Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547DCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtw-0003KN-Hi; Mon, 06 Jul 2026 18:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtP-0002ku-Ro
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtO-0005bb-8D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4gI1626316
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XtS4bYgoRZ9
 QBujN0pHStoDlXIfm5Y2GNHq2ooz/GmE=; b=AJ5Ur+iDgEXcDtggu8YGlcM/5Gs
 34/Zpdsc8/iYSZ96GTTFrZKdQYQvIR+MqB52X47vQWqKMj3PZSMEDA/q/Onc8LDh
 6RNL773vhJRaowSOKs3u9xpIY2X9jQ+XEr3mTpeuHBNNMUr4mLGsvZ2P1VGfPRGA
 XcasiZwlBaixb0g8T+is4dAxgHNDkTEEjeAeKkqtaInRr3elONPMZnUNWomEpOSk
 RxiGWCcmKiv0czQ/k3SZTGYsM8b6i8ncNwxkuz6X3Ps+ccqrBg7W3lYEk63ACUtS
 eUEKdR18qr3kvBCvR2O4dYsWABNPcQb/pm3lKPRKmtNaaFLW8I6wyiGEFpQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bn5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38112fd8b48so3973092a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377260; x=1783982060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtS4bYgoRZ9QBujN0pHStoDlXIfm5Y2GNHq2ooz/GmE=;
 b=XWktX45WptcvTmZbCmBWk4OE93dn83auPimKo7bG1OMRXiXWDGDl4qnbZLwoNqWdqN
 +xVQk8xBP7NT2fTBFcz+d7Dl9xgXmUbuH419vt2N+/pfNNopDWv87UObYtQZanYRI52l
 xKnr50lhSqDIlssS5mAgvcjmUnI/Xi8JdoSghKMfUgJ10rU7vm3pD+2KnGh1CGn7XhpM
 rteiHp7oDdIDKwrcsauCqAaEwHq1kq+05ndE3w0jaLrnLIp8yKkKAm7hBL6LM1P/nwD8
 rt3Gu0aWM8M7w3XMutPPCnQtyiXrt8NyYt30ni0JhFn6U4ZE48Rjcr5soPvd1ArnqLCL
 YoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377260; x=1783982060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtS4bYgoRZ9QBujN0pHStoDlXIfm5Y2GNHq2ooz/GmE=;
 b=EWaNTBsu1XeeP0jm+SAhtX1Qf8PPPZ5ZYuBTdOwj9FD2AwerJWSHSaq64am+BI/L7b
 MfooWdBvfTdkgf2tWPBgBCQYN/Qyxgh3K74YEFM457a2A4+vb93TUtqrE/mPHDMKuE1y
 irpP3l69nk/WDMhG5aaq1zUsNX7XzhLGPPMhjFwxlSV5DE73HvXuGEO3Xx2/dDpSHZxd
 7KYcAYfy0RkIhTy3/ShvuaK+HHuERtur/EMvbWaV1Iq6GXP6gV9xKGt0ArcRNv6IK5Xi
 G/fXV/CmFfKUJIn5NgEBU+WhU8Cn115UocVCSe32nVfECG2bJaQEFUBtxStqmxCsWMtV
 FjZQ==
X-Gm-Message-State: AOJu0Ywt/pff2VlK5HFTVRhzWXPH+ILTaoVpQP/VC1hd8RDywnr3P/y4
 exyeiVqpyqBY3F8zzRqYGtgPc5ymKOw44AzAa0/sVPo6FkxCdLGHAyjdWu09uUeQTN7VSEcDOzr
 4nvzjlErNrRcOuMEYYKgma5AoJdzxEOKNNBzAg0Lz4vmvuyTpA345mkOFRfpJbNNVFQ==
X-Gm-Gg: AfdE7ckqCtpCGKNs4VPjFulMtMzEbj5ErfqpiW4ob1EMeSQz1TuX0knsphpWOWReeGL
 XMfZAWbP5AuSK5I3cSJIUD+etzoVgZdXwl9xzNrhbaBDAUfMYKE24oTK0dVtzpEf7JCPC6ykfzM
 +0pOsA6Ru/2RenPkEjU4vJh7MMvU6RX1L2hAKCmUQqaVD9M7u21TtQv7zXUfA2yamu88k+Q7RqF
 0rZjyWvTrNM/u7T7IMxsY9NoSISMGkIXTGqcqDwPwhjkKQsebUJA/roXAS9wQuRrQ2BrVoHpUuX
 A9XGew/5TPLPSa33sXGugBqY8CwCWSYvURSK8eyG8DRnQ/AU199UNuBnTdUEQmtlAGSYjE5d3Dl
 zJ3J1obbcTBOOO8+ykJ3x5+kgGk4bfY+zIMZMJ4WqfFasUTRbTiC8S1Qq8m7/TjdPuTo+zGqxFO
 c/z1/pjQ==
X-Received: by 2002:a17:90b:37cc:b0:37f:9ce3:ca96 with SMTP id
 98e67ed59e1d1-387593044f6mr2135389a91.31.1783377260272; 
 Mon, 06 Jul 2026 15:34:20 -0700 (PDT)
X-Received: by 2002:a17:90b:37cc:b0:37f:9ce3:ca96 with SMTP id
 98e67ed59e1d1-387593044f6mr2135360a91.31.1783377259743; 
 Mon, 06 Jul 2026 15:34:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:19 -0700 (PDT)
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
Subject: [PATCH v3 17/91] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Mon,  6 Jul 2026 15:32:29 -0700
Message-ID: <20260706223343.988769-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5Xyk7dhAgWeGcuHuNZzuEeF0Lnh6dc9m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX38ePSNKrAPuF
 shFIR2Br57NrgCzRP11V6lvylbRCYORrwdIJumlPv2C20JjQerUKbnCiZ2qPyDEiQO4EBGPRzOp
 eDjje4M5ybr0qUw5vXlYcHYR/jQ/YIE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXzcbK3oOv1RYk
 r0HhpYEItVBFMKjAHig/EiGjtc0fiwR7RYJIRg4AzzPX/phap/ZPLpnfD7yKEld3Ek/oQst8Rjh
 HUzyT14Ppe03UpPJjWtEqL977BiZ11ejpDxUBcOwKtdlG64wls0x9T9jcIkVkFC4NndOARcsHzl
 6fquuRPn7IbLS17b1HrmEyT65bW7sHLk0NO51hehw4DGuKpaGPwqv4dotxoTPkw//fqbaUWiHLf
 m81BlrYXa9qU/nPs+ScFtoHwZLLMdldjQpBl1iM7YmPjZAvEi/Flc6aI1ZGpXEqkgJOpUdwZ1cE
 iB3Fx5sUrbSRk6CgYk5n26VNyNRt15Nd1hdHu1sGs32GU388CUm+k8Jqoub3xHpJ6BLLc0N0wAW
 0tcyjurL5yQhHTnXFle9nN8ns0+W8W0Hyqepg9NI4q8TeuX2sO+N2YDxJ35TXxTCVZfCI7xzkpG
 Yxn/LTB/TwcG+Xz2uxw==
X-Proofpoint-GUID: 5Xyk7dhAgWeGcuHuNZzuEeF0Lnh6dc9m
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2d6d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=fCjPhq1eeATGNm5uL08A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

One of our test requires to make sure output does not contain a specific
string. An example is system multiarch test run-gdbstub-untimely-packet.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                         |  3 +++
 .../scripts/run_and_check_forbidden_output.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1dd0e492810..adb11af7acb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -8,6 +8,9 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_and_check_forbidden_output = find_program(
+  './scripts/run_and_check_forbidden_output.sh'
+)
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
diff --git a/tests/tcg/scripts/run_and_check_forbidden_output.sh b/tests/tcg/scripts/run_and_check_forbidden_output.sh
new file mode 100755
index 00000000000..4486ca8ef83
--- /dev/null
+++ b/tests/tcg/scripts/run_and_check_forbidden_output.sh
@@ -0,0 +1,19 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_check_forbidden_output: 'forbidden string' cmd [args]..." 1>&2
+    exit 1
+fi
+forbidden="$1";shift
+output=$("$@" 2>&1)
+set -x
+if ! echo "$output" | grep -Fi "$forbidden"
+then
+    echo "output does not contain forbidden string: $forbidden"
+    exit 0
+fi
+echo "found forbidden string: $forbidden" 1>&2
+exit 1
-- 
2.47.3


