Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC61AC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfsO-00029w-RF; Tue, 11 Aug 2026 02:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wtfsL-00029P-KH; Tue, 11 Aug 2026 02:22:13 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wtfsJ-0008Dz-Lv; Tue, 11 Aug 2026 02:22:13 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 1DB6FEC01C4;
 Tue, 11 Aug 2026 02:22:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 02:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786429328; x=
 1786515728; bh=UWnzEtC7KiICr1FXAgDx/v/994ixpyykvcCcJpM1768=; b=g
 7qOMO1oez0tJEmjopuTYMOCRQncW9WRLQg0jtMMFL97Cw2JFUrD2HvHRtDHclVfq
 kUVyQSy0IFT3+rF0Jt9CDARJNcscZvb6CKfalaNQlW5vKgayhViWFFxGJQXRPkXT
 MfQZwOP1UYjwVJ9uosvIoeWcT6tJlFiTUt+1tC+UBEfn+tjubiPZ6AaEEy5riCJV
 NpDwShsoMZh8ycoawilEhoElQ8mRgo9voE5t31ZekRTEVeiPI62v+A5F7i7crHsA
 6qeR7/h9k4TuRAIgXX3aKrzyDA4VJUKvIQU5Zvste52fYU3PQlaT6qk6uqV8ZL2A
 tX2m63GAD+qdyGGaZ4oWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786429328; x=1786515728; bh=UWnzEtC7KiICr1FXAgDx/v/994ixpyykvcC
 cJpM1768=; b=JIovGXASGgruJWK6ydUuBReA/v/wHDuI9lNn3gyuaoxoibfTsev
 tm7dNUrjBvYEXXO2hvI54JPwsonbNgDtaoDJjRcbw7lMJDu8AFaUmHQ7D6DEvgNU
 ECmnaFpN/G2U0n/uN9OWkcfvlHhN/4596CeZ6RL8RRGMor0VzHZH8PA59XNQCJD2
 8mxHbAnXja83YXB1nCrNzY4iYg5TiJpfh0iIGLM1W0nqSCAnCMetOxURbD57j8z1
 RgLsz7sjEXh95LNylRBbW2MGA1D1vNOxMd5WbgNIGuLeD2L5x1akGtefUVs83zWj
 CbNpfgoZ+6pu+l05CIqDf+fINS9VJlN7MCw==
X-ME-Sender: <xms:j796aqJ7b-teEiy7ARzbUTKLYk--9GU36rSFY_1XKJamhDphTTO6wQ>
 <xme:j796atFOE2wKMR2DAmC_rKG-O1jAYsfSgeC97npSb8Yc_2-GJs8aj6qmH44NvduKk
 eWYgPhgIcA8X2rDi3dfnVcKjYi3D7eJFK9VhtTF-BSU-1z3OREKcQ>
X-ME-Received: <xmr:j796apvLvFEKZsFMU3FuI_W5kuK-hABzjmtzvPJtHYzW4LL7amFbGhDWjTKR-xtUAgY4QjzDgvc4C-3aOY54TtjQkgutr-M>
X-ME-Proxy-Cause: dmFkZTGJE1E39mnBLQijsQwgZPe7FMLOWocf7ZuMlm9mYMde6pQaRLMYkj+WOntOHMI0Mq
 s+L39Lbhc0k0omMfJUkzpdVYNifqCcGYMenflpUbvu/5TR/sh7xgBbomj8p3AOV77xQXUT
 5tmyp0djhmClxOMuYSV5xMbYCu6y+5drx3MZYGLXnYOsJFw/vzNG5PR6LbSn0twY8I7EU8
 IkiJMk1AADAK3uhwn71CxTLacJvZX1R8AL+UUAR4jlPuhhAgYj5xUh3fdQXfi1M9+5X0ES
 yWXzrMhZepaHXXdwgNvUc2uSvbbv6qeRAGdVYbm0sYyQpRxxwNREL3GqqW09NttbONw/Dw
 NPp/W5d2bF9HoMtSvxyL6MDJuP0/hRblRCvSa9jncJ6rPlnoE6+AC65Ewtb9ETOJVa4Exq
 JGtPH3TpYB5DY4TfOVPVH9hvIY7FZH1oOhUB0MFYFwaF8HwZW1idH2HnMlIMTjy6mLKclP
 Z8IHxhtSsxVQkZC4nSQSYf0ZBrJNARV2pLbetnya5KAOGEBeNQ7NKu/5DrslHrwhlcuJdu
 YwfNFzyB88XUCSqF+XhXlD3C9WRiDWbnkzZyMgI7wkKIedHxyvr7u6AVO5sXn0tGYFML+4
 QjGuB7IH7CCpDc7eAcEnWuSJFKBQKvy5mUkM3JSy8Bd1RnfJSqwZl/BzlpJw
X-ME-Proxy: <xmx:j796akv3AYiG3qqerY_IX_XORHmuWe4FXTSPsSU8-4TWbgmwzjZMLQ>
 <xmx:j796avCIa5s29uuFHu2h2_95yFOaNK7YNh4ke_VMLIvs0vHDnXFk_A>
 <xmx:j796amNcwLUnDbfkUZ_MSoUGp2SCuiEv6w9DiywIuxsBUgAQZkHHLw>
 <xmx:j796aowc4YIr21Dsq6Ml0BWSbl6r-Djh0vyjQsow4vMPWMzNJOm_rw>
 <xmx:kL96al0W6cEWUqngfl5vD2i_pvHldyB-FBzu3AntFGVxfnzXSAfhstVh>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 02:22:07 -0400 (EDT)
Date: Tue, 11 Aug 2026 08:22:05 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>
Subject: Re: [PATCH] hw/nvme: add SPDM_SOCKET Kconfig dependency
Message-ID: <anq_imtEJZ3XssyQ@AALNPWKJENSEN.aal.scsc.local>
References: <20260810214846.76805-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yy2NwIbj0v3golzB"
Content-Disposition: inline
In-Reply-To: <20260810214846.76805-1-stefanha@redhat.com>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=its@irrelevant.dk;
 helo=fout-a7-smtp.messagingengine.com
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

--yy2NwIbj0v3golzB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 10 17:48, Stefan Hajnoczi wrote:
> The NVMe emulation code unconditionally calls spdm_socket_*() APIs. Add
> a Kconfig dependency to avoid build errors when NVME_PCI is enabled
> without SPDM_SOCKET.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/nvme/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
> index cfa2ab0f9d5..cfeeed64cd7 100644
> --- a/hw/nvme/Kconfig
> +++ b/hw/nvme/Kconfig
> @@ -2,3 +2,4 @@ config NVME_PCI
>      bool
>      default y if PCI_DEVICES || PCIE_DEVICES
>      depends on PCI
> +    select SPDM_SOCKET
> --=20
> 2.55.0
>=20
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Stefan, Philippe,

Do you want to grab this through trivial fixes tree or should I send a
pull?

--yy2NwIbj0v3golzB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmp6v4oACgkQTeGvMW1P
Dek8Xgf/ZfVqQAKtJeUMfKqXaZFqa4UuH6MH21BSai/BraM5IyH6fMimw1vN5lOu
m4uqijRHzhAfXkXKvscTXbGlbcbhNih2Cd+9q5oBCbnMyTF23VeSEr96t/tq92o9
vqn+4AStymazuCPOu7W2pDA8WuZ8mCkrak/kjrIAzaa0XVIwMZI3or/oR2lytnsl
Z8eiaXEBW14Ho7Bx4B8rvo497lRjjjDAVkiZDytYlOpNDgDfOscnRc3Y27N6ZS/+
dDq+9REstHrlSx31gQ7e9aopOQKMbhCsciPI4+UqKf43y14+y40yKUMgwNAr02RH
u7wdWHIXoXZmQDrRZd9zELLfpJInLQ==
=tVyx
-----END PGP SIGNATURE-----

--yy2NwIbj0v3golzB--

