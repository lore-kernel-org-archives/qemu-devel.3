Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B2DCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxn-00084t-98; Thu, 01 Oct 2026 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxe-00081O-8D
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxc-0001mB-CP
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FtNec2688237
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oe8Apjz2/dXAyqexQa3BYy8WyaeQtxWFXYFKeOY0scI=; b=fK3madeFNDpLx4GV
 o/F0vKlS2tf3+P5owREmvqenLuvGgKWO//VxYqBuwwrkQBVx17JB5lPCrSsc31NF
 5wCzu0mIeRyca4bxjhT+V1FyAODUl3Ta8HaInE3xV+qa/yuvaaONDUn51X0Uey4i
 qN3melzbOxu1ORwk2wPdh512z3NpJt6fNoLDtZ8lW4VTrmDEL/L5XosLp6/+0f2i
 9IL2EWUlCoVndjmea25R1MfU5b050XLd6FcWczPuPKb0O0HnHSEG4ybnfBpBv/z1
 SvzeRFHPEmM9wdkhPJfs3cq4IDpim8lAmTJ1k6X3AnHjSqZtu6BHt0AUWuqFvp/P
 Gn98bg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8nt4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:37 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14a62326b51so4515894c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877156; x=1791481956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oe8Apjz2/dXAyqexQa3BYy8WyaeQtxWFXYFKeOY0scI=;
 b=QS/AmrIj0D/TRL/bMfjNpH/ps9BYQJlZ1vdKQNBtSvAAIsCnfSwUW6Thpk8tQ6HflS
 BhfuJg1ykMVr7rzlMUFdpj1BbU38I/aQf8SqF5vNYwq4BUr+V/vjhcbDXZMHMZmjbWrc
 6HUj8sz+e/r26Af4bM9n4NFRCp2BIyChzLXdRxQ8ciSYwUyWy+ZC/WypibSCBD+cwajB
 fMk3alARrzPUecioSe320ayi9qjBg/07BWHYbEWOiqlK1XmnKApVwsfInEN5wXYyric/
 NywAy5IanjD3biH9s8nyybAzVNAWlU1pNzMm5nWr+VDoW0EJlOdf10GeyZ2gsG+DWzUm
 C6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877156; x=1791481956;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oe8Apjz2/dXAyqexQa3BYy8WyaeQtxWFXYFKeOY0scI=;
 b=HitM0Xh4nJvGGXpb49cPERQSztI+m7bGVkWMgb7ii5HL8RrEhFl+zEl/I/Vhss9zXX
 mZMHm5Og3UvbwTLKhJTfD2oR5cEnOR4bujet2PlW/Cd5An3pk7jjA2UXPIjWpCwL5jhR
 GW2NsCmUo78hwlLLgF2CPS549PmItPgXqzdOKYQoanrn32wfysfCIP737KLPmRfriqqc
 O5+mZWZWcTO6PIMEq4Tqmi3Qm4XMLGWs6nTgYyjcv0EGqHLjzn+qvVNP8jlNeFUFfwbE
 YtvcKkLLnGETMBjaqgFrOcF1PYEwlY8Ffy9iTO1Ko7XAygNPqFJpsHhf2qLmIdfwEar6
 B+RA==
X-Gm-Message-State: AFuF++kCUHvF91oDcn8IbC7QNqzR4k57w4fYSczk7ZBe5XhZs2bSqVNE
 1+eTjjAOqVY5fDFMxkX5VHwxNcHvIkotP7A51NHsRo4BWlS1NVPN1LrU1oUMNG1CP+s45XgzKTP
 XCJsh20sky5gvdFGLn+IaGK9B5Lpc6eMqeGhem/mv/M01rZbT0rHmrhOjVRuuH1Nx4A==
X-Gm-Gg: AYBFou2rKHu7bfETNqos2G8/5C5Fw5dFDULNAxAKiJdPA7nY2DtRXfaF4O0hxz20AoJ
 IKGmeYXRLCefDV3Lj9MGv2ejO2Y1DNjyTT+IV6u5eo1XuqyioJIeyXcN0NrxlWYLNIrfFPkMG1C
 N67CtdumcWJXcxDfu3i7KhI2etOWCYYF1/kM89GXJS/UvK8mdE0AsHnglU9NfgYh4NqXYtcCCEv
 x1Idvr7GfzVKVOPxL93mg0WbiXs6CreY9X7iWtzF3R67W+aUjbZr2Gjl7oNc/aPnyTpP/HEmJzl
 2e1RkIhlGcnzFOL4xyKtvRupfDyQ4xhC4MYULFKYQOqKxlCttO5SUWckmHTQEQNL/sp4LSFTi4R
 cow8LAXT+Cv5kUgqcYLUhZG1ZSC/kWG8hDtYTVDKrWq606pQmPgLY66KZIsZc
X-Received: by 2002:a05:701b:42d2:20b0:14a:51c8:ea06 with SMTP id
 a92af1059eb24-14d331aa8efmr5373267c88.29.1790877156300; 
 Thu, 01 Oct 2026 10:52:36 -0700 (PDT)
X-Received: by 2002:a05:701b:42d2:20b0:14a:51c8:ea06 with SMTP id
 a92af1059eb24-14d331aa8efmr5373230c88.29.1790877155666; 
 Thu, 01 Oct 2026 10:52:35 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 15/27] tests/tcg/mips/include/test_utils_64.h: add
 check_binary_op_64
Date: Thu,  1 Oct 2026 17:51:51 +0000
Message-ID: <20261001175203.8673-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX+4wSgLvjee9F
 38kgmNjnr+qoD6X4UL1uyACIrjX5fbb6nTBs0j3tYGsLahxrAZ1Ego1GOYr88Cw3IREs59qTGyO
 CWsw649uko170G7obS/41IcblKry9dM=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9de5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fjnl9vzf0ToXMKjLauIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: hlgmpx4ytZmUTHyulkJMY-qC6MiMkl_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX9bVwHLUsW+Q7
 DNvTYd4t/vloD0BMVeC803MRL9oM/i9ildFE8eBO6oefIBphA9GvpbQhrwkADOR1SX3U+59hJ+3
 pUihZD4Y8qJrF6z+TLaDrbHio/UgCF2Oi5XtjRKGXu/Y41mHet1SinOPXdzLuC2eor/xYmSAqG3
 g25FlZEAlStagwMFZjXpESaXDIBVYr5XQn3L/omrM2laFAVyHMTw6M8M37vaw+HHACoqmzZW8Q+
 EkIYcmDyn1kKjWe1L3oTPVZnPrRAecZ+CCbU/NvztjGcLPSYWKVSyZKPfOfj/lMLVeTMKL0W3ew
 G0Sk/tUUNU5KVYX0j7M+sLu/mynUHvi7i63/rHICgEwkVphNSZbIwykFYzz7Uhs5q41jf/jsyYx
 S8UAaX+cZaMtW6fW+7hMZtJ/d3Xj2JOCa54NbE7zNfqnVodHVJYoV+aNaLndttn29eIgFDagnVw
 JzALPXrb8fV2HvlMoOg==
X-Proofpoint-GUID: hlgmpx4ytZmUTHyulkJMY-qC6MiMkl_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-16-pierrick.bouvier@oss.qualcomm.com
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


