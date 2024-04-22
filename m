Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2496AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 19:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryzM9-0005EH-Bh; Mon, 22 Apr 2024 15:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ryzM6-0005Ds-HF
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 15:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ryzM4-0004T5-6b
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 15:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713814170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KL6eP2X+sIoI7QHaVOtGBZRWofoVZ640qKnt4whigto=;
 b=UfO5CoeRZEKGKvyT2d45qEQaxNMECOHgZDOQpb8XbSU5OKklRNgZrlae3msbSIayLbRjXm
 ZBSA0tUBV9KxjfoMX1Q9h8d9uWtrAsr6Wq8BrgVPIc7ugKYP8M8aE2LRY2XLM6aChgMohc
 t9C/prUmjArXvETz3fdr/OyUcuRP9SQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-jLsBAdDAP6C6eYL1SKIbnA-1; Mon,
 22 Apr 2024 15:29:26 -0400
X-MC-Unique: jLsBAdDAP6C6eYL1SKIbnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2AEF29ABA04;
 Mon, 22 Apr 2024 19:29:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 194A51C060D0;
 Mon, 22 Apr 2024 19:29:24 +0000 (UTC)
Date: Mon, 22 Apr 2024 15:29:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, groug@kaod.org
Subject: Re: [PATCH for-9.1] util/log: add cleanup function
Message-ID: <20240422192923.GA118554@fedora>
References: <20240417183333.39256-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A7s01TqLEmzCvQ5V"
Content-Disposition: inline
In-Reply-To: <20240417183333.39256-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--A7s01TqLEmzCvQ5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 09:33:33PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We leak global_filename, and do not close global_file. Let's fix that.

What is the goal?

Leaking global_filename does not cause unbounded memory consumption. I
guess the goal in freeing global_filename is to keep leak checker
reports tidy?

Closing global_file doesn't improve anything AFAICT. It might cause
problems if another component still wants to log something from a
destructor function. I'm not sure if the order of destructors is
defined.

What about qemu_mutex_destroy(&global_mutex) to balance startup()?

What about debug_regions?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>=20
> Interesting: seems, nobody is maintainer of util/log.c
>=20
>  util/log.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/util/log.c b/util/log.c
> index d36c98da0b..30de209210 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -85,6 +85,15 @@ static void qemu_log_thread_cleanup(Notifier *n, void =
*unused)
>      }
>  }
> =20
> +static void __attribute__((__destructor__)) cleanup(void)
> +{
> +    g_free(global_filename);
> +    if (global_file && global_file !=3D stderr) {
> +        fclose(global_file);
> +        global_file =3D NULL;
> +    }
> +}
> +
>  /* Lock/unlock output. */
> =20
>  static FILE *qemu_log_trylock_with_err(Error **errp)
> --=20
> 2.34.1
>=20

--A7s01TqLEmzCvQ5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYmupIACgkQnKSrs4Gr
c8jCTggAxhEgjtcYN4PH1KpJ0hBVSgEZwEjlc1c1MxmUGMMadYzMUGvjEQ5aHJ58
XOngBvgAMDvZfcPFQpxkiwf/I24nCRfGLK510LVyktCFIngIoQwiRc0sANP9SGay
3m9spZ2JhVFl8x2Wwi86p59nQTIC+Mlpyzv86x1l+kshNViV3+IJEnSFyDE0YllQ
RnEPWQS8FxlwoneuDRI5wluCPsiNSHhDHRqKrh59qmnfmfK+5v0lpoVnsMdXA0lk
ll+Jl15edwfub72liItJ5oyxCUayt2KUpQLDQs/WNE2cDtpvVUocMnc6XyuTZTmz
mIGKgbMe1GHfBntodil4noX7CQCcRw==
=dxDA
-----END PGP SIGNATURE-----

--A7s01TqLEmzCvQ5V--


