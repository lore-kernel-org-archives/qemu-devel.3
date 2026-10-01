Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEDFCA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCH2O-0000jC-Np; Thu, 01 Oct 2026 09:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCH1v-0000hV-DD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:41:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCH1s-0007YM-7H
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:40:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691AkDDx3388135
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 13:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I1ry2hqtlM6+ycp+jQDXy0kAQRh2IWE47tSm+AaQiBY=; b=Vwv2ikBdD7MQvrj0
 XgfLdUG+NJvpEn/wfoG5MF52zwghDTNs+aE/ZqQL0WjWY6VupI05zCzkeCv7pA9+
 U56IO+vI76+iwcc2NEmQy3/fW2LYT92OYuLOKmHO7SvS/rNlhJlrTFy5/Zs+Rzm4
 BybLpmNR7qyoSeL+V+8FUKRBhroWKUtmoeSOW1D0UzRSIZWfJK7cfXsm1cIVH1zM
 2AKP5MZVZtdXt/2SFzH/CKL9pqwO259jQLAZU0NnDGD/AAyhgNtRDPLEC5SADVGe
 Qi7vMA+r3cZlv3T2DXH7ymPHhl5QdiHUMnBUalugOrXHGBwwvk4nFLydJs5vcOPq
 QWL7Dg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1p2b8nnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:40:54 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf853be08eso208570137.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790862053; x=1791466853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I1ry2hqtlM6+ycp+jQDXy0kAQRh2IWE47tSm+AaQiBY=;
 b=UnTVBC/1tlM+tKyQVzpi2jBrhxT8cvkARiJYjVBCQUMt4VRhatMFd8o1artWluH5oJ
 RrBA4Bwcv5kPqfnq2ztDNeUGN72aOaXb3EKQ+QnqHchgZF9jldota0ytKkacmNZ233ml
 k2ghgeT0hZ3mSd6nVK08KBETHromSOcLXgYiC/CCE64pCRThDA5yreEFRvL7i84Tsk2X
 96A7eOgEOBPo9n4krSpbMqBlKa5pMKQOQQH9iAZnxi1yvT4hbbxB3dVZW8ud2daWpvQd
 LsPGMWbTZdsgu6TSQrxvkgK4L8zqO2PmnvBaKas2CaEvYYA45NbuFf7b6ysxOFbl+vKG
 u9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790862053; x=1791466853;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I1ry2hqtlM6+ycp+jQDXy0kAQRh2IWE47tSm+AaQiBY=;
 b=ShxZQXsDmaN5nKiz1bLEH0M4ujc2uJ5BQIRZYPDn9mnl/Dl0glAUSgz4R72FgmcB8W
 XkILH5zAH76QgDtbptgwKXVRlmdAN3OpSerkGIhf0yTo+9OrGYvbd1HWujMOuN1gb75L
 AgVLqGh0/pDjRUUzIi0znpyktgaAaRO5P8OFs7BMNgLzYjsf82PIn+rXVUfn2NwQ4Y4h
 cvr84C4/GxDuxbU+QKjOyBxFgG5DNwvNcJDU/rVkre+45C92ZofbfY06KsdbVioan41N
 Fojx3PXjVDPRm+1LiZrlkKsiqo+xrtLLMQ5yJxaNYsCObmP1IXT2A7jA0s9HAaOA6w7e
 DNsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzALZVtXCrQu4QOCc/xHtGBekfyRkceJRdcjTmbiBdR2D7MPQES138mrUZWUbOEd2xOIB7kThoine/p@nongnu.org
X-Gm-Message-State: AFq9FYKKu1ucD/3j5lF8dART9zp0l39bSQc9Q34xm2Xk2+Q5Fxv3zrtN
 3I01zl0FkTyT6lGqRLYBRFuxVCR+14AZIgGO2Yat8qRk4aqo3Yfb6PSIKz+3dab082QdQaLPxXj
 HkeLDyZvr7VDpmdhgZ7b347QW3dsvh6V4jiWnprt7M3TRlkb24c+LlGfMbA==
X-Gm-Gg: AYBFou07reyZDBl++9p35Q/T+4qk8v0dRrhouCa5Oipspmje9uEgBdcy2QOoGojKd3g
 B3OCEbh2fQPiRnHE5WscyNGpHkEQ3DWTeSV1rRkMHBG6VIj0x0So/AcJ4NuKy+lCM59JjG+NNac
 WUhjO06nfuHJv+Y9a7J0iuo3JxxfsuWSx1+0zbRu80WfvjshUwSFwQQIsU65Srmc19tfMc73Bl1
 G7toaYfN3JSCeCSv337GI0484imwrQm6DI+hjFboajKeKrGqpj6N+zeEScCoC7YfgHygL3uevOY
 Rr3XRL7RJAi9RODeE2thwA5yy6W2qa4hkIK56XEAobEQPQBQav4zNu+CNVRVJxCYxJu2Nfm/LX6
 wvw2yA3wIJnER4iTGnFlvMA==
X-Received: by 2002:a05:6102:3fa3:b0:7a7:198a:c2bf with SMTP id
 ada2fe7eead31-7be735975ffmr1079574137.29.1790862053279; 
 Thu, 01 Oct 2026 06:40:53 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa3:b0:7a7:198a:c2bf with SMTP id
 ada2fe7eead31-7be735975ffmr1079560137.29.1790862052780; 
 Thu, 01 Oct 2026 06:40:52 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692b1c9sm6125022f8f.27.2026.10.01.06.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 06:40:51 -0700 (PDT)
Message-ID: <75d53637-5cb8-4a03-bcd8-97acd646b527@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] target/hexagon: Move to do_interrupt() (BQL
 acquired internally)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-9-philmd@oss.qualcomm.com>
 <ee1807fd-eb2d-4fcb-b7e5-e44e64829b5a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ee1807fd-eb2d-4fcb-b7e5-e44e64829b5a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eiHhgAtAtEFCUquw0NssLPcEJUNbsS_H
X-Proofpoint-ORIG-GUID: eiHhgAtAtEFCUquw0NssLPcEJUNbsS_H
X-Authority-Analysis: v=2.4 cv=O8SsLx9W c=1 sm=1 tr=0 ts=6abe62e6 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=neIvRC4PW-D10HVD7IUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX6VFMNw9m+DZU
 BWjJoR0DgDoime0ke7n0GXvn0vQ5OCrM+e4M+9oG1Y9cT5LxT/MJCnl1rIbkoPDLnVsgVfGXwc/
 LX3+8/k2DbwVC3cWcT+TXBwZpRnsy3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXzIpwQeCbr3NW
 yeLeVjHO+Qw8BRDghYC0kpPB4Hs3bACkGHhYKtqZ/z/cXq+N/ys/vmP4j5QtbkxQiO5CYcermgW
 SLSFzTLxvA8/P7zLrrf4qie8CiEGuo2KBkXuY5lGUGjugdq+ymgFi9HlgT2BE9LU1PfQdiE11dK
 Uyrc6iGnBE/D02J8OrNV+sdfwjxA2LoN465BOUYsLefQqK2CHDWbYuW2ba83HbWqJrOcGS3mZ1g
 CmqT7Vre1yf8uCoulSaSqK3MPuXiYIaP8ZmLd6gr0/grBmx6snDvsG1VyWM9L6YISh8/MdDirQG
 HygurSednSVwEDas5SHLtGZ/lk1bFGXLgRYcGhPX5LIfi1Ffju6uta2Ls5bHl7IVrFQ7Sd1kPas
 4SBAi6iUuBO0gXpIGr4WhKGj1po73lOTGU95OJ3ZYvO2fQJtM0not1WO8iBMphdfyOD56ZWaFm8
 gXVloMexuQPUBumIlpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-09-13 5:55, Richard Henderson wrote:
> On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
>> hexagon_cpu_do_interrupt() already acquires the BQL internally,
>> so register it as do_interrupt() instead of do_interrupt_locked().
>> This reflects the actual locking model used by the target.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index b5dcbfc99db..7067e5b70f7 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -769,7 +769,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
>>       .tlb_fill = hexagon_tlb_fill,
>>       .do_unaligned_access = hexagon_cpu_do_unaligned_access,
>>       .cpu_exec_halt = hexagon_cpu_has_work,
>> -    .do_interrupt_locked = hexagon_cpu_do_interrupt,
>> +    .do_interrupt = hexagon_cpu_do_interrupt,
>>   #endif /* !CONFIG_USER_ONLY */
>>   };
> 
> Eh.  Except all that hexagon does is acquire the lock at the beginning 
> of the function and keep it for the entire duration.  I think hexagon 
> should stay using _locked and *not* do internal locking.

I'm rewording to clarify:

```
   target/hexagon: Use do_interrupt() for internal BQL locking

   hexagon_cpu_do_interrupt() acquires the BQL with BQL_LOCK_GUARD() and
   holds it throughout exception delivery. Register it as do_interrupt()
   to match this locking contract and allow removal of
   do_interrupt_locked().
```

