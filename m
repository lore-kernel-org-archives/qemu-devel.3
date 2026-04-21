Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B17BF94CB0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJ4R-00060y-Ff; Tue, 21 Apr 2026 17:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJ4Q-00060f-4Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:55:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJ4O-0000gf-H7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:55:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d6fbd0954so3833964f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776808547; x=1777413347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XZwLyPJplmTWtTj2UT4jH1YdF/y/oearIvzj8Hc1hyQ=;
 b=SsbDLiGVAulqAl6FopL7m44185pK+JIG0gIR6leqM+vXN9zZnqdDzSTjk+KsVvRDWr
 6py1W8loOXlh2ieFe3xl9auJO2ySIW5SJNXxIl/cDd+bfUmSHBEN4bovRXdZclWX755M
 iKWG5B3O+uws+o6bV5UXEKuu4VdymOLZTSPpJwH+y2KacneTHDYjzRY5/mDmwNKvZQXM
 /ugcRGIUIqSbiLE3DeKI0/bIJKwlDrG81ecU4NEorsK2+gJxcH3bKifsS13SjVwAUGyN
 Tw6xs1sVub46BPyQXb6mGDksevATTpyn/sg8E+tBFZmfWiXUMPJlJZhDat9+b5nFBDMd
 zz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808547; x=1777413347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XZwLyPJplmTWtTj2UT4jH1YdF/y/oearIvzj8Hc1hyQ=;
 b=VF6CGSAqb7z6x4Y2rg6xzJk0puBQHK32+vbfS86TO8u+GpFuC9nqljQ/4lVfd6xQHR
 ZXFOEjgnfROyY2W/AAcc0o2ddwjrwWAsJPhWFpyfVXAt2bb8t45ah58KbfD/zfON3J/w
 mTu4eqTJRqpLNMBiKFlpyDF/s/qkQaUMooKTxZaqcTWnhKT/7yIqENc45vEaumMEAIeT
 JDXLWZDX4zJs98MjFtiEakx3EnHRZXYLNGdQ3Ter0DNqpI8jsTkk3NImvWQP+TBRMwFh
 rz0Z9qb9LIuDF2SiVU7lkRlp+itay9/dropaSNQG6TAt4bg52FEt1/PXXxqOt91ZxDFP
 Zf6g==
X-Gm-Message-State: AOJu0YxTq6oEZRtD6gpgEiiTUPuOKmsHF+ThhADRM9gD/PRzzCfvYCpK
 bYAGc2UWmURY6gx2LCiRMS5Arha/Capu0FWuWk4VcqNhmdZ6444Yx3OBxLq9dsg+9c4=
X-Gm-Gg: AeBDietltVVAGkxCL9WdgLACA7CR3J6jgX3llHaD+sLdk8S9TwU3jexbQwyGqPQhVlU
 dioAlSVPxCXtR+8v8Hk8OA2zfcF1Yl8SuXKbugr/Lw8mjr19uxvbGCWQxewHfPD6w55QF+pHy4l
 gkOe0ALoLVR8CfwGocaeO9Vy2kTHe/sL648oW8QOijDHUWZBCfdLWA+2dXCxJZ1tp6WzizdLdHk
 p2K0POq8Gvn9iw2/ACOolj90PjjGXbmy5NZqcCxr0MchttIqdcBq4sBVZ5ngUoLa5vl8n7wLLwH
 94pK6nK3UZ53l+39GWwHeF2/XsWQd6B59LxLcC8m1pYo2hOrXqeVO4FKo/gfkZEwgXBOsfRCOc1
 FTaAujqrkzRx39FHsCQgJ2MsNx9Y2blgMwl7MQpSyvH3i9bw2PTzkxwQXBrnkKpbcDPEDmlMt3J
 A2UsYATOYKUQSOaxQrlxxupqElNO/UVWLzEXeYtmUgw2YphTf5FASOLWOmdEGpvzDyvaqk9UrBV
 yvD
X-Received: by 2002:adf:fc4c:0:b0:43f:e413:e5ad with SMTP id
 ffacd0b85a97d-43fe413e60bmr21642476f8f.0.1776808546862; 
 Tue, 21 Apr 2026 14:55:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a79esm42662097f8f.17.2026.04.21.14.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 14:55:46 -0700 (PDT)
Message-ID: <9867b017-88d7-4acb-b855-9e0293b26be3@linaro.org>
Date: Tue, 21 Apr 2026 23:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
 <46a10ac4-a267-458e-973e-a784173460a3@linaro.org>
 <CAEqNhNbOJfne+0OTazYfYzzxbReNDng9pm=iNmsyFiEhasXoKA@mail.gmail.com>
 <5ee12c29-5d61-4c3d-a8b9-bb049585ea56@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5ee12c29-5d61-4c3d-a8b9-bb049585ea56@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 20/4/26 18:50, Pierrick Bouvier wrote:
> On 4/16/2026 8:12 PM, Brian Cain wrote:
>> On Thu, Apr 16, 2026 at 4:19 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 16/4/26 23:03, Brian Cain wrote:
>>>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    MAINTAINERS                                 |  1 +
>>>>    configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>>>>    configs/targets/hexagon-softmmu.mak         |  7 +++++++
>>>>    target/hexagon/cpu.h                        |  7 +------
>>>>    target/hexagon/cpu.c                        |  3 +--
>>>>    target/Kconfig                              |  1 +
>>>>    target/hexagon/Kconfig                      |  2 ++
>>>>    target/hexagon/meson.build                  | 13 ++++++++++++-
>>>>    8 files changed, 32 insertions(+), 9 deletions(-)
>>>>    create mode 100644 configs/devices/hexagon-softmmu/default.mak
>>>>    create mode 100644 configs/targets/hexagon-softmmu.mak
>>>>    create mode 100644 target/hexagon/Kconfig
>>>
>>>
>>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>>> index 9883c4d1681..355abb4fd24 100644
>>>> --- a/target/hexagon/cpu.c
>>>> +++ b/target/hexagon/cpu.c
>>>> @@ -713,9 +713,8 @@ static vaddr hexagon_pointer_wrap(CPUState *cs, 
>>>> int mmu_idx,
>>>>    #endif
>>>>
>>>>    static const TCGCPUOps hexagon_tcg_ops = {
>>>> -    /* MTTCG not yet supported: require strict ordering */
>>>>        .guest_default_memory_order = TCG_MO_ALL,
>>>> -    .mttcg_supported = false,
>>>> +    .mttcg_supported = true,
>>>>        .initialize = hexagon_translate_init,
>>>>        .translate_code = hexagon_translate_code,
>>>>        .get_tb_cpu_state = hexagon_get_tb_cpu_state,
>>>
>>> Please commit this change as a separate patch, explaining why
>>> we can do that in the description.
>>
>> I think I'll drop it for now, and revisit after this series.
> 
> It basically means supporting atomic instructions and memory barriers 
> correctly. From what I saw, memory barriers are nop at the moment.

Sure. When I meant is such change also affecting user emulation should
not be buried in a commit only mentioning softmmu changes.


