Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3C3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wbx-0004s9-Bo; Wed, 23 Apr 2025 05:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbX-0004An-Oz
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbV-0008Jz-Hy
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uWoXnckgp/3cPXEWV6PWVXNFh+phzVHf+shlzxT9o0=;
 b=g7uKM/nOeKhKpGj0L4yqUhCuwV30LCXmp7GLHXfVSSZQnfBXkg5hHe2fxizbPyvR5NIENu
 nHl9d2xszzA2x0Cx4XBwP3vXWZHgvcctGHijzyoHWY7GTSHYF4NHJl+23brMBZS8clQiXU
 C2wYM2ZIQkq0HfzVC5SMUi4UEZj3vfE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-YShB35MlNrCd2qOq1U00-A-1; Wed, 23 Apr 2025 05:41:14 -0400
X-MC-Unique: YShB35MlNrCd2qOq1U00-A-1
X-Mimecast-MFC-AGG-ID: YShB35MlNrCd2qOq1U00-A_1745401273
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6ebab17d8so569039766b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401273; x=1746006073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uWoXnckgp/3cPXEWV6PWVXNFh+phzVHf+shlzxT9o0=;
 b=LH/fHEBVfTv/GYuBtpqIIkvXMnAsaMg+rM85LONu4eZGa3Zsahg4OuTF8vjubQGYct
 bczava9xu0PHhWCjg1weIxUJGTolDl5Yya0qdi9yIujnrX1vUwBf14DQs8sStEpuM+1q
 1Q8Hi2TgHRwCM90G7sWjlojsJS3RdK+a6asn6uURaNNyxBBgtRm1onCs/R4sXuOME4kt
 mmVvxBt/1PUdVTSIBF/3CEEZ0TGmQFi0v6ts3z/63Xa8rmZYUDS2tOzy3d00TjLuKi8N
 blf63aYtORLIRmLQjisO33kUm6EDMABAIIuX5O0NQVZuHs+LfAyER9OTZ6SvVcZKxiLM
 5eWw==
X-Gm-Message-State: AOJu0YzYWS59An4Y1Z2Hd6d+vM5b32QE6+M65JKhSLFwpA0I0r3aygqp
 AG5TSYebYNe7stCdbDFJnqs9kO/TaNEViutWCdabD4jH7kB7LZdGIYMHNKNn/bCWk+S/UujXkoQ
 sqrWS3xzU4JRz0AWNYQFnhqT8hZFxumTrhGySWGhg+GSEQyuFB+d1n4ctcv3Ig+WgmwWqddw0Wt
 cwldf9hcN/6J1zlVOosGah0Khb+JyTjOQoOAG1
X-Gm-Gg: ASbGncsfyqT8i4wp41j9hTgLNKKhCtKwyqOtXlzwwY2nkp1efCcyLXi1lC/MhvjLdBR
 RPtoAWl7U5vys6b54/xOJqelnOmr0rNOp2rEtCtbGCVtwtCrJWIJpjgz1npjptHRDN1mTjPanf1
 +uGECQNIX8QRBoW4VEdwOmNwrO85MBN8DubzvfOZLXYWbsiihK0NG0dYv6eVMeM/OtiqhlGdbuT
 yWPtyvTfXKvteYj2eJD2LzP3pME7fv+l7BpmhoBWOjXoyOMN1TDC5p8YET24KoBOPXY0YVYmOKz
 g5oUKuu897V2pJk/
X-Received: by 2002:a17:907:3f24:b0:ac7:e80a:c6f9 with SMTP id
 a640c23a62f3a-acb74af255fmr1683396566b.1.1745401272697; 
 Wed, 23 Apr 2025 02:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwC5gbD141pwWEThOthqh39gX1rFCRE68f7IrbFHZvmYiFQ+ZiE2abh8wN6q6fMPbfgDlenw==
X-Received: by 2002:a17:907:3f24:b0:ac7:e80a:c6f9 with SMTP id
 a640c23a62f3a-acb74af255fmr1683394066b.1.1745401272274; 
 Wed, 23 Apr 2025 02:41:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb8cca2323sm623837966b.181.2025.04.23.02.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-stable@nongnu.org
Subject: [PULL 03/34] target/i386: Reset parked vCPUs together with the online
 ones
Date: Wed, 23 Apr 2025 11:40:33 +0200
Message-ID: <20250423094105.40692-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Commit 3f2a05b31ee9 ("target/i386: Reset TSCs of parked vCPUs too on VM
reset") introduced a way to reset TSCs of parked vCPUs during VM reset to
prevent them getting desynchronized with the online vCPUs and therefore
causing the KVM PV clock to lose PVCLOCK_TSC_STABLE_BIT.

The way this was done was by registering a parked vCPU-specific QEMU reset
callback via qemu_register_reset().

However, it turns out that on particularly device-rich VMs QEMU reset
callbacks can take a long time to execute (which isn't surprising,
considering that they involve resetting all of VM devices).

In particular, their total runtime can exceed the 1-second TSC
synchronization window introduced in KVM commit 5d3cb0f6a8e3 ("KVM:
Improve TSC offset matching").
Since the TSCs of online vCPUs are only reset from "synchronize_post_reset"
AccelOps handler (which runs after all qemu_register_reset() handlers) this
essentially makes that fix ineffective on these VMs.

The easiest way to guarantee that these parked vCPUs are reset at the same
time as the online ones (regardless how long it takes for VM devices to
reset) is to piggyback on post-reset vCPU synchronization handler for one
of online vCPUs - as there is no generic post-reset AccelOps handler that
isn't per-vCPU.

The first online vCPU was selected for that since it is easily available
under "first_cpu" define.
This does not create an ordering issue since the order of vCPU TSC resets
does not matter.

Fixes: 3f2a05b31ee9 ("target/i386: Reset TSCs of parked vCPUs too on VM reset")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/e8b85a5915f79aa177ca49eccf0e9b534470c1cd.1743099810.git.maciej.szmigiero@oracle.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa39..951e8214e07 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -437,9 +437,8 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_fd;
 }
 
-static void kvm_reset_parked_vcpus(void *param)
+static void kvm_reset_parked_vcpus(KVMState *s)
 {
-    KVMState *s = param;
     struct KVMParkedVcpu *cpu;
 
     QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
@@ -2738,7 +2737,6 @@ static int kvm_init(MachineState *ms)
     }
 
     qemu_register_reset(kvm_unpoison_all, NULL);
-    qemu_register_reset(kvm_reset_parked_vcpus, s);
 
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
@@ -2908,6 +2906,10 @@ static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg
 void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 {
     run_on_cpu(cpu, do_kvm_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+
+    if (cpu == first_cpu) {
+        kvm_reset_parked_vcpus(kvm_state);
+    }
 }
 
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
-- 
2.49.0


