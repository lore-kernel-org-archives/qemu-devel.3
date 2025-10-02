Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7644CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Feo-0005tX-T9; Thu, 02 Oct 2025 05:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4Fef-0005pJ-9Y; Thu, 02 Oct 2025 05:31:17 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4FeW-0001o7-Os; Thu, 02 Oct 2025 05:31:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRRlq2+pauEUz2Jnp7aF3ggbITtivUHkOn7uaUVKJ1uWGr2gZ4Jw9jhGAhd3NOYd4oi1N4z8OPSNDsWJEV5g8/phl4wDhJMvAo6ULDibgNOl/ROE6tnyjhOq4+N4sT5FxfRzczRsCsQr79oyAx8NzJ9yOjY7Vo5AjvJkEIJ0cChOmUWexBriXSz0UxLHWOTDa2DYCmAW0goPcRkTWnE7Eshj8lpJC0Z8uwp8SrsFKWdZxbm9GZZUZf8FebMBcTjf+wzEpjMhDwsOIV53J7PhkB9CBZti5perlxFh2qDmHnN9KSf0EXDufY4iV82ZWvNs6tHPoVJMNfxed5sGswHBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTe/D2yNgi01Xh5MnDTrbvvskWJFNdgDbYMfYhsOpGQ=;
 b=n2tz29PXmFLY9Y8oqSCReyj2OSiCvYdYzmBTYznxCtKL7vQqS0lI2NEmyGa7F7xEdms7dyfGOzSnHegaVV7nWSprTd84YsGub1sHBUFYd+mvvX7I4MyFDN32g24RqVCcKxJSr0BWwDK+ndKAt7Ff1XsCEwl8xVBZJrxc2d9bF7kUl/+LDyuhAcmzFYni7eJkD5MCi8CYjUq6c2OPkCT7XSqzuI3sEcV6DYoMaOObR5+Yrhfhzq97vumOdHD2XsBRRZrpJaK7uQr7QaxG4nnlRCFR7OjsC7GmBIl0/lgGxeht5mCZcFPPNXFrRLOiWP665cEZT4w+A4Bqq2t41UXKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTe/D2yNgi01Xh5MnDTrbvvskWJFNdgDbYMfYhsOpGQ=;
 b=Aq2TWJ5E8GpBJyz6QpW3roJhFxrE99L+YlXdlutV09UyuHyzVqCr93F+ChJtrDRDW4LNDI5CLDz7h4+Q1SyyZ+bSYrupXq8GZxTBbzAyYM3RzLmnlHRTxxK7HWqnCUP4SXgaO3chIDDTR130NGwnzufYCnwDfbRO2dj1sHWJqbM08FxCQQAvAGQa4F7XUjeRBMiGZVGlvmK5qLweq0t5qLiVnPqkw6WhTujosFrFaABUk2QBBmDzpu++gomPUp3hyszZ+VWsoYZlvZeLNfGTk/SszP51Upd9BNwGVvCHhohzxAEHiKf3eqDSHUplEI3OojU3ka1KiD1hUqNxU0XohQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Thu, 2 Oct
 2025 09:30:42 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 09:30:41 +0000
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
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Thread-Topic: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcMvlSHNFvMFbT2kCFLixXDfUlObSuhAjg
Date: Thu, 2 Oct 2025 09:30:41 +0000
Message-ID: <CH3PR12MB754822A08B7D9D7317DBECD8ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <cba0a4c0-9d0c-4137-ae0a-7460da56ac56@redhat.com>
In-Reply-To: <cba0a4c0-9d0c-4137-ae0a-7460da56ac56@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB6342:EE_
x-ms-office365-filtering-correlation-id: 7fd3e650-6e04-41de-9203-08de01965af6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Zi9ZaUhrSDhPbWdNN0RvRXNHM1BQRHlQNjdWZHlVS1VpWDVSQTI1VHJCUm1E?=
 =?utf-8?B?WDhJMnJ5a2tpMkdBMFBxNld4RXRJVy9aQlZPTmFCeVF1WFhGNFNROExOVTlD?=
 =?utf-8?B?VFZ6bGlYOTJiSUp4TWJTVHdlZSt1NGp4ZTllMHMxWW5aRXY0QjdnL3RvQXB4?=
 =?utf-8?B?cmhLZWVZYkQ0RGtDbFYrMXhhNWF4WkFRNE56dnZzUFdTYkx4Z1NtY3M4Tk5l?=
 =?utf-8?B?MFVCZDRJSHZmNHlRZ1hwV096c1l5eVN3NS9ReElNSkVoZmd2Mk0wL3hWaCtt?=
 =?utf-8?B?UmxqNURyRjZmeHpFVG5iSGJubEltODRHK084akc2aUo2QVdrcWpmOFRmejhW?=
 =?utf-8?B?azBmbkJ5bTRHb1VMaUswWTgxK2dGUGFDZWx2am1pQUlMWmFmR05jLzVTOXd5?=
 =?utf-8?B?SndIYjhFVGE3N0Y0dDRkRlJ3dmkzcTlLUXZhRHdZVmRBUU9FQzVRNWpzYThr?=
 =?utf-8?B?UHBkd1lVV0FMRGNSZ0J1U1hWTER3bVVGZEo0ZGRyZ2lxUERlUEV4TThNM1Jx?=
 =?utf-8?B?ZUsyNEVVc0gyeXF2Tnk3NXFZbWFrTXN2QUl0YlFVdzYwVVRPUUxoUTFTelFK?=
 =?utf-8?B?RS9XM3N3Q3JlMkR4czlpTVlTRnlZNjdTdHNTbmtleHpjOVlJZ2hSOUgwUWpp?=
 =?utf-8?B?TEhHR0VVaHRFZ1Rpd1ZPMWpLZmxTejlIUUVGNTh6cWdoS0FQY0lFSGRXUjBB?=
 =?utf-8?B?d0tld1ExdGVNOXMwQzlkalBQQXFKckhrZU5kNXczMkkxbDBLTkRGdVFHZ2cz?=
 =?utf-8?B?L1JISXYyTG4zSjBueGtkZ2U2ZUltY3VuWHRxN01Ob1hjc0ZSRTNrd3JQK2Mx?=
 =?utf-8?B?dzcwUVNkc3hVK0hUVkJxMDdvU3UzK0tVU2VibzVhWHZ0UnpnQVE2dExnV1Zi?=
 =?utf-8?B?ZjJKWXlCTGorclNZcFhZQlJEdEJvVE0yaUJ5NXl5Z0NSSVlXbS9ZazFPVDJt?=
 =?utf-8?B?Y3U1aTJYQWRVRjFydnBLc3dRM25yN2RoQU5ibXFsbUg3K1dZdXZOZWZGYWov?=
 =?utf-8?B?enU5Z2JOV3R1MDR0ZUNzUTBaa1BSQkxReFh2dWM0QTVqZlI2ZWI4LzJ1YjNu?=
 =?utf-8?B?WUIzQTQxOTZiYW81MjVBMDdZY3lrdDdWbDlrNTVJd3UyWHA5cFRaVGVVUUhp?=
 =?utf-8?B?S09rVkw3SUQzNzc0WVhScXQ4cWhLQStmejhPMS81aWZUUG9CSVc5MnRsbWhX?=
 =?utf-8?B?bENHdTc2YkdKbVRqbHgxc0M2QWNMWkhITEFXb055cDN2SnZWaVkxR09kMmxH?=
 =?utf-8?B?MUJnS0EwM1VZZEtZR1k3QStMODFpMVJzSE1HQ2NIZ3c4NHVRZnB3SkhLTXA3?=
 =?utf-8?B?QThoOGJMcG5YUUUxS3dkdGpaVkxzQWJKR3I1UWNmaTVBSWRYTE9IeldjL01O?=
 =?utf-8?B?dnhxM2JYTjRtUG0vLzA5VUVBSFNySmdrWmhwTkZMeVBTRktqQ2VmMXZxeDZC?=
 =?utf-8?B?VVpLdE9LbXM2UXRtY1JISXd0allZemhkQXN5Qkl2UkZvVVJUZDhEbGZEeW1x?=
 =?utf-8?B?VjBXMi9XcVRXWVpERVd5SFBKLy95U3dHWmFLTHprTW5tbGdjSnlCMWVJNUg2?=
 =?utf-8?B?SDc0dURMVHZUWC9YN3BpcExCTXlwS014VllZbHc2bExxY2RGUUxJQ2VtTkg3?=
 =?utf-8?B?cHVtMkNtbXJ5TG5wKzhtVlVDczd2K3NnU2FOdUJ2QVlSSFZaSjZpSjBzdVRo?=
 =?utf-8?B?VGNRZ201YThMdFNuRDYyc3BNYTNFU1NxMm5YT1MrTVc0VFU5bEdXaHRBdlgv?=
 =?utf-8?B?dXA0ZnlqbnVzbEVqUTdKQ1Y2V3hlZmJnL1p0RUNDRE54RWNpWVhIWXd3MVdi?=
 =?utf-8?B?dWczeldlVFBGckhzZlQxQlNsaUhKSThqWG00QzRJR0ZwMFdaMUZSWE1lUWxi?=
 =?utf-8?B?V1g3emJJNXczZjBMZ0lKUnRWdnZrVmpUbGJpOGx6Skx6NmVmbHhyK3BGV1Vk?=
 =?utf-8?B?Umh0OE5aNlZVUGpITXRqMFI1N2pLY0VubmNGYUxwL1pBQ1haSXFUWUltMU05?=
 =?utf-8?B?d29OOThoODRzYURqV3RpcU9YVkJzWm4wT0tYT1NhaCtHQjhvYlhPZlpkWCtO?=
 =?utf-8?Q?5juE6Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnlmakJ2RmxyMEZJWFFvS1NPSEV3OXQ2QVpmTW9SREVrN2tkUGlXYmZHY01z?=
 =?utf-8?B?ZitjbG5NSG9STEJMbFlTaytPcmtTOUdTeTdCKy82dTNhS3FPN2FLb2grUzFy?=
 =?utf-8?B?Q2R6ZHk2NFJHSWY5YVo0d0x1RDY4MUlxajZtVm93bCtTaENlRWpmZTdSUnZS?=
 =?utf-8?B?b2d6NGZCdGFLRGdNeTNoZjJjRnhaN0lGcG1KOHBFeHNHcmY1OXg2S1BnRWZE?=
 =?utf-8?B?ZnBKV1NUZE5WNkViZDBPK0xjSU1wbDh1ejZ3Mjl0MWZsSmhpa2FDQktLbXho?=
 =?utf-8?B?TmhwNTNxZXdZVEtWODgzT3BZcFpGek5ZeVJGbjJVR0JGTmM2bGIxTTg1QmRL?=
 =?utf-8?B?QTJMdXFEVjNyb00zaHpnbmZWZEJsU0l5NWhRME5PSGhQR3RFRVZzRHEvTkFp?=
 =?utf-8?B?RW5uQWljRjVSa2RrbHdTeXZURFBLdjBFQS9CalhxOVRKYWh0alpiRk5EYmh4?=
 =?utf-8?B?cFhkSms0REp1TDVrMHQ1MWt4U2hYdWhBOUJ3WE9YcGtCUFFwenpXcGRwNnZx?=
 =?utf-8?B?dGZBNXlQbDY0T21OZFpBdWJyYUcwQzhUWEdqdWZRUWtoS0xLTGFBUTFGVTg4?=
 =?utf-8?B?aG9VYms5dHpjaW9taG1GRUtuOHE2VC96UmZhbzZqR1EwVkdONWFYTExtU2xZ?=
 =?utf-8?B?VXVvbkZjTUhsUFlVQ1g4YWZoeHMrV3JxZGpRa0VxQ1hkWlpCMllyaE1uZ0Fn?=
 =?utf-8?B?SmxCemcwUWx4STlmZS9OaVN2KzFhSVJuVUIvYW5USWZ6azM4SUZvN3BBM3po?=
 =?utf-8?B?NjVFdE56ZEtITHVsRVR1S2dZSjdDSjlmZDdmQ3M2WUJDVk1FWlRmTXpSd1o0?=
 =?utf-8?B?T0VVeVRZV1V1ZHRRbWNNQkZCeHB2Y2lCS2pWTE1CeVJ5alVObk01KzdLR2pI?=
 =?utf-8?B?RHk4dlFEMTNtZFYrM1NUekNKTXhMK3c1RzZhTXZMd2NIa3gram02aG1ZYVZG?=
 =?utf-8?B?VEo0YVZsNU9ZTTFwWHExR1d1YzI5QWQyK3lzQjNiSzFhVG5OQ01JNmtvdnBl?=
 =?utf-8?B?d255MVZUNW9YdDJWUXhBUU5ua2lXLytrVktkVzRWVnVRc1p6cGxzdEpuQUda?=
 =?utf-8?B?akVyRnBCdkl0MlNmdWhPK1p2dFVWb2hNMDI0dFVGS2QwdXJMelNZTnl3YzRp?=
 =?utf-8?B?anpyQnpNdGpPbzY5TCt5WmFOL245WnJjaHhyRElEMXRub3pMV2V3UXJveHNZ?=
 =?utf-8?B?aklmdEVIMFFNN0k1ZmFMN1ptazh6NjRrVW1NUU4va2NqRmFDdlFsRm95SXlX?=
 =?utf-8?B?NVBERy9MQllqcS9oMVlRQzVSTG8xcXU1WGI2QzR5OFJObWVPNHdZT0JjLzJK?=
 =?utf-8?B?WTRJVmtXMmE0ZFBSMUJtZks4RzY4K2ZGb2pyVEZnbUhNNlhYTEJLZTZOWWJ1?=
 =?utf-8?B?TW1kMzNrbW9iNDFjRVU4ak5NdHh4eXlIQmRjYjY5MFdjZnBrT0ZFd1ZnbzhR?=
 =?utf-8?B?VFo0RE1SendIa0RpR21NSWhIZytyUzdsRzBYbHhyQUhQOXJyc1JCTzRCcldX?=
 =?utf-8?B?bmpQYUxFKzAwNThzS3pydFliWVVDMFRHOCtlZkJWblpVYkVVMFk1ZVFySW9r?=
 =?utf-8?B?MGdEelRFUjBPZ1ppaEdqb0NDcmdMRndaUEgxL3p0M09mWmo1b1U2Z2Z2OFdF?=
 =?utf-8?B?dlRCUmlxdzhvcGVKUmxQeUdVSUxneUpEeUpneTFkY1hQckVZb3p5WjQyd0ZH?=
 =?utf-8?B?YjM5NFlXK0FrQldya3BxOGcya0RReHBSbU8vWHhTRzFaTExQZDJUWTNVdmxT?=
 =?utf-8?B?cUZvWGpHTWwzTytYYzkzVUtYRjJlRmNmMUR3SmR5Qng1OXRzanFiVVFaZVll?=
 =?utf-8?B?ODNSMFhnREw2RGN3dW4zbVVraGpzNGlzeHZIMkJZcE9IMlBaMmlRVXIzVCt4?=
 =?utf-8?B?KytodUVRU0pJbFcrTzUzZmJGWnZlTmlTS050T1ZMS1d4NGttOVRteTNsUXp4?=
 =?utf-8?B?b0Y2aUxrTE9xUm95N05RUW1vUTVvV3ExNGVuQ3BGRXRkb05odC9JcW1ZVzlB?=
 =?utf-8?B?cEV6Y21rUkVVQ0ZON1c5ZlVaK25kRmNPd3JNQUdGQkhtQzFNZy9qL3BBc2tB?=
 =?utf-8?B?Y1VjVjdnMFBWV2pMYTQ1b29WQXA0c25zSUpOVGZ6b2pKeXBVWmo4OHhJVnhi?=
 =?utf-8?Q?jAaYJyuASK7Tr8R6s+x/GoffK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd3e650-6e04-41de-9203-08de01965af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 09:30:41.5608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOs7U99t25E8ls2afwxfQHRy5m8gqojs9ZScz6Zj57fVngIv5cf0X7+lykWdqgC+iai6vatTb9YIg7xfNCm8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDAxIE9jdG9iZXIgMjAyNSAxODoz
Mg0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNv
bGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBN
YXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5n
emhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25n
LmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBn
bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8yN10gaHcvYXJtL3NtbXV2My1h
Y2NlbDogUmVzdHJpY3QgYWNjZWxlcmF0ZWQNCj4gU01NVXYzIHRvIHZmaW8tcGNpIGVuZHBvaW50
cyB3aXRoIGlvbW11ZmQNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gOS8yOS8y
NSAzOjM2IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEFjY2VsZXJhdGVkIFNNTVV2
MyBpcyBvbmx5IHVzZWZ1bCB3aGVuIHRoZSBkZXZpY2UgY2FuIHRha2UgYWR2YW50YWdlDQo+ID4g
b2YgdGhlIGhvc3QncyBTTU1VdjMgaW4gbmVzdGVkIG1vZGUuIFRvIGtlZXAgdGhpbmdzIHNpbXBs
ZSBhbmQNCj4gPiBjb3JyZWN0LCB3ZSBvbmx5IGFsbG93IHRoaXMgZmVhdHVyZSBmb3IgdmZpby1w
Y2kgZW5kcG9pbnQgZGV2aWNlcyB0aGF0DQo+ID4gdXNlIHRoZSBpb21tdWZkIGJhY2tlbmQuIFdl
IGFsc28gYWxsb3cgbm9uLWVuZHBvaW50IGVtdWxhdGVkIGRldmljZXMNCj4gPiBsaWtlIFBDSSBi
cmlkZ2VzIGFuZCByb290IHBvcnRzLCBzbyB0aGF0IHVzZXJzIGNhbiBwbHVnIGluIHRoZXNlDQo+
ID4gdmZpby1wY2kgZGV2aWNlcy4gV2UgY2FuIG9ubHkgZW5mb3JjZSB0aGlzIGlmIGRldmljZXMg
YXJlIGNvbGQNCj4gPiBwbHVnZ2VkLiBGb3IgaG90cGx1ZyBjYXNlcywgZ2l2ZSBhcHByb3ByaWF0
ZQ0KPiANCj4gIldlIGNhbiBvbmx5IGVuZm9yY2UgdGhpcyBpZiBkZXZpY2VzIGFyZSBjb2xkIHBs
dWdnZWQiOiBJIGRvbid0IHJlYWxseQ0KPiB1bmRlcnN0YW5kIHRoYXQgc3RhdGVtZW50Lg0KDQpC
eSAiZW5mb3JjZSIgaGVyZSBJIG1lYW50LCB3ZSBjYW4gcHJldmVudCB1c2VyIGZyb20gc3RhcnRp
bmcgYSBHdWVzdCANCndpdGggYSBub24gInZmaW8tcGNpL2lvbW11ZmQgZGV2IiB3aXRoIGFjY2Vs
PW9uZSBjYXNlLiAgDQoNCiB5b3UgZG8gY2hlY2tzIHdoZW4gdGhlIGRldmljZSBpcyBob3RwbHVn
Z2VkIHRvby4NCj4gRm9yIGVtdWxhdGVkIGRldmljZSB5b3UgZXZlbnR1YWxseSBhbGxvdyB0aGVt
IGJ1dCB5b3UgY291bGQgZGVjaWRlIHRvIHJlamVjdA0KPiB0aGVtPw0KDQpDdXJyZW50bHkgZ2V0
X2FkZHJlc3Nfc3BhY2UoKSBpcyBhICIgTWFuZGF0b3J5IGNhbGxiYWNrIHdoaWNoIHJldHVybnMg
YSBwb2ludGVyDQp0byBhbiAjQWRkcmVzc1NwYWNlIi4gQ2hhbmdpbmcgdGhhdCBhbmQgcHJvcGFn
YXRpbmcgYW4gZXJyb3IgYWxsIHRoZSB3YXksIGFzIA0KeW91IHNhaWQgYmVsb3csIGlzIG5vdCB0
aGF0IHN0cmFpZ2h0Zm9yd2FyZC4gQXQgcHJlc2VudCB3ZSB3YXJuIHRoZSB1c2VyDQphcHByb3By
aWF0ZWx5IGZvciBib3RoIHZmaW8tcGNpIHdpdGhvdXQgaW9tbXVmZCBhbmQgZW11bGF0ZWQgZGV2
aWNlIGhvdCBwbHVnDQpjYXNlcy4gUGVyaGFwcywgaWYgcmVxdWlyZWQsIHRoZSBlcnJvciBoYW5k
bGluZyBjYW4gYmUgdGFrZW4gdXAgYXMgYSBjbGVhbi11cCBzZXJpZXMNCmxhdGVyPw0KDQpBbHNv
LCBJIHRoaW5rIEkgbmVlZCB0byBleHBsYWluIHRoZSBlbXVsYXRlZCBkZXZpY2UgaG90cGx1ZyBj
YXNlIGEgYml0IG1vcmUuIFRoaXMNCmlzIHNvbWV0aGluZyBJIHJlYWxpc2VkIGxhdGVyIGR1cmlu
ZyB0aGUgdGVzdHMuDQoNClVuZm9ydHVuYXRlbHksIHRoZSBob3RwbHVnIHNjZW5hcmlvIGZvciBl
bXVsYXRlZCBkZXZpY2VzIGJlaGF2ZXMgZGlmZmVyZW50bHkuDQpXaGF0IEnigJl2ZSBub3RpY2Vk
IGlzIHRoYXQgdGhlIGhvdHBsdWcgaGFuZGxlcuKAmXMgY2FsbCBwYXRoIHRvIGdldF9hZGRyZXNz
X3NwYWNlKCkNCmRpZmZlcnMgZnJvbSBjb2xkLXBsdWcgY2FzZXMuDQoNCkluIHRoZSBlbXVsYXRl
ZCBkZXZpY2UgaG90cGx1ZyBjYXNlLCB0aGUgcGRldiBpcyBOVUxMIGZvciBiZWxvdzoNClBDSURl
dmljZSAqcGRldiA9IHBjaV9maW5kX2RldmljZShidXMsIHBjaV9idXNfbnVtKGJ1cyksIGRldmZu
KTsNCg0KSGVyZeKAmXMgd2hhdCBzZWVtcyB0byBiZSBoYXBwZW5pbmc6DQoNCmRvX3BjaV9yZWdp
c3Rlcl9kZXZpY2UoKSB7DQogICAuLi4uDQogICAgaWYgKHBoYXNlX2NoZWNrKFBIQVNFX01BQ0hJ
TkVfUkVBRFkpKSB7DQogICAgICAgIHBjaV9pbml0X2J1c19tYXN0ZXIocGNpX2Rldik7DQogICAg
ICAgICAgICBwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoKSAgLS0+IGdldF9hZGRyZXNz
X3NwYWNlKCkNCiAgICB9DQogICAgLi4uLg0KICAgIGJ1cy0+ZGV2aWNlc1tkZXZmbl0gPSBwY2lf
ZGV2OyAgIC8vaGFwcGVucyBvbmx5IGFmdGVyIHRoZSBhYm92ZSBjYWxsLg0KfQ0KDQpGb3IgdmZp
by1wY2kgaG90cGx1Zywgd2XigJlyZSBmaW5lLCBzaW5jZSB0aGUgdmZpbyBsYXllciBjYWxscyBn
ZXRfYWRkcmVzc19zcGFjZSgpDQphZ2Fpbiwgd2l0aCBhIHZhbGlkIHBkZXYuDQoNCkZvciBjb2xk
LXBsdWcgY2FzZXMsIHRoZSBpZiAocGhhc2VfY2hlY2soUEhBU0VfTUFDSElORV9SRUFEWSkpIGNo
ZWNrIGlzDQpmYWxzZSwgYW5kIHRoZSBjYWxsIHBhdGggbG9va3MgbGlrZSB0aGlzOg0KDQpwY2li
dXNfbWFjaGluZV9kb25lKCkNCiAgIHBjaV9pbml0X2J1c19tYXN0ZXIocGNpX2Rldik7DQogICAg
ICAgcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKCkgIC0tPiBnZXRfYWRkcmVzc19zcGFj
ZSgpDQoNCkJ5IHRoZW4gd2UgaGF2ZSBhIHZhbGlkIHBkZXYuDQoNCknigJltIG5vdCBzdXJlIHRo
ZXJl4oCZcyBhbiBlYXN5IGZpeCBoZXJlLiBPbmUgb3B0aW9uIGNvdWxkIGJlIHRvIG1vZGlmeQ0K
Z2V0X2FkZHJlc3Nfc3BhY2UoKSB0byB0YWtlIHBjaV9kZXYgYXMgaW5wdXQuIE9yIHdlIGNvdWxk
IGNoYW5nZSB0aGUgDQpjYWxsIHBhdGggb3JkZXIgYWJvdmUuDQoNCihTZWUgbXkgYmVsb3cgcmVw
bHkgdG8gZW11bGF0ZWQgZGV2IHdhcm5fcmVwb3J0KCkgY2FzZSBhcyB3ZWxsKQ0KDQpQbGVhc2Ug
bGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCg0KPiA+IHdhcm5pbmdzLg0KPiA+DQoNClsuLi5d
DQoNCj4gPiArDQo+ID4gKyAgICBpZiAocGRldiAmJiAhc21tdXYzX2FjY2VsX3BkZXZfYWxsb3dl
ZChwZGV2LCAmdmZpb19wY2kpKSB7DQo+ID4gKyAgICAgICAgaWYgKERFVklDRShwZGV2KS0+aG90
cGx1Z2dlZCkgew0KPiA+ICsgICAgICAgICAgICBpZiAodmZpb19wY2kpIHsNCj4gPiArICAgICAg
ICAgICAgICAgIHdhcm5fcmVwb3J0KCJIb3QgcGx1Z2dpbmcgYSB2ZmlvLXBjaSBkZXZpY2UgKCVz
KSB3aXRob3V0ICINCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICJpb21tdWZkIGFz
IGJhY2tlbmQgaXMgbm90IHN1cHBvcnRlZCIsDQo+ID4gKyBwZGV2LT5uYW1lKTsNCj4gd2l0aCBh
Y2NlbGVyYXRlZCBTTU1VdjMuDQo+IA0KPiB3aHkgZG9uJ3Qgd2UgcmV0dXJuIE5VTEwgYW5kIHBy
b3Blcmx5IGhhbmRsZSB0aGlzIGluIHRoZSBjYWxsZXIuIE1heSBiZSB3b3J0aA0KPiBhZGRpbmcg
YW4gZXJycCB0byBnZXRfYWRkcmVzc19zcGFjZSgpLiBJIGtub3cgdGhpcyBpcyBjdW1iZXJzb21l
IHRob3VnaC4NCg0KU2VlIGFib3ZlIHJlcGx5IG9uIHByb3BhZ2F0aW5nIGVyciBmcm9tIHRoaXMg
Y2FsbGJhY2suDQoNCj4gPiArICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAg
ICAgIHdhcm5fcmVwb3J0KCJIb3QgcGx1Z2dpbmcgYW4gZW11bGF0ZWQgZGV2aWNlICVzIHdpdGgg
Ig0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgImFjY2VsZXJhdGVkIFNNTVV2My4g
VGhpcyB3aWxsIGJyaW5nIGRvd24gIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
InBlcmZvcm1hY2UiLCBwZGV2LT5uYW1lKTsNCj4gcGVyZm9ybWFuY2UNCj4gPiArICAgICAgICAg
ICAgfQ0KDQpBcyBJIG1lbnRpb25lZCBhYm92ZSwgc2luY2UgdGhlIHBkZXYgZm9yIGVtdWxhdGVk
IGRldiBob3RwbHVnIGNhc2UgaXMgTlVMTCwNCndlIHdpbGwgbm90IGhpdCB0aGUgYWJvdmUgd2Fy
bmluZy4gDQoNCj4gPiArICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICogQm90aCBj
YXNlcywgd2Ugd2lsbCByZXR1cm4gSU9NTVUgYWRkcmVzcyBzcGFjZS4gRm9yDQo+ID4gKyBob3Rw
bHVnZ2VkDQo+IEluIGJvdGggY2FzZXM/DQoNClllcywgc2luY2Ugd2UgY2FuJ3QgcmV0dXJuIE5V
TEwgaGVyZS4gSG93ZXZlciwgYXMgZG9uZSBoZXJlLCB3ZSB3aWxsIGluZm9ybQ0KdGhlIHVzZXIg
YXBwcm9wcmlhdGVseS4NCg0KPiA+ICsgICAgICAgICAgICAgKiB2ZmlvLXBjaSBkZXYgd2l0aG91
dCBpb21tdWZkIGFzIGJhY2tlbmQsIGl0IHdpbGwgZmFpbCBsYXRlciBpbg0KPiA+ICsgICAgICAg
ICAgICAgKiBzbW11djNfbm90aWZ5X2ZsYWdfY2hhbmdlZCgpIHdpdGggInJlcXVpcmVzIGlvbW11
IE1BUA0KPiBub3RpZmllciINCg0KWy4uLl0NCg0KPiA+ICsjZGVmaW5lIFRZUEVfUFhCX1BDSUVf
REVWICJweGItcGNpZSINCj4gSSBhZ3JlZSB3aXRoIE5pY29saW4sIHlvdSBzaGFsbCByYXRoZXIg
bW92ZSB0aGF0IGNoYW5nZSBpbiBhIHNlcGVyYXRlIHBhdGNoLg0KDQpJIHRob3VnaHQgb2YgbWVu
dGlvbmluZyB0aGlzIGNoYW5nZSBpbiB0aGUgY29tbWl0IGxvZyh3aGljaCBJIG1pc3NlZCkgYW5k
DQphdm9pZGluZyBhIHNlcGFyYXRlIHBhdGNoIGp1c3QgZm9yIHRoaXMuIEJ1dCBpZiB5b3UgZ3V5
cyBmZWVsIHN0cm9uZ2x5LCBJIHdpbGwNCmhhdmUgYSBzZXBhcmF0ZSBvbmUuDQoNClRoYW5rcywN
ClNoYW1lZXINCg==

