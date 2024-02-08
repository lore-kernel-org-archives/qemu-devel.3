Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB19AC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 08:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXzW4-0002GJ-W1; Thu, 08 Feb 2024 03:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXzW0-0002G4-2T
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXzVx-0004ES-EM
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707379928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhJlRuNB/MMqlVQ7nQKreU65PO6Xb60C+ZM1hqnrIMA=;
 b=XkzJ6pTc1sEVvbSMObcE8nUD1ef0PswskzcrUXaUKlNHrPMVWvd7Z970BjClcmfscPplNL
 qeizjE256X4E1ptiveqRw0PkJz/osm91CgZaFcgOwEdll0PbXBxH68nOwppMTdnLe8/htu
 QNjXKDNFgu/O5CWT0yuLkUikP7KYyvc=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-IFG5BBR4M0ycB_wQQl5nyA-1; Thu, 08 Feb 2024 03:12:05 -0500
X-MC-Unique: IFG5BBR4M0ycB_wQQl5nyA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57b8so654933241.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 00:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707379925; x=1707984725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhJlRuNB/MMqlVQ7nQKreU65PO6Xb60C+ZM1hqnrIMA=;
 b=POISCeFP7nEIMbHSLBX6R4W3TglH5ysbaRTgFoP+i8C5u4UxlxM4EH2gmvnZQQ4fii
 WuRwSbMGDcSjC/dUp3g3WTqpG+mS2niiVqy2bDK1oC1lhBHiuSyWCZZJnufAhbtNnWDL
 bX586qGyH8haPJ/Tutu9QKGw66YjTTtDsV04ht0AmRDtXhypzvgH3/2W/84ALx5Agqbi
 rU0QcJat/H2bk2HscwNqL4T3t+3FmLBVHRMMtN3Th9nlSnHP1VARk+V3IEcS9WB5iSeW
 8wb3EewDQRh7Hjeih9SxKzaqmdMtUeOTtGdFkiW63tbd8tchuN2PHDB43QK1k/2QTvGz
 qj9w==
X-Gm-Message-State: AOJu0YzEp4epnzRTbhnOCzSWhyXTCSKHloOoO0YHlVxh91sTAJGevYcH
 5LF1FQIVp9kY4l8JsQd7KRX20rJgvQJfvT/8kXgE9QVDyuom1D2XBFWVhORFW7cqf9L3yIU5Qf7
 C7LmAg9/MxJuz3OqNcmihvopHfArBrXMuVu5DGDCgUcce5IODAF75ys564KTY5kR7sCdj30EDwY
 8XjIzfUdRYcxRqpFHGM1rP3E0IdVw=
X-Received: by 2002:a05:6102:5110:b0:46d:3625:6d67 with SMTP id
 bm16-20020a056102511000b0046d36256d67mr6262483vsb.14.1707379925422; 
 Thu, 08 Feb 2024 00:12:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK8XQJViIIOWkZ5qDewElO6yPvzbLvsc674QjACOiTLZ5I1LjGrJ2/yt6Uzs1u6tXf5XXpBm9B5sjCQ3Fxvoc=
X-Received: by 2002:a05:6102:5110:b0:46d:3625:6d67 with SMTP id
 bm16-20020a056102511000b0046d36256d67mr6262467vsb.14.1707379925188; Thu, 08
 Feb 2024 00:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-4-pbonzini@redhat.com>
 <078c8c89-f468-43d1-9ca6-4c485f09c9ba@linaro.org>
In-Reply-To: <078c8c89-f468-43d1-9ca6-4c485f09c9ba@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 09:11:52 +0100
Message-ID: <CABgObfb+EdNzqqDiAtzf5B9YPhe+p1cf94KKzCd2fgLCKFAbmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] hw/mips/Kconfig: Remove ISA dependencies from
 MIPSsim board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, shentey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 7, 2024 at 7:58=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> > @@ -6,8 +6,7 @@ config MALTA
> >
> >   config MIPSSIM
> >       bool
> > -    select ISA_BUS
> > -    select SERIAL_ISA
> > +    select SERIAL
>
> Hmm there is an ISA bus which can be exposed with:
>
> -- >8 --
> diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
> index 16af31648e..a1a4688861 100644
> --- a/hw/mips/mipssim.c
> +++ b/hw/mips/mipssim.c
> @@ -209,8 +209,9 @@ mips_mipssim_init(MachineState *machine)
>       /* Register 64 KB of ISA IO space at 0x1fd00000. */
>       memory_region_init_alias(isa, NULL, "isa_mmio",
>                                get_system_io(), 0, 0x00010000);
>       memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
> +    isa_bus_new(NULL, get_system_memory(), get_system_io(), &error_abort=
);

Quoting you from
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg08752.html,
"there is an ISA MMIO space mapped at 0x1fd00000, however this is not
a real ISA bus (no ISA IRQ)".

If mipssim cannot support "-device isa-serial" as a replacement for
"-serial", there's no reason for it to expose the bus. In the end,
-device support is the main thing that an ISA bus provides over
sysbus, and if it cannot work due to the missing interrupts, I think
this patch is correct.

I can add a comment:

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 01e323904d9..47b37b454e7 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -204,7 +204,11 @@ mips_mipssim_init(MachineState *machine)
     cpu_mips_irq_init_cpu(cpu);
     cpu_mips_clock_init(cpu);

-    /* Register 64 KB of ISA IO space at 0x1fd00000. */
+    /*
+     * Register 64 KB of ISA IO space at 0x1fd00000.  But without interrup=
ts
+     * (except for the hardcoded serial port interrupt) -device cannot wor=
k,
+     * so do not expose the ISA bus to the user.
+     */
     memory_region_init_alias(isa, NULL, "isa_mmio",
                              get_system_io(), 0, 0x00010000);
     memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);

Paolo

>       /*
>        * A single 16450 sits at offset 0x3f8. It is attached to
>        * MIPS CPU INT2, which is interrupt 4.
> ---
>


