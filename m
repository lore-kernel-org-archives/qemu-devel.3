Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45672C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eQZ-0000fh-CP; Mon, 21 Sep 2026 09:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eQK-0000f0-Rd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eQI-0004ZZ-Kb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789998669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZxf5BzPvrbolEyf8rnvL4Vey5u4rTz/G3m1489/ttY=;
 b=UqIP9l4f253p/AcmzQXx6uQ6FzOuKxjBthZ+90ylGIZXzaUF1OKUCwdt5RIQgIm2UkfwNF
 FAXEoi+yxm7Wx4bwGjE+qzsxARvp67u7NpHBZceN15mKndY9PSHufnU6g2H3CoOTspnppz
 zX7hVdNY7dd0PpyZOQjDeBhWg9/VZEg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-FZ4-BpzGMxCYx3a973JgRg-1; Mon,
 21 Sep 2026 09:51:04 -0400
X-MC-Unique: FZ4-BpzGMxCYx3a973JgRg-1
X-Mimecast-MFC-AGG-ID: FZ4-BpzGMxCYx3a973JgRg_1789998662
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7089E18454A4; Mon, 21 Sep 2026 13:51:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4ECFA41B; Mon, 21 Sep 2026 13:51:01 +0000 (UTC)
Date: Mon, 21 Sep 2026 09:51:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 09/14] qemu-options: Change qemu_opts_parse_noisily()
 to take the group
Message-ID: <20260921135100.GB90591@fedora>
References: <20260918223002.1892021-1-farosas@suse.de>
 <20260918223002.1892021-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="stWh8AqMWtBjfz59"
Content-Disposition: inline
In-Reply-To: <20260918223002.1892021-10-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--stWh8AqMWtBjfz59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 07:29:56PM -0300, Fabiano Rosas wrote:
> Pass the group name as argument to qemu_opts_parse_noisily() to make
> it simmetric with qemu_opts_parse().
>=20
> This change solves the issue of qemu_opts_parse_noisily() crashing on
> a NULL return from qemu_find_opts(), which can happen when an option
> is invoked for code in a module that is not loaded.
>=20
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  block/monitor/block-hmp-cmds.c |  2 +-
>  blockdev.c                     |  2 +-
>  chardev/char-hmp-cmds.c        |  5 +--
>  include/qemu/option.h          |  2 +-
>  plugins/loader.c               |  2 +-
>  qemu-img.c                     |  3 +-
>  semihosting/config.c           |  4 +-
>  system/vl.c                    | 75 ++++++++++++----------------------
>  tests/unit/test-char.c         | 12 ++----
>  tests/unit/test-seccomp.c      |  6 +--
>  trace/control.c                |  3 +-
>  ui/vnc.c                       |  3 +-
>  util/qemu-option.c             | 14 ++++++-
>  13 files changed, 54 insertions(+), 79 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--stWh8AqMWtBjfz59
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqxNkQACgkQnKSrs4Gr
c8g35Af9Gw1vwEAT9baJxLJR5UBlJYy+JofNZwoRYHmrTLMVACocsdsJLjh5UC8a
C4CTTWNQi21T9KSNjRO0p5OJAINqm3rjxTuxuPXrYOqs7bIylZNgu2xgg8+6KHHc
Iv8uclCogDLTtZ/2bkKzN6HmUlFrKHMS9pyk/0SWV9RpfgSTvclPNPD2bQZw5zbh
ZVWiz7ag3aNoG8wHymye5mp/8ETauzf558ziIwNfBmviH2VQtX47lKmW0eQG/feU
h2z1vaF/OlgprHiJdIHwBzRvKm4iH3qFWbRCHTc++5ij/g6z3DV34htn1jpgl24G
nDPW/Yyl9ZdTwcksNk+4YuIs6mIkjw==
=y3JR
-----END PGP SIGNATURE-----

--stWh8AqMWtBjfz59--


