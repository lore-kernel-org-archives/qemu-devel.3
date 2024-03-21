Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C21C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 09:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnEvZ-000129-ML; Thu, 21 Mar 2024 05:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnEvW-00011u-2v
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 05:41:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnEvD-00047a-SW
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 05:41:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ed4dd8659so1145976f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711014074; x=1711618874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHGTdUrfJ2OJJGZSGitfA6//HTCzp3zVUWyIwKXSxlc=;
 b=iks5hCW9efBYvmZLcQNOL1in9zzM30Ef4zLUeAyfaXlGGmbiw/rSiRvocRqEHfa4bn
 WTotk1TTaWGZu2sXMmxcrGE0ferpxeNOgyp+cpTf87ncFppbRYv3xiwtrNeZWE7dPfc1
 zlTnf7LI+3RcKlf/weJ8CTItKp7rduHRLB4x+WTPVrNQG/d61UqN3ZKnm6NgOkyX7+bM
 f6XMQhWCkoS2RdCAI82MWx5sVgZc1355ZMPl0ipYHIyQrGvQt0dBeLeCUyFUkLMk3t+H
 NGXG3U7BMD8UFlf86M8vrZMtpysfz1ZlRk3cJs60FfIkoJbc62nKtSUoSTWlu5dStpfl
 FCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711014074; x=1711618874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHGTdUrfJ2OJJGZSGitfA6//HTCzp3zVUWyIwKXSxlc=;
 b=AsIGQ09yLV0JxWGTHBLei6UdvNYzaxLu5nepIhWGlquiBMXw5CzyZe6dHJaXFNIWjI
 Ze7Y0U8yJ5vEOFoJa/cSpNnpbBBw+n16ATH8ZX9ND+pMEfQEyunecn4h3QTHKn7ZJfGA
 BZwABQioHqQEB9UKUInzlAXRWfzs0YPvpIZAb7/DzfLAoatckEejKucjNgfd+zatp0O6
 SWpfJkPNtJpXQWEoYah9RzZho7Rnznw5yf94qe0iUcHVUL/492IQIvwhnkhWKPzWJ2nR
 BalDCYYhXdpzIwZGFcE6kRWQyV1KIyymvgOgBW9qxkQVJ81KcqfkvMV7kuUAzIZlnDfi
 6YFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvFSnzH2RNhL/iJoOj9orRqPFIC/2rLpQ4m60th4IJ+k0+J04ojOd3kVlIgbgTnWfAaP9t2876+bt6quaqwkA/xXlfUJw=
X-Gm-Message-State: AOJu0Yx2ohngirJkhWR6mZrypkA1oOGyB9Rf33o8FLwpaXGMYT5OnWNb
 rUSOMoYevZrE0H19/Y7kb8wxJlUM2cmc1m25laCyYonVkC/dFYspfbc7TQX+eD0=
X-Google-Smtp-Source: AGHT+IEmK4EPaJ1UvwpkztFc1aa9hUf1MI48mAZAUwb4Hpy2vewuyB/ucBhxGnIBGcd6+ml/38L6Lg==
X-Received: by 2002:a5d:47c3:0:b0:33d:7e9:9543 with SMTP id
 o3-20020a5d47c3000000b0033d07e99543mr2308552wrc.32.1711014073905; 
 Thu, 21 Mar 2024 02:41:13 -0700 (PDT)
Received: from [192.168.167.175] (10.red-88-29-188.dynamicip.rima-tde.net.
 [88.29.188.10]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d4aca000000b0033e03d37685sm16804475wrs.55.2024.03.21.02.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 02:41:13 -0700 (PDT)
Message-ID: <eb87f161-6365-499c-9beb-6bf63ae33b96@linaro.org>
Date: Thu, 21 Mar 2024 10:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
Content-Language: en-US
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320205018.3351984-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 20/3/24 21:50, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> QemuDmaBuf struct is defined and primarily used by ui/console/gl so it is
> better to handle its creation, initialization and access within ui/console
> rather than within hw modules such as hw/display/virtio-gpu and
> hw/vfio/display.
> 
> To achieve this, new methods for allocating, initializing the struct, and
> accessing certain fields necessary for hardware modules have been introduced
> in ui/console.c.
> (3rd patch)
> 
> Furthermore, modifications have been made to hw/display/virtio-gpu and
> hw/vfio/display to utilize these new methods instead of setting up the struct
> independently.
> (1st and 2nd patches)

What about dbus_scanout_texture(), should it use dpy_gl_create_dmabuf()?

> Dongwon Kim (3):
>    hw/virtio: intialize QemuDmaBuf using the function from ui/console
>    hw/vfio: intialize QemuDmaBuf using the function from ui/console
>    ui/console: add methods for allocating, intializing and accessing
>      QemuDmaBuf


