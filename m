Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D38EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1U-0004xj-Rr; Fri, 10 Jul 2026 17:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1T-0004xU-Rg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1S-0003T2-8M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3c8s1846374
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S3g6qndOAR0zUmUUtuicgxyrcvWecaZXoJqtMTpXsAo=; b=X8SUJS4RQBJ+TK9g
 GLPXiEyD86GUyITpPZIF9MWzw5hvjpkX5RvvL3EOETBG5bqoDWBW8Bq+XL9lZ+D+
 BebtPqR1PqBoLG7VP5IoHVL20X7Iz7MOrSGtg8F4RYktPY6dpfgjfja567koYm8j
 +mf5nQ9bEww3FaPrbwSRAEmlNNAAdo3q5499s8n68pIPPUTJ0+NtqW3ZfFPkkVqG
 L+yl3pE28g2wRMEROfzH7dJF7r8K3YDHKGtxFkDLBp26eSEy/VVz5yt8R5ZDeYoa
 tVjXHppxTOWPCrc+uuu1JXMCCj2ov9PYvr5wdJXXSy15PmtrKkGXosJCmbdRPVEA
 aXL9EQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rj90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84885a4fcabso536138b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719866; x=1784324666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S3g6qndOAR0zUmUUtuicgxyrcvWecaZXoJqtMTpXsAo=;
 b=EZI9HYazzuLpFX7a0OlEdlLWb0nyc9tE1HagperJ/hXyuKdC3dYHuCJwXdVXIKC5SF
 62YA12BTkMxNEvKIPOPSKQzYjrraAddoEVcBE+tsr+zBZ5NAnFt2YI+qB+W49xOOI55Q
 QffsaiOwb105wWh7UygZhcsjhJWdTG79xFxTJFZDIYk7ap76VOEXqN87yLX4ouMtjO9S
 B0IWpzHq8tAnP2/Cip103pmoiigAPehkhmr2Nhlr7ZNQorkeaFdthNstp6LQWGEXSCSK
 6jbVVUrmLFXrEoUY8BJDdhp0a2ik/l02paMyjg3hZCbvNZzMw+RQwCSwEzz6jZla2NK6
 W2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719866; x=1784324666;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S3g6qndOAR0zUmUUtuicgxyrcvWecaZXoJqtMTpXsAo=;
 b=AHZlvZWPKc/mf7N0rmfINe4OiqLXfShbbNeSXE6Ln5Kt/tC3nlJOz6ZEGMSmqWUwBf
 Kie6MlQ9yaJ7s+en6HMG6sO3HoLWfrMgsCfD5gYdMUnyoPaC1uiLoHwJPOE8JhvEZGKt
 AuYSNS63HQkO2ZdrvNpIHze6wtoBrY3L4ZhH8xzOzdCUnVfH2m5q8c3EKzfsOhMzNN5N
 HHdEadIf7aYQqLCYAhWP4j158Ay/v4a1T5UuorRDq7zYeQ1JUeoFyEfH+onft0qzIu7z
 er18PNV+QfXZFmxLOo7iFTKB6RyfH2CPbH0IlPId6YnFeMRl9UDE6DYAO0RMhBWpa6WM
 3mfg==
X-Gm-Message-State: AOJu0YwhOZ0Oeeznh+DcNRo+L3oMlrCKgRsCg5XHGG8YUnH5JnUzYCj8
 xxn+EIYbpU2+I5jxY7ZgGO6jmHsWJlbgWgq24mCE8USVLNJ3M/Uq7kgLuC3fiZJpF2gr55Kc5SS
 legfjkvy4TOQrFueNzm+vdzDxz19cg1MF1TDcxImFJc90tiXaFdXNx2PM4OU2X2vfnQ==
X-Gm-Gg: AfdE7cmQIfO82fkSVVUy5NbDBRMBimcVv3M+vKOsoH4WbDPNysK8rtm+n+FQZegaHeI
 g/WWU3px0hrWKADgWU25AechPxTk2I8qT61bZYp4bbzqHEPIUdfUAP+tDVae7O0Al8f6NAeVj1Y
 V7bgbtJz4eZoLlDFc81358p9zrVmBgfFc9S8PbTB3/ucq2ckfR6UdmXgRwguVUECmD6hoR4JLsY
 etqqRelCCaQ1eUYAkurxFHHkqbnBGbp7fGiumU30Q3qUVdfV/zgkuZT5G0EK8Q/GuQXAvZD9AqZ
 jmJwFD7bzVIkffh33lFMmlpT7qukzCUfjJnO5Y33TT4z9cu/mXo9IPrAVZ/VIaBbk7ycG5zc8JO
 Uygv7LYuqrw9SmMkAowmg9U0fH4dScxnZBkeQ3UHU24asDelzHo6Ux6xSrjg4gl38Lp3W6rwpb6
 ihCEj7sQ==
X-Received: by 2002:a05:6a21:4c08:b0:3bf:a11c:176e with SMTP id
 adf61e73a8af0-3c110b7879cmr688237637.57.1783719866379; 
 Fri, 10 Jul 2026 14:44:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c08:b0:3bf:a11c:176e with SMTP id
 adf61e73a8af0-3c110b7879cmr688216637.57.1783719865932; 
 Fri, 10 Jul 2026 14:44:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:25 -0700 (PDT)
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
Subject: [PATCH v5 16/98] tests/tcg/meson.build: introduce expected_output
Date: Fri, 10 Jul 2026 14:42:20 -0700
Message-ID: <20260710214343.2065491-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0cwD04MTAma_QOnElT3EfYkwitAEwo2I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX6pLucycRi9bV
 30dOm7DpHISDSxE4SZ0QxhxZwuHVSo1Q+wqa9AnuzmSVj+QiCj8yz0xzGQNazZHazzdb2WI1H92
 GUFlBrxZ61h8ooesRH1lFxz6S2jGAAZgHZoo0RZmbPyhTY/jD/P+5O3cDOJvL0e1BJ14qVKok3z
 9kYuqpDDkeIDIjHHsPhU6TFSW/eGT9FW6hOobPYwBlbmCc3yhTDIiUz+yMMRewKwV8VHoebh2+x
 z3s14KURaSCyEf0xsSZrWlp5W2kiJ6nOyCh8HFjcV+2jUJv3R5fYUOn2bVBeZjeR63jz1R+sZVr
 qo3Zd1/4KrA5dv5kiHg/I5/fevG52GNL5kPu5koUFdCCMMdU3dYXYLAUk8WnGLU08lqxCDrB98B
 Z+ovTXZaAgvYWlhP4q3MOPXmnF9FAdybeIJZoySrXZlEyjJuCLovuAhqQ1vU5XSGwCEp9gRqS7E
 Zm/UVpttptrD2EftMWg==
X-Proofpoint-GUID: 0cwD04MTAma_QOnElT3EfYkwitAEwo2I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0KWt0oQP/pPQ
 4qvSKeSy+2zR1ZeOO94wEotDdvf4prL27iWM5NJXF3cze1DH5lf+W8QNqI1xuNWS3gsn0Vxz1vo
 SO7kOcamR6EITFiqN3eQCCT/Tg/Cexc=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5167bb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=twXvQjPDpJ6hybaE9wIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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


