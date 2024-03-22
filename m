Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96AFC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNR-0006os-RV; Fri, 22 Mar 2024 14:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNK-0006eU-UL
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNI-00073g-CL
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ1i93OLH0rJPkws1vcaOOsOxlg3B1IE3zBDSu2Pk2c=;
 b=JJsEkhJGNTKAeDZ2bV7Zfx0c+l4Q/JdFvTsPeGrcMDIQtVtHWJtFNmMbq6DRTNzpjTTMXJ
 bV/juHisF7NQ7uqmWuhGT9s9OhCrKcs1zYSM+1cXgYaVpIuYVa23uL45tEpnuBFj9v4/OC
 /4fWttqrtS7VL1rnwq5MfDejVFQlEBc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-Veg-52g_MJSBA9af-yaEBQ-1; Fri, 22 Mar 2024 14:12:14 -0400
X-MC-Unique: Veg-52g_MJSBA9af-yaEBQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a473f5a84aaso3144166b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131133; x=1711735933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJ1i93OLH0rJPkws1vcaOOsOxlg3B1IE3zBDSu2Pk2c=;
 b=rNa/616bjzbKDbTVTTyjT6Lj99Ik19fEbWbfdUD8qFcedgAuMpSOd964n0AP17T6nZ
 8IFu8vtRCj7NZFWvUQxeQaSjX1KXLtW3ps+rBIjkNPNUPkQhDywxawGHHPMl+/cPxqWn
 RX7/KSvucQ+p9BhXCFKbLpig/jtlVhWsX54G577rnhUw3ef3Z5fGxS21rKecGubViPt3
 7NxBQcqP4CwFeJxMMKvxZ84ZepGpeNaRxCid4xIOzdOjdqlfShQgkmH6RG/s3X7q81er
 MhhSpo2RstasabUbwERzP2R6S6Pk+Bw5TlripYKbMaei1/l+myxBYapkG74W5nESyplU
 q+aA==
X-Gm-Message-State: AOJu0YxMOAxtmNU7a2yk66bJ9ZroAKczGpbU+Ii47Xt3X1iXuCpw+bBS
 KTmfv4FEnE2JA/HHKeNMvV+BIVNt7HB6vHlqihyvPs91WQhZcCsMUJpULzABCtUJsBlY3fcrSqZ
 Y3353Y+ILnr4s0GWJY1KYFuQtZq0MxDu5QX+LVakBRIb5tDm6KSqNa4af3eYOmTRLHMqxkOdEAj
 ihSjNyax7h2IOoR5iZh+5kuVF9IsVc4ZFLITby
X-Received: by 2002:a50:8a9a:0:b0:566:4a85:ceba with SMTP id
 j26-20020a508a9a000000b005664a85cebamr209524edj.1.1711131132846; 
 Fri, 22 Mar 2024 11:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqt7gNETxzL03L2rHMAZAcfDdiAAVL590d7iBvsTPwl9Sc6GtR/QgCVo66oUjJzUTdfcIn8A==
X-Received: by 2002:a50:8a9a:0:b0:566:4a85:ceba with SMTP id
 j26-20020a508a9a000000b005664a85cebamr209506edj.1.1711131132549; 
 Fri, 22 Mar 2024 11:12:12 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a50cc0a000000b0056b0af78d80sm74255edi.34.2024.03.22.11.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 17/26] trace/kvm: Split address space and slot id in
 trace_kvm_set_user_memory()
Date: Fri, 22 Mar 2024 19:11:07 +0100
Message-ID: <20240322181116.1228416-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The upper 16 bits of kvm_userspace_memory_region::slot are
address space id. Parse it separately in trace_kvm_set_user_memory().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240229063726.610065-5-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 5 +++--
 accel/kvm/trace-events | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a05dea23133..4ac3cf1c9ef 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -303,8 +303,9 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
     ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
     slot->old_flags = mem.flags;
 err:
-    trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
-                              mem.memory_size, mem.userspace_addr, ret);
+    trace_kvm_set_user_memory(mem.slot >> 16, (uint16_t)mem.slot, mem.flags,
+                              mem.guest_phys_addr, mem.memory_size,
+                              mem.userspace_addr, ret);
     if (ret < 0) {
         error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
                      " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index a25902597b1..9f599abc172 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,7 +15,7 @@ kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
 kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
-kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
+kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
 kvm_resample_fd_notify(int gsi) "gsi %d"
 kvm_dirty_ring_full(int id) "vcpu %d"
-- 
2.44.0


