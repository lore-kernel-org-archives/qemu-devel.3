Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF109CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXexr-0000FJ-Pc; Thu, 11 Jun 2026 08:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXexo-0000E6-TB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXexn-0006Vj-0M
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781182608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pub4y2YHeIrkO8bn+5wPLGe+c894GIPkyVYnPDwcQrM=;
 b=hRQNFqetdaaczBev3JyzMN2OKWqryXzIwX+I3oCOiUW/FR3/NAlHz8kOkudjW3kaF80oPG
 nWUlr/EDWOUJMEGqZMtUnGmCUXJD2cmH7o3veNGvbxh4e6X8mAGI2KfArLVRu90MqxqmEh
 exwvNWjewZK0fkfAq8tggHKbAO9L6FI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-MyC66KHDMxuAcBOqLjXonQ-1; Thu,
 11 Jun 2026 08:56:47 -0400
X-MC-Unique: MyC66KHDMxuAcBOqLjXonQ-1
X-Mimecast-MFC-AGG-ID: MyC66KHDMxuAcBOqLjXonQ_1781182606
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69B8D19775A5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:56:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.137])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EC861954B09; Thu, 11 Jun 2026 12:56:45 +0000 (UTC)
Date: Wed, 10 Jun 2026 20:54:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/42] MAINTAINERS patches for 2026-06-10
Message-ID: <20260611005459.GA171891@fedora>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ia/8BDmhPgce8bQu"
Content-Disposition: inline
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--Ia/8BDmhPgce8bQu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Ia/8BDmhPgce8bQu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoqB2MACgkQnKSrs4Gr
c8hSRQf/bXZD07VHRXgxi+9N+iE3vsAyodGCwjiAkk4DIcFeKVdA1ELQlxT8qEwY
jQ/GKNVrQ6gO3BzueN0Z6k98o7ENEj34cklVzl+jlZAmQ8HpsNX9O8wBlWtSlg4Q
yorWFcB9Clx+NLu8ls9084h+5ydWihaIVNDDVl5GduGkYCNdQyXnZsOWNt3lB+oG
at0bTw8cPWuyHHGpIbKCB4Fd2hGfIKmC2vgMX9ZEbh1xkm/u6tkhjP8mbuNhCnTh
eDCsCGityDaNg2lcmeW2imXwdyBSWTaYRv7CqmSaYJSPl7fj2b3qmnTbYZkwvF+y
7WJdChdB6ufNWy4EVgXDNHjpgdP3Ig==
=IS2M
-----END PGP SIGNATURE-----

--Ia/8BDmhPgce8bQu--


