Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A1FCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 19:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw46h-0000LC-1n; Tue, 09 Sep 2025 15:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uw46c-0000Ki-Vr
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uw46T-0006PZ-S1
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757446446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0oyMKn8c2HzAyXlAk8xm9/7/BUyYrZLxv/pZQYevvus=;
 b=TJgJc1XxUZf9ViviseaHbcHNFsjFeECrdwZchcnZzIz7IUh1L1aTXTwOAd9eW387aa+pnn
 FTexIPJJ6Bw0iwszuK+qiduEMNyRRbVSS08JwQWdMEJoBBXNtIhygh6Ny8Zbers0jsT+3e
 bu4oR2jj3gycBJSgBERfYJzMD81buMk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-lvAZ7rF1OhuL-cewHT0UjA-1; Tue,
 09 Sep 2025 15:34:03 -0400
X-MC-Unique: lvAZ7rF1OhuL-cewHT0UjA-1
X-Mimecast-MFC-AGG-ID: lvAZ7rF1OhuL-cewHT0UjA_1757446442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D94831955F26; Tue,  9 Sep 2025 19:34:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4F363000198; Tue,  9 Sep 2025 19:34:00 +0000 (UTC)
Date: Tue, 9 Sep 2025 15:33:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
Message-ID: <20250909193358.GE218449@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YtKW/8yiALL7lCi0"
Content-Disposition: inline
In-Reply-To: <20250830025025.3610-4-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--YtKW/8yiALL7lCi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
> @@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport *blk_e=
xp)
>           */
>          g_hash_table_remove(exports, exp->mountpoint);
>      }
> -}
> -
> -static void fuse_export_delete(BlockExport *blk_exp)
> -{
> -    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> =20
> -    for (int i =3D 0; i < exp->num_queues; i++) {
> +    for (size_t i =3D 0; i < exp->num_queues; i++) {
>          FuseQueue *q =3D &exp->queues[i];
> =20
>          /* Queue 0's FD belongs to the FUSE session */
>          if (i > 0 && q->fuse_fd >=3D 0) {
>              close(q->fuse_fd);

This changes the behavior of the non-io_uring code. Now all fuse fds and
fuse_session are closed while requests are potentially still being
processed.

There is a race condition: if an IOThread is processing a request here
then it may invoke a system call on q->fuse_fd just after it has been
closed but not set to -1. If another thread has also opened a new file
then the fd could be reused, resulting in an accidental write(2) to the
new file. I'm not sure whether there is a way to trigger this in
practice, but it looks like a problem waiting to happen.

Simply setting q->fuse_fd to -1 here doesn't fix the race. It would be
necessary to stop processing fuse_fd in the thread before closing it
here or to schedule a BH in each thread so that fuse_fd can be closed
in the thread that uses the fd.

--YtKW/8yiALL7lCi0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjAgSYACgkQnKSrs4Gr
c8iISAf7Bi2JjJ9wkpzx7d1qTo5TKP9HxHCCPXqkSEviN/uDUrsSxiXVexB/69GX
B/iXcmtKkrT40KRGLfDMrULsou0/56my/zfe1ZEnZgileUbZOXYh0gyg5GPkluiy
V1zml4ZPUuGiOO+WyErHHMCfgzdvLBQYC+lCIp93h+X6nKoSAZqgfB8M5Kl40aY7
YK8w+A83ye8m4WjYJTNFffKZv1VVp2K0ApCgrqwTfRm5Wz2/v0e46Tq2HOnnOUHa
FdGAOZCxBdqiD0Ivb7FzrrNdLqijlvmm8punTg0eH6ZRwp9SQfDnjQ/hwLMdZB9w
lG9P0jBrHDJ2eJe1J7AKVGd7Obcx9A==
=cGJc
-----END PGP SIGNATURE-----

--YtKW/8yiALL7lCi0--


