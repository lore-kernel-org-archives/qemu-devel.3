Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118D2CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6U5F-0006VF-Iu; Wed, 08 Oct 2025 09:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6U5D-0006Uv-8i
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6U57-0003xu-GM
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759929584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NqWFGXNqgimUWQ6vSVSIubD3VA2PiMFBKF5YjPCZn2M=;
 b=WkF6/WeNiv0Xv3yfT/y4BMjISDGjhjVP9rKTMycD/sEthA8QBosgAjKtX/8DpwMNnQGukm
 SbRAjCKV76n51V+2NH+1PhXoLo1ArkMkSUU3MHicGulX9nWxsO9C4qibya8JhEtVp20Y2a
 XbDvWzGmp2HyKR5vMZFVjLfmZ0QuRnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-WB3Mtl0nN8uMFN0GCK3Q9A-1; Wed,
 08 Oct 2025 09:19:40 -0400
X-MC-Unique: WB3Mtl0nN8uMFN0GCK3Q9A-1
X-Mimecast-MFC-AGG-ID: WB3Mtl0nN8uMFN0GCK3Q9A_1759929580
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD972180034D; Wed,  8 Oct 2025 13:19:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.220])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 467691956056; Wed,  8 Oct 2025 13:19:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] python/qemu: Replace some remaining "avocados" with
 "functional tests"
Date: Wed,  8 Oct 2025 15:19:36 +0200
Message-ID: <20251008131936.71160-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The avocado tests have been replaced by the new functional tests,
so also update this in the README.rst files in the python directory
accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 python/qemu/machine/README.rst | 2 +-
 python/qemu/utils/README.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine/README.rst b/python/qemu/machine/README.rst
index 8de2c3d7722..6554c693201 100644
--- a/python/qemu/machine/README.rst
+++ b/python/qemu/machine/README.rst
@@ -2,7 +2,7 @@ qemu.machine package
 ====================
 
 This package provides core utilities used for testing and debugging
-QEMU. It is used by the iotests, vm tests, avocado tests, and several
+QEMU. It is used by the iotests, vm tests, functional tests, and several
 other utilities in the ./scripts directory. It is not a fully-fledged
 SDK and it is subject to change at any time.
 
diff --git a/python/qemu/utils/README.rst b/python/qemu/utils/README.rst
index d5f2da14540..5027f0b5f11 100644
--- a/python/qemu/utils/README.rst
+++ b/python/qemu/utils/README.rst
@@ -2,6 +2,6 @@ qemu.utils package
 ==================
 
 This package provides miscellaneous utilities used for testing and
-debugging QEMU. It is used primarily by the vm and avocado tests.
+debugging QEMU. It is used primarily by the vm and functional tests.
 
 See the documentation in ``__init__.py`` for more information.
-- 
2.51.0


