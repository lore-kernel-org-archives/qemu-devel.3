Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB440CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMOm-0006t5-4A; Tue, 04 Nov 2025 14:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGMOf-0006nz-Da; Tue, 04 Nov 2025 14:08:49 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGMOZ-00066a-6P; Tue, 04 Nov 2025 14:08:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7mjuSzfhAHO52v5yC3STT5DZ1bYdmkrsaLW0N17J36YVEgqvRh2NbvOX3MZaVEPJEhC24ZPzMEMsfGrJPOYngbP91DeQrhFy9f0d06zvloA0XeG7yR9+s5e7HfNdHCZ/rwtLFf19odu3aEZtTKKi2cwfglQx+n+znqXBtfth5Jugh5IvsJYW4XoDd6TfHbAU51r4zZG6uT9EEC2Jlr9FVWSCdH8JkTWPVKufiZZVDPqk27fWh/C8BOSKmPd0v5U68LsWk50YwGkUYSnscY7zXsaoEoKL7aWXg3J/Zpq1HJAuUPb3ewgcBFEmYjXt59Lw6Y55dpNaY6grtiny8W5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj8lrUdC9r5QAvNrqXXz5D5/1rVQHYtH0F3X8OPnJOQ=;
 b=D2I2nYSmLUqf9MtnVnYCDF6nhkti6zS0HaHzEt7+6xagGZuGzGRVm9PwQ9/cW1gptEC9B51Z0oP+7NPsqHDjZJ3T+FzytzQYh3SWmpwbBiEWiofESzy8GQxoPcM8j74FjMxI4xdvcoXlY1JArXwbdQnCDVZMPF/HOHZcmCLw6pUhLeurM6Qa2jEPQhuOn6/VQPOQT5vsA56+cCsY54H2lz7a9GflI1mVo3D265mB1EMVT8YPZScbP8O4tobT6uiIY0p9HrXwq6OOVzITMavr8J4Gm5ZeHieLZWNcvdJt8I2yisLzjNoPuqPYW7lTSJd7XkM+RjSw2HSDjf8K0qUopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj8lrUdC9r5QAvNrqXXz5D5/1rVQHYtH0F3X8OPnJOQ=;
 b=Dlmw1MHnDwnLKTKNVjp+sEpq8eaKRyuxiIjbNVIypLLdBhdRSXKKV0vE23xCJv72NoFKkcotEujbQNWxW5PNFgjDC7eFQf66oDmnIiUvlnkAY94FvGu7mXxWY4ksTryXsbrJPxcadT8/uht00mhdmODUGVBkia/8t9Q/un+OMxroCRcjopWrIg1uqmDjgODXIMJYU3tklD/QbZ+zQnqJ9xww9AJjGobAl6/NV4xjhWa/PIzNszqBH866JgkhzcXGmBJiDK985yOaU0pzo3rtgzAqaunM/2fRVcKuMMGGlTBnQDBngKH9jAANho2S6bXdDj8Ecrhxv1LFmrpjtF2wfg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 19:08:32 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 19:08:32 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTik/BQgAAD6QCAAAbV8IAADtmAgAAo4pA=
Date: Tue, 4 Nov 2025 19:08:32 +0000
Message-ID: <CH3PR12MB75486B69E845EB6AAD680C8CABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <3c9e00f5-de9e-4e5c-8312-75eb4fcef81b@redhat.com>
In-Reply-To: <3c9e00f5-de9e-4e5c-8312-75eb4fcef81b@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB8844:EE_
x-ms-office365-filtering-correlation-id: b12464c1-110a-4328-eb13-08de1bd58bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MGRxMzJaM3RadjRzV2pSRUw4L0w4Z1IzdE5jazZ2bDFGTENVSVAwSzFGcEhB?=
 =?utf-8?B?enRBaExwQ2ZoMGx6OGpuMlE1L1RKV1dTOEJZZ0dxdGhtWlI3emswcE5ZTlBO?=
 =?utf-8?B?TFczSXc5bGxvQXNwOVFuYU5nUUljbW9xK1JMRkc5NjMzOWNWUXJaaisxYzNZ?=
 =?utf-8?B?SktKMkJhMFNjcHFZNDNxWExpbVNZWlR5VU9MUXZVQ3B0ajVvSmZ4WmhFQmo4?=
 =?utf-8?B?eDZsbk5CKzBVQTg3NldTcDJyb2RoVmxYNGUzMFowa3pyTHdtSjNxelB4YU93?=
 =?utf-8?B?MUREaDlmOU4ydFpleWRHMmJ1YS9PSEFGdXp0NC92Tjl4N1RvdnE0V25SSUJO?=
 =?utf-8?B?dFp2OTIxWnhheXlHRVpCbkpxNUdCcFo2MERCdEQ1VzAyUkN5TEhxWHRrbWkx?=
 =?utf-8?B?ZEVkdWh6WEJLME5RczhBUStoRWRHbHBxT0NIT0V4eGZUWXhyVWp3SFIrYVor?=
 =?utf-8?B?TVdSTGNuUXV2a3hKemlmamR2Q25tZWlOVHl6RUszcEFISG9JaU4vZkZaRlhK?=
 =?utf-8?B?bXdPUjhHZXNaaW1HSFpMeC84K2k5clUvcUhwaEd5WGF1SVpXM29EWWVUT1Vy?=
 =?utf-8?B?ZWFuRXh3Yk5QZTU1anliZENVS0lVRW9XMGtyTjRsZDZIMGI3dkQzRkI2NDZY?=
 =?utf-8?B?YnhuanpINXZ1Yng2NWpEMHI0M3dkb0RKVlQwWkZrS1paNDlSbE9aWjhURXh0?=
 =?utf-8?B?NTJQWXU4RVc4RDB5empvdUJ5ektPNlFaUUtEcEVvZFRHUldqd2pXaTlUelNY?=
 =?utf-8?B?WUkxdEwxYytBSFRWdEdKWGFkOUxUaGJkeUJwYjNwWS81L3VZNmpCYnZURjR6?=
 =?utf-8?B?bDA3TTNOdCtyMWJxWG0zLzdrV0FOcmFFK2JSM3Z6QVV5MlNxNDlUQktDbndO?=
 =?utf-8?B?cUwzRG51M3JxQzNoN1F0SEd0K2pwcVdTcEhFRDNRVlIvbDFrd0dBVVJkYnZM?=
 =?utf-8?B?NUFMc3NlSGNSWVY2emRjTStaSEhiRW9sQkxwTDVHSzJzc2c5NHp1SjdVLzN0?=
 =?utf-8?B?WWtvd0d1ak96cXp6RWprd2dnY2Y5SVJnM1Y1eW5YcUxsVWRNSEU2eFZiVVZ3?=
 =?utf-8?B?VGxTRnk1Z1g0N2hSZ2J0anpBSE5uTDdSYzg2YUdBb3pNZWxKQkZJdFdPNktx?=
 =?utf-8?B?WElCZlF1Zzg3WWI4VUFGejAxd1VLUHF4OTNJZFNOMGdPVGdKZWRYRy9LTjN4?=
 =?utf-8?B?SnlqbS91d2lyejg3WnBLcllTZU8rejdVMG9BeVFTNENJUDJqMGVNT1l4TG1z?=
 =?utf-8?B?NVFRbHhIS2tQTVhjakV4dU9qWk1qblBPMjZ0V3hsK0Z2ZGlzeS9hTFpxS3V4?=
 =?utf-8?B?UXIrZFc4aFU2SFJrMFhDRy9tYjcrMTN5V1IyeEtGY2tBeWRlbmJHbnJBV3p6?=
 =?utf-8?B?ZzV5SFUrT1k0eGZxUG1NV0d3RVV6eVh0eGJHTGorRDkvRjBjS2NjWnNQRW1z?=
 =?utf-8?B?TmM0RWJFZkZuSHB1SGhXSGlQUUE5anZlR2dGelQ2OUpIekRnNVh6MGVJZUQz?=
 =?utf-8?B?Vm1jUVoySGdsZ2M2ZUJMMEtwZ3ZhRDQ0SDVKY0JYV1JkZ3VrOXhQdkFKOUdU?=
 =?utf-8?B?eFhVdHh0eCtHMlZJMUxOK1NsTGhBQXQ3SzhiRjg5Ym1Gbmc0Y0t3T243Umtj?=
 =?utf-8?B?cGw2T1BRTGIyaHYxZDdPTDJ4S0hJYmhHRDhsM0VJQ2dxemVUVnlGOVFsbDdJ?=
 =?utf-8?B?Z3VnTWpkOXJYd2FpaWJqOTdTcWsveG4zTXg1ZFN6ZWRhSEFpamtTMTZhSlBC?=
 =?utf-8?B?TnU0dFI2Q1hjcmtxYVNESExZalpPTmJ0ZDI1ZnhtTkkrRmhNYU4wUXRGR1ds?=
 =?utf-8?B?UGpCdDR3SFczNUZjYWhvQ0g2OVJEVXhoazB5Z2V2bkE2NklQTHdicFFsZW1Q?=
 =?utf-8?B?dFNwc2k2eXJjdTlwcm81MEs4NDNUYTg1RTZxR3pMSUNNUENmU28yV29KK3Jh?=
 =?utf-8?B?Mkt1WGtPejZIYWpqYkZpeG1PZVZ5WWxyU3hyZGhGbFdxTllLUVNyRXg5YW5j?=
 =?utf-8?B?V0M2OU1BUmNHWFFRUmF1a2J3Z1FFMUtNSmhhZk10ZnJQcTdVNDhUY3UvcEc2?=
 =?utf-8?Q?g/4xvY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUR0eXVOaEVndmRjekhEWkZoR2JFNVc0MjNXK2tkWXJ3RWJvYWE3Rm90azVq?=
 =?utf-8?B?NGp6SWpmbTBLTHM5eTh5bEZ1SjY1VFRJMXJDRXdldVJaYTYrc2FjTnBickdM?=
 =?utf-8?B?OVQvL0FLeTdVdC9XbUlmRWMwSXk5NGhLZ2xxbUNtOVR4YTFjSG5OTnRta081?=
 =?utf-8?B?WGx1bGY2N2JwWjh5OG4vTUpIMm1JOFFFZFFGUjduN1NERFB3MVhVbktxSHVk?=
 =?utf-8?B?cW4rQWZQQUJqT3ArZ0wxVFpJMVlkYkY2bEtFOVZybCtiTUF1bW56cUNUVGhX?=
 =?utf-8?B?Mk1YQVJWd2tpQ2paVVF2M2RFMVpnSEZLeE80RWwzb0dLTW1ORU1Vb3ZJL1RO?=
 =?utf-8?B?cmtoTG02VHRaR2RibVZRN3dXNURkeUFrRjF1MktUb2REWHlSdDVFUGgxUEVV?=
 =?utf-8?B?b240cWY5bHZ4MEdpYzE1bUd5WDd0NEJvMy81d1VBNTM3WmtONDQvK2NzeG9X?=
 =?utf-8?B?Y2wwbWwrN0RjaTdxSi9qS0d2dldEL21FYjdMcGRINzd5ZjZXY1VaaEFPRm1z?=
 =?utf-8?B?VlA4MEs5aHFyek1XTmZ2ZVNDYlJkWnQvRHFaN3dyZWIyaFpVTjFhMlE5SCs2?=
 =?utf-8?B?VGYvN200YXYrb0tiUTg1bFRvdTNla0hkT0g3d1ZaS3JvZS94a0FJdjNmWWRi?=
 =?utf-8?B?SnNpSWl6cWt4ZDNlUldlQ0NuQzF0K3RtT1pCWUJJc2FMcUhSVGtmbzVvNkR0?=
 =?utf-8?B?U1VYUzY5VFpHdHcrdlpWS2d6ckFhZzdGVTloZDJWOWxDQW1BWmtnN3ZZTzY4?=
 =?utf-8?B?WGhxUldQMVNCU0dBemtFNHJmQ2RaMW5aNVZtTlJ5WGpwTnN1TVZFMCtnR01v?=
 =?utf-8?B?YTlZaFN2MXpwL1Eva0Nsd1pvZjVEeHhBZFJWSUkxRnVHNUxLeFlDS0tBMy9H?=
 =?utf-8?B?bW1YY1lDNFdrKzBMb01GTURkN0Fmd1hTc3h6b29kTlFNZkM0ZGtHWDNLWmlX?=
 =?utf-8?B?Vkl1ZGZaeG05cklaTFJHR21OSTJ5VnEzUDU1dXk3NUZxazV4b3VXRjJkMDRG?=
 =?utf-8?B?UEErbGdXTWtZL3NKNVF5V3NGdUZsWmhtc0hxMlMxV3czNS9RZ3BacTJYTjJ5?=
 =?utf-8?B?ZXlLUmtyL096WTlzbnk5czh5bmVlY0RIWlJpVjRXcTd3T29BdjlZcDZuL2sy?=
 =?utf-8?B?ZDVVOWpEcHBBdWZ3b2x4UWxCRStoSFc1Z0JrYWljb21GUk1aSWlqVU9pZFNH?=
 =?utf-8?B?VWR2aEIzam1lNjlRcnd6cDh3bGZ0U2ZjQisxdzBvRXpDR01kUTlucnl3ZFph?=
 =?utf-8?B?Tlpnemd1dVdNS0p3ZnRZd21XNzJIMGtkdVhGS2hCODcrRGo2djhPZGE1QytY?=
 =?utf-8?B?ZC8vM0d6NmZZTXlvVVNkM0ZvajFXM0pDRWc2VVFzeGg3Nm4zMkdnN1FrTmZp?=
 =?utf-8?B?ZDJBc3RZbVFqZnBDNEt2TWpOTFlONmh4Sy95UHUvV2RmM1JtT1FjZngveVpR?=
 =?utf-8?B?UCs0N3gvMG5KYlhBb3lib3JqNHk3VGtPcWE0RG03RHVUK1NoZTJzTmlkMVpK?=
 =?utf-8?B?OFduc3FJL1BnSHFjOTN5dzhZbk9jWHlWbHVkWktweXFMRHJuc29mWWpFeE1O?=
 =?utf-8?B?cWswMnE5R3hCWkRuN3MxMmplZGFSUXRrNG9FdFlqenZDQWVBQ1p3NXlKUlcr?=
 =?utf-8?B?MUczVC9oMk1lcDdNTnBIcFZIU3hhTmtDY3A4cEs0bmNIQklXMXZ4Q1Z1NTVj?=
 =?utf-8?B?bTRkbHc2OFE2OW9EOHNjTGsyYzMwNCtQT1FtdnprMkwxSG5nbnRraE5mOEpI?=
 =?utf-8?B?THhzbS9COXlrdHdvR3lXeUt6M2lIV2R6SE1xV3dZNHZmR0NSS3ZQV1RWSXNU?=
 =?utf-8?B?QnVhZDFFeENFWGROYk5qWmVUS0pFa0hhSEFhbzZYQzk3Y2ZkdnJ3K0ZYblJn?=
 =?utf-8?B?MldUWHo0VHBQZUNKbWFqei9IZldPU0J2Ym1xNjd5YUN4OUZoZjJmMkNEWnRE?=
 =?utf-8?B?SGVOdGFmRUdRdkhRclZEMTFUYjVUNkoxVnovSGlya2tJQWZiRmkyOXp3bVBz?=
 =?utf-8?B?ckY4VmVsTEFidk9wcndadk1yMjlTcjFQTDFPVTVoYkxQWVZaL0N3WFpHMnJl?=
 =?utf-8?B?WXU1S0U0QXU1VTdINS8zdTZpMzFIaWJWYVdrQmtHRnVJTkQxVHptWW1XRVZD?=
 =?utf-8?Q?DUHPIhdpq/hdr8k4s1pyUiZmc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12464c1-110a-4328-eb13-08de1bd58bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 19:08:32.1363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3li1AmAR5+zy6xA56M3kzEMy9Pn5P/wU587ZXCGbYA5nvUmbTGLS/Rwuu7m28PQWUBiA1hM3wbOaIts3gvmGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNCBOb3ZlbWJlciAyMDI1IDE2OjAyDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBo
aXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9u
QGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gS3Jpc2huYWthbnQgSmFqdSA8a2phanVA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNS8zMl0gaHcvcGNpL3BjaTog
SW50cm9kdWNlIG9wdGlvbmFsDQo+IGdldF9tc2lfYWRkcmVzc19zcGFjZSgpIGNhbGxiYWNrDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IE9uIDExLzQvMjUgNDoxNCBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90
ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IDA0IE5vdmVtYmVyIDIw
MjUgMTQ6NDQNCj4gPj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEu
Y29tPjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7DQo+ID4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0KPiA+PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpn
Z0BudmlkaWEuY29tPjsNCj4gPj4gTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsg
ZGR1dGlsZUByZWRoYXQuY29tOw0KPiA+PiBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hl
biA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+ID4+IDxtb2Noc0BudmlkaWEuY29t
Pjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+ID4+IGpp
YW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gPj4g
emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsNCj4gPj4g
eWkubC5saXVAaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0K
PiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDE1LzMyXSBody9wY2kvcGNpOiBJbnRyb2R1Y2Ug
b3B0aW9uYWwNCj4gPj4gZ2V0X21zaV9hZGRyZXNzX3NwYWNlKCkgY2FsbGJhY2sNCj4gPj4NCj4g
Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gPj4NCj4gPj4NCj4gPj4gT24gMTEvNC8yNSAzOjM3IFBNLCBTaGFtZWVyIEtvbG90aHVt
IHdyb3RlOg0KPiA+Pj4gSGkgRXJpYywNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+
DQo+ID4+Pj4gU2VudDogMDQgTm92ZW1iZXIgMjAyNSAxNDoxMg0KPiA+Pj4+IFRvOiBTaGFtZWVy
IEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+ID4+Pj4gYXJtQG5v
bmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+Pj4+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiA+Pj4+IE5p
Y29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsNCj4g
Pj4+PiBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29t
PjsgTWF0dA0KPiBPY2hzDQo+ID4+Pj4gPG1vY2hzQG52aWRpYS5jb20+OyBzbW9zdGFmYUBnb29n
bGUuY29tOw0KPiB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gPj4+PiBqaWFuZ2t1bmt1bkBo
dWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+ID4+Pj4gemhhbmdmZWku
Z2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsNCj4gPj4+PiB5aS5sLmxp
dUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+ID4+Pj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNS8zMl0gaHcvcGNpL3BjaTogSW50cm9kdWNlIG9wdGlv
bmFsDQo+ID4+Pj4gZ2V0X21zaV9hZGRyZXNzX3NwYWNlKCkgY2FsbGJhY2sNCj4gPj4+Pg0KPiA+
Pj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1l
bnRzDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IEhpIFNoYW1lZXIsIE5pY29saW4sDQo+ID4+Pj4N
Cj4gPj4+PiBPbiAxMC8zMS8yNSAxMTo0OSBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4g
Pj4+Pj4gT24gQVJNLCBkZXZpY2VzIGJlaGluZCBhbiBJT01NVSBoYXZlIHRoZWlyIE1TSSBkb29y
YmVsbCBhZGRyZXNzZXMNCj4gPj4+Pj4gdHJhbnNsYXRlZCBieSB0aGUgSU9NTVUuIEluIG5lc3Rl
ZCBtb2RlLCB0aGlzIHRyYW5zbGF0aW9uIGhhcHBlbnMNCj4gPj4+Pj4gaW4gdHdvIHN0YWdlcyAo
Z0lPVkEg4oaSIGdQQSDihpIgSVRTIHBhZ2UpLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJbiBhY2NlbGVy
YXRlZCBTTU1VdjMgbW9kZSwgYm90aCBzdGFnZXMgYXJlIGhhbmRsZWQgYnkgaGFyZHdhcmUsDQo+
ID4+Pj4+IHNvDQo+ID4+Pj4+IGdldF9hZGRyZXNzX3NwYWNlKCkgcmV0dXJucyB0aGUgc3lzdGVt
IGFkZHJlc3Mgc3BhY2Ugc28gdGhhdCBWRklPDQo+ID4+Pj4+IGNhbiBzZXR1cCBzdGFnZS0yIG1h
cHBpbmdzIGZvciBzeXN0ZW0gYWRkcmVzcyBzcGFjZS4NCj4gPj4+PiBTb3JyeSBidXQgSSBzdGls
bCBkb24ndCBjYXRjaCB0aGUgYWJvdmUuIENhbiB5b3UgZXhwbGFpbiAobW9zdA0KPiA+Pj4+IHBy
b2JhYmx5DQo+ID4+Pj4gYWdhaW4pIHdoeSB0aGlzIGlzIGEgcmVxdWlyZW1lbnQgdG8gcmV0dXJu
IHRoZSBzeXN0ZW0gYXMgc28gdGhhdA0KPiA+Pj4+IFZGSU8gY2FuIHNldHVwIHN0YWdlLTIgbWFw
cGluZ3MgZm9yIHN5c3RlbSBhZGRyZXNzIHNwYWNlLiBJIGFtDQo+ID4+Pj4gc29ycnkgZm9yIGlu
c2lzdGluZyAoYXQgdGhlIHJpc2sgb2YgYmVpbmcgc3R1YmJvcm4gb3IgZHVtYikgYnV0IEkNCj4g
Pj4+PiBmYWlsIHRvIHVuZGVyc3RhbmQgdGhlIHJlcXVpcmVtZW50LiBBcyBmYXIgYXMgSSByZW1l
bWJlciB0aGUgd2F5IEkNCj4gPj4+PiBpbnRlZ3JhdGVkIGl0IGF0IHRoZSBvbGQgdGltZXMgZGlk
IG5vdCByZXF1aXJlIHRoYXQgY2hhbmdlOg0KPiA+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIxMDQxMTEyMDkxMi4xNTc3MC0xLQ0KPiA+Pj4+IGVyaWMuYXVnZXJAcmVkaGF0LmNv
bS8NCj4gPj4+PiBJIHVzZWQgYSB2ZmlvX3ByZXJlZ19saXN0ZW5lciB0byBmb3JjZSB0aGUgUzIg
bWFwcGluZy4NCj4gPj4+IFllcyBJIHJlbWVtYmVyIHRoYXQuDQo+ID4+Pg0KPiA+Pj4+IFdoYXQg
aGFzIGNoYW5nZWQgdGhhdCBmb3JjZXMgdXMgbm93IHRvIGhhdmUgdGhpcyBneW0NCj4gPj4+IFRo
aXMgYXBwcm9hY2ggYWNoaWV2ZXMgdGhlIHNhbWUgb3V0Y29tZSwgYnV0IHRocm91Z2ggYSBkaWZm
ZXJlbnQNCj4gPj4+IG1lY2hhbmlzbS4gUmV0dXJuaW5nIHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFj
ZSBoZXJlIGVuc3VyZXMgdGhhdCBWRklPDQo+ID4+PiBzZXRzIHVwIHRoZSBTdGFnZS0yIG1hcHBp
bmdzIGZvciBkZXZpY2VzIGJlaGluZCB0aGUgYWNjZWxlcmF0ZWQNCj4gPj4+IFNNTVV2My4NCj4g
Pj4+DQo+ID4+PiBJIHRoaW5rLCB0aGlzIG1ha2VzIHNlbnNlIGJlY2F1c2UsIGluIHRoZSBhY2Nl
bGVyYXRlZCBjYXNlLCB0aGUNCj4gPj4+IGRldmljZSBpcyBubyBsb25nZXIgbWFuYWdlZCBieSBR
RU1V4oCZcyBTTU1VdjMgbW9kZWwuIFRoZQ0KPiA+PiBPbiB0aGUgb3RoZXIgaGFuZCwgYXMgd2Ug
ZGlzY3Vzc2VkIG9uIHY0IGJ5IHJldHVybmluZyBzeXN0ZW0gYXMgeW91DQo+ID4+IHByZXRlbmQg
dGhlcmUgaXMgbm8gdHJhbnNsYXRpb24gaW4gcGxhY2Ugd2hpY2ggaXMgbm90IHRydWUuIE5vdyB3
ZQ0KPiA+PiB1c2UgYW4gYWxpYXMgZm9yIGl0IGJ1dCBpdCBoYXMgbm90IHJlYWxseSByZW1vdmVk
IGl0cyB1c2FnZS4gQWxzbyBpdA0KPiA+PiBmb3JjZXMgdXNlIHRvIGhhY2sgYXJvdW5kIHRoZSBN
U0kgbWFwcGluZyBhbmQgaW50cm9kdWNlIG5ldw0KPiBQQ0lJT01NVU9wcy4NCj4gPj4gSGF2ZQ0K
PiA+PiB5b3UgYXNzZXNzZWQgdGhlIGZlYXNhYmlsaXR5IG9mIHVzaW5nIHZmaW9fcHJlcmVnX2xp
c3RlbmVyIHRvIGZvcmNlDQo+ID4+IHRoZQ0KPiA+PiBTMiBtYXBwaW5nLiBJcyBpdCBzaW1wbHkg
bm90IHJlbGV2YW50IGFueW1vcmUgb3IgY291bGQgaXQgYmUgdXNlZA0KPiA+PiBhbHNvIHdpdGgg
dGhlIGlvbW11ZmQgYmUgaW50ZWdyYXRpb24/IEVyaWMNCj4gPiBJSVVDLCB0aGUgcHJlcmVnX2xp
c3RlbmVyIG1lY2hhbmlzbSBqdXN0IGVuYWJsZXMgdXMgdG8gc2V0dXAgdGhlIHMyDQo+ID4gbWFw
cGluZ3MuIEZvciBNU0ksIEluIHlvdXIgdmVyc2lvbiwgSSBzZWUgdGhhdCBzbW11X2ZpbmRfYWRk
X2FzKCkNCj4gPiBhbHdheXMgcmV0dXJucyBJT01NVSBhcy4gSG93IGlzIHRoYXQgc3VwcG9zZWQg
dG8gd29yayBpZiB0aGUgR3Vlc3QgaGFzDQo+ID4gczEgYnlwYXNzIG1vZGUgU1RFIGZvciB0aGUg
ZGV2aWNlPw0KPiANCj4gSSBuZWVkIHRvIGRlbHZlIGludG8gaXQgYWdhaW4gYXMgSSBmb3Jnb3Qg
dGhlIGRldGFpbHMuIFdpbGwgY29tZSBiYWNrIHRvIHlvdSAuLi4NCg0KSSB0aGluayB0aGUgQllQ
QVNTIGNhc2Ugd2lsbCB3b3JrIGFueXdheSBhcyBpbiBzbW11djNfdHJhbnNsYXRlKCkgZm4gDQp3
ZSBhcmUgY2hlY2tpbmcgdGhlIHN0ZSBjb25maWcgKFNNTVVfVFJBTlNfQllQQVNTKSBhbmQgaXQg
d2lsbCBqdXN0DQpyZXR1cm4gdGhlIHNhbWUgYWRkcmVzcyBiYWNrLg0KDQpTbyB3ZSBjYW4gZG8g
dGhlIHNhbWUgaGVyZSBpbiBnZXRfbXNpX2FkZHJlc3Nfc3BhY2UoKSBhbmQgcmV0dXJuDQpJT01N
VSBhcyBhbHdheXMuIEFuZCB0aGF0IGNvbXBsZXRlbHkgYXZvaWRzICZhZGRyZXNzX3NwYWNlX21l
bW9yeQ0KZnJvbSBTTU1VdjMtYWNjZWwgaWYgdGhhdOKAmXMgdGhlIGNvbmNlcm4uDQoNClRoYW5r
cywNClNoYW1lZXINCg0KDQoNCg0KDQo=

