Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC46606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HRpw4/Pw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLH2V-0007cj-3z; Mon, 26 Oct 2026 05:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLH2S-0007cO-Ic
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xLH2R-000665-51
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793007041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=obIR1ZgNDFLBfELrJwxTm+X3g5dZklkcaJ8yms1SqK8=;
 b=HRpw4/PwnAfrm1Io+n7hEqUH6fxsoKWGTiQJUsJmAddPNwPnO8mxdzMjkFPiLRRk65GZnQ
 f+EqC/vVadkp1NAOQ8p1GnUzSM4IPQA0URxOP+oJ9BWjSfGfxIyxCaTea9W3i23XJmafhp
 lVvA7eKR2vH8rCgvW7PSKLOz60eKhKA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-_VKzhH8kOiur92Y-71fxwA-1; Mon,
 26 Oct 2026 05:30:37 -0400
X-MC-Unique: _VKzhH8kOiur92Y-71fxwA-1
X-Mimecast-MFC-AGG-ID: _VKzhH8kOiur92Y-71fxwA_1793007037
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8FB1805A3C; Mon, 26 Oct 2026 09:30:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1F80195608B; Mon, 26 Oct 2026 09:30:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests: Add a target to run all tests in thorough mode
Date: Mon, 26 Oct 2026 10:30:34 +0100
Message-ID: <20261026093034.516604-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"make check SPEED=thorough" is a little bit clunky to type and many
people are not aware of this nice possibility to run almost all test
in parallel this way. So add a "check-thorough" target that makes this
way of running the tests a little bit more accessible.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9f82552ab54..d9d2b7ef13b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -4,6 +4,7 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
+	@echo " $(MAKE) check-thorough                Download assets and run almost all non-flaky tests"
 	@echo " $(MAKE) bench                         Run speed tests"
 	@echo
 	@echo "Individual test suites:"
@@ -46,10 +47,13 @@ FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$
 $(FUNCTIONAL_TARGETS):
 	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
 
-.PHONY: check-functional
-check-functional:
+.PHONY: check-functional-precache
+check-functional-precache:
 	@$(NINJA) precache-functional
 	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
+
+.PHONY: check-functional
+check-functional: check-functional-precache
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
 .PHONY: check-func check-func-quick
@@ -57,9 +61,12 @@ check-func check-func-quick:
 
 # Consolidated targets
 
-.PHONY: check check-clean
+.PHONY: check check-thorough check-clean
 check:
 
+check-thorough: check-functional-precache
+	$(MAKE) check SPEED=thorough QEMU_TEST_NO_DOWNLOAD=1
+
 check-build: run-ninja
 
 check-clean:
-- 
2.56.0


