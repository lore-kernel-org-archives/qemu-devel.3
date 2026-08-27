Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C8CC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNV-0004th-C7; Thu, 27 Aug 2026 18:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNQ-0004rn-0N
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNM-0005y6-Ms
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLuwk1117684
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=; b=SDTS71eosjqBCwwI
 UrtTG5j6hC9eVeLNMK/6ARA4xFhxa7inHk0sYGw9JjU6jU4mJGYWLY4YUn21jWb8
 FwOV/WJvUuGwTM94wfpc5/+bmQj8bIzmsgXSLD6oEOJj0/rY4CbdLBvy+gUPvvus
 +0JIetj/sz5G5PGhFEpvkyo3scVcaNZBtLnKC5OEcVcJvfW9GhZXtA6gSCqugr8R
 /m9LdkoEB+UpLIx3q9VxwZs6XyNTlrFWsvAip/JMdiEscjBArZxURThP1lQwHcow
 y7DiroGtpkcKAWldvxVrAm2wjZFv58/qF8uBgBNP9LRDz2E+J/hsBuST4tNNw/O9
 inHPIg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hfdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-85602449126so902002b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868910; x=1788473710; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=;
 b=E6Y3mbxqFMwmeKCAGwRWR7mhWKwMGXIK9SNkLedzfCu1FjoyQ5W/D4jgo+NJvP51nx
 KRsZX83BnCwAfApyhfx0FORijSxnpLJisq4V6RNGF4JsesQQLVPU9tHI42drIpmga/Mr
 IpEpAnK09ILMpj+ssY6x22bQ4a066jkFwDqMzdMpoft8V0/u9yOZpyJPRc80rHVqT4Wc
 pr0BVCS+qfOqXurB0/ijw1vBh1r2klakWMwo7PcA9cTbIpTk35NJ1f1tMv1a/eqr777V
 XCw8uiFdLecSeHUseB8X8SZdL4vMGUyew2fKQXxXaS31RRdyBZl1fXVOWrmiaq6ATkdc
 RmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868910; x=1788473710;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=;
 b=dWLPhUrS0BcsCxmOqrnPSzxQhM4XmptJ8/nM3pCe1rNe+BDAO7i4ERE1PAQbA+EHdg
 rgtW0hBxbFq33fVNL4mSVSarruoEL8qlRA4EHYOJxKjhhbHxRZC2yfDgpMqIY42o+tox
 SkCxKPwsV4zwzuC+BxTxOMXAnQOBJRWR9caTE4NN+tJnd0PfoCD8H9ibpQn7F7qUdzcz
 ANT9Md6Q1iliiSDAyTkGEj/JtDNPiEZ57H0eN2GwhiQGn03X5WRwnHz3z8OeBTt+Jbai
 yt59MO2pB+0vzmLO82LQNJetyLAdWci1R2MHkmFrwW743M/Mini5YqqQlBggj1X2CFdS
 bj/A==
X-Gm-Message-State: AFuF++ke2M87hlFHHM30+gYMftULF6heD0BUPUEk75KAxtHf55sUA5Le
 9GQe598qy+jfU7Dj34Go90nB9d4bNyaz8B3YHslhDh7D2kS/h3089fJIO98I47l3MBQfJSiy+OC
 lfr1A/LBFZKw8nR0UZGbiXRK2LtSljNYa+SkEinOr3AX5aMd9kOZMx4toHlRlEP9vTA==
X-Gm-Gg: AR+sD10OzjxbksD4gXprq2cHUGXiGceUfnZtGBfp9RdMvCz8+4B3oGwpzQed3HBuc1H
 sQ1ZeTQXHj49nYDMKirhYb3YzMsYeJe/zh8KdZxHEYoLktC8g972/EYliirKbYt170ydCu3H4iy
 8Lbv9+NC652Aelt3BLuyo8SibxmfD1oiP9JnEu43qS4khnKpZScZoDSguvI4o6eoXHJZwJln1On
 SskFFDsDhRj7AbXtBMqs5mmjNqiHkvLh9nJflzJ/CYp3bjIK6NlTNwGvV0PyrlJA3Qc84SUrtCD
 ziAzOGi/7Di6N3peL4GmK/8yCaK4rF1a0SIY0z1HA9p0IBpJQMI5PNoux+6jmMZ3gg9IFAnOaU3
 vqkWDsVay/rPzx5Pj1QC0Y9BoiacKREUUQIDvSUzQu8hWpQxmMVrpuK7Fzfo=
X-Received: by 2002:a05:6a00:f0c:b0:852:5f99:1866 with SMTP id
 d2e1a72fcca58-8562514cfb6mr4805266b3a.0.1787868910333; 
 Thu, 27 Aug 2026 15:15:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:f0c:b0:852:5f99:1866 with SMTP id
 d2e1a72fcca58-8562514cfb6mr4805137b3a.0.1787868909737; 
 Thu, 27 Aug 2026 15:15:09 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:09 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 002/105] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Thu, 27 Aug 2026 22:13:23 +0000
Message-ID: <20260827221506.91574-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4nfClm5BMLPW
 2ece6fsSbWGPXV0RVLci7+ADGP/5I6makgOtMVF/EOlqPSzVk7+E+W7dZanFr/yzvnAls9lO1PB
 iRSIg6Wb8MvrzjYeFMRkXqQjx5J+DCHonJRqgzo+3FaVL9UogXLkpUPNdhYTlsXlxJOIFoaNNwc
 5f+JgTy18+fqwmVAeSP/+aqtNPPNsLqBAsgtqhViMKpy3F1weoHpuuV7FCmi06CutUpoF4qfmLI
 i31srwG9JgY3g8gKx5ukmhEU+XJTky2EksiWBBSvCTR2T9UvABkM+ilQ+OqUaGSgtck+Xse/Bct
 QaEx69x/FX6yf51qO3W7SCP2hBTenTEIc5VGzgoHs4SB+HCdZj95mNd0h7ipnns/pxQFzQaSDLN
 aNjGVpDp5tasLWuhElonMyPYlqZU29ysagaY+bHeUh5SIgD4jLMDyyxIQzLi335r/FQM/ViMd+/
 4Bb5/3BylDihCb0Ypdw==
X-Proofpoint-GUID: s7i9txwT9NbXVtn6dYBq6MPXsWgSOBiB
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b6ef cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: s7i9txwT9NbXVtn6dYBq6MPXsWgSOBiB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwxWNZIF+BvhZ
 hNYaMYC5YblLxdJF0J0AKFTk6ye/36SY6rUxAECli8aopYqeOntN7XcweI61EAw96P+nPAMb8hw
 nbDV4yMwDzSwQTCCPiGk90aRXRQ70f0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
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


