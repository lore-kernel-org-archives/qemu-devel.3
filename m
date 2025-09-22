Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gYv-0006YO-9l; Mon, 22 Sep 2025 09:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v0gYs-0006Xx-1w
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:26:34 -0400
Received: from mail.avm.de ([2001:bf0:244:244::94])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v0gYp-00061T-1M
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:26:33 -0400
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68d14e80-f941-7f0000032729-7f000001e5b8-1
 for <multiple-recipients>; Mon, 22 Sep 2025 15:26:24 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Mon, 22 Sep 2025 15:26:24 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025092215262457-15975 ;
 Mon, 22 Sep 2025 15:26:24 +0200 
Date: Mon, 22 Sep 2025 15:26:23 +0200
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250922090748-mutt-send-email-mst@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 22.09.2025 15:26:24,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 22.09.2025 15:26:24, Serialize complete at 22.09.2025 15:26:24
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1758547584-11B9B482-5901DFEB/0/0
X-purgate-type: clean
X-purgate-size: 3857
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::94;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Christian Speich <c.speich@avm.de>
From:  Christian Speich via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > > > > This removes the change introduced in [1] that prevents the use of
> > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > > > > 
> > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > > 
> > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > > > ---
> > > > > > vhost-user-device and vhost-user-device-pci started out as user
> > > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > > > > introduced.
> > > > > > 
> > > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > > > > google for "vhost-user-device" I've seen no confused users.
> > > > > > 
> > > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > > > > maintain our own QEMU packages, which is non-trivial.
> > > > > > 
> > > > > > So I want to propose lifting this restriction to make this feature
> > > > > > usable without a custom QEMU.
> > > > > > 
> > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > 
> > > > > The confusion is after someone reuses the ID you are claiming without
> > > > > telling anyone and then linux guests will start binding that driver to
> > > > > your device.
> > > > > 
> > > > > 
> > > > > We want people doing this kind of thing to *at a minimum*
> > > > > go ahead and register a device id with the virtio TC,
> > > > > but really to write and publish a spec.
> > > > 
> > > > Wanting people to register a device ID is a social problem and
> > > > we're trying to apply a technical hammer to it, which is rarely
> > > > an productive approach.
> > > > 
> > > > If we want to demonstrate that vhost-user-device is "risky", then
> > > > how about we rename it to have an 'x-' prefix and thus disclaim
> > > > any support for it, but none the less allow its use. Document it
> > > > as an experimental device, and if it breaks, users get to keep
> > > > both pieces.
> > > 
> > > Maybe with the insecure tag you are working on?
> > 
> > Sure.
> > 
> > > And disable in the default config?
> > 
> > Disabling in default config would retain the very problem that Christian
> > is trying to solve - that no distro would have the functionality available
> > for users.
> 
> I think his problem is that he has to patch qemu.

Yes I'm trying to avoid that. Patching qemu also involes providing updates
(and security patches!) for it. This is a very high burden to turn this
simple flag on.

> 
> As described, this is a developer option not an end user one.

I don't really get the distintion between developer and end user here.

As a developer I'm an end user too, I'm concerned with the linux kernel
and the additional host tooling for mac80211_hwsim support but QEMU
I'm just using as an user.

Greetings,
Christian

> 
> 
> I know Red Hat will disable it anyway - we support what we ship.
> 
> 
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 

