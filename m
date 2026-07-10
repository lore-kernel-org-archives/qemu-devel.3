Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37969C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bx-0001OU-10; Fri, 10 Jul 2026 02:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bd-00019L-Om
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bc-0004eZ-5R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nU973848885
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 My8v9Q+Gbq9Q2G6fG7cryzQAT86oGuijCTJTLTsstI0=; b=m7XqNXOC2EyKcrii
 PLjIDKZ9FpMZ1q4hrZiBsgmLfSbJyguK1QkVUwRmIM0HEKS1zbJVZGN+BYNPcE2/
 n+17SCsUHfty2AkAeT9BOxZUSxKyqzMtqOhuh9pMRESVMyPUmTQn9/FRfU633IpV
 eURnbF70Q8Cpbk0QKUdRuV2LsX54Ccyrf3gpz4+ZFyrvZkrEz72pI7okcA7vP6EC
 yRalWnDfqK42ZufDGyHCnaghdSEaE1uU2t3m4szah4RhXFxhXDF2m8CbMiK/4YuK
 Yt/2xunlJmBC61nn48oRnq4SIAvvgkAuCHJMD0UdRKbypa1LObikBVqhLE6rxVZy
 i13Zjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu29d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso6060455ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664457; x=1784269257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=My8v9Q+Gbq9Q2G6fG7cryzQAT86oGuijCTJTLTsstI0=;
 b=aiPqbOn8/zu/POQsP2anoezOAhaxF48arg2sPgLRTlWVCF5DFHgCSMQEwzhatS2H+D
 uoAx+FXJZwYDZ/Jb+ULQyrKuLMiGQ5Hfl8oeWtBv/zXEHS488utthvC/WEXf5EslMpYl
 6cQg1gZmh/u4z9FkrD4UTBNlJtQp6stNw0rlEPgwB26lj9NxaMRZjp4ypH7mA5MaC3CE
 9ImgzpaLeqEeBrw9lb0PtruL42etZkw+iBG2gq/dpNzlp3H1S0TQMYsgdITNpkswVivx
 +Z1+U95eipH8rJnOydJhNzY85IsNfk/uK+AfcSsj9Z4r8LVz/OT1q3bzOWZvwPQeB4CY
 0s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664457; x=1784269257;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=My8v9Q+Gbq9Q2G6fG7cryzQAT86oGuijCTJTLTsstI0=;
 b=SfPryEYm8yf4z6/2/xS8VDoQLoTTX8/Jf1ZRqAqhiF/DW9D9VZdVf/iMPilbDxskJx
 spGVzeEWhruz+37NZKtlPsBT2LF/wZ+kz/QGtxpgvlkyyFVSOd7bd4Ldko0kdm8sm2IS
 bx70LGeGDy5+gW0fTk+kG55xhi0M9wqoFNiLveoiNhzzAJA9Wh0RueX9uC+UdlsNybtA
 HXTQV5rgMX5HDJMS3Ek2llT68OzCo33cQXzCSBODLf7FaefcBii7NrF1K1+s9rRljMo0
 sD2R7Ak5t5hBHUXZ/yrgc3KSgjH/PLc+70bf7XcjnaaWQaDcFolJpEUm1NCKjlnBasJY
 mbtA==
X-Gm-Message-State: AOJu0YzqFXxIus52zq2dYdeXOe6XtkotUAK9/QmSMn54nssjkz0sgUcu
 rJkw2NJcQ1hqu5zP5037HKR96ESBL3Wjkz8G6Lw+QffGzPF95S+iorZSmq3MvNjAjMEOgbXlRdH
 6bInefLJxdgmGRvZbgOt52hsQKTXc7om1xS93I6i1wjQ8LuQLFoUYMBLXdRUHZVu5Fg==
X-Gm-Gg: AfdE7clFq5sLQ3sZcG6Cqcu+HqXfeb6kQwqo358MGDU4d4QromJnL/4X/4CGybgehXT
 PFfCr9Wz/5J1Q/R9r4I6aIx0rMXrOvJtBIFCMLP+5emMC5vs+TDtIh9TgBNf1mHcJ/yWplvGGcO
 2G8x5SWOlyaJI8XhoxlxAyKiPZkh177FIwDbgQh+BLS3nyd0q7AViUwdWeDz/hUdcrpxyVhfj+V
 6kpk0VrxN7lfLsi8FpZQ12//0lq8lT7WQE6Ry4UdPOTHX109HwPpKe/VqkMlB2de198aRdtk1CJ
 hChAvr9p9gNm0LaggBwI572TRIcE4M/19KFc558/IfEEZvg9BOr4MXu6Je3u6SkkIGcpPJEJ67I
 qKOlcTN/KdGZrWJFG4DbUdEeAKTuuxi76B2rm9NpqkhwN+t+Jtb6E2Rcsn0Q/qAvcWKzWIWXpJr
 0E+rC7ZQ==
X-Received: by 2002:a05:6a20:1615:b0:3c0:9c19:b272 with SMTP id
 adf61e73a8af0-3c0bcc32329mr11942024637.64.1783664457450; 
 Thu, 09 Jul 2026 23:20:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:1615:b0:3c0:9c19:b272 with SMTP id
 adf61e73a8af0-3c0bcc32329mr11941990637.64.1783664457015; 
 Thu, 09 Jul 2026 23:20:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:56 -0700 (PDT)
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
Subject: [PATCH v4 17/97] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Thu,  9 Jul 2026 23:18:55 -0700
Message-ID: <20260710062016.1818125-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f9XALuPUGlx2_eD4GrlRbJ2aTk05BA0a
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508f4a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fCjPhq1eeATGNm5uL08A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX6EX7ZWtGa8Uf
 fHKfw2ihLG0JgUMzd1w5cgN6IERQmUl65R1dvz5Br68rnRKm2VgtO5OLDypy8I5l/5bzpuaDcKJ
 MmB4rgqTJ8/3KXi95MKwa8xn0zr24mc=
X-Proofpoint-ORIG-GUID: f9XALuPUGlx2_eD4GrlRbJ2aTk05BA0a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxImXE9bh6ZOw
 sFpBiz7Qt0Vj4751D6s56gQzfrXpaCUGEHEpmRv0wjz4WsXWaro+TYo3Ekm7O28om7V8wR6TmE/
 CWWSiWyCLVUQEwt17LjsAtn1jr/fpdQJCXq/oaTuju5heLT3IicqM88DR8JfQOIRTixSRgEXj41
 Q+dpoCGLQ+pMrvVG5Inbx7YXLoFg3q7hZi2ODmnXhjBHV2SpGjc5LAQCg+m2v+olTU9ZEMnP81B
 Is/rFduRu7JEqLu/G6RgrM+A0uPJm9QY8YgtDwFM2GQNbnjmM2zpVAYAg6mDAvPPiIQ8vjh/TO4
 DL+utKx4CAGd6kNXTaUGi7SHN7eeAimO0Zprbk5ooIlWh2hFsiZ0JdruWuxQ9SOBMv+rnKqVoEB
 LGPydZzeV4xsTz/6SF64u+jIKfYXfLt/eKoOiZY1dha4TjscFr5sdsHurfL/GjESBHG+Yb1J5UD
 W073vREeIaJywRhGxgQ==
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
index 4965cc282ab..92b148e9d18 100644
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


