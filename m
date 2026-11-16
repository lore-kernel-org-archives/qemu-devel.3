Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2EC606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kHpk8Zb/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Lk-0000Br-Ol; Mon, 16 Nov 2026 15:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KR-0007mU-Oi; Mon, 16 Nov 2026 15:29:30 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KO-0001fZ-7x; Mon, 16 Nov 2026 15:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=SDPdW7HDE9NnibewVIOHtjaVG7JiD0OXNontjy430ms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kHpk8Zb/uqNdDASKYJ9ObSVsPTCw0YzeMJ6AQsH8UF/fAODw+hoFYtnda18cQKFPg
 UyV04L69g2cvrmC3uhlj+LO5l5PzF2nG08v1Uj6gd+U3BFSH4PjehIDYZYmnF/7sdw
 DLzxXXUOZJp7+QQg1mWndbwQMJJEvg0UfRmgGerfKvRyok8AsICiwdn5xSUW2SynHR
 0ZR86PGncF7RaYu/yrraGio59xZk8mwrpXhecHFXz52xVcyWX3R3SYF8G/SEknK/iD
 FrM2luAWbT/1r4NEFQe60eGlK8e3bGebHHhNE/hlag1wuLPXHEzKhViWFb1qIQdImr
 zhlmon0j2PfEA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E6C31E71BB;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B74245FBE7;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 36B71B8E92; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 38/63] target/i386/tcg: reject VEX.NP for MMX
 instructions
Date: Mon, 16 Nov 2026 23:25:17 +0300
Message-ID: <20261116202554.535325-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Paolo Bonzini <pbonzini@redhat.com>

MMX instructions do not have a VEX encoding, so reject VEX instructions
with no prefix for instructions that use X86_SPECIAL_MMX.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9f94fd68c89bed9bd59019a0bb2ad7d2e5458bcf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ebd2905cf42..5532ed0d7e0 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2134,6 +2134,12 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     decode->mem = (AddressParts){ def_seg, base, index, scale, disp };
 }
 
+static bool is_mmx(const DisasContext *s, const X86OpEntry *e)
+{
+    return (e->special == X86_SPECIAL_MMX &&
+            !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA)));
+}
+
 static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp *ot)
 {
     switch (size) {
@@ -2179,8 +2185,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         return true;
 
     case X86_SIZE_dq: /* SSE/AVX 128-bit */
-        if (e->special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, e)) {
             *ot = MO_64;
             return true;
         }
@@ -2198,8 +2203,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         return true;
 
     case X86_SIZE_x:  /* 128/256-bit, based on operand size */
-        if (e->special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, e)) {
             *ot = MO_64;
             return true;
         }
@@ -2294,8 +2298,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         goto get_reg;
 
     case X86_TYPE_V:  /* reg in the modrm byte selects an XMM/YMM register */
-        if (decode->e.special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, &decode->e)) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
@@ -2316,8 +2319,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         goto get_modrm;
 
     case X86_TYPE_W:  /* XMM/YMM modrm operand */
-        if (decode->e.special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, &decode->e)) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
@@ -2329,8 +2331,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         goto get_modrm_reg;
 
     case X86_TYPE_U:  /* R/M in the modrm byte selects an XMM/YMM register */
-        if (decode->e.special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, &decode->e)) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
@@ -2656,12 +2657,15 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     case 4:
     case 5:
     case 7:
-        if (s->prefix & PREFIX_VEX) {
+        if (is_mmx(s, e)) {
+            if (s->prefix & PREFIX_VEX) {
+                goto illegal;
+            }
+        } else if (s->prefix & PREFIX_VEX) {
             if (!(s->flags & HF_AVX_EN_MASK)) {
                 goto illegal;
             }
-        } else if (e->special != X86_SPECIAL_MMX ||
-                   (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+        } else {
             if (!(s->flags & HF_OSFXSR_MASK)) {
                 goto illegal;
             }
@@ -3100,8 +3104,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
     }
 
-    if (decode.e.special == X86_SPECIAL_MMX &&
-        !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+    if (is_mmx(s, &decode.e)) {
         gen_helper_enter_mmx(tcg_env);
     }
 
-- 
2.47.3


