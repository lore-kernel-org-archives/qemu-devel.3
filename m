Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C1CFB45F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuAk-0000Sg-OO; Mon, 07 Oct 2024 16:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1sxuAi-0000S3-Jo
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:17:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1sxuAf-0002Uh-La
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:17:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42f6995dab8so68925e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728332251; x=1728937051; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OqY1JLysujOhLKGTUwau64jwByTf7xuIWMyoIAFmV3s=;
 b=z3l8xh2LLM6GvShZ9K47/cfSTdltEV+RAaCqGx+JPykyP9/U/BvK4SDSxOVA9gkggx
 azmzk+o5M0j6/TW1Jyj7XQ4h+70lloPvMj64TRCC/O24RpB/wlCACnEVoR5HO0O6RVZY
 4ZXnnlUd/C6dcSmq9WMfeS9zjlbOaPNOAE34CUvygPVvtzZMuiw7PWtM902FBiUbuf2n
 ooC6lm7fQTjtiJ0YJYEYRDBp5Dz6MnkgTLeSj5E48sd4yepBM+H1i5hqOJoxuC0ETbB0
 RfdI4K8SZDIKxzuCbWb1RM2F6jpLCoQMhW7qbzGroDI2m/zinYaoAOCV5sJIu4xWrWcz
 RGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728332251; x=1728937051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OqY1JLysujOhLKGTUwau64jwByTf7xuIWMyoIAFmV3s=;
 b=vxN1NUNC/hpWoL5aaaoW2bg3X1YTqqR2XwFCKiHn+XRGCdfWuZTWNTHtvhwl4rUNvu
 zAvysHq/BdX9SlrGYwup9u3W9YDSlWaskWJIxODglSAxxh16rigVgGzUuxFuIBZMoD8t
 I8fWYjokcl3yK4MjmJRS0Rkrt57kNnfNiB7fUlRxpQX6k0ONjeeXXDTzWunCrRz0Bfkm
 PzNcaOVWkdHshT0Xiym4Fy/bAwbvIn4vGs2odXRO4ao74jGULA7Dz5ikcQn8Kn03a2Um
 Y54ChiVdOkS63as6GZZXROzo05TGov7HHYw34LcwdUFLAXJz7HO6BzF6LmlcbLgnS5Cj
 LJ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrugefxCSEuSfyEU8IaVxxOALZuI4Vk7LA/ArLPx749xfCgROmHCNim/9T6P41zIOHVk1WpeWMIVlV@nongnu.org
X-Gm-Message-State: AOJu0Yzv58M3qEUrS6ggOAeDSO8f3DBUKqUb7SVZVDshSGG2SePp/H/8
 80tP3eNcomjCPD5swRVns419GjPiOcKzz5gGg9VHfX5hs1ILgJjrD08Fs6RQpzH/2wCdtIq4VSH
 oVGzsqMxjoVUwnKSFudyvtshfxZw/oh23t8nZ
X-Google-Smtp-Source: AGHT+IEg3E63Syd/ht8VNFJ+2XMAFBGxKYwq+QeHgQrn2EzwdliQcNnanL/H9x61aOQb0Si0qs05nK96hkIYqvO1zFE=
X-Received: by 2002:a05:600c:4e11:b0:42f:808e:52e6 with SMTP id
 5b1f17b1804b1-42fcdcddebemr1012135e9.6.1728332246209; Mon, 07 Oct 2024
 13:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241007171700.1594342-1-titusr@google.com>
 <5e176ecece460f8676184b51ef4b3227@codethink.co.uk>
In-Reply-To: <5e176ecece460f8676184b51ef4b3227@codethink.co.uk>
From: Titus Rwantare <titusr@google.com>
Date: Mon, 7 Oct 2024 13:16:47 -0700
Message-ID: <CAMvPwGrczK1ZwGu5kbYx_MiG7dFFeLr0ShoQa02gRjqTc6_hgA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add Quanta GSZ bmc machine
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: peter.maydell@linaro.org, minyard@acm.org, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, venture@google.com, wuhaotsh@google.com
Content-Type: multipart/alternative; boundary="00000000000097778e0623e8b52e"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=titusr@google.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000097778e0623e8b52e
Content-Type: text/plain; charset="UTF-8"

Ack. There are devices that get attached to these muxes. I need to send
another revision of the patches in
https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg01514.html, but
for the moment. This patch can go in separately from that series.

-Titus

On Mon, 7 Oct 2024 at 12:16, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

>
>
> On 2024-10-07 18:17, Titus Rwantare wrote:
> > This patch adds the quanta-gsz-bmc target, a current Google machine of
> > the day. This machine will be used as a platform to enable features
> > such
> > as the PECI bmc interface, and Intel eSPI virtual wire interface in
> > QEMU.
> >
> > Signed-off-by: Titus Rwantare <titusr@google.com>
> > ---
> >  hw/arm/npcm7xx_boards.c | 140 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >
> > diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> > index e229efb447..e1ff5af756 100644
> > --- a/hw/arm/npcm7xx_boards.c
> > +++ b/hw/arm/npcm7xx_boards.c
> > @@ -48,6 +48,8 @@
> >  #define NPCM750_EVB_POWER_ON_STRAPS ( \
> >          NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_J2EN)
> >  #define QUANTA_GSJ_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT
> > +#define QUANTA_GSZ_POWER_ON_STRAPS ( \
> > +        NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_SFAB)
> >  #define QUANTA_GBS_POWER_ON_STRAPS ( \
> >          NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_SFAB)
> >  #define KUDO_BMC_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT
> > @@ -269,6 +271,109 @@ static void quanta_gsj_fan_init(NPCM7xxMachine
> > *machine, NPCM7xxState *soc)
> >      npcm7xx_connect_pwm_fan(soc, &splitter[2], 0x05, 1);
> >  }
> >
> > +static void quanta_gsz_i2c_init(NPCM7xxState *soc)
> > +{
> > +    I2CSlave *i2c_mux;
> > +
> > +    /* i2c1 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> > TYPE_PCA9548,
> > +                                      0x75);
> > +    /* pca6416@0x20 */
> > +
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> > +                                      TYPE_PCA9548, 0x77);
> > +
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> > "raa229004", 0x72);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> > "raa229004", 0x72);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
> > "isl69260", 0x72);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3),
> > "isl69260", 0x72);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4),
> > "isl69260", 0x72);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> > "isl69260", 0x72);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> > "adm1272", 0x1f);
> > +
> > +    /* i2c2 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2),
> > +                                      TYPE_PCA9548, 0x77);
> > +    /*         - channel 0: tps546d24 @25
> > +     *         - channel 1: delta,dps800 @69
> > +     */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> > "raa228000", 0x68);
> > +    /*          - channel 2: delta,dps800 @68 */
> > +    /* max31725 is compatible with tmp105. */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105",
> > 0x5c);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105",
> > 0x5c);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105",
> > 0x5c);
> > +
> > +    /* i2c3 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3),
> > TYPE_PCA9548,
> > +                                      0x77);
> > +
> > +    /* i2c4 */
> > +    /* mobo_fru_1 */
> > +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192);
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4),
> > +                                      TYPE_PCA9548, 0x77);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> > "max34451", 0x59);
> > +    /* mobo_fru_2 */
> > +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 2), 0x55, 32768);
> > +
> > +    /* pca6416@0x20 */
> > +    /* pca6416@0x20 */
> > +
> > +    /* pdb_fru */
> > +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 6), 0x55, 8192);
> > +
> > +    /* i2c5 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 5),
> > TYPE_PCA9548,
> > +                                      0x77);
> > +
> > +    /* i2c6 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6),
> > TYPE_PCA9548,
> > +                                      0x77);
> > +
> > +    /* i2c7 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 7),
> > TYPE_PCA9548,
> > +                                      0x77);
> > +
> > +    /* i2c8 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 8),
> > TYPE_PCA9548,
> > +                                      0x77);
> > +
> > +    /* i2c9 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 9),
> > TYPE_PCA9548,
> > +                                      0x77);
> > +
> > +    /* i2c10 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 10),
> > +                                      TYPE_PCA9548, 0x77);
> > +
> > +    /* i2c11 */
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 11),
> > +                                      TYPE_PCA9548, 0x77);
> > +
> > +    /* i2c12 */
> > +
>
> A for () loop to create these devices would be good.
>
> > +    /* i2c13 */
> > +    /* pca9555@22 */
> > +
> > +    /* i2c14 */
> > +    /* LEDs and PE Resets */
> > +    /* pca6416@0x20 */
> > +
> > +    /* bmc_fru_1 */
> > +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192);
> > +
> > +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 14),
> > +                                      TYPE_PCA9548, 0x77);
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> > "max34451", 0x59);
> > +
> > +    /* max31725 is compatible with tmp105 */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105",
> > 0x5c);
> > +
> > +    /* i2c15 */
> > +    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15),
> > TYPE_PCA9546, 0x75);
> > +}
> > +
> >  static void quanta_gbs_i2c_init(NPCM7xxState *soc)
> >  {
> >      /*
> > @@ -392,6 +497,25 @@ static void quanta_gsj_init(MachineState *machine)
> >      npcm7xx_load_kernel(machine, soc);
> >
>

--00000000000097778e0623e8b52e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ack. There are devices that get attached to these muxes. I=
 need to send another revision of the patches in=C2=A0<a href=3D"https://li=
sts.gnu.org/archive/html/qemu-devel/2023-02/msg01514.html">https://lists.gn=
u.org/archive/html/qemu-devel/2023-02/msg01514.html</a>, but for the moment=
. This patch can go in separately from that series.<div><br></div><div>-Tit=
us</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Mon, 7 Oct 2024 at 12:16, Ben Dooks &lt;<a href=3D"mailto:ben.do=
oks@codethink.co.uk">ben.dooks@codethink.co.uk</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2024-10-07 18:17, Titus Rwantare wrote:<br>
&gt; This patch adds the quanta-gsz-bmc target, a current Google machine of=
<br>
&gt; the day. This machine will be used as a platform to enable features <b=
r>
&gt; such<br>
&gt; as the PECI bmc interface, and Intel eSPI virtual wire interface in<br=
>
&gt; QEMU.<br>
&gt; <br>
&gt; Signed-off-by: Titus Rwantare &lt;<a href=3D"mailto:titusr@google.com"=
 target=3D"_blank">titusr@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/npcm7xx_boards.c | 140 ++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 140 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c<br>
&gt; index e229efb447..e1ff5af756 100644<br>
&gt; --- a/hw/arm/npcm7xx_boards.c<br>
&gt; +++ b/hw/arm/npcm7xx_boards.c<br>
&gt; @@ -48,6 +48,8 @@<br>
&gt;=C2=A0 #define NPCM750_EVB_POWER_ON_STRAPS ( \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM7XX_POWER_ON_STRAPS_DEFAULT &amp=
; ~NPCM7XX_PWRON_STRAP_J2EN)<br>
&gt;=C2=A0 #define QUANTA_GSJ_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAU=
LT<br>
&gt; +#define QUANTA_GSZ_POWER_ON_STRAPS ( \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM7XX_POWER_ON_STRAPS_DEFAULT &amp; ~NP=
CM7XX_PWRON_STRAP_SFAB)<br>
&gt;=C2=A0 #define QUANTA_GBS_POWER_ON_STRAPS ( \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM7XX_POWER_ON_STRAPS_DEFAULT &amp=
; ~NPCM7XX_PWRON_STRAP_SFAB)<br>
&gt;=C2=A0 #define KUDO_BMC_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT=
<br>
&gt; @@ -269,6 +271,109 @@ static void quanta_gsj_fan_init(NPCM7xxMachine <=
br>
&gt; *machine, NPCM7xxState *soc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 npcm7xx_connect_pwm_fan(soc, &amp;splitter[2], 0x0=
5, 1);<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; +static void quanta_gsz_i2c_init(NPCM7xxState *soc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 I2CSlave *i2c_mux;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c1 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 1), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75);<br>
&gt; +=C2=A0 =C2=A0 /* pca6416@0x20 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PCA954=
8, 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0)=
, <br>
&gt; &quot;raa229004&quot;, 0x72);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1)=
, <br>
&gt; &quot;raa229004&quot;, 0x72);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2)=
, <br>
&gt; &quot;isl69260&quot;, 0x72);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3)=
, <br>
&gt; &quot;isl69260&quot;, 0x72);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4)=
, <br>
&gt; &quot;isl69260&quot;, 0x72);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5)=
, <br>
&gt; &quot;isl69260&quot;, 0x72);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6)=
, <br>
&gt; &quot;adm1272&quot;, 0x1f);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c2 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PCA954=
8, 0x77);<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- channel 0: tps546=
d24 @25<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- channel 1: d=
elta,dps800 @69<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1)=
, <br>
&gt; &quot;raa228000&quot;, 0x68);<br>
&gt; +=C2=A0 =C2=A0 /*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - channel 2: delta=
,dps800 @68 */<br>
&gt; +=C2=A0 =C2=A0 /* max31725 is compatible with tmp105. */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4)=
, &quot;tmp105&quot;, <br>
&gt; 0x5c);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5)=
, &quot;tmp105&quot;, <br>
&gt; 0x5c);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6)=
, &quot;tmp105&quot;, <br>
&gt; 0x5c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c3 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 3), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c4 */<br>
&gt; +=C2=A0 =C2=A0 /* mobo_fru_1 */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 81=
92);<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PCA954=
8, 0x77);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0)=
, <br>
&gt; &quot;max34451&quot;, 0x59);<br>
&gt; +=C2=A0 =C2=A0 /* mobo_fru_2 */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 2), 0x55, 32=
768);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* pca6416@0x20 */<br>
&gt; +=C2=A0 =C2=A0 /* pca6416@0x20 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* pdb_fru */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 6), 0x55, 81=
92);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c5 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 5), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c6 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 6), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c7 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 7), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c8 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 8), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c9 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 9), <br>
&gt; TYPE_PCA9548,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c10 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 10),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PCA954=
8, 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c11 */<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 11),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PCA954=
8, 0x77);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c12 */<br>
&gt; +<br>
<br>
A for () loop to create these devices would be good.<br>
<br>
&gt; +=C2=A0 =C2=A0 /* i2c13 */<br>
&gt; +=C2=A0 =C2=A0 /* pca9555@22 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c14 */<br>
&gt; +=C2=A0 =C2=A0 /* LEDs and PE Resets */<br>
&gt; +=C2=A0 =C2=A0 /* pca6416@0x20 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* bmc_fru_1 */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8=
192);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus=
(soc, 14),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_PCA954=
8, 0x77);<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0)=
, <br>
&gt; &quot;max34451&quot;, 0x59);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* max31725 is compatible with tmp105 */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4)=
, &quot;tmp105&quot;, <br>
&gt; 0x5c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* i2c15 */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), <=
br>
&gt; TYPE_PCA9546, 0x75);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void quanta_gbs_i2c_init(NPCM7xxState *soc)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; @@ -392,6 +497,25 @@ static void quanta_gsj_init(MachineState *machine=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 npcm7xx_load_kernel(machine, soc);<br>
&gt; <br>
</blockquote></div>

--00000000000097778e0623e8b52e--

