Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B8AC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WcK-0005nQ-UZ; Wed, 23 Apr 2025 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbi-0004No-Ej
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbg-0008LW-J4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WV/33915Cp1lyg6FaM5mC8S9fs4ugxpdjv4iZnTm4I=;
 b=TIqCaixo+TE1CFGMdsEmphCSqASA3uooEgorH4QUPvJ80x5C+Aly1C/vMTQW12V0YnooI4
 r5b1wbysa7rOVMMSsr41cg2g7WzgvIkftoCJN8VU+FVCtpRK/YSrrTbbr/ga/5xYPbePXs
 XhDaOyWOCJm7edVM6KyVOEA5cxlW0qc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-jcqsGevAN12g7XDnooyOHw-1; Wed, 23 Apr 2025 05:41:25 -0400
X-MC-Unique: jcqsGevAN12g7XDnooyOHw-1
X-Mimecast-MFC-AGG-ID: jcqsGevAN12g7XDnooyOHw_1745401285
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac297c7a0c2so391396066b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401284; x=1746006084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WV/33915Cp1lyg6FaM5mC8S9fs4ugxpdjv4iZnTm4I=;
 b=UfkZ/GxrUMx0C17yfT41NjRXZ162GidGeyLcya6pKYsBqRCejZFHNZORn2Us/RrCEV
 GlfIAakgm+knHnxUqh2ToNDjekyyZomHEd1bmuVWDZlKZJRHSGHoywP6EDSGMWxX5hEk
 UZrV8JCL4+p9STMkaIPsGV+05Y0+eN9fv97CWDSKa30VywENCypL2DQ3aIuuPCQaKMqj
 PG5gSBZIoYqc9PzHH8//pShahGeWJcIsFwgW12gJ9AYrXQjBwdsK4EcUMh1yW8eLqbnf
 3WJIZSNvQZCeZ6UTZIWiN6xuVeBLVw7HxMhmUw74xN8mCafc60iY2CGRrKK0ch0z3KRo
 x/oQ==
X-Gm-Message-State: AOJu0YxpIF8badBXwuueUa+TUKptG1piYFmWgdSVwV7ufGhwqTaUXpXI
 M0/vmrqNYcUxX94za5d8uW2RxPQPdGXkgYJkt+ET1KokB8YBJkGKBr9ASQ24b93mSNcH3Qgl7dO
 dZ9qNldstuaH+9AvFAkqw9fyMjtZYU6ErvMPryqS3Mtt6TdI7kIVNj41olLVI6fgi3h2AAAjxys
 la1H/20f5JT2RzS9dv21wjSkEdOkH4i8vsh6nN
X-Gm-Gg: ASbGncv1vJV9k3wXPAQeyiZq/RyjSKHfoTcupCk0gmGpGgS0Jgjng77cOgmdWuBNj06
 mYPOm3ebv9SNOlaCdAXpE60Cs+OkSLDxz+Ae/gB9GfoRpNhOpAFndkd08C88Y5oDE10iwym29Sj
 SNssT50Whl4DQax62bpveUn8sGP6l9oYvxGNMsOTP/CN5QtUTflFZdORr6Cu5BrwR7V+m2GD1iy
 W6JU8it0GkRpwdtWeoqDwCEm5UxpLS0nmTE/30fByPD3rPE5Qzz9Vowxz84qTOMg7gubzEOBrw9
 RQXc/ZK1L5rFzErf
X-Received: by 2002:a17:906:c10f:b0:aca:a3a8:5560 with SMTP id
 a640c23a62f3a-acb74e0ed71mr1351301166b.53.1745401284152; 
 Wed, 23 Apr 2025 02:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAancXXHi3BLmLaPGDNeFfwglnZZKm6QvcvbqYR1nf8TYGUP2VY1roHa8u61j2PwAgCxFFOw==
X-Received: by 2002:a17:906:c10f:b0:aca:a3a8:5560 with SMTP id
 a640c23a62f3a-acb74e0ed71mr1351298666b.53.1745401283633; 
 Wed, 23 Apr 2025 02:41:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6eefcf76sm789606266b.100.2025.04.23.02.41.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/34] target/i386: tcg: remove tmp0
Date: Wed, 23 Apr 2025 11:40:38 +0200
Message-ID: <20250423094105.40692-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 27 +++++++++++++++------------
 target/i386/tcg/emit.c.inc  | 20 ++++++++++----------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 822dbb2e9ae..5d433f8522e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -134,7 +134,6 @@ typedef struct DisasContext {
     TCGv T1;
 
     /* TCG local register indexes (only used inside old micro ops) */
-    TCGv tmp0;
     TCGv_i32 tmp2_i32;
     TCGv_i32 tmp3_i32;
     TCGv_i64 tmp1_i64;
@@ -2175,14 +2174,17 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     level &= 31;
     if (level != 0) {
         int i;
+        if (level > 1) {
+            TCGv fp = tcg_temp_new();
 
-        /* Copy level-1 pointers from the previous frame.  */
-        for (i = 1; i < level; ++i) {
-            gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], -size * i);
-            gen_op_ld_v(s, d_ot, s->tmp0, s->A0);
+            /* Copy level-1 pointers from the previous frame.  */
+            for (i = 1; i < level; ++i) {
+                gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], -size * i);
+                gen_op_ld_v(s, d_ot, fp, s->A0);
 
-            gen_lea_ss_ofs(s, s->A0, s->T1, -size * i);
-            gen_op_st_v(s, d_ot, s->tmp0, s->A0);
+                gen_lea_ss_ofs(s, s->A0, s->T1, -size * i);
+                gen_op_st_v(s, d_ot, fp, s->A0);
+            }
         }
 
         /* Push the current FrameTemp as the last level.  */
@@ -2405,10 +2407,11 @@ static void gen_ldy_env_A0(DisasContext *s, int offset, bool align)
     int mem_index = s->mem_index;
     TCGv_i128 t0 = tcg_temp_new_i128();
     TCGv_i128 t1 = tcg_temp_new_i128();
+    TCGv a0_hi = tcg_temp_new();
 
     tcg_gen_qemu_ld_i128(t0, s->A0, mem_index, mop | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 16);
-    tcg_gen_qemu_ld_i128(t1, s->tmp0, mem_index, mop);
+    tcg_gen_addi_tl(a0_hi, s->A0, 16);
+    tcg_gen_qemu_ld_i128(t1, a0_hi, mem_index, mop);
 
     tcg_gen_st_i128(t0, tcg_env, offset + offsetof(YMMReg, YMM_X(0)));
     tcg_gen_st_i128(t1, tcg_env, offset + offsetof(YMMReg, YMM_X(1)));
@@ -2419,12 +2422,13 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     MemOp mop = MO_128 | MO_LE | MO_ATOM_IFALIGN_PAIR;
     int mem_index = s->mem_index;
     TCGv_i128 t = tcg_temp_new_i128();
+    TCGv a0_hi = tcg_temp_new();
 
     tcg_gen_ld_i128(t, tcg_env, offset + offsetof(YMMReg, YMM_X(0)));
     tcg_gen_qemu_st_i128(t, s->A0, mem_index, mop | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 16);
+    tcg_gen_addi_tl(a0_hi, s->A0, 16);
     tcg_gen_ld_i128(t, tcg_env, offset + offsetof(YMMReg, YMM_X(1)));
-    tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
+    tcg_gen_qemu_st_i128(t, a0_hi, mem_index, mop);
 }
 
 #include "emit.c.inc"
@@ -3771,7 +3775,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->tmp0 = tcg_temp_new();
     dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
     dc->tmp3_i32 = tcg_temp_new_i32();
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a41afb7fe46..bd24438230d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1710,22 +1710,22 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
     switch (jcc_op) {
     case JCC_O:
         /* (src1 ^ src2) & (src1 ^ dst). newv is only used here for a moment */
+        cmp_lhs = tcg_temp_new(), cmp_rhs = tcg_constant_tl(0);
         tcg_gen_xor_tl(newv, s->cc_srcT, s->T0);
-        tcg_gen_xor_tl(s->tmp0, s->cc_srcT, cmpv);
-        tcg_gen_and_tl(s->tmp0, s->tmp0, newv);
-        tcg_gen_sextract_tl(s->tmp0, s->tmp0, 0, 8 << ot);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        tcg_gen_xor_tl(cmp_lhs, s->cc_srcT, cmpv);
+        tcg_gen_and_tl(cmp_lhs, cmp_lhs, newv);
+        tcg_gen_sextract_tl(cmp_lhs, cmp_lhs, 0, 8 << ot);
         break;
 
     case JCC_P:
-        tcg_gen_ext8u_tl(s->tmp0, s->T0);
-        tcg_gen_ctpop_tl(s->tmp0, s->tmp0);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(1);
+        cmp_lhs = tcg_temp_new(), cmp_rhs = tcg_constant_tl(1);
+        tcg_gen_ext8u_tl(cmp_lhs, s->T0);
+        tcg_gen_ctpop_tl(cmp_lhs, cmp_lhs);
         break;
 
     case JCC_S:
-        tcg_gen_sextract_tl(s->tmp0, s->T0, 0, 8 << ot);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        cmp_lhs = tcg_temp_new(), cmp_rhs = tcg_constant_tl(0);
+        tcg_gen_sextract_tl(cmp_lhs, s->T0, 0, 8 << ot);
         break;
 
     default:
@@ -1876,7 +1876,7 @@ static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
                                       s->mem_index, MO_TEUQ);
     }
 
-    /* Set tmp0 to match the required value of Z. */
+    /* Compute the required value of Z. */
     tcg_gen_setcond_i64(TCG_COND_EQ, cmp, old, cmp);
     Z = tcg_temp_new();
     tcg_gen_trunc_i64_tl(Z, cmp);
-- 
2.49.0


