Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF478C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpdZ-00082l-Ly; Thu, 27 Mar 2025 11:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpdY-00082N-3d
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpdW-0000Sn-Dm
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743091157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/EaxZKjsouVrj5QrKUdrly+je/MOb4lndH/Ho81qbk=;
 b=LJhxSws72bxLOWsflnY40R2+SQYv3vt2B3rV/2vZ0WHHDbrLFaHNfvQsJQkdIWfFLf8fHU
 x3J1axTpjrHvqxD/cdHTH3f+VZ6CnH2CtBCTAnzQz4vHkPTnmRk2MZXd6nwaiRojVr3uZd
 4WSO/7ABjyhhZ9Ge3ZJpzKXpViHH5Dk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-gzFMMr_uNiqPWHgxr25B0A-1; Thu,
 27 Mar 2025 11:59:14 -0400
X-MC-Unique: gzFMMr_uNiqPWHgxr25B0A-1
X-Mimecast-MFC-AGG-ID: gzFMMr_uNiqPWHgxr25B0A_1743091153
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CDC818EBE8F; Thu, 27 Mar 2025 15:59:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6F0430001A1; Thu, 27 Mar 2025 15:59:12 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:59:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 15/15] fuse: Increase MAX_WRITE_SIZE with a second buffer
Message-ID: <20250327155911.GO37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-14-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GVg2Z/JA2mxFdA7I"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-14-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--GVg2Z/JA2mxFdA7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:55PM +0100, Hanna Czenczek wrote:
> We probably want to support larger write sizes than just 4k; 64k seems
> nice.  However, we cannot read partial requests from the FUSE FD, we
> always have to read requests in full; so our read buffer must be large
> enough to accommodate potential 64k writes if we want to support that.
>=20
> Always allocating FuseRequest objects with 64k buffers in them seems
> wasteful, though.  But we can get around the issue by splitting the
> buffer into two and using readv(): One part will hold all normal (up to
> 4k) write requests and all other requests, and a second part (the
> "spill-over buffer") will be used only for larger write requests.  Each
> FuseQueue has its own spill-over buffer, and only if we find it used
> when reading a request will we move its ownership into the FuseRequest
> object and allocate a new spill-over buffer for the queue.
>=20
> This way, we get to support "large" write sizes without having to
> allocate big buffers when they aren't used.
>=20
> Also, this even reduces the size of the FuseRequest objects because the
> read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
> the requests we support are not quite so large (except for >4k writes),
> so until now, we basically had to have useless padding in there.
>=20
> With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
> is easily met and we can decrease the size of the buffer portion that is
> right inside of FuseRequest.
>=20
> As for benchmarks, the benefit of this patch can be shown easily by
> writing a 4G image (with qemu-img convert) to a FUSE export:
> - Before this patch: Takes 25.6 s (14.4 s with -t none)
> - After this patch: Takes 4.5 s (5.5 s with -t none)
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 137 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 118 insertions(+), 19 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GVg2Z/JA2mxFdA7I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfldc8ACgkQnKSrs4Gr
c8jFsAf/TAlWHprBIIRNtVAbQmN+sQlUkzRhvXpKeEKq6UN7jRn01wn8912xggwG
ciWpkGT5c51YmZ8IH9uYxNG6q72eN9Pt97yDyKMshjZrK5n3DK8CKSw4IzkkREAo
WrM9vDRlclfttBDTXIo2/zT7SGw/566doqKtD+dsg3oQhSNewTvb30G4DI0bGYUQ
spFpVojhZ+9ajD7/pnQTa6fvF2gc9SnM/Xh8QxmLIvX29EqYHxsXlKecOdSvD0sK
lt/Qi/lMynPclX+fqPYm2xyZnuD/N35o3RAjzDtKY+2Yz+RD5z2Wq+fef6hFLfwk
JPYVh7+UrB5Woc5pv2IWZb+gWHNqaQ==
=+N/h
-----END PGP SIGNATURE-----

--GVg2Z/JA2mxFdA7I--


