Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C40CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlH4-0008O4-1l; Fri, 04 Oct 2024 12:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGS-0006XR-Mm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGP-0006AV-T2
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkJQs4M6TG5A3+cCJfAZ8QZtJwRKwQvtcjCn7qsdE04=;
 b=Ga3hsORlDE/ubcMfXmaX1abyYEO8xG0QYeBA36Ad9ZPfxAhuo8ci1Eb3J/T6H+zdf594/T
 +hphgXdtafkpulCvX6uSgt+k6qNf+RE1WX9YwX0KstkVlAjIcbHnVuIbvceHTzn+3S1yAx
 uSVaHAbH0WeNzTWlIVdhjacEXDwAjOI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-nUBdTZ3GMsmqx9rmukJwIg-1; Fri, 04 Oct 2024 12:34:42 -0400
X-MC-Unique: nUBdTZ3GMsmqx9rmukJwIg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd08d3678so1011894f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059680; x=1728664480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkJQs4M6TG5A3+cCJfAZ8QZtJwRKwQvtcjCn7qsdE04=;
 b=NjWL5qoBT9K3gzF7ZrbazG3t1p2XA734EVGedLYeMB0M076FKFDJGGIVRoqU8hX6n2
 mPYbC1RGZmzSfNt6Khi0IKT9AJ138Ij2zF2E9o+6v1Ou5j6nDa9hMnu0pPMc5QF60EFC
 d/GoU9ButCZNYeXmvvUcqC6Ygv1FFuqnywfqzuq0vyK8lWTfGvMTNnCMnAnI4x51rdL9
 1bIVoR7E1OuDQfXpHT6GvCMUi3Fm5eaArTRz/kmUwlmPbC66KO7c7XIrdp5k7dArBgP4
 0TC/fRRhpsbulQ9N67llMGrSFoDEudE8jGH2Dxl+R1WR3W6dlAY9TfgucRVcfT6wMKZN
 6+Lg==
X-Gm-Message-State: AOJu0YwMkcewLoG6KutQDPGtBAH8+NsamrUFvOVuY2w9s3JQ+ZaU0rDR
 2MfrLN/P+Ornjw8/UFH/Uo5/e+p9xwBn4tsFdNQ0VIDYgB28pTmhlCrQx47fUNhpBUIouyjxtdg
 U4NCJefb+e6HiHnmiBSzYVuZJaluzc0PJnjWaQoxw8KcJ3YGQd/93x3z6jsVHsofrLO4r4QnioX
 N3jEmJ7eIz7C7d0oBlWKZtdBORaSPHIFqmrSzE744=
X-Received: by 2002:a05:6000:c86:b0:37c:ca20:52a with SMTP id
 ffacd0b85a97d-37d0f6a15cemr2654858f8f.8.1728059680413; 
 Fri, 04 Oct 2024 09:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNOZkK/A/UPzmMRaCVQDM+O0jCZjXVDR+H3Fc2MnUQSwMrTl/QEKOOThc8z5dkRCCaLmca1g==
X-Received: by 2002:a05:6000:c86:b0:37c:ca20:52a with SMTP id
 ffacd0b85a97d-37d0f6a15cemr2654833f8f.8.1728059679932; 
 Fri, 04 Oct 2024 09:34:39 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f77dsm38201f8f.2.2024.10.04.09.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 07/23] kvm/i386: fix return values of is_host_cpu_intel()
Date: Fri,  4 Oct 2024 18:33:59 +0200
Message-ID: <20241004163415.951106-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

is_host_cpu_intel() should return TRUE if the host cpu in Intel based, otherwise
it should return FALSE. Currently, it returns zero (FALSE) when the host CPU
is INTEL and non-zero otherwise. Fix the function so that it agrees more with
the semantics. Adjust the calling logic accordingly. RAPL needs Intel host cpus.
If the host CPU is not Intel baseed, we should report error.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240903080004.33746-1-anisinha@redhat.com
[While touching the code remove too many spaces from the second part of the
 error. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c         | 6 +++---
 target/i386/kvm/vmsr_energy.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 94fdf3cb304..fa0be5537fa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2906,9 +2906,9 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
      * 1. Host cpu must be Intel cpu
      * 2. RAPL must be enabled on the Host
      */
-    if (is_host_cpu_intel()) {
-        error_report("The RAPL feature can only be enabled on hosts\
-                      with Intel CPU models");
+    if (!is_host_cpu_intel()) {
+        error_report("The RAPL feature can only be enabled on hosts "
+                     "with Intel CPU models");
         ret = 1;
         goto out;
     }
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 7e064c5aef3..31508d4e77a 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -34,7 +34,7 @@ bool is_host_cpu_intel(void)
 
     host_cpu_vendor_fms(vendor, &family, &model, &stepping);
 
-    return strcmp(vendor, CPUID_VENDOR_INTEL);
+    return g_str_equal(vendor, CPUID_VENDOR_INTEL);
 }
 
 int is_rapl_enabled(void)
-- 
2.46.1


