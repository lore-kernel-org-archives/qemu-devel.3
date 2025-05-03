Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB1EC3ABAD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mb-00088o-FW; Sat, 03 May 2025 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mW-00086n-2Y
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mU-0006gN-1X
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQ62A3MCY62mWXW1oMyGxVt/pkkUQ6ezdwuuGxH7Rf0=;
 b=Ov5fwjMva2dZ3WXGuh53eWKusamtp5MhZNwX8e7XFmkMSp6Pb8Oa0UGKiEVVA3o5jfmjVG
 zubcMHR98yHEEl7RD0kP1G3L8Bct5Ap4/bQVPTez7Yfd7RoBMbXMILrlXU0lOpcLPun7TD
 +NhbTBBkCaW3HcmEHZTIhVMdAsF64hU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-aWv9OPSxPsKE6IdWLerNrw-1; Sat, 03 May 2025 03:59:27 -0400
X-MC-Unique: aWv9OPSxPsKE6IdWLerNrw-1
X-Mimecast-MFC-AGG-ID: aWv9OPSxPsKE6IdWLerNrw_1746259166
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so13461425e9.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259165; x=1746863965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQ62A3MCY62mWXW1oMyGxVt/pkkUQ6ezdwuuGxH7Rf0=;
 b=T+ciHMHULpVcswmWasl/fYeyxH490f75btGMWmjK4wDUK//CTkSqFG8X2tkDVmVCHV
 SbYAMsMYhlf+FqG9cutUanW18ldyXG8dKiH9Hc8lQrw5xjW71gzXcWY8jryKUB/zVaS/
 zlxluRE19/+kKUfvcgJEtB3H0S4hbe/y+WbSDI/iz1amWoTRIRTcs1e/mP/Anebhf2ua
 K0aFVKl/67ZOPj9svgdTllug6Qr9lhV/jU0Gg3qMrG5/yJDfAkd5TeqyKa1dhW+PLBek
 u5H/ldpNaD3lpoM1A619MZuSqa1MKvLvQ5zrs0nfrn5vd9cayJYP6sfBPW4+F5wvJ5WP
 o1yQ==
X-Gm-Message-State: AOJu0Yz5C1ViG1gtwWDWHEzjuRS362npdi00AgYM0gFWE6TGhz2Ukwoe
 ZAcrgiDEDT3BbN/uU9VeGg5q1vUD/ZEkc4rtznPD9b/GY7zPjflel5ykvhJPQuzA/6sdaNAY1B0
 bzDuhsilyZDQ4FqiPeRH5qE0rWdu9azOOmnCJPCcO5GC5ASDvRWIyducF4HFHHd2KpaKx6Lmn1Q
 2g4H0K9xSFc1qcC5kzEbQgKNPmvlGDNCsyqNfS
X-Gm-Gg: ASbGncuxHD9anNQQGw82jqF+oUQhZrBflMfyXXYXrMDiLq+/KuJZ7O5d12eqUsCp33s
 bh+titeLe51bh+s1cCUmcmBxFgMgh9EVS3KzdVkd1CsGlzRoj8Dri5XT37hpCOIaDp07KiFxohQ
 FKLALiF6PAe9Kdh/tc7yUrKwR7YnFWijw3tu9NPFwarTIDB628k6GRiPw2qamE1HmgA2UxC8/Tr
 DPlFU2Hn6fYonnLemDIyzRBRh+qOf7Yj80AwYEsc/kzcgfW4sy3yadz2ANpo7Q/LzS5xbnurCPs
 6jsUe5X8gxl3DUg=
X-Received: by 2002:a05:600c:34c3:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-441c48b0404mr1998175e9.6.1746259165603; 
 Sat, 03 May 2025 00:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIHvKHSSB81eDIixqHq/Zvp0mz1bwWI8osNGzApgcVe3ruCOlSZi/uTpxfNRzCQMgxPInfFw==
X-Received: by 2002:a05:600c:34c3:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-441c48b0404mr1998005e9.6.1746259165170; 
 Sat, 03 May 2025 00:59:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a31695sm67646245e9.40.2025.05.03.00.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 09/13] target/i386: do not trigger IRQ shadow for LSS
Date: Sat,  3 May 2025 09:58:54 +0200
Message-ID: <20250503075858.277375-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 target/i386/tcg/translate.c | 27 ++++++++++++++++-----------
 target/i386/tcg/emit.c.inc  |  4 ++--
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8a641951cd1..a4e935b043b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2026,27 +2026,32 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 
 /* move SRC to seg_reg and compute if the CPU state may change. Never
    call this function with seg_reg == R_CS */
-static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
+static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit_irq)
 {
     if (PE(s) && !VM86(s)) {
         TCGv_i32 sel = tcg_temp_new_i32();
 
         tcg_gen_trunc_tl_i32(sel, src);
         gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
-        /* abort translation because the addseg value may change or
-           because ss32 may change. For R_SS, translation must always
-           stop as a special handling must be done to disable hardware
-           interrupts for the next instruction */
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        } else if (CODE32(s) && seg_reg < R_FS) {
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
index e3166e70a5b..1a7fab9333a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -342,7 +342,7 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         break;
     case X86_OP_SEG:
         /* Note that gen_movl_seg takes care of interrupt shadow and TF.  */
-        gen_movl_seg(s, op->n, s->T0);
+        gen_movl_seg(s, op->n, v, op->n == R_SS);
         break;
     case X86_OP_INT:
         if (op->has_ea) {
@@ -2382,7 +2382,7 @@ static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
     gen_op_ld_v(s, MO_16, s->T1, s->A0);
 
     /* load the segment here to handle exceptions properly */
-    gen_movl_seg(s, seg, s->T1);
+    gen_movl_seg(s, seg, s->T1, false);
 }
 
 static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
-- 
2.49.0


