Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55FFC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEh-0006mC-25; Thu, 04 Jul 2024 05:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEd-0006fN-6e
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEX-00087R-N8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xodI69XkEFxSKoRXtaeS0GzJTj+TYzlh41WlJfxNZDg=;
 b=LkfBwcEsXqGhDUuIDweGkFKyEiNlkn8QYY2KmMP72qMuY2ANZqG1HOgYJ0SFDwmaF92NT5
 xqL5fICXnGC+I0ObnxDl39yCpb0jYKKlgBhkMOAY17onimB8aamLE1fVQdtDzRtcRMa8bR
 SrkvB5qq3/SVEyMkcArJ+uAy2jvA7ls=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Lghdnl2BNJ6CUTtu0MKcWw-1; Thu, 04 Jul 2024 05:58:30 -0400
X-MC-Unique: Lghdnl2BNJ6CUTtu0MKcWw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257f95fe85so3476095e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087108; x=1720691908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xodI69XkEFxSKoRXtaeS0GzJTj+TYzlh41WlJfxNZDg=;
 b=Y2CJFcqHTZfKKBQUt580NVbxEhNOaBUA3E1G1K7lR4lU8GXjPntKEbJhCSndNSqomI
 8QFomidnWafuZxJ0urD8rcdDAEd95HHxPueu0rAnwCmCOYJzjBy2hT8kv+2V9aUZA+TC
 X29WkSLJkA2dx4Z9cjgA3PLLv9Ien0ZRDlQAEK9072yzPYatO4eh5VuzqN6xt5TP6PB5
 fkcPtDi5Rt2Hl+YUPwJyGfVPQ0wdx/OvP8/KdszQ/+rOWhbQ+JFYOBGHS5f9XO/F778E
 WTHPVh6GN/oJCxUew4Z+uYyxzLN3OPfrFX6Mvjke4PLj+k4LSXFLbjQa62V+KafJY3mR
 Hrwg==
X-Gm-Message-State: AOJu0YwrWad0URxcre62hBr7hfH/RYVURYt/0hcZ67rGnkXfDS8McZkB
 QDrNKJUxAxcvdJIdYXHGRvXA2Xo5RvrRopwsTlLgX+S0zKSPgleYM731WUUr5EmqAtJO+zkSA2J
 gaoY9FAwyeccAugJrICZMUxBrTIV/hUBXhHs4pNkxH/h16dsm5Is8r3WBKb1XF98Ar7enZhATQF
 EvOvaI4Zr8FpKvpOycsjA3yj8D4nxY97QvH9uT
X-Received: by 2002:a05:600c:5349:b0:425:5e9a:5958 with SMTP id
 5b1f17b1804b1-4264a3e88d1mr8493155e9.22.1720087107888; 
 Thu, 04 Jul 2024 02:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt3D+mPlZv70+ZMY47xcWhULRk9EV/JIyeppJd5DyPT38ApverxhnbUDAD6jMIAuujdOWwPg==
X-Received: by 2002:a05:600c:5349:b0:425:5e9a:5958 with SMTP id
 5b1f17b1804b1-4264a3e88d1mr8492995e9.22.1720087107531; 
 Thu, 04 Jul 2024 02:58:27 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d6133sm17665845e9.13.2024.07.04.02.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	John Allen <john.allen@amd.com>
Subject: [PULL 08/16] target/i386: drop AMD machine check bits from Intel CPUID
Date: Thu,  4 Jul 2024 11:57:58 +0200
Message-ID: <20240704095806.1780273-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid()
causes the bit to be visible when "-cpu host" VMs are started on Intel
processors.

While this should in principle be harmless, it's not tidy and we don't
even know for sure that it doesn't cause any guest OS to take unexpected
paths.  Since x86_cpu_get_supported_feature_word() can return different
different values depending on the guest, adjust it to hide the SUCCOR
bit if the guest has non-AMD vendor.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4364cb0f8e3..5e5bf71702c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6039,6 +6039,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
     uint64_t r = 0;
+    uint32_t unavail = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
@@ -6064,19 +6065,33 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
     } else {
         return ~0;
     }
+
+    switch (w) {
 #ifndef TARGET_X86_64
-    if (w == FEAT_8000_0001_EDX) {
+    case FEAT_8000_0001_EDX:
         /*
          * 32-bit TCG can emulate 64-bit compatibility mode.  If there is no
          * way for userspace to get out of its 32-bit jail, we can leave
          * the LM bit set.
          */
-        uint32_t unavail = tcg_enabled()
+        unavail = tcg_enabled()
             ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
             : CPUID_EXT2_LM;
-        r &= ~unavail;
-    }
+        break;
 #endif
+
+    case FEAT_8000_0007_EBX:
+        if (cpu && !IS_AMD_CPU(&cpu->env)) {
+            /* Disable AMD machine check architecture for Intel CPU.  */
+            unavail = ~0;
+        }
+        break;
+
+    default:
+        break;
+    }
+
+    r &= ~unavail;
     if (cpu && cpu->migratable) {
         r &= x86_cpu_get_migratable_flags(w);
     }
-- 
2.45.2


