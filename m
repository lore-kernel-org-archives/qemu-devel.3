Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C769CA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhk5v-0002r4-6G; Mon, 19 Jan 2026 02:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhk5t-0002lz-2l
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:54:37 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhk5r-0004oT-GU
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:54:36 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so25888315ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 23:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768809273; x=1769414073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BHcqT8fmGMZPLrE9bCz2PMYzfC6jQO0b0+45gNyPNzY=;
 b=gsk9PTonwwpST9DxZYsFnaqZp10W78YPjM7mf0GYxomxy/Dl0w1bYztoDX0dkdI9yF
 S1PoK586/GrCt35Nis/oAG0Z4vO60kjtH4v8a0XiedcY2O3sfPwSD/+jOiHzrub0+hqi
 siF1EIVnJCcBaNNfIKoC1BYZ4NxbeAfvBsm//9GkII+IOP2Vyho/3D1w8HNov7GMp1Bh
 A6zPU6ed0mbPjgJQBpi+t4EEnesYJBNjlA31PBWRhyzLMFa6ZC76FW2tXN2on5xIvNb2
 KFCmv1GYJ8C1XP4BjIFbBREng5kVuYmmk6y9HitcytHJQpVEcLZpGPj/21v3ZdtQMFwl
 fjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768809273; x=1769414073;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHcqT8fmGMZPLrE9bCz2PMYzfC6jQO0b0+45gNyPNzY=;
 b=g10CAGNOqUiX42GSGIMuLWFk5PqbJ+UWBX0hEOxPTTAb9UcIxapEx1r9bs5/daOQ5u
 IfkN4Np7SCPLp5hIu+dVAuMnhEPEbrbWF9FLh7OhLmE/3KT7Bc65bhKtdgDKXwH3EA3f
 B9D082saDWJYs1N4AaWOo8Gni92PiI/XUrP0ABL7J/QBIrANZjQTQQGdhYtHXExauqKU
 KBex+hcqMnUpKvfOZGVVneO02XDbmEafuDL/yCiOzmB41c/KCEGC+1XnvMotSHS+qgTv
 GsuIpHfi4Z5wZ4yzaC8Ng9JZFDTQgUhTq7lz5hyxf68RUpA85g8eaqhychWE2Xk4e6eD
 uwng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE8Q2vUvUYNGqjNJIXBxK0uMuc+f2TPWWFg5uWze4ybptlPNW9AwJ6akzWEOk4ehJKneskhtc+GLzH@nongnu.org
X-Gm-Message-State: AOJu0Yyy/PQKEuhH3c0wivsXN+SpPXMyRe8xZqorUaFe71sSHNQzFAL6
 geCVfjlSGVFQ0r4tbrTq3vu3fMLxpJPCRlhCB9tBVWQ1OJX0JNCs03l5yQam8I/unwo=
X-Gm-Gg: AZuq6aLktN+CdZnuCK9EMcu/UsfrNSU7auhoN2errfd0kTTEJkoR9tFHUQ6kJVWJdZk
 x5ugbd65KIJVWwOCpf9Z88h8iDO+CHEMDDRNL23XeeDmyXxFaIaUCXtWKwtpbkvNtVOJ5fkXLrJ
 1ISN1+WiAgCU3aERMg4Hhn2MbJow8n+/5sskmxYECQZC3390oOlarRG2C6vDf4x4y/ZoHiP3Rds
 aDfCohcmLaNN/I67WF+dvEu0MYq/Wqg2AdAz8TGalasLJKlHmYMj2U6BmMdDcvEyEkGBIUR/zUP
 OWxmJxF52f374G523rkZRBT7slnGw6yWHPUMHaFraqdU5rscrTX4VG0BNbs0eHs7PRR2BqfNGg4
 xns1zDecih3ReVL58nEbYgU42B9DE8whCCNN+SFjeSe0FHXlDJlNE44iKApEsN+6J0b/91aEFZe
 4GHjSzhfwgLzvFYyyvZK73fx4ikrW1oA==
X-Received: by 2002:a17:903:41d2:b0:295:9627:8cbd with SMTP id
 d9443c01a7336-2a7175a5cbemr98275805ad.33.1768809273460; 
 Sun, 18 Jan 2026 23:54:33 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190abc62sm84920395ad.2.2026.01.18.23.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 23:54:33 -0800 (PST)
Message-ID: <e2b00c96-ecc2-4c47-9bc9-77957e9ba5ae@linaro.org>
Date: Mon, 19 Jan 2026 18:54:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 7/7] rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-11-mjt@tls.msk.ru>
 <5fa1630e-e557-4e23-adf6-3bdf695c81fe@linaro.org>
 <f795a93f-fcf4-4aba-952b-dbf53e3876c8@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f795a93f-fcf4-4aba-952b-dbf53e3876c8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/19/26 18:50, Michael Tokarev wrote:
> On 1/19/26 04:28, Richard Henderson wrote:
>> On 1/14/26 00:00, Michael Tokarev wrote:
>>> Since CONFIG_EPOLL is now unused, it's okay to
>>> perform this rename, to make it less ugly.
>>>
>>> Since epoll is linux-specific and is always
>>> present, we might as well make CONFIG_EPOLL equal
>>> to CONFIG_LINUX.
>>>
>>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>>> ---
>>>   meson.build      | 2 +-
>>>   util/aio-posix.h | 4 ++--
>>>   util/meson.build | 2 +-
>>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index f8b4f06049..552b34f34e 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2713,7 +2713,7 @@ config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
>>>   # has_header_symbol
>>>   config_host_data.set('CONFIG_BLKZONED',
>>>                        cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
>>> -config_host_data.set('CONFIG_EPOLL_CREATE1',
>>> +config_host_data.set('CONFIG_EPOLL',
>>>                        cc.has_header_symbol('sys/epoll.h', 'epoll_create1'))
>>
>> This is present in glibc 2.9, which is required.
>> Therefore you can drop this bit of configuration as well.
> 
> It's a bit more tricky, see my comment in the patch description
> above.  Yes, epoll_create1 is now always present *on linux*.
> But this particular test (cc.has_header_symbol) is run on all
> platforms, not only on linux.  So if we drop this test, we'll
> have to alias CONFIG_EPOLL to CONFIG_LINUX.  Because epoll is
> used outside of linux-user too (eg in the main loop), and there,
> the test is CONFIG_EPOLL, not CONFIG_LINUX.
> 
> So it might be possible to replace this test with something
> like
> 
>   config_host_data.set('CONFIG_EPOLL', config_host_data.get('CONFIG_LINUX')
> 
> but not drop it entirely.

 From the patch description, I had expected s/CONFIG_EPOLL/CONFIG_LINUX/.


r~

