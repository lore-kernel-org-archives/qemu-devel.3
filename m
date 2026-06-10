Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB4ACD98C8
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDvw-00011f-RL; Wed, 10 Jun 2026 04:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvr-0000tr-7r
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvo-0000aG-0E
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j69tvMAjJEVdJM+/oqEsbkPf+mVWEmh1vbSUtmQ5D+E=;
 b=Bv7sv0jWAMhrqKruS8UIdIryXGjiL7wa2g70H9eVBDAU1tJlVUMiVizNBB9OWerTihv+BX
 s1vQoringe/tvBLTttEgVt2BWSllo1so9fbdIgg/X9+e/Zaf4yx3e9pfjcsI2rgIQnE8vE
 m5ezb6NInjgGRqoiLbExWPvmBg/u4/M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-ik2K_Z19NNi6TCbNuX_RZQ-1; Wed,
 10 Jun 2026 04:04:55 -0400
X-MC-Unique: ik2K_Z19NNi6TCbNuX_RZQ-1
X-Mimecast-MFC-AGG-ID: ik2K_Z19NNi6TCbNuX_RZQ_1781078693
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB1FB194510E; Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 470201800595; Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2F9621E6A37; Wed, 10 Jun 2026 10:04:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL 13/42] MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
Date: Wed, 10 Jun 2026 10:04:18 +0200
Message-ID: <20260610080447.1156502-14-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

include/hw/block/dataplane/xen* does not exist.
hw/block/dataplane/xen* does, and is covered.  Drop the bad line.

Fixes: fcab2b464e (xen: add header and build dataplane/xen-block.c, 2019-01-08)
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Anthony PERARD <anthony@xenproject.org>
Message-ID: <20260603064032.3733394-10-armbru@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40413cae91..dd691ddbd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,7 +636,6 @@ F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
 F: hw/pci-host/xen_igd_pt.c
-F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/system/xen.h
 F: include/system/xen-mapcache.h
-- 
2.54.0


