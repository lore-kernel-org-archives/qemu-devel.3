Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D15CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKL-0000Ts-9i; Tue, 29 Sep 2026 17:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKI-0000NJ-Um
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKH-0003sW-68
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THld7i3300565
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o6bGPTqyCNfdKMep7K6EPX/7kLSzHNVssI02SznINZA=; b=gyDTUhLBJ3QRKGDH
 xPr+tA9dcDsernn5Bpe10zKjEG90BHZJgybzB50lXGxKj++rMrhBQuiGLbO65XcK
 pxA0ULl7cRisBrMwMJQfl6+sp56DGEOiY8WRzLyThqLQKW1qh3W6GJldzf2ZZ0Ex
 CnHkYAmuNp5DaVz42VTMBiCqRxSDKqgGNWZwqdWGdzscTa+ME45RQ+fhgJbLyL6s
 4zVtpLSxQJuqyJS4cxKeE274SIOuujLA3lmetz8Dhh7k6HlX/16sZOBV1Lb2INgT
 gmoq5Uv4PZFERDQArX8bvjIjkokckzWWfK4m/6vAZvZEydb3btpp3zaWgXt6mh33
 YpDspw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx27p9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-342a0e1d8c4so4468944eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717123; x=1791321923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o6bGPTqyCNfdKMep7K6EPX/7kLSzHNVssI02SznINZA=;
 b=ZkXaFf9KlNYV8f0SMypfdnNlXsHQRNzcXvSf9WC7Ty//2Wv84/SRTogsTifgK3DmwU
 UBIsNr02qlIT1t2S8vcb74i01iTOwLH1NkfUQHkIEmT3kVtoZH8CiRUAx6cyGT42rdx4
 xYsbqQ3RDytOJ6efCMdI3hQc/vfnpa4mxpeX5lArBS4srcRSsiAYAfJuxKa7iB6iniqU
 CJ2ZjIqCIeEmDfM1XA+dd1pui5am5qP2Z1Gd3sraTq0HLgkoIK8FLVhtg0KDmD+6T8Vi
 9rR9BkuQVSMxcuRn3/RBVOXiLQgMHxpbJtE9rOD/NJysPkS30VRD+SVDrPczzC7+wIGk
 rnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717123; x=1791321923;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o6bGPTqyCNfdKMep7K6EPX/7kLSzHNVssI02SznINZA=;
 b=OSIr0fs0HJQKEq1fsBbD+wqkojaIiOLpw/zICN+GiFAanPZuEJ5H4Mpx+THdcIlq/d
 ij4rdDiMncUTnmwQkDrEz7riZwx5zBrCryyGLh/YVQ6GMOJ7zK9PTTzXmnnON43+10bb
 r1+CNoxYPkUHWDVv3iSuSI9keONqKCRILie4Emcsus+kdqWgcykoVoihT/l+na8O6sfr
 V5ot4nuXB/NK/CWGQfvHBwPFm4Ve/is/9Tiz31uMoHqAWiX4x5EP5tznHT9uBM1PFzMO
 TXVVi36XNHnmEzvK3bjeP29RR1b2TznGio1d9dz2ynz+L74dC1LN5jtAuOZCE7QVUKDP
 VnmQ==
X-Gm-Message-State: AFq9FYLqhIej9Ega0M3QcrXxkmSD0vLgA8V/Hl4ODWpkyWJNJpgUvwc0
 UJSRv8P/cXufNlVx0CTZowzBNkdYlr1UkkoZ0AYphCJwxv4yN5MCZrcoZa2FKud3rIZj6X3NSvG
 FC7hyKm8sVwCvrX5OjhTxcRqK2ndHFhqvkwLmqKZNLlzL4Keq0gwW3Fdal9lEvqCB0Q==
X-Gm-Gg: AYBFou3ldLWU75hEh/GByL2fdGlCP5dkH+4nfz2oI5d+MPlvOYpK4oKIjGqrfELUbrR
 Ks/KYu3VuYBIclqC6supOeQu7i9ePD2tdPviHQ6aAv8x3yT2o79mLk0UWhOxk4wUNnyC/SM+87b
 9VmHLGIzT6rR8HCYdq9p3y9Yr1U3TDfQEaOLze2eotyDtfJfBTbqHs/VO6mPGpU86EosmMM54iA
 Y9UoSf66VGUvg9trCLgL2Wa1iygS5HaYVqGuCUmYQeaEPJR1B9vCLClIx+gYJJcFm+ybnAsgQnl
 WTS1lK4kdz5/zJVdywQg0E/k3URLYieHCzVlYjaOMddCGn4VT5GCv4HNuVUHSFpHzMZB8KqkFUe
 mkyGSYJQU7HTFVq9/9Sa5InZx5U7UqkNI8NclOaprWNbw7eA5+heKI5RBQgPj
X-Received: by 2002:a05:7300:f784:b0:33c:2611:1a14 with SMTP id
 5a478bee46e88-34c677c4b11mr699432eec.29.1790717122992; 
 Tue, 29 Sep 2026 14:25:22 -0700 (PDT)
X-Received: by 2002:a05:7300:f784:b0:33c:2611:1a14 with SMTP id
 5a478bee46e88-34c677c4b11mr699407eec.29.1790717122369; 
 Tue, 29 Sep 2026 14:25:22 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 15/24] tests/tcg/mips/include/test_utils_64.h: add
 check_binary_op_64
Date: Tue, 29 Sep 2026 21:24:30 +0000
Message-ID: <20260929212439.110454-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX9bxBuauGvMIe
 vd3mam1vX7Un4ziNQrJs+50zIqkAs3M7kV+p+RkzkxobrzYWlpGfq8oa86Qkpb+rGC7pcVBKRTo
 Z3lJ7skAlH3oxeGvkPLp24zLFf1/98febkPpw7G7qpbJEbGdsmis0tbiEmI4y4fbfAuNmIF1MQ/
 +eucjNo4juqUkt8fOM52xYaypcdAYUYvBgLrs37bOJX3it3kNf2VphVJrjqgl6elra0yfPdJ+x4
 w1GllNoaZCiXO8fDS65gDU1qYaODH83bCSlEtPUSgnGxWLcKF35IAddgbHiQejofPxqIeCXAErF
 Mf6xP6tNXxwIcvwtAVgpFd29cIAi+ojLKT/YlgB43ze6U3A0pyA92GrRFo/ZxwPbPlOTGio1VMn
 Fdkg4xdn3Lp0WP/tvwa+FiToBrLpg7uuKy8SuwMYSWT+Kc7A9z6FPU7NIX2pR97mQpxntdeOyZ5
 rmbyYzK9PiKQBnRpgfA==
X-Proofpoint-ORIG-GUID: WAwrmD3Yf3U6jTJP-Q05PC_kl5feZfBy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX4cLlu79/xwFB
 awmcH84YjDdWevmuahNVtijAVpoLJyYRhl8+qGekaJhzHLTrA1XN657exuYCpbcXUIXaAU8y1lG
 x+CzqQOoMrYxbpmYd/Sdj3SWPS52wKQ=
X-Proofpoint-GUID: WAwrmD3Yf3U6jTJP-Q05PC_kl5feZfBy
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc2cc3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Fjnl9vzf0ToXMKjLauIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

Each mips64r6 test copies the same loops, to generate an output vector,
that is compared to expected one. Also, input values are not reported,
making a failure hard to debug.

Instead of this, factorize this loop in a single function, and compare
elements one by one. This function generates a C compatible output, that
can be compiled on host to check that all values are correct.

We use that for the few failing tests to update their reference, and
check it's correct.

At this point, failing tests are:
- mips64r6-linux-user-test_mips64r6_and
- mips64r6-linux-user-test_mips64r6_nor
- mips64r6-linux-user-test_mips64r6_or
- mips64r6-linux-user-test_mips64r6_srav
- mips64r6-linux-user-test_mips64r6_xor

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_64.h | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/include/test_utils_64.h b/tests/tcg/mips/include/test_utils_64.h
index c9609d8281f..b785c26d093 100644
--- a/tests/tcg/mips/include/test_utils_64.h
+++ b/tests/tcg/mips/include/test_utils_64.h
@@ -22,6 +22,7 @@
 #ifndef TEST_UTILS_64_H
 #define TEST_UTILS_64_H
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <inttypes.h>
@@ -77,5 +78,44 @@ static inline int32_t check_results_64(const char *isa_ase_name,
     }
 }
 
+typedef void (*binary_op_64) (const uint64_t*, const uint64_t*, uint64_t*);
+static inline bool check_binary_op_64_with_input(binary_op_64 op, const char *op_str,
+                                                 const uint64_t *expect,
+                                                 const uint64_t *input,
+                                                 size_t rows, size_t cols)
+{
+    bool ret = true;
+    for (size_t i = 0; i < rows; i++) {
+        for (size_t j = 0; j < cols; j++) {
+            uint64_t input1 = input[i];
+            uint64_t input2 = input[j];
+            uint64_t expected = expect[i * cols + j];
+            uint64_t res = 0;
+            op(&input1, &input2, &res);
+            printf("assert(0x%"PRIx64" == %s(0x%"PRIx64", 0x%"PRIx64"));\n",
+                   res, op_str, input1, input2);
+            if (expected != res) {
+                printf("// error: expected 0x%"PRIx64"\n", expected);
+                ret = false;
+            }
+        }
+    }
+    return ret;
+}
+
+static inline bool check_binary_op_64(binary_op_64 op, const char *op_str,
+                                      const uint64_t *expect)
+{
+    bool res = true;
+    size_t pattern_size = PATTERN_INPUTS_64_SHORT_COUNT;
+    res &= check_binary_op_64_with_input(op, op_str,
+                                         expect,
+                                         b64_pattern, pattern_size, pattern_size);
+    size_t random_size = RANDOM_INPUTS_64_SHORT_COUNT;
+    res &= check_binary_op_64_with_input(op, op_str,
+                                         expect + (pattern_size * pattern_size),
+                                         b64_random, random_size, random_size);
+    return res;
+}
 
 #endif
-- 
2.43.0


