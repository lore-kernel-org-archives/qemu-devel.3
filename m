Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD618C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1R3-00081s-Q7; Wed, 03 Jul 2024 10:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sP1R1-0007wd-T7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sP1R0-0005Si-3I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720018692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGZO5P63jdklO4pDntsmgfZbMJFqdINnByvMGT3F7k4=;
 b=gAo6E6LB3p/RUSy2tE0DZqRZIzy2daXGeEI3F4bCPRJYFZFALQFXUQcGDzJi3Vh1Q3gMeE
 5qd20UignkHCSlftQCRUmGpRhKL2GALbA462iquHhJPGfq7fDuIkx2+0vJ18JHb4ybNgep
 qqx2rdk5x+EZvj6k0S74bCUgM5aRR/U=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-1USNMFJzNMGoXw88lpM4tw-1; Wed, 03 Jul 2024 10:57:04 -0400
X-MC-Unique: 1USNMFJzNMGoXw88lpM4tw-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7f3c9b72aebso590619139f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 07:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720018623; x=1720623423;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGZO5P63jdklO4pDntsmgfZbMJFqdINnByvMGT3F7k4=;
 b=kw/jwfPFdGfTTr0nxOk3/KzoZ3ijiuZv+VpmaiRRvFvCZq0fs35vdmOvQ+In2Goo38
 B0fi/s9QXXEPJo+Do4OM7oOIHiY0qC1nAuSaaU8+iNQ3hFT6kMB2SpL53s1m6KSNzp+j
 dbKOFsdS+C46JSA6ElSXjKT/SdVV2EqofpFwf7lCo7acKOlA39N135/crO8XT0VKb2iR
 R2wcgPcn3EMgSumw4pkReCzNIcfbX/slcgBtes+sExIqBhQ4Ib5qxRZct5S5Y7QyQX+i
 GJek89qUrOHT2FHDhcCjkK9FZc8HxTuBAYllymiCjLXyCRVe5uVRHkZmS+QbHp77sPF8
 1rHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwzJr7GQy81QrPfah7gkHhd76qpBiLEe3ZhITz7D6+Naz/paymkB9jrBTiuTd/3u+Z3C2LKvFCobVkAp4xNP6gkYkxJJ0=
X-Gm-Message-State: AOJu0Ywt2La8TZEaay4ZrHqtb6EJA71deuKVlmMO40e8Gwhll9ZRT8NK
 8Yb7wXpwubqFaND5zYMGZlbw0KSQFQbleZ7AzKBrs8Dc6WS5OcunKdebIC5l/gj/+dke0Bpm3qi
 +cl9ffrUW0+AO+a2gwFIn2UuyKBRHd9SfufGtjgMWuI2reRQUOiot
X-Received: by 2002:a05:6602:2be1:b0:7f6:1b3a:437b with SMTP id
 ca18e2360f4ac-7f62ee79e9emr1377092239f.17.1720018623199; 
 Wed, 03 Jul 2024 07:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyJLBd933nSl/AdFLqYARYHGPdRI3szfYAvMVVHqlMLFaRr4Gju3aXb5DxDM63Ek+XATZ+jA==
X-Received: by 2002:a05:6602:2be1:b0:7f6:1b3a:437b with SMTP id
 ca18e2360f4ac-7f62ee79e9emr1377090539f.17.1720018622928; 
 Wed, 03 Jul 2024 07:57:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4bb742b1acfsm3377238173.123.2024.07.03.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 07:57:02 -0700 (PDT)
Date: Wed, 3 Jul 2024 08:56:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>, Jason Wang
 <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen
 <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v10 11/12] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <20240703085659.36fc5267.alex.williamson@redhat.com>
In-Reply-To: <f056b470-a95c-1696-4276-a60eb92fced0@eik.bme.hu>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-11-7ca0b8ed3d9f@daynix.com>
 <20240702095426-mutt-send-email-mst@kernel.org>
 <57c3c9c1-99c5-1f35-59d4-f913c3dee36b@eik.bme.hu>
 <20240703015747-mutt-send-email-mst@kernel.org>
 <f056b470-a95c-1696-4276-a60eb92fced0@eik.bme.hu>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 3 Jul 2024 13:00:21 +0200 (CEST)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Wed, 3 Jul 2024, Michael S. Tsirkin wrote:
> > On Wed, Jul 03, 2024 at 04:15:23AM +0200, BALATON Zoltan wrote:  
> >> On Tue, 2 Jul 2024, Michael S. Tsirkin wrote:  
> >>> On Thu, Jun 27, 2024 at 03:08:00PM +0900, Akihiko Odaki wrote:  
> >>>> rom_bar is tristate but was defined as uint32_t so convert it into
> >>>> OnOffAuto.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>  
> >>>
> >>> Commit log should explain why this is an improvement,
> >>> not just what's done.
> >>>
> >>>  
> >>>> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> >>>> index e17bb50789ad..35c6c8e28493 100644
> >>>> --- a/docs/igd-assign.txt
> >>>> +++ b/docs/igd-assign.txt
> >>>> @@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
> >>>>        ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
> >>>>        PCI address 1f.0.
> >>>>      * The IGD device must have a VGA ROM, either provided via the romfile
> >>>> -      option or loaded automatically through vfio (standard).  rombar=0
> >>>> +      option or loaded automatically through vfio (standard).  rombar=off
> >>>>        will disable legacy mode support.
> >>>>      * Hotplug of the IGD device is not supported.
> >>>>      * The IGD device must be a SandyBridge or newer model device.  
> >>>
> >>> ...
> >>>  
> >>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> >>>> index 39dae72497e0..0e920ed0691a 100644
> >>>> --- a/hw/vfio/pci-quirks.c
> >>>> +++ b/hw/vfio/pci-quirks.c
> >>>> @@ -33,7 +33,7 @@
> >>>>   * execution as noticed with the BCM 57810 card for lack of a
> >>>>   * more better way to handle such issues.
> >>>>   * The  user can still override by specifying a romfile or
> >>>> - * rombar=1.
> >>>> + * rombar=on.
> >>>>   * Please see https://bugs.launchpad.net/qemu/+bug/1284874
> >>>>   * for an analysis of the 57810 card hang. When adding
> >>>>   * a new vendor id/device id combination below, please also add  
> >>>
> >>>
> >>> So we are apparently breaking a bunch of users who followed
> >>> documentation to the dot. Why is this a good idea?  
> >>
> >> On/off is clearer than 1/0. But isn't 1/0 a synonym for on/off so previous
> >> command lines would still work?
> >>
> >> Regards,
> >> BALATON Zoltan  
> >
> > I see nothing in code that would make it so:
> >
> >
> > const QEnumLookup OnOffAuto_lookup = {
> >    .array = (const char *const[]) {
> >        [ON_OFF_AUTO_AUTO] = "auto",
> >        [ON_OFF_AUTO_ON] = "on",
> >        [ON_OFF_AUTO_OFF] = "off",
> >    },
> >    .size = ON_OFF_AUTO__MAX
> > };
> >
> > I also tried with an existing property:
> >
> > $ ./qemu-system-x86_64 -device intel-hda,msi=0
> > qemu-system-x86_64: -device intel-hda,msi=0: Parameter 'msi' does not accept value '0'  
> 
> Then it was probably bit properties that also accept 0/1, on/off, 
> true/false. Maybe similar aliases could be added to on/off/auto?
> 
> In any case when I first saw rombar I thought it would set the BAR of the 
> ROM so wondered why it's 1 and not 5 or 6 or an offset. So on/off is 
> clearer in this case.

There's only one PCI spec defined offset for the ROM BAR.  Yes, the
option could be more clear but relocating the ROM to a different
regular BAR offset is invalid.  Thanks,

Alex


