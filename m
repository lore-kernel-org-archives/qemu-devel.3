Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180DDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4mE-0007DX-MH; Fri, 10 Jul 2026 02:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4ll-0006ey-7a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lj-00075q-Dc
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n3IN3802165
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=; b=VX9btuBXl1FZGkHJ
 RrFBt8pPSWKZQGOvPfMMQmdiQ02c/03BAz9y/3wVPAwPsxO4B2q06vDdhVoIm/0w
 tTTE7arNpNEesgnB1F43gHjEolxv8IVAk8eXS0Eo+GXUCVz2UlZjBtPktKY4IRAs
 otp3fNGDVyfXsQlcwH1DdkbaxrbPZv3pjM9dKdHMK5aiS/SSHwvB20diSgFTeoxH
 sXVt/M2u4mU5czEmvpCkzoysKml3hbGSaa71IfTQpGQojNUAgnA1U7yR+9TKxjeC
 qyT600zxbDmaQdz3qouuOINHqc8RBDd6gwLRetKr4mePMbPGGeP5poyQwksuoqgk
 SDgz/w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpkpe5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso962313a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665075; x=1784269875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=;
 b=cw9ZVhPHjLYF/MarjIglRvbNojU2/a1OdjWJfRRKUESFUmD2eEMXhWBD9jSKDxwvbk
 WdUMJ+ZIyqWuzx7Ifg7mvRjVqIwPJEkBgRZRF8XTyI19pTvMYwbczNwWuO2WJNMm2aw3
 Tr5JHnm+zeJoEX9+7nQRiR7nDvNPieSOGgb4Qmx6Pc1NFi2k05BJfeorwRUZEaY4bjyd
 zdHak0UADVNXO5UscVKV8e4069KfiDrpqE3BPg8ZL9rARvzttFiYyUY7scoQ/Re6OUrY
 qk0FVhGoQfo0tQKCOU+iogN8jYSIS5SBMGMnaIYcX89DafZRL6pk8S76r2yyrhux9hHl
 YeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665075; x=1784269875;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=;
 b=hVdAK3gCWHNUeV0bhx3X0KhvvWmjBOs2jfxWFsWymuxJoH625t91fuzHMpIsM6HieU
 HI8qqpUB0o3sZu2Beakm1wG+WrQrxtvqsLo2y8qgPkqiNqxSG8EhyqoUFH73glhzIqzp
 apbVqfAekj29/rw2+FXwZK/qnqT0lPpgTm8Haa8/apaPdWrVUwn+z7DS57HuovwE23Fh
 rw3OHHVTE/TEn0Vxwvqe//nHNkzXng3AUDmATCHtJgNtEb4fgq9hPQp3QIm9pnTR5+JK
 w1ECYbhx1j+6YBntHOuxv0Iq14nEIAcanf1GnaHA/0ZNv8Tr9eKg9yZvSdNl5TYkQ0Gg
 d2hA==
X-Gm-Message-State: AOJu0Yy2HHXCkpE4xbxu2Rk8y0/dJ27j3HQhCyH/0Ni2GfbwlyswYQRo
 tdBMzJr6W2r/wg8QUi/nbB56Epgm+GF/8buh9+ioU+pIYaC0erVwl2oXrAAwgti0Rp+TcFN/J2Q
 7iU9mF4NnVHHo0Z4oPHR5xjyxyCatt1QFHosRPIiVbJOkF2OtysR3C5uK4IenAsLGzg==
X-Gm-Gg: AfdE7cnj+Ri+aWMrqNJB86O7vQ0I158hxSWi2txckzGVa+mwRMSG2q3KByJ9SHeW5qa
 WkB36gbUXh/2khXo3BFPv4Wzu67p4XmFUzBEiA8t8pcmKU9SWMl5vJWkKnWdeMEZEsQG9pFMuG0
 5IWnjVAEhSXJ3KKuqcrQgquzohX6GwcZMkR06dK/zOKgspuVyjKsTarydD0YQbMk32cvSst0r3W
 U74UlCcth+iu838TeciCiFntmUT7sjNZVi++nohmPUSt0r7CCPVrk/Mw9erTPbhTIIm5obdio98
 y0RwSSeEDU6NMitqe6M28rv3CRvFycl1ko+xUr9IqYVgMzCr/0jmL6r0nNb+vsZUDnMTG9lMWQQ
 R50EWDbjvKL3wv9xMAIyAgrAuixPSbtRlcuDhdnH2I7fOm19JYEbbhEj7rk51mUNgjMPC24XlEw
 y1rHN62w==
X-Received: by 2002:a05:6a21:4d92:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3c0bcbc5c2amr12738454637.38.1783665075457; 
 Thu, 09 Jul 2026 23:31:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d92:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3c0bcbc5c2amr12738394637.38.1783665074824; 
 Thu, 09 Jul 2026 23:31:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 94/97] tests: remove tcg tests machinery
Date: Thu,  9 Jul 2026 23:20:12 -0700
Message-ID: <20260710062016.1818125-95-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXwoEYdfog2FtP
 NdSgZ0EvCm46QlykP8YKg6ZL2WNpMqgjcIZcH9z4pxeXHBeDBu7HM1xEMrGZYKzdaEH1H3HuHVG
 3pQjbm1o4iOEX6tpDaVxGnWk1VNDedPZJJGYM6jm6qlM99uU1PIsuWr1LRY7sqZSyp4cs9gyXxr
 pgOS1GuZG+s02FEk6Eg11uMt2I/z1GXadTOlJihG5MnZZZukv8MLLv6Ws29upUF5meL0i2C8CA9
 AN491WND7u7AgDxAWyyvYMPy2phHXREZbIWvKiYNlZB05fUQYOiM/A7NLGz7VF9xO069+vMXQOP
 1IZllJkZKNjUCTqkZZlR/xXj9OaSMxYYVTPjp+yi0Z+GUNFG+F9JgiAb6Iwp2LB8nC0ZcjaVVNA
 AeZwAn+sl+nOl/XkNnljPrBmbCaInlAlskoZ4Sl+YkR4OG4RicvI6behFD8W42PMlFJJXrBdNiy
 ZJa0GDU5wYwJ5UrgsQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXzsc/ZDN2AA+b
 9+s86iO5WRAnpD5Dt3ss8L8wGS3dTfvJBuoWei9esC11a/jd3u2q9miFg1kpOEQSnP3aaU2GU7p
 as30rWHHpQSiK/LXLswE2JDXXP3i+N0=
X-Proofpoint-GUID: SsrV42kLVQ9kGbSINDUBnwXO-tifvHlT
X-Proofpoint-ORIG-GUID: SsrV42kLVQ9kGbSINDUBnwXO-tifvHlT
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a5091b4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=45U3grDSXPH4n2F9VpgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100060
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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


