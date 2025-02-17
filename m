Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3496C021AD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4C4-0004VY-E5; Mon, 17 Feb 2025 11:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4C3-0004VM-F9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4C1-0007wq-Ve
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SjDTh66mEQX1doULZPhA4TPZA1F/E9TYQcDWSRSI7Y=;
 b=hDyf8z/JjR7li/n5OifLBvSnlHrI+8WqD9fHzOWz26/ngDhEIoXjj/q+DiRZSDkirtwKwu
 4PO8Pu8KHvyNMcDECnr6vTKAMkVqIiZcvNqg1/B1o2IFppWBpSb6lRaIBq7uyJcXlTrXF+
 pF1wPqk/mCM6TwtkhvDPVa7UFokbEbE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-YIBB2mrrPiiXAgUHpiYVgg-1; Mon,
 17 Feb 2025 11:40:34 -0500
X-MC-Unique: YIBB2mrrPiiXAgUHpiYVgg-1
X-Mimecast-MFC-AGG-ID: YIBB2mrrPiiXAgUHpiYVgg_1739810431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7CA818D95E0; Mon, 17 Feb 2025 16:40:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.252])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 978DB1800358; Mon, 17 Feb 2025 16:40:25 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
 david@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 2/9] vhost_user.rst: Align VhostUserMsg excerpt members
Date: Mon, 17 Feb 2025 17:40:05 +0100
Message-ID: <20250217164012.246727-3-aesteve@redhat.com>
In-Reply-To: <20250217164012.246727-1-aesteve@redhat.com>
References: <20250217164012.246727-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add missing members to the VhostUserMsg excerpt in
the vhost-user spec documentation.

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
2.48.1


