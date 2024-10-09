Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80926CED60C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 06:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syQ6K-0000EG-Lb; Wed, 09 Oct 2024 02:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1syQ6F-0000Dt-5O
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:23:07 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1syQ6D-0000Oc-6q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:23:06 -0400
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 273E4254008F;
 Wed,  9 Oct 2024 02:23:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 02:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1728454983; x=
 1728541383; bh=utG1qaiHaxw0hPEGfVYJgD7iWHm8Jg+Ujvz6ioXWgSU=; b=c
 xYF14n84zAcJakrnEDA/U7vcfkvNY12VXCCBTWtLCh7ZchhcbWM8NGeAOy7QpB91
 Ae7GaE5p3DYRPfTnO4NzI11S+mm7Z+Qik/fK4xDdlU6ae74dAK7dwNXW62Xu+cqC
 fBeHupBYjwTmuR5IJj9iadTEQP32CLJXgQMW5I7VXVHz4VcXGrdYugWx/lJ8KugO
 xXxxcatagQ3opHu0g4fo6iFLTJWos02pWQBjyAX/TmmoXT2gKK8Kk3gazq/KQm1X
 wO7LPdUn9uX2/A7b8K3CM/vBzSdoA5smh0HzCbyXMPYrsV1NyS8M1WfaGeUJlGy4
 pkqXyiElrUaBcdypp7KeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1728454983; x=1728541383; bh=utG1qaiHaxw0hPEGfVYJgD7iWHm8
 Jg+Ujvz6ioXWgSU=; b=j1iEL8gxBUGuaaSeIyEm5L5E5UdawKwVDfhAGDDisijD
 C+BwEwLAo8MJtV6qBchtfligZuG0ES/PqD8tQFz/bsVW+nP8nrDmMIPosIE66OPA
 kIAGhw8SUZvmnQmFaVY94AZvEbk2t/POzFyL9YfXL8Hn2a82ccUrBwcJjNnXFv8O
 0m95BRCGzFiYJKqOKksC4zKxPx2cJX1ergwWZjfK2tg2p2wPYpomaW8CCC3QmxRy
 OiiWPnweix1XNTUdlLSwkN9NBLwlulNS+GqVL6rNyLZbUvldTllFJWuXyvjjhbgT
 H6znHZsTH0tRq/3GhSUbnzHH/QAlUgrRcf3p2y8CJQ==
X-ME-Sender: <xms:RyEGZ6PRDlG3afo1CwyU9Bd8gZqP9YJXQ20w1XQBwrydk7lC9w1xxg>
 <xme:RyEGZ4_Q4be2jPWmYwmDgc4uJoD6ZInCVxTxFX9bhlhWKZncSbhXcX6oe_S0R6nZ2
 ZKQLwq3bgXeThVxCio>
X-ME-Received: <xmr:RyEGZxSfumlN89cNvCWUfYkODIZLMuAdov3aupllbyHM5MIJlaN4JmLS0tBZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
 evuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghn
 uceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepjefgje
 efffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlh
 gvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
 tghpthhtoheprghruhhnrdhkkhgrsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthhes
 khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpd
 hrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohep
 ihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:RyEGZ6sftfIxxVAYvUn-_9MHorTVowJH2JfVrsugI9xQWty-46M6mw>
 <xmx:RyEGZyfiecnN0QQ7iJKeRUodgcUksH_KYbzPFErrBnZOg1T_0lKH-Q>
 <xmx:RyEGZ-3w7hh5LBGiMAUMrk8TZ5wlo4Iv8tLUgxwNLWSP36XXbDOLkw>
 <xmx:RyEGZ28US131rWMEb0tEYX2JAXOXY-qMRwgYh1fLbH2HUzx2OS8Xkg>
 <xmx:RyEGZ6Tlr3sMmoi8ZXOB4L_rZO0MknFisfSmymX-SVdzNiS80WMpU6aN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 02:23:03 -0400 (EDT)
Date: Wed, 9 Oct 2024 08:23:02 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2] hw/nvme: i/o cmd set independent namespace data
 structure
Message-ID: <ZwYhRtp8_kI9fHnw@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240925061501epcas5p26c161f5c7cae08faa15a8db8391ab417@epcas5p2.samsung.com>
 <20240925004407.3521406-1-arun.kka@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bl3W+EOEjETE/w1V"
Content-Disposition: inline
In-Reply-To: <20240925004407.3521406-1-arun.kka@samsung.com>
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--Bl3W+EOEjETE/w1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 25 06:14, Arun Kumar wrote:
> add support for i/o command set independent namespace data
> structure(cns=3D8h and cns=3D1fh)
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Arun Kumar <arun.kka@samsung.com>

Looks good.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c       | 31 +++++++++++++++++++++++++++++++
>  hw/nvme/ns.c         |  6 +++++-
>  hw/nvme/nvme.h       |  1 +
>  hw/nvme/trace-events |  1 +
>  include/block/nvme.h | 22 ++++++++++++++++++++--
>  5 files changed, 58 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..cef2c3fa19 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -5498,6 +5498,33 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCt=
rl *n, NvmeRequest *req)
>      return nvme_c2h(n, (uint8_t *)&list, sizeof(list), req);
>  }
> =20
> +static uint16_t nvme_identify_ns_ind(NvmeCtrl *n, NvmeRequest *req, bool=
 alloc)
> +{
> +    NvmeNamespace *ns;
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    uint32_t nsid =3D le32_to_cpu(c->nsid);
> +
> +    trace_pci_nvme_identify_ns_ind(nsid);
> +
> +    if (!nvme_nsid_valid(n, nsid) || nsid =3D=3D NVME_NSID_BROADCAST) {
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    ns =3D nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        if (alloc) {
> +            ns =3D nvme_subsys_ns(n->subsys, nsid);
> +            if (!ns) {
> +                return nvme_rpt_empty_id_struct(n, req);
> +            }
> +        } else {
> +            return nvme_rpt_empty_id_struct(n, req);
> +        }
> +    }
> +
> +    return nvme_c2h(n, (uint8_t *)&ns->id_ns_ind, sizeof(NvmeIdNsInd), r=
eq);
> +}
> +
>  static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
>                                       bool active)
>  {
> @@ -5732,6 +5759,10 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeReq=
uest *req)
>          return nvme_identify_sec_ctrl_list(n, req);
>      case NVME_ID_CNS_CS_NS:
>          return nvme_identify_ns_csi(n, req, true);
> +    case NVME_ID_CNS_CS_IND_NS:
> +        return nvme_identify_ns_ind(n, req, false);
> +    case NVME_ID_CNS_CS_IND_NS_ALLOCATED:
> +        return nvme_identify_ns_ind(n, req, true);
>      case NVME_ID_CNS_CS_NS_PRESENT:
>          return nvme_identify_ns_csi(n, req, false);
>      case NVME_ID_CNS_CTRL:
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index ea8db175db..6dbdcb49bf 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -62,6 +62,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      static uint64_t ns_count;
>      NvmeIdNs *id_ns =3D &ns->id_ns;
>      NvmeIdNsNvm *id_ns_nvm =3D &ns->id_ns_nvm;
> +    NvmeIdNsInd *id_ns_ind =3D &ns->id_ns_ind;
>      uint8_t ds;
>      uint16_t ms;
>      int i;
> @@ -75,7 +76,9 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>      id_ns->nsfeat |=3D (0x4 | 0x10);
> =20
>      if (ns->params.shared) {
> -        id_ns->nmic |=3D NVME_NMIC_NS_SHARED;
> +        id_ns->nmic |=3D NVME_ID_NS_IND_NMIC_SHRNS;
> +        id_ns_ind->nmic =3D NVME_ID_NS_IND_NMIC_SHRNS;
> +        id_ns_ind->nstat =3D NVME_ID_NS_IND_NSTAT_NRDY;
>      }
> =20
>      /* Substitute a missing EUI-64 by an autogenerated one */
> @@ -770,6 +773,7 @@ static void nvme_ns_realize(DeviceState *dev, Error *=
*errp)
>          subsys->namespaces[nsid] =3D ns;
> =20
>          ns->id_ns.endgid =3D cpu_to_le16(0x1);
> +        ns->id_ns_ind.endgrpid =3D cpu_to_le16(0x1);
> =20
>          if (ns->params.detached) {
>              return;
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index bed8191bd5..b0268efe84 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -228,6 +228,7 @@ typedef struct NvmeNamespace {
>      int64_t      moff;
>      NvmeIdNs     id_ns;
>      NvmeIdNsNvm  id_ns_nvm;
> +    NvmeIdNsInd  id_ns_ind;
>      NvmeLBAF     lbaf;
>      unsigned int nlbaf;
>      size_t       lbasz;
> diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
> index 3a67680c6a..6be0bfa1c1 100644
> --- a/hw/nvme/trace-events
> +++ b/hw/nvme/trace-events
> @@ -56,6 +56,7 @@ pci_nvme_identify(uint16_t cid, uint8_t cns, uint16_t c=
trlid, uint8_t csi) "cid
>  pci_nvme_identify_ctrl(void) "identify controller"
>  pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=3D0x%"=
PRIx8""
>  pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
> +pci_nvme_identify_ns_ind(uint32_t nsid) "nsid %"PRIu32""
>  pci_nvme_identify_ctrl_list(uint8_t cns, uint16_t cntid) "cns 0x%"PRIx8"=
 cntid %"PRIu16""
>  pci_nvme_identify_pri_ctrl_cap(uint16_t cntlid) "identify primary contro=
ller capabilities cntlid=3D%"PRIu16""
>  pci_nvme_identify_sec_ctrl_list(uint16_t cntlid, uint8_t numcntl) "ident=
ify secondary controller list cntlid=3D%"PRIu16" numcntl=3D%"PRIu8""
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index bb231d0b9a..47af651354 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1068,6 +1068,7 @@ enum NvmeIdCns {
>      NVME_ID_CNS_CS_NS                 =3D 0x05,
>      NVME_ID_CNS_CS_CTRL               =3D 0x06,
>      NVME_ID_CNS_CS_NS_ACTIVE_LIST     =3D 0x07,
> +    NVME_ID_CNS_CS_IND_NS             =3D 0x08,
>      NVME_ID_CNS_NS_PRESENT_LIST       =3D 0x10,
>      NVME_ID_CNS_NS_PRESENT            =3D 0x11,
>      NVME_ID_CNS_NS_ATTACHED_CTRL_LIST =3D 0x12,
> @@ -1077,6 +1078,7 @@ enum NvmeIdCns {
>      NVME_ID_CNS_CS_NS_PRESENT_LIST    =3D 0x1a,
>      NVME_ID_CNS_CS_NS_PRESENT         =3D 0x1b,
>      NVME_ID_CNS_IO_COMMAND_SET        =3D 0x1c,
> +    NVME_ID_CNS_CS_IND_NS_ALLOCATED   =3D 0x1f,
>  };
> =20
>  typedef struct QEMU_PACKED NvmeIdCtrl {
> @@ -1400,6 +1402,20 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
>      uint8_t     rsvd268[3828];
>  } NvmeIdNsNvm;
> =20
> +typedef struct QEMU_PACKED NvmeIdNsInd {
> +    uint8_t     nsfeat;
> +    uint8_t     nmic;
> +    uint8_t     rescap;
> +    uint8_t     fpi;
> +    uint32_t    anagrpid;
> +    uint8_t     nsattr;
> +    uint8_t     rsvd9;
> +    uint16_t    nvmsetid;
> +    uint16_t    endgrpid;
> +    uint8_t     nstat;
> +    uint8_t     rsvd15[4081];
> +} NvmeIdNsInd;
> +
>  typedef struct QEMU_PACKED NvmeIdNsDescr {
>      uint8_t nidt;
>      uint8_t nidl;
> @@ -1420,8 +1436,9 @@ enum NvmeNsIdentifierType {
>      NVME_NIDT_CSI               =3D 0x04,
>  };
> =20
> -enum NvmeIdNsNmic {
> -    NVME_NMIC_NS_SHARED         =3D 1 << 0,
> +enum NvmeIdNsIndependent {
> +    NVME_ID_NS_IND_NMIC_SHRNS   =3D 0x01,
> +    NVME_ID_NS_IND_NSTAT_NRDY   =3D 0x01,
>  };
> =20
>  enum NvmeCsi {
> @@ -1854,6 +1871,7 @@ static inline void _nvme_check_size(void)
>      QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) !=3D 4);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) !=3D 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) !=3D 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsInd) !=3D 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) !=3D 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) !=3D 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) !=3D 16);
> --=20
> 2.43.0
>=20
>=20

--Bl3W+EOEjETE/w1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmcGIUYACgkQTeGvMW1P
Den6QggAne5mTIATqGaGN6SAetiFrIjqf92TFFzGMlpvI4VD5dPVibvL/i0TpQkm
pS3GlcryTWh2cIiJsK/qWTC3PcR2bZ1EBoH5QrcgXW+aexkzsY26qAUiRyuFZvtv
rIcjY8kP6/sBkiZ/tJB4r76XX8Qy/pxpBUb3bROYH3yzff7IKfYQwZC0AWIgx+2L
MRHgsAIO9MEHYtTc04lCJLIkPVYiZc3xRpxHJnoEef2+ejIUNLgi4cf9/IQYX+KT
J4YiLoWbei+2WipM8NodeH/6TIPgvMpPfF0hk7RbcdG+y53W9utztvd5NB6gwsAz
90K056Qnt6HdCAZ2XRh4yYcBuA7pvw==
=Mu7a
-----END PGP SIGNATURE-----

--Bl3W+EOEjETE/w1V--

