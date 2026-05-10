Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB1CCD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgV-0006DE-LU; Sat, 09 May 2026 22:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgL-0006Am-6R
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:13 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgI-0002zd-Db
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:12 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbe437b072so1740997a34.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379249; x=1778984049; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jKw73ZJ33rglTTEz0kLNVuiIFuqopYtvnsmTN0JtURA=;
 b=DfpcffDG3TUnbEqCUoRPhXi5kJWlPTzfFSMZ+XHZ9ire5FvdqRCNNnRXulQ2RQ7ZFp
 mYQYHt0GZ1Ykiqzo9dhanfuI7Z5AdBZbwP39iSVDUsFJxdzmxg6dj9ru2iferHH8hhjP
 Upp5DC7rXELv1g55vKAs7cR2eUvtVvq2BqMsBDFlGkYRJsTdVLHjAmT8bGJOOj2Y3aTE
 K4ZSaeAQrU/f6gF37yobkKuoN5Z8CcCJIyDc8NKmFaiQ9oEfBxPEb/8PRmbnTll9s3Ca
 iuU4leq7ndY5VSR5gadxcX59F8n6Wbj8mw4wMSeFJz3ktwNAvgbnyRhbryqTc+BGV5/S
 Y7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379249; x=1778984049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jKw73ZJ33rglTTEz0kLNVuiIFuqopYtvnsmTN0JtURA=;
 b=Z7kWJPeP+GhxX28b28Bzn4FkSEd76hLRD6z8H6AB4ZCB5lNIuW0gGDVFNygFMKPlLB
 TMtLnSgCLYjCwyK6gUm1vOMboDhpmuJPKBxlKk6tWSplPw3FKH1o/kU89mHf7YBzWz8V
 eYGkPVKRqr4w4Unv/cIEJy0fQlngxJoK82Na0L57xJiwqgiMnJpN8+GycreztfkFN4Bm
 V4YEJyoao93hDgk5O6QlDQivXmgBYl9TGPKsmpcIlVuyuislZtXUh3ALaHyZSju4aGv6
 8LXrKdEAJqaACQM0cEkrQ3zMCcLz8G1tAlamvNb+D4Zi03Il+a1xKj+iZV03IdAdtMez
 chPQ==
X-Gm-Message-State: AOJu0YwIuZvU49wHbGSBX+uo2AkAaqIJKxtpikFK7/Vz9W3QMbqdLrQK
 92/jwEia8jVOfLNUCei9iCA/WdIlpmPG0LT8e5oxku6RGp4sVL5PjlI9WEqYMhfT
X-Gm-Gg: Acq92OFwTWGwkNztqyBGxmroO9IjQW4/mK2+J3FN5/F4bMb4lzwCAHx4/RdDT7bXCRn
 91oezrLKQKaehlwJuAXY+bKVgSgysHzJ3szGTN1LU4EmmKjDnacEdbxIOgOt4GbgMmn6pK9HZGh
 rI/ynngoZxEV/Z9+9vMTnTXY0YTOz8rO9Xv4ia7ZR++LHJxinX0dU8ajINFjOfI1Qfl9lhR/yv6
 3If8iaiWgdxHW+xIEPlNtdQqDQ/3kj+BjsreeOHKq8a8/tnKk/sUd9hJDcmY7C34TaVj61f3bd3
 WD88Nruapf9ln3EKP/nxf8ZjdslKXem1Dh7CrUQaQ/UujyPyPu2XqeJXj7icRFD9XuantYRG2zN
 MHWNgZ5k2YosjF77wblwA/AVOpEonpacpp5cnihyIqN3SOpi2mxuodzJdshUn0gLZCbWKpWpR0r
 XT3Y3Krgbxa4vU6e6y36ydHKOtsKeiyKiMENfG87MPwChmH4qh91bJb8oIBYMpNPGk/MKV9UU9s
 ZRfqEfeC5ehzMD/E5+C0VEDlFCR8CJNPMBO43QDdUR7SZKTtc9CTIyR+02Q3qNh/NvW
X-Received: by 2002:a05:6820:f08:b0:696:77e2:a78 with SMTP id
 006d021491bc7-69998cc228bmr10821972eaf.23.1778379248657; 
 Sat, 09 May 2026 19:14:08 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:38 -0600
Subject: [PATCH v4 15/32] target/mips: add Octeon MTM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-15-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

MTM0 loads the low Octeon3 multiplier operand pair from rs/rt into
MPL[0] and MPL[3], starts a new multiplier chain, clears the upper
multiplier limbs not populated by MTM0, and resets partial products.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTM encodings use rt == $zero.
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 56c54e0973..2dadb13845 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -43,6 +43,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+&r2          rs rt
+MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 477f681f9e..9f1c1471c5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -208,6 +208,58 @@ static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
     return trans_ZCB(ctx, a);
 }
 
+static void octeon_store_mpl(unsigned int index, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env,
+                   offsetof(CPUMIPSState, active_tc.octeon.MPL) +
+                   index * sizeof(uint64_t));
+}
+
+static void octeon_store_p(unsigned int index, TCGv_i64 value)
+{
+    tcg_gen_st_i64(value, tcg_env,
+                   offsetof(CPUMIPSState, active_tc.octeon.P) +
+                   index * sizeof(uint64_t));
+}
+
+static void octeon_zero_partial_product_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        octeon_store_p(i, zero);
+    }
+}
+
+static void octeon_clear_upper_multiplier_state(void)
+{
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    octeon_store_mpl(1, zero);
+    octeon_store_mpl(2, zero);
+    octeon_store_mpl(4, zero);
+    octeon_store_mpl(5, zero);
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(value, a->rs);
+    octeon_store_mpl(index, value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_mpl(index + 3, value);
+    if (index == 0) {
+        octeon_clear_upper_multiplier_state();
+    }
+    octeon_zero_partial_product_state();
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -217,3 +269,4 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+TRANS(MTM0, trans_mtm, 0);

-- 
2.54.0


