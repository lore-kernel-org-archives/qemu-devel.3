Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD18EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM3jA-0000yT-Q6; Mon, 02 Jun 2025 07:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j9-0000yI-6k
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j7-00019w-Q6
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748865193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdJvIg+cRdkKutHfQkjNMyNds/MYdO6sZjF1lz6NT3o=;
 b=HVXG/zb5pchcuM01uMynrLQuTqg7vPrNlcdfSu0nrRU1ONb9VMwO7G7SgDqL8lsK5Veow5
 GPy3Dn9oIOC+K8g/4ojCxuFZ6X1dMpCMqt4YAK7Azp6lOyhXyUOOX1m+7tlCSUPqO22D1U
 yLiLpiMWylEskITwBkymSFhESw9J4Yc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-BFhQoLf2MSubxP8wGCjEhQ-1; Mon,
 02 Jun 2025 07:53:09 -0400
X-MC-Unique: BFhQoLf2MSubxP8wGCjEhQ-1
X-Mimecast-MFC-AGG-ID: BFhQoLf2MSubxP8wGCjEhQ_1748865188
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3857180045B; Mon,  2 Jun 2025 11:53:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C8EC180045B; Mon,  2 Jun 2025 11:53:07 +0000 (UTC)
Date: Sat, 31 May 2025 19:06:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/15] target-arm queue
Message-ID: <20250531230628.GA268216@fedora>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="27TKW/jhE8Hwm1CJ"
Content-Disposition: inline
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.015, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--27TKW/jhE8Hwm1CJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--27TKW/jhE8Hwm1CJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg7i3QACgkQnKSrs4Gr
c8g/2Af+JZZPZhqu856eNC0IdWFnzPF+3+dZur4LV+vyclpdiwBA6TrtGepiNUMZ
8Vo6bHOESdrIs0HmrI+DYSREplVsWQ9I+Ennip73pvdWjX3tvZeYRefCoKLr41Gm
s+0EByURCrFGOjhDMZb+hmW0nslgeY6XBw2JvpWVpPhmIIZ92hCT+BZCqicXCcKL
imSadZuz1m5Fz2D5UDKLoobKsl5y+kkln89mF+FPJGMr2JdOajBbTl74Gqfs7u4s
18PJvv6TCHSnr+q6OOI7oOIPMO+ij1UyCQLpZZ62u2SE+AsOvkhyQmLNS3r3whfd
kAHA1zajRXKPB2CeJWN/LRbH5iNI2A==
=xHbP
-----END PGP SIGNATURE-----

--27TKW/jhE8Hwm1CJ--


