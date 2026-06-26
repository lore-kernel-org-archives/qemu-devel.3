Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B93C43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9S-0003ZO-56; Fri, 26 Jun 2026 19:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9Q-0003Xq-DZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9O-00043N-BC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwp0i2164215
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+CV9S9WNGYc
 RNWLvEvUepwgDecUeeo2WQvt9uLyU6wE=; b=ktZo0JuCr/OWj/RBLH1bPQSe8+W
 5msLBG7YUsBhwNQviZVDWhCNz9t0SChCsK0iepGcatc4BRt5WfgAWyKNJP2WyRzs
 VNY8rM4nxCrqxM0ZaGLRBNLpZ1FCU1DVx3J04uanKuUEBdWtNe5Nk0EpE/8ZFw/p
 oXJh86LGl5Pcq8BvxloImqZhNW6//QgPUklOGSDgV9gI4G6YQZPwrgYH3b+W5OG6
 RB07FgUMbiJbeq9eqV9tCVp8QzuEsLgUFAo8i4bFiwjXZKB4EnQSDDCI6Vqdr1em
 FuGFQwkwnWQvcNzKv9AMDvwoPFbXwjWsLdJh6ZhxKE4PYhap3gvan4MZ3lA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdvkq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bccca5620so2091364eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517186; x=1783121986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CV9S9WNGYcRNWLvEvUepwgDecUeeo2WQvt9uLyU6wE=;
 b=Lhushp4478A72PnYsI4fomPN7uvf+aE0ekyvi3PdsC+qL0vj0Q8+yw+vlw+k8NV7Zr
 nMmYQvZwFXtaTK3hd6UzGm3YhHwYTF9iBf+43DDmXILWNGY627u7VwnraWz5bTnR9vL6
 F0Of4YleIBo+GzJdilj+T+7iWf7k0lsnOgukablLZGlNuQ925/kTVegTOUHeC4lDe+D7
 jR5foNM/d3MgXV7pQwYgQYsEn4h2RJPy6Dz2b4gFy/eJZKs35BmZ3BlII3QEpaMLcy1z
 oteNnz46LEl+XeqhVj0asS5uKA3bwP5Z/fi+oLrQpjqvtvWuioP4/MPFlzfoH3dasJx5
 hCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517186; x=1783121986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+CV9S9WNGYcRNWLvEvUepwgDecUeeo2WQvt9uLyU6wE=;
 b=L6M/KAEk2iNJ4LPtXziYnWDHfsKXqKdluNwYcFfb3FGIYEidJafOBDquQn922iOAkc
 vgxD53lwHLaTAScrfr5X0tZc4sh7Tyfx8s+6CD9z47mtYuY+1gtkU8D9vqC7Vcvya/XQ
 3e2JdtTNG2TYPgDmD8vQ9x3LN9xO6po3jtBq9jpBFIYDiwpga7X17AUJY39jR5kpsbLK
 4mR4ls+DiXGpbicr+PoLNnfWi0gRbC87E1P1PTun+M0RyqlUa+tU8hPyNEIexDZaa/7F
 OVZ4EC0ox23WRb+1iL57N1MeZoNpqjQMBkCAC+Uc8nncbAHAwZ9URBGS04mFjO/QSW1H
 WLGQ==
X-Gm-Message-State: AOJu0YzPHerKrofUqcVNoVLtoQXbwndSP+r/BCsv9kSeOEV6orC8TeyP
 O7k1As0wkQh9VhNR+I1QexT+5SClzs1GBCZVOGJP4KlCq2SUbTBLwomqcdnzyeyDdjSzvVpw4hy
 58t6JVmZ1YnurTeaG1Y5hZ6WtoUOVAA/chr5bQINIlhJAhMmSCN4kRkk3Bk9lPubcXg==
X-Gm-Gg: AfdE7ck1LtwSQVZydPKTrcAmHDK3LfwuSzpHJwaqzKQ8mr8PSg66qhcRkhvdeI7mZ8t
 r8NBIqMl0gWWyOPqRQjgZDPPJAEb973oYtQAScO9jXrYu3GA/n8QgGZghNLR85aaMYWKk/+vnI8
 G5zMqVQHWdjvJNcNbzg75z5ytU49+E0dGTCBcPBAova7+kL8Gc6ZPMOI8aCAhFCQlufE9wrqiGu
 VN5J9BZf8+P6A2qAqDlOx1HxEy9FFUAyDO824uOfcA65KX00qgvQWbY5XIBLX7Khw8feyV+InG7
 Fhgg4LHtr7+5p6P5m+D/c1CjA7kYY2hOFSHt5fUaSudyJ+mSJtj9Ix5/7UPl356vLDLx5SNXYul
 uQRmIzddaLtRpVtut7W1SbgoHPKrAd6zhrICyj/qYztfQLBZwmdzrjlv9scfJrEyxfCqGC55i2X
 BvbHxAcA==
X-Received: by 2002:a05:7300:3202:b0:30c:ab4d:3823 with SMTP id
 5a478bee46e88-30cab4d3cffmr2085626eec.37.1782517186241; 
 Fri, 26 Jun 2026 16:39:46 -0700 (PDT)
X-Received: by 2002:a05:7300:3202:b0:30c:ab4d:3823 with SMTP id
 5a478bee46e88-30cab4d3cffmr2085606eec.37.1782517185740; 
 Fri, 26 Jun 2026 16:39:45 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 16/37] tests/tcg/meson.build: introduce expected_output
Date: Fri, 26 Jun 2026 16:38:57 -0700
Message-ID: <20260626233918.158740-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3f0dc2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=twXvQjPDpJ6hybaE9wIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/jtSVt1k23f4
 IY07N3r+cMrL9WIlTapY5abafPdSpd+h3x8asDWG7EbdGdm7mOqnl6Jj7AM35bXeL5urT0pDM+v
 pKBJSZr1q8HZP8zmp/JR2oR5pC6gH/uCO9X59/pd2n3ku/e4AfiSGHTwOQY3hl/8ckgARHjAVyp
 C6Q/v1M8t6efDs9EBhGForWehiMh9Kh7pfGVp6pwYBsM7Mnywtjy7/fJUcvcGBOAVy3ma8GGi36
 uI/6/KJ9ovJ0EXQek1LBjIh91pGVw3kqtDSQ8Yf1g0AHcdkNmOVkwH/iHHZdi2Zfp39W73iCklq
 0VDmSQ49AN0V2CMyY91pZeAW3ZZMODw5Qtee3b3qloSmey2/Vm7quH7ELh8ofy/JrFisj25M2gx
 5qX2zTacUem8jzvx4RuhL/NllV1iZlMmizP9h7lI7SS0aPRvgHaDcsVvQX/ZlZeYi+kOh716FDD
 eIT1uJQ02OZuUUb6EMA==
X-Proofpoint-ORIG-GUID: eZ74oS5PaNYbHeqiUkJGBM4CzG80fYO8
X-Proofpoint-GUID: eZ74oS5PaNYbHeqiUkJGBM4CzG80fYO8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX4lJ7fqyEz45K
 sf0bAG1Rcb+UwYxdhtF6qWuWbEEAjTfqDkbf7JVoYs1rXM045Z+J5iVyt3UB8igd2cIu6b1YzZB
 nnJymOfmZLkDImRVjl8/vAB8xZruob8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

A test can declare it expects a specific output on stdout. In this case,
we compare it to a reference file. We implement this instead of relying
on a wrapper because we need the flexibility to resolve name of
reference file per target.

For instance, multiarch float tests expect different ref files for each
target, which is something we can't express with a test wrapper.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             | 12 ++++++++++--
 tests/tcg/scripts/run_and_diff.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 tests/tcg/scripts/run_and_diff.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ad4024f793b..f052e731de6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -24,6 +25,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
@@ -87,8 +89,9 @@ foreach target, plan: tcg_tests
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
@@ -202,6 +205,11 @@ foreach target, plan: tcg_tests
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


