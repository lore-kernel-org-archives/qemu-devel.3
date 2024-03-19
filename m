Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D246EC54E6A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPcn-000072-P9; Mon, 18 Mar 2024 22:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPcm-00005t-U4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:54:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPck-0004j1-Tf
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:54:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e73e8bdea2so682853b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 19:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710816885; x=1711421685;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HDIBy76UAagNa5qz5F2BQ5rKPIrkH/FBLCwd5Ke3q0E=;
 b=adyJWLwOeQMppvklVmqVKXTWVYnTV5L7gtdfb7nyzngLet+lGqlAfZltxiccGFDnUE
 eBiAn2/hN5U8JjEDC8PGF/akbXK890w6LfsrvoSKndsgVRoInGJ+zY94yelbmKAPc9TC
 4DH2IWWXc/4G89QjYjabgigMmkfpdf4Ys7KpoRQCchQ59n0rI2VUvum+pcNKn3oVpsIw
 KNDJglhYGpCIDSWnJOfsxljHgTOfZEpOpXMlqUUbWgCkmTQ9cUTVYTRMELJcJAeh9a2s
 j9uguU8ycFjT7/iVE5NaPjZ2+sDplvQ9FQbQQHSS4H4CauilZ6hcNPy6VRxaSrKjOI7e
 S5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710816885; x=1711421685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HDIBy76UAagNa5qz5F2BQ5rKPIrkH/FBLCwd5Ke3q0E=;
 b=Jgou4z33INTG216OMQq9Kc6FzlBlj5jsEAj3mtAJuDQWC/KypEgENu5C8gHjB3m049
 T/YjKyKfWqRSibl5DL6G4MzzlMo/v0/Mc2y6/Uk3VIg3ixi+GLbwJRUhnCrBlncSgXVp
 ORJc2sN1dXnBbzBxVQZbXakeDpQ7E6wT7jesN0M+XD0ZnqtHeHQrzlAyNHErdYGBD4sq
 1wkHsWPvsPsZG6oaomyD73ouPSjGlwGiQRThJqGj3TZsTNky55gn6br9mU+6YNtvXXfN
 vKxjbjajvA3txg4pC/IXJCDjSx7OcHf+ujl8Sfj7EkveApZZi3J9fPM7Rw5utNqs53ph
 nTaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqsZj+XuTM4OlkCtUWBvhqPs6eMm08KeKw4lAjGOtHfz8PzcCK3JHZOk/Rpv8zppxQ4nP+tYJFU3A2c3F5jy53z78qM7E=
X-Gm-Message-State: AOJu0YznmMnVTLCxj+LU1v5IHjNhUZQrNoUoFG+7+znUhKmq/APt03Rb
 NTduAMGDYmBKcXC9IHZcvfi1KqkorE3QTzhyOd4OPjJPgCOyQDb4S3NWItS+gPY=
X-Google-Smtp-Source: AGHT+IFVRCXTVdlzKH4mf57vl9SyNA5g/5jRRlJL0zc1/QTruB5xg4NGDGR0P+dWVmtjqUkUZLMd5Q==
X-Received: by 2002:a05:6a00:2301:b0:6e5:64cd:8f52 with SMTP id
 h1-20020a056a00230100b006e564cd8f52mr17768104pfh.0.1710816885591; 
 Mon, 18 Mar 2024 19:54:45 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 z3-20020aa79e43000000b006e6fd17069fsm6188632pfq.37.2024.03.18.19.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 19:54:45 -0700 (PDT)
Message-ID: <e15312de-3a5b-47e2-aaa9-1fb3f623b04f@daynix.com>
Date: Tue, 19 Mar 2024 11:54:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] hw/display/pxa2xx_lcd: Set rotation angle
 using qemu_console_set_rotate
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240318113140.88151-1-philmd@linaro.org>
 <20240318113140.88151-3-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240318113140.88151-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/18 20:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   hw/display/pxa2xx_lcd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
> index a9d0d981a0..7d03fa57d0 100644
> --- a/hw/display/pxa2xx_lcd.c
> +++ b/hw/display/pxa2xx_lcd.c
> @@ -1439,6 +1439,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
>       memory_region_add_subregion(sysmem, base, &s->iomem);
>   
>       s->con = graphic_console_init(NULL, 0, &pxa2xx_ops, s);
> +    qemu_console_set_rotate(s->con, graphic_rotate);
>   
>       vmstate_register(NULL, 0, &vmstate_pxa2xx_lcdc, s);
>   

