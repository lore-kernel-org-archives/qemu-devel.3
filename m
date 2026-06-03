Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D3ECD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfHr-0003jE-DF; Wed, 03 Jun 2026 02:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHW-0003QA-JX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHT-0000q2-3F
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780468845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/1NMFbCCTiIHLk8JtsDwjURe28Qph3Ze1ot3C5bz1c=;
 b=ff6DSGrKnoY/uHi3GnFT1ZWt75KQiWFaOciVEo6ORpUK6eziZjOOs2oPrP812DepXLSKmB
 RHNoGRsY0OzDOrk9wBGi6jkR1ZudM3rVLrbxuiLLvXYcFL7mPy/ZDBUnrXccmLQf3x4QVg
 q2ST9cGRciYbY2FAU+MJudmkauqt3R0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-RLawYz73OIqh5JmmI2ZwEw-1; Wed,
 03 Jun 2026 02:40:39 -0400
X-MC-Unique: RLawYz73OIqh5JmmI2ZwEw-1
X-Mimecast-MFC-AGG-ID: RLawYz73OIqh5JmmI2ZwEw_1780468838
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FAAD180049F; Wed,  3 Jun 2026 06:40:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2345A30001A7; Wed,  3 Jun 2026 06:40:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5652F21E6A25; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 09/38] MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
Date: Wed,  3 Jun 2026 08:40:03 +0200
Message-ID: <20260603064032.3733394-10-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

include/hw/block/dataplane/xen* does not exist.
hw/block/dataplane/xen* does, and is covered.  Drop the bad line.

Fixes: fcab2b464e (xen: add header and build dataplane/xen-block.c, 2019-01-08)
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Anthony PERARD <anthony@xenproject.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 269c26196d..3a99c84839 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -634,7 +634,6 @@ F: hw/xen/
 F: hw/xenpv/
 F: hw/i386/xen/
 F: hw/pci-host/xen_igd_pt.c
-F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
 F: include/system/xen.h
 F: include/system/xen-mapcache.h
-- 
2.54.0


