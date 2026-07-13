Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB485C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEjB-0003v3-1H; Mon, 13 Jul 2026 07:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjEj8-0003YK-Mk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjEj6-00087m-AD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783941691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ks358kdjx/XHsfqhfbhc57yJ2h73lJzpUI4/nBFMfs=;
 b=Wym3rp/2OEtUIxLqCEkDx0/mT+Ap7iPIXDI0vOljdz0Nr2Z8jJ+5FheKOkZ6KMQ/mjxxLI
 A7cqd0fcZC8s/tTCBCZkU3igdBpBSMPP5GcC6hk5PXHXFTbJkG5fOfBsK+/Q177avPc8IT
 dFqVP4kowXGwudgm4I8LMeqxy7ZG0i8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-A9n4Fve1OIC1GUhRGIENJQ-1; Mon,
 13 Jul 2026 07:21:29 -0400
X-MC-Unique: A9n4Fve1OIC1GUhRGIENJQ-1
X-Mimecast-MFC-AGG-ID: A9n4Fve1OIC1GUhRGIENJQ_1783941688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E87251955D6D; Mon, 13 Jul 2026 11:21:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8037180028B; Mon, 13 Jul 2026 11:21:23 +0000 (UTC)
Date: Mon, 13 Jul 2026 12:21:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
Message-ID: <alTKMA87h9x951Ei@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 13, 2026 at 01:55:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 13.07.26 12:51, Daniel P. Berrangé wrote:
> > On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > We are going to implement local-migration feature: some devices will be
> > > able to transfer open file descriptors through migration stream (which
> > > must UNIX domain socket for that purpose).  This allows to transfer the
> > > whole backend state without reconnecting and restarting the backend
> > > service. For example, virtio-net will migrate its attached TAP netdev,
> > > together with its connected file descriptors.
> > > 
> > > In this commit we introduce a migration parameter, which enables
> > > the feature for devices that support it (none at the moment).
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > Acked-by: Peter Xu <peterx@redhat.com>
> > > Reviewed-by: Ben Chaney <bchaney@akamai.com>
> > > ---
> > >   include/migration/misc.h |  2 ++
> > >   migration/options.c      | 18 +++++++++++++++++-
> > >   qapi/migration.json      | 12 ++++++++++--
> > >   3 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > 
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 66bd900465a..03bdf19f3a6 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -830,7 +830,8 @@
> > >              'zero-page-detection',
> > >              'direct-io',
> > >              { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
> > > -           'cpr-exec-command'] }
> > > +           'cpr-exec-command',
> > > +           'local'] }
> > >   ##
> > >   # @migrate-set-parameters:
> > > @@ -1012,6 +1013,12 @@
> > >   #     Must be set to the same value on both source and destination
> > >   #     before migration starts.  (Since 11.1)
> > >   #
> > > +# @local: Enable local migration for devices that support it.  Backend
> > > +#     state and its file descriptors can then be passed to the
> > > +#     destination in the migration channel.  The migration channel
> > > +#     must be a Unix domain socket.  Usually needs to be enabled per
> > > +#     device.  (Since 11.2)
> > 
> > What happens when this is enabled and there are devices which
> > don't support it ?
> 
> These devices are migrated as usual, ignoring "local" option.
> 
> > 
> > What happens when this is enabled and a device on the src
> > does not support it but a device on the (newer) QEMU dest
> > does support it ?  How does the mgmt app know which devices
> > support it ?
> 
> The only supporting device (TAP-backend) declares support by
> "local-migration-supported", so mgmt app should care to set
> same value for it on host and target (like for other options
> actually). Or simply relay on default, which is true starting
> from 11.2 Machine Type.
> 
> > 
> > Can we document the semantics in these cases.
> 
> That's: "Usually needs to be enabled per device."

....except that we have it enabled by default for TAP backends
in new machine types.... except that it will then break if the
app/user has enabled any of the "forbidden" options.

The way this doc is written makes it sound like "local" is an
optimization you can turn on in any scenario, and it will do
the right thing if the device supports it. That is very much
not the case - enabling this flag will definitely break many
configs out of the box, with new machine types due to the TAP
device defaults & incompatible options.


> So, we (may) have three types of devices:
> 
> 1. Not supporting "local" migration: they just ignore "local" migration
> parameter.

Yep, the easy case.

> 
> 2. Supporting "local" from the beginning (not such devices for now):
> they simply do "local" migration when "local" is set, and "usual"
> migration when "local" is not set.

...except that abort the migration if you used any forbidden options.
I really dislike this as default out of the box behaviour for the
TAP backend.

> 3. Support for "local" appears at some moment (like TAP in this series).
> Such devices should have a possibility to enable/disable the "support
> for local" by hand, to be able to migrate betweend supporting and
> not supporting QEMU versions.

If the mgmt app is manually enabling the feature, then mitigates
the problem of forbidden options, as they should be aware of
whether their config is safe to enable or not.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


