Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD894E63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXS-0002Vq-Dy; Sun, 15 Feb 2026 22:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXR-0002VR-G5
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXQ-0002Pp-4J
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:45 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so11697395ad.2
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213483; x=1771818283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sx4EklBCDXRhXcx4X7Amw2w/L2qFpEA1iQNUEaWH8vg=;
 b=iCFhWeeJgVhObOxanFVVof8cdrl2C5DlN976POlnJ8ZZX2XllKDbx7w1gyYucI40IZ
 dLfxGeePw1hOAE+cB/KshjmUe0lbJDzr80Lb0dcokfd1Ung9ghtrSBFd6OXiPVpukvK+
 lKaZKbjPbD5+Sjbt+a02t/UzH4HidI2OqO2UhJsBzCX7CPP5qg7fM/LLL4g0H5zJrBdp
 a9mHYnd9YUsleji5EFZTWLqyBgYzFTZtUoxZcqDak+8IOeldKU7fAnDfyKsVh+GXkub4
 NWisceAt3r4Mlic6Q6guBsaOkEMeOqE2ATpvscgYZQ/kOyDpyB9gZCb4TRLGaRai1oaM
 9/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213483; x=1771818283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sx4EklBCDXRhXcx4X7Amw2w/L2qFpEA1iQNUEaWH8vg=;
 b=JpKq6k3BLCsl7cvX6BN5Df6l6jI9wt4tcJLAtDi2MOTX8pj+3/Iehq3zHqnk6gjhwD
 3bFXOInPyP41B1ohidG8c2kF1lUOYJvz6fWl3rqs0q3QSHCiWuUs6gqK9kRXOM9KSp59
 XyhP/CsO5Oetb2sl724fkl35+WayLLoJD5DcBxsTIM4uCu54n4nEh1aIYgu0hwxp6KvQ
 t9QOsJCGovhNVpvnZJAc3QTctSfOLWuVljkImb1iXwVyLtbRiT7wzCKPbdG+tY7JJqjb
 tDcW6rcGhQUJIBIJxGo6tDH3VOjMNCjnZfBEsXy4fZPU7/nlx3+tVyMx9ZcvuLtATRtl
 qQZQ==
X-Gm-Message-State: AOJu0YzqtYC3jDaWz7cXhx+5E97HQqBsrR3kh5ki6ofEb+T5le2IztJh
 oYCZ9hNV4GsoS3xR/9QEAvY2RhLLyFl+ZZA68TFkNHtUTjElCawwwEV11Ay0riWPTDcejCz+k8v
 cGyqt+/g=
X-Gm-Gg: AZuq6aLxGQ4Xp9GpvA2cc417IG/uLusJ1gRvOiSrx3hhFVc+3k0Rn4iBp70RRkhAyt/
 emQqlpt7kr9k1PRLsx54hjqg4Ffsg0yy5gk2CQsdvyjhnuwUxJykrCliFDHrggOrbg3xjvEMBj0
 ThK+2ojTLjwSXCe3NGn85QbTicAmqN7dJBvBRTg5y7Z3LwkbmbP2o747CfpVult31yhdEE4wbkc
 8XamOYtuxkwQ+hcOnKcr1tP3GXDPuSElUVkdbwRZomwuLtazDfTzgps04+0JyiLT/PCLpYtMdQ5
 TcZ61XVTrA1tYVgBBaekjsluc4fUGZbiPfXkAJiSsoibzBHKr2YCwevcPb2++U8rogLSMmP17Jn
 TuEJ4hlFOC6KPYW0vdgl5uCGGRf/sNvadfstI1FAonM0iYVcDLfDgpiwJBwoRdg4gerZfP+V6bU
 ACtLDJRx1qwhAv3V1Q+cuLjNosIczfhQZi
X-Received: by 2002:a17:903:3545:b0:2aa:d672:3be with SMTP id
 d9443c01a7336-2ab506152c4mr91464745ad.52.1771213482537; 
 Sun, 15 Feb 2026 19:44:42 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/13] target/arm: Remove aarch64 test for kvm
Date: Mon, 16 Feb 2026 13:44:21 +1000
Message-ID: <20260216034432.23912-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

We no longer support kvm for aarch32, therefore the aarch64
test is trivially true.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 5d7c6b7fbb..10c6796548 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -767,9 +767,7 @@ static void aarch64_host_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 #if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        aarch64_add_sve_properties(obj);
-    }
+    aarch64_add_sve_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
-- 
2.43.0


