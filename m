Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC30C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRBP-0004rH-9v; Mon, 10 Feb 2025 05:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRBM-0004pd-Po
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:38:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRBL-00051M-6L
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:38:28 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43618283dedso41363575e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183905; x=1739788705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lpf7FzddLbD4vLLtsiKhL3Io/bhh7otLZC+2D8nsEv4=;
 b=ojd42LLHcUYWkh6tOYF0nLgg2iT2ZGi16E3wzPbD5Vq0tPA4c+wYhivThqjzXD6ScG
 p232ZYbvDx38UBq0rK/LORLnjaO5Eflj2CKA7EQgpRJYZcDsQiRpdHJ+ft6s/ei8gUSI
 jLczxGriEkD7ndypJIADS/BinnbTVesBesHl1sAplQlXTQ3QY65AS5VNJuchEDWoaTmt
 H4lylFMNbPW1qHQPzM2UkgW/EIRv5EkjDxtb7jRQ842YTI4jPpJYdp/1qV4uxX8mrwC7
 Jd9wiP1DWOe7PxBaxQAUe6+wlgH77zeQXz5aABT+cRPYKp2hI7G7v1mBSZeIqeofMPnP
 WJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183905; x=1739788705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lpf7FzddLbD4vLLtsiKhL3Io/bhh7otLZC+2D8nsEv4=;
 b=Jlrp8O/AcP8ShzNKCCoyjwuCgtBwqX+bISLPzevapriCIcO0Cg4txE/O4tK9Y/tMLA
 NdMfrlh/KjGhm2Kf9xXOozbcLG6phJhDIGKpylfz3UmlcmNsDB+IdJ8Y4sJTizJxDsIJ
 nYlbIahu/wfOJ/M49Joml9+c8u+1iwSIdf6wuWrl8o4JeYOkVYS8uBoh2XSi7hq53LVX
 FIqJlBitu0yKSSjnLavL4fKkNrSmaGSK4Afk8n1OKQo/u+GxClt4dTNnHtMv0au8cliW
 EThOhBa3Y1ZLfVjlEx3eyDmTPFRF+Kgiqz0g9PR5+MR5eH3qPrKDuRMSUJMbFVXL/JG+
 tuIg==
X-Gm-Message-State: AOJu0YyNLk49bMzTydmzdmuZnN2IUOhYnAL+8QrCJ1cM9xdhEeMbIIip
 voZc2c1r9WgfvpXR80EzyPGJB45srldiuCOACL51MmDUaAS/SlVnTIrC9wPeRLjFBqS5HunPwQ+
 8S2c=
X-Gm-Gg: ASbGncuCf7TpPdBnb+G2ycsmK7zzmDHb3qIQg+POscwan42MibyNdZtXhMdLlp1JZZd
 /BrLE9j5kVHkFCKUkBA0gmf4Zgmb+qyqqD74AJjcpgjAzWbCZKqv/IZ0a0OGvtsZ/+kT7CdcBtA
 SWUwB0LjgoQOAaOQs8MiFBwj/dPwvKcaEUDkBkDFxmZ2nZpfQcyyyVn9c5MlI/Shv35aOn7U8Ox
 UzNIMVREUTkPYuvj0nCUf96s56iwI8EGM84UNJcEbETlE2U9lmCKhy8Ie/9LuQSsb9GGNxO7vsD
 ue6vPCDTBWQU8jkRFzsTPUt3ugkUXdsEh57vdVPBACFn+IlQ7KoO8VXGHiFeSo66
X-Google-Smtp-Source: AGHT+IEjTjiXs/QEXVN3KlTYMJcoSvjiXLmMFWXUIJdBlJg8alBcD0uQd7FB01FvbX2ux2umuL0hYg==
X-Received: by 2002:a05:600c:1c92:b0:439:4589:1ab0 with SMTP id
 5b1f17b1804b1-43945891dd3mr20448535e9.13.1739183904670; 
 Mon, 10 Feb 2025 02:38:24 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf7dbcsm178374205e9.30.2025.02.10.02.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:38:24 -0800 (PST)
Message-ID: <ab658338-5638-4f75-9ece-a160745fe82d@linaro.org>
Date: Mon, 10 Feb 2025 11:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
 <7e35b5b6-01dd-457b-b36f-507a85300b45@linaro.org>
 <CABgObfbr4yHBJxCVtOk9rQau3Z8M-QUy0+OqTnjecTsKTXrH0Q@mail.gmail.com>
 <ad5dcd1b-ae0e-42ac-befe-a33b3f900c71@linaro.org>
 <3953673d-873b-4379-9bff-c9bf68130b75@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3953673d-873b-4379-9bff-c9bf68130b75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 6/2/25 11:19, Paolo Bonzini wrote:
> On 2/6/25 11:02, Philippe Mathieu-Daudé wrote:
>>>> Could we always make .valid_sizes() explicit?
>>>
>>> Yes (for example build() could even fail to compile if you don't have
>>> impl_sizes/valid_sizes set), but why do you want that? I'm not even
>>> sure that all cases of .valid.max_access_size=4 are correct...
>>
>> Exactly for that :) Not have implicit default values, so correct
>> values are reviewed when models are added.
> 
> But I wouldn't bet that those that we have in C are reviewed and 
> correct...  They are incorrect if the hardware accepts 8-byte writes, 
> either discarding the top 4 bytes (then impl must both be 8) or writing 
> to both registers (then impl must be 4).

Are you saying in general or for the pl011 model?

What I'm asking is to have all rust models explicit the min/max sizes,
regardless of whether the C implementations are correct or not. For
rust models, we won't rely on default and will have to check the
valid range in the specs.

