Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA4606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dJdicSar;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j8uqOrkZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB2n-0000vF-Qs; Thu, 19 Nov 2026 17:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2m-0000ux-Cb
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2k-0006SY-SB
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:52 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1J3D3595064
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IJDXK74WzH0PQo6U7EdFX4iCvJOcm+jZ3pPLl3lcy/o=; b=dJdicSarTRiHxZG6
 7ZzijuEN1SqC7U3dUj/HGsxmUkAnSIBd/2TBWkWW3ZawG4OdEp/TYc5ODTTjNk2/
 9Ci5qNe9RNgQn9PX8OYqkHGdL6UJuyP/BPp+qzZFLWgj7Zkva08DvwwqPywcQ0lC
 RndJvCYZOmMClhPr4rM4iuQ4AtaxZDHkW7vB3cRK5eR2po6kL0/0jAJYbR+fA86B
 MxVmfpe6zNHPUOunmgu8SgZfFuoK6UqUxyX+FcGTofeKhH9rsXf10+fDs3KL5r7c
 xsm/1NcHin0c5nsyogrtGwMvCAS1/LSFitsQwPUxeicYHsWk9v8Ft3PTUgBKlgU3
 26Gtqw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255whq58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94960131b4eso68938985a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795128949; x=1795733749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IJDXK74WzH0PQo6U7EdFX4iCvJOcm+jZ3pPLl3lcy/o=;
 b=j8uqOrkZDhYd8e6lk2hFTeStBuz3P1ruinCGbKwj1eKgYpoUatwm5u2tuvOJLEScJh
 tFiwrN/5Kb7HtO3k6fKosZbkSzTGdTz+rEh2Icuca8OazX4R1zHJflpuK8vXLR+0jcpL
 fuviybcGLJTMWH0wxXE7FqBA/dNjLzXVLSyANuGNEVtP7MWns8IL4ul78u7/tydpVQsj
 GWhiPDC6/G+nDV3amgjZ3B+NG09zgJysZavOjQxvapQIJalMrwy7l8MoW/G8Ry0ZvOU5
 29rpxoOhNjb2OZsCEz1dpZEGv8/RkNEBHyvjPOa6Gk8W4AS0Jt/Sjq13vY5JJr7YOp2W
 UT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795128949; x=1795733749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJDXK74WzH0PQo6U7EdFX4iCvJOcm+jZ3pPLl3lcy/o=;
 b=Ppc2S561pOg3amZ8vqkeclbdDP/y8+UMLL48S3faFl3vrj0SLyig5+qPX9PVtF+cul
 ti+BQJHziS3A8X9mWwRomHHbFvaTYfCytohIxtOGVZbQ5ytPAUcrCNrQi2rCmpK1mG7F
 0p+uf4i6wu3Jerr2zg77EcV+ZEWZKPhrk9JwkmbEPSyltvMrLeAr95/ZBWTRfa4dx3q0
 EWcPe9znBRh0OzQ+gJm2t1jnMsqPBbNmnrbwZCLiG7wbj2ADdvp8Ek77VKVqJAmASQQr
 2yXw/jxdG13Cw2kH8YA3p7OpfP471tanVxNBKf069kpT9ZukW2/lSXsDZHDpAPEbcWsJ
 cZNg==
X-Gm-Message-State: APuU4Z/aeZUdJy6SLqSUrqhZttozWiG8E8yywGE9E4/pAU1HfTs6owP+
 gDsPJvfftOUUyYF3L2/SmqfceagXxGbuNmOQg6A3iVh123guLr34vPeGTITcx2/R+1OOBeTeizL
 t6pWcu6XqkydHD1VOLYNn0jvtAb31CdIb1EWt2sH7YGOp2Ksrw94R8a9+SHghZ+Gdd9BN
X-Gm-Gg: AYBFou2rmeysA46jvqh7AgAAlpRGyk6RNR4K0ogEeYqbIzKT9u1rgJmpQghrOdZgKOc
 pewxoXVjQ5adLmlG+Nx232qIl67z6fagkhyXoAuWHvKiy5qqXg0swK13S+CYF4pgjAVVfkqcj/u
 04YOjv6my5h6jf+MTB5AwsHk9aTV4vzrXd0D3g0CBizzHT7pfEtkYucPMJnxP0oCHJLX94yO6vW
 TxQN2NCtbfeyrBkUGaVb+6SpkaBo9NGxHRUo6rD65hUR1924jO2PshVXx1dyl6ohkUd8vFQoPyr
 C50br7VYlYjTKT5ZI5RxTcS1Fn1z18MK7WtfsIzhNArVDvjnDBjqpM8kH5WIHl1jc0FbmEhdnjx
 9tp/Ie64Yyc1dg2QiHD9XZFe6ON1VxbbPP6pHwoRxgTxmTw5zXX4yqfSYiPAh3hLKsaNggT0rfX
 QLi0bV16KeH4Crxw==
X-Received: by 2002:a05:620a:2a0a:b0:93f:43a4:a47e with SMTP id
 af79cd13be357-949bab1dadamr217863085a.43.1795128948673; 
 Thu, 19 Nov 2026 14:55:48 -0800 (PST)
X-Received: by 2002:a05:620a:2a0a:b0:93f:43a4:a47e with SMTP id
 af79cd13be357-949bab1dadamr217860485a.43.1795128948264; 
 Thu, 19 Nov 2026 14:55:48 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm1960685f8f.5.2026.11.19.14.55.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:55:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ashish Anand <ashish.a6@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 4/4] target/arm: Kick other vCPUs on SEV under TCG
 round-robin
Date: Thu, 19 Nov 2026 23:55:14 +0100
Message-ID: <20261119225514.4080-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119225514.4080-1-philmd@oss.qualcomm.com>
References: <20261119225514.4080-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX3+0ZCYBzHc95
 8JiWE7Cu744wHQqELsX0yF7d/ePQQaY8AeCRFyAyjRo0dMOxQve9uWiKZj10sDDjX2At/LhQn92
 jKWieBGR/0N+6NYRk4mhzlys1LhyYBw=
X-Proofpoint-GUID: oNPDIwnDqwPaDIj5-YEJPmnP5iDPK0IO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX+UUnPXXGleye
 vpUAanEZNhsNF+64NkkykI0eMpzsd8hRaWN/4SUMlB85BsEAIhVTU9EftSnTA+L6hPlMP+zKsKe
 r9SqAeOsexE+1bOFj3LLHkHKHp+M5b/eaisuBIjW18ZAHNFd0tyjYxl/mcaqyAxQCyN8AiuBftY
 DX7VR5jLCYlfj/YXxuzMgSUqmz2d48BlM1QBQ8xmBMCY2qi0BI95WX+oUh+0KlgPVoTp6rzw/lB
 1xrKXdBoCXqrICctfu7PWz7naIYJ4xE/WLLJmBNerIN5ejyBJJuz/YgzUY8NE5oEQQyO1xCzc8V
 InLR3R2JZF8MRiv/k/GsDi40q3QUXqP16zWjUWWf97rmPUA8FmxNKDfCaH1kzXWwKTYACmAX8Zb
 /XVL/Wh4hgCY77cyKbifPuR3eykHobXkKRXxIt6Q6Zssj1O860PtWIJpjN+278cCFeY26iFZXNU
 Wp4qXCftNKVrc4HEhhg==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff7e75 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=J0BsVto9XRD7R-49C68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: oNPDIwnDqwPaDIj5-YEJPmnP5iDPK0IO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

In round-robin (single-thread) TCG, all vCPUs share one
host thread, so qemu_cpu_is_self() is true for every vCPU.

The SEV helper used it to skip the kick of the issuing vCPU,
and so skipped it for every other vCPU too: a vCPU sleeping
in WFE is only woken when the RR kick timer fires.

Compare against the issuing vCPU instead.

Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/tcg/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index a862b9eb02da..c2fdad7411db 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -470,14 +470,14 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs;
+    CPUState *self = env_cpu(env), *cs;
 
     BQL_LOCK_GUARD();
 
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         target_cpu->env.event_register = true;
-        if (!qemu_cpu_is_self(cs)) {
+        if (cs != self) {
             qemu_cpu_kick(cs);
         }
     }
-- 
2.55.0


