Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E68CC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0u-0005Tc-Ok; Fri, 24 May 2024 04:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0t-0005Sa-S1
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0s-0000db-7F
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNB7yIXWrmDB/iISbVm985kavI7s1g592wuWZJrSyvA=;
 b=KIyHtUgYqpqgJpjssLP3PwDbVpvBSvqvCFClk9CYNdTaGC3pp/4HepWNCddmJv/vtXo5ZO
 NUr6ryKhaujQgigPjo7FYMi7JNAyAXkFawhVBNArm7drSlWPlzU9iiJYSdM6zK3UyGR3TR
 308afpgl4J11txSNgRkwWsRUGm9lu8Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-UOdBZUoRM22mVpN8fnNj4w-1; Fri, 24 May 2024 04:10:51 -0400
X-MC-Unique: UOdBZUoRM22mVpN8fnNj4w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6269ad800aso27595166b.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538250; x=1717143050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNB7yIXWrmDB/iISbVm985kavI7s1g592wuWZJrSyvA=;
 b=TMY6228aQtXLp7lb0gOVZq1vblUwrvwcBjvM+MAQ2vyW7hOOFkGH3KCjvdmkVtEQvI
 i6ws84BA728i9ZCqgMK584/sOoy2flbRCnWdlEoenZ8GX+CR7KzBDmdxOMmNkjxHVi9Y
 GTXbHCDKjabPiGAw0KzAsz/NXGm2udE8LZCEIM3IiGL/ayCiSGNLOyHONuoXyRwQd5NK
 Xhn85iLej2u8YZVVjJ6/sAPP+kCkBRxD4N+si1CZ2Z4hKt6IiY11Q6zMXWqEe5AwxzfZ
 WEKDSzPpkTNdUnQ0Uku21Zi22oyaxedVqfdUoeyQVJm/8cgLVwZ/4MQtqt8Hh+6QcXdZ
 gPTA==
X-Gm-Message-State: AOJu0YzB54pxz7qyK8B9x/4B6usjYFivxykMJNV/GtyiqG2zE9bZ5WSu
 blNlRiqcd0nMsFBJHZsW+Yd7kkgJyigWMqpfjpWqybbWebLw9uNsdll03W22O9QvAZC/BtkbDXp
 F2JJmlvsr1Vr3ZIZAAHP53hRcRw9xOCXYmXlEG33o40maFXxT7NExm0aMBC97lta14Pdzb3guhm
 sgjTQPJU4jEQg3l0/yCFIbfIwIjkSPKOdT4FP7
X-Received: by 2002:a17:906:1287:b0:a59:c577:c5c3 with SMTP id
 a640c23a62f3a-a62642e8fe1mr148924366b.29.1716538250008; 
 Fri, 24 May 2024 01:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdmh7MnYoVpwU0QmVSmUfTcwCNf1NZkkhwkdKAMDWXwzenfR+9isccp9puJH80N8gYHca4EA==
X-Received: by 2002:a17:906:1287:b0:a59:c577:c5c3 with SMTP id
 a640c23a62f3a-a62642e8fe1mr148921166b.29.1716538249445; 
 Fri, 24 May 2024 01:10:49 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a627623c38bsm60924066b.23.2024.05.24.01.10.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] target/i386: clean up repeated string operations
Date: Fri, 24 May 2024 10:10:16 +0200
Message-ID: <20240524081019.1141359-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Do not bother generating inline wrappers for gen_repz and gen_repz2;
use s->prefix to separate REPZ from REPNZ in the case of SCAS and
CMPS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 ++++------------------
 target/i386/tcg/emit.c.inc  | 22 +++++++++-------------
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8354209b037..18d8c0de674 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1320,14 +1320,12 @@ static void gen_repz(DisasContext *s, MemOp ot,
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 }
 
-#define GEN_REPZ(op) \
-    static inline void gen_repz_ ## op(DisasContext *s, MemOp ot) \
-    { gen_repz(s, ot, gen_##op); }
-
-static void gen_repz2(DisasContext *s, MemOp ot, int nz,
-                      void (*fn)(DisasContext *s, MemOp ot))
+static void gen_repz_nz(DisasContext *s, MemOp ot,
+                        void (*fn)(DisasContext *s, MemOp ot))
 {
     TCGLabel *l2;
+    int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
+
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
@@ -1343,18 +1341,6 @@ static void gen_repz2(DisasContext *s, MemOp ot, int nz,
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 }
 
-#define GEN_REPZ2(op) \
-    static inline void gen_repz_ ## op(DisasContext *s, MemOp ot, int nz) \
-    { gen_repz2(s, ot, nz, gen_##op); }
-
-GEN_REPZ(movs)
-GEN_REPZ(stos)
-GEN_REPZ(lods)
-GEN_REPZ(ins)
-GEN_REPZ(outs)
-GEN_REPZ2(scas)
-GEN_REPZ2(cmps)
-
 static void gen_helper_fp_arith_ST0_FT0(int op)
 {
     switch (op) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 83fa745fd8a..bc96735f61d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1508,10 +1508,8 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
 static void gen_CMPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & PREFIX_REPNZ) {
-        gen_repz_cmps(s, ot, 1);
-    } else if (s->prefix & PREFIX_REPZ) {
-        gen_repz_cmps(s, ot, 0);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_nz(s, ot, gen_cmps);
     } else {
         gen_cmps(s, ot);
     }
@@ -1834,7 +1832,7 @@ static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     translator_io_start(&s->base);
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_ins(s, ot);
+        gen_repz(s, ot, gen_ins);
     } else {
         gen_ins(s, ot);
     }
@@ -1993,7 +1991,7 @@ static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_lods(s, ot);
+        gen_repz(s, ot, gen_lods);
     } else {
         gen_lods(s, ot);
     }
@@ -2155,7 +2153,7 @@ static void gen_MOVS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_movs(s, ot);
+        gen_repz(s, ot, gen_movs);
     } else {
         gen_movs(s, ot);
     }
@@ -2321,7 +2319,7 @@ static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     translator_io_start(&s->base);
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_outs(s, ot);
+        gen_repz(s, ot, gen_outs);
     } else {
         gen_outs(s, ot);
     }
@@ -3329,10 +3327,8 @@ static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & PREFIX_REPNZ) {
-        gen_repz_scas(s, ot, 1);
-    } else if (s->prefix & PREFIX_REPZ) {
-        gen_repz_scas(s, ot, 0);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_nz(s, ot, gen_scas);
     } else {
         gen_scas(s, ot);
     }
@@ -3495,7 +3491,7 @@ static void gen_STOS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_stos(s, ot);
+        gen_repz(s, ot, gen_stos);
     } else {
         gen_stos(s, ot);
     }
-- 
2.45.1


