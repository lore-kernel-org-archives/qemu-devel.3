Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA3BCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyQA-0000KP-7N; Thu, 21 May 2026 04:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPY-0007mF-5d
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPW-0007Ga-My
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsZShazR8NuE/I5DW/aKpwfifrc1UYGmXYf1GAprSq4=;
 b=fxPjUBOxuR5zMw5aQvbrLeaHXrCkBta8LBbZ73UrZZ+1N5LaTWsCy8Jdu4ddnYxuvziPIe
 Dc0BkmPqkrVz8ysrr5+14mwJhCuWID9bBCgAJCb9kEh+NEK/sVgU3vFuLD/9dxjcpE2tOP
 mfWHqyGsDcvC2a0tbmlepS1QWAiCF4c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-pnsAZ4CYPL23JXnGFNHOKQ-1; Thu,
 21 May 2026 04:05:22 -0400
X-MC-Unique: pnsAZ4CYPL23JXnGFNHOKQ-1
X-Mimecast-MFC-AGG-ID: pnsAZ4CYPL23JXnGFNHOKQ_1779350720
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8344218002C8; Thu, 21 May 2026 08:05:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E3A41800357; Thu, 21 May 2026 08:05:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3254A21E65EF; Thu, 21 May 2026 10:05:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
Subject: [PATCH 23/39] MAINTAINERS: Fix bad / stale F: in "virtio-rng"
Date: Thu, 21 May 2026 10:04:55 +0200
Message-ID: <20260521080511.999266-24-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-1-armbru@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

tools/vhost-user-rng/* never existed.  Drop the bad line.

We neglected to update MAINTAINERS when we moved
docs/system/devices/vhost-user-rng.rst to docs/system/devices/virtio/.
We later deleted the file.  Drop the stale line.

Fixes: e3e01466bf (MAINTAINERS: Add maintainer for vhost-user RNG implementation, 2021-06-14)
Fixes: 487ce6ce99 (docs/system: split VirtIO devices from the rest, 2025-10-16)
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d58459d7f0..8fff1649ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2541,11 +2541,9 @@ F: hw/virtio/vhost-user-device*
 vhost-user-rng
 M: Mathieu Poirier <mathieu.poirier@linaro.org>
 S: Supported
-F: docs/system/devices/vhost-user-rng.rst
 F: hw/virtio/vhost-user-rng.c
 F: hw/virtio/vhost-user-rng-pci.c
 F: include/hw/virtio/vhost-user-rng.h
-F: tools/vhost-user-rng/*
 
 vhost-user-gpio
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.54.0


