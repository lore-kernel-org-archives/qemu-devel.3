Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v39C7-0003Si-2H; Mon, 29 Sep 2025 04:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v39C2-0003SI-HR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v39Bu-0002wU-2L
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759134291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZGHCKJNmSOsFkxPbMgsiwgEENrIyXlXPicHZi0RbAg=;
 b=ICfRTTE+W99UlzvGwANBT1iQf+VquS2GTcX455/9L3Ni/AQ/8QkLNvXD3wfMOU+uTT0eSM
 D9whfX08h2nafBceOQAIhVR3pOFNjx+dUHtR1lTsVBPQLLws2/VzFTeUOk6MEzo5wA2QHj
 sZ3RMcCHs1dKCjm/U6hUIipdHldxb3M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-O8N4g6n3Mh6-pepfu1igwQ-1; Mon, 29 Sep 2025 04:24:48 -0400
X-MC-Unique: O8N4g6n3Mh6-pepfu1igwQ-1
X-Mimecast-MFC-AGG-ID: O8N4g6n3Mh6-pepfu1igwQ_1759134287
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e49fb4c4cso1112705e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 01:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759134287; x=1759739087;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RZGHCKJNmSOsFkxPbMgsiwgEENrIyXlXPicHZi0RbAg=;
 b=I+IyP/N+POA8iMb7AyZVUmrxd9A/OZfnO9dHteefOmVETQL9vpXYQqhPe7UwT9qZi4
 o9LlLuXZD/GaJCtjI4ebWrdl/B+8no/Z/LYyeH6ujBvM9e9CRXYAIUWNBg9eM5ejPLsz
 69piQeEDI9f8DpkmfdWkFg9bGl8h5owkBJ4MTcz/LI8LW0NisTDOhVn3BM/Q8GFnvEEs
 RKsM8S/zmYl1ZOWhltjcdBZRVtB39HUalg4r/pm9/PI1Dq3SBBOqtOYozOoI4trC5Bx/
 D/WBhCKB0t2lQNVfU8E0emME+ms/oBsaplXSC1qLhZaHk0u7eiU8LKU8HR/c3sGLe5S4
 V9wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6VZfXgHlNWoFikhKEaY+yIiNT7yB+etU32z8QeGoBJsZ5tH5BDHlqhOa5MJe8rxa//VQMHHtFMF6R@nongnu.org
X-Gm-Message-State: AOJu0Yx9t/LBGS1twwuFxk23h64+Q4tarKjVdKOheYED0qzOtPntvY+y
 Vu+8OPallt/7I4TmqzYedAfGD3l2oG2ocH2ZECmTEolCtGRNdCCXMiDBpMduNLvL97MACyfXAWC
 FvlsL+T5mqBubt1k9vGPOW+7MQyKgclKYRDbCQfksZ6AYe6uQxXzuR6vs
X-Gm-Gg: ASbGncsVIc89YCr7ixhWZjsjHi7r+tiO7aEurzwH4wO8XHzdij3hTrCnjLUMo1n2zbQ
 adUsJfams7nDJyajnmpRSgKGyqDlvNMVMm3oeuAHOTAyQf7iG0x68DB2aKh1xnbR5aiC8JHNdtA
 3l+vegVRuwOz+x932tr37CFzJUS98McaRRW2BAl2Jvuorq178AgU5xn0IlsDpIzI+O1Bnl1jsY+
 ftYpUBgxvHMptn6dn5I3DNj7qXhQst1YT53hV3uUxo/Y1L1dxOUZIeiz3QsCo0WW1Kw5KW55DvR
 X2yhvZ7+OpjSDh4/zzA/WNjQJJpO86haUQ==
X-Received: by 2002:a05:6000:1789:b0:3ec:dd27:dfa3 with SMTP id
 ffacd0b85a97d-40f6550a16cmr13754862f8f.25.1759134287410; 
 Mon, 29 Sep 2025 01:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9NTGxgDTecfDY5d/u4VUEazKmRV+lqmOhgpIlVW9Q2pg1ULWz/9Wq+XWKDB1aCy88ocQKfA==
X-Received: by 2002:a05:6000:1789:b0:3ec:dd27:dfa3 with SMTP id
 ffacd0b85a97d-40f6550a16cmr13754831f8f.25.1759134286921; 
 Mon, 29 Sep 2025 01:24:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2c6b3sm18182357f8f.54.2025.09.29.01.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 01:24:46 -0700 (PDT)
Date: Mon, 29 Sep 2025 04:24:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250929042410-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org> <aNpBqlRmdOac7U99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNpBqlRmdOac7U99@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 09:22:02AM +0100, Daniel P. Berrangé wrote:
> On Mon, Sep 22, 2025 at 04:14:55PM +0100, Alex Bennée wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > 
> > > On Mon, Sep 22, 2025 at 03:26:23PM +0200, Christian Speich wrote:
> > >> On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
> > >> > On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrangé wrote:
> > >> > > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
> > >> > > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> > >> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > >> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > >> > > > > > > This removes the change introduced in [1] that prevents the use of
> > >> > > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > >> > > > > > > 
> > >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > >> > > > > > > 
> > >> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > >> > > > > > > ---
> > >> > > > > > > vhost-user-device and vhost-user-device-pci started out as user
> > >> > > > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > >> > > > > > > introduced.
> > >> > > > > > > 
> > >> > > > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > >> > > > > > > google for "vhost-user-device" I've seen no confused users.
> > >> > > > > > > 
> > >> > > > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > >> > > > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > >> > > > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > >> > > > > > > maintain our own QEMU packages, which is non-trivial.
> > >> > > > > > > 
> > >> > > > > > > So I want to propose lifting this restriction to make this feature
> > >> > > > > > > usable without a custom QEMU.
> > >> > > > > > > 
> > >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > >> > > > > > 
> > >> > > > > > The confusion is after someone reuses the ID you are claiming without
> > >> > > > > > telling anyone and then linux guests will start binding that driver to
> > >> > > > > > your device.
> > >> > > > > > 
> > >> > > > > > 
> > >> > > > > > We want people doing this kind of thing to *at a minimum*
> > >> > > > > > go ahead and register a device id with the virtio TC,
> > >> > > > > > but really to write and publish a spec.
> > >> > > > > 
> > >> > > > > Wanting people to register a device ID is a social problem and
> > >> > > > > we're trying to apply a technical hammer to it, which is rarely
> > >> > > > > an productive approach.
> > >> > > > > 
> > >> > > > > If we want to demonstrate that vhost-user-device is "risky", then
> > >> > > > > how about we rename it to have an 'x-' prefix and thus disclaim
> > >> > > > > any support for it, but none the less allow its use. Document it
> > >> > > > > as an experimental device, and if it breaks, users get to keep
> > >> > > > > both pieces.
> > >> > > > 
> > >> > > > Maybe with the insecure tag you are working on?
> > >> > > 
> > >> > > Sure.
> > >> > > 
> > >> > > > And disable in the default config?
> > >> > > 
> > >> > > Disabling in default config would retain the very problem that Christian
> > >> > > is trying to solve - that no distro would have the functionality available
> > >> > > for users.
> > >> > 
> > >> > I think his problem is that he has to patch qemu.
> > >> 
> > >> Yes I'm trying to avoid that. Patching qemu also involes providing updates
> > >> (and security patches!) for it. This is a very high burden to turn this
> > >> simple flag on.
> > >> 
> > >> > 
> > >> > As described, this is a developer option not an end user one.
> > >> 
> > >> I don't really get the distintion between developer and end user here.
> > >> 
> > >> As a developer I'm an end user too, I'm concerned with the linux kernel
> > >> and the additional host tooling for mac80211_hwsim support but QEMU
> > >> I'm just using as an user.
> > >> 
> > > Are you ok with building qemu with an extra config flag?
> > 
> > In my patch I gated the feature on:
> > 
> >   VHOST_USER_TEST
> > 
> > so it's easy to patch out of the default config.
> 
> FWIW, we have multiple other test devices that we don't gate behind KConfig
> build flags - hyperv-testdev, pc-testdev, pci-testdev & edu.

Well that's because e.g. kvmtest actually depends on pci-testdev.
IOW it's actually supported.

>  IMHO the
> vhost user device is more compelling to have enabled by default as it can
> actually be used todo something useful.
> 
> IMHO the rationale for disabling it is more fitting to downstreams like
> RHEL.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


