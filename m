Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADE8CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVcp-0002HE-Dp; Thu, 28 May 2026 03:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wSVco-0002Gg-Fz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:57:54 -0400
Received: from mail-westus2azon11010069.outbound.protection.outlook.com
 ([52.101.46.69] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wSVcm-0003Yc-9Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:57:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA9JGZ6GSl2FkjlY2BSvJAUBEecLpoX45Y8ORmHL9zwiwWiHGmW+kfEESqhvsgcZa6y8Br6lxsnMZj1lXZZX8jpopE/pq6xofZs1wrd0ISO8MaFQnP44ShpqXm1kvqzQbhCJJccRWDMW5BEQZ9/TThiLk0H/vvRwMnOB/Uk8dxnbsbdX+83HYPZtg6VlLCzY7OePVghZ40TGbV/xuUtuKKaZe+quk5WHhsPORUsb+1eSo5BumyI2AG1pbmLJkgeDFsBx6RpkncjUINZQEIPGG2K5DV8poOUXzljZEAsLxNkgmLkqrFY13hteqZuZ3Xp+S8GSmi73RWxT9AztZ/4iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYYrfF7qjiApc/xQDCmOkOJkHbPgJpHyn7NZ9lE2QVo=;
 b=IrrZz0Pkwq9T+NsKozdNX2PXqCOA+Cx9lXw3t1QNRaihlyTWD2GeDr+/nEvpTbhXyBwMfe5jNOPk8ZK0GPaCj0DHFY4xho6NOaovPKm3YfitJaNNrhsbWaeKS6XBxi+LuURlxf38Z0PKxAi0ov+2DX3TXy8FkryO4TewwSBrb82rEZzOXa3NC1c6eFIcz68XvGVvSA3PrYv0QQOEYWLhGDZYuLWoXdPl/LL03+o0/fJWQZp2dYUFm7uaF5ITIuoYCSOj9F7aAjdwOdU4KODMol31OXHDSz9Bxu/JsotcM33QK0O81KCToDFqSxZ1X25REJA+X6kVoY8fg+E3BHE+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYYrfF7qjiApc/xQDCmOkOJkHbPgJpHyn7NZ9lE2QVo=;
 b=CsRqk5pg9iS2St+wN2KL6Hu4p5UcGrpJ1Ik1AUSq9Gj8HzI5E/qC6+0U7MQSsqeOS0ZUoQrm+HMS3RV+foQAwMMAI6Ag3lElt219+zQWdyfPbGzJmSaYXaZyJTUCIfbET8k90vo0lKSl5tp9E2xHK21ixyFFwcLlcxOR8fVuQxMh+ANr5e/ek05gVCJ9Cy5XjBPOiLZgLH9Cwm3N3gmmFss851dKRpwzG51FIZxhicPOcRYEGRKMgRmqHNcCpcWbC+/hH1qq5hbw3a+9zS4DTIy4x8dx9yhEeiHD2SXMOz4AIVJMhCorRC7eKl3+MUkn27k8uBRzqsng7A9BVl0kLA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.13; Thu, 28 May 2026 07:52:37 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:52:37 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: RE: [PATCH v6 03/17] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v6 03/17] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHc7ZxaQoBqzCjpZkOQ3JjuYDqTSLYjEkbw
Date: Thu, 28 May 2026 07:52:37 +0000
Message-ID: <CH3PR12MB75489EC0BE24F1DE7E5DB35CAB092@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
 <20260527054658.1021096-4-zhenzhong.duan@intel.com>
In-Reply-To: <20260527054658.1021096-4-zhenzhong.duan@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB8414:EE_
x-ms-office365-filtering-correlation-id: 570ed6c2-16b1-4ce4-d68a-08debc8e1642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|22082099003|18002099003|6133799003|56012099006|5023799004|11063799006|4143699003;
x-microsoft-antispam-message-info: lf2fV/nzXmojl/LBCMl49ZHyreci4xMSbNDp1bbpOCMQatWyfLHo6czUa2BezkOux4KlmgKdtzPdamo0BKZJF6kyWY7/jexxzfkVxeU9UrHi6WN2vw/6pQ1kRIU5/Xg/ucVUCr4IVtF0Zx7tpFQ724gvJRUHxVmj2396/X0wXOAbLlWe2vZhVa73ouK/hEtrQmv8Lm6LoC1f32w8ex57HQa84u3ahqmnz+5qJDgzbq2HrCWU+h42ChMV3cVCQePARwDvmnchNF6AfB+TRYoSa/p1TfdHBWnY8g2roLTUPaDL2s0xuYMZ2EZIMEtne+wazr2pPiLYYNMoVKpnG9vuVoaxhjYfyRene6vWk5aq9tYKQ9HYdoJyLnFN2xBxhqWgolNMe8MPqRmk8XnOowx4lHVPWjVwZxnfQlORTcam1vWsfG2FUZG8RVu8zmjOmg3CPu+txL1uew8pN1G+iR7EbX8O3DjYxmFwP+hu5sbGldgbRsQ84dh5Bo4vusk0VHYJVizD4Wmn4hNIccgLQ88TI+vCCPSsAledETYSqisW2pFSqq3/h9oWhSsdLybo+CONrZQoICIglqGH5w8n871yVGv2gFOIxpZu58g73uKbg2HSbXXkMWg2koJwXar28V7le9n3hjkVIK/RR6ZIsOWvmciv3dgCUpK8G8mx1hYnsgLcGrnTHH4AQy+31BVDIwCBF092GqmVA+zOzqjfb4hfM85W0RdU5MeJPsYYfG2g054e1dhPP7aIxa8ptz3JKymv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wDcZioKv6oPFkNxeaTScQM4l3rlUwFAvd9bAFnUGklgMZ43pJramPxw+ULKq?=
 =?us-ascii?Q?ZoY531s6Rrts53KQWM4qgX23a6KsO+3e2jMYQJXp8C+Tf/nidf1LC0wMXJUM?=
 =?us-ascii?Q?sAaEnWWKT+8FC5umQSAVDjt9VLU5YHxJqfVv3YiU5esnl3D55GAr1+JsG7q6?=
 =?us-ascii?Q?/JOQ9IRNeqy6pieQObaAY3lB53LU4LG2Lfqq/ZVhjQrw7Y8HN/pzWtSixDrG?=
 =?us-ascii?Q?ZcuP20lIU7ixAOqNquhDmmkma8rYJ5i7nvQFlHOxsyCqqztwZQLlnVYSHG0E?=
 =?us-ascii?Q?WplSWIFhDM0G29xYM0UWPe4wd474zkqgO2jZtpdRxLIri+YjiDrNBA1ANqvQ?=
 =?us-ascii?Q?IC4kSuOpUBdQwhNT2lvEGI6w6ppu9cfTuw97xtuDP0CZzK+Ly5lOL3aicAJJ?=
 =?us-ascii?Q?Yxvj+1YUMDAuwqU+BZXhGgOHnCcwX1oukNZglOJLZkuFCPT/MQESkNXawuOZ?=
 =?us-ascii?Q?Gv1mK7VOYHvnEBSq67Jam5PLI1FPw+InZ1vIOFSLdA5CpQIlEOIYpa31n1Oy?=
 =?us-ascii?Q?26KKdXDd3G5U4KeRnd/BPB/5ZK7I8xSXKUWHybcpdAkVoAnwDmLMPY4nylrH?=
 =?us-ascii?Q?n/TBlMfQpHTCzs7VYEalicJfHztYHhyrlsA/8WnuMkV7zUg2J6auY7lxWXME?=
 =?us-ascii?Q?cXnS3+9r9/m6ekSeu+zzKuzSUUfcIB9cL+NRsTWSrH3rVDpt90fBBltXruDw?=
 =?us-ascii?Q?IpNha9XgWHIa4c1kgwxMisY0y+Yhu5fB+6GVEIRPAGI19UPOLDxlMUh5eN1g?=
 =?us-ascii?Q?hhcyPoFEoweUzeCdv1NN3+HqqWE2hPOTcYYvIyx9fIXKRGPbYxwgNGQYqe08?=
 =?us-ascii?Q?22AxqYR94MNPhbPZP3K9b1T18YVVBag/Aw8WjOnc01B0r/3MQlAveNkUX5Rr?=
 =?us-ascii?Q?4suBUciLldoOXsb4xBBroA/VaFzGAM9FoFfSN1Cv2o030J95nSMOTRdO7BwC?=
 =?us-ascii?Q?Px0VorluxPG/ksoiMuxb7EuGwtmEKVgZN4BoQfimqADJj8sI7UGGFdIXag9F?=
 =?us-ascii?Q?VQ535OZYlUJUZbsZEfhSpE66HHvu5TSJ2ZlSSHNfCxH8CrPmi+9wU1nJQQzX?=
 =?us-ascii?Q?fOxLa4ZmHzWyXp5i5PI8hutJpiexYIntuZ3/aBskUMbdkQzkZXVzURgHymfF?=
 =?us-ascii?Q?xmoIk2ur1FEdk3k7PcK462nrw+Sgg6DYVGmwW76DktYpWPVW++koArt59KRM?=
 =?us-ascii?Q?BwrsQD4gpgOQZx61pX51Vwa7gFBJ88bpKdLfbMlb+PduXZRLgy5SZPprV2po?=
 =?us-ascii?Q?33xp29tVEAr5LekGv4Kc0AP2ePfRTuxm0bHKmqFIEZ3+AMD4B4P2KKbC9+1v?=
 =?us-ascii?Q?d+lHpoNiLnz8XYDqW9CEKzN6GHUeWgzxbPs9TcfXKevnsQ5Bs9xACmBcVY4v?=
 =?us-ascii?Q?p+0ocIVWVRDtpBICv1JaQORCPFzB1e2DouzhrtEl38S/5+Ud7qvf8H8DB4vn?=
 =?us-ascii?Q?xdEjac5J6UUYXuZEGDqARbLjjDvunyM0c8ime//StqPLoKHdtrVGjtArwEha?=
 =?us-ascii?Q?aOKTQzW0Z63Xo/BRuasBAYA/yV83VXzYvAKTfetSKD8YmDEUSJC7h2DcolcW?=
 =?us-ascii?Q?PTDerbFoM9dVM0oS7BTkxfvaelsxicd0p66kBdhJ45QOQb/yoEbp7NxnW4Gc?=
 =?us-ascii?Q?bopQoy9BFLHhr0h9LQ9NwD1gJFP0gCL70olePk69nvQ5fY7SQL1sK2E4AtOP?=
 =?us-ascii?Q?pJkIV/KpqP2/sgN4g7CWmKLCTYOpw3vZ5cZloOd5hndVmJFHq61UXLIFuvIL?=
 =?us-ascii?Q?vvU9uNEvoQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570ed6c2-16b1-4ce4-d68a-08debc8e1642
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 07:52:37.7624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnRTH4h3zfEvRWps4COuz+Gz+N0eycuGVV467Rxe42LXtZw7IatOkNOnJUDuuFWsSocn9aGUKkXjoliPXhMDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
Received-SPF: permerror client-ip=52.101.46.69;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Sent: 27 May 2026 06:47
> To: qemu-devel@nongnu.org
> Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com;
> mst@redhat.com; jasowang@redhat.com; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
> Thodi <skolothumtho@nvidia.com>; joao.m.martins@oracle.com;
> clement.mathieu--drif@bull.com; kevin.tian@intel.com; yi.l.liu@intel.com;
> xudong.hao@intel.com; Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [PATCH v6 03/17] vfio/iommufd: Create nesting parent hwpt with
> IOMMU_HWPT_ALLOC_PASID flag
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> When both device and vIOMMU have PASID enabled, then guest may setup
> pasid usages such as SVM.
>=20
> VFIO needs to be aware of potential pasid usage and should attach the
> non-pasid part of pasid-capable device to hwpt flagged with
> IOMMU_HWPT_ALLOC_PASID.
>=20
> ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it.
> So
> we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED
> to
> determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
> flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by
> VTD.
>=20
> Opportunistically add documentation for VIOMMU_FLAG_PASID_SUPPORTED
> and explain the difference with VIOMMU_FLAG_WANT_PASID_ATTACH.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

