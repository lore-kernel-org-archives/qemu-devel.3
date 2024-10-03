Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC6CCF34C3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swT9e-0001LU-4s; Thu, 03 Oct 2024 17:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swT9c-0001Kx-1O
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:14:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swT9a-0002W6-DS
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:14:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso13010935e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727990069; x=1728594869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y/FiKwEQtzIllpWf/huDp/8qVIbiBSmNTcCwpny6jN4=;
 b=BEj0Y37bAFD5MRqMuzFwSMumk809O/5a2WYaRrae4P3fF83HsQ2oXcMbb9OjEgDhuW
 rZ1MmUhRYsgijK5GZKeMu28OAP4fyVQYrw6nLDuPidLuzgbfoUoK/XIHaelLHB0te4YL
 K3xLE3p7mhCEjz7Kzv3MnpbnnQd5rR31gXhfblry7kwSQmq0G0aTN8AC+Hj13LQ4OS8r
 PtJirwuSQnaJzLvS2SUe8FiIOqux5hlPNsUnABZoNO4iV43ZvHcfj84+JoDUkc12tDKP
 8reiLWCDkRVQrS0aHTORP0qfBlTFuxr09VUMqbbDVzt4qafIhAZyiCChiVRC5/ksE6tY
 UaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727990069; x=1728594869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/FiKwEQtzIllpWf/huDp/8qVIbiBSmNTcCwpny6jN4=;
 b=t2CrReRB08Di1xIn916oXib9Sz+ewC81QyApwkJQKEOBe6ujE5/WH3ktBx0JFDCDwF
 RlRKB4hVEgnGIecBGsslWJ37t44uv4NFZ741VOvp45wouyYz/MEYA2AUSyJs8ta5vuj6
 9Rpjm9x1B184GWUPb9nYq9F8/bDB60Tj2vwPXd9ttIHbdiO9yfq9W8Eok2XNM68PuD3w
 8jGmccI5iMBNbPxyCVXVL0uH4CuzDSRe1K7UuIjmyWCwj/JLUA1f/2eGn03ACLlkSoNt
 bAPhQQT2Q5dHBWy4IXoxWom0U7M4SlzA9PutrBW3mZKP70g7QLoJkiM/1Fc12FeFxc2o
 wd2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5mT0YxESey/BB7i+uoC5NhWOFb2qso/nk/3TErPS6ATPQp6GGeR3u3cpfR8RJM0RJ+Vi3dCa33dpm@nongnu.org
X-Gm-Message-State: AOJu0YwlPDLacRqhKJLhV1NmGicZdm7LV4SogXEIO4cfXk0oSXNe/HOk
 2sAPXgoKNLlqoiUtcenhZ9Sz/OjSUoMLhLKDhLxIDu7XS31BhNcXr8cQmX7lA2M=
X-Google-Smtp-Source: AGHT+IFpWMncJuJSCjk+l4zOWqhzYWh1b/ubMxKn7Wu021W+7RnUnxTf6PZdS4XPP6Z0Hefup0aalQ==
X-Received: by 2002:a05:600c:450f:b0:42b:afe3:e9f4 with SMTP id
 5b1f17b1804b1-42f85aa3965mr2638735e9.3.1727990068763; 
 Thu, 03 Oct 2024 14:14:28 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f80255f01sm23847665e9.9.2024.10.03.14.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:14:28 -0700 (PDT)
Message-ID: <b61ee567-7cb2-4788-8c28-745fff6fa155@linaro.org>
Date: Thu, 3 Oct 2024 23:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: Remove unused serial_set_frequency
To: dave@treblig.org, mst@redhat.com, pbonzini@redhat.com,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240918144122.155351-1-dave@treblig.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240918144122.155351-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 18/9/24 16:41, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> serial_set_frequnecy has been unused since it was added in 2009:
>    038eaf82c8 ("serial: Add interface to set reference oscillator frequency")
> 
> It looks like the 'baudbase' is now a property anyway so the wrapper
> isn't needed.
> 
> Remove it.

See previous patch from Bernhard:
https://lore.kernel.org/qemu-devel/d8ffe38c-756d-4187-875e-e6697631b7fa@linaro.org/
Anyhow no objection at this point.

> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/char/serial.c         | 7 -------
>   include/hw/char/serial.h | 2 --
>   2 files changed, 9 deletions(-)
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index d8b2db5082..6c5c4a23c7 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -951,13 +951,6 @@ static void serial_unrealize(DeviceState *dev)
>       qemu_unregister_reset(serial_reset, s);
>   }
>   
> -/* Change the main reference oscillator frequency. */
> -void serial_set_frequency(SerialState *s, uint32_t frequency)
> -{
> -    s->baudbase = frequency;
> -    serial_update_parameters(s);
> -}
> -
>   const MemoryRegionOps serial_io_ops = {
>       .read = serial_ioport_read,
>       .write = serial_ioport_write,
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 6e14099ee7..40aad21df3 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -93,8 +93,6 @@ struct SerialMM {
>   extern const VMStateDescription vmstate_serial;
>   extern const MemoryRegionOps serial_io_ops;
>   
> -void serial_set_frequency(SerialState *s, uint32_t frequency);
> -
>   #define TYPE_SERIAL "serial"
>   OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
>   


