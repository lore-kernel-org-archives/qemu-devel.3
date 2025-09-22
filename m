Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910D4CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gHv-00006m-5r; Mon, 22 Sep 2025 09:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0gHr-00006Q-Fx
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0gHo-0002hp-L6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758546533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbksAJwBpd35DCxgF+N4uG0Yhg9M5imxAM6BZouqvGA=;
 b=JCCI5PFti3mXCrEKqw5jF0wNRreQiKFK5gQLAYLKvOwbd3g/3vL8siFOrQFLWxwQcToJKk
 IydIavZ+/Al+Xj/zgMOXagX9bHGGke0XVyRJPa1VKyqYB+Q/dxHS+hSfU7REkDJPnYuu/7
 z5uix+nccYVY2Oct53OAaAQPz5CA5x8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-4DtTw6poOLy51cn3LIcELw-1; Mon, 22 Sep 2025 09:08:52 -0400
X-MC-Unique: 4DtTw6poOLy51cn3LIcELw-1
X-Mimecast-MFC-AGG-ID: 4DtTw6poOLy51cn3LIcELw_1758546531
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f456d4db0aso1202263f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758546531; x=1759151331;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fbksAJwBpd35DCxgF+N4uG0Yhg9M5imxAM6BZouqvGA=;
 b=pdz8E5i6DmI30h84kjerpjMTgCKJKUR9tZDhASwElpp6JGI2DHC4Qd20Oi0z2t863s
 apAyoXEz0GMjTpzlw2EYfVbfts2Q+uhgP+K8sbfnPUR66kJsWHLG2OOf2sJY6ToYQGaK
 QDYwhTSLUTzXi1AFVIOzO4wP3AVZVYlCk/X3NJjI8nbfNSlYm9mB3pgksXZoQHFEqgPC
 7NsiYKHGDbreYJ0GpnptYXma3H1OgM4b6j5I1CYsv3FLIxWFxEkx40Gv6G+UT2EDYCHb
 Z7vRkGHvk5DW4mUlCatdvUIvwoTCXmnh/5te+vsHolpAhQsVeyu5lPARJFKrOWEo+nTY
 J9Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdm8n72Ks2HPV/PZyQyN2k1IJ956SJ8lnH0fwVldBTyQkfukPF2lp5ZBgLHVUsgyWksT4d3OEo16EZ@nongnu.org
X-Gm-Message-State: AOJu0YxOb+4aztBdntx25G+apkfjw6uGNFlMZ55EGr1bru/LH7A4W5ec
 6YYyBe5g4UjKTvzXbJWJ05+ylzRM1lkBCf5tHdyEwXLVTjIWPR2F/I0PrbIcPgTGtea0GyKq3jZ
 nv4JpUB8QIlS1QXSbaGsFdim19sYSlV6wvlpL+fh+Ug8kAdIYZ8nB7q13
X-Gm-Gg: ASbGncsoSVU4+Cd1C3dwxMtATLtyEjUl1JNnZp+uUrFb/pGn7wxUyF83mbCEn12y+jx
 EKoAjLesHhFg6KIdtGlbReX40E13wsc2d2K/SgEcWpr0/xEVC0AHDSGhglK5aOQJa4cUdWtBMsx
 kM+yImEJctgfISGBvGpflZc6MRFJUpe2OCVH3V2/3+tvri/h7x0vQqLJZRx32/Z3LWv8OTN18Gn
 Afl29/Pq4ZT/SsGhB8KrLyCyleMTaDEPfOdZM9xN7sqSz3hNxa2JwwUgVry6065OhFCNiuQiGbJ
 IcHiyi5yaKIxtOn5YUE/qu5a8pZjotKSUOc=
X-Received: by 2002:a05:6000:1861:b0:3ee:109a:3a83 with SMTP id
 ffacd0b85a97d-3ee842662bemr9529289f8f.29.1758546530786; 
 Mon, 22 Sep 2025 06:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0fZf6WJ6Qjy4jpYeRR+Dgga6uo6BhVMPodVhwmSNJJH5nfbJOmafgRp7VTHXuRY/0CE4uJw==
X-Received: by 2002:a05:6000:1861:b0:3ee:109a:3a83 with SMTP id
 ffacd0b85a97d-3ee842662bemr9529219f8f.29.1758546529938; 
 Mon, 22 Sep 2025 06:08:49 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f3d8csm18918890f8f.9.2025.09.22.06.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:08:49 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:08:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250922090748-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNFF8wsycqqOTc-x@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrangé wrote:
> On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > > > This removes the change introduced in [1] that prevents the use of
> > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > > > 
> > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > 
> > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > > ---
> > > > > vhost-user-device and vhost-user-device-pci started out as user
> > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > > > introduced.
> > > > > 
> > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > > > google for "vhost-user-device" I've seen no confused users.
> > > > > 
> > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > > > maintain our own QEMU packages, which is non-trivial.
> > > > > 
> > > > > So I want to propose lifting this restriction to make this feature
> > > > > usable without a custom QEMU.
> > > > > 
> > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > 
> > > > The confusion is after someone reuses the ID you are claiming without
> > > > telling anyone and then linux guests will start binding that driver to
> > > > your device.
> > > > 
> > > > 
> > > > We want people doing this kind of thing to *at a minimum*
> > > > go ahead and register a device id with the virtio TC,
> > > > but really to write and publish a spec.
> > > 
> > > Wanting people to register a device ID is a social problem and
> > > we're trying to apply a technical hammer to it, which is rarely
> > > an productive approach.
> > > 
> > > If we want to demonstrate that vhost-user-device is "risky", then
> > > how about we rename it to have an 'x-' prefix and thus disclaim
> > > any support for it, but none the less allow its use. Document it
> > > as an experimental device, and if it breaks, users get to keep
> > > both pieces.
> > 
> > Maybe with the insecure tag you are working on?
> 
> Sure.
> 
> > And disable in the default config?
> 
> Disabling in default config would retain the very problem that Christian
> is trying to solve - that no distro would have the functionality available
> for users.

I think his problem is that he has to patch qemu.

As described, this is a developer option not an end user one.


I know Red Hat will disable it anyway - we support what we ship.


> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


