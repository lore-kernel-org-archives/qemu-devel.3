Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA867F4180F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdCB-0003Bh-1s; Mon, 09 Mar 2026 12:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdBl-00031X-D9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:10:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdBh-0002qb-Hk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:10:35 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-358ed696623so4917420a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773072632; x=1773677432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OZNavs60TcJqGoR3lruQxu1imrBKLWomSBgv7FNFYz4=;
 b=LOPRQmVonkjq5Kg0vJJqeE9oGngBb4LRCgfg8YyvuwZfrBv8g45Xq5RlxwnuVyWDiu
 W64dbmX29p25zqxVoNEfpJX53tgxs7FrCN/aajWQYfqFsAcCvIq2gaayp96EjPl+K5pg
 Plq+1wFV597gfWsZaYWH9hhWvkwGSrsLICzZ6Tr/oofThBlG+aKrb8a/L4u60HiJYxye
 3sT5o2gS0GSYXN51sNpbvTiFtYtGSNrUJooLdeGBwVqup9vGP8MUAV5iJ1LWGHXGGQka
 FDJctr3NpJUj6SXnQbCbQQkhky0kkm89/z7Roy+FvSXRre9dk5RJmmZ/NVJAn9q7oxFW
 MqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773072632; x=1773677432;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZNavs60TcJqGoR3lruQxu1imrBKLWomSBgv7FNFYz4=;
 b=Hgvumvp7d+bK9ozeKjR96xYra+HUOnpvuMelppOF3tXAJp3T9zBWy8mN9uayIiQUgg
 rlx0YuRJw6wYjLbpIP9mSDc4NMWa+XFcb3On2XfPUvV46FeTVJ0Sw4Dp4sCbL69iia90
 /vadidrWEFeixK2/1TZ+MLOouY8nEzGazt4wFKH3tK0OOa/7jRpcO1hwCus29edLr/FB
 KOnQJQ4hGfk+HYtUeIjoDixZKCSXjKLQgWzLRg8YHGQe9eeoJPLcjN0q5uo5xC/1s0cj
 0IkU+t4ivmccYNn7bsTgG37R7Y6C8vplLYWGy4ycfDCS70QlWDnwUmMr9/JMacCD/mBP
 mRtQ==
X-Gm-Message-State: AOJu0Yw//AIVHc91JUsAmDcB+V0EQE0AfijUroGsJvUzUmgenl9GRwMw
 tSlJc6JnmQCD29wOVEVMJuQvRMWsodyIJIQJkdIxhVoIMQZBKQXcYO2ExPFj1L4KQmg=
X-Gm-Gg: ATEYQzyZ24sVRL250qwmRYZ5jePp1ERuzz3bvKvCsZ6VzDiHQwyzhDewgVEcsSy1ir7
 BxGgZDWa0drlyXgxIQWIJeq3XVOR/YdtvlnxX9cH64nH+V3xNGIxVJknYtmNiFgg9mqMyIAkfkJ
 gSn1dOfhKv7wCa8JzJc8UBau7mdYvlBqVT1YYRvD06HvLa1Bgvg45bsOzl5eA6RC4wDqzTTcyA1
 1uMCyotGDtNGrI9qEpqQNLEkQ3lRwRO77J0zonhAW65QgAIqIpgGrD8oQrQUnUN8QC5INm5O9pf
 1Rdr6x95CAKXdvRfiZ1S5O5UXH8u8r3vTifqTPUlH7h9Ot0XaIZE5flOmyr4qUKL0EDJbHVZd3v
 o9UfMbau4+SUNeQi4iS8Jb+s8zg04JJh71b5tGMARUfNVi/YkwJCljEtUe1s2JYHZIXNQtj7szN
 ahBLt70XSS9k9XOpeGhVMsVGht+A5d863+eEzHa0sNNqC4eN1znaq08DL+H8h68NfW2wSE
X-Received: by 2002:a17:90b:4d88:b0:359:8055:df63 with SMTP id
 98e67ed59e1d1-359be15449amr11058660a91.0.1773072631801; 
 Mon, 09 Mar 2026 09:10:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359f0827f96sm57182a91.15.2026.03.09.09.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:10:31 -0700 (PDT)
Message-ID: <c1958cfc-06d0-49db-8e4e-a0c848fca9e0@linaro.org>
Date: Mon, 9 Mar 2026 09:10:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: leaks in migration-test
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
 <321e8b29-7879-4778-8734-0c2a6a2dadf3@linaro.org>
 <CAFEAcA-zd=k0xioNOKgpe6hAsY76ux04=VkHeQWkngkBnTXTVw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA-zd=k0xioNOKgpe6hAsY76ux04=VkHeQWkngkBnTXTVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/9/26 2:42 AM, Peter Maydell wrote:
> On Sun, 8 Mar 2026 at 23:42, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/8/26 12:22 PM, Peter Maydell wrote:
>>> I'm continuing to work through leaks reported during "make check".
>>> Some of them come from the migration-test. (For these to actually
>>> appear in the log you need to run with QTEST_LOG=1, otherwise the
>>> migration test framework will send stderr to /dev/null and the
>>> tests will fail without printing the leak report.)
>>>
>>> I did find this comment in qmp_migrate_incoming():
>>>
>>>        * NOTE: QEMU _might_ leak this refcount in some failure paths, but
>>>        * that's OK.  This is the minimum change we need to at least making
>>>        * sure success case is clean on the refcount.  We can try harder to
>>>        * make it accurate for any kind of failures, but it might be an
>>>        * overkill and doesn't bring us much benefit.
>>>
>>> The issue with this is that it means we need to suppress leak
>>> reports in the whole migration-test binary, which means the
>>> migration code will get no leak-detection coverage at all.
>>> (Not all the leak paths have qmp_migrate_incoming() in their backtrace,
>>> as you can see below.)
>>>
>>> We're getting pretty close to being able to get a complete "make check"
>>> run with the leak sanitizer enabled, so it would be nice to not have
>>> to suppress leak reports for this test at some point.
>>>
>>
>> That's a nice thing in itself.
>>
>> Is the end goal is to enable that in CI? If not, I doubt there is a
>> strong value in reaching that state today. You'll run out of steam and
>> motivation to fix that yourself in the end.
>> Same goes for all other sanitizer errors.
> 
> Yes, I'd like to be able to get this into CI at some point.
> I periodically have a look through some of these things and
> whittle down the number of failures.
>

That's great to hear that. In the past, I used to run sanitized builds 
also but lost motivation chasing and fixing new bugs added upstream. I 
tried to push the idea a few times to add in CI but comments were 
usually "we don't want to spend CI minutes on that", so that's great to 
see this change coming from you.

If we can reach a stable state and enforce it in CI for all tests + 
check-tcg, this would be a really good thing for QEMU community.

Regards,
Pierrick

