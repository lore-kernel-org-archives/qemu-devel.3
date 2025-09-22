Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BDACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0eh1-00053b-Qc; Mon, 22 Sep 2025 07:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v0egs-00052P-8Y
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v0ego-0000Id-0a
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758540393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hW4hR82tiMBU3vapspKIyV4qr50kzzzhya1SshHYjEU=;
 b=gel8v9AqPoeSsf2odcAGWgsIPXcyPihK4LjVGtMykODw8RAv1oq5XPF2Z27ysuNBvUMoiD
 HAY2X9lTp0Mkkp9NgiroaXPxlaxWPCnQBDW4gOqP/CAcVChD3hk5hCgvNPidLDwwsPQBSJ
 Mz56xfKSWH5OMFuEdMlZv6oW01v24dg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-T0XMO0Y4PfiN7WqUsY83jw-1; Mon, 22 Sep 2025 07:26:27 -0400
X-MC-Unique: T0XMO0Y4PfiN7WqUsY83jw-1
X-Mimecast-MFC-AGG-ID: T0XMO0Y4PfiN7WqUsY83jw_1758540385
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f924ae2a89so890233f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540385; x=1759145185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hW4hR82tiMBU3vapspKIyV4qr50kzzzhya1SshHYjEU=;
 b=VkiBp9b1dGgA26ATjZkH+QAuWQHc2ICvUy+h6coZcnm2dT//5kTA0Ro7R8Ke3GV2i9
 gbARXcf5jDYmxmev6UfzKWHwhzQi2ZJ3fHp3qvK+94k9WvrqrRwX7jFGtmfd2ypfP6LG
 cMxLpH8rrAthgzll+Ut1noBje15um29tZShULOWXeaHoBSnDScsKhBhHy7sdljomxhpS
 IoaZgSrscz/IEPjoDoEXxy+QpKuO6Xd9MdOFeI4+45KpBNrbJcHGnkTrpGu2in7oSnkw
 lk02msePqWTlwrseeQMWSq4QY7yjqEJOXntZHU3OPsoiLwL0KzcG6sfkhNZpGTxGyKYD
 sATg==
X-Gm-Message-State: AOJu0Yy/ajfSlm30fzp+9o1GQI3UlNnjr554UmR068wTWguIYp9v9iPi
 kHZ0O/hM2ylCC1NeChyRQXWeOFHyjwUxP4lOzmHWFF6+tcTVW13fbMTQuXDChJft3001I0WC92i
 J+pAqQPwY5K5koUcndc9w9XYYAjfnqmK7pm9PELIWpJn4Es4pR+9eL/48Za01AG4hB1c=
X-Gm-Gg: ASbGnctzhK9mY06+9NgI0ld6KOtRQhoB/LP71k9oOiA/Bqtzxbaxym/A4BoK2p6SL0+
 j6ymRmblaOBZdUZLhyNNUn+rs5mcPXhCS9MKtl6k5LzGvS0EDkEMAtzHKBG27wydd1bR0QUIlN2
 /EICtq1TpoFv6x7iGT/WhUVX1R4ksPIncLNzDFftvW7dQxyo0EeIUaHKpOGF4b6G9OvschwFIBu
 KSQXLI8YhrpbNR4+KFEA0W1lfU9za8S5Sz5Gd5MW8+K/AXxL9nWPd4L+DLa/TfsA3fV1E47XEEO
 pHcLzzvh4aAMrLW5KViagz11QsAkSA==
X-Received: by 2002:a05:6000:1ac8:b0:3e7:5f26:f1d3 with SMTP id
 ffacd0b85a97d-3ee7df1d066mr8763728f8f.17.1758540384711; 
 Mon, 22 Sep 2025 04:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzSOQ5P6pZgj8Zv+cITylxz0seMLqAoLYjiQcaTG/tOfRh1VNIzMzhzgeqiOr7sB8SjVWmcA==
X-Received: by 2002:a05:6000:1ac8:b0:3e7:5f26:f1d3 with SMTP id
 ffacd0b85a97d-3ee7df1d066mr8763709f8f.17.1758540384291; 
 Mon, 22 Sep 2025 04:26:24 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dea20f833sm20216735e9.10.2025.09.22.04.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:26:23 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:26:21 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] migration: Accept MigrationStatus in
 migration_has_failed()
Message-ID: <x56ogh3oypa6yadyngppn4lgc7zda6vo6raw4j7z6zpbmoqeem@zextrdytcm2a>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-3-jmarcin@redhat.com>
 <aM1vSZcXY08tfMpM@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM1vSZcXY08tfMpM@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On 2025-09-19 10:57, Peter Xu wrote:
> On Mon, Sep 15, 2025 at 01:59:13PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > This allows to reuse the helper also with MigrationIncomingState.
> 
> I get the point, but just to mention that this helper doesn't really change
> much on incoming side on simplifying the code or function-wise, because we
> don't have CANCELLING/CANCELLED state on deste QEMU.. which is definitely
> not obvious.. :(
> 
> So:
> 
>   migration_has_failed(incoming->state)
> 
> Is exactly the same as:
> 
>   incoming->state == MIGRATION_STATUS_FAILED
> 
> Except it will make src start to pass in s->state.. which is slightly more
> awkward.
> 
> Maybe we keep the MIGRATION_STATUS_FAILED check in your next patch, and
> drop this one for now until it grows more than FAILED on dest?

Sure, that sounds like a good solution.

> 
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  migration/migration.c | 8 ++++----
> >  migration/migration.h | 2 +-
> >  migration/multifd.c   | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 54dac3db88..2c0b3a7229 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1542,7 +1542,7 @@ static void migration_cleanup(MigrationState *s)
> >          /* It is used on info migrate.  We can't free it */
> >          error_report_err(error_copy(s->error));
> >      }
> > -    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
> > +    type = migration_has_failed(s->state) ? MIG_EVENT_PRECOPY_FAILED :
> >                                       MIG_EVENT_PRECOPY_DONE;
> >      migration_call_notifiers(s, type, NULL);
> >      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> > @@ -1700,10 +1700,10 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> >      return ret;
> >  }
> >  
> > -bool migration_has_failed(MigrationState *s)
> > +bool migration_has_failed(MigrationStatus state)
> >  {
> > -    return (s->state == MIGRATION_STATUS_CANCELLED ||
> > -            s->state == MIGRATION_STATUS_FAILED);
> > +    return (state == MIGRATION_STATUS_CANCELLED ||
> > +            state == MIGRATION_STATUS_FAILED);
> >  }
> >  
> >  bool migration_in_postcopy(void)
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 01329bf824..2c2331f40d 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -535,7 +535,7 @@ bool migration_is_blocked(Error **errp);
> >  bool migration_in_postcopy(void);
> >  bool migration_postcopy_is_alive(MigrationStatus state);
> >  MigrationState *migrate_get_current(void);
> > -bool migration_has_failed(MigrationState *);
> > +bool migration_has_failed(MigrationStatus state);
> >  bool migrate_mode_is_cpr(MigrationState *);
> >  
> >  uint64_t ram_get_total_transferred_pages(void);
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index b255778855..c569f91f2c 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -568,7 +568,7 @@ void multifd_send_shutdown(void)
> >               * already failed. If the migration succeeded, errors are
> >               * not expected but there's no need to kill the source.
> >               */
> > -            if (local_err && !migration_has_failed(migrate_get_current())) {
> > +            if (local_err && !migration_has_failed(migrate_get_current()->state)) {
> >                  warn_report(
> >                      "multifd_send_%d: Failed to terminate TLS connection: %s",
> >                      p->id, error_get_pretty(local_err));
> > -- 
> > 2.51.0
> > 
> 
> -- 
> Peter Xu
> 


