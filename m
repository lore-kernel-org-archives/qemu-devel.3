Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCAAC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggit-0007fA-C7; Mon, 06 Jul 2026 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggim-0007NS-ON
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggih-0003VT-Pa
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493bab44440so14922065e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334314; x=1783939114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fo+9pG3xZhFDHuvwy7kh0EKLAhh40YeZ9qlEBHYTK9w=;
 b=TALztmN3D2+EdwIp4dwUkK90e1H5/5/ppBGtj6Meb7/HMZlfhBU0cOJp1hiwOVZGZz
 ZaDA6/efA5OsKMoc3dx0VF4YuRCS5qz6qVVh5BmLwyd9hhjJjcJ1N9ZfUAYMArYVZRLL
 sngCEv1n8IjFdwTcMbDBk7xb97vgYOjLmwiYmovlbyjQOi8qj3+NpWTKmFE4rEjuYbZ9
 4KmcLc/bue6kFhfMJvWSc4dFhNxQzoWiXjUkQyDYX0hO6w1isSlJRTUFJHX9vI0XmpQz
 MeCEOofb2F50RQ9abfwB7G5flblJJT1fYlWReGAjf3NXyK2zJJswN4wjzt7K9QUa9Okm
 nheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334314; x=1783939114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fo+9pG3xZhFDHuvwy7kh0EKLAhh40YeZ9qlEBHYTK9w=;
 b=lFg1ckMcEIKmZjz+TYN0SFetlbT18DsOXAAw0/y6V3JHsvWIujbGGtV3YoQQ+oG4+J
 gi+NyzKCZ3PLDaUVmG9kecAlV7Eg7641Vv+8cv6erQYoZEe3+gYmPpJy9zz7HxW2fAxj
 +DzzSqPI1i+p+m4AcK/VeOVo6ehXi418sULhB8E1P/ypdFpK3sSGl88XKeYHg7Kf7Zq8
 CW4Uin3qqfodrrMIJR6h5oFkVsGtAXLJ4TLMPV6+yaRoRW4IkDNND6y4NJflhi3Tjbv5
 IxUaSO4HODwIeJG7RpyakfWFm+Ew1IB6ouU3m66AXZrNTWhFvQLw5ibv3cpFyQHLqc43
 jr9Q==
X-Gm-Message-State: AOJu0YxY2YAbE6EF4/yCx8eV3v8Lg9ufzbXowrU/L+6zJ587Yi5ejprp
 X97tqxJaWbmudKX9iYve9j2tpDD7AhxlIa8DhtF6+46WfrFAjdMQ3A3cTFE3Lzjutxijoos2g9P
 TbqbREMLZ1A==
X-Gm-Gg: AfdE7cmVckcnbgvEfVzlIis4fdMNwYmBX+3QA4QmUtfvw5Nymc2T731g4O+GQHfOoeA
 Fp10DBFe7hnQbkcIpF3UTe6ocqjL7/Qw1BslaSNmbbnAbU7bEZdk6Ut2tAA55jkZ7158kz0n5tX
 TsjLkbcqli88jXFvO1iLLfHIX+jbtym9kWded2GkvFMvzR9SpvV+N7iiktRfmemcLJiPqdAOg6Z
 wYFyQ5o4tJCOWVI/tRvoC9jYCkTWAb5h1YzMNUj1pqDw8xUhy3ge8F2MpUgnlV7knV/+LW3NHcQ
 X+wROhsWtJviafcRt5pOner56ZWOpoMdRBABOli5EoY2TRRh+f4YsnFc3G7D070gc+lM3lIBxA9
 WKsVD211Vz+PLAzyr+cviFTY8h3lRmLWAySwTNNe0StOMVi1NlpNguVCIbI80S+6tRJ29MZQFcZ
 OAFDbyhw5QAzDUqef0t6LwSHcGcB7EOSWu7Zu+O+T77qUz6HN+qCUKuk66wWN1LZhKfbM21KmuK
 1tnQVEEJQyZfp5T350Txg==
X-Received: by 2002:a05:600c:3145:b0:493:cbdc:7cd2 with SMTP id
 5b1f17b1804b1-493decb3dd3mr1301915e9.3.1783334314396; 
 Mon, 06 Jul 2026 03:38:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/49] target/arm: Implement FMOP4A (widening, 2-way,
 FP8 to FP16)
Date: Mon,  6 Jul 2026 11:37:41 +0100
Message-ID: <20260706103752.320511-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sme.decode        |  3 +++
 target/arm/tcg/translate-sme.c   |  2 ++
 5 files changed, 27 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e577880ab0..29b4f99aeb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1827,6 +1827,11 @@ static inline bool isar_feature_aa64_sme_mop4_f8f32(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f8f32(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f8f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f8f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index f899a6cbf7..4b046f5f26 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -989,3 +989,19 @@ void HELPER(sme_fmop4a_sb)(void *vza, void *vzn, void *vzm,
     FP8MulContext ctx = fp8_mul_start(env, -1);
     sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float32), inner_fmop4a_sb);
 }
+
+static void inner_fmop4a_hb(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd;
+    uint16_t *n = vn, *m = vm;
+    FP8MulContext *ctx = vinfo;
+
+    *d = f8dotadd_h(*n, *m, 2, *d, ctx);
+}
+
+void HELPER(sme_fmop4a_hb)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float16), inner_fmop4a_hb);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 47f35a82dc..dedbd8541c 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -46,3 +46,4 @@ DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4a_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index b8b507d8fb..4b7a99e203 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1101,6 +1101,8 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 @mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+@mop4_o1_s0     .... .... ... m:1 .... .... .. n:1 ... . .... zad:1 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn s=0
 @mop4_o2_s0     .... .... ... m:1 .... .... .. n:1 ... . ... zad:2 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn s=0
 
@@ -1113,3 +1115,4 @@ BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
 
 FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
+FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 386ded1b90..b198c7c855 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2090,3 +2090,5 @@ static bool do_mop4_fp8(DisasContext *s, arg_mop4 *a, MemOp esz,
 
 TRANS_FEAT(FMOP4A_sb, aa64_sme_mop4_f8f32,
            do_mop4_fp8, a, MO_32, gen_helper_sme_fmop4a_sb)
+TRANS_FEAT(FMOP4A_hb, aa64_sme_mop4_f8f16,
+           do_mop4_fp8, a, MO_16, gen_helper_sme_fmop4a_hb)
-- 
2.43.0


