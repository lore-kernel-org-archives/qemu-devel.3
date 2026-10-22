Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0150606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U6FD0HpL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MrmRYh3y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nU-0001nj-5v; Thu, 22 Oct 2026 17:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nQ-0001mE-Rc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nP-0000HV-5E
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKvEeH792626
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6sHf/w29CdhlhFeXNCUTUDPkVBm0Y9qqEW5yNmdIpGg=; b=U6FD0HpLnmQcrprl
 PnKiDzXrwMLDgKvxz1srtKQJ6Dxi0n3fNB7HNc6BkyKopCJJDkAFTuPsuH4jeBs5
 Fa9ZokdlQjYy+JDzKW3A1ig7H1dK4zy3GWhsEnStHGYwz14b1klWdgYoAwM1e9MY
 GEQbI2A+xI2cH/XktZumYfjHpyfDa0km1CFu42WZFWPOhKiw+aiL0fasQpei2/cY
 gYPJEqXSf+W5jJUinrGf7dnaVmybiNAOczqs5oirq0SPg6kXSMkZR4qXWLDMAbGN
 ERnUoN57YU6T9YC8MQhuAiRtaPhmfrNrInU5C/CcU2jn6CXPU+xRm4ECOELtWrMr
 3XehuA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk85vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so348637a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706277; x=1793311077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6sHf/w29CdhlhFeXNCUTUDPkVBm0Y9qqEW5yNmdIpGg=;
 b=MrmRYh3yzV/AfT0C+iusO3gdVKf2FJLhQjlBeZCNxsMmrrsGDv81VquOtoRILI6Abp
 jWBuzFphKJihHtecXvk/r1pI7gSrBywAQoMvyQLSJztoraJWxNg9TBiy+1C7Hr5LwB4V
 LUqf+E7TyaT6xL6+x/9X6NO+ZDemv3N3pRdC6u4M9q2kP/i4DmePtpe0epKRWbR5oZfU
 XcMPa+HVxN1IKQRL7z63t//EBa2u98Q3sSxn4Ix/U9ziXkALWfT3VjdoG1end+HVOpnv
 b9f5g6x15ILRNy0bwEmP7S5zYePb6vsw1IXs9tOITamPRninWLw61ezKEVSMNTcYVzXU
 YBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706277; x=1793311077;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6sHf/w29CdhlhFeXNCUTUDPkVBm0Y9qqEW5yNmdIpGg=;
 b=zxeWdPfi40tX4XY5xzomUgbKFnVaIfelx5GKX3ZmviUUEfqh+ucd7HR5HfcbE/DXke
 ojrmzEV5YDPPSTMGtZnJ9mUIKRD7p+1BhOJdc5XlJ19DtFLU1aY+Rg0PzGLwQQgN27MA
 T6vSwU36hPDk+jOAp8zvnyKxZ3Kd0EbPN3Kf5oi1jqXmVlkS6lBt2TVd1K0SHx2G+ej0
 Mh/YRk8hx32Mky3s5vPjEPTP4hsE15umuqCp6iI8OpdtM0Dd9lTsT1aT8zwbDz5dG/HJ
 JFmFQElW7OeyU8FGyjW311dgpWE/mrJN/wQq37J6Xw+wjDOdjNTKEGn95Wj7IrakLPRK
 kT2A==
X-Gm-Message-State: AFq9FYJ6I1PO+00hyJvPQudVtbd4ttv6OMG3xPMlhS3mhW8m+trY4rg4
 vIju5SbmpIvq1KuH4fdWkxocCstpSn8utNsa08XTiU21VqbWJrf4GsS9aj2bKtNceza8kzp/QfF
 g9ygLcxZV7tbuuZiy4Dx3CuNRjlw8N3l2cqyWARWqruTzg9Xafvv+oyj0/OM7IfIOtA==
X-Gm-Gg: AYBFou0zDmwubeAh2c887ImBTKdy0N/yst4lD4kOro8IL+xgtLE/QNIRQjtxquysnCB
 hPh2l2VS+ZlPhCiM1+nCr92mmUtCFFl9TJ/R377EKGU+Y5dtLg+hEhahTRtYwruM4Qsf6UPl7Ce
 ZVW+E9cbkdKvb/zTZ33UfDvuHZ1v8ovFoKwMztNOrYB2lFNhdui6Etipfzqi0L4i6/aKzPGuSKS
 c5NS/xakPWWW+QtEb7qUVmK1XySVlPAEDa40GY8+/HczJC4B627kEMhI8bcmw/0vPl0qIxs/By+
 5vrvyNVR2b8wPMkN26NFtC8J+idHGukhyBagTcXKtuIrDSO11FRprHbz/4IVl12zlHEOtxOGYTl
 RPR7Xx+xgcLnWmVTGsFMqxftMpyYSrJGYoM1zfPZBXl8PaaBr5Au94SEoU3HT/Oc=
X-Received: by 2002:a17:90a:da8e:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3adce01b033mr176532a91.27.1792706277249; 
 Thu, 22 Oct 2026 14:57:57 -0700 (PDT)
X-Received: by 2002:a17:90a:da8e:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3adce01b033mr176515a91.27.1792706276828; 
 Thu, 22 Oct 2026 14:57:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/27] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Date: Thu, 22 Oct 2026 14:57:27 -0700
Message-ID: <20261022215747.2479440-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+hIL2nyaJEGF
 /kqNl8wPjavoIKHAJZ3VF2sHUS8A6kd6vLbPHrbT/2uIZLvEgsO+S5nmkrQIi6b/1z8xyl6RCZo
 /AZCdX2ZLlH4zYmghlj6vhMkmYXMBVqRfwDodFaCAu/bzCca41VHpwc9xeMGnzgAgn63FVaSAjy
 t239Ds3Nb648MLKVKreGIRBkiyqUBntG4jBhEUXcpFsoKRxHdH/7pL4r4x+YbklIg1UltFEaTtq
 j5jtz/ONWpTzXSpfSh3EctHgyf9q+mKhfvwB7DgvSCVn4J72v7zJnsRSrSOZvkQS6Zu7M+Jlzqs
 eEQPtn5M1u3hrgBFN3toUO/CS+LG35DASyr5JhkBFnQ7+CLX140jAQpIGxDLqcB4i1L3x/5+hQi
 tpB9mzgd565IgRuSCgn6aC3UaeJn24dmXpgIxYaXYy9gCb2LOYziey80//PgPlZ6scavje80Clr
 9f89I+44KceZ8Wjq6EQ==
X-Proofpoint-ORIG-GUID: ItRElRA3OvdLOb0e9NTicKwcgvCWLXFe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1j+ODbCR2sFW
 Kq0d9jZSLQgMCcw9zeAaKOnPz/+gqB3W6DXv0IVQzsj/tbvUHZBO3LV3zG1kRps/X6kD2rEYvuM
 +nWvX7CqHhdNa5kE/sFYqz2HnTtTbRs=
X-Proofpoint-GUID: ItRElRA3OvdLOb0e9NTicKwcgvCWLXFe
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada86e5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KOFfYGMdUDr6h6J8HrYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-9-pierrick.bouvier@oss.qualcomm.com
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


