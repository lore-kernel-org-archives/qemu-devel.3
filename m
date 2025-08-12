Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6160BCA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 23:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulyYJ-0003Q9-Sr; Tue, 12 Aug 2025 19:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulyYB-0003PO-VT
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulyY4-0007ew-D9
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755041809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f8f2k5V4NiKKTppWrp4ZQT0qzyWVt/cIW4cqauhH9ww=;
 b=InZNx3h/2Cy48fTeJKWKbk6LjK5sATX+OSDIQZUj2NbPWrYeLGRNLx11rQWl2jQnX3AhUC
 +nxZSIKj+e815bTG+YawUGukfXUZGScLMJTDuQPbtokKw8v7lxYkAP3FgSW3I7Dy/7OOge
 qyPXzrROEvicAisBryTbvmW/78xTwPY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-APcjhFddP2iDp7pFlSwM2A-1; Tue,
 12 Aug 2025 19:36:45 -0400
X-MC-Unique: APcjhFddP2iDp7pFlSwM2A-1
X-Mimecast-MFC-AGG-ID: APcjhFddP2iDp7pFlSwM2A_1755041804
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AD50180034F; Tue, 12 Aug 2025 23:36:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F006195608F; Tue, 12 Aug 2025 23:36:43 +0000 (UTC)
Date: Tue, 12 Aug 2025 19:36:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/2] SD/MMC patches for 2025-08-12
Message-ID: <20250812233642.GA131473@fedora>
References: <20250812165642.81157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BPe9RB/l3JXrW7E1"
Content-Disposition: inline
In-Reply-To: <20250812165642.81157-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--BPe9RB/l3JXrW7E1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--BPe9RB/l3JXrW7E1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmib0AoACgkQnKSrs4Gr
c8hptwgAtP+kn9w+C630t/AWfK3w2igKDwol16aSkb4GtP/UdxmnCPmt6Ex5WOF3
j7H5t7ymsVy+Kf/qtxEj2ZOonsg5RMWq+aOYy7vw2MZ8596dMedjKGUf3cab0Uhi
2g7GSwew9P7+gFYGOAfrWDMJCFyvIuy8CegRtjb3yRvVmvSnTiju4c2pXSTkfqEZ
GxRLU2ylR/0ZTE+Hu3WO4ctER3h9xaGSuaysRyfS9IS1EHe0jMCH33VLe2d1eaJN
T+M9k2CVZ9OwdGaKoRfIN5Voh5/+y0LtAKdsVV2gaCEp3qbutoq8vW4IyP/mOE5r
WvT+PoxDGWb/mFSYq4TkjumWbTdesA==
=fMsf
-----END PGP SIGNATURE-----

--BPe9RB/l3JXrW7E1--


