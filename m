Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6FCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 10:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3AnJ-0001tZ-Mt; Mon, 29 Sep 2025 06:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3AnH-0001tR-31
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3An4-0002FL-OY
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759140439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOEfCl6UomcujDX1GXDEtdxbfYKrBBcXeBXutg6Q4MI=;
 b=aswZ0t4R35NUkNKkv/gmal1NHx5VYdQ4Hdx327Tpp075lAsbl7s98fQ5Xs7GQCMkdaSwkb
 y6UgwYIyWdDppUcYHqZ66TmeFR9O5YFhAKVrG8p+xRhbFdhlVaRVRtARpCFCg8NDcuQjwG
 tvToVueklhGSm7tPGzHgfBhKcaSsnqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-GBp82F-NOP22KmTeO6l_Xg-1; Mon,
 29 Sep 2025 06:07:17 -0400
X-MC-Unique: GBp82F-NOP22KmTeO6l_Xg-1
X-Mimecast-MFC-AGG-ID: GBp82F-NOP22KmTeO6l_Xg_1759140436
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DD21800366; Mon, 29 Sep 2025 10:07:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988F3195608E; Mon, 29 Sep 2025 10:07:11 +0000 (UTC)
Date: Mon, 29 Sep 2025 11:07:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <aNpaSpF_qY6z03Q3@redhat.com>
References: <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org> <aNpBqlRmdOac7U99@redhat.com>
 <20250929042410-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929042410-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 29, 2025 at 04:24:44AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 29, 2025 at 09:22:02AM +0100, Daniel P. Berrangé wrote:
> > On Mon, Sep 22, 2025 at 04:14:55PM +0100, Alex Bennée wrote:
> > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > 
> > > > On Mon, Sep 22, 2025 at 03:26:23PM +0200, Christian Speich wrote:
> > > >> On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
> > > >> > On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrangé wrote:
> > > >> > > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
> > > >> > > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> > > >> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > >> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > >> > > > > > > This removes the change introduced in [1] that prevents the use of
> > > >> > > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > >> > > > > > > 
> > > >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > >> > > > > > > 
> > > >> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > >> > > > > > > ---
> > > >> > > > > > > vhost-user-device and vhost-user-device-pci started out as user
> > > >> > > > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > >> > > > > > > introduced.
> > > >> > > > > > > 
> > > >> > > > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > >> > > > > > > google for "vhost-user-device" I've seen no confused users.
> > > >> > > > > > > 
> > > >> > > > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > >> > > > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > >> > > > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > >> > > > > > > maintain our own QEMU packages, which is non-trivial.
> > > >> > > > > > > 
> > > >> > > > > > > So I want to propose lifting this restriction to make this feature
> > > >> > > > > > > usable without a custom QEMU.
> > > >> > > > > > > 
> > > >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > >> > > > > > 
> > > >> > > > > > The confusion is after someone reuses the ID you are claiming without
> > > >> > > > > > telling anyone and then linux guests will start binding that driver to
> > > >> > > > > > your device.
> > > >> > > > > > 
> > > >> > > > > > 
> > > >> > > > > > We want people doing this kind of thing to *at a minimum*
> > > >> > > > > > go ahead and register a device id with the virtio TC,
> > > >> > > > > > but really to write and publish a spec.
> > > >> > > > > 
> > > >> > > > > Wanting people to register a device ID is a social problem and
> > > >> > > > > we're trying to apply a technical hammer to it, which is rarely
> > > >> > > > > an productive approach.
> > > >> > > > > 
> > > >> > > > > If we want to demonstrate that vhost-user-device is "risky", then
> > > >> > > > > how about we rename it to have an 'x-' prefix and thus disclaim
> > > >> > > > > any support for it, but none the less allow its use. Document it
> > > >> > > > > as an experimental device, and if it breaks, users get to keep
> > > >> > > > > both pieces.
> > > >> > > > 
> > > >> > > > Maybe with the insecure tag you are working on?
> > > >> > > 
> > > >> > > Sure.
> > > >> > > 
> > > >> > > > And disable in the default config?
> > > >> > > 
> > > >> > > Disabling in default config would retain the very problem that Christian
> > > >> > > is trying to solve - that no distro would have the functionality available
> > > >> > > for users.
> > > >> > 
> > > >> > I think his problem is that he has to patch qemu.
> > > >> 
> > > >> Yes I'm trying to avoid that. Patching qemu also involes providing updates
> > > >> (and security patches!) for it. This is a very high burden to turn this
> > > >> simple flag on.
> > > >> 
> > > >> > 
> > > >> > As described, this is a developer option not an end user one.
> > > >> 
> > > >> I don't really get the distintion between developer and end user here.
> > > >> 
> > > >> As a developer I'm an end user too, I'm concerned with the linux kernel
> > > >> and the additional host tooling for mac80211_hwsim support but QEMU
> > > >> I'm just using as an user.
> > > >> 
> > > > Are you ok with building qemu with an extra config flag?
> > > 
> > > In my patch I gated the feature on:
> > > 
> > >   VHOST_USER_TEST
> > > 
> > > so it's easy to patch out of the default config.
> > 
> > FWIW, we have multiple other test devices that we don't gate behind KConfig
> > build flags - hyperv-testdev, pc-testdev, pci-testdev & edu.
> 
> Well that's because e.g. kvmtest actually depends on pci-testdev.
> IOW it's actually supported.

This again just sounds like a downstream 'support' rationalization.
I'm still not seeing a compelling reason why the vhost user generic
device should be disabled by default in upstream, especially if we
mark it as an experimental device with an x- prefix. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


