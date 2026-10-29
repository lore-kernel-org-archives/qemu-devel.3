Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1126606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nP0tB0Xd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ML4G4w5N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFF-0004c9-AD; Thu, 29 Oct 2026 13:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCB-0000RM-LH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUC7-0003yA-FB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDb363689749
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sOeoB9fydsBt2aRNppJOe5VYblXVPJ3U83LavNj5h5k=; b=nP0tB0XddNZYZGWD
 mQ5wpoKBlhGfng76UlZWM+d6Avf8cxqP4VI7iGGOktgd9UpMlpp1p6moueVfk/zM
 zvNKZdCvmoDcOdHb7nYSzyoDZkgaqzyK8FyHkPoDqqJkY/oVvsxPrUiuXBP2aO1O
 KW8MHfCyfXUSMQVlsggFxeJhv3Nv4cWhMmP9kdaVIZOvCLhU8IYpUeWbWcfBhigH
 /4hpeR/AnYPMa5wDkhauNzL0zKzQ1dpafKiJQG2P1v2I1lS3C31U6bVXsMR0QasD
 lT1gZl1Ok8bWTcd7kG1Tn6EsIV/j92/6W0pfLOd1HECdlDj/W1SQXjFTvKdce0jN
 NFOIUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sbhs3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1e62510cso576284685a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295942; x=1793900742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sOeoB9fydsBt2aRNppJOe5VYblXVPJ3U83LavNj5h5k=;
 b=ML4G4w5N5/Xd8rEqp2GZ+EefeNv5G4wV5C0OZrJpTuZsdhc1ThXE9G9QWUbuEafuRb
 dMIKNchOyaq74mNHp+0m64wBPdI0iuTu4rbC6AMQItFA3zpN2o2cQ6XjE3561uPGr07z
 7kPc+sTPRusMHdqIGBqZ+9FWYsG7oJbYSj0quIvl0beOvFLnfuGc52HKbQ63f89qYGxX
 M64ZNJOka5TQ7X7hzba1NbQpxQDTluxmAoBeej05e3qkL+tsshA/3dmfgTLiV2kALZp3
 bHHJv9f02PNxOaz21BBE34AyuOqYe8qDgBABppZJeU6x3K31D1UwTV2wJA1x4ue0iC5B
 nrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295942; x=1793900742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sOeoB9fydsBt2aRNppJOe5VYblXVPJ3U83LavNj5h5k=;
 b=SXHi1ZpTGFJtTUJ6TDF+J2yZ4eCqoZNku0NkM84PMV3q4FyeBXLlc/FpNxzuuMT8G+
 YYp/Dfc+wsCrQKr3B0ELlh/5jIrdHnGjXk/btooRuQlSLt0QpHwMHKK58YMQ/j5e7+5O
 t0rym9/lt5fSePU7GLcZC0M5CDLkDJQaCnABdhwxa9ENL6POIKEAdpj+7/EBtqZy6nQT
 dlrxBqn0y2IuXfUAVHlsLU3XViPLD04yPjH1hD7YwjaOWi1qdo9TlDUaFeoBlVwP0DyP
 2A/V7fGLrX+SHDFeSWj7Stn52PZaPwGcexlAlIdf6uyH26aMHoYRDYsa3w5lHKqIuh5E
 Jxww==
X-Gm-Message-State: AFq9FYLOqe/AJP0dyJZEowmlF5mBPniBrvzA4QisVSqThTjgSBXQTdLs
 BRuDajdcrLMrdOu6eAXL5u86eMEQKtGsjHDL/PU4zuTu+fi2gbiWaeU2cR1GpS7VQlFvFIV5skT
 mXwg+q4RixEEA7qx1Z/jUVenm2dL7P9x7dpim9p3uJJGRXf50Nb4kx1zApjkqzCWJ6vww
X-Gm-Gg: AYBFou0BbS+jmU6wA+q0muiE4cwPfsa3ISvpEbBLXy6WwtvJjZJHvKmQoU4jr3hZ0+w
 pxV9HEueiJV81+AYnR4MVOy25TFqtuKVSCzv+CrI8zWZGzu/z7xvlcXiUTQsR2K2Nq2a1nvvM0N
 wP7nqDXClkYY5tIErUJKRBQYgx5CZ2e4TTUcixU9S/HNiEGBjZrhnDoCVO7Ht7WGzcnVkeM9qP8
 JNwQZnNmNVz105CokT3Yb/Ia3ITtBOHTs74ub9ubJZerZgQPW5vwiceGbUDVLCV05V5+Lrguzac
 mMvnIsztwP0cvoduY7Jyx16YogZnhhxYIiVihHEEmxljv4penMpTgtLe81Ntv2xYZXdAMaT0tB0
 FNQC5e5UFsQtcEzJGR5b1H0V0oTRd0lILQMjGXguDkS/+/3dXaQMmqeSwi+AG1RpI40jonvuKDd
 ygqcI1bLqPsoSuueZ/3LO0Fqjbxb6YQw==
X-Received: by 2002:a05:620a:26a0:b0:93e:c06a:7313 with SMTP id
 af79cd13be357-94408a6fc7fmr928775985a.13.1793295942017; 
 Thu, 29 Oct 2026 10:45:42 -0700 (PDT)
X-Received: by 2002:a05:620a:26a0:b0:93e:c06a:7313 with SMTP id
 af79cd13be357-94408a6fc7fmr928773185a.13.1793295941521; 
 Thu, 29 Oct 2026 10:45:41 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf723b5dcsm707795e9.14.2026.10.29.10.45.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 09/12] tests/tcg/mipsel: Test MIPS32R6 DIV, MOD, DIVU and MODU
Date: Thu, 29 Oct 2026 18:44:30 +0100
Message-ID: <20261029174434.27985-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX1JwV/R1UFm7F
 Iph+9wVs3KSmWkfrvmLa7X9pVbzOWDs2tPXLIeBLZy9x5THqXaBI9yRkqS0sC+MG6wZPRl0kHDl
 99Qicv/el61wLGrxJ1a8ApzyMbYMAZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX4f25G3LKZm2f
 mT0H0Da+ZvQNfg2STMuHA7U+028ekrqUtueHd7Ht/Fqvae0tB+/Vr6LTcoNP32yH8tNXFS2uch7
 7l30r3AMetCk7AU6RJkjNJTe2sDHuVlR7K3IZ09Lw/tP6J7RwPuwd/0o25I+59Ww1g6BEQFK802
 rkwhw7T02kO+GYAk92c1FnSz0yKddk5iGIj5XBLChsyu3qJoAqXuw/jJkTUOruvc7ANpQUGcKM2
 whvHmRW227PWJ/1Wt7/KFcXO4wE6e8Q/+uI0fjWMXYNfbcoXrSQ16FRRpp9yLPOQ26jI0y5TDU+
 uXb2mKGmSnUr1WFmYdklYMOFFy41Dj/fZ7Q9gbXmzyAM6yapMPrO7YIJVudBRw1dYn/DmD9O5Wd
 Won2wDfNH/TE4TCa2UB6itjEJUcRiQ==
X-Proofpoint-ORIG-GUID: Q-D-wayKLWy4HyEAcilIigeIk_4Ft8S9
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae38646 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=CcuutW9W_LychIfcB9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Q-D-wayKLWy4HyEAcilIigeIk_4Ft8S9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test DIV[U] and MOD[U]. A zero divisor and INT_MIN / -1
are skipped: their result is UNPREDICTABLE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h |  5 +++
 tests/tcg/mipsel/test_mips32r6_multiply.c  | 47 +++++++++++++++++-----
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/mips/include/wrappers_mips32r6.h b/tests/tcg/mips/include/wrappers_mips32r6.h
index aaa8afcae95b..cbff8450b656 100644
--- a/tests/tcg/mips/include/wrappers_mips32r6.h
+++ b/tests/tcg/mips/include/wrappers_mips32r6.h
@@ -53,6 +53,11 @@ DO_MIPS32R6__RD__RS_RT(MUH, muh)
 DO_MIPS32R6__RD__RS_RT(MULU, mulu)
 DO_MIPS32R6__RD__RS_RT(MUHU, muhu)
 
+DO_MIPS32R6__RD__RS_RT(DIV, div)
+DO_MIPS32R6__RD__RS_RT(MOD, mod)
+DO_MIPS32R6__RD__RS_RT(DIVU, divu)
+DO_MIPS32R6__RD__RS_RT(MODU, modu)
+
 DO_MIPS32R6__RD__RS_RT(AND, and)
 DO_MIPS32R6__RD__RS_RT(NOR, nor)
 DO_MIPS32R6__RD__RS_RT(OR, or)
diff --git a/tests/tcg/mipsel/test_mips32r6_multiply.c b/tests/tcg/mipsel/test_mips32r6_multiply.c
index 94c4a3426ba2..356401f45c85 100644
--- a/tests/tcg/mipsel/test_mips32r6_multiply.c
+++ b/tests/tcg/mipsel/test_mips32r6_multiply.c
@@ -12,6 +12,7 @@
 
 typedef void (*binary_op_32)(const uint32_t *, const uint32_t *, uint32_t *);
 typedef uint32_t (*ref_op_32)(uint32_t, uint32_t);
+typedef int (*valid_op_32)(uint32_t, uint32_t);
 
 static uint32_t ref_mul(uint32_t a, uint32_t b)
 {
@@ -33,8 +34,28 @@ static uint32_t ref_muhu(uint32_t a, uint32_t b)
     return (uint32_t)(((uint64_t)a * b) >> 32);
 }
 
+/* Division by zero and INT_MIN / -1 have UNPREDICTABLE results. */
+static int valid_udiv(uint32_t a, uint32_t b) { return b != 0; }
+static int valid_sdiv(uint32_t a, uint32_t b)
+{
+    return b != 0 && !(a == 0x80000000u && b == 0xffffffffu);
+}
+
+static uint32_t ref_div(uint32_t a, uint32_t b)
+{
+    return (uint32_t)((int32_t)a / (int32_t)b);
+}
+
+static uint32_t ref_mod(uint32_t a, uint32_t b)
+{
+    return (uint32_t)((int32_t)a % (int32_t)b);
+}
+
+static uint32_t ref_divu(uint32_t a, uint32_t b) { return a / b; }
+static uint32_t ref_modu(uint32_t a, uint32_t b) { return a % b; }
+
 static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
-                    const uint32_t *input, size_t count)
+                    valid_op_32 valid, const uint32_t *input, size_t count)
 {
     int fail = 0;
 
@@ -42,6 +63,9 @@ static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
         for (size_t j = 0; j < count; j++) {
             uint32_t a = input[i], b = input[j], res = 0;
 
+            if (valid && !valid(a, b)) {
+                continue;
+            }
             op(&a, &b, &res);
             if (res != ref(a, b)) {
                 printf("# %s: %08x, %08x: got %08x expected %08x\n",
@@ -53,13 +77,14 @@ static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
     return fail;
 }
 
-static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+static int run(const char *name, binary_op_32 op, ref_op_32 ref,
+               valid_op_32 valid)
 {
     static int count;
     int ret = 0;
 
-    ret |= check_op(name, op, ref, b32_pattern, PATTERN_INPUTS_32_COUNT);
-    ret |= check_op(name, op, ref, b32_random, RANDOM_INPUTS_32_COUNT);
+    ret |= check_op(name, op, ref, valid, b32_pattern, PATTERN_INPUTS_32_COUNT);
+    ret |= check_op(name, op, ref, valid, b32_random, RANDOM_INPUTS_32_COUNT);
     printf("%s %d - MIPS32R6 multiply %s\n", ret ? "not ok" : "ok", ++count,
            name);
     return ret;
@@ -69,11 +94,15 @@ int main(void)
 {
     int ret = 0;
 
-    printf("TAP version 14\n1..4\n");
-    ret |= run("MUL", do_mips32r6_MUL, ref_mul);
-    ret |= run("MUH", do_mips32r6_MUH, ref_muh);
-    ret |= run("MULU", do_mips32r6_MULU, ref_mulu);
-    ret |= run("MUHU", do_mips32r6_MUHU, ref_muhu);
+    printf("TAP version 14\n1..8\n");
+    ret |= run("MUL", do_mips32r6_MUL, ref_mul, NULL);
+    ret |= run("MUH", do_mips32r6_MUH, ref_muh, NULL);
+    ret |= run("MULU", do_mips32r6_MULU, ref_mulu, NULL);
+    ret |= run("MUHU", do_mips32r6_MUHU, ref_muhu, NULL);
+    ret |= run("DIV", do_mips32r6_DIV, ref_div, valid_sdiv);
+    ret |= run("MOD", do_mips32r6_MOD, ref_mod, valid_sdiv);
+    ret |= run("DIVU", do_mips32r6_DIVU, ref_divu, valid_udiv);
+    ret |= run("MODU", do_mips32r6_MODU, ref_modu, valid_udiv);
 
     return ret ? 1 : 0;
 }
-- 
2.55.0


