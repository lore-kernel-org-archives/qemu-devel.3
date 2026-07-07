Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24393C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMJ-0005jS-Um; Tue, 07 Jul 2026 14:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALo-0005K4-Jg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALj-0006Qz-Tv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Gv3o5230768
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JKq+yUGvjHZ4YQ1p6Re3a/4lZ2DhXCPE6UUMq60lqzA=; b=Abk+rjfAQ8JPZfNh
 akyOqGFv1JYpaXZRnDJMvFU3V3QNIWIewSQYqmNL2zo+5bl4X0DJMr3MZl+RPpWl
 GCZpvrmyQsBIwYZxLQVshQ+U7cTRsInYSFakqMABRJxX/VKF7+E9StsoWbs1//zm
 1N3uRADWUP4HWEs8llQ804iGURHfLVex+R6Z8/oYUfdcwvyAUAbD2iWAyHGLH5GG
 avOe9C8JJ0jrXwgvI3FQ7InLtOhB0B1OfCvbVVo0fWWhN/7gAFhTIBcLSK5E/IE1
 Ig5ZBQU0+lXhpmXX4DM2InFKxcKRKL8fNae7+CJUGgOFXm5RK07XMX7JV/Sf84t3
 OTRZPA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5rcpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0e702df8so55431571cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448210; x=1784053010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JKq+yUGvjHZ4YQ1p6Re3a/4lZ2DhXCPE6UUMq60lqzA=;
 b=IEuFcCCMmotSl3Aij9UAumgyoSQErrfXdMVn7sD3yMkZXBDUFy/n9SsrLVerXCNCxO
 HR8C+rlg1eetfl8yoBfSlSjkC7HeIzEXTXOaPRhFmzlGgldfymyeSfJ8+ZnaU1K4qiAd
 U+UhMQDWQVIafLVmarvPI06jy92qrNDBzxiYiSd/5/XVqDF1LCzgsjmifvpAsfA7JSI3
 rhIBqHmUpxs7I/DK6sC5hY34Ch+3Cw4/XiOUD4Qiq8q2QXUmkPzrL0XxjfXHR9XkijSM
 UWkCVJaVa8iPrwN+ZNGaS1eWRbxere9KryR/z8e4FH9QWBqMzTbklbdYn/hGFFHLmIP7
 7g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448210; x=1784053010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JKq+yUGvjHZ4YQ1p6Re3a/4lZ2DhXCPE6UUMq60lqzA=;
 b=UQmhlYbuzk6wkG0kAjUV3BRjtA1HJKVQjcP04PXlAQU9vkA2LPCt5+1PpNSbva5/vF
 PB++HusFJMkhjNwnY9FlIKLGL2/dmNvFehYToAI6CZ8fxVJp0NFNlX20MwHAFOePMUsF
 TW2tm7oXrlZ598sT6MxpxS9vcWFOG0uN/QZrd2kUGyFkpmYkRm+6z4dTCsDKnDJvVSqX
 I5oB7rV0dx5lh2+e5hTlih9xqXFA0COcZv8jhesmsrPDHoMEh3WdxL3oxRGbz8dHm1nH
 8QvzFmdEHZjCbYWe8iOGdLJyJXgVa67hXwhxEbtB3wRLJXAuaCTqpdwfLvQxiT0U5fwk
 1hmQ==
X-Gm-Message-State: AOJu0YyJRlW5dup16PtedGxW12SSSti++MZRDqJnKnmDkq6zxcOzGBft
 Zr8lk9bOPIV0FefsHQ2QkRNeNNxT67uPVgGk8fRFg6bGkvK/uZIBaP7CNOs/fffCY5+D6TWY1qt
 PA9pxtzDHIaGNpzNL3JrK4xadm1vGiAU+7Cnw+2iI44IlSl0k8AYOAV9LhB3hV2NxQQ==
X-Gm-Gg: AfdE7clNHBhDqgG3JlWRJGvxtZJ2Y3jc8cdpiDZcE+KL0WQgpcDGsVHDAw+Up3QGLUG
 K/yeIplzufj7Af/8w9JZJDEZ7O0YGlcMojSlbZ50SVkc5XE2RiX53IRTWNTgHYb1VUicFpypYjU
 0GFrqBQjaPuwabVRulXORcoEk7jE5GnNEI2AsZPNhW0Ow7Ypfa/9PCwo2n5Ent+FKp1ZEriWtAu
 uCa6XCRoj9E2MSOj7yFULLqE7+kOC6XbNS7bPq9y5ZAh/NU/p7GPq1ExBQjxtQ6n+58zvZ+7svv
 +tPvUS4GTi8BNqaD6CADWuvrou4pklHuqhIcKKbY64hwnApLk74kKXsv4w2rynvL7/T03Lf+2j8
 r4lBoD+8qVYN40RUhoz/q3+qw1pGSrQcE54iyFQM1+yDyvd7L82Jc7N0HjgdbQuzUluU6
X-Received: by 2002:a05:622a:101:b0:51c:12bf:d4a7 with SMTP id
 d75a77b69052e-51c74829b84mr70535791cf.45.1783448209026; 
 Tue, 07 Jul 2026 11:16:49 -0700 (PDT)
X-Received: by 2002:a05:622a:101:b0:51c:12bf:d4a7 with SMTP id
 d75a77b69052e-51c74829b84mr70535231cf.45.1783448208309; 
 Tue, 07 Jul 2026 11:16:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm36792398f8f.25.2026.07.07.11.16.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] target/mips: add Octeon Camellia COP2 helpers
Date: Tue,  7 Jul 2026 20:15:16 +0200
Message-ID: <20260707181529.60191-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7Qx4Hgr06gE91kA8WLVAPt0lOp-EoTD7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX+bShQMbZRvyN
 lOrICjXWxhoor6DdO5Y9MQbl1tjK7/0Go+ftDUX7mgx90V7LtjOfmR3up37ci21urgN17FNfj++
 rcvFkn2v0r3td4XqeSI/fu/FXlQFdro=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4d4292 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pfeKYdQS9pwTd56Xz4kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 7Qx4Hgr06gE91kA8WLVAPt0lOp-EoTD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX8NxYTa6vGXQA
 VAO30Kp0CrrKjsUT2Ep4vIOBrg14i7GLTOzY+VAvy0iDeURuM777YnrB2l/tQ/D0VpsoJiYGTQs
 zxck1ldN2y9wvdwVWTCN5Gj1cYzrx7kaJLr9J3i1yQjoiCCWSuGFgnoW0/797QgmXvSmjj9SHh2
 +QcIpDnWB1oBdFJYyB5/1w6UQYM/fHp35fQGQV6s3Q3qOfJk0Lad8wxyp85jswPcsFjGA0qkRtB
 T2lb+BmqAsOklqmsXeibub+pGmsqNI96MFdJWvingAXIeC3q/PHucWsVUbpen1LSj/MSs6+lcvd
 hb4Ruj7bUkO34PKloMcUtiNTLtOjHcBtERcvWJjdER+tVMMEm3CIUx9eNEZW3UBSN0xWoIWVqNz
 2/eJMWtqAZ9vLJRROSltffw+xgiAFit4Eqhsp9a9ZuRjk89dqBwSIWslLFLFowyx9ciXObfLckW
 TViHft7yyTLch1AJNcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add helper support for the Octeon Camellia ROUND, FL, and FLINV
selectors. The engine reuses the AES RESINP bank, and guest-managed key
schedules drive the Camellia F-function and FL layers through these COP2
operations.

Implement the Camellia F-function and FL layers directly from RFC 3713.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-11-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   3 +
 target/mips/tcg/octeon_crypto.c | 126 ++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index c9332c5c522..71b7a2b30ec 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -66,6 +66,9 @@ DEF_HELPER_2(octeon_cp2_mt_des3_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_kas_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec_cbc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 8ea79e37568..430feaf5f4f 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1566,6 +1566,132 @@ void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
     octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
 }
 
+static const uint8_t camellia_sbox1[256] = {
+    112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12,
+    174,  65,  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,
+     29, 101, 146, 189, 134, 184, 175, 143, 124, 235,  31, 206,  62,  48,
+    220,  95,  94, 197,  11,  26, 166, 225,  57, 202, 213,  71,  93,  61,
+    217,   1,  90, 214,  81,  86, 108,  77, 139,  13, 154, 102, 251, 204,
+    176,  45, 116,  18,  43,  32, 240, 177, 132, 153, 223,  76, 203, 194,
+     52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215,  20,  88,
+     58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34,
+    254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252,
+    105,  80, 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149,
+    224, 255, 100, 210,  16, 196,   0,  72, 163, 247, 117, 219, 138,   3,
+    230, 218,   9,  63, 221, 148, 135,  92, 131,   2, 205,  74, 144,  51,
+    115, 103, 246, 243, 157, 127, 191, 226,  82, 155, 216,  38, 200,  55,
+    198,  59, 129, 150, 111,  75,  19, 190,  99,  46, 233, 121, 167, 140,
+    159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89, 120, 152,
+      6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250,
+    114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56,
+    241, 164,  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244,
+    119, 199, 128, 158,
+};
+
+static uint8_t camellia_rotl8(uint8_t v, unsigned int shift)
+{
+    return (v << shift) | (v >> (8 - shift));
+}
+
+static uint8_t camellia_sbox2(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 1);
+}
+
+static uint8_t camellia_sbox3(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 7);
+}
+
+static uint8_t camellia_sbox4(uint8_t x)
+{
+    return camellia_sbox1[camellia_rotl8(x, 1)];
+}
+
+static uint64_t camellia_f(uint64_t input, uint64_t key)
+{
+    uint64_t x = input ^ key;
+    uint8_t t1 = camellia_sbox1[x >> 56];
+    uint8_t t2 = camellia_sbox2((x >> 48) & 0xff);
+    uint8_t t3 = camellia_sbox3((x >> 40) & 0xff);
+    uint8_t t4 = camellia_sbox4((x >> 32) & 0xff);
+    uint8_t t5 = camellia_sbox2((x >> 24) & 0xff);
+    uint8_t t6 = camellia_sbox3((x >> 16) & 0xff);
+    uint8_t t7 = camellia_sbox4((x >> 8) & 0xff);
+    uint8_t t8 = camellia_sbox1[x & 0xff];
+    uint8_t y1 = t1 ^ t3 ^ t4 ^ t6 ^ t7 ^ t8;
+    uint8_t y2 = t1 ^ t2 ^ t4 ^ t5 ^ t7 ^ t8;
+    uint8_t y3 = t1 ^ t2 ^ t3 ^ t5 ^ t6 ^ t8;
+    uint8_t y4 = t2 ^ t3 ^ t4 ^ t5 ^ t6 ^ t7;
+    uint8_t y5 = t1 ^ t2 ^ t6 ^ t7 ^ t8;
+    uint8_t y6 = t2 ^ t3 ^ t5 ^ t7 ^ t8;
+    uint8_t y7 = t3 ^ t4 ^ t5 ^ t6 ^ t8;
+    uint8_t y8 = t1 ^ t4 ^ t5 ^ t6 ^ t7;
+
+    return ((uint64_t)y1 << 56) | ((uint64_t)y2 << 48) |
+           ((uint64_t)y3 << 40) | ((uint64_t)y4 << 32) |
+           ((uint64_t)y5 << 24) | ((uint64_t)y6 << 16) |
+           ((uint64_t)y7 << 8) | y8;
+}
+
+static uint64_t camellia_fl(uint64_t input, uint64_t key)
+{
+    uint32_t x1 = input >> 32;
+    uint32_t x2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    x2 ^= rol32(x1 & k1, 1);
+    x1 ^= x2 | k2;
+    return ((uint64_t)x1 << 32) | x2;
+}
+
+static uint64_t camellia_flinv(uint64_t input, uint64_t key)
+{
+    uint32_t y1 = input >> 32;
+    uint32_t y2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    y1 ^= y2 | k2;
+    y2 ^= rol32(y1 & k1, 1);
+    return ((uint64_t)y1 << 32) | y2;
+}
+
+static void octeon_camellia_round(MIPSOcteonCryptoState *crypto, uint64_t key)
+{
+    uint64_t left = crypto->aes_resinp[0];
+    uint64_t right = crypto->aes_resinp[1];
+
+    crypto->aes_resinp[0] = right ^ camellia_f(left, key);
+    crypto->aes_resinp[1] = left;
+}
+
+static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
+                                     uint64_t key, bool inverse)
+{
+    uint64_t state = crypto->aes_resinp[inverse ? 1 : 0];
+
+    crypto->aes_resinp[inverse ? 1 : 0] = inverse ?
+        camellia_flinv(state, key) :
+        camellia_fl(state, key);
+}
+
+void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_camellia_flinv(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_round(&env->octeon_crypto, value);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);
-- 
2.53.0


