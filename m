Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9680EC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBHz-0008QS-Fr; Fri, 26 Jun 2026 14:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBHx-0008Pu-Ku
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:28:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBHv-0007J4-Ns
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:28:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QIQqm42104407
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 18:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLOY0UVPy5eBI8BxEpGomxZsn1ve4ygRdReiJweKLB0=; b=dxd1JqosW1Omlbqf
 gh6TJjtW3Pq9FnqIUqe7ndNGUB4gInZeelbj0u5b80kqh5FjnKGtw+qhPihIezvE
 2wn9k9V5QXJ6ga41OnNfcm2gedSgWRk0X7UDHFw5wBK1tBDQxr0Je/BH3OXtlWSZ
 FSXp/dHfh1ZkBFuj4lx8D/RR+9l7y1q0gldR2++aPiXs1wtXuMLgpGelEJG1z5rj
 LAkQv1weQHC7Wjcx3M+Bva2Moc5pxVg0yzzvntVRFGAft4Ul1mUVvRPtsnh2X2YB
 +eIjkJb2hXDQP+b1XpTJLXq9OYEosb/KUvRCYzrHUqmAPQoNjBe/I66zoJMNHvBc
 LsOgVg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xqa804r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 18:28:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bccca5620so1770670eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782498504; x=1783103304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tLOY0UVPy5eBI8BxEpGomxZsn1ve4ygRdReiJweKLB0=;
 b=QCh6m77rHyOloQgOncGL4pwt7SUXXdztAG81CHchcF/eblVm/Zi5rdUTlCBunPTfCg
 wbn3atgG+kaGX5gUxFPHL10EhdbObpwlnX3Jhd2wYX5AIt9t52hMOucUn4U/E1rfPpOx
 KLP1yTKyrrlYgdoYCZl+lI3ZlNy4eTfm8/j1wKKjh6AfOdTddcO7wijKH/yVKCQKhRZ0
 wOK9Kvayq2DcH4UBYpznhPEy4uVVJLYLqSPEbbQbGdsnMsfZ+IpKiJ9w4o4abVGjxusG
 x6AfCCi/LJ9VWokuMbGmBPO4aWOGiCwZNmaBHyL0bNOd0rc0vJcJxfWKtj/luVU7nuvd
 TAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782498504; x=1783103304;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tLOY0UVPy5eBI8BxEpGomxZsn1ve4ygRdReiJweKLB0=;
 b=EJRvIey1SwNPmFfSPa4VWN5MQVd9AfMR7MHfudTJ8b+C38OcoWPQg2AnuDCAMT5hLw
 fIax02w3d6ZLT0Fg9ocYzTS4mCaXWh5DexMUHqihDtenHrEAQljutSHKctNbzpjmk31Y
 Pv2slQN9ABnPRUjMMFDoOfaNTanAVNk1hqkwxQAixGkdHODWt5Blhipl4oEpS1J9+35+
 Wv35cW+G9pWP+evUa/FpmDb5JDZN2sjTe06ND/Y0nL3YL/b702tlyhRnmuoNnCACbStI
 qdT8GQIvNobvum2oQ5EON18elJr8gz7MLd8q5MDoornZKqye7gOB6D8K5Z65Kn2Fh0mm
 9tMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKunKNIIolhki+fyZYpW6Qr17mn2Aes95iG/XrufnNctDW8L+zScE4JHfvp3+ItAli0lnkQ2isPKzA@nongnu.org
X-Gm-Message-State: AOJu0YwZf9xYXTScAlThMg3WoOh/wGPh+xsqiqDII1mbIrc7fHYoOQbH
 qOU8SQ2HvLMPTGlJaL/DUMuDpYg5n1MoP3QYB3DdSkoiUYEtI3Riu6rouTiRqUH5+sWmVMlG1wv
 Gnk+04yzie1YoIcmA3MyYmC5GE+zVpnqSaWHjL2QqQBw8u5M9BYfhhDLT0g==
X-Gm-Gg: AfdE7ckMqhCqcoxbvSQfJXaNGe9IZ48G4sYMapI9qOv5dxcZbOtjGgkZOuEvN6+mgUj
 HZlvmH6w/Ov4lYM9wr4lzscuvTiaXPbAlkvjeMW4f3oGFXqQha3SwMoFiwa1GvE83MXgpcG+Z0o
 WraimFvyDKeqpZTHgpV31GVZpq9qx6JTXZqxfL4fLR3g+uMBETNjuIV2EJhRutgmyEJA7mPzOoo
 4GSu1Zm4y51igAR0QAwALwna4bSU8qEyg2F6QoFsGwlrsoxGRzY0THFHMKbJ5MrOHmRrIV5n1oW
 YrGvy17W6CUGrPjh9Na8RYbTflJrOHZCv3JZQ1xD3CXOt2P7NSd0xKREB2bybHCN/gPRgGeauam
 rzauxxWqG6XTxxtVlocEgeOy/Qhi1CG/BQd440SjAXPnygxLvReKWrFJr6YZSm6Owwd17Uhi51i
 mAg5M=
X-Received: by 2002:a05:7300:23d3:b0:30c:ab4d:382b with SMTP id
 5a478bee46e88-30cab4d3c28mr1119119eec.45.1782498504281; 
 Fri, 26 Jun 2026 11:28:24 -0700 (PDT)
X-Received: by 2002:a05:7300:23d3:b0:30c:ab4d:382b with SMTP id
 5a478bee46e88-30cab4d3c28mr1119072eec.45.1782498503326; 
 Fri, 26 Jun 2026 11:28:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a80sm19489883eec.18.2026.06.26.11.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:28:22 -0700 (PDT)
Message-ID: <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 11:28:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: linisha <linisha232@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, mjt@tls.msk.ru,
 philmd@mailo.com
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com> <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
 <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OaM7zapXLKwmNmPWOaXbMSmI9gHW9QM_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE1MyBTYWx0ZWRfX7b+4TZ9Jg8My
 4u1M7wq/W5GaegNx3xqjFtQHKcZ7+8p2GPy73G7HRXVThLmlHTLF/CB16zMGqdS9BZ7iy8Y5qWA
 5iTCarNf9tjltqN+oAKlI7l5vHlYsKA=
X-Authority-Analysis: v=2.4 cv=GPs41ONK c=1 sm=1 tr=0 ts=6a3ec4c9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=0MAClLo30FVTCrmksvIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE1MyBTYWx0ZWRfX77k4Kj1WqfLj
 tmBq/LJO8bqSX4J4awBYV+P+WHCxGfEl8Y8gNyIQ76df17NEJuRtV6FmKwj1DYD91lpqfHvKDd7
 UKQdmhIYxfdSQKC7TgBLoeI+7yD1nanpsSVULmI6bfaxMgoEoi42XUMtaT0+aXGo7+98f2taPfR
 TKVs8iwd6a3hdpwMS4ZyVOFBdZNnf2RvxyF8d36LK3Z6yntzPzXcJluRPM8LcDNnRjfEq6+Gylf
 Jvt6mmQzYZkThThr5j9KF2oNQLkjbI/bXL0yNWcQ4EY8vTRWbDXN+DYTtomHEfI+VA2XkLSv8Xs
 xH8jcxYrW+QP9RyaJR3JZW8xwzMRtQ1VAhiLGwxrOFrAugKKsDa6ucXPMgTi1wrpZP4E7B6TFCn
 cov6c9O+0SC7tmAiFPo0wT077qzBFzpNHBgyyUxi7bpdQ6Lfl8yJD7rbG7ngDAkh18lAIhLgFyW
 OC27nC2kH+/KQdnL5RA==
X-Proofpoint-GUID: OaM7zapXLKwmNmPWOaXbMSmI9gHW9QM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260153
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

On 6/26/2026 10:44 AM, linisha wrote:
> Hi Daniel, Pierrick,
> 
> Thank you, Daniel, for the Reviewed-by tag and the wrapping feedback.
> 
> Pierrick — I didn't intentionally remove anyone. I used
> scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
> Philippe Mathieu-Daudé, Richard Henderson, Alex Bennée, and Cédric Le
> Goater, and I picked CCs from that list along with people who
> responded to v1. You weren't in the script's output, so I didn't know
> to include you. Apologies for the miss — I'll CC you on any future v3.
>

Thanks for your answer.

Just to dig this further, is your tree up to date?

When running it on my side (from upstream/master), I get:
$ scripts/get_maintainer.pl -f docs/
Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
Documenta...)
qemu-devel@nongnu.org (open list:All patches CC here)

> Daniel — I'll send a v3 with the commit message body properly
> line-wrapped to 76 characters. Let me know if there are other changes
> you'd like at the same time.
> 
> Best regards, Linisha
> 
> On Fri, Jun 26, 2026 at 9:09 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 6/26/2026 3:09 AM, Daniel P. Berrangé wrote:
>>> CC Pierrick as docs maintainer.
>>>
>>
>> Thanks Daniel.
>>
>> I wonder how I was not in original recipients for this patch.
>> @Linisha: did you explicitly set list of recipients, or remove some people?
>>
>>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
>>>> Add a note near the start of the introduction explaining that QEMU options, properties, and command lines may differ between target architectures and machine types. This helps prevent confusion when examples shown for one architecture do not work for another, such as the pflash0/pflash1 options visible in -machine help on some machines but not others.
>>>
>>> Please ensure commit messages are line wrapped.
>>>
>>>>
>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>>
>>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
>>>> Signed-off-by: Linisha <linisha232@gmail.com>
>>>> ---
>>>>
>>>> v2: Take a different approach based on review feedback from Daniel
>>>>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>>>>     machines too), add a general note near the start of the introduction
>>>>     about how options, properties, and command lines may differ between
>>>>     target architectures and machine types.
>>>>
>>>>
>>>>  docs/system/introduction.rst | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
>>>> index bec7291e47..8d9ef61d26 100644
>>>> --- a/docs/system/introduction.rst
>>>> +++ b/docs/system/introduction.rst
>>>> @@ -1,6 +1,15 @@
>>>>  Introduction
>>>>  ============
>>>>
>>>> +.. note::
>>>> +   QEMU supports many different target CPU architectures and many
>>>> +   different machine types for each architecture. Options, properties,
>>>> +   and command lines that work for one architecture or machine type
>>>> +   will not necessarily work on another. The examples shown in this
>>>> +   manual are specific to the architecture and machine type being
>>>> +   demonstrated. When in doubt, consult the documentation for your
>>>> +   specific target architecture and machine type.
>>>> +
>>>
>>> Not convinced many people will read this, but I gues it doesn't
>>> hurt.
>>>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>>
>>>>  .. _Accelerators:
>>>>
>>>>  Virtualisation Accelerators
>>>> --
>>>> 2.47.0.windows.1
>>>>
>>>
>>> With regards,
>>> Daniel
>>


