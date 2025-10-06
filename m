Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C74CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5jjq-00068X-U8; Mon, 06 Oct 2025 07:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5jjn-000686-OE
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5jjj-0002WR-Cu
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759751434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HdZA+nm3WGRoPR55MxzrbWgStXcVMhpXQwNkBo3I5Iw=;
 b=ML6jB/USIQTvRAFb1WzqQoQxyeJiXnXac5pNcSuVcBo6729vT80nlOEhYoY2hPeDGiCGkC
 izyCMJPBoCFAd9rOHHI3qD2mOJ0N1GZCcImclg27BfZmKRGtjwxexm+WpKjiA42gi24lE8
 t8Ugla3a0s6r/Mm8g0p51Rqkp86MrDg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-kvi_4MveMFKwAWClcxw8tA-1; Mon,
 06 Oct 2025 07:50:28 -0400
X-MC-Unique: kvi_4MveMFKwAWClcxw8tA-1
X-Mimecast-MFC-AGG-ID: kvi_4MveMFKwAWClcxw8tA_1759751427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 515D019560B0; Mon,  6 Oct 2025 11:50:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.132])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5261D1956056; Mon,  6 Oct 2025 11:50:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/functional/aarch64: Skip some sbsaref_alpile tests by
 default
Date: Mon,  6 Oct 2025 13:50:22 +0200
Message-ID: <20251006115022.164004-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

test_sbsaref_alpine is one of the longest running tests in our testsuite,
because it does a full Linux boot a couple of times, for various different
CPU configurations. That's quite a lot of testing each time, for a rather
small additional test coverage, so mark some of the tests with the
@skipSlowTest() decorator.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 See: https://lore.kernel.org/qemu-devel/87eczriaej.fsf@draig.linaro.org
 
 tests/functional/aarch64/test_sbsaref_alpine.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/aarch64/test_sbsaref_alpine.py b/tests/functional/aarch64/test_sbsaref_alpine.py
index abb8f5114bd..33e77cc7049 100755
--- a/tests/functional/aarch64/test_sbsaref_alpine.py
+++ b/tests/functional/aarch64/test_sbsaref_alpine.py
@@ -41,12 +41,14 @@ def boot_alpine_linux(self, cpu=None):
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
 
+    @skipSlowTest()
     def test_sbsaref_alpine_linux_cortex_a57(self):
         self.boot_alpine_linux("cortex-a57")
 
     def test_sbsaref_alpine_linux_default_cpu(self):
         self.boot_alpine_linux()
 
+    @skipSlowTest()
     def test_sbsaref_alpine_linux_max_pauth_off(self):
         self.boot_alpine_linux("max,pauth=off")
 
-- 
2.51.0


