Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F310C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfZ-00038A-8F; Sat, 25 May 2024 07:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfX-0002ye-9y
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfV-00049p-LC
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6zwylRhfgSaIYxfMePasb6a88uh2JdmZkISP91K2CU=;
 b=MUodaaAGfzM00Yk5DUL+/cSLPYxjZ3lgYsX1/ap4LaeyCMbltVDa97lGyn/0HAaXAaNPvw
 nzZVlgR02D4f8LZI/eqPnoa3s14H9BahN3ykM/J9srv9XWGMxYDYBZ4Buq+WAG/S7khkg5
 sTAKToIQT1KbeUwl59TA+JXFuE5pEKI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-vdcIuTWVMNC9g_I1ftdwkA-1; Sat, 25 May 2024 07:34:31 -0400
X-MC-Unique: vdcIuTWVMNC9g_I1ftdwkA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6266ffdb45so87188366b.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636869; x=1717241669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6zwylRhfgSaIYxfMePasb6a88uh2JdmZkISP91K2CU=;
 b=L7ceKXx8F+wRjjRTZ3e/25ADd+JnRx1GwQ4t6cEk0ARKQ4BiudBZ8i4cdklN1puRow
 YQPE9T8ii3KjQ5Ag5Op39LoroZMxzjr4zGSJfJ4Jc27O31XchYmXF/pyTKwX0c77jIb2
 bHq6729e7rqe2Eh2z32g+hVgClITisfvqu1AC15NCOOu3n+6QwEuYU73ue9CaPmUkDVK
 x1E8mZ9dW96XOEeNc228jYqoaR6Q1x5rHhnP6sbJ7lUrDZM5XAgF7o53ROJTlC8QyUg5
 qoUGBJjI3XFAItVdBy4XE4wF4QP3EkmjrEnBOVeYSClOFVgrqBBe21YJiO9fWm5IfJNR
 tm8Q==
X-Gm-Message-State: AOJu0YzL0e8rnMvhNu6xtCuJQKh2j4uxHe/9/ZBdWUYDf/nDH9WxHbz5
 dq2qYAB2Cjjn8oEZHWiwFTHIn/GOVNlDwk6Tb5Uarh/xHjSBZrfniZsO1hdjpLxCw/mxhEES8uc
 7HAWi3qUoxwC07B9Lzh60L6IQKq26HAVjrLMY22N3qyywg2qiCIXUHRxfvs6rvh5o0tz0xhMrS5
 TbJ6jAaJHn2Z5mxRqsq6+n3JAIoK6cWm7dXAsj
X-Received: by 2002:a17:906:c017:b0:a59:9b52:cfc5 with SMTP id
 a640c23a62f3a-a62649bd8f5mr308578466b.37.1716636869453; 
 Sat, 25 May 2024 04:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHupV3Om9XGlYQbAg0u+yLIxxXmycVLArHcH3HXAuYdA393feV0ZjnnLrSqlloNwQ/PjfXE/Q==
X-Received: by 2002:a17:906:c017:b0:a59:9b52:cfc5 with SMTP id
 a640c23a62f3a-a62649bd8f5mr308577466b.37.1716636869103; 
 Sat, 25 May 2024 04:34:29 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda6e1esm243023966b.215.2024.05.25.04.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/24] target/i386: clean up repeated string operations
Date: Sat, 25 May 2024 13:33:26 +0200
Message-ID: <20240525113332.1404158-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 22 ++++------------------
 target/i386/tcg/emit.c.inc  | 22 +++++++++-------------
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 15993f83024..7dd7ebf60d4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1327,14 +1327,12 @@ static void gen_repz(DisasContext *s, MemOp ot,
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
@@ -1350,18 +1348,6 @@ static void gen_repz2(DisasContext *s, MemOp ot, int nz,
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
index 0a13be4989a..377d2201c91 100644
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


