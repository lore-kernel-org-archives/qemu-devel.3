Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FF0C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKE3-0001u1-Qf; Wed, 29 May 2024 10:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKE1-0001rR-1L
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKDy-0000Rh-3B
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716992657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mM/RHyJ3d0Ax7YBhuhwDkeF91rodivdCaH9bhnvYQiA=;
 b=B4wcGm5Ncsgfl52unbYXHJUIv/9ghcSa/sbyTOU3jgqUC+uvY4rrIEYDTbXAtEmWax41a8
 fDg56Tusj6MJI8FZzFBVnNiQDo+YG3uD38/0d8YdFWJOnpsZC6jjNOYPIH+ig77d5cTAbs
 fGdq9msVJ7PKsDfrPgWvNsUsGVgsmLs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-LUsBXDwgNPSah28hwaOs5Q-1; Wed, 29 May 2024 10:24:16 -0400
X-MC-Unique: LUsBXDwgNPSah28hwaOs5Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-354f7a278efso1408959f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716992655; x=1717597455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mM/RHyJ3d0Ax7YBhuhwDkeF91rodivdCaH9bhnvYQiA=;
 b=A2bX9mkqnkNUA/qi3ceVQV4xZfV/nj+aFJlwDWeYflM1fHtAqp7leQgGUTgacsbPMQ
 gFJoMHUfGASkwgHWtLdoHOB+aFzFF2go2fwqaQ8makkyy/7bUe8h/9SMicjgD4R7mg/0
 NeECDP0OfCNoPSx60kXeaGmHpPbozguRg8Y2FBBy4+exbyC+ZqS2ofsZOvcfXUALhkAd
 3KCRnlvrqDn3xshzoi2i0tOojGMOfe+qRQp65nclwAZmKSTHl7dBij5M6mysJ2X9kKc4
 z3+6WBFCw79ARd5arsR4fxCfNsxIZCKWT1Tfwf2C1mfo65fixlv0PT6djI09fxCHUQtz
 helw==
X-Gm-Message-State: AOJu0YxjRIwJuOJd7TOlY9UzZ6WNB8767lO0V1Y2ae0aLE7dJP2uG65d
 1tI9zDot1oARdJlIFEJaju/vN2e8IE+ezYyc+4ET+3BaB60FsYvxzH5gDVGIg9lu4B7gYmABJhQ
 WEOxoD6tgvlP0AJ1bPfj4MlfZmG81mtR28ClqYuiWuf9rPvqRrOY4
X-Received: by 2002:a5d:4f04:0:b0:354:f6ea:3f88 with SMTP id
 ffacd0b85a97d-35526c15563mr10544749f8f.1.1716992654835; 
 Wed, 29 May 2024 07:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaKCrG6COjcuOyJZ3jIJTLuuytKMMmg746yw3TlvpSRJIx7kIcjnLyNuuqox805XhaHmjpDQ==
X-Received: by 2002:a5d:4f04:0:b0:354:f6ea:3f88 with SMTP id
 ffacd0b85a97d-35526c15563mr10544723f8f.1.1716992654333; 
 Wed, 29 May 2024 07:24:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-359bc20cbdbsm7811232f8f.22.2024.05.29.07.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:24:13 -0700 (PDT)
Date: Wed, 29 May 2024 16:24:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 10/23] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Message-ID: <20240529162413.0fc11032@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-11-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-11-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Wed, 29 May 2024 07:15:26 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::smbios_uuid_encoded was only used by the
> pc-i440fx-2.1 machine, which got removed. It is now always
> true, remove it.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h | 1 -
>  hw/i386/fw_cfg.c     | 3 +--
>  hw/i386/pc.c         | 1 -
>  3 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index db0f8e0e36..bbbf58bd42 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -109,7 +109,6 @@ struct PCMachineClass {
>      /* SMBIOS compat: */
>      bool smbios_defaults;
>      bool smbios_legacy_mode;
> -    bool smbios_uuid_encoded;
>      SmbiosEntryPointType default_smbios_ep_type;
> =20
>      /* RAM / address space compat: */
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 6e0d9945d0..f9e8af3bf5 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -63,8 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgSta=
te *fw_cfg,
> =20
>      if (pcmc->smbios_defaults) {
>          /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc, mc->name,
> -                            pcmc->smbios_uuid_encoded);
> +        smbios_set_defaults("QEMU", mc->desc, mc->name, true);
>      }
> =20
>      /* tell smbios about cpuid version and features */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f27c9fd98c..4b2a29bf08 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1790,7 +1790,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->has_acpi_build =3D true;
>      pcmc->rsdp_in_ram =3D true;
>      pcmc->smbios_defaults =3D true;
> -    pcmc->smbios_uuid_encoded =3D true;
>      pcmc->gigabyte_align =3D true;
>      pcmc->has_reserved_memory =3D true;
>      pcmc->enforce_aligned_dimm =3D true;


