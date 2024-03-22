Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBB7C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNX-0007N0-Hj; Fri, 22 Mar 2024 14:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNU-00072c-QD
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNO-00074i-VJ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUBPSKRBAPOo+lQ/eTxjDUcxZLo5fXSFnvIO2PmnF9k=;
 b=LVS4bJnXy/s/5z0w/j8wLkHW2tWAaDH1OzDhpUgei66wybMWdCzMJAcX3l8Zk4ak5D1yWF
 bseJD74nEuPi+T+Dmkh2/M7e+ZSkXtTvFfXA7wPtBHmwZBEDFU1C1lMqOo9ZtOURX1HESZ
 VECo7u7/Z9p9Q7TDm7tded6sygfhBYI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-bCH1RyR1NhecZjXLaOeyRg-1; Fri, 22 Mar 2024 14:12:20 -0400
X-MC-Unique: bCH1RyR1NhecZjXLaOeyRg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4711e69b9bso130027166b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131136; x=1711735936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUBPSKRBAPOo+lQ/eTxjDUcxZLo5fXSFnvIO2PmnF9k=;
 b=RfrVCQtB1picmZoGak5Wo3h+z29Nx3HshsjJo4DSSxQ4k8fM/+JaPEYd75qt802CmK
 qNwG8c5OyrCdVUP5eyfa5Fk4rEWALy9/KPQbPLmcr5GSTYh4AEoUwC2GMvfmZw7mWnDl
 iOW/gKypvDxnGo2cN2YqDXyM/HG6yEn8gBvWnhdxvcnawOi2agFgGot6c8iUypN5SPp2
 WzMPM2w7kF1ZccFLC0DGBstoXWRKW7TfkvFYn7HsVpwlW+ZK5Ih5+gY0f69Yejl8+SOF
 mwsbTb8kKpNRHz/TVCp0NcfMZ2mGXS51kMrHh9vxI/6SfZKXrJxpYc60PwEGPPAlKfM+
 QSYg==
X-Gm-Message-State: AOJu0Yyxzvlq28tNMKCfrh1XnAqUQjuruHzZ4FVJqnB2YGpPQucsmuQ4
 RxfjTKxzf2WzVKoFO7kArbrPtzqSnSgUxm14DO9GhNWc6pSspEryTywoje/mzWBLdjZoJD+9WXO
 lYO4gEWSXvHh806pWKkwpgs1AKVsbqBBfqcOgL9ip4A8l+KlLtW8mZuAayDLWZ3U7Z6KxjuD1MY
 1BIhFNOvkcptvhcjtGaLLmWr238qa4w1Ie/ETv
X-Received: by 2002:a17:906:128d:b0:a47:25e4:f5c8 with SMTP id
 k13-20020a170906128d00b00a4725e4f5c8mr326383ejb.65.1711131135837; 
 Fri, 22 Mar 2024 11:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHymEeJZpYlsG7C5LT6JNwxJjbmm9VBD+qbDTCyyq9NKtl0r3gOy9qFplXIbuStRjAaj+8O0A==
X-Received: by 2002:a17:906:128d:b0:a47:25e4:f5c8 with SMTP id
 k13-20020a170906128d00b00a4725e4f5c8mr326369ejb.65.1711131135526; 
 Fri, 22 Mar 2024 11:12:15 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a170906091000b00a4735fc654fsm68782ejd.205.2024.03.22.11.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 18/26] kvm: Introduce support for memory_attributes
Date: Fri, 22 Mar 2024 19:11:08 +0100
Message-ID: <20240322181116.1228416-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Introduce the helper functions to set the attributes of a range of
memory to private or shared.

This is necessary to notify KVM the private/shared attribute of each gpa
range. KVM needs the information to decide the GPA needs to be mapped at
hva-based shared memory or guest_memfd based private memory.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240320083945.991426-11-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h |  4 ++++
 accel/kvm/kvm-all.c  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 54f4d83a370..bda309d5ffa 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -536,4 +536,8 @@ void kvm_mark_guest_state_protected(void);
  * reported for the VM.
  */
 bool kvm_hwpoisoned_mem(void);
+
+int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
+int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
+
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4ac3cf1c9ef..36e39fd6514 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -91,6 +91,7 @@ bool kvm_msi_use_devid;
 static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
+static uint64_t kvm_supported_memory_attributes;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -1266,6 +1267,35 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
     kvm_max_slot_size = max_slot_size;
 }
 
+static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
+{
+    struct kvm_memory_attributes attrs;
+    int r;
+
+    assert((attr & kvm_supported_memory_attributes) == attr);
+    attrs.attributes = attr;
+    attrs.address = start;
+    attrs.size = size;
+    attrs.flags = 0;
+
+    r = kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
+    if (r) {
+        error_report("failed to set memory (0x%lx+%#zx) with attr 0x%lx error '%s'",
+                     start, size, attr, strerror(errno));
+    }
+    return r;
+}
+
+int kvm_set_memory_attributes_private(hwaddr start, hwaddr size)
+{
+    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size)
+{
+    return kvm_set_memory_attributes(start, size, 0);
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -2382,6 +2412,7 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
+    kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
     s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
-- 
2.44.0


