Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B13D132B4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vxd-0004Eh-CB; Mon, 04 Nov 2024 07:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7vxT-00045p-PD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:13:23 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7vxR-0006Pv-Fh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:13:22 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7187e0041d5so2162512a34.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730722400; x=1731327200;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rT/T/00MbZ7/p0zWU/Q2u9xuQdhfkoFCvi/Stn9vBFs=;
 b=iipJ2rhR3W3Jwfq/QuhldxPKAJ54EkFwFTngFaujz/2yE3t/9IG3LTEkldm/TM4X3m
 4rCASpU1wpLz2b043jt7pW4u79AgJ1oxz/fkLWHhWDYoS2vEjtPq/kKvUu+yD9eY1BZJ
 Z2rG52qeT/kbwu85ETFi4yDr8zdsw8cqSnsnunQ/J98VgUd4Jg4KeQGYO4W9XtrVoGWc
 yT9xB8Zwti1NHS0Jl9rS6Pwye/EQMkM4TDKtRV0GR8JCEmCHcVLiVI6a0uyzyqrPAM90
 SgzPxr1hlfb6jEvPvxbRECSCj9ElikeBZaJJFVIvdc4e5WujTvdT91gRI4LFUZwGmf6e
 cvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730722400; x=1731327200;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rT/T/00MbZ7/p0zWU/Q2u9xuQdhfkoFCvi/Stn9vBFs=;
 b=mJYk47bmVI9Bz/oGYb3+9JQGB4KEjHJAJ5jhPPQcxZ5H/DnOf++m18pW5DPZ+hMPbk
 p1sIiL+8ONawsxFamJL52wlx46NQ9CW6VA1gn20DaBLtTrUN565OYiZGgCIlIz54GJf/
 ewPw9VerX1xfUPDQp4OAT4QpjIMc9xTtRrql6a4aCsLOi4No436NZn6GhRPIzIdL+vaU
 vRp3mSuEDTbjnJzgRn4WOGuPK0V+FPSZj2q+cuQWxo0AQauqwMRWtAfHsFMTTfAVTqng
 zSvGjuQs8DZ3f35l0teVMpD55r1L0ZOWfvHK7RA0I6w1eUlA5SFyuDSagajnjCGxYtW0
 jWhg==
X-Gm-Message-State: AOJu0YxUrBkfnQR/RiQUXntb30O1SiKj7NWWuI5O3oB5vY9oJnVQwwlD
 If/yainW1FJQHAkUSIul4k+PoNYBT/Wn6Ke93RlGFRTMegHZWPpMyABZvAYwqFU=
X-Google-Smtp-Source: AGHT+IH1fiZDe9OBeF17ra4i0+IKQH17ffYqbmB91NfAC/7aK+AP75QZjRMnngQ/VbOsy5BcwAdLNA==
X-Received: by 2002:a05:6830:34a0:b0:715:4e38:a1ab with SMTP id
 46e09a7af769-7189b5436cemr11507705a34.22.1730722399705; 
 Mon, 04 Nov 2024 04:13:19 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8f65:c09a:8672:74e8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7189cc6a2absm1942673a34.30.2024.11.04.04.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 04:13:18 -0800 (PST)
Date: Mon, 4 Nov 2024 06:13:12 -0600
From: Corey Minyard <corey@minyard.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Kevin Wolf <kwolf@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 22/26] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
Message-ID: <Zyi6WE5mhJtANCxI@mail.minyard.net>
References: <20241103133412.73536-1-shentey@gmail.com>
 <20241103133412.73536-23-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241103133412.73536-23-shentey@gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=corey@minyard.net; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Nov 03, 2024 at 02:34:08PM +0100, Bernhard Beschow wrote:
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Yeah, I think this is best.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/smbus_eeprom.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 9e62c27a1a..e3e96d4a2d 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>      dc->user_creatable = false;
>  }
>  
> -static const TypeInfo smbus_eeprom_info = {
> -    .name          = TYPE_SMBUS_EEPROM,
> -    .parent        = TYPE_SMBUS_DEVICE,
> -    .instance_size = sizeof(SMBusEEPROMDevice),
> -    .class_init    = smbus_eeprom_class_initfn,
> +static const TypeInfo smbus_eeprom_types[] = {
> +    {
> +        .name          = TYPE_SMBUS_EEPROM,
> +        .parent        = TYPE_SMBUS_DEVICE,
> +        .instance_size = sizeof(SMBusEEPROMDevice),
> +        .class_init    = smbus_eeprom_class_initfn,
> +    },
>  };
>  
> -static void smbus_eeprom_register_types(void)
> -{
> -    type_register_static(&smbus_eeprom_info);
> -}
> -
> -type_init(smbus_eeprom_register_types)
> +DEFINE_TYPES(smbus_eeprom_types)
>  
>  void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>  {
> -- 
> 2.47.0
> 
> 

