Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C8ECCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsHP-00042i-B2; Mon, 03 Nov 2025 05:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHO-00042A-B7
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsHA-0004Vi-29
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSYsrw2Y919OGidLpK2HDGa8Ib3a619BuATvAZ3gJ8c=;
 b=UOlEoL7Eh8meXiN0l1i0VVuVCwdCSfgfQh0nq/raiqDgTd5EgMk9UZCbTX00QeF7Vbk7p/
 roX9ARQtaQv3/rYS3GyOCfVFACkA0FQCB2IzarrPKykfrruQOPcHluQKrniE7xix5r0NqX
 xxD9Eaqg3y7Mj3j/A4U5Jjv94UpuGtw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-fSwcKSxANw2w69Okp--cPg-1; Mon,
 03 Nov 2025 05:58:59 -0500
X-MC-Unique: fSwcKSxANw2w69Okp--cPg-1
X-Mimecast-MFC-AGG-ID: fSwcKSxANw2w69Okp--cPg_1762167538
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8BD1180A22D; Mon,  3 Nov 2025 10:58:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED14B30001A1; Mon,  3 Nov 2025 10:58:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 14/22] tests/functional/x86_64/test_virtio_balloon: Fix
 cosmetic issues from pylint
Date: Mon,  3 Nov 2025 11:58:11 +0100
Message-ID: <20251103105824.322039-15-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251029075342.47335-1-thuth@redhat.com>
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


