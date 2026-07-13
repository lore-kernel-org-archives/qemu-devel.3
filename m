Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA79DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPfp-000668-CP; Mon, 13 Jul 2026 19:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfn-000649-25
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfk-0005m5-MI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2caced6038eso5107755ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783983767; x=1784588567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTzWDudorFUSc6264taLnl6rTnQdRME8Qf8ZWZSVL4w=;
 b=Y+IiIbziugAEP+x4wthAosnoweUeZOergOUe3RV3HgjlK805cNROyB31QneugnhBnp
 vSB8eZgsctClTeM5kmfoiS0GkRI78tNewEaFQ9x+n3X1VqZ1mu7TYmovUFcyOpAVTUdz
 PWCWq5bZRQEA16J3kKKh7/mJyqpMDAd5+W9fO6D+tu79aNM9djZbJc/IZ9OVqqEmIKHT
 n++Dpbqrgh9sH2gDMlUyMVHx1wVVviOQoL1Zy58yiklEy9b2xosCKH2Vu6R93GZ7TAdZ
 /9UDG0p8bWtSksoWZz6LZRvYszI3mAjxV7EbwIJohKgNiAN+sivK6Zmi+/yin6OTlood
 PsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783983767; x=1784588567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KTzWDudorFUSc6264taLnl6rTnQdRME8Qf8ZWZSVL4w=;
 b=DcoPVxzNh6QYajdxaFUo89zwFVbxr4R2eQhme5IMm+/iAouXW1EgUkwrPb91XmIV2i
 u52qW8yNjFj+uueLgLTghpZeNRJ65csFAF+B6Oap40GOimHZRJUVY76Rh+4L1MM98gyv
 dlSH/9WixQN93iD5bHFy7AnQ4Lo8JiRYhbA0BcMm1m7LNY24h1jzVNXa89caPASosRgP
 +fMpy8RVTguj8QJfIzOKZpVZn9FWYod9skCPB9D2YDmWPZR9LIB4Eo4YpF7ROiajF8Te
 PDH/r/+XF0hsk64jBFN8pXrDUtI8tm8H1EU0deWK5YPlPFZf4Aw948CGlUdZDUOl5VpE
 s0rQ==
X-Gm-Message-State: AOJu0YygS4hSDR6r5zRGHYyrEGlGjJUIHYdWUPn7gxhbHlA4WWAzU+uB
 WVH0lZAJ/zAYWP0ePRpaaGnRnoLgT/uzm9pAF1qXQ8ObxSoZ/00SHULkO6xefpw1Fbc7mV9gbsj
 RdO/7
X-Gm-Gg: AfdE7ckcMY3GG8it7pJIFwJgMhh+2vEjbZyc9RLgNWWhimrZOZ7Vg1K+9lvJC99gaK1
 DeDWLhtihooKvP5BrIfzqSj8IAz8pchlNZiHnw2cqlkPd8Iqu3s/c2LtJOxZS9/1TDEOWxONA8m
 Bty3n4P+Su2aVapgbCKKRtBbavordXiw+GVpzJwBGcrzUxaZN0VXVz0mKsaLq5ZQCGmVNWEi/S3
 EXevBH11SPZWy7oaq0H87tezygXWxjfE65hizJL9oG7jFaZ6AntTVID2Gz+zL5fwSpWHz/UwgR0
 FPVBtBpRC/dJQr5u2tQXh+scNYNdntyedTZx5S03bzKkZTdYHx0e1fNkR60BMLmTFKCX3rEtMyZ
 nejQaVknHe9uN+3f0eWdqN3UQ773AwiZGp3nXoOR6zCysXoLE00QY/jjOi2prZstjYbDWe106N0
 WLs0xLcryA3425fBGXwvYu9XkbEcSr
X-Received: by 2002:a17:903:240c:b0:2ca:2390:ff13 with SMTP id
 d9443c01a7336-2cea169f406mr87436085ad.5.1783983767100; 
 Mon, 13 Jul 2026 16:02:47 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm106902965ad.24.2026.07.13.16.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 16:02:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/10] target/arm: Implement FTMOPA (non-widening, FP16)
Date: Mon, 13 Jul 2026 16:02:36 -0700
Message-ID: <20260713230244.70174-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713230244.70174-1-richard.henderson@linaro.org>
References: <20260713230244.70174-1-richard.henderson@linaro.org>
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
 target/arm/cpu-features.h        | 5 +++++
 target/arm/tcg/helper-sme-defs.h | 1 +
 target/arm/tcg/sme_helper.c      | 6 ++++++
 target/arm/tcg/translate-sme.c   | 2 ++
 target/arm/tcg/sme.decode        | 3 +++
 5 files changed, 17 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6370c03e2a..4190398a1d 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1842,6 +1842,11 @@ static inline bool isar_feature_aa64_sme_mop4_i16i64(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_i16i64(id);
 }
 
+static inline bool isar_feature_aa64_sme_tmop_f16f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f16f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 8107eb40af..84707e6c71 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -405,4 +405,5 @@ DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sme_ftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 571b0add34..49fd3d07e4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2693,6 +2693,12 @@ void HELPER(sme_fmop4a_hh)(void *vza, void *vzn, void *vzm,
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4a_hh);
 }
 
+void HELPER(sme_ftmopa_hh)(void *vza, void *vzn, void *vzm, void *vzk,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_tmop(vza, vzn, vzm, vzk, fpst, desc, MO_16, inner_fmop4a_hh);
+}
+
 static void inner_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float16 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 36a0b00089..6cb9628e75 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2156,5 +2156,7 @@ static bool do_tmop_fp(DisasContext *s, arg_tmop *a, MemOp esz,
     return true;
 }
 
+TRANS_FEAT(FTMOPA_hh, aa64_sme_tmop_f16f16, do_tmop_fp,
+           a, MO_16, FPST_ZA_F16, gen_helper_sme_ftmopa_hh)
 TRANS_FEAT(FTMOPA_ss, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ZA, gen_helper_sme_ftmopa_ss)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0250177d0d..16ed3ca391 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1137,7 +1137,10 @@ USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 &tmop           zad zn zm zk idx
 %tmop_zk        10:3 !function=expand_tmop_zk
 
+@tmop_o1        .... .... ... zm:5 ... ... .... idx:2 ... zad:1 \
+                &tmop zn=%zn_ax2 zk=%tmop_zk
 @tmop_o2        .... .... ... zm:5 ... ... .... idx:2 .. zad:2 \
                 &tmop zn=%zn_ax2 zk=%tmop_zk
 
+FTMOPA_hh       1000 0001 010 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
-- 
2.43.0


