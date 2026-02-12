Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ABFEEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqd3y-00069t-VQ; Thu, 12 Feb 2026 15:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqd3x-00069K-5W
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 15:13:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqd3u-000858-HT
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 15:13:20 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so1795185e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770927197; x=1771531997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/UXXIMdZQ1yEF6XH7tYw6k1RBttw9Ak7PjAOFBjs++c=;
 b=XkU04p9uZVivtE6aqbpOsq87XBlA7YCPfQge5ROfiDu0eu87OHzKNX9SkiV7M4VZah
 GJaukJ0bJtMO3BndQiiO45rXvzRG96jRQIF/fkcARWWNDTQdum25I+rYtdsqh5TinE+n
 kLCYV4Jzz1kwDMBAevdiEVxmGyJVeknH6t7OivyiyrvrbtD9PfX24xJ4HBSdvOTIXddu
 WfdmdtmpviTvUB7m/AEaRbZxgPLurXp3o4c3ZYHXyOmGLnT+2bAObjgplvrYK3ynnAAl
 MWyrAI53fk5aX9MxwYQrbp2286NEWGnTgdnj5HTpcPbUHQ8uJDHvJ/VB3lDE36sC329h
 4Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770927197; x=1771531997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/UXXIMdZQ1yEF6XH7tYw6k1RBttw9Ak7PjAOFBjs++c=;
 b=qvrV0w+gEHyjERe6L3NvavN5YhIAB/7gXTdjsYfgxjPLF78agGaLiygP4JL91R1rEx
 9lCbDz52Ks6ofxgVJL6n6tCQKsi7QNmh3QqX04KDkVaEf069eos+UdIgGjj6kmlvOShu
 K0z8OeGiRUOPFBES2tNaecgFtJiHbdA8bzsqqhlBW/nH1HMVWKC6kFQGAFbZK9dO482+
 /4h/tG1XL3wHGgkM1bdH9o/Z/cry1xwKzYeumXVulPuKo486bMdDfutDcmFZi9y1oThD
 oCfsTG4SvZPSNntMMq8Cl3BjAvSSIKx787S2AOyuM4xgslzY9iicL/Bld1fRPY2Otkpy
 rTfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZglFFzp7QyzcoGWGXwrVOrbn4++tfscEiXEeTlWwACL00yapZuCxxhLLBRzC8UY6mF0iYhTol//fJ@nongnu.org
X-Gm-Message-State: AOJu0Yy8PWcMRqhC6hQFDtAWvR+TwaaRyKUBN/HvNMqoYkg7PBFiPs52
 iAWlTjHMMCgt0nYbXbqidvCIRyHN7ySDy7qBcsN1T07uVV/pnxU/CV85SvOZfaWJd4I=
X-Gm-Gg: AZuq6aIS73zGmxoLO4ULqBfiP+Pn5R2MzcwtaiI0ek0QwPkfblWAdzKt6LZMX+2yStx
 XgmZClLUooKGP08t8ThLsQ9I6XrC+X4xC1eAN4H1casGW+fExnBaSDnLOKEm4iQaQHM71IF2ij6
 WdJFqySsOi9oJ2olVQLTrG6GG/KNMMkY70yCXn/5bi6HCp29gK8gWsjrLF9ikW+3ctvtBvdKEJp
 FFVQpX/WgAu0GHWnNAUjX7t6oxg1wGacFlb6m4yDwuGbxN5x9Rm0hCx0FXXrxcSgD4jubxmC4uV
 PdO61p/GHnR4K0t3IwNN+1aKexXswZsoPmk1oq1RqxN1TNFPNt8x7MRI2f/JXy0mf5Hj4xBFIPq
 vjcTMysZpnEziJ7r92ReOfrvSD10MBaXqDAQUFXRb0nJfkdBjRMYuZmmWeI8F9Q+aY39cd0j6vy
 QVUIwWUknAy0qxAmrakw3u6CBG877A6gBO1dPN4gajFFKl5SKiCZQgfreyzdJYYYsFrw==
X-Received: by 2002:a05:600c:8b08:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-48370e237c9mr5102315e9.14.1770927196736; 
 Thu, 12 Feb 2026 12:13:16 -0800 (PST)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d78cfsm299090885e9.1.2026.02.12.12.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 12:13:16 -0800 (PST)
Message-ID: <17f7b53d-dbb7-4090-a6ac-671c85dd611d@linaro.org>
Date: Thu, 12 Feb 2026 21:13:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
 <0faef1dc-6fde-41b1-bf1e-8ecfe49033f7@tls.msk.ru>
 <a50b8ccb-4d13-431b-836e-b08e5add71bd@linaro.org>
 <95e61064-c8e8-4c36-9371-cbd28ab737c8@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <95e61064-c8e8-4c36-9371-cbd28ab737c8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 12/2/26 18:58, Michael Tokarev wrote:
> On 11/26/25 10:45, Philippe Mathieu-Daudé wrote:
>> On 26/11/25 07:56, Michael Tokarev wrote:
>>> On 11/12/25 16:41, Philippe Mathieu-Daudé wrote:
>>>> v3:
>>>> - Addressed Marc-André & Daniel comments
>>>> - Document qemu_chr_fe_write()
>>>> - Rename replay arguments
>>
>>
>>> Hi!
>>>
>>>  From this patchset, 1 change has now found its way to the master
>>> branch:
>>>
>>>   chardev/char-pty: Do not ignore chr_write() failures
>>>
>>> Besides it, the following 2 changes were marked for-stable:
>>>
>>>   chardev/char: Allow partial writes in qemu_chr_write()
>>>   chardev/char: Preserve %errno in qemu_chr_write()
>>>
>>> Are other changes (including the above 2) not needed anymore?
>>
>> They are, I need to reply to Marc-André and respin a v4...
>>
>> Old bugs so can wait 11.0 :S
> 
> Found an old(ish) thread...  ping? :))

Cc'ing new docs/ maintainer :P


