Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC2CC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNk-00055Q-6T; Thu, 27 Aug 2026 18:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNg-000500-FY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNe-00064d-Md
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLr6v547167
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=; b=Rz6IL/0qp/nmOHLS
 3CjIVb7tE6dz64PEqKQXiEUQHMyyNnLkV0J08kZ9iouJeVmfeRoDYaWuD+F0M6uR
 pfKCHERowrdw8tSpvNbIoVTt0vL4uqVHqxq6KTQ2RZtGzhS+XTRJ6fg8ubCU7NIg
 dFEx9DWoiBv88wgsmy+Uha0WNcu8RtaOQ/2L3wCTBFuxdBrd2L7MIQwb7145yCtl
 PLFIj3SMNkRHaWzBOfLEo3abrzWEt0ZFk+GyIa7GXN6A87wmY8v4J5WWdfByQ0ek
 GVnXAgJn9/RKWsZZK3XyxISpCsnoBVCBSftNudC67dNa7aOhWb67zvJAmdWurf0d
 Rg+2lg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562tpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-85321e37104so486039b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868929; x=1788473729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=;
 b=CfOHzosqbFKWNO5uAi6qWHm2oYjYfZ1TdIfh7X9Mhk201CvP9tL2KL8X7WwHOPHmm8
 BImAbul+hWhQz0n9gxkTtSt0ebbYeP2S58CeQkjzSunZ4T4gcBcXiq0OfXRYU4bieWjU
 XOBkSlQcNqDXxY7VjQzlyKyMEdVgUPEIvTkefThKRIKMOlA0+4vYqsESXHPVVwhPi336
 Um32aJY96RuniZO1HS97m1Y6Yvui3p+nlT71qpJJQ6T0gQtHLYVoLcW7Yb5ImMLnK7Lq
 9gjuZCC37gUxwkyPTpFJuKlv+VR1snnzDm+XqvkDXwVEfPN4SGpR+Dl367BN98lmRD09
 4u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868929; x=1788473729;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pGQwE9tfGAvHJ5PgSgphG1auUOPHaS2Ibe9acuh1cWk=;
 b=ZRnbj8tjcKYT6VqRhXpP+GTsegqTwhJZyGw1AKOC0VO0u+AzLTZuKqg0C2yHogLI3k
 5vKXBOTIih8JE7yFizAVO0MyUHvPtdYft/C65qLclRAqvQ8ihuT+9SIIsezS4Y+t7rnv
 hMEBniF8lJtr3VZiMPo2tfxd2+CIbiCSIR3wrnHtdigzdLdMsCBTSGsBNEGq5RMO4ZCl
 0gFE1SkKNMmbasSHm8xa8vkuUelPiEVwJtIpk82NhHCG5DBbk4/RHpj/X4kYJ0ArWsT+
 N/NnmvUKVNyVacyfyUaL9ls00MIZmeXbKGGfeSj+1gQtmTMJh/6+p9tZgjOZHfQcDdXL
 jaWg==
X-Gm-Message-State: AFuF++nLYCg/o1V/r3mefpwVQaM64Mf2k9Og4b6oJiO7FR6ShqdEiKnw
 fLWThpJV0ErmKxA9dTI4VMoe5cbUzhIGbO/z9Pg/sj6tYwy1zbrPPd7z6jChwLmPBuxpaxwYh4/
 skBVyRyfaHiw5SN8FUj3s7/h3AcaYHOnD8TSzRAU6yQD867Hm7MtI8iid6Goh4uqxWw==
X-Gm-Gg: AR+sD11Qi0NEi3oohonW8yRblp6GLFl8lb78/G0Ey9sBMSaL9OqF/JbLOUmVQJh1qWv
 MOkjz2FyMqKhicqQbTpu1XDMAIDWYhu3TdQ1DvWNT6Hsm594k3eKwfcNKBza2vv0nPI3ibT+iOZ
 ZbJ1upT6w8DzpLqVrz2ehAstaki5gTqCBWIvLAGGqKGQZdnJ9eDWOWFNYSClD41XGdImAu6o+Qn
 HYEnBt45kmKMyK15coh2FiKnJya6ADz4Dco27IMXr0NQ3Fc1hkdhNqc9qZfZmO+PwxYuaueVHsz
 eqeXgPLoZwNsJF/BILbj374Q9GjWZ+Qjvi3wBPgOhEa3P7WEBvCQkOLyRwT+b+Gk2Jg7Uu6qACg
 8I+JF4o3hk8U53rpYyFxyE1SW5uil3bKwrDECO5rlfCZCPzypq+j0AX3WIrk=
X-Received: by 2002:a05:6a00:3ccd:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-85627dbfa0bmr4448016b3a.1.1787868928691; 
 Thu, 27 Aug 2026 15:15:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:3ccd:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-85627dbfa0bmr4447927b3a.1.1787868928268; 
 Thu, 27 Aug 2026 15:15:28 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 016/105] tests/tcg/meson.build: introduce expected_output
Date: Thu, 27 Aug 2026 22:13:37 +0000
Message-ID: <20260827221506.91574-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXy6OGfAnMLhnA
 lU5WpA3j92FVOxuMz7MfRdZ/4npnNBeOxFUY56+SrYTK2lbxrc/gtLVDij8umoKWcJWADB5wHSa
 w1qKApfhTesw3kIclsNXwubPEpfSo/0=
X-Proofpoint-ORIG-GUID: -Yi3mwYt7zDoZ_u9VadDhmcf8l3BRrxT
X-Proofpoint-GUID: -Yi3mwYt7zDoZ_u9VadDhmcf8l3BRrxT
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b701 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=twXvQjPDpJ6hybaE9wIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxckTXFzerqWD
 p58aVX6YU/cz/gx6/rbYRyb5RRuw1r5OVIDO8VW+XsTd1PvCl0umGJ/O6N0R0Jk8ZShhTiVdnp1
 mUg6M++iNkZCHQ4y7V34Qwg9YrEha8862/FvAYzi61I+AXOBs2hgxp9CIJOx67xI8CWp+bwC+2j
 yZpMAp/uj2zWfkVWQR85bEmXVG2MD1h+Ozge8Ifw+bA4eC6TkMfZ1gafA7KMOGyOiO4c6L9/9Oa
 I723vF+t+ymCI97oGgpY6F632cv4cMtKHLPfUbDVN74YJSl+TSTWSLFsEc3YsJk4Vb+ip6eitEO
 ziHdrp2e/FIaDTrbA+hQHxGRgYzh//aU1aF/O6JDI0YH4LoKq9tlHpbV6fe4wOBc0Dy5WFn8l5M
 ax7c4rqRC31m4gh3Cik1E6RMaWZUIKzkB59MJAvsWMBxubLx5TTgavSGbAOKnRn2cGbysWAOhIT
 SSkLKdc26US76QBvKBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


