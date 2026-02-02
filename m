Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3460EE7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn28p-0005pG-HW; Mon, 02 Feb 2026 17:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vn28U-0005KB-QV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vn28T-0003GE-8g
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770070267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=olzCkJ1SDGXdSTuI1wTt8M6mDPxlif32eVmFoAzv6nY=;
 b=e17uNcqcDof9OC7bJwuoeQs/oF3TgNIpPSmPLOlip7Fo1gFa60kXmlobb78MigAe7IfmEy
 c/70qhplZJbL+QYLy/n2ohfqZaRXB5pOHdW0paEtnqy7it6OnqQ7U/Di+I2fHcbtK+9Mij
 0dwp1HjtxMsFdcLYpMXg/q6ddVADs6w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-BVDvKfitN6C9EfBtu6_Mrg-1; Mon,
 02 Feb 2026 17:11:03 -0500
X-MC-Unique: BVDvKfitN6C9EfBtu6_Mrg-1
X-Mimecast-MFC-AGG-ID: BVDvKfitN6C9EfBtu6_Mrg_1770070262
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2733180057E; Mon,  2 Feb 2026 22:11:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.238])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE1B61800285; Mon,  2 Feb 2026 22:10:59 +0000 (UTC)
Date: Mon, 2 Feb 2026 17:10:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net
Subject: Re: [PATCH 6/6] block/io: keep zero flag for head/tail parts of
 misaligned zero write when possible
Message-ID: <20260202221058.GA429972@fedora>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260109120837.2772961-7-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="syvyOOmuF+eSdbov"
Content-Disposition: inline
In-Reply-To: <20260109120837.2772961-7-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--syvyOOmuF+eSdbov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 01:08:33PM +0100, Fiona Ebner wrote:
> This fixes io-test 179 with qcow2. Otherwise, there would be more 'data'
> sectors.
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> Not sure if we should even attempt this without considering
> detect-zeroes. While it does keep 179 working, it is a change in
> behavior, since it could turn previously data sectors (with zeroes)
> into zero sectors when they are part of the head or tail of a zero
> write.
>=20
> Would it even be tolerable from a performance perspective?

179 compares qemu-img map output and this makes changes to allocation status
fragile. In a case like this I would either adjust the test case and
regenerate the output, or if the output variance is now unavoidable then
a more sophisticated filter function is needed.

I'd avoid buffer_is_zero() in bdrv_co_do_zero_pwritev() since it eats
CPU cycles.

Stefan

--syvyOOmuF+eSdbov
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmBIPIACgkQnKSrs4Gr
c8gNbwgAxhEjfqrsT93GQUhrc/lwMUSZWaSOTZaXY5ju04fLKFwjoRz2Q3DPccr7
0sbvq2EE3c8jmPS1B5fwuZU2epsMiQ7FNKYJ1CEd4vmsNtJW5PN2zZ1QWr23MZ5M
smB3aJPhORTNkFOwnbRZ/U0RIbLU2RWBLnMZBG6JClh5MpwsFwNDI/+PT+rqqgb5
7VRNvqP02jcLk/YpuGe3b5DIWvUYtjjT5yiB1AYc3HuJKaXPwrfPs54Uvy0eeGzW
V7INkbT7KucfT5b1vHd2M1QTMBb8/omj8T1Pgs9xZXKQs7wB25O7uarYqP+0wr6R
C47VZHz97FSEbeJwZNYwMuSUdP07AQ==
=ZX2w
-----END PGP SIGNATURE-----

--syvyOOmuF+eSdbov--


