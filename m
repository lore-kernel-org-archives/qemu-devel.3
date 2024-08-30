Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A6FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk3Rr-0007Gl-EH; Fri, 30 Aug 2024 11:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk3Rp-0007EN-CW
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:22:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk3Rn-0007RA-FA
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:22:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso17450715e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725031318; x=1725636118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NG8BT4wk2wwlWq+dR+64QDBVzrTHfzbABoSBLNWlxsw=;
 b=sY0Fd/vx3s8XNB/yAfZQ5T/BaQYS9MZtkDFXhm+oHK/HzF0d1zf0rKfWjCljeuhE5M
 8zoxxWxndZOiLK0JDhdwNVv6QwEHYEw6SuG3a4gwAB75OTmAueFu6iD7iVrQwYZRWbPA
 +6Nab2+P4pzwJzmdzYE4yY/ksjxDw984jKebZV1t4QShM1RIIajce58wF0nk9vEdSpIe
 VGIvCQkcCqTA/pHzYQzu3B1o518Fn0mqnUANnP0aTpgLBjhJsFv5SxVqYvMmI5yJp7zZ
 /pCJdlAIkSWjhnpp8umpSR2Hug9yDl6HxH5ig828CCcKNnTqjqb2IgMHm/IxqN/ztFK2
 V4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725031318; x=1725636118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NG8BT4wk2wwlWq+dR+64QDBVzrTHfzbABoSBLNWlxsw=;
 b=V+WFTRSDBEMNsOiJCUOh0fr+2ndxCXmxvZDZjIQf8WfLeb5tViI9qpKQIToj8Hw7IA
 lfPfuLr14vKf7HFUobHWvpdnNXkE6n94nHbeyey7mLsXUn5WD1vtu/+d+xZWK/VLayrm
 lQpsdoWJVQ8noqDtI4KdGdB2zyxeF6ObFDOjunhNIA9qWTcyq0atW/htMkf///KCY/9O
 VjaW9FWLanSbH7P6aQHto55iuZZ5dr/8oAJGBWBUtGyaYnIYRtrtJ1s5M6fPWmxs+ngq
 iYRq2uj+2/q+p2shdZpFFk2OVu80tstb0LtsDuIy4OUCee0oxMQvog7CZenb/uq4VYVk
 NxHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpop9ivvHGTB6z8aE5Iz4xH/QOvsPnSSzxVyNp8JFZyn0+6EnchEVFH5ccvFHL/qBIV8pw61STQh/B@nongnu.org
X-Gm-Message-State: AOJu0Yzh0r15a9Ed4Q5Mfyr2l8697dAXPTmtPsYa4tC9BWmhoCB+EYv/
 YaxEvAGsyPFy7wQOe8D06M3fa4zZbMpW2q+LLzZx9hfv2u/bFudUYzK4aPTU/g0=
X-Google-Smtp-Source: AGHT+IGT2eFd6PocgYn56pDYLo3KpN5DuZIKP7JXWUH7FelK2ws5vl2HuwYwQyqnoPT1Vy2/pO0dig==
X-Received: by 2002:a7b:ce0d:0:b0:428:17b6:bcf1 with SMTP id
 5b1f17b1804b1-42bb01c225bmr53225295e9.22.1725031317417; 
 Fri, 30 Aug 2024 08:21:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42baf7fa745sm64189335e9.31.2024.08.30.08.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:21:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Correct names of VFP VFNMA and VFNMS insns
Date: Fri, 30 Aug 2024 16:21:56 +0100
Message-Id: <20240830152156.2046590-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In vfp.decode we have the names of the VFNMA and VFNMS instructions
the wrong way around.  The architecture says that bit 6 is the 'op'
bit, which is 1 for VFNMA and 1 for VFNMS, but we label these two
lines of decode the other way around.  This doesn't cause any
user-visible problem because in the handling of these functions in
translate-vfp.c we give VFNMA the behaviour specified for VFNMS and
vice-versa, but it's confusing when reading the code.

Switch the names of the VFP VFNMA and VFNMS instructions in
the decode file and flip the behaviour also.

NB: the instructions VFMA and VFMS *are* decoded with op=0 for
VFMA and op=1 for VFMS; the confusion probably arose because
we assumed VFNMA and VFNMS to be the same way around.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2536
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vfp.decode      | 12 ++++++------
 target/arm/tcg/translate-vfp.c |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/vfp.decode b/target/arm/tcg/vfp.decode
index 5405e80197b..2dd87a27089 100644
--- a/target/arm/tcg/vfp.decode
+++ b/target/arm/tcg/vfp.decode
@@ -141,18 +141,18 @@ VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
 VFMA_hp      ---- 1110 1.10 .... .... 1001 .0. 0 ....       @vfp_dnm_s
 VFMS_hp      ---- 1110 1.10 .... .... 1001 .1. 0 ....       @vfp_dnm_s
-VFNMA_hp     ---- 1110 1.01 .... .... 1001 .0. 0 ....       @vfp_dnm_s
-VFNMS_hp     ---- 1110 1.01 .... .... 1001 .1. 0 ....       @vfp_dnm_s
+VFNMS_hp     ---- 1110 1.01 .... .... 1001 .0. 0 ....       @vfp_dnm_s
+VFNMA_hp     ---- 1110 1.01 .... .... 1001 .1. 0 ....       @vfp_dnm_s
 
 VFMA_sp      ---- 1110 1.10 .... .... 1010 .0. 0 ....       @vfp_dnm_s
 VFMS_sp      ---- 1110 1.10 .... .... 1010 .1. 0 ....       @vfp_dnm_s
-VFNMA_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
-VFNMS_sp     ---- 1110 1.01 .... .... 1010 .1. 0 ....       @vfp_dnm_s
+VFNMS_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
+VFNMA_sp     ---- 1110 1.01 .... .... 1010 .1. 0 ....       @vfp_dnm_s
 
 VFMA_dp      ---- 1110 1.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
 VFMS_dp      ---- 1110 1.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
-VFNMA_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
-VFNMS_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
+VFNMS_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
+VFNMA_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
 VMOV_imm_hp  ---- 1110 1.11 .... .... 1001 0000 .... \
              vd=%vd_sp imm=%vmov_imm
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index cd5b8483576..b6fa28a7bf6 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -2190,8 +2190,8 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 {
     /*
-     * VFNMA : fd = muladd(-fd,  fn, fm)
-     * VFNMS : fd = muladd(-fd, -fn, fm)
+     * VFNMA : fd = muladd(-fd, -fn, fm)
+     * VFNMS : fd = muladd(-fd,  fn, fm)
      * VFMA  : fd = muladd( fd,  fn, fm)
      * VFMS  : fd = muladd( fd, -fn, fm)
      *
@@ -2262,8 +2262,8 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 #define MAKE_VFM_TRANS_FNS(PREC) \
     MAKE_ONE_VFM_TRANS_FN(VFMA, PREC, false, false) \
     MAKE_ONE_VFM_TRANS_FN(VFMS, PREC, true, false) \
-    MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, false, true) \
-    MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, true, true)
+    MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, false, true) \
+    MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, true, true)
 
 MAKE_VFM_TRANS_FNS(hp)
 MAKE_VFM_TRANS_FNS(sp)
-- 
2.34.1


