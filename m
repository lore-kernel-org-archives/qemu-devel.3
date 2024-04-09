Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA53C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEae-00010L-HH; Tue, 09 Apr 2024 12:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEa0-0000aI-Gb
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZk-00084a-Oi
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjS8qjTg1SFA8JebWO9k+5blG86QrHCQn7ISVPzjrfQ=;
 b=ejq1ScHnh+XXVpcYihUSkudosJIop6Z8GouncfmCqH8PLMBdL9DhAlG5AIrXaobCWfnfmV
 zs2v5QPQNyNI05a0O+Gil/El5i5k/LfOsZ4vltNqIsDZOAaQnMTn/ZOrY9ly2vGRZ+kK3/
 0t0pA72+m6MsGlUtTQGZBQnY7JnD6sc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-wI5NRHjCPcartw_V7JAIsw-1; Tue, 09 Apr 2024 12:43:55 -0400
X-MC-Unique: wI5NRHjCPcartw_V7JAIsw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41663448bcbso12539265e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681034; x=1713285834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjS8qjTg1SFA8JebWO9k+5blG86QrHCQn7ISVPzjrfQ=;
 b=wBIlsiUj513ka8fcggc/0Z68zi5RPg1dEtvGlkIKZQ6CC27Vy4GJk38dShmqPkL1HO
 gRJbXYTGiTr98C+rxaeZ+YHfwY14gvFK4LPD3iN0fPJpDhMaH64ptlRt5u3RY9LrPgZU
 TzWqscSLG/awqJI7Uc5aJbSBqFAVnVtpnf2TWOGhBg1i8y4YbrFKEE+W4bt03SrxkE3S
 rDn646mqnr/qwYCDjH+xF4zPJhsZiTaFG5Nj4Cc5da7JMb5U5UiW1V8wqOMggxnwyJyZ
 akVkoRXQHYZ/zWtm4fABVv/aw7Yrb7yVn9YvsqumrB+CC3vreTQiihQDu1H+5MX0DwJa
 VDcQ==
X-Gm-Message-State: AOJu0YzBu4WqItNopIDVgS4y+YpRhq9KG2X3e83lAUoGrslqu4GnkYBt
 L6tohZafity8dfDpTgl3zsYEkkPRWaJ7VUDj5wINCBor+YvRKafPzL2TbdFrgyPuftatPjI7a1e
 4Sggusa1tgMlfyRSS4k/45TztnR82oFBWTdZiviOAGBz2VUptDAuHbaR13fcDFg9iFe0tPRY458
 sNIc46jhk3qbflHHwIg3K24lsrvAznB1N6gHBN
X-Received: by 2002:a05:6000:87:b0:343:cee1:cbc1 with SMTP id
 m7-20020a056000008700b00343cee1cbc1mr2705213wrx.14.1712681034192; 
 Tue, 09 Apr 2024 09:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBySulLEbKVZJFGsqWOcd5VtL2Wg/I9GYyHOW+XR719uOvbAY1BKqgE8VAHQ1lXHPfscknJg==
X-Received: by 2002:a05:6000:87:b0:343:cee1:cbc1 with SMTP id
 m7-20020a056000008700b00343cee1cbc1mr2705191wrx.14.1712681033838; 
 Tue, 09 Apr 2024 09:43:53 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 bi17-20020a05600c3d9100b00416bf7b68f6sm535735wmb.31.2024.04.09.09.43.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 10/19] target/i386: generalize gen_movl_seg_T0
Date: Tue,  9 Apr 2024 18:43:14 +0200
Message-ID: <20240409164323.776660-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index de1ccb6ea7f..8a34e50c452 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2531,12 +2531,12 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
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
@@ -2548,7 +2548,7 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-        gen_op_movl_seg_real(s, seg_reg, s->T0);
+        gen_op_movl_seg_real(s, seg_reg, src);
         if (seg_reg == R_SS) {
             s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
         }
@@ -4086,13 +4086,13 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
 
@@ -4139,7 +4139,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (reg >= 6 || reg == R_CS)
             goto illegal_op;
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-        gen_movl_seg_T0(s, reg);
+        gen_movl_seg(s, reg, s->T0);
         break;
     case 0x8c: /* mov Gv, seg */
         modrm = x86_ldub_code(env, s);
@@ -4325,7 +4325,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_add_A0_im(s, 1 << ot);
         /* load the segment first to handle exceptions properly */
         gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        gen_movl_seg_T0(s, op);
+        gen_movl_seg(s, op, s->T0);
         /* then put the data */
         gen_op_mov_reg_v(s, ot, reg, s->T1);
         break;
-- 
2.44.0


