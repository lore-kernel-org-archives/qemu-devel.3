Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AECC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVI-0006Nh-1f; Tue, 07 May 2024 06:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IVF-00063P-C2
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV8-0002wH-3C
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJqcByJ3Q5t6XIfJOE4Z6U3852PiAUmVuIfMfA88Lz8=;
 b=MuMpVbH7PMDjJRwg3PwJMoPmX3vkEg5Ro2XwK/lBqKGLWaGlRAm0g9BZo9f9VpC6TnJHrj
 c2JKupknfA0o5NHV9MoRUVdWes96CEck62rd2MB5vq6dXTtO/ayZU/MQFoYdpoekaRvBqv
 j6xwl+ENeziQJX2antgGbMAkxH0HkZE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-7S5zOkrzOMuMP4vCg2D4EA-1; Tue, 07 May 2024 06:56:46 -0400
X-MC-Unique: 7S5zOkrzOMuMP4vCg2D4EA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5202218b4d3so2870519e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079405; x=1715684205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJqcByJ3Q5t6XIfJOE4Z6U3852PiAUmVuIfMfA88Lz8=;
 b=dGy3eStT2hJE5XjQxJlMWYm581xIwa8fH3O+ozIwZdy5eEcMAKlq0FWTOIS+ayCB2R
 v7SWljU//qjuF69M86FLMRJlfimuFN+OZEFzGgEYTlEOQS/XZyZQ+7Tj5UxZytJ2hRGG
 K+JfcssBIuAK67fHOzHKoIB10Oo/K6XuNInSywV6xR7XV2m6m91IzPH3+cCany+lq3nA
 MSCYj7suLSfwDqBLlAK0jTmrJK4zU9An/W96TCB7y8D7gxyvLX0WytAfpIZ1GzNRO4NL
 h3gt8Zspv/2vYXqBtfaXUyDTrDGI2SWO4c9pc6n3j4YbSQqfdt/8U1Z1mmwIBjymLvOz
 VtGQ==
X-Gm-Message-State: AOJu0YxfIIOBvT8ivde4bQnXSKxscdkRic1ZY9WH8miBmqByBO7e9uiH
 r9kqVmBHfVZJI+VEKRiMh/Ia5I5MVTYUXwH6iYaS1cKsAbHSKGshZkw+ldNDOa1rS7FBl59bCbz
 1DgTA5NSFngutSOhNxdlcnrCMFRjTfXeZilB+05i7AmWjN6M29TeiZgagEBRzZXtcemd4lnHTtg
 t2j3LAEulosbdF50SDbbP42DK05GHpgCofXrdL
X-Received: by 2002:ac2:4c50:0:b0:51f:27e7:a4e2 with SMTP id
 o16-20020ac24c50000000b0051f27e7a4e2mr14931394lfk.58.1715079403664; 
 Tue, 07 May 2024 03:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEhnNmhlfMRQNIyjgPcE9n2es1Jpbjp6qzv2Bbi/vlCbCqVkGOh5PmrZ5bBI71VqZtC55gOQ==
X-Received: by 2002:ac2:4c50:0:b0:51f:27e7:a4e2 with SMTP id
 o16-20020ac24c50000000b0051f27e7a4e2mr14931329lfk.58.1715079402313; 
 Tue, 07 May 2024 03:56:42 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170906c30a00b00a59a08c722fsm4519585ejz.184.2024.05.07.03.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/26] target/i386: remove now-converted opcodes from old
 decoder
Date: Tue,  7 May 2024 12:55:35 +0200
Message-ID: <20240507105538.180704-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Send all converted opcodes to disas_insn_new() directly from the big
decoding switch statement; once more, the debugging/bisecting logic
disappears.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h                        |   11 -
 target/i386/tcg/shift_helper_template.h.inc |  108 -
 target/i386/tcg/int_helper.c                |   34 -
 target/i386/tcg/translate.c                 | 2175 +------------------
 target/i386/tcg/decode-new.c.inc            |    3 -
 5 files changed, 11 insertions(+), 2320 deletions(-)
 delete mode 100644 target/i386/tcg/shift_helper_template.h.inc

diff --git a/target/i386/helper.h b/target/i386/helper.h
index ac2b04abd63..3c207ac62d6 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -207,15 +207,4 @@ DEF_HELPER_1(emms, void, env)
 #define SHIFT 2
 #include "tcg/ops_sse_header.h.inc"
 
-DEF_HELPER_3(rclb, tl, env, tl, tl)
-DEF_HELPER_3(rclw, tl, env, tl, tl)
-DEF_HELPER_3(rcll, tl, env, tl, tl)
-DEF_HELPER_3(rcrb, tl, env, tl, tl)
-DEF_HELPER_3(rcrw, tl, env, tl, tl)
-DEF_HELPER_3(rcrl, tl, env, tl, tl)
-#ifdef TARGET_X86_64
-DEF_HELPER_3(rclq, tl, env, tl, tl)
-DEF_HELPER_3(rcrq, tl, env, tl, tl)
-#endif
-
 DEF_HELPER_1(rdrand, tl, env)
diff --git a/target/i386/tcg/shift_helper_template.h.inc b/target/i386/tcg/shift_helper_template.h.inc
deleted file mode 100644
index 54f15d6e05c..00000000000
--- a/target/i386/tcg/shift_helper_template.h.inc
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- *  x86 shift helpers
- *
- *  Copyright (c) 2008 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#define DATA_BITS (1 << (3 + SHIFT))
-#define SHIFT_MASK (DATA_BITS - 1)
-#if DATA_BITS <= 32
-#define SHIFT1_MASK 0x1f
-#else
-#define SHIFT1_MASK 0x3f
-#endif
-
-#if DATA_BITS == 8
-#define SUFFIX b
-#define DATA_MASK 0xff
-#elif DATA_BITS == 16
-#define SUFFIX w
-#define DATA_MASK 0xffff
-#elif DATA_BITS == 32
-#define SUFFIX l
-#define DATA_MASK 0xffffffff
-#elif DATA_BITS == 64
-#define SUFFIX q
-#define DATA_MASK 0xffffffffffffffffULL
-#else
-#error unhandled operand size
-#endif
-
-target_ulong glue(helper_rcl, SUFFIX)(CPUX86State *env, target_ulong t0,
-                                      target_ulong t1)
-{
-    int count, eflags;
-    target_ulong src;
-    target_long res;
-
-    count = t1 & SHIFT1_MASK;
-#if DATA_BITS == 16
-    count = rclw_table[count];
-#elif DATA_BITS == 8
-    count = rclb_table[count];
-#endif
-    if (count) {
-        eflags = env->cc_src;
-        t0 &= DATA_MASK;
-        src = t0;
-        res = (t0 << count) | ((target_ulong)(eflags & CC_C) << (count - 1));
-        if (count > 1) {
-            res |= t0 >> (DATA_BITS + 1 - count);
-        }
-        t0 = res;
-        env->cc_src = (eflags & ~(CC_C | CC_O)) |
-            (lshift(src ^ t0, 11 - (DATA_BITS - 1)) & CC_O) |
-            ((src >> (DATA_BITS - count)) & CC_C);
-    }
-    return t0;
-}
-
-target_ulong glue(helper_rcr, SUFFIX)(CPUX86State *env, target_ulong t0,
-                                      target_ulong t1)
-{
-    int count, eflags;
-    target_ulong src;
-    target_long res;
-
-    count = t1 & SHIFT1_MASK;
-#if DATA_BITS == 16
-    count = rclw_table[count];
-#elif DATA_BITS == 8
-    count = rclb_table[count];
-#endif
-    if (count) {
-        eflags = env->cc_src;
-        t0 &= DATA_MASK;
-        src = t0;
-        res = (t0 >> count) |
-            ((target_ulong)(eflags & CC_C) << (DATA_BITS - count));
-        if (count > 1) {
-            res |= t0 << (DATA_BITS + 1 - count);
-        }
-        t0 = res;
-        env->cc_src = (eflags & ~(CC_C | CC_O)) |
-            (lshift(src ^ t0, 11 - (DATA_BITS - 1)) & CC_O) |
-            ((src >> (count - 1)) & CC_C);
-    }
-    return t0;
-}
-
-#undef DATA_BITS
-#undef SHIFT_MASK
-#undef SHIFT1_MASK
-#undef DATA_TYPE
-#undef DATA_MASK
-#undef SUFFIX
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index ab85dc55400..df16130f5df 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -29,22 +29,6 @@
 
 //#define DEBUG_MULDIV
 
-/* modulo 9 table */
-static const uint8_t rclb_table[32] = {
-    0, 1, 2, 3, 4, 5, 6, 7,
-    8, 0, 1, 2, 3, 4, 5, 6,
-    7, 8, 0, 1, 2, 3, 4, 5,
-    6, 7, 8, 0, 1, 2, 3, 4,
-};
-
-/* modulo 17 table */
-static const uint8_t rclw_table[32] = {
-    0, 1, 2, 3, 4, 5, 6, 7,
-    8, 9, 10, 11, 12, 13, 14, 15,
-    16, 0, 1, 2, 3, 4, 5, 6,
-    7, 8, 9, 10, 11, 12, 13, 14,
-};
-
 /* division, flags are undefined */
 
 void helper_divb_AL(CPUX86State *env, target_ulong t0)
@@ -447,24 +431,6 @@ target_ulong helper_pext(target_ulong src, target_ulong mask)
     return dest;
 }
 
-#define SHIFT 0
-#include "shift_helper_template.h.inc"
-#undef SHIFT
-
-#define SHIFT 1
-#include "shift_helper_template.h.inc"
-#undef SHIFT
-
-#define SHIFT 2
-#include "shift_helper_template.h.inc"
-#undef SHIFT
-
-#ifdef TARGET_X86_64
-#define SHIFT 3
-#include "shift_helper_template.h.inc"
-#undef SHIFT
-#endif
-
 /* Test that BIT is enabled in CR4.  If not, raise an illegal opcode
    exception.  This reduces the requirements for rare CR4 bits being
    mapped into HFLAGS.  */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4fbd91e70d1..f4e5843d5f5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -215,7 +215,6 @@ typedef struct DisasContext {
 #ifdef CONFIG_USER_ONLY
 STUB_HELPER(clgi, TCGv_env env)
 STUB_HELPER(flush_page, TCGv_env env, TCGv addr)
-STUB_HELPER(hlt, TCGv_env env, TCGv_i32 pc_ofs)
 STUB_HELPER(inb, TCGv ret, TCGv_env env, TCGv_i32 port)
 STUB_HELPER(inw, TCGv ret, TCGv_env env, TCGv_i32 port)
 STUB_HELPER(inl, TCGv ret, TCGv_env env, TCGv_i32 port)
@@ -242,21 +241,8 @@ static void gen_eob(DisasContext *s);
 static void gen_jr(DisasContext *s);
 static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num);
 static void gen_jmp_rel_csize(DisasContext *s, int diff, int tb_num);
-static void gen_op(DisasContext *s1, int op, MemOp ot, int d);
 static void gen_exception_gpf(DisasContext *s);
 
-/* i386 arith/logic operations */
-enum {
-    OP_ADDL,
-    OP_ORL,
-    OP_ADCL,
-    OP_SBBL,
-    OP_ANDL,
-    OP_SUBL,
-    OP_XORL,
-    OP_CMPL,
-};
-
 /* i386 shift ops */
 enum {
     OP_ROL,
@@ -442,13 +428,6 @@ static inline MemOp mo_b_d(int b, MemOp ot)
     return b & 1 ? ot : MO_8;
 }
 
-/* Select size 8 if lsb of B is clear, else OT capped at 32.
-   Used for decoding operand size of port opcodes.  */
-static inline MemOp mo_b_d32(int b, MemOp ot)
-{
-    return b & 1 ? (ot == MO_16 ? MO_16 : MO_32) : MO_8;
-}
-
 /* Compute the result of writing t0 to the OT-sized register REG.
  *
  * If DEST is NULL, store the result into the register and return the
@@ -851,25 +830,6 @@ static void gen_op_update2_cc(DisasContext *s)
     tcg_gen_mov_tl(cpu_cc_dst, s->T0);
 }
 
-static void gen_op_update3_cc(DisasContext *s, TCGv reg)
-{
-    tcg_gen_mov_tl(cpu_cc_src2, reg);
-    tcg_gen_mov_tl(cpu_cc_src, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-}
-
-static inline void gen_op_testl_T0_T1_cc(DisasContext *s)
-{
-    tcg_gen_and_tl(cpu_cc_dst, s->T0, s->T1);
-}
-
-static void gen_op_update_neg_cc(DisasContext *s)
-{
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    tcg_gen_neg_tl(cpu_cc_src, s->T0);
-    tcg_gen_movi_tl(s->cc_srcT, 0);
-}
-
 /* compute all eflags to reg */
 static void gen_mov_eflags(DisasContext *s, TCGv reg)
 {
@@ -1484,165 +1444,6 @@ static bool check_cpl0(DisasContext *s)
     return false;
 }
 
-/* If vm86, check for iopl == 3; if not, raise #GP and return false. */
-static bool check_vm86_iopl(DisasContext *s)
-{
-    if (!VM86(s) || IOPL(s) == 3) {
-        return true;
-    }
-    gen_exception_gpf(s);
-    return false;
-}
-
-/* Check for iopl allowing access; if not, raise #GP and return false. */
-static bool check_iopl(DisasContext *s)
-{
-    if (VM86(s) ? IOPL(s) == 3 : CPL(s) <= IOPL(s)) {
-        return true;
-    }
-    gen_exception_gpf(s);
-    return false;
-}
-
-/* if d == OR_TMP0, it means memory operand (address in A0) */
-static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
-{
-    /* Invalid lock prefix when destination is not memory or OP_CMPL. */
-    if ((d != OR_TMP0 || op == OP_CMPL) && s1->prefix & PREFIX_LOCK) {
-        gen_illegal_opcode(s1);
-        return;
-    }
-
-    if (d != OR_TMP0) {
-        gen_op_mov_v_reg(s1, ot, s1->T0, d);
-    } else if (!(s1->prefix & PREFIX_LOCK)) {
-        gen_op_ld_v(s1, ot, s1->T0, s1->A0);
-    }
-    switch(op) {
-    case OP_ADCL:
-        gen_compute_eflags_c(s1, s1->tmp4);
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_add_tl(s1->T0, s1->tmp4, s1->T1);
-            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
-            tcg_gen_add_tl(s1->T0, s1->T0, s1->tmp4);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update3_cc(s1, s1->tmp4);
-        set_cc_op(s1, CC_OP_ADCB + ot);
-        break;
-    case OP_SBBL:
-        gen_compute_eflags_c(s1, s1->tmp4);
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_add_tl(s1->T0, s1->T1, s1->tmp4);
-            tcg_gen_neg_tl(s1->T0, s1->T0);
-            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
-            tcg_gen_sub_tl(s1->T0, s1->T0, s1->tmp4);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update3_cc(s1, s1->tmp4);
-        set_cc_op(s1, CC_OP_SBBB + ot);
-        break;
-    case OP_ADDL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update2_cc(s1);
-        set_cc_op(s1, CC_OP_ADDB + ot);
-        break;
-    case OP_SUBL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_neg_tl(s1->T0, s1->T1);
-            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, s1->A0, s1->T0,
-                                        s1->mem_index, ot | MO_LE);
-            tcg_gen_sub_tl(s1->T0, s1->cc_srcT, s1->T1);
-        } else {
-            tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
-            tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update2_cc(s1);
-        set_cc_op(s1, CC_OP_SUBB + ot);
-        break;
-    default:
-    case OP_ANDL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_and_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_and_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update1_cc(s1);
-        set_cc_op(s1, CC_OP_LOGICB + ot);
-        break;
-    case OP_ORL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_or_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                       s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_or_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update1_cc(s1);
-        set_cc_op(s1, CC_OP_LOGICB + ot);
-        break;
-    case OP_XORL:
-        if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_xor_fetch_tl(s1->T0, s1->A0, s1->T1,
-                                        s1->mem_index, ot | MO_LE);
-        } else {
-            tcg_gen_xor_tl(s1->T0, s1->T0, s1->T1);
-            gen_op_st_rm_T0_A0(s1, ot, d);
-        }
-        gen_op_update1_cc(s1);
-        set_cc_op(s1, CC_OP_LOGICB + ot);
-        break;
-    case OP_CMPL:
-        tcg_gen_mov_tl(cpu_cc_src, s1->T1);
-        tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
-        tcg_gen_sub_tl(cpu_cc_dst, s1->T0, s1->T1);
-        set_cc_op(s1, CC_OP_SUBB + ot);
-        break;
-    }
-}
-
-/* if d == OR_TMP0, it means memory operand (address in A0) */
-static void gen_inc(DisasContext *s1, MemOp ot, int d, int c)
-{
-    if (s1->prefix & PREFIX_LOCK) {
-        if (d != OR_TMP0) {
-            /* Lock prefix when destination is not memory */
-            gen_illegal_opcode(s1);
-            return;
-        }
-        tcg_gen_movi_tl(s1->T0, c > 0 ? 1 : -1);
-        tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
-                                    s1->mem_index, ot | MO_LE);
-    } else {
-        if (d != OR_TMP0) {
-            gen_op_mov_v_reg(s1, ot, s1->T0, d);
-        } else {
-            gen_op_ld_v(s1, ot, s1->T0, s1->A0);
-        }
-        tcg_gen_addi_tl(s1->T0, s1->T0, (c > 0 ? 1 : -1));
-        gen_op_st_rm_T0_A0(s1, ot, d);
-    }
-
-    gen_compute_eflags_c(s1, cpu_cc_src);
-    tcg_gen_mov_tl(cpu_cc_dst, s1->T0);
-    set_cc_op(s1, (c > 0 ? CC_OP_INCB : CC_OP_DECB) + ot);
-}
-
 static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,
                             TCGv shm1, TCGv count, bool is_right)
 {
@@ -1685,298 +1486,6 @@ static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,
     set_cc_op(s, CC_OP_DYNAMIC);
 }
 
-static void gen_shift_rm_T1(DisasContext *s, MemOp ot, int op1,
-                            int is_right, int is_arith)
-{
-    target_ulong mask = (ot == MO_64 ? 0x3f : 0x1f);
-
-    /* load */
-    if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, s->T0, s->A0);
-    } else {
-        gen_op_mov_v_reg(s, ot, s->T0, op1);
-    }
-
-    tcg_gen_andi_tl(s->T1, s->T1, mask);
-    tcg_gen_subi_tl(s->tmp0, s->T1, 1);
-
-    if (is_right) {
-        if (is_arith) {
-            gen_exts(ot, s->T0);
-            tcg_gen_sar_tl(s->tmp0, s->T0, s->tmp0);
-            tcg_gen_sar_tl(s->T0, s->T0, s->T1);
-        } else {
-            gen_extu(ot, s->T0);
-            tcg_gen_shr_tl(s->tmp0, s->T0, s->tmp0);
-            tcg_gen_shr_tl(s->T0, s->T0, s->T1);
-        }
-    } else {
-        tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
-        tcg_gen_shl_tl(s->T0, s->T0, s->T1);
-    }
-
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-
-    gen_shift_flags(s, ot, s->T0, s->tmp0, s->T1, is_right);
-}
-
-static void gen_shift_rm_im(DisasContext *s, MemOp ot, int op1, int op2,
-                            int is_right, int is_arith)
-{
-    int mask = (ot == MO_64 ? 0x3f : 0x1f);
-
-    /* load */
-    if (op1 == OR_TMP0)
-        gen_op_ld_v(s, ot, s->T0, s->A0);
-    else
-        gen_op_mov_v_reg(s, ot, s->T0, op1);
-
-    op2 &= mask;
-    if (op2 != 0) {
-        if (is_right) {
-            if (is_arith) {
-                gen_exts(ot, s->T0);
-                tcg_gen_sari_tl(s->tmp4, s->T0, op2 - 1);
-                tcg_gen_sari_tl(s->T0, s->T0, op2);
-            } else {
-                gen_extu(ot, s->T0);
-                tcg_gen_shri_tl(s->tmp4, s->T0, op2 - 1);
-                tcg_gen_shri_tl(s->T0, s->T0, op2);
-            }
-        } else {
-            tcg_gen_shli_tl(s->tmp4, s->T0, op2 - 1);
-            tcg_gen_shli_tl(s->T0, s->T0, op2);
-        }
-    }
-
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-
-    /* update eflags if non zero shift */
-    if (op2 != 0) {
-        tcg_gen_mov_tl(cpu_cc_src, s->tmp4);
-        tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-        set_cc_op(s, (is_right ? CC_OP_SARB : CC_OP_SHLB) + ot);
-    }
-}
-
-static void gen_rot_rm_T1(DisasContext *s, MemOp ot, int op1, int is_right)
-{
-    target_ulong mask = (ot == MO_64 ? 0x3f : 0x1f);
-    TCGv_i32 t0, t1;
-
-    /* load */
-    if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, s->T0, s->A0);
-    } else {
-        gen_op_mov_v_reg(s, ot, s->T0, op1);
-    }
-
-    tcg_gen_andi_tl(s->T1, s->T1, mask);
-
-    switch (ot) {
-    case MO_8:
-        /* Replicate the 8-bit input so that a 32-bit rotate works.  */
-        tcg_gen_ext8u_tl(s->T0, s->T0);
-        tcg_gen_muli_tl(s->T0, s->T0, 0x01010101);
-        goto do_long;
-    case MO_16:
-        /* Replicate the 16-bit input so that a 32-bit rotate works.  */
-        tcg_gen_deposit_tl(s->T0, s->T0, s->T0, 16, 16);
-        goto do_long;
-    do_long:
-#ifdef TARGET_X86_64
-    case MO_32:
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-        if (is_right) {
-            tcg_gen_rotr_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
-        } else {
-            tcg_gen_rotl_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
-        }
-        tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
-        break;
-#endif
-    default:
-        if (is_right) {
-            tcg_gen_rotr_tl(s->T0, s->T0, s->T1);
-        } else {
-            tcg_gen_rotl_tl(s->T0, s->T0, s->T1);
-        }
-        break;
-    }
-
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-
-    /* We'll need the flags computed into CC_SRC.  */
-    gen_compute_eflags(s);
-
-    /* The value that was "rotated out" is now present at the other end
-       of the word.  Compute C into CC_DST and O into CC_SRC2.  Note that
-       since we've computed the flags into CC_SRC, these variables are
-       currently dead.  */
-    if (is_right) {
-        tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
-        tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
-        tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
-    } else {
-        tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
-        tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
-    }
-    tcg_gen_andi_tl(cpu_cc_src2, cpu_cc_src2, 1);
-    tcg_gen_xor_tl(cpu_cc_src2, cpu_cc_src2, cpu_cc_dst);
-
-    /* Now conditionally store the new CC_OP value.  If the shift count
-       is 0 we keep the CC_OP_EFLAGS setting so that only CC_SRC is live.
-       Otherwise reuse CC_OP_ADCOX which have the C and O flags split out
-       exactly as we computed above.  */
-    t0 = tcg_constant_i32(0);
-    t1 = tcg_temp_new_i32();
-    tcg_gen_trunc_tl_i32(t1, s->T1);
-    tcg_gen_movi_i32(s->tmp2_i32, CC_OP_ADCOX);
-    tcg_gen_movi_i32(s->tmp3_i32, CC_OP_EFLAGS);
-    tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, t1, t0,
-                        s->tmp2_i32, s->tmp3_i32);
-
-    /* The CC_OP value is no longer predictable.  */
-    set_cc_op(s, CC_OP_DYNAMIC);
-}
-
-static void gen_rot_rm_im(DisasContext *s, MemOp ot, int op1, int op2,
-                          int is_right)
-{
-    int mask = (ot == MO_64 ? 0x3f : 0x1f);
-    int shift;
-
-    /* load */
-    if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, s->T0, s->A0);
-    } else {
-        gen_op_mov_v_reg(s, ot, s->T0, op1);
-    }
-
-    op2 &= mask;
-    if (op2 != 0) {
-        switch (ot) {
-#ifdef TARGET_X86_64
-        case MO_32:
-            tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-            if (is_right) {
-                tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, op2);
-            } else {
-                tcg_gen_rotli_i32(s->tmp2_i32, s->tmp2_i32, op2);
-            }
-            tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
-            break;
-#endif
-        default:
-            if (is_right) {
-                tcg_gen_rotri_tl(s->T0, s->T0, op2);
-            } else {
-                tcg_gen_rotli_tl(s->T0, s->T0, op2);
-            }
-            break;
-        case MO_8:
-            mask = 7;
-            goto do_shifts;
-        case MO_16:
-            mask = 15;
-        do_shifts:
-            shift = op2 & mask;
-            if (is_right) {
-                shift = mask + 1 - shift;
-            }
-            gen_extu(ot, s->T0);
-            tcg_gen_shli_tl(s->tmp0, s->T0, shift);
-            tcg_gen_shri_tl(s->T0, s->T0, mask + 1 - shift);
-            tcg_gen_or_tl(s->T0, s->T0, s->tmp0);
-            break;
-        }
-    }
-
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-
-    if (op2 != 0) {
-        /* Compute the flags into CC_SRC.  */
-        gen_compute_eflags(s);
-
-        /* The value that was "rotated out" is now present at the other end
-           of the word.  Compute C into CC_DST and O into CC_SRC2.  Note that
-           since we've computed the flags into CC_SRC, these variables are
-           currently dead.  */
-        if (is_right) {
-            tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
-            tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
-            tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
-        } else {
-            tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
-            tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
-        }
-        tcg_gen_andi_tl(cpu_cc_src2, cpu_cc_src2, 1);
-        tcg_gen_xor_tl(cpu_cc_src2, cpu_cc_src2, cpu_cc_dst);
-        set_cc_op(s, CC_OP_ADCOX);
-    }
-}
-
-/* XXX: add faster immediate = 1 case */
-static void gen_rotc_rm_T1(DisasContext *s, MemOp ot, int op1,
-                           int is_right)
-{
-    gen_compute_eflags(s);
-    assert(s->cc_op == CC_OP_EFLAGS);
-
-    /* load */
-    if (op1 == OR_TMP0)
-        gen_op_ld_v(s, ot, s->T0, s->A0);
-    else
-        gen_op_mov_v_reg(s, ot, s->T0, op1);
-
-    if (is_right) {
-        switch (ot) {
-        case MO_8:
-            gen_helper_rcrb(s->T0, tcg_env, s->T0, s->T1);
-            break;
-        case MO_16:
-            gen_helper_rcrw(s->T0, tcg_env, s->T0, s->T1);
-            break;
-        case MO_32:
-            gen_helper_rcrl(s->T0, tcg_env, s->T0, s->T1);
-            break;
-#ifdef TARGET_X86_64
-        case MO_64:
-            gen_helper_rcrq(s->T0, tcg_env, s->T0, s->T1);
-            break;
-#endif
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        switch (ot) {
-        case MO_8:
-            gen_helper_rclb(s->T0, tcg_env, s->T0, s->T1);
-            break;
-        case MO_16:
-            gen_helper_rclw(s->T0, tcg_env, s->T0, s->T1);
-            break;
-        case MO_32:
-            gen_helper_rcll(s->T0, tcg_env, s->T0, s->T1);
-            break;
-#ifdef TARGET_X86_64
-        case MO_64:
-            gen_helper_rclq(s->T0, tcg_env, s->T0, s->T1);
-            break;
-#endif
-        default:
-            g_assert_not_reached();
-        }
-    }
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-}
-
 /* XXX: add faster immediate case */
 static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
                              bool is_right, TCGv count_in)
@@ -2061,63 +1570,6 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
     gen_shift_flags(s, ot, s->T0, s->tmp0, count, is_right);
 }
 
-static void gen_shift(DisasContext *s1, int op, MemOp ot, int d, int s)
-{
-    if (s != OR_TMP1)
-        gen_op_mov_v_reg(s1, ot, s1->T1, s);
-    switch(op) {
-    case OP_ROL:
-        gen_rot_rm_T1(s1, ot, d, 0);
-        break;
-    case OP_ROR:
-        gen_rot_rm_T1(s1, ot, d, 1);
-        break;
-    case OP_SHL:
-    case OP_SHL1:
-        gen_shift_rm_T1(s1, ot, d, 0, 0);
-        break;
-    case OP_SHR:
-        gen_shift_rm_T1(s1, ot, d, 1, 0);
-        break;
-    case OP_SAR:
-        gen_shift_rm_T1(s1, ot, d, 1, 1);
-        break;
-    case OP_RCL:
-        gen_rotc_rm_T1(s1, ot, d, 0);
-        break;
-    case OP_RCR:
-        gen_rotc_rm_T1(s1, ot, d, 1);
-        break;
-    }
-}
-
-static void gen_shifti(DisasContext *s1, int op, MemOp ot, int d, int c)
-{
-    switch(op) {
-    case OP_ROL:
-        gen_rot_rm_im(s1, ot, d, c, 0);
-        break;
-    case OP_ROR:
-        gen_rot_rm_im(s1, ot, d, c, 1);
-        break;
-    case OP_SHL:
-    case OP_SHL1:
-        gen_shift_rm_im(s1, ot, d, c, 0, 0);
-        break;
-    case OP_SHR:
-        gen_shift_rm_im(s1, ot, d, c, 1, 0);
-        break;
-    case OP_SAR:
-        gen_shift_rm_im(s1, ot, d, c, 1, 1);
-        break;
-    default:
-        /* currently not optimized */
-        tcg_gen_movi_tl(s1->T1, c);
-        gen_shift(s1, op, ot, d, OR_TMP1);
-        break;
-    }
-}
-
 #define X86_MAX_INSN_LENGTH 15
 
 static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
@@ -2153,11 +1605,6 @@ static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
     return translator_ldub(env, &s->base, advance_pc(env, s, 1));
 }
 
-static inline int16_t x86_ldsw_code(CPUX86State *env, DisasContext *s)
-{
-    return translator_lduw(env, &s->base, advance_pc(env, s, 2));
-}
-
 static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
 {
     return translator_lduw(env, &s->base, advance_pc(env, s, 2));
@@ -2483,15 +1930,6 @@ static target_long insn_get_signed(CPUX86State *env, DisasContext *s, MemOp ot)
     return ret;
 }
 
-static inline int insn_const_size(MemOp ot)
-{
-    if (ot <= MO_32) {
-        return 1 << ot;
-    } else {
-        return 4;
-    }
-}
-
 static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
                                         TCGLabel *not_taken, TCGLabel *taken)
 {
@@ -2523,12 +1961,6 @@ static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
     tcg_gen_movcond_tl(cc.cond, dest, cc.reg, cc.reg2, src, dest);
 }
 
-static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
-{
-    tcg_gen_ld32u_tl(s->T0, tcg_env,
-                     offsetof(CPUX86State,segs[seg_reg].selector));
-}
-
 static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 {
     TCGv selector = tcg_temp_new();
@@ -3019,9 +2451,6 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
-static bool first = true;
-static unsigned long limit;
-
 #include "decode-new.h"
 #include "emit.c.inc"
 #include "decode-new.c.inc"
@@ -3178,45 +2607,13 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
     prefixes = 0;
 
-    if (first) {
-        const char *limit_str = getenv("QEMU_I386_LIMIT");
-        limit = limit_str ? atol(limit_str) : -1;
-        first = false;
-    }
-    bool use_new = true;
-#ifdef CONFIG_USER_ONLY
-    use_new &= limit > 0;
-#endif
-
  next_byte:
     s->prefix = prefixes;
     b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
     switch (b) {
-    default:
-#ifndef CONFIG_USER_ONLY
-        use_new &= b <= limit;
-#endif
-        if (use_new && (b < 0xd8 || b >= 0xe0)) {
-            disas_insn_new(s, cpu, b);
-            return true;
-        }
-        break;
     case 0x0f:
         b = x86_ldub_code(env, s) + 0x100;
-#ifndef CONFIG_USER_ONLY
-        use_new &= b <= limit;
-#endif
-        if (use_new &&
-            ((b >= 0x138 && b <= 0x19f) ||
-             (b & ~9) == 0x1a0 ||
-             b == 0x1af || b == 0x1b2 ||
-             (b >= 0x1b4 && b <= 0x1b7) ||
-             b == 0x1be || b == 0x1bf || b == 0x1c3 ||
-             (b >= 0x1c8 && b <= 0x1cf))) {
-            disas_insn_new(s, cpu, b);
-            return true;
-        }
         break;
     case 0xf3:
         prefixes |= PREFIX_REPZ;
@@ -3314,558 +2711,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     switch (b) {
         /**************************/
         /* arith & logic */
-    case 0x00 ... 0x05:
-    case 0x08 ... 0x0d:
-    case 0x10 ... 0x15:
-    case 0x18 ... 0x1d:
-    case 0x20 ... 0x25:
-    case 0x28 ... 0x2d:
-    case 0x30 ... 0x35:
-    case 0x38 ... 0x3d:
-        {
-            int f;
-            op = (b >> 3) & 7;
-            f = (b >> 1) & 3;
-
-            ot = mo_b_d(b, dflag);
-
-            switch(f) {
-            case 0: /* OP Ev, Gv */
-                modrm = x86_ldub_code(env, s);
-                reg = ((modrm >> 3) & 7) | REX_R(s);
-                mod = (modrm >> 6) & 3;
-                rm = (modrm & 7) | REX_B(s);
-                if (mod != 3) {
-                    gen_lea_modrm(env, s, modrm);
-                    opreg = OR_TMP0;
-                } else if (op == OP_XORL && rm == reg) {
-                xor_zero:
-                    /* xor reg, reg optimisation */
-                    set_cc_op(s, CC_OP_CLR);
-                    tcg_gen_movi_tl(s->T0, 0);
-                    gen_op_mov_reg_v(s, ot, reg, s->T0);
-                    break;
-                } else {
-                    opreg = rm;
-                }
-                gen_op_mov_v_reg(s, ot, s->T1, reg);
-                gen_op(s, op, ot, opreg);
-                break;
-            case 1: /* OP Gv, Ev */
-                modrm = x86_ldub_code(env, s);
-                mod = (modrm >> 6) & 3;
-                reg = ((modrm >> 3) & 7) | REX_R(s);
-                rm = (modrm & 7) | REX_B(s);
-                if (mod != 3) {
-                    gen_lea_modrm(env, s, modrm);
-                    gen_op_ld_v(s, ot, s->T1, s->A0);
-                } else if (op == OP_XORL && rm == reg) {
-                    goto xor_zero;
-                } else {
-                    gen_op_mov_v_reg(s, ot, s->T1, rm);
-                }
-                gen_op(s, op, ot, reg);
-                break;
-            case 2: /* OP A, Iv */
-                val = insn_get(env, s, ot);
-                tcg_gen_movi_tl(s->T1, val);
-                gen_op(s, op, ot, OR_EAX);
-                break;
-            }
-        }
-        break;
-
-    case 0x82:
-        if (CODE64(s))
-            goto illegal_op;
-        /* fall through */
-    case 0x80: /* GRP1 */
-    case 0x81:
-    case 0x83:
-        {
-            ot = mo_b_d(b, dflag);
-
-            modrm = x86_ldub_code(env, s);
-            mod = (modrm >> 6) & 3;
-            rm = (modrm & 7) | REX_B(s);
-            op = (modrm >> 3) & 7;
-
-            if (mod != 3) {
-                if (b == 0x83)
-                    s->rip_offset = 1;
-                else
-                    s->rip_offset = insn_const_size(ot);
-                gen_lea_modrm(env, s, modrm);
-                opreg = OR_TMP0;
-            } else {
-                opreg = rm;
-            }
-
-            switch(b) {
-            default:
-            case 0x80:
-            case 0x81:
-            case 0x82:
-                val = insn_get(env, s, ot);
-                break;
-            case 0x83:
-                val = (int8_t)insn_get(env, s, MO_8);
-                break;
-            }
-            tcg_gen_movi_tl(s->T1, val);
-            gen_op(s, op, ot, opreg);
-        }
-        break;
-
-        /**************************/
-        /* inc, dec, and other misc arith */
-    case 0x40 ... 0x47: /* inc Gv */
-        ot = dflag;
-        gen_inc(s, ot, OR_EAX + (b & 7), 1);
-        break;
-    case 0x48 ... 0x4f: /* dec Gv */
-        ot = dflag;
-        gen_inc(s, ot, OR_EAX + (b & 7), -1);
-        break;
-    case 0xf6: /* GRP3 */
-    case 0xf7:
-        ot = mo_b_d(b, dflag);
-
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        rm = (modrm & 7) | REX_B(s);
-        op = (modrm >> 3) & 7;
-        if (mod != 3) {
-            if (op == 0) {
-                s->rip_offset = insn_const_size(ot);
-            }
-            gen_lea_modrm(env, s, modrm);
-            /* For those below that handle locked memory, don't load here.  */
-            if (!(s->prefix & PREFIX_LOCK)
-                || op != 2) {
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-            }
-        } else {
-            gen_op_mov_v_reg(s, ot, s->T0, rm);
-        }
-
-        switch(op) {
-        case 0: /* test */
-            val = insn_get(env, s, ot);
-            tcg_gen_movi_tl(s->T1, val);
-            gen_op_testl_T0_T1_cc(s);
-            set_cc_op(s, CC_OP_LOGICB + ot);
-            break;
-        case 2: /* not */
-            if (s->prefix & PREFIX_LOCK) {
-                if (mod == 3) {
-                    goto illegal_op;
-                }
-                tcg_gen_movi_tl(s->T0, ~0);
-                tcg_gen_atomic_xor_fetch_tl(s->T0, s->A0, s->T0,
-                                            s->mem_index, ot | MO_LE);
-            } else {
-                tcg_gen_not_tl(s->T0, s->T0);
-                if (mod != 3) {
-                    gen_op_st_v(s, ot, s->T0, s->A0);
-                } else {
-                    gen_op_mov_reg_v(s, ot, rm, s->T0);
-                }
-            }
-            break;
-        case 3: /* neg */
-            if (s->prefix & PREFIX_LOCK) {
-                TCGLabel *label1;
-                TCGv a0, t0, t1, t2;
-
-                if (mod == 3) {
-                    goto illegal_op;
-                }
-                a0 = s->A0;
-                t0 = s->T0;
-                label1 = gen_new_label();
-
-                gen_set_label(label1);
-                t1 = tcg_temp_new();
-                t2 = tcg_temp_new();
-                tcg_gen_mov_tl(t2, t0);
-                tcg_gen_neg_tl(t1, t0);
-                tcg_gen_atomic_cmpxchg_tl(t0, a0, t0, t1,
-                                          s->mem_index, ot | MO_LE);
-                tcg_gen_brcond_tl(TCG_COND_NE, t0, t2, label1);
-
-                tcg_gen_neg_tl(s->T0, t0);
-            } else {
-                tcg_gen_neg_tl(s->T0, s->T0);
-                if (mod != 3) {
-                    gen_op_st_v(s, ot, s->T0, s->A0);
-                } else {
-                    gen_op_mov_reg_v(s, ot, rm, s->T0);
-                }
-            }
-            gen_op_update_neg_cc(s);
-            set_cc_op(s, CC_OP_SUBB + ot);
-            break;
-        case 4: /* mul */
-            switch(ot) {
-            case MO_8:
-                gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
-                tcg_gen_ext8u_tl(s->T0, s->T0);
-                tcg_gen_ext8u_tl(s->T1, s->T1);
-                /* XXX: use 32 bit mul which could be faster */
-                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-                tcg_gen_andi_tl(cpu_cc_src, s->T0, 0xff00);
-                set_cc_op(s, CC_OP_MULB);
-                break;
-            case MO_16:
-                gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
-                tcg_gen_ext16u_tl(s->T0, s->T0);
-                tcg_gen_ext16u_tl(s->T1, s->T1);
-                /* XXX: use 32 bit mul which could be faster */
-                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-                tcg_gen_shri_tl(s->T0, s->T0, 16);
-                gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
-                tcg_gen_mov_tl(cpu_cc_src, s->T0);
-                set_cc_op(s, CC_OP_MULW);
-                break;
-            default:
-            case MO_32:
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
-                tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
-                                  s->tmp2_i32, s->tmp3_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EDX], s->tmp3_i32);
-                tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
-                tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
-                set_cc_op(s, CC_OP_MULL);
-                break;
-#ifdef TARGET_X86_64
-            case MO_64:
-                tcg_gen_mulu2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
-                                  s->T0, cpu_regs[R_EAX]);
-                tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
-                tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
-                set_cc_op(s, CC_OP_MULQ);
-                break;
-#endif
-            }
-            break;
-        case 5: /* imul */
-            switch(ot) {
-            case MO_8:
-                gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
-                tcg_gen_ext8s_tl(s->T0, s->T0);
-                tcg_gen_ext8s_tl(s->T1, s->T1);
-                /* XXX: use 32 bit mul which could be faster */
-                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-                tcg_gen_ext8s_tl(s->tmp0, s->T0);
-                tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
-                set_cc_op(s, CC_OP_MULB);
-                break;
-            case MO_16:
-                gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
-                tcg_gen_ext16s_tl(s->T0, s->T0);
-                tcg_gen_ext16s_tl(s->T1, s->T1);
-                /* XXX: use 32 bit mul which could be faster */
-                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-                tcg_gen_ext16s_tl(s->tmp0, s->T0);
-                tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
-                tcg_gen_shri_tl(s->T0, s->T0, 16);
-                gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
-                set_cc_op(s, CC_OP_MULW);
-                break;
-            default:
-            case MO_32:
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
-                tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
-                                  s->tmp2_i32, s->tmp3_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EDX], s->tmp3_i32);
-                tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
-                tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
-                tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
-                tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
-                set_cc_op(s, CC_OP_MULL);
-                break;
-#ifdef TARGET_X86_64
-            case MO_64:
-                tcg_gen_muls2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
-                                  s->T0, cpu_regs[R_EAX]);
-                tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
-                tcg_gen_sari_tl(cpu_cc_src, cpu_regs[R_EAX], 63);
-                tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, cpu_regs[R_EDX]);
-                set_cc_op(s, CC_OP_MULQ);
-                break;
-#endif
-            }
-            break;
-        case 6: /* div */
-            switch(ot) {
-            case MO_8:
-                gen_helper_divb_AL(tcg_env, s->T0);
-                break;
-            case MO_16:
-                gen_helper_divw_AX(tcg_env, s->T0);
-                break;
-            default:
-            case MO_32:
-                gen_helper_divl_EAX(tcg_env, s->T0);
-                break;
-#ifdef TARGET_X86_64
-            case MO_64:
-                gen_helper_divq_EAX(tcg_env, s->T0);
-                break;
-#endif
-            }
-            break;
-        case 7: /* idiv */
-            switch(ot) {
-            case MO_8:
-                gen_helper_idivb_AL(tcg_env, s->T0);
-                break;
-            case MO_16:
-                gen_helper_idivw_AX(tcg_env, s->T0);
-                break;
-            default:
-            case MO_32:
-                gen_helper_idivl_EAX(tcg_env, s->T0);
-                break;
-#ifdef TARGET_X86_64
-            case MO_64:
-                gen_helper_idivq_EAX(tcg_env, s->T0);
-                break;
-#endif
-            }
-            break;
-        default:
-            goto unknown_op;
-        }
-        break;
-
-    case 0xfe: /* GRP4 */
-    case 0xff: /* GRP5 */
-        ot = mo_b_d(b, dflag);
-
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        rm = (modrm & 7) | REX_B(s);
-        op = (modrm >> 3) & 7;
-        if (op >= 2 && b == 0xfe) {
-            goto unknown_op;
-        }
-        if (CODE64(s)) {
-            if (op == 2 || op == 4) {
-                /* operand size for jumps is 64 bit */
-                ot = MO_64;
-            } else if (op == 3 || op == 5) {
-                ot = dflag != MO_16 ? MO_32 + REX_W(s) : MO_16;
-            } else if (op == 6) {
-                /* default push size is 64 bit */
-                ot = mo_pushpop(s, dflag);
-            }
-        }
-        if (mod != 3) {
-            gen_lea_modrm(env, s, modrm);
-            if (op >= 2 && op != 3 && op != 5)
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-        } else {
-            gen_op_mov_v_reg(s, ot, s->T0, rm);
-        }
-
-        switch(op) {
-        case 0: /* inc Ev */
-            if (mod != 3)
-                opreg = OR_TMP0;
-            else
-                opreg = rm;
-            gen_inc(s, ot, opreg, 1);
-            break;
-        case 1: /* dec Ev */
-            if (mod != 3)
-                opreg = OR_TMP0;
-            else
-                opreg = rm;
-            gen_inc(s, ot, opreg, -1);
-            break;
-        case 2: /* call Ev */
-            /* XXX: optimize if memory (no 'and' is necessary) */
-            if (dflag == MO_16) {
-                tcg_gen_ext16u_tl(s->T0, s->T0);
-            }
-            gen_push_v(s, eip_next_tl(s));
-            gen_op_jmp_v(s, s->T0);
-            gen_bnd_jmp(s);
-            s->base.is_jmp = DISAS_JUMP;
-            break;
-        case 3: /* lcall Ev */
-            if (mod == 3) {
-                goto illegal_op;
-            }
-            gen_op_ld_v(s, ot, s->T0, s->A0);
-            gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T1, s->A0);
-            gen_far_call(s);
-            break;
-        case 4: /* jmp Ev */
-            if (dflag == MO_16) {
-                tcg_gen_ext16u_tl(s->T0, s->T0);
-            }
-            gen_op_jmp_v(s, s->T0);
-            gen_bnd_jmp(s);
-            s->base.is_jmp = DISAS_JUMP;
-            break;
-        case 5: /* ljmp Ev */
-            if (mod == 3) {
-                goto illegal_op;
-            }
-            gen_op_ld_v(s, ot, s->T0, s->A0);
-            gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, s->T1, s->A0);
-            gen_far_jmp(s);
-            break;
-        case 6: /* push Ev */
-            gen_push_v(s, s->T0);
-            break;
-        default:
-            goto unknown_op;
-        }
-        break;
-
-    case 0x84: /* test Ev, Gv */
-    case 0x85:
-        ot = mo_b_d(b, dflag);
-
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_op_mov_v_reg(s, ot, s->T1, reg);
-        gen_op_testl_T0_T1_cc(s);
-        set_cc_op(s, CC_OP_LOGICB + ot);
-        break;
-
-    case 0xa8: /* test eAX, Iv */
-    case 0xa9:
-        ot = mo_b_d(b, dflag);
-        val = insn_get(env, s, ot);
-
-        gen_op_mov_v_reg(s, ot, s->T0, OR_EAX);
-        tcg_gen_movi_tl(s->T1, val);
-        gen_op_testl_T0_T1_cc(s);
-        set_cc_op(s, CC_OP_LOGICB + ot);
-        break;
-
-    case 0x98: /* CWDE/CBW */
-        switch (dflag) {
-#ifdef TARGET_X86_64
-        case MO_64:
-            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
-            tcg_gen_ext32s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_64, R_EAX, s->T0);
-            break;
-#endif
-        case MO_32:
-            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
-            tcg_gen_ext16s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
-            break;
-        case MO_16:
-            gen_op_mov_v_reg(s, MO_8, s->T0, R_EAX);
-            tcg_gen_ext8s_tl(s->T0, s->T0);
-            gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-    case 0x99: /* CDQ/CWD */
-        switch (dflag) {
-#ifdef TARGET_X86_64
-        case MO_64:
-            gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
-            tcg_gen_sari_tl(s->T0, s->T0, 63);
-            gen_op_mov_reg_v(s, MO_64, R_EDX, s->T0);
-            break;
-#endif
-        case MO_32:
-            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
-            tcg_gen_ext32s_tl(s->T0, s->T0);
-            tcg_gen_sari_tl(s->T0, s->T0, 31);
-            gen_op_mov_reg_v(s, MO_32, R_EDX, s->T0);
-            break;
-        case MO_16:
-            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
-            tcg_gen_ext16s_tl(s->T0, s->T0);
-            tcg_gen_sari_tl(s->T0, s->T0, 15);
-            gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
-    case 0x1af: /* imul Gv, Ev */
-    case 0x69: /* imul Gv, Ev, I */
-    case 0x6b:
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        if (b == 0x69)
-            s->rip_offset = insn_const_size(ot);
-        else if (b == 0x6b)
-            s->rip_offset = 1;
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        if (b == 0x69) {
-            val = insn_get(env, s, ot);
-            tcg_gen_movi_tl(s->T1, val);
-        } else if (b == 0x6b) {
-            val = (int8_t)insn_get(env, s, MO_8);
-            tcg_gen_movi_tl(s->T1, val);
-        } else {
-            gen_op_mov_v_reg(s, ot, s->T1, reg);
-        }
-        switch (ot) {
-#ifdef TARGET_X86_64
-        case MO_64:
-            tcg_gen_muls2_i64(cpu_regs[reg], s->T1, s->T0, s->T1);
-            tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
-            tcg_gen_sari_tl(cpu_cc_src, cpu_cc_dst, 63);
-            tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, s->T1);
-            break;
-#endif
-        case MO_32:
-            tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-            tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-            tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
-                              s->tmp2_i32, s->tmp3_i32);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
-            tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
-            tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
-            tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
-            tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
-            break;
-        default:
-            tcg_gen_ext16s_tl(s->T0, s->T0);
-            tcg_gen_ext16s_tl(s->T1, s->T1);
-            /* XXX: use 32 bit mul which could be faster */
-            tcg_gen_mul_tl(s->T0, s->T0, s->T1);
-            tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-            tcg_gen_ext16s_tl(s->tmp0, s->T0);
-            tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
-            gen_op_mov_reg_v(s, ot, reg, s->T0);
-            break;
-        }
-        set_cc_op(s, CC_OP_MULB + ot);
-        break;
     case 0x1c0:
     case 0x1c1: /* xadd Ev, Gv */
         ot = mo_b_d(b, dflag);
@@ -4023,375 +2868,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
 
         /**************************/
-        /* push/pop */
-    case 0x50 ... 0x57: /* push */
-        gen_op_mov_v_reg(s, MO_32, s->T0, (b & 7) | REX_B(s));
-        gen_push_v(s, s->T0);
-        break;
-    case 0x58 ... 0x5f: /* pop */
-        ot = gen_pop_T0(s);
-        /* NOTE: order is important for pop %sp */
-        gen_pop_update(s, ot);
-        gen_op_mov_reg_v(s, ot, (b & 7) | REX_B(s), s->T0);
-        break;
-    case 0x60: /* pusha */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_pusha(s);
-        break;
-    case 0x61: /* popa */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_popa(s);
-        break;
-    case 0x68: /* push Iv */
-    case 0x6a:
-        ot = mo_pushpop(s, dflag);
-        if (b == 0x68)
-            val = insn_get(env, s, ot);
-        else
-            val = (int8_t)insn_get(env, s, MO_8);
-        tcg_gen_movi_tl(s->T0, val);
-        gen_push_v(s, s->T0);
-        break;
-    case 0x8f: /* pop Ev */
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        ot = gen_pop_T0(s);
-        if (mod == 3) {
-            /* NOTE: order is important for pop %sp */
-            gen_pop_update(s, ot);
-            rm = (modrm & 7) | REX_B(s);
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-        } else {
-            /* NOTE: order is important too for MMU exceptions */
-            s->popl_esp_hack = 1 << ot;
-            gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
-            s->popl_esp_hack = 0;
-            gen_pop_update(s, ot);
-        }
-        break;
-    case 0xc8: /* enter */
-        {
-            int level;
-            val = x86_lduw_code(env, s);
-            level = x86_ldub_code(env, s);
-            gen_enter(s, val, level);
-        }
-        break;
-    case 0xc9: /* leave */
-        gen_leave(s);
-        break;
-    case 0x06: /* push es */
-    case 0x0e: /* push cs */
-    case 0x16: /* push ss */
-    case 0x1e: /* push ds */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_op_movl_T0_seg(s, b >> 3);
-        gen_push_v(s, s->T0);
-        break;
-    case 0x1a0: /* push fs */
-    case 0x1a8: /* push gs */
-        gen_op_movl_T0_seg(s, (b >> 3) & 7);
-        gen_push_v(s, s->T0);
-        break;
-    case 0x07: /* pop es */
-    case 0x17: /* pop ss */
-    case 0x1f: /* pop ds */
-        if (CODE64(s))
-            goto illegal_op;
-        reg = b >> 3;
-        ot = gen_pop_T0(s);
-        gen_movl_seg(s, reg, s->T0);
-        gen_pop_update(s, ot);
-        break;
-    case 0x1a1: /* pop fs */
-    case 0x1a9: /* pop gs */
-        ot = gen_pop_T0(s);
-        gen_movl_seg(s, (b >> 3) & 7, s->T0);
-        gen_pop_update(s, ot);
-        break;
-
-        /**************************/
-        /* mov */
-    case 0x88:
-    case 0x89: /* mov Gv, Ev */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        /* generate a generic store */
-        gen_ldst_modrm(env, s, modrm, ot, reg, 1);
-        break;
-    case 0xc6:
-    case 0xc7: /* mov Ev, Iv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        if (mod != 3) {
-            s->rip_offset = insn_const_size(ot);
-            gen_lea_modrm(env, s, modrm);
-        }
-        val = insn_get(env, s, ot);
-        tcg_gen_movi_tl(s->T0, val);
-        if (mod != 3) {
-            gen_op_st_v(s, ot, s->T0, s->A0);
-        } else {
-            gen_op_mov_reg_v(s, ot, (modrm & 7) | REX_B(s), s->T0);
-        }
-        break;
-    case 0x8a:
-    case 0x8b: /* mov Ev, Gv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_op_mov_reg_v(s, ot, reg, s->T0);
-        break;
-    case 0x8e: /* mov seg, Gv */
-        modrm = x86_ldub_code(env, s);
-        reg = (modrm >> 3) & 7;
-        if (reg >= 6 || reg == R_CS)
-            goto illegal_op;
-        gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-        gen_movl_seg(s, reg, s->T0);
-        break;
-    case 0x8c: /* mov Gv, seg */
-        modrm = x86_ldub_code(env, s);
-        reg = (modrm >> 3) & 7;
-        mod = (modrm >> 6) & 3;
-        if (reg >= 6)
-            goto illegal_op;
-        gen_op_movl_T0_seg(s, reg);
-        ot = mod == 3 ? dflag : MO_16;
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
-        break;
-
-    case 0x1b6: /* movzbS Gv, Eb */
-    case 0x1b7: /* movzwS Gv, Eb */
-    case 0x1be: /* movsbS Gv, Eb */
-    case 0x1bf: /* movswS Gv, Eb */
-        {
-            MemOp d_ot;
-            MemOp s_ot;
-
-            /* d_ot is the size of destination */
-            d_ot = dflag;
-            /* ot is the size of source */
-            ot = (b & 1) + MO_8;
-            /* s_ot is the sign+size of source */
-            s_ot = b & 8 ? MO_SIGN | ot : ot;
-
-            modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            mod = (modrm >> 6) & 3;
-            rm = (modrm & 7) | REX_B(s);
-
-            if (mod == 3) {
-                if (s_ot == MO_SB && byte_reg_is_xH(s, rm)) {
-                    tcg_gen_sextract_tl(s->T0, cpu_regs[rm - 4], 8, 8);
-                } else {
-                    gen_op_mov_v_reg(s, ot, s->T0, rm);
-                    switch (s_ot) {
-                    case MO_UB:
-                        tcg_gen_ext8u_tl(s->T0, s->T0);
-                        break;
-                    case MO_SB:
-                        tcg_gen_ext8s_tl(s->T0, s->T0);
-                        break;
-                    case MO_UW:
-                        tcg_gen_ext16u_tl(s->T0, s->T0);
-                        break;
-                    default:
-                    case MO_SW:
-                        tcg_gen_ext16s_tl(s->T0, s->T0);
-                        break;
-                    }
-                }
-                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
-            } else {
-                gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, s_ot, s->T0, s->A0);
-                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
-            }
-        }
-        break;
-
-    case 0x8d: /* lea */
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm);
-            TCGv ea = gen_lea_modrm_1(s, a, false);
-            gen_lea_v_seg(s, s->aflag, ea, -1, -1);
-            gen_op_mov_reg_v(s, dflag, reg, s->A0);
-        }
-        break;
-
-    case 0xa0: /* mov EAX, Ov */
-    case 0xa1:
-    case 0xa2: /* mov Ov, EAX */
-    case 0xa3:
-        {
-            target_ulong offset_addr;
-
-            ot = mo_b_d(b, dflag);
-            offset_addr = insn_get_addr(env, s, s->aflag);
-            tcg_gen_movi_tl(s->A0, offset_addr);
-            gen_add_A0_ds_seg(s);
-            if ((b & 2) == 0) {
-                gen_op_ld_v(s, ot, s->T0, s->A0);
-                gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
-            } else {
-                gen_op_mov_v_reg(s, ot, s->T0, R_EAX);
-                gen_op_st_v(s, ot, s->T0, s->A0);
-            }
-        }
-        break;
-    case 0xd7: /* xlat */
-        tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
-        tcg_gen_ext8u_tl(s->T0, cpu_regs[R_EAX]);
-        tcg_gen_add_tl(s->A0, s->A0, s->T0);
-        gen_add_A0_ds_seg(s);
-        gen_op_ld_v(s, MO_8, s->T0, s->A0);
-        gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
-        break;
-    case 0xb0 ... 0xb7: /* mov R, Ib */
-        val = insn_get(env, s, MO_8);
-        tcg_gen_movi_tl(s->T0, val);
-        gen_op_mov_reg_v(s, MO_8, (b & 7) | REX_B(s), s->T0);
-        break;
-    case 0xb8 ... 0xbf: /* mov R, Iv */
-#ifdef TARGET_X86_64
-        if (dflag == MO_64) {
-            uint64_t tmp;
-            /* 64 bit case */
-            tmp = x86_ldq_code(env, s);
-            reg = (b & 7) | REX_B(s);
-            tcg_gen_movi_tl(s->T0, tmp);
-            gen_op_mov_reg_v(s, MO_64, reg, s->T0);
-        } else
-#endif
-        {
-            ot = dflag;
-            val = insn_get(env, s, ot);
-            reg = (b & 7) | REX_B(s);
-            tcg_gen_movi_tl(s->T0, val);
-            gen_op_mov_reg_v(s, ot, reg, s->T0);
-        }
-        break;
-
-    case 0x91 ... 0x97: /* xchg R, EAX */
-    do_xchg_reg_eax:
-        ot = dflag;
-        reg = (b & 7) | REX_B(s);
-        rm = R_EAX;
-        goto do_xchg_reg;
-    case 0x86:
-    case 0x87: /* xchg Ev, Gv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3) {
-            rm = (modrm & 7) | REX_B(s);
-        do_xchg_reg:
-            gen_op_mov_v_reg(s, ot, s->T0, reg);
-            gen_op_mov_v_reg(s, ot, s->T1, rm);
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-        } else {
-            gen_lea_modrm(env, s, modrm);
-            gen_op_mov_v_reg(s, ot, s->T0, reg);
-            /* for xchg, lock is implicit */
-            tcg_gen_atomic_xchg_tl(s->T1, s->A0, s->T0,
-                                   s->mem_index, ot | MO_LE);
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-        }
-        break;
-    case 0xc4: /* les Gv */
-        /* In CODE64 this is VEX3; see above.  */
-        op = R_ES;
-        goto do_lxx;
-    case 0xc5: /* lds Gv */
-        /* In CODE64 this is VEX2; see above.  */
-        op = R_DS;
-        goto do_lxx;
-    case 0x1b2: /* lss Gv */
-        op = R_SS;
-        goto do_lxx;
-    case 0x1b4: /* lfs Gv */
-        op = R_FS;
-        goto do_lxx;
-    case 0x1b5: /* lgs Gv */
-        op = R_GS;
-    do_lxx:
-        ot = dflag != MO_16 ? MO_32 : MO_16;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        gen_lea_modrm(env, s, modrm);
-        gen_op_ld_v(s, ot, s->T1, s->A0);
-        gen_add_A0_im(s, 1 << ot);
-        /* load the segment first to handle exceptions properly */
-        gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        gen_movl_seg(s, op, s->T0);
-        /* then put the data */
-        gen_op_mov_reg_v(s, ot, reg, s->T1);
-        break;
-
-        /************************/
         /* shifts */
-    case 0xc0:
-    case 0xc1:
-        /* shift Ev,Ib */
-        shift = 2;
-    grp2:
-        {
-            ot = mo_b_d(b, dflag);
-            modrm = x86_ldub_code(env, s);
-            mod = (modrm >> 6) & 3;
-            op = (modrm >> 3) & 7;
-
-            if (mod != 3) {
-                if (shift == 2) {
-                    s->rip_offset = 1;
-                }
-                gen_lea_modrm(env, s, modrm);
-                opreg = OR_TMP0;
-            } else {
-                opreg = (modrm & 7) | REX_B(s);
-            }
-
-            /* simpler op */
-            if (shift == 0) {
-                gen_shift(s, op, ot, opreg, OR_ECX);
-            } else {
-                if (shift == 2) {
-                    shift = x86_ldub_code(env, s);
-                }
-                gen_shifti(s, op, ot, opreg, shift);
-            }
-        }
-        break;
-    case 0xd0:
-    case 0xd1:
-        /* shift Ev,1 */
-        shift = 1;
-        goto grp2;
-    case 0xd2:
-    case 0xd3:
-        /* shift Ev,cl */
-        shift = 0;
-        goto grp2;
-
     case 0x1a4: /* shld imm */
         op = 0;
         shift = 1;
@@ -4988,374 +3465,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             }
         }
         break;
-        /************************/
-        /* string ops */
-
-    case 0xa4: /* movsS */
-    case 0xa5:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_movs(s, ot);
-        } else {
-            gen_movs(s, ot);
-        }
-        break;
-
-    case 0xaa: /* stosS */
-    case 0xab:
-        ot = mo_b_d(b, dflag);
-        gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_stos(s, ot);
-        } else {
-            gen_stos(s, ot);
-        }
-        break;
-    case 0xac: /* lodsS */
-    case 0xad:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_lods(s, ot);
-        } else {
-            gen_lods(s, ot);
-        }
-        break;
-    case 0xae: /* scasS */
-    case 0xaf:
-        ot = mo_b_d(b, dflag);
-        gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
-        if (prefixes & PREFIX_REPNZ) {
-            gen_repz_scas(s, ot, 1);
-        } else if (prefixes & PREFIX_REPZ) {
-            gen_repz_scas(s, ot, 0);
-        } else {
-            gen_scas(s, ot);
-        }
-        break;
-
-    case 0xa6: /* cmpsS */
-    case 0xa7:
-        ot = mo_b_d(b, dflag);
-        if (prefixes & PREFIX_REPNZ) {
-            gen_repz_cmps(s, ot, 1);
-        } else if (prefixes & PREFIX_REPZ) {
-            gen_repz_cmps(s, ot, 0);
-        } else {
-            gen_cmps(s, ot);
-        }
-        break;
-    case 0x6c: /* insS */
-    case 0x6d:
-        ot = mo_b_d32(b, dflag);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-        tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
-        if (!gen_check_io(s, ot, s->tmp2_i32,
-                          SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_ins(s, ot);
-        } else {
-            gen_ins(s, ot);
-        }
-        break;
-    case 0x6e: /* outsS */
-    case 0x6f:
-        ot = mo_b_d32(b, dflag);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-        tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
-        if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_STR_MASK)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_outs(s, ot);
-        } else {
-            gen_outs(s, ot);
-        }
-        break;
-
-        /************************/
-        /* port I/O */
-
-    case 0xe4:
-    case 0xe5:
-        ot = mo_b_d32(b, dflag);
-        val = x86_ldub_code(env, s);
-        tcg_gen_movi_i32(s->tmp2_i32, val);
-        if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_TYPE_MASK)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        gen_helper_in_func(ot, s->T1, s->tmp2_i32);
-        gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
-        gen_bpt_io(s, s->tmp2_i32, ot);
-        break;
-    case 0xe6:
-    case 0xe7:
-        ot = mo_b_d32(b, dflag);
-        val = x86_ldub_code(env, s);
-        tcg_gen_movi_i32(s->tmp2_i32, val);
-        if (!gen_check_io(s, ot, s->tmp2_i32, 0)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
-        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-        gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
-        gen_bpt_io(s, s->tmp2_i32, ot);
-        break;
-    case 0xec:
-    case 0xed:
-        ot = mo_b_d32(b, dflag);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-        tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
-        if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_TYPE_MASK)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        gen_helper_in_func(ot, s->T1, s->tmp2_i32);
-        gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
-        gen_bpt_io(s, s->tmp2_i32, ot);
-        break;
-    case 0xee:
-    case 0xef:
-        ot = mo_b_d32(b, dflag);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
-        tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
-        if (!gen_check_io(s, ot, s->tmp2_i32, 0)) {
-            break;
-        }
-        translator_io_start(&s->base);
-        gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
-        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-        gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
-        gen_bpt_io(s, s->tmp2_i32, ot);
-        break;
-
-        /************************/
-        /* control */
-    case 0xc2: /* ret im */
-        val = x86_ldsw_code(env, s);
-        ot = gen_pop_T0(s);
-        gen_stack_update(s, val + (1 << ot));
-        /* Note that gen_pop_T0 uses a zero-extending load.  */
-        gen_op_jmp_v(s, s->T0);
-        gen_bnd_jmp(s);
-        s->base.is_jmp = DISAS_JUMP;
-        break;
-    case 0xc3: /* ret */
-        ot = gen_pop_T0(s);
-        gen_pop_update(s, ot);
-        /* Note that gen_pop_T0 uses a zero-extending load.  */
-        gen_op_jmp_v(s, s->T0);
-        gen_bnd_jmp(s);
-        s->base.is_jmp = DISAS_JUMP;
-        break;
-    case 0xca: /* lret im */
-        val = x86_ldsw_code(env, s);
-    do_lret:
-        if (PE(s) && !VM86(s)) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            gen_helper_lret_protected(tcg_env, tcg_constant_i32(dflag - 1),
-                                      tcg_constant_i32(val));
-        } else {
-            gen_stack_A0(s);
-            /* pop offset */
-            gen_op_ld_v(s, dflag, s->T0, s->A0);
-            /* NOTE: keeping EIP updated is not a problem in case of
-               exception */
-            gen_op_jmp_v(s, s->T0);
-            /* pop selector */
-            gen_add_A0_im(s, 1 << dflag);
-            gen_op_ld_v(s, dflag, s->T0, s->A0);
-            gen_op_movl_seg_real(s, R_CS, s->T0);
-            /* add stack offset */
-            gen_stack_update(s, val + (2 << dflag));
-        }
-        s->base.is_jmp = DISAS_EOB_ONLY;
-        break;
-    case 0xcb: /* lret */
-        val = 0;
-        goto do_lret;
-    case 0xcf: /* iret */
-        gen_svm_check_intercept(s, SVM_EXIT_IRET);
-        if (!PE(s) || VM86(s)) {
-            /* real mode or vm86 mode */
-            if (!check_vm86_iopl(s)) {
-                break;
-            }
-            gen_helper_iret_real(tcg_env, tcg_constant_i32(dflag - 1));
-        } else {
-            gen_helper_iret_protected(tcg_env, tcg_constant_i32(dflag - 1),
-                                      eip_next_i32(s));
-        }
-        set_cc_op(s, CC_OP_EFLAGS);
-        s->base.is_jmp = DISAS_EOB_ONLY;
-        break;
-    case 0xe8: /* call im */
-        {
-            int diff = (dflag != MO_16
-                        ? (int32_t)insn_get(env, s, MO_32)
-                        : (int16_t)insn_get(env, s, MO_16));
-            gen_push_v(s, eip_next_tl(s));
-            gen_bnd_jmp(s);
-            gen_update_cc_op(s);
-            gen_jmp_rel(s, dflag, diff, 0);
-        }
-        break;
-    case 0x9a: /* lcall im */
-        {
-            unsigned int selector, offset;
-
-            if (CODE64(s))
-                goto illegal_op;
-            ot = dflag;
-            offset = insn_get(env, s, ot);
-            selector = insn_get(env, s, MO_16);
-
-            tcg_gen_movi_tl(s->T0, offset);
-            tcg_gen_movi_tl(s->T1, selector);
-        }
-        gen_far_call(s);
-        break;
-    case 0xe9: /* jmp im */
-        {
-            int diff = (dflag != MO_16
-                        ? (int32_t)insn_get(env, s, MO_32)
-                        : (int16_t)insn_get(env, s, MO_16));
-            gen_bnd_jmp(s);
-            gen_update_cc_op(s);
-            gen_jmp_rel(s, dflag, diff, 0);
-        }
-        break;
-    case 0xea: /* ljmp im */
-        {
-            unsigned int selector, offset;
-
-            if (CODE64(s))
-                goto illegal_op;
-            ot = dflag;
-            offset = insn_get(env, s, ot);
-            selector = insn_get(env, s, MO_16);
-
-            tcg_gen_movi_tl(s->T0, offset);
-            tcg_gen_movi_tl(s->T1, selector);
-        }
-        gen_far_jmp(s);
-        break;
-    case 0xeb: /* jmp Jb */
-        {
-            int diff = (int8_t)insn_get(env, s, MO_8);
-            gen_update_cc_op(s);
-            gen_jmp_rel(s, dflag, diff, 0);
-        }
-        break;
-    case 0x70 ... 0x7f: /* jcc Jb */
-        {
-            int diff = (int8_t)insn_get(env, s, MO_8);
-            gen_bnd_jmp(s);
-            gen_jcc(s, b, diff);
-        }
-        break;
-    case 0x180 ... 0x18f: /* jcc Jv */
-        {
-            int diff = (dflag != MO_16
-                        ? (int32_t)insn_get(env, s, MO_32)
-                        : (int16_t)insn_get(env, s, MO_16));
-            gen_bnd_jmp(s);
-            gen_jcc(s, b, diff);
-        }
-        break;
-
-    case 0x190 ... 0x19f: /* setcc Gv */
-        modrm = x86_ldub_code(env, s);
-        gen_setcc1(s, b, s->T0);
-        gen_ldst_modrm(env, s, modrm, MO_8, OR_TMP0, 1);
-        break;
-    case 0x140 ... 0x14f: /* cmov Gv, Ev */
-        if (!(s->cpuid_features & CPUID_CMOV)) {
-            goto illegal_op;
-        }
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-        gen_cmovcc1(s, b ^ 1, s->T0, cpu_regs[reg]);
-        gen_op_mov_reg_v(s, ot, reg, s->T0);
-        break;
-
-        /************************/
-        /* flags */
-    case 0x9c: /* pushf */
-        gen_svm_check_intercept(s, SVM_EXIT_PUSHF);
-        if (check_vm86_iopl(s)) {
-            gen_update_cc_op(s);
-            gen_helper_read_eflags(s->T0, tcg_env);
-            gen_push_v(s, s->T0);
-        }
-        break;
-    case 0x9d: /* popf */
-        gen_svm_check_intercept(s, SVM_EXIT_POPF);
-        if (check_vm86_iopl(s)) {
-            int mask = TF_MASK | AC_MASK | ID_MASK | NT_MASK;
-
-            if (CPL(s) == 0) {
-                mask |= IF_MASK | IOPL_MASK;
-            } else if (CPL(s) <= IOPL(s)) {
-                mask |= IF_MASK;
-            }
-            if (dflag == MO_16) {
-                mask &= 0xffff;
-            }
-
-            ot = gen_pop_T0(s);
-            gen_helper_write_eflags(tcg_env, s->T0, tcg_constant_i32(mask));
-            gen_pop_update(s, ot);
-            set_cc_op(s, CC_OP_EFLAGS);
-            /* abort translation because TF/AC flag may change */
-            s->base.is_jmp = DISAS_EOB_NEXT;
-        }
-        break;
-    case 0x9e: /* sahf */
-        if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
-            goto illegal_op;
-        tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
-        gen_compute_eflags(s);
-        tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
-        tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
-        tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
-        break;
-    case 0x9f: /* lahf */
-        if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
-            goto illegal_op;
-        gen_compute_eflags(s);
-        /* Note: gen_compute_eflags() only gives the condition codes */
-        tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
-        tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
-        break;
-    case 0xf5: /* cmc */
-        gen_compute_eflags(s);
-        tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
-        break;
-    case 0xf8: /* clc */
-        gen_compute_eflags(s);
-        tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_C);
-        break;
-    case 0xf9: /* stc */
-        gen_compute_eflags(s);
-        tcg_gen_ori_tl(cpu_cc_src, cpu_cc_src, CC_C);
-        break;
-    case 0xfc: /* cld */
-        tcg_gen_movi_i32(s->tmp2_i32, 1);
-        tcg_gen_st_i32(s->tmp2_i32, tcg_env, offsetof(CPUX86State, df));
-        break;
-    case 0xfd: /* std */
-        tcg_gen_movi_i32(s->tmp2_i32, -1);
-        tcg_gen_st_i32(s->tmp2_i32, tcg_env, offsetof(CPUX86State, df));
-        break;
 
         /************************/
         /* bit operations */
@@ -5546,188 +3655,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         gen_op_mov_reg_v(s, ot, reg, s->T0);
         break;
-        /************************/
-        /* bcd */
-    case 0x27: /* daa */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_daa(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0x2f: /* das */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_das(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0x37: /* aaa */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_aaa(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0x3f: /* aas */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_helper_aas(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
-        break;
-    case 0xd4: /* aam */
-        if (CODE64(s))
-            goto illegal_op;
-        val = x86_ldub_code(env, s);
-        if (val == 0) {
-            gen_exception(s, EXCP00_DIVZ);
-        } else {
-            gen_helper_aam(tcg_env, tcg_constant_i32(val));
-            set_cc_op(s, CC_OP_LOGICB);
-        }
-        break;
-    case 0xd5: /* aad */
-        if (CODE64(s))
-            goto illegal_op;
-        val = x86_ldub_code(env, s);
-        gen_helper_aad(tcg_env, tcg_constant_i32(val));
-        set_cc_op(s, CC_OP_LOGICB);
-        break;
-        /************************/
-        /* misc */
-    case 0x90: /* nop */
-        /* XXX: correct lock test for all insn */
-        if (prefixes & PREFIX_LOCK) {
-            goto illegal_op;
-        }
-        /* If REX_B is set, then this is xchg eax, r8d, not a nop.  */
-        if (REX_B(s)) {
-            goto do_xchg_reg_eax;
-        }
-        if (prefixes & PREFIX_REPZ) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
-        }
-        break;
-    case 0x9b: /* fwait */
-        if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) ==
-            (HF_MP_MASK | HF_TS_MASK)) {
-            gen_exception(s, EXCP07_PREX);
-        } else {
-            /* needs to be treated as I/O because of ferr_irq */
-            translator_io_start(&s->base);
-            gen_helper_fwait(tcg_env);
-        }
-        break;
-    case 0xcc: /* int3 */
-        gen_interrupt(s, EXCP03_INT3);
-        break;
-    case 0xcd: /* int N */
-        val = x86_ldub_code(env, s);
-        if (check_vm86_iopl(s)) {
-            gen_interrupt(s, val);
-        }
-        break;
-    case 0xce: /* into */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_update_cc_op(s);
-        gen_update_eip_cur(s);
-        gen_helper_into(tcg_env, cur_insn_len_i32(s));
-        break;
-#ifdef WANT_ICEBP
-    case 0xf1: /* icebp (undocumented, exits to external debugger) */
-        gen_svm_check_intercept(s, SVM_EXIT_ICEBP);
-        gen_debug(s);
-        break;
-#endif
-    case 0xfa: /* cli */
-        if (check_iopl(s)) {
-            gen_reset_eflags(s, IF_MASK);
-        }
-        break;
-    case 0xfb: /* sti */
-        if (check_iopl(s)) {
-            gen_set_eflags(s, IF_MASK);
-            /* interruptions are enabled only the first insn after sti */
-            gen_update_eip_next(s);
-            gen_eob_inhibit_irq(s);
-        }
-        break;
-    case 0x62: /* bound */
-        if (CODE64(s))
-            goto illegal_op;
-        ot = dflag;
-        modrm = x86_ldub_code(env, s);
-        reg = (modrm >> 3) & 7;
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        gen_op_mov_v_reg(s, ot, s->T0, reg);
-        gen_lea_modrm(env, s, modrm);
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        if (ot == MO_16) {
-            gen_helper_boundw(tcg_env, s->A0, s->tmp2_i32);
-        } else {
-            gen_helper_boundl(tcg_env, s->A0, s->tmp2_i32);
-        }
-        break;
-    case 0x1c8 ... 0x1cf: /* bswap reg */
-        reg = (b & 7) | REX_B(s);
-#ifdef TARGET_X86_64
-        if (dflag == MO_64) {
-            tcg_gen_bswap64_i64(cpu_regs[reg], cpu_regs[reg]);
-            break;
-        }
-#endif
-        tcg_gen_bswap32_tl(cpu_regs[reg], cpu_regs[reg], TCG_BSWAP_OZ);
-        break;
-    case 0xd6: /* salc */
-        if (CODE64(s))
-            goto illegal_op;
-        gen_compute_eflags_c(s, s->T0);
-        tcg_gen_neg_tl(s->T0, s->T0);
-        gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
-        break;
-    case 0xe0: /* loopnz */
-    case 0xe1: /* loopz */
-    case 0xe2: /* loop */
-    case 0xe3: /* jecxz */
-        {
-            TCGLabel *l1, *l2;
-            int diff = (int8_t)insn_get(env, s, MO_8);
-
-            l1 = gen_new_label();
-            l2 = gen_new_label();
-            gen_update_cc_op(s);
-            b &= 3;
-            switch(b) {
-            case 0: /* loopnz */
-            case 1: /* loopz */
-                gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-                gen_op_jz_ecx(s, l2);
-                gen_jcc1(s, (JCC_Z << 1) | (b ^ 1), l1);
-                break;
-            case 2: /* loop */
-                gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-                gen_op_jnz_ecx(s, l1);
-                break;
-            default:
-            case 3: /* jcxz */
-                gen_op_jz_ecx(s, l1);
-                break;
-            }
-
-            gen_set_label(l2);
-            gen_jmp_rel_csize(s, 0, 1);
-
-            gen_set_label(l1);
-            gen_jmp_rel(s, dflag, diff, 0);
-        }
-        break;
     case 0x130: /* wrmsr */
     case 0x132: /* rdmsr */
         if (check_cpl0(s)) {
@@ -5815,14 +3742,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_update_eip_cur(s);
         gen_helper_cpuid(tcg_env);
         break;
-    case 0xf4: /* hlt */
-        if (check_cpl0(s)) {
-            gen_update_cc_op(s);
-            gen_update_eip_cur(s);
-            gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
-        }
-        break;
     case 0x100:
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
@@ -6227,72 +4146,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             /* nothing to do */
         }
         break;
-    case 0x63: /* arpl or movslS (x86_64) */
-#ifdef TARGET_X86_64
-        if (CODE64(s)) {
-            int d_ot;
-            /* d_ot is the size of destination */
-            d_ot = dflag;
-
-            modrm = x86_ldub_code(env, s);
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            mod = (modrm >> 6) & 3;
-            rm = (modrm & 7) | REX_B(s);
-
-            if (mod == 3) {
-                gen_op_mov_v_reg(s, MO_32, s->T0, rm);
-                /* sign extend */
-                if (d_ot == MO_64) {
-                    tcg_gen_ext32s_tl(s->T0, s->T0);
-                }
-                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
-            } else {
-                gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, MO_32 | MO_SIGN, s->T0, s->A0);
-                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
-            }
-        } else
-#endif
-        {
-            TCGLabel *label1;
-            TCGv t0, t1, t2;
-
-            if (!PE(s) || VM86(s))
-                goto illegal_op;
-            t0 = tcg_temp_new();
-            t1 = tcg_temp_new();
-            t2 = tcg_temp_new();
-            ot = MO_16;
-            modrm = x86_ldub_code(env, s);
-            reg = (modrm >> 3) & 7;
-            mod = (modrm >> 6) & 3;
-            rm = modrm & 7;
-            if (mod != 3) {
-                gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, ot, t0, s->A0);
-            } else {
-                gen_op_mov_v_reg(s, ot, t0, rm);
-            }
-            gen_op_mov_v_reg(s, ot, t1, reg);
-            tcg_gen_andi_tl(s->tmp0, t0, 3);
-            tcg_gen_andi_tl(t1, t1, 3);
-            tcg_gen_movi_tl(t2, 0);
-            label1 = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GE, s->tmp0, t1, label1);
-            tcg_gen_andi_tl(t0, t0, ~3);
-            tcg_gen_or_tl(t0, t0, t1);
-            tcg_gen_movi_tl(t2, CC_Z);
-            gen_set_label(label1);
-            if (mod != 3) {
-                gen_op_st_v(s, ot, t0, s->A0);
-           } else {
-                gen_op_mov_reg_v(s, ot, rm, t0);
-            }
-            gen_compute_eflags(s);
-            tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_Z);
-            tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, t2);
-        }
-        break;
     case 0x102: /* lar */
     case 0x103: /* lsl */
         {
@@ -6619,18 +4472,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     /* MMX/3DNow!/SSE/SSE2/SSE3/SSSE3/SSE4 support */
-    case 0x1c3: /* MOVNTI reg, mem */
-        if (!(s->cpuid_features & CPUID_SSE2))
-            goto illegal_op;
-        ot = mo_64_32(dflag);
-        modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        if (mod == 3)
-            goto illegal_op;
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        /* generate a generic store */
-        gen_ldst_modrm(env, s, modrm, ot, reg, 1);
-        break;
     case 0x1ae:
         modrm = x86_ldub_code(env, s);
         switch (modrm) {
@@ -6873,13 +4714,19 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
         set_cc_op(s, CC_OP_POPCNT);
         break;
+    case 0     ... 0xd7:
+    case 0xe0  ... 0xff:
     case 0x10e ... 0x117:
     case 0x128 ... 0x12f:
-    case 0x138 ... 0x13f:
-    case 0x150 ... 0x17f:
-    case 0x1c2:
-    case 0x1c4 ... 0x1c6:
-    case 0x1d0 ... 0x1fe:
+    case 0x138 ... 0x19f:
+    case 0x1a0 ... 0x1a1:
+    case 0x1a8 ... 0x1a9:
+    case 0x1af:
+    case 0x1b2:
+    case 0x1b4 ... 0x1b7:
+    case 0x1be ... 0x1bf:
+    case 0x1c2 ... 0x1c6:
+    case 0x1c8 ... 0x1ff:
         disas_insn_new(s, cpu, b);
         break;
     default:
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f9a966943fb..dabc987b998 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2227,9 +2227,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     X86DecodeFunc decode_func = decode_root;
     uint8_t cc_live;
 
-#ifdef CONFIG_USER_ONLY
-    if (limit) { --limit; }
-#endif
     s->has_modrm = false;
 
  next_byte:
-- 
2.45.0


