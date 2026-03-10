Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BA6FCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4i-0006wE-N2; Tue, 10 Mar 2026 01:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4O-0006pJ-Ko
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4K-0006EA-Js
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KXRaJiDAkoIl8DyFh2lNCPL1Jetdk1ohZihoYYyEHw=;
 b=cxC/ofSD8qTN1otan7mcLTemgIp2zByadktx5RczYTXpxRIIELA6x39Qwpc+juUqgKO9qR
 q4JEey8Or9wO+8sILrH8trQQtjOmxW4FNUJ9EdFfRJ6vflozFU4tU3/jyXzwg9rZMkue+u
 bM9ke7SvofN/vcMlLOTus9CoXyTMaaE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-HrxZAwSFPga4OhYzeVHn-w-1; Tue,
 10 Mar 2026 01:55:45 -0400
X-MC-Unique: HrxZAwSFPga4OhYzeVHn-w-1
X-Mimecast-MFC-AGG-ID: HrxZAwSFPga4OhYzeVHn-w_1773122144
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61D9C195608A; Tue, 10 Mar 2026 05:55:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F76A1956095; Tue, 10 Mar 2026 05:55:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Reinoud Zandijk <reinoud@NetBSD.org>
Subject: [PULL 03/25] tests/functional/ppc/test_40: Fix the URL of the
 NetBSD-7.1.2-prep.iso asset
Date: Tue, 10 Mar 2026 06:55:08 +0100
Message-ID: <20260310055530.8893-4-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We now need a slightly different URL to be able to download this asset.

Suggested-by: Reinoud Zandijk <reinoud@NetBSD.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260212143843.287090-1-thuth@redhat.com>
---
 tests/functional/ppc/test_40p.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/ppc/test_40p.py b/tests/functional/ppc/test_40p.py
index 614972a7eb3..ed272147f6e 100755
--- a/tests/functional/ppc/test_40p.py
+++ b/tests/functional/ppc/test_40p.py
@@ -27,7 +27,7 @@ class IbmPrep40pMachine(QemuSystemTest):
         'f86236e9d01b3f0dd0f5d3b8d5bbd40c68e78b4db560a108358f5ad58e636619')
     ASSET_NETBSD71 = Asset(
         ('https://archive.netbsd.org/pub/NetBSD-archive/'
-         'NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso'),
+         'NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso?key=NetBSD'),
         'cc7cb290b06aaa839362deb7bd9f417ac5015557db24088508330f76c3f825ec')
 
     # 12H0455 PPS Firmware Licensed Materials
-- 
2.53.0


