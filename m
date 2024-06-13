Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371FAC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmqG-0006uf-Q8; Thu, 13 Jun 2024 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHmqF-0006tI-0n
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHmqD-00067h-B5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718294300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpubRBwaYHCjb9hNKIpx/oOqBRIOQL8TECIXcTtLxXg=;
 b=OHN3Zjkz1749nPHgUGSSQgvDjgTivUHl3bV8P84tFeJo48YHKJEM/KoX3CWGv2/TvSd0ju
 iZuwOkz6nbkwo8GMGXg3Mjx8+sdmLpbdplSiRI61n/qBcbO7oFXsO5QRqYANUISwtI2oWp
 a46PjAmfSEPxpcY+/uUsCvxvuLUaf04=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-GEI3FtNEMhydzX53DYlxJQ-1; Thu, 13 Jun 2024 11:58:18 -0400
X-MC-Unique: GEI3FtNEMhydzX53DYlxJQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c9b91277a9so200478b6e.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 08:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718294298; x=1718899098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpubRBwaYHCjb9hNKIpx/oOqBRIOQL8TECIXcTtLxXg=;
 b=P/ZazuPkaxkr7KWl08WMztfdGXiu+1od5eDUDj8UwU/gpLZ3JL2hj7DbwbjMeT9MHF
 qS16jzq+LEeXmV3Fpfm4jiWhz6nbA6ACXKr5/L0cxRImSLjyIjaN3O12m0Wk2dfshLBZ
 bI3ynWyYO5m4h/0vWyl/KCIekuuE6/a/ZvH6JK+9kb8bXnpBvIcqQbuPAu0ZcI/V9H/3
 5kRhPRMK/N4BLNSbNlQ8wmcMGcTMrnzvmvr8olvIVtGqX25MD3lgP1Fl0vLTzMz6doKu
 TfOSn9z6IPDaiBUOvRH2ifh+KOoAz3qQVb2jkWJkozYT2wiHqAvi7tA0mS8ZgVKqtql8
 13wA==
X-Gm-Message-State: AOJu0YwGvyHWkRnOYlhZt1iLBYN37QvrKpwMO/r0RTTvYAtyKjItsyMh
 9g+yNRaid19ukXBB7/RNBbZjy3lPGY9nFRgBfo8eFuGRfmUfR0/8Fz7tZl1XGhba7HAslJdIabD
 gizKjzPvt/3zBNP5UFx2yktrIGJUKnW+4Ouajq8XfS06BY44CuImm
X-Received: by 2002:a05:6870:798:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-2583e83d7femr743939fac.1.1718294297758; 
 Thu, 13 Jun 2024 08:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4x7UJGV2KpchYjKm6DSrJhNh2tDNqnto80yc1pAdKH+dBiAiRb0kWblrJ2YpdI6laAaF5xQ==
X-Received: by 2002:a05:6870:798:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-2583e83d7femr743920fac.1.1718294297186; 
 Thu, 13 Jun 2024 08:58:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abe69cd0sm62151185a.124.2024.06.13.08.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:58:16 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:58:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH 3/4] migration: Use MigrationStatus instead of int
Message-ID: <ZmsXF2Fltf-iNByl@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-4-peterx@redhat.com> <Zmm4z0qbv8H39pC0@x1n>
 <87wmmsc2if.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmmsc2if.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 13, 2024 at 11:59:20AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jun 12, 2024 at 10:42:27AM -0400, Peter Xu wrote:
> >> @@ -1544,7 +1545,7 @@ bool migration_in_postcopy(void)
> >>      }
> >>  }
> >>  
> >> -bool migration_postcopy_is_alive(int state)
> >> +bool migration_postcopy_is_alive(MigrationStatus state)
> >>  {
> >>      switch (state) {
> >>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> >> @@ -1598,7 +1599,7 @@ bool migration_is_idle(void)
> >>      case MIGRATION_STATUS_DEVICE:
> >>      case MIGRATION_STATUS_WAIT_UNPLUG:
> >>          return false;
> >> -    case MIGRATION_STATUS__MAX:
> >> +    default:
> >>          g_assert_not_reached();
> >>      }
> >
> > This survives the tests, but I just found that it's risky, as it's not
> > covering all the states..
> >
> > I'll squash below when I send v2 instead.
> >
> > ===8<===
> > From 1fc42c76294044c0ccca8841e482472486de5459 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Wed, 12 Jun 2024 10:57:26 -0400
> > Subject: [PATCH] fixup! migration: Use MigrationStatus instead of int
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 9475dce7dc..706cee1b69 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1637,20 +1637,9 @@ bool migration_is_idle(void)
> >      case MIGRATION_STATUS_COMPLETED:
> >      case MIGRATION_STATUS_FAILED:
> >          return true;
> > -    case MIGRATION_STATUS_SETUP:
> > -    case MIGRATION_STATUS_CANCELLING:
> > -    case MIGRATION_STATUS_ACTIVE:
> > -    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > -    case MIGRATION_STATUS_COLO:
> > -    case MIGRATION_STATUS_PRE_SWITCHOVER:
> > -    case MIGRATION_STATUS_DEVICE:
> > -    case MIGRATION_STATUS_WAIT_UNPLUG:
> > -        return false;
> >      default:
> > -        g_assert_not_reached();
> > +        return false;
> >      }
> 
> Unrelated, but should we consider POSTCOPY_PAUSED as idle?

I think not; idle should be about "whether a migration is in progress" in
verbose, IMHO.

E.g. see migrate_add_blocker_modes() -> is_busy(), otherwise we'll allow
changing migration blockers when postcopy is paused.

PS: offtopic, but.. "is_busy" may deserve some better name in the future..

-- 
Peter Xu


