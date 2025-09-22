Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7D6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ggI-0002lF-GW; Mon, 22 Sep 2025 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v0ggF-0002l1-Br
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:34:11 -0400
Received: from mail.avm.de ([2001:bf0:244:244::94])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>) id 1v0ggA-0007Ut-8F
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1758548040; bh=vKbduuaCNbkac2u5ysZ8nS1ybwV8XPfEy+no73Kw1wo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u3BU0850qC1icyGUxbwZ6DPBp1NhQ9JfsiRrG1Kso0mMMpqBw3jRREg3wwcae+mLw
 MEZ2JbIB2w6g2K72FSYVlBgrkaGOAvCtF4e4rF9jxj0xU3VfqiNG9QCkLzSeRwdQYi
 wpN7Ul9EpnAQkGScUkyDwN12OlR6yVMsDkO+YWNQ=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68d15048-f941-7f0000032729-7f000001b4ec-1
 for <multiple-recipients>; Mon, 22 Sep 2025 15:34:00 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Mon, 22 Sep 2025 15:34:00 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025092215340054-16165 ;
 Mon, 22 Sep 2025 15:34:00 +0200 
Date: Mon, 22 Sep 2025 15:33:59 +0200
From: Christian Speich <c.speich@avm.de>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Stefano
 Garzarella <sgarzare@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <yw2dep327wpykp2p2losnkidw3kjv5dg3q6ji7dbnymosf5q6b@dgb3dfwsvxia>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aNE0Bp0hsA31sLCJ@redhat.com>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 22.09.2025 15:34:00,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 22.09.2025 15:34:00, Serialize complete at 22.09.2025 15:34:00
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1758548040-C25C5482-6BA5B5D4/0/0
X-purgate-type: clean
X-purgate-size: 3024
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::94;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > This removes the change introduced in [1] that prevents the use of
> > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > 
> > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > 
> > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > ---
> > > vhost-user-device and vhost-user-device-pci started out as user
> > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > introduced.
> > > 
> > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > google for "vhost-user-device" I've seen no confused users.
> > > 
> > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > maintain our own QEMU packages, which is non-trivial.
> > > 
> > > So I want to propose lifting this restriction to make this feature
> > > usable without a custom QEMU.
> > > 
> > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > 
> > The confusion is after someone reuses the ID you are claiming without
> > telling anyone and then linux guests will start binding that driver to
> > your device.
> > 
> > 
> > We want people doing this kind of thing to *at a minimum*
> > go ahead and register a device id with the virtio TC,
> > but really to write and publish a spec.
> 
> Wanting people to register a device ID is a social problem and
> we're trying to apply a technical hammer to it, which is rarely
> an productive approach.
> 
> If we want to demonstrate that vhost-user-device is "risky", then
> how about we rename it to have an 'x-' prefix and thus disclaim
> any support for it, but none the less allow its use. Document it
> as an experimental device, and if it breaks, users get to keep
> both pieces.

I don't mind the 'x-'. And if that makes it clear, that this is used
without any warrenty, sure!

However I'm not sure where the "risky" comes from. Initially confusion
was given as reason.

Initially I thought about some kind of '--i-really-want-to-do-this'
flag, but somehow I don't really see this device to bethis harmful
to to warrent that big of a deterrent.

Kind regards,
Christian

> 
> It seems like it would be useful before any virtio spec submission
> as a mechanism by which users can experiment to finese their ideas
> prior to getting to the point of needing to make a spec proposal.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 

