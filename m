Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9347CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIlwW-0005xl-An; Mon, 19 Oct 2026 07:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xIlwV-0005xW-2h
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:54:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xIlwT-0002cl-6I
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:54:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Osm33305548
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 seflFJn6QYQmQe1vaD2wNIDBThztECEZBMdyfT8OQAQ=; b=Ds2CG1vTuWEFF8qz
 mlFS3gh6YHo8sU2wY3r1HM2KdoczR0RSPUBSdLnzGQWzbtpzsBUPXw97a2Ti1qzW
 aydJ/JstbZwfIW4EYxWcIgMG4wI3XR45wfiloOvRDVNc1qGoJHdppTMS1XU+bG20
 emc7ekmhnW3ukV45qr+DZ3UByBWyE2vqRE/JbAfZmG+aSFoADYQUk/wZEXz7LlTL
 ut0CIqxdeHT+SvHhMkwEkiH0+9hg6gGNH89ZLx4aj0bf15OQGiCfe+t40QeWxq0N
 9uATAZmX2Pxuof9gmcZ/BTXPoEFo2MC+xUs6IaiajHvr1artAJa0M3Hr0afzgFQv
 B251Iw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47gwm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:54:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b92acedd9so73765706d6.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410850; x=1793015650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=seflFJn6QYQmQe1vaD2wNIDBThztECEZBMdyfT8OQAQ=;
 b=I5XQh1AyExL/A0W/vvXrgepSoviJOBbr/y7ZAwyyaDTcUx2hb2KdgqdfOMsabB2IKs
 q2rFDPQQTvdeZ0AaFlbvokefiio4T8jj3lCxDs7fOzkS/LRuU9olOgfjL/KhZ57GtAEU
 nKO+2Cum7fI1PAuQlQnlupw1A1FVX4N09OPKYiKk7aB3mRMeTmVVqfTMfhOfKh9eJcq/
 dkhP1U9R1tv4vO99IaNsm1iMB3vP8a8oiqrCHnbIHYGvs2tGxtiVsdePhkC9Oy/maNYt
 WhB4ke0sgKoJytFzMujHnATH3h1PweaTNcCMXcSPMwKk3fFy9zYfXpkls3+NBj4b0vvW
 1Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410850; x=1793015650;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=seflFJn6QYQmQe1vaD2wNIDBThztECEZBMdyfT8OQAQ=;
 b=LV9XDrWbYzJWCNSfjDUK0TemJhQ6EXBZShczl6gkVa23P4YO8+RIBqgEjrAZbFxxUX
 C+hjhoN+FAJoJVwX8XEilQW7p4sdyRSlXHXSGPz1Q/JiMo+85HnG4G+8N41fE59Ltlv0
 ZnNrSpqprnOVrRO5gOUPf2KJWNfm9IaLYhShIMAPkAGH5RqDRvsHeo2u9a7OAEf31G/f
 6Fb+x4tihrfzOuN2okmmfwTDqSxTfymc5s10ImcSNPWt371MsoQwLWedgxxCMAo2Xxy5
 cbE+Beo3IhiglkbjbD4Iu8gkbJFHCFGEq2zG+wNZRJAW/aT6Pk5OkqOVpR1VVuJKRnJ8
 cFaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBye0dgWQ9H84I4htg4ntCcxKCXjlQNptULN7EQGuOez7Y3f/6nW6Q62iul058pzwvgK8ZJr/mE9Mrqc@nongnu.org
X-Gm-Message-State: AFq9FYL8+VK0hGL2q4VG3O6R1LCFYfIvCTHDcBX7IKOMw1y4xxJNxpEQ
 b55ZwjmSN7mJfiCrShjDY04jtRq6DUihBlaxeCpIGY/hrGlLymKqXpN59Mda1YkFSV1HuI5w+SL
 4DYImWqbTXc+SKOz0DXYpK2aYoI5avVo/ebv7KfTPCEODCQ7a0UeN8XVdug==
X-Gm-Gg: AYBFou1C5mZwexGkEUZVUBmHwJYPS3iSkGO6xYZ7Xcn2yh+csPRKBPqavlr6HTQz3kt
 nlk8RmrfSD8iooTJD7BiEvqpARsKdEANUF/sNPgcfrQ/oVVetltNBqUrBFhVNTHWI91e2JYu8Ux
 D01Ex25Daz3wu8g9O04IIN07B0cGDHraQ/aselHU4UrPMcVz8Rht8cMhSiosXUD5570YXfmj3sC
 biBmyCg39g5iVf9xzMyUZpSuMQnvtXj4ef1jRZQXrNac9/QnouexzYottWKfJ11ekl4tsWv3YDz
 eAYQYC2NgYofMmSIeVbNt8yu/W078qF73RRvTqJ+7aPDCF9WnXk/ZKxSyfe1LeaaKIDSp+bcxmt
 gkAbmFl1Pm2AdBjXWJD2TS7wLXKmOUO83OVSGr/YRwiRAput4aX5vftFC+iSUxCMrRrcMc905
X-Received: by 2002:ad4:5dce:0:b0:91b:5d39:e142 with SMTP id
 6a1803df08f44-91bdf631e9fmr125353516d6.55.1792410849726; 
 Mon, 19 Oct 2026 04:54:09 -0700 (PDT)
X-Received: by 2002:ad4:5dce:0:b0:91b:5d39:e142 with SMTP id
 6a1803df08f44-91bdf631e9fmr125353056d6.55.1792410849099; 
 Mon, 19 Oct 2026 04:54:09 -0700 (PDT)
Received: from [192.168.68.103] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcbae1e06sm96564086d6.27.2026.10.19.04.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 04:54:08 -0700 (PDT)
Message-ID: <943c16d9-1880-44a6-9982-4fac725cf982@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:54:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261018230741.6560-1-philmd@oss.qualcomm.com>
 <8360ad12-6dab-44e6-a930-17ed8e92a09b@oss.qualcomm.com>
 <CAFEAcA8thrNkzvR_UVnfYUjaSNiaax6Xupw=DsBapHDyPbpdEg@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8thrNkzvR_UVnfYUjaSNiaax6Xupw=DsBapHDyPbpdEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RbWkmBVsKDX1Lxyzb_P6bb7CMazSoQ-Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NyBTYWx0ZWRfX2Ra1sqO6Fz1r
 0YDd48GlfXZO6gLQm3g+oPh8fbuor9Jep+zp+p71Br0a2sXJdVI5iIYrprldWFR3pMZNxuLPis0
 qSoLB0PuVXgeuC6kOccdbgdb6lWJO/xNe10Sch1Qh7XdPGqoa10oVLqOkWz/Db2QNgPOP8JXrNz
 HEq+Bp4h/YSoD7Rf4zWmkdK4LXupkugoZyKOu8ShDROhs4eCPFTZr31h2Z07WCk6psOVmb+zru7
 4cgIm61Qj1jmUwGPWKlOtFcn3WhZZk1oditfG+9XGeALtk2po3ilFhNFYdVUgZJxFKYt63J/K+u
 8VGIX0sXG3qrXQcvmq+sgM0jb/WhOmQ2En8foAMMIiu84Tf7vnsUP4Dg1zgxToJV/hK0bwUqL+Z
 f3I+6d5pGNyelwnUfk4jP7dt86cxFjuMePSWUZq+pJ0VCrwF9EjqPijgSM5NqVOETwfAZJLR6Vd
 bwXyCVt9xSdpWJeriNQ==
X-Proofpoint-GUID: RbWkmBVsKDX1Lxyzb_P6bb7CMazSoQ-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NyBTYWx0ZWRfX7ikMXzDqVesN
 yMVxNd8T43wE14wrCMruIWYtt18uXyytrz3YWpJ3qxdPeTM+ToaycwF/du4w4KsHL9MPPjTBZ/7
 tkxKDjMlzwAkf8SLe43WoBtO8A5VG1U=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad604e2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=r6Uv-rxiSxc7U83AazAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/19/2026 6:48 AM, Peter Maydell wrote:
> On Mon, 19 Oct 2026 at 10:42, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 10/18/2026 8:07 PM, Philippe Mathieu-Daudé wrote:
>>> RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
>>> for the release v10.1.0. Remove the stale comment.
>>
>> I wasn't aware that we need to remove stuff from deprecated.rst after
>> awhile.  Thanks for taking care of it!
> 
> We are supposed to move the section from deprecated.rst to
> removed.rst (adjusting it as necessary) when the feature moves
> from "deprecated" to "actually removed". We didn't do that in
> 455c0fa9eef, so we should do that here, rather than just deleting
> the section.

Got it.  Thanks for clarifying!

Phil, can you please re-send the patch moving the text to remove.rst?


Thanks,
Daniel


> 
>>>    docs/about/deprecated.rst | 24 ------------------------
>>>    1 file changed, 24 deletions(-)
> 
> Alistair, could you unqueue this, please, as it doesn't update
> removed.rst ?
> 
> thanks
> -- PMM


