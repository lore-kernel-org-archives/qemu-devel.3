Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D51CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDvu-0000xs-M3; Wed, 10 Jun 2026 04:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvs-0000uz-9e
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvo-0000ab-7u
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1+VCqzqajnbYAhxmoPfFAMqrzbFj8ti7z2f2iO4QIc=;
 b=PoOmMDOGAgU7zNePsYFFit5DHZPhUp0uZ2SzPuw4hTJfIY+3BrtZxNuFC4iypviZ8Ns3UR
 HF5a71QVBH5xiZ2nd9kEcWO72862FePnVsWa97BukSYy3Zf+3YVbAux+0haea4/bQD4S/S
 HzEi1Sz0lNBy8H9Xmkiy666j4sqdjS0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-06K6e1iWM2KVcTCUqRt0Yg-1; Wed,
 10 Jun 2026 04:04:57 -0400
X-MC-Unique: 06K6e1iWM2KVcTCUqRt0Yg-1
X-Mimecast-MFC-AGG-ID: 06K6e1iWM2KVcTCUqRt0Yg_1781078696
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EDE01954B2A; Wed, 10 Jun 2026 08:04:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ADA236535; Wed, 10 Jun 2026 08:04:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06E5721E649A; Wed, 10 Jun 2026 10:04:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 27/42] MAINTAINERS: Fix F: in "vhost-user-stubs"
Date: Wed, 10 Jun 2026 10:04:32 +0200
Message-ID: <20260610080447.1156502-28-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We neglected to update MAINTAINERS when we renamed
hw/virtio/vhost-user-device-pci.c and hw/virtio/vhost-user-device.c to
hw/virtio/vhost-user-test-device-pci.c and
hw/virtio/vhost-user-test-device.c.  Update it now.

Fixes: 722e9022a0 (hw/virtio: rename vhost-user-device and make user creatable, 2025-09-01)
Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260603064032.3733394-24-armbru@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaa13a5e91..3d646b64a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2534,7 +2534,7 @@ vhost-user-stubs
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
 F: hw/virtio/vhost-user-base.c
-F: hw/virtio/vhost-user-device*
+F: hw/virtio/vhost-user-test-device*
 
 vhost-user-rng
 M: Mathieu Poirier <mathieu.poirier@linaro.org>
-- 
2.54.0


