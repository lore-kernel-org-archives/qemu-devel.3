Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57760C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7ML-0002LC-T0; Thu, 22 May 2025 10:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI7MK-0002Km-Ir
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI7MH-0004Vt-Qn
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747925840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SAxu2TG4Qa6wmMYOMNFQxrCbLKii1Tnw4EYNpLqDRbA=;
 b=Nzfnt0LQDRP2C2soNMhT9KfIChkWDRTvO3GbYXPXOsUF9q6dt+zQ7EZsXb7Do9kWibQnBQ
 gfFl+ZPkzS1olzhSq74H85WzVX6YDeLKkdiFcYr0R6h+7NzVEin0TgbTxZpQdJpPoIK5R7
 iNPaCh6f+wIbkgE5rHklQGHaxCEDupU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-MVrCb6tuMV6t1dQupT4XOA-1; Thu,
 22 May 2025 10:57:17 -0400
X-MC-Unique: MVrCb6tuMV6t1dQupT4XOA-1
X-Mimecast-MFC-AGG-ID: MVrCb6tuMV6t1dQupT4XOA_1747925836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFD31956095; Thu, 22 May 2025 14:57:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6835019560AB; Thu, 22 May 2025 14:57:12 +0000 (UTC)
Date: Thu, 22 May 2025 16:57:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, bmarzins@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <aC87RvpJ9O-4jmMM@redhat.com>
References: <20250522130803.34738-1-kwolf@redhat.com>
 <20250522144607.GA258433@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6RZJ7/Ph9I/N1Yzs"
Content-Disposition: inline
In-Reply-To: <20250522144607.GA258433@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--6RZJ7/Ph9I/N1Yzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.05.2025 um 16:46 hat Stefan Hajnoczi geschrieben:
> On Thu, May 22, 2025 at 03:08:03PM +0200, Kevin Wolf wrote:
> > When scsi-block is used on a host multipath device, it runs into the
> > problem that the kernel dm-mpath doesn't know anything about SCSI or
> > SG_IO and therefore can't decide if a SG_IO request returned an error
> > and needs to be retried on a different path. Instead of getting working
> > failover, an error is returned to scsi-block and handled according to
> > the configured error policy. Obviously, this is not what users want,
> > they want working failover.
> >=20
> > QEMU can parse the SG_IO result and determine whether this could have
> > been a path error, but just retrying the same request could just send it
> > to the same failing path again and result in the same error.
> >=20
> > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> > block devices (queued in the device mapper tree for Linux 6.16), we can
> > tell the kernel to probe all paths and tell us if any usable paths
> > remained. If so, we can now retry the SG_IO ioctl and expect it to be
> > sent to a working path.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> > v2:
> > - Add a comment to explain retry scenarios [Stefan]
> > - Handle -EAGAIN returned for suspended devices [Ben]

> >  #if defined(__linux__)
> > +#if defined(DM_MPATH_PROBE_PATHS)
> > +static bool sgio_path_error(int ret, sg_io_hdr_t *io_hdr)
> > +{
> > +    if (ret < 0) {
> > +        switch (ret) {
> > +        case -ENODEV:
> > +            return true;
> > +        case -EAGAIN:
> > +            /*
> > +             * The device is probably suspended. This happens while th=
e dm table
> > +             * is reloaded, e.g. because a path is added or removed. T=
his is an
> > +             * operation that should complete within 1ms, so just wait=
 a bit and
> > +             * retry.
> > +             *
> > +             * If the device was suspended for another reason, we'll w=
ait and
> > +             * retry SG_IO_MAX_RETRIES times. This is a tolerable dela=
y before
> > +             * we return an error and potentially stop the VM.
> > +             */
> > +            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
>=20
> sgio_path_error() is missing coroutine_fn.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, good catch. I already applied the patch and fixed it up to make
sure that I won't forget.

Kevin

--6RZJ7/Ph9I/N1Yzs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmgvO0YACgkQfwmycsiP
L9Y6YA//UosZ7aMjtAl4tOd56NSTB5G5fhflWPmsWN1H4MZTQ1+Q9vE3jOtJalIZ
/1xsoLveuSzRmDGWzOEaqZpsMvrMt2Fjw9F3Wm/Ckdp1I0dlcK6lle37Ned2kvVf
TrRbH1CLCkmOB20WOHPbTLmMkINL3a51GglOx8+BzeQagIV/M0WAleCQ2WQG336R
Xiy9GN9LE8C5rUbi5QtbvPx3rya30XGnNACWr+bX4Q2OdjusHp9QbSLNndIEOHrO
TSuXzwv60pdTotaiVY8UEPFNRj7VfYfXLH4iK/h7SBzRH2HSkVagr6NLao8RVhzO
aVeHfBrp9X5uPKRdeUoXxkXVJQffbOrPB8BnkkOe1T+644UbvlKAKvjgyB0N+wfG
z9BFmJgZlOt2aAV0kECPfX2sJ5w3NK4B7a8LEtLXJBj08piCpyr3cyT6/xXNyrkJ
TsIxZu5SEFHZRLp8szFViSMguoBJGcniR9NQr2WH0vIlGAJo5Ohf+dJ3dmj5kvuG
FhMEaPghFIrMcQ+IQt+N6Az6AoLvcQM9coB9bYarNJOM+9v1HFb4pwjoAkHjBJnx
dC9Lwtm37bei+wacIc00z49VQNFM7IlvPPnFEqvy/xwjTSc9/zfsytBytnCVv1Js
IPqOnqonpNEIJR9vTYpnSQ4NY1ZnfDTwZxbBz32Ee4s8OMYce68=
=0OOc
-----END PGP SIGNATURE-----

--6RZJ7/Ph9I/N1Yzs--


