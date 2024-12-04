Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5463E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIjUi-0002FD-KU; Wed, 04 Dec 2024 02:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjUg-0002Ey-Gq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjUe-0000HB-76
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733296090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=95J4PAzJeFA+HqSpZrGcTdwPjGHmIH0yiv25YSuAspQ=;
 b=JViMJXKXPPJFCedCXpy+BdZxZXRsY4TO1khgb/TKb+1NQQstPdw266uoXHediRdH1hfUPr
 MIfqlo7cbIODxDMrq5QvtwX4WNON70xWZtsDBgkhMI43H7vW4ImKCdA/eb55P+Ekn0pnXQ
 DlN1bSVvTFPTJbJewLa5Prst0swQTDk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-PUL2F4LSNmqlhpQUK0G1UQ-1; Wed,
 04 Dec 2024 02:08:06 -0500
X-MC-Unique: PUL2F4LSNmqlhpQUK0G1UQ-1
X-Mimecast-MFC-AGG-ID: PUL2F4LSNmqlhpQUK0G1UQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BF541956088; Wed,  4 Dec 2024 07:08:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FD8619560A2; Wed,  4 Dec 2024 07:07:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Bump the timeout of the sh4_tuxrun test
Date: Wed,  4 Dec 2024 08:07:57 +0100
Message-ID: <20241204070757.663119-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

When running "make -j$(nproc) check SPEED=thorough", the sh4_tuxrun
test is timing out for me, and using TIMEOUT_MULTIPLIER I can see
that it clearly takes more than 100 seconds to finish. Thus increase
the timeout setting of this test to avoid the problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d6d2c0196c..f50bf61a50 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -34,6 +34,7 @@ test_timeouts = {
   'ppc64_tuxrun' : 420,
   'riscv64_tuxrun' : 120,
   's390x_ccw_virtio' : 420,
+  'sh4_tuxrun' : 240,
 }
 
 tests_generic_system = [
-- 
2.47.0


