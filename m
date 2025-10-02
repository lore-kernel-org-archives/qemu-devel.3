Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B594CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DtU-00084A-1p; Thu, 02 Oct 2025 03:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4DtK-0007ul-V1; Thu, 02 Oct 2025 03:38:19 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4Dt8-0000O8-1z; Thu, 02 Oct 2025 03:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YooJCDsXwcUTurtdKw0GHDcX2DS3m1cJH1AAPSMWUvOAWO+7F776Hritvu3+xlovcMrqF7LQnvtrWVDRE8tGUeVIwIdxAvfaTQhiM+gQCZC6U3owC1rGZso0a0AkVbhUQk4P8CoVB/mXoYdcxizgx+3F6xy+y9RNEFh3Yi5ZL3bIZ3WEjllLAsib2yLKq1kWmb7FxvfyFeiDt0H8l596C90ZtgYLX96PLBc07mxpaPiz5UGqztGpf7FCRJrgNa5+DQMbbA/eg2wyXN7RhUahM6WVm7VPcf5JebqsBJRX4CUmrzhFOojDswUIzU9YMPG6YzFUqO3Qt5UsN5h7PXF1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoDyaJOA038Xlm5n1IAEspX5+hv+3OevZA4PYIb5tZQ=;
 b=oo9PH9og/PbYOqnE9DCeQngnBZ5Dk+CIKptqu1g8PJXeWyKm8MhrEEAek6yfK//hFOVfAz+CkMsa8bTaiAa2BLhbKu700zAJW1NdYicQvJewzZrSG5fw1majNayN8zNJIVidjkRq0V9eqKw6ltZGz4RW7c79PZo9pADGmHUVteqfYitH8x1AtSRmnrD/6tAqgZTdlvCT3rvuPx3H48STDT5OwE1VXhF9T+zufV25Atc5L3NzjXrhaZnau7YwuZHktOkkst3R3mlC95qcrH7OZdY2mNWImmJrCIJfdh7cjTJ6Dkl7QIT4rFXD0tu0o/b0/KrcPCBpuXt1561uQCz3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoDyaJOA038Xlm5n1IAEspX5+hv+3OevZA4PYIb5tZQ=;
 b=qci0DyTY5J3wZTxFS6a+w4XLZXoltoEyxuesIYJSRIh7qcaBEua28EINsh9xyGgmIO6LiYsWmAmNvr7+kHxinMbS58lbhYAIWvJgyg7gMuxzqcDY3l8nVLTTOQx6P53TJUeAl2sExEZUSbXHNr6azoZKwsl8aG/00D2mlH073J8n6/XPQAnbJHSyMV2+b+C4GhLxZ2TPU2Xf8lKWDe1ROF6Z+coe0HY+ej3Qg1Ssi3X8gT1u/KgaWJUF2LqcMMPaIXn5DWpP7yPfoHMzUcYuvD5XsSSvPfYhOXrBEv7RFcg1n5R3LO89NrvBLEUWnJ3TE/tjGizRhgiKNANWiiQGbw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:37:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:37:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Thread-Topic: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Thread-Index: AQHcMtLEPA/MgQKh4UGAmorIYeppLLSueF4A
Date: Thu, 2 Oct 2025 07:37:46 +0000
Message-ID: <CH3PR12MB7548996F62446259F99BBBA6ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-15-skolothumtho@nvidia.com>
 <20251001135604.00006776@huawei.com>
In-Reply-To: <20251001135604.00006776@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV3PR12MB9258:EE_
x-ms-office365-filtering-correlation-id: e1bdbba5-3931-4054-2b60-08de018694d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LpmPoTFHFs3kqihJpIsdrS3W0FO/K5qQx4zEo3nST53A/LEwzY4tRw5lBlJn?=
 =?us-ascii?Q?SAjG5BzZDSug3+7mPt4a+arI1K1aaSVdvElS6ahtO/KFxUNkTC09JNVJUK1d?=
 =?us-ascii?Q?cZ6fp59mwpdNm42cwW5FdxC3cbnd2k5xsM2re+UZXikBuuJ6ro4d+uF67HQ4?=
 =?us-ascii?Q?2jnP6a4Bq5troeVlc5HwfYqVsSUoSvPwg3CIPv/WGxD0o9SsPTvNlqLu9jnV?=
 =?us-ascii?Q?JnWJ9iapIL377zXv/6jgGhPc7RkUJO8l5xK61telIn8iBoT8ymNfEJCw1/Nw?=
 =?us-ascii?Q?ee2eU7akCQhWN3NSE/eMdowc9WnqUVihMjHh9+TlkK2aRmbhfOnrV/MWZVo6?=
 =?us-ascii?Q?ociXrYJ0JO6Bwt+8/+EX9xCcWvPYi16PEAMByt5uUo4qtNfkLnd9PwyTWcyZ?=
 =?us-ascii?Q?f614vC0xF00rerZUwrBzop2g98wB80/ENpxllGigAcgZr9/AAidFKHnFD/f+?=
 =?us-ascii?Q?Cr1Nn6asGNrIOF139ICA/Pa0o41SqdyEjc8xulJyelFE9tptNm/vIug/GS6c?=
 =?us-ascii?Q?jOotXIuO6h4XwIcYE/zQAaDugkC8Z1GKRI/OJ4aLRmM84tRoIi2nUifMuAxZ?=
 =?us-ascii?Q?ngkLDCbmXz1dDhDgf8fwm0ht7hQ8QLRF+TBtOl6hcDFb31OTrXfQ4Di4uj/p?=
 =?us-ascii?Q?egJRXlNPsPJ+gLFrWR4x+dJolxQZl+V5AFl6AGWMg9dliXw0AB8ApaohZKxN?=
 =?us-ascii?Q?8/Ek35vWSsCRKwph2BYNVq8moUE6ZiUkgpD7EXeuXTwS274R+RH41LC49IOK?=
 =?us-ascii?Q?ixR8hdJmz7iP3uCbj9iNdvzsgmLoAZjIWnqbiZKcBvBIyUp41sVRhyGRWXHb?=
 =?us-ascii?Q?Lpz6a/ovx7VqY+F/UpL6JOIBPy83/NiBpco8uoDo4K1OxAV6znaohX7AytUW?=
 =?us-ascii?Q?/7zNW/4VU391aIuD6JKXLBH6OunRX4Tr2yDmPIlk1R3KbgMtW/eYqlq8GNQi?=
 =?us-ascii?Q?EntoumIkvCW8TdErP1ChmbMUfdZypsdEm2frCe/c1HPNatApItwt5sfrVehj?=
 =?us-ascii?Q?Jgyo6GtmjQFQM6VS+KPv4z/trrFacSqcowRZlgB5/ns2KzjIW9s0R+AmxYZM?=
 =?us-ascii?Q?A6q64GUqunR4l44SF1rZEjE6Aa98X6F2MtqX1CP8Pen7bPgQHwYXA2xDEleS?=
 =?us-ascii?Q?jAuZJPoPpneygvOGlltwJij6ydayb+SsMMpT14+dp/hJ/ECl2byD/LCOMK2O?=
 =?us-ascii?Q?19f22fxkGlSCRSLz5wdgmiChILrpOh69LjM0i9+9T9Xmn9RX/tbVx3jqoxE5?=
 =?us-ascii?Q?YDiHJCXMg09geSoDqlgc9diM31YrFNBg/DECLnqjDdVglpg+6Y28HOQcipXh?=
 =?us-ascii?Q?pp9gfIO8mkmzZyQjQbLsEla6OGRgkhlP+2+cbCiZQxbBByaoi7Ng8hNkVT/M?=
 =?us-ascii?Q?sTXS9j2WpClr5CFH0omEXB2f0JqA7ercJjQ7MdMgY/j7cc7C9l0ZzIXT9xKY?=
 =?us-ascii?Q?6l1qSOi27BsB1hSz7DKRwaQGzTOPYAilI5aQeB0dIEHmpI+ekn3tqx3MMB7u?=
 =?us-ascii?Q?JGXzC0XDCXfbm9q2GN7x9Onzv24d7UULOsgc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hRg1g/3A9qKJM7XfVxdzdEhUWhKjazi/aSiv27peKCpbUAc4qdPTabTvevxN?=
 =?us-ascii?Q?T/XIHNfn6KajzWqvMCknG0nBWAzDpnTgNS48nyYvtQRvKm18LDAZvbUQLmGO?=
 =?us-ascii?Q?f8yfG4Ci+KEGO7hxVD509mTi7cHx+DTiOc7itopSnnUAs5srzM+QlKSg/Us5?=
 =?us-ascii?Q?9BEF2mewcrynjkPehPLQr5V4hDaXnqa/Ta1b4XZmUKr6QNhuyai4Z29dR5Cn?=
 =?us-ascii?Q?jNHDRR+sRh73uNncRTF3/J/Inm6BZSNKdghHtCzh9rGlmuxXFF50xYzeAE3m?=
 =?us-ascii?Q?N1tLaRfs6P0blgvi8JqafnSlYjR4Zu1dVGtcoX5di+vahGBJHtle3DozHsv3?=
 =?us-ascii?Q?MdvtWOdxsTK1JQYI9UUGJLGKjdQ+OJtfOGghpBii77TTo8eK+hCylx9U17Gv?=
 =?us-ascii?Q?nTugdygqBjh1UH8OUFrMebGn9dRGKnpMzMqcIAmWsVJ/aipM5piscDSLx0O3?=
 =?us-ascii?Q?wMqsp5Kk+9lYbS8xzgFvc4X3IiWMl67JR4cwtB84iGlo2n707x0aqYqc+Vnj?=
 =?us-ascii?Q?MzPjKx6FcCSMDyrnwmECuaCNrElyAAKFGAZldDW+YJ6OHcE1y/SCgafW+ZQh?=
 =?us-ascii?Q?bqRuDZWxPuo3JGsy8jtRdXbvaf34OG1xYVMHRk7SsYvwrKgTaQOD8DINkdal?=
 =?us-ascii?Q?M8nEfmYArr7Jo7ZBZLFR6tN+MmYB8bFvJYWp/HFk+Il3fboRrAhLo3vZTDpm?=
 =?us-ascii?Q?9vPxskFxuxNtBvf8ScbSnVbLrTJSUuwrgqHNKy4T3m0X1aqnDXMtUFyn2IMx?=
 =?us-ascii?Q?1zHMyGWHsN9WavXNvQpGnW9WydDv6rLV6zdBgG6dH8Piwe/ZQWqVubJRWy5E?=
 =?us-ascii?Q?BwPwpjK/deDlV1ge6TIhlP4we9KX/8ER0Di5VWk/me/w0NtNy2yC3Kh76p6E?=
 =?us-ascii?Q?9+8k68aDnPM2D5HYTk2tFyI23bvm9hONS+0dI4EYPxGLuZdPlHe0NMaQoAfY?=
 =?us-ascii?Q?xwNp+vA67cI99v05OD5bq/6cyHrkL11bQLBAUddbo7CA6MuyT0GbHaQxp6FV?=
 =?us-ascii?Q?Ju12wWEAAAd68/4PVm34RBBvPvI5x71pbamTurr0KoIsEScFU7p4uyY+q0Am?=
 =?us-ascii?Q?22tAgojgkj2pjB1DPltlGQ9GA+Dw250Rak+KxhrcOuFVMNaZiXH7s6DWKH9n?=
 =?us-ascii?Q?R45Ww4HA+fRLc/Wn1NskD06vP+nH3EiCzCyBxpZ01xdmeVVCxQ+n+1GM5V1U?=
 =?us-ascii?Q?DlhbNIqFR+TeKU/FpcBRncjUGYvlnKAk7RtnYw/gzuW387qNMTleEOfnI74K?=
 =?us-ascii?Q?cUbNmwOwct72aV+9FdnJdLXfEbv6Ef9B9C/kgLOM75u4oNVVKfDjSCknbUI6?=
 =?us-ascii?Q?CEzxYoYcRCD4r+Dh58DlhcGb9BD4F6VjWj46TCkXHP2Be/+NOvirQK+Hsbq2?=
 =?us-ascii?Q?W/x4NJjf7HkSTWnV6MlBDmj8GefIg3FETvGQgwv6pmMvZ1iHaqlp4c/mtqtB?=
 =?us-ascii?Q?lKpNunz18Q3/xYLlO6ujKbiyBV07ogl3KgWgeEv5agFFPmJAXrx3iRKwa0WF?=
 =?us-ascii?Q?My8pLCorsXCGppiLOkzklhQHdJ/SQy5ZqGjEG7o0hUOVnpOfqTz2ItEWpoWI?=
 =?us-ascii?Q?qcBPEnY7kZsxnhLXt55KuMlzM/6+MO5V1cOTnJ+1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bdbba5-3931-4054-2b60-08de018694d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:37:46.6484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LgV/jXe2l1SHXTFKi7nsw7WOoFXhKQwAAN2PLylsL6Vzb7Lre28dHLGYaIrV5pGj/zawjviDb/PnIVR5S5gSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 01 October 2025 13:56
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw
> info and validate
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 29 Sep 2025 14:36:30 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > Just before the device gets attached to the SMMUv3, make sure QEMU
> SMMUv3
> > features are compatible with the host SMMUv3.
> >
> > Not all fields in the host SMMUv3 IDR registers are meaningful for user=
space.
> > Only the following fields can be used:
> >
> >   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16,
> TTF
> >   - IDR1: SIDSIZE, SSIDSIZE
> >   - IDR3: BBML, RIL
> >   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
> >
> > For now, the check is to make sure the features are in sync to enable
> > basic accelerated SMMUv3 support.
> >
> > One other related change is, move the smmuv3_init_regs() to
> smmu_realize()
> > so that we do have that early enough for the check mentioned above.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> Hi Shameer,
>=20
> Back to this series...
>=20
> Various things in the checks in here.

Thanks for going through the entire series. I will address the comments
in the next revision.

Between, you seem to have missed patch #20 though.=20

Thanks,
Shameer
=20


>=20
> > ---
> >  hw/arm/smmuv3-accel.c | 98
> +++++++++++++++++++++++++++++++++++++++++++
> >  hw/arm/smmuv3.c       |  4 +-
> >  2 files changed, 100 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> > index 9ad8595ce2..defeddbd8c 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -39,6 +39,96 @@
> >  #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH |
> STE1_S1COR | \
> >                         STE1_S1CIR | STE1_S1DSS)
> >
> > +static bool
> > +smmuv3_accel_check_hw_compatible(SMMUv3State *s,
> > +                                 struct iommu_hw_info_arm_smmuv3 *info=
,
> > +                                 Error **errp)
> > +{
> > +    uint32_t val;
> > +
> > +    /*
> > +     * QEMU SMMUv3 supports both linear and 2-level stream tables.
> > +     */
>=20
> Single line comment would be more consistent with below and looks to be
> under 80 chars.
>=20
> > +    val =3D FIELD_EX32(info->idr[0], IDR0, STLEVEL);
> > +    if (val !=3D FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> > +        s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
>=20
> This seems a rather odd side effect to have.  Perhaps a comment on why
> in error path it make sense to change s->idr[0]?
>=20
> > +        error_setg(errp, "Host SUMMUv3 differs in Stream Table format"=
);
> > +        return false;
> > +    }
> > +
> > +    /* QEMU SMMUv3 supports only little-endian translation table walks=
 */
> > +    val =3D FIELD_EX32(info->idr[0], IDR0, TTENDIAN);
> > +    if (!val && val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
>=20
> This is a weird check.  || maybe?
>=20
> Otherwise if !val is true, then val is not likely to be greater than anyt=
hing.
>=20
> > +        error_setg(errp, "Host SUMMUv3 doesn't support Little-endian "
> > +                   "translation table");
> > +        return false;
> > +    }
> > +
> > +    /* QEMU SMMUv3 supports only AArch64 translation table format */
> > +    val =3D FIELD_EX32(info->idr[0], IDR0, TTF);
> > +    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
> > +        error_setg(errp, "Host SUMMUv3 deosn't support Arch64 Translat=
ion "
>=20
> Spell check the messages. doesn't.
>=20
> > +                   "table format");
> > +        return false;
> > +    }
> > +
> > +    /* QEMU SMMUv3 supports SIDSIZE 16 */
> > +    val =3D FIELD_EX32(info->idr[1], IDR1, SIDSIZE);
> > +    if (val < FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
>=20
> Why not
>     if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
>         FIELD_EX32(s->idr[1], IDR1, SIDSIZE))
> I.e. why does the local variable make sense in cases where the value is
> only used once.  To me if anything this is slightly easier to read.   You=
 could
> even align the variables so it's obvious it's comparing one field.
>=20
>     if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
>         FIELD_EX32(s->idr[1],    IDR1, SIDSIZE))
>=20
> > +        error_setg(errp, "Host SUMMUv3 SIDSIZE not compatible");
> > +        return false;
> > +    }
> > +
> > +    /* QEMU SMMUv3 supports Range Invalidation by default */
> > +    val =3D FIELD_EX32(info->idr[3], IDR3, RIL);
> > +    if (val !=3D FIELD_EX32(s->idr[3], IDR3, RIL)) {
> > +        error_setg(errp, "Host SUMMUv3 deosn't support Range
> Invalidation");
>=20
> doesn't.
>=20
> > +        return false;
> > +    }
> > +
> > +    val =3D FIELD_EX32(info->idr[5], IDR5, GRAN4K);
> > +    if (val !=3D FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> > +        error_setg(errp, "Host SMMUv3 doesn't support 64K translation
> granule");
> That doesn't smell like it's checking 64K
> > +        return false;
> > +    }
> > +    val =3D FIELD_EX32(info->idr[5], IDR5, GRAN16K);
> > +    if (val !=3D FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> > +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation
> granule");
> > +        return false;
> > +    }
> > +    val =3D FIELD_EX32(info->idr[5], IDR5, GRAN64K);
> > +    if (val !=3D FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> > +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation
> granule");
> Nor is this one seem likely to be checking 16K.
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +static bool
> > +smmuv3_accel_hw_compatible(SMMUv3State *s,
> HostIOMMUDeviceIOMMUFD *idev,
> > +                           Error **errp)
> > +{
> > +    struct iommu_hw_info_arm_smmuv3 info;
> > +    uint32_t data_type;
> > +    uint64_t caps;
> > +
> > +    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid,
> &data_type,
> > +                                         &info, sizeof(info), &caps, e=
rrp)) {
> > +        return false;
> > +    }
> > +
> > +    if (data_type !=3D IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> > +        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device =
info",
> > +                     data_type);
>=20
> Alignment looks off.
>=20
> > +        return false;
> > +    }
> > +
> > +    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
>=20


