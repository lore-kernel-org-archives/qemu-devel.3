Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AF7CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9P8L-0008I7-AR; Thu, 16 Oct 2025 10:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9P8J-0008HB-9L
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9P84-0005Od-8z
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760625533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JRarTR2AYg3ChsZq/h++rQDJXjy/c1zeADcSA56lqE=;
 b=avcuj3DoxBO/KkUe7T0bXf5eyAcviWeoxaQLuxKzIzBOy13gIiMweCWTWx9zrhjKaC4HqV
 vfKqw9Jt8Mlispq6URhXGT5erdvTCKpUTSpYJuZJYWmfSnOlMlSO8xLta1GsI1krmc7IQi
 OEwFyGYhbHIeIq/6oATa7wVN3LO+c+k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Op5XBTDeMMqum7kEGdysZg-1; Thu,
 16 Oct 2025 10:38:50 -0400
X-MC-Unique: Op5XBTDeMMqum7kEGdysZg-1
X-Mimecast-MFC-AGG-ID: Op5XBTDeMMqum7kEGdysZg_1760625527
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73CFD195609D; Thu, 16 Oct 2025 14:38:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.164])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 567891800451; Thu, 16 Oct 2025 14:38:41 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, hi@alyssa.is,
 stefanha@redhat.com, david@redhat.com, jasowang@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 slp@redhat.com, manos.pitsidianakis@linaro.org,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v10 2/7] vhost_user.rst: Align VhostUserMsg excerpt members
Date: Thu, 16 Oct 2025 16:38:22 +0200
Message-ID: <20251016143827.1850397-3-aesteve@redhat.com>
In-Reply-To: <20251016143827.1850397-1-aesteve@redhat.com>
References: <20251016143827.1850397-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add missing members to the VhostUserMsg excerpt in
the vhost-user spec documentation.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 2e50f2ddfa..436a94c0ee 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -366,11 +366,15 @@ In QEMU the vhost-user message is implemented with the following struct:
           struct vhost_vring_state state;
           struct vhost_vring_addr addr;
           VhostUserMemory memory;
+          VhostUserMemRegMsg mem_reg;
           VhostUserLog log;
           struct vhost_iotlb_msg iotlb;
           VhostUserConfig config;
+          VhostUserCryptoSession session;
           VhostUserVringArea area;
           VhostUserInflight inflight;
+          VhostUserShared object;
+          VhostUserTransferDeviceState transfer_state;
       };
   } QEMU_PACKED VhostUserMsg;
 
-- 
2.49.0


