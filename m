Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CECC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x946u-00014j-3z; Tue, 22 Sep 2026 13:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x946f-00014P-S7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:16:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x946c-0004zs-8V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:16:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjNHg318300
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 salmY3JQidfIabp3/MF/HPMplYbbC5RXGzbmAJdhGak=; b=ROi2w8rfdABOJjhu
 C5xbtveVlS1yiX56SGhucv/lCpqDRZt6dyXreya9bDadMStTKv5X+lFn++2FCIup
 8OMJnU/WH1Zzt1V2H/49+WEoHeSCpF0KLNRk/HTAm30HPVDt3P9btyneewCi/cZq
 bVAmwgazqHU1YxCijJ8z5gG4i8lZNsQP96BJa4RL35r3qHaSCulXO6bcIPGAVRQa
 Y9M7cImOIX/9lQRgNO/fOVhwaGXUbb+5jQceNOxT+2fhCdgNSTUpPmDeQsKvPPTj
 9/OyysTxU4UTWuUJx1hrjkTRAH8NjnyFJyBRcUzkcXP9BZgjyZs50ScQFr+J50OO
 aRov5Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqjbcx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:16:32 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438492fb40so49479c88.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790097391; x=1790702191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=salmY3JQidfIabp3/MF/HPMplYbbC5RXGzbmAJdhGak=;
 b=fobuch6YZeW3X4G8TTY2EiuRt2mtcLchl0toKtfjiSK9LkcNbMmzUPT8zgyxfeYVUJ
 aT7Dssy0aMlwwNCGXRUNctzBHLmz7Dv0i2TCk/ND86mn3INGrzCHjKCe6wlrmb7oocvw
 /4OxHXJrkAFXZvt+YEyC3enrykiC3HFVKAc88qCxK9U0Kk25oCTxTwPF3dwaHtpsPt2F
 DzHEKI+BKQiBLrwN1hZb5UOkiSdWwiBDqAoYRsHnwIjCN5mdV+SC0KyOpMaGvbMzZ6HD
 aTRvsNTZEg37aNHySd03j1LgNpaxlPMF5RvBpv4Hr/yNt4UejFmKyrf1qsHzH7Me0qW5
 nb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790097391; x=1790702191;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=salmY3JQidfIabp3/MF/HPMplYbbC5RXGzbmAJdhGak=;
 b=CZI7o2pjxLxUtoUL4Sf8seu5LnHLrvfB3/zMKidLQ2uuSdEGel4cymj/ecUrh3zcVY
 oYmqIe6D4h3+OGC13TgssiwIoHXVVz4k13V7wK+nsJIeUpp2kHvHjZhSYnNI474aTZSt
 jt/nkzfehLS98AqEfC1qYiw6L+8mJ3RTA79RzW4+z0+3UhP7NotxZkpoDLh0/O5QImYO
 GaxOm9H01ug/cG1pHUJCK9T+SsGV/DXoO/lXP8WrcCYTgGBdyq4f5KuTrRfkzeiBQouq
 Ysaxku7Lugdl9Yh/lAAO3jVgClX1VrXvqdFeYA/4KgQM3Y0T2bfmIbPMULj7oqr9OzpF
 QilA==
X-Gm-Message-State: AFuF++mjTMq++uUCV8ZSC+PLlvZ5DEFDesNnODoKKLFzwLBHPecD8AB5
 TUuhPhZUmUUCFN4UsGpE4REzt4fm3/U0rHx8eDyLtqgpi7JVAZQclmw2hb7jUkiSOV1gKHG8fIp
 FJKLOd25I3PG4IOFsa5omixT3agi9mUW8c7VZW9JpP0peZl3493aAyuAIkw==
X-Gm-Gg: AYBFou3TcsL40u412sRiuGe7IzxZV/AqlKtZoBfw34cBNKI//vbRjUWDQJEurB9eN4m
 ORW/min5I6Y8BU18g/EXkyNlKN9SKX0f8N3qRcU2MGtyXhwUciCvKdoObwEEK5pFomLTX1uSwCX
 7H/yVUbc148bvNSypprzlg829X0tFJhjDRyir8F4f9l68qncj8Gye2YpdxApSlX0i2Xo2F+TEzH
 vbs8rUof3jJTFVNXXl0Xow0XhUXSsr1xT3o8KGkoWHA1Ej+Bog9CN7/pUHIUrpMZtXMpMqUNa08
 S5K1Opgix5LfpqZi8Opn9aVIXCCGj3d6rGcA9G6BdcmVY9hatoFGaKjNQhR+KyjukPtV7OQisBa
 cTbOKjWJc10u4lw4oTmZzVjnB+244la46GjKGZ6plxlcCNEceGZFNG4CqiDEt3zor+vo=
X-Received: by 2002:a05:7022:f101:b0:144:f86c:e330 with SMTP id
 a92af1059eb24-144f90da036mr52305c88.3.1790097390877; 
 Tue, 22 Sep 2026 10:16:30 -0700 (PDT)
X-Received: by 2002:a05:7022:f101:b0:144:f86c:e330 with SMTP id
 a92af1059eb24-144f90da036mr52255c88.3.1790097389990; 
 Tue, 22 Sep 2026 10:16:29 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f8feaefdsm81274c88.7.2026.09.22.10.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:16:29 -0700 (PDT)
Message-ID: <039cb46b-90ba-40e6-bdb3-9812add2fc44@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:16:27 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MiBTYWx0ZWRfX9JdNQndzAPYw
 lLwTFFjXCHHVGjPwf32R8NhRWOaZRwLMR9ZhLF78/0Pmcs0PCHa9HiDduH0RH+PKIVOS1hiZpY5
 Kq6VPJkt3iFSK0ryC6e6BpaL7FQC6YSSNZmuG7nThYmIYznokHwOJ4dhMO6ni4yPK4dM8F/ViOk
 j+xX6wKPFJ+caHw8DTX2bIqEOjJPadxr23xxG3+zqkV2qECDWi/yk7Ax5Qu4rFa2gzYyvjSjbgT
 PTUaO/sDfie/+v/rqSOAxo2z6pmz/OURp9BPJr/DMwat2eHVq5vcsO462ncgrZmEca6koavQpNj
 aqC1MFTyoKllvPW914aWgq5Yq2D/INkNO1OwZatmWdrVwmS15l4hbTOQg+zEBulcdolCPq5hBC5
 fbnWIZiRI6yDUGtDwfaPGYc6Tz/ibAniVuF1NIwgom08lTHz+KmxPvhRsb3n0JlA3oxyQfzJ7Os
 AbtUkTfXyGvIwHDeaOQ==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2b7f0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tTRpbT3xe4sVb0fZGNIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: BGD-wePCfOcPRY_iIsa6UcGbc--Y3C4o
X-Proofpoint-GUID: BGD-wePCfOcPRY_iIsa6UcGbc--Y3C4o
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MiBTYWx0ZWRfX7jsSSEjF5oOT
 MCVnKKVfy08zSCXpCL16ikuDAc/dw2cd3fgn4CV8IxeetmIDJ2FahRn22rgkuhB2PSJtb232W/A
 G9mBikddnmf9/q/BSIvCqo9go35+ItY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220252
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

Thanks for the sharing the reason, I'll add this option.

Out of curiosity, what's the reason to differentiate generation based on
host arch?
Wouldn't that be better to be explicit if you want to generate an arch
specific Dockerfile (and use FROM docker.io/arch/... instead of
docker.io/library)?

> With regards,
> Daniel

Thanks,
Pierrick

