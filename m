Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE4EE7DEFB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwPh-0004PX-4d; Mon, 02 Feb 2026 11:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmwPX-0004Nc-Fd; Mon, 02 Feb 2026 11:04:24 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmwPQ-0001IO-M4; Mon, 02 Feb 2026 11:04:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFH5XtxTX9mXqwnyZ+NiNV3yjLt2FKRiR4wEuWIFrRMPR9oq7UoqamYKK+GH2Ol69EFIink61BPv/1rNNZ22DV6KzIiiU1yms1XTE6tH6F7E4HOG6tyWhNucJOoRbtIDgAxsf/gVNbdoEqRNpACCmAzEOAOkkZv+90jVLOIN+gudnF6QCQER4IGGlFubxVPEzCxtRXAGGgqkYgPLYwW0nl9oNMB1S5zNiu/PY7xR/Gmw2fn5Shmo0fwYoLBVFpjPQJEU+WlsSCaXehF5a7bgfAQ40KeJI7VlgVKa489/ZRx3l1HaxdYmCEJ6KyW938RoWYGLhOF4Vf/AysV0lu+ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mae5G865b5rg4RI7BjiY35XZplp25A9PYvt6vxtqggg=;
 b=qq3rCz+/PF1bhbf6ZZHqzZFuWDO51a1iA01P38WPiCkwCpqVU6DcFgxVFSI/piD1iTV6OG8qtjo8AVty3U88imiZeVMhGgecMniXhUZic+9nEypEtKgSdw2VxZLx81S+c3mTE/mY9/dehr8bKg3F27t933a3YTV0AHzaGxNpbe3pfOuBQQnAgEpFag2o37enJ7APhpGwirHStfqZ0tLnhNEIGw96pR9cd9W4WslJ3jnC5Z/ymu3mOL47+wcTx53Sqht4kQC3+R4BfQBztZ58Qdx4ffS4Ef59BqSb5FombfMpHF3T1jVTttQRe2Q9DNUNDQQQs7l8w69WRsVpwiHhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mae5G865b5rg4RI7BjiY35XZplp25A9PYvt6vxtqggg=;
 b=TG98QMbkF2PY2fY+T2S/0l+1iyo9TbBa9try1M+DcTnLUNRoIHoIPcyik+r6o9Nv0urD7lXDsKu8L3tQts3zkCSOcRIciJmRccF0JzcpLcms1gKulQ3f+Pq+LwYYRu+/ATm6tmT2YI4v8sUQtPl19AJdQVEhTfIlu52dayzu9adD/3t7sZyHNx9vqK7qM+j7yAa4ZN/O90fF8MsoaD+apkN8ze01jXIKD778RMrGKIizcEvxYmBVRhK3IrF83XbFlKKy0+GEaeTFnX2TGhk1cO6ASgL5CMqgSJLBAUJ1mctGj+xLTTKKtYTzeSbHDHC19dnEVBAxkw6rc8/BJ93zCw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Mon, 2 Feb
 2026 16:03:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:03:56 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Thread-Topic: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Thread-Index: AQHcjrF92YpMmGmntEqRZLFfH3O4H7VvhjCAgAAEUKCAAAa0gIAABIOQgAAG3gCAAAAr0A==
Date: Mon, 2 Feb 2026 16:03:56 +0000
Message-ID: <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
In-Reply-To: <20260202160000.GR2223369@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM3PR12MB9390:EE_
x-ms-office365-filtering-correlation-id: 255cf149-952f-45fc-1a9d-08de6274ab93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LCyL5f9ZJKylvT39LiGni61oJTNTW1AuOcBn1UPzUXBtHZEEyKTGb7LE0nf8?=
 =?us-ascii?Q?6pBt34+Qzd8Vt/znU0boWt1xIfdMoHGDbxDcYi3W6PuWcXgaQT8L5zDeubEM?=
 =?us-ascii?Q?uWCxbwL0/7OadctT3oyI5FUOKyrb+5rVg0qZRA3Sc+zFyOOsjnjpTxpr6cRJ?=
 =?us-ascii?Q?/dbUvvSgwqKvhUgdlOfjyERw6BmcLeVyuAPiv1cp/lT6+sFTuLhykkZ0GQU/?=
 =?us-ascii?Q?0F6AisCjIzWsYaYVtQIsKnKKdd0YH8xoT5xwgaDG821/2lyzhvz3S2240t/H?=
 =?us-ascii?Q?PiCC0UWPWjsWyWMjghvMBpn9vsyQ091hdBqCG4FACnrtLi3keInXWsO9YAtG?=
 =?us-ascii?Q?urEqeHiZTLGnDVEE060UCgRUOfpACeDj5QgaG5QnuD4rf/1lkkmbumywj/hR?=
 =?us-ascii?Q?MXRcM/QzN/B1vDceaI41S6YE3uZfs3URTKEX7TwxdblZwF6nuz6iG0WHwPVd?=
 =?us-ascii?Q?9Huq/lqF3Mtu4aJ1MSM57r10CLATRyYhA553RF5vpj/RRquz9l93YhlDdxDC?=
 =?us-ascii?Q?W0FjbVFElkcabKV6HPrbSGl2mwvVYWfesIlNls1efAqbh/KzcXtIMBbCN10O?=
 =?us-ascii?Q?a88hSL/hyX/S2MC/AB1IyinmiowH/o7AbuO5AkU/A69CtwU+czXyqf4XCVlO?=
 =?us-ascii?Q?OUEif+9dRmInddwIFD5N/nH4CHFPZFtYJRcF3NrCKqfAavNgqsUXXzPsE4cg?=
 =?us-ascii?Q?Nur7u34QZL2DBTstSEnCn3eWcFMHeGDvGYx4t8msO0emrfurOwLTx8HrjKx/?=
 =?us-ascii?Q?FbTkGf6kHSFVhsgaW1Se4qj1azgEk3iW++czvIT1gIQMoS7fsIqnQ+wKcAfq?=
 =?us-ascii?Q?D58shL5u9Jquu2Z2iN8/ww4QfK6BNRBy+g24rux3nEPTabhI+8bLWpIGi3QW?=
 =?us-ascii?Q?hLECiq2yxEuMiT+vpkh9gs71m8s5NIVxlGg24ZA9ae7Pq2f1KzIEJTF3AGTf?=
 =?us-ascii?Q?47IZKBbpI9QLvrjoZUiASrPEgJOcsXG2/fiV7Sgd+FePJoXctHfbGSz6eycn?=
 =?us-ascii?Q?dBLQlVCBxte5By2QDUpZir6OL2pLv+BVK6hbIvXIt3C5TZKeYDps+MwKF/D9?=
 =?us-ascii?Q?MXEZxk7dZ3VTXvTH0l9iVRNE3FIKOgCbfZelsQYHNvO0HfKGCvhoCy2NEvPx?=
 =?us-ascii?Q?oQfvnCkbZzyV2cawgRTKI6YE1pieDszsj3ZFDFQq5BpRj7K/CNUS4Vyo57+t?=
 =?us-ascii?Q?Laovozuv+YzbktXBupJL6uDZOHlem1+308WflzY3rITSw2G+ZgSur/Szifs1?=
 =?us-ascii?Q?vcX7gReR8JCejt9xoevfCljaI7Nnqp9oS2VsS/qr/0zZTYDPjiBZ/b00sRgF?=
 =?us-ascii?Q?HnMJtyrFcxjst+471yiTDR3K57REDau+XIEqaNydyAZVkt/d6aISk921cKEA?=
 =?us-ascii?Q?gcjhtJMBfEZgFwTpFY8zIbYHIIVHpwwYF8vnExCTBwiF/ELGe2KUBMMgdl2B?=
 =?us-ascii?Q?3ZzTdL6Me874dWOWWUsSvi9Ou5amQaS5l3AFsWCUxcMF3aPcT32tpzXFn99w?=
 =?us-ascii?Q?T6/9kn7i7x9doaBjCtJsu+zieEhf2lw631pea0Y0A3cQCi4Eerhpl4+c0oVB?=
 =?us-ascii?Q?i3pjPrwgkrKdhPFL3gyzbdeVZ1QVEVtyZnQWs7ZwQzCy4B71J1lWcI1BjwnG?=
 =?us-ascii?Q?jy9RhWc7bppbqEFdi9rk4zM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35y8J3tPTvQ/mawwUIc0deU4phK1ydpVuXqwT8vxQphGUA4PUtHTxe0NYDch?=
 =?us-ascii?Q?kz8tnD7SILrnHFxD6GquLmSCvRbcw82zcLDdY8kDhMiulvv2lliAWxKADO2Y?=
 =?us-ascii?Q?Ls7uB/5YcQat1v0qX8tuqJsasK/k99R9dhNKPfKp8U3BrJzQupA7Pc60Q4EV?=
 =?us-ascii?Q?KGlOQ5QBbmnkmNtDmQLk+QtNigFYAfypSMpZvjV4QXNA6x9pvxydwKj6DooT?=
 =?us-ascii?Q?BagwzplL4TDksm0pvDWEmpbsbXlvx+cpFMyALOiOBHN1BSr2F/O0vFAnoF1f?=
 =?us-ascii?Q?FNmrWUUuACwV6R3F6+RoiddLX9LyW3peIF7bOy/SEpv12JsXGhGbQFpJQAq/?=
 =?us-ascii?Q?O/4LsBH1Dpquhtw0LTvWM6YOFZ/LSIU/LSVDXNIiOQr0mb1QLjQY/LZqinSG?=
 =?us-ascii?Q?WcLY8KZ8jGjHIvn7yJTE/bcB//anvdU5DQ1iw3iFYrt8T1QZqctK7LUNicre?=
 =?us-ascii?Q?Z2dlK42E3mSIK5QoWSysas7mur2ZnEvzHp8W+j04kDONtnCNVlJt5vIl2Nn2?=
 =?us-ascii?Q?e3oInWRWXeTbL5IEHMxz0kcadiwX2wYr5QrH2V9z68oOAif1C9PxAT9EGm0W?=
 =?us-ascii?Q?HF3yRIOExiwPaExiGpU8uyDo38XPNaj1jHzxWVwduNQWR0SicPjtrJQLr9Qa?=
 =?us-ascii?Q?rzHsDIJMWdt75xWgtJ1SsvbW4YDHt0EVMfL5F/XpeNfeeMx8mBZPre9c4J4p?=
 =?us-ascii?Q?yTS4XS9RJsxwoDKZgNA8HSfGJVzFhCsZLFZXUri12MrK27XIpG0FzcEDl9aA?=
 =?us-ascii?Q?CHLfBr7a3j+BfdNJFdU70l+e9hpbZDTt84yHuHKv7wFc3Z+Dg4jt6Dvl22KP?=
 =?us-ascii?Q?CSFZ20UOLX2KyDmhh+LUT7yJ9JWbT/JBv5SZslI+mXv5YM08cZSaLHUSAnK+?=
 =?us-ascii?Q?Qq5Cd+BgXn2qPzTQi7P00Nr90MJhyQZtzKnv/4vfkwGO6mDSHAdveeg7aRyk?=
 =?us-ascii?Q?1hcNOAQ/xOHwUiBRy1dlXYFpPXIzB/4BmZ1ZgGCAhgrbu/2DFKZqzbKDmTgC?=
 =?us-ascii?Q?CQOzvYTTCpXdvG10NEJT6jKiWG0jYLh/rxTNLqLyHjaiENV6RjCnZNvLZFfN?=
 =?us-ascii?Q?URJd7gyNFbhGSzjXvEbaisczILKVfBPeBpeD4pzE6QVnbs9hsHU9a1wfoDX/?=
 =?us-ascii?Q?Vad4FClyY1PVH9F1Al69fi4x5fHCNjS5x6e6c4ZXwxMnFOxvOOnC6a4oevLj?=
 =?us-ascii?Q?7U0i/18Ba3CWpcPlmcVfNOtYkQR9wyZ8jMFXps0XX5SfigTe2M5oSp/FFmFH?=
 =?us-ascii?Q?wEm0w6S2Oiv7XLGSWK4P5wIKQlOuRnzyG+f9+XP8tcOmdvEaA/QaT7xnifVK?=
 =?us-ascii?Q?mxY4CeK2H3XzSc4yH+iR0SdxNODYBf//H7yNRRkWyzvNQpPK9Ox/5nZRIk66?=
 =?us-ascii?Q?LEiF0LBkqEclJmHtDikk7R++tNlj+ApNr0aTX2++4z15h9WStvkOtzmD2PGP?=
 =?us-ascii?Q?hXh6T/U67QCktKlieHRnlHpfoU6IK2QIBQZ2NZh3PXOk3LuT46NUj3STxelW?=
 =?us-ascii?Q?ByoIP2dJwTAJDxH5UnLAnqzrWWcsC18zenPBCFe7UxcNZdofEsaQ/tapheWF?=
 =?us-ascii?Q?lDDAQ82KrnFw9NdiznE66F0tkTstqDL1GhHhKeZ2PMkmfAEWT2dPYZ9qADRj?=
 =?us-ascii?Q?vtqwFPeeiQaCf/D+MYv/t/zES7qo2NwKcTO4g11NEKAKPJYz3znCkbBLfpBq?=
 =?us-ascii?Q?ceYHhsbRM8NcscvxSaB4rU3WGwOeK6MxVca2Qp34LHHwZzowaxhb3bac2dB2?=
 =?us-ascii?Q?bxfaN9jgsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255cf149-952f-45fc-1a9d-08de6274ab93
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 16:03:56.7326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bG31FprlOV2n5fHfHF/aPyLXJRJJNd0+EnRJ2Kdui3KZt3ltBrjozLpff8k4pmhj+sS/7Rfi3A1MowJw68gSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 02 February 2026 16:00
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
> specify OAS bits
>=20
> On Mon, Feb 02, 2026 at 03:38:50PM +0000, Shameer Kolothum Thodi
> wrote:
>=20
> > > We can treat ATS as a per-PCIe device property.. I think it would be
> > > fine to tell the SMMU that it always has ATS support, it will never d=
o
> > > anything with it unless it sees a PCIe device with an ATS cap, and th=
e
> > > physical STE generated by the hypervisor should sanitize the EATS.
> > >
> > > BIOS overriding it should be reflected as the devices being reported
> > > as not supporting ATS, qemu should have a per-device flag to disable
> > > ATS.
> >
> > Do we have way to detect that(IOMMU_FWSPEC_PCI_RC_ATS) from
> > userspace now?
>=20
> I don't think so.. I was describing how I suspect that should work.
>=20
> The iommu driver is the only entity that decides if ATS should be
> enabled per-device, so it should report back to userspace in iommufd
> if the device is allowed to enable ATS or not. That should roll up any
> FW overrides and the PCI cap block.

Right. May be just like the out_max_pasid_log2. Will take a look.

Thanks,
Shameer

