Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3A8FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFE1-00074U-4v; Wed, 29 Apr 2026 20:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDm-0006UC-84
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFDi-0007V7-A0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82fb2d0c5d1so992915b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508732; x=1778113532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Egvrkp8neGq2B7wyhDnAd5c3Q0Mh02xDjeK027QYBw0=;
 b=kXSa6HVhnO3JAaSsTYVK9cuhudyZ231ajUzWcIDIyvqs5BnL0H0TSGYIT5vDeCUXof
 nGibS09v5MC8/l6LMPYLo5CxauN0MRYEd+3gtGSfxa+rV8IjuqL/KOo3PLLmtcyT3qbo
 qzwp46+meuHODyibRgNND1+f54o2lCk1Gm6Hx9JKl2X0JSx+cFCPnm4HRhlBCeZXDAJR
 1Np5sQZRLv03pYEKDKgbFKNdO47x00eEMK/H4kPfsB5jkwticwjjKvV2ey2jTUfNK5il
 CL8XCkZhYyGaPYb7eDW8kvHYj4Vreypa2oxWS0IXDRr+7lFCuIBeDD6mLCctxFet0CDa
 xZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508732; x=1778113532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Egvrkp8neGq2B7wyhDnAd5c3Q0Mh02xDjeK027QYBw0=;
 b=WexS7133bcqF6MQvjuC2OiK/G22BRr1skZG3pn5PL8O7qQA/yRe706gmBqD9aHksKJ
 nKqXWzHrKVeZDLCryTvQZ39OB0ZCjj0bwsouNmmHZOECr6zZXJn9HCyIS3+o2usb0m8I
 zk1PkaLThprObdg1eBrMHF+2wra+OmlC42D9YDGwqJvIPR49QYQKhIe9J8//Me5btoh2
 45ljetxYhMfhwiWR70geoj5r0Iu+/lKhC3UdR7yh5jN+Jci4hZife+lCDItOmFCC1BzH
 lxp8aWbDGn0i344IoBGCogdN9/hA79R7Yp3bgbfR0a7+6JJIYRqzFzQetBGayJ7Vzb7B
 bKOQ==
X-Gm-Message-State: AOJu0Yxki2YaJiiiL2kDYdjj0qHz07iD6gYXAa/i6f+Kf+S/VRoS2dQq
 w0XJl78IR5U5vCEmQ8Z2gEoSFyKtxOImz/JDwHC92A1kSLNL6AtrG8pCqoZjuBeIMohIUg7FEqE
 gTZYt40M=
X-Gm-Gg: AeBDies6FzH+JmDridgnxnifYLMI8XRrfBlf2rZSdURSh3bYMGnrPdCrGQbtlaxP6Hn
 7cuWShzwKxNxUQV17tstNEuc40q/oTBgFtrbsGeq868MBlE7cmvxTyLeCo86yV/A8GXPPXZDCif
 T++LysICqgE9R3Y9VKHbopH4Sb1DwczfqGo26cKJqFboa7087ORJ3ONvifXb3pBO6yJEZD4EyF9
 4P+VhSHf3NUurOtNNJphJGT+TlC38ksT9GUEbDQO9DqlMaQ+yySJX/FmHE4UyVGjbgLwHoydfbh
 EUh3xrZKfIfVNWMn+wiMvmguqYgYIoq4kQQBxv3f8jxS9k7+rdxPCiEk7bkok/Xt7bL3t3PzkSi
 2J2DVnGqrhFl3hsV2+5deVrfKS5tHrD559rpXxdOnDy3msy5z2Rrf7eAR0E1Yq7I5z3QpDeRRTm
 +SisgQ0wGAG5n3t2KhPgB1htad8GpPjiWjwGBX7+6g
X-Received: by 2002:a05:6a20:3949:b0:3a3:21db:8ecb with SMTP id
 adf61e73a8af0-3a3d1cf2c02mr310826637.14.1777508731696; 
 Wed, 29 Apr 2026 17:25:31 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd64f21b4sm3204112a12.21.2026.04.29.17.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:25:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 44/47] target/arm: Implement FMLALB,
 FMLALT (FP8 to FP16) for SVE
Date: Thu, 30 Apr 2026 10:20:43 +1000
Message-ID: <20260430002046.59739-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/arm/tcg/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index db31ac6b6b..1cefb21b0e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1531,6 +1531,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ea0d66178e..aa785fa0c3 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8336,3 +8336,36 @@ static bool trans_LUTI4_2h(DisasContext *s, arg_LUTI4_2h *a)
     }
     return true;
 }
+
+static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
+{
+    bool fp8fma = dc_isar_feature(aa64_f8fma, s);
+    bool ssve_fp8fma = dc_isar_feature(aa64_ssve_f8fma, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8fma || (fp8fma && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8fma) {
+            s->is_nonstreaming = !ssve_fp8fma;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz,
+                           a->idxn | (a->idxm << 2), fn);
+    }
+    return true;
+}
+
+TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
+TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a11ea08eb3..e6c8e8fec3 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -29,6 +29,7 @@
 %imm9_16_10     16:s6 10:3
 %size_23        23:2
 %dtype_23_13    23:2 13:2
+%index4_19_10   19:2 10:2
 %index3_22_19   22:1 19:2
 %index3_22_17   22:1 17:2
 %index3_22_12   22:2 12:1
@@ -73,6 +74,7 @@
 &rri            rd rn imm
 &rr_dbm         rd rn dbm
 &rrri           rd rn rm imm
+&rxx            rd rn rm idxn idxm
 &rri_esz        rd rn imm esz
 &rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
@@ -1864,6 +1866,8 @@ BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
+FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1880,6 +1884,9 @@ BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
+FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


