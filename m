Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43645C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwnX-00010N-UI; Wed, 02 Jul 2025 08:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjZ-0004Ps-Hn
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:45 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjN-000285-BH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:40 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2efa219b5bbso1276943fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459906; x=1752064706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYKrs7/vnCW+3D9Wa8KDDkWEpeNBkgolpoiBmK9XdxM=;
 b=Z5oRp/2PV1KOH9BayBM59kBj9a46zKv/RSmoF9Vs/bN2cLpr564Wh63UoAOJCTwBqw
 t5K/oDha2lIOt69ZuILLK3qGFpzpteeVONXwsIZvmEOs/t5bZBbOP9sMncB6syGlUesr
 IaRCRBisnKcFaz6JCw9U65E/wQRY0I2gYAXkWIc6ADRkcNpF9gnduWe3+mqbYVE96xfS
 YAPuj1oBTyoSQeBthwszmWRUJrzL/C+WCRWT4i90XrHFgbqqJjB7DdSc3n2phZcNdfIa
 POP5sWoDXa0tujbYEaYlwqM2dNcZ0CVcozxD0OBKJ1lwO7/c9fJrSdUBPqF1FOS4zZux
 jwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459906; x=1752064706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYKrs7/vnCW+3D9Wa8KDDkWEpeNBkgolpoiBmK9XdxM=;
 b=s4B0gxZPQvACFiG0JNQCS3gH9Kj+gAezy3L/ioUyMtGyKGRCPrCCJblUMy878DD4Wv
 SHo2pQDbsy76fAGlHeftIS4BPH2lhalYNwmM1WJwYeUu7zDLfdcuEleNmpGVdglBtgEy
 kW7kYVKXJejxbSbjJTWCwdFK5rcb9Z+l9+z7KP+faxw2M2bF5n1GIM1Hj9qJGsW209IC
 pj7cq4GEU89SXntIsCyHuH9pUx8dU8L0Dp52qZhkTSOLXzFTl2+X/y0na/TbNhUvvSyB
 XVo6fbVSR/HXyVsB01Ck5y+3SmVEigqb5CmxRZgBP9vhDjH4oigcpu//c34vhkeyqaey
 3KnA==
X-Gm-Message-State: AOJu0YzUxBrPsZX0X7rTC1gFWUW4A+COgH9iX3u/ZCsEuY5j9tjiAmLz
 1zcU34/CLBfwQyZwD3WsbOtPXuSo9/5NzgU7cPx3oOJUcBij3+Z3ihRXjV5SyQ8eaS4suMuT6Sm
 UPdN8pz4=
X-Gm-Gg: ASbGncsknUWnT/Ui/WHVVvXZTeGSivPFAa/PRGITYpcReXF9AjaYYWwqT9l+wOUPDkY
 or+7M5gd3yFd4gWVuCH9rPH8xhTLhNGCMWWcTi3EH6RG0kR+1J3Levy8hTynw0FWwXEIIX5sSv7
 N0zQ/SDs84dRyFpWo9QtehDvyDNk1WIbK4aNqeN09ZhNcFcoNXRhz/UVeW20zrQiUo/tzXF0Rue
 uXLXO4ct45rfNTLHPS5VtW07ovWU2QLEez4SKkpIgJPwR6TX0I2I7EDAp0GKLkLowXTdYQGaAMn
 NVcFBKpBdg1q/U1s8nSFZYHf8hSU6yrUSPAgrnP5UX9++SU/TH7DRPXwGVOVbzhIQUYCcA==
X-Google-Smtp-Source: AGHT+IGwoHkEHB0tWzN234xQKd3Tf3qaIC4hOtxlwsRTmlGTBhlhpRvnRsN7+3o8xEbC5HnjU1F7xg==
X-Received: by 2002:a05:6870:9602:b0:2a3:c5fe:29b9 with SMTP id
 586e51a60fabf-2f5c7d5790amr2167207fac.29.1751459906609; 
 Wed, 02 Jul 2025 05:38:26 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 58/97] target/arm: Implement FCLAMP for SME2, SVE2p1
Date: Wed,  2 Jul 2025 06:33:31 -0600
Message-ID: <20250702123410.761208-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

This is the single vector version within SVE decode space.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff70bf27b0..210a029ab8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7428,6 +7428,28 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 
 TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
+static bool trans_FCLAMP(DisasContext *s, arg_FCLAMP *a)
+{
+    static gen_helper_gvec_3_ptr * const fn[] = {
+        gen_helper_sme2_bfclamp,
+        gen_helper_sme2_fclamp_h,
+        gen_helper_sme2_fclamp_s,
+        gen_helper_sme2_fclamp_d,
+    };
+
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (a->esz == MO_8
+        ? !dc_isar_feature(aa64_sve_b16b16, s)
+        : !dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+
+    /* So far we never optimize rda with MOVPRFX */
+    assert(a->rd == a->ra);
+    return gen_gvec_fpst_zzz(s, fn[a->esz], a->rd, a->rn, a->rm, 1,
+                             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
 TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f808362f23..dcfc40ef44 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1721,3 +1721,5 @@ PSEL            00100101 .1 1 000 .. 01 .... 0 .... 0 ....  \
 
 SCLAMP          01000100 .. 0 ..... 110000 ..... .....          @rda_rn_rm
 UCLAMP          01000100 .. 0 ..... 110001 ..... .....          @rda_rn_rm
+
+FCLAMP          01100100 .. 1 ..... 001001 ..... .....          @rda_rn_rm
-- 
2.43.0


