Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF7AC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuro-0003Yw-6P; Tue, 27 May 2025 10:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJurK-0003TS-RW
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:00:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJurH-0005xN-Ij
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:00:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so44609575e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748354443; x=1748959243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVx0hirbHyVhiqRoCs1aSSF5yqohmxPuujDOwBv76Jg=;
 b=eFapmt+Q4oJd+Dw78XPRzvywH86RACYGacvVeS9BD5teEABm2L5Cssy1VcdNK4Jl9J
 D9FDcaHBVsCJ6RbcPd79cPbCgsGP2r4QyEa0WQF9ejGsDeWlM2j+lhKONQk0hM4UxEMK
 jzjFy7NYHffu5x0lkqK39SxlcXUZgsH0Lkr63WxMYXH1rDYxb3c6sBPmeaPyp29O3AJI
 7jZVHi0Grm3EuPX4AxZAY9Ya+W0IdsZzY/Fxl3xn1sjlkHulpe/9etosmy83eG9h2PBq
 pd89ADvC7cLod6VdMzZrsvxN6yLo8pfO5DPq2N9hOKr2oPFnZYV3ys06QhAglISTYB3g
 9Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354443; x=1748959243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lVx0hirbHyVhiqRoCs1aSSF5yqohmxPuujDOwBv76Jg=;
 b=i6yoZtu9WtrjnsXY5fAggaUFD61EjP2rKfmm+1dCh8I6rguoSrIK/KgW8Rpiv+Hs+w
 SCeKJdstoXMuS7SZLspZsimpUTC2wC/FpcojjvXx+CE065cKeG0CdSXS427W2zU6iKFU
 9KDa4eOPC+di2yfbzScE/BjqZ4h0AxQWuQpFNteJ80wW8QuEPzh/KLqywBslyfsJIRyG
 eRe+/5UP48YvNnqpBfI9Kg5w/M+zeIDo6CdqZfHwF4Aty0iD9vCvbHnYnyesfsmC8l5Q
 zxNlSvFuZ3u+NHAvHmKM+ORxf2SdtKmxG0i8ZCJO5/WxRC1iLMfN6j+xMxa/dsjXnnT0
 GTbw==
X-Gm-Message-State: AOJu0YzKe1Hm+s+o5TLDGzzwINcGXzssjQDKcwC36XNQ4SqfAcgNkn53
 eD6RZEBd4LeE6yAa7quPaQB5yZpkUjItG1lZsnrwZKoTHu/FP9053QOKDu14FLNBUIA=
X-Gm-Gg: ASbGnctgPfQKGBq0oSKwuGopFfqlHej13SnnAQqcb+2UP8bYsk0ZyEiF10v+pAGLOCq
 v3tKC+8AMAbtY98A537Sh0GkJVBY4u8Bmr3KG0r/W2HtNHwsvP3RlPD0EidvBPXOgJX6Ym3IhOz
 8hAL4L6WK2yT/oRVlgeEjq8xdtFIMhNulq7Q9VwPP7fLT2Zx16LLM+BGRcZFlf+m9MFYlR6lhWI
 fXeDuoytXJWMIvFRUqOFRcwM3FPLrxJkdbkFxC6ITZxgtwSZ0PKyoRv70SmjuznACYYG9SI/q23
 qEKYhi11CYmHIY71UPVQpnHuT+i8VJ39fj5lgOD9UO2WUZ+LsHgexYUuoKnUG9Zz+lx/5z4XHcU
 JqBfva4UBeFcRlBqaMQIs0U9V
X-Google-Smtp-Source: AGHT+IHAFidqTshKWPwW0w8zKahzeLO98Ew2YrU8MWVWRKg+giPun7Sr+afm4GZF0Wj07+sobbF32A==
X-Received: by 2002:a05:600c:5249:b0:442:f990:3ce7 with SMTP id
 5b1f17b1804b1-44c9465cecfmr123649745e9.16.1748354443077; 
 Tue, 27 May 2025 07:00:43 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-448ba3d8facsm255174855e9.6.2025.05.27.07.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 07:00:42 -0700 (PDT)
Message-ID: <fd63e788-48a0-45da-ad17-665b3b8e4bfb@linaro.org>
Date: Tue, 27 May 2025 16:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] hw/ide/ahci: Delay a bit before completing reset
To: Gerd Hoffmann <kraxel@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: QEMU devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250526180558.65613-1-philmd@linaro.org>
 <9bfb089e-6bbb-45dd-8da1-14ba4e28d935@app.fastmail.com>
 <kfhsylcpobz5zphhsoimmvoa2q7wsy45atl6z4rhkqpuudgnp7@evgs3jw2jefu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <kfhsylcpobz5zphhsoimmvoa2q7wsy45atl6z4rhkqpuudgnp7@evgs3jw2jefu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 27/5/25 12:45, Gerd Hoffmann wrote:
>    Hi,
> 
>> I do believe QEMU's current implementation is also in conformance to the spec,
>> as the reset process itself is done instantly in QEMU.
> 
> Yes, that is fine spec-wise.  The problem is the seabios driver which
> doesn't wait until the hardware signals completion.
> 
>> I don't know if it's worth it to introduce extra complexity in QEMU to model
>> a very specific hardware behaviour. Even some hardware is working in QEMU's way.
> 
> We have that kind of differences between virtual and physical hardware
> in other places too.  Timing is notoriously difficult to emulate.  Often
> qemu completes hardware actions faster than physical hardware, or it at
> least looks that way to the guest because it does not get CPU time until
> qemu is done.
> 
> One way to change that would be to have all mmio writes return instantly
> and only kick a timer or BH which runs the actual action.  I'm not
> convinced this is worth the effort.  If you think it is I'd suggest to
> move the complete driver to that mode of operation instead of adding a
> reset tweak only.

Nah I'm fine ;)

