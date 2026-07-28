Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B3C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeKv-0005CA-AJ; Tue, 28 Jul 2026 05:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woeKt-0005Ao-Ic; Tue, 28 Jul 2026 05:42:55 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1woeKs-0007hG-89; Tue, 28 Jul 2026 05:42:55 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7DBE314000F2;
 Tue, 28 Jul 2026 05:42:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 28 Jul 2026 05:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785231770; x=
 1785318170; bh=U6g6qtE8GIN58YV3JQwYnVYZ4fHIbT+TKRxggWh8KBw=; b=X
 TT38Jl5PCWXs3GYo69S1m2LkU4qZYANanOl+hKZ2k5jfO/rXMr+YL4b9XuHFkuA/
 3lWAi7nOF9AVNE8TYP/IeDRBH5e8xRwzUAfaorI2QMys1MxaC3iybVHBDkBaoQ27
 0ZTpObvsqIsXfsDCAlaO/8Bv3FSpvlpI3TdRDZGeM9KzZ3L3wVXbAw7Pog8t26gF
 ZVR9lcZUuAQ95VBleaMP/WcJLZPDe6VMpT0jFZA044uyvJZ7A8GrW4xOunblFEk5
 D15ckuEoDDDrhe28C9+p6OH7NXS5vUwFy4RXlgc9aGosGFmC4Lj1r6UIzuWPk69o
 +0C2nWn4+3/z61xJxk9sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785231770; x=1785318170; bh=U6g6qtE8GIN58YV3JQwYnVYZ4fHIbT+TKRx
 ggWh8KBw=; b=QOY+d5zdnEbIG1QacL6x8szxlluFsjJ+GqLNO5Vz8LCtu3mvCwf
 QyXN2lIBKVcGLYUvmuzYhyMlIxRA+h2iLNcvDaCRFHSS4CyxCnEfvaD9q7oUMAAo
 owwx8wL6JjrvYmm0YWRhNRr52oc6/7XnXdsMukz/FUkOVTFdqzC7wXUoAg59TEOS
 yls10UEOChUTwMRaCXEvy6jxrU6bi3NBwzsVbtx1hFfQwMJng5eqeT1Ruk3cDWkH
 IbJf/0F9aIrYp1DDTgYqCCEO/J1/XpCuBM6F5aR17j5npOh+aXZrxuCL9cU5WCdq
 m+ggEfuqQpHBRwylHg7V/7vmELOcRi4YjcQ==
X-ME-Sender: <xms:mnloah-IRxZPvWoM3tarccy3PCS1lV54ghe13ADsPOA762zRtNwSnA>
 <xme:mnloaoSvCFIh12YIx9p2dVsyBzU8D5alC5LL3XO_sV_e_Uh1dFKFemziCaXdInx9F
 Yc6oAnJB8NSD4tbAso-7IIXJcrB0Yxss7jklC2oieNsgghd41S83NY>
X-ME-Received: <xmr:mnloaiooMYiMhpBE9QFTE8AV6DW35dht1wfzyyi3otHOShRysMpy9oR3YgIm9w>
X-ME-Proxy-Cause: dmFkZTEuBL7FQdztr/r5uUGPMrihDvt4AS5u/IOGItM+SoVjTDKfrcQDcvTKCDjBQG5ryb
 brjL2Y8WXYXUq/WgEkmBrgpnrwDqaahrzy4VuYvBWlLO3x08nfEEv8DII+0yG3ST1E+a5M
 EUW5w8qah4ULGGqMuZmgYHNEn4guI4Fy1aMMnS8hTtukCOry92xYRaQBCu7kSaeCefhGTY
 YVglfwTBxyxoPSUo2kJnHjmxgGBTosdL/UOuyiQyDU6KcD2AafpTchKY/D9SYv/i1RE8GC
 5au5Y6bUcjPKmWlVYjaCuzWsmYw9SfRVihOZsYu4a886DqPs6bCA0KI91KndG35sRX0fB5
 sir8ew1aMbBScnJ8Zvn3thal3ZafkLTqalWBmR673pk6ShhSGs7lnaE6Rd69lUDD72DTiM
 lgdTOdo1fkFiTMs6l+2TIMu18M2agxZQOvW0wRL/HS+qP+lTkpjX6cWNhPGMWrSwWe8Y21
 mZ7cOYVMpBQybS89e2q81PwMuw3rsYpNv0F7O0indRBbcTxT0NeQVqYxJA59TAjCCGxGoK
 H0AN/8r1vTMTqmopM72IKiC9vlaA21HMn9BuOxU7OOeuKJfpnAfcpDA5q+0mhiPb2e7P0P
 yaloabmdCPoHhdA4nfkqrGW7Bqe1v12kFPgH8j9rG+8Kw8k6zLx/TJc50YZA
X-ME-Proxy: <xmx:mnloalmLSKcmHaoHVhXMXjnwPZnHO72JX11NZ_ECkM0UftAtRi0sUw>
 <xmx:mnloard6oYyiVQ7FUYIf7wSWzW3vNK7U98hfLXq8Np9rYVFQgr03Sw>
 <xmx:mnloahpgV9nVF7DazgGI0HzEFb7W5laPszYpoLu3jm-8dmNSYfh_mg>
 <xmx:mnloalNDivc1MkC-YYQh3SuWC2QRw73FSYUy4IW1cs51Ww5uLKh6HA>
 <xmx:mnloasNz6Ih1u3RyGzM-IfjztFkeLefYEtMq0Jj-T8HiyOlknFXNcj5e>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 05:42:49 -0400 (EDT)
Date: Tue, 28 Jul 2026 11:42:46 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/nvme: fix unintentional integer overflow in shift
Message-ID: <amh5lvDUQ-cOOgNb@AALNPWKJENSEN.aal.scsc.local>
References: <20260728-fix-shift-v1-1-bdb98c205233@samsung.com>
 <7428df68-ffb9-429b-b0ab-8c009c0c42ad@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mekm0Dq+Zh2R6atJ"
Content-Disposition: inline
In-Reply-To: <7428df68-ffb9-429b-b0ab-8c009c0c42ad@oss.qualcomm.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Mekm0Dq+Zh2R6atJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 28 11:34, Philippe Mathieu-Daud=C3=A9 wrote:
> On 28/7/26 11:26, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Fix potentially overflowing shift operation.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Resolves: Coverity CID 1663674
> > Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index a67e1598891c..40f22fdc40bd 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -6622,7 +6622,7 @@ static uint16_t nvme_set_feature_fdp_events(NvmeC=
trl *n, NvmeNamespace *ns,
> >           if (!shift && event_type) {
> >               continue;
> >           }
> > -        event_mask |=3D (1 << nvme_fdp_evf_shifts[events[i]]);
> > +        event_mask |=3D (1ULL << nvme_fdp_evf_shifts[events[i]]);
>=20
> Alternatively:
>=20
>   event_mask =3D deposit64(event_mask, nvme_fdp_evf_shifts[events[i]], 1);
>=20

Better! Thanks!

> >       }
> >       if (enable) {
> >=20
> > ---
> > base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> > change-id: 20260728-fix-shift-525e53c1df6f
> >=20
> > Best regards,
>=20
>=20

--Mekm0Dq+Zh2R6atJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpoeZYACgkQTeGvMW1P
Demspwf+MMVXN6dlQS+1AgqbhwYAEU0Hu0cSXASc5yW+dfBspITu5pni+ZlhiohT
+vSmh2yCHtCnMn2+F7K/GDqOsT3oFtrsMWXhzJCfrd8R3RBtVRHds8lIeAJ2Ml97
pEPbuD7w2Ea8o93Yk1WTcexaZ3sUVQeDaT2nejz+VJemtEjkEiMQmMfNS8zMv2Rn
mVCcwnqb1f2kTWRNDPexguzE5D6EGWUaiVpxG6vUJumNoUVD03Es/cOh8rlr98qS
4PqfHHVdWBwuH3MD76lOvreByAlmxjW8F0T9HVc5r20QBJLeFaCpattFRJF694PE
2lzbASIqAk5u8escXHA+h1tE6TG5Og==
=elDZ
-----END PGP SIGNATURE-----

--Mekm0Dq+Zh2R6atJ--

