Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4517C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJA3n-0006Go-1k; Mon, 17 Jun 2024 06:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJA3l-0006Ed-06
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJA3j-0005ot-0M
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718621878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DeTxpaZPoE5n/6sn1qKBhGwPu3TeW8vls9mSrVjkrM=;
 b=UwHXffR6yInv4WkpHhr4Psb7RmAn/cub+p28ulCU+kg2XtSKEsN1Bs1ZOCngQ/u6sfFWrH
 o+Ev41Sk81ff84TQYV4HXYBjsyeOWwMRcBUMTGQmPcJnr8HXPWwS1Pfjr8/2VpOvMJf1eF
 uy+0F2BFMQxsIUJWbOCHdfB1uGSqbl4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-IFXTmKBiMLqLKuTi3kYQsw-1; Mon, 17 Jun 2024 06:57:56 -0400
X-MC-Unique: IFXTmKBiMLqLKuTi3kYQsw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso30358295e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 03:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718621875; x=1719226675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DeTxpaZPoE5n/6sn1qKBhGwPu3TeW8vls9mSrVjkrM=;
 b=hgh7jV5m5BpTgOeb0DqOReVz7iapk0Dm+vfPdBGjIWlarkcjRK4vyizG2IreLyGd20
 Dq0JKDzFA37mxDpojukDx0G4KxOQBBV3KjZktNbY6VT9w/ve9hRUejcZntwiieu6vjsV
 YjeLBsSlt1G9j3UGOIfunqyy7P8PnZgY9ZSXI4VN+ttMsCmy4a8kmC9MxQnR8UsXxsca
 mK/n03dppfHjuO/XEAG4PLe8RLy939wBHZ5l3htFiqf6gAJyMsOGsNePdLMVsSxzwZ0Q
 nATpd9WTcf4JUzs1bYfdrEXZlKoHGmLyDD2s3i7q++pdmcvtmbzURQv9KVImTOROhrTI
 /vFQ==
X-Gm-Message-State: AOJu0YwITA8zww02XseQ+P3KWh/1yH1vkdeWCYNhXPgvIQ8BI5v8jkV/
 Mrww6XOnV8V/jzaWDXrV2PqXXd+M/PwdkAANlgeJTBLx7Wg0Y8MIV3djN4ZP10HQt3mBdYQ1rz3
 P4wU2RosabdiRlrv6bFFlYH9ROqyW+lDlGfSGmVGwMNCFUlUpdV6T
X-Received: by 2002:a05:600c:4688:b0:422:7c50:18ff with SMTP id
 5b1f17b1804b1-4230485bacdmr69804675e9.39.1718621875266; 
 Mon, 17 Jun 2024 03:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXhP/wXXOEsfzBCh5KspiD6hT4auKqFLZcZLYvwDYQFdXBrhHYoxxZ32/dTcJzneZ7MLP1xg==
X-Received: by 2002:a05:600c:4688:b0:422:7c50:18ff with SMTP id
 5b1f17b1804b1-4230485bacdmr69804535e9.39.1718621874789; 
 Mon, 17 Jun 2024 03:57:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641f522sm153026565e9.48.2024.06.17.03.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 03:57:54 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:57:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v6 21/23] hw/i386/pc: Simplify DEFINE_I440FX_MACHINE()
 macro
Message-ID: <20240617125753.52300d4e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240617071118.60464-22-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
 <20240617071118.60464-22-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 17 Jun 2024 09:11:16 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Last commit removed the last non-NULL use of DEFINE_I440FX_MACHINE
> 3rd parameter. 'compatfn' is now obsolete, remove it.
>=20
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c | 69 ++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 40 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 217c749705..e4930b7f48 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -414,13 +414,6 @@ static void pc_set_south_bridge(Object *obj, int val=
ue, Error **errp)
>      pcms->south_bridge =3D PCSouthBridgeOption_lookup.array[value];
>  }
> =20
> -/* Looking for a pc_compat_2_4() function? It doesn't exist.
> - * pc_compat_*() functions that run on machine-init time and
> - * change global QEMU state are deprecated. Please don't create
> - * one, and implement any pc-*-2.4 (and newer) compat code in
> - * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
> - */
> -
>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {
> @@ -452,13 +445,9 @@ static void pc_xen_hvm_init(MachineState *machine)
>  }
>  #endif
> =20
> -#define DEFINE_I440FX_MACHINE(suffix, name, compatfn, optionfn) \
> +#define DEFINE_I440FX_MACHINE(suffix, name, optionfn) \
>      static void pc_init_##suffix(MachineState *machine) \
>      { \
> -        void (*compat)(MachineState *m) =3D (compatfn); \
> -        if (compat) { \
> -            compat(machine); \
> -        } \
>          pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
>      } \
>      DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
> @@ -496,7 +485,7 @@ static void pc_i440fx_9_1_machine_options(MachineClas=
s *m)
>      m->is_default =3D true;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
> +DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1",
>                        pc_i440fx_9_1_machine_options);
> =20
>  static void pc_i440fx_9_0_machine_options(MachineClass *m)
> @@ -512,7 +501,7 @@ static void pc_i440fx_9_0_machine_options(MachineClas=
s *m)
>      pcmc->isa_bios_alias =3D false;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
> +DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0",
>                        pc_i440fx_9_0_machine_options);
> =20
>  static void pc_i440fx_8_2_machine_options(MachineClass *m)
> @@ -527,7 +516,7 @@ static void pc_i440fx_8_2_machine_options(MachineClas=
s *m)
>      pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_64;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
> +DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2",
>                        pc_i440fx_8_2_machine_options);
> =20
>  static void pc_i440fx_8_1_machine_options(MachineClass *m)
> @@ -541,7 +530,7 @@ static void pc_i440fx_8_1_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
> +DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1",
>                        pc_i440fx_8_1_machine_options);
> =20
>  static void pc_i440fx_8_0_machine_options(MachineClass *m)
> @@ -556,7 +545,7 @@ static void pc_i440fx_8_0_machine_options(MachineClas=
s *m)
>      pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_32;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
> +DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0",
>                        pc_i440fx_8_0_machine_options);
> =20
>  static void pc_i440fx_7_2_machine_options(MachineClass *m)
> @@ -566,7 +555,7 @@ static void pc_i440fx_7_2_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
> +DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2",
>                        pc_i440fx_7_2_machine_options);
> =20
>  static void pc_i440fx_7_1_machine_options(MachineClass *m)
> @@ -576,7 +565,7 @@ static void pc_i440fx_7_1_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1", NULL,
> +DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1",
>                        pc_i440fx_7_1_machine_options);
> =20
>  static void pc_i440fx_7_0_machine_options(MachineClass *m)
> @@ -588,7 +577,7 @@ static void pc_i440fx_7_0_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0", NULL,
> +DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0",
>                        pc_i440fx_7_0_machine_options);
> =20
>  static void pc_i440fx_6_2_machine_options(MachineClass *m)
> @@ -598,7 +587,7 @@ static void pc_i440fx_6_2_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2", NULL,
> +DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2",
>                        pc_i440fx_6_2_machine_options);
> =20
>  static void pc_i440fx_6_1_machine_options(MachineClass *m)
> @@ -609,7 +598,7 @@ static void pc_i440fx_6_1_machine_options(MachineClas=
s *m)
>      m->smp_props.prefer_sockets =3D true;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1", NULL,
> +DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1",
>                        pc_i440fx_6_1_machine_options);
> =20
>  static void pc_i440fx_6_0_machine_options(MachineClass *m)
> @@ -619,7 +608,7 @@ static void pc_i440fx_6_0_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0", NULL,
> +DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0",
>                        pc_i440fx_6_0_machine_options);
> =20
>  static void pc_i440fx_5_2_machine_options(MachineClass *m)
> @@ -629,7 +618,7 @@ static void pc_i440fx_5_2_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
> +DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2",
>                        pc_i440fx_5_2_machine_options);
> =20
>  static void pc_i440fx_5_1_machine_options(MachineClass *m)
> @@ -643,7 +632,7 @@ static void pc_i440fx_5_1_machine_options(MachineClas=
s *m)
>      pcmc->pci_root_uid =3D 1;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
> +DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1",
>                        pc_i440fx_5_1_machine_options);
> =20
>  static void pc_i440fx_5_0_machine_options(MachineClass *m)
> @@ -655,7 +644,7 @@ static void pc_i440fx_5_0_machine_options(MachineClas=
s *m)
>      m->auto_enable_numa_with_memdev =3D false;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
> +DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",
>                        pc_i440fx_5_0_machine_options);
> =20
>  static void pc_i440fx_4_2_machine_options(MachineClass *m)
> @@ -665,7 +654,7 @@ static void pc_i440fx_4_2_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
> +DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2",
>                        pc_i440fx_4_2_machine_options);
> =20
>  static void pc_i440fx_4_1_machine_options(MachineClass *m)
> @@ -675,7 +664,7 @@ static void pc_i440fx_4_1_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
> +DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1",
>                        pc_i440fx_4_1_machine_options);
> =20
>  static void pc_i440fx_4_0_machine_options(MachineClass *m)
> @@ -687,7 +676,7 @@ static void pc_i440fx_4_0_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
> +DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0",
>                        pc_i440fx_4_0_machine_options);
> =20
>  static void pc_i440fx_3_1_machine_options(MachineClass *m)
> @@ -701,7 +690,7 @@ static void pc_i440fx_3_1_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
> +DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1",
>                        pc_i440fx_3_1_machine_options);
> =20
>  static void pc_i440fx_3_0_machine_options(MachineClass *m)
> @@ -711,7 +700,7 @@ static void pc_i440fx_3_0_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> +DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0",
>                        pc_i440fx_3_0_machine_options);
> =20
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
> @@ -722,7 +711,7 @@ static void pc_i440fx_2_12_machine_options(MachineCla=
ss *m)
>      compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len=
);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
> +DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12",
>                        pc_i440fx_2_12_machine_options);
> =20
>  static void pc_i440fx_2_11_machine_options(MachineClass *m)
> @@ -732,7 +721,7 @@ static void pc_i440fx_2_11_machine_options(MachineCla=
ss *m)
>      compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len=
);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
> +DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11",
>                        pc_i440fx_2_11_machine_options);
> =20
>  static void pc_i440fx_2_10_machine_options(MachineClass *m)
> @@ -743,7 +732,7 @@ static void pc_i440fx_2_10_machine_options(MachineCla=
ss *m)
>      m->auto_enable_numa_with_memhp =3D false;
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
> +DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10",
>                        pc_i440fx_2_10_machine_options);
> =20
>  static void pc_i440fx_2_9_machine_options(MachineClass *m)
> @@ -753,7 +742,7 @@ static void pc_i440fx_2_9_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
> +DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9",
>                        pc_i440fx_2_9_machine_options);
> =20
>  static void pc_i440fx_2_8_machine_options(MachineClass *m)
> @@ -763,7 +752,7 @@ static void pc_i440fx_2_8_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
> +DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8",
>                        pc_i440fx_2_8_machine_options);
> =20
>  static void pc_i440fx_2_7_machine_options(MachineClass *m)
> @@ -773,7 +762,7 @@ static void pc_i440fx_2_7_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
> +DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7",
>                        pc_i440fx_2_7_machine_options);
> =20
>  static void pc_i440fx_2_6_machine_options(MachineClass *m)
> @@ -788,7 +777,7 @@ static void pc_i440fx_2_6_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
> +DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6",
>                        pc_i440fx_2_6_machine_options);
> =20
>  static void pc_i440fx_2_5_machine_options(MachineClass *m)
> @@ -802,7 +791,7 @@ static void pc_i440fx_2_5_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
> +DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5",
>                        pc_i440fx_2_5_machine_options);
> =20
>  static void pc_i440fx_2_4_machine_options(MachineClass *m)
> @@ -816,7 +805,7 @@ static void pc_i440fx_2_4_machine_options(MachineClas=
s *m)
>      compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
>  }
> =20
> -DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
> +DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4",
>                        pc_i440fx_2_4_machine_options)
> =20
>  #ifdef CONFIG_ISAPC


