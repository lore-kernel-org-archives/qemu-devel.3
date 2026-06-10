Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A8FCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDvr-0000uI-Ka; Wed, 10 Jun 2026 04:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvo-0000rT-Dz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvm-0000ZM-KE
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpBriOZ51TKkd2HJIVM3oraxLTDVt5gky+e+lxXaLMw=;
 b=Ozgb5uV7XWHmIT5rwzbq3mFHd0Pg758b6hanVnLI06mrCRRrX6SalmK87qQ3qm1RwY44TW
 kNe2DTRYWxyATiLpz74Z3FV6+NpQhiCI3Lq7+mJUGhZ/ODV+jX9SWHXSHeh7Ktoqyaiphq
 VCwQ7UD75xFz3AZjPswdRsz2Aj84oPc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-xoVrv-rpMAuC-gCurqGfGw-1; Wed,
 10 Jun 2026 04:04:54 -0400
X-MC-Unique: xoVrv-rpMAuC-gCurqGfGw-1
X-Mimecast-MFC-AGG-ID: xoVrv-rpMAuC-gCurqGfGw_1781078693
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 525431805C32; Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F2E036927; Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A709721E6A09; Wed, 10 Jun 2026 10:04:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/42] MAINTAINERS: Delete trailing colons in section headlines
Date: Wed, 10 Jun 2026 10:04:11 +0200
Message-ID: <20260610080447.1156502-7-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These are harmless as far as I can tell, so this is just for
consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260603064032.3733394-3-armbru@redhat.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 552adaadb7..07f5f3b39d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2837,7 +2837,7 @@ F: docs/interop/vhost-user-gpu.rst
 F: contrib/vhost-user-gpu
 F: hw/display/vhost-user-*
 
-qemu-vnc:
+qemu-vnc
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Maintained
 F: tools/qemu-vnc
@@ -4461,7 +4461,7 @@ F: include/hw/remote/iommu.h
 F: tests/functional/multiprocess.py
 F: tests/functional/*/*multiprocess.py
 
-VFIO-USER:
+VFIO-USER
 M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 M: Cédric Le Goater <clg@redhat.com>
@@ -4473,7 +4473,7 @@ F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
 F: tests/functional/x86_64/test_vfio_user_client.py
 
-EBPF:
+EBPF
 M: Jason Wang <jasowang@redhat.com>
 R: Yuri Benditovich <ybendito@redhat.com>
 S: Maintained
-- 
2.54.0


