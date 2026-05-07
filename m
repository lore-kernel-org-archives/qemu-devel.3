Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B3CD37AD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S5-0007kF-Ue; Thu, 07 May 2026 19:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rp-0007DQ-79
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:10 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rk-00026f-2X
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:02 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479e6bc357eso595540b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197677; x=1778802477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiL04P2CzHdch1eAb8Dy0QC+hd+UkcPVAZS3KCpqoms=;
 b=Bc+MJBhOpsevCOWPAFFcLMEgFASfsemjNIiMMk0Ugfl+yOV5fTL20IONejwJo6EuKp
 gG2yPK3We/txJPQ4QOiqC82mmabIO5EkmJxC8m0NCdLm1qAxcDcc4J/qEszB3IpSmQsO
 8WE6ZA3neBDKcs0NprJnlQHWDbxIhvv3Iw+InAGq8hnUACELACqtDvm+w0Mgez6NBZhT
 wvxBeOUb512VZw7b7OnB/Zg7okSZkLsWAIzAzwO9unQ98UPwBe2MZFjHU5uQv82BAWpQ
 Z7VjR/+IyojtTTbnG9aNCDIvGohEpgXrbDJwFSGJjwxvCm/UyKIzSgYUHtDW6fykfCx6
 bW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197677; x=1778802477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiL04P2CzHdch1eAb8Dy0QC+hd+UkcPVAZS3KCpqoms=;
 b=tD4u+K9wZWgYx3Y8n+LKXgD2IlN+Yv2BC48NN8zkWldaQAtWBzFVfygAC5MyvrP1qh
 AMHW3IQgtvnZwIVI+IYVHPxmkRtibyuvupQa5j7rT/C/bTZ3yAZt0Q6D65G3Ba/V7KsZ
 7R+nTDh7T1QMoBwKybIZ7+y8OnpCuPvV9pB/VzZUG8NWLBRZRn2C6dcWWkI77iWXvX7A
 jyiwGS5ySOwxrxCFN+buQ2e0Zbava+0UwJlYZyCE/gV04q2SFwLwOhh9vcXkF3cIOfj1
 zwY/J8vSJhfMHPSVLKJBsC8GMCcfQ3igzHJsAcuLi5COyuB0W4X4wTfM3zpyJ0cp2s1G
 hQXQ==
X-Gm-Message-State: AOJu0Yy42ql2IF8FgflNy8nP2+5j4iSPopVYenLOEF4gVW1u5Kr6PT7e
 7kZ89TAGbNbcBdP8NB6vEc5BCF8QFas9p7e6mkQK9ZzobHZymUzdQKnUNew5kwSrB5HbknxH9ou
 uLwVY
X-Gm-Gg: AeBDieu4seqkBFSXxBiMO1pXrVZcatBMbArqPw5+FUutoy9jkMja09oZJZH2IANleR2
 DSzYW0WzUHcZoTn/2JkadGzo+McypXP1PK+zA3yuKbkCStGl/3nJIgRpjVkOr+7QAuX9uX8ml7G
 ihkDlWK0kHK/1rXLEWi3wcpI8eqA0VJTqsyZlxWyvazDg7anvV09N2r9JunM3NgBp8l90n20wsq
 Xr8WixYDTsUPo8Zff/gHUU48o7shlvv7ea6Hgf9Dm5532ff1jc/g8C/T7bPP+wy/D0LcRuB0sGg
 FXZW4Tv1NFipp82AaFAfTTmXLYMVzjxVUCd9CUzGBpMUDrCcbT1Pr0PryBvZR0WfhyTW2JJ2Ohk
 CH5WjJIk2Xrw/jkDkcpgKwAYHvmB9RqCQzKelt/mYZmio2hTUjHbMSrJ2pBFvi6yH/8hS5DFo+k
 3U57MM5r02D2bBwIRGCg1z3sg3Xs41U2TtZn8nzINKn8zjmQ==
X-Received: by 2002:a05:6808:3a14:b0:47b:9886:1bdc with SMTP id
 5614622812f47-480424f6f70mr6191628b6e.33.1778197677500; 
 Thu, 07 May 2026 16:47:57 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:47:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 43/60] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Thu,  7 May 2026 18:43:56 -0500
Message-ID: <20260507234413.643512-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8d0c057902..90214a355a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1388,6 +1388,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b6f0ca9351..0dd6b554a0 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -158,6 +158,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


