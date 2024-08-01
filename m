Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2073C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXsG-00070x-W2; Thu, 01 Aug 2024 11:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXsF-0006wZ-Sf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXsE-0003Rb-9h
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722526669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7hjMtH3+eUIvaPbB4wZwLCFHGn9P4tSWi7DELYueQo=;
 b=M6+/wkHyAmDJIvOSBw2TtO3fCPjwBmnx0AE9yMEOyEuEEwjLffECAp51r6evrei/X9//Bc
 KtpMS+Fg2xsgR3rY+lSou40aytuBAq//9O4G+xxEdtpZH/DENRE9no82CM88V2D4SycMZn
 FefAC6tUOXmj9g3BOsM0p76RNc51vkU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-f2ZSSpEaMzaX2gofsu-BrA-1; Thu, 01 Aug 2024 11:37:47 -0400
X-MC-Unique: f2ZSSpEaMzaX2gofsu-BrA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a30be1c5cfso7685666a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722526666; x=1723131466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7hjMtH3+eUIvaPbB4wZwLCFHGn9P4tSWi7DELYueQo=;
 b=G/Nm7qQBfyJBk69JUYOD8VErpDWEuAWCISf9Uvdkg5GS85pLPLJuzKujsilVz3+CTb
 zF0sbPT6oKgOD9gs0YS3Lk1wAxMLNUBEpgv8oLeStS6CdgOrq65hV1qGQZN9VS2VjpGo
 sYdP8exQjHV7pW0nCDmrZ5dEPk4V48IkHRsW3RsLZ5XBoI/Ls0RwENlY9BVKkrLmSXr6
 j/bw3HLdtyB1JWXfTPYpB4aFmYM2p75PqA+V/91RhU6DE/pXxjzsQUdgk3NfX/VwVwbX
 wzL169IFY56LXklaBZM48waG1/utRnz2FpGCT6eGtmy0oRlst83gqKaZsGWJpAwpkc9J
 O6tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXuaHsDPcT1OCJyHUieTYzA0AjbZBeG97OnPo2SIEvd6Gcc/LCafZJIkdbsiXgZS5dUny4bt+JFnxNXE431vHNS13I/Oo=
X-Gm-Message-State: AOJu0Yy+O5NADi1Zd8MDqdzFjtekHoay8sJFRWy0U52B4qY8izTIiIcw
 NxPeptaIQw/hIcclVUtPtcyg+XIpesuWJ62xQhyFbgV4lVAApA58jzQ6L+WDax18JKszK5b0h25
 nn2e0aWKj2T+WoRIBNI1b/HvaKrzNaPTTIwoYVW3R9GhJ7ivfeIkL
X-Received: by 2002:a50:e602:0:b0:5a2:1b9d:1d3d with SMTP id
 4fb4d7f45d1cf-5b7f5414380mr533903a12.29.1722526666471; 
 Thu, 01 Aug 2024 08:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAbcV4GqZAAOktIYfoxBaic4h3JAx7Tr1/929q5DK5lhdX76oYurhiCMoUhtZf0PBCr2sXGw==
X-Received: by 2002:a50:e602:0:b0:5a2:1b9d:1d3d with SMTP id
 4fb4d7f45d1cf-5b7f5414380mr533873a12.29.1722526665720; 
 Thu, 01 Aug 2024 08:37:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3146sm10335180a12.66.2024.08.01.08.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:37:44 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:37:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH-for-9.1 v3 1/2] hw/pci-host/gt64120: Reset config
 registers during RESET phase
Message-ID: <20240801113646-mutt-send-email-mst@kernel.org>
References: <20240801150021.52977-1-philmd@linaro.org>
 <20240801150021.52977-2-philmd@linaro.org>
 <5e765e4d-5314-0737-fccf-635d9365f796@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e765e4d-5314-0737-fccf-635d9365f796@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 05:30:38PM +0200, BALATON Zoltan wrote:
> On Thu, 1 Aug 2024, Philippe Mathieu-Daudé wrote:
> > Reset config values in the device RESET phase, not only once
> > when the device is realized, because otherwise the device can
> > use unknown values at reset.
> > 
> > Mention the datasheet referenced. Remove the "Malta assumptions
> > ahead" comment since the reset values from the datasheet are used.
> > 
> > Reported-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> > hw/pci-host/gt64120.c | 14 +++++++++++---
> > 1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> > index e02efc9e2e..b68d647753 100644
> > --- a/hw/pci-host/gt64120.c
> > +++ b/hw/pci-host/gt64120.c
> > @@ -1,6 +1,8 @@
> > /*
> >  * QEMU GT64120 PCI host
> >  *
> > + * (Datasheet GT-64120 Rev 1.4 from Sep 14, 1999)
> > + *
> >  * Copyright (c) 2006,2007 Aurelien Jarno
> >  *
> >  * Permission is hereby granted, free of charge, to any person obtaining a copy
> > @@ -1211,19 +1213,24 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
> >     empty_slot_init("GT64120", 0, 0x20000000);
> > }
> > 
> > -static void gt64120_pci_realize(PCIDevice *d, Error **errp)
> > +static void gt64120_pci_reset_hold(Object *obj, ResetType type)
> > {
> > -    /* FIXME: Malta specific hw assumptions ahead */
> > +    PCIDevice *d = PCI_DEVICE(obj);
> > +
> > +    /* Values from chapter 17.16 "PCI Configuration" */
> > +
> >     pci_set_word(d->config + PCI_COMMAND, 0);
> >     pci_set_word(d->config + PCI_STATUS,
> >                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
> >     pci_config_set_prog_interface(d->config, 0);
> > +
> >     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
> >     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
> >     pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
> >     pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x1f000000);
> >     pci_set_long(d->config + PCI_BASE_ADDRESS_4, 0x14000000);
> >     pci_set_long(d->config + PCI_BASE_ADDRESS_5, 0x14000001);
> > +
> >     pci_set_byte(d->config + 0x3d, 0x01);
> > }
> > 
> > @@ -1231,8 +1238,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
> > {
> >     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> >     DeviceClass *dc = DEVICE_CLASS(klass);
> > +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> > 
> > -    k->realize = gt64120_pci_realize;
> > +    rc->phases.hold = gt64120_pci_reset_hold;
> 
> Why reset_hold and not a simple reset method which is more usual?

Good point. And I'd keep it limited, e.g. wmask can be set once,
no need to tweak it on reset.

>  If
> there's an explanation maybe it could be mentioned in the commit message.
> Other than that this should work so you can add:
> 
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> if that helps but I don't know much about this chip (even if it's similar to
> mv6436x).
> 
> Regards,
> BALATON Zoltan
> 
> >     k->vendor_id = PCI_VENDOR_ID_MARVELL;
> >     k->device_id = PCI_DEVICE_ID_MARVELL_GT6412X;
> >     k->revision = 0x10;
> > 


