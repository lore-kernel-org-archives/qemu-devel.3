Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D0FC55184
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrPuA-0002Zf-NG; Tue, 04 Aug 2026 20:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPu9-0002ZT-Jo
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPu8-0003QE-9K
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785891283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7TppToUNcvtvqEjUXNa1spDHIJhXB6Z6ZP+7UeCzHko=;
 b=D4MFLXT3NeszcOLWojrCqw3e4aMhf0UcB6DRD1bZjm+r+zSXIho8+1rxwqrwB2r4fNpNsk
 molS2UYv8rgUrOgXfgiLyO/sFxL6WbyYIiIESoiUaSlO/PRU5NgiNdcty7vj9sNpSU1d1H
 eei/JqK3jVkypHHcx6NxHoXOdZPwGoY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-fO_mUUwIMqGWiModIz_pDQ-1; Tue,
 04 Aug 2026 20:54:41 -0400
X-MC-Unique: fO_mUUwIMqGWiModIz_pDQ-1
X-Mimecast-MFC-AGG-ID: fO_mUUwIMqGWiModIz_pDQ_1785891281
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D77FE1800366
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 00:54:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83F621956087; Wed,  5 Aug 2026 00:54:40 +0000 (UTC)
Date: Tue, 4 Aug 2026 20:54:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/2] vfio queue
Message-ID: <20260805005439.GA582093@fedora>
References: <20260802135846.328866-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A0hPf6QBt58dQ9cp"
Content-Disposition: inline
In-Reply-To: <20260802135846.328866-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
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

--A0hPf6QBt58dQ9cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--A0hPf6QBt58dQ9cp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyic8ACgkQnKSrs4Gr
c8g5kQf+Ja4hQoXO9SGWu1544miBGHfAnAe1tYTOksw1u2MqjhjkniY+zOMwchtQ
AdmDzzoHbcbdq/iYA6m9eWYSoFFc0lcJJ6IM+BroyTxQzXn+cciRXZHaWaszLBsQ
mU2AVcoEdAPHAdBPbwd8kjiutTP7q489Orh4zUNneX2Fxj2jpmmC8wr1BRuj0V5x
W1UzL1FFRbfflVh90JrAhsZHk7lw/FV5/qz56NTOOjc5yFsrU7lLbIAA/TD/W0g2
bakUBOKvkNRvHmCv3ecUOAgEsah2umX+lX+p4u5BPEJ0TCf0CoR9wEG72rRx8qk8
5mknNsG8h+vcoBOxE2TVs6bQJTcocg==
=/e3I
-----END PGP SIGNATURE-----

--A0hPf6QBt58dQ9cp--


