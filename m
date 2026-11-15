Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7F606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krum-com-ar.20260707.gappssmtp.com header.i=@krum-com-ar.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MMElX+3k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSZh8-0000o8-0j; Sun, 15 Nov 2026 07:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <federico@krum.com.ar>)
 id 1xSWv9-0000YA-Q2
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 04:53:11 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <federico@krum.com.ar>)
 id 1xSWv7-0002ST-IP
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 04:53:11 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7f4dda21facso289844a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 01:53:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794736387; cv=none;
 d=google.com; s=arc-20260327;
 b=BkU5/MJv4DlEJZvPMHnfQRkcAGGCviID6ERtSqun7q2IIOUQlbtHNu3XZNzXWTUBnZ
 CjFxNN+yvHGC1byPB/91VKUjvDtFyte8BM1OgpjReL6pxaVaYWeltQ1iXfjimZdxQjIA
 7kGJOgbQ/j+cJe4/1iSZhbvxKVMe/YZoYwQtVoxdauXBXr6zOtK7DYucOwb06f40IQg3
 V82TuIcVlXShRGf7bBg/w/CwIRpHivURreDpx9qi6LTP9Mv53Wkorn4DzfIc47fr3PYL
 o+i2NRJoKaicvRAjy8ZBg1FCp02S3eePLkU4Ato3eM6/BJpfG+lVdE2TSpE2oJQbTX75
 SKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=YhkIf3n3wfA78DxNxyjOLPpfwJXYvAwA2cCOL5DLqtg=;
 fh=LjmFQJgVelyhfnky7EyCJEpDOLP7QPW6PlE6Pj4hjIo=;
 b=WH6sSJdidcF6dBo6y8vVkTaARSmE+uIH4rTfOsXzvTa721pI7B5Zmpjr/dMpa/5jZe
 qWBqPCJhwyZhrLJPu+StciwLNPbGbPBIDC9GIk0rIAL0x0S311hEalGm/EDyNrW7Qn9D
 DtBaVIlEfeo8mRsLvRuQ95W4xeTll4AusaAnOBW/VWEHafby7Zp3NGQ6KylDElXarsig
 WRxHtZFS3VSQ3BVZtF0RKQsM/wwDo7jepARcaerxsstdGh7V3JQ0G+p7v/OAfbgSkvRs
 I3Wgfv00yDyei9ErNaSxiOtUa6fQsSdiKD9XJCAHtWBVOYbwNi9CKbNhtuJCFeI5MF83
 4i+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=krum-com-ar.20260707.gappssmtp.com; s=20260707; t=1794736387; x=1795341187;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YhkIf3n3wfA78DxNxyjOLPpfwJXYvAwA2cCOL5DLqtg=;
 b=MMElX+3kBTP+omyzvqvBIhLzFNUaipVo+OUXX2NAKOSfhUK9d6swKgi7QPKasbnx4f
 tIo9ZBlC9sRKhkD6a3QJ0KOTISHyMYNupR2jicYBFlmdwrnl7c5pyyYpTuxXo8D+77JN
 tpFfOCM/fol6q2KeC6TGBy1jfJ0yMbyVsQf8ITPsy6PxTKJySR8Kqn2oLEjhA6Jsn7mL
 u5HZFbSwlkhF7B2GZ8EY/DTz3m4ftjUwRsO4RVrq2soK4q+1xlMf06c1gq5wrSNkEHCk
 PGLFq8EgBvBCDRSEGgG/AflVTvqvAcYCRZGzkiHJ7cswAkh+eHnvCX2opDI1K5R6NQYj
 xWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794736387; x=1795341187;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YhkIf3n3wfA78DxNxyjOLPpfwJXYvAwA2cCOL5DLqtg=;
 b=JFkENuXubdM00rKKJ+qzNiyMd1TEeEHKIVB/iI168G4/0RqSse7WWEBeAYXXdMlNjc
 Y8EmyDirdoIZFro9xHFNDSjtjTx2/mWtPKI1KvMOITyp6QJCd/uQR/tulRL4OgP2a5mT
 Koj17s9lFcVWeE18lQbvmfs6RHtVgegajsd+zfsoZXr5BNpyulRNd7J4ET6N0ks6U4gF
 5e6irl63cBrR04YPX3O8Hxicl/ws0hkoxBjxPECXyzwHoh9p9Ze/fx3ULyv+TnxQfQRT
 me3ZiBhK1FqmlAIqZoME//dGJVb7LoCEnnmjyvWAyWynA718UORs9mpG+tvnui/RhzTC
 d3lg==
X-Gm-Message-State: APuU4Z/lbhlRaGg9i9GpEhJolnWEINeHbkyrQ50nGvl2J3IEmSUzlxF4
 1QN7odfA1p+cuwE/AKkOtTOByR+N7vGY0S0X8D4kcnhrHB6Z/lLdFzoqFSgilsSlwCCyZPcMhBN
 itRhoAVGBNGqL+e0fTV8ZMGXJpBZIQbvWnZExhmIU/ErRKONOwtsyWX9ZXEw=
X-Gm-Gg: AYBFou1Wu9AqFjm0XydsulSoN6UEmCZAPO20Y9MDarHqz2R0IX8R4+F1wwfbmbhCMyL
 y+I7P901rujJdJIGy+DjcHjmPX4O0iwwGNXyo2BsNzSiwfpYIELPgLN0g80RCr/xodijGM6RUbx
 OHDIvS2x8TPnU/iwL09iX0s4vryNP+rGa8a/zSmfEST8joUKh3RsoFdJzrJE/AaQGk3ql3r0Xw+
 rf/G+WxzZJl1kbBVKRd7ecNO2rM3YM/UJjBkfqfmwTO2z+eo4/2mQqAguB3YgOCHjg995gVrvPa
 RQl2aNVrKU+SbXmFxOWfcBebAGTKmnYuJzLfMk2p9mq/oldVmMYSawWLYbXmtDKwKj0A8gATVEk
 yLIsZjDmjGPUD1Aze+d5uoTGJ/vw1OpnE8l7sOrD+RFLmvuJcV5BrIY9r4Os1b5hy0ktv4pEEfm
 oroTe4LYao0PH/19kKum5CDY+WU1QT
X-Received: by 2002:a05:6830:4507:b0:845:8d86:9f71 with SMTP id
 46e09a7af769-86289852079mr6120494a34.3.1794736387243; Sun, 15 Nov 2026
 01:53:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Federico Krum <federico@krum.com.ar>
Date: Sun, 15 Nov 2026 10:52:56 +0100
X-Gm-Features: AclHuK_q8Il0n_pmpviAUY9IjNU0Z5_i9a1284_vE4tJJoLeH_wAOAIzcqvUYF4
Message-ID: <CAOveVYyXZ7jXOfgGi4=bq4sde8XZYZYCvJNTmgfxGcwFv5q22A@mail.gmail.com>
Subject: [PATCH] hw/nvram: add the Mac OS 9 "APL,MacOS75" PRAM partition
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=federico@krum.com.ar; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Nov 2026 07:50:47 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mac OS 9 looks for a CHRP NVRAM partition with signature 0xa0 named
"APL,MacOS75" to store its PRAM and name registry.
pmac_format_nvram_partition() only creates the OpenBIOS "common" partition
and the Mac OS X one, so every boot prints

  MacOS: unable to find a usable NVRAM partition - using offset 0x1400.

and the guest then keeps PRAM at offset 0x1400, which is inside the
partition reserved for Mac OS X.

Fill the free area left between both partitions with the Mac OS 9 partition
instead of a free space one, and keep the previous behaviour when that area
is too small (for example with many -prom-env variables). Only the 16 byte
CHRP header is written on each boot, so the PRAM contents survive as long as
the NVRAM has a backing store.

Tested with Mac OS 9.2.2 on the mac99 machine: the warning is gone and the
guest boots and runs normally.

Signed-off-by: Federico Krum <federico@krum.com.ar>
---
Note: written with the help of an AI assistant; the change was reviewed,
built and tested by me with Mac OS 9.2.2 on mac99.

 hw/nvram/mac_nvram.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index efadb3c..adca155 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -164,18 +164,31 @@ static void macio_nvram_register_types(void)
     type_register_static(&macio_nvram_type_info);
 }

-/* Set up a system OpenBIOS NVRAM partition */
-static void pmac_format_nvram_partition_of(MacIONVRAMState *nvr, int off,
-                                           int len)
+/* Set up a system OpenBIOS NVRAM partition, return the offset past it */
+static int pmac_format_nvram_partition_of(MacIONVRAMState *nvr, int off,
+                                          int len)
 {
-    int sysp_end;
-
     /* OpenBIOS nvram variables partition */
-    sysp_end = chrp_nvram_create_system_partition(&nvr->data[off],
-                                                  DEF_SYSTEM_SIZE, len) + off;
+    return chrp_nvram_create_system_partition(&nvr->data[off],
+                                              DEF_SYSTEM_SIZE, len) + off;
+}

-    /* Free space partition */
-    chrp_nvram_create_free_partition(&nvr->data[sysp_end], len - sysp_end);
+/*
+ * Mac OS 9 looks for a CHRP "APL,MacOS75" partition to keep its PRAM
+ * (0x100 bytes right after the 0x10 byte header) and name registry.
+ */
+#define MACOS_NVRAM_SIGNATURE   (0xA0)
+#define MACOS_NVRAM_MIN_SIZE    (0x110)
+
+static void pmac_format_nvram_partition_macos(MacIONVRAMState *nvr, int off,
+                                              int len)
+{
+    ChrpNvramPartHdr *part_header = (ChrpNvramPartHdr *)&nvr->data[off];
+
+    part_header->signature = MACOS_NVRAM_SIGNATURE;
+    pstrcpy(part_header->name, sizeof(part_header->name), "APL,MacOS75");
+
+    chrp_nvram_finish_partition(part_header, len);
+}

 #define OSX_NVRAM_SIGNATURE     (0x5A)
@@ -205,12 +218,22 @@ static void
pmac_format_nvram_partition_osx(MacIONVRAMState *nvr, int off,
 /* Set up NVRAM with OF and OSX partitions */
 void pmac_format_nvram_partition(MacIONVRAMState *nvr, int len)
 {
+    int sysp_end, hole;
+
     /*
      * Mac OS X expects side "B" of the flash at the second half of NVRAM,
      * so we use half of the chip for OF and the other half for a free OSX
      * partition.
      */
-    pmac_format_nvram_partition_of(nvr, 0, len / 2);
+    sysp_end = pmac_format_nvram_partition_of(nvr, 0, len / 2);
+    hole = len / 2 - sysp_end;
+    if (hole >= MACOS_NVRAM_MIN_SIZE) {
+        /* Mac OS 9 PRAM partition, keeps the previous PRAM contents */
+        pmac_format_nvram_partition_macos(nvr, sysp_end, hole);
+    } else if (hole > 0) {
+        /* Free space partition */
+        chrp_nvram_create_free_partition(&nvr->data[sysp_end], hole);
+    }
     pmac_format_nvram_partition_osx(nvr, len / 2, len / 2);
 }
 type_init(macio_nvram_register_types)
-- 
2.56.0

