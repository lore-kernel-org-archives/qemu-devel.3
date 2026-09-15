Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663C7C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6We3-0005kP-Ti; Tue, 15 Sep 2026 13:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdX-0005Xc-Fp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:04 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdV-0003Yh-I6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:03 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so1994257f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492080; x=1790096880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LRH3b8482DZ2qTZr1l8vvVhFgp01fVVHG2VpejOl0go=;
 b=ao4bLV0CLpxgQ9kUbu1J1jyBJm0FuP8bRmG+cA2aj2gM2wYs7plbFjGwjYMYzGKEwJ
 fSJBbhjU/PwLE411GouT40BOyx6VbruZjndhNmJOL2uQoLHyiIwgoJEb76pMx/tEK1pa
 aIaGJnIeItsJGHG9POnBUbOPBI5PMiBtgY/t8GruTVwsLm7Wgc2GTYwXbKsSlTwmGVUp
 rTqyrPdrYne5ZyqIjvEyWHpqTHV02P7ghaMd3sQrl+HazfveWZZyC07QwAUHXn7hQVb4
 Qyksq1tOhyJGroyRiwHh46Uy4ll5yaQ2sv72t7/44Hwgael3bUdNqJGNKwtU7DpXbwaG
 loaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492080; x=1790096880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LRH3b8482DZ2qTZr1l8vvVhFgp01fVVHG2VpejOl0go=;
 b=Q1R7TRiMz4aO/NOe0DOx2frT1KawA4zSC07VimqHm+ujsVruQlAENGFOmu0AK8KHZO
 KqXxzZEGd4DmWdcJG78EdsvKArYja0Am094b6WECKF/rUo7k40uqsYM28Tdod79jV7yO
 HyAYwjJWVGKojW5eaNvENJd9uFnO50jdEJz5pxxCxek/veCJk8xh5kCSW5C8QVFqxXEr
 7a2q1Q8j00tX33jdhtQWoDIxoun+yzz+BjHYmiMFpTySTuYt+augrSMLSTklcVMwTjTe
 Jm9P03tsIDze24HnvZULG60XxK+ElVqRGaq4OBy8wjDMXI7yWXLTqpbKDfDM12HZP0bC
 M+Hg==
X-Gm-Message-State: AFuF++laH/e3B++o24qkl0drk8OaVpCJKAHLtj0+RZ8KTaBQ605sCav9
 5eSrnR4A3cQTkuzJIw31CdMoOl5GlGL43JWxcSEkoSkh2vgK08h+Yw04lrR/h18cupJxXaIvw7R
 tvmmKJOM=
X-Gm-Gg: AYBFou3BkwbxEJ7XMV/ca0tiJx5iPlSbpVKg2C42EDbeR4VktEnlJKADSsUibV1In+s
 D9i4b5Hb7zsKsF/geAkPTBgpL6p3UAFgEq0qP2RmneJEkt4ImzzMQ+mI0bJZdL17yXglCFRuhpA
 N4A9nAZwZCA4fydUOFPdUEkni410R55dHvlDo72v9/PAesok5bn6XyHWNrJVG5cMeRdPpOIxg/b
 /9bllpbsyk4A0YTdXOVNuJ7iFL4r2z9/zvN+sftCULAoN0J89cbXyG9qhgng5URX59cgp4agyMn
 M1EF2HYxMLVGFZpbAMmMhxeqml+Eu575wI2gd5cqKvAIkPKq7rlQxDLIAPHOGaepPOD/b06igJH
 CeBHxSxyM8S76SrZ9AbiH3dU7QQNzLmw30FPLKXFSgOMFzYD7zar55UCLILj/f810PxURb2zan9
 LO5DS8QPu3aMQKNTSp0RA+jzuhzzJ6bXjchnq4yNLCKy/0ESttcNZNmOlnidafu6pj3ha4ufGNz
 TvI7VCuU/T5uBjePd9DULqveKm2lZF4LPY/aCdhKULcD4CZ/WC9x5qDTQGsWc+BIySz3SGeG87q
 nKf4
X-Received: by 2002:adf:e014:0:10b0:487:71d:e878 with SMTP id
 ffacd0b85a97d-487071dea3dmr7738378f8f.2.1789492080126; 
 Tue, 15 Sep 2026 10:08:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] target/arm: extend PMSAv7 support to v6-M CPUs
Date: Tue, 15 Sep 2026 18:07:35 +0100
Message-ID: <20260915170735.425445-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

QEMU conditions PMSAv7 storage, reset, allocation, the pmsav7-dregion property,
migration and address translation on ARM_FEATURE_V7, which prevents the Armv6-M
MPU from being used. The checks are widened to also accept ARM_FEATURE_M while
preserving the PMSAv8 path for v8-M CPUs (PMSAv8 is tested first and the
migration vmstate excludes v8-M with !ARM_FEATURE_V8). This lets a Cortex-M0+
declare and use its MPU regions without setting ARM_FEATURE_V7, while v8-M CPUs
continue to use PMSAv8 storage and migration.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c     | 12 +++++++++---
 target/arm/machine.c |  3 ++-
 target/arm/ptw.c     |  3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..f58a1db843a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -617,7 +617,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                            sizeof(*env->pmsav8.rlar[M_REG_S])
                            * cpu->pmsav7_dregion);
                 }
-            } else if (arm_feature(env, ARM_FEATURE_V7)) {
+            } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                       arm_feature(env, ARM_FEATURE_M)) {
                 memset(env->pmsav7.drbar, 0,
                        sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
                 memset(env->pmsav7.drsr, 0,
@@ -1656,7 +1657,11 @@ static void arm_cpu_post_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
-        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+        /*
+         * QEMU's PMSAv7 state also models the Armv6-M MPU register layout.
+         */
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7) ||
+            arm_feature(&cpu->env, ARM_FEATURE_M)) {
             qdev_property_add_static(DEVICE(obj),
                                      &arm_cpu_pmsav7_dregion_property);
         }
@@ -2332,7 +2337,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+        (arm_feature(env, ARM_FEATURE_V7) ||
+         arm_feature(env, ARM_FEATURE_M))) {
         uint32_t nr = cpu->pmsav7_dregion;
 
         if (nr > 0xff) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 7005f4e5d77..53a2734d25d 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -584,7 +584,8 @@ static bool pmsav7_needed(void *opaque)
     CPUARMState *env = &cpu->env;
 
     return arm_feature(env, ARM_FEATURE_PMSA) &&
-           arm_feature(env, ARM_FEATURE_V7) &&
+           (arm_feature(env, ARM_FEATURE_V7) ||
+            arm_feature(env, ARM_FEATURE_M)) &&
            !arm_feature(env, ARM_FEATURE_V8);
 }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index cb9e73fc0ad..f537502d3b1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3908,7 +3908,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
-        } else if (arm_feature(env, ARM_FEATURE_V7)) {
+        } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                   arm_feature(env, ARM_FEATURE_M)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
-- 
2.43.0


