Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819A6E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBqN-0004qm-C3; Tue, 07 Jan 2025 10:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVBqJ-0004lZ-5j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:50:08 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVBqG-0006tK-5N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:50:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso108596865e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736265002; x=1736869802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uL7tmd9mUIlLYCOLx9MrU0lzClIZcU9iuDszLT0rGM=;
 b=A9yWLIHCpAye+K4c0OcvIyWvgFEIXwsS86e2rPQdLGsY3GjHyM2gyIV772jVORkutM
 mN+JGRfZvTvEtSO4mRVIO3HhYtaGIhtrgTDemwIqBMCEdS2CDFbQgY5EG/7gGlzKQVZi
 iKOkfNJRTJHFJcdCe3a5F34VSQKFjRcawEesYvzMxg93Axap+ES80tvc2Wpvk2D15xGo
 Ay2nXHzk02BRlCO18XqsO1RU2V4Mu6w1Az7IWwFlbzrUwcnks6oINOlaFIEOveJjZxiM
 p7Qb1Bq9TusPf2pTZ6G9UFzsjxxo78yN6UgmDrSU10z4OBSon9k4KsTcm/lXaeq5ks21
 yjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736265002; x=1736869802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8uL7tmd9mUIlLYCOLx9MrU0lzClIZcU9iuDszLT0rGM=;
 b=ay23dOYzHlan0MuySmrFmzUkk/g0ti5GJr7VkeJGolCNZgFKdfWNFCjti0hBhKXScH
 A2ZZhWORJRvx0iypRKEpbMnIyHP/cYV7l400NPWpUPBenneDN4vfOQYXL9OFtGajhdl5
 Wz4boAlN7unmyRR4/Aty68deZKMPnAX1Jo8FVNfsr5lHxFhiGFitjnHJM9BB78leae59
 jdoNdi2zMe8t3wFPm1pQx+tvuOdaoiHsmjyz/TWOPOBkA4cUSIt3ip1bx3YNuuVJMhWf
 44NFQKgBV5ctcYi3y4lUYSn6y2DOpZPAzfKjkIxXowvXP5EOmIeg01PnPd+97CV7GTCt
 QU5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURiYIRsEUCBLZkYNDTfhaJtM3yAaUmVV/Y90TR1JXsjBE4/7ikpuYEqm1oXhi/LrI/jkGcKz4GlbPS@nongnu.org
X-Gm-Message-State: AOJu0YzXWIUXocub65ipxAPgokoM0Q780bo0VxPKjCBoP4xFTMFQ5CyE
 fMbUMJINekbZKXvg5qcZgvEYR10KOofiFl8plia520Gn1h9tq2yo6+/AG0bUfdA=
X-Gm-Gg: ASbGncsOipHHJNTyF8J5zry8vm5VK/DIhlkAU8QTC/rTq/XGznkACN1PPzoEAKmUtVX
 3EteKuSrwTGo0cZJO6sYpjdV3MH4iotSSYua9WRPP8Noc8Qr0J1522xRPrvkKQTXhD21VmwmvbK
 1zvmaITtosYJLfXDSghg5TAvWTGqkOmzkpRsuh7kwbIx3K0MvcZfVc1LRea+AmpP1zZ5iWQeyAu
 ddPDPnwLYYmFJNTPKXZbxgHseGlSWU+hZvRDIVYcugP/utzirvIh3jUZEHtDpPGR33UFIJVtIOQ
 s5f/oUOMuQxz8j7PBqFfhFEX
X-Google-Smtp-Source: AGHT+IH2N2hCHNT/GIol2eJD86r2KacZ7DsYBYv5HDoCWQc5TzhLGRQGqYZv+cTpjM3sxWJYR6eRSQ==
X-Received: by 2002:a05:600c:450f:b0:434:f5c0:32b1 with SMTP id
 5b1f17b1804b1-436686461f0mr584402155e9.15.1736265002478; 
 Tue, 07 Jan 2025 07:50:02 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119b6sm640027315e9.22.2025.01.07.07.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 07:50:01 -0800 (PST)
Message-ID: <c21089b9-bb8a-4bac-8302-c19efe4da16a@linaro.org>
Date: Tue, 7 Jan 2025 16:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
 <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
 <Z31OiMcYT/66AGDt@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z31OiMcYT/66AGDt@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/1/25 16:55, Zhao Liu wrote:
> On Mon, Jan 06, 2025 at 04:21:16PM +0100, Paolo Bonzini wrote:
>> Date: Mon, 6 Jan 2025 16:21:16 +0100
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
>>   ClassInitImpl<>
>>
>> Il lun 6 gen 2025, 14:32 Peter Maydell <peter.maydell@linaro.org> ha
>> scritto:
>>
>>> I think here I agree with Philippe that we might as well
>>> provide only the new API to Rust devices.
>>>
>>
>> Ok, I wasn't thinking of doing that because there isn't right now an easy
>> way to add interfaces to Rust-defined classes. However, all devices are
>> Resettable and Device isn't defined in Rust, so it's not hard to add a
>> ResettableImpl trait in rust/qemu-api/srv/qdev.rs, and initialize it for
>> all devices.
>>
>> If anybody wants to do it as an exercise, I am happy to help, otherwise I
>> can prepare a patch too.
>>
> 
> If possible and if no one else wants to practice, I would also like to
> give it a try (I'll add it to my list).

Go ahead! (I'm very busy right now)

Thanks :)

