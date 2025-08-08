Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078E8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 17:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQXP-00030c-JA; Fri, 08 Aug 2025 13:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukQXN-0002yt-9y
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukQXK-0001Kt-AC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754672744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vQt+CNI6Lv7EOnlvVxpwbQ+XsxjORiU+LOFIMzTVBhU=;
 b=LLe3I3xmbNInPy5hTcLVFc9x28GR7GeOdnMwMxUBSuKqan3rs3FGlHlmJxRsCFIO+EmrWS
 vAutNj4ZQcX/rwMSpcfPAc+/IlkEAbYT3N6QC40WROeaETHZSaZnHtFoC2VB6F2Dp6hE3E
 q/4Ji9ZEmXwVwwKn3ihyazWmfJrO9Ec=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-DKNE8aMSNJaSpw53073BfA-1; Fri, 08 Aug 2025 13:05:43 -0400
X-MC-Unique: DKNE8aMSNJaSpw53073BfA-1
X-Mimecast-MFC-AGG-ID: DKNE8aMSNJaSpw53073BfA_1754672743
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-70e73d3c474so36688337b3.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 10:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672743; x=1755277543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQt+CNI6Lv7EOnlvVxpwbQ+XsxjORiU+LOFIMzTVBhU=;
 b=GYe5bpPrjk5dn9csvKUyqk29dnVTlYCgfxwOlzsANwa/UNcQrGH7kTs8T0ABno/VUb
 vYQOoT2kilZJpwIDFd89Q6uTgC2CygjwSfTLGIw/z1CZI7LGf9eHrqlM9FkBPP/o2boU
 MxN40NRttP2iezaGZO/vtGtQl//JgG7ovzAjMKmKBZxDihZPPzMNZLsdx5rmgI7klDWM
 rizA8bZZTmsO8oJXnNlg26YsSQP93z30aCA70kTnCqc8PCAelrmbC8z7WFxzamSaUuaX
 j/tIa691VNhhteFSwrblERm/9SP+b617zUnylQmYx4ejbEb2pB/qFnweVOct3DYmdAfX
 3kOw==
X-Gm-Message-State: AOJu0Yw7KKH09DkPI7Cag+Lf1rQohxQ8rLc2icy5In/1UIVgw5hmY/xL
 T6FKbUTLif++NVQywkdCyS+tz0EF5tKGCRqiSQa7SC7f5gtpKGygjbLvq+bh93Rz/CsLIHcY3lp
 2vU3f2zppL3Z1nY1ZhEttFYxCYDpV1HtkT33vWGi6U/71AMN1swHn8ZIo
X-Gm-Gg: ASbGncu7oZ1L3THIWV/agTztrxED42HIfJMNOnYNidUuzAbktHb8K7E6cNA7N2+MHcR
 fIgYNlLAR+NHRtoHvutAOyZYdst9iqpfUhX5a1V0ce4rGwU+HiWUNLHdJICnSHuG9iHkH4tbvjp
 P4l3KxecTbv2Dwb39HA8GOPlQSmFCF8k6qxCmGZbValE4xd17hW5CJSZEv8WRw0qaBljybrLnWb
 g8AE4p6+bGRxivMup2rnqlOxlPiNmxkaGOnOQXE/AdQ7221/gAPoIGhhaaq+oo7fTwl+64H85Rk
 JzRjkn+XmMsv5uEl1G+fLJBE+Sgf69YB
X-Received: by 2002:a05:690c:6d13:b0:71a:18fb:6eaa with SMTP id
 00721157ae682-71bf0cedbc2mr44917327b3.3.1754672742483; 
 Fri, 08 Aug 2025 10:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUhyDVu0cLQUuQ43PjXootakVZJ03zT+ulg+S4/cBvNhXSnN1aYagRkumlCxEjnB70tiUoBQ==
X-Received: by 2002:a05:690c:6d13:b0:71a:18fb:6eaa with SMTP id
 00721157ae682-71bf0cedbc2mr44916747b3.3.1754672742019; 
 Fri, 08 Aug 2025 10:05:42 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a5cc216sm53278607b3.73.2025.08.08.10.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 10:05:41 -0700 (PDT)
Date: Fri, 8 Aug 2025 13:05:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 3/4] migration: Make listen thread joinable
Message-ID: <aJYuWKjb8ij7NRx6@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-4-jmarcin@redhat.com>
 <aJUTO0n9NyIWaFNj@x1.local>
 <2svq64am2z4dr7q7x2jozlgzhiwluzi3je3f4acjylxqyzbxml@mnqscmlofjro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2svq64am2z4dr7q7x2jozlgzhiwluzi3je3f4acjylxqyzbxml@mnqscmlofjro>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 08, 2025 at 01:08:39PM +0200, Juraj Marcin wrote:
> Hi Peter,
> 
> On 2025-08-07 16:57, Peter Xu wrote:
> > On Thu, Aug 07, 2025 at 01:49:11PM +0200, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > > 
> > > This patch allows joining the migration listen thread. This is done in
> > > preparation for the introduction of "postcopy-setup" state at the
> > > beginning of a postcopy migration, when destination can fail gracefully
> > > and source side then resume to a running state.
> > > 
> > > In case of such failure, to gracefully perform all cleanup in the main
> > > migration thread, we need to wait for the listen thread to exit, which
> > > can be done by joining it.
> > > 
> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > ---
> > >  migration/migration.c | 1 +
> > >  migration/savevm.c    | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index e5ce2940d5..8174e811eb 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -901,6 +901,7 @@ process_incoming_migration_co(void *opaque)
> > >               * Postcopy was started, cleanup should happen at the end of the
> > >               * postcopy thread.
> > >               */
> > > +            qemu_thread_detach(&mis->listen_thread);
> > >              trace_process_incoming_migration_co_postcopy_end_main();
> > >              goto out;
> > >          }
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index fabbeb296a..d2360be53c 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2217,7 +2217,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> > >      mis->have_listen_thread = true;
> > >      postcopy_thread_create(mis, &mis->listen_thread,
> > >                             MIGRATION_THREAD_DST_LISTEN,
> > > -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> > > +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
> > 
> > This is good; I actually forgot it used to be detached..
> > 
> > Instead of proactively detach it above, could we always properly join it
> 
> However, after the main thread finishes loading device state from the
> package, process_incoming_migration_co() exits, and IIUC main thread is
> then no longer occupied with migration. So, if we should instead join
> the listen thread, we probably should yield the coroutine until the
> listen thread can be joined, so we are not blocking the main thread?

Or could we schedule a bottom half at the end of
postcopy_ram_listen_thread() to join itself?  We could move something over
into the BH:

    ... join() ...
    mis->have_listen_thread = false;
    migration_incoming_state_destroy();
    object_unref(OBJECT(migr));

> 
> > (and hopefully every migration thread)?  Then we could drop patch 1 too.
> 
> If I haven't missed any, there are no detached migration threads except
> listen and get dirty rate threads.

Yep.

From mgmt pov, IMHO it's always good we create joinable threads.  But we
can leave the calc_dirty_rate thread until necessary.

-- 
Peter Xu


