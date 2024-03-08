Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1C3C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9Q-0006aV-PW; Fri, 08 Mar 2024 06:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9P-0006a5-4X
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:31 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9C-0001Pd-J1
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dcc7f4717fso5832955ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896337; x=1710501137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qqg70NONw8dBt9M4IalaPWJdi2Dhn3suW2dRWllcI8Q=;
 b=eac2WNxeDFALz4tXfpIciSAQQTRG/Nh78wi8g0RRig7Lng9iuSzpctVzu3+wShfZDR
 5kB+Rg3iKy9p320jI2hOjhJKMc41W16gMtENrwMFmws5qJtpueg9cAB/jz4XydepDT4O
 qm4OQ/Mt2dqeq5wkcaOev6LDPsLndYSYOPBpU36IjNT1IUyMISWavcaflr9eIfco3Nm1
 trWeb2Z68WqrFI2RVTv0N44JOnNl0dC5vVVdILrBgXHCtQM3OlIyWIP4fhb/eundNbm/
 VGtwbaR/UlkKZKAOT2ad7NAKLdQTQxg8/BY2DCZm0bkmSgNvLp9zoXn/7YQDFaeaxFwc
 e8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896337; x=1710501137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qqg70NONw8dBt9M4IalaPWJdi2Dhn3suW2dRWllcI8Q=;
 b=B1SuBpBBliozliHfGK+NlckL3ykJEEx/Dj9YcSWdrGEH1z4/fkTOkOW8bECUP6lsuC
 fUlDv/f6iNJusSp8ZWLJp8GlnO1OqXKfwzxHpDFu/WKpm+BWc6g17q6hcwPVh7yfvltk
 QxKljvVESsDDUNh5sJnShF3gLJdBgJK1VaJNYiYc18npZuaNxqC5lo0PBIbiAp5QPv5a
 Z14whRG97kjS/pDpuFEqWWkfCqr0TKb3fBRdum/GcDSd2FRaEAcmH2mZMTcfUNrBFSnh
 Ih3eGxtVMgNb7xYwwBnP8Vs0C1JPEo1XhCmr6SXHN53fHulF0t3VuTO73qAPW/PdlwYx
 IBVw==
X-Gm-Message-State: AOJu0Yw5qdHoDCzw3S40ypgKgrpHx2KYl6RkYFVlNmdbBWBPf0ly3+U5
 vINp/zBwaaHmaVGdOTTvJskABZplmpNX3A26Aqn+MnLRSlgS+qExe2LcfaabAZHdGw==
X-Google-Smtp-Source: AGHT+IFFwacdP08HEDItHphrKPST9QsAJIQznc6Beg5mWI0VMN2hMTyf6f392TWyoxooR7Of/pqyZQ==
X-Received: by 2002:a17:902:e843:b0:1d9:a14c:eeb0 with SMTP id
 t3-20020a170902e84300b001d9a14ceeb0mr13777029plg.43.1709896336987; 
 Fri, 08 Mar 2024 03:12:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 04/34] hw: riscv: Allow large kernels to boot by moving the
 initrd further away in RAM
Date: Fri,  8 Mar 2024 21:11:22 +1000
Message-ID: <20240308111152.2856137-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

Currently, the initrd is placed at 128MB, which overlaps with the kernel
when it is large (for example syzbot kernels are). From the kernel side,
there is no reason we could not push the initrd further away in memory
to accommodate large kernels, so move the initrd at 512MB when possible.

The ideal solution would have been to place the initrd based on the
kernel size but we actually can't since the bss size is not known when
the image is loaded by load_image_targphys_as() and the initrd would
then overlap with this section.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240206154042.514698-1-alexghiti@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 12f9792245..09878e722c 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -189,13 +189,13 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
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
2.44.0


