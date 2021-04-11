//
//  PackageUtil.swift
//  mobnius
//
//  Created by Александр Краснов on 11.04.2021.
//

import Foundation

public class Reader {

    public static func readSize(bytes: [UInt8]) -> MetaSize {
        let count = MetaSize.MAX_LENGTH + 1
        let metBuf: [UInt8] = Array(bytes[..<count])
        let str = String(bytes: metBuf, encoding: .utf8)!
        
        let type = str.substring(to: 3)
        let status = Int.init(str.substring(from: MetaSize.MAX_LENGTH))!
        let sizeStr = Int(str.substring(with: 3..<MetaSize.MAX_LENGTH).replacingOccurrences(of: ".", with: ""))!
        
        return MetaSize(metaSize: sizeStr, status: MetaSize.Status(rawValue: status)!, type: type)
    }

    /*public static MetaPackage readMeta(byte[] bytes, boolean zip) throws Exception {
        return new Gson().fromJson(getString(Arrays.copyOfRange(bytes, 16, readSize(bytes).metaSize + 16), zip), MetaPackage.class);
    }

    public static List<StringMapItem> readMap(byte[] bytes, boolean zip) throws Exception {
        MetaSize metaSize = readSize(bytes);
        MetaPackage aPackage = readMeta(bytes, zip);
        int start = metaSize.metaSize + 16;
        return Arrays.asList(new Gson().fromJson(getString(Arrays.copyOfRange(bytes, start, aPackage.stringSize + start), zip), StringMapItem[].class));
    }

    public static RPCItem readMapItem(byte[] bytes, int idx, boolean zip) throws Exception {
        List<StringMapItem> mapItems = readMap(bytes, zip);
        int start = readSize(bytes).metaSize + 16 + readMeta(bytes, zip).stringSize;
        for (int i = 0; i < idx; i++) {
            start += mapItems.get(i).length;
        }
        return new Gson().fromJson(getString(Arrays.copyOfRange(bytes, start, mapItems.get(idx).length + start), zip), RPCItem.class);
    }

    public static RPCResult[] readMapItemResult(byte[] bytes, int idx, boolean zip) throws Exception {
        List<StringMapItem> mapItems = readMap(bytes, zip);
        int start = readSize(bytes).metaSize + 16 + readMeta(bytes, zip).stringSize;
        for (int i = 0; i < idx; i++) {
            start += mapItems.get(i).length;
        }
        return RPCResult.createInstanceByGson(getString(Arrays.copyOfRange(bytes, start, mapItems.get(idx).length + start), zip));
    }

    public static BinaryBlock readBinaryBlock(byte[] bytes, boolean zip) throws Exception {
        MetaSize metaSize = readSize(bytes);
        MetaPackage aPackage = readMeta(bytes, zip);
        int start = metaSize.metaSize + 16 + aPackage.stringSize + aPackage.bufferBlockToLength + aPackage.bufferBlockFromLength;
        int end = aPackage.binarySize + start;
        BinaryBlock binaryBlock = new BinaryBlock();
        if (start == end) {
            return binaryBlock;
        }
        byte[] temp = Arrays.copyOfRange(bytes, start, end);
        int idx = 0;
        for (MetaAttachment attachment : aPackage.attachments) {
            byte[] t = new byte[attachment.size];
            System.arraycopy(temp, idx, t, 0, attachment.size);
            idx += attachment.size;
            binaryBlock.add(attachment.name, attachment.key, t);
        }
        return binaryBlock;
    }

    public static byte[] updateStatus(byte[] bytes, int status) throws Exception {
        if (bytes.length >= 16) {
            bytes[15] = String.valueOf(status).getBytes()[0];
            return bytes;
        }
        throw new Exception("Длина пакета меньше 16");
    }

    public static String getString(byte[] temp, boolean zip) {
        if (!zip) {
            return new String(temp);
        }
        try {
            byte[] zipBytes = ZipManager.decompress(temp);
            if (zipBytes != null) {
                return new String(zipBytes);
            }
            return new String(temp);
        } catch (IOException | DataFormatException e) {
            Logger.error("Ошибка распаковки строкового блока.", e);
            return new String(temp);
        }
    }*/
}
