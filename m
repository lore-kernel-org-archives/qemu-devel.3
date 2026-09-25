Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9512AC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADos-000890-2o; Fri, 25 Sep 2026 17:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo9-0007lN-Kp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:24 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo3-0007lG-DF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:17 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-87fd84c0bfeso450598b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373010; x=1790977810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=001YOUzeDy/jRJu+XV/XxZMtl8V6MI8QjkzCy6iHGME=;
 b=htJsajGd7amyCSGnU6uyJWcfKWvvtUYC0IX80n8n3iMgYGxIS/ne2XNp6j80/EXvrJ
 /DcDMLkkfcrqIvL9iBbcijwGNKqELPKXFP7SAgnFt/ZhN8ArQzsssVsv9m/McMmKHTZX
 cbFWZWRKsmT+a++qbZkqAE/x/H1q6eZzvXMlVj0vCrvI296LGe5CxPcBma/WHMSBRxDO
 FW/OW1DQ//cq+cedHbUkAbIGODzJu9YZ927kUjOrThmMkAmZl1ux0EHr/3mQkMMRHuWO
 STTfTXwH5WdeP9ORDWAj0jol5EU04Wj7mdiXAwsUISzl+utvaMqnWAl8i057MpZawjVA
 AkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373010; x=1790977810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=001YOUzeDy/jRJu+XV/XxZMtl8V6MI8QjkzCy6iHGME=;
 b=oq84GBINef76W3EiDGRmLadMOxKDbz1qjlajvvnYgTvgodZa+rwq/Fk45F5PaAt315
 WAyAuXXeQre9F21SvgoJ+GBkgH08+T1/S0cepo3ksDHuEz+PF3m4v51OR2qKCU2mMvcO
 QkMn0fmwUg4V7sw08YGTy4B+L7DkKlkpoId8mmsimyxZOzgUMQUdPzmnEjJSlo00WJjx
 pZHCVGa5UyHT+tTICQuUC/RW50PdqIhXEAvVDHYsueKMAKCwQubUZHVSCmIiJYxpYVpD
 R1HY0OoG6v0ZBswDWhnGE7V3Wa7iI5ZJSo6ti2qYh/sMnNuSDdV6jfbqrlSrtLVuKHF5
 eVOQ==
X-Gm-Message-State: AFuF++mMDSygpBC8qnXv6ivonlvXqCYHQep+948ca0/aGrRP+//NAzTt
 iwT6ZHBol+qFnQJd+IXHzDG8qa+L0NkhRFHecNbVHzBd+s4eNR7knWqh5LW/u0/V+sc2bUIiCkC
 jIOH7
X-Gm-Gg: AYBFou22qx9LSMJus69saupS2BJkOtErs5FKndiwTbTV9skNHDglkkuITvK3/wB2I1K
 cBfEbMAi3zEaC28V+LHFyLNHbXGtEcOvPAtGbDaC/1SmDthlGP4qXG7i2Z0vbBJeM3K+t3Kwguy
 ApQv1MAApEBs9BCX5Pm6FzfODzVNruqihI0dHgSuqkVnmrOjU5INxEBNv26WsuQDwONI92jo4eU
 BPDGff5sMxfKdQDEIorz9xT1BhYUarJjp3bbnMgMh6wgDTym3CUkv7b2F6hoIfJM9TzD9Tkzaq6
 AqnQf51wxSUPyGvE1Y/KqQ3J0cfkCBB0489t9Kzx9b0jHAJ9cTrRsekpCkpWM7mLnrgzmBf4poj
 zwZl8dOtFHR+qdpmr4UmMb0znmrm7KUsQDNW9Mxs/y6tm+j2hR8xcQestz4+0n/pJ0dThQSSIqv
 45Nz+Ha7wODZYwVSLwvAzFZg7R8uO9AwGoS9dnucz8ytJ7d8upa6X/wgNREqRybx3AJG/joJ/Eb
 beoS7C6Ohs6z69APCixJtPFtouc94bKJ0NIq3+d
X-Received: by 2002:a05:6a00:1884:b0:878:3783:8a4c with SMTP id
 d2e1a72fcca58-87e9be753f1mr6413242b3a.52.1790373009693; 
 Fri, 25 Sep 2026 14:50:09 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 04/14] target/arm: Sort BE_DATA toward the top of
 rebuild_hflags_a64
Date: Fri, 25 Sep 2026 14:49:54 -0700
Message-ID: <20260925215004.456336-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is the last of the "ANY" class of flags.  Sort to the top
with the other "ANY" flags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/hflags.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8da02ae1ecf..cf7d49be908 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -412,6 +412,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
+    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
+        DP_TBFLAG_ANY(flags, BE_DATA, 1);
+    }
+
     /* Get control bits for tagged addresses.  */
     tcr = regime_tcr(env, mmu_idx);
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
@@ -475,10 +479,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
-    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
-        DP_TBFLAG_ANY(flags, BE_DATA, 1);
-    }
-
     if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
         /*
          * In order to save space in flags, we record only whether
-- 
2.53.0


