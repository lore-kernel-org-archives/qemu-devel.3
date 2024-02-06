Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D6AC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWB-0000Y6-Mo; Tue, 06 Feb 2024 08:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW9-0000Se-M8
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:42 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW5-0008ET-He
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:41 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-337cc8e72f5so4189546f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226176; x=1707830976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gFP5iyTPjpV1cEOb71+konTscrwLFnQ2qPt+jzXrQdw=;
 b=pJ9rOZPjc609bEUnrHEghLlOW1hNQdLyY9MEDfvMxwfg1/IOvlIVodEyAqFAdIyQo+
 eymR81iPKS0YjjU7fA3HmCWHpbtJCA7jZCLKAWSpnXJrTtqzxikmLRjTqOrEk3r9Uhfj
 FvReNNb7o+lZS7PGwsesZuzfNff32V7x5S4bchZ8XSkPmol9u6M8nPeyauofaJ/OU7ry
 znnwRPPzt9HupWBRzFj+DLRHL6nQphwZcAvJgPR3Kd4/1uzkcRT9wD/UKmiZqlM2sqki
 H03eFi5peOp0bf0sL1KIVJFOVggTjTC///aW0z+d3tTCLV5DE0Tizt53sxONmllzaTrm
 kLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226176; x=1707830976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFP5iyTPjpV1cEOb71+konTscrwLFnQ2qPt+jzXrQdw=;
 b=E+jGavqOh7VFPucuBtpxRRHJGsPG5D/RwVm6mhO7O5kAE2OA8IhwXl7xc7wKGpihBO
 66sL8W5LQUIrGyxfxFeDm0vhD+NruSXgYXcCx9I5+iapUyXkBoBnHzmBgRJTeguyqsJe
 4tF/lHgXrl5wc4HRqM+00xFAdG0fZ0k3BG7ZnkK2C8Coj2cOHI2lnm1AjRbvzuDHiCnG
 mQ4ORWUybxn9C3qaesGkTVdeaGqf2b9DRB55yCMWuDzjo0OU8RNtlmku+N3pdL53vh/U
 6sPqY2nQTyKcQTc0cfMqFpDSaE0NWdx4by55q3EVr4JTF9w4ncSfgQWGa0GjBW0CHF62
 NfOA==
X-Gm-Message-State: AOJu0Yx9nQdQOz9NR2n/44fHqHDxSrF5tMIlXoma1eBPeZKo94KCLSUS
 RONPwH3BvfdcCyJwlb5ANr9trBnYQLiNJCc3/yUrMArPOYsnnuGNNnJWFkgZGGA=
X-Google-Smtp-Source: AGHT+IEUPdsObKq4krLuGIK1SubBfL2QYoaVAa2UWG7J78QQxtGu0zUgFBi+wyeQvfHL16n2yb6iiA==
X-Received: by 2002:a5d:4a45:0:b0:33a:e6dc:2e98 with SMTP id
 v5-20020a5d4a45000000b0033ae6dc2e98mr1432613wrs.5.1707226175753; 
 Tue, 06 Feb 2024 05:29:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWDHAyClWhqwpDk43/Uy2geWAjD3CIEjPD2lJLDxzqg4gGZ2UoKx+LP5Lsbr6B2KgM4Rw6AqU4lc+gV6+cybMUXDFYN4JE=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/13] hw/misc/mps2-scc: Make changes needed for AN536 FPGA
 image
Date: Tue,  6 Feb 2024 13:29:25 +0000
Message-Id: <20240206132931.38376-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The MPS2 SCC device is broadly the same for all FPGA images, but has
minor differences in the behaviour of the CFG registers depending on
the image. In many cases we don't really care about the functionality
controlled by these registers and a reads-as-written or similar
behaviour is sufficient for the moment.

For the AN536 the required behaviour is:

 * A_CFG0 has CPU reset and halt bits
    - implement as reads-as-written for the moment
 * A_CFG1 has flash or ATCM address 0 remap handling
    - QEMU doesn't model this; implement as reads-as-written
 * A_CFG2 has QSPI select (like AN524)
    - implemented (no behaviour, as with AN524)
 * A_CFG3 is MCC_MSB_ADDR "additional MCC addressing bits"
    - QEMU doesn't care about these, so use the existing
      RAZ behaviour for convenience
 * A_CFG4 is board rev (like all other images)
    - no change needed
 * A_CFG5 is ACLK frq in hz (like AN524)
    - implemented as reads-as-written, as for other boards
 * A_CFG6 is core 0 vector table base address
    - implemented as reads-as-written for the moment
 * A_CFG7 is core 1 vector table base address
    - implemented as reads-as-written for the moment

Make the changes necessary for this; leave TODO comments where
appropriate to indicate where we might want to come back and
implement things like CPU reset.

The other aspects of the device specific to this FPGA image (like the
values of the board ID and similar registers) will be set via the
device's qdev properties.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/mps2-scc.h |   1 +
 hw/misc/mps2-scc.c         | 101 +++++++++++++++++++++++++++++++++----
 2 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
index 3b2d13ac9c3..8ff188c06b1 100644
--- a/include/hw/misc/mps2-scc.h
+++ b/include/hw/misc/mps2-scc.h
@@ -51,6 +51,7 @@ struct MPS2SCC {
     uint32_t cfg4;
     uint32_t cfg5;
     uint32_t cfg6;
+    uint32_t cfg7;
     uint32_t cfgdata_rtn;
     uint32_t cfgdata_out;
     uint32_t cfgctrl;
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 02a80bacd71..18be74157ee 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -37,6 +37,7 @@ REG32(CFG3, 0xc)
 REG32(CFG4, 0x10)
 REG32(CFG5, 0x14)
 REG32(CFG6, 0x18)
+REG32(CFG7, 0x1c)
 REG32(CFGDATA_RTN, 0xa0)
 REG32(CFGDATA_OUT, 0xa4)
 REG32(CFGCTRL, 0xa8)
@@ -62,25 +63,46 @@ static int scc_partno(MPS2SCC *s)
 /* Is CFG_REG2 present? */
 static bool have_cfg2(MPS2SCC *s)
 {
-    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547 ||
+        scc_partno(s) == 0x536;
 }
 
 /* Is CFG_REG3 present? */
 static bool have_cfg3(MPS2SCC *s)
 {
-    return scc_partno(s) != 0x524 && scc_partno(s) != 0x547;
+    return scc_partno(s) != 0x524 && scc_partno(s) != 0x547 &&
+        scc_partno(s) != 0x536;
 }
 
 /* Is CFG_REG5 present? */
 static bool have_cfg5(MPS2SCC *s)
 {
-    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547 ||
+        scc_partno(s) == 0x536;
 }
 
 /* Is CFG_REG6 present? */
 static bool have_cfg6(MPS2SCC *s)
 {
-    return scc_partno(s) == 0x524;
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x536;
+}
+
+/* Is CFG_REG7 present? */
+static bool have_cfg7(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x536;
+}
+
+/* Does CFG_REG0 drive the 'remap' GPIO output? */
+static bool cfg0_is_remap(MPS2SCC *s)
+{
+    return scc_partno(s) != 0x536;
+}
+
+/* Is CFG_REG1 driving a set of LEDs? */
+static bool cfg1_is_leds(MPS2SCC *s)
+{
+    return scc_partno(s) != 0x536;
 }
 
 /* Handle a write via the SYS_CFG channel to the specified function/device.
@@ -144,8 +166,16 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         if (!have_cfg3(s)) {
             goto bad_offset;
         }
-        /* These are user-settable DIP switches on the board. We don't
+        /*
+         * These are user-settable DIP switches on the board. We don't
          * model that, so just return zeroes.
+         *
+         * TODO: for AN536 this is MCC_MSB_ADDR "additional MCC addressing
+         * bits". These change which part of the DDR4 the motherboard
+         * configuration controller can see in its memory map (see the
+         * appnote section 2.4). QEMU doesn't model the MCC at all, so these
+         * bits are not interesting to us; read-as-zero is as good as anything
+         * else.
          */
         r = 0;
         break;
@@ -164,6 +194,12 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         }
         r = s->cfg6;
         break;
+    case A_CFG7:
+        if (!have_cfg7(s)) {
+            goto bad_offset;
+        }
+        r = s->cfg7;
+        break;
     case A_CFGDATA_RTN:
         r = s->cfgdata_rtn;
         break;
@@ -211,28 +247,43 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
          * we always reflect bit 0 in the 'remap' GPIO output line,
          * and let the board wire it up or not as it chooses.
          * TODO on some boards bit 1 is CPU_WAIT.
+         *
+         * TODO: on the AN536 this register controls reset and halt
+         * for both CPUs. For the moment we don't implement this, so the
+         * register just reads as written.
          */
         s->cfg0 = value;
-        qemu_set_irq(s->remap, s->cfg0 & 1);
+        if (cfg0_is_remap(s)) {
+            qemu_set_irq(s->remap, s->cfg0 & 1);
+        }
         break;
     case A_CFG1:
         s->cfg1 = value;
-        for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
-            led_set_state(s->led[i], extract32(value, i, 1));
+        /*
+         * On most boards this register drives LEDs.
+         *
+         * TODO: for AN536 this controls whether flash and ATCM are
+         * enabled or disabled on reset. QEMU doesn't model this, and
+         * always wires up RAM in the ATCM area and ROM in the flash area.
+         */
+        if (cfg1_is_leds(s)) {
+            for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+                led_set_state(s->led[i], extract32(value, i, 1));
+            }
         }
         break;
     case A_CFG2:
         if (!have_cfg2(s)) {
             goto bad_offset;
         }
-        /* AN524: QSPI Select signal */
+        /* AN524, AN536: QSPI Select signal */
         s->cfg2 = value;
         break;
     case A_CFG5:
         if (!have_cfg5(s)) {
             goto bad_offset;
         }
-        /* AN524: ACLK frequency in Hz */
+        /* AN524, AN536: ACLK frequency in Hz */
         s->cfg5 = value;
         break;
     case A_CFG6:
@@ -240,6 +291,14 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
             goto bad_offset;
         }
         /* AN524: Clock divider for BRAM */
+        /* AN536: Core 0 vector table base address */
+        s->cfg6 = value;
+        break;
+    case A_CFG7:
+        if (!have_cfg7(s)) {
+            goto bad_offset;
+        }
+        /* AN536: Core 1 vector table base address */
         s->cfg6 = value;
         break;
     case A_CFGDATA_OUT:
@@ -353,6 +412,24 @@ static void mps2_scc_finalize(Object *obj)
     g_free(s->oscclk_reset);
 }
 
+static bool cfg7_needed(void *opaque)
+{
+    MPS2SCC *s = opaque;
+
+    return have_cfg7(s);
+}
+
+static const VMStateDescription vmstate_cfg7 = {
+    .name = "mps2-scc/cfg7",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cfg7_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cfg7, MPS2SCC),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription mps2_scc_vmstate = {
     .name = "mps2-scc",
     .version_id = 3,
@@ -372,6 +449,10 @@ static const VMStateDescription mps2_scc_vmstate = {
         VMSTATE_VARRAY_UINT32(oscclk, MPS2SCC, num_oscclk,
                               0, vmstate_info_uint32, uint32_t),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_cfg7,
+        NULL
     }
 };
 
-- 
2.34.1


