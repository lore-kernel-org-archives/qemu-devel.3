Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F60CDD56F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGmI-0007cO-MP; Thu, 19 Sep 2024 09:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srGm2-0007VX-Rg
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:00:44 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srGly-0008H3-UN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=+hFMzqNydeSJA06lUWtRksv4/SAG4KXCx6CD3FpiZQs=; b=UfHWj+R1/bwRMQpd
 W0RXu/eHirS4DmmvIDt4zHMiJwwQWuZQv7gvq4U4bfSmzoTlwhDlyBkW4/q/2Z+yQvaPkvoLMcEyS
 XJhXqXlJA5GxiketsAloCoMcoK/qB2kVYtmsg1LldJwgLeU3HcsJQlYdeST5hH38tX5v7/5OccV4p
 ZmsCsfcx+QpkFtcr7WmJNtOcaQUGJ9QuQgEo8FNHSy22WNWKQqn5esEdSVLY2EL7GzOqYMPtphpp/
 GBqa5sA5oQij6SrtMJ8ftRLEc2N08qKwg0DbmL91TlR2KiT/gDnhZrjsRrvmO05phVc2anQHs2t7+
 H7j52NItghh37o7uDw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1srGlu-006Q4d-0O;
 Thu, 19 Sep 2024 13:00:34 +0000
Date: Thu, 19 Sep 2024 13:00:34 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] migration: Remove unused zero-blocks capability
Message-ID: <ZuwgcgLfOHkOMqHT@gallifrey>
References: <20240918000207.182683-1-dave@treblig.org>
 <20240918000207.182683-3-dave@treblig.org>
 <87msk54ifb.fsf@pond.sub.org> <Zur_d4m4D3QSHYOu@x1n>
 <87ttecrkqe.fsf@pond.sub.org> <87tteber7o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87tteber7o.fsf@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:59:35 up 134 days, 13 min,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Fabiano Rosas (farosas@suse.de) wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Wed, Sep 18, 2024 at 07:52:56AM +0200, Markus Armbruster wrote:
> >>> dave@treblig.org writes:
> >>> 
> >>> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> >>> >
> >>> > migrate_zero_blocks is unused since
> >>> >   eef0bae3a7 ("migration: Remove block migration")
> >>> >
> >>> > Remove it.
> >>> > That whole zero-blocks capability was just for old-school
> >>> > block migration anyway.
> >>> >
> >>> > Remove the capability as well.
> >>> >
> >>> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> >>> > ---
> >>> >  migration/options.c |  8 --------
> >>> >  migration/options.h |  1 -
> >>> >  qapi/migration.json | 10 +---------
> >>> >  3 files changed, 1 insertion(+), 18 deletions(-)
> >>> >
> >>> > diff --git a/migration/options.c b/migration/options.c
> >>> > index 9460c5dee9..997e060612 100644
> >>> > --- a/migration/options.c
> >>> > +++ b/migration/options.c
> >>> > @@ -177,7 +177,6 @@ Property migration_properties[] = {
> >>> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> >>> >      DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
> >>> >      DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
> >>> > -    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
> >>> >      DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
> >>> >      DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
> >>> >      DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
> >>> 
> >>> Property of (pseudo-)device "migration".  The "x-" prefix suggests we
> >>> expect management software not to rely on it.  Okay.
> >>> 
> >>> [...]
> >>> 
> >>> > diff --git a/qapi/migration.json b/qapi/migration.json
> >>> > index b66cccf107..82d0fc962e 100644
> >>> > --- a/qapi/migration.json
> >>> > +++ b/qapi/migration.json
> >>> > @@ -389,13 +389,6 @@
> >>> >  #     footprint is mlock()'d on demand or all at once.  Refer to
> >>> >  #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
> >>> >  #
> >>> > -# @zero-blocks: During storage migration encode blocks of zeroes
> >>> > -#     efficiently.  This essentially saves 1MB of zeroes per block on
> >>> > -#     the wire.  Enabling requires source and target VM to support
> >>> > -#     this feature.  To enable it is sufficient to enable the
> >>> > -#     capability on the source VM.  The feature is disabled by
> >>> > -#     default.  (since 1.6)
> >>> > -#
> >>> >  # @events: generate events for each migration state change (since 2.4)
> >>> >  #
> >>> >  # @auto-converge: If enabled, QEMU will automatically throttle down
> >>> > @@ -483,7 +476,7 @@
> >>> >  # Since: 1.2
> >>> >  ##
> >>> >  { 'enum': 'MigrationCapability',
> >>> > -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> >>> > +  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
> >>> >             'events', 'postcopy-ram',
> >>> >             { 'name': 'x-colo', 'features': [ 'unstable' ] },
> >>> >             'release-ram',
> >>> 
> >>> This is used by migrate-set-capabilities and query-migrate-capabilities,
> >>> via ['MigrationCapabilityStatus'].
> >>> 
> >>> query-migrate-capabilities is unaffected: it couldn't return zero-blocks
> >>> anymore even before the patch.
> >>> 
> >>> migrate-set-capabilities changes incompatibly, I'm afraid.  Before the
> >>> patch:
> >>> 
> >>>     {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "zero-blocks", "state": true}]}}
> >>>     {"return": {}}
> >>> 
> >>> Afterwards:
> >>> 
> >>>     {"error": {"class": "GenericError", "desc": "Parameter 'capability' does not accept value 'zero-blocks'"}}
> >>> 
> >>> If we had somehow rejected the capability when it made no sense,
> >>> removing it now it never makes sense would be obviously fine.
> >>> 
> >>> The straight & narrow path is to deprecate now, remove later.
> >>
> >> I wonder whether we can make this one simpler, as IIUC this cap depends on
> >> the block migration feature, which properly went through the deprecation
> >> process and got removed in the previous release.
> >>
> >> IOW, currently QEMU behaves the same with this cap on/off, ignoring it
> >> completely.  I think it means the deprecation message (even if we provide
> >> some for two extra releases..) wouldn't be anything helpful as anyone who
> >> uses this feature already got affected before this patch.. this feature,
> >> together with block migration, are simply all gone already?
> >
> > We break compatibility for users who supply capability @zero-blocks even
> > though they are not using block migration.
> >
> > Before this patch, the capability is silently ignored.
> >
> > Afterwards, we reject it.
> >
> > This harmless misuse was *not* affected by our prior removal of block
> > migration.
> >
> > It *is* affected by the proposed removal of the capability.
> 
> How does this policy_skip thing works? Could we automatically warn
> whenever a capability has the 'deprecated' feature in migration.json?
> 
> Also, some of the incompatibility errors in migrate_caps_check() could
> be simplified with something like a new:
> 'features': [ 'conflicts': [ 'cap1', 'cap2' ] ]
> to indicate which caps are incompatible between themselves.
> 
> >
> > We either treat this in struct accordance to our rules: deprecate now,
> > remove later.  Or we bend our them:
> >
> >>> If we believe nothing relies on it, we can bend the rules and remove
> >>> right away.
> >
> > Not for me to decide.
> >
> 
> I'm fine either way, but in any case:

OK, so I'll split my code to just remove the dead function rather than the
actual capability; Thanks for Fabiano for doing the Deprecation stuff!

Dave

> -- >8 --
> >From 3ff313a52e37b8cb407c900d7a1aa266560aebb7 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Thu, 19 Sep 2024 09:49:44 -0300
> Subject: [PATCH] migration: Deprecate zero-blocks capability
> 
> The zero-blocks capability was meant to be used along with the block
> migration, which has been removed already in commit eef0bae3a7
> ("migration: Remove block migration").
> 
> Setting zero-blocks is currently a noop, but the outright removal of
> the capability would cause and error in case some users are still
> setting it. Put the capability through the deprecation process.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/about/deprecated.rst | 6 ++++++
>  migration/options.c       | 4 ++++
>  qapi/migration.json       | 5 ++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ed31d4b0b2..47cabb6fcc 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -476,3 +476,9 @@ usage of providing a file descriptor to a plain file has been
>  deprecated in favor of explicitly using the ``file:`` URI with the
>  file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
>  command documentation for details on the ``fdset`` usage.
> +
> +``zero-blocks`` capability (since 9.2)
> +''''''''''''''''''''''''''''''''''''''
> +
> +The ``zero-blocks`` capability was part of the block migration which
> +doesn't exist anymore since it was removed in QEMU v9.1.
> diff --git a/migration/options.c b/migration/options.c
> index 147cd2b8fd..b828bad0d9 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -457,6 +457,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      ERRP_GUARD();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
> +    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
> +        warn_report("zero-blocks capability is deprecated");
> +    }
> +
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>          error_setg(errp, "QEMU compiled without replication module"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b66cccf107..3af6aa1740 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -479,11 +479,14 @@
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> +# @deprecated: Member @zero-blocks is deprecated as being part of
> +#     block migration which was already removed.
>  #
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> +  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
> +           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
>             'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>             'release-ram',
> -- 
> 2.35.3
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

