Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4274C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVA-0005lV-Ty; Tue, 07 May 2024 06:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUq-0004wV-Lr
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUp-0002sZ-1Y
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whjY8VJAEdtsmR76AypLSHX3d79fRDrD3PQOTDyVzPM=;
 b=IazbWKT3CWaOj3+I/eXaV4XX5pFsClgkcq0nzAZAOpLXj4jrWdSKnOyA3uNeVqnFfPYtsE
 14ZerS458Ft4so8tWP+8193s135YtqzMe4+ABy+6F9A+xe6lrE1GgL3XT3hIXLGJO5iEoj
 qvEZZO8cnFPNpXCK+9cuqF+EEV+pr6I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-4zAYda5IOqCkZ_tuqdYhWA-1; Tue, 07 May 2024 06:56:28 -0400
X-MC-Unique: 4zAYda5IOqCkZ_tuqdYhWA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so152115766b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079385; x=1715684185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whjY8VJAEdtsmR76AypLSHX3d79fRDrD3PQOTDyVzPM=;
 b=sAiauAjYJXt5Oqo4LJLSwR4mQfH6LMCzi+0WrhZuUlWQutwe86VYicfPjFn+3FNF8d
 lpm14b+7oRFvtr/H8EomKJ73oDnwkVgovw/67T/ncBuGfSOP+ip70rgJZeT27Itewrlv
 8hs6Rf1VlTIVPyzSbyyTkNDM6so3OYyHypv9k+HRMlu8r8BjCkhreIaoTL6IwAdBnQFN
 MAlvGUay07Svp6es3RwbZ9vxpRuvmNDtYEgEL4Wh29vH6xuRTVD/FMiTXjDwbO/D0UE1
 Fk4BiT0fdImXgWD8euZz+KX5zJH0TDH/cj44DCPmPWAIPt7hQEK8yXZOqS1Ai+iq0RFR
 DfqQ==
X-Gm-Message-State: AOJu0YxaE2wXbHhAn3eya/gYA7bSUGhM6KlChxOK37r6tA8kTXjjT3p3
 s9kajy/y9lR226Mf7UuoZ6TvSMoDB+C8bOqM/RmECV3EdwIkUxIdnU8EiMRDlJvoy8lmLOAVUio
 B3QCG38P5G0iZgJQjiha/eLGIrtKSz3WxMGVsysk8ZnMZ/mzDVwAaoPPnXZH822L5e1dcwwiFoF
 I9HFPk/Ipv+Bx5oCDEk1h0VV41VqRsPnZ5UQR+
X-Received: by 2002:a17:907:7203:b0:a59:c31a:91be with SMTP id
 dr3-20020a170907720300b00a59c31a91bemr4509334ejc.16.1715079385440; 
 Tue, 07 May 2024 03:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv4nF9MJ8cq8CJLBvfW3+i89uwld4tG+ri+Dkw+c9vTK/wLGkUHjCcl3PNqy+uhwyeCPd69w==
X-Received: by 2002:a17:907:7203:b0:a59:c31a:91be with SMTP id
 dr3-20020a170907720300b00a59c31a91bemr4509318ejc.16.1715079385078; 
 Tue, 07 May 2024 03:56:25 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a1709067d8600b00a599e65808asm4766222ejo.18.2024.05.07.03.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/26] target/i386: generalize gen_movl_seg_T0
Date: Tue,  7 May 2024 12:55:29 +0200
Message-ID: <20240507105538.180704-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
index 4f47c40fb08..e09bfdaa39b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2525,12 +2525,12 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
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
@@ -2542,7 +2542,7 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-        gen_op_movl_seg_real(s, seg_reg, s->T0);
+        gen_op_movl_seg_real(s, seg_reg, src);
         if (seg_reg == R_SS) {
             s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
         }
@@ -4084,13 +4084,13 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
 
@@ -4137,7 +4137,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (reg >= 6 || reg == R_CS)
             goto illegal_op;
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-        gen_movl_seg_T0(s, reg);
+        gen_movl_seg(s, reg, s->T0);
         break;
     case 0x8c: /* mov Gv, seg */
         modrm = x86_ldub_code(env, s);
@@ -4323,7 +4323,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_add_A0_im(s, 1 << ot);
         /* load the segment first to handle exceptions properly */
         gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        gen_movl_seg_T0(s, op);
+        gen_movl_seg(s, op, s->T0);
         /* then put the data */
         gen_op_mov_reg_v(s, ot, reg, s->T1);
         break;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 5834f8ea0fd..56ce0d2a9f3 100644
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


