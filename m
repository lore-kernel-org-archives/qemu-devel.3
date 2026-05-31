Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A37CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 15:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTiGS-0002lK-3i; Sun, 31 May 2026 11:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samyak.bambole07@gmail.com>)
 id 1wTiGQ-0002jy-Cs
 for qemu-devel@nongnu.org; Sun, 31 May 2026 11:39:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <samyak.bambole07@gmail.com>)
 id 1wTiGO-00075S-TY
 for qemu-devel@nongnu.org; Sun, 31 May 2026 11:39:46 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bf125989f2so20504695ad.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780241983; x=1780846783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eweo+AOP/LZy7+9wjmBN/ms5He+OgWhoGr43HaLs7OY=;
 b=ap5Qm2nPxvRypcMAp1KfltUW7VQIfpZYLCEQwGo79lmaaQxLJ97+f/bK/yOM0Es18r
 VweXY8wfcds/LRlIz7TSA0De3QX/9xAfAL2M4IyE+2SPILTypfdLyY537Rww471ZlHHZ
 s+ZX4Y4NL7i28CGH4GoucyI7nVv6q3uUyCDaWkCwewk9xWO87wG9zC1jjYwwIGgHcZGu
 NGc0apwrk9kHVL49YbO1Yx4QDk1GfjMlpQAD3iyBrBCpC+vRwZDFApBQslYl1k+jtCjJ
 xZxaothglyDwgNGNtg7X0q5Vpe/KvhfreOlUEPbU7q3qiMSbE2OhYxgdcaQX9sZ//EvL
 JrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780241983; x=1780846783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eweo+AOP/LZy7+9wjmBN/ms5He+OgWhoGr43HaLs7OY=;
 b=j767HWjobLrhXDCya76tkgVMJUCiqhP1o/i6lAEx1HhzTdwH1MBvlMCQIqjz7CDT4n
 0lXTEb598AXTpPQc2CE1K3FB3zpTdEDrrP3Mg5T0r+s1dqgi2sBpDS59wH7oNbZbzDa0
 aonUuP6M90PccaSaIIq06Gw4hB+f/lWC1NvObfyxbXFGoOCDpHObXziVkvIPMSmIl2on
 KGC/j1SLUlqLLB4ZpDkZYo5a/BLJd1VCDEqK4mN9Pz5G7IHY0WASTjmOPpEJFZMN1X0o
 BUwfkf6nApHDBsydzAHx1IbAA0/Seuh1M079/m44h4w6pCDI4kcMPHMaNghqJv+DEO+k
 jYhQ==
X-Gm-Message-State: AOJu0YzfDUi8bmRlZJhVShv9OM/LtJOKEI4VmFnhnHsQBY9+6nKbdQMV
 iwbOvQLOrBfTqKDU1uj/5S7ERoE7SHo1YSzMSTyNcsSQZ/JKm6r6GcUxW2LNFw==
X-Gm-Gg: Acq92OH+6iNEPVAIYyKaO4UJOu5+D2j/HAeWqCGwaMo80RRrYenyVQ1aK/pp4oytr5F
 p5m5A7gDqtvFfSLlWOd/8o9NnCfk3+Mv3/EShWgjmBfUfUifyhj+DeqiuPIbVQRDiRBj1P0Ood1
 wLtUXclHoDO0Hsm9tnXKq3D+MIUK3exD5GWhH47NkwMoMUcd497agNIgr+I5HsS+ecgiy7vgIfX
 sBHEO2H4+ERutIJxT2Zvi2VPtmPOD7xbZz44ZcnqT4P9Cj0sShwsxxknRmfdEV6UhNiuJ7W7rAp
 TTl9L3kmovtm7GZc+c8a1iTRXWAn+3oxFLCOYojfV0AB23NKlk7vEbRsH/1epwZULgDNoOq/XqK
 uJM4aZUAgTlLzRGZ+zrnOA2u2M9wuqrovYqcoCY+PnWrMozo4Ced6Xfuf3NXl4Br0p0ZeWz6nKF
 2DJ4S0uexvqmNDrX34sU+3PikLcVE6O5Pnm9osjPUvPP/k+6dlGFhMsAvbPUEO
X-Received: by 2002:a17:903:1a28:b0:2c0:b9a1:6493 with SMTP id
 d9443c01a7336-2c0b9a16ac9mr43368755ad.10.1780241983180; 
 Sun, 31 May 2026 08:39:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:88b1:bfce:96bb:43ff:fec0:e782])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf28973335sm74194235ad.63.2026.05.31.08.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 08:39:42 -0700 (PDT)
From: Samyak <samyak.bambole07@gmail.com>
To: qemu-devel@nongnu.org
Cc: Samyak <samyak.bambole07@gmail.com>
Subject: [PATCH v2] hw/misc/applesmc: replace DEVICE_NATIVE_ENDIAN with
 DEVICE_LITTLE_ENDIAN
Date: Sun, 31 May 2026 21:09:29 +0530
Message-ID: <20260531153929.286962-1-samyak.bambole07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531152210.264330-1-samyak.bambole07@gmail.com>
References: <20260531152210.264330-1-samyak.bambole07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=samyak.bambole07@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use explicit DEVICE_LITTLE_ENDIAN same as other devices in /hw/i386,
since the Apple SMC is x86 only.

This was flagged by scripts/checkpatch.pl

Signed-off-by: Samyak Bambole <samyak.bambole07@gmail.com>
---
v2: add missing Signed-off-by line

 hw/misc/applesmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f245..aae7fad3a2 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -278,7 +278,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
 static const MemoryRegionOps applesmc_data_io_ops = {
     .write = applesmc_io_data_write,
     .read = applesmc_io_data_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -288,7 +288,7 @@ static const MemoryRegionOps applesmc_data_io_ops = {
 static const MemoryRegionOps applesmc_cmd_io_ops = {
     .write = applesmc_io_cmd_write,
     .read = applesmc_io_cmd_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -298,7 +298,7 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
 static const MemoryRegionOps applesmc_err_io_ops = {
     .write = applesmc_io_err_write,
     .read = applesmc_io_err_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
-- 
2.54.0


