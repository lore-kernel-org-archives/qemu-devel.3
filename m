Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37000606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JKHpk15/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ULcm4S20
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrKJ-0006dQ-RN; Fri, 30 Oct 2026 14:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJo-0006LN-Fi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJm-0002QO-QE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuSMH411194
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yeJKqyM0+SrhgWbt1uHvVNcPIydQeLHIeWpBo7FwUWc=; b=JKHpk15/eOWK6ZBu
 pR2L8uJWrRpYBWphJqjDRGP3Abb2ahtXZTybNsnjBIyLUJH9BtPev7b68XB+h7Vq
 6Tdwo+DvbJw40WqzYBchpBqXpqErWFRT+kthPH9oBAa2IOVvRLBeB/+/SRyKO292
 MKqiAYH4fx2A17PfVO2KChRa6wHSyp+qNy8GaWp2KL65XXqpXVo/aSKICtcrlINl
 4VnSBrH7Xzeq/CbAXxlZXhNOnaSbxaERhHxY41yhJDXraUlAGXwZcx5w38LcKY0J
 O/KyGioo+Rt7i5Sr6n4IERvWgDVJf8QVgUY2Cd7hL4I3vkvVI8tPSi8TL/Q4DZr1
 X5goGQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qvd87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so138560885a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384829; x=1793989629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yeJKqyM0+SrhgWbt1uHvVNcPIydQeLHIeWpBo7FwUWc=;
 b=ULcm4S20isNgMIJVT/OvMeXBrq1J0adbL5j/tRUQ9WipbUThHlTN83b1AtkrmvRb7D
 XvmhWHgtahBSukwDZg+q3RjOgVpnGzc24yMEpfh29a7Uo4Q/Lhu9TkRckarfX9KFjK36
 U9sqqmfid5Or+O5fnYlg2kUZS0Qx3Sg8VC62Z6ShppAJ+OkSmg8/Zb6rIDm2nnfh/MF3
 XZ3ZE1Il93S3OeOHRM7PW9JClM233X/B80/wlR3Bx3x/YjKbr2XPhnu6SYt0rLJE+iRs
 mKhxM+NIOSeiYodbMWYd0lT8Ypv+AZ1j6Vlbh+MDx7+rhYT0aqEBjdB7pbcgMQ/+OG3C
 gyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384829; x=1793989629;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yeJKqyM0+SrhgWbt1uHvVNcPIydQeLHIeWpBo7FwUWc=;
 b=gjaMRNwrNhhJ5aoftY04WUbuq6DR5Vs5Goa+xIO7tm3/wocJvUDpfoBioI/rjD6UAw
 KJ/nE0oOVd7uuqXFzOE5OJv7ld/BEhItr3gpOYlyJzusaxJA4qTeLNkzXPiC8RWCSVhM
 Vl4jhZmEwkGF6jw7psQfbss4+dvBX2X19jL88PkIex8LTAqrHNvB06o5+8B36k4lYwZp
 iDIyPyIXVkebANhe/v6ULa766tySbntpxmdHUO89zicN86h7hN+tmnNLxiDESfmqNN9h
 gn7gCx/+N41/oUdZPR+rj5ULm0u7+3KlyGO6PgeZM3ydXlhtx6BVbRjHi04Ks7iqhqdz
 mUfg==
X-Gm-Message-State: AFq9FYLCr/TxPLZU/6TO3Rfi1WFfYInph4uCwaR508EgYe5kQSeYMooe
 vdo8p5hweGcS+RHKr4CgEok7o58lcZa41ml16QIgGtbFLUzwfKtoMcGy4YdZOLHoAWz2EAb+mCh
 GjoLjzGcPDiTDyYbgWLt6JZO0zrLjAWqTWsRe5dEsU2ywd69Jg5xwJYW5k7h5xK9/6kBQ
X-Gm-Gg: AYBFou0I+0VYSYXYvKTt6p1iRu5nfKNCNNQO3tMq4hESZPnYmFe7F+9V7o1Ju9HqbGE
 TczR89nTYlf/tvEx1BS6vJryjyrS/Z8LmswfgqUn3eTh3Lha4zytQ7KFr536ZlUp/C8OxBn11fZ
 nvlj0FKNOweCx93fj2IBrQ3R2DM0xroYMfS1e6U7p6LxtunUOcvARXE0fg/06goCn4fPU6ld3Xx
 7Wt8POg7TqkIgUhgz7iYOm7mdefh0C7yeFp0vRcFddz2edTXSB5muVhYbSc9ERnL30O/pTVBNgp
 tdq9bzt6VzVlmEsCV5EwGEf7nztDUAmkeCPK9jw+t7bJplE2PJsrSYe3o+X0aAzI6LWB1VVkD5U
 +azQ744MToRAzfUbAJVN52OTfwd/LcUP5VDoI6BTJxCMoaGSfa7G2XztbYsgqZiUyslxWHkrKYL
 i9y8lLyxZR4UFQ4MB35qIIzlueA7zq4A==
X-Received: by 2002:a05:620a:608b:b0:943:f2ea:5ee7 with SMTP id
 af79cd13be357-94421659ddemr523465885a.23.1793384829166; 
 Fri, 30 Oct 2026 11:27:09 -0700 (PDT)
X-Received: by 2002:a05:620a:608b:b0:943:f2ea:5ee7 with SMTP id
 af79cd13be357-94421659ddemr523460985a.23.1793384828536; 
 Fri, 30 Oct 2026 11:27:08 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm159692465e9.9.2026.10.30.11.27.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:27:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 09/12] tests/tcg/mipsel: Test MIPS32R6 DIV, MOD,
 DIVU and MODU
Date: Fri, 30 Oct 2026 19:25:42 +0100
Message-ID: <20261030182546.2508-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E1qE92a7_wH44S2fNq-xonT719FCpIiJ
X-Proofpoint-ORIG-GUID: E1qE92a7_wH44S2fNq-xonT719FCpIiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX/GYqGodzT99z
 wrl9ZB/UFp52zf7SebWSzE5dYaXg1bvxPOp+MXglFyQnhG7343Yg4sqQEd4uw+n3kcAROpHHtB/
 j2MZyLiTsPew3M0nkyCWUL9x+9MeCCOQzn8ntR52jCST8OOfz1sAWCd/MnGH2b3xnOQNgyRGjYM
 MELR6kyCYJkk3ziv1Snc0gjOkTUvBYtIj09P0fKZb7Y2UHvtODAKHzrbFH5EFcc13eHzCBnGVx8
 mAS9vUTCca+ucM2YL39YJTSmcOV994UT3Iavgw1uewUQh7a/qRHvS4oqd5tYl5vir4U0WsAC2Ow
 oDkLWvUiLmVXfFM4Kg61NKWw0zSYPWaGHqX+Wwz1lu2CyFUE2QADWEbaufnIksC8R7Pi04anAWb
 4YitaWlnAq8/GweO8nqLABEl1vIVIAwi0qloqp9t5h3Q6kvG9xyGhzI0058dbkiqlIF9sc9d7iO
 K0ggLKPMCu53zNLqajg==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4e17d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CcuutW9W_LychIfcB9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX/f6f67xn1+hh
 Ppeie+nZXJSBjDdncpW0UUP72fsiov7QejQjgw7M2YGe2OxC7iWqxgGX0zfR52j8zy87QjwviND
 8vsb2AS/j7Qpr0yCM3hvwENczKq3B3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
 tests/tcg/mipsel/test_mips32r6_multiply.c  | 45 ++++++++++++++++++----
 2 files changed, 42 insertions(+), 8 deletions(-)

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
index 17106391107a..a58f757b24c0 100644
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
                 TAP_INFO("%s: %08x, %08x: got %08x expected %08x",
@@ -53,12 +77,13 @@ static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
     return fail;
 }
 
-static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+static int run(const char *name, binary_op_32 op, ref_op_32 ref,
+               valid_op_32 valid)
 {
     int ret = 0;
 
-    ret |= check_op(name, op, ref, b32_pattern, PATTERN_INPUTS_32_COUNT);
-    ret |= check_op(name, op, ref, b32_random, RANDOM_INPUTS_32_COUNT);
+    ret |= check_op(name, op, ref, valid, b32_pattern, PATTERN_INPUTS_32_COUNT);
+    ret |= check_op(name, op, ref, valid, b32_random, RANDOM_INPUTS_32_COUNT);
     tap_report(!ret, "MIPS32R6 multiply %s", name);
     return ret;
 }
@@ -66,10 +91,14 @@ static int run(const char *name, binary_op_32 op, ref_op_32 ref)
 int main(void)
 {
     TAP_START();
-    run("MUL", do_mips32r6_MUL, ref_mul);
-    run("MUH", do_mips32r6_MUH, ref_muh);
-    run("MULU", do_mips32r6_MULU, ref_mulu);
-    run("MUHU", do_mips32r6_MUHU, ref_muhu);
+    run("MUL", do_mips32r6_MUL, ref_mul, NULL);
+    run("MUH", do_mips32r6_MUH, ref_muh, NULL);
+    run("MULU", do_mips32r6_MULU, ref_mulu, NULL);
+    run("MUHU", do_mips32r6_MUHU, ref_muhu, NULL);
+    run("DIV", do_mips32r6_DIV, ref_div, valid_sdiv);
+    run("MOD", do_mips32r6_MOD, ref_mod, valid_sdiv);
+    run("DIVU", do_mips32r6_DIVU, ref_divu, valid_udiv);
+    run("MODU", do_mips32r6_MODU, ref_modu, valid_udiv);
 
     return tap_done();
 }
-- 
2.55.0


