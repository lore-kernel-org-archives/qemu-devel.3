Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2985EF3719
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWE9-00077a-Nr; Mon, 09 Mar 2026 04:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzWE6-00077H-4A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzWE3-0008Da-M6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773045869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuLUESNOdNsNunkPSVlVkLV7kNd5br+ydDQLcM9RM1Q=;
 b=gydxuuPJHK2Obvtg3NM8143/69zgzWD8CofO7JzFsGfuQEAM48WCvrB+KME2u7NM2YdFFa
 gM9WKtEbx5q/o8R+2TzX02MiIw7CSNCMmqE4ce3JYENzaOx11WFTTMFa61FQqnYPvALuvv
 C+Z8z7B5XsQt1z063tEfea/DwCqGNh4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-WHgeoaW7OvmSQTjloHa8sQ-1; Mon,
 09 Mar 2026 04:44:28 -0400
X-MC-Unique: WHgeoaW7OvmSQTjloHa8sQ-1
X-Mimecast-MFC-AGG-ID: WHgeoaW7OvmSQTjloHa8sQ_1773045867
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A1B6180035C; Mon,  9 Mar 2026 08:44:26 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 463D81800673; Mon,  9 Mar 2026 08:44:24 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:44:22 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 07/13] net/colo: track IOThread references using
 path-based holder
Message-ID: <20260309084422.GG39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-8-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ex25xIpk97ojswJb"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-8-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Ex25xIpk97ojswJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:24:53PM +0800, Zhang Chen wrote:
> @@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Object *obj)
> =20
>      qemu_bh_delete(s->event_bh);
> =20
> -    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> +    /*
> +     * Use the device's canonical path as the holder ID to track IOThread
> +     * usage and ensure the AioContext remains valid during the device's
> +     * lifecycle.
> +     */
> +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);

Should NULL be path?

>      AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
>      if (s->notify_dev) {
>          AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
>      }
> +    iothread_put_aio_context(s->iothread, path);

--Ex25xIpk97ojswJb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmuiGYACgkQnKSrs4Gr
c8hl2ggAvrXyIwRya6XXs3JdyhymgORPd3/Maqqv5xoKN0CiLEuDv2WkX5AoX4Or
URgOi6CmhwAB8yJzAZX2YggUV5KfdzCxBBGXYLylCIrV17CCgz8a19AMOBLoJTEs
+K0POqANulgwPQztgFxpEnPugPdlSkUZKQgdLTCHzPDPxvVvMy/O/k2Cnsrb7Ksd
zTzEFDZ352cLfP62GZIHCnxdqPyZ8uwZD5LkuKkgjxPRwym6NC8i7IPc5uehjd0n
xsSqAdOHMlEnt9wlFFSnnovTisxGZJGFT6Vh4nv8QmHCJOykiOaSzmg8AgnnXZtU
B8Kgjt1Vp2aVsZn8r4wqh/9IF7bWQQ==
=1K1Q
-----END PGP SIGNATURE-----

--Ex25xIpk97ojswJb--


