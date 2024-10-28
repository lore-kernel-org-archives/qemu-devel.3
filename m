Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04BBD33996
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RX1-0000CE-0M; Mon, 28 Oct 2024 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWs-0008Lc-FQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWq-0000rW-0t
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmKhKEdS2mkx4S/7qSYmAFENKPtbe328YARDjOvKYh0=;
 b=Q/A2jrK3nj+Mi1hV3iaiC+KjlU+gEyHPKqh5UHHl4VtbDxne3rIQcBRlEnl7eJU4m+86aQ
 mSK6dap6dSbwGgrZltH/c9/zaXUBv8ySBrZZFxJhjg1uwaPlf82hBf2yOM4DE9CYcPpzrw
 mMinclabjizbUqoCGMaa7e4dgYzq6qc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-9nZ7siPONyuo7hSgUMi2dA-1; Mon, 28 Oct 2024 11:19:34 -0400
X-MC-Unique: 9nZ7siPONyuo7hSgUMi2dA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so31941775e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128772; x=1730733572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmKhKEdS2mkx4S/7qSYmAFENKPtbe328YARDjOvKYh0=;
 b=W1V/2sihd/9F1/1MjHdwmDZ9iqwAH5ooH6yFZTkoQxLAIouJC/b6+oUD6hGgInOrhj
 +ta61pDsox1y3BiToeF7DFe7EOmqHErEeL/vriNuVZ7vG5NCnPog8yjscGgOEsovctaV
 +TEG++Df10lzVUIE85RiaPEu8DuJ3e4aaCRrIBCTRMBqALYGPNeiiaH99/TegxanR3Hq
 dlp+bhbdlbb+qlqi+ThCv9Gv9/MdiGF+shOv7zDGU0RZn/XFeGpsJc2oF0yKeT4rZY2w
 K3hwwA8AYlzgv7+XWTegK+m+1ZjWYUHGK6uiG81xc5uKt/eZjjR8lDy7WgAz6vNUff9B
 Ng0w==
X-Gm-Message-State: AOJu0YxuY4fT7yxuwSN9mUFL6ZuYtKs5vY3D80g6l8qQPO+UOLJsLaSz
 zjZwApCDJYtqNK+nNB8ocWL2JrE1MVNqHMmBRj98lCuKfvC9ICFlYfyEfs9y3B6nl1zWE+JG01a
 R0LE4KEYH9micl2bpkE5XTR3zADix3Fgx8JLBJFGbrDxOdUZdfTB2Q0mKkihzJ/7tivqP83+I4I
 eumXNIun7+/Vc+Ab7dOL62K5WOpDG/T3BPL1oeC7o=
X-Received: by 2002:a05:600c:3ca3:b0:42f:823d:dde9 with SMTP id
 5b1f17b1804b1-4319acbba20mr81364225e9.21.1730128772502; 
 Mon, 28 Oct 2024 08:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiNMa6DEwpmp3jkzn6CmqntXxtycjOsfKarpJouKKJCpjKj1j2czQvLjX9qkk3wslpjbP/ow==
X-Received: by 2002:a05:600c:3ca3:b0:42f:823d:dde9 with SMTP id
 5b1f17b1804b1-4319acbba20mr81363465e9.21.1730128771186; 
 Mon, 28 Oct 2024 08:19:31 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573cd4sm113158445e9.5.2024.10.28.08.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 12/14] target/i386: use compiler builtin to compute PF
Date: Mon, 28 Oct 2024 16:18:49 +0100
Message-ID: <20241028151851.376355-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This removes the 256 byte parity table from the executable.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/host-utils.h                |  9 ++++++
 target/i386/tcg/helper-tcg.h             |  6 +++-
 target/i386/tcg/cc_helper_template.h.inc | 20 +++++++-------
 target/i386/tcg/cc_helper.c              | 35 ------------------------
 target/i386/tcg/int_helper.c             |  4 +--
 5 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index ead97d354d6..4d28fa22cfa 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -313,6 +313,15 @@ static inline int ctpop8(uint8_t val)
     return __builtin_popcount(val);
 }
 
+/*
+ * parity8 - return the parity (1 = odd) of an 8-bit value.
+ * @val: The value to search
+ */
+static inline int parity8(uint8_t val)
+{
+    return __builtin_parity(val);
+}
+
 /**
  * ctpop16 - count the population of one bits in a 16-bit value.
  * @val: The value to search
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 15d6c6f8b4f..696d6ef016f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -21,6 +21,7 @@
 #define I386_HELPER_TCG_H
 
 #include "exec/exec-all.h"
+#include "qemu/host-utils.h"
 
 /* Maximum instruction code size */
 #define TARGET_MAX_INSN_SIZE 16
@@ -87,7 +88,10 @@ G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 #endif
 
 /* cc_helper.c */
-extern const uint8_t parity_table[256];
+static inline unsigned int compute_pf(uint8_t x)
+{
+    return !parity8(x) * CC_P;
+}
 
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 4cbbc73c3cd..8af8b8539f9 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -45,7 +45,7 @@ static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     DATA_TYPE src2 = dst - src1;
 
     cf = dst < src1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -65,7 +65,7 @@ static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
     DATA_TYPE src2 = dst - src1 - src3;
 
     cf = (src3 ? dst <= src1 : dst < src1);
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & 0x10;
     zf = (dst == 0) << 6;
     sf = lshift(dst, 8 - DATA_BITS) & 0x80;
@@ -85,7 +85,7 @@ static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     DATA_TYPE src1 = dst + src2;
 
     cf = src1 < src2;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -107,7 +107,7 @@ static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
     DATA_TYPE src1 = dst + src2 + src3;
 
     cf = (src3 ? src1 <= src2 : src1 < src2);
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & 0x10;
     zf = (dst == 0) << 6;
     sf = lshift(dst, 8 - DATA_BITS) & 0x80;
@@ -128,7 +128,7 @@ static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = 0;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -144,7 +144,7 @@ static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     cf = src1;
     src1 = dst - 1;
     src2 = 1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -160,7 +160,7 @@ static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     cf = src1;
     src1 = dst + 1;
     src2 = 1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -173,7 +173,7 @@ static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 >> (DATA_BITS - 1)) & CC_C;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0; /* undefined */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -192,7 +192,7 @@ static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = src1 & 1;
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0; /* undefined */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
@@ -209,7 +209,7 @@ static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
     uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
-    pf = parity_table[(uint8_t)dst];
+    pf = compute_pf(dst);
     af = 0; /* undefined */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 1b83775a914..f1940b40927 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -22,41 +22,6 @@
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
 
-const uint8_t parity_table[256] = {
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
-    0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
-};
-
 #define SHIFT 0
 #include "cc_helper_template.h.inc"
 #undef SHIFT
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index e1f92405282..1a02e9d8434 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -237,7 +237,7 @@ void helper_daa(CPUX86State *env)
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xff) | al;
     /* well, speed is not an issue here, so we compute the flags by hand */
     eflags |= (al == 0) << 6; /* zf */
-    eflags |= parity_table[al]; /* pf */
+    eflags |= compute_pf(al);
     eflags |= (al & 0x80); /* sf */
     CC_SRC = eflags;
     CC_OP = CC_OP_EFLAGS;
@@ -269,7 +269,7 @@ void helper_das(CPUX86State *env)
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xff) | al;
     /* well, speed is not an issue here, so we compute the flags by hand */
     eflags |= (al == 0) << 6; /* zf */
-    eflags |= parity_table[al]; /* pf */
+    eflags |= compute_pf(al);
     eflags |= (al & 0x80); /* sf */
     CC_SRC = eflags;
     CC_OP = CC_OP_EFLAGS;
-- 
2.47.0


