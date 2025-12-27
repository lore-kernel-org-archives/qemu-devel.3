Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9750AE92714
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWZh-0006pc-8e; Sat, 27 Dec 2025 10:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWZf-0006pQ-PL
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:51:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWZe-0008Lm-8a
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:51:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso81556635e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766850680; x=1767455480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6Ynz1b0FNLZGvJPvSqeGtlWQTuOE9JMhqJ6FwrmHVg=;
 b=uQ6sOw54n82dQiWtfWamFxWwWmU/iAHG3VQE9Li8qMnDBwb7/7oIjey1dt9Vi0tcfg
 S2Ix359P5gxnzs9R8dk545BT3NhADVrRdrBaGZr/PnIcVC0fz4EnzjVWo4TCcKUtl0y8
 pOuAW1IZXr4wDLSJzn0rMBY7uKPkbeyZCHoeEa4o+5zJPjQ9M/R4KOggMpTMs3QLd0ZB
 xhwQdcAQh2tbqwj9F9fB68UY/9gyyn8ZSF592tbiVjtqE9M4jqd3FblZpNvtUmglBh/X
 HH9ulTvaYkYZTv8vuYHDyYq0u971vPNHeUf7QEJlOlF1OYiguWU6ATwXNRePnVJxRJEE
 ttvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766850680; x=1767455480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q6Ynz1b0FNLZGvJPvSqeGtlWQTuOE9JMhqJ6FwrmHVg=;
 b=hHqIs6y8npo6XEXwAreaU2/5QbKXHHWgWBFvd73zImQaQ7pAE+SmmesugWW8HnnYkl
 gSlmDMqanXloJns4AGUyBnHrXRwjUdr0ocOyMcZgr8xNzUuoh0daeKtZPwiX5kvsZ/QQ
 eRmMe181YW+mcTzj0+pQzLJlkdvyC27hbmPNAW9PYKzkKw+ig8bPG0cusOm+1OR7w/aG
 LUHuWP9yAfh+k7PdHe9H95TSimOMX1aeZ0Eaf8Ai/RJRiSQCb1mcUCTVIUk9AEwe8gA7
 P7ucgLbWahYVVqjZQYQyxoY+z4+OybHWD5Q2+qPw9QoZUAm0OrpLg8ZvIndNd6BLhiCg
 GHsA==
X-Gm-Message-State: AOJu0Yz6z9+R9/ifEUumtl4wp9NSuJvlrJLt6Pv66WliJthG22h1vJjR
 xqmva/fZMLAVjtioSgbwbbxB6PNYdBxo5t4UyS293lMc5rMjgslvFvZK8uLP6fgWlLk=
X-Gm-Gg: AY/fxX5absbFHsUkZtzm4q60lCmwgBHKw2ohM6YvJExvuAcSDp48FYXtawgRauoLZ9H
 s5ElaNKNJ62AfEKExYDC1NQOcwD8IWthpRo/33UZjA1cbErKafWj1X21B2YspUVmLUfkXvZfWTN
 virnw7eoFbX006dS1zvOxGlfHnzEX7BZDyDxSltmEf1vNJstIq/fnRh9E9ZzeUYDX1OuHRgVAE/
 PZvtR/7MlRSRloSf/kERAFDzRv989+/aBojHkS3JZiE0YG4lwp4uC0azM2okwYW/lw856WPpJxb
 aTeJMieV5NK4U1gayXFx6J57tH4cO1mMvSVqDRkqtI+AzzaugCpIzeZeVwNkn+2Eru9gbeQk9bh
 lnPiyjfufuLwtL0aKv74szcdd8hUssbv4JSP/wY8Io1buFpSxNby84atnHUoimXkmvWjARz6L8m
 uy1/JumhLouDq3YXecukGyKG/xQXk0JIuku/EzdvzpuDSL+jC4EE7Rapouz6wP1g==
X-Google-Smtp-Source: AGHT+IGRYWFb4jaDTtiCcta5gxwPW5ddRAhEkBzCYGwNaRWFXBQXfJ8lUVCT9deOB1Ds2//cPa1i1Q==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-47d4047f3e5mr115495705e9.36.1766850680253; 
 Sat, 27 Dec 2025 07:51:20 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm51950552f8f.24.2025.12.27.07.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:51:19 -0800 (PST)
Message-ID: <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
Date: Sat, 27 Dec 2025 16:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/12/25 09:56, Paolo Bonzini wrote:
> 
> 
> Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     Guard the native endian APIs we want to remove by surrounding
>     them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
>     Once a target gets cleaned we'll set the definition in the
>     target config, then the target won't be able to use the legacy
>     API anymore.
> 
> 
> Host endianness APIs are fine and are used when talking to the kernel. 
> These functions that take a void* should not be included in 
> TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API.
> 
> (And also they are the same for all targets so they don't get in the way 
> of the single binary effort).

Indeed they don't get in the way: I'm trying to have clearer APIs where
everything is explicit. Anyway I can live keeping this for now.

> If the only change needed in the series is to drop this patch, don't 
> bother with reposting.

OK, thanks.

