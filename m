Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25594EEA84A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbp1-000430-6g; Thu, 12 Feb 2026 13:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbov-0003yf-Bu
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbou-0004BS-1v
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZVGFzMOFLM4EllKqtRcoParJo9IjQGkIjaBavF232I=;
 b=Vxd8QIdA6OA3fzQGcD9z7JrNcfOPIaEsqvpgeoqX27cuabJpUy8v2daKr0mO+be/b6nGuK
 d90VL2b/d3NeCjo+MTQQKblOosP2pa/hcgwMX7Tijh38tiq11GJku4/fR2ff5hhjxutebc
 nzGuizCpQ9s7MPCkuxXFBB1WsRIUP+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-9CT7KaViN_SwNi4lULp0rg-1; Thu,
 12 Feb 2026 13:53:39 -0500
X-MC-Unique: 9CT7KaViN_SwNi4lULp0rg-1
X-Mimecast-MFC-AGG-ID: 9CT7KaViN_SwNi4lULp0rg_1770922418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A70AC18002E6; Thu, 12 Feb 2026 18:53:38 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54F011800670; Thu, 12 Feb 2026 18:53:38 +0000 (UTC)
Date: Wed, 11 Feb 2026 17:50:52 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 6/7] fuse: add 'io-uring' option
Message-ID: <20260211225052.GG234157@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-7-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cjDhQfLF9Bi5Pi5r"
Content-Disposition: inline
In-Reply-To: <20260207120901.17222-7-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--cjDhQfLF9Bi5Pi5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 08:09:00PM +0800, Brian Song wrote:
> This patch adds a new storage export option for storage-export-daemon
> to enable FUSE-over-io_uring via 'io-uring=3Don|off' (default: off).
>=20
> The initialization phase performs a protocol handshake via the legacy
> /dev/fuse interface before transitioning to the io_uring mode.
> If multiple IOThreads are configured, the export distributes the uring
> queues to handle requests concurrently.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  block/export/fuse.c                  | 3 +--
>  docs/tools/qemu-storage-daemon.rst   | 7 +++++--
>  qapi/block-export.json               | 5 ++++-
>  storage-daemon/qemu-storage-daemon.c | 1 +
>  4 files changed, 11 insertions(+), 5 deletions(-)

Aside from Markus' comment:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cjDhQfLF9Bi5Pi5r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmNB8wACgkQnKSrs4Gr
c8h7Cwf8Cq9qugDp8vnFUMSfQ8p/KU2eQqXERtmWfvyHJM2j6kq52ls+UyWImrag
iOPD+4xb9tfnOBTCHv4v0kl3CkGBCIEQvYqnv44m1htsQBJbk+lDUmo28Kfbxse4
iWfy1mPmgVF5niSNPQMZzzTSNqXfmz+P5ki0Xd36nPY8HVZVF4Z9iqiScVtnomzY
JeD96f7dWuGQ0J9biWvZn3phjZOR2Zy0kAaUSlXv2qjYIiVOdANViSG44UXX0hjE
v8F9sJLl79Qluddtx20yOi4Nle+DqpQ4w0yVHBQ2PKNfheeJv0uN4gc+1KI17QGU
jIc2vfrFOGNV+NHtrP+bXK5HxHAhkw==
=zCAG
-----END PGP SIGNATURE-----

--cjDhQfLF9Bi5Pi5r--


