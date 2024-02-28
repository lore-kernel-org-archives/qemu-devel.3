Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB22C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfI6S-0006St-OR; Wed, 28 Feb 2024 06:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfI6R-0006QE-F6
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rfI6P-0001Gd-L7
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709119675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4R/WMwzgEaVb2wWead6cJP5bUNhcyCGedNVRcbbWic=;
 b=VoUqHYOFU1AvwrXKk3poABkuEgm4RD/KR0EZ8vcAAAwEioU0iPOkkNpd9u+u2PSWXm7tN2
 QnCT+i2cWvxzV7o7JOvI2M1ZkPZK8IqBtBh75vOsQ2GNSJftmuMtkyFFCt61kIf64Ep0iI
 Iq26jEqstFko1goQIJ6r6DLtc41lDnY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-nw-LjfUrOX695GJIBXucCw-1; Wed, 28 Feb 2024 06:27:54 -0500
X-MC-Unique: nw-LjfUrOX695GJIBXucCw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e558491ca6so962776b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709119673; x=1709724473;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4R/WMwzgEaVb2wWead6cJP5bUNhcyCGedNVRcbbWic=;
 b=fMQIjYGy8b6I/PXAtly53mLseOnpgNeF68CvOeMWebyu8z0YBfgNajTqD22T7x6wgg
 x6NXZyETvSPBimOQZnT2E/gNQgbToBd+HsOpTKwlsrex21NCGuErSdOepc+mC5qWj8DD
 QeXhqradGRKTxwDtPEBdybFQBrfWFrdOZ0iS9WCyAEAFNKlff6nsqY/l/1ic8CvYF/H2
 FPgDp0L8zq2+9QBKiZHPhWCW//vIrEUXO7UYvGD7GtGNUU2JXRDKAoMuD9dTjIhHb5uO
 WiC+1i5uYV//Giwwob7svGlmD31X00cK8NAY4/G0pV05dDRkbLWDSqyrwWUzotJGfwWf
 ddVw==
X-Gm-Message-State: AOJu0YzKmeULXygnDL6wVRg5f4uw/GLzq998Y+Z98XfHQYRzjbvpP9aH
 YQ7YsUc0sWnMu29JovV9bV69MeSYqD2J0b23vEP5lw++6f3+6mGPNsiWvch0qBf1u/igkFqrwWo
 eUFW2ns6NS7XdX69gFm/XGbN7VWPu9xVHerflAx7hepzJdpqpirRJ
X-Received: by 2002:a05:6a00:4403:b0:6e5:265:fd31 with SMTP id
 br3-20020a056a00440300b006e50265fd31mr15015556pfb.7.1709119673292; 
 Wed, 28 Feb 2024 03:27:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpVT51NaUTErIo0OqUsCBzaIH7guS+7sJYRcO4y/KvfCLTlQN9nUW2DWzC+LKNXi4VGorC5Q==
X-Received: by 2002:a05:6a00:4403:b0:6e5:265:fd31 with SMTP id
 br3-20020a056a00440300b006e50265fd31mr15015542pfb.7.1709119672994; 
 Wed, 28 Feb 2024 03:27:52 -0800 (PST)
Received: from smtpclient.apple ([115.96.143.215])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a056a00179000b006e57247f4e5sm372024pfg.8.2024.02.28.03.27.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:27:52 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 04/19] smbios: cleanup smbios_get_tables() from legacy
 handling
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-5-imammedo@redhat.com>
Date: Wed, 28 Feb 2024 16:57:34 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <45D1D5DE-6D90-47E2-88CC-1810020B94D0@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-5-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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
> smbios_get_tables() bails out right away if leagacy mode is enabled
> and won't generate any SMBIOS tables. At the same time x86 specific
> fw_cfg_build_smbios() will genarate legacy tables and then proceed
> to preparing temporary mem_array for useless call to
> smbios_get_tables() and then discard it.
>=20
> Drop legacy related check in smbios_get_tables() and return from
> fw_cfg_build_smbios() early if legacy tables where built without
> proceeding to non legacy part of the function.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/i386/fw_cfg.c   | 1 +
> hw/smbios/smbios.c | 6 ------
> 2 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 98a478c276..a635234e68 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -74,6 +74,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, =
FWCfgState *fw_cfg)
>     if (smbios_tables) {
>         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                          smbios_tables, smbios_tables_len);
> +        return;
>     }
>=20
>     /* build the array of physical mem area from e820 table */
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index a3c4e52ce9..8e86c62184 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1106,12 +1106,6 @@ void smbios_get_tables(MachineState *ms,
> {
>     unsigned i, dimm_cnt, offset;
>=20
> -    if (smbios_legacy) {
> -        *tables =3D *anchor =3D NULL;
> -        *tables_len =3D *anchor_len =3D 0;
> -        return;
> -    }
> -
>     if (!smbios_immutable) {
>         smbios_build_type_0_table();
>         smbios_build_type_1_table();
> --=20
> 2.39.3
>=20


