Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE37C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfD-0004bn-Bg; Tue, 28 Jul 2026 00:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf8-0004UV-Sx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf7-0001b4-2x
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aWVq1303373
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S3g6qndOAR0zUmUUtuicgxyrcvWecaZXoJqtMTpXsAo=; b=gscmOPJ0DvA/cEMd
 /mIYWypw5oCHArGNpB5ymn9M+lrrmjX5afgUITpn6B9JowcqmYa8gWgbquay+3RI
 9JIjhqN+buQz4Z6Z6eeMOSm1aGFpGFT22xA7lsjQTyxxpJ69p/B3V30NKInJ6nyY
 4NxJdXYzBiMT/xa8T9vPL6RVg/doHEl5RTgrfbtYrSH/T44mzrKuJLcYeCKiT0uz
 R15BJ6aIltmhrzvdxM2faPUk+XdhdPhN1HGPileCXWKTxj3K2W1x6VPq9NJNwNDG
 lm0CneJ1fIxacF4uA2Sqt0NNtt13HuuHW7wy8mK0bfAGKkrUfR7CJaaS/Zk5mHy2
 8fhb/Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8afqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so2425095a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213807; x=1785818607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S3g6qndOAR0zUmUUtuicgxyrcvWecaZXoJqtMTpXsAo=;
 b=LYpdun6FuXTvomCEoYFfqOXO8omJx0+1igKSrRs0AevxJpEx3Uoiv5ipeY41GzFmsK
 qqHuzFsF47A6ezq/HGGAm1IF8a3N2wxCuHbl97cq/y7iTxaIC5rO9dXAYMBTlukIEJMS
 Dyjh4/L2FnyFljwZAYABe7cjG+FH+agx5R+H6sZUVYBVvBJJ/F2Awmro3l9VykFz+9rU
 MfOGMkTPzvsBIlnLvQ8BUD9VVoMTF2GxbYc5zFSm1QbBdsXMF9m0ZDZV5PFWTnl5gwIT
 CSEmQWujM+qYm8X8kepAShOxfoo7ABuqjUci90xbNJbFWxFWhXupKpt7zfDm+bausl7K
 jnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213807; x=1785818607;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S3g6qndOAR0zUmUUtuicgxyrcvWecaZXoJqtMTpXsAo=;
 b=ApvidgwyrKYHEJWT2YFHxpfX7uKCkIM9kxRSZJYsz+O/UADi87SprFqUvhRqAhmuf5
 STLt/4MkQQOU4wDR2whnZJbGXhhsHMkpdlpJWxM9JvwbFdf3i6M3oJ/0qvk19aJSNKZ5
 3Xn3j42lS6Gtf/iGOZKfiKYLlcsFrw9gKUPxMQLIGHteUwhbULTWGfr1QJXfhHJSbv24
 r7luzFN5wDemCxK8A6ApW/t3cvGvTZnxGPxqdFUGCak7Havf6b2ikRs0vTBeoZjLs0/Q
 PT+0fhgWvYoljmAiDYCZ42xD9CSa2fafLCcSAgUat9QjgVJBiS6cOl1E1ocHbjpLKvyL
 PiKA==
X-Gm-Message-State: AOJu0Yya/+iY2QF9err4yWp8VwtyaGCnvSBHA+KHHwPoktF6zl4hQFjC
 JLzknp7RjwJ4vROmNjDzpq12gZlcELBcpopeQtOnkk0jmyA/WORa4TcFeVYs2q8WLelWMe1EaPQ
 cZFVnofynohhgVlqcp38eSGrMnSKhziBdhPn9dZCxd75Wtt2cI3HWKP9w/US1LV5GcA==
X-Gm-Gg: AR+sD108h7K/FgAlrzfMTREr2fgzovU4FYrylVpu7gwUyrzufbKSgR2DxbBTkDorSvZ
 M4Mi/Ic8gIw3AOd7LB1OfOiQwRsncD/EE3l0rNYmR/dVFZB6TP0PE5cKZpAMPMeFCwrHgfIE9AX
 zELlJRoRS35OBgDkB76BKf9qy4fYEX4aOmTytLc2VmGPjeDNjuLPavkiByeK72jjZDcoZ17aWHu
 8FftRM6AiZByFQroWz/3Npor7cjO2qQR9XNd7gl8K6HmqeRiHIApNdFegCycfqqptClJ/ccqOHk
 WDk9p9xg41dE5ixwpqJoXB5nOcwbVNGndbq4dftbU0HfmNkAWWM9Pj/thL3eMubpjgJj0VrXGMZ
 bSLfE0KdFwRZDyONLC96ObqxTKn+GfRDeugZLgOckhUnKQf1HpaTQbXszzDIUpQm8cW7UiX4=
X-Received: by 2002:a05:6a20:d81a:b0:3c3:fb32:a004 with SMTP id
 adf61e73a8af0-3c8ba4a3f39mr974653637.34.1785213807014; 
 Mon, 27 Jul 2026 21:43:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:d81a:b0:3c3:fb32:a004 with SMTP id
 adf61e73a8af0-3c8ba4a3f39mr974626637.34.1785213806597; 
 Mon, 27 Jul 2026 21:43:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:26 -0700 (PDT)
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
Subject: [PATCH v6 016/103] tests/tcg/meson.build: introduce expected_output
Date: Mon, 27 Jul 2026 21:41:20 -0700
Message-ID: <20260728044248.137626-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9XIM+v8ntbt6
 ys+KvxU2p+J5A3xjPXUI53udZQ+6rnviqIFoDY3g75/joHlkMiZFdLZnxzoVnGBCSaos/7NHHS6
 u/Bd/HeNREO9vsujuQOmaLGSpEg39yE=
X-Proofpoint-GUID: uAkvLIHxSLw3tRJjE0aR5Vr8S0pG3upc
X-Proofpoint-ORIG-GUID: uAkvLIHxSLw3tRJjE0aR5Vr8S0pG3upc
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a68336f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=twXvQjPDpJ6hybaE9wIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX7yW239XXQg2i
 ujFneRs2se3OXlHJ7zndiNWzTT3HsexqIIU4W2TBijyW8p3Da1fMAoWHDaIo9PdcvdyBfNZa+M6
 D61WjOvxm3yYEElMwmMO6LHTYvBxo6C2TRwsQ5ANIupoag5nklvEVV3pnzjskcDFhMo0CxMN6C4
 u4d2LQRwbt9kNMXeh0wLRfHkSuwMQNtNah+lCd5nXTXRt4+O9QAk6kaUvfNDpjCL2SuEMP4vc4F
 6uYtpUwLzcZdmBaVqHzn+IxlOhmH6/Sb10p8liOEyBtiBMdMQPqLs9FJbxD91E3yW2iEBLy5iki
 bRg5cI/zI0VYT9LoH9YewWrt/YrQZIlJ92QuQJBndVWKJee+RY4WTweN8Ge+Cq8BaK/4WT3AzTy
 eeW6+iKfyF2qH84zbFpmbZENBSodhv1KHRKO8SVFagh7aEdYqA44CFiV2fH4nUAgBlGJB58gitk
 oeL85kEGQ9iZ0Ea6TDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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
2.47.3


