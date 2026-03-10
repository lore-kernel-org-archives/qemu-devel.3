Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3787BFCC9DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzsy5-0006eV-NV; Tue, 10 Mar 2026 05:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzsxs-0006dy-IR; Tue, 10 Mar 2026 05:01:26 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzsxm-00089f-4t; Tue, 10 Mar 2026 05:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkBBwtYQ4Zhc7X2MqdsN4WMefzmEZQZoHUyoT6sVTj8qUITaattB8Z1qcjpuqXkojCgW7L7S9U0p615LABDDRDAGBZo+6MwAmE7qqG5amUDXCFK2QtsvAPjH3vOw1UYy1bzON4YO+n5vIclO1ymFUs+acb9w9lH5708xU4yj9/AM3C7owBlZyXU06WNpB3E3VVeycj3dpBfeE68kjh7UfUN6oFL8b9QYlVThY0VeYdY7vyetrqU14Zd7l2Pvi0YdC1ZfM+v5cBV+8XCme1Wg1llCJaBXL7RKvet36SIT3Bh8ZktPvkaCKKiNV5TAUllP1/tmXFfJ5owVRgBxOgvPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBJUwDL8Us1KLvlfgcJ/TYD4A10r9jOeQ3rlbCyTyv4=;
 b=BluQ8w75WUpPkOHQDPsKaRpSNvIZaqrylceTRge2D6akOvyeawOYi8sEG9vfViOXEDU9nHUSNdaeatuH4mfNy/Qd1yTuRhRf99MM1LCs6yg8CQ2WaVVbgIf/ZTo6D6sTQfjRO9e8011qqZ+wwqhF4as0JGqWZN/vViQlQyP6PX4+EP8p3QG4z9jX1orZ776d1jNeK1u7dOcoGgKNsidzIZVEsghOsXs0RYDBhUCqDuY5kcslOgfbGoNGXhTSrglaH6jTY8PlLbuQZszldZXa7lcUd9rhcVzQfbpIC2Z336XZegjkuFkMvr+m2l3mOwj2kAWxTswywq004WYV5kXwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBJUwDL8Us1KLvlfgcJ/TYD4A10r9jOeQ3rlbCyTyv4=;
 b=cETSWIkxzQKrBWf6Yzr25lNaFdui7yvNWbZnndtoSorcz/IoG9P+T/jNrETYKgedW/it8JNIRmFraDc7xhyyTzHik8NdJGU8Hs3KoR3Qdq1BsisVHzkugKLoL2nL23Lm5C4m2cm46zafFEzP43HVRF3pilUCpmjs0TSI+X5riAXDwZ4kMgMYb5YDaELB92UduyAWQiaVl7P98IwMdJLJX2tmCDqGZ3qc56FUqTuvQHjJLBySEfRxmyQ0WMpPFSaKtHgtHiRAIJfloUcAuKknoq8DOGFffBeYMQGCuqf1kLaXoTLgZYIaqwvz5zH8zMyQNIuPOZwHX+IEIEh1mZ01yQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 09:01:04 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 09:01:03 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Markus Armbruster <armbru@redhat.com>, Nathan Chen <nathanc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Yi Liu <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2EBerrang=E9?= <berrange@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: RE: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Topic: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Index: AQHcr/oMB52/+UCqJ0eb9yphs6lsLbWnV1XEgAAb7VA=
Date: Tue, 10 Mar 2026 09:01:03 +0000
Message-ID: <CH3PR12MB754899F3426FCB494EA7154FAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com> <87tsuonp7r.fsf@pond.sub.org>
In-Reply-To: <87tsuonp7r.fsf@pond.sub.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB8433:EE_
x-ms-office365-filtering-correlation-id: 57b99f2e-3d1f-4783-4ef5-08de7e838f06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: d73tuuDxk/LztPS/dAVRVs66Ev9q26QV1QmosMgyGoUzBABRIsovgS/r3nxKySGCDs0rFsStpWNcRhLhO8qy+g5nzbWcFKYkLLM5Zmz70jnztEMXm1o50jOxnEPu4CVv/FtW9SFdR6RRLrQr/e6LZg260lQGS9aQr7dxy0tYd/soCTeeKd77Ef/0o3DdUFcHLuYBm7y5MjtAiDn95ky0NsInxjGei/3y0mx3lbAEyM5NrRgpTUJ/OHHuxPmFPRA9yWKA7Be3NDXzeyvg8PI9kRnQuF01+6kDaynrovgqywGBhooT3MQ2XHnihiDfvr2zwZMIB9z1zTDs1Yt6hmMmdI0k87zuZL+ZdVvJ1YbgtROWJxYlpK1ou1YMcQBMMj7yYuLSjuCB5lsN5cdtBjNtWDhQ3jOtpkdc75E5GS5kNsAk8FLMYg+XS96I2o0qPEo9zQ6gH5XvGcVJ8ZrAmIZZ9lce86tTjL6Fv1fJviBFq/qVNuA/KfI2BNSqiDavGR5BU4CsFckkRSMQQuX/ZWMFAlBK1IpZWpXBYrFtLkzWxgUQ+PN6PvGfgc0WQ4I8myFnlsNqfDx/cL91eTAdWE8E3/QkBOpgFFKvHctgeRkkZlH98tqtksQSe+tUsr6UHlluC8RxEgmdmtuQ3x0GpYXeKZET1SbbiUKU4/kRcATVV7pHU1310nwWxjL+JsDlFefxfWa46PkivnQXptO+03kTs1HzxC3lML8Oz5gZqCX4VdVBnYimbULHSQ8wbOARW71svOAhvW8CfHG4YpVy8baPCobUYp1FkENVNBbAZwxVT+8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KTCBFNZReKu3xKu6wIzVv38uCYWaW1WpV80UYZFp64oMTYAZBtFkB4mB4T?=
 =?iso-8859-1?Q?ERC6PxkpxAs+QXo6vi4OGGc3GJB+1+2k4GiB60PuCb8AV7eVl4CCTBHEM6?=
 =?iso-8859-1?Q?kvydcrv8Ir0xVPxfV3SlhENCBsYDx6fOwDLFUZxmIM/FH+lD7DQ+LZbJ6U?=
 =?iso-8859-1?Q?Cir6F/k9KHIktBgXC3efpLqoDmcfcbSaSPDMJEkA0QwVXzMCVCEUifGwza?=
 =?iso-8859-1?Q?vco4F3GRCrlty7smPWh0jeUBKaOoUuaTC5086lQtrcJRaq22gZBQX8xHkJ?=
 =?iso-8859-1?Q?WbGW/3TCgHBN6GBCOrLF63rbY9aqyIBsiCzAlFzlP0sFj5bufcQ2VfNePV?=
 =?iso-8859-1?Q?4U8p41XTaIirbQzpjq51gPmmmAn1SGKPQz3xkBE2/bkDhMErHqEutcRm6J?=
 =?iso-8859-1?Q?Z5fCkOLjBfLrbWD01/2mY66Dr2NVK4rm+r82fX0SlARYjqhteRU5X1QE1L?=
 =?iso-8859-1?Q?nIJoErujT6nHkWvI0CQd78zCgHVl+A6UqvlPHIGB0mvM1q04avMCB/N12u?=
 =?iso-8859-1?Q?NJYL2E9glnp/EAttGi6refXCRUAI5Z76HdpE2wlJUd9Avn3Y1ypQBvXFAM?=
 =?iso-8859-1?Q?dv4CcDUSxwD24uUCFeAMissb+Sg+2vfZFfDrg5cHqaeZDuhSH6lNWW/XQx?=
 =?iso-8859-1?Q?r0Y+1blx7xqY5FHNXLlWqQ/NAFlgsq11JsVzhKwLJq9idyEUC/SBn+YADN?=
 =?iso-8859-1?Q?tAWb+uBIm1MQgruNL+ty/H6Q6UChtqOfusc/WOwfE0TqhrQnu9VPbsr5Ks?=
 =?iso-8859-1?Q?F1bQs5Lc0Kqn0uyuTPFZogyXJZeoxYUarryyHhATHSqTKjw7n0oMO9MIn2?=
 =?iso-8859-1?Q?NledNqL4fJazkkVnyBEmv3JU/qBhDlDO9u7zpeFS7hFxndJJmVVod/aOkD?=
 =?iso-8859-1?Q?ipAHhHcZ7avknFVRx4kkLiaZFtECq+n+pzOVXQ+w8gzef3/eDYMUrSlux2?=
 =?iso-8859-1?Q?S0W4Kc/Zx+7ft4/JfsUhapajinX9qmt7cPamADQjy7mEBLBAtsXNuoEfwo?=
 =?iso-8859-1?Q?phNz3ytmzkILoODkd7Nqsao47SsXwx52s2eoz/lj1PoFyc3KwaaIGh6+5E?=
 =?iso-8859-1?Q?vsfmD+x2Ou2l+TMfNCUL4MXbXNc9Fu/cbQ31z9HFtwZ7dCK8Q13IGdzXY8?=
 =?iso-8859-1?Q?EjQnwD8+3rYtSqzCaj/HaRXaJgdsRYvDwTI45c4c7XaPO1SXTzc4JbBkt5?=
 =?iso-8859-1?Q?buW0mNqMLSrL5+D93lil6PIWME49DgwYY1MDN0h1e0VNMsL9GyeIFat5Uj?=
 =?iso-8859-1?Q?DG2IRqJYMIpqEB9TgZxV9c8OgGh2G/rpY0shEy8GMEl6wAf6IDzJfi0D93?=
 =?iso-8859-1?Q?TNUciAfKD2cqn8T28JrNFhPfuT1HDHMEExbvqoKPmTmK7HozmLiZRCeY6B?=
 =?iso-8859-1?Q?sCTJgpuj+230rhEmlYiqrv4fwqUgBmMX63PDzBYQZVFn1KIVBM2u3Sr9y2?=
 =?iso-8859-1?Q?wGBAshUq8lcuKI8/dd6K1tR1qZ7jbmHtoAGbK/URLGBrPjvYLeLhxj5Jo+?=
 =?iso-8859-1?Q?iwi8EdmjJsvWVj7FXpGZYimO9X4ZKmWuiXUI92OsoMFyacen4Bll8iUMhY?=
 =?iso-8859-1?Q?ZAtCcJ/XjdTv8nPRJ9HgwOYyuQdYlH9lvz9EABVxxL3hYbycmVuBJVTj5R?=
 =?iso-8859-1?Q?8Ta4o/EztkRUP6flt8JFbj2pMVXWehGi8dgqoVxSKFfmawMYatWmMCtz0x?=
 =?iso-8859-1?Q?Mm/tuprunXsRbgTOpO5nY9ohzdGyHrKbf3CVAKzF5p29tGpauskxHAan8v?=
 =?iso-8859-1?Q?EN0lJ/M7yWPCTmYCcBNbNCqQ5xMYRE6ffrRuZCTqMz55vIj8FIT1EVpT0B?=
 =?iso-8859-1?Q?7wITT8jvMg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b99f2e-3d1f-4783-4ef5-08de7e838f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 09:01:03.8121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42B+OHbgbfZfHgVSnWvieZocr8BsRY6E9MFJE53geYXBz3bA05TeyX/dlCErnoR4xIs0LgXCcwVTckmesZuKOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Markus Armbruster <armbru@redhat.com>
> Sent: 10 March 2026 07:01
> To: Nathan Chen <nathanc@nvidia.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Yi Liu
> <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>; Zhenzhong Duan
> <zhenzhong.duan@intel.com>; Peter Maydell <peter.maydell@linaro.org>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Michael S . Tsirkin
> <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
> <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Daniel
> P.Berrang=E9 <berrange@redhat.com>; Alex Williamson <alex@shazbot.org>;
> C=E9dric Le Goater <clg@redhat.com>; Eric Blake <eblake@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolvin=
g
> auto parameters
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Nathan Chen <nathanc@nvidia.com> writes:
>=20
> > From: Nathan Chen <nathanc@nvidia.com>
> >
> > Introduce smmuv3_accel_auto_finalise() to resolve properties
> > that are set to 'auto' for accelerated SMMUv3. This helper
> > function allows properties such as ATS, RIL, SSIDSIZE, and OAS
> > support to be resolved from host IOMMU values, while avoiding
> > triggering auto-resolved values for hot-plugged devices.
> >
> > Auto mode requires at least one cold-plugged device to retrieve
> > and finalise these properties, and we fail boot if that is not
> > the case.
> >
> > Subsequent patches will make use of this helper to set the
> > values when we convert the values to OnOffAuto. New auto_mode
> > and auto_finalised bool members are added to SMMUv3AccelState.
> > smmuv3_accel_init() will set auto_mode to true when 'auto' is
> > detected for the accel SMMUv3 properties.
> > smmuv3_accel_auto_finalise() will set auto_finalised to true
> > after all 'auto' properties are resolved, and subsequent
> > calls to this function will return early if auto_finalised is
> > set to true.
> >
> > Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> > ---
> >  hw/arm/smmuv3-accel.c | 38 +++++++++++++++++++++++++++++++++--
> ---
> >  hw/arm/smmuv3-accel.h |  2 ++
> >  2 files changed, 35 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> > index 17306cd04b..617629bacd 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
> >      return map[oas];
> >  }
> >
> > +static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice
> *pdev,
> > +                                       struct iommu_hw_info_arm_smmuv3=
 *info) {
> > +    SMMUv3AccelState *accel =3D s->s_accel;
> > +
> > +    /* Return if no auto for any or finalised already */
> > +    if (!accel->auto_mode || accel->auto_finalised) {
> > +        return;
> > +    }
> > +
> > +    /* We can't update if device is hotplugged */
> > +    if (DEVICE(pdev)->hotplugged) {
> > +        warn_report("arm-smmuv3: 'auto' feature property detected, but=
 host
> "
> > +                    "value cannot be applied for hot-plugged device; u=
sing "
> > +                    "existing value");
>=20
> Why is this warning useful?
>=20
> Does @auto's meaning depend on whether the device is cold- or
> hot-plugged?

If SMMUv3 accel=3Don and properties are set to "auto", we require
at least one cold-plugged vfio-pci device to retrieve the associated
host SMMUv3 information and finalise the QEMU SMMUv3 properties.

In this series, "auto_mode" is set if any accel property is specified as
"auto". The properties are then finalised using the first cold-plugged
device and "auto_finalised" is set.

Since we later fail the guest boot(see below) in the reset phase if
auto_mode is set but auto_finalised is still false, the above hotplug
case should not really happen. In that case the VM would not boot.

So likely we can get rid of the hotplug check above. Need to do
a bit more testing to confirm we cover all corner cases.

>=20
> > +        return;
> > +    }
> > +
> > +    accel->auto_finalised =3D true;
> > +}
> > +
> >  static bool
> >  smmuv3_accel_check_hw_compatible(SMMUv3State *s,
> >                                   struct iommu_hw_info_arm_smmuv3 *info=
,
> > +                                 PCIDevice *pdev,
> >                                   Error **errp)
> >  {
> > +    smmuv3_accel_auto_finalise(s, pdev, info);
> > +
> >      /* QEMU SMMUv3 supports both linear and 2-level stream tables */
> >      if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=3D
> >                  FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> > @@ -124,7 +147,7 @@
> smmuv3_accel_check_hw_compatible(SMMUv3State *s,
> >
> >  static bool
> >  smmuv3_accel_hw_compatible(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> > -                           Error **errp)
> > +                           PCIDevice *pdev, Error **errp)
> >  {
> >      struct iommu_hw_info_arm_smmuv3 info;
> >      uint32_t data_type;
> > @@ -142,7 +165,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> >          return false;
> >      }
> >
> > -    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
> > +    if (!smmuv3_accel_check_hw_compatible(s, &info, pdev, errp)) {
> >          return false;
> >      }
> >      return true;
> > @@ -595,6 +618,7 @@ static bool
> smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> >      SMMUv3State *s =3D ARM_SMMUV3(bs);
> >      SMMUPciBus *sbus =3D smmu_get_sbus(bs, bus);
> >      SMMUv3AccelDevice *accel_dev =3D smmuv3_accel_get_dev(bs, sbus, bu=
s,
> devfn);
> > +    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
> >
> >      if (!idev) {
> >          return true;
> > @@ -613,7 +637,7 @@ static bool
> smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> >       * Check the host SMMUv3 associated with the dev is compatible wit=
h the
> >       * QEMU SMMUv3 accel.
> >       */
> > -    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
> > +    if (!smmuv3_accel_hw_compatible(s, idev, pdev, errp)) {
> >          return false;
> >      }
> >
> > @@ -867,8 +891,12 @@ bool
> smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
> >
> >  void smmuv3_accel_reset(SMMUv3State *s)
> >  {
> > -     /* Attach a HWPT based on GBPA reset value */
> > -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
> > +    if (s->s_accel && s->s_accel->auto_mode && !s->s_accel->auto_final=
ised)
> {
> > +        error_report("AUTO mode specified but properties not finalised=
.");
> > +        exit(1);
>=20
> How can we get here?

This is reached from the SMMUv3 reset handler when auto mode is
specified but no cold-plugged device has been attached to finalise the
accelerated SMMUv3 properties.

If no such device is present, "auto_finalised" remains false and we hit
this path during reset.

C=E9dric mentioned that we should not exit during the reset phase. If that
is the case, we likely need another way to handle the scenario where
auto mode is specified but no cold-plugged device is present.

Thanks,
Shameer
=20
> > +    }
> > +    /* Attach a HWPT based on GBPA reset value */
> > +    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
> >  }
> >
> >  static void smmuv3_accel_as_init(SMMUv3State *s)
> > diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> > index dba6c71de5..3c1cd55714 100644
> > --- a/hw/arm/smmuv3-accel.h
> > +++ b/hw/arm/smmuv3-accel.h
> > @@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
> >      uint32_t bypass_hwpt_id;
> >      uint32_t abort_hwpt_id;
> >      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> > +    bool auto_mode;
> > +    bool auto_finalised;
> >  } SMMUv3AccelState;
> >
> >  typedef struct SMMUS1Hwpt {


