Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56A3CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0X1-0006WO-OA; Thu, 23 Oct 2025 14:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X0-0006VM-3y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0Wx-0003Cw-4o
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMvVz+L6/dBIaEXwH2WldpTrPwKHBCrsIkQZ6bHOmlg=;
 b=SCZrlMcv0pMQOHCMOfJ9KDhXtBmnl2/iHqVoHWCywekIXEAVXqk0ZmpQ7fvHhUlo5LN0uf
 xBgDIMNPSDk723RiYzBAmmwwX/83BJw1wEK+B1klQfr9rDJHdu8kOYet7LA798Pvbzct/+
 FhfhwCHqzS8BQ02ApKilD27pbVv1MEU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-PkMf87woO2mWl9vnpqpVeg-1; Thu, 23 Oct 2025 14:59:21 -0400
X-MC-Unique: PkMf87woO2mWl9vnpqpVeg-1
X-Mimecast-MFC-AGG-ID: PkMf87woO2mWl9vnpqpVeg_1761245960
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87c2085ff29so31372636d6.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245960; x=1761850760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMvVz+L6/dBIaEXwH2WldpTrPwKHBCrsIkQZ6bHOmlg=;
 b=WdDtUq5tLRfjT4frCdXyhjyj6JIFkYigk3aAN/tkgS1Bbtct4S9ITZwZULgmLnFqph
 mlKD9B9gvZFgbjxat4himCAD7bWOu1nm42DCv90KPzouM+SSs/Og1w55mqjTsXMAPVQa
 NEzDQykx9ywZUxm1JcOaVYF+UloO2RhDSjDUljdwxYQuKOT2NVIbmuAIM8poOvAhVdDx
 Y6gLSXG1XjC9RNfkiZGxceGcRl1T/OOm1yYlnEyMNPTz7hX6JMxlAjpxtJFs8gWxAqAh
 KMB9I6BPNYsHG8FBbtcgG2M1/9wjxDeVMqWBE373UAoSFqDtphs5M35ynJ2gH9z19aUq
 hdTQ==
X-Gm-Message-State: AOJu0YzWMz2PHaeguA2Z2jfjGBs2U8DOjv6Vsp/QZZJpv6E5BVWjhgyV
 8IIoAg8nIZenRAC/2fFecYX4j9Lk7g4H96uESHAv0u/HBfs2S8TXRh6TDDM7pbrwWDBIU7GIX6u
 szMaVKVAAWnUocuUoxMb4E8VH50Osjqaw+EXeO4sh0JmQb9DMx6dCNlYwDBrPGSZN8xYN/GaQoy
 neEwf1p6ZBNYNZSKgxB/foWWB/TUjzdThI8sGmWA==
X-Gm-Gg: ASbGncsRUNYKPyQTHN57ezTV0BrcB27ty3dM16o12P8G1yVp0DtT0DE1fKxaxOI42VV
 QwnNGzQxbe5lfIsTZ08WUeeAP2LlYARHlQwghyJhwJV28lzT7J+kpa+LPcgCPEtYC5Gi21spEfd
 yqEum8gS5xcEbAWHMzXOSHlVOjEqh5SUT0QZkGD9zeDn1HGdahRFz2/1akdGopY1G45eAfcR36a
 G56k1XBXlxJjZqvc9RFmQKhCqfbV7uaXDLp2fVXy5Sr/UTOWS/hzqI9MIc2QkWkNGWsEJBebkzv
 YyV4Ozrx2wMQ1vSPmpnCPaoSDzNCEicLeUSJTRq2mXQrhQ4AZ0z4wN++pq5HorA0
X-Received: by 2002:a05:620a:2544:b0:88e:4d7b:f5c8 with SMTP id
 af79cd13be357-8906e9a512emr2944299985a.20.1761245959970; 
 Thu, 23 Oct 2025 11:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUDFsev2NEXB3iNCGbhCvmrUtyeqtwaRcWE5jIjIy2673QW5/kNt0AD4pd8A3m4oUSSloV0w==
X-Received: by 2002:a05:620a:2544:b0:88e:4d7b:f5c8 with SMTP id
 af79cd13be357-8906e9a512emr2944295785a.20.1761245959343; 
 Thu, 23 Oct 2025 11:59:19 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 2/8] kvm: Allow kvm_guest_memfd_supported for non-private use
 case
Date: Thu, 23 Oct 2025 14:59:07 -0400
Message-ID: <20251023185913.2923322-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Guest-memfd is not 100% attached to private, it's a VM-specific memory
provider.  Allow it to be created even without private attributes, for
example, when the VM can use the guest-memfd memory completely shared.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9254ae654..1425dfd8b3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2779,10 +2779,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
     }
 
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
-    kvm_guest_memfd_supported =
-        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+    kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
-- 
2.50.1


