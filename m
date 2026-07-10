Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F297C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4by-0001PI-0p; Fri, 10 Jul 2026 02:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bk-0001Ef-He
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bi-0004fc-Qy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mZ5S3838057
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BbEix7aYGkRUDJtuBGJPcwustJnfP6VA8z2XnXT16ZU=; b=lHQVxW3e8Ik0znkf
 Co1n+vF3YFJnUGCNyt6OliwI/B7SGE82yp6AiVP+0l7Pz/yNcOEc9Inn1iZ1U26n
 h/BpIAXP7ujeV/xmixTDtC5WHpGJmtVvWCwnAwAoZ+dykvyI+ygdEXMJ0Cg+JR7p
 ra6DCHwEiNeF8l+LCW312rPTD0d4ZZh2qj5HQ5BlWr1sG+zGY3fF9kRczD+8siYB
 oWEJnLt1ZolqXniGHLyb94bTKyJLHzdSJGDxtDyohI1nJFmj+A/lNB/mAHcy4Zsg
 Sr6z2Nhx6YFEkCxXzzgKOvzUL8IZ/cTvGEUCJ7b4WOcmz6JtVkVhO63cXxsLvRN9
 LnJDlg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe93xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so436801a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664465; x=1784269265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BbEix7aYGkRUDJtuBGJPcwustJnfP6VA8z2XnXT16ZU=;
 b=d62gFPe/W2rNjdCAfbnrpwsK5PEjCGusyRLfIruuTWYQyChtmerKwvLXBiXFu19iIB
 Nn0RzYAjUC3SutPxXcxRuMF2q+Lf72DHre3G/TThtVxJohEPt5O9TYsO8Qn9XzDQXZSy
 ATIILj6ScPVLyIskCxxKgzEvAlWfq38fu2Ap45acA5IzSr8fh2RJWK5VVSXJ/1P4uMUS
 064oU67u/UvLIx9I1Q9hdh0n6cV3vsSaqrbLHMyGY2zbOXbD5iPciGQbmdAUCCbVKQfi
 HcYgxpJ5cEFvw+aodrSx7GJTGexY2MP+DAtzEr+rypifMrfI73ImLkdhv2Zngcmuj7/9
 riOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664465; x=1784269265;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BbEix7aYGkRUDJtuBGJPcwustJnfP6VA8z2XnXT16ZU=;
 b=l0T5jQ7TuApD7AYUlwVYzr7+Ddv32AdyoAX5NTxuog8eHgZe7R90Cb4apEy+6d8nC8
 LX+8Bt5Cor6QFAs+Qy8jfEl9Hg5R5CwWQBasvUY8j4yQQUNujxpuQQgZGoXnpC6FUexm
 /Paajz5bwv1rLDpw43kNFukQvDSTvs5nl2JnNTNCvhaPzcFLWOuSdca5/u4LqMCaWqkx
 449Jy0ouTiaG6LpAklqCTmw3C3O+JfGBrruavLKo/qpChprIgx9SQ7asqpPymyZ8wHLl
 B+lNmxOVOjuUHRARdIt9UUhH6iSfWe5yYKAwiM6fXP0fd5YnAynVZNPOSsyKuuk+a1hi
 BrlQ==
X-Gm-Message-State: AOJu0Yw77A+6cqMcvGOGL5lzgsiM4Lb9fYStixbXDrfVhzcoRtH7OCvz
 2attD9Ur0BqEeh8xYQx0eDiksHjBdeR2ihn8JjV2yPyD0glMueWXIj7uf4/iSehTFQOJAfL+smv
 6kuP2V64RdmidQ3BrDlgQ7Qy8Yc4aVmCML7nO/Lu/5w+exqDsH6SUc4J5avvOUWDIYg==
X-Gm-Gg: AfdE7cmXwRGvuUDCqfMzkpcYGYqcP8gctoiUrlTJ8KB9HUaM+MpfBge2PBTOetpveBH
 6H6tsgzELtIP3KKDD7EnuqrL5x2F23Sv9T94MdUZnlv1Ll1caWKJiEySIQBISgpPicGF7T1Im1R
 fEiQ4vbLolM6LHxCQkfJDBxhkcqx69r/OBm9toDFtYZSChz2qwwPE4RpV9HOcL9UyrfQpX1FFW7
 NIkQef+laLP8c++d0fmipn8NFfcFEAM1VcLX3cPcBeNWOr12EipMTyuPupDTJ1THfR1LGk4Vfyk
 q66ABUq+WtyJ9WwLdQCfcglt8zW/o6MEU7FV+lErEnK5IrKVZT8G53wQXFot1XnVMLdnRuKyY1c
 ISL2dcupCMFRDoVJQP0HljT+KOlnD+UfyikRFYvCTcvPZq0KRJ8fmfmusFg3rpI1GaVW0+ETPg+
 a15SbHzg==
X-Received: by 2002:a05:6a21:6817:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3c0bc93aa5dmr12486196637.0.1783664464713; 
 Thu, 09 Jul 2026 23:21:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:6817:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3c0bc93aa5dmr12486151637.0.1783664464226; 
 Thu, 09 Jul 2026 23:21:04 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:03 -0700 (PDT)
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
Subject: [PATCH v4 21/97] tests/tcg/meson.build: add logic to skip tests
Date: Thu,  9 Jul 2026 23:18:59 -0700
Message-ID: <20260710062016.1818125-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a508f51 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX51ZWjYBDkTwG
 9XmSlGppBHPyxRBcjcdTSqmNCivwPZuthwMCy04so0NBMOQ90HlXJzdge6UDjWTGyWvsXQbvFMj
 EEj1gJLCJjzxbB8lt77F723EgkYeBkCc9RLEjwv43O9IZs5e76ou6YiMuhpadB9pOMUtAYRyWku
 7PRVj4nd8fZk3OuzflF9eMHRR4Nd0yHtUIdI82C2E7fcKE0sI5B0ZDhqzi/KsZubQhMSo1zkx1n
 lkiwRTt56PEm82Hx+hnM39ovgDklU6MrYIOEDR/HwjH1oNAcTrOrOFfogz2a42bTm4Z9CdykL2g
 wpP2Cxyj+x6d562VjB6vg5E15dDaO0IPxWnMZ/bOv5UXtZj5kFilRQZjSvPBDQ+NlnYMFwo5Fze
 GP0/M8hDEYIHFjbPkMSxdlhfAnyyiNPow6f1oBNbLs4f1jfQ7Qiq+CIDwDaEh+tL3m7sPW/AqIn
 wTdDiymKXQGrlwPCI6w==
X-Proofpoint-ORIG-GUID: ZNMNoG945tAMTURZcHfvRIxT4yBo46en
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3k/F33QfI+OE
 aqQtYF3E7NIO2wTZxxkGyzwf162KcWy07kICLTeRoz8lnwdJBi0vnOej1TAwyqZ7RRs3UHt6lqi
 WiodE1+jZsia0Ip24vRDDm8DUXA4wqA=
X-Proofpoint-GUID: ZNMNoG945tAMTURZcHfvRIxT4yBo46en
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 6dfff7ab5e4..05d54093709 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -114,11 +114,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -226,6 +230,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            suite: ['tcg', 'tcg-' + target])
-- 
2.47.3


