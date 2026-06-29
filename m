Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76833C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGk1-0003St-Js; Mon, 29 Jun 2026 14:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGjc-00036q-Hw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGjZ-00043g-Pb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782757769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Doxg7MZC0+zdngbnJGhAlBa2GwEsl8moKskazRxQFSc=;
 b=Qu2qi7uKOV4jnXyn81J/A+5DV1svKZtIdfv+ee6UxF47d7U4eK6OK27zjQsCbF5mqLoodV
 6ayWp2f5+ofQYIkuL3xbGSWBDJcLhsP0+8WrkGJx4WvSN/v8OtIpWZUbgZXD4k4HpiECU+
 lwXkQR55vwZGJ5oBEqQfmOEySg9XYGI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-biJt3VUwPOezkS-_zNZYHA-1; Mon,
 29 Jun 2026 14:29:25 -0400
X-MC-Unique: biJt3VUwPOezkS-_zNZYHA-1
X-Mimecast-MFC-AGG-ID: biJt3VUwPOezkS-_zNZYHA_1782757764
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD36F1800767; Mon, 29 Jun 2026 18:29:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E3F7765; Mon, 29 Jun 2026 18:29:21 +0000 (UTC)
Date: Mon, 29 Jun 2026 20:29:15 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 0/1] s390x/kvm fix for potential crash
Message-ID: <20260629182915.GA383334@fedora>
References: <20260629133133.1189753-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="etP7xbAjJXkBfpKA"
Content-Disposition: inline
In-Reply-To: <20260629133133.1189753-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--etP7xbAjJXkBfpKA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--etP7xbAjJXkBfpKA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpCuXsACgkQnKSrs4Gr
c8inKgf8CbhoIjWZFkXogL9EvCjz2dvh+1qddY571xzRVNODr049yzxZj+oydEcP
j5u+iUDjr8vstK3uL5uV6LH5jsd5f049WHlM0VFi2IXIe4vPtGvjPmNOe0X7HEa7
XiVYnllG7n2SfcecfSELx/hGzLGm4Njb+Cj9nDYko6l4edDqKI9ikBVwbsK1WTIX
pVwx8EenJgwrPG9aSbkWuaIs1rIr2rRMZb1bZQ85NCQvv74GXVMYHQ3dt6sJsriT
/IzXJzd08YVUyMhB56g76GJObA8lN42Jm6JrvAdveBYN+JDH1K6pp8OFvduSqlpF
/bFLTf8UfoJeMu1+Bhegns9dekAVzg==
=2E2V
-----END PGP SIGNATURE-----

--etP7xbAjJXkBfpKA--


