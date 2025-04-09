Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AB8C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QqR-0006Sl-Km; Wed, 09 Apr 2025 04:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2QqF-0006Pq-To
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2QqE-0003u8-6q
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744187483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfuve8ttIKKpF5mix1gTNd8gg7ttBvnJD/OqNxqA0yg=;
 b=g4sdbHqeoKcxEF0cqHY4c8V0xcprBCLP9uf1fya/LdRXx7//kn/Yi0tizsTQHDbthV76IH
 SYBiJvVXsBZgU5wspUEJ4LhZtgOHv2NZPLutLGtAfVPMdV80YqDbCQo0dt+X+1Rvfe19rT
 +5nksNC4bocMOwY0F2AdMue6ym0g8oQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-0Vf3xro7OhWdVTBlOsv5pA-1; Wed,
 09 Apr 2025 04:31:22 -0400
X-MC-Unique: 0Vf3xro7OhWdVTBlOsv5pA-1
X-Mimecast-MFC-AGG-ID: 0Vf3xro7OhWdVTBlOsv5pA_1744187481
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CD2F1956060
 for <qemu-devel@nongnu.org>; Wed,  9 Apr 2025 08:31:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DCF119560AD; Wed,  9 Apr 2025 08:31:19 +0000 (UTC)
Date: Wed, 9 Apr 2025 04:31:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/11] QAPI patches patches for 2025-04-08
Message-ID: <20250409083118.GA24060@fedora>
References: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fX3f1IYBnpiC8Q4o"
Content-Disposition: inline
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--fX3f1IYBnpiC8Q4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--fX3f1IYBnpiC8Q4o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf2MFYACgkQnKSrs4Gr
c8hptgf8CETMxXjEY6JVOMBsC2Sl4uQCSGYVKTEKuA6n8HxMN8zdoXrdprJ/ElMv
9mH08GVDQImuXP4AiewKOGCFWib05Hp/csgn0fZ99SsBqT1VQDayeUy4Oaw+Cz0N
Q1O2wqy296VvGBFM9mGWvs64LoCbkx730WdcPFzkIDk20ue621cEnd3tMkKD+SHo
P4DYtMb8CX6+a6Y/jC2DfOSwACVjWOh9+Y/Img0FcoN6QS3KXU4TPNn0YgN57VOF
N/J4JerwMastN+BQQ89dLciLB9zNd1TQIjgghzaxDOdU5MHflP8GFcJtjBIy2snF
FJ3khZrFFHfl6mZndS0T+Qr1mdoOQg==
=02CH
-----END PGP SIGNATURE-----

--fX3f1IYBnpiC8Q4o--


