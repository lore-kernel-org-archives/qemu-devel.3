Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C6FE67802
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 15:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7GAe-0006Qc-Ns; Sat, 02 Nov 2024 11:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7GAd-0006QG-1M; Sat, 02 Nov 2024 11:36:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7GAZ-0005XT-69; Sat, 02 Nov 2024 11:36:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so23031695ad.1; 
 Sat, 02 Nov 2024 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730561765; x=1731166565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ir4bsmkC5gM1QHQB0cTjySbGrM9JmrsviXDE92WrX34=;
 b=H3tYa1e/fICThUxoLqWrhPtHzksXbg1YfxImDWg7Ii57YFZgjB+3LG3aJpvr+Ruewk
 63KWybEoIXvQz/kqj9Zkm9evbuHn9ZmGO1v5+c3TVMadawlu6sTRmuhBVKQMpt7R5caJ
 oqEzh6x2XYGkhei3SeAiunb+SU7Cu3kcjGhtY6EWKmoYcJPUz6CMaRLL94T1I4gHGCeq
 FiIH2crpQkZgRuMbRop9hkfkzBNygS6QbwUUMOFWSo+JtM1hKSoiRXEZFjHKi1yNh1tN
 IxtHc1al4eCqufJ46raYD2dxPk9A+mIipIKJH/AGhNZzeeNQr5OmzvmNzoPzzlG+bQnf
 dnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730561765; x=1731166565;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ir4bsmkC5gM1QHQB0cTjySbGrM9JmrsviXDE92WrX34=;
 b=fFVkRfruerKZ/A2Q20eUoP8KvYoU8ukLzyomEurUEhSV16fBth+fRDVYnUkrbRdNuD
 ycfuM34xA0L7tisd7/f8/GqE5xKwL/1hhFRz9SWhH80Rx6uY98dfgHZU19ywpfz/YCno
 m3HCB4rnPB2Zkt5wMkGCr+5gD31PrlwZcZMKEET0u/X4ZZniTsYH20KoIoVc0FvQgGi0
 X2OjMvyzp9+3qqkb/oMI1euvw6egNsOIV6ha5UJ8AvrKf8ZFCUaIw56M4oHs4Z6tcIsO
 HHnZOkOMlqwxeLpLuJ1O4ikfGrtHcHXsjXzw3p9A/EL7kD5NMq1nKyrOziYCbBJIkjTh
 kmmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViIgB7SS50/43CgLqOBJ1eiMhE975CHOlsjv2D8+KrdbDJYlwpYr1HoMBqBU5EhumSuePsW2VDtTCP1Q==@nongnu.org,
 AJvYcCW9Bh9yfpEG1PEcVLEqeh3v97TvMLbI3NS9ZWA+NwE15jtXgcJmRZ84mrsnw+S+bROB2jKi4pQdNw==@nongnu.org
X-Gm-Message-State: AOJu0Yx0dqsOiL8pTi7bnoIVoDYw0B4mQ0Yv7cTsxfGR1ugtUomHY7Gd
 oNmfMuRZbDi1kF8dQC3tI65NcJZlEvv/nGc0inI4dIALoM56kJP3
X-Google-Smtp-Source: AGHT+IE1JTltdmrzTUrFpzS7o7IIdzACR041r7Oq3K0IED8us8W+IdlWI2cgb0dei8Eqb9868jhIOQ==
X-Received: by 2002:a17:903:2344:b0:20c:94d1:2cb9 with SMTP id
 d9443c01a7336-2111af1cdf2mr94705295ad.9.1730561764830; 
 Sat, 02 Nov 2024 08:36:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc5asm35135935ad.9.2024.11.02.08.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Nov 2024 08:36:04 -0700 (PDT)
Message-ID: <e3b7cbff-7cf9-4529-adfc-b650a4db0d81@roeck-us.net>
Date: Sat, 2 Nov 2024 08:36:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Don't set always boot properties of the emmc
 device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Luebbe <jlu@pengutronix.de>
References: <20241102143943.1929177-1-clg@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241102143943.1929177-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/2/24 07:39, Cédric Le Goater wrote:
> Commit e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
> HW strapping") added support to boot from an eMMC device by setting
> the boot properties of the eMMC device. This change made the
> assumption that the device always has boot areas.
> 
> However, if the machine boots from the flash device (or -kernel) and
> uses an eMMC device without boot areas, support would be broken. This
> impacts the ast2600-evb machine which can choose to boot from flash or
> eMMC using the "boot-emmc" machine option.
> 
> To provide some flexibility for Aspeed machine users to use different
> flavors of eMMC devices (with or without boot areas), do not set the
> eMMC device boot properties when the machine is not configured to boot
> from eMMC. However, this approach makes another assumption about eMMC
> devices, namely that eMMC devices from which the machine does not boot
> do not have boot areas.
> 
> A preferable alternative would be to add support for user creatable
> eMMC devices and define the device boot properties on the QEMU command
> line :
> 
>    -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
>    -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8
> 
> This is a global change requiring more thinking. Nevertheless, in the
> case of the ast2600-evb machine booting from an eMMC device and when
> default devices are created, the proposed change still makes sense
> since the device is required to have boot areas.
> 
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Fixes: e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
> HW strapping")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/arm/aspeed.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index e161e6b1c582..ac6d8dde71b3 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -338,7 +338,18 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>               return;
>           }
>           card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
> -        if (emmc) {
> +
> +        /*
> +         * Force the boot properties of the eMMC device only when the
> +         * machine is strapped to boot from eMMC. Without these
> +         * settings, the machine would not boot.
> +         *
> +         * This also allows the machine to use an eMMC device without
> +         * boot areas when booting from the flash device (or -kernel)
> +         * Ideally, the device and its properties should be defined on
> +         * the command line.
> +         */
> +        if (emmc && boot_emmc) {
>               qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
>               qdev_prop_set_uint8(card, "boot-config",
>                                   boot_emmc ? 0x1 << 3 : 0x0);

That second boot_emmc check is no longer necessary, so this could be
simplified to
		qdev_prop_set_uint8(card, "boot-config", 0x1 << 3);

Thanks,
Guenter


