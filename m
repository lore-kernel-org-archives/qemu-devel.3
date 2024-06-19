Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A9CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 05:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJoHg-0006k7-5m; Wed, 19 Jun 2024 01:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJoHf-0006jb-5b
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJoHd-0002MV-EK
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718776500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DfBsRvQa30qaml54KWL9dttlDGUV5AjxPsATfXcq4mQ=;
 b=MUndasT7RcwCdUcIWWIx9NeDcTpgVMwe+U8ElNqM7F5y/4z+co0KxcIJLOnqLNnqfoqyDP
 V488aC7HJkyoTC4EwKwDrYM8j4+TyiokinPWpgzzAqKNeoaEXQXE7i1lMJ/FT/N7kzqAc0
 4Fisa4+24RseIl9B0xwYd7Gd+7pQjfk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-WpHaUa84P0uA5bjxyzLYhg-1; Wed,
 19 Jun 2024 01:54:55 -0400
X-MC-Unique: WpHaUa84P0uA5bjxyzLYhg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39FBB195608F; Wed, 19 Jun 2024 05:54:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 588BE19560AE; Wed, 19 Jun 2024 05:54:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] MAINTAINERS: Cover all tests/qtest/migration-* files
Date: Wed, 19 Jun 2024 07:54:47 +0200
Message-ID: <20240619055447.129943-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Beside migration-test.c, there is nowadays migration-helpers.[ch],
too, so update the entry in the migration section to also cover these
files now.
While we're at it, exclude these files in the common qtest section,
since the migration test is well covered by the migration maintainers
already. Since the test is under very active development, it was causing
a lot of distraction to the generic qtest maintainers with regards to
the patches that need to be reviewed by the migration maintainers anyway.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f63bcdc7d..32691302db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3316,6 +3316,7 @@ F: tests/qtest/
 F: docs/devel/qgraph.rst
 F: docs/devel/qtest.rst
 X: tests/qtest/bios-tables-test*
+X: tests/qtest/migration-*
 
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
@@ -3412,7 +3413,7 @@ F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
-F: tests/qtest/migration-test.c
+F: tests/qtest/migration-*
 F: docs/devel/migration/
 F: qapi/migration.json
 F: tests/migration/
-- 
2.45.2


