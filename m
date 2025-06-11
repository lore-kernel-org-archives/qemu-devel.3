Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD7AC71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ6R-0005gS-BS; Wed, 11 Jun 2025 14:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ61-0005bY-1F
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ5y-0000q0-Pk
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=08Afwdl1W0lODVPL/Io2W8wYjs9rQwa7Ob1fI06lkK8=;
 b=jQHjmNBGmNMSIuX8B3mNfDtn8EtFBGK6CLjh4TEnJwYmr4b28W+tXgJ6YBTLL0hfMkwli8
 1wzlp5vjdeUYIBdWu49wGXAfmuvFyXMgemTiqg2ZTTwznOGG3dtS0KAVzvfg2ZGELVUmxv
 xPlZ4r7a8Jxr7wRDdsC0OvVUzMDmYpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-haVF0K-jOiyqCZ84G52KZA-1; Wed,
 11 Jun 2025 14:22:40 -0400
X-MC-Unique: haVF0K-jOiyqCZ84G52KZA-1
X-Mimecast-MFC-AGG-ID: haVF0K-jOiyqCZ84G52KZA_1749666159
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F3E619200BD
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 18:22:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B1981941286; Wed, 11 Jun 2025 18:22:32 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:22:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
Message-ID: <20250611182231.GA198248@fedora>
References: <20250611075037.659610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UWCCNXGAJU7IKXVq"
Content-Disposition: inline
In-Reply-To: <20250611075037.659610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--UWCCNXGAJU7IKXVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--UWCCNXGAJU7IKXVq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJyWcACgkQnKSrs4Gr
c8iscQf/UrHhUbNrl0bpNma9087oPRztUr6Gzv9duiyozWrKpS+8QFTCkgOPjTrz
4XoVl2iIXYpVGYFL12e92LKPhpTE8TIuRNslryObzkpu0LCvZpgXD8apMgJQfcqN
pHQJPCIlyQCQokJEUpXOdef8EAz5fZRKzz6H5/Y5b9wmcl3PT60saCPB0WmtoP+R
2JDeHP5OBDLkyjJIav29JL0gRMCj1o5Z/bTSDc4MDYUhzF2777ao54VRugjlpmpr
x0vMVEnwDPTv93Z3x3xGmFGk9z4UWFLX46aTaeE/v1uBpdgQkgD3qyL3Xb1Leoy3
aNBYt7sQb3mC+OSK+CVpAhgjp+nP8w==
=MPCh
-----END PGP SIGNATURE-----

--UWCCNXGAJU7IKXVq--


