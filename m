Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3619DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNZ7-0003OB-6K; Tue, 06 Feb 2024 10:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rXNZ4-0003Nr-59
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:40:50 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rXNZ2-0000wa-CY
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:40:49 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-783045e88a6so384073085a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707234047; x=1707838847;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hLbg+SEBXldc/aM928IlX5UZSpp0lFtjrNh1hEw18hw=;
 b=XATGJ2Q5au0IZjtKL1YBb6d9P8fOIDgvRodeFBbzCQSuLT4hukienprLNuJZxam/TR
 N7/DlOgU4C7yXWzJPEvcHwX8Iqf8obMziFGFD9foYots/uGbn+rPQJdjTf/elVzKz+8U
 nFRWFp+SbBuU9WHw7hVKrqC4SKI233CIBZMgknI9aocJYUPbvXDtjKRorSyN0NkfcuFg
 OsV3uBsp78GsmPur2qRXWJdzPZ62/WFfmfnrCrvnZ1ysg4qnj5g2WIDrRD1iVkBBo0zC
 t+dYao2r+ZQF+0E1Petp0ItzqjwWrmYX/lvL0Rap2omueWuF92MKxFiepekmlFce3u66
 aYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707234047; x=1707838847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLbg+SEBXldc/aM928IlX5UZSpp0lFtjrNh1hEw18hw=;
 b=Swmeb/ohYCpvEKKbdnZrggm9+SIVyNEt9pJSBgAXFbibJl+nBAZ5iIbT+lVvzhzc6Z
 Aq6coxpd8GRXt7uZIqMKwEyIWaVogI4ObbdUAGgLsPTISTgFRLAyqyXThLVaZLV6DnVP
 f9NUBiax6dGDYyBqbrEDdZthjS03neD+JvhBfCbz0KM1RMoqP67G8Rik5k9YVdn0PJmt
 6KWUQjoOBztjzGrdYeNc4O1BcPF3SmG34V68RMvWl1f77vxnmbsrQDvm74VP5YJYlyZ1
 tBTT7WGWQ80Af9UCI/SFywyP6HfRoF7E3SWX1lWM3ljaw7E3ka4mIPCr8Cf+zlRTpu66
 a25Q==
X-Gm-Message-State: AOJu0YzUqq72JH4QnHINKvABvU4VzXdI08N3quR8YgijvWmtT0d2+UQ1
 LL34NUSsamWMZ4r2FapWk2N5Kr8gYze8wxr7YxhzMGm5mom2Q2PdxYUVg/SD8r8=
X-Google-Smtp-Source: AGHT+IGI+EFmfb9CyK33aqTkOXtXjLRcG8Zutmqjv9tQ3kvgCqBcPphV04XvPCN2DxRNNQ+QyNDjWg==
X-Received: by 2002:a05:620a:4550:b0:783:d83b:f588 with SMTP id
 u16-20020a05620a455000b00783d83bf588mr4023642qkp.17.1707234046953; 
 Tue, 06 Feb 2024 07:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUjcqmQvqXFp/Ti14xA9qhvhu/iwP4t90OjzoCcR92GLqBjMl2zHYsbozbvvELtRNhpb5D9h91XtvahO55ZIVB9fCS31YZCp6qUoorJZFW7pwHYnHl8XoQjpCCRFZ18WinNmzLIoOo1C2Ymaby9dlRCSG6lGNx1VXHkd+O5B4zVDBA9CRh82HiFQ0qklKym/0ZDftClRO6FH3difuw79fchjKg/rvhHGeUMQSB03O4VHtvpHdgh+1iWi9wcDPSTquuQDmYDdZ7w3YcSLdtSWN+2y5g4/g66nJcmMRtw
Received: from alex-rivos.ba.rivosinc.com
 (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a05620a095900b0078445f63dc4sm994875qkw.60.2024.02.06.07.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 07:40:46 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] hw: riscv: Allow large kernels to boot by moving the
 initrd further away in RAM
Date: Tue,  6 Feb 2024 16:40:42 +0100
Message-Id: <20240206154042.514698-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=alexghiti@rivosinc.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the initrd is placed at 128MB, which overlaps with the kernel
when it is large (for example syzbot kernels are). From the kernel side,
there is no reason we could not push the initrd further away in memory
to accommodate large kernels, so move the initrd at 512MB when possible.

The ideal solution would have been to place the initrd based on the
kernel size but we actually can't since the bss size is not known when
the image is loaded by load_image_targphys_as() and the initrd would
then overlap with this section.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v2:
- Fix typos in commit log (Daniel) and title
- Added to the commit log why using the kernel size does not work
  (Daniel)

 hw/riscv/boot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189..9a367af2fa 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
      * kernel is uncompressed it will not clobber the initrd. However
      * on boards without much RAM we must ensure that we still leave
      * enough room for a decent sized initrd, and on boards with large
-     * amounts of RAM we must avoid the initrd being so far up in RAM
-     * that it is outside lowmem and inaccessible to the kernel.
-     * So for boards with less  than 256MB of RAM we put the initrd
-     * halfway into RAM, and for boards with 256MB of RAM or more we put
-     * the initrd at 128MB.
+     * amounts of RAM, we put the initrd at 512MB to allow large kernels
+     * to boot.
+     * So for boards with less than 1GB of RAM we put the initrd
+     * halfway into RAM, and for boards with 1GB of RAM or more we put
+     * the initrd at 512MB.
      */
-    start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
+    start = kernel_entry + MIN(mem_size / 2, 512 * MiB);
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size == -1) {
-- 
2.39.2


