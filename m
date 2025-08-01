Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9ECC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuYq-0007HE-FU; Fri, 01 Aug 2025 14:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uht6p-0001zc-MX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:59:55 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uht6m-0006rL-8E
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:59:54 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b3f80661991so2519904a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754067590; x=1754672390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VAZ4XoaTRapKmm6L4RCNYvG/OA4d9eoLUWvP4rbKHc=;
 b=Wuq+xss+QLsFo8QBzlzpBsYY3D9P0+KtExoIuqz10Dx3Xto3LUDjetM9bA1tEDRPdG
 c++70CdAJo7v7EfKwwpdwN8H2FSGD1r+11+i0JiphfcZH+a7awbwN4p6Snofa3unYsEX
 h/43MU3E78xTq1+yiol8kHjW9yCDzly99qMTIvlaiy6Sx5KJzW6qaQXZVpkQOktImU0N
 XaulGXaIIGfHUMklVfIOQ661xFlZrgOvzOKoynJgJV2n1ylKJsnGzas8t653gdwyJlpc
 yUjg5rh3A8p3pPdMI4YInup1vSkuFC5LvhZeq0bEI/gNIfdQ7T0OwDfOl3dDV1XxdMkW
 rLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754067590; x=1754672390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VAZ4XoaTRapKmm6L4RCNYvG/OA4d9eoLUWvP4rbKHc=;
 b=trcywMpu9cgI36gCw9wHPLROSDiO3o5CgFZQ2oSbEzLOyHMj4+JjM8ydwXw4y1d6HG
 h+n+C8zkbsP0SVdC68PYggsWgdbW8uoP95lxVMmqQEbtW7g4Tqw5tx8mAUYmProPi3lo
 JoE7WjDLmkQEleExp/676LWjLq87TK3DbaC3BU/QPBc/E0qpuSzmxDrdTP1IGWiAQqAz
 QNiLQi2Mm7VmCo0pWtyWUIcU4zyNUGIl6SCto4Uf2XaNjHg3e9eBZ8Ybj4wvqJ4c715R
 ektSWX+YZHH2dCmSTC+n40Tgq61mnFQPZ1QNMCRfqq0WEp33OiYw7ZoU71iRx77frh82
 xlfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Mc9FD+kH3OrPYE5fvg/Vw2x2//G/yKOcTFDc6MR6mKjbNSjkToHPwPxvKWkO3Nf3qZAGig1dv12M@nongnu.org
X-Gm-Message-State: AOJu0YzZNgDaE24v5HX9mvAbMBpMY1sYy5u+hNEGajrNmXIvjNA/Dnz0
 auzr2ZGR0lBuV3OInKqQdiMftfqIRIEpzuP2pW2j0WkMqV9iPbPZsFtHf6+SUWlxPNw=
X-Gm-Gg: ASbGncs/SfV29lzC0+g2c4zd6Bz09/mci3+y0+hsY3QxU/D6YFHzn7luhE1AcvxHG7v
 Yqjs5v1qQqul3K95LyH8QazsLhRiV4I+E1fgoxwH1jPtt3zZKl65krHKMAUWPitEBNGRLZ65s44
 Oxd3L+lha70hxDFY1gcc2lp2o/LKYg8nN0tY1WbJf1FWgPPBIBmF2P8iARhKPZKggdEnQY1oxKZ
 4QpOdDdrrlDmb2IQqc8ZRgwLsyzzy3L6p58lLOXm68kd4SdWoYKpYHP0kyNYZSoU93VGt9WbaxX
 Ou7eSlDMI1yUXpXCS5DlEO9rK409HtdT1lHUyPw++YpmhxVKh2hlEf3R62ukB75OKdpllbLNuPc
 ZxjGCkg4rvHhCD0ZLihaeyuIZckooGrHCNUvqCC9t+mGJSA==
X-Google-Smtp-Source: AGHT+IFa1zmKmt/7JQvvBQhtm+VAozO4d4iAODHIhqKjwxec5hT/Rr/eWGKQ50uofO/uji9ylyCKrg==
X-Received: by 2002:a17:90b:1645:b0:30e:e9f1:8447 with SMTP id
 98e67ed59e1d1-320da596a1fmr8856493a91.4.1754067590475; 
 Fri, 01 Aug 2025 09:59:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32102a77576sm1346454a91.2.2025.08.01.09.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:59:50 -0700 (PDT)
Message-ID: <9790a6fe-1f5b-4d4c-a40f-6188b17d05c5@linaro.org>
Date: Fri, 1 Aug 2025 09:59:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
 <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
 <CAFEAcA8qHUT-0k6chAFZ61J=YZ7xLvhYgqsgtQiCgkfaxfFRxg@mail.gmail.com>
 <034c953f-dce6-4068-8f93-05e758e67703@linaro.org>
 <CAFEAcA9H4WtVUuEX8kf8LiHQ3Z421Fq3ukbLnCRRfUKLyRF6QA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9H4WtVUuEX8kf8LiHQ3Z421Fq3ukbLnCRRfUKLyRF6QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/1/25 9:38 AM, Peter Maydell wrote:
> On Fri, 1 Aug 2025 at 17:31, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/1/25 1:34 AM, Peter Maydell wrote:
>>> On Thu, 31 Jul 2025 at 19:30, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>> Regarding the "modern" completion support, I recommend you take a look
>>>> at it. Even though you wrote or reviewed most of the code you navigate
>>>> in everyday, and thus don't need it, it has become a standard tool for
>>>> any developer, like sanitizers or omniscient debugging. It's especially
>>>> interesting since those tools are based on compilers (clangd is the
>>>> standard for C/C++ nowadays) and not a bunch of clunky regexps.
>>>> It's even more interesting when you learn a new language, like Rust.
>>>
>>> I do actually have clangd enabled at the moment in emacs:
>>> but my experience is not good, because typically what happens
>>> is that clangd runs itself out of memory and falls over
>>> fairly frequently, or it produces obscure error messages like
>>> "LSP :: Error from the Language Server: trying to get AST for
>>> non-added document (Invalid Parameter)"...
>>>
>>> So I mostly continue to investigate code the way I always have
>>> done, with grep.
>>>
>>
>> By any chance, are you using an old version of clangd (or an old
>> distro)? It has been a few years since I didn't run into any issue with
>> it, and it's quite easy to update it using llvm apt repositories without
>> updating your whole system [1].
> 
> I use the Ubuntu 24.04 version. In general I try to avoid
> using tooling that isn't packaged by the distro: it
> tends to result in headaches later on.
>

You should be good with it I think.
Maybe you can try to delete clangd caches, in case there is a problem there:
- ~/.cache/clangd/index/
- (in qemu build folder): build/.cache/clangd/index

> -- PMM


