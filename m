Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6249ED59F7F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 22:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8oww-0007aw-Mt; Wed, 06 Nov 2024 17:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8owu-0007aa-7x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:56:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8ows-0002ZR-M0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:56:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so3215435e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 14:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730933785; x=1731538585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4XSkS0nndTi7QVOx8hXqnft7dLkjB0YNG0pZTjCZTKA=;
 b=iRXhuyytv5d521Rmei7j6TjJ/Mc7yg5SQ/nPw6HaE8t5h/VeiyQi4r0L+g1bQUcGYT
 1EtljAdbZSPQda4bbLFi5Ytisj5LxSwZPiruwsWax6OORD3h2FX+bRQGUCm9HU3vBocj
 BNSuno/CJU6WUkH0rBIjffDfeWHdlz92f9A7pSORBhpNcGCi1Sa4JTy2zSY9I4915mri
 Sc+jR35LEOo4DJbsyPkC38XedIHiOvHS50IX6/xlM1GztqziR2fJ7rdTm2gUKJ0ZWB/C
 MVCsRAQ3zr64g473LmAU5552hJiwj73WmVFbUA1Gbzz6nwE3wUQLFnwwuRzMvE+tU78l
 mD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730933785; x=1731538585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4XSkS0nndTi7QVOx8hXqnft7dLkjB0YNG0pZTjCZTKA=;
 b=ike8lJ2VXLpVCxAAh7uSEGxkkNZsveD/JS8dqW5tJhu2kPYEFwyl3yzVTPE0ATZ8WE
 2IkAuYgQUOP7RUp/eNQ0yqRxH8xFlegBmg0qVbFq6zo/xNhc9RtEvv8laylvrsWCfgTQ
 yOOIr1RNJedM1Vyxopt3hyDO3DNJR8gY3Rok8xC54DdF2co7Ro8goPfG+FpzHw87tzaR
 kLbb7GVTbKrxPcXYPj4g5oC6CNtg/3/b4aXm2hQCTeUu8ylWJSFgsUDQL7uHJECs5/MM
 +omoCUJF9/HjM3E4n/OOb7wNEP7eI0+sh2WRBd9AnnZ3myRaVifnF0bW7Tg8QLGIcNkM
 Flqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXql8N+/f6A2vnWlCX66Toyc+xO5m+epBIZRiyDt/pLbHCs6YufXi1H8kudahmlGrp4p28e8voVAly8@nongnu.org
X-Gm-Message-State: AOJu0YzxVnF9rXqGU4D8F2Aq7+7XGLMpFQRj7AUbTZi1D1zfI94c+R9p
 ZWA74tU9lnKemoyhwJoa0hfIoaF9/9j6Uh2jtM87KorP0UAZuIE6V7qrJdHOC2af6V8Pz5PAkQl
 Y
X-Google-Smtp-Source: AGHT+IEErNUel2DeKMw7DY/DK8YdOa2C06oluKwWlVeNuZow4A+tcoFpkznF/guj3h9be2KKZp1QWA==
X-Received: by 2002:a5d:64c8:0:b0:37c:cc96:d1ce with SMTP id
 ffacd0b85a97d-381be7c863amr22189528f8f.24.1730933784756; 
 Wed, 06 Nov 2024 14:56:24 -0800 (PST)
Received: from [172.20.143.32] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97d658sm24131f8f.39.2024.11.06.14.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 14:56:24 -0800 (PST)
Message-ID: <2ee0bab1-1baa-4b52-9856-4c1fa4c9ef0e@linaro.org>
Date: Wed, 6 Nov 2024 22:56:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pl011: fix device id matching
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20241106185136.582198-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241106185136.582198-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 6/11/24 18:51, Paolo Bonzini wrote:
> The offset that is compared against 0x3f8..0x400 is not shifted right.
> Adjust the pattern matching.
> 
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


