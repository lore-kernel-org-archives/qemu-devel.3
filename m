Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E554FE9412E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 09:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaVbM-0000mQ-V0; Tue, 30 Dec 2025 04:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaVbC-0000gb-9h; Tue, 30 Dec 2025 04:01:02 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaVb9-0002Zk-Hr; Tue, 30 Dec 2025 04:01:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dREdK/PmXtednbytXEXNCa2+RZBN1sxrSqBgo9cnK51L0ln7CcXCzctazw5qXTG1p1ULfnxi2Sxu0XQcLuX+YiTkdsBBG8lVWlcIEwZJ+pF/itvAIj3sZtvMRgkTgA62ZzPHRO55cbBpBQJYRcBCC/k1lSOBnAG+uECKuj9tp2zUmM/w3QCipTY+jEAfbPuA7D4l/41ut13Se0XwQ9oJSPQCmUxNUXPNaNX1yCsMa2mRVvABM4+Fck8cpp4Wgmj1NmmKASLOzWPpyrLzIqoUOqG/zLzK1jRcSM48aPwcwEb9un0K2PLU2QDRGOTpzQmolL1Lt7R/Vo8pacwDmdRD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqlu+K2tL0dzOk3yiZHvk9rLGqeLOJfPJBDe46hBjb8=;
 b=oWxj/02hwi3DhDmGPNYMLKhkcpNL6/ikE+CtpQv8Tk7rWR8fHtcLPOR3Q+WCWvlyMuJ9ghpujwblk64sy6yQc6uRYZTppEbYcwqrG5G3+R00Laq8Ty7oIjB3dbX5PaNRHdYmYqJFVbrhCscU9n+8qoOZ3xZBm7ADtA2ZbDE+kLNQVZI58yZMLSuY8AmB2PAjya1GG5XnssxpCylpGEx3f2Wu3uM/u9k/JqgtRMiQ+gd9/+iBhE9ZYdtXRP1D0A/l1a8GyMk9Sk1YtsqSep7DLUw49HGvYyzR8kYgEggOzRI79h91sLLON+Sv8vO6eLOpDrBalISeSeeyo3R97fvaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqlu+K2tL0dzOk3yiZHvk9rLGqeLOJfPJBDe46hBjb8=;
 b=ODj1El/js46nQ3DYMzV+fFE3Oe4WueAbebJb0/f6GQrI8XF5oIXmZyUKNqbBjCdw8uMTUZaFHHTOyVymFve6jdMIOB/a4X0RE8vnNsiG0gdS+St9BW2n0tmL0eY637QbEksYQ2V9MHJ9EthoyyB9VzrvDjvvejP+eVagXvBi3RfD1RRT+zLNM2rfiXOw4+0uSW/UeAEge8bs5XQewB5LFYSfuPnzIw3krYZKDI9NcM5XdYP8QwSh6TFz2JI8xcofRPpqKYJq5bZgcQ//ZQ9oC7INVp2RbmzRhWye6xDNIoTxlZkiwdUbLlARlZIBG78jnBJs+VmyQzrvvldOgRF35A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 09:00:54 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:00:54 +0000
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
Subject: RE: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Thread-Topic: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Thread-Index: AQHcadqP71vRjdLaMEyQWnaXahlP+7U5GQUAgADkFKA=
Date: Tue, 30 Dec 2025 09:00:54 +0000
Message-ID: <CH3PR12MB7548FE82C4296FEC792CB72CABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-6-skolothumtho@nvidia.com>
 <aVLRbI2dYkvIwEBv@Asurada-Nvidia>
In-Reply-To: <aVLRbI2dYkvIwEBv@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN2PR12MB4093:EE_
x-ms-office365-filtering-correlation-id: 01192526-2d31-4422-d089-08de4781f078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?06Ou6sbm7pYXaVqeKMEKieVcEU5gVfNri9hbHX8K8fOLVzrfKyRYhsQTlCqh?=
 =?us-ascii?Q?GZIfrc336V83cyS8JtoACSepZ/3Df9kZTXsJE78wteuYyjgjTCO7pKOmOvIj?=
 =?us-ascii?Q?vs0aALHslK4Xzxom6UUKP0ZIsGIyGHgA47ioKEcTB0LElrsqlKyxzkWGivLz?=
 =?us-ascii?Q?Z/oqAGFaIcTJQQaOOEdb8g3E4uph21JaqcIgqpmW22qXK654VLGL6KISGP8v?=
 =?us-ascii?Q?NQlOjtOI54Yw0whW3ngKry5ppN9ph6CdAroihW/Ie7bC80fhWTf+eHyQgC96?=
 =?us-ascii?Q?kFQzweemrF244XCj+n6oBGraz53DqcmWiPAXDK56c7ovy0oGjyalC5qgPncI?=
 =?us-ascii?Q?j7tkY1i8vdVgfmt7vq2KgM5TYZOSH7ZAI2ptQUVQIEw7A3LVcjrN3Zm4B5T7?=
 =?us-ascii?Q?UWWT4i8ch4OSzG5QeRvLA/1+VSPC11gCLRAA5SwHX3MYs8yeXDhFmRhROZhj?=
 =?us-ascii?Q?O/hAJXV0ZMysVyzWTxjq5YYB71mceQSGvpjd7wVIKiRro/9Fiu0ljTZ4pQO5?=
 =?us-ascii?Q?6jugWPYhxE2y8GCROjV/a9Gh8Uu9GcIIrVn60clEN+OxSm+kAFDDHs4PuL5H?=
 =?us-ascii?Q?PBKBX2DGTD0LUKvKq9nLd6bU392rEOcjLTmQddYZt9Cu1uOP6O++PPJPDLZL?=
 =?us-ascii?Q?GOjSVlyc1Zzy+D7WA95+qeg0iLm1D/NsBLhsxbWPfNvr0oS1WuQ2UB1Bp/7I?=
 =?us-ascii?Q?VCXN+8PZ82aXQQ4lzvARqWzC0eOsv/4e6MyHnwuBScAcUHPCszBu7iqBhKHc?=
 =?us-ascii?Q?L0I1f8pzacEgVZsnipzDuaKYRJ0YETdS+ULBPNVH5EFEVxqN592AF2nQ7reZ?=
 =?us-ascii?Q?wUYLa5oI27TtmRToQQXoAO6vnTny1G8TfnnpBZDZcsYSEhz+Z2f1Wn752f6C?=
 =?us-ascii?Q?rR6hg7vWPsd9mHijTOX+qcj7DLE8yeq9FWx9Qy5QLxlqt4aAPqipV7VsMrel?=
 =?us-ascii?Q?iXUtJChIEMwcfQY2ByQL9H1lCaVemK9zsRXvKkNG5JiaZjuZlb99L0ONlNIX?=
 =?us-ascii?Q?jKnwCWGkc/a+llI+TreX/51ezhbjHt9Lue5/kfi+948g1Kaj+VJcIgPYEaMx?=
 =?us-ascii?Q?i4jCempe+bXVHSAubTZSRxXPgH5InNvL1Xfoi7l+FqyFWBPeHM8Rx1eyumA+?=
 =?us-ascii?Q?jnqDThoE0WmUvY2jepMyUZeZpUOaSlUOpRzGVWxPcLrRci07oPdxDvyS/3gu?=
 =?us-ascii?Q?y0sCyOYCjzYM4tEl5rt0TIWmg9Mn/Wsl5fy4V6ekYP/X+ks8X4DhValh2pI3?=
 =?us-ascii?Q?w1jKSxejM12GOMMMwkbZ/3zxp6qVZ4KcFYc7+fc9Hp1FwuSjgIheNxW+PVH5?=
 =?us-ascii?Q?c436/J+oR+a56ZGBCv41j9S7gOq/stBM9k7oi5c6RLa1JxFwvXAHuh50B890?=
 =?us-ascii?Q?P9hRJwZU7HjkvmSvUlFdsON+X73KBAUL1j1PeOETcIYZ3WQCC45xJtF9v0cl?=
 =?us-ascii?Q?wWemoR+fsR+S3yNT9bwMVoSDK6kcVIWF8wzUvg0ofhV2Ouw7BMSJnJNIXKps?=
 =?us-ascii?Q?UGw08XBuYeBbKnDUvPh5OJnRpVgBx3Han/Ny?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DRgN62C6tvQiyA/OVxafdDjHWwBQKqo/kojwABENqG1zq64jhVRkGYEMGIRk?=
 =?us-ascii?Q?rfHw99jsB484UwQF8s7dbXo85ms+DlpzVarf3ipXRk60KpjbOsnmGTSU3DBv?=
 =?us-ascii?Q?q6jN2An6GtGyTMcOJ0Kfo/qxGfPQSOdF8js3kHTkeec5BDUlqZdCkRb/0QOM?=
 =?us-ascii?Q?9lauw+dc84jKo8VzZTaU9rf6O4lV2mTqSbaHqZlzzxlC2zxPCAuy5eHFPJkk?=
 =?us-ascii?Q?BXEprvrF6iLptPDCuQvoI04bO6Ur4+fnDV9xm1OmoMb5Dj9TKzNhvNY6O+g8?=
 =?us-ascii?Q?VKOlCaJm9WbpCA13M0SXGkHpR6HL5MpU7rhk7Zb8hoiu2EMjfjfdJFduBXmt?=
 =?us-ascii?Q?EShPCTv+T7Q4bMzbVBPiqAl2pLpnaCVZFXVCtD2MgSEO+uSm3hvl1iTWVF1b?=
 =?us-ascii?Q?0BVUKATszoDMv1ksE9+FulqnPLRKfogI5Gzv78iOhnARplsgA58A1uP1HpXZ?=
 =?us-ascii?Q?a7CL767bwg4gAtXUxkqFemCuHB3GCSxhGUgRQDrI85m8ntCxWgcugjIHA26n?=
 =?us-ascii?Q?iF+SmHz/RyzmBD7ab+/CIPx+uoVsRziuvelgVFfdASr9scaHvkUKkk0EZg63?=
 =?us-ascii?Q?IALjqSGYwdhC5EhttRwboovgTmWlqSrhibztiHjxZ0EXES18YdiMT+mIfNHe?=
 =?us-ascii?Q?8M+R5MBLw9T0FTEd12dj6HkodDiicIlo24RpBxcEKMGK89Fp1G70gI69n5ZR?=
 =?us-ascii?Q?QMG6xwL9S4hKsaAlXJv2szeL3iT8dn5d0igr5m7c+EW2F4CVGbcsfhPkHqwt?=
 =?us-ascii?Q?ZVzdCirgnI6aPfK4h9+Skszk1ApoX/6VtHif9ue9n2/sj03AMj8h1lC2M1Qy?=
 =?us-ascii?Q?GP8AFdb/SuwyHLXfD1xXkddSSb3as6aBaHkUEcRAmH0VBB2EP4oIgAm5rj6C?=
 =?us-ascii?Q?L+JgaDlZ3vDNC8zXd/iLn62qTf7DPGkm08Ae1dWHdJTrebe1FSzAI42MzzLb?=
 =?us-ascii?Q?h5cyQoKZ/BlqEC0hrh+SLq9q4Wdh2RD05votuZaCFVJCLs5MX+kintAdgOGB?=
 =?us-ascii?Q?2e6v322xydRiK2luTUUXWLN3JyoeDbHQnkOt8gJXM1jxQaxKFdrZVAUduSKi?=
 =?us-ascii?Q?Mw6j2Kheh58/6ZA2nyAF2ki67R5xMZ+r+RQBjMJ0sifMvrSMnzDFJMcEHtGa?=
 =?us-ascii?Q?qzMOtXftSkqZYqpi2r7fu8QxgIe1XNZwsD/+cFGjx86kIsoPeNzg9OUA1iVz?=
 =?us-ascii?Q?e0EiPMxkUgAgPbDgOKH4qYbHfQdJ9dpBb591Z0bk9/Ybg4OMd4QLN27YKfgA?=
 =?us-ascii?Q?hGX7HQUK4e3qQ6exbm7mAwmVlc1hMajJp+/34ZmIpfEtxB7nyS0kRJbb/a7l?=
 =?us-ascii?Q?nwkf9ssIuEdV0YOMD/kCShHXlZXmUpV9LxDJ9YztzGiLCXNSGjBnEPvWqqFY?=
 =?us-ascii?Q?LSoaHb5xS6tEyqC4i2nJBadmQLAHa0dotIXZRbUrhrT/tUB/a26OTfsXKtCQ?=
 =?us-ascii?Q?8tFx3nKg6svniTdqY9zQOKkTrZ5zRpDKLLzY4chgt6WlhC39GymORi7efLJr?=
 =?us-ascii?Q?oz6JDyPoVT4LPruEGEPU5zfg6XEA1ZMk2R5C5mfNK6lppmEXBY2BpT0hPlqQ?=
 =?us-ascii?Q?jM3Nkv27pb73vIBAZ3K1m2BTpu0DvZDWt0bwMad2APXjRDddXFcnuTT9kE6w?=
 =?us-ascii?Q?zm5FlgyvoLHRh3WmBbGkFSJHRhue9Ry/tSdhwyng7tf4vsalgomZAykUGhQv?=
 =?us-ascii?Q?Y79k48GieM7syTGA4cNgCT1ko6YgKtZcJbVtgRXb37H6RddHBuP4IjcPa67R?=
 =?us-ascii?Q?aQnak5Mfmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01192526-2d31-4422-d089-08de4781f078
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:00:54.3922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyohdinYwAsZKkxubavJN+5yht6oD4zySlOuqazxQeelWKST0qMuMQN4rMGEiebOD+KNKa1qTMsy1ISc+lKLqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> Sent: 29 December 2025 19:07
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial
> Tegra241 CMDQ-Virtualisation support
>=20
> On Wed, Dec 10, 2025 at 01:37:26PM +0000, Shameer Kolothum wrote:
> > +void tegra241_cmdqv_init(SMMUv3State *s)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(OBJECT(s));
> > +    Tegra241CMDQV *cmdqv;
> > +
> > +    if (!s->tegra241_cmdqv) {
> > +        return;
> > +    }
>=20
> Maybe g_assert?

Sure.

>=20
> > +typedef struct Tegra241CMDQV {
> > +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
> > +    SMMUv3State *smmu;
>=20
> I see all the cmdqv functions want "smmu->s_accel", so maybe store
> "s_accel" instead?

Yes. But see below.

> > +#ifdef CONFIG_TEGRA241_CMDQV
> > +bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> > +                                 uint32_t *out_viommu_id, Error **errp=
);
> > +void tegra241_cmdqv_init(SMMUv3State *s);
> > +#else
> > +static inline void tegra241_cmdqv_init(SMMUv3State *s)
> > +{
> > +}
> > +static inline bool
> > +tegra241_cmdqv_alloc_viommu(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> > +                            uint32_t *out_viommu_id, Error **errp)
> > +{
> > +    return true;
>=20
> Should it return false?

Hmm..it should be, given how it is invoked here.

>=20
> > index 2d4970fe19..8e56e480a0 100644
> > --- a/include/hw/arm/smmuv3.h
> > +++ b/include/hw/arm/smmuv3.h
> > @@ -73,6 +73,9 @@ struct SMMUv3State {
> >      bool ats;
> >      uint8_t oas;
> >      bool pasid;
> > +    /* Support for NVIDIA Tegra241 SMMU CMDQV extension */
> > +    struct Tegra241CMDQV *cmdqv;
> > +    bool tegra241_cmdqv;
>=20
> tegra241_cmdqv is a Property, so it has to stay with SMMUv3State.
>=20
> But "struct Tegra241CMDQV *cmdqv" might be in the SMMUv3AccelState?

I have considered this. Currently, SMMUv3AccelState is allocated in
smmuv3_accel_alloc_viommu(), which happens later than tegra241_cmdqv_init()=
.

Changing this would require some rework. I will look into whether we can ad=
dress
that as part of the next respin of the SMMUv3 accel series to make this cle=
aner.

Thanks,
Shameer

