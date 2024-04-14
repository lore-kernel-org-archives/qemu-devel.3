Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638E4C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 19:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw5f4-0000mI-QY; Sun, 14 Apr 2024 15:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <giacomo.parmeggiani@gmail.com>)
 id 1rw5f2-0000lr-Up; Sun, 14 Apr 2024 15:37:08 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <giacomo.parmeggiani@gmail.com>)
 id 1rw5ez-0001TO-Ti; Sun, 14 Apr 2024 15:37:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2a3095907ffso1145972a91.0; 
 Sun, 14 Apr 2024 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713123423; x=1713728223; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FuxkjjjCEolnUBjtBcKRGALZMe76TcfbHSx0+qH9yfA=;
 b=QUx4SdYZEp4zi8Q8d1ayJFG1qVfMf+DhcahVqXLmncN3A02m3QRWe220bm9jteAqQu
 TbHW7jbEoiuBW7lS/1wRh5GavYTFHkmYMR2LZiE5aeVJbB6aq4WIH3UqRlhBzWpNG7tX
 J8c5m4lhgAKSIgXb6HYsKF5W5HCmRyMj1YZ9m3e0AaEm7q4wclWMJpGy3n/UhOnGtnEN
 4iz5i5yvWBM0X5WmBISVYu7lbuxBeK+cI+BHWQPSF3sfMAvnEePQj2XmHU/ro+9Ito37
 eRxMz2/BNxM9rLVdcWMYVVJs9CBkWDXO3IU7bn7Vtx8D9hNa6uflZ42O9LxRy4cLUYtq
 Jeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713123423; x=1713728223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FuxkjjjCEolnUBjtBcKRGALZMe76TcfbHSx0+qH9yfA=;
 b=aJ9A1b4ROt3Fz4+ylbfQBu0v7JTdV3ywvYT5lxOUYvjuk2hJoXDzQxZAkA1CV45zXA
 nO/tqQJuuYNhtbRG28J4Cg/tJLxXUXWT7eGMyIdl+vv9ogtSBGh/uTzU11caJu755usT
 i4cQurCIShbf415061IQBycWZuT/7/zH+AZt+mAw53nF95b3goClLilx5XEhVc8Fnkr7
 V9FxylkNIYa/W/sywrNRVQDIi7zSGWEGr8peLBLUjzJCKVN4RtZqHpGZLc6L3GqIo4ep
 jZM/60kdwaxCrjvFOMfkVzmVjaHMjKu9IIrgrkuNYrEv/cl1NozqoTD/S/TJ0Q9l1UR1
 samQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1JdKeAW6NbbyaJjkJ/N0iqh4US7H9eqMFQb7Yn/N4v3+9E/h2aTW80utptvr1Wg2ghXvwMnBgtKgL8t+/id8QULyzQ/k=
X-Gm-Message-State: AOJu0Yxt12pSYKkQk/HbH7DglvY1plm5It1SN+5KtgSB9Et+Er1yuZCj
 xWh5OVxmD+LZFElm05XhyVh9A/iuiumD3r0j1NsDnIyPcto0nKKBw0ePyuHzGQ3gQ5lK0qTvPch
 Ke0wRqNyr91IMfQfly/pvdTKwf7of7Xrt
X-Google-Smtp-Source: AGHT+IHwGmC5CtVh0rdopBMxKPsV7+oGohFaNwtvdx2MpvCboq2xzs8s+ZX4+pTQ+izvDlYn4PJwZt5c7UqvBXvTzYI=
X-Received: by 2002:a17:90b:108c:b0:2a2:5ec9:3754 with SMTP id
 gj12-20020a17090b108c00b002a25ec93754mr5866182pjb.33.1713123423434; Sun, 14
 Apr 2024 12:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240330203520.64892-1-giacomo.parmeggiani@gmail.com>
In-Reply-To: <20240330203520.64892-1-giacomo.parmeggiani@gmail.com>
From: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>
Date: Sun, 14 Apr 2024 21:36:27 +0200
Message-ID: <CAGSiPK8kAxNSVSQ7vA4sBq9W0J=PMLTEoODVwMFjbimkmp=iUg@mail.gmail.com>
Subject: Re: [PATCH] m25p80: Add support for the GD25WQ32E flash
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001c4665061613a148"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=giacomo.parmeggiani@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000001c4665061613a148
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PING

Hi all, could you have a look at this small patch?
See also:
https://patchew.org/QEMU/20240330203520.64892-1-giacomo.parmeggiani@gmail.c=
om/

BR,
Giacomo Parmeggiani

On Sat, Mar 30, 2024 at 9:36=E2=80=AFPM Giacomo Parmeggiani <
giacomo.parmeggiani@gmail.com> wrote:

> This introduces the GigaDevice GD25WQ32E flash, including the SFDP table
>
> Signed-off-by: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>
> ---
>  hw/block/m25p80.c      |  2 ++
>  hw/block/m25p80_sfdp.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  hw/block/m25p80_sfdp.h |  2 ++
>  3 files changed, 44 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8dec134832..6cc05b63e5 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -205,6 +205,8 @@ static const FlashPartInfo known_devices[] =3D {
>      /* GigaDevice */
>      { INFO("gd25q32",     0xc84016,      0,  64 << 10,  64, ER_4K) },
>      { INFO("gd25q64",     0xc84017,      0,  64 << 10, 128, ER_4K) },
> +    { INFO("gd25wq32e",   0xc86516,      0,  64 << 10,  64, ER_4K),
> +      .sfdp_read =3D m25p80_sfdp_gd25wq32e },
>
>      /* Intel/Numonyx -- xxxs33b */
>      { INFO("160s33b",     0x898911,      0,  64 << 10,  32, 0) },
> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
> index 6ee2cfaf11..cb0963328d 100644
> --- a/hw/block/m25p80_sfdp.c
> +++ b/hw/block/m25p80_sfdp.c
> @@ -406,3 +406,43 @@ static const uint8_t sfdp_is25wp256[] =3D {
>      0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>  };
>  define_sfdp_read(is25wp256);
> +
> +/*
> + * GigaDevice
> + */
> +
> +static const uint8_t sfdp_gd25wq32e[] =3D {
> +    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
> +    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
> +    0xc8, 0x00, 0x01, 0x03, 0x90, 0x00, 0x00, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xe5, 0x20, 0xf1, 0xff, 0xff, 0xff, 0xff, 0x01,
> +    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,
> +    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0xff,
> +    0xff, 0xff, 0x00, 0xff, 0x0c, 0x20, 0x0f, 0x52,
> +    0x10, 0xd8, 0x00, 0xff, 0x63, 0x92, 0xfd, 0xfe,
> +    0x83, 0x2f, 0x26, 0x46, 0xec, 0x82, 0x18, 0x44,
> +    0x7a, 0x75, 0x7a, 0x75, 0x04, 0xbd, 0xd5, 0x5c,
> +    0x00, 0x06, 0x64, 0x00, 0x08, 0x10, 0x00, 0x00,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0x00, 0x36, 0x50, 0x16, 0x9e, 0xf9, 0x77, 0x64,
> +    0xfc, 0xcb, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
> +};
> +define_sfdp_read(gd25wq32e);
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> index 1733b56950..7d1f60f2ee 100644
> --- a/hw/block/m25p80_sfdp.h
> +++ b/hw/block/m25p80_sfdp.h
> @@ -29,4 +29,6 @@ uint8_t m25p80_sfdp_w25q01jvq(uint32_t addr);
>
>  uint8_t m25p80_sfdp_is25wp256(uint32_t addr);
>
> +uint8_t m25p80_sfdp_gd25wq32e(uint32_t addr);
> +
>  #endif
> --
> 2.32.1 (Apple Git-133)
>
>

--=20
*Giacomo Parmeggiani*

--0000000000001c4665061613a148
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">PING<div><br></div><div>Hi all, could you have a look at t=
his small patch?</div><div>See also:=C2=A0<a href=3D"https://patchew.org/QE=
MU/20240330203520.64892-1-giacomo.parmeggiani@gmail.com/">https://patchew.o=
rg/QEMU/20240330203520.64892-1-giacomo.parmeggiani@gmail.com/</a></div><div=
><br></div><div>BR,</div><div>Giacomo Parmeggiani</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 30, 2024=
 at 9:36=E2=80=AFPM Giacomo Parmeggiani &lt;<a href=3D"mailto:giacomo.parme=
ggiani@gmail.com">giacomo.parmeggiani@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">This introduces the GigaDevi=
ce GD25WQ32E flash, including the SFDP table<br>
<br>
Signed-off-by: Giacomo Parmeggiani &lt;<a href=3D"mailto:giacomo.parmeggian=
i@gmail.com" target=3D"_blank">giacomo.parmeggiani@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/block/m25p80.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0hw/block/m25p80_sfdp.c | 40 ++++++++++++++++++++++++++++++++++++++++<=
br>
=C2=A0hw/block/m25p80_sfdp.h |=C2=A0 2 ++<br>
=C2=A03 files changed, 44 insertions(+)<br>
<br>
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
index 8dec134832..6cc05b63e5 100644<br>
--- a/hw/block/m25p80.c<br>
+++ b/hw/block/m25p80.c<br>
@@ -205,6 +205,8 @@ static const FlashPartInfo known_devices[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0/* GigaDevice */<br>
=C2=A0 =C2=A0 =C2=A0{ INFO(&quot;gd25q32&quot;,=C2=A0 =C2=A0 =C2=A00xc84016=
,=C2=A0 =C2=A0 =C2=A0 0,=C2=A0 64 &lt;&lt; 10,=C2=A0 64, ER_4K) },<br>
=C2=A0 =C2=A0 =C2=A0{ INFO(&quot;gd25q64&quot;,=C2=A0 =C2=A0 =C2=A00xc84017=
,=C2=A0 =C2=A0 =C2=A0 0,=C2=A0 64 &lt;&lt; 10, 128, ER_4K) },<br>
+=C2=A0 =C2=A0 { INFO(&quot;gd25wq32e&quot;,=C2=A0 =C2=A00xc86516,=C2=A0 =
=C2=A0 =C2=A0 0,=C2=A0 64 &lt;&lt; 10,=C2=A0 64, ER_4K),<br>
+=C2=A0 =C2=A0 =C2=A0 .sfdp_read =3D m25p80_sfdp_gd25wq32e },<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Intel/Numonyx -- xxxs33b */<br>
=C2=A0 =C2=A0 =C2=A0{ INFO(&quot;160s33b&quot;,=C2=A0 =C2=A0 =C2=A00x898911=
,=C2=A0 =C2=A0 =C2=A0 0,=C2=A0 64 &lt;&lt; 10,=C2=A0 32, 0) },<br>
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c<br>
index 6ee2cfaf11..cb0963328d 100644<br>
--- a/hw/block/m25p80_sfdp.c<br>
+++ b/hw/block/m25p80_sfdp.c<br>
@@ -406,3 +406,43 @@ static const uint8_t sfdp_is25wp256[] =3D {<br>
=C2=A0 =C2=A0 =C2=A00xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
=C2=A0};<br>
=C2=A0define_sfdp_read(is25wp256);<br>
+<br>
+/*<br>
+ * GigaDevice<br>
+ */<br>
+<br>
+static const uint8_t sfdp_gd25wq32e[] =3D {<br>
+=C2=A0 =C2=A0 0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,<br>
+=C2=A0 =C2=A0 0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,<br>
+=C2=A0 =C2=A0 0xc8, 0x00, 0x01, 0x03, 0x90, 0x00, 0x00, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xe5, 0x20, 0xf1, 0xff, 0xff, 0xff, 0xff, 0x01,<br>
+=C2=A0 =C2=A0 0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,<br>
+=C2=A0 =C2=A0 0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0x00, 0xff, 0x0c, 0x20, 0x0f, 0x52,<br>
+=C2=A0 =C2=A0 0x10, 0xd8, 0x00, 0xff, 0x63, 0x92, 0xfd, 0xfe,<br>
+=C2=A0 =C2=A0 0x83, 0x2f, 0x26, 0x46, 0xec, 0x82, 0x18, 0x44,<br>
+=C2=A0 =C2=A0 0x7a, 0x75, 0x7a, 0x75, 0x04, 0xbd, 0xd5, 0x5c,<br>
+=C2=A0 =C2=A0 0x00, 0x06, 0x64, 0x00, 0x08, 0x10, 0x00, 0x00,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0x00, 0x36, 0x50, 0x16, 0x9e, 0xf9, 0x77, 0x64,<br>
+=C2=A0 =C2=A0 0xfc, 0xcb, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,<br>
+=C2=A0 =C2=A0 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff<br>
+};<br>
+define_sfdp_read(gd25wq32e);<br>
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h<br>
index 1733b56950..7d1f60f2ee 100644<br>
--- a/hw/block/m25p80_sfdp.h<br>
+++ b/hw/block/m25p80_sfdp.h<br>
@@ -29,4 +29,6 @@ uint8_t m25p80_sfdp_w25q01jvq(uint32_t addr);<br>
<br>
=C2=A0uint8_t m25p80_sfdp_is25wp256(uint32_t addr);<br>
<br>
+uint8_t m25p80_sfdp_gd25wq32e(uint32_t addr);<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.32.1 (Apple Git-133)<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><b>Giacomo Parmeggiani</b><span style=3D"color:rgb(34,34,34)=
"><br></span></div></div>

--0000000000001c4665061613a148--

