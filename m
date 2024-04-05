Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20442C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 18:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsntt-0004m7-UD; Fri, 05 Apr 2024 14:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsnts-0004l1-2h
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 14:02:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsnti-00021w-CR
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 14:02:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-415515178ceso18103045e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712340154; x=1712944954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m0U4uFdOEq535ExzLiuM9D+YMI23y51gRPpkAZoBeQM=;
 b=tCZxeyXrB/D96e+4a3R6d6ept1RCRGpMMY5P8Qa3+XWu+mK25RdM9MebC1UT2PG8qF
 Kj4uzsj5RaIvyOn+BC6f8/BsycE2KKAc5aLHyKxE6pgFWKCMdYePTyr53KpjL7lNddaz
 2n3hm7B6AjK3Q5em6hreF/s0vwD0dqzIARLW7e/A6L6AFXVBGXAa8Z9rDGEZw6/Yy+kd
 nTGiNfIHUmGO4SWvsD7Ktp/COJLYkjAcY4xT4ulY8M1oky0W7jufl8qwQB/ik3kt92pn
 wK4ictKnF+KswWJAZU0CrLCNva97x8/BBJObK95p9cc5cjhZRCYw5utSmk+6Wv6nb59o
 wDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712340154; x=1712944954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0U4uFdOEq535ExzLiuM9D+YMI23y51gRPpkAZoBeQM=;
 b=YN4LFGgZXFC9IcZm2snPLnIppAN+88AFZXy2QrOyyiy49JdnCNUWWJp0qwREh12o3F
 nz2xjtk1n3FANt5aZKg9prfNndlFR1f6nOQNNuIetdomJTcV6+dTuh7lMdhQ20dI5zEp
 GOXnkM6Q/eiApKjucAUk6ICUcn5d1bv1scxTSEoOIbUJTekDhWnhUvSkNbEwAOC1ogGH
 F+Aq+7sr8yEuDMpnjulaZl1BpRWS3kZuhA/ulUhSbW7XTQpAVS8urlCOVJ/dl2bw3n5a
 jYdP9BQRdiHy8NdR/2o8sMxfo2FQ54D/gSbm/IqZi3TkrqBDGFfkhD/6IokecU+Nyn9D
 wjig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXLjcLCDSjMAhAZgQyVVIe/HZeWv5w29MNoUef5BQtn1l1NA6HeOranl+0qvNqgMz+tgojhUdPTi93ezadbqu/pjCwQqo=
X-Gm-Message-State: AOJu0YzgC1tX6Owz2hbaFsHRoIBlSnMA2V3+1Bj9GNSJN1vHDH/fXkBi
 +BaNvdpIh23zYb05HIbCWNUikoFNoxciWJqkuV+wpCj+T9bU4M1wRmxAmzoBwMg=
X-Google-Smtp-Source: AGHT+IGc4iV9+knKMnfXJUMSoj7jSZwdVAJtC+XoRC4rxYn5A/VZIiyey68D3sC+HdbAn5CjjvavIg==
X-Received: by 2002:a5d:56d1:0:b0:33e:8ba7:e53d with SMTP id
 m17-20020a5d56d1000000b0033e8ba7e53dmr1736654wrw.7.1712340154123; 
 Fri, 05 Apr 2024 11:02:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a056000136d00b00343e3023fbasm2265751wrz.34.2024.04.05.11.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 11:02:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH for-9.0] target/arm: Use correct SecuritySpace for AArch64 AT
 ops at EL3
Date: Fri,  5 Apr 2024 19:02:32 +0100
Message-Id: <20240405180232.3570066-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When we do an AT address translation operation, the page table walk
is supposed to be performed in the context of the EL we're doing the
walk for, so for instance an AT S1E2R walk is done for EL2.  In the
pseudocode an EL is passed to AArch64.AT(), which calls
SecurityStateAtEL() to find the security state that we should be
doing the walk with.

In ats_write64() we get this wrong, instead using the current
security space always.  This is fine for AT operations performed from
EL1 and EL2, because there the current security state and the
security state for the lower EL are the same.  But for AT operations
performed from EL3, the current security state is always either
Secure or Root, whereas we want to use the security state defined by
SCR_EL3.{NS,NSE} for the walk. This affects not just guests using
FEAT_RME but also ones where EL3 is Secure state and the EL3 code
is trying to do an AT for a NonSecure EL2 or EL1.

Use arm_security_space_below_el3() to get the SecuritySpace to
pass to do_ats_write() for all AT operations except the
AT S1E3* operations.

Cc: qemu-stable@nongnu.org
Fixes: e1ee56ec2383 ("target/arm: Pass security space rather than flag for AT instructions")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2250
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I guess most people don't run guest code at EL3 that does AT ops...

 target/arm/helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f3a5b55d4a..0af4ce2e8a7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3878,6 +3878,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMMMUIdx mmu_idx;
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
+    bool for_el3 = false;
+    ARMSecuritySpace ss;
 
     switch (ri->opc2 & 6) {
     case 0:
@@ -3895,6 +3897,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_E3;
+            for_el3 = true;
             break;
         default:
             g_assert_not_reached();
@@ -3913,8 +3916,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         g_assert_not_reached();
     }
 
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type,
-                                       mmu_idx, arm_security_space(env));
+    ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
 #else
     /* Handled by hardware accelerator. */
     g_assert_not_reached();
-- 
2.34.1


