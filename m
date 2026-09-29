Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A94CA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfi-0000Hz-DY; Tue, 29 Sep 2026 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfL-0007d7-W2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:28 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfK-0008Gh-8t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:27 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48881a62e09so2366484f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676145; x=1791280945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IkFpezh0UNbWbltntytc6lBVFDfMOMoC/WCVqTS3c5A=;
 b=vlBIIiwPuGBg3x2wBd/LWy3pufEkQZKHf19W9QiWFkijK1TmEQGMoG9ZkVPEU7vXwi
 H1GshWAXif/d5rLBKLdblbsjYba401eZlkohws7D6qmiEwB8U+tZ0jcNpGq2ZnLPdojP
 Fl30LUk6s30BJqgo23YNZ8RtaKBGrJedSi/alcsF1OHGd28IN4yJsfPRWNKYWJyVIp/Y
 n7MBs1pXrZoOlwvUOZvxY7lxSZbaIMhFXpYlAwRgN7wjfNT7irP81iccqJOBJlIkozY/
 lBrZx46sAPkuz/d6BdeX1nqoSsOoiYtxnpYG8Q6dna43xvpHWQvNCUZYmmtPesru2uxT
 i09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676145; x=1791280945;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IkFpezh0UNbWbltntytc6lBVFDfMOMoC/WCVqTS3c5A=;
 b=0rqeM+PUpJDoo5LpGEPAoB0AUrl9pNI+H4v7TOi/7xcU1auxGhwEfEY0nRZ3Wd/naJ
 GMTaiNXCjFVP49udpUX2E9VS3WTrGGGisx35YOQZdGrZrHsHyNlDQr9zOTW9Nz4PypAW
 ORP/imknv3nsYIyT0/PpJKY9SY7wK0rQispqe7bEWl+CtQWDQXViA1VumV+Xs1jJMGlJ
 QfiTl/JWR6jF+XWhTlwtqkWyguMlkr3Ixtn8nSI1YZbUriEYP8PylHF/vMcRk5cbs9o6
 WBVnaObA2qDJmNRGwLFQH8y1mzRLpnW0bOnKAkcb1lXpntgm8/eutA4yOGUYfjqcPXV4
 a5ig==
X-Gm-Message-State: AFq9FYKX+miGc4N6y4Uc/LScja/BZMAEq6lJKkX0WD9Z6ADH6j3E0vzK
 J8izIy1DVSKKKzbn3sqIzJtTlrnW33BbaCt59aPo+VD2Ql9t93Z1SiKsjqblzIxZZxZDxWRJvFj
 iGOp4
X-Gm-Gg: AYBFou3KZ75U6j8nc6NLa0ZLUye75UZplONvlxDKlFSTU9OydZnBXDl/S3MQfp8Pcit
 wpbtUm1AoV9mVHw4mU6/TDnnNiQ3puzaraPZsWrbivRQQmpAB6yAimnWAQSEoYLBxCZws1afueX
 /V1LVMzA/kw/jf+zXo2gufqeDn00S53ocGjNx46FL3NvWfIHhGgSKp3gN5a0C25nRe9/FDWE+PP
 FLkzPu73xQCWw9ZuITySMjWli7P8b/QcSVXS0aS6/YKGoLY1U+Y3nesE/diU/+Wffn0/3p4yrbV
 lV+QRbf6zQJ7Wuat+YRUIC/93i7y4G5jWxRGQsryWvXi1VF4riW7Dbl70gDfMI1eIWRYbQY7HVX
 7yt2NIKPdi+m0SBgw8ZV/6tDDdT5qGjpmkiCeOkjH4wqch1afeMX2s1uq3bu+fmwXioJ9agke5w
 G5C1DQSb1O86g2hw8JDWpPnv1JDeDiRWJH5kGeTl1CG3sH2Y6dou8KXxqkAlRdX0gkQAzBXkMsJ
 //4tj9+MXgctpT48/x52CxrDLguj6BmzqA5frZQ4jQbSt6OrVBcjDmPesNICsaf/3JNrBX+1iLz
 8/M=
X-Received: by 2002:a05:6000:208a:b0:48a:f929:e140 with SMTP id
 ffacd0b85a97d-48af929e23cmr807255f8f.10.1790676144867; 
 Tue, 29 Sep 2026 03:02:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/37] target/arm: Add PSTATE.UINJ to tbflags
Date: Tue, 29 Sep 2026 11:01:27 +0100
Message-ID: <20260929100133.2598676-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/hflags.c        | 3 +++
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 target/arm/tcg/translate.h     | 2 ++
 5 files changed, 8 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 78bf4576a58..06ebed4a8fd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2506,6 +2506,7 @@ FIELD(TBFLAG_ANY, ALIGN_MEM, 10, 1)
 FIELD(TBFLAG_ANY, PSTATE__IL, 11, 1)
 FIELD(TBFLAG_ANY, FGT_ACTIVE, 12, 1)
 FIELD(TBFLAG_ANY, FGT_SVC, 13, 1)
+FIELD(TBFLAG_ANY, PSTATE__UINJ, 14, 1)
 
 /*
  * Bit usage when in AArch32 state, both A- and M-profile.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index cf7d49be908..c0b47f484e6 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -121,6 +121,9 @@ static void rebuild_hflags_common_aprofile(CPUARMTBFlags *flags,
     if (il) {
         DP_TBFLAG_ANY(*flags, PSTATE__IL, 1);
     }
+    if (env->pstate & PSTATE_UINJ) {
+        DP_TBFLAG_ANY(*flags, PSTATE__UINJ, 1);
+    }
     if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(*flags, ALIGN_MEM, 1);
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c60f4c4103d..b3438235828 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11028,6 +11028,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
     dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 8c56348a665..f32200cc47e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6418,6 +6418,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->fp_excp_el = EX_TBFLAG_ANY(tb_flags, FPEXC_EL);
     dc->align_mem = EX_TBFLAG_ANY(tb_flags, ALIGN_MEM);
     dc->pstate_il = EX_TBFLAG_ANY(tb_flags, PSTATE__IL);
+    dc->pstate_uinj = EX_TBFLAG_ANY(tb_flags, PSTATE__UINJ);
     dc->fgt_active = EX_TBFLAG_ANY(tb_flags, FGT_ACTIVE);
     dc->fgt_svc = EX_TBFLAG_ANY(tb_flags, FGT_SVC);
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 31f52a34a68..f633aa265f0 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -155,6 +155,8 @@ typedef struct DisasContext {
     bool align_mem;
     /* True if PSTATE.IL is set */
     bool pstate_il;
+    /* True if PSTATE.UINJ is set */
+    bool pstate_uinj;
     /* True if PSTATE.SM is set. */
     bool pstate_sm;
     /* True if PSTATE.ZA is set. */
-- 
2.43.0


