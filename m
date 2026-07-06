Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337DBC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtx-0003NI-Ff; Mon, 06 Jul 2026 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtU-0002lm-27
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtS-0005cK-C2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE6C71495664
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EuOgBu/3sKn
 FG0EXIvcQ+MuZ+KyYjKgHKRfQ5+B961M=; b=JscAY3OognHS6noa2Xb+B0Sw7xy
 ET5lvVlH5ttdCsQI2osbsrKlq80NCpxdqNBV4DJ1lqttcTAIWBaKIazeb0wm/Cd7
 nidWlsfzn9wTUJmAwqBaJBP7HQxjo53E8LNNmmSVuxbHIVjRyyetLNKPm8oIN2ag
 FeIzgB9MSziws7AFHTuRA9uDrCJucup8ce5SnIXASeByI67/4syshudYlPhIUQgz
 +4YKKD1rKXzr649JVHSftEUPlUXI4v8lHYGaUhnZ9PKi3Rb++WQcy+qMs1OI7ZaU
 rChQI+ynpA+kLNHD+Ohg7m2JwecBzVg1sEr13Vt+6qx0AH6seluZhRf8SXg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bg7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so3022976a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377264; x=1783982064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EuOgBu/3sKnFG0EXIvcQ+MuZ+KyYjKgHKRfQ5+B961M=;
 b=byqraB1pt+rwVQvGj8Rbv2XHluDIYPcv3XNC+h5SRRa1zaWhUw0+9BQIbR8raQMnSl
 cFxxHS2DsupXFU31CrKnmFkbRoXIj/s6zhg7Odnaq33SN2Ljlm4SQVieA2NtdBXeD0m+
 x5FC2dsjIKmXhP+MT51EEY1lpPxU6Gn7xeollDJ+SyWYeT0iPPEon84UkuuqGNqGiCZ3
 3y0dSvgYc/HYqILFxjFMEmJE4ZHKlZm+sPUpR/YvoD/uF2oxupeDqZWCHtszPp/yYR3c
 IJKaTgvDF9g92CjjXsRM3qR2spCaNUoTIZfyJz33T9phcjXPQUWcfSkQHVVfMQSK2WyY
 rVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377264; x=1783982064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EuOgBu/3sKnFG0EXIvcQ+MuZ+KyYjKgHKRfQ5+B961M=;
 b=UAwyiZTqfoVePB3OFwa/S+erKdB6vyfFsjBCSvhWLpA4iqkX6RirOco5UzALy1kMEj
 fQtXKaV06BNLNeg8H5KxZOjBvMg0PXHV58C0PXeMokje6NsJDERWxP19BQHD8fP2Cx62
 SobbthKcF/eX/f4DReNX5py9/Pbx/bCD+xqSjx9a2O4AcgKwDiQjHjyIZJC4K38TVLzB
 WB7w01LBkQawAJNN/GGEB+knCV040QA+lVF/iYvZM39wrc1ucOYNbmpTzOPTvCTGDsit
 9Btl20kvjjZ7ishhdlLH7wvfbiS84mhwiU66xSmDcYTTMLC1csVQfbommnQ3OCJT1C36
 Refg==
X-Gm-Message-State: AOJu0Yw5BshZFuUozZpGKDAjBvtxcGcPXXzui5ldHG/w37WePBu5VZTn
 6W+anKzmQ0ilFYdnlcoiVGVGQgp9V7RiMgQPsgcBx5lKI3ArSTo4M/ZOdxgY4iAruK320B0uSUX
 1yYJg6Z5OdwwxQXeg2z1xElYN6FqllNaHNNBDafQdfTcLbLdn/MwHoopzMO/4I2X6Uw==
X-Gm-Gg: AfdE7cmrjmbsRfLn1wHYWKdmKA9eYvuQfZh1NLZ2KplzqT5ajqU9BiO2SnVE+SKb8Qj
 FNWqleM7dJdrQ9uddjK5nEOXTSi2RESLWiKGsjxgvYZmhayeVwkA+YOi4K/htakzMXN7RByWXQj
 kANl5bCv7vfpK3nK5zeYwkDycrX8c3xeRfmAqnw/gl/rSGNz9Zt4iZPA9E4lUyZx/yxrQgQ6ul4
 JILb4gaL+hCoJqpa8UiGxHOeDuPvqWXTuJ83HZp1h3IJksUH7qSkVp6ddKCer/FAYcVpGpmd1qy
 Ith6DUljw5lioNlfULgSgNtHj6VZHErTfGOqb3wgprUsI4QWZQRg241ZmoPHA6gX7b/qz3qqwFb
 NiNznHlCJpgveHTotIyKWFFnUeUMs4+xFnnUv8J4RDIttvhfNO1yiws/l6B4W/e7y+Y6nT5LzKf
 aP8VCJBw==
X-Received: by 2002:a05:6a20:d490:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c08ee6d060mr2915717637.37.1783377264356; 
 Mon, 06 Jul 2026 15:34:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:d490:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c08ee6d060mr2915680637.37.1783377263926; 
 Mon, 06 Jul 2026 15:34:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:23 -0700 (PDT)
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
Subject: [PATCH v3 20/91] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Mon,  6 Jul 2026 15:32:32 -0700
Message-ID: <20260706223343.988769-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX29z7n1VsQ8PE
 sD3QKUyr66sWsg33D5XF6ICi4utSnuX9O8iFqc1/oUn0VP38xvmD32CDDpZtIfSsyYO7JoTkCFq
 yJXWA35utbNaDBHtifAOt7HzEn8NLw0=
X-Proofpoint-GUID: fbtqhkxhg2XxCfGVN8MQuQa0UHFLYXPO
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2d71 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=lxO3YoiiJHT-ZU0r3qQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: fbtqhkxhg2XxCfGVN8MQuQa0UHFLYXPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1erCHPzwiezK
 7bxHUehkR4TjTxFR6lKgmPezOiGqzvAcZtCufOlS1e6fByJ1WwmsYOuikxGXS19YmvQb6dVXB1q
 LndRn+w/biZzFSjfCUi0W2JSGSAsSlEiWO6jrg6dhCauNJt4XHa4NNG+OoFFXeEqlE74iiq+iFJ
 zZGi2QVBpqvs+dGw2XeJu2LnSHPoujdPG2bNz6KJM7RulgSSYa0VUS6GXWRwdWzN9rUVkNNc+tU
 Thw4NGpum8XE6N56h+Poy0wjbXMuOKS4lB/znRTRxNiTI5FFUs1/u8ZTejUQSM4cyPOiABkYAOx
 Im/Nwhtbwd4rDiDmIlKiluqIElZfiZLfFMm9BRINPVNpS6gdj6xpBXcRr1CoOnas+au+21a9fwt
 aUSxTTCkKxqOJqn1UnIPhU9RTQ5rUgy/ywOvHXkgMLFnDGA3KN6XtK8Z2/XiTiz2/JuKf0NIzE3
 4DkMxbevfVwv/I60JvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e610ce30f40..679a69054e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
new file mode 100755
index 00000000000..d942082ad86
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,25 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 3 ]; then
+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
+    exit 1
+fi
+check_cmd="$1"; shift
+check_cmd_args=""
+while [[ "$1" == "-"* ]]; do
+    check_cmd_args="$check_cmd_args $1"
+    shift
+done
+
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $check_cmd_args $tmp/output $tmp/plugin
-- 
2.47.3


