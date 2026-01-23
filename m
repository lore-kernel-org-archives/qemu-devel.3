Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8684D74EEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJAP-0004kG-SD; Fri, 23 Jan 2026 10:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjJ9y-0004cM-W0; Fri, 23 Jan 2026 10:33:24 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjJ9x-00089O-3W; Fri, 23 Jan 2026 10:33:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFImLttJPSS0MN552Tb8l1UdSDlsoaYUZ8+/4TLw8kxu0mYcpWpD9z3zGo5m8B8+yBHAgIsV+wBxhJp5gxwFZ6FXsDZH0A6LJx5R7suBj2dLcD2ZyjIebusNtYc+jYUhagMKseZac1fBiWv5ZQq0Yts01ov6MN8/KFqAoM1tFQbZLl/tflCa7x452IqRIopYQt2eONB0HsesdG9ikEwmmTn+5ByrhVM5SmsZyS8WZUU+fhxPrgxYikfC/tY4N7WIFJEH3wswuFdLXyZM3qeTzDB3inQBD6QLheAIEXqnAhVjL1AEaNHbc+BKq2mU1GQF/SSd2OTFvnXQ/GkawKod7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSQibw5faGfLKZ1G6wzT0U+jH+Odep3kbcrLf4Lpj/U=;
 b=yI2aiCOrH2W5IsEFyRrn7u2jdApnWttlKzl4iumVmfCKPlzQ/9RsGtAxoPDs4tx93PtSvjPrmjW1C+9nbrXnJcC3m8cU+UcD95BuLXiaK2dR7hEbIz+lxjR8JPxpySGcfahsRhC+dxPJ2vcc1qckaoLgF2Y1/GSPHjUNSiiC1c9wx1dNsWdpR2RESiCcCZ38AtG0f42LvE5sXKDXkoP1P7TO1VY2m2YUfO64rwiasENstcuEvnyjq4rO5orA6oBC0iNNyvw2FvcQySeYtr1mgxLUOKNHqssISfkboDvJbSNuGxCpWHb62FjOEvC+p1CrocOQx1jaKT3VhC+6vHNtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSQibw5faGfLKZ1G6wzT0U+jH+Odep3kbcrLf4Lpj/U=;
 b=nQKMOl48u82XrYv4FkahJMwnbsPLkAQichgKc9OA/Bjvo7i/XxMmdJ5IIvAUhBYYIv4rmNXaMAwwCeQL055pQqxNQuHJb24eRRHniu2MKibny9sOB6cM1yjiV3bxTwv88UY9BhGZbHvRs7xfRMjhWryaofODLPgRLBA24YrxbgwDx7rdXPNlWyzbArOBd03PvYM+zkbraeOVTXxwcsx3p8OS3QPNIojEKuMYvLZHBzDcAx9Arf/nqIAhcwsRcYyo3Fge6osrd9RhkaPzFsR97Dkye4sI+cTeLp0Gipxf1IunndZBWM5unewuxuMuvys1nAqaUPZepYG631aXsZABBg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:33:10 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:33:09 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin
 Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHciv8RXDVv9+SEiEKA20nh1wOeY7VfZT0AgAA/SYCAAAStgIAAAURAgAAzGICAAAaFgA==
Date: Fri, 23 Jan 2026 15:33:09 +0000
Message-ID: <CH3PR12MB75482DA817149816D5CD485EAB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
 <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
In-Reply-To: <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8910:EE_
x-ms-office365-filtering-correlation-id: 6b3bfc6b-a5f5-458c-8c97-08de5a94b696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eGhnZCtoRXNXSXVsUzRyRzNidUVYSFFIa2hHUW5FSy80cHRmUXZDQnJGSGZo?=
 =?utf-8?B?KzRPUldVb21zYlBVcEF5eSsxc2pNNTZTUnU3OWlucnNMemFjU3FsUGJmazIv?=
 =?utf-8?B?R0d2czdtR21udDVJRWY1c0lzVWtrblBNc0tUbm52cHc3blBjVU8zSTlXaG0v?=
 =?utf-8?B?VTFrZHVLUEVsM1ZxTXFHT0VObW03cUJTaFVSdXpTcDZ1MVcrc25jZFo0VXpw?=
 =?utf-8?B?MzMzRHNRWkpXZkRUeTVrQ3VYMHNMU0VCYS9oaW9XbXJqV0tINndjSk1UaSsr?=
 =?utf-8?B?N3loTmIrU0hhWjJQcmlicWJUSlhEMUsvZ1RRTjYyNWtsTUk1QVBaUVJWdEZH?=
 =?utf-8?B?bXN5NWNGSi85ZEU4NXl1Kzdya21FNENUbGlqK1Nnd3JBaEdtTGhrL0hLZXhz?=
 =?utf-8?B?cStocjB1RzFiVHF6czJLY2hLMzgvaEVGajF6eFUzLzBwdTQxbWlMN2tBM1gw?=
 =?utf-8?B?QlB4aEVyeTdyV1RCZmRxZFBWK0g4ZzNEeUxOMkRGQWJCNnNaeS9ZSGVCT2NB?=
 =?utf-8?B?REgyTlpiSXphM1Azclh6dkVsam1zKzFHVm9sMzI3bGdhalk0WXU3MVJIdHA1?=
 =?utf-8?B?NFpwVXhldDd2NmVGaUlWdVhDUFdxakprUTZmeDFkajU0ZHRKb05EdTZJYm5O?=
 =?utf-8?B?cDRsaVZ1K3hXc1dEVk9GMXZRL012c2RlTVRyVWMydFA4aUtWSWR3OTBOZDEy?=
 =?utf-8?B?eUwvMmt0S2JuNGQ5d2NLVVVQcXR1cTMySmJUdVhxeUxtRjN6YTlJYWtmSUZZ?=
 =?utf-8?B?QUFWOGs5cXZqclpod0pCR0lhSURza09TL3k3N2hBOWVvYXcvdDJRalc3a1dR?=
 =?utf-8?B?b0NMZzQwbUI5VDlVZVJHT2tKdjE3ZjZFcUsxVmNoZCs4RlJVTEJ3VkFjeWs0?=
 =?utf-8?B?UjFrbHlBNlJGL2JiMGU1a0w3Zjl4bEs2c1lNTFhRY1RPRk5iYXZ1YU1XbC9B?=
 =?utf-8?B?d1FJYlFYYXJ4NXp0YTJNd1NZcjd6dHA1b1NTMk55TWVzQWd6c0JZVnRlK05w?=
 =?utf-8?B?WDk5MzdFZFZJZ2kzNlJuYXRjLzdzWU1mTXpTNWs2K2EzQTFHMUdoa0d6Q0ww?=
 =?utf-8?B?OTBBZ2x3ZDRtTm9lQ3JOcjBEN094QWVSeHdIc0V4TWNlTEdwTWpGLzhXY2dG?=
 =?utf-8?B?M3BFdUNjdmZKWGJqYmNtRDNQQitPaC9vb01iSkQzS3l3WUQ3bytkRkhQZnha?=
 =?utf-8?B?RjYxUnp2TkNyNFRoS2pVbXgrOVBKNnBxUU9JTy9GOUgvdE1BQ1N4Ylo0WWQz?=
 =?utf-8?B?NDNFQkVkR0hpWFlkMGZMMEdieEVtcHRZbVorM2JDb3Nhc01VQW4xd1VTbjBx?=
 =?utf-8?B?Ymhsa2lkVG9ZSTUyRHQ5YVU4MXFhc2ZuOU15MDY3d0xwUEtaMjM0Nmxrd0pW?=
 =?utf-8?B?UExIbkRzekpuWkxid0pDaDZVMTU0b2hQTWI4Zy9HcXRjS1I4eU1QTGhkZ3dz?=
 =?utf-8?B?RUxiUWVGQ1F2V3J1N09NeWVjZFIwNkZxa1NXQ005Mm53ZXRjU0ZvSTRVUkdr?=
 =?utf-8?B?Rm1zd3htSkxaRWR1Ynp2cXYzQWZ6cUdIUTlGU01tdXRnVTY2UTdlbkZaQXlx?=
 =?utf-8?B?Qm1yNjNXNHR0SENLSmdpcFBxYThwT09YNzdiRnJwZTNlazhSRXAreFlPTmRV?=
 =?utf-8?B?dUJNQ1I4RWdDUTNITDdqZDZOeEF5a2ZhQnlHT3pXUVRubFBQbzhMcmkwcklB?=
 =?utf-8?B?Zi83VzZnYmZIRldvZjkzYytTdXE4dVNFZkt3MjNzU29rVjE1TExtUytIVlR2?=
 =?utf-8?B?dzQyQW5YZmFkckN0OUxiWWpscDBHaHh6SzVjd1VPcEYyVDA3VjA0RjdEM3BG?=
 =?utf-8?B?NnRNbXdoV3c2VHZ4MEJyM1N0TWJrUWlzQnBCMThZZDV4bnRiZ1RTLzFIMy9W?=
 =?utf-8?B?eERGWThROUFDcnQxbml5bjk3WFV6UEdPRzVDOVZibkVaNVM2akU4bG1Kb250?=
 =?utf-8?B?blVqTkYwUGxoVUk3bElybTZ6M1hTZ05LMFlENDBKOXhpV094U0Q1TW5QSVJZ?=
 =?utf-8?B?RDU4SUV4dFcyaDJPMnRiREgxbmc2ZERPTHFmZTFTQlpJQzl4LzBUT1BZNzA4?=
 =?utf-8?B?YzZxTTVtd3lXaithR1FocHlkYzg0SlVKNm94U1BONkEvZlV2S1hxdGEva25x?=
 =?utf-8?B?YlBnbXNER2RzL2dHbTRtVkEwT0FuQ1lMQmx3UVZnUGp0enZNV3ZqeHdLTEVo?=
 =?utf-8?Q?oE7cFoq33lppIlJi50VZA/A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejZzblJ6S05UUUp6d3lnVVY1ZmxFajZDdGdjQjJoTk03a0pKdDFmNlRkN045?=
 =?utf-8?B?U3lnL3Fnd0RXUXZ3UE9iRDVpZGFWU0ZGTkhWRi8xZ014YzVSaGpNZUd3V3cx?=
 =?utf-8?B?L1J0dG1ZQUNJdGNVK01lcWZkaHV5blZsSkNEaE5YMjVlUzZQMFc1OGxQVWJ1?=
 =?utf-8?B?YUZUcmRpNUhlUi83aFIyYldTMDVaeUJjelhMOUxzRnN3aWdZUVJ1SGttYzNp?=
 =?utf-8?B?bUYzR05xQmFDKzVRMHFJV2F1cjllQWI2blQzMDE2eHJaWW4vMWgrRjI5REZH?=
 =?utf-8?B?emhXUVpGK0JHZFhPeE9FemRaeThpc2hGNjU2RmpnYThRZnJMMzR1a2o1cTIz?=
 =?utf-8?B?NThqZmlzVU9kMXZyZjBlVFVMTG9OZjhqUGVjNG1hOXQwekliR3pwNlZwb2NW?=
 =?utf-8?B?Ti9QN0FHT2dvRTA0Yk5SdElsUTdzRHdWaVd2dlRoSVhrUFdwN0svMFZibGRO?=
 =?utf-8?B?UGNuNzZNUnRCWlQxcE4vTEVUTFRKZmxPN0IrS3VDcjlWT1JWcEdScUdmaVNk?=
 =?utf-8?B?blVSUldyQk9SM2JmYkd5YkUvQ2pjMUlWWjhKYXVuaTZTREk0emJQVmp2ZnRB?=
 =?utf-8?B?RWZPTCt3czNidzFaUTJYUUJ1ZU9zd3ZrOFlqVTlOa0YreGJiUHpGQmxoNGR3?=
 =?utf-8?B?Q1dUTEZhTEwxeUVKSGdjYjV4a2RkSXVzTHdLbVNuNG5TMFA0ejM5emI3U1JG?=
 =?utf-8?B?bW5ublBkSzkwbEtiRSt0U2preFptRCt4b0xaR05EMTNMUmxwK21rK2VvOFFk?=
 =?utf-8?B?OWhzZDQxR2hNZWhVb3FSOFFURTU0emxLSG5uNG15SGVuTC9QSE9mTDVWZHpT?=
 =?utf-8?B?SlpDaERMckFyQTU4bVg4eEZiZ09lVDBqMWNyUjVlN2lWUEo3bURSUmlhaHBm?=
 =?utf-8?B?cGFwOG1qemx1M2pIRHFwSmZrbXhqdDUxVXh4V01lcmM3WUNFU3VRWmdLL09x?=
 =?utf-8?B?Wk1DTkZJclpBWStJeU02d2ZTSlFqZUprNzNQVStZaU1KeVpVb1dTNTVsRWdO?=
 =?utf-8?B?MFJiVWRMNVA3K3BtZWdsWmNBYzcvNGF5dHVMazFvVXljUjFHN1d1dmhnMzF5?=
 =?utf-8?B?bEgwenpnUU9rUU5uMTRsSkdBUTlXcXZ6WmpNc3VTTVRkVVZlTnBzR0hUUGQx?=
 =?utf-8?B?OGhKdGx6a0IzNDBjTkx3L2o3Q2JEbFZQZ2R0V2xNdS9wTEwxL1lSWWFYVEZy?=
 =?utf-8?B?VHcrK1A4V2xsczd6UUlZVWljbWhFaUc3NFViMHBVTjlNNlVIcWVRcnRMNG5U?=
 =?utf-8?B?ckRtaFIrQ3lhaEdCUjdQMERjWTJzbERYTkV0M0VLdVZwSnRMRHdGSDFtaDhn?=
 =?utf-8?B?UFFjdytpOTlsVFp1STU0RHpvVlE4WjNUWlluT0k3bmFWRWM2bUxReTg2ajcy?=
 =?utf-8?B?cCs3czFqdU54UE4vRUQ3K0lTN3FPSW10eGsvYVVWV3c2WnhlcEFKRy94S3JC?=
 =?utf-8?B?c2NNaEZHTnEzb2FxZjJ5T3c0YXNnNDBnRllGanR6em9LaGREQzMvWjBpSUpT?=
 =?utf-8?B?RHJqUGxUVXdNVnp0Q1V1ejczS2xuSFplckhTMS8wL0FQQ0EwLzJQVkV2ZXk0?=
 =?utf-8?B?NzNuSW5Gb1docCs4b0I0T1dQRVNrejIxUEFFVGtocC96MEhMMDh0QWRzVG52?=
 =?utf-8?B?SVN4WFZ5aCsvdGRSa1pCSU1YVHljakFOaXl5cStSdlRTb1ZvSWxITkhrelpk?=
 =?utf-8?B?TkhFdEFNbUx0SVhnNmJNWmpxVXA5cE85MWpLNHFXTkZtMDR4ME14KzZFNXJF?=
 =?utf-8?B?dEp6czJnMFBNU0VlNTZCT1pqWlNTbFFFdnJkYW8xSjZSaDFQYlFoTytQUDNU?=
 =?utf-8?B?RlNPY1ZjMTY2UHJadWFCUG1iTThTWk1UZkxwbTNyZWsySHA5bk8rcXF2VVhY?=
 =?utf-8?B?QXowRGR2MWg3WnZmZjNUUHVOT1AvTzFobk1HVncvY3JSMGdFNmNDUkNqTHAz?=
 =?utf-8?B?cTUxaGZSeGYrWVIrWi9xbGhEdkdUVlU4UVpEWSttRS9mdVhSbGZCZ2kwOGF2?=
 =?utf-8?B?WHc4c1NXMGdjLzNqWStOV2pWd2hYZ21LQ2RxWCtEamoyM3dMTi9UNzlMZEhB?=
 =?utf-8?B?R28rcDVTT21FL1E4eDJINjlOWTJEdVp3dlFrcDNvTXRDcWw5bmlYaUdjakVP?=
 =?utf-8?B?dmNDSnF1YjZNWWYrWnlxMjYwbVhBYURFOEJKV2tZbHQ3Sk8zM1hqQXJCN1o3?=
 =?utf-8?B?ckU5UjI1MXF0Tk82M0lhUUFxV2c0K1pBVWd3ZkhxQmVjQTZGTEp3bG1PODZa?=
 =?utf-8?B?Rk52dUJmYi8yRlcyN2FGdzRsbGhBSXVOcWRHRFUxM20zdVZSY1htQTVmNlVS?=
 =?utf-8?B?SkNoMkNGYzJJTzZCNnh6MGtjT2hLOGtQb3ZuOENxblppQldBK3Jzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3bfc6b-a5f5-458c-8c97-08de5a94b696
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 15:33:09.7948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G062zeqP5pi2aMNlunlADqpvJXYlok7Mw40Q9XKB3Das/jw32UbAWsYyh05pKte7J7ECQ6rddfy4Gb3skyP9+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjYgMTU6MDYN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzog
Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgRXJpYyBBdWdl
cg0KPiA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJy
YW5nZUByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsNCj4gYWxleEBzaGF6Ym90Lm9yZzsgTmF0
aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2Nocw0KPiA8bW9jaHNAbnZpZGlh
LmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBq
aWFuZ2t1bmt1bkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUN
Cj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDAvMzddIGh3
L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVhdGFibGUNCj4gYWNjZWxlcmF0ZWQg
U01NVXYzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIEZyaSwgMjMgSmFuIDIwMjYgYXQgMTI6MDQsIFNo
YW1lZXIgS29sb3RodW0NCj4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPiB3cm90ZToNCj4gPiA+
IEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiA+IEkg
Y2FuIGZpeCB0aGF0IHVwIHdoZW4gSSBxdWV1ZSBpdCBpbnRvIHRhcmdldC1hcm0ubmV4dC4NCj4g
PiA+DQo+ID4gPiBUaGFua3MgdG8gZXZlcnlib2R5IHdobyBoZWxwZWQgd2l0aCBjb2RlIHJldmll
dyBvbiB0aGlzIHNlcmllczoNCj4gPiA+IG5vdCBoYXZpbmcgdG8gZG8gdGhhdCBteXNlbGYgaGFz
IGJlZW4gYSBiaWcgaGVscCBmb3IgbXkgcGVyc29uYWwgd29ya2xvYWQNCj4gOi0pDQo+ID4NCj4g
PiBUaGFua3MgZm9yIHNvcnRpbmcgaXQgd2hpbGUgcXVldWluZy4NCj4gDQo+IFVuZm9ydHVuYXRl
bHkgSSBoYWQgdG8gZHJvcCB0aGlzIGZyb20gdGFyZ2V0LWFybS5uZXh0LA0KPiBiZWNhdXNlIGl0
IGNhdXNlZCBvbmUgb2YgdGhlIGdpdGxhYiBDSSBqb2JzIHRvIGZhaWw6DQo+IGh0dHBzOi8vbmFt
MTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdp
dGxhDQo+IGIuY29tJTJGcG0yMTUlMkZxZW11JTJGLQ0KPiAlMkZqb2JzJTJGMTI4MzkwNDAyNzgm
ZGF0YT0wNSU3QzAyJTdDc2tvbG90aHVtdGhvJTQwbnZpZGlhLmNvDQo+IG0lN0NlNjRmODhlNWVi
ZTU0YzEwYTc3MDA4ZGU1YTkwZjEyZCU3QzQzMDgzZDE1NzI3MzQwYzFiN2RiDQo+IDM5ZWZkOWNj
YzE3YSU3QzAlN0MwJTdDNjM5MDQ3Nzc1ODExNzUyNzYwJTdDVW5rbm93biU3Q1RXRg0KPiBwYkda
c2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpY
YVcNCj4gNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdD
JnNkYXRhPXIyY0Z4DQo+IHRlNnRjVVNMalRUcE1LTXZtVTRnN0ZncmhNVGF0RUxrUDRzSlhvJTNE
JnJlc2VydmVkPTANCj4gKE5vdCBhbiBpbnRlcm1pdHRlbnQgLS0gdGhlIGpvYiBmYWlsZWQgdGhl
IHNhbWUgd2F5DQo+IG9uIHJldHJ5LCBhbmQgcGFzc2VzIHdpdGggbXkgdGFyZ2V0LWFybSBxdWV1
ZSB3aXRob3V0DQo+IHRoaXMgc2VyaWVzIGluIGl0LikNCj4gDQo+IEknbSBub3Qgc3VyZSBleGFj
dGx5IHdoYXQncyBnb2luZyBvbiBoZXJlLCBiZWNhdXNlDQo+IHRoZSBiaW9zLXRhYmxlcy10ZXN0
IHRlc3QgcGFzc2VzIG9uIG15IGxvY2FsIG1hY2hpbmUuDQoNCkkgdHJpZWQgb24gYm90aCBteSBB
Uk02NCBhbmQgeDg2IG1hY2hpbmUgYW5kIG5vIGZhaWx1cmUuDQoNCj4gQ291bGQgeW91IGludmVz
dGlnYXRlLCBwbGVhc2U/DQo+IA0KPiAxLzQ1NyBxZW11OnF0ZXN0K3F0ZXN0LXg4Nl82NCAvIHF0
ZXN0LXg4Nl82NC9iaW9zLXRhYmxlcy10ZXN0IE9LDQo+IDgzLjU4cyA1NSBzdWJ0ZXN0cyBwYXNz
ZWQNCj4g4pa2IDIvNDU3IC9hYXJjaDY0L2FjcGkvdmlydC9pdHNfb2ZmIC0NCg0KVGhpcyBpcyB0
aGUgb25lIGZhaWxpbmcgYXBwYXJlbnRseS4NCg0KPiBFUlJPUjouLi90ZXN0cy9xdGVzdC9iaW9z
LXRhYmxlcy10ZXN0LmM6NTU0OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbg0KPiBmYWlsZWQ6IChh
bGxfdGFibGVzX21hdGNoKSBGQUlMDQo+IOKWtiAyLzQ1NyBFUlJPUg0KPiAyLzQ1NyBxZW11OnF0
ZXN0K3F0ZXN0LWFhcmNoNjQgLyBxdGVzdC1hYXJjaDY0L2Jpb3MtdGFibGVzLXRlc3QgRVJST1IN
Cj4gMjUuODZzIGtpbGxlZCBieSBzaWduYWwgNiBTSUdBQlJUDQo+ID4+Pg0KPiBNU0FOX09QVElP
TlM9aGFsdF9vbl9lcnJvcj0xOmFib3J0X29uX2Vycm9yPTE6cHJpbnRfc3VtbWFyeT0xOnByaW50
DQo+IF9zdGFja3RyYWNlPTEgUFlUSE9OPS9idWlsZHMvcG0yMTUvcWVtdS9idWlsZC9weXZlbnYv
YmluL3B5dGhvbjMuMTENCj4gVUJTQU5fT1BUSU9OUz1oYWx0X29uX2Vycm9yPTE6YWJvcnRfb25f
ZXJyb3I9MTpwcmludF9zdW1tYXJ5PTE6cHJpbnQNCj4gX3N0YWNrdHJhY2U9MSBRVEVTVF9RRU1V
X0lNRz0uL3FlbXUtaW1nDQo+IFFURVNUX1FFTVVfU1RPUkFHRV9EQUVNT05fQklOQVJZPS4vc3Rv
cmFnZS1kYWVtb24vcWVtdS0NCj4gc3RvcmFnZS1kYWVtb24NCj4gQVNBTl9PUFRJT05TPWhhbHRf
b25fZXJyb3I9MTphYm9ydF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MQ0KPiBSVVNUX0JBQ0tU
UkFDRT0xIE1FU09OX1RFU1RfSVRFUkFUSU9OPTENCj4gR19URVNUX0RCVVNfREFFTU9OPS9idWls
ZHMvcG0yMTUvcWVtdS90ZXN0cy9kYnVzLXZtc3RhdGUtDQo+IGRhZW1vbi5zaCBNQUxMT0NfUEVS
VFVSQl89MTYyIFFURVNUX1FFTVVfQklOQVJZPS4vcWVtdS1zeXN0ZW0tDQo+IGFhcmNoNjQgL2J1
aWxkcy9wbTIxNS9xZW11L2J1aWxkL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QgLS10YXAg
LWsNCj4g4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQo+IOKAleKA
leKAleKAlSDinIANCj4g4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
DQo+IOKAleKAleKAleKAlQ0KPiBzdGRlcnI6DQo+IGFjcGktdGVzdDogV2FybmluZyEgSU9SVCBi
aW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsDQo+IFthbWw6L3RtcC9hbWwtN1FRVkozXSwgRXhw
ZWN0ZWQNCj4gW2FtbDp0ZXN0cy9kYXRhL2FjcGkvYWFyY2g2NC92aXJ0L0lPUlQuaXRzX29mZl0u
DQoNCkFueSB3YXkgdG8gcmV0cmlldmUgdGhlc2UgZmlsZXM/DQoNClRoYW5rcywNClNoYW1lZXIN
Cg==

