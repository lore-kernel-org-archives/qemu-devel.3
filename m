Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB13C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSlN-00078O-3x; Wed, 09 Jul 2025 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSke-0006SZ-Fn
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:14:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSkc-0001wB-8B
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:14:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso6284535e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752059648; x=1752664448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOao6ok8bQfixpb6MKUZTcbjWHtmeIHvBvlL01aa0NQ=;
 b=bcwIyAhXErSSNwA+uspRU3oXohv61J8HGhvHEwm2azxaWSL6kjBJlmJH7+PeuiMNS5
 YR6qqN9ZzdqpBKNoT38rbFV/u7/G3tOnE+m1yqhYC1H5SSMUNb0qWMIqbiPP0CEgJkgf
 oFLOv0Q2Rq7fa0QmoJ7BrO9Kd+Qxj6hq7Bf283cQBavR8rOhA/uCCW7uOs9xMm23luXh
 CRIW8eRfOA82DdBeS1CiPsv1pD0IG/Mx2Ots1IYhyXLhxdw2lLq5RmiZha675yALh3k0
 MBbdNBqB37wSFJZ8I6Z060Bp2qG6VndkJ3OJjwutdqPF/crQcKmUHEesx9TSEt8tMO8A
 8cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752059648; x=1752664448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sOao6ok8bQfixpb6MKUZTcbjWHtmeIHvBvlL01aa0NQ=;
 b=hYk8hl9YH+qJSugHmJJSiODFxZMxcLasULJvFzzn2vphmgzdgSgeEs2yj/CZ+5igbE
 fwckmbJm3WslpO6XB5oXPKLo9EXyO2/4zPm6aoz8AwW7qBIlwXZ6jtaVpxNR3Oq47D3Z
 Suq08D9RObz3vH74ARlvRwXAlR+JafEI3apnQmoy4QemTHbtHGA/dDPhalWoDVCnnm8X
 JmxmvTfmvUOkIuPfHRlpkT7eS9Rfpvl91uJgRUeMpt747uiqatXqKJMluWIjK7hlWRlN
 4uL59P1VCJzrvJpQ9UX2hSajDtFif/YSQYJJs8fxfnAaCvMi+YZ8VvRJSyshvN+hColR
 zizA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDnQP+AYA1ApafuAnIYf2+iNsfeJViR4Qh13eUqx2bP3PlAlwkPL9Uog+6fG03oGYz+7ONgLSr/dii@nongnu.org
X-Gm-Message-State: AOJu0Yzgqlt00IImTvn6KL8iBnGyY3gvCojHkjNYvIj5LHGzuOsmX6EU
 vNHQn+QglmgpARDuqH9zk33ulpGLPHUk+SNdDSd2Vi2Q3lvMh/FChlybgbT7McJ9Ybk=
X-Gm-Gg: ASbGncs5CVok+63FUX1donA8eNTaF94s9JxaD8KEK2JqPlBXVJvcUkkkF4YKT/JAzXR
 jiU+oVRgDBkrgmNx06LRkns60iKJwCfcjtCOyDsbZWwjtrJ1i62599McVKynddZCGbL8I+v+xno
 tA+qIDuSu3AlhXHXJlf7QVJ8yiHtFDHbTM8EWGBOvv9fSkWjxAdGnzNEHHkRN4lD8G21gTA2f9J
 TUCBq6+t0rmkBXVl7+3kXi2xOUjHew059GUVJV9uARHZzIvZ+VHxN2bIfAIJtHG39Ktt/x1urOV
 X3dCGC4dlOTcFI4wUeTtHsUevh9X831zVV7GwXvOh5N6A3mJwC8mAySBNwpgYM192QogPsIi60T
 YdMAaoIH8eabtNXnCJTNhVKNs6xXmLQ==
X-Google-Smtp-Source: AGHT+IEc2j7l7P9yKtYoeuTComdwHEmVM2ORYFP39uWI7CzhsMXTlERt/Tqxexwls3z/HW+bFYZbcg==
X-Received: by 2002:a05:600c:64c6:b0:453:10c1:cb21 with SMTP id
 5b1f17b1804b1-454d5584445mr20685765e9.8.1752059648429; 
 Wed, 09 Jul 2025 04:14:08 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5051e7esm20287755e9.11.2025.07.09.04.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:14:08 -0700 (PDT)
Message-ID: <a9d23dc1-60b8-4ad0-a666-ad3770051ec3@linaro.org>
Date: Wed, 9 Jul 2025 13:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] esp.c: only call dma_memory_write function if
 transfer length is non-zero
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-6-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618061249.743897-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 18/6/25 08:12, Mark Cave-Ayland wrote:
> In the cases where mixed DMA/non-DMA transfers are used or no data is
> available, it is possible to for the calculated transfer length to be
> zero. Only call the dma_memory_write function where the transfer length
> is non-zero to avoid invoking the DMA engine for a zero length transfer
> which can have side-effects (along with generating additional tracing
> noise).
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index ec9fcbeddf..1c7bad8fc0 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -631,7 +631,9 @@ static void esp_do_dma(ESPState *s)
>           switch (s->rregs[ESP_CMD]) {
>           case CMD_TI | CMD_DMA:
>               if (s->dma_memory_write) {
> -                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
> +                if (len) {
> +                    s->dma_memory_write(s->dma_opaque, s->async_buf, len);
> +                }
>               } else {
>                   /* Copy device data to FIFO */
>                   len = MIN(len, fifo8_num_free(&s->fifo));
> @@ -681,6 +683,7 @@ static void esp_do_dma(ESPState *s)

As future cleanup, indent could be simplified using 'if (!len) break;'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>                   buf[0] = s->status;
>   
>                   if (s->dma_memory_write) {
> +                    /* Length already non-zero */
>                       s->dma_memory_write(s->dma_opaque, buf, len);
>                   } else {
>                       esp_fifo_push_buf(s, buf, len);
> @@ -715,6 +718,7 @@ static void esp_do_dma(ESPState *s)
>                   buf[0] = 0;
>   
>                   if (s->dma_memory_write) {
> +                    /* Length already non-zero */
>                       s->dma_memory_write(s->dma_opaque, buf, len);
>                   } else {
>                       esp_fifo_push_buf(s, buf, len);


