Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0FEC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFd-0001RF-AB; Wed, 19 Aug 2026 01:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3P8SEagcKCjYbSUcqdaYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--jackyli.bounces.google.com>)
 id 1wwQg9-00060j-O6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:45:03 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3P8SEagcKCjYbSUcqdaYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--jackyli.bounces.google.com>)
 id 1wwQfz-0007Lq-G8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:54 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8487eb67173so498047b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085888; x=1787690688; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rmFVlsgAYCtkRLriUR3Oc/OpxK2wKe12tzMJ0rDrbCg=;
 b=uHOCCmsFVh9PG58iJTR+7D67uOZxTUE1D2GyPrX6ehCLpiX7F0gimv6PcmpaCblN5G
 cyoMesetbQ6RQISzpq0J6mYNJe8eVYMbtIUQFqnUPzx+dmfVIX5hOyFbcZX1vWfWtyuQ
 n9AFfPCeBIW4/fQcNhWipdTFG3Bm0H38PE6+iXYWTnchM8GeT/SW1CcILWwvsVrDPuv9
 xLeJAAO7yYMjy4m2jn1WJJISbK2xeiOSTns6+A4JY9cYOzcy0Z91+899sQgQodTv6J5Z
 85mbD4EZKeaS9TiDVEldIN0c8Wf++Mr+767AzPqrQnHz0UT5lZytU2n1TELAOMKWEbqS
 X4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085888; x=1787690688;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rmFVlsgAYCtkRLriUR3Oc/OpxK2wKe12tzMJ0rDrbCg=;
 b=ClfQ5Xenp2p/LUvwPtY+wKcIiU1jjhQvU9kpddhCbhE8Y7a850h7agxwJfEwnNIOfu
 oe30LgjK+qX1mOk9TXKCavBwcw4bA9F1r9a2XofdOuFJzD8rIicdKBJP8idOs0dIlWUf
 4HV3ec7sNw/Rsg+bUW3hptaqteP0LUwIeBFPGbQ85HtmhdB3n0u+YyW1Ifb/DvYDMJM/
 2KjTReSgNJs08+nQt6GtouhPvb0KrogsgaZVJGiopu/74EBF4fHBT9x2kyZXU5lZIesn
 P/kgJIcozUr8J3BJlbOFU+84ZGHNBihEhveni9QXcBtl1PD9Eejn0qOVA3Gg6vGaXpwn
 PUgQ==
X-Gm-Message-State: AOJu0YwjauswBzqO6V1jpEcYcRS83kXN5Ypur13iq6zIYMkrE6h6IORw
 0b0ZdSi3r5Yng0ZsZDPlfVreWnIHJJudEvH5wLqa/RlUQ6dI2mTcWGedQdT0x17W20Dn/Z0LCNa
 vZmyy659L0RDqKNJDyen/qKDCIzP1gaPFwyE/m1wXmcMAYJYta5bFnb34wmC9hIkewVVRpDZzS0
 7N+UaFLmPRSh3M6P/hGhgdZyGq6khM5eLZEEzmgpg=
X-Received: from pfew19-n2.prod.google.com
 ([2002:a05:6a00:c1d3:20b0:84f:dde6:e818])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c91:b0:847:9015:e68c
 with SMTP id d2e1a72fcca58-851cdaad991mr1536495b3a.17.1787085887607; Tue, 18
 Aug 2026 13:44:47 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:19 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-5-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 5/6] x86: Add xstate parsing and PKRU offset detection
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, 
 Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3P8SEagcKCjYbSUcqdaYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--jackyli.bounces.google.com;
 helo=mail-pf1-x447.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:10 -0400
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

Add data structures and CPUID detection routines to locate the PKRU
register inside the Linux x86_64 signal frame extended state (`xstate`).

Signed-off-by: Jacky Li <jackyli@google.com>
---
 util/pkey.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/util/pkey.c b/util/pkey.c
index 2e42da7d9c..21b41f928e 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -88,6 +88,59 @@ static inline __attribute__((always_inline)) intptr_t local_syscall3(
     return ret;
 }
 
+/*
+ * Custom structures to parse FPU xstate and extract the PKRU register.
+ * These match the Linux kernel x86_64 signal frame ABI.
+ */
+struct fpstate_64 {
+    uint16_t cwd;
+    uint16_t swd;
+    uint16_t twd;
+    uint16_t fop;
+    uint64_t rip;
+    uint64_t rdp;
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    uint32_t st_space[32];  /*  8x  FP registers, 16 bytes each */
+    uint32_t xmm_space[64]; /* 16x XMM registers, 16 bytes each */
+    uint32_t reserved1[12];
+    union {
+        uint32_t reserved2[12];
+        struct {
+            uint32_t magic1;
+            uint32_t extended_size;
+            uint64_t xstate_bv;
+            uint32_t xstate_size;
+            uint32_t padding[7];
+        } sw_reserved; /* Extended state is encoded here */
+    };
+};
+
+#define FP_XSTATE_MAGIC1 0x46505853U
+#define FP_XSTATE_MAGIC2 0x46505845U
+#define XFEATURE_PKRU 9
+#define XSTATE_PKRU (1ULL << XFEATURE_PKRU)
+
+static int pkru_offset = -2; /* -2 means uninitialized */
+
+static int __attribute__((unused)) get_pkru_offset(void)
+{
+    uint32_t eax, ebx, ecx, edx;
+    __cpuid_count(0xd, XFEATURE_PKRU, eax, ebx, ecx, edx);
+    if (ebx == 0) {
+        return -1;
+    }
+    return (int)ebx;
+}
+
+static int __attribute__((unused)) qemu_get_pkru_offset(void)
+{
+    if (pkru_offset == -2) {
+        pkru_offset = get_pkru_offset();
+    }
+    return pkru_offset;
+}
+
 __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
 {
     if (guest_memory_pkey != -1) {

-- 
2.55.0.737.g08866a6d13-goog


