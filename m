Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E5AC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 03:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcdB4-0006j7-2H; Tue, 20 Feb 2024 22:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcdB1-0006i2-Ox
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcdAz-0002fA-3j
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708485700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qoG/BAfjKKiEYVuVbt/tQY4MGIU/PSR01GpOA+UXq4=;
 b=D4uP3e/9Iq+CZbaasexBu1ybnlzTCqn9ilLRFd+y8Cx6WZDbESttlCW5yuVSj/eaAs8Eld
 wZJjo6H6l1hitSnK9ZKJxSmkE/bq8uIOeRMa7OxnsIRUlV2EdSCEWRhQfWlvYFCzxX/PWf
 uU/v9gKuNWVpKB5RCGRtsUayNBzVPTQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-u24CRBOkMpi8JHYVNCov6w-1; Tue, 20 Feb 2024 22:21:38 -0500
X-MC-Unique: u24CRBOkMpi8JHYVNCov6w-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so1161326a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 19:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708485697; x=1709090497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qoG/BAfjKKiEYVuVbt/tQY4MGIU/PSR01GpOA+UXq4=;
 b=TExQ58RMJQPPzNwsolsodFR/36HXOli6ogGje2ibbrQihJ8FblgwO6RCBQeT24PUI3
 YoLqog77IT3Wrh1r4xPHzaJsPSm+d52ZXkTO3b+GMbhurd/WuoocEq0YwkFOoZtYwMf8
 rTWq3NUMqaAUoQidnOgk3Qc6FnEluXUEI1tuqdp/r2VaF4EAgL94oIVEG4KQR6CjiPHr
 Cl+G6uQClVEgUXpQQ1txFSKogS4l1gphFREi/4nXjGtJ/YZDlQwYMXIeh1aH+ddlwOmI
 RlvjK4eBOoutyLhFNhDT8e53586eIxH3cbmvRkUzFGriqIbWcNKzUPTvyqWnnqZbYUwE
 4WTw==
X-Gm-Message-State: AOJu0YwhRTGTxXedsb4A5EAQlqFhArtvFo/4taSWvRKLqK98W2Cz74Fq
 hDTvR13febVlYSt1vjFSjcF9q34mYNPy1RR9raLDkYywfqA2z9UowWiiC5iBH/WTlUUtWpBSx3/
 gYlJIWkCaAfLvCHDxY0RRMz4oQGlkx6EpVAuhDGimNbQfTxC357Lk
X-Received: by 2002:a05:6a20:1441:b0:1a0:b0d7:f909 with SMTP id
 a1-20020a056a20144100b001a0b0d7f909mr5585048pzi.1.1708485697537; 
 Tue, 20 Feb 2024 19:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHuCZQQYHoeZS2gjM1PV8Q7gF4VY5KbE2ms8+w0M66+yQa/RdHpTsWwjaA4lXP0jU4h424YA==
X-Received: by 2002:a05:6a20:1441:b0:1a0:b0d7:f909 with SMTP id
 a1-20020a056a20144100b001a0b0d7f909mr5585038pzi.1.1708485697179; 
 Tue, 20 Feb 2024 19:21:37 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l1-20020a170902d04100b001dbb14e6feesm6952248pll.189.2024.02.20.19.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 19:21:36 -0800 (PST)
Date: Wed, 21 Feb 2024 11:21:31 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 1/2] migration/multifd: Cleanup TLS iochannel referencing
Message-ID: <ZdVsO_25eRFsj7hb@x1n>
References: <20240208035126.370620-1-peterx@redhat.com>
 <20240208035126.370620-2-peterx@redhat.com>
 <b29381a6-bbf9-4f00-a860-6f1b121f16b0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b29381a6-bbf9-4f00-a860-6f1b121f16b0@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 04:10:58PM +0200, Avihai Horon wrote:
> 
> On 08/02/2024 5:51, peterx@redhat.com wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
> > blocking handshake") introduced a thread for TLS channels, which will
> > resolve the issue on blocking the main thread.  However in the same commit
> > p->c is slightly abused just to be able to pass over the pointer "p" into
> > the thread.
> > 
> > That's the major reason we'll need to conditionally free the io channel in
> > the fault paths.
> > 
> > To clean it up, using a separate structure to pass over both "p" and "tioc"
> > in the tls handshake thread.  Then we can make it a rule that p->c will
> > never be set until the channel is completely setup.  With that, we can drop
> > the tricky conditional unref of the io channel in the error path.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   migration/multifd.c | 37 +++++++++++++++++++++++--------------
> >   1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index adfe8c9a0a..4a85a6b7b3 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -873,16 +873,22 @@ out:
> > 
> >   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
> > 
> > +typedef struct {
> > +    MultiFDSendParams *p;
> > +    QIOChannelTLS *tioc;
> > +} MultiFDTLSThreadArgs;
> > +
> >   static void *multifd_tls_handshake_thread(void *opaque)
> >   {
> > -    MultiFDSendParams *p = opaque;
> > -    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
> > +    MultiFDTLSThreadArgs *args = opaque;
> > 
> > -    qio_channel_tls_handshake(tioc,
> > +    qio_channel_tls_handshake(args->tioc,
> >                                 multifd_new_send_channel_async,
> > -                              p,
> > +                              args->p,
> >                                 NULL,
> >                                 NULL);
> > +    g_free(args);
> > +
> >       return NULL;
> >   }
> > 
> > @@ -892,6 +898,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
> >   {
> >       MigrationState *s = migrate_get_current();
> >       const char *hostname = s->hostname;
> > +    MultiFDTLSThreadArgs *args;
> >       QIOChannelTLS *tioc;
> > 
> >       tioc = migration_tls_client_create(ioc, hostname, errp);
> > @@ -906,11 +913,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
> >       object_unref(OBJECT(ioc));
> >       trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
> >       qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
> > -    p->c = QIO_CHANNEL(tioc);
> > +
> > +    args = g_new0(MultiFDTLSThreadArgs, 1);
> > +    args->tioc = tioc;
> > +    args->p = p;
> > 
> >       p->tls_thread_created = true;
> >       qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
> > -                       multifd_tls_handshake_thread, p,
> > +                       multifd_tls_handshake_thread, args,
> >                          QEMU_THREAD_JOINABLE);
> >       return true;
> >   }
> > @@ -923,6 +933,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
> > 
> >       migration_ioc_register_yank(ioc);
> >       p->registered_yank = true;
> > +    /* Setup p->c only if the channel is completely setup */
> >       p->c = ioc;
> > 
> >       p->thread_created = true;
> > @@ -976,14 +987,12 @@ out:
> > 
> >       trace_multifd_new_send_channel_async_error(p->id, local_err);
> >       multifd_send_set_error(local_err);
> > -    if (!p->c) {
> > -        /*
> > -         * If no channel has been created, drop the initial
> > -         * reference. Otherwise cleanup happens at
> > -         * multifd_send_channel_destroy()
> > -         */
> > -        object_unref(OBJECT(ioc));
> > -    }
> > +    /*
> > +     * For error cases (TLS or non-TLS), IO channel is always freed here
> > +     * rather than when cleanup multifd: since p->c is not set, multifd
> > +     * cleanup code doesn't even know its existance.
> 
> Small nit:
> s/existance/existence
> 
> BTW, I just noticed that multifd_channel_connect() can't fail, probably
> would be good to turn it into a void function.

Yes we can.  I'll add a patch and fix the spell, thanks.

-- 
Peter Xu


