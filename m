Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E50CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGve-0008On-0o; Thu, 18 Jun 2026 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGvc-0008OE-4I
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGva-0008Dj-Jj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781805202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=prSlXID//fxep2KV15LwCkYvyy3EHuMZ2QJeBzrPNzA=;
 b=FkmJTmSR/Xpk6NBdMRWMTSaCUsadQUGvt77jRisMh/d8+TEc+GYrysMfZTussqwiH3UyEi
 SLFMIhvRTZi3N16xDlpgWx11mn5/c4jsagrCAcUsr52vy2XbcoFYP5ppxayV2XwEDwNpoS
 qSl4XyLpm9Q+F4DVgk4QQwVJ4yUzh3I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-ZQ1NBhTwPpeNKA9d3U1svg-1; Thu,
 18 Jun 2026 13:53:20 -0400
X-MC-Unique: ZQ1NBhTwPpeNKA9d3U1svg-1
X-Mimecast-MFC-AGG-ID: ZQ1NBhTwPpeNKA9d3U1svg_1781805199
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F24C195607B
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 17:53:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C86C4404; Thu, 18 Jun 2026 17:53:18 +0000 (UTC)
Date: Thu, 18 Jun 2026 13:53:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] Miscellaneous patches for 2026-06-17
Message-ID: <20260618175317.GA748443@fedora>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MrM/GJ4Iv5Nr+O+n"
Content-Disposition: inline
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--MrM/GJ4Iv5Nr+O+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--MrM/GJ4Iv5Nr+O+n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0MI0ACgkQnKSrs4Gr
c8gLsQf+KFXE3caAjBFlIPLG4isLzk6Lk789WzzWjT1m4AtcQ2JiFmLhZ9oH9M0B
An7wC0xDq89A5lNmwwwoj4gG5zgYR9pC9b9ESdh4kmhfSC8GgoiahExws8JKfrjj
T/crwAfDupSNmNTKHzSJs5J6ky+e+fsp9VSMWxS+svzaB5AL7wXumK7mm8xaeJ9N
A0tQ70txbNvpbMkAhx8KZ+NOICGEjthTOeOOKsL5/V9+05XvjVbYSeik8bArOwmS
CHc5vy2OY4asEfiJXqkWU1lQWL10LdFScxxa+9Mqw1tAOxbtkOvx2C5ijeKUcqmh
eOmXjGeu39NsonAZMCKqgE6DsT5CbQ==
=4i87
-----END PGP SIGNATURE-----

--MrM/GJ4Iv5Nr+O+n--


