Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D23C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9X-0003eE-Ez; Fri, 26 Jun 2026 19:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9V-0003cb-QL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9U-00044S-0R
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxhlr796799
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S80SFrLy+Z+
 Gqjf6O9QYa+bmwIIfjDs6y5sg9W6Q3ks=; b=LPzQ3AkxU3Yz/LXondidCc3kAWW
 KUKEXtDftmQc2+oyUbnOU7tVf4SYJkn/cikbIBOiuKDtBgIY/IiJ7/Rswx7LOqJi
 8KiewXKZcZO0Fhhf8Spm6RweLNDHAtU68l1uNw0kJnR1ef5MkVKBtTUFpMcjg2nd
 NoqecKQ9r/j+4VFg8BJLhN0p/oHs0WarJlDyggr4NdXD11/xmtXUoCZ/O9SWc6kR
 LiFSNUXWPYvu/L55FXxExnZMWtRFRSei5bWXL7LGW0AVS9ASXnQJPjh06gvMsuqS
 7UmzcHRVWZ0swBf16Qm2CyXxVoPLT+cCQSO//ynZhyKs+rrmv+x+yuvnjzg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ups9kkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30ca1f74cacso1163164eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517192; x=1783121992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S80SFrLy+Z+Gqjf6O9QYa+bmwIIfjDs6y5sg9W6Q3ks=;
 b=Upt0/4Swq7JK052RDkyQTHTgebHtrXy4Rlg3ayuAcwoketxpahK3esihggMC/z9qZH
 hLwD63B5p9KOlyo6nojaKJCc+XET1aUPVFiZSEWpWeYwXKQJaB3OKDf+vHDn9KhSSVPs
 STjjJ8sgoH781LNdxccdl9G+5mk7g9jlHGnbKEtGr5cHZrIKPh6ixdDG1XV5qng7fpSu
 BDi56sjicSlBCArU5lDsFsUh3gbr02ZieBMBr1eYP3RuG0tx88VjhlPB4A+s5LdH0e14
 iaMGKgajIG02tef8hDQruAR1aLGiXdYOK2wY9DTot5EEcPpgClgzYu4jjM98+eaTxFMh
 vuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517192; x=1783121992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S80SFrLy+Z+Gqjf6O9QYa+bmwIIfjDs6y5sg9W6Q3ks=;
 b=gGGqGp39gDVQP1vabDNQlXySsthxkVi8IR2KomEAM2Cc8KBxnrZhOos52OlLQKYi9Y
 EAlm9pkvodabobzM+VPz5WQ9wgPqri1f/SeYRRjJh08kb+y9jO4Rx5DoaCwsssWmwSmP
 81CUFfp5g6Yd0pjDNOfBM9+x7xG44Bjq5hmGVjzA3tvK8OYVgqKkgTjfk1jykRXwpso6
 WwqlBe29MxnbPTDMV4u0qDxxPS57bT+z2PNddJcrXFxQWimoWGVmZgOtOz+ufE0rMU7G
 zna95TrJkwpBcdNONXbj9G+vrOqLlfAikdv6UAy4YTQ6HLYAMi7nKflmj4mDdnhpiYXT
 1L4A==
X-Gm-Message-State: AOJu0YznmwxKy6oaTNML+4Ccah+2qWAW5EFqi3s7puKNB1CLHi1NVQ0I
 12GEY8T7yaMM/TsNEfwFPI+E5n1ha/2sbe6YGVlb0bjywgjxccgn7g+X0ZjFWI7EeqoJFbXCZGK
 760PrXN75MABAKFlBm4yEj5U7FHL9SQx80fyJKo5AuzsIq1Og11G2n3g/ORVofMUEXA==
X-Gm-Gg: AfdE7clBhUasOkV/2Bp07iF5WrP5WD5FTeuOOWJZ7b8N3Ca31ZJfUVbGcWxh6ZhVtDO
 fhGUfjpCIY/uEWENppGBEUBPmZyASr30uw/xvbe+T8tKZLTuBPYAmn3ORV8LpapXLODPoQPVFS1
 mj/wh/h8XtwbKb0Y4gP9fraT/ZdZypiUUZ/FR4mgrYtKA6e4O7iyOZWWgjdb9YYGypLydW6RnS+
 FyfJLGbdj2uwoy0KNdxXBuUCDXR1+8LjnXSpDj4/OLnCxUn4Y1w/7BEU/QGFQURM7tHkhncoQrA
 AqPZ4z/uTQd1sjKJuDjRkkyMbB8KtmfpjhvIkyBbVIgsNTPxPGFfDyBS3IZV6YDNKLSciR2ol2M
 0D6y1DBsF9++6/+/qJoJ8E10omkzbL10T4nZYJUGbtB0z4K+dyQM0TGSIrgIJF0jyzQlrnM23xg
 wAFYpP1w==
X-Received: by 2002:a05:7300:80ce:b0:30c:ab4f:46a2 with SMTP id
 5a478bee46e88-30cab4f490fmr2243140eec.38.1782517191728; 
 Fri, 26 Jun 2026 16:39:51 -0700 (PDT)
X-Received: by 2002:a05:7300:80ce:b0:30c:ab4f:46a2 with SMTP id
 5a478bee46e88-30cab4f490fmr2243106eec.38.1782517191233; 
 Fri, 26 Jun 2026 16:39:51 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:50 -0700 (PDT)
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
Subject: [PATCH v2 20/37] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Fri, 26 Jun 2026 16:39:01 -0700
Message-ID: <20260626233918.158740-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX33QDx8iL30Yw
 6fI2arUROxWArbWkwkisjY/wH+smZ84ph/rRZKoHPxg34quUNzxl5+aJThzZk8E8yXTWguQDK1S
 T9UigBi687+DW2cTzJlCp1kKKD218c5K5nBItCgacaSRLsYbmQwte2AxOw3VepigK84ROK4Ks+5
 50w929PsmX/QN8WI/x/+BrSqE7giEwWqlaghZcsZh8QeqCm0Aeq5DIPwMoCvHOdUhjPA6WkFWbT
 jEqhmbjJzQ5oTrRaUvl1PbmAJhbsVnCksGu47ZUxi8QR1DZ5rhcr9shrDdNHP/UhtQ2DHj/00g3
 VAkXZHI4nRMWNI1cRpKVm0LZl8D8Y/YxPtfaU+ti22lfpC5KsapyusLRfHUpYKzn0jO6IXrMwAs
 FnmbAttKymI6dH5iQS9wVduXjQHcV9zGxBSybHXSbFnJhaQBS3eas83XPL4xaSiIOwEYAP9eOKK
 OHh7hbmtRzP9Nt0ZzXQ==
X-Proofpoint-GUID: JUCCtYye3xu1GUbGjFW6irrPZq0sOhTC
X-Proofpoint-ORIG-GUID: JUCCtYye3xu1GUbGjFW6irrPZq0sOhTC
X-Authority-Analysis: v=2.4 cv=R6kz39RX c=1 sm=1 tr=0 ts=6a3f0dc8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Hh2p75sUsxRZ3lFXYtQA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX0Ai+u2dU6UAP
 SVGxOdBusToTU6fBPJuFffEM/87slgmjGZV992+/JVIi1B72815R7D8yPBddug2Fz1BDkz+VgHP
 24DnBBUOF9PZbyWJ1YelhvOxW/1vZ7Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1d08db5cd3c..fbccf72f686 100644
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
index 00000000000..4d12e23ad60
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,19 @@
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
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $tmp/output $tmp/plugin
-- 
2.47.3


