Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1947CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaes-0002QX-EC; Fri, 02 Oct 2026 06:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCaer-0002QB-9y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:38:29 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCaeo-0005Kj-Rz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0MfRz++38ssTXonv1Z7hX5nZBO5rYxE/IA1AHHaIDcc8cc7FUbsO8fsj2k+Ym6Ht+MIhjsjrX4Gq44RUxhztKVfRwC0MwKsJ2ywl/B4vfBKrUnlnb9f5d1T24kS7TsehBxf07AS0K4ruuxuXPP4pgk5NBHtTGkmUp1tqkh9YZKngrJ5cRc76NizNV2t9ok6q0jVr++hQyuDTrHFYPd8Ni5Mw0l1ois0S4Ffab3NqQh2frAC3hM7F5NXqBu0UKs/eCffUK5/aS9XhmJyMe8KEhSpOVDJbbfsFOnB7zMm+KwKbk2olHg0pb5m3x1nEIQtVL9BkRlGZwNKmwzsFqfs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqiE/4s+0ZR6sWV4yMHXNyLRp+RVyQgWIBWN46dVsMQ=;
 b=Ad30fbbmBTATsrSJgzA3hpXZX7PiFddHPc3uecdtq5RcHD0HQsDR6aQzEbU3d/c7/NuyhR2VWcUeEjQDeMoEaz0hs2Rjeo2boatt/EJdm2vGh2wJ5StcD/Lpw+xyUEHBxwNDb1nw0j9X42Ov08YKeV2VvP6W8oNjL5JpJLtNlaQqbFZ2F57GDBruCPXzaXII0JavfmjL/TaP1Uil/v6muIEFoBYuEjb6/5CFXKgqnHSGFuKg9KPmtK2svPjDHBoXex0etQvMXQgTC7Co7hfL38C/4pOUQ1oiLEDIFQzRttHAY19IOJKX1e/nVUp4Oxbj/4tmE5XFquZjJ70880PAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqiE/4s+0ZR6sWV4yMHXNyLRp+RVyQgWIBWN46dVsMQ=;
 b=E3OoiUssbVoKf5T736u542BJ6TwuSuPxBTGnOqChgaGe8l3CtGJU2n3onNwA15XEhpaxv3+Ogw+auC9PCUKjRTCasc++pTyXq4VZFY/6TXjaAX1FOhbShuMfw9ekT9CrNhJWSlZKjdcVhwTpgW19cWLqKA0dck6nJEGlOYFNo83msj/393WW76GmSZgIlD0+YG7p9OOx0D6f9BDJuZ5T53ZrViC9mHbSOJsyQajL0HT3TtcbwjcdSt/UhoFpZf2SS7ZTyxYaxVF1MbL7VHdfxpn2pwqJFQOa0Rohrfzc8zAhw8db7fb0LVv+sdRODHePDCm9Gym7OMdw4H2YOgQpfA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 10:38:20 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 10:38:20 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>, 
 Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 1/3] xio3130_downstream: Add ACS support for downstream
 PCIe ports
Thread-Topic: [PATCH 1/3] xio3130_downstream: Add ACS support for downstream
 PCIe ports
Thread-Index: AQHdStxellRdKy3FjkOoMiDPN/tyMrbqGt4w
Date: Fri, 2 Oct 2026 10:38:20 +0000
Message-ID: <SJ0PR12MB8614AB65D581542D1D9B3CA4AB892@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
 <20260922215008.2554402-2-tdave@nvidia.com>
In-Reply-To: <20260922215008.2554402-2-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|LV3PR12MB9120:EE_
x-ms-office365-filtering-correlation-id: df47b721-2729-4c28-89e8-08df2071470a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|38070700021|10067099003|5023799004|11063799006|6133799003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: lLia+GSSjSEGjuwsdNcARk5wWO9opOgu4ShIbbNV6a3vq2QeJecHo1+B2CshNaEsAiT6UpCnRIx9+Pu5YwoPZhJKjEVS/vPbbi8KGmXmqggbWJxpdQaUcLmGQHfU7Lhg7eg10osLGuOb6IW+mm3EOhrP6Y6qEeNQ3sZrKFkOfMBoycb6ycc8y/QUFgV9bgebwVJHEsmiDtjCUyYTYmaOIPay4y4nzx9+oyfV+GsuPIlii3DdzNPLY+ClE1pwdSkkZkzHrbjptAgRqxW0AaFyDP+TQKE+0iMo2XLLfx5wmb41q1zSRYjPhmu1J8FF2/Du0e5gR41LA6i0JX3yn6Ks7VHIZ0fWd4vVei2inHi5+y7RzJWHYqvQ0tvODArqrDIwxaYTeYfIV4z6ljSmNANsCmL4IIViIMb2nfAmXLIYuvTa0xgIFhtBf9677yv4IcjQ3E3818EiY+gRqAOKmMZSub8bLDecBtbk4Ts2w5BoaodhsOYnc+LT+3D1SF2gLdwdLNh78fJARALflKELZVYsFU4q7zWZtPyjf3cp6ZZcY2sRrhApXeHZVbbYIG0FrhuPxAyPcWyetOth4xytji7lEDxfBtK8Yh/i/DwW72AYk2J3V1E/b9BBLzzqyJv33YWE54M6S2F6CsOa6Y+EhK3Ti2tEXxvSxH/c7H7mwSoh2kCI3mYzYczF2Oo1RdDyszesGHuOzk5vbaGCju+NpCROoVNMfVsCwsCHP2Tlr9qt92k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(38070700021)(10067099003)(5023799004)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n7H5xjlaQGXse9zcu8aJ0YNCr9o7gX7Pw4nJuTXTaGITIz4lNE9fOHgaa6uS?=
 =?us-ascii?Q?K+QA2goSsRt2TFfFo8nP3Y5jOIeTUVWyeUM1OdhKrhsq33USibaTxY/2M5Tm?=
 =?us-ascii?Q?HgIZAYQXam9UUQU//G91Fs6/co2Zx8czl0RPBBwMFVbIGS13qTZmlBU5u2mf?=
 =?us-ascii?Q?g3z5OIUQkAO1coDCKrWbtY136WmZGVlBapYRohbnscdwO2ADoECj+4GebSuO?=
 =?us-ascii?Q?lTrKFFxT//JOIthCEUuIbnqcNs2sh0ni5SPAr8za3ChTEUy4Z+on3qWYHVQS?=
 =?us-ascii?Q?OMjHP5RL8UnBcThVps0AqYu6U6Q7OkeVdzx1MrhdAxIUUNLnaVbduyzalPWW?=
 =?us-ascii?Q?iCK1tcKEk1iHXJ/WNRdjF1sBMxPnbL5cHpbb+FCi6M2Jc0pSWr/8VV/7PePd?=
 =?us-ascii?Q?m1ieiideE8evbuahIjMcuHglVe8hMKa69clRv2wPX43dEVtSfXzwpIJrlPhC?=
 =?us-ascii?Q?b1uUCwAcETcPyP0D273FcWJCHvF38jdHkHlLmdkUNRkSZa+5bZi0GLlxGShm?=
 =?us-ascii?Q?p0d8BORJ6AAg+dBWDvJ+4JUknfF0M/kRpJbH9XwykEoo4woj7+ropuRIzfWL?=
 =?us-ascii?Q?VBSvhmJcZTN3IbaJz1H2LiuxwaGFHRvUOhNq6UyPe3oEIzPCXxoWMS+eAmf8?=
 =?us-ascii?Q?LNju39juRJWeOV9U4jKxopy65CKTlqoRVtd4oMKYj5N2xHYGpl6bNQNgT4TN?=
 =?us-ascii?Q?gjRfjS7k35Zc1g1t31pv87+krJsUxwVWSJL/2TtxqGoFAUch1B7eWLzTTcNx?=
 =?us-ascii?Q?MAzQdTL3WyTZBjWBrdbkklExpt5Cpq2VT3Ubl3FCif3auiyY/STRA+VPgRcC?=
 =?us-ascii?Q?z01H8oU5PQ61qwr2RfGFTYBN9qG8oTBWqRrVFOc1rAStVPTJD7XJSvQZ5dUW?=
 =?us-ascii?Q?Zzxqta+2hACM5bG7GnWS1VwLoN8FqGNg3XM13Fr/FfrPvBFfEBRrBl9s4nHt?=
 =?us-ascii?Q?qac+uWgLbn/qbE9oDdSxmjGqjyGZxhYxV3t0BnziEw1/HrgO3UdqKBMcCmek?=
 =?us-ascii?Q?PD/czT7eqihZykE6Ci5/av0hc5Gg/5DgXNQY2ATi01CSgot6HjtWRJ3PY8HY?=
 =?us-ascii?Q?5rW0MkImrv0I5kKw9GpGRTHpjCSXlIBNPZyJh9SO0Nm8vllnZ/QaQZWS7UPI?=
 =?us-ascii?Q?/Y+9w5T24TOeb+aXGXSvM1ae+O6PCi1y+KRvUBDW/t295ESPJxemW/QcTyU7?=
 =?us-ascii?Q?fparvKNgKYSoyUvUs5x6ruTuXHqHdwx3gNuJklGGpVID4Hb6nJywpapqSE7G?=
 =?us-ascii?Q?ym3Uy2+TYplU3eIz+N5A0WxWBNyxsK8QN8iTn87WxfxCJe6ETMcwGcNWUCC4?=
 =?us-ascii?Q?aybZAH5IA3kLPLXBtg5li9Tb825ccOyUYMHBERYrY6wmhk5F1B1I6C05EmtH?=
 =?us-ascii?Q?cBdnvHvLWJVJApkD5hmQUfwRHP1RGNXUIDLbjXUOktgPnE1bblAUkONlWqrm?=
 =?us-ascii?Q?+PTumSpEZs4PQiFEYJRpXQDTWcFfSetY23/sAQHI1nG9wgPfkTKfCE3xTV1P?=
 =?us-ascii?Q?BX2VX3w8CBHdu3LvKYysdfTlfxc0Hau1W/iHD4j39JNUBTMQK4GPNyxNKBO4?=
 =?us-ascii?Q?zEI1ZvcPIKJJ0imMW0JNYlrN9QKCVWyP6QYsGf37+ilm9GCrtW7TkC3gOeYu?=
 =?us-ascii?Q?QgA7X5E0bez7kn9r9lwH2YND18GzYhrew0ol1ePH3jOa2kcfjxmwMY1dewRP?=
 =?us-ascii?Q?i3YynX83N3kogncTtKvEnE+wE3RCxjn4k6Kv6J+YEYpENCU8m8NSzDzZPW2E?=
 =?us-ascii?Q?a8v20KynYg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df47b721-2729-4c28-89e8-08df2071470a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 10:38:20.4757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkzIFJnYM5v8G2eLDMPhNiDGFagzmykiO1hFSN/OFW2RuBzpM8McApC7x/myqxk8xtF+VZY7XEc4uJxBuBV+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Tushar Dave <tdave@nvidia.com>
> Sent: 22 September 2026 22:50
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; philmd@oss.qualcomm.com; zhao1.liu@intel.com;
> Yishai Hadas <yishaih@nvidia.com>; Alex Williamson
> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>
> Subject: [PATCH 1/3] xio3130_downstream: Add ACS support for
> downstream PCIe ports
>=20
> When a PASID-capable device is added behind the PCIe downstream port,
> for example, an Nvidia GPU, the PCIe downstream ports must expose ACS
> capability otherwise PASID won't get enabled.
>=20
> In addition, the other use case is GPUDirect RDMA using Data Direct
> that must require special ACS controls at the PCIe downstream ports
> for P2P communication.
>=20
> Gate it behind a new x-pcie-acs property (default on), following the

Why default on? It only matters for the use cases above. With it on,
a guest with a vIOMMU behind an xio3130 downstream port may see its
IOMMU groups change. Is that intended? If so, please mention it in the
commit message.

> x-pcie-* compat-bit convention (x-pcie-ext-tag/x-pcie-err-unc-mask/
> x-pcie-ari-nextfn-1), so older machine types can disable it via
> hw_compat to preserve migration compatibility.
>=20
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/core/machine.c                  | 1 +
>  hw/pci-bridge/xio3130_downstream.c | 7 +++++++
>  hw/pci/pci.c                       | 2 ++
>  include/hw/pci/pci.h               | 3 +++
>  4 files changed, 13 insertions(+)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 92f7be52a1..4fd48f594f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -43,6 +43,7 @@
>  GlobalProperty hw_compat_11_1[] =3D {
>      { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>      { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +    { TYPE_PCI_DEVICE, "x-pcie-acs", "off" }, /* Added in 11.2 */
>  };
>  const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);
>=20
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-
> bridge/xio3130_downstream.c
> index 0c3fed3053..87ba30eb36 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -40,6 +40,8 @@
>  #define XIO3130_SSVID_SSID              0
>  #define XIO3130_EXP_OFFSET              0x90
>  #define XIO3130_AER_OFFSET              0x100
> +#define XIO3130_ACS_OFFSET \
> +    (XIO3130_AER_OFFSET + PCI_ERR_SIZEOF)
>=20
>  static void xio3130_downstream_write_config(PCIDevice *d, uint32_t
> address,
>                                           uint32_t val, int len)
> @@ -60,6 +62,7 @@ static void xio3130_downstream_reset(DeviceState
> *qdev)
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> +    pcie_acs_reset(d);
>      pci_bridge_reset(qdev);
>  }
>=20
> @@ -111,6 +114,10 @@ static void xio3130_downstream_realize(PCIDevice
> *d, Error **errp)
>          goto err;
>      }
>=20
> +    if (d->cap_present & QEMU_PCIE_CAP_ACS) {
> +        pcie_acs_init(d, XIO3130_ACS_OFFSET);
> +    }
> +
>      return;
>=20
>  err:
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0efb4eb4bb..807729ca75 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -105,6 +105,8 @@ static const Property pci_props[] =3D {
>      DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
>      DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
>                      QEMU_PCIE_EXT_TAG_BITNR, true),
> +    DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
> +                    QEMU_PCIE_ACS_BITNR, true),

This is defined on every PCI device but only xio3130 downstream reads
it.  I think it is better to limit the scope.

Thanks,
Shameer

