Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4187FC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jT6-0004zO-Hx; Wed, 08 May 2024 11:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4jT4-0004zC-LF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4jT2-00033L-U3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715183067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ExubtSGvKnUzfdHZ1PDYOU0dWB4CI5fPKePARELOrQs=;
 b=PL+KQDPMWj4ecmhtw2bXAV0hq/4R6Am586fzZEczc5lp98BiRzBoCwlG0GQ6JjamH7qy9G
 S/KdM6vXbzdpOrSOr1XLBicet+gYWXaP8WAwIy0FbfaVhYCqE7CF1w1GTymwfrCWp4B40x
 kI0MUq0SW0DsvFSimwUQ7MeRrUAwqAg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-WIZq4YulOZq6kNSwU0yILg-1; Wed, 08 May 2024 11:44:26 -0400
X-MC-Unique: WIZq4YulOZq6kNSwU0yILg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572baf39435so1058898a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715183064; x=1715787864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExubtSGvKnUzfdHZ1PDYOU0dWB4CI5fPKePARELOrQs=;
 b=iMaNmFgmLOdxrMl+tWM9e4KvZ9+XScBMqGXtG/4y8d/u1KerWOU19IebzOxoyN22tF
 +a+N2e8wzZ2UHe0q8vTCO18o4S485j5ZPMZBblzA+jtiJ+UcwHU6z/jhgnojo56JWmpO
 QkJpfoZC8ZNuFm/oK5j4d7KzsbPCg2neboXSU8TswGT4AsltkTZ5HHpydTn7OtuPdHR3
 7zUNPy80s9yDWpxV6w7XVOPLhylF5f5EjHRLxIQ+LSi4dHudDjk+fHcFZJ3YEh6TBVhT
 6odjJZ9catkvzYzz1Tvq11Wpkf5wBshIfVPWSA4TBYefN1lucWi4TVL0+HzCMI42j44L
 mo5A==
X-Gm-Message-State: AOJu0YwQsEoeWvUPI0j0syMsrBDaqW1ycGiyM3JXwECiAUzZSqDVOdVn
 KL/kckgY81M9QT3sGiXx6UyLid5aCFVpSdjWAXrMxoW0P24KpHk4h+sLB1x50tRnH00qLRuok0S
 NEQykEB+fzSDSLTmer51Abzjw0Yh+CKwjz1GCLj3PgWDlXPc3M8b+9tdF8iSug75m0ly0Gv7Zdg
 lS4XzxjBv0bKU7l10WOYRN47kBcv2VNoIFEqWp
X-Received: by 2002:a50:9b5a:0:b0:572:67de:5fd2 with SMTP id
 4fb4d7f45d1cf-573322da6f7mr61900a12.0.1715183064229; 
 Wed, 08 May 2024 08:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoAz55wR/eTW4huhqWE+jqKVWOIt7izHFYCS1FRLhjWLxrS9b+IndxnGaccL5kuKPR8M8lJQ==
X-Received: by 2002:a50:9b5a:0:b0:572:67de:5fd2 with SMTP id
 4fb4d7f45d1cf-573322da6f7mr61885a12.0.1715183063699; 
 Wed, 08 May 2024 08:44:23 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a50ed08000000b0056e718795f8sm7691432eds.36.2024.05.08.08.44.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 08:44:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: remove PCOMMIT from TCG, deprecate property
Date: Wed,  8 May 2024 17:44:21 +0200
Message-ID: <20240508154421.61419-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

The PCOMMIT instruction was never included in any physical processor.
TCG implements it as a no-op instruction, but its utility is debatable
to say the least.  Drop it from the decoder since it is only available
with "-cpu max", which does not guarantee migration compatibility
across versions, and deprecate the property just in case someone is
using it as "pcommit=off".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst   |  8 ++++++++
 target/i386/cpu.h           |  2 --
 target/i386/cpu.c           |  2 +-
 target/i386/tcg/translate.c | 12 +-----------
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03f8b1b655e..b87fe70be47 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -418,6 +418,14 @@ Backend ``memory`` (since 9.0)
 CPU device properties
 '''''''''''''''''''''
 
+``pcommit`` on x86 (since 9.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The PCOMMIT instruction was never included in any physical processor.
+It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
+only with ``-cpu max`` (which does not guarantee migration compatibility
+across versions).
+
 ``pmu-num=n`` on RISC-V CPUs (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1e0d2c915f5..ccccb62fc35 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -816,8 +816,6 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_0_EBX_SMAP              (1U << 20)
 /* AVX-512 Integer Fused Multiply Add */
 #define CPUID_7_0_EBX_AVX512IFMA        (1U << 21)
-/* Persistent Commit */
-#define CPUID_7_0_EBX_PCOMMIT           (1U << 22)
 /* Flush a Cache Line Optimized */
 #define CPUID_7_0_EBX_CLFLUSHOPT        (1U << 23)
 /* Cache Line Write Back */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1058b6803fd..79372de8c5a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -713,7 +713,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #endif
 #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
-          CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
+          CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
           CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED | \
           CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_KERNEL_FEATURES)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3842b294842..7d9f6b5c55b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4487,17 +4487,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             }
             goto unknown_op;
 
-        case 0xf8: /* sfence / pcommit */
-            if (prefixes & PREFIX_DATA) {
-                /* pcommit */
-                if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_PCOMMIT)
-                    || (prefixes & PREFIX_LOCK)) {
-                    goto illegal_op;
-                }
-                break;
-            }
-            /* fallthru */
-        case 0xf9 ... 0xff: /* sfence */
+        case 0xf8 ... 0xff: /* sfence */
             if (!(s->cpuid_features & CPUID_SSE)
                 || (prefixes & PREFIX_LOCK)) {
                 goto illegal_op;
-- 
2.45.0


