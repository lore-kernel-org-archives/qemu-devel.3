Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23A1E7718D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53a-0002ON-Ei; Sat, 21 Dec 2024 14:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53Y-0002Na-Bp
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53W-0000A5-Qa
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4KdKj6hbbdD8TFVWl0itPd8xJR7/KfGpl+19tzA838=;
 b=NsiHHye/InGlAjaP4FrDYFFA0tBvR+WcfSmUtj/SjuqoZXx5+7AmhIG/A0i6jJsFfAbmc/
 fDRDe18+9Saa4EWmiTlZJ9yXjtoG554wXVP6FwrdOegd+/RZIe/nAYWcFtnKexpgJ2zIDw
 bNdQILOa4UTyy3Qo4lQSMhHq5CKWO1Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-v4IDNRgrPmO9mms---R0kw-1; Sat, 21 Dec 2024 14:22:25 -0500
X-MC-Unique: v4IDNRgrPmO9mms---R0kw-1
X-Mimecast-MFC-AGG-ID: v4IDNRgrPmO9mms---R0kw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e27c5949so1815923f8f.3
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808944; x=1735413744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4KdKj6hbbdD8TFVWl0itPd8xJR7/KfGpl+19tzA838=;
 b=BDNiTYYpmXNfkcD2ryXW0E6tGJsFr1W5MXYoEU7E8vLJQEYc2e4D2o7FNA/IqRvmql
 XI9ALI0fj/9kpXYsEa57JM9V8o54s7ByTYO9k1H5R2uQ3HO6ogMBv0TCWXJz0yqS44HU
 gDsgbC+4zurv3ZWzZGL+ndayjx20gNKPx63JA54jJYn8z7REaag6a3wlg9tKdt5NawJo
 hjM5bwIBz8JmQNp/Cw2DhhxPVrJQZwUQL+VUS9MxZq4KH6QoScDQoNbwpXjCpU8/3PJV
 qplCBc8AQKA6ndhFl/KUnTcTwiRrRTATRfKysgUxlIYefMElYb+inYKYW1hgA3UJMOyi
 JVwA==
X-Gm-Message-State: AOJu0Yw4SCZUd1XMetuVatzzrH3hxoK8x3gk2Jn651uZAoniya+Dh2yY
 Pn7Lp0HT8pgEJV0mIytebQ95Um9ZNXkpUR8yISDqPLLEQnwmpf2EtC58f8f8tEqSMVH3TcSFk7C
 9i5z3ODr4I0lTDxFu/5iDgXtOpLBBB3yPJHM0a4udxpuGo/Ts8JF34yut6n1LareelnEvX4vltS
 g8j3gp4WX3gowE3jnfqEJDQQ+GPfmnBB44
X-Gm-Gg: ASbGnctIkQiRpfs+duftFAMudD5G5YAFpZISdGWOCq9IjMH/zMZgDKIPAY5Mh5RUFxm
 BXLp6yrplsQkTh+1afchTGTGR8I/9mmB0fsF7Re7TKb6w5ygxY9IxcEq5xIhrJ2mnvumf0no8K5
 Sfl2dDLym1QZ4CLSmsCDGek71SiZFW+QhVZXYHwH7NTCzgOxWowN8lfRZvm9R801/k6O0MU8qQi
 MRMpg5o7NQBSDi5f9/0yaTjIPWHagIhNy/7247t0ZtNKjIirzD7ykQusSDplSWvFAcXqx+BuYKl
 jewTKOpIn9gqcZZGc9CAsMx2Hqmp41rQ2m/hqrg=
X-Received: by 2002:a05:6000:402c:b0:385:e9c0:c069 with SMTP id
 ffacd0b85a97d-38a22408f78mr6058591f8f.57.1734808944589; 
 Sat, 21 Dec 2024 11:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKXTaedTUGvHalZ1YSe4HqBX1icZJNUv4SuMdvMlag+UD1e5QqNsrpQVZYCuKms7yOUifx3w==
X-Received: by 2002:a05:6000:402c:b0:385:e9c0:c069 with SMTP id
 ffacd0b85a97d-38a22408f78mr6058571f8f.57.1734808944097; 
 Sat, 21 Dec 2024 11:22:24 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c833149sm7073049f8f.39.2024.12.21.11.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:23 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 04/15] s390x/s390-virtio-hcall: prepare for more diag500
 hypercalls
Date: Sat, 21 Dec 2024 20:21:58 +0100
Message-ID: <20241221192209.3979595-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

Let's generalize, abstracting the virtio bits. diag500 is now a generic
hypercall to handle QEMU/KVM specific things. Explicitly specify all
already defined subcodes, including legacy ones (so we know what we can
use for new hypercalls).

Move the PGM_SPECIFICATION injection into the renamed function
handle_diag_500(), so we can turn it into a void function.

We'll rename the files separately, so git properly detects the rename.

Message-ID: <20241219144115.2820241-4-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-hcall.c   | 15 ++++++++-------
 hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
 target/s390x/kvm/kvm.c         | 20 +++-----------------
 target/s390x/tcg/misc_helper.c |  5 +++--
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index ca49e3cd22..5fb78a719e 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390
+ * Support for QEMU/KVM hypercalls on s390
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -57,18 +57,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     return 0;
 }
 
-int s390_virtio_hypercall(CPUS390XState *env)
+void handle_diag_500(S390CPU *cpu, uintptr_t ra)
 {
+    CPUS390XState *env = &cpu->env;
     const uint64_t subcode = env->regs[1];
 
     switch (subcode) {
-    case KVM_S390_VIRTIO_NOTIFY:
+    case DIAG500_VIRTIO_NOTIFY:
         env->regs[2] = handle_virtio_notify(env->regs[2]);
-        return 0;
-    case KVM_S390_VIRTIO_CCW_NOTIFY:
+        break;
+    case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
-        return 0;
+        break;
     default:
-        return -EINVAL;
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 }
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 3d9fe147d2..dca456b926 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,5 +1,5 @@
 /*
- * Support for virtio hypercalls on s390x
+ * Support for QEMU/KVM hypercalls on s390x
  *
  * Copyright IBM Corp. 2012, 2017
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -12,12 +12,13 @@
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
-#include "standard-headers/asm-s390/virtio-ccw.h"
 #include "cpu.h"
 
-/* The only thing that we need from the old kvm_virtio.h file */
-#define KVM_S390_VIRTIO_NOTIFY 0
+#define DIAG500_VIRTIO_NOTIFY           0 /* legacy, implemented as a NOP */
+#define DIAG500_VIRTIO_RESET            1 /* legacy */
+#define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
+#define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
 
-int s390_virtio_hypercall(CPUS390XState *env);
+void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 32cf70bb19..508403609f 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1492,22 +1492,6 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
     return r;
 }
 
-static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
-{
-    CPUS390XState *env = &cpu->env;
-    int ret = -EINVAL;
-
-#ifdef CONFIG_S390_CCW_VIRTIO
-    ret = s390_virtio_hypercall(env);
-#endif /* CONFIG_S390_CCW_VIRTIO */
-    if (ret == -EINVAL) {
-        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
-        return 0;
-    }
-
-    return ret;
-}
-
 static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
 {
     uint64_t r1, r3;
@@ -1603,9 +1587,11 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     case DIAG_SET_CONTROL_PROGRAM_CODES:
         handle_diag_318(cpu, run);
         break;
+#ifdef CONFIG_S390_CCW_VIRTIO
     case DIAG_KVM_HYPERCALL:
-        r = handle_hypercall(cpu, run);
+        handle_diag_500(cpu, RA_IGNORED);
         break;
+#endif /* CONFIG_S390_CCW_VIRTIO */
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
         break;
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f44136a568..2b4310003b 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -119,10 +119,11 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     switch (num) {
 #ifdef CONFIG_S390_CCW_VIRTIO
     case 0x500:
-        /* KVM hypercall */
+        /* QEMU/KVM hypercall */
         bql_lock();
-        r = s390_virtio_hypercall(env);
+        handle_diag_500(env_archcpu(env), GETPC());
         bql_unlock();
+        r = 0;
         break;
 #endif /* CONFIG_S390_CCW_VIRTIO */
     case 0x44:
-- 
2.47.1


