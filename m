Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCBACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hgq-0006ue-7Y; Mon, 22 Sep 2025 10:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0hgo-0006th-4e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0hgh-0000vN-3s
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758551922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErNFbSp4LjMeauYJPbczPvbCQlNXwugfMLcHgK8l9MY=;
 b=MqUWOUIfwyQKMIUak3iRPOEsYn9qXIdVTmUuBZJytKT3bi/vz33uxKYr/4Jw+f7EL8dG+k
 qJftxYHX3DG9ZfvCfccivrwnjPqRCE+ko8im0zYBqM++eQpspp6agtvoI0zN+IiEOWWzLP
 94dp4ppgTbb9zNvITYzSAOTVPeLLqSY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-n2W0pUO-M4Wl5pHfuME8JA-1; Mon,
 22 Sep 2025 10:38:32 -0400
X-MC-Unique: n2W0pUO-M4Wl5pHfuME8JA-1
X-Mimecast-MFC-AGG-ID: n2W0pUO-M4Wl5pHfuME8JA_1758551911
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CD9719560B8; Mon, 22 Sep 2025 14:38:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84DFD1956056; Mon, 22 Sep 2025 14:38:28 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:38:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Speich <c.speich@avm.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <aNFfYLX2V4Kz9eZy@redhat.com>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <yw2dep327wpykp2p2losnkidw3kjv5dg3q6ji7dbnymosf5q6b@dgb3dfwsvxia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw2dep327wpykp2p2losnkidw3kjv5dg3q6ji7dbnymosf5q6b@dgb3dfwsvxia>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 03:33:59PM +0200, Christian Speich wrote:
> On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > > This removes the change introduced in [1] that prevents the use of
> > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > > 
> > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > 
> > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > ---
> > > > vhost-user-device and vhost-user-device-pci started out as user
> > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > > introduced.
> > > > 
> > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > > google for "vhost-user-device" I've seen no confused users.
> > > > 
> > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > > maintain our own QEMU packages, which is non-trivial.
> > > > 
> > > > So I want to propose lifting this restriction to make this feature
> > > > usable without a custom QEMU.
> > > > 
> > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > 
> > > The confusion is after someone reuses the ID you are claiming without
> > > telling anyone and then linux guests will start binding that driver to
> > > your device.
> > > 
> > > 
> > > We want people doing this kind of thing to *at a minimum*
> > > go ahead and register a device id with the virtio TC,
> > > but really to write and publish a spec.
> > 
> > Wanting people to register a device ID is a social problem and
> > we're trying to apply a technical hammer to it, which is rarely
> > an productive approach.
> > 
> > If we want to demonstrate that vhost-user-device is "risky", then
> > how about we rename it to have an 'x-' prefix and thus disclaim
> > any support for it, but none the less allow its use. Document it
> > as an experimental device, and if it breaks, users get to keep
> > both pieces.
> 
> I don't mind the 'x-'. And if that makes it clear, that this is used
> without any warrenty, sure!
> 
> However I'm not sure where the "risky" comes from. Initially confusion
> was given as reason.

I view it as "risky" in two ways

 - this device makes it very easy for a user to shoot themselves in
   the foot
 - we dont want to have to think about compatibility across QEMU
   releases in case there is something peculiar about a particular
   device type.

IMHO, adding the 'x-' prefix and disclaiming full support is sufficient
mitigation.

> Initially I thought about some kind of '--i-really-want-to-do-this'
> flag, but somehow I don't really see this device to bethis harmful
> to to warrent that big of a deterrent.

I agree.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


