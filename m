Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70235606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XHzauXTz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjuJ-0007xD-NJ; Tue, 27 Oct 2026 12:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xLju9-0007v2-HL; Tue, 27 Oct 2026 12:20:06 -0400
Received: from mail-westus3azon11011056.outbound.protection.outlook.com
 ([40.107.208.56] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xLju7-0008Dc-Ba; Tue, 27 Oct 2026 12:20:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlgTVDthVMKI/XOoeFShcwnp9k1bKb0GmwG2D6t1iPPcTfRhhKVRlJl6tHB7Eg9rCy6p+mejWlYWzhZshahZtUR+OvvZTajOvyLCP/j30oDE2EON/wyEaV6ibPaJ/0yB0KSmFDJ1pwdkSe1DA+i3tN1YLKfY8oYyCpZmdjni+dTAJ/a7gIYPggb2pN172ki/8VUpmhTSV38GLXP+SCFbJ1VW2oSHQ5nUz0SUNYkK6GwnVYYpqxWFVZEEItqod5EDmpe0I/747OTRRxuaC6//f7CgVzIksFUEYzOLbJxzzfInyqJwkOvA21K2rK+YRuCf2cvZyTKA6Iumml6ya1D2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utstp6fHOhNyTmzSA7/pN7VoDPJ8Xh+XDXLgr5Jf7I8=;
 b=MR/67kZpol5Eai/KE3FgTQfymglG3lNrWjRsphhxdV56N1WOdS1c6HNDj3z74ScwdhBlcVKpdLxm1v36i44TPIgbLmRdNg+sbMh3Y02oy65c/VdWg/TSME4UEOMyeH1h7vwfvw0KuRsmb8iSsGH2IyJY5+vTc/rkmI2tDifsYwTSV1eZP8xMwfJ106Qx/NTZ1svQ7LuBhNnyaT53seN1Motk8HTHADwaJiFTLJOqr426nUcv4pJrxrOmedtM5eKTFvdUoPIe46wvVv/6AikTTz1GZ061zeqGYBTd99p2YpITt2DRweawECR6ltXx39q9mDYe8WPEJji+EXjSPt6O1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utstp6fHOhNyTmzSA7/pN7VoDPJ8Xh+XDXLgr5Jf7I8=;
 b=XHzauXTzOCwm5HHD5hf5cDRXOk1Gj0az/Fd0FlvWWeJ9lE6vU2DSTO1Z+3FH9G/YEB2MaqLrzsU35UNBpX0sBF7qCdLF19FfZCX4FddEfCRpSGdvLxGJ1a+mq/jI8GE82ASJDSRGtv2+Fw3ElAJLxOUrpku25Q3C6IMaYVdZI5JJj8cPq7DBcz/HiwgwENGS1XnuRdVCfElEjjcNNArOvoOBD7DulOzIK+TO3NIdb5ejhd4AM8JWdguCTD4p5BFp5HeB2JgPOAjwJFuTr9lLl6F2pNvXlWeMIhXUBtUO0gSfRNKESiWRDx0dy/+DP9zYWxhllMwlC1ksrXTN6tP+hg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:14:51 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:14:51 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel@redhat.com" <marcel@redhat.com>, "devel@edk2.groups.io"
 <devel@edk2.groups.io>, Alex Williamson <alwilliamson@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
Thread-Topic: [PATCH 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
Thread-Index: AQHdRg0K8aip+rCRt0GRiVP6QSFzorcRziSA
Date: Tue, 27 Oct 2026 16:14:51 +0000
Message-ID: <SJ0PR12MB86141EEA7C2A286558146732AB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-5-tdave@nvidia.com>
In-Reply-To: <20260916185554.917526-5-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SA3PR12MB9157:EE_
x-ms-office365-filtering-correlation-id: bd012c4a-2850-4d4e-22f1-08df34456e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|6133799003|22082099003|261026140227099003|56012099006|261021123027099003|4143699003|11063799006|10067099003|261009223027099003|261022075727099003|261021121427099003|261022105027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: nOTouNZD20Y0JggHzduZ1qj7HsWYM9LpQBrwcmxlk8kDu8kbHt9wdSyO9wuOTx8Lb8FpWq1q9ivLal3BFjl6cS/TwaT4P5ar18WbrWKEOjetUglDJ9ymxI31Gqgg1s8Orj4N1mMtSGZwxLhb4EIr8gkm9PkBUqjWFpoFR3gBo6tU898GLP8eDV5z/ueEkcgd1FPM/vTJpmF0AHks89E2e80bpbk9I9mHy06RPuWd0/HoDxZetIzSzmSkcoi/Pkb/YEGc8f//g1TbpUAG/WnVTWKly52HJzaHECi9NJD9DfKaL9aY2PFY3tIp0CDSfRombp2P6ufE5WJoHN43G9TNExc5+1IwhU4A3dB0IYXg7Ek/+PHaDZqiCFauDjmxrsi0M/30hBwefu4qX2nnGv/MAFz7mK12p3ET2X6KMfpQG1l5f7JCyJcUIExQct2H1Vk0NVx6C8f1FEaJ7FpUYQ5fwj/4jBq9IIar6JgcIOvWw7CU27L7RqPnmz5b8xm7Oh9fID6cBrP8xrc8wASJKsohDlu6pwdvpx77YjpQfTG9kCRkdeguc32naQFD5okN4nfkkq/FiYM3dbtnh+bet3AYWdhkxhC+RgFLJxuaDG/IifdzN3Psy3j6T/o1fTfHxwgCvaYiPZFPWMsLCBmtToPXZZUTCQh750O8C2MPpDzLuoryWo8h3qwrxLaqFfKD7yl2oColnL+JP/MBv+9Vb/9GRjC+8IpEkstQZ5UAN2OhRsI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(261026140227099003)(56012099006)(261021123027099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/AIGhzvYNyLEeOyF+AlX4BzdA8vV6Km0WCoZ0dHu/kvJqG+LsvflwWRTTFf6?=
 =?us-ascii?Q?Nx3HA83IB7qFH3fsPZjz54eKbstQsy4IMobufOW7YVB3SivdrDj5Y5KaZeW9?=
 =?us-ascii?Q?Q7J3QSczgUFP9uYHc9xzH/fjvNEzrjM/nY2BR4Ghu6SOw0WU555C9Wog4fJi?=
 =?us-ascii?Q?2gwiO8ZSueTMc9PWgH4jxsqlHejSU2yWTpr0ceU21Ob8dYsmPNF+k2dkOr1B?=
 =?us-ascii?Q?6GlU6bcZt1o89AnIneUeysyGaiKhrP3RFv5OmE3694Eu61tG8hcH49da81+X?=
 =?us-ascii?Q?lECxY39u829XDQ5QF3jToBdX1D5cXawVnznzcLBuTh1pfz+ZJ/tavoc985eH?=
 =?us-ascii?Q?fj3VtOKu10pMVS/i0LZ308LAQ/nDDJyoksdSfyhZizRy76/ywBWbbkHSMQzM?=
 =?us-ascii?Q?f/skz9r0ew1eJ1i+dJwOnXGHR/LtC4JFS9OFZ96XQaKtoPPZp1P6rJc3CEIw?=
 =?us-ascii?Q?P5TtqQgCpCMbV8oQVEGfQroJYSFlHgpBNgftyq/P8Sgwnz7OwkkypjKgP8im?=
 =?us-ascii?Q?w6HkxnpBm6SrjDKvvnF6YlQLnEFSMXc9+pFkG9ZB2jYGl+J9LipLOABRq2z9?=
 =?us-ascii?Q?CnCfKCyk/nqx0iO58kSMYWaixFPpyg9XpiaUNbN9aAMG3ciyhlzcGjXXpz72?=
 =?us-ascii?Q?B+3DcrEfh6lRQ6qRA81QFKZ2U4XpXoH4hKVt4jPC+WtgW/ZYMxVda4TQ2dq9?=
 =?us-ascii?Q?nDfp/iF78yvDDp3gYv6MmQ+qzldmjRqK9s+FhBfWw016sFrw+7pbIMVGGAT1?=
 =?us-ascii?Q?nYvFDtlc2w7V0CilrgMbxYQiYp+rY4JtZqXjFyexcC65a3g8nWm/bQshfU2f?=
 =?us-ascii?Q?pfDFku1Rdszf9wef/IRMs7hXxFgbWokKEUeKqmXHb28eCdQq7x1PZDcOJlgy?=
 =?us-ascii?Q?uwrBlpkIpwksfliQ5zJxu82btJ+OaLOpIhfxKkQK1GP48rAiKGOPTPwubpHM?=
 =?us-ascii?Q?TM+5B3oXDsen2+TpEgbduBGhlPL4KzCC1vLa7ZHgrQl9dBYEg7pGA8cgHsZN?=
 =?us-ascii?Q?yXLX0x6XECPF27sBUVgwM3GVx5znIZo0bbZmwEI2EP9lA7Wx3fOHGXIrbi9j?=
 =?us-ascii?Q?r620NxWyf9wcdRDaY1+X/IEz2DMvshhXdZERw0jwdNnGriR+/RIul3eUiR0n?=
 =?us-ascii?Q?j5JrI+wn8GQSjJ3Hkz8JEOfIbqgSUzho2x1/9mjKWg62IBks7T+1o2eTZqR+?=
 =?us-ascii?Q?yLVay7EKFoKblXBMYFaPDg20/EfFbdGgmORZfeEXfLEKdAXxFTJp+2HmJqvp?=
 =?us-ascii?Q?Dk5XV0WIMlH0hzSxOTuKvHW90W7NdeGQEwMZQ6g8zwRL0/s4FHBikt2ZL3/H?=
 =?us-ascii?Q?N3Cejtx/7QXF6aBV5rHOzxcu/EMu4qEmQI296zL3MvplTtQuzRWsceEwQdDg?=
 =?us-ascii?Q?WCFcKS4vOqcsxEhGJoxjVfFKKaMfd8hV4amJ4z6rBQ3kKqUhw3x7NLXhw+/B?=
 =?us-ascii?Q?My3vryLICix3HjhpSNfwQ1uFFa7b0b0YwoKD0gclM6qowP2FcvaQtoAO3/p+?=
 =?us-ascii?Q?UMqxvaEQdPLOKktyCzJKhqNhf/Yl1CZHwpDTiTI0DLWGSokKoVJMfw6W5N+9?=
 =?us-ascii?Q?GyTKAqAJNt8s0jqjyUvCZxXxou29gfedsayH1jMZOhjJ05qIc9Gs56F8Hv4S?=
 =?us-ascii?Q?vdLdyDuVyQbENHnA3iAHF8BihAuBDzvFbtLVL/VMQ25HBhJtyxW/ztd/5CpR?=
 =?us-ascii?Q?lTVrd5mgePNOEVpD0HExsLdkLs8oFcdca0ctumhfgAnRS/mdsgZaQ8bwR7Kg?=
 =?us-ascii?Q?utKVwLcvSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd012c4a-2850-4d4e-22f1-08df34456e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 16:14:51.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kqocSn/rWM7kZ6Def2CzMQwJcw+6X9X64u1dEIfxpk/L2I5LANr6fpjsyLXU5BGcogathdGsO3PN8mxXeRkZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
Received-SPF: pass client-ip=40.107.208.56;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Tushar Dave <tdave@nvidia.com>
> Sent: 16 September 2026 19:56
> To: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>
> Subject: [PATCH 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
>=20
> Export fixed BAR metadata from the virt machine through the
> "etc/fixed-bars" fw_cfg file during machine initialization.
>=20
> Fixed BAR placement requires firmware to preserve the PCI resource
> configuration established by QEMU. ACPI provides this via the PCI
> boot configuration preservation mechanism, _DSM function 5.
>=20
> Reject fixed BAR configuration when ACPI is disabled, and request PCI
> boot configuration preservation when ACPI is enabled.
>=20
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/arm/virt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3eecf094bc..c5db663858 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -95,6 +95,7 @@
>  #include "hw/cxl/cxl_host.h"
>  #include "qemu/guest-random.h"
>  #include "hw/watchdog/sbsa_gwdt.h"
> +#include "hw/pci/pci-fixed-bar.h"
>=20
>  static GlobalProperty arm_virt_compat_defaults[] =3D {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> @@ -2438,6 +2439,21 @@ void virt_machine_done(Notifier *notifier, void
> *data)
>                                         vms->memmap[VIRT_PLATFORM_BUS].si=
ze,
>                                         vms->irqmap[VIRT_PLATFORM_BUS]);
>      }
> +    if (fixed_bars_write_blob(vms->fw_cfg,
> +                              vms->memmap[VIRT_PCIE_MMIO].base,
> +                              vms->memmap[VIRT_PCIE_MMIO].size,
> +                              vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
> +                              vms->memmap[VIRT_HIGH_PCIE_MMIO].size)) {

Should we check for vms->highmem_mmio here? The memmap entry still
contains a base and size when highmem-mmio=3Doff, but the aperture is
not mapped or advertised in ACPI.

> +        if (!virt_is_acpi_enabled(vms)) {
virt_is_acpi_enabled() merely checks that ACPI is not explicitly disabled. =
With the
default acpi=3Dauto, it returns true even for direct kernel boot without fi=
rmware.

Should check vms->bootinfo.firmware_loaded as well.

Thanks,
Shameer


