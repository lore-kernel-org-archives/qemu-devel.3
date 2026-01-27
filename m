Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3088D2FEDB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknpC-0004Rz-7G; Tue, 27 Jan 2026 13:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vknnl-0001YL-Is
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:36 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vknnh-0003QA-62
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:30 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso920413b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769538508; x=1770143308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vguqAVHyuwIrEnmQnJJZkhK57X3O96Nx9cNl4BzWvMQ=;
 b=qTDM6HJ6L+PqkZnGYMxqPJeozJnsitEPA1SsIzh48lUORiJgjw/IJ1YO2jKByOfvEe
 HjU3qoOqiA7uLIFNX6QSwYTYGyeMXvowLCfumm6y+TympUgxOMn8AmwM7yPMDJH7h8Tv
 wjRrjSgXLvWv/bymM27M3//6pmjULqiDx0LlsdnjzJVb7/PLi8+wUgNuiT4ETWxs2P1T
 g5+PrEibfg/Jk2PE9FiffYPqUN6xBiR9DRT9C4dgN7FWjWyIkhagcjUdjrwRmoCa4ZFJ
 mBBZ3fOZdeWgYb0kVcL8pQIkHVRLARjOMQVrY7z0Rvcj6SIsHj5uJtBl1l1P5gtY2WOZ
 JiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769538508; x=1770143308;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vguqAVHyuwIrEnmQnJJZkhK57X3O96Nx9cNl4BzWvMQ=;
 b=Wx+tc9b17EuQNJEND0f2OmZNqZ3tHiggPUYFT/6PfkaPPzTBQ6ITkX4a1tQFqfIUia
 KxuzsC+GEs5sBwCZXqds05IXI9MZtfo4mJbHXFgPdSBqtVeVYTY2q985qtY1d5sHEva5
 GuwvxV6NeZ+QH9CMPgseEZXhRwdAkGBWi5tZ2sAbWOO+JVMhyVdStUL2htv6kw+rbjY5
 lrQwIu11bEfBHSl2P4+pDkJB4UrSWyr0xnu5jFnKyhbajiinH8ZT7J0txXSkpwce0GQ6
 HuwLUjHmdfEcFgFgOj9kRj6CfK7qbPwrLjHTmCe9H3T+ttM667EKpi2uF0loQqYtifOZ
 MPyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXztiq6Bd2Y58yFIe/XjGnbgWDUC5zVcpaIf/bcgzpKWMEJn7mLquFOyazYJf1ZNmYWqqNolu2FOVRJ@nongnu.org
X-Gm-Message-State: AOJu0Yzp2onyYhzBcXL2JXmuPn1qF0is+idB+02u3RM/Mw6SBJOkWyRx
 uHuQQX5U07wnaDhZNv1KunXMJw0kRlSCArgjRAHLYgJlP82wMu8i78G404z7NgGAXZo=
X-Gm-Gg: AZuq6aI3ZQ3zrm1KIALmavx4V2P0C6uFXf/JozVgnzvQH6tw22SqyqPhrUiBZx950qm
 tbV+fo5C58qr2LSG5reF3EjKRM0FgTARKSR1jdUV4c3ofPkk/NFubPEac+04kNGw6psXkZaH5zW
 8zSjLncthnDEnqVKC8SEQodmz70emnooyvZGBnD3+lU+gx2vNDYxi8u29VOLHtL5aNck/BtKTOH
 eYDFsPb0SP+HhIOazjBDnlXWj4+xN9RwfCIeMRim1WF9KuCg2JDv5VeLpN2eYhtOyU+HSVMsNN4
 WE/5K0DqEhiFj+sBxTL4K+LkbS35Hnqe2cPL0xI1BU7UILoJA7AY03IEa7MUmQNY2SL8quKTsAZ
 TMTAhfoSet4wmHbsvgwVJVy1Xw30ZGXPDGSA4bmOvqKe9H4GdxK8wG34Z+nd9QaXqhseRpOOdJ2
 CJqEI/ZYSGvM23+8GM4aKCFohlRKVxWnDM9yo6XszE9hsD1xYCn/3Oe2Ek
X-Received: by 2002:a05:6a00:240a:b0:821:7e53:5627 with SMTP id
 d2e1a72fcca58-8236928ed34mr2296852b3a.39.1769538507487; 
 Tue, 27 Jan 2026 10:28:27 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b4c197sm258500b3a.20.2026.01.27.10.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 10:28:27 -0800 (PST)
Message-ID: <4be05e70-323d-42c9-84fb-b66e5579a1ed@linaro.org>
Date: Tue, 27 Jan 2026 10:28:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitlab docker registries
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87ecncc4sg.fsf@draig.linaro.org>
 <90520ad2-8256-4bc7-94e3-010455659394@linaro.org>
 <878qdjcslb.fsf@draig.linaro.org>
 <7574812c-c200-49bf-8367-927c3cc7295b@linaro.org>
 <87qzrac46p.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87qzrac46p.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/27/26 10:15 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 1/27/26 1:28 AM, Alex Bennée wrote:
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> On 1/27/26 10:50, Alex Bennée wrote:
>>>>> I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
>>>>> wasm64) because we base the tests of the existence of dockerfiles and it
>>>>> now generates multiple targets.
>>>>> Do we actually use the wasm32 stuff anymore? Maybe we can just
>>>>> rename it?
>>>>
>>>> All of the wasm32 stuff is supposed to be gone.
>>> I think 20260127092745.2978371-1-alex.bennee@linaro.org should fix
>>> it,
>>> but I need to re-read how to trigger the weekly build on my test branch
>>> to test it.
>>>
>>>>
>>>> r~
>>>
>>
>> What if docker-verify was depending on building the container locally
>> instead? It would allow to have a self-contained command, that works
>> the same in local, or in CI, without any yaml dependencies.
>>
>> With current approach, it's tricky to reproduce locally as it depends
>> on global gitlab registry, while we are just trying to see if images
>> is buildable from scratch or not.
> 
> No - the point of verify was to check we where building in the
> registry.
>

Hum, I'm not sure what "building in the registry" means. Containers are 
always built locally then (optionally) pushed to a given registry.

If you want to test something useful, it has to be a build from scratch 
(docker build --no-cache ...).

> A lot of the Makefile.include stuff is legacy now (although its a useful
> wrapper for building tests locally) because gitlab invokes the
> containers directly. We used to do all sorts of dependency handling as
> well but the lcitool approach is a lot cleaner even if we don't get
> layered containers.
>

The commit message for 8bec7b9874 is:
```
gitlab: add a weekly container building job
This will hopefully catch containers that break because of upstream 
changes as well as keep the container cache fresh.
```

IMHO, a simple weekly job doing what we want is:
docker build --no-cache - < $dockerfile

I don't see what is the relation with gitlab, lcitool or Makefile.

Maybe I miss some extra insights or goals that were not documented in 
original commit, but it seems like the current implementation is not 
aware of what it's supposed to do.

