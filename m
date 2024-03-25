Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E288C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romkM-000379-J1; Mon, 25 Mar 2024 12:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1romkL-00036P-CC
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1romkJ-0005fH-MK
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711382422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4letdqinZvN99CL2TEUtT5XNPzr7JXOoEpfS/heBK4=;
 b=bL8cLmQR7YZjDP2ZUoASWiCVz4wxjm02Hf5f1E0MGCbQ6zz9Guoj+vZFzdQv1tjBSir6a1
 uxBZVj6rkPtVL7b4H3yuKBqWBV16OkQzSA5cp9RkgymT78gySz9nlQmnF/vKmN5J6FtJ1a
 PkHzLJL2v+/28aVlDxBtprhgu5jCOgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-5ONfyJ2qPayJOKq4K1XSxw-1; Mon, 25 Mar 2024 12:00:20 -0400
X-MC-Unique: 5ONfyJ2qPayJOKq4K1XSxw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4148c5f08d3so1204415e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 09:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711382419; x=1711987219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4letdqinZvN99CL2TEUtT5XNPzr7JXOoEpfS/heBK4=;
 b=Wx+VmZwWGjoq56O6hs8c0WI8Yaj3vAoeFZfaixXETAQwJkei8306LRU5ZrriOasW9a
 JfoN3eZ9I8K592R7vUA8Nd8JakschWH58KM2i9WZgufVcZ7lbg/iLO1FguPqbNhP9MAn
 GidNHKWcNPP/Re2+hwUZVikd2RvgGL3yEE8pHo9tgWkZWctM7DdnXEVGPkoOuhM+JBgt
 gs1Qpw1ag9PUSroYttIMONzmdf8NJppesPKwg3J4ORwFW1fU09cumLqEZfSL7OZMYEBY
 V/Cw2JJhiYAeNLjqdiXR9d/oT9gt5fyRaTxtGVZnqVAv9fw1YFYTQxNXsCfdWorDUlMD
 sL5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLdbnD5oS5Lqlm7wyJ8L826rHmEi/88k1Q/+vNb98LTCn7/SL73INvjxfwbiYbJwSOxug26GmKd5xJJ80EMFuJtPHIvFc=
X-Gm-Message-State: AOJu0YzseWnoxQlPFT1L9vTwepK3exIzPqxarmFBsUUYa5BZqzf9zzaQ
 dMhbPEkGcsPUjZcWc4BR0sdBBvMaDKqekJhoNmjjX/TJJVjIQTRTM50zQ5KzrjPgD9h1QLFP97Z
 hB8ifjmEL2rCSn2kbsZWLRHDOEQSuadu3WWQSzOv4UolmdrOjEwWD
X-Received: by 2002:a05:600c:19d4:b0:414:8a28:6c89 with SMTP id
 u20-20020a05600c19d400b004148a286c89mr1733416wmq.31.1711382419334; 
 Mon, 25 Mar 2024 09:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgwFHt0WDC3tqpFoTCgxB6da/9DbKzFTQpKZ547dHKNVP+pv3bKEHhhlmi1rirCYkQcH3GjA==
X-Received: by 2002:a05:600c:19d4:b0:414:8a28:6c89 with SMTP id
 u20-20020a05600c19d400b004148a286c89mr1733395wmq.31.1711382418990; 
 Mon, 25 Mar 2024 09:00:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h18-20020a5d4312000000b00341bdd87fcasm7669617wrq.103.2024.03.25.09.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 09:00:18 -0700 (PDT)
Date: Mon, 25 Mar 2024 17:00:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios
 build
Message-ID: <20240325170017.5b830e37@imammedo.users.ipa.redhat.com>
In-Reply-To: <ca6b1ae9-14b9-413b-93dc-a28d930b0e3a@linaro.org>
References: <20240325130920.349521-1-mjt@tls.msk.ru>
 <ca6b1ae9-14b9-413b-93dc-a28d930b0e3a@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 25 Mar 2024 14:40:21 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Michael,
>=20
> On 25/3/24 14:09, Michael Tokarev wrote:
> > When building qemu with smbios but not legacy mode (eg minimal microvm =
build),
> > link fails with:
> >=20
> >    hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
> >=20
> > This is because fw_cfg interface can call this function if CONFIG_SMBIOS
> > is defined.  Made this code block to depend on CONFIG_SMBIOS_LEGACY.
> >=20
> > Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machi=
ne"
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > ---
> >   hw/i386/fw_cfg.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > index d802d2787f..d5e78a9183 100644
> > --- a/hw/i386/fw_cfg.c
> > +++ b/hw/i386/fw_cfg.c
> > @@ -70,6 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgS=
tate *fw_cfg,
> >       /* tell smbios about cpuid version and features */
> >       smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1=
_EDX]);
> >  =20
> > +#ifdef CONFIG_SMBIOS_LEGACY
> >       if (pcmc->smbios_legacy_mode) { =20
>=20
> But then having pcmc->smbios_legacy_mode =3D=3D true without
> CONFIG_SMBIOS_LEGACY would be a bug. IMHO what we want is:
>=20
> -- >8 -- =20
> diff --git a/hw/smbios/smbios_legacy_stub.c b/hw/smbios/smbios_legacy_stu=
b.c
> index f29b15316c..7d593dca98 100644
> --- a/hw/smbios/smbios_legacy_stub.c
> +++ b/hw/smbios/smbios_legacy_stub.c
> @@ -13,3 +13,8 @@
>   void smbios_add_usr_blob_size(size_t size)
>   {
>   }
> +
> +uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
> +{
> +    g_assert_not_reached();
> +}

Agreed

Philippe,
shall I post a patch or will you do this?

> ---
>=20
> >           smbios_tables =3D smbios_get_table_legacy(&smbios_tables_len,
> >                                                   &error_fatal);
> > @@ -77,6 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgS=
tate *fw_cfg,
> >                            smbios_tables, smbios_tables_len);
> >           return;
> >       }
> > +#endif
> >  =20
> >       /* build the array of physical mem area from e820 table */
> >       mem_array =3D g_malloc0(sizeof(*mem_array) * e820_get_num_entries=
()); =20
>=20


