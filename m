Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3CCC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bs-0001Ij-Ta; Fri, 10 Jul 2026 02:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bi-00019e-IA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bg-0004fM-Nr
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nU983848885
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gcifHDk3aDRmenyGLnwjR8jSCXikZwBp2RKlA+ecjIs=; b=c6WcBY2rt/EHcbCJ
 YmWxCuH82JXRuf7Gi4Z9LwRisTEoAPgUIlN97zgeXPEgL2uEjyMbAe32VYjRGXoc
 y8d+bAUy47y0OfxW/yuvNtoT5YHOs2KXR/Ul2uyS69L9JLjj4ndMIJQ+Wbbz8PvK
 p+IPkGL1WOdvJ+ZWX9ujhcrsuclXcAdSbcQqVWdjBmQ+0VcvzPhA3JNP7uPEzlvy
 WWyimquvIH7sQfLs9Mhu4BNwFOeq+WBsHd/5u6qi611vM1gsbKi833wyf6zt0rDa
 3iRyIBq6ExakHh9isAhQ/UqEZU+pAcBa5rYkAM36BNK5ZGLiR6ZGVHgAhtFl5Tp0
 jXHmEA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu29p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so1085452a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664463; x=1784269263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gcifHDk3aDRmenyGLnwjR8jSCXikZwBp2RKlA+ecjIs=;
 b=PNEHH+mEmq1XybUc8xyJYjJGozeJch6sw7/YHgIxn1NLtEjUVqFc3s1uS4GoRnVJ5Q
 bzt30EbN8A5WFfFOJhWUU/dLDLxtuMvAP7Bqqk7KKAQW1SSte/+ziDl8HPkHDnOgP1Lr
 fMel/yhZC/8fuNJtUXbOcAyvpRKqT/aDEcEJnRDA4BOH/RwqMBvqKN4dHCShPsyrjDxx
 yQ8+VRgtohZKPyJdiIufOEW5cjjGHP1UHN3rShA5utw0k+HJRtw9e2uwgIzErUXsnfc/
 p78XJdjywAGHoqepMsR6G0uG7l2yCxnrEb1CKxJ+GmW6RlrjZKlxAgap9PaH6S6iH0LY
 Ug7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664463; x=1784269263;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gcifHDk3aDRmenyGLnwjR8jSCXikZwBp2RKlA+ecjIs=;
 b=aOkp8TZVDpe8CI5DfOYLLwAgw75cRYSTHSW5ZOSPd0k3cKVLIEiaHBZ2m9HbT96ikV
 FVV+KGJWG/bm6njuvQiwPvu+90kCjQhrxZgUP0UByoUh+os8jfTesd+eUIuW9ZDCePg2
 SYNMkfdA/S4KHamGnHY+5v+1ToZnzEhNtjsYqx5TLfyWt5bgXvD/rhNswk5ozXr9BoyZ
 GmSYLZ3R3bDqQd9Wt8Vfhjn1QlA17pZHvkSpkok60RUh5BzrUPGvm9OrFhEJWQrVylWo
 YANvVCPAGbQOGbVMeFo64IgrHFIx5Hl2xYssRSKP+HCOrFWPsW+OA0HfG1clD6mX0WKm
 2xTA==
X-Gm-Message-State: AOJu0YzXXpfcgWxUbstnTTBT/xpNv7qgVa2B2dCkZ2Sy4BirTyuWH4Qj
 CfRusUnw+42HA8BtL0tclHhcuZ2lSVZGqMJjhHweMFuJ1ghc1DYQzmnFPJLFX8Pm+AiRtlUeUsQ
 461067341wCf9bxV5KSxlfpTES26i77eEO4dJBRK+tClX3inIZZ4rnsw8BWQ1hWxoVA==
X-Gm-Gg: AfdE7clWJ+SHDUEFmdTx4LgYKjE5WmXNF9ONzbN+nK3iOY0mg1m10uj/Lf9aWztbYCL
 S0n8zsyDgfgiK2o5+lLis5zASZhTImKwCHM2FMKPu8+sfjx0IkT7rII9HuIfzIHUwPT2Z21CwSV
 BGRNohKpr7A+EPOORb0WH/NchU4YtIIgHIHxqp9fppnhkD4LcpuhmivykTV0EjAn2+kyWkh2MRr
 5e71znFb3Wxy6Gv1la4Bb8pbN01NQjhcUq752OR7pTop9oKOSx/uOpZxfkjr87Me/qWydRiQHwB
 /qPmZDqixvhownAW7yzF9j/v9ncWKn4bqkGjWInsPM9v6ga2eEwF5hdJTFdJuuESpTVqqs5OPml
 yasp6xBIiBLt64edFF688skdQhVTCQjqNAolcWr1lIYk7nCnh3BRXc/SVaDatUpCF20aONdTed2
 jq4V0QRg==
X-Received: by 2002:a05:6a20:5482:b0:3b3:be1f:c89b with SMTP id
 adf61e73a8af0-3c0bcff89edmr12134819637.22.1783664462799; 
 Thu, 09 Jul 2026 23:21:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:5482:b0:3b3:be1f:c89b with SMTP id
 adf61e73a8af0-3c0bcff89edmr12134780637.22.1783664462397; 
 Thu, 09 Jul 2026 23:21:02 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:01 -0700 (PDT)
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
Subject: [PATCH v4 20/97] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Thu,  9 Jul 2026 23:18:58 -0700
Message-ID: <20260710062016.1818125-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XK8rlTILhCt8yfUiVAdnbVsoJqzXnVS9
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508f4f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BXsEv_29ue2U9Kr6R5IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX1VCFJL6FA5YO
 +fog+CYTCuZAVKKwCQVpYtO9s2GVYT9sSzdkY3QYIJ2bB+3P+ZVMoa6q9riXzzsgTwNARHTIc7J
 USKevMTWW8GI/SYUWHxFfiVU8ZwzxfY=
X-Proofpoint-ORIG-GUID: XK8rlTILhCt8yfUiVAdnbVsoJqzXnVS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX+Kx5hgOWxiIz
 kPtIyl8IfEKVcyDFQh8Xkm31A+UV19xSWVkK80bQ3pceThHku37n3onAClKQspv1xAhFxBZI0kn
 4fHLtPPEQaW3NOkvFkUv+NMULlljxNxgwb1JHhX+yu6zGvMzNjvWJjLhpV1FNpP7VqFEOaikYQx
 a2zhfd5fektUqH/i/m8d+DRW+P7Dq6oXIFKQWtA/OkIjwAliYu5VWMQ4g0un9rtpEjK4eABRjtb
 s86ygX/Frcx1nKm2oOVQ34xG0Ie80fQetKE/5yLvBZD2iQ+8yCg1vAuAi69iZhJ7rTbi7JyLAZv
 GYGSyJEi2LJm+mD7Xm7AqGK9bTV+sapHuowbDrNu2JN6bfK6m1GceOiBZoW0qC2918pFVL6zeKj
 xCbPTMHkwW3Ti78NmVEH4X1bVNsrKdQ8WacQ+u/Ol0V7TtU4f6tICgzehAJbSOvavT79ER/uA8p
 YWz/6IpBInR35Pr/kGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 92f8fe97649..6dfff7ab5e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
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


