Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271251098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c85-0007Xo-2M; Fri, 20 Mar 2026 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c82-0007WW-FV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:14 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c7z-0005VL-UW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:14 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so358424266b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021870; x=1774626670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gpxMBpssTBiyClKYiW1/NzisCMEhju5aJAH+eV1EPU=;
 b=boBEDiipWOUGU6wT0er29xAj2wRNeX0Re5TCmnKhWt4LNsp7QBt0en6n+SKyXmPrQU
 9LycfEuiOjNCJrNkFhmYF8gLHlRGYQYPBR1igl2ZklNw3TbIe5N1hrEyiau2KCNUstcg
 OwSNLMc97jWzPuYLFbkDg76jHThQaJYe9MUWReA/sYY92v6oQvFWgOulkhxlspRK7uYg
 0wwQjvM7L2JQPgqVPbsOAxklqJ7lA3/MIKO89YGy7j2bjD9T3/LIFSzbuFJPMXS0Dqm+
 xM9HO9ZLcbDNgwlW3RrdqVm+SNaX2Ymnv9DnGzgVHZumzG/FsQi7DtYXNZU+XqL97sKI
 zKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021870; x=1774626670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gpxMBpssTBiyClKYiW1/NzisCMEhju5aJAH+eV1EPU=;
 b=e5Egscz0xIy28pcdQSlhX51nx2FB9YxqRFlm3lFNkL3IAStyZyWKAG/B39JQBfLuyP
 lmwGQhl4Ve1r0axWihJhk8X0PUSW2hqsAwm3Fg/i7pRrqSE1xutlioeFTk0e9FqEcTKG
 9VabTaaC531mqdOuj0xoAEqLb2bi3w1lAGXYW2IPDN/xqcid84f1JiDiS36n5/LD0+eB
 uyuHyap8hTtKiZcT3zgJSW2sM1i8WV+AQYbgp1v7GrLab4kZwzjfqrLm0pQBvbUiK0wi
 sSo55bGWGL9XxywjsBgqGy3GjtV1Y//bkAdg8bflOEk+EQXPZxnED1B98C+Iyimh2sUq
 1Wfg==
X-Gm-Message-State: AOJu0Yz2GetBIh+39E2uULrPEMo4yGLykK1Ytfon7z+390fbfM/UjiQs
 lAY9AwGpwx/p1zLfyYf9M6dOr4i6HpQUJ1K20jp5K3JL2nNedbWNRQK2qBzFuccoyk4=
X-Gm-Gg: ATEYQzz5LpYWgzSm6GBhXfH7W+jdGM1r3O+prDG/YLH6CMFZ6ictxTQvUrgGyZPPMKe
 t9Doqk6haFVthLZA6gIw1gzw6jIAqT1Ffc9DqWUbQNBFtEiDfm3nENkHESxIXyxIUi/0pMgMUzR
 U1mkI+sn0ZstAGptSxTZc53EIhc+na/RKTXLYghz3ECrmHB7fml1ujEt9Cks10fp8hNvLfudIOV
 qQmKuks8tgwlIYBDlUfe1/SzYLuRj6cnbUsmgFK8tPQ8UJv9obxd+ZVsXT4BiLKSevckt4PrGYp
 f9MKPDNq7Ya+PC+QjJHH9fLTAyPYloJwKwbeODzM5tDvSMxggietQSY1zNjFZHs4ZxZp46BV94c
 oRmFN92yf+aXgjli2akAUcbLjChE/2RNj9PhNo1B7mIYnFU4mrP9Kmnwh9IpnWiKWekd/7sRU1J
 RjyewBn6Y+AiySlvh2jSjPzig=
X-Received: by 2002:a17:907:a807:b0:b96:e3db:9e04 with SMTP id
 a640c23a62f3a-b982f4faea3mr248933266b.53.1774021869964; 
 Fri, 20 Mar 2026 08:51:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f42f0dsm172731966b.12.2026.03.20.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1A7D5F909;
 Fri, 20 Mar 2026 15:51:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 1/8] tests/tcg: allow filtering of TCG tests
Date: Fri, 20 Mar 2026 15:51:00 +0000
Message-ID: <20260320155107.2143191-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We have a lot of TCG tests now which can be fiddly if we just want to
check one particular test type across the targets. Introduce
TCG_TEST_FILTER to allow this:

  make check-tcg TCG_TEST_FILTER=gdb

to run all the gdb tests across the suites.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include    |  8 +++++---
 tests/tcg/Makefile.target | 12 +++++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59b9a4b9220..f257288194d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -16,9 +16,11 @@ check-help:
 	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
 	@echo " $(MAKE) check-block                   Run block tests"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
-	@echo " $(MAKE) check-tcg                     Run TCG tests"
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
-	@echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a given target"
+	@echo " $(MAKE) check-tcg                     Run TCG tests"
+	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given target"
+	@echo
+	@echo "The variable TCG_TEST_FILTER will select the subset of matching tests."
 endif
 	@echo
 	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
@@ -64,7 +66,7 @@ $(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/
 .PHONY: $(TCG_TESTS_TARGETS:%=run-tcg-tests-%)
 $(TCG_TESTS_TARGETS:%=run-tcg-tests-%): run-tcg-tests-%: build-tcg-tests-%
 	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) run, \
+           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) TCG_TEST_FILTER=$(TCG_TEST_FILTER) run, \
         "RUN", "$* guest-tests")
 
 .PHONY: $(TCG_TESTS_TARGETS:%=clean-tcg-tests-%)
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index af72903f898..1b83824ff4e 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -254,8 +254,15 @@ endif
 gdb-%: %
 	gdb --args $(QEMU) $(QEMU_OPTS) $<
 
+# Filter tests based on TCG_TEST_FILTER if set
+ifdef TCG_TEST_FILTER
+FILTERED_RUN_TESTS=$(foreach test,$(RUN_TESTS),$(if $(findstring $(TCG_TEST_FILTER),$(test)),$(test)))
+else
+FILTERED_RUN_TESTS=$(RUN_TESTS)
+endif
+
 .PHONY: run
-run: $(RUN_TESTS)
+run: $(FILTERED_RUN_TESTS)
 
 clean:
 	rm -f $(TESTS) *.o $(CLEANFILES)
@@ -269,3 +276,6 @@ help:
 	@echo "Built with $(CC)"
 	@echo "Available tests:"
 	@$(foreach t,$(RUN_TESTS),echo "  $t";)
+	@echo ""
+	@echo "Environment variables:"
+	@echo "  TCG_TEST_FILTER=<pattern>  Filter tests matching pattern"
-- 
2.47.3


