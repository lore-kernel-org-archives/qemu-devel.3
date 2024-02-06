Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0610C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 18:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQYH-0003MC-Je; Tue, 06 Feb 2024 13:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQYE-0003Lq-Kx
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 13:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQYC-0006SS-VH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 13:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707245527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C++Wf7sb1iT7uBC/Q12DMM0XIC/4zoy2UHhiTzjEOxo=;
 b=SagKhNFaatbR0J4iMOXuKIDXdzur4UtqGEPp68jIviuNAG9dMdhya4+M3doVXncM+UVhNO
 Wytytj+LsfLgoQsZqtJyizpnThVtIuZj1awNM7sdbJn5AMQ2U4BDpcFesBpFnsZIIHISqH
 GG7GQrCA4Ud0uPuTUfO83Lw4xiqGWGA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-ZB9Mkv91NjCQ9H2VzX07Pw-1; Tue,
 06 Feb 2024 13:52:04 -0500
X-MC-Unique: ZB9Mkv91NjCQ9H2VzX07Pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A82C32812FEC;
 Tue,  6 Feb 2024 18:52:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13E23C0FDCB;
 Tue,  6 Feb 2024 18:52:03 +0000 (UTC)
Date: Tue, 6 Feb 2024 13:52:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] virtio-blk: do not use C99 mixed declarations
Message-ID: <20240206185202.GF66397@fedora>
References: <20240206140410.65650-1-stefanha@redhat.com>
 <20240206105722-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cGDEYIWGnEycANY9"
Content-Disposition: inline
In-Reply-To: <20240206105722-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--cGDEYIWGnEycANY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 10:57:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 06, 2024 at 09:04:09AM -0500, Stefan Hajnoczi wrote:
> > QEMU's coding style generally forbids C99 mixed declarations.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> or maybe it's time we moved on?

I sent a patch to allow C99 mixed declarations but a number of people
spoke out against changing the coding style so it didn't seem like a
good thing to pursue:
https://lore.kernel.org/qemu-devel/20240205171819.474283-1-stefanha@redhat.=
com/

Instead, I just want to make virtio-blk consistent with the coding
style...especially because I introduced one of the recent violations
:-).

Stefan

--cGDEYIWGnEycANY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCf9IACgkQnKSrs4Gr
c8hHgggAnqwPIMZdIRHkm/qDYrH3HfilNL6CBsxj1EpRZ/KuoMaZYOD6Qnk3ws7D
wvrS6jW/8+VT/GYkx7N2+bFZjkmcMWHtsIC8tJMPsayZP+VTB3ArH/mZTcfNhkjx
Xxqifo4gf6lWNzKzQnM3S9eX62F0l236KYW4tJZ6+oJDDbpfwFcm7peZbKKOUg2g
3oA5w/vlO3m5fXA0jmAXoDhhQn010uNI/d+YVCfs99DX4ecUiLbyz4llrMA0EJz5
WqOHvQAmqgixRl7CbtADPe8AE1oxdZlc4bmQt4p38iSLRWef1wfBwSfyulbQuV8d
5Y+k7Yms1aDabrkUvb7ScYwgjjmSSQ==
=z481
-----END PGP SIGNATURE-----

--cGDEYIWGnEycANY9--


