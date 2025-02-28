Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0E5C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4vX-0002A5-MO; Fri, 28 Feb 2025 13:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1to4vV-00029N-LL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1to4vR-000466-T8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740766648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwEj7OA8uKCI9OD9MCZN+sxg7WmGy8/DZWkD0yfHP84=;
 b=Qgjefh40Ter5NzAduzKqXUhmMdjgfD2m7FHcai3kifk4DGLoCInq7NnkeX5P80H0Nf5R0B
 LIk2szW+fKkr6tZZ396d9S6g6m7R9f8FGOMmBXGCjUppZ35cyn++ebil92xdQn17ryaeKc
 oVNKQEWMZSDDhosw5UHLaXw160vdtKc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ey08ruMbP8KA4qCXSa6Seg-1; Fri, 28 Feb 2025 13:17:26 -0500
X-MC-Unique: ey08ruMbP8KA4qCXSa6Seg-1
X-Mimecast-MFC-AGG-ID: ey08ruMbP8KA4qCXSa6Seg_1740766645
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab77dd2c243so480765766b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 10:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740766645; x=1741371445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwEj7OA8uKCI9OD9MCZN+sxg7WmGy8/DZWkD0yfHP84=;
 b=NSG1ae1O18jnf9cgIqXaVQof5ElP1xOtAuCqbp/m30QmJ4bhPHXoTek/0ylX/aWlI4
 i98pj8tF0rzFTYVT5sEz9jkgC8Zyr2EkTPR8Zj1w66vbJsmt1HTiPtGYPyrA/JY90Z+U
 Ikefw+tZ5vfM0n38uti5fsAmh/u8OX9VWOThdDtLN6h1VJIlBqPD64FRYvt+v/f+wiGA
 JIXDV2nQiRS11qTqGYMrgOmdoxpyWx7Ob1/ZCbDvn8Vy2vs368t4DTfYLkjrwFDBE0jv
 Ij2yTQEvIgL9a473u6kzcxGKiwxCWXGXBQyRNsJX8JlVc/5eJVPm7ttaPII9QGjhMIde
 ALeg==
X-Gm-Message-State: AOJu0YxwCAIZTqo2N9pC5+113XJ1Wku6urpyPzACYkEjQD7tCE32iWmf
 xsBP9t7MdCw2UfhG9nMAU+QwN4L3mnSGig6B4fhW+rPO8wCcoxM3J/gf/WiOBuR3SLd8aCr/YoD
 EIvnaIymgjeFP/KQcIatRISELoIViMUcXs+o2oP2CqhzDEFoVnuv3bsfXHZCrx5X6053ely/IJ0
 S9T0jBMGqHO2qmvf/XMN5/uRRJoS4=
X-Gm-Gg: ASbGncsXz/lARn0foj6C2BrN97UjeXvqsuAZ7XBTW7OHazmlZwGKw8r6Xp/Yca0pnbK
 pwV2DY2svPbcRi3AGEn2OgztrQ4rLPVSwjQfOFY5lo6J6/HfV7LeL0SnGWilNQkPrvnA/JYddoQ
 ==
X-Received: by 2002:a17:907:972a:b0:ab7:d454:11c9 with SMTP id
 a640c23a62f3a-abf25f9fdddmr507087766b.8.1740766644700; 
 Fri, 28 Feb 2025 10:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzW3InghKrlTvRJnWPdz0wUG8Ngecw6+CT8byR+xQyn7Z6JgmFXVZX0Z0pAwmllcD7uL+a+kjnBTPU1Fg9Y4=
X-Received: by 2002:a17:907:972a:b0:ab7:d454:11c9 with SMTP id
 a640c23a62f3a-abf25f9fdddmr507085166b.8.1740766644373; Fri, 28 Feb 2025
 10:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20250228170434.317306-1-anisinha@redhat.com>
In-Reply-To: <20250228170434.317306-1-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 28 Feb 2025 23:47:13 +0530
X-Gm-Features: AQ5f1JqfJJRICAbHZ5WgglvoUb-Krhgjyiuv5fAbQNbss4MQJUSzekvnWoYpf9A
Message-ID: <CAK3XEhOXBqqdo5XiW1KJe0Y1HN7F9EOTR668S0t-oCMXZ2Gunw@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/ovmf: check if ovmf is supported before calling
 ovmf parsing code
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 28, 2025 at 10:34=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> Currently call to x86_firmware_configure() -> pc_system_parse_ovmf_flash(=
)
> happens only when SEV is enabled. Fortunately, X86_FW_OVMF is turned on
> automatically when SEV is enabled and therefore,  we never end up calling
> pc_system_parse_ovmf_flash() when X86_FW_OVMF is turned off. In future,
> it is possible that users call x86_firmware_configure() or
> x86_firmware_reconfigure() without checking if SEV is enabled. Therefore,
> x86_firmware_configure() or x86_firmware_reconfigure() need to check if
> ovmf is supported before calling ovmf parsing code. Hence, this change
> introduces an api ovmf_supported() that returns true wnen ovmf is enabled
> and false otherwise. Ovmf parsing code is only called after checking if o=
vmf
> is supported.

This patch passes the CI pipeline.
https://gitlab.com/anisinha/qemu/-/pipelines/1693838556
on branch
https://gitlab.com/anisinha/qemu/-/commits/fuki-hyperface

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc_sysfw.c            | 18 +++++++++++-------
>  hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
>  hw/i386/pc_sysfw_ovmf.c       |  5 +++++
>  include/hw/i386/pc.h          |  1 +
>  4 files changed, 22 insertions(+), 7 deletions(-)
>
> This patch is built on top of
> https://mail.gnu.org/archive/html/qemu-devel/2025-02/msg06005.html
>
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index a9943d95c8..725d142606 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -278,17 +278,21 @@ static void x86_firmware_configure_sev(hwaddr gpa, =
void *ptr, int size)
>
>  void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
>  {
> -    /*
> -     * OVMF places a GUIDed structures in the flash, so
> -     * search for them
> -     */
> -    pc_system_parse_ovmf_flash(ptr, size);
> +    if (ovmf_supported()) {
> +        /*
> +         * OVMF places a GUIDed structures in the flash, so
> +         * search for them
> +         */
> +        pc_system_parse_ovmf_flash(ptr, size);
> +    }
>      x86_firmware_configure_sev(gpa, ptr, size);
>  }
>
>  void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size)
>  {
> -    invalidate_ovmf_parsed_metadata();
> -    pc_system_parse_ovmf_flash(ptr, size);
> +    if (ovmf_supported()) {
> +        invalidate_ovmf_parsed_metadata();
> +        pc_system_parse_ovmf_flash(ptr, size);
> +    }
>      x86_firmware_configure_sev(gpa, ptr, size);
>  }
> diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.=
c
> index edf890a525..08ec18b9b7 100644
> --- a/hw/i386/pc_sysfw_ovmf-stubs.c
> +++ b/hw/i386/pc_sysfw_ovmf-stubs.c
> @@ -15,6 +15,11 @@
>  #include "qemu/osdep.h"
>  #include "hw/i386/pc.h"
>
> +bool ovmf_supported(void)
> +{
> +    return false;
> +}
> +
>  bool pc_system_ovmf_table_find(const char *entry, uint8_t **data, int *d=
ata_len)
>  {
>      g_assert_not_reached();
> diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
> index 3244c17a7d..e6497fd7a7 100644
> --- a/hw/i386/pc_sysfw_ovmf.c
> +++ b/hw/i386/pc_sysfw_ovmf.c
> @@ -36,6 +36,11 @@ static bool ovmf_flash_parsed;
>  static uint8_t *ovmf_table;
>  static int ovmf_table_len;
>
> +bool ovmf_supported(void)
> +{
> +    return true;
> +}
> +
>  void invalidate_ovmf_parsed_metadata(void)
>  {
>      ovmf_flash_parsed =3D false;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 7b0d0c54f5..2e41ca8b05 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -212,6 +212,7 @@ bool pc_system_ovmf_table_find(const char *entry, uin=
t8_t **data,
>                                 int *data_len);
>  void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>  void invalidate_ovmf_parsed_metadata(void);
> +bool ovmf_supported(void);
>
>  /* sgx.c */
>  void pc_machine_init_sgx_epc(PCMachineState *pcms);
> --
> 2.42.0
>


