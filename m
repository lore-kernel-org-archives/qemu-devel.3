Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9A8FD9E14
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjkH-0004Rn-Kc; Thu, 26 Feb 2026 17:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjkF-0004Qz-EB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:07 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjkD-0005wS-S6
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2adae92249eso15048845ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144524; x=1772749324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ugH2sjYvErRham5qeu5pJBHQcMnFp7j4/TNyMwS4mdA=;
 b=ngy2tYXpUiCp8rpgxFHAYGKEYPBwTET09vItTTFU0JTDpEgRyIwLmpirdaJNum6Pv/
 y+Dl/fv0kBLqd6fXa5xhV75XXdhmsVzbfYCfYKEeV0pXanQFnh55QAvqggYvMU49Vt7G
 Z8J3ZvdBHAZdlt+UApY38Zm6oKz6Ne85DP6HBYseJxgSSBRfgFu4LUcIgbybdamVqh2C
 KjkCHHIMs0ElwGBXUQanQ5Ksr4li/RWttikP4fzy/EjpuaH3WIHdixD2hYk8FOODdT26
 lTkNRaj6E04cgXt447D3eiwG3nol9Fnr5WsswQ8zL+vee3TpLgkG5C+gKlMBLIFmh/im
 QDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144524; x=1772749324;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugH2sjYvErRham5qeu5pJBHQcMnFp7j4/TNyMwS4mdA=;
 b=gpKrEn4ITVz89cjYg0n+SuytbY7dEZPX+Wp5WuVRFJJv5AlK+PEpX3b6WTVX8bADOw
 USEvO9trIAMZauF7dbZHUmk1qQRh9g1xsdMk6HVyC7dSX7EbJGkG2HNpbvzlMtFYxqOb
 Rj2psOYh0zYjEVGCBtjYAkc1s540y2XPptXQ1ExPRKSaEHCumnkds60lHmUJlTwCc3TK
 akoEkiKgvXhAqBIS24HX7I8Ak4rZCOODdQYq58Ts6e+tfFQ3aXvVvSVEBe5jtYKjkDCi
 BueMBlZ4oAVT/qvEwY+r8bjG1DE2ZwQyKl5FrgGf6j/PdWNVRasS8L+zfUuIX+HKS7gk
 Fukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBQY4TPu4eZ9q2eIWmBHQrnZFCsIBgDCmXPsHFIAQoLOwzk3WAqP0/LiPbHY97gaeNtJYJTGlsMiAX@nongnu.org
X-Gm-Message-State: AOJu0YzBuRccTcY5XZApfpHL0HIWEMOkeJsG+bEfIEgMGCJycsO8p29U
 KHzS6nsNv1vCTdVtX/T1WnxetxzxZZWvN9G5wUSlppFjrPHlHAmeHa3wCdHSXQ5B8yA=
X-Gm-Gg: ATEYQzxOPc7fKf8ES64IP2qtFh7ZiZDW8cWZEkiUVHRk7BF0qibsMWu6DP+bUuTGddF
 EoVxrKv9GUgOg9MpPp/80wad4uiW0MnFqjXMQzQFq7ZlVdne9RYro5Isfwv6emv5VXlcZCFMoqP
 NiE50y4yK8QACeOKr3d8Im0yNHGw9DpKxiYz9K4LehQCYBH63MMosGoIUaogwibl9z0LMXra5Zp
 YLTyb3s21uXOYtGtPAyxPBe4CuwhAWgnxTvtPjRvg9NXAb3MzeBa+QMB+oufffWj2ebUogDqJ9D
 LGBZFjh06ZQvGj93g7QiLWpXvz43OPUyaVNVbH1BmZeBIKtXX+lc5LCT6aYxUYcKerPGB+SmqEl
 oBKAl8gJo585jGn6xmbvCJgM7aVDVQYHqUZYFUCIfoUgO+itf93/SY693LjGQR0qCkR8jj9lioy
 f/1U9k7L//7y3Pzt3+8KeXHSqN0UlStIucIhkxfB4IzMWYxPiTMsjZapVmUn/faAHkoPjm
X-Received: by 2002:a17:902:c951:b0:2a9:622e:fd46 with SMTP id
 d9443c01a7336-2ae2e035736mr4743075ad.0.1772144524213; 
 Thu, 26 Feb 2026 14:22:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6f3688sm36724245ad.87.2026.02.26.14.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:22:03 -0800 (PST)
Message-ID: <0a910d27-cb1d-4495-90ee-3674fd8ee564@linaro.org>
Date: Thu, 26 Feb 2026 14:22:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] system/ramblock: Constify various RAMBlock arguments
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> Mark the RAMBlock structure const when is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ramblock.h | 26 +++++++++++++-------------
>   stubs/ram-block.c         |  8 ++++----
>   system/physmem.c          | 26 +++++++++++++-------------
>   3 files changed, 30 insertions(+), 30 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

