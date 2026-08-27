Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1CFC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFO-000769-Ap; Thu, 27 Aug 2026 18:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFM-00075H-JG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFK-00039K-Qb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMCv8654830
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=; b=NTLIt9M59aZ+W1/m
 IOoedp7twVL1Uhh2LFa4lnwuL2WiLkYQe4z5D83P4k7yiDA8yJTHSS165IrvnypZ
 qIu1G81/qhWrY+5JBkxh/BMP0xlkksdHe0QinZdLJSt6FTsOWno7qgynpLFGs2tk
 qfo2EJehL/TWrAfotf+g7AK1QWWLNP95TmBNRCdAkQsw2i5BsrrxCq1t04cfAfFu
 MiPP7Ntspz/qG+Lh+sMoEQ+85XXT2LGL1TXTsWlRlqYmy0CGIvTPALBaUT6ePMdo
 /2J0/4dfNMemkN+HOVOqfkdaCdl8xFDNm9D9Yug2XglD+K2QgFLRrPBln22ZkPVp
 6FQVvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuhys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84c4cd31b51so2029104b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868412; x=1788473212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=;
 b=Wbi4zC5rvR3aAf8cQcmgfJzv5pN8C8f/ZURMuHk3BvA1Yj6SD34pjpBgNs5LK+dYjT
 YHQMUttf17xNBRtst0hcgEsoPgR0U+COssCi9SVz16DbPU6bvSSdNXDwhRwc9ryfMp13
 d0PByb4ZFIpRvzAOs+WOofL2ewPtm+UkMc6UUsROeeToiFBgE/nDKGSBBcwE3Ddhp9pB
 AR8s5c1hIuKjMdgcd2NqsuGWNgRbTavKSI76MF3LIRXqFYpIFwxzotOpknAtJpYwE1qy
 ZdzuQFqDApQ/Obrl3/KUjQzKGWsoPDA2RIt9bHiP+c+1gfrz/wrQx2HgQA3H8se/fzd4
 8vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868412; x=1788473212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=;
 b=XjnPiEuDkynLnYk+GJmufh94UFWAi5kOl9uKkQq7LvP3rh0mLdliK43P9bMoZHKAun
 j0xwH5Dh7m2YK/DW7WZ8V+Oz5IqunBRkkQKZCcAwGohOyLArklNtZB2Y2wmst5sIzeD8
 qGVAmbhGKngc2XR4UJk/vRyFrb8b+cCN5hqVeJvCMqWy7yMdfZB/HC3tOGvSvI/pbkys
 oCqc8aT6z7Qwx9Rh0OKR2satQEuIsTizCiKaDWaSqgv3BGgTkY/fwdGNjR/DW/pafbsb
 LT4h95H1263BF1xSBxSCZPhIZJ4R/JvmNBEEfUrt+pAyHKLAtie/rOtfCtoK8GjlqJWV
 LmEg==
X-Gm-Message-State: AFuF++n9hyi8bvEx8bK4lofobYRX4PKuMP7Yqr1oQxaAHkEBFL48dK/H
 DjS9fANx8ewxluZvl5IAnmOg2jOWQKew1bjyDEdeqogthO6nr4lD5Vk2mMlkI4Aoa4w6jTgVjyK
 maCAx6QT2MACn5WEmo359BlTaPoYU3kws1ZiJwC7nf/HyMCse0RUEErALCzsOxLPc0w==
X-Gm-Gg: AR+sD13ABsda+XguNqQYu78251j54nhOHeoqIpgYT0HZ4cdZPuMCjT8bk1l80Wj4h8G
 19sLrezI2aXUZV5jd8rVFwu7vGmxetewi/g4hEaf0BDzgtlfwsLiYFQXK0Wt8culTaWb58Snbrr
 +05CizP7zUFLgxqps6t4VC7PhEKmpPY6tpxwGPcyrE1lM1J/H5KtEMQpJr2kSbrdKkz0yfg6Ts0
 jeU7A3CbggjDZkWNDxXHh77qpwzjyve1zg1qz3KYQV05jP/1xpa+PT7wOBeiFCu8P42drzKI/V7
 PyW/sqZCEg8ZBJaK9a0BWmrbUG+dyHohMCMgnUkKrsBbrlPW8vxr+JNlbElzJdKpAaxqb7jgBFJ
 lx6NTC0+0/yOu/DmZzGPadubRxFHJnnKswsTP9sod12hey75eTrY63BwSnm4=
X-Received: by 2002:a05:6a00:4b52:b0:847:852f:c28a with SMTP id
 d2e1a72fcca58-8562ba75f27mr2246989b3a.5.1787868412492; 
 Thu, 27 Aug 2026 15:06:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b52:b0:847:852f:c28a with SMTP id
 d2e1a72fcca58-8562ba75f27mr2246935b3a.5.1787868412053; 
 Thu, 27 Aug 2026 15:06:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 002/105] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Thu, 27 Aug 2026 22:04:56 +0000
Message-ID: <20260827220641.84885-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Amwu3d6q3fNsqETiQSVZKRdcdFSQ6SO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8H/4U4uXUZON
 nD7/ZyBDnfgLNOF9rd0Q+VhHJIs7Uf4c+7KoZh21zBxGQcI14W3PrsEdEptRyMCUMbm9FrtExaq
 YInNg3csqeen7tb3opqTtty+2lHTKvaG2XOeRBxqcMor5e/VSCn6C/wPcWjlyJUTEq4cHBeuHaZ
 mNAJCRPbLJ8rB8bZ/RnPHktuNexFebDmMbLrqulkaY9jcXc4v3qnWeEeAJmA7cFkcrx2bmk77+8
 MYbkyE94QLoIgOmrXS27hFe9jlJUacbPUo/OHCSFrVkoEo+Fwp62SGca0tlchmWebSHSczeCO42
 zwCp6nP1YdGeaEeqdozhkZlNXGx1iKHipeMT8uw3ZR8rN35Mu+FUTeljyZ6ZuT8DIwXzAJmThfy
 UAk2uUC9CjPMLuaMZTNq8gIRcnIEoaqBsfMiqwy9c0EbFsGRxBqFjHcZJj3uITIRDbIX9ABb/kD
 LK9PDbTGMqHx4ucEbFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5wFdj/PtMEet
 Eg5jyZO3OTzfPUQhB/3Om5sF579vka5YSH/WVV0eFp5fM6wOkeixquQs/f1hEnqXrnjW+VyneB9
 J2jK3OZRhOzjvXHP3PULuZurQp3ozLs=
X-Proofpoint-GUID: Amwu3d6q3fNsqETiQSVZKRdcdFSQ6SO8
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b4fd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
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

Instead of executing test, just read it's output from a file. This
allows to standardize how to call check plugins scripts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target           |  3 +--
 .../multiarch/plugin/check-plugin-output.sh   | 22 ++++++-------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index ab4bf9c5d53..9bcbbb11286 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
-	$(QEMU) $<
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
index 80607f04b5d..338c9ced23e 100755
--- a/tests/tcg/multiarch/plugin/check-plugin-output.sh
+++ b/tests/tcg/multiarch/plugin/check-plugin-output.sh
@@ -1,8 +1,7 @@
 #!/usr/bin/env bash
 
-# This script runs a given executable using qemu, and compare its standard
-# output with an expected plugin output.
-# Each line of output is searched (as a regexp) in the expected plugin output.
+# This script checks that plugin_output contains line from test_output.
+# Each line of output is searched (as a regexp) in plugin_output.
 
 set -euo pipefail
 
@@ -19,18 +18,11 @@ check()
     grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
 }
 
-[ $# -eq 3 ] || die "usage: qemu_bin exe plugin_out_file"
+[ $# -eq 2 ] || die "usage: test_output plugin_out"
 
-qemu_bin=$1; shift
-exe=$1;shift
-plugin_out=$1; shift
+test_output=$1;shift
+plugin_output=$1;shift
 
-expected()
-{
-    $qemu_bin $exe ||
-        die "running $exe failed"
-}
-
-expected | while read line; do
-    check "$plugin_out" "$line"
+cat $test_output | while read line; do
+    check "$plugin_output" "$line"
 done
-- 
2.43.0


