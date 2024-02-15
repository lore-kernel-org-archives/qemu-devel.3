Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C60C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 11:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZg6-0006hF-Pa; Thu, 15 Feb 2024 06:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1raZg5-0006h4-Dw
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 06:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1raZg3-0006Bm-JD
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 06:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707995593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVWp+WAkU+LVUbm9vTy0zQ9CfSWqGozVjRRUSLf0f3M=;
 b=hMNBRnPRo/pALHcy4WWqDyvqx9fX5HfqFE7PJTF+gBvTEdxDQCAupDNeC5kVdod5sZqJ/s
 hEGq3ZUTrk2K2DgISLwZ52BfZWQfpT3SJP5xRgTjWOpXU1K2/p4i7DkTYQ/dMGTYBTbHiS
 UZqruFHRndR37b8pbLzu8tsZhNvCnAc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-1WkPYeTFOoK7Y8AYZbpeEA-1; Thu, 15 Feb 2024 06:13:11 -0500
X-MC-Unique: 1WkPYeTFOoK7Y8AYZbpeEA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5114f2a1e81so654995e87.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 03:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707995590; x=1708600390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVWp+WAkU+LVUbm9vTy0zQ9CfSWqGozVjRRUSLf0f3M=;
 b=sJ07fC8ZMiWor8J+7XB6Cgku1Rz7ypv+0n6whkX4icCJI93sTNyyP4n5lNCO+poWoA
 7ULf4qjMT7l5g5CIKI8tTLI9iTdaELaxrqVwRHG2x9kdonhfo7wahCAOb+h5g8vWtW/Z
 Qy/Cwvnud02/eqOhfZJEIGmtPV6zduZQBvwGxCHpBI/PCY8P2TuXNKJ0jlGRZGbtK+9b
 c5bbmo6eHZ830omKijIWmibIhzQhfvnvalfBhfZfQK/e8mzRhuy4SzYjeHkXAMhyw+Zb
 GOXYtcsCsCCrjNatbUi4mm6Z7vX09QhP7H3A6sis92malaEECn6wJHH3ph5qHGr8xvQb
 2nBg==
X-Gm-Message-State: AOJu0YwF8vw/tbqRN6Zz3GjFqcN1aFrA6FLdxGgE91lcEuAJFbzEN4uB
 zQZGeKGaQ1dg0F5k4OFge8GLycqI2oax6X4oMsCTpzmN2wzafJoCobVNcYZcvq+0ITxxAWQpWg9
 KEgUz1p3aN8zjoObgEds8SGGJ17Vq040YKTZ/PQ6f+sQkCCFeoIyJ7e4JJbI02ZbYvwagBUyXYa
 /cPEfyXnXffimrDUSfv3xC8lUjggs=
X-Received: by 2002:a05:6512:200b:b0:511:878b:806 with SMTP id
 a11-20020a056512200b00b00511878b0806mr914713lfb.2.1707995590437; 
 Thu, 15 Feb 2024 03:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhLJgJ4Kg3DHDMIQJfc/gXEPbTsGAXHQJfwJhmIPLmwYdvCb3lLQvGfSDdpQ3Mc7HNGzfLdebO+CRJNW5jddw=
X-Received: by 2002:a05:6512:200b:b0:511:878b:806 with SMTP id
 a11-20020a056512200b00b00511878b0806mr914702lfb.2.1707995590033; Thu, 15 Feb
 2024 03:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-9-pbonzini@redhat.com>
 <47a999a8-a0e0-4995-8f8c-8d18f564c30b@linaro.org>
In-Reply-To: <47a999a8-a0e0-4995-8f8c-8d18f564c30b@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Feb 2024 12:12:57 +0100
Message-ID: <CABgObfYbQ+MX88uYbzTw9GPvwva3mFgDMYBFUtc7OiHMZHFyAg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] mips/loongson3_virt: do not require CONFIG_USB
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, shentey@gmail.com, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
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

On Thu, Feb 15, 2024 at 8:55=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> >       if (defaults_enabled() && object_class_by_name("pci-ohci")) {
> >           pci_create_simple(pci_bus, -1, "pci-ohci");
> > -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> > +        Object *usb_bus =3D object_resolve_path_type("", TYPE_USB_BUS,=
 NULL);
> > +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> > +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
> >       }
> >
> >       pci_init_nic_devices(pci_bus, mc->default_nic);
>
> Can we remove usb_bus_find() completely instead?

s/instead/in fact/

Yes, we can, but this would be just one patch in that series...

Paolo

> $ git grep -w usb_bus_find
> hw/hppa/machine.c:401:        usb_create_simple(usb_bus_find(-1),
> "usb-kbd");
> hw/hppa/machine.c:402:        usb_create_simple(usb_bus_find(-1),
> "usb-mouse");
> hw/mips/loongson3_virt.c:450:        usb_create_simple(usb_bus_find(-1),
> "usb-kbd");
> hw/mips/loongson3_virt.c:451:        usb_create_simple(usb_bus_find(-1),
> "usb-tablet");
> hw/ppc/mac_newworld.c:434:            USBBus *usb_bus =3D usb_bus_find(-1=
);
> hw/ppc/sam460ex.c:423:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> hw/ppc/sam460ex.c:424:    usb_create_simple(usb_bus_find(-1), "usb-mouse"=
);
> hw/ppc/spapr.c:3027:            USBBus *usb_bus =3D usb_bus_find(-1);
> hw/sh4/r2d.c:315:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> hw/usb/bus.c:103:USBBus *usb_bus_find(int busnr)
> hw/usb/bus.c:669:    USBBus *bus =3D usb_bus_find(-1 /* any */);
> include/hw/usb.h:500:USBBus *usb_bus_find(int busnr);


