Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD29C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGhY-0003VN-2V; Wed, 12 Feb 2025 12:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGhV-0003Pz-Eb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:39:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGhS-0005eZ-Q9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsLZBmmOcDJDixDkYI/BBQKbJ0sWQRd3mlLIwt/194g=;
 b=IxegkiCpFkQ6tknPpp5YQaUZFm2jU/4vEfAy0htmBk3eva+mrhjfKg96viEUm2DkCb6cBT
 lk+BSEyYWLvWopSmvbIK/PXxutukC9CXimJEAsdqzjlQ74++uSQjR51sHOLvVN+wDvw8zl
 p4G2sxR9zwRJJVdkyIW9DiBqkxuTL0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-sKfkT3AhOICieEg3fW5TFA-1; Wed,
 12 Feb 2025 12:38:58 -0500
X-MC-Unique: sKfkT3AhOICieEg3fW5TFA-1
X-Mimecast-MFC-AGG-ID: sKfkT3AhOICieEg3fW5TFA_1739381937
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19111801A10
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 17:38:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47B5E19560A3; Wed, 12 Feb 2025 17:38:57 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:38:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] NBD patches through 2025-02-11
Message-ID: <20250212173856.GA211910@fedora>
References: <20250211202527.574723-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kNmjVIfUIlBECLSC"
Content-Disposition: inline
In-Reply-To: <20250211202527.574723-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--kNmjVIfUIlBECLSC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--kNmjVIfUIlBECLSC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmes3LAACgkQnKSrs4Gr
c8g0cwf/eyoo27dtbGXYFzLwCLSii25LKXMqPgjT9BR9GsGzV88yPO19/c4BH/vw
ZJqsvnqIBeOdixVv42g0lsM+/QupDcgU0H7eEF+8WpVF5OXSNhzlmRPZg1vgawOl
22PvS8m7ok5onKzoW3BDr8a+7ktvqrkdGFC13vkfvawRq31BuF03UArF8aYBHx9R
NGnblM4A3MP/LufWqaGkyqE7WN74He8VVvDeALSo8VXLT/eKgxdMowOe8tjv7ylK
+uOWA/QSKH0bVoPNskPMnmAJijPuU7NZukXsFiDuaDDP1ARaOOeox9YI9g3CtYDm
lioCrIZYAekqXEkGjhlVuyR5qpzmig==
=yFEw
-----END PGP SIGNATURE-----

--kNmjVIfUIlBECLSC--


