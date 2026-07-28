Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C64CC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocTr-0002Jx-5I; Tue, 28 Jul 2026 03:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wocTn-0002JJ-Vt; Tue, 28 Jul 2026 03:44:00 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wocTl-0001Tl-Ou; Tue, 28 Jul 2026 03:43:59 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D543A14000B6;
 Tue, 28 Jul 2026 03:43:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 28 Jul 2026 03:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785224634; x=
 1785311034; bh=dCRKJLN2RrCNP7efXZ7zhIxYqx2WtiCSMNhmvJ5IJ+M=; b=d
 WtCEIcFyv12yL+rZm0LnUCHlEqt/774IOnAifqakrLmaX1OXfANWrVwcXQ5Emipc
 6tjMsqsquY6HGkeSJR7A/OBBm0RbJ8E55E8spjXmqa1zON94gRsMscMZZt3/zugR
 KeatRL+nM9aqUnmV37ogzTBshpsDnwyMO3W1IYK+mZhFaJy5UxpO8NuoOaBtpA4H
 Z79+CUfVbWY+IuBUVlnIbyIpL+pQeYX6V5hD+p0MSiMc5Nkj/7tZqXTW+Sd6gPIc
 zLSVT1pwFMqDgvPDvpGojwOJUatDCArXV6nV/oeQ8C+UK8gRUxy4vVLIAEMsKQHo
 g/jaa1jh4NoiPsSLVlnGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785224634; x=1785311034; bh=dCRKJLN2RrCNP7efXZ7zhIxYqx2WtiCSMNh
 mvJ5IJ+M=; b=ACUX3ndm5iK/wY4+VnqqSXmz5oPwE5mb/uy1qeYfHk8NlTfxy/M
 ftJkgv5kBLmPP/GOnHcq15U8QFe2SDTX2kzv50U6fWuDeBTRXsb9UiQMuhu6q4Un
 9HTwYeI+ZaU90Bzvj92JuXmA6HpxZqKavvslZDsKkDZ5B+FdtROihWuBs+HzUnch
 fLb/jR9HzD3omuMpD5rAAnmWwhPfm2MgUZsdZxoPV9YApwafV3jsD5qpYN1uqWgW
 mapffWZ9hIjKbdT7rc5YVptJ1vkjF6poZ79nOgM+hCHlC3FmK5hLSTdm55VxKnuQ
 4JJORM2WOk1eCkwOmYRWYXS9sNt81pTloxg==
X-ME-Sender: <xms:uV1oahhEc9KotaOWdp_zXgFAzA2R6ZXKzbvN2LxDhhkLwSDwzfBw9w>
 <xme:uV1oagHurhLoXjAmEvr6wobsTYcii3KyQHGcDX9hVL64X-yZPkmyH3CTsQMwOpObJ
 wrxii4HocYKzrfyLRyqyfeGxWvROBW9XfGqflTtAPH090J6U5tEOMY>
X-ME-Received: <xmr:uV1oag-YFtm7xSJedZTF00kwZGhYL-_ShX3EaC1vJpiz8e7AlamQ_YywDkvx>
X-ME-Proxy-Cause: dmFkZTG1T3na9OGM/lVDbENxZ6/xZHRBrph/+Me8I4Awn5xmsjbSsALh6VFVFxM/CN+xl/
 vlxpKjdnHkyMn2Ht1+0ZjPPCdNYBFiLQwtuAtYX2PAA5GhGFvyqTa6a6DJhC01ymwOKXs/
 2oQYnCHxR7K8CILWrXHsJ1s///g/Xf5G1qAXKKkj7R4+4X12b5tH/lVlhXnE+AxSWaVgc8
 1xrzcs1fLkCM6LrISAnipqGZYv0moZ+dEhZggbVtyf/1Qzf4Ojw0KpzU+oNoH2hUDOubOD
 z6cOLoH2xpT4rImeEOkgFgEE3HCWZV5clERPBHJZe+tI9Av2W8Cff0TfmYHdKa7dU8C4s2
 EYTzwyRdy9Ow0sxn79FsIMrOiFw79dsXWqUiUMvSaHJDslZ0TDbcSEsrurbRleZ1HNzMj4
 gYcVp1F4a+BKCQkwafzlFuvLJKhiibF2a6+EWIX3EoJy+vvrQDmU9+nv6xYjyRMk4viqxH
 ipb5TjCRT5yJ0p+OFn/Y4M2epFRbFJTBgsH5eH6Qjkt5wR2INqBsNmg1oOGdHKKBlrSqdH
 ilHtxY59HR+boahbj0ZoLKEjJcoxof2/bhwvQ0eyIaBXAq1MCAsfEmoPHZ3NkiTClKwyH4
 b4glyG69xqcZW4vRNbyEwtdQFpgBhjfxPKRxGkou1s45fiu7x2Bk9CV+lP5g
X-ME-Proxy: <xmx:uV1oanwzeXm47pOnIwtPBAQNcRJBnpF1CAmIbc8kRJAJTrrgUzpJJw>
 <xmx:uV1oasMRuS7kW6SsQ9Yf80mvZ3UWDVKSC2zhi2Z3p8_AegWO3XHG-w>
 <xmx:uV1oas_fbhkHK4gVdqZjLOd0wcr7TlbrndiEqKloDNXEKRianJF3tw>
 <xmx:uV1oap7TW24-Byo8iJaKY5CG1VY63izlkj4EZ62VXT7PNnWMU6tcQw>
 <xmx:ul1oasTxsR8u7ZQeH_kQih30Mv0Gjl10ZZDEXllnhjmmc5dMDI84_4n8>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 03:43:53 -0400 (EDT)
Date: Tue, 28 Jul 2026 09:43:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] hw/nvme: use GPtrArray for blocker_features
Message-ID: <amhdtSJyGh39zq5x@AALNPWKJENSEN.aal.scsc.local>
References: <20260709084728.92862-1-alexander@mihalicyn.com>
 <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
 <CAJqdLroRKpD0B2KXbwG61DY=Uff_DZyxE-XB_AQmEnQt6ViyHg@mail.gmail.com>
 <CAFEAcA_gZmVZr5ixHgf9EmPHb2kBgOdenF=3JTNEzs71v+gM=w@mail.gmail.com>
 <CAJqdLrp6oi2dycW-m=zBWnaQ3nTy7cYtxUY_drEnYkoWgvGpSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XaGRKtCO8x2CKB2E"
Content-Disposition: inline
In-Reply-To: <CAJqdLrp6oi2dycW-m=zBWnaQ3nTy7cYtxUY_drEnYkoWgvGpSw@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
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

--XaGRKtCO8x2CKB2E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  9 11:01, Alexander Mikhalitsyn wrote:
> Am Do., 9. Juli 2026 um 10:58 Uhr schrieb Peter Maydell
> <peter.maydell@linaro.org>:
> >
> > On Thu, 9 Jul 2026 at 09:53, Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > Am Do., 9. Juli 2026 um 10:51 Uhr schrieb Peter Maydell
> > > <peter.maydell@linaro.org>:
> > > >
> > > > On Thu, 9 Jul 2026 at 09:47, Alexander Mikhalitsyn
> > > > <alexander@mihalicyn.com> wrote:
> > > > >
> > > > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > > >
> > > > > Let's use GPtrArray to build a list of blocker features and then
> > > > > g_strjoinv() to build a final comma-delimited string.
> > > > >
> > > > > While previous approach was technically correct, it is fragile
> > > > > (because we need to take care of static buffer size choice) and
> > > > > Coverity dislikes it too.
> > > > >
> > > > > Note, that we use g_ptr_array_new() to allocate array which means
> > > > > that GDestroyNotify callback is not set, so we can pass pointers =
to
> > > > > a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") wi=
thout
> > > > > any problems as there won't be any attempt to free that memory.
> > > > >
> > > > > Resolves: Coverity CID 1663673
> > > > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futur=
fusion.io>
> > > > > ---
> >
> > > > > @@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(N=
vmeCtrl *n, PCIDevice *pci_dev,
> > > > >              }
> > > > >
> > > > >              if (namespaces_num > 1) {
> > > > > -                nvme_add_blocker_feature(blocker_features,
> > > > > -                                         "Namespace Attachment");
> > > > > +                g_ptr_array_add(blocker_features,
> > > > > +                                         (gpointer) "Namespace A=
ttachment");
> > > >
> > >
> > > Hi Peter,
> > >
> > > > Is the cast here because we're dropping the const property of the
> > > > literal string?
> > >
> > > yep.
> >
> > Mmm. Unfortunate but unavoidable I guess.
> >
> > The glib docs recommend using "void *" instead of "gpointer" in
> > new code: https://docs.gtk.org/glib/types.html#gpointer
> > but either way
>=20
> ah, I didn't know that. My first intention was to use "void *", but
> then I searched over QEMU codebase
> and found a few gpointer casts in exact use-case (with g_ptr_array_add).
>=20
> I can correct this and resend if you want ;)
>=20
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > -- PMM
>=20

Thanks,

Added to nvme.next with the gpointer cast changed to void *.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--XaGRKtCO8x2CKB2E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpoXbUACgkQTeGvMW1P
Denj0ggAmXM3HCGTF5M/jmuQjSvyNGmHWPlbmCOvSumHsbEcflHtuEVUam3VZ8i9
AMKReG79UK0htQ3T+sz92KCvfvGKAvL+sNN+EvHV/vFHKfxTnSlVj4OlJPUoBDT1
+n6QOGrECBeC9/kyU+PF9vmn5J5dAeSjuu90Dk3KbCS0gEc7vP7fza5LIxKhb7LT
cbc2S4CqWFisLeiqcScgpnhS/npzt6fLzyfIywzYZMucJZqFQvBJkKoJxmNRu76A
ai4OHLuJCTkdC7Bjcasq7Ul3zA+qHkkQ/L3t7XgFR8AoHSbCnGHIOKhYolVAPosN
DJJgzpResFf155PKS0g6yK8PKAnbjw==
=9CPP
-----END PGP SIGNATURE-----

--XaGRKtCO8x2CKB2E--

