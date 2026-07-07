Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMb-0006Lb-0M; Tue, 07 Jul 2026 14:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMG-0005bM-A3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMB-0006Ur-TB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Gxbut187970
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0wtQgmx/NVlKO958uqowOtMGTQ7eBtEK767tGSSbrd8=; b=b2HcSFLPG3wPBZOj
 c/CbY6CL97Fk7emRIue2El+CPrmpbtTSS7nlSsemoNQz+CJLgEfaibE4VS/Vwl65
 Aobr7kScrfCwFYYwXbwJOH4kK8X8z0HTuO4wmHOo3EWm31Y2TJPwiBhdmJ8RROhA
 uH4Nl99vhc0/xhw/JVDItKOF25/D7+cICOMiPrVW8t0VighBkO7y5j8lkepuZeX3
 SdqU2w5xkoaKu3KO0MSDrgev76kxvOnI7/FZnRv94YEkvxpL7OQDkP/E6jQkWTuI
 tGPwXg5c/MwIKbZr9wk9AhlG98E43yZj7nXTXjL7K0JuWm55sARcWk7ABbwTIlZf
 UlI50A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd0cef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso60159561cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448238; x=1784053038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wtQgmx/NVlKO958uqowOtMGTQ7eBtEK767tGSSbrd8=;
 b=X+DfBnyocY5+HRpzaw5qAKVOwviE2R5UAJ4REoLY41ZIDub40j7pD0/O5K1QC3Fqnl
 G+Jy/1QYkxys0MHgN11X9fdL3voBRnAviKsCgoAmmVQzWUKEwtKNhT97d8i4V4zZ9PGQ
 VcPBp6TDwIExPTovTpWRdNi7j1z3e84/eFeuCAaGbJFB59o7+j1eq40TjKlzsDhW3Nca
 rUyNAPZtfMKfGKjeQc+K2iWzDr2YVDXC3RxsRQdUVl9bRPKnDHQDMlhMDZKx9drvtBme
 MIOTfuqNZyhzBbBUgu8MO+xur0TSq1wzgSBXsr+9iGcn9JeIdwz/Xx4z4VRM/Q8+oTO1
 ppBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448238; x=1784053038;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0wtQgmx/NVlKO958uqowOtMGTQ7eBtEK767tGSSbrd8=;
 b=pKukdbzk0/HAA4KjrsAD6WWp7WN1ks8qUiDamTwakKqtzlIegL3X6txQ/OOKam4y8y
 FZgLi+hZaKFdRJES/5kVRh5Kt5vqKPQ7zM8hL2wKy/W/0lD4pY7f+m9NcVysXWWXQB3a
 iLSa4+kWil3Yar1V6XwF2sn175bq7fdZ1HS/Gl9Pz0se4eIFR0hyytKxj/G0044geAdx
 MGNC87e8lFnBCf40JfsAimiRJ98GdmdpyritNQdrnq8dKABLZu9UsAlAaqEu3O/D0CBi
 +xBuLAvF59krbrHG1VS+RFEj8xIf7InmbNiwbdt8btPLAnHoB9doGU7L0RS2Bmtgtjrt
 +p8g==
X-Gm-Message-State: AOJu0YxlzqjsaYEAVOWcmTWDIVg95x1G2RP2qq/fONkSa00j/gfhdTkx
 MwZtpZRyAiFP6S8oxIys2xX3bF8X4Pl2w/pC6Eypd91ez9jKl+XpbqWwl7LO6iOkYQSqn0ggAOM
 dj+OLY6PPjcNb6SnJskGDf+sO4yyQngvPAvy+M5M4PqcJ4lv0Gxfsr54c4Izf0V21fg==
X-Gm-Gg: AfdE7cmVL1Z7rZLGkjj+Le/xUv8h+boTO58gUF6grcyqcj6o2Zw29Gubh+Eucg66UBL
 f9vMczIYE2QVRGwtgSfaA5Ozsrj3kQbeJUBZxZj9B32nKlSDIvWtyp3wKqTsyz8gS7Wk1RB4ryz
 MkZIaoub15K2xJyNSuzbSKhFbrvNox+pXFKv1HMR9s9pTqq03mQrgaksKMOF8b5H1OjkEo1TugG
 j1UTzqtcRSr0ZGGZFuYez89n1w7AO/nTVLKQs2gzp+FA8GLbbI5OyshZWm/Oa/w3o312V5Yi9lR
 TXukbUv4n/Q5eKWdL1Lzfikm7q8eAE54qzga83JxaukqcMvc8nTCzVK+J26GuORF8i4pTYdh1gN
 8/5rk8TmanFf21+qNaU4UGX9+DbkjvHLB74fr3buAMbQGh5jFtLLnQM9ZoC0S8nuvvntH
X-Received: by 2002:a05:622a:1183:b0:51c:1b78:b044 with SMTP id
 d75a77b69052e-51c7487febcmr66637431cf.61.1783448237366; 
 Tue, 07 Jul 2026 11:17:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1183:b0:51c:1b78:b044 with SMTP id
 d75a77b69052e-51c7487febcmr66637251cf.61.1783448236812; 
 Tue, 07 Jul 2026 11:17:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e3e2702sm36522504f8f.9.2026.07.07.11.17.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/23] target/mips: decode Octeon CRC and GFM COP2 selectors
Date: Tue,  7 Jul 2026 20:15:20 +0200
Message-ID: <20260707181529.60191-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX59nVWgaaXd1y
 nrUHjQYHT93d+82L+E0mLjlnzBEFnmIEBGnNmIZcA+kErmgbR061YLZkesKJVMMbHXBv8h+8ln4
 kTp0WCoaChQrluL24Kpy5iTKQ3j4o/dFuZnRh59MavEXhARMVciPxQY4zRafGd/hla5ItSA7/ky
 ySr/BpGnKNJ6VFAWbnrTt67DptxNaZEHI9j76VshYgbXRoJPVzs/tSW/Yr047VzYWjR+RQmFPdV
 ynusN1ERyV4tp33U22hFm00PReHZbsfDKahX91ALP5+llbVcf8mXtI57LISH2KIRzNbyzDsikDq
 Qgmk1C0W/KlN1hw1ngWDbdXapI7w/5PiOfwE/Sw+iaMeiUeUu/6QZCD5vx3ug4LJ3h8qwFg+XMb
 aMmjx8usRo/Mzh2d7shQV1tWxWu5BW+zQYAtgEqj17HmjaDkMTGEGlBRq85RAaQrtmKWREg9XNt
 /nWhaQxQ5Xy1gvA1Y/g==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4d42ae cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p39F3lQ1OLOpEbmj1dkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EuCgIurvj6y9yod77u5QNElyJHXC5gmN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX5nDNAeZZdEhb
 GZyMY16TfRtmkPUmYLWQs79tvaXzOTlRRDB8tFAKBNAnOnrWa7c0GKZ1zX/R5/kXqUBulmtkMvH
 2691EmaKq3veT5vFnS5cST9HgjXLk2s=
X-Proofpoint-GUID: EuCgIurvj6y9yod77u5QNElyJHXC5gmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070179
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

Add explicit decodetree entries and translator bindings for the Octeon
CRC and GFM COP2 operation selectors. Unlike simple register moves,
these selectors update CRC or Galois-field state and therefore remain
per-operation helper calls.

Keep CRC/GFM decode next to the helpers that implement these side
effects while avoiding a monolithic selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-15-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h                          |  1 +
 target/mips/tcg/octeon.decode                 | 22 ++++++
 target/mips/tcg/octeon_crypto.c               |  7 ++
 target/mips/tcg/octeon_translate.c            | 50 +++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 70 +++++++++++++++++++
 5 files changed, 150 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e210e406f9c..141350e80ad 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -32,6 +32,7 @@ DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_polynomial_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_word, void, env, i64)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 09fbc6c1e34..70e02d0b0e9 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -132,6 +132,11 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_CRC_POLYNOMIAL                010010 00001 rt:5 0000 0010 0000 0000 &cp2
     CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
     CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
+    CVM_MF_CRC_IV_REFLECT                010010 00001 rt:5 0000 0010 0000 0011 &cp2
+    CVM_MF_GFM_MUL_REFLECT0              010010 00001 rt:5 0000 0000 0101 1000 &cp2
+    CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
+    CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -148,6 +153,9 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
     CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
+    CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
     CVM_MT_3DES_KEY0                     010010 00101 rt:5 0000 0000 1000 0000 &cp2
     CVM_MT_3DES_KEY1                     010010 00101 rt:5 0000 0000 1000 0001 &cp2
     CVM_MT_3DES_KEY2                     010010 00101 rt:5 0000 0000 1000 0010 &cp2
@@ -167,13 +175,27 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_CRC_IV_REFLECT                010010 00101 rt:5 0000 0010 0001 0001 &cp2
+    CVM_MT_CRC_BYTE                      010010 00101 rt:5 0000 0010 0000 0100 &cp2
+    CVM_MT_CRC_HALF                      010010 00101 rt:5 0000 0010 0000 0101 &cp2
+    CVM_MT_CRC_WORD                      010010 00101 rt:5 0000 0010 0000 0110 &cp2
+    CVM_MT_CRC_BYTE_REFLECT              010010 00101 rt:5 0000 0010 0001 0100 &cp2
+    CVM_MT_CRC_HALF_REFLECT              010010 00101 rt:5 0000 0010 0001 0101 &cp2
+    CVM_MT_CRC_WORD_REFLECT              010010 00101 rt:5 0000 0010 0001 0110 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
     CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_DWORD                     010010 00101 rt:5 0001 0010 0000 0111 &cp2
+    CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
+    CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
+    CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
+    CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
   CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
 }
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index b24533e03df..fbf80be2a53 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -2203,6 +2203,13 @@ void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
         octeon_crc_reflect32_by_byte((uint32_t)value);
 }
 
+void helper_octeon_cp2_mt_crc_write_polynomial_reflect(CPUMIPSState *env,
+                                                       uint64_t value)
+{
+    env->octeon_crypto.crc_poly =
+        octeon_crc_reflect32_by_byte((uint32_t)value);
+}
+
 void helper_octeon_cp2_mt_crc_write_byte(CPUMIPSState *env, uint64_t value)
 {
     octeon_crc_update_normal(&env->octeon_crypto, value, 1);
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b33252dd1f8..ce4cfcb3f30 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -28,6 +28,9 @@
     TRANS(NAME, trans_octeon_cp2_mf_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MF_HELPER(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mf_helper, \
+          gen_helper_octeon_cp2_mf_ ## SUFFIX)
 #define CP2_MT_I64(NAME, FIELD) \
     TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
 #define CP2_MT_U32(NAME, FIELD) \
@@ -41,6 +44,9 @@
     TRANS(NAME, trans_octeon_cp2_mt_hsh_pair, \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
           OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MT_HELPER(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mt_helper, \
+          gen_helper_octeon_cp2_mt_ ## SUFFIX)
 
 #define OCTEON_LO32_OFFSET (HOST_BIG_ENDIAN ? 4 : 0)
 
@@ -99,6 +105,16 @@ static bool trans_octeon_cp2_mf_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mf_helper(DisasContext *ctx, arg_cp2 *a,
+                                       void (*gen_helper)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_helper(value, tcg_env);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
 static bool trans_octeon_cp2_mt_i64(DisasContext *ctx, arg_cp2 *a, int offset)
 {
     TCGv_i64 value = tcg_temp_new_i64();
@@ -149,6 +165,16 @@ static bool trans_octeon_cp2_mt_hsh_pair(DisasContext *ctx, arg_cp2 *a,
     return true;
 }
 
+static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
+                                       void (*gen_helper)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    gen_helper(tcg_env, value);
+    return true;
+}
+
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
 CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
@@ -185,6 +211,12 @@ CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
 CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
+CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT0, gfm_mul_reflect0);
+CP2_MF_HELPER(CVM_MF_GFM_MUL_REFLECT1, gfm_mul_reflect1);
+CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT0, gfm_resinp_reflect0);
+CP2_MF_HELPER(CVM_MF_GFM_RESINP_REFLECT1, gfm_resinp_reflect1);
+
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT0, hsh_dat, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT1, hsh_dat, 1);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT2, hsh_dat, 2);
@@ -196,6 +228,9 @@ CP2_MT_HSH_PAIR(CVM_MT_HSH_IV0, hsh_iv, 0);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV1, hsh_iv, 1);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV2, hsh_iv, 2);
 CP2_MT_HSH_PAIR(CVM_MT_HSH_IV3, hsh_iv, 3);
+CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT0, gfm_mul_reflect0);
+CP2_MT_HELPER(CVM_MT_GFM_MUL_REFLECT1, gfm_mul_reflect1);
+CP2_MT_HELPER(CVM_MT_GFM_XOR0_REFLECT, gfm_xor0_reflect);
 CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
 CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
 CP2_MT_I64(CVM_MT_3DES_KEY2, des3_key[2]);
@@ -223,6 +258,21 @@ CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
 CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
 CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
 
+CP2_MT_HELPER(CVM_MT_CRC_POLYNOMIAL_REFLECT, crc_write_polynomial_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_IV_REFLECT, crc_write_iv_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_BYTE, crc_write_byte);
+CP2_MT_HELPER(CVM_MT_CRC_HALF, crc_write_half);
+CP2_MT_HELPER(CVM_MT_CRC_WORD, crc_write_word);
+CP2_MT_HELPER(CVM_MT_CRC_BYTE_REFLECT, crc_write_byte_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_HALF_REFLECT, crc_write_half_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WORD_REFLECT, crc_write_word_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_DWORD, crc_write_dword);
+CP2_MT_HELPER(CVM_MT_CRC_VAR, crc_write_var);
+CP2_MT_HELPER(CVM_MT_CRC_DWORD_REFLECT, crc_write_dword_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_VAR_REFLECT, crc_write_var_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 7a7445c40a5..f3c52d7829e 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -266,6 +266,70 @@ static uint64_t octeon_cop2_hsh_dat0_readback(uint64_t value)
     return rd;
 }
 
+static uint64_t octeon_cop2_crc_len_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a81202\n\t" /* dmtc2 $8, CRC_LEN selector */
+        ".word 0x482a0202\n\t" /* dmfc2 $10, CRC_LEN selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_crc_poly_reflect_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a84210\n\t" /* dmtc2 $8, CRC_POLYNOMIAL_REFLECT selector */
+        ".word 0x482a0200\n\t" /* dmfc2 $10, CRC_POLYNOMIAL selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_gfm_mul_reflect_write_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80058\n\t" /* dmtc2 $8, GFM_MUL_REFLECT0 selector */
+        ".word 0x482a0258\n\t" /* dmfc2 $10, GFM_MUL0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_gfm_mul_reflect_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80258\n\t" /* dmtc2 $8, GFM_MUL0 selector */
+        ".word 0x482a0058\n\t" /* dmfc2 $10, GFM_MUL_REFLECT0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -288,6 +352,12 @@ int main(void)
     assert(octeon_cop2_keylength_readback(0xa5) == 1);
     assert(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
            0x0102030405060708ULL);
+    assert(octeon_cop2_crc_len_readback(0xb5) == 5);
+    assert(octeon_cop2_crc_poly_reflect_readback(0x12345678) == 0x482c6a1e);
+    assert(octeon_cop2_gfm_mul_reflect_write_readback(
+               0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
+    assert(octeon_cop2_gfm_mul_reflect_readback(
+               0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
 
     return 0;
 }
-- 
2.53.0


