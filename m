Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2002C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYU-0004CL-V7; Tue, 18 Aug 2026 15:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYG-0003sk-Fa
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYE-0000M9-Ma
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI27a1872821
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QvpG5TtOVv7/sfZiS/1BzH9v1VLAL1opPEUMfJcOgos=; b=l8ftA3/PX2dYdXHf
 qkcomn5IfHerNiwL5a4OLG76oEaWEyfnZBWD4f14/7A0MEfo/Rf4DiO81vjkbfSN
 3mCX87EeruPFaDZAWWaVuWf5TYXU89I6h32kHTqNxelY40Dj6Vh3+0Xs7Q3We8ML
 TJOvcj8BUzwsI5rv6b0pAdp193+U+KPoXaNJo8VR1DTXAa+OMxbiisTL24wqgLQG
 LMIHvwglYt7dwyPK53fYXF+BUnqQ4S42kq82HoxxDfGM59JDMeyRcSNdlh2sX01w
 M0oyGUETEC1Z4k5yMCC1RujJjAFdr3/5UsE+W0vvn+c1j96zqbv/0cK8oVtTVS8P
 ErHZvg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1aha8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so409832a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081564; x=1787686364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QvpG5TtOVv7/sfZiS/1BzH9v1VLAL1opPEUMfJcOgos=;
 b=LG6w5v4vqxhZQl7tmrAdHlnZmDiD8f3O5nkL6jXpAhcGAzd0Mip+h3or2vdQeo92a8
 lKo1/V5fvafCxH8v2APwRO3tZPLJoTf/gnH6eFUS7eY2iexe1zY+E2/Hs9G8WjBn3nG6
 LCNfVhcaAgKei8XXZyiOsUP9j++GT6TmM6dOwjubEPw+dPI0J+VusnIlRPT6dbJzWl2c
 wqpVWfERe2x+dGmkYHxEmm5A4Q8+/jOkwVIn6v1owdIIF31JJgGwBC5KIF5qVTnPSMpB
 5E8mhFpNERcT3rx4zG2hV659WbbM+FcZGAPzWE9SuAHarHRXcfFvUqpHm6ajWazQpTrb
 2i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081564; x=1787686364;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QvpG5TtOVv7/sfZiS/1BzH9v1VLAL1opPEUMfJcOgos=;
 b=sO88MhyrXH3YU5lt+cUXmTvQ8S3yQAP6siJpet7f6gPK7UnIIMxoq3fmgRq5o7NRQi
 MaAKh4dGDfDzFBj8G1zYcVgvH9h+Zu8fZD1O/OWeH/OZ1QCclV/CXcFl0WVSUziGfaTF
 9G3hVHwz6uz02mnmK2pFHLdEsGE94SdDU3X2FQKHm8YoQaB338RM1fArIkaqVcq32kWR
 zC5fJLN+dJY8TZ3lSvyumb6kHmZSshvHQkVWxhyV4G9jcPkuPbD3m12dOfpW8oYPthG3
 Bgi8eo1mCtYnF9sYRZxaLF0XiWhLqLanI8XJuMPueUyT5gD/8jxfq/HcE0O8kNUfusAD
 NjJA==
X-Gm-Message-State: AOJu0YwcCSb8fGgRUuQz3gzKg8pAQ/xTabUxM9JQqBhQWyvbrxnwozUy
 m4sPrDcA1SZ05u8h3jSyFDXRX1XKedsnT3aJcKRPP81lSl5q7sX28MF+EH9eAujXoTI9Kbhuuzr
 nTDwoPtjAA5XMluRhZKFceOrNNCom/1XHKELaJXZF24r5KOvyLrWpHuLygNGEWUOxkw==
X-Gm-Gg: AR+sD13XZ5HffbiOVIF2T8Lx3hgFpLIRB2OCP7vizg7Fr3CMu588S1TZFe+RBRwGQcO
 FmHdRpqrr9wqOsNoRPG8iNUGsuvcMTnCMkzOZK33NW413OMidrr8izUeKpqWLrXKGc2aFWvr3u5
 /yrUvIqUuVlQIV1970EuptYjLw10Kl52VsxpoxNmIgBqbg+iGZwQcgSqnSXCPp2Q2h9TP0FJ2fC
 UNvBaQ5cAvs3B+t6W2GO6KwTZQXqniYf5c7+TcL0W+W83J8cIen+p99yUV0949ClPyVFC6cv/gU
 u0JC3tqJSHPYrlCKxSU5n/YzRiirnfWBoYq7XcDe0vMAkDKtVBLB4f3sOUYLarM0eh2LHxtC/Ll
 jK5lpDWW9z5sWcXpATAti/uDfuPSpfjfJ78S6Ir1GpDtPNwJjZ2hfzzqg3dw=
X-Received: by 2002:a17:90b:4cc5:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-3957b0fd54bmr267255a91.1.1787081564060; 
 Tue, 18 Aug 2026 12:32:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4cc5:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-3957b0fd54bmr267134a91.1.1787081563496; 
 Tue, 18 Aug 2026 12:32:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 097/104] tests: remove tcg tests machinery
Date: Tue, 18 Aug 2026 19:23:01 +0000
Message-ID: <20260818192309.22169-98-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2CZKIVQ8dK43
 jJ7X1Js8+9KZAbAgR4epPfNhxmeZ1WoDXhZIxYi1COBUKwFwDKB0/7OuRXGPnO4Q1nCbgnLTapR
 2Xpz6XJLITdV+jCx+fLoCRgHcaL7CFJzdh6PnGSgGCDEcLIGHzxifGzyNPV8xrK3zmi2ipGLa2S
 FsVdTJA79bcDxsuUMyPqrEMy6eG3P20jJ3OS+yPHaTTf87m6bPYvCVx3Chw/emKsn+WQpyBiVSE
 ATVb2frxqbmX0EBPQYDMFfdSQM6BmguOpqL1cj9jaTayz9HShX37+nV4yEXSBs4FiDYcskftVbI
 3PP864jG/qDeMvS0UfLD7Rr/kZvryxFoVx2ZS7RHg/fjSsxQ/fbXzysSkTPoPp7M8ynejLtScEb
 jpr99xueD/pK3o6sqwhrS8bxnyFoIfkJ4EBLdMkwK5X4iDgtn6zg8F6m5Q18BkPqJraKG9dSZXc
 x+cnQG7ChNC1exNIIHA==
X-Proofpoint-GUID: INav4fyBbPyzbP495mRwLmumfmFW5ucp
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b35d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=45U3grDSXPH4n2F9VpgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: INav4fyBbPyzbP495mRwLmumfmFW5ucp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX05+CuX5vVY9r
 TLBcydsdEdWpuCQuQhPVkxKFH7ZgkcuJCNJcIaQcmsfU9TBFfJZbTICfrfHGSXQKUgg+zXJ4ZHj
 /7Pu5+qXDDAkOgCcEI3WJOTAlbxCY/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
2.43.0


