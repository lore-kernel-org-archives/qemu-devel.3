Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC0EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1X-0004yT-AH; Fri, 10 Jul 2026 17:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1V-0004xt-65
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1T-0003TJ-JK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKsL3k1947651
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sr6Kr8KOVgldgQT/Cp/NDRYkVE9COGPiUTjyvPYRF9U=; b=pUYFzM48dYXrtSTh
 Nqg1TtSVMbbHusqaCwGE3cjKI2hH1I8R/wpVBJWwhvu8Jkl6oOyYV/CP6VuYBVpo
 9UhrXAcL3pshjTh358pAM35g17bmz5XHJsDf9Z7V/p0/QYjs70CuP2iHnjuaNev3
 8iqQBaQ9oEXU8T10M+tNf07+88spalbsWfn91TDzF2HbMhJG7CAaLE6idJlGWwGj
 wqZGWZCjfk830Md0imozdo3a+2Zw9plw15xan/BJpNehOZf9C6+l3ExMcGo0s/5x
 OlSzZMhhPDAt35Vsp1N7UvVVkNN+pGzc9CCBY9WYaJ93k70TjvsKVCw9Nu3Z0gi6
 CQdNUg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg45b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so980883a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719868; x=1784324668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sr6Kr8KOVgldgQT/Cp/NDRYkVE9COGPiUTjyvPYRF9U=;
 b=cm1o2HpyXz+mGDWn+uHOySHWJEUr1xoCL8Ulbmw4nCxY0PUZKWL5Yl5w/YuVhgRxVU
 Mq7t/HGhGbvcXT0o0dKP/JfIgvfMlsU+V1s+9U/7DgcQ+AKXNkOKoDzCvMxmra78Nc/7
 b8CMmpg0HlAfVs8lEJMG4H35H4dzE7KtTB10MxJDHoeK2qMQ0O0kiNgPCR4tKW47ZSDJ
 1DUDQa821Kv4Ceaue2FixDGBpV5koz3yrs9xO6cRVN1rhqrxJV0TCmNlNobpC9h1fLCE
 3KFpZqRb0jZQCnPSL9Iu1zoDPBNMZhLfbSh1CZrOIBakWc/uLoLoIhh26g4zrmtLPLyw
 4qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719868; x=1784324668;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sr6Kr8KOVgldgQT/Cp/NDRYkVE9COGPiUTjyvPYRF9U=;
 b=A74LxU++hXnRw3bqczbh3DiIDWT7Zadz7eki6r9471t7T2Txt1XUt6zcjCE0wVVsrS
 nZ8UBUU2rndzvwnEK5tkK7wr0PBAckyCLZ7HAyRZQYE/c0PZtTuhKMjJ+X6h8LeNUiFW
 HB13gp6UOKF47e5FS9MY6RBosgGmGE4MLfYdGzY9Z5/k7F8swESLtYRePdMvYY3QRMIJ
 7rKbKQskXS5QOC+n8GheYUnoEEDXKw+tmbDbasqvDeEF1DnftFjnQspku0IeXUzfp+Yc
 KfdY6UcSLxui5Ifx45WdJCKAx68plefz0KYXzyLES3pkxcp9wL0aFLReDSTVjVDrTMqp
 +trg==
X-Gm-Message-State: AOJu0YzQn1f/GZYeXPesqPXki1NF6HBQm5LePAy31BHo8ZZ41QDLzeJ7
 rrt6vO6CW4MGSjMhjR70Kxct+rpUVd3R1BGd8/kBsfh1XmcLPjcI9pg0NJuMOAqX0cyXHmVPA8o
 p+YdBPRDFWnTSXXMq4MxLzF377JRrUbxcFwgxYY7g52XZH+tCgsIwR76PLVLwl75X5g==
X-Gm-Gg: AfdE7cluDdOB5vOa9mjjtGv6M8JCBIdipkXT/BqgVHjaXkJQ+DKty0LuxmO0dDIk8Gv
 SeiAM9umRQSTPuWVLmld9VB746ewM5c6zsVZhQKJ+RrD037Y/hh8PlpXLCb2CgI53f/5rweOOls
 RZjV7CBgXxa0nP3Q+qm7ZSAeuh/5sgDrkn206Wm//hRJngojLGJgiviY8tT+HjhYyD4V1w9yroR
 wxQl2CK/mbpXCJOvOGO5o7SMHTA2d0K8jbr0Yw3N53EFs+GmMI3YJ9lUCfKTK165wjP6jzfnrCs
 m8h36SFUwpwrV0Fjr7apVa6052U471yXbA1bfZddPg1dU3cuaoXnR4xw3RwRmu4mkA7+UCBGImi
 8DJxqqPfcatHapg7XECEUnrkrHKEGmmhYIJDG2WJT4FEAb5lpFvXvm+NY78tt9qKz1tosyhMhUg
 ZanIImow==
X-Received: by 2002:a05:6a20:244d:b0:3c0:9c19:65a3 with SMTP id
 adf61e73a8af0-3c110ba59ecmr701008637.75.1783719867818; 
 Fri, 10 Jul 2026 14:44:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:244d:b0:3c0:9c19:65a3 with SMTP id
 adf61e73a8af0-3c110ba59ecmr700984637.75.1783719867375; 
 Fri, 10 Jul 2026 14:44:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:26 -0700 (PDT)
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
Subject: [PATCH v5 17/98] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Fri, 10 Jul 2026 14:42:21 -0700
Message-ID: <20260710214343.2065491-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXzrI63bmR/MSa
 zC+EGmiGAPJgiH0aFL+E/0DlwBfsOMyeoASsq06nfqR1zaKiz3+X5zvgJXfgTgH/Vb+yW4NPXxa
 4RauYmOt+7uDJNa9OOtE5Ze98w0jPvyA6rqLSNxLwS59H4RrcQg++VJ8SkT3SBupI/ZTlpl/OOp
 N1RIwh+PCEWac4HO1Xbyo3FtlhEfQ8L+kiRCiGnhUgtw7JPgBxqw62M7aJImpEpBgH/SuJbZsKk
 0CTHnsZVgsaDeJFT7zS0umA+eZjdVZmDo6TjZlL/6DlBfRmY6gXSEV5ZAThDJEe8aJNQQx8Iog1
 7V9IFR5fh3Y2bLq+IbxV4/8HZW51nH8GQSqyOqAQ+uFOXVc21NOzULB2+hdk/cenYQT65rQp7/n
 sq0bHHnE8/IfDpO6aX/3M3CAIfNgOWSZ6P9EDFdPEhXlDTNf1pK0EXs9jOGaof/HERk5jibu3o1
 pyi4VlCyfecK2gIG9sg==
X-Proofpoint-ORIG-GUID: XSamPzKbPc5ATBwqe-A8TprRzOXrybSP
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a5167bc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fCjPhq1eeATGNm5uL08A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX+1Gv6FnpREqc
 FgpGX5fAlflv0fw0baatreyXuNckKYMd9AF7Otx0LkUR2viL7Sv9GYlZeEJfR+q2se2EhHdIeQs
 /OhtSWlWSO5EzZnj62lNjNs3zLPJfY8=
X-Proofpoint-GUID: XSamPzKbPc5ATBwqe-A8TprRzOXrybSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                         |  3 +++
 .../scripts/run_and_check_forbidden_output.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f5fd9bee7bc..c718555d257 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,9 @@ endif
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


