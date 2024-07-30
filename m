Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE5EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJj-0003Ee-Sw; Tue, 30 Jul 2024 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJh-00034b-I5
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJe-0000Fn-Mf
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3683178b226so2137778f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355389; x=1722960189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J8QodGCyXxyaENLTKMO9Txf9gYtGANATnCYmDKKTwbU=;
 b=pMb9oii565HwEJFr2CgmyD59rMk/n9JX0/04HGWcG9Vad35iKrkX4tPZldxCiRzpi8
 2k+otYTYcaIwTfpCv8rnkmE5t3Z6yVlYLf6Ryju5Ezeg7L2aUGx4KGEdYb9X5XnjoTOL
 qG9OsSZpj1gJTaTLlcqYLSvyTiwb89YEMMXTGf1UoB2RHTqqUmwiqLeeRBD6H8L2ws0h
 AnpQpze+djgnT69r41E3AqOR1WrkCGNTsGOi9fgVzXyFQJFOGO7as9iMF4nUY1BCfFdZ
 txm2iOwpAMpuffnYQePMOjXCkuZYi1ISkJpmbbWomjig2k758fziJ3aAv0zKmWOas9gF
 a4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355389; x=1722960189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8QodGCyXxyaENLTKMO9Txf9gYtGANATnCYmDKKTwbU=;
 b=K0sVzZ21kB8TPABWAKEttsFqOe0DZagbW/8yOq1V/7jUEE5kPsYII1d5mZEE/r1YYF
 ot8v1vOgKpYXyczWp61AjKNZKLc54u+IqAtSSQDW2ZH/fpqYV78GDjzP0tuz2YJY4C9X
 o8K95d+FT+vRQ154nR3t1Fq30njFdqkX6dOuLsPgXv/dDGMCnq4Lm53Z6Ut9NzsmZ9UB
 0AdPPeN2ad/OwJDDOYJAH0eWpbjmCoGKQJHd+4cAf9n8O4eYg2CtJMuzY9cnHrYkwoRv
 eyQaEvUQJFeHQjjHymDX5BXY9fzmakC2D80IerT2CXiAOUcgInbxLE16IRrCxqit3Y/d
 Qfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeG2Lltiy0+eIt7PputrSC4QClnrwTM7umWZZKpa/apSOLIr/lH7zstZhzUpR7DcToH0yt7+qJbk+wnwGlKt3G6l7QdNQ=
X-Gm-Message-State: AOJu0YyxyA1ayP0VNcYsY3knFPd2vyuRTOkiTlV+Mpa6WpeHLLImfehu
 fZ56S/qtO0dFuegDr/KMoKG+i1OSyiUVYMC+EPKh3YJxHaloK1uECw3kRXZSybUHCK9hBpBlTLW
 f
X-Google-Smtp-Source: AGHT+IGv6KAM2NIpBdX8j2d+sWyxJ7dI7m6Wx8zNbzHKmN0Rg8GfpvxIx+dOdVBRmX6AUPGoaLvV0g==
X-Received: by 2002:a5d:698b:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-36b5cee2e4emr7735549f8f.7.1722355389158; 
 Tue, 30 Jul 2024 09:03:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/8] target/arm: Pass env pointer through to sme_bfmopa helper
Date: Tue, 30 Jul 2024 17:03:00 +0100
Message-Id: <20240730160306.2959745-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

To implement the FEAT_EBF16 semantics, we are going to need
the CPUARMState env pointer in every helper function which calls
bfdotadd().

Pass the env pointer through from generated code to the sme_bfmopa
helper. (We'll add the code that uses it when we've adjusted
all the helpers to have access to the env pointer.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 4 ++--
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 659867a1faf..f12d903aa44 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -126,8 +126,8 @@ DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(sme_bfmopa, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
+                   void, env, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_umopa_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 2af2b957cb6..f172225b2f2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1080,8 +1080,8 @@ void HELPER(sme_fmopa_h)(CPUARMState *env,
     }
 }
 
-void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
-                        void *vpm, uint32_t desc)
+void HELPER(sme_bfmopa)(CPUARMState *env, void *vza, void *vzn, void *vzm,
+                        void *vpn, void *vpm, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8e9332f1898..bcb502feb05 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -355,7 +355,7 @@ TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
 
 /* TODO: FEAT_EBF16 */
-TRANS_FEAT(BFMOPA, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_bfmopa)
+TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
-- 
2.34.1


