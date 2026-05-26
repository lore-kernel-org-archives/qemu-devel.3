Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F049CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsme-0000ea-PU; Tue, 26 May 2026 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmZ-0000G0-KQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmX-0001LI-Sw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso5999129f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805760; x=1780410560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oyc9WLt5chjRtOnme0+hheyrtoueTXcE0HqrcPgz3fs=;
 b=qeKs3E6Q6qaX2D802o2BZAGX1rIeaSOuARKh1sDhMt0B4f3o/+mPPbRiGodJpg9Gtd
 RfkcxsKsx5v8CyVIrE6yIznMyhB06IA1bXsF9+QPPIf1f5zDbaGRnPcZGQtvv76oephT
 GhThe7a3k160zlNacMEOK8sN913PRdbOWhzpHtYpEIqHaAm9vQwR1E2mD0smEhWWbu6r
 Nscup56vY2Y6+rEY/Ux0ppBzUDsP0kz2AUTRWnoCBPrcAPo8eEFj5YShMw7WOM3fijj3
 ZjT2ndTZzHPHjXnH8XlPMK8Jub27ewQnx6TxegiuMQXInQsomg3ZY8C830gs6ynDdQeL
 B9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805760; x=1780410560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oyc9WLt5chjRtOnme0+hheyrtoueTXcE0HqrcPgz3fs=;
 b=e+vh0XDbs/jSrbal82FgsDOuSNp6R5IvZxiKAvrdPxA/9Ju6unwgkzcwmtcR4DQ1+m
 J7m7HKoDFI24BqNpTQEHVSP/huxTdiWc6ohD4rA6J0T3RHB9mPL3vlhI+FF7sTQUnTRJ
 3giZn15oUiidQVG0X+hOtzw1cMJPx2G9Xn4ueyqCh1W+B7vf3WniA3v1/CRR/VtD/mal
 /b90odGWooFxkM/e0qXuJE0Jiw1Qgjaw+VqCcl9rGM4SDSGV8e8faGuQQSLf0WZx+anM
 g9SIH4U3EtgoLbkBWbRphNOS5zuCGBeCgb1k0w5XYB0FVNpP7XEuX/UztSfvCu9u/f7K
 0W4A==
X-Gm-Message-State: AOJu0YxxQeEDTLrD2wrZ/pOngYl54rFzY1j9fuuCiP+oCsxR3zUOlEKG
 4NFb+Tpm4Y2NINYj+dDDfC5/nltYfj7mQfOWRYrD8CcseRgxXVWML6wdf0w1WRfqbLewyoaoQRH
 gycn9
X-Gm-Gg: Acq92OEgApNzQtAm77boP9RsaA4/9p6uKpJVMVMyyogZvEeyJys5gRBhYlih6VLuOgX
 feaQEOsIO2VPx7A3p3+cQRtf2yafkfEfI4RwpZPGq+/f4rcuoDDwFWXIW3EcGFQrQ219TCOdddN
 yOtoYCWe/Jg6wlWuSNjgO2UHcD/Nw3A7F9yn9wzQpafJrU8ec3H1vOszBY/j8g86WuQMvMIRA6+
 bRShqJPzaW0We05gPwSfwBTc6QFrXjS2//fKBOL4ejx70UqDXpZE7j6ZjWW0+uVmFcAPCmi321E
 YkwjRAsdEARS17Tsb9iD/90DcRxLHw3xWDun3Iyuc79e3fJRjMOP4rp5hPZMTkcTkYH8tC26/5i
 kigGvXyCpFIe5nqGC2dPK/Lr/ETFCKYc+w9NUQOT0TryxNkDB/GSLo9Rpe5pDhP33z8Fvuh19ln
 ecAZsWeuPwVmi7GrCyiTqlfT6J79FhcQ/LrjEuSe2lrE3JvOtWZHWKxqh/mq8HLrHLhmCCJ8UC4
 8jmPbdQ41Yt6QO8speCwRQraLU/g5k=
X-Received: by 2002:a05:600c:c16a:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-49062375334mr173601015e9.10.1779805760534; 
 Tue, 26 May 2026 07:29:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/54] target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
Date: Tue, 26 May 2026 15:28:26 +0100
Message-ID: <20260526142850.2326589-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We should be using the F16-specific float_status for conversions from
half-precision, because halfprec inputs never set Input Denormal.  If
we use the FPST_A64 fpstatus then we will incorrectly set FPCR.IDC
for input-denormals when FPCR.AH=1.

In commit e07b48995aaa we updated most of the halfprec-to-other
conversion insns to use FPST_A64_F16 as part of implementing
FEAT_AHP.  However we missed the SVE FCVTLT instruction, which has a
halfprec-to-single encoding.

Correct the FPST we use for the hs variant of FCVTLT.

Cc: qemu-stable@nongnu.org
Fixes: e07b48995aaa ("target/arm: Use FPST_A64_F16 for halfprec-to-other conversions")a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260521122913.1565011-3-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index bf9f0ae179..59b8c494a8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7827,7 +7827,7 @@ TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
+           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
-- 
2.43.0


