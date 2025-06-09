Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D502C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfm9-0008WG-C8; Mon, 09 Jun 2025 12:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOfm5-0008U9-0m
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOfm3-0005MA-9B
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749488101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ATxaO5+xU2dRDoP7B/bvMinOljEHHEOrml3hyQPX2RE=;
 b=RSMeLr+l5eHUfLY4wO6yFwLAFsb5imLp0lLtMxsPv4yBQ5UlqApMEddHAwV1Ww+UuWXJhg
 zG0x2juooHt9M0wbkYYA2De/Zz9PVBS7ReM10Ihdr3QBgDFSnCKxoWRTA64fEOTKknaxN5
 6kMJB1tPnqGfrLfNcJaMf8CPR4WMlpg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-JzCG5OD6NH2xxCuAvDX6JA-1; Mon,
 09 Jun 2025 12:54:59 -0400
X-MC-Unique: JzCG5OD6NH2xxCuAvDX6JA-1
X-Mimecast-MFC-AGG-ID: JzCG5OD6NH2xxCuAvDX6JA_1749488098
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1F97195608B; Mon,  9 Jun 2025 16:54:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE66C1800284; Mon,  9 Jun 2025 16:54:57 +0000 (UTC)
Date: Mon, 9 Jun 2025 12:54:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 13/21] fuse: Manually process requests (without libfuse)
Message-ID: <20250609165456.GG29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-14-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J+NMVuFT3HruG575"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-14-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--J+NMVuFT3HruG575
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:28:05PM +0200, Hanna Czenczek wrote:
> Manually read requests from the /dev/fuse FD and process them, without
> using libfuse.  This allows us to safely add parallel request processing
> in coroutines later, without having to worry about libfuse internals.
> (Technically, we already have exactly that problem with
> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>=20
> We will continue to use libfuse for mounting the filesystem; fusermount3
> is a effectively a helper program of libfuse, so it should know best how
> to interact with it.  (Doing it manually without libfuse, while doable,
> is a bit of a pain, and it is not clear to me how stable the "protocol"
> actually is.)
>=20
> Take this opportunity of quite a major rewrite to update the Copyright
> line with corrected information that has surfaced in the meantime.
>=20
> Here are some benchmarks from before this patch (4k, iodepth=3D16, libaio;
> except 'sync', which are iodepth=3D1 and pvsync2):
>=20
> file:
>   read:
>     seq aio:   78.6k =B11.3k IOPS
>     rand aio:  39.3k =B12.9k
>     seq sync:  32.5k =B10.7k
>     rand sync:  9.9k =B10.1k
>   write:
>     seq aio:   61.9k =B10.5k
>     rand aio:  61.2k =B10.6k
>     seq sync:  27.9k =B10.2k
>     rand sync: 27.6k =B10.4k
> null:
>   read:
>     seq aio:   214.0k =B15.9k
>     rand aio:  212.7k =B14.5k
>     seq sync:   90.3k =B16.5k
>     rand sync:  89.7k =B15.1k
>   write:
>     seq aio:   203.9k =B11.5k
>     rand aio:  201.4k =B13.6k
>     seq sync:   86.1k =B16.2k
>     rand sync:  84.9k =B15.3k
>=20
> And with this patch applied:
>=20
> file:
>   read:
>     seq aio:   76.6k =B11.8k (- 3 %)
>     rand aio:  26.7k =B10.4k (-32 %)
>     seq sync:  47.7k =B11.2k (+47 %)
>     rand sync: 10.1k =B10.2k (+ 2 %)
>   write:
>     seq aio:   58.1k =B10.5k (- 6 %)
>     rand aio:  58.1k =B10.5k (- 5 %)
>     seq sync:  36.3k =B10.3k (+30 %)
>     rand sync: 36.1k =B10.4k (+31 %)
> null:
>   read:
>     seq aio:   268.4k =B13.4k (+25 %)
>     rand aio:  265.3k =B12.1k (+25 %)
>     seq sync:  134.3k =B12.7k (+49 %)
>     rand sync: 132.4k =B11.4k (+48 %)
>   write:
>     seq aio:   275.3k =B11.7k (+35 %)
>     rand aio:  272.3k =B11.9k (+35 %)
>     seq sync:  130.7k =B11.6k (+52 %)
>     rand sync: 127.4k =B12.4k (+50 %)
>=20
> So clearly the AIO file results are actually not good, and random reads
> are indeed quite terrible.  On the other hand, we can see from the sync
> and null results that request handling should in theory be quicker.  How
> does this fit together?
>=20
> I believe the bad AIO results are an artifact of the accidental parallel
> request processing we have due to nested polling: Depending on how the
> actual request processing is structured and how long request processing
> takes, more or less requests will be submitted in parallel.  So because
> of the restructuring, I think this patch accidentally changes how many
> requests end up being submitted in parallel, which decreases
> performance.
>=20
> (I have seen something like this before: In RSD, without having
> implemented a polling mode, the debug build tended to have better
> performance than the more optimized release build, because the debug
> build, taking longer to submit requests, ended up processing more
> requests in parallel.)
>=20
> In any case, once we use coroutines throughout the code, performance
> will improve again across the board.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 754 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 535 insertions(+), 219 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--J+NMVuFT3HruG575
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhHEeAACgkQnKSrs4Gr
c8jQBAf+Kdvf+55S36vk6EdeBl9gUW8ol6CdkVfgX6LlgBrMMPzQ789ESWidzFHv
5Hq/edbUoRxevatO8WhnSXlZgij0YIkk8pTYZpEeVE2jmAQl+G8SNSu3BJK8kAm+
ydzczynbewV5z/Z7sb+Y1r3L7ENThGv/SYsbsoIut6FjdbuUCqSqHUw5gi5mH1cK
4X2HnDh6e2tQOzf9g9lJhWzs0IoX2jKingOJVS/x4m+gKFoDz3r9DFEiAI5pU0Am
ZlqnPyyI3cTpRni2b8Z1RVzu8oYvWIUYSXL/O0tHmYcaXi0YymvV0P+E5XIpEENE
CVflNCGd3EDXp3DEmyS+geUxa35v5w==
=Jr+K
-----END PGP SIGNATURE-----

--J+NMVuFT3HruG575--


