Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD1FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1PtR-0005PU-NT; Wed, 24 Sep 2025 09:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1v1PtK-0005O7-K6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1v1PtD-0006UL-GB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758721830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPXgd7QikQYN3T/ZBl3DBK5ug2BpVWDjRHAMjIYBwds=;
 b=giwaara+7kJLeHlz0OgVBx5YPfdNFDbs6OU3YAxvMKTCc2Als95SNqs2WLe//k0O29sK6R
 KXS+rpahVAnKFmbMZ8UfMwTO0AqJHAKrWeCoUXoH90n8QJof2wQ4zeaQX/BSboM1Bez2Y6
 n/6to3ZDZYwn42byXItPhmd6jELfIpo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-v7lqYKY-NV2ozbC6ZlYGvg-1; Wed,
 24 Sep 2025 09:50:27 -0400
X-MC-Unique: v7lqYKY-NV2ozbC6ZlYGvg-1
X-Mimecast-MFC-AGG-ID: v7lqYKY-NV2ozbC6ZlYGvg_1758721826
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEB251800577; Wed, 24 Sep 2025 13:50:25 +0000 (UTC)
Received: from fedora (unknown [10.44.32.109])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3DD51800578; Wed, 24 Sep 2025 13:50:20 +0000 (UTC)
Date: Wed, 24 Sep 2025 15:50:12 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com,
 jasowang@redhat.com, devel@lists.libvirt.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
Message-ID: <aNP3FErrzemnpfot@fedora>
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7F3F9Ma2ybz5mXvU"
Content-Disposition: inline
In-Reply-To: <20250924133309.334631-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--7F3F9Ma2ybz5mXvU
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Wednesday in 2025, Vladimir Sementsov-Ogievskiy wrote:
>They were deprecated in 9.2, now we can remove them.
>New options to use are reconnect-ms.
>
>v2: fixup docs and error messages
>
>Vladimir Sementsov-Ogievskiy (2):
>  chardev: remove deprecated 'reconnect' option
>  net/stream: remove deprecated 'reconnect' option
>
> chardev/char-socket.c           | 24 +++++-------------------
> chardev/char.c                  |  3 ---
> docs/about/deprecated.rst       | 15 ---------------
> docs/about/removed-features.rst | 22 ++++++++++++++++++++++
> net/stream.c                    | 20 +++++---------------
> qapi/char.json                  | 14 +-------------
> qapi/net.json                   | 13 +------------
> 7 files changed, 34 insertions(+), 77 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--7F3F9Ma2ybz5mXvU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCaNP3DwAKCRAU0rOr/y4P
vDb6AQDjFZoKjbcDfbjgPbtfi/T+Kjos7D5REwmMKYkUqRJXUwEAx9kLb0dlY5Fl
Nf5esSiu2ZH9xyJqy5VILyPzNIlcewk=
=0bf+
-----END PGP SIGNATURE-----

--7F3F9Ma2ybz5mXvU--


