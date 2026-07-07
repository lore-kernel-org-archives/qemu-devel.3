Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46715C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMh-0006Op-Vj; Tue, 07 Jul 2026 14:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALl-0005Ed-Sw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALg-0006Qf-Ue
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTBlb018008
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5M6snpFZmFwIYvtpDT6MQ6iIpZtqDxNvfy3bhHDcL9Y=; b=hb/KF3RSyVmcvnjX
 /XPCTrGiPVvMUN+h0thyBWo6sHBT6Rygc7boHC2Ggaw8yGEGeeTnGRrnRp9fPxGE
 OdBGQ7cetflAwxQznlqlFnp3/qptdZ2aLaeg00TGEeMBShUBoJL6F4GlPF2YHdZJ
 8q2k/Jy9WR9sg1KJrZ/Be0a4IeSnCSf0dSKuO//cYTrlYcKtYJkzj/s6J5G2asnu
 +J546cdDtjRtJ/vRdvLNmVRKMwHkurIU6Z8kxPRhNAQzQBfkVpLtpjywxq82DWaB
 yXg2OG40iMHmjX6mHw/npWtWinl+g50tpsv7kXDdOfJrQgtKZXatUHim0n79rebB
 aEUhlw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep2p0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso90614421cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448204; x=1784053004; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5M6snpFZmFwIYvtpDT6MQ6iIpZtqDxNvfy3bhHDcL9Y=;
 b=Uxhu4eFUL25TSr/enEnwpRGplqAVULlvf+zhsHQp/Hi5jaPxoeL8sz4xFtxWHf4uLz
 CH+vFtfX9MZd88UHVImpZZwzLqtRO67PnuA2BSxl62IHOHcuUEMN/8qFNKeoxNAxqjXf
 zmIjabiD+9ixq77IMRML5Of1pDF3i6nX9LYqI2BsFQqjy5vY6RQme1PPBb34vP82mxdV
 9KhFSNqcAzZ1G/Nl6uECMY5szV/5LVA5ctwMrnVnGKv/Nmi3xeBAYGAb0L8QbvE608yx
 2ywYg67F7yzW/Bc4ZQ4ufS4xbDQ6J7ifBpX/4ouXUqMa7aHf9ogHgmNYrL7yT/1sgjSH
 sQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448204; x=1784053004;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5M6snpFZmFwIYvtpDT6MQ6iIpZtqDxNvfy3bhHDcL9Y=;
 b=ANRS6IL/jUa1wO2JqEFiax3b3v1HSzTQTuyolxZ/3mMCHjZP8nbhWkCBxyOU9JVv2z
 Y4mnWh+pbMvuuyYqHjoWd0M+ZcosGPdzPjgzLzhPQ/M2BvKVe9hRFIqEuESJTdyBri2Q
 LskvmDgUqb/JVKB7k4Bc9+wjdzC/AjkyaZyemfpwhz4KN4ocnlM3LeA7ycm+YWzQgfqx
 XX2/l1/3NkEPcpdZaAckwB1w+V8aLJ55onQ75CiHXqJSKVdQMqoNnjlhm3n82Mg6RrwH
 zROkdxVn0DtJ/yx+U0a7MbjS1Mf2/jRVq9jhWPJivohZ5n3NdKLeaUAHOphB2+Kp9lP2
 bCLQ==
X-Gm-Message-State: AOJu0YyW9jP3mDWIgnjrzYlVv9uA5DBDIYWdPsH8x0om4c6nirUjLzqV
 JGam90Hh6gKqIM+RiHPBQ5xcY6V56qKm/jFmi8C2jYTG1C26sePtQP6J6g3rcbsmZ4uiEZtCcD5
 G05pBy2lOANGaNjv9QMj+ki+dsmnsf5miIXnq6bCxF1efGXyaAMM/tnHM1i84Q2UQBA==
X-Gm-Gg: AfdE7cnNy6SeCO1Yn/CxmnQjNL8q4UgytLuK8uKtoyMz9SB/dRBZWnunWycuVkZm51I
 51Eh33EOtWIKLZhZUmxMvq7NnYMlrJtPrY/OT/DqZeAQVWXmN8sbQlG7zfUqZVA9WrP/ALSm0m3
 VccuFUdoeuhLylZr6E+8wHHqPecyuej1EfiGbojCIyieMbGjHsDRjblmHEOYVrLYTdIguvOl6lM
 RmqIOlJ6xXEw1BQBAeapd3SdomzWbe1oknWKKaEJmFOfUW4dJGDh1w4oOPNwkU83du4MToVRKFc
 2Tid6cimMdhDtgxzlFVomBpj6PN+5HqqCUSGOXK3w6FFu7A4dEh1ayFZclpdE4KwlvPT7NxF8hb
 xbmzRqSEvRWWqypH455v5eesSwGFDGbrVa/qdXbRZoPHvtz6qejxB9rkJ681gu7rTTxr9
X-Received: by 2002:ac8:7d47:0:b0:51a:8c86:bd40 with SMTP id
 d75a77b69052e-51c748c56a0mr69925701cf.61.1783448203809; 
 Tue, 07 Jul 2026 11:16:43 -0700 (PDT)
X-Received: by 2002:ac8:7d47:0:b0:51a:8c86:bd40 with SMTP id
 d75a77b69052e-51c748c56a0mr69923991cf.61.1783448201453; 
 Tue, 07 Jul 2026 11:16:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm33345786f8f.10.2026.07.07.11.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/23] target/mips: add Octeon 3DES and KASUMI COP2 helpers
Date: Tue,  7 Jul 2026 20:15:15 +0200
Message-ID: <20260707181529.60191-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8doOraWg5wkBN_NzxPwuBLCBLDaDN9pA
X-Proofpoint-ORIG-GUID: 8doOraWg5wkBN_NzxPwuBLCBLDaDN9pA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX9YrVdOgtDx5c
 Jye83t1kb3qfK10F8jEFDRGjmkp3f3RGqMo8MT2JZ8QJwPUi1OZ4L41PLy1LXIRFQ24wsiDniCZ
 4TypdfUB5GSng261V5h12mds8yXuzMhH5ymkYNRMlcxmr2VDtpsGXEmk4EOV3SdcVlxZiIFNoB0
 9eFZAEIDUsEtRuF7QET5W4p0VS89aukZmbuz7cyDkZ13QWPOOfycijDJucTHp3jQ4HChUN8FPxm
 /5z3lqQiYZC0ntm2RGzCsDZ6DjzWPU7QxK26fbHenUUUd+ZCMp48Q4zAVTaMxeDb/5J4lCf9yT/
 LAKA2vvzsrtae0U5QNv+rjQLfEhlDDkvjcgjIuf0hsryPtBA7RhLzNz4i1pBQfv2ovKUDj943cz
 NmVO4MIeWUy+CcH30SUhTFQ3YG7RqtwA1jAuBpfAH3CseDGWwe4UpkrSH+6PNgcEhB8iFYTx4Js
 E12n0NREQPLlaGY026g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX7q987XDAJDYC
 ruCvPPz9uxA0f8M50dbYsXU6aVaE14wswL2TrSYrF8Aupw08mSWILCzw8HbubrP6iyipFz4w8QD
 y4fCLJRExpRRlbgaGEUungNexq2fXmo=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d428d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aUFnen29rhRlqlhoDbIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add helper support for the Octeon 3DES and KASUMI operation selectors.
The 3DES helpers implement ECB and CBC encrypt/decrypt over the shared
3DES key, IV, and result bank. KASUMI reuses the same register bank and
adds its own encrypt selectors.

Only the operation selectors require helper code. Simple key, IV, and
result register transfers are handled by direct selector decode.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-10-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   6 +
 target/mips/tcg/octeon_crypto.c | 458 ++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 4949b94657f..c9332c5c522 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -60,6 +60,12 @@ DEF_HELPER_2(octeon_cp2_mt_sms4_enc_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sms4_enc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sms4_dec_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sms4_dec1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_enc_cbc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_kas_enc_cbc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_enc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_kas_enc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_dec_cbc, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index bcffd17ab6c..8ea79e37568 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1108,6 +1108,464 @@ void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
     octeon_sms4_crypt_common(crypto, false, false);
 }
 
+static const uint8_t octeon_des_ip[64] = {
+    58, 50, 42, 34, 26, 18, 10,  2,
+    60, 52, 44, 36, 28, 20, 12,  4,
+    62, 54, 46, 38, 30, 22, 14,  6,
+    64, 56, 48, 40, 32, 24, 16,  8,
+    57, 49, 41, 33, 25, 17,  9,  1,
+    59, 51, 43, 35, 27, 19, 11,  3,
+    61, 53, 45, 37, 29, 21, 13,  5,
+    63, 55, 47, 39, 31, 23, 15,  7,
+};
+
+static const uint8_t octeon_des_fp[64] = {
+    40,  8, 48, 16, 56, 24, 64, 32,
+    39,  7, 47, 15, 55, 23, 63, 31,
+    38,  6, 46, 14, 54, 22, 62, 30,
+    37,  5, 45, 13, 53, 21, 61, 29,
+    36,  4, 44, 12, 52, 20, 60, 28,
+    35,  3, 43, 11, 51, 19, 59, 27,
+    34,  2, 42, 10, 50, 18, 58, 26,
+    33,  1, 41,  9, 49, 17, 57, 25,
+};
+
+static const uint8_t octeon_des_e[48] = {
+    32,  1,  2,  3,  4,  5,
+     4,  5,  6,  7,  8,  9,
+     8,  9, 10, 11, 12, 13,
+    12, 13, 14, 15, 16, 17,
+    16, 17, 18, 19, 20, 21,
+    20, 21, 22, 23, 24, 25,
+    24, 25, 26, 27, 28, 29,
+    28, 29, 30, 31, 32,  1,
+};
+
+static const uint8_t octeon_des_p[32] = {
+    16,  7, 20, 21, 29, 12, 28, 17,
+     1, 15, 23, 26,  5, 18, 31, 10,
+     2,  8, 24, 14, 32, 27,  3,  9,
+    19, 13, 30,  6, 22, 11,  4, 25,
+};
+
+static const uint8_t octeon_des_pc1[56] = {
+    57, 49, 41, 33, 25, 17,  9,
+     1, 58, 50, 42, 34, 26, 18,
+    10,  2, 59, 51, 43, 35, 27,
+    19, 11,  3, 60, 52, 44, 36,
+    63, 55, 47, 39, 31, 23, 15,
+     7, 62, 54, 46, 38, 30, 22,
+    14,  6, 61, 53, 45, 37, 29,
+    21, 13,  5, 28, 20, 12,  4,
+};
+
+static const uint8_t octeon_des_pc2[48] = {
+    14, 17, 11, 24,  1,  5,
+     3, 28, 15,  6, 21, 10,
+    23, 19, 12,  4, 26,  8,
+    16,  7, 27, 20, 13,  2,
+    41, 52, 31, 37, 47, 55,
+    30, 40, 51, 45, 33, 48,
+    44, 49, 39, 56, 34, 53,
+    46, 42, 50, 36, 29, 32,
+};
+
+static const uint8_t octeon_des_rotations[16] = {
+    1, 1, 2, 2, 2, 2, 2, 2,
+    1, 2, 2, 2, 2, 2, 2, 1,
+};
+
+static const uint8_t octeon_des_sboxes[8][64] = {
+    {
+        14, 4, 13, 1,  2, 15, 11, 8,  3, 10, 6, 12, 5, 9, 0, 7,
+         0, 15, 7, 4, 14,  2, 13, 1, 10,  6, 12, 11, 9, 5, 3, 8,
+         4, 1, 14, 8, 13,  6,  2, 11, 15, 12, 9,  7, 3, 10, 5, 0,
+        15, 12, 8, 2,  4,  9,  1, 7,  5, 11, 3, 14, 10, 0, 6, 13,
+    },
+    {
+        15, 1,  8, 14, 6, 11, 3, 4,  9, 7, 2, 13, 12, 0, 5, 10,
+         3, 13, 4, 7, 15, 2,  8, 14, 12, 0, 1, 10,  6, 9, 11, 5,
+         0, 14, 7, 11, 10, 4, 13, 1,  5, 8, 12, 6,  9, 3,  2, 15,
+        13, 8, 10, 1,  3, 15, 4, 2, 11, 6, 7, 12,  0, 5, 14, 9,
+    },
+    {
+        10, 0,  9, 14, 6, 3, 15, 5,  1, 13, 12, 7, 11, 4, 2, 8,
+        13, 7,  0, 9,  3, 4, 6,  10, 2, 8,  5, 14, 12, 11, 15, 1,
+        13, 6,  4, 9,  8, 15, 3, 0, 11, 1,  2, 12,  5, 10, 14, 7,
+         1, 10, 13, 0,  6, 9, 8, 7,  4, 15, 14, 3, 11, 5,  2, 12,
+    },
+    {
+         7, 13, 14, 3,  0, 6, 9, 10, 1, 2, 8,  5, 11, 12, 4, 15,
+        13, 8,  11, 5,  6, 15, 0, 3,  4, 7, 2, 12, 1,  10, 14, 9,
+        10, 6,  9,  0, 12, 11, 7, 13, 15, 1, 3, 14, 5,  2,  8,  4,
+         3, 15, 0,  6, 10, 1, 13, 8,  9, 4, 5, 11, 12, 7,  2,  14,
+    },
+    {
+         2, 12, 4,  1,  7, 10, 11, 6,  8, 5, 3, 15, 13, 0, 14, 9,
+        14, 11, 2,  12, 4, 7,  13, 1,  5, 0, 15, 10, 3,  9, 8,  6,
+         4, 2,  1,  11, 10, 13, 7, 8, 15, 9, 12, 5,  6,  3, 0, 14,
+        11, 8,  12, 7,  1, 14, 2, 13, 6, 15, 0,  9, 10, 4, 5,  3,
+    },
+    {
+        12, 1,  10, 15, 9, 2,  6, 8,  0, 13, 3, 4, 14, 7, 5, 11,
+        10, 15, 4,  2,  7, 12, 9, 5,  6, 1,  13, 14, 0, 11, 3, 8,
+         9, 14, 15, 5,  2, 8,  12, 3,  7, 0,  4, 10, 1, 13, 11, 6,
+         4, 3,  2,  12, 9, 5,  15, 10, 11, 14, 1, 7,  6, 0,  8, 13,
+    },
+    {
+         4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7,  5, 10, 6, 1,
+        13, 0,  11, 7,  4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
+         1, 4,  11, 13, 12, 3, 7, 14, 10, 15, 6, 8,  0, 5,  9, 2,
+         6, 11, 13, 8,  1, 4, 10, 7,  9, 5,  0, 15, 14, 2,  3, 12,
+    },
+    {
+        13, 2,  8, 4,  6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
+         1, 15, 13, 8, 10, 3,  7,  4, 12, 5, 6, 11, 0, 14, 9,  2,
+         7, 11, 4,  1,  9, 12, 14, 2, 0,  6, 10, 13, 15, 3, 5, 8,
+         2, 1,  14, 7,  4, 10, 8,  13, 15, 12, 9, 0,  3,  5, 6, 11,
+    },
+};
+
+static const uint8_t octeon_kasumi_s7[128] = {
+     54,  50,  62,  56,  22,  34,  94,  96,  38,   6,  63,  93,   2,  18,
+    123,  33,  55, 113,  39, 114,  21,  67,  65,  12,  47,  73,  46,  27,
+     25, 111, 124,  81,  53,   9, 121,  79,  52,  60,  58,  48, 101, 127,
+     40, 120, 104,  70,  71,  43,  20, 122,  72,  61,  23, 109,  13, 100,
+     77,   1,  16,   7,  82,  10, 105,  98, 117, 116,  76,  11,  89, 106,
+      0, 125, 118,  99,  86,  69,  30,  57, 126,  87, 112,  51,  17,   5,
+     95,  14,  90,  84,  91,   8,  35, 103,  32,  97,  28,  66, 102,  31,
+     26,  45,  75,   4,  85,  92,  37,  74,  80,  49,  68,  29, 115,  44,
+     64, 107, 108,  24, 110,  83,  36,  78,  42,  19,  15,  41,  88, 119,
+     59,   3,
+};
+
+static const uint16_t octeon_kasumi_s9[512] = {
+    167, 239, 161, 379, 391, 334,   9, 338,  38, 226,  48, 358, 452, 385,
+     90, 397, 183, 253, 147, 331, 415, 340,  51, 362, 306, 500, 262,  82,
+    216, 159, 356, 177, 175, 241, 489,  37, 206,  17,   0, 333,  44, 254,
+    378,  58, 143, 220,  81, 400,  95,   3, 315, 245,  54, 235, 218, 405,
+    472, 264, 172, 494, 371, 290, 399,  76, 165, 197, 395, 121, 257, 480,
+    423, 212, 240,  28, 462, 176, 406, 507, 288, 223, 501, 407, 249, 265,
+     89, 186, 221, 428, 164,  74, 440, 196, 458, 421, 350, 163, 232, 158,
+    134, 354,  13, 250, 491, 142, 191,  69, 193, 425, 152, 227, 366, 135,
+    344, 300, 276, 242, 437, 320, 113, 278,  11, 243,  87, 317,  36,  93,
+    496,  27, 487, 446, 482,  41,  68, 156, 457, 131, 326, 403, 339,  20,
+     39, 115, 442, 124, 475, 384, 508,  53, 112, 170, 479, 151, 126, 169,
+     73, 268, 279, 321, 168, 364, 363, 292,  46, 499, 393, 327, 324,  24,
+    456, 267, 157, 460, 488, 426, 309, 229, 439, 506, 208, 271, 349, 401,
+    434, 236,  16, 209, 359,  52,  56, 120, 199, 277, 465, 416, 252, 287,
+    246,   6,  83, 305, 420, 345, 153, 502,  65,  61, 244, 282, 173, 222,
+    418,  67, 386, 368, 261, 101, 476, 291, 195, 430,  49,  79, 166, 330,
+    280, 383, 373, 128, 382, 408, 155, 495, 367, 388, 274, 107, 459, 417,
+     62, 454, 132, 225, 203, 316, 234,  14, 301,  91, 503, 286, 424, 211,
+    347, 307, 140, 374,  35, 103, 125, 427,  19, 214, 453, 146, 498, 314,
+    444, 230, 256, 329, 198, 285,  50, 116,  78, 410,  10, 205, 510, 171,
+    231,  45, 139, 467,  29,  86, 505,  32,  72,  26, 342, 150, 313, 490,
+    431, 238, 411, 325, 149, 473,  40, 119, 174, 355, 185, 233, 389,  71,
+    448, 273, 372,  55, 110, 178, 322,  12, 469, 392, 369, 190,   1, 109,
+    375, 137, 181,  88,  75, 308, 260, 484,  98, 272, 370, 275, 412, 111,
+    336, 318,   4, 504, 492, 259, 304,  77, 337, 435,  21, 357, 303, 332,
+    483,  18,  47,  85,  25, 497, 474, 289, 100, 269, 296, 478, 270, 106,
+     31, 104, 433,  84, 414, 486, 394,  96,  99, 154, 511, 148, 413, 361,
+    409, 255, 162, 215, 302, 201, 266, 351, 343, 144, 441, 365, 108, 298,
+    251,  34, 182, 509, 138, 210, 335, 133, 311, 352, 328, 141, 396, 346,
+    123, 319, 450, 281, 429, 228, 443, 481,  92, 404, 485, 422, 248, 297,
+     23, 213, 130, 466,  22, 217, 283,  70, 294, 360, 419, 127, 312, 377,
+      7, 468, 194,   2, 117, 295, 463, 258, 224, 447, 247, 187,  80, 398,
+    284, 353, 105, 390, 299, 471, 470, 184,  57, 200, 348,  63, 204, 188,
+     33, 451,  97,  30, 310, 219,  94, 160, 129, 493,  64, 179, 263, 102,
+    189, 207, 114, 402, 438, 477, 387, 122, 192,  42, 381,   5, 145, 118,
+    180, 449, 293, 323, 136, 380,  43,  66,  60, 455, 341, 445, 202, 432,
+      8, 237,  15, 376, 436, 464,  59, 461,
+};
+
+static const uint16_t octeon_kasumi_constants[8] = {
+    0x0123, 0x4567, 0x89ab, 0xcdef, 0xfedc, 0xba98, 0x7654, 0x3210,
+};
+
+typedef struct OcteonKasumiSubkeys {
+    uint16_t kli1[8];
+    uint16_t kli2[8];
+    uint16_t koi1[8];
+    uint16_t koi2[8];
+    uint16_t koi3[8];
+    uint16_t kii1[8];
+    uint16_t kii2[8];
+    uint16_t kii3[8];
+} OcteonKasumiSubkeys;
+
+static uint64_t octeon_des_permute(uint64_t input, const uint8_t *table,
+                                   size_t output_bits, size_t input_bits)
+{
+    uint64_t out = 0;
+
+    for (size_t i = 0; i < output_bits; i++) {
+        unsigned src = table[i] - 1;
+
+        out = (out << 1) | ((input >> (input_bits - 1 - src)) & 1);
+    }
+    return out;
+}
+
+static uint32_t octeon_des_rotate28(uint32_t v, unsigned shift)
+{
+    return ((v << shift) | (v >> (28 - shift))) & 0x0fffffffU;
+}
+
+static void octeon_des_expand_subkeys(uint64_t key, uint64_t subkeys[16])
+{
+    uint64_t permuted = octeon_des_permute(key, octeon_des_pc1,
+                                           ARRAY_SIZE(octeon_des_pc1), 64);
+    uint32_t c = (permuted >> 28) & 0x0fffffffU;
+    uint32_t d = permuted & 0x0fffffffU;
+
+    for (int i = 0; i < 16; i++) {
+        c = octeon_des_rotate28(c, octeon_des_rotations[i]);
+        d = octeon_des_rotate28(d, octeon_des_rotations[i]);
+        subkeys[i] = octeon_des_permute(((uint64_t)c << 28) | d,
+                                        octeon_des_pc2,
+                                        ARRAY_SIZE(octeon_des_pc2), 56);
+    }
+}
+
+static uint32_t octeon_des_f(uint32_t r, uint64_t subkey)
+{
+    uint64_t expanded = octeon_des_permute(r, octeon_des_e,
+                                           ARRAY_SIZE(octeon_des_e), 32);
+    uint32_t out = 0;
+
+    expanded ^= subkey;
+    for (int i = 0; i < 8; i++) {
+        uint8_t sextet = (expanded >> (42 - i * 6)) & 0x3f;
+        uint8_t row = ((sextet & 0x20) >> 4) | (sextet & 0x01);
+        uint8_t col = (sextet >> 1) & 0x0f;
+
+        out = (out << 4) | octeon_des_sboxes[i][row * 16 + col];
+    }
+
+    return octeon_des_permute(out, octeon_des_p, ARRAY_SIZE(octeon_des_p), 32);
+}
+
+static uint64_t octeon_des_block_crypt(uint64_t block, uint64_t key,
+                                       bool encrypt)
+{
+    uint64_t subkeys[16];
+    uint64_t permuted = octeon_des_permute(block, octeon_des_ip,
+                                           ARRAY_SIZE(octeon_des_ip), 64);
+    uint32_t l = permuted >> 32;
+    uint32_t r = permuted;
+
+    octeon_des_expand_subkeys(key, subkeys);
+
+    for (int i = 0; i < 16; i++) {
+        uint32_t next = l ^ octeon_des_f(r, subkeys[encrypt ? i : 15 - i]);
+
+        l = r;
+        r = next;
+    }
+
+    return octeon_des_permute(((uint64_t)r << 32) | l,
+                              octeon_des_fp, ARRAY_SIZE(octeon_des_fp), 64);
+}
+
+static uint64_t octeon_3des_block_crypt(uint64_t block, const uint64_t keys[3],
+                                        bool encrypt)
+{
+    if (encrypt) {
+        block = octeon_des_block_crypt(block, keys[0], true);
+        block = octeon_des_block_crypt(block, keys[1], false);
+        block = octeon_des_block_crypt(block, keys[2], true);
+    } else {
+        block = octeon_des_block_crypt(block, keys[2], false);
+        block = octeon_des_block_crypt(block, keys[1], true);
+        block = octeon_des_block_crypt(block, keys[0], false);
+    }
+    return block;
+}
+
+static void octeon_3des_crypt_common(MIPSOcteonCryptoState *crypto,
+                                     uint64_t input_reg,
+                                     bool encrypt, bool cbc)
+{
+    const uint64_t keys[3] = {
+        crypto->des3_key[0],
+        crypto->des3_key[1],
+        crypto->des3_key[2],
+    };
+    uint64_t block = input_reg;
+
+    if (cbc) {
+        if (encrypt) {
+            block ^= crypto->des3_iv;
+            block = octeon_3des_block_crypt(block, keys, true);
+            crypto->des3_iv = block;
+        } else {
+            block = octeon_3des_block_crypt(block, keys, false);
+            block ^= crypto->des3_iv;
+            crypto->des3_iv = input_reg;
+        }
+    } else {
+        block = octeon_3des_block_crypt(block, keys, encrypt);
+    }
+
+    crypto->des3_result = block;
+}
+
+static uint16_t octeon_rol16(uint16_t value, unsigned int bits)
+{
+    return (value << bits) | (value >> (16 - bits));
+}
+
+static void octeon_kasumi_key_schedule(const uint64_t key_regs[2],
+                                       OcteonKasumiSubkeys *subkeys)
+{
+    uint16_t key[8];
+    uint16_t key_prime[8];
+
+    key[0] = key_regs[0] >> 48;
+    key[1] = key_regs[0] >> 32;
+    key[2] = key_regs[0] >> 16;
+    key[3] = key_regs[0];
+    key[4] = key_regs[1] >> 48;
+    key[5] = key_regs[1] >> 32;
+    key[6] = key_regs[1] >> 16;
+    key[7] = key_regs[1];
+
+    for (int i = 0; i < 8; i++) {
+        key_prime[i] = key[i] ^ octeon_kasumi_constants[i];
+    }
+
+    for (int i = 0; i < 8; i++) {
+        subkeys->kli1[i] = octeon_rol16(key[i], 1);
+        subkeys->kli2[i] = key_prime[(i + 2) & 7];
+        subkeys->koi1[i] = octeon_rol16(key[(i + 1) & 7], 5);
+        subkeys->koi2[i] = octeon_rol16(key[(i + 5) & 7], 8);
+        subkeys->koi3[i] = octeon_rol16(key[(i + 6) & 7], 13);
+        subkeys->kii1[i] = key_prime[(i + 4) & 7];
+        subkeys->kii2[i] = key_prime[(i + 3) & 7];
+        subkeys->kii3[i] = key_prime[(i + 7) & 7];
+    }
+}
+
+static uint16_t octeon_kasumi_fi(uint16_t in, uint16_t subkey)
+{
+    uint16_t nine = in >> 7;
+    uint16_t seven = in & 0x7f;
+
+    nine = octeon_kasumi_s9[nine] ^ seven;
+    seven = octeon_kasumi_s7[seven] ^ (nine & 0x7f);
+    seven ^= subkey >> 9;
+    nine ^= subkey & 0x1ff;
+    nine = octeon_kasumi_s9[nine] ^ seven;
+    seven = octeon_kasumi_s7[seven] ^ (nine & 0x7f);
+    return (seven << 9) | nine;
+}
+
+static uint32_t octeon_kasumi_fo(uint32_t in, int index,
+                                 const OcteonKasumiSubkeys *subkeys)
+{
+    uint16_t left = in >> 16;
+    uint16_t right = in;
+
+    left ^= subkeys->koi1[index];
+    left = octeon_kasumi_fi(left, subkeys->kii1[index]);
+    left ^= right;
+    right ^= subkeys->koi2[index];
+    right = octeon_kasumi_fi(right, subkeys->kii2[index]);
+    right ^= left;
+    left ^= subkeys->koi3[index];
+    left = octeon_kasumi_fi(left, subkeys->kii3[index]);
+    left ^= right;
+
+    return ((uint32_t)right << 16) | left;
+}
+
+static uint32_t octeon_kasumi_fl(uint32_t in, int index,
+                                 const OcteonKasumiSubkeys *subkeys)
+{
+    uint16_t left = in >> 16;
+    uint16_t right = in;
+    uint16_t a = left & subkeys->kli1[index];
+    uint16_t b;
+
+    right ^= octeon_rol16(a, 1);
+    b = right | subkeys->kli2[index];
+    left ^= octeon_rol16(b, 1);
+    return ((uint32_t)left << 16) | right;
+}
+
+static uint64_t octeon_kasumi_block_encrypt(uint64_t block,
+                                            const uint64_t key_regs[2])
+{
+    OcteonKasumiSubkeys subkeys;
+    uint32_t left = block >> 32;
+    uint32_t right = block;
+
+    octeon_kasumi_key_schedule(key_regs, &subkeys);
+
+    for (int i = 0; i < 8; ) {
+        uint32_t temp = octeon_kasumi_fl(left, i, &subkeys);
+
+        temp = octeon_kasumi_fo(temp, i++, &subkeys);
+        right ^= temp;
+        temp = octeon_kasumi_fo(right, i, &subkeys);
+        temp = octeon_kasumi_fl(temp, i++, &subkeys);
+        left ^= temp;
+    }
+
+    return ((uint64_t)left << 32) | right;
+}
+
+static void octeon_kasumi_crypt_common(MIPSOcteonCryptoState *crypto,
+                                       uint64_t input_reg, bool cbc)
+{
+    const uint64_t key_regs[2] = {
+        crypto->des3_key[0],
+        crypto->des3_key[1],
+    };
+    uint64_t block = input_reg;
+
+    if (cbc) {
+        block ^= crypto->des3_iv;
+    }
+
+    block = octeon_kasumi_block_encrypt(block, key_regs);
+    if (cbc) {
+        crypto->des3_iv = block;
+    }
+    crypto->des3_result = block;
+}
+
+void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);
+}
+
+void helper_octeon_cp2_mt_kas_enc_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_kasumi_crypt_common(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_des3_enc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, true, false);
+}
+
+void helper_octeon_cp2_mt_kas_enc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_kasumi_crypt_common(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_des3_dec_cbc(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, false, true);
+}
+
+void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
+{
+    octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);
-- 
2.53.0


