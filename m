Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C1BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 09:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxc6-0001pp-6b; Thu, 08 May 2025 05:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxc4-0001nF-Bz
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxc2-0007Qx-79
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746696736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=noFvtkyaeag2yxJ5yTuYZsKunRo2E4M9+rBaAMqfYe0=;
 b=IVkyy57bc0WSTEFC106Z/Kejr+ITJpmeos+BrrkXWo7du3DvuM5MUYdt1hZYWPWEdivSAv
 BwLNmMBEsp2RfJN9JrJbixwij5Pby/8sf1kKs8PpFTNqG+W8FrjR8OfJn9Ykf9PGDXEaYz
 Q+KmbkMwmjvHXLtygHO4H7sUhY2RnmY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-CKDEZjl9MT6bNqiV3K5bmA-1; Thu, 08 May 2025 05:32:14 -0400
X-MC-Unique: CKDEZjl9MT6bNqiV3K5bmA-1
X-Mimecast-MFC-AGG-ID: CKDEZjl9MT6bNqiV3K5bmA_1746696734
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so4222665e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 02:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746696733; x=1747301533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=noFvtkyaeag2yxJ5yTuYZsKunRo2E4M9+rBaAMqfYe0=;
 b=GtcGq0stTZQ1DKMZslCSK0mMN/TPV/7qq+QVbgk2+hwhYXeToXu9tXZejHLtDymUPg
 SsP9cWIPhrtfXZ8R0jntADMj1tpF0MMm8ur0ITqaZ53OVaQA00BxUxf/X6cAE4nPPYv8
 /nSVPpCxNyPUzsxDE/bDQ8DUbkJb5l/XemChKHKe17KhK5UE/WCeaOxZ1d1fsIg5Lowz
 BX4nj6xLjYM2K2bQfmZrE7CuSbXjCO8p3O8lW1uIyn2dDV+Xzbw1BaMNMroyIkIAT6Rl
 L6sYeV+L7HcolOql8JARN5rQGzwAqgIw2AgYXWJZHAIvrHIEEBOpdcJefcYKiusTd360
 Lr5A==
X-Gm-Message-State: AOJu0YznIvO6g1A4uY6xtLIrHjbYskjUS27zFn06FRM802x07s3JrnsE
 s23j71IhU4dq5NQSXfkh3XyRG40ain44K80jWs7lAO5K7hneWDMfgXLmE6ouecTOFiiqyi0kdIX
 dOeAUTTBtvEPq3Q+JlSyWOHbsNu6g5qq1UOD6A8BPaeuMZ4kjs3rEjon1ipWgWvi+6GTLOmqJNs
 15hzGPx7X3c67hEaDf2i7kQ+IL/w37brvcVDI5
X-Gm-Gg: ASbGncupuflyv0cr05j/we4eW/TP1MeqvQvi5p8+zvVUTFt/ibKNgNtledjqxP1/txn
 BlpAp7W5q/HEr3cetrXeCorKPT3JmdxqczfIPM24igHzNR/ZhVM2C4U77vHe+55eRHEV7bNHF3H
 qYGgZIH6avKA8Bd3cOKtaD2/rI4erfdGqznUKiMHBukDMwsRG6H4YCR/MYHBiivGVfUAepkSxXV
 zzIFI8iqKvFsS0Skx8v7U4disFnyTQeqJzu7MiUH4oM6QoyOInWmwtAZE8m5GbqN78O7CHMTi6T
 Wi8a+RDTIpMfoKs=
X-Received: by 2002:a05:600c:8889:10b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-441d4f3e5famr36256525e9.13.1746696733166; 
 Thu, 08 May 2025 02:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2aFTuMJ4MsBcZsFDP8Cm2sDxBcBq97CmNjv4S6nU7KP43VlsVTF4HMdxoamkCbkLYcA6YrQ==
X-Received: by 2002:a05:600c:8889:10b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-441d4f3e5famr36256265e9.13.1746696732679; 
 Thu, 08 May 2025 02:32:12 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeca5sm31292255e9.26.2025.05.08.02.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 02:32:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [PATCH backport] target/i386: do not trigger IRQ shadow for LSS
Date: Thu,  8 May 2025 11:32:11 +0200
Message-ID: <20250508093211.463592-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Because LSS need not trigger an IRQ shadow, gen_movl_seg can't just use
the destination register to decide whether to inhibit IRQs.  Add an
argument.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        It is not a major bug, so apply it wherever it does not
        have conflicts.

 target/i386/tcg/translate.c | 33 ++++++++++++++++++++-------------
 target/i386/tcg/emit.c.inc  |  4 ++--
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487aa..390018fdec2 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1992,25 +1992,32 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 
 /* move SRC to seg_reg and compute if the CPU state may change. Never
    call this function with seg_reg == R_CS */
-static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
+static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit_irq)
 {
     if (PE(s) && !VM86(s)) {
-        tcg_gen_trunc_tl_i32(s->tmp2_i32, src);
-        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), s->tmp2_i32);
-        /* abort translation because the addseg value may change or
-           because ss32 may change. For R_SS, translation must always
-           stop as a special handling must be done to disable hardware
-           interrupts for the next instruction */
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        } else if (CODE32(s) && seg_reg < R_FS) {
+        TCGv_i32 sel = tcg_temp_new_i32();
+
+        tcg_gen_trunc_tl_i32(sel, src);
+        gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
+
+        /* For move to DS/ES/SS, the addseg or ss32 flags may change.  */
+        if (CODE32(s) && seg_reg < R_FS) {
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
         gen_op_movl_seg_real(s, seg_reg, src);
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        }
+    }
+
+    /*
+     * For MOV or POP to SS (but not LSS) translation must always
+     * stop as a special handling must be done to disable hardware
+     * interrupts for the next instruction.
+     *
+     * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
+     * might have been set above.
+     */
+    if (inhibit_irq) {
+        s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
     }
 }
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24f..b4dcb46e810 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -352,7 +352,7 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         break;
     case X86_OP_SEG:
         /* Note that gen_movl_seg takes care of interrupt shadow and TF.  */
-        gen_movl_seg(s, op->n, s->T0);
+        gen_movl_seg(s, op->n, v, op->n == R_SS);
         break;
     case X86_OP_INT:
         if (op->has_ea) {
@@ -2372,7 +2372,7 @@ static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
     gen_op_ld_v(s, MO_16, s->T1, s->A0);
 
     /* load the segment here to handle exceptions properly */
-    gen_movl_seg(s, seg, s->T1);
+    gen_movl_seg(s, seg, s->T1, false);
 }
 
 static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
-- 
2.49.0


