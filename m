Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ADFCD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiZ-0005ZD-0U; Tue, 16 Jun 2026 06:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiW-0005RK-PV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:24 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiV-0003cF-14
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c85c531d4a9so1680209a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604501; x=1782209301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a171VpmQFGXoe3rT39lAdkfIikj6YLS/s1pyARELVY=;
 b=YFMFbSIcdNwdILNuNhWoa9Bc08tNQYLgplNTH6vIEtTFJw0Gg5bqQc0yrBS07ySTMI
 P9ZdfAZhyrR4a/ktItBEfS4kJ+s5U0BKAXx9hvI6CRQ76ovDXxjysG9ZSyp5o6n87FFy
 NipokBZN7mQAaoBIwcboQ71sptz3nHq3WbIamI1aPwPtyiN6pUcTIS6zJIAuBKdHWZ+l
 /5+8r8pzyZhiOPTGluYQV/vPpFakkgiKCdkP9eon0rXNGjlrmp2r22hYmWAUgwmDauDB
 mV66cgNgkC5pT7vTzvXI/sZ9y8jn+Vv0bJQibM9zMMvRpLRlVjbD27N1/6ThlojJPjs0
 s1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604501; x=1782209301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8a171VpmQFGXoe3rT39lAdkfIikj6YLS/s1pyARELVY=;
 b=kApd9SGs6qj9yIf+Vfv4+D2hCFjzFZRNPrTqS8Yw3rog5I0kZ2a5oNXpx17qE2HJ1S
 fxYRvms1OQ+MLNw+O3sqmTiZ2cvhd0Gb7DrYWzHRnp2gWTUOKwdOTiSZLEoMX5DrS+bx
 z3Rg900yv5eSoS4QtjGX9I0FHRedjkfRy1+bxi1VF4vz7V3/h2Di6Ebohu7A8QjKffWA
 jU1MOy2yT3UysaY+fU6Z1tRtdOsTSA67hhUMgFinYJLP6AQT/7dvR70UlKEJOO5R4ITR
 2dyMF24N64Bzr/mUCnpqLosQqDuYLed1PYCtEM1NHXE0froKtokPR+PrNHrKnLr4REr5
 hp8A==
X-Gm-Message-State: AOJu0YxhmNYBpo4ZjEIu3zJ/DgNyWrGl08rtoHPFdxqZiA03JozjdYxu
 pgD6lh6Y42CWfBYt+092pHs2c4Hsng1TaAitPpo3y6tgf9AS6EoMKDOl9dOBrtha
X-Gm-Gg: Acq92OEYngqOcQ88x9e1YQne9118TW7KdetY5JgLeNkWB8/N0bESrZI3C45RaBSlLFr
 am6YFDkCUV7ndOz2PUruKt8AGq3vlakBxZvNURJZ3UpGPBGUwRmq6Js2kuM01Kczdb7junR45Pa
 Yg/W+dtLpOm6E0a0BuyAyfOz2zLpUKM4M5PyBhIliC8NekQQaK7seJ5UNWqWjXPIzNE1gEkWqCb
 iT85REztfsFTXUJlztShpfCz+hPaf33ecePchfR17BHkleBq9yHH28fq+mLbqxeOsucsubscMIY
 TudEWLoyZaWYRRVb6003WDDvntesdOlx0prpdETfNv6e9HZo1b/y423/YKd1IVjHflYrSsxlba7
 DaYc+xIbw+Ee1/XvrQF/uYEPMSjVnNcSh+zNywYV+0fBiirqqWe+xi/ZFJocjf2kPMdZrrA5S2A
 35MCbQn1/WHhkLqwZnUDwaigDZjIZG5Vc47BJJWQCL
X-Received: by 2002:a05:6a21:d84:b0:3b4:6dee:a427 with SMTP id
 adf61e73a8af0-3b796445fd5mr14540671637.44.1781604501476; 
 Tue, 16 Jun 2026 03:08:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 48/83] hw/riscv/boot: Replace cpu_to_le32() -> const_le32()
Date: Tue, 16 Jun 2026 20:04:51 +1000
Message-ID: <20260616100527.1939565-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rather than adapting the array endianness when it it
filled, directly initialize the CODE words with the
correct endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-9-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c6ab1cc8cf..4297949f6b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -454,40 +454,36 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr)
 {
-    int i;
     const bool rv32 = riscv_is_32bit(harts);
     uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
 
-    /* .text */
-    reset_vec[0] = 0x00000297;                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
-    reset_vec[1] = 0x02828613;                  /*     addi   a2, t0, %pcrel_lo(1b) */
+    /* .text (RISC-V instructions are always little-endian) */
+    reset_vec[0] = const_le32(0x00000297);      /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+    reset_vec[1] = const_le32(0x02828613);      /*     addi   a2, t0, %pcrel_lo(1b) */
+    reset_vec[2] = const_le32(0xf1402573);      /*     csrr   a0, mhartid  */
     if (harts->harts[0].cfg.ext_zicsr) {
-        reset_vec[2] = 0xf1402573;              /*     csrr   a0, mhartid  */
+        reset_vec[2] = const_le32(0xf1402573);  /*     csrr   a0, mhartid  */
     } else {
         /*
          * The Zicsr extension has been disabled, so let's ensure we don't
          * run the CSR instruction. Let's fill the address with a non
          * compressed nop.
          */
-        reset_vec[2] = 0x00000013;              /*     addi   x0, x0, 0 */
+        reset_vec[2] = const_le32(0x00000013);  /*     addi   x0, x0, 0 */
     }
     if (rv32) {
-        reset_vec[3] = 0x0202a583;              /*     lw     a1, 32(t0) */
-        reset_vec[4] = 0x0182a283;              /*     lw     t0, 24(t0) */
+        reset_vec[3] = const_le32(0x0202a583);  /*     lw     a1, 32(t0) */
+        reset_vec[4] = const_le32(0x0182a283);  /*     lw     t0, 24(t0) */
     } else {
-        reset_vec[3] = 0x0202b583;              /*     ld     a1, 32(t0) */
-        reset_vec[4] = 0x0182b283;              /*     ld     t0, 24(t0) */
+        reset_vec[3] = const_le32(0x0202b583);  /*     ld     a1, 32(t0) */
+        reset_vec[4] = const_le32(0x0182b283);  /*     ld     t0, 24(t0) */
     }
-    reset_vec[5] = 0x00028067;                  /*     jr     t0 */
+    reset_vec[5] = const_le32(0x00028067);      /*     jr     t0 */
 
     /* .data */
-    stq_p(&reset_vec[6], start_addr);           /* start:       .dword */
-    stq_p(&reset_vec[8], fdt_load_addr);        /* fdt_laddr:   .dword */
+    stq_le_p(&reset_vec[6], start_addr);        /* start:       .dword */
+    stq_le_p(&reset_vec[8], fdt_load_addr);     /* fdt_laddr:   .dword */
 
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
     riscv_rom_copy_firmware_info(machine, harts,
-- 
2.54.0


