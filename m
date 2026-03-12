Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C06106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0odV-0005aY-3o; Thu, 12 Mar 2026 18:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0odS-0005aJ-U0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:36:06 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0odQ-0008Vi-6J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:36:06 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-50917417efbso13829201cf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773354962; x=1773959762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7/f2XhvYKuQnuLaITTj/nhCxq4dCAMUs84kWHd2RjhM=;
 b=H5tTbho/2wx7P21OxqSFASKhnSQYqhZluEAG3miWOIP/3EHLLEGfPuQLjL9Ds3NXel
 JRvSwJLwKb23Wc4h8zHllQh2ZbP2EZEXWDYbkdNqaWry8xWlOG22WqD1pgUdwtvHDf/J
 NfrDtK6OOFGiCZew5O+kEGEID6LKOjrDzBlmwoHNDmk+LVsy/tcnronpT1vJlzhvTtaq
 fGjruvIvuSk5xQVuRAvWK5OJsWYz25Zz+xI3KdtFJMP/fnVnx8CTXKJF6EvZ/+Vs4QBH
 bzIfHQfB8g3y4TY83har+paEfbgbKpT8GwNXCweWbkCz/mZQab5so+u00GvUR5hpPhdw
 da7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773354962; x=1773959762;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/f2XhvYKuQnuLaITTj/nhCxq4dCAMUs84kWHd2RjhM=;
 b=CzW2nXjNfbeqWjU+bR9UpEH62j9EczR+n2hVJXDLlrfAujtdi3JqYzhvXZPHmzBrmz
 wxD5lAmNjCE2MWjGaYQ6yQ7SB8Woxh5Zx4OmWoLp1PmERIYuSX8biGIuf2WQUfFo81JM
 kBFDby2qVm1nxjbXKHiR2obzPc2mw5gR68QPcSduFZEt5Tab0KPfclXj8ov0HVRZnRvf
 3G164MHSgU8/m02oYQUyE2g/XH7gghLo4hDrxg4HmDo5QPcvezTiTOTVTUs5Q+4gpD8y
 MIyBkw+L7Nbl3WqdrR1peajpmXb92pYvC5g8Y0044/BrDxnnFmFULxI41L2H34CA8VMk
 Z1XA==
X-Gm-Message-State: AOJu0YxZSbnDL/yz5dYVg4Ru8UfbCcr/rAVRCkb++FoFC8Uf9YUPvFcF
 ir8YXcJHtgR4buslq6ujqtNh9/v66K6cu3NQ3SPhJqFpZ+lzRijyE4xFK5AFfrbeaJY=
X-Gm-Gg: ATEYQzySlcC5Ypg9WSdWPA6OjUmFd8ZrAHZs5LQq8LcqDCEKqAcH0g3pjvwpWDcg+rd
 wdeaNB42DuGjhBk58JA1O9fBn6zG2Zry56juerz2hsAFaq1OOtlDLAPiKCjRJ/EjpUy89CoSNf5
 AE1brTasUfUVJPj5K5PA4yRvxm136UHdU89oWT/fheAnNq0kWfQgGmeJBGE6jb6ZUyVM4hGudI+
 iLgGCNTs0tHk9l6fj+615OHq1mQkTMtyMS5kyBEQ0MPPtIPdzSJtu628vPhHOC8+pxoeczC8ANH
 gzARFp2mv6yZTt1Gymj28c/Rm0HmmUNhuSuW1PZkITIxwkHqP+QVjErG9hwWZZBd10Z/NKNu8Z/
 8OGm4jsjWpjWzyubROoZkhOrk9/PK5BuPwe3F6N5CSl/k9fDMcwcWPLiz1kWVZ3uxTd8/kZH0/M
 2LNmxTBfJDUB+49F8JWBkrSw1WzBs1u7KdpX4zcqvO0Rxam9syDzTKC2aUSWfbJCp2Zpwk
X-Received: by 2002:a05:622a:202:b0:509:1688:f8cf with SMTP id
 d75a77b69052e-50956fd88ecmr19797461cf.0.1773354962452; 
 Thu, 12 Mar 2026 15:36:02 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a14d7a6sm40501051cf.33.2026.03.12.15.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 15:36:02 -0700 (PDT)
Message-ID: <68903178-92ef-4956-b815-dc4c4533507d@linaro.org>
Date: Thu, 12 Mar 2026 15:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
 <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
 <CANCZdfo8cEp8_078o4bEwCo63vL+W5NW9ukeQR0nMACJBQXysw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CANCZdfo8cEp8_078o4bEwCo63vL+W5NW9ukeQR0nMACJBQXysw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x82e.google.com
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

On 3/12/26 1:19 PM, Warner Losh wrote:
> 
> 
> On Thu, Mar 12, 2026 at 11:52 AM Pierrick Bouvier 
> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> wrote:
> 
>     On 3/12/26 6:10 AM, Warner Losh wrote:
>      > thunk.c is the same between linux-user and bsd-user (out of tree),
>      > so share it between the two.
>      >
>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>      > ---
>      > As part of upstream blitz bsd-user, I've discovered that bsd-user and
>      > linux-user have the same thunk.c file. Rather than copy it, put
>     it into
>      > the common-user directory and share it. It has to be compiled
>      > per-target, unlike the rest of common-user, so modify linux-user and
>      > bsd-user to grab it from there.
>      > ---
>      >   bsd-user/meson.build                | 1 +
>      >   {linux-user => common-user}/thunk.c | 0
>      >   linux-user/meson.build              | 2 +-
>      >   3 files changed, 2 insertions(+), 1 deletion(-)
>      >
> 
>     Indeed, thunk.c seems to be highly target specific.
>     A good solution would be to move common functions to common-user/
>     thunk.c
>     and the rest in include/user/thunk.h. It may be cleaner than doing the
>     meson hack. Or leave it duplicated for now, except if you plan on
>     modifying it.
> 
> 
> My concern with leaving it duplicated is the process. I create a patch 
> to create
> bsd-user/thunk.c that's a verbatim copy of linux-user/thunk.c. Despite 
> putting in
> my cover that this is copied code, if past is prologue, then I'll be 
> asked to fix the
> copyright and style, plus lots of suggestions to improve the code. But 
> it's just a
> verbatim copy, so that's a lot of hassle just to copy it.
>

I understand, and it's a good intention to want to remove this 
duplication. However, I'm not convinced a build system hack is better 
than a duplication.

> Moving like this, though, is almost 0 friction. A small tweak to meson 
> is all that's
> needed. I suppose I could do the #include "../linux-user/trunk.c" trick 
> to make it
> less ugly in the build system, but then it's not clear it's shared, etc 
> and more ugly
> in the code, imho.
>

Yes, it's a hack, that's what it's for, "quick and that works but not a 
proper solution".

> I tried to move this stuff into thunk.h as much as possible so we could 
> have one
> compilation, and that didn't work. It really assumes that it can include 
> qemu.h for
> the tswap, etc macros. So it's impossible to just build once.
>

Yes, not all functions can be compiled once because they have target 
dependencies. That's why I invited you to simply extract common 
functions to common-user/thunk.c and leave the target specific bits in 
thunk.h (with static inline functions), or in a thunk-target.h header if 
you really want to do it cleanly. That's the proper solution here.

Build systems and preprocessor are not a shortcut to proper software 
architecture, even though QEMU abused both of them to this end.

> Now looking at the code, a lot of it would be a lot simpler with 
> 'Generic', but that's
> a battle for another day. As is the notion of just generating this data 
> from the .h files
> rather than hard-coding it here, but that too is a battle for another 
> day. I'd like to
> get this upstreamed so I'm spending my time on these sorts of battle.s
>

I totally get it, and we have been dealing with a lot of things like 
this for the single-binary topic, trying to find the good compromises 
between refactoring APIs and doing limited changes.

If extracting the common and target part looks like too much work, just 
leave it and simply change the copyright header, it's not a big thing to 
do, and you can modify both in the same series, no one will yell at you 
for changing comments in one file in linux-user.

As you said, pick up the right battles and ignore the rest.

> Warner

Regards,
Pierrick

