Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68900EED60E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sol4B-0000DF-25; Thu, 12 Sep 2024 10:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sol47-0008W7-S8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sol46-0007R7-6K
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726152297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IYk5z4L6UVh/eqExHfcLbPdMWjZoVYTsykloWLy4VQ=;
 b=iVj6t9kB8u6isgqo4FtKuF62if9TfglMaHblza4k5MAlLa9gp72w4qVmc9lOercrdXViJp
 lLn4WrooM+ArsAa8xoesdTCPDrelYTI5DNdSbWM5Obo3laaDYHOJc3WNn69aRtvJowxpU3
 n0/eU1pqcMBmIyKtadA5UtofW03khcc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-gHJgxhQTMYqAz3RCcDEj9w-1; Thu,
 12 Sep 2024 10:44:54 -0400
X-MC-Unique: gHJgxhQTMYqAz3RCcDEj9w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06E461944CEE; Thu, 12 Sep 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F0303000235; Thu, 12 Sep 2024 14:44:48 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, hi@alyssa.is, mst@redhat.com, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 stevensd@chromium.org, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 2/3] vhost_user.rst: Align VhostUserMsg excerpt members
Date: Thu, 12 Sep 2024 16:44:31 +0200
Message-ID: <20240912144432.126717-3-aesteve@redhat.com>
In-Reply-To: <20240912144432.126717-1-aesteve@redhat.com>
References: <20240912144432.126717-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Add missing VhostUserShared and VhostUserTransferDeviceState
members to the VhostUserMsg excerpt in the vhost-user
spec documentation.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index d680fea4a3..ec898d2440 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -369,6 +369,8 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserConfig config;
           VhostUserVringArea area;
           VhostUserInflight inflight;
+          VhostUserShared object;
+          VhostUserTransferDeviceState transfer_state;
           VhostUserMMap mmap;
       };
   } QEMU_PACKED VhostUserMsg;
-- 
2.45.2


