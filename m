Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02A2CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUDn-0005Ou-Tq; Tue, 03 Sep 2024 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slUDk-0005CE-MZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slUDi-0008Ok-Fc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725372560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jjhSCJBJuSAurBQThL2GuR+Yd4wjnt/EI+Br8d8wwkM=;
 b=LthbPTNMrE0l7WrkqBr6UT/V71e9NkCEoQV0gwy3lZkhTQUypDqeJdwqmsBImaAGMxz7NV
 0BV8enC7XrQ1bsEKvYueH6HaXhyA0IQQSJaq2WP6nhWsLOSQX9P4dRYq7UrTFZefEqcd53
 na/Hvu+5ACWYgrVNHdAgWpvrHMt/RIo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-hTd0IyMKPW6oxUtYT9NXFQ-1; Tue, 03 Sep 2024 10:00:57 -0400
X-MC-Unique: hTd0IyMKPW6oxUtYT9NXFQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2052d07ff07so35447585ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725372055; x=1725976855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjhSCJBJuSAurBQThL2GuR+Yd4wjnt/EI+Br8d8wwkM=;
 b=DNXMRFZEjHVqwo7MPI9d2BnMUpJj5GjrBSg+/mP0kflBF7dbBQortx3ISUVjlMDqqd
 MpGVRid+2cdjDu61+ww+aVH5Be7Hhu9L4THiFe2l6yDR1DUPHwDhEMG0t/DUJM7M7fUS
 37Zs8qa504Yw/KJNZSe4SfvpGTaoku0aknd1B6WsQzRXXYjRnX2RpY+JhxjQ4cM557Hh
 eiH3wbsE/ilqWi39Y2FiE57dnACFrepw2zN3j4Z4k/Wm+b57rFmu4jI0/8FIq5WKeDP8
 /1MbLNVJ75p5tkY3P6B53bYSvZj40tYllPCU4XODyYvopnp8zvofjCMDDg6wp4u1s0uC
 xiIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcecCYSrkAdct09fnR4zfJH4bXUP1+2t1xMScT4mkLzM0CJ48BNbgxlWAZUcqDNVmlNCkm6LBYBT34@nongnu.org
X-Gm-Message-State: AOJu0Yy11v3HJJpXMSFkl7WT1xEaJYKv87iE4uCP5bvXD25TN9vsBySC
 1nKmYI+GRShBP+kTCZ2kGH89WGsun/9EJ5UKboxzfdYGjWaONWQWxTeTX9KSjBSN+Ch3nExwW68
 KZUEGjF5P2EzJSDuiI2fGsNd+wUYbILZbiwRxLUeBA5JRoS5jPMb9
X-Received: by 2002:a17:902:f786:b0:203:a02c:992b with SMTP id
 d9443c01a7336-2054bc96937mr79291745ad.3.1725372055366; 
 Tue, 03 Sep 2024 07:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESt9Cl068xl1wlir0hWjmhG+W99U/WXJNrsXvb0csaMwc4arZlnKCEMz2eall7CtqN3IZy9Q==
X-Received: by 2002:a17:902:f786:b0:203:a02c:992b with SMTP id
 d9443c01a7336-2054bc96937mr79291325ad.3.1725372054841; 
 Tue, 03 Sep 2024 07:00:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2057554f328sm32900445ad.266.2024.09.03.07.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 07:00:54 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, philmd@linaro.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3] kvm/i386: make kvm_filter_msr() and related definitions
 private to kvm module
Date: Tue,  3 Sep 2024 19:30:45 +0530
Message-ID: <20240903140045.41167-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
easy for developers to understand that its not used anywhere else.
Same for QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers definitions.

CC: philmd@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c      | 12 +++++++++++-
 target/i386/kvm/kvm_i386.h | 11 -----------
 2 files changed, 11 insertions(+), 12 deletions(-)

changelog:
v2: make QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers private
to kvm.c
v3: typo fix. tags added.

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e3..d714f54ee4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -92,7 +92,17 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
 
+typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
+typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
+typedef struct kvm_msr_handlers {
+    uint32_t msr;
+    QEMURDMSRHandler *rdmsr;
+    QEMUWRMSRHandler *wrmsr;
+} KVMMSRHandlers;
+
 static void kvm_init_msrs(X86CPU *cpu);
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                           QEMUWRMSRHandler *wrmsr);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -5728,7 +5738,7 @@ static bool kvm_install_msr_filters(KVMState *s)
     return true;
 }
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr)
 {
     int i;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b..9de9c0d303 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -66,17 +66,6 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
 
-typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
-typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
-typedef struct kvm_msr_handlers {
-    uint32_t msr;
-    QEMURDMSRHandler *rdmsr;
-    QEMUWRMSRHandler *wrmsr;
-} KVMMSRHandlers;
-
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr);
-
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
-- 
2.42.0


