Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D0C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UP-0004iW-Hk; Thu, 23 Jul 2026 20:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UM-0004hX-7Q
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UK-00065F-Cx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeWGe1237289
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1yF1HZu2RxA
 z00Hbv58/KOfLT4/PgEXjUJidYIaoYto=; b=MHOKByyLWvEQXsfsbohqPM6XWky
 Q0E0OUbzgR7jQFv9rbLtpew8aU4FpVm0+l1IMRUg0VQfVQQRi5fYiHDX+tsYFY/5
 yMIzlQj1KLG5bUo3hdnV0Deii9LXvXV5F14kcKP32AhRtUI2TVicFHYgapD2HF9O
 mL7coHaxcaR8KwG3bUt2Ob6N6cNyQLNw9K0rnuob3qGigBjconRbgHsYCPwZZ0ZZ
 emTgKPRbbSyFrIOiuA+7RhooMaCkYBK+XsClzTKCW2lP+g+STSaMdbig17iInjVV
 FlJjsypqlZdO/SSGaF7FviAKg2zKal8rWJJ5c+pC0pykT23Xb764ssFz8sw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so22879245ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851802; x=1785456602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1yF1HZu2RxAz00Hbv58/KOfLT4/PgEXjUJidYIaoYto=;
 b=RVbo8J/vFy/7b/pfPUu6IwF2VDivM1fpd+42yhtLGeIMQEbDszKlwiOc3UzqcFhn/v
 fwGctX+xkYerrl1me534YWt7P73dD8eyQJppJhkEA3epUu+mcXFA+vNzM4UX0W8pxBVn
 ktsFCiGu2P18UTZIOfu7DYoCmOcjVYTiA0PobYGZgHQ2w5aV83JFH8Yii2tuX1cZBSis
 BoRbSxBXfZFogN+5doxbSa5Vwf21RDxT4X6nRvIjnjKBNDlGNM5pc2AN2F7Mq4S4KC4L
 GHaiduG6TALTGWcCV5PhmrHnWJkjmJnqNTY/p6NxEH0kFYD5KXizunUDUwOxBC0cqJtw
 3TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851802; x=1785456602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1yF1HZu2RxAz00Hbv58/KOfLT4/PgEXjUJidYIaoYto=;
 b=tBcIz4UENdHEcADsOMw4FRGDb+7SItZSb3ufUNr6f+PwI+V/AJvTfYjtHKdSDdEZJ8
 qmzEk7B8EOWyyecQ4I6CXs7DD8uTCSeC68X4EsmENqXrmzWV4PQZ08vXHclqICdJ6S/8
 HmghbVrTxQQH3v+MExpID1MCuqyg6wTAinx/qLRFxo5xwwA2teRzcdRSTiXEIVwACcnq
 VW8ieIfT/ekekQZtMXFZeqieUuAV5uij5Iq5vieZ5UXhVyrCfL5zq6HMG0cIOgy+a0eW
 y+dg1QLZPu/BiWO8n0ERsilJMZ3SE4kfz+G/CfOph458NY49ZFeQnisgyaznnamvSvba
 N5WQ==
X-Gm-Message-State: AOJu0YxgZdbxpyXtAgzPnG7hcn5FcKskKwEfewxVhMCNzhpMLLW6jkBB
 DH8ZceEeqQkyjaz0BiLQ9J8rqX++vI0tnGpn46hG8Tb4ToHFZlBDXRAGhFqqB1H7AXisALwOD/P
 1PzC9M1LbaKWV1DJFMIuswlFCpLn4Wh+nZMwZv1POOPIICGZTpoSt8Vr4WEg6NDZ+5w==
X-Gm-Gg: AR+sD10o4qdDvjxfU+bVrxVNM8HUsvwQK88Z5pPJHGiomJ7Yr2pg1JdvXSDuZX6xyMc
 58QS8O770JxwvohtDjP+ilN0AiqXFhxRorFvkh+5YyLUitmKrUNvM956Gg1pnN0LmVSQVWe7KOz
 R8iqUahL5o4ShdtE+uCRPEUgYPFN76ONRLfuEugbUe9fj/wwKv+mkRv29r6rUXY7o1gjvzZKQj/
 KWYDbFTsEFBD+kpBKgq8rpOG4HsNLoG3epVKnuIVkUjzKab/Dt7DNaWCdSpZ6YKoZyB0DL3SId4
 NOg7jKwE7+vYLvuh3tqTH5+tDBycJkmMFbNHgCrJwgL4s6ygW6z9Xu2jZfIRuB/musb75ud+9cY
 E7rhNamXL5FKRFDNF801qNWh1m7ijq8h7OTqiySbfULfZm5JSWKB9Xy2oiLlKvQY9m97iXuY=
X-Received: by 2002:a17:903:2acb:b0:2c9:cb1b:64d6 with SMTP id
 d9443c01a7336-2cfa6bbfb56mr63368005ad.19.1784851802324; 
 Thu, 23 Jul 2026 17:10:02 -0700 (PDT)
X-Received: by 2002:a17:903:2acb:b0:2c9:cb1b:64d6 with SMTP id
 d9443c01a7336-2cfa6bbfb56mr63367775ad.19.1784851801872; 
 Thu, 23 Jul 2026 17:10:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 05/27] target-info: add target_config_multiprocess
Date: Fri, 24 Jul 2026 00:09:25 +0000
Message-ID: <20260724000948.234657-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXwXoKrMiRl7rV
 zkHD/u+QSsDtBVxEJT4v+m3Tu8eH0aweDIsUA3PiL0hYN2/oVISyc+ODflbFbpkz59MeryEcjOL
 LdUAKvNhzAfrXD8XP/hGK+gC1IhVXCI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX3gAZQFYqXViY
 Byo0lWByrwspHdp2RowWleenbcP/x9p8CtSAqmokuDN3FhN6AEiJdmCXw9WTn3zXkbOvWuXyMMu
 fhk+Ho4/OhmSD7NMgu+WeUhak8LdH2KIRtpWoG6DEOcajQFFFxzVeORu7g/073v8uQBUSMQipgA
 uG+zRVaSSlIa3Paaz2upLBLowCoER5bzbk1jecBA8uJuvd81muIv95ZXA70ohLkROa6vX0Wmv2B
 mI/fADFA7XUOTXUSxc0cAZ0nF3md02mHHhlcwH6p1y4E+S+RUitNfuJoz7SWyCpX0HRAoMcMdeu
 kmVCP7A+1/6aJHQa+GvFc8LjxyeBjwlu1Rbb2zG+UBEYJMmS7A4hVVpu7sZnuup6fzxcXelqhJm
 qP52m7Vb1mcF9oJVBjgtLmz53VoteCbYSyezpMe9uqlrr0aTN9VtPkDeWRlhjMRxNsKHf28SPA7
 73n2V4v8/w4UReeXEcw==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad5b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jw_St5dA-TTCRLJR15QA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Yko8gOo66BrjNST88GSOGnVstM2ddOG2
X-Proofpoint-ORIG-GUID: Yko8gOo66BrjNST88GSOGnVstM2ddOG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

For some devices/machines, we'll need to access target configuration,
but without relying to target headers. Thus, we'll add the needed
information in target-info.

At this moment, we duplicate code between all configs/targets/*.c and
target-info-stub.c but we will clean up this before the end of this
series.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 11 +++++++++++
 configs/targets/arm-softmmu.c     | 11 +++++++++++
 configs/targets/riscv32-softmmu.c | 11 +++++++++++
 configs/targets/riscv64-softmmu.c | 11 +++++++++++
 include/qemu/target-info-impl.h   |  3 +++
 include/qemu/target-info.h        |  7 +++++++
 meson.build                       |  2 +-
 target-info-stub.c                | 12 ++++++++++++
 target-info.c                     |  5 +++++
 9 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 75d95b0e743..af65da80d04 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -12,6 +12,9 @@
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES
+#endif
 
 static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
@@ -22,6 +25,14 @@ static const TargetInfo target_info_aarch64_system = {
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+
+#ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_MULTIPROCESS
+    .config_multiprocess = true,
+# else
+    .config_multiprocess = false,
+# endif
+#endif
 };
 
 target_info_init(target_info_aarch64_system)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 73546fa5737..501956403cc 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -12,6 +12,9 @@
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES
+#endif
 
 static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
@@ -22,6 +25,14 @@ static const TargetInfo target_info_arm_system = {
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
+
+#ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_MULTIPROCESS
+    .config_multiprocess = true,
+# else
+    .config_multiprocess = false,
+# endif
+#endif
 };
 
 target_info_init(target_info_arm_system)
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 752c813077e..69053f3945e 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -12,6 +12,9 @@
 #include "hw/riscv/machines-qom.h"
 #include "target/riscv/cpu-qom.h"
 #include "target/riscv/cpu-param.h"
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES
+#endif
 
 static const TargetInfo target_info_riscv32_system = {
     .target_name = "riscv32",
@@ -21,6 +24,14 @@ static const TargetInfo target_info_riscv32_system = {
     .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
+
+#ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_MULTIPROCESS
+    .config_multiprocess = true,
+# else
+    .config_multiprocess = false,
+# endif
+#endif
 };
 
 target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index 5150f0fe9d9..cd0fb555986 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -12,6 +12,9 @@
 #include "hw/riscv/machines-qom.h"
 #include "target/riscv/cpu-qom.h"
 #include "target/riscv/cpu-param.h"
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES
+#endif
 
 static const TargetInfo target_info_riscv64_system = {
     .target_name = "riscv64",
@@ -21,6 +24,14 @@ static const TargetInfo target_info_riscv64_system = {
     .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
+
+#ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_MULTIPROCESS
+    .config_multiprocess = true,
+# else
+    .config_multiprocess = false,
+# endif
+#endif
 };
 
 target_info_init(target_info_riscv64_system)
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c917d546eab..0496eeac046 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -32,6 +32,9 @@ typedef struct TargetInfo {
     unsigned page_bits_init;
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
+
+    /* CONFIG_MULTIPROCESS */
+    bool config_multiprocess;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 88ccef2a988..996780150a0 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -120,4 +120,11 @@ bool target_riscv32(void);
  */
 bool target_riscv64(void);
 
+/**
+ * target_config_multiprocess:
+ *
+ * Returns true if target defines CONFIG_MULTIPROCESS.
+ */
+bool target_config_multiprocess(void);
+
 #endif
diff --git a/meson.build b/meson.build
index 49a5baf5b52..2b5db0d096a 100644
--- a/meson.build
+++ b/meson.build
@@ -4259,7 +4259,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
-  ]
+            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
   link_args = emulator_link_args
 
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
diff --git a/target-info-stub.c b/target-info-stub.c
index 22b7911201c..99c1b1cd7ef 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -14,6 +14,10 @@
 #include "cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/page-vary.h"
+#ifndef CONFIG_USER_ONLY
+#include CONFIG_DEVICES
+#endif
+#include CONFIG_TARGET
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
@@ -40,6 +44,14 @@ static const TargetInfo target_info_stub = {
     .page_bits_vary = false,
     .page_bits_init = TARGET_PAGE_BITS,
 #endif
+
+#ifndef CONFIG_USER_ONLY
+# ifdef CONFIG_MULTIPROCESS
+    .config_multiprocess = true,
+# else
+    .config_multiprocess = false,
+# endif
+#endif
 };
 
 target_info_init(target_info_stub)
diff --git a/target-info.c b/target-info.c
index 7ac2260b182..07fde91b1ec 100644
--- a/target-info.c
+++ b/target-info.c
@@ -114,3 +114,8 @@ bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
 }
+
+bool target_config_multiprocess(void)
+{
+    return target_info()->config_multiprocess;
+}
-- 
2.43.0


