Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5AECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIUp-0008DE-4d; Tue, 04 Nov 2025 09:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIUn-0008CZ-AD; Tue, 04 Nov 2025 09:58:53 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIUl-0007cZ-8x; Tue, 04 Nov 2025 09:58:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faEtf3r8G9/o6JhIA8oiIqMBy70knUUUrr6qSuFlkEGBVnNCo8XMHc/hVpLXl6YFBJ3C5KMYixruHNvDSqBIQicYrqtkQOMAkaaH3DbF88KXUcaygfTXQV11IWrwtFN9qKeH4Kb8Mu7ufr6uKBaHOPPSMhd15mYQo6kQ9lNRumygzY/rkKJSgIOUZuFsjbb/u0rxjzTUnVaeBtWQMrP9XPRuZA7YUH8w/waf+LHPusYNEK3/3eZd99nVNaq0/y5EH9vaZLS8tZKJeHx1P1zuxtzgkj9gFSr9pS/93AAe12LeqHC/lqM3tUq/m84CDD3nFGRQU39XkXPhMulFvfAC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6wu5yIVE+EvrofqoFkkQ/1UWIAyXwTkgSDCb4zwd0Q=;
 b=H51hoCrkn9BpmIpgFTjxFZWFS+52Z24QvGCcPLHWF/ZSmXV14ZtZVaYa2kWxjnsbzZ00BwflUfFF5OD9WLyRlz7L5HteYEd/dz02THiVPNbfuXhcflC+Uk9QFnDzRbNyL5k9qYPZs7UeR4MJgPeNxpjxb/Zh+yIYHse9IyI3hrsTQbixfeGFID0QdYsy/eOeM2Ass8g1D4WGGcN91uyH3uKS4pIaNWpFBppfOfzgQ5F7ziN9hzC2zVXG+a5/t0Oof9h+496XtgP4M6MxfsxfhEKEXTt/N/Y6boes9me1JFOBVE35KAJrRQ2s7ePGjAtDWYTvy3Sf31SG6ff18bm16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6wu5yIVE+EvrofqoFkkQ/1UWIAyXwTkgSDCb4zwd0Q=;
 b=EPrsj2FGzzpxQDUAtBnZ6UIGB8N6Z7lPGRZCMCI72OhSBPLfPtDwGYrlGRefUEha5dYo0CClPcKekFOYSpxeIFwrlFyrD1VYamZ5S6Rar/Yd2wCZgQ3KMpmn8MA/GSgoH/sHSU2J7D52HWwXhORE2Kv5LxZRbNTqzYNiZW6J5XtSnrJ2BsSg9xMEIJVNzA6hHipsrC22cThO2P0XxGsarCx8MebCcOm9z+rXnqeeEw6AIrgmw712OjlfnoblpCHjzlRLLzM/LTdTqTyKzR/dHe+yFJRYO0UzIttIsvupV10zIVVAlud/MEW7kQgoqyD1MNcfdI5bIbOWsBNTn2B3Ew==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Tue, 4 Nov
 2025 14:58:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:58:44 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTikUkAgAAEzmCAAAPhgIAAAELQ
Date: Tue, 4 Nov 2025 14:58:44 +0000
Message-ID: <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
In-Reply-To: <20251104145157.GF1537560@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB7306:EE_
x-ms-office365-filtering-correlation-id: c799dedf-a317-41de-ffd4-08de1bb2a651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5lJlsoq6ZcIxcR0afcX3H4pMoIP+5h+LpaBDgB+VT2MJ0F0teASbm/c0a4gZ?=
 =?us-ascii?Q?GCcmRAT/JCbxd7QbfZhejJcIv8/NNSwDrXIDh9FltQQ6+deRBzV3xHTwr+Ld?=
 =?us-ascii?Q?kDWbikeZswnkbqql9czamRwJvc/rtw2EZHmDozPtkOmmLCe2o+MPowhcsqRs?=
 =?us-ascii?Q?5IFclhqcVxPTg2JL1pOSNmODDVx+82yihbDGIT/9xCzZyL4tLBxrqT+N6D0G?=
 =?us-ascii?Q?mmw8XNeXP7eMYx2mzb5tUTewTKwxTMj89U6CJRqTvkU1srDXv7BPGgE0YAoa?=
 =?us-ascii?Q?dRYvF9kxexIclmTiBfJOSmjAXKuu8//tiXRcFMenUdBdogT+rPSYr3rbF2vB?=
 =?us-ascii?Q?Mhg/BX3ze/LHbJdcz3qY9V8PSE4Rb9igbFBtNhSeaP4HVnzKOFLZj9HYCwjc?=
 =?us-ascii?Q?1Jz/cbdv816zbf+qqUIdB3i58LEWwTttlpDnhLwZcTwbdJE1DEkoTdByoT0K?=
 =?us-ascii?Q?9CuWLxJP3TtyLAkRP30eXweiYEX72MP9/0vsGkjJRxV+4RWp4UOdSODbrVrk?=
 =?us-ascii?Q?a00XykpybsLAqpK+qAaTCAaeDhhRuO08pY/PCcTOZeDF4B/DnyVVWNSvMK4o?=
 =?us-ascii?Q?091X5Z0s6C9sfK+AQuCLHRLvQoZwDxNOBp71+w6I6VQn4iMDJGuxoI+lQI0F?=
 =?us-ascii?Q?elkghklwQQ29PII4ljN8z+NbkL2kdd7Phq8QAJJRw7K3XkzcF/ANN+H9qGBT?=
 =?us-ascii?Q?8Xhrgjoql1asbLI9O2/OEA7ZqmSzbQkKmbx7j2OAazvn0wvJ/RWbPiWOn920?=
 =?us-ascii?Q?I1trWeb919Q2jTUSuxZ2zN1CV/tf9CfFizzYrqeIzRt6kJNsdveBW01F2SjI?=
 =?us-ascii?Q?JRcP0lxlZdJbH4BTAMw5yNyRpe6prwcIa8ml5zfIxqqUtpBwm+TU5VBXCNkg?=
 =?us-ascii?Q?eRlppezQdKSmkCrJLkFXZEO29Pu9e+cjAENGHiXRoxxSukmCioLuqeX+HNcp?=
 =?us-ascii?Q?9pgYkWXvoj3JdLX/BTPNJ3g60uyece67yDI5cwgi3yRq6RLR7kO8U7I3ll2n?=
 =?us-ascii?Q?eSjsC3JyNkq98gTr8OFdxW9FeqmC/4gKL4EnU6Kbtzd+vIywUEGYTormNZMY?=
 =?us-ascii?Q?7yxDa/368PNtrfeqr3wnoDjKGRb6fL+TaTbMXXjRVapBFMpVYyRKxOw1nr6S?=
 =?us-ascii?Q?7RG76plQcuMPLFWPhrCcE/7TQDo1giVwUVOHWkTksQcl+03cpcE2ozH2eQ1+?=
 =?us-ascii?Q?UcBfH2TdzM/O1ajVUIw4qDjby6i80SOxfMPyMxzPuf6iHPBVc5zcEMwG0+/h?=
 =?us-ascii?Q?0cVPU6I2unzulmueTR/LYC9KmI+IcBl2SpBjiZso/2W/youKJoP98CKoMCL5?=
 =?us-ascii?Q?yaGyeQztRIj6Oeu7H5OJoe759iE9Ix9ortlOZJe5dNnSaNlzHqieHor3zAdc?=
 =?us-ascii?Q?nnC/6w4bI4fDuTEcr/D03FwuZQFEgZ2Q1+pgcmkg+RW7b9g397W/BaTCijhD?=
 =?us-ascii?Q?GIHuEndozDpFkHwpu8TZM8on8vjl1hZpBGbXgBp6+kSgAF9ehtedvysFLfM1?=
 =?us-ascii?Q?A7WBOyhFC3o1PRsCoYUuK30Ui3IKTCsEKJf2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a4gPNz193w9g+tUYPBxEEYMC6zF10ix8n9mQBUfie13gdSUrs9f0UPFORFOR?=
 =?us-ascii?Q?D1uHSoJj2Fl74DGes0YtSErXz375ixCb+tra71raipOkD79zltAI2PnZMz6a?=
 =?us-ascii?Q?bOYdjza0lMxidM7e8Rm5qyNLv21a8+4WPT+SnCNzfC9xM09pbjMqfd65Gx07?=
 =?us-ascii?Q?5Zuw/3YtXXmvGlig2RHU9PTu/dXmbyvwF3hiArVpPt/WuLSo/nV3utc373YB?=
 =?us-ascii?Q?3fBihwdF9WCSXoP9flp6eTQRluV4tC82uXSbIgBS9rG7tUEc3nuC1jdBrK8+?=
 =?us-ascii?Q?TyQz0GnOj/GczGmSIA978aM3Jy61aXTmLAwub5NEDHnGq3uflHv4pXH5y5oy?=
 =?us-ascii?Q?Oq3MXE2NDplsrpGJYpEo9zJImi0c0JzoH/tDHo+0riXugOWZ8u9fCD8CNFzB?=
 =?us-ascii?Q?mY61zgreqYdeKxAk5RQgyAjcMIrhqh6K2ncvgvqoCJpJynkf2cSyYVSzIVgZ?=
 =?us-ascii?Q?Y0vhxK29NaMd4ikG9WbzjPd5R6/O4JD91qILf8uxYnhqJND1ZijG29HLqK7n?=
 =?us-ascii?Q?VXNpX6SFMcooQWrO7Zxj7L+A5q2OJCtk2fhAeofpdLEtgPDjEbgdDEwCu2fQ?=
 =?us-ascii?Q?9QpfekXJqOl03SDGLL/fRpxw10E0iKDC/fyfzJT6BKUHuZxxYSLHBNQhI3Yu?=
 =?us-ascii?Q?QbWdjES/nlOPdJ1yN4D26gHgGSZrTHsc3mh8L2ieV4wDdqDrRFxzIamLYU7y?=
 =?us-ascii?Q?XS9dRABfdafeUUjQZBzZWNzSRExelkHiAzjxxG45rCkoXSigaE+6/TGmOZJj?=
 =?us-ascii?Q?l7gbeYce+t4PbrpvgbRgWqsV5agDkz950QBJQvPWgrskKN77JyBoZ3UMXyY0?=
 =?us-ascii?Q?2fwkJLS7VL2zqNcOqBm0YP82i4jXvMwd62zmBLkiIDIAZcRBZUuKdA4noToP?=
 =?us-ascii?Q?/+HuO7qfEctPtGlI/6uiWiFkYiqPyScLRRj7vVfMC5YbjP/SCt3yByegZ0Ph?=
 =?us-ascii?Q?JyJEtcvXZRrG+M7Z+3lz2AFjr5HZDXf2PfGSFhxoB+ycjVb9Dq7SW4SkyZ8L?=
 =?us-ascii?Q?H381wzxlxsOkqOyDwyh15W/wLzRiU1MSoaHxYgnwOiuO40t5m4KlNEWZGq0I?=
 =?us-ascii?Q?RQTOxxc4tfLTLP9jYfdN6vullWf6V725tcLJ5kKWMFSY5qASZGHT7dxO4LKY?=
 =?us-ascii?Q?nH8VkHhBYguOiQmEZfVXSvoh/6PTDdJAWerUETwT/NPdn3YDaArdwrU3BMQ9?=
 =?us-ascii?Q?ZMZXhSP1YQ/8bDqOBE9UIHWXDhQcW4m00ZmBLO4gSWDF1gM3zc3qx2cWeWui?=
 =?us-ascii?Q?+JPTDhFoj1hQpSYEG4n9DozgwZxy5TGDQt9xKqp1ap5YpuBZSd/KwzhKw2b4?=
 =?us-ascii?Q?e/HoKecXoShSNfTRAqqgrT1UJOrgNE2W4ktXADKrC4MYAB63iZhJPctfriCj?=
 =?us-ascii?Q?p4U2GptueJLhe3t/mAGA3OKIzcLfbkHql585os/dy07dza0a2hSSoImxirUI?=
 =?us-ascii?Q?anRebgd4WLTA8f3nASPW5pvrTuSdyHO2zvdi7IIVvb/FX9PDMvm2r9MoLnRh?=
 =?us-ascii?Q?kOJZMadK3E/TWZKve9HWQzx/ZI0Acx+5Q/DclJo8XyAYQRKWkAYYkY3lkGKk?=
 =?us-ascii?Q?xukc3JW6J3HjN857B+u3HBktg3fBuJ9+C3fsItPQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c799dedf-a317-41de-ffd4-08de1bb2a651
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:58:44.1635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHxD/8gL1QeeAJVKCkpDz2ECYxLBj3zvllTe/87QS6Mnlb79BVETbCF8jpEd8OU+0x1jmGvh2ZMLQRMOTPOPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 04 November 2025 14:52
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Eric Auger <eric.auger@redhat.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
> get_msi_address_space() callback
>=20
> On Tue, Nov 04, 2025 at 02:42:57PM +0000, Shameer Kolothum wrote:
> > > On Tue, Nov 04, 2025 at 03:11:55PM +0100, Eric Auger wrote:
> > > > > However, QEMU/KVM also calls this callback when resolving
> > > > > MSI doorbells:
> > > > >
> > > > >   kvm_irqchip_add_msi_route()
> > > > >     kvm_arch_fixup_msi_route()
> > > > >       pci_device_iommu_address_space()
> > > > >         get_address_space()
> > > > >
> > > > > VFIO device in the guest with a SMMUv3 is programmed with a gIOVA
> for
> > > > > MSI doorbell. This gIOVA can't be used to setup the MSI doorbell
> > > > > directly. This needs to be translated to vITS gPA. In order to do=
 the
> > > > > doorbell transalation it needs IOMMU address space.
> > >
> > > Why does qemu do anything with the msi address? It is opaque and qemu
> > > cannot determine anything meaningful from it. I expect it to ignore i=
t?
> >
> > I am afraid not. Guest MSI table write gets trapped and it then configu=
res the
> > doorbell( this is where this patch comes handy) and sets up the KVM
> > routing etc.
>=20
> Sure it is trapped, but nothing should be looking at the MSI address
> from the guest, it is meaningless and wrong information. Just ignore
> it.

Hmm.. we need to setup the doorbell address correctly. If we don't do
the translation here, it will use the Guest IOVA address. Remember,
we are using the IORT RMR identity mapping to get MSI working.

See this discussion here,

https://lore.kernel.org/qemu-devel/CH3PR12MB754810AE8D308630041F9AFEABF2A@C=
H3PR12MB7548.namprd12.prod.outlook.com/

Thanks,
Shameer

