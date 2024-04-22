Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1782C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvjJ-0001LB-8G; Mon, 22 Apr 2024 11:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ryvjH-0001Ku-T3
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ryvjG-0004bj-A8
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713800233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3WaZDU/J22/rfz6WSV00kAJIW1b3odqQQBV4Ynoins=;
 b=bUNagksfj8VuHAW/zOQ4L/hO+p4xjunpAzodKUwPRMstrmjYQp7ON9kJWxgL975Usg+YHC
 7CNEuU0O+eJfG42NMN61SnKXqcrluttAng0isMoHh46cgTl8zcpXs/dZQWZRIZNzlpiql2
 L3lBB4D9HUb1Oxu24e1qlSgRYQmijOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-QNt9TzKNO8Cxf9sh1Bowzg-1; Mon,
 22 Apr 2024 11:37:09 -0400
X-MC-Unique: QNt9TzKNO8Cxf9sh1Bowzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BE3329AC003;
 Mon, 22 Apr 2024 15:37:09 +0000 (UTC)
Received: from localhost (unknown [10.39.193.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2B061121312;
 Mon, 22 Apr 2024 15:37:08 +0000 (UTC)
Date: Mon, 22 Apr 2024 11:37:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] tests/unit: Remove debug statements in
 test-nested-aio-poll.c
Message-ID: <20240422153707.GB77895@fedora>
References: <20240422112246.83812-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o3LkhkKz6NsA4JeK"
Content-Disposition: inline
In-Reply-To: <20240422112246.83812-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--o3LkhkKz6NsA4JeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 01:22:46PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> We have been running this test for almost a year; it
> is safe to remove its debug statements, which clutter
> CI jobs output:
>=20
>   =E2=96=B6  88/100 /nested-aio-poll                      OK
>   io_read 0x16bb26158
>   io_poll_true 0x16bb26158
>   > io_poll_ready
>   io_read 0x16bb26164
>   < io_poll_ready
>   io_poll_true 0x16bb26158
>   io_poll_false 0x16bb26164
>   > io_poll_ready
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_poll_false 0x16bb26164
>   io_read 0x16bb26164
>   < io_poll_ready
>   88/100 qemu:unit / test-nested-aio-poll        OK
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/unit/test-nested-aio-poll.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--o3LkhkKz6NsA4JeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYmhCMACgkQnKSrs4Gr
c8jYAQgAvlDqB3zOqkP6qnjjflaBiPPtw0gSy6tKSg37VG6Il4swtFJFzQDdBMkn
5piM/G64cUCIV5m7dFgh0hj5YVrr6qMbKP7+sDUyxm7EmDE1/0MvTK31s4tspHyK
1CdzX4lEemXOIC8hR4rRGHJFQOg94xR+gjtGFqNpvoTYJF8HtH0IIi491HbXHWRi
0CbLp8REDsoVys4brDcajVVhOtHkVI+ecxbUcQepzyGPZ6F5KxDNZwemJlLri1ui
3CV0OB9G8EdvbQq4x5KJAE/dUik2OxvN4Nfo4n3kP0WzKB1ZBgPwkJZ/IiHFlrN3
yjLI7jpq7vJNYP/Z606+4rliT6KdBg==
=JtbI
-----END PGP SIGNATURE-----

--o3LkhkKz6NsA4JeK--


