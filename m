Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C9AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSU-0005db-Of; Mon, 06 May 2024 04:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRr-0004zH-0r
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRB-0002al-Jp
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYyE+A8JPYDhsHbuUhyOqc3BAt+kfeW3lkcMpEgGojo=;
 b=dgSjNn+FSRRHdxVIAAQVoRZy64ZH0g0Ifs2yD/lGaF0ivZuMD02xQnhkYR+Wc2sdUfDFC6
 4zu2qJc+S262Bh4GZ7vct+k+ZG9/motrMD8sqzOOGPQf+in5YQS8SUxHth5Vo1krqjoYPP
 /cw1EuA9dkkeIK52RI/ckOiyP6w8/0g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-B3__kq4bMHuYLRw1j9DKqg-1; Mon, 06 May 2024 04:11:03 -0400
X-MC-Unique: B3__kq4bMHuYLRw1j9DKqg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56e645a8762so1146714a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983061; x=1715587861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYyE+A8JPYDhsHbuUhyOqc3BAt+kfeW3lkcMpEgGojo=;
 b=BXhPa3RC05QNJrzLP8bMvxBHilULwSLPzg/u3Zych/k5ymc6EtYpFM45r00ZOBqeUU
 FSt9WpvDhsh+vN5uOTK6BMZt4xh0k1a9d0PTJHN01akbJlPPhFufWi11uvGjgzsKWjam
 nImPz5MvHLQzYMDkoMm93LlcFzFd5Mo7xNqYyAAqzb0ydUJPaXsZxycLx7DlngQ5Qv0h
 /B7bAa6Dqr4ITMMcFGmi5s3/WsZp3bxU2Hgj8XZ0q+7vG5T3wNiCXQIckb8mFFmWm9jH
 qPnUIfQS/ZazlKRk4NDIcC5I8TL2tr4VcHlQo64E9RZAmDbZCVVlp+5H5sv1020Dq94T
 zsCQ==
X-Gm-Message-State: AOJu0YwjECBvlePm9xg6Bl585mfPRtKJAkJTiLKMGilkIoMpq/i6n18b
 Hbrsi4YVPnoKMJHywrHQHPJfFBT/S0MgG/5xo1WWTDpo9g8E1sFSAF63a9IewgCo8Ml7C0e2MG5
 n7e/5lqLBv6INacPOHI+xZca0yAGLzRjwGD/y/tSqAtIEay1hhDUMj7oUIO5QeZ2Z9GJ2DEg/67
 GYZuJ4ePsz6VlwvXZuQuxoLvVKJBVP/1Y7DQHb
X-Received: by 2002:a50:8d13:0:b0:572:6f3d:7208 with SMTP id
 s19-20020a508d13000000b005726f3d7208mr6178503eds.29.1714983061703; 
 Mon, 06 May 2024 01:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsIwsUsm7ETinu6hxHriZOD24QCUttvcbW3F2C8anuLfep/AWW6JL/qt6ylr6rDsCVlrP+BA==
X-Received: by 2002:a50:8d13:0:b0:572:6f3d:7208 with SMTP id
 s19-20020a508d13000000b005726f3d7208mr6178487eds.29.1714983061307; 
 Mon, 06 May 2024 01:11:01 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005725c56b35bsm4868520edz.71.2024.05.06.01.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:11:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 21/25] target/i386: port extensions of one-byte opcodes to
 new decoder
Date: Mon,  6 May 2024 10:09:53 +0200
Message-ID: <20240506080957.10005-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/translate.c      |  4 ++++
 target/i386/tcg/decode-new.c.inc | 31 +++++++++++++++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 15 +++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index cd7ceca21e8..2ea06b44787 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -47,6 +47,7 @@ typedef enum X86OpType {
     X86_TYPE_Y, /* string destination */
 
     /* Custom */
+    X86_TYPE_EM, /* modrm byte selects an ALU memory operand */
     X86_TYPE_WM, /* modrm byte selects an XMM/YMM memory operand */
     X86_TYPE_I_unsigned, /* Immediate, zero-extended */
     X86_TYPE_2op, /* 2-operand RMW instruction */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 87ecf082316..14417b961ce 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3208,6 +3208,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
index e65fa208a43..8311b479846 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -43,6 +43,12 @@
  * Operand types
  * -------------
  *
+ * For memory-only operands, if the emitter functions wants to rely on
+ * generic load and writeback, the decoder needs to know the type of the
+ * operand.  Therefore, M is often replaced by the more specific EM and WM
+ * (respectively selecting an ALU operand, like the operand type E, or a
+ * vector operand like the operand type W).
+ *
  * Immediates are almost always signed or masked away in helpers.  Two
  * common exceptions are IN/OUT and absolute jumps.  For these, there is
  * an additional custom operand type "I_unsigned".  Alternatively, the
@@ -1047,6 +1053,9 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x96] = X86_OP_ENTRYw(SETcc, E,b),
     [0x97] = X86_OP_ENTRYw(SETcc, E,b),
 
+    [0xa0] = X86_OP_ENTRYr(PUSH, FS, w),
+    [0xa1] = X86_OP_ENTRYw(POP, FS, w),
+
     [0x28] = X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x, vex1 p_00_66), /* MOVAPS */
     [0x29] = X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex1 p_00_66), /* MOVAPS */
     [0x2A] = X86_OP_GROUP0(0F2A),
@@ -1111,9 +1120,26 @@ static const X86OpEntry opcodes_0F[256] = {
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
+    [0xb2] = X86_OP_ENTRY3(LSS,    G,v, M,p, None, None),
+    [0xb4] = X86_OP_ENTRY3(LFS,    G,v, M,p, None, None),
+    [0xb5] = X86_OP_ENTRY3(LGS,    G,v, M,p, None, None),
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
@@ -1815,8 +1841,13 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
         op->unit = X86_OP_SSE;
+        goto get_modrm_mem;
+
+    case X86_TYPE_EM:  /* modrm byte selects an ALU memory operand */
+        op->unit = X86_OP_INT;
         /* fall through */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
+    get_modrm_mem:
         modrm = get_modrm(s, env);
         if ((modrm >> 6) == 3) {
             return false;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c826adbbbb8..01aed001075 100644
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


