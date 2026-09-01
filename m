Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB37BC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON8-00010j-6P; Tue, 01 Sep 2026 09:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON1-0000x6-Uh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON0-00078m-8D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:47 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso207117066b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268665; x=1788873465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hHa7uKqDce6F9DSBhR1Ee9VldNHnO6yCRGsv4+2ezRk=;
 b=D6AbZiXp/scupsC+bRJ8CImUGQvXwHAn6IRln/g38eQkqvO7snOVGAcGiKsbVx8zok
 BCKlCTpnyZqyIDgASdFLADL5Ugglf2C3P9b/gDBtsS9Hmm9ep5102oFT5UgTqfKXxzgs
 /HSnA0oy9QNORZ2ggfvECJux1uYownhlzz2L32GGwz/SSVGf0PE9k9SyJ8Z7QIXdKQHP
 qt4f2ovmZIWpkAsF51igmMEPaGGqaMhHzIYZ8P8iqqv3tkHtiZz5lFexCqD2CooIsJPY
 +V6cMcjy0NDpgWdfAxjce20RhzUw+2AdCI2PmZOG1Bu7FF1a6xJaDzdIbKX8u5Q/ifFB
 wqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268665; x=1788873465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hHa7uKqDce6F9DSBhR1Ee9VldNHnO6yCRGsv4+2ezRk=;
 b=Ptv1EagAY5IB30WNFcGX+Bzf13VXosMHL7dbrN8gxKhKeBigiuu0xC8JjmWGLsFclK
 E2feahHEbgVGFtROBALElhc9j9SMnH90RnAJTXdpFE0hEk0XcVsLdoRuiaDoQf2mAGRl
 lf+rl6ykqUVfkYPsEkdA6MDWaB5Tn61GVVZwA16AfTDS1m5szOwTz7S7qZYNsujRKY7K
 /KJ07jjA1lHEnv+JhMk4yecjN/KZmojTNhHdmXv0GR7C471/anFWbtIZUWg+tfGvmHRP
 O+k9QIMvMxGcUQAQnUOBbzO8OZ3vLRg4Tq5Zm6RXYCikGPL00KomZR7lee3GPftLZ1Ss
 PfRA==
X-Gm-Message-State: AFuF++lhnPKTkY1idz7QmS4fVYfGbSdv/jvLwsBtzRua2xSfShk5AxJ2
 2wJMgVr7ddYwvXTJlYB5qiXCu+eHCl/XGiTeZbnNP2b2zf7AI5II60wmCdCho0RCPxoldHnel5c
 jlmQfJbU=
X-Gm-Gg: AR+sD12aq02e95HnVWLh/ZetTIaJLBW5eJpbqt+rFxI/CcEBmm4Qf/XOVh7pq52EQk8
 u4LGgJmj1DX06wKILLz7e4FpWuMn5+cx9bUKYnglsSBSn8AzAUfRTaF+dzvAydU479dDrDnCcAc
 PrPGBkcGwVt+ma71hE2hM8ymsOCbOfjlKuCb0R34Lc/uDhp7qS13PyS3p+R2cLp26pvgGFeKk6Y
 mhapzTkLhejl673uRsJ4NEbJyk7cDUvjk6cp5WOMo6eKqcEOBlKstu+3mbIPwfroAAv4JK80Q9p
 kP/Eh4RuZ/j0rjqC2Oi1Tq8jY1kdgD6y25te9/slvQoMaxESCF2lK80Wy+eSvRS2hSZ67hrqW2A
 rZJ9XKfg1Dw/MVqnXEZD3CyxgxxQZyzMs/2whoAkH0CY1siUtUWQgx8aPlU6uwZBDBVjXiyNNM1
 po2m+cSolM382MvsjqE/Teh1v5CUxMxx8mwJuXzag5wq5g43d8nhEnCAhMC9Hnq3YGF3OPGgVb+
 YhCDehsPx16GZ1tpwlzXhvApiyd1J1dk1aQ/Vi6rfEcRuYicPoqPek+CCqrqzmiZCIPDA==
X-Received: by 2002:a17:907:3e16:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c25b90ffc27mr330778466b.6.1788268664715; 
 Tue, 01 Sep 2026 06:17:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/58] target/arm: Don't enforce alignment faults on Device
 memory for SCTLR.U == 0
Date: Tue,  1 Sep 2026 14:16:44 +0100
Message-ID: <20260901131732.2263947-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

We enforce that we take alignment faults for unaligned accesses
when the MMU is disabled or the access is to Device memory. This
is correct for the new-style unaligned accesses rules that were
introduced in ARMv6 when SCTLR.U == 1 and then became the only
option from ARMv7 (where SCTLR.U is RES1). However, it isn't
right for the old ARMv4 and ARMv5 setup (and ARMv6 when SCTLR.U = 0).

We don't emulate the v4/v5 alignment rules (which notably include
"for unaligned LDR, do an aligned load and rotate"); but taking an
alignment fault is definitely wrong and isn't what QEMU has
traditionally done.  Restrict this behaviour to when SCTLR.U is 1.

(The other place we enable alignment checks on Device memory is in
ptw.c, but we only set TLB_CHECK_ALIGNED for LPAE translations, which
are guaranteed to be v7 or later.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260819190015.3555218-1-peter.maydell@linaro.org
---
 target/arm/tcg/hflags.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 296ec8101ab..c7739fc61b2 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -47,6 +47,18 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
         return false;
     }
 
+    /*
+     * Pre-v6 had a completely different model for unaligned accesses,
+     * which doesn't include taking unaligned faults for Device memory.
+     * v6 has the new model only when SCTLR.U is set. Later architecture
+     * versions repurpose the SCTLR bit for something else, so we mustn't
+     * test it except for actual v6 CPUs.
+     */
+    if (!arm_feature(env, ARM_FEATURE_V6) ||
+        (!arm_feature(env, ARM_FEATURE_V7) && !(sctlr & SCTLR_U))) {
+        return false;
+    }
+
     /*
      * With VMSA, if translation is disabled, then the default memory type
      * is Device(-nGnRnE) instead of Normal, which requires that alignment
-- 
2.43.0


