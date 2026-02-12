Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C37EEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQK-0008I7-8R; Thu, 12 Feb 2026 16:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQI-0008H2-5M
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQG-0006AP-Hm
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrdAdF87i/JIgXqZZqk6qym024ANSehJo6VPxvcJTQo=;
 b=PjxL5ONXYazC98esMrn5o7YofRTMBXHAeSo1AMt9uhW6rRmIBZRYD/XLDvuVgitVneAdK5
 lsegzI+gZv3iKNYaDw0AzvpnICulUxaBXFd1bkzwRVvLwsljtr5XCExPSNKiGQoIfZ1xKc
 37qgvdwGF/eZMIYxOWjZ0kA6Sl/WT7k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621--GbcR19WMHiD03K0TMXEFQ-1; Thu,
 12 Feb 2026 16:40:24 -0500
X-MC-Unique: -GbcR19WMHiD03K0TMXEFQ-1
X-Mimecast-MFC-AGG-ID: -GbcR19WMHiD03K0TMXEFQ_1770932423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84F21180034D; Thu, 12 Feb 2026 21:40:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93203180035A; Thu, 12 Feb 2026 21:40:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/16] tests/qtest/ast2700-hace-test: Use ast2700-evb alias for
 AST2700 HACE tests
Date: Thu, 12 Feb 2026 22:39:50 +0100
Message-ID: <20260212213955.2225662-12-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Update AST2700 HACE qtests to use the "ast2700-evb" machine alias
instead of a specific silicon revision.

The AST2700 A1 and A2 revisions are compatible for the HACE model, so
the tests do not depend on a particular EVB revision. Using the
"ast2700-evb" alias ensures the tests always run the latest
supported AST2700 silicon revision.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/ast2700-hace-test.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-test.c
index a400e2962b0b..508a34dd6c65 100644
--- a/tests/qtest/ast2700-hace-test.c
+++ b/tests/qtest/ast2700-hace-test.c
@@ -23,57 +23,57 @@ static const struct AspeedMasks as2700_masks = {
 /* ast2700 */
 static void test_md5_ast2700(void)
 {
-    aspeed_test_md5("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_md5("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha256_ast2700(void)
 {
-    aspeed_test_sha256("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha256("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha256_sg_ast2700(void)
 {
-    aspeed_test_sha256_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha256_sg("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha384_ast2700(void)
 {
-    aspeed_test_sha384("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha384("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha384_sg_ast2700(void)
 {
-    aspeed_test_sha384_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha384_sg("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha512_ast2700(void)
 {
-    aspeed_test_sha512("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha512("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha512_sg_ast2700(void)
 {
-    aspeed_test_sha512_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha512_sg("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha256_accum_ast2700(void)
 {
-    aspeed_test_sha256_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha256_accum("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha384_accum_ast2700(void)
 {
-    aspeed_test_sha384_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha384_accum("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_sha512_accum_ast2700(void)
 {
-    aspeed_test_sha512_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+    aspeed_test_sha512_accum("-machine ast2700-evb", 0x12070000, 0x400000000);
 }
 
 static void test_addresses_ast2700(void)
 {
-    aspeed_test_addresses("-machine ast2700a1-evb", 0x12070000, &as2700_masks);
+    aspeed_test_addresses("-machine ast2700-evb", 0x12070000, &as2700_masks);
 }
 
 int main(int argc, char **argv)
-- 
2.53.0


