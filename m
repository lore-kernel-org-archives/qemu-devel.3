Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B42C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp5-0007Nz-JR; Tue, 28 Jul 2026 00:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoC-0006Lp-UU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoB-0002aD-AJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abHJ1527461
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=; b=Ouw8/Ly0KIk8YCSU
 oM/BieKUr2K7pxkjgybqpZjAimoqvArrPY4rZw6wSmF7rVNeRr1fHLKKk2Wb3bSm
 MuocN5eJHTOwuTXNYuub36ln4yw4QHpXvemGwpDyHAbF0ojpNRE1VN66Kp1EBx9V
 wt5gZ741Jk4BE9oPNbH1sjA+YWRunUlNihIvqqtZtysGBtc5C/RpkfU7MMCdRqgj
 FiPPe50rubPrlqpSxEacr8R5pYxFku9eB55E95vNdJ2H/rlzqsnZ0AHqrhMHpXEb
 rCm85veNiRhPYmSmBJCKvK5ulFjPpb0YEdHA0w1M8Fc6C/PkO/m6yxplA4u2xasY
 DbE/hQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8adus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so5734781a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214368; x=1785819168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=;
 b=WFuipcbCsBZnuUo0CdQl2hG36BgParZeOXXOMUWoNPpaO8mWlAuYcUAvy4adXJOfUq
 0QcVjiduOeP3L0xXiJqOkzlRDH+tgSRwePqxvuSczM4JDQRP+eRxyPt6i5g7Q08/V14s
 Ci+KNkgw5vuGMjBC3QOZywB4J6Je6wBhEeoB56Je38GGjicK9+ab1c6GqdyTh+TrESM/
 L6P/LA9wuio4plqGm/KbByL11K0e5vfJO7b19LTvUGzTu436BuKOAYoiAlsFU8Nxhf0O
 ZOH0ACGx4bD18NkVttiU2SzibPHKfBgMVRmZiolPf7T03BQqmaT0Gw2mIIWmlQ8q3zso
 n4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214368; x=1785819168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=;
 b=l7I2s5wZQTVsn21OzHEcXIYcdgylryVnVpDNNmVcL0PFCqGZ/irvKlHhhhOPQ55AAP
 CksWDWakrdHvfF5/WAHueG1zVqXdod10ssYFsMcwykWAK65VxcBt2TsOT3dvy0iQedgX
 e4rpXu1TFSnEWaLiMqAFAh7qomtwQ8VhU6xPTquU/0XUqfRbNMXQ9iR7UQvRA4CJI49r
 017yTqW1yuT6aWRXfZ94DdJSPdTIqwpj4YoGDaTDNW4LTGdOfoZN3hc/XQLPMnDetVAU
 FPk4ux9p7mv0ToZlhx87J4GQSy2zVMFIghC+2Ww3jGDjTZ0IhWUr3KyruLfcyO91Clvs
 W+Mw==
X-Gm-Message-State: AOJu0YzpBq01zLMIZtl6tp6D6XZrAo9L/+GeNJJXx0u4tZ93IPll5ExP
 wcenN8LUp6NfZAI5EDyhyMLTYNm5t/yONIpXinpnQUQxxo4CbtC6LZy7rpO8IngD3SclFngAHrD
 j/XyBkcO7K5tIvqeY7knxZJHg79Y690tIro/x2mLraBD1JL/rqP3/EN2xzLb8hGTRrg==
X-Gm-Gg: AR+sD12bH1/aCfHqVsY1t7LO6LYtWfRSJ8NUCRTK1O5r9XVM0D3n1+uRYEnWWTXfpgc
 TS/1D7+ThxWvpXDZAVSVwlnc91KewhaXbwW2RmNXMsbQA2w7V1c7J9gfbxXJ4/B1crhqDdWSPzq
 eQ3eDfMQiFqGljZvb03xBQKhoA5j+XrExenlDDMgqJiIzQ5ipdsDpEopQVQ5zlCv6M/mZjSGK4c
 MMKYxzoCUYrB+QJHNI9wxFwTjkIBQIDbCtJA0VmiB2nh5jYJMhSAf/OLlkEOEam8tnCZBM82vxU
 V4Lmuq27bhdi+S0COKdgj5rs4e+Vx7Wri0ndO0Hl8+ej270FVW/2Ts0SXatDFWD5AbBLGYJib/A
 GG9zFPzDQ18eUXEML3Zb8Am78DMO2ZnngQ1UHyWIGsvFLIR0iRDeOGJtDTXgJJ12V2d6I/wc=
X-Received: by 2002:a17:90b:4cc2:b0:38f:474f:e77 with SMTP id
 98e67ed59e1d1-38f6a45e1cemr824022a91.37.1785214368282; 
 Mon, 27 Jul 2026 21:52:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4cc2:b0:38f:474f:e77 with SMTP id
 98e67ed59e1d1-38f6a45e1cemr823995a91.37.1785214367750; 
 Mon, 27 Jul 2026 21:52:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 096/103] tests: remove tcg tests machinery
Date: Mon, 27 Jul 2026 21:42:40 -0700
Message-ID: <20260728044248.137626-97-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfXze4f8/up+2eP
 rwpJ4mI7e5xXM75Rr9D114d7aoajmpmLTNZ7VLR9JWZQqJqbXMYIlNmvsEqwE+mEb66umt3hX/3
 44ppYe6AbP9/jxI/PqAftnCi81KS9Jf94rUuMrw4WxmryUo3e2mPmzUQrN2KPjQxX2MeVfS57wz
 FMEIxRIR2pVfPU+F+RYkpxm/VbCl/9E7CIACf7pcKTWRdp3fHpy6xxk0zFYJLEZ4VAGgNE7TSIy
 YV1MldMK/kLJZaJ8zTE9+Xb+kXOu4WipA8isWE2NOOziS8zzuy6/uTj7WN6gKj2SP1Vp9twAXuY
 pv38nLdhzL2R0pOG6E9wQ6w3MfS/on6mKFgD/8qlY+ra3C7zhujNE9uRAceXPemrqWSn6UlXaol
 +AlMfX0/q1UXxdenuFla9egKC2Mq27mrOyBP6h5yRj9i5UBOPGYojaEbXN8g+319JrG44Kfm1XD
 1e+nV8whzj0my+G+5zA==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a6835a1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=45U3grDSXPH4n2F9VpgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bli43Zkodu8iF24KHKxaw37IMOhPQ6zc
X-Proofpoint-GUID: bli43Zkodu8iF24KHKxaw37IMOhPQ6zc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX4WlPRQFRC6zs
 KSpU+BHdu+6D+NLsuii77U3Ji11yDrI9vui0Ha/nNpLeYm/ZnMnTQXq4FYwB3T7YKg3ARJSmj9o
 HoKSKAncIZeZ20lkz/ArdOLjbtGb1mw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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


