Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D4C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lFg-0000mZ-FW; Wed, 22 May 2024 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9lFe-0000lw-55
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9lFb-0007Gg-CU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716381561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kuaO9TvwL7G52FyoeqHZARswvg147nXEE6VOIREeSxU=;
 b=Rr9/cZG5mTODg9Lq+YVmLCTjKWOkEn4nADIP7Uac9fBpHvR4PWs/ENsDqQLQUKA5uMyBt1
 xyxhoo7FxI/q19sT6U6UdYkA7sRfBc7GyZO5YwRW/iuT+H6SAG+aS+IMFtdbgFGVFGLmKm
 ZaGl91Tj0QIfK6nL05ai3B80B+aet8I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-_-M0oIhpMymdZwcGwgsLRA-1; Wed, 22 May 2024 08:39:19 -0400
X-MC-Unique: _-M0oIhpMymdZwcGwgsLRA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a63a1f78so59303166b.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716381557; x=1716986357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kuaO9TvwL7G52FyoeqHZARswvg147nXEE6VOIREeSxU=;
 b=w/UxWZrsYHLGjGWISKiuPSPiFYG9rbPut+d80MGrE3sqW1AZNlb00aTe7+DjrSshMJ
 uFGzGZetIXFZV6j3QrnWtffbBol9Kmcu4b13KO/Yp7jNuDLoK4sFZZF+gg7mret9Eggz
 qNixVnU+/tUdX4M+GbVngKhZGYfLeYgHvJtFhPb4bcF916ZW+RmY2zSkzDrVyoVHXZF/
 WBTBldeZsQT63vAJk4PmBT9CrAOsXq1VYz3dEmy2zLO2vXngvGN05D6hlj0cYm8mdq+o
 fItnXGR+4VUbZZgXGWQM3vlaR43XsMAU2zMh2INxdFxx3oC73QYtaCj34pgNhkCffral
 baEg==
X-Gm-Message-State: AOJu0YxenKbxbBal894u/l6I3nlzdqs3VodQlbH1r2OgKIeoXPolK4KZ
 ZP1LvZsMVHByLhv1RC+PZvbeCOkCycdHCUFs8IfuUeUw4J1vsJH/gmOJA4IQF7BjkoaccMN3Rys
 GwSQR1oMJ75BbFUXJAeWzPDPe9Nk2ldSeuFztUaLwlflApZUFA7xB8xsKu0ZrNUChEk/tp9xO+J
 oUAQO9aH/B7wLdhr4vu3iRDpgj4iyihjFlLeSu
X-Received: by 2002:a17:906:aad1:b0:a59:a7b7:2b8e with SMTP id
 a640c23a62f3a-a622809afbdmr111389366b.29.1716381557433; 
 Wed, 22 May 2024 05:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwUl8s4dEG4rCRCjlJ7pJdQEwGuDK6mZPyEUy+LFKTnkFbR6aE5tXFqbm6iJSsQkJIMCY4PA==
X-Received: by 2002:a17:906:aad1:b0:a59:a7b7:2b8e with SMTP id
 a640c23a62f3a-a622809afbdmr111388066b.29.1716381557028; 
 Wed, 22 May 2024 05:39:17 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891fefsm1778802066b.62.2024.05.22.05.39.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 05:39:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: generate simpler code for ROL/ROR with immediate
 count
Date: Wed, 22 May 2024 14:39:14 +0200
Message-ID: <20240522123914.608516-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
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

gen_rot_carry and gen_rot_overflow are meant to be called with count == NULL
if the count cannot be zero.  However this is not done in gen_ROL and gen_ROR,
and writing everywhere "can_be_zero ? count : NULL" is burdensome and less
readable.  Just pass can_be_zero as a separate argument.

gen_RCL and gen_RCR use a conditional branch to skip the computation
if count is zero, so they can pass false unconditionally to gen_rot_overflow.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ecfdeb1e668..c78e35b1e28 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2901,14 +2901,15 @@ static bool gen_eflags_adcox(DisasContext *s, X86DecodedInsn *decode, bool want_
     return got_cf;
 }
 
-static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old, TCGv count)
+static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old,
+                             bool can_be_zero, TCGv count)
 {
     MemOp ot = decode->op[0].ot;
-    TCGv temp = count ? tcg_temp_new() : decode->cc_src2;
+    TCGv temp = can_be_zero ? tcg_temp_new() : decode->cc_src2;
 
     tcg_gen_xor_tl(temp, old, result);
     tcg_gen_extract_tl(temp, temp, (8 << ot) - 1, 1);
-    if (count) {
+    if (can_be_zero) {
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src2, count, tcg_constant_tl(0),
                            decode->cc_src2, temp);
     }
@@ -3000,7 +3001,7 @@ static void gen_RCL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     /* Compute result and outgoing overflow */
     tcg_gen_mov_tl(decode->cc_src2, s->T0);
     tcg_gen_or_tl(s->T0, low, high);
-    gen_rot_overflow(decode, s->T0, decode->cc_src2, NULL);
+    gen_rot_overflow(decode, s->T0, decode->cc_src2, false, NULL);
 
     if (zero_label) {
         gen_set_label(zero_label);
@@ -3053,7 +3054,7 @@ static void gen_RCR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     /* Compute result and outgoing overflow */
     tcg_gen_mov_tl(decode->cc_src2, s->T0);
     tcg_gen_or_tl(s->T0, low, high);
-    gen_rot_overflow(decode, s->T0, decode->cc_src2, NULL);
+    gen_rot_overflow(decode, s->T0, decode->cc_src2, false, NULL);
 
     if (zero_label) {
         gen_set_label(zero_label);
@@ -3129,9 +3130,10 @@ static TCGv_i32 gen_rot_replicate(MemOp ot, TCGv in)
     }
 }
 
-static void gen_rot_carry(X86DecodedInsn *decode, TCGv result, TCGv count, int bit)
+static void gen_rot_carry(X86DecodedInsn *decode, TCGv result,
+                          bool can_be_zero, TCGv count, int bit)
 {
-    if (count == NULL) {
+    if (!can_be_zero) {
         tcg_gen_extract_tl(decode->cc_dst, result, bit, 1);
     } else {
         TCGv temp = tcg_temp_new();
@@ -3165,8 +3167,8 @@ static void gen_ROL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     } else {
         tcg_gen_rotl_tl(s->T0, s->T0, count);
     }
-    gen_rot_carry(decode, s->T0, count, 0);
-    gen_rot_overflow(decode, s->T0, old, count);
+    gen_rot_carry(decode, s->T0, can_be_zero, count, 0);
+    gen_rot_overflow(decode, s->T0, old, can_be_zero, count);
 }
 
 static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -3190,12 +3192,12 @@ static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
         tcg_gen_rotr_i32(temp32, temp32, count32);
         /* Zero extend to facilitate later optimization.  */
         tcg_gen_extu_i32_tl(s->T0, temp32);
-        gen_rot_carry(decode, s->T0, count, 31);
+        gen_rot_carry(decode, s->T0, can_be_zero, count, 31);
     } else {
         tcg_gen_rotr_tl(s->T0, s->T0, count);
-        gen_rot_carry(decode, s->T0, count, TARGET_LONG_BITS - 1);
+        gen_rot_carry(decode, s->T0, can_be_zero, count, TARGET_LONG_BITS - 1);
     }
-    gen_rot_overflow(decode, s->T0, old, count);
+    gen_rot_overflow(decode, s->T0, old, can_be_zero, count);
 }
 
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
-- 
2.45.1


