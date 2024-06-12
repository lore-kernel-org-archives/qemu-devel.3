Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA83C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 22:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHWNW-0003Et-Ro; Wed, 12 Jun 2024 18:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWNV-0003Ek-Ma
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:23:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWNU-0003kE-54
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:23:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c60b13a56so235301a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718231014; x=1718835814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UppkfAIo9Rs9q9kvREoFFBmJaG7ZkDrz43BOn7itx5A=;
 b=bO6dNET9k1hpr9IWRWRYOSYfyfKjpYTo/0hJeHXM6IRHCCZDwpfPLXZ5zfj3R5ueS/
 64E+6Xj/f3Ye6Bkk6OHdUI2J7zIAroPP/pMAMZIiPTuxQpJ44EImqOl0GgQbF7LOOnIp
 58D5KA/hzaH6oJ095OKvppBOYSAbgETqOxH2AD1KoYU3KmHSFe/2UkW6ayqsKuej1/+X
 Vecuv1Lfsx3enL4PrOw30YHLi2QC6JzY2wc1smPTls4kpL6Flt7UBjRetaLSEHgdqNAV
 h2lq7mjxta4Gdqoaq2ZmRDEN7oL/z+qZSDsJNgegx9h+A3pw3X0Kfk2ZNEfHZXUBV5lB
 J6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718231014; x=1718835814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UppkfAIo9Rs9q9kvREoFFBmJaG7ZkDrz43BOn7itx5A=;
 b=fgEVP9284SOztwiYCmZUvT2Pa3KXMM0N+Ou8q5C0p76gWDDo+IJditZw/mHp1FWGB6
 sc3gZZVXMZuK3WmgTDdEeCvlgG8Pe4EdtBJu/dxVyKrzLYc+ULNjv8Jo/zfVHv01XPF5
 ZA70gR0FcKg/7LaOtRiZSGq37V3F2NYYtTOewMJ+/7H6tNkictEoKhJaZgoZReBKedhG
 qSWyrrpvfaYwWBrZwY1JoDtZFAmTSW9zmqfoGmJ/rRgOjFp2FUw5WQaKgwcSOJuAQTH2
 NVByjiNbjnb0ZI7mU66xVj5bNzbGDQXBbAYscPpP5ERQXuWMCSm58wAVo68VqJNn2kmN
 2WGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViXk0C1nicS6rZBT+OctfJ5v7WySdXAxe1FmAcj+DexSW4fiifEFMqPu+q52AYsphAQ0tlxrgKH4Y0F/j5zN8HRQ863Pg=
X-Gm-Message-State: AOJu0YwZ7LiQqZX3NawFvYLYKUkmPltCBq+1zutxiWsqdN95ipB0E9ju
 w10LilHVqur5aXTFjSf86nI3qRhQ36UrHHimqTKiAybIohfzF8CD79C53T1gx+E=
X-Google-Smtp-Source: AGHT+IGXEE+4F7dXf2Mob/E+pDCW/r7q3tzAGNNUlfLF8yieWV/u3f1bMTxlGj5Ev/uyQHdzZXrpzg==
X-Received: by 2002:a50:d715:0:b0:57c:abf9:e6ad with SMTP id
 4fb4d7f45d1cf-57cabf9ed34mr1483698a12.42.1718231014361; 
 Wed, 12 Jun 2024 15:23:34 -0700 (PDT)
Received: from [192.168.69.100] (sta21-h02-176-184-21-30.dsl.sta.abo.bbox.fr.
 [176.184.21.30]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72ce05csm71429a12.2.2024.06.12.15.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 15:23:33 -0700 (PDT)
Message-ID: <46403669-94a2-4fa8-9dd1-db69ef4ef546@linaro.org>
Date: Thu, 13 Jun 2024 00:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/32] hw/sd: Fix SET_BLOCK_COUNT command argument
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-27-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-27-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 3/7/23 15:25, Cédric Le Goater wrote:
> The number of blocks is defined in the lower bits [15:0].
> 
> TODO: This needs to be more precise on the spec version.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c4c9e9ee7999..7f07d0e99d15 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1282,7 +1282,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>               return sd_invalid_state_for_cmd(sd, req);
>           }
>   
> -        sd->multi_blk_cnt = req.arg;
> +        sd->multi_blk_cnt = req.arg & 0xFFFF;

On the SD Physical Layer spec v9.10 this field is still 32-bit
(see table 4-24, p. 104).

Should we use a sd_is_emmc() helper similar to sd_is_spi()?

>   
>           return sd_r1;
>   }


