Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E6606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PyuY8WpK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f1qCtEt8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegG-0000y6-A4; Sat, 24 Oct 2026 12:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegE-0000xV-T7
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegC-0002Nw-Bl
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExsRt838830
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cMhbgDmPQrV
 PPDr9pB95FgS/rggxk3ilVnSsvSESwlA=; b=PyuY8WpK611z+ajfYu42jSOksxH
 pI5BMGmWCIfSbQVXUppPo2apS8ldIScqFagigeKJiaOlZHQIBYMHkz2BufL6Xb8I
 VBVCp5OQnQrPKGh/RNtlYXr7GjtxW8QNw9nWdBe25zCcHYqYhm60ok8it8hRZV3Q
 By9OXWQCYFNunH9eaHTjL6J31Te4EoSwLPXkSi/xLpY/bBkJk5HiTSUDcCu92Swp
 0/rPb0jHL0K/STzsfMetGUPj5N2hpbLATfRonpbxROMTH0/FlxmpKrP/mUQlkr/1
 QStWJqnO76KX+pfEheq2rbVGRKeMSLsXLpcgALQXBF3bCqLCw8nIS7Mzx9A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27sahc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad91787a1aso1322974a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859590; x=1793464390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMhbgDmPQrVPPDr9pB95FgS/rggxk3ilVnSsvSESwlA=;
 b=f1qCtEt8p3j0dvH+dPQCdbbsKcmuzm3FbOezmPuWmMR6d4x7cWdpL4Q/hg6dOtBklc
 rgE/3cKEzjo2u1ueux6QqaWre167nXkClTFvCTcJ7AVuRe88t/U3Xs1lvgx1q0ndoBho
 xB6AS8asUf6PKa8CFQrbVMvyUASJQXa8ZZfwgfDVGbyR4BNVzV0uVyzQP3iI/nAVA+E0
 rLbMjtqjfDqWRfi04HeXVzvrWwU11x2qUH98pjWxLfA41X54ZMMazjoCWwuhEj0wFL7X
 0tnZOElTLYg0Eam7ph9bMwztxHMtwchA3w6vbzFvn1f37a+aLpv3oXU1JQg2uCIaFPdM
 Q5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859590; x=1793464390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cMhbgDmPQrVPPDr9pB95FgS/rggxk3ilVnSsvSESwlA=;
 b=ph5BK0cd8aDOcZvXmjBLFBVg5AMFqQARja/WBPfA5Hl7RpFfyZ6yNKhfUsXeLshH6q
 QfZKnrh/JR4alA66jRzq6HTRjJPlL0Qz8+XR+Nisl2IHequLIKSH+w5pxUrGaxe2AZxM
 fgclFRmXC9Lho3ln8j19dNkt4wIaJ+J6ibAF0BFw5icWwbh575tv0GChjGJFHRL0+Xgp
 d6MGGwNJv5qE9ZSqQvXLlPTjEZkhuUjlAT3vIqxY+f1fOhF5tJvnGlBX7xgXrR7KhOs3
 w1fIKmqs6+0Surow9sQTr+8RhxQy8cREA6vc6cbHpy9RsqMwdtGrdAJD4QAy/5DIaUMB
 4sZQ==
X-Gm-Message-State: AFq9FYKbHbmBs08/mYk2CDgTNxQQVsYAm9LIc3elp3hV3Rvt6+wSjPwf
 +pvNSUbgJa+FqSa8rTNvbZmRevHxAvbCCtCJ8Qc5pZmLfSchL+KDpzNLAtyrujXdHe0E8Thn/yK
 swTCA7zs3L+pXbwFduDlBmxOlBCpGAuQvmqUgxivXC6pBTlUWawhiCE1KhXHYXEGr1Q==
X-Gm-Gg: AYBFou1uqnDy5uKJvIfd/l/QuPA0eO6KLaLMf8YP4pMF7lBnn5FgrNpqO6GTxgZdJl4
 Uo00BQqba7G9zd+K+eqRRptFWawOlQrN8rNW1gCq9pLLP/Xjx0bQXU/EthJajt8zP3h2JN5kiWJ
 Af4ay6cB4s6x3GLd8tKTQ58sZ1O2s7QZqrPzUhG6mCON968W+IBcf3QZXgXN1r9Y3Yczt2th1eZ
 6IreE+HxJtlBIZ1u92Eae7PcXH1EkDr3fkMbQfwvt+OAsJbb6a0mA/6BY3JY+9UyThVRwtPpvO1
 MAEk4dHykDbS4gs/6s8CaA3sVFX4+Vn/J6Zvn4whCwVuKn3FEE1N7eJmpuYKXTWzV5+4BJY98Qy
 htytNYD31yWSK5aqTv2I67MKUzrtRIvJs9PfB9DbMhXV6xYIYxtcCgEwgj1BG3nQ=
X-Received: by 2002:a17:90b:5647:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3adead4c290mr1956056a91.34.1792859590246; 
 Sat, 24 Oct 2026 09:33:10 -0700 (PDT)
X-Received: by 2002:a17:90b:5647:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3adead4c290mr1956043a91.34.1792859589783; 
 Sat, 24 Oct 2026 09:33:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/11] target/sparc: define crypto helpers using HELPER
 macro
Date: Sat, 24 Oct 2026 16:32:41 +0000
Message-ID: <20261024163249.77855-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adcddc7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=rASOZnUmU6_uMA-YsRwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: CFlELtNJ4J-GMxv3KHoi-dmySp-bTlAS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX+waNwmBPS53f
 i5+bEcGDfJTMz+hjBE9ztQMPBntkov1LZHwwa/Xd4skRz3EDHQ6117aK5iDvkt9N4/ikzJHji8a
 NfL5WvuR0YeKwOJmP4Ms3iWL96w1X9M=
X-Proofpoint-GUID: CFlELtNJ4J-GMxv3KHoi-dmySp-bTlAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXzC1WYSvZmv1C
 +aSc2l9aVfHiOZIQ1+wpruNEoZneoJfg2pITVjNqDTz5y6zkZ/4revBQTW6RZdeSZ+rvniPYhwB
 GatzCsKzHht3kTZbX50h6WpClF+COv+VeVlh9587z0FiUGpCzyx71AyHjt+iR11fvOdlgwwoQVn
 Nsjspw0LqNjCm/JPZfwXPHpTpEUpoz+8n5KC6OHWpMc+G+awrX7zM2qO/5ySF81u2lfmcPrfyps
 l9NbpbR+mqUhmoKtI8xBhKgxtE+uo+8LUYZp1P19zuHbQV0Wagvoc3jvfcP+V4/OSGA9Fcvw8R8
 yIRyWV7oGxQkLX1F3m9ZSgifmyMGIvkv0cTGxpvYXR5taWTs0yVNTgT4fNrPrjt0CH5vpF0QLUB
 X1W2274LwLT22T8eSbq9XqG0AN3o6of5fRmRSwRFsRh9ecFRDeJRh2VAVqChiJvPn1t+stiVwK1
 ZcDLrmnj3gZQ44AmHGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240065
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

Crypto helpers were added after the conversion of target/sparc to the
HELPER macro. Convert them too, before helpers get prefixed with target
base architecture.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sparc/crypto_helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
index 6b6c843b3d8..9c9e951c40b 100644
--- a/target/sparc/crypto_helper.c
+++ b/target/sparc/crypto_helper.c
@@ -52,42 +52,42 @@ static uint64_t aes_round(uint64_t key, uint64_t s2, uint64_t s3,
     return r.d[out];
 }
 
-uint64_t helper_aes_eround01(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_eround01)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 0, false, false);
 }
 
-uint64_t helper_aes_eround23(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_eround23)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 1, false, false);
 }
 
-uint64_t helper_aes_dround01(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_dround01)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 0, true, false);
 }
 
-uint64_t helper_aes_dround23(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_dround23)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 1, true, false);
 }
 
-uint64_t helper_aes_eround01_l(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_eround01_l)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 0, false, true);
 }
 
-uint64_t helper_aes_eround23_l(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_eround23_l)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 1, false, true);
 }
 
-uint64_t helper_aes_dround01_l(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_dround01_l)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 0, true, true);
 }
 
-uint64_t helper_aes_dround23_l(uint64_t key, uint64_t s2, uint64_t s3)
+uint64_t HELPER(aes_dround23_l)(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 1, true, true);
 }
@@ -114,7 +114,7 @@ static uint32_t aes_subword(uint32_t x)
  * AES Cryptographic Operations 4-operand (Section 7.3)
  * AES key expansion with RotWord, SubWord, and RCON.
  */
-uint64_t helper_aes_kexpand1(uint64_t rs1, uint64_t rs2, uint32_t imm)
+uint64_t HELPER(aes_kexpand1)(uint64_t rs1, uint64_t rs2, uint32_t imm)
 {
     static const uint8_t rcon[10] = {
         0x01, 0x02, 0x04, 0x08, 0x10,
@@ -135,7 +135,7 @@ uint64_t helper_aes_kexpand1(uint64_t rs1, uint64_t rs2, uint32_t imm)
  * AES Cryptographic Operations 3-operand (Section 7.4)
  * AES key expansion with SubWord, without RotWord or RCON.
  */
-uint64_t helper_aes_kexpand0(uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(aes_kexpand0)(uint64_t rs1, uint64_t rs2)
 {
     return aes_kexpand(rs1, aes_subword(rs2));
 }
@@ -144,7 +144,7 @@ uint64_t helper_aes_kexpand0(uint64_t rs1, uint64_t rs2)
  * AES Cryptographic Operations 3-operand (Section 7.4)
  * AES key expansion without SubWord, RotWord, or RCON.
  */
-uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(aes_kexpand2)(uint64_t rs1, uint64_t rs2)
 {
     return aes_kexpand(rs1, (uint32_t)rs2);
 }
@@ -153,7 +153,7 @@ uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
  * CRC32C Operation 3-operand (Section 7.19)
  * Accumulate CRC32C over the eight bytes of rs2, most significant first.
  */
-uint64_t helper_crc32c(uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(crc32c)(uint64_t rs1, uint64_t rs2)
 {
     uint8_t buf[8];
     /* IV and result are byte-swapped in the register. */
@@ -172,7 +172,7 @@ uint64_t helper_crc32c(uint64_t rs1, uint64_t rs2)
  * Compress one SHA-1 block from f8-f23 into f0-f4.
  * Clear f5 to match SPARC M7 behavior.
  */
-void helper_sha1(CPUSPARCState *env)
+void HELPER(sha1)(CPUSPARCState *env)
 {
     uint32_t a = env->fpr[0].l.upper;
     uint32_t b = env->fpr[0].l.lower;
@@ -396,7 +396,7 @@ static void sha512_compress(uint64_t state[8], const uint64_t block[16])
 }
 
 /* Compress one SHA-256 block from f8-f23 into f0-f7. */
-void helper_sha256(CPUSPARCState *env)
+void HELPER(sha256)(CPUSPARCState *env)
 {
     uint32_t state[8], block[16];
 
@@ -422,7 +422,7 @@ void helper_sha256(CPUSPARCState *env)
  * Compress one SHA-512 block from FD16, FD18, ..., FD46
  * into FD0, FD2, ..., FD14.
  */
-void helper_sha512(CPUSPARCState *env)
+void HELPER(sha512)(CPUSPARCState *env)
 {
     uint64_t state[8], block[16];
 
-- 
2.43.0


