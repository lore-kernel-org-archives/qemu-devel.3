Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B693BFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiR-0005Na-Nu; Thu, 26 Feb 2026 10:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiP-0005Lc-6k
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiM-0003kr-Lg
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4398d1f06caso961964f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121345; x=1772726145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9JJmQIaiVFL0Mge03bSjQhlB7hltQcjiAuFGOTxguH4=;
 b=c6NyRxMqRJZQ+fA1Z6G7mo/lZ0GEQb7DdOzxno2hXvp2x9bvMxBSNlYsvz1bSOojY7
 MAvZm4reG+JUt71u1PGcFakYrzgP8/qhP0aN54L4EoOxVrM4yRXH4tT+sBrreXtGQiU9
 gLdYXYQeu1VvlUd602Uwjf50a7kQ+q/Q3Fj7FgKkIMzomhqNc7UfEkPZKZDFF7Fnxk0q
 Vuh2Isq2ynGC4xZegWTjN/yKK1KvbylmeRwsNnvDa+bKXtGEb1rk93p8NNwALSlHlMPa
 BKcpebC6ETbBKUYkHO6KKX9yZr31buXenYclyiHwHFAsm+Bfg7UmcXKPFGKoYmYgnfjO
 uxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121345; x=1772726145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9JJmQIaiVFL0Mge03bSjQhlB7hltQcjiAuFGOTxguH4=;
 b=ba/tkFer9u9ajCLgo7BnSjsIXHUqb2CKOibxqIVUdxUZAMmXUkuo2199CmLBth4WNb
 Mka29t19xaq2qY3sETb6r3p1mdwOI9MgL6dJV/hIVJb8zQWExbPsMjSgs3htDYl9ONlz
 lJTBdieciA23hLaCiHCK7vlZgqc2MJyoCfBowJU3S+mslNvDZOHdPPWyUHBPjTwclEUU
 jReXB9/02lUM2TySgWzuVKUXNHHn9SQ7uuvMpxtKGse13/HaKSV8/c37aaiugDP33tkq
 9Y8fF170jj0BEltivHP1Zlp1kmL9c8eO0e0xsfHfpajtNKg0ZWs//nuIjfd22VwGbcFM
 UXrw==
X-Gm-Message-State: AOJu0YzlfMccLwaEkBvDW626q5NotdCxe75NssuNy0V1NJg9gfKw+B6K
 cB6fjW+EFtBy8mHQwi744It6U4WlJD7/WVE8DybXFATaYZxQIOALu36FKAq12roZ4FejGbd3ZKu
 OwL8x
X-Gm-Gg: ATEYQzxJBviGD3/JQDpCbsDodCiU4AWOYncszJCFhM4pbBIfyhaBhyZBe3CJHAkJE6R
 8hK5fU7gsSRPVMpUtcWEKvSTF8alRv5gTRfzE6gZR8BhChpzMgmI+vvzVVLLIj4Onjta52HZtlZ
 vxilsm82gmuE3BN6Mi17+wXAKIgin7hPDyrgvtwG7rL+YXXlapkFEkxZoKAT1Z1JE2fGnRVsCTt
 Z3yikFWkVRtYu9Odn+HNlC12f4DYSb6MqKxzOT21VsRQv8655MmFv8OI/YlEWB6WZ/+9+4f5o9S
 6s68R2uRQ/NgVKPPZ2P8P8sHseHizy1xVDb5yDHoqmLgsHvD482d9ASGgpF7hQD3jTSIlM2GSBI
 6Wgp1El9QFLGWq9Hv7L6uXP1OhTiHfz10j6WeOmId0sShTZvQrSm3tcngKGcPR35QXEiIIeUsFC
 0uQuCCWWIulGVTME0Q//mlbD2ulVAqg0TemSRBAbi7c20b3uamPGAeVehJ+zr4qp8r81Gtu2Hmj
 9ss+rdl8xAOBbrEIMaGXkJvOha6Y6I=
X-Received: by 2002:a5d:64c9:0:b0:436:8058:452 with SMTP id
 ffacd0b85a97d-439942f2c8fmr9772213f8f.44.1772121345026; 
 Thu, 26 Feb 2026 07:55:45 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] Revert "target/arm/hvf: Sync CNTV_CTL_EL0 &
 CNTV_CVAL_EL0"
Date: Thu, 26 Feb 2026 15:55:22 +0000
Message-ID: <20260226155535.1171290-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This reverts commit bfbea371ef2cabc47effac5a286e2644d727a8d6.

This commit breaks VM save/restore:

Assertion failed: (b), function hvf_arch_get_registers, file hvf.c, line 667.
zsh: abort      ./qemu-system-aarch64 -m 8192 -M virt,accel=hvf -cdrom  -device virtio-gpu

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Tested-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1b19d9713e..d79469ca27 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -200,9 +200,6 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
-
-#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
-#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -505,7 +502,6 @@ int hvf_arch_get_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
-    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
@@ -635,16 +631,6 @@ int hvf_arch_get_registers(CPUState *cpu)
 
     aarch64_restore_sp(env, arm_current_el(env));
 
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
-    assert_hvf_ok(ret);
-    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
-    assert(b);
-
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
-    assert_hvf_ok(ret);
-    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
-    assert(b);
-
     return 0;
 }
 
@@ -656,7 +642,6 @@ int hvf_arch_put_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
-    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -771,16 +756,6 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
     assert_hvf_ok(ret);
 
-    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
-    assert(b);
-    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
-    assert_hvf_ok(ret);
-
-    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
-    assert(b);
-    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
-    assert_hvf_ok(ret);
-
     return 0;
 }
 
-- 
2.43.0


