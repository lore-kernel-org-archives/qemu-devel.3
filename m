Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B67DC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJfZ-00083Y-Nj; Mon, 29 Jun 2026 17:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfX-0007if-R7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfW-0004EZ-AP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0/UQU46W2hvgmNLSWNCBvTQ9oWZFd9tSIYPkcUj78k=;
 b=NIls/LId5nRsx81U0SnR7yYKkWWAX4cxQbMkQvoKihk2g2569m8E8uBPy49Cn1S6aHLEhp
 lEXgH9R7qqxGvRoARG193z9HNEhK5hBSSODGiGdGsuBAKsXpHFL9qqivsAx9IKUrEsYXoo
 AcyrCsW5VhBFt1uLqqQD1yjCcfZXFug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-NZeftUPHNH6lFU_-yNAtAQ-1; Mon,
 29 Jun 2026 17:37:25 -0400
X-MC-Unique: NZeftUPHNH6lFU_-yNAtAQ-1
X-Mimecast-MFC-AGG-ID: NZeftUPHNH6lFU_-yNAtAQ_1782769043
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8474D18052D1; Mon, 29 Jun 2026 21:37:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D6441956096; Mon, 29 Jun 2026 21:37:17 +0000 (UTC)
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
Subject: [PATCH 09/14] qapi: convert intro sections for cryptodev.json
Date: Mon, 29 Jun 2026 17:36:19 -0400
Message-ID: <20260629213624.936258-10-jsnow@redhat.com>
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cryptodev.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index eb309c22f86..d0c1e6c8944 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -12,8 +12,7 @@
 
 ##
 # @QCryptodevBackendAlgoType:
-#
-# The supported algorithm types of a crypto device.
+#     The supported algorithm types of a crypto device.
 #
 # @sym: symmetric encryption
 #
@@ -26,8 +25,7 @@
 
 ##
 # @QCryptodevBackendServiceType:
-#
-# The supported service types of a crypto device.
+#     The supported service types of a crypto device.
 #
 # @cipher: Symmetric Key Cipher service
 #
@@ -46,8 +44,7 @@
 
 ##
 # @QCryptodevBackendType:
-#
-# The crypto device backend type
+#     The crypto device backend type
 #
 # @builtin: the QEMU builtin support
 #
@@ -62,8 +59,7 @@
 
 ##
 # @QCryptodevBackendClient:
-#
-# Information about a queue of crypto device.
+#     Information about a queue of crypto device.
 #
 # @queue: the queue index of the crypto device
 #
@@ -77,8 +73,7 @@
 
 ##
 # @QCryptodevInfo:
-#
-# Information about a crypto device.
+#     Information about a crypto device.
 #
 # @id: the id of the crypto device
 #
@@ -95,8 +90,7 @@
 
 ##
 # @query-cryptodev:
-#
-# Return information about current crypto devices.
+#     Return information about current crypto devices.
 #
 # Since: 8.0
 ##
-- 
2.54.0


