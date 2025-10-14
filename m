Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823BACCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92kF-0001iO-LP; Wed, 15 Oct 2025 10:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92kC-0001hy-IX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92k2-0006bf-6x
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760539473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4+Q0Od3qa3LKgYuS21c5ZmCxDSh2Ccm53q6m780Omc=;
 b=fvWjgqUuETy0Z5DSEDBt32k6j5T+oCSeF/IoBHtht9iRcGEnGT0WXmAR2rumIcjVgUtlnj
 o5yd4SU4lLTrCe+4UgxzwOuXtTDfNylpoB8L8SRspya1adwnVlg7tvZ/z2miN597ChvhGs
 /jKXvod1Fq4yQwTgbArKd4Urf0XnF2M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-cm1KgcV9OZupTIUFg2_qhg-1; Wed,
 15 Oct 2025 10:44:31 -0400
X-MC-Unique: cm1KgcV9OZupTIUFg2_qhg-1
X-Mimecast-MFC-AGG-ID: cm1KgcV9OZupTIUFg2_qhg_1760539470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50E1D1954B08; Wed, 15 Oct 2025 14:44:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C4C21800446; Wed, 15 Oct 2025 14:44:29 +0000 (UTC)
Date: Tue, 14 Oct 2025 15:48:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 07/12] aio: add errp argument to aio_context_setup()
Message-ID: <20251014194844.GF18850@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-8-stefanha@redhat.com>
 <aOff3OCKvw3nei_x@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lkj1vNYNA+SN6MJB"
Content-Disposition: inline
In-Reply-To: <aOff3OCKvw3nei_x@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--lkj1vNYNA+SN6MJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:16:28PM +0200, Kevin Wolf wrote:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > When aio_context_new() -> aio_context_setup() fails at startup it
> > doesn't really matter whether errors are returned to the caller or the
> > process terminates immediately.
> >=20
> > However, it is not acceptable to terminate when hotplugging --object
> > iothread at runtime. Refactor aio_context_setup() so that errors can be
> > propagated. The next commit will set errp when fdmon_io_uring_setup()
> > fails.
> >=20
> > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> > diff --git a/include/block/aio.h b/include/block/aio.h
> > index 2760f308f5..d919d7c8f4 100644
> > --- a/include/block/aio.h
> > +++ b/include/block/aio.h
> > @@ -718,10 +718,11 @@ void qemu_set_current_aio_context(AioContext *ctx=
);
> >  /**
> >   * aio_context_setup:
> >   * @ctx: the aio context
> > + * @errp: error pointer
> >   *
> >   * Initialize the aio context.
> >   */
> > -void aio_context_setup(AioContext *ctx);
> > +void aio_context_setup(AioContext *ctx, Error **errp);
>=20
> I don't really mind much, but the convention these days is that
> functions don't only take an Error **, but also return a bool or
> 0/-errno.

Will fix in v5.

>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>=20

--lkj1vNYNA+SN6MJB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjuqRwACgkQnKSrs4Gr
c8gTmwf8D8Qb8zlfgY7t+JxSug23ff8qTv4nRoBKLU94gUkdZIG/dZFFq9vy4eWG
R0lgLBPqPhjW3rs/20nSQNdL2SEvztT23h9zeC7cCoThDiRNAs+zErmKqVfiqbwu
HYU1I6f4Gc6rbfqQjpBOVsL1nR2cpITXV+lmjonEGEYgQAKbNb0HfURPvTy8P9ze
9sAmXzx6DfX2gPl+yB0Tkurqwi6+hqV97XqGZdKgpmCUZ6zTYbwCdSB/Gziic4Nu
gYwBHLE8H/boUbuwxe2imTilQoZHLZzU9Z57FioH41keVP2gwgAjRaAhXAyk/eed
2Zyw/eE+XuY6mMLS4yT0jnItgwQ5ow==
=upYU
-----END PGP SIGNATURE-----

--lkj1vNYNA+SN6MJB--


