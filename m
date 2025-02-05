Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A11C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgWX-0007vW-04; Wed, 05 Feb 2025 09:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tfgWV-0007u9-4a; Wed, 05 Feb 2025 09:37:03 -0500
Received: from mail-dm6nam11on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2415::616]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tfgWP-00059M-Hf; Wed, 05 Feb 2025 09:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/2AxF67uRBHJYmvSM+J9OD39lLUcniUK5LoTgnkcS9Yd7DmbW6E1mqCpBMBJCVzWJc8Bp/+5wyHrV/XuhRSRWfjpd1pIdTl+OgVYsct3eYefLG/IkIhXpcTTioE2Ou0msryZTrFCQzB465zgx87HIlka3ClwpRpaPq+HK7gvek0VWFVtVn7xSxSJP3udh3Rqq5m6wK3+sy0Aad7DyaWO9rGPJFkEfgKNUewReSkCBtly0Cj9mDJUcvJSyYPko0osQ7hmr0JXz6dmBy46b+QlLpkjglwvu+hAFEe5c49nDBNMdogvxrc5uGTj0d6K19itwbBOMnczci88yJWzsxcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGZVD8GJAHpf/fkdZubVQ1IE0OvaTwVMBGu6Jryna50=;
 b=af9VDXD+KLhsahsIBFrMO+IQUlFP+LCNHJ5PkLJ8vocJXXkxWO2r1dcpgdkvgepxOKX6wH1IFg4Br5NhEZ2FWmB2+iCfiCxDpFVWqQns2h1DRHa7FArtVubzSFaeefECQkTPb4HRrg/VvjgclswFKl9OzBTiiH+TepUx2L+KDGIt3AI+aakvWeN+SfOO2LoL1KWpIYWg4OfI2X09sM2gFQh/8/uV1sobcJ0+FYpPFn4fVzpuqCqMyFK45Kmo1sw3IyZiWPfGLfgk3yQ+Xg0uNZo6HEDzKpJmsyJ392znFCeGQyKkxWSa2tCZYAqRvn/xiVkD5947kw8snAcuu956JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGZVD8GJAHpf/fkdZubVQ1IE0OvaTwVMBGu6Jryna50=;
 b=YdFBXWwPfvsI1INFfsSvk7YS+LYnbZyd+PZ3jxSa87lG/gJMxqBmyBh8dR6mIKNcyMSmFowzvvsYFyDf/RfjePxqMmuwaAZYbMmwVYR4eG6j5HyqsBcvFkUZFB+FoSQQvOwYeynPQiK0jbYfDhK6vekVwntucnYy07eXixk27LsMl1EBbOv3MI9WaDp33cH1RZ4lvaV8bGMC8Fk36c39e/dcq052UWu+Uq3rmw8w/ddVpjl813JYMHtwJ/vh3EG97KZVC3M4cmVsXLkTnf6kera47NauLHKjcvU8yku79w7eJlVJvDgpkzpHG0Dqya3mkUKsZWj9xdXAEGNrfEExLg==
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 14:36:49 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 14:36:47 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Gavin Shan <gshan@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Nathan Chen <nathanc@nvidia.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Donald Dutile <ddutile@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Ankit Agrawal
 <ankita@nvidia.com>
Subject: Re: [PATCH v2] hw/arm/virt: Support larger highmem MMIO regions
Thread-Topic: [PATCH v2] hw/arm/virt: Support larger highmem MMIO regions
Thread-Index: AQHbd4UjuzSI6i4Tsk6WhHjREW970bM4KOmAgACexYA=
Date: Wed, 5 Feb 2025 14:36:47 +0000
Message-ID: <2747EE84-3073-49B8-9B14-A4E4B08E5255@nvidia.com>
References: <20250205041918.2340237-1-mochs@nvidia.com>
 <04b9198a-9b50-4ad5-8495-8ed4c44aa9eb@redhat.com>
In-Reply-To: <04b9198a-9b50-4ad5-8495-8ed4c44aa9eb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8897:EE_|IA0PR12MB8376:EE_
x-ms-office365-filtering-correlation-id: e9bf2dd8-0c81-4feb-96ee-08dd45f28567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dlBkSlJNcExSNXJFSFBXRVhHMGl5aFREU2VoejIyd3JJMEZUSWJpNmpaTlpt?=
 =?utf-8?B?Ni9CMDU0SGJ2V1FFcUtvRVMrMHBpQjVVeGtXWjViMU5wL1RTWFFEQ0lIakJE?=
 =?utf-8?B?RUQ0cWdTcUcreWgxS1FhT2hnRWxkQmNibk1MMDFFNG1jSlR5cUtVc2t6cjlV?=
 =?utf-8?B?dlhDZlJ6TEhQVjFpMmc3bW1EaXB6MGRjaW0zVFFsUEpYd1lQY2dXaWZ0djlC?=
 =?utf-8?B?d3lFYXUzSkhYajFuQWh6ZGY5UXZBY1hGTGNzVWdFU3ZBcTRKcTVsOEZ2V1Nl?=
 =?utf-8?B?N0RLUVpTVXM5VFRaTHdQeWVQbjlhaTNHaW10TkR2NDh3OVhFQWtsUllENVFO?=
 =?utf-8?B?REhPeGpyd1lLc3pqdTA1U2xSdVBDYTQyZURHSS9JdStiY0RtOGlhQTBXQzhK?=
 =?utf-8?B?NzlHd1BjVnhyc3ZMRnROWjBTU0hMeURVOGYzMWJWVTcxVFhpNTB0ejliVGNt?=
 =?utf-8?B?c0RpVmhtbVRsYWVHOWdTbnQvcEJ1SVEzYlRnekZiWmdENVpKSnZMb25LcjVq?=
 =?utf-8?B?K3F6RTQrR3Y5YXJieUZ3MGFHb2s4aVRXVEhTMmdJZTJ0aStOQWNaN3VyUnIr?=
 =?utf-8?B?YnZKMy9LazE0SVhzZ05nUFZuTUNYRHlGVUh2T3hsaGFNbHJFRkExd1BlYlQ1?=
 =?utf-8?B?Z1lUVHBrYU9LUXNjRGV0RmtGdm5IclB5czBadjBFQUdTUzVOVU5iQlBnaWtu?=
 =?utf-8?B?MkZCNUFERnNIdGwrdkhSZitoLzk4Nk9LV2R4NG1nN3ZiY0xpZExLRGhSOERh?=
 =?utf-8?B?bkhzaVBIVENmb0NXRWRHZWNBYUZONXl6YnJ2OS9iOGtEV3N3djhneXpjSFNP?=
 =?utf-8?B?Q1doT0ZTNmh5RGdLZkNCam9lbGszenREUkN2d2hleldWMStoQUV6TDFtcVpk?=
 =?utf-8?B?dXJFakVEZDlLVC9DL1NOaWU1NVYrWWk1aDFvQ0VVUFlvZTIrbUlkcWNveTRS?=
 =?utf-8?B?Q3hETFNlc2hqd1RFa2UrV0dGb2VmSVN3VWZad0ZVZUE2OTZKWXBHYzlUcjZ1?=
 =?utf-8?B?M2dmbC9iTlFuZy90KzNXSWtNaEtENUhvWW9LcEZLNlduUHloeml3UzdHQzFE?=
 =?utf-8?B?bmRPdDhpVjVKb0lTV1JQaFI3ZThtRFZzUlVVckdZMUNhQ2FZL1dlLzhOOUpn?=
 =?utf-8?B?MWt3ZHNJTTQyTVd0WUhhenoxVlZVaXJINnc5WHB6c3hEOHFlVXhkMmd4VElt?=
 =?utf-8?B?NjJpaGNVZkFIZm1HUEUwOTB1OWlUN3M1VWxITmMwY3ExN2xuajRvQkc1anVY?=
 =?utf-8?B?dTB5aFZvQXVRaUpDaW9KS1FQd0ZSSWFhTktQeU55a005S2pmSzZQNElua05M?=
 =?utf-8?B?aCtjOUNmOVl2NDNBbDRzSHRpZ0dXZXByVVVRMEJOVWphT01VZmRRNC8zWXJI?=
 =?utf-8?B?YXVXZlQ0djl3NWZVeXdxeXFvMlM0NXp3aFVueXB2YysxWmdzZUluVlNic2JP?=
 =?utf-8?B?V0U4N2RPdGtXU2JERmhLTWZsanVBbVZVRWJMenB3ZnMzWGdRRUMxeG13VE4w?=
 =?utf-8?B?Q2hTdDZQOGtWNWtEQlRoVC9KTHZleGE0UUJFSzRPWDl4UGJnR0RMSWJVV2lo?=
 =?utf-8?B?cHNzQ3hlYlZ3RUJOenkzbmxtd3h4cUNXMmlwc1B0M0tHQytXV0VIMWhFR0lo?=
 =?utf-8?B?ajM0clZRNnd5OE5hMDRPd2pCaUJYMnFWRUxSS3gwbTFhRktNRWs1U1dQL1N3?=
 =?utf-8?B?eTFIZWREaEtmWnZsTU8vTStDVHlFTnVsOVFna1g3RDBXQnRiQWkzZmxhZ0pR?=
 =?utf-8?B?b2taMkwxdTBMMWFCMVJYalVBajFOdWF1VkhybG84OXBvOHJ4VDVPZExMeklX?=
 =?utf-8?B?dlJjMVkxeTEwc1I1Q0JsNHRTOXB3WjJ0WHNzYWdNandFS05CNTNQNjhkczRI?=
 =?utf-8?B?MUFxY2l1S2tCQlQyUGlDaU9wZ0ZLclBjRG9lRnQ4T0Y5T2liU3NVVUxWSTUx?=
 =?utf-8?Q?Xhjf1i6izi9ugC287S6PqoAKdV0DdVOq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWpvR0NsSWNMNHZlMm10SEYwMityeEVSTU50TWZ0b05DV3JiMTA4cDM1K0tv?=
 =?utf-8?B?bmJxb0RGSnp5bFdYaTFURzVTaUdldUhScXI1dTZOUEowb2tiUXR1YUNxZkkv?=
 =?utf-8?B?eHNPVXpsTWVmbk1RMDRuK1VHMXhPMmVNZEpKZGllMkR4WE43UjQ4WWpJZ0pS?=
 =?utf-8?B?VC9VL2ZuU2ZoRjcxK0JESVNWblB4NG9vNVN6VS9Jak9NL2RVd3pWUkxYMmxt?=
 =?utf-8?B?ZUJXbXpwUkk1OGJwYmR3MHhwZFhpQjNEMWFNbG1uVXFFTGlTQnFQV1Fyc3VN?=
 =?utf-8?B?dzFPMHhxV3BFWlZmU095dEVSckNlVU1mNlhwVWdaSkhTekUxVW5QSW92eEZl?=
 =?utf-8?B?RFpjd0VIWm5rR1hSajcwSXRNWUtYbUVUMVl4aEF2dUE2ejk3R25TRWlWaTh5?=
 =?utf-8?B?a3ZCL3ZjMmxiOS9ua3owNVFqZnR0SnlyTmFNQzI3NEcxM09EMmMyVGx4c3hG?=
 =?utf-8?B?Mzg4SzBEanI2R3NORzdFSWthbFFheHNTUmhMUVhNWnAvbVNOSUxUMmd2czFT?=
 =?utf-8?B?STFGY2FXK1Q4Q01HeXVYUnNpazRSMG1HT0ZUR1paWERLTW1XL2NSSFo0SW1x?=
 =?utf-8?B?bGROK05WTWU5QzJMUXNYYjl1L3pmcXJRYXFVT2pocytHdXVZWTBPTFNNY2tv?=
 =?utf-8?B?ci9GUW1XbEFyYTZWTHhrdUpkaURHTGUxK1hHekpTSGxYTzRaalBRYmdZbkRm?=
 =?utf-8?B?US9EWk5kVW4yNjZ0VTNjWTBjTGJ5c3RtbERKRjhsRmo0YXFja1BvSEp3ekRF?=
 =?utf-8?B?Z3cwVE05WU43Rk5aNEYrL3dJZ1ZGN0pzcDYwMythRnNBWXVsTS92WFdPc2tV?=
 =?utf-8?B?NnpMOElSbWtxZlFTRVBIMjVKeVA0SURYWEpBSXBDQjJpYmNza3AyOG5MSTkr?=
 =?utf-8?B?RTh1QS9SemxlTFEyQkR1M0JFcE1xS0tOMzFPbXNHM2Y5TzZxYUx4bkNrQlpN?=
 =?utf-8?B?cSt3RTlsVmkvQzZHNlZKZ2Z0VFNJb1h1RW9vWWFoRFlXVWdHN1VCdkFlNmFT?=
 =?utf-8?B?UGt1K0MvTUQycTRMbXByak9ocUdXeitnMVlPZm1oRWZGZnRYNTl3NytjcklP?=
 =?utf-8?B?YytIMHdyTEdKZWhIQ0lnMkw2b1lSVkJrWDhGLzRNOGVNQ1lmNWhZR3ZvamZM?=
 =?utf-8?B?T3U3TitlY2VjMHJHd09lckJ3bGNWVXhrOTBuQzBNVFZqV0VWRWZPQ2tYc1FG?=
 =?utf-8?B?VXlaR2tvcm1JTmxIUmhUM2QvUVdRS25DS0RLM3N0S0hSMzh5anMvMFhWcWFx?=
 =?utf-8?B?SEQ3UXZmckJvWStwYjVGVE9XKzEzK0VyNWdtM1JLQUhjK001OTFnYWlyK3Mz?=
 =?utf-8?B?NGY0Q2Nva1lKREtQbUNqbnRKeC9lOHlWYmNFUEhORzU0blMxWFU1VVB2OVgz?=
 =?utf-8?B?VWdZYVk1U1R4bEFQS0V0d25wSm5qbnEzeUFkblpMT0NkNGxUblZ5bklPdGpG?=
 =?utf-8?B?b0xuZFZOMFpPVVhiWFRRV0ttTld5ZUlaanI5ejNmUnpoU3ROQTdaN0Vveng1?=
 =?utf-8?B?R09ZS205TmMyalp6SmJQR2VjUG5Rb3RYY2xlUXNHWnVYWDNqVHI1bTF5T2Jv?=
 =?utf-8?B?RDdYR0VCbWZ5SFY1ZUt2cndLVVdlSXNUeU1RK25VOS9sVVBweHhVM2IwODBG?=
 =?utf-8?B?ZTdEdGFPenhhVnZBMG5Pd1Y2RzBGckxtR3ZwTjVLSnRTY21sdkdoeW1Rbnor?=
 =?utf-8?B?eDlncllUS0t4TzU4MnFtSFFZeHVVS0hScGN0K0Qwd3N6V2MzL3p6WE9oT29j?=
 =?utf-8?B?SHF2S0oxSEZRVnhoV0hpM0p1RG9pOUwzays4Slo1ZHVOVzA2d1NYKzl5L1Jh?=
 =?utf-8?B?a29tbFh1RUh0aVNnN3l0Ymg2VDRYWUlIWE5EbWV3ZkJQSmJFaTdPK09OZkNC?=
 =?utf-8?B?S3hqL3VPSENZQnFsekUrRnJzZEVySzZkUngxQmVRMHVWdnVFWk80N001QTQ0?=
 =?utf-8?B?UFgxRUlWYUpZTGZXWi95Y0wvVlJ1cHZQNlVXamNLWm0xT3hwenpEbUNvQXdE?=
 =?utf-8?B?UEYrcmZJM0JGNXFJc0ZmcTR3bE95dm9QUmlqQlNucGJZV0ZUM0M2WHRSb1Ja?=
 =?utf-8?B?YlJrSmtLQ2xXZTE5NmNkZ2VOazcxKzdxdS96dGhEY1pKWW9uYVRyRGRzbEoz?=
 =?utf-8?Q?UV08rGlgwTFMaZVgPOVacJPHE?=
Content-Type: multipart/alternative;
 boundary="_000_2747EE84307349B89B14A4E4B08E5255nvidiacom_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bf2dd8-0c81-4feb-96ee-08dd45f28567
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 14:36:47.8733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbt5DPpPyQv4FNiiBfiW0bSbmaSkyB6I4vGNlWfGoxCN7awIZ+jeITBXV3aVYBcsW8Z2UKKqALzvpsGkLqezYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
Received-SPF: softfail client-ip=2a01:111:f403:2415::616;
 envelope-from=mochs@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_2747EE84307349B89B14A4E4B08E5255nvidiacom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRmViIDQsIDIwMjUsIGF0IDExOjA44oCvUE0sIEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5j
b20+IHdyb3RlOg0KDQpPbiAyLzUvMjUgMjoxOSBQTSwgTWF0dGhldyBSLiBPY2hzIHdyb3RlOg0K
VGhlIE1NSU8gcmVnaW9uIHNpemUgcmVxdWlyZWQgdG8gc3VwcG9ydCB2aXJ0dWFsaXplZCBlbnZp
cm9ubWVudHMgd2l0aA0KbGFyZ2UgUENJIEJBUiByZWdpb25zIGNhbiBleGNlZWQgdGhlIGhhcmRj
b2RlZCBsaW1pdCBjb25maWd1cmVkIGluIFFFTVUuDQpGb3IgZXhhbXBsZSwgYSBWTSB3aXRoIG11
bHRpcGxlIE5WSURJQSBHcmFjZS1Ib3BwZXIgR1BVcyBwYXNzZWQgdGhyb3VnaA0KcmVxdWlyZXMg
bW9yZSBNTUlPIG1lbW9yeSB0aGFuIHRoZSBhbW91bnQgcHJvdmlkZWQgYnkgVklSVF9ISUdIX1BD
SUVfTU1JTw0KKGN1cnJlbnRseSA1MTJHQikuIEluc3RlYWQgb2YgdXBkYXRpbmcgVklSVF9ISUdI
X1BDSUVfTU1JTywgaW50cm9kdWNlIGENCm5ldyBwYXJhbWV0ZXIsIGhpZ2htZW0tbW1pby1zaXpl
LCB0aGF0IHNwZWNpZmllcyB0aGUgTU1JTyBzaXplIHJlcXVpcmVkDQp0byBzdXBwb3J0IHRoZSBW
TSBjb25maWd1cmF0aW9uLg0KRXhhbXBsZSB1c2FnZSB3aXRoIDFUQiBNTUlPIHJlZ2lvbiBzaXpl
Og0KLW1hY2hpbmUgdmlydCxnaWMtdmVyc2lvbj0zLGhpZ2htZW0tbW1pby1zaXplPTFUDQpTaWdu
ZWQtb2ZmLWJ5OiBNYXR0aGV3IFIuIE9jaHMgPG1vY2hzQG52aWRpYS5jb20+DQotLS0NCnYyOiAt
IEFkZCB1bml0IHN1ZmZpeCB0byBleGFtcGxlIGluIGNvbW1pdCBtZXNzYWdlDQogICAgLSBVc2Ug
ZXhpc3RpbmcgImhpZ2ggbWVtb3J5IHJlZ2lvbiIgdGVybWlub2xvZ3kNCiAgICAtIFJlc29sdmUg
bWlub3IgYnJhY2VzIG5pdA0KIGRvY3Mvc3lzdGVtL2FybS92aXJ0LnJzdCB8ICA0ICsrKysNCiBo
dy9hcm0vdmlydC5jICAgICAgICAgICAgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KDQpXaXRoIHRo
ZSBmb2xsb3dpbmcgbml0cGljayBhZGRyZXNzZWQ6DQoNClJldmlld2VkLWJ5OiBHYXZpbiBTaGFu
IDxnc2hhbkByZWRoYXQuY29tPG1haWx0bzpnc2hhbkByZWRoYXQuY29tPj4NCg0KVGhhbmtzIEdh
dmluLCBJIHdpbGwgY29ycmVjdCB0aGUgZGVzY3JpcHRpb24gaW4gdjMuDQoNCg==

--_000_2747EE84307349B89B14A4E4B08E5255nvidiacom_
Content-Type: text/html; charset="utf-8"
Content-ID: <F7DC69C832FE7048A86CC6FAEFE43177@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJvdmVyZmxv
dy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6
IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQo8ZGl2Pg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+DQo8
ZGl2Pk9uIEZlYiA0LCAyMDI1LCBhdCAxMTowOOKAr1BNLCBHYXZpbiBTaGFuICZsdDtnc2hhbkBy
ZWRoYXQuY29tJmd0OyB3cm90ZTo8L2Rpdj4NCjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2Ut
bmV3bGluZSI+DQo8ZGl2PjxzcGFuIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDApOyBm
b250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBmb250LXNpemU6IDE0cHg7IGZvbnQtc3R5
bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IDQwMDsg
bGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAw
cHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXNwYWNp
bmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246
IG5vbmU7IGZsb2F0OiBub25lOyBkaXNwbGF5OiBpbmxpbmUgIWltcG9ydGFudDsiPk9uDQogMi81
LzI1IDI6MTkgUE0sIE1hdHRoZXcgUi4gT2NocyB3cm90ZTo8L3NwYW4+PGJyIHN0eWxlPSJjYXJl
dC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBm
b250LXNpemU6IDE0cHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5v
cm1hbDsgZm9udC13ZWlnaHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGln
bjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1z
cGFjZTogbm9ybWFsOyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0
aDogMHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7Ij4NCjxibG9ja3F1b3RlIHR5cGU9ImNpdGUi
IHN0eWxlPSJmb250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBmb250LXNpemU6IDE0cHg7
IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWln
aHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgb3JwaGFuczogYXV0bzsgdGV4dC1hbGln
bjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1z
cGFjZTogbm9ybWFsOyB3aWRvd3M6IGF1dG87IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRl
eHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiPg0KVGhlIE1NSU8g
cmVnaW9uIHNpemUgcmVxdWlyZWQgdG8gc3VwcG9ydCB2aXJ0dWFsaXplZCBlbnZpcm9ubWVudHMg
d2l0aDxicj4NCmxhcmdlIFBDSSBCQVIgcmVnaW9ucyBjYW4gZXhjZWVkIHRoZSBoYXJkY29kZWQg
bGltaXQgY29uZmlndXJlZCBpbiBRRU1VLjxicj4NCkZvciBleGFtcGxlLCBhIFZNIHdpdGggbXVs
dGlwbGUgTlZJRElBIEdyYWNlLUhvcHBlciBHUFVzIHBhc3NlZCB0aHJvdWdoPGJyPg0KcmVxdWly
ZXMgbW9yZSBNTUlPIG1lbW9yeSB0aGFuIHRoZSBhbW91bnQgcHJvdmlkZWQgYnkgVklSVF9ISUdI
X1BDSUVfTU1JTzxicj4NCihjdXJyZW50bHkgNTEyR0IpLiBJbnN0ZWFkIG9mIHVwZGF0aW5nIFZJ
UlRfSElHSF9QQ0lFX01NSU8sIGludHJvZHVjZSBhPGJyPg0KbmV3IHBhcmFtZXRlciwgaGlnaG1l
bS1tbWlvLXNpemUsIHRoYXQgc3BlY2lmaWVzIHRoZSBNTUlPIHNpemUgcmVxdWlyZWQ8YnI+DQp0
byBzdXBwb3J0IHRoZSBWTSBjb25maWd1cmF0aW9uLjxicj4NCkV4YW1wbGUgdXNhZ2Ugd2l0aCAx
VEIgTU1JTyByZWdpb24gc2l6ZTo8YnI+DQo8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTogcHJlOyI+PC9zcGFuPi1tYWNoaW5lIHZpcnQsZ2ljLXZlcnNpb249
MyxoaWdobWVtLW1taW8tc2l6ZT0xVDxicj4NClNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgUi4gT2No
cyAmbHQ7bW9jaHNAbnZpZGlhLmNvbSZndDs8YnI+DQotLS08YnI+DQp2MjogLSBBZGQgdW5pdCBz
dWZmaXggdG8gZXhhbXBsZSBpbiBjb21taXQgbWVzc2FnZTxicj4NCiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOy0gVXNlIGV4aXN0aW5nICZxdW90O2hpZ2ggbWVtb3J5IHJlZ2lvbiZxdW90OyB0ZXJt
aW5vbG9neTxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy0gUmVzb2x2ZSBtaW5vciBicmFj
ZXMgbml0PGJyPg0KJm5ic3A7ZG9jcy9zeXN0ZW0vYXJtL3ZpcnQucnN0IHwgJm5ic3A7NCArKysr
PGJyPg0KJm5ic3A7aHcvYXJtL3ZpcnQuYyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8IDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrPGJyPg0KJm5ic3A7MiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNl
cnRpb25zKCspPGJyPg0KPC9ibG9ja3F1b3RlPg0KPGJyIHN0eWxlPSJjYXJldC1jb2xvcjogcmdi
KDAsIDAsIDApOyBmb250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBmb250LXNpemU6IDE0
cHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13
ZWlnaHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRl
eHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFs
OyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0
LWRlY29yYXRpb246IG5vbmU7Ij4NCjxzcGFuIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAs
IDApOyBmb250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBmb250LXNpemU6IDE0cHg7IGZv
bnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6
IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5k
ZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3Jk
LXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29y
YXRpb246IG5vbmU7IGZsb2F0OiBub25lOyBkaXNwbGF5OiBpbmxpbmUgIWltcG9ydGFudDsiPldp
dGgNCiB0aGUgZm9sbG93aW5nIG5pdHBpY2sgYWRkcmVzc2VkOjwvc3Bhbj48YnIgc3R5bGU9ImNh
cmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBOVklESUFTYW5zLVJlZ3VsYXI7
IGZvbnQtc2l6ZTogMTRweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczog
bm9ybWFsOyBmb250LXdlaWdodDogNDAwOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0ZXh0LWFs
aWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRl
LXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdp
ZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiPg0KPGJyIHN0eWxlPSJjYXJldC1jb2xv
cjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBmb250LXNp
emU6IDE0cHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsg
Zm9udC13ZWlnaHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3Rh
cnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTog
bm9ybWFsOyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4
OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7Ij4NCjxzcGFuIHN0eWxlPSJjYXJldC1jb2xvcjogcmdi
KDAsIDAsIDApOyBmb250LWZhbWlseTogTlZJRElBU2Fucy1SZWd1bGFyOyBmb250LXNpemU6IDE0
cHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13
ZWlnaHQ6IDQwMDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRl
eHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFs
OyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0
LWRlY29yYXRpb246IG5vbmU7IGZsb2F0OiBub25lOyBkaXNwbGF5OiBpbmxpbmUgIWltcG9ydGFu
dDsiPlJldmlld2VkLWJ5Og0KIEdhdmluIFNoYW4gJmx0Ozwvc3Bhbj48YSBocmVmPSJtYWlsdG86
Z3NoYW5AcmVkaGF0LmNvbSIgc3R5bGU9ImZvbnQtZmFtaWx5OiBOVklESUFTYW5zLVJlZ3VsYXI7
IGZvbnQtc2l6ZTogMTRweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczog
bm9ybWFsOyBmb250LXdlaWdodDogNDAwOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyBvcnBoYW5z
OiBhdXRvOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zv
cm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdpZG93czogYXV0bzsgd29yZC1zcGFjaW5n
OiAwcHg7IC13ZWJraXQtdGV4dC1zdHJva2Utd2lkdGg6IDBweDsiPmdzaGFuQHJlZGhhdC5jb208
L2E+PHNwYW4gc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBO
VklESUFTYW5zLVJlZ3VsYXI7IGZvbnQtc2l6ZTogMTRweDsgZm9udC1zdHlsZTogbm9ybWFsOyBm
b250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogNDAwOyBsZXR0ZXItc3BhY2lu
Zzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFu
c2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Vi
a2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsgZmxvYXQ6
IG5vbmU7IGRpc3BsYXk6IGlubGluZSAhaW1wb3J0YW50OyI+Jmd0Ozwvc3Bhbj48YnIgc3R5bGU9
ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBOVklESUFTYW5zLVJlZ3Vs
YXI7IGZvbnQtc2l6ZTogMTRweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fw
czogbm9ybWFsOyBmb250LXdlaWdodDogNDAwOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0ZXh0
LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdo
aXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tl
LXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiPg0KPC9kaXY+DQo8L2Jsb2NrcXVv
dGU+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KVGhhbmtzIEdhdmluLCBJIHdpbGwgY29ycmVjdCB0aGUg
ZGVzY3JpcHRpb24gaW4gdjMuPC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9o
dG1sPg0K

--_000_2747EE84307349B89B14A4E4B08E5255nvidiacom_--

