Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F457606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vkm1vVrX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B4T5rpF/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfwc-00043x-Bg; Sat, 24 Oct 2026 13:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKfwZ-00043m-Aa
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:54:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKfwX-0001Dk-GE
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:54:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExtgv2960342
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3QBlGCLXOtCnrFHxJrnFx6b5riaR76dpM8ZWwMrBSqs=; b=Vkm1vVrXZWfC950y
 zuVYjzy27EdP2o+MIk6jWXa4K2rtOQAnySHfFcoEbNyJ6W5xrG9VrNxDGSjGQn9S
 yPxItNwade7hjwNaUjYSJZvD0v0fqsnocjiqAAB794Gg1bXc+lMZvuN1Ex+GGGVL
 OxU0yJBhUPMmwq4INbDfP6Eo9PV2qJHIIbiWw/Y8g//HYZ3dheGSFXnp0bPpEqcf
 XJ11Y9Bp5BlVcOcmrBcGP0B0agmrf5TlF78neTiWVMcjLllvqA7BqIBOSllC4Esv
 OmUxvnd+LM0g06Vx+VjHZ8mKdgiW5iNWQxa0zkyiVNf7HQjkiQ0ooxU+YTsCTVe6
 0VKNUA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgstn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:54:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337ed1ba44so39340631cf.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792864446; x=1793469246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3QBlGCLXOtCnrFHxJrnFx6b5riaR76dpM8ZWwMrBSqs=;
 b=B4T5rpF/UMQ3GndM1i0XQCyPjm/E+nPwD1dt56WUmsGmJ2gIOI6aD3FnndAh8Fpxs/
 USMPdAjWVdDpsyC4g1S1Ctivy2CHy+azykyt6xkf7bz9mjCzpzC6Ol1hVq9T58Vnn6Yz
 pFDhi0AJvqbGRgmKU0l7AnktIOvy92lwvyACxLFEIM0iWGYIX757477UDiOa/eJOZqLg
 WwUQ2ZaBypmqI2/nv8UnLjZla+9Y/bfXkKW18fk+G7NEtmF7iSTetSpDVbmtHeKyzLfJ
 32wVafkEd1cdqpRItMaTN3BDWC9IQT2sHA/wCjTcQEsTm44DrwZij12nlmIpSG3LmYJM
 i/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792864446; x=1793469246;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3QBlGCLXOtCnrFHxJrnFx6b5riaR76dpM8ZWwMrBSqs=;
 b=b+q6BPQ5VL9ufou41xq/+U9pntqz4BVlDW0Q1y6fHftMvuELjnPgXQpm6bQ4c8PvSf
 W/8CwQw9AImv/iAv0No54Ov9FJgxiatxJNW1TdvQeQlJtE7ydUqIN5TOTRVHdEB2+41t
 cEt36BXiSi86NhwFpRVSnjQtWpNxminmTJWm3wqd5MSoY//41TN4ToBjj2//ikZCiPiK
 OHhgMsu6LGAHx3IQmxk0taciMOuB4faT0ZKt4+2KnbDJOEFO/vG5wjl++ohUuOnPF0EG
 BPTmZ5RcnXu2EHixBAf/PLjI2PcIuu8H2KoFlN8qia96kjFdFUGSY41/qKXbtBbnsb7w
 3QXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSmtrrJiC8TRWf2hxjANVwTk83FrNC4Vl9mOuAJ48HaZDbkBu/XVfKNsaz+9TBLXJJ6pZhk/78RYBa@nongnu.org
X-Gm-Message-State: AFq9FYJTQ9Y3fNqPVQPQ1HFi4CW2R5R1doX6vtM0FBaH6gmztORquwTJ
 Mwuy8TiVDbWbWQlVdZuzApWWuW3WjMeR0GZqPqtfUGOv3faWGqDZ5+oiTyoW3zYXfkrgjrSoFQ6
 h2gSnqixgSxcYTXr1sJmaUQic4Zdyzt4LpIbsu0JzXXGEAqmx+qUqxe7dUg==
X-Gm-Gg: AYBFou0ohZkocG5E2giFT24dJhzhngXlKo5LXI0bVaNxMsXjkfVVyaL4EdtDgxShIll
 6WoatvEedvlRenAOwV6eRI6tmEXrLfvf4tE1mrS/42a0EPHKARFcnh0PXpyjXBaS6NIOVykdKsh
 jxSqsG38kDjij9+c890u76uhqVWdvV4rVcNwXyCU2yG8luvTs2MRrCiyBujC2Hz4gHF98pb/KJx
 yPsCMhJE49h6h8aap+8rqqycpzTuYAZLxprqBrJZQ5XuJdW0043NrV08ug6ky2fxJMecdjnrea+
 7BAzHGxvMIlXarZAZ5RsHTMCkFlHDbhBdF42kd5Y5BzLFbhQRoyMZGD3a89jjhKEyTYTdYQBUB3
 PVsEx7/OV6jg+LB7lnRqW4y+bWWxwypqKLnRf34MhiGa6R/vzCB/NAootIXl8WOTbXr40xE19/5
 SHLMA=
X-Received: by 2002:a05:622a:4cc6:b0:530:430d:87f7 with SMTP id
 d75a77b69052e-5383b57871cmr31930301cf.47.1792864446063; 
 Sat, 24 Oct 2026 10:54:06 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc6:b0:530:430d:87f7 with SMTP id
 d75a77b69052e-5383b57871cmr31930121cf.47.1792864445540; 
 Sat, 24 Oct 2026 10:54:05 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-538394c5264sm19816961cf.5.2026.10.24.10.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 10:54:04 -0700 (PDT)
Message-ID: <533e4a39-a62d-421d-851f-63a3effa9366@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 12:54:03 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/43] hex queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
 <1720ce05-f58e-4795-a2f5-3212b017784d@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <1720ce05-f58e-4795-a2f5-3212b017784d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MSBTYWx0ZWRfXzAolk9r7uU9C
 OS25685+pX7KYVdo/x6SoNmNTk8j3tJ3goWt2qBPy9l8h1QBh9cr9ciXfaxhzAT/cWYaOtpGZ9R
 br6JR4LnYcrzjNKW/g/mFY0g+kBmEPs=
X-Proofpoint-GUID: pBZTdfG6jh7-EER3QPEY-YbBWbLCPfH7
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcf0bf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=TBmdvtbPx_IpTngXN2EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MSBTYWx0ZWRfX1qQUkT7/Fzep
 otw9oSP6saXgefheYRYaNfQJtUS72E3+5DQQzJQmak6iGbXjpKU778hPJE94sSqavTjUx3R+0cy
 rjnK1Ay1ERkcpIR9PKdmH6y0Pa/veusy6cJfsP68hNzhpXwuHw5Uf8Ii0Ye0Jp4nswnLFvr+t+x
 r5Bem7tk41fs8vR4fd4V+Yvqcw75CfJU5VIv1PiEIqIMlkBl8nIZ5M0VY4lHuR4GuNWOPYPJu7/
 io0pztHIeXVU4I82J+zOc+UZbP/mtS1BA29TJWfizA0M3agzUj4Zj6qU3IFad+P5YAVG2PSbveK
 wcAp6Z6z8+5qllA2neAM44R0kOQV4sFEyb0kzQTSN+LRcl84CqHS75rEP3CX6VhUZ70bFwL57Yw
 KEwpJ/Y6fFAPt9Wol7/l9wIDrjAthFFWLLC74UBT8SfxRnfKjc9vwHMCCXvK2VY+R9L6SGhfCQk
 2kW5zxTwQyx0+BADScw==
X-Proofpoint-ORIG-GUID: pBZTdfG6jh7-EER3QPEY-YbBWbLCPfH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/24/2026 1:40 AM, Richard Henderson wrote:
> On 10/23/26 03:49, Brian Cain wrote:
>> The following changes since commit 
>> 4f4225874d4d3747ec1142e935dbd314218992fa:
>>
>>    Merge tag 'pull-request-2026-10-22' 
>> ofhttps://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/qualcomm/qemu tags/pull-hex-20261022
>>
>> for you to fetch changes up to c8798f02fd9800b9a439b3175b0c94be09cf52cf:
>>
>>    target/hexagon: fix semihosting ACCESS filename handling 
>> (2026-10-22 18:49:07 -0700)
>>
>> ----------------------------------------------------------------
>> hexagon: v85, DSP machines, singlestep, bugfixes
>>
>> - v85 scalar: atomics, CFI/_rb, vector stack
>> - new DSP machines: SM8975 NSP, SA8797P NSP0, SC8480XP NSP0, SA8775P 
>> CDSP0,
>> QCS6490 CDSP.
>> - bugfixes:
>>      - coverity, ubsan findings in semihosting, decoder
>>      - handling framekey w/dealloc_return
>> - handle singlestep exception
>> - performance improvements: TLB flush, l2vic
>> - test coverage
>> - MTTCG fixes: enabling MTTCG exposed races in lock/interrupts and ciad.
>
> This fails one of the hexagon tests:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/17413671779#L1159
> https://gitlab.com/qemu-project/qemu/-/jobs/17412765117#L1159
>
Shoot .. this was fixed in v3 but I must have included v2 by mistake.  
Sorry about that, will send an updated PR.


>
> r~

