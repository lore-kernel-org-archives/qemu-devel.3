Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A93CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEaX-0000l2-Q2; Tue, 09 Apr 2024 12:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZs-0000Vl-7L
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZf-00082F-0U
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jil+htFRzvf6aPlzOtZ9Y7Dok7rKW7xkrEHwvqOyfxQ=;
 b=HDa7I+xwDlju9hc5wLnS4X9nJsKjRTuuBxgbO1FZFAYUub2qsAexGXSGfkZT2Rn7MY1MSm
 I3nga2GnA6AMNQDxopyyUlc97PxMhe7rLjH0dTOMt1C7a9g9pgnaYbj04gFoAGFtJow+Kb
 aKZlexNqSnyacWA4WlyN4CaJNKoEktI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-XEvuUECOM1SvrORaz4UYQw-1; Tue, 09 Apr 2024 12:43:44 -0400
X-MC-Unique: XEvuUECOM1SvrORaz4UYQw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416612274e7so9280635e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681023; x=1713285823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jil+htFRzvf6aPlzOtZ9Y7Dok7rKW7xkrEHwvqOyfxQ=;
 b=rQq+bDJgJZCwGVWTdk3rU1oEiaOjyWFdz4zgnOhJ510/CB8qmW8wXnqjwy4ADGbn9o
 KTwws1UFkH0ffn+VD0AxZ2dPkVo6l7wkglOJkKTv7TI8E7Iz7REwAfnOfLUSkWdO+dnm
 eKjMFTc03AJfKZta6/I+ZmPKazAcw+P6DnUyK+4PYWpw1iBIGBmCh3NYvqOJcmmj3yhz
 WJQfOUotm8m3D6JeEX5xyFe8TVgd0p4gyw0bB8U9G8eoFDn9NWBwDJIRku03Cdj6aSjl
 1T7iHRf+GzAp/y7P1UT9F+f6keurxhXX7YPJCKt38x6/DFxud6HIKn9imJs1CKFThBDn
 qaLA==
X-Gm-Message-State: AOJu0Yw8Ubq6pCTKIN7+KeZ459/56i4nXh1xOc275t1o8A9so3ZzYfCX
 nakNg7ho80We79r97TpbJWddkxujxaFeUnCDGpF4xDdmyZ99w27ZGK/v0uqtB3FgSyb8MdpZH3i
 Kxj5bmtxA7o6mpNVZ5XM0VbBpADhYXgjQlpu3E0R8A9ywNHf+8StQ62xlhnx1xi9J3BZaYnquZx
 EuaBjeihjTtVOUUzmDpsz7gbf3n1bre5GA1VHR
X-Received: by 2002:a05:600c:cce:b0:416:bbf8:27e7 with SMTP id
 fk14-20020a05600c0cce00b00416bbf827e7mr176700wmb.24.1712681022818; 
 Tue, 09 Apr 2024 09:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPdAMK26dmrdXahME7CjbeNJysX3y+1mqtjtfIjDpNnUK9egz4rUe0624r2pbecLecBeH2Dg==
X-Received: by 2002:a05:600c:cce:b0:416:bbf8:27e7 with SMTP id
 fk14-20020a05600c0cce00b00416bbf827e7mr176687wmb.24.1712681022202; 
 Tue, 09 Apr 2024 09:43:42 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 bg8-20020a05600c3c8800b00414807ef8dfsm17908983wmb.5.2024.04.09.09.43.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 06/19] target/i386: move 00-5F opcodes to new decoder
Date: Tue,  9 Apr 2024 18:43:10 +0200
Message-ID: <20240409164323.776660-7-pbonzini@redhat.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |   2 +-
 target/i386/tcg/decode-new.c.inc | 120 ++++++++++++++++++
 target/i386/tcg/emit.c.inc       | 202 +++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2a372842db4..e501d4701b6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3148,7 +3148,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && 0) {
+        if (use_new && b <= 0x5f) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 3fc6485d74c..1e792426ff5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -121,6 +121,8 @@
 
 #define X86_OP_GROUP2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_GROUP3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
+#define X86_OP_GROUPw(op, op0, s0, ...)                           \
+    X86_OP_GROUP3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUP0(op, ...)                                    \
     X86_OP_GROUP3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -140,12 +142,23 @@
         .op3 = X86_TYPE_I, .s3 = X86_SIZE_b,                      \
         ## __VA_ARGS__)
 
+/*
+ * Short forms that are mostly useful for ALU opcodes and other
+ * one-byte opcodes.  For vector instructions it is usually
+ * clearer to write all three operands explicitly, because the
+ * corresponding gen_* function will use OP_PTRn rather than s->T0
+ * and s->T1.
+ */
+#define X86_OP_ENTRYrr(op, op0, s0, op1, s1, ...)                 \
+    X86_OP_ENTRY3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRY2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_ENTRY3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRYw(op, op0, s0, ...)                           \
     X86_OP_ENTRY3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRYr(op, op0, s0, ...)                           \
     X86_OP_ENTRY3(op, None, None, None, None, op0, s0, ## __VA_ARGS__)
+#define X86_OP_ENTRY1(op, op0, s0, ...)                           \
+    X86_OP_ENTRY3(op, op0, s0, 2op, s0, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRY0(op, ...)                                    \
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -1096,7 +1109,114 @@ static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
 }
 
 static const X86OpEntry opcodes_root[256] = {
+    [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b, lock),
+    [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v, lock),
+    [0x02] = X86_OP_ENTRY2(ADD, G,b, E,b, lock),
+    [0x03] = X86_OP_ENTRY2(ADD, G,v, E,v, lock),
+    [0x04] = X86_OP_ENTRY2(ADD, 0,b, I,b, lock),   /* AL, Ib */
+    [0x05] = X86_OP_ENTRY2(ADD, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x06] = X86_OP_ENTRYr(PUSH, ES, w, chk(i64)),
+    [0x07] = X86_OP_ENTRYw(POP, ES, w, chk(i64)),
+
+    [0x10] = X86_OP_ENTRY2(ADC, E,b, G,b, lock),
+    [0x11] = X86_OP_ENTRY2(ADC, E,v, G,v, lock),
+    [0x12] = X86_OP_ENTRY2(ADC, G,b, E,b, lock),
+    [0x13] = X86_OP_ENTRY2(ADC, G,v, E,v, lock),
+    [0x14] = X86_OP_ENTRY2(ADC, 0,b, I,b, lock),   /* AL, Ib */
+    [0x15] = X86_OP_ENTRY2(ADC, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x16] = X86_OP_ENTRYr(PUSH, SS, w, chk(i64)),
+    [0x17] = X86_OP_ENTRYw(POP, SS, w, chk(i64)),
+
+    [0x20] = X86_OP_ENTRY2(AND, E,b, G,b, lock),
+    [0x21] = X86_OP_ENTRY2(AND, E,v, G,v, lock),
+    [0x22] = X86_OP_ENTRY2(AND, G,b, E,b, lock),
+    [0x23] = X86_OP_ENTRY2(AND, G,v, E,v, lock),
+    [0x24] = X86_OP_ENTRY2(AND, 0,b, I,b, lock),   /* AL, Ib */
+    [0x25] = X86_OP_ENTRY2(AND, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x26] = {},
+    [0x27] = X86_OP_ENTRY0(DAA, chk(i64)),
+
+    [0x30] = X86_OP_ENTRY2(XOR, E,b, G,b, lock),
+    [0x31] = X86_OP_ENTRY2(XOR, E,v, G,v, lock),
+    [0x32] = X86_OP_ENTRY2(XOR, G,b, E,b, lock),
+    [0x33] = X86_OP_ENTRY2(XOR, G,v, E,v, lock),
+    [0x34] = X86_OP_ENTRY2(XOR, 0,b, I,b, lock),   /* AL, Ib */
+    [0x35] = X86_OP_ENTRY2(XOR, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x36] = {},
+    [0x37] = X86_OP_ENTRY0(AAA, chk(i64)),
+
+    [0x40] = X86_OP_ENTRY1(INC, 0,v, chk(i64)),
+    [0x41] = X86_OP_ENTRY1(INC, 1,v, chk(i64)),
+    [0x42] = X86_OP_ENTRY1(INC, 2,v, chk(i64)),
+    [0x43] = X86_OP_ENTRY1(INC, 3,v, chk(i64)),
+    [0x44] = X86_OP_ENTRY1(INC, 4,v, chk(i64)),
+    [0x45] = X86_OP_ENTRY1(INC, 5,v, chk(i64)),
+    [0x46] = X86_OP_ENTRY1(INC, 6,v, chk(i64)),
+    [0x47] = X86_OP_ENTRY1(INC, 7,v, chk(i64)),
+
+    [0x50] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x51] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x52] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x53] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x54] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x55] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x56] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x57] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+
+
+    [0x08] = X86_OP_ENTRY2(OR, E,b, G,b, lock),
+    [0x09] = X86_OP_ENTRY2(OR, E,v, G,v, lock),
+    [0x0A] = X86_OP_ENTRY2(OR, G,b, E,b, lock),
+    [0x0B] = X86_OP_ENTRY2(OR, G,v, E,v, lock),
+    [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
+    [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
     [0x0F] = X86_OP_GROUP0(0F),
+
+    [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
+    [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
+    [0x1A] = X86_OP_ENTRY2(SBB, G,b, E,b, lock),
+    [0x1B] = X86_OP_ENTRY2(SBB, G,v, E,v, lock),
+    [0x1C] = X86_OP_ENTRY2(SBB, 0,b, I,b, lock),   /* AL, Ib */
+    [0x1D] = X86_OP_ENTRY2(SBB, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x1E] = X86_OP_ENTRYr(PUSH, DS, w, chk(i64)),
+    [0x1F] = X86_OP_ENTRYw(POP, DS, w, chk(i64)),
+
+    [0x28] = X86_OP_ENTRY2(SUB, E,b, G,b, lock),
+    [0x29] = X86_OP_ENTRY2(SUB, E,v, G,v, lock),
+    [0x2A] = X86_OP_ENTRY2(SUB, G,b, E,b, lock),
+    [0x2B] = X86_OP_ENTRY2(SUB, G,v, E,v, lock),
+    [0x2C] = X86_OP_ENTRY2(SUB, 0,b, I,b, lock),   /* AL, Ib */
+    [0x2D] = X86_OP_ENTRY2(SUB, 0,v, I,z, lock),   /* rAX, Iz */
+    [0x2E] = {},
+    [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
+
+    [0x38] = X86_OP_ENTRYrr(SUB, E,b, G,b),
+    [0x39] = X86_OP_ENTRYrr(SUB, E,v, G,v),
+    [0x3A] = X86_OP_ENTRYrr(SUB, G,b, E,b),
+    [0x3B] = X86_OP_ENTRYrr(SUB, G,v, E,v),
+    [0x3C] = X86_OP_ENTRYrr(SUB, 0,b, I,b),   /* AL, Ib */
+    [0x3D] = X86_OP_ENTRYrr(SUB, 0,v, I,z),   /* rAX, Iz */
+    [0x3E] = {},
+    [0x3F] = X86_OP_ENTRY0(AAS, chk(i64)),
+
+    [0x48] = X86_OP_ENTRY1(DEC, 0,v, chk(i64)),
+    [0x49] = X86_OP_ENTRY1(DEC, 1,v, chk(i64)),
+    [0x4A] = X86_OP_ENTRY1(DEC, 2,v, chk(i64)),
+    [0x4B] = X86_OP_ENTRY1(DEC, 3,v, chk(i64)),
+    [0x4C] = X86_OP_ENTRY1(DEC, 4,v, chk(i64)),
+    [0x4D] = X86_OP_ENTRY1(DEC, 5,v, chk(i64)),
+    [0x4E] = X86_OP_ENTRY1(DEC, 6,v, chk(i64)),
+    [0x4F] = X86_OP_ENTRY1(DEC, 7,v, chk(i64)),
+
+    [0x58] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x59] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5A] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5B] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5C] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5D] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5E] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5F] = X86_OP_ENTRYw(POP, LoBits,d64),
 };
 
 #undef mmx
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0e00f6635dd..a64186b8957 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -352,6 +352,20 @@ static void prepare_update2_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
     decode->cc_op = op;
 }
 
+static void prepare_update_cc_incdec(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    gen_compute_eflags_c(s, s->T1);
+    prepare_update2_cc(decode, s, op);
+}
+
+static void prepare_update3_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op, TCGv reg)
+{
+    decode->cc_src2 = reg;
+    decode->cc_src = s->T1;
+    decode->cc_dst = s->T0;
+    decode->cc_op = op;
+}
+
 static void gen_store_sse(DisasContext *s, X86DecodedInsn *decode, int src_ofs)
 {
     MemOp ot = decode->op[0].ot;
@@ -1040,6 +1054,37 @@ static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 VSIB_AVX(VPGATHERD, vpgatherd)
 VSIB_AVX(VPGATHERQ, vpgatherq)
 
+static void gen_AAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_aaa(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_AAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_aas(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_ADC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+    TCGv c_in = tcg_temp_new();
+
+    gen_compute_eflags_c(s, c_in);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_add_tl(s->T0, c_in, s->T1);
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+        tcg_gen_add_tl(s->T0, s->T0, c_in);
+    }
+    prepare_update3_cc(decode, s, CC_OP_ADCB + ot, c_in);
+}
+
 /* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
 static void gen_ADCOX(DisasContext *s, CPUX86State *env, MemOp ot, int cc_op)
 {
@@ -1093,11 +1138,37 @@ static void gen_ADCX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_ADCOX(s, env, decode->op[0].ot, CC_OP_ADCX);
 }
 
+static void gen_ADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update2_cc(decode, s, CC_OP_ADDB + ot);
+}
+
 static void gen_ADOX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_ADCOX(s, env, decode->op[0].ot, CC_OP_ADOX);
 }
 
+static void gen_AND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_and_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_and_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
+}
+
 static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1331,6 +1402,34 @@ static void gen_CVTTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
+static void gen_DAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_daa(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_DAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_das(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_DEC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    tcg_gen_movi_tl(s->T1, -1);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update_cc_incdec(decode, s, CC_OP_DECB + ot);
+}
+
 static void gen_EMMS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_emms(tcg_env);
@@ -1349,6 +1448,20 @@ static void gen_EXTRQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    tcg_gen_movi_tl(s->T1, 1);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update_cc_incdec(decode, s, CC_OP_INCB + ot);
+}
+
 static void gen_INSERTQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
@@ -1501,6 +1614,19 @@ static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_or_fetch_tl(s->T0, s->A0, s->T1,
+                                   s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_or_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
+}
+
 static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1744,6 +1870,18 @@ static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
+static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = gen_pop_T0(s);
+    if (decode->op[0].has_ea) {
+        /* NOTE: order is important for MMU exceptions */
+        gen_op_st_v(s, ot, s->T0, s->A0);
+        decode->op[0].unit = X86_OP_SKIP;
+    }
+    /* NOTE: writing back registers after update is important for pop %sp */
+    gen_pop_update(s, ot);
+}
+
 static void gen_PSHUFW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1890,6 +2028,11 @@ static void gen_PSLLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
+static void gen_PUSH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_push_v(s, s->T1);
+}
+
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1924,6 +2067,28 @@ static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv c_in = tcg_temp_new();
+
+    gen_compute_eflags_c(s, c_in);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_add_tl(s->T0, s->T1, c_in);
+        tcg_gen_neg_tl(s->T0, s->T0);
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        /*
+         * TODO: SBB reg, reg could use gen_prepare_eflags_c followed by
+         * negsetcond, and CC_OP_SUBB as the cc_op.
+         */
+        tcg_gen_sub_tl(s->T0, s->T0, s->T1);
+        tcg_gen_sub_tl(s->T0, s->T0, c_in);
+    }
+    prepare_update3_cc(decode, s, CC_OP_SBBB + ot, c_in);
+}
+
 static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
@@ -2011,6 +2176,22 @@ static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
 
+static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_neg_tl(s->T0, s->T1);
+        tcg_gen_atomic_fetch_add_tl(s->cc_srcT, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+        tcg_gen_sub_tl(s->T0, s->cc_srcT, s->T1);
+    } else {
+        tcg_gen_mov_tl(s->cc_srcT, s->T0);
+        tcg_gen_sub_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update2_cc(decode, s, CC_OP_SUBB + ot);
+}
+
 static void gen_VAESIMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     assert(!s->vex_l);
@@ -2490,3 +2671,24 @@ static void gen_VZEROUPPER(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
         tcg_gen_gvec_dup_imm(MO_64, offset, 16, 16, 0);
     }
 }
+
+static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    /* special case XOR reg, reg */
+    if (decode->op[1].unit == X86_OP_INT &&
+        decode->op[2].unit == X86_OP_INT &&
+        decode->op[1].n == decode->op[2].n) {
+        tcg_gen_movi_tl(s->T0, 0);
+        decode->cc_op = CC_OP_CLR;
+    } else {
+        MemOp ot = decode->op[1].ot;
+
+        if (s->prefix & PREFIX_LOCK) {
+            tcg_gen_atomic_xor_fetch_tl(s->T0, s->A0, s->T1,
+                                        s->mem_index, ot | MO_LE);
+        } else {
+            tcg_gen_xor_tl(s->T0, s->T0, s->T1);
+        }
+        prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
+    }
+}
-- 
2.44.0


