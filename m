Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D5CCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWV8c-0003PC-86; Mon, 08 Jun 2026 04:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wWV8Z-0003OT-ST; Mon, 08 Jun 2026 04:15:11 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wWV8Y-0006nO-3q; Mon, 08 Jun 2026 04:15:11 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 921EBEC01FF;
 Mon,  8 Jun 2026 04:15:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 08 Jun 2026 04:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780906506; x=
 1780992906; bh=WuTBLcbM0YrFq69apAbkxDdd5xJiYnMusghCpIsaOwA=; b=X
 xn0ILOtgeNX7pSVSg6ZG55jRY80qov4B0IEzsmZaPpUyz1Ua10QPcW4HI/a4Qcrh
 x+DNialFYSqTiHlMnkFtY0mr1sAjBrfHMzgErPDmK2bHL2zevOh3TyPjS6mQ/cxR
 iZvqm3K+qAhiYFtn4jBZNwKb6Qo36N4+PJJUrMWouddxTKNJtX0xzkv/f9t1kWhB
 dyMMLS9xRpLQA31QZgs2TSpUxRJWO1uvcLkmByeeS66+eDuZnO6qXygnbiDwMQDX
 Jqhm576gEbmBdscvlpQRdo2paUgLn6mv2e/2xgxWK1ogCMfpqJ2i7OJyMxYl+YtO
 0e5dAyazUZR58ipNX71UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1780906506; x=1780992906; bh=WuTBLcbM0YrFq69apAbkxDdd5xJiYnMusgh
 CpIsaOwA=; b=dIP7WNHbQWzf20puEkdNVupx/nMdCfR/hWv0m4wYlX1Qw/TnwjN
 70vjGk/gE/aai2uFsjfzD3YsLadeTxgk+eXJXpSIjrKGv3xHffpq/ZDgpTLratAb
 TwY4eAf9VBgrry5etXHO1xxFkWD7/vZaiL636oIeLysA9j3vMlhfB7y42fBDDNzW
 rlx+EnT/2cO4MWAv1QwJ1Kkj0EAStVrwS4xMQ16Qpye86eUrVWA2ZXRxpBBlg46T
 1l5Jq/WIEOJA8GYsWNhyutVpD8EC61cQ5pKMtVbuyjlHxuFl603Dhul4m18JfHPg
 ZPxWoen4ejbDajjin7IUoFrltr03MUuxRhA==
X-ME-Sender: <xms:CXomajvJlabs32RN0VCiyLkh1A9cjlKffisp-75A-f8kGWrBhIGKAg>
 <xme:CXomagWD2iNYAvtjGYM5fTwtxfl18I1MAKnf8y5QixUKBlseZEqEGZPxpzNreaW29
 j6x7C5VmHqXAd4YbD9x7PBmobU9TU7wH6Bn25jou1kt33gD7XFfeYw>
X-ME-Received: <xmr:CXomajxiJ4SuNUeGUfg15JPS7wS-afbZy5vvBIv9oxyAfklU5G0kMXA7sJDiaw>
X-ME-Proxy-Cause: dmFkZTFmMPv2A1pj1T351020dJ6qrMbKe3lK3Naj3bt9UbcJs+083ESHranRVLkn+pbdgL
 e7zafStYDFM7VoaoqNVdipAAG6X5EGfMrIfY+OtGMkvn31x7CxWNB5dJ0dxTh6yPvifvSE
 r8Oo6G7s1VIsYaoHsbQzCFws5+IuXULsETxhW/PrQWLTKVgdCHUuwLKpPY9zQ/4KPOIO3G
 4krpokMP70Rtykm/1x4clLGVHzFCJhX8uh9GpAIzYh3PF2EqleX+q9u0lI0h/u1zH1YVkr
 MLYaX52EH1huOsEF6HzpOIG4Faw5v+epbcQPxN8xdR46ESudrvRP9O7HNQdR6y4/FTikCV
 gPbQwcaMCDRitLdAD7eiEgJzqFoo9R696TdopZ5+3K3yamUYpaBnEIqae/wHThgfRY+VPy
 BV8N2PmN4K2lA0h3uayz5PjmIT/uNipc14YcpOzvUly7jffOa9Nn6MN5WzEUHXrY2jxbLE
 XL/7Bhk5jkyD+IERLmLHEKblJgeQRhvcL6kMp+96Ykew82wtUl5QoVyB6I2WzUbJlfNqdv
 k9BzrsECA3Xa9+PoEclYfG0S3yHmcJ0SmVesU4OHozIXvLf/U/0uhK1tbsV7ogYlIo63Lr
 Kc0igOxIPcig6NOTizEBQUT/ZgsnvKaLVjhAi4vz7Bvt2jtgaEnNQqV5yJJw
X-ME-Proxy: <xmx:CXomanEmiPv9YTe1NYTtp0ooTOb7xDeQjE2R7jyqkVyzc7TXfue6RQ>
 <xmx:CXomaosd_6GQwd9CRIBSi2IewTSU9Nn1mSXyRcQw6Znlt7Q_Jp4Z0g>
 <xmx:CXomanCz_CblKfQZb5Wqcg9EH9zC-N2iDOclS4b5GTMLH7kGgCIifA>
 <xmx:CXomajCdmXQz11a1BXAR-hRGSfTxKG1Qo27G10id0-UdzXBSJIzbMg>
 <xmx:Cnomaq1CppNAkDy20llxUEHbNPDEliW5tR0Ofdf9c-ga-WCZ5WpnLP_z>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 04:15:05 -0400 (EDT)
Date: Mon, 8 Jun 2026 10:15:04 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 2/3] hw/nvme: drop DMA-path IOV_MAX guard
Message-ID: <aiZ6CKSFLjf4SD3I@AALNPWKJENSEN.aal.scsc.local>
References: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
 <20260529-align-nvme-mdts-with-linux-v1-2-221d4d21ab43@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IGhDx0WYYf7YfG6t"
Content-Disposition: inline
In-Reply-To: <20260529-align-nvme-mdts-with-linux-v1-2-221d4d21ab43@samsung.com>
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


--IGhDx0WYYf7YfG6t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 29 14:36, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
>=20
> dma_blk_cb() now chunks at IOV_MAX, so the per-mapping cap on sg->qsg
> in nvme_map_addr() is redundant. Drop it.
>=20
> Suggested-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  hw/nvme/ctrl.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index be6c7028cb5..00995d9808f 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -866,10 +866,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *s=
g, hwaddr addr, size_t len)
>          return NVME_INVALID_USE_OF_CMB | NVME_DNR;
>      }
> =20
> -    if (sg->qsg.nsg + 1 > IOV_MAX) {
> -        goto max_mappings_exceeded;
> -    }
> -
>      qemu_sglist_add(&sg->qsg, addr, len);
> =20
>      return NVME_SUCCESS;
>=20
> --=20
> 2.53.0
>=20
>=20

I posted something similar a while back where I also removed the
restriction for CMB/PMR. However, I think that was wrong - for CMB/PMR
we take the blk_ path directly, which will not split on its own.

However, that means MDTS can't go that high if we have CMB/PMR enabled,
right?


Thanks,
Klaus

--IGhDx0WYYf7YfG6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmomegUACgkQTeGvMW1P
DenJHQgAjwplkqHaZZxJR3sBtsHo29BGooBBtu5iiKSAB2M1o5qtD6JHNGjqtNsw
ab2P+s9hGKNzU2NTD+KjPUzMUXV5Gleimx/6kHlqEzag5oleZctL/Xroj+0WGxgv
egJkgy7+IjlJW3FswjWH1n2EHn3h0rl8yMJmobcLCwN4fJlrsQBlTMjVX5dgEbls
ahN86vrBJeDwA7/njVr0BePNEL0Dbzb4Rdwbko/QoCUWPsb0qy5+yZ+sXYeR0gQz
EZSjoELEZ+Iph6u5D6syeBYWBb1Rle6KGr6nRJ1J2zaYjF4Py1u3N53YXmnaHFko
lgujS8Rt/eM2oq8guWtBhzxjuTxP5w==
=lv3n
-----END PGP SIGNATURE-----

--IGhDx0WYYf7YfG6t--

