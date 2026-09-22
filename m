Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2062FC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94V3-0008K4-6n; Tue, 22 Sep 2026 13:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94V1-0008JU-RH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:41:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94Uy-0007eU-SZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:41:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEijJQ3924020
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 za+MH6QX+0YKV2+GqecLO+qfadXwyT4+txF/hD0r0/M=; b=eo3lnFJDSRZ2oDuS
 6bqDnFR3YILCwVWM6pmcQr1R7pQXsBGBgHk+JbeD5SYGTOsUrjB7hn8ie7bU/VJE
 AYjVv1mkFlRGcWe15cGvp6GEEvHYuFMADkjkCsHajKWH0fQ623D4kkQ7Sv3ofGuf
 mjcz93T4PzkUIQ5/ioZamWPv5x6i+cRCdjc5Q3gb05+EvPqWSOcbfB+PkFUcjzma
 OyYxTs31Z034A1qRkkn2tm4ANWaGYk0t5eTkhocHk5mkzlOrcjT6bqlVwDVdypDg
 mwsyRxWRvKExDLPBm4j1QLKG82q/pppkfuRNkgNplHCez8+P/Wh4TbWmxpXAfBd5
 Og22Mg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec11p3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:41:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-331b2ec616fso168246eec.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790098902; x=1790703702; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=za+MH6QX+0YKV2+GqecLO+qfadXwyT4+txF/hD0r0/M=;
 b=fgtdWrjM8qL12qZsqlRbgYRi5v6gyeErNR0TRuW3KyJqxBTb31eRhRiGxIlMI8Pl5x
 4tarf3go6stJvGVaqZNoZFSpPpP5Bh3FYKE7LQp3bFpkAKcmOAbAG9UjjmV+OXzyJiQq
 nUZPqu89/E99daI8TjIujeA4CFH2X4fH7b+H5Nt6eHiIOgv42IFaxri3Y9xYrwpFxVEQ
 KFY7KuN1BZXChwHCndizRYSjIJqzVaPKgUOA3jjGyz3Vb53BoALgjThpoXAtEHawGLNp
 xykeU5Oxx+kQZHRl5Zef0BbrlsNYBv9tyDEny4gw0Z/KO0U9MoUxKapDM2um/NEtXk9C
 j4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098902; x=1790703702;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=za+MH6QX+0YKV2+GqecLO+qfadXwyT4+txF/hD0r0/M=;
 b=ebXRM0vINnXDJSGjHe01zBaNZwdxORlXoq6LPdlS7rZE5wtPYx+TpulFeRVWP3aQB7
 iEgtyvsjBiR1Iz2yQCIeMpHSW2y/brAPRB3iPQSttwksFwRoq2Sy5Ypn540EVzk0ntiO
 B4ouXA3SNCzj0AMyU8ZtS6wZkm9/JzFbtit52Lwhe4dayk2xLUpY4u5+AkMB8lyoF+lZ
 e7gr3A7wo2+f8ksOr2PkF69nhAmt7Lwf5ZW9oW6nyNYh017jMKZc+WjTzhAjW236uBo2
 hc3U0QI/Aec3+5y9OxXxyaqrZg0Dc1+l49yLbASAtXzaLJ8EauEFIKHgtFsc8bvu0H2+
 UdWA==
X-Gm-Message-State: AFuF++ncLvGxEWeSC5CnKe2ED06kD49l/VnnFfETTxwJ82sP7va75Suz
 ag+dFxfse7unaAI4/GDRDnYRgO/t5QpKcWb1R7AVBIAGaNyoNV9LuvIrHQddaVJ4D68pz+uCZMV
 CZD5e6OxAmqrKhvBacUmP8CCjyQ5Gz79rae79QFqqksxd8DuZVICvTaK4cQ==
X-Gm-Gg: AYBFou3fBmkcK9Bmr8Bvd7+ZSpKUahn96jTV+3fthOFdMtBhtpWV31vVUS8D7mo/J7K
 GBDWt6G7NDlrJ7IsmoLzxVGXY0ZEV7DU8Sk3MweURaymUbuzsiQPapduY+2UWfCaU0LQ3PH3CKw
 22yntfw719YQBrBCCrGPSv0OLPEvvktrDiTl/3edsLz/tWHGNJ27esVckJfSzQR4MO+pWP6/o6Z
 0b0PLll83ZD4qyRVGe+4bWqmf5xtdDvs0RRPd4v1QlkeV12ukWT2goLOrzqxWKbPAGQKHpWwYpu
 oEWzV5fB4e0SUlyZ3Q/fXZKXklnxmuio5R0qpX1R8NJM3sgltpg1MLeg3eERfxIanHLiwg/oqkM
 PvzmoKRysg0ooLvyOhw/N/oIHW7oMYuU+3zLjzfJTyJmEuycHGX8ZoNK50NvhuXcHLQw=
X-Received: by 2002:a05:7300:4715:b0:33b:bfb7:31cc with SMTP id
 5a478bee46e88-33e8c53b8a7mr38801eec.16.1790098901811; 
 Tue, 22 Sep 2026 10:41:41 -0700 (PDT)
X-Received: by 2002:a05:7300:4715:b0:33b:bfb7:31cc with SMTP id
 5a478bee46e88-33e8c53b8a7mr38766eec.16.1790098901160; 
 Tue, 22 Sep 2026 10:41:41 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e8dac9facsm16448eec.24.2026.09.22.10.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:41:40 -0700 (PDT)
Message-ID: <f2df6883-ee78-48b1-bd03-9b7d41ac2b60@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:41:38 -0700
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
 <039cb46b-90ba-40e6-bdb3-9812add2fc44@oss.qualcomm.com>
 <arK8UOJtGSxYpNtf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arK8UOJtGSxYpNtf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1OSBTYWx0ZWRfX89qQqs97cEDz
 JjMmrN/Yx6r6Jk1BUX30HaEa58FZ8as5x7idPsOGBLGYNk31JDjvQF406nERgdOk65Deb84VhIS
 13J9krPzkoYcXpHRvKcIJbxbGcbOkK/oe7C5Cb257dtNge2Im5wn/bxjoouzkrdxzP33a1jySst
 I4a+DwlPubUMUdLqdrfNIb0qBgISjs1sDFkGDtkwDGRNeiKg28YTE5TGRR+lQtqTra3gs+xJtWr
 zszp1seFbZVceACRInQS82+111+dw9DYmIj/HTtOrFCWPfuDKcCF6OqMYQ/d7y7N+zD5x7eQE4q
 pKVzZ0rPZ4n9rjOL+gI1SnYOaKAPxKiVCP3QP2nNSB4Tds6sftvCVo5ZHmnoLpxc4mgOWbiT5f3
 MJnmuJdbvMyejS5cfvjs1ZaipvR8XfANPpRF6/ppC7T5UuMmQDTXET/+Oo5YFbYHIjDNHnL/hEb
 VYA5Lhfjk3W+mkoGY+Q==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab2bdd6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=hbbba_UpsKfx4IAJBuAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: U_Maglnd2xDP74_e8H04Y3jnsYStWTjB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1OSBTYWx0ZWRfX+EJahGu2ZkTR
 s338wwPz5R8BABcARzfjsx33drywmFHuwqB9RqNgijOIca0b0/FfnRZ8iQauXrc5vjBlyKmAweN
 LAE/GGCoFR7KhHYRITJr7JZ63k3JkWg=
X-Proofpoint-ORIG-GUID: U_Maglnd2xDP74_e8H04Y3jnsYStWTjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220259
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

On 9/22/2026 10:35 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 10:16:27AM -0700, Pierrick Bouvier wrote:
>> On 9/22/2026 9:54 AM, Daniel P. Berrangé wrote:
>>> On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
>>>> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
>>>>> latest update of libvirt-ci changed packages, but images were not
>>>>> refreshed.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>  tests/docker/dockerfiles/debian.docker     | 1 -
>>>>>  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>>>>>  2 files changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>>>>> index 77869f71546..2d03ff03c8d 100644
>>>>> --- a/tests/docker/dockerfiles/debian.docker
>>>>> +++ b/tests/docker/dockerfiles/debian.docker
>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>                        libpcre2-dev \
>>>>>                        libpipewire-0.3-dev \
>>>>>                        libpixman-1-dev \
>>>>> -                      libpmem-dev \
>>>>>                        libpng-dev \
>>>>>                        libpulse-dev \
>>>>>                        librbd-dev \
>>>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>> index bb8f4e4e53f..440699a5005 100644
>>>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>>>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>                        libpcre2-dev \
>>>>>                        libpipewire-0.3-dev \
>>>>>                        libpixman-1-dev \
>>>>> -                      libpmem-dev \
>>>>>                        libpng-dev \
>>>>>                        libpulse-dev \
>>>>>                        librbd-dev \
>>>>
>>>> Dropping this patch, as it's incorrect.
>>>> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
>>>> ubuntu2404, so not sure why it removes it here. Seems like a bug in
>>>> libvirt-ci itself.
>>>
>>> Most likely you ran invoked lcitool from an aarch64 host OS, so it
>>> filtered out libpmem-dev which is only valid on x86_64 targets.
>>> The non-cross containers we have defined here are assumed to be
>>> for x86_64 targets.
>>>
>>> We should change the tests/lcitool/refresh script in QEMU to pass
>>> '--host-arch x86_64' to lcitool, rather than defaulting to the
>>> developers' machine's arch.
>>>
>>
>> Thanks for the sharing the reason, I'll add this option.
>>
>> Out of curiosity, what's the reason to differentiate generation based on
>> host arch?
>> Wouldn't that be better to be explicit if you want to generate an arch
>> specific Dockerfile (and use FROM docker.io/arch/... instead of
>> docker.io/library)?
> 
> I'm not familiar with docker.io/arch/ but this all just grew up
> organically over time, and since most usage was x86_64 host based
> there  was not much need to think about other scenarios.
>

Basically, it's (official) docker images per arch, following docker
platform naming:
- docker.io/amd64
- docker.io/aarch64

https://github.com/docker-library/official-images#architectures-other-than-amd64

Advantage is that image are provided for a specific platform, which
avoid some of the issue multi plaform images have.

For instance, on aarch64 host:
$ podman run --platform linux/amd64 docker.io/library/debian:latest true
$ podman run docker.io/library/debian:latest true
WARNING: image platform (linux/amd64) does not match the expected
platform (linux/arm64)
# podman/docker now select the amd64 version by default, which can break
build of other containers. It's a design issue with docker cli IMHO.

> If we want the tests/docker/dockerfiles to be portable to non-x86
> hosts, then we'd need to either have many dockerfiles there for
> each arch, or drop packages that are arch specific from the
> install list.
>

I'll add the --host-arch x86_64 option to lcitool as recommended, which
should be enough for our need.

> With regards,
> Daniel

Regards,
Pierrick

