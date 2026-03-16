Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4DDEFCBD4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w23J3-0003x6-77; Mon, 16 Mar 2026 04:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23Iy-0003wj-3L; Mon, 16 Mar 2026 04:28:04 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w23Iw-0007Rw-3Z; Mon, 16 Mar 2026 04:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq8H92kJfL3rDr+KCHeJqgMXr4JcyqUGoXDc/zcPLpMKIhGMk9AvyElmBqupYExLSDEgAXBhI9YSB4Oo3eSZXm36lHI++wEss/VNcv6ewCKmDqqdu0bZLTMpe+Mp+weV+ICOBu5ZneDI8I9vXJVZYr7XOkraVAaeSaw4MUbomOQHA2FtE4B17jKg3s2IHuVIIqa+QznuluRImZH7weJoUEaXThf9mD0zOKbU6jH2/JG07M0qb6WtpAHzgl1dDTZ1Eipav2YPl2XDeN0Ig6klu3Sgsv4VudHL0TLRmp+GwzIw4J7eA5BlHV25cl7rYxdGhoq6P5Y8OnCMYjef+ayrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVMI71AD4oh2Hk71/qFJQfdotUW/0pF04nXjcHPGGg4=;
 b=SXWGQOaaFqJYxfFTACzDkaTVbemfpQvPGtpBrTQlcasOfFYx7/9jK0ORtuhPVflzBltX7szcLJjpqSOkqps4miq7hwZfWl6J0yGVhQ20F8zLXu0Mga8LF3LYq6sgqB134h2sUP8kX2/Pev4qCvUnL52M0MHJFhA0/Uq28LdTykcZFHlYR/EXmLEkKeshDZjt1aPc/XZJ+NE73/4Twz8BTd6BtnQmr5l5w7KEp0/xdu0TMo/nRE8OWJnq2MSrBJO168EMtEk7nNFjQSn4PtAJNIQam0yt91wTtibkuGfuMg+Tt/OL1MZ1d6E99AxAR9Q6ohOaKTW1LAyn/Phx9uq8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVMI71AD4oh2Hk71/qFJQfdotUW/0pF04nXjcHPGGg4=;
 b=KPdMaxBpow7cIorc8SDS+Uriq4mwo3bOUPyNz53dWr3ojwZhZ0HsmUBD//osLnl/GZNcgPExDwXMuaKI5LSurDcstT/lKGvxluMkrTkNf15oO+ulNuNVJftCNZPxBiG5niduu6hbDndFA/JrX5ekZFpq3MKeel+kFZg/qENZY5/phcAsvulilYy5m58L1BQ9j4+wtu40dNwE+JMJ5dCmn8ZROkt5f52vXd16IUplGPiwj21EjaIuZDgo8wGcUIl47QfWwlI8sSyFNMdbb3BMWvWGa5cukX91jjbkwi9i+s5uopalr75xV9Nm32oqzAbu4MOivQQU+IEeIpqVP0Z21w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:27:52 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 08:27:47 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>
Subject: RE: [PATCH v2 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
Thread-Topic: [PATCH v2 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
Thread-Index: AQHcsmPB3Yz4P/M5tk+N21NuPDiB17Ww1r2g
Date: Mon, 16 Mar 2026 08:27:47 +0000
Message-ID: <CH3PR12MB75483F2A3C9BA1E27DF06180AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-9-nathanc@nvidia.com>
In-Reply-To: <20260312210328.2016191-9-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6207:EE_
x-ms-office365-filtering-correlation-id: 104874b5-94d7-41b1-e7ca-08de8335e775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info: uSNU5jPYOFNyQ05XmnNc3dzG2kuUllsfP8vZbxrKAPiPnxCcD0Qzd4D7IDejRAK11xL9UR1sWVJQvq2rpV+JuDyW/aQ308DL7nInds9GHprnlWtvKGnjxUOMwRi069VRYLPLYPzRUci2wU04QAhz15Quc6RGWHdDwOOvM25ZUlRKVQOOlgwOKi68Qdp5z4L5Deo3UShI2HjTdc8thl7qW9nyLcSmu2gy7atNDeCZ2sUgAamfVLX8rt0+dm9FC3j7DojqBYPO17ApumU9mw+FOkzixNzObnpJHSxyz3b7yTNd9O32j/l/6fMzcCEGKo7GGfDv7+3CpPSDobYnchBNEgQ491vlskqKYO3/sdMt+vjRqfBhWYJkhZPF4chrc+BxYIHf/sGwNlG5JGhowAO5BbsKrug9pbB7/kjMKnfmo+uYlOkbBifIPBujDdFbWF39gxmrRMgMEPOR+0aDlNl6aw67vehP3Bj6+if++1mpiVLuDBEYdudWm7D1SEErBNuhMrSoJXQ8UTihzxmyei3dvGd8pVfwAqiI2g1tJxoZaBMtMj6/y/vnEsl7vwIuohEVEKzUz9uWkPs4PO6SWprTpR07ImADmvv0jiyIBNX6guNbqWjV/eGTXNnqyr0N73SVkE+OVW+UmNmqT7SJmr/3AsjC0v982+upDECHqIb9a2XR6RSIuuKPhJU91DGLIq7MFo/KqOGXVB1dAuBnpZ3X9nnpfAr/uDsahTc9BmiRYVGwPr6be2cH+T4okMkQrZlWOBN17spUOAI2cGymUUphrXKKJzQMGgwQTxxOajJopa0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L6uToqRCyEXOwE6PY0J82R7f5LKpJL3+H6p2M31eRf/ZKBfi1p8Tdh00e6?=
 =?iso-8859-1?Q?kJt65UNAIvsKI0aJB2dO+PNywTnDu3tr2LJRxIukLe6CHu2UxhQvmLM3Aw?=
 =?iso-8859-1?Q?iFx74wsqXTMF89PZiSPeSS/UN7zCOFVhqCfJL5PcH20twsZs92/UrPbMjR?=
 =?iso-8859-1?Q?YR0sb7m2eLUQyhXt5hIpBJd4N8fhxwgHzuXc+qwvxMc+xMZohDHN9RWiI6?=
 =?iso-8859-1?Q?/VO42bmiRz0vdOl24gHrPoRBflUUssNyL4nRAalzLku2Ff2tge3FzrjUwo?=
 =?iso-8859-1?Q?YM5aadasD3tTz3JRTyCRjWPewZHst84x5H+MUCqV+z0ncJvtYAMDNtw6pL?=
 =?iso-8859-1?Q?TLtPoiVOqkBVLB0QsvayO55htn6wB4ldA4+0ke2QfXz4QC0P3xd/1XzQgU?=
 =?iso-8859-1?Q?m+D6qKcEKFZnYE9VuNArKvs2dLWdbdrKlO4DjWLQ7Uiar93cgfi9nVZYsq?=
 =?iso-8859-1?Q?KxOmu6lCIovGVm2tk2U7z+BzdYFNloyhBV5IZZBx4FBvCYbnAvZvutFWwe?=
 =?iso-8859-1?Q?h1gaIQvyXz3r8NHJ5fcFRGsdK13wEK5CfpWtcjmWO5rilIRi3J7WAd/WIx?=
 =?iso-8859-1?Q?QSGKV3ZUdGit6kdp0FIBxc5A+ddHcLUJQqkIhugWVqQthm0iqXjyfM+gKH?=
 =?iso-8859-1?Q?geMcHiUTwoB227ybSDUeHVZv2TnS7eys/wWmeV5D6xHvNoYMPHZ+CQude6?=
 =?iso-8859-1?Q?pow1+Gc2l7PPClnzk9ZEjJvG2pFHscGWoTEsP1KEwUFuZtMvv7vra0zv3p?=
 =?iso-8859-1?Q?fhEOCD50oooov2EyH57s4K0voJdup71be65qeKazJTYv8l5mcroC0Z8rwj?=
 =?iso-8859-1?Q?gg7WzUMYfQ6y4wk2VbRcYXIiNo2kq3haEmB69dA7ZCDMHSB0yKJPSnG1bZ?=
 =?iso-8859-1?Q?K7vZ8UsvMT9cPJFoFzORB7TMvcx/fchD3V5Kwp0DdQaLK16C7hyZjmyp1d?=
 =?iso-8859-1?Q?T5hDpc2Ia4vMxH67euxvEIo8QeAx8f0D+ACQe3ON8vge/rbx671SsFt9cS?=
 =?iso-8859-1?Q?iwaT08E0z+GtRQ6KC8/B+k4/BL4rcB7GkON+5efg5z9cTu878w2HLLVrhF?=
 =?iso-8859-1?Q?q6wBjb/3NRVlreG8DsOzsk8s78Nr9DXiGZr6CuWHKxTra1dhb6v/+57Jeo?=
 =?iso-8859-1?Q?l3W4pmb0iSG4Z0vITuyJNsY/kPGy12+PIhEbTUnVYcKhcAxFCEfnL/Au2C?=
 =?iso-8859-1?Q?H3eLi4hv1fbw0xRHT1crrdwApvS1VQuwqX1mwdgZtwPu3NRcs3W8bctaOy?=
 =?iso-8859-1?Q?Bi3MOK7jaXH1wYyVmPjjzfxH+E+nESvoPyu0tD15TkscgwJsZug/L1Fyxe?=
 =?iso-8859-1?Q?mX5N6N8aJ2l5z3ruBNqkoQNxgbjlWY4NIFwOgOGvL+OLZEBzQgflbW28Rx?=
 =?iso-8859-1?Q?etxVmFeVStLiBlAGx0kFYC1i6mgAhLAtJYkz+vta3OO3fYfy6rRq/Hm5N+?=
 =?iso-8859-1?Q?N/SMvdGsZawoHPUnV2D28eGfosOjVNgI0ZBa1BETluxgBP6p2nBmpntt3P?=
 =?iso-8859-1?Q?gyK8o9OrC4XltloJ4kEyBcU7Yr84rbdbCgw+pizQjVifkZrQ8iK0/g2EkH?=
 =?iso-8859-1?Q?LURbQeVcrlFEeeZcaFgAJCmIDEGWe2rVcDpzsG56J0W6euZcm3FdK/J/Sv?=
 =?iso-8859-1?Q?EJkP0QvxIGZ/cj8WHPKmpH98Pxm6xm+28KktSbJRHC0ZZyJLu641OLzwSs?=
 =?iso-8859-1?Q?pNoo9rd3+gSihbTqdhzm4r8YRIc/FyfkU5FMvIKArwtKT8b8rnlgzIDskj?=
 =?iso-8859-1?Q?dIN+eLnL9aasumbqR/x8WfZVfmznrvWc1sl0rm8wpxNAAIs/cs9HN2fHdX?=
 =?iso-8859-1?Q?iD6+C0Mvpg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104874b5-94d7-41b1-e7ca-08de8335e775
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:27:47.2916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqc4nhju7E1hUT/Ms+ADeXlzX26V0m+lpWuvWWoePegbEskJ6HQLTjs2XSRSdPlu88zY/3dIK3H1+SSw3doJaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 12 March 2026 21:03
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Michael S . Tsirkin <mst@redhat.com>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>;
> Eduardo Habkost <eduardo@habkost.net>; Eric Blake <eblake@redhat.com>;
> Markus Armbruster <armbru@redhat.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Matt
> Ochs <mochs@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v2 8/8] qemu-options.hx: Document arm-smmuv3 device's
> accel properties
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Document arm-smmuv3 properties for setting HW-acceleration,
> Range Invalidation, and Address Translation Services support, as
> well as setting Output Address size and Substream ID size.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 890c4f1d23..836de4532c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1274,13 +1274,40 @@ SRST
>      ``aw-bits=3Dval`` (val between 32 and 64, default depends on machine=
)
>          This decides the address width of the IOVA address space.
>=20
> -``-device arm-smmuv3,primary-bus=3Did``
> +``-device arm-smmuv3,primary-bus=3Did[,option=3D...]``
>      This is only supported by ``-machine virt`` (ARM).
>=20
>      ``primary-bus=3Did``
>          Accepts either the default root complex (pcie.0) or a
>          pxb-pcie based root complex.
>=20
> +    ``accel=3Don|off`` (default: off)
> +        Enables guest to try to leverage host SMMUv3 features for accele=
ration.
> +        By default, enabling accel configures the host SMMUv3 in nested =
mode
> to
> +        support vfio-pci pass-through.

It might be worth mentioning that the properties below are only
applicable when accel=3Don.

Also, should we explicitly mention that "auto" is currently not
supported?

Thanks,
Shameer

> +
> +    ``ril=3Don|off`` (default: on)
> +        Support for Range Invalidation, which allows the SMMUv3 driver t=
o
> +        invalidate TLB entries for a range of IOVAs at once instead of i=
ssuing
> +        separate commands to invalidate each page. Must match with host
> SMMUv3
> +        Range Invalidation support.
> +
> +    ``ats=3Don|off`` (default: off)
> +        Support for Address Translation Services, which enables PCIe dev=
ices to
> +        cache address translations in their local TLB and reduce latency=
. Host
> +        SMMUv3 must support ATS in order to enable this feature for the
> vIOMMU.
> +
> +    ``oas=3Dval`` (supported values are 44 and 48. default: 44)
> +        Sets the Output Address Size in bits. The value set here must be=
 less
> +        than or equal to the host SMMUv3's supported OAS, so that the
> +        intermediate physical addresses (IPA) consumed by host SMMU for
> stage-2
> +        translation do not exceed the host's max supported IPA size.
> +
> +    ``ssidsize=3Dval`` (val between 0 and 20. default: 0)
> +        Sets the Substream ID size in bits. When set to a non-zero value=
,
> +        PASID capability is advertised to the vIOMMU and accelerated use=
 cases
> +        such as Shared Virtual Addressing (SVA) are supported.
> +
>  ``-device amd-iommu[,option=3D...]``
>      Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
>      Only available with ``-machine q35``, it supports the following opti=
ons:
> --
> 2.43.0


