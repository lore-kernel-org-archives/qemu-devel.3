Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B482606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jN7h/m/a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqcY-0001VJ-7L; Mon, 19 Oct 2026 12:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIqcW-0001UY-1M; Mon, 19 Oct 2026 12:53:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIqcU-0005Bb-2b; Mon, 19 Oct 2026 12:53:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiLG54116529; Mon, 19 Oct 2026 16:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+qxtbZ
 Gzbd4Mp50HOcbH/2wMV5ZdR0nc7jnkimozo64=; b=jN7h/m/aM2OqBHfULzahIA
 LEjD5JX4USdLUvkJl6BjiASOAQY7iAxbt7MRZq1XQVZ49mbCC4xdPEwJVE3Yj9HP
 TIY9I8oRuozwgpXPUeQBll3TraL4q7sHlnTC3Igr3LRGTTVrWUEwgGRV5ZaAhW0g
 WKCaMaP/qV5W+HYMWe+kjvTbbLtlMStkaB2dsgb7WZuvpDD4iJYbUDX3RvxBWmFc
 yF5g0SHoMfhY0PbpyC3Eq3dwZv+4PVl4BS2xIRbjtsnLZDlNV9fAF16o/7oxmNDH
 D6uDfAKbFFrianZ3z902uUNWJUeALZ9A48/a5dcx2C3sjC/m0o+8Z244D2Q7E3iA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehv1p5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:53:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ43j121747; Mon, 19 Oct 2026 16:53:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq6sew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:53:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGrmZv29688534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:53:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F6EE58056;
 Mon, 19 Oct 2026 16:53:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C6058052;
 Mon, 19 Oct 2026 16:53:47 +0000 (GMT)
Received: from [9.61.191.236] (unknown [9.61.191.236])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:53:47 +0000 (GMT)
Message-ID: <2e4941f8-9192-4fb7-a352-2296307a775d@linux.ibm.com>
Date: Mon, 19 Oct 2026 12:53:46 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] tests/tcg/ppc64: Skip float_conv* tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-3-farman@linux.ibm.com>
 <9c7fb198-06eb-43ae-b945-bf789158a68b@oss.qualcomm.com>
 <1d797652-50c7-4292-9297-61b09aefbac3@linux.ibm.com>
 <03cf8b9e-c23b-4286-8c19-7094f7865f8a@oss.qualcomm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <03cf8b9e-c23b-4286-8c19-7094f7865f8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX6j4Xw3nhbZ45
 ipC1lREEoQayO5z8ZPKNjb8lr2pdqazy6MHI5BkFdhlX/7/TB4SAWuJejVm5gTmu58yanuoxACn
 ryBITkW4vxXfz4nl6uw6MpLhtss03bkrFKWCq3Vaskz4CrpMQiLst7keor68kAzPEomeW+WdDGh
 O9FHJLMaR+vZK1ibXCwUTc9xkKoy2pymqAtm0uOsHdnx+WrAgbTrK2dxKpPjneNVhvhjfDshKPt
 9taoCiP/jMLTqEW3dXKj/oGfmpsxtqJVpK2wtGNwK5UHE91fGybYjTPMEGne1G/ghymgTGzaXvC
 ddPKdq6xJT3wRGAlf69UX0jO+kEy6Nj6J6BvSPky+xCBPtSblH8GeG9zFvj8XEkDOQIQyrULeeM
 nnn3Xfy64BOfncqm15e49ICVeoyqRrOPyCIeAoQY2kWl9L8mt2reNVQbnugTyo3TEx81RuUNFxv
 ocSYVDijK8xDRty/z2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX7fGWb68Ar0Ri
 ByL2jNsnqz+4zpgYKT9CbYnrBCUd1bsqA2wYKWqtzl+XSqyStqBHAv1Nghi5vgviuhrtAICjL3a
 U2VT5go9LSNPHdrnt1y4IJDlvU18VKc=
X-Proofpoint-GUID: VP0fzokskeCQyfGx3ua60tRO5zlXx5KU
X-Proofpoint-ORIG-GUID: wwIy-fnFAlLbHRLOdwyzT62KeWiQt4Dm
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad64b1f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=LJKnelaLU_koa1p8L4UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 12:44 PM, Pierrick Bouvier wrote:
> On 10/19/2026 9:23 AM, Eric Farman wrote:
>>
>>
>> On 10/19/26 11:59 AM, Pierrick Bouvier wrote:
>>> Hi Eric,
>>>
>>> On 10/19/2026 8:12 AM, Eric Farman wrote:
>>>> There is an oddity that turns up with the float_convd and float_convs
>>>> tests, when running from different toolchains. As one example, the
>>>> expectation at the start of tests/tcg/ppc64/float_conv*.ref is:
>>>>
>>>>     ### Rounding to nearest
>>>>     from double: f64(nan:0x007ff4000000000000)
>>>>       to single: f32(nan:0x7fe00000) (INVALID)
>>>>        to int32: -2147483648 (INVALID)
>>>>        to int64: -9223372036854775808 (INVALID)
>>>>       to uint32: 0 (INVALID)
>>>>       to uint64: -9223372036854775808 (INVALID)
>>>>
>>>> But, other hosts offer a different response, e.g., this debian guest
>>>> on a laptop:
>>>>
>>>>     ### Rounding to nearest
>>>>     from double: f64(nan:0x007ff4000000000000)
>>>>       to single: f32(nan:0x7fe00000) (INVALID)
>>>>        to int32: -2147483648 (INVALID)
>>>>        to int64: -9223372036854775808 (INVALID)
>>>>       to uint32: 0 (INVALID)
>>>>       to uint64: 0 (INVALID)
>>>>
>>>> The explanation seems to be a behavior change when compiling to
>>>> different
>>>> versions of power hardware. Disable this for the time being, and it can
>>>> be added back in manually with the correct responses.
>>>>
>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>> ---
>>>>    tests/tcg/ppc64/meson.build | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
>>>> index 8cca4d65a4c..ee86a75c23a 100644
>>>> --- a/tests/tcg/ppc64/meson.build
>>>> +++ b/tests/tcg/ppc64/meson.build
>>>> @@ -13,6 +13,9 @@ foreach t: tcg_tests['multiarch-linux-user']['tests']
>>>>        if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
>>>>          continue
>>>>        endif
>>>> +    if 'float_conv' in fs.stem(src)
>>>> +      continue
>>>> +    endif
>>>>        tests += {src: setup}
>>>>      endforeach
>>>>    endforeach
>>>
>>> could this be made deterministic by setting an explicit -march or -mcpu
>>> compiler option?
>>
>> That's what ends up happening in patches 3 and 4. I didn't like the idea
>> of cobbling a conditional add to an existing dictionary of options
>> within this multiarch loop, so thought it'd be cleaner to skip it and
>> readd it outside the loop. Could squash them all together either way, of
>> course.
>>
> 
> Just saw that after sending this message, thanks.
> 
> For why to keep them in the loop, the reason is to keep multiarch
> definition centralized. For instance, by removing and adding them, one
> plugin test was unexpectedly removed. It's also just the general pattern
> I enforced in all arch, so that could be nice if it could stay enforced.
> 
> Thus, I would invite you to use the following instead:
> 
>       if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
>         continue
>       endif
> +    if fs.stem(src).contains('float_conv') and 'cflags' in setup
> +      # ensure float conversion tests are deterministic
> +      setup += {'cflags': setup['cflags'] + '-mcpu=power8'}
> +    endif

Yup, that's much what I had, though I overengineered it in case there 
isn't a cflags.

>       tests += {src: setup}
>     endforeach
>   endforeach
> 
> You can squash the ref files update with this change, that's good for me.

Works for me; I'll go through my combinations to make sure it's still 
behaving and send a v2.

Thanks,
Eric

> 
> Thanks,
> Pierrick


