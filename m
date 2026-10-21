Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883D1606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kTAJaVRo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eiFauAsy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpp-0006Dp-TM; Tue, 20 Oct 2026 23:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMoJ-0004Ie-HP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMoG-0002pL-U7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F3uJ3256728
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TC65Z4oOuG7Jg7V28F/HsbLF9AfJKPs6Sr9yiJLdycE=; b=kTAJaVRoZBEy2tQZ
 F9YXJARIkfOM2iX+t4Qr2rRd0eWfP9jIes1aSsHD48cge2B71ucAK3fBpqVvZCDf
 SH3o2fKpxGYC667NS1oPulvt9/pcfVOdZy7ejBPg8DK/Zj7JddRw1J7zNQKsCAE7
 1iOJSMzBEAnMfP2vKdZ9e26KvcbarMMjH64DSCr5cmr0P9EbdOnzeR2H+e8CniAu
 Puk3kQOz8VwPCTafOPZ3un+22XpaNDmVbkbrnY8J6HM434PJuQT1RuKStFpaFI7e
 xjvHWrYsSsh1kjler24swzEB+dTkViWxtaNk1eqJ+vWQF4gJBBDYm8keDlTHgzhG
 1Ol8kw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v1rqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so67028385a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552561; x=1793157361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TC65Z4oOuG7Jg7V28F/HsbLF9AfJKPs6Sr9yiJLdycE=;
 b=eiFauAsy04jB0bjEKsMSRDBcZ/JzyncYnSK0Ul8cMipEREJ7wj6cm1Z4hYZ1i0S/u/
 kRgOsgOGFeRYwcm/s7D9nZWl18SAUWHG3r/5BypAdvA0ASbobOyN2XYiajXuE72FTPdO
 lq02tQVX00uQ7cZQQrGkwiIHWtI+vE2OG4Bac+EHxCZvhbruXtsEynsLSn3c9OR+HAOn
 p/bRHYgmTjFr5LzwmjouActZnul9Nrkc1/CBbzhgBKMqeampWLpBXiFRetHxcGik1+6s
 kRn9mPcnqP5nppn4Jr/9q41/K0A5OMRKaBRG5yCiKqTEqpYcOzYHff05ksdjbG5d9mU6
 6yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552561; x=1793157361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TC65Z4oOuG7Jg7V28F/HsbLF9AfJKPs6Sr9yiJLdycE=;
 b=HTX+7iXR5gSE/5VVbUdt5r4uPKBlvpkTxmkZ4v+p9keeG1MxPjf0GX4bKiyb0WEIno
 07n4rDVIJIxVNGXMVbZ51uPLuJpPuKmtd1yjTuhKuQgxtFt18Q9M1oXikwiQr2Fy1o5v
 GOcj+k6nYomhBCjPJ2w62snMWN0O9cjGkXTHJXkOHUGnPGAIokknZyX9G2kejtbHarR3
 W6VfmAL1IS3jkaTsovwo3X3YvHINOBPUHs7V2GDS02cp/HwzRzOp208/l/PehwFSOVNw
 Xo1tn0zAyR/3AbPYQ8UwT/knWFx1WLn5Ccwh16eoi7Sornawkxwwqebri3vM6qae5csl
 zdLQ==
X-Gm-Message-State: AFq9FYLhhe7Py1StSqlCDsvKe5Z2ZGfuJEufNFbwJh68SwU+8R6iA7ug
 Bftf5o+FiknnzVUUQOei6P5YKLm4Ex99mRwm/lffqIEgzUIwdM7X+rw4IIAAJtDmeqBkWGzZTRe
 eLiS0d1MmgNrjmjVnGmW/TgyNHb/ukxZSQkQft/QCVHgB1yKdWK2xoOOupCxSV7bdhxhv
X-Gm-Gg: AYBFou29Ng2Cjl6e+QGpz94xK8Tn2WsUwNu+ndu/PiExUBWF0aNMq2A2v2eyFysWpp2
 +vXbOiEJEXtY7kaZr1ijferS+DLvT/RkLvUxrna43jBqopouIxWAfEvnkHlCmPWrVkYvH/s6q2N
 D0QMZmwg1Q9Ic/dXZhTAyVmA92GENTfb7tUw5S+eT+/Z5+3Mx7JL3fUod78zU4n+2JnYKcgjHsN
 tTaPH7F7wQVSg6Ild8Zab0LrPT+W6q9a4c0VkY1HuBVFx4DP6qevTJb8pr/mp4gdGTdr00GLRUH
 JjtIYrqKXzj2bRhi+lTo4BU9UnycbgLkAov5qOGFNItI48Lj5wtPV6+uvJTSX+NCA3FSQfegMSQ
 j7cn3hsBITLiqPS60e2bQEREL0jboYKxCfhKK/46v
X-Received: by 2002:a05:620a:298c:b0:93c:7861:675 with SMTP id
 af79cd13be357-93f4c195b61mr679498285a.1.1792552561211; 
 Tue, 20 Oct 2026 20:16:01 -0700 (PDT)
X-Received: by 2002:a05:620a:298c:b0:93c:7861:675 with SMTP id
 af79cd13be357-93f4c195b61mr679496085a.1.1792552560739; 
 Tue, 20 Oct 2026 20:16:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d41c8asm115894385e9.8.2026.10.20.20.15.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:16:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 14/33] target/m68k: Use a static table in
 m68k_exception_name()
Date: Wed, 21 Oct 2026 05:13:47 +0200
Message-ID: <20261021031407.24862-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXxc5rtaruL9rs
 PPYI2UsUZBOhigihoPsMexsxNuHDix4+nlBXf4w7Rx19WMBqmQz8UvjTEoCm3umfXEk2XfAdoUQ
 cfJAH9GhhZRWJfKUFO7KokLupHfsdZE=
X-Proofpoint-ORIG-GUID: VfezB6FCiYLXYL9ADUoYLp0Jz3rH2878
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXwWUxGiXYEWDa
 tjjeH6ngdUjusfxvuiv3gbpXkr3TxmobigWrkiMfqosrNd+noZfowA24RlXjQAO1xgd/J6fK87X
 /gPf/8+I9iyuhRsdtyF63dTF6DMK+13Z5LRLF43X+lS6GZd7Knq7uAz18QKJ/PxJNU3GrG8WUe7
 gjRJSeieh8vxWoTNFEiPjdRw171DokdZX56Q/doVIsmGGIdStghawISE5qaf4H8jz9lmMQgk0Ks
 1SnQO5lCwRSJBIWWOvwiD9N7TUt/n8stULtuDeaZkPxRpu+BYvxlGtJKwFkJ13USSEWtK3B9jbZ
 j+M+3U3WwP6tQY5A1LsCqXF9ThkXXopf2wmDQZRuUIKVNj6skFlBYzqtIxEyZqjWjevfsmE6y8Z
 CUpIpBpOLdiGc/j5UL+sPXHeVn0VM1kwEC0SWX3zgW/y4M4QVwiBz5GHviFQ5YTA0Wk+WVKkk0e
 /tD97S5RO8PEkBVi9fg==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad82e71 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LY5oDNgcubN9BrCfni0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: VfezB6FCiYLXYL9ADUoYLp0Jz3rH2878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the switch statement with a static lookup table.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/m68k/op_helper.c | 152 ++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 99 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index c600f83ddbf..6a4eafddb31 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -84,107 +84,61 @@ throwaway:
 
 const char *m68k_exception_name(int excp)
 {
-    switch (excp) {
-    case EXCP_ACCESS:
-        return "Access Fault";
-    case EXCP_ADDRESS:
-        return "Address Error";
-    case EXCP_ILLEGAL:
-        return "Illegal Instruction";
-    case EXCP_DIV0:
-        return "Divide by Zero";
-    case EXCP_CHK:
-        return "CHK/CHK2";
-    case EXCP_TRAPCC:
-        return "FTRAPcc, TRAPcc, TRAPV";
-    case EXCP_PRIVILEGE:
-        return "Privilege Violation";
-    case EXCP_TRACE:
-        return "Trace";
-    case EXCP_LINEA:
-        return "A-Line";
-    case EXCP_LINEF:
-        return "F-Line";
-    case EXCP_DEBEGBP: /* 68020/030 only */
-        return "Copro Protocol Violation";
-    case EXCP_FORMAT:
-        return "Format Error";
-    case EXCP_UNINITIALIZED:
-        return "Uninitialized Interrupt";
-    case EXCP_SPURIOUS:
-        return "Spurious Interrupt";
-    case EXCP_INT_LEVEL_1:
-        return "Level 1 Interrupt";
-    case EXCP_INT_LEVEL_1 + 1:
-        return "Level 2 Interrupt";
-    case EXCP_INT_LEVEL_1 + 2:
-        return "Level 3 Interrupt";
-    case EXCP_INT_LEVEL_1 + 3:
-        return "Level 4 Interrupt";
-    case EXCP_INT_LEVEL_1 + 4:
-        return "Level 5 Interrupt";
-    case EXCP_INT_LEVEL_1 + 5:
-        return "Level 6 Interrupt";
-    case EXCP_INT_LEVEL_1 + 6:
-        return "Level 7 Interrupt";
-    case EXCP_TRAP0:
-        return "TRAP #0";
-    case EXCP_TRAP0 + 1:
-        return "TRAP #1";
-    case EXCP_TRAP0 + 2:
-        return "TRAP #2";
-    case EXCP_TRAP0 + 3:
-        return "TRAP #3";
-    case EXCP_TRAP0 + 4:
-        return "TRAP #4";
-    case EXCP_TRAP0 + 5:
-        return "TRAP #5";
-    case EXCP_TRAP0 + 6:
-        return "TRAP #6";
-    case EXCP_TRAP0 + 7:
-        return "TRAP #7";
-    case EXCP_TRAP0 + 8:
-        return "TRAP #8";
-    case EXCP_TRAP0 + 9:
-        return "TRAP #9";
-    case EXCP_TRAP0 + 10:
-        return "TRAP #10";
-    case EXCP_TRAP0 + 11:
-        return "TRAP #11";
-    case EXCP_TRAP0 + 12:
-        return "TRAP #12";
-    case EXCP_TRAP0 + 13:
-        return "TRAP #13";
-    case EXCP_TRAP0 + 14:
-        return "TRAP #14";
-    case EXCP_TRAP0 + 15:
-        return "TRAP #15";
-    case EXCP_FP_BSUN:
-        return "FP Branch/Set on unordered condition";
-    case EXCP_FP_INEX:
-        return "FP Inexact Result";
-    case EXCP_FP_DZ:
-        return "FP Divide by Zero";
-    case EXCP_FP_UNFL:
-        return "FP Underflow";
-    case EXCP_FP_OPERR:
-        return "FP Operand Error";
-    case EXCP_FP_OVFL:
-        return "FP Overflow";
-    case EXCP_FP_SNAN:
-        return "FP Signaling NAN";
-    case EXCP_FP_UNIMP:
-        return "FP Unimplemented Data Type";
-    case EXCP_MMU_CONF: /* 68030/68851 only */
-        return "MMU Configuration Error";
-    case EXCP_MMU_ILLEGAL: /* 68851 only */
-        return "MMU Illegal Operation";
-    case EXCP_MMU_ACCESS: /* 68851 only */
-        return "MMU Access Level Violation";
-    case 64 ... 255:
+    static const char * const excp_names[] = {
+        [EXCP_ACCESS]           = "Access Fault",
+        [EXCP_ADDRESS]          = "Address Error",
+        [EXCP_ILLEGAL]          = "Illegal Instruction",
+        [EXCP_DIV0]             = "Divide by Zero",
+        [EXCP_CHK]              = "CHK/CHK2",
+        [EXCP_TRAPCC]           = "FTRAPcc, TRAPcc, TRAPV",
+        [EXCP_PRIVILEGE]        = "Privilege Violation",
+        [EXCP_TRACE]            = "Trace",
+        [EXCP_LINEA]            = "A-Line",
+        [EXCP_LINEF]            = "F-Line",
+        [EXCP_DEBEGBP]          = "Copro Protocol Violation", /* 68020/030 only */
+        [EXCP_FORMAT]           = "Format Error",
+        [EXCP_UNINITIALIZED]    = "Uninitialized Interrupt",
+        [EXCP_SPURIOUS]         = "Spurious Interrupt",
+        [EXCP_INT_LEVEL_1]      = "Level 1 Interrupt",
+        [EXCP_INT_LEVEL_1 + 1]  = "Level 2 Interrupt",
+        [EXCP_INT_LEVEL_1 + 2]  = "Level 3 Interrupt",
+        [EXCP_INT_LEVEL_1 + 3]  = "Level 4 Interrupt",
+        [EXCP_INT_LEVEL_1 + 4]  = "Level 5 Interrupt",
+        [EXCP_INT_LEVEL_1 + 5]  = "Level 6 Interrupt",
+        [EXCP_INT_LEVEL_1 + 6]  = "Level 7 Interrupt",
+        [EXCP_TRAP0]            = "TRAP #0",
+        [EXCP_TRAP0 + 1]        = "TRAP #1",
+        [EXCP_TRAP0 + 2]        = "TRAP #2",
+        [EXCP_TRAP0 + 3]        = "TRAP #3",
+        [EXCP_TRAP0 + 4]        = "TRAP #4",
+        [EXCP_TRAP0 + 5]        = "TRAP #5",
+        [EXCP_TRAP0 + 6]        = "TRAP #6",
+        [EXCP_TRAP0 + 7]        = "TRAP #7",
+        [EXCP_TRAP0 + 8]        = "TRAP #8",
+        [EXCP_TRAP0 + 9]        = "TRAP #9",
+        [EXCP_TRAP0 + 10]       = "TRAP #10",
+        [EXCP_TRAP0 + 11]       = "TRAP #11",
+        [EXCP_TRAP0 + 12]       = "TRAP #12",
+        [EXCP_TRAP0 + 13]       = "TRAP #13",
+        [EXCP_TRAP0 + 14]       = "TRAP #14",
+        [EXCP_TRAP0 + 15]       = "TRAP #15",
+        [EXCP_FP_BSUN]          = "FP Branch/Set on unordered condition",
+        [EXCP_FP_INEX]          = "FP Inexact Result",
+        [EXCP_FP_DZ]            = "FP Divide by Zero",
+        [EXCP_FP_UNFL]          = "FP Underflow",
+        [EXCP_FP_OPERR]         = "FP Operand Error",
+        [EXCP_FP_OVFL]          = "FP Overflow",
+        [EXCP_FP_SNAN]          = "FP Signaling NAN",
+        [EXCP_FP_UNIMP]         = "FP Unimplemented Data Type",
+        [EXCP_MMU_CONF]         = "MMU Configuration Error", /* 68030/68851 only */
+        [EXCP_MMU_ILLEGAL]      = "MMU Illegal Operation", /* 68851 only */
+        [EXCP_MMU_ACCESS]       = "MMU Access Level Violation", /* 68851 only */
+    };
+
+    if (excp >= 64 && excp <= 255) {
         return "User Defined Vector";
     }
-    return "Unassigned";
+    return ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "Unassigned";
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.55.0


