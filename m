Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F24FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwq9-0002u2-5S; Wed, 17 Jul 2024 01:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwq3-0002U0-GD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwq0-00023z-Hh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgJ+cIl6ZeRPyItJ8FIMr9ODJcaa5ZrbsqamH1sXMi8=;
 b=RwArKBSJYCYNEK8E+i3M3hohdkCjCU+Ao9c8Xw7sL9qwC2ReUL5uC2kkuMbhB6Ary0pu71
 26eaSpVIUdLODKwAVUUesJ1nQh64/f5IoxArRoYcEVjnqv8NlzOrNyNOROuWGN6TflC6bv
 vFOyhux3Nexhey5ZDqLt2UrIZXRqVjE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-bQCrSoO4Op-vt-YBFoEeWA-1; Wed, 17 Jul 2024 01:04:21 -0400
X-MC-Unique: bQCrSoO4Op-vt-YBFoEeWA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42671a6fb9dso41256465e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192660; x=1721797460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgJ+cIl6ZeRPyItJ8FIMr9ODJcaa5ZrbsqamH1sXMi8=;
 b=iISydYKPLJuVHwY4fXTd+0v7nDpYD94acVjvoDqtQu3sBEl8zsXOtCNJ6SHfKFCJ9D
 qqIIlQm4gSMiakYy935EPqkq4PSo91a3lzRSriSCGr46QK0fqjWDzYJn5OxhJAkrxBRK
 H8NWtoA3mCXDQQ4vxDOvXSJ+Gasa0S/G5Jtze2Sp2ziT+cSaavcvfLy571/cQVEh3ccM
 YjOzWYVnDp9wP6QBiXd1C7E0YNugg+3jsVn1hpfIybRz5f6EyGxbu/D7g4gdvtSQSWT7
 BomUedOJ1HIVqBxOm/KJzvzTPyHmI3ojG7N3YYS1RJm/Y+JW45Kii9lqdOR/FQD31HIa
 LDYg==
X-Gm-Message-State: AOJu0YziX+xCfum37SdTF1eCfI3DQ+LHxt6IXUgzOBp/wO5e481Lt5DT
 Rrf3r8r1E7dGZECWrriQRhTqeSOF/nEhUzdwsuZ5Q3tM4Sc0EK11tW3Q8bpoYv6S5uG4Q5dfd2d
 kMetEmNQyXNJozucqcQdkXC8Tl2AUoQoMezw3ENtsw07nryYPtjifqtizRKftBNbPP1c8lZu4RS
 pgDuY5K+dzo3nJPkWTH6LRpv4ChReH65Iwt/lh
X-Received: by 2002:a05:600c:3b8c:b0:427:abf6:f0e6 with SMTP id
 5b1f17b1804b1-427c2cb0878mr4119435e9.9.1721192660134; 
 Tue, 16 Jul 2024 22:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmfcSjEEkPlnqy9uIl5p2L+59w904DAu2aVTVUd2t6WJ4fh6R7CQbyEVL67ez/HeLUG2VjDg==
X-Received: by 2002:a05:600c:3b8c:b0:427:abf6:f0e6 with SMTP id
 5b1f17b1804b1-427c2cb0878mr4119255e9.9.1721192659730; 
 Tue, 16 Jul 2024 22:04:19 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f276c52sm190639715e9.22.2024.07.16.22.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:04:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/20] target/i386/tcg: save current task state before loading
 new one
Date: Wed, 17 Jul 2024 07:03:30 +0200
Message-ID: <20240717050331.295371-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is how the steps are ordered in the manual.  EFLAGS.NT is
overwritten after the fact in the saved image.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 85 +++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 36d2f089cae..aac092a356b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -389,6 +389,42 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     access_prepare_mmu(&new, env, tss_base, tss_limit,
                        MMU_DATA_LOAD, mmu_index, retaddr);
 
+    /* save the current state in the old TSS */
+    old_eflags = cpu_compute_eflags(env);
+    if (old_type & 8) {
+        /* 32 bit */
+        access_stl(&old, env->tr.base + 0x20, next_eip);
+        access_stl(&old, env->tr.base + 0x24, old_eflags);
+        access_stl(&old, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX]);
+        access_stl(&old, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX]);
+        access_stl(&old, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX]);
+        access_stl(&old, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX]);
+        access_stl(&old, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP]);
+        access_stl(&old, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP]);
+        access_stl(&old, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI]);
+        access_stl(&old, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI]);
+        for (i = 0; i < 6; i++) {
+            access_stw(&old, env->tr.base + (0x48 + i * 4),
+                       env->segs[i].selector);
+        }
+    } else {
+        /* 16 bit */
+        access_stw(&old, env->tr.base + 0x0e, next_eip);
+        access_stw(&old, env->tr.base + 0x10, old_eflags);
+        access_stw(&old, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX]);
+        access_stw(&old, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX]);
+        access_stw(&old, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX]);
+        access_stw(&old, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX]);
+        access_stw(&old, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP]);
+        access_stw(&old, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP]);
+        access_stw(&old, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI]);
+        access_stw(&old, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI]);
+        for (i = 0; i < 4; i++) {
+            access_stw(&old, env->tr.base + (0x22 + i * 2),
+                       env->segs[i].selector);
+        }
+    }
+
     /* read all the registers from the new TSS */
     if (type & 8) {
         /* 32 bit */
@@ -428,49 +464,16 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
         tss_set_busy(env, env->tr.selector, 0, retaddr);
     }
-    old_eflags = cpu_compute_eflags(env);
+
     if (source == SWITCH_TSS_IRET) {
         old_eflags &= ~NT_MASK;
+        if (old_type & 8) {
+            access_stl(&old, env->tr.base + 0x24, old_eflags);
+        } else {
+            access_stw(&old, env->tr.base + 0x10, old_eflags);
+	}
     }
 
-    /* save the current state in the old TSS */
-    if (old_type & 8) {
-        /* 32 bit */
-        access_stl(&old, env->tr.base + 0x20, next_eip);
-        access_stl(&old, env->tr.base + 0x24, old_eflags);
-        access_stl(&old, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX]);
-        access_stl(&old, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX]);
-        access_stl(&old, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX]);
-        access_stl(&old, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX]);
-        access_stl(&old, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP]);
-        access_stl(&old, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP]);
-        access_stl(&old, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI]);
-        access_stl(&old, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI]);
-        for (i = 0; i < 6; i++) {
-            access_stw(&old, env->tr.base + (0x48 + i * 4),
-                       env->segs[i].selector);
-        }
-    } else {
-        /* 16 bit */
-        access_stw(&old, env->tr.base + 0x0e, next_eip);
-        access_stw(&old, env->tr.base + 0x10, old_eflags);
-        access_stw(&old, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX]);
-        access_stw(&old, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX]);
-        access_stw(&old, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX]);
-        access_stw(&old, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX]);
-        access_stw(&old, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP]);
-        access_stw(&old, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP]);
-        access_stw(&old, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI]);
-        access_stw(&old, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI]);
-        for (i = 0; i < 4; i++) {
-            access_stw(&old, env->tr.base + (0x22 + i * 2),
-                       env->segs[i].selector);
-        }
-    }
-
-    /* now if an exception occurs, it will occurs in the next task
-       context */
-
     if (source == SWITCH_TSS_CALL) {
         /*
          * Thanks to the probe_access above, we know the first two
@@ -486,7 +489,9 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     }
 
     /* set the new CPU state */
-    /* from this point, any exception which occurs can give problems */
+
+    /* now if an exception occurs, it will occur in the next task context */
+
     env->cr[0] |= CR0_TS_MASK;
     env->hflags |= HF_TS_MASK;
     env->tr.selector = tss_selector;
-- 
2.45.2


