Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED9C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrVf-0006yw-Ji; Mon, 22 Jul 2024 07:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVrVd-0006ra-NP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:47:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVrVa-00034L-Fx
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:47:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4266ed6c691so27736025e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648833; x=1722253633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJWII8p1HGH5CGdFfESiYUa2TDJwq31vVH6rzS5Rckw=;
 b=p6WDhUlucF9n4T3hyMgbRwdgzubOxlX9+WU6P9w3sZJivDvGDChCuobHMs+MVNBReR
 UgHAV86JjHp1JoZm0SCrsfbLiExdHUJzaBhLzABgA5Aql/mjh+/KEXtajkffIAr/pZdw
 40m1fNWEi/MZJJvuVNS+C2zd36ZyeTRS6/1PeGMUFBeBO0hBWLKPV9AZxF6Pr4gA4Vin
 Mcx54rP/x9M61SozWjBzX4Q2OgIB44iXOTksi47bVrjeojhiXpxG1qR00zy57e2bBqPX
 r1/cOPk+9Qj2seSpercaUUv1DWs5awp06GTanmF0T0+jkAG0JP6JbZZ0krH1g1q/stlz
 c8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648833; x=1722253633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJWII8p1HGH5CGdFfESiYUa2TDJwq31vVH6rzS5Rckw=;
 b=lCI9t+98cs++q2hd9i9XZjpDH50d6StEy5Rc4pAZAdHuhg1g03GSjQs2KT2Q4OQ6rN
 4vTSIu5QdZS0+NLhhlXjrvUY9eTnMXklG4cUEec197wqigHKo5hE2QhBMoFr2wiLMa6Q
 rBQ57MqnDXSpFabJDx33lqipf01usIm/WG49dYmhqC13K1bnZUieBjjNGaBrADMXzuDC
 Esireg/Mht4fAEE/bnz3AK5RM9r6Beneu2Sy4ccXjOHijcewAqsrVA6UNRp820yIOnlt
 NLyx44eoW6KduCGcldY6PtTzF1WAoDXv4dyQkV5o91dFL9JWPdxzfDFghIif7MqTOr0G
 DnLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn5On0H6MzKIiVCC+8Nax1MAniaJCE+Scs80SkYYQN/NDwoENiuNxmJmwo3gBCka1LOCHbzu1Gw4pqwDrqmpQhBXrs3Lw=
X-Gm-Message-State: AOJu0Yy55kMw6CyBdrFNUfHrP7MXjqtfXLVor2+LtjvVXj1ncT9g4Cxs
 VBgYVHs0VEIqkybl1UpFm+4WzIn2y4qor+8Hd+l3pLrbrdnPooJ1XbIlmKCuCz4=
X-Google-Smtp-Source: AGHT+IE9OgVYg8k0WxAaAsIzetXsx9CrTAohvFCYIJCcvs2QAVyCNmsLT4XTfZqwMmJQnAK8oMV/yg==
X-Received: by 2002:a05:600c:4f88:b0:426:6220:cb57 with SMTP id
 5b1f17b1804b1-427daa622b3mr42804105e9.25.1721648832796; 
 Mon, 22 Jul 2024 04:47:12 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929976sm125043835e9.29.2024.07.22.04.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 04:47:12 -0700 (PDT)
Message-ID: <96679d63-c6b7-4d49-8555-8ecb89b0f994@linaro.org>
Date: Mon, 22 Jul 2024 13:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 16/16] hw/char/pl011: Implement TX FIFO
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-17-philmd@linaro.org>
 <4e6b616f-3acc-4130-9b92-1af7fed540da@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4e6b616f-3acc-4130-9b92-1af7fed540da@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/7/24 23:25, Mark Cave-Ayland wrote:
> On 19/07/2024 19:10, Philippe Mathieu-Daudé wrote:
> 
>> If the UART back-end chardev doesn't drain data as fast as stdout
>> does or blocks, buffer in the TX FIFO to try again later.
>>
>> This avoids having the IO-thread busy waiting on chardev back-ends,
>> reported recently when testing the Trusted Reference Stack and
>> using the socket backend.
>>
>> Implement registering a front-end 'watch' callback on back-end
>> events, so we can resume transmitting when the back-end is writable
>> again, not blocking the main loop.
>>
>> Similarly to the RX FIFO path, FIFO level selection is not
>> implemented (interrupt is triggered when a single byte is available
>> in the FIFO).
>>
>> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: Something is still broken, some characters are emitted async...

[*]

>> ---
>>   hw/char/pl011.c      | 60 ++++++++++++++++++++++++++++++++++++--------
>>   hw/char/trace-events |  1 +
>>   2 files changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>> index cfa3fd3da4..9f72b6a765 100644
>> --- a/hw/char/pl011.c
>> +++ b/hw/char/pl011.c
>> @@ -240,7 +240,9 @@ static gboolean pl011_xmit(void *do_not_use, 
>> GIOCondition cond, void *opaque)
>>   {
>>       PL011State *s = opaque;
>>       int bytes_consumed;
>> -    uint8_t data;
>> +    const uint8_t *buf;
>> +    uint32_t buflen;
>> +    uint32_t count;
>>       if (!(s->cr & CR_UARTEN)) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to 
>> disabled UART\n");
>> @@ -249,25 +251,40 @@ static gboolean pl011_xmit(void *do_not_use, 
>> GIOCondition cond, void *opaque)
>>           qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to 
>> disabled TX UART\n");
>>       }
>> +    count = fifo8_num_used(&s->xmit_fifo);
>> +    if (count < 1) {
>> +        /* FIFO empty */
>> +        return G_SOURCE_REMOVE;
>> +    }
>> +
>>       if (!qemu_chr_fe_backend_connected(&s->chr)) {
>>           /* Instant drain the fifo when there's no back-end. */
>>           pl011_drain_tx(s);
>>           return G_SOURCE_REMOVE;
>>       }
>> -    data = fifo8_pop(&s->xmit_fifo);
>> -    bytes_consumed = 1;
>> +    buf = fifo8_peek_buf(&s->xmit_fifo, count, &buflen);
>> -    /*
>> -     * XXX this blocks entire thread. Rewrite to use
>> -     * qemu_chr_fe_write and background I/O callbacks
>> -     */
>> -    qemu_chr_fe_write_all(&s->chr, &data, bytes_consumed);
>> +    /* Transmit as much data as we can. */
>> +    bytes_consumed = qemu_chr_fe_write(&s->chr, buf, buflen);
>>       trace_pl011_fifo_tx_xmit(bytes_consumed);
>> +    if (bytes_consumed < 0) {
>> +        /* Error in back-end: drain the fifo. */
>> +        pl011_drain_tx(s);
>> +        return G_SOURCE_REMOVE;
>> +    }
>> +
>> +    /* Pop the data we could transmit. */
>> +    fifo8_pop_buf(&s->xmit_fifo, bytes_consumed, NULL);
>>       s->int_level |= INT_TX;
>>       pl011_update(s);
> 
> One of the gotchas with Fifo8 is that whilst fifo8_push(), fifo8_pop() 
> and fifo8_push_all() will wrap the FIFO buffer, fifo8_{peek,pop}_buf() 
> do not. For example fifo8_num_used() could return 15, but if 
> xmit_fifo->head is set to 15 then fifo8_{peek_pop}_buf() would return 1 
> leaving 14 characters in the FIFO at the end of pl011_xmit().

Wow, indeed this is the problem [*] I was facing :) <3

> Possible solutions could be to use a loop to send one character at a 
> time similar to:
> 
>      while (fifo8_num_used(&s->xmit_fifo)) {
>          uint8_t c = fifo8_pop(&s->xmit_fifo);
> 
>          if (qemu_chr_fe_write(&s->chr, &c, 1) == -1) {
>              fifo8_push(&s->xmit_fifo, c);
>              break;
>          }
>      }
> 
> Or else use a solution similar to the one I used for ESP at 
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/esp.c?ref_type=heads#L200. I did think about whether it was worth adding a function similar to the one used for ESP to the Fifo8 API, but wasn't sure it was worth it at the time.

Yeah clearly this DTRT. I'll extract this method.

> 
>> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
>> +        /* Reschedule another transmission if we couldn't transmit 
>> all. */
>> +        return G_SOURCE_CONTINUE;
>> +    }
>> +
>>       return G_SOURCE_REMOVE;
>>   }
>> @@ -290,6 +307,10 @@ static void pl011_write_txdata(PL011State *s, 
>> uint8_t data)
>>       trace_pl011_fifo_tx_put(data);
>>       pl011_loopback_tx(s, data);
>>       fifo8_push(&s->xmit_fifo, data);
>> +    if (fifo8_is_full(&s->xmit_fifo)) {
>> +        s->flags |= PL011_FLAG_TXFF;
>> +    }
>> +
>>       pl011_xmit(NULL, G_IO_OUT, s);
>>   }
>> @@ -488,10 +509,24 @@ static void pl011_write(void *opaque, hwaddr 
>> offset,
>>           pl011_trace_baudrate_change(s);
>>           break;
>>       case 11: /* UARTLCR_H */
>> -        /* Reset the FIFO state on FIFO enable or disable */
>>           if ((s->lcr ^ value) & LCR_FEN) {
>> -            pl011_reset_rx_fifo(s);
>> +            bool fifo_enabled = value & LCR_FEN;
>> +
>> +            trace_pl011_fifo_enable(fifo_enabled);
>> +            if (fifo_enabled) {
>> +                /* Transmit and receive FIFO buffers are enabled 
>> (FIFO mode). */
>> +                fifo8_change_capacity(&s->xmit_fifo, PL011_FIFO_DEPTH);
>> +            } else {
>> +                /*
>> +                 * FIFOs are disabled (character mode) that is, the 
>> FIFOs
>> +                 * become 1-byte-deep holding registers.
>> +                 */
>> +                pl011_drain_tx(s);
>> +                fifo8_change_capacity(&s->xmit_fifo, 1);
>> +            }
> 
> Presumably this is the part where fifo8_change_capacity() is required: 
> what does changing the FIFO size to 1 do here? Is it possible to move 
> the fifo_enabled check into pl011_read() and pop/clear the buffer there 
> instead of changing the FIFO size?

Again I tried to stay close to the datasheet description:

   3.3.7 Line Control Register, UARTLCR_H

     Bit FEN: Enable FIFOs

       0 = FIFOs are disabled (character mode) that is,
       the FIFOs become 1-byte-deep holding registers

       1 = transmit and receive FIFO buffers are enabled
       (FIFO mode).

But indeed it could be clearer to handle the FEN bit and do FIFO
enabled check elsewhere, I'll have a look.

Many thanks for your review!!

>> +            /* Reset the FIFO state on FIFO enable or disable */
>>               pl011_reset_tx_fifo(s);
>> +            pl011_reset_rx_fifo(s);
>>           }
>>           if ((s->lcr ^ value) & LCR_BRK) {
>>               int break_enable = value & LCR_BRK;
>> @@ -636,6 +671,11 @@ static int pl011_post_load(void *opaque, int 
>> version_id)
>>           s->read_pos = 0;
>>       }
>> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
>> +        /* Reschedule another transmission */
>> +        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, 
>> pl011_xmit, s);
>> +    }


