Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56418C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhT6j-0000SX-VE; Tue, 05 Mar 2024 06:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhT6i-0000Rt-6K
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhT6d-0002Z1-Rd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709638627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lr9ZwAIZH9USXJUZ1I9mjZLUVZFZB1fODebftbuXqoI=;
 b=RRyl/5b43+96NW6Z5B0WJ5eXskcRsIQkGEWXo6DddatMj/crwrT2RYdm3HWqXPRix1In2H
 nS3WypN5p5eVGEPeu7W60G3VZ/AdeeMTTY3YPfChouqyoJaKsm0YQ88kWiAkhw6iYZQzv4
 /mP2j8msounMdVb+j+GLzKydovjhxw8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-bjhXT27lMC62KbLx4EHWCQ-1; Tue, 05 Mar 2024 06:37:06 -0500
X-MC-Unique: bjhXT27lMC62KbLx4EHWCQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5d1bffa322eso6327001a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709638625; x=1710243425;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lr9ZwAIZH9USXJUZ1I9mjZLUVZFZB1fODebftbuXqoI=;
 b=c1jBQG2B5Lz0wK591NlQOWny9EDz2KzL5ZX8hqCJerKdnjhP6Eh7OKrNyAmEQFB28U
 mueG21QPD2gQvVyuz9wwYlqvcTdk0kuz4wLltT5g3obudHG8G6aSjRGFzcFMjbnU1+Ov
 EeQPK23gbOoKZoJriJtqi5/n5zweifmHTagkAZ2n3oASpxdCYMEyQ8spidxTRLOhO47N
 2j+YDpu2qqIcES9gF3p66ha/TuvmpAwoWkPdL8BQxsLSX+hNRrSdM0MaLAJRrzR1LHPy
 /RA7Rk4kxh3LIZq9UcDVjHpr+h6w0raBH3fLBqjJkZTqMM0Bb6DDiT1K5a4QL2M4sQ54
 Ixxg==
X-Gm-Message-State: AOJu0Yz552/pWKJXPCyRIKRJFY/7e+TnlqVJ0JmMtLyFO7h9s7/kQKyl
 wg9JVLKuW/jEh0XRcBfcvP5K9ItHqTHwUeVwqGmT3o2RsWGX5+IjIxiEX/q8OKg5u9USmHfZ/lT
 HfPHmoenMNLEf4l8cXdrp5Oo3ly3NUoK0dKkc2jR3NTOOo9nI1IYI
X-Received: by 2002:a05:6a20:7289:b0:1a1:20b6:bf11 with SMTP id
 o9-20020a056a20728900b001a120b6bf11mr1597647pzk.50.1709638625353; 
 Tue, 05 Mar 2024 03:37:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLrDzEd7tyhw5iEBmY9Sh5Xobt+xuca6ATpIu5iGB9a+UuNGVvLfY2YAxmx1dF/TYs4Gw+3Q==
X-Received: by 2002:a05:6a20:7289:b0:1a1:20b6:bf11 with SMTP id
 o9-20020a056a20728900b001a120b6bf11mr1597629pzk.50.1709638625027; 
 Tue, 05 Mar 2024 03:37:05 -0800 (PST)
Received: from smtpclient.apple ([203.163.238.152])
 by smtp.gmail.com with ESMTPSA id
 le8-20020a170902fb0800b001dc8db3150asm10357683plb.199.2024.03.05.03.36.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Mar 2024 03:37:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 15/19] smbios: error out when building type 4 table is not
 possible
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-16-imammedo@redhat.com>
Date: Tue, 5 Mar 2024 17:06:46 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, wangyanan55@huawei.com,
 eblake@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC89DC43-048D-4C23-BF18-470BECA3140E@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-16-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> If SMBIOS v2 version is requested but number of cores/threads
> are more than it's possible to describe with v2, error out
> instead of silently ignoring the fact and filling core/thread
> count with bogus values.
>=20
> This will help caller to decide if it should fallback to
> SMBIOSv3 when smbios-entry-point-type=3D'auto'
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/smbios/smbios.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index e54a9f21e6..bf5c7a8885 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -605,7 +605,8 @@ static void smbios_build_type_3_table(void)
> }
>=20
> static void smbios_build_type_4_table(MachineState *ms, unsigned =
instance,
> -                                      SmbiosEntryPointType ep_type)
> +                                      SmbiosEntryPointType ep_type,
> +                                      Error **errp)
> {
>     char sock_str[128];
>     size_t tbl_len =3D SMBIOS_TYPE_4_LEN_V28;
> @@ -659,6 +660,12 @@ static void =
smbios_build_type_4_table(MachineState *ms, unsigned instance,
>     if (tbl_len =3D=3D SMBIOS_TYPE_4_LEN_V30) {
>         t->core_count2 =3D t->core_enabled2 =3D =
cpu_to_le16(cores_per_socket);
>         t->thread_count2 =3D cpu_to_le16(threads_per_socket);
> +    } else if (t->core_count =3D=3D 0xFF || t->thread_count =3D=3D =
0xFF) {
> +        error_setg(errp, "SMBIOS 2.0 doesn't support number of =
processor "
> +                         "cores/threads more than 255, use "
> +                         "-machine smbios-entry-point-type=3D64 =
option to enable "
> +                         "SMBIOS 3.0 support");
> +        return;
>     }
>=20
>     SMBIOS_BUILD_TABLE_POST;
> @@ -987,7 +994,10 @@ static bool smbios_get_tables_ep(MachineState =
*ms,
>     assert(ms->smp.sockets >=3D 1);
>=20
>     for (i =3D 0; i < ms->smp.sockets; i++) {
> -        smbios_build_type_4_table(ms, i, ep_type);
> +        smbios_build_type_4_table(ms, i, ep_type, errp);
> +        if (*errp) {
> +            goto err_exit;
> +        }
>     }
>=20
>     smbios_build_type_8_table();
> --=20
> 2.39.3
>=20


