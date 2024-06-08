Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0220C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrdm-0001L4-BX; Sat, 08 Jun 2024 04:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdl-0001KV-4D
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdj-0001NE-Gz
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+S5LnfQa8HuliJcdgec0NytFwCbzBU9w1gslYMiuR1g=;
 b=Hh8RbKGbuhNitAVll9CSsPJ8c2deM1R2Vpw04ndI+Z0C6gAhPeVVjGOMELGI3Gl1ev1jcP
 QPdU3mOL0Svprgc1NTTJhF4w5N9JpRR3Jee1R5nH22DXY1hbM1VcyTGah9GEbAEuz9uYU/
 OpVk4G8+Icjfsori7PUmlsuAlOiCC/E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-V23OToHLP42egWjbC6Jupg-1; Sat, 08 Jun 2024 04:41:29 -0400
X-MC-Unique: V23OToHLP42egWjbC6Jupg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6efe561b04so24403066b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836087; x=1718440887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+S5LnfQa8HuliJcdgec0NytFwCbzBU9w1gslYMiuR1g=;
 b=urCAjPMpS31A9Ob/RyNS4IQFmN1z5mkAz7oX3zAr28/os90GnVzB0tU+r+8VGpJY6f
 G31oaECD/ASBSh83dFnpMr+RymAvYFD2YSBlhmN3SEYIBuhaaNe6nhFjQxVvyk/8k10y
 7jaPw96e7dQ0KCt9dmI3JeVjboe+AfAvm5amPJtBBVCeuJkcQBnE2lktVtoD5SuFXDBy
 ytN1JIM2p1PA0m8cusVwkTlyub1H67eW0luUk0gdsaqQR4ctea58icY5wgN+9YlQPgqO
 POmPEIX4nUePLxtDvLB+JDPNuzrCO/DeqderpOX2DA5kqheKB4sZ8gm3nE+8ZXxOkQD/
 L5Xw==
X-Gm-Message-State: AOJu0YxwXqgoOGbhsu2oE+jEBaI0yPkNmwUYkbZxOBHw9k4hSBs8Sjpm
 c4bO7yfDyWSKWvVx0wwYs268bAwUe+JoaDY5mPEqzTvlMa+th8KFl3IYrZ3a7tMjQBlne6XUFyg
 +F6AyMIyQgbNRyARo7bKBNf8j07/B2hrk/sjIkm3tdkQoGVlWtaZxbZYUQ6LSC05nN1mUXZKZz2
 FQyK1IbKoY5G+StvVvPMtV3y6atHe/dDJA9qp9
X-Received: by 2002:a17:907:bb88:b0:a63:cd85:4d7b with SMTP id
 a640c23a62f3a-a6cdb00066fmr282583766b.62.1717836087189; 
 Sat, 08 Jun 2024 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHWeSRnnMPsCh19PhVvwzrWfzYSw6Ve4+4X9m8BQ16gZHV/W9jTQhnUsdb4CeciiN97SvL8A==
X-Received: by 2002:a17:907:bb88:b0:a63:cd85:4d7b with SMTP id
 a640c23a62f3a-a6cdb00066fmr282582666b.62.1717836086838; 
 Sat, 08 Jun 2024 01:41:26 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6eff899fbbsm59005066b.212.2024.06.08.01.41.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/25] target/i386: put BLS* input in T1,
 use generic flag writeback
Date: Sat,  8 Jun 2024 10:40:51 +0200
Message-ID: <20240608084113.2770363-4-pbonzini@redhat.com>
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

This makes for easier cpu_cc_* setup, and not using set_cc_op()
should come in handy if QEMU ever implements APX.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc |  4 ++--
 target/i386/tcg/emit.c.inc       | 24 +++++++++---------------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index e7d88020481..380fb793531 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -633,7 +633,7 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
         {},
     },
     [3] = {
-        X86_OP_GROUP3(group17, B,y, E,y, None,None, vex13 cpuid(BMI1)),
+        X86_OP_GROUP3(group17, B,y, None,None, E,y, vex13 cpuid(BMI1)),
         {},
         {},
         {},
@@ -2604,7 +2604,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     }
 
     /*
-     * Write back flags after last memory access.  Some newer ALU instructions, as
+     * Write back flags after last memory access.  Some older ALU instructions, as
      * well as SSE instructions, write flags in the gen_* function, but that can
      * cause incorrect tracking of CC_OP for instructions that write to both memory
      * and flags.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2041ea9d04a..a25b3dfc6b5 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1272,40 +1272,34 @@ static void gen_BEXTR(DisasContext *s, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
-/* BLSI do not have memory operands and can use set_cc_op.  */
 static void gen_BLSI(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
-    tcg_gen_mov_tl(cpu_cc_src, s->T0);
-    tcg_gen_neg_tl(s->T1, s->T0);
+    /* input in T1, which is ready for prepare_update2_cc  */
+    tcg_gen_neg_tl(s->T0, s->T1);
     tcg_gen_and_tl(s->T0, s->T0, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
-/* BLSMSK do not have memory operands and can use set_cc_op.  */
 static void gen_BLSMSK(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
-    tcg_gen_mov_tl(cpu_cc_src, s->T0);
-    tcg_gen_subi_tl(s->T1, s->T0, 1);
+    /* input in T1, which is ready for prepare_update2_cc  */
+    tcg_gen_subi_tl(s->T0, s->T1, 1);
     tcg_gen_xor_tl(s->T0, s->T0, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
-/* BLSR do not have memory operands and can use set_cc_op.  */
 static void gen_BLSR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
-    tcg_gen_mov_tl(cpu_cc_src, s->T0);
-    tcg_gen_subi_tl(s->T1, s->T0, 1);
+    /* input in T1, which is ready for prepare_update2_cc  */
+    tcg_gen_subi_tl(s->T0, s->T1, 1);
     tcg_gen_and_tl(s->T0, s->T0, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
 static void gen_BOUND(DisasContext *s, X86DecodedInsn *decode)
-- 
2.45.1


