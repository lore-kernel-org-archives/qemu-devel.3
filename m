Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B1BC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4by-0001PJ-5E; Fri, 10 Jul 2026 02:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bc-00018Z-D6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4ba-0004dn-73
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mr8j3629893
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W2CM/Z7W6QiWnO+7R4+cjGfC35wfMZ/ZFG3Vh/B+ak4=; b=RXIaXow2QsAd0Jqv
 4Jzuc4YPb/vq4O4g0wv44LbndDuf0v3C1sa1gXquxU57EyOHr5ibEOzU37sTFqcN
 CPQvvM3mcH2YKwWlIqdhcPpoTF1omKQZKcBXwJN5MkYxpgQnolZ9lAye3K+s3I9k
 6lqWe2ni+/djSAElqzRv1DSms/Y2h2PDl1U/OA80Cguuj3md3E4sxsRQEVwdjOI9
 U0hL10NmVaEtcmqLUK/cFfCJffHKTD3YJZwxYFtxFJXeSpuraFo0qjWrv4xi4l1u
 zGmEv3AQDZ/NEmIxA3T1Q/c6ggKDCZ2K1WxAuBRI3VwNHRrAizLhKp8ecEQ07B0P
 T4HDzQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hwv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso946566a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664456; x=1784269256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W2CM/Z7W6QiWnO+7R4+cjGfC35wfMZ/ZFG3Vh/B+ak4=;
 b=ROc+07aA7Ui3QC5zHbYvh1oZpeMEqQg6QT/KdcSDJaaOu2w7K4XBxkiVClDgn0g+Lk
 E5l6FtOjYrOAbO8zxa5YTGUQugHUpCUmVaxfSTNMkLs8I5FYUPy65kJLtgBOYCzSTDpH
 AvUmgS3pMFNpQJLaHmSnSxx1dPNb1ZL0Xpuy+AitMXJtAxw8ipxDx4L7T/mm67n9iava
 2LlUfHhyZwWVxDjrKjssvMsIT/KOLjtVYK3IfcAp3v1wume7cbgUFlLt0dZpoPDREypc
 DJ+IJAiz2Xbv/7b9YUAvlzVi3eCg5NklWVK2QppkWsDMRkSOAKZg0jgpZ6geuwaEv4FB
 Ugeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664456; x=1784269256;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W2CM/Z7W6QiWnO+7R4+cjGfC35wfMZ/ZFG3Vh/B+ak4=;
 b=QbW4YTdWnpaXKv+u2h6M9gI6ofgItcCRvLTZZYPiODSy6L5Q6vr7X0IgyfKPClszgQ
 L2geuTRbdgXueiPyEZK60sD6qaHNBLOWXqKaGPUUgQjtqTwF6W+IEylnfOaX6ovOUw2t
 TbRZBZrRUbHZxLxuBmXTZXzAckLsSaG8advxuibf2JZ9+DJ98+L1YaBg5iajXeHnDSCN
 jjdKqXND9cNigvqbOs+WbfV1ZQnmkvMGn+jkrcSYHe+yu48rHegHJeORzdkjt655H6m8
 dWhsEZ3yU6pS4YQAw6NqyK4HEvQ6oc85ZlF4fZ8crqNZig7rBx3PlxHFwsfASrxKIO1p
 X+0Q==
X-Gm-Message-State: AOJu0YzNJzPxVeWNFCyCWXx+SPxd4CCcPFm72qTeuhWlijkLqpNU3xQg
 Dr/CbTnoZ9xepuy2emARazXZDDwKO89IdGuNbuvRpNAlu1vVAb6AqeZO8efj87B5BCi1efRkqtv
 sdbe3lZ2tmFfeHzRs4kdULU6Gn7zJNErqVXHHBD9RWQ8X50lXI40HckFftVegCkdO8w==
X-Gm-Gg: AfdE7cm1ZdZP/oWldKP4XPmHN3L5e3OmOBZwWBwtpA1i0AlyVv1VB3x+bN/zdRtJJfG
 mRcHMa5XQ0HdjFkMn3veG0VuALvBiZufb0Rki+pNbQh0QRrLIQRW3lRy7opwCWXjqEdX02FOtB9
 84bcFYEDU8PEeN1nfzySQj3lnBwB2jvsRitIV/N0soKeotB9w4rx7fY3K6Vvbi2/j5cWznnBVfx
 HYxDFx25u3XBavj/H9ZQ5VoNEC5Y31Mm/CvMTtaVcCCis9MdOo1BTSfgnUo6dz6Wp2MWk2IHKtz
 qY7h6y77hQLJB1FqeXxYiGVGPvPIGjPmf4e/AYqsobVtnNYaR8DsQ+AsdC1IZA/OmRiweKsqlCE
 SwUy3wwsfMFZaA0JFdMz8hC/HlQ3gwNSSs8S3X35gq6qjunSAb9/TLSaLhWaWa1lD3Yw7XalRyu
 I9MNpxjg==
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c1a:8941 with SMTP id
 adf61e73a8af0-3c0bcd20057mr11481932637.73.1783664455953; 
 Thu, 09 Jul 2026 23:20:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c1a:8941 with SMTP id
 adf61e73a8af0-3c0bcd20057mr11481895637.73.1783664455464; 
 Thu, 09 Jul 2026 23:20:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:55 -0700 (PDT)
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
Subject: [PATCH v4 16/97] tests/tcg/meson.build: introduce expected_output
Date: Thu,  9 Jul 2026 23:18:54 -0700
Message-ID: <20260710062016.1818125-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t5S8G0N4kpXfgHVhkLbLfOpYSKxifkKX
X-Proofpoint-ORIG-GUID: t5S8G0N4kpXfgHVhkLbLfOpYSKxifkKX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0X/A+KPAAjvI
 wTmynzqH+KXAud47nJcaWKRnRMCkoaiKveGfpiyExkQIOTXPlC90dL8HiX7xSqQuLiXFQjixVwL
 FoRa6ypNrUgvJhdLCb0eRo0CMkUG690=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a508f48 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=twXvQjPDpJ6hybaE9wIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0I0lkTPreseP
 S3pWzrYLn3CFleOfsj1WHsIfus84ul34MP5TMQJ3bcBkk1O+gfNSUHdsBGU5tCkZ0Klpiwd1d3r
 VjklrYb8IDfhZBRp3kdQxZkfy7thNhONFTzLh5HdAV9KeEzyFDJlDoXHzrycqvM5Uyl7rg2l35U
 1zNpBNLwtHbM6nMnH+z1vN/kdNz9yWdLd+GG/XmZT7+Wo+jybRk5BD8ZCDr7IvVwwyVbNXInou6
 7O8+ab8gpWqweP0RpigEmmKlOvy2J5ZoL5VmUaJYcMYWyD2Lro5Su5tKqWk4IBmbcuZ/qnRKVsX
 l8jRygCuYnLaUtbyPl1lr//5MSZ1Elfwgo1Hg83CPKq2IO3u6Uv3V4TYkmVd8ABFcdD683B7Z2q
 G3UVI7tgJmPle5s64bTpwhXvdHpLD4MQhQfQcf+TqC+wk1aTRDo1bMYMWi62IiQR3wmNtV69oZt
 k2Z4hvDnZNGcJKuX47A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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
index 9845c59f108..4965cc282ab 100644
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


