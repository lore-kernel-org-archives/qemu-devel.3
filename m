Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03736C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytQR-0003N9-GS; Mon, 22 Apr 2024 09:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytQP-0003MQ-68
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:09:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytQM-0001dX-PD
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:09:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso3165805f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713791372; x=1714396172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQqrbhd8qa7kjnHR7QKSL+wR9eb8l881ZQXLK3+a0VQ=;
 b=TL5l8md/DxYnEcJmJ5PDr6V8keNJyGIuPnxA1Wfm446hZIjqbgntpQRC/1OlyKhQQJ
 PnxKMfE1g2iVghBq9BErnYW6IngXk8Wd+QLlhc/jgyR9615cz057O4v1GkFykcyLEmMW
 uzkYFoq8/g4zbVrRc8ypNiDWbTOpHdwL6zHuKGfhgIlnugk/IyFhUbuyCIK+ncSdBWdG
 dkjkXxxDqYYthghwtSLoYasB3sO1TU4eY2x8PlodAVLlX0k08whusZCrh0Y/QOUUvJRW
 93n7s7J9uGpB6X3mon7O8ULLZTUkzU/CH0H/EP4jjW5DjMoNI3+yA9dJMYKe23lghQrI
 7QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713791372; x=1714396172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQqrbhd8qa7kjnHR7QKSL+wR9eb8l881ZQXLK3+a0VQ=;
 b=FRb/2onSZJC4rUBWKRKsdX1yxvHmMrNsHq0ex3SzscSYJ6LzXWp4Cefi3uHM+vhmVG
 ZB8t4iU4/IomKhKFInCIPF8Wyla5nqrKfcnmE9bPmknDMhDn7fou5R0ON3pvq5M3qPv/
 A1Ito0iteY/duvYop7a8/tG0PUAaw73RSnSQFleJQovWIKGNZsJGSVi8tcT9gOAYiASM
 SwTSS0NFwGfsBUA3YMD85WQvY7Ls9T/kMO3wN7BeVuCMZ3rPHjCYrfko7ZBMd0dQL+Rx
 KKm5RqLyA1WJl3a/D47MhK1SwpYJj1c467E+N9m8xPJywjJLgz469SUsxe+aEL+ald08
 7pHg==
X-Gm-Message-State: AOJu0YwHkI8a+gtwHTQPrwebge7PsL10uFDBmAADKJpPzidYSC6O0LA6
 FnrPcTbmp6sURMDVpohQUQtp3v1CU8nTRd7EwKIRH8Xo42i4Z/Gy4TA0ShsIyn9GnCZO2fbNVad
 G
X-Google-Smtp-Source: AGHT+IFw6mprnylPFlQqfkpaMM0qJmVXdruqvAsVto8b8Svu/M5HmuX03jExnZHx9wr+K5BsamS6hQ==
X-Received: by 2002:a5d:4450:0:b0:347:4ba8:ede5 with SMTP id
 x16-20020a5d4450000000b003474ba8ede5mr6410385wrr.13.1713791371996; 
 Mon, 22 Apr 2024 06:09:31 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 a3-20020adffb83000000b0034b32e5e9ccsm1558022wrr.64.2024.04.22.06.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:09:31 -0700 (PDT)
Message-ID: <335ba8e4-1e5c-4080-bc11-e01f63169a18@linaro.org>
Date: Mon, 22 Apr 2024 15:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org
References: <20240422130416.1891-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422130416.1891-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 22/4/24 15:04, Philippe Mathieu-Daudé wrote:
> Since VirtIO devices can change endianness at runtime,
> we need to use the device endianness, not the target
> one.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)


> -static void virtio_snd_get_qemu_audsettings(audsettings *as,
> +static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
>                                               virtio_snd_pcm_set_params *params)
>   {
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
>       as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>       as->fmt = virtio_snd_get_qemu_format(params->format);
>       as->freq = virtio_snd_get_qemu_freq(params->rate);
> -    as->endianness = target_words_bigendian() ? 1 : 0;
> +    as->endianness = vdev->device_endian ? 1 : 0;

Err, I neglected to consider VIRTIO_DEVICE_ENDIAN_UNKNOWN :/

>   }


