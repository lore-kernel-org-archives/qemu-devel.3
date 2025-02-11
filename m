Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB83C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 19:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwAG-0007oD-Kp; Tue, 11 Feb 2025 14:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwAF-0007o1-EF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:43:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwAD-00054F-AX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739302999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+FRiz0vFBBQFWvGSWvQmpATQqfAnoP/gg11H3yIdRBs=;
 b=BKuKBL6sfL87158tmlpgsJquVMb7IhKnzX0v65PbX+vFHIH/HCcubSVE7cQYl8rv4DDs+F
 ucngwx1nP5DVm8p02U0HqtKVvHJ+vu7Xxjp7PKrEUcgU7vSg4UdgbunPkBtKDnkcm54Kpf
 WQfvH8SDaAEi7XGg7j0YFaZ/5ciKiok=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-okLYjoOLP22kjn2EhxQeRw-1; Tue, 11 Feb 2025 14:43:15 -0500
X-MC-Unique: okLYjoOLP22kjn2EhxQeRw-1
X-Mimecast-MFC-AGG-ID: okLYjoOLP22kjn2EhxQeRw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c057344597so17808285a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 11:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739302995; x=1739907795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FRiz0vFBBQFWvGSWvQmpATQqfAnoP/gg11H3yIdRBs=;
 b=jz/MZBTaw2EsU1kvoo8TwqRSFIZ+tjtImhyQz/7z2v0YB1iY2R9jdjTNkbHBHY3O1W
 3FFLLNmeoRQfRri2SfSCVwGWeOJd8ZsOq2n/b08wY4UcRk7V+5AkNRKGBjTUkuR+TTFW
 zFEEHDajO40DOl6e3+MC/n2+AcsB6pNv2ZEneqHaSZ1lUacVHY0/R8xRuLGU2PsJnrGQ
 bf+Fko/AmEJvOuWrPwgOwzotky5IWNqs/Oih9dKxbB7wnV7NQItbjT5YwSlWLGBDbCFd
 0pbAEsdHACee9HUE/n2UfO6ZLhb8TKEBi1XTUhaxnRkFZqdVR5XBbV4TeiIonyuupvMo
 rHcQ==
X-Gm-Message-State: AOJu0YyXwDmfEVR5V91t73hRsOSPr1AZm/ZVRa+WrzIpbB7/P8xMSCX+
 368PXAW2LDTZ/+/yIWL7SaW4I2TBgSCHPbAEA3ux/c5+jWU09qKEZTqOAV+1+bFySyxXuxk3/Nk
 KNAaHJZ5JDP+rBT/vXbq2AiJ6mkdPUITa5RO1VfFjPjxvd2NVjskz
X-Gm-Gg: ASbGncsldEdZ2jM82xy2FwYN5PCcW05WEoCi20Ki4tf8P11uJ82yHvH/KeYFC3UhdtX
 oeoPi+z3g5CBoWTgEQH09Hjzauq1wAFHgARJbUf+1lntjHgaU6s7MQclNUGV5p19QrPx9yXXW1f
 QadGh2UgXCOURZKDA52QMD/TVdluknVh/8Ck8yGnzMI/58o09K3VwvQBhkI/PZgC2KpHlkfjIsp
 lOl2EXffDhkXC87aBqId/miraq1CFFEnc6BJYdejX7OfoYF2x5SWskclnI=
X-Received: by 2002:a05:620a:288b:b0:7b1:ab32:b71e with SMTP id
 af79cd13be357-7c06ff5a000mr53231685a.0.1739302994980; 
 Tue, 11 Feb 2025 11:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHLvRXVTbZkpKypPzKxPVWIRCivZcQY/Ld9MJ0HtVPaw6Yjmsj8VLvLC2zxNumjeBgmR4mAA==
X-Received: by 2002:a05:620a:288b:b0:7b1:ab32:b71e with SMTP id
 af79cd13be357-7c06ff5a000mr53228185a.0.1739302994622; 
 Tue, 11 Feb 2025 11:43:14 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c04ec3fa82sm470574785a.93.2025.02.11.11.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 11:43:14 -0800 (PST)
Date: Tue, 11 Feb 2025 14:43:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 6/9] migration: Don't set FAILED state when cancelling
Message-ID: <Z6uoTymcfHcjnrtf@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-7-farosas@suse.de> <Z6uM5TDDGb5FkVqf@x1.local>
 <87wmdwuzm2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmdwuzm2.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 11, 2025 at 03:04:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Feb 11, 2025 at 12:01:33PM -0300, Fabiano Rosas wrote:
> >> It's possible that the migration is cancelled during
> >> migration_switchover_start(). In that case, don't set the migration
> >> state FAILED in migration_completion().
> >> 
> >> Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > I remember I paid some attention on this one when working on the commit,
> > where it has:
> >
> > static bool migration_switchover_prepare(MigrationState *s)
> > {
> >     /* Concurrent cancellation?  Quit */
> >     if (s->state == MIGRATION_STATUS_CANCELLING) {   <================= [1]
> >         return false;
> >     }
> >     ...
> >     bql_unlock();
> >
> >     qemu_sem_wait(&s->pause_sem);
> >
> >     bql_lock();
> >     /*
> >      * After BQL released and retaken, the state can be CANCELLING if it
> >      * happend during sem_wait().. Only change the state if it's still
> >      * pre-switchover.
> >      */
> >     migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER, <====== [2]
> >                       MIGRATION_STATUS_DEVICE);
> >
> >     return s->state == MIGRATION_STATUS_DEVICE;
> > }
> >
> > So when holding BQL logically it can't change to CANCELLING, it'll check
> > first [1] making sure no prior CANCELLING.  Then after release and retake
> > BQL it'll check again [2] (see the comment above [2], it's done by passing
> > in explicit old_state to not change it if it's CANCELLING).
> 
> Right, it doesn't change the state. But the function returns false and
> someone else changes to FAILED. That's what both my patch and your
> snippet below fix.
> 
> >
> > Any hint on how this could be triggered?
> >
> > OTOH, when looking at this.. I seem to have found a bug indeed (which could
> > be another?), where I may have forgot to touch up the old_state in
> > migrate_set_state() after switching to always use DEVICE..
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 74c50cc72c..513e5955cc 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2793,8 +2793,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> >  fail_closefb:
> >      qemu_fclose(fb);
> >  fail:
> > -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > -                          MIGRATION_STATUS_FAILED);
> > +    if (ms->state != MIGRATION_STATUS_CANCELLING) {
> > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> > +    }
> 
> Now that I think about it, we should probably just use the skip at
> migrate_set_state() always. Isn't this^ the same as:
> 
> migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
> MIGRATION_STATUS_FAILED);
> 
> Better to list the state explicitly, no?

There's one case where it can be in ACTIVE rather than DEVICE,
unfortunately:

    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
    if (ret < 0) {
        error_setg_errno(errp, -ret, "%s: Failed to stop the VM", __func__);
        goto fail;
    }

> 
> Or... do we want to incorporate this into migrate_set_state()?
> 
> void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                        MigrationStatus new_state)
> {
>     assert(new_state < MIGRATION_STATUS__MAX);
> 
>     if (qatomic_read(state) == CANCELLING && new_state != CANCELLED) {
>         /* Once it's cancelling, there's no way back, it must finish cancel */
>         return;
>     }
> 
>     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
>         trace_migrate_set_state(MigrationStatus_str(new_state));
>         migrate_generate_event(new_state);
>     }
> }

IMHO we'll need the original migrate_set_state() more or less, e.g. when
setting CANCELLING->CANCELLED in migration_[fd_]cleanup().  So maybe it's
slightly easier we keep it.

Said that, maybe we could have a few helpers for the state transitions,
like:

  migrate_set_state_failure(MigrationState *s)

Which can consider CANCELLING.

Also, we have a portion of such state transitions not caring about current
state, so we could also have some helper for that, like:

  migrate_set_state_always(MigrationState *s, MigrationStatus status)

Or rename old migrate_set_state() into migrate_set_state_atomic(), then
make migrate_set_state() to ignore current state.

> 
> >      migration_block_activate(NULL);
> >      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
> >      bql_unlock();
> >
> > I'm not sure whether it's relevant to what you hit, though.. since you're
> > looking at this, I'd rely on you help figuring it out before I do.. :)
> >
> >> ---
> >>  migration/migration.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 375de6d460..5dc43bcdc0 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -2986,7 +2986,9 @@ fail:
> >>          error_free(local_err);
> >>      }
> >>  
> >> -    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> >> +    if (s->state != MIGRATION_STATUS_CANCELLING) {
> >> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> >> +    }
> >>  }
> >>  
> >>  /**
> >> -- 
> >> 2.35.3
> >> 
> 

-- 
Peter Xu


