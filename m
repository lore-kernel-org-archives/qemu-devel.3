Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DCEC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohtU-0006E5-8E; Mon, 25 Mar 2024 06:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohtT-0006Du-Eu
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:49:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohtR-0001XS-Tw
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:49:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3416a975840so3188703f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711363767; x=1711968567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04hn7x8Vy2j5CoELasEafSYZDCszvT7ODnHWOY9GTtg=;
 b=n9s834xZXtRY5koM37HW/fvuOAjoepFElDh66naemt8F0SewUEwRjLX3WbqMDQeZWF
 fLo7dlHYr8bTyPh0USMuZnRoRokK5kgzNKpBgqM1Gx8uBhyw1yFUD9agEP9PPl87ta8d
 9uwSEmx8n6AXpkGVg/JNLY8AoZQErZ4pnx8r8jAbcS70fUj+0Ssb83r7IGI+3tQFFUhH
 wUXfvl2lCDeZr+ruz/otaxxRtkgkFrSM8BHm8/i8SRRhv5+ZtI//HGd73shaeqAcOLW4
 dfxdu8Qhux11cvTApiM7bQzn1b5rMTyMItZ45GsUgIpxkqV0YiogdLB1n9cpjIX5nJNM
 ZUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711363767; x=1711968567;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04hn7x8Vy2j5CoELasEafSYZDCszvT7ODnHWOY9GTtg=;
 b=ZzWkppW3cgUKcb3Ih3ePmNt9j4AJIopE3N56EBOALahrmo7Xx0dt0WdpQQsnxy9rYE
 chEVApCmSlEcCQaxNh+IvrAsE1Hw1ZdKpAb9iE5naoI9LzX/GADd2IOR2yTTWio0uz4t
 xZBiToRUdz5Wlsq2Sb0L4WYSmUdRNxcsbtfZr46kfbAufKK7D/2ru9RSUBpn/c9tXV8m
 DODSLsV4jFP1e6o56zDP5Tkfue8Z36zJiu4nahYOh8o1waNjBUF8MdqybU3PxB9XmZmy
 pMr0yoAd9F8oZn6Ynk9XnBA7erBEFcuuQgmOBYu9rUlejm+8BOvdeTqOEw47Ajm1fqXc
 hatA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPhPZudZ7vpQPM0yLlerMR0FJYtTvoGi7rFTD8EY6L02XkFLquDHFJY5J/za1ZXbhXZytFoS6ObaNdrH50XebO4V0170A=
X-Gm-Message-State: AOJu0Yw/VvZSXknEPp6N53YWjWdP/oOsV77Src6KW4ys3LBd5nLagWtx
 N91Z+kZzG2DbYRuorBVGxsWC2O/2+pyfnUDAa7Uh70yP1jlfjM1siCqWsmk1gDM=
X-Google-Smtp-Source: AGHT+IFzG2GTMPTH613Up6Yf+pw000Yc8pUUISXx/NAnFBASl3Z/4HlvqDq/Pg1892gti4uM21n1IQ==
X-Received: by 2002:adf:c00c:0:b0:33e:6efa:757e with SMTP id
 z12-20020adfc00c000000b0033e6efa757emr4343302wre.22.1711363766890; 
 Mon, 25 Mar 2024 03:49:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a5d6b50000000b0033e93e00f68sm9235315wrw.61.2024.03.25.03.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 03:49:26 -0700 (PDT)
Message-ID: <5f8511b6-225d-4197-8785-7fb69a1b1c13@linaro.org>
Date: Mon, 25 Mar 2024 11:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] esp.c: don't assert() if FIFO empty when
 executing non-DMA SELATNS
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-11-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
> The current logic assumes that at least 1 byte is present in the FIFO when
> executing a non-DMA SELATNS command, but this may not be the case if the
> guest executes an invalid ESP command sequence.

What is real hardware behavior here?

> 
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 1aac8f5564..f3aa5364cf 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -762,7 +762,8 @@ static void esp_do_nodma(ESPState *s)
>   
>           case CMD_SELATNS:

Alternatively logging the guest abuse:

               len = fifo8_num_used(&s->fifo);
               if (len < 1) {
                   qemu_log_mask(LOG_GUEST_ERROR, ...
                   break;
               }

>               /* Copy one byte from FIFO into cmdfifo */
> -            len = esp_fifo_pop_buf(s, buf, 1);
> +            len = esp_fifo_pop_buf(s, buf,
> +                                   MIN(fifo8_num_used(&s->fifo), 1));
>               len = MIN(fifo8_num_free(&s->cmdfifo), len);
>               fifo8_push_all(&s->cmdfifo, buf, len);
>   


