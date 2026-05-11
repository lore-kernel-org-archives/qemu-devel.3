Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6E5CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUjG-0000ds-8m; Mon, 11 May 2026 13:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMUis-0000b9-9o
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMUio-00085B-VT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778521633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jp6O0lTumsNVIRnqWI477lA7goMO5DdtMYPb4GB2MWo=;
 b=RSHb20IoyiK67/WVO9Hm8KBEI80ZIn0w9IV5Q/LOblP9w7tNYk69yRSh9J03wGSQUbwLV3
 MAjTfP5l813kLlGVGhKncwURctjSCEist9F+Hck5BZx3SOuN+tUAjIYZFELwgj2rAER0j4
 p7Q0sjiJz59xi2o3y8GBwaUhg+bnmRk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-6XOezLMVOoeBRtQLXKyJ7Q-1; Mon, 11 May 2026 13:47:11 -0400
X-MC-Unique: 6XOezLMVOoeBRtQLXKyJ7Q-1
X-Mimecast-MFC-AGG-ID: 6XOezLMVOoeBRtQLXKyJ7Q_1778521631
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eaaf673eb4so920954085a.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778521631; x=1779126431; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jp6O0lTumsNVIRnqWI477lA7goMO5DdtMYPb4GB2MWo=;
 b=L/vYN0+Z8/LXY6mfwhMZRYl2vgMbFIN6c0bD5VPtgm+cyyXl2h+OF5ei6AAwM8gSDa
 lAWympj5RbfJOnrPjDz0LTqRPk97Ep5VD6mlIUsAT28L3xI/2w3xMQRP8EHUUl/6BXLe
 OR1jIxJnrrqx5a8WPi5M0QMJSemLfxgFcAwa+x9yB9n+1HZUHq6+xojZgXSFBUN/oi2K
 1uo5j1R7lytWtAfWFONUprCN8Vo1JLpqYukRPJ/0hartD++Qnfd+i9GZm98xcI3P3HWH
 l3vnF8Z5OxXnJk0SPcDypcMMfqUA9rGmNHFvSZFa01pf2wB86K+NI6cqauPlEnqsPvZt
 Whgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778521631; x=1779126431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jp6O0lTumsNVIRnqWI477lA7goMO5DdtMYPb4GB2MWo=;
 b=Osb8HJWhSM4GpewYsG2r4j4S323ZIdXwwe29h8Dg4sJz9UIOe9kiJPnzpD+Hx0TX5y
 VHyehbUz3qMfBwb+c7HTgBfx1sbmogeVNhANCuMIX4wNbhO5EPaOeS3g6HnHMRKdbnIy
 1zPiHSuw58tunSAxuJWVbPwS1Lh4/CqQoBZ5fq4qW3rFnx67hujcrAe2EK2Yq9L72dP9
 Y5tqb8QB/DxoQH9KNIX8TyqOKHjdtNHqHI2+EVCRFn5MB080pybJi1vHe7uQz8+l+zqi
 BDZHwmI0qr4YJmBQWXSmifMZ0vxS7ggavMKdp8n5hbQbHZIWliaeyaZnPZX8J7xTDdo5
 zLKA==
X-Gm-Message-State: AOJu0Yx0UFseN6EpwUP9zTZ+7Fb/fD6lGFc/NiKffF6MsqWiiW7cwRsm
 OV8qgnyuQtFlaGFatRsXAbeOGcbq8jUN6KEUiQ3ZCg6Kw0U5tpn+O+mGfY7Pn0FeMRfTsWL1RmH
 00Ax5zkUt0yHSCh3GWrei27D0skUa16JEVP+R31CBLQwuR44HSOxaYOvj
X-Gm-Gg: Acq92OFAAFzIOcsdtt7F9yE3EicnzhcO5/2aeYzOClJ4D+r6KDF6VTo3wsW+pfLdmLg
 hCGA1NyunIzIY+n1y0r8ytCTjp7+TWL8uJ5IGMe4R70B0QpBCiimBjp1jiIsxfKj1vzrSxRtbuG
 DF0tyd/cKx8gUXECPg6df0sjdwfQ3lv+5aV+2UhrxMfu9jMvMFvIq7cmCxU9j59ij8KJ+rwAkT8
 TB32eAySv2Tjm5BiI6o6qn1aLQyHKYAcs5VAs4H0Ag7mCnTpEK838D3c3SI/qAFVe7kJ4JmB2J5
 VFCSty07wKxJ1a7wYE+61IdWj3VmOBA1AAUM6A/I4nJbYxmTVynKfaj06Pm8bnbw//UScph8xOJ
 zPMDAOPpctebizlbaiOKVjhPTbRU9CtCB6uDWJXspq4qy3kM=
X-Received: by 2002:a05:620a:c45:b0:8d6:39c0:e6a0 with SMTP id
 af79cd13be357-90910ffe81cmr1628188485a.54.1778521630893; 
 Mon, 11 May 2026 10:47:10 -0700 (PDT)
X-Received: by 2002:a05:620a:c45:b0:8d6:39c0:e6a0 with SMTP id
 af79cd13be357-90910ffe81cmr1628180985a.54.1778521630211; 
 Mon, 11 May 2026 10:47:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53ca982a1sm348972346d6.38.2026.05.11.10.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:47:09 -0700 (PDT)
Date: Mon, 11 May 2026 13:47:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] migration: Fix possible division by zero on calc
 expected downtime
Message-ID: <agIWHJExoRQqfcNT@x1.local>
References: <20260511152019.1316898-1-peterx@redhat.com>
 <CAFEAcA_Hk5EnPWK3Ho1fQVeN0o+2VFjjjz+1sZQk2f3f_CRmWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Hk5EnPWK3Ho1fQVeN0o+2VFjjjz+1sZQk2f3f_CRmWg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11, 2026 at 04:47:22PM +0100, Peter Maydell wrote:
> On Mon, 11 May 2026 at 16:20, Peter Xu <peterx@redhat.com> wrote:
> >
> > Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> > that the value will be calculated on-demand.  One side effect on the change
> > is QEMU will allow the calculation to happen anytime even if there's no
> > transfer happening for a short while.
> >
> > PeterM reported an ubsan report from clang when running migration-test with
> > aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> > concurrently so some of the src QEMU may not get chance to push any data,
> > causing mbps to be 0:
> >
> > ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
> >
> > Fix it by properly handle both Inf and Nan.  One note is we can't use
> > ">"/">=" check here otherwise we cannot cover Nan.
> >
> > Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index b6f78eb3ac..e4103cd3f0 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1044,12 +1044,28 @@ static bool migrate_show_downtime(MigrationState *s)
> >  /* Return expected downtime (unit: milliseconds) */
> >  int64_t migration_downtime_calc_expected(MigrationState *s)
> >  {
> > +    double expected_ms;
> > +
> >      if (mig_stats.dirty_sync_count <= 1) {
> >          return migrate_downtime_limit();
> >      }
> >
> > -    return mig_stats.dirty_bytes_last_sync /
> > +    expected_ms = mig_stats.dirty_bytes_last_sync /
> >          migration_get_switchover_bw(s) * 1000;
> > +
> > +    /*
> > +     * This "<" check covers two cases where we want to fallback to
> > +     * INT64_MAX, the 1st case is obvious, but the 2nd is not:
> > +     *
> > +     * (1) when expected_ms is Inf, or anything too big for int64_t
> > +     * (2) when expected_ms is Nan (division by zero), evaluation of this
> 
> This should say "zero divided by zero" -- general division by
> zero gives Inf, and it's only 0 / 0 that runs into NaN.
> 
> > +     *     if clause will be FALSE
> > +     */
> > +    if (expected_ms < (double)INT64_MAX) {
> 
> This works, but maybe we should write it out
>       if (isnan(expected_ms) || expected_ms < (double)INT64_MAX) {

I agree using isnan() is better than comment. Though code in the patch for
the next line here is:

+           return (int64_t) expected_ms;

Do you think below should work?

    expected_ms = ...;

    /* For isnan() (0/0) case, we can return anything; return MAX too */
    if (isnan(expected_ms) || expected_ms >= (double)INT64_MAX) {
        return INT64_MAX;
    }

    return (int64_t) expected_ms;

Thanks,

-- 
Peter Xu


