Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A16CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc3bE-0007gP-0Q; Tue, 23 Jun 2026 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc3b6-0007cf-S2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc3b5-0007Sd-5B
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782230612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ryLJiI6VAKv+23fMh2DYiM3UFe+EYNutIItneADmm/w=;
 b=Pc/STZ2ogE2zQX46qziTQEuKc9nWAPYSGSeS8sCTWMs6QxhY8yCMPrE883Rde5RvToV8px
 D3nAAekWClSEZeQsocwTwVVc1/hRt800c6mmbeNBYwDqLm2+2F68Boh5dMjpvZrB9mkfJC
 W9HVIRQCgtJQ0b/PDjCZ30V0s7/pfPc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-69augNA3PZWq0iwAnO-UFw-1; Tue,
 23 Jun 2026 12:03:31 -0400
X-MC-Unique: 69augNA3PZWq0iwAnO-UFw-1
X-Mimecast-MFC-AGG-ID: 69augNA3PZWq0iwAnO-UFw_1782230610
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32A471802666; Tue, 23 Jun 2026 16:03:30 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.133])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 623613000B4E; Tue, 23 Jun 2026 16:03:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] iotests: increase timeouts for tests to 5 minutes
Date: Tue, 23 Jun 2026 17:03:26 +0100
Message-ID: <20260623160326.2346255-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently we have tests timeout set to 3 minutes, on the basis
that they're generally done in less than a minute. I've hit a
couple of random failures suggesting that's not sufficiently
pessimistic. Increase the timeout to 5 minutes to have a greater
safety net in high load scenarios.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/meson.build | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index bc6132a0f7..8857f25f29 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -52,16 +52,17 @@ foreach driver, speed: qemu_iotests_drivers
               '-tap', '-' + driver, item,
               '--source-dir', meson.current_source_dir(),
               '--build-dir', meson.current_build_dir()]
-      # Some individual tests take as long as 45 seconds
-      # Bump the timeout to 3 minutes for some headroom
-      # on slow machines to minimize spurious failures
+      # Some individual tests take as long as 3 minutes
+      # in high load scenarios. Bump the timeout to 5
+      # minutes for some headroom on slow / loaded
+      # machines to minimize spurious failures
       test('io-' + driver + '-' + item,
            python,
            args: args,
            depends: qemu_iotests_binaries,
            env: qemu_iotests_env,
            protocol: 'tap',
-           timeout: 180,
+           timeout: 300,
            suite: suites)
     endforeach
   endif
@@ -94,16 +95,14 @@ foreach driver, speed: qemu_iotests_drivers
               '-tap', '-' + driver, item,
               '--source-dir', meson.current_source_dir(),
               '--build-dir', meson.current_build_dir()]
-      # Some individual tests take as long as 45 seconds
-      # Bump the timeout to 3 minutes for some headroom
-      # on slow machines to minimize spurious failures
+      # See earlier note about timeouts
       test('io-' + driver + '-' + item,
            python,
            args: args,
            depends: qemu_iotests_binaries,
            env: qemu_iotests_env,
            protocol: 'tap',
-           timeout: 180,
+           timeout: 300,
            suite: suites)
   endforeach
 endforeach
-- 
2.54.0


