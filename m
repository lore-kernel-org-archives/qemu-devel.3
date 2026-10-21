Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A67606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lb7IyQHj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TDLI8qOD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoC-0004Nh-LQ; Wed, 21 Oct 2026 14:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao8-0004MI-2A
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao6-00082t-BO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpOp92384272
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fDN6T4AgDJQ+QHacK9uCfNndCCdU4Bgk5L81UGVSCHc=; b=lb7IyQHj+bC2dlp8
 PPXe+t8Ru/FlR6SIcRwcjes4sqlv+44+jsTcYNqyLB6bEWztzuAcWzwprSWIvq6E
 mgC4eu87II89yx3elZFhYV/xR7nqnA7VCj0oT7md0oOnzxRgKhl3KZ7n5FdGaRAv
 LlxCU73JfIiwAOjf3EHvZ2tR5bG7magsKrp1ftMPydzYGDIUE5VWSgqcpY1w/pAT
 CXffhI6VvaZO1MW2mggu1HercdMM7RujPwFaILneYE0eI7dhNG0yVsdLifzLt2iy
 5+qzVWf320FEejsQGZ6JE6J7FUIcqvb8BWVl8GRJdzU1jKLys/2NnAufZravVs3+
 A9Y67A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0jtv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e8ba4757baso9392185ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606376; x=1793211176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fDN6T4AgDJQ+QHacK9uCfNndCCdU4Bgk5L81UGVSCHc=;
 b=TDLI8qODpWVVlB0byaSKZxXL+TN9X4nrxKwhkHEWxAwiYVjm5+oa2C1QnsprQpiK5s
 PXhRTcPd/+i3q/fpfN79e/ZiMX2a2bOtyf+FJiasn/cbKTKBsKlar1Q/Zzd7lZpWG4Jk
 3tpesIZErW+4kWg8lQ5l+OjGLASp1Bk0trlq7dONsfdnw/HVfffq3uFQhHZo+JYAr1eF
 WnElUdU8o8tz4anJPLeaIOl3awWB2GFK4qoKalff672YW22ho+KgGL3eow2yBhmw1Q0b
 YvGVMTr0/H2Ar62eoF8PHmLga50EysOqW7Mzn2am9CA1yFN0NQYaM2zf3yI9sdSvzP+H
 Ks/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606376; x=1793211176;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fDN6T4AgDJQ+QHacK9uCfNndCCdU4Bgk5L81UGVSCHc=;
 b=zUhm6IxCRI/yivGpQTdWdKE6NwyFXQxgx3wyyORZf/CYa9vrkhtlDW31HA+H9rJgDy
 Vs+ZM6iqqJfRwkbUj2VyEoS1EKn5q5gWevTrR93Hz7uY4n6OLfOVoNzJbmGCHPE+PmzN
 O1eEWt1Wy+QQedZxPIQlH/IRl8RvJ2awClab1F7SbOLU0laV4KRN2tVYqDR1uRIuXYWD
 KSlyXBt8WyxPfGTYDuIg2VBjBz0oKwTnU4kesFROFuP0vWMMb44xFZVa8Kjduo0veJPH
 vQnIlosCNOoCYXSY22v3N+n3rRlwsEOe0Qj+XnCtLl4y+6UOCy+Q4cr/pGnB7qNBX06o
 PV8w==
X-Gm-Message-State: AFq9FYKyRJRE7u+jvttP5CjLAwGE+zqRbTgQsQRBrPx5b/BqeR96Niwv
 KJtw05jNCgc5AKJulcyo6wficiLmAvfHovybrZ+onfdvb8jdcAJi61J3l1sDoHxhdXd9IDYM8BM
 PPCj+52qDcnDaS9fZGPTy5xyNmeojOnHoS/e5Emk60OP48u/WDc/KIDzTvMCXNA412A==
X-Gm-Gg: AYBFou00yu5oQBydB/mryFTOMgVzeXumD1beT9q+pQGIDF3U/hlmKT4smwCFbKD7L7C
 i4L66fTRG3aPrhASflfUFfnKPkXjCOFMbf6v8tz70tJHY6IeGznOYk9fYbhPaHtiBSa0c6bR5eQ
 IMDTSJ/Z6N7ZACDAgWGz3YnrkoBhFPALb5uah1a68zpsZUiZp+vkWrbqmdr0JRJGljwYkEycu4L
 8eBZpQm4/pbiECziL8ZRzFjjmy495B1FYO8PgIWxqoAYYhWYipaZMIucbLKkIOaEmiN7tgbxrPf
 xor0Pot6BbLzKu1VZv9LVjA9/mIAFDsuBB/u5CUUcPRRpDIFz+NJBZ8lnHbHsvPP9cZDfSMx0tc
 1lIWzeYQ507Kc5dCTKitNdwFryKfzJrWbKEd7aXUMXIi61slhMZ88VH5maGbN50k=
X-Received: by 2002:a17:90b:48c3:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3ad86d50cc8mr2373680a91.30.1792606376143; 
 Wed, 21 Oct 2026 11:12:56 -0700 (PDT)
X-Received: by 2002:a17:90b:48c3:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3ad86d50cc8mr2373669a91.30.1792606375663; 
 Wed, 21 Oct 2026 11:12:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 08/21] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Date: Wed, 21 Oct 2026 11:12:31 -0700
Message-ID: <20261021181244.867840-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8c8g_znFx-7pegg0P3F6jERb_YQ4qBWJ
X-Proofpoint-ORIG-GUID: 8c8g_znFx-7pegg0P3F6jERb_YQ4qBWJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX7lq1MYA7ymt8
 xZ84qAcYRunNtnq+mlStM9GV5TaT3EH2V/CCTfabKXIr9BcIoZyjUc7ibBjOPoJ26h4h4cV/2Kq
 7Q7jOmrDNq+Jjd0C/Rv76Ko59JSIpCo=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad900a8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KOFfYGMdUDr6h6J8HrYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX0KpLEL8Vq+Tv
 7bozfp4xRqy6fhNl2E4kAimNeEPukLAh86ZY0ziry+2LQ9MJWiYt0QQ7+2uh97N4spVjGmwUeDf
 kP7iY1mCnnnlQFbSfkTfiG8fNJJwFptL/FHVnGujE6PxHCih8T9u8DKS4Ns2C0eW9MxWm3wZYk8
 AmquKn7BRb6Hylr3gN+cyK9D9P7hrgK23SKbAe4rN57U3UDTEy0IdB3QsVOaWkXPc+oUgjgIDxV
 moOw++BCRuDtywY/KaubQBc+6gPQQMsJgJWH3ZqMvIn72+pn9y0tcBZqEWjJD+6jlOk324QMSg4
 IXJqsGNCo6PBFWItTRD3BGNLi+TjeuqAyrzieuQQwyI0SCx8pDmNag3gTSJQjjiwi3oafiqqRi8
 mr4f6uTy9RUKGq8zncKyj6rrwbGwiz9WZ5F9VJwk6Qa+OgTE78d92GDK4FNBkUqXq8DXSiZjYf/
 NDLpGQFMv57xZQrZIhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..fbffc9b3005 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3048,10 +3048,10 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
-static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
+static inline bool ppc_interrupts_little_endian(const PowerPCCPU *cpu, bool hv)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const CPUPPCState *env = &cpu->env;
     bool ile;
 
     if (hv && env->has_hv_mode) {
-- 
2.47.3


