Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD32D59F5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ktu-0005aN-Ii; Wed, 06 Nov 2024 13:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t8ktp-0005Yg-AL; Wed, 06 Nov 2024 13:37:01 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t8ktm-0006Tl-Tr; Wed, 06 Nov 2024 13:37:00 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso2182418a12.0; 
 Wed, 06 Nov 2024 10:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730918216; x=1731523016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GecbNIdr79EaVSaOipaVBB8D5UwkRHIlzUxQWhS71Nw=;
 b=AilKyzBbjB65k/nxjM+/rUQUrX/ZqSmc+2OxDvVjs4z9I3WDqWEWTkWWFqKmQGlk2i
 xl1AH60M8sUpDv1qWjf4vis218DKV0qI4ZVxPDsCRfr6XXr9M82lDjH/2DjroCh+wwW6
 W8IYGHZdWellgjxzJJ5x60qapBn3lZgHwTJQDQirPgRnBM29pDUm3UmiXPDzYHoYsNZg
 zA3+3OyKry0Gdke0jBmR8h2iyME85VUr8ER4GRc+Z212eBRwfD0SXCM1ksuAw4T8qg7F
 LSYDyQ9Uvofdck/YdK7tuIDqOQqhMTRJ29VpHk4TvpI4YjBTTiF4Uvy+iXbmI0h/CMIr
 mAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918216; x=1731523016;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GecbNIdr79EaVSaOipaVBB8D5UwkRHIlzUxQWhS71Nw=;
 b=sbwsE2ES5stQlK8uVKy1tKJtMYPnQiw7zIcJI6pmZDZxD0buAx8dugn28fyc+JoiNY
 UtXYfUT7aq3YHr5zd2RRhCg7yi1o/oujt77aW3VjKNz8caXZ91kEgMty/Vjv+qMosjp7
 SQ52gKg1fsWPUjlZhbW7J4DmowXisrbXQsqZdL3WsicWe0gfVlPuSoGrksyfJFGr2OUN
 hq47oEADPG4P1eYElrhFzGN00yYeR8yznRW3v99SgtTdS1guvFJuBPdGHh/1j374Gd3y
 8RkGLkPumeoJRtkQV+vqwFUjVxIW1d4OQ9o4OLf1MgaUrvOloiPUxLvncY3ZQxcSFSal
 D3HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7fI6+wOfZAGr4VVG3xcEQbgA6kpEvWFHfjnr/9j8uq+iXgg6IYh/lPmCWd+fbGmLQCQ4ePImg70Su@nongnu.org,
 AJvYcCWuSfuPUpAfkN+iv5DT29Lcri9GWxmZuf6F6AkaliD0mRwpwws6I2zGbE7vUQKjLdSXYV6SnfM4deI=@nongnu.org,
 AJvYcCXPjsnqVAVesYXzvu1jST52gXXxIqXRd1LhTN5DsTyu0B0kaWjpRVUtjehdgY2apv0gl30YHUZNKyDIGQ==@nongnu.org
X-Gm-Message-State: AOJu0Yws8Ejp0CO4e0f03v6ROetsYkSdG1hCSWGp9zmXYBq4by0Lyvs1
 N2ddmexQKBnp/wGPKPGgvSvTImuU5rc3Uh14VPftpLBazhY3OI2v
X-Google-Smtp-Source: AGHT+IFzx+YgXfrekzqtIzfQVzUrSMKNT/jqkrafO7DleH4KECvpD0S3Jcvr8SlfInCOSMdeW2Notw==
X-Received: by 2002:a17:907:2d8f:b0:a91:1699:f8eb with SMTP id
 a640c23a62f3a-a9ed519b0d9mr15152166b.28.1730918215660; 
 Wed, 06 Nov 2024 10:36:55 -0800 (PST)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17cf862sm322007866b.107.2024.11.06.10.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 10:36:55 -0800 (PST)
Date: Wed, 06 Nov 2024 18:34:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 00/26] E500 Cleanup
In-Reply-To: <b28ffff6-7b7f-47cb-b39c-8b132e353a2b@linaro.org>
References: <20241103133412.73536-1-shentey@gmail.com>
 <b28ffff6-7b7f-47cb-b39c-8b132e353a2b@linaro.org>
Message-ID: <441E1287-7293-4C90-B88D-D8AF4B235815@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 5=2E November 2024 22:55:20 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 3/11/24 14:33, Bernhard Beschow wrote:
>> This series is part of a bigger series exploring data-driven machine cr=
eation
>> using device tree blobs on top of the e500 machines [1]=2E It contains =
patches to
>> make this exploration easier which are also expected to provide value i=
n
>> themselves=2E
>>=20
>> The cleanup starts with the e500 machine class itself, then proceeds wi=
th
>> machine-specific device models and concludes with more or less loosely =
related
>> devices=2E Device cleanup mostly consists of using the DEFINE_TYPES() m=
acro=2E
>>=20
>> Patches still missing R-b tags: 1,2,6,8,9,15,23,26
>
>I queued most of the reviewed patches=2E

Thanks, Phil=2E Much appreciated!

Best regards,
Bernhard

>
>> Bernhard Beschow (26):
>>    hw/ppc/e500: Do not leak struct boot_info
>>    hw/ppc/e500: Remove firstenv variable
>>    hw/ppc/e500: Prefer QOM cast
>>    hw/ppc/e500: Remove unused "irqs" parameter
>>    hw/ppc/e500: Add missing device tree properties to i2c controller no=
de
>>    hw/ppc/e500: Reuse TYPE_GPIO_PWR
>>    hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>>      resources
>>    hw/ppc/e500: Extract ppce500_ccsr=2Ec
>>    hw/ppc/ppce500_ccsr: Trace access to CCSR region
>>    hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
>>    hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access
>>    hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
>>    hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
>>    hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
>>    hw/net/fsl_etsec/miim: Reuse MII constants
>>    hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
>>    hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
>>    hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
>>    hw/intc: Guard openpic_kvm=2Ec by dedicated OPENPIC_KVM Kconfig swit=
ch
>>    hw/sd/sdhci: Prefer DEFINE_TYPES() macro
>>    hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
>>    hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
>>    hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
>>    hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
>>    hw/vfio/platform: Let vfio_start_eventfd_injection() take
>>      VFIOPlatformDevice pointer
>>    MAINTAINERS: Add hw/gpio/gpio_pwr=2Ec
>

