Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37B3EA8115
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnns-00042m-6S; Tue, 10 Feb 2026 08:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpnnl-00042P-Og
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:29:14 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpnnj-0000aO-St
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770730126; x=1771334926; i=lukasstraub2@web.de;
 bh=s56nE8uQrfwsdvKYi2GhzzKDHYn6NuO6udF/EEODG8M=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iYEpxKzO3TN37xszYcmQdbaTIvlfPQXsSxmhVQWEsw45bau6eLL/lV50m5OGrqId
 cMLv5LF6m2QiF6wyanGWlWmfOixGeTal51aI+Q6Px3WZR4ujMtoq9a6Rd+76Fwq1u
 ErrhCQPH+D5FM5zHnQ+tbRS63PIPWTnYl0itB4PdBauAcZT8kn884LB5lIeoE44FN
 d+fM0ebjViah7ahlCEXyuI3cTFobynevzwgDppURHT8mC9JvlI2yshDXwSdn5WK2z
 LbKBRX0AcP2KbhTofLqmjqZaYiLDj8B6/hiNhnDCBZZo5Kdpay+GlbRzQlLmgVTfW
 airs2SwEfTtAsv+oiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([141.58.36.84]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xjd-1vgLfB2F2x-00v4AK; Tue, 10
 Feb 2026 14:28:46 +0100
Date: Tue, 10 Feb 2026 14:28:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 05/16] colo: Remove ENABLE_COLO loadvm command functions
Message-ID: <20260210142835.6622e72e@penguin>
In-Reply-To: <aYoHn5DSsia4mxMW@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-5-57508b7389f6@web.de>
 <aYoHn5DSsia4mxMW@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kyKQCj9yfEP=K15_vsYw+lo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:B4lCVZ4y2uISQQSbFqpgWqw6cigLSy280BvQDcOlW7R57ECmqq4
 5bSGnqbtgi5wWaJq2YtbaTyL+itwGWFdaWLpK98U/J8kdUFZFsX9BobUUSnuWjc79kmoJ+N
 CQ6raP+iRBA3PvoMfr274Xr/ypeOffA1r2+34YUaQ7uycRdtNLalrOGAEzre1s8CgVuUgDF
 aGxlC7VMbzmPQY2jbb7Lw==
UI-OutboundReport: notjunk:1;M01:P0:v2ExKXgisMY=;D6S5Z3Dm8KJbM0xZG85cVB/8M0t
 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
 zNH0tADH2jwLN6YoS2ZG
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/kyKQCj9yfEP=K15_vsYw+lo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Feb 2026 11:13:19 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Feb 03, 2026 at 11:15:11AM +0100, Lukas Straub wrote:
> > No need for it anymore now that x-colo capability is required
> > on incoming side.
> >=20
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> IIUC this patch needs to be squashed into the next or it will break COLO..
>=20

No it's fine actually. Now when we receive the MIG_CMD_ENABLE_COLO
command, we just go to the return 0 at the end of
loadvm_process_command().

--Sig_/kyKQCj9yfEP=K15_vsYw+lo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmLMoMACgkQNasLKJxd
slhV1g//XkUXLuPLhweixon/Td8Za4+tT9MjsUprponaKD+N7geYVBajDFc8gX7s
pLj5DiiUDLnXlzjWCSicsaflkFevgY/wrg35mt1KPH/lxp2MFyscuCN6V3m7B5Gd
o2arlI3SM+AJfHF/8JyA186IRwDzktikancCFMRpxm71I6aP5+XrnnGEUq7jaLQq
LEALn6/gd49MjYeWvTMR3fE1T4/mccP9sT1qLUQDO/hxn3Sa/MX0ZCLigXugqCMO
LKKhfrUmWSrq3pS/0UkoEc/Nc/X/+bowo9ZGnqwCCBQe5lJhnCp6xfPx72rpMd0z
XGvDV0op+6zS8Kgq35zwNIja0HCjxYiTWqagWKnJrqt8kyHEXATwaGoYWfINPvF2
pQRNDi2Cp2dVfekMRHqBnP+b9+vGoi4+KA5oeH44Kro1F6seNpTTzEBLTvyBaNMb
BHOKep2ThgZJLDOGvlOt6ZIIzjdaOhmaIQ21SHU9V4vWGCe1SK/SUgO4rdlHqgOW
t8ANzpKMey0/wOdmZ3p0dK/iwvxF/a+hLX+GDZ5wYAEXmsYq7Q9pS4OYX3fgqchr
naISlP+E3/ODttUuBXXcncmbTOVTioJu4GefW9hNNJV4G+2UMKitZ5YncfVbw5Id
1adlaXoeo/bBkry2+HtlnM6bS1f2Id9HGUzJ708NNheFgw/Udhk=
=BQgp
-----END PGP SIGNATURE-----

--Sig_/kyKQCj9yfEP=K15_vsYw+lo--

