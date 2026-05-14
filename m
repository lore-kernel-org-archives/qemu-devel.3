Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B91CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNW0g-0000cR-FN; Thu, 14 May 2026 09:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNW0e-0000at-II
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNW0c-0003gv-SB
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778764908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l117w3T4GoQN6v2bIXW9fXCUs2SkSegCp0m9wEUKZXU=;
 b=Ne6BwSuXzaLk2LmhuER6PROplvqnWZLqiP2JOonPzIkZJyhIj2NL+8cu8hORgs6eRqsNwE
 2w+hy5N92kpoybqg7Wfif+RsxS1ugMKWGAND3hpWotQVooRY2FabZUE+txg5T/KnHJePrh
 MbEgNpfQwUZuUq80+hXuWZoG2F2ARGc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-7WQfmEo8N4CQFESUl8_h_w-1; Thu,
 14 May 2026 09:21:46 -0400
X-MC-Unique: 7WQfmEo8N4CQFESUl8_h_w-1
X-Mimecast-MFC-AGG-ID: 7WQfmEo8N4CQFESUl8_h_w_1778764905
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 631DC18002D7; Thu, 14 May 2026 13:21:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFB8019560A2; Thu, 14 May 2026 13:21:44 +0000 (UTC)
Date: Thu, 14 May 2026 09:21:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: Re: [PULL 0/5] ufs queue
Message-ID: <20260514132143.GA1399736@fedora>
References: <cover.1778560533.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GpaXeoWcUqUK/SvF"
Content-Disposition: inline
In-Reply-To: <cover.1778560533.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--GpaXeoWcUqUK/SvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--GpaXeoWcUqUK/SvF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoFzGcACgkQnKSrs4Gr
c8iy6Af/a0ecAlaCmsK88p/PNAoouHJvBQibzGYH+/Kvrr18hq0uFnJNWRrpehxF
3z1BSpOvxXWP2nwNRRuUC5YoDGio9n2cZ4uzatwjXOmuBfT8NSLYb9nGw1BZr6sR
+VW2+yif8jyCNX0PYhYFJ7v/WHCB/bv9Hee8n7/bkyhceMcB5DGGjARwY5XY7A9U
7F5bUsGMimQkLlUKOlHWt+d8PK7YdW1MfJlR7lk7QnQHpqc/15674SvSfw5bdkac
oukhjGx8Hlevvb45lFnL3aob2Y+OsXui4e0A9LkkT0+4JRt42WF9W690iRa4cUz4
YTaHVYJTf2PMrWi+sIgvj8xHmdSwdw==
=CA1N
-----END PGP SIGNATURE-----

--GpaXeoWcUqUK/SvF--


