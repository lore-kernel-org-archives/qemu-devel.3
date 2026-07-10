Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF77C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1b-00056c-7R; Fri, 10 Jul 2026 17:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1Z-0004zA-7q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1X-0003U8-Oq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCliM1931565
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u9Flkj2si26nLeuVsGfTVr3E6/Y0GgePRLKguVyHtdc=; b=ce6qf8AT7Iw4mr0v
 fsPNZdLFx1lpUG6sHZhjD9Qw2jPU9ioDeIdrCQdNOC71mYpSvc1R9Fq4iJMCJcIZ
 lngCJu9BjD/6FrnwwuMr3Tp2wsxqgtKs2mlel9oy9qDhRXEVhYEsiwYWrrGVMHb2
 8s1ovdkYvHDcTm2M8DQMUWlEI+eozUAV//dLHJLNnJdtEgmbkWabe3y40uXqhLaD
 kirhNktkZ7owUTN1nmj+gsVPR/tBLAj8jXg0ItK7j7s34f+4CdE7gcrgcD7Srnr+
 PL8Z/1/tUVamndITdm3F+X64eM2L3iVmQUv/U4zEKHCXV2xbd2F9H+xymPjo9dQE
 KgnEdA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2kb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso340996a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719872; x=1784324672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u9Flkj2si26nLeuVsGfTVr3E6/Y0GgePRLKguVyHtdc=;
 b=TjiXRD1jXWuoi4crxJwRCmnSpDFPBViAL+wqQQfkTyF1PsEVJQARhz1oF3kzjd7XSv
 XfnQEIGJlE5WLEqIKWPLPkuxRXxQYyD4S6uRNJ8hvS8x/J99y1yGu60C3vwau/emnAR/
 /1f+IADxGSgDjq98+8/2ABfGyYUf0F5/dsh8SetklFBdL7OxSDyGGLip+wI7PM6ikkk7
 F3hFudUiY06oRnwGDwiZwU5QqQ2hHMNupWH5dlkTHguzEwRct1X84rRqa4MLTpx9dAxi
 rq27cDJmvuFkqI3XWbDyhveTKhGjreY5u/zJLEYDP3vSDftLPofJdAHarMqX2Z5U+djG
 S1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719872; x=1784324672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9Flkj2si26nLeuVsGfTVr3E6/Y0GgePRLKguVyHtdc=;
 b=lvyNIEW5hJo80icKO0l8PapRLKUlrJkO+f94IVnfC+yiVzxjH3eiLX7T5Y8MvEQfv5
 SVzi9woQklKWKajha172EHMMNKjQqMPHeS5DDHUlw19YoZ4lN/JBvUwsUjBUerVd6ybA
 f5SgMX2QLiR/h50Ckdsqjpzl5rF1whHkijStzuJtfTohv9WE5hhsonCyqLlWLqIJVONX
 Rufn1MTN8DYtwF5HgeAzDy5AsEEa8s2TxpplFaXYwOCaZqhZQcJPW3fV+N8skSmF6dSO
 i02Ji8Leow6FaXbIVTaPdkcmHLppmgmERAL+Mzbvjurb/DrrUtgMbrpRasSfK6SsniVE
 wwBw==
X-Gm-Message-State: AOJu0Yyr8iYuGUYslRHqZed3EUwDbui2Exq2bxcyZwF+MFlGd7jTwVeC
 hqUMRy7ZMyLc3eM7PxuWsoEpH3dshnle6uNvjPTN484iCpGwifyEKgCjEdB6NSCIqd9u75N4NJ6
 e6Z0J1juN62bj3Dlud0qiqGtNfhV/8grqwyCNScQbhCEFQL0/yyvttMZqxxL2vHEG0A==
X-Gm-Gg: AfdE7cmroeo7/uykYsxbqPZUwNYVLvYHSw1qgkhnCvetpFjI9gsoW6z44vzJzQ6l1Fj
 MuCfKC1nob4hTOe11DBZSH8emDJPuBNr0HMYG3GVA5f6t6qpbc4Gr8OofOVnvGIBQT5UOuaYUWu
 XXtnG8UOjF7PabuKWhDFke1HYL6VSHrJz0w5u8YnJ1FB9tOBSfAVMYkoRbTXBkAeAdR9A6AI+HM
 630jhe1QpzkMGhtJP9gC77gvBwXqMNNgxLpWgNnDsLsxX9vC4VPatl0QEB8USCLzBd26ac0AmG3
 XpphiJuTKoadxTtlOez6X9XZyOpzXfthSHWHLomcGiLbUB1sx26iGmF8s0njvaLksqGPopZy+tl
 ce0SJBlcLdTODNpGc/7V8eCccwvC6j0RbkDNP6mvRIh/aot8quJJNVpM/WRJ3+UxAsECzTNPgJP
 AE+VRNDA==
X-Received: by 2002:a05:6a20:5484:b0:3bf:e449:332a with SMTP id
 adf61e73a8af0-3c110009ba4mr802160637.3.1783719871834; 
 Fri, 10 Jul 2026 14:44:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:5484:b0:3bf:e449:332a with SMTP id
 adf61e73a8af0-3c110009ba4mr802146637.3.1783719871435; 
 Fri, 10 Jul 2026 14:44:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:31 -0700 (PDT)
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
Subject: [PATCH v5 20/98] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Fri, 10 Jul 2026 14:42:24 -0700
Message-ID: <20260710214343.2065491-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167c0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YJ5_JRR3wJtdSSnXqCYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qGWf7yf2NXDPLQQCY8H-S6Ts2xj7nDn9
X-Proofpoint-ORIG-GUID: qGWf7yf2NXDPLQQCY8H-S6Ts2xj7nDn9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX9D4a4YUVZiHG
 CvO/zNeAjUag9xY0Kc0SWKBuDn9IZaSQBDf7guESREuMvwNlo78dmVPxgPmeBjJkj0iBttASRi7
 OxYaRKkZ/JrzbYA52s8gPK1gFLnU7iE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX7wIKXPP8qk/P
 vvjPGTDoS2doagXLx8ph1ptJuHuINLeKIGGNrbodSvHBk7dGG5JOZ8kQmYcuuGMsggOEEBcEsfA
 6VlrsIUUrrB6fNdXtPDdPLUoLGmw91HtG1qdu4m87mwh/LLEe9tTX5hPbrRbjx8o+pCjpVXHLw0
 1kCuivLYoeUBB3Ea5CMJTvt/+Ns7B0l62FBVk7ohGe0IVjbswWEIvhT9srTX7/ALnGyUJpeRQ39
 O/KK7ZjsrS7mHqySXSNvI0sOFpVm2E20LvJx+LnW+HoyF1PcQrh32YC5sWmfRUgDZ5wQYyyGWBM
 C52BVytCVcRai4XdKWqoUjKJltOfOWU+thfC9XbgmvMTmDRGk/3wRTHalcLhuPyHpaGX+orHE7h
 BdEv2XrrSVLDteNwza8QDR6GClyMUT3zx60c95ikt23mNHh8kgjCUUe8s13Ig4TeBN2FyHcDAPg
 sv87fzxdsAXkh5nvCnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 328592b28bc..779f9043abb 100644
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


