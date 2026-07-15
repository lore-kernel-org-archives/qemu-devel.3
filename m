Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905EDC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1v2-0000Sa-Ks; Wed, 15 Jul 2026 11:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk1v1-0000SF-52
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk1uy-0005H8-VQ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784130783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OCLYhPCoaTPzd0cjpjRLz6U09mDfeXipA02PIh9dHWg=;
 b=JBTmBUsCTJc+0irzdAgdZi4aE2joLRwj7H6hTtt43/O/p5GYew4qYpT8lzpGo840MXX5SV
 Ao3tjSxdcQF1t7mrO9r4xIdBgLJv0Q5aborSoAjZZyufhjJehCumjb/xApWySZjJvBi8U1
 bMl+Z5vCxpc0n14/HVqdVVxtC3vvE3M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-9WyTv9BpNoGS7ij6aBw2cA-1; Wed,
 15 Jul 2026 11:53:00 -0400
X-MC-Unique: 9WyTv9BpNoGS7ij6aBw2cA-1
X-Mimecast-MFC-AGG-ID: 9WyTv9BpNoGS7ij6aBw2cA_1784130779
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38F6818002CC; Wed, 15 Jul 2026 15:52:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 577F230001A4; Wed, 15 Jul 2026 15:52:51 +0000 (UTC)
Date: Wed, 15 Jul 2026 16:52:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <ales0BaHaS0ZgA2d@redhat.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715114802-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
> > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > Hi all!
> > > 
> > > Here is a migration for TAP net backend, including its properties and
> > > open fds.
> > > 
> > > With this new feature, management software doesn't need to initialize
> > > new TAP and do a switch to it. Nothing should be done around
> > > virtio-net in local migration: it just migrates and continues to use
> > > same TAP device. So we avoid extra logic in management software, extra
> > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > migration downtime.
> > 
> > This is quite a big patch set, - is this really worth the effort to do
> > all this just for *local* migration?  What's the possible use case for
> > this in real, - am I right this is just about upgrading the host qemu?
> > And with that in mind, isn't it sufficient to use what we already have
> > (namely, create new tap, start new qemu instance, and migrate the usual
> > way), and tolerate some very minor downtime while the networking code
> > learns the new network topology (isn't it happening almost instantly
> > anyway, and if not, the management can help by sending gratitious ARP)?
> > 
> > I wonder what's the use for this at yandex?
> > 
> > Thanks,
> > 
> > /mjt
> 
> Well just theoretically, imagine a big VM, reserving twice the amount
> of memory just to migrate is not nice at all.

Don't we already have the ability to skip memory transfer by setting
the "x-ignore-shared" capability, assuming the VM RAM has a shared
memory backing.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


