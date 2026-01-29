Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD81D73E9B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZsC-0007LX-TZ; Thu, 29 Jan 2026 16:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlZs9-0007LA-5v
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:48:17 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlZs7-0003IZ-EI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:48:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so19190665e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 13:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769723293; x=1770328093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9EZJ6r0VHu2VUp5MaIaefPn7K+hso6nEbxbi1XKc+/E=;
 b=hHCM6Kp5nI3W/sPIokFhYrWMEl8zWfMtNNqDnInS59ebDqLMXgMuTIJYkrft8SUoJe
 meFAwJngrdAshhWfc+3sXjpgpryBOcMziM+D/Pmz220Efx8EsTNUOgYacB8lYf3V5vSf
 0Y/Iog92RZDiVuWND3Wkz2WD90oXON096IoUspofoRGWf0R4WGjnyOnJtcqJVyqPeCyh
 XNGMwadCtJjOQKAm3GcgBmfSFklxSvGQRoDK9uJDH5wMimbzmYOMVCavjDWE8n25E7+D
 LQ58RbrsinIaQsi9uhBoH90lHEk4cLvPr7rSUse5uvCf+izkieCbg61eq8tmOUfLllIp
 A8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769723293; x=1770328093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9EZJ6r0VHu2VUp5MaIaefPn7K+hso6nEbxbi1XKc+/E=;
 b=xFJL9dj88cGilJN++y1Y2gzNoTee0+fzMNf3LT+nGRdwJKlFIGhpKw1dsQ+bVlqkKi
 U5pjMD3C0b3JrfCSu8jLlVf/zodxCYcwciLP8A+QimGSqA1N5J+DxYEmaC0IWGDGU9Bc
 5jJlaOtzzFkx7mMcGqV4VTuyAX+b2gCkuBru/OkOmWN+Mx7OLLiB4jLq6PoPMB8GKEfv
 mM01Hf8QKcS8AkeAPjjTAJkik6J2jyV7YMWhkdwdHp4pIWP+wrSLfIAG0cxuaAfQ4VVm
 Sx8mLbEI01TIBgfO1Vv9IBX58pjYmgW3kL7r85EJ66FFPR+NhitseMHPqEkQ9152iYeK
 edng==
X-Gm-Message-State: AOJu0YxsWp1oyCEN6Fg8HTjq2yhVTCD43MPoMTKG433UWoCywYi6mmtj
 rApQ19Kv5UCbD2Ptaz1gmQHHYN3C/UEnqu/58/4kkt5w3JwqGGS7kdQeIIeIxXzqfGM=
X-Gm-Gg: AZuq6aIIzZUHZaJrZecsxZaM4oCJPbXZFw6ICB82VwFpN6P9Ic0HS2dL8Pc9dCmYBPH
 Qmj40V3aYMMek8Fm6Gw8ycZeaBed4q4gE93agMtJjFmE8jsZkV3YuagyNT5iyP58005Pb5Ir3yr
 B+Ve8SxbdU93tCTVmJC67BTOmC/mv1ZIDrjaMpoahVegKue/drbBjA3Mw2A7f7cnEOPczW477nA
 ivNa2wUKWiadF2InIsxtBcHup7GPW8ATFVEtOTKl604wYHeq/MCo04vYBYDmmX5gur/TeS8/Xj2
 3G1mBp0yRI4wZnnGGRPhi2j7rSR+f+OGrFydGLLy4qiu1QkIPWHKdT/LFez/4z9ui3gvtQofe74
 QfWy8UsE4EH9CVZl7ZFE3O+gVxez/Vk3R0sIgTUszhFuYLxTJ+ocVNMscKWyJNX1ba6Zq8cMQ2W
 7+fsvXID4O7M9IDWv1S8bV50SSGD+LszgzQ231gic46laDpu9ZriW6joJYbBJCjlQy
X-Received: by 2002:a05:6000:2913:b0:435:dbb8:c5a6 with SMTP id
 ffacd0b85a97d-435f3a62f05mr1429672f8f.12.1769723292775; 
 Thu, 29 Jan 2026 13:48:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf16sm18161383f8f.22.2026.01.29.13.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 13:48:12 -0800 (PST)
Message-ID: <c7a77c16-2b43-40a7-bae6-1e6a579a99d2@linaro.org>
Date: Thu, 29 Jan 2026 22:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/data/acpi: disassemble-aml: rename and change
 interpreter line
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260129164004.222-1-mohamed@unpredictable.fr>
 <20260129125744-mutt-send-email-mst@kernel.org>
 <a25e4042-0df8-4e46-9e74-3b4c55f90778@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a25e4042-0df8-4e46-9e74-3b4c55f90778@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 29/1/26 19:52, Pierrick Bouvier wrote:
> On 1/29/26 9:58 AM, Michael S. Tsirkin wrote:
>> On Thu, Jan 29, 2026 at 05:40:04PM +0100, Mohamed Mediouni wrote:
>>> /usr/bin/bash isn't guaranteed to be present. Switch
>>> to /usr/bin/env bash.
>>>
>>> Rename disassemle to disassemble in the same commit.
>>>
>>> Adapt the correponding message in rebuild-expected-aml.
>>>
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>
>> /bin/bash then - that's in the posix standard I think.
>>
> 
> Using /usr/bin/env bash is a pretty "standard" and good practice.
> https://stackoverflow.com/questions/21612980/why-is-usr-bin-env-bash- 
> superior-to-bin-bash

On Darwin/macOS:

$ which bash
/opt/homebrew/bin/bash

WRT QEMU source tree:

$ git grep -E '#!.?/bin/bash' | wc -l
       43
$ git grep -E '#!.?/usr/bin/env bash' | wc -l
      242


