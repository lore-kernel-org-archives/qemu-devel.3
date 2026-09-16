Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70961C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCw-0002sS-0k; Mon, 21 Sep 2026 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCu-0002ro-7T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCs-0002kV-RA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p6SObD1RTV5XHRWnPh5wLxdCzY1vNOAw5KoolkV8WDs=;
 b=HQtMZKE3DFg0kCNQN31ZKpNP/g+0T5Gw0ZHew+qq9qh2uPqLpZ1FuwxeV8jXQNl7P8fiUR
 fkeC8uRi5JBcE31CJxFx6P5MJBZxo0OfwjRaKItaMB54LtNxLfqMsT7gvFOdoxIMHY5ARA
 ghIEd81i+JJAKxQ9fIlp4dnF/3GOp8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-BFw00wzMPvSlX8zkQI03wg-1; Mon,
 21 Sep 2026 09:37:14 -0400
X-MC-Unique: BFw00wzMPvSlX8zkQI03wg-1
X-Mimecast-MFC-AGG-ID: BFw00wzMPvSlX8zkQI03wg_1789997833
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9027C195D011; Mon, 21 Sep 2026 13:37:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 148E141B; Mon, 21 Sep 2026 13:37:12 +0000 (UTC)
Date: Wed, 16 Sep 2026 16:09:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 12/13] iothread: make legacy AioContext getter
 explicitly unsafe
Message-ID: <20260916200907.GI162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-13-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g77aZVZ3DzDGVZkv"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-13-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

--g77aZVZ3DzDGVZkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:54PM +0800, Zhang Chen wrote:
> Now that holder-aware callers have been converted, rename
> iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
> update qmp_x_blockdev_set_iothread().
>=20
> The block graph retains only the AioContext, while detachment happens
> outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
> a matching holder lifecycle. The new name makes its existing lifetime
> assumption explicit.
>=20
> New code should use iothread_ref_and_get_aio_context().
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  blockdev.c                |  9 ++++++++-
>  include/system/iothread.h | 11 ++++++++++-
>  iothread.c                |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)

With Markus' feedback addressed:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--g77aZVZ3DzDGVZkv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq92MACgkQnKSrs4Gr
c8iXFAf/eFy92TXmHf8gchocL4Xq9G2wKnUAlF+91AUKeKt4i+qOGhNVc9E/h9fC
OAmN2q0sfPgL/IHrdRRXguR7Dwii+wOB2J1ksA9fDk9J/ehGV7hIU4wOtQXFHUXW
I7v2VM+Q2Nt3frmPXTQaXmpn0zNxljH0ixqNQqwe/8v8HWX7aBpShnXUxuhc1NkL
pE6mCz657IN3Zxdy4I2K/jPj+ESeFW+LEm1FTX6sHwgfGe/6FX8+VoX840P1zyNh
drLOr5I4/8z6Vlk80Jff5Fu3iL5fwPNM+ijkszDV/M0YIgIbPcq4fAsvk2EJdQEf
ZNe/NqYyvuEWdHZ0VJg/Bqu7lEWIQw==
=L/O4
-----END PGP SIGNATURE-----

--g77aZVZ3DzDGVZkv--


