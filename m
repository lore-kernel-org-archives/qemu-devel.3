Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6231BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1o-0005oe-DT; Mon, 06 Jul 2026 18:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1m-0005mK-EO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1k-0000Kn-F3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEOAx1613962
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0SpNd0VqUSt
 IO+6RpXnEjso0io5sHIyKScvsiN9JOJg=; b=iVvJeCeYXmThawpAJByI3iLouTg
 ihN+O6dH9/mv8yYWn3YRZURnI/TclhhC5mwGY+fcKzC6Bn5bPyikdTKGBzMIIp2Y
 gIxrdzOHndSsvpL2ptISpyVvQ6eSeAtdQRtesFak9/jBFUB4UdKwzYxrq9c2rhMJ
 1iz5Pb4Xa5Jkq6kLoVAd31hgKzM5cNG+8RCAlWePJ1afrHVDeLlaQF6uiThd6sEk
 kM0H0yrvL57FhTHuQFYOUR+R18Obdpc7bZAIt+B9Xxv38YDcCqfCIf3Ry9n/tQMp
 KTKnQH2uRIl2f07LPwt0PRSHjcJygMbY/x3yfA3BdmncriuwhJO0vHYiuGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53kn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso3096625a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377778; x=1783982578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0SpNd0VqUStIO+6RpXnEjso0io5sHIyKScvsiN9JOJg=;
 b=jB7JOjkzGuHKo9k2NOdFm7c2QjeWZ0/sMmYabax29MF4y/ds7Bn7XsYUDgL/aAnuvn
 RNQkPVhYX8WT5Ji6lk96R9/58Zv8Ee+etAuN0mHNxUrQL0//1b3TBFfAic4f1jg21TbZ
 iT2qri0JabuQwm3/29TYTtksl5ZPytg74168loDu2DGiPJuIuDhKs42XBiOVqbL+Jp4R
 j33CEFGDrJiZrw+VfYhXzjtxUOfVV8+WVZ4FRvbGP9M/YVIFBOzLIBHWpznPS7Fuwetz
 HAEIvJp+P5FCMJUIOaXcP8mEoGHZ26w8T+gnwzIFzuQ5WCiKOiglVFcdVlQbnlYtbRY4
 qahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377778; x=1783982578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0SpNd0VqUStIO+6RpXnEjso0io5sHIyKScvsiN9JOJg=;
 b=KqSS9qvk1+jUJwfGhg1iLqv3HpYNeO9HfroVudIFRU/N+b7GZW7FTptaTm1nFF/V3d
 RWDwYxVv1G46/9kCT1yznnqw62P1gOpZJVuH3LZtHdXqqI56XYkOwJHP6wS/0SIavVZp
 l0px/QbJXzMScP7GhoYpQ4B7PRwyqZoXQtwYZN5d7lIeSmS2FZVMM3rpc/oo2TWI0mg/
 95VTaTCsZcVuDAblGOVOm+qZz6stD9g2st0ehKGXLufN6lEGZ9qH18aJh2jkllTOylQm
 Xp205sm/NugWH+W7s90RGZ0d0/SE8gODqkRTr0nz5jV2jypi5gDNEyVQaGCyhUMPuUC/
 qXbQ==
X-Gm-Message-State: AOJu0Yxp5+sTDz49O46YjffFSUoY5hM5qemuICBxXZRFJ91KA6d9Fq+j
 Xe/w96WwIkoqbjc9dlOTiwIWHAyvz9xxXkXWH2rqxohCu2FHgkIEUYJpaQdubKApF39U/3eXOZc
 PViAkoeomDZd9GWzvvL/GpxVv1jF/c6KLG/DKqgHGqd2B1Jv4r7iUzjFW36D02wUReA==
X-Gm-Gg: AfdE7cn/eAzXTbP9N97XSSYC1U7WIx/BDVAK6z1eUbTnj+o8d7i6kjwElmdCAokJNLO
 nYhl4i72G84fflvhzsmdjYTWc7JebmTnj4teokyLIoqzXcig1taBI1WGIkWF3KGumE2bx4FCiOu
 KBUtWKQVGrm7tusm1CXqUWBou9fBKFNIdjiD7z0CcWlDV0abKFYgsq2DkSby4gBVH9G7zVzN8kk
 R67UMmr8Fo/15Ywk3y0BcxM936p1YOJDZ93UVM3QX/p38vSr1ySqPIcL4Q1BbCLjhIRfa0+wl8u
 QRCLy9VSyopKpygqkGYxxXMTfT5XmL2snRreNU+V4MbrbrBEpVo8wNjhdkgz1ucS6BwQHIxgUIQ
 ky1UflMVK7eowoAzC57WKZH9HY5Xxm/6zEihWD6IP+55i9GC4MGwEdLJLSbwBcBMaEK7kApmCO7
 l18Utx+A==
X-Received: by 2002:a05:6a21:487:b0:3c0:9c1a:8947 with SMTP id
 adf61e73a8af0-3c09c1a9c54mr120830637.63.1783377778528; 
 Mon, 06 Jul 2026 15:42:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:487:b0:3c0:9c1a:8947 with SMTP id
 adf61e73a8af0-3c09c1a9c54mr120803637.63.1783377778066; 
 Mon, 06 Jul 2026 15:42:58 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 89/91] tests: remove tcg tests machinery
Date: Mon,  6 Jul 2026 15:33:41 -0700
Message-ID: <20260706223343.988769-90-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r_Jn0dzCU897ZVBYCphwUiAdy4BoSx1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXxBHL3nthOuNa
 jMPf8loTiIYREUccyYNgwysg9xw+SE+PuCvMWgLo75+Z+oFR/qG+nX95mV2D30+PU7X91ctMK1I
 9Z/7zzuYI9C6ZhlwlC6hQanjITrjKcU=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2f73 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VHszGtx8UcCnBy5lKywA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX3N19GRT2stxy
 3BtnwJZOuUPfttZugwnheWm4pPx+yC5i8MImg1RbilwWR3pS6UvKZdKkwyzlHBJ92CqqlFuZ7C1
 itVBvFs74WfKjJCvFplqmy1AZcdOb9bznvRxfOxepmKJR4zgW3rD+ilZhOAQV65LwgP6MqQRM9m
 Ml2lkRqcdbV0bg0N+nptTH4nCR6pmDRJzcqjSS8ePEMVxozBHVBE0ICVIk/+BZnMdSTIrBXelgv
 Z8rgqYNSVp8uUNhTJDsL2I+SFcSsIgWMRh2NQjTQdsobsxVuvtAdK8b/zaRGEnREGaOZV7sAgpm
 vQuT5XoEIFLAe6UuqxUN/0CPlnm3KeKrP/Zbx+sLzMNHtWbSWzYscecq+eZRoYxm3SlCXoQAnGL
 M+C+SDGzRdHfuoETCJPqiNC0RknP/Mz4DoiwkW0+hHT5govRotkoVTUT5B1ZNg2O3NvSMRlfb49
 bdhfTJHQwTUs6P9fktQ==
X-Proofpoint-ORIG-GUID: r_Jn0dzCU897ZVBYCphwUiAdy4BoSx1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

It's now built-in meson, which offers targets check-tcg and check-tcg-*.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/Makefile.include | 68 ++----------------------------------------
 1 file changed, 2 insertions(+), 66 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 494d0109f26..9f82552ab54 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -19,9 +19,7 @@ check-help:
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
 	@echo " $(MAKE) check-tcg                     Run TCG tests"
-	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given target"
-	@echo
-	@echo "The variable TCG_TEST_FILTER will select the subset of matching tests."
+	@echo " $(MAKE) check-tcg-TARGET              Run TCG tests for a given target"
 endif
 	@echo
 	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
@@ -40,67 +38,6 @@ export SRC_PATH
 
 SPEED = quick
 
-
-# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
-# support for, CONFIGURED_TCG_TARGETS it what meson has finally
-# configured having rejected stuff we can't build.
-CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
-
-# This is the intersection of what tests we can build and is configured
-TCG_TESTS_TARGETS=$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH_COMPILERS))
-
-# Per guest TCG tests
-BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TARGETS))
-CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TARGETS))
-DISTCLEAN_TCG_TARGET_RULES=$(patsubst %,distclean-tcg-tests-%, $(TCG_TESTS_TARGETS))
-RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
-
-$(foreach TARGET,$(TCG_TESTS_TARGETS), \
-        $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
-
-# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
-get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
-
-$(foreach TARGET,$(TCG_TESTS_TARGETS), \
-        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
-
-.PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
-	$(call quiet-command, \
-            $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
-        "BUILD","$* guest-tests")
-
-.PHONY: $(TCG_TESTS_TARGETS:%=run-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=run-tcg-tests-%): run-tcg-tests-%: build-tcg-tests-%
-	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) TCG_TEST_FILTER=$(TCG_TEST_FILTER) run, \
-        "RUN", "$* guest-tests")
-
-.PHONY: $(TCG_TESTS_TARGETS:%=clean-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=clean-tcg-tests-%): clean-tcg-tests-%:
-	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) clean, \
-        "CLEAN", "$* guest-tests")
-
-.PHONY: $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
-	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) distclean, \
-        "CLEAN", "$* guest-tests")
-
-.PHONY: build-tcg
-build-tcg: $(BUILD_TCG_TARGET_RULES)
-
-.PHONY: check-tcg
-.ninja-goals.check-tcg = all test-plugins
-check-tcg: $(RUN_TCG_TARGET_RULES)
-
-.PHONY: clean-tcg
-clean-tcg: $(CLEAN_TCG_TARGET_RULES)
-
-.PHONY: distclean-tcg
-distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
-
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
 
@@ -128,7 +65,6 @@ check-build: run-ninja
 check-clean:
 	rm -rf $(BUILD_DIR)/tests/functional
 
-clean: check-clean clean-tcg
-distclean: distclean-tcg
+clean: check-clean
 
 endif
-- 
2.47.3


