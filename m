Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3F1CA601D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFDQV-0004mB-JH; Fri, 09 Oct 2026 12:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xFDQT-0004kf-Vs
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:26:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xFDQR-0004qa-RQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:26:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699GHIXh846212
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 16:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fl8xgxzjTRnFH1ggvGav4/+ihN2M7oGruBpj+SWVqvc=; b=oMj+mUSweKU+xhBy
 gyv7CMp1EL7tG4GzK0O9CV4XX103UYaT4Ag7EQcYDaRGliHIPmJK7srJ3kqYo9Yy
 xGvT1zLAqBtjR+7rBykW1Sqyus8yvB2orjEQMRjSk4XjJDGk9gEbur3HJ/ou+jXO
 VGmX2WEH+dPl+KcQw0f3UMaPH2W/5K84EyztxvYh3psemhJGtATJ9y1qJlo9pKUS
 OI0UQmYwIEQy0NdCv6KwerkIAauFujqzn5+qPtq2VSwNPqaz8VUoloJ0KjM44MqP
 9X4WUhY8RPWN0TN+C42HVpSZDotu6AFW0JhPjIcIoK+Y8PtINXojdKB5aOwnuh+/
 Scc5Gw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h71f28n9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 16:26:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso1082039285a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791563184; x=1792167984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fl8xgxzjTRnFH1ggvGav4/+ihN2M7oGruBpj+SWVqvc=;
 b=VIyPrjUtBWQSJAhxaglIZPcPP35FbvVSHV3YbyABKS/HQCjZ10sNzZ71H0A8+ejZAv
 1FT2EykhaWKFFByLRa+/hBjs2K5WY+xYI8sj9qsdkcFw0VJ+mVFkFs3sDn3DsSGMCR40
 dzQ9XpT/HYUoGH1LoO4n1/32WZJeQf/WOuzH+V0akb4eQXONVDSZVm5RG1O2/+vBKp/a
 wvq6AFtZjQg7M6ik48m/W7LjKE7QR3SUm47mf2+1+MMmgC+FFCseBMmTT1jDinVRdANz
 DvdWp0nRwtrrZEi3KuRFNgu18QjwJaQrg+KMTxv+WtUVTC9oHw+S3cJKdsg5W3K0S0EK
 YpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791563184; x=1792167984;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fl8xgxzjTRnFH1ggvGav4/+ihN2M7oGruBpj+SWVqvc=;
 b=KsjrVPx/FqSchJZK61EaKRbZY3zA4Mkq1Yh1QIdUtR/Bi7m09A9D8h4mNKOOXxuIOR
 NzZfm1Wh0w7QMBspoNGwbUyRbkJx0iZzXSVYXaNvCr0SiDjBZO64Lpj0ZzX4WVEyBNa6
 GgMD42uQ+QMbx7UFQf5A6mcCLdEUbNlCRybB9Ml5gzqRb3q2YZQItZ3AOK6vOdVCrke7
 H4HJRyLkrG2gUWa0I3kUlou2tNvulL/C/EnTtmdWmbVtk9TNrMD+7+XBhSzhd9lZ75ou
 0a+/odTCGz3Q0gSqkGwU29SZdiSp5BU/FyjqVwYtKHeorsUR9Qk4hyRga8uimXHAQr2k
 rgEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSWoQZKiprwZsH7ZQDaP9D02lOD3SyKXpRNAkBJqT1oePY+agfzAZQ0DMtuJhHgPTdZi05bflSnyjX@nongnu.org
X-Gm-Message-State: AFq9FYKUPEY4gob9jXSZBLwCEr4dWlLfJrz+hhdCxzZgO1IK15R3iskD
 ZeZ3mNUR+Ky1JRuYEbxJ9lMEJD5EXZgFmrQ7uvEdfKuasXNCAOJGwCN2OHpeKjqpUSS1QoRmJ1C
 Sx2hXrVpDJB1O+d09VJvvkCvR71UXfTDNN0W6Hj1LmzQPbsuJST0uvuww4w==
X-Gm-Gg: AYBFou1uEt7Cf08Yr8/D3hUVwu5vgSjaBalrn0vTRyaf+gkCiW1y2pY+I0f7Ak/pBv/
 YbDyFDiKCfSQM3wL96ssnlmLIR5P7oF73nKpyLUN02vOhToV0qXnOke5XaNsIfx1quuYLcPZWm+
 0d688fpaCXhawj05nJT6ta8+CdHGtil//UHshRyFBxHIn1sATZ/cfO75gG8cHOJk2CPnDypt/oo
 1Py1uTy44QNWOT87ivrYuVqxSDBV5NWKwZjBUA7nP4nHiEeBF4jpqdbsvKgHP1zEybb1P2RcfIx
 Wo+iQezjnqeisoxmPnnECTPMPG+x61ST+twjoKJzjjBSMRFHYP7TGxPft6fpzQxSn7UXnmGOlcC
 Wk5ahkYEI+Wgcn2CU+EitIzZkNKOkW3PueQ==
X-Received: by 2002:a05:620a:6601:b0:93e:4dd3:bbb1 with SMTP id
 af79cd13be357-93ebd1e0104mr376937985a.19.1791563184110; 
 Fri, 09 Oct 2026 09:26:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6601:b0:93e:4dd3:bbb1 with SMTP id
 af79cd13be357-93ebd1e0104mr376931085a.19.1791563183408; 
 Fri, 09 Oct 2026 09:26:23 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd574sm4869456f8f.34.2026.10.09.09.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 09:26:22 -0700 (PDT)
Message-ID: <a3119c65-fc70-45ca-a9e8-d0250d93892d@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 18:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
 <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
 <6992a79a-96d8-4b73-8552-cae7d8102b17@oss.qualcomm.com>
 <b6fdd824-499c-4a4f-aaaa-04881381703b@oss.qualcomm.com>
 <824d02f5-b9c0-4a3b-a31d-d34f8cbfa5c7@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <824d02f5-b9c0-4a3b-a31d-d34f8cbfa5c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TnZSrWAmq2gUwdk7IpG6Xi-Yd_ZrypXZ
X-Authority-Analysis: v=2.4 cv=Nf5zRGD4 c=1 sm=1 tr=0 ts=6ac915b1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KNwXWR8cOSQN6UGlVC8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NSBTYWx0ZWRfX/zKaQV5A8zv4
 i0oZHsQikz/wRwQPEEqoKDfAuS0lklDV7YqSH2FRUScIg4hnZeuKh6JD8dZd2vWmCH4OmR+dGWt
 2rOGRghEkrKiftJ7qs3R5YIxFbqE+fU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NSBTYWx0ZWRfX1MSt3QeoKXO+
 2KZFCkYe24XgfcmnNBGuBCwP4s7txbCjR1RXNa4dYCV5PYHLZLvOHFiKJDUieR1LREGcHsxM1YN
 RvEgrg50exy8CaFxkm9NThBuUEAZ5CyyC/9+aktpBKrKZQHjX4xokrioaS9h2gPgUxfi7CcbJ4f
 5Jy1X90+0RozDDpPwcNQRaqbHruC9vXPKiSpI1TzB5bsyAf3K8zIp6SdOPYbCZg/eDqvbCa5SXI
 jJGIYDpVVLxYuKZsVnpbhqyHxxcwGKL1daDywLQhCvo9xkjzTLqpFchpPbhDmLyuw6rm9yFdoRJ
 Z9/R3nlhPTIDZoD/atUe3/D6q+vUeFg0jBjdkEFeqVRCZDX5ws0EmiGsRwaJH4Z6FbM666NX2VL
 +Gx/2+vfogS3a+iQT9vX5Hs/oDsmiVu2nwR4L7Ojh7OfXFGqDipDZfX6HqdmX1HotcNKU0QCCf1
 49X+wZdXFpka31YoFfA==
X-Proofpoint-GUID: TnZSrWAmq2gUwdk7IpG6Xi-Yd_ZrypXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090065
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

On 9/10/26 01:10, Pierrick Bouvier wrote:
> On 10/8/2026 4:02 PM, Philippe Mathieu-Daudé wrote:
>> On 9/10/26 00:53, Pierrick Bouvier wrote:
>>> On 10/8/2026 3:26 PM, Philippe Mathieu-Daudé wrote:
>>>> Hi Brian,
>>>>
>>>> On 8/10/26 23:10, Brian Cain wrote:
>>>>> Hand the k0lock/tlblock lock implementation functions the packet PC
>>>>> as a
>>>>> constant instead of relying on next_PC's opcode-dependent staging.
>>>>>
>>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>> ---
>>>>>     target/hexagon/hex_mmu.h    |  2 +-
>>>>>     target/hexagon/sys_macros.h |  4 ++--
>>>>>     target/hexagon/hex_mmu.c    | 16 +++++++++-------
>>>>>     target/hexagon/op_helper.c  | 16 +++++++++-------
>>>>>     4 files changed, 21 insertions(+), 17 deletions(-)
>>>>>
>>>>
>>>>> -extern void hex_tlb_lock(CPUHexagonState *env);
>>>>> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
>>>>
>>>>> -void hex_tlb_lock(CPUHexagonState *env)
>>>>> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
>>>>
>>>>> -static void hex_k0_lock(CPUHexagonState *env)
>>>>> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
>>>>
>>>> Please do not re-introduce more target_ulong uses.
>>>>
>>>> @next_PC was converted from target_ulong to uint32_t in commit
>>>> 613653e500c ("Hexagon Remove next_PC from runtime state").
>>>
>>> That's ideally "cleaner", but in practice, since hexagon currently has a
>>> single variant (32 bit only), it's not a problem.
>>>
>>> In general, for targets having a single variant (only 32 or 64 bit), I'm
>>> not sure we gain anything from chasing down usage of target_*long.
>>
>> I prefer to share my thoughs because some maintainers realize
>> "oh indeed this sed change will take me 37 seconds, let's do it now
>> so Phil will stop bugging me about it" and directly reply "Since this
>> series is fully reviewed I addressed that nit locally before posting
>> the pull request, all good thanks!". Anyway nevermind I'll redo the
>> audit in few months and clean that myself then.
> 
> Sure, it was not a "stop bugging about it Philippe" comment, just a
> remark, for Brian also, that what we need to prevent is introducing
> target_*long which create duplicated definitions.
> 
> It's fine to have target specific code, as long as there is a single
> target variant. Just my 2 cents.

OK so this is more about our distinct way of work then. I pay attention
to detail and often derails and get delayed / lost, while you keep focus
on the main goal and get there faster. Thanksfully we are complementary
:) I'll try to reduce my scrutinity on Hexagon code base since you are
actively looking at it, that'll help me to focus.

Regards,

Phil.

