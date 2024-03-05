Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813BC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTnp-0007YU-Bf; Tue, 05 Mar 2024 07:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhTng-0006aR-35
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhTnc-0004Pd-6M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709641295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuCTE5dR2LeiJCLJ3DPa9+R29o0fzWp8dhviYMi5D68=;
 b=iwGLLzHAt+9vjeGR6mcFynTBfFJS9CvO8txCZVYMjrq1wIiR84mkAWstJMNa3Y1SN7vpUs
 RIG95ff3E4BrJhRKAJmbZravwV8zRocXpeOjb4gxrpTLpdvhl0A470RcUtiWlG7QQLZPKm
 dqFCb1yiE4CWji4JbAAXgZEFMgrGP04=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-W5AFneRNPlKrUnAvb1wEmA-1; Tue, 05 Mar 2024 07:21:33 -0500
X-MC-Unique: W5AFneRNPlKrUnAvb1wEmA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dccd8076b0so65538805ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641292; x=1710246092;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuCTE5dR2LeiJCLJ3DPa9+R29o0fzWp8dhviYMi5D68=;
 b=j5wcr15apW4W/03LD6JX0FbQv9YhC+VxAVj+L8izUCzduJhPtULxEqUGYI2Zy/bEC5
 SIQ1G3GaxR2lOrxQ+gESjZlquBZygJIgBaro2CVgi91PHnm2n+N7qJraqbMncXYw0N8A
 qBybYdvIyuSJZoBrvoX3NvoTjnK6CPwPVm9DYy+ClcUITF8Cz1bP6lk69yCq4JMBWq6d
 MB18SI8kifQAL+mijM+8bLSir8nbhfKcUEHfY/V3TqlMRLbs0neEY6Mc7m9iout1WwiR
 DKC6gheRHB9tl14kwpM2I1o/NXfftPb3Azizg45dijpxq0SYsv6M3JbRw+rQB0bnzDa8
 4C/w==
X-Gm-Message-State: AOJu0YxmwfLEtzCcmIgvXi/LgQgUG1bjHuzhxLeU/W6aeugFMHiKEjnQ
 nThiUOnQrc5d5Knek3IkQ/XhUiE8YtLXzlJgZ1rdIZvVghMMThl21imYj3FCuUq2o2mewATOOAe
 8CPi0q3mQy7BrHfBY9jJQN8JFsIWkK2nrEAPEIb/GH/vuo8EaB92/
X-Received: by 2002:a17:902:ec88:b0:1dd:911:19b1 with SMTP id
 x8-20020a170902ec8800b001dd091119b1mr1886169plg.19.1709641292570; 
 Tue, 05 Mar 2024 04:21:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwPg+Fg0kv7QelL1AmYk/YA0f2QGxYXgrcM5i7ZlC0nAziu7oSs3YcNo+21RMyBCVuwYLTlw==
X-Received: by 2002:a17:902:ec88:b0:1dd:911:19b1 with SMTP id
 x8-20020a170902ec8800b001dd091119b1mr1886153plg.19.1709641292252; 
 Tue, 05 Mar 2024 04:21:32 -0800 (PST)
Received: from smtpclient.apple ([203.163.238.152])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a170902d48700b001db5079b705sm10400830plg.36.2024.03.05.04.21.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Mar 2024 04:21:31 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 18/19] pc/q35: set SMBIOS entry point type to 'auto' by
 default
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240227154749.1818189-19-imammedo@redhat.com>
Date: Tue, 5 Mar 2024 17:51:14 +0530
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
Message-Id: <B21B8627-97D5-4047-97BF-963F3CA57DCA@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-19-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Use smbios-entry-point-type=3D'auto' for newer machine types as a =
workaround
> for Windows not detecting SMBIOS tables. Which makes QEMU pick SMBIOS =
tables
> based on configuration (with 2.x preferred and fallback to 3.x if the =
former
> isn't compatible with configuration)
>=20
> Default compat setting of smbios-entry-point-type after series
> for pc/q35 machines:
>  * 9.0-newer: 'auto'
>  * 8.1-8.2: '64'
>  * 8.0-older: '32'
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2008
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/i386/pc.c      | 2 +-
> hw/i386/pc_piix.c | 4 ++++
> hw/i386/pc_q35.c  | 3 +++
> 3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 56562e7d9e..2f69dfd0a8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1831,7 +1831,7 @@ static void pc_machine_class_init(ObjectClass =
*oc, void *data)
>     mc->nvdimm_supported =3D true;
>     mc->smp_props.dies_supported =3D true;
>     mc->default_ram_id =3D "pc.ram";
> -    pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_64;
> +    pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_AUTO;
>=20
>     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
>         pc_machine_get_max_ram_below_4g, =
pc_machine_set_max_ram_below_4g,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ec7c07b362..f9da942c55 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -535,12 +535,16 @@ DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", =
NULL,
>=20
> static void pc_i440fx_8_2_machine_options(MachineClass *m)
> {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +
>     pc_i440fx_9_0_machine_options(m);
>     m->alias =3D NULL;
>     m->is_default =3D false;
>=20
>     compat_props_add(m->compat_props, hw_compat_8_2, =
hw_compat_8_2_len);
>     compat_props_add(m->compat_props, pc_compat_8_2, =
pc_compat_8_2_len);
> +    /* For pc-i44fx-8.2 and 8.1, use SMBIOS 3.X by default */
> +    pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_64;
> }
>=20
> DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 53fb3db26d..da3f92bea7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -371,10 +371,13 @@ DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
>=20
> static void pc_q35_8_2_machine_options(MachineClass *m)
> {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>     pc_q35_9_0_machine_options(m);
>     m->alias =3D NULL;
>     compat_props_add(m->compat_props, hw_compat_8_2, =
hw_compat_8_2_len);
>     compat_props_add(m->compat_props, pc_compat_8_2, =
pc_compat_8_2_len);
> +    /* For pc-q35-8.2 and 8.1, use SMBIOS 3.X by default */
> +    pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_64;
> }
>=20
> DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
> --=20
> 2.39.3
>=20


