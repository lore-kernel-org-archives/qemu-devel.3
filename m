Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA0AC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMqO-0004tk-6F; Tue, 05 Aug 2025 14:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujMqM-0004rQ-RO
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujMqK-0002Vf-5a
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754420218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5jVk7S1ieIIic15Ul/woefn+M6w8sYZDNYuN6H+cWc=;
 b=dTWztSuIjn+MBZpX/M9LFcHwwbN9QM/HCiy4OWjItgSA+LQaryZ/o78IYA6j3Ri8PuDrEt
 8OVw2RgxVNVVmTqwoUk6iGvPDO2WQIUFL1ZewZZettYxWBriElPsL4rMVDv+O86GifuCQv
 /pNclTLcht7I4xMNqlo9I3Vf24HeeAg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-kf4CO8JyMbSnJ7lWwPe6cQ-1; Tue,
 05 Aug 2025 14:56:56 -0400
X-MC-Unique: kf4CO8JyMbSnJ7lWwPe6cQ-1
X-Mimecast-MFC-AGG-ID: kf4CO8JyMbSnJ7lWwPe6cQ_1754420215
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7567619560AD; Tue,  5 Aug 2025 18:56:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.205])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF3303000199; Tue,  5 Aug 2025 18:56:53 +0000 (UTC)
Date: Tue, 5 Aug 2025 14:56:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] qga: correctly write to /sys/power/state on linux
Message-ID: <20250805185652.GA21648@fedora>
References: <20250801115316.6845-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RJABWiiByk+zHZ6y"
Content-Disposition: inline
In-Reply-To: <20250801115316.6845-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--RJABWiiByk+zHZ6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2025 at 02:53:14PM +0300, Michael Tokarev wrote:
> Commit v9.0.0-343-g2048129625 introduced usage of
> g_file_set_contents() function to write to /sys/power/state.
> This function uses G_FILE_SET_CONTENTS_CONSISTENT flag to
> g_file_set_contents_full(), which is implemented by creating
> a temp file in the same directory and renaming it to the final
> destination.  Which is not how sysfs works.
>=20
> Here, there's not a big deal to do open/write/close - it becomes
> almost the same as using g_file_set_contents[_full]().  But it
> does not have surprises like this.
>=20
> Also, since this is linux code, it should be ok to use %m in
> the error reporting function.
>=20
> Fixes: 2048129625 "qga/commands-posix: don't do fork()/exec() when suspen=
ding via sysfs"
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3057
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qga/commands-linux.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RJABWiiByk+zHZ6y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiSU/QACgkQnKSrs4Gr
c8jNlQf/QAqqiPaxi3sH/LvmDxEZLtdO2jqtFwISJpHg5YNZtEbcPKhvx4YMk+wS
dIMCAsxaZv8WQEhH2JYwXljO6i5YgVF+EVN8w2JyI9tRGi1LC4RxOkS6JNnrf5pC
vFDtP79P6XYQZPfFaY1oX2wj8MaH7LjSRsCxCvqyKBDUvgeNBOC41tr335X5rZHJ
wQacCw9vk9GwuRsit8J73aONuvLWSUAjKdsTTqT6uwXWl7wR8EiCqAcImiisT+d8
cTysZlSrkECIo4TwPveQ/ZzUDpFH1IAjReqltqKoCma9/7F9JBqnh7LjKUxBEbJt
XXgNXaY0d4H7Jhxesj3ZFSGkwjfvsw==
=uRh0
-----END PGP SIGNATURE-----

--RJABWiiByk+zHZ6y--


