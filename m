Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607BFCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxb0-00032i-Ro; Thu, 06 Nov 2025 05:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGxb0-00031O-6Y
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGxay-0002go-Rp
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762426319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kxG4bcSIcVh95gyP/1qKSKNMarnpO4PpjXeU41lxtDY=;
 b=PUxTqTUgqp5JFIQ4cVtpQ+qA5RbL4pyAqZqNERjOomjUEPaQ9u0gnNUEV5gEyF2o1D2roK
 lsCg+Tr1PzD2jN71OfjDyTpR8JR07fSUGJgKeUbLKIDsE1J8ddbpwrTUWrRXcA5dwDXMtG
 CnepuuMLjGF7dw5xwN2SkhX2/c4T2Hc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-ZG-23U1NOTeLNDTo-i-LrA-1; Thu,
 06 Nov 2025 05:51:56 -0500
X-MC-Unique: ZG-23U1NOTeLNDTo-i-LrA-1
X-Mimecast-MFC-AGG-ID: ZG-23U1NOTeLNDTo-i-LrA_1762426315
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0DF51956088; Thu,  6 Nov 2025 10:51:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.134])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DAD9180049F; Thu,  6 Nov 2025 10:51:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] hw/intc/ioapic: Fix ACCEL_KERNEL_GSI_IRQFD_POSSIBLE typo
Date: Thu,  6 Nov 2025 11:51:48 +0100
Message-ID: <20251106105148.737093-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit 638ac1c78457 introduced a regression in interrupt remapping
when running a VM configured with an intel-iommu device and an
assigned PCI VF. During boot, Linux reports repeated messages :

 [   15.416794] __common_interrupt: 2.37 No irq handler for vector
 [   15.417266] __common_interrupt: 2.37 No irq handler for vector
 [   15.417733] __common_interrupt: 2.37 No irq handler for vector
 [   15.418202] __common_interrupt: 2.37 No irq handler for vector
 [   15.418670] __common_interrupt: 2.37 No irq handler for vector

and may eventually hang.

The issue is caused by the incorrect use of the macro
ACCEL_KERNEL_GSI_IRQFD_POSSIBLE, which should instead be
ACCEL_GSI_IRQFD_POSSIBLE.

Fixes: 638ac1c78457 ("hw/intc: Generalize APIC helper names from kvm_* to accel_*")
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/ioapic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index e431d0031176800753795d6d29ccc22982e4f63b..38e438464861040341f73c576c3214e2ceab2f8a 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -216,7 +216,7 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
 #endif
 }
 
-#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
 static void ioapic_iec_notifier(void *private, bool global,
                                 uint32_t index, uint32_t mask)
 {
@@ -434,7 +434,7 @@ static const MemoryRegionOps ioapic_io_ops = {
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 {
-#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
 
-- 
2.51.1


