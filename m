Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2F2C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlA1h-00062S-9L; Sat, 18 Jul 2026 14:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlA1c-00061z-DJ
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 14:44:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlA1Y-0004FR-IG
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 14:44:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGOUSK1262631
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 18:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xIdPuM0P5ma83j86pkbjvx79vGVEOO7YSt2kte/xptg=; b=YIi4EdHdLT03NHhs
 iGEGlV81ZzhqIe1psqc+iDXkDh8FLAv0OJUnd6mt1N6UhZWORl9hOqiMBOmc7NjK
 6pvcjE3UA92NAQKkQNgiqLQA+0rmHQJTvOlyYtxSxwLCiNRZ6kbuNeODceDa4OmV
 Z5y11hDOx8zDwkCRVLQS4NJSGKpcjtfbokAMS574PFLhjop+L7x8ZcyNvHPHkZ5S
 drLVHHZKnqbZ09AwCE6VpkYw+aQWCYCnRaFEi1SnFCq784OM/fD+eGQse0A37gI2
 xvO8PW2+fjbFgpMtcMRP+tfmkHG4eL8iyWKqQrZ/ZfWw/h9z/v9sVyb4/DjoLxCX
 rqjk+A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2c69cc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 18:44:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so4340015a12.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784400269; x=1785005069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xIdPuM0P5ma83j86pkbjvx79vGVEOO7YSt2kte/xptg=;
 b=eVWUTHf4bqUwwTDZEkqgUnKen9Fd58GNNx/rAbdcy5f/oHgWu//0HvX9k5TBP7u0Vc
 wloB8ec/uKXHOe0BhuGTqUGwovEVQWX1ahfnzJmASqhA5z54/1syby8KDAH9b/bR/yQ4
 JG+WpnsoKaqZIt43uETHh4Re6tpWYh1Q5SY+5FuhR+Ad6Xkf10hKMPmLfiMyGOdA3Lqg
 oEBY92EJPwsgjKvMhXRUbf6Hap5QoVKB3x/gHwWyjvOxQS5bhii+egqD5pvf5aRQpvFf
 oS2z44AwNq3Vs6fTtLUrRlEnHC6Hca1FC2CEez89hx2D443jmspYePMKGggCpNXVJEdK
 J9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784400269; x=1785005069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xIdPuM0P5ma83j86pkbjvx79vGVEOO7YSt2kte/xptg=;
 b=jRwxOOowK2+UgfoYK7adORjWBvup0mBg1hRDthehbC6OFE+exiS6N/Q5g4Qw6ShvK8
 tesz+SpS6+4vSQkhMI9vRC3HSlJcqRG3GlizONVfxrRXpQxmpzTB8Gn8E8qv9ZZCr5Dk
 DrPZW/vHGEDhoqAv2MDnqGOEBBmb/cBOBE66QkhJeW5r0bJoZdWeq2on3T9pGBxKi1LG
 /ssgaDqCDrO83RoyZVeb7ux9yxZ//bx+CEQ1TO8gUgcdmmj4Zw5YUQtmBrS06q8FUp/F
 KdEpV+QIDrnYeMnbpiqAjdCFo0VLh8U+icmVuyx+l0VsZcRjQ/NJdvGjBfKhykiALRsL
 5DsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RquYS9JfaAB4loBBEQCIi6PVMxOnbQZj9XZsddyfDJgfqqKdYLx9UfgRJkKmks0GBfdo7h+UpTvMHyh@nongnu.org
X-Gm-Message-State: AOJu0Yy9VKRVE5kTexsADD7xjPQoLL+x0ohAwgqibTEy1txOXjoibJ8F
 nMD/nN+HZw5/J8/r+h1CkhUW5eA+fiCWySXaDGt86VojQuAapBc40UqZl06e/8rHJJJdxEyCdIq
 GWxrJ17Yawm3bA1ZFLXmWeYWlE7stRnMoSEXCb1PDYrmTt0dFDACogglWiw==
X-Gm-Gg: AfdE7cklJJjgKMowvfyt+kCxvRFvb7MmUyP6bmbwsljDFmMpMxmbZQ5eR2udA1/uI8w
 t9ZXccfsAEbKc1mOMN6IR3FDiAwnZF0R0iRTW+p2efPc1uuZQNBvk0DAhGoKE/qujdye+61NTh6
 tdiVy+yM5035LS8NaVfhLDttOvc8qj3lKWo2UXN3waAmWR8cZ98eMHLkewiXNy+HP5eccYbDrGf
 cIRdB9nP4KZAWkCqW89GL8S6adB0eFxyM2KLjE3IJTiLpw3C/3spFSv2BqSwrObemVo2z5nt4Wu
 p1Ji33B2mEPhhqwuAhJVtEkDPBSw3ln5ZaEIyRVyt1ORttCpTQV5fUo8wm6y6KBON4SGcUDnIhu
 ziIRPYq6RhRuru+7s37N86/E/a31i21fziNXgAgZwS183REnsSAFMZjix6SespZh+5X6V
X-Received: by 2002:a17:90b:2f0f:b0:387:e0db:bc31 with SMTP id
 98e67ed59e1d1-38e4b56ed5fmr8140681a91.39.1784400269109; 
 Sat, 18 Jul 2026 11:44:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0f:b0:387:e0db:bc31 with SMTP id
 98e67ed59e1d1-38e4b56ed5fmr8140657a91.39.1784400268637; 
 Sat, 18 Jul 2026 11:44:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm36819510eec.21.2026.07.18.11.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 11:44:27 -0700 (PDT)
Message-ID: <e43b316e-e8ac-42ea-afec-c56d2f030819@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 11:44:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
 <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
 <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
 <cfa19c77-6783-0870-a509-691f0539ff2a@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cfa19c77-6783-0870-a509-691f0539ff2a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iSDel4TXFx--_ZePqQPeQ9pzAiu4Mp28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE5NiBTYWx0ZWRfXzV9zs3F56iGj
 ifbru9VwLWUNTGdrF0cfgwpsaAaYFKLREopnff3XzJLt5ClYufcxyPAx+urui38KLQuP0TX2Cna
 joGjoD9tynH6+jveJpo12tGCruhIUqGnrd+EZmvEKwApdsNmAK6x+O2oxER2OUn5UZ2Y9qyZDPd
 UyaYikTbDtsuwKnozeK2i+QEgvHDGLQou7zl1gw2/zW2t/y39zfxpxrcUhqhRoArhnitZNAKY4H
 H+hhci2AuRhAGebgQzHiqIRBF3v67ETGGBdEfgKZScF3V0KyGa7gHPl74xJR0N7WprQJ8OTnO62
 01rAjZI6XeTugAEIS5BiPtMQkI+28sbpYyhyHCtiuOUu5TvWYJKiQ0Wtu2ZnQlb+d36mH/5/3/D
 LGdIK82VP70VNqXSGIgUjpKci+Bt4qRrLFVIhIauLXC9f44atFMtm/cX6cNbAa4NqKXL/Vkb3uA
 VOkvwNw7Q+D6pknVxwQ==
X-Proofpoint-ORIG-GUID: iSDel4TXFx--_ZePqQPeQ9pzAiu4Mp28
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE5NiBTYWx0ZWRfX1GQKZ/+0L3AX
 cE0StnApIdmzhNi6AagLEMajk3H3cRYY25dF98qo19nx9Bcoe1FuIBFXYum6gHj7c6sgbmGw6OG
 Yc8tO7iSL14NINppQF9EUv9FLNp7XVo=
X-Authority-Analysis: v=2.4 cv=CJQamxrD c=1 sm=1 tr=0 ts=6a5bc98e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=g26msxm2AAAA:8 a=fwYiEHGAlrO_WJUAzG8A:9 a=lqcHg5cX4UMA:10
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22
 a=bFCP_H2QrGi7Okbo017w:22 a=GGU-N_oZwHsPb1Xv_0el:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180196
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/18/2026 4:51 AM, BALATON Zoltan wrote:
> On Sat, 18 Jul 2026, Cédric Le Goater wrote:
>> On 7/18/26 06:52, Pierrick Bouvier wrote:
>>> On 7/17/2026 9:14 PM, Michael Tokarev wrote:
>>>> On 7/17/26 22:40, Pierrick Bouvier wrote:
>>>>
>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>>>>> ref_type=heads#L5
>>>>>
>>>>> ```
>>>>> config VFIO
>>>>>       bool
>>>>>       depends on LINUX
>>>>> ```
>>>>>
>>>>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>>>>> At least sparc64 to fix the current issue.
>>>>
>>>> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
>>>> way we can do --disable-kvm and it will work.
>>>>
>>>
>>> I think it's a safe choice, but not sure if we are supposed to be able
>>> to use the exotic combination of vfio with tcg also. Maybe it doesn't
>>> make any sense technically though, I don't know the arcane of vfio.
>>
>> VFIO works in some heterogeneous configurations, aarch64 TCG running
>> on an x86 host for instance. The opposite doesn't. ppc64 TCG on an x86
>> used to work. The limitations primarily stem from architectural
>> differences in the host/guest memory mode, CPU/IOMMU address spaces,
>> assumptions, etc.
>>
>>> @Cédric, Any idea of which matrix of host/target is supposed to be
>>> supported?
>>
>> Overall, heterogeneous TCG configurations happen to work by accident.
>> I would not consider them supported.
> 
> VFIO (vfio-pci) works with PPC TCG and is used for passing through cards
> including GPU to emulated AmigaNG machines (maybe also mac99). Please do
> not break that. There are some quirks mostly with GPUs, see https://
> qmiga.codeberg.page/qemu_vfio.html but it works and used by some people.
>

👍

In this case, and we want to ensure we don't break any existing workflow
we might now be aware of, a safe choice could be to restrict VFIO to all
hosts that supports KVM. This is different from CONFIG_KVM, which is
only enabled for new hosts.

@Michael: You'll need to detect kvm hosts (see meson.build for
kvm_targets), add a host config CONFIG_KVM_HOST, and use that for
CONFIG_VFIO definition. This should restrict VFIO to host providing KVM,
without limiting which target is ran.

> Regards,
> BALATON Zoltan

Regards,
Pierrick

