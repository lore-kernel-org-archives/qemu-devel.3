Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4BEC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNA3T-0004xB-ET; Thu, 05 Jun 2025 08:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNA3A-0004nt-0U
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNA37-00031G-VI
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749127823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KWI0IDEuAZuCxiKgUVUMPGvr+uxq9EnajIgGMe81vE=;
 b=Y2eesxeOS9DoZdYly+F8qWIcJ+cZy4wlo1qdn/JhqPNs2sUhbIo5bLRmC9JdAmXp7BpcPs
 lQYwMxXO0CxszBDWnMQC+DNtHZA9lhu067QfCwDZjIdgBlZ8g6h68+4wdgQro16NiviLp9
 nWwlHjQJhLYx24kR0IFlBDQKNXeECok=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-VLvDLTj3PzmQ8mD4xin3SA-1; Thu,
 05 Jun 2025 08:50:18 -0400
X-MC-Unique: VLvDLTj3PzmQ8mD4xin3SA-1
X-Mimecast-MFC-AGG-ID: VLvDLTj3PzmQ8mD4xin3SA_1749127818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFF3B18001E3; Thu,  5 Jun 2025 12:50:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1137195E74A; Thu,  5 Jun 2025 12:50:16 +0000 (UTC)
Date: Thu, 5 Jun 2025 08:50:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Message-ID: <20250605125015.GB417071@fedora>
References: <20250604191843.399309-1-stefanha@redhat.com>
 <aEFWeZUlqqRvHsJT@redhat.com>
 <42276df1-4267-4038-8685-c7a193259e67@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aSsrzZzEi6U0HPse"
Content-Disposition: inline
In-Reply-To: <42276df1-4267-4038-8685-c7a193259e67@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--aSsrzZzEi6U0HPse
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 01:28:49PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 5/6/25 10:34, Daniel P. Berrang=E9 wrote:
> > On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
> > > Since commit 7ff9ff039380 ("meson: mitigate against use of uninitiali=
ze
> > > stack for exploits") the -ftrivial-auto-var-init=3Dzero compiler opti=
on is
> > > used to zero local variables. While this reduces security risks
> > > associated with uninitialized stack data, it introduced a measurable
> > > bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
> > > functions.
> > >=20
> > > These virtqueue functions are in the hot path. They are called for ea=
ch
> > > element (request) that is popped from a VIRTIO device's virtqueue. Us=
ing
> > > __attribute__((uninitialized)) on large stack variables in these
> > > functions improves fio randread bs=3D4k iodepth=3D64 performance from=
 304k
> > > to 332k IOPS (+9%).
> >=20
> > IIUC, the 'hwaddr addr' variable is 8k in size, and the 'struct iovec i=
ov'
> > array is 16k in size, so we have 24k on the stack that we're clearing a=
nd
> > then later writing the real value. Makes sense that this would have a
> > perf impact in a hotpath.
> >=20
> > > This issue was found using perf-top(1). virtqueue_split_pop() was one=
 of
> > > the top CPU consumers and the "annotate" feature showed that the memo=
ry
> > > zeroing instructions at the beginning of the functions were hot.
> >=20
> > When you say you found it with 'perf-top' was that just discovered by
> > accident, or was this usage of perf-top in response to users reporting
> > a performance degradation vs earlier QEMU ?
>=20
> Would it make sense to move these to VirtQueue (since the structure
> definition is local anyway)?
>=20
> -- >8 --
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce374..b96c6ec603c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -153,6 +153,12 @@ struct VirtQueue
>      EventNotifier host_notifier;
>      bool host_notifier_enabled;
>      QLIST_ENTRY(VirtQueue) node;
> +
> +    /* Only used by virtqueue_pop() */
> +    struct {
> +        hwaddr addr[VIRTQUEUE_MAX_SIZE];
> +        struct iovec iov[VIRTQUEUE_MAX_SIZE];
> +    } pop;

This is an alternative. Using g_alloca() is another alternative.

I chose __attribute__((uninitialized)) because it clearly documents the
reason why these variables need special treatment. In your patch the
"Only used by virtqueue_pop()" comment isn't enough to explain why these
variables should be located here. Someone might accidentally move them
back into virtqueue_pop() functions in the future if they are unaware of
the reason.

I'm happy to change approaches based on the pros/cons. Why do you prefer
moving the local variables into VirtQueue?

>  };
>=20
>  const char *virtio_device_names[] =3D {
> @@ -1680,8 +1686,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t
> sz)
>      VirtIODevice *vdev =3D vq->vdev;
>      VirtQueueElement *elem =3D NULL;
>      unsigned out_num, in_num, elem_entries;
> -    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> -    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> +    hwaddr *addr =3D vq->pop.addr;
> +    struct iovec *iov =3D vq->pop.iov;
>      VRingDesc desc;
>      int rc;
>=20
> @@ -1826,8 +1832,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq,
> size_t sz)
>      VirtIODevice *vdev =3D vq->vdev;
>      VirtQueueElement *elem =3D NULL;
>      unsigned out_num, in_num, elem_entries;
> -    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> -    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> +    hwaddr *addr =3D vq->pop.addr;
> +    struct iovec *iov =3D vq->pop.iov;
>      VRingPackedDesc desc;
>      uint16_t id;
>      int rc;
> ---
>=20
> >=20
> > >=20
> > > Fixes: 7ff9ff039380 ("meson: mitigate against use of uninitialize sta=
ck for exploits")
> > > Cc: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >   include/qemu/compiler.h | 12 ++++++++++++
> > >   hw/virtio/virtio.c      |  8 ++++----
> > >   2 files changed, 16 insertions(+), 4 deletions(-)
>=20

--aSsrzZzEi6U0HPse
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhBkocACgkQnKSrs4Gr
c8iteQgAvN/LqF5HY24nfMJZ5WGIWc71nJ+g583XWuhDa2YnfBABYJTc7lsZZ9Dj
LW2355EQuLxFnSUqOFq0R730kaY+UpbP/I8n1HAOSbCTqkQwZod5hSN8VEVLJCro
ze97tyIpvlhrPRdEen8/uxlQBi7/w5iGsWf3p8ZIZbqItcBnyuFZKJsX/sa9Vhqi
nQVpvq1e+3x5KnpSC9RvEzcDagghcIhknjt6YdCXxpzUqyjzk8Ksoxvc73KuCs0W
1VNs80vjAjJ6pQ/JxiG4dAPT1nyEEiwA/faCrXPEF+eKrpgfWCpEDdHm3Ogzy2SM
h91uLigbBLZwMfqJpYIWrl6+NPJpfg==
=ZFq8
-----END PGP SIGNATURE-----

--aSsrzZzEi6U0HPse--


