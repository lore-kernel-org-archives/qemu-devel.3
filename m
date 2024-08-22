Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACBCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shDE6-0002Nv-5r; Thu, 22 Aug 2024 15:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shDE1-0002NG-H7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 15:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shDDy-0006YD-F2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 15:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724353916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjn0FXapyM+mTZ3w5mFzCqjM7SK8gs7n4qXDiKMCaqk=;
 b=SxZTs6AOQ905we9pzUDpgw2+ISTLOInDprsbbnEmDl3Yix94w/8g25blV4nfyfvGHeC8Y3
 7O3HlCAKTWvyMqXUmgxk4Pp+2ErOyT9ccSMDx3AIwVejqlxZ6p815WSpZbavlxcRWc1ZSN
 vZ+OfVfzyQ0pIYq17nFeaFRN9+wdSVo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-yts0eaTOPXm3f2U9LIHXtw-1; Thu, 22 Aug 2024 15:11:54 -0400
X-MC-Unique: yts0eaTOPXm3f2U9LIHXtw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6bf6bcee8ccso13668386d6.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 12:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724353914; x=1724958714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjn0FXapyM+mTZ3w5mFzCqjM7SK8gs7n4qXDiKMCaqk=;
 b=svQldu+6rYPE9AVKGLVWBb8HMrh4M2pLf51+7Jbjgt9zxGGvMekVbOTMQLa50qgXai
 wdX9lrn603egZo1nHTZC0qS0w09ZjlVcl+wY0IuqfvZMlDR0e6UHULGW4dHswPAu/mAx
 dnlyWv+VIG5ClSgrQHsSYJXqojT1tW6qedRqCYexXZ/QRJ8ps5LRKQleUkDErnWLbfVv
 oOHU2BWiJjIHQtx20k2EkgNB+mjd8ksDXMby10qgZrksgBzQEpmnuOMXHAAj8HU7U6jM
 1PWR3DX60FWGH85EcXoRJ6Q+UcC7yX0SukMSzqUkF4U/38jwmuCY89/RLBiXBaV1KDat
 gfsg==
X-Gm-Message-State: AOJu0YxY8o+mFwBR2qf53lBi/7CqWUpj3K8M+/BUvb10pdDpi3sKk9K+
 WWwMKjSQ89Esyz3Udd4YYjBuloStRcsgnNXSQwOQLG51A3Il/w7ETNMEsMD8Leqg7UIaq6bK9Sa
 McxnJYdi/Zq3yxTBIzfqvb3UQWPx3bbQS77/2n0BMsVB+3vY3y8wL
X-Received: by 2002:a05:6214:2e4a:b0:6bf:6e0f:1a18 with SMTP id
 6a1803df08f44-6c155d5b688mr66681106d6.8.1724353914277; 
 Thu, 22 Aug 2024 12:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYqLLEr4vAxYr7TyRkckC3rk6/FO+UY+NzljT8oN+SwryhzkVtBGRTaLrdaIHyyTwuCMj9bw==
X-Received: by 2002:a05:6214:2e4a:b0:6bf:6e0f:1a18 with SMTP id
 6a1803df08f44-6c155d5b688mr66680916d6.8.1724353913915; 
 Thu, 22 Aug 2024 12:11:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcd10esm10446046d6.105.2024.08.22.12.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 12:11:53 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:11:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 12/14] migration/multifd: Allow multifd sync without
 flush
Message-ID: <ZseNd77DUXe62mL0@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-13-farosas@suse.de> <ZsdhY2ijx9nhSdLz@x1n>
 <Zsdi432b2dobNhMj@x1n> <87ttfcxzc5.fsf@suse.de>
 <Zsd3O_OCbpyctm-K@x1n> <87le0oxwg4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le0oxwg4.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 03:07:55PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 22, 2024 at 02:05:30PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Aug 22, 2024 at 12:03:47PM -0400, Peter Xu wrote:
> >> >> On Thu, Aug 01, 2024 at 09:35:14AM -0300, Fabiano Rosas wrote:
> >> >> > Separate the multifd sync from flushing the client data to the
> >> >> > channels. These two operations are closely related but not strictly
> >> >> > necessary to be executed together.
> >> >> > 
> >> >> > The multifd sync is intrinsic to how multifd works. The multiple
> >> >> > channels operate independently and may finish IO out of order in
> >> >> > relation to each other. This applies also between the source and
> >> >> > destination QEMU.
> >> >> > 
> >> >> > Flushing the data that is left in the client-owned data structures
> >> >> > (e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
> >> >> > but that is particular to how the ram migration is implemented with
> >> >> > several passes over dirty data.
> >> >> > 
> >> >> > Make these two routines separate, allowing future code to call the
> >> >> > sync by itself if needed. This also allows the usage of
> >> >> > multifd_ram_send to be isolated to ram code.
> >> >> 
> >> >> What's the usage of sync but not flush here?
> >> >
> >> > Oh I think I see your point.. I think flush+sync is always needed, it's
> >> > just that RAM may not always be the one to flush, but something else.
> >> > Makes sense then.
> >> >
> >> 
> >> I'm thinking of "flush" here as a last multifd_send() before sync. We
> >> need multiple multifd_send() along the migration to send the data, but
> >> we might not need this extra flush. It could be that there's nothing to
> >> flush and the code guarantees it:
> >> 
> >>  <populate MultiFDSendData>
> >>  multifd_send()
> >>  sync
> >> 
> >> Where RAM currently does:
> >> 
> >>  multifd_queue_page()
> >>  multifd_queue_page()
> >>  multifd_queue_page()
> >>  ...
> >>  multifd_queue_page()
> >>  multifd_send()
> >>  sync
> >> 
> >> Today there is a multifd_send() inside multifd_queue_page() and the
> >> amount sent depends on the ram.c code. At the time sync gets called,
> >> there could be data queued but not yet sent. Another client (not ram)
> >> could just produce data in a deterministic manner and match that with
> >> calls to multifd_send().
> >
> > I hope I read it alright.. I suppose you meant we have chance to do:
> >
> >   ram_send()
> >   vfio_send()
> >   flush()
> >
> > Instead of:
> >
> >   ram_send()
> >   flush()
> >   vfio_send()
> >   flush()
> >
> > Am I right?
> 
> Not really. I'm saying that RAM doesn't always send the data, that's why
> it needs a final flush before sync:
> 
> multifd_queue_page()
>     if (multifd_queue_empty(pages)) {
>         multifd_enqueue(pages, offset);
>     }
>     
>     if (multifd_queue_full(pages)) {
>         multifd_send_pages()   <-- this might not happen
>     }
>     multifd_enqueue()
> 
> multifd_send_sync_main()
>     if (pages->num) { <-- data left unsent
>        multifd_send() <-- flush
>     }
>     <sync routine>

I see now.

At least for now I'd expect VFIO doesn't need to use sync at all, not
before the kernel ABI changes. It's just that when that comes we may need
to move that final sync() out of ram code then, but before a migration
completes, to cover both.

It's ok then, my R-b holds.

-- 
Peter Xu


