Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BAF607180D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=LXzGxHhp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kkSO0NHx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQZFF-0007NJ-70; Mon, 09 Nov 2026 18:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQZF6-0007Md-C7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:57:41 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQZF4-0003es-FT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:57:40 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 6AE06EC0223
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2026 18:57:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 18:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794268655; x=1794355055; bh=bxDSk1l0hwoR1GLBMbOZD31cfDjL72Mx
 cfCoBrQWbqM=; b=LXzGxHhpz1G85JX+WHbiNfBXBIpa2egl6eHVr5ie2WYUDaKX
 mHL2BvZRRV+ld+hvReSDJK06cAxsq1dA64v7Yef+SF0HmcIcjZ1nhvTyf0gi+UBx
 0QNIiwW8YW1Z5CfxFlJf7jVythZ2Kq6GrQGfwnz/XleWtf7/W+b0tFEnsmDRHxz8
 KQ7JfwzS0fx97U96XeKn5RLNoAn8g/i7V95Hru+gEA16y2i4if2dFCi2VRH1oYzu
 zwm88bYo5gzolVu5X/pLAqyDjBYCVEOEOo7uOlZq/JTodG8LHPPwhE2GJO0SlE48
 6jfzuf9KLk0GEaieK2mmHY01ksxaqX3nPF7Dkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794268655; x=
 1794355055; bh=bxDSk1l0hwoR1GLBMbOZD31cfDjL72MxcfCoBrQWbqM=; b=k
 kSO0NHx5A3Kew05uk2TVmK+skcm+BEpBF5zCqnTLH6fEKKkYxJS6kTJBMF91YIlP
 4Ned/TZuJeS8oLmN4D8CgKBSR24FncR0fNw6gsZwS9SGWT3PF5fA8zKeR+SFOtLw
 QJpRLjZ52PkTVFb26WJzpb76G/Nt7K8AcB8HZNNwLACszNKjS1B1H6qNYxTiywYP
 JpJvb36o7aITl1pYOdfmh8oqSlvET14BysbQ/eXZRlOFmdBRZJIcVlhzTLJOL735
 /bXoHm2KiNWKuBRpZkfxs6eOdzutpbOeQNNxLfKknuIaixxw/3Yx7sUIIS6BRkfp
 Wy9H8XibpmFloUNhXFiQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794268655; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:Wc0AW45AVaJhZ7KPJdwwqfNO73u9t87VmQcBAcqzl3hBi2b
 1/U+THUSxo6/TibEPgmf+1UbLVN15E7MwyDqwXJDuMUYgrUIxeNKr+KEBir+70Bn
 k1V4I8Qm/uHDB7d8hMyjAvTDCpolW/Wwi6izMFyqNAoqslXYxJDQmgSnIzQG1Y2n
 9AQXATXmu39X8wmgHrxh7DIl2IahzAutZAl/yWs/H6B3ChYJ7Wr6szWU7qTtTgCn
 ZULui2E6mFOCaA9D9C+uzmKS+AtLXYaAuKiwpCwkN6UOkIU6ja+cbWX3V+IT/QCl
 Bxg6PfHQhD0W77KZ6nrF0jFwUeEhgk1iqRQ21dA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:+oSr0iX8XmRR8k4uRlJbjxyvtjE32Zny+ix6BOVnYzQ=:bxDSk1l0hwoR1GLBMbOZD31cfDjL72MxcfCoBrQWbqM=;
X-ME-Sender: <xms:713yaoLbzXUUQE1TQLrDYzMV4a5HB6Xh7gNXYf1Zu5NQBQzoEwoFRw>
 <xme:713yajFh5cJyX1rTHmHheGnQKSWnOzL4VezfsPlDVNG8kThGfoj-Ph6zH97uyhSu0
 PPwiYmobFGgDBxD7mvu05ct74FReJ_wIF0c_gxLb5-QstJBH05Rj6az>
X-ME-Received: <xmr:713yanveMDaqhJQ4nvRiAgU7Xp7jq28GRUGw-i_kOKUVT4XqTmkXyC9L2rO5vssGY52cTF80SbEQ81Ifhw8PjEzP9z4>
X-ME-Proxy-Cause: dmFkZTGQlAlJRjqeWg+Kzj7gZLRpufoaf323Xcoyu6Pzz5DsN2d//YpblkmaTccVD7w5+x
 QzImP+FaYzH3LvYUMbG4UhaM4Fzjs3xUBx/UVHj1tYcHjpUIwDZablK36XSmInLcMdpAz/
 k/PaV7bOdNLSGDkfd+025xTUMfwWZWlyYyNp+o27EAkmAzopZVJ5cjSAjXWr+5JQJlIdk5
 +jJPJh9zzWFovQqjJ/pCnx3LS6GhzQFa6RxIqwWJP+W8/Gciu6bhBDXkpV2XL/SgYVCp+5
 PihlMkcHE3XYGJeiC4evxFlw+AOoR+wFMJH09nb4naMzIb9pZNufOamCiwOw2wdgqpQpRR
 k1SnmLBBhZmSL+XNhTJHRcH5l4UNMSQOI6glLUHZDJRv2jU49V79QDbK39FmIqC0FbknuG
 2a5r9SQST3z0u1awfJn85/FM3dpvHE6mSTBBRNhWNBPR2aa0VBZnEE4ybcjo0kQqABw/yB
 iiNE+9DU3w+fhD0DV9KWEe4pEZIH5kf4/1St7TXf/1mnRXx2P9UZvWDZhXyqOYVhEitA5B
 1sn0z0l/sLOYZE9PQznztgIvMIa5ULBiLe60exiO5PXx1YihkRw0rvN5yLhUgZvqSYHrAH
 jVFyqn0GSdv3lsTOrQkToN6h6B/HpHBmXJZ9vlwXYW95MDqbtS7fJtrxeRIQ
X-ME-Proxy: <xmx:713yaqtA47zpw9YzUN7EGbj7TtPOn3SYHgJ9ilkdewrlqM85LzBcMg>
 <xmx:713yatAGxGtMqoF9XAIe8ySdgPW19sf-pdZM6FBHCFiw64vedJu-Ew>
 <xmx:713yasM0BTf71IQdoXOQm-wHksT1-40LuOw-9dnnmC5TdpkAXWsFsA>
 <xmx:713yamx9FyAbd6LSqSMkwasvE0ke6lkKhoLSDLfqZkv__X0_uV3giQ>
 <xmx:713yalvw4SJA_b48aeG6m2iIfUooVD6sKBpHK9kVFb3AzPRaSMqGQbbM>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 18:57:32 -0500 (EST)
Message-ID: <9106f25e8f91be6d5129accf1a20a4dbf7442958.camel@alistair23.me>
Subject: Re: [PATCH] hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads
From: Alistair <alistair@alistair23.me>
To: Manuele Conti <conti.manuele@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
Date: Tue, 10 Nov 2026 09:57:29 +1000
In-Reply-To: <20261021065238.15220-1-conti.manuele@gmail.com>
References: <20261021065238.15220-1-conti.manuele@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-21 at 08:52 +0200, Manuele Conti wrote:
> Writing SPI_DR already performs the synchronous SSI transfer and
> stores
> its response in spi_dr. Reading SPI_DR performs another transfer,
> using
> the previous response as transmit data, and returns the new response.
> Consequently a normal write/read pair clocks two frames on the bus
> and
> can skip bytes in a peripheral's response.

Yeah, this seems broken as it is today.

It does seem like reading SPI_DR should pop the data from the RX
Buffer, but we don't actually have an RX Buffer to pop from.

This change seems like an improvement on currently dropping the read
data, but ideally we would have a buffer to copy to/from.

>=20
> Return the response saved by the write and clear RXNE without
> starting
> another transfer. Repeated reads then leave the peripheral state
> alone.
>=20
> Add a qtest using the upstream netduino2 machine and an M25P80 flash.
> Check the JEDEC ID, RXNE clearing, and repeated DR reads. The test
> requires
> no board changes and reproduces the unwanted extra transfers before
> the
> fix.
>=20
> Fixes: 5ae74402d1f ("STM32F2xx: Add the SPI device")
> Signed-off-by: Manuele Conti <conti.manuele@gmail.com>

Thanks for the fix!

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
> =C2=A0hw/ssi/stm32f2xx_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0tests/qtest/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0tests/qtest/stm32f2xx-spi-test.c | 50
> ++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 53 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 tests/qtest/stm32f2xx-spi-test.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77..822c60a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1201,6 +1201,7 @@ F: hw/char/stm32f2xx_usart.c
> =C2=A0F: hw/timer/stm32f2xx_timer.c
> =C2=A0F: hw/adc/*
> =C2=A0F: hw/ssi/stm32f2xx_spi.c
> +F: tests/qtest/stm32f2xx-spi-test.c
> =C2=A0F: include/hw/*/stm32*.h
> =C2=A0
> =C2=A0STM32F405
> diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
> index 871d573..da1dbb7 100644
> --- a/hw/ssi/stm32f2xx_spi.c
> +++ b/hw/ssi/stm32f2xx_spi.c
> @@ -82,7 +82,6 @@ static uint64_t stm32f2xx_spi_read(void *opaque,
> hwaddr addr,
> =C2=A0=C2=A0=C2=A0=C2=A0 case STM_SPI_SR:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s->spi_sr;
> =C2=A0=C2=A0=C2=A0=C2=A0 case STM_SPI_DR:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stm32f2xx_spi_transfer(s);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->spi_sr &=3D ~STM_SPI_=
SR_RXNE;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s->spi_dr;
> =C2=A0=C2=A0=C2=A0=C2=A0 case STM_SPI_CRCPR:
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 78b3010..5984e9c 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -238,6 +238,8 @@ qtests_stm32l4x5 =3D \
> =C2=A0=C2=A0=C2=A0 'stm32l4x5_usart-test']
> =C2=A0
> =C2=A0qtests_arm =3D \
> +=C2=A0 (config_all_devices.has_key('CONFIG_NETDUINO2') and
> +=C2=A0=C2=A0 config_all_devices.has_key('CONFIG_SSI_M25P80') ? ['stm32f2=
xx-
> spi-test'] : []) + \
> =C2=A0=C2=A0 (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-tes=
t'] :
> []) + \
> =C2=A0=C2=A0 (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ?
> ['cmsdk-apb-dualtimer-test'] : []) + \
> =C2=A0=C2=A0 (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cm=
sdk-
> apb-timer-test'] : []) + \
> diff --git a/tests/qtest/stm32f2xx-spi-test.c
> b/tests/qtest/stm32f2xx-spi-test.c
> new file mode 100644
> index 0000000..619191c
> --- /dev/null
> +++ b/tests/qtest/stm32f2xx-spi-test.c
> @@ -0,0 +1,50 @@
> +/*
> + * STM32F2XX SPI controller tests
> + *
> + * Copyright (c) 2026 Manuele Conti <conti.manuele@gmail.com>
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +/* The first SSI bus found by -device belongs to SPI3. */
> +#define SPI3_BASE 0x40003c00
> +#define SPI_CR1=C2=A0=C2=A0 (SPI3_BASE + 0x00)
> +#define SPI_SR=C2=A0=C2=A0=C2=A0 (SPI3_BASE + 0x08)
> +#define SPI_DR=C2=A0=C2=A0=C2=A0 (SPI3_BASE + 0x0c)
> +#define SPI_RXNE=C2=A0 (1U << 0)
> +
> +static void test_jedec_id(void)
> +{
> +=C2=A0=C2=A0=C2=A0 static const uint8_t jedec_id[] =3D { 0x20, 0x20, 0x1=
4 };
> +=C2=A0=C2=A0=C2=A0 QTestState *qts =3D qtest_init("-machine netduino2 "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-device m25p80,bus=3Dssi");
> +
> +=C2=A0=C2=A0=C2=A0 /* Enable SPI in master mode, with software slave man=
agement. */
> +=C2=A0=C2=A0=C2=A0 qtest_writel(qts, SPI_CR1, (1U << 9) | (1U << 8) |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1U << 6) | (1U << 2));
> +
> +=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, SPI_DR, 0x9f);
> +=C2=A0=C2=A0=C2=A0 qtest_readb(qts, SPI_DR);
> +
> +=C2=A0=C2=A0=C2=A0 for (unsigned i =3D 0; i < ARRAY_SIZE(jedec_id); i++)=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, SPI_DR, 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmphex(qtest_readl(q=
ts, SPI_SR) & SPI_RXNE, =3D=3D,
> SPI_RXNE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmphex(qtest_readb(q=
ts, SPI_DR), =3D=3D, jedec_id[i]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmphex(qtest_readl(q=
ts, SPI_SR) & SPI_RXNE, =3D=3D, 0);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Reading DR again must not =
clock another byte out of the
> flash. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmphex(qtest_readb(q=
ts, SPI_DR), =3D=3D, jedec_id[i]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmphex(qtest_readl(q=
ts, SPI_SR) & SPI_RXNE, =3D=3D, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +=C2=A0=C2=A0=C2=A0 g_test_init(&argc, &argv, NULL);
> +=C2=A0=C2=A0=C2=A0 qtest_add_func("/stm32f2xx/spi/jedec-id", test_jedec_=
id);
> +=C2=A0=C2=A0=C2=A0 return g_test_run();
> +}

