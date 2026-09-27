Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4132EC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAj8M-0007Qm-QB; Sun, 27 Sep 2026 03:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj8K-0007Qa-Vq
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:17:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj8J-0002hV-Ds
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:17:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNr1Bx3993216
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OvTX6/erE0jQlX33lLX7CVeRDrPJ0e+EoK4Q5juip6E=; b=SSicm4Adv4zyS17z
 yfW+m0nxaMG+sMzm+mAYL46UOHUdrkQogLfwFF1t8Fuk1ZHMhpkzue4YKW2qNNFV
 1UB5PytErTpNVs1trbP6rlvFQw1JsRLJKMl36cLVRFbJcMBPbmhorP0OGn5Kgu3K
 n8N05245niClRSY2XR5UYobmmSOZNcxb1vptsrZeovyzeH324wyUZpb6MLT0oYuM
 eaPObS3QYPTGOiZ8xTAJyISA8kzC0xUqSr5uFziBi6AVqaAX17wVTVBSsnb+l0dy
 kuAIb6K71R9ZZdd3bLsGbfNqwgIlISHdgfPQEE8hr34EZVbOaqroDcyKCvwle4f7
 OCRHYA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jtbym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:17:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a05d645acso452535585a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790493429; x=1791098229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OvTX6/erE0jQlX33lLX7CVeRDrPJ0e+EoK4Q5juip6E=;
 b=Qq92+Mv2pPQrib8q9WP1yHp7LdBsLk7Pom4q0t9nC6juolQ+y4a9cNN/lqJhq3r1OJ
 UEieW9dKxK12LpQXZWwYmLYcUmkDJsw5ZhIGnAUhZELQyxncYF4nxXfZnQsW6nlKF1Bn
 odJGtDTZjlfUzObP5bniAD9umnKBL7/dS+sMoN4XeQAxKo6UAyeWu/yKSS8dVCrz/rY6
 Q+DTSlHl12m+Qcej/rZxEv/MfM6KyHBa771Rcy0aX07qESu+4qqfPe9WDYbeZICahoe3
 UCkhptpTs6KuU8RtxlP7Dn9sGvDkg/u0jSRCw3roRROwXb3EW6miHIAVu5ImtS3+/koA
 tKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790493429; x=1791098229;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OvTX6/erE0jQlX33lLX7CVeRDrPJ0e+EoK4Q5juip6E=;
 b=R05mzSh/pS9XM+1AEgcxf2RgYcM9D0goICt1uMRiA+ITYzzlpttd4CcpRSUvuoRKL3
 ROCdtPCYVGnL71SNjuOaDY+bzJFkn8OkPag2tnSMT3lcR8TKvfz51yz/QZ/s+ODaumwu
 seGjkigAmEgIcn2IfbCaX83O2YI0F2rIa5ffAwlGZ55p8bELQZiSDOgM2BdpqQhXWSKC
 U2K0+/sOkLoyu/NQbTpAxAbpSTildqe7lCTHFPH5SIGXWvciFxfuvMtBFy02w2log9q4
 trDyx5nUi8jSbua/4xeJQxJnKBlmMhXDguLYNeLX4XeGEE/88MF/RwPZwj0zYfCrwLUl
 t4JQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgSwvumc+L5SNMqoXZvqgaGXuMMjbeIRGdUHQ6Eoxs8xZm6O7u/49l2AiV8bHDxib4toROvCs6kati@nongnu.org
X-Gm-Message-State: AFuF++n7OyTvuUu5zL9JWF1klPQDAKX/YSHBVDFyOcqTHIiB9zr0T0pm
 b1lQHIZQyPCKbrIfw8daNKUfIImVTXNJz3HLSc3ZeRgW6lhyGPZiaerbsuYOkAbaaLWhOCRgTWL
 NNln/ZeTo/FnrO0NW8YE6s5KL7Nyz80vLP/Ni0L6BPSFZji0556dzWVoZzVxo8GBeEA==
X-Gm-Gg: AYBFou1wI2PfbaptHBlHNJcGAzNd9W0HaR5cmmqF+xW5etQavJ8LXIFHuaiNU9e4/sI
 yMxWgSeDwbc+NMKCT19CCLtK4T8Tyzw4Sn1Rx+MFRqsRivWsEYO5r1omEC8Qn0RHw5GBrhHzID1
 X0m2r0QHq/eRf4v4OJmttcQgfy8jHpSfvuoJp6y0zJaKRy6/QzWUr4hRhkMhvhlPRKAviigZSvt
 RANAeOgLi85m8B5ecFxTQSP90q4wLYP3/RgTQpYITHT+RavrAD997a/svHdcezEGO1t6fOUJci3
 KIb4C1vPLfCAmhFNThVSeHqPiHm2eYGRpIHwnH2+kEehYM820hSUr1xqaWY38MSMqBYUHx5w2T3
 kSYn2qDOguJUy/MeM00tHWZO/Vuy5QvgC4Q==
X-Received: by 2002:a05:620a:710e:b0:93c:6bda:e028 with SMTP id
 af79cd13be357-93c6bdae4fdmr253810385a.40.1790493428624; 
 Sun, 27 Sep 2026 00:17:08 -0700 (PDT)
X-Received: by 2002:a05:620a:710e:b0:93c:6bda:e028 with SMTP id
 af79cd13be357-93c6bdae4fdmr253807785a.40.1790493428208; 
 Sun, 27 Sep 2026 00:17:08 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a354c47sm19692667f8f.15.2026.09.27.00.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 00:17:07 -0700 (PDT)
Message-ID: <3fbd1160-ca0b-404e-9390-1845dadec80d@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/isapc.c: reject modern x86 CPU models
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, qemu-devel@nongnu.org
References: <20260824111054.575149-1-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824111054.575149-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfX1+/jYOtRDQ/b
 gkiQMbFX3pFEkOuAb9pMhTcTd05oO32MyZJ86gcE+uMsCKbGta4qyKsQ/y0LKi4L/mojooLOHGU
 /BGKRd5TF43BcMygqbEPsC0HAqpQL8A=
X-Proofpoint-GUID: CuuT-hrHas9Y7WzsrQxbDTYnJ_cVr5E8
X-Proofpoint-ORIG-GUID: CuuT-hrHas9Y7WzsrQxbDTYnJ_cVr5E8
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab8c2f5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=64Cc0HZtAAAA:8 a=catcoup4RJIRKdDdaWIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfXz9D8ULMzOnuA
 AWMOv/eltzNH4o+fMQ2ZCVetfm1SAbW/fpUOV/pkwrJd+/WU3ls1Yv/ITHzlxFHFsyb7JxOGR8v
 tGFfgoZi2Yl25IEK2A80bh99pnpxpdYhtoPTJfrJpNUri8rT+02R8iIfAMoDD1tWtZ9rW/LYOs7
 XtMagFP3Az73eCJcLqG2DNJbo+aFRLhEn0iWAChNh9tzt0yW5E4x9JJEfG4MbdhWGJwqXfMdmAQ
 DbQMxuwUolLwt89Av8koVN5EgSwC+9TFUNmGKp7STSKqokBVfK/t16ZNWpLNXNJgHP/KtQKyIKF
 N2CHL+uJWoYmyMyxS0vKPn5OBNzQlzUHMXgWebf0I0WvvD1fEAB2CbFkCHNs7Pet9mQ4y0L9qjH
 GlfJ/+25qvK2GSAMEBgA4vwEMrV2PHI8s0C6mqHiaFTxFSIDJeLdKRVneCP2pKzYtGmexkILczd
 RsPxyl56+AdKg/sutzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270028
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

On 24/8/26 13:10, Mark Cave-Ayland wrote:
> It was originally intended as part of the work to split out the isapc machine
> from the pc machine to restrict the isapc machine to using only 32-bit CPUs.
> Before the 10.2 release it was decided in commit 329e36af94 ("hw/i386/isapc.c:
> warn rather than reject modern x86 CPU models") to follow the official
> deprecation process due to concerns this would have an adverse effect on users.
> 
> Now that the deprecation period has expired and there have been no reported
> problems, update the isapc machine to reject modern x86 CPUs by reverting
> commit 329e36af94 ("hw/i386/isapc.c: warn rather than reject modern x86 CPU
> models").
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/isapc.c | 53 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 32 insertions(+), 21 deletions(-)

Patch queued, thanks.

