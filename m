Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87876C5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFCZ-0008VA-Mz; Thu, 05 Jun 2025 14:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCW-0008Tx-Uu
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCV-0001WV-BM
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749147625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1IOiYYV4y8EU16Zge7qnkvSB6TpEXkBx97HR0NTwmQ=;
 b=KUD7s0EBPYw7vZ+aykLCrIoetEvFdQf44SJAGOrZreT52twTd9u4FtEtVg/3ZhBS3Sxn1F
 4HxVVK5BIQ1T8Ek8LmIk0Y5FK87G9PQ3m+FEvZ0YaB76tC7+DZlRhCY+m4n0JvdjYutqN7
 x3wNN9KP11zZvwXA53BxwDlc0OEszlM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-YXCoi7e7Mnem6TzvTZ2K2w-1; Thu,
 05 Jun 2025 14:20:22 -0400
X-MC-Unique: YXCoi7e7Mnem6TzvTZ2K2w-1
X-Mimecast-MFC-AGG-ID: YXCoi7e7Mnem6TzvTZ2K2w_1749147621
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31F3D18003FD; Thu,  5 Jun 2025 18:20:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 698421956094; Thu,  5 Jun 2025 18:20:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v2 1/6] qapi: Add some pylint ignores
Date: Thu,  5 Jun 2025 14:20:09 -0400
Message-ID: <20250605182014.561172-2-jsnow@redhat.com>
In-Reply-To: <20250605182014.561172-1-jsnow@redhat.com>
References: <20250605182014.561172-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This restores the linting baseline in QAPI.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20250604200354.459501-2-jsnow@redhat.com
---
 scripts/qapi/backend.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 14e60aa67af..49ae6ecdd33 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -13,6 +13,7 @@
 
 
 class QAPIBackend(ABC):
+    # pylint: disable=too-few-public-methods
 
     @abstractmethod
     def generate(self,
@@ -36,6 +37,7 @@ def generate(self,
 
 
 class QAPICBackend(QAPIBackend):
+    # pylint: disable=too-few-public-methods
 
     def generate(self,
                  schema: QAPISchema,
-- 
2.48.1


