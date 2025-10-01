Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9457CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wWk-00020d-1R; Wed, 01 Oct 2025 09:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wWg-0001zT-IQ; Wed, 01 Oct 2025 09:05:46 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wWW-0001tN-9i; Wed, 01 Oct 2025 09:05:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccFSp1Tslz6M4L7;
 Wed,  1 Oct 2025 21:02:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C4A114037D;
 Wed,  1 Oct 2025 21:05:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 14:05:25 +0100
Date: Wed, 1 Oct 2025 14:05:23 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 16/27] hw/pci-host/gpex: Allow to generate preserve
 boot config DSM #5
Message-ID: <20251001140523.00006635@huawei.com>
In-Reply-To: <20250929133643.38961-17-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-17-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:32 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> Add a 'preserve_config' field in struct GPEXConfig and if set, generate the
> DSM #5 for preserving PCI boot configurations. For SMMUV3 accel=on support,
> we are making use of IORT RMRs in a subsequent patch and that requires the
> DSM #5.
> 
> At the moment the DSM generation is not yet enabled.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> [Shameer: Removed possible duplicate _DSM creations]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Throw an AML blob in the patch description as easier to check that against
the spec.  Add a specific spec reference as well.

> ---
> Previously, QEMU reverted an attempt to enable DSM #5 because it caused a
> regression,
> https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net/.
> 
> However, in this series, we enable it selectively, only when SMMUv3 is in
> accelerator mode. The devices involved in the earlier regression are not
> expected in accelerated SMMUv3 use cases.
> ---
>  hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++++++++++------
>  include/hw/pci-host/gpex.h |  1 +
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 4587baeb78..e3825ed0b1 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -51,10 +51,11 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static Aml *build_pci_host_bridge_dsm_method(void)
> +static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
>  {
>      Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>      Aml *UUID, *ifctx, *ifctx1, *buf;
> +    uint8_t byte_list[1] = {0};

The inline declaration is a bit odd, but I'm not seeing a specific reason to
change that here.  Perhaps call out the change as some 'other cleanup' in the
patch description if you want to make it anyway.

>  
>      /* PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
> @@ -64,10 +65,23 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>      UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
>      ifctx = aml_if(aml_equal(aml_arg(0), UUID));
>      ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
> -    uint8_t byte_list[1] = {0};
> +    if (preserve_config) {
> +        /* support for function 0 and function 5 */
> +        byte_list[0] = 0x21;

Change the comment to reflect the fix in previous patch as otherwise
it sounds like bit(0) means function 0 is supported.

       /* support functions other than 0, specifically function 5 */

> +    }
>      buf = aml_buffer(1, byte_list);
>      aml_append(ifctx1, aml_return(buf));
>      aml_append(ifctx, ifctx1);
> +    if (preserve_config) {
> +        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
> +        /*
> +         * 0 - The operating system must not ignore the PCI configuration that
> +         *     firmware has done at boot time.
> +         */
> +        aml_append(ifctx2, aml_return(aml_int(0)));
> +        aml_append(ifctx, ifctx2);
> +    }
> +
>      aml_append(method, ifctx);
>  
>      byte_list[0] = 0;
> @@ -77,12 +91,13 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>  }


