Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C8606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YGIu2Jny
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLk1M-00013s-9K; Tue, 27 Oct 2026 12:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xLk1K-00013U-CE; Tue, 27 Oct 2026 12:27:30 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xLk1I-0000bv-Hk; Tue, 27 Oct 2026 12:27:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOt1HFtLibKF+EVEl+OhQIRbDWtOR7IbWHCq7041LW5S926oz776uRxLMNnfs9+rtZQVZ7QDVv/Y2fMbhMGRbHrl2gvWCOarhN4NfFahwR6pcfRzt0ldffV8HoafiRnHwDTDRLv4s6YKUKnIKOyM/Eu9oCFdfmfPa7zrJlwfViuTO9Zd0qo9vHB4tdmRWZ36/Jc6++pUl8AfElAxi+UpxlMWxLBG5Z68qgUP58M3iCDxSfblMloMIpF7ViSqhlCkh77Pv8AsSPFAi164Qbq4jFDaYSbn4A2A/OfIvkJiQAu6ot1wd4iqI17naaXwjM4JuyCZ2k7TwevCqMBg1vtmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV+k10CgmWCGNmGAFWvjQwGMsvK/nWO+C3E6k4UajaY=;
 b=sHbi8VbmQGUWtzZoTmj9DzkZd1LSZvGn6J+ZR2U6kN67+yCAyh190WaQOC6saUSm8HuiwCjNJrhNMpS0rcacVJb6v8g6nJT1mlu+KPO05cVYYZTMjuzMCf2pbk7DTntlex6khHheRM5HewNwAlQ2hdwt6xLhUMBk3xhqlDPIrERvFu13vlFOSgdApHGjYxSU8HNhm3KqffRhpeSJS6kDnm47YMgfQ0MYeqbgaAm55APImf7Ai/0RI2ESjWA+G3Vi51ske4Q+K13OPZ9YltGfFxh+7lHmvp5GI/Jh9lLBx53XxiLJE700s1gQmYaiR3QmCgjjo7Z6PzUTlXmhGDhARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV+k10CgmWCGNmGAFWvjQwGMsvK/nWO+C3E6k4UajaY=;
 b=YGIu2JnyeEHxPEDyx+Kc0V8ARgmqWOIgCVSGnC/yjPw00ObZRYgPYvev0FTRRXZh3UdeqdriJjdVp4DCmHMg17JyuUDDg2v79LGMl8GN1TidyVg9fNP7XmRHpQBm7tWvMsO+ZirwsYfPlXdNjqF8WUNKNZLBFzT2GDd4pTrMylWOLFZ1X+sVhoak/FnFF85QC9RbC0/0TV9ifjyWnG5Ltdu1rccfd/sNe85svFuuyneRvuUGE4oyXezVdcyKrn66zWQ/YgNiY/QEA+rYNsr+xWIsOtCIHj8q75Ihqss2/9jjlBnxTHwhcoIJsftvMHNCKiyFXhw8vNYeLPtzUoy9Uw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:27:22 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:27:21 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel@redhat.com" <marcel@redhat.com>, "devel@edk2.groups.io"
 <devel@edk2.groups.io>, Alex Williamson <alwilliamson@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 5/5] hw/arm/virt: add highmem-mmio-base property
Thread-Topic: [PATCH 5/5] hw/arm/virt: add highmem-mmio-base property
Thread-Index: AQHdRg0KNIoA9lDLQ0+NjIgZRbQt57cR0gsQ
Date: Tue, 27 Oct 2026 16:27:21 +0000
Message-ID: <SJ0PR12MB861457018E7FB359517B200BAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-6-tdave@nvidia.com>
In-Reply-To: <20260916185554.917526-6-tdave@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|MW4PR12MB7309:EE_
x-ms-office365-filtering-correlation-id: cf1bfe4b-7054-42fd-adbf-08df34472d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|4143699003|261021123027099003|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|261026121527099003|3023799007|38070700021;
x-microsoft-antispam-message-info: rUW32mTC4pVWYu/8DS8akP8y+i2itFZQcaKLx2kBXVuFEhKOf/aMS4Pyq8+aDYDUYhTvJZSE3kpzQOKPxvYOJOMfyu1Jk1Z2wIC51QDGKPOaDuhlt1ljya9bxh6hUCIFSDCFWybpPhCNwW4e+ao5CwRcqxLOfWmOzGlK5Lip4CCfDLbTZcxrTUL7/EGn21cBp+yo82bEjbEeF7jdm70lV4omAsoRh5SDxxTwcsR6JvwQjAqy3xi3MvOgJpP7Pawmj/u4AeMXDNB7TIxDvd9H3qG5RruqsT6v1Wun2FhBPpwquzcunDzORkVTuc8jQt8YWVJhCAr+4VYCCENzhpMASbIbsjjtN91Xm32gPIJiPXi3lyAKtTqUO57Uq/GCkdQdV7FhLI598aeoCuGBKsMG3a6iDNM1e0S6uFE61wU5kJ2J6hFUVENTh0xU1HMlaH/Ys6zkybT51wFhFGZUESTv9VYdULw8d51Fao2jPadun0lqpUW6g3BBCb0Pdi5uZLXOKnNSe0vDy/GE0Htyf0hEqd+985KqYj/4HJ/+EXBHTvdNWnxOsYUla5u9+6EzifbxOPM1TKa9vFD2+neg2XaR+0ysghupSddlALyC/weeYsvYJXRwNv7mtp3Kgc9mtYwU07jfK5Zfxrid9nekhswMxOKox3bdYflbRsTfIx/ZJWezQhScFutuHGgQRw4OIpvR5WsYy34nQEK+E2yMFgcnFY1lj++nIo8xARtpTB1dvvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(4143699003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261026121527099003)(3023799007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fl1ZTtrgvO/oePTkwvI6tB58/VLNdJN7R/puDvltNScXZxhx8YcXRXAmvjSt?=
 =?us-ascii?Q?3xCSETCGojGSSv3ZRLPrGdL4vXDty4BEuav7kKsh/J8Zl0s1JQipLq5dCcWR?=
 =?us-ascii?Q?+Qk/KuPoztjhKn6fllTNcXIE7VN0Brd8zb7gcwth8zd69wgbh9inhlMnOGsD?=
 =?us-ascii?Q?sui8B5iDZ2phU0pK3zbSWnX1FXrkM21b8HILdhJHSo75q+G5o59wB/VwplzP?=
 =?us-ascii?Q?F1yfM3jCh2/VltrRLVeJ+rVUp5TZHHcsHBThrNtZaalepHPcP+7n9i5OgA7C?=
 =?us-ascii?Q?C0agpqUHaHi32e/YI+GeknRzmY7g/Z5LGRJqRaGScdxiI/2j5hEBmJsmZaRg?=
 =?us-ascii?Q?bu1oRsrT2wvx/l+kuwoYryLGh6br9p2MSI90DMwvQfPGRNMN8vEclaFOm5IR?=
 =?us-ascii?Q?HZjn2SyuTyjYhDvqBKKIY6vY9gBHQUbb2S7fpz1Y3GoqeAyxA30w4+18owfK?=
 =?us-ascii?Q?4fXl8HAlYrs1I7kpSd5DglViHJ1hh9Ufpek3dVdFUHWLt0meV2uxEokWDm5o?=
 =?us-ascii?Q?Lm7IvxaL/d2vcxAEav48JjwLvdmt80F74ub/xZaQ/CGWsj6DWqUKW1stkWZ8?=
 =?us-ascii?Q?RXYBBPb8F+hIsNIJZAZavN0fYJ3W6Zq4vVaF0mbgnyhvyvOikM69NO/U8Fz2?=
 =?us-ascii?Q?HGAVHDNxaV1COBR0BOrpbPYIpB02Mo3SC/woHeOE1we+z1HfJlS7jmI8VUXs?=
 =?us-ascii?Q?C83c/1d5fyqCgxfHU6r6GyGRmUSYKb5/2sEDhLzJxoCtnmzONBQJdItYURKk?=
 =?us-ascii?Q?CWS8XzGMCcQP5X2+ZiXhPyeRaRtzzC6LqpYUGaRJUYoc0H6KQi+nvc4GYN3H?=
 =?us-ascii?Q?IbaW0FKIowSKzgjbHCwOvi6puBzRgCbhE5O5WJn7atScLVeRXtLYp/Q1XTrj?=
 =?us-ascii?Q?hZa0gQ4JEzwCy+ywIZp2vptfi2JCi0XaPeexzrE2YO569vwm3C5H2fhuKA8Q?=
 =?us-ascii?Q?Wk15GfAz1eqgDSjM6pTiEOCAhw/8b8HAyQTKDsf9gAIbh3S1ATVDhxL5zqiM?=
 =?us-ascii?Q?tWaiU1xFRjuMtub106olihkLZXKbCeP3MZCWobsZssPGj1m1yUdUwdtksy+b?=
 =?us-ascii?Q?bUW34zvMQs9Nd/f6ETA18QycAwcQrG1xGAqMWgvduaDpfSgZhgrKc7qKeyFp?=
 =?us-ascii?Q?QbccZin7Gsa3RMnqODVlGblT+uH4clZsQYNQ43tDIa5M8W02V7rAh1McKHrJ?=
 =?us-ascii?Q?vBkhLUYUiF1nkoRj12UdjVEGSHS0pHG1G1eLws4n9kd3DHJ38Fh8XcvVyleT?=
 =?us-ascii?Q?xgCBp0yJT/o4SxOAtygRUfXpFpjzR57N8q3VzK3aBwLp/LAEc49qFFxtsG9G?=
 =?us-ascii?Q?4SApkLKTC5vtWz5yUx8WEpSR19CxL2J0A9P89QE/+eFd1/bdrvSx0w2fx7C+?=
 =?us-ascii?Q?ncuLA9SID4HwWeXq9jjUck8R7YjERSx31vkLMzX4JXKHqjNnsebecPnMWRka?=
 =?us-ascii?Q?V3PX7nCXPYol7pMHNqWCobDWs3zKTaZxDQ+kK+qTbNxw/A5C+ocihKxasCj3?=
 =?us-ascii?Q?aiUvNhioe1NIV2gny1I18E8gXbqfXM0HIrfCJi5GAcgZwImRm7gMUnVWL0zt?=
 =?us-ascii?Q?fi0nV8oNJPgV3mu5O5sGpAqVD8jGdv2Mcq/TRCrP+QrFfUqfBeX787CfgUL+?=
 =?us-ascii?Q?Wf8QAKs+/MVXZT/NmUDe3mILPCOJXc/7yfzK1zi625VgKkveqHHWrBbs9I+E?=
 =?us-ascii?Q?OHUc1SBZXCpx8mDjVgZKEaTVEIshw3E06SI6+d2yK2zkX6wHUknuo2KpXKNz?=
 =?us-ascii?Q?OnfNFV3Ifg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1bfe4b-7054-42fd-adbf-08df34472d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 16:27:21.5486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrxGB+vvhIOsuv/RsjNjkSWx8CysPFggZZfN2pzq+Cio46PTPAOuOeFUrBAdhLWkBCCTXY1/YS3ORJE3UBPI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> Subject: [PATCH 5/5] hw/arm/virt: add highmem-mmio-base property
>=20
> Add a highmem-mmio-base property to override the base of the virt
> machine's high PCIe MMIO window, alongside the existing
> highmem-mmio-size:
>=20
>   -machine virt,highmem-mmio-base=3D<addr>,highmem-mmio-size=3D<size>
>=20
> Some PCI devices require MMIO resources to be placed within a
> specific address range that cannot be satisfied by the default
> placement. The configured base is validated to be non-zero, aligned
> to highmem-mmio-size, non-overlapping with the existing high memory
> layout, and within the configured physical address space.
>=20
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  hw/arm/virt.c | 62
> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c5db663858..3a554dd26c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2513,9 +2513,34 @@ static void
> virt_set_high_memmap(VirtMachineState *vms,
>=20
>      for (i =3D VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap);
> i++) {
>          region_enabled =3D virt_get_high_memmap_enabled(vms, i);
> -        region_base =3D ROUND_UP(base, extended_memmap[i].size);
>          region_size =3D extended_memmap[i].size;
>=20
> +        if (i =3D=3D VIRT_HIGH_PCIE_MMIO && extended_memmap[i].base) {
> +            region_base =3D extended_memmap[i].base;
> +
> +            if (region_base < base) {
> +                error_report("highmem-mmio-base 0x%"PRIx64" overlaps pri=
or "
> +                             "high memory layout (must be >=3D 0x%"PRIx6=
4")",
> +                             region_base, base);
> +                exit(1);
> +            }
> +            if (region_base % region_size !=3D 0) {
> +                error_report("highmem-mmio-base 0x%"PRIx64" must be "
> +                             "aligned to highmem-mmio-size 0x%"PRIx64,
> +                             region_base, region_size);
> +                exit(1);
> +            }
> +            if (region_base + region_size > BIT_ULL(pa_bits)) {

region_base + region_size can overflow and bypass this check.

> +                error_report("highmem-mmio-base + highmem-mmio-size "
> +                             "[0x%"PRIx64", 0x%"PRIx64") exceeds %d-bit =
PA "
> +                             "space", region_base,
> +                             region_base + region_size, pa_bits);
> +                exit(1);
> +            }
> +        } else {
> +            region_base =3D ROUND_UP(base, region_size);
> +        }
> +
>          vms->memmap[i].base =3D region_base;
>          vms->memmap[i].size =3D region_size;
>=20
> @@ -3416,6 +3441,33 @@ static void virt_set_highmem_mmio_size(Object
> *obj, Visitor *v,
>      extended_memmap[VIRT_HIGH_PCIE_MMIO].size =3D size;
>  }
>=20
> +static void virt_get_highmem_mmio_base(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    uint64_t base =3D extended_memmap[VIRT_HIGH_PCIE_MMIO].base;
> +
> +    visit_type_size(v, name, &base, errp);
> +}
> +
> +static void virt_set_highmem_mmio_base(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    uint64_t base;
> +
> +    if (!visit_type_size(v, name, &base, errp)) {
> +        return;
> +    }
> +
> +    if (base =3D=3D 0) {
> +        error_setg(errp, "highmem-mmio-base cannot be 0");
> +        return;
> +    }
> +
> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].base =3D base;
> +}
> +
>  static char *virt_get_msi(Object *obj, Error **errp)
>  {
>      VirtMachineState *vms =3D VIRT_MACHINE(obj);
> @@ -4286,6 +4338,14 @@ static void virt_machine_class_init(ObjectClass
> *oc, const void *data)
>                                            "Set the high memory region si=
ze "
>                                            "for PCI MMIO");
>=20
> +    object_class_property_add(oc, "highmem-mmio-base", "size",
> +                                   virt_get_highmem_mmio_base,
> +                                   virt_set_highmem_mmio_base,
> +                                   NULL, NULL);
> +    object_class_property_set_description(oc, "highmem-mmio-base",
> +                                          "Set the high memory region ba=
se "
> +                                          "for PCI MMIO");
> +

Add this to docs/system/arm/virt.rst as well.

Thanks,
Shameer

