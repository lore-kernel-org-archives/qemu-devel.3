Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8FCCAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gge-0002pE-0N; Mon, 22 Sep 2025 09:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v0ggb-0002my-Rp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v0ggZ-0007XZ-3S
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758548068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ui+AOXf92sW2rXVbWMlLz14NmfNtDT5NMim7VGTahuI=;
 b=XD2lzaFYTuamt88fOiNUzx93JEkYrXe7UWP98Ao5Bj9n5PrS04XzEGuYYQHT+M03RdKgGs
 YWlwHRfaIM+084GoE1M5NIvp3Pk/IdfpzlyL5gVWPOSz4hNlHikPPzvfcp+NqH3cTajtvb
 3ygFpTJEOUrYxacPbr5vPBtArA+tJSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-p8hLapiSOpi3aV5P5QEahg-1; Mon, 22 Sep 2025 09:34:25 -0400
X-MC-Unique: p8hLapiSOpi3aV5P5QEahg-1
X-Mimecast-MFC-AGG-ID: p8hLapiSOpi3aV5P5QEahg_1758548065
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45e037fd142so40495985e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758548065; x=1759152865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ui+AOXf92sW2rXVbWMlLz14NmfNtDT5NMim7VGTahuI=;
 b=W9cz/frh0rIH0AtoNWV3fM6jXZ6AB8hPaNglNi8fmn1Pplntzca9jgKbsUFguZBRhB
 yUnrFBNK6ch8/1aFG/QRlPYjq67qDwDgdiA/KEtO9jWIGETYmjqAaadQ0Mnf0c+QptJC
 exj+KJVZviF8ErNTHZIfAGAbb0XgUSPs+W0p8ns9HsCVmIPJ723jnW6RnglwHYfkoNeV
 zs7gvv6H+3mB72hzh2O3Jh6hU2VueCTtao2zAgYSxgPZDuecLLhtM4u7qKPhTEvSAt7m
 YkhuxUwFCJ6wYCPRCbsENDVRgbY7kUwkduTteHqP+HJ7e3/ym3LWhJDMUpBIvyh+QaTu
 JHsQ==
X-Gm-Message-State: AOJu0YzUKuW6egjh1a+pB7fTGhmZbeCvsQWSxB0PE+/BQLuv/nwydMEo
 r2eDpf60QMznJ4li0JPt2+nHfF8x2zrGynB0/a6YJ+pNW4+EBxRTgdRo81q5lPvp39vwLZSCA7C
 5cK9p6gw8pXNNSj9yqt9+PWnfy5BI9+TWBNkb1nzWlsksc+VDMJ1R+xqr
X-Gm-Gg: ASbGnctoIGx/FAjYuw9uM/xDVQ05DBPLH5a2i4lE1TWLgJt1/kmgN2XFD40A3LoOqCV
 C+H5RtZp/Bwy5Zs+rEr66XfiLIl1Q4kr65u/6ZWVm1PljoZnDpEV+KNY5PqFGCz05vPmbtb23gz
 Uvj+Fjzhv0CrLdDoYZQn+P1K3F5km9ANhg4KHrP59l7jUE8IvLR15eyUmvhux6cbmYzsmVz/X8k
 S0lNfIbyLsaPu3D3S3e0G3sBD82Dh7cYpg98ctmHS/a64BrVVbHGUg2q9/QVgHL1KIOkTgI4d3O
 KXlyGAfMfQgE+tdrr6qbjpjkwYdmmA==
X-Received: by 2002:a05:600c:450b:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-467eaa86fddmr130524835e9.31.1758548064629; 
 Mon, 22 Sep 2025 06:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8CWJhjliRxokv6gsAkTr88hfo6EKBvomkHnH7dzf+i+tkrXkVOt5B2Jxxiokkq3zan4ru6Q==
X-Received: by 2002:a05:600c:450b:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-467eaa86fddmr130524515e9.31.1758548064108; 
 Mon, 22 Sep 2025 06:34:24 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fb8ebb0d91sm6627819f8f.54.2025.09.22.06.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:34:22 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:34:19 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <oy3kx54pezowk65jvt2vagz7c22g26k3fbu4byzsxtc4wvbgo3@uwzuuysbedzb>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aM2LoGDh5WsVnEi8@x1.local> <aM2X-N9gXvFxxdvI@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM2X-N9gXvFxxdvI@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
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

Hi Peter,

On 2025-09-19 13:50, Peter Xu wrote:
> On Fri, Sep 19, 2025 at 12:58:08PM -0400, Peter Xu wrote:
> > > @@ -2564,6 +2569,11 @@ static void *source_return_path_thread(void *opaque)
> > >              tmp32 = ldl_be_p(buf);
> > >              trace_source_return_path_thread_pong(tmp32);
> > >              qemu_sem_post(&ms->rp_state.rp_pong_acks);
> > > +            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
> > > +                trace_source_return_path_thread_dst_started();
> > > +                migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> > > +                                  MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > 
> > Could this race with the migration thread modifying the state concurrently?
> > 
> > To avoid it, we could have a bool, set it here once, and in the iterations
> > do something like:
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25d..55230e10ee 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3449,6 +3449,16 @@ static MigIterateState migration_iteration_run(MigrationState *s)
> >      trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
> >  
> >      if (in_postcopy) {
> > +        if (s->postcopy_package_loaded) {
> > +            assert(s->state == MIGRATION_STATUS_POSTCOPY_DEVICE);
> > +            migrate_set_state(s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> > +                              MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > +            /*
> > +             * Since postcopy cannot be re-initiated, this flag will only
> > +             * be set at most once for QEMU's whole lifecyce.
> > +             */
> > +            s->postcopy_package_loaded = false;
> > +        }
> >          /*
> >           * Iterate in postcopy until all pending data flushed.  Note that
> >           * postcopy completion doesn't rely on can_switchover, because when

It was there in the RFC version, when there was mutual handshake before
dst starting, but I thought cmp&exchange would be enough. I can add it
again, however, there is no need to set it to false afterwards, we can
simply check if this condition is true:
s->postcopy_package_loaded && s->state == MIGRATION_STATUS_POSTCOPY_DEVICE.

> 
> [...]
> 
> > > @@ -2871,7 +2882,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> > >  
> > >      /* Now, switchover looks all fine, switching to postcopy-active */
> > >      migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
> > > -                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > > +                      MIGRATION_STATUS_POSTCOPY_DEVICE);
> > >  
> > >      bql_unlock();
> > >  
> > > @@ -3035,7 +3046,8 @@ static void migration_completion(MigrationState *s)
> > >  
> > >      if (s->state == MIGRATION_STATUS_ACTIVE) {
> > >          ret = migration_completion_precopy(s);
> > > -    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > > +    } else if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
> > > +               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > 
> > Exactly.  We need to be prepared that src sending too fast so when device
> > loading on dest we finished.
> 
> One thing more to mention here.. which may void some previous comments I
> left.  Let's discuss.
> 
> I think it may also make sense to only allow a COMPLETE after
> POSTCOPY_ACTIVE.
> 
> That is, if src sends too fast to have finished sending everything,
> reaching COMPLETE during POSTCOPY_DEVICE, that is, while before it receives
> the new PONG you defined, then.. I _think_ it is better to wait for that.
> 
> If it finally arrives, then it's perfect, we switch to POSTCOPY_ACTIVE,
> then continue the completion.
> 
> If the channel is broken before its arrival, logically we should handle
> this case as a FAILURE and restart the VM on src.
> 
> It's only relevant in a corner case, but does that sound better?

Yes, it does make sense to wait for POSTCOPY_ACTIVE as src could finish
before dst finished package load and could still fail. We could use a
qemu_event_wait() to wait and set the event in src return path thread
when the PONG is received.

> 
> -- 
> Peter Xu
> 


