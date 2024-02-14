Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4D6C48BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH0j-0007hR-RF; Wed, 14 Feb 2024 10:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0h-0007gt-9J
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0f-0000LD-9W
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5aOVJSEpKei/7ex6EeASiVcKRUD1LDRJrwBUNnZEXU=;
 b=hIgFVXJ5OecC0ZD3+1e6y9Q2ooUxNrE8zCUUp6XF0Lcs4W9B0gocYWQNSzOU8xsOpGW7d2
 Ggn+DZCdKS6ec4N4VoFZr+kHsRDq+c5blKTVOnmtYULwNhS6FPzFjYoi77y58Y1Efdqrca
 YEQFHS8wfd4ETwltkCOXu6k1kFR7Pcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-lvvM4uYSMBSsSnzfrGQzvg-1; Wed, 14 Feb 2024 10:17:12 -0500
X-MC-Unique: lvvM4uYSMBSsSnzfrGQzvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3626483F265;
 Wed, 14 Feb 2024 15:17:12 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 525771C02ECA;
 Wed, 14 Feb 2024 15:17:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PATCH v2 02/14] libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS to
 509
Date: Wed, 14 Feb 2024 16:16:49 +0100
Message-ID: <20240214151701.29906-3-david@redhat.com>
In-Reply-To: <20240214151701.29906-1-david@redhat.com>
References: <20240214151701.29906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's support up to 509 mem slots, just like vhost in the kernel usually
does and the rust vhost-user implementation recently [1] started doing.
This is required to properly support memory hotplug, either using
multiple DIMMs (ACPI supports up to 256) or using virtio-mem.

The 509 used to be the KVM limit, it supported 512, but 3 were
used for internal purposes. Currently, KVM supports more than 512, but
it usually doesn't make use of more than ~260 (i.e., 256 DIMMs + boot
memory), except when other memory devices like PCI devices with BARs are
used. So, 509 seems to work well for vhost in the kernel.

Details can be found in the QEMU change that made virtio-mem consume
up to 256 mem slots across all virtio-mem devices. [2]

509 mem slots implies 509 VMAs/mappings in the worst case (even though,
in practice with virtio-mem we won't be seeing more than ~260 in most
setups).

With max_map_count under Linux defaulting to 64k, 509 mem slots
still correspond to less than 1% of the maximum number of mappings.
There are plenty left for the application to consume.

[1] https://github.com/rust-vmm/vhost/pull/224
[2] https://lore.kernel.org/all/20230926185738.277351-1-david@redhat.com/

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index c882b4e3a2..deb40e77b3 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -31,10 +31,12 @@
 #define VHOST_MEMORY_BASELINE_NREGIONS 8
 
 /*
- * Set a reasonable maximum number of ram slots, which will be supported by
- * any architecture.
+ * vhost in the kernel usually supports 509 mem slots. 509 used to be the
+ * KVM limit, it supported 512, but 3 were used for internal purposes. This
+ * limit is sufficient to support many DIMMs and virtio-mem in
+ * "dynamic-memslots" mode.
  */
-#define VHOST_USER_MAX_RAM_SLOTS 32
+#define VHOST_USER_MAX_RAM_SLOTS 509
 
 #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
 
-- 
2.43.0


