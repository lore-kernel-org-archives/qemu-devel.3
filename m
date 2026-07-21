Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C91C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9U4-000396-AP; Tue, 21 Jul 2026 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm9Tw-0002zC-Dj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:21:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm9Tu-0003ve-NP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:21:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARvft1252118
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rCdfC/fttUV6f/HWgpjNV1h6VJQ5cWJzdCAYU6K9+cA=; b=p7rTyuMVzfGlYVzF
 Z8TDBsDs1l7daNU4ZsuL3uBWbySkDzQM1ATSDMPI31+uRba9uQ4MBeiB4T8iIDvA
 Mify4a+MKnMyHQHIrZJKwMttmfVgca6txxLkM7AmfQebxIMIw7gsAdajY/hFCsSN
 RQiR5Jotq9H/RsskiipCraUPHZ1qukQxoBLd2LuvZNKtyfbAyZH90Y5qthR33MFY
 qFIVbnmPGQucRup+0HvpEBxNv/vh+D6mtGwUIDzjoYJWhMueZB7mkjdnhLueaiDw
 BJd61BtxZauKm7KbLl7G5gonNM3sfLyxpkkPtjG5fMpx8xenic+TLSG+zrrsMOHF
 +QDctw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvccewf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:21:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso98149171cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784636513; x=1785241313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rCdfC/fttUV6f/HWgpjNV1h6VJQ5cWJzdCAYU6K9+cA=;
 b=gDm8b9DF0O8UtubKeWoRulKymxYExypmaJi962wujLvyzSJg9xfHgaoLj8bNYqBByV
 Xb4CcEcsVQRAAAzrZUiV2MRafECvbkarml7IJssYDl19acdbY8awLrVbWvEOwZ9U6wK4
 /MNz2H9fmcSwUZV5iqvIJzVTBXEBUBKj6VStrT19QXQbw/mq7lQsddc4zo3ZgbSHmiA1
 UHGF16zt3BzuTflDIRQWHh/QltLYVv6FgdgJbcmPOoAb9tMqeZlpv+0lt16kCVfrYwze
 0gAtihp4uIPUN1+PSBZ8UommTbxB3UcO+uy9DRzqODicqA61r6eKy4eiPLt75vuxu+Aa
 yKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636513; x=1785241313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rCdfC/fttUV6f/HWgpjNV1h6VJQ5cWJzdCAYU6K9+cA=;
 b=g5qUuOB09eZZDDudbBi8KMspMSC0kx0V7EtzmLc7FraV0nQwz/cmXjf3oLr+O9O46g
 Jl8khCsiECLVzeXOiT8AllJz49wWwFqAroI0+Yz2qZV9WLsU1Dz6Sl0TlSkmTXB36mRW
 AJGwoO+RGqwazzPqQiMA3eN35KiW09+3C/ck5ZNrXQRT/x8VpIanhkup3YPStpRUyuUg
 SBWCT5futy84VZvhbjFQvMzmJUU3NhSrIfBz4+PG53tOw7dauvUEczJ45v0VGndCsFoA
 nJexXN9284i0roWKRtonUvJZKXkaybymckKWBZcG0p7c/k0j3sNffDthXMFFb+YY0L+D
 7MWA==
X-Gm-Message-State: AOJu0YwUN3tV1D3ce3fibYzdNacb04A8M1TjPwNJjmRANskhxBt8VDm9
 HLKITAIcrXiEtpIPl5JkbPUoIFdq70OKwzBok8G17hTfF6XGgZWVqJhIRW0oiYx0GEjSluejdY2
 PK6oXyoPc26LYE2c4/hvXjley9NsXt0N9G7j5zbQ9CdmrcCT37rCcEwAilpx+K+1rrg==
X-Gm-Gg: AfdE7ck3jmwEZdYIcpCds32wL629DY4TPVdcsDok1zsAI/fqMPspCERIx//kRzPWTsj
 eHwMXTwIoXY1TPrXCCq9f9avfp1VWP7qR/G2PfYOtPxt/3deLNFI8Xb1mLfi6nUIfOllza28elA
 Y1BS6sA28/7VD6bK8jdzvvaW3/Du2xp3KpzLQ3SXSZr8cWlB0IQLN5SdEiBsb1q8N0td8Quc5dM
 lW9/wDy1whO97CVT4jEQGGQ1vWXB7piJ+U0py12oV6EpvQxBDFjfhXhXWcCji6rjZMlPhl/URMm
 e4gzWImm1jhTUJs8GdbEgTnuwcqzDL0laaJL5aV6/bmyQyBM3KN52ErhExM1EthjFyDhyAIAboK
 9NUVUEAJl5Ew6qbXNP6Kjf2jyVUtXPs2N4Ka6heq5/NYRJyK/McvNVGe7gQ==
X-Received: by 2002:a05:622a:2616:b0:51c:10aa:9ba with SMTP id
 d75a77b69052e-5213e48b0d0mr161920841cf.46.1784636512756; 
 Tue, 21 Jul 2026 05:21:52 -0700 (PDT)
X-Received: by 2002:a05:622a:2616:b0:51c:10aa:9ba with SMTP id
 d75a77b69052e-5213e48b0d0mr161920411cf.46.1784636512197; 
 Tue, 21 Jul 2026 05:21:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm63597595e9.5.2026.07.21.05.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 05:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/4] target/arm: Add stub for define_gicv5_cpuif_regs()
Date: Tue, 21 Jul 2026 14:21:32 +0200
Message-ID: <20260721122135.6288-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721122135.6288-1-philmd@oss.qualcomm.com>
References: <20260721122135.6288-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMSBTYWx0ZWRfX7r6nD2RYUMRW
 v68IIvM6G7cD7WqE+CTeyJYcbv82DvcfU5To7WVZOEEiG4yiQ9XPyb3pw7cwDkixiOogTgSGfo4
 1bptIJdU+EvbwV/8OgDQ8RyBzNLPnJE=
X-Proofpoint-GUID: EyFQJHik0YVZhxzCr18ANQbKdCrt5G9J
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5f6461 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TAc-z3PBzWRmM4gypW4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: EyFQJHik0YVZhxzCr18ANQbKdCrt5G9J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMSBTYWx0ZWRfX6T0Y5owO2rbY
 +SEhx+uyjvTGvx9kw605pSXawA2BQWeVFlCGBhUvTKK4w6C/2q+iIsz0kH1oAw1fcGNR40+6qFK
 zY313gk6Ti4dVWDQxX4dR1YF4seyCDhY+1uBQ1utiyPsBRbP738txJCntjpO5PNlXSLLK+5VgF7
 ea9vXgn+zu9fp8pVJH6yDDGuVKQV7tOMDJ9pW7f7UKtBzjbyggqmsKddR6ZXXEGITm7zX1d1+wS
 nB8sEYguJqP/gDhEyP2iT5rNwrQi+mc4s4+W1ba2kC/78cBqd5IcazknK1pM/9Cjc+yAq51okYV
 6rCYWqHxJnVjIfxzXmO2KNZ+X26xtmzEk/CZmGVDbCsMP27LoQIEvYDtJBpF4tKj8PfR33aQx47
 J1l/vBDkau3iT6tlgYSrq8/P1rxEI47yHlOKL46BtfLaOetBy4+q6tJ+kYribiOAHKo0AmnRnY1
 991fPeWmvk37mijiA4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210131
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The common helper.c file calls define_gicv5_cpuif_regs() which
is only defined when TCG is built:

  $ git grep -w define_gicv5_cpuif_regs
  target/arm/internals.h:1885:void define_gicv5_cpuif_regs(ARMCPU *cpu);
  target/arm/helper.c:6334:        define_gicv5_cpuif_regs(cpu);
  target/arm/tcg/gicv5-cpuif.c:923:void define_gicv5_cpuif_regs(ARMCPU *cpu)

This fixes when building on macOS with --disable-tcg:

  Undefined symbols for architecture arm64:
    "_define_gicv5_cpuif_regs", referenced from:
        _register_cp_regs_for_features in target_arm_helper.c.o

Define the GICv5 stubs in their own compilation unit, otherwise
we get the following error:

  duplicate symbol '_raise_exception_ra' in:
    libsystem_arm.a.p/target_arm_tcg_op_helper.c.o
    libstubs_arm.a[4](target_arm_tcg-stubs.c.o)

Fixes: ee0f1ce00db ("target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/gicv5-stubs.c | 17 +++++++++++++++++
 target/arm/tcg-stubs.c   |  4 ----
 target/arm/meson.build   |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/gicv5-stubs.c

diff --git a/target/arm/gicv5-stubs.c b/target/arm/gicv5-stubs.c
new file mode 100644
index 00000000000..845626d7c6b
--- /dev/null
+++ b/target/arm/gicv5-stubs.c
@@ -0,0 +1,17 @@
+/*
+ * QEMU ARM stubs for GICv5 TCG helper functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "internals.h"
+
+void define_gicv5_cpuif_regs(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
+{
+}
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 8d97449cfc6..aeeede80661 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -43,7 +43,3 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env)
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 {
 }
-
-void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
-{
-}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4412fde065f..f6ae8934d1b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -37,6 +37,7 @@ arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_user_ss.add(files('cpu.c'))
 arm_stubs_ss.add(files(
   'cpu32-stubs.c',
+  'gicv5-stubs.c',
   'kvm-stub.c'
 ))
 arm_user_ss.add(files(
-- 
2.53.0


