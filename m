Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LcRocO08;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XF2U3u28
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLult-0001fl-Ro; Tue, 27 Oct 2026 23:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLult-0001fU-92
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:56:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLulr-000722-IN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:56:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S0jAIt113413
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RBk2pLwKUJr88MxCa76CnpOXH2RccLJg/MmUB0q8g0o=; b=LcRocO08k6ZZ8oAI
 GhFZBzryShSYeEnDpEEBVmfqPqAL9t6atRhyI0yJfGtdANPhTw8VgkRSaMalkVho
 xvglmeoFOXTVelclnUf6OH1Mum3Yv1b4QkWueNXgUcXVgAZmILS9F7GM9X4zavpv
 l4clTuYrKeZhX5JiW7qsSMWr+rlRXzWO6yvDU6By0x8plIfwztMQHa4npKNK5Por
 CDQOaKBGCVaNvCksy+K/MmApD1Ash1cLo/pb+n+WEnqQL/nCxO/hTTfOXE6yFWRK
 3Sgbz7rqOyeTaA/4guzvEEIC1AObCIFN25IVhtBvzPtrZYZ8hcPpLBRCHs8d5/Gx
 /wq4oA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk2qe1bye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:56:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3552883bd19so21494eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793159772; x=1793764572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RBk2pLwKUJr88MxCa76CnpOXH2RccLJg/MmUB0q8g0o=;
 b=XF2U3u28e+mK/ittGQgAznu06J2qU5dxhHCnf2XxLFHYsVzSqM8pSPY0v7oT+MUdtX
 3DWetj/6aZa/sbEPdAdOYSL+ogjbiLngPPfwl+g7duKBBbxpKBDG9MUv2CiwN/w4A5t/
 CoWV/rHL7FsSlS3XSEWokhFhsqXji9WF7BmvzpwLLvTFuPzW6G+ulEXbIBMMHIcb1Q95
 J5ptMO+Y3F90lHnThGwi59V7MIsR5XgtpNQW/EotIE9BKoxxs5ftpBym3pn7wYvhkuaa
 AR1h0gZco0aBoY91Uv6wniYz47Gqxey3jUNmspyIKOIkOWM+Hg3iV43S4YWzewDKa6zB
 xnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793159772; x=1793764572;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RBk2pLwKUJr88MxCa76CnpOXH2RccLJg/MmUB0q8g0o=;
 b=RWqJEdoEAQj839zLNCeYIhaieIEq27+xyeZUAdSDsFWA8eoTtfY3NBDVTNmVUG1sAY
 LXx6SClwMHq5zMNCHkuLIwrgLiT3xxTfPSW729ZYd4S/C3FZ1ENvGD55uxyFtE7CS83Y
 ULlVXhOjKAQr1cdEUM6DOVIqKiORM24D6ncMT7ZOsJOdQ8/1XpWUK8oCIfFW+t1iButi
 gt+0AdGnYKOf5yrcxxIK4/zDtLIRb/ZTQ1XeX4woOhUcN/R0hGHFyPvBy+Vq4V0COomz
 /dsxxpLbkieI5El4T+AeRAxqOjXA3kLB2ONz+NmChXP3zX58ZTRW/YsQE00XOHyDIJU8
 tlLw==
X-Gm-Message-State: AFq9FYKPmk7DXOhlVyRNpOH90Z3RhCNMhiw9s8cuA16TSBPVY6IUoMXF
 jKbHaS+DNGRsyB99tSKTYOoWAHAcLROw+qPneqSNejPcjUIiy44QGc/ycr4VWXlQp9UqZDejxRB
 +0xNfZVOnsJJ59+1SMR6gt8kyTNbU9pKhdMlirrr2cix5KlZeW6Nzo4Lu3w==
X-Gm-Gg: AYBFou1uAkoje1IOonZercLRgvGJA5SM1JARSKWoMgMeIYvEa8m9oxRtpKgzz8lAr1R
 jC/RBe7C4V1umGYZ6wHdYGy7+FW/j2Neb3UX+YUQ/Lc7Hj33ShIigYeriksXpUDQI7S6krav7i+
 dugcJkD6GHJLQroXBzrSeN6ZZAdntrc+CGTyIz3eAc8UnQqTHeIeB6nhfuKyUvCx6QFuCEZUh3H
 dLeOfgT/5JMiQhxAhF45heVoOfiseLvVEBCZjNjYuBRNtnRpIKb36m6MWqtn+MH2T441wkOmYu0
 dYYPiYZd0ZNXlHiV9+AWbsJHbfOq/9C7XHqjKfWdMJOMMc5Z2Nk0kAxJkI6AXqJNJDJqfHWXvno
 CImas5CrzzJnOvtis+j0l2vorFK3M/i/G0AM03Z7iLvSOWu+xaZD35f/0kLrM2cAm43nhE6rJcg
 LKTRWI3nka0otqAG1r5zdxOboKod/ted3w9V4RSesXn/k=
X-Received: by 2002:a05:693c:2411:b0:358:3426:d601 with SMTP id
 5a478bee46e88-36a202e9e62mr2130490eec.2.1793159772453; 
 Tue, 27 Oct 2026 20:56:12 -0700 (PDT)
X-Received: by 2002:a05:693c:2411:b0:358:3426:d601 with SMTP id
 5a478bee46e88-36a202e9e62mr2130465eec.2.1793159771808; 
 Tue, 27 Oct 2026 20:56:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2392ecfdsm1936133eec.17.2026.10.27.20.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 20:56:11 -0700 (PDT)
Message-ID: <b45d0be7-519b-4c7e-9934-02929e98b1c1@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:56:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
 <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
 <bade67ae-332a-4b51-aa4d-02c49867dd91@oss.qualcomm.com>
 <CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7HB9NCTtCooTny4DJRBRLQ3mpnlm31Ji
X-Authority-Analysis: v=2.4 cv=YuGa1IYX c=1 sm=1 tr=0 ts=6ae1725d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Oc-SoyMnGXBHGrQTnWkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAxNSBTYWx0ZWRfX4kXgv3RSbAP6
 RxALNtq2v7TPP25rIreUZ4WAseosvJtuS0RXXWuJnVpjdgllYdk4uPtMPQItp/dnk8uq+tw/MtP
 lA6wSSEJ6nE+GnWpg50yF6A8G3rLJhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAxNSBTYWx0ZWRfX7INJ9V0DD32c
 RQ+kv1Z7HRJtPB0JO4Bb9yIM92r4gRQKLWgTJTlTlz/aMfitl1u0KHV4YxJgbezQgQo0t56ROkA
 moGbkJWFdeoTxS6pPGVnb3jhglL9od3e6/uzP9VIPVvbpyozmZoaPt0OfEC1filElg9w7vE6v4E
 CFL7T9bSybfggR9VxPpsbs/tgQb0cmcQV/O+NCRALPn7gQYSh45TQXB96aAoNgbFyFeQ00aIB+o
 rgclZxLABx+XfOvDsJNKLlGaNsnWKU7EljETiPy4egvr9jroeXmis3c7W742Jpxnd2Re4tIpx1T
 Xs4C5u3Xt9xnbEqmVmYX2hpVypPT6uVie/CsiU7emqDr2LfNZsffxRxA2wixwUfWP8wZhhsBxPC
 sF/KFLhhe8+B5Z/A1uOD0lp/yPKLNm1Ra3VJjQ7dzSzeS5tV9z8uy1J4U9uDXJSCdYz3FgLSXxL
 6rsOd/ILgXJSWDr65zw==
X-Proofpoint-ORIG-GUID: 7HB9NCTtCooTny4DJRBRLQ3mpnlm31Ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280015
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 7:15 PM, Yonggang Luo wrote:
> On Wed, Oct 28, 2026 at 1:40 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/26/2026 9:57 PM, Yonggang Luo wrote:
>>>> I hope that through the recent series sent on multi target topic, you
>>>> can see better how to try to slice work in smaller pieces. I try to
>>>> focus on having a clear goal for each series, and each patch has a
>>>> unique purpose. Then wait for reviews, and iterate from here.
>>>
>>> I have learned much, I need more information or discussion about thow to
>>> avoid calling target_info() in class_init. You suggest me to use is_available
>>> but I still did not get it, because for multi-target binary, the is_available
>>> will not be called. so adding more things into is_available is
>>> useless(for my target).
>>> So I want a more clean explanation of how to do that. (I have already
>>> tried rename/duplicate
>>> the QOM name with is_available, too much changes and cumbersome)
>>>
>>
>> First step is to create distinct duplicated types for every QOM type
>> concerned (like two cpu max, one for arm, one for aarch64), and select
>> the right one with is_available.
> 
> I think this is easily implemented. So this is fine.
> 
>>
>> Once we have all types correctly duplicated, and using is_available
>> everywhere, we can replace the callback approach with a declarative
>> approach (.targets), and register types in distinct buckets.
> 
> Indeed, we can compute .targets from is_available, as we can create a
> constant mapping
> for those target_* is_available callbacks. So the prototype can leverage that.
> 
> 
> 
>> Then we can have an automatic naming convention "arch-type" which hits
>> this bucket, or "type" which must exist uniquely among all buckets.
> 
> 
> So you mean use "<target-name>-<TypeInfo::name>" as the QOM name when
> registering?

No, it would still be registered without the target prefix. Then, we
would automatically make an alias as target-type for each separate bucket.

> For example, most types are QEMU_ARCH_ALL, then they will be
> registered multiple times?
> Or for all type with QEMU_ARCH_ALL, will only be registered a single time, with
> narrow QEMU_ARCH_*, emulate <target-name>， then register all
> "<target-name>-<TypeInfo::name>"
> at type_register_internal?
>

For this, we can probably keep the type in the global table. I doubt
there are many machines/cpus concerned.
And all devices will be available for all targets, as discussed previously.

> 
>>
>> Yes it's a big change, and it can be done in parallel to current effort
>> to support multiple targets linked together, it's unrelated.
>>
>> Please note that the bucket idea is just an idea at this point, and I'm
>> not sure if this will be accepted. In all cases, the refactoring for
>> using is_available and have duplicated first is needed first, so lets
>> focus on that.
>>
>> Regards,
>> Pierrick
> 
> 
> 


