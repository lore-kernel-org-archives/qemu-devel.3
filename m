Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40615C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYa-0003y3-L2; Sat, 08 Jun 2024 04:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYW-0003fq-9P
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYT-0000LQ-Hi
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YizZQkddmGp9IpJqiTCvsXVhloyDqW3nyR8ZMHT+G4E=;
 b=T3g/a11d/ROQcN4BB60UHvS+3+mJRwJU3xUtUMWx7y+D6wKScqyKP1pyyhZPFVwv+kVr5X
 2PHxcjUqgGEt2aFtc6DoM/ri4f6XLMKPGEFT+6+lMh8WM2/uTHRNhr0aZUG6gHBrVIf8N8
 iUA5rElDk84CZV5RHgly+ByraMh5N7M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-m9EpFyoYOSO_BdvOaw9dWQ-1; Sat, 08 Jun 2024 04:36:02 -0400
X-MC-Unique: m9EpFyoYOSO_BdvOaw9dWQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6efe58a1aeso25651966b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835761; x=1718440561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YizZQkddmGp9IpJqiTCvsXVhloyDqW3nyR8ZMHT+G4E=;
 b=d1yL87I8zPb11f6MLKCSNcnG6o8lLPK165wzQ9aULbTZRInStHzAkw8I4/VG91BLBI
 tTTfa+E/dlLa6yABuy/fVsbGEA/xIDcj22fPa5zYciiei25f3NCXmvZeIX6F8W/YNu8j
 tl/jYx11Kz9Nnmg63FzIX3K7sInjVsQ1UxibrFEdyv+9xJDEK9w8nFxp6k3uwn3uQBbg
 ugJnLH9LzzG7e9qv43vOAvwxCgVceOkrDOfuk7yHyQdWEJtCpJzOCJm/3KTFVLc+EHI3
 eN/rSXznITVDi8VTkcbWrElY9RsBHUaU+tFiFbHJIIWF20ESsfr2+2wNz49WH4fnlppY
 BMBg==
X-Gm-Message-State: AOJu0YwwjqsmJi+j/cMgfZRwXHXs10MKMIEWoLfYYoCtBC9fIn5/hD5t
 9eTAnuHpy2a0+fxWwsFv7SWiVt/6a6yEy0gLMNj0/lgo7e7sCU8QTqY2EtgaEcu3jeMWpJeD76J
 CZSGVg0AqNlHYsp0QpEiboqjiegrckZmvEyoiVJvxpeO+moxbUv3759QshC7ZG7zklTAxDdRJro
 dAl0xytJb9EXLKjcyiWyoSl2WFUUUKV/9GW0CW
X-Received: by 2002:a50:9e43:0:b0:57c:677a:a941 with SMTP id
 4fb4d7f45d1cf-57c677aaadbmr896753a12.40.1717835761123; 
 Sat, 08 Jun 2024 01:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY6enENoTDab7tJPuSMOA7BKFnYvlFXgaiLV5/WNNjmd40ozLzJw8i016ncUe3chUmu4FckQ==
X-Received: by 2002:a50:9e43:0:b0:57c:677a:a941 with SMTP id
 4fb4d7f45d1cf-57c677aaadbmr896744a12.40.1717835760684; 
 Sat, 08 Jun 2024 01:36:00 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13d1aesm3992928a12.55.2024.06.08.01.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>
Subject: [PULL 40/42] i386: Add support for overflow recovery
Date: Sat,  8 Jun 2024 10:34:13 +0200
Message-ID: <20240608083415.2769160-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

Add cpuid bit definition for overflow recovery. This is needed in the case
where a deferred error has been sent to the guest, a guest process accesses the
poisoned memory, but the machine_check_poll function has not yet handled the
original deferred error. If overflow recovery is not set in this case, when we
handle the uncorrected error from the poisoned memory access, the overflow bit
will be set and will result in the guest being shut down.

By the time the MCE reaches the guest, the overflow has been handled
by the host and has not caused a shutdown, so include the bit unconditionally.

Signed-off-by: John Allen <john.allen@amd.com>
Message-ID: <20240603193622.47156-4-john.allen@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 1 +
 target/i386/cpu.c     | 2 +-
 target/i386/kvm/kvm.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6786055ec6b..8fe28b67e0f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -984,6 +984,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
 /* RAS Features */
+#define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
 
 /* CLZERO instruction */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c5a532a254e..7466217d5ea 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1183,7 +1183,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0007_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, "succor", NULL, NULL,
+            "overflow-recov", "succor", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 56d8e2a89ec..912f5d5a6be 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -533,7 +533,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
         ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
     } else if (function == 0x80000007 && reg == R_EBX) {
-        ret |= CPUID_8000_0007_EBX_SUCCOR;
+        ret |= CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR;
     } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
         /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
          * be enabled without the in-kernel irqchip
-- 
2.45.1


