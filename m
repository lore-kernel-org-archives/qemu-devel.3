Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D986FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3x3k-0004qQ-B2; Wed, 01 Oct 2025 09:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3x3d-0004ot-Dx; Wed, 01 Oct 2025 09:39:49 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3x39-0001xc-Kj; Wed, 01 Oct 2025 09:39:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccGGz5qZbz6L4sy;
 Wed,  1 Oct 2025 21:38:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 25C4D140370;
 Wed,  1 Oct 2025 21:39:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 14:39:08 +0100
Date: Wed, 1 Oct 2025 14:39:06 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Message-ID: <20251001143906.00006b50@huawei.com>
In-Reply-To: <20250929133643.38961-22-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-22-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:37 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
> is enabled, RIL has=A0to be compatible with host SMMUv3 support.
>=20
> Add a property so that the user can specify this.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

One trivial comment inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/smmuv3-accel.c   | 16 ++++++++++++++--
>  hw/arm/smmuv3-accel.h   |  4 ++++
>  hw/arm/smmuv3.c         | 13 +++++++++++++
>  include/hw/arm/smmuv3.h |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 8396053a6c..e8607b253e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c

> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a0f704fc35..0f3a61646a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -300,6 +300,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
>      s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
> =20
> +    smmuv3_accel_idr_override(s);
> +
>      s->cmdq.base =3D deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>      s->cmdq.prod =3D 0;
>      s->cmdq.cons =3D 0;
> @@ -1925,6 +1927,13 @@ static bool smmu_validate_property(SMMUv3State *s,=
 Error **errp)
>          return false;
>      }
>  #endif
> +    if (s->accel) {
> +        return true;
> +    }

Feels to me that an early exit here is going to be slightly odd if other pr=
opoerties are added
later as they'll have to be added at a specific point in the function. Perh=
aps.

    if (!s->accel) {
        if (!s->ril) {
            ....
        }
   }

   return true;

is going to be easier to extend.

> +    if (!s->ril) {
> +        error_setg(errp, "ril can only be disabled if accel=3Don");
> +        return false;
> +    }
>      return true;
>  }


