Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4481AEE4998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLyN-0000kf-O2; Wed, 11 Sep 2024 07:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soLyK-0000jt-Sb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:57:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soLyJ-0004LK-0S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:57:20 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so7162153a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726055837; x=1726660637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pg5YMNJRiIGyb2ZY+MUlv00SEY2QhFQa9iUPP4b+d3M=;
 b=R4eVPdcYLgZjl5mitMpk/f9NYsriWuCAi2TspS+tCI6Dolt3sS5ang3mLA/ea6bLgg
 W0XCTka3pe5dhPuY70YeDzL2bxzix4kNFtYzHBiZnoWZrb95L1n/xCSR89hRmjWLBK6S
 vzf+VVcPAAC5fDHNMpl21nYw4yWxZmBjtUb/ZaFiw4flCdHRhSMOovM820+6A8L6neXW
 +jy3w9nFmIm0iTKW/8sBtdTg6keRrOdLgrB0NoBz3KexGv3SgitfZi5zFzcTUGcsucB3
 6xN5I91zrTZtTAdow3zy0gcQTRC6DmIDdHEg70PB5bfGyjf/OeOyCizKnZwPrJDeaQK8
 ptxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726055837; x=1726660637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pg5YMNJRiIGyb2ZY+MUlv00SEY2QhFQa9iUPP4b+d3M=;
 b=Dqha52Ko7UgMIkIGEF2rDAQT7WZkIuqO/IZlUSqyhStuBMsu4jYiMhpoPa01D/xPSf
 PXj2D/+7toBgcVSOGDL8pHZayW03bYtb5scJ3hvE3nlhtWSvalBZIL+vSnJpvfjy4ZXA
 8HpScQWAdCcy4OH67Z+nhstnwxJx8mJHvw0pqBMNa9Gibe704n+Pa02zmv3+AApSM7OR
 /3y/wJToExvzs5RgHDLuxPXCTMUkddgUS4ZGDCii6ZpjnnX9VjuZ4MnhmyB5l+w1/sBT
 0ReBCVSrv6f9HheWpcbf+je2oPJ679+3qLzZrnqqkQTeNzzL4W3Dgzaeb7dHHrndSN3w
 BqEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrQ4DYYtJkftEuydlL9ydVikLw0pGNTPojHZfGmW4QgYP1llevX2ZvYUWNWiGPZW7Kp/oJCKAlHv9K@nongnu.org
X-Gm-Message-State: AOJu0YzViqyJdgMibc3CBB13cDoLhS1M9cSn1zJp3rW/yIWPfBtMZsxj
 LN8SjMsI7mzLotixEjNzPS66il31mIzCa7Cn7BZni7KzI4SYVe+4UBMsI+mOYnc=
X-Google-Smtp-Source: AGHT+IFDh0e/ExrG4nL2mQYuDclUHjTJfsWPkHB67mO6YKUw+MdCxdjy7A7h0cD4chvncVKJRC3nug==
X-Received: by 2002:a17:907:3e21:b0:a8d:439d:5c3c with SMTP id
 a640c23a62f3a-a8ffaaad23dmr408799366b.8.1726055836503; 
 Wed, 11 Sep 2024 04:57:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a901292f81esm52055366b.1.2024.09.11.04.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 04:57:15 -0700 (PDT)
Message-ID: <7b536856-3155-432b-95b0-e03f96a0808e@linaro.org>
Date: Wed, 11 Sep 2024 13:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
 <20240909061552.6122-1-vr_qemu@t-online.de>
 <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
 <69b15684-0d00-4a74-aeac-2d98f7e88d95@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <69b15684-0d00-4a74-aeac-2d98f7e88d95@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Hi Volker,

On 9/9/24 21:38, Volker Rümelin wrote:
> Am 09.09.24 um 09:26 schrieb Marc-André Lureau:
>> Hi
>>
>> On Mon, Sep 9, 2024 at 10:22 AM Volker Rümelin <vr_qemu@t-online.de> wrote:
>>> Windows only:
>>>
>>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>>> level keyboard hook procedure to grab the left and right Windows
>>> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
>>>
>>> Because the QEMU Windows keyboard hook procedure is still needed
>>> to filter out the special left Control key event for every Alt Gr
>>> key event, it's important to install the two keyboard hook
>>> procedures in the following order. First the SDL2 procedure, then
>>> the QEMU procedure.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
>>> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>>> ---
>>>   ui/sdl2.c           | 53 ++++++++++++++++++++++++++++++---------------
>>>   ui/win32-kbd-hook.c |  3 +++
>>>   2 files changed, 38 insertions(+), 18 deletions(-)


>> Note: there is no 2.16 release. They jumped from 2.0.22 to 2.24 (see
>> https://github.com/libsdl-org/SDL/releases/tag/release-2.24.0)
> 
> Hi Marc-André
> 
> Oh. This means that the comparison I wrote is true for SDL2 versions <
> 2.24.0.
> 
>>
>> The windows hook was indeed added in 2.0.16, released on Aug 10, 2021.
>>
>> Given the distribution nature of the Windows binaries, I think we
>> could simply depend on a much recent version without worrying about
>> compatibility with < 2.0.16. This would help reduce the potential
>> combinations of versions and bugs reports.
> 
> Okay, I'll send a version 2 patch series.

Queuing patches 2 & 3 meanwhile. Please do not bury series within
threads, if Bernhard hadn't sent his T-b tag, I'd have missed it.

Regards,

Phil.

