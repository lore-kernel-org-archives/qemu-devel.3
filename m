Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46584CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMh2t-0000AA-Se; Tue, 12 May 2026 02:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMh2r-00009y-Rd
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMh2q-0000tT-7S
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778569000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aDAMrQHPMVRbjEY1ga1gy1kkhDs885eVhoLHwVZIDB0=;
 b=gFM9TFx+9QwZ9sia3wlhkGJ51zC4ytndFPwKyKzd0mlyE1xsZtI7zqqlocwJqQ7bWVrYVe
 As1Wu42pWG1qEGhxQhd/9MazSWwszGNAZvl82fxPiP0RgwFmFq/HjkzNGqyLOUEFCxc8gg
 +UXmjDbt0klKdviq7mHAOvDKk4OkoxY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-GuTUU1osM-27QNlQYzNxBw-1; Tue,
 12 May 2026 02:56:39 -0400
X-MC-Unique: GuTUU1osM-27QNlQYzNxBw-1
X-Mimecast-MFC-AGG-ID: GuTUU1osM-27QNlQYzNxBw_1778568998
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 011A618002CF; Tue, 12 May 2026 06:56:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFDCB18004A3; Tue, 12 May 2026 06:56:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests: tag slow tests with 'slow' suite for easy filtering
Date: Tue, 12 May 2026 10:56:33 +0400
Message-ID: <20260512065633.3542562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add several RCU and thread-pool unit tests to the slow_tests dict,
and tag all slow tests (both qtest and unit) with a 'slow' suite so
they can be excluded or selected via meson test --suite/--no-suite.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/meson.build | 3 ++-
 tests/unit/meson.build  | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 728dde54b3f..2c5dcf2340f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -493,6 +493,7 @@ foreach dir : target_dirs
          protocol: 'tap',
          timeout: slow_qtests.get(test, 60),
          priority: slow_qtests.get(test, 60),
-         suite: ['qtest', 'qtest-' + target_base])
+         suite: ['qtest', 'qtest-' + target_base] +
+                (slow_qtests.has_key(test) ? ['slow'] : []))
   endforeach
 endforeach
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 03d36748c73..ed1172a107c 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -176,6 +176,12 @@ slow_tests = {
   'test-crypto-tlscredsx509': 90,
   'test-crypto-tlssession': 90,
   'test-replication': 60,
+  'rcutorture': 30,
+  'test-rcu-list': 30,
+  'test-rcu-simpleq': 30,
+  'test-rcu-tailq': 30,
+  'test-rcu-slist': 30,
+  'test-thread-pool': 30,
 }
 
 foreach test_name, extra: tests
@@ -197,5 +203,6 @@ foreach test_name, extra: tests
        protocol: 'tap',
        timeout: slow_tests.get(test_name, 30),
        priority: slow_tests.get(test_name, 30),
-       suite: ['unit'])
+       suite: ['unit'] +
+              (slow_tests.has_key(test_name) ? ['slow'] : []))
 endforeach
-- 
2.54.0


