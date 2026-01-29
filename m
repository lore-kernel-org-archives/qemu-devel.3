Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBC9D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb1-0001TC-IO; Thu, 29 Jan 2026 11:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUau-0000xF-Me
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:08 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUas-00075F-Vi
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:08 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so733451f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703005; x=1770307805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VWa2vbvC4oNt+Jo6t0zGuSn96CV4yI+L2pkpAeUn8YY=;
 b=gKVW7aRHjq2x2X+cjjX+2tP4aIVruoGl7CCfwptp+lycEFV+OcnHB+smewLF58Aa9T
 Rhnf7KtsRzHHxacUgtTZJac4uv0Cp+Epz5M66bqDg4avdXDaAwaHzqmnXgtxoS5JbZ9I
 tuuetnHKJmPPikNc1I1xbB0QkHqsHeFUrC4DkqzDEVu/+7qepFe93Zz1viD57iaZAZms
 NffyHdy5nYe20zgyDG0Ch6BQk8a3eRYstcIRsGq+RrmJeNVF5r4nevy6tC7F/Y+FKG5a
 t9Ey51Iyq8svX6hxqSwNZ/7qgokj8qfm6nCduxAlYqKp2wgvyfVRX6S0YxCsBw6ZqhpW
 q6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703005; x=1770307805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VWa2vbvC4oNt+Jo6t0zGuSn96CV4yI+L2pkpAeUn8YY=;
 b=SxWZjCbIwA4373ELepcKmMoX528cdBEl0lZXQvY81m+M/jkKalMqxfCJum5NOSKN18
 AFUA7mqhzAc981SNT5zxBHXQfKQJi6UeU0ipb5p9PWA7ntNzGOsPKGMZleGb60QewRtp
 XZ4me/cezi/n3DYpvDw4O5vSg7cAD4ePObOaTO1SUEPwo74HmMBp/b2M8cEbFOKTrfMI
 sPU7HcYdPoO3t20s//Ylb1W9yJ3rSZzmy9GsYC0a30mbhmdfGHoO07tOQ5BqLCrTLCnU
 gBoJnwRsa0/iUw0o/ACo1cngu6/A/eLrnpolS5eobNEH0qB/6my5D1BR3yTcuwtNk65I
 dKEw==
X-Gm-Message-State: AOJu0Yx59ciXrYi4qS0EGNdnavDrj7ax5pCb5rSlL3tzwOgiHQaAc21m
 lCdZly0SKN+iv4lRcg+DhMEcVY5zncJRHOOVWkWdSx/s52boZevBNBcKuRDnu/BgtXPxoy1Y6Mp
 nEn+AFvA=
X-Gm-Gg: AZuq6aJPqrmB42j0/4xA23JnYujFaKO43yK1hRNZXla3mn08P1A4hv3hlJ86CwLiyVY
 qKP8WQ6dZTZHzb3xBEY6OOGLkXBUkVMOX5teea/VIRCln5qBoe+XKDJ1hXz8wrVf0uE+CMy3xBQ
 07NVf+Qxf3aAOk68PkSXAEvR0YGirufphwQHbB8S00cWFJvEbGNTiIyIiEnitBKcvg7BZf/YCS/
 bO3sYjacfiFfhuuD2Tn/AFHK17mPEKmZVCZRaIL7kdN8/JBGnE7HvDij2ppEmc+SNC4hZ9ixKzt
 0cki0J/CopfQelBHhMJMTkXzztGw0WwmKZXdo5HELaCiSQINq3uRUDyN5CvUaO834s9frymfnW2
 maxno5MrKpqm1QK9AviDZhFQZn6Z9jKNNAQqModYX4AvQLnOf26mv9sQ/stDHR14SjlpKNcI7Hm
 0PH9BA6uoh9HFAOcgsFL2XjmjuAiITuA==
X-Received: by 2002:a05:6000:3103:b0:435:dbbe:1130 with SMTP id
 ffacd0b85a97d-435f3a6ca95mr206198f8f.11.1769703005251; 
 Thu, 29 Jan 2026 08:10:05 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/43] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Date: Thu, 29 Jan 2026 16:09:13 +0000
Message-ID: <20260129160917.1415092-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
host hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20260118215945.46693-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fcb7fa3b30..9ce720793d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+
+#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
+#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -502,6 +505,7 @@ int hvf_arch_get_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
+    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
@@ -631,6 +635,16 @@ int hvf_arch_get_registers(CPUState *cpu)
 
     aarch64_restore_sp(env, arm_current_el(env));
 
+    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
+    assert_hvf_ok(ret);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
+    assert(b);
+
+    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
+    assert_hvf_ok(ret);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
+    assert(b);
+
     return 0;
 }
 
@@ -642,6 +656,7 @@ int hvf_arch_put_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
+    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -756,6 +771,16 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
     assert_hvf_ok(ret);
 
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
+    assert(b);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
+    assert_hvf_ok(ret);
+
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
+    assert(b);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
+    assert_hvf_ok(ret);
+
     return 0;
 }
 
-- 
2.43.0


