Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CDDFA374F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6Ck-00033q-K2; Fri, 13 Sep 2024 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp6CZ-0002wX-Pc
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp6CY-00027i-7B
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726233544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Wq2gz2kJ2DpqJ0edWlOFNLeL/UQkcdpUB9mWh98cNQ=;
 b=F/5jNV/Nsbug3ZVH3jVH1gonZKvzwQiK/onILbltPnI7mteY7mbSmwGFD6ndWPKttggH0x
 6gGz4nQPDD8qy6zVDo1QsneR/XAtBHOHh0X0ds9jsAwp+8rQcakKUSQBi5/bfZEL9iaZ1U
 NrbeL1aREj4uW7edAVDdCsaJzT50WcM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-gjZEIDtbMiyXcomOa7yPZQ-1; Fri,
 13 Sep 2024 09:19:03 -0400
X-MC-Unique: gjZEIDtbMiyXcomOa7yPZQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37EEF193E8D1; Fri, 13 Sep 2024 13:19:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18C0A19560AB; Fri, 13 Sep 2024 13:18:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mzamazal@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org
Subject: [PATCH] hw/virtio/Kconfig: Include vhost-user-scmi only on arm targets
Date: Fri, 13 Sep 2024 15:18:58 +0200
Message-ID: <20240913131858.418407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The System Control and Management Interface is specific to arm
machines, so don't include this device in non-arm targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aa63ff7fd4..bea5be4d4a 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -109,4 +109,4 @@ config VHOST_USER_SND
 config VHOST_USER_SCMI
     bool
     default y
-    depends on VIRTIO && VHOST_USER
+    depends on VIRTIO && VHOST_USER && ARM
-- 
2.46.0


