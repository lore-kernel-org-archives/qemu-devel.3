Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BB9F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wI-0003N9-B1; Tue, 24 Feb 2026 22:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wE-0003C3-Ju
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wC-0008DR-St
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5fiyO5toFV4jV0KLoqJkMTJePRwiukufXlV5ZgaA7k=;
 b=PCKNnNpuinNn0tyFtF56jhmWMgsNgFkn52S0JNcMlDYw/jZuAM7s3W+RNC75roJ2BpVoHs
 Dmvp6ov5UTc092OWJ1Ax+fGOTq6NuRibD85Wj/n5QCveicLhNYAkwSUMR1V4XgfADJdesj
 f+/L31eknYZ7ZldpPGc5Lra0w0aj2Tc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-EA_gmIPfMWKRSf4lCysq_A-1; Tue, 24 Feb 2026 22:51:44 -0500
X-MC-Unique: EA_gmIPfMWKRSf4lCysq_A-1
X-Mimecast-MFC-AGG-ID: EA_gmIPfMWKRSf4lCysq_A_1771991504
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e79b4ca6so1140829a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991503; x=1772596303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5fiyO5toFV4jV0KLoqJkMTJePRwiukufXlV5ZgaA7k=;
 b=dDwrxOCf4UYVO1Mx4qjx+OYKFC0OSjhnlsVM4+uj9HAWwmXbpogaSvKCt9yNnKNkTi
 Zu9EqU97/JL7HRVU/+BPC07Dn+VRhm1gjLmemy2RcpoE/JnxcdQ62S+H09q9aV33LoL6
 iMjbV49+7ctt9qPOoqZoGOV0mwcQOCDwVrqFyI13l9S3a5PZsa//ePZmmROfFyxLOsBu
 SlJhX3jtsiw9gM5axm3VVwg2YihQDeArXL1YafsJLwMr/9bEtMATuawoS3auSOgf8mF1
 n1ndlmKERSjjyS+rP7iIp8jhBSW/+4LrDipJwrprvoLzpcet0j/v48VMlzwu33Wea/kd
 0YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991503; x=1772596303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M5fiyO5toFV4jV0KLoqJkMTJePRwiukufXlV5ZgaA7k=;
 b=AhqSpCuPQ/HNI1BI3OdGggUHWNPRafn8ZKXbeXOllV/ySUe/Pvofzy9Kc43dZmFqG2
 rNHRfbVUp+uWx1JXSKLYMWZoCTjh4smBTtCcnG0mSLT6Fu//Zj2GQJfjw9j7+WMNTS1r
 0T+Xkuy1agcOIiYWJaHIAVbs3ey+5wdFhGKg0UdIFspnwuNRdms7nZwO0pbaYTvU8F4b
 p/YYazNSfGjBKnBK1gbfVSLsFDQH59C736hitofuF24Cu3aKjGf/2VqShFYgXZXzwjRH
 q32zBOigqLqvHZmE6XkUIz+GlN3taRAFKlEZbdxcd8Lpj+WSZp96tdrDrm+KT/kRN9L8
 TrWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvzrtCIt7yTZstBJN7CNv8JFpNVEuzWaWtlRWvZHH/jK4gg/b4HHBprdx+UkyP9n/soo+RVGLkzH4/@nongnu.org
X-Gm-Message-State: AOJu0YxZ+yLvHUa+4Ba2C75of199xR2bzaG2tfow7F4fmFlqlxPbm+FY
 xuixTNInvnDvaQc8XdXJKfXRbICaLFW11/3iwrS6JvD4gNLC/84UFkc6dVOPfJ8Y8uUczI8b3AC
 T+lTMyowv+4VeU/40Wt2nbXqmfaT5E/Nx2BCPJuqX1kFeCL8oIS+3FaUA
X-Gm-Gg: ATEYQzxUwEATQ4cM2HAlyk9c3qDHIj7AZfI5T6ukax3M1xztx5zNGYfaeHkW3GpcHrJ
 u5TbKvmy9s/L8A6/1cVhbnbxjSW8R5FLWLOeBE1+T8kPNFpBW1OTab0na26sHu5qO96WEnkfna3
 Zm04gzCUfYjXvvusCu34WT5KwM2g4c1DCb92hmnAsY96gbquYtC1Wp1cjGHj3PsZar3wxbZ3KaY
 9/Q589RovpVF2lWFvwqHo1DqgJggauJfWZ4Pq/VQ0ADIwMn13iZ84/5guNyCAFs+U8kFKDkZ7px
 qt8E1jRUuSRohLYmTz2sBDwyuxHdG+zB8HXoax56WDKhOpD1O1r1vG0R6IScNYoOIXCu444P7yX
 lmOJSCg4FKp2da2hMBuPZ1774DD+GbBobnd2iYcDtbckCZCM+gu756Yw=
X-Received: by 2002:a17:90b:5185:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-3590f1f3c09mr822866a91.31.1771991503579; 
 Tue, 24 Feb 2026 19:51:43 -0800 (PST)
X-Received: by 2002:a17:90b:5185:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-3590f1f3c09mr822856a91.31.1771991503196; 
 Tue, 24 Feb 2026 19:51:43 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:42 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 28/35] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
Date: Wed, 25 Feb 2026 09:19:33 +0530
Message-ID: <20260225035000.385950-29-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On confidential guests KVM virtual machine file descriptor changes as a
part of the guest reset process. Xen capabilities needs to be re-initialized in
KVM against the new file descriptor.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/xen-emu.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 52de019834..29364a9279 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -44,9 +44,12 @@
 
 #include "xen-compat.h"
 
+NotifierWithReturn xen_vmfd_change_notifier;
+static uint32_t xen_msr;
 static void xen_vcpu_singleshot_timer_event(void *opaque);
 static void xen_vcpu_periodic_timer_event(void *opaque);
 static int vcpuop_stop_singleshot_timer(CPUState *cs);
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
 
 #ifdef TARGET_X86_64
 #define hypercall_compat32(longmode) (!(longmode))
@@ -54,6 +57,23 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
 #define hypercall_compat32(longmode) (false)
 #endif
 
+static int xen_handle_vmfd_change(NotifierWithReturn *n,
+                                  void *data, Error** errp)
+{
+    int ret;
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    ret = do_initialize_xen_caps(kvm_state, xen_msr);
+    if (ret < 0) {
+        return ret;
+    }
+    return 0;
+}
+
 static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
                            size_t *len, bool is_write)
 {
@@ -111,7 +131,7 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
     return kvm_gva_rw(cs, gva, buf, sz, true);
 }
 
-int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr)
 {
     const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
         KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
@@ -143,6 +163,19 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
                      strerror(-ret));
         return ret;
     }
+    return xen_caps;
+}
+
+int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
+{
+    int xen_caps;
+
+    xen_caps = do_initialize_xen_caps(s, hypercall_msr);
+    if (xen_caps < 0) {
+        return xen_caps;
+    }
+
+    xen_msr = hypercall_msr;
 
     /* If called a second time, don't repeat the rest of the setup. */
     if (s->xen_caps) {
@@ -185,6 +218,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     xen_primary_console_reset();
     xen_xenstore_reset();
 
+    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
+    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
+
     return 0;
 }
 
-- 
2.42.0


