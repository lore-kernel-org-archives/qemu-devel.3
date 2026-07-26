Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714B8C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxz7-0001SB-IP; Sun, 26 Jul 2026 08:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxz6-0001Po-2s
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:36 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxz3-0003JA-Ab
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8485b358552so1933172b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068972; x=1785673772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5wBFH4kuOWR6ro+3Rls6E6onh4AnTwIygY1OrxRai0=;
 b=NVF4i4lnU3wyVoiw4/ZNknmFC17J2nUeN33yavf3WaD8Yq03YBXLjjNukuxw1OzGrn
 KwDmEZjrCz5ZBVXLFRn/U9RLlzXC4r21cRiLnWxmkKT4wq6u5pZvpTUdBCgx7kebbsLI
 zlcvB3eivWgyJ098eDobzOqwTzdJ2VDaiIpG9P2VOgsCMaZXgpRgHNkeASvHQiEs/VNA
 reQB6J8nfoOc23LhTPhR3WAm4GPVitQbmf1mKbYwhXzlku8d7Kdq2Tf3eICaYRQTQu3T
 kP3sC8HA+M18IybaNZ+jP92UqgsdAfrxv3CmBWvEfXXJykCb69QXNjeJbg3qdVr4qvH5
 ropg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068972; x=1785673772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u5wBFH4kuOWR6ro+3Rls6E6onh4AnTwIygY1OrxRai0=;
 b=hPKuFSzz6tFVqO/bn6aavnJ/y4P6wiJSjvxTBHYAjSObD+0tcOb7sq47Zn89yq6FK3
 salaf5MnViVDAv7KU0tS+A336s+dxBu0ZlCuFLb1M//CX6lU/p/aZUK+p3v67+QVOcVN
 gjL2ePFc/5IUynJ1sXGfeWwnEUlr8yZNSL0+k5nXQEyRBqJtUWp3mgxy87aEocSe7Htk
 RSNzYdDPOuca58meM3cMIPueQYIaYgoKUR/oGYZWEQxT/bDtjQPR4eYy133005ATuBGX
 MrVDjGRpoD+XHnemB9Zek93AvePvQd/LwamXEeCtNyb+5JFTuFq0s2yChU3pTa+I1Yam
 /EoA==
X-Gm-Message-State: AOJu0Yx2GHXPYLe6pT/cG843pUfq+5W/vnUzoRYJpjZ4xVXTFeC2e1gb
 2uo1dioy7t47ZS/297OqvlWJ2YCkZWwOVTUmPmO8Cvb7S3Y9YxdO95i4n+vQMIbk4lU=
X-Gm-Gg: AR+sD10Q/t5eoR/4FWtw+OdWZJF0veV9bWqubn+zNchnlNj7XnF29lr76Y7CHACIE5I
 7GvA0W1Twx2BHPh9sMwL7onw99lhT0IwmUVEBsTcTE+jdSVocH0MXDrZTxbYwIx4Xsh8Zk2hdl+
 1qu+DhjqQffzxVyekcawrUv2dN+A36tsT18/BcPER4mCMJsd2LUZLsMJVsAbpfoxaevizCVCG8X
 rhZ1QUsbLg6l438d84J/FjTrRiZCvCDBjuD3SXIl7qmaOfn0a3wbY4Cit1GYEYDvNVCkVcgu9SY
 xuzecOJPGdcjyVLCUeDoZkcR/AfCp6D4/eLDL6dYca6zq4unSaeN9dEcjkx0GU50qVrLc94cMvr
 eorrIb8Fpx0dhqnqhzwnI/vW70r6kdgTdTpFptz5feuUhaQJSms0lKc293ASyV/v+bQSckO0w04
 5bXo9+mUp/3HN9ddqe0GfH
X-Received: by 2002:a05:6a00:2e1e:b0:848:2f84:732 with SMTP id
 d2e1a72fcca58-84e5959438amr3832009b3a.69.1785068971551; 
 Sun, 26 Jul 2026 05:29:31 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:30 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 06/11] hw/ssi: Implement K230 enhanced QSPI transfers
Date: Sun, 26 Jul 2026 20:28:24 +0800
Message-ID: <db4d5698e19e610c3e84b85b5ea8b0b3758546be.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add controller-side Dual and Quad SDR phases for instruction, address,
mode, dummy, and data fields.

Reject unsupported Octal, DDR, RXDS, and invalid transfer configurations
without consuming FIFO data.

Use qtest to check an accepted Quad SDR configuration and representative
Octal and DDR rejection paths.

According to the K230 SDK driver, multi-line QSPI data transfers use the
controller's internal IDMA path. That SDK-facing path is implemented by
a later patch.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/ssi/k230_dw_ssi.c           | 297 ++++++++++++++++++++++++++++++++-
 include/hw/ssi/k230_dw_ssi.h   |  22 +++
 tests/qtest/k230-dw-ssi-test.c |  65 ++++++++
 3 files changed, 376 insertions(+), 8 deletions(-)

diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index 26ac052a63..31da3a06a3 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -40,6 +40,13 @@
 #define K230_DW_SSI_PIO_TX_BATCH            64
 #define K230_DW_SSI_IRQ_VALID_MASK          0x000009bf
 
+enum {
+    K230_DW_SSI_TMOD_TR,
+    K230_DW_SSI_TMOD_TO,
+    K230_DW_SSI_TMOD_RO,
+    K230_DW_SSI_TMOD_EEPROM_READ,
+};
+
 REG32(CTRLR0, 0x000)
     FIELD(CTRLR0, DFS, 0, 5)
     FIELD(CTRLR0, FRF, 6, 2)
@@ -324,7 +331,6 @@ static uint32_t k230_dw_ssi_frame_masked(K230DwSsiState *s)
     return bits == 32 ? UINT32_MAX : MAKE_64BIT_MASK(0, bits);
 }
 
-
 static bool k230_dw_ssi_enabled(K230DwSsiState *s)
 {
     return FIELD_EX32(s->regs[R_SSIENR], SSIENR, SSIC_EN);
@@ -386,6 +392,7 @@ static void k230_dw_ssi_abort_transfer(K230DwSsiState *s)
     fifo32_reset(&s->rx_fifo);
     s->phase = K230_DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
+    memset(&s->enhanced, 0, sizeof(s->enhanced));
     k230_dw_ssi_update_irq(s);
 }
 
@@ -419,7 +426,7 @@ static void k230_dw_ssi_push_tx(K230DwSsiState *s, uint32_t tx)
         return;
     }
 
-    fifo32_push(&s->tx_fifo, tx & k230_dw_ssi_frame_masked(s));
+    fifo32_push(&s->tx_fifo, tx);
 
     if (s->phase != K230_DW_SSI_PHASE_STANDARD_TX_ONLY) {
         k230_dw_ssi_run_transfer(s);
@@ -444,6 +451,267 @@ static uint32_t k230_dw_ssi_send_frame(K230DwSsiState *s,
     return rx & mask;
 }
 
+static bool k230_dw_ssi_enhanced_config_supported(K230DwSsiState *s)
+{
+    uint32_t ctrlr0 = s->regs[R_CTRLR0];
+    uint32_t spi_ctrlr0 = s->regs[R_SPI_CTRLR0];
+    uint32_t spi_frf;
+    uint32_t trans_type;
+    uint32_t tmod;
+    uint32_t required_lines;
+
+    spi_frf = FIELD_EX32(ctrlr0, CTRLR0, SPI_FRF);
+    trans_type = FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, TRANS_TYPE);
+    tmod = FIELD_EX32(ctrlr0, CTRLR0, TMOD);
+
+    switch (spi_frf) {
+    case 1: /* Dual */
+        required_lines = 2;
+        break;
+    case 2: /* Quad */
+        required_lines = 4;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported SPI_FRF=%u\n",
+                      DEVICE(s)->canonical_path, spi_frf);
+        return false;
+    }
+
+    if (required_lines > s->max_lines) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SPI_FRF=%u requires %u lines, only %u available\n",
+                      DEVICE(s)->canonical_path,
+                      spi_frf, required_lines, s->max_lines);
+        return false;
+    }
+
+    if (trans_type > 2) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported TRANS_TYPE=%u\n",
+                      DEVICE(s)->canonical_path, trans_type);
+        return false;
+    }
+
+    if (tmod != K230_DW_SSI_TMOD_RO && tmod != K230_DW_SSI_TMOD_TO) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported enhanced TMOD=%u\n",
+                      DEVICE(s)->canonical_path, tmod);
+        return false;
+    }
+
+    if (FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, SPI_DDR_EN) ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, INST_DDR_EN) ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, SPI_RXDS_EN) ||
+        FIELD_EX32(spi_ctrlr0, SPI_CTRLR0, SPI_RXDS_SIG_EN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: DDR/RXDS enhanced mode is unsupported\n",
+                      DEVICE(s)->canonical_path);
+        return false;
+    }
+
+    return true;
+}
+
+static bool k230_dw_ssi_decode_enhanced_command(
+    K230DwSsiState *s, K230DwSsiEnhancedCommand *command)
+{
+    uint32_t spi_frf = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF);
+    uint32_t inst_l = FIELD_EX32(s->regs[R_SPI_CTRLR0], SPI_CTRLR0, INST_L);
+    uint32_t addr_l = FIELD_EX32(s->regs[R_SPI_CTRLR0], SPI_CTRLR0, ADDR_L);
+    uint32_t trans_type = FIELD_EX32(s->regs[R_SPI_CTRLR0],
+                                     SPI_CTRLR0, TRANS_TYPE);
+    uint32_t inst_bits;
+    uint32_t addr_bits = addr_l << 2;
+    uint32_t mode_bits = 0;
+    bool mode_bits_enabled =
+        FIELD_EX32(s->regs[R_SPI_CTRLR0], SPI_CTRLR0, XIP_MD_BIT_EN);
+
+    if (!k230_dw_ssi_enhanced_config_supported(s)) {
+        return false;
+    }
+
+    inst_bits = inst_l ? (1U << (inst_l + 1)) : 0;
+
+    if (addr_bits > 32) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unsupported enhanced address length %u bits\n",
+                      DEVICE(s)->canonical_path, addr_bits);
+        return false;
+    }
+
+    if (mode_bits_enabled) {
+        uint32_t mode_length_encoding =
+            FIELD_EX32(s->regs[R_SPI_CTRLR0], SPI_CTRLR0, XIP_MBL);
+
+        mode_bits = 1U << (mode_length_encoding + 1);
+    }
+
+    command->instruction_bits = inst_bits;
+    command->address_bits = addr_bits;
+    command->mode_bits = mode_bits;
+    command->mode_bits_enabled = mode_bits_enabled;
+    command->wait_cycles =
+        FIELD_EX32(s->regs[R_SPI_CTRLR0], SPI_CTRLR0, WAIT_CYCLES);
+    command->data_frames =
+        FIELD_EX32(s->regs[R_CTRLR1], CTRLR1, NDF) + 1;
+    command->spi_frf = spi_frf;
+    command->trans_type = trans_type;
+    command->tmod = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD);
+
+    if (mode_bits_enabled) {
+        command->mode = s->regs[R_XIP_MODE_BITS] &
+            (uint32_t)MAKE_64BIT_MASK(0, mode_bits);
+    }
+
+    return true;
+}
+
+static bool k230_dw_ssi_prepare_enhanced_command(K230DwSsiState *s)
+{
+    K230DwSsiEnhancedCommand command = { 0 };
+    uint32_t required_items;
+
+    if (!k230_dw_ssi_decode_enhanced_command(s, &command)) {
+        return false;
+    }
+
+    required_items = (command.instruction_bits != 0) +
+                     (command.address_bits != 0);
+    if (fifo32_num_used(&s->tx_fifo) < required_items) {
+        return false;
+    }
+
+    if (command.instruction_bits != 0) {
+        command.instruction = fifo32_pop(&s->tx_fifo) &
+            (uint32_t)MAKE_64BIT_MASK(0, command.instruction_bits);
+    }
+    if (command.address_bits != 0) {
+        command.address = fifo32_pop(&s->tx_fifo) &
+            (uint32_t)MAKE_64BIT_MASK(0, command.address_bits);
+    }
+
+    s->enhanced = command;
+    s->remaining_frames = command.data_frames;
+    s->phase = K230_DW_SSI_PHASE_ENHANCED_INSTRUCTION;
+    return true;
+}
+
+static void k230_dw_ssi_send_enhanced_field(K230DwSsiState *s,
+                                             uint32_t value,
+                                             uint32_t bits)
+{
+    uint32_t bytes = DIV_ROUND_UP(bits, 8);
+
+    for (uint32_t i = 0; i < bytes; i++) {
+        uint32_t shift = (bytes - i - 1) * 8;
+
+        ssi_transfer(s->spi, (value >> shift) & 0xff);
+    }
+}
+
+static uint32_t k230_dw_ssi_dummy_bytes(uint32_t spi_frf,
+                                         uint32_t trans_type,
+                                         uint32_t wait_cycles)
+{
+    uint32_t lines = 1;
+
+    if (trans_type != 0) {
+        lines = spi_frf == 1 ? 2 : 4;
+    }
+
+    return DIV_ROUND_UP(wait_cycles * lines, 8);
+}
+
+static void k230_dw_ssi_run_enhanced_rx_data(K230DwSsiState *s)
+{
+    while (!fifo32_is_full(&s->rx_fifo) &&
+           s->remaining_frames > 0) {
+        uint32_t rx = ssi_transfer(s->spi, 0);
+
+        fifo32_push(&s->rx_fifo,
+                    rx & k230_dw_ssi_frame_masked(s));
+        s->remaining_frames--;
+    }
+}
+
+static void k230_dw_ssi_run_enhanced_tx_data(K230DwSsiState *s)
+{
+    uint32_t mask = k230_dw_ssi_frame_masked(s);
+
+    while (!fifo32_is_empty(&s->tx_fifo) &&
+           s->remaining_frames > 0) {
+        uint32_t tx = fifo32_pop(&s->tx_fifo);
+
+        ssi_transfer(s->spi, tx & mask);
+        s->remaining_frames--;
+    }
+}
+
+static void k230_dw_ssi_run_enhanced_transfer(K230DwSsiState *s)
+{
+    if (s->phase == K230_DW_SSI_PHASE_IDLE) {
+        if (!k230_dw_ssi_prepare_enhanced_command(s)) {
+            return;
+        }
+    }
+
+    if (s->phase == K230_DW_SSI_PHASE_ENHANCED_INSTRUCTION) {
+        if (s->enhanced.instruction_bits != 0) {
+            k230_dw_ssi_send_enhanced_field(
+                s, s->enhanced.instruction,
+                s->enhanced.instruction_bits);
+        }
+        s->phase = K230_DW_SSI_PHASE_ENHANCED_ADDRESS;
+    }
+
+    if (s->phase == K230_DW_SSI_PHASE_ENHANCED_ADDRESS) {
+        if (s->enhanced.address_bits != 0) {
+            k230_dw_ssi_send_enhanced_field(
+                s, s->enhanced.address, s->enhanced.address_bits);
+        }
+        s->phase = K230_DW_SSI_PHASE_ENHANCED_MODE;
+    }
+
+    if (s->phase == K230_DW_SSI_PHASE_ENHANCED_MODE) {
+        if (s->enhanced.mode_bits_enabled) {
+            k230_dw_ssi_send_enhanced_field(
+                s, s->enhanced.mode, s->enhanced.mode_bits);
+        }
+        s->phase = K230_DW_SSI_PHASE_ENHANCED_DUMMY;
+    }
+
+    if (s->phase == K230_DW_SSI_PHASE_ENHANCED_DUMMY) {
+        uint32_t dummy_bytes = k230_dw_ssi_dummy_bytes(
+            s->enhanced.spi_frf, s->enhanced.trans_type,
+            s->enhanced.wait_cycles);
+
+        for (uint32_t i = 0; i < dummy_bytes; i++) {
+            ssi_transfer(s->spi, 0);
+        }
+        s->phase = K230_DW_SSI_PHASE_ENHANCED_DATA;
+    }
+
+    if (s->phase != K230_DW_SSI_PHASE_ENHANCED_DATA) {
+        g_assert_not_reached();
+    }
+
+    switch (s->enhanced.tmod) {
+    case K230_DW_SSI_TMOD_RO:
+        k230_dw_ssi_run_enhanced_rx_data(s);
+        break;
+    case K230_DW_SSI_TMOD_TO:
+        k230_dw_ssi_run_enhanced_tx_data(s);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (s->remaining_frames == 0) {
+        s->phase = K230_DW_SSI_PHASE_IDLE;
+    }
+}
+
 static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
 {
     uint32_t spi_frf;
@@ -455,16 +723,18 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
 
     spi_frf = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF);
     if (spi_frf != 0) {
+        k230_dw_ssi_run_enhanced_transfer(s);
         return;
     }
 
     tmod = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD);
 
     switch (tmod) {
-    case 0: /* TX_AND_RX */
+    case K230_DW_SSI_TMOD_TR:
         while (!fifo32_is_empty(&s->tx_fifo)) {
             uint32_t tx = fifo32_pop(&s->tx_fifo);
             uint32_t rx = k230_dw_ssi_send_frame(s, tx);
+
             if (!fifo32_is_full(&s->rx_fifo)) {
                 fifo32_push(&s->rx_fifo, rx);
             } else {
@@ -476,7 +746,7 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
             }
         }
         break;
-    case 1: { /* TX_ONLY */
+    case K230_DW_SSI_TMOD_TO: {
         unsigned int frames = 0;
 
         if (fifo32_is_empty(&s->tx_fifo)) {
@@ -497,7 +767,7 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
         }
         break;
     }
-    case 2: /* RX_ONLY */
+    case K230_DW_SSI_TMOD_RO:
         switch (s->phase) {
         case K230_DW_SSI_PHASE_IDLE:
             if (fifo32_is_empty(&s->tx_fifo)) {
@@ -522,7 +792,7 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
             break;
         }
         break;
-    case 3: /* EEPROM_READ */
+    case K230_DW_SSI_TMOD_EEPROM_READ:
         switch (s->phase) {
         case K230_DW_SSI_PHASE_IDLE:
             if (fifo32_is_empty(&s->tx_fifo)) {
@@ -562,8 +832,6 @@ static void k230_dw_ssi_run_transfer(K230DwSsiState *s)
     }
 }
 
-
-
 static bool k230_dw_ssi_is_dr(hwaddr addr)
 {
     return addr >= A_DR0 && addr <= A_DR_END &&
@@ -920,6 +1188,7 @@ static void k230_dw_ssi_enter_reset(Object *obj, ResetType type)
     s->phase = K230_DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
     s->irq_latched = 0;
+    memset(&s->enhanced, 0, sizeof(s->enhanced));
 
     s->regs[R_CTRLR0] = K230_DW_SSI_CTRLR0_RESET;
     s->regs[R_SR] = K230_DW_SSI_SR_RESET;
@@ -983,6 +1252,18 @@ static const VMStateDescription vmstate_k230_dw_ssi = {
         VMSTATE_UINT32(irq_latched, K230DwSsiState),
         VMSTATE_UINT32(phase, K230DwSsiState),
         VMSTATE_UINT32(remaining_frames, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.instruction, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.address, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.mode, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.mode_bits, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.instruction_bits, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.address_bits, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.wait_cycles, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.data_frames, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.spi_frf, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.trans_type, K230DwSsiState),
+        VMSTATE_UINT32(enhanced.tmod, K230DwSsiState),
+        VMSTATE_BOOL(enhanced.mode_bits_enabled, K230DwSsiState),
         VMSTATE_INT32(active_cs, K230DwSsiState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/include/hw/ssi/k230_dw_ssi.h b/include/hw/ssi/k230_dw_ssi.h
index 404215245b..b692a616d6 100644
--- a/include/hw/ssi/k230_dw_ssi.h
+++ b/include/hw/ssi/k230_dw_ssi.h
@@ -51,8 +51,29 @@ typedef enum K230DwSsiPhase {
     K230_DW_SSI_PHASE_RX_ONLY,
     K230_DW_SSI_PHASE_EEPROM_COMMAND,
     K230_DW_SSI_PHASE_EEPROM_DATA,
+
+    K230_DW_SSI_PHASE_ENHANCED_INSTRUCTION,
+    K230_DW_SSI_PHASE_ENHANCED_ADDRESS,
+    K230_DW_SSI_PHASE_ENHANCED_MODE,
+    K230_DW_SSI_PHASE_ENHANCED_DUMMY,
+    K230_DW_SSI_PHASE_ENHANCED_DATA,
 } K230DwSsiPhase;
 
+typedef struct K230DwSsiEnhancedCommand {
+    uint32_t instruction;
+    uint32_t address;
+    uint32_t mode;
+    uint32_t instruction_bits;
+    uint32_t address_bits;
+    uint32_t mode_bits;
+    uint32_t wait_cycles;
+    uint32_t data_frames;
+    uint32_t spi_frf;
+    uint32_t trans_type;
+    uint32_t tmod;
+    bool mode_bits_enabled;
+} K230DwSsiEnhancedCommand;
+
 struct K230DwSsiState {
     SysBusDevice parent_obj;
 
@@ -69,6 +90,7 @@ struct K230DwSsiState {
 
     uint32_t phase;
     uint32_t remaining_frames;
+    K230DwSsiEnhancedCommand enhanced;
 
     uint32_t num_cs;
     uint32_t max_lines;
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index e6c0e2ee8c..a507814b66 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -55,12 +55,23 @@
 #define K230_SSI_CTRLR0_DFS_MASK        0x1fU
 #define K230_SSI_CTRLR0_TMOD_SHIFT      10
 #define K230_SSI_CTRLR0_SRL             BIT(13)
+#define K230_SSI_CTRLR0_SPI_FRF_SHIFT   22
+#define K230_SSI_CTRLR0_SPI_FRF_MASK    (3U << K230_SSI_CTRLR0_SPI_FRF_SHIFT)
 
 #define K230_SSI_TMOD_TR                0
 #define K230_SSI_TMOD_TO                1
 #define K230_SSI_TMOD_RO                2
 #define K230_SSI_TMOD_EEPROM_READ       3
 
+#define K230_SSI_FRF_QUAD               2
+#define K230_SSI_FRF_OCTAL              3
+
+#define K230_SSI_SPI_CTRLR0_TRANS_TYPE(v) ((v) & 0x3U)
+#define K230_SSI_SPI_CTRLR0_ADDR_L(bits)  (((bits) / 4U) << 2)
+#define K230_SSI_SPI_CTRLR0_INST_L_8      (2U << 8)
+#define K230_SSI_SPI_CTRLR0_WAIT(v)       (((v) & 0x1fU) << 11)
+#define K230_SSI_SPI_CTRLR0_SPI_DDR_EN    BIT(16)
+
 #define K230_SSI_SR_BUSY                BIT(0)
 #define K230_SSI_SR_TFNF                BIT(1)
 #define K230_SSI_SR_TFE                 BIT(2)
@@ -104,6 +115,8 @@ static const K230SsiInstance k230_ssi_instances[3] = {
     },
 };
 
+#define FLASH_CMD_JEDEC         0x9f
+
 static QTestState *k230_ssi_start(void)
 {
     return qtest_init("-machine k230");
@@ -326,6 +339,57 @@ static void test_plic_routing(void)
     qtest_quit(qts);
 }
 
+static void assert_enhanced_config_rejected(QTestState *qts, uint32_t frf,
+                                            uint32_t extra_spi_ctrlr0)
+{
+    uint32_t ctrlr0;
+    uint32_t spi_ctrlr0;
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_RO, 8, 3);
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0);
+    ctrlr0 |= frf << K230_SSI_CTRLR0_SPI_FRF_SHIFT;
+    spi_ctrlr0 = K230_SSI_SPI_CTRLR0_INST_L_8 | extra_spi_ctrlr0;
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_CTRLR0, ctrlr0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPI_CTRLR0, spi_ctrlr0);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, FLASH_CMD_JEDEC);
+    g_assert_cmpuint(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_TXFLR),
+                     ==, 1);
+    g_assert_cmpuint(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_RXFLR),
+                     ==, 0);
+    k230_ssi_disable(qts, K230_SPI0_BASE);
+}
+
+static void test_qspi_config(void)
+{
+    QTestState *qts = k230_ssi_start();
+    uint32_t ctrlr0;
+    uint32_t spi_ctrlr0;
+
+    assert_enhanced_config_rejected(qts, K230_SSI_FRF_OCTAL, 0);
+    assert_enhanced_config_rejected(qts, K230_SSI_FRF_QUAD,
+                                    K230_SSI_SPI_CTRLR0_SPI_DDR_EN);
+
+    k230_ssi_configure(qts, K230_SPI0_BASE, K230_SSI_TMOD_RO, 8, 3);
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0);
+    ctrlr0 |= K230_SSI_FRF_QUAD << K230_SSI_CTRLR0_SPI_FRF_SHIFT;
+    spi_ctrlr0 = K230_SSI_SPI_CTRLR0_TRANS_TYPE(1) |
+                 K230_SSI_SPI_CTRLR0_ADDR_L(24) |
+                 K230_SSI_SPI_CTRLR0_INST_L_8 |
+                 K230_SSI_SPI_CTRLR0_WAIT(8);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_CTRLR0, ctrlr0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SPI_CTRLR0, spi_ctrlr0);
+    k230_ssi_enable_cs(qts, K230_SPI0_BASE, BIT(0));
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, FLASH_CMD_JEDEC);
+    k230_ssi_write_frame(qts, K230_SPI0_BASE, 0x123456);
+    g_assert_cmpuint(k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_RXFLR),
+                     ==, 4);
+    for (int i = 0; i < 4; i++) {
+        g_assert_cmphex(k230_ssi_read_frame(qts, K230_SPI0_BASE), ==, 0);
+    }
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -335,5 +399,6 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dw-ssi/interrupt-controller",
                    test_interrupt_controller);
     qtest_add_func("/k230-dw-ssi/plic-routing", test_plic_routing);
+    qtest_add_func("/k230-dw-ssi/qspi-config", test_qspi_config);
     return g_test_run();
 }
-- 
2.43.0


