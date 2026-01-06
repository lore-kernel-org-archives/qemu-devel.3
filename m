Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241F4CE9D46
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd8gQ-00053E-1g; Tue, 06 Jan 2026 10:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vd8gL-00052m-QJ
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:09:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vd8gI-0001Ps-BK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767712148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrSwysaoKjRrChvVhXeVHkuJCC81jdU1vkBJVfDedM0=;
 b=A2qw1nNrifFql7hkOnyLosWrdBzQbQpzFDkjuS5Zg4msZS2XtBUJXp9evGAkqHdEnYSwcW
 UskuFlwZvs04uNutTZDptQMVVF4K0TQl9oDhqF2oaZUdbNT5q4nCRgEtiQiR5wW52tIy8n
 FBAjx/CLEg6mebOdmKfQV+/KfYkgBV4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-3qk2HKKrOta37LXRZfzMrQ-1; Tue, 06 Jan 2026 10:09:06 -0500
X-MC-Unique: 3qk2HKKrOta37LXRZfzMrQ-1
X-Mimecast-MFC-AGG-ID: 3qk2HKKrOta37LXRZfzMrQ_1767712146
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e235d4d2so421697485a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767712146; x=1768316946; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xrSwysaoKjRrChvVhXeVHkuJCC81jdU1vkBJVfDedM0=;
 b=ZQjmoEta9qUiEaIGGkr/dzktrfSCRzSI8GCe7ItP9GJMLTRQtpUNfM5AVkFyRSMqbG
 DoWLqJul7t8GUlH+p/e4GEqXTjTpwws7YICPDYXvpmy2AZ41XZhyKq+PmSvZh772JjHl
 Vf+KNP90tb2Rq03q6Vd/togOn1QnQlZl+wh/+LczqsBrQxxmuM/DaHKpZKL5s8dpXl/Q
 MTIA/2iLVzhRNStxNDFx5G1aK5d0OMvf7TVEOi327np0GrbotPiD0RJgzOvPUqyjwpkq
 zy67J+zPK476MYf7eb2kg4QO37oTc2bnO20e9RExVj4yUQnM2wUneWthQu3ABCzbjAPF
 RVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767712146; x=1768316946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrSwysaoKjRrChvVhXeVHkuJCC81jdU1vkBJVfDedM0=;
 b=agIki/r+TQB0aTyJKOvvE8ZoqFwro+nqu3l8GL5lsxhjN1Xu/HtmOvibwvUjvgRn64
 F7ws7dZ3vBiXScv0jyS2KVrdy1myzWL4IXjgzyt8pmkQ/Rc6dOMrWvpvu3/KqPJvBRh3
 spy+Z+EUq88o48/O4mh357iemqCm8iXuwtbqDRVM60uc43ipqmfA511aqCTLZjHh79/O
 0UjcxLjVOFDdX/SOcCiH83wRPOH32fNDkbh2fyetCBjodFj0SRzKwvfmC8KSLUmlP47y
 zPzxN7XekJ6BPXiGOTk6GP3lysSPupTo1S0D6UbR1kwekcQJkSNoLqApDIEOzr7L8+k2
 IZPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0YYvLVuacEFNwxrQj94a752dt1CSSszTiYLFwJOiu4tH/Ba+8meb5aJR00zc6b7z/qlYWdEVU9ITv@nongnu.org
X-Gm-Message-State: AOJu0YzVuMsiyJfsfnEIzjVKwyDE0QBsG7tF27sOIZQx2g1XsJfHkpez
 e1Hj+A9Sr0+6dMSAG+0aClezO6EC8ESA1oy+V1SY6DSJRqB4SewaysiqwVzugO6eZjPJg0D5VNX
 lZLY1zyU2EsF0Qh1xeC/mqh8WX8Y9ZaHVIo5w3aKCy7IQqpMXlDV56dE0
X-Gm-Gg: AY/fxX5kZCt9Le7MEDmwg/F/7YOggCgyxOa94JSCYsDXqVf/PcceEeNMCdh7qBTuDkV
 ozcLMkHFSTWz0sAMz9DheJwodCXAx9K1S27xXRCrO0coPt/PBkwcHT2an6cxYmAZ/nUfwhxcmb6
 N1PMmtX9DU1X7sTsbTjJKueKkYhRogM0iUJ3V1icfv6TAHpuS0JQMu2XuK6j2k3tlPB++uisHAC
 br1mFJwrimr9Xq59ZdLRXWXO0r340ybwLxTY+m3kanIw5H0tbwOTD+apv3bMH2x83juq4tzAd8w
 QMb3EPFVrAG8vLGVbO3+KWj407uW4oExl7vibvan47RRgraW6Cxg651y0arwjsUTtj8KT3njxo9
 K3po=
X-Received: by 2002:a05:620a:7105:b0:8be:e044:8cfa with SMTP id
 af79cd13be357-8c37eb8143fmr451491585a.40.1767712145921; 
 Tue, 06 Jan 2026 07:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXqMF6ohqBu5lKv1ctXyoyDQHjGnhT0bMmVZX6S0LHwaux4hC+x5RHuG0GIy+oVYOXVMPIzQ==
X-Received: by 2002:a05:620a:7105:b0:8be:e044:8cfa with SMTP id
 af79cd13be357-8c37eb8143fmr451482185a.40.1767712145199; 
 Tue, 06 Jan 2026 07:09:05 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f54427esm185918585a.48.2026.01.06.07.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:09:04 -0800 (PST)
Date: Tue, 6 Jan 2026 10:09:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Prasad Pandit <pjp@fedoraproject.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aV0lj8ShJufwRY8z@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 06, 2026 at 05:15:23PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Tue, 23 Dec 2025 at 21:00, Peter Xu <peterx@redhat.com> wrote:
> > One thing good about exposing such status via QAPI is, it can help us
> > diagnose issues by seeing CANCELLING / FAILING even looking at
> > query-migrate results (as normally when bug happens we can't see the
> > internal status..), so that we know either it's explicitly cancelled, or
> > something went wrong.
> >
> > If it's a completely hidden / internal status, we may see ACTIVE even if
> > something wrong happened..
> 
> * Both process state and reason(s) for the state change needs to be
> visible to the user. But states like cancelling/failing are redundant,
> users would derive the same conclusion from CANCELLED and CANCELLING
> OR FAILED AND FAILING. Besides, migration_cleanup() does exactly the
> same steps irrespective of whether migration is failing or cancelling
> or failed or cancelled.
> 
> > My current hope is any mgmt should normally by default ignore new migration
> > states..  If that's always achieved, it looks to me adding FAILING directly
> > into migration status would still have some benefits on debugging.
> 
> * libvirtd(8) complains about unknown states multiple times:
>       libvirtd[2194267]: unknown status 'failing' in migration event
>       libvirtd[2194267]: unknown status 'failing' in migration event
>       libvirtd[2194267]: unknown status 'failing' in migration event

IIUC these are benign warnings, so should be fine. We'll need one entry for
libvirt ultimately to avoid this warning.  Copying Dan and Jiri in case I
am wrong.

> 
> 
> > > > @@ -2907,7 +2914,7 @@ fail_closefb:
> > > >      qemu_fclose(fb);
> > > >  fail:
> > > >      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> > > > -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> > > > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
> > > >      }
> > >
> > > This is a good example where having MigrationStatus makes the code more
> > > complicated. This could be exiting=true, running=false, etc. It
> > > shouldn't matter why this routine failed. If we reach
> > > migration_cleanup() and, at the very end, state is CANCELLING, then we
> > > know the cancel command has caused this and set the state to
> > > CANCELLED. If the state was something else, then it's unintended and we
> > > set FAILED.
> >
> > If it'll be an internal status, we'll still need to identify if someone
> > already have cancelled it, right?
> >
> > Assuming we introduce stop_reason flag, making it:
> >
> > enum {
> >     MIG_STOP_REASON_CANCEL,
> >     MIG_STOP_REASON_FAIL,
> > } MigrationStopReason;
> >
> > Then we can switch to CANCELLED / FAILED when cleanup from those reasons.
> >
> > Then here, logically we also need logic like:
> >
> >     if (stop_reason != MIG_STOP_REASON_CANCEL) {
> >         stop_reason = MIG_STOP_REASON_FAIL;
> >     }
> >
> > Because we want to make sure when the user already triggered cancel, it
> > won't show FAILED but only show CANCELLED at last?
> 
> * I think the way we are setting/changing these states in as many
> locations is only adding to the complications. Do we have to
> explicitly set these states like this? What if migration_cleanup()
> always sets the state to 'STOP'. Similarly other places set the state
> to a predefined state. OR
> ===
>     struct {
>         current_state;
>         old_state;
>         event/trigger;
>         reason[];
>     } MigrationState s;
> 
>     migration_change_state(s) {
>           s->old_state = s->current_state;
>           if (s->current_state == START && s->trigger ==
> 'connections-established') {
>               s->current_state = ACTIVE;
>               s->reason = "connections-established, migration starting"
>           } else if (s->current_state == ACTIVE && s->trigger == 'completed') {
>               s->current_state = STOP
>               s->reason = "migration completed"
>           } else if (s->current_state == ACTIVE  && s->trigger == 'pause') {
>               s->current_state = PAUSE
>               s->reason = "pause, migration paused"
>           } else if (s->current_state == ACTIVE && s->trigger ==
> 'error-occurred') {
>               s->current_state = STOP
>               s->reason = "Error occurred, migration failed"

We can't change status that were already used, like FAILED.  Libvirt and
all mgmt may rely on it.

>           } else if (s->current_state == ACTIVE && s->trigger ==
> 'user-cancel') {
>               s->current_state = STOP
>               s->reason = "user-cancel, migration cancelled"
>          } else {
>               s->current_state = s->current_state;
>               warn_msg("unknown combination, maybe define a new rule?");
>          }
>     }
> ===
> * We define explicit rules for the state change and accordingly we
> only call migration_change_state() at any point and it'll change to an
> appropriate next state, recording the due reason for the change.
> 
> Wdyt...?

Personally I don't see much benefit on adding a new "trigger" internal API.
If we want to forbid some state machine transitions, we can use a
transition map.  Said that, IMHO it's separate from what we're discussing
here.

Thanks,

> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


