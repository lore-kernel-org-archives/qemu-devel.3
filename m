Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C579C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJg0-00011K-DB; Mon, 29 Jun 2026 17:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfs-0000dI-T8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfr-0004KD-EO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLVFGzp09CzhnZkb/rQms/Ql1UubbrCtslqNYqSQ1RA=;
 b=eBBfhwjVBf6OES5mSQZv0P8ZtXG+jlgdbaVeoJXkDq5puyDXVl9nunfIcX19ezxNGZyXc4
 oeruQ+bxOJuSLRBBxsNKOYr4oHcs8Oe+Cz8Zr0NzZMZ0tKzsna+LZS36bDGWQuDrlZkwzH
 ivIq8XGElukP3C5jBHGsww6i2pq3InU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-fx_v1BPxM7Cp4O4iBwHqog-1; Mon,
 29 Jun 2026 17:37:45 -0400
X-MC-Unique: fx_v1BPxM7Cp4O4iBwHqog-1
X-Mimecast-MFC-AGG-ID: fx_v1BPxM7Cp4O4iBwHqog_1782769063
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C978D19344BE; Mon, 29 Jun 2026 21:37:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BF5C1956096; Mon, 29 Jun 2026 21:37:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 13/14] qapi: convert intro sections for yank.json
Date: Mon, 29 Jun 2026 17:36:23 -0400
Message-ID: <20260629213624.936258-14-jsnow@redhat.com>
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/yank.json | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index f3cd5c15d60..6fdf169084d 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -10,9 +10,8 @@
 
 ##
 # @YankInstanceType:
-#
-# An enumeration of yank instance types.  See `YankInstance` for more
-# information.
+#     An enumeration of yank instance types.  See `YankInstance` for
+#     more information.
 #
 # Since: 6.0
 ##
@@ -21,9 +20,8 @@
 
 ##
 # @YankInstanceBlockNode:
-#
-# Specifies which block graph node to yank.  See `YankInstance` for
-# more information.
+#     Specifies which block graph node to yank.  See `YankInstance`
+#     for more information.
 #
 # @node-name: the name of the block graph node
 #
@@ -34,9 +32,8 @@
 
 ##
 # @YankInstanceChardev:
-#
-# Specifies which character device to yank.  See `YankInstance` for
-# more information.
+#     Specifies which character device to yank.  See `YankInstance`
+#     for more information.
 #
 # @id: the chardev's ID
 #
@@ -47,9 +44,8 @@
 
 ##
 # @YankInstance:
-#
-# A yank instance can be yanked with the `yank` qmp command to recover
-# from a hanging QEMU.
+#     A yank instance can be yanked with the `yank` qmp command to
+#     recover from a hanging QEMU.
 #
 # @type: yank instance type
 #
@@ -74,9 +70,8 @@
 
 ##
 # @yank:
-#
-# Try to recover from hanging QEMU by yanking the specified instances.
-# See `YankInstance` for more information.
+#     Try to recover from hanging QEMU by yanking the specified
+#     instances.  See `YankInstance` for more information.
 #
 # @instances: the instances to be yanked
 #
@@ -101,8 +96,7 @@
 
 ##
 # @query-yank:
-#
-# Query yank instances.  See `YankInstance` for more information.
+#     Query yank instances.  See `YankInstance` for more information.
 #
 # TODO: This line is a hack to separate the example from the body
 #
-- 
2.54.0


