Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70241EE499B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soM0T-0007eT-V4; Wed, 11 Sep 2024 07:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soM0R-0007V8-Ra
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:59:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soM0Q-0004RY-2B
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:59:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so234261166b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726055968; x=1726660768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DtQAx8OaozkY4yZNQU9I0jXmxEdovJDgJqF2SHO0Nr4=;
 b=s+MZQRN6elJG3zrDFK9LN95Di7OMJwwNb7DUaBZwcFw4IwjGSfQ71xW0ZEpCCTs10X
 pgUVgMUDvdkpRELao9LoaeQkYcxyMITJSkn5ltvdb2D3sXhNfz9til6HDYkUcSW8AcQQ
 WPKuYgVT2JxcOL3FQBNRn+blBxQ/57gj7P6k4GwQNPMbjrmUpDGgfRiYi1XTfZOZc4Mc
 urTxYEaJu9gGZBz9l/5/0YaRbRjb9qkGbFJWvMSSWEqJedACcAjeJQXze4C3mvmPeR59
 JeAAUpAS7AnDbh8dYzELWexYG/9RWv3RVHlTtyTqqer2kofVPC7f5VzO5kpJkqyT/6l3
 /K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726055968; x=1726660768;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DtQAx8OaozkY4yZNQU9I0jXmxEdovJDgJqF2SHO0Nr4=;
 b=Ad+7A0c1WTlgANiIkWNgv1um/p4A4j4U9h90J/deYvPL7Aw7SzN8oFabH2vJ2Ym2ds
 ynRW89UgOyzM/7eofl+XXcd0ifOAIQKEYD6vnnP8dZ0ydtezCYYaOwI4aMRBEhFSu62h
 Yn9FQkRNL9fP5tZMpI2z9wKRCHQveGE+ms0yoZgg5b9hrJFUyv3UmLc+GlPy2panrWn6
 A2AkCMePY6ZQQXSdn16P0sp+zhQjkxIRnRFdO9pgU8obukzUC7Tt4kQmN/Va5pnq1XVO
 jnRxc8mg3TG6ofDMCe6SwA6cksvWKBqNalLaL9i0nv3oOzjjZk/uvKBtM+Sma3EOkyIZ
 1aEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJU+fs8BIBZRnSU75HkwL/l0GB+K2YuY+kAJj2kmo07S/TYeb976i2pJc8ImvZO2FWmB+aieE2p+Wi@nongnu.org
X-Gm-Message-State: AOJu0Yy3IwoBsp3Cq/xLNCrInC6gen6y9ORTZY0AxiCJ7bI7Z1/NXru8
 TQMCc6Y/zq9yPOm/80iGwRKtWg5PSvUZCsIrn6LHKF4uzH1foTOW3V4kHZ+Nyk8=
X-Google-Smtp-Source: AGHT+IHVZbyx9mlnhM1Edrt3sLKUed78gt74QqKtS9Ub7/12ICsWjj7WRzF7ojLTJ9XLzFJA82M6RQ==
X-Received: by 2002:a17:907:9483:b0:a8a:7549:2a30 with SMTP id
 a640c23a62f3a-a9004a99171mr247084766b.63.1726055967829; 
 Wed, 11 Sep 2024 04:59:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d400afsm607392366b.189.2024.09.11.04.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 04:59:27 -0700 (PDT)
Message-ID: <1e160bbe-f16a-4396-9f73-e9a6cab91fd9@linaro.org>
Date: Wed, 11 Sep 2024 13:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
 <20240909061552.6122-1-vr_qemu@t-online.de>
 <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
 <69b15684-0d00-4a74-aeac-2d98f7e88d95@t-online.de>
 <7b536856-3155-432b-95b0-e03f96a0808e@linaro.org>
Content-Language: en-US
In-Reply-To: <7b536856-3155-432b-95b0-e03f96a0808e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 11/9/24 13:57, Philippe Mathieu-Daudé wrote:
> Hi Volker,
> 
> On 9/9/24 21:38, Volker Rümelin wrote:
>> Am 09.09.24 um 09:26 schrieb Marc-André Lureau:
>>> Hi
>>>
>>> On Mon, Sep 9, 2024 at 10:22 AM Volker Rümelin <vr_qemu@t-online.de> 
>>> wrote:
>>>> Windows only:
>>>>
>>>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>>>> level keyboard hook procedure to grab the left and right Windows
>>>> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
>>>>
>>>> Because the QEMU Windows keyboard hook procedure is still needed
>>>> to filter out the special left Control key event for every Alt Gr
>>>> key event, it's important to install the two keyboard hook
>>>> procedures in the following order. First the SDL2 procedure, then
>>>> the QEMU procedure.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
>>>> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>>>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>>>> ---
>>>>   ui/sdl2.c           | 53 
>>>> ++++++++++++++++++++++++++++++---------------
>>>>   ui/win32-kbd-hook.c |  3 +++
>>>>   2 files changed, 38 insertions(+), 18 deletions(-)
> 
> 
>>> Note: there is no 2.16 release. They jumped from 2.0.22 to 2.24 (see
>>> https://github.com/libsdl-org/SDL/releases/tag/release-2.24.0)
>>
>> Hi Marc-André
>>
>> Oh. This means that the comparison I wrote is true for SDL2 versions <
>> 2.24.0.
>>
>>>
>>> The windows hook was indeed added in 2.0.16, released on Aug 10, 2021.
>>>
>>> Given the distribution nature of the Windows binaries, I think we
>>> could simply depend on a much recent version without worrying about
>>> compatibility with < 2.0.16. This would help reduce the potential
>>> combinations of versions and bugs reports.
>>
>> Okay, I'll send a version 2 patch series.
> 
> Queuing patches 2 & 3 meanwhile. Please do not bury series within
> threads, if Bernhard hadn't sent his T-b tag, I'd have missed it.

Oh actually this is a series with a cover, but the cover subject
doesn't contains 'PATCH' which is why my git tool missed it.


