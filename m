Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96797CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulrHC-0001vt-QQ; Tue, 12 Aug 2025 11:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ulrH4-0001vF-8m
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:50:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ulrGv-0006vZ-Ts
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:50:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bee58e01cso6686922b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755013841; x=1755618641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g9fSziLLE/aKfw77ObRHszOQCUFIjcYmnlrol+OKAK4=;
 b=QEtRp6kPBkLx9LuKGzfejnsv4MaZIBnnI9OlztT4XO09eMFypyVMP4AKBsAKMruOwq
 JnnQlLDjORsSMmkgJ2yrwzGzr1/IMhxpE5TYrQ+Lfxyn9Pr84u/I561dqFLSZfCVZLJM
 Oo7wZLlAfTimzixRqpkg1M4a8KMRJWGnNHLfd0YjqbfjQy2B4iwkypNGfco7F/VEenVi
 TEFbGOHr69wFQJtEgd4uOUP6W1joJCGrTt8eMlpDtSBa0BQzz4qu8/5qQSB19cly1OY+
 TVjK3HSuPgeSNdH55C/tPG7t/5AXWdNKAEf0Iz8RABeAF4Q/2Y7wTNR0KKw8pjTLiH/O
 DX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755013841; x=1755618641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9fSziLLE/aKfw77ObRHszOQCUFIjcYmnlrol+OKAK4=;
 b=EUyiekb3/Y+uT4zCkuP5TXnD8KAsZ/j1YBujPoLIdOzVGTu6wP22ao45OQBtAUYhwx
 H1gQH6mJRAx+nJIkLtqlZvAXDwXqkYDQ7xJ/CrH+Z9+8tJFo4u+xYcSO/QQ+euKehmGC
 O3E3ua1iGrXTRq/3rnxeqK1b87Sc9VvJv8UirTD0IN7eDv5qu1vHhJ+z2QRQmFxntX9I
 kotXUYDFH9p0lKKmis1IeF7kMMEEU2/XyWwoxW68PIrNAlNXK8Oe8vkPKX4M3MOCdcRU
 xADu5PDN9g89Dvula5ry1T6GCuHf5db+IdcAPWMP5/42jluDboktD2lBS7q2W0MN11ku
 /MWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP6RS3wO2rUVzIgxzKoBW1fuHEOsb1O0NvpP1tieWJtHU4+DmJAyleDQN3FyI6mXlMoz2yjpXT6ORN@nongnu.org
X-Gm-Message-State: AOJu0Yy31kkRLBxBuSOFOKgKMG99C69cTU7AAPeoWAOKk7RFcAzpOtkG
 TWZXWgkXMrLsnmlXWnxPdpx3JxCQt8Hq5FGFzL/T7x15ERdIqnzyFSFhlY2fWfITdWQ=
X-Gm-Gg: ASbGncsabUOCquLNlol2X2o/6i7QakfjH9ASlyeJ4R1kZOFTfruRQfIdy8xthrccfKa
 f2Y61LbZLulPjENjOjQzZn/4rYOmgTwQoSd6be92H9Boz1Wz876VpPOpoxMzb5nbEUM3vsb+2z8
 ZrlU2CH+sYIDiF7PDNSkJ9E3rCgnIQov7ahQYkRt7PFafQyKA1gIL1bY2Y1mvRnytn31sMeOpCz
 K96n/lxeQqGkMrrvA+iQdxzKs908pBp6cQZ430hX3HBQoRvuzTBuTplp4hxn/5TF0L9UIj86lTv
 KMOQORA0N8JHAFucIIdJJWyTmzapwhduOmVyvZ9Af7J7aI0zaBUsqvadFUgvgVvBG3wTY5F9cyi
 zKxmZ28Pd3WzfwA9jzPDZvFl024P7RcrPv/A=
X-Google-Smtp-Source: AGHT+IHHl7j0ovIUsVs13N0Jt7qN9nnG50Mn3WlHdUow6DC4lKNbLzl2EOx260U0NWE5ht5WQ/rY5w==
X-Received: by 2002:a05:6a00:4b02:b0:76b:db12:3e7 with SMTP id
 d2e1a72fcca58-76e1f9a0645mr132404b3a.0.1755013840662; 
 Tue, 12 Aug 2025 08:50:40 -0700 (PDT)
Received: from [192.168.0.102] ([152.250.234.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcceab592sm29867345b3a.58.2025.08.12.08.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 08:50:40 -0700 (PDT)
Message-ID: <96ca35b6-8bd4-46d0-aff8-ab5ee0f5d89f@linaro.org>
Date: Tue, 12 Aug 2025 12:51:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 RESEND RESEND v2 3/3] hw/ssi: Document
 ssi_transfer() method
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250812140415.70153-1-philmd@linaro.org>
 <20250812140415.70153-4-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250812140415.70153-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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

Hi Phil,

On 8/12/25 11:04, Philippe Mathieu-Daudé wrote:
> A SPI transaction consists of shifting bit in sync with the CLK
> line, writing on the MOSI (output) line / and reading MISO (input)
> line.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ssi/ssi.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 3cdcbd53904..2ad8033d8f5 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -38,6 +38,7 @@ struct SSIPeripheralClass {
>   
>       /* if you have standard or no CS behaviour, just override transfer.
>        * This is called when the device cs is active (true by default).
> +     * See ssi_transfer().
>        */
>       uint32_t (*transfer)(SSIPeripheral *dev, uint32_t val);
>       /* called when the CS line changes. Optional, devices only need to implement
> @@ -52,6 +53,7 @@ struct SSIPeripheralClass {
>        * of the CS behaviour at the device level. transfer, set_cs, and
>        * cs_polarity are unused if this is overwritten. Transfer_raw will
>        * always be called for the device for every txrx access to the parent bus
> +     * See ssi_transfer().
>        */
>       uint32_t (*transfer_raw)(SSIPeripheral *dev, uint32_t val);
>   };
> @@ -110,6 +112,18 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp);
>   /* Master interface.  */
>   SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>   
> +/**
> + * Transfer a word on a SSI bus
> + * @bus: SSI bus
> + * @val: word to transmit
> + *
> + * At the same time, read a word and write the @val one on the SSI bus.
> + *
> + * SSI words might vary between 8 and 32 bits. The same number of bits
> + * written is received.
> + *
> + * Return: word value received
> + */
>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>   
>   DeviceState *ssi_get_cs(SSIBus *bus, uint8_t cs_index);

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

