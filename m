Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44060CED606
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJie-0004nA-PN; Tue, 18 Nov 2025 06:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLJid-0004n1-QZ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:17:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLJic-0003dM-AA
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:17:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477632b0621so35259985e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 03:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763464672; x=1764069472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8sT0A1yKIEvLuBMFPWoviLf+MQAfw2tVjxlZahaU3IE=;
 b=mkFIrFcO+D/y/anxFaFitgIELYJg3T2E8Y2a/aa6ki6Piv6XRA7Z+lel/vEL3VsvHY
 aehYNiP+npAduZiQsvr6H0wRcwE9ErSoTAYkoGTRI82xfDG92iz4LsMhP9Ybrj+P8z1D
 v4kksPk8w2g0AMtrpTqwo2/FWd6cVVkwl/1bXLrUmJEjDNTXPKKCopHwhg/AiA9+cmgq
 N02AS1aXZHhjRtIGAkGB2HtnROGeglCGVJHNmTC2uFE1nNTXgdApa6V1ttfqz7xM6qaC
 Sg30L/bALO9SwMQOxPfCpANnGjYWa77xYj7cLeJOlsBhD8jqSgZqyBm71Lbke452zBBz
 Hf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763464672; x=1764069472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8sT0A1yKIEvLuBMFPWoviLf+MQAfw2tVjxlZahaU3IE=;
 b=sLZk/aH61J8wXoifeze1o5m0ZaXVDrz8TYwR5EpOYV2QL/B2l8RpYPkgTKjEVvyZS4
 DrNbc5ytdiy/F9d97c+GXNWKR+/s7BEWwkD5etK/WWQiUbNPrzHRiWGhLM8dxdIZKIGL
 6OZteEdHOPSnw5gRN1pC3Lhy4eMEHuANVODOTYlKawfwTVh+Jd6cSJT/xq2EjPxqvg7X
 2uhGxMenfsNWBI9H9yPetSGLsSY7znNF+7f3T0v60RO0wvDMSeNIz15J4Ykevsr6QXRh
 4o1knke3EZ8528lSVBcP5U86AwegHwRg9UUtbWCBkLlnKdfIiJFfxp5ozc2y6RXoOpF5
 IBFA==
X-Gm-Message-State: AOJu0YxVG+Ph1manDRJfbuYsX330vZch1r++oj9t+tSqN0UmVqa+dQ+R
 70Ack/lar9rtD+Tn4O0FwXr42mxW8KWxMQ4y7thj2YW/cPFyP9khyTHDgK1mg22KQvckBwwRJCo
 edpvGmZCiuA==
X-Gm-Gg: ASbGncvydENYSb92Djt7qXDWirg1udoi9Objy1hzayv2w5TVEkUohCX3n+0X/5oN86t
 kmdAii1q+5GdLCL2SODn77EYU19Yiy2iHL6amc0HqdgJmkkViy4qIE4j6KLZCN5GLApnWADX/bb
 30GQ+eSW/dgIECQDim8atnJnqPi8DeQ0MjLRL5pwX5/TLSUFqnbJeEHkz44xny9szC47yxFEv9/
 E/jLruxvq7cf89jut1nOYKTdLiX6wU3xI6bbvhes1YpAzU++FeZIsE+nmJjXjLUeEy02l6pCu7V
 esOFLUN8is02F+zf8DNN3qYTS9uA9OSXEgbju2790vP9kggG5YEVbP5305IXP7P15cu3sNFqdl7
 44UZgmog3chPulRruc7KzdpS328WjnpTYODQ4wvwX8CCcvbgaiFFSCepmXeh9XdtC6t0a3dOubn
 9Al3r9ofSb8U8dsdPuUQ5O4lPQj6w1m8gFme0Z4DV2xT3OxSWSU0uCOcOSn0/0xL8Y
X-Google-Smtp-Source: AGHT+IGcqyXOqZlR+BNG+d6eKp96anWUOMFVw2vRwfcbU3prWxAN0VnHlB9ZuXcq2aPdUlkFbjqYgg==
X-Received: by 2002:a05:600c:a45:b0:477:3e07:217a with SMTP id
 5b1f17b1804b1-4778feb10f7mr141003755e9.36.1763464672449; 
 Tue, 18 Nov 2025 03:17:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84b12sm32931819f8f.15.2025.11.18.03.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 03:17:51 -0800 (PST)
Message-ID: <038c229c-2b94-4294-a73b-093b74030838@linaro.org>
Date: Tue, 18 Nov 2025 12:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] roms: Do not try to build EDK2 for 32-bit ARM on
 Fedora
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251117140420.62193-1-philmd@linaro.org>
 <vnutsclexonswf5dv2nx5qjp3v2k5gtcpkseqhvojtjbeag2f5@q7i2zxhw5r4z>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <vnutsclexonswf5dv2nx5qjp3v2k5gtcpkseqhvojtjbeag2f5@q7i2zxhw5r4z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 18/11/25 08:09, Gerd Hoffmann wrote:
> On Mon, Nov 17, 2025 at 03:04:20PM +0100, Philippe Mathieu-Daudé wrote:
>> With Fedora 27, support for 32-bit ARM hosts was dropped.
>> QEMU also stopped building the docker images in commit
>> 0054dc8bde4 ("Update lcitool and fedora to 37").
> 
> /me fails to see the link to the patch ...
> 
> This is about the /guest/ firmware images, and they are
> cross-compiled.  And note that you can run 32-bit guests
> on 64-bit hosts (if supported by the cpu).
> 
> Note that I have no objections to removing the 32-bit edk2
> firmware images.  Upstream edk2 is in the process of removing
> 32-bit support, so that is going to happen sooner or later
> anyway (for both arm and ia32).  Also UEFI on 32-bit never
> really took off in the first place.
> 
> But when doing so do it properly please.  Remove build config
> (in edk2-build.config), pre-built binaries, maybe also test
> cases, ...

I only have handy Fedora 42 and 43 VMs where this script doesn't
work anymore. I'm not really interested in installing a pre-37
Fedora to build EDK2 ARM, nor motivated right now to clean this
"properly". Better we wait EDK2 32-bit removal upstream and then
clean these QEMU scripts.

Regards,

Phil.

