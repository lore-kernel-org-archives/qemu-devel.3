Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755C1C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WFh-00043o-13; Thu, 17 Apr 2025 16:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WFe-00040f-Jt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WFc-0007n1-LK
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzU6VPX6NCC+aSIDyhJu1vyryrloF2ekJS1ybVrKizI=;
 b=BFy5/T9LSEiPDCKNkn1mwThIa6nMNP97cnYxEKiFXb8FO4QOLtFK3CHEzWwmMMcyZQEcAW
 2ySc7UuZ7WTGW8AgOmO5SPW2ZJ1SG9459drtYXPASNHYU4SYjeTzCf6YQUR8fSUtCsGY+6
 d7/S1pow6ySs5f6VoaP4olhKrEZuHVw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-hyOFI68iO3e811DHrtS9kw-1; Thu,
 17 Apr 2025 16:54:19 -0400
X-MC-Unique: hyOFI68iO3e811DHrtS9kw-1
X-Mimecast-MFC-AGG-ID: hyOFI68iO3e811DHrtS9kw_1744923258
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38ED71800980; Thu, 17 Apr 2025 20:54:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC98230002C2; Thu, 17 Apr 2025 20:54:15 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:54:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 08/11] mirror: Skip writing zeroes when target is
 already zero
Message-ID: <20250417205414.GG85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ULX/vJJrDnR5YlXE"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-21-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--ULX/vJJrDnR5YlXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:13PM -0500, Eric Blake wrote:
> When mirroring, the goal is to ensure that the destination reads the
> same as the source; this goal is met whether the destination is sparse
> or fully-allocated.  However, if the destination cannot efficiently
> write zeroes, then any time the mirror operation wants to copy zeroes
> from the source to the destination (either during the background over
> sparse regions when doing a full mirror, or in the foreground when the
> guest actively writes zeroes), we were causing the destination to
> fully allocate that portion of the disk, even if it already read as
> zeroes.
>=20
> The effect is especially pronounced when the source is a raw file.
> That's because when the source is a qcow2 file, the dirty bitmap only
> visits the portions of the source that are allocated, which tend to be
> non-zero.  But when the source is a raw file,
> bdrv_co_is_allocated_above() reports the entire file as allocated so
> mirror_dirty_init sets the entire dirty bitmap, and it is only later
> during mirror_iteration that we change to consulting the more precise
> bdrv_co_block_status_above() to learn where the source reads as zero.
>=20
> Remember that since a mirror operation can write a cluster more than
> once (every time the guest changes the source, the destination is also
> changed to keep up), we can't take the shortcut of relying on
> s->zero_target (which is static for the life of the job) in
> mirror_co_zero() to see if the destination is already zero, because
> that information may be stale.  Any solution we use must be dynamic in
> the face of the guest writing or discarding a cluster while the mirror
> has been ongoing.
>=20
> We could just teach mirror_co_zero() to do a block_status() probe of
> the destination, and skip the zeroes if the destination already reads
> as zero, but we know from past experience that extra block_status()
> calls are not always cheap (tmpfs, anyone?), especially when they are
> random access rather than linear.  Use of block_status() of the source
> by the background task in a linear fashion is not our bottleneck (it's
> a background task, after all); but since mirroring can be done while
> the source is actively being changed, we don't want a slow
> block_status() of the destination to occur on the hot path of the
> guest trying to do random-access writes to the source.
>=20
> So this patch takes a slightly different approach: any time we have to
> transfer the full image, we know that mirror_dirty_init() is _already_
> doing a pre-zero pass over the entire destination.  Therefore, if we
> track which clusters of the destination are zero at any given moment,
> we don't have to do a block_status() call on the destination, but can
> instead just refer to the zero bitmap associated with the job.
>=20
> With this patch, if I create a raw sparse destination file, connect it
> with QMP 'blockdev-add' while leaving it at the default "discard":
> "ignore", then run QMP 'blockdev-mirror' with "sync": "full", the
> destination remains sparse rather than fully allocated.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ULX/vJJrDnR5YlXE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBanYACgkQnKSrs4Gr
c8j7jQgAqn34max8IrUb+ictUwFMoar+uvTpv4r5pI51/MrCk+i1RrP+pmTtKKtk
G51Q9AD7ywxM6tS2wHxM1yG3b7ft6GNuT3IURKOWGsoowEJfPYd3qhIkprNzumT8
lQvifZI8YI1IWQAr0L4b0hKJSZ9pfNEVoN9Nubx7KpRAijSQEyKRnWUVmnd/Zy+B
3iZMuoEVINbTjW2uISyVpsCn23HuVbZjHRrYolb9wXu0X7uWvQwuCBkEXx370eLy
XYydubq6D2tSFfImyNnMvDRvD+a0Bhq15dPmofGp4HWiqWBc5HAnV/PUo11Dq7GA
680ojuUsKtFKMqPjUW1nfqzsCdA1Zw==
=KEUX
-----END PGP SIGNATURE-----

--ULX/vJJrDnR5YlXE--


