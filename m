Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B7FC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 06:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOt39-0002Xk-1D; Wed, 03 Jul 2024 02:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOt33-0002WK-L9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 02:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOt30-00067u-Oq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 02:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719986453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwQOMbsZ6i6K3bEm8jqb/lCzJ6q120Iu0oG3LZwHZXQ=;
 b=Kp8Od6S7JLXO9YR9F4qWqOQyKjbdchXDWJmq8k+0tNNLuFibhBGMDY5d/xjmLBL1sa/oMz
 FhxgYPlhuUAQj7ohq99rueruI0PUcxDnXtUl2mAJyoWSrFvoyKxQpVWT+2fm5l1o6Wngbo
 pgmQntkWAJLBsoeoqyuKBgRumJf1b8M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-74mgyA4mOA6N3ilohFih2Q-1; Wed, 03 Jul 2024 02:00:48 -0400
X-MC-Unique: 74mgyA4mOA6N3ilohFih2Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36794fcfdd6so141753f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 23:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719986447; x=1720591247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwQOMbsZ6i6K3bEm8jqb/lCzJ6q120Iu0oG3LZwHZXQ=;
 b=JFq6uoxkVpFDepTzkcFel42gT3VH4sG7g4pWFnOCu1QWz7MVkpoST6o2kqSHUkmCO6
 dGAegIX4lZ0YXtVJ5CbUK7CYBkqCf6/ZqNkRtI/5o2wNKKDbGXPEmDNGjaTWdYZFzxHQ
 FQ5P4qiqWcDbozlLtBQemI3ZmLKO/leF48KLlQumO9XMsawNnkNDn70IHd1iQV93w1BB
 aSfFT1fJTUyRwzmvxqIHfku4O0NKJ1omZnslQxFsJC2o09hwJWfXpTISbMoUZHFF7Zmw
 6gaapklvEE6ss65ft3rg1kugjdWQMyg3tbIw61wGOO3G55ZRZAAdsN90y1htsS0DtuZu
 ZmNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWspSoz9XFRn1pjQN7oU6sw+oK7P77zdPUWx1zVuKByd8xQrWFWhQM9mKBk5dUyXEJZLjpFfqtafYbZWt2dTbfsYV4Ru8g=
X-Gm-Message-State: AOJu0Yw4nUy4HT2GKJZPKphGWIBbM2b3wH17EaYpgHpgOdzh/TY+rfRs
 WkKbM3OJskcrrdwenFGkwOqFTf+8RrhPh7oxk7xq+r+y4yLUNo9ZNNc8x9Jqq5ooDBbmROSRwbj
 yPUyiw/kBFTuApHBGywOEK8r/ZaxiQBCdrkQBZAW9PvHd2U+J3Cg/
X-Received: by 2002:a05:6000:4013:b0:360:7a1b:62f6 with SMTP id
 ffacd0b85a97d-36775699966mr7761573f8f.5.1719986447659; 
 Tue, 02 Jul 2024 23:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRXDd8Qjh3CzqR7F+XKmp50hB2NP5NckAsyEHI8pySIsmMnpS4s7AWJDqTMDoFVqnJ13RrvA==
X-Received: by 2002:a05:6000:4013:b0:360:7a1b:62f6 with SMTP id
 ffacd0b85a97d-36775699966mr7761530f8f.5.1719986447041; 
 Tue, 02 Jul 2024 23:00:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e0661sm14777914f8f.47.2024.07.02.23.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 23:00:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 02:00:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v10 11/12] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <20240703015747-mutt-send-email-mst@kernel.org>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-11-7ca0b8ed3d9f@daynix.com>
 <20240702095426-mutt-send-email-mst@kernel.org>
 <57c3c9c1-99c5-1f35-59d4-f913c3dee36b@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c3c9c1-99c5-1f35-59d4-f913c3dee36b@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 03, 2024 at 04:15:23AM +0200, BALATON Zoltan wrote:
> On Tue, 2 Jul 2024, Michael S. Tsirkin wrote:
> > On Thu, Jun 27, 2024 at 03:08:00PM +0900, Akihiko Odaki wrote:
> > > rom_bar is tristate but was defined as uint32_t so convert it into
> > > OnOffAuto.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > Commit log should explain why this is an improvement,
> > not just what's done.
> > 
> > 
> > > diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> > > index e17bb50789ad..35c6c8e28493 100644
> > > --- a/docs/igd-assign.txt
> > > +++ b/docs/igd-assign.txt
> > > @@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
> > >        ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
> > >        PCI address 1f.0.
> > >      * The IGD device must have a VGA ROM, either provided via the romfile
> > > -      option or loaded automatically through vfio (standard).  rombar=0
> > > +      option or loaded automatically through vfio (standard).  rombar=off
> > >        will disable legacy mode support.
> > >      * Hotplug of the IGD device is not supported.
> > >      * The IGD device must be a SandyBridge or newer model device.
> > 
> > ...
> > 
> > > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > > index 39dae72497e0..0e920ed0691a 100644
> > > --- a/hw/vfio/pci-quirks.c
> > > +++ b/hw/vfio/pci-quirks.c
> > > @@ -33,7 +33,7 @@
> > >   * execution as noticed with the BCM 57810 card for lack of a
> > >   * more better way to handle such issues.
> > >   * The  user can still override by specifying a romfile or
> > > - * rombar=1.
> > > + * rombar=on.
> > >   * Please see https://bugs.launchpad.net/qemu/+bug/1284874
> > >   * for an analysis of the 57810 card hang. When adding
> > >   * a new vendor id/device id combination below, please also add
> > 
> > 
> > So we are apparently breaking a bunch of users who followed
> > documentation to the dot. Why is this a good idea?
> 
> On/off is clearer than 1/0. But isn't 1/0 a synonym for on/off so previous
> command lines would still work?
> 
> Regards,
> BALATON Zoltan

I see nothing in code that would make it so:


const QEnumLookup OnOffAuto_lookup = {
    .array = (const char *const[]) {
        [ON_OFF_AUTO_AUTO] = "auto",
        [ON_OFF_AUTO_ON] = "on",
        [ON_OFF_AUTO_OFF] = "off",
    },
    .size = ON_OFF_AUTO__MAX
};

I also tried with an existing property:

$ ./qemu-system-x86_64 -device intel-hda,msi=0
qemu-system-x86_64: -device intel-hda,msi=0: Parameter 'msi' does not accept value '0'


-- 
MST


