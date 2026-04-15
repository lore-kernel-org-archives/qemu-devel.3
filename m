Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C55CFA0C35
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCu3b-0001LK-U2; Wed, 15 Apr 2026 02:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3U-0001Je-93
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:48:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3S-0001gX-QF
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:48:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso20065275ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776235733; x=1776840533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxPGaHE4PCoGhoZp84fsTDqeNnYG1t2SMlGq1B2LOqo=;
 b=nAqUKf4Q1jI7cpgH0LDvFtGcTjYxYlslJm8Qi+GDRhBYsRGoQYDqOOMHIhw1aV7akL
 PPC7VLenP3q3v7F8LxRhWiohoW4ulnZ1dcc3Y1n8X8+9Xqcz57ayrdalOUQ6o32xmfNM
 6WmcS2+q/d3E8IMU2bthQ7FHgtSn9EK2w47YvpEbKlqP+xV69HR4r+E5jmbVAE3DBhBo
 PvNfOewECB2OVeryyP3Wlx2vi8U0H+3IXzoG0rcotytiSi+7mr/cynEv0tJYP5Td6dzu
 fOdric7F9vmA3YEYeOYeu8trBooR/el/MfwQpNJejwvTfbkSUDNhfoWT/d9pTIUL0Rns
 +SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235733; x=1776840533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nxPGaHE4PCoGhoZp84fsTDqeNnYG1t2SMlGq1B2LOqo=;
 b=EAyV9PsZLHGlUpkyMnhutgJePbQ2GYtde02amueuAFjjodUptZvf2eJ4watElqN6XF
 cLAzz+ld8/BudViaqq2pFhpfPUf+vq1W8BPKS5T5ghaf2qI8b1sFXQa5r4UpPGR8Aixt
 HLPSP0ZQqr59MMlt9/TgfA+31T+ue3GDDccspDMp9KEoPTQQk7nRPBzBYPBi5Rd+y9QA
 3DWXPa7EOZpkxiM6pbGdZUwGCGeTnSRYVsMOVbN0VlwZM9Mnfgi/alu8owcyrZgGmQXD
 WmmtzqYXFAUTtfnghi9P7iOig/RZoRD0m8J6Y48qs2PpR1Uo2EeUHB3kcO75VS3asB/l
 GV8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UF0lJ8pTaH6lCWegdYAgUJaT6M1aErwWGhdQMuJJNPP4TTBGPQLMtp3JbuqXtImzvKjVrcZmnPKXU@nongnu.org
X-Gm-Message-State: AOJu0Yy0KBvUAgMXy9m66eDHutaaRJCmkNrDSHep6I6Kp7JC+Mvb9FEK
 OKhxFnaAx3ovHs9gOTj2U1RIbyvL6dnROje4kholKyOCBsgFrGaLbnKf
X-Gm-Gg: AeBDieuzptvbBLsoAu6+Qt7VbnYcZnrwJrotGoA/OdpyZ+u0tFWeJZ2GuJLRzQgE+tX
 +0kP1RpoycasZNDZGrnr4MFV9tfTfb4+abLOebSuc7h3VF85yshIa9Sk7xKm7gPRFRFSrolYFdv
 W7rurjwMkiDxKkT0hqMox3nHcRbdtIBqLVpOx8wAyNJ/TH9Eq+zBX5Te3y+r40UKHmMiLPDx3L1
 WHuVEixC6ILLJhXQX0LwmugAOeqF/fLisXalKdnlN45Hh4rvinPpImdtW7HtvXZEMqFfy8XdXgE
 jsLMhJwF/+J0Hr762oNx5Jk96rKTvG8r3oS78r7SQAXSdd/zQxBYoZtBj49YgQOqES5NMOSDiIc
 Nx5i/1/R66wDp4bJbGApmtWIUh7L98vOniFkPHZpXgxQqNYbAKo31B5rvTBe3zjSiCkm9QcDrvs
 NITQzocaCN32DpRcN5YDwJeVV6VbkKV9o1R4eoLjI1KUgPHJF4bDEx0RUZ9c0BiyGhPdFvxvM81
 FtjVem5jrcNwIE4G9KuOg==
X-Received: by 2002:a17:902:d583:b0:2b4:689a:e420 with SMTP id
 d9443c01a7336-2b4689ae791mr74305565ad.8.1776235733289; 
 Tue, 14 Apr 2026 23:48:53 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478142565sm10353195ad.37.2026.04.14.23.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:48:52 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 1/4] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Wed, 15 Apr 2026 16:48:33 +1000
Message-ID: <20260415064838.652297-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415064838.652297-1-joel@jms.id.au>
References: <20260415064838.652297-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Machines that have discontiguous memory may need to adjust where
firmware and images are loaded at boot. Provide an interfaces for
machines to describe a discontiguous low/high RAM scheme for this
purpose.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  7 +++++++
 hw/riscv/boot.c         | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca12245..115e3222174f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -28,6 +28,10 @@
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
 typedef struct RISCVBootInfo {
+    /* First contiguous RAM region. If size is zero then assume entire RAM */
+    hwaddr ram_low_start;
+    hwaddr ram_low_size;
+
     ssize_t kernel_size;
     hwaddr image_low_addr;
     hwaddr image_high_addr;
@@ -43,6 +47,9 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr start, hwaddr size);
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda007..9babb85b0458 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -69,11 +69,22 @@ char *riscv_plic_hart_config_string(int hart_count)
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
+    info->ram_low_start = 0;
+    info->ram_low_size = 0;
     info->kernel_size = 0;
     info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr start, hwaddr size)
+{
+    riscv_boot_info_init(info, harts);
+    info->ram_low_start = start;
+    info->ram_low_size = size;
+}
+
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
-- 
2.47.3


