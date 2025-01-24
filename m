Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F85C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFg-0006sx-Q9; Fri, 24 Jan 2025 04:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFc-0006mQ-56
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFZ-0003sL-O3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPRuMrkGlDgncK8Zo+Qb0JgJSO2g2QdNllQujRRkgEk=;
 b=H4QsG8jmEvvPd4g+hcoH/6s6r1e92+0YC/SEDAbqea7JtP1Dyhs/Nr5ymhs7Pc8PiWaU+q
 VPOVh5+unGuXJdG+M2wiT6Nfe5IiORFgKn4FaG6/lY+oQP/nCLA3DFho1B83chU9X/+bcf
 cmwY5T2yH4HyS0CSkvG1P0wem3YBkDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-0aUkPbSBMYmpXgIfXUVWYQ-1; Fri, 24 Jan 2025 04:45:11 -0500
X-MC-Unique: 0aUkPbSBMYmpXgIfXUVWYQ-1
X-Mimecast-MFC-AGG-ID: 0aUkPbSBMYmpXgIfXUVWYQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso8761435e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711910; x=1738316710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPRuMrkGlDgncK8Zo+Qb0JgJSO2g2QdNllQujRRkgEk=;
 b=ZrKc7xZF9C2wUUYCaFK9KsyA8GVXrNn3SbSphkg69v/K0hSiZZlWk+t5nmVAW7COfH
 GF6DZCCZFGM1qZ0xO+wZPfBZJ6wJFlMl3UIANS/PTzUm8Hc4gNAmb5qMyUNgOr40fIJ9
 Emsg2ZUKzuFAXJEZ0zi5B69u4lprKsfk71aY3YpgNMQVASg8mfIefGqp/nrxnqRSHX48
 tWatW07wgKufGCHo2MTQPAMjzNmURd1BNBudweJwb1VGn3hdlR9DyhhP+AEUipvwNGm9
 MfYjZiOXZc4yfYcNFUUejVXrHqrsXsd4f4rsczgvL3UlaMzwiXkfxrsIxU0wPWe+oVO9
 t0AQ==
X-Gm-Message-State: AOJu0Yw4nUMr76ulkq9kD1erfIvnf001Yuk8X+DmslodpRAs9Ifo+nuw
 2iscsV5mW/kWGF1Y6GNRGkSFLJpxrlqhB5dzBfFH3wf2sqwL6iB5vJ0EfuHhIJ8CHHA2iCi8F61
 lQ2D4OoCO+hbHYAO3J6qc/555Brv7JDXRCznzDSh0ZM2vCyae55LeLqD7Wqwi6Grab8TxNWI2wW
 ZjjxlIQdxDiplH0pseNuo34Gcd9ePv9zg5plR2e68=
X-Gm-Gg: ASbGncvFpeAMsIJqmq2N/I4r0zDyZaRnuzCP5yShjbFs8HTLbM32pJvgKU1XPwK6sf8
 8/QP4mCWJ1R7rt+hTIopwhFrMDLHFgDlzG77Va/98OQKrpgGs3i8wVK4YOUmFRB9MszBpyK86Fp
 dDVRCLuOFtlfRs0/3ZWMbYncForJEO4Wtc9XcXScV77cTC4kR9S3Nw9j7wj9eFKknAp2Ow+NKpB
 GtryHrPV30I+Si2lfBKDZVL7ADkOr6eTrqhDfoxLSfRO9OmMIM7Xkwm1uPaGivQjSu68HXgBA==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-438913dfd7fmr325619345e9.14.1737711909839; 
 Fri, 24 Jan 2025 01:45:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi9Cyr1qmaKtAihszP392he3yXXCQY7XJ93fRJh7fTl5lMWt48R04G6vatoXJ3oQQyNzz+xg==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-438913dfd7fmr325619025e9.14.1737711909319; 
 Fri, 24 Jan 2025 01:45:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa46esm20449995e9.1.2025.01.24.01.45.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/48] target/i386: pull computation of string update value out
 of loop
Date: Fri, 24 Jan 2025 10:44:07 +0100
Message-ID: <20250124094442.13207-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is a common operation that is executed many times in rep
movs or rep stos loops.  It can improve performance by several
percentage points.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241215090613.89588-13-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 54 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 991baf5d829..9f4d3ebbd95 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -832,16 +832,13 @@ static bool gen_check_io(DisasContext *s, MemOp ot, TCGv_i32 port,
 #endif
 }
 
-static void gen_movs(DisasContext *s, MemOp ot)
+static void gen_movs(DisasContext *s, MemOp ot, TCGv dshift)
 {
-    TCGv dshift;
-
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
 
-    dshift = gen_compute_Dshift(s, ot);
     gen_op_add_reg(s, s->aflag, R_ESI, dshift);
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
@@ -1246,22 +1243,22 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
     }
 }
 
-static void gen_stos(DisasContext *s, MemOp ot)
+static void gen_stos(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_lods(DisasContext *s, MemOp ot)
+static void gen_lods(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
-    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
 }
 
-static void gen_scas(DisasContext *s, MemOp ot)
+static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
@@ -1270,13 +1267,11 @@ static void gen_scas(DisasContext *s, MemOp ot)
     tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
     set_cc_op(s, CC_OP_SUBB + ot);
 
-    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_cmps(DisasContext *s, MemOp ot)
+static void gen_cmps(DisasContext *s, MemOp ot, TCGv dshift)
 {
-    TCGv dshift;
-
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
@@ -1286,7 +1281,6 @@ static void gen_cmps(DisasContext *s, MemOp ot)
     tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
     set_cc_op(s, CC_OP_SUBB + ot);
 
-    dshift = gen_compute_Dshift(s, ot);
     gen_op_add_reg(s, s->aflag, R_ESI, dshift);
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
@@ -1305,7 +1299,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
     }
 }
 
-static void gen_ins(DisasContext *s, MemOp ot)
+static void gen_ins(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_EDI(s);
     /* Note: we must do this dummy write first to be restartable in
@@ -1316,11 +1310,11 @@ static void gen_ins(DisasContext *s, MemOp ot)
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     gen_helper_in_func(ot, s->T0, s->tmp2_i32);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
-static void gen_outs(DisasContext *s, MemOp ot)
+static void gen_outs(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
@@ -1329,14 +1323,14 @@ static void gen_outs(DisasContext *s, MemOp ot)
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T0);
     gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
-    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
 #define REP_MAX 65535
 
-static void do_gen_rep(DisasContext *s, MemOp ot,
-                       void (*fn)(DisasContext *s, MemOp ot),
+static void do_gen_rep(DisasContext *s, MemOp ot, TCGv dshift,
+                       void (*fn)(DisasContext *s, MemOp ot, TCGv dshift),
                        bool is_repz_nz)
 {
     TCGLabel *last = gen_new_label();
@@ -1401,7 +1395,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     }
 
     gen_set_label(loop);
-    fn(s, ot);
+    fn(s, ot, dshift);
     tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
     gen_update_cc_op(s);
 
@@ -1438,7 +1432,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
          */
         gen_set_label(last);
         set_cc_op(s, CC_OP_DYNAMIC);
-        fn(s, ot);
+        fn(s, ot, dshift);
         tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
         gen_update_cc_op(s);
     }
@@ -1453,23 +1447,27 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
 }
 
 static void gen_repz(DisasContext *s, MemOp ot,
-                     void (*fn)(DisasContext *s, MemOp ot))
+                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
 
 {
+    TCGv dshift = gen_compute_Dshift(s, ot);
+
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, fn, false);
+        do_gen_rep(s, ot, dshift, fn, false);
     } else {
-        fn(s, ot);
+        fn(s, ot, dshift);
     }
 }
 
 static void gen_repz_nz(DisasContext *s, MemOp ot,
-                        void (*fn)(DisasContext *s, MemOp ot))
+                        void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
 {
+    TCGv dshift = gen_compute_Dshift(s, ot);
+
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, fn, true);
+        do_gen_rep(s, ot, dshift, fn, true);
     } else {
-        fn(s, ot);
+        fn(s, ot, dshift);
     }
 }
 
-- 
2.48.1


