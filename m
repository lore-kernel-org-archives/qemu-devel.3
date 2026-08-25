Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA110C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLR-0002i2-AM; Tue, 25 Aug 2026 07:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLN-0002QJ-H9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLK-0005uj-4L
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tu9OjoAkb2kL7TySR/SgHNC8iaedkUFQv6ynJ1J+Cdk=;
 b=JLPvvpEdf79i+hbPKHGKjAfk0f03nG+7bKCjVIfwOdWCQApHbafM0Uppv3rB1zVamI1YyY
 y2iJF7GOWuQJjoml06ejmt/J0FXmOAGE6X2ax+TE8p9KzY4aYfq/UlCfl6z2kl66JU1AAI
 DZHUh4+jYh+MbaolLjwhLj3PgXTN6hY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-O43WpaxHNgGOqq8T7VKjQQ-1; Tue,
 25 Aug 2026 07:29:22 -0400
X-MC-Unique: O43WpaxHNgGOqq8T7VKjQQ-1
X-Mimecast-MFC-AGG-ID: O43WpaxHNgGOqq8T7VKjQQ_1787657361
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B9F5187E5E4; Tue, 25 Aug 2026 11:29:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCE781800641; Tue, 25 Aug 2026 11:29:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:57 +0400
Subject: [GIT PULL 07/19] tests: tag slow tests with 'slow' suite for easy
 filtering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-7-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QITPpiOZP5Uk5r6XkgWAklMllT4ehRNGnPcCX1K6Y3c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrUN/nnqX13yoFYWrmQ1nCuOdAHLmuhkO6tx
 DBdbOOuzHyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5VQCEACrSMBzGAm7EQYa5+sG7oX2/lVVLRT7C95m/OMXxELyM+jzSC6qF5h2mFV8sli9D+I8Hw7
 Po60Kv1bRf9gFmwFZl8KGzi1pxaa30mJOy3HGLmvrbZsQVw/euN2CvMUGMv5JbFVFfZtrj9N6xL
 wLWelqMPL8/gR2NRseGQEdXPCeS6lsUcoYgh4E96jre5bfSOir/hqJfnMYbGFe/WeLw139wUxre
 C7PYoiOKUKexFxoMYWOiA2mhtM1N0C/uUY3pTb2UnAWwErA35UrLDKERJdgnbJcRxHY4T7rwAfN
 YwSRCd9qqZcxAk2solBclaT4Oj/NTg34fkP+VRvOHrudHUNhu0Z1If88zHV2jKic36iqHVGHcjK
 KyrVPawr25GEEltcs6pEP9M0PLVQ2fn6aJNvDBvzFGnb4usI9weoN4EeBFAmcs7IU3fXcBnKGNl
 ksMMs6fkujPmbLpIsworjnRiL2ijzr4fSnR6QAFaqycggRcDm4n22yzFbi9DD4RR2PXmNenyPRo
 64h30O7XbNIjV9PRcnEn4bP3mPPDOQHyyylJTMEvGWZDaRwruFaypGh/OoosBmdP926J4T4gODH
 3OsDEZIlEz+Id4TZYzS64GTDkln3qWFCqRhKg7Nh5zY02qhVP2frlh9oB3+z4vcPoIqQD0ATN+D
 bpBVJVuwfpcEMPQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add several RCU and thread-pool unit tests to the slow_tests dict,
and tag all slow tests (both qtest and unit) with a 'slow' suite so
they can be excluded or selected via meson test --suite/--no-suite.

Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260512065633.3542562-1-marcandre.lureau@redhat.com>
---
 tests/qtest/meson.build | 3 ++-
 tests/unit/meson.build  | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 739df71d8d0b..cbdef5a54550 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -510,6 +510,7 @@ foreach dir : target_dirs
          protocol: 'tap',
          timeout: slow_qtests.get(test, 60),
          priority: slow_qtests.get(test, 60),
-         suite: ['qtest', 'qtest-' + target_base])
+         suite: ['qtest', 'qtest-' + target_base] +
+                (slow_qtests.has_key(test) ? ['slow'] : []))
   endforeach
 endforeach
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index dc3fb954c03a..3a9866c1f2be 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -184,6 +184,12 @@ slow_tests = {
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
@@ -205,5 +211,6 @@ foreach test_name, extra: tests
        protocol: 'tap',
        timeout: slow_tests.get(test_name, 30),
        priority: slow_tests.get(test_name, 30),
-       suite: ['unit'])
+       suite: ['unit'] +
+              (slow_tests.has_key(test_name) ? ['slow'] : []))
 endforeach

-- 
2.55.0.543.g5ebe2ebe4ea8


