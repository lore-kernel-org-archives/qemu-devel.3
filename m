Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FBDC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpI7h-0005Xf-LZ; Tue, 26 Mar 2024 21:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpI7a-0005X4-3j
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpI7X-0003vI-7T
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711503024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8F0MIllH5clWMxBrxgR5uny6vEHitOHBq+RT3SWOBLI=;
 b=G72BJurp2yvLgWoYUmB/JaBP4E1HDI5Wos7ycHCyAYySbkaCOMASmMhJ/xqQduyCOkbP6Z
 ysw7jEMySUNknMds16kEyLdRDzuoqy8bQ1CQDsiHZZzMDvLYJUJUo9VEGTRL6+KY9XN6Pt
 +EDub2s9cATuxRX2i4C3kzkAXQZxVuA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-q31fhu74OWOXANwBjr0OEQ-1; Tue,
 26 Mar 2024 21:29:14 -0400
X-MC-Unique: q31fhu74OWOXANwBjr0OEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E44EA3C29842
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:29:13 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA2E6492BD4;
 Wed, 27 Mar 2024 01:29:11 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
Date: Wed, 27 Mar 2024 09:22:13 +0800
Message-ID: <20240327012905.70188-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

we need a crash in Non-standard image, here is the jira for this https://issues.redhat.com/browse/RHEL-28522
The root cause of the issue is that an IRQFD was used without initialization..

During the booting process of the Vyatta image, the behavior of the called function in qemu is as follows:

1. vhost_net_stop() was called, this will call the function
virtio_pci_set_guest_notifiers() with assgin= false, and
virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0

2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTORt

3.vhost_net_start() was called (at this time the configure vector is
still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
assgin= true, so the irqfd for vector 0 was not "init" during this process

4. The system continues to boot and msix_fire_vector_notifier() was
called unmask the vector 0 and then met the crash
[msix_fire_vector_notifier] 112 called vector 0 is_masked 1
[msix_fire_vector_notifier] 112 called vector 0 is_masked 0

The reason for not reproducing in RHEL/fedora guest image is because
REHL/Fedora doesn't have the behavior of calling vhost_net_stop and then virtio_reset, and also won't call msix_fire_vector_notifier for vector 0 during system boot.

The reason for not reproducing before configure interrupt support is because
vector 0 is for configure interrupt,  before the support for configure interrupts, the notifier process will not handle vector 0.

For the device Vyatta using, it doesn't support configure interrupts at all, So we plan to disable the configure interrupts in unsupported device

Signed-off-by: Cindy Lu <lulu@redhat.com>

Cindy Lu (2):
  virtio-net: disable the configure interrupt for not support device
  virtio-pci: check if the configure interrupt enable

 hw/net/virtio-net.c        |  5 ++++-
 hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-----------------
 hw/virtio/virtio.c         |  1 +
 include/hw/virtio/virtio.h |  1 +
 4 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.43.0


