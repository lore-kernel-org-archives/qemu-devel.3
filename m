Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D9E63F32
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 07:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrsrP-0005TU-Ds; Mon, 16 Feb 2026 02:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrsrL-0005SZ-Mm
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:17:31 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrsrJ-0004yo-GU
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAsztJ6vBDRmclKfsOxJOBA/6nlGU2o0SGVbY761N4/sWOi5QnGaQjrZ4oAHNUV2nNZOzHGexzWH9+ysW+b4PyqjJCADXYYs+n1t9gQQpohNGjOK3pZnvPatfgbkXXpPrImoKDbvwhqpe35pWFNK2jPB7I/im80WYcJ3jPMi7/t8lyh7lJPAtiJx7Pq7ro+D9Nj9Wjn58Z4EAJeU5jISy/6v86wvvRoYM3rotrNacxEpB2ONBkP6rz92/j60w2XYf7xoq6IuYO6AXTBbBkF7eLewjWfoqnYwJ7X8KjtWi7DJqjC5xAfo/DTccH6e2Wsaa0fAXxTZNzT6upOhRL0ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8yvA+F0IQ/sZJ9pi92er7KsxgA9jFUgZ+m89FJf98o=;
 b=Jl+6AWGMOtUMcKYfMmxmnvgKIW//Ox1WIkNVu+hUuiYT2eWb+3t2234vqdZpwr8flonBfRNATcunUJCxE8FyZmVCieywnG5djW95YoKbzLhTj2rcxmTAo6zql5dVXe+nwT+fouhDfWTYTw55D+xIzXXyvMVx/Pqmks3qKq6/St/sqSpXSyPsLFbnnRUlok4kpbHopvzi8r58bqGW3d8ZH5FaVM+GCtScgHVUUlmFLvm/ovZnAESIj9Dz8LlOHIlP9xBAjJD365yRiGnTAl5qyxL/jKrEyjkk12btXIFQcd+JgPi9QDXNXqXHdPq8KW/oGTBZxCBLYEqjCKhafJc8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8yvA+F0IQ/sZJ9pi92er7KsxgA9jFUgZ+m89FJf98o=;
 b=AeD7WIjnNkYocqW7bRbx0baKqUqPSi9vPAubKpXiHyVIpCpSMa0zFqeU4Mbk+v78Ua6fbJLT7DBY5FUHBUyBbqa194xpDT2hm6zgyc5zBbOEecTlL2ASUjBe0Il8MEjLmlqc9E1OFA/vgrvIwdjQxmXZuFj13UBadsFNCTy4FNWXT2QbM3NigVXE//HJiAMtvYh0QC5n0UbYnU83YAIBqST6XQ0dTOtEysoprePis4U3ErJ6arKwzqLLhKQmdvtjUENi4U6XEgzNw/CcHjkOTTPgGyIQatJYhpMWUV/CpTOn4sSXBaSFIrpx/csF3TuV1IvuKxNSbRkCGDBvk7utwA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 07:17:23 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 07:17:23 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Vikram Sethi
 <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Shameer Kolothum Thodi
 <skolothumtho@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>
CC: Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)"
 <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Thread-Topic: [PATCH v2 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
Thread-Index: AQHcmwN0ar8vW5hixUmg2suBTSh537V9x2aAgAclqK8=
Date: Mon, 16 Feb 2026 07:17:23 +0000
Message-ID: <SA1PR12MB71994FF05BA4E852DF0CA080B06CA@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260211030615.3202-1-ankita@nvidia.com>
 <20260211030615.3202-2-ankita@nvidia.com>
 <98b36726-71d1-4129-99cf-b16bea1575f1@redhat.com>
In-Reply-To: <98b36726-71d1-4129-99cf-b16bea1575f1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|SN7PR12MB7177:EE_
x-ms-office365-filtering-correlation-id: 00c8bb9a-91ef-4cf4-bc6e-08de6d2b6e10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ROOn/T6vwdwoAaYSZVrURuvPtcUppPB0YgP0WUUXzBmZkJkHYuXg/fHR/U?=
 =?iso-8859-1?Q?CfC84BZDdPhQGiY/1gURY+xt+DseXuv805RXowCgiaJgZ/ecN8TJtiyF+A?=
 =?iso-8859-1?Q?EUHW7V4BRBd2aySZbpLjTKE72TUyzp1htfd7YVil12n5SpH7wr5xKouKJF?=
 =?iso-8859-1?Q?vPEh+itzLbrwXc3bjItL01nAEqQGJeBuPsTcFWLaH6I7TpGDJp3ofpWKc/?=
 =?iso-8859-1?Q?QgmIkkAmAGESCE0DPDhakOOC38kVltyAB/q88jVZ+b3neLSj9D2Ye01hB9?=
 =?iso-8859-1?Q?UDA9xaCDvRZFYPySTVA4GhbSUT1/0zgbImJILM8K+CPYZYgpTOqEG8Ifqy?=
 =?iso-8859-1?Q?+hhEMRMKTRiOu3BRc8niF5dhVRXFP6burXzBnK5U0eX7ym2zXyyjH+Cbwe?=
 =?iso-8859-1?Q?8FUHa5yH/iZ78bbemPGHuzMzPAGrCYSgitWiizwH+h8BGabtb91fVChqKb?=
 =?iso-8859-1?Q?SGiBa48OSWWJ/jCLiDASWZOEPOOZVXs12VoRnv0Th58gDJ6dcV7EiJLMEh?=
 =?iso-8859-1?Q?CgpvRQgwHq7DlXoamOSf4SwecdPTgAVhdLn9yZbs754dBMW0mPCXa1AlY0?=
 =?iso-8859-1?Q?PDQjPepGQPrA40k9Lt3SQFt3R/BqAsVH74ysDaAf4d7+6odz2orR4aKLHs?=
 =?iso-8859-1?Q?dY8B12AzFv2EHGyMXHVxgC3mCk0ImWoVJTVSGGPeeaCJ/nGJnEkURuqyis?=
 =?iso-8859-1?Q?+3Yd0SNRxcpzAlmNO7j+26NxiU8/ZMLy+TChOBm9ByhQ1brRGldQtKh1eO?=
 =?iso-8859-1?Q?sprigs4oXDL3xh3d9uyP14kKrEydeYvhyHsFITYNfZh/brf++YFifiM+ab?=
 =?iso-8859-1?Q?z76oHjLYmTpOeED9bofFY8ESEcxm6EgLkLU0wHQU2XPsZnLoIuj6w+o7ma?=
 =?iso-8859-1?Q?Z5p7TGlQVOsIZa/SwnErOgTxdyQ53bEslVfehebyfkbyq14I40C9hek0Zm?=
 =?iso-8859-1?Q?XiAJzo6IHGkzwf85Pq4qPUCYcrQdNcW4bBWbB7dsd5cfbbskoKwZqk6FOn?=
 =?iso-8859-1?Q?QIifNezTOoAfqIAC56aSZN24xrcnkWqki/EeJxexwD89lPpHEBmVAuEDqt?=
 =?iso-8859-1?Q?NNE8wt6iWyqtMqFzYEqiPRFLvcUToHJWTJpSwuYZgfhs0pHJRsXfH7V+8r?=
 =?iso-8859-1?Q?jzf6FQjHTJ0SaAiCzs+hxOzsQYtufbfVzZo4mupwqjLSjRMHuYsqS6A/bz?=
 =?iso-8859-1?Q?pnyDjKqey0W0iyL7HGBVkxPMyWQM6EZqhjYR6NLnTbRhiIIzBBfaFw+WoE?=
 =?iso-8859-1?Q?Thnk9whWi5CBXiklQt34sJZXd+B+Do7u/RkPc+MQYnY0vUBVhKBARBaijd?=
 =?iso-8859-1?Q?UkSQOKYIgL/1mNXWXGBngc5wtxoSUdKdgvjlxJoTcjE7Rk1wDGWiGqEnWR?=
 =?iso-8859-1?Q?PbKiCAuxEoyA5lKI0J53ySBouGltyCPULnTOpTRjeQjoIIRfwSIK4aKrAd?=
 =?iso-8859-1?Q?efGXvA2WyVnL+Jtsh/Iiw1PeFvo2XC4D6/Jxk41QhRWNYCa1t6CxfKYd/l?=
 =?iso-8859-1?Q?5wYzng+l1gNIhdWLBlXoMPdhs5PHQeEe7FZtwhtLBLN/wzlYKQwVuAudwE?=
 =?iso-8859-1?Q?S9Ve/uO8R0je2xiROm2+CzdcjKAhpnzpfeH2tm+0Gno6k1JtsxzXwKNwcC?=
 =?iso-8859-1?Q?Lov4omPCGnUaZAPnJ3jdfGmZJ39d4qPDokh95JATsOa+45B1Qwyp7YZ/yb?=
 =?iso-8859-1?Q?wCI2PkP4IrVMHtCHsyc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1jOcXnypaxRoTwGSN2QPrBLTpqpoS18kxI2xjeVRUuGgyM1lnHdCWwJ0AL?=
 =?iso-8859-1?Q?2/WliXuBRbha48mGZ9wplfbhoMyc96c1Njx+hLQKtSfSnwNAHHyMhsOVdU?=
 =?iso-8859-1?Q?Jm1eSnXWmrF8LsAT58ADnxvDwJh/W986fOWen4Ph4o7u1tEDv28E7cq+2F?=
 =?iso-8859-1?Q?yI/uyfXf+0f4jpRGw10TlGKb0Kl/zETEKgglQy5RZIAkXZXtI3KFGtDt3W?=
 =?iso-8859-1?Q?awQXyfCjJFjg96G1KP2eq/kpNY34+se03eoXdLuiPWP61ugyGb99TRVmml?=
 =?iso-8859-1?Q?CliUfETy2R0dKK0HUDC3l9lVcelO6ROQTJDQvrKC9JHu5ZdI6RgKgPxCgi?=
 =?iso-8859-1?Q?spTjj4Runv0xBr+Tua8qhmPihUWZphZ7Z4yPkCr6Vmd2/GB7j/QblhvV84?=
 =?iso-8859-1?Q?NgAUko2E5pEPINeQ/V5MzodBldD7fz+Bwvfq/JoGn5VeS7+ux8J1Gnpe6v?=
 =?iso-8859-1?Q?EPm72b1h6Vk+X/OUGQLPN7akl9vv8jQkIb7Kby/JRj2BZ/77RQ3QrOufkJ?=
 =?iso-8859-1?Q?klCPaWxQW/3J5KYwV6+Otx5aAIEPv14GW4J8daWcqAB0T8OU/NSrpaUIH9?=
 =?iso-8859-1?Q?BE5TLpTSKRSztayikMEEwri+ppAZ397DxmTmcC/96QzGyMCNPWRs/h7Chd?=
 =?iso-8859-1?Q?B7gENdACJKAN1VXXngqSayrhKYalB8YTQDgInR/6L7Krw9EwQsmSzhqtiF?=
 =?iso-8859-1?Q?saB/Bu5UtZEU/EygprNhLEtW8VZBCS2sRVOshl1/SF0Yb2BR2EivFlFlua?=
 =?iso-8859-1?Q?AJpVv8jYPHGZpXi8OXRGtJFUGN5cd8vzYx1pooASzCzaXuAlh9TwdUi0tW?=
 =?iso-8859-1?Q?rma5GCWHA+2+M2BOOZ0Np36dtlUnBhqoARJJEbqspmvfTFUMPC+2fDW41T?=
 =?iso-8859-1?Q?+iGvmnjlZ6Ac2Ff8P3t5uPjwmqXY8F6tnQVNfHjuQElSl5BaFZnAzxutNE?=
 =?iso-8859-1?Q?tl44DmkBs6d6TyeaRNMMZ5j5CcHE/fgngdpTXEk0DWpKyuHH3FLcLaDeY6?=
 =?iso-8859-1?Q?ta+VJ+IV+aZ5bdMu0mj6iLr4JcDerTjrWErfPnMGtVcKEXiN/MAOiGWjyF?=
 =?iso-8859-1?Q?q4hkx9+W3uyknToU6SxtUgblLDMumi3r7DJHQE7JtJQ1RAmTjePnJOmeLE?=
 =?iso-8859-1?Q?4RqAMaZbuM1ojEkrerQDiGdUZ14xM3lD0j8U1HxmvCxZmABMh6S9LXf8eV?=
 =?iso-8859-1?Q?xH9GxDhAdCuAZmwNNzI8V1vqUcp+kT2pllw2luhwcM/iHxWkGMNF4+wF3l?=
 =?iso-8859-1?Q?OiBIimDv1sp/XB/IKLKyYAJPjhu0UVXZpzZAh0gw82FYuRrXItO0T3yWfr?=
 =?iso-8859-1?Q?fCOcQlP2opjhL0yE+nUPCXRtodOM4k9bdqj8qUwYiejhzt7z7VPi8CDJCf?=
 =?iso-8859-1?Q?Z+WXEj2AO3Y05dQvo5hzJYJAvmunXS+lL0ZhIOwDKdjv9HCNMJs6V4wc1n?=
 =?iso-8859-1?Q?rBTYsPEG2zlDAqJyNNkyJlptoa/lV0p3lOFKWfIVHfBPBP+Fl1SESwtaUn?=
 =?iso-8859-1?Q?EuLOWdRh1kQTMxiUA/YZxiKK8/nQ34zmRpqUG/K2C1Hib4Ai6EOBswIhBr?=
 =?iso-8859-1?Q?W9z1ATBBfcYpBjtVcYa/BX87OEcCGRIBT41N7MHcKSN15pNiB0qW7J7JUz?=
 =?iso-8859-1?Q?Z4K87/8AhJz1I/VDhlDNya1HurgfpxLwtjZtMFWpbu+Ppi+Kt04TC6q4Ru?=
 =?iso-8859-1?Q?b3FV8gdwmxoTc6emOePgA88LeVan6g7wwg/KH4Sl7KtM5j/+YLKR3KlK6T?=
 =?iso-8859-1?Q?FX9DEe4SpPIjuq1tsOPAiWiz++X5EKPM6CA+KshzZL7xFf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c8bb9a-91ef-4cf4-bc6e-08de6d2b6e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 07:17:23.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSp5DAUa7OuIHODRPE7pY/HOr1M2Q4mHHzx/fRNrvNHD2+E1h3YoC2DEMclqwnz7BZpYBf5vlR5xUAqh2LL9Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=ankita@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 1; i < region->nr_mmaps; i++) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 off_t prev_end =3D region->mmaps[i - 1=
].offset +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 region->mmaps[i - 1].size;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (prev_end > region->mmaps[i].offset=
) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("%s: overlapp=
ing sparse mmap regions detected "=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",=0A=
>=0A=
> please use PRIx64=0A=
>=0A=
>=0A=
> An extra 'Error **' parameter to vfio_region_setup() could also be=0A=
> considered to propagate the error to vfio_pci_realize(). It shouldn't=0A=
> be too complex to add.=0A=
=0A=
Thanks Cedric for the comment, I've posted v3 addressing the additional=0A=
Error ** param. Please take a look.=0A=
https://lore.kernel.org/all/20260215084950.4657-1-ankita@nvidia.com/=0A=
=0A=
I missed to address to use the PRIx64 in error_report. I'll consolidate tha=
t=0A=
with any additional comments that I get in that version.=

