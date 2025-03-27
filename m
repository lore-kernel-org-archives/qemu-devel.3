Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01835C36012
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiG7-0000Od-Uy; Thu, 27 Mar 2025 04:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiG6-0000OU-G3
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiG4-00062q-Ua
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9V7MotqbpNaS9rMOW4DrdfDcaNrXxBF0fRr9vaxQ9Y=;
 b=bHpKOwG1PfixUlXY0cUw8j5C2qWBYsD0J/CyHPRampMyn4VwnZPErzvHVO6ldwjE2aL+KR
 i8eqEGuhKRG4YuDSU9KvxLtEl33SvDWBZviZYfQkJSFwEeiSnELDm+HEqiRQ+8Brtbew4H
 8x8CuyYd6Dk2mwScdEEquFAWZRQAkpI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-isyw6sD7Mk6o9E2cYiZtgA-1; Thu,
 27 Mar 2025 04:06:32 -0400
X-MC-Unique: isyw6sD7Mk6o9E2cYiZtgA-1
X-Mimecast-MFC-AGG-ID: isyw6sD7Mk6o9E2cYiZtgA_1743062791
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58384196D2CF; Thu, 27 Mar 2025 08:06:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.126])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56ED119560AB; Thu, 27 Mar 2025 08:06:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] tests/functional/meson.build: Bump arm_aspeed_bletchley
 timeout
Date: Thu, 27 Mar 2025 09:06:18 +0100
Message-ID: <20250327080622.954388-3-thuth@redhat.com>
In-Reply-To: <20250327080622.954388-1-thuth@redhat.com>
References: <20250327080622.954388-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The arm_aspeed_bletchley timeout takes more than its
current 120s timeout on a debug Rust config:

$ time (cd build/rust; PYTHONPATH=../../python:../../tests/functional QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3 ../../tests/functional/test_arm_aspeed_bletchley.py)
TAP version 13
ok 1 test_arm_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openbmc
1..1

real    2m15.536s
user    3m21.444s
sys     0m11.558s

Bump it up to 480s, same as arm_aspeed_rainier.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250321155806.1888867-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 96d28289279..0f8be30fe27 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -26,7 +26,7 @@ test_timeouts = {
   'arm_aspeed_witherspoon' : 120,
   'arm_aspeed_ast2500' : 720,
   'arm_aspeed_ast2600' : 1200,
-  'arm_aspeed_bletchley' : 120,
+  'arm_aspeed_bletchley' : 480,
   'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
-- 
2.49.0


