Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BF606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=krum-com-ar.20260707.gappssmtp.com header.i=@krum-com-ar.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jPa106ok
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSZhD-0000ok-2g; Sun, 15 Nov 2026 07:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <federico@krum.com.ar>)
 id 1xSWy1-0002Q6-M0
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 04:56:09 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <federico@krum.com.ar>)
 id 1xSWxz-0007LH-VV
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 04:56:09 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-862b273ed58so70399a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 01:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794736566; cv=none;
 d=google.com; s=arc-20260327;
 b=OQrh08OiHJItYYiQUt4A/8jLOJjqfreAcexh8cbjuQzH4yj1qBe812iaNa4PZqmYVI
 VaKCT8GX+BKc2R6It/81LMAHA+pbbO8QdiCLk8t+rWJFOgyxlg7Eqa3ZEZWBhWrgfxeC
 M1jw4qol2mPmy7rn6btZEp4DWpHtGNn07VyeBP0ZmRQFtzlOgZRdYxeCkSGSiwka4DJO
 BXNA6BFGS0MNZ4EnlUFaAiLaX3Gy+9/vos1DbNaqMoDjDDeoTYTCjPQ8MWhBsKvejj+G
 14oXypJ0SmwuqnXxHKYQ0H4PqbsHwUxE3mk8XVKMEUEZYNNM4/kDov8qe4KnRZu9lMn8
 glyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=YhkIf3n3wfA78DxNxyjOLPpfwJXYvAwA2cCOL5DLqtg=;
 fh=LjmFQJgVelyhfnky7EyCJEpDOLP7QPW6PlE6Pj4hjIo=;
 b=oA6O6wNJfvVVbnT+VMMAmpw/mS6ilNUKutXbsibuYDZvjb2iIvlulUAzv/DomrrVUr
 +T+WmYcpM6l0N3pCRSEh0QlfrRJxXrwVaL2sjMLWXynw/RSIkoBYDinCMhjYHi5Cei8x
 EE33qOvGPvadmRi4nRhulJHjWQiHuoBo2kE7pUGfT7C+qkGoGVeFNR/EgKXjTdqFLwzW
 a3udexErfLEIMQDmth9SYv7EUezrpCNkJHqLFp15HfT69D4T3PeIkIpWA/kJk/8kvIFl
 zckuRXiWfMLoUKVDdeo6C5OL5nMvrQd+ymNIf0MaTimKhbq5iqwWxMuUEx8lyzOKA0hV
 po2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=krum-com-ar.20260707.gappssmtp.com; s=20260707; t=1794736566; x=1795341366;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YhkIf3n3wfA78DxNxyjOLPpfwJXYvAwA2cCOL5DLqtg=;
 b=jPa106ok1hmVlNhQS6l2MFljX1mseSLT9nwhANF2l/P+fYE1y2Q/QOdczsDJYZIQqI
 Q0gEWEJ9CZfkv+2y1sLlkvfLxs8gBdmNEUtg1tODpuPVObm7bA08iOen+BQg6vqJwK6d
 FC04ovXwkQhwrVMAfsQMPNxWS+6v3uXiDdhDof8qNP7fYb3wTbL/XAolyKqYhO75tVsR
 J3JgsAeCHqPO6ZCCB6E0WRD2IshrCj40ssd8Pbg1b1kAlQTPUxrbl4iGn1EfNjl4wLyR
 8jAKq6xnpmdmd/B+e8LdXvXXv3mIYoZWIGizz4ICa80LgayX5ovtsU2tGQkBxNmPWIK/
 m/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794736566; x=1795341366;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YhkIf3n3wfA78DxNxyjOLPpfwJXYvAwA2cCOL5DLqtg=;
 b=nzzUVtlHroR0YpnWbnUwRruI+zn0aWu5P6EbySPcn50ypJcdC6thRYHljzl5hcudIM
 OCYaWHqg8YCYpaBE2pua8LrSqo/Sfk15R2a7et80Cm/T1oMqhb55NeBJ1H32OY5JImNC
 GZelue4XP56xBqdWwwr5r+JN1h4yAJyXsnDNIUPU/ix8ZFUD2RqxsPzd1ciB75auow4d
 wKLzi9wQHAqPuo13PIYSyzJj7wRXrW3iI9E6CfefQzPXDPtkK2hLRR+d/p1+gSvXxG5U
 iRNRCI3an2gyRN+0W4zq0xjooCh/P9CE5FlLtmupkLbzRR16z3Vq0yc++fz+UJow2GnO
 U2Aw==
X-Gm-Message-State: APuU4Z9ohBXgiISd+fZS0jfYiFb9MZVwOr1zaYa+ChftKVuiZO6I2Oeu
 lTaFxhBsILYq8HbOoRffV/bXg0UarSTCaiskUn4PFgATAXIMK5sNi2zuGv3I9PBAKe3qMFHZQhi
 qgF9w1C6D0f3zS+8/7tcd5DGU6ga63B67dEx3DjPM5RNAQ4TOb6MBnlXyQSs=
X-Gm-Gg: AYBFou1oRiDsDLXq4JIpttKnj/5+tnQFz7c+vc2j/hw1MFw/rOyyw8vpK+PZm1qwGSB
 SlaRFSyFpGS3sRAbZkBga2rX9LXZ4bMP5JCkToKEdcJ+2MPnpXOzGvVykXeHrIA7TzEHCbCPMEE
 +Six8rHEeQ9ALuwl7M4r7HNu39Rf40jJ1hTgZ+JNYTYXzysFS1LH0YcRlhomc+hX9WbHenm23Y7
 2IfHBfF8p8iYqM612kx5Sp7xpvdFYtLp5/pYQJ2hUv6gUaYdyWR7rFpHwos1nszBNawboBuxEAd
 ZfPUKVUXdAvlpF2Xtk2bLD20FQoVyBZI2rsvKiVAfPbNeEHgoue+kkEoUyf4dEMld8kyxM7Gg3Q
 wuYtbn2A7LmIbw88YYrz3T49P9/xHvFVI8lLqm7aroF3vUnFluVL2v1VbSISiDtzNHnKLRUSLWn
 iDLirRDgg=
X-Received: by 2002:a05:6830:6e13:b0:862:abdf:7712 with SMTP id
 46e09a7af769-862abdf8be4mr3115073a34.0.1794736565893; Sun, 15 Nov 2026
 01:56:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Federico Krum <federico@krum.com.ar>
Date: Sun, 15 Nov 2026 10:55:54 +0100
X-Gm-Features: AclHuK_If72qxVMyytYslkGkVmIkEFsKbC1g8OqFxKuc9x5AFu6GvzZzebXcZx4
Message-ID: <CAOveVYyOPSopzt35PZZ57Yk7rLJ6Q7QQus7xFdNgG5WyssKLHg@mail.gmail.com>
Subject: [PATCH] hw/nvram: add the Mac OS 9 "APL,MacOS75" PRAM partition
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=federico@krum.com.ar; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Nov 2026 07:50:49 -0500
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

