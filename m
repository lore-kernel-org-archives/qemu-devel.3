Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEED6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYd-0002am-6o; Tue, 26 May 2026 16:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYI-0001eY-76
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYF-0007sN-OT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so43548155e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827937; x=1780432737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdQzEExd/6XIarCtGNcCUUBNB/7ENhjoxJyVnv6NZlA=;
 b=rjEG98SFKcxB7Gn5iakvtWLJB25R38piSkNbMIXye45G9K0BdVf0u36Cf/UH3VmcL/
 2eJxwax3a2RzyrUpZ5pSBZMkZKJBeDMI+lR4OILMBvevUMHIuoojKpNfeIPqxxB+tUso
 l4AKuDgBEiwCM5oo5qGt06JbU9lRaMWC7e4uTsAYdguQzIOScmrLyKm6Y11CeDlDbkX/
 E4WI06LsSsxnkmsv3mIEc4l42EAEtU3StBGkBfW7RkaloVxhe/k+s0XQLlUt2B+Xw44v
 MdwgOLBZR6N1D2MAJDbJ2gfVjpXsievT1KUdNCVbJlXUbZ/FcoY8ZpXlqRA0yB2SAL47
 uVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827937; x=1780432737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdQzEExd/6XIarCtGNcCUUBNB/7ENhjoxJyVnv6NZlA=;
 b=ngpyDhTxQSRMPFHJKNegpAUsS+HFUHScZstqbzg/AVTsvbwb21wjNu8S9OX5BCKodf
 wTgQhFW3Nvx1D3WiScz1GzO/srmjyp3undup6A6jooZm4WY+obvqbZLeQRT1mqITqRQL
 MuR9cCeHBQWiQjVj2ALLX1Fl4CMyfUsNHrVJmGJwyEJCec14n2NAQAJUTan1ancpHysE
 cA7dxhP/TcAc3/dXN7yp5kcVKjm5eE6CJc07Vn7guC4FZjjAMMz8e5YgxL1a9w58lgXk
 4FVfNfbFwTguSN24r3cmp8+4eekgMD0CHacEaq4MecQjPE/Zs6wfGRFP0RgAZxxNnqZy
 jseg==
X-Gm-Message-State: AOJu0YzOIlQWLkPlIUB9NWWftni7QTyr6o5qdGjAdKLVglLX4i3Ke18B
 VgeHRSuflDUob0KlUxdM+VNzO4lPc6k0rqgBm5oGyVrCgL+yQVmyLxo9alURjmW9JJlVgpzWrIi
 oWqvof3QQbw==
X-Gm-Gg: Acq92OF0L2xbSL8P0cLcLY1j1glkdJ58R2c+amY/aITUmpboAY6JmehWFxxhB2h2q0y
 Bsu1L/FqqFSwXBbEkKHxz1BN2EMpYXbW+w2u/hB9mPBI7/0MCG+u9R2mpyDrVqsZtwrWTHP4JSs
 YmY1KitofK5XNMKhOQpS0FXAlPEFeqIsru/OHcxJw8lT1Lcpmoy+phEMzi+1J9XwDDtXRPeQT68
 HNa0HNWfn+o5i1TzdxaurqgPWVJZU1yp2or71cguLV6qcNikPKbP2t9Zg2Fa+rUJaGKDHUrGtPL
 6QHoOQuva/aamSKCt/r+rsDDk2UdcGuGYZoc6X8aZQoTqWBV2XF10oUKY6oVggcJNVZgr/RZIZk
 gvcPLfuOTv3wH8bB80xUM10kVyig611i74yR9GbyHe78FoEbRFROlZjO7FotzOKbcCoXMeuacp3
 Wer2RF1o6l6whRlWX+dzVSW8TVzp+aK4tsr0Q6nsdBGlwwpt5R4gfjQ+Q=
X-Received: by 2002:a05:600c:8485:b0:490:5074:651e with SMTP id
 5b1f17b1804b1-4905074659bmr253456235e9.25.1779827936908; 
 Tue, 26 May 2026 13:38:56 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561f2dfsm332552445e9.12.2026.05.26.13.38.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 13/17] target/arm: Factor aarch64_aa32_a57_init() out
Date: Tue, 26 May 2026 22:37:18 +0200
Message-ID: <20260526203722.79463-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In order to make the following commit easier to review,
factor aarch64_aa32_a57_init() out of aarch64_a57_initfn()
as a preliminary step. We only add a %aa32_only argument
to restrict AArch64 features.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7b2f09cf8ec..7dce17fdb20 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -686,17 +686,20 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
     SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
 }
 
-static void aarch64_a57_initfn(Object *obj)
+static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
+    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    if (aarch64_enabled) {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -727,10 +730,12 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
-    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
-    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    if (aarch64_enabled) {
+        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
+        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
+        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    }
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -742,14 +747,21 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 2048KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    set_dczid_bs(cpu, 4); /* 64 bytes */
-    cpu->gic_num_lrs = 4;
-    cpu->gic_vpribits = 5;
-    cpu->gic_vprebits = 5;
-    cpu->gic_pribits = 5;
+    if (aarch64_enabled) {
+        set_dczid_bs(cpu, 4); /* 64 bytes */
+        cpu->gic_num_lrs = 4;
+        cpu->gic_vpribits = 5;
+        cpu->gic_vprebits = 5;
+        cpu->gic_pribits = 5;
+    }
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+static void aarch64_a57_initfn(Object *obj)
+{
+    aarch64_aa32_a57_init(obj, false);
+}
+
 static void aarch64_a53_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -886,7 +898,7 @@ static void aarch64_max_initfn(Object *obj)
     }
 
     if (tcg_enabled() || qtest_enabled()) {
-        aarch64_a57_initfn(obj);
+        aarch64_aa32_a57_init(obj, false);
     }
 
     /* '-cpu max' for TCG: we currently do this as "A57 with extra things" */
-- 
2.53.0


