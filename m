Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE30C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 23:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK52v-0000rE-PI; Wed, 19 Jun 2024 19:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sK52t-0000qx-Bh; Wed, 19 Jun 2024 19:48:55 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sK52q-0003x1-Hi; Wed, 19 Jun 2024 19:48:55 -0400
Received: from [192.168.68.112]
 (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 88E5A20154;
 Thu, 20 Jun 2024 07:48:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1718840925;
 bh=IEgncZSK+nXv6/fbH5xMKM4cWSDqyVFNFDNZAR7rAck=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=cnJeAxGRxdWrUM+S92Q/2YrFAKdVJHdxxh4dpNqLlknRL2slhLwYmZuc/tVr8k3o7
 0ydTZhFmfnTggHp9A/4M8Wa6W474Z5UmF5aZgFkzXrexutOhLO2nS/hMGbS5sWNPDu
 J4hePohouezTKfKPs/Oi/Ne81W0i98XFnNaMpRZsmIFRDzvvA06ZN5ebk6lhcPISzx
 11ZntAPrP10DtRCGr6rX1iP/BaDXQc3zEhd4hYvXybb9/9TvP7Dqc4pTTdi4TunoqJ
 3mLbffNMGQZAQfXa4bjtYGvNg0fxkNqn0e1TvWeHfJrWoQ1JwyxHTb4d+DeJXAPKnb
 dMnv3ALSFwj0A==
Message-ID: <7fcbf65de8bc5668e036249d6408bf4e4cbc6efe.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3] hw/gpio/aspeed: Add reg_table_size to AspeedGPIOClass
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Zheyu Ma <zheyuma97@gmail.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley
 <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Date: Thu, 20 Jun 2024 09:18:43 +0930
In-Reply-To: <20240619183638.4073070-1-zheyuma97@gmail.com>
References: <20240619183638.4073070-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2024-06-19 at 20:36 +0200, Zheyu Ma wrote:
> ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
> function. This issue occurred when reading beyond the bounds of the
> reg_table.
>=20
> To enhance the safety and maintainability of the Aspeed GPIO code, this c=
ommit
> introduces a reg_table_size member to the AspeedGPIOClass structure. This
> change ensures that the size of the GPIO register table is explicitly tra=
cked
> and initialized, reducing the risk of errors if new register tables are
> introduced in the future.
>=20
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=3Dqtest, -m 512M -machine ast1030-evb -qtest stdio
> readq 0x7e780272
> EOF
>=20
> ASAN log indicating the issue:
> =3D=3D2602930=3D=3DERROR: AddressSanitizer: global-buffer-overflow on add=
ress 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e8=
8
> READ of size 2 at 0x55a5da29e128 thread T0
>     #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
>     #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:=
11
>     #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
>     #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:142=
6:16
>     #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459=
:9
>     #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:283=
6:18
>     #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
>     #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

> ---
> Changes in v3:
> - Add the reproducer
>=20
> Changes in v2:
> - Introduce the reg_table_size to AspeedGPIOClass
> ---
>  hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
>  include/hw/gpio/aspeed_gpio.h |  1 +
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index c1781e2ba3..fd4912edae 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -559,6 +559,12 @@ static uint64_t aspeed_gpio_read(void *opaque, hwadd=
r offset, uint32_t size)
>          return debounce_value;
>      }
> =20
> +    if (idx >=3D agc->reg_table_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bou=
nds\n",
> +                      __func__, idx);
> +        return 0;
> +    }
> +
>      reg =3D &agc->reg_table[idx];
>      if (reg->set_idx >=3D agc->nr_gpio_sets) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
> @@ -785,6 +791,12 @@ static void aspeed_gpio_write(void *opaque, hwaddr o=
ffset, uint64_t data,
>          return;
>      }
> =20
> +    if (idx >=3D agc->reg_table_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bou=
nds\n",
> +                      __func__, idx);
> +        return;
> +    }
> +
>      reg =3D &agc->reg_table[idx];
>      if (reg->set_idx >=3D agc->nr_gpio_sets) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
> @@ -1117,6 +1129,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectCl=
ass *klass, void *data)
>      agc->nr_gpio_pins =3D 216;
>      agc->nr_gpio_sets =3D 7;
>      agc->reg_table =3D aspeed_3_3v_gpios;
> +    agc->reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
>  }
> =20
>  static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
> @@ -1127,6 +1140,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass=
 *klass, void *data)
>      agc->nr_gpio_pins =3D 228;
>      agc->nr_gpio_sets =3D 8;
>      agc->reg_table =3D aspeed_3_3v_gpios;
> +    agc->reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
>  }
> =20
>  static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void=
 *data)
> @@ -1137,6 +1151,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(Obj=
ectClass *klass, void *data)
>      agc->nr_gpio_pins =3D 208;
>      agc->nr_gpio_sets =3D 7;
>      agc->reg_table =3D aspeed_3_3v_gpios;
> +    agc->reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
>  }
> =20
>  static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void=
 *data)
> @@ -1147,6 +1162,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(Obj=
ectClass *klass, void *data)
>      agc->nr_gpio_pins =3D 36;
>      agc->nr_gpio_sets =3D 2;
>      agc->reg_table =3D aspeed_1_8v_gpios;
> +    agc->reg_table_size =3D GPIO_1_8V_REG_ARRAY_SIZE;
>  }
> =20
>  static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
> @@ -1157,6 +1173,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass=
 *klass, void *data)
>      agc->nr_gpio_pins =3D 151;
>      agc->nr_gpio_sets =3D 6;
>      agc->reg_table =3D aspeed_3_3v_gpios;
> +    agc->reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
>  }
> =20
>  static const TypeInfo aspeed_gpio_info =3D {
> diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.=
h
> index 904eecf62c..e66036ac39 100644
> --- a/include/hw/gpio/aspeed_gpio.h
> +++ b/include/hw/gpio/aspeed_gpio.h
> @@ -75,6 +75,7 @@ struct AspeedGPIOClass {
>      uint32_t nr_gpio_pins;
>      uint32_t nr_gpio_sets;
>      const AspeedGPIOReg *reg_table;
> +    uint32_t reg_table_size;
>  };
> =20
>  struct AspeedGPIOState {


