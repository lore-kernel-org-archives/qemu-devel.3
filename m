Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88627CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvQq-0001oG-KD; Mon, 03 Nov 2025 09:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFvQm-0001kA-HT; Mon, 03 Nov 2025 09:21:12 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFvPl-0008W6-Sw; Mon, 03 Nov 2025 09:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRJD0GO7PBCwZbvfN5E80Y5GqGA9m7KD4U1ADtuulfLue8ooIF0xZEb05q07GDGBSgRjSIT7ZUzuhWxXbBBsLSBpC4sO05seV0HNCPbio32QC/N7jGCaIL3iUfIZDI+Qu+dUtuszUOoW/1TxTercNlOO2thXRCU4zhpeqatlu+D7uOeHhtysnTRnNSoin7IKGYGY5GIQw1Mm5A/JVp6ghGmPcMGTimOAT5YSz8c8RUmSXxi2fPQc32l2vCYjnBaw4rf8pL1qIEHcbXCreuHiys1YI2w67FadzVcH/aYUnz16r4wLzFPLCuxDsVCa5Q/oBRQGUa+0Qt4EG5zlX/xLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GCcxFZY971KmQMDUn65BZFoBQTtmC1GXmnBcg4WRSs=;
 b=nbOoq/EHFjORKbarlfqZ44c3Yp4WyuaajD6p1MzVNz8hnp3cHqsVEVnWw7yQazFHh+tXiahwt/snp+AWsSnWQG+oU59oC/oMIGEJS2iqxsPNumLHVU5C2kB/gy71TF52GjXyYW5GWKrnizrMuAqLagtKlS+W240LIc/Hncrw2ATdlgOieW68Fqe2gwi5iyZhoLO60oym1PHc71nwexjvo5FuY6hCrgGx9IYKgWYhQs70DQvA1aBzpCsbjHHxz6vdZE0LzVz0bLtx39gF6a1OylSZojxoQVGcxEne6Vh7MQC/J374hHgnuRtNTdz7qi/11bQWC1Sjlk4P2fznxA6ETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GCcxFZY971KmQMDUn65BZFoBQTtmC1GXmnBcg4WRSs=;
 b=dbygI+vwNIK91YfGPWCZ4z+2HIsD+3yToqCvH8UpMlrsvyNDH0PSr6fB9/i16ZxMSC7XSeq14W7PkVlaXF4yVJW8rcRlmfn7DMUIaQel3HTSW58vfddalPUuh8ihElZ8C8dGCQmA/DlAzAXalx6LZMLGeN9gTWSlcWT/RPAjSzqNtIJAXkjUOQpeLJczTCL/D2tpB3eG1kEdNg8lw3pSqJuYEXMCYg5zwnmI0dNTg0+tXxAB7uOYy9nARCX7fKxqNSkpdloyqj3UeymZwuaX63NXgJ+JzyDk80CQsrid50X7o2WL5Ug7dsz0SCh7u/gZhkaPWk/E+hNAJu4vLemXqQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:19:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:19:57 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 12/32] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Topic: [PATCH v5 12/32] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Index: AQHcSrIKdlczGK2/6EeDeSbD/FnVR7ThA+8g
Date: Mon, 3 Nov 2025 14:19:57 +0000
Message-ID: <CH3PR12MB7548494C494955AF8DD4EE34ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-13-skolothumtho@nvidia.com>
 <aQUx3e2ZtJKMgfnd@Asurada-Nvidia>
In-Reply-To: <aQUx3e2ZtJKMgfnd@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB7617:EE_
x-ms-office365-filtering-correlation-id: 67275b0b-9cf7-480d-c541-08de1ae41143
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jR6fDy67pXdWeNbrDCufCYHygTdjtAtaVTrY+1vUUQS70AeXp0ddf6TLTVW8?=
 =?us-ascii?Q?mS/2lTxWYZq/zbeyRG6NdRyfbDz78551t64QWt8MvlWM5H3rif/1p+pSeFow?=
 =?us-ascii?Q?b02FtXnL3WX+g79wj0OmLeuf5mcecNOZDdGPxwqcn9jlDGGiO0wWAM+KPBRq?=
 =?us-ascii?Q?GiBghaW/XHVV8mWYg12Q4yrZL46a9cMZDaJ28zPZjG+7zOk183s7l94VgAsF?=
 =?us-ascii?Q?kGMFi7Ifb5jL/bxDwI7MavvbHSqeiSs5lBVxvhQB6v/U9mOTfs/VUs+0fQBU?=
 =?us-ascii?Q?WxQUK0jLdUwarela8pAGB0rjTaLxBh7k0FoTvM4FN3b3SjGwYZEZN9sYjLYn?=
 =?us-ascii?Q?pTOS7yNE3mmn/DIKWjoQ35aMag4fRi57qFjomCbe8MkRulN6BUMWGCKEBgej?=
 =?us-ascii?Q?835+qApbvqxeC4zOkUzDsQgm4SIJNC13jx2Kija7KV7mFvxjznYuOw54rJ0m?=
 =?us-ascii?Q?C/pas+FT/uebFvGrJUUbp1MLZQSJdKY1aUYbp3j/rgpKvuvwPDnfBMlOcqq4?=
 =?us-ascii?Q?V8BE/DNwbv7bJAGWwMgW/zAEcKZdqTJYrq0yXalc+HW3KuarCjzs9mSAv6cv?=
 =?us-ascii?Q?ewej8HpupwAnH0sUFzc/pXksLeQQtMph17DX7JCTxIW4WNfuC7lgKg/X72Rs?=
 =?us-ascii?Q?96ChjKbDTFr51IiFp7XjHrod9VC+PliZ/oX0bXY/fiquI/Wjs7rJhTCYaxAA?=
 =?us-ascii?Q?UPGwnN0jJr10wGBL6nP6CWsZM7MPvvwkBwkn9CC1OaWEKk7iNyXBEmAbby/N?=
 =?us-ascii?Q?x+YnRyfVFDfapm9vP4zN8qe7qMpHPpMMncHkoTd4f3479Dk/c89bRkOnJ5Iv?=
 =?us-ascii?Q?goEQEU5tvQbG1oWn8Rjf4FTKS86sNJOGoYSm4v9cQKOSeVG2cvmu+8VdxKLD?=
 =?us-ascii?Q?USrlkc1IE2IBZ8H0tZZfNFGLvJb3J9KphDh7131EG/koK1YyE9Jc8Nx4qA/r?=
 =?us-ascii?Q?NdaFCiLIUkaHJxgscwUaZauI61vtQ9RsXk2xPiK+7cgcqgOC74LrsPz2XN0q?=
 =?us-ascii?Q?jtSnUbNAzQphvifp9Ee2lRkVW8BCEW8HyZOFGtd7v1Gboux0Hi5Ii/6Bo0mZ?=
 =?us-ascii?Q?qq8os2ZS1nkewjFP5N85WiqrawONzhOpj7qtwyTo/nNMGN6TQoZSEn/IY4JC?=
 =?us-ascii?Q?SqT+8BZAFgWH/y3ged3Sbe/4KQvspXhZh8Y1NGgku8cRZtm6YxejuJCE2dvT?=
 =?us-ascii?Q?Px9v1fSCTLeA+LJEG4AJrTKSJF9kyW56gbZlyyKWZoNdPd89hi8xShKvGtmv?=
 =?us-ascii?Q?Eacod333RmQ9zN2w5089S6szpn1peAKvn2TanDC5IhIALtUjarehqhdjbaUC?=
 =?us-ascii?Q?JUweHa9W/FFwXOIJHFE8T2EArpWI9Z2RdwCY/dQrEuvVLxEzvRG5u8wlcN6/?=
 =?us-ascii?Q?i9ZQd/KxnGbHQ2ZS6BjE5zLkptXTSd5I41e5BCEDlk7w5DtxfaZ+IwMBf3nQ?=
 =?us-ascii?Q?jB5s9yo2drBKdwMPBoz8kZT0sXhypPsoB8r2xbGPPvaOICBu8og+ekPoPupJ?=
 =?us-ascii?Q?mOFnwOlvUiKuvPbb/vcwZ1hXlpczmdN/TXiw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vT9TgXhGCXsj21/7AsN+quF8dMvB4VpiYDmDGKC9ybceYpT4G+CxRq9XhRb+?=
 =?us-ascii?Q?bKv1IS7/DNj+pgvg59qCLqTGNE68YT7jYwJDCwcHRcyufU+IY7Vs9dxaLHrg?=
 =?us-ascii?Q?8x6f0Tcrtt/IF0RV3sR0V0zfFtSAQM+QuBWAmi89wuU8WioryVxK+tNdmUJ6?=
 =?us-ascii?Q?4z+WJK0cUzSNz/EC5caLB0BFwkTEMeyhRE/KQ7CuddLWSNuWvAKRm9GHisM7?=
 =?us-ascii?Q?MhfApNHih+jab3h2KljNW16J1bUM4Zy3X08TU6R7OHPL2Cb0xqsI5z1ls9RN?=
 =?us-ascii?Q?86UdL0e6yO03ip/DnJ946x+6xzjlYmRn82bWLhks0kMWygtKKVxE3iK+WYPS?=
 =?us-ascii?Q?rctyyvGXcotYzgGAi0MaXuWTM/lCONEuH9NeokBRCUAytPFHupts7vw1a4g1?=
 =?us-ascii?Q?lgMknNYwZ2yOk0zmNrp6k8PaHhdJ06qC7YV32HipXdUwRAL9kQj/FuxwEef9?=
 =?us-ascii?Q?wCuG4KQzF790T4NqhrKx3vfRwBExMS4R54XynS/d9tMvfAK70Xm8Yd7rszkk?=
 =?us-ascii?Q?rJMTAJjtd8Q6egmfsg3D5u5OajO/mokujdSdbf2LU9VfZJUrWT9Lehs+psS3?=
 =?us-ascii?Q?vY6/x+EuYJ6t77aG5ErH0+Gca8X4l8LAG+ZYjcW1ySfBAwds9tlzn/rDwTHX?=
 =?us-ascii?Q?STTNaJ//kAYB50HqQq06QcCSWO0vbGLzBW/d9Z8HSh/J3Yd3oFKuP3gQPHcy?=
 =?us-ascii?Q?8Dl9Y6Qa2SDiZq1F24lTArwq8usZUCubAOYRdF+dK9C5Z/3IzpMcBWIzyRo7?=
 =?us-ascii?Q?GXYSq+zE5S1DYPT5rcK6nb+LDUD8UmTLpy4Y07E6jkieMn3IOsI0hz0t6W8/?=
 =?us-ascii?Q?p5GmkFNoE81b5y+ZBL8NJy5vCV5AB7CNGb5Gl4HqcQUVxtX97uP0BAKHbCoL?=
 =?us-ascii?Q?Nc05vz+XhwmgSG6wwMv3cXYf1J0C/gAOqLGlwB4ePXtXI8lZhGfo/iBjQ/DP?=
 =?us-ascii?Q?sILXuaLluB9RPMbKcgm0Hb+IK+kHu+32hsLRqQD6MkKHlqKFd00vtfxcUGrx?=
 =?us-ascii?Q?6dchdABEabYYcOArmd0Fu/Q2yXL6sZNyUxxs5IeYLv2wZZJIIHXOg5WdtPX0?=
 =?us-ascii?Q?zvUE9P1dPQssA/ivJjqEr90jRGrUhubAhnzs/dp42pwUY32qmU2MSRTG5bhy?=
 =?us-ascii?Q?3q9c5qN3X22mCJzf5DCQGc1Ih6ahBz/JYBMLr28ZPeJphiF1iBs87gvDzwyI?=
 =?us-ascii?Q?Wszvrp4vbfzxAsOK6R6NKkNrAu10LPWtzYkr2JfdsYMCRGn67/AsNd0hGKRT?=
 =?us-ascii?Q?NynH8AoL6x6PrMnM84rMWjjDR8Otwq+1dz/fwwPp0bWPbjHwfyBp4UiF7vL4?=
 =?us-ascii?Q?PGTX6pZWcoJJ8eNKw9JbdUhN5uTj+W/V25v0o3lfqnkp/C5eBNw2tuCAJQjJ?=
 =?us-ascii?Q?S7Hr3viWDW+vhF1B9OD8dmxmNWV+oDyudOQhzbG1PnjpmqEq9Cl0p4b0NA+Z?=
 =?us-ascii?Q?7E/2D/yjhh9KGZcRTETHthe7D56+DJNFoEch39ZKPR97n7Pw3d6kqjbD52tw?=
 =?us-ascii?Q?oyrkYIXbagMrqazFfYHhRVIAc3Nn8lm1cRevUN5y2DV8FeCLMkQKIOV6niqL?=
 =?us-ascii?Q?LGrAa4gJBdatqJIQpRf5XF06l6SZqgVCqW/ZNimz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67275b0b-9cf7-480d-c541-08de1ae41143
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 14:19:57.7656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zMnTZs6vrJfteE5RqhECkkKkSBWVxLRRQ5DbGJS0QhRwN0DpH6PGbi2oKRX4fF8jQpe+C6At300e7UnG9vl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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
> Sent: 31 October 2025 22:02
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 12/32] hw/arm/smmuv3-accel: Add
> set/unset_iommu_device callback
>=20
> On Fri, Oct 31, 2025 at 10:49:45AM +0000, Shameer Kolothum wrote:
> > +static bool
> > +smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
> > +                              HostIOMMUDeviceIOMMUFD *idev, Error
> > +**errp)
>=20
> Let's make it simply do alloc() on s_accel:
>=20
> static bool smmuv3_accel_alloc_viommu(SMMUv3AccelState *s_accel,
>                                       HostIOMMUDeviceIOMMUFD *idev,
>                                       Error **errp)
>=20
> Then..
>=20
> > +    SMMUDevice *sdev =3D &accel_dev->sdev;
> > +    SMMUState *bs =3D sdev->smmu;
> > +    SMMUv3State *s =3D ARM_SMMUV3(bs);
> > +    SMMUv3AccelState *s_accel =3D s->s_accel;
>=20
> Drop these.
>=20
> > +    if (s_accel->vsmmu) {
> > +        accel_dev->vsmmu =3D s_accel->vsmmu;
> > +        return true;
> > +    }
>=20
> And this.
>=20
> > +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque,
> int devfn,
> > +                                          HostIOMMUDevice *hiod,
> > +Error **errp)
> [...]
> > +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> > +        error_append_hint(errp, "Device 0x%x: Unable to alloc viommu",=
 sid);
> > +        return false;
> > +    }
>=20
> And here:
>=20
>     if (!s_accel->vsmmu && !smmuv3_accel_alloc_viommu(s_accel, idev, errp=
))
> {
>         error_append_hint(errp, "Device 0x%x: Unable to alloc viommu", si=
d);
>         return false;
>     }
>=20
>     accel_dev->idev =3D idev;
>     accel_dev->vsmmu =3D s_accel->vsmmu;
>=20
> Feels slightly cleaner.
>=20
> > +/*
> > + * Represents a virtual SMMU instance backed by an iommufd vIOMMU
> object.
> > + * Holds references to the core iommufd vIOMMU object and to proxy
> > +HWPTs
>=20
> I read "reference" as a pointer, yet...
>=20
> > + * (bypass and abort) used for device attachment.
> > + */
> > +typedef struct SMMUViommu {
> > +    IOMMUFDBackend *iommufd;
> > +    IOMMUFDViommu viommu;
> > +    uint32_t bypass_hwpt_id;
> > +    uint32_t abort_hwpt_id;
>=20
> ...viommu is a containment and two HWPTs are IDs.
>=20
> So, it'd sound more accurate, being:
>=20
> /*
>  * Represents a virtual SMMU instance backed by an iommufd vIOMMU
> object.
>  * Holds bypass and abort proxy HWPT ids used for device attachment.
>  */
>=20
> > +typedef struct SMMUv3AccelState {
> > +    SMMUViommu *vsmmu;
> > +} SMMUv3AccelState;
>=20
> Hmm, maybe we don't need another layer of structure. Every access or
> validation to s_accel is for s_accel->vsmmu.
>=20
> e.g.
>     if (!s_accel || !s_accel->vsmmu) {
> could be
>     if (!s_accel) {
>=20
> So, let's try merging them into one. And feel free to leave one of your f=
avorite.

Looks sensible to me. I will take a look during next revision.

Thanks,
Shameer

