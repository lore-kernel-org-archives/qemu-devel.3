Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82BFCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2WO-0008UL-Qr; Thu, 23 Oct 2025 17:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WN-0008TR-OS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vC2WL-0004R9-QE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761253613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VM0pMWK3QHMa/92FWGbvn9I0A3ZBwOPL4y3rdQT7A5I=;
 b=i0+Kb+WtBmbivgljWiUMtCLtQ3rvGSEOCF9PHnLWUdZThtsHa7eunIv1wraKxrgc14fjEu
 QHmUPWB3cb79TqkoTix0R04HJUaEk9uLJD3iEtZxTcZYrwyrT8LYhRyKK6/CteHCVjhZoh
 /0dLNOlBnXJOKqPPaVH+pFUn+koD99s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-CW9cKb8MOfi5IdOI9shh7Q-1; Thu,
 23 Oct 2025 17:06:51 -0400
X-MC-Unique: CW9cKb8MOfi5IdOI9shh7Q-1
X-Mimecast-MFC-AGG-ID: CW9cKb8MOfi5IdOI9shh7Q_1761253610
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2576318002E4; Thu, 23 Oct 2025 21:06:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E18830002DB; Thu, 23 Oct 2025 21:06:48 +0000 (UTC)
Date: Thu, 23 Oct 2025 16:18:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 09/12] aio-posix: add aio_add_sqe() API for
 user-defined io_uring requests
Message-ID: <20251023201846.GC62080@fedora>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-10-stefanha@redhat.com>
 <aOkk0NL7IMq3gFVl@redhat.com> <aOkyUdEJFhFMlIfD@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5+3agyFkmhcg4xVQ"
Content-Disposition: inline
In-Reply-To: <aOkyUdEJFhFMlIfD@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--5+3agyFkmhcg4xVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 06:20:33PM +0200, Kevin Wolf wrote:
> Am 10.10.2025 um 17:23 hat Kevin Wolf geschrieben:
> > Am 10.09.2025 um 19:57 hat Stefan Hajnoczi geschrieben:
> > > Introduce the aio_add_sqe() API for submitting io_uring requests in t=
he
> > > current AioContext. This allows other components in QEMU, like the bl=
ock
> > > layer, to take advantage of io_uring features without creating their =
own
> > > io_uring context.
> > >=20
> > > This API supports nested event loops just like file descriptor
> > > monitoring and BHs do. This comes at a complexity cost: a BH is requi=
red
> > > to dispatch CQE callbacks and they are placed on a list so that a nes=
ted
> > > event loop can invoke its parent's pending CQE callbacks. If you're
> > > wondering why CqeHandler exists instead of just a callback function
> > > pointer, this is why.
> >=20
> > This is a mechanism that we know from other places in the code like the
> > Linux AIO or indeed the old io_uring block driver code, because a BH is
> > the only thing that makes sure that the main loop will call into the
> > code again later.
> >=20
> > Do we really need it here, though? This _is_ literally the main loop
> > implementation, we don't have to make the main loop call us.
> > .need_wait() checks io_uring_cq_ready(), so as long as there are
> > unprocessed completions, we know that .wait() will be called in nested
> > event loops. We just can't take more than one completion out of the
> > queue to process them later for this to work, but have to process them
> > one by one as we get them from the ring. But that's what we already do.
> >=20
> > Am I missing something?
>=20
> I think what I missed is that we probably don't want to call arbitrary
> callbacks from .wait(), but only in the dispatching phase. At the same

Yes, exactly. The polling/wait phase of aio_poll() is sensitive since it
measures time, holds ctx->list_lock, and has ctx->notify_me enabled. In
that state we cannot call arbitrary code.

> time, we need to fill the ready_list during .wait() and can't do that
> later, so we do have to go through all CQEs here. The only way I can see
> to get rid of the extra list - which I would really like to see - would
> be processing the CQEs twice (once during .wait() for the internal ones
> and once during the dispatch phase for the add_sqe() ones). That's a bit
> annoying.
>=20
> Either way, even if we keep the list, scheduling and cancelling BHs from
> the fdmon still doesn't feel quite right to me. I wonder if we shouldn't
> introduce a .dispatch() callback in FDMonOps that could run the
> cqe_handler_ready_list for fdmon-io_uring. That would also make the
> interface more consistent with the set of callbacks we have for GSource,
> and maybe eventually simplify deduplicating them.
>=20
> Then you also don't need the ugly optimisation in the next patch that
> fixes the slowness of scheduling BHs in .wait() by moving io_uring code
> to the AioContext core.

You're right, cqe_handler_bh is ugly. Either every dispatched callback
in the event loop should be its own BH (and BHs are the one and only
list of callbacks) or I can add the .dispatch() callback you suggested.
I need to play with the code a bit to compare the approaches. I'll
choose an approach for the next revision of this series.

--5+3agyFkmhcg4xVQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj6jaYACgkQnKSrs4Gr
c8g5/gf+PSzgi1bL7wnfIDcXjZHyLe7gDVP9kv/EHMClCnPAWzNt5CdP5vSZIpP1
Ad74YhLri1q6WDQM5ehIfZzfjQhE+mDGIhpIervibwZIup5PD9xNbc3gI8c3rGDt
pcbCRzjbGR0R2G5+sXb3GyLFZS+gWfzF40M2pwn+BYOKUInxqq0e86WbnnbI28qB
rbnuD1CTaUclV1ONA5QFWAjLZyupPqE/CeaDyW/N1MoT2PZE/V6C2ONKnhbfkVNe
y3XKWHwAqJXy3iiTTf5jru7PZoC24d2YGy3AIKMSKlg1Y4xBwN7wspalwqfIF7Nz
Y+rnsnVUPOOoI6KWap2SvYYKRBCuiA==
=7WDw
-----END PGP SIGNATURE-----

--5+3agyFkmhcg4xVQ--


