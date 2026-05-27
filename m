Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1927CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSN4f-0002TQ-1Y; Wed, 27 May 2026 18:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSN4d-0002S6-3Z
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSN4b-00007o-9h
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779922199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ia5ja4A8rHnMLECOaWxRooS0MyB36iziA9SgcNr0rIY=;
 b=EyADceHbdF4UllpjHdL0Zljk5novblbpnbQ1OXtbDbJh5YXaMcfvXlCwZMb7cFapIv00Tc
 BquZ5bYmdY2GOwCSMTLJO7qA001AVeZmwqGTLFTVleizasSrApNEWm4otHAINatit4eaN3
 uLa4CsklQuR75d/9EE3UB4EqoxPjbE4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-J35UmZEuPz6RK12OsRYujQ-1; Wed,
 27 May 2026 18:49:57 -0400
X-MC-Unique: J35UmZEuPz6RK12OsRYujQ-1
X-Mimecast-MFC-AGG-ID: J35UmZEuPz6RK12OsRYujQ_1779922197
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6201180034C
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:49:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BAC519560AB; Wed, 27 May 2026 22:49:55 +0000 (UTC)
Date: Wed, 27 May 2026 18:49:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/7] vfio queue
Message-ID: <20260527224955.GA13474@fedora>
References: <20260527122700.1589764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1xClsJb/LeToW+Ft"
Content-Disposition: inline
In-Reply-To: <20260527122700.1589764-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--1xClsJb/LeToW+Ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--1xClsJb/LeToW+Ft
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoXdRMACgkQnKSrs4Gr
c8jr+Qf/SpA9UISB3MF50vkqpb7pitDJmsL3z11FpIJ3JGDFmfh9EZnjT3ZFWHjv
s61/lbZZGnG2MVOKVBXNBBXvjNzVv8LRkPrLuJoxGmNRiFHvwNRsMbG2licY/WqD
w1qXzCuV86kMzltPyiqXzsxtZnNeqnkkNYN0IYRzEsWvCLe3t+ORn6Wq05/r/ocy
sPrxsl+Am0W/GBs2rRWjBt8mZ0n0e5tKmVktTcZ/xMorA+q5ZuY0LEtbxVJxfPF0
A3Erlr8PhTelqA02VjftBKMkMK5BMXOpXUdS5SlGeQ94vYJljiXueUVIfseNYX9p
PgH9d34Ob+vbNaaJvDSC82kI9SyCwQ==
=hi1L
-----END PGP SIGNATURE-----

--1xClsJb/LeToW+Ft--


