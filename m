Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FFAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ2A-0006W5-Ow; Fri, 10 Jul 2026 17:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ22-0005qA-Tm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ20-0003bn-7e
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3UXS1752832
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=doTTHLUxsEt
 KunA9wrhHCgnr5rsmsJhkZfbHLI98hfE=; b=kXoXPpWP/ZfGirML2zd9AXeb4Js
 gfUYkduFt6AR3xVmaXR7YK8h6la1EgsfSOKTmVDETQWFB3vw03Lr/5p0+HxVlm7M
 +uSLcpeQMx0HssxevXLbWqwoTuw1sMltXt5dEi5Xvnn/R7zjB7jhoH4OKR4Wb80T
 PiNBWqRSZSLYslPGpBOY59dvlrlX3Qn+jMFidHlclQCgR/B8r9Kodb7W2qkuCjPZ
 aHl1emX0LDtXluFHB0TOphdrs9iRdlM2saJEzyuYxtd1JqJMQiHDs1UyOmVlel1r
 xdz7C4+AVMsM+xStGGfGw0XEMdUmJk6Yp6z6wmdI9LK5AS0JxP1NHmGVitQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so24112a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719898; x=1784324698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=doTTHLUxsEtKunA9wrhHCgnr5rsmsJhkZfbHLI98hfE=;
 b=Hc68UPPj1WOCZlnoX+i+OSfIBt9PvGMzTEKbMSbZYzWp6G/ETSjp1Tw/Rw5uNGiI3k
 d56ivzf64cXybovQP0UVywPq0EYTBd2cRs7ULgKEhMvdVIbz8zwQvWG6YwH29+DE433C
 qX/DCY2K13CBaCDp86vFa4vMuOD3AcFbOQqAatphuzTsuhj4LACOAFQEOg4WPIwM0w4w
 /KnsjarBoIPiR6h18L1EvNH80Q4R8lNhdq9EHruZ1szQ4vb4FqRBYRPVFBmAVDEBTwWo
 xbLOODXaK4/CKUq6U9yOzlTtEkJMlVGnBKGzFhNcPu+mgI2I46Ovei4MCG485z7ehk9+
 UEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719898; x=1784324698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=doTTHLUxsEtKunA9wrhHCgnr5rsmsJhkZfbHLI98hfE=;
 b=lUJ3/qNXdT/VhHsOrVlyuRXg2ad7hroje0MhqQYy87z3Z3KmF8TB7W9Pukhu5YUiEY
 UvZ4k7X/PLLnE7wfxbe0wTlP5w9vgUx5qp6ra4Rzd7eL3h2hwYXcDoulSlTZkssaBdp8
 IazCSgIkgWFqT4fYrI0IO5kQmzbM4T0Ee9BRdB628B1hpA72nIbRXI8ues7AwQ2C8vUC
 +qaP8LuOlSHktmuMkNaSImiW+IxA9SUBD+eN9OR7KHcedxBpnZqOx6HGRLj/r0MY1GVD
 3Xr4d/uSLCl37nHnL6jBs+q21L0F1Om4bwqKwLoul7cjdnuvn9PRxiDlUpZALZZC71XD
 /m+A==
X-Gm-Message-State: AOJu0YyZZN/rq731Qd9OHNbM9VeilB/Qd2AU8h8hmVyRvFjLvGxdGSJc
 aB+xs3uS072uVQNzpCk71Ug2WGCN43p9HVMYd80EOhdSwsN2be3arcscZNVS8VnTu6+4Y09PUNa
 dSzZLGh5jUvhFDnh8NpZ47Ed6YYpmrjmv6PWOQSNgF8E2N/vwXdNBQdEMGzS6ynzU6A==
X-Gm-Gg: AfdE7cm7v/A5Bvb8Wxs1zPQChDY0D5kSnlHvsXyM6lE3GwHjwJew9Bl3vtdgMSLvt3j
 8SKkf7SNzCUCM/p6r58l2iLe5jUiX2fcZNMvmt7bTZzYiNWyXsPN30KHnx5j0XCnnNLPB8kp5jY
 zyiYcCf6HCK+82sWZgeojxyMv3BWh+iKWI6FlPVVi44mwdbZXDiem+uzUJu9vSJwgiRo7rliNMR
 AWNKfkIfNZWIdDmeZIvaVlB93XpZ1BNsB0iaC+W5GqSgAndeZzb8CTZZXf6GcAQ8/sF86GA0HTz
 ZXeN5MWYfpD6dsgU4WSXwCNTRz7aqgJucXiqKdmG97Xwz/NRyBw4Mqzqx85W/YRW/tdS33wSNxV
 dFbdbEIeOcjncQG6Ln7Cwzr82XSL3+d6tQSoBf1/R5yIykLOr8lxFn0+rio075YOgfdYsAMhH1d
 2OS2ytbw==
X-Received: by 2002:a05:6a20:4304:b0:3b4:8300:7019 with SMTP id
 adf61e73a8af0-3c11051148cmr751925637.18.1783719897498; 
 Fri, 10 Jul 2026 14:44:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3b4:8300:7019 with SMTP id
 adf61e73a8af0-3c11051148cmr751889637.18.1783719896983; 
 Fri, 10 Jul 2026 14:44:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:56 -0700 (PDT)
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
Subject: [PATCH v5 38/98] tests/tcg/aarch64: user tests
Date: Fri, 10 Jul 2026 14:42:42 -0700
Message-ID: <20260710214343.2065491-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX/QLF8QQ0FrDK
 /Ut/yjox8e9x97fWV9tr03z/4IO229tj8K+t3qWmXZ5TjqxoKESMHbXXsEyUwfuez5bD/Asp0M6
 RmwjWtN7m3o0N8OTIA2zK8aPvMe2SmejI5uOt6v/JIsGgUCxtlkYBOOhn6pH1DjC8meFrGZb1b+
 4jnan3Dre6wsEAfoJDnHr8Vt95gS9Yy4leHWyfEBKrRBIBo3CmOCYYZ2U5OHpX+wNxLq6+/oFzS
 hz18STVmRP7h7ZhC9v+B7eSe+k0/MNR4E02i0fhG2ngN+HWlQxkHnqVxDqEd65zdXNj+1oy6uRB
 RLaBJdKaGMyDjQquACV0fqft8gmB5DP48/1grcR5IvRo2WdoKxK9jBo7ds9c8OriWAuWTsuXwZx
 EjCerXCGMeglKrf7AQ89I7RjY3wspoSi3FHiSoNFrz2juPnUMoKxiatqc2tRQIXw4cZ2tCCVn2c
 ttAl1uUF0yjvjoYHu5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX8P9hQUMca9xY
 F28PW4hwLr8nOH/a4DmpEVn+0Z5BGuOFd6wNcjRx2QcdD3TOIClWKG+zLwpteOI2VU00hvhmxw1
 qcWWz/BKp8N/+hX06fYPjiVy27MGKRI=
X-Proofpoint-ORIG-GUID: buidpzo6HngcnIAqeowWChaDDU4MBR6j
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167da cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Em0P4F6pParytpyspAEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: buidpzo6HngcnIAqeowWChaDDU4MBR6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/Makefile.target | 210 ------------------------------
 tests/tcg/aarch64/meson.build     | 205 +++++++++++++++++++++++++++++
 tests/tcg/meson.build             |   3 +
 3 files changed, 208 insertions(+), 210 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/meson.build

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
deleted file mode 100644
index 32f26892737..00000000000
--- a/tests/tcg/aarch64/Makefile.target
+++ /dev/null
@@ -1,210 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# AArch64 specific tweaks
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
-VPATH 		+= $(ARM_SRC)
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-VPATH 		+= $(AARCH64_SRC)
-
-# Base architecture tests
-AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
-AARCH64_TESTS += test-2248 test-2150
-
-fcvt: LDFLAGS+=-lm
-
-run-fcvt: fcvt
-	$(call run-test,$<,$(QEMU) $<)
-	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    fnia=`$(call cc-test,-fno-integrated-as) && echo -fno-integrated-as`; \
-	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
-	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
-	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
-	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
-	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
-	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
-	    $(call cc-option,-march=armv9-a+fprcvt,         CROSS_CC_HAS_ARMV9_FPRCVT)) 3> config-cc.mak
--include config-cc.mak
-
-ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
-AARCH64_TESTS += fcvt-fprcvt
-fcvt-fprcvt: LDFLAGS += -lm
-fcvt-fprcvt: CFLAGS += $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
-fcvt-fprcvt: fcvt.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-fcvt-fprcvt: fcvt-fprcvt
-	$(call run-test,$<,$(QEMU) $<)
-	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_2),)
-AARCH64_TESTS += dcpop
-dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
-endif
-ifneq ($(CROSS_CC_HAS_ARMV8_5),)
-AARCH64_TESTS += dcpodp
-dcpodp: CFLAGS += $(CROSS_CC_HAS_ARMV8_5)
-endif
-
-# Pauth Tests
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
-pauth-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-test-2375: CFLAGS += -march=armv8.3-a
-run-pauth-1: QEMU_OPTS += -cpu max
-run-pauth-2: QEMU_OPTS += -cpu max
-# Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
-run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
-run-pauth-5: QEMU_OPTS += -cpu neoverse-v1
-endif
-
-# BTI Tests
-# bti-1 tests the elf notes, so we require special compiler support.
-ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
-AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -fno-stack-protector $(CROSS_CC_HAS_ARMV8_BTI)
-bti-1 bti-3: LDFLAGS += -nostdlib
-endif
-# bti-2 tests PROT_BTI, so no special compiler support required.
-AARCH64_TESTS += bti-2
-
-# MTE Tests
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9 mte-10
-mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
-endif
-
-# SME Tests
-ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-SME_TESTS = sme-outprod1 sme-smopa-1 sme-smopa-2 sme-fmopa-1 sme-fmopa-2 sme-fmopa-3
-AARCH64_TESTS += $(SME_TESTS)
-$(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
-endif
-
-# GCS Tests
-GCS_TESTS += gcsstr gcspushm gcsss
-AARCH64_TESTS += $(GCS_TESTS)
-$(GCS_TESTS): gcs.h
-
-# System Registers Tests
-AARCH64_TESTS += sysregs
-
-AARCH64_TESTS += test-aes
-test-aes: CFLAGS += -O -march=armv8-a+aes
-test-aes: test-aes-main.c.inc
-
-# Vector SHA1
-# Work around compiler false-positive warning, as we do for the 'sha1' test
-sha1-vector: CFLAGS=-O3 -Wno-stringop-overread
-sha1-vector: sha1.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-sha1-vector: sha1-vector run-sha1
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
-	$(call diff-out, sha1-vector, sha1.out)
-
-TESTS += sha1-vector
-
-# Vector versions of sha512 (-O3 triggers vectorisation)
-sha512-vector: CFLAGS=-O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS += sha512-vector
-
-ifneq ($(CROSS_CC_HAS_SVE),)
-# SVE ioctl test
-AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS += $(CROSS_CC_HAS_SVE)
-
-sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
-sha512-sve: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-sve-str: CFLAGS=-O1 -march=armv8.1-a+sve
-sve-str: sve-str.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS += sha512-sve sve-str
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-sysregs: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
-	basic gdbstub SVE support)
-
-run-gdbstub-sve-ioctls: sve-ioctls
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
-	basic gdbstub SVE ZLEN support)
-
-EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
-
-ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-# SME gdbstub tests
-
-run-gdbstub-sysregs-sme: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
-		-- test_sme --gdb_basic_za_test, \
-	basic gdbstub SME support)
-
-ifeq ($(GDB_HAS_SME_TILES),y)
-run-gdbstub-sysregs-sme-tile-slice: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
-		-- test_sme --gdb_tile_slice_test, \
-	gdbstub SME ZA tile slice support)
-else
-run-gdbstub-sysregs-sme-tile-slice: sysregs
-	$(call skip-test,"gdbstub SME ZA tile slice support", \
-	"selected gdb ($(GDB)) does not support SME ZA tile slices")
-endif
-
-run-gdbstub-sysregs-sme2: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme2.py, \
-	gdbstub SME ZA tile slice support)
-
-EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice run-gdbstub-sysregs-sme2
-
-endif
-
-ifeq ($(GDB_HAS_MTE),y)
-run-gdbstub-mte: mte-8
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
-		-- --mode=user, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-endif
-
-endif
-endif
-
-ifneq ($(CROSS_CC_HAS_SVE2),)
-AARCH64_TESTS += test-826
-test-826: CFLAGS += $(CROSS_CC_HAS_SVE2)
-endif
-
-TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
new file mode 100644
index 00000000000..959d1cf698f
--- /dev/null
+++ b/tests/tcg/aarch64/meson.build
@@ -0,0 +1,205 @@
+cc = 'aarch64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'aes': '-march=armv8-a+aes',
+  'sve': '-march=armv8.1-a+sve',
+  'sve2': '-march=armv8.1-a+sve2',
+  'v8.2': '-march=armv8.2-a',
+  'v8.3': '-march=armv8.3-a',
+  'v8.5': '-march=armv8.5-a',
+  'bti':  '-mbranch-protection=standard',
+  'mte':  '-march=armv8.5-a+memtag',
+  'sme':  '-Wa,-march=armv9-a+sme',
+  'fprcvt': '-march=armv9-a+fprcvt',
+}
+
+gdb_feat_version = {
+  'sme-tiles': '14.1',
+  'mte': '15.1',
+  'mte-baremetal': '16.0',
+}
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+# Base architecture tests
+tests += {
+  '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
+  'pcalign-a64.c': {},
+  'lse2-fault.c': {},
+  'test-2248.c': {},
+  'test-2150.c': {},
+}
+
+tests += {'dcpop.c': {'cc_feat': 'v8.2'}}
+tests += {'dcpodp.c': {'cc_feat': 'v8.5'}}
+
+# Pauth Tests
+cpu_max = ['-cpu', 'max']
+cpu_neoverse = ['-cpu', 'neoverse-v1']
+tests += {
+  'test-2375.c': {'cc_feat': 'v8.3'},
+  'pauth-1.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  'pauth-2.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+  'pauth-4.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+  'pauth-5.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+}
+
+# BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
+f = ['-fno-stack-protector', '-nostdlib']
+tests += {
+  'bti-1.c': {'cc_feat': 'bti', 'cflags': f},
+  'bti-3.c': {'cc_feat': 'bti', 'cflags': f},
+}
+# bti-2 tests PROT_BTI, so no special compiler support required.
+tests += {'bti-2.c': {}}
+
+# MTE Tests
+tests += {
+  'mte-1.c': {'cc_feat': 'mte'},
+  'mte-2.c': {'cc_feat': 'mte'},
+  'mte-3.c': {'cc_feat': 'mte'},
+  'mte-4.c': {'cc_feat': 'mte'},
+  'mte-5.c': {'cc_feat': 'mte'},
+  'mte-6.c': {'cc_feat': 'mte'},
+  'mte-7.c': {'cc_feat': 'mte'},
+  'mte-8.c': {'cc_feat': 'mte'},
+  'mte-9.c': {'cc_feat': 'mte'},
+  'mte-10.c': {'cc_feat': 'mte'},
+}
+tests += {
+  'mte-8.c': {
+    'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
+    'gdb_feat': 'mte',
+  }
+}
+
+# SME Tests
+tests += {
+  'sme-outprod1.c': {'cc_feat': 'sme'},
+  'sme-smopa-1.c': {'cc_feat': 'sme'},
+  'sme-smopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-1.c': {'cc_feat': 'sme'},
+  'sme-fmopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-3.c': {'cc_feat': 'sme'},
+}
+sysregs_sme = 'sysregs-sme'
+tests += {
+  'sysregs.c': {
+    'exe_name': sysregs_sme,
+    'cc_feat': 'sme',
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_basic_za_test'],
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme-tile-slice',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_tile_slice_test'],
+    'gdb_feat': 'sme-tiles',
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme2',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
+  }
+}
+
+# GCS Tests
+tests += {
+  'gcsstr.c': {},
+  'gcspushm.c': {},
+  'gcsss.c': {},
+}
+
+# System Registers Tests
+tests += {'sysregs.c': {}}
+
+# Crypto Tests
+tests += {'test-aes.c': {'cc_feat': 'aes'}}
+
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
+# SVE Tests
+tests += {
+  'sve-ioctls.c': {'cc_feat': 'sve'},
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sve',
+     'cc_feat': 'sve',
+  },
+  'sve-str.c': {'cc_feat': 'sve', 'cflags': ['-O1']},
+}
+tests += {
+  'sysregs.c': {
+    'exe_name': 'sysregs-sve',
+    'cc_feat': 'sve',
+    'gdb_test': ['--test', files('gdbstub/test-sve.py')],
+  },
+  'sve-ioctls.c': {
+    'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
+  },
+}
+
+# SVE2 Tests
+tests += {'test-826.c': {'cc_feat': 'sve2'}}
+
+# FPRCVT test
+tests += {
+  '../arm/fcvt.c': {
+    'exe_name': 'fcvt-fprcvt',
+    'cflags': ['-DFPRCVT', '-lm'],
+    # fprcvt is available only from gcc-16.
+    # Use raw opcode until it's available in cross container.
+    # 'cc_feat': 'fprcvt',
+    'expected_output': 'fcvt.ref'},
+}
+
+# Semihosting tests
+# Add -I path for semicall.h
+semihosting_cflags = ['-I', meson.current_source_dir()]
+
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 48bf747b316..eef7ae12afb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -132,6 +132,9 @@ foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
   tcg_tests += {target: {'tests': tests + plugin_tests}}
 endforeach
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.47.3


