Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D09AFF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLT7-0004Nq-Cq; Mon, 27 Apr 2026 08:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNo-00084h-W5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNi-0005fe-3C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso142334585e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294085; x=1777898885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=blK/QB0ifCOHjFFZaugJe65T2S2vwxgGyAYmHanyIto=;
 b=a1wFQ2RlqLH1abMMQZGcJlsVqcNt3PzxQ3LZdIbuwkTq5NkNYfIkTduWPo2aOcpPFt
 l4AKP8G3SkwRKLEeFsN0DteX/sl59MUZUAGmzOt8H+lIogJwLaXJWV/5kNE49YpBal57
 KqD+kpaB5/HDVRYzxoAPJkLPRydmlojAdguA5ZMNOf2Gvlf8sJlaTGc9ieuo/J/pS6wH
 Pg+xgt3nqjdqJcpngUN5c89FxxYWyU26u96YbJ+/WpgvY4lBsuJ5y5J859aXsX9wAivH
 x73gfkQg7E0ZXblIUCUyh/mVOqZLoTJy8zTMFKCEpkjJ7LNCKCoU2MjkIxB0KoQNQl2B
 SSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294085; x=1777898885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=blK/QB0ifCOHjFFZaugJe65T2S2vwxgGyAYmHanyIto=;
 b=GMa4AwF+mkPEOMW7sxFa2CViCmQK2ORwcPi/ihjmRbmA0rQ7tFU0JruoKX2QVa9ngK
 63cqOYtsujrB6n82Hb8cuLIyLJC7jT5Vc9uWo40dUU+RUTkmkRxNcL6gZOFNBm3+EXaF
 GZn5LX5sE7jGLZm8gMYble2NFOCamkc5NLJoN/5nXkEDkOlgS2PBLa5wX2YdapymQUEj
 fFYMBLIaghyz9BS2BrFsIOhdEERyp146hoC9eaCsaT7mTsW/5BaXSR1FUGlVERuLTcFL
 n5VTBETtMbHI0P5THbrwOryN2J+SpgrUfYlpMTzMQCEuMvQuODtEeTA9oXNJwswSF6Ri
 MPBA==
X-Gm-Message-State: AOJu0YwZr0KA+MR5hPZg6bgl1slciQ5XH4ESp1yui3AUFFlBDwdkjcCr
 EMTfEHMw5nzG0p3f7Hzi6blIgD/iE+nRQsXbZuYasQxxoVZ3HBqDn8Xu5fq1qgHZI8hpAFO+xtU
 W/KBK
X-Gm-Gg: AeBDies/CPNszLhUARSwpbgJovtXKyc2nArx0kZJjxlNgzAy2+ipBxYh+l2djFs7AOs
 WNfqwYAC5noUft95e798jviu50/mgavAHwxkvOqte6CAO9Y/Gqii1xpoMg6PmyV8dvHf5vOSZgv
 3Qt7RD9yEx9L3f8xbHVVQ1v439/hxdwyz8cYF162iv2WARjIJXqh12gtyHEaCO0LPpWZhJbKg9c
 RILmNs7mE7dxay0BJS8PFNIC0BUUgIrUvg4Zh/TfaLljoNrPGeW2g0VXATE05lVf3qpU//6nThf
 jWzFLclw00xINY4esfEVigG0tjf8uPN71rqryb27fltqiGK7lCJ0hpy7FMX3w7Oq4RGrXS7lKNg
 zq46wqCDhJQTaQiwlsA480px8UqH/5hObmHUr8x6jmKLDow7CikzCxt6yKPyAqfEoTTbusIq38e
 bPccbVOvUB8LK8MsjJzbF8YBBFzpL2O5E8A4ig6CZJVNHm4zVp1I2vOJeqtyQv1G6zDxV3q81Q2
 8NcIv+ZdazvVbnEyJ8BYY4OFsnaT8AZuTqrkw8fpw==
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-488fb7844c5mr655106685e9.27.1777294085364; 
 Mon, 27 Apr 2026 05:48:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/63] target/arm: Clear AArch64 ID regs from ARMISARegisters
 if AArch64 disabled
Date: Mon, 27 Apr 2026 13:47:02 +0100
Message-ID: <20260427124738.966578-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

If we create a normally-AArch64 CPU and configure it with
aarch64=off, this will by default leave all the AArch64 ID register
values in its ARMISARegisters struct untouched.  That in turn means
that tests of cpu_isar_feature(aa64_something, cpu) will return true.

Until now we have had a design policy that you shouldn't check an
aa64_ feature unless you know that the CPU has AArch64; but this is
quite fragile as it's easy to forget and only causes a problem in the
corner case where AArch64 was turned off.  In particular, when we
extend the ability to disable AArch64 from only KVM to also TCG there
are many more aa64 feature check points which we would otherwise have
to audit for whether they needed to be guarded with a check on
ARM_FEATURE_AARCH64.

Instead, make the CPU realize function zero out all the 64-bit ID
registers if a TCG CPU doesn't have AArch64; this will make aa64_
feature tests generally return false.

We only do this for TCG because only TCG really needs it, and for
KVM it might be confusing to have QEMU's idea of the ID registers
be different from KVM's.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260416165353.589569-2-peter.maydell@linaro.org
---
 target/arm/cpu.c | 35 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h |  3 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b62de8addf..6705ee9db7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1606,6 +1606,27 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
     }
 }
 
+static void arm_clear_aarch64_idregs(ARMCPU *cpu)
+{
+    /* Zero out all the AArch64 ID registers in ARMISARegisters */
+    SET_IDREG(&cpu->isar, ID_AA64ISAR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR3, 0);
+    SET_IDREG(&cpu->isar, ID_AA64DFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64DFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64AFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64AFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
+}
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1733,6 +1754,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
+    /*
+     * A TCG aarch64=off CPU has no AArch64 at all, so we clear out the
+     * ID registers to avoid cpu_isar_feature(aa64_something, cpu) tests
+     * incorrectly returning true. We don't do this for other accelerators
+     * (which in practice means "for KVM", since no others have AArch32
+     * guest support) because from KVM's point of view the AArch64 ID
+     * registers still exist and must have their correct values. So we
+     * avoid clearing them out so that we don't have QEMU and KVM with
+     * different ideas of the ID registers.
+     */
+    if (tcg_enabled() && !arm_feature(env, ARM_FEATURE_AARCH64)) {
+        arm_clear_aarch64_idregs(cpu);
+    }
+
 #ifdef CONFIG_USER_ONLY
     /*
      * User mode relies on IC IVAU instructions to catch modification of
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..ab6bacf4aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1080,7 +1080,8 @@ struct ArchCPU {
      * Note that if you add an ID register to the ARMISARegisters struct
      * you need to also update the 32-bit and 64-bit versions of the
      * kvm_arm_get_host_cpu_features() function to correctly populate the
-     * field by reading the value from the KVM vCPU.
+     * field by reading the value from the KVM vCPU. If it is an AArch64
+     * ID register then you also must update arm_clear_aarch64_idregs().
      */
     struct ARMISARegisters {
         uint32_t mvfr0;
-- 
2.43.0


