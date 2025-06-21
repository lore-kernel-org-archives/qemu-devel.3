Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE74C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zF-0005CJ-4h; Sat, 21 Jun 2025 19:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z9-000597-V1
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z8-0004VU-G9
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747fc7506d4so2280045b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549857; x=1751154657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hIj+vAX7G/hkpgAg2HdGgQ1SLPFC32HCJxDHBBELnHg=;
 b=u3KNoxyJGshyLE49le4OZ7PTVsyIOK//Am68KWJs/Be55FtGEIusKmK1QnxHNIXDsc
 QXikVsfR2c7EXXHFdBALj6UGCrlZ3euhh8C1A3R0Z+/ZMFsv6II6lXQrwQuq9IpoNaws
 4Ye8W3aDwvCM3s9m/f//sBsT/3Ou/fPQ0aSCU3akTig0orxP1Suepjng71Z59uPYfTl2
 XMzhF5iKDy6hxYTGGjhviDHgAan+3FyXDwSSTAmdeH/Z3kVypqD1YukJcj6Z3NW9xfgd
 IQYX59I/yhvDGkVWRjXBQ3KlTkQLOUuDr8DdXta1vG3/mOYWvdRzAkSNXxAV1XCoq2am
 x8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549857; x=1751154657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIj+vAX7G/hkpgAg2HdGgQ1SLPFC32HCJxDHBBELnHg=;
 b=k5WHc0yiVhaaVgFSdtknhcbvFDCtSKuJbD2kWazg2PY0f+KAFWVUu4ecunxEth1N4y
 RT5igrrOB8VcR3VFnIw/0nV0k2fjk6J4Tg131PATayxQRUW5zW1G1aZUteCJTmuwX22O
 yKo6WYKVYcC+Jm2UcrMXjtzXMa72d9UgxWj6gYUfOFoTpBLxRH4rmZMULhMKVdZsl8v3
 /OpclI8zqGKRwCd68/RtoU/2WLEbca5pGEeQUAsUQgjnTstY4/3NWbAxHJ+UeafgsUtR
 bjqYFd2a+oyExikdSN2bpL7dBjXC2T4Qa6VKAljbPLkavCDWO9TA6J3yOBwoNBsyQ98Q
 sXaA==
X-Gm-Message-State: AOJu0YxQ+MJ3RXK9RHYskvPpkvPc6XK7GhTS2uVubVuSbcA+roIQ0Hxg
 QXc4s837+2ScZQsHZJFI7c8rLvUpSlbYsJFLL9A2oU13ZJNXOsu2H6hD4fOOldlqWzysRig6drA
 iC197
X-Gm-Gg: ASbGnctsT1ew/fns3uoSNpapq3xOpglHckt9gJ331PBMwbNDbCXdDFHLLmrJtHkVlhZ
 vhN7N/TMXWKbkfi9IEGXReODEMFOKa8ubXg58hvfCfNjp16lgpOQ93VdD6n6e/a/f2QwaiBCqkR
 xyVuDKq0BeKsHmawlyxwEYJmQneUNLHw312xz4qv6tY1OeR05GYAnYOQsYqQSWZSD0LwAGK9U/P
 Mhupm1gsXeF9TmVGQbR18cvdVB+siV0H/x/NPjypG1kSiey3v9LDoPr51V1/JgwCNSHEBon614q
 30Kmxy2AvvDcNvDC97/EjUVgczJDxKxSrdwnYKZczfOoHeXUSl4QRM/Odc7IUsGZpwPqPNjgcTj
 D+9sOMr3h13p3CbMQ2g4C
X-Google-Smtp-Source: AGHT+IGHdXHBJAmLUiBvrAxV34fvSBeeCTJTzAPWlpfDPnQfZeX+Zex8eJYxb+M1bVLXxtG0m/HEnA==
X-Received: by 2002:a05:6a00:1d22:b0:749:1d18:2c74 with SMTP id
 d2e1a72fcca58-7491d182d9fmr5293982b3a.10.1750549857224; 
 Sat, 21 Jun 2025 16:50:57 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 028/101] target/arm: Introduce gen_gvec_sve2_sqdmulh
Date: Sat, 21 Jun 2025 16:49:24 -0700
Message-ID: <20250621235037.74091-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

To be used by both SVE2 and SME2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  4 ++++
 target/arm/tcg/gengvec64.c     | 11 +++++++++++
 target/arm/tcg/translate-sve.c |  8 +-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index b2420f59eb..3649602f4b 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,6 +225,10 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz);
+
 void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
 void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
 
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2617cde0a5..2429cab1b8 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -369,3 +369,14 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
+
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
+        gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
+    };
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f3cf028cb9..87b6e4a88e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5911,6 +5911,7 @@ TRANS_FEAT(MOVPRFX_z, aa64_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
  */
 
 TRANS_FEAT(MUL_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
+TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
 
 static gen_helper_gvec_3 * const smulh_zzz_fns[4] = {
     gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
@@ -5929,13 +5930,6 @@ TRANS_FEAT(UMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(PMUL_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
            gen_helper_gvec_pmul_b, a, 0)
 
-static gen_helper_gvec_3 * const sqdmulh_zzz_fns[4] = {
-    gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
-    gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
-};
-TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
-           sqdmulh_zzz_fns[a->esz], a, 0)
-
 static gen_helper_gvec_3 * const sqrdmulh_zzz_fns[4] = {
     gen_helper_sve2_sqrdmulh_b, gen_helper_sve2_sqrdmulh_h,
     gen_helper_sve2_sqrdmulh_s, gen_helper_sve2_sqrdmulh_d,
-- 
2.43.0


