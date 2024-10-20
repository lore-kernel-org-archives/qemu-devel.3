Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782BED3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YGC-0003hf-A0; Sun, 20 Oct 2024 11:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFx-0003On-GG
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFv-0005RX-QO
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puHKtdYSByTzsLL6YmkC2GAWqDoPkcpbu5iM6Kyqj54=;
 b=Nz4zIPC0TyS8ncIS9x09uzaEf+MG2HH30lHFSPendb/mxhnzCTeZXI+mfAnSiOaJB3LPiI
 6rbjg5J5+7S8w+pEA713m5jVeysPEM3stwvQp4suVaXw5t/1gxLExP4lkx7jr02LMk/nlQ
 00z7wBj6nB/hhCf2WJShrOn3s5g1YGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-e8e5t7HwPCu7KjFE2Xh9wA-1; Sun, 20 Oct 2024 11:54:09 -0400
X-MC-Unique: e8e5t7HwPCu7KjFE2Xh9wA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431518ae047so22293275e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439647; x=1730044447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puHKtdYSByTzsLL6YmkC2GAWqDoPkcpbu5iM6Kyqj54=;
 b=ROPcz4MzLLLyoFq8PQQW/ARmUWp1YKUTYwNaiNbQum8S6l0p3eo6aN2YaKsb73/alw
 IYfCfy2efZd+tuyBdNb4yIiWdJnyEm1Wh/aEiv9BbEMk6qCwjpR0ebTEjkYQw3XU/EU2
 vCLB1khdxAjkjvL2lm0jEV3uPbUdEbkM+Oc1SKoQGMrAnCxTq2hjkWr7YwI5x8XcqtBH
 Ua3L6doyA37fjonVfHZPy75DZQFlKLmhVOCwqBcCG0lb+GicrVFN3wJeR5t+5PaoIOXM
 R6ey+Wad3QrybhSEREZRXQ26kMHpjPvYRJ9OSthIqzRlot3/BrhnNjo8iuZwA80ykL9p
 cKfg==
X-Gm-Message-State: AOJu0YwSLVPWRl9TPIBt69cYpawW2/6b613mA5x5sKfljCPjhpXfSp9u
 WqevpGQ8I8wBhqmC4BJ/ylBvj3RtvbhuLfWgRID60gwM545L0ASjRaIZaJUk3oN7mUL0ifMTrJr
 UFO3+ZG8giRO2e/CwsQQns1WB3Ak5YS9/qrUGT7GYQC5XV51lhWIld5GEa7PhWvSp7h2jue+mPp
 7Jj5ytTynuDscFWcEbsZLNJVRh4dg+jpd1L+Pg2DE=
X-Received: by 2002:a05:600c:511c:b0:430:56f5:4d1f with SMTP id
 5b1f17b1804b1-431586fc549mr74756155e9.2.1729439646841; 
 Sun, 20 Oct 2024 08:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxc5DRFb/uEe0C0BIK2MYpByrUuLmhNMTr70RIymtc9wedP82J5pjzpcd7CyaAlbN/GtxCIg==
X-Received: by 2002:a05:600c:511c:b0:430:56f5:4d1f with SMTP id
 5b1f17b1804b1-431586fc549mr74756005e9.2.1729439646383; 
 Sun, 20 Oct 2024 08:54:06 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a37bb5sm2015074f8f.7.2024.10.20.08.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:54:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 12/14] target/i386: use builtin popcnt or parity to compute PF,
 if available
Date: Sun, 20 Oct 2024 17:53:22 +0200
Message-ID: <20241020155324.35273-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This removes the 256 byte parity table from the executable on
x86, s390 and RISC-V/zbb hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/host-utils.h                | 16 ++++++++++++++++
 target/i386/tcg/helper-tcg.h             | 12 ++++++++++++
 target/i386/tcg/cc_helper_template.h.inc | 20 ++++++++++----------
 target/i386/tcg/cc_helper.c              |  2 ++
 target/i386/tcg/int_helper.c             |  4 ++--
 5 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index ead97d354d6..bd4c684e5b5 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -126,6 +126,13 @@ static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
 }
 #endif
 
+#if defined __POPCNT__ || defined __s390x__|| defined __riscv_zbb
+#define HAVE_FAST_CTPOP 1
+#endif
+#if defined __i386__ || defined __x86_64__ || defined HAVE_FAST_CTPOP
+#define HAVE_FAST_PARITY8 1
+#endif
+
 /**
  * clz8 - count leading zeros in a 8-bit value.
  * @val: The value to search
@@ -313,6 +320,15 @@ static inline int ctpop8(uint8_t val)
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
index 15d6c6f8b4f..fb6354873d1 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -21,6 +21,7 @@
 #define I386_HELPER_TCG_H
 
 #include "exec/exec-all.h"
+#include "qemu/host-utils.h"
 
 /* Maximum instruction code size */
 #define TARGET_MAX_INSN_SIZE 16
@@ -87,7 +88,18 @@ G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 #endif
 
 /* cc_helper.c */
+#ifdef HAVE_FAST_PARITY8
+static inline unsigned int compute_pf(uint8_t x)
+{
+    return !parity8(x) * CC_P;
+}
+#else
 extern const uint8_t parity_table[256];
+static inline unsigned int compute_pf(uint8_t x)
+{
+    return parity_table[x];
+}
+#endif
 
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
index c24e6a14c07..d65345f059d 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
 
+#ifndef HAVE_FAST_PARITY8
 const uint8_t parity_table[256] = {
     CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
     0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
@@ -56,6 +57,7 @@ const uint8_t parity_table[256] = {
     CC_P, 0, 0, CC_P, 0, CC_P, CC_P, 0,
     0, CC_P, CC_P, 0, CC_P, 0, 0, CC_P,
 };
+#endif
 
 #define SHIFT 0
 #include "cc_helper_template.h.inc"
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
2.46.2


