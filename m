Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DD606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7HzMoPN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WadBe7Im
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj4C-0003g8-AM; Thu, 26 Nov 2026 18:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3e-0003G5-3G
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3c-0001Ij-EW
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:17 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwIIW3864509
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wLRFKPB7CP+13NTFtFlfHvU882UYml1HqOOHW0ZUVCc=; b=p7HzMoPNGlizMSk6
 cuEiXtS7H3OYz8sBNbwqiVvJx176JEZvs8vsyyvKy+392WE2xGSrp0Sp4GJ+QvE8
 RyQn/fNXEB/ct9zJ+SMZKYeXS0wq+87Tvi+ckJMvOCvSwvRq5aZTDozjHUkDyB2+
 ggwiJJ3J0g8jZwmt164ENDbiZYWvJewl4By1Oty0EaO4iXPEOSNwZLMGksbjmpNp
 9HYbvkl3o6pFOKXIe1+WwVrWHneBTLMO09ed5Jqg1XSDFHyDWQEqN0QkAK8uewkI
 eohFGvyQbVTCLc0XJZw0BeKSwJDPKSTJygTYVd5S7W/7IxwCozbJyMdLcl58e+bA
 WWFZfg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55rfv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:39:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9496ff065bcso1004141585a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736343; x=1796341143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wLRFKPB7CP+13NTFtFlfHvU882UYml1HqOOHW0ZUVCc=;
 b=WadBe7Im62Iar5+daGqExS887/txhFc9ZcAUA0WYdbWoev0wuHgiF884A20AK+BgVg
 36Ln9z9eHb/aQFOYcG9mcT1Pt/57aaTJhdv1dMa42BceEMxL5I61o8ms3darbtI+XYpG
 Tmh/0/7+iqEXLijAe1le+N8cnT+jg5LVFdBcBXwJA9o3EoX35LPv+p0ETT5Wlk0/FBmN
 Y04rYSQ3qTwbPvQ9qX5SUZvAF/8IUTrJqTgATBhejkCupx+T7kdHvXdo/5tPfdV+c1aY
 HJRfNnJu77EfV4922iqwfqck8HWENcE9VX/u0qfX+OsJw5JwXlJBqC5ljV97iSx/VbT2
 eCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736343; x=1796341143;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wLRFKPB7CP+13NTFtFlfHvU882UYml1HqOOHW0ZUVCc=;
 b=tFLTBgEKY/0ms5IhAP1zq0RoBbgO7KvLxHzcRVAvuBMOyQZEf3AuVuvCEcVfNbPO2N
 6Y0rLig5ueGEtLpr4hEgoKzH2MihDm4cekAoU1kTvlrHLM0O9TDhw7BKpfrOTokx9kZA
 m5bh+WwrzoUno+cGcdhqH5LRZh2ZR11sMy85hqrxD//tjCgRbg8Cur0YZkFAPUuwIHNQ
 JE3NFohDVr/UbS7TYCwMWbiDd9vx7vYMR+2GSARiRx940TyJhrORCOXAltyjHD6fOX6A
 JlKk2SV/8sBfDy46coZEF3ino/Jp/Z3XRiI4dToyyJPZFNiwdhzJhLuULdX5xj+Gukwz
 enYQ==
X-Gm-Message-State: APuU4Z+p6thmS86pAjLec3E1dXjlIA6kLdqhHJzahGoms7A7NqK1FfZ3
 K8uOyWea38hrxgEL4Wf+5SuVPx5w4O2cBy4HC0PHH0Y/JSOEWgHEnJicZgBC34dSBknr1tRWTY+
 koxQbND1zO+2yd6gWyP0/BFhx54+EJLugqG4nfCmhwe9awMY4UQRQMqsbXWzvz5D2EA==
X-Gm-Gg: AZFdTZeki4uif/ktMBt0AW0NrU0ewayKlyA9azBeQjnMHeRkh9JZbG0sKCnSm0ifds4
 MCjDzQuWIuww97sQQcSpCF/SwOxLWJurzAzCWbzZ/YO8xbaLIs5nLw7BAF+kzOkKk4DXTO6NCp8
 SZe1QGeVlfWht8viojMeGSOs+rBExVif1sA6TOLvkdkfu+zWDduS6y5ZacO+bwcvfchN1bsOc3u
 crR0itxmehjDILLVQtLzWck2iahoLLvZc7AyJZqOSJ0gyspogAif+HXGWCua6x5/cR+D3qNN2I0
 WdOoxkyQGHzNAUqMis2pLUSKEZWRCHuE91NeGH2f2PpLFZ0PlugrWMjsxAs+UIWNiSG2d4+M5Vk
 pEeAgRJrP2+0FoGRwwGSdTGyVDcZo3oRYGIajCnYznnlpNen6WcAEwQbwkvPW0KkzkXaoRooVz6
 8JszPPHw7l3qGTtg==
X-Received: by 2002:a05:620a:1b81:b0:949:6a66:66dd with SMTP id
 af79cd13be357-949ba96e873mr4358386485a.21.1795736343372; 
 Thu, 26 Nov 2026 15:39:03 -0800 (PST)
X-Received: by 2002:a05:620a:1b81:b0:949:6a66:66dd with SMTP id
 af79cd13be357-949ba96e873mr4358383885a.21.1795736342948; 
 Thu, 26 Nov 2026 15:39:02 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm43934410f8f.20.2026.11.26.15.39.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:39:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 22/24] target/tricore: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:36:00 +0100
Message-ID: <20261126233604.67722-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX6Xaoj5H8Qrlb
 /wGSmQXW/KDQquW82YnGp3kDBus34sF4je3Z4nImZ4hNh0YeoT/t2GXufAAojVFeY+vkMZKb/+Q
 TunhsGtFhmAq9whVY74O9xBH/5h7UcQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX/DCxY4c4Cvv2
 3hG6NG9pHaLgUHlptGAzshk0/aIO+gKSdIgGiIYWTog6HUIQWktpNf1N7w2prO2vgJe+cHZfcxR
 NrbGwwjXvPHtSt3ym8U6CBlvSZ9s0NfoidTqwiFqha2jSITAghPxW262wSJJeOvFz82Rj0dyngW
 MwHwRAGEt4lyU7HeLUgVgZceCyNwPgAJzA7WizhM9cS8VhZT1YPJ8Q3MBAtKx3Yl0iBybcjnnBo
 6vtDDc2f8MfK4vQv+VyC1YdkhoP8tvwdyUiBnpNOv4VMfRbR7s6F5wJAIBkj88boFGSf0FqEcEQ
 AZvxT/iu4xIIJSquimCItt8KI7wA6bI7ffUt3StyKxIalA3XQVoOjBPrhnFMb2eGRjRciusyyPN
 vZAUDv4rNDHutZTQUyERNG17gjj/OtR7NVV0SoKk0wAC9cQoVtLcfXNayA9HTLmDrixPbMo6loC
 XwJNyWji2yfMFzaqhcA==
X-Proofpoint-ORIG-GUID: PJJfzvcDbf6RCCBbTAQ35Y32bwP_YB1C
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b08c318 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ltnaFbhCd6zjLZLej9kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PJJfzvcDbf6RCCBbTAQ35Y32bwP_YB1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/tricore/cpu.c       | 2 +-
 target/tricore/translate.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index fa782f82f00e..b77ad96fe7bb 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -81,7 +81,7 @@ static TCGTBCPUState tricore_get_tb_cpu_state(CPUState *cs)
 
     return (TCGTBCPUState){
         .pc = env->PC,
-        .flags = FIELD_DP32(0, TB_FLAGS, PRIV, extract32(env->PSW, 10, 2)),
+        .flags = FIELD_DP64(0, TB_FLAGS, PRIV, extract32(env->PSW, 10, 2)),
     };
 }
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 8cd6b58f66be..7f343d5626e6 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8389,8 +8389,8 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
     CPUTriCoreState *env = cpu_env(cs);
     ctx->mem_idx = cpu_mmu_index(cs, false);
 
-    uint32_t tb_flags = (uint32_t)ctx->base.tb->flags;
-    ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
+    uint64_t tb_flags = ctx->base.tb->flags;
+    ctx->priv = FIELD_EX64(tb_flags, TB_FLAGS, PRIV);
 
     ctx->features = env->features;
     if (has_feature(ctx, TRICORE_FEATURE_161)) {
-- 
2.55.0


