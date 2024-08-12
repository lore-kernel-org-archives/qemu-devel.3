Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0109EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZar-0002dU-4h; Mon, 12 Aug 2024 14:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdZaq-0002ce-5f
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sdZao-0004XW-8f
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723486589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3zppXz/YxiHeDfWoy1gdOLm+Fug2ZqqrS1ecTblpv0=;
 b=Z3vq9EX4SQxfZCyJkCO7TMrtwKGursZb0YaJGh4T27ptaKnRqdubd5XDX/4Y1p98UBUYBY
 V4KrncQoqowgIt1zuFjO50CFe89uV7KbrAopXlrNnaz+qxxuxYoZT8Je9jCnV3/BaNYGns
 l5JOToKnnT2MJ8JexztRgrl92iDGRDQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-OB49jMOHN9eITVBTRvCEdg-1; Mon,
 12 Aug 2024 14:15:38 -0400
X-MC-Unique: OB49jMOHN9eITVBTRvCEdg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8333319253BC; Mon, 12 Aug 2024 18:15:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F2DE1955F6B; Mon, 12 Aug 2024 18:15:35 +0000 (UTC)
Date: Mon, 12 Aug 2024 14:15:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH v2 0/2] qdev-monitor: avoid QemuOpts in QMP device_add
Message-ID: <20240812181534.GC69160@fedora.redhat.com>
References: <20240801140552.1021693-1-stefanha@redhat.com>
 <87wmkz5oqk.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5xhfUws/biux4FS0"
Content-Disposition: inline
In-Reply-To: <87wmkz5oqk.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--5xhfUws/biux4FS0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 10:10:43AM +0200, Markus Armbruster wrote:
> Can we additionally cut out the QemuOpts middleman in
> usbback_portid_add()?
>=20
>     qdict =3D qdict_new();
>     qdict_put_str(qdict, "driver", "usb-host");
>     tmp =3D g_strdup_printf("%s.0", usbif->xendev.qdev.id);
>     qdict_put_str(qdict, "bus", tmp);
>     g_free(tmp);
>     tmp =3D g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
>     qdict_put_str(qdict, "id", tmp);
>     g_free(tmp);
>     qdict_put_int(qdict, "port", port);
>     qdict_put_int(qdict, "hostbus", atoi(busid));
>     qdict_put_str(qdict, "hostport", portname);
>     opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
>                                 &error_abort);
>     usbif->ports[port - 1].dev =3D USB_DEVICE(qdev_device_add(opts, &loca=
l_err));
>=20
> Trying this is up to you!

Paul or Anthony: Do you know how to run usbback_portid_add() for
testing? I would like to make sure that suggested the code change works
and don't have experience running the Xen code in QEMU.

Thanks,
Stefan

--5xhfUws/biux4FS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAma6UUYACgkQnKSrs4Gr
c8iHCAf7Bx19FENvDXMGkzw3ZRSiIO9coXU8mgc+n9hGOR5wEJA7phdrT3CeSQq8
9YO4ih9F/wmmFO7+sIWc/vq/T930y0EKE2rzvoAmd3s7U9yLAJan+8+HXxZ+qMuL
8+anm+uYnOaw4m/Fd4tGd8mXTcyC+X4lZBQzMsiwVlmQn01PNc31PZ7mkRUp2RB8
cJRy/K8Pi98lcTu67+ax6UUpQfTvIzIDjKdF3k1PXqCqYDGLjnLvsJlXuzEUhgYs
Q8HaGY230cP5Gv+S+3Ft81W7ZwQF6mfoo/9ZPpkZMScZW5fJcm/UoH/gHVZ8eetE
Hd738S7RLuyNaZGCOy6NHdrs6ce87w==
=kTGQ
-----END PGP SIGNATURE-----

--5xhfUws/biux4FS0--


