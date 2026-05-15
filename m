Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F0CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 07:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnON-0004CU-1B; Fri, 15 May 2026 03:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNnOL-0004AW-LH; Fri, 15 May 2026 03:55:29 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNnOJ-00076P-P5; Fri, 15 May 2026 03:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEAaEamBuvLWq2Y3103JgragpFBEWyp7uTqxjjNkGrgPsXtuINuIYAkBHTfEOWkg2dchnaUNpux9FadEKQKHIQIlOQOAdg20SF5JqWA76zrA75rkcehSKzTsbJ4pH/GTUkMLAZ1rFxzaRv6VVa80pJ9+v8YlWc/ko1TqwvsqP83fwJEAC4ZFcA3mJxJsov7t9nug+jPI8BV9beNI2ld3q+B9jjeYe1/QT6ZBPIFXFX5WhAlC8k5W5BbN96EV5mXAEbiiBJtrU1g004ZVgMrVqAzKFrLvY9vF8ZKxOQq7xofgiqNuRBPjf5kl37RolM2xftBGDs3N4fptMxsINHV0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dre2rZyODTsJ8cCdJlrbOzrCSnB5OIq+QnvfuwpRnYQ=;
 b=Fhg/0NuPXQIrgx9fUEp04w526W4v2qwQG/wypU68nGZhp1CZki1tQTW508XXp2C6BZb9984Xcz8LgsPxROLZ+6u6jXQVuJbD/IAFNZjzWf/gv5Yqxvs5vQyXWQv0C28K/oBiObk1hPTDpqLsUss4/9bv470fhYSTtoejvPPiLMCwmvXsiE3oqgx2c4SRsAYeXQUjBy0z4WnXKOWVorfxR2TdU83LHmAyhep0A4qyyG0eImNU/XTPrAchsrOHtgyY1Riq/bWSGdJU1b1HDW53uqYfl4BUpV+3lDDJEsBb2Yu1lm4Pse98QtORUgE6B0l/sjZoS9BFh10MYgrsrvxRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dre2rZyODTsJ8cCdJlrbOzrCSnB5OIq+QnvfuwpRnYQ=;
 b=qRIVCmlzouKEtocpN6nFJhHL1rOo0KAyGrTUqgMBbUDeB9zqQYog4/s8XYZ9d39dZ41egnflOWUzUR/VuKCa2gtJg7+ePAwRePFcPY4CoXUvDOTOK6Sge5nhg+R5TheIy2XQSMQx7br+cX59xYCmN3LH3heqnsVHTH1h3ZkRg5nOffkUkOg71AArFwDFYeQPX5Kqopu96bAtMwJc1rfqJaI8Rjuxj5U/V/Am5d3iGaqXa0CRCImmwx/oyQsxc3/Mvn+NsjmwiA7LTQQWy2VniKEbkT0l458co2Lp4T5C1FFFJ7c6Wn+9ys7EyG716jzyZaZW9edsNJSY0mOxNYPINQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 07:55:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 07:55:18 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
Thread-Topic: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
Thread-Index: AQHc4kaIKC7DjtHfhUOSgnIS3G+/RrYNkQ6wgABktQCAAMTaEA==
Date: Fri, 15 May 2026 07:55:18 +0000
Message-ID: <CH3PR12MB75482526F3E2B515168A1E16AB042@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-3-nathanc@nvidia.com>
 <CH3PR12MB75488C9306659D939ACEE203AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
 <cb3f2ace-be0d-4b5a-ad3e-9de541a2444a@nvidia.com>
In-Reply-To: <cb3f2ace-be0d-4b5a-ad3e-9de541a2444a@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY1PR12MB9700:EE_
x-ms-office365-filtering-correlation-id: 2fd3b147-f511-446a-ba9c-08deb2574ece
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|3023799003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info: hqRmEtKY3r4z+MJkN45GRh68+JaNa0brKq/74KlIPJctBnYP533BC8b/xwpjAhNYJZFPGY6NybgqXh8o3AL/+6nALxBAjHgpIohe6w6Wueyf8qY/6WSii7ffgBmlMe2W4oJJoDUJ/fRWsPmhLlCIoetkZ3tfpRmcYnrYzvsgGW/XessPFxHyUJThp/BOWYbSnuL95lxZF1n7JRCHZq3xOnInrLBVLt2dAHSlkEaMlpRER28a3Fd4bLXWMm27Lt7U0qEPFJba4hKnxURmV4z9xLoiuE8KgBqoeKNaHuEosPBkw4ixp0xwS6sdDYvqnejSXXZ9c5E4/1vz8x8CPerbED5ca08ROdz6gsGXzt+iQGSZ0mAY/UzlMErOUdaS9Q/apow16rUh3O90pgS9w/Fa9YPvl80WuEIIdIb8bLqzVV9J5ca32DEhmzj0RXZpzXaMmEoj3Lk0vbwTOnKVtXaZ1dnQmCOuFZXmWDheFHX3+a76V5UucYDEnYWkPfOKBRsmbFunScy2wrJ8nQERDGd7hiqr/o3ZyFFf+a+hkIGBoFUCyildphvPqtMGF9YUfmGNaee8/WbZ4o8ug99I3XKTUQNYVbLlb37v16zZspBqfqTJoJSK2yVqPZaFkaSQ7Q9ZXsBX6JbQ4WwJdZ44CrnVLpTKBFiVGQun9lNY7m4f1FC6cXSNNB4F9sE8dtXtKUk+ap3yefiB3TyDVWEtctUKXN9HbvmT54B33QPCCL/zWg+Ht8LLcPHRjcT7AZuXBgb2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(3023799003)(38070700021)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGpBclM5ZlFKeGpBdW9aZG1IZ3A0K1dJQVZQUERZZFJDN25UVjByVFNiVHdT?=
 =?utf-8?B?RllGRzlVM2QxSndZSENJSWN1azNNSS9HVG1wTTU4MDIxbmZ6UzJwcWc5Yzhj?=
 =?utf-8?B?dmhYOUJRM1NhbHQ3bG55c015OGV2SFU2M3FsZ3FtdXhOVFZ3OFFHUXhQSlJ5?=
 =?utf-8?B?T1p2eGdSYWh4TkZVanB5WkVmcnh6TURIb25iWlpFcDRTejQzSmxLcDJZMjUw?=
 =?utf-8?B?TExMSFNSdVBNQnlZYU1INk9YQWlYZUY1SUJkbkhWQk81TzE4NFhuT1M5NDVX?=
 =?utf-8?B?ODd0T0hId3NzTjNMb0Y2eXdLUFFrb2xzZjgzbXR5eHZsSEkrZzNYYXBKRWVp?=
 =?utf-8?B?ejNQRTFXWm5pL0FQVGpWWG1ST1E2QU8rT0N4cEZzaXVEZytRMmMzNUJrdzVn?=
 =?utf-8?B?Ukt4VUZoM1hkK01yYW13K0VOcno3SEE3S2JiK05tUGZ1YVVHdTNpVmw1Z3BW?=
 =?utf-8?B?eTJnQ3djVklMS1JmWXBFV0NPUnRLc3BDa1A3eVRqZUNuK0gwS0o5dnNUS3FI?=
 =?utf-8?B?Q0Q2QmhCV1RENU1YeU8wMzBDc3RhZmEzV1hBM2xYYm5PWjk1MHB1WExuQnJl?=
 =?utf-8?B?QXQ5MlVrelVNbGliSmpyYmovMVpvR1EzcTVhYmNNYnhMcllkZEJJaGlzRnFP?=
 =?utf-8?B?aldKZGVkWjFtRVBVeFI0bnZ1WU01TERldmFPaER5N3V2akpxV1E4aTcyN3k3?=
 =?utf-8?B?ZTFjV2dQTzFDcUxEbjBpRWwxQ0F3WnpGR1MrVldQUm9leFpVR0IzSjRIOW9M?=
 =?utf-8?B?ajlkS293MWdacnZMazF0eTZEak0xaC9ZdVVqcW80clhtRDViV2xiNnBQQzFr?=
 =?utf-8?B?amdrcDE0eVdleVpJMlVIV09qN3pxWFFxb1FzK0JnN2NQSGtOTFNOTFpvM3Z0?=
 =?utf-8?B?VmNTS2N6ZTNUTlpyY3RtS213MjgyM2pJYlhHV0dEWit6MmtOTVVmNDNmT2I5?=
 =?utf-8?B?a3BiV05VQlo3Mm9lMWtlYk5NOUQ4aTVvZFIvM1V2V0NlZTdVbDluZzlmS3cv?=
 =?utf-8?B?aGFQSlVqN2h4RFJjTmhUa0c2MlovUFhuVkVQem45TnhzYzFhbklxNDR4bFNS?=
 =?utf-8?B?d2gwSUhrVk1HSWtocWU0OHBaMjQyNE52ZjR1WFJtM0YzMmtXSUg3NXdNZWE1?=
 =?utf-8?B?MnNIVVdLQlJnVy8zU1FSdEM5eDZhR2hIamhjWFVEb3pub1BKYnJ6QnZ5cmFQ?=
 =?utf-8?B?QnNlUDR4NVo3TW9LYzhuMWFPK3IyV0x3NkFVQ05LSzdCaUp6Mm03RDdpYWZr?=
 =?utf-8?B?WllGeTdjdlplSUN0WThURW1YTHR1ZFJOYitTVHRsbFZmUkNqWVFVOFBzTFhy?=
 =?utf-8?B?YUdDNmZJUkpwMG1FdGJJV014QkdhU3VVQ2ZudzdRbmN1VDFYNHFnZlQ4dXZ6?=
 =?utf-8?B?TityeDdDN3grTUUrazVFRFRpU3Zad3dFMUlWaWhscHFnOUthSmJIT2Q1bkJL?=
 =?utf-8?B?U1ZlNEdqRnNnZ3AyUG0rbGR1TkUzVFdTQnQ3amY3UXVoQnVJOHRHcUN2WGR4?=
 =?utf-8?B?S0FLYlIxSng5a0hZWVA5M1NuU1d6NGRjb2UxWWV1NmdoOWlJWE90WWZ1Ly9w?=
 =?utf-8?B?OFYzMm5PVlBnZmtmVjY3a0p0bFJnTnFXZVZuVFZvZDFkeUNCZTNLSWd6NGZj?=
 =?utf-8?B?aG03d0hZbVN3VGg0anRrc2ZnYkZ3MStQeWQrQ29EM0p0SkdwTTErYW1oTHhv?=
 =?utf-8?B?Y1RWNXd1dWdUMFJQZElWMXN6WkFhQnBKWDRhMjFSVmRHT3Qyd09GR1ZtMUtz?=
 =?utf-8?B?dlRSZURxYTlEcS9KUjVyeE1MdUgzdDZsdStadStJKzY3UXpiNzkrVEpSc1Vz?=
 =?utf-8?B?Mm9qclh4M3hTdnQ2OGtQejNTRzNxVlpCdU5INkd0aFpXY3NmbmUwUG55eDNs?=
 =?utf-8?B?SDU5Q3pCaXc3cGtJSzlHTml2Z05YU1d1aU9WT1AzTEJlVEk4VjVFUHUycmc4?=
 =?utf-8?B?QncwakxGdEhLdnpnYTI2ZkRMZ3VkejJUQmR1Sy9VVm5xYWExRm1xdE5LRHFR?=
 =?utf-8?B?RXVuMW10VTl1cVdRa05jQkVoS1R5c2FsVG5xeW9rYUdlbjdGdVlJcE9GY1Br?=
 =?utf-8?B?RWw5Y3RlUjkzdTNJeXFlTGNEOVo4SDZQbGJkcDZ3M0VKN2M5K0NyZWp2MVpT?=
 =?utf-8?B?emJoRjU5QnVPNnV3LzYyVFk4UFYyTytNUlM1ZFFsOE1mZDZOWXBieWczcHJW?=
 =?utf-8?B?M3NYT2szK1dSM0NiMkxCaG8xOENzZERmdzF6c0xqN2ZDOGlsQ3B3VnNNTXlj?=
 =?utf-8?B?WWgrUmRSdXVEblF1YzNQM01rdkx0YlNHam9wVjhob2VPM3JDMnFpZ1BLVkM1?=
 =?utf-8?B?NEN2bjZNdXkzaHJ6ZEpWdWI1U20rczlpRkZGNUdmaXhydk9xYmJMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd3b147-f511-446a-ba9c-08deb2574ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 07:55:18.6974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJ0E4wCo37SDNmJRed/UaDclpJ86vW3lEE3X1OyypEGXb7SWiTJarr1Q/eJM2jVwuAZ03sN4u+y+xEPIIp2bKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoZW4gPG5h
dGhhbmNAbnZpZGlhLmNvbT4NCj4gU2VudDogMTQgTWF5IDIwMjYgMjE6MDcNCj4gVG86IFNoYW1l
ZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsNCj4g
WmhhbyBMaXUgPHpoYW8xLmxpdUBpbnRlbC5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5j
b20+OyBOaWNvbGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMi83XSBody9hcm0vc21tdXYzLWFjY2VsOiBJbXBsZW1lbnQgImF1dG8iIHZh
bHVlDQo+IGZvciAiYXRzIg0KDQpbLi4uXQ0KIA0KPiA+PiAgICAgICBvYmplY3RfY2xhc3NfcHJv
cGVydHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAib2FzIiwNCj4gPj4gICAgICAgICAgICJTcGVj
aWZ5IE91dHB1dCBBZGRyZXNzIFNpemUgKGZvciBhY2NlbD1vbikuIFN1cHBvcnRlZCB2YWx1ZXMg
Ig0KPiA+PiAgICAgICAgICAgImFyZSA0NCBvciA0OCBiaXRzLiBEZWZhdWx0cyB0byA0NCBiaXRz
LiBvYXM9YXV0byBpcyBub3QgIg0KPiA+IEluIHNtbXV2My5jIHdlIGhhdmU7DQo+ID4NCj4gPiBj
YXNlIFNNTVVfQ01EX0FUQ19JTlY6DQo+ID4gICAgICAgICAgew0KPiA+ICAgICAgICAgICAgICBT
TU1VRGV2aWNlICpzZGV2ID0gc21tdV9maW5kX3NkZXYoYnMsIENNRF9TSUQoJmNtZCkpOw0KPiA+
DQo+ID4gICAgICAgICAgICAgIGlmICghc2RldiB8fCAhcy0+YXRzKSB7DQo+ID4gICAgICAgICAg
ICAgICAgICB0cmFjZV9zbW11djNfdW5oYW5kbGVkX2NtZCh0eXBlKTsNCj4gPiAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgICAgICAg
aWYgKCFzbW11djNfYWNjZWxfaXNzdWVfaW52X2NtZChzLCAmY21kLCBzZGV2LCBlcnJwKSkgew0K
PiA+ICAgICAgICAgICAgICAgICAgY21kX2Vycm9yID0gU01NVV9DRVJST1JfSUxMOw0KPiA+ICAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gVGhlIGFib3ZlICFzLT5hdHMgd2ls
bCBiZSB0cnVlIGZvciBBVVRPIGNhc2UsIHJpZ2h0PyBJIHRoaW5rDQo+ID4gd2Ugc2hvdWxkIGNo
YW5nZSB0aGUgYWJvdmUgY2hlY2sgd2l0aCBzbW11djNfYXRzX2VuYWJsZWQoKS4NCj4gPg0KPiA+
IEFsc28sIHNpbmNlIHdlIG1vZGlmaWVkIHRoZSBhdHMgdG8gT25PZmZBdXRvIGluIHRoZSBwcmV2
aW91cw0KPiA+IHNlcmllcywgSSBhbSBub3Qgc3VyZSB0aGUgYWJvdmUgc2hvdWxkIGJlIGEgZml4
IHBhdGNoIG9yIG5vdC4NCj4gSSBzZWUsIEkgd2lsbCB1c2Ugc21tdXYzX2F0c19lbmFibGVkKCkg
aGVyZSB0byBhY2NvdW50IGZvciB0aGUgQVVUTw0KPiBjYXNlLiBJIGFtIG5vdCBzdXJlIGlmIGl0
IHNob3VsZCBoYXZlIHRoZSBGaXhlcyB0YWcgZWl0aGVyIGJ1dCBsZXQncyBzZWUNCj4gaWYgd2Ug
Y2FuIGdldCBhbnkgZ3VpZGFuY2Ugb24gdGhhdCBwb2ludC4NCg0KVGhlIGRlZmF1bHQgYXRzIHdp
dGggcHJldmlvdXMgc2VyaWVzIGlzIE9OX09GRl9BVVRPX09GRig9MikuIFNvIGV2ZW4NCmlmIGF0
cyBpcyBub3QgdmlzaWJsZSB0byBndWVzdCwgYSBtYWxpY2lvdXMgZ3Vlc3QgaXNzdWluZyBhdHMg
bWF5IGVuZCB1cA0KZ2V0dGluZyBmb3J3YXJkZWQgdG8gaG9zdC4gU28sIEkgdGhpbmsgd2Ugc2hv
dWxkIGZpeCBpdC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg0K

