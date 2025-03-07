Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83070C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS7v-0002yT-K4; Fri, 07 Mar 2025 02:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7m-0002xf-5i
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7j-0002ID-Md
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741332479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5H9rwfeP/6O944Xpvu2L4Ru0Rq7tHF86eZT1lk39ZDU=;
 b=OqRlrQCulNUGCaw0CyB7ZoF7uvhHB9eck9hxAQGeJudDGRz9LQWNdBqudeTEckOZ5XRyga
 rhntE5rNj4pmpK+eZdqDkQgbQ2CNeYPY0GR2ocsb9H+A7RhWOv0ree2CrjQ2sXqsK3GTXB
 //PUkonADE/00CLRYRAFjsLQeX8NnGM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-zAN6M8ScN7CaEdQEBvKAqA-1; Fri,
 07 Mar 2025 02:27:55 -0500
X-MC-Unique: zAN6M8ScN7CaEdQEBvKAqA-1
X-Mimecast-MFC-AGG-ID: zAN6M8ScN7CaEdQEBvKAqA_1741332474
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 133501956087; Fri,  7 Mar 2025 07:27:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C406180AF71; Fri,  7 Mar 2025 07:27:51 +0000 (UTC)
Date: Fri, 7 Mar 2025 15:18:26 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PULL 0/1] Block patches
Message-ID: <20250307071826.GA362043@fedora>
References: <20250306022106.304510-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QmgneXYWJoHdD3I0"
Content-Disposition: inline
In-Reply-To: <20250306022106.304510-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--QmgneXYWJoHdD3I0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--QmgneXYWJoHdD3I0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfKncIACgkQnKSrs4Gr
c8isLAf/RQg4oWsLBPT1dmzi+N6d1nE/DSL4S0sLtnxFdfek11+j9fSZtiSDoivp
3HeqC69i/aiCCHrHKxkEDnk+Eyq7G+dz/xQGRSuv11hCnl2X4M5BrGBZVDvjzYLS
2RmOkFbPDXdwaj30VTd6+BEINuGvP2cs2m7V+8SMK8etnyGhPeKELRvF5Yf5pcDr
TR9cwv+mqp5vTHoQ/kFd/lu03FiYL4q8/LIVhXnDU00FoY+nNA32WufiXS38EUUa
E4GOff38gEu61bMHDgVnjqIfaSz2cejRJVfqeFs6DkqoUh5Ps4AqKVRQxKJsyAeK
RgYD37oNL4gZ5lycMIL3kCTGImUadw==
=jV0E
-----END PGP SIGNATURE-----

--QmgneXYWJoHdD3I0--


