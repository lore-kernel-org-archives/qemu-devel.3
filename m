Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7859AC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSbH-000210-Iy; Mon, 10 Aug 2026 12:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtSb8-00020c-BD
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:11:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtSb3-0002sh-5g
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:11:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AFWehF2345308
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 16:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sygwd04pe33lb/VI7EK0b+ajWCZHprKdeNfGkxC//Qs=; b=h+h7MnZVYE+RwMR2
 UqLAvxBC+xlnTYuUNULGEp9/12nuJ6xe0FecSWiUNE2aXh3XD57VjG2Gspyb9Rat
 ygTVW5P+4IKZvnuKI9/YDlXaNUGL3N/5bmg59p9nBO7Qz+H3WDZF3+p7yr9mB+QB
 w2hBWAfTK63gYOZFe7kQbBINt3SlQqX8Vfq+9v8awnJB76A5xRNRqxCWuXpn/6tL
 Hb8U884u+MwHwLWMy48G8NuXdT4ikbM7tudDrlz4CizY0uLKyYXhV6nCdHn8s7b/
 qjQSv5Zs+dvirfwDrjiOCqzp6uf296pFCzfTca8y5aAxy6mQEcDCgHHbpR+suSOY
 +lDqDA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xug6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 16:11:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso4126796a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786378281; x=1786983081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sygwd04pe33lb/VI7EK0b+ajWCZHprKdeNfGkxC//Qs=;
 b=SnkPhxfkgp2lEbc2ZKjZRd8hjRiUSSVBynYM4wd0qgeMf2IDGznN78Dnv4eC8FsApl
 jn2Tynd0w7j3bMem6+r0rGrD/wR/MjUFMOkv25iAcr59zoZVrsJ8OaZjXqunXcN/190r
 TU6ncd7EEouzgDgfEMCfdL1+vxDAImwawEAgpHCMEu2mwt9pG20kfr3MtBzXkKqFCBIx
 xQQspMwEcPNGBb2tqs+kQ4iJvG1Uy4MBl1iJpzGYCwhtewjNKxpQ3df334H7J7UcMjzr
 n4rx0u40Rdof9KgtSHQXnMbk4DpzkHzyRjiVe/DYh563Qkq0u2fOhUGbpkWAEHJpNEVX
 pAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786378281; x=1786983081;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sygwd04pe33lb/VI7EK0b+ajWCZHprKdeNfGkxC//Qs=;
 b=SS5U2hozk3jLZNwsuFaaQEEO7KEP0PnR9af7vAM0ch1k2pK6yt1hBVJMiOFZs/ZKS4
 Y7p5p4s2JCNayZ709Fhhv6Wz8wucp33CVAW18/ReBL0ORMZ6agXVdTv8mCbj2jD8gXwy
 iNbwX3eVTLdiINpxyDPQ9ltaIFyvdj5yipmU1GZsdyiwo1XRKqlR6Xi75payU/BKIZbz
 +Vr+jRTwdhrBKIXxXhLXWnLTc0yw9RI6yYFExaSy9m4wYYE8JPsdYvko/uFjIau5Uox5
 R6AhX3BXMrbkBKu9JqR9y4W3h+Vv8QgBrVShAd8p564rIdlJOW3IkLHF3LRbmWp4G8Kv
 QCAA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzQ11BvOOCMYl66a1Z2gotseHfq67jyja5mzt4E/r3VSakUn/mEecVuijQnVRD3uXrXWzWLSppJ8n+@nongnu.org
X-Gm-Message-State: AOJu0Yyq9DFN2zUKnYXVHjJhtZfhOUhfb/9zjQuWCgz+Nld3JZSSEw39
 JRcbV0YDfjhHy1w6vmz8fiPWLfAgHuczfMAG8c16ZwcqKkLmDK6DTcFZS4ofpokOgyNhBoKRRAk
 aWhet9T3qQeefpYRBPn61T2d5tG3pEMi+y013VWxZIM9YDXNVz5wREFcZPg==
X-Gm-Gg: AR+sD10JkNZCJU6GzXnbGzWj6sCZ6biznJx/CsBz82HneDqFpccCoJHUL/ufDeriP1o
 BEMWa6TPIXqBMcrpw5EDGg2D1zBmMy4+s7K5SOGZsBULrDKq5fGJrtaZl2ysNFldnSQQzPA9i9X
 Ay5xfsq3uBcP8L2AdlhBDsAs41YfrYjdMvehrz1rz+ucCltrr3mDKtGY517qc22sBWDWRRdLb32
 g7WRd+irsNUZEzyrrLG2jLqTm0TAtxdfnsCG3+kPKB9+u/n1aQxOkD0Yk2nmz6cAUILd7EokG73
 ijExqYIAiZ1NSqGKVBDlgAruMuv5BrbAYrTqKcVlCpgKB3mMMtHfPhGuQl9OthEGswEcrfPAoT0
 CbdaWODH+sMqGh90oQOZWcJewMBcJu22tDvi/ONUQA5WIzrpCxHkHG71msEZ0Bkn4Psfz
X-Received: by 2002:a05:6a21:9995:b0:3c4:2eb6:c3a0 with SMTP id
 adf61e73a8af0-3cbc04489a5mr25109485637.30.1786378280578; 
 Mon, 10 Aug 2026 09:11:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:9995:b0:3c4:2eb6:c3a0 with SMTP id
 adf61e73a8af0-3cbc04489a5mr25109417637.30.1786378279984; 
 Mon, 10 Aug 2026 09:11:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141018f18d6sm40082424c88.0.2026.08.10.09.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 09:11:19 -0700 (PDT)
Message-ID: <431f8304-c4a2-463c-8e63-9b9813593972@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 09:11:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <anS7uRcg2IkGxR-4@redhat.com>
 <328caf32-d011-40e5-aa05-dac3273fa203@oss.qualcomm.com>
 <ann0yXUsspvKffH2@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ann0yXUsspvKffH2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfX3DAYWUVk4wXd
 vRSW3Iw4vSS3rAxzk1QUEqBHNzN7Cm2yrx+SZa6WYIUllc68H8YkMDJPx456ONsGpV/3/LHKSUl
 W1LG9uY5gHhVKsF/G80EkrWL5JX4yGw=
X-Proofpoint-ORIG-GUID: W0f8jj5HmMhbZCnW8DwUV5myA4kMrjoM
X-Proofpoint-GUID: W0f8jj5HmMhbZCnW8DwUV5myA4kMrjoM
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a79f829 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=CFpV7jCm5_I2NdFgZeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfX7d3aw6/n6nYZ
 Nqfu0v6KmYqx8AMKVIXNurzkBeE03kNJoGGLEikLN+ju8eLyUOwBIh3GufI28Hle8UNgENvuoHo
 4QyLDidWmnpRV3fmVOtw7fCFnDYtaTYcIelMQ0EKW/6e+11xfaq5BtN9s0smEBkhNsSrV8uuH4C
 xT6KZJXQhOouv6EaX0UqpD7u1C3u+fngjF2/mPAM9vDbCD8VldO74F0FjA2n6nteKd0ak7cz3oZ
 lQx6n/90hIV0i/ujyrGHEQIyqhqqg4LHWeXEfuNTPiZ7qzgi4cPzLupoAsvisvFEyobPJyubT1a
 JxSsxeoqVVZVarIp1rUvw0gefJWAY0Kg5FYX0rp4jTsNrVpgg/+ywZ60n+sbklBHT/F0qNMn7Co
 hgCQwl6AhLjZu4QsqYykbbR58tRKaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608100139
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

On 8/10/2026 8:56 AM, Daniel P. Berrangé wrote:
> On Thu, Aug 06, 2026 at 01:21:13PM -0700, Pierrick Bouvier wrote:
>> On 8/6/2026 9:52 AM, Daniel P. Berrangé wrote:
>>>
>>> What machines you could see when doing "qemu-system --machine help"
>>> would depend on which/how many "--target NAME" args you enable.
>>>
>>>  qemu-system -target x86_64 -machine help
>>>    -> x86_64 machines
>>>    (equiv of qemu-system-x86_64)
>>>
>>>  qemu-system -target aarch64
>>>    -> aarch64 machines
>>>    (equiv of qemu-system-aarch64)
>>>
>>>  qemu-system -target x86_64,aarch64
>>>    -> aarch64 machines
>>>    -> x86_64 machines
>>>    -> aarch64+x86_64 machines
>>>    (equiv of qemu-system-aarch64 plus qemu-system-x86_64 plus new heterogenous machines)
>>>
>>>  qemu-system -target x86_64,aarch64,riscv64
>>>    -> aarch64 machines
>>>    -> x86_64 machines
>>>    -> riscv64 machines
>>>    -> aarch64+x86_64 machines
>>>    -> aarch64+riscv64 machines
>>>    -> riscv64+x86_64 machines
>>>    -> aarch64+riscv64+x86_64 machines
>>>    (equiv of qemu-system-aarch64 plus qemu-system-x86_64
>>>     plus qemu-system-riscv64 plus new heterogenous machines
>>>     for any combo of x86_64, aarch64 and riscv64)
>>>
>>
>> This is where we have a gap in our understanding.
>> The goal is not to enable multiple targets, not in this way at least.
>>
>> I give you a simple example about why it's a bad design:
>> What is the semantic of such a line?
>> $ qemu-system -target x86_64,aarch64,riscv64 -M virt -cpu max
>> We now created an ambiguous command line, is virt the virt riscv64 or
>> aarch64? How about cpu?
> 
> The ambiguity needs fixing before we can have multiple different
> targets in the same binary. I would expect you're going to hit a
> failure before QEMU even tries to process that command line, as
> QOM class names must be unique and you'll have two separate
> classes called 'virt-machine' AFAICT.
>

That's why it's interesting to fix this issue, as we add more targets.
We met this issue with max cpu between arm and aarch64. There is no
"generic solution" and we'll tackle issues one after another, like we
did so far.

>> Someone with over engineering tendencies will come with the idea:
>> "Ok let's prefix machine and cpu with target".
>> $ qemu-system -target x86_64,aarch64,riscv64 -M aarch64:virt -cpu
>> aarch64:max
>>
>> And then, someone will say:
>> $ qemu-system -target x86_64,aarch64,riscv64 -M aarch64:virt -cpu
>> riscv64:max
>> And then, we will all go to hell for creating such a thing.
> 
> I wouldn't suggest we need to prefix an arch name for *everything*,
> as most type names will not clash.  "virt" and "max" are two
> exceptions but most machine names and CPU names will be unique
> across architectures.
> 
> IOW, just those clashing names need fixing, 'aarch64-virt'
> and 'aarch64-max', but not the rest.
>

So now, should it be the default name for existing binary, or just for
single-binary? This approach creates more and more problem.

> Saying this is "going to hell" is overly dramatic. It is just
> an expected result of fixing a handful of cases where we got
> away without having properly unique naming today.
>

Sorry for not being a native speaker. The meaning I wanted to express is
that we would commit a sin, and end up in hell because of that.

>> The only sane solution is to restrict to a single -target, and have the
>> exact same behavior than current binaries. No change, no breakage.
> 
> I think we're going to need to have changes this area.
> 
> To deal with the transition we'll need to support aliases
> like "virt" that resolve to either "aarch64_virt" or "riscv64_virt"
> depending on target specific context, or raise an error if it is
> ambiguous in a fully heterogenous context.
>

How about we wait to have a single-binary before solving issues to which
we're not exposed yet? We don't even have a prototype upstream, and
we're already trying to solve issues we'll have in 6 months. One lesson
of our work so far was that trying to fix things before they happen
just create more delay and problems.

>> For heterogeneous machines, we want to propose a very different
>> approach, that requires all QOM types to be registered. Once again, it's
>> not the time to present/solve that, but it's why we implemented this
>> runtime filtering instead of exposing only some types.
> 
> AFAIK, QEMU won't be able to register all QOM types, as it will have
> multiple different classes called 'virt-machine' and will (should)
> trigger an assert until they're given unique names.
>

See the first paragraph in my answer above.

> With regards,
> Daniel


