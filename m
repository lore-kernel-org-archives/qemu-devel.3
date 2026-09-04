Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6563C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLd-0005aY-M7; Fri, 04 Sep 2026 01:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLX-0005TT-BH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:15 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLU-0001Fn-SF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8568e3ecfc3so414932b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499211; x=1789104011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LTX0PH11b1czHfXHTberS5ToFxks3tVZpJW98VUZspU=;
 b=bncnfXhE+BUnwyOVieLZLgjh502mN55rD1cB6eWsexB6jS1mGFncuAIYKxoKBOFpTZ
 9AHvB+oAEwsd9ZX8XWvTpC41YaP6cQ3FyHZA8dF8KIjhd65KuaTs1qN7ig5aOwdo6J+Z
 hSCafGw3yuaCtz/OD59pZEIsPMAx3YOgYSVmmSnnsFzlwdkfd1kf4J9fF3YYvobff5Hd
 a2tstqs+HmsdnHHCrKsDsw2uhZWA2GPMIiCMTMFfuD+/L7Ok7jwCIFAGckBOpe2pTHCp
 m9FlPwxeodvFoyXDzq+4JcImz3JiMuzRAivREsIkYY+tcbFgYLVdx/5nAgUqZl3Jt0r4
 eFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499211; x=1789104011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LTX0PH11b1czHfXHTberS5ToFxks3tVZpJW98VUZspU=;
 b=jJ2Tynd/3kmSPmrpawxeZzhFpT3es0ADjLjfy+zY0mERoenG1U2O+YAR43csvh+SE8
 OpVEvgJDsiaFe9XfH7F/5shm3/0zw3Gxcm22fUwbMYA28nWQ9C45h9e67HIV+sWxqZCy
 Cy42Fz9u9sN7KsuZnlszcq3u0ov2agKr8ud4enVKFFcnwTNPzBBsesA3H54/ObqjX++X
 X3kf5sq2Ff6Avd+isGFzBw7Dy4tiTkZYOSXGwukpgC1+G0V8lKxIE/T9fa5CTqfJj+kT
 V2LNehz7Z2oSEYQybnkMJR3oJGtr7UL5SzJ14BJ3SiegAf5rS7S+VvJJo8cLUS+cpq1y
 L9FQ==
X-Gm-Message-State: AFuF++niEau3nWS/E3U+nFtDuzvgyTPE5DH32zVHDKEITZvQ410NLrlP
 KQvfVbZVjuKEt1VeAFXPCf0xuDma37y8zHbKuxsYdDejUR+yQzKwxwsByLloWw==
X-Gm-Gg: AYBFou07f1icpXIvUCo8ZgRNzlv9EZckzatEKBCyUmHLOu/cN0J3HLk29nPhCKeHW/o
 ZXST/k2bfyNvmbCWAmSwbohO4tDdhoM1ivU0svjiwAeQ/nHWDQUxIfYoTGM1dwXM+Kare+zFUdC
 xa9M0iRvF++0CALSjTmQY03JX1gqsGad4ESA813YIapBjTvbnBni/G3sxHUzvKCDoCwXAA2h8cQ
 AXhnnNcjAZAp5V2L2dr3e8WwZ+WdDrWxn7quzFs8X2s6ahdqqA4d1qyHqV6WKHu3b8Rmgbf/o6U
 oQqFSKBn2PrU7k0ZPWngBgWPEO1vtOUg1MHxthQRJaabupd6F9dHZGdXQs8vqaH22E3CfmM6Eu8
 FXH0NMUSIXU1h9jl6oMdmIX1W+Qd919Tsfis09xvHcUPKB5b/JZHy4e/r4TWKbtTU0OM2WKVq62
 lGi2Izjt8mUEW/+BhSBF3t0wCqR8hKPnRk0XRCu3M8PVd5mNi9O07Oi43s3L94LGcOtl6mcrhaq
 VtHaA==
X-Received: by 2002:a05:6a20:a127:b0:3c0:b943:f984 with SMTP id
 adf61e73a8af0-3da39d18786mr4885744637.3.1788499211458; 
 Thu, 03 Sep 2026 22:20:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PULL 06/47] hw/riscv/boot: Make RISCVBootInfo const where possible
Date: Fri,  4 Sep 2026 15:19:02 +1000
Message-ID: <20260904051943.799041-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Joel Stanley <joel@jms.id.au>

As with riscv_load_firmware, take a const pointer in functions that
reads the structure without writing.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>
Message-ID: <20260824055642.41098-2-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h | 6 +++---
 hw/riscv/boot.c         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 4e7bd9a225..d23f45d780 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -50,10 +50,10 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
 void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
                                         RISCVHartArrayState *harts,
                                         hwaddr low_start, hwaddr low_size);
-vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+vaddr riscv_calc_kernel_start_addr(const RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
-                                    RISCVBootInfo *info,
+                                    const RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb);
@@ -71,7 +71,7 @@ void riscv_load_kernel(MachineState *machine,
                        bool load_initrd,
                        symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms, RISCVBootInfo *info);
+                                MachineState *ms, const RISCVBootInfo *info);
 void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr saddr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5e2dfa091a..4ac0b8ef65 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -91,7 +91,7 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
     info->ram_low_size = low_size;
 }
 
-vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+vaddr riscv_calc_kernel_start_addr(const RISCVBootInfo *info,
                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
@@ -151,7 +151,7 @@ char *riscv_find_firmware(const char *firmware_filename,
 }
 
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
-                                    RISCVBootInfo *info,
+                                    const RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb)
@@ -348,7 +348,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms, RISCVBootInfo *info)
+                                MachineState *ms, const RISCVBootInfo *info)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
-- 
2.55.0


