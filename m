Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED382C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wollv-0001GK-7Y; Tue, 28 Jul 2026 13:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkz-0007xs-B6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkx-000606-4Y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+6jw/lGlUu0pYQ2NwDNgj0yQqSLYINP9XB55VdDzmY=;
 b=Nn3ugj+nKV7Y3hlnjMC0cMCU5TTVFeKG1IdncyjimkOrIprzbngMvc6jolKQiiIbBysgOq
 +magsho2/N8NlAFCWcWtTIgoqlVSI9P1G8UCLXmnFFJsaJb4DJRnSuRbUpfzC6XqyxYJ3L
 9grbcPQA60v4JaV/x4tsDT58u0QCMAA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-h9tGDbncOCOqu8_bVY6k8Q-1; Tue,
 28 Jul 2026 13:38:16 -0400
X-MC-Unique: h9tGDbncOCOqu8_bVY6k8Q-1
X-Mimecast-MFC-AGG-ID: h9tGDbncOCOqu8_bVY6k8Q_1785260296
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5C0F19560B2; Tue, 28 Jul 2026 17:38:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8257619560AB; Tue, 28 Jul 2026 17:38:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/17] iotests: increase timeouts for tests to 5 minutes
Date: Tue, 28 Jul 2026 19:37:39 +0200
Message-ID: <20260728173739.352078-18-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Currently we have tests timeout set to 3 minutes, on the basis
that they're generally done in less than a minute. I've hit a
couple of random failures suggesting that's not sufficiently
pessimistic. Increase the timeout to 5 minutes to have a greater
safety net in high load scenarios.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260623160326.2346255-1-berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/meson.build | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index bc6132a0f7f..8857f25f291 100644
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
2.55.0


