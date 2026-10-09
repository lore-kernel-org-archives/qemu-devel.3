Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D14CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 01:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEzYc-0002hr-GH; Thu, 08 Oct 2026 21:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEzXl-0002cR-9c
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 21:37:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEzXh-0007L5-DM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 21:37:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990Phfe3578902
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 01:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2grHLSQNYDnFI5HG4w2TqJ2JHPI+cEahIQ/HCNK61JE=; b=ilIo6pVasHzGFUHM
 m386/KUCu/wBtRLEL2lyOwPXNMBt62aKhwp42h3a+tgkyz4qPwFHxvjELBEIC6T3
 dtoPMoEvfb+MNv5wS//hIqhPxr9Ai1yvmP9pz907T9QLy3pP9Yo7kNxP2JA1pwtb
 Bq6WJBTvYar6rGpTBh65cskMNsjyerKuPUPPtEttEFXpD6UUSMS8IxSFNztiolDa
 12/VlKpR/LSyX9B7w1pF9fLVywGkc9CXVJ8FTZ2U5srUEB5BWAo4Z//ytMBaCPKq
 TSFpq6B8Ndqi8lTdDjvwVjbcdKIeAvr+f8eZ9QbSZmsUTQ3i2ABOdJstlmjMe0gS
 qHJG6Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk1byu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 01:36:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-535851217d9so47225511cf.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 18:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791509818; x=1792114618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2grHLSQNYDnFI5HG4w2TqJ2JHPI+cEahIQ/HCNK61JE=;
 b=VWl5kaV9enyJTRPulUlMVvK6VbW8TGI6AKW2I1q1bwdFnRRSV5P/Vt1VRsKDMNGrXI
 HMK3A8Xqrj83KkKeM+A/mR0T/cIvHSq0ufK3CzXjcHIvhmzTlIeGDPPE08KDVJjRXU+x
 3az1QEAiv1IOEYF5BU+LKpxXBt3dtjEZiINoiVT0qPP16VpzrSr5AN2+7p5aOO3wB9W7
 bLBMvqRC/zxHKA297mlDLIxAwLgGFz7Q6oVeWLS9dyt1i2fdXoE0sLoNCnHJ1kWN94vG
 ksZhKziyn+etM9mpmLTiZ3X03FFH5+87I4VkHqANPUlNMUb3RDPIpgvIEAluv3WP72vG
 znNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791509818; x=1792114618;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2grHLSQNYDnFI5HG4w2TqJ2JHPI+cEahIQ/HCNK61JE=;
 b=0y87W8tw77+ZSceL+jmiJuTIAxIuFIxOLwnA4YXy3rh77HNHJWAgven5D1ig3haTz2
 DIkut7+fKr25DRJIINFZ3IIjea+e5AsgCYK0Lm2RgpotAYBc+OGffi+B0JbjuL+0xHCE
 6HSjPHjp5NLp3B8AFH41IAQrGtJ0dUKjhJy8MFz5lImbv7OwS7Phi2V4cD9CLEfZ2Jhp
 7R04RGaazstmY3bcvw1O/NGtnX6pqCqRdo/2f8xLUGTAj9Tv9Sh2cU7kENrB8NG/ll4Y
 V6SXzoElZjG9+RxXwccOxApaNx1S7rVvysPLiGQ+QLwQr4hTz3Fmf8od3MgqLee1txOh
 AnIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjLaXfDN3JfB97n8sKoq5QTR1p5kt6+s8669ziYpT2cSd13jC1OWqnc7NV2k++6RSGowvKDPeOCVzm@nongnu.org
X-Gm-Message-State: AFuF++nUY31AwWYYhDgIlaQ8MNFfCez51eIqKwjXdDcoYzvI3Aorc1ny
 mQDjI15zuGRQ9bz/7DWdY3F9zOPLWjceMA3kmWarq3X0CBGDxr0Sho8OyTsOWqWI8K2F+LInucV
 wekfmpflHMadrOGkskpgnFViReZmG4jFYpNQMVbJk9fxkF1jfIMzjnlx4wQ==
X-Gm-Gg: AYBFou2Bjo4+GSRamZIgKld5FDr5ijSiuQa4AIeBRzmucKm7sxvKSZI4NQsG8X9FaE6
 sPW7A8taCcxqLtuA1J9O1U4udrObaTHUtDEUykci6AWMkV5bQWe39ezjYc92kHZc44F8YVvTBqn
 il7AXZ+CkPmdEqcE6p0ZZEv+pL2pJ0dnkNGy55rsq0fScHvG0hkAZjGuJL4eopGkc6sXqMZMEcM
 z4gOwmQnwINSpjejNyuXp8wOdto9igmcmqAwwYQ2+gSQuuVEfTb9JWGx2fRncumGSNS8n8xNzGW
 IquxLCleG+hgNWyvUY8+XSswUXelnP1FOI2LKCxjnv0Q951G9ONI+tQDC2IGCvWls05fddmUGCW
 BiXQrJp2WNkHcRAyxY+sl1/F9l+415zDWfY5ttxBK1xSTty/3rUGrqJk/ag==
X-Received: by 2002:ac8:59c6:0:b0:533:415f:4290 with SMTP id
 d75a77b69052e-5359face2f6mr8418541cf.25.1791509818349; 
 Thu, 08 Oct 2026 18:36:58 -0700 (PDT)
X-Received: by 2002:ac8:59c6:0:b0:533:415f:4290 with SMTP id
 d75a77b69052e-5359face2f6mr8418311cf.25.1791509817888; 
 Thu, 08 Oct 2026 18:36:57 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-237-68.myvzw.com. [174.237.68.16])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b6fa262sm7693941cf.6.2026.10.08.18.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 18:36:57 -0700 (PDT)
Message-ID: <16dd3da2-2fad-49fd-810a-b12fdeb65901@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 20:36:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
 <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
 <6992a79a-96d8-4b73-8552-cae7d8102b17@oss.qualcomm.com>
 <b6fdd824-499c-4a4f-aaaa-04881381703b@oss.qualcomm.com>
 <824d02f5-b9c0-4a3b-a31d-d34f8cbfa5c7@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <824d02f5-b9c0-4a3b-a31d-d34f8cbfa5c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac8453b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=cMASl6d0ORhCJ5zpoWum5g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=hVDM-Hg3bIHD0ZTcbuYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: EhH4_ZTWb8HBdpYrb8zRzFxy5ky7Lxrf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfXwHWlQC9wVdVj
 7qKmwvnzGvi0Fi2fUhF1BUx3VhW7nAPElymXS25/kllbK79wWE5k+a/yKQW7BbkefTjjZaGGWK9
 TEOXSo5Q6o7K0fDcrAAoTBE7FWdY4DM=
X-Proofpoint-ORIG-GUID: EhH4_ZTWb8HBdpYrb8zRzFxy5ky7Lxrf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfX1B6op1PbV6fB
 UqauL+Rd9Q774N4CnFBYS8r00uhwTAmuZ78Lxkz4bmYzSSlNiSE0tXpXbBqY/9K4wHsWRWLU+TU
 u2jI+G62livFqdGRDY6A0IDG2XT+/HLaGkz1ysbD3iUofSKilJWO5wnamFqW61LkRsvDssqxsU7
 O3EbdeVUUf+ejaUW+/ds0i4P1LG+x1d6/UboI4qlfd8FNDZaSrQmIk9LPCFgLJ2Tfwd9+Lxxvzq
 WKjPzEtDWEMwoTFHkIDGBNmR/GuiNdZkZLFk/E+pD1uckm7A1XQGz/ub7b0BAaeyXsa6qN7yWre
 SuOQTVzljzjcK8IA5aY9LKGY52Up28JVn4g4H9c0XA+TwpJYthTdVAi4mGP30mQxcUlvAJEC2s2
 EXL7jzHrvprtxerAeW3SgJMlp3y0U9kqCjrd3xmcS1U7QnMUjjrDRS9CxEdXD8Izm7ZkhrzZ/mp
 a0TK5PXBG14y8fBlXUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090006
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/8/2026 6:10 PM, Pierrick Bouvier wrote:
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
>>>>> -extern void hex_tlb_lock(CPUHexagonState *env);
>>>>> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
>>>>> -void hex_tlb_lock(CPUHexagonState *env)
>>>>> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
>>>>> -static void hex_k0_lock(CPUHexagonState *env)
>>>>> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
>>>> Please do not re-introduce more target_ulong uses.
>>>>
>>>> @next_PC was converted from target_ulong to uint32_t in commit
>>>> 613653e500c ("Hexagon Remove next_PC from runtime state").
>>> That's ideally "cleaner", but in practice, since hexagon currently has a
>>> single variant (32 bit only), it's not a problem.
>>>
>>> In general, for targets having a single variant (only 32 or 64 bit), I'm
>>> not sure we gain anything from chasing down usage of target_*long.
>> I prefer to share my thoughs because some maintainers realize
>> "oh indeed this sed change will take me 37 seconds, let's do it now
>> so Phil will stop bugging me about it" and directly reply "Since this
>> series is fully reviewed I addressed that nit locally before posting
>> the pull request, all good thanks!". Anyway nevermind I'll redo the
>> audit in few months and clean that myself then.
> Sure, it was not a "stop bugging about it Philippe" comment, just a
> remark, for Brian also, that what we need to prevent is introducing
> target_*long which create duplicated definitions.
>
> It's fine to have target specific code, as long as there is a single
> target variant. Just my 2 cents.


Happy to fix it and make a note to myself not to re-introduce it.


:)



