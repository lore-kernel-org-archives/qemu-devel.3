Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0103FC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMn2N-0000wZ-4o; Wed, 04 Jun 2025 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMn2I-0000vh-Uq; Wed, 04 Jun 2025 08:16:04 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMn2C-0003TR-QJ; Wed, 04 Jun 2025 08:16:02 -0400
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A5E3613804DC;
 Wed,  4 Jun 2025 08:15:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 08:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1749039354; x=
 1749125754; bh=Hp6zf+wxpedKJI7/+wwMFP4mY/Bi848Orhf/n7uYp20=; b=Q
 EdIwfKpuwcOgg29eDe8NfE6vERuDzf+8pLoxEHKFsJhQMbsmCZlzW/zJFcTM8hb5
 9nkZlFFjW9yWqAJkQp5lP61aJujIqV5WjS5OcYHugO5mYkhg+Jn3guiVEnny/PBE
 FvGZ9rpfOBMhD1lAXaVjyjkBXNJmkOl+uectpjBSQvgn4S+TBVZ1iXLMSZjy5TYj
 k1xN/dSyfIpvJ7hz1t5+1UC3gMSwTNSM9GPxuEVP3l3ubmdUYNWl6z1Yvb8M6Trs
 5Fh8ESfW9/1n8+NiIrak8/UYFRdsKYKiNkOH23JUOeA/CxX03nmOIfcrH7qpopx5
 sWU9OqjflESAWxkYZ78qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1749039354; x=1749125754; bh=Hp6zf+wxpedKJI7/+wwMFP4mY/Bi848Orhf
 /n7uYp20=; b=U+OVqcrM8joFy7hdIr2Jq51snMA2ItjBCCkkJkC/+ty7gZvnCsw
 NFv40q++Z0tJQNgI3hahntpKt5NxqIFyRvfOYNtiCCvnoi0iaJmo/SBHmdwHjVar
 IHJH5h2UNoNbJdf+QalrbLgkTvXLyZo+VAsoPUNoYp2x7LlnFGDLRymPHpp3QnAT
 haCYYrvr7Rf3HNr2IUDGX2ukMEOe7A+vSamjkDNgjMIEwfei5qlIYB+Iuk/nT3YO
 /SjFvRYVgyjczQ/BLWG2O1rgnqVrTyMG8pJmfsSTFuaa88Nvz7rQ86QUNI2qBx27
 Q8ulJSzuUh3J/5b7BMmP5YkSkCiw3g/UZvA==
X-ME-Sender: <xms:-DhAaCjSbDJwW8pebRySq5P0V6LtV2B71olvkcCaUQwKEZYG56YW2Q>
 <xme:-DhAaDCH-_GeXJsxsezH_01HLp7Frb7K0ZVHGCwnKgmkLKcGecCECc4OgDawVRyoG
 dq-uv1188-kFE12LJQ>
X-ME-Received: <xmr:-DhAaKEHLjuikzRyE1vSHVHXKAmYmUn0bf3h7rSgHl20trStUiQKpcXfdXUUag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfrdgvsghnvghrsehprh
 hogihmohigrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtg
 hpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhrvghithii
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepjhhs
 nhhofiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhsvghmvghnthhsohhvseihrg
 hnuggvgidqthgvrghmrdhruh
X-ME-Proxy: <xmx:-DhAaLRRw3hHGNRK6e6p08sHbxfAKUUUqN-bqDVEwWAbZX54HPmBIQ>
 <xmx:-DhAaPxFxYz7OuLTiLG9OeJZ0_1cqgpSB2fXphqL9EHPZZyZFo7pkg>
 <xmx:-DhAaJ7QFbpmWAZi34x3lmdLUvIRgFv4Zkybi0ZJzd_k2gcinQS3GA>
 <xmx:-DhAaMxY_Zznv0dqqee-lHiiYp8uoMhwzFiwUgYM1ZDzmatNxpLFnw>
 <xmx:-jhAaOi8Oaahn1bkZNpRf8QEWHJo_pRIvWRl6KRh4LlxYM5Q3fFKmiqK>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 08:15:52 -0400 (EDT)
Date: Wed, 4 Jun 2025 14:15:50 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 jsnow@redhat.com, vsementsov@yandex-team.ru, eblake@redhat.com,
 kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH 3/4] block: make calling bdrv_refresh_limits() safe while
 holding graph lock
Message-ID: <aEA49mn6O5mwtW-J@AALNPWKJENSEN.aal.scsc.local>
References: <20250604120717.458445-1-f.ebner@proxmox.com>
 <20250604120717.458445-4-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kW9ZIhDz3WS3otbl"
Content-Disposition: inline
In-Reply-To: <20250604120717.458445-4-f.ebner@proxmox.com>
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--kW9ZIhDz3WS3otbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun  4 14:07, Fiona Ebner wrote:
> The bdrv_refresh_limits() function and driver implementations are
> called with the graph lock held. The implementation for the 'compress'
> filter calls bdrv_get_info(), which is a generated coroutine wrapper
> and thus polls. This can lead to a deadlock when issuing a
> blockdev-snapshot QMP command, when bdrv_refresh_limits() is called in
> bdrv_append() while the graph lock is held exclusively. This deadlock
> was introduced with commit 5661a00d40 ("block: Call transaction
> callbacks with lock held").
>=20
> As a solution, this reverts commit 3d47eb0a2a ("block:
> Convert bdrv_get_info() to co_wrapper_mixed"). To do this, it is
> necessary to have callers of bdrv_get_info() take the graph lock
> themselves. None of the driver implementations rely on being run in
> coroutine context and none of the callers rely on the function being
> a coroutine.
>=20
> All callers except one either already hold the graph lock or can claim
> the graph lock via bdrv_graph_rdlock_main_loop(). As part of this,
> bdrv_get_default_bitmap_granularity() is annotated with GRAPH_RDLOCK
> and its callers adapted where necessary.
>=20
> The single exception is the caller nvme_ns_init_format(), which can
> run as a callback in an IO thread, but can also be reached via the QOM
> realize handler nvme_ns_realize(). For this caller, a
> bdrv_get_info_unlocked() coroutine wrapper is introduced that must be
> called with the graph unlocked.
>=20

> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 6df2e8e7c5..ee3eabb1aa 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -50,7 +50,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
> =20
>      npdg =3D ns->blkconf.discard_granularity / ns->lbasz;
> =20
> -    ret =3D bdrv_get_info(blk_bs(ns->blkconf.blk), &bdi);
> +    ret =3D bdrv_get_info_unlocked(blk_bs(ns->blkconf.blk), &bdi);
>      if (ret >=3D 0 && bdi.cluster_size > ns->blkconf.discard_granularity=
) {
>          npdg =3D bdi.cluster_size / ns->lbasz;
>      }

Acked-by: Klaus Jensen <k.jensen@samsung.com>

FWIW, if there is a better way to get the cluster size I'd very much
like to change what we do in hw/nvme for that. We need it to
infer/compute the "preferred deallocation granularity".

But maybe, it's just not the correct way to do this, and we shouldn't
try to do it at all and not report a preferred dealllocation
granularity. It does seem brittle, or?

--kW9ZIhDz3WS3otbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmhAOPQACgkQTeGvMW1P
DelBVgf/XilmLE5NkE9LWvWADiovRhD45vGwWSqksb8LpiqDuus/RhRvtt+E+uph
1Brctc+BlgcTKs8Gjx4x+eylQnIag7uYHMaXYyZ3JD4pSyhtVkZPVzOnHlZFG7vK
p+GTHFexGwsvXSTzkEOFRw7tfA2F1yeBj7dbD6/tAmevtWfoP568AxBJQmwl2GFT
rY6cVoR+P1T6rbYl9gRX4lJ4GMFMDKs67vgLmrFURSJ8OrVy0O5wtoV6WrFlDj+u
LokJHBjYiobeglIuzRgoptdPzEgU/bQO4OKsyXkNiumLjO7WMGyZ+dHFHYfPhPa4
qfsi74jnllaKI+bxh1mBTr7Odd66dw==
=sO/t
-----END PGP SIGNATURE-----

--kW9ZIhDz3WS3otbl--

