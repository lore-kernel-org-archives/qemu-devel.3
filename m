Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83AFCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX26F-0000Ap-Ms; Tue, 09 Jun 2026 15:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX225-0003fR-Ik
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21v-00046b-Ko
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c0aa420401so46231245ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032890; x=1781637690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWvX2E867LJtlgVoJHrhCYt8UyQTToQDMYypwmY8Rlc=;
 b=HzSKl2YtByIL/+tfbLcpf3zYP7sQF84fcl9PBWkD94zcOSFtM5F4ClGEwc3M98NYCO
 4FjPwnz43pLJUWcz4s03Td00CgRNWT+gyaQbBrhwxsVdrb80/iQzPbe9wrmeTiGyehQQ
 DLbxvo+38zqa4W63XbCYnGAczFbDHGZR/1M9ceHFu2UPMvAPLVZWnY4N1gMdJG7JRruX
 iHI3wBSCcIFk2udRdrr8T5kf2kH0gTQ4yM/x8zFc1gZsHDw9LrpyFqg9Ed/zBRAE2jFm
 jk+WgNDwnGBYAaKrAPylYu720VVIhYFOnzgkkcN5jPl2qBmO2YqWFiB6qBBr+aCLp94L
 iq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032890; x=1781637690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gWvX2E867LJtlgVoJHrhCYt8UyQTToQDMYypwmY8Rlc=;
 b=JAblv19NK8E9LpTA24B1JJ2zRt387XDh81Cj9hDoH4K/JvjK3Ud6BmJpOTBvTiZDlW
 C+otZxDEFpNt24rCNPK8zEP9Fmdw169cKprNVoLQJ4Dex00voS6UDI65k2Zr0NGPrRLE
 x8flH0+NW4U52C2cctoIL5lRi2Kdoixdi6NGOsFHumCAJ02w0bmgUbk9PSfNBolKDK6Q
 fTIuTnNjOTWwAthj8hQlxxsPkf8rqM8xESdT1r53U2IAUOD3y1IS12UzQU3irsjdk/N1
 5PicySw/obC07TK2oUtPG3Xo4YQXnZLCe4m9TB0yH6KOd1MUFcjifuPyQxHrkHNIHads
 hWjg==
X-Gm-Message-State: AOJu0YzRt/n+Moj5TuJvbAqctYoykoSDuaojcRz4NDXEIXWtqnEZb0kH
 /QvCL5h+cOUDZqlq7nTc2my6GsUHWqggLwJ2yLQkFmS9bv1k87dCd1JLG7nczaqEyit4YsyebF5
 2FwT1YpQ=
X-Gm-Gg: Acq92OEsgzDatrcurb2ayRoactnBsYc9kvqIfLiYLwyoONaGmR632ZQVjZBU0RieZaV
 oAuklV/Gm0iCaP+ZneLGUEliXywWFuVlmNa1r7FxlBb9mdO4x9J5XOk9jGLq0p0PWhwDtIgBSlG
 MdU12OjW0m0TkIT5Lcn26yhqr0ylu+rgOszlOXLZnDG0VqbmlpKXCznjmLGjZMIIQwB9Y/R56FT
 AHwHudDFx82Cj12uy3Wdkpd2O3ZnZs2mSXG3yFlCRIFydzn1Ah10sQR1FCBN/lPzQVCJIQcAxFP
 lXmmnHQRd/XuTGWE1WcyETaAaoaa2AjbdbMPHWmiqowMg1VbGI/ER2o/CrQt8khgfvEWb0iogtv
 we/z1XJ4tqCqAmT8QuWYiE7mC8Osugutj4VspB8EOfsSAUq/RbmQ30dsNxAYIX6+G6a2huY6G3g
 x1o1MopOZ6VCHZXjW6eqweaf1X6O8+piila21Va1s=
X-Received: by 2002:a17:903:1209:b0:2c0:c3ac:4ae6 with SMTP id
 d9443c01a7336-2c1e810b983mr236269095ad.19.1781032890277; 
 Tue, 09 Jun 2026 12:21:30 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 26/45] target/arm: Implement MOVT (vector to table)
Date: Tue,  9 Jun 2026 12:20:50 -0700
Message-ID: <20260609192110.752384-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 18 ++++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 3a754f8d61..050a826849 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_sme_lutv2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, LUTv2);
+}
+
 static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) != 0;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 76bbacfb6e..c4bede2ae3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -391,6 +391,24 @@ static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
 TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
 TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
 
+static bool trans_MOVT_ztz(DisasContext *s, arg_MOVT_ztz *a)
+{
+    if (!dc_isar_feature(aa64_sme_lutv2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int tsize = MIN(svl, 64);
+        int offset = (a->off % (64 / tsize)) * tsize;
+
+        tcg_gen_gvec_mov(MO_64,
+                         offsetof(CPUARMState, za_state.zt0) + offset,
+                         vec_full_reg_offset(s, a->rt), tsize,
+                         offset ? tsize : 64);
+    }
+    return true;
+}
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i64);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 2b9e41a75a..339de72b8a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -141,6 +141,8 @@ MOVAZ_zt4       11000000 11 00011 0 v:1 .. 00110 za:3 zr:3 00 \
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
 MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
 
+MOVT_ztz        1100 0000 0100 1111 00 off:2 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za off v:bool st:bool
-- 
2.43.0


