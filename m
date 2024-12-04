Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E8E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwTq-00020j-KH; Wed, 04 Dec 2024 16:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tIwTi-0001xI-Cq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tIwTg-0007z0-Ee
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733346006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZywQik/6l4KAU9M97CtFrru79vCLsIvhORnbfzPcNIw=;
 b=Z6RpHwrCRsBEcQaoZMJ0CGdusW01SnPWjTrHhDDUyvf2929UUDzNDEmzbVoDCeBORwBhuw
 sejm5updU+LHo/0E6G7SuA7WYRaB7v5s1D9CKSTuJN0ZSll1+blYvRQ4OLs8qWLuj8rAAC
 6/3yjfNtng4pVsXGfi7vHw1Lu+zn5xs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-vyYR9NHwOu-R1l3D4vP4AQ-1; Wed,
 04 Dec 2024 16:00:03 -0500
X-MC-Unique: vyYR9NHwOu-R1l3D4vP4AQ-1
X-Mimecast-MFC-AGG-ID: vyYR9NHwOu-R1l3D4vP4AQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AE4C195608A; Wed,  4 Dec 2024 21:00:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB6D21956094; Wed,  4 Dec 2024 21:00:00 +0000 (UTC)
Date: Wed, 4 Dec 2024 15:59:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] 9pfs: improve v9fs_walk() tracing
Message-ID: <20241204205959.GB48585@fedora>
References: <E1tIPPo-006ldP-Uk@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gbVHhgPSQO/7aLDJ"
Content-Disposition: inline
In-Reply-To: <E1tIPPo-006ldP-Uk@kylie.crudebyte.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--gbVHhgPSQO/7aLDJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 10:14:28AM +0100, Christian Schoenebeck wrote:
> 'Twalk' is the most important request type in the 9p protocol to look out
> for when debugging 9p communication. That's because it is the only part
> of the 9p protocol which actually deals with human-readable path names,
> whereas all other 9p request types work on numeric file IDs (FIDs) only.
>=20
> Improve tracing of 'Twalk' requests, e.g. let's say client wanted to walk
> to "/home/bob/src", then improve trace output from:
>=20
>   v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames=3D3
>=20
> to:
>=20
>   v9fs_walk tag=3D0 id=3D110 fid=3D0 newfid=3D1 nwnames=3D3 wnames=3D{hom=
e, bob, src}
>=20
> To achieve this, add a new helper function trace_v9fs_walk_wnames() which
> converts the received V9fsString array of individual path elements into a
> comma-separated string presentation for being passed to the tracing syste=
m.
> As this conversion is somewhat expensive, this new helper function returns
> immediately if tracing of event 'v9fs_walk' is currently not enabled.
>=20
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  CCing tracing maintainers in case they have better ideas how to do this.

Thanks, Christian. Comments below but this looks fine if you prefer to
keep it this way.

>  hw/9pfs/9p.c         | 42 +++++++++++++++++++++++++++++++++++++-----
>  hw/9pfs/trace-events |  2 +-
>  2 files changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 578517739a..c08e7e492b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1774,6 +1774,30 @@ static bool same_stat_id(const struct stat *a, con=
st struct stat *b)
>      return a->st_dev =3D=3D b->st_dev && a->st_ino =3D=3D b->st_ino;
>  }
> =20
> +/*
> + * Returns a (newly allocated) comma-separated string presentation of the
> + * passed array for logging (tracing) purpose for trace event "v9fs_walk=
" only.
> + * If tracing for that event is disabled, it immediately returns NULL in=
stead.
> + *
> + * It is caller's responsibility to free the returned string.
> + */
> +static char *trace_v9fs_walk_wnames(V9fsString *wnames, size_t nwnames)
> +{
> +    g_autofree char **arr =3D NULL;
> +
> +    if (trace_event_get_state(TRACE_V9FS_WALK) &&
> +        qemu_loglevel_mask(LOG_TRACE))

There is no need to call qemu_loglevel_mask() explicitly if you use
trace_event_get_state_backends() instead of trace_event_get_state(). The
QEMU log backend will check qemu_loglevel_mask(LOG_TRACE) for you.

> +    {
> +        arr =3D g_malloc0_n(nwnames + 1, sizeof(char *));
> +        for (size_t i =3D 0; i < nwnames; ++i) {
> +            arr[i] =3D wnames[i].data;
> +        }
> +        return g_strjoinv(", ", arr);
> +    }
> +
> +    return NULL;
> +}
> +
>  static void coroutine_fn v9fs_walk(void *opaque)
>  {
>      int name_idx, nwalked;
> @@ -1787,6 +1811,7 @@ static void coroutine_fn v9fs_walk(void *opaque)
>      size_t offset =3D 7;
>      int32_t fid, newfid;
>      P9ARRAY_REF(V9fsString) wnames =3D NULL;
> +    g_autofree char *trace_wnames =3D NULL;
>      V9fsFidState *fidp;
>      V9fsFidState *newfidp =3D NULL;
>      V9fsPDU *pdu =3D opaque;
> @@ -1800,11 +1825,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
>      }
>      offset +=3D err;
> =20
> -    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
> -
>      if (nwnames > P9_MAXWELEM) {
>          err =3D -EINVAL;
> -        goto out_nofid;
> +        goto out_nofid_nownames;
>      }
>      if (nwnames) {
>          P9ARRAY_NEW(V9fsString, wnames, nwnames);
> @@ -1814,15 +1837,20 @@ static void coroutine_fn v9fs_walk(void *opaque)
>          for (i =3D 0; i < nwnames; i++) {
>              err =3D pdu_unmarshal(pdu, offset, "s", &wnames[i]);
>              if (err < 0) {
> -                goto out_nofid;
> +                goto out_nofid_nownames;
>              }
>              if (name_is_illegal(wnames[i].data)) {
>                  err =3D -ENOENT;
> -                goto out_nofid;
> +                goto out_nofid_nownames;
>              }
>              offset +=3D err;
>          }
> +        trace_wnames =3D trace_v9fs_walk_wnames(wnames, nwnames);
> +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, trace_w=
names);

This could be adjusted slightly to avoid calling trace_v9fs_walk() when
the trace event is disabled. It's up to you but this pattern is more
common:

  if (trace_event_get_state_backends(TRACE_V9FS_WALK)) {
      trace_wnames =3D trace_v9fs_walk_wnames(wnames, nwnames);
      trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, trace_wnames=
);
  }

Now trace_v9fs_walk_wnames() doesn't need to check the trace event state
internally.

> +    } else {
> +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "");
>      }
> +
>      fidp =3D get_fid(pdu, fid);
>      if (fidp =3D=3D NULL) {
>          err =3D -ENOENT;
> @@ -1957,7 +1985,11 @@ out:
>      }
>      v9fs_path_free(&dpath);
>      v9fs_path_free(&path);
> +    goto out_pdu_complete;
> +out_nofid_nownames:
> +    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "<?>");
>  out_nofid:
> +out_pdu_complete:
>      pdu_complete(pdu, err);
>  }
> =20
> diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> index a12e55c165..ed9f4e7209 100644
> --- a/hw/9pfs/trace-events
> +++ b/hw/9pfs/trace-events
> @@ -11,7 +11,7 @@ v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %=
d id %d fid %d"
>  v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime, =
int32_t mtime, int64_t length) "tag %d id %d stat=3D{mode %d atime %d mtime=
 %d length %"PRId64"}"
>  v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mas=
k) "tag %d id %d fid %d request_mask %"PRIu64
>  v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint=
32_t mode, uint32_t uid, uint32_t gid) "tag %d id %d getattr=3D{result_mask=
 %"PRId64" mode %u uid %u gid %u}"
> -v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_=
t nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
> +v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_=
t nwnames, const char* wnames) "tag=3D%d id=3D%d fid=3D%d newfid=3D%d nwnam=
es=3D%d wnames=3D{%s}"
>  v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids)=
 "tag %d id %d nwnames %d qids %p"
>  v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d i=
d %d fid %d mode %d"
>  v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t versio=
n, uint64_t path, int iounit) "tag %u id %u qid=3D{type %u version %u path =
%"PRIu64"} iounit %d"
> --=20
> 2.39.5
>=20

--gbVHhgPSQO/7aLDJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdQws8ACgkQnKSrs4Gr
c8gTsQf/dReWLsWAXDu9tJ2c2Xx3KHo28Es8PXB4rKxRwTIl0rPXnV8UW9iZopVS
oFJNdcq56x+tv/lGti3xwoU+JrRZ4JCRo9nX87luQ7ZThjGdwCzb/3cCO/u4LtJy
incgJtzUFPdP5aUxDWUlLOiOa96/WLZfR7F5A13bUhAL8w7AebBstEtFmKmwv1eJ
etSAF03Io2z9jjdCDvzUGL/PvvWscIY6L7FtA4tl6+JsK3UICQY/y9n2H+ewVJH4
2ROVUqvPpVwEdafyo2zxv468RDQlAp2Uo63ajBppsdE70tkD68bPDP6RN64IUw9h
licDldDGzRnmuLdGI9aTTNWLx0Ypwg==
=g01+
-----END PGP SIGNATURE-----

--gbVHhgPSQO/7aLDJ--


