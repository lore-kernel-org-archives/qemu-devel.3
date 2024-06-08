Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE833C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrdu-0001Wu-TI; Sat, 08 Jun 2024 04:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrds-0001St-Ql
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdr-0001Ng-4u
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMwm5EoQWR8WwwQOBghJk+ePxHBVZNeMzC33/BhJzSI=;
 b=V7xXG90ZFcpP40DRzZXKtupjGY/Ko6Kli/+FF3B7G5CbyY3Si38+7i5KazxzTzv1qCVvNu
 ywE4sw7U60Qm3jNw4yambFUG2zZ/0/72t7rk4N9qDwP37qOGPVXKcSuqCxLSNjDLpXxzre
 tUq53NZKno8a1ExgtITYzgiHVxkm3aQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-COt33wvdOqWvKEDzA5UGqQ-1; Sat, 08 Jun 2024 04:41:36 -0400
X-MC-Unique: COt33wvdOqWvKEDzA5UGqQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6f0f008f9aso2540166b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836095; x=1718440895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMwm5EoQWR8WwwQOBghJk+ePxHBVZNeMzC33/BhJzSI=;
 b=Dwx4jBNmg9iYYJ7vFmR7xEQKE4APNXVZZPdojKiSUsitguzDQWxVMmiHTfh4Y9hnyD
 GgHPzpJzgKI2JhtqhSs7X5yyAxi5Vd3CBEZmQHZ1YCq0VKeQjnFfA3UafK2PWPBGKZpu
 QQ1zJJqAjcxfiLMT7muGOeHllNJz99Fg4+UOAoPNHYnfuQgYit2Waqb42xznmQZG/erL
 5TXLWkjZgGtGryRGANu+z4xA/U//HCIkhje7kQQEL2dPXxmrBlTemr+SLkWmDBc6ZSEb
 mZ+GzDEVlkmzSi1EdeEuL6sM85uO/6r2PANtWSztHiww43sMDOWS7h7CPEFSe/DLvt1s
 8u0w==
X-Gm-Message-State: AOJu0YyBl/ZjhMVhog/TtdONa+jF+vOiqzA5DGBa1qYcmGnKtjjz8Gts
 RPFOzfBeXqoZdVR5tjAfSxhxLghNaZiPnCdJiy77n4w2NvVdT913MpcK0mlkYRy2N/2Whuynb2T
 9vwF41TklkYoyfaYiYLTSuKAK2qMdUr8Nl7Aig/y7tvg2rS+bo6w+3pg3ouEEU60/cywOVID9A7
 A9y4DUZR8S2iQRrUm+czGlmUONyuNjQ62rsw0O
X-Received: by 2002:a50:d7ca:0:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-57c50861ae8mr3510745a12.5.1717836094823; 
 Sat, 08 Jun 2024 01:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLQ+iKIHvNgnv55Yco+FipE5yyOJ/2Pz4LC+niCyi2r1u6X7QaSd0tbDEz7YxulKizGSQ9kg==
X-Received: by 2002:a50:d7ca:0:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-57c50861ae8mr3510740a12.5.1717836094394; 
 Sat, 08 Jun 2024 01:41:34 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ca5e3sm3937038a12.25.2024.06.08.01.41.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/25] target/i386: change X86_ENTRYwr to use T0,
 use it for moves
Date: Sat,  8 Jun 2024 10:40:53 +0200
Message-ID: <20240608084113.2770363-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Just like X86_ENTRYr, X86_ENTRYwr is easily changed to use only T0.
In this case, the motivation is to use it for the MOV instruction
family.  The case when you need to preserve the input value is the
odd one, as it is used basically only for BLS* instructions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 48 ++++++++++++++++----------------
 target/i386/tcg/emit.c.inc       |  2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f9d3e2577b2..d41002e2f5c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -180,7 +180,7 @@
 #define X86_OP_ENTRYrr(op, op0, s0, op1, s1, ...)                 \
     X86_OP_ENTRY3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRYwr(op, op0, s0, op1, s1, ...)                 \
-    X86_OP_ENTRY3(op, op0, s0, None, None, op1, s1, ## __VA_ARGS__)
+    X86_OP_ENTRY3(op, op0, s0, op1, s1, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRY2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_ENTRY3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRYw(op, op0, s0, ...)                           \
@@ -612,15 +612,15 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 /* five rows for no prefix, 66, F3, F2, 66+F2  */
 static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
     [0] = {
-        X86_OP_ENTRY3(MOVBE, G,y, M,y, None,None, cpuid(MOVBE)),
-        X86_OP_ENTRY3(MOVBE, G,w, M,w, None,None, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,y, M,y, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,w, M,w, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
     },
     [1] = {
-        X86_OP_ENTRY3(MOVBE, M,y, G,y, None,None, cpuid(MOVBE)),
-        X86_OP_ENTRY3(MOVBE, M,w, G,w, None,None, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,y, G,y, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,w, G,w, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,y, cpuid(SSE42)),
         X86_OP_ENTRY2(CRC32, G,d, E,w, cpuid(SSE42)),
@@ -1586,18 +1586,18 @@ static const X86OpEntry opcodes_root[256] = {
     [0x7E] = X86_OP_ENTRYr(Jcc, J,b),
     [0x7F] = X86_OP_ENTRYr(Jcc, J,b),
 
-    [0x88] = X86_OP_ENTRY3(MOV, E,b, G,b, None, None),
-    [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
-    [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
-    [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
-    /* Missing in Table A-2: memory destination is always 16-bit.  */
-    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None, op0_Mw),
-    [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
-    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,w, None, None),
+    [0x88] = X86_OP_ENTRYwr(MOV, E,b, G,b),
+    [0x89] = X86_OP_ENTRYwr(MOV, E,v, G,v),
+    [0x8A] = X86_OP_ENTRYwr(MOV, G,b, E,b),
+    [0x8B] = X86_OP_ENTRYwr(MOV, G,v, E,v),
+     /* Missing in Table A-2: memory destination is always 16-bit.  */
+    [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
+    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, noseg),
+    [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
     [0x8F] = X86_OP_GROUPw(group1A, E,v),
 
     [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
-    [0x99] = X86_OP_ENTRY3(CWD,    2,v, 0,v, None, None), /* rDX, rAX */
+    [0x99] = X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
     [0x9A] = X86_OP_ENTRYrr(CALLF, I_unsigned,p, I_unsigned,w, chk(i64)),
     [0x9B] = X86_OP_ENTRY0(WAIT),
     [0x9C] = X86_OP_ENTRY0(PUSHF,  chk(vm86_iopl) svm(PUSHF)),
@@ -1607,22 +1607,22 @@ static const X86OpEntry opcodes_root[256] = {
 
     [0xA8] = X86_OP_ENTRYrr(AND, 0,b, I,b),   /* AL, Ib */
     [0xA9] = X86_OP_ENTRYrr(AND, 0,v, I,z),   /* rAX, Iz */
-    [0xAA] = X86_OP_ENTRY3(STOS, Y,b, 0,b, None, None),
-    [0xAB] = X86_OP_ENTRY3(STOS, Y,v, 0,v, None, None),
+    [0xAA] = X86_OP_ENTRYwr(STOS, Y,b, 0,b),
+    [0xAB] = X86_OP_ENTRYwr(STOS, Y,v, 0,v),
     /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
     [0xAC] = X86_OP_ENTRYr(LODS, X,b),
     [0xAD] = X86_OP_ENTRYr(LODS, X,v),
     [0xAE] = X86_OP_ENTRYrr(SCAS, 0,b, Y,b),
     [0xAF] = X86_OP_ENTRYrr(SCAS, 0,v, Y,v),
 
-    [0xB8] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xB9] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBA] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBB] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBC] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBD] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBE] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBF] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xB8] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xB9] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBA] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBB] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBC] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBD] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBE] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
 
     [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
     [0xC9] = X86_OP_ENTRY1(LEAVE, A,d64),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 797e6e81406..78d89db57cd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1796,7 +1796,7 @@ static void gen_IN(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[0].ot;
     TCGv_i32 port = tcg_temp_new_i32();
 
-    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_trunc_tl_i32(port, s->T0);
     tcg_gen_ext16u_i32(port, port);
     if (!gen_check_io(s, ot, port, SVM_IOIO_TYPE_MASK)) {
         return;
-- 
2.45.1


