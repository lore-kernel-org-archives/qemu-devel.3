Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52B0C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94aO-00026N-6H; Tue, 22 Sep 2026 13:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94Zn-0001rt-TY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:46:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x94Zj-0008Gu-4s
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:46:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjIBs573113
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ba18U8WBiQBrZOB7yWX5ZE1GhAW+oXeoc/Po4ELEZig=; b=Sk7ZfUNqvY2ii8i3
 TsCCaGalJ01odVibLdwKT/6/shLrdEoQ54fmwJ30Dn4v3fHPr0qdK3JromXF0JF0
 sIUkFlV9hc5mgNAcA9UqU/3vrLfwDGxZ5tN3fyhzlUzMRjG9TW3hk8gOpKNtGhR6
 vjj3HB7QilT1fjjxwmQs/0abwI35JObirQtD3LJsLaPHsTtSGhoyxjp4Lxgwb3jt
 DqAbA0a78b2UmLHiLvvFIm4cXPQuKBaDHYZXJwYkzTApLN4+zcMDYyDtyTTlm7Yr
 7LymKavn6tTV8WHcjeGy9+V6yuplu5gkVj26QQpdHKP1GUcMNa4cH45f8JaNqTRh
 ZMTgPA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gujkjbhsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:46:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3284bbaa89dso170167eec.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790099195; x=1790703995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ba18U8WBiQBrZOB7yWX5ZE1GhAW+oXeoc/Po4ELEZig=;
 b=SFdmd6B2b6jRInnSYsQqThqT2WQJ3GaISnQ/UhlWHbrl4OiXEsP8wQ6LHSVd8QcmHc
 StnPVqDhtWdwmL6F1p319N5/zv17onV0Cj/FmnRaFtSSQLl3r+UckeFKzGEJid2b4f9k
 0nVjqMcw60zNd/4nKWqGGlhd1E3bJD0s/5v/yiBpC/8soQGDhrZhwCTEbHgt6f9yE0g1
 Ql6ZgEbmGUQXlMlIc02UKp2u+b27Gn+8XZu5am6ExgkUnW9tzOat+e9kcy2NDjEp/wGY
 hxZiCLY/XdiVnqG+3rQkrVljco1jYRVQhCPILEcLfTgRrr2C3SFqUkuzIP1hdZVSSG5k
 UPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790099195; x=1790703995;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ba18U8WBiQBrZOB7yWX5ZE1GhAW+oXeoc/Po4ELEZig=;
 b=WRlmV+FMVjSR5fffotflYXUPvhXcudBxR0SrtahR8kb0D8xwRHXRr79l/Kpn6K81M4
 bT9CpCubIZcsMV2VrDNHx4N/BfwuJMQ5CQ1k+lMcKUaU5LPh+ijrp3CkRz0VEJeNHYAp
 3DIu/sYvw5qHlwVlOSv3JlzNJQzb68g7FD0ysP+71R1tFj7WXcB8XZP+cICtgUbiSPQ+
 H5P3pg9gIplWFkuVh3GTdwHj7fBVDdZpGgl294hPxbmVDKSX0NWC9j9CH1FhVExKrlof
 NwyHBreKdbUXYFrHrsj6iMiU6lV2sDf9z38/eSfTXifyYNqVOf0Mac7uS984Wns/fwtB
 uYpw==
X-Gm-Message-State: AFuF++mcybqNS033obf6cjq9YfrFyT/ApIBCp+aNcnuyrB5/A3Dwj3dJ
 b8cDBLtSwHzBbgy65WRMjGAYhVb31bVrbiQ9LCLdMfDTRR381Dez01kbbTQ41O5cxqYlggeFLKH
 4kp7PgJ3euUAZYskRGbKZwUH2pI+mY/hoJGwUkidTV0QKmkWOjXlrlBYNnMDVBFeCuw==
X-Gm-Gg: AYBFou0ACdCZfPAsoFxNZHePCK0tUTHpazTyB2Jo5CeqMEqS4S9Q7n2MSi6UP2sZLl8
 yQ8qOA+Pe6nBtfYbNfRMQFHceYeqe3xzq5AVoQCqmCwzJEnYjj/HG+LoNfA+Oh3rgIEcHsyjRua
 NztPXccBgIE3rz1mOlziPwibwapY11r4FCqWhFgxlanCNfuAGCPeEYpYgNWhNhpZkJv+ztBMML/
 1bQdD9/xpMnHaRh+ikb3R9TxdZjcVyVc5eYLdFBLGgEI3MJw0w/kHtDrRIzU/srVKQNo4YnM3lJ
 dmNYfNb2ZkYxgmCWZgck6lcLdBeRdZmKIgkyVn6rlF+Wb/ICEvpLRjBR49cana+Kn7Eg0d+L1I9
 niJCbVSF7qxhh+NYbyK6YJbo0OTDAYBUV/4AkyDk6PSlpIDllnuSLfvqt55bBBD33juk=
X-Received: by 2002:a05:7300:f144:b0:33c:987:7567 with SMTP id
 5a478bee46e88-33e8dbc4252mr34296eec.24.1790099195245; 
 Tue, 22 Sep 2026 10:46:35 -0700 (PDT)
X-Received: by 2002:a05:7300:f144:b0:33c:987:7567 with SMTP id
 5a478bee46e88-33e8dbc4252mr34261eec.24.1790099194542; 
 Tue, 22 Sep 2026 10:46:34 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e8dac9facsm31540eec.24.2026.09.22.10.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:46:33 -0700 (PDT)
Message-ID: <1734b67d-7f86-473f-ab77-0201636aaf72@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:46:32 -0700
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
 <f2df6883-ee78-48b1-bd03-9b7d41ac2b60@oss.qualcomm.com>
 <arK-ePCi4xU_4sXo@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arK-ePCi4xU_4sXo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Pt9-MeNvxLDMUX60mqUgwviQpHZslept
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2MCBTYWx0ZWRfX03jKmsWYxDFk
 mSmz8B+i8vxKaQ1odv5/gVB5Ky9b/kO1wTAV2wgK+hBi2VPWZ5VrRXN6Y1QDGK0ajk433R4VGoE
 aBEDuKLn7B5St4IWxYYDFPklq6Qy97k55oBJly6TsWVXG8LjZrNRzu2TwRPewRyI565z068fxBa
 B+Ea4hYzsAxm8HGSNKDA5Z9u1+J3m8cODxe/zQlTJhsx1IRBXb6KNd87D5LMa8Zz+6+r7ZmSPv2
 SRAv1M06EnKjR4mNq4gLBVql+Hp8TrilfkKTeRFFY460eL2j4QrHxbULtxfgJXH1mxzAc0gPtaS
 mlki/gWAhJnVwWdXVHD5JPwZ9wTYMjXaTreP1RGJ1ISals1xIuT41glx7XTDDpDHuOQSYQGW3La
 dE4K8rOkKou6jRI3XiSfPqNuI2Xpqw2gQmVnuu2Q/hCTObIVvXBalyZVsnr2ycLLvSamoXKtClU
 094I0gCeW2OOEAsy+IQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2MCBTYWx0ZWRfX1BJ7dUz6/mlO
 QA0BmKFzC01Q2FQnjdlHV0rx9JRddWVHdPAI/xZgLEYXixyVFWsUctXUY0s1XrBPLclyDXfaJn3
 fJs2PRIXbEep1AlXXToEZh/wF9ZHiG4=
X-Authority-Analysis: v=2.4 cv=SuAFe/O0 c=1 sm=1 tr=0 ts=6ab2befc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ySKFF1CTKHyh6QN_nNYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Pt9-MeNvxLDMUX60mqUgwviQpHZslept
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220260
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

On 9/22/2026 10:44 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 10:41:38AM -0700, Pierrick Bouvier wrote:
>> On 9/22/2026 10:35 AM, Daniel P. Berrangé wrote:
>>> On Tue, Sep 22, 2026 at 10:16:27AM -0700, Pierrick Bouvier wrote:
>>>> On 9/22/2026 9:54 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, Sep 22, 2026 at 09:15:02AM -0700, Pierrick Bouvier wrote:
>>>>>> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
>>>>>>> latest update of libvirt-ci changed packages, but images were not
>>>>>>> refreshed.
>>>>>>>
>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  tests/docker/dockerfiles/debian.docker     | 1 -
>>>>>>>  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>>>>>>>  2 files changed, 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>>>>>>> index 77869f71546..2d03ff03c8d 100644
>>>>>>> --- a/tests/docker/dockerfiles/debian.docker
>>>>>>> +++ b/tests/docker/dockerfiles/debian.docker
>>>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>>>                        libpcre2-dev \
>>>>>>>                        libpipewire-0.3-dev \
>>>>>>>                        libpixman-1-dev \
>>>>>>> -                      libpmem-dev \
>>>>>>>                        libpng-dev \
>>>>>>>                        libpulse-dev \
>>>>>>>                        librbd-dev \
>>>>>>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>>>> index bb8f4e4e53f..440699a5005 100644
>>>>>>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>>>>>>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>>>>>>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>>>                        libpcre2-dev \
>>>>>>>                        libpipewire-0.3-dev \
>>>>>>>                        libpixman-1-dev \
>>>>>>> -                      libpmem-dev \
>>>>>>>                        libpng-dev \
>>>>>>>                        libpulse-dev \
>>>>>>>                        librbd-dev \
>>>>>>
>>>>>> Dropping this patch, as it's incorrect.
>>>>>> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
>>>>>> ubuntu2404, so not sure why it removes it here. Seems like a bug in
>>>>>> libvirt-ci itself.
>>>>>
>>>>> Most likely you ran invoked lcitool from an aarch64 host OS, so it
>>>>> filtered out libpmem-dev which is only valid on x86_64 targets.
>>>>> The non-cross containers we have defined here are assumed to be
>>>>> for x86_64 targets.
>>>>>
>>>>> We should change the tests/lcitool/refresh script in QEMU to pass
>>>>> '--host-arch x86_64' to lcitool, rather than defaulting to the
>>>>> developers' machine's arch.
>>>>>
>>>>
>>>> Thanks for the sharing the reason, I'll add this option.
>>>>
>>>> Out of curiosity, what's the reason to differentiate generation based on
>>>> host arch?
>>>> Wouldn't that be better to be explicit if you want to generate an arch
>>>> specific Dockerfile (and use FROM docker.io/arch/... instead of
>>>> docker.io/library)?
>>>
>>> I'm not familiar with docker.io/arch/ but this all just grew up
>>> organically over time, and since most usage was x86_64 host based
>>> there  was not much need to think about other scenarios.
>>>
>>
>> Basically, it's (official) docker images per arch, following docker
>> platform naming:
>> - docker.io/amd64
>> - docker.io/aarch64
>>
>> https://github.com/docker-library/official-images#architectures-other-than-amd64
>>
>> Advantage is that image are provided for a specific platform, which
>> avoid some of the issue multi plaform images have.
>>
>> For instance, on aarch64 host:
>> $ podman run --platform linux/amd64 docker.io/library/debian:latest true
>> $ podman run docker.io/library/debian:latest true
>> WARNING: image platform (linux/amd64) does not match the expected
>> platform (linux/arm64)
>> # podman/docker now select the amd64 version by default, which can break
>> build of other containers. It's a design issue with docker cli IMHO.
>>
>>> If we want the tests/docker/dockerfiles to be portable to non-x86
>>> hosts, then we'd need to either have many dockerfiles there for
>>> each arch, or drop packages that are arch specific from the
>>> install list.
>>>
>>
>> I'll add the --host-arch x86_64 option to lcitool as recommended, which
>> should be enough for our need.
> 
> Hmm, I think we also need '--arch x86_64' passed to 'docker build' for
> similar reasons, since the dockerfile input to the build has an
> arch specific list of packages.
>

That's what patch 1 is doing, adding --platform to build and run
commands 👍.

> 
> With regards,
> Daniel


