Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375E2D3517F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81OQ-0000wn-Bk; Wed, 01 Apr 2026 15:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w81OP-0000wf-CM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w81OM-0005KU-E6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775072296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFHUo62d8PzS0FxGrTr83rU2/c09m4Bf1fujtdzECtQ=;
 b=f/zqM6UAPiSQZ+zKIabffwI3BRQC07a5CwawTZI9fGXe6MwdQUvpknf0Sz/RPAYcZb51cx
 8EawHcGQNnorWIKZPfeNdI68m4+FTCps+RgjQGFqSetJzh7mQwh5NEZIUgVujiFNoGskkl
 zB077WP22TnoTRjuN5t77YJHZc71nBA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-O-mTOGWrNFSktegoKmiClA-1; Wed, 01 Apr 2026 15:38:15 -0400
X-MC-Unique: O-mTOGWrNFSktegoKmiClA-1
X-Mimecast-MFC-AGG-ID: O-mTOGWrNFSktegoKmiClA_1775072295
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090bc4823cso2929421cf.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775072295; x=1775677095; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vFHUo62d8PzS0FxGrTr83rU2/c09m4Bf1fujtdzECtQ=;
 b=IimmbwJJdTIpETon1XQtliiPmz8/KpFxEy4wMq64D3BO8t9eton8Qr+86UNrjwGZwO
 H6MXIoYErcLlJ0BR+U+QCPBo1jeR++TKYqOJJlO6+JZ0tw3ttvOWhxdjJ6Gf47UxjOpw
 Z0HtvGJiNJB+PZLw20BjVtwD7a+oaFX7YXQCtDi3mjWKrofatcazRrDpsWXYMbVZ6VpS
 uk77UGO7XaTlEV1VV4vguHOVN+6Yo+fRbJBF8QULkH4fKCFY7iT4d/CJmXxIsKqqU0GC
 OP19nssVN0c1Iz6AbkVzxGiIH7jxr/yCpu6ryTVfDqnvxqqHAOg5m7L6Q6ZHqof9/UFC
 /jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775072295; x=1775677095;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFHUo62d8PzS0FxGrTr83rU2/c09m4Bf1fujtdzECtQ=;
 b=o7tQONdUiyvI/vRJLshXrFVBm7B5XPW5jmmWNBo2ifil20xFkMcWPuVAtxQWrdK0x2
 lXlJxV/cEOe+YstsOE3q4kRrbmgV2OF7KChWdP6UJyysAaZ3TGhnRnq0PTR6JIM5Vigk
 cQNKcx2NS65QBzunhOC+A+H/Kj5yHwjEWo1cyBz6ygAub994d+VqXv6HeOh6lU+ClL/z
 C7Lbh+Qx9U5kAHc4H+pYKAJjHvV9J/FsF4Dw4/5749VLbR9bCWrGw1pNehEMLSPvwKJF
 z8mOuFFK+GyXwCf9lqulpVoZDAthdWMcG1+GV8Ls+0Z6K3PR4TKWwBhISgYk+w8s4mLw
 F9pA==
X-Gm-Message-State: AOJu0Yx56gCLowQ0MkIevVfsjH3BaoSqAPkpvS9ImukZd/j6cVT8uxDt
 J0p9Wv50Vc/pJ+aOzxzWoXaUPP3losPLA9vCfQ9qVbJdwnKUfUj3wAWalQvgRCnBhD7yEQtQa8g
 0nMN2Q98mB5F0OjHLQRwdM5yVFFMrU+AXCgsW/eqNnkNkuEx8cDcb5tZHBgEEhhM6
X-Gm-Gg: ATEYQzxk8I3SyHpurNlNebbpQ6bLaSC8fkl2hV7uZCIDbR9XEbdp9Owg8DCa4bv+aDI
 JUyMTghyIcL9LLiDyM/nKkTMd6XrjXlE5leGDDsCy0Ry9GDiaTnvrRD7uARegYQkzAqYhjBNgOD
 bEIhef56M2vBwX2nD85ujwQaJxiM/tNYim0Z+SY69O4Ua2SGU6Jq4F3rN5YjXzVZvGYca0d8I73
 GEG0cOY4fKVxExJCdPt+B9blfaIStva/2tkW6+8fbxmYRaMUy0m5KKAiTag/y+Oz2nH1wGKWbcO
 8Y/Roch/RpBd9TgQCsSbcoVlOV2RhAxH2Tzk+wufVqG23hw/oRkWo9BQZpH0+wW1lP2RdW4lS+C
 h7fS4Z3DvD5fXZ4fNwMax7pqAB/mfPYseCtArEJxLWUcamw==
X-Received: by 2002:a05:622a:7912:b0:509:2f5f:a178 with SMTP id
 d75a77b69052e-50d3bbf2660mr56928251cf.21.1775072294809; 
 Wed, 01 Apr 2026 12:38:14 -0700 (PDT)
X-Received: by 2002:a05:622a:7912:b0:509:2f5f:a178 with SMTP id
 d75a77b69052e-50d3bbf2660mr56927911cf.21.1775072294347; 
 Wed, 01 Apr 2026 12:38:14 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b1fdda8sm5517641cf.11.2026.04.01.12.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:38:13 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:38:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH RFC 02/12] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Message-ID: <ac10JGed8XpI-r55@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-3-peterx@redhat.com>
 <877br7kn2p.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877br7kn2p.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 20, 2026 at 07:54:38AM +0100, Markus Armbruster wrote:
> Cc: correct libvirt list address
> 
> Peter Xu <peterx@redhat.com> writes:
> 
> > This stats is only about RAM, so make it accurate.  This paves way for
> > statistics for all devices.
> >
> > Note that even if this is part of qapi/, this should not be part of ABI of
> 
> docs/devel/qapi-code-gen.rst section "Compatibility considerations":
> 
>     Since type names are not visible in the Client JSON Protocol, types
>     may be freely renamed.  Even certain refactorings are invisible, such
>     as splitting members from one type into a common base type.
> 
> So, s/should not be/is not/.
> 
> > at least query-migrate, because the structure is not changed, and this
> > stats is always reported only under the "ram" section.
> 
> Why "at least query-migrate"?  Do you have other interfaces in mind, or
> are you just hedging?

I wanted to say the QMP command that consumes this structure will not be
affected.  Happy to learn that it's explicitly described in qapi document,
thanks for the pointer!  I'll also add this reference in the commit
message.

> 
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Libvirt Mailing List <libvir-list@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/about/removed-features.rst | 2 +-
> >  qapi/migration.json             | 8 ++++----
> >  migration/migration-stats.h     | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> > index 6f4447993c..7c4f4325f7 100644
> > --- a/docs/about/removed-features.rst
> > +++ b/docs/about/removed-features.rst
> > @@ -699,7 +699,7 @@ was superseded by ``sections``.
> >  ``query-migrate`` return value member ``skipped`` (removed in 9.1)
> >  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> >  
> > -Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
> > +Member ``skipped`` of the ``MigrationRAMStats`` struct hasn't been used
> >  for more than 10 years. Removed with no replacement.
> 
> Could simply use "of the return value".  But this is fine, too.

Let me keep this as-is then; the plan is to make this patch as simple as a
rename effort, as it's not accurate anymore (e.g. dirty-sync-count should
be a global statistic rather than RAM-only), and it also makes that name
available for system-wise statistics.

> 
> >  
> >  ``migrate`` command option ``inc`` (removed in 9.1)
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 7134d4ce47..cfc6ccee26 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -12,7 +12,7 @@
> >  { 'include': 'sockets.json' }
> >  
> >  ##
> > -# @MigrationStats:
> > +# @MigrationRAMStats:
> >  #
> >  # Detailed migration status.
> >  #
> > @@ -64,7 +64,7 @@
> >  #
> >  # Since: 0.14
> >  ##
> > -{ 'struct': 'MigrationStats',
> > +{ 'struct': 'MigrationRAMStats',
> >    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
> >             'duplicate': 'int',
> >             'normal': 'int',
> > @@ -209,7 +209,7 @@
> >  #     If this field is not returned, no migration process has been
> >  #     initiated
> >  #
> > -# @ram: `MigrationStats` containing detailed migration status, only
> > +# @ram: `MigrationRAMStats` containing detailed migration status, only
> >  #     returned if status is 'active' or 'completed'(since 1.2)
> 
> This gets rendered like
> 
>       * ram (MigrationStats, *optional*) -- MigrationStats
>         containing detailed migration status, only returned if status
>         is 'active' or 'completed'(since 1.2)
> 
> Recommend to rephrase to avoid the repetition.  Maybe
> 
>    # @ram: Detailed migration RAM status, only returned if status is
>    #     'active' or 'completed' (since 1.2)
> 
> Also consider replacing "status" by "statistics".

Sure, I'll touch it up while at this.

> 
> >  #
> >  # @xbzrle-cache: `XBZRLECacheStats` containing detailed XBZRLE
> > @@ -309,7 +309,7 @@
> >  # Since: 0.14
> >  ##
> >  { 'struct': 'MigrationInfo',
> > -  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
> > +  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
> >             '*vfio': 'VfioStats',
> >             '*xbzrle-cache': 'XBZRLECacheStats',
> >             '*total-time': 'int',
> > diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> > index c0f50144c9..1153520f7a 100644
> > --- a/migration/migration-stats.h
> > +++ b/migration/migration-stats.h
> > @@ -27,7 +27,7 @@
> >  
> >  /*
> >   * These are the ram migration statistic counters.  It is loosely
> > - * based on MigrationStats.
> > + * based on MigrationRAMStats.
> >   */
> >  typedef struct {
> >      /*
> 
> Only minor issues, and none added by this patch, so
> Acked-by: Markus Armbruster <armbru@redhat.com>

It took me a while to be able to go back to this series, thanks for the
super fast feedback!

-- 
Peter Xu


