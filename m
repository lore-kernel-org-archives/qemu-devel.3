Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605A1109C028
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5PzF-0004TD-S6; Wed, 25 Mar 2026 11:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Pz2-0004MX-92
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:32 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Pz0-0007cB-67
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:23 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso3663457a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451840; x=1775056640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wbryKCxevC3WrevA7QfcVwX53hdSBEPvdsDR5WNEfgo=;
 b=oXdW37rLa45sHpEfbHU29hMfgetEqteUWfOBLpmYDgFzGY+b+gDfSK3GUNaEsy7TkV
 POB11JGenr/lZF1vR4v5TPyGRKWLrOkDD75yXmrG29HG5wdlr/RG0dW/PjfC457NUf97
 76D9UOZaoyjr/zSu2dd4XmOrIy/hjSRo71IkPpJgyZ0QcwAb/wHbcDZpIJ59KpUStddP
 C7UxaEjbAxvtzKMoOWqmnH/5sG2Jbn8/UYuUtT6hJAcGdyI8m1xSTvcQR1hTjvUq8TWG
 /V50jazLQoLgOu82DwIGyhaTY9cYsyFUIjmbEQflbO/pA+NMSDWpl6PEB9ivMiG+0s33
 lQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451840; x=1775056640;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbryKCxevC3WrevA7QfcVwX53hdSBEPvdsDR5WNEfgo=;
 b=YfJrP2H/yeDcFDsQlflUa4Csg6HioWFcOQdZVVnCVPsdGULDwoSs8+l4CFRzttyo9l
 KKYwwUW6BWAd9yUQAvHnegKXn8jU1mMulP+FFiHsO6WXWP3UuIrVKMJYmzsuESOc4GCB
 kuIley8KJeCYp1zJblp18AGd1pFAxd3SNkNoKgTvsPqY66tGF5g2LyMgQjqbtxUwp2Dp
 kLL/LRQthd1GajpcV0/jFJloP9lm3aWwVU1D5ypUzrl38VYDKNhOnB5chJxPbmNQgU5T
 9uW26UOYMS8IsIMrFSiDezktI44ba+aBwliPtnp8yrVj0sMLDVnw3QD0LaIQWS/cKIUB
 i/Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlzETIkTlYleOCsKZElQtcZ59ABqJTK8Gz7/fotvYvPbein/evI6fNdzRo2UdoLzNrIQbpeCAH+3pv@nongnu.org
X-Gm-Message-State: AOJu0YxPN0yfmWHo0Hru5prqJ/uK2Vbnip7G6WIJfdysrDaIIjp0l3/E
 kb5W8tEUERKXpewxa0MRPQyqwD3L7HPZa6x4YW0cDygdY4N9J1Mndf2epWA0RjKlEIo=
X-Gm-Gg: ATEYQzy+B23wwEX2XjW6QliMVa5PfIclaeZY9brf8vRlYf5d0G/DJp4wM+9V3BMV+ik
 p23iC5yPpV9AtKjMiOgFCneA6BAi4jP/h1JZxT3YxcMOJrkAcnfQsi5oH2JRtJ4Cu2q5b/3Zh1n
 qyXqKsIvS2JOqyGpAz2M/r/PIV9nGHtpflNEFWUHZMYFK56hJTCgcXA8zOq5YpL5RAWqMKW0cRF
 4/wr/fQBvBRQFCl446sfWABfreuPpwQW/zMvadkV8T0jeT04UiDhV49EiY1De/uxOINGTE/iWWm
 zKCAXOxuLkkBvkNznCgdDFb/5+3h2+ZGMGazygySavdkydvIfBT2E0I4yiuG4Hcuv3olH1F3iY2
 0qJKt6Hf61H2S0JVYwDjMBMG/Wt8uAgj+Vp6V38MHjCAp+yXIR9serC8mwqtWDdSijpZ3BRKOe1
 Sh79PdZDHdQUmbvW+Kw6bvKirZH39tamS3KapZWlxHQxEBpgU4QW0/JED3hMKl9WfCOOpe
X-Received: by 2002:a17:90b:582d:b0:35b:947d:9fca with SMTP id
 98e67ed59e1d1-35c0ddb224bmr3575657a91.19.1774451840160; 
 Wed, 25 Mar 2026 08:17:20 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c1a045860sm184990a91.6.2026.03.25.08.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:17:19 -0700 (PDT)
Message-ID: <f81e71f3-fe15-459a-9c27-2aea1592d155@linaro.org>
Date: Wed, 25 Mar 2026 08:17:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cleaning up contrib/ and tools/
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
 <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
 <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
 <878qbg410i.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <878qbg410i.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/25/26 4:11 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 3/24/26 11:33 AM, Peter Maydell wrote:
>>> On Tue, 24 Mar 2026 at 18:28, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> On 3/24/26 10:09 AM, Peter Maydell wrote:
>>>>> And for contrib/, easy ones first:
>>>>>     * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>>>>>     * contrib/elf2dmp moves to tools/
>>>>>     * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>>>>>     * contrib/plugins moves to plugins/plugins (or a different subdir
>>>>>       name of your choice)
>>>>>
>>>>
>>>> I would suggest plugins/contrib or plugins/community, to make clear they
>>>> are the community contributed ones.
>>>> @Alex, do you have a different suggestion/preference?
>>> I firmly do not want us to have anything that claims to be
>>> "contrib" or "community" or similar. Everything in QEMU is
>>> community contributed in some sense. Either we care about
>>> and maintain these plugins, in which case call them "plugins",
>>> or we do not in fact care about and maintain them, in which
>>> case delete them. "In the tree but not maintained" is not
>>> a category I think we should have, and that is what "contrib"
>>> generally implies.
>>>
>>
>> We make sure they build, and test them (manually) on changes. The only
>> difference with tests/tcg/plugins is that those are used for make
>> check-tcg. I personnally consider both of them as properly maintained.
> 
> They are maintained.
> 
> The aim have having these more complete plugins in the source tree was
> to ensure they where updated as APIs change as well as provide useful
> tools compared to the more toy like implementations we use for
> check-tcg.
> 
> I'm not sure about having them directly in the plugins folder as their
> implementation is meant to be separated from the core QEMU code itself.
> Maybe tools/plugins?

Fine for me.
Peter, is that ok for you too?

> 
> While we are at it we should consider moving the example plugin descriptions
> from About/Emulation/TCG Plugins to the Tools section.
>

Yes, good idea.

>>
>>>> Moving those sources will break build folder hierarchy also, which is an
>>>> issue for all existing binaries built from contrib anyway.
>>>> I'm not sure there is anything sane to do to fix that except accepting
>>>> the breaking change.
>>> What are we breaking here ? Nothing outside QEMU ought to be
>>> depending on the layout of our source tree. When we move things
>>> around we'll update the meson.build and the documentation.
>>> I don't think we have 'contrib' in our installed-locations
>>> layout (tools get installed into the bin/ dir, for instance),
>>> but I might have missed something.
>>>
>>
>> I was thinking more about users that might have custom scripts using
>> various contrib plugins, or using vhost-* binaries or ivshmem-server
>> or elf2dmp. They will be relocated because meson automatically uses
>> layout of sources in build folder.
>> It's not a big deal anyway.
>>
>>> -- PMM
>>
>> Regards,
>> Pierrick
> 


