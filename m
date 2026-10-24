Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165ED606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SyZgssQo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HPdCJ02V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfg6-0003zD-6p; Sat, 24 Oct 2026 13:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg2-0003yA-UL
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKffz-0008H8-4G
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExqUO1907252
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4fdaO8BZpd3gaNJmd9bR+zhjd/iYspheTdIklQ/zkl4=; b=SyZgssQoC8ooHSWZ
 zpamUxhj7Xh4qlRhxEMVyl1ph4ixo5/gwPTtCHaaLyLt7g+4p/ghLNodUEEXi/GR
 Qx0sGU0NfRr2V5mmORrxBUr1Bbuq+JkGhYV8Mz4prRmhJQiaKTEcF9zl06DHKsJ6
 mIekX9vkmOsR78HzZ3K1yd+M/8aQWnPSrf2gvuuhi3e1cVpFc/CyKQnClP+UTLR+
 cKjzlI0dXgRu33symCdOiFKIQdMjFFocLuzxFGCzgvgrT4iSi2y6gsc67H9IdUFE
 IcGNT6MAKU1KbHba29tGCVX/t9gl/JUo1Pxqv4F41ajJCcXsUrBcT9edylJnXgcn
 111J1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3hekd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adcb81f487so2832627a91.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863421; x=1793468221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4fdaO8BZpd3gaNJmd9bR+zhjd/iYspheTdIklQ/zkl4=;
 b=HPdCJ02V+i4jOT5K51HiV2Hl4O0GwGCA8nUnrltr++DmJkdodJyrykoVS56cebsjGZ
 n5RHXLWXnVKhgWOthBjXPABmFvEO4MY5Otj64p07ol++xVgKeLLgbnmkqvWF/XorvKbQ
 KWXklBSCfRDjCFcPYlzHGbhoC3ptQo9RVgH0ROE7r04x9uuHlq/jbInnOdQRMzyuEI7t
 pgi6ZJxxGWUTGfEZYnVdPxNJ9bUHPEsXDTgRV1emj5P00Q5D2EKxwhyEsxrQqMrUnUPw
 oPw5BOzIExxk0uv6WsWM2qotQHHPYgNPDd3j7hJ0K+exNVVKKbDwdnWLJGOunI6XJCkZ
 k/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863421; x=1793468221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4fdaO8BZpd3gaNJmd9bR+zhjd/iYspheTdIklQ/zkl4=;
 b=JZHWnoDkaIf9HPbK3AnHHoLFMXO+bebgy6b7CCR7Q0GApmNoEMbG4kzGnKQbcUtQ8w
 aSGnqSCYpcXw4KkCJfdubes2WJnvq3LclkabE+v4q8+fc/T7fSCupO3/yD2GNkWY2YPq
 vzCP8A1eos8gG9TxkESZio1oxH3siF408klApQ+LU7b4wPABvijSq/xul2TRBd9m6MPG
 /OMT5Y384qeplhXziFhy2+Qm2/L5iLFfMyzm0rXA5nR4lTVJxG2JQmuJlh7syxRM8+cZ
 9OqcgyVqAi6LjXRqzKTFyTtVS0UFVisu+19LT6dzIrFRAnSYLLyJm9WEnR11wNO41CT9
 9Lqg==
X-Gm-Message-State: AFq9FYLedl0dg5OVSjpQb8XhnDEb8koKTQaE76mjMhlOtcgY6tWt01bD
 2D8rArtth3zkHLv1VRAyLc3Hcg87yvFavJ8pvUDPsRYzOfVGdg8e+wpdzLDd0mMTxCPhqwGlb5V
 2BfjBfbM+CeGzlj8yYMySvW83F3F4dkYYTl3S6ertWEIMd9tAo5Sz6Am9H+rvDpjntQ==
X-Gm-Gg: AYBFou1KnxGwLIzj8mWdxrHQk+LeZUbBdDGcnr+Lu7lGIrqZTPC26Hedf+CKOHxE70L
 zK1DaA+9fTmRIjfx3snqfZjXSaBOiF0+xMIIaSCqx9x9kkXcqukcBZZmnQmHPbpJt5HGgtKMw1y
 Rd3yGymgzbOGfnRJeB8uoqWeXNq3UsMAGf52xP7kU0B5qgDKqkju5BpzF7sZn06WVn1ydqcckYi
 Zky7QJuotF3hLpT4D064XEidI7OwgwloMkR+WVz1CA4aieLsz5cAIV2MPnGuw3BPwkPGKrxg1SM
 9ElUHiDXeEkKrj4ANX2OmoVJlIMnCmezeMbLsTpSYZaniZEBoOxtmJ26wmv1eU/ff0562fArxIS
 pzeMuXr5eebqDym58GLPhDCUZCqRWtC12MpzGBJdNFKS+YKc4Ave/x+0RxWnFg70=
X-Received: by 2002:a17:90b:1e4f:b0:3ac:9d83:8856 with SMTP id
 98e67ed59e1d1-3ade9b2ef3emr2384000a91.9.1792863420827; 
 Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1e4f:b0:3ac:9d83:8856 with SMTP id
 98e67ed59e1d1-3ade9b2ef3emr2383986a91.9.1792863420285; 
 Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/20] target/sparc: define crypto helpers using HELPER macro
Date: Sat, 24 Oct 2026 17:36:32 +0000
Message-ID: <20261024173649.7405-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S0xqSy4G9aW7k0RIzZTy3757qZjBUGev
X-Proofpoint-ORIG-GUID: S0xqSy4G9aW7k0RIzZTy3757qZjBUGev
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX44lwumqTk8fO
 P83Wfs97+G4nq00KqiZQcGXBkr/Rr87haZzuSEYRQi6FoqEhJrtyB6DN3DWOAJnzvf4lz58NU+y
 g6xeC101oOyhQFmX0eZW1Y77VToMTdU=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adcecbd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rASOZnUmU6_uMA-YsRwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX1zlZzln0ARox
 KIE23uldgdJMmSfK26no7N6TVjCyRTEmhOjBFt9BACybEAwtsn2oEGdtrM7/DN0EQePaKKuylDR
 Vje9tDqmfTDNDd1OV5e+iIcHsAKuGhTyB3LuzitminuqSjHuyviyhR5uJ74+EDk9yG8h/CcCM0A
 w/F7uiEBOUro8CqN8BUsdhUt55CQGTa1BFOuDq0TBdJUBjjNpPotcsc1Gw8E+P4TEs8vNIkyXML
 +8ri2QyrqDYqWY9B/mzza14syjAb8FxWh2sK72Ud06YateAyDW9dp4QKuMR0k4i+EjaxAoKqfNY
 1wLtgO90xmPRQF6iRp5kP00rMt/zIzWgZIqQr5kDIYN1qm53ccnr4ey6lC6iRlxqy1DGtGaxUu0
 WYvVkYy6dImKAg6A2MsIKws8bnqJ8G26EePidmYhwWNmxLkv92t6ZqpA2dzPA3DgS9XlFESMhFH
 6rSR81tLwiE+QjKtD8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-4-pierrick.bouvier@oss.qualcomm.com
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


