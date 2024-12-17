Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFF1E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTlu-0002Cp-SF; Tue, 17 Dec 2024 04:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tNTls-0002Ce-SO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tNTlo-0004K1-Cp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734427293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4m/ATkixV7QqWvLtZUm43UQjJxK2lmN/VDm/laZEako=;
 b=KEu+mij0wiJQYVf1v4zjnNPsCFvzcuHLDEJLTXEM6YfT51wKFOqZm9bRhYMSG0+lib5f5j
 O1lW12KaJJ6wesP1S7ndIgzOUrpYYwiiunNUePi6VoV3J3ZYYLTcTaRzgHo24Jnq5uwo7d
 lxaGS3MZJ3hqatJw66yXooteamt5KB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-JRwkTossN7K4FV3uHnsotg-1; Tue,
 17 Dec 2024 04:15:08 -0500
X-MC-Unique: JRwkTossN7K4FV3uHnsotg-1
X-Mimecast-MFC-AGG-ID: JRwkTossN7K4FV3uHnsotg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A61A719560B2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:15:07 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A81E1956053; Tue, 17 Dec 2024 09:15:05 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qapi: fix colon in Since tag section
Date: Tue, 17 Dec 2024 10:15:04 +0100
Message-ID: <20241217091504.16416-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

As described in docs/devel/qapi-code-gen.rst line 998,
there should be no space between "Since" and ":".

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 qapi/cxl.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 9f65589bce..dd947d3bbc 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -460,7 +460,7 @@
 #
 # @unstable: For now this command is subject to change.
 #
-# Since : 9.1
+# Since: 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
   'data': { 'path': 'str',
@@ -539,7 +539,7 @@
 #
 # @unstable: For now this command is subject to change.
 #
-# Since : 9.1
+# Since: 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
   'data': { 'path': 'str',
-- 
2.47.1


