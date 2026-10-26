Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mw0Hb9eH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLGvR-0006dN-2a; Mon, 26 Oct 2026 05:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLGvN-0006d6-IN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLGvM-0005JK-1I
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793006601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=k2b/tYxd8Uq7X26KTFDNvAo4zw1zRHKWYygPfV+3qIQ=;
 b=Mw0Hb9eHk8Rr7nb+eQ1ae68gaZrbJghY/RtBKrVnflecVezXELnzeBNXNpM+mXO/EJFaQ8
 MW+H8+qmYaL1VVZO8rzecafw1S/GlJFNYYRCRg+gRRiWGwyX7aB/8b2mVJJP1A62nHq3Ye
 BacR6FuGXJaO2M+5Fc3uAb/NxQqqScc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-Yif-il6CPX2JcwcGZl02LA-1; Mon,
 26 Oct 2026 05:23:18 -0400
X-MC-Unique: Yif-il6CPX2JcwcGZl02LA-1
X-Mimecast-MFC-AGG-ID: Yif-il6CPX2JcwcGZl02LA_1793006597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEC7C1956069; Mon, 26 Oct 2026 09:23:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 602CF1800257; Mon, 26 Oct 2026 09:23:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest: Increase the timeout of the
 device-introspect-test
Date: Mon, 26 Oct 2026 10:23:13 +0100
Message-ID: <20261026092313.480889-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I'm occasionally seeing timeouts of the device-introspect-test for
the aarch64 target when running "make check SPEED=thorough" - looks
like the 720 seconds aren't enough anymore nowadays. Add 2 more
minutes to give some more headroom.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2d01837ff29..540aa5fc8d3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -3,7 +3,7 @@ slow_qtests = {
   'aspeed_smc-test': 360,
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
-  'device-introspect-test' : 720,
+  'device-introspect-test' : 840,
   'ide-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
-- 
2.56.0


