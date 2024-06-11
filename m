Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA474C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S7-0007y4-Q6; Tue, 11 Jun 2024 10:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S6-0007tr-Ex
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S4-0006Bg-IB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM+2F+hx2KQCEz/PaZSH6JF18fi1CDq4iiNZACN4mQA=;
 b=PY7vKQhho3WgtRePm0dr7erS+/XnwprE2pY3UijKmZDlXFr5lEE/ruuyFuCrZxck94oih0
 yDmlgJrZ0r4CE5scg9ObesXiqQHB+y7qV0gZuBRxIcKz27QyZtUHMfHS7rybqE7aMOljCe
 5AbFaeElYo2P6roz4oRpZBKiaTnnsoE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-pXl3cdAlP6uMmC9wL2OhQg-1; Tue, 11 Jun 2024 10:26:18 -0400
X-MC-Unique: pXl3cdAlP6uMmC9wL2OhQg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57ca45d7664so42910a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115976; x=1718720776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM+2F+hx2KQCEz/PaZSH6JF18fi1CDq4iiNZACN4mQA=;
 b=Q6y5B3ak+ZhDwRUIt4YbnCvwYj0tOk35rzqQjCiUS8U/o53kiYQo9t/ZkBb3zz0Fan
 CWKSWn0NI2BdifV6JMT3YLnFUCqoh4qH7R4z47lxlcXfiC59ZZhgjv/7g3uIBAQ2CVHn
 dBKO6IogWb+URAXARwaAOiuEvab3/lM4Yc1kUpym6ArY2PS9tAx72AMMKQNYy+szAGYi
 VV8xV8NIv+h2TVKd/f+Vhhn1Kxt39c78+BOgmF65wCn2D25PZtC2Ao6HwxbBqCgHSDRf
 Sn+Psip5HyuNs6sCoZDbAZqN3za3kinE2+oYjiOg5aLxPPNs4KUHX/9uJGohw7VsSZIK
 kauw==
X-Gm-Message-State: AOJu0YymW7TrfIBzPEoxcHkAC15yP875u/Kiu8Ya7yzbK4HLkpBx7iCf
 saUkYDhscGzk0H4n4hIexeqYsrKwMOXDU5889QSN0AjE4ILLg8v0w739BiBAKVJ9OOGAbGk2d7y
 4mBbJ6fjuoVikgt6DeK0KCbVf5d4ZlFs1y6ldAu7IrwtXc81U4hFGycxWUAmuhmmumLcFGirCoD
 BsfHtu8jAyh7wW+OSyP1kU9WkqutJo9AcOhAJ+
X-Received: by 2002:a50:d51c:0:b0:57c:7653:7386 with SMTP id
 4fb4d7f45d1cf-57c76537481mr5111329a12.13.1718115976327; 
 Tue, 11 Jun 2024 07:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2nqnefGUi5VtpTkasGAJTMKtzxXV6+BZZ7jGFznM+R1D4HM2u9sp/NGW9YMd5YQOqg8CWSA==
X-Received: by 2002:a50:d51c:0:b0:57c:7653:7386 with SMTP id
 4fb4d7f45d1cf-57c76537481mr5111313a12.13.1718115975909; 
 Tue, 11 Jun 2024 07:26:15 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57ca4527bd6sm183711a12.22.2024.06.11.07.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/25] target/i386: convert XADD to new decoder
Date: Tue, 11 Jun 2024 16:25:21 +0200
Message-ID: <20240611142524.83762-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 35 --------------------------------
 target/i386/tcg/decode-new.c.inc |  3 ++-
 target/i386/tcg/emit.c.inc       | 24 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 68a11f81786..5d9312bb48c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -823,12 +823,6 @@ static void gen_movs(DisasContext *s, MemOp ot)
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_op_update2_cc(DisasContext *s)
-{
-    tcg_gen_mov_tl(cpu_cc_src, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-}
-
 /* compute all eflags to reg */
 static void gen_mov_eflags(DisasContext *s, TCGv reg)
 {
@@ -3011,35 +3005,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     switch (b) {
         /**************************/
         /* arith & logic */
-    case 0x1c0:
-    case 0x1c1: /* xadd Ev, Gv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        mod = (modrm >> 6) & 3;
-        gen_op_mov_v_reg(s, ot, s->T0, reg);
-        if (mod == 3) {
-            rm = (modrm & 7) | REX_B(s);
-            gen_op_mov_v_reg(s, ot, s->T1, rm);
-            tcg_gen_add_tl(s->T0, s->T0, s->T1);
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-        } else {
-            gen_lea_modrm(env, s, modrm);
-            if (s->prefix & PREFIX_LOCK) {
-                tcg_gen_atomic_fetch_add_tl(s->T1, s->A0, s->T0,
-                                            s->mem_index, ot | MO_LE);
-                tcg_gen_add_tl(s->T0, s->T0, s->T1);
-            } else {
-                gen_op_ld_v(s, ot, s->T1, s->A0);
-                tcg_gen_add_tl(s->T0, s->T0, s->T1);
-                gen_op_st_v(s, ot, s->T0, s->A0);
-            }
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-        }
-        gen_op_update2_cc(s);
-        set_cc_op(s, CC_OP_ADDB + ot);
-        break;
     case 0x1b0:
     case 0x1b1: /* cmpxchg Ev, Gv */
         {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 15ebc1233ea..008a8387bda 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1167,6 +1167,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
     [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
 
+    [0xc0] = X86_OP_ENTRY2(XADD,       E,b, G,b,            lock),
+    [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
     [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
@@ -2590,7 +2592,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xb3:          /* btr */
             case 0xba ... 0xbb: /* grp8, btc */
-            case 0xc0 ... 0xc1: /* xadd */
             case 0xc7:          /* grp9 */
                 disas_insn_old(s, cpu, b + 0x100);
                 return;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 7f554ba1173..9c8fe14e286 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4368,6 +4368,30 @@ static void gen_WRxxBASE(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_mov_tl(base, s->T0);
 }
 
+static void gen_XADD(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    decode->cc_dst = tcg_temp_new();
+    decode->cc_src = s->T1;
+    decode->cc_op = CC_OP_ADDB + ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_fetch_add_tl(s->T0, s->A0, s->T1, s->mem_index, ot | MO_LE);
+        tcg_gen_add_tl(decode->cc_dst, s->T0, s->T1);
+    } else {
+        tcg_gen_add_tl(decode->cc_dst, s->T0, s->T1);
+        /*
+         * NOTE: writing memory first is important for MMU exceptions,
+         * but "new result" wins for XADD AX, AX.
+         */
+        gen_writeback(s, decode, 0, decode->cc_dst);
+    }
+    if (decode->op[0].has_ea || decode->op[2].n != decode->op[0].n) {
+        gen_writeback(s, decode, 2, s->T0);
+    }
+}
+
 static void gen_XCHG(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->prefix & PREFIX_LOCK) {
-- 
2.45.1


