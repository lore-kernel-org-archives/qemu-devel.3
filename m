Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A72CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUvv-0001gw-4P; Tue, 16 Jun 2026 10:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZUvs-0001fz-Nn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:38:28 -0400
Received: from mail-northcentralusazon11012032.outbound.protection.outlook.com
 ([40.107.200.32] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZUvr-0002M6-CB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGh6h5tv9J3LI759V5+GxNOf/FbfvYZLpSNQsh5qUnj6tkioLtBj4lcGiMuwDdqDU5oVo4CZ5R3XaLTYvVVAnWn2+cpRbZ9Tay/WIopHtJ26ZDs0Gp04KfQN8SWJbdFGLQCKo4T9bhSnrvD8+ZvtoW+r062nQOVE1ptHJD3h3iOhAJpv4n+BYBLMQ04AJmcAeMUl0od2SZ1ZLXIL2cnTBw+b4hjFtGPOt9FaIzifDrvxymREjl2PGqJ77lV+VZ0O+v6aU0f4TcRw5EInU5QwqX4F0L+X9LRp3iXPR5YIP7Pa4nUKiHkpkNOUr+7et7cSVZrazDxdJRRhzdelJgVEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrEgdxgS4K9+xS7INiL5YcqKv78l5oPm5SuqNhYB5wU=;
 b=KLB8zohK4UG1bPCisO8ehAz/253Q9amZXjnVEHqqi2A1og/Gc89tvFv97CLP6BHmIoS/ZQZw4xDipHt5c/K/Kuw8BnnaAGB30Bh1XCKxHNH7qQiIz9T2IojaMiHRPzaiIdxKIProQIk+R0Abo31lKoWRyLcykHk7maJ/dOITcGM7R008rMtvFw3qTcxJpsf2GKbRD4AIrYh9yr45EOdQdCdgWiJJvBjB7UQNJUbaqJ6rKuAjM1oJlx/XpBHAHLgqxy2w5iHIPTD/dpMitER+URyH1sW052QpEBJfMjWZYGUFNMDoERmCTbbz2MsGk3b3uvVccw7KrTUqYv+B4TASCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrEgdxgS4K9+xS7INiL5YcqKv78l5oPm5SuqNhYB5wU=;
 b=OC3+TS/Hv5DcjUiBe2ZLCs0W9FY1KT2WvD1pkuN+CklLGndEbaDgT4LNgRBBpknb7cDGz2tiwAvlHoTikQwH9AIQ48dK45NeDTUi9d2V6SXBBBw3HQe716Uk7icxd/Q0OfTdm/2XJl7uk5xdQ75SN1+z4UHiyeYgj1WnsubIySw2vmtZETBeeKrBBJPPyjSiYWo0smoDzg9F7HPsK4+/BBq/nk7OCMl2FTKxJzPloAoCsasPf6X6DzKXoUiuJI86ntT0DPMA2UQFBW4cuSfrKHnXvMAI+wY2oo4dYdk6yT4ATRiTlfjeo6V7QwOZYcX89tSb7ugJzVN8hzxGNQrAJg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:33:12 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:33:11 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 1/3] iommufd: Introduce handler for device ATS support
Thread-Topic: [PATCH v2 1/3] iommufd: Introduce handler for device ATS support
Thread-Index: AQHc/QhmWzcTYDWsLUGwiteoIhPaHLZBP/Ow
Date: Tue, 16 Jun 2026 14:33:11 +0000
Message-ID: <SJ0PR12MB861438044D82715784E35DEBABE52@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-2-nathanc@nvidia.com>
In-Reply-To: <20260615204849.3659647-2-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|CH3PR12MB9251:EE_
x-ms-office365-filtering-correlation-id: 2b7ac6b6-9cdd-4d62-8617-08decbb43165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: IaMR8RG/HWXP0h3W1y9U/tHxv2nit9fwVtVXKdVWFrV6jZQZEjqz9g3tvqeYNtZrg9SwrPafgElfxs2gP2VixtOMztn+ZHQYvwj3rfLC74xDfevxGqfve/PO3yYo2eZpJ+70I/NqLUHdJhnkk07FZ4op7M8ENigbupgwCbbNIrfaKc6NEWAxhaeHc7e8IFtvfsPaYBP54/XtssKvKmHCDp/pjd7L3oXYNaMi2aq4VbkrolZguKqlVnEZvDVpIFh8O2SjyH0TMuFeF8gbQowUdSI0S3HhPiT1ScDrmQcEOcXpX7S6f/PBsHo20AEHfBrO5PUDKw7+iGyJfVhRpfAuF5IdqZeU0qLZSWAqd6Uo3xX4zf7qJJiMq98ackJCLnE0AO1ZgKVCAROlacE+Q1gE4MD8IFa97Jbs9b7czwBAWADdGt3KxPPo30HoE8mm60zYuBG/KPdCsEdHd+EHVKvAF8DT2yH5RbFbNHiBaW0TVlFaLmemhwnY8OR7JMogk+XlCzVYAZG+BEXGQ9bhqgXi8kru5FtauMbFPp494EWwx/yFBGXH68+2VlKacrN/yTFqgQ3/i1FbYabqiykqvui2HRFQzpuFGgHVdkxrnZEktWodrO3qjg+Cgaf7j/muJ8SALKpGLd4jQhhFDiF17C9EPqQHb9yYgOWceky1mqW++fxqMG7GJz2orUJxuggV5qWiEnMDKGQ6N4ucvSZkaTAYhipTjPoCvzbPCj3tRW20TIErFWDktMtwXCEAnRasOWPl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A6vzYucP6KOZcAnBeK+Z6Cio2VfPloFaSCl0ggpUJCr5/P5XX5aHFmpWb1?=
 =?iso-8859-1?Q?ms8qa6j4lC72G6nxaGEdwJR4g7VjQfD86NbhPIRgJUBg5G9qpXizhzxCvU?=
 =?iso-8859-1?Q?J5Ru8x0SQbO1sl39ZEM9NSvvB1OEfSk605H7SInkGjHtoFb3L3Kromnk2M?=
 =?iso-8859-1?Q?Hiqh0noVqDX0kqMvl9Vq9TK2YTgaO0D/EpjAKaBU5tH4J3C9fY0VnYgNFK?=
 =?iso-8859-1?Q?jBgnde7m0eofFMT875v1cNCu9YyP3VFC/Xr+gdrEw9/7OQfBIdTUu8F62Q?=
 =?iso-8859-1?Q?/irE6Kx/zLgch0mqJoRF0G97IgaRDaCZ72BjPdfX7Ln6HF9DB1a6LPcYEC?=
 =?iso-8859-1?Q?XivZIQxsGcvmdjjQTML+AABBMbZ5uAiYVlGLj3Uo/WMaPtzFcr8RCNsc3m?=
 =?iso-8859-1?Q?Z/TxkxDNCsJ6rkOwwLeCwxz4lB9LQtb3V8APu27X8SH14yY4dICWVRnEKU?=
 =?iso-8859-1?Q?Wonl/g/H3PKKy5EvVf0tvPPojAnPtvY7g6srirX3hSkdBDbEBehX8418hS?=
 =?iso-8859-1?Q?JoLs5dQciuzznzcB8S9mOaLbd6jyZi9eZ4kDKfY5KGHEB7KKClqiT/y/VW?=
 =?iso-8859-1?Q?DlDkw0YVYN1DrESvXjKaKDSJm9KhAFZ5qq5Pjjl4d+P3LqvHKDnRFB4ndr?=
 =?iso-8859-1?Q?3T8uwv2N38WtR4sDgY56b/C0s76efKQ0nojY/vgmXwhUJFlP75NXibvm2c?=
 =?iso-8859-1?Q?TL1qQsvL0qs3Nc2zXq0Pfr5xdG9RxMqI2PCSHe4TxCIuFdYYMpMXVcvPaf?=
 =?iso-8859-1?Q?XM8jEwD1cuMLvO4nEMy+seWGJcpSsovxxjNPg+0S3FZ2l7vKg7MdNisEt+?=
 =?iso-8859-1?Q?Mvllx0WPdeyHNAtchd/5vxoyATZdKOxK0HxiikYk4VJgzMb6mEpxo8bvcp?=
 =?iso-8859-1?Q?tBY5Il8QvUwJRo1Mh4tmkFNdEVQ6KAdmRJPWpAy1e9zg8fqOXKf19m4TX5?=
 =?iso-8859-1?Q?pJ3rrc8eoWo4pHYUtjS8HBSjBPDdHdm07zs4HNVBEhNOZmJaqooc16Nbln?=
 =?iso-8859-1?Q?rtAo1/WqCXCBJAawv9zt42En176nwTiLl0uNM0Xj1sTum5kcmrs7xJ+/Rh?=
 =?iso-8859-1?Q?4NMQu0gSQJBpsUVoVL9M5SsQtK3RXDYkTmcbgnDxZLl4lqqvh7i0Kr3kwm?=
 =?iso-8859-1?Q?z1lILJZqg1VFgjBkiWT5kAI3NsjtNjGAEr8P14kLM+yG1u6Um4gLI73IRw?=
 =?iso-8859-1?Q?ioMT7u1L/i4b0UIlWsSgbZcVzZmCQTc6Gu3Gc2TCZukzZU/2gwW1macgbw?=
 =?iso-8859-1?Q?lbt8H+5K8H36PznnySZQKSzeWz9gdRDSymMt5iETOI6HV/KjfaDnNMwM5e?=
 =?iso-8859-1?Q?JtTRcJ7zS4M3GsvH0+HBdIWKFwqo4tnS8nNW3avDzbbnHVVJMnbp3/bJsG?=
 =?iso-8859-1?Q?aLDP5k/6Gr5s36rN3Q6Dm0FB63kIeE6lnIJ5Lzmn7QNB8Gc5k945y0Ra23?=
 =?iso-8859-1?Q?e5TB1QUSe9Bh0A5VZ90yGnZSL8W/M75AYkBDn5sfQIU8I6ovDjN5D9vFU2?=
 =?iso-8859-1?Q?GeygIVUi6nKUGNGz9RiYxqKbes38sdPq4cXHwzi2bpznqn9S2G9+sxwskX?=
 =?iso-8859-1?Q?D0t9NtgJEdwo3uWr90fk88ngSU2V2uKBiwRM6R2Nk96MSK9SOz+/NylBpx?=
 =?iso-8859-1?Q?h8TU5B9gYK5rTI4gyNbNPdgKO7/GO4taDWBBR3JMzguZAIQ0z09MJmGKL2?=
 =?iso-8859-1?Q?ySdzeRfFDCE1YMmjWP9LQi2gZWGH7tSc0JRhiJRu3UItoUQgAvEwQP0FyH?=
 =?iso-8859-1?Q?65y8N/5tOPbRw6z46MpXUz5sDgtriGp40D1kKpS2ZgB7shoeqKpuDuHir/?=
 =?iso-8859-1?Q?UIeergLRcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7ac6b6-9cdd-4d62-8617-08decbb43165
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 14:33:11.6067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6ig75ChwVfpitco3t1LuD9zBiDS5DNYp+IDR/Esd2B9AX56UIhYNKWHb9BEgre3DtUJvvSks4FQGx+uAsMPdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
Received-SPF: permerror client-ip=40.107.200.32;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 15 June 2026 21:49
> To: qemu-devel@nongnu.org
> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
> Zhenzhong Duan <zhenzhong.duan@intel.com>; Philippe Mathieu-Daud=E9
> <philmd@mailo.com>; Zhao Liu <zhao1.liu@intel.com>; Alex Williamson
> <alex@shazbot.org>; C=E9dric Le Goater <clg@redhat.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
> Kolothum Thodi <skolothumtho@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v2 1/3] iommufd: Introduce handler for device ATS support
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Introduce a support_ats() handler that returns whether ATS is supported
> for a device associated with a host IOMMU device, checking if the
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
>=20
> Implement this handler in a new function for iommufd.
>=20
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

