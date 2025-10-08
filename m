Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFD8CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bc6-0005YT-Lw; Wed, 08 Oct 2025 17:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bc4-0005Xn-ID
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bbw-0002V1-OW
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759958525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQKGJfBPRLwLZ/arKu5Y/nC/3OGGuDaxG3xoUgcsKVU=;
 b=OrcBfFn5eBov6pVf8/f10xOKgfIERBpWz/xmRfGE1ULorw2/TZe+EnSznQ50icDuFsfKo5
 F4spGFzaGKzHqOPUw+QxQsGC/0f1qXqOYRMyfqTHHQaHjFhAZUm84bYfmHaDVtmiyhzV9v
 gvpJ3vdfFYLYT8/wX7u3zhIrnW00rEc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-gSoAC-V5MeeZ3itfipLpSQ-1; Wed, 08 Oct 2025 17:22:04 -0400
X-MC-Unique: gSoAC-V5MeeZ3itfipLpSQ-1
X-Mimecast-MFC-AGG-ID: gSoAC-V5MeeZ3itfipLpSQ_1759958524
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78ea15d3548so5506616d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759958524; x=1760563324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQKGJfBPRLwLZ/arKu5Y/nC/3OGGuDaxG3xoUgcsKVU=;
 b=P9jyDjURn2sddNixxq41PNP4KwDpxWkl7UyZ4tsiRLrOeUUpe4ecJuOOTZ9Kovp9zr
 G37O0MduqVNVFu0UL7v37D0DXATFXzksXPX2BowbphqBoLHYubF51p71u83E9imjL0ER
 A9gkLHMGyW8k+Qwbx5NMGWFH8NIUXrH7lpULQW4ZjL0SrgpbSoQuiMAgCCxqTneud9K1
 Z3dFwt8YJEjow88xq99l7vxb4Rg7TICKyCrWfnspEDZ+H1E2eM1yiZSal7QK63Md2SNQ
 lm//olDiMLdlfccdLq9gsmMgHivnfEkJI1wRdm4kjSnq1hjny5dcHzoHStg3eEHh+bUF
 5Y9A==
X-Gm-Message-State: AOJu0YxU2NAiiZqCkK4o9hlUrHVcIIAb2MfjOzHRfYmOOqn5yY+T+6rt
 rPsQE++pDnm3JWdzMQs/Y2YI+HkkS2hkO8J4QFsXqvIujXOyPmnQpcfm+xmyXb8EXRaLuX+leMb
 V7t7gnO3Oeo5EcYQxDYidWqNg09Gr6nPzwpRPc1JPQsIRQ7YW/mk+LnCz
X-Gm-Gg: ASbGncsKoGnF9qeK2BbxN9CbOGS936xOnt8KiaCCLKseYKkYIDH/ErNL24aoYHHCDnt
 ZGqYK3nR1YZOvIA+GudTT7yszCbrldiPw3fF7OIPV3L0wftr3md7Rfj/2eK4xi5qrzEy4vzPVs0
 kFEvs7bIi9vA1sPj0qi1rFFpCFESiJd26RD+sh7zLIKDm36nAlUP/r95ZsWj2crx9ooLZZBizGf
 eLzs1eISn5zx5F3VxIAS2nLMMC8wlpiojHfl5TwaZb+I2uEOlOWOY/ZSxcm4AwZAkI4bM+2pbAK
 eHGkeym6+vchqdOOqhRncNHtJqOZSyi3ovAvwQ==
X-Received: by 2002:a05:6214:f6d:b0:70f:5a6d:a253 with SMTP id
 6a1803df08f44-87b2ef44013mr67604396d6.49.1759958523859; 
 Wed, 08 Oct 2025 14:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMLBWUvopf7umhGjE1Ydbp4iS/5AIOkdmxEGpml3Aamr43b1mDepi+tshucbGWZzR4CXPdYw==
X-Received: by 2002:a05:6214:f6d:b0:70f:5a6d:a253 with SMTP id
 6a1803df08f44-87b2ef44013mr67603956d6.49.1759958523307; 
 Wed, 08 Oct 2025 14:22:03 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bdf53a05sm177878606d6.51.2025.10.08.14.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:22:02 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:22:01 -0400
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
Subject: Re: [PATCH RFC 9/9] migration/rdma: Remove rdma_cm_poll_handler
Message-ID: <aObV-e2ZRgbVng6T@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-10-peterx@redhat.com>
 <877bxwx6tw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bxwx6tw.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 03:38:35PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This almost reverts commit 923709896b1b01fb982c93492ad01b233e6b6023.
> >
> > It was needed because the RDMA iochannel on dest QEMU used to only yield
> > without monitoring the fd.  Now it should be monitored by the same poll()
> > similarly on the src QEMU in qemu_rdma_wait_comp_channel().  So even
> > without the fd handler, dest QEMU should be able to receive the events.
> >
> > I tested this by initiating an RDMA migration, then do two things:
> >
> >   - Either does migrate_cancel on src, or,
> >   - Directly kill destination QEMU
> >
> > In both cases, the other side of QEMU will be able to receive the
> > disconnect event in qemu_rdma_wait_comp_channel() and properly cancel or
> > fail the migration.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/rdma.c | 29 +----------------------------
> >  1 file changed, 1 insertion(+), 28 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 7751262460..da7fd48bf3 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -3045,32 +3045,6 @@ int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> >  
> >  static void rdma_accept_incoming_migration(void *opaque);
> >  
> > -static void rdma_cm_poll_handler(void *opaque)
> > -{
> > -    RDMAContext *rdma = opaque;
> > -    struct rdma_cm_event *cm_event;
> > -
> > -    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
> > -        error_report("get_cm_event failed %d", errno);
> > -        return;
> > -    }
> > -
> > -    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
> > -        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
> > -        if (!rdma->errored &&
> > -            migration_incoming_get_current()->state !=
> > -              MIGRATION_STATUS_COMPLETED) {
> > -            error_report("receive cm event, cm event is %d", cm_event->event);
> > -            rdma->errored = true;
> > -            if (rdma->return_path) {
> > -                rdma->return_path->errored = true;
> > -            }
> > -        }
> > -        rdma_ack_cm_event(cm_event);
> > -    }
> > -    rdma_ack_cm_event(cm_event);
> > -}
> > -
> >  static int qemu_rdma_accept(RDMAContext *rdma)
> >  {
> >      Error *err = NULL;
> > @@ -3188,8 +3162,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> >                              NULL,
> >                              (void *)(intptr_t)rdma->return_path);
> >      } else {
> > -        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
> > -                            NULL, rdma);
> > +        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> 
> I'm not familiar with this code, but is this left here to remove the
> handler? Can't we remove this line altogether?

Fair question. I was just lazy because I know it's safe to call it like
that no matter what, unregistering anything if we registered some,
otherwise this qemu_set_fd_handler() should be a no-op.

I am just not confident on RDMA code that we can remove it.  IOW, before
923709896b1 we did that, so I kept it as-is.

-- 
Peter Xu


