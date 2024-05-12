Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0940BC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66sB-0002fC-IU; Sun, 12 May 2024 06:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66s9-0002cw-N2
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66s5-0007cq-VC
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iPjNiodnUMNgUQHLmagCZjQBGNrAf3agZR9eKXmAcQ=;
 b=aTdKr+FO5AsjpeOJ1wI0ZiBWh54vziZbe49vV6bcJLuW6SMlWZczogv0C4FwKedY2l7wAI
 WgkMSWfKJosQs/AD7L+50x/Y7OHWLq12qPzCWZToHKlzFArWLsuBJOLj4co2JKaPE86G4j
 ehDns3XgU6OZ4/U2FpFtIAdiMFFDOKM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-8-8OoC-kMZahcGpoPhhPEg-1; Sun, 12 May 2024 06:49:52 -0400
X-MC-Unique: 8-8OoC-kMZahcGpoPhhPEg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572d0cb1ffbso2497103a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715510989; x=1716115789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iPjNiodnUMNgUQHLmagCZjQBGNrAf3agZR9eKXmAcQ=;
 b=iIyVMteL/LT/XWuovlsHl5seuZ8FXuwmoyrXyPzSKhK9KBh0Zbp1eiPatH7+UReE7n
 y/Wj0mmLINwIzSJj0xSJbNSMLetEW+WmRbH2M/xtXHgQkySQHct7HLEUABpb3Ds6s/yV
 QFN9HxuCslltJx4TZTcTWNbo4XNP4LPXjrU2PXgKSxsiIWjVGaUgEcbz7xoyuwk/I8uL
 m5CSnfCu8toibom/8thXT1p4a85kXl7mdvDbBWM6CyqzhfuZens9aMTHe7cdFLMTt6FK
 /LZvqprhnzoX+sfQI4OujCWKDTiISMp9kTvhh4lO3QIzaozM8jAAyHXOkxUO4gijPjyY
 by/A==
X-Gm-Message-State: AOJu0YzYerxpRgb070rSsOo2teO2grfOpLy3TOR4NC1YqTRbtMyqncCO
 LYnH5vxb9FFGyDBenHzY4k4dGpkxC+LmJdngxz1WUm30R00ZZ7eNJ5ZussFoO8rTLYFXafpy4zo
 A71Wzeg89DwXDTp3sBFLgZMEJz+/kIuEfHW9cuwlEr/0+SmzyOrSBItBQu1Fo0Fo11yJvTpKwy0
 QkC3flav3o9U7Rx9dysRtKxBx3kFooKDxLDklD
X-Received: by 2002:a50:aada:0:b0:572:7b08:d497 with SMTP id
 4fb4d7f45d1cf-5734d5c17acmr4802869a12.17.1715510989632; 
 Sun, 12 May 2024 03:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuwvDh/Sq5K1Qn/XdhGwvGLVLO1RAFIh4CD59qZpJbhJdt1VMNgxEyHKx3VluhBCZBsXUglg==
X-Received: by 2002:a50:aada:0:b0:572:7b08:d497 with SMTP id
 4fb4d7f45d1cf-5734d5c17acmr4802858a12.17.1715510989146; 
 Sun, 12 May 2024 03:49:49 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb57asm4533919a12.26.2024.05.12.03.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:49:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/27] target/i386: remove PCOMMIT from TCG, deprecate property
Date: Sun, 12 May 2024 12:49:19 +0200
Message-ID: <20240512104945.130198-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst   |  8 ++++++++
 target/i386/cpu.h           |  2 --
 target/i386/cpu.c           |  2 +-
 target/i386/tcg/translate.c | 12 +-----------
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5c3ca47801f..40585ca7d55 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -432,6 +432,14 @@ Backend ``memory`` (since 9.0)
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


