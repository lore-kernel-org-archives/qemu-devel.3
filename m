Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21322CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bZ2-00044E-F8; Wed, 08 Oct 2025 17:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bZ0-00043v-WA
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bYs-0001sp-DB
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759958335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tP8UPCx3RQl/09lQVQM//eUPTc87icdYdc/MA666Efw=;
 b=cwrtTe+FgcSpm35j1/RbdzNgHcaIj6fu+og/Nn0lZ97XdYXrXnO8o/RPIzAw3EkCy66ewt
 d//drAqpF6ExMzjFzyuQnnTLRP7w9SWa+cCSilbs+3YHkI9nCrSrMFcnvcvhx6eVOKMXNt
 q7CA6rs8ZRzWMVHqfDeTY08jft7Pc1s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-b4oAif2gN8WJZPfHyhIfsA-1; Wed, 08 Oct 2025 17:18:54 -0400
X-MC-Unique: b4oAif2gN8WJZPfHyhIfsA-1
X-Mimecast-MFC-AGG-ID: b4oAif2gN8WJZPfHyhIfsA_1759958333
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e6e51d9dd9so7730851cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759958333; x=1760563133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tP8UPCx3RQl/09lQVQM//eUPTc87icdYdc/MA666Efw=;
 b=BGIGl5AonoobStDnFyQ97EgmxA70dML4tYV25r+hfCJ1aAEXqCRAKJxcwZ/EXsfeZU
 vVIT798JkpJ09kktIT05b2NHadJbHHCVHKqjsoYuFZ0vjRRfviOxcdTFq6Kzx72BhgKm
 /iAB7m0Q5wResqj1n12TYQTGyo/Pq5CBiHnqN/ETQKS8fHF9twOtvpdPu3hUxVQaRgmd
 3ODZnuGoR5vFM2xGRD3R1d8pYwfOYp7xvh5qPBnF4QvAlSb4hgN5G9pas9VOtM3nRwZo
 ZQsQ5Iou9vFM/KqpvaCRi8WMT9HUIjwVFXIUMj0QuV/2E/6gMWBMiCfJV17WfOqRJWTE
 3Ung==
X-Gm-Message-State: AOJu0YxGzB60wc+xzSvBB0Yp1Mb13j+7HGZVcXAOmsyHuaL7cDFFlVmn
 Dbml2NvJf8mh3rRyn3qmGgOKL1V87Zyn/PeCihJidmpdx5Zxff8jmJj7vriS1TfKE88I0VUwh/t
 PGZc7n4A61CUygyVtTUO11XJkcOaP4iKUmJi1I8n4/3WZKZdZUAY30ivu
X-Gm-Gg: ASbGncvALdTjIKApyEXFlmUJPBrdhMGY7Rb2DZYfWSD/O/H6Tu/7r+kSTrN5fp8jwED
 Bmlwwd+ytxEgTx9Irbc/eeZZVuIT1FWvykRvA11tLYQcrulx8jLyc31tSWE2wsiz9adB9NdeJ22
 /li7X0mN5L9LsdL+UJXqUTYRf1PChNQEvSYx8UHncGllFbQHcNuZJiNqtUJ1pPVBx+BUi/FwoKY
 aFmw3+R3eP65mJRkrV7uAabbgM016cJ9oGDy8K47P+u5pNYVDIvpOTguPSx9DJ0xLR6DjmB9LmU
 WEXHzUdRE85JXPjWkCE2RMLObiWY8t+qFcXFfg==
X-Received: by 2002:ac8:7d0a:0:b0:4e4:beb1:73d4 with SMTP id
 d75a77b69052e-4e6eacf551amr81648241cf.31.1759958333411; 
 Wed, 08 Oct 2025 14:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGFA/O/QW2U/EvNZdBTF1WshWmWYFmjIN0+hKOWNiYaFRlUHd1RAgcK00qxM+Fr75sgnJ8YQ==
X-Received: by 2002:ac8:7d0a:0:b0:4e4:beb1:73d4 with SMTP id
 d75a77b69052e-4e6eacf551amr81647801cf.31.1759958332904; 
 Wed, 08 Oct 2025 14:18:52 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8849f3d8b39sm72655185a.8.2025.10.08.14.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:18:52 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:18:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 6/9] migration/rdma: Remove coroutine path in
 qemu_rdma_wait_comp_channel
Message-ID: <aObVOU3tw-DwMWeA@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-7-peterx@redhat.com>
 <87ikhivx7h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikhivx7h.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Tue, Sep 16, 2025 at 07:39:30PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Now after threadified dest VM load during precopy, we will always in a
> > thread context rather than within a coroutine.  We can remove this path
> > now.
> >
> > With that, migration_started_on_destination can go away too.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/rdma.c | 102 +++++++++++++++++++----------------------------
> >  1 file changed, 41 insertions(+), 61 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 2b995513aa..7751262460 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -29,7 +29,6 @@
> >  #include "qemu/rcu.h"
> >  #include "qemu/sockets.h"
> >  #include "qemu/bitmap.h"
> > -#include "qemu/coroutine.h"
> >  #include "system/memory.h"
> >  #include <sys/socket.h>
> >  #include <netdb.h>
> > @@ -357,13 +356,6 @@ typedef struct RDMAContext {
> >      /* Index of the next RAMBlock received during block registration */
> >      unsigned int    next_src_index;
> >  
> > -    /*
> > -     * Migration on *destination* started.
> > -     * Then use coroutine yield function.
> > -     * Source runs in a thread, so we don't care.
> > -     */
> > -    int migration_started_on_destination;
> > -
> >      int total_registrations;
> >      int total_writes;
> >  
> > @@ -1353,66 +1345,55 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
> >      struct rdma_cm_event *cm_event;
> >  
> >      /*
> > -     * Coroutine doesn't start until migration_fd_process_incoming()
> > -     * so don't yield unless we know we're running inside of a coroutine.
> > +     * This is the source or dest side, either during precopy or
> > +     * postcopy.  We're always in a separate thread when reaching here.
> > +     * Poll the fd.  We need to be able to handle 'cancel' or an error
> > +     * without hanging forever.
> >       */
> > -    if (rdma->migration_started_on_destination &&
> > -        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE &&
> > -        qemu_in_coroutine()) {
> > -        yield_until_fd_readable(comp_channel->fd);
> > -    } else {
> > -        /* This is the source side, we're in a separate thread
> > -         * or destination prior to migration_fd_process_incoming()
> > -         * after postcopy, the destination also in a separate thread.
> > -         * we can't yield; so we have to poll the fd.
> > -         * But we need to be able to handle 'cancel' or an error
> > -         * without hanging forever.
> > -         */
> > -        while (!rdma->errored && !rdma->received_error) {
> > -            GPollFD pfds[2];
> > -            pfds[0].fd = comp_channel->fd;
> > -            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> > -            pfds[0].revents = 0;
> > -
> > -            pfds[1].fd = rdma->channel->fd;
> > -            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> > -            pfds[1].revents = 0;
> > -
> > -            /* 0.1s timeout, should be fine for a 'cancel' */
> > -            switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
> > -            case 2:
> > -            case 1: /* fd active */
> > -                if (pfds[0].revents) {
> > -                    return 0;
> > -                }
> > +    while (!rdma->errored && !rdma->received_error) {
> > +        GPollFD pfds[2];
> > +        pfds[0].fd = comp_channel->fd;
> > +        pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> > +        pfds[0].revents = 0;
> > +
> > +        pfds[1].fd = rdma->channel->fd;
> > +        pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
> > +        pfds[1].revents = 0;
> > +
> > +        /* 0.1s timeout, should be fine for a 'cancel' */
> > +        switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
> 
> Don't glib have facilities for polling? Isn't this what
> qio_channel_rdma_create_watch() is for already?

Yes.  I don't know why the RDMA channel is done like this; I didn't dig
deeper. I bet Dan has more clues (as author of 6ddd2d76ca6f). The hope is I
also don't need to dig it if I only want to make the loadvm to work in a
thread. :)

I also replied to your other email, that should have some more info
regarding to why I think rdma's io_create_watch() isn't used.. or seems
broken.

For this patch alone, it almost only removed the "if()" section, these
lines are untouched except indentation changes.

-- 
Peter Xu


