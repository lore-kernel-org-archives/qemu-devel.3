Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A11DF419A0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzd0-0005dj-PL; Wed, 15 Apr 2026 08:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCzcw-0005bX-Tk
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCzcu-00036t-LW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776257150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4YL+q5AGi6nO3nCACP7fANYPbFkTFgwwCYem+atEJg=;
 b=e/Jn59gShPx4tf+IlHD0jgFhmKBtn4bA5FMNeUjykS7UjgFwqEeDATIN3tkcZt7zJAEr/y
 YatwugvDR+B9yPamabZXdu1XKCDMksHnRRGvq9TMuJlowd4nUpTWt63T7V7xwCawghvtVI
 pXQZ4b9g170H+cd+5d0LC1Mts8AMNxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-a2cRu78sOGKSe834vI7MgA-1; Wed,
 15 Apr 2026 08:45:47 -0400
X-MC-Unique: a2cRu78sOGKSe834vI7MgA-1
X-Mimecast-MFC-AGG-ID: a2cRu78sOGKSe834vI7MgA_1776257145
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A989180049F; Wed, 15 Apr 2026 12:45:45 +0000 (UTC)
Received: from localhost (unknown [10.44.34.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39558180044F; Wed, 15 Apr 2026 12:45:43 +0000 (UTC)
Date: Wed, 15 Apr 2026 08:45:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matthieu Rolla <matthieu@minio.io>
Cc: kbusch@kernel.org, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mr-083 <matthieu@min.io>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <20260415124542.GB163810@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
 <20260414181030.GB136064@fedora>
 <C8F5F496-2401-45AC-82D3-EE0E3E1F2B21@minio.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ufh6uJhM4JmAAARw"
Content-Disposition: inline
In-Reply-To: <C8F5F496-2401-45AC-82D3-EE0E3E1F2B21@minio.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--Ufh6uJhM4JmAAARw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 08:14:16PM +0200, Matthieu Rolla wrote:
> To clarify,  we're not swapping to a different backend. It's the same disk file being disconnected and reconnected, simulating a physical drive being pulled and reinserted.

Is it necessary to drive_del to simulate PCIe Surprise Down? Can you
perform just the PCIe actions without removing the drive from the NVMe
device? That way the drive_insert command is not necessary.

Stefan

--Ufh6uJhM4JmAAARw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnfiHYACgkQnKSrs4Gr
c8jrDwf9H3i0m9q3czqHQoZndwTwxuJrDSWxapf3Q4vMQgM+V32ZepdmfG0SKDWz
40OGwcfu1g0/ogdDmsJlLto1bcHayibNUg6Ez6x6ahzqGJbMyfpoDYETbOfjQ6gN
sUUM53TumT/aBl0fuwfA7OmUJxBN2m/YWR1MQ68gQDYmoGVBHJO1PQlzvI3ZtfnK
VdT5gqhDlQAoFCDE/oa3MPmSrEyxiVw6Mw7Wju9CZ6oiG7VSJz86t7SJ66zBGJdl
0C9qUYvMgMejRUJm7FqyxzrFLfd2vtxfsHiETYXiv06BAIU6Cth7zDJR3FAI8I9W
t9Ht4OIqJB471pzrpHPirrnjlZ/CrA==
=Cfbo
-----END PGP SIGNATURE-----

--Ufh6uJhM4JmAAARw--


