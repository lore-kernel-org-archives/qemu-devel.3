Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9261C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKEu-0003A4-2M; Wed, 29 May 2024 10:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKEs-00039A-9Z
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKEq-0000iT-Jg
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716992711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/A0bLw0dQZCy82eziqf4lwnP9FTduc9V5MirNSMdl7U=;
 b=N9ygdIulZPmkKFLanV/b8WcjXGOHi7KzHNTLSDavv4VaJYcKr6S/1SWkTbaX9HCPTRRKwh
 J1ITDnFMiUzA+mGXhXqblGMNPS5j15pvAofrwFgSrlZUNevX9vdYy+0KsgEMG6XbPlHKaF
 82NpAj/oX3W94wLAv4binlq14y1a1Zs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-NgVUh908PtWW1MsjlfwwHw-1; Wed, 29 May 2024 10:25:09 -0400
X-MC-Unique: NgVUh908PtWW1MsjlfwwHw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35508103145so1729550f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716992708; x=1717597508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/A0bLw0dQZCy82eziqf4lwnP9FTduc9V5MirNSMdl7U=;
 b=HAJBYY8R0+UyUvpzPM5rKR5pC/IvpCFF+2RdaKrYdXUdFqhtj+8GB2l+BtUACgVjbk
 pic5eS+jVYQnW1WQ/qyALnovaARYjyWOinYFJDm5XbYlUw66C52R9DT+suUBtfn45jE6
 CUgGbGyxz+kOw6k382hFvktJjAhT3d9FHbhMC1UYfd66VRGt6ilE9BtwUHVX1yeCvPSE
 aaq1foZMT9a8JoGnft0sRo9M4hzwFIgDY7hs5UJ85ALs/NrWKch8cbbqBj9YV67sAiUN
 KMt1AmhxF0Aml5OS6/SpfEZQIgBz2NVZFOJws6EtMdpbxRYKxd5NYuCcCN2dghib3Z4H
 sZ+w==
X-Gm-Message-State: AOJu0YzRqayrvC4//lE0wM04OZFADk1njG/YrVlBl1t2Qy9DAR/YU/v+
 wqvPAH64vVLkTNhBYmjd7Q4D5UdpB44ZFd2jGmJIc0VH/FrN6f2Hn2PJwO67rN9pXEqgPTlhiZM
 0DJPCnJuiACSIQxdBOUZp0QTX/VwDpszQY/sBqpZHlxeGpyPsJjZY
X-Received: by 2002:a5d:570e:0:b0:35c:5202:face with SMTP id
 ffacd0b85a97d-35c52123e27mr2222086f8f.9.1716992708749; 
 Wed, 29 May 2024 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWBlpvHCtEtNlGXHafgdLVvMefEh5EB22U1C8Zdzg92gMNAEkN37YWDAU3hdM5UFJIdnsKpw==
X-Received: by 2002:a5d:570e:0:b0:35c:5202:face with SMTP id
 ffacd0b85a97d-35c52123e27mr2222069f8f.9.1716992708418; 
 Wed, 29 May 2024 07:25:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0871sm15316180f8f.110.2024.05.29.07.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:25:08 -0700 (PDT)
Date: Wed, 29 May 2024 16:25:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 11/23] hw/smbios: Remove 'uuid_encoded' argument from
 smbios_set_defaults()
Message-ID: <20240529162507.7fee65b0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-12-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-12-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

On Wed, 29 May 2024 07:15:27 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> 'uuid_encoded' is always true, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/firmware/smbios.h | 3 +--
>  hw/arm/virt.c                | 3 +--
>  hw/i386/fw_cfg.c             | 2 +-
>  hw/loongarch/virt.c          | 2 +-
>  hw/riscv/virt.c              | 2 +-
>  hw/smbios/smbios.c           | 6 ++----
>  6 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index 8d3fb2fb3b..f066ab7262 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -331,8 +331,7 @@ void smbios_add_usr_blob_size(size_t size);
>  void smbios_entry_add(QemuOpts *opts, Error **errp);
>  void smbios_set_cpuid(uint32_t version, uint32_t features);
>  void smbios_set_defaults(const char *manufacturer, const char *product,
> -                         const char *version,
> -                         bool uuid_encoded);
> +                         const char *version);
>  void smbios_set_default_processor_family(uint16_t processor_family);
>  uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
>  void smbios_get_tables(MachineState *ms,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c93c0c0a6..268b25e332 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1677,8 +1677,7 @@ static void virt_build_smbios(VirtMachineState *vms)
>      }
> =20
>      smbios_set_defaults("QEMU", product,
> -                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
> -                        true);
> +                        vmc->smbios_old_sys_ver ? "1.0" : mc->name);
> =20
>      /* build the array of physical mem area from base_memmap */
>      mem_array.address =3D vms->memmap[VIRT_MEM].base;
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index f9e8af3bf5..7c43c325ef 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -63,7 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgSta=
te *fw_cfg,
> =20
>      if (pcmc->smbios_defaults) {
>          /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
> +        smbios_set_defaults("QEMU", mc->desc, mc->name);
>      }
> =20
>      /* tell smbios about cpuid version and features */
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 3e6e93edf3..6a12659583 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -529,7 +529,7 @@ static void virt_build_smbios(LoongArchVirtMachineSta=
te *lvms)
>          return;
>      }
> =20
> -    smbios_set_defaults("QEMU", product, mc->name, true);
> +    smbios_set_defaults("QEMU", product, mc->name);
> =20
>      smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
>                        NULL, 0,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb660525..5676d66d12 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1277,7 +1277,7 @@ static void virt_build_smbios(RISCVVirtState *s)
>          product =3D "KVM Virtual Machine";
>      }
> =20
> -    smbios_set_defaults("QEMU", product, mc->name, true);
> +    smbios_set_defaults("QEMU", product, mc->name);
> =20
>      if (riscv_is_32bit(&s->soc[0])) {
>          smbios_set_default_processor_family(0x200);
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index eed5787b15..8261eb716f 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -30,7 +30,7 @@
>  #include "hw/pci/pci_device.h"
>  #include "smbios_build.h"
> =20
> -static bool smbios_uuid_encoded =3D true;
> +static const bool smbios_uuid_encoded =3D true;
>  /*
>   * SMBIOS tables provided by user with '-smbios file=3D<foo>' option
>   */
> @@ -1017,11 +1017,9 @@ void smbios_set_default_processor_family(uint16_t =
processor_family)
>  }
> =20
>  void smbios_set_defaults(const char *manufacturer, const char *product,
> -                         const char *version,
> -                         bool uuid_encoded)
> +                         const char *version)
>  {
>      smbios_have_defaults =3D true;
> -    smbios_uuid_encoded =3D uuid_encoded;
> =20
>      SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
>      SMBIOS_SET_DEFAULT(smbios_type1.product, product);


