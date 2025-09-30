Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 22:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ifI-0000Zp-TN; Tue, 30 Sep 2025 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1v3ifG-0000Y2-Ic
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 18:17:43 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1v3ifB-0001pj-AH
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 18:17:42 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-62faa04afd9so1564a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759270651; x=1759875451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N0PNwjSWW4mY++FnCbbuWlgH6ra9GvXDdDwnj9jSvME=;
 b=RzW+hiT3XqjFt6lDvNcbFmR+dB4pD72rndNxcwAaa8a1XwoJjp6IKE83tMjl6GUcEo
 XIJgzugYzp+YfFLW7pyiA9jJph9ItSImE5yvxsD9yvYtT/YR4BAU2t98qVYmT9fm+d9J
 AIIesn5L4ITcHTKYZVqOACjYPEV+t52La5PukBynt6OQalUiy3EIcPHJk4/8XI9o+6CD
 GvWTGgQqZOhNPXoyBlJmd+NDQaSYpFWUDwC9xSRJjefV+nG6A41JqZIVmlDA+AdQKtnp
 j8T2KR6T8LxmxIu3qUQLAx5DXn55TEOt/BjRpTFi8kjgvlXZPvhHNBeMv2xeE445f3YP
 WJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759270651; x=1759875451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N0PNwjSWW4mY++FnCbbuWlgH6ra9GvXDdDwnj9jSvME=;
 b=oymywCkLnKMUzJVHkKLq4ZVBVM/PP8rdOOaOLkHEFEQaL3CBYpskX/uDaUCyIjxMT1
 7RY83IwUklgpN/yYm4a/ifnPr+roMQal+J2bBT0OjyHa9lUCGMYSBiONdPJ9wWfO3hyP
 Sa+0i1L7fW+Nzu4cXoiuVRBg+4/n2iMgURm2ecJ7Z9BjaR7DB2zKtL6xFGvsIgj96X//
 TPPqqt+d5Bi6Fp2LOnwQYmg9kM8r357xiYd9cfrFscNqAGksqSkDMgIFH/rjUSLCf7+s
 Q/VR42vdiKACRjqlSShGT/H7myRVJfXCfmxU4R6609kb8hDxNlpE7kDSgndlzNTmlFd2
 Kt4w==
X-Gm-Message-State: AOJu0Yyy8HHWjy8B700qLS+GYgod/zGHNBZu9An4pGuFQVWhJEyMozKq
 fO05PKev5n9aeo+bf3qAqO2zAB+SffakmZ2P4B2BWhrac10Bai06CdlS38J2jLKRquJTUqn3hg1
 hfzvFxkg1dHePturrfDmI5AwtnQ3c6Cl3+qdMq2As
X-Gm-Gg: ASbGncs/TsgBHb8mt69osg1o3+7e8jwf58Fabau7hGVWtT7TiJzH44RJx0gQw8h6uZI
 ba+wciSYL3/18vgXNr85ENwzvFr45O0fLCdE/KmpVnobXkvBdwY+R2oROtF7nBG41yRL1SuQd1c
 CG0nSi1Eiz6PFa4fn7dKvqfCB/V6B2zaxe6czGc88TliRncPo5Bv+YOC+ehXLIogUvbRx0QEAxd
 aAQQNyLHrMHJDRIYlRrM+Q28oCy9dc3Ohm1LLLDZVngi0mTJqT7WFkpx930L6HW/k2hCtvnEOZM
 Cm0=
X-Google-Smtp-Source: AGHT+IFN1zh9OMPICqCcTD10Hj0QdS7Sd6pFsMvt5iOG7FKEljkoz7C20dCtWL/dBUxm66aDZ8r2bvXVrRUVgHKMQxI=
X-Received: by 2002:a50:d71d:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-6367a952f6dmr43826a12.0.1759270650469; Tue, 30 Sep 2025
 15:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
 <20250916-quanta-q71l-eeproms-v1-2-3648692cc441@google.com>
 <08b6e571-bf4f-4e51-8a70-8c2c5c675277@kaod.org>
In-Reply-To: <08b6e571-bf4f-4e51-8a70-8c2c5c675277@kaod.org>
From: Yubin Zou <yubinz@google.com>
Date: Tue, 30 Sep 2025 15:17:19 -0700
X-Gm-Features: AS18NWCvjYNl1sDOsXPQKEGx37Wvfq-jCbo3DlCY6NYmLABjPv0DL6Ydj-jbzzA
Message-ID: <CABU_6BJ5zZ2VWHo4pS7r815RtTjdv5iZj=wYbXm5xc=X0+dh9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm: enable eeproms for quanta-q71l
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Patrick Venture <venture@google.com>
Content-Type: multipart/alternative; boundary="0000000000002fe9d106400c1ec0"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=yubinz@google.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--0000000000002fe9d106400c1ec0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I will include the patch containing the utility function of
at24c_eeprom_init_one.

Yubin

On Tue, Sep 16, 2025 at 11:07=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:

> Hi,
>
> On 9/16/25 19:50, Yubin Zou wrote:
> > From: Patrick Venture <venture@google.com>
> >
> > Tested: Quanta-q71l firmware booted to login and was populated via the
> > -drives for the corresponding eeproms.
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   hw/arm/aspeed.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index
> bae59ae7394882e3fc93863049a37ff5a8737ff8..8cef387a0b431576a87355370492088=
6222cca86
> 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -562,16 +562,16 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4f);
> >
> >       /* Baseboard FRU */
> > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
> > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1, 0x54,
> 8192, 0);
>
> Where is at24c_eeprom_init_one() implementation ?
>
>
> Thanks,
>
> C.
>
>
> >       /* Frontpanel FRU */
> > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
> > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1, 0x57,
> 8192, 1);
> >       /* TODO: Add Memory Riser i2c mux and eeproms. */
> >
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9546", 0x74);
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9548", 0x77);
> >
> >       /* Add BIOS FRU */
> > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
> > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 3, 0x56,
> 8192, 2);
> >
> >       /* i2c-7 */
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> "pca9546", 0x70);
> > @@ -581,9 +581,9 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> >       /*        - i2c@3: pmbus@59 */
> >
> >       /* PDB FRU */
> > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
> > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 7, 0x52,
> 8192, 3);
> >       /* BMC FRU */
> > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
> > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 8, 0x50,
> 8192, 4);
> >   }
> >
> >   static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
> >
>
>

--0000000000002fe9d106400c1ec0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, I will include the patch containing the utility funct=
ion of at24c_eeprom_init_one.<br><br>Yubin</div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep=
 16, 2025 at 11:07=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:c=
lg@kaod.org">clg@kaod.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi,<br>
<br>
On 9/16/25 19:50, Yubin Zou wrote:<br>
&gt; From: Patrick Venture &lt;<a href=3D"mailto:venture@google.com" target=
=3D"_blank">venture@google.com</a>&gt;<br>
&gt; <br>
&gt; Tested: Quanta-q71l firmware booted to login and was populated via the=
<br>
&gt; -drives for the corresponding eeproms.<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed.c | 10 +++++-----<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
&gt; index bae59ae7394882e3fc93863049a37ff5a8737ff8..8cef387a0b431576a87355=
3704920886222cca86 100644<br>
&gt; --- a/hw/arm/aspeed.c<br>
&gt; +++ b/hw/arm/aspeed.c<br>
&gt; @@ -562,16 +562,16 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachi=
neState *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 1), &quot;tmp105&quot;, 0x4f);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Baseboard FRU */<br>
&gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
1), 0x54, 8192);<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 1), 1, 0x54, 8192, 0);<br>
<br>
Where is at24c_eeprom_init_one() implementation ?<br>
<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Frontpanel FRU */<br>
&gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
1), 0x57, 8192);<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 1), 1, 0x57, 8192, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: Add Memory Riser i2c mux and eeprom=
s. */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 2), &quot;pca9546&quot;, 0x74);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 2), &quot;pca9548&quot;, 0x77);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add BIOS FRU */<br>
&gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
3), 0x56, 8192);<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 3), 3, 0x56, 8192, 2);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* i2c-7 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 7), &quot;pca9546&quot;, 0x70);<br>
&gt; @@ -581,9 +581,9 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachine=
State *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 - i2c@3: pmbus=
@59 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* PDB FRU */<br>
&gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
7), 0x52, 8192);<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 7), 7, 0x52, 8192, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* BMC FRU */<br>
&gt; -=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
8), 0x50, 8192);<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 8), 8, 0x50, 8192, 4);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void ast2500_evb_i2c_init(AspeedMachineState *bmc)<=
br>
&gt; <br>
<br>
</blockquote></div>

--0000000000002fe9d106400c1ec0--

