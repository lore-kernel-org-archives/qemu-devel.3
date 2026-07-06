Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9610C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggih-0007Ft-MG; Mon, 06 Jul 2026 06:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiY-00078h-NO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiW-0003Sz-GX
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-493b779003fso14039525e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334303; x=1783939103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ao1n9F78AUEbECsnjWogvFkJsCih/kQbcPL26IQqPqc=;
 b=chKQ/NfVVmm0FyNk8hXj56COh55SVPzGDDBCIzdVe7MVCseHHGQHEUcoq/KzOJVBOk
 DXew9k9ic2c3MEl5HBt2JoD01vzTqQi7wWLOP9oTblXXe5pwfpdML9e2SKRJC5rG6EY/
 4/vTV56Oa24DUJOoc8cv6ELAqqVX4H8LPn16y/6KV+0uI9kYEktn8HCmSDyku36oEURf
 TXIy5f7H5kca76dNoQEMXPvarnpNbuXkdszyLGxkSPWT/1oyWgzIE3wtsxhWVqtdG8C0
 cSvnDJE1aKSh5KrRwQEEl1HXmjc32voM4/RVv0GKSKb0mgGdHwgCIXk//OrCiQ9Nvags
 ZFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334303; x=1783939103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ao1n9F78AUEbECsnjWogvFkJsCih/kQbcPL26IQqPqc=;
 b=Jx38pccQSyCsNud4+78x93meYTkSIKY7Ul728FqPkAQb9h9394cwy5SQt2A/r/LUeu
 69yymgRO0/y74gSfzJn0npEKxhaQYb0/cVwgoerEKL+RX3DjlO8n8uAvYEhHc2ZEVrct
 bsm9tN/6e1ov2VuvJXxQdNc7Kl7zaAI9tpy6mEloXNfHjivBw8dXgVpO0a2LEBHK/7Wo
 vsWRY7mx6T4TcflgcNAnbO7EvFN/xFNjnbKWmk7+xhs++qRnyYpVjZhCuyUY8zXto2VH
 Xp5W3IAj8zNe4SzaX8q4g+ICoJ5crPzTqv5bT9Ni4gWIWxbiCjYgxQLHMqbNFPHdpt2N
 zAPQ==
X-Gm-Message-State: AOJu0Yx9yTSdHwE+y13xUS3ASUrY3HoDLALFEtffaPSdg/kIp2u752Uc
 1NYNbHRcJgf6tiVJ7DHLZyt5BBZ74wq9/HYZ3YeRBWaZ6XSqKdNyyZr3peDxxwzJu+0pzRIQmjm
 pt2Gx4pWSIpSj
X-Gm-Gg: AfdE7cnBqI4oPfeKuZeGTe01Ur0nfy5GRlhuc7BOd8hZ8KECLHZIIVmIzujKczJb1gx
 589/y9EqbwrUBoe8Oj8wIeoT2ULqlxLfjTiIuPnFn7gKqXvmayGSz4KC67QQikCoktJ9dLhU/Yt
 lLo54iosQhUpeJCaQr1IE1m7tK/uslLREb4SrxCvRNgNHqRZa2N8EF2OQ7Z4C60vD2cCors84ZK
 VF2cirVpVgi2kPJwj5TYphEclSMw3NVAg9IB+J3ShJI6z7JiwGoHNuyjBnyw2X49TFdDEkd0INU
 Wz8y9ci6vok+JrHT/UDUFguFtas/sv1RjY16b4lZfFkfMHqANTAB3yl8+6inDRClp5SPaZpMw/J
 Tnu8PUCPlN4JaN+EkDJR6l9khpgJN7qipcfOl4AOh0ttWAO3n1FA/PfxddJ385QdiihEq8MBRWT
 A5QQtUc6rSF2kAJSvhy+iUFM4SSy6xhh8E8dlfsB2Wz7UIFmVE7+iK6ao9okpjCUZWlr8g6507l
 gy46K2j3dpaPYRXGLauQA==
X-Received: by 2002:a05:600c:c4a6:b0:492:70f4:8d1e with SMTP id
 5b1f17b1804b1-493d526d4admr79862905e9.11.1783334303018; 
 Mon, 06 Jul 2026 03:38:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/49] target/arm/hvf: seed NO_RAW ID registers from
 isar.idregs[] on vCPU init
Date: Mon,  6 Jul 2026 11:37:29 +0100
Message-ID: <20260706103752.320511-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

From: Jason Wright <wrigjl@proton.me>

Commit 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
gave ID_AA64ISAR0_EL1 a readfn so the RNDR field can reflect SCR_EL3.TRNDR
at read time, and marked the cpreg ARM_CP_NO_RAW in the system-emulation
path.  HVF then trips its hvf_arch_init_vcpu() assertion that no ID
register in hvf_sreg_list[] is NO_RAW, aborting on boot on Apple Silicon:

  Assertion failed: (!(ri->type & ARM_CP_NO_RAW)),
  function hvf_arch_init_vcpu, file hvf.c, line 1441.

Reproduce with:

  qemu-system-aarch64 -M virt,accel=hvf -cpu host \
                      -nographic -display none -bios /dev/null

Fix it the same way ID_AA64PFR0_EL1 already is: list
HV_SYS_REG_ID_AA64ISAR0_EL1 in the SYNC_NO_RAW_REGS block in sysreg.c.inc
so the assert loop skips it, and seed the vCPU's copy at init time.

While here, unify how the three isar.idregs[]-backed ID registers are
seeded.  isar.idregs[] already holds QEMU's intended value for each (the
host caps, probed once at realize via hv_vcpu_config_get_feature_reg(),
plus any QEMU adjustment), so there is no need to read each register back
from the vCPU first.  Seed PFR0, ISAR0 and MMFR0 directly from
isar.idregs[], dropping the two per-vCPU hv_vcpu_get_sys_reg() reads:

  - PFR0: take the GIC sysreg-interface bit from env->gicv3state, as the
    id_aa64pfr0_read() readfn does.  Identical to the previous code
    whenever a GICv3 sysreg interface is present (the configuration HVF
    runs in practice); it differs only in that a vCPU with no GICv3 now
    reports ID_AA64PFR0_EL1.GIC == 0 instead of inheriting the host's
    value, which matches the field's meaning.
  - ISAR0: no overlay is needed; HVF does not expose EL3, so
    SCR_EL3.TRNDR is never set and the readfn is constant.
  - MMFR0: still clamp PARANGE to the chosen IPA size, updating
    isar.idregs[] in place because the page-table walker and the
    ID_AA64MMFR0_EL1 cpreg resetvalue read PARANGE back from there.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3533
Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
Signed-off-by: Jason Wright <wrigjl@proton.me>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 10 ++++------
 target/arm/hvf/sysreg.c.inc |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b902c6882..6310cfaf3e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1478,20 +1478,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->mp_affinity);
     assert_hvf_ok(ret);
 
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
-    assert_hvf_ok(ret);
+    pfr = GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
     pfr |= env->gicv3state ? (1 << 24) : 0;
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
     assert_hvf_ok(ret);
 
-    /* We're limited to underlying hardware caps, override internal versions */
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
-                              &arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR0_EL1,
+                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0));
     assert_hvf_ok(ret);
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
-                              arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
+                              GET_IDREG(&arm_cpu->isar, ID_AA64MMFR0));
     assert_hvf_ok(ret);
 
     if (!hvf_irqchip_in_kernel()) {
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index c11dbf274e..acd5a41364 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -89,13 +89,13 @@ DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 2, 0, 0, 2, 0)
 DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 3, 0, 0, 0, 0)
 DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 3, 0, 0, 0, 5)
 DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 #endif
 
 DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 /* Add ID_AA64PFR2_EL1 here when HVF supports it */
 DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 
 #ifdef SYNC_NO_MMFR0
-- 
2.43.0


