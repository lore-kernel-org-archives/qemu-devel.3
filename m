Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA91FE94108
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 08:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaVIj-0004Lp-I9; Tue, 30 Dec 2025 03:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaVIh-0004Ja-M8; Tue, 30 Dec 2025 03:41:55 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaVIf-000849-Vo; Tue, 30 Dec 2025 03:41:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC1w7qIWe2h15aMCixaObG75M3ISiD+cHjiQjNuy8vHs9zI/V9tt/HvQ2FSN18vBhzSmux0zKN70TfX7WO1Yos2z45NhKnKNoS33WQN8DZqSZ1iSjrScudOq3mXiT4oBiLpeXbAFdse/5OwlXBwbz7LX/brlT1gvqbgJgXRb7nW+W4hl812Hyq/EIBNDr8GVVQd+JtvVDhuONaY4tFBsLN6VPm5ANijeVpELP5OT7CGg3KdkMLqPVcFRbr/z30uTf6h/NCHxeuTFusYTHkHdOf7dPl071Md3EhdzWDwC+3Jxubz775OYIZH90hExYJ/h7lQmTABepyT1ojJOp9HVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5MbhLpjN6m7nAxzg1atCdKqekMiS0XrQqmF4k0Yj3Y=;
 b=ccmW24otTpvpj5VvHtmQ84QyFSFD/HgDUjBTyFImif0sbaVcnHhFztTDrDRiDSXwzig/feYTrn0qjRA0xv76/FTAqRAbZtiNW1nXpu8lW6/3/JWIeTEFdbZOtDwQ1ukjrI1AxeAfranvG379xarEUzAjIv9AB9iT5nBPPYSamcELKxNgvGrp6oItdT6h00tCs+6vcjsLXi0LT1iOfXkXF7A/N5FqJPbCf3JOH6Vc0ER5H4SOlmj3YPaI6bNPzYCFsWjEnd1QL/qEdppFwkKebAoERSpnJEwf7ZMzOSsbNynw/FLQiougasleEsnEacKFAF0kxNC/9dMMW7qlOuVNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5MbhLpjN6m7nAxzg1atCdKqekMiS0XrQqmF4k0Yj3Y=;
 b=k68njkZIrD0tUf7L+oJ3+zHupJyE6Vcy/zhXbiBF0x9ZElKkH/1dsd9lRIUMKiqCVjf8kw6wiZlxAdW8zlHklxHO7vu7gsVrWOGaAzv2wY9iyteUhl0PbjXdwNGJ641LZp2M4yjAAmkypJWFPwOYRxhS4sbAyT6n0a1UkDO1SxZp2ryVQWLMM9MXRH0BDoGHUnZsjQU5VXW30X7x7/MeckHFr12mPwA4B+WUrmbgUK0cWmsP87+U9jQu6nEqS36h9vjmKFGRBGSPBoMQuh6/V/6C+Y8mtZqIa73GTnEmcfYhVmrm71Hn6THhNeEHiuP4Bcleo0APyukgdgfrM/6lXA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 08:41:49 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 08:41:49 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 01/16] backends/iommufd: Update
 iommufd_backend_get_device_info
Thread-Topic: [RFC PATCH 01/16] backends/iommufd: Update
 iommufd_backend_get_device_info
Thread-Index: AQHcadq0uGQzmDefTEKiMsSVvxnpurU5EUEAgADqZBA=
Date: Tue, 30 Dec 2025 08:41:48 +0000
Message-ID: <CH3PR12MB7548E7E88C87C32AA66E9B7BABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-2-skolothumtho@nvidia.com>
 <aVLK6O7ZJEImtpjZ@Asurada-Nvidia>
In-Reply-To: <aVLK6O7ZJEImtpjZ@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB9524:EE_
x-ms-office365-filtering-correlation-id: d174aa9d-317d-47b0-7458-08de477f45b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SBbuZBE25D2OHlS72yJk8VGBYYxVk0T7498Psmi1kTkRh1cFCJ76BQ0Z9mE9?=
 =?us-ascii?Q?z8hONMGKlXyyfThaoZbmd0v2RhIp+0HTT84K5KgwuriepRMJxqtWX0tnOm0t?=
 =?us-ascii?Q?9FMlnPT+EH/CHyPL+nRoFXFXlPR7lTSneBFZ980Cu0v70GiBcbv49nsWLNy5?=
 =?us-ascii?Q?rwFVZM78vBq35XUqi4WHJT5JcpHNxKW2yuHWY92w7RGMbhL8AR7ayzT359fp?=
 =?us-ascii?Q?3PSsrBTRL7SHOPLposCyRIF9jnTx2PeitxXbZp3d6TPibUd2TRnD0qiFmv/s?=
 =?us-ascii?Q?RYujKZ1diGPgQ5q88R0nDGvUuhy24LMbAesBQRzsQ/I+l3qmrlTuAAi3T48E?=
 =?us-ascii?Q?vOejy8ixYX4Js+o/uPScKgO5Zu86QNjXYCs4nnZi1Y1vYJWPNqB60I6IUkDR?=
 =?us-ascii?Q?yZ1QSUFCrHd74bnkQHqojF4Mm5K55BTxnjEJC7/UmUGALcBN0ojohXAvmW9e?=
 =?us-ascii?Q?D0hAJeConK1PnpfXQSo7nyatq+XlCpilmeIC5LPkYrK10bFY0k2l8QHAZu2y?=
 =?us-ascii?Q?uXfM82bMw7zfd72EmpWxVExyoUK3oTmtqKrr0Sn2DZfkVE9hJHgLVAQ+cS8v?=
 =?us-ascii?Q?5MbdrLfodM0r6PSkUqT3kbfLVbyl24hDYU4dBqs5ahoKK/O5yOkdfxWPLO7K?=
 =?us-ascii?Q?uwTcG0Fa97Kz3K+U/xzedgSydcOsjoHIjbW4b/PJme1+7bzcHs7hn1DLO4MZ?=
 =?us-ascii?Q?yNOnkL0xZAY3OM0KHDeszKIMYT7Vz1VJwOSJExnsybUS1xh8xR5q0BuUE6uK?=
 =?us-ascii?Q?CnSGrNSNqvPP8e+0OZPwtoXADI9hXxB2TePXM2dztE59ifFk/ilaJipZyWcE?=
 =?us-ascii?Q?zZraM2tb4CNR+i1V85CGO7vfU6UXkVQI/H6/1GFs0Fz3N3mtgBeuB5C/vvH2?=
 =?us-ascii?Q?5Lag+2u50HPYn7lKx48igCMFXHhtHRlRU80gAiTpSJBRFJ+1zdKpedOWaTXo?=
 =?us-ascii?Q?uKZqA7djYGbJhLan4fgY+AB7hnXOBumapBi1RlrsGJcPEoHXJkHbPkNyBE0I?=
 =?us-ascii?Q?to70mdsjNgFtpu2Y/0A7C8ZsUWZuSseAyCb/M5flTwys0xLi5KHPFa5bKApX?=
 =?us-ascii?Q?J6QGgsfUyKOLuDIiN37RlLzR5118u0yHRpdECiqdJWB0kjalw16wyZ5EvtWa?=
 =?us-ascii?Q?Mnoi5GmXisLXbgn6O8Q7HRWuS/ehse0u4ADxmjEEqHeTRmVE82xEsEVX2ERo?=
 =?us-ascii?Q?ebWvk/EPGSQtXCqqxkHEz7yK1Eo5cgYnAI4zsgMC283fwY4V1hr/c4JNh9ia?=
 =?us-ascii?Q?EcvOAHjMD8V/uyN/ih4P76BxCrnEoByPqlTjSD6zirplMS/FEMklTNsZfFnv?=
 =?us-ascii?Q?Gf71HSeNEXXfNUo3AMhSH3BV2Ut0wtSKlTZsj+AwO2XtPhCNBMun2s4nfsTh?=
 =?us-ascii?Q?dk6Ig2v4BsdUGsgtZeFNeS5OxeqF2FG0jbhqiOaWKqyphky4SWhBrewYb4Zs?=
 =?us-ascii?Q?c6pn1kgeI72RSHi/UEdUkfznfKl7rjqvm5d3mQ+Np7LlE/pmJdbXEOMFFD42?=
 =?us-ascii?Q?u0jDEd6t9XeJ81mZk3XcPsqhS30t+Sd+N9Vo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q5eh1wppMwnd2QpJmIHdZv/WcOanPGu2p46pauaUaxRQ6532V7sALuGQz2lC?=
 =?us-ascii?Q?FXxtdR1Iv0bxD53yrqBPCU5j9OKIUGci9pC6YTHs3vLNE1ENvwbC8tKmlrvd?=
 =?us-ascii?Q?8FlJ4rkybUykid5a7vi79YBtsulOVCtMmaP4W7NjdWEzrl796aU1E/aN5gzj?=
 =?us-ascii?Q?4qVvXagNjf/ZlsJ0xkkgISgN0hMG7XgDoWxHUCQaB3v43p8qX9vulPy4B1ii?=
 =?us-ascii?Q?ANR3E8OzS1/bAq6enSTkkbV+7BEvjEhU2sqUu1+SosBBccnCZLi6ATKtP13s?=
 =?us-ascii?Q?2R9SXbW2qtc7LnKzZn5/SQ5tqVhLGAD36+o7ioFn3TIvOmsovyC+PjeJYDeY?=
 =?us-ascii?Q?NUxrtfpoW9fGwcf+z0FWKG6VAoWQFrdGKIzarbYqCBc6GuL4XQveq4j/yVHx?=
 =?us-ascii?Q?8huRsDyAanrr2BAmiYiTGpsLhcHSeNladvnzpvMwGQx/rWiFHagtYrIPMSx4?=
 =?us-ascii?Q?w0iaKkcwOGYMShkuBiDR1P73IhrU10mwu7W8k1GsPQrXFRNvDlceHXFDQgGY?=
 =?us-ascii?Q?GEwPKliedh0jhTOauNxDc31gq3J0MCUvRkegCCMtd0pQQFRVzxo4Gu9Vk03U?=
 =?us-ascii?Q?6OHwlhybkQAqA8s7S3YBw/lDRq7sW2HWiy3WyGmKh+8g4RFXvIbo26BfrM7x?=
 =?us-ascii?Q?BzaBNtm5IsFRsVRZXzVumg1ZCLCJQ8ktUyDhgc/X3qz7DhTmBVJXyoYTcjaA?=
 =?us-ascii?Q?cxDCDGabRTutjIrYb5tgDFWc47DA9bgvBACrytYbNAwWpurwtih3mOOclWfF?=
 =?us-ascii?Q?IvPgWXL+rMIvRqbM1GMTeHgLGwlJtnY6H3SkTaIhHhovwId3y+W6XYdW580F?=
 =?us-ascii?Q?1RA00uGK6BO8NZWJpkZx67I46KXDTiVkPp501g5AHfW9GZF1n+W63sPfN/w4?=
 =?us-ascii?Q?Y3A28US68l2nloWn2eTr4D82JWtRokhjPGwFdvealLMKMbzZ4/Zgspj0D4oQ?=
 =?us-ascii?Q?rzbtthic904AEkORoPozeCakN/BnpGuKIIVKmDAPn6lhAErDqJwhsLlp8qaG?=
 =?us-ascii?Q?EqIC9C1egdbh1hqe+byLGaicg+FVWikHCk8MtaUg+zHKwZu7thn/fF6Z2ccy?=
 =?us-ascii?Q?KjWhXzCPV5vlz3Xpq3hPuOsf6xdC1LY3zEiS/gaOXYj1LLUsU0HRGHzf6Kxu?=
 =?us-ascii?Q?KNb1V1iePWAKJPDiR2QyRr938aOg4EViNUYpx1kSK/mOGh0nQOZPQDMH6OhL?=
 =?us-ascii?Q?EQ60SWXLm7CJ5QvMx+MTxhWThPW+pc/DSSplXjFvLE204sYYzsYl9vpAwEJj?=
 =?us-ascii?Q?JQuZ1kFgBow2SFamXEgBjAROJr68GNU959LHyqJVNvGGrt5VH2isTn1QNW4j?=
 =?us-ascii?Q?CkUDbSTTenr9zc5qfkRYC7iXg7UTuAl6zTIs/Y9aj/7S13EZBOeQESD2Fifb?=
 =?us-ascii?Q?O9DyMH9SSNi1QOmYdFldZ7a+35UOapABvP8LptAzwAMPjJ6T2tBt1Wcja1h1?=
 =?us-ascii?Q?g6g908SpfwL/+ffkFH7vraltBvCeffGWHVtS9W9op8NLqjEGfw3Xs4LJv4RG?=
 =?us-ascii?Q?ygUe1U0OUld7IN1mNBlduC78ioC0sDZdCyeEYIjWEvqqv6X7TG6cGCA8J/Zn?=
 =?us-ascii?Q?YIEhNLJ/20rWcfePR4IXXssbu+JXnUk8Vk4gTKsT+ax1XIicGWtPPZ/QlrH/?=
 =?us-ascii?Q?6p9ur2JpM0qsDSbL0iDxQFwbOZCDoyHoZRHRLtcz5JnrlwQ9rrl3Ck8faQR7?=
 =?us-ascii?Q?M4irfpWnbwH+tbrR5GArHvUgSC9keLa9jN0s8SQh3U2/91tAqmlX4e0D6eB0?=
 =?us-ascii?Q?JRLqj1yFTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d174aa9d-317d-47b0-7458-08de477f45b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 08:41:48.9071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy8rCNeWib2iysUZilqLTVGBpwykapJW33fu4K+4gTGt8HFqXXRp4sZ4uiyhrOqsdiD5HZ19YStnADeeD6TzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 29 December 2025 18:40
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 01/16] backends/iommufd: Update
> iommufd_backend_get_device_info
>=20
> On Wed, Dec 10, 2025 at 01:37:22PM +0000, Shameer Kolothum wrote:
> > The updated IOMMUFD uAPI introduces the ability for userspace to
> > request a specific hardware info data type via IOMMU_GET_HW_INFO.
> > Update
> > iommufd_backend_get_device_info() to set
> IOMMU_HW_INFO_FLAG_INPUT_TYPE
> > when a non-zero type is supplied, and adjust all callers to pass an
> > explicitly initialised type value.
>=20
> Let's mention IOMMU_HW_INFO_TYPE_DEFAULT=3D0 v.s. just "initialized".

Ok.

>=20
> > +++ b/hw/vfio/iommufd.c
> > @@ -306,7 +306,7 @@ static bool
> > iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> [...]
> >      bcontainer->initialized =3D true;
> >
> >  found_container:
> > -    vbasedev->cpr.ioas_id =3D container->ioas_id;
> > -
> >      ret =3D ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
> >      if (ret) {
> >          error_setg_errno(errp, errno, "error getting device info");
>=20
> I might have missed some details but this seems unrelated?

Yes, that is likely an artifact from a careless rebase on my side.
Thanks for catching it.

Shameer

