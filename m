Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C699AC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujJ34-0003qE-Js; Tue, 05 Aug 2025 10:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujJ2M-0003WN-5r
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujJ2K-0005Lv-0i
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754405585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNfIZ9AW2meqZzztIQqpKeIMoQEAemTTfE5dolQvATE=;
 b=c0jcdK/cKZK8jU4OO1j7Lln5qr2mUMVKxuUGzb0hR6uyB+cuVPF6/4W2D82KPluoTcyKCI
 u9F8eXpi4CB3LpkMfBki0YYJjw4rCwErcgOiuBqwmxsWhLAu2JFivz3HL6GP0QWdw1d+Eh
 Ki2p6Fj8t2Mv9p7MzHfKee7JKqnH+uc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-W5KuXMYWNHWotUg_Rn2r-A-1; Tue, 05 Aug 2025 10:53:02 -0400
X-MC-Unique: W5KuXMYWNHWotUg_Rn2r-A-1
X-Mimecast-MFC-AGG-ID: W5KuXMYWNHWotUg_Rn2r-A_1754405582
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4af156a27b1so114702001cf.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 07:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405582; x=1755010382;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNfIZ9AW2meqZzztIQqpKeIMoQEAemTTfE5dolQvATE=;
 b=wVTB6KuHVUY9lK7/f1D53kEHAz49MQWc7tpIMT1IFWlUi2KKbfK8Ed+chUVeku8b96
 3tYu2b0i5sNxYypMQOwPhVQbqHkZ8udMrsQZ3LXUdRBWstGijSfnL/pFEg5GPzUV/zwE
 f1qU3fzkkL42oKl8zvudb+ZHFwAlwwj45IpRUBraSKl/STa3aFuueb3qSne+LcW/QF1k
 adP5zQuTrYhpWk9zGlThfJjKY4PgBX5XrKToeS9Q8WDRLP0BFkODMMdkpxTRji8eSXWV
 PQ0BoDvU0ozha1HJqQsWGGdEIGyGQfh9vsXmYZ0k/STDzop+x4bTt8E24cQ9bTDRQSrm
 AZlg==
X-Gm-Message-State: AOJu0YwIoelfLCcoHvxl9MntmwKkYumHFfPoH6wVInVcej72nXJXdlCI
 OhJs6OGxEVMMd++Q2ZwQguxw+5qo4gLrrLuDCYQNVU9I1hZKm5Z8Hz9Yjysq51gOCZOSaFo8/M1
 3xaKPxdfo7jogGzCCgxpP8avCkC1zIyGgC2nU04z6geM92w5BHxtCj/a4
X-Gm-Gg: ASbGnctPOsiZs0X6WPp1bYS59ZWpgAdx5gcz+l9Equ+kHD/7ooGHtw2Orjpmtcw7Q7F
 RzOlM1UNfD6lWvp+5VcprpA3opWozO+lnKSRMH5V1R+gHTY8WJm6CMmrm3YeCNk7qKcrhySGRfM
 OVTZZhAagDUUL9B1A5eMg+cMgNUDvqxgiUzYB0SNtSY32gG9WFXaaixVPgECjszeXUnCkbVNxeT
 S3vDFmI/sjrU8wYw6hHMcEB52NYGo0B3Aj2lYY5uSicaPJtM79XHGltOXBXJIl+giK4UY83/k1y
 DxXN3QGtfr7tcXy39Gu18gJ9XalT
X-Received: by 2002:a05:622a:1a81:b0:4b0:656c:236e with SMTP id
 d75a77b69052e-4b0656c53e9mr100286151cf.6.1754405582202; 
 Tue, 05 Aug 2025 07:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKnNRkDxIorEhmO2tGG5SBbHCGIlggV7Cp53oCpOb/XtDC/3pOss0IEqSOC27/9WDoTJKf8w==
X-Received: by 2002:a05:622a:1a81:b0:4b0:656c:236e with SMTP id
 d75a77b69052e-4b0656c53e9mr100285681cf.6.1754405581520; 
 Tue, 05 Aug 2025 07:53:01 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06890e821sm27041761cf.26.2025.08.05.07.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:53:01 -0700 (PDT)
Date: Tue, 5 Aug 2025 16:52:58 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <ekcc4p5uap6g674ljwjpa7q42yybrl5vabxhodgfmo6awcvzq2@s4dmgpfpd4jz>
References: <20250801170212.54409-1-berrange@redhat.com>
 <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
 <87jz3i3n0u.fsf@suse.de> <aJHYSwGXTOF4o00n@redhat.com>
 <87h5yl3mt2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5yl3mt2.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
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

Hi all!

On 2025-08-05 10:44, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Aug 04, 2025 at 04:27:45PM -0300, Fabiano Rosas wrote:
> >> Juraj Marcin <jmarcin@redhat.com> writes:
> >> 
> >> > Hi Daniel,
> >> >
> >> > On 2025-08-01 18:02, Daniel P. Berrangé wrote:
> >> >> This is a followup to previously merged patches that claimed to
> >> >> workaround the gnutls bug impacting migration, but in fact were
> >> >> essentially non-functional. Juraj Marcin pointed this out, and
> >> >> this new patch tweaks the workaround to make it actually do
> >> >> something useful.
> >> >> 
> >> >> Daniel P. Berrangé (2):
> >> >>   migration: simplify error reporting after channel read
> >> >>   migration: fix workaround for gnutls thread safety
> >> >> 
> >> >>  crypto/tlssession.c   | 16 ----------------
> >> >>  migration/qemu-file.c | 22 +++++++++++++++++-----
> >> >>  2 files changed, 17 insertions(+), 21 deletions(-)
> >> >> 
> >> >
> >> > thanks for finding a fix for the workaround. I have tested it and it
> >> > resolves the issue.
> >> >
> >> > However, it significantly slows down migration, even with the workaround
> >> > disabled (and thus no locking). When benchmarking, I used the fixed
> >> > version of GNUTLS, VM with 20GB of RAM which were fully written to
> >> > before starting a normal migration with no workload during the
> >> > migration.
> >> >
> >> > Test cases:
> >> > [1]: before this patchset
> >> > [2]: with this patchset applied and GNUTLS workaround enabled
> >> > [2]: with this patchset applied and GNUTLS workaround disabled
> >> >
> >> >   | Total time | Throughput | Transfered bytes |
> >> > --+------------+------------+------------------+
> >> > 1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
> >> > 2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
> >> > 3 |  72 426 ms |  2343 mbps |   21 215 009 392 |
> >> 
> >> Thanks testing this. I had just managed to convince myself that there
> >> wouldn't be any performance issues.
> >> 
> >> The yield at every buffer fill on the incoming side is probably way more
> >> impactful than the poll on the RP.
> >
> > Yeah, that's an unacceptable penalty on the incoming side for sure.
> >
> > How about we simply change the outbound migration channel to be in
> > non-blocking mode ?   I originally put it in blocking mode way back
> > in 9e4d2b98ee98f4cee50d671e500eceeefa751ee0, but if I look at the
> > QEMUFile impl of qemu_fill_buffer and qemu_fflush, but should be
> > coping with a non-blocking socket. qemu_fill_buffer has explicit
> > code to wait, and qemu_fflush uses the _all() variant whcih has
> > built-in support for waiting. So I'm not seeing an obvious need
> > to run the channel in blocking mode.
> >
> 
> It's definitely simpler and I think it works. It's uncomfortably late
> though to add a bunch of glib event loop code to the migration
> thread. Is the suggestion of moving the yield to tlssession.c even
> feasible?
> 
> Juraj, are you able to get some numbers with this?

Yes, I have tested it with this patch and it still works, now without
any noticeable performance regressions.

Test cases:
[0]: before this patchset with GNUTLS workaround disabled
[1]: before this patchset with GNUTLS workaround enabled
[2]: with this patchset applied and GNUTLS workaround enabled
[2]: with this patchset applied and GNUTLS workaround disabled

  | Total time | Throughput  | Transfered bytes |
--+------------+-------------+------------------+
0 |  32 464 ms |  5 228 mbps |   21 213 283 021 |
1 |  32 429 ms |  5 236 mpbs |   21 224 062 348 |
2 |  32 934 ms |  5 150 mbps |   21 200 558 083 |
3 |  31 547 ms |  5 384 mbps |   21 229 225 792 |


Tested-by: Juraj Marcin <jmarcin@redhat.com>


Best regards

Juraj Marcin

> 
> > Using non-blocking will prevent the return path thuread setting
> > in a read() call, so we won't have mutual exclusion between read
> > and write which this patch was trying to avoid
> >
> > ie, this delta on top of this patch:
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25d..1eaabc1f19 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -4002,7 +4002,7 @@ void migration_connect(MigrationState *s, Error *error_in)
> >      }
> >  
> >      migration_rate_set(rate_limit);
> > -    qemu_file_set_blocking(s->to_dst_file, true);
> > +    qemu_file_set_blocking(s->to_dst_file, false);
> >  
> >      /*
> >       * Open the return path. For postcopy, it is used exclusively. For
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index cf6115e699..8ee44c5ac9 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -338,22 +338,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
> >          return 0;
> >      }
> >  
> > -    /*
> > -     * This feature triggers acquisition of mutexes around every
> > -     * read and write. Thus we must not sit in a blocking read
> > -     * if this is set, but must instead poll proactively. This
> > -     * does not work with some channel types, however, so must
> > -     * only pre-poll when the featre is set.
> > -     */
> > -    if (qio_channel_has_feature(f->ioc,
> > -                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
> > -        if (qemu_in_coroutine()) {
> > -            qio_channel_yield(f->ioc, G_IO_IN);
> > -        } else {
> > -            qio_channel_wait(f->ioc, G_IO_IN);
> > -        }
> > -    }
> > -
> >      do {
> >          struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> >          len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> >
> >
> > With regards,
> > Daniel
> 


