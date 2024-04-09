Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAA8C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEaZ-0000q6-T7; Tue, 09 Apr 2024 12:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEaE-0000es-L7
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEa1-00087D-9V
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlu7b7TOekeVXIs0YLd//Se9WSGm5c3+rStDiPl90VM=;
 b=XPeu44w525Xjqry5lB+8YW4GNiYvfEiYlw0kDaL5KKTBu0vYBJZTohNAJh/qE8u3Pz/yvE
 qqodXXrFjRxqMhxpiPKQfyTIa+NJZTs4d9ZfouUx8ZZEeghk/YcIe9p90BhaenhpIFDUBv
 YJmj8giuNWaPRjFIO896aTrC/Zg7Z7U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-g8zM3X1COuqo1dyGffnvcA-1; Tue, 09 Apr 2024 12:44:09 -0400
X-MC-Unique: g8zM3X1COuqo1dyGffnvcA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-343ee8b13aeso2752388f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681048; x=1713285848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlu7b7TOekeVXIs0YLd//Se9WSGm5c3+rStDiPl90VM=;
 b=DhJLSNRLujPsN1SEZju5iS9b1JoKL8e+W9nvmhgnR/TAGcl1q+/CE2HR+um587hnqP
 W4LqhYV3qmwNXuuouRogmKcrpyDHWaV8sHgqMGg6KZTG4yULPPh9s0fGESkL8yCrAHFh
 8nLX+9n0LIGebMDhGYQOEEkTZoCjzL3S1WgCccokRHFkFiU1Tv6VPBwqO5JMhCD5KFSD
 vSvOSfb9fqaENCmU0hJ4NnAgcZHvygjoJMmQadpruC7fyClNccxC8+5rsFYnjQt+2aku
 gM8Aj7cjXnCwvGzgdPScdbYK/VVX37jchwSBhsGHy/UiQOZ+z54en0UwK2Kgdiz/lFDt
 Mf8g==
X-Gm-Message-State: AOJu0YzQcVbK2pEvQyql6Bg7+CIEmUmNskav4M+c/yY8HJZ9EDzhXJv+
 9PmGj+h1EbnRgOFOvrQ2EGJOswYdOgtKxR3bqFKy3Kz8rHB7ecFs8Lh5DhTLglmSRo+9kNTs5/A
 5zJBbgR/f3bWMky9aVJj4ZDu/npouc+AVssv2Hr6pvD5F9DH+sKs4AaxRYnmDiY4MIaJ+QWmnty
 f3CMnQpV1GXCZDVe4JhQ5p7MJMHDnaWKBf6R3Z
X-Received: by 2002:adf:f1c4:0:b0:343:a337:f380 with SMTP id
 z4-20020adff1c4000000b00343a337f380mr244819wro.19.1712681048397; 
 Tue, 09 Apr 2024 09:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoRVmUgn+2o5l4YRHNlGb6YqgiaXTUPL4H8R8dh59TvLf9NtjNoVcyUuiB9k5I8UjKAXTixQ==
X-Received: by 2002:adf:f1c4:0:b0:343:a337:f380 with SMTP id
 z4-20020adff1c4000000b00343a337f380mr244804wro.19.1712681048059; 
 Tue, 09 Apr 2024 09:44:08 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a5d5242000000b00343c0c24a65sm11841262wrc.89.2024.04.09.09.44.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:44:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 15/19] target/i386: port extensions of one-byte
 opcodes to new decoder
Date: Tue,  9 Apr 2024 18:43:19 +0200
Message-ID: <20240409164323.776660-16-pbonzini@redhat.com>
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
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/translate.c      |  4 ++++
 target/i386/tcg/decode-new.c.inc | 27 +++++++++++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 15 +++++++++++++++
 4 files changed, 47 insertions(+)

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
index a1e6e8ec7d9..e8352d43678 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3211,6 +3211,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
index 2ee949b50e2..2e27d28dc95 100644
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
@@ -1111,9 +1120,22 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x9e] = X86_OP_ENTRYw(SETcc, E,b),
     [0x9f] = X86_OP_ENTRYw(SETcc, E,b),
 
+    [0xa8] = X86_OP_ENTRYr(PUSH, GS, w),
+    [0xa9] = X86_OP_ENTRYw(POP, GS, w),
     [0xae] = X86_OP_GROUP0(group15),
+    [0xaf] = X86_OP_ENTRY2(IMUL3,      G,v, E,v),
+
+    [0xb2] = X86_OP_ENTRY3(LSS, G,v, M,p, None, None),
+    [0xb4] = X86_OP_ENTRY3(LFS, G,v, M,p, None, None),
+    [0xb5] = X86_OP_ENTRY3(LGS, G,v, M,p, None, None),
+    [0xb6] = X86_OP_ENTRY3(MOV, G,v, E,b, None, None, zextT0), /* MOVZX */
+    [0xb7] = X86_OP_ENTRY3(MOV, G,v, E,w, None, None, zextT0), /* MOVZX */
+
+    [0xbe] = X86_OP_ENTRY3(MOV, G,v, E,b, None, None, sextT0), /* MOVSX */
+    [0xbf] = X86_OP_ENTRY3(MOV, G,v, E,w, None, None, sextT0), /* MOVSX */
 
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
+    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
@@ -1814,8 +1836,13 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
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
index 1dc246f8c1e..35bb56c750e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1956,6 +1956,16 @@ static void gen_LES(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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
@@ -1997,6 +2007,11 @@ static void gen_LOOPNE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
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
2.44.0


