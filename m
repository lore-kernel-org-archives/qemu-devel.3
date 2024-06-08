Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BE6C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYc-0004Hx-G6; Sat, 08 Jun 2024 04:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYT-0003Zu-3K
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYR-0000LE-Fq
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFPWQHzz5XsC/hwHCF9kGKW2QA2c0A/x+5S2uKUsipI=;
 b=R2FUiRgY5qFefslZ0kZHI4kiqKayugHR4nBA8ydCFk/d3HmoskKql1TNVQn/F/D7GbUhxp
 D+RX7Rr8OXzaXmmVTL3JkWz6USc1UAd2dgsKCq90P84bXLOtUnhyzzO80IxK602RXNqS7y
 K/5BZBgLPyY87DZeKHvLLFqDk37sF8k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-OosyhZ6NPge7cwvwPC_HWA-1; Sat, 08 Jun 2024 04:36:00 -0400
X-MC-Unique: OosyhZ6NPge7cwvwPC_HWA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6ef6ac6e0aso46502966b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835758; x=1718440558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFPWQHzz5XsC/hwHCF9kGKW2QA2c0A/x+5S2uKUsipI=;
 b=ZwvdKFEOKNY8wBo+tAfyD/Zyu8zurXlHlVMGwFj1Pz6eGZ3JeoErHU/8Yxxrl1DThu
 4kagTSbogkpnAXplVdqQ73FuFxfCVvnelRP/2CNlf+HE3rCCHcU4DUA/kd80ZrwK9Mms
 f67G4iuudi09BEcWW51HQ04lSu5g42HRGP+/5ZydTAS5gVSkhL2W2slXx5Iiq1Hczqet
 VsmOfwVEZrrBNshDfUl6LhgDGxjkmi65Ex3wurMxEK1ygUaeVA/03QnKeciutkUY2rFn
 kwSTfza6lOkAS6Qb9IHFoZR7sRmEPHmxTfQgXb6RXVXjDo0cxQU1z6e7XaBAbZA5NinT
 Jr/w==
X-Gm-Message-State: AOJu0Yw1Ja78nSIm9HnGQ1g1qmoBAK3kIjag8Khlc773Zt9eQ3ov/0V8
 l/2F0FXBWccBe79GTHnwpvoGWpffOgxMxcWIXFaNlZFit84gKYMCxwX4doGxQ0VdIb64lJ9PAJ9
 uyXbSET9gEoTPMV6liWhomNgPzInZdMac6fkuEcoDT8dsq0py3KXVxELw180Ag3I+1JuDkpHWN0
 adb/PwUSf75ahzl6RzRuBuhVPLAF49ljZj6SU6
X-Received: by 2002:a50:d70d:0:b0:57c:5e65:1ff7 with SMTP id
 4fb4d7f45d1cf-57c5e652ca9mr2386990a12.39.1717835758238; 
 Sat, 08 Jun 2024 01:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnQNvjFC2z9Cv7Ps2zLc7yc+rPO9/zUaGuXMJT5wwDeVfGj8ZQqEVGFOqB1oGrlXzAL1p+9A==
X-Received: by 2002:a50:d70d:0:b0:57c:5e65:1ff7 with SMTP id
 4fb4d7f45d1cf-57c5e652ca9mr2386979a12.39.1717835757859; 
 Sat, 08 Jun 2024 01:35:57 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d296sm3946967a12.7.2024.06.08.01.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>, William Roche <william.roche@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 39/42] i386: Add support for SUCCOR feature
Date: Sat,  8 Jun 2024 10:34:12 +0200
Message-ID: <20240608083415.2769160-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: John Allen <john.allen@amd.com>

Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
be exposed to guests to allow them to handle machine check exceptions on AMD
hosts.

----
v2:
  - Add "succor" feature word.
  - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.

Reported-by: William Roche <william.roche@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: John Allen <john.allen@amd.com>
Message-ID: <20240603193622.47156-3-john.allen@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  4 ++++
 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/kvm/kvm.c |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6d5d1b483c..6786055ec6b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -630,6 +630,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
+    FEAT_8000_0007_EBX, /* CPUID[8000_0007].EBX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
@@ -982,6 +983,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* RAS Features */
+#define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 383230fa479..c5a532a254e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1180,6 +1180,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
+    [FEAT_8000_0007_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, "succor", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000007, .reg = R_EBX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_8000_0008_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6887,7 +6903,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000007:
         *eax = 0;
-        *ebx = 0;
+        *ebx = env->features[FEAT_8000_0007_EBX];
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 55a9e8a70cf..56d8e2a89ec 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -532,6 +532,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          */
         cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
         ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
+    } else if (function == 0x80000007 && reg == R_EBX) {
+        ret |= CPUID_8000_0007_EBX_SUCCOR;
     } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
         /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
          * be enabled without the in-kernel irqchip
-- 
2.45.1


