Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A9EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTT-00031R-30; Tue, 18 Aug 2026 15:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTQ-0002mP-OF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTN-0007Oj-LQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH1HS1006317
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OStZsy9zh9E
 Sh/yv8GlFMJXy8ALoi5yLu8xbaZN0g8g=; b=mYvYWwslHyHVmqGEeh4Bu/xxf7+
 MGuqiMKcP9Ly9IlkRL9q4GzGVUQ24VHTdvcoon/IUJWq1OnY0Xi5o+uF5sXz2tPn
 zQWK/oM+AdNpePKKajYfuJkHxxdYtTC4WCRwpBGM+1b7tgQrmPuAVKmCbV1hx2cx
 zOdyw7LhFyOipum95pxYWqdH8SWAvn1Eots5NL3lhQ8HeQfNXTS8v5CZsK4ytdb7
 r5zHslQ1US9mNwzDVKnZqQXqOA8aqwTMFa3+VtrvIjnBtO663FBF82qmREjXopW5
 D2BUutNiQaQF4xBjiLr11DI5H1BcdhUu81pXf2u36KhG1x/QT1T2VvrHKkw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrvkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso276216a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081263; x=1787686063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OStZsy9zh9ESh/yv8GlFMJXy8ALoi5yLu8xbaZN0g8g=;
 b=jg6iuBTXIcetWgdLoyenqdtBRnAWWvwYUV89hAS+sjXgNFTf3Gwr0BQt6feeTcO/Oc
 hgWFgT5EqII4sfDo7D57DBFv+JsY5767Tw8UkXaZ8KH4xAJvNRYlS8L9xod2YF7WJ36M
 UNSQPvbtYFlpzo8IinOBuQhDNNvjOnWq1D+mOR2o0C6zd+rajpgaU07k4B6v7jej5S3x
 TOhzhqaCrZ0w39mzxKfJQXSSNJ+vaHLblWI5W1EISGUtI31TnObThTo1XUTWkv3pp17g
 FGNFsEWrFXf4TIxlC/DeNThJsfCeB4Kc3WuvGlJkwbP1TU+1gf51yEUAylSHlRJcyY8c
 duZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081263; x=1787686063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OStZsy9zh9ESh/yv8GlFMJXy8ALoi5yLu8xbaZN0g8g=;
 b=LfWWHlbYMqvUJllx2sKpPkZUtjKQfeBGq/SVpZxZWyCO7uHUAiniHPMxUCoe3WFw52
 Jc7hVE+hLv1/2kiRTiFS+dmPgBB5TE+uIABFSo9c2HFP+h0kK0cwWwa8btr/6eCyZN65
 FGho7TzSiWnYgiQEYiRpEisxv+YQOU9yIG8QS3i5XZj8OZ8pKCyLZdqbSqF2AmCxkvRp
 X8wjk/WqVHKl3xFZpu7X0siGTAYWqsn+HLNmqcvWvUFkswkNkT6U18tpMkQQ5up3p/GL
 kwGYfovNTXodbrluGKJKYsMKQiavD6BbN4tdzEYTOiOvMQnyisB5U8fZ5HWY7OFckzPu
 ynuA==
X-Gm-Message-State: AOJu0YwlzZHc1rFLRDbpw75lbcQmXvAvhFHza7tnN+TFFWSwUe7tuYjq
 eckIG/kczFoyfDTpRU/zopdvQYL8x+0hKxB0pF4iC4RN0b5ALDBV5WsGr80cq6YeQTieoAA/KLx
 ji8D6U9yeicyqrQUS9cnnCnEdjQKCE1AUbuhu+JxFvKt0Y7zMC+ezCWdm748K/xs0hA==
X-Gm-Gg: AR+sD12i+8yafcBSeUnTtAPiGrBxnlCJOwy7oynG5drIcrOTCVTEXPUHErwr+2aq0f5
 orj/IlUT2ivPiTe3ekPxzHkFeMxORU0topzufJqfdQWmFS7y5l/rklm6ILjPCvajg7Uqc+flTQa
 FIIkocmz/oAV2W7+/eKHBV7PdR3pnnHna9TnT/TPUOl98u/v+quyqvWH954to3+s6fGGPbUywYn
 2ns3zfwMh0idFaO/ThAPeo5lhAfQLaglSgNPQtbz6umhnHhuS2A9siiDk11kBGtSNE9AGNsK4d1
 m1M3SV04o06+4ioZEEXfc/c6jBuqH9pvAEPLFTYR+c55MhxmDJRcaQtFrjVkcWNk1j3d4/VoNnn
 9b2+0zpRBtMZaoVXsROyihHb4M3io0cbY2Fpbwh4n2uC/BuZbvb3tp2pSc7M=
X-Received: by 2002:a05:6a20:c901:b0:3cc:3d08:da39 with SMTP id
 adf61e73a8af0-3ccfef7e40emr246072637.0.1787081262644; 
 Tue, 18 Aug 2026 12:27:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:c901:b0:3cc:3d08:da39 with SMTP id
 adf61e73a8af0-3ccfef7e40emr245971637.0.1787081262138; 
 Tue, 18 Aug 2026 12:27:42 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:41 -0700 (PDT)
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
Subject: [PATCH v7 040/104] tests/tcg/aarch64: user tests
Date: Tue, 18 Aug 2026 19:22:04 +0000
Message-ID: <20260818192309.22169-41-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxgS3vu7JBkY1
 m518eD3KxtLlyuuAy7zAE+bK3TAsToENwGucHG+dE855Yx4I+dd50n+WE8CCJu8lXJ8J2Zvlch3
 qrm3K42M99974gSbmL44DR0SOmWSKzLz7BlbxX5WV+kTOQnTkPvrlaH9+6ACl+WhHM4WHEc5vtP
 T/mOrOvzSQj4DZ0kfFVBA2uOVYJgBK+sFWcV8KGv7lUrgaU4uehy0SDyVqkDNWUaZGAGTYVxPbS
 LLmsyNE05YTy2nnRm2H2Wk5r2HbY/Jf+VFmhgG4+PgcTdI8fhOk10QuTE9r+fkg+yW09NgKdjEn
 U2QDJ2fwCOwa1nhyi75grHKuPMnAfemGYTCntMx1ejeXgl6sl4EEwLCgDcTyv3j5sE5VgL3OpJV
 0pb3CliUwHdVT+4rnM9dk6HWUavIGTRhyyIekOKZlq8MqI0DUIjXkc+XPXN5AWZqRQAPFqi3tGy
 bGiKYmeLaQ6HQUprBiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5Vw70AzD4fMz
 D7y6Jmg4M9na2ATgOonRpqfPHE4QqeYcuJS6MgquKXP1idDAWM6lFhgNsnrz5cWBPTol6JSa0cm
 kBdYsUGRjDmFLMYx0JkbU47+sWEPLc8=
X-Proofpoint-GUID: Qc5vSb_O6_SMUH5aDbOnOz_McVJj7s6K
X-Proofpoint-ORIG-GUID: Qc5vSb_O6_SMUH5aDbOnOz_McVJj7s6K
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b230 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Em0P4F6pParytpyspAEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
index 16292d4d7b0..76d7dbe045b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -135,6 +135,9 @@ foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
   tcg_tests += {target: {'tests': tests + plugin_tests}}
 endforeach
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.43.0


