Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06092C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKn-0003IS-92; Wed, 16 Sep 2026 09:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pKe-0002py-95
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:48 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pKc-00019Z-AJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:47 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bc475ffcbfso397766eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563945; x=1790168745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zViLnWWimhUqqQWRcEtwFvMmvTWE+xmDjdpS/VswBpI=;
 b=bJPZToP75c01EncSoX6QDFR1Fj6aFFa5ABEwHGidK5UWjP+0CZ4ajT01RDSzz3CSuI
 B1BG8vy59MEbboRRkOThaRM0caKH8+eNyY7wJBtlg4P8fowiya4+tqjxhWEGGqw6sop9
 JulOSzaA2Keh560QWUClQYYAoN3XhUyIt8M1K/kQnhp4oyqvXK/f3wlPzWXkWdtJhMl3
 hfsAB90zCnJ1MVWYvKjScobFFdsznHyickLqmBCVL6yZ6VZlQpE2ax5isbTJX128xsfI
 3CQFflChHESjcZiqoobptHQfh2OFc4OEkn7wBfo9HK4N1+HN88PVBuhOppQCz0/vO084
 yBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563945; x=1790168745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zViLnWWimhUqqQWRcEtwFvMmvTWE+xmDjdpS/VswBpI=;
 b=r9VriFBrhX3NQ2JshijoIHASuNdYmYMPV7tNabaUDMdunrxVEwFmljGsNlMM4NlNCQ
 +UgbSu508EKlAhWD5rREpWmaDZjtooS5mUumEdEUsjWNSh7cxRywAC81Q4CYoPqs6yYO
 4CZsIPuz50nJqMOv6SIoRZdm//cgGns24JCdH3URVmS+bRBqD9cAs7EinwRhhkEQ5srt
 aZasVjphFyKSKA8UZmn04R7zMUYK6ufCWF3YHnYI5ABh1Q5uE3/z/2/UUB80dvyYFr1k
 clTkHj5Po8MRCf6poo6+9xn/ZfEjNfFJzx9EjKhcSmbHzlE5yX2mi0NKu2HWVEYnjRC4
 Tt9g==
X-Gm-Message-State: AFuF++nALb9dUsAfwajxKtNhhH1rwXOQhnuSP5j7QuehdZPI+oK1Sfv3
 CN6op/O764HzdObu3W2qK6wFUjQQP0wPE8O/mOAucOA9BEdp8YUeTfRthVuOB7rTufziJzAUNvW
 t1bTjkx4=
X-Gm-Gg: AYBFou0TrJ6szB937oPGwpUVcav9D48ti/95e2C8E+YnZfNL+GAHWuu7gT3V22ks2Ob
 HUTlvKnnKBdG9J/eRYb81oMZI6526di8g39Wy6qhKknkRTbcmwkxMjR7l3sV1905t37H4t7HlYz
 btB1xVAGBsVdVy2ee/xxtgQcScT+JD0vdAMFRwe3sNmasY6byngU92xATwFth6Jov/CCfNMoYOR
 zAEnRpLgKOG/Xa0p1uEARBKBwXm8T8g0RE8P9pXYsCTRA5jJ5i+uj7Rt0F9RZyfx4695WIUQ7hH
 /zxzIc9txisBlmWdPC28qraEoI4gHyPhlTa+PCXQmpanV9rwkv5o5cCbNUg+aq+5ifxZzq4PNVm
 j3UoW6o+6hTF5WEfhQU5zN/+b4ux3c2ybRiQuq6S2x4NpWFEec3Y0kPRYJWL1rQEEXYTfBLhxBO
 jFWg0bqRjhy5MRy/0TjaZ3Rzs90sxVAkvCTdXuoRfQ5relLFEqa/mg5ryr8VYd5K4ebD8oUMqkj
 ALrXXY=
X-Received: by 2002:a05:6820:2221:b0:6b1:2843:1312 with SMTP id
 006d021491bc7-6c7ce24fdcemr2329606eaf.0.1789563886101; 
 Wed, 16 Sep 2026 06:04:46 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/92] tcg: Generic expansion of tcg_gen_shli_*
Date: Wed, 16 Sep 2026 03:02:57 -1000
Message-ID: <20260916130409.3382710-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f45e5961a22..14f8dce347e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -217,7 +216,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b318ddd74e2..b98e5bd80e9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2d0e2c4b34a..1546fc3c094 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -458,6 +458,16 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -554,16 +564,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


