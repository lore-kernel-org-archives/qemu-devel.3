Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED5CC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94iC-0004tZ-Bg; Tue, 22 Sep 2026 13:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94hr-0004jY-56
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:55:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94ho-0000V1-Cb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:55:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjELW4110023
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lYKB7kldBuh06/ebhlifbJ1UmEWuJ3KfOtpbctKhmgU=; b=EJIluizkNefzwzeu
 WbyqbhBY24JOvZpFaI08NedACzlt55CIpEGrod2a3jG9f1aVJYuiVldQT556N8Lj
 kRhPOo4NLqTK21u7Ne722YHlEircfdYim6/qzxhExksLg/U/6Ncs7HFXXf1NfFpT
 D8w4FIAUm18ivb0kd86m40XuzKepvRA2NHJ+7So4PxAloOpPdahYUYxt5wVFXLYI
 sgSe6XGkm4/tGg6v7vYAuUVi07T1QANVyS/d3iVWNVifOU7Aq8RNkflMZhPrEqVR
 4ZnZi7BR7g+n2rc0p0/IyvCcVMaDJJigdUQtORB951CeKbW2OPxsDGzXb6qIpPv0
 Or47+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnta06y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:54:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so190719eec.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790099697; x=1790704497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYKB7kldBuh06/ebhlifbJ1UmEWuJ3KfOtpbctKhmgU=;
 b=URqksBZ+ghdqyhXnFPtxSy3W/Lip8Pwhu6qNPhgwYvn1i3JOxrc2qI+FasghjQPuOp
 pYu7Gk4LNXjtiULTzGmhvw2z5T4MJOFfEcQl4mfRGnh1+DMU/MUDqn65+HTuDT3U/QEj
 oyGIKugN5B8Ork6T3W9pU/5fosckZQMFb4okQ8pfDDucQOurPmQ2pJkUvYehR8Ss5CPk
 rgiO3w4x2OXXN0fT3lgbc5zaPWGPVipA86t146EVJ3HglCaVk0tf4So4kUv9jouqGtWF
 7x60nG+A/v18cD+q7Ldk1XxtOmbXzCcdUAuDLn8bEGlUCYgYX3Sfw3BNe75ngBXGze+N
 QDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790099697; x=1790704497;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYKB7kldBuh06/ebhlifbJ1UmEWuJ3KfOtpbctKhmgU=;
 b=IAbLsxeP43PQPAU7KyJiExX7AajNNzQp4TEIkKXGCDbZNC9335mmbSXSkuYUuzFW6y
 WMoCV6xSWMF7RVCr9mV44NVI6OJIrgryTrt3sLl6uhVVdYVIXpQFgDyp9s/tgINuj8ot
 8Ir7RinFwMRD0dSfL9266PTc+h30FH+IJHpWOBJRQ61c+HYvE8kQsnEYVil1A+XFw0PG
 VYkeUB8tuPvJxt7yY5L/0AJ4yJ0v+Wt8NuQ4psAqzSJ5qo+Sigkd4RItX9dDpTRU6KVv
 G6dqBHhazsR11NnRtvvBBJuTrqr3laoL5VXgHgtz9E1vMXcPF0+iKSxlYk8UheBqXUGC
 HuhQ==
X-Gm-Message-State: AFuF++l1zmD5SvShO3oA/Qfhi7KKdP7ZKJJ2ktXo5YDMVzZ/7hzOSvN0
 ALMHGn9oTStNQjckla14nkvqf1LK/Z+uvEDuwb7zT5iK4IKnwX3NhUErOtQR9mB60ih/dZ+T8Cu
 RwMpq3sAjiP98H5an6dpiAQ4Tf9zxnLIfCfyTzWZYFIwm4F8NOLXV08669g==
X-Gm-Gg: AYBFou1+tl2XxG6/znMCzTy4mUsOcuiUg0BkLbbW8FqMGqA/MPEZ9niJN1vbkHEUyEV
 jo3QSd8+7iTBEGupq3pEs4JICfpL38/cYPHhTK18orFSytWD+eL972F7PuHeP5y7GKPNNWbH/2W
 F9FKJrwRORkvdCl6L8ylhl2IGaEMPieK1hzAx5ZeowvMMkXl1D3KkqPrw2Z0kfyZxuxRgslgwPo
 TnUgP6zz9gwVa8pfTyLr3S4rGA2TRi1o/1KDsj0proKZQYPmy4/VWIdsSQHNd2xdfEGgEmTYp7V
 +DfATydxIXraeGDjcE6mOjA7X4TpqugLocX4ttUSGooBUeqqzcH6TWBAlmzppEIVaP3bebjZ6mT
 oX4897tr9QD6fwSneg2rGOHAYMPZN3GDhpT8FFK6mAl6v7RWckTf1zAQQMHHChWgDAQ0=
X-Received: by 2002:a05:693c:66db:20b0:33e:633c:7f70 with SMTP id
 5a478bee46e88-33e8e0b95c8mr44638eec.35.1790099697150; 
 Tue, 22 Sep 2026 10:54:57 -0700 (PDT)
X-Received: by 2002:a05:693c:66db:20b0:33e:633c:7f70 with SMTP id
 5a478bee46e88-33e8e0b95c8mr44608eec.35.1790099696234; 
 Tue, 22 Sep 2026 10:54:56 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e8dac9facsm58232eec.24.2026.09.22.10.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:54:55 -0700 (PDT)
Message-ID: <a0a300b4-a200-4d5d-a910-44dde2ab6f08@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:54:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
 <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
 <arKywfq6YHXxN8Ch@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arKywfq6YHXxN8Ch@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rIMJxQ-b3xF3HqXjn6709Yzoce8KuJxf
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab2c0f1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=tTRpbT3xe4sVb0fZGNIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2MiBTYWx0ZWRfX59MZ1k/9pKA1
 jh7rFR18W5lME1uC9epdCy19ioCFe+s0OBiDflIcbJQOS8lCjuVA5WLpvSHB41A6/oDLW21sQMK
 q09YRRiDwnenxl6GNMz9CkHhwDJmurJqF50Hn7JFctCdJejcpw2JqCCUKNf4Tr9wSIkU4w6pU9r
 s+pDIpkdiFFubnrZVGUiE3hDC8hShiN/HpiZQCrl030rIBZsTNmB47VusZWTSJ7nqLdVXQrlB5+
 z0pD+OKUhftWqwytX6P3SRMC5gGCiOlsI3PtReRlTWhe/EqxQOnhEJRbNh/v+tcY0p1NWFHuOqd
 LE211LxUequ3GO6EOysLG0xV9vASoLfC8Kne/fr70GxdZxrGpULT6LNDJgL/UJt1tVySmgSQumo
 0V7AFh9kBB4mq2p+s/H9njA8GXJv85uDgQvy5WsLD6WyV6nVtTtqn/SsVNSTG4o2CQlQnnGaxf+
 3yddmVvKpNx/KmzQyRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2MiBTYWx0ZWRfX9eKKTqjOXHiN
 ZoLmD6N2QiNYkx7FAd/cGffeeULrSeWkNxhOmFQXY04rwxMaL5lq5uyyihvDaa/CAjRh/pKlMoj
 XBLuHxDZadSCMiql/Si0RWWNvme1VQQ=
X-Proofpoint-GUID: rIMJxQ-b3xF3HqXjn6709Yzoce8KuJxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220262
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/22/2026 9:54 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
>> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
>>> latest update of libvirt-ci changed packages, but images were not
>>> refreshed.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/docker/dockerfiles/debian.docker     | 1 -
>>>  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>>>  2 files changed, 2 deletions(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>>> index 77869f71546..2d03ff03c8d 100644
>>> --- a/tests/docker/dockerfiles/debian.docker
>>> +++ b/tests/docker/dockerfiles/debian.docker
>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>                        libpcre2-dev \
>>>                        libpipewire-0.3-dev \
>>>                        libpixman-1-dev \
>>> -                      libpmem-dev \
>>>                        libpng-dev \
>>>                        libpulse-dev \
>>>                        librbd-dev \
>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>>> index bb8f4e4e53f..440699a5005 100644
>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>                        libpcre2-dev \
>>>                        libpipewire-0.3-dev \
>>>                        libpixman-1-dev \
>>> -                      libpmem-dev \
>>>                        libpng-dev \
>>>                        libpulse-dev \
>>>                        librbd-dev \
>>
>> Dropping this patch, as it's incorrect.
>> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
>> ubuntu2404, so not sure why it removes it here. Seems like a bug in
>> libvirt-ci itself.
> 
> Most likely you ran invoked lcitool from an aarch64 host OS, so it
> filtered out libpmem-dev which is only valid on x86_64 targets.
> The non-cross containers we have defined here are assumed to be
> for x86_64 targets.
> 
> We should change the tests/lcitool/refresh script in QEMU to pass
> '--host-arch x86_64' to lcitool, rather than defaulting to the
> developers' machine's arch.
>

This solved the problem, thanks. I'll add this patch in v2.

> With regards,
> Daniel


