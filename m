Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A58C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXO3L-0005zQ-Pt; Tue, 06 Feb 2024 11:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXO3K-0005z2-KN
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXO3E-0006l4-5E
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707235918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npxBa6VVGsuE3dcMo3QjI4rl/Zf9E+TvxdOKPkaHY+0=;
 b=Z2wUydS4L/A1stqzHfEk+9E/e0cyy5+QPnjLfsLtx6mVS2A936Sq2P8Fkip5fMSwGsTK7A
 oPjfl01pUVWz28pnogOkbkAMUiJhjNSVI5ar/XqQiPdCLy/FBixbdB0GfTlit8ms0sddIL
 7rY3SXfNDnnlP75TALG4pSUAIzfPmxU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-xRljquOmMLSVzKNoQdvlHQ-1; Tue, 06 Feb 2024 11:11:56 -0500
X-MC-Unique: xRljquOmMLSVzKNoQdvlHQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bb9f35fbfcso6636586b6e.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707235916; x=1707840716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npxBa6VVGsuE3dcMo3QjI4rl/Zf9E+TvxdOKPkaHY+0=;
 b=fnzWGGxMvxCw2ZkZVo3V7qE1/9bgKxLIXZMyg34eoYJngg2RN63FMiTwRVriCEhy/j
 VjdnSUlnVNfLy1tJSDogwQDRCvXU+0xgN65QA9gheekK1qqozzB+cvcHS9mFny3Yo0CM
 +q7QYeEVxBrNuLj3okioprErLvk82NhySSD4vN5gsi7Jg3EOUI86Z4xis89sSvZjr4+N
 XK6cRKjGnomKhq15zjmD5ju5oLrpBR8qxk22PgwMmGbcyhZrspw3GZGZ8A6sFVuQLg0B
 kiiSLY91f7et4OxmPoIhFU0qy+OIs7Pm69FMBUiijKwbV6hb0MW+wkkOg3Sw2mYObcyY
 nDjA==
X-Gm-Message-State: AOJu0YzETU7vInkpMbb+SgUpQhe5Wt5xHVy0looQEHeqQe32suldnxV0
 R5/a4QGqYyY5daI/4/bi8hLV1BxQVUecbF5krxTURyVnO9s511HgH5P6m4THk4+PsYDK1yd4qeE
 Brt/RvVMApR3oFH4ePnUBQGaN/TezzfdOkHGswLxzsPM9/gz4P9a3k85nw1UqPmjr+ZwQZHgPXv
 OcRsb/8xI/6id0SsIWv8sVdxsDelQ=
X-Received: by 2002:a05:6808:138d:b0:3be:408d:c3ae with SMTP id
 c13-20020a056808138d00b003be408dc3aemr2804965oiw.21.1707235915306; 
 Tue, 06 Feb 2024 08:11:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRc8xEfoo/zvlY7kUMm7LrvbZsMYMrOkYLp8yyLfb26Svt4gmF9Pqlz7ZH1rJCBjXw4ERLfmjDyuczThb9OAg=
X-Received: by 2002:a05:6808:138d:b0:3be:408d:c3ae with SMTP id
 c13-20020a056808138d00b003be408dc3aemr2804948oiw.21.1707235915059; Tue, 06
 Feb 2024 08:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-3-pbonzini@redhat.com>
 <E227AD11-6FA5-4FB0-9238-86101F71C80D@gmail.com>
In-Reply-To: <E227AD11-6FA5-4FB0-9238-86101F71C80D@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 Feb 2024 17:11:43 +0100
Message-ID: <CABgObfbWJSMkSnQysGTP6s3=wAcAospKNY395n2Tkcxy0d8K=w@mail.gmail.com>
Subject: Re: [PATCH 2/4] isa: extract FDC37M81X to a separate file
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Sun, Feb 4, 2024 at 9:00=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
> >-/* SMS FDC37M817 Super I/O */
> >-static void fdc37m81x_class_init(ObjectClass *klass, void *data)
> >-{
> >-    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
> >-
> >-    sc->serial.count =3D 2; /* NS16C550A */
> >-    sc->parallel.count =3D 1;
> >-    sc->floppy.count =3D 1; /* SMSC 82077AA Compatible */
>
> >-    sc->ide.count =3D 0;
>
> Isn't this assignment redundant?

I think it's there for clarity.

> >+config FDC37M81X
> >+    bool
>
> +    select ISA_SUPERIO
> (in alphabetical order)
>
> >+    select ISA_BUS
>
> Shouldn't it `depend on ISA_BUS`?

It should be there in "config ISA_SUPERIO". That was a mistake in the
original patch that introduced hw/isa/Kconfig. And VT82C686 should
also select ISA_BUS because it's a combined PCI-ISA bridge and SuperIO
chip.

Paolo

> >+    select IDE_ISA
>
> Not needed. This device doesn't have an IDE interface.
>
> Best regards,
> Bernhard
>
> >+
> > config PC87312
> >     bool
> >     select ISA_SUPERIO
> >diff --git a/hw/isa/meson.build b/hw/isa/meson.build
> >index 2ab99ce0c6b..f650b395071 100644
> >--- a/hw/isa/meson.build
> >+++ b/hw/isa/meson.build
> >@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('is=
a-bus.c'))
> > system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c=
'))
> > system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
> > system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
> >+system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-super=
io.c'))
> > system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-super=
io.c'))
> > system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
> >
> >diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> >index ab61af209a0..94b969c21db 100644
> >--- a/hw/mips/Kconfig
> >+++ b/hw/mips/Kconfig
> >@@ -1,7 +1,7 @@
> > config MALTA
> >     bool
> >+    select FDC37M81X
> >     select GT64120
> >-    select ISA_SUPERIO
> >     select PIIX
> >
> > config MIPSSIM
>


