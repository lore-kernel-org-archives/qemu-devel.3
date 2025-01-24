Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC77C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFJ-0006RM-Ft; Fri, 24 Jan 2025 04:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFF-0006Hz-Ey
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFC-0003e0-Ms
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWJ9yLcmbAXDT1ZuvmB0daQxa504eigEeoJOBFz9rfk=;
 b=VtFF8JyRj3W+0QlUtL0Zc5Dcz2aWKJII2pe+iQ3nThZqtuiAbEubMGGviFTd4Tc7+A1HcA
 W04m5AAUSJ07ZxrJoVOsh4JfMr4/lh4WfYgYL8dHmAACBbRtJod+IO9ImhtVm9xPyjtJ3N
 XJu8X9a6BaCNnMSQLJakBqB3qppyTEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-pKrj1jNrPLmWwzO96HP1OQ-1; Fri, 24 Jan 2025 04:44:51 -0500
X-MC-Unique: pKrj1jNrPLmWwzO96HP1OQ-1
X-Mimecast-MFC-AGG-ID: pKrj1jNrPLmWwzO96HP1OQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-386333ea577so722390f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711890; x=1738316690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWJ9yLcmbAXDT1ZuvmB0daQxa504eigEeoJOBFz9rfk=;
 b=hpUu2RwL4856J+F2JbWJHbMw44BjtVs03cFjPK3PTj/b8iSOZfhDAoOpB7Z0qwbiSM
 X6VwUIxwXi1sBOHiXbocoLZh9/Ms5ltLoaZLwxkaR5TATXe7kro7/2adM6K+24NUn3ce
 pSYvCNibtpEmjxgP1U3erVC7o4eh6gZy8DcPOJMcO4jeq+56VflDCXk9lzFqekaHhkcs
 RiYcv8n16BWlcBd7SGImpronOQza6j/XB7setIYobTU/hFtzBGY/vZ9Rh8+x6UpHzDRl
 fxM5jQGBelKAXQ4C0nbMCl5Hk6unuXls19B2i13I1aknhNbxoG3mFixBhkQUE3tJDK5V
 RFzg==
X-Gm-Message-State: AOJu0Yzzav2YTzQGmEe7osUU9PUIiJpb2DTLzxNNzc8rU+kabbRWX7k3
 SR1LRd3Jo6AEiKNFZz7D5Z9+LbGr/A2LNG4vG3oMGXftGXtaLd3PGZ1mOnzucozSaGmhEBJ4yp9
 Fx9M+6D5XzKLk/WVLrsoB3OmczRFtD//BJyWRF9kUE8tocMt3AXTgqAw+Zx/0LZ1KGc1zo1PROx
 bXPi8TmcuIg4g5/LeUrnmB/SpfPnljvobZiXJKUOE=
X-Gm-Gg: ASbGncupeUZV60T1UI6MrISuMtIatpSljnOc1uOJovFaBk5tbFtgD3iRraCiexCbTFk
 IfX985aICkOP+5DJxTHC2hbuGvktr+R7kA1KIqWR+6J1906Ab7xn5iaibbM7zSI0rLRcYRriEAF
 FDxfI64LTTgTloY4gENXsENmf4i1OpS2XJK5J4FwCyqnzo12ZUA1op12oxwx/wrvPaFpJSCeyPH
 9VwoDvau1d767FVoArUFqagopflRWrlvM0VWg1xng2re3vjKedTs5kwnmjfXNP4KAVqxbFV7g==
X-Received: by 2002:a05:6000:2ce:b0:38a:a117:3da1 with SMTP id
 ffacd0b85a97d-38bf566e683mr24833490f8f.5.1737711890282; 
 Fri, 24 Jan 2025 01:44:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH84xk42pimvTZVM6ee2tspeDvSBNHEYDaH+wi6dI33mYl2BG1cf15cQxl/wRb1Q+GKJLSXBg==
X-Received: by 2002:a05:6000:2ce:b0:38a:a117:3da1 with SMTP id
 ffacd0b85a97d-38bf566e683mr24833456f8f.5.1737711889740; 
 Fri, 24 Jan 2025 01:44:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd43cdbbsm21063845e9.0.2025.01.24.01.44.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/48] target/i386: remove trailing 1 from gen_{j, cmov, set}cc1
Date: Fri, 24 Jan 2025 10:43:57 +0100
Message-ID: <20250124094442.13207-4-pbonzini@redhat.com>
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

This is not needed anymore now that gen_jcc has been eliminated
(merged into the similarly-named gen_Jcc, where the uppercase letter
gives away that it is an emission function).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-3-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 14 +++++++-------
 target/i386/tcg/emit.c.inc  | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3b68441a561..a2101b5615e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1148,7 +1148,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     return cc;
 }
 
-static void gen_setcc1(DisasContext *s, int b, TCGv reg)
+static void gen_setcc(DisasContext *s, int b, TCGv reg)
 {
     CCPrepare cc = gen_prepare_cc(s, b, reg);
 
@@ -1170,12 +1170,12 @@ static void gen_setcc1(DisasContext *s, int b, TCGv reg)
 
 static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
 {
-    gen_setcc1(s, JCC_B << 1, reg);
+    gen_setcc(s, JCC_B << 1, reg);
 }
 
 /* generate a conditional jump to label 'l1' according to jump opcode
    value 'b'. In the fast case, T0 is guaranteed not to be used. */
-static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
+static inline void gen_jcc_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
@@ -1190,7 +1190,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
    value 'b'. In the fast case, T0 is guaranteed not to be used.
    One or both of the branches will call gen_jmp_rel, so ensure
    cc_op is clean.  */
-static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
+static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
@@ -1337,7 +1337,7 @@ static void gen_repz_nz(DisasContext *s, MemOp ot,
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-    gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);
+    gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
     if (s->repz_opt) {
         gen_op_jz_ecx(s, l2);
     }
@@ -1847,7 +1847,7 @@ static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
+static void gen_cmovcc(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
@@ -2856,7 +2856,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 }
                 op1 = fcmov_cc[op & 3] | (((op >> 3) & 1) ^ 1);
                 l1 = gen_new_label();
-                gen_jcc1_noeob(s, op1, l1);
+                gen_jcc_noeob(s, op1, l1);
                 gen_helper_fmov_ST0_STN(tcg_env,
                                         tcg_constant_i32(opreg));
                 gen_set_label(l1);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a193d32ca76..861f0fb70f3 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1634,7 +1634,7 @@ static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_cmovcc1(s, decode->b & 0xf, s->T0, s->T1);
+    gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
 }
 
 static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
@@ -2300,7 +2300,7 @@ static void gen_Jcc(DisasContext *s, X86DecodedInsn *decode)
     TCGLabel *taken = gen_new_label();
 
     gen_bnd_jmp(s);
-    gen_jcc1(s, decode->b & 0xf, taken);
+    gen_jcc(s, decode->b & 0xf, taken);
     gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
 }
 
@@ -2451,7 +2451,7 @@ static void gen_LOOPE(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
     gen_op_jz_ecx(s, not_taken);
-    gen_jcc1(s, (JCC_Z << 1), taken); /* jz taken */
+    gen_jcc(s, (JCC_Z << 1), taken); /* jz taken */
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
@@ -2463,7 +2463,7 @@ static void gen_LOOPNE(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
     gen_op_jz_ecx(s, not_taken);
-    gen_jcc1(s, (JCC_Z << 1) | 1, taken); /* jnz taken */
+    gen_jcc(s, (JCC_Z << 1) | 1, taken); /* jnz taken */
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
@@ -3888,7 +3888,7 @@ static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_setcc1(s, decode->b & 0xf, s->T0);
+    gen_setcc(s, decode->b & 0xf, s->T0);
 }
 
 static void gen_SFENCE(DisasContext *s, X86DecodedInsn *decode)
-- 
2.48.1


