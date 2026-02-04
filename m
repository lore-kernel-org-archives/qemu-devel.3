Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C987E8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnRzM-0003Kl-Tq; Tue, 03 Feb 2026 20:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vnRzK-0003KF-Gf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:47:26 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vnRzH-0004T0-6e
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:47:24 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a09d981507so2646895ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770169641; x=1770774441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XCiRjZHvUu0TjP6/mxgAYbCMECapdtjgyVyOaMNWk54=;
 b=gokru2txJdATex2/LNOnQ80cQpWzobm5oEEuQZPs7dNlIPEXD8m4/9FjUDYmuzUKcu
 LG9IwLX0iDDWTDYJhJyLwVG+zekIS4EjX2CvPcsOAfBblg9t0uGbDE+Rzy9dziwZgm+2
 2wXMvaS0KCm25/aboE8uf7MP1gOrHJa9C5GNcvSMXy5CBCJaTkxXZQf8Er40561K4ll/
 DyNDDUQC6tNSzRcT9leVAN9d/2qlcuG/ADz7P2FPdvCf0rMfw+4Aav1Xiw62rGYyHEc0
 HvVDJm2Z58Jkjj23B3DBiZuCZ41TfJKB+hNw/cmF7HvmE4Zb65Qnwn1KkuovjCqpRcm7
 EQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169641; x=1770774441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCiRjZHvUu0TjP6/mxgAYbCMECapdtjgyVyOaMNWk54=;
 b=HzRrzuCv7txdL2guWf5wzQpSY0Ss0Tfm0e8mGkJty96xv6CFPctYCn0aw6MZCDXjiT
 UpcgBZjfJsY+mqyElJxY7S1+lsd69Sj0PuPuc20zvdMOEuxJgtXqjZCE9RWjcWrnq/7I
 k2maR3agm7qPMTVkHNFVEofXrp2jQ7+y4n2uGxBk+bVqUE1KQz33Sezogrq7H2m4wlHn
 KEtu3rUXbK9u/Czv6oPAt8q25YKSEPW8/4Wy8tgao9K3glLFFYRHp7P7gve8eGi0pAcu
 XVvtrPHkzuhfjjW3h6Zvit0i0K0Ep3ojVHtU7UmMXLICeAeuJ4t+Tlwlp2ksWXZn4DQ/
 FYBQ==
X-Gm-Message-State: AOJu0YzUR6KRbzP03W4ckS+oqojxn+EyVo5iF/iE4BqBrGZX5ZL96ASR
 PaN0fwrD7DoAT3ZSFrtSMaYeruPQpPdtzDOQc5xWqwbVeY3NoLog0aJykrxxZQ==
X-Gm-Gg: AZuq6aIyOzkaVcpwq6GEjI+fQds187mDzYJNpruVae0g9lxvKsXcSXgZjDCzGZTcsPx
 6wl50AIwe69v9XG5f1uLj10z4tZsSWnA4jCWIwWEmVTFpip9acpz9A22K13APKb7yuLLIdhI/uk
 oCkWUHJJmTa1PCY+gPyLNKDiaFspzaDd4nH3kCOjcW9ZEvUZ8ShFS0O1jcCehTDHCKC5IrqUJ4y
 rUdi6VlQv/pExOsL7POWV6rC8NAK4GsAc+xpKQN9zzyTkEO0vq8fOw99wyvB8U1HqvIOSTI5PXA
 2ZVAs5n2yZLv3hMfi9EBVk8syJ7+nDYjEHNywFEfDbTTSV+ePTwZKACHSsB5kCfGVHgjgyEdsx3
 uVQGmJ1o1+9r35Dhs7oFoVoUpEQAr1CPYt4QZ+tsF49iqjqITwzhi6WnTQj/ycCLbtV/++B8LMB
 4BRh7Ce7oy6Ra7QZdhwDFvv03PAHLsGaUCD23x
X-Received: by 2002:a17:902:fc87:b0:2a0:9a3b:d2a4 with SMTP id
 d9443c01a7336-2a9245c1465mr52354745ad.10.1770169641114; 
 Tue, 03 Feb 2026 17:47:21 -0800 (PST)
Received: from localhost.localdomain ([137.132.26.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933a252f6sm6198925ad.75.2026.02.03.17.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 17:47:20 -0800 (PST)
From: ck <ckeong.teo17@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com,
 philmd@linaro.org, ck <ckeong.teo17@gmail.com>
Subject: [PATCH] tests: add run-tcg-tests-TARGET-softmmu to make check-help
Date: Wed,  4 Feb 2026 01:46:11 +0000
Message-ID: <20260204014611.2267-1-ckeong.teo17@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

User can execute TCG tests for a specific TARGET using the command:
$ make run-tcg-tests-TARGET-softmmu

However, this command is not showing in 'make check-help'
documentation, making it hard for new contributors to
discover.

This commit help to resolve this by adding the description
for the command, to the "Individual test suites" section
in tests/Makefile.include.

Additionally, reformat the alignment to accommodate
the length of the new command, ensuring the
consistency of the output.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/228
Signed-off-by: ck <ckeong.teo17@gmail.com>
---
 tests/Makefile.include | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7728098981..5a99f0a920 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -3,29 +3,30 @@
 .PHONY: check-help
 check-help:
 	@echo "Regression testing targets:"
-	@echo " $(MAKE) check                    Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
-	@echo " $(MAKE) bench                    Run speed tests"
+	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
+	@echo " $(MAKE) bench                         Run speed tests"
 	@echo
 	@echo "Individual test suites:"
-	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
-	@echo " $(MAKE) check-qtest              Run qtest tests"
-	@echo " $(MAKE) check-functional         Run python-based functional tests"
-	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
-	@echo " $(MAKE) check-unit               Run qobject tests"
-	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
-	@echo " $(MAKE) check-tracetool          Run tracetool generator tests"
-	@echo " $(MAKE) check-block              Run block tests"
+	@echo " $(MAKE) check-qtest-TARGET            Run qtest tests for given target"
+	@echo " $(MAKE) check-qtest                   Run qtest tests"
+	@echo " $(MAKE) check-functional              Run python-based functional tests"
+	@echo " $(MAKE) check-functional-TARGET       Run functional tests for a given target"
+	@echo " $(MAKE) check-unit                    Run qobject tests"
+	@echo " $(MAKE) check-qapi-schema             Run QAPI schema tests"
+	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
+	@echo " $(MAKE) check-block                   Run block tests"
+	@echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a given target"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
-	@echo " $(MAKE) check-tcg                Run TCG tests"
-	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
+	@echo " $(MAKE) check-tcg                     Run TCG tests"
+	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
 endif
 	@echo
-	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
-	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
-	@echo " $(MAKE) check-clean              Clean the tests and related data"
+	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
+	@echo " $(MAKE) check-venv                    Creates a Python venv for tests"
+	@echo " $(MAKE) check-clean                   Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
-	@echo " $(MAKE) check-build              Build most test binaries"
+	@echo " $(MAKE) check-build                   Build most test binaries"
 	@echo
 	@echo
 	@echo "The variable SPEED can be set to control the gtester speed setting."
-- 
2.43.0


