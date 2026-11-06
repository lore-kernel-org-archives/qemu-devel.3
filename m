Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63365606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=nUV2MrRw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L4mMr2F3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJvl-00076c-Tk; Fri, 06 Nov 2026 08:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xPJv9-00072u-9Z
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:24:01 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xPJuw-0007nk-LN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:23:45 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6A91A1D0018F
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2026 08:23:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 08:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1793971417; x=
 1794057817; bh=YIss9VZFIR1TT5QZSDmu7yqe2sIE69j9l2gfbICRWTU=; b=n
 UV2MrRwsP+WqxFhHu6whfo9z5ljlDMl34x/nbFnANYX4RCczGkydkjk76BeYOOIe
 r2kGMErejGAqs02urEwUso0zz2mIe4e8g/gFq3G4bxTQ7CdBB7ssfZbYruG+4qWh
 fsIFhkRBZXxbTVVtw6aGybVtHlhuL9hZzXTIDWmL5DnJiuYFEQpNwaRaPlwLVfTg
 5Cquke0n1aSaxpp3VJjbFV/Yeg1sQptp+jC8gGfpEjKmTXAC9t3tN6txb1qr10MT
 DUI9cUc/cdaejnZJHU/HNgNNpe3Zp9MH4v77qHgCC8Rlg7CTXauGNtHN1lpIt+1o
 FzwhbburtTJGrKzXBPonQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1793971417; x=1794057817; bh=YIss9VZFIR1TT5QZSDmu7yqe2sIE69j9l2g
 fbICRWTU=; b=L4mMr2F3qdrpORrVjydicoBAOYTAzMm2x+l1b6FwFo+BeDXeB7r
 k72aH4r9u7V+pzOl+0/7jre+fiGewAo0HBpM0CAhsZu1WpRAZ/Mt20r2yAORFT1C
 SLZITEjamx7wLuOourAe0jNeJjYEolycvvoBpkxZ9MZ9jqGzhP+Q5YT4Gu+p4qVP
 VdzPLZ+iFQZwkAw47hWrm3I4iD0f/5Ni10/zvDaEoLDmoxcoKAvLqQz86PlPXFKg
 Synk3NfRFAGb/e9r/7kJVb3UruI3Q+7Lh8Ys+Gm7UtPSbaVsaM3vFWEUjf/Q/XLe
 dXu7ZH0xf2t0UoxjQMrJSRrykDEXuviX2rA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793971417; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:ENNQosZYVr5DlXPf8g/mkYZKy4iFrAxZY3foAw5/nyZJKUX
 4OsaqlGMzHpHCH5zSGlGL6sfrtEQkui6HW6BJYh+Mrt5r3rYrlIg2wmcuYy6m3W8
 V/b/ZWSDojx53IgcYRTvxs02bYh2QurKnKHQtn/hWN1CqX3TzvnkYYeglCr/6bV2
 deZapJqxsg63fy23Rmkwan3/gmUIZOZ8Nc1vY4HxVDYRmHx64a8k+GhzybMhXPqz
 u3dkNzp//745v5gI3/ymh9CgQgsgCnqOZ44ybVELUp5RMfdmWkzxa+/RNFv07tnL
 r9lvl5Z/WNmcYPV08XzZuw3ZCjirkXe1pfY0oQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:smwhge5hyHmUXmt4T3cJkEep72gahug+EHqJT4YCdVs=:k4/U3c2RYmos8zxM2fB2nI+jMo9yO/Z6qmb+j1W51Rs=;
X-ME-Sender: <xms:2NTtahwK4QwT-_sBY-OLGSOYNeCCjiUXrpeupdvYXbc3JaDz-BMESA>
 <xme:2NTtaqPPskhSNoj7x_uYmVTMqVdcbzKNqcKUAgII9N74Ct39TZoweUz-T23GC_uCu
 AdjMPV4mPVVxScH15io72jO46ciT9Uxp47foYIWpRD51_GblTaVS5CVzA>
X-ME-Received: <xmr:2NTtam4iLLWMLZTb5WvFn5ljcxCiPCJXdoHTdllyXV2xgP5U29xWOuVl_PsGRvtm_qJppnT5ipveZrGviuFNkyCvQAIIQB8>
X-ME-Proxy-Cause: dmFkZTFvUNwnrRPCKRkTAOxMdL2r0AFjKTwjkSGdE87j1hCTspL0aEc7zXHLANOTW2s+tq
 lft+cWwsMJv76U1C1lXYsgXIU39ueFSHXe832TO474ceW7Rx3o/lUAFZBToKTCNqf5KD8U
 BhmadvVdCIoc9HtYp6uq8ACVfkSx8FwG9Y/ySt3SNv14GGSB5/Jx48+XdF3nvThyrrGK6X
 4Tvo5gsSZpioxSwB1SJAlhkhI4N4deADLrATeHcsEZj3UbL62FJn4yCNzOxysa4u0aVCiz
 Hzf2/kmvwNBRnEmTK+YBuUVWCpqqaDCU69VyTvS7MCnhVzZvDxutFeVuiV0R7Mnl2WWUeR
 iUa5jdSAnrzrPXxyRqKeIHIARODG03602taKdWAqFcQBLNGfcZJCWWw5Q9Ed3pMR7YpxM9
 05fBb/owQR7PNplQC4vGCiW5FKow2JUPK2TCGdyx+E52+bq5eFfWLerUsbo7MsLCwX6eME
 O+5I/MBK1UlZkjh9AZb8DMLzl0diJzzeBAP73/3ZOCIjGPlpEfYfa4dRC6IsO3jXiQ02Fo
 PT+/Ei7jHv5n9Wt5uFobvmCTosWsNhQSJ5Du7aBbQAij/OX6MiCazJesTWxVxe5pHG1FKG
 FAYxybYjrw+amAUeHBzr/4WZd5KUFeCAlMm/jaE+N0PWaouq5Wxz4M1bak0Q
X-ME-Proxy: <xmx:2dTtajm-kuNpczgXbcviFg2itj-6R9ZrMqumDjSaI04A49jHVxX7bg>
 <xmx:2dTtavSOsc8y5YJ68N4iyn1lzbr9Mt9IcktpPCup_HIe9QPK2EN5iQ>
 <xmx:2dTtaqGF5jlZ_hYfBIZxbU8HXGZ4vgnyi8E5E_Oq6QNNvrZY2jHBug>
 <xmx:2dTtasFaF_g-TbdBm1kUoxlVidkrCx0VURyj9ian6HOpZrQaaiTVkA>
 <xmx:2dTtauJpvf5wCzTuvLiEmBrF_mB2XWY0TFaDGVSKrK3Noztcyg35xStW>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 08:23:36 -0500 (EST)
Date: Fri, 6 Nov 2026 14:23:35 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Markku =?utf-8?Q?Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
Message-ID: <au3U14vW_e2busZz@AALNPWKJENSEN.aal.scsc.local>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uef0XNP1HgXsbjbN"
Content-Disposition: inline
In-Reply-To: <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
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

--uef0XNP1HgXsbjbN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 23 15:20, Markku Ahvenj=C3=A4rvi wrote:
> cq_pending counts interrupt-enabled completion queues with unconsumed
> entries. nvme_cq_notifier() and nvme_process_db() decrement it whenever
> a CQ becomes empty, but they may also process a notification or doorbell
> write for a CQ that was already empty.
>=20
> Decrement cq_pending only when the CQ contained pending completions
> before its head update. Otherwise cq_pending may underflow and
> prevent legacy INTx from being deasserted.
>=20
> Signed-off-by: Markku Ahvenj=C3=A4rvi <mankku@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4753

> ---
>  hw/nvme/ctrl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index c641226e27ad..2be4bab7eb5a 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4782,6 +4782,7 @@ static void nvme_cq_notifier(EventNotifier *e)
>  {
>      NvmeCQueue *cq =3D container_of(e, NvmeCQueue, notifier);
>      NvmeCtrl *n =3D cq->ctrl;
> +    bool pending =3D cq->tail !=3D cq->head;
> =20
>      if (!event_notifier_test_and_clear(e)) {
>          return;
> @@ -4790,7 +4791,7 @@ static void nvme_cq_notifier(EventNotifier *e)
>      nvme_update_cq_head(cq);
> =20
>      if (cq->tail =3D=3D cq->head) {
> -        if (cq->irq_enabled) {
> +        if (cq->irq_enabled && pending) {
>              n->cq_pending--;
>          }
> =20
> @@ -8555,6 +8556,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
> =20
>          uint16_t new_head =3D val & 0xffff;
>          NvmeCQueue *cq;
> +        bool pending;
> =20
>          qid =3D (addr - (0x1000 + (1 << 2))) >> 3;
>          if (unlikely(nvme_check_cqid(n, qid))) {
> @@ -8609,13 +8611,14 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr a=
ddr, int val)
>              qemu_bh_schedule(cq->bh);
>          }
> =20
> +        pending =3D cq->tail !=3D cq->head;
>          cq->head =3D new_head;
>          if (!qid && n->dbbuf_enabled) {
>              stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPEC=
IFIED);
>          }
> =20
>          if (cq->tail =3D=3D cq->head) {
> -            if (cq->irq_enabled) {
> +            if (cq->irq_enabled && pending) {
>                  n->cq_pending--;
>              }
> =20
>=20
> --=20
> 2.55.0
>=20
>=20

--uef0XNP1HgXsbjbN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmrt1NcACgkQTeGvMW1P
DenUDwgAwF1P8RnTOYKyD4/3GeEXwvlAXgvjWyes37urEfhYSOzvx114FwtbQ0dk
a0q4bP6TPkv3CYkDWtRNO0ucoaBl3fv3/ap7Zifj3BKnN+Fsx1GfQhXTcvIA4QQo
KRcSTT2b5Ktg349gpSwx+7Hk+Ecm3+rWxW1SnZ2R1TlP6Ga0ru891k4eYKsJDiYv
d8ZrktgKdhYoWCgZmg9ZKpceAeMVGL8SrKSxl4OtvuZaDYuDtGm/T//xHLJ9aKTU
6B2IqJYlt6khL5cVI2VqV90Y3G+IPsgMaPfxRr/YjBvR4B8qZkdC4AyzEHvoVJIi
/eRNzNLP0X9OZ/pHv/2BQ9arz726zA==
=tYXF
-----END PGP SIGNATURE-----

--uef0XNP1HgXsbjbN--

