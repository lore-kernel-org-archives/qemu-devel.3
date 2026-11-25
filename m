Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BB606A339
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=JCH+0xrm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2F3jak3d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAB2-0007rz-A0; Wed, 25 Nov 2026 05:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWAB0-0007rn-Kn
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:24:34 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xWAAw-00008O-Rn
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:24:34 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 9F2961D0047A
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:24:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 05:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795602267; x=
 1795688667; bh=8NQSITXSYGGFqYsIKZdzXx6tAjMVSWkG3cTx8rXzGrE=; b=J
 CH+0xrmC8FhIwssdAeF+21Tpx/RHm2i4dogyp/wIPAuq0cxiAsLG14THQMU+3yl3
 f96VNeMO30YCJtC9jDIOTUjltkd9igCPskqbgw6GdpWBti4PvVw5o9IO7iG/hUzT
 jH4HsS1AFt7J3I6ZKeT7xMlwrzIpD/7DCvl3G8thN3qQ7wx/jW2JAzbARj2FJKJ5
 qn8B8/cVhiD4W082DMCXNl0X1TGgrfwuTlZWVZEqij+HVKOhtq+s0q4pKhi8GsSM
 YzKgDWrgVBhp6XiL9ZM0bAjlzAvGsOiGp8jujq7G8YlOO8E/fPDLp3obb+JBXe2b
 AmTdgenPGcWtwuFrw5d/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795602267; x=1795688667; bh=8NQSITXSYGGFqYsIKZdzXx6tAjMVSWkG3cT
 x8rXzGrE=; b=2F3jak3dnuZta+pxIxTsQ0YJ49MC03JiKAML37jQHr0w56WTDNC
 1NEm5p9OAhai2XPu+Chl/ntmhXpww+3M+dcqN1Tz4i7ebbmv5ZAblvc3HkAvHEzj
 WnTMhZwn2bg+WyMKSB59fNEdtfTlDiw/UoXeXsdaRj/Lwl1MXARwl/xkkvsceeQi
 gul9mVM8EDk9XCuMWeTnlXM1xe+yJNwmsEt3K3JPG+5GJjS96samqccDMynrTUj7
 JCs+654/wv1J0PCW7RHAgLQrrW77xKABxrM65goMvVJG+FfmKOgYMu3Pwl4iqgkO
 /MrCyxROcx+pL43ZrnYEzftOixV3jxmmrAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795602267; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:RMxKO9pqeFqqLIn5GnN2x2r3+f0rS6S5t7FU6RR7vVIOJkG
 6gLzXI87lHOLZCb7BBT9ellPgvtzwb4uRvHXlVjtDKiICrz1z4K+vGC6W/DPxNSg
 i+xQClti4F7cCGFYJT8cd/kA6LEt34mOW0lekQXXthxVqdIhBot/0dO7njZWatSk
 MX/YAOz5tLkrxkVu2XkxEbw6QhJDPI818SQaTB6eoSOKdumxVxX2BbrSMx3WBS/0
 NmxDjC/WJgPyG5GMGNe4/DtHjIX+UO0yv1YrSNuKH96G13EpuSmn6DP111c8rTKb
 //upbg6LNfAKM3wTXxmiTvZCQnHLbYKxLJFqpyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:WJfo4V8g4DbBS/1mOEx532UA8TgwvxBNdyDtgsUOuV4=:GBgWG9kKKR6gpmYFbCvlFviqS3tSSvxqdHqvWrEhkIk=;
X-ME-Sender: <xms:WrcGaxH8lky-OjiGMic1t3opbPrb1rOVaf5RYhWoa9EESUnJFEj00g>
 <xme:WrcGa4mdOl-5OuxvcsY2mIL5H5g9HuyjrR7OTFJAyea_qenVmZetc3z0VQCStr08k
 9O46zFFluMID9E08xqsetUVJ4fX-XNSCru8Cm_i0KUXfrYCTiKHpfw>
X-ME-Received: <xmr:WrcGa1YFDimLEVnr9NRLC2WXaeKYDD5q5cjCQZY8zj0u5ZoaI79Qf2Z2JA0LGA>
X-ME-Proxy-Cause: dmFkZTF0Y0miwuh9l99wkJPqS92v7Up0zDp4bCGvP9AWNPww9wl4jPVpNEF2g/kQU3PAfw
 nqYCBsOIBgn4BSpYc94XpiVqXtKYsViDrtdsGEhcqBGei9Q7NuNITL2diZnnMpKrJwQuqU
 XJjZ85oJvO/HvSISKTWoJLp+MEWed7mEfhWOHznBU3mTBEnaQxkYYKVZmeOf/3ILV2204n
 75vkVe4THRmG7IfNFUXToIgzfZJGwWfhcBm3rU12KX1LABsxsG1n37yIpQOQ/SjmTRdgCX
 sgCILrFG7TjABo1bcnONvumPDFwLoF85kbrxx6zxUAuPDZgMcxRxp6xoUz1QdbsxN92BC9
 y6xcA1pCbUdgPIH3zG1aO7IlHhLu1keeCiM/ILkxVpMRkUoVeAjaK1eHUPhIMjlvRj1AAn
 ujbJ/omIvvYwTC83Ekal7/Fse4hSShb4ODDITi90CrehtoS7FE9MFiPx1GIN5x2jufNUkQ
 cTxAED1z2kNwsjZh5fJLgddWDp1o0j6Ef5Zu/lvxJ4BJuXlDtBiP2THHHBU5VRN5pFtLHt
 9qoAP/09qrrNZ9/24vFzYpVzIMz7f+u4Ho1uuFGkUIWEkf2pqQgGDV68aVAkTkAtqoWPok
 DhffDp1BP7zuLdw8/6qIp5xLaodBaiXeUSB+HaqHfJs83QIqpCTJbIRCl9uQ
X-ME-Proxy: <xmx:WrcGa9H3uiGZbMOK4Pf-p5aXN3X1kq1TEhVXvQZlOijfK33XPC0HNg>
 <xmx:WrcGa2IeolGoT5Q1qMgyt0fad3kz5gt_QU0eZdUcbEP97Vke61f0Cw>
 <xmx:WrcGa4Nb-LmT0qRqqhSiGC04-Jm5fIYvDnM2DKadKIdMGPk1t1XzTQ>
 <xmx:WrcGa2kElbsd2_6spBAZTsk6qH75TgBlihIG7CdL43Og6xWsHlFiRg>
 <xmx:W7cGazfdpfdG9tc2veiOsn3c6W4XAUa3m0h8egzPfPq7pJHW6-IB977F>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 05:24:25 -0500 (EST)
Date: Wed, 25 Nov 2026 11:24:24 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/nvme: fix use-after-free on duplicate dbbuf
 configuration
Message-ID: <awa3VlggWQqZf4Gz@AALNPWKJENSEN.aal.scsc.local>
References: <20261123-fix-4902-v1-1-342b8dc00fef@samsung.com>
 <baef72f0-5ecf-400e-addf-7059391ba45c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P/KG/GsWIvFneSG3"
Content-Disposition: inline
In-Reply-To: <baef72f0-5ecf-400e-addf-7059391ba45c@oss.qualcomm.com>
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--P/KG/GsWIvFneSG3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 23 14:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 23/11/26 11:03, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > nvme_cq_init_notifier and nvme_sq_init_notifier does not consider that
> > the notifiers may already have been initialized. A second Doorbell
> > Buffer Config command will re-initialized the notifiers and leak the
> > previous fds. The leaked fd will remain registered on the doorbell
> > address and may be dispatched on doorbell writes, referencing freed
> > memory.
> >=20
> > Make sure the notifiers are not initialized more than once.
> >=20
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4902
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/nvme/ctrl.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >=20
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index 5755aad1fa72..7b5f6178dd36 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -4837,6 +4837,10 @@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
> >       uint16_t offset =3D (cq->cqid << 3) + (1 << 2);
> >       int ret;
> > +    if (cq->notifier.initialized) {
> > +        return 0;
>=20
> Simple enough; but avoid poking EventNotifier internals:
>=20
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
> -    if (cq->notifier.initialized) {
> +    if (event_notifier_initialized(&cq->notifier)) {
>          return 0;
>      }
>=20
> @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
> -    if (sq->notifier.initialized) {
> +    if (event_notifier_initialized(&sq->notifier)) {
>          return 0;
>      }
>=20
> With that:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>=20
> Alternatively guard the registration state that actually causes the
> dangling ioeventfd, checking ioeventfd_enabled at the DBC call sites:
>=20
> @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
> -            if (n->params.ioeventfd && sq->sqid !=3D 0) {
> +            if (n->params.ioeventfd && sq->sqid !=3D 0 &&
> +                !sq->ioeventfd_enabled) {
>                  if (!nvme_init_sq_ioeventfd(sq)) {
>                      sq->ioeventfd_enabled =3D true;
>                  }
>              }
>=20
> @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
> -            if (n->params.ioeventfd && cq->cqid !=3D 0) {
> +            if (n->params.ioeventfd && cq->cqid !=3D 0 &&
> +                !cq->ioeventfd_enabled) {
>                  if (!nvme_init_cq_ioeventfd(cq)) {
>                      cq->ioeventfd_enabled =3D true;
>                  }
>              }
>=20
>=20

I have some patches down the road that gets rid of ioeventfd_enabled in
general, so I'll go with your above suggestion.

Thanks!

--P/KG/GsWIvFneSG3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmsGt1YACgkQTeGvMW1P
DembzQgAuVRhYnlJFRqNkd/Hp7kWNkE4hRGkyPHWl00h6xPqQ5kySYkJ4mmL8nOn
WvPVkQVvtqWqpoF/6o/iB+LLuyZdZzexWy+fzvDZUlTEyqOxjxHSaZY8NaCvm2oH
sBxULv1Vi37bJNhOg+BEjz7f1S1gMbIlkbSCY84HlsAiKwX6CKTPa8HaVaO3n4N5
a5lDjaE9QVDPnk+kBV8Jyq6I7hyMqOaiBVMcWRA6naWw6X53kAHsvuQqTBKvLud+
5PlNLV16cMdeGyQtLQkGe3QOoiXvdrVAjvrcuNBvuwr7fH2epLCpkMnmbFQFX471
Z/pMef5uuSJV/BQKljoVQwmPXKyBjQ==
=rU6E
-----END PGP SIGNATURE-----

--P/KG/GsWIvFneSG3--

