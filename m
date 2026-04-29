Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144ECCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAER-0001in-4B; Wed, 29 Apr 2026 15:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIAEO-0001i8-TC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIAEL-0000Jg-N3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TFKj2q3067056
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 19:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CwNZRyAYFDDz2eUgIuC5FOG334+JMRlR9zpHV3dUNDY=; b=X2jDtODejOTDFnTa
 XXW+PoA4zNvI7Q71kCaYsr/6E7unR/GGUIyshNdCOlfdNp7zkzcVvtMMy0MutH6F
 7jFF+CCjhuL8+fZmwxsLWPdn/4Yzw2Nr+VoYFM+5I0QKPtmEG71wOZDCbMnmupVp
 y4vliavAHksojunnTWeYL71wUMGLO9mw0+NO1ZRI6DwedDbnZ10flkMbzHItJq5/
 QjRJMzzznJNid61BknXJ/2nYtZEGRehsWRp5sJ8E3jKwDIEPSR3Fei01rQN7r5j8
 cqxA8gjF4Wru71ZaNc8osgX+VaaESTLePnopqn+bEKsnWk9iKg2GvVQienzA/Tn/
 gyYeSA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxc70a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 19:05:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so289599eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777489550; x=1778094350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwNZRyAYFDDz2eUgIuC5FOG334+JMRlR9zpHV3dUNDY=;
 b=ZsPpjooUTFN7iRSIyiDC2dtYXMpuNMov4n8IMZUdAXrz7QHyaLsCvohmEfH3cY18Ez
 uEfN5EtRqWilibGWfe6T+eLsf5oPaFGYYhIbb3n6iNayoj+SFC3AoGukbg4m4uHUbDbQ
 OzivzZz3JcNZtuHztcckim6WRkU424hmYODbxueqdmMAXvK63gY4dvOAl0FrYeuE8ZIK
 dL2Rz8SP6B4kdvibCsPNfygzk480O+73tF/1W159kLbJFWdVDcHeyLxOEWSblUcTfHlA
 Yy8nU2QOFNfeCrDUUeR5YWLd5DZ3p9Vd44Upcw5mjoOFyx0tlimbD2NNstt+mQub8HPB
 4Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777489550; x=1778094350;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CwNZRyAYFDDz2eUgIuC5FOG334+JMRlR9zpHV3dUNDY=;
 b=WmTRyCFrZorS0LuKPJBLYVV4iR1qp+l2Xe03BDOKw70SQnp36rZNf0o5YcJRGw3G+K
 qGvGsnP/l3A19IzthE0f7tbSqKrcyXLeq5i+GfY/2WcosonOTAtc3iuE2RG4X+tAHekJ
 IjKm/BpWrnJUyuBXUJR97X2GeMOM1+iZq3t3ID5CbMBlElkRF4Qri4AiLbIaLp4G2shX
 0Hl+VyP3GPyw6bBJQ+ADQQIg4SQMgEan/Q3qHpL9cma1u5vhdSM2veLEsCVlwI2DA/NH
 D8RxwHdGtnXmNXpT1+CKDUtV07po3LaNYkgOAXu4RlLXHfHX7cjOad51H8Bl4lrE/hzt
 skig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z/4EeNeQFHC1Hk02TTMdxWhbhoK9uPcuXvzZF1s/i//I5qtq2dzZCLhIT2fIRndPh+Gin6t5g5tAs@nongnu.org
X-Gm-Message-State: AOJu0YxPbrI13XYEAC8lhPNpBysdWsHeBqIRKnmQRVUnDhNanBZb3RSh
 x1bhWcz8CDCKIW1ZI4kLNYpBSUjYfUVPvj7ouLJJp1HT0MaZqYoSJR9/DwlrKPhxX7eRNKH6fF5
 dGCxbpEFDOXxl4iXWQgQZBCIcx/rsfa/2JW8tH+VaS/H97mzq3DkEczQfbQ==
X-Gm-Gg: AeBDievT7A4UnEUg36XeBd7Fs/C+/Rjf1+Z0MviNvLHHWzhNxfklsh95f+xWl7FpjyO
 vvYCWFsVcU+GhTLgGr5zs5pUxIh/WWBR3X9lQKB5Eqieo68gpTlA4af6YknpmyejwBko6xnDdUd
 z+K6P9m1a9JN8/wlxrL2NMa2RPZfPx2BO95aVUMqdwTP3xD5Ib7yFEw62Pzo8BJvWKUfgrkzUu+
 4AqgL/lvV5ZAJdLWyZGagRfEe9x5CKMxmRfHJkFppSZl14CX4Goi3dzd8dlNEDHre9v8VD7ysye
 k/+ypwlXj6tAUps/+io4W54dxQdPMFkjNqZ5bZ0ICAB573txaLM8acKFseLmG8n32tjwsodvtzP
 LEtWNXx/TzDHopCka4wAQCcr5/JeXwnAJAdWVqcqYT02Hj/4w5CxXfcOyoRd0iZyPAkZOIeznF8
 b7RsWKxjUxIbt9kvf3Dm10vwwm
X-Received: by 2002:a05:7300:8622:b0:2e2:a4ba:84ae with SMTP id
 5a478bee46e88-2ed198bf616mr2544577eec.25.1777489549601; 
 Wed, 29 Apr 2026 12:05:49 -0700 (PDT)
X-Received: by 2002:a05:7300:8622:b0:2e2:a4ba:84ae with SMTP id
 5a478bee46e88-2ed198bf616mr2544513eec.25.1777489548910; 
 Wed, 29 Apr 2026 12:05:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c070beesm3442349eec.14.2026.04.29.12.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 12:05:48 -0700 (PDT)
Message-ID: <18567655-8712-459c-8d13-dc656ed4405b@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:05:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call 28/4/2026 agenda items?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <874il05rwo.fsf@draig.linaro.org>
 <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
 <e341ea82-5389-4e13-9fb5-a00c3383da85@oss.qualcomm.com>
 <afIZYIgaAZiQ6xQu@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afIZYIgaAZiQ6xQu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _R-fl78zTGItdVLDgxuOJONTTdFT235i
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f2568e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=nXA5WNwiAAAA:8 a=IvsrRCchTg0M033JI4YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=fGr-7aqQv4RST94IA8XU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4OSBTYWx0ZWRfX5X1urjMTC+p4
 CqXuyPOF8zBE4NpvBgYaBElZ5SUDI8T8HMRp2wl/YNp/7DUcCeC2KaWmfbcv9i1VWMt0dMZ9V5x
 YDFLhjnrebXOz3ASgFtH0wp9zPyusHtZ287/VdZ6+DgkNLatd3Wuw+I1ez40NZc88z00HDk1Vi0
 OeFoJrUIMryhcttEQsU+SB9gAVJBQqn1knRUxITExpISv0prYf1q4x1iH6FU+s8u496snkz1116
 nGGpMYSSnvNZawFJMuNfgVrSEqoHGksJl7nWTanjJvUTQLojzZzm3A1oT4peHw44TUvrzwwthu8
 zJeO7rLMYrO7kgZ3OJmUjTJfX8lxlZhk4C5tBW4m2xjwO+P0bwfEkGkh/ihBti/o4oZbL/AKDWt
 zrXQGqmhwylBKqlKLStP9y6knjSASMU6cpMBhqZbwYkNPJmmfnplra3jrkYqWM/zpPiVMXWIhwf
 zfpKr9ZCBqrJfNGpaDQ==
X-Proofpoint-ORIG-GUID: _R-fl78zTGItdVLDgxuOJONTTdFT235i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290189
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

On 4/29/2026 7:44 AM, Daniel P. Berrangé wrote:
> On Fri, Apr 24, 2026 at 12:31:06PM -0700, Pierrick Bouvier wrote:
>> On 4/24/2026 8:40 AM, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 24/4/26 16:55, Alex Bennée wrote:
>>>
>>>> The KVM/QEMU community call is at:
>>>>
>>>> https://meet.jit.si/kvmcallmeeting
>>>> @
>>>> 28/04/2026 14:00 UTC
>>>>
>>>> Are there any agenda items for the sync-up?
>>>
>>> I'd like to have a discussion with Stefan and Pierrick about the
>>> possible improvements that can be done on our CI system, and
>>> review our git-forge use in general.
>>>
>>
>> That's a nice topic I would be happy to talk about with all of you.
>>
>>> Pierrick: Stefan is available this Tuesday, are you?
>>>
>>
>> It would be 6am on my side, which is too early sorry.
>>
>> However, I would be very happy to talk about it in private with Stefan and
>> you, and other people interested in this specific topic.
>>
>> I just feel it will be a conversation that may derail very easily with many
>> people participating, and it would be better to restrict it to people very
>> enthusiastic about it first.
>>
>> Once we have a concrete plan, we can share it more widely and deal with
>> critics and see what can really be done.
> 
> Can we please keep the discussions in public. Yes, sometimes the threads
> can derail, but that's just a characteristic of our open collaboration
> process. Switching to private design and then presenting a solution is
> not the way to work in the community.
>

Sorry for the misunderstanding. The goal was not to do anything in
"secret" among a chosen group of people, but to restrict it to people
who are enthusiastic about this change. Anyone (including you :)) who
wants to join in early conversations is welcome. See it as working group
in the wider community.

This way, we can focus on proper benefits/downsides of the approach,
instead of having to manage fear of change. It's just a different
audience to approach this topic.

As well, the format, an oral conversation, is not a good match for a
subject that might derail easily. It would work better with a written
conversation, but we need a first email with content to start this.

That's why we need a first concrete "plan"/"proposal", to get something
to start from. It's not supposed to be a final solution, quite the
opposite actually.

> With regards,
> Daniel
> 

Regards,
Pierrick

