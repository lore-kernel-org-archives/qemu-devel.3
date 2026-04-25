Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A0CFF8864
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjA5-0004Te-Rq; Sat, 25 Apr 2026 15:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA2-0004TK-JU
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGj9z-0002b3-An
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mHDZuw706nOxszFPJkG/MMv+TeaKtaTgj5aLHQ8De90=;
 b=M8msc1RgR2Shzej1rHpxnBDGL5hcNnqfEav+rTLwZ4bxLdRalDBG4NX4b5qjcW65UiSSF2
 SsAGqc58HZcgy3zJ27rKRa8Mq8kotG+3l9p1A5AF/0AcJGFpdBJedWXXdyebY64F3JfPkk
 bx3AXk5DvXsGuKQUiUEyR3ZUn3ICNNo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-PvpIunsSPSeN8HSSjDuApw-1; Sat,
 25 Apr 2026 15:59:23 -0400
X-MC-Unique: PvpIunsSPSeN8HSSjDuApw-1
X-Mimecast-MFC-AGG-ID: PvpIunsSPSeN8HSSjDuApw_1777147162
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 019CC1956080; Sat, 25 Apr 2026 19:59:22 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23A2A3000C20; Sat, 25 Apr 2026 19:59:20 +0000 (UTC)
Date: Sat, 25 Apr 2026 08:30:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/59] target-arm queue
Message-ID: <20260425123027.GA128716@fedora>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iniBlZM1rPiiubUN"
Content-Disposition: inline
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--iniBlZM1rPiiubUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--iniBlZM1rPiiubUN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnss+IACgkQnKSrs4Gr
c8gfYQf+MHJzck3dEoSVfTmjFxgu3LJUa+G/hVXy6X7ihG9Oa2xp/uBy6U0ExXUR
rSgkMN03eTJH4QiLuFq5a840Xeld91CW2ZPUtUUUH1KIH5tjMLy8+5CQ39PKM7G1
94wEWpmpDrag62folZAlmhwTHbNFlKhUZe2ftPcn0hE4/lVd62doford3yn7kzFn
JVPv4CUFqCGWRqs/2SxwW1mNjtLvvyWCe4fCkeootjiVByOClhOWidy0pDRUKUsX
NfbxEMnqc88s+0JAUJpPRyX9568ZygIxHd2+CHa82sofGxttNkRgIiKyS3nb4wdd
2pK3pmZ6DM4EZDX7DQNt1PBYNQojEQ==
=bbqb
-----END PGP SIGNATURE-----

--iniBlZM1rPiiubUN--


