Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5530D5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9fBj-0000et-DJ; Sat, 09 Nov 2024 01:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9fB3-0006vc-5i
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:42:39 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9fB1-0002h2-4c
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:42:32 -0500
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so417195566b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 22:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731134549; x=1731739349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/H2qO36ATbxDWZ4mWVuZziP41ISPn6jJdrrP3YzKMY=;
 b=hhkFt97qIG16c613RmhPEX2gsUc7r2EItVKkia+v6pYqMNG5xj+0WSAGuZNLAVxrJX
 nWgSaBaXgcbV7L/2TC0g2sF3m5hO9K4jas5VOaZK8cx9qoTCQIQJ1qgbNfkAznnvtBkX
 iBgR533eo1RH38mA8tf2LroC2kB8jkVIiQxNxaePhZvfsRzzUbp+8ozM5afjveaO/YAS
 4oetlyMVCxM4Zn9hIRyg7NXQGxMHNnfpTLL+pvhmSw9LQJdM5hvzZfe1CbEz7jM98BrV
 gadUDo5glPIh4+hutSnXJ8Ky7Lnnz+WZAdczZNvXM+6MNs9na9qQWuAeLn4yOt9/7qys
 3Olg==
X-Gm-Message-State: AOJu0Ywfwu6XStf55burWRXCSPTQo/cXdmfnfPm43MkqgAF7HjmMNQ9e
 eoGT7ycemNNbX3es9Bbny2pTLO+12zSldUSp/5eCnDJI5zQCYMyi
X-Google-Smtp-Source: AGHT+IEpCDirefYJ1XvSvyjemP96RQwc9BT4xA6vRnMS9LAvfGorR3mF478Lf6M0MQqE1Secs8gIDA==
X-Received: by 2002:a17:907:60cf:b0:a9a:1253:4d81 with SMTP id
 a640c23a62f3a-a9eefff1ffemr431963466b.47.1731134548441; 
 Fri, 08 Nov 2024 22:42:28 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0deeed0sm326761966b.139.2024.11.08.22.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 22:42:27 -0800 (PST)
Date: Sat, 9 Nov 2024 07:42:25 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Richard Henderson
 <richard.henderson@linaro.org>, xen-devel@lists.xenproject.org, Paolo
 Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jia Liu <proljc@gmail.com>, Stafford
 Horne <shorne@gmail.com>, Paul Durrant <paul@xen.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/5] hw/openrisc: Mark devices as big-endian
Message-ID: <20241109074225.76e0e4ad@tpx1>
In-Reply-To: <20241106184612.71897-5-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.44; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f44.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am Wed,  6 Nov 2024 18:46:11 +0000
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> These devices are only used by the OpenRISC target, which is
> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/openrisc/openrisc_sim.c | 2 +-
>  hw/openrisc/virt.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 9fb63515ef..794c175bdb 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -266,7 +266,7 @@ static void openrisc_sim_serial_init(Or1ksimState *st=
ate, hwaddr base,
>      }
>      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
>                     serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
> -                   DEVICE_NATIVE_ENDIAN);
> +                   DEVICE_BIG_ENDIAN);
> =20
>      /* Add device tree node for serial. */
>      nodename =3D g_strdup_printf("/serial@%" HWADDR_PRIx, base);
> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> index 47d2c9bd3c..ede57fe391 100644
> --- a/hw/openrisc/virt.c
> +++ b/hw/openrisc/virt.c
> @@ -236,7 +236,7 @@ static void openrisc_virt_serial_init(OR1KVirtState *=
state, hwaddr base,
>      qemu_irq serial_irq =3D get_per_cpu_irq(cpus, num_cpus, irq_pin);
> =20
>      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
> -                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
> +                   serial_hd(0), DEVICE_BIG_ENDIAN);
> =20
>      /* Add device tree node for serial. */
>      nodename =3D g_strdup_printf("/serial@%" HWADDR_PRIx, base);

According to https://openrisc.io/or1k.html the openrisc CPU could be
implemented as little endian, too ... so would it make sense to use
a runtime detected value here instead?

 Thomas

