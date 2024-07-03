Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4106FC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP09c-00013L-7w; Wed, 03 Jul 2024 09:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP09Z-00012Y-Up
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP09X-0006mm-UI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720013767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ET/HPubsYBw0qrRNLucEA2Fv5aHFsqnHwND1e7B0YcE=;
 b=EiMhiFpgcaWeQq/M4UplL1Hftj34wgpVjAWFlvcfTqi6BtpMrE5m6HHxLXkcOaZkKUl13Y
 xqXAt38dJspvr/1EOoCi4yV6GA1vccaBAVCp1YOi3vWvbZE+7VyR/tOYxU6gNgvWS5zBus
 KR3nI+ax1oiqttnu9eBVYRtTLkvOHKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617--AJL8RpaNf6cA1FBuGlIDQ-1; Wed, 03 Jul 2024 09:36:03 -0400
X-MC-Unique: -AJL8RpaNf6cA1FBuGlIDQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3625bef4461so384605f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720013762; x=1720618562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ET/HPubsYBw0qrRNLucEA2Fv5aHFsqnHwND1e7B0YcE=;
 b=PgnaycxnxbEj1bzkub5jVYB+a9KGCw7EbZcViAN8Em7H5yC0GjjjfM7JvUq0ZnUsHr
 eiAh92sOHqHD4vHlBhLn6VRmlxzUBePsFcMJjZIDen753/qWFUxrl4nOsAcb36jHV5C5
 M+IRcNmJLdInMX+ePnPQpgqaU3pXE+1VvCR5GSWNuZtnei9vdrEhmR2G7iX0GlDvCtTV
 DqWydAXEUg+IXA4dOa7Qu3+MUuZJq09hYXzMqSBCMYQeCAWK+GZJoUXoFWxsY8k/lO/0
 ZapNSY0xUTyiN4xWBb3T4GbF6rpFJ2LxIDSW1karLrN2KSAMlwMMsq6XRpqNfCOXxjur
 51AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKfECuZ5PIJcgDOIHChiehSB9wzUBjgmqsq3URRwMmc8lVFBBdWfzfqUdBe4lVHCUzhefzknESnnLyNVst4uVWX6wt9CQ=
X-Gm-Message-State: AOJu0Yz4ISW+Ql/QP1WG6/bnNHR1+Q0la+tyiGgnRUjK+PyB5LEPJ2CQ
 vYKyirK3HirSl3qxV+RyuzHu4/fjciB1Wb2TL0MFhxatm3YHs9EFVI1vgTyNmCMVnQM9OjFQ9Gd
 et1bs+afMr0KZummw0n5RfWP5iyI22MP36Z7eSEOKv/31GqBmWTWx
X-Received: by 2002:adf:f152:0:b0:362:2af4:43cc with SMTP id
 ffacd0b85a97d-367947a57c8mr1501523f8f.19.1720013762137; 
 Wed, 03 Jul 2024 06:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/OZtpy/kHsx9T3Kp4Cq+g8fg4QibsJYkxUiQKMf85LToTdzmiTeZkwD40UBFZcRsqkcBJA==
X-Received: by 2002:adf:f152:0:b0:362:2af4:43cc with SMTP id
 ffacd0b85a97d-367947a57c8mr1501503f8f.19.1720013761476; 
 Wed, 03 Jul 2024 06:36:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a648dd3sm3961618f8f.89.2024.07.03.06.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 06:36:00 -0700 (PDT)
Date: Wed, 3 Jul 2024 09:35:56 -0400
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
Message-ID: <20240703092451-mutt-send-email-mst@kernel.org>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-11-7ca0b8ed3d9f@daynix.com>
 <20240702095426-mutt-send-email-mst@kernel.org>
 <57c3c9c1-99c5-1f35-59d4-f913c3dee36b@eik.bme.hu>
 <20240703015747-mutt-send-email-mst@kernel.org>
 <f056b470-a95c-1696-4276-a60eb92fced0@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f056b470-a95c-1696-4276-a60eb92fced0@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 03, 2024 at 01:00:21PM +0200, BALATON Zoltan wrote:
> On Wed, 3 Jul 2024, Michael S. Tsirkin wrote:
> > On Wed, Jul 03, 2024 at 04:15:23AM +0200, BALATON Zoltan wrote:
> > > On Tue, 2 Jul 2024, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 27, 2024 at 03:08:00PM +0900, Akihiko Odaki wrote:
> > > > > rom_bar is tristate but was defined as uint32_t so convert it into
> > > > > OnOffAuto.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > > > Commit log should explain why this is an improvement,
> > > > not just what's done.
> > > > 
> > > > 
> > > > > diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> > > > > index e17bb50789ad..35c6c8e28493 100644
> > > > > --- a/docs/igd-assign.txt
> > > > > +++ b/docs/igd-assign.txt
> > > > > @@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
> > > > >        ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
> > > > >        PCI address 1f.0.
> > > > >      * The IGD device must have a VGA ROM, either provided via the romfile
> > > > > -      option or loaded automatically through vfio (standard).  rombar=0
> > > > > +      option or loaded automatically through vfio (standard).  rombar=off
> > > > >        will disable legacy mode support.
> > > > >      * Hotplug of the IGD device is not supported.
> > > > >      * The IGD device must be a SandyBridge or newer model device.
> > > > 
> > > > ...
> > > > 
> > > > > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > > > > index 39dae72497e0..0e920ed0691a 100644
> > > > > --- a/hw/vfio/pci-quirks.c
> > > > > +++ b/hw/vfio/pci-quirks.c
> > > > > @@ -33,7 +33,7 @@
> > > > >   * execution as noticed with the BCM 57810 card for lack of a
> > > > >   * more better way to handle such issues.
> > > > >   * The  user can still override by specifying a romfile or
> > > > > - * rombar=1.
> > > > > + * rombar=on.
> > > > >   * Please see https://bugs.launchpad.net/qemu/+bug/1284874
> > > > >   * for an analysis of the 57810 card hang. When adding
> > > > >   * a new vendor id/device id combination below, please also add
> > > > 
> > > > 
> > > > So we are apparently breaking a bunch of users who followed
> > > > documentation to the dot. Why is this a good idea?
> > > 
> > > On/off is clearer than 1/0. But isn't 1/0 a synonym for on/off so previous
> > > command lines would still work?
> > > 
> > > Regards,
> > > BALATON Zoltan
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
> true/false.

I mean, the code is open, why do you keep guessing?


No, these reuse the bool parsing logic:

static void prop_get_bit(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
{
    Property *prop = opaque;
    uint32_t *p = object_field_prop_ptr(obj, prop);
    bool value = (*p & qdev_get_prop_mask(prop)) != 0;

    visit_type_bool(v, name, &value, errp);
}

and that never accepted 0 or 1:


bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
{       
    if (g_str_equal(value, "on") ||
        g_str_equal(value, "yes") ||
        g_str_equal(value, "true") ||
        g_str_equal(value, "y")) {
        *obj = true; 
        return true;
    }
    if (g_str_equal(value, "off") ||
        g_str_equal(value, "no") ||
        g_str_equal(value, "false") ||
        g_str_equal(value, "n")) {
        *obj = false;
        return true;
    }
    
    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
               "'on' or 'off'");
    return false;
}



> Maybe similar aliases could be added to on/off/auto?

Could be, but even then switching to that would mean that user sets 1
but query returns "on".  Might or might not surprise some users.

Adding true/false yes/no y/n aliases to on/off/auto might make sense
though, for consistency. Donnu if QAPI guys will agree, though,
and not directly related to this patchset.

One other idea is to add a generic way to detect that a property is set
by user. This requirement comes up, once in a while.




> In any case when I first saw rombar I thought it would set the BAR of the
> ROM so wondered why it's 1 and not 5 or 6 or an offset. So on/off is clearer
> in this case.
> 
> Regards,
> BALATON Zoltan


I agree here, but it's been here for a long time.

-- 
MST


