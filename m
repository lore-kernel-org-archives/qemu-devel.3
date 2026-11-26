Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=noLkTpRH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aovx0Pyl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj2o-00078Q-74; Thu, 26 Nov 2026 18:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2T-0006CF-MN
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2Q-0000SY-Ur
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:05 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQK03NX1715668
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UeLXE4d96fbTkFdswGqyRCe9nALWzm6+6sS29bl2VXQ=; b=noLkTpRHjV5K1bre
 YQU94M25a8pcl3CUkIUVzYKRg0ytFTcRQRzGaUzNwLg1I6Ke572KK3fUqgR/iwXE
 yZoH2D70B6+NC97Z9V76wqaY5/oiCisqnndIrfWuRcDR4b9Sr8kc9UzLGfEqw+yc
 2Cn05pLWWVbmcvbBYD2jakL8x9W1zR5Mk4akKZAVEDlti7hPmjawOYMoIlY94lAV
 9xtxdwp0p+pRsYzHanVF8GQMFunQyBIh+KSyTanEqsb7tb8ztqgO/9Y9VyHnhPAR
 2b5q6GTL0g2XrFT/B23BLt1Gu7a9EUFV7S5/EyiHqywy1NDBwVwfBSVCFcjID3y8
 HKTTNQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2u7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94967c6d4f4so839809785a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736271; x=1796341071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UeLXE4d96fbTkFdswGqyRCe9nALWzm6+6sS29bl2VXQ=;
 b=Aovx0PylArpxUhtGPe+6FROtZt7uoZOeR5b7+Lf44YGF8Axfxr2MP3hrkhEQ2rhYBj
 vV1iQRsAD1xnOAb+Ehnono8ZUmGzGIS7lreDoRUbESk8mmm8i7L57Oq/fSUZQ5kcnELD
 AEfShQijlgVVUZzM2Fv9VAI3pBK0c/ZOvJD68013oi4VJofeBV05+QaJeCiowNwpaklG
 04YD+YLE6BucLrvnRhB04pjkCvsov1hhW/YHiruZNuloe4bJADLpeySUlefCV01Ou3V8
 z06GAIchup2nt7IaiUzhCeWV6tZwcrd+ZPrQGJ2HxsXkd4EcnA5XtTDmnrd3hkSDEn/a
 NJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736271; x=1796341071;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UeLXE4d96fbTkFdswGqyRCe9nALWzm6+6sS29bl2VXQ=;
 b=DxRhJXGHhzfwFQaT9LAMFIBU4K0bwsZ0XL3oUk/iePTwrSW7Vo86tatvvt66/an08n
 9E3mwbi1aq6C5cN9dtHbKckonAxRSTPoZ8xWYUseePEdffRDANTFG89NXBL+k3yupO/e
 EcideGjtgKEN5BBcbgKiPL7UNzH18583ss6iWsIjnmwJyxO6RC2N8oMDxUw1ypClRYKy
 SwHjFmJFuosNEeKAkaPjDJSKo/bRbDsSIxUMBEODvDf6S2PqALPDNjBRsLVVtPeTgwqu
 DhTMd/+MKMNPqaqYdny8i13D59yjozAlyUGB5HQVMIkdBwyC+7r+bPzDjzkzUtSs7+Cs
 tV4g==
X-Gm-Message-State: APuU4Z/wn/87OF6rHOmu+jfIY6yXB291hxPNAyAs1uXqLiayHAglltKZ
 evVdjSrIgvtpmikGTPxDDrfODuoe6g6U4bLncRP0JmOIxyjmHRPRTqBAikLhR4IS8+16kUfUuZL
 +YO7PAAWptzJXJ9nzDwnwAyQ0cFyLsJlr6V5WGXYNCvqv0RKOmGqcxcPSUirdTvMhTg==
X-Gm-Gg: AZFdTZcdo6uVyMo7UuHl1iVw3UirQGWxbDg1FIqNsC7lNwxArGocdG8FZ1j00FUSBUY
 gRbEQ4o5Ebbdi9en1hJlepLqgzydM9NBnehciDGjOekwILSptb0sx/ORFUX0gTwTedBUaFa1zwD
 DBz8UUUln0FCxVofCyVR9DujQAvyNaTAHyl4wZ4RRwjCZFTOwtZZViimk+ccxnHE7nDsV8VB9ka
 vkj7LRPl56rZbLdXLqPZZ7GAUpwNVc/XzfIOhitNZbVsMMvW+m2m6HQKwwHryZwjkEJ8NODOcQR
 aSyMNC4MshUdLV84mC0a/ePCryGS/Aom0IcRH4AjRpAcZyhHUYl+ipfM8uTDP6cfZqUKS4iy4pC
 YNJ7v59Z2xOyiK02cYNFOJWRyphVQgGkab6VXLmXbo9+DWYaO5fkuUYeUnIXjNd3WGyqkrmwQX3
 bsCFiemIJkx7Vwqg==
X-Received: by 2002:a05:620a:2403:20b0:945:e46b:15a2 with SMTP id
 af79cd13be357-949cb821e7fmr2691914885a.49.1795736271058; 
 Thu, 26 Nov 2026 15:37:51 -0800 (PST)
X-Received: by 2002:a05:620a:2403:20b0:945:e46b:15a2 with SMTP id
 af79cd13be357-949cb821e7fmr2691912085a.49.1795736270606; 
 Thu, 26 Nov 2026 15:37:50 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm42636343f8f.38.2026.11.26.15.37.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:37:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 13/24] target/mips: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:51 +0100
Message-ID: <20261126233604.67722-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08c2cf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LLTHveLdIxpoD6EXDcsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX7nbba5Dh200a
 J1gKqIFtSQz80qgft3jbD/GVW98ukhscS7uiOqKgxvkzqC5gbDtr1njOCWLSP7r7ZO+IwDmgdv6
 upyZcQPH9hfb/OQ4xPvKS0aKhmMDXWVf8h9FB8ucS+X5PSAqTzrRVk69NejX2fGloH4mcAhP/Zz
 h5CCUG9X05LMfLe6X4iuFPzLR4Hvl47lr8TZywPk59AtKzAli2LuWFKBtF6+4WiVSWnM3DZ5a4j
 3Hk5rA6gufn4NRDAxu8TYfsSepmBZDQX/UktyzeMRcnOR+Tt+FY1va2SAqqW2FnmQhKbyKS97zm
 kq+U3UUFlNarpb9W8WPHzifTle6hqHNg7VgSEoCL4bvBdwwLLB8mg4IfXV7aZkXblTSpmQdGPFj
 /vFcZKIUIBR0+CFa+4aW3WGb+bzSvteI6e9jQoXxPiTDKUVhzre2JgyHKTxVoImYst49cXUTlSm
 NSMLRV+HxNs5LT1seWQ==
X-Proofpoint-GUID: 8kPquiJT7PNIPl7Z4rUFcUgUsM2nQTpD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX4G2TortBHUCC
 ETxFHru3pfEqgmPopC9XuMhFlXnCs0uBd/0RdebxSdGVNEXfcpaXH4e8mr3UtkxB/3nmnVGLEFZ
 TWVgkI2pLf3amflJZ3+1H/IGR4Ibh/M=
X-Proofpoint-ORIG-GUID: 8kPquiJT7PNIPl7Z4rUFcUgUsM2nQTpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.c           | 2 +-
 target/mips/tcg/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 324e5989cca1..fb2ece5c9a46 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -682,7 +682,7 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
-    uint32_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
+    uint64_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
 
 #ifdef CONFIG_USER_ONLY
     if (!cs->prctl_unalign_sigbus) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index bbcccbbb467f..9c76f1bc00ec 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15127,7 +15127,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUMIPSState *env = cpu_env(cs);
-    uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t tb_flags = ctx->base.tb->flags;
 
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->saved_pc = -1;
-- 
2.55.0


