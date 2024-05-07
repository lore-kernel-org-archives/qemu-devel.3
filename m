Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D837FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVD-0005xn-NS; Tue, 07 May 2024 06:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV0-0005Bo-Mw
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUy-0002uK-Ms
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36zjtL34Xdsi5Kw7ff/j9esAdUS5f+PAQXgkpMxW4Zk=;
 b=BZ05cT+EXpQJLgbBwAZKhfuynAG45QgIb6F1XZIWcb+yzy28TyGwAEDCgs/yBvE8f8liKn
 sBWhpvmuqWrGfv1wGOOuTXqphvP9ZraVSob10RiiV9TLn3OvO3HAWroVPaMJEgTU7xb1y7
 2VOupSeIFWOXH8Cel8hY7Y7LoJJ7EB0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Hm02DHwqOCOWyIlcIKmYrA-1; Tue, 07 May 2024 06:56:37 -0400
X-MC-Unique: Hm02DHwqOCOWyIlcIKmYrA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59ad486084so153453866b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079395; x=1715684195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36zjtL34Xdsi5Kw7ff/j9esAdUS5f+PAQXgkpMxW4Zk=;
 b=AiEfQWo4pp6wALQG5j3qqlJCN1dUMJn6VimEFkzOwpcVBaqbieUe6pyeWH4bFVjW3r
 FK5zsIRFh/uki7QcWk9FcXvDIpFeOZKLn7FadEmjO92Cps7XD1cd3YCPnCtsxpodsMpg
 d8XTzD6yAP0IJrC+lhEow3lwGseKNfzvRhgyIXmTSQvVOSsqsWQnMgc4U/rz2pzCxciV
 JGdhBiluKnNn4bTMYdCi2mQKq4kLqk2yGH4AaooRErhbTDq2V7lpPSlLmzXmzSSdKy56
 Vw4FCnjgf8zZwR8s1mqMoDoZBLIpPqNSssqPjaCDjBE6UGXmwbRWaOqG6uehuNtx8q8E
 j6pw==
X-Gm-Message-State: AOJu0YyP1TJ7FEuoEfR7+v/Lvu/NxX0CyMM5Gm1At2fC8vU+kcdlL4LV
 GlG2UjvL2JU/NtVWVi67Tkl49hox94V9EoJLBAujjQN9vcaY8W0PRWcHjacS8O9iAHRp+eCVGv1
 wfrKdauBQRvnk3GJvgyDgVXF2OvniJ4ddb3fajBzNXVuCJ2tCOE7kl/JHOyoTXZGcTMpl5dGk4c
 fnO57oFCJ7Qkz9zQP/e+mgGn5xC2f2MMdUhT86
X-Received: by 2002:a17:907:9722:b0:a59:bae0:b12f with SMTP id
 jg34-20020a170907972200b00a59bae0b12fmr6412195ejc.57.1715079395595; 
 Tue, 07 May 2024 03:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt9bxOaDBYQ1nNDFqRUS1YIQbKQpLNrYB8vlpSUI+Kwv5sssuCKz3lyTxm4pc7gu8ltgEABw==
X-Received: by 2002:a17:907:9722:b0:a59:bae0:b12f with SMTP id
 jg34-20020a170907972200b00a59bae0b12fmr6412185ejc.57.1715079395300; 
 Tue, 07 May 2024 03:56:35 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a170906394300b00a599c1d46d5sm4786967eje.101.2024.05.07.03.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/26] target/i386: move remaining conditional operations to
 new decoder
Date: Tue,  7 May 2024 12:55:32 +0200
Message-ID: <20240507105538.180704-21-pbonzini@redhat.com>
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

Move long-displacement Jcc, SETcc and CMOVcc to the new decoder.
While filling in the tables makes the code seem longer, the new
emitters are all just one line of code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/translate.c      |  2 +-
 target/i386/tcg/decode-new.c.inc | 56 ++++++++++++++++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 10 ++++++
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index e86a5c2cb56..2ea06b44787 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -107,6 +107,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_AVX2,
     X86_FEAT_BMI1,
     X86_FEAT_BMI2,
+    X86_FEAT_CMOV,
     X86_FEAT_CMPCCXADD,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3060fdbee94..b1c1aecf71e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3207,7 +3207,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && 0) {
+        if (use_new && (b >= 0x138 && b <= 0x19f)) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b145af7a565..c70a7836914 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -999,6 +999,15 @@ static const X86OpEntry opcodes_0F[256] = {
     /* Incorrectly listed as Mq,Vq in the manual */
     [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex5 p_00_66),
 
+    [0x40] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x41] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x42] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x43] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x44] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x45] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x46] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x47] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+
     [0x50] = X86_OP_ENTRY3(MOVMSK,     G,y, None,None, U,x, vex7 p_00_66),
     [0x51] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* sqrtps */
     [0x52] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3), /* rsqrtps */
@@ -1026,6 +1035,24 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x76] = X86_OP_ENTRY3(PCMPEQD,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
     [0x77] = X86_OP_GROUP0(0F77),
 
+    [0x80] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x81] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x82] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x83] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x84] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x85] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x86] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x87] = X86_OP_ENTRYr(Jcc, J,z_f64),
+
+    [0x90] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x91] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x92] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x93] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x94] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x95] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x96] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x97] = X86_OP_ENTRYw(SETcc, E,b),
+
     [0x28] = X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x, vex1 p_00_66), /* MOVAPS */
     [0x29] = X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex1 p_00_66), /* MOVAPS */
     [0x2A] = X86_OP_GROUP0(0F2A),
@@ -1038,6 +1065,15 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x38] = X86_OP_GROUP0(0F38),
     [0x3a] = X86_OP_GROUP0(0F3A),
 
+    [0x48] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x49] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4a] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4b] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4c] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4d] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4e] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4f] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+
     [0x58] = X86_OP_ENTRY3(VADD,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x59] = X86_OP_ENTRY3(VMUL,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x5a] = X86_OP_GROUP0(0F5A),
@@ -1063,6 +1099,24 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x7e] = X86_OP_GROUP0(0F7E),
     [0x7f] = X86_OP_GROUP0(0F7F),
 
+    [0x88] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x89] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x8a] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x8b] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x8c] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x8d] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x8e] = X86_OP_ENTRYr(Jcc, J,z_f64),
+    [0x8f] = X86_OP_ENTRYr(Jcc, J,z_f64),
+
+    [0x98] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x99] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9a] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9b] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9c] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9d] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9e] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9f] = X86_OP_ENTRYw(SETcc, E,b),
+
     [0xae] = X86_OP_GROUP0(group15),
 
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
@@ -1929,6 +1983,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     switch (cpuid) {
     case X86_FEAT_None:
         return true;
+    case X86_FEAT_CMOV:
+        return (s->cpuid_features & CPUID_CMOV);
     case X86_FEAT_F16C:
         return (s->cpuid_ext_features & CPUID_EXT_F16C);
     case X86_FEAT_FMA:
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2c848fab62f..a9e32516afd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1386,6 +1386,11 @@ static void gen_CMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
 }
 
+static void gen_CMOVcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_cmovcc1(s, decode->b & 0xf, s->T0, s->T1);
+}
+
 static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
@@ -3305,6 +3310,11 @@ static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_SETcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_setcc1(s, decode->b & 0xf, s->T0);
+}
+
 static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
-- 
2.45.0


