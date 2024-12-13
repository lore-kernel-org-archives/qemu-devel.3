Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5189BE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuQp-0000sI-Oa; Thu, 12 Dec 2024 20:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQc-0000nP-SB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQY-0003Dy-8t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734053109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9fcP8aOBsKR0g9U63DwKUzKMEA6oafQrK0PCCojdfCs=;
 b=WwmZH4xpIU1TkNvrl9FjBsoCiDVsKPtO+hGpViFAo16c86tUrOwwtUBfY4gR8r70vTDKYc
 Y+6hhLAe0JRH6j2p/ZLTgQXdJzNAsJ23h4hT96L9nFLpX36NUfRFEJMA4fjVhUJXGkxe81
 zIXof8485hgU4hjQ9peUVy+eR5/gx+s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-lGXC5kqgM4-SBRawsYQ1yA-1; Thu,
 12 Dec 2024 20:25:05 -0500
X-MC-Unique: lGXC5kqgM4-SBRawsYQ1yA-1
X-Mimecast-MFC-AGG-ID: lGXC5kqgM4-SBRawsYQ1yA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F88D1956046; Fri, 13 Dec 2024 01:25:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A2FF195605A; Fri, 13 Dec 2024 01:25:04 +0000 (UTC)
Date: Thu, 12 Dec 2024 20:21:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/22] QTest patches for 2024-12-12
Message-ID: <20241213012112.GA395453@fedora>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VraijbMsm6fbfa8J"
Content-Disposition: inline
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--VraijbMsm6fbfa8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--VraijbMsm6fbfa8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdbjAgACgkQnKSrs4Gr
c8gM9Qf/Y3gsfHvMNMWXYFJs4rGoNKMZYpsQLeS7juDDfsN8KirJ/0RsIMd4dZVD
2+0YHoOKFRrNrS4HpSqtmJOUppqvnYBCUWOpUTnLILTFcQhOE3HrWVkNrc5kqSUL
iJ/mFMeib4n5XgjvskRAMhMpt5Hsn9L1xL8w0Mjf6krEQYN2rjmo87+8mUq7zYxO
x0/agR33LwAgEDWTIjC/hzDawPU0fDZ3ex6ubOTux6krafNk1SCzODaOLAYJdDcv
ZGdBMTWb+9vvByOjiP91JEvO/BGBV3+rU6NjTA9BTQ/G/CDP/pbA9mfVdntrhNsz
2/Sp1midAxI2rKiBDK9Qtelwc4Y8zQ==
=9WoW
-----END PGP SIGNATURE-----

--VraijbMsm6fbfa8J--


