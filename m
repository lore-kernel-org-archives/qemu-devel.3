Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4409BC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOQj-0007BI-Ud; Tue, 06 Feb 2024 11:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOQd-00070H-LN
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:36:12 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOQW-0003EU-FR
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:36:11 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fdd65a9bdso16919615e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707237362; x=1707842162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkMb2EUV24/uMXpVQHUiUuNQtIBp3iL3/qe44nI5hZE=;
 b=dOO5vgbft78eKNiUZTXT2fouIaIlv7ZqutqIJFwFLbIIHfCqeKXMfIybWMRmr29/4N
 4kXyIN38HasRpbgIFo9J/+zyAsm0r/k+0WpeTS+dJdF1KnZ8tHBEbk+9+onhTeWYfP9v
 XZpyArIGpPKiolPoEjiUaTpunsK335JqPgKQiY0HWEDIKR2zFa0+WJIlpOyfMIM/foSL
 G0wxGPb+yGqCvGmh4+FU1hwqBHWokQIEHFgYKZVKFD37IwIrNsjN9DAyq+D9/jFg4UG0
 ZLczuV0c285wMsWdrAp3iQ+xKUFlREejvZsYAU53q5KoQB+YZ5f7Qh5Rq5ozYTHF0Zbq
 Lpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237362; x=1707842162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkMb2EUV24/uMXpVQHUiUuNQtIBp3iL3/qe44nI5hZE=;
 b=LiDRoI3m/h1ODOfUmv59a56C/l3AZL3NXP+cbkhTjjamzUwRaP+0cJhbTkJs8ITQUw
 J5Z4EcXevM5fhLE2RN3HIZhomzdeivWfF1ECof3QigFUsCryeRtj9NGDrRS3g/pQa1fa
 7XOEubA/qloz8DAlIggCw/yXUpT5W/O23HLg/QShMJEy6K/54RoAGB6icbM0O5BinfsK
 VQm06Ua2FD4TXLo0X2u+ua425CYgp/66VeOU0OPeZXsIRLnDzOyXzIqaM5Bm7Tb+mI2q
 bxLbS3RRB+lXZzso7MgMd92Lp/rjSo0NLjX1c+1ld10aiwHJydJdLpwOYpjzROGXKWmN
 sO8g==
X-Gm-Message-State: AOJu0YyCsWYiHBJspaaevX07el6upnQ7DBesKuPHdKMyptIUw2aanWJW
 lK2mvqz4srg1Hj4qxFdgVKMEwT8y86ZQzLDP40WkXptIhX12tM+sgo4qkpgdP24=
X-Google-Smtp-Source: AGHT+IHZ1g8EEin+PXNJyiGYpHahaHROqu70C3CppNsctisCQAbGyBT9HargjMkHmybrJTiPMsC6fQ==
X-Received: by 2002:a5d:69c1:0:b0:33a:f798:bfa with SMTP id
 s1-20020a5d69c1000000b0033af7980bfamr1605590wrw.64.1707237362171; 
 Tue, 06 Feb 2024 08:36:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUKc+IsVZ0ivlBSdUZ2AtKHnqRUibEH3UuQAyDTsuKCGrloZzDJ1qL70obsXOJfBnRchX0YdkCN9uZZZePx9R7wZK+MBVBpx0qwi7sqFK7t9NCPSt3lBI+G/dGXyNIpEuSGBtDbHsd/ecMJ9fi5yrt4
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a5d53cc000000b0033b2221d938sm2461680wrw.76.2024.02.06.08.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:36:01 -0800 (PST)
Message-ID: <a5a41078-b7be-4d45-9b08-00949ef3fb25@linaro.org>
Date: Tue, 6 Feb 2024 17:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/pci-host/designware: Initialize root function in
 host bridge realize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 qemu-arm@nongnu.org
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-3-philmd@linaro.org>
 <CAFEAcA9ft44fEp9eGDJC7xCOXmW4Px-XO8HEUSyci_x5sh8XQA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9ft44fEp9eGDJC7xCOXmW4Px-XO8HEUSyci_x5sh8XQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 17/10/23 18:32, Peter Maydell wrote:
> On Thu, 12 Oct 2023 at 13:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> There are no root function properties exposed by the host
>> bridge, so using a 2-step QOM creation isn't really useful.
>>
>> Simplify by creating the root function when the host bridge
>> is realized.
> 
> It's not necessary, but on the other hand "init child objects
> in init; realize child objects in realize" is the standard
> way to do this. Does not moving this to the realize method
> block anything in the rest of the patchset?

I thought it was only recommended to use the init/realize
pair when properties could be consumed. Otherwise using
a single handler makes a model simpler.

No problem if I can drop this patch.

