Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D8C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJasM-0005Q6-D0; Tue, 18 Jun 2024 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJasK-0005OO-JL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:36:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJasI-0002eG-SI
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:36:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3608545debbso3245336f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718724957; x=1719329757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yaAKq0ClcR6KnesF8Egd9IgeJapfP0lLHslc6XaJOGs=;
 b=deQcLDFl2ci0+OFgD+DdzsB+5rWa0Q7r1WoNr55pEdX3cO5jZPhKdt4FSPcC9IQLEI
 Hb4qOWk27tAVUNsudsuSGGzIwzM8g+CcIa4xIoQape2T00JIGeZs8w0HacY9yo/HrdCT
 gVLhLWujuHofzSkp2IT9E0iad4ZTzaq88qRCGFyUPIM89D4fEaET8LlzQpYA354UJMRc
 U/jycl9OPT1Vl60SFsyCDIeT4DL//O+8hOpInxR3G81SAcbxJ7IACfw7s6mgHh9xrqmN
 JVUslQW9lNsXHgF7eV0TbJEosVzwROVTbIW/XKjYYvxaC4zOsvcWsJJtCXNApY1zJIU+
 dpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718724957; x=1719329757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yaAKq0ClcR6KnesF8Egd9IgeJapfP0lLHslc6XaJOGs=;
 b=b5lbD6zd4MgAmG8Ct4yKBeWqzQRUt7yLbWd5FPvWfhV/I1XO26Z+15lTaAGLl4n1w7
 y56OVCoX+ZxBlMf6HBym2hM37qzR7uVhYLtZVKIFueLe7qyWfWlasl2XmqHU7K0eLDI3
 BL5vT4Pm/nnWtUYvu4gP5238NgP0g0+ZsKpN2P5GSiYwQoDNBoRktM/1+wZ5e68ePCiE
 NSat4A2RIX77NcVjaMgBE8smWAddgD4qoSqybb+X/h1tSBrpnHRS8if+mcje+55LnWzy
 V00d1xCTqI516wCRgV+xI3cptGqjjjruk26B57jCD5Ne62McNT/EIpPiCasmybOJ5oVH
 lrTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHwtUItTFb9A+qznWspoZTK1wl5cmHboF4QYo9fIVz0A13cLj+LTo11mcAzwpneFokQytW5mUFnoyLu7MU/4zvHDFbGXw=
X-Gm-Message-State: AOJu0YxvU+7Ri/l0Eey5wKcTQ6b1Efe2BQSKTp6enn53+CfXkDAs+VBy
 jwMKTVq5OJTkFNOq0kptYRX1tZkv6Dce9Sv+4r7c8p2BGd5gZyEi0wTGy2bhqv83aSwxQKWrGyZ
 K
X-Google-Smtp-Source: AGHT+IGkH2qwHEhXqKErBhrlWwknWkKgbpYu6VC63/W6tpznUSfcBcnA5p0YMwCO4LLKdcYbM5bOlQ==
X-Received: by 2002:a05:6000:4014:b0:360:7558:49dd with SMTP id
 ffacd0b85a97d-3607a75c379mr12789512f8f.36.1718724957071; 
 Tue, 18 Jun 2024 08:35:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362e3e1abd5sm343471f8f.47.2024.06.18.08.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:35:56 -0700 (PDT)
Message-ID: <896bbf08-7a3d-4a2c-b7f7-b260073255cb@linaro.org>
Date: Tue, 18 Jun 2024 17:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: m25p80: Fix heap-buffer-overflow in flash_erase
 function
To: Zheyu Ma <zheyuma97@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20240618152328.3163680-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618152328.3163680-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Zheyu,

On 18/6/24 17:23, Zheyu Ma wrote:
> This patch fixes a heap-buffer-overflow issue in the flash_erase function
> of the m25p80 flash memory emulation. The overflow occurs when the
> combination of offset and length exceeds the allocated memory for the
> storage. The patch adds a check to ensure that the erase length does not
> exceed the storage size and adjusts the length accordingly if necessary.
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=qtest, -m 512M -machine kudo-bmc -qtest stdio
> writeq 0xc0000010 0x6
> writel 0xc000000c 0x9
> writeq 0xc0000010 0xf27f9412
> writeq 0xc000000f 0x2b5cdc26
> writeq 0xc000000c 0xffffffffffffffff
> writeq 0xc000000c 0xffffffffffffffff
> writeq 0xc000000c 0xffffffffffffffff
> writel 0xc000000c 0x9
> writeq 0xc000000c 0x9
> EOF
> 
> ASan log:
> ==2614308==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7fffaa155900 sp 0x7fffaa1550c8
> WRITE of size 65536 at 0x7fd3fb7fc000 thread T0
>      #0 0x55aa77a442db in __asan_memset llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:26:3
>      #1 0x55aa77e7e6b3 in flash_erase hw/block/m25p80.c:631:5
>      #2 0x55aa77e6f8b1 in complete_collecting_data hw/block/m25p80.c:773:9
>      #3 0x55aa77e6aaa9 in m25p80_transfer8 hw/block/m25p80.c:1550:13
>      #4 0x55aa78e9a691 in ssi_transfer_raw_default hw/ssi/ssi.c:92:16
>      #5 0x55aa78e996c0 in ssi_transfer hw/ssi/ssi.c:165:14
>      #6 0x55aa78e8d76a in npcm7xx_fiu_uma_transaction hw/ssi/npcm7xx_fiu.c:336:9
>      #7 0x55aa78e8be4b in npcm7xx_fiu_ctrl_write hw/ssi/npcm7xx_fiu.c:428:13
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/block/m25p80.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8dec134832..e9a59f6616 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>           abort();
>       }
>   
> +    if (offset + len > s->size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "M25P80: Erase exceeds storage size, adjusting length\n");

Usually hardware doesn't "adjust" but report error earlier.

> +        len = s->size - offset;
> +    }
> +
>       trace_m25p80_flash_erase(s, offset, len);
>   
>       if ((s->pi->flags & capa_to_assert) != capa_to_assert) {


