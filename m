Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A1EC1128
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucCx-0004DT-IR; Mon, 23 Feb 2026 15:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vucCr-0004D7-OT
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vucCo-0007Ei-2o
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771877216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VL6VgyD5voTBjuNHnM1SEKYWuGgEgwCb9XdN4G3ySww=;
 b=EP8rfABJ4JIfK/s4IhtzKKjrDqkY/PCEotuw9McBggNuuAXVzeqJaYvxGE2hLb/M/7RdwM
 5XqgsBarqZGKHagsTGA+ODH37ldYQzBVbQAkYaDeFKG3o4ewWMKVt2dVXVR+lM9x2y2ayC
 9KUXzq2zNuvq0dxl9PrkAxN/aJ58OOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-Ibscjxo4Mqi3wgWSvW8VlQ-1; Mon,
 23 Feb 2026 15:06:52 -0500
X-MC-Unique: Ibscjxo4Mqi3wgWSvW8VlQ-1
X-Mimecast-MFC-AGG-ID: Ibscjxo4Mqi3wgWSvW8VlQ_1771877211
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48C24180025B; Mon, 23 Feb 2026 20:06:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AAD61800666; Mon, 23 Feb 2026 20:06:47 +0000 (UTC)
Date: Mon, 23 Feb 2026 20:06:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: migration: stable machine types?
Message-ID: <aZyzVOZkeicX0lrS@redhat.com>
References: <eabe1076-d30c-4454-8558-a231b9cb228d@tls.msk.ru>
 <aZwwGW7ERvH555zg@redhat.com> <aZysbHMzin4PYtIK@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZysbHMzin4PYtIK@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 23, 2026 at 02:37:16PM -0500, Peter Xu wrote:
> On Mon, Feb 23, 2026 at 10:46:49AM +0000, Daniel P. Berrangé wrote:
> > On Sat, Feb 21, 2026 at 09:55:55AM +0300, Michael Tokarev wrote:
> > > Hi!
> > > 
> > > We had a few examples when a bugfix required for a stable series
> > > but it can't be applied because it breaks migration.  One recent
> > > example is https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2131822 -
> > > the fix has been cherry-picked for 10.0.x but had to be reverted.
> > > 
> > > I wonder if we can, sometimes, introduce additional machine types
> > > for stable series.
> > > 
> > > In this case, it might've been an intermediate 10.0.4 machine type,
> > > which is between 10.0 and 10.1 - with this additional change included.
> > > 
> > > If this machine is known to both 10.1-tobe and 10.0.4+, all migration
> > > should work fine in both directions.
> > 
> > Yep, any bug fix machine would need to be added to 'master' branch
> > too, and any intermediate stable branches - though the latter probably
> > wouldn't ever happen as machine version mistakes are usually discovered
> > reasonably soon.
> > 
> > > It is exactly the same situation and solution which has been implemented
> > > by ubuntu in the end, but using their own, distribution-specific,
> > > machine types.
> > > 
> > > Why can't we do the same in upstream qemu?
> > 
> > There is no constraint from a technical POV. The macros I introduced
> > for defining versioned machine types in a standardized manner, can
> > have variants provided that define "bug fix" machines for stable
> > branches. We have a pretty old example for Q35:
> > 
> >   hw/i386/pc_q35.c:DEFINE_Q35_MACHINE_BUGFIX(4, 0, 1);
> > 
> > We used to have another example for PPC, which used the _MACHINE_TAGGED
> > variant, which added a string suffix instead of a micro version number,
> > but I'd recommend we don't use string suffixes again, only micro versions.
> > 
> > The core reason we didn't do this in the past was the support workload,
> > as every extra machine type we add is one more thing to maintain...
> > previously this burden was forever, but at least now we have capped
> > versioned machines at 6 years / 18 minor releases total lifetime.
> > Thus if we did add bugfix machines, that burden is now capped and
> > thus more tolerable.
> > 
> > 
> > IOW, if you as stable maintainer want to add a bugfix machine, and
> > the subsystem maintainer for that machine is aggreeable to adding
> > it too, there is no fundamental blocker here.
> 
> Then does it mean we may sometimes need to add >1 new bugfix machine types
> for one fix?
> 
> Consider if somethinig was broken in QEMU 10.0 release, then in 11.0 QEMU
> we fixed it and marked backport (which will break guest ABI).
> 
> If we want to backport that change to older systems (that is, in this case
> 10.0, 10.1, 10.2), IIUC we need to introduce three machines (for example,
> 10.0.3, 10.1.2, 10.2.1), rather than one bugfix machine type.  IIUC we'll
> need all these machine types available in master branch and intermediate
> stable branches?

If we cause a regression in an existing machine type via a backport,
we should just fix that regression, not introduce a new machine type.


A new machine type in stable should only be considered where we need
to backport a bugfix, and that fix was inherantly tied to a machine
type that exists in master, but not in stable.

Even if it is possible to do it, we should still consider each case
to decide it is it desirable to do it, given the support burden.

IOW, if we ended up with multiple bugfix machine types per stable
stream, IMHO that would be a sign we were not being anywhere near
strict enough.

I was thinking this should be something where we have 0 or 1 bug
fix machines introduced per year. ie most stable branches should
not need bugfix machine types. Only the most significant of bugs
should justify it.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


