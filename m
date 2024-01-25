Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B71AC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT33m-0000nq-Bp; Thu, 25 Jan 2024 11:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rT33W-0000Lk-Pe
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rT33V-0001Py-4h
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706201899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XwX+QoFnS6kQobTAMyJFMb2huR0jeqEF3W7RMrmGdwE=;
 b=NFmRoTfkHx5YB541RKfQz+xJvJiuElBs9nMlmhAirTlcWQs1VkZbDEi+xybuZ3XiFFFyg+
 oXL6JuF4hlo0IMM6Pyz14mtTKNZ/tbvw4unaR2XK+ou8g73zV+MU32jm1Rp73XEt6VM6ym
 E0ZJKywRdIwSnKtjZ1CL76jpitoXDuk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-PaoHBQyhMui42bmZ_SiCuQ-1; Thu,
 25 Jan 2024 11:58:15 -0500
X-MC-Unique: PaoHBQyhMui42bmZ_SiCuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 280CB3811809;
 Thu, 25 Jan 2024 16:58:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14AE52166B32;
 Thu, 25 Jan 2024 16:58:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH] tests/unit: Bump test-replication timeout to 45 seconds
Date: Thu, 25 Jan 2024 17:58:03 +0100
Message-ID: <20240125165803.48373-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We're seeing timeouts for this test on CI runs (specifically for
ubuntu-20.04-s390x-all). It doesn't fail consistently, but even the
successful runs take about 27 or 28 seconds, which is not very far from
the 30 seconds timeout.

Bump the timeout a bit to make failure less likely even on this CI host.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 0659532122..db6398a0f4 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -175,7 +175,8 @@ slow_tests = {
   'test-aio-multithread' : 120,
   'test-crypto-block' : 300,
   'test-crypto-tlscredsx509': 45,
-  'test-crypto-tlssession': 45
+  'test-crypto-tlssession': 45,
+  'test-replication': 45,
 }
 
 foreach test_name, extra: tests
-- 
2.43.0


