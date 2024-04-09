Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC59CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEai-0001AF-E1; Tue, 09 Apr 2024 12:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEa9-0000eG-7m
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZz-00086f-TU
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dBjfULU0sDr337Hpo9NybkNaRsnBMREB60wbOp5+4s=;
 b=KuqhP/qbDw6CH9lcVQ1RyVQpe1m7bfrEqJPdUBXSATHQ4SfCVnaIkpBnHtlvaXqZJSB3kz
 KygiRMClSJQ1DqZ8rW04YKq7nPMJ2W1y1SbbFHkQnAn4OcIaq+AkWiVgf2HPxKi5utPVnL
 foQVK9HxFbY4UHKR++XsDPdfHzMvTtQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-J7rRhDCjOh2rHNxbw46I4g-1; Tue, 09 Apr 2024 12:44:04 -0400
X-MC-Unique: J7rRhDCjOh2rHNxbw46I4g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-416ac21981dso4592025e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681043; x=1713285843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dBjfULU0sDr337Hpo9NybkNaRsnBMREB60wbOp5+4s=;
 b=RPVy7H35mG68OCaBe5BXFQ48SuGAUPr5Ja+WQVIWuPE163DusUN8ejoduyUsiIhcL9
 VMb2mwYxUZatOhxSOWrp652Zqo9apiR1dvOEMjnZ6APlRtaJLAclbo37lfsMs+FXSW0+
 3DEYYQrVQOcvrPYZFC9yozCDBP+mbxPXWE+6IVJ0qlQ17aBlDXSgS9XP4r7EXJ9owX1m
 okSZAbZAEFd/bM3PLS4XrcCpWQctw5YOjI83fvsQmRWdQzXmY7pfS0w85QOEwlRmtUKD
 F3FMlj6f9Vc1FRVLG0sTGZrHqFbMGqlyXB5yJXvmVQrLh9ilzJHo4pz1RvQPnAWsBBBG
 /5Tw==
X-Gm-Message-State: AOJu0Yycu9zTm701JmDcqsJVVe4pS4cyFL4Q/CBXEhKUv+IQA0bIG8oe
 GsLAOSui4p4mU4CV5z4xH9VKvVPMfYeKDZnmmL02s2+Y4R/jwBKkcAtSbaOq1aUCkvY9j7doIJq
 uvQ8wfdqEPzUMkAYYuo7fjPJQQI44h+AWmPMgESfpqXJdggij0KlIdaPcIM8Nbci7GlDhQgppEQ
 E/ZchwLnf7l7h1sOnF2KGUI807YUalBhMJRsh3
X-Received: by 2002:a05:600c:4748:b0:416:2674:1938 with SMTP id
 w8-20020a05600c474800b0041626741938mr2857646wmo.15.1712681043056; 
 Tue, 09 Apr 2024 09:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ+44dp/Q4EGhHP+Mcxv1+Zq4yiOiyKIXBr3JvlcW69FFI3hkowXBHdyu4HdBi6a1iJLd09A==
X-Received: by 2002:a05:600c:4748:b0:416:2674:1938 with SMTP id
 w8-20020a05600c474800b0041626741938mr2857627wmo.15.1712681042637; 
 Tue, 09 Apr 2024 09:44:02 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a05600c358e00b0041674bf7d4csm7851084wmq.48.2024.04.09.09.44.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:44:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 13/19] target/i386: move remaining conditional
 operations to new decoder
Date: Tue,  9 Apr 2024 18:43:17 +0200
Message-ID: <20240409164323.776660-14-pbonzini@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/translate.c      |  2 +-
 target/i386/tcg/decode-new.c.inc | 56 ++++++++++++++++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 10 ++++++
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 77bb31eb143..cd7ceca21e8 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -106,6 +106,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_AVX2,
     X86_FEAT_BMI1,
     X86_FEAT_BMI2,
+    X86_FEAT_CMOV,
     X86_FEAT_CMPCCXADD,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 26e4c7520db..f3c437aee88 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3209,7 +3209,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && 0) {
+        if (use_new && (b >= 0x138 && b <= 0x19f)) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 87ae63faf9a..36eb53515af 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -993,6 +993,15 @@ static const X86OpEntry opcodes_0F[256] = {
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
@@ -1020,6 +1029,24 @@ static const X86OpEntry opcodes_0F[256] = {
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
@@ -1032,6 +1059,15 @@ static const X86OpEntry opcodes_0F[256] = {
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
@@ -1057,6 +1093,24 @@ static const X86OpEntry opcodes_0F[256] = {
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
@@ -1917,6 +1971,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     switch (cpuid) {
     case X86_FEAT_None:
         return true;
+    case X86_FEAT_CMOV:
+        return (s->cpuid_features & CPUID_CMOV);
     case X86_FEAT_F16C:
         return (s->cpuid_ext_features & CPUID_EXT_F16C);
     case X86_FEAT_FMA:
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 07f9b506043..dc5142be51f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1375,6 +1375,11 @@ static void gen_CMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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
@@ -3270,6 +3275,11 @@ static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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
2.44.0


