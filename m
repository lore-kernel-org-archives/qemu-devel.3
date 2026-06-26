Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5E8C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG8w-0003Ig-Vy; Fri, 26 Jun 2026 19:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8w-0003IF-Bu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8t-0003w8-VV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxHii2746548
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sU1ZEpbtsPiTi3Z1jYI9sf2PH/WmQ1kJvaxyrijgup0=; b=aU5rvE1lZaMqJjIk
 CNkKbaJtD5X87KcOjA5z/eFLcPVaJYP3WsDaTMVwd9niH4Ydol6hAXgIOMDmCR4J
 lR8dTr7R3E/jiJVfTJfc8IMiCGIdU8fJomd1jmo/wvXp5Cz5NVCDwZo8xnsLDxbf
 Ck64VvYYtXubr0VUdWhVzWWi1Qej8j1anmtXhp/ipJHT9IALh+eItWWnteDh7DeL
 aahxicHUcCPki7xgTFLPYOyPQxV8DHHwmSeIC6QQicLWjm9Ju6dLLriXeSo+vV72
 x3zbMes+TNcoYG7MWYSifFE41+cgeqroGTRtS+f/7CC7vuusA0ZB09nFCJJ8+8KD
 uPxQvA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1yqv0mvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca1f74cacso1162866eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517166; x=1783121966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU1ZEpbtsPiTi3Z1jYI9sf2PH/WmQ1kJvaxyrijgup0=;
 b=eCIj4SKtLytRGCaZ/jSrA+Guf/5lZB33F1yV+6jklbC9a8nSdLewdrMn3vHpy0c4JJ
 sCJWVlzt65F8WIr9yT6z+9RyrOIyRhs1cG/jou5qfQAXYu1yYY3iki/yW9qf+ghU6Bxg
 vVdZMPJjA41uYvRwILSNJhgs2AgPFgDsfCU3d6kE9f5TztSVRsoyv9aZBIa9ScYYFsOE
 UNIFCiNN15CA93cgaUW4+KV5apfUt26EZP6zGm9aMI33bKLi84lBBkyR3CzuA1aDpTlI
 5Yt7pO9WTxi9L/D/6QTQUJdHnTwWQa6Tf3GhodT0HR3TV61Ff1un63Nk+b5rRvI+szLs
 fAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517166; x=1783121966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sU1ZEpbtsPiTi3Z1jYI9sf2PH/WmQ1kJvaxyrijgup0=;
 b=SMBjyMZaAGKItg4oZu7E+fFXn6+n6E5faPkDFVEurNBk5wWfLZYojDZmZAqhJrHa/F
 5Spnp9qAtMuWMWCvl0/EH/7aK6f7678dzXYXPm9G00k/1HAI/WdsPxs2ABuYK0aM7HxQ
 4fNN52ml2skuMR8DiQnE3t4hKWK92J8endizblx6WZ3TxcqJT4L4nyoDMq/qkAKMLO7A
 NoydKl7HRAdKci1M6a7E8fvdCqn4BlOVPkKSx4EzzEX7YhokZelAtTxkbAuDjT8E+Lep
 SLDHGBOx/KAHRb6SVMQ135mEk/gN+hEKtVpObkQ3diz6VrbFJHEc8pi5ob4h6k8tEZld
 z9Iw==
X-Gm-Message-State: AOJu0YzRPEKKdCRD0QOzbef1QlMwYsvw9KJTUWeyrvSxnn7u3RNjddX5
 mrj8+PLfcstyLUfzOYVly57+BxBzDCr5sQERV0YWAV++lEFFGffKxfyGAy/8nGCoyIstXT+PVbR
 fD9rgiIZTyIocdMHMh5PvJ+TkQXe7SzCVe9qPXBMW7Wzu7cmS3/3Y/DDmmEdrxS8WYA==
X-Gm-Gg: AfdE7cl26En4O+/tfh7fzL/GC6U3UdRtnavO/Y7FK0Amszi9HcP0Ar/KEwnqN4CMLdn
 y3494FpsBhJAps1XO+arXoVph41DPjNN/EBm7gPCBx8gPkt7NVdGouhQl1mA6t0bJXSdd+QO4eg
 ApoN0Xz9SNzgKeihogKpaXBUaLpuwLACG87FGxG2aW/CIV9goqJ6m5vfz4VvM/FFvGU4PvcTwSM
 GNZUvEjb5NoJhdd1oOXdgo2YNSMLdGD5s3pjWeHElQGCQbUAK0JdNl7ekCXM+v1Snid3FFHF3ZF
 6nkEwgFVIKRCLMbCSWUmn+zv3G95suOvvb+gGSXE9csamLcES0Ga19ehi14xG4xtdHM3vyP84Q4
 ycTaLn7GxrdFQTXe/PS+G2CvD7GznRlcuJPWil1yOOi0p/IxCdmS0hTuRUv8/5lHDchAIqt+wAr
 JrDSnCNA==
X-Received: by 2002:a05:7301:644c:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30c84bcdacfmr8052562eec.13.1782517165971; 
 Fri, 26 Jun 2026 16:39:25 -0700 (PDT)
X-Received: by 2002:a05:7301:644c:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30c84bcdacfmr8052543eec.13.1782517165450; 
 Fri, 26 Jun 2026 16:39:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:24 -0700 (PDT)
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
Subject: [PATCH v2 02/37] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Fri, 26 Jun 2026 16:38:43 -0700
Message-ID: <20260626233918.158740-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aoiCzyZV c=1 sm=1 tr=0 ts=6a3f0dae cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1nAYMaIFilY67gu1o-kLlHlV1SyLppGw
X-Proofpoint-ORIG-GUID: 1nAYMaIFilY67gu1o-kLlHlV1SyLppGw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX0N78sNArWDkT
 hSu4dC20e/0TKbSBtLnd3trIDl4QocN81hWhoGjyOIl5gd+vhgC533aFkAZbSqIP6qjPOAKFnQf
 4pY2qK/455uRhF3D38l0L/sf1hhsEiw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXwLjBrhHU8eV1
 fKJa9Uk1RwZraPBrUDUTGdo18B/lz0Zvv7AS8Rc/baAcwqTG6mV+0XiWqA0+agkZuujkMeTaYCf
 wK1Nxlw2wndRts5vVF5X9vs84Csl0JgqW9Sna6IFQc+pxMXS2KXg9kGqgQM1wqkCJvqt660pdKc
 zIRYybXWr8cO5GFF3u2pCXhBSTdWMs5a1DqdH8QyINQqiX9pLykIeQNT8zkPpkLpku6ptizt69r
 TuB1ZZshN4GeiuaQuFa9qzCRtD+JSEnGFOM6ZlrdpA6tPPCVwC3uDgKriYCFItiJQQbcjilbO/l
 20xZZjazFfpicDxxdv9/fdWt5z+DnaC/7rcmI5dqCnyKrzHH7f5GbrOYXLt2eB6jyYih2WBzsck
 xvGggSMNzwCMIvyo/dMpsZdlisQo7XlFoJmPjqZ1JLdB61lBBSzdLX8c2hvRFLHU8ReXsXW5qiB
 U++a5eKBAA69PiNmG8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target           |  3 +--
 .../multiarch/plugin/check-plugin-output.sh   | 22 ++++++-------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 508149d57bd..f46983cc76e 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -211,8 +211,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
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
2.47.3


