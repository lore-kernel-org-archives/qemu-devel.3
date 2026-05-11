Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE223CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUjp-0000qp-BM; Mon, 11 May 2026 13:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMUjU-0000o5-Ev
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:48:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMUjL-0008Bc-Ey
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:47:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso2585244f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778521666; x=1779126466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DHcDi5C+Qz5FFXCMxfbXpKHJ+Q6v0sF55OEfInDpCYI=;
 b=doABnVU+T1BeOgJQSHrgdtHQ8KtSAi9onHsdcGzCATCxtaqtPYTj9iwT0ku4v0um94
 h26CPAm68i8OEHUjAtfAuKt5Nl3jAflghlw4EtF5hwVvQamNLa6mBQeIU0dSTFgA/SrB
 DrrBqS7b99XmN3n8EMu25ltBLkrHfYNxBas49GyEHvAwhHBnkLWgi408isFRycOPsAhR
 ihrV/YG0w9W+0H7es32I6rNBaaJWsZP+6dYFdkVQy1dHCAAchOfKI4chsZdh1eDqHfN+
 Ddl/79TDkSAbR3Exq7ckNUz6Bbd0IyoDUNdDsJcumWXSLBxXx2QS9z+gmfsvv3nZ1rCn
 Xz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778521666; x=1779126466;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHcDi5C+Qz5FFXCMxfbXpKHJ+Q6v0sF55OEfInDpCYI=;
 b=YBB10MVbkC5aJ+8CyWKFx/fWOJCj/dGxV4On/zUwVG3l6mkp8qMCkgmHMwz3zMbyAm
 iMT+xAkw3nUF0sS/XE4YVHp0h6yAw/DEGqoPs+nTzNS4/6WlyWXrXm0mf0NAQuNdb1/N
 +qv1IKOuiE+Xmc7cdODUeF7WyWuJ2vfXnhmTltrBmmeJ7B30f+9Eq+idWIfpBl1Vvon9
 Md5UVWMwPciQdRvCNhAuUTgynJ+w4D4jJxrmgTCtG4FkmO4LkeG61Myh56morW64LeV/
 F8/KeLiz6a24/pVZEDF6cOCwzNtDCJ5RksXy5ADQwAbKKGR0O4aSSPSLrx11+n+HSBfa
 fEAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ813BbfDUqK2CeaKdiDPDA7Rf+rNqDQ83rBj1h8UP8EU3lOAqgDm5T7FwnmpaR4UckQOodsr3PA/wZ2@nongnu.org
X-Gm-Message-State: AOJu0Yzsw/3MPGmKzpGKcyq5uTz0d+5Ts9+jcPZ0TGelleK/5ix+XQAR
 TOMzsCkuIo9hYqPQQK0ikevLZcViuiHc5t5fRF8WMD7wbPnr9fiUm+dCTSg29KzZkc4=
X-Gm-Gg: Acq92OER1ydWZkYLlCxQCRQgtTDnj7+BiHv22hJLKshNPeKlnZHgvXzCjYj1/ACROAC
 7vZYgdL9Ma3usZsgMJv6DR7s7Uw42dNC3a/zhBXs7AsMEl7erp3Ipx30ga2ktRvDrUsq7mFUC0T
 g6mro6CEEIY/5wbpjWWzG8MpM/CCE8Ts6w0d9Uuv7NZkiWe0xnbIfproZ/1iLPaXWjQsmOj2sdV
 naLQiC9UoFvkkik71hFEkZv+1EAyYnO8dM2GXNEjXkmP473s1n5zVC0bC2bC68HAVWAjLw8dhTU
 bw0YnofMDllcYnUCrnxL4gQQL81+hId3lMSzOn3uKSd00bzgIN0fsnD572NN34W8FHxgDuU2tUc
 J0hy1FKFNMEEMIjBxyBl+kl28FCda3vFXy8151MfZ2cw8DiT8uRBwMT7Kd3iq+zm8+dNzp2jnPG
 wp2f/EB/rIiuMLPc491SBGuJx8goDoEgBBjuDmEpc3qiU0YHhw+ENqamHOJbVJq+50cg==
X-Received: by 2002:a05:600c:4194:b0:48a:7965:b92a with SMTP id
 5b1f17b1804b1-48e51f53980mr267498485e9.26.1778521665748; 
 Mon, 11 May 2026 10:47:45 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6db1e6e9sm67129935e9.35.2026.05.11.10.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 10:47:45 -0700 (PDT)
Message-ID: <3b5ff524-75d6-41d0-949d-39bbff0558bb@linaro.org>
Date: Mon, 11 May 2026 19:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
 <40f3f863-04fe-4eb5-9672-a21ae4fca950@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <40f3f863-04fe-4eb5-9672-a21ae4fca950@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 11/5/26 18:36, Cédric Le Goater wrote:
> On 5/11/26 17:58, Eric Farman wrote:
>> On Mon, 2026-05-11 at 17:48 +0200, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>>> Introduce a source set common to system / user. Start it
>>>> with the files built in both sets: 'cpu_models_user.c'
>>>> and 'gdbstub.c' No logical change intended.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>>
>>> This change introduced a regression with PCI passthrough which
>>> stopped working. Guest kernel reports :
>>>
>>>     [    0.156501] zpci: PCI is not supported because CPU facilities 
>>> 69 or 71 are not available
>>>
>>> and other devices (ap, ccw) are impacted too I think.
>>>
>>>> ---
>>>>    target/s390x/meson.build | 25 +++++++++++++------------
>>>>    1 file changed, 13 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/target/s390x/meson.build b/target/s390x/meson.build
>>>> index 6f98ce34d73..44f58ac2919 100644
>>>> --- a/target/s390x/meson.build
>>>> +++ b/target/s390x/meson.build
>>>> @@ -1,4 +1,9 @@
>>>>    s390x_ss = ss.source_set()
>>>> +s390x_common_ss = ss.source_set()
>>>> +s390x_common_system_ss = ss.source_set()
>>>> +s390x_system_ss = ss.source_set()
>>>> +s390x_user_ss = ss.source_set()
>>>> +
>>>>    s390x_ss.add(files(
>>>>      'cpu.c',
>>>>      'cpu_features.c',
>>>> @@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
>>>>                                   capture: true,
>>>>                                   command: gen_features)
>>>> -s390x_ss.add(gen_features_h)
>>>> +s390x_common_ss.add(gen_features_h)
>>>> +s390x_common_ss.add(files(
>>>> +  'cpu_models_user.c',
>>>> +  'gdbstub.c',
>>>> +))
>>>> -s390x_system_ss = ss.source_set()
>>>>    s390x_system_ss.add(files(
>>>>      'ioinst.c',
>>>>    ))
>>>> -s390x_common_system_ss = ss.source_set()
>>>> -s390x_common_system_ss.add(gen_features_h)
>>>>    s390x_common_system_ss.add(files(
>>>>      'helper.c',
>>>>      'arch_dump.c',
>>>> @@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
>>>>      'mmu_helper.c',
>>>>      'sigp.c',
>>>>      'cpu-system.c',
>>>> -  'cpu_models_system.c',
>>>
>>> This file is compiled anymore and the CPU features and facilities are
>>> not propagated to the guest anymore.
>>>
>>> Without this patch, cpuinfo reports :
>>>
>>>     features    : esan3 zarch stfle msa ldisp eimm dfp edat etf3eh 
>>> highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2 nnpa
>>>     facilities      : 0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 
>>> 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 
>>> 45 47 48 49 50 51 52 53 54 57 58 59 60 61 64 65 69 71 72 73 74 75 76 
>>> 77 78 80 81 82 129 130 131 133 134 135 138 139 140 146 147 148 150 
>>> 151 152 155 156 165 192 193 194 196 197
>>>
>>> with :
>>>
>>>     features    : esan3 zarch stfle msa ldisp eimm dfp edat etf3eh 
>>> highgprs te vx vxd vxe gs vxe2 vxp sort dflt vxp2
>>>     acilities      : 0 1 2 3 4 6 7 8 9 10 11 13 14 16 17 18 19 20 21 
>>> 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46 
>>> 47 48 49 50 51 52 53 54 55 57 58 59 60 61 64 72 73 74 75 76 77 78 80 
>>> 81 82 129 130 131 133 134 135 138 139 146 147 148 150 151 152 155 192
>>>
>>
>> Thanks, Cedric... I wonder if the above is addressed by this patch? (I 
>> haven't checked yet, but will
>> do that now.)
>>
>> https://lore.kernel.org/qemu-devel/20260510204640.2178926-1- 
>> marcandre.lureau@redhat.com/
> 
> Something like below seems to work.
> 
> C.
> 
> 
> @@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-feat
> 
>   s390x_common_ss.add(gen_features_h)
>   s390x_common_ss.add(files(
> -  'cpu_models_user.c',
>     'gdbstub.c',
>   ))
> 
> @@ -38,8 +37,11 @@ s390x_common_system_ss.add(files(
>     'mmu_helper.c',
>     'sigp.c',
>     'cpu-system.c',
> +  'cpu_models_system.c',
>   ))
> 
> +s390x_user_ss.add(files('cpu_models_user.c'))
> +
>   subdir('tcg')
>   subdir('kvm')

Right. I wonder how I could screw that change...


