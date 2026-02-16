Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A5BE81A36
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs0Q0-0008S7-Pi; Mon, 16 Feb 2026 10:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vs0Pv-0008RC-Ls
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vs0Pu-00051j-5n
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771255301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lolAJwU95cspVYi+O/FGFooyC07WrVNHa4MAnvJGV+c=;
 b=X1gbkTW4D7utAlPPoEfiHxyhZpb+a35ftq8UtGdcUqOZJSAQ1Q5+HPu7ja4SX+MDpVqPh4
 i3YmyuD80tCLPYfzBnGkUTsu3SDbflsNfaIrte19deoq8bBfa+7KBxGwNWVTauzs4gwSVf
 SYeGLCZaFd5FAGXpw4ahvxoq4V+SZVE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-lTE6hE1BO1-2lUDOmbF3AQ-1; Mon,
 16 Feb 2026 10:21:35 -0500
X-MC-Unique: lTE6hE1BO1-2lUDOmbF3AQ-1
X-Mimecast-MFC-AGG-ID: lTE6hE1BO1-2lUDOmbF3AQ_1771255294
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 026AC195605F; Mon, 16 Feb 2026 15:21:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E892918003F5; Mon, 16 Feb 2026 15:21:32 +0000 (UTC)
Date: Mon, 16 Feb 2026 10:21:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 1/3] aio-poll: avoid unnecessary polling time
 computation
Message-ID: <20260216152131.GB396170@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-2-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9fYxM+oHg/kIJ4A"
Content-Disposition: inline
In-Reply-To: <20260113174824.464720-2-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--t9fYxM+oHg/kIJ4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:48:22AM -0600, Jaehoon Kim wrote:
> Nodes are no longer added to poll_aio_handlers when adaptive polling is
> disabled, preventing unnecessary try_poll_mode() calls. Additionally,
> aio_poll() skips try_poll_mode() when timeout is 0.
>=20
> This avoids iterating over all nodes to compute max_ns unnecessarily
> when polling is disabled or timeout is 0.

Did you consider optimizing the case when polling is active and there is
no way around calculating the polling time? Glib has ordered data
structures that have lower operation costs than O(n).

Stefan

--t9fYxM+oHg/kIJ4A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmTNfsACgkQnKSrs4Gr
c8gVCwf+I5zh/gax7mNM9dxpgKVtnVcjdslqhc7hEh1tofguR7LCAJr8fknforAW
rd2eJjNf/4Fipkze9yZXFbO4D83P4tO7j493DD87izYP5rttgyyXCtON/lN91fyR
nkuZEKA0iXfPU6ldiuhUVsBFNw+Q0NN1a8Mk9O/vlrAVrAS+x0rByXCE1KT5+dW6
rx/zaMWI4JfqKEg8Hn1vMrC4C/Ad0eYYw8Li8AShXDb82juUCkvfCYfXpTXT2Tmi
tXw1ppDCK/hMo5Fc3kEXi8DGfKIcUeSfSh0LtiAfTyTQi1cKZC4/pesdFK064n3X
USPNcczcpksbyz9foUNAX8eiqsbVhg==
=bprO
-----END PGP SIGNATURE-----

--t9fYxM+oHg/kIJ4A--


