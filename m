Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C57C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDqB-0006w0-TP; Mon, 31 Mar 2025 08:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDq8-0006uC-82
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:02:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDq6-0002Pg-Jc
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:02:03 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so3741957f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743422521; x=1744027321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qNPCBpFT2EhA0nbHtjBf0iW/Tgvg0WmVeqDMG30u8v4=;
 b=saQXzPRF1wbRlct7raJE8lE3gu82IYQ0Bwblr4ByDyH/ZDcMOD0D6SUXa3rtn4hEv0
 cqFiB2k/T4NhQcOSXLbybY7x5RieTl4bJu5kKbCAjSFt6wJ4zGzXMpzwYXOmYqOtONEB
 OU0I2qLZ/jKUaEphiJPFkSZkS3tXJ0vIwFLuFRZvNjtDZ/qu30pft8vXw+oiewM/dGv0
 j+R++eZ4zgW5EH/LVYGHv9x8thCba6fLxOjF0GTfCfRupXwYH4eWB21vM3ncNbAEfKIi
 wrCW53mlCW+SNcwgrfLliZ6gHXGHcLEB9i/ESGa1LIROUcjO46rR10p2P5XJXyH1LKxg
 2oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422521; x=1744027321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNPCBpFT2EhA0nbHtjBf0iW/Tgvg0WmVeqDMG30u8v4=;
 b=tDpsC7TB3ry6vJi7dKPFgF+ADUfJf7qO3NJZY1lNxj6GuAKuv39+JiGtMQdemKtKaa
 DwWqjyisms0ZiZ37hc8MFqvk69tMVBYAs2pGZylazHjNA+o4e+d/Cmq4OlRulVFEl2UK
 ogqbiozAZla3HWyvNsqOFjrQPCeeg25xJvbTDXkpInjsRB+7TnnEEOBCMHJftsdljbH+
 nf8pDtXfpKw6nHRi1oBiQD76YLdIpMCER+CiWO8GoD5miFIZ1LlBPukFVavfhggrJjYP
 7LMWaJYSagM6tVB2fg8lYA910LCPnZHBKB/UEA4u9RlGUZ1r0vUfP9LJGFCTw8ddJe9B
 t2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYt7G16z5ib8Qb6leZrUchGosMEYVjj8O3RfNGd+48404QTHJgxJSlxI9PbC3t8Sdvl7AwvqMarmIV@nongnu.org
X-Gm-Message-State: AOJu0YzRb14jIWE7+7hAx7fmyLYakbHPJF1MG6EYvMnOpFz3g8bBnicI
 BhfqCNz93PGsOqbTcenOoxpxOSx7aWnKCwo4MhTacaZkFwX/+AyVBNkAzFkvTWI=
X-Gm-Gg: ASbGncusd5kBIzwGP9xmNqmQ3ybU+VU72tqeqbqoKMlaQTP7trIbdeKL+pBPr12w/oH
 9jLGrYwt36fqxsXyMM9O5lrDkiFeewlB3NKDdg+3dUUNM7TDEKCH4v/9gO+JNq+hnpqAjmLHwYl
 xk6JCpsov/TMV6GZIcdekdTVw081pcukP9vNPj9NixZn1ib1AQO06sipEILCkqC8kD4qtEqHWVP
 oEQgO6zd9/fIKWhDGTKOLMBGhpMIn8lZPuPzkB7R00jOufX9pyMWHKHQXwMs9RYfdazjypFRkrc
 LxoIYzIhGirS+WsrzxUxUNU1+/3waFNSoqOOleFwiUI1jgw+ZJ2AKx1S38jXrseOfR1+VgPK2mU
 DvcwDYJofrYw9
X-Google-Smtp-Source: AGHT+IEzKWllmprsunc5g5WVfCy73xoW/wFch8rg6vEdqCJNzCGd3Gg1i9BuYzE1Pl6HcUwRHcYbyw==
X-Received: by 2002:a5d:584f:0:b0:391:13d6:c9e5 with SMTP id
 ffacd0b85a97d-39c120dec41mr5239560f8f.19.1743422520700; 
 Mon, 31 Mar 2025 05:02:00 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e6a532sm162112235e9.9.2025.03.31.05.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:02:00 -0700 (PDT)
Message-ID: <9caad0db-7886-46fe-ba8a-c2532b56c2ce@linaro.org>
Date: Mon, 31 Mar 2025 14:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
To: Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 QEMU devel <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
 <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
 <1e2fc164-0721-435f-a29c-43d54539eb74@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e2fc164-0721-435f-a29c-43d54539eb74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi Jiaxun,

On 21/1/25 13:16, Thomas Huth wrote:
> On 21/01/2025 13.07, Jiaxun Yang wrote:
>>
>>
>> 在2025年1月21日一月 上午10:36，Thomas Huth写道：
>>> We are not aware of anybody still using this machine, support for it
>>> has been withdrawn from the Linux kernel (i.e. there also won't be
>>> any future development anymore), and we are not aware of any binaries
>>> online that could be used for regression testing to avoid that the
>>> machine bitrots ... thus let's mark it as deprecated now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   If anybody is still using this machine, please speak up now!
>>
>>
>> FYI I'm using it to run MIPS AVP (Architecture Verification Programs)
>> time by time to check TCG's compliance.

Is MIPS AVP accessible somewhere?

> 
> Ok, if you're still using it, we can certainly keep it around... but it 
> would be really good to have an old Linux kernel or something similar 
> available online somewhere that we could use for a CI test for this 
> machine, so we can make sure that it does not bitrot... do you happen to 
> know whether such a kernel is available somewhere?

Otherwise what can we use to test this machine?

> 
> Also, please consider volunteering for becoming the maintainer of the 
> machine in the MAINTAINERS file ... currently it's marked as "Orphan" 
> there which was also a strong indication that nobody really cares for 
> this machine anymore.
> 
>   Thomas
> 


