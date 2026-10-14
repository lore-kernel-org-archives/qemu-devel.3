Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1831CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqNO-00049i-Rq; Wed, 14 Oct 2026 00:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqNM-00049B-KA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:14:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqNK-0004jo-NB
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:14:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E3u5Qa2222165
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eh7xXTugCEgX88+BKti62tGMVntiiWPJnKIQa6EkG44=; b=W3Asy+0wmPAWdt8b
 vVai5ApD9J0wNJGZqoagCdGK/ZKtmGUSqSIaZkUYefI19t7idEDRy0xINElHeKZJ
 J+WaCf23uMeMwVX05D8hzxzsfot7fdo8qGAYzGgzqLOCJxLjhxzKrAnV1MSjoYDb
 xG+fVUaxb1IyOjQFvSsXwamfU3Vlz5QmTy7TNf6oaLwUM2eFY7+gqN9NcnaljJKm
 WjGvQsiTwCaF6TuvZNAlO4B29cHKcX9yLjDhkv8t/SUPYZDDQJcV/bPxeDA2NLQI
 k/CZKmaMVRG4l42Ou2C42qb1tc1zEbOEDdEJmvWhzxNdKKlQIQJWFnyyKjGgmf6Q
 NnHU5w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txs9ng6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:13:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338974c0ceso102567111cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951235; x=1792556035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Eh7xXTugCEgX88+BKti62tGMVntiiWPJnKIQa6EkG44=;
 b=bWYIjzGj0EXiesY5EQlHU3blUdVJ6EkzjLWLyhG6QXGCBkmTpQ6qIM/DNZCLGlaQTc
 fSyz3CnyEpO+04ivHLX9m7NqmemwP6E5VF7lLzQMyUqdwiIVXkfp3notQbz2Zv0G+Akj
 Vx6jlzqgji4IxWKdXU6s2tveKjuvRjD9mNByIiJxthCp0KOwPbMo/D9iNvQ2bFRKE6Rv
 vw/7DZ3ekdVK8GwePhnxP0mH3xpdnKyjY+R14m4KWCY3tWAowjjQCokOnLZaXujaCqvC
 IRN1wRqbCTThQy2MJTCJpAuEhiEcVdaJ9aoqSgFzGhAfj4KHQOcLQsmWhP0ahackBn8x
 n7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951235; x=1792556035;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eh7xXTugCEgX88+BKti62tGMVntiiWPJnKIQa6EkG44=;
 b=a2stPDjMA9I6czxM+nog8x+WdW/KIgY7hnuWcVAv0A7X4OGlQBXt71wCnuFImxXO9O
 rCcDATxm25jiAvUdwXzJSy2MgQm7A4ewx5k6fj6stnQsFOIESbX+Xr9gx/1wpzfxRM9N
 hHvRJ+u9/z9Q/jxXr2wHTuKEVUpZ7wM7186wBt/H68wErnRuO/kugN9+IvKFu3RNT4Om
 iVX7AxMYBFRSMosxp0IO6rCzxOJ0YiJ9h/tYPlDBp5f+8ZHHIi0uTLeoC8HJBIDmLoZt
 pT5sIKL5E2bAFCDMYzI9xDgVnSZ85GK0nLauTwAAxh3LAlzAcBHQG6H17L5fgsrC9Oke
 jPPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDrBE1g72tJeIKOwdf20OnLeBdbs2YyK87bvNZ+Wcr5kdp3b5FO8hXayQI0gGGALfdZcMXZURGtaXh@nongnu.org
X-Gm-Message-State: AFq9FYLih1oER5vfiVWg4BtyW9vDOcnM6JdKpppldEpR66t/Lgw9E8oU
 U6vGFuVSJzGV6bbSlAdXX4rDLlwavQGlsOSEZw0ITgkUocDLcfHn6TjiuZTRKo9+mcZ9goN4/lo
 rfSAm7ceHAcI4WAu4TjCYCaNI60jkAfM2kRw6uqmqRaJoEy57NGN7WiK4Pg==
X-Gm-Gg: AYBFou0nRbf3qP3uQYfn1biEOAd8522h/V6IS6f5LL/l8m2/9kFBYxqgk8XVb0iuLxI
 E1xP4m+aiOEZu3iGpypuLZdEMld/eo/iFvnjLAzoSwE7mo67fFmcn5b77ErqIrJZBsWlraosb4w
 rGL1OoOpzAG+ZPMKnt8xa6f0cnHuyWUTtjkeBqBzGU83A6Yv1rqVZx5UqFG5fTWTd63m5qoLSgi
 cj7UUGIEHB77PFDHTcax+BMNAGZDtK95DHSv7I7shlvC1l9QH8dprS0Zwm0kj+l1lPFi7/S4EHu
 RcwQznXvL64KJCh+6qVIxCEEy3fAsuemXghvDjAf0jrmMH9/Q3cqim3CfRxpIvsYUfgkvujX9e9
 Oj4Mf8Ew4cvCB67FWz7i1k8lj2WCHhV/ABcCAaarIF/klXzvgjyE0JIDnGmUS3y13oyZurUtK7P
 9nGJU=
X-Received: by 2002:ac8:5fc8:0:b0:530:b2e1:2f3d with SMTP id
 d75a77b69052e-5359fdc2feamr253466901cf.52.1791951234852; 
 Tue, 13 Oct 2026 21:13:54 -0700 (PDT)
X-Received: by 2002:ac8:5fc8:0:b0:530:b2e1:2f3d with SMTP id
 d75a77b69052e-5359fdc2feamr253466721cf.52.1791951234278; 
 Tue, 13 Oct 2026 21:13:54 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7c0214sm117720371cf.25.2026.10.13.21.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:13:53 -0700 (PDT)
Message-ID: <a2a1e47c-b92d-4ae6-9376-ef6fd14a0d99@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:13:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/hexagon: halt on tlblock when the TLB lock is
 contended
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
 <5b415e5b-8d35-4f4b-a5c3-09ae631e6670@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <5b415e5b-8d35-4f4b-a5c3-09ae631e6670@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX7rW0rVq9kg8v
 8yLpGXwEH5syhgks/wb3IsAXsobuoqOk4lmILZs4rmi77n6wSfxJAU+7w3NnvHWwgkQ+l8DdyXQ
 0CzeYVNrFDNOFN+m77HtzQRoWyRXXuaUIwbchbj1/9GWPx9T3SzDWLp25MOOUcNtLrCWQUF5Njq
 pcwL2teSrVz1vH3ugES39aN1A1GvMsrsZoGorEgHVbTp06xMrC7533PM60QwZu6q4mem/f3yYTz
 BUbpexmj3dHHS8RtzzPncsH5yJg/GMFDTw7s7q3jpvMBivGZxFA/1otO8SKXeLj3G4kTIZJ2TbN
 pzx4EPmOQpWbX09dAV8wzgIGw7/H61gVoxmhOkfIRInhMhtynSYC1hmtn78hmf0cEvILsKuUG3X
 DC43Mm+jh0iO9jWglkmsQVUdBK9DcD6ntmmtG4htUn3/zaLLRGwBqCxSsw4m/BlOSFSaIrJCL9t
 jJZDTOO0Prc9wU4os3w==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6acf0184 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=eWhtmVagNa9x8AhgrRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX85dh4jZO3vzg
 dNnomZJVrK6q4Aw2iOY+leYsXjUV2Gy1nWqTtyLcgyUIQ5nbfH4r5uRppjYleA51XHz8fqvpYdb
 Qr+TWmmUYM/OgCl+5AnNYl/eucSPmXI=
X-Proofpoint-ORIG-GUID: knb_gjpzv8JwKOzeMMgfiGCfnKkaJRck
X-Proofpoint-GUID: knb_gjpzv8JwKOzeMMgfiGCfnKkaJRck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140016
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


On 10/13/2026 10:01 PM, Philippe Mathieu-Daudé wrote:
> On 9/10/26 21:25, Brian Cain wrote:
>> Set PC to the tlblock instruction and leave the CPU loop when the 
>> lock is
>> contended. This retries tlblock after ownership is passed and prevents
>> execution without the lock.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/hex_mmu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
>> index bdcfa057c21..b9fab949d0f 100644
>> --- a/target/hexagon/hex_mmu.c
>> +++ b/target/hexagon/hex_mmu.c
>> @@ -12,6 +12,7 @@
>>   #include "system/cpus.h"
>>   #include "internal.h"
>>   #include "exec/cpu-interrupt.h"
>> +#include "accel/tcg/cpu-loop.h"
>>   #include "cpu_helper.h"
>>   #include "exec/cputlb.h"
>>   #include "hex_mmu.h"
>> @@ -185,11 +186,14 @@ void hex_tlb_lock(CPUHexagonState *env)
>>               env->next_PC += 4;
>>               CPUState *cs = env_cpu(env);
>>               cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>
> Pre-existing apparently, is CPU_INTERRUPT_HALT appropriate?
>
>      /*
>       * External hardware interrupt pending.
>       * This is typically used for interrupts from devices.
>       */
>      #define CPU_INTERRUPT_HARD        0x0002
>
> or is there a better match from "exec/cpu-interrupt.h" definitions?

I think CPU_INTERRUPT_HALT is appropriate.  _HARD is suitable for an 
external (maskable) interrupt.  The signal we need here is one that will 
cause us to stop executing instructions while pending on the lock.


>
>> +            cpu_loop_exit(cs);
>
> This call makes sense otherwise.
>
>>               return;
>>           }
>

