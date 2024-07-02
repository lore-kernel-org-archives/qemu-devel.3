Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BECAC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgCx-0003TH-FW; Tue, 02 Jul 2024 12:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOgCs-0003Rh-Or
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:18:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOgCq-0001mq-Cl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:18:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso17611855e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719937089; x=1720541889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NCg2q3ThYi6t48SlSLzReQHBySneepMMuzN9PiMJAD8=;
 b=HEf/jFfkP7rocUBFca4MALM9CmG3RkFlanKgtF/YQQdbfwhkmU3srlsouXPg4F2DK1
 XzphHW9JH6dBo8GhwW1pQGvRblPGI9O/gaU4bB2Ywuu21JuFtJy6mUHmXZtHhC1YZuBj
 hhC7aMnnLJBadbsSqI5/iDF9thhp/D5Hl7fdCQIOdgA1ZRH8w7GZDV+cLJCrcJM1tuzU
 VG8NytWjSeGfKkAYb02LcGEkzGOUwcAPkuyeIR8uRbZzayqaCZLBTMQ1XCmY77MaCFK1
 jfMWHgH5grnueTiHCN06p8J9MULuZZNVIT+WIaBIR0dka1/4YZDmOfAuKnNZEITVRdX4
 qLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719937089; x=1720541889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCg2q3ThYi6t48SlSLzReQHBySneepMMuzN9PiMJAD8=;
 b=rLvFLdnCKyU/eu65HwsezjUe2qtRAGFVMAA737J81iFRvMjO0YzLq3rhleJI3APaBB
 MpxYgTj7RsDGgs34lSUwa0fO+c3NOdSMSQzTDfZu2K94mg8giE3cVoClt7a9Eif24KJR
 H279RJHRhrqQonSeMBNy/2wLebtXdDlJDPKjgc8wPapwEZepnoH21myLXDMv8Q8gjLGO
 tYI5QQEsF2ryeAnwkmeGiFmVCOFy7TsyTz6vdZ+xOopX9JqwCZ4TfP4lMXnG0G97Swc5
 gRf50iRJO8ltHV6oInPQfpnb+Eo2kzKIBnaIscvjsl8n21eBcPAl/B0t9THRDKAE+AEK
 322w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoSGnJsqrTteCuz+nlIhIBgM2CFkfxpVfUqQdCaU9zhdXHDecKdIj6vQgsDtgo4VLRdca+s9k7L/GKFJMTQUE/4P0VoiE=
X-Gm-Message-State: AOJu0YwGcQbwJn+MnxZ6w/GhCVO0mYOC49GIDrZyTOrt2cZRRHH0iWU4
 FEx/k9sVr/KH/mTr8/tbincvGrb5HkjxdHNpl+4ZMcsFarOM5Sz5VtZQCFKXONY=
X-Google-Smtp-Source: AGHT+IFYVhOeT5WStDokFB3emq5bwoCEAl0WWEPmSFWQcD6dSeHNqhUWVlPJPlwwDJEuR+s9UYwY/A==
X-Received: by 2002:a5d:6890:0:b0:360:9436:b928 with SMTP id
 ffacd0b85a97d-367756aae29mr6369264f8f.27.1719937089209; 
 Tue, 02 Jul 2024 09:18:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba38sm13621997f8f.77.2024.07.02.09.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:18:08 -0700 (PDT)
Message-ID: <8aa595ef-efb2-45f8-a89f-9a4db3b2f11e@linaro.org>
Date: Tue, 2 Jul 2024 18:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240702155752.3022007-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240702155752.3022007-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/7/24 17:57, Zheyu Ma wrote:
> In pl011_get_baudrate(), when we calculate the baudrate we can
> accidentally divide by zero. This happens because although (as the
> specification requires) we treat UARTIBRD = 0 as invalid, we aren't
> correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bit
> ranges the hardware allows, and so some non-zero values of UARTIBRD can
> result in a zero divisor.
> 
> Enforce the correct register field widths on guest writes and on inbound
> migration to avoid the division by zero.
> 
> ASAN log:
> ==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348
> (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
>       #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
>       #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:260:33
>       #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
> writeq 0x1000b024 0xf8000000
> EOF
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Peter, feel free to replace that line by:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v3:
> - Defined masks for UARTIBRD and UARTFBRD to avoid magic numbers.

Thanks Zheyu!

> Changes in v2:
> - Enforce the correct register field widths on writes to both UARTIBRD
>     and UARTFBRD registers.
> - Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_post_load
>     function to prevent division by zero during inbound migration.
> ---
>   hw/char/pl011.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)


