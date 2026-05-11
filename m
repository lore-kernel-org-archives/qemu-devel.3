Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49252CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSQd-00017M-Fq; Mon, 11 May 2026 11:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMSQa-000134-U9
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMSOu-0003Sb-9J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778512711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxdZYlw1ty9vfivcQWySHQRMD78iIccGW15+wthpce4=;
 b=HXwVVigvkQAooNTaY2aPL+KUVh8TOy1p5CC0mrXfwQ8tjJrPUlgEc0smGBanyJlYZGoi7o
 hw5vgun2JZeRikodF9f4F2RYQ5SmWmGksrIRiRQ4YImbeKoxLiXofXkpfCWGCa+PWV4C+j
 yxGW8P5YFLDOdkFMi6ZBYH4OepvUrWk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-l9gcePzAMLCkQ1Q6FNOO-A-1; Mon, 11 May 2026 11:18:30 -0400
X-MC-Unique: l9gcePzAMLCkQ1Q6FNOO-A-1
X-Mimecast-MFC-AGG-ID: l9gcePzAMLCkQ1Q6FNOO-A_1778512709
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-902e1e4f8ccso1114658885a.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778512709; x=1779117509; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mxdZYlw1ty9vfivcQWySHQRMD78iIccGW15+wthpce4=;
 b=mQBdrGKN/DMYSUKOwgcY2hKVhVOkGzQDvZFlgo4dNyHcvUZEQ79Lcv82lAl+lAk1gD
 65iRAWHcQ0vY9SBQzOgaf5Djw45fP2ROa1+JRfCt2HzDPYaNOH9J6by9x1RXXUuBG1bK
 sF2YXmtRCBj+qpX7/poMoJpQcNGFNady/LDVHEsmunraQ924PLV935Hf14JAj3Ukebm4
 mmhzqyjxvcpwf6ww6ZaSgxKhyYtCieVQsGKCj0B2/oBidUQ5HUp2B0QzQx3RpEF6lZqM
 SIXGfxPNnRzK8F7RQ5OxFWRvwdmkxZ4YwagpHg/25MkVhrvbisRHk+sDYnlkpxTdWRe7
 LsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512709; x=1779117509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxdZYlw1ty9vfivcQWySHQRMD78iIccGW15+wthpce4=;
 b=EzICx9yGrlm6tudlGV5uBKzegoqfnuSMUoWM2ObNj7F7N2vbOdknw9zn6So/HUilJo
 9jkf6JWWZms1Kvmz7vTBtzHjmLUkiPXucNn7kVpwcZd7nLPCy1CzpK6mYBj1xd31nucC
 56iIYsxKf9PH9g59mOA/JHJVLcZnkucx3oFs4euVb9AQoAet8UsRhCUpHOtzgOZ6A7C6
 siK5ob12gvA2a+AtTRd8boaUIjlazA+xHFFVKBBZiuP6ByZ0OVqntpL4DGqUY6xzwHGR
 AJi+cC+/2iN1GuNmyiviblcgUZDMHqVOLzzlWGJbsvupFGAmWtxhreMP87x8hTh36m5T
 0MQQ==
X-Gm-Message-State: AOJu0YyrSukS0NY894xdCXAMTFr2u6Q9e75sjazayOXSQMp6IiTnP7AP
 4kUoBGCfBvlnXcWmA6UNTRtLyV1vEZEn/0WNXh/fyXEU9m50Nka/cTDOmhPvW6vfMgl7TX6dZxz
 XGn70sqi3klW3mrQn544zK3VxmwFy5/oaqnjDfDjsdhGtxlcnsK621OUy
X-Gm-Gg: Acq92OExNKwUCfUvi3UfsTxPKm0HXnYFi0T1VxAMVQ9qX1I+vtab6G3UwsgNSLDU0pV
 ZVvh8JwHgSxObkyfMF3jXv8JZR8qIGtgnoKlyugzy+3LpWLZ/BuDLZ0kw/M7iJp/79KA0KpZlQW
 YL/BCZCJz7HyJC1XQz+niyH5xc82PjpB5u2U2RtTZNqC3GF4348VLPLR5It8qlLBdvgws3MlI+c
 TpZ+uK1TJ2IG56Qd5h1X32OLS+jJrhrsuW9ZuWiwLopKrqAetfnpqCDLT0wBVIvVgYnGgWfmJq8
 ouuLiIttlwuOqCV+MojQmOsEdvuS1W+ueVYuv8sfmwylXq7QI4D/XbbPE98Ohw6NrUKL7uSyGbP
 3moCHhroUxPJCxoRdt0EjiXFZvLQvwLirfxc3AE4LVK+DvGg=
X-Received: by 2002:a05:620a:44c5:b0:8f3:6160:863f with SMTP id
 af79cd13be357-904d4584a8amr3583312285a.14.1778512709234; 
 Mon, 11 May 2026 08:18:29 -0700 (PDT)
X-Received: by 2002:a05:620a:44c5:b0:8f3:6160:863f with SMTP id
 af79cd13be357-904d4584a8amr3583299185a.14.1778512708126; 
 Mon, 11 May 2026 08:18:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b87c3e01sm1159422985a.26.2026.05.11.08.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:18:27 -0700 (PDT)
Date: Mon, 11 May 2026 11:18:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration: Fix possible division by zero on calc
 expected downtime
Message-ID: <agHzQnXFQbnam-RF@x1.local>
References: <20260511141049.1293449-1-peterx@redhat.com>
 <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
 <agHs1PcxZYJtba4W@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agHs1PcxZYJtba4W@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 10:51:00AM -0400, Peter Xu wrote:
> On Mon, May 11, 2026 at 03:26:06PM +0100, Peter Maydell wrote:
> > On Mon, 11 May 2026 at 15:10, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> > > that the value will be calculated on-demand.  One side effect on the change
> > > is QEMU will allow the calculation to happen anytime even if there's no
> > > transfer happening for a short while.
> > >
> > > PeterM reported an ubsan report from clang when running migration-test with
> > > aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> > > concurrently so some of the src QEMU may not get chance to push any data,
> > > causing mbps to be 0:
> > >
> > > ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
> > >
> > > Fix it by checking mbps non-zero before the devision.
> > >
> > > Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index b6f78eb3ac..b06e577328 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -1044,12 +1044,18 @@ static bool migrate_show_downtime(MigrationState *s)
> > >  /* Return expected downtime (unit: milliseconds) */
> > >  int64_t migration_downtime_calc_expected(MigrationState *s)
> > >  {
> > > +    double bw;
> > > +
> > >      if (mig_stats.dirty_sync_count <= 1) {
> > >          return migrate_downtime_limit();
> > >      }
> > >
> > > -    return mig_stats.dirty_bytes_last_sync /
> > > -        migration_get_switchover_bw(s) * 1000;
> > > +    bw = migration_get_switchover_bw(s) * 1000;

PS: I think I got the math wrong, not that it matters anymore.. :(

> > > +    if (!bw) {
> > > +        return INT64_MAX;
> > > +    }
> > > +
> > > +    return mig_stats.dirty_bytes_last_sync / bw;
> > 
> > I think this is still UB if bw is a value that's nonzero
> > but still small enough that mig_stats.dirty_bytes_last_sync / bw
> > is greater than INT64_MAX. It might be more robust to do
> > something like:
> > 
> >     double expected = mig_stats.dirty_bytes_last_sync /
> >         migration_get_switchover_bw(s) * 1000;
> > 
> >     if (expected >= (double)INT64_MAX) {
> >         return INT64_MAX;
> >     }

This actually fails to fix the ubsan issue and I can still reproduce,
because the ubsan issue was a Nan reported, where it seems when Nan found
in normal such evaluations it'll return FALSE.  I'll need to use:

        if (expected < (double)INT64_MAX) {
            return (int64_t)expected;
        }

I'll add a rich comment when repost.

> >     return (int64_t)expected;
> > 
> > (which will also handle the infinity case, because
> > in IEEE fp infinity is larger than any finite value).
> 
> I almost treated mbps as integer, because when it's non-zero it almost
> should be at least ~10byte/s (our unit is (uint)transferred / 100ms).. so I
> doubt if the issue can happen. But indeed it's theoretically flawed.
> 
> I'll repost, thanks for the careful review, Peter.
> 
> -- 
> Peter Xu

-- 
Peter Xu


