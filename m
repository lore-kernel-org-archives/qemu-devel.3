Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D9DD1CA01
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85GD-00015d-Hl; Mon, 04 Nov 2024 17:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85GA-00015P-7t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:09:18 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85G3-0002aj-8e
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:09:17 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c805a0753so44217815ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730758149; x=1731362949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yViXbQ+WvUh4bfyB5NhQsb0nG3LCjW3eaqKV1EXoMk8=;
 b=H/+vByaKt/B//o5AEDaSGBF5jdS/0RQcajtXY0U5onk73K5FfPS99cj0bPJAPczYs7
 ICKBQxHzvKhsq6USvU775RF4GJ7TrrPJrgdSzvzVAegpcu4BwHdiWUgGNdqNo8JcMS5n
 qNmmrNSD1ARQDs7RStSKoSVNBa+EO9cDDmoJZqnTx+rgHP5RvqHDO9HW26NxDF2FnZ6p
 N5QX91wB/fgaxBWMC88ZK60CVR3om/Z5FZL5ox7mg3F0cFtkOZor7pZU+JT2+iu9ckV0
 DrPDKjJ68/DI3A5XX6yxj5TLPvWSclNiGr8cEIRyYBSfkaTSBe+gLNoYrnylAmyMOABS
 h0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730758149; x=1731362949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yViXbQ+WvUh4bfyB5NhQsb0nG3LCjW3eaqKV1EXoMk8=;
 b=CILpL/6rnbYYDKzcncoZD8aeAQ+kPvSgOkuVSb8h6HlumGXW8h7Rl05AHlq4EhnKIR
 /yItw8MzEXk8xtQyYm+ZQu15Hpvjz5hzphBat4yKJtah2yJXG5ZyPucGbI+obi5QXlbm
 EXPx83TgWQmY7cHvfby/kVDmeP7sXm6ySrSQzDWFIkHDCpHgmu1oRx2zpz8eGh89RIoJ
 tilk8gCyQSSlZA/lnE/CRj0izjgiZ3Kfvvrk/h9E22hI1YyXsYsofhNrjV8Jy6gQXE8e
 ns7dljdFDDXW5zl2qi9wrWl2G3qZ+KVQtmZOMxVUGCdDUsXuywzWYbjWb+u6RTCN1RdC
 JQcw==
X-Gm-Message-State: AOJu0YywGiHYXzrlZJZqGLkXmACWkMu08WGAQcKb/w1d1FZAfmFOIIeB
 rR4D3IUsmSY5i/HZ9DLqgxsaW8xzr6jSR8gBZ+b9f7SRffVD+tfNGqwy2320wUc=
X-Google-Smtp-Source: AGHT+IEuh38OZ14yQaYOiSXKrfa+K20PlWRGzB1fJkHI/xbWG2wxqCTy4V8apf7mR5DV94qICJzw7w==
X-Received: by 2002:a17:903:4404:b0:20c:b810:13a5 with SMTP id
 d9443c01a7336-210c68ca8a8mr383994775ad.21.1730758149454; 
 Mon, 04 Nov 2024 14:09:09 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm65589985ad.70.2024.11.04.14.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:09:08 -0800 (PST)
Message-ID: <583055e0-9e07-466d-965e-1948fcfecc26@linaro.org>
Date: Mon, 4 Nov 2024 14:09:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] docs: add information on how to setup build
 environments
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-13-pierrick.bouvier@linaro.org>
 <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
 <20241104110814-mutt-send-email-mst@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241104110814-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/4/24 08:08, Michael S. Tsirkin wrote:
> On Mon, Nov 04, 2024 at 03:58:19PM +0000, Peter Maydell wrote:
>> On Thu, 31 Oct 2024 at 04:07, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> MacOS and Linux are straightforward, but Windows needs a bit more
>>> details.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> We have documentation on the wiki currently about how to
>> build on various platforms:
>>
>> https://wiki.qemu.org/Hosts/Linux
>> https://wiki.qemu.org/Hosts/Mac
>> https://wiki.qemu.org/Hosts/W32
>>
>> I agree that we ought to move this into the main documentation.
>> Some of the information in those wiki pages is probably
>> out of date, but some of it looks like useful extra detail
>> that we could incorporate here.
> 
> Also, as that wiki notes:
> 
> 32 bit Linux target on a 64 bit Linux host would be useful for build bots
> 

IMHO, and regarding my previous message, I don't think adding details 
about cross compilation would help new comers.
Cross compilation is specific, and most of the people who do it know how 
to do it. Especially when setting up a build bot.
In more, we already have a docker container for this use case 
(debian-i686-cross), without needing to play with host machine.

> 
> 
>>> ---
>>>   docs/about/build-platforms.rst |   4 +-
>>>   docs/devel/build-system.rst    | 100 +++++++++++++++++++++++++++++++++
>>
>> I don't think this is the best place to put this information.
>> "How do I build from source?" is a question that most beginning
>> developers and some end users will have. The information in
>> build-system.rst is mostly about the internals of our
>> build system and how to modify it, which is a more niche topic.
>>
>> I would be inclined to put this in a new file, maybe even
>> in docs/about/ rather than docs/devel.
>>
>> thanks
>> -- PMM
> 

