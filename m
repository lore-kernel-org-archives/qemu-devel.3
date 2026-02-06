Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9540EEE6B6A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfg-0007kj-SA; Fri, 06 Feb 2026 16:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeM-0005Xo-8x
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeI-0002dk-FQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so3453365e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414356; x=1771019156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDf9quw+DaLq8BHyIDG5OuzARsjFtAW0LWmMKUxEGC0=;
 b=mcTdeejOtrgoSwbrJy9U13UeFWEnaGkV6JYB8sR2YYR+Tv4snnui2Vc6jLUDWYd1iE
 eR+zXF1BIN7OW9Mjhe48H2r7PXF3kqg5La3mqCxaybSdkJyLq0icWTTd/gdosopTVgJ9
 9/SaN5WY+qGb/NA16Sf65ZufEgrVFV/vnM3zAYe9eujS3E++SSlx/oN5fNysLi6r+stE
 YojAjBHZHq4ENOHDbsYAADCuf2bi+NF7Uym1cevNXZ6AP3z0fPw63mEfA7r72bCSWPFa
 xmnaaUnu+OOEa1oKS1KiflJLuuPUuNe1rDKB1PqVI3fktE4ULvoPqnhzEm2tcGfW9nAj
 Pj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414356; x=1771019156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WDf9quw+DaLq8BHyIDG5OuzARsjFtAW0LWmMKUxEGC0=;
 b=PREwZdMGKS0o4RiXNfO3WvuIeDQBF/F9AbtmNxqavZEkSi/SmZovqFwVc+HXOewTQQ
 RpVdABGiRdFj97WTbi7XvYWPvfFh07XKfiCl1/OtCQR4jlB9G0mldEUTuz7zxdDXwEKu
 mXxBt2wSC4P8K9/FwaPW3GOxrNaPDMUybMc0eVkUg/vZ3VS1tUlYm7d6vcEdrNxUBJhf
 TI7fKoRQzWh/k6JJlbPm3FcyvixtMF/DgkLXN9eqQfKvtc3IifW6u1vj+A1SD161YoeZ
 eC8K00+tRhraKJp5sj72DChbNeT9rSEKSNJqm1cD7FINbJBCG7An58RXVJLMGCb/6uH+
 kvuQ==
X-Gm-Message-State: AOJu0Yz250loHVOw0TRc04BZBdkZ4G8oQPXOf/5/Ms4HBhXuFZ5igRLo
 GlS+ioGUpU2CUCbMwMv2aNfinkKfWOBG7voocDfWcAhUT0B+oWodcCWzHXqFd27Psl3bGYwX94C
 6Opd3sH8=
X-Gm-Gg: AZuq6aJ0fY0pNOBVaBxbZM4LJw4CeRbCEtnybY9M6e0/H3rMzQ5YQDIihOAMEDvPJHo
 V1pph3o1X3V29axoRHrbElpmZmdMbEpYPpL7hclwV3tdioYgnBVRzZe80ei3TN8rk4ACoYXodQ4
 i/jc1JRtvMM1AAxazh2Bgko5BwolCrqjGxxPwmJ9Nj0cBJ3gfS1/wixEGa1TIIl7SX1+jOePGOA
 xAUYjnNPxHu1XzyTsgGApavw+nIS3JlNgao8QQvEyq266R1INAOBMx77W6LOGxZzLBVDS2QVoJ9
 inSU0Yuuz0PMzgQeQRyqb7ZPH6pohGWGqLYg/xhFU+TevVKj9UHLrl1mXdLy6EiI5SjPC4vgVFN
 Gf6X5Luq2EF65bjJg+4obb9UQKICer7cYzBe2lgYZa8wWNaB3zKyQwSwyTnFGxLqTdTH57PRnSh
 eXXDRcin/YmXLVLKcC1IAh7KSDOU3a8xfLOUAljds7weegwBQ0h8HrOCMNdRO1
X-Received: by 2002:a05:600c:1548:b0:480:1e9e:f9c with SMTP id
 5b1f17b1804b1-48320933613mr49203355e9.10.1770414356110; 
 Fri, 06 Feb 2026 13:45:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320410b78sm45321495e9.2.2026.02.06.13.45.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 10/30] target/s390x: Expand tcg_gen_qemu_ld/st_tl() as 64-bit
 target
Date: Fri,  6 Feb 2026 22:44:28 +0100
Message-ID: <20260206214448.22008-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The s390x target is a 64-bit one, so we have these expansions
in the "tcg/tcg-op.h" header:

 . tcg_gen_qemu_ld_tl() -> tcg_gen_qemu_ld_i64()
 . tcg_gen_qemu_st_tl() -> tcg_gen_qemu_st_i64()

Use the expanded form which is more explicit when a target
isn't built for different words size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-10-philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 54 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 437f5a4aeb7..4dabd49840f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1259,7 +1259,7 @@ static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
 
     o->in1 = tcg_temp_new_i64();
     if (non_atomic) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic addition in memory. */
         tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -1270,7 +1270,7 @@ static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
     tcg_gen_add_i64(o->out, o->in1, o->in2);
 
     if (non_atomic) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -1281,7 +1281,7 @@ static DisasJumpType op_asiu64(DisasContext *s, DisasOps *o)
 
     o->in1 = tcg_temp_new_i64();
     if (non_atomic) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic addition in memory. */
         tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -1293,7 +1293,7 @@ static DisasJumpType op_asiu64(DisasContext *s, DisasOps *o)
     tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
 
     if (non_atomic) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -1374,7 +1374,7 @@ static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
     o->in1 = tcg_temp_new_i64();
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic operation in memory. */
         tcg_gen_atomic_fetch_and_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -1385,7 +1385,7 @@ static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
     tcg_gen_and_i64(o->out, o->in1, o->in2);
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -1917,8 +1917,8 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
         mop = ctz32(l + 1) | MO_BE;
         /* Do not update cc_src yet: loading cc_dst may cause an exception. */
         src = tcg_temp_new_i64();
-        tcg_gen_qemu_ld_tl(src, o->addr1, get_mem_index(s), mop);
-        tcg_gen_qemu_ld_tl(cc_dst, o->in2, get_mem_index(s), mop);
+        tcg_gen_qemu_ld_i64(src, o->addr1, get_mem_index(s), mop);
+        tcg_gen_qemu_ld_i64(cc_dst, o->in2, get_mem_index(s), mop);
         gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, src, cc_dst);
         return DISAS_NEXT;
     default:
@@ -2747,15 +2747,15 @@ static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_tl(o->out, o->in2, get_mem_index(s),
-                       MO_BESL | s->insn->data);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
+                        MO_BESL | s->insn->data);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_tl(o->out, o->in2, get_mem_index(s),
-                       MO_BEUL | s->insn->data);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
+                        MO_BEUL | s->insn->data);
     return DISAS_NEXT;
 }
 
@@ -3087,7 +3087,7 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_tl(o->out, o->in2, MMU_REAL_IDX, s->insn->data);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, MMU_REAL_IDX, s->insn->data);
     return DISAS_NEXT;
 }
 #endif
@@ -3506,7 +3506,7 @@ static DisasJumpType op_oi(DisasContext *s, DisasOps *o)
     o->in1 = tcg_temp_new_i64();
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic operation in memory. */
         tcg_gen_atomic_fetch_or_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -3517,7 +3517,7 @@ static DisasJumpType op_oi(DisasContext *s, DisasOps *o)
     tcg_gen_or_i64(o->out, o->in1, o->in2);
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -4334,7 +4334,7 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, MMU_REAL_IDX, s->insn->data);
 
     if (s->base.tb->flags & FLAG_MASK_PER_STORE_REAL) {
         update_cc_op(s);
@@ -4367,8 +4367,8 @@ static DisasJumpType op_st16(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->in1, o->in2, get_mem_index(s),
-                       MO_BEUL | s->insn->data);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
+                        MO_BEUL | s->insn->data);
     return DISAS_NEXT;
 }
 
@@ -4836,7 +4836,7 @@ static DisasJumpType op_xi(DisasContext *s, DisasOps *o)
     o->in1 = tcg_temp_new_i64();
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic operation in memory. */
         tcg_gen_atomic_fetch_xor_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
@@ -4847,7 +4847,7 @@ static DisasJumpType op_xi(DisasContext *s, DisasOps *o)
     tcg_gen_xor_i64(o->out, o->in1, o->in2);
 
     if (!s390_has_feat(S390_FEAT_INTERLOCKED_ACCESS_2)) {
-        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+        tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
 }
@@ -5291,7 +5291,7 @@ static void wout_m1_16(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_16a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_BEUW | MO_ALIGN);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUW | MO_ALIGN);
 }
 #define SPEC_wout_m1_16a 0
 #endif
@@ -5305,7 +5305,7 @@ static void wout_m1_32(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_32a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_BEUL | MO_ALIGN);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUL | MO_ALIGN);
 }
 #define SPEC_wout_m1_32a 0
 #endif
@@ -5816,7 +5816,7 @@ static void in2_m2_32u(DisasContext *s, DisasOps *o)
 static void in2_m2_32ua(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_BEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUL | MO_ALIGN);
 }
 #define SPEC_in2_m2_32ua 0
 #endif
@@ -5862,16 +5862,16 @@ static void in2_mri2_16u(DisasContext *s, DisasOps *o)
 static void in2_mri2_32s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_tl(o->in2, gen_ri2(s), get_mem_index(s),
-                       MO_BESL | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s),
+                        MO_BESL | MO_ALIGN);
 }
 #define SPEC_in2_mri2_32s 0
 
 static void in2_mri2_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_tl(o->in2, gen_ri2(s), get_mem_index(s),
-                       MO_BEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s),
+                        MO_BEUL | MO_ALIGN);
 }
 #define SPEC_in2_mri2_32u 0
 
-- 
2.52.0


