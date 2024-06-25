Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25689C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzRQ-0000TG-QT; Tue, 25 Jun 2024 02:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzRP-0000SV-Ia
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:14:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzRO-00062Y-2V
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:14:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so29950105e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719296044; x=1719900844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7Dg77b4XqwjBtb5GbXMQmdVquovXXbKu5BAkVtSa/0=;
 b=Lgpsp5OyLoGN/gLrN4nh3DZjOEmXFQ0MScv/WrfOXWqjq6K/CbFoX/6XAp4gRY+mou
 MDGbG8Y5v4M6RVqY9bM37RDaDrfaUcTXD6FHDKKY3GSCenSZhDcprcZGZSsnJ7Sh4y+B
 Ymec+dOoxwN4w+yBCWD0PEJQbUOKZ6Q0+CoYf19t5X1W/QApVmiflQvWafAUiUZAe45A
 lwHu2F0/+jmoFk4WkEaTYqjShyQk0qsiabCnkAgDSHlgK4EjZoA/l11NlohKxKDAYKVD
 Tu7atRF7ElgsMxacoXriN51HJFilxJjFBqT0qrZtPag3DT+ygdRFqr1zwtO2ndUq71FO
 9aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719296044; x=1719900844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7Dg77b4XqwjBtb5GbXMQmdVquovXXbKu5BAkVtSa/0=;
 b=CCoc3dM2SHM29KP1jRtaabTkx3XCg86PIpLpQ/uFT2tptCaXTTEyIkDoKCp8J5nfJu
 a3S5xX8li3A/dB0sTcXez8O5ijA04Br9yFcbolV9lMUbCuJsJoAYB9xb3a298A81MxoW
 Ztt6PBbhmuVL/YvMpheec16mJJkJO0dnfbDIJE8ll6Ta3T662pmqEtnMxebhCGbb+yrd
 23Cmoc2fEgnRoHb0VCncSrLhj3udZyzeEc5mLJoUTMFgcJEeLr9BkMNEikxprfF/PD7t
 UWlN/vBPXkg8uzj1qQzSJ2GiwfGU2xL5R2Rb/ZYvzc+h16k5fN9hfLVS4JXoQ/36rjI/
 bgLg==
X-Gm-Message-State: AOJu0YwZzpHb4TN65nNVWK2G9TJPVPkzAsUa/CA0qOrvwQlLXaM6pR/+
 pkry+oU82zox4ZAQNDA2PV5gzv61d8ta7tAsjqGcHglbbm9r/6Y0Szei+ny26YG4waC1qi3kJPl
 C
X-Google-Smtp-Source: AGHT+IH7mmjnIfTzB+80/LTwNfGzoDWSbgYMY1njySy/WmOD3gKL2KPolsdkOf6IPvkgu/iH7ZN+bA==
X-Received: by 2002:a05:600c:1986:b0:421:741d:5c31 with SMTP id
 5b1f17b1804b1-4248953412amr63697635e9.15.1719296043763; 
 Mon, 24 Jun 2024 23:14:03 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d21243esm201292325e9.43.2024.06.24.23.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 23:14:03 -0700 (PDT)
Message-ID: <0e5c19a4-b9a1-40ab-acf9-2008c8b6a032@linaro.org>
Date: Tue, 25 Jun 2024 08:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/sd/sdcard: Convert SWITCH_FUNCTION to
 generic_read_byte (CMD6)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20240625061015.24095-1-philmd@linaro.org>
 <20240625061015.24095-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240625061015.24095-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/6/24 08:10, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 89006ba1b6..0011aa86da 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1220,10 +1220,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           }
>   
>           sd_function_switch(sd, req.arg);
> -        sd->state = sd_sendingdata_state;
> -        sd->data_start = 0;
> -        sd->data_offset = 0;
> -        return sd_r1;
> +        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
>   
>       case 7:  /* CMD7:   SELECT/DESELECT_CARD */
>           rca = sd_req_get_rca(sd, req);

Oops, missing:

-- >8 --
@@ -1068,3 +1068,2 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState 
*sd, SDRequest req)

-__attribute__((unused))
  static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
---

> @@ -1922,7 +1919,6 @@ send_response:
>       return rsplen;
>   }
>   
> -__attribute__((unused))
>   /* Return true when buffer consumed */
>   static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
>   {
> @@ -2112,10 +2108,7 @@ uint8_t sd_read_byte(SDState *sd)
>                              sd->current_cmd, sd->data_offset, io_len);
>       switch (sd->current_cmd) {
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
> -        ret = sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >= 64)
> -            sd->state = sd_transfer_state;
> +        sd_generic_read_byte(sd, &ret);
>           break;
>   
>       case 9:  /* CMD9:   SEND_CSD */


