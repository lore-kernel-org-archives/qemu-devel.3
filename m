Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E00CA0FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1qr-0007FB-IB; Fri, 30 Aug 2024 09:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1qp-0007D2-Nc
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1qn-0005FE-26
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkVIFbqGNBKi87+Qhd5tJiEOm7IYbePTteBbp7+Sfoo=;
 b=YYiE4cK9FE3TLGMaZ6mpfNA/b8GpOx+aIBon+P2JaU5mlC6gg11YhJr4QWg2ZQZB6BLn3B
 5UWvwyhroCsaYOvamLAQgBkGrWUwXMh7LF6FTTNFCAhahf3N/BSxF1ErGf96Vy41rP3tfV
 T+63d91U1jaWKAaj3HCmxla0edST1S8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-YnuNltLTNku9bTDY5P1oLQ-1; Fri,
 30 Aug 2024 09:39:36 -0400
X-MC-Unique: YnuNltLTNku9bTDY5P1oLQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35E211955D48; Fri, 30 Aug 2024 13:39:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5089300019C; Fri, 30 Aug 2024 13:39:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 10/44] tests/Makefile.include: Increase the level of
 indentation in the help text
Date: Fri, 30 Aug 2024 15:38:04 +0200
Message-ID: <20240830133841.142644-11-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The next patch is going to add some entries that need more space between
the command and the help text, so let's increase the indentation here
first.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 537804d101..fbb1a4b211 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -3,28 +3,28 @@
 .PHONY: check-help
 check-help:
 	@echo "Regression testing targets:"
-	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
-	@echo " $(MAKE) bench                  Run speed tests"
+	@echo " $(MAKE) check                    Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
+	@echo " $(MAKE) bench                    Run speed tests"
 	@echo
 	@echo "Individual test suites:"
-	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
-	@echo " $(MAKE) check-qtest            Run qtest tests"
-	@echo " $(MAKE) check-unit             Run qobject tests"
-	@echo " $(MAKE) check-qapi-schema      Run QAPI schema tests"
-	@echo " $(MAKE) check-block            Run block tests"
+	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
+	@echo " $(MAKE) check-qtest              Run qtest tests"
+	@echo " $(MAKE) check-unit               Run qobject tests"
+	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
+	@echo " $(MAKE) check-block              Run block tests"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
-	@echo " $(MAKE) check-tcg              Run TCG tests"
-	@echo " $(MAKE) check-softfloat        Run FPU emulation tests"
+	@echo " $(MAKE) check-tcg                Run TCG tests"
+	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
 endif
-	@echo " $(MAKE) check-avocado          Run avocado (integration) tests for currently configured targets"
+	@echo " $(MAKE) check-avocado            Run avocado (integration) tests for currently configured targets"
 	@echo
-	@echo " $(MAKE) check-report.junit.xml Generates an aggregated XML test report"
-	@echo " $(MAKE) check-venv             Creates a Python venv for tests"
-	@echo " $(MAKE) check-clean            Clean the tests and related data"
+	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
+	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
+	@echo " $(MAKE) check-clean              Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
-	@echo " $(MAKE) check-build            Build most test binaries"
-	@echo " $(MAKE) get-vm-images          Downloads all images used by avocado tests, according to configured targets (~350 MB each, 1.5 GB max)"
+	@echo " $(MAKE) check-build              Build most test binaries"
+	@echo " $(MAKE) get-vm-images            Downloads all images used by avocado tests, according to configured targets (~350 MB each, 1.5 GB max)"
 	@echo
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setting."
-- 
2.46.0


