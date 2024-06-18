Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85987C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfXg-00057k-Qy; Tue, 18 Jun 2024 16:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfXf-000578-7f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:34:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfXd-0003zM-Cy
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:34:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4218180a122so42198925e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718742895; x=1719347695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMT4MnF+Zmy/QD2WxeZrLQ5X3jj4D4TA0j5Pi4Uu+CI=;
 b=Encgv0euhbvbQcwwKTgs4n+/bEBzmvb/+VGuVsoDC7f2CbhFHVOL5K5iv+vHlE+nGS
 6nDnUyPttM16YTA3DOZViTtclb5l08SvAAoVvrbZ87kgPkbApcQCdre2c68+UNDTvRSc
 XrVyZbXrjwzvSzcAoBTvFLf1qMKtpE9pdWm6XOBO8KCc++oD3Ysequ5B5tTMkAINdlQh
 YWhKyDDqhAFQSv6UsZ0WoTiZKpkdPpkOIm1uAXVbJSbZtMtFqk0JALf6hO9ZVEQrnFqU
 P6+O8f25MTVB+hIeUMFPbjScevsjmNLhY7Xuyt85QlgTuCzHgDcPoI4PN686tcH4R6Qx
 8WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718742895; x=1719347695;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VMT4MnF+Zmy/QD2WxeZrLQ5X3jj4D4TA0j5Pi4Uu+CI=;
 b=rscL9I8aOHUXc4xkcm2qUVMyl4WxlPx7RxaAitrftK7WhZyE3FOBFicX7yNnQtR+X5
 v+jp4FlpK4oeMXOHD51NMEHqYHJfh0lQ61UevcJhfiydWpaiiJo+rQsW9v9diZ4sTMtu
 7ZE6gW9dWJ4qDh4J70lQ1Sn0W4xC/Yo/PhhLIpWK2FeTFvT/BpJVGiqrenT+NnuZc52H
 aEnhJkxiLOpxNuw/k4t/AuR6gAX8PwoODEcEJXXNQ2nqKPNPZkEp8mYhCMX6UZFsnKxY
 KJBY2jFdXtNPo19T3/5dlhiOzb+6L8adXnazJjL1eRC8F4tUsW94PDSi/o3OIRmfvCuH
 MMMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP0Te3NHIHLlYR2mHkiyuvxf/LFID+4qoi3S/S8VDwEjWX4NQ+fzAo3P6pQ4Rp9bUgDS93r1uKuWWG43AP5Uztp8/ChNc=
X-Gm-Message-State: AOJu0Yz6o0hsLxRxhfVasb+khte28xPZPBGQeEK5fOeXTa0R7HZcychJ
 ojheRMOFH6T/aG2QGuUCGzcez9mkgeSzUOUMrGQFvGxhIaN4OcADk6QKMkfovME=
X-Google-Smtp-Source: AGHT+IHf8bKqGpDwFPlPAivmjVqmgKgiJOfCd0rFodlFfMqt0b3y/mDN7Sp36nEAOd+ObiDVMrmDug==
X-Received: by 2002:a05:600c:181c:b0:421:f346:6b06 with SMTP id
 5b1f17b1804b1-42475298e68mr3701585e9.28.1718742895469; 
 Tue, 18 Jun 2024 13:34:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33c43sm204194515e9.7.2024.06.18.13.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 13:34:55 -0700 (PDT)
Message-ID: <8feeec5d-4287-42f4-97a8-5d9cf9df4a72@linaro.org>
Date: Tue, 18 Jun 2024 22:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: m25p80: Fix heap-buffer-overflow in flash_erase
 function
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240618152328.3163680-1-zheyuma97@gmail.com>
 <896bbf08-7a3d-4a2c-b7f7-b260073255cb@linaro.org>
 <CAMhUBjmpYLFuRfsHACUjGvwfydEU7R89AEWToLAyo-0kQ-B41A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMhUBjmpYLFuRfsHACUjGvwfydEU7R89AEWToLAyo-0kQ-B41A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 18/6/24 21:11, Zheyu Ma wrote:
> Thanks for your useful advice!
> 
> So how about report the issue and return:

We might report the issue to the user, but there should
be a way the hardware report the issue to the guest software
running. Usually signaled as error condition, irq, ...
We need to figure out what check wasn't properly done.
The spec is the source of truth.

> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8dec134832..2121b43708 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset, 
> FlashCMD cmd)
>           abort();
>       }
> 
> +    if (offset + len > s->size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "M25P80: Erase operation exceeds storage size\n");
> +        return;
> +    }
> +
>       trace_m25p80_flash_erase(s, offset, len);
> 
>       if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
> 
> regards,
> Zheyu
> 
> On Tue, Jun 18, 2024 at 5:35 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Zheyu,
> 
>     On 18/6/24 17:23, Zheyu Ma wrote:
>      > This patch fixes a heap-buffer-overflow issue in the flash_erase
>     function
>      > of the m25p80 flash memory emulation. The overflow occurs when the
>      > combination of offset and length exceeds the allocated memory for the
>      > storage. The patch adds a check to ensure that the erase length
>     does not
>      > exceed the storage size and adjusts the length accordingly if
>     necessary.
>      >
>      > Reproducer:
>      > cat << EOF | qemu-system-aarch64 -display none \
>      > -machine accel=qtest, -m 512M -machine kudo-bmc -qtest stdio
>      > writeq 0xc0000010 0x6
>      > writel 0xc000000c 0x9
>      > writeq 0xc0000010 0xf27f9412
>      > writeq 0xc000000f 0x2b5cdc26
>      > writeq 0xc000000c 0xffffffffffffffff
>      > writeq 0xc000000c 0xffffffffffffffff
>      > writeq 0xc000000c 0xffffffffffffffff
>      > writel 0xc000000c 0x9
>      > writeq 0xc000000c 0x9
>      > EOF
>      >
>      > ASan log:
>      > ==2614308==ERROR: AddressSanitizer: heap-buffer-overflow on
>     address 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7fffaa155900 sp
>     0x7fffaa1550c8
>      > WRITE of size 65536 at 0x7fd3fb7fc000 thread T0
>      >      #0 0x55aa77a442db in __asan_memset
>     llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:26:3
>      >      #1 0x55aa77e7e6b3 in flash_erase hw/block/m25p80.c:631:5
>      >      #2 0x55aa77e6f8b1 in complete_collecting_data
>     hw/block/m25p80.c:773:9
>      >      #3 0x55aa77e6aaa9 in m25p80_transfer8 hw/block/m25p80.c:1550:13
>      >      #4 0x55aa78e9a691 in ssi_transfer_raw_default hw/ssi/ssi.c:92:16
>      >      #5 0x55aa78e996c0 in ssi_transfer hw/ssi/ssi.c:165:14
>      >      #6 0x55aa78e8d76a in npcm7xx_fiu_uma_transaction
>     hw/ssi/npcm7xx_fiu.c:336:9
>      >      #7 0x55aa78e8be4b in npcm7xx_fiu_ctrl_write
>     hw/ssi/npcm7xx_fiu.c:428:13
>      >
>      > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com
>     <mailto:zheyuma97@gmail.com>>
>      > ---
>      >   hw/block/m25p80.c | 6 ++++++
>      >   1 file changed, 6 insertions(+)
>      >
>      > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>      > index 8dec134832..e9a59f6616 100644
>      > --- a/hw/block/m25p80.c
>      > +++ b/hw/block/m25p80.c
>      > @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int
>     offset, FlashCMD cmd)
>      >           abort();
>      >       }
>      >
>      > +    if (offset + len > s->size) {
>      > +        qemu_log_mask(LOG_GUEST_ERROR,
>      > +                      "M25P80: Erase exceeds storage size,
>     adjusting length\n");
> 
>     Usually hardware doesn't "adjust" but report error earlier.
> 
>      > +        len = s->size - offset;
>      > +    }
>      > +
>      >       trace_m25p80_flash_erase(s, offset, len);
>      >
>      >       if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
> 


