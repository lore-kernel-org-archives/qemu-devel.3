Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E00C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOsr-0003bD-Ec; Wed, 28 Feb 2024 13:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rfOsp-0003b4-AH
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rfOsn-0003XK-KX
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709145738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sU+3X0AHn456pNTAT2xSU6kPLCizdVrPJ8hAbycWptw=;
 b=B6UDo58kO8p/XYoTzE5DPjpLrRM44QCwmwnhofNBCEdTs2dU4jEYaXZcVH84Q7GqB/Cjb3
 x+yrs2ZBmePSDjj5K2ndemewfNhbXkRWA9WzbAFCrjcstfmECJNnY7hZZzDXztoXtxsCnL
 Q/i2iuBMnSrqVQr1s7bshVNZJ9hQwY8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-ooyQuhUBMA24T815POlQAA-1; Wed,
 28 Feb 2024 13:42:16 -0500
X-MC-Unique: ooyQuhUBMA24T815POlQAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7B4A2824798;
 Wed, 28 Feb 2024 18:42:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1127A20169C6;
 Wed, 28 Feb 2024 18:42:13 +0000 (UTC)
Date: Wed, 28 Feb 2024 13:42:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 06/16] block/nvme: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <20240228184212.GB641417@fedora>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-7-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NF1acaMMLvtcxaWo"
Content-Disposition: inline
In-Reply-To: <20240228163723.1775791-7-zhao1.liu@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--NF1acaMMLvtcxaWo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:37:13AM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
>=20
> * =3D Why, when and how to use ERRP_GUARD() =3D
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
>=20
> ERRP_GUARD() could avoid the case when @errp is the pointer of
> error_fatal, the user can't see this additional information, because
> exit() happens in error_setg earlier than information is added [1].
>=20
> In nvme.c, there're 3 functions passing @errp to error_prepend()
> without ERRP_GUARD():
> - nvme_init_queue()
> - nvme_create_queue_pair()
> - nvme_identify()
>=20
> All these 3 functions take their @errp parameters from the
> nvme_file_open(), which is a BlockDriver.bdrv_nvme() method and its
> @errp points to its caller's local_err.
>=20
> Though these 3 cases haven't trigger the issue like [1] said, to
> follow the requirement of @errp, add missing ERRP_GUARD() at their
> beginning.
>=20
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>      ("error: New macro ERRP_GUARD()").
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: "Philippe Mathieu-Daud=E9" <philmd@linaro.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  block/nvme.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NF1acaMMLvtcxaWo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXffoQACgkQnKSrs4Gr
c8gzIgf/dM25JEOFRp2w9Rq06Tewm5rA3O+zyTz7QWsy2BUYSk1fzAJNLYN0sCvu
LJ4cOk66oR05Tu/jZ0sBEep03lCvqNvQ2sYif3SgCFO7KwpDywCeokmX2OQIaKIX
efWuDvEC813LeHWJ9S3UKB+JrDseXwcC0Vv5/LGEt4Z0y0RbGZwUL4anH71E1ZiZ
TNE4a2Vyd1jey9Su0CiDR22Y8EXytQc1dfDMY7ssPGknSzwuipUxrwM39bLag31K
sq7L4iLeULQ+iMhT5h+55TWv/ihz7LuqHUv+KgUQKT+YitYm05nKML26JK1C4rYz
2Td/v0xpUHhzPAa0cmgkjhrwzBfAzQ==
=3U1B
-----END PGP SIGNATURE-----

--NF1acaMMLvtcxaWo--


