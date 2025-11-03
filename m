Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476A0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFv5Z-0007Dm-7q; Mon, 03 Nov 2025 08:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFv5R-0007BH-CH; Mon, 03 Nov 2025 08:59:09 -0500
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFv5K-0001Df-Bz; Mon, 03 Nov 2025 08:59:07 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d0Y4V3gSfz6L5Qh;
 Mon,  3 Nov 2025 21:55:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 4569E1402F1;
 Mon,  3 Nov 2025 21:58:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 13:58:52 +0000
Date: Mon, 3 Nov 2025 13:58:51 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 20/32] hw/pci-host/gpex: Allow to generate preserve
 boot config DSM #5
Message-ID: <20251103135851.00000088@huawei.com>
In-Reply-To: <20251031105005.24618-21-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-21-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 31 Oct 2025 10:49:53 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
>=20
> Add a 'preserve_config' field in struct GPEXConfig and, if set, generate
> the _DSM function #5 for preserving PCI boot configurations.
>=20
> This will be used for SMMUv3 accel=3Don support in subsequent patch. When
> SMMUv3 acceleration (accel=3Don) is enabled, QEMU exposes IORT Reserved
> Memory Region (RMR) nodes to support MSI doorbell translations. As per
> the Arm IORT specification, using IORT RMRs mandates the presence of
> _DSM function #5 so that the OS retains the firmware-assigned PCI
> configuration. Hence, this patch adds conditional support for generating
> _DSM #5.
>=20
> According to the ACPI Specification, Revision 6.6, Section 9.1.1 -
> =E2=80=9C_DSM (Device Specific Method)=E2=80=9D,
>=20
> "
> If Function Index is zero, the return is a buffer containing one bit for
> each function index, starting with zero. Bit 0 indicates whether there
> is support for any functions other than function 0 for the specified
> UUID and Revision ID. If set to zero, no functions are supported (other
> than function zero) for the specified UUID and Revision ID. If set to
> one, at least one additional function is supported. For all other bits
> in the buffer, a bit is set to zero to indicate if that function index
> is not supported for the specific UUID and Revision ID. (For example,
> bit 1 set to 0 indicates that function index 1 is not supported for the
> specific UUID and Revision ID.)
> "
>=20
> Please refer PCI Firmware Specification, Revision 3.3, Section 4.6.5 =E2=
=80=94
> "_DSM for Preserving PCI Boot Configurations" for Function 5 of _DSM
> method.
>=20
> Also, while at it, move the byte_list declaration to the top of the
> function for clarity.
>=20
> At the moment, DSM generation is not yet enabled.
>=20
> The resulting AML when preserve_config=3Dtrue is:
>=20
>     Method (_DSM, 4, NotSerialized)
>         {
>             If ((Arg0 =3D=3D ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434=
d")))
>                 {
>                     If ((Arg2 =3D=3D Zero))
>                     {
>                         Return (Buffer (One)
>                         {
>                              0x21
>                         })
>                     }
>=20
>                     If ((Arg2 =3D=3D 0x05))
>                     {
>                         Return (Zero)
>                     }
>                 }
>          ...
>       }
>=20
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> [Shameer: Removed possible duplicate _DSM creations]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> Previously, QEMU reverted an attempt to enable DSM #5 because it caused a
> regression,
> https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net/.
>=20
> However, in this series, we enable it selectively, only when SMMUv3 is in
> accelerator mode. The devices involved in the earlier regression are not
> expected in accelerated SMMUv3 use cases.
> ---
>  hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++++++++++------
>  include/hw/pci-host/gpex.h |  1 +
>  2 files changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 4587baeb78..d9820f9b41 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -51,10 +51,11 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, u=
int32_t irq,
>      }
>  }
> =20
> -static Aml *build_pci_host_bridge_dsm_method(void)
> +static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
>  {
>      Aml *method =3D aml_method("_DSM", 4, AML_NOTSERIALIZED);
>      Aml *UUID, *ifctx, *ifctx1, *buf;
> +    uint8_t byte_list[1] =3D {0};
> =20
>      /* PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
> @@ -64,10 +65,23 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>      UUID =3D aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
>      ifctx =3D aml_if(aml_equal(aml_arg(0), UUID));
>      ifctx1 =3D aml_if(aml_equal(aml_arg(2), aml_int(0)));
> -    uint8_t byte_list[1] =3D {0};
> +    if (preserve_config) {
> +        /* support functions other than 0, specifically function 5 */
> +        byte_list[0] =3D 0x21;
> +    }
>      buf =3D aml_buffer(1, byte_list);
>      aml_append(ifctx1, aml_return(buf));
>      aml_append(ifctx, ifctx1);
> +    if (preserve_config) {
> +        Aml *ifctx2 =3D aml_if(aml_equal(aml_arg(2), aml_int(5)));
> +        /*
> +         * 0 - The operating system must not ignore the PCI configuratio=
n that
> +         *     firmware has done at boot time.
> +         */
> +        aml_append(ifctx2, aml_return(aml_int(0)));
> +        aml_append(ifctx, ifctx2);
> +    }
> +
>      aml_append(method, ifctx);
> =20
>      byte_list[0] =3D 0;
> @@ -77,12 +91,13 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>  }
> =20
>  static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> -                                              bool enable_native_pcie_ho=
tplug)
> +                                              bool enable_native_pcie_ho=
tplug,
> +                                              bool preserve_config)
>  {
>      /* Declare an _OSC (OS Control Handoff) method */
>      aml_append(dev,
>                 build_pci_host_bridge_osc_method(enable_native_pcie_hotpl=
ug));
> -    aml_append(dev, build_pci_host_bridge_dsm_method());
> +    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
>  }
> =20
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> @@ -152,7 +167,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig=
 *cfg)
>                  build_cxl_osc_method(dev);
>              } else {
>                  /* pxb bridges do not have ACPI PCI Hot-plug enabled */
> -                acpi_dsdt_add_host_bridge_methods(dev, true);
> +                acpi_dsdt_add_host_bridge_methods(dev, true,
> +                                                  cfg->preserve_config);
>              }
> =20
>              aml_append(scope, dev);
> @@ -227,7 +243,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig=
 *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
> =20
> -    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug,
> +                                      cfg->preserve_config);
> =20
>      Aml *dev_res0 =3D aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index feaf827474..7eea16e728 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -46,6 +46,7 @@ struct GPEXConfig {
>      int         irq;
>      PCIBus      *bus;
>      bool        pci_native_hotplug;
> +    bool        preserve_config;
>  };
> =20
>  typedef struct GPEXIrq GPEXIrq;


