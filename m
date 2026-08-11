Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAA1C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wts0j-00046D-RN; Tue, 11 Aug 2026 15:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wts0e-00045P-Gs
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wts0c-0002oa-OT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786475973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpjSwfR/lT9IpbX+WAy59/b0rDiO1n6M1oz61eONG0U=;
 b=JiwJgzM/JF4v7E8wDIx9TwOquzKTt/kwxNlDh0Rgi0I0wSoeZoVxvT9KhvJ/oZldSqagID
 DXKHmNy7Nii41KsykYm2vgpLpT1D3lFf6CX37wZFZVV44opUhV5M7rhvlpUGVtCI7cqkux
 7B8/BfppSjuGiFASwzFRZ/azKhrBli8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-PzmeRaKJNqyrUFjZitn6fQ-1; Tue,
 11 Aug 2026 15:19:18 -0400
X-MC-Unique: PzmeRaKJNqyrUFjZitn6fQ-1
X-Mimecast-MFC-AGG-ID: PzmeRaKJNqyrUFjZitn6fQ_1786475957
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F5D0180074B; Tue, 11 Aug 2026 19:19:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E281D1800348; Tue, 11 Aug 2026 19:19:16 +0000 (UTC)
Date: Tue, 11 Aug 2026 15:19:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V11 03/15] iothread: track users with holder name
Message-ID: <20260811191913.GB170741@fedora>
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-4-zhangckid@gmail.com>
 <87wlu2nj4h.fsf@pond.sub.org>
 <CAK3tnvLFvd6F=BLAgeE_preztLHZQDa1Va9i-Y1RAoEbiZ2vPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TVTdXy4CjoRGJbk6"
Content-Disposition: inline
In-Reply-To: <CAK3tnvLFvd6F=BLAgeE_preztLHZQDa1Va9i-Y1RAoEbiZ2vPA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--TVTdXy4CjoRGJbk6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 04:51:55PM +0800, Zhang Chen wrote:
> On Fri, Aug 7, 2026 at 9:41=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
> >
> > Zhang Chen <zhangckid@gmail.com> writes:
> >
> > > Introduce iothread_ref_and_get_aio_context() with a holder argument
> > > and its counterpart iothread_put_aio_context().
> > >
> > > Previously, users of an IOThread AioContext did not explicitly record
> > > their identity, making it difficult to debug which devices or
> > > subsystems were pinning an IOThread.
> > >
> > > Registering a holder takes an IOThread object reference so that the
> > > IOThread and its AioContext stay alive until the matching put
> > > operation. Document the ownership and BQL requirements.
> > >
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > ---
> > >  include/system/iothread.h | 21 +++++++++++++++++++++
> > >  iothread.c                | 23 ++++++++++++++++++++++-
> > >  2 files changed, 43 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > > index b8aeb32b0e..b6664e7a38 100644
> > > --- a/include/system/iothread.h
> > > +++ b/include/system/iothread.h
> > > @@ -67,6 +67,27 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> > >  char *iothread_get_id(IOThread *iothread);
> > >  IOThread *iothread_by_id(const char *id);
> > >  AioContext *iothread_get_aio_context(IOThread *iothread);
> > > +
> > > +/*
> > > + * Register @holder and return @iothread's AioContext.  The holder i=
s copied,
> > > + * and a reference is taken on @iothread so that both the IOThread a=
nd its
> > > + * AioContext remain alive.
> > > + *
> > > + * The caller must eventually call iothread_put_aio_context() with an
> > > + * equivalent holder.  This function is not thread-safe and must be =
called
> > > + * under the Big QEMU Lock (BQL).
> > > + */
> > > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > > +                                             const IOThreadHolder *h=
older);
> > > +
> > > +/*
> > > + * Unregister @holder and release the corresponding reference on @io=
thread.
> > > + * Calling this function without a matching
> > > + * iothread_ref_and_get_aio_context() call is a programming error.
> > > + *
> > > + * This function is not thread-safe and must be called under the BQL.
> > > + */
> > > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHold=
er *holder);
> > >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> > >
> > >  /*
> > > diff --git a/iothread.c b/iothread.c
> > > index 2a4c92e08b..0cc8344ee6 100644
> > > --- a/iothread.c
> > > +++ b/iothread.c
> > > @@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOThre=
adHolder *holder)
> > >      assert(holder);
> > >
> > >      QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, =
holder));
> > > +    /*
> > > +     * This guarantees that the IOThread and its AioContext remain a=
live
> > > +     * as long as there is a holder.
> > > +     */
> > > +    object_ref(OBJECT(iothread));
> > >  }
> > >
> > >  static int iothread_holder_compare(const IOThreadHolder *holder_a,
> > > @@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOThr=
eadHolder *holder)
> > >              *prev =3D curr->next;
> > >              curr->next =3D NULL;
> > >              qapi_free_IOThreadHolderList(curr);
> > > +            object_unref(OBJECT(iothread));
> > >              return;
> > >          }
> > >          prev =3D &curr->next;
> > > @@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *ioth=
read, const char *thread_name)
> > >      g_autofree char *name =3D g_strdup_printf("%s aio-context", thre=
ad_name);
> > >
> > >      iothread->worker_context =3D g_main_context_new();
> > > -    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
> > > +    source =3D aio_get_g_source(iothread->ctx);
> > >      g_source_set_name(source, name);
> > >      g_source_attach(source, iothread->worker_context);
> > >      g_source_unref(source);
> > > @@ -421,6 +427,21 @@ AioContext *iothread_get_aio_context(IOThread *i=
othread)
> > >      return iothread->ctx;
> > >  }
> > >
> > > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > > +                                             const IOThreadHolder *h=
older)
> > > +{
> > > +    /* Add IOThreadHolder to the list */
> > > +    iothread_ref(iothread, holder);
> > > +
> > > +    return iothread->ctx;
> > > +}
> > > +
> > > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHold=
er *holder)
> >
> > Should we name this "unref" rather than "put"?  Perhaps Stefan has an
> > opinion.
>=20
> It's OK for me. The original code was designed to match the
> "iothread_get_aio_context",
> If Stefan has no objection=EF=BC=8C I will change the name to
> "iothread_unref_aio_context".

iothread_unref_and_put_aio_context() would be consistent with
iothread_ref_and_get_aio_context() :)

Stefan

>=20
> Thanks
>=20
> Chen
>=20
> >
> > > +{
> > > +    /* Delete IOThreadHolder from the list */
> > > +    iothread_unref(iothread, holder);
> > > +}
> > > +
> > >  static int query_one_iothread(Object *object, void *opaque)
> > >  {
> > >      IOThreadInfoList ***tail =3D opaque;
> >
>=20

--TVTdXy4CjoRGJbk6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7dbEACgkQnKSrs4Gr
c8j6dwf/bF97+oR6aa61rc8VHLKuqLOMkoQmJjGlOGu8t+BfSh8SdccEVqpUynKw
BSr8aqc/bE9C2+/HRDJpYsUwWBhTPQrGn6Dzo+3856tBRDQCGsPRDqA3A4C0mt1f
gqdtcIfkEt4SgXv3RtDji7Mk9R/scwKAR0I0lp1kjhJO7mkFxyvqkDiYNtqAKyvA
m2KvjUd48Zsa/O04MDCuQV4ib5tP+hRMwlksoXMRk64SstaeHYQuJUq8pD86IpUS
Zu162ARxPq9EsiYKfDaKVdUdm73KCorAQlQ/+daI2QETX1I4UTx6UTyybEAy2TUH
dJne6dgCNAFPLjzuFNtvvWCZOGXppw==
=JVtG
-----END PGP SIGNATURE-----

--TVTdXy4CjoRGJbk6--


