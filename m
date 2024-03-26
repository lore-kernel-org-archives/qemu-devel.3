Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5530ECD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6G0-00021T-J2; Tue, 26 Mar 2024 08:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp6Fx-00021B-ON
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:50:22 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp6Fv-0003X2-0H
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:50:21 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so3080528a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711457417; x=1712062217;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HD8bTh4SKj8kWMpYV27yBYsr6pw/gXEO7hM8oeGvcbY=;
 b=naxMFgS2dHUTc6nozrgAg0IMWRepAo/GnWr9vC6pohDqzEmzXXmJgRr5WxAmt12/Px
 88UoP5ReBaXqFnGTQuAEGJw0xpIpi0i7tIRnk/AfIol7Ju18GluobbF8kUNyOC370z75
 G+HP+sNq3hNP+CqDKOTDBH7BWLskJx2hb2LFM1y/rfA8DBLLiC4CRsLzOesOL5DbjMSR
 Uy+cupZpCs3J2XHLXProR9x8CBCzBPem+XPZgAXvSsQG5jj0yAmF8AVEuCjjLgqZ37GA
 RmqhhglCReymGTeBZje3SgCb0Q2I72Y/WT3AHDDVD6W2w7S1hAITZrvxpbSCPip0s/OV
 AEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711457417; x=1712062217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HD8bTh4SKj8kWMpYV27yBYsr6pw/gXEO7hM8oeGvcbY=;
 b=i/MB/VJMaAQxLxJ7+Futmt3PNZA1Hc4rZe0zvyF/FXpkrfP+wWlY/YIHvKFGjcUOpS
 N0+AVLWszMv42C66OR7MpDte58f91wnkl3uk3fOEyGfSn8aM/brGyiRtHphk5EaWQD0f
 IjcLJCf3MGXWUmH27/cZ9jddGPNRh0+Yj61HlNjHEgL9VrygYFdija7F31XMYjAdADyM
 20hjRs74enhnfqqKsIfVvnxwjhfUzUCWzOu2b6sCek4pKAhN/03HbjH3CQ//SQpAmvGK
 g5GEMn26NFeYrqYX9lJuiB3479LMN/LaJ+hc7H5bcC9/AfkdrFrCPaCFfMxLVePw6A/4
 2EXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhIPLUv1Apoz9buysiBXXkOO39VV5QxfVNA1wyDO02Q2oT27O6Xhupvtv8gTh7/fYkRYM0rcxtvK9EpZlE8WZlmx98QuY=
X-Gm-Message-State: AOJu0YzKCiyMpYctkw70N0+Y63SFjpLZZURPVZ1VcfuYtQv1qc+LPEpQ
 Je68MgQR0xFe8EV8cnVLzQEmIkAo23InlzwdVBczVEljZhvO5DcV+LjuBpy7S5M=
X-Google-Smtp-Source: AGHT+IHG/U03BbGPOtwZPbEQcNLo5qDeQT9JHJUzkBw98y9Pe/AQrgkLEEDmQFPFVa7nuDLOLTnu7Q==
X-Received: by 2002:a05:6a20:3d0b:b0:1a3:d60c:f16d with SMTP id
 y11-20020a056a203d0b00b001a3d60cf16dmr1808840pzi.51.1711457416941; 
 Tue, 26 Mar 2024 05:50:16 -0700 (PDT)
Received: from [157.82.202.248] ([157.82.202.248])
 by smtp.gmail.com with ESMTPSA id
 r18-20020aa78b92000000b006e647716b6esm6110428pfd.149.2024.03.26.05.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:50:16 -0700 (PDT)
Message-ID: <f2686686-70f6-41e6-998c-d54e8480a8d4@daynix.com>
Date: Tue, 26 Mar 2024 21:50:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.1 v2 1/2] buildsys: Bump known good meson version to
 v1.4.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
 <20240326-meson-v2-1-d9f9003775e9@daynix.com>
 <CAFEAcA8JF35A5o-+F39sXFnkTDnPo29A7zCZgxFPt3388sVvig@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA8JF35A5o-+F39sXFnkTDnPo29A7zCZgxFPt3388sVvig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/03/26 21:40, Peter Maydell wrote:
> On Tue, 26 Mar 2024 at 12:35, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> We need meson v1.4.0 to fix MESONINTROSPECT quoting on Windows:
>> https://github.com/mesonbuild/meson/pull/12807
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   python/scripts/vendor.py                   |   4 ++--
>>   python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
>>   python/wheels/meson-1.4.0-py3-none-any.whl | Bin 0 -> 935471 bytes
>>   pythondeps.toml                            |   2 +-
>>   4 files changed, 3 insertions(+), 3 deletions(-)
> 
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -19,7 +19,7 @@
>>
>>   [meson]
>>   # The install key should match the version in python/wheels/
>> -meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
>> +meson = { accepted = ">=0.63.0", installed = "1.4.0", canary = "meson" }
> 
> If we need 1.4.0 why does this still say we accept anything 0.63.0
> or better ?
> 
> If we use shlex.split(), does that go wrong for pre-1.4.0
> meson only on Windows, or is it broken for all platforms?

It is only needed for Windows.

> (i.e. could we if we wanted to make the requirement
> "1.4.0 for windows, 0.63.0 for others"?)

I just followed what commit 1a1e889f3576 ("buildsys: Bump known good 
meson version to v1.2.3") did, which don't bump the accepted version.

But certainly we can do better and conditionally ensure meson==1.4.0 on 
Windows in the configure script as commit edc210789500 ("python: use 
vendored tomli") does.

Regards,
Akihiko Odaki

> 
> thanks
> -- PMM

