Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5B0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKea-0003Ot-Re; Wed, 29 May 2024 10:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKeZ-0003OM-Cy
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKeX-0004zr-Vb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716994305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9cxyQWN/WwcwSYPvl7JbDUAz8QD5m1HmpA4cg2g2IA=;
 b=RoPlBpL7s7zZGyd8CPO7rkZ7/x64Wy1T4nPCgjcOyN6+4JY3DPRfOWmeUod2uSAJTysSSv
 K9OL9nNRnXIuo9hC/bQKttm2pVCVVLqep149uhDjvN1P1SHo3ko64r9PDDV0AZQOXFFDV1
 4MIPh+eTcsg3e0ZxPDngYayfGdKJgtM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-_OFRPsLKMmOSNNJUA9VGiQ-1; Wed, 29 May 2024 10:51:43 -0400
X-MC-Unique: _OFRPsLKMmOSNNJUA9VGiQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4210ea66b7dso14579915e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994302; x=1717599102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9cxyQWN/WwcwSYPvl7JbDUAz8QD5m1HmpA4cg2g2IA=;
 b=djlI7ihNpyeFRpynqCQSdrbjC9YTjhlYi22E2MRnj9yF0NuZt40ZTDfGrabrOAtCm8
 oIHTcUJ0shnerkaSXjJabjp3L9FsY4Mr/uj3Q30ls/GjLfqer9vyte78fL1J+cfXXPOu
 hbrCivoASr5ye9gT0kXciZ4O6jovDpRrZnhNNAfhibL3w1PVUJ7eBJpvqFp+gCDi+2UB
 l13vaBfZji1SOk4GjBwYYvUPcx3GhBxRaBXph+Ypu0SmptlOg1XTNQFx02xs+nU2Gh6K
 iUpjO7WVSBcwYXO+MPfNLNbG8KhqCU75GvVp6BkS5YZ22CFh8+Qi4uhMw3PBs+WcRkc9
 pgTQ==
X-Gm-Message-State: AOJu0YwkURpVFI0om1mQEZX2i2n/K6RW1MxnNyGr3I9G2Rb9ODrP0L37
 wYNOLvgNI1Pq5RqaLkOC6QC9aAk/yMSXwPOv81pHEj7FGIoHWu68K158Krfz214tHCt7UDSwxmW
 D6zPgzftkG/EaQB45T7cL+eSV7BxPVNLeC9l2HAtVEbcgZyh+Eqbu
X-Received: by 2002:a7b:cbd8:0:b0:420:11cd:d302 with SMTP id
 5b1f17b1804b1-421089d7682mr104288575e9.9.1716994302691; 
 Wed, 29 May 2024 07:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyraX3i8axDgzxjFkO7j9BdJjqpPxw8O8iM7u4d9HKxnmRpmYwkUAOdcDFboreifVnz6GTNg==
X-Received: by 2002:a7b:cbd8:0:b0:420:11cd:d302 with SMTP id
 5b1f17b1804b1-421089d7682mr104288395e9.9.1716994302282; 
 Wed, 29 May 2024 07:51:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f598d7sm211495285e9.23.2024.05.29.07.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:51:41 -0700 (PDT)
Date: Wed, 29 May 2024 16:51:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 19/23] hw/i386/acpi: Remove AcpiBuildState::rsdp field
Message-ID: <20240529165141.1945b9df@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-20-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-20-philmd@linaro.org>
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

On Wed, 29 May 2024 07:15:35 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> AcpiBuildState::rsdp is always NULL, remove it,
> simplifying acpi_build_update().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

I'd squash this into previous patch=20

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


