Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B22C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u260M-0004VA-Tj; Tue, 08 Apr 2025 06:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u260I-0004U2-Ur; Tue, 08 Apr 2025 06:16:27 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1u260F-0005H9-SL; Tue, 08 Apr 2025 06:16:26 -0400
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 0F81F138012E;
 Tue,  8 Apr 2025 06:16:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 08 Apr 2025 06:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1744107380; x=
 1744193780; bh=vZm4OJyOjJCAfcgpLIBLhMcG+DuneZAOtwFODTjr5xw=; b=Q
 Y7ECWdqtvSw2TjHBA+wBOGf4fwC5WlWvZbm/y9t/6bopnylzvsNkXdDzBOo5Hgeu
 /XeBEXGaBOHjwPk7Rf/yw92vh4PkjkadkCJ8B+ibky9TuwlGAl7U7g9cAzky1Gq/
 ZDPD4sBQvAi7dBGws+fpfMDRUH8dVaICH/7N7y/VrffVlxG8OpmJqZovr3fUbbhG
 L9Y09bI1Tp7zDszXskclsF68+Ba6lr38morrVrEfsXyJIniXt/eYnwAPZlEsGabx
 3XdaGFEAzi/3iv0uiF/X+0Sb20vftmALgonWLFZPFxaIRQQfPlGScpwyyVzggISj
 NzDp6EamftxO32WerzwGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1744107380; x=1744193780; bh=vZm4OJyOjJCAfcgpLIBLhMcG+DuneZAOtwF
 ODTjr5xw=; b=qN3PsT7OPQJHOn2evUqc7Wq83cUEddFDeJ/DP0u1BGSZ/jmZSfK
 eaVq+V5dAb+mDel6XGJPkXwBGI4UDz2+BP21UwnhZsjevbvmOCGcxD9GYCAnEsAM
 5DAJEElO90mFpnZRdPA4WYG8VZKeELFMyeCvDqyb+qEhN0WZd3mQoSPE8zyejX53
 c7W/nIHH4O8c1CZk5UOenTvLWLlplrWr3qaF+Z2yJrxGOudp/pwIJkKQBUR3FBSJ
 UyLPSbUstZ5TOgR3FFueViaha7RL7hb12QNuVXLAfgVE+upR/US9K+6L8WaHAMWp
 HUgWCYYnV84PdRsgeyVOsZjyLSuXjuWglyw==
X-ME-Sender: <xms:cvf0Z5rl0MZxiQVJHh2hAM-le-t5X6dfz1Rz77N-ESAZ_BkQNu59Ww>
 <xme:cvf0Z7o6KNMyXOIh_ZvsK7R3SLk8tnUrYYjGdQkWZOeQ2okEYeBFMpTAJyfPUygBn
 kDxNAUrWbOhQ83SkoE>
X-ME-Received: <xmr:cvf0Z2N1vHMNpjXawjgKQbb1UDhenO_WHlPJBy6Urp2QiHYlBlQ0Xyr5Lq6zMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
 jeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnh
 htrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudek
 veejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghp
 thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmh
 hsohhnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghl
 rdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtoh
 epqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdq
 uggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukh
X-ME-Proxy: <xmx:cvf0Z05Z3O78GxqZEHS9nUPk2_CbM4HBV_f04kZOKoTjeci8rMWGwg>
 <xmx:cvf0Z47eOeC0lpDVppf3CaraBU8__Kbh96Wx8d6OmQ6mWHpssAnrqA>
 <xmx:cvf0Z8jyZUYvzM-Et48FM1iO-GMHcybK6lTdbsyGBevd3pJLM_xz2w>
 <xmx:cvf0Z66ghUSvuDasvtsWZ_w2d75DY7d4CjJnXOHNXEnKyBJk3kUi0w>
 <xmx:dPf0ZwUFvjtJFvC0sKK9ocsRCx7PPEIugBcHSLVofNVlehiOVyEMjUvP>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 06:16:18 -0400 (EDT)
Date: Tue, 8 Apr 2025 12:16:17 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: alan.adamson@oracle.com
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: hw/nvme: Issue with multiple controllers behind a subsystem
Message-ID: <Z_T3cYh3Ttu6alFN@AALNPWKJENSEN.aal.scsc.local>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
 <0e1a7bfd-ac33-4779-928c-bb486b878bcf@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tojdh9nXeqZ5YwcS"
Content-Disposition: inline
In-Reply-To: <0e1a7bfd-ac33-4779-928c-bb486b878bcf@oracle.com>
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--tojdh9nXeqZ5YwcS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  4 10:52, alan.adamson@oracle.com wrote:
> I'm running into a issue with the latest qemu-nvme with v10.0.0-rc2 with
> regards to multiple controllers behind a subsystem.=C2=A0 When I setup a
> subsystem with 2 controllers, each with a private/non-shared namespace, t=
he
> two private/non-shared namespaces all get attached to one of the
> controllers.
>=20
> I'm sending out diffs that resolve the problem but would like to get some
> feedback before sending a formal patch.
>=20

Hi Alan,

Thanks for reporting this! This is definitely a regression caused by the
csi refactoring I did.

Few comments below, but I'd like to try to get this into 10.0. Timeline
is tight, so I'll send out a patch with my suggestings below.

> @@ -7751,17 +7752,23 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 nvme_set_timestamp(n, 0ULL);
>=20
> -=C2=A0=C2=A0=C2=A0 /* verify that the command sets of attached namespace=
s are supported */
> -=C2=A0=C2=A0=C2=A0 for (int i =3D 1; i <=3D NVME_MAX_NAMESPACES; i++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeNamespace *ns =3D nvme_su=
bsys_ns(n->subsys, i);
> +=C2=A0=C2=A0=C2=A0 if (n->subsys) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 1; i <=3D NVME=
_MAX_NAMESPACES; i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeNamespace *ns =3D n->subs=
ys->namespaces[i].namespace;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ns && nvme_csi_supported(=
n, ns->csi) && !ns->params.detached) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!=
ns->attached || ns->params.shared) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nvme_attach_ns(n, ns);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ns) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 continue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(n->subsys->namespaces[i=
].ctrl =3D=3D n) && !ns->params.shared) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 continue;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nvme_csi_supported(n, ns-=
>csi) && !ns->params.detached) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!ns->attached || ns->params.shared) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_=
attach_ns(n, ns);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 nvme_update_dsm_limits(n, NULL);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;

Yeah, this is where things went wrong.

> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 6f782ba18826..bea3b96a6dfa 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -97,6 +97,11 @@ typedef struct NvmeEnduranceGroup {
> =C2=A0=C2=A0=C2=A0=C2=A0 } fdp;
> =C2=A0} NvmeEnduranceGroup;
>=20
> +typedef struct Namespaces {
> +=C2=A0=C2=A0=C2=A0 NvmeCtrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *ctrl;
> +=C2=A0=C2=A0=C2=A0 NvmeNamespace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *namespac=
e;
> +} Namespaces;

Let's just add an NvmeCtrl* in struct NvmeNamespace. If set, the
namespace is private.

> diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
> index 2ae56f12a596..d5751564c05c 100644
> --- a/hw/nvme/subsys.c
> +++ b/hw/nvme/subsys.c
> @@ -92,13 +92,19 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **er=
rp)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 subsys->ctrls[cntlid] =3D n;
>=20
> -=C2=A0=C2=A0=C2=A0 for (nsid =3D 1; nsid < ARRAY_SIZE(subsys->namespaces=
); nsid++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeNamespace *ns =3D subsys-=
>namespaces[nsid];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ns && ns->params.shared &=
& !ns->params.detached) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_=
attach_ns(n, ns);
> +=C2=A0=C2=A0=C2=A0 for (nsid =3D 1; nsid <=3D NVME_MAX_NAMESPACES; nsid+=
+) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeNamespace *ns =3D subsys-=
>namespaces[nsid].namespace;
> +
> +=C2=A0=C2=A0=C2=A0 if (!ns) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(subsys->namespaces[nsid=
].ctrl =3D=3D n) && !ns->params.shared) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (ns->params.shared && !ns->params.detached) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_=
attach_ns(n, ns);
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 return cntlid;
> =C2=A0}

The code here that attach namespaces when the controller is registers
actually need to go away. This is a leftover.

--tojdh9nXeqZ5YwcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmf0924ACgkQTeGvMW1P
Dek9xQf5AdmVnR9WPIvH9c25NOSFiv1B2dPvxzVjQCLYrGCmsJ0UQiOfxlbfbvjd
2jP/HiYffaBuRvSo9t2GjdZtlyIEpk5kWc3/0VTsXz22QmcgTVzpG3paoSPMDSJ1
QgLQeR6zgbRtL5AEF6QhDcxS/g3qyfo7r3blAOHhbYitw2w4aJ5GrZ9g+vp4zxq0
F0bdO3z439NUNuynqaQ5CPS+pEQVIkQ7NNTOLtw/O5eofEXwajejA6oOHgabARK2
h7L2cc+Vj41IGxXCenmmJ4tidj14FooTSmH4vu5ZfTFf50yPIdFMF7pB3S2xaXQO
ejGAUjPAdshYANBXz3euUBev7Sq+gg==
=ncs6
-----END PGP SIGNATURE-----

--tojdh9nXeqZ5YwcS--

