Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9039EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tS8-0005Ci-1I; Mon, 06 May 2024 04:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRn-0004wQ-FX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQx-0002P9-Tr
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0Iuu/GgGcNtLR5DmQBSUBrbuciOBPHVA3yxeLir2co=;
 b=htGg9xxeVTDUKCXbFyahYwapf8C2Y7a+GMMQwUD7SDAPIXXro+ZRWa+QTHAhca3osEDMR7
 dEm0ZMAqaclycjhODgyeVPtHP5MU4TQegX6vQuFhl0RzE5XFxcBfcRYlYy/xvFCHtrAAS/
 9EhBMnHsrRK2DYtBQ1TUXJRGyRsccHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Nt2jQ_5fOoyzmgh8XpV6ng-1; Mon, 06 May 2024 04:10:49 -0400
X-MC-Unique: Nt2jQ_5fOoyzmgh8XpV6ng-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a558739aaf4so144503366b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983048; x=1715587848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0Iuu/GgGcNtLR5DmQBSUBrbuciOBPHVA3yxeLir2co=;
 b=LEGaJVVMia+3XE89JlEr7MJgbafdmOBc9Z+TnIJJRV3BDEjT/zkWh2+Oa3XN43sSAQ
 hvRCpvNrPhf1asJ8QBp+H7GkIGezDzBCPZeEl47bz8hpkFchCfcgJJRytKf12lzRRPq7
 +XLrUy5Z4qW7RshOqWaYKZACL/FIBHTzo06EYtgJx62ViVH3YmDzm2i2dbQXGbUHLnFa
 njK8PK5PArHq2ihWtz7PE1yqgGyI+t2YmmmqETsEF0wnFO+RCb3FDclXYnglg8A7wn5P
 PsESIpn9994o19/uOi6k2NdGLtdQmdGFMD8Et2juee12FeAsVWaSkhDmNknGZ2BagGvC
 ioIA==
X-Gm-Message-State: AOJu0YyfAAzQqs3sU3LwYsdlz2Rqe6FlfomhRrCcS414b2gH2GmyRXNq
 fq0k/MlzNht3xJbA6gwQn/DSklvfNmauy/om3OUgM8YWHKg8FrDxICTeVg2V9NlF7tfZ4QcY5vy
 hDEHH4qa/2NFy7acfXGD+iDyu3SIUB4t67abAOLE4dsFy8px/5xtJzoZjKGxO3njCMauB8RUCtD
 3Zm8/z+qzxOqeYOxQwj3ma6vAauCx1XifYY9EQ
X-Received: by 2002:a17:906:a84f:b0:a59:a64d:c5b9 with SMTP id
 dx15-20020a170906a84f00b00a59a64dc5b9mr5126316ejb.76.1714983047983; 
 Mon, 06 May 2024 01:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwnzogsCPKIl5Sc+1Kmi7Qgwe1M6nf3MGRBLnnSOqXbFuEmPpPXCK5+rshL279CLwnKM/V2g==
X-Received: by 2002:a17:906:a84f:b0:a59:a64d:c5b9 with SMTP id
 dx15-20020a170906a84f00b00a59a64dc5b9mr5126295ejb.76.1714983047587; 
 Mon, 06 May 2024 01:10:47 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 dc2-20020a170906c7c200b00a59aaf2f626sm2592243ejb.26.2024.05.06.01.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 16/25] target/i386: generalize gen_movl_seg_T0
Date: Mon,  6 May 2024 10:09:48 +0200
Message-ID: <20240506080957.10005-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

In the new decoder it is sometimes easier to put the segment
in T1 instead of T0, usually because another operand was loaded
by common code in T0.  Genrealize gen_movl_seg_T0 to allow
using any source.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++++--------
 target/i386/tcg/emit.c.inc  |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8f633814586..708fe023224 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2524,12 +2524,12 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
     tcg_gen_shli_tl(cpu_seg_base[seg_reg], selector, 4);
 }
 
-/* move T0 to seg_reg and compute if the CPU state may change. Never
+/* move SRC to seg_reg and compute if the CPU state may change. Never
    call this function with seg_reg == R_CS */
-static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
+static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
 {
     if (PE(s) && !VM86(s)) {
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, src);
         gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), s->tmp2_i32);
         /* abort translation because the addseg value may change or
            because ss32 may change. For R_SS, translation must always
@@ -2541,7 +2541,7 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-        gen_op_movl_seg_real(s, seg_reg, s->T0);
+        gen_op_movl_seg_real(s, seg_reg, src);
         if (seg_reg == R_SS) {
             s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
         }
@@ -4083,13 +4083,13 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
         reg = b >> 3;
         ot = gen_pop_T0(s);
-        gen_movl_seg_T0(s, reg);
+        gen_movl_seg(s, reg, s->T0);
         gen_pop_update(s, ot);
         break;
     case 0x1a1: /* pop fs */
     case 0x1a9: /* pop gs */
         ot = gen_pop_T0(s);
-        gen_movl_seg_T0(s, (b >> 3) & 7);
+        gen_movl_seg(s, (b >> 3) & 7, s->T0);
         gen_pop_update(s, ot);
         break;
 
@@ -4136,7 +4136,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (reg >= 6 || reg == R_CS)
             goto illegal_op;
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-        gen_movl_seg_T0(s, reg);
+        gen_movl_seg(s, reg, s->T0);
         break;
     case 0x8c: /* mov Gv, seg */
         modrm = x86_ldub_code(env, s);
@@ -4322,7 +4322,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_add_A0_im(s, 1 << ot);
         /* load the segment first to handle exceptions properly */
         gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        gen_movl_seg_T0(s, op);
+        gen_movl_seg(s, op, s->T0);
         /* then put the data */
         gen_op_mov_reg_v(s, ot, reg, s->T1);
         break;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c59793f170a..fd2e1db0d2e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -306,8 +306,8 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
     case X86_OP_SKIP:
         break;
     case X86_OP_SEG:
-        /* Note that gen_movl_seg_T0 takes care of interrupt shadow and TF.  */
-        gen_movl_seg_T0(s, op->n);
+        /* Note that gen_movl_seg takes care of interrupt shadow and TF.  */
+        gen_movl_seg(s, op->n, s->T0);
         break;
     case X86_OP_INT:
         if (op->has_ea) {
-- 
2.45.0


