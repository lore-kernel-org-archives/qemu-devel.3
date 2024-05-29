Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D1C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKuq-00028T-By; Wed, 29 May 2024 11:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKun-00027w-Pp
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKul-0007jq-BH
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716995310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1P6eVHE1FHzy9GJi73aTdvlYoHD7NSGdZhrEsYJuZ4=;
 b=Fb4jyGnxz28NLGjRi78SQwkmT5/UwUq+uL9lpHjxkMTWh2FtXYmNQHUBW0TM7saNbOy5pZ
 5lhXXm2bifV1tlj0fKA4YCDJKTErmVcF7xqtj+oVpu/4TtDbfKKxHgRUFwyRow44Eg7ym1
 ooQKD8YEdnX9Ts32vgoJPLCwxg5g3Ho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ejK1h3snNraDJZKECXQIpQ-1; Wed, 29 May 2024 11:08:27 -0400
X-MC-Unique: ejK1h3snNraDJZKECXQIpQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4210a9cd834so13487845e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995306; x=1717600106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1P6eVHE1FHzy9GJi73aTdvlYoHD7NSGdZhrEsYJuZ4=;
 b=CKMPglyApl9QMwIWOUCQHwklbya/KpGJjjlI87n6lV8Y6ydLHHxUpI4QymlxBkejka
 2HkNi40pAyTSdbIp50lBTW88WrDM99GOrj448OpVKd6ctnlat9hJHgk9NwigU0vBOKGb
 O3hYLDAkdzNtbrmyk3b7aYEg9Tqv/2eTLLjaLCOlpGsuHdAtoO0qiXwtRLlrMgeKIwEW
 J2suIxp38aVyAltRX/f8nnAWyiXIJ562YW9oNVg8XF+8YrbDEa3/vQEn7yDk2mEgXxSX
 HfKKuHhPjERTi9LSFLgCwBHOtUJZL1SkrLexa9jraMXVeUnLtGVS3cwo4KOSqDr7Zp8s
 xUbA==
X-Gm-Message-State: AOJu0Yx4TcWDFoMjfTeIfiKCyp0Y2qYcpb+Kv4CkTjXAapHP83/34+DW
 mxD8P/Oh8VLyBCz3r1VEPlhj0yvyCu0vHvXFODWa1YBN6U8oJ0ngzN+Stfv2A1IeodCA6UUWibe
 xxv//HP5Pw0wpPxIAQpZ9LebTHVPDpVWGA2UbPBHA6RU9/pWWbD2dNL7jR1GL
X-Received: by 2002:a05:600c:45cd:b0:420:29dd:84db with SMTP id
 5b1f17b1804b1-42108a26c56mr139156665e9.35.1716995305966; 
 Wed, 29 May 2024 08:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmVg9h5dxTMnPdoUyJopysqPaXp8hQ5thwQpIfTVZdRUKsgfmBMUJ6IDicHleuJG/vjc1sHA==
X-Received: by 2002:a05:600c:45cd:b0:420:29dd:84db with SMTP id
 5b1f17b1804b1-42108a26c56mr139156485e9.35.1716995305660; 
 Wed, 29 May 2024 08:08:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210897c5d7sm184438195e9.23.2024.05.29.08.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:08:25 -0700 (PDT)
Date: Wed, 29 May 2024 17:08:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 19/23] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Message-ID: <20240529170824.00392ce7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-20-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-20-philmd@linaro.org>
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

On Wed, 29 May 2024 07:15:35 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> AcpiBuildState::rsdp is always NULL, remove it,
> simplifying acpi_build_update().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ed0adb0e82..6f9925d176 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2459,7 +2459,6 @@ struct AcpiBuildState {
>      MemoryRegion *table_mr;
>      /* Is table patched? */
>      uint8_t patched;
> -    void *rsdp;
>      MemoryRegion *rsdp_mr;
>      MemoryRegion *linker_mr;
>  } AcpiBuildState;
> @@ -2715,11 +2714,7 @@ static void acpi_build_update(void *build_opaque)
> =20
>      acpi_ram_update(build_state->table_mr, tables.table_data);
> =20
> -    if (build_state->rsdp) {
> -        memcpy(build_state->rsdp, tables.rsdp->data, acpi_data_len(table=
s.rsdp));
> -    } else {
> -        acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
> -    }
> +    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
> =20
>      acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
>      acpi_build_tables_cleanup(&tables, true);
> @@ -2805,7 +2800,6 @@ void acpi_setup(void)
>                             tables.vmgenid);
>      }
> =20
> -    build_state->rsdp =3D NULL;
>      build_state->rsdp_mr =3D acpi_add_rom_blob(acpi_build_update,
>                                               build_state, tables.rsdp,
>                                               ACPI_BUILD_RSDP_FILE);


