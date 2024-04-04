Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12A6CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 17:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsR4v-0003li-D3; Thu, 04 Apr 2024 13:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ptosi@google.com>) id 1rsQ4m-0006ut-Bh
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:36:32 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ptosi@google.com>) id 1rsQ4k-0000SI-Ll
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:36:32 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso1903474a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712248588; x=1712853388; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl46i3DrBjDfPSGCGKqwQP2SynTZKyWMkmvHAmen0b4=;
 b=DnyI+FMf+xKGDr+/20DIyLDiytDCsBx4xP88oA+Ke0jWAo/xv2QmxipTzKa+dMXFN5
 //FKqNjYBEnepMhsLW64MNDvLDKrfvAL4Y38wff0ZVO3MhipdhoIrem7rpYZCbV3wb4w
 K3geyMi/qF87ghDR+uH6gJSb5p1YoWJeBabzzQhBi1OVuTMqXuqL5CHLm14dVJTh+lWi
 YjJ+0AAASPZwNTRVA2RnfF1nAQePPampsTzasAwnv2gl/EqnYoziWY4s0qrql8cBKCkE
 CdYO2Cs0FVCnxt58dtD3Pz9hMOBuOAjwUMWCmq5Nt3cCaY6JbMJzZ0P3j4twcvuTqGGM
 2GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712248588; x=1712853388;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rl46i3DrBjDfPSGCGKqwQP2SynTZKyWMkmvHAmen0b4=;
 b=g46yrL43/fnwMXQtqqHYnaFXGFayJMSqrHj8qd6jK9oWMRKY/pRGgMXAgCimcYyv2k
 Zkjo2CErS8JsR0A3FvUh+IaCdSKDfR3MGPn1/ZpN3Sp91Bz906zb42h6hmdzO0Uk0ISX
 hIBw/Vjf0hdYnWO8MqtVRYE2wQh29n1D+pB3gj6+QbeGqh/5IuAbor7jpy2mvOuREoQo
 PsDIlGJ3lALeMvrbY100O6wOqli8hgQ8nLeg5BMCGLyTjrhPucXRSef6HwowTFEPolXA
 S9EheogetjMofboN4PDE0TQnfPynh+He3S9OknMEXvo9cBr2npMkOytKYuB65yKFEmmb
 qH6g==
X-Gm-Message-State: AOJu0YzJ0c2Rm4Gj1AwuR9/D+V+2acuuiNt5RT/zuLrbxFv8Q3TcppfO
 R0Hl9nUVwrI6FXyezYkljz7pS7sBY71l5pRcDWmg/wgJiX+pWRUULzsPlFErV8KyUax+azKWZ3l
 FOg==
X-Google-Smtp-Source: AGHT+IGCLKb6gggeqWMBrnG+rVO+GH0ns7Rxad+hVIH/ocwQiEeLI19LDhqII0DQB+O+qulEbQh8cA==
X-Received: by 2002:a17:907:60cf:b0:a4e:7d39:dff1 with SMTP id
 hv15-20020a17090760cf00b00a4e7d39dff1mr2450728ejc.8.1712248587917; 
 Thu, 04 Apr 2024 09:36:27 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com.
 [34.90.240.118]) by smtp.gmail.com with ESMTPSA id
 qf31-20020a1709077f1f00b00a4df4243473sm9188609ejc.4.2024.04.04.09.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 09:36:27 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:36:23 +0100
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH] target/arm: Fix CNTPOFF_EL2 trap to missing EL3
Message-ID: <m3al6amhdkmsiy2f62w72ufth6dzn45xg5cz6xljceyibphnf4@ezmmpwk4tnhl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ptosi@google.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Apr 2024 13:40:43 -0400
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

EL2 accesses to CNTPOFF_EL2 should only ever trap to EL3 if EL3 is
present, as described by the reference manual (for MRS):

  /* ... */
  elsif PSTATE.EL == EL2 then
      if Halted() && HaveEL(EL3) && /*...*/ then
          UNDEFINED;
      elsif HaveEL(EL3) && SCR_EL3.ECVEn == '0' then
          /* ... */
      else
          X[t, 64] = CNTPOFF_EL2;

However, the existing implementation of gt_cntpoff_access() always
returns CP_ACCESS_TRAP_EL3 for EL2 accesses with SCR_EL3.ECVEn unset. In
pseudo-code terminology, this corresponds to assuming that HaveEL(EL3)
is always true, which is wrong. As a result, QEMU panics in
access_check_cp_reg() when started without EL3 and running EL2 code
accessing the register (e.g. any recent KVM booting a guest).

Therefore, add the HaveEL(EL3) check to gt_cntpoff_access().

Cc: qemu-stable@nongnu.org
Fixes: 2808d3b38a52 ("target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling")
Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f3a5b55d4..13ad90cac1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3452,7 +3452,8 @@ static CPAccessResult gt_cntpoff_access(CPUARMState *env,
                                         const ARMCPRegInfo *ri,
                                         bool isread)
 {
-    if (arm_current_el(env) == 2 && !(env->cp15.scr_el3 & SCR_ECVEN)) {
+    if (arm_current_el(env) == 2 && arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_ECVEN)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
-- 
2.44.0.478.gd926399ef9-goog


-- 
Pierre

