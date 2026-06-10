Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5239CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDwF-0001F7-JR; Wed, 10 Jun 2026 04:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvw-000115-5j
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvq-0000ck-Lb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA39rDQ7e/toS9JmXeQQ2KdKQPVHbkIQAGpgMKEU/Dc=;
 b=X9HrdZRWhvl1OGzv+Gk7KRygJw5Sz3Y97IAxqJZ75gTvNwrJgYzyP80/7K/1BBepj1ZTIP
 v67umqroClipu+ybiBkKrJsVqBoILSARaA3KkWMckQknHq+IphLz+xkqdAzyoj1xbDNXq3
 O5APlvrUdi43ECY/LuCbHUsbhM8fCA0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-6CKoEB1DN-6-8PjnQPg76g-1; Wed,
 10 Jun 2026 04:05:00 -0400
X-MC-Unique: 6CKoEB1DN-6-8PjnQPg76g-1
X-Mimecast-MFC-AGG-ID: 6CKoEB1DN-6-8PjnQPg76g_1781078699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2499E195DE2A; Wed, 10 Jun 2026 08:04:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D304E3008B35; Wed, 10 Jun 2026 08:04:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37C4F21E64AF; Wed, 10 Jun 2026 10:04:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 39/42] MAINTAINERS: Fix F: in "VFIO-USER"
Date: Wed, 10 Jun 2026 10:04:44 +0200
Message-ID: <20260610080447.1156502-40-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The commit adding the section added two bad F: lines:
include/hw/vfio-user/ never existed, and subprojects/libvfio-user had
long been replaced by subprojects/libvfio.wrap.  Drop the former, and
correct the latter.

Fixes: 9fca2b7d70 (vfio-user: add vfio-user class and container, 2025-06-25)
Cc: John Levon <john.levon@nutanix.com>
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Message-ID: <20260603064032.3733394-36-armbru@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce0a70a0a..7e3a712c04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4451,8 +4451,7 @@ S: Supported
 F: docs/interop/vfio-user.rst
 F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
-F: include/hw/vfio-user/*
-F: subprojects/libvfio-user
+F: subprojects/libvfio-user.wrap
 F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF
-- 
2.54.0


