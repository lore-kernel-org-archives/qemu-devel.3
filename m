Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A820DCD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcLM-0001hN-7a; Tue, 02 Jun 2026 23:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLH-0001UD-Bu
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:33 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLF-0004cP-ID
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c32f6ce1so21601245ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457547; x=1781062347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9YCh36KGW4DMNvDs+qzc9ZLkXx+lxkD5bVdA/i8Kk4=;
 b=npOJdKEAS70pK+ll6edxWSL7brneuJMTPX9rIIS9kkZcyihb4T31ytzxIRkMOQB6wx
 gQbKCg7HKnSeOUm8EIBJWjl8qjISz9rMNh6wKDZAvwEH7ew+ipRBVTYWBJuaZGoJS5vk
 TLlTUtOB5LMOYgSdHXF0obtyc3j2tIyOBxUolEhTwrfnu6mftptCJ/lBhNEmowruy0dr
 kCxTkzZEzGLqw8WqEnMv58EBP4c9zzt25lYu+ZbY4+KBjObm1JLwMMi1+NQbIFj1TDqa
 NqMLooCQA3wxc5VTSex6M4NooIDFJ7MyQ1Ti9lJH/R6LphCfpa+borvJAPrm8InQBvz2
 yqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457547; x=1781062347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u9YCh36KGW4DMNvDs+qzc9ZLkXx+lxkD5bVdA/i8Kk4=;
 b=OHzhDR/w5VrtddVqZjuWI7f89c9tDiNFeBivJql2xopRKDSiM5iyYoTV/kyav6i2Sv
 xX+lcrwrNvX61JML3JKlc4FnmHAm2VTfQsPNbMjJ8DOgqs4WhOVQZJv5AdxVjNAyl2Tl
 i+Lbk/wlba1WJoylfBGvngnd4Y5NyZ1VJu/RgYkhGA8dNYo8kV9C3cHtxqzsgIDFtTr5
 DgdY5l60H25v1B897vWfr89S1tZzUDfauwnwBf5EF+pZYaCHucJp4CL76LHI8vTHWBIm
 +7rFJiiwbajjgdJN1ZrAH6NLbelIPthIByoRkFTQyDdjRUZAC5cibbM3M35o9JRUj2oJ
 B43Q==
X-Gm-Message-State: AOJu0Yz/bt8ZDk97ffCkIAzU32VsgBIZJoNjXOc/40z4k5LXiUsUdj9k
 0PaPuIM41U4VTuf1HKRVJBU8wGmKPCilB6bmxIc5uOVu2lAMhr4ibNzP5drSDtewTkDjpFHKQQt
 BIUpSCaI=
X-Gm-Gg: Acq92OGMSk1SIjdlaX19vhWFAkEWaoAqu+C6qnloP5A+Q4qxLDoCMpRbN9ugi7cWIMZ
 lm4F7RZ0WRfhiDJimoi9oxdHbsBYNA1hbV5AdpP+DHxvOqian36/220lyB2aQ87y3OahX+RA88G
 vHshSYkqj/C34hu6nk24HwemUZ5kcbmIZnyU52dq+KSf0gOcSpwWjDrRvFONyU9ANlyfCJGS6Id
 ISetj7Sibk/FTLtKEBt9EEC0FN0zBWkJlYqYXyhG6EsdwtyrsxtIBY/W91HFYMbHrjRl/dpORWL
 VOGKmAe/VnMi/Nwfmr7NdhoNUSQIiiTgCvscrsdbUD9Eg5lqdxmP+LH4HHdeqfYhiADn51vhzNl
 GZBBpwZWsFPq6TmV7zDDNP+lYEeVoG98vXzpg1zzr5oUiC4qKZPHEzznOwHSb01iMKCKEeWbblX
 UVDZZ/6jYGPHIZvvUJCPMA9eER6PQvvWMhdFAVgb4=
X-Received: by 2002:a17:902:f60b:b0:2b9:f59e:aca5 with SMTP id
 d9443c01a7336-2c1644b12c2mr16936155ad.39.1780457546518; 
 Tue, 02 Jun 2026 20:32:26 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm7785685ad.33.2026.06.02.20.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 41/45] target/arm: Implement FMMLA (FP8 to FP32) for SVE
Date: Tue,  2 Jun 2026 20:28:50 -0700
Message-ID: <20260603032855.106930-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1fc8db8d58..2b1d1034c0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1703,6 +1703,11 @@ static inline bool isar_feature_aa64_sve_bf16(const ARMISARegisters *id)
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
index fa0f3d23b2..1def148f64 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8461,3 +8461,19 @@ static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
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


