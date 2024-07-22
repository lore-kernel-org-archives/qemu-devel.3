Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC948C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVveW-0003sW-5j; Mon, 22 Jul 2024 12:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVveV-0003o5-1K
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:12:43 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVveS-0000Tz-Nq
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:12:42 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77c1658c68so484213466b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664756; x=1722269556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUnEZQeXXlZXeNXnnbVEIVnP0pQsNfyfJir/+RcM/Qk=;
 b=FDEXFoSaqu5lT+vK7jsVO8CStFvuXI0qQqVwMY2H3HAoAJnlK7WGwKMhsN7/poLqtS
 wTq8ddlaqfkZf1W/Rq1lrIzqrZImIwxi2n/OcQmWWWT1+AP8JJBCzG0j6x1rwRLGWw9x
 GdW+6rB/Fv60fgacxDb4I93MPX4s5pTU+BGgnQF9q6aafKgQPlVEPM/x3iUF8jGcaOEi
 qvXoMQ0QwkyZQx9L55C4hkjYOYRzBwn45AYBqWyUZCbENIfti+747wuO6YIb/8sB4RSE
 pxso2mF9yD8IFTrYvrqoT8rDOXx6zSjqbKNAucpnSJrZ51muZWcTV7qU/Gv3i7NiX2NO
 p1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664756; x=1722269556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oUnEZQeXXlZXeNXnnbVEIVnP0pQsNfyfJir/+RcM/Qk=;
 b=fshF4lJRCQOE7ZKIj86B0FS0iySk042MfhnrRrFcnjBiZixvFQrGn3GAccoPyib3qY
 tv0ZYnMkm+1N9mcE7QEvny97rFRIYwJaUCaQldsMOwxDBpiFK7136dbTjiJCXpp6UsWo
 QUthBPF7gLrYBGhuDFjeYd4Y67UPcpP+mywnLIkLiusMNnKTZ4p7iM3JeT0IVNJScHzN
 tzXb6B36PuFhF2ZTAah1wLL/FrcAgqOG11u5IgJlvzTa0NU/xh6euyKxw45/Neuetvv8
 OCBZrtHX3BpCKYK7bXpP7J4B5Xl+I8bpkpvR7I2GY+HRR886CEKuMwmpQt+UwSUw0frZ
 PULA==
X-Gm-Message-State: AOJu0Ywsal0q+5rgnK3imyG6NbyhWUrxoa4827e7Fog6zSaR951G//f6
 q6p6HDrWLQShJpnnQq3gJW2qU4iGeSJTkzlfGcpH6vm+WSpe5MtvWTGP4QnxrXUcqrcLOn2jrvJ
 m
X-Google-Smtp-Source: AGHT+IFBdHT+9u4/6WWaBwixYdDF3EWAbkW+CHFw0mN1R1XySX24ipX+3w+XMa7/1tXuIG2Dt7liqg==
X-Received: by 2002:a17:906:6a18:b0:a7a:8876:4429 with SMTP id
 a640c23a62f3a-a7a8876449bmr24577166b.45.1721664756132; 
 Mon, 22 Jul 2024 09:12:36 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c7be6edsm441133966b.85.2024.07.22.09.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 09:12:35 -0700 (PDT)
Message-ID: <18f7d975-617e-4791-b921-7df7c9ef2d1d@linaro.org>
Date: Mon, 22 Jul 2024 18:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] util/fifo8: Introduce fifo8_discard()
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-8-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722160745.67904-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 22/7/24 18:07, Philippe Mathieu-Daudé wrote:
> Add the fifo8_discard() helper for clarity.
> It is a simple wrapper over fifo8_pop_buf().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/fifo8.h | 8 ++++++++
>   hw/scsi/esp.c        | 2 +-
>   util/fifo8.c         | 6 ++++++
>   3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index 21c7a22937..53bafabd25 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -129,6 +129,14 @@ const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
>    */
>   const uint8_t *fifo8_peek_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
>   
> +/**
> + * fifo8_discard:
> + * @fifo: FIFO to consume bytes
> + *
> + * Discard (consume) bytes from a FIFO.
> + */
> +void fifo8_discard(Fifo8 *fifo, uint32_t len);
> +
>   /**
>    * fifo8_reset:
>    * @fifo: FIFO to reset
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index cec847b54a..c703fa7351 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -351,7 +351,7 @@ static void do_message_phase(ESPState *s)
>       /* Ignore extended messages for now */
>       if (s->cmdfifo_cdb_offset) {
>           int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
> -        fifo8_pop_buf(&s->cmdfifo, NULL, len);
> +        fifo8_discard(&s->cmdfifo, len);
>           s->cmdfifo_cdb_offset = 0;
>       }
>   }
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 6610b79182..ea39ca2552 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -131,6 +131,12 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
>       return n1 + n2;
>   }
>   
> +void fifo8_consume(Fifo8 *fifo, uint32_t len)

Sorry, forgot to s/fifo8_consume/fifo8_discard/.

> +{
> +    len -= fifo8_pop_buf(fifo, NULL, len);
> +    assert(len == 0);
> +}
> +
>   bool fifo8_is_empty(Fifo8 *fifo)
>   {
>       return (fifo->num == 0);


