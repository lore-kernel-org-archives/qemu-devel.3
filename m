Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02357C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ10-0004rD-Q4; Fri, 10 Jul 2026 17:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0w-0004pj-1j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0u-0003N5-Bn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDdDO1811791
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=; b=GcLN9pnr42/IWqar
 Rehgip1PikAyhIdQm//H1/29TX54RTZQLOm/WlsxF/75NRk0tbhcbJ3fH9lyhGh1
 QTpGnGnjtt+J759CQtKS8ENvERIkUAtRAd1uoMEb1lH1wBifpViwB52gahycvHwN
 Gy+JcvT9E91Q6nSYiyW5NGyvlqt++UkI/8Zh625Vl7xWF8ihnULDFWLqGcOhS1U9
 4aHk51GVAu14u9MaQ/fY5Lkqa+H9LN190lwDCMcS5H9/NtBbLsncB3MXaNs7Jwpj
 pYCoQZthfHTAAOmeO++e/BW5393VPqsFyaFgYSbLds8RdsWKvR2Fiw3JO/LJzgwr
 F+2eog==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fahmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so2715356a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719842; x=1784324642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=;
 b=hNnglbdqZVC5kfuv/V5X6Q0YF7pj6iUNHuMGgsRB7KaGFI+mXmk3rediPfdteyr//I
 m+cnbw92Omdlp0Tty9cXtTNZqufeDHQwDJ162jKKhajxMzX+K7VbUtGUqGSdSycVCP41
 Zy7O3+7UUM7mulZtouizUnve2A2qTz6vLlhC+er3grGj4kEEs/HdpHEVmlNO/jeBTyo2
 hBG56RnGJlSimIt9ocebPc2viyDa+ySH5C8pnZPLltnOiBrQNlVkxgf5o7eYnQ9mbv8H
 mRhGypN2c6WegB+kXRl50mAnXSPtY1RtEkDY8JAIJlXh0n6kaB9ZNPAXuOIUaA9si03o
 X9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719842; x=1784324642;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=;
 b=mEmcBM22ho/CKlTiI20irwVhRmmUIihqDcyw0Ao6cy1Vmw+IKUEVrkp2b2ZJCPNErg
 yrBDr1ZdfrhbDcZUFuNPoA4sQcAcXzoi73laQ7eRdgebrT/cSYChetrDmuOtm9NQ6BrT
 pIcHtJue/3810A//wFVTGI4m1pjzhPwPsoi9ysI+t3hSGeO5HrPQsDzt+x+nwpYhWzgp
 t3OkxIfT88wm3zEEwYVADPdONZFKpe++peZMXSIS0eCF4PE3s2SazoYFK5B3CnEHS/Ie
 lhNa9EJHf3hZ4JoOOOxqGUQFOwqTfh1tdvZfWdn3tkG00R7KtR+Qrtpz0cBpOSbvMXw2
 OzWQ==
X-Gm-Message-State: AOJu0YxjwA0TzR2OPV8IeEaM3b6Ofjwa9TY9/ClANSrzjAo32xtDlPzY
 SF1V8XnLD4gfRakM1J1Z29tEnnN0Rf5fxpBGmx7aqavEsnXvcp1Hp4FURjsD02HuAChGxB0CuzF
 PLHldUlYTzDjchS5iAv/v8qE2b+dnXg2lIgt2RYS6aVHjX05sR/Rp3NfquvazH6cEtQ==
X-Gm-Gg: AfdE7cnZ/gNhqne9X1izUBF8QTS/ksU78G7fkoEgvTxizY2/ReWCA04h9lOE08DtK+R
 bZiw+9OhRS/LHmg2eJf8eUkp2ssxdd+6lDw6OvCCbvD3XA+OG3iYEboSOUwWsDr2a3oY1MCan9/
 1Q2p4CUXvjUhjU85yXajg+VWI/RkMsidhcOvCZRahEiogjGtUQDCi+8RUlzBliXDfAOt9nvv/i0
 AEW6GlVxX0r8axbazE0fmnxoZprLs4i6bzO3Z9Ta1EJaVE0nPxhNKrE3kafnLqMMr5Eg7Z4GDID
 ccPRiQ2vhtxj5lspdwIHDys4ytEdikAyGVkY8Ixnc+SEDxokBnVpw7ObiQtd3KYSDCEiT9Ogy9u
 AXy9nq/9sTi5B4v9Sj/SsMIEaQrhNzhmGT2KHazLroLmKubfIndSY682V3EGUbsrK/NhRf+Ey3B
 PRBFZ6sg==
X-Received: by 2002:a05:6a21:4593:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3c1109e034emr726176637.26.1783719842384; 
 Fri, 10 Jul 2026 14:44:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:4593:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3c1109e034emr726161637.26.1783719841941; 
 Fri, 10 Jul 2026 14:44:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:00 -0700 (PDT)
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
Subject: [PATCH v5 02/98] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Fri, 10 Jul 2026 14:42:06 -0700
Message-ID: <20260710214343.2065491-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a5167a3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7hp1HTRjUTOHumXdO82wekNzbBFhD4cv
X-Proofpoint-GUID: 7hp1HTRjUTOHumXdO82wekNzbBFhD4cv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX8ez0PJrhsuHO
 i2burks5kcjH+i2hKIOI1rx1ASnAo1P4CXD+sI5LnYFSZPvJitFg9ACHoawJ8AL/M+vLv9TDF/U
 Rw6fuHvpqhwfLiQoWZyvPLUhrkANbL4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX6QHcrhvpYyqF
 M1/d60KvsRnTEieYmt3dPRaJZkSazTv7MgWOxOIoLqcPtfOe5vy32M5GJzwDah93u4jroW+cm0O
 C2gca6AfQdI7YZKtQubGTFcfonumDh2touEo/7hYz82FaiPLENBhpAtt9TLP/nNF+kU9O107gPg
 rTUYIFgvgazkRiidxneTBj0KidRzYevgAbiIpWTMRHnR6AjJ3kgH+IfQ1Fl1QbWvu9XfvQrEfuk
 MuBZx692yRRHEG9zGEw19wV2aJmRinZmWCt6odQXHw+JolekAzTUbPGVDsWi7WY9VgcPM0h5/iT
 iBry3D5+JYvkPsCmQ4wrG1TImvPEyOL77CqIHaUdBC4HeN/PxbmV83hVcGwSW+R98mpeSsmYSX6
 Jzb4UMpbdnCwDR6X7CetTV975vOs/ZUmGNUe+SyA4F6hjadQziB3PgkVa11hU8SHA53W7fLooGk
 tdCCFaGYLHtMJpCd6DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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
2.47.3


