Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21625CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0jDy-00063y-KJ; Mon, 22 Sep 2025 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v0jDv-00061z-3O
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v0jDn-0007wo-CW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758557816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYWOQn0OAAdLKYLI3DFBgh+6xUtuUc4Oeca5At2UJ1E=;
 b=U54dmNYyEGUpxMUR0qRlM9khVUynOpc3hrlZNtxXkyTwfVK670N0jl4AHlvpTrWH0LTcD5
 VuXmoCeGgoOqS+k9L4GGqM9HteYhxUoixfnXHL+QakuFg7XGSAKNMrdoh5IA4c4LK95Xf+
 9taEMSucVj0aBC1cK7RoLWbzXqotzQs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-YpzSZTHwP6CoY0yIuLv0KQ-1; Mon, 22 Sep 2025 12:16:55 -0400
X-MC-Unique: YpzSZTHwP6CoY0yIuLv0KQ-1
X-Mimecast-MFC-AGG-ID: YpzSZTHwP6CoY0yIuLv0KQ_1758557815
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8500faee0c5so59241785a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 09:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758557814; x=1759162614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYWOQn0OAAdLKYLI3DFBgh+6xUtuUc4Oeca5At2UJ1E=;
 b=uzPHgdI5tHrn3WDkQKHGDt4aRRTOei+8i0qOJjVgNZziH4rDzCo8ikqglusLL19/03
 qeL+OiUR3KzCcupa7mrlaRMn45wScUHZZcghHFsrGNlk7KFSKQBM+1zhdzsGh+EAqpw5
 GENqtRPsnrSdlwTTjL23VfNCwKnDRANIiQLiNiwkfAnPAA9ZLQXSFigUEpGpQuCO8mII
 /EZnM7x1dZPbi3VZLmFrIw1CMEM+SNx1Vb9mp29pcaPq6pF+dg8xpM1FZuXblLRCOuF5
 DElAPZwU+lMQ5CP3tVW4iWbLWtkzvYB4xUzZGibUMjMXs5iBTkYxHgfTLZ94L+kgOAry
 Jcbg==
X-Gm-Message-State: AOJu0Yx3u3BT8qwylkWG8NaImdTHPb16EUSP0H8v9wlB0vFa5U20WVgF
 BNbjqhIzTHAYa8Tqf9xSrvt3dBGhozvfeIvPLw4Xs8tgbfZhnBZzDh0IL7WD56gA6BNLSw+Z20d
 2gXaYOl1SonkHN7Ukv3a5IQsf3KOsGh/rjBqMyHxvL3SeOW9le+icGR4E
X-Gm-Gg: ASbGnctpZbLs3ER4PAr41vq2ypZZ/f0HWuy/nWVl+E/j/XNNEvR9DywRpnfBYap2YHC
 2crkUH20jwoeJTrZ8ra0KcWuxVQobYTr4R6lCz8uS4Pl+ATif2gp2SP1PWUy8+X9oehCqr+1+3K
 RXNDyddA2WoG8ecJ8fNZda9sxdfufc0C4jU4dBi7Vq9WreqVYr9jkpr2jHvZ6MTYU25/d6jajDL
 SQepab1hxy/PHxD9loTvUzXdTYLhM6aekegyDLbgh4ssX2I6t526i+ErgO2uGNgaGCN6JJIcUqi
 WoSZOyf4AxAIfA0/y7aovzdSuLCd2vj0
X-Received: by 2002:a05:620a:4152:b0:84d:9f49:6898 with SMTP id
 af79cd13be357-84d9f49694cmr254634585a.61.1758557814343; 
 Mon, 22 Sep 2025 09:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrnYY8E9XZPz7WeiJgD9P6sPypVBzSDtTaIToL/HZXS+uZ7kyb+fu4h3L6kWIm6LFfRPuTnw==
X-Received: by 2002:a05:620a:4152:b0:84d:9f49:6898 with SMTP id
 af79cd13be357-84d9f49694cmr254626785a.61.1758557813622; 
 Mon, 22 Sep 2025 09:16:53 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83631a7fc2fsm814163185a.54.2025.09.22.09.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 09:16:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:16:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aNF2dNdWNRaFCHMy@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aM2LoGDh5WsVnEi8@x1.local> <aM2X-N9gXvFxxdvI@x1.local>
 <oy3kx54pezowk65jvt2vagz7c22g26k3fbu4byzsxtc4wvbgo3@uwzuuysbedzb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oy3kx54pezowk65jvt2vagz7c22g26k3fbu4byzsxtc4wvbgo3@uwzuuysbedzb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 03:34:19PM +0200, Juraj Marcin wrote:
> Hi Peter,
> 
> On 2025-09-19 13:50, Peter Xu wrote:
> > On Fri, Sep 19, 2025 at 12:58:08PM -0400, Peter Xu wrote:
> > > > @@ -2564,6 +2569,11 @@ static void *source_return_path_thread(void *opaque)
> > > >              tmp32 = ldl_be_p(buf);
> > > >              trace_source_return_path_thread_pong(tmp32);
> > > >              qemu_sem_post(&ms->rp_state.rp_pong_acks);
> > > > +            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
> > > > +                trace_source_return_path_thread_dst_started();
> > > > +                migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> > > > +                                  MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > > 
> > > Could this race with the migration thread modifying the state concurrently?
> > > 
> > > To avoid it, we could have a bool, set it here once, and in the iterations
> > > do something like:
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 10c216d25d..55230e10ee 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -3449,6 +3449,16 @@ static MigIterateState migration_iteration_run(MigrationState *s)
> > >      trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
> > >  
> > >      if (in_postcopy) {
> > > +        if (s->postcopy_package_loaded) {
> > > +            assert(s->state == MIGRATION_STATUS_POSTCOPY_DEVICE);
> > > +            migrate_set_state(s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> > > +                              MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > > +            /*
> > > +             * Since postcopy cannot be re-initiated, this flag will only
> > > +             * be set at most once for QEMU's whole lifecyce.
> > > +             */
> > > +            s->postcopy_package_loaded = false;
> > > +        }
> > >          /*
> > >           * Iterate in postcopy until all pending data flushed.  Note that
> > >           * postcopy completion doesn't rely on can_switchover, because when
> 
> It was there in the RFC version, when there was mutual handshake before
> dst starting, but I thought cmp&exchange would be enough. I can add it
> again, however, there is no need to set it to false afterwards, we can
> simply check if this condition is true:
> s->postcopy_package_loaded && s->state == MIGRATION_STATUS_POSTCOPY_DEVICE.

Setting it to false was a safety measure.  Indeed not needed, but when so
we need to be extremely careful to always check with above two conditions
to avoid it frequently triggers.  So I thought clearing it would be much
easier to read.  I can wait and read the new version whatever you prefer.

> 
> > 
> > [...]
> > 
> > > > @@ -2871,7 +2882,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> > > >  
> > > >      /* Now, switchover looks all fine, switching to postcopy-active */
> > > >      migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
> > > > -                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > > > +                      MIGRATION_STATUS_POSTCOPY_DEVICE);
> > > >  
> > > >      bql_unlock();
> > > >  
> > > > @@ -3035,7 +3046,8 @@ static void migration_completion(MigrationState *s)
> > > >  
> > > >      if (s->state == MIGRATION_STATUS_ACTIVE) {
> > > >          ret = migration_completion_precopy(s);
> > > > -    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > > > +    } else if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
> > > > +               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > > 
> > > Exactly.  We need to be prepared that src sending too fast so when device
> > > loading on dest we finished.
> > 
> > One thing more to mention here.. which may void some previous comments I
> > left.  Let's discuss.
> > 
> > I think it may also make sense to only allow a COMPLETE after
> > POSTCOPY_ACTIVE.
> > 
> > That is, if src sends too fast to have finished sending everything,
> > reaching COMPLETE during POSTCOPY_DEVICE, that is, while before it receives
> > the new PONG you defined, then.. I _think_ it is better to wait for that.
> > 
> > If it finally arrives, then it's perfect, we switch to POSTCOPY_ACTIVE,
> > then continue the completion.
> > 
> > If the channel is broken before its arrival, logically we should handle
> > this case as a FAILURE and restart the VM on src.
> > 
> > It's only relevant in a corner case, but does that sound better?
> 
> Yes, it does make sense to wait for POSTCOPY_ACTIVE as src could finish
> before dst finished package load and could still fail. We could use a
> qemu_event_wait() to wait and set the event in src return path thread
> when the PONG is received.

Right.

Though since we want to move to POSTCOPY_ACTIVE asap when receiving the
corresponding PONG, we may want to have something like qemu_event_read()
just return "ev->value == EV_SET", as we can't event_wait() in the
migration thread while pushing RAMs.

Or, to avoid touching library code, we can also introduce yet another bool,
then when receiving the PONG we set both (1) the bool, and (2) the event.
We can check the bool in the iterations (when set, wait() to consume the
event; the event should have happened or just to happen), and wait() on the
event when completing (when return, bool must have been set, hence can
reset bool).

-- 
Peter Xu


