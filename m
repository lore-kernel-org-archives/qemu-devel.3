Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14373C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1w-0005rZ-Hn; Mon, 06 Jul 2026 18:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1u-0005r9-PP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1p-0000LW-54
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KF2KL1642034
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dv54NiTm3Ry
 VDhyx306PUSGt8GS29XSUO84w/1u7cfc=; b=LFOUGk0pzCJG2H479qkaqmXzmvh
 JZwt6N/hyO+W80G0QRBtm6xMOJIUcWfxyNz3RCLE7nFSsLgIhoWmKFIL3wA/xRjM
 g8gQ7Jut2YFOLWrDGoqlyMfA3RCfl16r+8NHhBH6LBXntWMXUt4U1PBXnRq3iQPn
 Bl0J11taVvV1NWjqkZ92QbQDuLRTk1qf1g32KCV2dOMg7KrL7SOHMrYBN/zk+Qu+
 /GKxmfnZhV9Gn94dKaB2It70W6/lRU3O3uFWQPEIFzPBqPIGbjO2yfUmplz50Sn5
 TsIA8fnJJ50M691L4tYL1IYyExgzfKEI2nkFdbEX4f9zMv3vcwm/vqIexcw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r35s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:43:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c89956023dbso4729232a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377783; x=1783982583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dv54NiTm3RyVDhyx306PUSGt8GS29XSUO84w/1u7cfc=;
 b=bswTp1dulIN5KnCdsOiJWoIJrkaSYOLXChsQmCBKbLEBUfqCcOLzVSOXO22UXkQfGp
 pUn7pxZJoXVa9IdnzmttXdjnsWwzvP+Y4geY7yxfzwUodNpAYGBrTHup7TCK6gNguzzh
 H7JWCuMjUhWpp6BG6r6aVgFoX2xlrXOIBz07qVADEIT27Gr04GpT17ARok7RrDzQhDQl
 Hu+tiKRxOKQwnM4dYFyAgu9NmpQN5KYjLUV14A/u4LdtrG+vRWXWDv+9GeR+x1IzTI5h
 YsvFw2KNEuUqrkaFsrNwdHEZ2t6Fd9fj5BKzsY7z7zfDGXH4MAen6Bn0iTZKNzEjX6oY
 HWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377783; x=1783982583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dv54NiTm3RyVDhyx306PUSGt8GS29XSUO84w/1u7cfc=;
 b=Fdw06ccdn924idLt94pFbenUM+oFB7tilnx+tgKxHr/POfp114J2WNgC1ULqzIM+Oc
 GqyPlr7a18wfo/XJqNr2vqpaDnkXi7hI54YWUQuEDaFuMLy4An0m2ijKMmYSfRgnKXpf
 j1YkuznDBWzVVgKifTzOCssB5HAdD5idXjd5zXtVjfFlxjvndO4Ell6YAHsN4rxuEK70
 zye5hDEcS2IckHM9xVdWo4ef0TMXRJLBFOpAAssv9AUEUo9SIZLvMvuGW32lE+ex2Bwv
 ujw7n4CrofDEntgQiWbNnR1ESISg1D7lzJtndFTk8rV8Tv1JqVBwqlDAAU1eYa64pskA
 GebA==
X-Gm-Message-State: AOJu0Yzo4mf90WhB5vs4HO5NlnpHl5uklsylNg6o0aVnUyISJSLicPxa
 oDR+8+yxsM9I+fEa+vDaYIXcWqBOVgtKgvAmrphEGUBrTrL58avU4LfPuSUCuYwNtongWoTvQAe
 s6eiI7Y9apGG5O+pOfOmrE2Bum0uAbBy9dwmH+DdDQCd67licZzDUBV+wlnhDLe3tFA==
X-Gm-Gg: AfdE7cn+C4Nd7LU9FxSOk6yqYTFvpD/JBS8ZzjogUXfoA5YjJvXNsk/seI1lCoCzRr0
 wDumXogJXmYpAEe3l/C4Rtpu33cKPeLu8kGphKm2Wwshzp8gUkfJqGWyJIjGIcgV/7FLlab6F/1
 WGMb6FT3bpJp4rGCCUr4orGjb8BMb82cfETLWE+Rk7iBGrcSk+opGriaSeVXkei0Y8tm+TjEtPq
 Wy7yaAPFW3dHBOaFphjrPYYx6In4DlQWRloVdI1r8/UAAxLzxvf2hNjVqgG/SSvir3iIbA4G641
 9WMq/+gaJc0zUJOjxbfqzoEIWQDx21BT8zR1RadDKKSvC52vkC/PxA47RpqOHJ51nfbTqiwSpiD
 bY2/y4pv1M47elRJdKiHSDmOLqRxUziY2uAXa43XF/WVTpUzotypyCwlQ4P156bJQNm1ikAW62O
 UujEp+Ow==
X-Received: by 2002:a05:6300:2208:b0:3c0:9c1a:893c with SMTP id
 adf61e73a8af0-3c09c1a9b87mr102513637.68.1783377781578; 
 Mon, 06 Jul 2026 15:43:01 -0700 (PDT)
X-Received: by 2002:a05:6300:2208:b0:3c0:9c1a:893c with SMTP id
 adf61e73a8af0-3c09c1a9b87mr102407637.68.1783377779710; 
 Mon, 06 Jul 2026 15:42:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:59 -0700 (PDT)
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
Subject: [PATCH v3 90/91] tests/tcg: remove Makefiles
Date: Mon,  6 Jul 2026 15:33:42 -0700
Message-ID: <20260706223343.988769-91-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX39qSLEyaOy/S
 C8440mMi1hyQdUwZiJkbSH06jk1RS8w7zCxaZyaI5TSogAIW9tTJy5nb6cS+TmAECaCAAxpKfxg
 y7tX6TMXEhfvpw8n0uKroCV2HmJObp4LzDqmiwUO3o7c4GbEtmch4pSovzn/kyQ4vKS4gvNXP+X
 73B4AEV2+jcuQLN5bsnlaZOmvvZc7vW9rrggeU+XxyWXk5a8fd7VgFLOHTBOR4t4yLc2vW8jj89
 57/OpoRqb1SuXUPdeDUYMOopQOe6DFzqrnPQXmDQFVws5cq4NgH95CTRVkyyJBQf/AgkfAAQaSO
 dSQh3EV4vrv7/PHfRJ4hufo+deyF3FWdOS5qIWzsVZC3KxNyYl0U/RSdX2a9+b8WVoyuyx1LTE8
 5ha6e32IIWkeADbsY5B2pWql8qHkftlqZUaowqVHqpNl77dxLoG5EfeQ9b7IzRQ50A2AZep5OcB
 pHOol1SRLAc411cvyFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXz81yCEP0XB2k
 O93bpWb4z0VLUk2TSGnimFlGqGJjc9/sBPYpFirpaZ4bH00ntLuhdUDhVlJHt5SPPdMPYX8lWY0
 t/5G14xpR4E1UFsAHzSIqwi7c1wm8Vk=
X-Proofpoint-GUID: Q2zJmtEDTxKyNkW2GFwGDCr7mJiT2AZH
X-Proofpoint-ORIG-GUID: Q2zJmtEDTxKyNkW2GFwGDCr7mJiT2AZH
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2f78 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=mDV3o1hIAAAA:8
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=ALku5c8DAAAA:8 a=6o_fRWhhNNxDIx1bnI8A:9
 a=DdWl4vYK4o7w8uF8:21 a=bFCP_H2QrGi7Okbo017w:22 a=Skunnq644UPbuD6fT1yj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
 tests/tcg/Makefile.target                     | 281 ------------------
 tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---------
 tests/tcg/aarch64/Makefile.target             | 198 ------------
 tests/tcg/aarch64_be/Makefile.target          |  17 --
 tests/tcg/alpha/Makefile.softmmu-target       |  34 ---
 tests/tcg/alpha/Makefile.target               |  18 --
 tests/tcg/arm/Makefile.softmmu-target         |  80 -----
 tests/tcg/arm/Makefile.target                 |  87 ------
 tests/tcg/hexagon/Makefile.target             | 146 ---------
 tests/tcg/hppa/Makefile.target                |  14 -
 tests/tcg/i386/Makefile.softmmu-target        |  37 ---
 tests/tcg/i386/Makefile.target                | 102 -------
 tests/tcg/loongarch64/Makefile.softmmu-target |  33 --
 tests/tcg/loongarch64/Makefile.target         |  20 --
 tests/tcg/m68k/Makefile.target                |   7 -
 tests/tcg/minilib/Makefile.target             |  21 --
 tests/tcg/mips/Makefile.target                |  19 --
 tests/tcg/mips/user/ase/dsp/Makefile          | 184 ------------
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 ---
 tests/tcg/mips/user/isa/r5900/Makefile        |  32 --
 tests/tcg/mips64/Makefile.target              |  20 --
 tests/tcg/mips64el/Makefile.target            |   8 -
 tests/tcg/multiarch/Makefile.target           | 232 ---------------
 .../multiarch/system/Makefile.softmmu-target  |  81 -----
 tests/tcg/or1k/Makefile                       |  71 -----
 tests/tcg/ppc64/Makefile.target               |  63 ----
 tests/tcg/ppc64le/Makefile.target             |   7 -
 tests/tcg/riscv64/Makefile.softmmu-target     |  45 ---
 tests/tcg/riscv64/Makefile.target             |  20 --
 tests/tcg/s390x/Makefile.softmmu-target       |  57 ----
 tests/tcg/s390x/Makefile.target               | 127 --------
 tests/tcg/sh4/Makefile.target                 |  18 --
 tests/tcg/tricore/Makefile.softmmu-target     |  53 ----
 tests/tcg/x86_64/Makefile.softmmu-target      |  44 ---
 tests/tcg/x86_64/Makefile.target              |  40 ---
 tests/tcg/xtensa/Makefile.softmmu-target      |  46 ---
 tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
 37 files changed, 2454 deletions(-)
 delete mode 100644 tests/tcg/Makefile.target
 delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/aarch64/Makefile.target
 delete mode 100644 tests/tcg/aarch64_be/Makefile.target
 delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 delete mode 100644 tests/tcg/alpha/Makefile.target
 delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
 delete mode 100644 tests/tcg/arm/Makefile.target
 delete mode 100644 tests/tcg/hexagon/Makefile.target
 delete mode 100644 tests/tcg/hppa/Makefile.target
 delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
 delete mode 100644 tests/tcg/i386/Makefile.target
 delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 delete mode 100644 tests/tcg/m68k/Makefile.target
 delete mode 100644 tests/tcg/minilib/Makefile.target
 delete mode 100644 tests/tcg/mips/Makefile.target
 delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
 delete mode 100644 tests/tcg/mips64/Makefile.target
 delete mode 100644 tests/tcg/mips64el/Makefile.target
 delete mode 100644 tests/tcg/multiarch/Makefile.target
 delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 delete mode 100644 tests/tcg/or1k/Makefile
 delete mode 100644 tests/tcg/ppc64/Makefile.target
 delete mode 100644 tests/tcg/ppc64le/Makefile.target
 delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/riscv64/Makefile.target
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
 delete mode 100644 tests/tcg/s390x/Makefile.target
 delete mode 100644 tests/tcg/sh4/Makefile.target
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/x86_64/Makefile.target
 delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
deleted file mode 100644
index 1b83824ff4e..00000000000
--- a/tests/tcg/Makefile.target
+++ /dev/null
@@ -1,281 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# TCG tests
-#
-# These are complicated by the fact we want to build them for guest
-# systems. This requires knowing what guests we are building and which
-# ones we have cross-compilers for or docker images with
-# cross-compilers.
-#
-# The tests themselves should be as minimal as possible as
-# cross-compilers don't always have a large amount of libraries
-# available.
-#
-# We only include the host build system for SRC_PATH and we don't
-# bother with the common rules.mk. We expect the following:
-#
-#   CC - the C compiler command
-#   EXTRA_CFLAGS - any extra CFLAGS
-#   BUILD_STATIC - are we building static binaries
-#
-# By default all tests are statically compiled but some host systems
-# may not package static libraries by default. If an external
-# cross-compiler can only build dynamic libraries the user might need
-# to make extra efforts to ensure ld.so can link at runtime when the
-# tests are run.
-#
-# We also accept SPEED=slow to enable slower running tests
-#
-# We also expect to be in the tests build dir for the FOO-(linux-user|softmmu).
-#
-
-all:
--include ../config-host.mak
--include config-target.mak
-
-# Get semihosting definitions for user-mode emulation
-ifeq ($(filter %-softmmu, $(TARGET)),)
--include $(SRC_PATH)/configs/targets/$(TARGET).mak
-endif
-
-# for including , in command strings
-COMMA := ,
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX=tests/tcg/$(TARGET):$(SPACE)
-
-quiet-@ = $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(strip $2)" && ))
-quiet-command = $(call quiet-@,$2,$3)$1
-
-cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>&1
-cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "$(strip $2)=$(strip $1)" >&3; else \
-    echo "$(TARGET_PREFIX)$1 not detected"; fi
-
-# $1 = test name, $2 = cmd, $3 = desc
-ifeq ($(filter %-softmmu, $(TARGET)),)
-run-test = $(call quiet-command, timeout -s KILL --foreground $(TIMEOUT) $2 > $1.out, \
-	TEST,$(or $3, $*, $<) on $(TARGET_NAME))
-else
-run-test = $(call quiet-command, timeout -s KILL --foreground $(TIMEOUT) $2, \
-        TEST,$(or $3, $*, $<) on $(TARGET_NAME))
-endif
-
-# $1 = test name, $2 = reference
-# to work around the pipe squashing the status we only pipe the result if
-# we know it failed and then force failure at the end.
-diff-out = $(call quiet-command, diff -q $1.out $2 || \
-                                 (diff -u $1.out $2 | head -n 10 && false), \
-                                 DIFF,$1.out with $2)
-
-# $1 = test name, $2 = reason
-skip-test = @printf "  SKIPPED %s on $(TARGET_NAME) because %s\n" $1 $2
-
-# $1 = test name, $2 = reference
-# As above but only diff if reference file exists, otherwise the test
-# passes if it managed to complete with a status of zero
-conditional-diff-out = 							\
-	$(if $(wildcard $2), 						\
-		$(call diff-out,$1,$2), 				\
-		$(call skip-test,"$1 check","no reference"))
-
-
-# Tests we are building
-TESTS=
-# additional tests which may re-use existing binaries
-EXTRA_TESTS=
-
-# Start with a blank slate, the build targets get to add stuff first
-CFLAGS=
-LDFLAGS=
-
-QEMU_OPTS=
-CHECK_PLUGIN_OUTPUT_COMMAND=
-
-
-# If TCG debugging, or TCI is enabled things are a lot slower
-# so we have to set our timeout for that. The current worst case
-# offender is the system memory test running under TCI.
-TIMEOUT=120
-
-ifeq ($(filter %-softmmu, $(TARGET)),)
-# The order we include is important. We include multiarch first and
-# then the target. If there are common tests shared between
-# sub-targets (e.g. ARM & AArch64) then it is up to
-# $(TARGET_NAME)/Makefile.target to include the common parent
-# architecture in its VPATH. However some targets are so minimal we
-# can't even build the multiarch tests.
-ifneq ($(filter $(TARGET_NAME),aarch64_be),)
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
-else
--include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
-endif
-
-# Add the common build options
-CFLAGS+=-Wall -Werror -O0 -g -fno-strict-aliasing
-ifeq ($(BUILD_STATIC),y)
-LDFLAGS+=-static
-endif
-
-%: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-%: %.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack $< -o $@ $(LDFLAGS)
-else
-# For system targets we include a different Makefile fragment as the
-# build options for bare programs are usually pretty different. They
-# are expected to provide their own build recipes.
-EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
-
-# We skip the multiarch tests if the target hasn't provided a boot.S
-MULTIARCH_SOFTMMU_TARGETS = i386 alpha aarch64 arm loongarch64 s390x x86_64
-
-ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
--include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
--include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
-endif
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
-
-endif
-
-all: $(TESTS) $(EXTRA_TESTS)
-
-#
-# Test Runners
-#
-# By default we just run the test with the appropriate QEMU for the
-# target. More advanced tests may want to override the runner in their
-# specific make rules. Additional runners for the same binary should
-# be added to EXTRA_RUNS.
-#
-
-RUN_TESTS=$(patsubst %,run-%, $(TESTS))
-
-# If plugins exist also include those in the tests
-ifeq ($(CONFIG_PLUGIN),y)
-PLUGIN_SRC=$(SRC_PATH)/tests/tcg/plugins
-PLUGIN_LIB=../plugins
-VPATH+=$(PLUGIN_LIB)
-# Some plugins need to be disabled for all tests to avoid exponential explosion.
-# For example, libpatch.so only needs to run against the arch-specific patch
-# target test, so we explicitly run it in the arch-specific Makefile.
-DISABLE_PLUGINS=libpatch.so
-
-# Likewise don't bother with the syscall plugin for softmmu
-ifneq ($(filter %-softmmu, $(TARGET)),)
-DISABLE_PLUGINS += libsyscall.so
-endif
-
-PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
-	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
-
-strip-plugin = $(wordlist 1, 1, $(subst -with-, ,$1))
-extract-plugin = $(wordlist 2, 2, $(subst -with-, ,$1))
-extract-test = $(subst run-plugin-,,$(wordlist 1, 1, $(subst -with-, ,$1)))
-
-# We need to ensure expand the run-plugin-TEST-with-PLUGIN
-# pre-requistes manually here as we can't use stems to handle it. We
-# only expand MULTIARCH_TESTS which are common on most of our targets
-# and rotate the plugins so we don't grow too out of control as new
-# tests are added. Plugins that need to run with a specific test
-# should ensure they add their combination to EXTRA_RUNS.
-
-ifneq ($(MULTIARCH_TESTS),)
-
-# Extract extra tests from the extra test+plugin combination.
-EXTRA_TESTS_WITH_PLUGIN=$(foreach test, \
-                        $(EXTRA_RUNS_WITH_PLUGIN),$(call extract-test,$(test)))
-# Exclude tests that were specified to run with specific plugins from the tests
-# which can run with any plugin combination, so we don't run it twice.
-MULTIARCH_TESTS:=$(filter-out $(EXTRA_TESTS_WITH_PLUGIN), $(MULTIARCH_TESTS))
-
-NUM_PLUGINS := $(words $(PLUGINS))
-NUM_TESTS := $(words $(MULTIARCH_TESTS))
-
-define mod_plus_one
-  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
-endef
-
-# Rules for running tests with any plugin combination, i.e., no specific plugin.
-$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
-	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
-	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
-	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
-	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
-
-# Rules for running extra tests with specific plugins.
-$(foreach f,$(EXTRA_RUNS_WITH_PLUGIN), \
-    $(eval $(f): $(call extract-test,$(f)) $(call extract-plugin,$(f))))
-
-endif # MULTIARCH_TESTS
-endif # CONFIG_PLUGIN
-
-RUN_TESTS+=$(EXTRA_RUNS)
-RUN_TESTS+=$(EXTRA_RUNS_WITH_PLUGIN)
-
-# Some plugins need additional arguments above the default to fully
-# exercise things. We can define them on a per-test basis here.
-run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
-
-ifeq ($(filter %-softmmu, $(TARGET)),)
-run-%: %
-	$(call run-test, $<, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) $<)
-
-run-plugin-%:
-	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
-		-d plugin -D $*.pout \
-		 $(call strip-plugin,$<))
-	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
-		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
-		       TEST, check plugin $(call extract-plugin,$@) output    \
-		       with $(call strip-plugin,$<)))
-else
-run-%: %
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  $(QEMU_OPTS) $<)
-
-run-plugin-%:
-	$(call run-test, $@, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
-	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
-	    	  -d plugin -D $*.pout \
-		  $(QEMU_OPTS) $(call strip-plugin,$<))
-	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
-		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
-		       TEST, check plugin $(call extract-plugin,$@) output    \
-		       with $(call strip-plugin,$<)))
-endif
-
-gdb-%: %
-	gdb --args $(QEMU) $(QEMU_OPTS) $<
-
-# Filter tests based on TCG_TEST_FILTER if set
-ifdef TCG_TEST_FILTER
-FILTERED_RUN_TESTS=$(foreach test,$(RUN_TESTS),$(if $(findstring $(TCG_TEST_FILTER),$(test)),$(test)))
-else
-FILTERED_RUN_TESTS=$(RUN_TESTS)
-endif
-
-.PHONY: run
-run: $(FILTERED_RUN_TESTS)
-
-clean:
-	rm -f $(TESTS) *.o $(CLEANFILES)
-
-distclean:
-	rm -f config-cc.mak config-target.mak ../config-$(TARGET).mak
-
-.PHONY: help
-help:
-	@echo "TCG tests help $(TARGET_NAME)"
-	@echo "Built with $(CC)"
-	@echo "Available tests:"
-	@$(foreach t,$(RUN_TESTS),echo "  $t";)
-	@echo ""
-	@echo "Environment variables:"
-	@echo "  TCG_TEST_FILTER=<pattern>  Filter tests matching pattern"
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
deleted file mode 100644
index 3f30be6c5d6..00000000000
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,147 +0,0 @@
-#
-# Aarch64 system tests
-#
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
-
-VPATH+=$(AARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
-AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
-
-AARCH64_C_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_C_SRCS))
-AARCH64_S_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.S, %, $(AARCH64_TEST_S_SRCS))
-
-AARCH64_TESTS = $(AARCH64_C_TESTS)
-AARCH64_TESTS += $(AARCH64_S_TESTS)
-
-CRT_PATH=$(AARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(MINILIB_OBJS) -lgcc
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
--include config-cc.mak
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-vector_log_boot.o: $(CRT_PATH)/boot.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DLOGGING_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
-
-gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
-
-TESTS+=memory-sve gpc-test
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST) -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# vtimer test needs EL2
-QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
-
-# gpc tests need EL3 and RME
-QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
-QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
-run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-# This test explicitly checks the output of the pauth operation so we
-# must force the use of the QARMA5 algorithm for it.
-run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
-else
-pauth-3:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-pauth-3:
-	$(call skip-test, "RUN of pauth-3", "not built")
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
-QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-mte: CFLAGS+=-march=armv8.5-a+memtag
-mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-mte: mte
-
-ifeq ($(GDB_SUPPORTS_MTE_IN_BAREMETAL),y)
-run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-gdbstub-mte: mte
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--output run-gdbstub-mte.out \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "-chardev null$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py -- --mode=system, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-else # !GDB_SUPPORTS_MTE_IN_BAREMETAL
-run-gdbstub-mte:
-	$(call skip-test "RUN of gdbstub-mte", "GDB does not support MTE in baremetal!")
-endif
-else # !CROSS_CC_HAS_ARMV8_MTE
-mte:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-mte:
-	$(call skip-test, "RUN of mte", "not build")
-endif
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
deleted file mode 100644
index 6203ac9b517..00000000000
--- a/tests/tcg/aarch64/Makefile.target
+++ /dev/null
@@ -1,198 +0,0 @@
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
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
--include config-cc.mak
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
diff --git a/tests/tcg/aarch64_be/Makefile.target b/tests/tcg/aarch64_be/Makefile.target
deleted file mode 100644
index cbe5fa0b2db..00000000000
--- a/tests/tcg/aarch64_be/Makefile.target
+++ /dev/null
@@ -1,17 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# A super basic AArch64 BE makefile. As we don't have any big-endian
-# libc available the best we can do is a basic Hello World.
-
-AARCH64BE_SRC=$(SRC_PATH)/tests/tcg/aarch64_be
-VPATH += $(AARCH64BE_SRC)
-
-AARCH64BE_TEST_SRCS=$(notdir $(wildcard $(AARCH64BE_SRC)/*.c))
-AARCH64BE_TESTS=$(AARCH64BE_TEST_SRCS:.c=)
-#MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-# We need to specify big-endian cflags
-CFLAGS +=-mbig-endian -ffreestanding
-LDFLAGS +=-nostdlib
-
-TESTS += $(AARCH64BE_TESTS)
diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
deleted file mode 100644
index a944102a3ce..00000000000
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Alpha system tests
-#
-
-ALPHA_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/alpha/system
-VPATH+=$(ALPHA_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ALPHA_TEST_SRCS=$(wildcard $(ALPHA_SYSTEM_SRC)/*.c)
-ALPHA_TESTS = $(patsubst $(ALPHA_SYSTEM_SRC)/%.c, %, $(ALPHA_TEST_SRCS))
-
-CRT_PATH=$(ALPHA_SYSTEM_SRC)
-LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0 -mbwx
-
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
deleted file mode 100644
index 36d8ed1eaea..00000000000
--- a/tests/tcg/alpha/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Alpha specific tweaks
-
-ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
-VPATH+=$(ALPHA_SRC)
-
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
-TESTS+=$(ALPHA_TESTS)
-
-test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-test-cmov: test-cond.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-# Force generation of byte read/write
-test-plugin-mem-access: CFLAGS+=-mbwx
-
-run-test-cmov: test-cmov
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
deleted file mode 100644
index b66074b0b43..00000000000
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ /dev/null
@@ -1,80 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM SoftMMU tests - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-# Specific Test Rules
-
-test-armv6m-undef: test-armv6m-undef.S
-	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
-		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -static \
-		-T $(ARM_SRC)/$@.ld
-
-run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
-
-ARM_TESTS+=test-armv6m-undef
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
-ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
-
-CRT_PATH=$(ARM_SRC)
-LINK_SCRIPT=$(ARM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(ARM_SRC)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-TESTS += $(ARM_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
deleted file mode 100644
index 613bbf0939a..00000000000
--- a/tests/tcg/arm/Makefile.target
+++ /dev/null
@@ -1,87 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-fno-integrated-as, CROSS_CC_HAS_FNIA)) 3> config-cc.mak
--include config-cc.mak
-
-float_madds: CFLAGS+=-mfpu=neon-vfpv4
-
-# Basic Hello World
-ARM_TESTS = hello-arm
-hello-arm: CFLAGS+=-marm -ffreestanding -fno-stack-protector
-hello-arm: LDFLAGS+=-nostdlib
-
-# Float-convert Tests
-ARM_TESTS += fcvt
-fcvt: LDFLAGS += -lm
-fcvt: CFLAGS += -march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
-run-fcvt: fcvt
-	$(call run-test,fcvt,$(QEMU) $<)
-	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-
-# PC alignment test
-ARM_TESTS += pcalign-a32
-pcalign-a32: CFLAGS+=-marm
-
-ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
-
-# Semihosting smoke test for linux-user
-semihosting: CFLAGS += -mthumb
-
-ARM_TESTS += semihosting-arm
-semihosting-arm: CFLAGS += -marm -I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-semihosting-arm: semihosting.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-semihosting-arm: semihosting-arm
-	$(call run-test,$<,$(QEMU) $< 2> $<.err)
-
-ARM_TESTS += semiconsole-arm
-
-semiconsole: CFLAGS += -mthumb
-
-semiconsole-arm: CFLAGS += -marm -I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-semiconsole-arm: semihosting.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-semiconsole-arm: semiconsole-arm
-	$(call skip-test, $<, "MANUAL ONLY")
-
-endif
-
-ARM_TESTS += commpage
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
-ARM_TESTS += sha1-vector
-
-# Vector versions of sha512 (-O3 triggers vectorisation)
-sha512-vector: CFLAGS=-O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-ARM_TESTS += sha512-vector
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Require emitting arm32 instructions, otherwise the vCPU might accidentally
-# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
-test-plugin-set-pc: CFLAGS+=-marm
-endif
-
-TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
deleted file mode 100644
index 70a8ec2e7fb..00000000000
--- a/tests/tcg/hexagon/Makefile.target
+++ /dev/null
@@ -1,146 +0,0 @@
-##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
-##
-##  This program is free software; you can redistribute it and/or modify
-##  it under the terms of the GNU General Public License as published by
-##  the Free Software Foundation; either version 2 of the License, or
-##  (at your option) any later version.
-##
-##  This program is distributed in the hope that it will be useful,
-##  but WITHOUT ANY WARRANTY; without even the implied warranty of
-##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-##  GNU General Public License for more details.
-##
-##  You should have received a copy of the GNU General Public License
-##  along with this program; if not, see <http://www.gnu.org/licenses/>.
-##
-
-# Hexagon doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
-CFLAGS += -fno-unroll-loops -fno-stack-protector
-
-HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
-VPATH += $(HEX_SRC)
-
-%: $(HEX_SRC)/%.S $(HEX_SRC)/crt.S
-	$(CC) -static -mv67 -nostdlib $^ -o $@
-
-HEX_TESTS = first
-HEX_TESTS += hex_sigsegv
-HEX_TESTS += misc
-HEX_TESTS += usr
-HEX_TESTS += preg_alias
-HEX_TESTS += dual_stores
-HEX_TESTS += multi_result
-HEX_TESTS += mem_noshuf
-HEX_TESTS += mem_noshuf_exception
-HEX_TESTS += circ
-HEX_TESTS += brev
-HEX_TESTS += load_unpack
-HEX_TESTS += load_align
-HEX_TESTS += atomics
-HEX_TESTS += fpstuff
-HEX_TESTS += overflow
-HEX_TESTS += signal_context
-HEX_TESTS += reg_mut
-HEX_TESTS += read_write_overlap
-HEX_TESTS += vector_add_int
-HEX_TESTS += scatter_gather
-HEX_TESTS += hvx_misc
-HEX_TESTS += hvx_histogram
-HEX_TESTS += invalid-slots
-HEX_TESTS += invalid-encoding
-HEX_TESTS += multiple-writes
-HEX_TESTS += unaligned_pc
-
-HEX_TESTS += test_abs
-HEX_TESTS += test_bitcnt
-HEX_TESTS += test_bitsplit
-HEX_TESTS += test_call
-HEX_TESTS += test_clobber
-HEX_TESTS += test_cmp
-HEX_TESTS += test_dotnew
-HEX_TESTS += test_ext
-HEX_TESTS += test_fibonacci
-HEX_TESTS += test_hl
-HEX_TESTS += test_hwloops
-HEX_TESTS += test_jmp
-HEX_TESTS += test_lsr
-HEX_TESTS += test_mpyi
-HEX_TESTS += test_packet
-HEX_TESTS += test_reorder
-HEX_TESTS += test_round
-HEX_TESTS += test_vavgw
-HEX_TESTS += test_vcmpb
-HEX_TESTS += test_vcmpw
-HEX_TESTS += test_vlsrw
-HEX_TESTS += test_vmaxh
-HEX_TESTS += test_vminh
-HEX_TESTS += test_vpmpyh
-HEX_TESTS += test_vspliceb
-
-HEX_TESTS += check_rev_gating
-HEX_TESTS += test_pnew_jump_loads
-
-HEX_TESTS += v68_scalar
-HEX_TESTS += v68_hvx
-HEX_TESTS += v69_hvx
-HEX_TESTS += v73_scalar
-
-TESTS += $(HEX_TESTS)
-
-atomics: atomics.c hex_test.h
-brev: brev.c hex_test.h
-circ: circ.c hex_test.h
-dual_stores: dual_stores.c hex_test.h
-fpstuff: fpstuff.c hex_test.h
-hex_sigsegv: hex_sigsegv.c hex_test.h
-load_align: load_align.c hex_test.h
-load_unpack: load_unpack.c hex_test.h
-mem_noshuf_exception: mem_noshuf_exception.c hex_test.h
-mem_noshuf: mem_noshuf.c hex_test.h
-misc: misc.c hex_test.h
-multi_result: multi_result.c hex_test.h
-overflow: overflow.c hex_test.h
-preg_alias: preg_alias.c hex_test.h
-read_write_overlap: read_write_overlap.c hex_test.h
-reg_mut: reg_mut.c hex_test.h
-test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
-unaligned_pc: unaligned_pc.c
-
-# Compile for v66 so that the ELF selects a v66 CPU; the test then
-# exercises revision gating by executing a v68 .word instruction.
-run-check_rev_gating: QEMU_OPTS += -cpu v66
-check_rev_gating: check_rev_gating.c
-	$(CC) $(CFLAGS) -mv66 -O2 $< -o $@ $(LDFLAGS)
-
-# This test has to be compiled for the -mv67t target
-usr: usr.c hex_test.h
-	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-defined $< -o $@ $(LDFLAGS)
-
-# Build this test with -mv71 to exercise the CABAC instruction
-misc: misc.c
-	$(CC) $(CFLAGS) -mv71 -O2 $< -o $@ $(LDFLAGS)
-scatter_gather: CFLAGS += -mhvx
-vector_add_int: CFLAGS += -mhvx -fvectorize
-hvx_misc: hvx_misc.c hvx_misc.h
-hvx_misc: CFLAGS += -mhvx
-hvx_histogram: CFLAGS += -mhvx -Wno-gnu-folding-constant
-v68_hvx: v68_hvx.c hvx_misc.h v6mpy_ref.c.inc
-v68_hvx: CFLAGS += -mhvx -Wno-unused-function
-v69_hvx: v69_hvx.c hvx_misc.h
-v69_hvx: CFLAGS += -mhvx -Wno-unused-function
-v73_scalar: CFLAGS += -Wno-unused-function
-
-hvx_histogram: hvx_histogram.c hvx_histogram_row.S
-	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
-
-ifeq ($(CONFIG_PLUGIN),y)
-# LLVM is way too aggressive with inlining and dead code elimination even at
-# -O0, which interferes with the test. What looks like dead code in this test
-# to the compiler isn't actually dead code, so we need to disable all potential
-# LLVM optimization passes.
-test-plugin-set-pc: CFLAGS += -Xclang -disable-llvm-passes
-endif
diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
deleted file mode 100644
index ea5ae2186df..00000000000
--- a/tests/tcg/hppa/Makefile.target
+++ /dev/null
@@ -1,14 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# HPPA specific tweaks - specifically masking out broken tests
-
-# This triggers failures for hppa-linux about 1% of the time
-# HPPA is the odd target that can't use the sigtramp page;
-# it requires the full vdso with dwarf2 unwind info.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN awaiting vdso support")
-
-VPATH += $(SRC_PATH)/tests/tcg/hppa
-TESTS += stby
-
-stby: CFLAGS += -pthread
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
deleted file mode 100644
index 4096a1cf31f..00000000000
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
-#
-
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(I386_SYSTEM_SRC)
-LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-# Running
-QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
deleted file mode 100644
index f1df40411b0..00000000000
--- a/tests/tcg/i386/Makefile.target
+++ /dev/null
@@ -1,102 +0,0 @@
-# i386 cross compile notes
-
-I386_SRC=$(SRC_PATH)/tests/tcg/i386
-
-# Set search path for all sources
-VPATH 		+= $(I386_SRC)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-          $(call cc-option,-fno-pie, CROSS_CC_HAS_I386_NOPIE)) 3> config-cc.mak
-
--include config-cc.mak
-
-I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
-ALL_X86_TESTS=$(I386_SRCS:.c=)
-SKIP_I386_TESTS=test-i386-ssse3 test-avx test-3dnow test-mmx test-flags
-X86_64_TESTS:=$(filter test-i386-adcox test-i386-bmi2 $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
-
-test-i386-sse-exceptions: CFLAGS += -msse4.1 -mfpmath=sse
-run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
-
-test-i386-pcmpistri: CFLAGS += -msse4.2
-run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
-
-test-i386-bmi2: CFLAGS=-O2 -fwrapv
-run-test-i386-bmi2: QEMU_OPTS += -cpu max
-
-test-i386-adcox: CFLAGS=-O2
-run-test-i386-adcox: QEMU_OPTS += -cpu max
-
-test-aes: CFLAGS += -O -msse2 -maes
-test-aes: test-aes-main.c.inc
-run-test-aes: QEMU_OPTS += -cpu max
-
-#
-# hello-i386 is a barebones app
-#
-hello-i386: CFLAGS+=-ffreestanding -fno-stack-protector
-hello-i386: LDFLAGS+=-nostdlib
-
-# test-386 includes a couple of additional objects that need to be
-# linked together, we also need a no-pie capable compiler due to the
-# non-pic calls into 16-bit mode
-ifneq ($(CROSS_CC_HAS_I386_NOPIE),)
-test-i386: CFLAGS += -fno-pie
-
-test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $(EXTRA_CFLAGS) -o $@ \
-	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
-else
-test-i386:
-	$(call skip-test, "BUILD of $@", "missing -no-pie compiler support")
-run-test-i386:
-	$(call skip-test, "RUN of test-i386", "not built")
-endif
-
-ifeq ($(SPEED), slow)
-
-test-i386-fprem.ref: test-i386-fprem
-	$(call quiet-command, ./$< > $@,"GENREF","generating $@")
-
-run-test-i386-fprem: TIMEOUT=60
-run-test-i386-fprem: test-i386-fprem test-i386-fprem.ref
-	$(call run-test,test-i386-fprem, $(QEMU) $<)
-	$(call diff-out,test-i386-fprem, test-i386-fprem.ref)
-else
-SKIP_I386_TESTS+=test-i386-fprem
-endif
-
-# Update TESTS
-I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
-TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
-
-sha512-sse: CFLAGS=-msse4.1 -O3
-sha512-sse: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-sha512-sse: QEMU_OPTS+=-cpu max
-
-TESTS+=sha512-sse
-
-CLEANFILES += test-avx.h test-mmx.h test-3dnow.h
-test-3dnow.h: test-mmx.py x86.csv
-	$(PYTHON) $(I386_SRC)/test-mmx.py $(I386_SRC)/x86.csv $@ 3DNOW
-
-test-mmx.h: test-mmx.py x86.csv
-	$(PYTHON) $(I386_SRC)/test-mmx.py $(I386_SRC)/x86.csv $@ MMX SSE SSE2 SSE3 SSSE3
-
-test-avx.h: test-avx.py x86.csv
-	$(PYTHON) $(I386_SRC)/test-avx.py $(I386_SRC)/x86.csv $@
-
-test-3dnow: CFLAGS += -masm=intel -O -I.
-run-test-3dnow: QEMU_OPTS += -cpu max
-test-3dnow: test-3dnow.h
-
-test-mmx: CFLAGS += -masm=intel -O -I.
-run-test-mmx: QEMU_OPTS += -cpu max
-test-mmx: test-mmx.h
-
-test-avx: CFLAGS += -mavx -masm=intel -O -I.
-run-test-avx: QEMU_OPTS += -cpu max
-test-avx: test-avx.h
diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
deleted file mode 100644
index 6d4a20fde73..00000000000
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Loongarch64 system tests
-#
-
-LOONGARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/loongarch64/system
-VPATH+=$(LOONGARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-LOONGARCH64_TEST_SRCS=$(wildcard $(LOONGARCH64_SYSTEM_SRC)/*.c)
-LOONGARCH64_TESTS = $(patsubst $(LOONGARCH64_SYSTEM_SRC)/%.c, %, $(LOONGARCH64_TEST_SRCS))
-
-CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
deleted file mode 100644
index 00030a10266..00000000000
--- a/tests/tcg/loongarch64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# LoongArch64 specific tweaks
-
-# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
-VPATH += $(LOONGARCH64_SRC)
-
-LDFLAGS+=-lm
-
-LOONGARCH64_TESTS  = test_bit
-LOONGARCH64_TESTS  += test_div
-LOONGARCH64_TESTS  += test_fclass
-LOONGARCH64_TESTS  += test_fpcom
-LOONGARCH64_TESTS  += test_pcadd
-LOONGARCH64_TESTS  += test_fcsr
-
-TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
deleted file mode 100644
index 33f7b1b1275..00000000000
--- a/tests/tcg/m68k/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# m68k specific tweaks - specifically masking out broken tests
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap denormal
diff --git a/tests/tcg/minilib/Makefile.target b/tests/tcg/minilib/Makefile.target
deleted file mode 100644
index af0bf54be98..00000000000
--- a/tests/tcg/minilib/Makefile.target
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# System test minilib objects
-#
-# The system tests are very constrained in terms of the library they
-# support but we are not savages. We provide a few helpful routines
-# that can be shared with the tests for basic I/O.
-#
-# They assume each arch has provided a putc function.
-#
-
-SYSTEM_MINILIB_SRC=$(SRC_PATH)/tests/tcg/minilib
-MINILIB_SRCS=$(wildcard $(SYSTEM_MINILIB_SRC)/*.c)
-MINILIB_OBJS=$(patsubst $(SYSTEM_MINILIB_SRC)/%.c, %.o, $(MINILIB_SRCS))
-
-MINILIB_CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0
-MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
-
-.PRECIOUS: $(MINILIB_OBJS)
-
-%.o: $(SYSTEM_MINILIB_SRC)/%.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
deleted file mode 100644
index 5d17c1706e4..00000000000
--- a/tests/tcg/mips/Makefile.target
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# MIPS - included from tests/tcg/Makefile.target
-#
-
-MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
-
-# Set search path for all sources
-VPATH 		+= $(MIPS_SRC)
-
-# hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
-MIPS_TESTS=hello-mips
-
-TESTS += $(MIPS_TESTS)
-
-hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
-hello-mips: LDFLAGS+=-nostdlib
-endif
diff --git a/tests/tcg/mips/user/ase/dsp/Makefile b/tests/tcg/mips/user/ase/dsp/Makefile
deleted file mode 100644
index 5c6da96870e..00000000000
--- a/tests/tcg/mips/user/ase/dsp/Makefile
+++ /dev/null
@@ -1,184 +0,0 @@
--include ../../../../config-host.mak
-
-CROSS=mips64el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu 74Kf
-
-CC      = $(CROSS)gcc
-CFLAGS  = -EL -mabi=32 -march=mips32r2 -mgp32 -mdsp -mdspr2 -static
-
-TESTCASES  = test_dsp_r1_absq_s_ph.tst
-TESTCASES += test_dsp_r1_absq_s_w.tst
-TESTCASES += test_dsp_r1_addq_ph.tst
-TESTCASES += test_dsp_r1_addq_s_ph.tst
-TESTCASES += test_dsp_r1_addq_s_w.tst
-TESTCASES += test_dsp_r1_addsc.tst
-TESTCASES += test_dsp_r1_addu_qb.tst
-TESTCASES += test_dsp_r1_addu_s_qb.tst
-TESTCASES += test_dsp_r1_addwc.tst
-TESTCASES += test_dsp_r1_bitrev.tst
-TESTCASES += test_dsp_r1_bposge32.tst
-TESTCASES += test_dsp_r1_cmp_eq_ph.tst
-TESTCASES += test_dsp_r1_cmpgu_eq_qb.tst
-TESTCASES += test_dsp_r1_cmpgu_le_qb.tst
-TESTCASES += test_dsp_r1_cmpgu_lt_qb.tst
-TESTCASES += test_dsp_r1_cmp_le_ph.tst
-TESTCASES += test_dsp_r1_cmp_lt_ph.tst
-TESTCASES += test_dsp_r1_cmpu_eq_qb.tst
-TESTCASES += test_dsp_r1_cmpu_le_qb.tst
-TESTCASES += test_dsp_r1_cmpu_lt_qb.tst
-TESTCASES += test_dsp_r1_dpaq_sa_l_w.tst
-TESTCASES += test_dsp_r1_dpaq_s_w_ph.tst
-TESTCASES += test_dsp_r1_dpau_h_qbl.tst
-TESTCASES += test_dsp_r1_dpau_h_qbr.tst
-TESTCASES += test_dsp_r1_dpsq_sa_l_w.tst
-TESTCASES += test_dsp_r1_dpsq_s_w_ph.tst
-TESTCASES += test_dsp_r1_dpsu_h_qbl.tst
-TESTCASES += test_dsp_r1_dpsu_h_qbr.tst
-TESTCASES += test_dsp_r1_extp.tst
-TESTCASES += test_dsp_r1_extpdp.tst
-TESTCASES += test_dsp_r1_extpdpv.tst
-TESTCASES += test_dsp_r1_extpv.tst
-TESTCASES += test_dsp_r1_extr_rs_w.tst
-TESTCASES += test_dsp_r1_extr_r_w.tst
-TESTCASES += test_dsp_r1_extr_s_h.tst
-TESTCASES += test_dsp_r1_extrv_rs_w.tst
-TESTCASES += test_dsp_r1_extrv_r_w.tst
-TESTCASES += test_dsp_r1_extrv_s_h.tst
-TESTCASES += test_dsp_r1_extrv_w.tst
-TESTCASES += test_dsp_r1_extr_w.tst
-TESTCASES += test_dsp_r1_insv.tst
-TESTCASES += test_dsp_r1_lbux.tst
-TESTCASES += test_dsp_r1_lhx.tst
-TESTCASES += test_dsp_r1_lwx.tst
-TESTCASES += test_dsp_r1_madd.tst
-TESTCASES += test_dsp_r1_maddu.tst
-TESTCASES += test_dsp_r1_maq_sa_w_phl.tst
-TESTCASES += test_dsp_r1_maq_sa_w_phr.tst
-TESTCASES += test_dsp_r1_maq_s_w_phl.tst
-TESTCASES += test_dsp_r1_maq_s_w_phr.tst
-TESTCASES += test_dsp_r1_mfhi.tst
-TESTCASES += test_dsp_r1_mflo.tst
-TESTCASES += test_dsp_r1_modsub.tst
-TESTCASES += test_dsp_r1_msub.tst
-TESTCASES += test_dsp_r1_msubu.tst
-TESTCASES += test_dsp_r1_mthi.tst
-TESTCASES += test_dsp_r1_mthlip.tst
-TESTCASES += test_dsp_r1_mtlo.tst
-TESTCASES += test_dsp_r1_muleq_s_w_phl.tst
-TESTCASES += test_dsp_r1_muleq_s_w_phr.tst
-TESTCASES += test_dsp_r1_muleu_s_ph_qbl.tst
-TESTCASES += test_dsp_r1_muleu_s_ph_qbr.tst
-TESTCASES += test_dsp_r1_mulq_rs_ph.tst
-TESTCASES += test_dsp_r1_mult.tst
-TESTCASES += test_dsp_r1_multu.tst
-TESTCASES += test_dsp_r1_packrl_ph.tst
-TESTCASES += test_dsp_r1_pick_ph.tst
-TESTCASES += test_dsp_r1_pick_qb.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbla.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbl.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbra.tst
-TESTCASES += test_dsp_r1_precequ_ph_qbr.tst
-TESTCASES += test_dsp_r1_preceq_w_phl.tst
-TESTCASES += test_dsp_r1_preceq_w_phr.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbla.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbl.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbra.tst
-TESTCASES += test_dsp_r1_preceu_ph_qbr.tst
-TESTCASES += test_dsp_r1_precrq_ph_w.tst
-TESTCASES += test_dsp_r1_precrq_qb_ph.tst
-TESTCASES += test_dsp_r1_precrq_rs_ph_w.tst
-TESTCASES += test_dsp_r1_precrqu_s_qb_ph.tst
-TESTCASES += test_dsp_r1_raddu_w_qb.tst
-TESTCASES += test_dsp_r1_rddsp.tst
-TESTCASES += test_dsp_r1_repl_ph.tst
-TESTCASES += test_dsp_r1_repl_qb.tst
-TESTCASES += test_dsp_r1_replv_ph.tst
-TESTCASES += test_dsp_r1_replv_qb.tst
-TESTCASES += test_dsp_r1_shilo.tst
-TESTCASES += test_dsp_r1_shilov.tst
-TESTCASES += test_dsp_r1_shll_ph.tst
-TESTCASES += test_dsp_r1_shll_qb.tst
-TESTCASES += test_dsp_r1_shll_s_ph.tst
-TESTCASES += test_dsp_r1_shll_s_w.tst
-TESTCASES += test_dsp_r1_shllv_ph.tst
-TESTCASES += test_dsp_r1_shllv_qb.tst
-TESTCASES += test_dsp_r1_shllv_s_ph.tst
-TESTCASES += test_dsp_r1_shllv_s_w.tst
-TESTCASES += test_dsp_r1_shra_ph.tst
-TESTCASES += test_dsp_r1_shra_r_ph.tst
-TESTCASES += test_dsp_r1_shra_r_w.tst
-TESTCASES += test_dsp_r1_shrav_ph.tst
-TESTCASES += test_dsp_r1_shrav_r_ph.tst
-TESTCASES += test_dsp_r1_shrav_r_w.tst
-TESTCASES += test_dsp_r1_shrl_qb.tst
-TESTCASES += test_dsp_r1_shrlv_qb.tst
-TESTCASES += test_dsp_r1_subq_ph.tst
-TESTCASES += test_dsp_r1_subq_s_ph.tst
-TESTCASES += test_dsp_r1_subq_s_w.tst
-TESTCASES += test_dsp_r1_subu_qb.tst
-TESTCASES += test_dsp_r1_subu_s_qb.tst
-TESTCASES += test_dsp_r1_wrdsp.tst
-TESTCASES += test_dsp_r2_absq_s_qb.tst
-TESTCASES += test_dsp_r2_addqh_ph.tst
-TESTCASES += test_dsp_r2_addqh_r_ph.tst
-TESTCASES += test_dsp_r2_addqh_r_w.tst
-TESTCASES += test_dsp_r2_addqh_w.tst
-TESTCASES += test_dsp_r2_adduh_qb.tst
-TESTCASES += test_dsp_r2_adduh_r_qb.tst
-TESTCASES += test_dsp_r2_addu_ph.tst
-TESTCASES += test_dsp_r2_addu_s_ph.tst
-TESTCASES += test_dsp_r2_append.tst
-TESTCASES += test_dsp_r2_balign.tst
-TESTCASES += test_dsp_r2_cmpgdu_eq_qb.tst
-TESTCASES += test_dsp_r2_cmpgdu_le_qb.tst
-TESTCASES += test_dsp_r2_cmpgdu_lt_qb.tst
-TESTCASES += test_dsp_r2_dpaqx_sa_w_ph.tst
-TESTCASES += test_dsp_r2_dpa_w_ph.tst
-TESTCASES += test_dsp_r2_dpax_w_ph.tst
-TESTCASES += test_dsp_r2_dpaqx_s_w_ph.tst
-TESTCASES += test_dsp_r2_dpsqx_sa_w_ph.tst
-TESTCASES += test_dsp_r2_dpsqx_s_w_ph.tst
-TESTCASES += test_dsp_r2_dps_w_ph.tst
-TESTCASES += test_dsp_r2_dpsx_w_ph.tst
-TESTCASES += test_dsp_r2_mul_ph.tst
-TESTCASES += test_dsp_r2_mulq_rs_w.tst
-TESTCASES += test_dsp_r2_mulq_s_ph.tst
-TESTCASES += test_dsp_r2_mulq_s_w.tst
-TESTCASES += test_dsp_r2_mulsaq_s_w_ph.tst
-TESTCASES += test_dsp_r2_mulsa_w_ph.tst
-TESTCASES += test_dsp_r2_mul_s_ph.tst
-TESTCASES += test_dsp_r2_precr_qb_ph.tst
-TESTCASES += test_dsp_r2_precr_sra_ph_w.tst
-TESTCASES += test_dsp_r2_precr_sra_r_ph_w.tst
-TESTCASES += test_dsp_r2_prepend.tst
-TESTCASES += test_dsp_r2_shra_qb.tst
-TESTCASES += test_dsp_r2_shra_r_qb.tst
-TESTCASES += test_dsp_r2_shrav_qb.tst
-TESTCASES += test_dsp_r2_shrav_r_qb.tst
-TESTCASES += test_dsp_r2_shrl_ph.tst
-TESTCASES += test_dsp_r2_shrlv_ph.tst
-TESTCASES += test_dsp_r2_subqh_ph.tst
-TESTCASES += test_dsp_r2_subqh_r_ph.tst
-TESTCASES += test_dsp_r2_subqh_r_w.tst
-TESTCASES += test_dsp_r2_subqh_w.tst
-TESTCASES += test_dsp_r2_subuh_qb.tst
-TESTCASES += test_dsp_r2_subuh_r_qb.tst
-TESTCASES += test_dsp_r2_subu_ph.tst
-TESTCASES += test_dsp_r2_subu_s_ph.tst
-
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
deleted file mode 100644
index b7f5811a5e9..00000000000
--- a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
+++ /dev/null
@@ -1,40 +0,0 @@
-#
-#  Test program for MIPS64R6 CRC32 instructions
-#
-#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
-#
-#  SPDX-License-Identifier: GPL-2.0-or-later
-#
-
-ifndef PREFIX
-  $(error "PREFIX not set, please export GNU Toolchain install directory.")
-endif
-
-ifndef SYSROOT
-  $(error "SYSROOT not set, please export GNU Toolchain system root directory.")
-endif
-
-SIM = ../../../../../../../build/qemu-mips64
-SIM_FLAGS = -L $(SYSROOT)
-
-CC      =  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
-
-TESTCASES  = test_mips64r6_crc32b.tst
-TESTCASES += test_mips64r6_crc32h.tst
-TESTCASES += test_mips64r6_crc32w.tst
-TESTCASES += test_mips64r6_crc32d.tst
-TESTCASES += test_mips64r6_crc32cb.tst
-TESTCASES += test_mips64r6_crc32ch.tst
-TESTCASES += test_mips64r6_crc32cw.tst
-TESTCASES += test_mips64r6_crc32cd.tst
-
-all: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-            echo $(SIM) $(SIM_FLAGS) ./$$case; \
-            $(SIM) $(SIM_FLAGS) ./$$case; \
-            echo $(RM) -rf ./$$case; \
-            $(RM) -rf ./$$case; \
-	done
-
-%.tst: %.c
-	$(CC) $< -o $@
diff --git a/tests/tcg/mips/user/isa/r5900/Makefile b/tests/tcg/mips/user/isa/r5900/Makefile
deleted file mode 100644
index bff360df6c9..00000000000
--- a/tests/tcg/mips/user/isa/r5900/Makefile
+++ /dev/null
@@ -1,32 +0,0 @@
--include ../../../../config-host.mak
-
-CROSS=mipsr5900el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu R5900
-
-CC      = $(CROSS)gcc
-CFLAGS  = -Wall -mabi=32 -march=r5900 -static
-
-TESTCASES  = test_r5900_div1.tst
-TESTCASES += test_r5900_divu1.tst
-TESTCASES += test_r5900_madd.tst
-TESTCASES += test_r5900_maddu.tst
-TESTCASES += test_r5900_mflohi1.tst
-TESTCASES += test_r5900_mtlohi1.tst
-TESTCASES += test_r5900_mult.tst
-TESTCASES += test_r5900_multu.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
deleted file mode 100644
index 042855844a8..00000000000
--- a/tests/tcg/mips64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 - included from tests/tcg/Makefile.target
-#
-
-MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
-MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
-
-# Set search path for all sources
-VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
-
-MIPS64_TESTS=octeon-insns
-
-TESTS += $(MIPS64_TESTS)
-
-$(MIPS64_TESTS): CFLAGS+=-mabi=64
-
-run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
deleted file mode 100644
index dbc5f8dc5fe..00000000000
--- a/tests/tcg/mips64el/Makefile.target
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 little-endian - included from tests/tcg/Makefile.target
-#
-
-include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
deleted file mode 100644
index 6907c2830aa..00000000000
--- a/tests/tcg/multiarch/Makefile.target
+++ /dev/null
@@ -1,232 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Multiarch Tests - included from tests/tcg/Makefile.target
-#
-# These tests are plain C and built without any architecture specific code.
-#
-
-MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
-
-# Set search path for all sources
-VPATH 	       += $(MULTIARCH_SRC)
-MULTIARCH_SRCS =  $(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
-ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
-VPATH 	       += $(MULTIARCH_SRC)/linux
-MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
-endif
-ifeq ($(CONFIG_PLUGIN),y)
-VPATH 	       += $(MULTIARCH_SRC)/plugin
-MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
-endif
-MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-#
-# The following are any additional rules needed to build things
-#
-
-
-float_%: LDFLAGS+=-lm
-float_%: float_%.c libs/float_helpers.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< $(MULTIARCH_SRC)/libs/float_helpers.c -o $@ $(LDFLAGS)
-
-run-float_%: float_%
-	$(call run-test,$<, $(QEMU) $(QEMU_OPTS) $<)
-	$(call conditional-diff-out,$<,$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/$<.ref)
-
-fnmsub: LDFLAGS+=-lm
-
-testthread: LDFLAGS+=-lpthread
-
-threadcount: LDFLAGS+=-lpthread
-
-signals: LDFLAGS+=-lrt -lpthread
-
-munmap-pthread: CFLAGS+=-pthread
-munmap-pthread: LDFLAGS+=-pthread
-
-vma-pthread: CFLAGS+=-pthread
-vma-pthread: LDFLAGS+=-pthread
-
-sigreturn-sigmask: CFLAGS+=-pthread
-sigreturn-sigmask: LDFLAGS+=-pthread
-
-tb-link: LDFLAGS+=-lpthread
-
-# GCC versions 12/13/14/15 at least incorrectly complain about
-# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
-# Since this is just a standard piece of library code we've borrowed for a
-# TCG test case, suppress the warning rather than trying to modify the
-# code to work around the compiler.
-sha1: CFLAGS+=-Wno-stringop-overread -Wno-unknown-warning-option
-
-# The vma-pthread seems very sensitive on gitlab and we currently
-# don't know if its exposing a real bug or the test is flaky.
-ifneq ($(GITLAB_CI),)
-run-vma-pthread: vma-pthread
-	$(call skip-test, $<, "flaky on CI?")
-run-plugin-vma-pthread-with-%: vma-pthread
-	$(call skip-test, $<, "flaky on CI?")
-endif
-
-run-test-mmap: test-mmap
-	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-sha1: sha1
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
-	basic gdbstub support)
-
-run-gdbstub-qxfer-auxv-read: sha1
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
-	basic gdbstub qXfer:auxv:read support)
-
-run-gdbstub-qxfer-siginfo-read: segfault
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin "$< -s" --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-siginfo-read.py, \
-	basic gdbstub qXfer:siginfo:read support)
-
-run-gdbstub-proc-mappings: sha1
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-mappings.py, \
-	proc mappings support)
-
-run-gdbstub-thread-breakpoint: testthread
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
-	hitting a breakpoint on non-main thread)
-
-run-gdbstub-registers: sha512
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
-	checking register enumeration)
-
-# The prot-none test was skipped on gitlab due to missing gdb-multiarch,
-# however it seems to have bitrotten. Disable, it is tracked as
-# https://gitlab.com/qemu-project/qemu/-/issues/3329
-run-gdbstub-prot-none: prot-none
-ifneq ($(GITLAB_CI),)
-	$(call skip-test, $<, "Broken on GitLab")
-else
-	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
-	accessing PROT_NONE memory)
-endif
-
-run-gdbstub-catch-syscalls: catch-syscalls
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/catch-syscalls.py, \
-	hitting a syscall catchpoint)
-
-run-gdbstub-follow-fork-mode-child: follow-fork-mode
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-child.py, \
-	following children on fork)
-
-run-gdbstub-follow-fork-mode-parent: follow-fork-mode
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/follow-fork-mode-parent.py, \
-	following parents on fork)
-
-run-gdbstub-late-attach: late-attach
-	$(call run-test, $@, env LATE_ATTACH_PY=1 $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" --no-suspend \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/late-attach.py, \
-	attaching to a running process)
-
-else
-run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
-endif
-EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
-	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers run-gdbstub-prot-none \
-	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
-	      run-gdbstub-follow-fork-mode-parent \
-	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
-
-# ARM Compatible Semi Hosting Tests
-#
-# Despite having ARM in the name we actually have several
-# architectures that implement it. We gate the tests on the feature
-# appearing in config.
-#
-ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
-VPATH += $(MULTIARCH_SRC)/arm-compat-semi
-
-# Add -I path back to TARGET_NAME for semicall.h
-semihosting: CFLAGS+=-I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-
-run-semihosting: semihosting
-	$(call run-test,$<,$(QEMU) $< 2> $<.err)
-
-run-plugin-semihosting-with-%:
-	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
-		 $(call strip-plugin,$<) 2> $<.err, \
-		$< with $*)
-
-semiconsole: CFLAGS+=-I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-run-plugin-semiconsole-with-%:
-	$(call skip-test, $<, "MANUAL ONLY")
-
-TESTS += semihosting semiconsole
-endif
-
-test-plugin-mem-access: CFLAGS+=-pthread -O0
-test-plugin-mem-access: LDFLAGS+=-pthread -O0
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Test plugin memory access instrumentation
-run-plugin-test-plugin-mem-access-with-libmem.so: \
-	PLUGIN_ARGS=$(COMMA)print-accesses=true
-run-plugin-test-plugin-mem-access-with-libmem.so: \
-	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
-run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
-run-plugin-test-plugin-set-pc-with-libsetpc.so:
-
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
-			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
-			  run-plugin-test-plugin-set-pc-with-libsetpc.so
-
-else # CONFIG_PLUGIN=n
-# Do not build the syscall skipping test if it's not tested with the setpc
-# plugin because it will simply fail the test.
-MULTIARCH_TESTS := $(filter-out test-plugin-set-pc, $(MULTIARCH_TESTS))
-
-# test-plugin-syscall-filter needs syscall plugin to succeed
-test-plugin-syscall-filter: CFLAGS+=-DSKIP
-endif
-
-# Update TESTS
-TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
deleted file mode 100644
index 98c4eda5e00..00000000000
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ /dev/null
@@ -1,81 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Multiarch system tests
-#
-# We just collect the tests together here and rely on the actual guest
-# architecture to add to the test dependencies and deal with the
-# complications of building.
-#
-# To support the multiarch guests the target arch needs to provide a
-# boot.S that jumps to main and provides a __sys_outc functions.
-# Remember to update MULTIARCH_SOFTMMU_TARGETS in the tcg test
-# Makefile.target when this is done.
-#
-
-MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
-MULTIARCH_SYSTEM_SRC=$(MULTIARCH_SRC)/system
-VPATH+=$(MULTIARCH_SYSTEM_SRC)
-
-MULTIARCH_TEST_SRCS=$(wildcard $(MULTIARCH_SYSTEM_SRC)/*.c)
-MULTIARCH_TESTS = $(patsubst $(MULTIARCH_SYSTEM_SRC)/%.c, %, $(MULTIARCH_TEST_SRCS))
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-memory: memory
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) \
-		--output $<.gdb.out \
-		--qargs \
-		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/memory.py, \
-	softmmu gdbstub support)
-run-gdbstub-interrupt: interrupt
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) \
-		--output $<.gdb.out \
-		--qargs \
-		"-smp 2 -monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/interrupt.py, \
-	softmmu gdbstub support)
-run-gdbstub-untimely-packet: hello
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--gdb-args "-ex 'set debug remote 1'" \
-		--output untimely-packet.gdb.out \
-		--stderr untimely-packet.gdb.err \
-		--qemu $(QEMU) \
-		--bin $< --qargs \
-		"-monitor none -display none -chardev file$(COMMA)path=untimely-packet.out$(COMMA)id=output $(QEMU_OPTS)", \
-	softmmu gdbstub untimely packets)
-	$(call quiet-command, \
-		(! grep -Fq 'Packet instead of Ack, ignoring it' untimely-packet.gdb.err), \
-		"GREP", file untimely-packet.gdb.err)
-
-run-gdbstub-registers: memory
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) \
-		--output $<.registers.gdb.out \
-		--qargs \
-		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
-	softmmu gdbstub support)
-else
-run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
-endif
-
-MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
-	run-gdbstub-untimely-packet run-gdbstub-registers
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Test plugin memory access instrumentation
-run-plugin-memory-with-libmem.so: memory libmem.so
-run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
-run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
-
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-memory-with-libmem.so
-endif
diff --git a/tests/tcg/or1k/Makefile b/tests/tcg/or1k/Makefile
deleted file mode 100644
index fb5ceda512f..00000000000
--- a/tests/tcg/or1k/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
--include ../../config-host.mak
-
-CROSS = or1k-linux-
-
-SIM = qemu-or1k
-
-CC = $(CROSS)gcc
-
-TESTCASES = test_add.tst
-TESTCASES += test_sub.tst
-TESTCASES += test_addc.tst
-TESTCASES += test_addi.tst
-TESTCASES += test_addic.tst
-TESTCASES += test_and_or.tst
-TESTCASES += test_bf.tst
-TESTCASES += test_bnf.tst
-TESTCASES += test_div.tst
-TESTCASES += test_divu.tst
-TESTCASES += test_extx.tst
-TESTCASES += test_fx.tst
-TESTCASES += test_jal.tst
-TESTCASES += test_j.tst
-TESTCASES += test_lf_div.tst
-TESTCASES += test_lf_eqs.tst
-TESTCASES += test_lf_ges.tst
-TESTCASES += test_lf_gts.tst
-TESTCASES += test_lf_les.tst
-TESTCASES += test_lf_lts.tst
-TESTCASES += test_lf_mul.tst
-TESTCASES += test_lf_nes.tst
-TESTCASES += test_lf_rem.tst
-TESTCASES += test_lf_sub.tst
-TESTCASES += test_lf_add.tst
-TESTCASES += test_logic.tst
-TESTCASES += test_lx.tst
-TESTCASES += test_movhi.tst
-TESTCASES += test_mul.tst
-TESTCASES += test_mulu.tst
-TESTCASES += test_muli.tst
-TESTCASES += test_sfeq.tst
-TESTCASES += test_sfeqi.tst
-TESTCASES += test_sfges.tst
-TESTCASES += test_sfgesi.tst
-TESTCASES += test_sfgeu.tst
-TESTCASES += test_sfgeui.tst
-TESTCASES += test_sfgts.tst
-TESTCASES += test_sfgtsi.tst
-TESTCASES += test_sfgtu.tst
-TESTCASES += test_sfgtui.tst
-TESTCASES += test_sfles.tst
-TESTCASES += test_sflesi.tst
-TESTCASES += test_sfleu.tst
-TESTCASES += test_sfleui.tst
-TESTCASES += test_sflts.tst
-TESTCASES += test_sfltsi.tst
-TESTCASES += test_sfltu.tst
-TESTCASES += test_sfltui.tst
-TESTCASES += test_sfne.tst
-TESTCASES += test_sfnei.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) -static $< -o $@
-
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do $(SIM) $$case; echo $$case pass!; sleep 0.2; done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
deleted file mode 100644
index 0d058b26006..00000000000
--- a/tests/tcg/ppc64/Makefile.target
+++ /dev/null
@@ -1,63 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64 specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/ppc64
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-mcpu=power8,      CROSS_CC_HAS_CPU_POWER8); \
-	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak
-
--include config-cc.mak
-
-# multi-threaded tests are known to fail (e.g., clang-user CI job)
-# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
-run-signals: signals
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-run-plugin-signals-with-%:
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-
-run-threadcount: threadcount
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-run-plugin-threadcount-with-%:
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-
-ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
-PPC64_TESTS=bcdsub non_signalling_xscv
-endif
-$(PPC64_TESTS): CFLAGS += -mcpu=power8
-
-ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
-PPC64_TESTS += vsx_f2i_nan
-endif
-vsx_f2i_nan: CFLAGS += -mcpu=power8 -I$(SRC_PATH)/include
-
-PPC64_TESTS += mtfsf
-PPC64_TESTS += mffsce
-
-ifneq ($(CROSS_CC_HAS_POWER10),)
-PPC64_TESTS += byte_reverse sha512-vector vector
-endif
-byte_reverse: CFLAGS += -mcpu=power10
-run-byte_reverse: QEMU_OPTS+=-cpu POWER10
-
-sha512-vector: CFLAGS +=-mcpu=power10 -O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-sha512-vector: QEMU_OPTS+=-cpu POWER10
-
-vector: CFLAGS += -mcpu=power10 -I$(SRC_PATH)/include
-run-vector: QEMU_OPTS += -cpu POWER10
-
-PPC64_TESTS += signal_save_restore_xer
-PPC64_TESTS += xxspltw
-PPC64_TESTS += test-aes
-
-# ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol for a
-# given instruction. Thus, we don't check output of mem-access plugin.
-run-plugin-test-plugin-mem-access-with-libmem.so: \
- CHECK_PLUGIN_OUTPUT_COMMAND=
-
-TESTS += $(PPC64_TESTS)
diff --git a/tests/tcg/ppc64le/Makefile.target b/tests/tcg/ppc64le/Makefile.target
deleted file mode 100644
index daad5118a56..00000000000
--- a/tests/tcg/ppc64le/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64le specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/ppc64le
-
-include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
deleted file mode 100644
index 82be8a2c915..00000000000
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# RISC-V system tests
-#
-
-TEST_SRC = $(SRC_PATH)/tests/tcg/riscv64
-VPATH += $(TEST_SRC)
-
-LINK_SCRIPT = $(TEST_SRC)/semihost.ld
-LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
-
-%.o: %.S
-	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
-%: %.o $(LINK_SCRIPT)
-	$(LD) $(LDFLAGS) $< -o $@
-
-QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
-
-EXTRA_RUNS += run-issue1060
-run-issue1060: issue1060
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-mepc-masking
-run-test-mepc-masking: test-mepc-masking
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-doubletrap
-run-plugin-doubletrap: doubletrap
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-interruptedmemory
-run-plugin-interruptedmemory: interruptedmemory
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-crc32
-comma:= ,
-run-test-crc32: test-crc32
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
deleted file mode 100644
index 4da5b9a3b32..00000000000
--- a/tests/tcg/riscv64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-# RISC-V specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/riscv64
-TESTS += test-div
-TESTS += noexec
-
-# Disable compressed instructions for test-noc
-TESTS += test-noc
-test-noc: LDFLAGS = -nostdlib -static
-run-test-noc: QEMU_OPTS += -cpu rv64,c=false
-
-TESTS += test-aes
-run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
-
-# Test for fcvtmod
-TESTS += test-fcvtmod
-test-fcvtmod: CFLAGS += -march=rv64imafdc
-test-fcvtmod: LDFLAGS += -static
-run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
deleted file mode 100644
index a4425d3184a..00000000000
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ /dev/null
@@ -1,57 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-# EXTFLAGS can be passed by the user, e.g. to override the --accel
-QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
-LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
-CFLAGS+=-ggdb -O0 -I$(SRC_PATH)/include/hw/s390x/ipl/
-LDFLAGS=-nostdlib -static
-
-%.o: %.S
-	$(CC) -march=z13 -m64 -Wa,--noexecstack -c $< -o $@
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -march=z13 -m64 -c $< -o $@
-
-%: %.o
-	$(CC) $< -o $@ $(LDFLAGS)
-
-ASM_TESTS =                                                                    \
-    bal                                                                        \
-    cksm                                                                       \
-    clm                                                                        \
-    exrl-ssm-early                                                             \
-    icm                                                                        \
-    sam                                                                        \
-    lpsw                                                                       \
-    lpswe-early                                                                \
-    lra                                                                        \
-    mc                                                                         \
-    per                                                                        \
-    precise-smc-softmmu                                                        \
-    sckc                                                                       \
-    ssm-early                                                                  \
-    stosm-early                                                                \
-    stpq                                                                       \
-    unaligned-lowcore
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-softmmu.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-softmmu.o
-ASM_TESTS += $(PGM_SPECIFICATION_TESTS)
-
-$(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
-$(ASM_TESTS): $(LINK_SCRIPT)
-TESTS += $(ASM_TESTS)
-
-MULTIARCH_TESTS += mvc-smc
-S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
-$(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): CFLAGS += $(MINILIB_INC) \
-			      -I$(SRC_PATH)/roms/SLOF/lib/libc/include/
-memory: CFLAGS += -DCHECK_UNALIGNED=0
-
-# s390x clears the BSS section so we need to account for that
-run-plugin-memory-with-libmem.so: 		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py \
-		--bss-cleared $@.out
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
deleted file mode 100644
index 0ca030ded01..00000000000
--- a/tests/tcg/s390x/Makefile.target
+++ /dev/null
@@ -1,127 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-CFLAGS+=-march=zEC12 -m64
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=z14, CROSS_CC_HAS_Z14); \
-	    $(call cc-option,-march=z15, CROSS_CC_HAS_Z15)) 3> config-cc.mak
--include config-cc.mak
-
-TESTS+=hello-s390x
-TESTS+=csst
-TESTS+=ipm
-TESTS+=exrl-trt
-TESTS+=exrl-trtr
-TESTS+=pack
-TESTS+=mie3-compl
-TESTS+=mie3-mvcrl
-TESTS+=mie3-sel
-TESTS+=mvo
-TESTS+=mvc
-TESTS+=shift
-TESTS+=trap
-TESTS+=signals-s390x
-TESTS+=branch-relative-long
-TESTS+=noexec
-TESTS+=div
-TESTS+=clst
-TESTS+=long-double
-TESTS+=cdsg
-TESTS+=chrl
-TESTS+=rxsbg
-TESTS+=ex-relative-long
-TESTS+=ex-branch
-TESTS+=mxdb
-TESTS+=epsw
-TESTS+=larl
-TESTS+=mdeb
-TESTS+=cgebra
-TESTS+=clgebr
-TESTS+=clc
-TESTS+=laalg
-TESTS+=add-logical-with-carry
-TESTS+=lae
-TESTS+=cvd
-TESTS+=cvb
-TESTS+=ts
-TESTS+=ex-smc
-TESTS+=divide-to-integer
-
-cdsg: CFLAGS+=-pthread
-cdsg: LDFLAGS+=-pthread
-
-# The following tests contain inline assembly that requires inlining,
-# and thus cannot be built with -O0.
-rxsbg: CFLAGS+=-O2
-divide-to-integer: CFLAGS+=-O2
-
-cgebra: LDFLAGS+=-lm
-clgebr: LDFLAGS+=-lm
-divide-to-integer: LDFLAGS+=-lm
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
-TESTS += $(PGM_SPECIFICATION_TESTS)
-
-Z13_TESTS=vistr
-Z13_TESTS+=lcbb
-Z13_TESTS+=locfhr
-Z13_TESTS+=vcksm
-Z13_TESTS+=vstl
-Z13_TESTS+=vrep
-Z13_TESTS+=precise-smc-user
-$(Z13_TESTS): CFLAGS+=-march=z13 -O2
-TESTS+=$(Z13_TESTS)
-
-ifneq ($(CROSS_CC_HAS_Z14),)
-Z14_TESTS=fma vfminmax
-fma: float.h
-fma: LDFLAGS+=-lm
-vfminmax: LDFLAGS+=-lm
-vfminmax: float.h
-$(Z14_TESTS): CFLAGS+=-march=z14 -O2
-TESTS+=$(Z14_TESTS)
-endif
-
-ifneq ($(CROSS_CC_HAS_Z15),)
-Z15_TESTS=vxeh2_vs
-Z15_TESTS+=vxeh2_vcvt
-Z15_TESTS+=vxeh2_vlstr
-Z15_TESTS+=vxeh2_vstrs
-$(Z15_TESTS): CFLAGS+=-march=z15 -O2
-TESTS+=$(Z15_TESTS)
-endif
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-signals-s390x: signals-s390x
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
-	mixing signals and debugging)
-
-hello-s390x-asm: CFLAGS+=-nostdlib
-
-run-gdbstub-svc: hello-s390x-asm
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
-	single-stepping svc)
-
-EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
-endif
-
-# MVX versions of sha512
-sha512-mvx: CFLAGS=-march=z13 -mvx -O3
-sha512-mvx: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS+=sha512-mvx
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
deleted file mode 100644
index b7a8737be0f..00000000000
--- a/tests/tcg/sh4/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SuperH specific tweaks
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/sh4
-
-test-macl: CFLAGS += -O -g
-TESTS += test-macl
-
-test-macw: CFLAGS += -O -g
-TESTS += test-macw
-
-test-addv: CFLAGS += -O -g
-TESTS += test-addv
-
-test-subv: CFLAGS += -O -g
-TESTS += test-subv
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
deleted file mode 100644
index 258aeb40ae8..00000000000
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ /dev/null
@@ -1,53 +0,0 @@
-TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
-ASM_TESTS_PATH = $(TESTS_PATH)/asm
-C_TESTS_PATH = $(TESTS_PATH)/c
-
-LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
-ASFLAGS = -mtc162
-CFLAGS = -mtc162 -c -I$(TESTS_PATH)
-
-TESTS += test_abs.asm.tst
-TESTS += test_bmerge.asm.tst
-TESTS += test_clz.asm.tst
-TESTS += test_crcn.asm.tst
-TESTS += test_dextr.asm.tst
-TESTS += test_dvstep.asm.tst
-TESTS += test_fadd.asm.tst
-TESTS += test_fmul.asm.tst
-TESTS += test_ftohp.asm.tst
-TESTS += test_ftoi.asm.tst
-TESTS += test_ftou.asm.tst
-TESTS += test_hptof.asm.tst
-TESTS += test_imask.asm.tst
-TESTS += test_insert.asm.tst
-TESTS += test_ld_bu.asm.tst
-TESTS += test_ld_h.asm.tst
-TESTS += test_madd.asm.tst
-TESTS += test_msub.asm.tst
-TESTS += test_muls.asm.tst
-
-TESTS += test_boot_to_main.c.tst
-TESTS += test_context_save_areas.c.tst
-
-QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
-
-%.pS: $(ASM_TESTS_PATH)/%.S
-	$(CC) -E -o $@ $<
-
-%.o: %.pS
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.asm.tst: %.o
-	$(LD) $(LDFLAGS) $< -o $@
-
-crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.o: $(C_TESTS_PATH)/%.c
-	$(CC) $(CFLAGS) -o $@ $<
-
-%.c.tst: %.o crt0-tc2x.o
-	$(LD) $(LDFLAGS) -o $@ $^
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
deleted file mode 100644
index 4e65f58b570..00000000000
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ /dev/null
@@ -1,44 +0,0 @@
-#
-# x86_64 system tests
-#
-
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
-
-VPATH+=$(X64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(X64_SYSTEM_SRC)
-LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-# Running
-QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
-
-ifeq ($(CONFIG_PLUGIN),y)
-run-plugin-patch-target-with-libpatch.so:		\
-	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
-run-plugin-patch-target-with-libpatch.so:		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
-run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
-EXTRA_RUNS_WITH_PLUGIN+=run-plugin-patch-target-with-libpatch.so
-endif
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
deleted file mode 100644
index be20fc64e88..00000000000
--- a/tests/tcg/x86_64/Makefile.target
+++ /dev/null
@@ -1,40 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# x86_64 tests - included from tests/tcg/Makefile.target
-#
-# Currently we only build test-x86_64 and test-i386-ssse3 from
-# $(SRC_PATH)/tests/tcg/i386/
-#
-
-include $(SRC_PATH)/tests/tcg/i386/Makefile.target
-
-X86_64_TESTS += test-2413
-
-ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
-X86_64_TESTS += vsyscall
-X86_64_TESTS += noexec
-X86_64_TESTS += cmpxchg
-X86_64_TESTS += adox
-X86_64_TESTS += test-1648
-X86_64_TESTS += test-2175
-X86_64_TESTS += cross-modifying-code
-X86_64_TESTS += fma
-TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
-else
-TESTS=$(MULTIARCH_TESTS)
-endif
-
-adox: CFLAGS=-O2
-
-run-test-i386-ssse3: QEMU_OPTS += -cpu max
-run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
-
-cross-modifying-code: CFLAGS+=-pthread
-cross-modifying-code: LDFLAGS+=-pthread
-
-test-x86_64: LDFLAGS+=-lm -lc
-test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
-
-%: $(SRC_PATH)/tests/tcg/x86_64/%.c
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
deleted file mode 100644
index a29571b367c..00000000000
--- a/tests/tcg/xtensa/Makefile.softmmu-target
+++ /dev/null
@@ -1,46 +0,0 @@
-#
-# Xtensa system tests
-#
-
-CORE=dc232b
-ifneq ($(shell $(QEMU) -cpu help | grep -w $(CORE)),)
-
-XTENSA_SRC = $(SRC_PATH)/tests/tcg/xtensa
-XTENSA_ALL = $(filter-out $(XTENSA_SRC)/linker.ld.S,$(wildcard $(XTENSA_SRC)/*.S))
-XTENSA_TESTS = $(patsubst $(XTENSA_SRC)/%.S, %, $(XTENSA_ALL))
-# Filter out common blobs and broken tests
-XTENSA_BROKEN_TESTS  = crt vectors
-XTENSA_USABLE_TESTS = $(filter-out $(XTENSA_BROKEN_TESTS), $(XTENSA_TESTS))
-
-# add to the list of tests
-TESTS += $(XTENSA_USABLE_TESTS)
-VPATH += $(XTENSA_SRC)
-
-QEMU_OPTS+=-M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
-
-INCLUDE_DIRS = $(SRC_PATH)/target/xtensa/core-$(CORE)
-XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
-
-vectors_ASFLAGS = -mtext-section-literals
-ASFLAGS = -Wa,--no-absolute-literals
-LDFLAGS = -Tlinker.ld -nostartfiles -nostdlib
-
-CRT        = crt.o vectors.o
-CLEANFILES += linker.ld
-
-linker.ld: linker.ld.S
-	$(CC) $(XTENSA_INC) -E -P $< -o $@
-
-$(XTENSA_USABLE_TESTS): linker.ld macros.inc $(CRT) Makefile.softmmu-target
-
-# special rule for common blobs
-%.o: %.S
-	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-%: %.S
-	$(CC) $(XTENSA_INC) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
-
-endif
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
deleted file mode 100644
index 95d0528c372..00000000000
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Xtensa system tests
-#
-
-include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.47.3


