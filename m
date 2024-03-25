Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7BFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohSc-0006Ke-Oh; Mon, 25 Mar 2024 06:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohSa-0006Jw-9w
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:21:44 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohSY-0005ps-LU
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:21:44 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d485886545so72841111fa.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711362100; x=1711966900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0fjChlDvswqJPWd5zH1GS3wDKOweoNv1xSt85R+BlS0=;
 b=XE0fEaVKCc2Oz7WyTEaaE5BLsgcvatFrHfWzN+8QJistqQGPp/OiWy6SKzg7YnsYJU
 mFKBkjVNPGAntQvLP7062W4Z1VjSy1duN2oFdn6zY3OFYyZUUrbTT8z1/HvfYVtkajTR
 0RHQ4N1Zhnb/d5n+oUuw94bagVEuqALwKGXHuKEI8B9tA5WWK3GYcff1Bjt1x+rVyIp3
 2gpRm/i+ZJbw4XOO4Vww/643aKOrJ6FQOFlf6Mg/NwSPxzfEFreNDF+0WugC720QgDLu
 lrrS+SfBc31p9bRxbEtakLy5K/mNXJQcx5TTRfQzKaFqXWBomVWCtCTf8WKDAo7eGmVg
 CDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711362100; x=1711966900;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0fjChlDvswqJPWd5zH1GS3wDKOweoNv1xSt85R+BlS0=;
 b=tl85OvM2VWLAh2Hveq/I/IxMrmvFs86kQl6H1m8Ly5YbISVHiixUYIx7a1J+3VBe9b
 CyMAIlpb0uPb6X2rLOWuMOHVhkmb3EcmZU1VHjdhDgT2FD6c68cK6/9TDEBewtH+YCKL
 Wfxf/r+zghQB8xl0MuU07by7de+4yTw97rWECjhndxcWW+BcNE4C+3pIuePGhvU1gWm6
 NpbvhxqWLtSwTbZWr8RDzSnkqGWFs8Mfq6KHJ+1d4S3glfrwda5hRAZsq+MJF+DvWuZR
 J1fILnSiIuuYr903q0SlPNxFj73+za9+6dSqu+LbTN0S7T+xmc04RXNhycMKD2sD2BHK
 lwMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnwL0JXQYVVS/A5S79M36LB8jeozITnIzSsPWB+SY+GWB41AIXNjaOpLCiP3X5rCXNQH94kK562024PaqAONbQe2BOxyU=
X-Gm-Message-State: AOJu0Ywhqfmy9W/xsOnlC3PeseBvHOXsbSSrldfqAcZipUmPeKxCvIeI
 Fg7gk8fg0onWInIQOu1DMY4whK5A6q34L8cB7lANcVCAIkHUfrlZqzO4NY6fDRE=
X-Google-Smtp-Source: AGHT+IEUeHhQs74yQqEItYAxP3F7a6sJSD91z9gnfxziMaXbDyt7G3I2D4XB2J4AR6l/l+WSP+dZOQ==
X-Received: by 2002:a2e:8055:0:b0:2d4:6bab:15eb with SMTP id
 p21-20020a2e8055000000b002d46bab15ebmr5401253ljg.12.1711362100526; 
 Mon, 25 Mar 2024 03:21:40 -0700 (PDT)
Received: from [192.168.130.175] ([92.88.171.150])
 by smtp.gmail.com with ESMTPSA id
 hy8-20020a1709068a6800b00a46c0191306sm2885132ejc.213.2024.03.25.03.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 03:21:40 -0700 (PDT)
Message-ID: <f1a377f3-904d-487b-9737-bc361982443f@linaro.org>
Date: Mon, 25 Mar 2024 11:21:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] esp.c: replace esp_fifo_pop_buf() with
 esp_fifo8_pop_buf() in do_message_phase()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 24/3/24 20:16, Mark Cave-Ayland wrote:
> The aim is to restrict the esp_fifo_*() functions so that they only operate on
> the hardware FIFO. When reading from cmdfifo in do_message_phase() use the
> underlying esp_fifo8_pop_buf() function directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



