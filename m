Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86293C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujfkN-0008KE-K9; Wed, 06 Aug 2025 11:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujfX2-00039g-7N
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 10:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujfX0-0003hT-A8
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 10:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754492057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VtWSiZGAAOEFjzqd2c5o01F9tN/EzQa00NNmMmsRxk=;
 b=T2qbYaIXgITGLGz6RV5NId/K2HctlUkuuINdBNN42d8mc8XyLFU9yk8fkxgtgg7UE+Y5lf
 tOuqRgZvQDYVQL0AMbpvArxF4HCFmSi3EZWWXiRx/pQpK4l7U6YJm900uyMa4P5d5Sq0OJ
 fahrgJOhV5/Zmq58TK3FBwAscWsqaVw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-1hywDPivOEKyN1NpW7Ldqg-1; Wed, 06 Aug 2025 10:54:16 -0400
X-MC-Unique: 1hywDPivOEKyN1NpW7Ldqg-1
X-Mimecast-MFC-AGG-ID: 1hywDPivOEKyN1NpW7Ldqg_1754492055
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4af18aa7af8so92809401cf.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 07:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492055; x=1755096855;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3VtWSiZGAAOEFjzqd2c5o01F9tN/EzQa00NNmMmsRxk=;
 b=eHBSFFS4nUnUmo+2iT5Nn2Uq2QsRy5IkDLPLz/uVGStPhnY00jRT+QV7cohig9YOwG
 xlfKjHtbBFhYLH2cq0oYkorK8n5k+AtNo3BT40Tk7F7Ea1Pp8qaI3a2jfDatBzLEE2zM
 wQl4nmohYmX4aspnQq0rgRYfz88JGyU+Ypj1PEHYScEdhtK2w9jLjcMg50G3h7Kxezo5
 AEDCDXZS3sEPSbEqq1TXCOFaSeCt07Paq2VCUVh/fV/2LVaWu5HhXgypVx+VmlJc+mRy
 Z32tJOGzSN1NQAJ47Aipg0CvqmkMw2ahy23gUKLjpadq1DizZxEbaYt0Wh0qh6Wqz8X8
 cOMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEs0EMEtwz46AiokfkDmdqT1WiXwm7EMPV5AEZpuuzVXW4C0TOIkyCxLgXJurf/LwsALrs9NjmMyOu@nongnu.org
X-Gm-Message-State: AOJu0Yy8I5oN2HersOumpoDfKzvXiia79tQ/9px3Mlrua0FeftNf9epN
 eqhMyp6OElI03xmKpOdmIYrzKQr2xBcjpp8nv2F1eKQYsst3MTxLB6dlNqeJKqXXXH8sMsb4sr7
 puNpUQ3FuHVx0SV+G6dbQE/6WoPSZUwNES7di40QmlyAitk3D5FSM4JPl
X-Gm-Gg: ASbGncvWgmploUCjeQu4R7XdIDneXMNLcFG/2ZvBamL5kf44P4GeVJfWcMC71XR9AkH
 QI3ONoguX/UTRt5vmfugAlLOzPOrBJvkXzu8o7eRHRInFqrNNqiTFKMFFt91CRa0d9PvzZrgw51
 Cj3zhQvhXNfrhPVh6PgOs+N5ZvaNRft0GVgcSd1qAY7gasbaX8yU/y/PeKcn4cxK9jYvep0umCD
 dKg5p92aW1+VY/n28lDE4uZ35Rmwbvklt0mQoLKODiQXgu/UELdN5VNmaAWg3HC+ZIOv6uNpYMy
 ytzJXoe9s1t5aqQTGCfmzxHUSByBrlqtSkMEI8Wt0axLsG0LLqCED3MF4CDN+F1dQohZO85bIF5
 R9yCGj4Amxf+dmjy8e/by5Q==
X-Received: by 2002:a05:622a:1787:b0:4b0:8773:9b13 with SMTP id
 d75a77b69052e-4b0912cb83emr33232741cf.3.1754492055293; 
 Wed, 06 Aug 2025 07:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwOlq/zFeJ9bUTfbNGDkL6Rav5BRL3C+kjpoJAQMPd72KRBq5Ok7kfCRj7otlgAtTYtSOazQ==
X-Received: by 2002:a05:622a:1787:b0:4b0:8773:9b13 with SMTP id
 d75a77b69052e-4b0912cb83emr33232201cf.3.1754492054422; 
 Wed, 06 Aug 2025 07:54:14 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cde5a01sm86650526d6.70.2025.08.06.07.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:54:13 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:54:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <aJNsk7PRVJ33dX5a@x1.local>
References: <20250801170212.54409-1-berrange@redhat.com>
 <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
 <87jz3i3n0u.fsf@suse.de> <aJHYSwGXTOF4o00n@redhat.com>
 <87h5yl3mt2.fsf@suse.de>
 <ekcc4p5uap6g674ljwjpa7q42yybrl5vabxhodgfmo6awcvzq2@s4dmgpfpd4jz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ekcc4p5uap6g674ljwjpa7q42yybrl5vabxhodgfmo6awcvzq2@s4dmgpfpd4jz>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 05, 2025 at 04:52:58PM +0200, Juraj Marcin wrote:
> Hi all!
> 
> On 2025-08-05 10:44, Fabiano Rosas wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Mon, Aug 04, 2025 at 04:27:45PM -0300, Fabiano Rosas wrote:
> > >> Juraj Marcin <jmarcin@redhat.com> writes:
> > >> 
> > >> > Hi Daniel,
> > >> >
> > >> > On 2025-08-01 18:02, Daniel P. Berrangé wrote:
> > >> >> This is a followup to previously merged patches that claimed to
> > >> >> workaround the gnutls bug impacting migration, but in fact were
> > >> >> essentially non-functional. Juraj Marcin pointed this out, and
> > >> >> this new patch tweaks the workaround to make it actually do
> > >> >> something useful.
> > >> >> 
> > >> >> Daniel P. Berrangé (2):
> > >> >>   migration: simplify error reporting after channel read
> > >> >>   migration: fix workaround for gnutls thread safety
> > >> >> 
> > >> >>  crypto/tlssession.c   | 16 ----------------
> > >> >>  migration/qemu-file.c | 22 +++++++++++++++++-----
> > >> >>  2 files changed, 17 insertions(+), 21 deletions(-)
> > >> >> 
> > >> >
> > >> > thanks for finding a fix for the workaround. I have tested it and it
> > >> > resolves the issue.
> > >> >
> > >> > However, it significantly slows down migration, even with the workaround
> > >> > disabled (and thus no locking). When benchmarking, I used the fixed
> > >> > version of GNUTLS, VM with 20GB of RAM which were fully written to
> > >> > before starting a normal migration with no workload during the
> > >> > migration.
> > >> >
> > >> > Test cases:
> > >> > [1]: before this patchset
> > >> > [2]: with this patchset applied and GNUTLS workaround enabled
> > >> > [2]: with this patchset applied and GNUTLS workaround disabled
> > >> >
> > >> >   | Total time | Throughput | Transfered bytes |
> > >> > --+------------+------------+------------------+
> > >> > 1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
> > >> > 2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
> > >> > 3 |  72 426 ms |  2343 mbps |   21 215 009 392 |
> > >> 
> > >> Thanks testing this. I had just managed to convince myself that there
> > >> wouldn't be any performance issues.
> > >> 
> > >> The yield at every buffer fill on the incoming side is probably way more
> > >> impactful than the poll on the RP.
> > >
> > > Yeah, that's an unacceptable penalty on the incoming side for sure.
> > >
> > > How about we simply change the outbound migration channel to be in
> > > non-blocking mode ?   I originally put it in blocking mode way back
> > > in 9e4d2b98ee98f4cee50d671e500eceeefa751ee0, but if I look at the
> > > QEMUFile impl of qemu_fill_buffer and qemu_fflush, but should be
> > > coping with a non-blocking socket. qemu_fill_buffer has explicit
> > > code to wait, and qemu_fflush uses the _all() variant whcih has
> > > built-in support for waiting. So I'm not seeing an obvious need
> > > to run the channel in blocking mode.

Sync IOs actually made some sense to me here, since when there's no lock to
releaes, it sounds more efficient to wait in the syscall until all the
buffers are flushed read/write.  That is compared to async where we need to
exit to userspace, qio_channel_wait(), retry syscall.

Is there any concern where we could in some cases get frequent G_IO_*
events, but syscall read/write may be a large buffer so the overhead of
async can be measurable (one syscall may trigger multiple loops of wait()
and retry)?  From Juraj's test results it looks like at least not
measurable in the questioned use case.  However not sure about the rest.
For example, we still have option to only enable async channels for tls,
but I'm not sure whether it's necessary, either.

> > 
> > It's definitely simpler and I think it works. It's uncomfortably late
> > though to add a bunch of glib event loop code to the migration
> > thread. Is the suggestion of moving the yield to tlssession.c even
> > feasible?
> > 
> > Juraj, are you able to get some numbers with this?
> 
> Yes, I have tested it with this patch and it still works, now without
> any noticeable performance regressions.
> 
> Test cases:
> [0]: before this patchset with GNUTLS workaround disabled
> [1]: before this patchset with GNUTLS workaround enabled
> [2]: with this patchset applied and GNUTLS workaround enabled
> [2]: with this patchset applied and GNUTLS workaround disabled
> 
>   | Total time | Throughput  | Transfered bytes |
> --+------------+-------------+------------------+
> 0 |  32 464 ms |  5 228 mbps |   21 213 283 021 |
> 1 |  32 429 ms |  5 236 mpbs |   21 224 062 348 |
> 2 |  32 934 ms |  5 150 mbps |   21 200 558 083 |
> 3 |  31 547 ms |  5 384 mbps |   21 229 225 792 |
> 
> 
> Tested-by: Juraj Marcin <jmarcin@redhat.com>
> 
> 
> Best regards
> 
> Juraj Marcin
> 
> > 
> > > Using non-blocking will prevent the return path thuread setting
> > > in a read() call, so we won't have mutual exclusion between read
> > > and write which this patch was trying to avoid
> > >
> > > ie, this delta on top of this patch:
> > >
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 10c216d25d..1eaabc1f19 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -4002,7 +4002,7 @@ void migration_connect(MigrationState *s, Error *error_in)
> > >      }
> > >  
> > >      migration_rate_set(rate_limit);
> > > -    qemu_file_set_blocking(s->to_dst_file, true);
> > > +    qemu_file_set_blocking(s->to_dst_file, false);
> > >  
> > >      /*
> > >       * Open the return path. For postcopy, it is used exclusively. For
> > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > > index cf6115e699..8ee44c5ac9 100644
> > > --- a/migration/qemu-file.c
> > > +++ b/migration/qemu-file.c
> > > @@ -338,22 +338,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
> > >          return 0;
> > >      }
> > >  
> > > -    /*
> > > -     * This feature triggers acquisition of mutexes around every
> > > -     * read and write. Thus we must not sit in a blocking read
> > > -     * if this is set, but must instead poll proactively. This
> > > -     * does not work with some channel types, however, so must
> > > -     * only pre-poll when the featre is set.
> > > -     */
> > > -    if (qio_channel_has_feature(f->ioc,
> > > -                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
> > > -        if (qemu_in_coroutine()) {
> > > -            qio_channel_yield(f->ioc, G_IO_IN);
> > > -        } else {
> > > -            qio_channel_wait(f->ioc, G_IO_IN);
> > > -        }
> > > -    }
> > > -
> > >      do {
> > >          struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> > >          len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> > >
> > >
> > > With regards,
> > > Daniel
> > 
> 

-- 
Peter Xu


