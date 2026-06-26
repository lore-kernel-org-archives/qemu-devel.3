Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C5C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9S-0003Zv-Ve; Fri, 26 Jun 2026 19:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9R-0003YY-FT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9P-00043Z-LE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxo1Y3844801
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=G4I/lx0WkC3
 n0Bu26oW6ayHVqjbHuBk7Z59IPQ1LOSg=; b=Bdiu+nww/Gl4QDLcgaXzSeUuLmp
 BA2LU0IqSBLIC3zBCu7P7okRmPPcEiRyh1BusvkwbWXNKQIX8Wgh7eQ+5UHOV/zc
 1EhQvd5JFLYJYYHWkcrGP9OoOeC6QdZnrdbcpgQiTpWD9UDQ41FhZfEgaLTpiGU8
 tJ0mnD4BwqwpgoXJD5nVTjvvploN/gKBUhGBlOSWmDHamcsKqHSbUu84xZn+MEDg
 j6UzGe8/x1AgN8nwlCBY+BaTEgqB2W8EzJUNERhktHFZ2YyAyBaFp9uZz/osHUX7
 Pt+4ZAVuB0HOv/rwJJe1848gKV6pZiHyxLdS3yKWta6g5KjlZchHDw+KFWw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f21wvg77e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c8722a4easo2382818eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517188; x=1783121988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4I/lx0WkC3n0Bu26oW6ayHVqjbHuBk7Z59IPQ1LOSg=;
 b=TtIVoNniqtvVBsyghgK4lq4O4jfBeQ0CGNkaLqCviyBCnncRwpL5aeeDzZR9Y+s6QO
 IkuNJjmbmpDpKBSKfMA+rcoVeWE5EpHlIeCeqrE6ct1BGthde8lor1+cnkL+4d8qTEe6
 U2KN1M4ekWrV04bFZEjhMlaErxuhz2BC/Yv48q2ucWI7xKJ1bcWzIOR4PIXrp3iEW7gR
 AcCJ/mNK7xYgVk22MXGRfnU6n+Bm4qf/qYmyhBcLBtHoq/EyjmRMljb2BTVExMANUz4y
 59aNRcGPeghmR697+UN5DDNBWFMlz+VXf2VKzxZcCH5p8lL+ZWmUUnxoW2adtw26mw2q
 oBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517188; x=1783121988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G4I/lx0WkC3n0Bu26oW6ayHVqjbHuBk7Z59IPQ1LOSg=;
 b=m3L6+tCXXK5IqfIBjGEiW11qqXl94ieO/1t5T/kenC0qLIK/Ds0uIimlJSoXVMiXDd
 Up7a+yw+0W9LO7/1z2ql/zQKwJr4VXSuOZu+zh/JeMglqPR6ej1MJLHZCLRZbuR9UQGs
 2b3/tuQI4r3cgbYetDJnDa/wRaCkKx7A5CfBfcorqA2Cvz4fmsGsjN2oi5HRcmO1c+dL
 YMB2otH3S2Y+oUiL1wNhD/sCqAzUE/IKAdHggjE8simdk6b/3T5MOZknJcgXNBNmx45I
 92wQhZwo64mXoVP5WKeyIMUMRzJIfCHDgrag1dH+jMJn9TEgzrk9Z6dYS9CiFL0TxrFa
 zAYg==
X-Gm-Message-State: AOJu0YxOAxQ8Tkw5iItjPtOz0X+jTD07txzyIqIb7ZqLk8tLuIky7W+j
 0WzSSJsOrla8p5u3MiG8/nr98IAzEd5A+4l/LSIXmoj9PR8LUo4uRjIFuouj/OrSUsE9ngxLMwe
 4QCl7Dn46JsZk9YAEF1rFflgqn1rraiZ+XY9BZCHkho9s9lNNdx4ljmr0HMVo9AmeSw==
X-Gm-Gg: AfdE7cmbJZvPuymEKN9GCk1mrRyL2UTW1qb0fjN8y/7vN63ckupWotOOGloYamWzfQ0
 MkeJB4lHVWMOdQcZSRSRHaQlJdY7g5+Mn98BRI63wFMBDrxcHW0YbW92cgd6SYAvNagXytjzK/k
 T5vgHFLkSkLU7plab4dHHgfTidFdkYDRD6ftYTWk+vptmM+D6Lf6yH5Q/XdRDFHcaYOkuTfiZvg
 KDyHfheZ3VNwGDsTadbsfxixl3bFjsV0ck3s0lE3C7jX2VO31V7ebad+o/ieKYTLhFU93KC7vOQ
 zk8lvx29Adsj+pNdaCOOm0YKSSGv62UfQeUzGb5B0pu50aBxFFsw6WwG0XBscnKGJFd+QXbANJF
 kkY6bczlEY385mTfWoBZ4WoRDAA5qvmj6br2SK1rlwksF9a8dAoR3IXUSVIJGkSfIddhgdFPseU
 U2E2VOVA==
X-Received: by 2002:a05:7300:6902:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-30c84cf3f8cmr9178764eec.5.1782517187715; 
 Fri, 26 Jun 2026 16:39:47 -0700 (PDT)
X-Received: by 2002:a05:7300:6902:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-30c84cf3f8cmr9178742eec.5.1782517187182; 
 Fri, 26 Jun 2026 16:39:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:46 -0700 (PDT)
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
Subject: [PATCH v2 17/37] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Fri, 26 Jun 2026 16:38:58 -0700
Message-ID: <20260626233918.158740-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eszvCIpX c=1 sm=1 tr=0 ts=6a3f0dc4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=fCjPhq1eeATGNm5uL08A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: XQBVO9UfOB2VYKYhuRj8hhue0nqATjy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX066E/jWdJuEL
 XNNaz3ha6R1oHfjhjYFB2otZmwQpY5sVGDQFUskWcNGZBp8MxD/najNsAZ5oqCudt4W6qAPPZiZ
 FeSNCLuQks7hIhkYLJcr1jtwHBrkJ3EcmHr/C7oDw69QaMxZ5y50essfuSuxYDpAhKmjgtDw9cx
 sSRPck7OPycATlTOZ8+FXvnP38sFS469YA18RxjW26c8teo6Pr3y+TBK+/PP+8ZTfpx/Z2HTtzQ
 xgjPbs9lp6BDP39wbFyLWrDvcSX31BuPosJgOGhoT2ozYoFFdKaMbDwxbRr08Zuyk3k4btC0Z3l
 VMRk9Kg+FstIh6AL7R9+gtfjmipa7vjfOfVyZTJ2tbapjkyPeggAgfjBoLth5q0x/XxJu7OTv+1
 QbgbZfoMi+MTRBhRnplIRSGaDTA7C75BWZG82WFeVD+TpuJwlJDNO7bqasKyWFqLn9O+MJ4N8mN
 z5ZBYLcrbnaWG1EdxLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/Y/9QH3xJv+4
 qhIyps7+DKE2HUILPfu340RdhpgnIL3D0XhbhT7vur63k79RSv8JTVuFOBeEGSAiNs6v5UegEdb
 esJJBL/1PL6hr0EqVf+12Jl3vqajWsc=
X-Proofpoint-ORIG-GUID: XQBVO9UfOB2VYKYhuRj8hhue0nqATjy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

One of our test requires to make sure output does not contain a specific
string. An example is system multiarch test run-gdbstub-untimely-packet.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                         |  3 +++
 .../scripts/run_and_check_forbidden_output.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f052e731de6..130f8a83c54 100644
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


