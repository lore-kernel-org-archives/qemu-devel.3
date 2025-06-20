Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81601C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYsj-0005qR-Bf; Fri, 20 Jun 2025 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uSYsc-0005pf-GF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uSYsZ-0006L8-Tt
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750414908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i/DrvFZNHWseLx2S0XzpNtVupNMJ2Czh2hQX5BlapFA=;
 b=S0vPpK3+NUwnMT4+3nYq/zbi1iBjwIv0cmhHTbtsMo9UW2+mtEeZHLfgYmsDp4jJhlHjjX
 Y5JPYLQR/mzdD2+lHw6ubP8QuEg5jeyM2kiJ32hNUSioVZlpMRQGS87UA0Ef0sNqyF4Y0o
 EjU8e/kWLHA2eGFTLiwPoWFNx3XUGIg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-nT6aAUs3MsO8lFudCGMjFQ-1; Fri,
 20 Jun 2025 06:21:46 -0400
X-MC-Unique: nT6aAUs3MsO8lFudCGMjFQ-1
X-Mimecast-MFC-AGG-ID: nT6aAUs3MsO8lFudCGMjFQ_1750414906
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC36A1956089
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:21:45 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.33.241])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAA2D19560A3; Fri, 20 Jun 2025 10:21:44 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] MAINTAINERS: Update Kostiantyn Kostiuk transliteration
Date: Fri, 20 Jun 2025 13:21:40 +0300
Message-ID: <20250620102140.38556-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c4076127..3e7ca85c55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3370,7 +3370,7 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QEMU Guest Agent
 M: Michael Roth <michael.roth@amd.com>
-M: Konstantin Kostiuk <kkostiuk@redhat.com>
+M: Kostiantyn Kostiuk <kkostiuk@redhat.com>
 S: Maintained
 F: qga/
 F: contrib/systemd/qemu-guest-agent.service
@@ -3381,7 +3381,7 @@ F: tests/*/test-qga*
 T: git https://github.com/mdroth/qemu.git qga
 
 QEMU Guest Agent Win32
-M: Konstantin Kostiuk <kkostiuk@redhat.com>
+M: Kostiantyn Kostiuk <kkostiuk@redhat.com>
 S: Maintained
 F: qga/*win32*
 F: qga/vss-win32/
-- 
2.48.1


