Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D050FC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPB-0006Xk-9e; Tue, 18 Aug 2026 15:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPA-0006XN-1Z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPP8-0006Wv-9A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGeV21517999
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=; b=L2Js5gTCcznM1JGY
 LFq5sbWxxHagSfeNUTbJRtyMC4ZWidTBSYPWfQTN4rS1NcyPNQ87rNBaBRw06Hne
 nBDwfEwhPHyPLewczOeyZVrawXp7bOAIio7Nyhlh8uk2bXuD2gTGVv3ZHRyFYF1p
 nydpCMgm+kT9I/YEhFeqZK2phbZcR7PTb+D/96iS1KOqIyJY19fLBMBVraCWdO0u
 zUKtmEAvK9oNalZ1lsKiB5zF0NGOEMkVbKgLSLBEhESoQl3mSvJitnneXTbk/PEs
 fSua0ytUyN8eJw3r4q3/+rHppvEKU+BOYutQ9YOsxpnseyGEgUqvY1a/lPLd8tNY
 sVsV/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0nbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so1448238a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081000; x=1787685800; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=;
 b=ULjueH+bjD196mPgU9259vPIl0x1RXQXPhjypI9qeHIRTYK3Jl63GT6mLpgTbIFc6T
 UJTxR6KkPgeuY4ZuDWls4oykGi6ErWV5BpriBNHLfSwNSE85TA4jwvfl22zL/DUWMmEs
 uJ13enF3AhOU23ZFDTNOkb/m05LwHalv9UHfRDMmLAr+77KxXKB2UhUJhlmqkAOV0BBr
 Ge5/WDHq/fQMT5hyVZ7IlaHVMIjgK06tGN2az6mZ15u9eOpWa8WPkLc/nZTaFqib5hoB
 5hDNcl8uOg4StTDgQkIjHlfTPQmTsNWpMg9UOzwyq0kO+kyLKdS+qo4aLqfcDsYbMRNB
 +Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081000; x=1787685800;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z54zZoMfGQjMM7A5kOsZQEvrgLnP/0d7CmURPbNg9cc=;
 b=KsqWEcuqLG0KCWLNaUPGNd5GHtQFlLnY0GF9avjg+NPzXJaSio6j7b2miD8YJXhdB0
 FX7n76ACZSyQZc6pxtif1+tF94RHEiODCeNmXR8j8btEHbdG2Ykxvk7ZWTMRBsnsoGTr
 gODjVqRld42plB32uk4DjO1pLry39VV5hN7noNIPIsfIG2J0vQ6VSjiFaqHne6muEEHs
 w+xkIh0A55J1XDLmiOTE6cbHR3DO7J+7dL9UCC5K4/UqOIX0VGgAjuCl3tOw4rOgmAgl
 SqMItWM3H7qxBemZDCcGze48MbzmrBYbWZhDmlYoLSIj5JSWxw1ntUfw4Bl4UBhLNEDW
 d6Hg==
X-Gm-Message-State: AOJu0YzUr6FLMALrqxt8ViZ+lfzh6i28rQtl3ief26Gr2VVJ1YLhdcht
 VZwepAxvRroNNpbILc/9v3WAaNkFlk/gLjGdZvx7YV3UEwq0IKo7BicPvca6LppTF/eusG4xVQk
 vjoQ/wEU4JHYHRTZCKm5qjfaR0MhJb3ZC8aVhZb3xbKKmYQvGnmyJl5WfzG2aT4Y/0A==
X-Gm-Gg: AR+sD10BgszVzdRlXaYBirIDqfKx2oQO57KkYQhm46OkbjQOGRRe+a8+ZNpbFIS20oV
 XxPF72tGYyWkg/6aBFS23GWv+EiNFBTeuZuaY/P2VP9xy2qhqnmKgNDpNdhGn0yeVPtAVL9LWOj
 aPotu36HWkT9GPDFRmZI4xeQNngxeMjH4OwsV+nWEVVBVawndfIhYu3mz5T0w9ZwjpHUUdIlbfo
 Z2lPVlEtf4lIzwWDigEZHOP7Sn8+Txzpdn+yRrlUr56UJSidzqrwFb6zxQpzA4u3QFO3k6GbANj
 cHVGrYVyS1bEN/wVzYcVcZYcttTt7wXY8z3/CluVtziYqjtbaVrrOvA7LSg2I4Nm3y2yREcav1f
 EHOQcCYVAw4DtbQi5Krvj5h/MW2S2BNbTrqIc51vH68v/OOMG8hcZr8GsgpE=
X-Received: by 2002:a17:90b:38d2:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-3955f1d833bmr7823054a91.20.1787080999989; 
 Tue, 18 Aug 2026 12:23:19 -0700 (PDT)
X-Received: by 2002:a17:90b:38d2:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-3955f1d833bmr7823001a91.20.1787080999546; 
 Tue, 18 Aug 2026 12:23:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:17 -0700 (PDT)
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
Subject: [PATCH v7 002/104] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Tue, 18 Aug 2026 19:21:26 +0000
Message-ID: <20260818192309.22169-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXy0LIoh5zH1Iu
 pyw2yOSvoszv5GniEGs/qX/ff01tDFQsSIDOL/Y3W2/epru9IVr7aYFXnDakHRh2RYWJbp9VeQt
 tFzbK+mad5KM206XJNg55FL6x43pyx5QdygLRm0mpCdZvJPHpek+Q4l6I3AD06ghXnyLER1HchQ
 8HRKNKrJq75GyIFMRfApJjg5DbziB8lfGhzQHMUwel1tJVYYIZXCDudEcuT9MVEGWKFow6vf2Cy
 PhmfMqK+m+Tz1X9z6rMJIDgUlqcJidbk+OIpNIWEGDMktiGZev7/BOmuBv+9SHHYnM1JuNwOzL8
 SRzo3XW/F5etIGuAXeRWjxftXh9Prus8e4RWXirfIGnF6bxDWpK3CKV6Bttgv+ov0AS7lsaBn3O
 Ue8WrbH18SjD75827C4B5MDZ30ayCOgfosHCclecWBBFHBq296dq+ulgu7HX0ah2UlAZcnY64XT
 B/bQs9ueY/8HrqS+RNg==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b128 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9E4pnZzLKwMjbVEL4aWB5oGXy_v9P08V
X-Proofpoint-GUID: 9E4pnZzLKwMjbVEL4aWB5oGXy_v9P08V
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6FrmBlWXfYSP
 4oetwMjHu02idPLcM5FzZj2JbRPk+6/VbmOHt07/v9KOSevoJNC9Sn7Z6UJqvYHMDfxjMVt++ls
 95iTZ10jfAIy4s8+PhyvU+qnK2HHUcw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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


