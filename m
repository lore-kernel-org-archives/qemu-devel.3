Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EFDC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2fo-0006pa-1w; Thu, 24 Jul 2025 16:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2fm-0006oW-Cp
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2fi-0003r4-SS
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753389369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9j8tztAk4Xr6RPsbDf10tm+asdf4cqfdJb6PqDBRQE=;
 b=fLnSnjmtPwboxBYyKXn7LqAbAyhMhJuvdEi8C+ZAh1ymPFWogndH2mHunEPs6W43ysmzcJ
 AjrpiyJW7CqWJbYTcAUG7n7YSC55+WxhaPyRZ3ZzkuwKs9PD6j8twzeZJP+MM3qmZa+0mL
 fIUDOtBDTjivyktWkCYvEvIE6QloIjw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-dnd1kVRnNVCvHilZ4iu4tg-1; Thu,
 24 Jul 2025 16:36:07 -0400
X-MC-Unique: dnd1kVRnNVCvHilZ4iu4tg-1
X-Mimecast-MFC-AGG-ID: dnd1kVRnNVCvHilZ4iu4tg_1753389366
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BCD31956087; Thu, 24 Jul 2025 20:36:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.247])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 323371956089; Thu, 24 Jul 2025 20:36:04 +0000 (UTC)
Date: Thu, 24 Jul 2025 16:36:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Brian Song <hibriansong@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250724203603.GA573965@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <e13f8119-7c60-4aa6-91b0-860ac0a462f5@ddn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CZFVtOZlLmvJyApo"
Content-Disposition: inline
In-Reply-To: <e13f8119-7c60-4aa6-91b0-860ac0a462f5@ddn.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--CZFVtOZlLmvJyApo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 01:51:44PM +0000, Bernd Schubert wrote:
> On 7/16/25 20:38, Brian Song wrote:
> > -    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io=
_uring, 0);
> > +    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES,
> > +                            &ctx->fdmon_io_uring, flags);
> >      if (ret !=3D 0) {
> >          error_setg_errno(errp, -ret, "Failed to initialize io_uring");
> >          return;
>=20
> I need test these flags again, might be worthful for qemu as well
>=20
> 	/* These flags should help to increase performance, but actually
> 	 * make it a bit slower - reason should get investigated.
> 	 */
> 	if (0) {
> 		/* Has the main slow down effect */
> 		params.flags |=3D IORING_SETUP_SINGLE_ISSUER;
>=20
> 		// params.flags |=3D IORING_SETUP_DEFER_TASKRUN;
> 		params.flags |=3D IORING_SETUP_TASKRUN_FLAG;
>=20
> 		/* Second main effect to make it slower */
> 		params.flags |=3D IORING_SETUP_COOP_TASKRUN;
> 	}

I measured the following using fio bs=3D4k in a 4 vCPU guest with 1
IOThread using a virtio-blk disk backed by a local NVMe drive:

                      IOPS               IOPS
Benchmark             SINGLE_ISSUER      SINGLE_ISSUER|COOP_TASKRUN|TASKRUN=
_FLAG
randread  iodepth=3D1   54,045 (+1.2%)     54,189 (+1.5%)
randread  iodepth=3D64  318,135 (+0.1%)    315,632 (-0.68%)
randwrite iodepth=3D1   141,918 (-0.44%)   143,337 (+0.55%)
randwrite iodepth=3D64  323,948 (-0.015%)  322,755 (-0.38%)

The differences are so small that I'd rather not merge the code changes.
I will post an RFC series just to archive the patches in case they are
needed again in the future.

You can find detailed benchmarking results here including the fio
output, fio command-line, and guest libvirt domain XML:
https://gitlab.com/stefanha/virt-playbooks/-/tree/io_uring-flags/notebook/f=
io-output
https://gitlab.com/stefanha/virt-playbooks/-/blob/io_uring-flags/files/fio.=
sh
https://gitlab.com/stefanha/virt-playbooks/-/blob/io_uring-flags/files/test=
=2Exml.j2

Stefan

--CZFVtOZlLmvJyApo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiCmTMACgkQnKSrs4Gr
c8i5UAf/cmTZvXwKqKW9K3WDBgvxgjhteqGzKC7HcG6CIDNDHnMrssTlB27fp3om
buhiwYtpWYgVAxGJbzwa7X5N+i1d2gL92oov7VIYP/gqLtrOwQIdsdt9UVW/le2i
F4MTUvNXEzvPBp5aRiSrtSrW5boEcijFnkG5jF74o7sAJDmn2UIxkFNLVA5OEjHP
WZzF4awZDKPPWJAxXTv3EAbgQHAVN0Gydd6aPpjv56AJ6dHgDtRREfuvH6yPUN8l
55cPf714lGWNGhocNBEPTLxNJcqjwU+AWEiLOzHhBndZMp9Q/PqvX3T34UHiyUNo
aW053cQMjhsGS5Tnbw6Lcd22IZNqwQ==
=cmZF
-----END PGP SIGNATURE-----

--CZFVtOZlLmvJyApo--


