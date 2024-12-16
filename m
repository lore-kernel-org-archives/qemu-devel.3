Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4377E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFue-0007m5-0V; Mon, 16 Dec 2024 13:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNFuS-0007lc-3N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNFuQ-0004nW-1M
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734374013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LE3l0+mNR+unFmOqPsmb78PgN3Ra+MNvjjHYAufyUYw=;
 b=JIIJnK/6RYoUHQbErKr15OBZi6hWN8H3L9ZTCeNvW0sZYJFGTRf8D6cGI3VUYmVU51tse5
 WHLmc1IzFstRFAFA3hPjskrjLhi5E2Xsn4FIpIcd2MpIBo4FdVKl9uD8EDoqXshQrIeTDx
 EpzKl4PQ3gWbjOQxQHFPyHf9xz6aTTU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-c0PnV4GlOrKh3X6qNtsuwA-1; Mon, 16 Dec 2024 13:33:30 -0500
X-MC-Unique: c0PnV4GlOrKh3X6qNtsuwA-1
X-Mimecast-MFC-AGG-ID: c0PnV4GlOrKh3X6qNtsuwA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d884999693so74294806d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 10:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734374009; x=1734978809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE3l0+mNR+unFmOqPsmb78PgN3Ra+MNvjjHYAufyUYw=;
 b=An6w1RQY5YXPihbKtwPLuGSwK6Cn63p7TEd4/7NlD3WsWcNXLu4ve5kZqVjyrp1FIy
 rdxwBo+/NcZQxG7Cr27+mssOBmreIwZsPP/jOT9j8MKTVjEqFHzbw1mT3Xylx2URsZWU
 BErm0soor7wT8YGAC2CBZNA4zia/opnSDi5ksF07JbRyB1g8EjZPawbh8L8e+DJUP6zP
 e3F+VpvSUojjAMAvcQMxBnM1SOVQ6FgpLg7wHEnEXOSGYQg8bHdYV/shhELSGdcQRtgH
 lTIBLqLGf0l6Vo+TBRL77IEf9cA8fcDTGrDCFnmSfKmjrdD0ys20ABo6MTElEN7FUEtI
 oapw==
X-Gm-Message-State: AOJu0YyU3Hz5i8jmfFEohy1+qsfKWSs0mPmy10nuWHl2bNvGS2VLhSZh
 +vHWZnLTfggriQkVCfLvONWxPse2PXtGB7FqsougC2/uOGb2EhyZip7GDgEj1IFodJNi7JodQZn
 sDJ9KIk2vv1bCxVF6zyXAJ74zPQVJbDwER5VmSSD0uxJOTYeaG2vo
X-Gm-Gg: ASbGncuS1b6q8nfoC1Oa0AQX2Jgt8mZuO/14XRuPNIgnsRf+lTfdg0zw5KShhRkyhD5
 xSwFDiWz4/7Mt15f/naBOmdeaz40lEXOs/9EASOUjV0BT3y0Vp9GMq5cpg4Bz9bRy+HzmAQ7oNc
 Jzxi57jEAvIHsDRH0MqArExkjYhZKLJDetBwthnHDNejTaIKdKKljR+eOQxkH19223Aq5inHjOK
 lkDuYbKt3EOtEMzmFY8SsVGsJH1Urn5MUbFiOz+Hb+YlZRDC5w9B234iBHjHMGsR7TYzL7/rT1R
 wS4LXPEBxJ1YUCA3IA==
X-Received: by 2002:a05:6214:f6c:b0:6ce:2357:8a2e with SMTP id
 6a1803df08f44-6dc9684fd5dmr239923356d6.37.1734374009703; 
 Mon, 16 Dec 2024 10:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz8XTbuDLl0ceUsYlo8yEOyQe8O7ciIzLdzb+JDrw2nbcYZtpDFczzF9dIvsIXc3lsXrlP9A==
X-Received: by 2002:a05:6214:f6c:b0:6ce:2357:8a2e with SMTP id
 6a1803df08f44-6dc9684fd5dmr239923026d6.37.1734374009359; 
 Mon, 16 Dec 2024 10:33:29 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cd9b9asm30679061cf.51.2024.12.16.10.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:33:28 -0800 (PST)
Date: Mon, 16 Dec 2024 13:33:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 6/6] migration/block: Rewrite disk activation
Message-ID: <Z2Bydnax8_J26N3K@x1n>
References: <20241206230838.1111496-1-peterx@redhat.com>
 <20241206230838.1111496-7-peterx@redhat.com>
 <87v7vjwrel.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7vjwrel.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Dec 16, 2024 at 12:58:58PM -0300, Fabiano Rosas wrote:
> > @@ -3286,6 +3237,11 @@ static void migration_iteration_finish(MigrationState *s)
> >      case MIGRATION_STATUS_FAILED:
> >      case MIGRATION_STATUS_CANCELLED:
> >      case MIGRATION_STATUS_CANCELLING:
> 
> Pre-existing, but can we even reach here with CANCELLED? If we can start
> the VM with both CANCELLED and CANCELLING, that means the
> MIG_EVENT_PRECOPY_FAILED notifier is not being consistently called. So I
> think CANCELLED here must be unreachable...

Yeah I can't see how it's reachable, because the only place that we can set
it to CANCELLED is:

migrate_fd_cleanup():
    if (s->state == MIGRATION_STATUS_CANCELLING) {
        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                          MIGRATION_STATUS_CANCELLED);
    }

In this specific context, it (as a bottom half) can only be scheduled after
this path.

Looks like the event MIG_EVENT_PRECOPY_FAILED will work regardless, though?
As that's also done after above:

    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                     MIG_EVENT_PRECOPY_DONE;
    migration_call_notifiers(s, type, NULL);

So looks like no matter it was CANCELLING or CANCELLED, it'll always be
CANCELLED when reaching migration_has_failed().

[...]

> > @@ -103,13 +104,8 @@ void qmp_cont(Error **errp)
> >           * Continuing after completed migration. Images have been
> >           * inactivated to allow the destination to take control. Need to
> >           * get control back now.
> > -         *
> > -         * If there are no inactive block nodes (e.g. because the VM was
> > -         * just paused rather than completing a migration),
> > -         * bdrv_inactivate_all() simply doesn't do anything.
> >           */
> > -        bdrv_activate_all(&local_err);
> > -        if (local_err) {
> > +        if (!migration_block_activate(&local_err)) {
> >              error_propagate(errp, local_err);
> 
> Could use errp directly here.

True..

-- 
Peter Xu


