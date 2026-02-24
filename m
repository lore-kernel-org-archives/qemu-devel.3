Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6AFF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbo-0001ff-7o; Tue, 24 Feb 2026 09:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vutbJ-0000sU-Tb; Tue, 24 Feb 2026 09:41:25 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vutbE-0001Lf-Ce; Tue, 24 Feb 2026 09:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVJUuSySLJa7A7ISRXw2e9VOtJsW4uMPPsyJFdPv8HFPG7JK/L6qpGBtFjNGWp0eEqhY2916VjSDneRvw27iQv2vW2LeknTcl8EaT0h0CK92Fey+ffY86xCMfEsLUf7zPl/VgWfO9RG2diosfabO89u8oIwbxhsi0N8VcZSUAMyiVPK8OuInAD7JWJJ7LaHALAe86pqPo2+Qu97n1EP3h69r2Je9BgpJB5FEPSKAEIFVtlxJob1978Q8MNhG1yIvwKWrI9CkDZG6quvgXFUgMTBtPJ2YE6FjO+IQlZn/LGdwGNg3M6ssm3HTLTi+WRO7puIVkOB5h/qHJyszS7aX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIE5W/p4d3FWsL23DNnDypW79Xeod8AwZM7h4C+bq8k=;
 b=XvSXRTzVfYXs/RwCoQE3bmkEKu1ue0bla+rBsJ5h0DGJwaRmUXkqngQpPhsOOeksWTLg+kuNKf32XjhU0CXR2vPTsJGp56Wc5JLsIE0OW5x7CbDDDBIy0DFujIZ9WEI/CcWZyP2JW7uccK38l62WeBylmnvUUmJpgraIEVvztdCxZPJWefo9CF8Rmbx6Qq+hPZSJVPC9AWjCLQc2v5+NWvtF9U6OKKH6oJuJ7FkIF3+LBosCF7AciHy8oyyA7Vq5kGosD3BsskH86ZOqGQ+GZiKNwvo7DTihqoiPR82VzWZMaGBvgcR6AC+CP+ZJBD6NG3uHIVXtHDJFE72kyfNPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIE5W/p4d3FWsL23DNnDypW79Xeod8AwZM7h4C+bq8k=;
 b=IuzQmyc6NjGr4H5TNxlfmKv/JHC0Hre+pEbYhPO4747eGk213FFydrdkDeGUzhAwDXF3BgOiGsXYtT7XeIH1GA9ubxCI8TN+i+5Jh6knkHDjLvhYvNGcqDFmH6QJF2Bj3BGuZ3VSV8+XnTm3sSpnI6s30d1QScjlIA5NydW/+fmxIIEy4FgSbq9XrvrsMwjWWIhv28XqqIbF0WxQH3HdOAlDRWsgUFopayJipP5zy6V5JzyyZ8vJM0RDxddETOWw56t5EpSyp7YmhTs3TUXLaSWFUxbNkh2++XfzgGy9ksaT86GP83V3XvXn4YoJ1kryjxk1risos3Mox35tTTPTEQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:41:08 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:41:08 +0000
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
Subject: RE: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcoX5mqsuvOdSY5kmqaAuAN0RYDLWR8NSAgAAAo8A=
Date: Tue, 24 Feb 2026 14:41:08 +0000
Message-ID: <CH3PR12MB75483EAD05125D5FD3998474AB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
 <20260219090103.33697-4-skolothumtho@nvidia.com>
 <20260224142857.00005fb6@huawei.com>
In-Reply-To: <20260224142857.00005fb6@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 27b630cc-261f-4943-7737-08de73b2bf48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?hcrEAgUyI0qVcYgYQTMr2M7bk3FUg6lHCCu8D2ycYGgBC4x/rzzDyp5LvuY1?=
 =?us-ascii?Q?g6AqIwp2IY72YGrOpIBUSecu5ZBG10Th4myE5xUm+vOiOzlzwVsKvQqPOxv1?=
 =?us-ascii?Q?27mjtG/QxUIJzQGkjBj9jhV5AkyN24cYrcvQpkgp9fYXtxdjZ0bMFsN2BH8F?=
 =?us-ascii?Q?EPKt8FjWvOBsLyX1/HEvDomCenws8jYVNEBNLozF2S5jTWbZmg7IdgWhJ8SJ?=
 =?us-ascii?Q?YnvOF2J9bMCoRDiQLrw61wLSf0CLE5mTHeiY4iEWxVSDphsJfK1yPzwCTq30?=
 =?us-ascii?Q?LqYzMy2/whdB+bYBYTsDBg9kGml0n+wYQ8fjWMb6gkSPAEeMb1HVs50kJoCv?=
 =?us-ascii?Q?RbBWL1+dlWe3PjWgzCBSKFERyAqSoEsULomb5+bdlEYhGveqLalpVZlN0Twk?=
 =?us-ascii?Q?ITM94Q0uJSkzeGFmwrbn+UnglE1LreM8VFUg/PbTsll8AXqm2pb9+gtUY3LL?=
 =?us-ascii?Q?o56lfptfyuEx+YrxC3M9ZuUrwVEXv1IrkpDby+feP4FvlOGX0UHbfOaxV5JQ?=
 =?us-ascii?Q?IFedmz/uwEGTSol0SVismfXgpWIkA0sEO3hEkuEFm8+CihS5A/GaTWoZaXOq?=
 =?us-ascii?Q?eRelY3AH+lulduY+BoyHfVPhcU1gSsMCOr7vUoGhCW90yLmZegj+9VnjAhrp?=
 =?us-ascii?Q?/JyqWQJlJscbdcjvUXpmybJeyEppE3uz+ej+z549xQ73Zrk+FHHcCFK0DrS3?=
 =?us-ascii?Q?d54QMCD+wrB+oROcRPYZP+S7Z0+EC0akXr0B/fF0vhuE2KWbyqIIKumKrEa7?=
 =?us-ascii?Q?hQGo8fmsPKfRQAswDnVBuLrEkpzDvkVQQ0cLX3Xnd8pY0IJlnQeyr+sOMbKI?=
 =?us-ascii?Q?1ybt4hI2+opGquvpfUhfBSw/7GJspf31Fv3NjZVp1PLHwTxoUWmbJpJKB+U1?=
 =?us-ascii?Q?B6OtEGba3ho5/4gTyTKbFBib/jR2bnwYQojhza0t0AWH2GnUIzW9rEM0N/xf?=
 =?us-ascii?Q?Qo7lgmzF5SXC+UeHc3OkszZZM4+k7BC7bsTUaJaJpCgjy91AOLD30PHdLvbO?=
 =?us-ascii?Q?UCO3dvWWN+d94FawWwuJpFpSNo2YQ9SlYPcGeEBjMTqueKtupo4IbH49EbxS?=
 =?us-ascii?Q?QFHDJZkZXb8fZyZyCi/UUs9EBPeI0ltndNRrsYp3KN6xiUC6Yf0Mwzzp1AnA?=
 =?us-ascii?Q?7mZzCv50kphzhIbPQzIOfGBUksJUqbpa4pY/OUHSUGhxqLKZDuM2GYIrwGGO?=
 =?us-ascii?Q?pI7IojvnCe9FKuPWvUfQPieOlCTZB+N92vDk5hTGErh/bztfagHxI/Wfggdb?=
 =?us-ascii?Q?6oiUJMiINm3ZNZpzmiQs3iSiKNx5BavgErpFWnHUFrAyYbDjxN2K+6v6DfHK?=
 =?us-ascii?Q?m3ZWMCZx52R2FvCP5f8HIbSIGLmejAvCEtaIOyuBmwhQTyOoSUik1Ic7LH5e?=
 =?us-ascii?Q?cObHM5mE34+7A8hWl/PzxVmUEYylIvfIQZiKoVrT1+2bD5/QHZtI8fRQn9d/?=
 =?us-ascii?Q?RT4KTzfBDE8CtJzyZQi2xoaJX39u9E+VOQ/7udX4P+pDlv7ToMRg+Tg+IfiT?=
 =?us-ascii?Q?E6/0ZJzISUKvsT7W0bJmPZgi+2kGqyK5eWXlDpSY436rGmdeycgyPCSFPjAN?=
 =?us-ascii?Q?YeUVc+V+ThSUtTDmnHIehTk9X8ZTiGDSj9HUCTNlmGZ26RsBpKGaD5+HzfLI?=
 =?us-ascii?Q?y8ZZroRITMAFUBHgH4UJXSA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JIl9lL70l7GqDjf3WX7fiOz9qeVqPtppLBnP3edTvNviMfTRK0I2tijPg/t1?=
 =?us-ascii?Q?wi00Hz68wfotlEI7nqKVebRgoOk++vNXoVpZISB8xyRVCoKj+q/Xy3hW4CrP?=
 =?us-ascii?Q?eOdm0FRGj7zNx+2LNOrTW4FsPLhK3hLJRtjjq8ZJHhDQ87X2/dLt55kySZQe?=
 =?us-ascii?Q?I6MneumoO7NiSt9zfiOe+tuf7Co74YuG3DXdLm8CSiq/9c1WnSuc4b+lPBQr?=
 =?us-ascii?Q?46OtFGCRwUOV6JGkrJwHsKEHM+LZ8R8yykuw3OQEKF7J28hpCV+dUEzBdQ5f?=
 =?us-ascii?Q?EvIlGVywoJg3RBha4cbpWiOpjdZLXJE82eaYmToME+29uy5RRpeCW0kEr8Cc?=
 =?us-ascii?Q?oNVWjBR8pvnlp/T89oU5/+6LcL3gSc7UyD8b0GlnvxOkfnl8Ipw/ojXqG7Pk?=
 =?us-ascii?Q?mnm61Gox/PKnstSmuZpPyvm0jXzcj2qw6WvtNRSCwrIZdrRiGh9aDeY0MB1w?=
 =?us-ascii?Q?FZIYBgjYnwZ0lvm8rhU2VpXTrdMlpnP+6YEB51bwyuckaGJlU3HAOGbBKvJR?=
 =?us-ascii?Q?IIyJTbJgfXvyQPXAuH+44J6QiyPL3dwe/3OhMi1Iy+F7DLi5yh7xHnHaSX+Y?=
 =?us-ascii?Q?uPfK0pQSO0cnd4yxRn0g6HKRcOMN/8U/TlqU312G5CZx2GgX1f8R6JGu1yuW?=
 =?us-ascii?Q?u+ACqvrJaeMJ/PXnZ5KCfDDjHR26OIlYGwd5Ep94D+qcOvcA8bvI140X6WZC?=
 =?us-ascii?Q?p7AkxRfvkibQ95E8wxkxABwo0gxdr9T0NQWbj0vQe5mc7QwbKbzeYutlQn9P?=
 =?us-ascii?Q?bDcFQG7YBmTU9uAy0mAscSwNd0mHRREZOIiPyPID24OhtUl/q6U/xhMssnE/?=
 =?us-ascii?Q?0+r7Ivf9uOeAJi8uY0NkrUxM/DmaFcusjczb02JoeSmKZrWPvXau7aKi4hdI?=
 =?us-ascii?Q?ZQGe1jZF/grk7FkBmeOFEcTADBydcCQRfZ7ts9PFFjQBd4JH7YHKVNm9jHA+?=
 =?us-ascii?Q?pjt+Wpp45vlJVDFI/ATGB9LqyI/OytPv+FWizvHsZinJPvh8rmrrS4OSgZ0u?=
 =?us-ascii?Q?AE7drQHA417WoGD8hr6MglhmW53fzt5hXN5foLS+z5giTb16a8CUIS3H/SuL?=
 =?us-ascii?Q?maiXCadhrCK4hAKv1iAsDRppClyvvROmawVEYNUnmofLapURen4M8CQ/qbEN?=
 =?us-ascii?Q?d+JoTu4Lqo5GFTkKi8+XkZKVZH0VYWXIhQt9VIquY1hNPxcm1OC0L7HtjFC+?=
 =?us-ascii?Q?QpKWYeM3zpCiajj7cRLzyfpm47+GYc1AuowFRFqwMQUy940fESEQ9dl7uUas?=
 =?us-ascii?Q?mi/IYvq0lRvLVk+VarUI00GYxrDDxucDigMorkSc9ziUolkbMKo3ISa8EL+R?=
 =?us-ascii?Q?PpcWYV/4xg3oP+pnKDctkuS3qeTbY1/YdUSgFnnRzDfCIVdDw3+DGCPHLt9A?=
 =?us-ascii?Q?KbE9wuGLhJ8inpvCmUynniHi45Jdg0dZ4viiMD9PwyWMycAZ4nYVxosrpqlZ?=
 =?us-ascii?Q?of8aV7TM2+5EhHUcv6Zehf4GocNzwG64Y6SZJ4UuQqG3054euKuPkFM4LeWk?=
 =?us-ascii?Q?dlJTMVBf0GRoybqzq6Z1+VuFAFeYTarV1VdK4M7pX83JukmpufQlzp/RNF4s?=
 =?us-ascii?Q?36gB316Us3VW5a70SnhmaGaP7JnkYXUOf8sOr0OngrtYsb58BHB82sHTb/rl?=
 =?us-ascii?Q?TiPIF0VU3IVlLsuw1lw8wL3ZRrFzpWKYKFQ57IFDuTXtDQc7dw/lMwmjHxab?=
 =?us-ascii?Q?PAAfwaV7UKqHnhWTMVWHwSAtOi+grLsCaf5eTrToiA2pZNSLWRrCyGVQtqNy?=
 =?us-ascii?Q?c+ItIDAe4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b630cc-261f-4943-7737-08de73b2bf48
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 14:41:08.3274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2ihclv5bnSGlRG9FO91bf26csr5oANAmIUFtbTr9A71nbFtncGS/yOF8mODwqnjADLzu3EAkyaAb5qf+ZBj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 24 February 2026 14:29
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 19 Feb 2026 09:01:01 +0000
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > When the guest enables the Event Queue and a vIOMMU is present,
> > allocate a vEVENTQ object so that host-side events related to the
> > vIOMMU can be received and propagated back to the guest.
> >
> > For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is
> > created before the guest boots. In this case, the vEVENTQ is allocated
> > when the guest writes to SMMU_CR0 and sets EVENTQEN =3D 1.
> >
> > If no cold-plugged device exists at boot (i.e. no vIOMMU initially),
> > the vEVENTQ is allocated when a vIOMMU is created, i.e. during the
> > first device hot-plug.
>=20
> Why do it differently?

This is because a vEVENTQ must be associated with a vIOMMU, and
iommufd_backend_alloc_veventq() requires a valid viommu_id.

A vIOMMU is only created once at least one vfio-pci device is
attached. If the VM boots without any cold-plugged devices, no
vIOMMU exists at that point.

In that case, the vIOMMU is created during the first device
hot-plug, so we allocate the vEVENTQ at that time instead.

So, the difference in behaviour simply follows when the vIOMMU
becomes available.

Hope that is clear now.

Thanks,
Shameer

