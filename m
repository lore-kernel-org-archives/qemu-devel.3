Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D64C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5VjY-0006FU-KS; Thu, 17 Apr 2025 16:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5VjV-0006Ec-Or
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5VjT-0000or-SQ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744921270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lAwkNORwVmX4z8faEunmUXkDrtbZ0Jwa8BCzS8LTi0=;
 b=WoUtCx+dUCXQPs/5QbVSlDX0Uqpp4pxLB3/h/YXrV59NyBq7PNRLsnmErX3HQXxKe3uDwE
 Jsqen+TvUiXBlfGaj+YPUUFDkYx1VvF0Fk4yETnRZjpVpCTOTwp9ZieGRPnNYOXku+EZB0
 j0+8/1ut4oA/3gFrF+kDTKHUi0VjRAs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-5OnBNVlePVWrLbLdruz2-w-1; Thu,
 17 Apr 2025 16:21:05 -0400
X-MC-Unique: 5OnBNVlePVWrLbLdruz2-w-1
X-Mimecast-MFC-AGG-ID: 5OnBNVlePVWrLbLdruz2-w_1744921264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEACD1800992; Thu, 17 Apr 2025 20:21:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 003E819560A3; Thu, 17 Apr 2025 20:21:01 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:21:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 03/11] block: Let bdrv_co_is_zero_fast consolidate
 adjacent extents
Message-ID: <20250417202100.GB85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-16-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HCvOpkVotiBcEC3/"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-16-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--HCvOpkVotiBcEC3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:08PM -0500, Eric Blake wrote:
> Some BDS drivers have a cap on how much block status they can supply
> in one query (for example, NBD talking to an older server cannot
> inspect more than 4G per query; and qcow2 tends to cap its answers
> rather than cross a cluster boundary of an L1 table).  Although the
> existing callers of bdrv_co_is_zero_fast are not passing in that large
> of a 'bytes' parameter, an upcoming caller wants to query the entire
> image at once, and will thus benefit from being able to treat adjacent
> zero regions in a coalesced manner, rather than claiming the region is
> non-zero merely because pnum was truncated and didn't match the
> incoming bytes.
>=20
> While refactoring this into a loop, note that there is no need to
> assign pnum prior to calling bdrv_co_common_block_status_above() (it
> is guaranteed to be assigned deeper in the callstack).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HCvOpkVotiBcEC3/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBYqwACgkQnKSrs4Gr
c8gzAggAhqhRW8TfRZi5YbUY5EU1aOIVrAy8zf+jTHHVVdwLWUHL0Eimm5E56vRw
hJIU5RqilX5sLqQFd+dAxBebCZX/oGjvbE50oiri0JlfFzSjr8LBCJ/rz3y9vLWL
6d53Iwyq+/rbxG7QxVpU/HGibSMeBbfjE1/+HjdnXsr141MXAhctJFKsOLGSFudz
VXeyD0LOm5gbv1WQM9GbDNB5ZuAvZN5dq8gnCBfqsYPcqvo2Pg5ITlXhdRLaw2Fa
5yp9rQf3iJzgKexnuz5mhJWQu9LRYLSAOZ9RDDfnuI5nLHDceqgElpEHfTtWbCJm
56ETBybieEKJG53zyoPOtkmQKgYoUQ==
=RZEr
-----END PGP SIGNATURE-----

--HCvOpkVotiBcEC3/--


