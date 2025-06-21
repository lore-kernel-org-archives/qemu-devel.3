Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F3AC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85u-0006wn-Gk; Sat, 21 Jun 2025 19:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85a-0005D1-RW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85Y-0006bX-Mg
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso2303455b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550255; x=1751155055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6OPetRAKYnryfLtVC7s64bomEynGoXq4yJo/wjOWV/0=;
 b=UYJUUL7Ma2/tuMKureJMlRNSzBeuGoXt5Arzui0+FxmLyegzqd5AcL+5/HUeLimLZH
 OKz5fxKU7KfzaIzCUzh1ZCCTSzcgvHRsHtoEz0bpiN9+tkOZGI1cp7iZ40EaqolC84m8
 OLyLgf06jtuChhBFFWL3yCHjGY2OytcXjQyHu2AOImiDqBnhXpUHh0xSYV1DVbTFZyXj
 /h8DPAws86DtTPGMnBpEm5O1FZMinF+hG0wB0Jlb1vSGpkHLqToJHq2ww2Fz2aXigTFf
 f6Na7PtbaXAoBXeNmUwfdqqPxQWe2YtOhY6wSnnssHUIOx7s1Cttn8YRb6OhH18MtpaI
 iKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550255; x=1751155055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OPetRAKYnryfLtVC7s64bomEynGoXq4yJo/wjOWV/0=;
 b=a3wjqtvNjWLm+1alFtEFvtjmA91HkZTPAoSeO/diG3mKz4Iv9BlMiAIKRttamor5Wk
 2wSgHep6b/cunC+hinS/o+ycFzkJbF5ex1qM7exBUkXgGwQoUXYnmY8JGjtJLgaE9J1Z
 3H5FYOcv3lI+xMFTbqWAJMXM9CjWonyR/wibNJDw1PGkgAAskbfmE32heFh70Yf/N0kh
 uMlI9moTXCrmbybRcQrJ0kD9sNFjwx24XPr9Ofg/0/t5UsMwu+mJGPxattGCAlm0rrML
 11ABOchYkWu0SyB5aq9p23e4H3y3+5tDDsPN3poOgkYCt/PdAilFNqUXf9wSiF5RNbvt
 NlWA==
X-Gm-Message-State: AOJu0YwZyJbWa5KcOI89OZTRSdRuh94fxRtg0Bs48CRw8qa8r7h5yLcC
 GEr3P8KGwrw5lQeFayUGnqALIpS7ZqIDgCGpnO/hoIExheUoWxxlnSE1XPmHSnlcDSmTfEEvS9g
 78Pytx3w=
X-Gm-Gg: ASbGncvN3mnpZGZyNIzKU/WlAfTWDl/aGXHyeUlIEWut8Bnzm6aj4n2TTalTLC4DCga
 2fk/izTxf0HglkrEmFz6iOg89KU4fAKifreHMBbGL7Qc79HdsArJX1/bLz9rPRzu07jJR7Ci26E
 TrCZ0UBQyzTLTxifjmKViTsEqsJyOQD1X8frEQOZoP+tqD6ZoWMzJBmtmueuQQ+/D7R0nZ2qv2b
 9i1xxwubEwJ8SYpGe5zQjDp5cffzUXdL/YNEZsb0MrE06gMO1Pk7wm4rYPQNoinmrXpwvTWV5ld
 5kk5BKQjzOKBqq0An7LJp7JIlJbhUkfOwrjZUvhVZCRO9hZdGCtknbP5v/d0U5Ve4Thl00b2So8
 7NDCJLFoXp1KFOs7rikcC
X-Google-Smtp-Source: AGHT+IFBFALE+G9V7kWJ6CPC1E/06tyiPpFiMmDf16E2AzfrVwus2OI567zj6aikTJf/XSf000CreA==
X-Received: by 2002:a05:6a00:9286:b0:740:6f69:f52a with SMTP id
 d2e1a72fcca58-7490d56157dmr10455334b3a.0.1750550254843; 
 Sat, 21 Jun 2025 16:57:34 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 087/101] target/arm: Implement EXTQ for SME2p1/SVE2p1
Date: Sat, 21 Jun 2025 16:50:23 -0700
Message-ID: <20250621235037.74091-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8e48b8aafa..613988b15f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2202,6 +2202,55 @@ static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
 TRANS_FEAT(EXT, aa64_sve, do_EXT, a->rd, a->rn, a->rm, a->imm)
 TRANS_FEAT(EXT_sve2, aa64_sve2, do_EXT, a->rd, a->rn, (a->rn + 1) % 32, a->imm)
 
+static bool trans_EXTQ(DisasContext *s, arg_EXTQ *a)
+{
+    unsigned vl, dofs, sofs0, sofs1, sofs2, imm;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    imm = a->imm;
+    if (imm == 0) {
+        /* So far we never optimize Zdn with MOVPRFX, so zd = zn is a nop. */
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    dofs = vec_full_reg_offset(s, a->rd);
+    sofs2 = vec_full_reg_offset(s, a->rn);
+
+    if (imm & 8) {
+        sofs0 = dofs + 8;
+        sofs1 = sofs2;
+        sofs2 += 8;
+    } else {
+        sofs0 = dofs;
+        sofs1 = dofs + 8;
+    }
+    imm = (imm & 7) << 3;
+
+    for (unsigned i = 0; i < vl; i += 16) {
+        TCGv_i64 s0 = tcg_temp_new_i64();
+        TCGv_i64 s1 = tcg_temp_new_i64();
+        TCGv_i64 s2 = tcg_temp_new_i64();
+
+        tcg_gen_ld_i64(s0, tcg_env, sofs0 + i);
+        tcg_gen_ld_i64(s1, tcg_env, sofs1 + i);
+        tcg_gen_ld_i64(s2, tcg_env, sofs2 + i);
+
+        tcg_gen_extract2_i64(s0, s0, s1, imm);
+        tcg_gen_extract2_i64(s1, s1, s2, imm);
+
+        tcg_gen_st_i64(s0, tcg_env, dofs + i);
+        tcg_gen_st_i64(s1, tcg_env, dofs + i + 8);
+    }
+    return true;
+}
+
 /*
  *** SVE Permute - Unpredicated Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 03e771b129..ef270efd3b 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -583,6 +583,8 @@ DUPQ            00000101 001 imm:3   10 001001 rn:5 rd:5        &rri_esz esz=1
 DUPQ            00000101 001 imm:2  100 001001 rn:5 rd:5        &rri_esz esz=2
 DUPQ            00000101 001 imm:1 1000 001001 rn:5 rd:5        &rri_esz esz=3
 
+EXTQ            00000101 0110 imm:4 001001 rn:5 rd:5            &rri
+
 # SVE insert SIMD&FP scalar register
 INSR_f          00000101 .. 1 10100 001110 ..... .....          @rdn_rm
 
-- 
2.43.0


