Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15799C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whANs-0007iz-3L; Tue, 07 Jul 2026 14:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMY-0006JC-Gf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMW-0006Yk-4R
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT7h04045099
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH4ej2NLvs8V6pxbRVNkyAzI6YhndgdI5YIJaL/DxVk=; b=m3wqGlmEoQKmYfxQ
 YQPjur7RjOGMYm1/j/bDnJxIfrsNH9KlU9dbiphCAVAGe8Ltu222uyxkAmuwx+7n
 44Oad1mnyOPw9TT/41W0RrWu9ninxaXYEVQTDmfLXiu/XgFxcn2jI8TVrmKN8Bf0
 ZvUPMurmGUEvft+F9yOk+q1jfOWu72D4ea2ao/sXsq4F4V8F1RaFQSKQd9Uiteti
 XyIsVOsWoQwVjb9/y4MIJf8dyhBZ7UC6OMpAyXxB52SSSgMGNLkeIEKcniA8C/aq
 1vtr983mpBGTf3CK7BLsYUn0CW4KYKLZNoru9WIsPqffV0YYIuPB9DX0HHEV7md+
 4XwrvA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2uas5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso93384161cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448258; x=1784053058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HH4ej2NLvs8V6pxbRVNkyAzI6YhndgdI5YIJaL/DxVk=;
 b=g7/0TlVP0L9egxwHOhZSFk5ovHLXN8fKoC+uyWSt8Ca66wF097wMgqjM9zA3SJrR5o
 0yiRMLIDhsgG26WKeUR81JgWFhJomiodcBr0d601cZxAutuc8skoRBoDipafPX2RLyR7
 Dsv1TOTTB5XdTmU51B2nz4fLvbwaa5l+CcR6rkar6DDeKpyLI5/zXdvyNoyVLWP++WYT
 OIM1e2L1KJ6Kaco7jXdDtAaTqXtbOM2ngMlWoRJY3UdrKW6z7NKsRf6gAYCJM5E38ZXC
 QtlXeKPrVDDGWJsUxluQg1pTkgg+yTdOKleVq7019vfgnTsC+4XtBnQrKZsXQn/1VS1p
 p9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448258; x=1784053058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HH4ej2NLvs8V6pxbRVNkyAzI6YhndgdI5YIJaL/DxVk=;
 b=IOgM9HmqZCaqu6Ht5cTqHKwDrNKaOny+XIgAgcGp7RKn8vKEGulEfJdTZJbL85sBTJ
 MpEr8cnoOLcjIR/lQUJoYHuXCjobeP3CfURqAsBxiZFNTM6CVknBi4WdaPSqiWRKdE/K
 GvyXeHdw0XE+K6OdS6D8NrGBYsG+tvv37azB7cacA4leqYn4t312QZK4aOGG621hytuE
 S0aHvD122Ah7YxoMEtdtc/hN0nY6IgloT2+OI0JLOv+szqefeMNE7HGiV+qH5tc8b1EO
 PFF7kIbPDj/Rg3jCQI09b6tvp8vjpVBtTwDhgkb2o9K6le5qMMdKR3nfgYMM3ryYBRRn
 vxMw==
X-Gm-Message-State: AOJu0YxdvkEbFIQQnNR5g2NhX9eF7THem9ZIX7A41EqTkH3ER5R3EPrh
 vlgCQGsG3IGfrd9kxsA0JGoS/HHulO7GC4NQ9KCcLeWjQE4A6ZxKyWQS9kijkojaNC+boCGuBRE
 1r+nwsTLFN5k+mXFrlwsat0iBS6B+H/4pycu3dsnnKZ1L2KYaXncFMkJoTp8/5Xoxvg==
X-Gm-Gg: AfdE7clk5kfN+W6iUnhsMJfbMH13Krs5xhyL8NZ34ro9PKvXMAyCW5ou0V9AQHXZuUB
 7h5Qa9jBknzUXakSoEOPoH2tMJWlrJp9hkasiQ30Ydd6VM+NmQbrU9sMgSd+9K6DotoTyeWxCXt
 47RaMuxyU+UwoRs+JmEYiVDutAzI6yqdeXieWdw5F8uWQe0M99RHQAEiay2XlejwW9WPwcAh8n+
 fSdpBiizxmeXNsBpfA7yQy3NmuyQ1jyR9j1D/zwimbBeP/KCbN/Mq3VV0KdEVOUSbsPw/tbrITp
 MvqZvYwsq59K5zXQq4WvH3QgJp3880Au6F/rmTFi8Nd3ryB5+RvuBCgq60eSHfZe0VNJxImLd8b
 4yk2myvcJeZUX8/B8ZqJqQreabvmgOp/zOkMAiCNOOfSm2cbKMd3pl5Nohz6oC3X7tq/O
X-Received: by 2002:a05:622a:110f:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51c747d0552mr68059891cf.24.1783448258188; 
 Tue, 07 Jul 2026 11:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:110f:b0:51c:1c73:5945 with SMTP id
 d75a77b69052e-51c747d0552mr68059571cf.24.1783448257637; 
 Tue, 07 Jul 2026 11:17:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b126sm35361207f8f.24.2026.07.07.11.17.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/23] target/mips: decode Octeon block-cipher COP2 selectors
Date: Tue,  7 Jul 2026 20:15:23 +0200
Message-ID: <20260707181529.60191-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX7ooQeZAHsa0N
 +M15rbu2Ky62Ab3vU+lQxK8bKnLgfBp+PcYBmLqVHdxgQpMAycmwb2m6Cbq+W254zS4EiwwaSqL
 uUxqzAE2LX5/jej9LbzCjLhcr7cVNrc=
X-Proofpoint-GUID: KglZmg8hk1CXY9r2NPNHfRNRE_Wn6kLJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4dVAbK5iGkB4
 fBcR0M4y/QuQtW4HXRS/vXzugjHIOxr6eix4Nn7FnsRDNd9J08GhTP7NALn2fg8GOg9AUwPRS33
 bplk/MzLu+GYLQjFp5VTkD3wG0ngVQu4MEsu/TxPvEDBaRPlPMELzxJ7C+H1JwU+zD1s0/eEm4h
 D1yAEmQTLt6coiUdoyiZ8bmjWIXJs9rSYjCDyqYFXSpPs9I9NNAsgmgjQn0kSibwy/oETRAgHAI
 mD0+mGu9r4Ldw5MRyTQ7C2o1+LVsOp6D1uzpshtaZKsHQGI+eisLD+prTtHuWvrMUwqSE5bRvLw
 HetsKBZV53U9gP5OC2+bRLuMGZu6kd4k7rgcMrL0dEpTOC/FhBfoZ88x4Z2vc9HSJWGZrd2gXux
 AILqkMlLIcdCDrA0/KpSrcjmk3Ocv8WXg5hQbVhsAG1Fwp7tl+B1TGn7v0e6/xMuzZi54CUXzK8
 8fXSYAs6o4bF4a+1t5g==
X-Proofpoint-ORIG-GUID: KglZmg8hk1CXY9r2NPNHfRNRE_Wn6kLJ
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d42c3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f58Cf6jUHuCqYyNe2GoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
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

Add explicit decodetree entries and translator bindings for the Octeon
AES, SMS4, 3DES, KASUMI, and Camellia COP2 operation selectors.  These
selectors consume or update engine state, so keep them as per-operation
helper calls while the simple block-cipher register moves remain direct
TCG loads and stores from the earlier register-selector patch.

This completes the block-cipher selector coverage without reintroducing a
generic runtime selector dispatch path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-18-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/octeon.decode      | 17 +++++++++++++++++
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2b27fa205ff..4ac38d264c8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -203,6 +203,8 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CAMELLIA_FL                   010010 00101 rt:5 0000 0001 0001 0101 &cp2
+    CVM_MT_CAMELLIA_FLINV                010010 00101 rt:5 0000 0001 0001 0110 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
     CVM_MT_CRC_IV_REFLECT                010010 00101 rt:5 0000 0010 0001 0001 &cp2
     CVM_MT_CRC_BYTE                      010010 00101 rt:5 0000 0010 0000 0100 &cp2
@@ -264,6 +266,15 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_AES_ENC_CBC1                  010010 00101 rt:5 0011 0001 0000 1001 &cp2
+    CVM_MT_AES_ENC1                      010010 00101 rt:5 0011 0001 0000 1011 &cp2
+    CVM_MT_AES_DEC_CBC1                  010010 00101 rt:5 0011 0001 0000 1101 &cp2
+    CVM_MT_AES_DEC1                      010010 00101 rt:5 0011 0001 0000 1111 &cp2
+    CVM_MT_CAMELLIA_ROUND                010010 00101 rt:5 0011 0001 0001 0100 &cp2
+    CVM_MT_SMS4_ENC_CBC1                 010010 00101 rt:5 0011 0001 0001 1001 &cp2
+    CVM_MT_SMS4_ENC1                     010010 00101 rt:5 0011 0001 0001 1011 &cp2
+    CVM_MT_SMS4_DEC_CBC1                 010010 00101 rt:5 0011 0001 0001 1101 &cp2
+    CVM_MT_SMS4_DEC1                     010010 00101 rt:5 0011 0001 0001 1111 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
     CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
     CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
@@ -273,6 +284,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
+    CVM_MT_3DES_ENC_CBC                  010010 00101 rt:5 0100 0000 1000 1000 &cp2
+    CVM_MT_KAS_ENC_CBC                   010010 00101 rt:5 0100 0000 1000 1001 &cp2
+    CVM_MT_3DES_ENC                      010010 00101 rt:5 0100 0000 1000 1010 &cp2
+    CVM_MT_KAS_ENC                       010010 00101 rt:5 0100 0000 1000 1011 &cp2
+    CVM_MT_3DES_DEC_CBC                  010010 00101 rt:5 0100 0000 1000 1100 &cp2
+    CVM_MT_3DES_DEC                      010010 00101 rt:5 0100 0000 1000 1110 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
     CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b4663b35a34..76792c9c874 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -349,6 +349,23 @@ CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
 CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
 CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
 CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
+CP2_MT_HELPER(CVM_MT_AES_ENC_CBC1, aes_enc_cbc1);
+CP2_MT_HELPER(CVM_MT_AES_ENC1, aes_enc1);
+CP2_MT_HELPER(CVM_MT_AES_DEC_CBC1, aes_dec_cbc1);
+CP2_MT_HELPER(CVM_MT_AES_DEC1, aes_dec1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC_CBC1, sms4_enc_cbc1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC1, sms4_enc1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC_CBC1, sms4_dec_cbc1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC1, sms4_dec1);
+CP2_MT_HELPER(CVM_MT_3DES_ENC_CBC, des3_enc_cbc);
+CP2_MT_HELPER(CVM_MT_KAS_ENC_CBC, kas_enc_cbc);
+CP2_MT_HELPER(CVM_MT_3DES_ENC, des3_enc);
+CP2_MT_HELPER(CVM_MT_KAS_ENC, kas_enc);
+CP2_MT_HELPER(CVM_MT_3DES_DEC_CBC, des3_dec_cbc);
+CP2_MT_HELPER(CVM_MT_3DES_DEC, des3_dec);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FL, camellia_fl);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FLINV, camellia_flinv);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_ROUND, camellia_round);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);
-- 
2.53.0


