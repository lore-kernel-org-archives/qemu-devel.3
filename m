Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EAFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE10N-0007Vt-7f; Wed, 29 Oct 2025 03:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE10L-0007Vj-Ru
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE10G-0002G2-GI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761724432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vZpG/u93l8XHzFrnWYpTPKSlveqkXvNP9Aak/8EkR10=;
 b=dqkFpA8oV3ol2ajlsur2RYwF6rOGChquxX+7jWKZvb6eK+e/vmWAZLjL+wBCcFfPKt8W1H
 tEd47Z905X70XxRUau3MALe4NyFE0Hw6/BNYx5xWRAe/v+MszML7V2gFqZs/CzLLhQQP/K
 ei4R+HqvH9Jh1vx7DnqDUplZ2JlCGCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-XKwd9G1vMh67vbigReuwyg-1; Wed,
 29 Oct 2025 03:53:47 -0400
X-MC-Unique: XKwd9G1vMh67vbigReuwyg-1
X-Mimecast-MFC-AGG-ID: XKwd9G1vMh67vbigReuwyg_1761724427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 149581808981; Wed, 29 Oct 2025 07:53:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EA2E1955F1B; Wed, 29 Oct 2025 07:53:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/functional/x86_64/test_virtio_balloon: Fix cosmetic
 issues from pylint
Date: Wed, 29 Oct 2025 08:53:42 +0100
Message-ID: <20251029075342.47335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Pylint complains about some style issues in this file: Unused variables
should be marked with an underscore, "when > then and when < now"
can be simplified to "now > when > then" and expectData doesn't conform
to the usual snake_case naming style.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/x86_64/test_virtio_balloon.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/x86_64/test_virtio_balloon.py b/tests/functional/x86_64/test_virtio_balloon.py
index 5877b6c408c..7a579e0d69a 100755
--- a/tests/functional/x86_64/test_virtio_balloon.py
+++ b/tests/functional/x86_64/test_virtio_balloon.py
@@ -66,7 +66,7 @@ def assert_initial_stats(self):
         when = ret.get('last-update')
         assert when == 0
         stats = ret.get('stats')
-        for name, val in stats.items():
+        for _name, val in stats.items():
             assert val == UNSET_STATS_VALUE
 
     def assert_running_stats(self, then):
@@ -87,10 +87,10 @@ def assert_running_stats(self, then):
 
         now = time.time()
 
-        assert when > then and when < now
+        assert now > when > then
         stats = ret.get('stats')
         # Stat we expect this particular Kernel to have set
-        expectData = [
+        expect_data = [
             "stat-available-memory",
             "stat-disk-caches",
             "stat-free-memory",
@@ -103,7 +103,7 @@ def assert_running_stats(self, then):
             "stat-total-memory",
         ]
         for name, val in stats.items():
-            if name in expectData:
+            if name in expect_data:
                 assert val != UNSET_STATS_VALUE
             else:
                 assert val == UNSET_STATS_VALUE
-- 
2.51.0


