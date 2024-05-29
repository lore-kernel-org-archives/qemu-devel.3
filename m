Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9802C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKuF-0001yg-O1; Wed, 29 May 2024 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKuD-0001yP-QO
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKu5-0007fg-9N
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716995268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aaqf5GspR11DrcD5OjIOYrgamdTsdKcnLzcUYUHAIco=;
 b=CyP1u2b1gsSAovfyreig804e2A+h9gkg+eJEPpDjjTro1HacV/ifn/m9mT27w8GX/VA1E3
 6NZc3Ge4tV/hed/nnStoSDgs2tMqdQFSn0BH27Wb3s1zT0eQQPF9MCeaqLt5r6dzEm4pzi
 NX5qX40G6HD+tAjCbg+w+8nXRGD/LMo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-NkT0yk7cP3qbgWLfE2j2wg-1; Wed, 29 May 2024 11:07:46 -0400
X-MC-Unique: NkT0yk7cP3qbgWLfE2j2wg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35559d30617so1751996f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995265; x=1717600065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aaqf5GspR11DrcD5OjIOYrgamdTsdKcnLzcUYUHAIco=;
 b=OqtJlf2mDS3gBw2mcJa8Vt7Un1B+WX+rSbPWXev/pcNkLoQlyVvoJRqTiCy1NehNXZ
 71qv13ncAC2FPIUSpj+I19wrKY0A70E9v+ZjMzPN5CHSnzYUIVaX2hgxQINbU4Y6owy/
 ni1iFffsvAwWWWA6evAiJTp3IqrfGdOW5NxUvlUfKq3XK4SrvCgMSd3QaBMfmEPvku3E
 qScXchbw5SIxuDs33M1r0zTWWZwKgd6glrUWMUVma1H5otMoDf1TDr+Tfv6+wu4eQbN1
 iNEROCwASM7phPs4ipq3+L1LNSX7XK/4CG00wWU9XDxQ7JgIH5eRgQoXe3ATDB7aeLZL
 Zn9Q==
X-Gm-Message-State: AOJu0YyEe5V2CIzOfaPtP86Q1fIrps8I3bwjr9MPKDMKSu9Q3V7QgQp9
 Kj/870tbEfziJWYOeTEkD4MrxvkpQ2fXIm/usKCKa1S0Z17sgJgLyQLg5stj1RpxufwO4QVvLzV
 3X3u6Q/03FCv0AUB/JslxTG+R2cXIFt5mXGdfCpKU8ZmuSE51ukP4qvXH6PN7
X-Received: by 2002:a05:600c:4f4e:b0:421:1717:2cf0 with SMTP id
 5b1f17b1804b1-42117172daemr81850065e9.24.1716995265084; 
 Wed, 29 May 2024 08:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjuQdMCL/zDt1VJVVHakN0efpqQT5Bc3+NXopeRAJ1T7IcmEiyc/Ffgc/R9QgbBSk/eaRLnA==
X-Received: by 2002:a05:600c:4f4e:b0:421:1717:2cf0 with SMTP id
 5b1f17b1804b1-42117172daemr81849765e9.24.1716995264697; 
 Wed, 29 May 2024 08:07:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f75acesm209926375e9.27.2024.05.29.08.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:07:44 -0700 (PDT)
Date: Wed, 29 May 2024 17:07:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 17/23] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Message-ID: <20240529170743.71727a14@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-18-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-18-philmd@linaro.org>
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

On Wed, 29 May 2024 07:15:33 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> PCMachineClass::resizable_acpi_blob was only used by the
> pc-i440fx-2.2 machine, which got removed. It is now always
> true. Remove it, simplifying acpi_build().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h |  3 ---
>  hw/i386/acpi-build.c | 10 ----------
>  hw/i386/pc.c         |  1 -
>  3 files changed, 14 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 996495985e..808de4eca7 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -125,9 +125,6 @@ struct PCMachineClass {
>      /* create kvmclock device even when KVM PV features are not exposed =
*/
>      bool kvmclock_create_always;
> =20
> -    /* resizable acpi blob compat */
> -    bool resizable_acpi_blob;
> -
>      /*
>       * whether the machine type implements broken 32-bit address space b=
ound
>       * check for memory.
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index a6f8203460..ab2d4d8dcb 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2688,16 +2688,6 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
>       * keep the table size stable for all (max_cpus, max_memory_slots)
>       * combinations.
>       */
> -    /* Make sure we have a buffer in case we need to resize the tables. =
*/
> -    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
> -        !pcmc->resizable_acpi_blob) {
> -        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slot=
s.  */
> -        warn_report("ACPI table size %u exceeds %d bytes,"
> -                    " migration may not work",
> -                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> -        error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                     " or PCI bridges.\n");
> -    }
>      acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> =20
>      acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ccfcb92605..fae21f75aa 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1768,7 +1768,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->acpi_data_size =3D 0x20000 + 0x8000;
>      pcmc->pvh_enabled =3D true;
>      pcmc->kvmclock_create_always =3D true;
> -    pcmc->resizable_acpi_blob =3D true;
>      x86mc->apic_xrupt_override =3D true;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler =3D pc_get_hotplug_handler;


