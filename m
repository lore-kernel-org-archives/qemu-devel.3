Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5533AC44502
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMK-0005k6-1S; Tue, 07 Jul 2026 14:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALO-0004uc-ES
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALJ-0006O9-OY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT7uO002266
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Qg8zaS5ttbCRCmRfPwtRufohF5TDIAM5LQDUX2T1kc=; b=QClRf9SfR1TOa455
 1EyogxBuxE6HHI+Gt0vMTufZaI9Y8TP+4UW04s63QHCGr4efns72Wl3PVk9f3NL9
 5XP9stPzsEc/90t968IShqB2iRLoZyBDEBFsya+4WFGdYz0FCALoAJ7GpYCRCFjF
 em3LeORJ3TjFklnx0JwNHqa7vYdKife68GH+flQtIAlBzVtk5A34mfHgn2lqcfBJ
 cQorfUHV70oYWlmNv9rL2j6+yeoDii1fK+JX+T5qhMTnGhAWpJv1pUAZ0uKGYcx1
 5xeTa9AI+FesXna6umphUEPrKoPFhaA6b+1KLR0UPBm2owhOzxtr2xqLJn5Vtz7+
 tBZ5dA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0j4cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ef81cc115cso9178976d6.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448181; x=1784052981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Qg8zaS5ttbCRCmRfPwtRufohF5TDIAM5LQDUX2T1kc=;
 b=CJy2kk+gPRSoPYNw95uaqRrNwAEVkb6/rcEhjRXsI3YiHkgtLZSxGdOONVIO8q0KAQ
 KCKvX7C9Jn6ML3qvuwDiZ7ppsf30ss0JFN7jCEUZ3dV2GpiWs1E4810ReTUXidM88pjq
 35acD5thSL2rWZUKbcpAGnGdWTzelFpAAc6Iq4TKPQCsYyZrSBPSou0hzCJTaUy9i/9l
 TM6d6kTnBlLbAvdXX/q8zOZzYCQZaVIxlgnpdF8ttNG5UFtnr/mzB79jgEdxgJVNYs3n
 sFzCNUGtMrwGX4g6RR3OVhTwM8B0/+sh/9wOKY20cYeL5WNdhjdgytIVzgWGU0Aym67E
 VurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448181; x=1784052981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6Qg8zaS5ttbCRCmRfPwtRufohF5TDIAM5LQDUX2T1kc=;
 b=Z/CLkeqvTxNXzmXxygwlXbEh7x+vTBn3GuGYvD5+MQBz4K2sCya7B9DU+SHtKWs7BG
 EbeHUx0Y8LSIVaTSo5UZNTbQNl+Smp5DQ0Mf/mIV/xmYcg2o0tB+4NDs08r5M1JTJgm4
 SQftKy8ce8mld9/lCOvoqdrYQQGuZwbYkTJbrUq0FbRbwyLIBx99PHtIB1B5BAH3Exle
 UCbfLlO2esCAty5kd8i70oq2Dc04rA5vv+plA05Yt5XTTXzh9ekApm0VQEoWhxtqVORJ
 eH8ZpLf4xZHNZXy+ldSc6ujNXKioPuVfwkxd2UogGjMNHm6f/B+cLosXE100MZkjj2WY
 nnfQ==
X-Gm-Message-State: AOJu0YwyehgaWPhRyPkPvvmAg0RjRLFC7alFAX2NB5LuMZt7fYkNgjdH
 QaJ3kcHZGAci5Q8WRUsX7+zZCDWp2A1Xko0HoiNgWd+JHWTx9A6OqPwEg9mDcjItsuBZPa19AHh
 sXHU+/9bwopCj5O7BEDBXJgceJUCetiQEeVfAMYHdUsYQda+JuqX0yc3nzsXv5mYO9A==
X-Gm-Gg: AfdE7cmqCI15i6rff+DBu7uwL17sTgLwpPptF3Fnac+ARLD5T0r/w8wuQhB3f+RNXLN
 zdg4jLf+lPe+aJrAMx+qlSEKaYaHUskS5eNo27sv28uIhYmQAvWKJqeg/I4+bo0t6MC5NI972G1
 21eGdwG3damME1YHCDthS83SB+KE/5bWvuQt1vq9rb+sUz40bAOo8lpW6MDz9Oy0kXH2xMxheYh
 HwEHsMTlBVpPw4/Smk27o/FnSkDh1qPuAA1jlgOuQYMOxoiQUvQPXJGAKpTdsqxVa0JYHksFKoK
 BHC6rTEmTFWbiIByxO/09DtVr1xfTGrIU1Dd2A7mGWtVsoyVKns5MwzfptBwoV0M/ca16J5u3yX
 AN7By5b1cLIsyHwR01xMksjTP7xdi12bHs6cgmgFGsJIgjzaSy6n/X2v15lc8uJmtFnKv
X-Received: by 2002:a05:622a:650:b0:51a:68df:a644 with SMTP id
 d75a77b69052e-51c7a46e933mr40956041cf.3.1783448181216; 
 Tue, 07 Jul 2026 11:16:21 -0700 (PDT)
X-Received: by 2002:a05:622a:650:b0:51a:68df:a644 with SMTP id
 d75a77b69052e-51c7a46e933mr40955501cf.3.1783448180530; 
 Tue, 07 Jul 2026 11:16:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e549dcd5sm3154675e9.1.2026.07.07.11.16.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] target/mips: add Octeon SNOW3G COP2 helpers
Date: Tue,  7 Jul 2026 20:15:12 +0200
Message-ID: <20260707181529.60191-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XA1f0Hl4XJ46VpLEEC6kUrvPE_UBXeA6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX/E7DnCrxdq6d
 z9Uk1Bwoqyc546mMMO9JV7KzY3NIbbJW3vdmwUW+8i+aagFnXammmK/UYmkyAjO5tWBDFPSui22
 4u+xrdfLNrFF0Oa1c81WJh7USkCbNZk=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4d4276 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=tEznxa4qMISWzUCv4FkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: XA1f0Hl4XJ46VpLEEC6kUrvPE_UBXeA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4sciyNRIHLgX
 FLimVecLF+3FTOCy3YZAYAhxkADTDIGO6pZck3nWVzhN0SplmsTJ25vWKVgfF9VKsLIQdB6C4RH
 vrvlapOb6YWeeXfe3r6yLBTCL/K1lCL0cc/sB1xOCwPMC4xvEKoALMZabU63dX6vydrKja5cuWg
 RsQljh0BI5WhINESeH42IKp9X8Lj0Vj8u0LFAMDWKE6FgQlcMwudSZMYN6ySyQIut0FZ5mfxrGU
 bQzkx/4KqRHj2SC8ipi5oQT89qwogqUUI32HDCwcA9+UVue+yxxneQ3foWJRDQ997U185dLL4ff
 i1IAbePuagxPbFjkbDUGm9FruRrjrXtHm3BeeHwj5TcdsdSwaUje/8xXMgTIfVzGcYRyiMo/zaG
 IB3j23jWyl1q9fiA19ytLHhjWog6TmzEi0iIVAZJ9rsTHD11GBrFxDHtWZ4KYG/2Lxm6GobFVw+
 7rw7HVK6+j2CQC4DZ5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
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

Add helper support for the Octeon SNOW3G START and MORE selectors. The
engine state and result are represented through the architectural HSH IV
and DAT register banks that SNOW3G aliases for save and restore.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-7-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   2 +
 target/mips/tcg/octeon_crypto.c | 282 ++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 292336ec629..c4e7693df63 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -50,6 +50,8 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
 DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_snow3g_start, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_snow3g_more, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 548269b9b8f..930a67346ef 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -251,6 +251,11 @@ static uint32_t octeon_crypto_lo32(uint64_t value)
     return value;
 }
 
+static uint64_t octeon_crypto_pack32(uint32_t hi, uint32_t lo)
+{
+    return ((uint64_t)hi << 32) | lo;
+}
+
 static const uint8_t octeon_zuc_s0[256] = {
     0x3e, 0x72, 0x5b, 0x47, 0xca, 0xe0, 0x00, 0x33,
     0x04, 0xd1, 0x54, 0x98, 0x09, 0xb9, 0x6d, 0xcb,
@@ -569,6 +574,283 @@ static void octeon_zuc_more(MIPSOcteonCryptoState *crypto, uint64_t data)
     octeon_zuc_advance_window(crypto, z2);
 }
 
+static const uint8_t octeon_snow3g_sr[256] = {
+    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
+    0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
+    0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
+    0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
+    0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
+    0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
+    0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
+    0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
+    0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
+    0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
+    0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
+    0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
+    0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
+    0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
+    0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
+    0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
+    0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
+    0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
+    0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
+    0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
+    0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
+    0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
+    0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
+    0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
+    0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
+    0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
+    0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
+    0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
+    0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
+    0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
+    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
+    0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16,
+};
+
+static const uint8_t octeon_snow3g_sq[256] = {
+    0x25, 0x24, 0x73, 0x67, 0xd7, 0xae, 0x5c, 0x30,
+    0xa4, 0xee, 0x6e, 0xcb, 0x7d, 0xb5, 0x82, 0xdb,
+    0xe4, 0x8e, 0x48, 0x49, 0x4f, 0x5d, 0x6a, 0x78,
+    0x70, 0x88, 0xe8, 0x5f, 0x5e, 0x84, 0x65, 0xe2,
+    0xd8, 0xe9, 0xcc, 0xed, 0x40, 0x2f, 0x11, 0x28,
+    0x57, 0xd2, 0xac, 0xe3, 0x4a, 0x15, 0x1b, 0xb9,
+    0xb2, 0x80, 0x85, 0xa6, 0x2e, 0x02, 0x47, 0x29,
+    0x07, 0x4b, 0x0e, 0xc1, 0x51, 0xaa, 0x89, 0xd4,
+    0xca, 0x01, 0x46, 0xb3, 0xef, 0xdd, 0x44, 0x7b,
+    0xc2, 0x7f, 0xbe, 0xc3, 0x9f, 0x20, 0x4c, 0x64,
+    0x83, 0xa2, 0x68, 0x42, 0x13, 0xb4, 0x41, 0xcd,
+    0xba, 0xc6, 0xbb, 0x6d, 0x4d, 0x71, 0x21, 0xf4,
+    0x8d, 0xb0, 0xe5, 0x93, 0xfe, 0x8f, 0xe6, 0xcf,
+    0x43, 0x45, 0x31, 0x22, 0x37, 0x36, 0x96, 0xfa,
+    0xbc, 0x0f, 0x08, 0x52, 0x1d, 0x55, 0x1a, 0xc5,
+    0x4e, 0x23, 0x69, 0x7a, 0x92, 0xff, 0x5b, 0x5a,
+    0xeb, 0x9a, 0x1c, 0xa9, 0xd1, 0x7e, 0x0d, 0xfc,
+    0x50, 0x8a, 0xb6, 0x62, 0xf5, 0x0a, 0xf8, 0xdc,
+    0x03, 0x3c, 0x0c, 0x39, 0xf1, 0xb8, 0xf3, 0x3d,
+    0xf2, 0xd5, 0x97, 0x66, 0x81, 0x32, 0xa0, 0x00,
+    0x06, 0xce, 0xf6, 0xea, 0xb7, 0x17, 0xf7, 0x8c,
+    0x79, 0xd6, 0xa7, 0xbf, 0x8b, 0x3f, 0x1f, 0x53,
+    0x63, 0x75, 0x35, 0x2c, 0x60, 0xfd, 0x27, 0xd3,
+    0x94, 0xa5, 0x7c, 0xa1, 0x05, 0x58, 0x2d, 0xbd,
+    0xd9, 0xc7, 0xaf, 0x6b, 0x54, 0x0b, 0xe0, 0x38,
+    0x04, 0xc8, 0x9d, 0xe7, 0x14, 0xb1, 0x87, 0x9c,
+    0xdf, 0x6f, 0xf9, 0xda, 0x2a, 0xc4, 0x59, 0x16,
+    0x74, 0x91, 0xab, 0x26, 0x61, 0x76, 0x34, 0x2b,
+    0xad, 0x99, 0xfb, 0x72, 0xec, 0x33, 0x12, 0xde,
+    0x98, 0x3b, 0xc0, 0x9b, 0x3e, 0x18, 0x10, 0x3a,
+    0x56, 0xe1, 0x77, 0xc9, 0x1e, 0x9e, 0x95, 0xa3,
+    0x90, 0x19, 0xa8, 0x6c, 0x09, 0xd0, 0xf0, 0x86,
+};
+
+static uint8_t octeon_snow3g_mulx(uint8_t v, uint8_t c)
+{
+    return (v & 0x80) ? ((v << 1) ^ c) : (v << 1);
+}
+
+static uint8_t octeon_snow3g_mulxpow(uint8_t v, unsigned int n, uint8_t c)
+{
+    while (n-- > 0) {
+        v = octeon_snow3g_mulx(v, c);
+    }
+    return v;
+}
+
+static uint32_t octeon_snow3g_pack32(uint8_t b0, uint8_t b1,
+                                     uint8_t b2, uint8_t b3)
+{
+    return ((uint32_t)b0 << 24)
+         | ((uint32_t)b1 << 16)
+         | ((uint32_t)b2 << 8)
+         | b3;
+}
+
+static uint32_t octeon_snow3g_mulalpha(uint8_t c)
+{
+    return octeon_snow3g_pack32(octeon_snow3g_mulxpow(c,  23, 0xa9),
+                                octeon_snow3g_mulxpow(c, 245, 0xa9),
+                                octeon_snow3g_mulxpow(c,  48, 0xa9),
+                                octeon_snow3g_mulxpow(c, 239, 0xa9));
+}
+
+static uint32_t octeon_snow3g_divalpha(uint8_t c)
+{
+    return octeon_snow3g_pack32(octeon_snow3g_mulxpow(c, 16, 0xa9),
+                                octeon_snow3g_mulxpow(c, 39, 0xa9),
+                                octeon_snow3g_mulxpow(c,  6, 0xa9),
+                                octeon_snow3g_mulxpow(c, 64, 0xa9));
+}
+
+static uint32_t octeon_snow3g_s1(uint32_t w)
+{
+    uint8_t x0 = octeon_snow3g_sr[w >> 24];
+    uint8_t x1 = octeon_snow3g_sr[(uint8_t)(w >> 16)];
+    uint8_t x2 = octeon_snow3g_sr[(uint8_t)(w >> 8)];
+    uint8_t x3 = octeon_snow3g_sr[(uint8_t)w];
+    uint8_t r0 = octeon_snow3g_mulx(x0, 0x1b) ^ x1 ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x1b) ^ x3;
+    uint8_t r1 = octeon_snow3g_mulx(x0, 0x1b) ^ x0 ^
+                 octeon_snow3g_mulx(x1, 0x1b) ^ x2 ^ x3;
+    uint8_t r2 = x0 ^ octeon_snow3g_mulx(x1, 0x1b) ^ x1 ^
+                 octeon_snow3g_mulx(x2, 0x1b) ^ x3;
+    uint8_t r3 = x0 ^ x1 ^ octeon_snow3g_mulx(x2, 0x1b) ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x1b);
+
+    return octeon_snow3g_pack32(r0, r1, r2, r3);
+}
+
+static uint32_t octeon_snow3g_s2(uint32_t w)
+{
+    uint8_t x0 = octeon_snow3g_sq[w >> 24];
+    uint8_t x1 = octeon_snow3g_sq[(uint8_t)(w >> 16)];
+    uint8_t x2 = octeon_snow3g_sq[(uint8_t)(w >> 8)];
+    uint8_t x3 = octeon_snow3g_sq[(uint8_t)w];
+    uint8_t r0 = octeon_snow3g_mulx(x0, 0x69) ^ x1 ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x69) ^ x3;
+    uint8_t r1 = octeon_snow3g_mulx(x0, 0x69) ^ x0 ^
+                 octeon_snow3g_mulx(x1, 0x69) ^ x2 ^ x3;
+    uint8_t r2 = x0 ^ octeon_snow3g_mulx(x1, 0x69) ^ x1 ^
+                 octeon_snow3g_mulx(x2, 0x69) ^ x3;
+    uint8_t r3 = x0 ^ x1 ^ octeon_snow3g_mulx(x2, 0x69) ^ x2 ^
+                 octeon_snow3g_mulx(x3, 0x69);
+
+    return octeon_snow3g_pack32(r0, r1, r2, r3);
+}
+
+static uint32_t octeon_snow3g_lfsr(const MIPSOcteonCryptoState *crypto,
+                                   unsigned int index)
+{
+    uint64_t pair = crypto->hsh_dat[index / 2];
+
+    return index & 1 ? octeon_crypto_lo32(pair) : octeon_crypto_hi32(pair);
+}
+
+static void octeon_snow3g_set_lfsr(MIPSOcteonCryptoState *crypto,
+                                   unsigned int index, uint32_t value)
+{
+    uint32_t hi = octeon_crypto_hi32(crypto->hsh_dat[index / 2]);
+    uint32_t lo = octeon_crypto_lo32(crypto->hsh_dat[index / 2]);
+
+    if (index & 1) {
+        lo = value;
+    } else {
+        hi = value;
+    }
+    crypto->hsh_dat[index / 2] = octeon_crypto_pack32(hi, lo);
+}
+
+static uint32_t octeon_snow3g_fsm(const MIPSOcteonCryptoState *crypto,
+                                  unsigned int index)
+{
+    return crypto->hsh_iv[1 + index];
+}
+
+static void octeon_snow3g_set_fsm(MIPSOcteonCryptoState *crypto,
+                                  unsigned int index, uint32_t value)
+{
+    crypto->hsh_iv[1 + index] = value;
+}
+
+static uint32_t octeon_snow3g_clock_fsm(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t fsm0 = octeon_snow3g_fsm(crypto, 0);
+    uint32_t fsm1 = octeon_snow3g_fsm(crypto, 1);
+    uint32_t fsm2 = octeon_snow3g_fsm(crypto, 2);
+    uint32_t f = (uint32_t)(octeon_snow3g_lfsr(crypto, 15) + fsm0) ^ fsm1;
+    uint32_t r = (uint32_t)(fsm1 + (fsm2 ^ octeon_snow3g_lfsr(crypto, 5)));
+
+    octeon_snow3g_set_fsm(crypto, 2, octeon_snow3g_s2(fsm1));
+    octeon_snow3g_set_fsm(crypto, 1, octeon_snow3g_s1(fsm0));
+    octeon_snow3g_set_fsm(crypto, 0, r);
+    return f;
+}
+
+static void octeon_snow3g_clock_lfsr(MIPSOcteonCryptoState *crypto,
+                                     bool init_mode, uint32_t f)
+{
+    uint32_t lfsr[16];
+    uint32_t s0;
+    uint32_t s11;
+    uint32_t v;
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        lfsr[i] = octeon_snow3g_lfsr(crypto, i);
+    }
+
+    s0 = lfsr[0];
+    s11 = lfsr[11];
+    v = (s0 << 8) ^ octeon_snow3g_mulalpha(s0 >> 24) ^
+        lfsr[2] ^ (s11 >> 8) ^ octeon_snow3g_divalpha((uint8_t)s11);
+
+    if (init_mode) {
+        v ^= f;
+    }
+
+    for (i = 0; i < 15; i++) {
+        octeon_snow3g_set_lfsr(crypto, i, lfsr[i + 1]);
+    }
+    octeon_snow3g_set_lfsr(crypto, 15, v);
+}
+
+static uint32_t octeon_snow3g_generate_word(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t f = octeon_snow3g_clock_fsm(crypto);
+    uint32_t z = f ^ octeon_snow3g_lfsr(crypto, 0);
+
+    octeon_snow3g_clock_lfsr(crypto, false, 0);
+    return z;
+}
+
+static void octeon_snow3g_queue_result(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t z0 = octeon_snow3g_generate_word(crypto);
+    uint32_t z1 = octeon_snow3g_generate_word(crypto);
+
+    crypto->hsh_iv[0] = octeon_crypto_pack32(z0, z1);
+}
+
+static void octeon_snow3g_start(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    int i;
+
+    for (i = 0; i < 14; i++) {
+        octeon_snow3g_set_lfsr(crypto, i, octeon_snow3g_lfsr(crypto, i));
+    }
+    octeon_snow3g_set_lfsr(crypto, 14, data >> 32);
+    octeon_snow3g_set_lfsr(crypto, 15, data);
+    for (i = 0; i < 3; i++) {
+        octeon_snow3g_set_fsm(crypto, i, 0);
+    }
+
+    for (i = 0; i < 32; i++) {
+        uint32_t f = octeon_snow3g_clock_fsm(crypto);
+
+        octeon_snow3g_clock_lfsr(crypto, true, f);
+    }
+
+    (void)octeon_snow3g_clock_fsm(crypto);
+    octeon_snow3g_clock_lfsr(crypto, false, 0);
+    octeon_snow3g_queue_result(crypto);
+}
+
+static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
+{
+    octeon_snow3g_queue_result(crypto);
+}
+
+void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_snow3g_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_snow3g_more(CPUMIPSState *env, uint64_t value)
+{
+    (void)value;
+    octeon_snow3g_more(&env->octeon_crypto);
+}
+
 void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_zuc_start(&env->octeon_crypto, value);
-- 
2.53.0


