Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FFED3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8S8v-0007gQ-Eh; Tue, 05 Nov 2024 17:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8S8t-0007f7-37; Tue, 05 Nov 2024 17:35:19 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8S8o-00029I-Qx; Tue, 05 Nov 2024 17:35:17 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5139cd0032cso1401961e0c.2; 
 Tue, 05 Nov 2024 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730846112; x=1731450912; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUPuM9NJ2R5BQ9TwKHhx/vPqhs6YfTIAfdUG396c+6c=;
 b=Xckxno8/mgpvUv8bW2XzzNnI3gKddYoMl6fMR4wTQ+t/yOcqMaTdJivpRFbitZ8qG8
 PnaMbX3hPVSY1v5nRDNcJSRwPv1rBXHrSayfNzZIlSba93xOfuR6IamTbe36lb7rHMCt
 7QpIiBnRRQTglZjMDrAdZlh5kgeKFVCLXMZYITDonI7s6ja2DR0l9ywZDTcu/TeAhll0
 0Gy9WJSEdMFw/qYgwnas+AgL4V4HM3lB4UxDhhqB148JhUS7OPuAFaGH8Whc8SWdayYd
 rjHXFxCYyedtj1aAj6R2aHXkKZWvUsc6vuC3jMNY14oqr9braX9nDSM+yTyHmqLmkXtv
 SHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846112; x=1731450912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUPuM9NJ2R5BQ9TwKHhx/vPqhs6YfTIAfdUG396c+6c=;
 b=CiB7Go0EopW11anTySTbiQnoCczrBt/MtfXARcxQo/loVh5kg1rlXMYmF5LJhpxc0u
 vVXrcPFUrx4Wll+nzLuepPGlKheH32IYS4cN4ZOSZcxnEYviyyyJxq+J2cQ1hJH+Yj3I
 zWbWt/nsYSFEJLC3E6c1zswBoS4WEZbzMwHy+pl8nl9J0QtYuKcoaWdHvxOXAl1M/OnE
 IXX12qADYcAt6UMwDGIdjZh/6ehKQTQjNS6v91X5UdhbCMgrO1LFqzZxvhFxz03f3cs6
 h3X84n7WZtDXwUtfkRx3QVO6T/zHmvIgwVHwbpciiT/PrfjI0EAKhagJjXFOMjguzJuA
 QqVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU19EXmE2PekkkaU9/SuuQf3enDbcLFtZDQ8qmBnHttwiFYOVJiHVN3K6h2Q0E43OEBUm+ERDzp4w==@nongnu.org
X-Gm-Message-State: AOJu0Yz2uYhOJNPGUP67zBylq6xDX7l4ZdGi7/6ic9Q3B1RTC+KyJy3Z
 C1I2LlC/9T9IcScfDF1GTnZHNpvffmzCS0dsfY2QQvG9/aNlGNDuO9WtryJuoTwEloD174od3/a
 ZqG3JTDwPmEOcJLY5qJRJgvjwuPc=
X-Google-Smtp-Source: AGHT+IHhD8qjni7Ey7MPULzcFNpaZ/oPUcd8D0oWIcWsTgZjT3boSJ3Eg2G7epc6a/6h0fMc/JLGBBCdp/Aj5aH1L5E=
X-Received: by 2002:a05:6122:4f84:b0:50d:66e1:826c with SMTP id
 71dfb90a1353d-5106b1c0385mr19920281e0c.11.1730846111873; Tue, 05 Nov 2024
 14:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-4-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:34:45 +1000
Message-ID: <CAKmqyKOf05=ppeHYRzwU0MRF7PQLfaXEF4ErheevVbNU4AO1Cw@mail.gmail.com>
Subject: Re: [PATCH 03/19] hw/microblaze/s3adsp1800: Explicit CPU endianness
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 5, 2024 at 11:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> By default the machine's CPU endianness is 'big' order
> ('little-endian' property set to %false).
>
> This corresponds to the default when this machine was added;
> see commits 6a8b1ae2020 "microblaze: Add petalogix s3a1800dsp
> MMU linux ref-design." and 72b675caacf "microblaze: Hook into
> the build-system." which added:
>
>   [ "$target_cpu" =3D "microblaze" ] && target_bigendian=3Dyes
>
> Later commit 877fdc12b1a ("microblaze: Allow targeting
> little-endian mb") added little-endian support, forgetting
> to set the CPU endianness to little-endian. Not an issue
> since this property was never used, but we will use it soon,
> so explicit the endianness to get the expected behavior.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
> index dad46bd7f98..37e9a05a62a 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -71,6 +71,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
>
>      cpu =3D MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
>      object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abo=
rt);
> +    object_property_set_bool(OBJECT(cpu), "little-endian",
> +                             !TARGET_BIG_ENDIAN, &error_abort);
>      qdev_realize(DEVICE(cpu), NULL, &error_abort);
>
>      /* Attach emulated BRAM through the LMB.  */
> --
> 2.45.2
>
>

