Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE848EE4997
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 19:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vafAk-0005Tv-La; Tue, 30 Dec 2025 14:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vafAD-0005KQ-R1; Tue, 30 Dec 2025 14:13:50 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vafA8-0000kG-Ix; Tue, 30 Dec 2025 14:13:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fu93U1A+nCTEy/hz88544QNVUrzjhAgYAxXa7cP8y0QtSD/iqsDof199griz3dZYTXm/Q6aXdJBUFe8/2TIofMGxGCNpBjHqns0PK0VPsBOqEIZaoL6yxCYIbQCNGx9O9sfkviFiTJwhxxqUGSmADwV0+GwvtmLR+eEe1GZw7ohGSrdP963mZIzMbjxG1tiYTXiTIceURYJ/6z9gFnQJhQzFcPCTq0Lglz+Kgj58MB5kyv3XFTLsYCvtBm/iSGUYYh1USLfIdOavwq9gmoNJYNz1595guLZq9kTBWTb7tRtxfQO1C4cHyHcuiLVIvLxiiRVMC1G1bj7DxBCezuu1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnFcbhXY+ay/gzmpGW1mHF9vNnbVW4dJvg6JCl35RqM=;
 b=mzBeQpOAeY5Y+eaxX6HOcUQzSDC28ct0spMPEN1HFtfI8o7DA9YktfD5ED5OUhXE4CYCu2eFxHy1mS+43tm7EV1EI1ERk96hNc4Hl8g/pjetUYrKYYW9dV8GZStE8m26ZiP0HvoeyWwyDj0W2Ow7uoSwq4XEZ2VEscJ4KiZ6JKiGr4/kteJoBIEJZnJ0gpXC5QY7nfmLN398nMpItbWWu9vgbyL9GeQxodDXUN6/DhQljHlgJRBaWWqiVgnrAPIdmWhbtycKq2TqN8ovEBCFuA+meLwrGUT14/fNxjyYCrCAH+m0j1rFhOu3l0SVuPFxcD/2IDnx2VmAgudWCu4pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnFcbhXY+ay/gzmpGW1mHF9vNnbVW4dJvg6JCl35RqM=;
 b=WczZKP1P1zG3nhN74sdxKv4O4FOiu6sdUSU/iFYc3qd1+gHIgH3RypswO5xvipt9+v9Ac74Z+3zmNOvZdHfmz1uCica2SGj2V0aEVE/JSwLAOrkvjZIC/5Gz+ftD6CHiqUQ6EGlYDqpFEHymhFQTdwqeqFZGphpZ/aQByY9CkPMxlndnPEG8IxCgTXEbMj6H7AWtzCdRGAnu54wSYJYlLXEPeLjKaKFLvn4J/qCxzNk/k46sNqeQ9fJ3GvKP+HpPLC3K6Aqp81txGSsykerJKsitmSxEe2a/jXO88Zb1hw7JoTdT0J+Rbx5mQtwkHFs0WeI50XCTafDBVu1Eo+FBGg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 19:13:34 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 19:13:34 +0000
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
Subject: RE: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Thread-Topic: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Thread-Index: AQHcadrI+NnRATD/c0u4kZbIiV9u27U5Ks6AgADmM+CAAIqsAIAAA3uAgAAFU2A=
Date: Tue, 30 Dec 2025 19:13:34 +0000
Message-ID: <CH3PR12MB7548FE9815EE3E8B3A7BBDF3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
 <aVLgV+kscNVlHjIq@Asurada-Nvidia>
 <CH3PR12MB7548E7EC8F2C1FD748BCAA65ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aVQVxrGenUgN7MNS@Asurada-Nvidia> <aVQYsTJPNmYPY3VH@Asurada-Nvidia>
In-Reply-To: <aVQYsTJPNmYPY3VH@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS7PR12MB6005:EE_
x-ms-office365-filtering-correlation-id: 6c68edf9-c87c-442f-8f8e-08de47d7871c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9YdfKDpto5uPgcmCc0WWFew6XS/9IulWA+WiybZN61SW01aRqukqrnmmJPln?=
 =?us-ascii?Q?HU+f5JGr5jPj1qvJ32DHd4Z4PBjq3LxihNEidwLiv/eDkbU1VkkdXRJJLyCV?=
 =?us-ascii?Q?2zex1iQGMk7eXEA2CeLc46D8hmGAZj8g4wgFIW/yCaE3bdVEYyCVB8S6pmfx?=
 =?us-ascii?Q?21aLpddhwido7BAZMI+UwhfkINGkFiH8DL92oZatRePykfpTxBJ3HGJEPIu8?=
 =?us-ascii?Q?sqB2W2spMUyapTwsC4qdvuJaKMU8FejHyRtpr9G9ZuVu6/jqujh/Of6v1QYA?=
 =?us-ascii?Q?PWQkUN+A3IB3GeXosoOIlN4c7NajmqUPJiUkGQDaWehkddW8nT2XM7UMcmPm?=
 =?us-ascii?Q?ho6/mWGt6+HgPueDflbZG/euOHbug9UoDGpgIT32SPzWTPgtExwOYu9HAVxS?=
 =?us-ascii?Q?NXm4WRn8Y3MVeJvq+xNB2TjSLaz/R1vcZiinHNnsyEXvz1TXZk4tpmG5g6aQ?=
 =?us-ascii?Q?wtKTP4HlxbMLN0GYYH6tQm1nAl6/l9cadHs2DaAYPcrlI109Pq1yGrTaXweq?=
 =?us-ascii?Q?fmEXdRUbJXeDNlnhYV97AMwQmPogZIrOzGt7sgg7mgHprCzvWXQyfKI5GNw5?=
 =?us-ascii?Q?1pX5C+JRK2xaR+T6GSIqtlumB5HgVCU3YKxiE0HI/mK+v+uDwt6xYyF/w/h6?=
 =?us-ascii?Q?wDjHs8UP6NZ/02nxxqEOOrByrWzqatcxdTzSBEeHVhJzye1/uI5/bCwIK/sg?=
 =?us-ascii?Q?63HWFp0MSk/1WnPIhIFI4bHYlY2VeajGz/NGksrok0bYfjAYdPggShwNRrFl?=
 =?us-ascii?Q?xNA9/vAq2qswzcWFp0cgKEwryUIS8QprnLdyTC/8wTErC6N3WYCiwcGyQP43?=
 =?us-ascii?Q?vygChpO4VjjxGFY4qtzs0BmSpDqNXJDxqhHaFa7ki2mCm0X+LIDywgc/Hc+A?=
 =?us-ascii?Q?K0OnOHxpDdQMO5KMPOkowX1p9y2DiZyyPgXzJiZlVUAJpzGR/0mzTmRs8bjM?=
 =?us-ascii?Q?49L6YAZQOliVTV4lC+JnZLFJ7nJKxNd8Uun0kDBAhdpHF353sp0HtJLvEHKL?=
 =?us-ascii?Q?frg7Qb3FC4N4fA12uyp/EJI8n/9O64h9oo7XpdD8MakqaCLcXJ+DneWkByQd?=
 =?us-ascii?Q?vk4bAtrttOszLJVowyt2WQ2uBQ1VuKbV6PqpDkZ9+9e2HE+CwmRVFkxAPyZp?=
 =?us-ascii?Q?wSvmyo+5aqsh4BmjZgbu+f0k3ku5m7Es0//fgu6Aypf4v2GkkYqMTUZ/4gUm?=
 =?us-ascii?Q?wasIZhSfgiQG+/WT/JKS7/KALSirkdFZKiJ340Ylosd/C/5g/nY9IJCNMxtT?=
 =?us-ascii?Q?+yFkO5fLt+jebCWI6lq7npAkKzmY2Hr9IT/wEQCHBq5+Ph1ayBmiv69Z6WCP?=
 =?us-ascii?Q?SxHd1S0Jut17aaTDiqv0fiHo9IJPpHKrDvF0752tiVJtpt3cnblPQnkbcWpq?=
 =?us-ascii?Q?RURPE+13wCVOQKJTQiijtuxkW4C+CdYJP+n2xr/+RB/W2qsrJQKy1EH4UfWJ?=
 =?us-ascii?Q?aaYnvhrsBF5FSkKOk5mkxTyqAnO+aEwrUWcWeLynD+JjFC2zZDZtRC8QwxFm?=
 =?us-ascii?Q?AOF574PUSm6dwj5GLxfax0fjEoaHQk2Cq+5J?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iLJby4wLdGCp9UyrROIrCOpOqXkjDlzj4zRK7Is5jz4IdQ74LwqKOP91SsZZ?=
 =?us-ascii?Q?68fREu16JhxyKvGeqe4PluMK9eLovaHb2TEb07XC9XQJCf5qB+Yz7Enu9Ob8?=
 =?us-ascii?Q?ZCBWqNHlPvxIBYwnxsocK7WGXSaZduTxBDwy5wG1Kf2Gd6pi/o8ZB4eW7Mbn?=
 =?us-ascii?Q?9h9Q7k7HTVXdjueXYLZwI43rBzoYKm9EAC8Cr8IJgdUenj3PBtpM+pmzfJNT?=
 =?us-ascii?Q?pMGASRVx+SvBXWYnUmc43TXwd1KkHkAAcatHffPXTWcvCIXy4SO+ntm2tFBP?=
 =?us-ascii?Q?9/adY67OQ1TwAQXfD0DaFD6OOuMcPfmD40at35DH6MvlT7VlnQN+XmDVcAcF?=
 =?us-ascii?Q?cC/9TCBBypo38hYbJ2II5bpTtBGvBZdWujl4Es535OSzPBSKZPGvIkLh89NP?=
 =?us-ascii?Q?hNvpdyyurND/bCEk1yHRiMpd8cVkQ1D54cFboly0ipMBarxKdSoZmCzSgTZ/?=
 =?us-ascii?Q?xs/dZLSmC0MlbfRC5Sgt5C6PDlsIfYspIvUaKxntU4f6flSrT9Sqph63F1/7?=
 =?us-ascii?Q?/T5lIX0jeA1fg4k+yYXAMB/exllOybI1k8RsmnWv1M4DdnXNLF0ys32AylG6?=
 =?us-ascii?Q?ANN8dSmozWaFM+ZKYUTgK2we6bRaaSFx/I8ubAjCwebXrz/r8Teyi2+s9/33?=
 =?us-ascii?Q?C7u8xceN3TdEfQov0MItowOdgWb7L5pZR6jiqWBsKsriQIXnoYwQhJj8rzZX?=
 =?us-ascii?Q?tBSb801zmlRkkXt/1UAFWTU5JX+6uRlJz2N++s/qXY3vohsLHHVJx4ER4VZm?=
 =?us-ascii?Q?MbTTqxrJ1CGZvjeOx4fTEUL5WYFggo2kA7zIFggiq9sBzUl6NqwlG4n1y62n?=
 =?us-ascii?Q?NXpKgTYItki6qgW1C/6TZiHBbZItauWcJMAOe1UcUTnS353kfABb1aEDcank?=
 =?us-ascii?Q?fOc8Jw3raZTSW53JAo0lHzLPy3Sp4JCPT6tQRuqavP4Vn6n+yH3CmE9F9Pjt?=
 =?us-ascii?Q?Mn/9XOqHYIs0MRGklwT9ui6CECyfEJYAQVZQMxNd4RKb9OMzCZUg3aMv29RF?=
 =?us-ascii?Q?CifknEzKQu6XJ4aTo5pPiRaMmuEXPWC2JDJHWj0td2UXvfRiaNdN7Z6Ix4J9?=
 =?us-ascii?Q?VxBTtG2rT5qzscYJgoTgISsHSLHw5WWErbDo30uC2ZNsVDxpqUbx3WkouLjg?=
 =?us-ascii?Q?pQbotwgPOzaXjk8sO2rvAk0qYRFMSs9iBksIDDqcThs4J1C2k18DAKPDrHPF?=
 =?us-ascii?Q?A1vuLLw/VBgAn8c9aeDRWmnbQR3xCzadv/Gi4jzTtuxNfGp4FiObHNH8uAfZ?=
 =?us-ascii?Q?1NhaI9mlyk6lDpqaiCpTzvmposAJJFokAYhLISEm5QHJg4Z/1of5sGsAZuCT?=
 =?us-ascii?Q?JhlhljmT2Z6x9bbXTOSITn+6pOA8hAObrcUilJED8S7CJIdkBV5tKJbc6LSh?=
 =?us-ascii?Q?I6AFdLcDj1Kc0w8ahDk48OgC8zcAIRK46YBkWL8Pdmlat1skCE+X0zyvYgrd?=
 =?us-ascii?Q?i2VSSNZW9/0DlSup6peBlbXgtqCKugoN7x+N79rfrlwalqe7XoGupHQMadri?=
 =?us-ascii?Q?oNpBNIhS3RlLFdapx08OCfvzr4yvHLC1bji+cgOgqCWk/c0VACGPXVnnOCDr?=
 =?us-ascii?Q?TV2JC4P9RDvOv0Dj8yPBeVfpJc4XgBiR2iZCAfAWHI9LPOs8sjxyf90uNdru?=
 =?us-ascii?Q?kT87Dzi/zYrp5uirD8rixEG2NBb2ycXzXn7s4EUgtQ+hIRyW7nUExUNV8KVK?=
 =?us-ascii?Q?PwSrwaGAck4oxQHsPlv7/AiIvmUZyNkEshu8Yk5l5NJQ/HV8C9OFKU+C1Arh?=
 =?us-ascii?Q?7BKS8mBWbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c68edf9-c87c-442f-8f8e-08de47d7871c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 19:13:34.3428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjSTXezKmm2/VT0DhtWvGkNshqJF9zXb4/kRiGal10zkzL5gApiXucp475xVva6kKvAINiZ4Wukrp/zlwjYIwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
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
> Sent: 30 December 2025 18:24
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241
> CMDQV nodes in DSDT
>=20
> On Tue, Dec 30, 2025 at 10:11:20AM -0800, Nicolin Chen wrote:
> > On Tue, Dec 30, 2025 at 02:13:12AM -0800, Shameer Kolothum wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: 29 December 2025 20:11
> > > > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > > eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> > > > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason
> > > > Gunthorpe <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > > > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant
> > > > Jaju <kjaju@nvidia.com>
> > > > Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise
> > > > Tegra241 CMDQV nodes in DSDT
> > > >
> > > > On Wed, Dec 10, 2025 at 01:37:36PM +0000, Shameer Kolothum wrote:
> > > > > +static int smmuv3_cmdqv_devices(Object *obj, void *opaque) {
> > > > > +    VirtMachineState *vms =3D VIRT_MACHINE(qdev_get_machine());
> > > > > +    GArray *sdev_blob =3D opaque;
> > > > > +    PlatformBusDevice *pbus;
> > > > > +    AcpiSMMUv3Dev sdev;
> > > > > +    SysBusDevice *sbdev;
> > > > > +
> > > > > +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) =
{
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > > > > +    sbdev =3D SYS_BUS_DEVICE(obj);
> > > > > +    sdev.base =3D platform_bus_get_mmio_addr(pbus, sbdev, 1);
> > > > > +    sdev.base +=3D vms->memmap[VIRT_PLATFORM_BUS].base;
> > > > > +    sdev.irq =3D platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQ=
S);
> > > > > +    sdev.irq +=3D vms->irqmap[VIRT_PLATFORM_BUS];
> > > > > +    sdev.irq +=3D ARM_SPI_BASE;
> > > > > +    g_array_append_val(sdev_blob, sdev);
> > > > > +    return 0;
> > > >
> > > > This is pre-building SMMU's IORT nodes right? Maybe a different
> > > > naming? And can be shared with the existing iort_smmuv3_devices?
> > >
> > > Not really, if you are referring about this patch here,
> > >
> https://github.com/NVIDIA/QEMU/commit/cc3b65e6a49a9b7addf44b377d
> 4ef1
> > > de99bfee3f
> >
> > Yes. I am talking about this. But you are actually pre-building an
> > ACPI SMMU device array here. So, my question wasn't accurate..
> >
> > > I didn't find a clean way to store the pre-built smmuv3_devs other
> > > than placing them in struct AcpiBuildTables. It's not clear we gain
> > > much by restructuring things to populate and store them separately.
> > > At best, it might slightly improve boot time, and if that becomes
> > > important we can always add it as an optimization later.
> > >
> > > This patch enumerates SMMUv3 accel instances with CMDQV separately,
> > > uses that information to build the DSDT, and then frees the device ar=
ray.
> >
> > Oh, I missed the g_array_free() in acpi_dsdt_add_tegra241_cmdqv().
> >
> > Let's have a note inline and copy to the commit message too.
> >
> > > > We do so, because we need to link CMDQV's DSDT node to the SMMU's
> > > > IORT node but it is created in build_iort() that is called after
> > > > build_dsdt().
> > >
> > > Hmm..not sure I get that. Does this mean IORT has a link to DSDT? I c=
an't
> find one..
> > > Maybe I missed. Please let me know.
> >
> > The _UID field of the DSDT node links to the Identifier field of an
> > SMMU's IORT node. E.g.
> >
> > [DSDT] // Qemu builds DSDT first
> > CMDQV0 {
> >     _UID =3D 0;
> > }
> >
> > [IORT] // Then builds IORT
> > SMMU0 {
> >     Identifier =3D 0;
> > }
> >
> > If we are sure that the SMMU sequence is fixed every time we rebuild
> > the sdev array so that IORT.Identifier matches with DSDT._UID, we'd be
> > fine. That being said, we should probably make a node inline too.

I see that the IORT node Identifier is used in the kernel SMMUv3 driver
acpi_smmu_dsdt_probe_tegra241_cmdqv() to retrieve the corresponding
ACPI device. This appears to be the relationship you were referring to.

However, I don't think this holds for the current series as is. It will
likely fail if we have SMMUv3 accel devices both with and without
tegra241-cmdqv enabled, since the "identifier" will not match in that
case. I will fix that.

Regarding QEMU keeping the same sequence across both iterations, I
couldn't find any guarantee that object_child_foreach_recursive()
does that. Need to check.

Thanks,
Shameer


