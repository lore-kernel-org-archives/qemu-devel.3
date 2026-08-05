Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D89C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdNs-000234-Ly; Wed, 05 Aug 2026 11:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wrdNr-00022w-IW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:18:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wrdNp-0004UN-QQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:18:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso5924375e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943096; x=1786547896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IxGtx7jkjvRW+jALrr9QepDi17RseShRN6FfJzo8guM=;
 b=XoOBXMGSNyZM/AzIjjU/lSTy6m6FOxd47nkl/fvHkG+nPZ3jGNs21XXXYbXT3YUPHF
 C4Vn+gyBeC7kTXVKmyyNrHZybo/U/SDh7T4z/35FIZqVhs0Vh2MG1/O6opqGCkIvqixq
 lHT1zRL6AtM9k6u/WtdJ7tseGUy0pdCp/2vsSv5qyAyRCj7lfm0f9R6eKEx+XoGzJaQe
 wpiMn7h+OEtbabyz5oAJVsEFCwYSzEAH6imcKlbOuNtPDAf29lLi26Zb+yfdkug7ZVJQ
 htNs7cwfindURi1rAvvAIpsSXndaF/2HVA8TGQ52wsGk5uTyHO4eIBicb8f5+FT6Cp8H
 wt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943096; x=1786547896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IxGtx7jkjvRW+jALrr9QepDi17RseShRN6FfJzo8guM=;
 b=ZKio7nGoe5CQAOATfjd1a+X8IUXcpLr36Cn9/r36XF6JgeUj3U4ROKk06iIg7/oWut
 YH/UGF9HsM/A2q46wHAvRkOpJWD5uCpgNXfWMz7viPlPUl+DqmpLbNKutsVG+GDgDWXJ
 JzHJkSe/ysp6/nhtfMK198dEpFUbQzfs5RCzSF02x00nMP8eLz2ubqjalTgzcGgDXApI
 zhudfPRDuRSxmXYO5kxDydUbctX7yhXV4RETwDKTQcvpIapNpftOEl6KBLjJZXPDKKIv
 Ck848jpUNamq4nfgux0a38FNopjTkxwR6YJosxDi3InT4a9GOiD/e3asNUjpeuXVpkRZ
 tzxw==
X-Gm-Message-State: AOJu0Yx0WZyt792Jb826Qxf5s5XlfTmqu6icuckq4bMvs62LvCHOIUGH
 WT6rdqmjv23EWfRsYarmVaRyXAviOOTKPkztZcvdOpSUILxlowaahyz0jLa0ylQHB0Y=
X-Gm-Gg: AR+sD13odR37rqbkXNNwkAXuQ1E3Jtn11q2nGi5Q77/XAf9gHCaeJMz2GjD4HjaQsYr
 Mjcd9GrIkyaWz2aR/hihBBc6/bzcL5Ea65KqdXOJNz0BeYhK3AlRXhraiLCob6p22P30NJYI/Pw
 QvcwFaN1tVzCatvJ2HfYf+Tv30uooNt5P1hLgaWP227zvYYxtIzaLBMiz0x2tLIwuc641oY+Wtw
 YLW5DWQO1j9H5u2EtdVtwXmGj8GaUIOGwD/rtf0b1uSwZsUTqlgBf5rPI7XyCjdv4/QStqT75/C
 MlLPTmXdpQkLbsNoMV1DNcmiLSjOeoNsTXL3F9emP32exj3lsJ/KQQMQ34xwD15nfwfPQ7HhJ1F
 84QnCGTzjQH4CEjI9ez2YYYhIM/h3I2XGA0cq9QDiTxEbc5RM0iFA6OStsIA+StjFMN+PJlp3B0
 sjqBpSRj5NBwUAih7kgWXOx4pkz1ozI+gTi11sG2Yrug2ELxj10LLFvTmhi6RsYWfLQnRFhjB+j
 iWZEFXAst0De6csqyX08AYvgeeRGA+t1p4c2oGilNKFO7kaiikiG9yMnZY49t/k0NCLdoITfG+J
 7jL4cszF/GHlJ8mo5w85dajO04IqF0JExsf5RH0=
X-Received: by 2002:a05:600c:19cd:b0:498:519:e660 with SMTP id
 5b1f17b1804b1-4994e72f7b6mr91328785e9.4.1785943093585; 
 Wed, 05 Aug 2026 08:18:13 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-c122.tugraz.at.
 [129.27.234.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e536a14sm53090885e9.1.2026.08.05.08.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:18:13 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: do not zero-extend BSR/BSF dest when source is
 zero
Date: Wed,  5 Aug 2026 17:18:10 +0200
Message-ID: <20260805151810.369643-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x32e.google.com
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

This patch bypasses the generic writeback for this specific case
(64-bit mode, 32-bit operand size) and writes the already-correct
value directly to the register instead.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4132
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/emit.c.inc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 473f415766..c555ef49aa 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1409,6 +1409,17 @@ static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
      * by passing the output as the value to return upon zero.
      */
     tcg_gen_ctz_tl(s->T0, s->T0, s->T1);
+
+    /*
+     * Bypass the gen_writeback: for a 32-bit destination in 64-bit
+     * mode it would zero-extend the upper 32 bits, but T0 already holds
+     * the exact final register value for both the zero- and non-zero-
+     * source cases (see comment above).
+     */
+    if (CODE64(s) && ot == MO_32) {
+        tcg_gen_mov_tl(cpu_regs[decode->op[0].n], s->T0);
+        decode->op[0].unit = X86_OP_SKIP;
+    }
 }
 
 /* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
@@ -1431,6 +1442,12 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_xori_tl(s->T1, s->T1, TARGET_LONG_BITS - 1);
     tcg_gen_clz_tl(s->T0, s->T0, s->T1);
     tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
+
+    /* See gen_BSF() above. */
+    if (CODE64(s) && ot == MO_32) {
+        tcg_gen_mov_tl(cpu_regs[decode->op[0].n], s->T0);
+        decode->op[0].unit = X86_OP_SKIP;
+    }
 }
 
 static void gen_BSWAP(DisasContext *s, X86DecodedInsn *decode)
-- 
2.53.0


