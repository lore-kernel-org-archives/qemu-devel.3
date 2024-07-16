Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E5C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjsT-00010Y-Qb; Tue, 16 Jul 2024 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sTjsQ-0000yl-HB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:14:02 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sTjsN-00069x-TK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:14:02 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b0d0a7a56so4255833b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721142838; x=1721747638; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxdKLwiszjoWg7E5lJOQHiqf4Bh0YUwQE7ZoZ+voD+g=;
 b=bc40/hEj215ZGYHeeKbAIur2v5ufcwUIfEe9/J/60PP5SjoZpnzvBxVuO4ySxjZ1Tj
 OGzkA/ojzQ1LaCZXDw9rZxNVdI2a1m4m4EVDH/bAFHBl16DrwRKsLY1dwY/KiEP8AZ48
 ROMEzeWi7uqbxxNEAHzt2XrtNWqyRM7+9Y9sqKocL6OKlWc+ARGPBuuuEgZhu6v5aoS3
 BQDa/HIw9dxMEeWRs/LlPdlpRkBLsQt+nnaUioBD7yy413E67GCGKxkEjkS3oEVEavfx
 fXcv12gdOvEoNibLIfblYShNijpqCjDxNq+8GDPFzrpvfM7DCn05RFRJ03NSgGVs1V2e
 HkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721142838; x=1721747638;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LxdKLwiszjoWg7E5lJOQHiqf4Bh0YUwQE7ZoZ+voD+g=;
 b=m5gdhU30XTLW+yh2JWTpxPAYFCY9Lp4/mtUDYYYvrf7cpiVVEDWmC2Fr3vqkAkLLfn
 J2xEU+n/wqgaXNajZvFPZCLg77kGWA7zWZAYqoaiXpEPMg8rGn3nKZQdXpOyYCXLSyqo
 VBpxL5s6eci6Q/EkjMyxS/U3GCsc+i6Hk7nBmm/6s7/e64X02pDd2MXNAupH5eC4ggtL
 PbpQfFw0oNWaF4H+eWCgMTPkh24aHpkwybT1ko9cw2iqD/b5JT8FYQ67GlwvLuQAHNzz
 QKqOuyAj9tO/mfN3hNYxY8ln6L5xW29F8mvXrY9VJpAdTJpJfnG5V4FQA/y6FE2w9IST
 p8Xg==
X-Gm-Message-State: AOJu0YzIUnYcGG836Eg7fq8xSU/1UUgjeo2WWL3ej6mZsNL7wcXvG8i7
 SBP5F6R9R9sZi3MJDFtGs+5Le8YX4D6g79EBI7zzuaz65wPp5hSGkuqtdt5MAQV86fMzw1VVqg8
 C
X-Google-Smtp-Source: AGHT+IGnNrEKD6Q5Hn3VFNNS2UoOXEKZsuX2yoRfbjmrSOKF1x8tocdHohmYAdbqA+41ZaGj7D1lNg==
X-Received: by 2002:a05:6a20:2589:b0:1c2:8cc4:908f with SMTP id
 adf61e73a8af0-1c3f12b3814mr2997985637.48.1721142837676; 
 Tue, 16 Jul 2024 08:13:57 -0700 (PDT)
Received: from [192.168.0.102] (201-1-50-128.dsl.telesp.net.br. [201.1.50.128])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd706349sm8400448a91.57.2024.07.16.08.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 08:13:57 -0700 (PDT)
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9690162-170e-1f74-f148-0642a8503002@linaro.org>
 <87plrdh2i3.fsf@draig.linaro.org>
 <CAFEAcA8+KXykmmk_4BU990kj3nY4xfr0zn2MtM0cYTuhNnsWtg@mail.gmail.com>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <1a40f484-18bd-c452-fbba-4e59e2b07294@linaro.org>
Date: Tue, 16 Jul 2024 12:13:53 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+KXykmmk_4BU990kj3nY4xfr0zn2MtM0cYTuhNnsWtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.356,
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

Hi Peter,

On 7/16/24 11:09 AM, Peter Maydell wrote:
> On Tue, 16 Jul 2024 at 14:48, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>
>>> Hi Alex,
>>>
>>> On 7/16/24 8:42 AM, Alex Bennée wrote:
>>>> Coverity reported a memory leak (CID 1549757) in this code and its
>>>> admittedly rather clumsy handling of extending the command table.
>>>> Instead of handing over a full array of the commands lets use the
>>>> lighter weight GPtrArray and simply test for the presence of each
>>>> entry as we go. This avoids complications of transferring ownership of
>>>> arrays and keeps the final command entries as static entries in the
>>>> target code.
>>> How did you run Coverity to find the leak? I'm wondering what's the
>>> quickest way to check it next time.
>>
>> Coverity is only run in the cloud on the released build. There is a
>> container somewhere but I don't know how its used.
> 
> The Coverity cloud stuff comes in two parts:
>   (1) you build locally with the Coverity tools, which creates
> a big opaque build-artefact
>   (2) you upload that artefact to the cloud server, and the
> actual analysis happens on the cloud
> 
> The container stuff and the integration with the Gitlab CI
> is there for the sole purpose of automating the "local build
> and upload" steps. You can't do an analysis-run locally.
> (Well, you probably can if you have the paid-for commercial
> version of the tooling, but we haven't got any kind of
> setup for doing that.)
> 
> We only do analysis runs on head-of-git because the Coverity Scan
> resource limits for open source projects give us about one
> complete scan a day. So this is all "after the fact" stuff.
> Developers who want to look at the scan results can create
> an account via https://scan.coverity.com/projects/qemu .
> Triaging new coverity reports is a bit tedious because there
> are a ton of false positives...

Thanks for the explanation!


Cheers,
Gustavo

