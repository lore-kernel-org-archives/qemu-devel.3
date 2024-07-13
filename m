Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3573FC3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 21:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSjzD-0008UV-9L; Sat, 13 Jul 2024 17:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSjzB-0008TE-6l
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 17:08:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSjz9-0004ab-Gr
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 17:08:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d3aso19416065ad.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 14:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720904930; x=1721509730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xn496lNfN+tjORBu0zJyIt7OHIqjOOBmYg4cfigffiY=;
 b=KXqDa/zyrMfqW6lQF6SVduSrPYyorubkcLcvL0VltdmGU5GaG+8/Bv4HZunV07IRV5
 mwrklMRO7g6D0jOruTEqzJvSsvFP99Yixu3CzKfDIs3BvDRaAibotamDM53jfS7kDfPj
 aW/+BeRnIiojObjwvnmZGzBC2tprInQXSN/6ymVsDq0sLKGl47Zs7+PZYbVaOtHGsz9S
 QvBlRHR54rqcAJPGQK+G7feodzEB+9w1w0e5tJT9q+w+JLMGKcLHGduiwK0+ujyUy3RZ
 PBKvuwePMBOw0Dou2qxPf80tTLf86P5BSWK3nTZ2I25dTXZo5rp+ksulFPLw4nFXqySr
 szBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720904930; x=1721509730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xn496lNfN+tjORBu0zJyIt7OHIqjOOBmYg4cfigffiY=;
 b=tJSwaQewB9V8PryiBZFoVwW8TLxiG5EzsQ02uPGdPYvFJII8UcT/TwQq1UaSs/ZY/S
 fOIsUjxkiR0HQ56So6ymrNbG8+qsFoDsoIctypLpUz4TE/P8iAl//hhI8UQl+wIMVzqP
 efb/qKVhDPyf7V1DhQd0HrICkGk5Er90ePqQmdC01BnNyF3gf0R0G8pV9jU9wAnEGCZO
 dBFzoZFKQUfo+Ll6Ntl1rk6gMRtFr6SgxYSCD/irbdlDNYkAkizGmzcW3hUIyh1n9vCg
 Nbrd9jtkkRrT/9f0cLBeZsh9qJfPSsflqt0/GvxM7u/hss062TYk86FrAvjINKkFc80l
 4o9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR4ThlJ4mDhNdZyg0xEJtk0sViqGjY8ne0yGZasdjUHzZ5ULswCFY3wGQ4Qpj9hbMjUNrpftF12ob/OWxbJkGKdW+hI6s=
X-Gm-Message-State: AOJu0YxWD7GRx5S+BySXjnHSIS73VJnFabbEskHo/59OpQEzqUARU+Mz
 qtIxAsMtV7+u1lASEU0a+4Ldg2P3fVB7YvuGSHxXmDBVeJslQprzl4bPURJCeJ0=
X-Google-Smtp-Source: AGHT+IF4PN1YN7TVV73R1E/KQ23keuh/o7oYVoBgdMsRREfaGcyHrGIoZuH2mNiO/644HhskMNdGJw==
X-Received: by 2002:a17:902:d490:b0:1fb:4f91:6728 with SMTP id
 d9443c01a7336-1fbb6d5fee1mr139785165ad.42.1720904929989; 
 Sat, 13 Jul 2024 14:08:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.129])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc509e8sm14109325ad.284.2024.07.13.14.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 14:08:49 -0700 (PDT)
Message-ID: <bf42c103-2328-4278-98a0-0df732515aa3@linaro.org>
Date: Sat, 13 Jul 2024 23:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/bcm2835_fb: fix fb_use_offsets condition
To: SamJakob <me@samjakob.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>
References: <20240713155656.59431-1-me@samjakob.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240713155656.59431-1-me@samjakob.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 13/7/24 17:56, SamJakob wrote:
> 	It is common practice when implementing double-buffering
> 	on VideoCore to do so by multiplying the height of the
> 	virtual buffer by the number of virtual screens desired
> 	(i.e., two - in the case of double-bufferring).
> 
> 	At present, this won't work in QEMU because the logic in
> 	fb_use_offsets require that both the virtual width and
> 	height exceed their physical counterparts.
> 
> 	This appears to be unintentional/a typo and indeed the
> 	comment states; "Experimentally, the hardware seems to
> 	do this only if the viewport size is larger than the
> 	physical screen". The viewport/virtual size would be
> 	larger than the physical size if either virtual dimension
> 	were larger than their physical counterparts and not
> 	necessarily both.
> 
> Signed-off-by: SamJakob <me@samjakob.com>
> ---
>   hw/display/bcm2835_fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index e40ed2d2e1..650db3da82 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -145,7 +145,7 @@ static bool fb_use_offsets(BCM2835FBConfig *config)
>        * viewport size is larger than the physical screen. (It doesn't
>        * prevent the guest setting this silly viewport setting, though...)
>        */
> -    return config->xres_virtual > config->xres &&
> +    return config->xres_virtual > config->xres ||
>           config->yres_virtual > config->yres;
>   }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


