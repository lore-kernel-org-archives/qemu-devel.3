Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC4C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx58Q-0007EF-V0; Thu, 20 Aug 2026 11:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx58P-0007BI-S1; Thu, 20 Aug 2026 11:56:53 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wx58O-0000l7-2E; Thu, 20 Aug 2026 11:56:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeW+zIsK4qs+gs0cAB1A/1oTl+WhPIxMS0n4cppGR/iZ1Lly4b4EjVnWTh0CKMnj+RUshnxNz3fa4xkoSMiUhYh2r5nghpv7Zppa9EVX2oO17EmsdvWWIeSUQrQstikwul6ZdEcZUS+C2LnfvaP2IZtfPi1fsH3uypv1E7pJTRoVwdSAlUFFqA/9m9o3TGCuCru1/IrzOxh2pHgNcbj8yE2GrBj5C4LcvIzmuhFQ1g17zbJRn0jyP2hk+kNIFho4tV374BfOHwMM3Sm8amIM+ntdNrOzH8gn9zDPvZdmnD43wdT+2OzDPhgsCJGN9yi/EnKeWUjGq3f280u2RiGXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX3LmtDgDWEXhPcQhYEawYFDHYHhBp44OkRDHBSR/wY=;
 b=CDtbEHLgTMzkre7e91fIoQjIaP7jF+ADc8M+9bkKBVr/naBLcYwY7UkLea5YzDOPAnlHXj/EvOBtBB09IowlIi9L5edu48krm3170Mpj4lGlF/LJiOlZUYVs1uaqi+NYjmEH/9Vg7WwpSLzmM9EEaJvczXGDCMs0x3YLwhqPxWKs+BykQn1hoTr4kpLUnqqGZZnYpaMN7Rj6fiykGht9zuQEuhui2d/KaTRixg5wtU83uiknHLXybKMexs85XtdgAmT73zwn3wr3mBl8k6a5Vdcv+lyzeveAmb48W1HdjjpmHB1W/NbkJE4XjkqmIG+c4lx5LzcDuPNHbzRky9md9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX3LmtDgDWEXhPcQhYEawYFDHYHhBp44OkRDHBSR/wY=;
 b=LJxmWmOdWi6jOzg/cnldkwg0FjcRtTXsuM7KhE9loXpDd6HIzn6gu5G0TVnils5JiUcvt7erICvr6Vpb+mpbggHO5Ss4WN/twN+xaj0jJVnw3xlvimZc5KTpiYSU3ldh2DKbsuLa1jEEnabaPEB67HCLCkzQzQT5FRbK6Z1HTdaK3kGC4VXQeITzAu+a6S6Bvahz78XJoj7SaalsF7yo9PtrzF2ofCAwB5mid0TfKiG3aI5JCOGN2yZ6NbIDkLHjT+dFy71LhCmmrl/sQ0oF8NLTOWCEXsVAE4Eq1NldjBFa6Jtlem3yJTjmHwEf5fd4Sh1KB32Kx0lJGESGPvd8KA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 15:56:38 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:56:38 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Junjie Cao <junjie.cao@intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>, 
 "jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
 <alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
 Vikram Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
Thread-Topic: [PATCH 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
Thread-Index: AQHdKyTGpyjbtwVurUmOVaDr4UiKUrajmF6AgAOH42A=
Date: Thu, 20 Aug 2026 15:56:38 +0000
Message-ID: <IA1PR12MB9030EECEA8236E6DAF73344CBDA42@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813130623.2499506-8-mhonap@nvidia.com>
 <20260818095250.252230-1-junjie.cao@intel.com>
In-Reply-To: <20260818095250.252230-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 2b68c945-180a-47e9-b630-08defed39e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|38070700021|5023799004|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: xaozrG0H1/NPM0HVro54M31zQ/AqeQ4hgBwzHIeTgbT6z1aDQuYI7rjdKELXfPlqxRpguJy4qeoIF3GxJ9412+L2aEVl1wVYyFwNbF6LzH57avkO1ZDBsVCeSenSx95N8lCVM7OCGuHdSV/rn34bZQp4ONs26/18AlhXxQfKZSv41G0XeJHWn6NrMoehhgJx1O4b5EsY+Wk1CBEQWj64uzDZ1ESlIqGT2Imj9hJ4kPd602STDWRq6wnjhDKishED5r0SWCrIXtJ+ns6VbaJNSU7e3p/0GrIwXwo8GX1TRL+QU080T6k6BmI4p0alNEHG8hKNfl/vboVay/mpg3aW6oxXYJxrHiuanB6v7x4MBmt7WG69/qSQgVJW9cjCwCvG4iJgCXdGgo5McWEKdIBg5iXeWv1R1AYRN28f5EXtw+vzQCybvqwRTODo+IpYEsnFGUJ3/JAtnG85he6VEPQtMW09X5EhP8ms6ldyDGQpO5KHqq/ozzgVosGRdXPInpEXYbqm2TyzXwHyY9fbJ+9U4gQk09KIh7otMonOQ1y05rX4hCBubI1fHm1C1l+v0o+JWN8DLi7vmwQT9zDNFY/sLkuYjXqsOU9oBembtqMTIiVbA1861OnBkM5slOzE6DgO4ve92v5vzZrtMtr5UEi4dQ8/YR+DGGrsssSAgu2/r1a7VGR4Od25z7na1RNY+A4A1Vrv9AywCqn9958NmWB6swaInO8f+zU1VZ1dPO4OPus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9030.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e5gW28G4PLS0OXvWGQeKlY6ymlsPI/WHbJ9j9mziNWz8/WjZrCHBmbZVKrNJ?=
 =?us-ascii?Q?FG1tojGIkjENVmGQP0/HX4phcNtMNfB00XyvRTSGjeBaZeEMTRzbetlk6gBK?=
 =?us-ascii?Q?khD6C2ZXfzkFw9KTYgxN1ReerSMdsAlcVuGpIesdOkm4Q9qF9+PWLMMPnyHV?=
 =?us-ascii?Q?mhRxRif905E3GbRSNJ/dx2u02rxCbM8myY6E8g28DdojSDDRTe7JexHifeRt?=
 =?us-ascii?Q?DlvSKQFlT2+Ne2WledvlVGluTVEaDslaqgckWcUYmNyDo+rPWN5WIUfkWdCA?=
 =?us-ascii?Q?UklWpEda6KNZZC7jmSdjTiQCE2Ftqg9WKOk8rhw4SNG51Dargvh2ru1HpiiJ?=
 =?us-ascii?Q?fxXlAEFyf81iSYR3Fm9cYhUdZoFcIUg/BPJW+GoJ3GpRa1LfsABMbLEU4jsY?=
 =?us-ascii?Q?/MUO2ae4x34joSY2Maetg5f+l0c6SG5HHQVHzmvpJQ0f1T6DnuAqS2DUxfX/?=
 =?us-ascii?Q?/CXtOQ74bXghm79nUrDL97hIFO6JhDzDx4zJvT+OxROGuBHu82IvGo5BIIq8?=
 =?us-ascii?Q?Ib4W3HanvF6+gSk4+jsYEuZwkYfVb3GUJ+Ar4ZJ3uyBG/9USonwTGTkZ467i?=
 =?us-ascii?Q?VbYzFzaPvl1PyQvFUbl/CCg9qg2VpNCj5bGuFBaNMriVqm3+xUG31qFaqPSA?=
 =?us-ascii?Q?3aG8fbeLG3d0LPJYqoDorIw448YVvrabHBAGzEBelyuBja86ghB80qVpNe3l?=
 =?us-ascii?Q?vkeg8044ioWz4woY45m5ofEXb8e6TXy6S88RUl+s4OqgYeczVH5rCWkpl1pX?=
 =?us-ascii?Q?PuP6QRpffUsGJKHlKW4B8ev7MXbOa39u/03p+thRw/Glg9OPCYMuldVSpALy?=
 =?us-ascii?Q?QiGLSjqiAW4SqGmLM6M16BUlkXhsL1oYub7L1hsCOnBmUvhi2OUpgioPa/2L?=
 =?us-ascii?Q?cpBvhD+45GYOkoJOeWxZEuMOhI54HogNy7ljLRCA3Cn4eduYuj8Ld9W0rRF3?=
 =?us-ascii?Q?FyBD9dwDYiKCFzxDXvnP0iocFAA4L/fnJgDUiKmsPoxFEwRqpMj2JZmOcgvB?=
 =?us-ascii?Q?e9Z5fnVfb7CRHJUJ5VPozRTFzA2PCLwRkNE/9/qaqifupcqzgSB8l1oc1wRI?=
 =?us-ascii?Q?RDgAXfSu/ONHc3tCdv4LBjDuuUXTxIIfK61XNDAzszHjpAC6jgPj+j3j4EQJ?=
 =?us-ascii?Q?Wlpqo7J7zGhzzmGRwPGZDvzwQPybSw+zpy6/vLTW68W99yABktyzWjUSzokP?=
 =?us-ascii?Q?PXfUjPvmjo22A+Of7sHQTEWHvdLhIMkoowWTcZjwwBol/3V7uryAQkZilAKK?=
 =?us-ascii?Q?0F5gcvncskXVcZdIm++ndEM6lu8UbV/wrf5iyzFIj6xDCs7OT6O79WaZg0Rk?=
 =?us-ascii?Q?I9QUU8j7Xf/BSSBrOWMGrqDzDZ+RwipaM7/bOLlpNH/aW5F9YToz0a98ULuM?=
 =?us-ascii?Q?yGYTFSpX69VGDbMzULUZx4VgsZSCLMtgnS3imAiHjAiW7Sh7tq/vgsm5XUZj?=
 =?us-ascii?Q?+nIVvIX0bEvnzCdhI6Bo8AK1YUZYOtrfqJ0VFYq3bNB/WiO/fGCj5upMllEo?=
 =?us-ascii?Q?985dap8k+xJrBgCFbyQ40c531S3Ja/FpGgpM6MNO/k0uA5hdlz/350Rk0Nz+?=
 =?us-ascii?Q?x4JFQpN3aT9w5OHffZpdxOh5vMQvcpUmFlhe/+2uAMBpCrPB8InNuaf98MDz?=
 =?us-ascii?Q?giSgk2cvA2rS3mh5bqoaHQtStAjcVOcK1xBkVb492WUon4KmEVPvB9EAPc9O?=
 =?us-ascii?Q?JHFYCApgW4M6s320NFB7VCxOYe9u9Qcp9ze4zWSskSSYDbc8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68c945-180a-47e9-b630-08defed39e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 15:56:38.1557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1r8bttrayAL9E2IXwXoqU3+2xGII5IRiwg+JpmtjZOioVLNJDeJ9AmcDaZ9dP6YTPMt3tu4Ytp3w5HLPRudPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=mhonap@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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
> From: Junjie Cao <junjie.cao@intel.com>
> Sent: 18 August 2026 15:23
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; Ankit Agrawal <ankita@nvidia.com>;
> jic23@kernel.org; dave.jiang@intel.com; alejandro.lucero-palau@amd.com;
> Srirangan Madhavan <smadhavan@nvidia.com>;
> pierrick.bouvier@oss.qualcomm.com; mst@redhat.com; imammedo@redhat.com;
> anisinha@redhat.com; pbonzini@redhat.com; eric.auger@redhat.com;
> peter.maydell@linaro.org; richard.henderson@linaro.org; clg@redhat.com;
> cohuck@redhat.com; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; qemu-devel@nongnu.org;
> qemu-arm@nongnu.org
> Subject: Re: [PATCH 07/10] hw/vfio/pci: Map the CXL memory on the guest
> decoder commit
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Manish,
>=20
> On Thu, 13 Aug 2026 18:36:20 +0530, Manish Honap wrote:
> > +    switch (le32_to_cpu(cap) & 0xf) {
> > +    case 0:  return 1;
> > +    case 1:  return 2;
> > +    case 2:  return 4;
> > +    case 3:  return 6;
> > +    case 4:  return 8;
> > +    default: return 1;
>=20
> The encoding continues: 5h =3D 10 is the most a device may advertise, and
> switch/host-bridge encodings go on to Ch =3D 32 (CXL r3.1 8.2.4.20.1), so
> a 10-decoder endpoint takes the fallback and "walk every decoder"
> becomes "check decoder 0 only". Unreachable while the kernel gates on a
> single decoder. cxl_decoder_count_dec() in hw/cxl/cxl-component-utils.c
> already carries the full table and this file already includes its
> header; reusing it needs a floor of 1 (it decodes reserved encodings to
> 0) plus the stub treatment patch 6 gives cxl_get_hb_passthrough().

Agreed, there is no reason to keep a partial table. I will use
cxl_decoder_count_dec() with a floor of 1 for the reserved-to-0 case, and
add the CONFIG_CXL stub the way patch 6 does for cxl_get_hb_passthrough().

>=20
> > + * GPA and never sees the host physical base the kernel shadow holds;
> > + the shadow
> > + * base and size are not consulted here.
>=20
> The cover has the guest driving its own virtual decoder, and this patch
> handles a decommit. After a decommit, what refuses a re-commit with a
> base elsewhere inside an oversized window (patch 6 only warns on size >
> need)? The kernel FSM runs on the written shadow, QEMU maps at the
> window base regardless, and the virtualized read-back also reports the
> window base, so a divergence is silent -- guest accesses at the base it
> programmed land in the CFMWS trap instead of the device memory. If the
> FSM rejects any base other than the firmware value, a comment here
> closes the question; otherwise the write trap already sees every base
> write, so checking it against fmws_base on commit is cheap.

Good point. The guest is only ever expected to program the base it reads
back, but nothing is enforcing that...
I will check the written base against fmws_base on commit and
refuse the map on a mismatch, rather than rely on the kernel FSM implicitly=
.

>=20
> >  static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
>=20
> Nothing on the unrealize path drops the mapping: the teardown runs at
> instance finalize, and the mapping itself blocks finalize, since adding
> the region into system memory referenced its owner, the vdev, and only
> the unmap drops that reference. An unplug flow that resets the device
> escapes through vfio_pci_pre_reset()'s PCI_COMMAND clear; ACPI hotplug
> eject unparents with no reset, so the vdev never finalizes, the VFIO fd
> stays held, and the guest keeps reading the removed device's HDM at the
> window base. Unmapping from vfio_exitfn() with the rest of the
> unrealize-time teardown breaks the cycle.

okay, I will drop the mapping from vfio_exitfn() at unrealize time.

>=20
> Two notes from reading, no action needed:
>=20
> The BASE_LOW[31:28]-only substitution is exact: cxl-fmw sizes are
> validated as 256MiB multiples (hw/cxl/cxl-host.c) and both machines hand
> cxl_fmws_set_memmap() a 256MiB-aligned start (hw/i386/pc.c,
> hw/arm/virt.c), so fw->base cannot carry bits below 28.
>=20
> Migration is blocked today by the auto-mode blocker your patch 3 comment
> describes, but the destination path already holds for the day that
> lifts: vfio_pci_load_config() pushes PCI_COMMAND through
> vfio_pci_write_config(), which re-runs the commit scan after the
> machine-done notifier has bound the window.
>=20
> Many thanks,
> Junjie

