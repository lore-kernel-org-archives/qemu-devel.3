Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B43ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3912-0007kY-T0; Mon, 29 Sep 2025 04:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v390x-0007i6-UP
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:13:44 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v390G-0006LC-P2
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1759133565; bh=ZJN1T+3uy6JDx5c7fVjlES928ciKyRlESGuOs6DJgCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ukuBd18VtQUc6cRkYO+qAUpWYM+OdiIF6lf1C2KeENDEwJQ63dDW81cEJWnFi6blD
 O+pilO5RJ2kvfAI8ISLs15UAI/QuKyfUMD9B1IBd/DDOeQ9agpb1Vg0F3+50DuQMFD
 PoJjaaY7WcIHE/qXdXp/s5PD2la/RQ2N29zvj/DY=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68da3f7d-047a-7f0000032729-7f000001a6e6-1
 for <multiple-recipients>; Mon, 29 Sep 2025 10:12:45 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Mon, 29 Sep 2025 10:12:45 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025092910124650-4787 ;
 Mon, 29 Sep 2025 10:12:46 +0200 
Date: Mon, 29 Sep 2025 10:12:44 +0200
From: Christian Speich <c.speich@avm.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=
 <berrange@redhat.com>, qemu-devel@nongnu.org, Stefano Garzarella
 <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <ytavi42a5zivn7ki6jc3zbnjmleq7tngdpaeqmnnfbjumat33b@533ax5vgapyg>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org>
MIME-Version: 1.0
In-Reply-To: <87y0q6mscw.fsf@draig.linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 29.09.2025 10:12:46,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 29.09.2025 10:12:46, Serialize complete at 29.09.2025 10:12:46
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1759133565-48FDF9E6-C402950F/0/0
X-purgate-type: clean
X-purgate-size: 4952
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 04:14:55PM +0100, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Sep 22, 2025 at 03:26:23PM +0200, Christian Speich wrote:
> >> On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
> >> > On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrangé wrote:
> >> > > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
> >> > > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> >> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> >> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> >> > > > > > > This removes the change introduced in [1] that prevents the use of
> >> > > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> >> > > > > > > 
> >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> >> > > > > > > 
> >> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> >> > > > > > > ---
> >> > > > > > > vhost-user-device and vhost-user-device-pci started out as user
> >> > > > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> >> > > > > > > introduced.
> >> > > > > > > 
> >> > > > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> >> > > > > > > google for "vhost-user-device" I've seen no confused users.
> >> > > > > > > 
> >> > > > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> >> > > > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> >> > > > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> >> > > > > > > maintain our own QEMU packages, which is non-trivial.
> >> > > > > > > 
> >> > > > > > > So I want to propose lifting this restriction to make this feature
> >> > > > > > > usable without a custom QEMU.
> >> > > > > > > 
> >> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> >> > > > > > 
> >> > > > > > The confusion is after someone reuses the ID you are claiming without
> >> > > > > > telling anyone and then linux guests will start binding that driver to
> >> > > > > > your device.
> >> > > > > > 
> >> > > > > > 
> >> > > > > > We want people doing this kind of thing to *at a minimum*
> >> > > > > > go ahead and register a device id with the virtio TC,
> >> > > > > > but really to write and publish a spec.
> >> > > > > 
> >> > > > > Wanting people to register a device ID is a social problem and
> >> > > > > we're trying to apply a technical hammer to it, which is rarely
> >> > > > > an productive approach.
> >> > > > > 
> >> > > > > If we want to demonstrate that vhost-user-device is "risky", then
> >> > > > > how about we rename it to have an 'x-' prefix and thus disclaim
> >> > > > > any support for it, but none the less allow its use. Document it
> >> > > > > as an experimental device, and if it breaks, users get to keep
> >> > > > > both pieces.
> >> > > > 
> >> > > > Maybe with the insecure tag you are working on?
> >> > > 
> >> > > Sure.
> >> > > 
> >> > > > And disable in the default config?
> >> > > 
> >> > > Disabling in default config would retain the very problem that Christian
> >> > > is trying to solve - that no distro would have the functionality available
> >> > > for users.
> >> > 
> >> > I think his problem is that he has to patch qemu.
> >> 
> >> Yes I'm trying to avoid that. Patching qemu also involes providing updates
> >> (and security patches!) for it. This is a very high burden to turn this
> >> simple flag on.
> >> 
> >> > 
> >> > As described, this is a developer option not an end user one.
> >> 
> >> I don't really get the distintion between developer and end user here.
> >> 
> >> As a developer I'm an end user too, I'm concerned with the linux kernel
> >> and the additional host tooling for mac80211_hwsim support but QEMU
> >> I'm just using as an user.
> >> 
> >> Greetings,
> >> Christian
> >
> > Are you ok with building qemu with an extra config flag?
> 
> In my patch I gated the feature on:
> 
>   VHOST_USER_TEST
> 
> so it's easy to patch out of the default config.

Do you want to move forward with your patch? Or should I update this one with a config
flag and an x- prefix?(which then should look a lot like yours anyway)

Greetings,
Christian

> 
> >
> >
> >
> >> > 
> >> > 
> >> > I know Red Hat will disable it anyway - we support what we ship.
> >> > 
> >> > 
> >> > > With regards,
> >> > > Daniel
> >> > > -- 
> >> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> >> > > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> >> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> >> > 
> >> > 
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

