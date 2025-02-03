Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF51C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 23:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf5Sw-0003uP-Bt; Mon, 03 Feb 2025 18:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf5Sl-0003tk-F8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 18:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf5SZ-0008Gd-B0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 18:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738623749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAABnQKr/x7DrGJ28M0o2ddxX2cJt65sLXs9fg04kKc=;
 b=cORbE7r+tjdlLE24qdg7DqMQVHSQO7Pchh+otLILX3AN/xbRXuKp3IZy0emp/qgT4akOZz
 q+DB9dH8Jqst9aIs8hl6UiOizZ//i+kcP08xXCenz352eRJR5oKLi4ouiUDpQ+SJnpidZy
 68KsRrTFZdnffKTeVI+DjMm/0X9BMLs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-1VE_g2wWNXWwyy3F4JTubQ-1; Mon, 03 Feb 2025 18:02:27 -0500
X-MC-Unique: 1VE_g2wWNXWwyy3F4JTubQ-1
X-Mimecast-MFC-AGG-ID: 1VE_g2wWNXWwyy3F4JTubQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6ef813ed1so725824885a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 15:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738623747; x=1739228547;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAABnQKr/x7DrGJ28M0o2ddxX2cJt65sLXs9fg04kKc=;
 b=QI3bpkfC5EGnFAQganUNaKy5s1VW0LIQRNbSbn1ElZLAxcd6zSTarBVV5FYPdgN5bC
 PuSzGl3noS6MfpCL/hWJ1XG/mj1rWZ35egupPY2c1ltnzonHUwXHiU4/1+mBnCIfGbf4
 pyaVwAya9wE5Q+bXSPUo4VfworchznCOelLgr1g+MfhF70T2EC66luTKI4Ag0Go81woV
 i+0fj/WZs1lgpoLZ8y2UbOxJxI4m1ZCKeyIccCBsFL54i/6bw9w5/SP7+UNwRuRqodE7
 hzGAocUBI2Im0RZcs+pFkKkXcYkQVyzBQdLF75MSgmGFOjLuYWjiYG89BPAf4RSHnIbE
 C4rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOMXwP9DnxAO8EJJ+Ttpd10yWAheop6X7ZlYTgndTraDm7/5TLuf5S1zx8Y3xYJZvPvRV9SWOOygIL@nongnu.org
X-Gm-Message-State: AOJu0YxG0ZcdtorYAWcX8FmYPuy5Dki9W6phgp/fJaZ4X9sKNavpjb+5
 IKc3L8W/LamM35LJGWDkr44jOLQiXYkOb2+wHS3LRpE9qCQKygemgGdUjKOwkysJMz5uCKFav+I
 DdivhqdqRSYXkcsBf5K71/KLzk/6CdefxwvWw+9pFij7y5lgG9iAk
X-Gm-Gg: ASbGncutdGCZgABIFERf7MrNEb81C0kjPNtHp0D/xtZoAevrmld14oOj7zxSNfuDGEP
 ObT9d2tg1EJi104PhM/QNRD0nbd5ZDkwNZa6b9hRZUiTN6gWg+NFbfy1wyRDBtQP0rdrPMAw8jW
 uCmcfRH/Aal+NZJX7AWq5EZBUrqHyWJjkyemMxcLtXLj38uqWiRrbZRt6644sqikH5+dVtS1VZ1
 qGQF655rn9Gv4hKmoZuww9iwGlyMNiBuHQoZGcydS2iD4Yt2xdK5tAM7e5eLPrmGdF1BK9T2+GB
 yqmFK0bnUvIVnYM6SPzDfnahC8ERPmjsvEEly1Bjhkenjr1Z
X-Received: by 2002:a05:620a:31aa:b0:7b6:f024:3ca with SMTP id
 af79cd13be357-7bffcdabe56mr3730589485a.58.1738623747042; 
 Mon, 03 Feb 2025 15:02:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwSPqmEhQS9bFeGagyy/xQS4t6LhbhQXYriATQ6ar93iPm//c+kZ0htUViFK24SBC8F8UrVw==
X-Received: by 2002:a05:620a:31aa:b0:7b6:f024:3ca with SMTP id
 af79cd13be357-7bffcdabe56mr3730585185a.58.1738623746624; 
 Mon, 03 Feb 2025 15:02:26 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a904781sm580290885a.78.2025.02.03.15.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 15:02:25 -0800 (PST)
Date: Mon, 3 Feb 2025 18:02:23 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs
 to take BQL for some calls
Message-ID: <Z6FK_4p24OjCziOF@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
 <Z57TPqhRYY4V14BE@gallifrey>
 <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
 <Z59o4u9zui3CPrkm@gallifrey>
 <fafbc505-acee-408e-a2ef-0a62bd30689b@maciej.szmigiero.name>
 <Z6Ef3iwQs7JSFY3c@x1.local>
 <afb27de1-d20a-4b0d-b271-ef6eef0e06ed@maciej.szmigiero.name>
 <Z6Eow-Ei3CvLy1vG@x1.local>
 <af219c2f-5cbe-4107-a35c-26bb0e2be1a4@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af219c2f-5cbe-4107-a35c-26bb0e2be1a4@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 03, 2025 at 10:41:43PM +0100, Maciej S. Szmigiero wrote:
> On 3.02.2025 21:36, Peter Xu wrote:
> > On Mon, Feb 03, 2025 at 09:15:52PM +0100, Maciej S. Szmigiero wrote:
> > > On 3.02.2025 20:58, Peter Xu wrote:
> > > > On Mon, Feb 03, 2025 at 02:57:36PM +0100, Maciej S. Szmigiero wrote:
> > > > > On 2.02.2025 13:45, Dr. David Alan Gilbert wrote:
> > > > > > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > > > > > On 2.02.2025 03:06, Dr. David Alan Gilbert wrote:
> > > > > > > > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > > 
> > > > > > > > > postcopy_ram_listen_thread() is a free running thread, so it needs to
> > > > > > > > > take BQL around function calls to migration methods requiring BQL.
> > > > > > > > > 
> > > > > > > > > qemu_loadvm_state_main() needs BQL held since it ultimately calls
> > > > > > > > > "load_state" SaveVMHandlers.
> > > > > > > > > 
> > > > > > > > > migration_incoming_state_destroy() needs BQL held since it ultimately calls
> > > > > > > > > "load_cleanup" SaveVMHandlers.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > > > > > ---
> > > > > > > > >      migration/savevm.c | 4 ++++
> > > > > > > > >      1 file changed, 4 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > > > > > > index b0b74140daea..0ceea9638cc1 100644
> > > > > > > > > --- a/migration/savevm.c
> > > > > > > > > +++ b/migration/savevm.c
> > > > > > > > > @@ -2013,7 +2013,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > > > > > > > >           * in qemu_file, and thus we must be blocking now.
> > > > > > > > >           */
> > > > > > > > >          qemu_file_set_blocking(f, true);
> > > > > > > > > +    bql_lock();
> > > > > > > > >          load_res = qemu_loadvm_state_main(f, mis);
> > > > > > > > > +    bql_unlock();
> > > > > > > > 
> > > > > > > > Doesn't that leave that held for a heck of a long time?
> > > > > > > 
> > > > > > > Yes, and it effectively broke "postcopy recover" test but I
> > > > > > > think the reason for that is qemu_loadvm_state_main() and
> > > > > > > its children don't drop BQL while waiting for I/O.
> > > > > > > 
> > > > > > > I've described this case in more detail in my reply to Fabiano here:
> > > > > > > https://lore.kernel.org/qemu-devel/0a09e627-955e-4f26-8d08-0192ecd250a8@maciej.szmigiero.name/
> > > > > > 
> > > > > > While it might be the cause in this case, my feeling is it's more fundamental
> > > > > > here - it's the whole reason that postcopy has a separate ram listen
> > > > > > thread.  As the destination is running, after it loads it's devices
> > > > > > and as it starts up the destination will be still loading RAM
> > > > > > (and other postcopiable devices) potentially for quite a while.
> > > > > > Holding the bql around the ram listen thread means that the
> > > > > > execution of the destination won't be able to take that lock
> > > > > > until the postcopy load has finished; so while that might apparently
> > > > > > complete, it'll lead to the destination stalling until that's finished
> > > > > > which defeats the whole point of postcopy.
> > > > > > That last one probably won't fail a test but it will lead to a long stall
> > > > > > if you give it a nice big guest with lots of RAM that it's rapidly
> > > > > > changing.
> > > > > 
> > > > > Okay, I understand the postcopy case/flow now.
> > > > > Thanks for explaining it clearly.
> > > > > 
> > > > > > > I still think that "load_state" SaveVMHandlers need to be called
> > > > > > > with BQL held since implementations apparently expect it that way:
> > > > > > > for example, I think PCI device configuration restore calls
> > > > > > > address space manipulation methods which abort() if called
> > > > > > > without BQL held.
> > > > > > 
> > > > > > However, the only devices that *should* be arriving on the channel
> > > > > > that the postcopy_ram_listen_thread is reading from are those
> > > > > > that are postcopiable (i.e. RAM and hmm block's dirty_bitmap).
> > > > > > Those load handlers are safe to be run while the other devices
> > > > > > are being changed.   Note the *should* - you could add a check
> > > > > > to fail if any other device arrives on that channel.
> > > > > 
> > > > > I think ultimately there should be either an explicit check, or,
> > > > > as you suggest in the paragraph below, a separate SaveVMHandler
> > > > > that runs without BQL held.
> > > > 
> > > > To me those are bugs happening during postcopy, so those abort()s in
> > > > memory.c are indeed for catching these issues too.
> > > > 
> > > > > Since the current state of just running these SaveVMHandlers
> > > > > without BQL in this case and hoping that nothing breaks is
> > > > > clearly sub-optimal.
> > > > > 
> > > > > > > I have previously even submitted a patch to explicitly document
> > > > > > > "load_state" SaveVMHandler as requiring BQL (which was also
> > > > > > > included in the previous version of this patch set) and it
> > > > > > > received a "Reviewed-by:" tag:
> > > > > > > https://lore.kernel.org/qemu-devel/6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com/
> > > > > > > https://lore.kernel.org/qemu-devel/e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com/
> > > > > > > https://lore.kernel.org/qemu-devel/87o732bti7.fsf@suse.de/
> > > > > > 
> > > > > > It happens!
> > > > > > You could make this safer by having a load_state and a load_state_postcopy
> > > > > > member, and only mark the load_state as requiring the lock.
> > > > > 
> > > > > To not digress too much from the subject of this patch set
> > > > > (multifd VFIO device state transfer) for now I've just updated the
> > > > > TODO comment around that qemu_loadvm_state_main(), so hopefully this
> > > > > discussion won't get forgotten:
> > > > > https://gitlab.com/maciejsszmigiero/qemu/-/commit/046e3deac5b1dbc406b3e9571f62468bd6743e79
> > > > 
> > > > The commit message may still need some touch ups, e.g.:
> > > > 
> > > >     postcopy_ram_listen_thread() is a free running thread, so it needs to
> > > >     take BQL around function calls to migration methods requiring BQL.
> > > > 
> > > > 
> > > > This sentence is still not correct, IMHO. As Dave explained, the ram load
> > > > thread is designed to run without BQL at least for the major workloads it
> > > > runs.
> > > 
> > > So what's your proposed wording of this commit then?
> > 
> > Perhaps dropping it? As either it implies qemu_loadvm_state_main() needs to
> > take bql (which could be wrong in case of postcopy at least from
> > design.. not sanity check pov), or it provides no real meaning to suggest
> > where to take it..
> > 
> > Personally I would put the comment as easy as possible - the large portion
> > isn't helping me to understand the code but only made it slightly more
> > confusing..
> > 
> >      /*
> >       * TODO: qemu_loadvm_state_main() could call "load_state" SaveVMHandlers
> >       * that are expecting BQL to be held, which isn't in this case.
> >       *
> >       * In principle, the only devices that should be arriving on this channel
> >       * now are those that are postcopiable and whose load handlers are safe
> >       * to be called without BQL being held.
> >       *
> >       * But nothing currently prevents the source from sending data for "unsafe"
> >       * devices which would cause trouble here.
> >       */
> > 
> > IMHO we could put it very simple if you think we need such sanity check
> > later:
> > 
> >      /* TODO: sanity check that only postcopiable data will be loaded here */
> 
> I think I will change that comment wording to the one ^^^^ you suggested above,
> since we still need to have this commit to take BQL around that
> migration_incoming_state_destroy() call in postcopy_ram_listen_thread().
> 
> > > 
> > > > I don't worry on src sending something that crashes the dest: if that
> > > > happens, that's a bug, we need to fix it..  In that case abort() either in
> > > > memory.c or migration/ would be the same.
> > > 
> > > Yeah, but it would be a bug in the source (or just bit stream corruption for
> > > any reason), yet it's the destination which would abort() or crash.
> > > 
> > > I think cases like that in principle should be handled more gracefully,
> > > like exiting the destination QEMU with an error.
> > > But that's something outside of the scope of this patch set.
> > 
> > Yes I agree.  It's just that postcopy normally cannot gracefully quits on
> > dest anyway.. as src QEMU cannot continue with a dead dest QEMU. For
> > obvious programming errors, I think abort() is still ok in this case, on
> > either src or dest if postcopy already started.
> > 
> > For this series, we could always stick with precopy, it could help converge
> > the series.
> 
> To be clear I'm messing with postcopy only because without adding that
> BQL lock around migration_incoming_state_destroy() in
> postcopy_ram_listen_thread() other changes in this patch set would break
> postcopy.
> And that's obviously not acceptable.

Ah, of course.

> 
> > > 
> > > > We could add some explicit check
> > > > in migration code, but I don't expect it to catch anything real, at least
> > > > such never happened since postcopy introduced.. so it's roughly 10 years
> > > > without anything like that happens.
> > > > 
> > > > Taking BQL for migration_incoming_state_destroy() looks all safe.  There's
> > > > one qemu_ram_block_writeback() which made me a bit nervous initially, but
> > > > then looks like RAM backends should be almost noop (for shmem and
> > > > hugetlbfs) but except pmem.
> > > 
> > > That's the only part where taking BQL is actually necessary for the
> > > functionality of this patch set to work properly, so it's fine to leave
> > > that call to qemu_loadvm_state_main() as-is (without BQL) for time being.
> > > 
> > > > 
> > > > The other alternative is we define load_cleanup() to not rely on BQL (which
> > > > I believe is true before this series?), then take it only when VFIO's path
> > > > needs it.
> > > 
> > > I think other paths always call load_cleanup() with BQL so it's probably
> > > safer to have consistent semantics here.
> > 
> > IMHO we don't necessarily need to make it the default that vmstate handler
> > hooks will need BQL by default - we can always properly define them to best
> > suite our need.
> 
> But I think consistency is important - if other callers take BQL for
> load_cleanup() then it makes sense to take it in all places (only if to make
> the code simpler).

I assume current QEMU master branch doesn't need bql for all existing (only
RAM and VFIO..) load_cleanup(), or am I wrong?

Thanks,

-- 
Peter Xu


