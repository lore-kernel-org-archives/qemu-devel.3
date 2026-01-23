Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419F7D74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIcB-0004Qz-En; Fri, 23 Jan 2026 09:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vjIc9-0004ON-3u
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vjIc6-0007rs-Va
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769180296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0A2r04mGgySsdu0VVAiYh5kUP3A3RivRpKS+DVUacgk=;
 b=d7NU/qsrjziL5evRNjnmgwiyUO4/YIaKw3IePPqlALp9xUgmoPGGhzNRLG8LHPTjQJR8dy
 Xlz0dY8HDvTQ9DHJEX3OFy3ZO7fSyGeQzl5Jt/XVx6B3gLnK+9iZ8n1XX+6Pk39ZM2pWsy
 NpFvh4C+/4vLbjWQpBBYe3OCOOZ+x+8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-LLsVYSLgP0GL2uG-9dAHSw-1; Fri, 23 Jan 2026 09:58:15 -0500
X-MC-Unique: LLsVYSLgP0GL2uG-9dAHSw-1
X-Mimecast-MFC-AGG-ID: LLsVYSLgP0GL2uG-9dAHSw_1769180294
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c52c921886so258220585a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769180294; x=1769785094; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0A2r04mGgySsdu0VVAiYh5kUP3A3RivRpKS+DVUacgk=;
 b=JlkO9UYI39cthld3wxVEUNbzdKSwRyDpEFJ7N+W8R95f07hJ2Us3xcHlFXQq4OfH0x
 ypxecnNW+dEvqlB4lCYLxvPErTYw7RkyY5pS5ZS67zgYKWGzvV/ZhUK8uGELwyGaUCHv
 cLPG8CycyitE/UTagCiUIvUsNdBjt/3ZbuP/Sggcte19IwNFay+cLZcu5QewGIeL/AG6
 U6huPRO6I8NdknyLjUGq/HtRWJDEqimPAN60HV2F/hFjxSg5Gx0ijdCHbMUC7jBux2Sr
 2CYi6ZCLHAH38oPVtwRdddsm+REypogFZCekzoPsEYA5ESeY02YlRfVmQBs+5iFRp/uu
 bBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180294; x=1769785094;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0A2r04mGgySsdu0VVAiYh5kUP3A3RivRpKS+DVUacgk=;
 b=Yj6NUqiw4gORNVdcBfFD0euwi3bT8tBDMI4/BT74ffnZOrc06VJaC5eXiAqOW45Ofc
 0XI4rjmJ7wPxFCxoCGhLl1jl0/PqiymWc6kIy/0w+aN5dSWziiIcirUyEsDYJOEmJZM/
 h1W6p8jYf6lxBd9aB831S0tWTRr0ZXgSsZLCPT97441vewiLo4qkvk7Azum6OfSK4g1G
 UU97jdybKdN9jeNFh8Ydk52/0Ycu1p1Ion6p82XWo7qdDzI8/5OvWRQlQLig17H49erK
 a+OfgtVBcqz2l7DfnAZz40R5x5ADr/I5LPSsKhCKoWtIbeij2WLyfeYpEkWPxlVUI5g8
 zzwA==
X-Gm-Message-State: AOJu0YzncqYhQambsM3Mn8349Re+PuNs4oHI77UKnhdnPijInmb/63HZ
 TCZNG0KIIVUmNG4womXpzY3P/98zk35YBZgvAZ7pWIQfeJmQ/vsl4ic0v/TjxpeG39cNZ5mtK71
 bDqOgVwb1370r3Sml7ygf2+v1OcaN9Q0Rto5IOk36DaNuJipu1FXQT1HT
X-Gm-Gg: AZuq6aIwsgrvF1Rcuu9v3WM/mMg+STx6xbGAmQFn5jPM74pQTDU/ah9gYzN5uOA9H79
 ZYbJTj/fSSXIJYfkAXmQ98lZs5YxZguYqXXwVEkIosvfRBpvIKJm8z9chhu9axWooEtaReyojzJ
 QYmazzP3N6rss45FwI5Da5F4Ht00pfwE9z/sxetLksnL8U//GPoIwQEEqxASr4OqK+IN9sr4E1n
 Do88ON2Jn7PNuOnJklL5V87BrlKxFPJ8yVE6+4MtoDI5dwF0tNzEsCFANm8yajQwZ1kGK98Jtrt
 jMP67FWGwwKU0gbhtVTkgsfMZgOhKo1/xmpB6jS+RyUfZyNoeiPjw57rqTiM6AiRXE7wXaCkTEY
 IdWA=
X-Received: by 2002:a05:620a:2990:b0:8c6:a487:6add with SMTP id
 af79cd13be357-8c6e2d96222mr396160485a.22.1769180294229; 
 Fri, 23 Jan 2026 06:58:14 -0800 (PST)
X-Received: by 2002:a05:620a:2990:b0:8c6:a487:6add with SMTP id
 af79cd13be357-8c6e2d96222mr396157485a.22.1769180293622; 
 Fri, 23 Jan 2026 06:58:13 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37c823bsm199075785a.2.2026.01.23.06.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:58:13 -0800 (PST)
Date: Fri, 23 Jan 2026 09:58:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 2/5] migration: Fix double notification of DONE/FAIL for
 postcopy
Message-ID: <aXOMhI2tP8IK6juv@x1.local>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-3-peterx@redhat.com>
 <87a4y4jxtc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4y4jxtc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 23, 2026 at 09:52:31AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Migration notifiers will notify at any of three places: (1) SETUP
> > phase, (2) migration completes, (3) migration fails.
> >
> > There's actually a special case for spice: one can refer to
> > b82fc321bf ("Postcopy+spice: Pass spice migration data earlier").  It
> > doesn't need another 4th event because in commit 9d9babf78d ("migration:
> > MigrationEvent for notifiers") we merged it together with the DONE event.
> >
> > The merge makes some sense if we treat "switchover" of postcopy as "DONE",
> > however that also means for postcopy we'll notify DONE twice..  The other
> > one at the end of postcopy when migration_cleanup().
> >
> > In reality, the current code base will also notify FAILED for postcopy
> > twice.  It's because an (maybe accidental) change in commit
> > 4af667f87c ("migration: notifier error checking").
> >
> > First of all, we still need that notification when switchover as stated in
> > Dave's commit, however that's only needed for spice.  To fix it, introduce
> > POSTCOPY_START event to differenciate it from DONE.  Use that instead in
> > postcopy_start().  Then spice will need to capture this event too.
> >
> > Then we remove the extra FAILED notification in postcopy_start().
> >
> > If one wonder if other DONE users should also monitor POSTCOPY_START
> > event.. We have two more DONE users:
> >
> >   - kvm_arm_gicv3_notifier
> >   - cpr_exec_notifier
> >
> > Both of them do not need a notification for POSTCOPY_START, but only when
> > migration completed.  Actually, both of them are used in CPR, which doesn't
> > support postcopy.
> >
> > I didn't attach Fixes: because I am not aware of any real bug on such
> > double reporting.  I'm wildly guessing the 2nd notify might be silently
> > ignored in many cases.  However this is still worth fixing.
> >
> > Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/misc.h | 1 +
> >  migration/migration.c    | 3 +--
> >  ui/spice-core.c          | 3 ++-
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > index e26d418a6e..b002466e10 100644
> > --- a/include/migration/misc.h
> > +++ b/include/migration/misc.h
> > @@ -63,6 +63,7 @@ typedef enum MigrationEventType {
> >      MIG_EVENT_PRECOPY_SETUP,
> >      MIG_EVENT_PRECOPY_DONE,
> >      MIG_EVENT_PRECOPY_FAILED,
> > +    MIG_EVENT_POSTCOPY_START,
> >      MIG_EVENT_MAX
> >  } MigrationEventType;
> 
> With the new state there's a doc text to update at
> migration_add_notifier below.

Yeh I noticed it, I didn't do it as I found POSTCOPY_START is special in
this case marking an optional phase for postcopy-only.

I can still update it, though..  Then it'll look like:

   - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_DONE
   - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_FAILED
   - MIG_EVENT_FAILED

I'll also move it above the enum instead if no objections.

-- 
Peter Xu


