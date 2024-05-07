Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A35C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVG-00067t-2R; Tue, 07 May 2024 06:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV4-0005Oo-PS
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV1-0002v6-Q3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMND7pu/M928xDVINEPT8A5TcOwQFK6xSjrV4C36iH4=;
 b=Uz3RQkcU6s6oyhmI95RoXUsxGzNWuGUi12OJhbt6YaS9fYRSHbbGOEmFe0CkcG4vWqIapj
 b6oZadju3XBmwPwkdTCT6dLY2tyHdAcUEBaw1pF2McgDwqD64nHKsYzrpyx8ETqc2TEkFv
 8tcWn8it02mEOsN0m5qmvDUkRCZkLv4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-I4P7pnH7NaCWjynCgEod5g-1; Tue, 07 May 2024 06:56:41 -0400
X-MC-Unique: I4P7pnH7NaCWjynCgEod5g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572babec6c6so5690736a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079400; x=1715684200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMND7pu/M928xDVINEPT8A5TcOwQFK6xSjrV4C36iH4=;
 b=tlxD1YN2a6WBbf8mF1T+jOQ+et9/FujWz9QTY2/46SmksNzdwx83586qbeuB/cypZ2
 6TdB8nwENulOK42nbb7vATsPgxHFFEF20AQH6gvP+SV0qeIVHZEWgs0f+rg+c/JGje0L
 wDnxPoPNow2e8WMCNIczCIHzFP5Cl8EfnCh1JTg23I9HCpAEnVzSMd+08SF6PPB+DaqN
 IiG+H/PyFAidHI/gpmeXdWZS1senbduHQC3eIKXioQgJD72tDKrvJ9LmHZL6OLwvnziI
 5U7pOydqwTFImgWH7bbqejt2KJ9Q6PoPz/S1znj00ZcUFyOcc9oZcyp2ZTmgCMfxpw3N
 eoyg==
X-Gm-Message-State: AOJu0Yy8zhrFFaHfYRvzmWhO4hiwx6+l2miiY2gfHA7AlswXNsDsltO7
 0u0BgZq5kJCFDm0dBNOk2htq2hCbZ35BEaiNNQvs5WcKns59Bmjcd2SNZu9JffrQqCpSifE2ACi
 iChhwxLL22Nr9DiMtsiP3rpxZV1zzc12sB41de8BM7fz1GlSJhPE/Mls2mHUs4B9308hNNG5Hga
 bZRiyYnAouFde2w7JX55nZcuhTzemedZxRqFRR
X-Received: by 2002:a05:6402:134f:b0:572:a087:304c with SMTP id
 4fb4d7f45d1cf-5731101d4b9mr1923186a12.2.1715079400106; 
 Tue, 07 May 2024 03:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ADz1O9fm9mnGDumusO5ofxMMo0xt1xZq9gGwc/no3ELvs8+bFJeovAijPbU4+HOgWnkPNg==
X-Received: by 2002:a05:6402:134f:b0:572:a087:304c with SMTP id
 4fb4d7f45d1cf-5731101d4b9mr1923171a12.2.1715079399806; 
 Tue, 07 May 2024 03:56:39 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05640205d200b00572f0438b02sm3102130edx.6.2024.05.07.03.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/26] target/i386: port extensions of one-byte opcodes to new
 decoder
Date: Tue,  7 May 2024 12:55:34 +0200
Message-ID: <20240507105538.180704-23-pbonzini@redhat.com>
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

A few two-byte opcodes are simple extensions of existing one-byte opcodes;
they are easy to decode and need no change to emit.c.inc.  Port them to
the new decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  4 ++++
 target/i386/tcg/decode-new.c.inc | 20 ++++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 15 +++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 751ec5d0f1a..4fbd91e70d1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3209,6 +3209,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #endif
         if (use_new &&
             ((b >= 0x138 && b <= 0x19f) ||
+             (b & ~9) == 0x1a0 ||
+             b == 0x1af || b == 0x1b2 ||
+             (b >= 0x1b4 && b <= 0x1b7) ||
+             b == 0x1be || b == 0x1bf || b == 0x1c3 ||
              (b >= 0x1c8 && b <= 0x1cf))) {
             disas_insn_new(s, cpu, b);
             return true;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 16e23ec3d88..f9a966943fb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1053,6 +1053,9 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x96] = X86_OP_ENTRYw(SETcc, E,b),
     [0x97] = X86_OP_ENTRYw(SETcc, E,b),
 
+    [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
+    [0xa1] = X86_OP_ENTRYw(POP, FS, w),
+
     [0x28] = X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x, vex1 p_00_66), /* MOVAPS */
     [0x29] = X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex1 p_00_66), /* MOVAPS */
     [0x2A] = X86_OP_GROUP0(0F2A),
@@ -1117,9 +1120,26 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x9e] = X86_OP_ENTRYw(SETcc, E,b),
     [0x9f] = X86_OP_ENTRYw(SETcc, E,b),
 
+    [0xa8] = X86_OP_ENTRYr(PUSH,   GS, w),
+    [0xa9] = X86_OP_ENTRYw(POP,    GS, w),
     [0xae] = X86_OP_GROUP0(group15),
+    /*
+     * It's slightly more efficient to put Ev operand in T0 and allow gen_IMUL3
+     * to assume sextT0.  Multiplication is commutative anyway.
+     */
+    [0xaf] = X86_OP_ENTRY3(IMUL3,  G,v, E,v, 2op,v, sextT0),
+
+    [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
+    [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
+    [0xb5] = X86_OP_ENTRY3(LGS,    G,v, EM,p, None, None),
+    [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
+    [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
+
+    [0xbe] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, sextT0), /* MOVSX */
+    [0xbf] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, sextT0), /* MOVSX */
 
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
+    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index befde6677be..58f255873ff 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1979,6 +1979,16 @@ static void gen_LES(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_lxx_seg(s, env, decode, R_ES);
 }
 
+static void gen_LFS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_lxx_seg(s, env, decode, R_FS);
+}
+
+static void gen_LGS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_lxx_seg(s, env, decode, R_GS);
+}
+
 static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
@@ -2023,6 +2033,11 @@ static void gen_LOOPNE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
+static void gen_LSS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_lxx_seg(s, env, decode, R_SS);
+}
+
 static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* nothing to do! */
-- 
2.45.0


