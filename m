Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BF3CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S8-0007wT-RK; Thu, 07 May 2026 19:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rz-0007O8-Fn
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:15 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rw-0002Ab-1S
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:14 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-435428c81a3so502826fac.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197690; x=1778802490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6OwHShdcvtjgeHyBz/m9h7QN/liBHaPqasCY4NNljY=;
 b=fUWPdmvnR2j2ScBEQGjXUeQUfT5hPYrdMsIH46gmtC4l1+rk1QibdE2oR0riSU+58+
 swM6y4A1fJTW6ES41x+yZpqfozohe48tn1CQkhA4uG2sPnvoywHBV4U8eY0q+i7yzWF6
 wg1lVflxL5aG0xDTDZQpklCRJPjoNGZkLFAGxR7IyGCi4hl+s1+w8KXNMniHwad70gD1
 vi9QC+ykQdUDN0Jm76qZ/kg1yvt2V54xqe1+ny6rjCyVEgAvZkJfmAf2g32BDPFxn7JF
 ntV9wU/7wib0+1Ua4uheprCUL1if6irXelaGi79BrgwaZ68HjmsZ0xe8RYzycYh61GnU
 fznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197690; x=1778802490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6OwHShdcvtjgeHyBz/m9h7QN/liBHaPqasCY4NNljY=;
 b=Nl7wAcX6XFO2VwqOaGZzMHnHhAX6sM6b4KVJiq9hUN6U4iLojggraleVfliKoFOcIV
 xatPYMZsJIjK8Uh99YhkHJhOGEWpuH5UwtKV497XYnuObyDQvfpYpwhNr6HMVmOe7Coa
 Nqp7yPRf7tLNsXd7xwkSuR97b8cnvb0GCEuarYMv538OF17iiRTylk6yqZj4X8TsJhPl
 Xmmkq9D1DvJ0Wsuo2jcmrDoJ6BrSp1UwfKrdX9cJXadb2p/QrlvsoD0RhJje9uHonYqH
 ZWxI6vwJI01Q0xLBRd/olsy0WBttNWAPsCiTNyAx8GL9KAbQv0yJ4OLmhfCD6B2haKE0
 zH1g==
X-Gm-Message-State: AOJu0YynNMQ7iKI/xZ8gj/xp9P5W9KONfTdv1j1upes5bIlhz3HKrUqY
 M/galCeHxaRlJMIM7U2INJaZD9yferFubwBDrP3VF0GLSt3ZkED1zOpz7hZQxDbSHGciV+Ed2j7
 wPFg/
X-Gm-Gg: Acq92OEsd6R74M+BZ/y1Id1FPQwUQrTLZpN2P3zjER4nV+wSE/PKNUnNKSfcTR8S/bU
 SMtKRrS5qZ5rkaDjPGw6rL/CgFeut96ZNmXCnuEmd19VrrjjpTMEUiHspflPcmlMw6G4v5mM531
 WqSv8YHskXiKTknZZQRurCXXzh7RKuCNBWfhuXqMhHAzSahoK2pHiuMnqVTMqDzs4eol1Ky2ark
 YEBw0hzKlVkTkDKFaqQDQVRmsuDEnBiGXHJa0u95d17fsSsOS9qWztVymBZQf2gpL5XerADuCst
 8UHF5C2T+jc0nwGUwiQUSfXIPXfUGhbJ9XvGermLvXGRLE/LVZQD5kD6hK/QpkSd1aePFrMvAhZ
 yhiCFjbdFtp8Rh6PQUcuH9AUjfuB6ggvdvDzmm2SIRkHHpRz9JvOg7ocpyfyJ0CceThGb40q6ek
 eIfHF8Z3JkN8zmbyq00YsQUNWoqEYFUJ3kIUM8gWBPtwq5Jw==
X-Received: by 2002:a05:6871:eb07:b0:424:2672:445f with SMTP id
 586e51a60fabf-43556ebb344mr312016fac.18.1778197690585; 
 Thu, 07 May 2026 16:48:10 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 56/60] target/arm: Implement FMMLA (FP8 to FP32) for SVE
Date: Thu,  7 May 2026 18:44:09 -0500
Message-ID: <20260507234413.643512-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1f1c090ef5..0aaf08eba9 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1687,6 +1687,11 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_bf16(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8d622f9a1c..5bda5f6c01 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8442,3 +8442,19 @@ static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 TRANS(FDOT_hb, do_f8dp2, gen_helper_gvec_fdot_hb, a->rd, a->rn, a->rm, 0)
 TRANS(FDOT_idx_hb, do_f8dp2, gen_helper_gvec_fdot_idx_hb,
       a->rd, a->rn, a->rm, a->index)
+
+static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
+                         gen_helper_gvec_3_ptr *fn)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 26b3c7697a..6610432528 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1808,6 +1808,8 @@ BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
 FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
+FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 Memory Gather Load Group
 
 # SVE2 64-bit gather non-temporal load (scalar plus 64-bit unscaled offsets)
-- 
2.43.0


