Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A19ED3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 15:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZsTr-0006IB-Rg; Sun, 28 Dec 2025 10:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZsTp-0006Hj-G3
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 10:14:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZsTn-00006a-Sc
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 10:14:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso76580495e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766934885; x=1767539685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9IgyYZP9u7/cBtDK6b0ydTnm+LWPn+uJBoVam1fq8u0=;
 b=D7A5Uov7XMaVAqL4dJK38poQo97vXyPcBHb7aNQ/r01NjqQ7gP+yzab8HdXzV9sWOZ
 5gDNfzExbah1DyzeeHWHRHseLnw3Mwmo4R4zYDSqzGxDX0fKvt/KuNee7tcpqgIUgD6M
 AqJlYqMnvraKdzI2oRMaPzZZVlsd9NLiMlGZqX02XB+RiuAPLGztAmgro3dvn2vKbU50
 ra/Zybhb1DAl1kc0vwFwWEzw4QQaLE/vJZbkIHYWJ5nONqzZx+RliJXFeNx7NCqpd1sQ
 1uNdTmFyaI5Lg+2FrvbajI/zp9FFspJVXOny9twWfmxxJ8s6W+eAc+LBaOtVTqMHHSqu
 +cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766934885; x=1767539685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9IgyYZP9u7/cBtDK6b0ydTnm+LWPn+uJBoVam1fq8u0=;
 b=K/ayVDYFEqt8LPI2QH1OBnlIcPdDL6KOZHNgH+wBkZGzJo699qL+2Q/4/CAFtFBygO
 k9RLhYAr0jun1iZrvqZoSv6ldutkJnm+RqW9EfNAOqsS+6CLDmGyaSLBTjU8Stb6gjIG
 qBxqPbgh4K/BxLYbm6sKFBChoGpM4lrOkcNlj7AaSVZOLRQSwNbJoTodHmvuESGD4Mir
 17viY4BSJ/SidfIni7nAXFB/QfIb5zxnzZ9/2qkgECwwJLgGoiXKeNG0QVxvLDkFU1E8
 65Kd90CuX+HrgTKkM3moL4Bb0vnhOnEtANd+m+FiE8IX7/mNG4J66lMTuAT0vbKE7/S2
 rsYQ==
X-Gm-Message-State: AOJu0YzmIqmFK3dAkcDnpCTBC6WtRDUEs+RUuQE24fjB5W5dKvI6+vOi
 vNoCWiEsULzYqzDqFHFyCDb0vPrLGRHnSFJ16ub9o6lDZ5PhaH+q30vY7CCFX48WjfU=
X-Gm-Gg: AY/fxX556Lv+DBLKp1rTYcOb5dpmJnkVqAS5wLRG5r51UmaGYWjFom2nBa/6y9X/YdC
 BzMbEpKvEIBS01N6oBjLylgzKmH8cmY2sCCI8HkGEpIFs93LkMe0jGYE/3RVrLhf87/D644x3xC
 U0gviTQ/wEbdH+36tQ2RXDLwm0tem89gvqQgeIp2NPnvN/dKgjOe6ufGBT3NdBOVuPtiJXC8mRu
 6hQiYImJ5V+fAIpkaMbBBdgs/SA7ommUfsQXua82WqDZAqWFIDGeG5p1H74VxYnTHxe0Q6m35TJ
 A0uDsIJpky64yKZJekSbp+QYLN370TYa4DN7Ob3wj75A4kGmLIhWPgh8SCykiXed4gan4kKKv2l
 jIDFKtBSEi6YuBFoQQ2WcSVQDFVdAHOACMaHotez+b4nYENSHIyqkQLlnkuaokvuvE4p9QDT3oC
 1kjPpHAp3SY565dBuXCLe1d1Kep7HvdfVs+VFqyk5FdyaPP0TJMbgpAwsUNWpAPQ==
X-Google-Smtp-Source: AGHT+IEojjZdFbhoHDUY2fabEzYp0oW6n/EibqFIkVyXOFzHHHRpeyYguluv7pxXGeG6YGlU+3ugnA==
X-Received: by 2002:a05:600c:1d29:b0:477:df3:1453 with SMTP id
 5b1f17b1804b1-47d195a06abmr321182365e9.28.1766934885000; 
 Sun, 28 Dec 2025 07:14:45 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d28bede16sm155394675e9.20.2025.12.28.07.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 07:14:44 -0800 (PST)
Message-ID: <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
Date: Sun, 28 Dec 2025 16:14:43 +0100
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
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
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

On 28/12/25 11:44, Paolo Bonzini wrote:
> 
> 
> Il sab 27 dic 2025, 21:34 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     1/ we can not have "guest native" endianness in single binary
>     2/ host endianness is only useful with "guest native" one,
>          otherwise if you know the guest endianness, you can just
>          use an explicit cpu_to_$endian method.
> 
> 
> Host endianness is useful when not talking to the guest at all—e.g. for 
> sockets or kernel APIs.
> 
> *_he_* functions are basically just memcpy in that they support 
> unaligned accesses; plus stn_he_p has the advantage of taking a value  
> unlike memcpy which takes a pointer.

I see.

> Perhaps the source of the confusion is that they are in bswap.h but they 
> (quite obviously since it's host endianness) never swap?

Hmm, maybe not well named API then.

>     I felt confident it was coherent because, except the ATI single
>     one-line case [*] which I believe is not the best implementation,
>     the rest of my series proved this API is easily removable, the
>     resulting code ending easier to understand IMHO.
> 
> 
> It's easily removable because most of the time accesses are in guest 
> endianness, or aligned, but the replacement for *_he_* functions is not 
> picking a specific endianness; it's a normal pointer store. These are 
> not super common but especially in hw/display/ you can find them. 
> stn_he_p is the right choice for ATI.

OK. Let's consider the following patches removed then:

- 03/25 system: Use explicit endianness in subpage_ops::read/write()
- 14/25 system: Use explicit endianness in ram_device::read/write()
- 16/25 system: Allow restricting legacy ld/st_he() 'native-endian' API

All the series I posted this week build fine without them.

