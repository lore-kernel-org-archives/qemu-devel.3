Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9B8C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMOj-0006Jm-F6; Wed, 13 Mar 2024 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMOO-00063O-OD
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:03:32 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMOK-0000AE-SB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:03:28 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d208be133bso77160321fa.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327799; x=1710932599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oz6dKbtn4IEpsUsc1P2fSpHA/xRdhf0Yk89OHKhclJI=;
 b=sVK1mmeB+mKfB7J2pyWZSduNg0MifJZrgmO6Ez6ywGHIVM9j3ufqWEobvCU8puyyi/
 OYyFnfaO1FOlbuVYb6ZdfblJfCr07d7K7/mwiE/GeEouUuqUPVmznSdg9ocZQo3jNuf7
 myvjeoEprSU8vWOUJq7wdyA3iRfQaWnyFq2OhtaV+3JgQGni650tsPTPOFY5A/FK1JYj
 cb24DXPD8jMK9bqcNHjUEyOsARjxm/WZ1McM8VnZrkHqTEJ4X7ffAxtwWkrIdBcbpjsD
 uuiS+R57flJ1F9yP+45R68sNJQKvyMQ5+317MtmYS1bJIWS4M70R/dGyHyhJz1kcuhPw
 1eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327799; x=1710932599;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oz6dKbtn4IEpsUsc1P2fSpHA/xRdhf0Yk89OHKhclJI=;
 b=GLOcSeBiiZiN421v2YozJMNBQfzi+F4OFCJvG/qMbruBkqCHsoImP+VihNfAhFz9x4
 FwV+lBDTpUGfLuy3l7/zX03fE8Krvh8RyvyI4x28zPQ+XwmK52ZIzcP5KkxLPlaGJlV4
 u1sJen22Ecw/YETgsSuwKozG8xl6HDMzBSM66NvKF5QOaYQ3SvYSBdUMNEzRbhQvf2tW
 GmWF++36+Kas+XlutLF1sQoM095+tZHcHyU6E7J7zhe6+v5R7MQ+yUiBYti4MbJVOlHH
 0IITB/niCNFPLOPEWhO81JsgLERkgMzz0DEaEDDdpkX+LNYaOBGHph7Qg52nRgoS6Isw
 jW3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpe68arHwGZ2v0WkYMsB1N5d7o0o+UwtUDp1TOxE7Ua8gxUEB9RtPoVwMurapzTArGCCIlh64flWPNVtQYeQ5FSfJbH9U=
X-Gm-Message-State: AOJu0YxeoEIPBWIZ1ndSA3S/7sRDeZj27zJ/zzsHYOJ+DyvZXZBrjTAx
 jq0I20HR9rHixAl/JRDEtG/84lLLkeCTwKXj4Xu/AtAorR1b2CZjV4yXj0dojgU=
X-Google-Smtp-Source: AGHT+IHfM7bEA01RJpJfBvuM25xju+MtygpyTn8dpF2PB8OADeHlhAZhKX36SCGRpyJBafoutBH+Fg==
X-Received: by 2002:ac2:4c9a:0:b0:513:c658:7997 with SMTP id
 d26-20020ac24c9a000000b00513c6587997mr1749018lfl.24.1710327798933; 
 Wed, 13 Mar 2024 04:03:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 fm26-20020a05600c0c1a00b00413ebdca679sm841873wmb.37.2024.03.13.04.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:03:18 -0700 (PDT)
Message-ID: <9c36ddab-59a9-47fa-ab2e-ab0e9cff5fb6@linaro.org>
Date: Wed, 13 Mar 2024 12:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf()
 in do_message_phase()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/3/24 09:57, Mark Cave-Ayland wrote:
> The aim is to restrict the esp_fifo_*() functions so that they only operate on
> the hardware FIFO. When reading from cmdfifo in do_message_phase() use the
> underlying Fifo8 functions directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index f8230c74b3..100560244b 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -309,6 +309,8 @@ static void do_command_phase(ESPState *s)
>   
>   static void do_message_phase(ESPState *s)
>   {
> +    uint32_t n;
> +
>       if (s->cmdfifo_cdb_offset) {
>           uint8_t message = esp_fifo_pop(&s->cmdfifo);
>   
> @@ -320,7 +322,10 @@ static void do_message_phase(ESPState *s)
>       /* Ignore extended messages for now */
>       if (s->cmdfifo_cdb_offset) {
>           int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
> -        esp_fifo_pop_buf(&s->cmdfifo, NULL, len);
> +
> +        if (len) {
> +            fifo8_pop_buf(&s->cmdfifo, len, &n);

'n' is unused, use NULL?

> +        }
>           s->cmdfifo_cdb_offset = 0;
>       }
>   }


