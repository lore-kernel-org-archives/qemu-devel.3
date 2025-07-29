Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BD4C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugk7s-0000Fx-Jl; Tue, 29 Jul 2025 09:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7f-0007u9-DT
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7b-0001M8-CY
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753794713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4usEoZoZ9KyVaIc8S5J9vDS55X6IKKojEE+AB+d8sI=;
 b=bgFlOOD3khcQIz5ViTWlySy3s56o5EEYlMsoSpfNtjsQm+8/QpKMV/xHK8VcYPuOaI+V6/
 +mM7kuGzU484qByNJalaZa/fmOMvbO05Yn7zWogBt3Aa4EUGKr62RgvBrOWk2qh4mGJISx
 hJZKJWQAosv3XkMwEVz0ni/LRX44Moo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-oJNsZqJbP4ypzl5ypDGKuw-1; Tue,
 29 Jul 2025 09:11:52 -0400
X-MC-Unique: oJNsZqJbP4ypzl5ypDGKuw-1
X-Mimecast-MFC-AGG-ID: oJNsZqJbP4ypzl5ypDGKuw_1753794711
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DD621956064
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47B1C1800285
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A8D521E6935; Tue, 29 Jul 2025 15:11:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 3/5] tests/qapi-schema: Bury dead test case
 doc-non-first-section
Date: Tue, 29 Jul 2025 15:11:46 +0200
Message-ID: <20250729131148.3777401-4-armbru@redhat.com>
In-Reply-To: <20250729131148.3777401-1-armbru@redhat.com>
References: <20250729131148.3777401-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The test passed when it was added.  However, the commit adding it
neglected to make Meson aware of it, so it never ran automatically.
The test stopped making sense when we changed headings markup, and
ceased to pass then.  It should've been removed then.  Do that now.

Fixes: 6c10778826a8 (docs/sphinx: remove special parsing for freeform sections)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250724091742.1950167-3-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qapi-schema/doc-non-first-section.err  | 1 -
 tests/qapi-schema/doc-non-first-section.json | 6 ------
 tests/qapi-schema/doc-non-first-section.out  | 0
 3 files changed, 7 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-non-first-section.err
 delete mode 100644 tests/qapi-schema/doc-non-first-section.json
 delete mode 100644 tests/qapi-schema/doc-non-first-section.out

diff --git a/tests/qapi-schema/doc-non-first-section.err b/tests/qapi-schema/doc-non-first-section.err
deleted file mode 100644
index eeced2bca7..0000000000
--- a/tests/qapi-schema/doc-non-first-section.err
+++ /dev/null
@@ -1 +0,0 @@
-doc-non-first-section.json:5:1: '=' heading must come first in a comment block
diff --git a/tests/qapi-schema/doc-non-first-section.json b/tests/qapi-schema/doc-non-first-section.json
deleted file mode 100644
index 1590876061..0000000000
--- a/tests/qapi-schema/doc-non-first-section.json
+++ /dev/null
@@ -1,6 +0,0 @@
-# = section must be first line
-
-##
-#
-# = Not first
-##
diff --git a/tests/qapi-schema/doc-non-first-section.out b/tests/qapi-schema/doc-non-first-section.out
deleted file mode 100644
index e69de29bb2..0000000000
-- 
2.49.0


