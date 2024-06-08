Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2624C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYD-0002wv-Cq; Sat, 08 Jun 2024 04:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYC-0002u9-3B
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYA-0000HB-2O
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpIqRPQiZ9Upcgr72AVRu+EsELD4YNFAS/TKEOfJkMA=;
 b=NNaGstLrS/dqWuEhNYBXyu4F0fC9fzJqNyDlnt11dp0b2mKglqSouydIFVST3zolilpVpB
 9qzmNqJMFgg9xZG+yRmhJbKtJ58ZDeUVhAIKDCDkhD07tVjl1qgw9SumLBlZ56ih1r01d0
 Mq+8Ab47NkymD50A1UVyt3fGurpIBHc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-18hWejcbNQ6EW-1G917ktw-1; Sat, 08 Jun 2024 04:35:37 -0400
X-MC-Unique: 18hWejcbNQ6EW-1G917ktw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6ec06ed579so66150266b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835736; x=1718440536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpIqRPQiZ9Upcgr72AVRu+EsELD4YNFAS/TKEOfJkMA=;
 b=gjGA4vY+rszJNy6t9NcnpZlWmkdpW4MdP8s4xWoMRr1+bVQnAak4r9dfGHeKm9qlCb
 k+TVlUiR4l5yt3jOuAbB3FK7bbpke1EmUrSX/vwYLP4L4SQqDbwRwQ5PTU0MOycANIaZ
 /pbxUTTHM84VHYu9qAbtu/LNxeF+wCvsMNtCL5eanS1HmDfZNtO1RdpIMphznZ41Z58N
 NNRNdFTcTN5Sa03gWsMKlxpc1s83U1dLiiLwwJEH5qJEKxqiLziUIuxVu431cPUNWj1c
 bvarNiQLtXMROZ8YFot/ejR5slUknQbkrhZC8p95fRP2YXmQEaozAG3xMBLOXdE8qSzV
 6d2Q==
X-Gm-Message-State: AOJu0YzEe520fLM6FdPQXe0N393kiI0JTnd0EO117yvQkU3ze6+24dvk
 dAvlRKrHg1nCOiI3PEjjtQnPq+Ziw+2MQ67qLItfg1mQvGDHHNkhnNguwwAK2+iO/FM5fbsteUo
 Qpvxs7im8kehFFec+uQSojAwedL7oHFD4dfyda3gvr8OSujGfzks/bQXpoJCcKaUO7CzGDk7ii8
 djU406r0O8Cfy5NODx1N2dimOpImKKw8AsqniP
X-Received: by 2002:a17:907:bb88:b0:a63:cd85:4d7b with SMTP id
 a640c23a62f3a-a6cdb00066fmr281810766b.62.1717835735729; 
 Sat, 08 Jun 2024 01:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyR9EjG2lRkeUxCkXIQk0ZQBiLh+/cGoOJfOVF+m7ProBm67baFbXGnQ5FBy+xuf7Vys++Mw==
X-Received: by 2002:a17:907:bb88:b0:a63:cd85:4d7b with SMTP id
 a640c23a62f3a-a6cdb00066fmr281809366b.62.1717835735288; 
 Sat, 08 Jun 2024 01:35:35 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6e438d2c23sm177485166b.6.2024.06.08.01.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 30/42] i386/hvf: Updates API usage to use modern vCPU run
 function
Date: Sat,  8 Jun 2024 10:34:03 +0200
Message-ID: <20240608083415.2769160-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

macOS 10.15 introduced the more efficient hv_vcpu_run_until() function
to supersede hv_vcpu_run(). According to the documentation, there is no
longer any reason to use the latter on modern host OS versions, especially
after 11.0 added support for an indefinite deadline.

Observed behaviour of the newer function is that as documented, it exits
much less frequently - and most of the original function’s exits seem to
have been effectively pointless.

Another reason to use the new function is that it is a prerequisite for
using newer features such as in-kernel APIC support. (Not covered by
this patch.)

This change implements the upgrade by selecting one of three code paths
at compile time: two static code paths for the new and old functions
respectively, when building for targets where the new function is either
not available, or where the built executable won’t run on older
platforms lacking the new function anyway. The third code path selects
dynamically based on runtime detected availability of the weakly-linked
symbol.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20240605112556.43193-7-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 106ac5cbf62..2d0eef6cd97 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -427,6 +427,27 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+static hv_return_t hvf_vcpu_run(hv_vcpuid_t vcpu_id)
+{
+    /*
+     * hv_vcpu_run_until is available and recommended from macOS 10.15+,
+     * HV_DEADLINE_FOREVER from 11.0. Test for availability at runtime and fall
+     * back to hv_vcpu_run() only where necessary.
+     */
+#ifndef MAC_OS_VERSION_11_0
+    return hv_vcpu_run(vcpu_id);
+#elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+    return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
+#else /* MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0 */
+    /* 11.0 SDK or newer, but could be < 11 at runtime */
+    if (__builtin_available(macOS 11.0, *)) {
+        return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
+    } else {
+        return hv_vcpu_run(vcpu_id);
+    }
+#endif
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -455,7 +476,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
-        hv_return_t r  = hv_vcpu_run(cpu->accel->fd);
+        hv_return_t r = hvf_vcpu_run(cpu->accel->fd);
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
-- 
2.45.1


