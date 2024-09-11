Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E8EE49A0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMY1-000650-2F; Wed, 11 Sep 2024 08:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXy-0005mh-KU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXw-00013V-Fe
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtYCdte9dWd9oGT6jGVa2VRP3oHQUflr0u1OJvVB2MA=;
 b=gFtsPBnO0IJ+0Xzyo0Op987NZbZfQuzdC3AYd8fHfgbLaMIbe4MSrZoT0DzcBLu6e31YR4
 eI16369PiTewo5XQW2pFYgmiTW8XGRaRHUgVw748HU3Zmrk02LoW40Ec8EEkmjpW6GC+uc
 0hKmpCjBCbm6Ocfekg9CxfKa8uHR2zM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Wz8Rcq_KPZ-vB-UsiYMfHQ-1; Wed, 11 Sep 2024 08:34:06 -0400
X-MC-Unique: Wz8Rcq_KPZ-vB-UsiYMfHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374b9617ab0so2863216f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058045; x=1726662845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtYCdte9dWd9oGT6jGVa2VRP3oHQUflr0u1OJvVB2MA=;
 b=EMWfj5453TfceR7FqnzMGLvHtDveZJ+O2g6XYRq6jAytjCGxOsOUBgyaWMRfGrIHip
 QvqD2Mcqt5MffhMUKg8aCLT195OHS/10F/pLvZPxlmwT5++pKStq2XECHAzgqDv26Dcz
 lrK8tD4+5kS1/6yuW8kBKiWHP20MIY/omdxCI6sufzPs2KmIBHbpGkbc6AsWWmwSXkZF
 YVB08pz8I7TGUewLLDrE52hRcB5343q+jzlTLC4a+1O3FkuQBjWnaKhhVYtPR+AaS8xQ
 m+cZw5ha5gCijJC2o1HSKdlNhdLy2SMmBa+n1mPuDf2eaNS1xF/9RV6F+mpHx9VGIgot
 0Ong==
X-Gm-Message-State: AOJu0Yxevt1BqPXTBjzJbL/WRQZtb9DLzmIQfzUBV7no4QLJ8aSFIJBq
 WE373ObNVlMhn4k0zETJ9E4Yoe9EPJHHJo7rbgRDuNH2wK138CJewamGSge0T71pk7TQccrBx3p
 c7Up3i7lf2rBVcPLPb89/OoYiLmUAMkqYLXDEQsP3EoukJIRxd6wCQQtKRI7TgGuKgmalOutm7d
 uDfc2q71rIC75Jo1LIlnGtJg2KmK53aHaEQDMYTLU=
X-Received: by 2002:a5d:4991:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-378926858b2mr7941981f8f.4.1726058044579; 
 Wed, 11 Sep 2024 05:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNafR3vo7C/29BOJu4tasZKxMizFSJ9u+6mePFyBtocHZYI8Q8jgAoAWHtyi+3mSLgGSQK9w==
X-Received: by 2002:a5d:4991:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-378926858b2mr7941958f8f.4.1726058044030; 
 Wed, 11 Sep 2024 05:34:04 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d35b9sm11476718f8f.70.2024.09.11.05.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 07/17] kvm/i386: fix return values of is_host_cpu_intel()
Date: Wed, 11 Sep 2024 14:33:32 +0200
Message-ID: <20240911123342.339482-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d95013a2ce6..7c491378026 100644
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
2.46.0


