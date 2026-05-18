Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3EBCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOxcp-0003eE-4w; Mon, 18 May 2026 09:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOxcP-0003cM-8u; Mon, 18 May 2026 09:02:55 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOxcK-0002jd-QZ; Mon, 18 May 2026 09:02:47 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 035AD1D00086;
 Mon, 18 May 2026 09:02:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 09:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1779109358; x=
 1779195758; bh=ucwTg66BiJyTm/B8LG7xlNBhsqnmg96UUeWjuK7cHwQ=; b=I
 RBX20mNiUouhvNHqZPActj4vQzo9QIkOsb/A8pFQXOQoQY+tK63OosvBGRIX4u9J
 XrodiXRoAkWtfp5s+exVSsoPLmViwNjh4ZaA2p7aQ5RDS/kexzR2hcngAmnc1YaK
 ozb03R7n4LiqceDw5WthuKtco+J227MxEUuZoZZziGre0U8oiDU1T0k9p1WFhQvC
 oKUGfNkoLD6thksdCpQMR+qEXcde9a6f6sRgdFHDW2WdIB5KdFwofhEIe3LYOurY
 74V1jmlKljSNNLtmtjs0T1tFTdPGrtvRfPKm+jqHPA+I6g03PzXYY3aJtGCjtzqi
 c2ggyBpweA57T2VeDy53A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779109358; x=1779195758; bh=ucwTg66BiJyTm/B8LG7xlNBhsqnmg96UUeW
 juK7cHwQ=; b=DtBnVQERLj2VZkZpOo20V4HTgyF9XFGYKVNPoi3+DyrxvfblBXL
 nw15zoIvd7BGTnUZOI9NuN/yqCs7le9+HDgEhGtwKQCa5I7Hq3nx9oNjWGoPZNAP
 LggBKxRQFMx3w043aNE46hsSOzI/IAShF0o/Yj41OMO8UVIDPtxZn9KzeFt4qMkU
 Ug797sWypNIISPhxfSPMahOFo/7mVrCuyAqA53qEEOxxvXIQAg6HWMTx0btWmhFQ
 63tgBJQXARxEjztQSxvF6NMAuJVq/MCO8yI/awVzvconNVPCmb6VS8nlBptLBCTT
 A9Gv/v/Rin+y/uxwTVv9vVNI3yNCsD7yUjw==
X-ME-Sender: <xms:7Q0LamEqQeM3nlwDU0d3CJeEe1JfOVRylOSt22Kp4CMbyd_mhV6zhg>
 <xme:7Q0LaoSvdrrR6nn6ITvk7se1k2ahJNC6c2ec4NWUSQae7wkX6YEzaJiN9EA7hQXtz
 0q23w3GUR6CmOp_nM6IFgGSsNVyUbVx0Wtnq-djloOFOTUkRVqI9ko>
X-ME-Received: <xmr:7Q0LagdZlio_jFqg22yJW_hI2nneArAllarJen-ad3dhhTM2y7pd_0GphGFvM4h56luqvo55G5Gutg7dMx5nRIM5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudekpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopegrlhgvgigrnhguvghrsehmihhhrghlihgthihnrdgtoh
 hmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphht
 thhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhrvghith
 iisehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrdgtohhmpdhrtg
 hpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkfiho
 lhhfsehrvgguhhgrthdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrd
 horhhg
X-ME-Proxy: <xmx:7Q0Lauj79QfPBkIwszOFWSifBP5m6n5uLvVPzHIUYpUd0R7vvss13w>
 <xmx:7Q0LajJU5IeRCudLDSdoqYOGHbLFTQKnhtVlEAd97y9bUdBvqGlqgg>
 <xmx:7Q0LajGEOUOsss6sOnmUqIrDLCbxZqqsu2Sy4kwv8XMZIhDT8egmyA>
 <xmx:7Q0Lah3rTmoi18_FoeOzZzukf7BKJS0ifbMybToOis7FR-FcR6U_UQ>
 <xmx:7g0LaoObksb2xx2BTC9iqRxd75-gPCzGo4s5pxfxKea-LaRLF0taET6C>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 09:02:36 -0400 (EDT)
Date: Mon, 18 May 2026 15:02:33 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v7 2/8] hw/nvme: add migration blockers for non-supported
 cases
Message-ID: <agsN6SMYKCUKf-LM@AALNPWKJENSEN.aal.scsc.local>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
 <20260511151131.483217-3-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eT8SNJsOadeqt4/Y"
Content-Disposition: inline
In-Reply-To: <20260511151131.483217-3-alexander@mihalicyn.com>
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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


--eT8SNJsOadeqt4/Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11 17:11, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Let's block migration for cases we don't support:
> - SR-IOV
> - CMB
> - PMR
> - SPDM
>=20
> No functional changes here, because NVMe migration is
> not supported at all as of this commit.
>=20
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c       | 206 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h       |   3 +
>  include/block/nvme.h |  12 +++
>  3 files changed, 221 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index be6c7028cb5..167b8da6342 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -207,6 +207,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pcie_sriov.h"
>  #include "system/spdm-socket.h"
> +#include "migration/blocker.h"
>  #include "migration/vmstate.h"
> =20
>  #include "nvme.h"
> @@ -250,6 +251,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] =
=3D {
>      [NVME_COMMAND_SET_PROFILE]      =3D true,
>      [NVME_FDP_MODE]                 =3D true,
>      [NVME_FDP_EVENTS]               =3D true,
> +    /* if you add something here, please update nvme_set_migration_block=
ers() */
>  };
> =20
>  static const uint32_t nvme_feature_cap[NVME_FID_MAX] =3D {
> @@ -4601,6 +4603,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, Nvme=
Request *req)
>          return 0;
>      case NVME_IOMS_MO_RUH_UPDATE:
>          return nvme_io_mgmt_send_ruh_update(n, req);
> +    /* if you add something here, please update nvme_set_migration_block=
ers() */
>      default:
>          return NVME_INVALID_FIELD | NVME_DNR;
>      };
> @@ -7520,6 +7523,10 @@ static uint16_t nvme_security_receive(NvmeCtrl *n,=
 NvmeRequest *req)
> =20
>  static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
>  {
> +    /*
> +     * When adding a new dtype handling here,
> +     * please also update nvme_set_migration_blockers().
> +     */
>      return NVME_INVALID_FIELD | NVME_DNR;
>  }
> =20
> @@ -9210,6 +9217,199 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice=
 *pci_dev)
>      }
>  }
> =20
> +#define BLOCKER_FEATURES_MAX_LEN 256
> +
> +static inline void nvme_add_blocker_feature(char *blocker_features, cons=
t char *feature)
> +{
> +    if (strlen(blocker_features) > 0) {
> +        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> +    }
> +    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
> +}
> +
> +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,=
 Error **errp)
> +{
> +    uint64_t unsupported_cap, cap =3D ldq_le_p(&n->bar.cap);
> +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] =3D "";
> +    bool adm_cmd_security_checked =3D false;
> +    bool cmd_io_mgmt_checked =3D false;
> +    bool cmd_zone_checked =3D false;
> +
> +    /*
> +     * Idea of this function is simple, we iterate over all Command Sets=
 and
> +     * for each supported command we provide a special handling logic to
> +     * determine if we should block migration or not.
> +     *
> +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
> +     * available to the guest, but if there is only 1 namespace, then it=
 is
> +     * safe to allow migration, but if there are more, then we need to b=
lock
> +     * migration because we don't handle this in migration code yet.
> +     */
> +    for (int opcode =3D 0; opcode < sizeof(n->cse.acs) / sizeof(n->cse.a=
cs[0]); opcode++) {
> +        /* Is command supported? */
> +        if (!n->cse.acs[opcode]) {
> +            continue;
> +        }
> +
> +        switch (opcode) {
> +        case NVME_ADM_CMD_DELETE_SQ:
> +        case NVME_ADM_CMD_CREATE_SQ:
> +        case NVME_ADM_CMD_GET_LOG_PAGE:
> +        case NVME_ADM_CMD_DELETE_CQ:
> +        case NVME_ADM_CMD_CREATE_CQ:
> +        case NVME_ADM_CMD_IDENTIFY:
> +        case NVME_ADM_CMD_ABORT:
> +        case NVME_ADM_CMD_SET_FEATURES:
> +        case NVME_ADM_CMD_GET_FEATURES:
> +        case NVME_ADM_CMD_ASYNC_EV_REQ:
> +        case NVME_ADM_CMD_DBBUF_CONFIG:
> +        case NVME_ADM_CMD_FORMAT_NVM:
> +        case NVME_ADM_CMD_DIRECTIVE_SEND:
> +        case NVME_ADM_CMD_DIRECTIVE_RECV:
> +            break;
> +        case NVME_ADM_CMD_NS_ATTACHMENT:
> +            int namespaces_num =3D 0;
> +            for (int i =3D 1; i <=3D NVME_MAX_NAMESPACES; i++) {
> +                NvmeNamespace *ns =3D nvme_subsys_ns(n->subsys, i);
> +                if (!ns) {
> +                    continue;
> +                }
> +
> +                namespaces_num++;
> +            }
> +
> +            if (namespaces_num > 1) {
> +                nvme_add_blocker_feature(blocker_features, "Namespace At=
tachment");
> +            }
> +
> +            break;
> +        case NVME_ADM_CMD_VIRT_MNGMT:
> +            if (n->params.sriov_max_vfs) {
> +                nvme_add_blocker_feature(blocker_features, "SR-IOV");
> +            }
> +
> +            break;
> +        case NVME_ADM_CMD_SECURITY_SEND:
> +        case NVME_ADM_CMD_SECURITY_RECV:
> +            if (adm_cmd_security_checked) {
> +                break;
> +            }
> +
> +            if (pci_dev->spdm_port) {
> +                nvme_add_blocker_feature(blocker_features, "SPDM");
> +            }
> +
> +            adm_cmd_security_checked =3D true;
> +
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +
> +    for (int opcode =3D 0; opcode < sizeof(n->cse.iocs.nvm) / sizeof(n->=
cse.iocs.nvm[0]); opcode++) {
> +        if (!n->cse.iocs.nvm[opcode]) {
> +            continue;
> +        }
> +
> +        switch (opcode) {
> +        case NVME_CMD_FLUSH:
> +        case NVME_CMD_WRITE:
> +        case NVME_CMD_READ:
> +        case NVME_CMD_COMPARE:
> +        case NVME_CMD_WRITE_ZEROES:
> +        case NVME_CMD_DSM:
> +        case NVME_CMD_VERIFY:
> +        case NVME_CMD_COPY:
> +            break;
> +        case NVME_CMD_IO_MGMT_RECV:
> +        case NVME_CMD_IO_MGMT_SEND:
> +            if (cmd_io_mgmt_checked) {
> +                break;
> +            }
> +
> +            /* check for NVME_IOMS_MO_RUH_UPDATE */
> +            if (n->subsys->params.fdp.enabled) {
> +                nvme_add_blocker_feature(blocker_features, "FDP");
> +            }
> +
> +            cmd_io_mgmt_checked =3D true;
> +
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +
> +    for (int opcode =3D 0; opcode < sizeof(n->cse.iocs.zoned) / sizeof(n=
->cse.iocs.zoned[0]); opcode++) {
> +        /*
> +         * If command isn't supported or we have the same command
> +         * in n->cse.iocs.nvm, then we can skip it here.
> +         */
> +        if (!n->cse.iocs.zoned[opcode] || n->cse.iocs.nvm[opcode]) {
> +            continue;
> +        }
> +
> +        switch (opcode) {
> +        case NVME_CMD_ZONE_APPEND:
> +        case NVME_CMD_ZONE_MGMT_SEND:
> +        case NVME_CMD_ZONE_MGMT_RECV:
> +            if (cmd_zone_checked) {
> +                break;
> +            }
> +
> +            for (int i =3D 1; i <=3D NVME_MAX_NAMESPACES; i++) {
> +                NvmeNamespace *ns =3D nvme_subsys_ns(n->subsys, i);
> +                if (!ns) {
> +                    continue;
> +                }
> +
> +                if (ns->params.zoned) {
> +                    nvme_add_blocker_feature(blocker_features, "Zoned Na=
mespace");
> +                    break;
> +                }
> +            }
> +
> +            cmd_zone_checked =3D true;
> +
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +
> +    /*
> +     * Try our best to explicitly detect all not supported caps,
> +     * to let users know what features cause migration to be blocked,
> +     * but in case we miss handling here, everything else will be
> +     * covered by unsupported_cap check.
> +     */
> +    if (NVME_CAP_CMBS(cap)) {
> +        nvme_add_blocker_feature(blocker_features, "CMB");
> +        cap &=3D ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
> +    }
> +
> +    if (NVME_CAP_PMRS(cap)) {
> +        nvme_add_blocker_feature(blocker_features, "PMR");
> +        cap &=3D ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
> +    }
> +
> +    unsupported_cap =3D cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
> +    if (unsupported_cap) {
> +        nvme_add_blocker_feature(blocker_features, "unknown capability");
> +    }
> +
> +    assert(n->migration_blocker =3D=3D NULL);
> +    if (strlen(blocker_features) > 0) {
> +        error_setg(&n->migration_blocker, "Migration is not supported fo=
r %s", blocker_features);
> +        if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
>  {
>      int cntlid;
> @@ -9315,6 +9515,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
> =20
>          n->subsys->namespaces[ns->params.nsid] =3D ns;
>      }
> +
> +    if (!nvme_set_migration_blockers(n, pci_dev, errp)) {
> +        return;
> +    }
>  }
> =20
>  static void nvme_exit(PCIDevice *pci_dev)
> @@ -9367,6 +9571,8 @@ static void nvme_exit(PCIDevice *pci_dev)
>      }
> =20
>      memory_region_del_subregion(&n->bar0, &n->iomem);
> +
> +    migrate_del_blocker(&n->migration_blocker);
>  }
> =20
>  static const Property nvme_props[] =3D {
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index d66f7dc82d5..457b6637249 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -666,6 +666,9 @@ typedef struct NvmeCtrl {
> =20
>      /* Socket mapping to SPDM over NVMe Security In/Out commands */
>      int spdm_socket;
> +
> +    /* Migration-related stuff */
> +    Error *migration_blocker;
>  } NvmeCtrl;
> =20
>  typedef enum NvmeResetType {
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 9d7159ed7a7..a7f586fc801 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -141,6 +141,18 @@ enum NvmeCapMask {
>  #define NVME_CAP_SET_CMBS(cap, val)   \
>      ((cap) |=3D (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
> =20
> +#define NVME_MIGRATION_SUPPORTED_CAP_BITS ( \
> +      ((uint64_t)CAP_MQES_MASK   << CAP_MQES_SHIFT)   \
> +    | ((uint64_t)CAP_CQR_MASK    << CAP_CQR_SHIFT)    \
> +    | ((uint64_t)CAP_AMS_MASK    << CAP_AMS_SHIFT)    \
> +    | ((uint64_t)CAP_TO_MASK     << CAP_TO_SHIFT)     \
> +    | ((uint64_t)CAP_DSTRD_MASK  << CAP_DSTRD_SHIFT)  \
> +    | ((uint64_t)CAP_NSSRS_MASK  << CAP_NSSRS_SHIFT)  \
> +    | ((uint64_t)CAP_CSS_MASK    << CAP_CSS_SHIFT)    \
> +    | ((uint64_t)CAP_MPSMIN_MASK << CAP_MPSMIN_SHIFT) \
> +    | ((uint64_t)CAP_MPSMAX_MASK << CAP_MPSMAX_SHIFT) \
> +)
> +
>  enum NvmeCapCss {
>      NVME_CAP_CSS_NCSS    =3D 1 << 0,
>      NVME_CAP_CSS_IOCSS   =3D 1 << 6,
> --=20
> 2.47.3
>=20
>=20

--eT8SNJsOadeqt4/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmoLDeYACgkQTeGvMW1P
DenPyQf8D0wo1B2tU44LLVNcJWcO0GH5/MrrS5DyuAtWAJR3/TQbu2ulyBKVYkGD
ZJ4oY/6q4PQhGr+lnbnJGJsIUJeGpgqYXOcdw3YmkInmyqzxsI15w2TfhP/MkqfK
gGyUWj1rUYgbm/WVo2uEudYvByodCKa5keMrk/jnz5s65EMAwBnycE28uSkFYONK
E5U2PGxK32ffYDVUbHdmJd120TJMe3Y7By6OIqE10zb7hsw3tO5aSNekJpXSba2j
T1DyJ+qSEOGLCJwD3eVF/Xoks4Z2czwmUseUHsXfq5tM+YPg9D22e8ALgRkg4Bgn
vaowaq8qQCZcX2U8vqfM+CqbhiGJiw==
=5EgK
-----END PGP SIGNATURE-----

--eT8SNJsOadeqt4/Y--

