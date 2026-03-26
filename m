Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6091010A1E63
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pXZ-0000bZ-Jg; Thu, 26 Mar 2026 14:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5pXX-0000b4-S8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5pXV-0007xY-TQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774550080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A20kyknheAtGfvDLc+Ux14LobydOyzSsjHcvNaxPKXs=;
 b=RvdBb0AmK4ty/GBfC5+tQdvtna+b3mrseIMVNnrL4MoFExPhYyYYtGql36HFkupL0Rbh/K
 blt3GywrtatABIe7GSiXjA63my1n9VusnIZhNJze3GKJ7LGMI8EKyARVo+c1PHDcFz8f8f
 +hyvm4NlY00GteYFHxDDoEJjqFaspBg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-NnHyW7T9PMW9C7dk4ENv_g-1; Thu,
 26 Mar 2026 14:34:35 -0400
X-MC-Unique: NnHyW7T9PMW9C7dk4ENv_g-1
X-Mimecast-MFC-AGG-ID: NnHyW7T9PMW9C7dk4ENv_g_1774550074
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C32EA1956046; Thu, 26 Mar 2026 18:34:33 +0000 (UTC)
Received: from localhost (unknown [10.45.226.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD87A1955D71; Thu, 26 Mar 2026 18:34:31 +0000 (UTC)
Date: Thu, 26 Mar 2026 14:34:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v2 1/3] aio-poll: avoid unnecessary polling time
 computation
Message-ID: <20260326183429.GA786313@fedora>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-2-jhkim@linux.ibm.com>
 <20260325172236.GC701300@fedora>
 <c2df581b-e8ab-4fbb-91ae-08d17eb52878@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="36h/Cu4eAdkKwrOs"
Content-Disposition: inline
In-Reply-To: <c2df581b-e8ab-4fbb-91ae-08d17eb52878@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--36h/Cu4eAdkKwrOs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 01:17:44PM -0500, JAEHOON KIM wrote:
> On 3/25/2026 12:22 PM, Stefan Hajnoczi wrote:
> > On Mon, Mar 23, 2026 at 08:54:49AM -0500, Jaehoon Kim wrote:
> > > Nodes are no longer added to poll_aio_handlers when adaptive polling =
is
> > > disabled, preventing unnecessary try_poll_mode() calls. Additionally,
> > > aio_poll() skips try_poll_mode() when timeout is 0.
> > Skipping when timeout is 0 seems risky to me. VIRTIO devices disable
> > guest kicks when polling mode is started. When aio_poll(ctx,
> > blocking=3Dfalse) is called, we will skip polling and
> > ctx->fdmon_ops->need_wait(ctx) won't detect an event either. aio_poll()
> > will return without noticing that the VIRTIO device's AioHandler is
> > ready.
> >=20
> > Is skipping when timeout 0 necessary for performance or can it be
> > dropped from the patch?
> >=20
> > Aside from this:
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Thank you for the review!
> Removing the (timeout !=3D 0) check does not cause any issue on my side,
> so I plan to remove it in the next version.
>=20
> However, I'd like to clarify: when timeout is 0, is there any concern
> in the try_poll_mode function below that I might be missing?
> I just want to make sure I understand correctly.
>=20
> static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int64_t *timeout)
> {
> =A0 =A0 AioHandler *node;
> =A0 =A0 int64_t max_ns;
>=20
> =A0 =A0 if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
> =A0 =A0 =A0 =A0 return false;
> =A0 =A0 }
>=20
> =A0 =A0 max_ns =3D 0;
> =A0 =A0 QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
> =A0 =A0 =A0 =A0 max_ns =3D MAX(max_ns, node->poll.ns);
> =A0 =A0 }
> =A0 =A0 max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
>=20
> =A0 =A0 if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {

I think you are pointing out that max_ns will be 0 and therefore polling
will be skipped? At least this is what came to mind when I read this
code again.

That is a problem because the exact scenario I described in my reply to
you can already happen in the existing code before your patch :(.

Avoiding the timeout !=3D 0 check in your patch would help contain the bug
in try_poll_mode() rather than extending it to aio_poll() as well.

Thanks for pointing this out!

Stefan

--36h/Cu4eAdkKwrOs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnFfDUACgkQnKSrs4Gr
c8jwkAgAl/pqwBWAlqofFKFMPyM1khKLbkT7t2aIcyso7e79vlpB5c1HXbbmY3ga
gYNx2/Py6RsQRoiXTSsioZu5Zdg+d4+6rEdamNbrI89f9pNxFDYD82Mt7Q1Rhlf+
atC4c7kkqTkKwIYFM04/TZB3stsQACDYILHOKh2FtmLKc/huRBSsUOaBNL1GZxLF
zKhEi+iKGJ3ni4Swh7hDmmrucPHVHsnazob0GuYIsK0xYaHW3QhtXTy83tmS8hEP
l8HphdW7Yzr2AOv7Up+S6mAQioeogS6qqVRSebypMB7mGa7V0G9cdWtI4B1h0K+C
JtNRaO+zJAi7M+acEpHJEkuBoWGj7g==
=5ViS
-----END PGP SIGNATURE-----

--36h/Cu4eAdkKwrOs--


