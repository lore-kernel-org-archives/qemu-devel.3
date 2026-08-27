Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDB8C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFg-0007C4-SG; Thu, 27 Aug 2026 18:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFe-0007Bf-V4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFd-0003Gg-6J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLkVY235843
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=; b=RWiXc+ui5C9mu3nH
 O97Xq30p51skf+T3HveLOTeRshY6cZXgWREvnu5myPbKL0P1QG/Q+cI6hGTCIz+e
 DyyzTsVJHOQDwosmKmtHOpVtKg9kZ3Xwi8bMGa/QamFhsQE4FZM8r7mUbCvO6umS
 p+t2zYlGuopYUUC1EdTg/FS7XOcqcfB5tUfmr8zmyEmVocahqS0lZI8jo8IHeFTe
 KwnVIlRVCVarwoZm0K6AxNsmbXFRggmzCvW/Ggql07MeMtYYceVyu3WIoNHuKXl9
 o4oxIwFnAWiWivNtiI/17lxULWnSze6abu8vDU1hOkFF1BuF5Sxj/35MU1oHdrwQ
 b23hIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgsuk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so255263a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868431; x=1788473231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=;
 b=KC68WmEgBXK/pj+BV1u/K2xddH3UabMZyQk4RQw/i22WQu1W5aPIrFhIyrUbHcnTL7
 oyMJBQdLd3wJpSYa3UGJc0Jgo3SjqAsmrOv76lgjRCTMHYCY2nczOK5gZtwVHIngCj98
 wrkKwyF6vVl/3qsEyr0JDUpq5K6i91QD3qDnVhdvNQ35FOGwoo5aSUm5NfT32PcIYxy8
 ROBquJKaFgqxqjD0Y4LwlkVUJUKivacIkpleKKUeGwYy/wr+mMBPuXFUb3br9C3FFaAj
 TWw8zBtJPHUySB+veZ2Yk9yfIZ6EcM93x9y3+qzgD9dlIUzxs+gWE14vefEz1o4H28qT
 rNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868431; x=1788473231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=;
 b=a6ykMthZvKZCL81Nce4XkUNr00qChdG43sbzFlvSS3UV6FAn53IAHUy+ms3rgKPrs2
 MdG5JvHjTh+aQLdrbWOkZWMo4KhL0qRhLNjFZF/P16X6MJ25s5Ia3RSih959SsUD1s3s
 ZlMDaXb+umB2gIpEcI2JTlIELJVHKRR9+rKYo69+rkDGd11xgzJx1yIEXfqxHH5y+Mf4
 5lY/tQeTxNHZE77yE7NwxGc08fqkLqDD7bRzl58l/VzzE2lAwvLLeLOi3C/ABlpxIIlj
 gzCnuEWDvkUCn0AA9ut+9X+sLjeN0hp+NL864Ax13QdGUVWFial0EbEVx6TzjSx4HWce
 9wMg==
X-Gm-Message-State: AFuF++nlUcGy0wybWYAFeka1avmqhmqsQoGFMt2EEeVx6mORiRQHEGLb
 l/sLjxVTGj9rosMiShtmTG4kIGZcfH9eDKCbGz5i05LKeu2UJrO6sqUZQ+ASUxWLNyjHDLjdECq
 4KNZIP3M435wNWMiCecgvxKh6HHqhrdHGvEQVC8EkthcW2Mnska5riquUc0xh+YzBng==
X-Gm-Gg: AR+sD11tbe5IcDjfbBynP/t+LeywBjX+mjRKeQ/4DU7U4Fbw+nn05KFX1WgsLUfvQnC
 HvVZ7A4uq3aran2ImsBDg+DmPw9wwsL3CWxOazYYYmlX8NHvN/lSts1/hMUtqbCMGN7b+G0PvBE
 sVb4km+v4l7EHCG/5G7MXxluzycSzeLiHdnyfwSTZdtWy+sqq12hKYOGnintEgR/hDt4Es6sTAZ
 RC27nC5uefByEt7dRUpXWHicV02bIK/4mVFU/ai/6d3R/eT9A1qn/eL5tinOD8po5jnb5tGciNx
 LpSl3+K2U5YtShn0XYgNThW0vYQpNaNyfUK0rVjc3ZLjUAO6q4kyB/BIxSldqtXyuuo7gryiakn
 quotLWFG6kg7KXAJP7T2SlqB1jGO7WbnwlAQWjdjdPg0+6BnGLRUhRd1xV7I=
X-Received: by 2002:a05:6a00:3309:b0:835:6388:655d with SMTP id
 d2e1a72fcca58-8562ba7dae0mr4911538b3a.14.1787868431000; 
 Thu, 27 Aug 2026 15:07:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:3309:b0:835:6388:655d with SMTP id
 d2e1a72fcca58-8562ba7dae0mr4911430b3a.14.1787868430508; 
 Thu, 27 Aug 2026 15:07:10 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 016/105] tests/tcg/meson.build: introduce expected_output
Date: Thu, 27 Aug 2026 22:05:10 +0000
Message-ID: <20260827220641.84885-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P0oE3WqLJJWKk0RmwUCgKh60YufTIYkJ
X-Proofpoint-ORIG-GUID: P0oE3WqLJJWKk0RmwUCgKh60YufTIYkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX519IiL9m35XT
 1d3HorcJGNbiXtyzGSQWix6GFvDck3IUFSn6HewfGoxIH2ypfrswxSM7ifmDaoN/hvCr/GJ/olj
 esBfO70yaqgThVgzQ2vXu1p+nYe5K4F1RSDA/6u8w5eTLQz/6b5lNyda+xv/g8Hq8YgHyHU6ldh
 MFLoGxSzhyVqePY7q8QCR2owSLsdVR6GcnRknFhAftid5JuY1uOykwVF6njALNMGd51GHt71aZg
 CN+yDzlCZvkHGgfplmGd5IMiZjwGO79KHEnr3DdO6k+HwrWTUp2Rdccg9PRsfBGFE2+0S3OUYen
 IzVqL7I716Vt76kMobP01+bJDGGkZRRsFFbtbHwxa+rONl089hTfTysD6+t765Jkh9Sfl5N3qqt
 PeqKcv5L4KeEP9FtSF9mc9dCsUuqKPTMPJ6/+yzOVO+kwIeCU7Jcxhk6fraDP+FF5NVRJqAlQ/O
 CJHV0tEoYHIEfbU1yiw==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b50f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=twXvQjPDpJ6hybaE9wIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXw/y7on7pkLDC
 KEb533CFS8WzZ0ldW/JGD8yyLmPwrLm8ft2dw/y66ohi3u3KwtsaNLn/1mbQrnDZduxE/w+c/IA
 O5sBAlWY/zWy2rVDjITbZlMwU3Ra56c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

A test can declare it expects a specific output on stdout. In this case,
we compare it to a reference file. We implement this instead of relying
on a wrapper because we need the flexibility to resolve name of
reference file per target.

For instance, multiarch float tests expect different ref files for each
target, which is something we can't express with a test wrapper.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             | 12 ++++++++++--
 tests/tcg/scripts/run_and_diff.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 tests/tcg/scripts/run_and_diff.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0311b2432e4..f5fd9bee7bc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -23,6 +24,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
@@ -86,8 +88,9 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name', 'wrapper']
+        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
+                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
+                   'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -201,6 +204,11 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'expected_output' in setup
+        expected = files(folder / setup['expected_output'])
+        cmd = [prog_run_and_diff, expected, cmd]
+      endif
+
       if 'wrapper' in setup
         cmd = [setup['wrapper'], cmd]
       endif
diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/run_and_diff.sh
new file mode 100755
index 00000000000..3e51cdc9663
--- /dev/null
+++ b/tests/tcg/scripts/run_and_diff.sh
@@ -0,0 +1,15 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
+    exit 1
+fi
+expected="$1";shift
+output=$(mktemp)
+trap "rm -rf $output" EXIT
+set -x
+"$@" |& tee $output
+diff $output $expected
-- 
2.43.0


