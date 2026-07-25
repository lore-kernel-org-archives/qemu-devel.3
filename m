Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114C0C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmq-00022o-Pj; Fri, 24 Jul 2026 21:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTJ-0006xo-MS
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:33 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTI-0000oW-1y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:33 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5bf94664327so387573e0c.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940151; x=1785544951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PLnP2ltcRm+AptlSTX1goJ6Q09KA8SX8AKgQZ5A2kxo=;
 b=AD1WK393FayqzIYtXiDsaX/c++2puuKXekmju+0NXV1EuGv4RM4YGjFP5Vh1YAh+Yk
 vGclL4/W0BmqdTmMMjAUxsEGGpBHRfGE/vXJVv7NdVAel470MpMc5GlwQxeMsomvcRuY
 Kjdz5SxZm/1/K1nGoqQ7tj9D785Xp2N/w9SR6meu+fLp64fIOg1w0zwqzgrj+HSm6ArT
 Jeq407ZCOXXjL/YJlvRrL1m6aleem5VzUOkO2Pa6d9mY+Gh8gG/R6EFGl73kdPFmdmYa
 IZ1DpnerG5cL0BZVYaa9oOLMAhW8qIDZv9QQtwpZo8KwFtWKf0pWyFPAq6UoIFRrr+4W
 VIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940151; x=1785544951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PLnP2ltcRm+AptlSTX1goJ6Q09KA8SX8AKgQZ5A2kxo=;
 b=X2q0wKbfO9FhZHoE2BG+FEG1vSr5QNLRw33Z0rdTzx9TvITEY/PMxwI3cgLjUh3p3J
 5SU57vJVq5GmVIEvOZ8X9QpUwo/Nl1pPC7f7EQdKz1xYsqS6GiHJiwjiun+g0IhRn8J5
 RiZXSUXEbZ/9glvL98yBW7sFO5jqJkW8EJmXYs4bSiDJGaRwiNwLcyS7aL0tzmDrkR2c
 o+qP2FnM5RFWTkli+1BPtovEXvChpPWnNGl7a2YJDQVGLspejJ8tdlbFXItjonruT6FP
 bOD4Kt7auo6g0VO9zx/LOX4MqauU5ZNMkssZBd6pi+qhYiarC5mkyw7MedGXkS6N3+UY
 ByvA==
X-Gm-Message-State: AOJu0Yy6Ol+7Wr4yvrKgF8rX5t0U0vaU1vAgxCxqFnokaIDNXkW5UYIH
 7qdDpOz0eztwRq8P2cmzLMpLYrXKgFkz1lO/dDY+aDeBPuxlwC0l5aTP/fJH3Z/p
X-Gm-Gg: AR+sD10YZxfcQRerG5AR9sy/2UEfoyczZi1riB+ntIZIHznCR5b/TK7sPFNKD5UJ0e0
 txsclo/DY24zBqfNfW5N3xnB8LQXaL5ssNZ7A5sTdGRNrLx1Ia+krFnHkQxVMlNj7zkby6Obo75
 wipp5B0fpEe3DfbNeN7hm3KjWmT6QMKyXa7txqPX8cxZoYFK7wMTUQQRmPGxP3PRVJM4/Nz4B6C
 ov0XHuJMMqLNHOwcBy8bpAwN50gpbzdHwAtebazvFAYHWt6zC5D+P+iwHR67+Ql54s2W4GFH7FF
 vvE9PEy+fTslt0/vqbtsk/JVyEHDCGtUZVFqn14fl6jFSrYSmdM9Q4wS/mWrLQorHm2Rifkpjt9
 nlrq89C5V+HkZsYD7Bov42Hfu3Mqi5VRU9O13aiOuUwzKwyUtjrBJFY53JrZF/hilTIphP5dy8X
 r3sTRZPXYYptCmEvzHxYsYEGhXY5OsR3sK
X-Received: by 2002:a05:6122:8b10:b0:5bf:6cfa:7743 with SMTP id
 71dfb90a1353d-5c306db29d3mr379064e0c.13.1784940150891; 
 Fri, 24 Jul 2026 17:42:30 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:30 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 08/19] hw/net/bcm2838_genet: add GENET register structs,
 part 4/4
Date: Fri, 24 Jul 2026 20:42:07 -0400
Message-ID: <20260725004219.66222-9-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

From: Sergey Kambalin <serg.oker@gmail.com>

Add the PHY "shadow" register structs (BCM54213PE PHY-specific
clock control, RGMII mode, LED, and expansion-block registers
accessed via the AUX_CTL/EXP_SHD indirection scheme) used by the
MDIO emulation added in a later patch.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 include/hw/net/bcm2838_genet.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index fedfbde0..12439b58 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -273,6 +279,34 @@ typedef struct {
     uint16_t rdb_data;
 } BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -284,6 +318,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.47.1


