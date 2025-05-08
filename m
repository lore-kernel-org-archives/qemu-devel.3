Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6673C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCubV-0001Tw-43; Thu, 08 May 2025 02:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCubS-0001Sc-P8
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:19:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCubQ-00086D-W4
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:19:30 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73972a54919so664312b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746685167; x=1747289967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yiHP4TlwEh6ms74MOz5a63FG2+OHs0apV3ncHU+nk4w=;
 b=b/PgQrpbuvjlTXqkMTQhOCgG40ymOLroEGMgCDx60y3JYPPJsMtK9outgzf4Y1xo/o
 4uzNnIB2nrERkv7eXtiby9WZF7w64vjLxiOz+6KKvnDVbwUQV0OYaNHfshd2X9iNGWMV
 ZYk/tf3p3pazD/Iy334u6Vl/PaOfrYB1GkmUc66uZkdBcRVrKTh7bmhull0OqGddHMCF
 suAKd/4gw5trO2l1Cjfz7uuvUU+SlHG5nNGfzXJFQI8RRrmyhwm5BlDPbMRDJeJNlxFC
 4xVS4M9G2IUoa1RtFutfEM7yEDo0Z6UfXeQuNcFmaQRcrPGP8udshHoG1zxXy0Eo8PLf
 bMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746685167; x=1747289967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yiHP4TlwEh6ms74MOz5a63FG2+OHs0apV3ncHU+nk4w=;
 b=s/byWWbMTFmiLZsYrCaVaBCN3qPbEvtzgEE3rycggn0Uxl3S9nIeQJruFxSOK56z7v
 R49fy9hng2+u6yfIrQqeihwzTKeBqxgT0iaRO9VLi583kR2VZ7U32YfI+ZofZ/5FFpKq
 Q5GMvmuKPzkTVr0ySVs0j0jnPnd2rawLLfTD9JW5QsLYOAhnlwRcQyo0NkUlK7nLDowH
 Dxt5XiBGj4jdSSZNbHChDtBidACnzcKmX6xmicrfsVRFlO2kyxN7xD2gHMiCVN0fjeGk
 HTBXnA7j/7/RUXp3akn+j6m9FNFu11mep3rWPzva8EM3n49rt8rPggjXryk9j79tgr1y
 IxHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRHPOtAEwpyRQ1wmUDpHGKKgqQqy9zPvY+TQCmCzZ7HIT/44kS6Ks+inpiY3uoy2p2PDBExi9ft2uJ@nongnu.org
X-Gm-Message-State: AOJu0YyqC1Lldl3Gxu797eg2gNlKo2oLZoXcZQiH1dR2RvPEf1q0Qelh
 s4ZC3ItWXrAt6K5Q0WiqzQBatbMiKmplrEbaeNXEdOu20Igz7IeZIwlfx9RtwZk=
X-Gm-Gg: ASbGncsjMvbKmvsVAJEbppOtz64F1eoCsYU4U2L6Gx6BHTf9KppYUF2kVcd3RBZvrps
 +cIDfZSvFBMPY12cxYawCcLQEPUOSOX7QJSOs9UEmnP+ZgJ7UdMk0GCkx4haxxQ6JnaEHdltlgR
 sGZ+JNeD9+1mzJwobQRTBfZHT3gMJ0cgJazG51xnSRsWE9L+CsULM7piYSd7aZqBUDNWbGMf7Tm
 X/DmJXnHsJtiwB6HnBViF1woI7K1zeV7SCjGhS7dLf3XKZt2Y+0z1nSAKweAb4TGV6Yxa5f0gMf
 JMvYyqR8JkBLvyCj9aX8HSnJNNFUyY5fP1VP/30wB/fVofima6yX6Pg/2pHan/06G4bprAdxu1E
 p1hDL1SkpBQC0/luWl4I=
X-Google-Smtp-Source: AGHT+IG6/Gg+ighuNaGXNQG96qev4OTmBjmqOwwO+eNDNojzoe6D/v7Dg6YBIaexCDAq9GnjRdMnAQ==
X-Received: by 2002:a05:6a20:3d94:b0:1f5:7f56:a649 with SMTP id
 adf61e73a8af0-2159af5b182mr2723143637.13.1746685167307; 
 Wed, 07 May 2025 23:19:27 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740aeafa44fsm609025b3a.20.2025.05.07.23.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:19:26 -0700 (PDT)
Message-ID: <e6b06003-7145-46d5-b19d-b9e134084fc7@linaro.org>
Date: Thu, 8 May 2025 08:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] hw/arm/npcm8xx_boards: Add auto zero flash image and device
 part number
To: Tim Lee <timlee660101@gmail.com>, peter.maydell@linaro.org,
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250508021510.2959328-1-timlee660101@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508021510.2959328-1-timlee660101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42c.google.com
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

Hi Tim,

On 8/5/25 04:15, Tim Lee wrote:
> Fix flash device part number to `mx66l1g45g` according image-bmc run on npcm8xx
> evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)
> 
> And add auto zero flash image size to resolve error below after executing
> `./qemu-system-aarch64 -machine npcm845-evb -drive file=image-bmc`
> 
> Error message:
> qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
> requires 134217728 bytes, mtd0 block backend provides 67108864 bytes
> 
> Tested:
> Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normally
> 
> Signed-off-by: Tim Lee <timlee660101@gmail.com>
> ---
> Changes since v1:
> - Add a statement that checks whether the storage is writable
> 
>   hw/arm/npcm8xx_boards.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
> index 3fb8478e72..79295a586c 100644
> --- a/hw/arm/npcm8xx_boards.c
> +++ b/hw/arm/npcm8xx_boards.c
> @@ -27,6 +27,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/datadir.h"
>   #include "qemu/units.h"
> +#include "system/block-backend.h"
>   
>   #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
>   
> @@ -59,10 +60,26 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
>   {
>       DeviceState *flash;
>       qemu_irq flash_cs;
> +    BlockBackend *blk;
> +    BlockDriverState *bs;
> +    uint64_t blk_size, perm, shared_perm;
>   
>       flash = qdev_new(flash_type);
>       if (dinfo) {
>           qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
> +        blk = blk_by_legacy_dinfo(dinfo);
> +        bs = blk_bs(blk);
> +        blk_size = blk_getlength(blk);
> +
> +        if (!bdrv_is_read_only(bs)) {

This isn't what I meant, we'll get the same issue with read-only storage.

See:
https://lore.kernel.org/qemu-devel/CAFEAcA9itEDTrznX1KRVEza__Dch95aBpPzbdTJ0-tuxwiHtoQ@mail.gmail.com/

> +            if (blk_size < fiu->flash_size) {
> +                blk_get_perm(blk, &perm, &shared_perm);
> +                blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort);
> +                blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF,
> +                             BDRV_REQ_ZERO_WRITE, &error_abort);
> +                blk_set_perm(blk, perm, shared_perm, &error_abort);
> +            }
> +        }
>       }
>       qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
>   
> @@ -194,7 +211,8 @@ static void npcm845_evb_init(MachineState *machine)
>       qdev_realize(DEVICE(soc), NULL, &error_fatal);
>   
>       npcm8xx_load_bootrom(machine, soc);
> -    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
> +    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
> +                          drive_get(IF_MTD, 0, 0));
>       npcm845_evb_i2c_init(soc);
>       npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
>       npcm8xx_load_kernel(machine, soc);


