Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97CBC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsO3D-0003KP-0a; Fri, 07 Aug 2026 13:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsO3A-0003KF-HL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:08:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsO38-0000ue-NB
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:08:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso2327037f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786122481; x=1786727281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m6DI6VN+i9gH8c76g9ZI/lgFcLQ0idQYpehU/lm657g=;
 b=feC1rnBsKvUt42QRdHtQ1iQuV8V5X7O1o+v5HMXgAazDgBBWoxnnDOAI8TNOSgP5LS
 1hXf5vJFBi6x+3yPNUGY7dVXT3mTTK9UDkqioZG75uTHy6QOyZtHQvfUWjGQTpPM9Ise
 UHiIJsvNJ8vqJf8VqmWUPzKoqk/uhQsL5lERKomgumcDoMw2P8hp8hDKI+aDUPj1CR3v
 PRdVmnrrwuFHuToooTSfns08nW1q/ucv3bA3eSQdFUSTt5ctJvA6+xaky1sKdW/aE6d0
 WYpKsGvov3Oiv1GnJZM0f7zE9q6mvL09V3PZLxhuYuucHpxfrS4oAlpInVG2I876GzCz
 QPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786122481; x=1786727281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m6DI6VN+i9gH8c76g9ZI/lgFcLQ0idQYpehU/lm657g=;
 b=Tht5HYn5/aal/WdqSn5jdr0ilAvrJMwbeDWfc66Z6iL9snkBCIB1Gi8dcZt2AZioYt
 qxt24An6/Li8TLd1bcz555QTgWLmK/ZFluJ9txJA1L37Y4Vjb2TIBpd3FotBNJJBQuNk
 BndkYHypvyak2SBhWWrfnCBkvWkPqDxyBj3No1sNf4BKBC+tAOPuTJ+TO60ezK7IN8Tp
 Ya4gz2hsUvR3YeaR9PWgNady19J3lBT4HQhK/QDpORmwPaPmx3CSl4I9kDonYF3Fe+BJ
 wrxbwzYaCVEVeGiI3ZFTlHrYHCImXSvonT990xqslXnGNgvBcWzktN4YsF33Hyzdb+KC
 t+Pg==
X-Gm-Message-State: AOJu0YwPbXjFn1M3B8YJoXvAflX3GIdkbQER0z84hRgI/l35F25TTWrJ
 DWQ1wXdq1W2M0ebGjHEUo23lpfutNY+YzrcbmhqDNEi54XTt2VJ8tYHcccJv8Bljc5Y=
X-Gm-Gg: AR+sD13dhh27vq5ScQuvx6BkPBb7USlcuFNUhFbLynhacSLvb+nGWIfo0HEQKyaoYJN
 BE8yc8I8wYNwb5AgStWzcDEc8O8YIcTQ+zFpZoVbl08Vtn42NpyDYPmFSXfzzUBWUl5spzCKE7E
 lG7rWSIm17+UVuQ3P93PBFxCylHy8FiqCROG8NfpNy7obdlHo+qgacI1mdLf69h88GsTfe9jWgf
 cNevNOdIVIKA1Td74X1YzFSm0o+tBnw4WfZFX6EXOt9PqtIv1mBzXbD1Lc2TvKpFGt20yxI6chM
 uzQEfILwBVUun693ZFYG7PcxAxrO4dZU/MNMnRg1T0AsENkIdHvIU9NLwDA9sL1pqFgMfGdMNwx
 iexcjuFvSzWZYZM60h9zRYzn57wsOHMR4rq9KsHZG7a+LSmrvM3dtVJv73nvq3CcE4eS17MJQoZ
 bOr8xhrDPaLxoz5n98vKjpLRtRrx2SsJITTsOP2b+hOoylF3rNXt86UplNWb0ZuGv9eQnqxkbjT
 +ay6vESyIL52J54lhtppRnAER5tFNyhhNBlps9qHzFDVxm7iMK7sr1c8sRLpbgAfKx0
X-Received: by 2002:a05:6000:2501:b0:47f:8b9e:f44e with SMTP id
 ffacd0b85a97d-48130eb0a58mr1682483f8f.12.1786122480856; 
 Fri, 07 Aug 2026 10:08:00 -0700 (PDT)
Received: from simon-macbookpro ([2001:4bc9:c011:7df5:c1e9:e2df:9c0e:29ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145971sm7137699f8f.8.2026.08.07.10.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 10:08:00 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH v2] target/i386: do not zero-extend BSR/BSF dest when source
 is zero
Date: Fri,  7 Aug 2026 19:07:51 +0200
Message-ID: <20260807170751.390792-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For the bsr and bsf instructions per the Intel SDM: "If the content
of the source operand is 0, the content of the destination operand
is undefined." The AMD64 Architecture Programmer's Manual is more
specific: it states the destination operand remains unchanged when
the source is zero. Testing on real hardware (multiple Intel and
AMD systems) confirms that when the source operand is zero, the CPU
leaves the entire 64-bit destination register untouched, including
the upper 32 bits, even when executing the 32-bit form of the
instruction (e.g. "bsr edx, ecx") in 64-bit mode.

gen_BSF()/gen_BSR() already encode this intent (see the existing
comment) by arranging for T0 to hold the correct full-width
passthrough value when the source is zero. However, that correct
value was then handed to the generic register writeback path
(gen_writeback), which for a 32-bit destination unconditionally
applies tcg_gen_ext32u_tl() and clears the upper 32 bits regardless
of what gen_BSF()/gen_BSR() had just computed.

Fix this at the operand-decode level instead: give the destination
(G) and its 2op copy the d64 size class instead of v, so gen_writeback
treats the write as full-width in the one case that was buggy (64-bit
mode, 32-bit operand size), leaving every other case unchanged. The
source (E) must stay v, or the decoder would scan the full 64-bit
source register instead of just its low 32 bits. No changes to
gen_BSF()/gen_BSR() are needed.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4132
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/decode-new.c.inc | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ac181308ca..85f9d27c56 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -659,12 +659,18 @@ static void decode_0FB8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* For BSF, pass 2op as the third operand so that we can use zextT0 */
+    /*
+     * For BSF, pass 2op as the third operand so that we can use zextT0.
+     * G/2op use d64 because ctz already zero-extends the full 64-bit result,
+     * and v would zero-extend the output register if the input is zero.
+     * E stays v: forcing it to d64 too would scan the full 64-bit register
+     * instead of just the 32-bit source.
+     */
     static const X86OpEntry opcodes_0FBC[4] = {
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0),
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
-        X86_OP_ENTRYwr(TZCNT, G,v, E,v,        zextT0), /* 0xf3 */
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+        X86_OP_ENTRY3(BSF,    G,d64, E,v, 2op,d64, zextT0),
+        X86_OP_ENTRY3(BSF,    G,d64, E,v, 2op,d64, zextT0), /* 0x66 */
+        X86_OP_ENTRYwr(TZCNT, G,v,   E,v,          zextT0), /* 0xf3 */
+        X86_OP_ENTRY3(BSF,    G,d64, E,v, 2op,d64, zextT0), /* 0xf2 */
     };
     if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
         *entry = opcodes_0FBC[0];
@@ -675,12 +681,18 @@ static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* For BSR, pass 2op as the third operand so that we can use zextT0 */
+    /*
+     * For BSR, pass 2op as the third operand so that we can use zextT0.
+     * G/2op use d64 because clz already zero-extends the full 64-bit result,
+     * and v would zero-extend the output register if the input is zero.
+     * E stays v: forcing it to d64 too would scan the full 64-bit register
+     * instead of just the 32-bit source.
+     */
     static const X86OpEntry opcodes_0FBD[4] = {
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0),
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
-        X86_OP_ENTRYwr(LZCNT, G,v, E,v,        zextT0), /* 0xf3 */
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+        X86_OP_ENTRY3(BSR,    G,d64, E,v, 2op,d64, zextT0),
+        X86_OP_ENTRY3(BSR,    G,d64, E,v, 2op,d64, zextT0), /* 0x66 */
+        X86_OP_ENTRYwr(LZCNT, G,v,   E,v,          zextT0), /* 0xf3 */
+        X86_OP_ENTRY3(BSR,    G,d64, E,v, 2op,d64, zextT0), /* 0xf2 */
     };
     if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
         *entry = opcodes_0FBD[0];
-- 
2.53.0


