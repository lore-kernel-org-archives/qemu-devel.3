Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63507C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohX3-000878-P5; Mon, 25 Mar 2024 06:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohX0-00086v-5c
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:26:18 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohWx-0006aC-Rb
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:26:17 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a4a34516955so100491866b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711362372; x=1711967172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KeQ99bJL0jXkzSuZkb+QQXK3uxwjNcEvYd2A5bNrnZc=;
 b=FTm/jToz5AJrp1YxTtSMM371dWbqj19YGWbKNT98jaFFhXxyw93hK9vCJGgXuYLe2E
 BrrTbl0C0nubtgKO1DljX57SEWL9kEfdaUiv3Fu2GEqwB1WOTG/n/zy9DGywvm28Lu71
 E00QAO+nKLPks9uJX+2RVFh83UbYORHH9SEE+CJ780ixZaNy6RGo/gZXK0cYrmKk1plk
 mofVQqb0qSeNybO5q7RCMxmnpJkuduIYtL7jJBMdO4161hyWF8h7THcd4UiVXovNuE6S
 6EkRLVXhSMFtEX8xt8pBVel2pXXFBwgDoHMjNCKGSWluFWbFMtFIJUYDRcAQ8WywPnWR
 kTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711362372; x=1711967172;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KeQ99bJL0jXkzSuZkb+QQXK3uxwjNcEvYd2A5bNrnZc=;
 b=GtoITlzrdTWeX59mjtKioExmhfism6fBMmFiMEA+IiiaFoVnxIbKgsE1yWvrLGQOmi
 /ZwtltvHUmiQzGc7+0P0u2Foz3WyFaCN0O/T6OrjX7kxI7Pm6fr7ziLdx9mGlRWaMJdd
 obJfRLhC6/VykFGy1dJ5HpxUgO+0xw1tYK46vijJyrr+gLxlET5Q/Nqq8Wsd5ZmOaQ65
 +ik4ttHjCxo8Ekbxkpy3ge740l4IHKqYOg65Ua+vqeidGAB/5sTLoTlvZ9g+mq82jCXl
 6gIfYFf9L8+9IZvIZ9YZ8yvkM5z6p4nRg0A0J0yAVTim97iKTieLiqtqTNJlIfhnI1lA
 SBzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/AVkkLryzFZTMkTtEnJ65hcu4GxY3QcZUzeTqCphg6cBbF3fPVy5qJtkFTCw6KRzm13UKiNLXJYd0/g7qV7MnPFKn/Fc=
X-Gm-Message-State: AOJu0YykDXNnRMxF3EpHtqRK48AsJGt06p2ayHk4218WV2UijXCoTP2f
 No19rW7KFxlSPhtxR29BRJ9qedn2jLoD+lthpmSP+z5Fbnt8xB9DCFL+riWJXU8=
X-Google-Smtp-Source: AGHT+IFcIvRut3z8X0V5FYx2K95KWth9Yrwg/GWpF+qVWyeDTLHieiHLyRiNHEKlyaP220kc9X+frw==
X-Received: by 2002:a17:906:6dc4:b0:a45:94bf:18e6 with SMTP id
 j4-20020a1709066dc400b00a4594bf18e6mr4795213ejt.73.1711362372020; 
 Mon, 25 Mar 2024 03:26:12 -0700 (PDT)
Received: from [192.168.130.175] ([92.88.171.150])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a17090627c300b00a45ffe583acsm2905207ejc.187.2024.03.25.03.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 03:26:11 -0700 (PDT)
Message-ID: <aaaad221-9a88-4298-ac87-49d8a827ce9f@linaro.org>
Date: Mon, 25 Mar 2024 11:26:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] esp.c: prevent cmdfifo overflow in
 esp_cdb_ready()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-13-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 24/3/24 20:17, Mark Cave-Ayland wrote:
> During normal use the cmdfifo will never wrap internally and cmdfifo_cdb_offset
> will always indicate the start of the SCSI CDB. However it is possible that a
> malicious guest could issue an invalid ESP command sequence such that cmdfifo
> wraps internally and cmdfifo_cdb_offset could point beyond the end of the FIFO
> data buffer.
> 
> Add an extra check to fifo8_peek_buf() to ensure that if the cmdfifo has wrapped
> internally then esp_cdb_ready() will exit rather than allow scsi_cdb_length() to
> access data outside the cmdfifo data buffer.
> 
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index f47abc36d6..d8db33b921 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -429,13 +429,23 @@ static bool esp_cdb_ready(ESPState *s)
>   {
>       int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
>       const uint8_t *pbuf;
> +    uint32_t n;
>       int cdblen;
>   
>       if (len <= 0) {
>           return false;
>       }
>   
> -    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
> +    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
> +    if (n < len) {
> +        /*
> +         * In normal use the cmdfifo should never wrap, but include this check
> +         * to prevent a malicious guest from reading past the end of the
> +         * cmdfifo data buffer below
> +         */

Can we qemu_log_mask(LOG_GUEST_ERROR) something here?

> +        return false;
> +    }
> +
>       cdblen = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
>   
>       return cdblen < 0 ? false : (len >= cdblen);


