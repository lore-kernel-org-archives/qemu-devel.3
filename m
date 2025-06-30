Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9693DC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWIDx-0002B9-H3; Mon, 30 Jun 2025 13:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWIDs-0002AW-Sy
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWIDq-00055p-3j
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751304192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2FIHlp4dsxijxXAk6+uDz+KHKBmOkyeRnIdYQ0Z3d0I=;
 b=EYrxlsVCtmoPO4qTJCKKMhdftWUwJSK5Pfd4alX9w10YRUz0XN317yMEZrmDu8CS6raD7L
 ujojlv0+N2pMyykc/G/oVzCyABpOFRidMtpJRhvO+NW2SnemK4O8gleG0PV9yiC3i48WAH
 1YfMXe4SkKckK1zeQWNRVV/iCfv3+TM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-d8ZF5q2pPz-K8S64TY1jjg-1; Mon,
 30 Jun 2025 13:23:09 -0400
X-MC-Unique: d8ZF5q2pPz-K8S64TY1jjg-1
X-Mimecast-MFC-AGG-ID: d8ZF5q2pPz-K8S64TY1jjg_1751304187
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CED201944A83; Mon, 30 Jun 2025 17:23:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E06D219560A7; Mon, 30 Jun 2025 17:23:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Signed-off-by=3A=20Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] b4: Drop linktrailermask
Date: Mon, 30 Jun 2025 19:23:01 +0200
Message-ID: <20250630172301.519848-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


When grabbing a patch series, the link trailer is replaced with a
Message-ID, which is not useful compared to an URL. Fix that by
dropping the linktrailermask config.

Cc: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Fixes: 838cf72b5d2c ("Add a b4 configuration file")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .b4-config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.b4-config b/.b4-config
index 4b9b2fe290f9..126f503ded74 100644
--- a/.b4-config
+++ b/.b4-config
@@ -11,4 +11,3 @@
     prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
     searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
     linkmask = https://lore.kernel.org/qemu-devel/%s
-    linktrailermask = Message-ID: <%s>
-- 
2.50.0


