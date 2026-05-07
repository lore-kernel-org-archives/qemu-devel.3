Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5ADCD37AD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SC-00087E-ID; Thu, 07 May 2026 19:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8S2-0007Uf-Ha
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:19 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ry-0002Bk-Ig
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:18 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-696ad0c2c2fso837486eaf.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197693; x=1778802493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnjAQy5uQrEwmgSYURuCn+Sb9FbsR2xmUbZI16rxj8g=;
 b=G9P1rBtGPCZdPvDSLwALLDitdM4j5trblIh5IiyLXo8CjQYogH9TsArm/rhoIlv4jN
 VnipEwMcREuC0SKrmS/zAg88PKSC0lbJsgitOoqdkR1zDZvAzpGMA6T788Gn0wSkEwic
 9Mk/E76Vs41BL81AzXI10+asB2ycywzU+PMNXcywuQ8j6E5izS1f1vQyM/1Jdzk03Sww
 Mt/XIMaDXZijA2hY13eEizc5FXfmFi2Rk6VzOvdwKhLnYFYXZoPyYUQ62F6+9nuw13HN
 7HMuAqbV+fsVgJv5W2+vjdktn0FsoNq0x5meaZf9mVvCeiOsdAje/QXgY1AC2BH9/pkK
 z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197693; x=1778802493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pnjAQy5uQrEwmgSYURuCn+Sb9FbsR2xmUbZI16rxj8g=;
 b=ossBA3BFUAA6gt87IKy7b31W4YqUI1A/6nNvq+SMSGO4GHPyrwOpebHzy5Sf+JTyBr
 0yuwR5se5MXkhsb4prvtHmKPWLBMFdPJfKCnLxV5VFOHU/IN1YNSbOUzt/Aefln/3jPL
 5CUSCOfjVf8oreROzVzIJJH5KgMkZMZw6XoCH3JE7E5Hz0MzzkXtwtln7jHyJW3CQMlY
 Ue2KAHFtlP+AGVVtDNG+m1bBN9KaOH7xVoyCI1UesVet+xNFPRS81pgkjHR+Vkj6PVoL
 JnmgSSugQljvpLP7I28KMynHFF1fzDXR8npPk14pPTi8wWIMUzWQZlbZJYtFYrrQdki4
 HhdA==
X-Gm-Message-State: AOJu0YzbYF6Vrw1bFDln2IEbRe10fYaujKkmkGKrDU9HnUnC6hnyoi//
 UZeHtnc1l/Sz03ezPJd+BFLO7nVLkFhf7AYIjQ0XZScguffBeCpZ5CWtLlAkEJvjkwg1AkyLWzv
 6sXFc
X-Gm-Gg: AeBDieu1oAS6icD8yl55fndDbM7/WGbkQPKVYC4JYpi+4lfiBHxCEnS9j9KUZkVxIZY
 Cn39VhDUUGobb07Dkn+Aox+jx6gfe0rJopJlmj1WyduvDrkUFDG4nVxrg5YSTQtCjF2Mm1eOi+u
 Uvz5nh/Xw341uiqR6D2nML/W5UcHOQfgvrY6Y69qS5WYaNynqIdjTmmjFBDPMTOK4AnNCE6Jazm
 Znt0o33rEpjsGsxBrydtahVgxZJksq/raS7kSf0A4BRPVlI/A0ph0zp39k1r13vnrLkN+JWy+82
 xY6qTtg9DCqB1dOZmgUHfwku4MAreZKL8k90SymhUNI/eu4pXvXT3ycksbjkD5ChbdRbqiEeOUh
 N4/0DGyTwMr6xMHo6wSs/GMn2GpT913PdYGL0Ca3sirf2quUY41V6vaKmcqTF6X0sG1alzQLUoo
 BkLWf93GhwzioSPixLWXjv1cHAn4WQb4+Mybl8wIb18dem3w==
X-Received: by 2002:a05:6820:f032:b0:696:2cb1:9ffb with SMTP id
 006d021491bc7-69998d87ca1mr5917504eaf.55.1778197693249; 
 Thu, 07 May 2026 16:48:13 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 59/60] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Thu,  7 May 2026 18:44:12 -0500
Message-ID: <20260507234413.643512-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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
 target/arm/cpu-features.h      | 5 +++++
 target/arm/tcg/translate-sve.c | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 41066ec5f7..546d29979e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1697,6 +1697,11 @@ static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
     return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm4(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bda5f6c01..2bce6a38a2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8458,3 +8458,5 @@ static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
 
 TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
                         gen_helper_gvec_fmmla_sb)
+TRANS_FEAT_NONSTREAMING(FMMLA_hb, aa64_sve2_f8mm4, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 6610432528..b53fe6a58f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1809,6 +1809,7 @@ FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_hb        01100100 01 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 Memory Gather Load Group
 
-- 
2.43.0


