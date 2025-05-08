Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83004C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3Mk-00029s-Tq; Thu, 08 May 2025 11:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uD3Mi-00027L-Jm
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uD3Mg-0003jH-Of
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746718849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwA504YPBGLxJMAq0kJ7g4FAfYLGpGM0xwJHbVHNdL8=;
 b=FGbfO+bo+M1j09QxKf26KK2imyXlHMt1n5A+fOO2Vkz4+/wQzWpcFH6aRZXW8AWKQ5Ts1p
 T9r4OaDhYpL+7tQ05/yt0L61UYhDd07/TgjeHvXZS+wp0JB2fQpy/jOLwUywBQlsejsAYd
 6k5dWzK/IxH01DL52tC4zxfPd2fEdJQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-YONxHUPsMQqgFdaF2Cq-AQ-1; Thu, 08 May 2025 11:40:43 -0400
X-MC-Unique: YONxHUPsMQqgFdaF2Cq-AQ-1
X-Mimecast-MFC-AGG-ID: YONxHUPsMQqgFdaF2Cq-AQ_1746718843
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5e2a31f75so348750385a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 08:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746718842; x=1747323642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwA504YPBGLxJMAq0kJ7g4FAfYLGpGM0xwJHbVHNdL8=;
 b=jra74ymDJpiO8AjhdIuhAL6gEdvq66VhfnfCA9XN5wWwJ/zRjtmqrHrOiVJNSigQ4I
 rf0KRklInkT8C5eOfK2ET6wYgbD7xZ7X0JgFRF1q2+WthR6sgBuvwmpQi9F3ruk15u8q
 P6az+F5dlxe7agbANT9BEN5TF30V1DkatQD1hqH/xcoxxuIUD41HeQ9tI8gzMD1l4ts5
 ciSHWcugL81Tihpesprg5V+/BqzGtOoD5IYp1ccO7xj58/+ie9emdB2rKrSxglUQeron
 lWTcx7eIZGRsjRROUz5V3OeOE/R8wtn36uIasn7p9UO1mI7DNSm/79TgM+69aYG//HtY
 17nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuQavUZeZOYMlN8mVoXsVyu/reARWxxPeKkMh28NLcOWJXqKn94nPQQLvo+7FiyHw0uF4ZsQOp8fhH@nongnu.org
X-Gm-Message-State: AOJu0YwnSOx3hDnE+NUDqxW47FN7rtk/8eVX6XHfbSO1oX+MVIBZZgxv
 xss7iFUgiJwsiQv/3lmZhe5O9R244t0nQxoyeQqvjgCSg34XK6Du96Xjh9SakPV44nWIfp2iZ+I
 2rv8wyi84x1VAb98ACQXTeVB7Sprr9V9wdiYpL2mof1NIg/1BHva7GbboG0+B
X-Gm-Gg: ASbGnct2fySK2/G2rW32M52CZCbULq/SWA7k5z7epc5hsGJVt5D14NM3bjnht57Ym04
 ESSpeb7UUxnAmed73nIjgXH1E8wQsNtW/CUBeVWqqJVKNgkPyPzba9sh86Pp6MOod9+CbpDWsYM
 Mrv8Rgr1EqpVVHxbTvdzU3qMVuIDh2ZVBy+VuqLuHl3Fn/21IDhaEveTNqHJR1kJ9H4yVMwk6jd
 oHONyU58A8a0kXCrHXnlwK0umlCT3hOiGGm/0aWWwMm1dJRbq/RxFlP2Pm2obAwwFlXSiAWtyof
 gUM=
X-Received: by 2002:a05:6214:f03:b0:6f2:d45c:4a25 with SMTP id
 6a1803df08f44-6f542adfa97mr110959096d6.41.1746718832016; 
 Thu, 08 May 2025 08:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrk1CBlTFat73f5dmbbYIAugRjw6ebZYbo0uKTVH0q609aXt2S+dN88S3Fc/eqX9JgWF7TPA==
X-Received: by 2002:a05:620a:2552:b0:7c7:a591:4f9b with SMTP id
 af79cd13be357-7cd011069bemr15681985a.28.1746718821404; 
 Thu, 08 May 2025 08:40:21 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f64c67sm6759285a.33.2025.05.08.08.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 08:40:21 -0700 (PDT)
Date: Thu, 8 May 2025 11:40:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
Message-ID: <aBzQYslYtUZgXjgO@x1.local>
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
 <87ecwzfbnk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecwzfbnk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, May 08, 2025 at 10:57:19AM -0300, Fabiano Rosas wrote:
> Prasad Pandit <ppandit@redhat.com> writes:
> 
> > From: Prasad Pandit <pjp@fedoraproject.org>
> >
> > During multifd migration, zero pages are are written if
> > they are migrated more than ones.
> 
> s/ones/once/
> 
> >
> > This may result in a migration hang issue when Multifd
> > and Postcopy are enabled together.
> >
> > When Postcopy is enabled, always write zero pages as and
> > when they are migrated.
> >
> > Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> 
> This patch should come before 1/3, otherwise it'll break bisect.

We could squash the two together, IMHO.

> 
> > ---
> >  migration/multifd-zero-page.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > v10: new patch, not present in v9 or earlier versions.
> >
> > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> > index dbc1184921..9bfb3ef803 100644
> > --- a/migration/multifd-zero-page.c
> > +++ b/migration/multifd-zero-page.c
> > @@ -85,9 +85,27 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> >  {
> >      for (int i = 0; i < p->zero_num; i++) {
> >          void *page = p->host + p->zero[i];
> > -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> > +
> > +        /*
> > +         * During multifd migration zero page is written to the memory
> > +         * only if it is migrated more than ones.
> 
> s/ones/once/
> 
> > +         *
> > +         * It becomes a problem when both Multifd & Postcopy options are
> > +         * enabled. If the zero page which was skipped during multifd phase,
> > +         * is accessed during the Postcopy phase of the migration, a page
> > +         * fault occurs. But this page fault is not served because the
> > +         * 'receivedmap' says the zero page is already received. Thus the
> > +         * migration hangs.

More accurate version could be: "the thread accessing the page may hang".
As discussed previously, in most cases IIUC it won't hang migration when
accessed in vcpu contexts, and will move again when all pages migrated
(triggers uffd unregistrations).

> > +         *
> > +         * When Postcopy is enabled, always write the zero page as and when
> > +         * it is migrated.
> > +         *
> 
> extra blank line here^
> 
> > +         */
> 
> nit: Inconsistent use of capitalization for the feature names. I'd keep
> it all lowercase.
> 
> > +        if (migrate_postcopy_ram() ||
> > +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> >              memset(page, 0, multifd_ram_page_size());
> > -        } else {
> > +        }
> > +        if (!ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> >              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
> >          }

Nitpick below: we could avoid checking the bitmap twice, and maybe move it
a bit is easier to read.

Meanwhile when at it.. for postcopy if we want we don't need to set all
zeros.. just fault it in either using one inst.  Summary:

void multifd_recv_zero_page_process(MultiFDRecvParams *p)
{
    bool received;

    for (int i = 0; i < p->zero_num; i++) {
        void *page = p->host + p->zero[i];

        received = ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i]);
        if (!received) {
            ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
        }

        if (received) {
            /* If it has an older version, we must clear the whole page */
            memset(page, 0, multifd_ram_page_size());
        } else if (migrate_postcopy_ram()) {
            /*
             * If postcopy is enabled, we must fault in the page because
             * XXX (please fill in..).  Here we don't necessarily need to
             * zero the whole page because we know it must be pre-filled
             * with zeros anyway.
             */
            *(uint8_t *)page = 0;
        }
    }
}

We could also use MADV_POPULATE_WRITE but not sure which one is faster, and
this might still be easier to follow anyway..

-- 
Peter Xu


