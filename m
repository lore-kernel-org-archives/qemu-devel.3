Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EECCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 18:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v183K-000726-IB; Tue, 23 Sep 2025 14:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v183E-00071k-B9
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v183C-0002it-3h
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 14:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758653259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1P3YME+UcVZM2GPE7hqCzpOVF6GYqIDDX0zDNldBWnY=;
 b=Cn9u6s7upRQprsyfjCNBg6gkn9bYeTM1pVZPeJT2uVm07KfxgqhNJ3h77SngmQjqw/SfrB
 EoYJnAyH01MmVykzGlaRS3LEk6GvMVN4b44tGl0JjcSjpUZDhLJZOukp37fAItOB04EeGF
 SwiTMNNevQBUKh06uSvujxLbGc51fbA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-c4OfasqtO5ai3J2unKjHVw-1; Tue,
 23 Sep 2025 14:47:37 -0400
X-MC-Unique: c4OfasqtO5ai3J2unKjHVw-1
X-Mimecast-MFC-AGG-ID: c4OfasqtO5ai3J2unKjHVw_1758653257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFC21956058; Tue, 23 Sep 2025 18:47:36 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46B6D300018D; Tue, 23 Sep 2025 18:47:36 +0000 (UTC)
Date: Tue, 23 Sep 2025 14:47:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH v2] tracing: deprecate "ust" tracing backend
Message-ID: <20250923184735.GE509965@fedora>
References: <20250923074418.87716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NzRVrZ4TapwK8k06"
Content-Disposition: inline
In-Reply-To: <20250923074418.87716-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--NzRVrZ4TapwK8k06
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 09:44:18AM +0200, Paolo Bonzini wrote:
> The "ust" backend is complex (tracetool contains two output formats just
> for that backend).  It is not clear if if it has any users, and LTTng
> anyway can use the uprobe tracepoints provided by the "dtrace" backend,
> therefore deprecate "ust".

LTTng UST cannot trace all of QEMU's SDT probes because QEMU uses SDT
semaphores. Semaphores appear to be unsupported by LTTng:
https://bugs.lttng.org/issues/1180

Here is an example that won't work:

  static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
                                                  hwaddr addr,
                                                  uint64_t *value,
                                                  unsigned size,
                                                  signed shift,
                                                  uint64_t mask,
                                                  MemTxAttrs attrs)
  {
      uint64_t tmp;
 =20
      tmp =3D mr->ops->read(mr->opaque, addr, size);
      if (mr->subpage) {
          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, =
size);
      } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_REA=
D)) {
                 ^^^ semaphore ^^^
          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, =
size,
                                       memory_region_name(mr));
      }

However, I don't remember hearing from LTTng UST users all these years,
so I think it's okay to deprecate this tracing backend.

Please update the commit description to mention that trace events that
use SDT semaphores do not work with LTTng UST.

Thanks,
Stefan

>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/deprecated.rst | 9 +++++++++
>  meson.build               | 4 ++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index aa300bbd507..57250f9d47f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -533,3 +533,12 @@ command documentation for details on the ``fdset`` u=
sage.
> =20
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +Host features
> +-------------
> +
> +``ust`` tracing backend
> +-----------------------
> +
> +LTTng can use uprobe tracepoints, therefore it is recommended to use
> +the ``dtrace`` backend instead.
> diff --git a/meson.build b/meson.build
> index 72da97829ab..b5e2186b35e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5073,3 +5073,7 @@ if not actually_reloc and (host_os =3D=3D 'windows'=
 or get_option('relocatable'))
>    message('QEMU will have to be installed under ' + get_option('prefix')=
 + '.')
>    message('Use --disable-relocatable to remove this warning.')
>  endif
> +
> +if 'ust' in get_option('trace_backends')
> +  warning('ust trace backend is deprecated, use dtrace backend for uprob=
e support')
> +endif
> --=20
> 2.51.0
>=20

--NzRVrZ4TapwK8k06
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS60YACgkQnKSrs4Gr
c8jUiwf+IKrd4qx+F6jWq8DtJKzjWuU+/sb8FVBEqsAKp9CpeWa3MI0IYjn7Tt2Z
YIr/AzTL5ioH2csHd0XCR5/qHe3dRkbPsFtZo27GilMQwStKh6My5qxPbaqTUwZ0
0Ye0sbfZsGqO2PYHQjzv6a4oIZprI6JymNsYLrai9RuUX+tqb+OmJmk08NzQ8gGG
oAg0YSNmPc4CUc6vhnZzZMEyEeQB0gpcitW4npeStt+lS14ACOOW7H/GYGqUgcso
5xd6r1WtTBXMY38fiZNZ8tWaCbGEcUqnyh2ADhPkiHw99zbejSA+qi2y1BKN3lnw
sGGh/9vCxJyobqZOqDW1ekjBR6hfnw==
=cUdY
-----END PGP SIGNATURE-----

--NzRVrZ4TapwK8k06--


