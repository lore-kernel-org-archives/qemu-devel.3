Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99115C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXv9z-0005kh-7V; Wed, 07 Feb 2024 22:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXv9x-0005kU-RP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXv9v-0000Ia-LC
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707363186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4gEhGkWDK3sNZo0u9JrfwNcmYHOFugX5ZL7m8MWPqY=;
 b=E5BimyOJmKx0xMKKeBPE8Aipq24SQR1EhPPZtNDx+zWdd/BSjLxD8nJIUHTP2FjuBHqMBF
 MJR0MC1+GfR5mnkSsAD7NviYOl5WhX0VhczitxtSjR60ZZnySM9u+5oSZSgB9lUlshw3V/
 RWuF8/xM5ChwbF+qNtF3RK/XR3VKWwM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-RabROgLnMNqjsNWOv_wxJg-1; Wed, 07 Feb 2024 22:33:04 -0500
X-MC-Unique: RabROgLnMNqjsNWOv_wxJg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5dc1aeb6a58so596342a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 19:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707363183; x=1707967983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4gEhGkWDK3sNZo0u9JrfwNcmYHOFugX5ZL7m8MWPqY=;
 b=ETAWeYgLHrJJjZgWr436Dlh/byMgz8BCg5/NbrsrDOoCfna42VW+ODAnR49aDn22+w
 cTtziUOnc/YhLOMn2UqnrGQ9vIRbn3rI7EXUN1UFnQTy6imhgSTyea0+uceoQnpM4btl
 p6i6HkiY/HT1aRyRQZZQBcMNAyWL/6MaxXlsbr84cGt9ihb+RzsxXf89wP6WBVSJH5/2
 utRg8AHNeJVNKN4ZClRYQ6gzyQs9HxT1lKupHtHl9wHl+d8hAXc9zFCPxQfoNmJ9iwuh
 /cMVpH5pQ7xYm4Qp7f2gWKc9dt/WhhBgkxf5Zwaom+DD52jFKFwF9mT3q2ukWEHcrUAN
 3+eQ==
X-Gm-Message-State: AOJu0Yx7hCKIyb10bks+/tPqC1J6Cn5oWUkX3Swkxj0K80K92CUqUMmf
 89hE90zmglucbS2P/hXGvkGJeynxJ5Ol3RoQm8SKORQxQApyQTUTRPxN+v+Zeke+xBfgPmgIENz
 OLIr/sSlWKFS1VSVtTNXTvmJdiS+4cOc3No39Gy4KYzsSVDSl9ckM
X-Received: by 2002:a17:90b:3141:b0:296:df79:c663 with SMTP id
 ip1-20020a17090b314100b00296df79c663mr4082083pjb.3.1707363182876; 
 Wed, 07 Feb 2024 19:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH704gN1Yxqh6PtZTChsLGGNBtnyjPEcHxoTGLIIWkYdDXEn6iTrUIhgr9PKJouL0rCTmr4fw==
X-Received: by 2002:a17:90b:3141:b0:296:df79:c663 with SMTP id
 ip1-20020a17090b314100b00296df79c663mr4082070pjb.3.1707363182527; 
 Wed, 07 Feb 2024 19:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWk6rlnCSfkQQ6aea0/YUWJxOxKT9RFvD0hXiAkIzt/g3sFvJhb7jDPB3BXhzX6GZLeoNYlmsvVvTfbvwAh14GXE/vJ/U3rdho8fkDa4NKdRJDQ0IPifQ0=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 eu15-20020a17090af94f00b00296b50bb21asm247088pjb.27.2024.02.07.19.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 19:33:02 -0800 (PST)
Date: Thu, 8 Feb 2024 11:32:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/6] migration/multifd: Fix channel creation vs.
 cleanup races
Message-ID: <ZcRLaSOpSypaB9dJ@x1n>
References: <20240206215118.6171-1-farosas@suse.de> <ZcLrF5HN920rUTSw@x1n>
 <878r3w7648.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r3w7648.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

On Wed, Feb 07, 2024 at 10:31:51AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Feb 06, 2024 at 06:51:12PM -0300, Fabiano Rosas wrote:
> >> Based-on: 20240202102857.110210-1-peterx@redhat.com
> >> [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and cleanups
> >> https://lore.kernel.org/r/20240202102857.110210-1-peterx@redhat.com
> >> 
> >> Hi,
> >> 
> >> For v3 I fixed the refcounting issue spotted by Avihai. The situation
> >> there is a bit clunky due to historical reasons. The gist is that we
> >> have an assumption that channel creation never fails after p->c has
> >> been set, so when 'p->c == NULL' we have to unref and when 'p->c !=
> >> NULL' the cleanup code will do the unref.
> >
> > Yes, this looks good to me.  That's a good catch.
> >
> > I'll leave at least one more day for Avihai and/or Dan to have another
> > look.  My r-b persist as of now on patch 5.
> >
> > Actually I think the conditional unref is slightly tricky, but it's not its
> > own fault, IMHO, OTOH it's more about a1af605bd5ad where p->c is slightly
> > abused.  My understanding is we can avoid that conditional unref with below
> > patch 1 as a cleanup (on top of this series).  Then patch 2 comes all
> > alongside.
> 
> Yes, I even wrote some code to always set p->c and leave the unref to
> the cleanup routine. Doing reference counting in the middle of the code
> like that leaves us exposed to new code relying on p->c being valid
> during cleanup. There's already yank and the cleanup itself which expect
> p->c to be valid.
> 
> However, I couldn't get past the uglyness of overwriting p->c, so I kept
> the changes minimal for this version.

Yep. The good part of "only set p->c if channel fully established" is that
then the migration thread fully owns the ioc as long as set, and no
overwritting possible.

> 
> I'm also wondering whether we can remove the TLS handshake thread
> altogether now that we moved the multifd_send_setup call into the
> migration thread. My (poor) understanding is that a1af605bd5ad hit the
> issue that the QIOTask completion would just execute after
> multifd_save_setup returned. Otherwise I don't see how adding a thread
> to an already async task would have helped. But I need to think about
> that a bit more.

It could be even simpler than that, iiuc.  Note that in the stack showed in
that commit message, it hasn't even reached the async handling:

    Src: (multifd_send_0)
    multifd_channel_connect
      multifd_tls_channel_connect
        multifd_tls_channel_connect
           qio_channel_tls_handshake
              qio_channel_tls_handshake_task <---- async handling provided here..
                qcrypto_tls_session_handshake
                  gnutls_handshake <-------------- but we're still at sync phase..
                       ...
                    recvmsg (Blocking I/O waiting for response)

IMHO it'll be much easier if we can remove those threads.  Please keep the
adventure there, just a heads-up that the async paths seem to have a close
dependency so far on gmainloop contexts, while the migration thread may not
provide that anymore (and I hope we don't introduce anything either; I
think it's better we stick with a full threaded model in migration rather
than event based).

> 
> >
> > We don't need to rush on these, though, we should fix the thread race
> >first because multiple of us hit it, and all cleanups can be done
> >later.
> 
> I said we should not merge these two changes right now, but I take that
> back. I'll leave it up to you, there doesn't seem to be that much impact
> in adding them.

Thanks.  I just sent the pull without them, as I don't yet have plan to
queue them so soon; I'll be accused to abuse the maintainership. :-)

If you think worthwhile, I can still repost them as formal patches later
and put there on the list.  If your explore on a bigger hammer works then I
think we can ignore these two patches.  But if you or anyone thinks we
could have these as good cleanups, we can also merge them first for 9.0 and
leave whatever else for later.

> 
> >
> > =====
> > From 0830819d86e08c5175d6669505aa712a0a09717f Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Wed, 7 Feb 2024 10:08:35 +0800
> > Subject: [PATCH 1/2] migration/multifd: Cleanup TLS iochannel referencing
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
> >  migration/multifd.c | 37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index adfe8c9a0a..4a85a6b7b3 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -873,16 +873,22 @@ out:
> >  
> >  static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
> >  
> > +typedef struct {
> > +    MultiFDSendParams *p;
> > +    QIOChannelTLS *tioc;
> > +} MultiFDTLSThreadArgs;
> > +
> >  static void *multifd_tls_handshake_thread(void *opaque)
> >  {
> > -    MultiFDSendParams *p = opaque;
> > -    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
> > +    MultiFDTLSThreadArgs *args = opaque;
> >  
> > -    qio_channel_tls_handshake(tioc,
> > +    qio_channel_tls_handshake(args->tioc,
> >                                multifd_new_send_channel_async,
> > -                              p,
> > +                              args->p,
> >                                NULL,
> >                                NULL);
> > +    g_free(args);
> > +
> >      return NULL;
> >  }
> >  
> > @@ -892,6 +898,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
> >  {
> >      MigrationState *s = migrate_get_current();
> >      const char *hostname = s->hostname;
> > +    MultiFDTLSThreadArgs *args;
> >      QIOChannelTLS *tioc;
> >  
> >      tioc = migration_tls_client_create(ioc, hostname, errp);
> > @@ -906,11 +913,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
> >      object_unref(OBJECT(ioc));
> >      trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
> >      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
> > -    p->c = QIO_CHANNEL(tioc);
> 
> This assignment also meant multifd_send_channel_destroy() would call
> object_unref on the tioc object. Removing it means
> qio_channel_tls_finalize() will never be called.

I think it'll still be properly released / called?

Just to make sure we're on the same page: qio_channel_tls_finalize() will
be called on the last ref released.  Then let's discuss error paths on how
this patch affects the last unref.

Before this patch, it will be called until multifd_send_channel_destroy()
as you said when cleanup, because that did the last unref (while your patch
has the "if" where you'll skip the cleanup even if error):

  multifd_send_channel_destroy
    socket_send_channel_destroy
      object_unref

After this patch, that object_unref() will be called in
multifd_channel_connect() directly, and the cleanup code, seeing
p->c==NULL, does nothing later.

> 
> It also means the socket channel (ioc) refcount will be decremented one
> too many times, due to the object_unref above^.
> 
> So I think we should find a point where tioc is not needed anymore and
> unref it and remove the object_unref(ioc) above.
> 
> Right?

[...]

> > From 9e574c3216f6459e3a808096d905e2554d962cad Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Wed, 7 Feb 2024 10:24:39 +0800
> > Subject: [PATCH 2/2] migration/multifd: Drop registered_yank
> >
> > With a clear definition of p->c protocol, where we only set it up if the
> > channel is fully established (TLS or non-TLS), registered_yank boolean will
> > have equal meaning of "p->c != NULL".
> >
> > Drop registered_yank by checking p->c instead.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> This one looks good. I know it depends on the previous patch, but if you
> plan to add it:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

I'll pick it up when posting the formal patches, thanks.

Let's see whether above will address your concern.  If not, we can move the
discussion over to that thread.

-- 
Peter Xu


