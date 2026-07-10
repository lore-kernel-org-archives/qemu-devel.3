Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727F0C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAI-0004P9-Qz; Fri, 10 Jul 2026 17:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJAH-00048e-5Q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJAC-0006Va-PN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Sl61713369
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=; b=ZT/8yaeBPdlCuc22
 Te/XzlPJAePviivmBlZXdcncrOHw97M/e5NWTsFcgnZibeqpQ/yBetA1xoB/EMDX
 bhKRFrX537J+q0TDXdEacOtMdTdtKM6Sdw92AIh5rAoZ6elYo2XAeSt9+7WMWydo
 nQa3XpIKKU/LixcbbJwfH8nnz0YUnYIUu1eFnlhRyYujedBx9Y60KA7nRMs/47NJ
 PhaTggiIF/z7GgUGOdjM12Ke0RP2EZKQThtMkrf8lWSwKQxBQiAqR8W6QcgECqdd
 Vdfbo+vWmJZPUeNggP9y+qH+a6WxvMSKAxgeY/VMTVufTwRgHOA1RI8/2Qfm8pwV
 CzaVgQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339saar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c890bac374eso2592322a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720408; x=1784325208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=;
 b=Vh8ql85oRyKO7BMyd4JtOQwLJ0DPDR/t9lvdB8GBjr4PwPBSROtuYK3rff0z2waUrO
 JoyH3P/1/1001qYWHFOvxPTcK3FwwB8s1aG6djAOt/3X5i0SeMRqz5EiH0pL94fKupt3
 W+qD19in0IjAlKqwsCc2k7RMsLPjPrKTl1tewrdy2CGXNciF95vuTPGxlePa0+4lVu1C
 0yQAVojCPwxXNu5a3UcWsXVupS4ticjSOOnYmC0mvqw8t5lGM7coF+oSeU7KAQC7EVMH
 O4yy7m8VS8OOdvX8CxRPUaEWxMgm33Z5tnqKtGL7gh6HphvmwnN0hX5G2hksnvQ+t20b
 ts8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720408; x=1784325208;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I8oWCntI2KAg6ntVFInXo1IctT7vnJlZcAcd39Wk+NE=;
 b=bGJl4c6qUVwkm8vfAbMUcJklu2rGvGcfqtpfkg67T+mCCV/ysMLdmZ0sIczmhwVzGK
 R89I/3G0ija+rcIniBbuMNAoBBrQiwN1WMjS6b8230BxnvZC0jqUZVoLng+vjzBWnYRm
 589qSvo2rpd2kbb8AbxV/ze1EWVB3Au/G0gYy5cQan0zg8Sr95oudz5hxc4ePFNLfa4R
 GXF2QITZg8AwzZfpK7boJgL9PLt3IsWbjIdTIrlvfuwEdGd7lyyttdtpHusmfmGEu0qH
 9VcwrosWjjXMNdM9fqPltNBvRdByXi4Qn5c1f1/gj4TKArSmngGdOklvZLrlwkMhbZh1
 WInA==
X-Gm-Message-State: AOJu0Yx8MXah1oXMsB0mJvL4YcqyfM0aK4/0DUfYrS/g7VdNY71Im89V
 DuQiXUmWM/CNLZhc2dy76gDL62lwvlPI/p7LIpS5GmAz2dl46Xngr0VBrE3R67d5BnkWaLQLX9B
 TXu3sgt8NOlkf9Rzb7KHhVUkSesdHOFuydxTddUgsiZkez+EJTMO2uolcal6ytNWA5A==
X-Gm-Gg: AfdE7ckFT0dx7DkG4EvY5/Vbt3CULhYr7dDbOfaoXMMUJfYTwusnjFQadRyXqLk6DZ3
 fpmTkWLEmcJyqwnS0DpWjrsneP+GcIVyeD1eAFFFm0/VVNqy6ZNUJSsuenvpD/E/9idCgOWt7Ie
 1jFGXogqrxowdg6WzGASjoVswdE7TG0YhhCY0vRJvt7iSLCOtyupA6a5/Vq/zyjRJZk+MScUL+r
 qRQssTsbUQ726scCUMNuKooeQVL6HYhgo3jlMZCg9/r2DPLmERBIBe6Geq7PtrFb8dMy6RFrZ92
 g8b0Vk+J7DP7ClyvcVtXvhm3RqLlAlkd0tnTnC/ViBqX4XyTWFsg0EddPqk8RCqPkDu7w+1WBpN
 MPNZtcmnoZ9eD/q6O3KZXdGIfLSzqwUhD6ngYAhp0D+P7M7vly0//uBXIfxMRoY4COH2FpDPjF7
 iTUsn5uA==
X-Received: by 2002:a05:6a21:32a6:b0:3c0:b4f8:bbe3 with SMTP id
 adf61e73a8af0-3c1102976c5mr954436637.23.1783720408569; 
 Fri, 10 Jul 2026 14:53:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a6:b0:3c0:b4f8:bbe3 with SMTP id
 adf61e73a8af0-3c1102976c5mr954413637.23.1783720408103; 
 Fri, 10 Jul 2026 14:53:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 95/98] tests: remove tcg tests machinery
Date: Fri, 10 Jul 2026 14:43:39 -0700
Message-ID: <20260710214343.2065491-96-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX2pPr+kPmZrLx
 olUNuBbjCxMARUHA+YsjfCC0mP54LU1/PoIAANN8hgt60+lkGc8tdMsRfTVYnGYGlscy5JPYAsN
 +hfZpegeg9Im5oJllCPlJU0Sm13tDuo=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a5169d9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=45U3grDSXPH4n2F9VpgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 803ErZwxRRC7fJ49xf5Hs_6iwJqpe9_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXxs8KgoNhoA77
 23AKXoanzlptPGJBqbOEmbQrHspFY/eXU2/wVdfFeYx8aXhPqjxXfNcW3WygSzofwb601QsiSAe
 ZmaGAO1meIHYy2NWtASNLQE4dYEwBZ7hrTXvy2q5VqEt/4JVwJKgoib1d+/3P4WXxXxv6Lavo2N
 OFepCMJp8PEO4djP0MZ6Ei0Uv1dR62J44HqaCp19EqIOm14XLKCYJ//uYfpKVfu2YvWOG9vcIcp
 RjjKwAnW6J3d4BkKkb/dTOF+sM3Pf2FRBdVBUs/gDBS5KdbeyrOjJBu0hbpIKn8kx2Jpxj4Q6Tc
 Ox3ZMJ4OWkWuoO1LEfKmLp3rrgLPIlkqRagw3r94yj2dPcoFrZPjxJn314XPzHzNmNBQc6n+lKW
 ArlsU4AT41JU4t9Q9E0Rl4YPwCJLevdXMYsEf+kJGUWtKWE1c96pjh4MNkd/pEmgow1rdze8Xjg
 JNaNppC6GDPgnu3zHJQ==
X-Proofpoint-GUID: 803ErZwxRRC7fJ49xf5Hs_6iwJqpe9_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


