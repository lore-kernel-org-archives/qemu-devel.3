Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EEC109C046
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RWy-0007b9-0o; Wed, 25 Mar 2026 12:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5RWn-0007ZV-5x
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5RWl-0001Ib-SW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+/uTuvEtJb2HVnt29ZkGdPbPyI8+bLQnZPQnbZTZPU=;
 b=MYqKahIf1Zrjpb5EgBmkwvDc0OuIL4utUwZ2wg8d5USXfshpgHxbPtHTatKfWPrERs2qgs
 H9BND2wb+70gdDPD7Evs7mCc2g1daFhZU3rtg2fb+rbm5Tk24Cxv8snin5v3Y7drRv0C3j
 wLrMLz8Zk8vEAdSzWSbpqfDuhBZjmdU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-0LlJFXYOMjaM-tJiTwr3kQ-1; Wed,
 25 Mar 2026 12:56:17 -0400
X-MC-Unique: 0LlJFXYOMjaM-tJiTwr3kQ-1
X-Mimecast-MFC-AGG-ID: 0LlJFXYOMjaM-tJiTwr3kQ_1774457776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0045B195608B; Wed, 25 Mar 2026 16:56:15 +0000 (UTC)
Received: from localhost (unknown [10.44.32.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A35519560B1; Wed, 25 Mar 2026 16:56:13 +0000 (UTC)
Date: Wed, 25 Mar 2026 12:56:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
Message-ID: <20260325165611.GB701300@fedora>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zn4DK78pCdykUHQm"
Content-Disposition: inline
In-Reply-To: <20260323135451.579655-4-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Zn4DK78pCdykUHQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 08:54:51AM -0500, Jaehoon Kim wrote:
> @@ -831,7 +822,8 @@ void aio_context_destroy(AioContext *ctx)
>  }
> =20
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> -                                 int64_t grow, int64_t shrink, Error **e=
rrp)
> +                                 int64_t grow, int64_t shrink,
> +                                 int64_t weight, Error **errp)
>  {
>      AioHandler *node;
> =20
> @@ -848,6 +840,7 @@ void aio_context_set_poll_params(AioContext *ctx, int=
64_t max_ns,
>      ctx->poll_max_ns =3D max_ns;
>      ctx->poll_grow =3D grow;
>      ctx->poll_shrink =3D shrink;
> +    ctx->poll_weight =3D weight;
>      ctx->poll_ns =3D 0;
> =20
>      aio_notify(ctx);

On second thought, now that the divide-by-0 protection has been removed
and these fields are assumed to hold a valid value when poll_max_ns > 0,
aio_context_set_poll_params() needs the same 0-protection as
iothread_set_param().

--Zn4DK78pCdykUHQm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnEE6sACgkQnKSrs4Gr
c8iCYAf/UEGVGeUCYBTYnTt6aeBoUFPvxd7MRcZgqmzP6BjofT9wjQYGreZKnbGK
WR3Bj1ADzK35f1CcwXIRp6XUexoL7ZqRjO2UHRgdl127rRFEX/LQ1pzSR0Zmw6Wt
VvUVVfZJA0EG6Eevb9vW95kZBj0w0TQqBkGsrOYYugFNLZAFcCdZSFso/cUVqJQj
OeoZhENkrLNJfDtQKVHebBjcliaO1e5d9/6iB/N6hpkofamZ4MtcHxRqCCIz1dBD
dKdM2BTn2pmazWYBaqSF4vss4TPFTR/5EjNRxp0F4xTJP+86FLTxAmCd70Ld6pwV
FfqywFfUqeEY6EHkWu38t0BijsoGYg==
=pQDn
-----END PGP SIGNATURE-----

--Zn4DK78pCdykUHQm--


