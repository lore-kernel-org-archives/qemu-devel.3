Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC96BC55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0yF-0000KL-Nj; Mon, 03 Aug 2026 18:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmazzini@gmail.com>)
 id 1wqySv-0000Cz-4e
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 15:36:49 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmazzini@gmail.com>)
 id 1wqySt-0004lQ-I7
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 15:36:48 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4896ae35be9so1236242b6e.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785785806; x=1786390606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EGdJ0LTBV05DYiqlvAPQDTCYhGKVOlTNNsyUSaPlO+E=;
 b=GDwfWnmROwOkjVF+uLk9GKGS3icpHIXDQdGpGD4DaguIZ34V7kn4PpZzt6gJiVhX8J
 yl+3PLCWdjAJU+4cXuhZEqW/7W6GamYVEs9TClL9i6n3q7JFIrBn/J6TUJ+Xg3LoSWaL
 ZyRJum6id50iXkv160DDMEiU6EkYcREk5RJNr/NZ3P4SdwycFOzLmMsxl/rM4h6WUg5k
 5d6IkgVzo28diS2cz82wb1XgF4oQs7fj1spkbY9t2vaXM5Ok5+cv0cdamUBQUZ+sdh89
 xUWj17pqrtTH+gnBvBA77kA5hD7aNd7St/Q4OtmXNtB7ml1u6sMCzqonMpWbjvp2LH33
 2kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785806; x=1786390606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EGdJ0LTBV05DYiqlvAPQDTCYhGKVOlTNNsyUSaPlO+E=;
 b=mrTWKJdR6oIdL5NfS+NpXJFdm9zJp1qDZxm+Rd7xK7N6Wq3E4gYeedQUDgFnBwQP25
 heESlCVrTZnFrK/RrUhsNmBewL2s26ZXpnG04npjgiRi7gMGVth9fIMC/EMAzYGxZ4Tl
 aqmzgysNTdQhxCTwso8BjvLu0jStnEYOoU6va1QSkJDJQTfW6iubdS4WBIE2GW85VR4J
 IQTOf1gfycDoEWBd+CO/l8/tRfo18o9cs30Sgy3f/IpTJ8vQ9y3ixkKxGQMq1tD1k4fQ
 NmUnWRh1maYVpJyD0X8LPgjkqu4bt9mLdc0JwXd/MJySzVnTHWFCIUK+uOI+nNpNeQDh
 ptjg==
X-Gm-Message-State: AOJu0YykQlYC/ksQyo1vfQ7AkzwY3MxYSQZBvtJmMPq3/I8LuNfsr2tk
 8f76d6xCu9Vnfc/HxJhofV4S9EwpGQTYnARaz5JA+nsnSU7Zh5nWpyv+JF8xGXvdHss=
X-Gm-Gg: AR+sD11jWCcUx2EQ4wtcY+1da+g17zfaYH+pc9yme5CFKcb/tvj8NrToFRb1FRkKjbC
 u/noqWaCWbUzX72P2QD2yN0f/J6YbOxfGwhxNt21CuZG1Isf7Ral0CsLR5n4JihkaXZPMjYFpLo
 qpChuXajY0GySwAbLaG0bkAZTdj4U+jyJ65l/86OUCCxHcRwvkTQZ/b9mjmh7aR1QKDAAMEr2Z8
 JdQdkXS9+kA9ZTSReh3CX55G7sf2p2kaH6dmfgb7nYxN9usE7oX9wn+AntwBUETtTmXSVYMk5tf
 NtcwlkvRRYvMRc5aig6+vldfHSSYHvTmbqpHn+c/XUT9X/6iDEcm/S5P4biHMDfSwZxeZ9YDisY
 XBQeZO8p9g2wJFrKIvXa/NP2MkoS+QSr0AoW5UFWpeZj/aVLnyygOFbF5JLtBNaKhpBVgR/MRNE
 mDYwSFxXSWajfuzruzzD//M7UjHh67t+vp3lHMWR5ie0jsYsPfXWSb0EDiYiO4O0dR4jOGMpzH4
 cuB1lhoeRZ0jd20
X-Received: by 2002:a05:6808:c1e8:b0:497:d371:21c8 with SMTP id
 5614622812f47-4af5e2cd936mr17274055b6e.19.1785785806257; 
 Mon, 03 Aug 2026 12:36:46 -0700 (PDT)
Received: from devvm55912.cln0.facebook.com ([2a03:2880:31ff:22::])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58e95b32sm7243817b6e.10.2026.08.03.12.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 12:36:45 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jcd@tribudubois.net, qemu-arm@nongnu.org,
 Pablo Mazzini <pmazzini@gmail.com>
Subject: [PATCH] hw/misc/imx6_ccm: add the i.MX6SLL variant
Date: Mon,  3 Aug 2026 12:36:32 -0700
Message-ID: <20260803193635.4153664-1-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=pmazzini@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Aug 2026 18:17:05 -0400
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

The i.MX6SLL shares the i.MX6Q clock tree, but reports its own chip id
in the ANATOP DIGPROG register and implements the PMU and XTALOSC24M
registers that the i.MX6Q does not.

Add TYPE_IMX6SLL_CCM as a subtype of TYPE_IMX6_CCM.  QOM runs the
parent's instance_init first, so the subtype only has to override
DIGPROG and widen the decoded ANALOG window to cover the extra
registers; the i.MX6Q window is unchanged.

DIGPROG is a hardwired chip identifier rather than a reset value, so
move its default out of imx6_ccm_reset() and into imx6_ccm_init().

The analog register array grows to cover the new registers.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 hw/misc/imx6_ccm.c         | 39 ++++++++++++++++++++++++++++++++++++--
 include/hw/misc/imx6_ccm.h | 12 +++++++++++-
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 45fdd0d5a8..6f48de5954 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -223,6 +223,14 @@ static const char *imx6_analog_reg_name(uint32_t reg)
         return "PMU_MISC1_TOG";
     case USB_ANALOG_DIGPROG:
         return "USB_ANALOG_DIGPROG";
+    case PMU_LOW_PWR_CTRL:
+        return "PMU_LOW_PWR_CTRL";
+    case XTALOSC24M_OSC_CONFIG0:
+        return "XTALOSC24M_OSC_CONFIG0";
+    case XTALOSC24M_OSC_CONFIG1:
+        return "XTALOSC24M_OSC_CONFIG1";
+    case XTALOSC24M_OSC_CONFIG2:
+        return "XTALOSC24M_OSC_CONFIG2";
     default:
         snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
@@ -237,7 +245,7 @@ static const VMStateDescription vmstate_imx6_ccm = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(ccm, IMX6CCMState, CCM_MAX),
-        VMSTATE_UINT32_ARRAY(analog, IMX6CCMState, CCM_ANALOG_MAX),
+        VMSTATE_UINT32_ARRAY(analog, IMX6CCMState, CCM_ANALOG_REGS),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -474,7 +482,6 @@ static void imx6_ccm_reset(DeviceState *dev)
     s->analog[USB_ANALOG_USB2_VBUS_DETECT] = 0x00000004;
     s->analog[USB_ANALOG_USB2_CHRG_DETECT] = 0x00000000;
     s->analog[USB_ANALOG_USB2_MISC] = 0x00000002;
-    s->analog[USB_ANALOG_DIGPROG] = 0x00630000;
 
     /* all PLLs need to be locked */
     s->analog[CCM_ANALOG_PLL_ARM]   |= CCM_ANALOG_PLL_LOCK;
@@ -763,6 +770,12 @@ static void imx6_ccm_init(Object *obj)
     memory_region_add_subregion(&s->container, 0x4000, &s->ioanalog);
 
     sysbus_init_mmio(sd, &s->container);
+
+    /*
+     * DIGPROG is a hardwired chip identifier: it is not affected by reset.
+     * Default to i.MX6Q; variants sharing this CCM override it below.
+     */
+    s->analog[USB_ANALOG_DIGPROG] = 0x00630000;
 }
 
 static void imx6_ccm_class_init(ObjectClass *klass, const void *data)
@@ -777,6 +790,21 @@ static void imx6_ccm_class_init(ObjectClass *klass, const void *data)
     ccm->get_clock_frequency = imx6_ccm_get_clock_frequency;
 }
 
+static void imx6sll_ccm_init(Object *obj)
+{
+    IMX6CCMState *s = IMX6_CCM(obj);
+
+    /*
+     * Runs after imx6_ccm_init(), which installs the i.MX6Q default.  The
+     * clock tree is the same; only the chip identifier differs:
+     * MXC_CPU_IMX6SLL (0x67), revision 1.0.
+     */
+    s->analog[USB_ANALOG_DIGPROG] = 0x00670000;
+
+    /* Unlike the i.MX6Q, this one implements the PMU/XTALOSC24M registers. */
+    memory_region_set_size(&s->ioanalog, CCM_ANALOG_REGS * sizeof(uint32_t));
+}
+
 static const TypeInfo imx6_ccm_info = {
     .name          = TYPE_IMX6_CCM,
     .parent        = TYPE_IMX_CCM,
@@ -785,9 +813,16 @@ static const TypeInfo imx6_ccm_info = {
     .class_init    = imx6_ccm_class_init,
 };
 
+static const TypeInfo imx6sll_ccm_info = {
+    .name          = TYPE_IMX6SLL_CCM,
+    .parent        = TYPE_IMX6_CCM,
+    .instance_init = imx6sll_ccm_init,
+};
+
 static void imx6_ccm_register_types(void)
 {
     type_register_static(&imx6_ccm_info);
+    type_register_static(&imx6sll_ccm_info);
 }
 
 type_init(imx6_ccm_register_types)
diff --git a/include/hw/misc/imx6_ccm.h b/include/hw/misc/imx6_ccm.h
index a54b940686..ba8b9037ce 100644
--- a/include/hw/misc/imx6_ccm.h
+++ b/include/hw/misc/imx6_ccm.h
@@ -150,6 +150,13 @@
 #define USB_ANALOG_DIGPROG 152
 #define CCM_ANALOG_MAX 153
 
+/* PMU and XTALOSC24M registers; i.MX6SLL/SX/UL only */
+#define PMU_LOW_PWR_CTRL 156
+#define XTALOSC24M_OSC_CONFIG0 168
+#define XTALOSC24M_OSC_CONFIG1 172
+#define XTALOSC24M_OSC_CONFIG2 176
+#define CCM_ANALOG_REGS 177
+
 /* CCM_CBCMR */
 #define PRE_PERIPH_CLK_SEL_SHIFT  (18)
 #define PRE_PERIPH_CLK_SEL_LENGTH (2)
@@ -195,8 +202,11 @@ struct IMX6CCMState {
     MemoryRegion ioanalog;
 
     uint32_t ccm[CCM_MAX];
-    uint32_t analog[CCM_ANALOG_MAX];
+    uint32_t analog[CCM_ANALOG_REGS];
 
 };
 
+/* Same clock tree as the i.MX6Q, but its own chip id in ANATOP DIGPROG. */
+#define TYPE_IMX6SLL_CCM "imx6sll.ccm"
+
 #endif /* IMX6_CCM_H */
-- 
2.53.0


