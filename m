Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE98EC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3OB-0006I1-VD; Tue, 12 Mar 2024 10:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk3O4-000654-9C
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk3O2-0000hm-FQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710254747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5VKjI+Ih/pMa8Iro8b3T5UaDs2KVMUmcZQOH9qknAM=;
 b=U3f9UctW8j2acoSjgsq55rX8nS2V2lR1PNorqV8LKcb8mWzI3lgvZu9FPwisNhpU8WRpES
 X95oPoRoJOM6r6y4+0qCvTz8EWGoSAzFAYrQyrbIZgLac5Iq3NEnGSaC2DJphXIK/p5DEn
 ghIWxIw8XRKeRZv+LFKqJVxCSxzzCr4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-N8-A-nxRM-yz6H-lBksJ_g-1; Tue, 12 Mar 2024 10:45:45 -0400
X-MC-Unique: N8-A-nxRM-yz6H-lBksJ_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3075980026D;
 Tue, 12 Mar 2024 14:45:45 +0000 (UTC)
Received: from localhost (unknown [10.39.194.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA7523C22;
 Tue, 12 Mar 2024 14:45:44 +0000 (UTC)
Date: Tue, 12 Mar 2024 10:45:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <20240312144543.GA411413@fedora>
References: <20240311054333.1264776-1-ppandit@redhat.com>
 <20240311130908.GA327967@fedora> <Ze8l1fzr0oxIFxO1@redhat.com>
 <20240311193641.GA384474@fedora> <ZfAkPhiAnyaEV9jQ@redhat.com>
 <CAE8KmOwpnVyFQKguQAAg3Y0oQCb8-G1vg_qL9Q_YaQqJC1i2MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="80w70sLG3shHPf5U"
Content-Disposition: inline
In-Reply-To: <CAE8KmOwpnVyFQKguQAAg3Y0oQCb8-G1vg_qL9Q_YaQqJC1i2MQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--80w70sLG3shHPf5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 07:07:04PM +0530, Prasad Pandit wrote:
> Hello,
>=20
> On Tue, 12 Mar 2024 at 15:15, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 11.03.2024 um 20:36 hat Stefan Hajnoczi geschrieben:
> > > > > That can be avoided with a variable that keeps track of whether -=
EINVAL was seen before and skips Linux AIO in that
> > > > > case.
> > > > >
> > > > > Fallback should be very rare, so I don't think it needs to be opt=
imized:
> > You're right. I missed that io_submit() returns failure only if the
> > first request in the queue is invalid, and returns a "short submission"
> > for errors in later entries.
>=20
> =3D=3D=3D
> +bool laio_has_fdsync(int fd)
> +{
> +    AioContext *ctx =3D qemu_get_current_aio_context();
> +    struct qemu_laiocb cb =3D {
> +        .co         =3D qemu_coroutine_self(),
> +        .ctx        =3D aio_get_linux_aio(ctx),
> +    };
> +    struct iocb *iocbs[] =3D {&cb.iocb, NULL};
> +
> +    /* check if host kernel supports IO_CMD_FDSYNC */
> +    io_prep_fdsync(&cb.iocb, fd);
> +    int ret =3D io_submit(cb.ctx->ctx, 1, iocbs);
> +
> +    return ret !=3D -EINVAL;
> +}
> =3D=3D=3D
>=20
> To confirm:
> * Do we need a revised patch V3? I'm testing one with the above
> function to check if IO_CMD_FDSYNC is supported. If it returns true we
> call laio_co_submit(..., QEMU_AIO_FLUSH, ), else fallback to
> thread-pool.

If you are already developing and testing it then I think a v3 with
laio_has_fdsync() would be great.

Thanks,
Stefan

--80w70sLG3shHPf5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwapcACgkQnKSrs4Gr
c8g2GQgAwnmE7zTs5VEIM1dX+WvCblFNB4Rc+2qKgPV/lerBIwuVfO1VQSRQUmJC
KlI5gKsZUafqaN5VJmDzJw9HqP6xE9xdsc4d90uiVT5LHfdC+Fdl6X4RNf3tt/VJ
uBA/YdL523VUfQDjCVADDtnpNTvCbp9+Mw3fSVeX0Qb8TBXznpF1vhjykEujdKz9
RLT+ozHw52+1K+oyvAbX4phdDf5QJWpYai6f+7DFPeCRkxoF3SxH0bJ+kEzwJg3P
VOpVbCvWGn9mqBgJbq7Yx16gQFft0M4afAedqLDHu/JBBAza5xXp83Ouy/9E25sj
WVxWiFevAPOC6cbGOe0VObnNjxoYxg==
=DT5S
-----END PGP SIGNATURE-----

--80w70sLG3shHPf5U--


