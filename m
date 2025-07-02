Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD4DC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0r4-0003fo-T9; Wed, 02 Jul 2025 13:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qq-0003eY-Lg
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qp-0003Z8-6E
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPUG6OfqUOdsX8dIyOu0E2Gk0RS6xP7qM4XS3g6v5no=;
 b=gTR6msZjGWljT7at58I3/qkM9ncZ3APMPfe7CtvBWiGAuM8i1zpVTzP8IwVpmUpSLGNB7Y
 tTRHnxP+7zW/AiXf4ksvvQT2htZdBKMGtPwrn/OwpVilYz47Ru/7zyf94prfuDrNT7zIrI
 x3LIslllHTibp1wpOBrpSehONPmBCGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-wi4RM04XOziGUbQp4chq3A-1; Wed,
 02 Jul 2025 13:02:23 -0400
X-MC-Unique: wi4RM04XOziGUbQp4chq3A-1
X-Mimecast-MFC-AGG-ID: wi4RM04XOziGUbQp4chq3A_1751475742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3E7218D624E; Wed,  2 Jul 2025 17:02:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD9A219373D8; Wed,  2 Jul 2025 17:02:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 2/9] MAINTAINERS: fix vendor capitalization (Vmware -> VMware)
Date: Wed,  2 Jul 2025 19:01:57 +0200
Message-ID: <20250702170206.212303-3-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Sean Wei <me@sean.taipei>

"VMware" is the vendor's official spelling.
Adjust the spelling in MAINTAINERS for consistency.

Signed-off-by: Sean Wei <me@sean.taipei>
Message-ID: <20250616.qemu.relocated.03@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 749799b0f84..585f08e709e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2538,7 +2538,7 @@ F: net/eth.c
 F: hw/net/net_rx_pkt*
 F: hw/net/net_tx_pkt*
 
-Vmware
+VMware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
 F: docs/specs/vmw_pvscsi-spec.rst
-- 
2.50.0


