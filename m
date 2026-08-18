Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B535C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPh-0006lv-Q4; Tue, 18 Aug 2026 15:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPf-0006hh-Q6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPe-0006dA-0J
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH1hh1006314
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=; b=l6EIENs5VwjCV7aZ
 pl8yHMtYczdHaYtgEWnMLmojWbnqOeaNH/xeL7iM5pFG3zKu/Qj4Cw33WQqRaDNH
 ZM6/fzs01mXOZ4iGxCZePqmp8WwYqlJFytVdyrcA5obE6L5TovzpbP8hkj4z7B8A
 44VcDBN5NcxQlP+RdtAl1OJyAT8TZi0ml4qCpZhrhh6NJsxg3GxXTdgJtX5USoTM
 ErWnKAkzlEWLLFedAisKLlsgK5e4JoETAafp3R4E66uf7B4v7KlELAO/X1ah1aTS
 89ejplKmonTh9uB4QPZGHJc4V5BNgg43WlEEoXeA/s4rXQgkSuRm7lZ0/WeeafKk
 is2qSA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrv68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so555984a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081022; x=1787685822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=;
 b=fRGOIYFWZeTaYwJgdymGzPU4336aes8RGoZJyY3HO25RYh0uJcQ/NHYupouBccLfs3
 Zi5s9JvrFnMVZ4qOp1WgajVSjIkAUX3XUyEkpHYtT2MmKznYnr7rHvh6X4XYQDEg0lee
 02Ej9rJygcMnMqA180Dr3SD3iyyVbCDoRpBZUSp3wejjzHecntM0+XQL5IxY2tnNGWbH
 lFmUMEHTPa+vHyd7uaRFVCoMWFat2YARIX5wQ1n8kP+R2fzF6HEf/6HWvEAn8U2MoDg8
 5EK8qDJnB/pNz8FvBppw0ArJJZY0xF0KmlbMbMpKWLqqjxM4FYkAib3WDDk3sktVDR+O
 Wm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081022; x=1787685822;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=;
 b=mS881rsDhQDrOIP2Q4cn3VtNZYln8ZyK1XvDzxgyqAgwPNDRcldaj610vBwckBi+r5
 jY/8Zf85ry6GTWRLMv3Q4ySygDsIre3eP6liXNgxxvzXqAEGSO+cXB+C5QRjsspdBe6i
 WQVqFO1TbLQeCvZQzsQXMaoBll3CidSmJsjvhV7b1cat1fjXbpc5l+WKMQcwvJ0wbIPG
 EsrEAriqqBSTP0cqJZsc7b+NWUstcumy+Q2Zd8Ni4kQRuCug2wJff3zbNVXAJk8GT0N6
 UfbmX7Iii5ElEOkeI1A55BsD9sJzZ/D3p1R8xcbrgYoPIDtDcfs8UdxQiG+iG5FDV9j0
 yWxQ==
X-Gm-Message-State: AOJu0YxlGG0sDNiXZNGLZdW5N51Qx6i/Tsjw383vqDoL9c1hc9Qhbtgg
 u164EdS8SnyZ4aPAkkGHZegcJMihg7n6W6yqmLH5dYCv/fVcZbr+xMRAJfO2g0b9zYiIVF8Dodr
 PEo51y9hkjBMqpA2p93R8iIy5Aa9enMfF+NoYPN3bsU8YkVavKuyWUwSiCi9dZE4uDQ==
X-Gm-Gg: AR+sD11K1H1K7PUb7velllhbkwn5Of69OtjSnrv0spwEPbOuHbZ2z6FN/W131ZGr+ct
 8T1K7BfFhlphAVD+c4fyQHUbIv7Vs9uPEdeLCudmyLFyKKH0ciWbjYRaOhCF9/SemOAaE6yJfqh
 2CQIB4UxJ1YlnstB5lqpKjgCxh9mXaxk1p74bN8QPTyQaVPLl0mv1jAwaU+S2bCWDYSCkrm75ao
 8Xc2c5CHny8Ynhlqml6O4U8Ay1+sVoMOMFUhUj3h8zUMRwLMz4OpWOxdWCCTG0z1EEFCs+LliI2
 0YxUE1CV5qIr38Kwgo2REZeRz0CcvWMy+bceg8//tm9Dj/C8n0bkv+FBf3qFcXKFt4r1pUO/GWk
 8FAE9p25YQWnJtqwa01Rq4gHnknpuacDSxWkSsp8R4+MN9MxFUJ09erKXujA=
X-Received: by 2002:a17:90b:5102:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3957b29774bmr65635a91.8.1787081021598; 
 Tue, 18 Aug 2026 12:23:41 -0700 (PDT)
X-Received: by 2002:a17:90b:5102:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3957b29774bmr65549a91.8.1787081021111; 
 Tue, 18 Aug 2026 12:23:41 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 016/104] tests/tcg/meson.build: introduce expected_output
Date: Tue, 18 Aug 2026 19:21:40 +0000
Message-ID: <20260818192309.22169-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/9faqUonRJnX
 /4NudaJ4g89nmVgCBRYZLysdXVbAkyhXedMFRjLb9+EF3lTj7+lCrZL2AFSkVQJFZNOOLFq0eys
 KJchoqE8wBjgVVm2h/DvyjDubm/X+Ge2+qkIkfZeLaqvjtSXyS2AWuQKxobUhS92R0t1EvbxfC2
 NVceCatB83UIl3Lz9ryT1RfnrFs9rYROg+UQvcyinafT/G7NB44txufvFeA5cSoHo8Yzs3JpAFQ
 pxfV/F0vjJ1Lyimp29K9XYuHZNCFHiSZuXzvo0hZiJ4oywVumAtB+VfsMw4dMv0+FLvV8V2+1RO
 kEuur5/03PotAnEww7+fHuTHBwq/k5IqE1pZdxPRNxuTKPwckBqqx51NjGjB/zpNxjPxQVtZZ/J
 DiXrcuEGG20EKpLDMfTQTJSSYskMHCL6/RY9p34Xa8B8mpx4OlDFFh4z5So5qjpCXwbG3hnlnUR
 fTEU6oLdPfm06Rxs2zQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+q2spu8PwWNg
 +KqPt6izB46d7nDdeacihI/MgOu8wRKW/MqLsTIhhvH4ylZBYsgHsmiJSoOxn9peGU7KouSDCjd
 dQ2WlJ5KXMHgRJ/g10ElfoyVXwHsOQU=
X-Proofpoint-GUID: O9-TmhKxGHXrjSskuKlEoz_Wy1p6Q6za
X-Proofpoint-ORIG-GUID: O9-TmhKxGHXrjSskuKlEoz_Wy1p6Q6za
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b13e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=twXvQjPDpJ6hybaE9wIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             | 12 ++++++++++--
 tests/tcg/scripts/run_and_diff.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 tests/tcg/scripts/run_and_diff.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0311b2432e4..f5fd9bee7bc 100644
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
2.43.0


