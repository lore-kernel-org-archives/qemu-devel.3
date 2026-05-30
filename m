Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72300CD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrH-00006n-QK; Sat, 30 May 2026 19:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrC-0008UW-Eu
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:42 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrA-0007Tz-Kp
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:42 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36d98b5e4dcso66304a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182759; x=1780787559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzF/aqOR8nU7ylzc54YGA12ZwczKRZX6pgS4Dyl5Z5o=;
 b=dBpM1fT6Is0sxeugA08tptcvlofybIFSBnXYusj2dEUprAIrk31nL2U2GwY9r9MQfD
 QvF0ZypckCyMS9g+D2XbZOqzYAOCYA+P2SxkItY/xwzTCTKzrxKCDOZGxLNQeM2zL/B/
 l5cYOVtSTih5UEWV6gvv0tC39yKWrZjCaXM1n4Rp0oo+cFNhk/fvvxEL/AM/1OuoiBgy
 MtLpp7JTvh5PDaMfhxZu3J8oTRcSefQkrFE3iCw571ip5GBDea2iZjKn2BlQzzFThKKL
 kMhi4gSpFfz/hPlYnSaoirLMP8wmRBOP2yTbOwktxXk1pAmzP+mmVYdg6XiGFSor3HsI
 1pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182759; x=1780787559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IzF/aqOR8nU7ylzc54YGA12ZwczKRZX6pgS4Dyl5Z5o=;
 b=CcrEShMMyhdbBa6Xa+RabeGCD64dqu6RWWI5yK0xUf3QNFb0JqLSGGzjc+sKYjH5YR
 XrQDwxLd+T5XTZe3U218rBseEKCnnAs6zdPFDJWrleRgB+AzBrcAaurhSv9JikE2BDwM
 MX46T4aUAHc+VJ+ES/gssyhe8FZSKcF8floeaIIPqVUBy3TCZqys5FPGo/gVv/MnQjuI
 rCFE3hOaw+Pw2mIVIfo2PYYmM8Z5VZR0Fn349S1k6rdr0pAcsdOBzzXPnLlSSTrRy0El
 w8fFm87futJyjuH72YEIycotF1HvuDq7tsuRo7zcKCaWSjfS0sHI1oAQdrZ3xG+2QCgp
 WYFg==
X-Gm-Message-State: AOJu0YwTQjzQcKkRvxIcBIMMyk3kpp5CybpBVq/ARFGLfye+UQdw7wwf
 2XW2ZN4w4gf8vKo51kEaWs1eL0KTV/0we5ri+LvdVvODigGJTDp38DB/nfy/Hr8hzs3ShQI7njF
 C2nhJdM0=
X-Gm-Gg: Acq92OFCAR9Iz+SWhysacRNTR4N+qWSg5m4BdszjM81jfLl8XJTRgWL9kfBopEYprb2
 Fmzt5kDxtAvzUtK28gUvDsp0y9fznMdRGmDUoUdvaJwcML/EeGy6kj9ihgVkVC5/jUAAWhciZv+
 6Jb3V85asWKwZVFa4uomudA9fWR9/x+Unvrn2x2T3GMjxhlucjt8PgaDExebZQ7NmFrV+3c44dk
 L7ulvcfBnBiTqBw/hwOBXSnM/r6EtUHeQV65bqiw//8ZPA0hm/2dsiZTzpciED/1Lj7n4gacggY
 ZJRnn2bWWE4nAqnkOOuRuANwEv1Gc+gVBLINMIw/hi4/2xgKWI0iObLyCiT+Bbgc7ub/6Jx9M0x
 cHBmzoLU0IuEKy/ymFGV+4miO/YCRAp5tAjQvwP+EtZH+c7tghkhJADy6dRXAnQqgTlR5HYkcr+
 satTuwDs8fmiDdbMQZo9MSTWsggtCoKlZKKYwdwUQ=
X-Received: by 2002:a05:6a20:3ca7:b0:3a5:8542:61a4 with SMTP id
 adf61e73a8af0-3b42823c97bmr4942078637.25.1780182759163; 
 Sat, 30 May 2026 16:12:39 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 08/41] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Sat, 30 May 2026 16:11:56 -0700
Message-ID: <20260530231229.400441-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0f3c279696..75c89203fe 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -168,6 +168,22 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_cvt_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0b03afe7a1..66a40059a2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4082,6 +4082,15 @@ static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
+TRANS_FEAT_STREAMING_SME2(F1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, false, false)
+TRANS_FEAT_STREAMING_SME2(F2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, true, false)
+TRANS_FEAT_STREAMING_SME2(F1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, false, true)
+TRANS_FEAT_STREAMING_SME2(F2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, true, true)
+
 TRANS_FEAT_STREAMING_SME2(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
                           gen_helper_sve2_bfcvt, false, false)
 TRANS_FEAT_STREAMING_SME2(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e7984fa8e0..ca110f4bc1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1091,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+F1CVT           01100101 00 001 000 001100 ..... .....          @rd_rn_e0
+F2CVT           01100101 00 001 000 001101 ..... .....          @rd_rn_e0
+F1CVTLT         01100101 00 001 001 001100 ..... .....          @rd_rn_e0
+F2CVTLT         01100101 00 001 001 001101 ..... .....          @rd_rn_e0
+
 BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
 BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
-- 
2.43.0


