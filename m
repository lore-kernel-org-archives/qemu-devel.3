Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0B8F3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutfi-0002t3-Gd; Tue, 24 Feb 2026 09:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vutfP-0002eo-LP; Tue, 24 Feb 2026 09:45:39 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vutfF-00029p-2o; Tue, 24 Feb 2026 09:45:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCd9eQ0M66MRrr7C2LPD6NoiFxJPHPELMoWDo9aIN75OWnJrl9HXrqdfNg0PQTxdWdvsTSXVVB09XIc7gHv/Y5qdoKOOCgOHQzWKkGN5xnd6eE1QOU7lL0dX9GOd7JT/Ls1ZxxqJfbeyE8JYRGqBx5tJuy5e+QO5YSpFAAaMHKiOm+eWu0ejGCTnP8dVJ8JgPluLC5xoXnaFHHR7vyoyYpzClFCL/83R8oQ1Nig0AvxbWWyqm53q45H/0MYYwGgqkZtbM2ifgmig3ziH21V+E8YI18EE4zoGMxXvqrvYsUYVHMcXLK6EkDrpjeVRFgf2jo7I3a5CZtQI0piWFaYqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Cfnl605sOYbT+qdt5g2QtKh45XqxlAR5IlxLo366VE=;
 b=xiI3gkJkzQFCvdbKai9BcBHyx+OZFdPNRW4pZJclMq0ogTeuUQg2gaDR1tGGRPXRQJuPq5yuUl6JupUAI9cBmWyjSqG9dGeMiZZ1NhuOpPiqYbWKHPpylk/TEGkTWLQC8n5svFVDm4ESNOmdE8cWK5LRV4JHbmlg3VFTBEkjg4f72wozl0TMQL3Il/Y99t8M2mUjT/Mk3Yqfwf3kgV+1beV22wnFrFNY6hJ7BTNcTfsnTaV9FHYdYnshtn6lOHaGoSfhUtPTUxFarVWKRh2YGgH4DWrADQPbOmB/UGi4M7Uk8HjbRHEvJTO75REt9E6vYO/iAp469IMTK8xPQKtLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cfnl605sOYbT+qdt5g2QtKh45XqxlAR5IlxLo366VE=;
 b=ApxcbertAHMZ4IK++rWKL9c4nf/ffxulliBrw3YzDo+MxpLg6l2RysX6w8JluyZgA0Bm2W8qMYBM4QhqwRz0Mf6j9KXx6nzbJiiovbDrmgfmgPPPlb8jf2A54HAUG66QiC+X6LLcaXgDwgdB0NSEzAyDW01liEqinsGUG0/AQ04tXyGW/KUzlBE0dNNcn6MPtm/E69ILIYFjV8mFUewtQumTXZI7OEdsvrZrSt0U329PF6RPBJ8i6gzKm3PH1UaRfTvIV68Kbx8r/ljm479tb9g2bkL0PazaLBUEg5FMnF2WhlCB6os0DAlwGU+l/rp1tGdNvV3JKiTce+dhrifnpg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:45:02 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:45:02 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v7 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Thread-Topic: [PATCH v7 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Thread-Index: AQHcoX5jfTL8u+EstEGxTvj3768CVLWR7KSAgAAHqKA=
Date: Tue, 24 Feb 2026 14:45:02 +0000
Message-ID: <CH3PR12MB7548A4D7F476AA7ED6A4998FAB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
 <20260219090103.33697-3-skolothumtho@nvidia.com>
 <20260224141357.000038f1@huawei.com>
In-Reply-To: <20260224141357.000038f1@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW4PR12MB7288:EE_
x-ms-office365-filtering-correlation-id: 5e0f6c15-4eb9-45b0-f4ea-08de73b34a95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?rW3YIWgY3WEkLjzjveCuekPLQOFwPbfW8b/qphD8tHMe54lVoMhk9AdWHnCM?=
 =?us-ascii?Q?CLFy9CBg6jMhMBBZcpe0G3tFu66SbMQDlznTJf8Spqr6Jmeu6lDPxdD7RyVt?=
 =?us-ascii?Q?Rh/YfZHcUFIad6kKFm4EH72kC8VY/ccgSkBshDKeIWCkgQokpybs9QDix39i?=
 =?us-ascii?Q?/tHIAqMfn6qBE1divHoxljZO7LU7WzopsVP3e1YlgGCDRwVmEnUUs6ksWpyq?=
 =?us-ascii?Q?kqT9Ne8RuT3N8/gRO/SUuKUKYPSNuLlzv94Wr3mMzkFZ/DF5jjyqFdV6vwr9?=
 =?us-ascii?Q?8rl1fgZmpbrHBt8TDaBl/MpsqowGmVEZYIERLkYbgHpodOf9/bHW1NcCLBDn?=
 =?us-ascii?Q?yHBzGmZfn7cAqsOPid4HlF71/+KoCfd0RwUc+h2VooLA3g8G8Cj/PtH84JRI?=
 =?us-ascii?Q?e6fqXJRc8FjKMJP50WdNqdro05Nf7CEFi2h++1mU+8UjoqO6kGqQ7xeVEcZ+?=
 =?us-ascii?Q?3BZE6ZqYhky8SjB2FeCwcU4JPkTaGtMTwZHr9eD5A72p6l/jWL563LbKv0/f?=
 =?us-ascii?Q?d+sZflmB5ag2wnRf6zo9cUKYwGp/xaaX+c5JKehPcTnGvIK6F9FOFOT3Fvx4?=
 =?us-ascii?Q?zIGFl1XLBqZFZS3ilaJFSzZ0ND+lRTVYdBO5Y6XGTNYXUVDm5xPbHbdcnuLh?=
 =?us-ascii?Q?6bBkomMO4TIAx08qWNGUNbGixQec4ZNDOweQ/WNn7o8MdgR0IAwHXmHFEYs7?=
 =?us-ascii?Q?M4RHO6j0tldgi13onFnsw0biA4NWf8kbCWXMHyZ0N37Z2Nyh4Qm7YYrkoQ3s?=
 =?us-ascii?Q?+uny5qUE4XSp75QRbNkbwl3MC1fSLo6klUPX2XD1MIY6hrzPn7IbPpGnKvX7?=
 =?us-ascii?Q?mwsKric6AWTBV6DcDjtBewzIPS5XgM+yaCXi+W/K9QOAlK1VV/SwiEtzHGDl?=
 =?us-ascii?Q?k9JCXAnK02vG5NoU2Te7nFLvxRo5nX5Gj5grEmcJlR2E0u9+M49E6k9iFMM/?=
 =?us-ascii?Q?R2ptXDWD4qL+E07JsNkIVI5pq65uB6qr7moliEQahZ+7IHJFAmhzaRirwT0z?=
 =?us-ascii?Q?Qn1bPJjZUrt5/2vCaT+/wCgj/OX0X/221M8FaZGbkDXMAkB7mgar/4SIas2y?=
 =?us-ascii?Q?yF/5jXuwOukcrUGwxirSDyRb/U8kW9wCxy4/mzedjjAJ/czgkkhphVZmHuQR?=
 =?us-ascii?Q?TrfYl7U1X0ePvF5Lu3ifEG0WUtNQjmlRKWKik1X6aX+l+8V4BoeSakagDQ0k?=
 =?us-ascii?Q?EWH6bjXaOngoyE/1Y1aoee62Kkd6E7igdDwM9MDFKg+/Co0FdKG7In6WHaJS?=
 =?us-ascii?Q?ZnIyQqi1whc6CPWRICMT6xmpkCtUcNIE74ZzCKuGK3arioAwZlXg0tpt2zhl?=
 =?us-ascii?Q?EDhm+eF7D45qRNX7GpbtXAv2E09IosZqPbqfWResURl1vSZB9rCPxy/zm7JB?=
 =?us-ascii?Q?U1Ii5EMSiruO6mgJAqUTgv/PImbVeb5Qx1o0flQ26JtXb7PKQMNYo3YY2BLc?=
 =?us-ascii?Q?RauuViQ9GQFea7gcodQs8VWTsxvih7NmGsJHag8r7dDKcpovYbv9Y5LZGdji?=
 =?us-ascii?Q?DCCKjIHLMfz08ltmZo1g29T1kH+b4zPJtNRfdNtczULXiRkFgKPeekWaRKUA?=
 =?us-ascii?Q?LUudQx0Y63KixbQC2cgT8m6pkAYFmjF7eTQw+D5fmG+jlrhrnJkHLwQUKW26?=
 =?us-ascii?Q?+2pqsS9kxqu0c+M7nFLplxc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f7Hf9Xh9ZuRcWISUQyrkstAQxufPQtXoY/Dd5AMZa65kGmA81c6b8yvUADKS?=
 =?us-ascii?Q?tJ4f+6m2iQZykopzQHvJ95V6uWjoPYsSU40IgrDlo+xpdSRksa4lfsHqxrqa?=
 =?us-ascii?Q?7DC5OUQkV/5LxuoHNzgp/Shu+BjO7qMN1UHOynEh4vlDglnh6RLcIMCLxJ3M?=
 =?us-ascii?Q?UJyToZddkGSO7rOz6JDmBTT4BUzeXICBplQfCKzd5A1340V4fRvVxtrL7wNb?=
 =?us-ascii?Q?duxXPfpwocTdf64ct38Kuj1hho9QuO1kXO0BTz4cV8sAWOI9S7EwuuCdAyyU?=
 =?us-ascii?Q?Our2KqmWqkzPLxqlI+AYzcu4qjx1UIrujqUT3dE1yWU+7BvGAmOUSyppwhm5?=
 =?us-ascii?Q?vj/BzMBxuxMXiRdYXPIUO9eu3qshMukiSwqIoPe88KTrADibAVDZSDI4F2NW?=
 =?us-ascii?Q?1YOPqqKF0O4uZ651MTI62dopSqiwhBXgoHd2ybWSKOVLVS2HRrtua3fl2nJb?=
 =?us-ascii?Q?PIHsGpg+9IWSCFqYiSPb1RI6GhGszYUlamm4EBbwHjSKi1GBSsTvQzXanrzc?=
 =?us-ascii?Q?5oi2twEk6By4hL1/Fos5I+2UP7Ucuhy1vuE3MK60GEFwY/W2obtEu1Jf6taE?=
 =?us-ascii?Q?sRmZRh4yOjWqixH2nMM1Y2T7NXzbEzeMvVpCM/E7z6+Sp2yyK20N1vwhQWNi?=
 =?us-ascii?Q?vIMCDLbohG04px+LmAvKgx4Ft4Y+lBxS3uvjsMLTZ3QalbJdm406oTnsKeiT?=
 =?us-ascii?Q?JRVvlHQQNOehukCI7P7PghUEAmPwe4buq05AOuzdCM86+Axs8B/VHE7Yd10C?=
 =?us-ascii?Q?fFPu/hIF+ygx0HJHf7iBKwvxsoF9Z2qW1vlcdyfGkh/x6BPk3iN68tAx/Zwp?=
 =?us-ascii?Q?dPEM+lOkMpAWivRQjBpqeVBKtvTn6OX/10gHWfnVZdOTPqK49vty4A8WR7uI?=
 =?us-ascii?Q?FdY1mmnq1u+4rE598Do/1GYgzd6CWgUk3rWwqeRvuQ8grFxP10Fia1BQupT3?=
 =?us-ascii?Q?+XDN7CUfXafi60MyfjtDLs2PNC9HH+L+5NnbcUM2+U0H1CJ/MjDYtfDPnlVA?=
 =?us-ascii?Q?zjRMzCXOncxLbaPSTRYXc1gpWEpXCRd5Dkj5S/we5LvzryqtAXqFiNemKenv?=
 =?us-ascii?Q?EnbdWp7iL6HXioqAILHxZlnpjFJL6w/PgIfBVo+RDq3L0mjVB4FXsuCQK+yq?=
 =?us-ascii?Q?zIyDyv1Ilnv2hKfbMkiZ7h39GL/cfzZkHWLYTxThtdjHsJgPMs9+7XyUJKjh?=
 =?us-ascii?Q?6UQ513qz04fVPfmCQoDAzpV6WWEh4Ag7c1IiY2XD2rRMa+gkQOkXCoMibRDo?=
 =?us-ascii?Q?H1jgCYPjYu8gMTHVKNv9Leu8e6XpfQ9eG4D7Qa9csoezt/uxnPpXhDJv4OMb?=
 =?us-ascii?Q?PZa4w4/H7koZCUjhEEdnipKulGZgnX1lQVWDq4mItnMrXTeATIGmpRbn0OrJ?=
 =?us-ascii?Q?fWGUjbauidx1XnVD5gF6FQrBJtJrxciuGWNn3sGlGj7t/SsWu2c3JjPbDxmc?=
 =?us-ascii?Q?QT9G8YJvldUu/sldfpyKCkbDgwhLJeitXm817QwOCeqkVmofbU3esV7GpmA+?=
 =?us-ascii?Q?w70qDXBRzi0oM+7uOJgoGBGS3nEym3yDkConUxLVkkdUkzAx/IXFhmRr6b0g?=
 =?us-ascii?Q?SyfHZysJoj6bH8InoiNRHYqUseK3egPTLUTxZ7+h2C17Msv88uXuYSpOmIDW?=
 =?us-ascii?Q?EIpa9/nbomiMncwthRw9uE50qUGYnT1ryitEPNKVoAHcmuM6TlIY4lA/rZPm?=
 =?us-ascii?Q?o9/sSMQC1DZ28xFDP3S7wTv42bkPrdlf4glMrRkHTtE0KMRDjxeor0+zlGoc?=
 =?us-ascii?Q?d56dwXS7Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0f6c15-4eb9-45b0-f4ea-08de73b34a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 14:45:02.0683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3Alwdrx2UpkjY39C0ZaTv89Qkm8fN/hhVOZnjlWvE86q/7AjVfAiNIw1Rb49BA9vltH1jD4fhql+baiZczaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 24 February 2026 14:14
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v7 2/5] hw/arm/smmuv3-accel: Add viommu free helper
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 19 Feb 2026 09:01:00 +0000
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > Move viommu teardown into a helper function and use it from the
> > last device removal path. No functional change.
>=20
> Minor thing, but this description should really include 'why' factoring t=
his
> out makes sense. I was kind of assuming reuse, but there doesn't seem to =
be
> any in this series.  So I guess just grouping related code for readabilit=
y?

Right, this is primarily for grouping related teardown logic and
improving readability.

It also provides a single place to extend the teardown in future,
e.g., when freeing related objects such as vEVENTQ.

>=20
> >
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,
Shameer

