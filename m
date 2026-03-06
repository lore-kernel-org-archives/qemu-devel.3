Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F0EFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXs3-00081X-Of; Fri, 06 Mar 2026 11:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrt-0007Fu-Aa
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXro-0007jI-V6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so92000595e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813851; x=1773418651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+UWl7QqCCvL307S47JaYkwj0UHFZYxrVcpTcdakFmY=;
 b=hYSY4GgHplD2rUi4p6oIhwX9noQMTVryeSLPcdAELnGE3PxRrmaNZjVarw9/Un2m+u
 0qLrjV9ZM2e+URSVH9pwlhsLIvzRw2OYzKHuCmL2a8Gmtk1jU903EptP5qgsMS/XWLGB
 92OPPG9yUWo50syTQPI+W5nM33Ten00m2I+7hlvulvqKVto7gtCnfQzJHVJnL67hrYXu
 p9sATANGR/3TxB8AKQ5LnCYGxF+YlEDwHEi7f6bdqiS8IDDkyy4vxiu9CBn1VUG+xEgH
 qhN5XKv9ISGc4T+IeSelG16IAsQudVqoItDRQyBuT6M6VLZp5mmswJ7QXI1Ydvon5Dba
 Js9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813851; x=1773418651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+UWl7QqCCvL307S47JaYkwj0UHFZYxrVcpTcdakFmY=;
 b=Mt+9+7D1CUvs+aFTRc92gn3+QGeiqmQfk2K8Om+VpPj/SMSPmDd2Vcgt0nScuqYXd8
 dC/QGumOaiLF8QYWoRPZwEHMiQH95OtRRvAQTY/6kO2hENEpp6+etJvufncjIC3T/6mZ
 L3DYolfdCyIjDIyBiGPWIjiFSP/YmP2B1WXtKFKR7E7lh280s9GtCHRRWa08uAdRwtMp
 ZkFmeCsCJM6gFc8Om4/yJvpSooBAFGgCY13G0FrkV4ckTCzui9gL0ThyqRFTrl3GfZIo
 ay5C9TCHVhGgMmZ05AEdkSJqlAU6rbRavMoioLVQnh0Tfh8vZXLAuAuPo+NpSUBzRGXj
 3Zzg==
X-Gm-Message-State: AOJu0Yy2EOjyr7jFNevPcPIKYf1aX6UFIePiSq8o+GDEjSGSmZ5ttTBw
 DPu3RllZz6aR1FOdYlWP2JaoJVkE1xjrh2JY8VeG9hBdaEO748WGIlR3wQbleJnPbJA=
X-Gm-Gg: ATEYQzwW5dOSb1+YURbz6noZc1nFu0tAS9ymBKE6ku474tSQo1400c/cmaGkbUBfYqt
 Qoxqq1Xq/EP/7cIBM6Uss5zF07+z4edWrMYnVHB2u64wZoiia9X1k5edJr2qI7a8R3To1I8x/L4
 /PPs4VuoHMZAXbLt7/cqKbegRbdpNjR6rQFtl2/FbhbWflvu8lO6xA/bxyuDVdFZwjzMbI7/nqu
 qv6bf2tLKVI1whahHE7AfsN+T677/Y5/bjFVDHrGWGqcIQ67aLHkeI/zyS0k4mO86EXO8nOQzZl
 2XjKMZMndHy22kcYPN0878M8cf0ycZBlEUnJVc8mgBqe7+Y6T+qfHqtnkLFUkilRWC6xvT9bwd2
 vPWIVSgsCWw8jVu2AFFBgM6EmU1h10yOozFJC+widiVdfuEylkuUDJpn50z3RIYnfJgGheENwb2
 QE7Q2xpvDRYKEyrBcSSLqGAMQ=
X-Received: by 2002:a05:600c:a4f:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-4852674e8damr45041185e9.12.1772813851428; 
 Fri, 06 Mar 2026 08:17:31 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686bcesm67253565e9.7.2026.03.06.08.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1132F689D1;
 Fri, 06 Mar 2026 16:17:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/7] tests/tcg: allow filtering of TCG tests
Date: Fri,  6 Mar 2026 16:17:23 +0000
Message-ID: <20260306161728.2657486-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


