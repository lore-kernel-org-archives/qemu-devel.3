Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357D4D7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Ke-0008Rf-AA; Thu, 21 Nov 2024 10:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Kd-0008QF-Cj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9Kb-0000jB-Vb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDwzpubNeX/qNKmGspxHAL/q+ogQKTglNRA4riqdpPU=;
 b=TjnzWa1RjNRR02MCo2UVsfCPK+IWC2UsWCuqlZfvxE1WvyReWyiSq9PRgulLqtZvthP+4x
 DHmRkHn/o65JeSiFxrwQ+q/yKX+6WaSn+ippND/ABa9+olbADDEvYjIF71zug1GZW03Ydi
 r4qy76xu0VTKM4TuEuLTtEEMeYyL7ec=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-qVwBDbvAM_CyKddU-mIZVA-1; Thu,
 21 Nov 2024 10:42:51 -0500
X-MC-Unique: qVwBDbvAM_CyKddU-mIZVA-1
X-Mimecast-MFC-AGG-ID: qVwBDbvAM_CyKddU-mIZVA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CBA019560B4; Thu, 21 Nov 2024 15:42:49 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3827D1956086; Thu, 21 Nov 2024 15:42:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 03/18] tests/functional: remove "AVOCADO" from env variable
 name
Date: Thu, 21 Nov 2024 15:42:03 +0000
Message-ID: <20241121154218.1423005-4-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This env variable is a debugging flag to save screendumps in the
mips64el malta tests.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_mips64el_malta.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 24ebcdb9c1..6d1195d362 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -159,7 +159,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         loc = np.where(result >= match_threshold)
         tuxlogo_count = 0
         h, w = tuxlogo_bgr.shape[:2]
-        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
+        debug_png = os.getenv('QEMU_TEST_CV2_SCREENDUMP_PNG_PATH')
         for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
             logger.debug('found Tux at position (x, y) = %s', pt)
             cv2.rectangle(screendump_bgr, pt,
-- 
2.46.0


