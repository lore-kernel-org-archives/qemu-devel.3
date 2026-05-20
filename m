Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9DACD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPapF-0000Gb-BB; Wed, 20 May 2026 02:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPaon-0008E2-KX; Wed, 20 May 2026 02:54:14 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPaol-0003Z7-Em; Wed, 20 May 2026 02:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHgl6O9ByNlZ42zs6BNLxa9GKTpjaQKOT4R/W7SXo8CeQRJ8Ea4gHjhl9cw6ritErlZaPvykulNnSoiEKbQa//bzrECkTfu/GX7Mni7laKq886qI++dTmsHSaWXwoHyM8Fe2Hp3yvXgr8sRU3TID6guOuSw3u0gML9eLSJLFf4aQ5ywtgMARjduLlotrYTlwi5AwdA8qF0GPWjULYyxMHeobKplgTG8QAztZqyi95NAeeuvno5s8Q4SWbdVhj7VvXjcPc0J0mvDolQJfi5Msl+WzuWoifcLsIJ1Mg5sUnh27i64heLKA68T4fAorxI9SGM9YiB0BXKspBzBo7wVpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaABLRSFNTURS5XyP2YboLUsMdnEEVfAINxECzbOiyA=;
 b=SPnpQZS+CNRmNdDv3Tm/+KX1PIinzPIO4IC4/WZLZQq7fhyE21Pcgr7T5+MtTovl7BTWZNLc1H0HPY0u9h7zw9RnQ10ufYSOIpmkrNeJENKpYCx+m+C+cjlAVXW5eBZjNFwbUidpscZQUmtflXDGgcexb5tN75hUYmslJIK+/HrPHaUKkCuqWcTbt1nRzDHLuOcU40epepKt1n0UXB2agk0ciFa2MrgNcyucfeEn/Yhqc1+0uYTZGb9iAPq5C09tm7/ge9LyYj5fqcK0aoMsiF7JB+7UHcTFd9fvef/KxDbrJFmjBKJD5tf5mJj3kzB695WzW0UEHw8lV/IzPMfKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaABLRSFNTURS5XyP2YboLUsMdnEEVfAINxECzbOiyA=;
 b=KMHrxBin5nRKPIpz8lKU6BDX9gjHh8tDjmMNCbm135i+VYalNiNnP2XedF+GVae+Lkdyl08bmJxgcwOGXIKqrflmRsOToGloOL97eeVrc630NBXGenriRfzsrlDGiMx1QIV1YHbUe0Sk9uVRCg+H0xDxzXAwF4FE4BRZJkEDJsUtEZVfNBTTofxOgSFtVDCMpCNzD5FV7kFfuNy1dG4rzvWjPG5kdksmtwnYcTrB+JotTETWgo+zK3Nhxko10QmLBCDSQd6SkzoC1ohzZG0Q9N3YZcFaPJYm+E03Ako5OrBrNq6vyCF7vvr8Fi8SQOHlTUoJzSz4z9WiaDYcsfbkRQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:53:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 06:53:56 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 15/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 reads
Thread-Topic: [PATCH v5 15/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 reads
Thread-Index: AQHc53vN+weCT1tSl0yA2GeyFGmDq7YWaaWAgAARXeA=
Date: Wed, 20 May 2026 06:53:55 +0000
Message-ID: <CH3PR12MB75480E94D997D5B881979ACFAB012@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-16-skolothumtho@nvidia.com>
 <7a96fe4f-a42b-44d7-b0e1-d767c42f4eb8@redhat.com>
In-Reply-To: <7a96fe4f-a42b-44d7-b0e1-d767c42f4eb8@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ0PR12MB7068:EE_
x-ms-office365-filtering-correlation-id: c7889da8-7f40-4a50-765f-08deb63c8fc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: qYAddqkKhEeq247ymVwaZp5wqOw20zoQERxfGdKiT7BoYVXYZ1s0CKPjHxOALJ8AAeeVWBtsnEpUbUPNx9cZBQHrCVMQLbn8Y16PwrpeD4TRv6efZBupDi8805SOktMGkKTcDlFjvRem8gm9CBqrEQ9z0xC7jCJCfdT3yt3uUD/E6oHlVgT3RYvX9t4CS4Pg1EW2z9mpR5mSfF0Eb0r5ssHjDLB0IHNGUa4s5hL0n1sHl3/yP9wLDqKnZDuAM9nlOESc9d43l95wS/PIsL+OgrjGnVtMyWozbC/bcgXzxxgKBRuaqd6YUZJaXoknffxnC3BfMeAEvZqyiNvYBC6k1/hWGDavtBPcePHBIS5hdNUmbP5TuJqC26bPw8x9+Z80hCtKuiZWvtL62lnamN4ncT/4C0jtcPdL3go/Q95VA/yEBh4mCpI5NsYdjZ+p6GgjKfiKI0GGdYWPSJcxjWYLv8RGiAzY+RSi0YlwzcPLYeJyC0w8zQ9eEoTj1JHitRfeE0FBPKo6yle/IDlEkhxnkOHiLRybF6GGdEjvWgxQkQJ0hvzeZGR4pphzKorvBGty2Mz6PBM23wcj5zR8ZjkrDkwJ3dh94gRKf2qzCCoctUI7sW29JbkBoXSlIkPYVUoxriHwzWvPulnHvHiQ29cshg3so79NWcmxZIOftujICn9CpedtSbJwnxIe8BiXA0NOGpzGPhpnVGHH8nIFkqf9/eHBIia9oiB417Nz/XrJF2thR8MzYweayOXFHcSZHv/H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amNXdUJTMFhHMGtQdVA3b0hBNnlpdEFFc0xjYnpISU1qMHlYTE1uenZPRjFU?=
 =?utf-8?B?OEp2aEZaQUpvRFRBVFZlMHFvWFFqVDFMZnpvWWRUZTJSSFo1bS85dWFaWUN3?=
 =?utf-8?B?YjdxR2hiZUptZVI5YS9CU0NqWGtreStZZStrSG13bU9va0E3M0h1WXBjcURF?=
 =?utf-8?B?aWRLYXJ6S3E2VHlzbFN3cG40aWxHd1N5ZzQxQVhuZDVtSEZuWC9RbWExVzB5?=
 =?utf-8?B?VUhsUEhOWVpMcGVUZ2wvOFJBTHQrY2RmQ3FlYlRFUkVpbGlsdTFJbjFZdmV0?=
 =?utf-8?B?QmR5VGVuZGptZ1RTcEhNbVUwNjF0Y3BmeGJmamsydGhDUUhlNFBXaEdGTjNW?=
 =?utf-8?B?Z01uNEw4dEg2aVFmRXJJV1FBN21rSG1sRUZ6NGpPZW9rb20wRExwdVJBLzhO?=
 =?utf-8?B?OGFBZVNudFlwT0JaNXlEc2NSVk1jUHlGbW5hVDRrNEpJZ1dyQy93eHI5RkxE?=
 =?utf-8?B?N21DQVNvbFh3eE5YS3FxRUNHSG9mOCtPS3VKS0FDeGlPcUlNK1pFdHNHTlp3?=
 =?utf-8?B?RGo1Um41b2lVMXp2Q3BXbjNQWnJHTFd6V0VPaFYvOStPNCtNZExoTzdueHFx?=
 =?utf-8?B?ekJlWEpZNjJEU2pocno3NFd5NW9iQTNVVVJPcVU4TnJnbFk3TXoxRnZRRjJG?=
 =?utf-8?B?dVZneTFWcVlEdHFQK1lmcUx0MWk4Q3JIbllwc2VDWmhVUmhmcWxPMVUyQ2hG?=
 =?utf-8?B?N2F6bHBOaWV3YjdCUjhYRExDVjByUXFsd1QxZDhvVHVSazFGQTdGZE82MDhp?=
 =?utf-8?B?eFJmRDJnd1BSYzgrL2M0dVZOSzhNVmVZdUlaTGRaSFVzTDhJUW1qU2N1cVpB?=
 =?utf-8?B?bjNBQWwvakswcG1tcjQ2TE11MEJ6SFR2M1BVNDIrTWZweWZ3b25nVEh3M0lM?=
 =?utf-8?B?cGtaejhPVzNrV05GWkZrTSs5RHkrMzIxZ0pFTVpveFI3YStsU21heXY3R0pY?=
 =?utf-8?B?MWk2aHU4ai8rTERvWHVTVkJlOHpEZy9DNldsMmF2TXFPNmhwbmdCVmtFZHB2?=
 =?utf-8?B?Y2d6ek0xY3BYczhVRW5BQ21sVlhlSVBscUxkalpqQXlwSUFJa3VLSXFlRGhv?=
 =?utf-8?B?UmgvVUZ5alU3eWh0UEQzVkhhcmdvZHZuNXNCelFqbHlMTXgyb0ZPMjRiRWZv?=
 =?utf-8?B?OFgwb3hPQ1Q4SFMwZzJxOGR5WUNLK1hBbDJybVF4Q2xxWG5jR3h2bno2RUJ0?=
 =?utf-8?B?NVFpZllJUUJEc09lTlBxUGdNTkUxdlhWKzNJdi8xazRmandLdkFRc3l4Zmkv?=
 =?utf-8?B?UDQ4ZWlPN2pObE9RY3B0YzNhY3BiRVF5OTc3QkxsZU1wUERzbW1KYk1pNWRJ?=
 =?utf-8?B?THpDdVViRkU4UVZzRmJIRllOemo3Q0JOdW5lVjVPTWxRUXZ2eXJ2T0xDU2Jp?=
 =?utf-8?B?U2FJZGhrd00vRnp6ejVtVTZUaDZXMVVPbEk5QXU0YVNNcFQ3alA5RzFpSHBV?=
 =?utf-8?B?UGxrb2FDY3c4YkkwUi96VVpXMWV2TTF2MzNqNjh1V0JtbnlYZ09zekYwZnhJ?=
 =?utf-8?B?VERVSGFWakpEcEl2WndjdzRRRzJNa1A3VjBKbGdJb2hpL0dqQlZ6UGhNdUkw?=
 =?utf-8?B?TVplenZ6QXZxYXhjOEp1RS82Zkx2aGs4eUo4NWZXamM2MHl1VFJ6bzJPb1pX?=
 =?utf-8?B?elUwblJSV2U1OXM0YjFIL0xlRzB1QVN1Y1NsOEJOL1E5WDVIQWYzc0VMczNU?=
 =?utf-8?B?MmtoL3VNT25JQkdRU0ZSNUE5bjNtR2dTc01QOFFTUFh1NlhsSmRoYzdLMlNm?=
 =?utf-8?B?bkhyQnpKQXRjaGNoRHkraU84eFE2cmR2OUZWL2E0c3pjazlhdDBTb0xDbzhI?=
 =?utf-8?B?TGFYOHo2WFFDZDR6Y1RPTUIyK3VIVHYzbmZXLzJWZ3R3THNNamdHN05sNy9n?=
 =?utf-8?B?MXYyUklDdE5PdVdyUzd4OFpxMXRKL0xXU1lNTzY1WThQYWtFMVB5c1BpT1NI?=
 =?utf-8?B?dG5FdjRjcWIyc0szaFJNWXBDdUp1NUtZdHBoZTZTU1Q4cUpnb3R1ZncxQm12?=
 =?utf-8?B?TXdFYlV0RmUrbngrREdEUm1lL0NmSGRNTHJhY2hJTm1KaFpLWTFEQ1ZrZUdZ?=
 =?utf-8?B?STBVSFd2aklBWWwrTDdtOGdJWnZLVGVQcWxiNmhHY3o5aTVDME95SUp5Uitt?=
 =?utf-8?B?elBMaEFEN3BJVVdEMU5MdUpieVF2L1BuQVlqb1RwNmRyV0FicUcvbTdiSkU5?=
 =?utf-8?B?ZXY5SkhNMnYwZnZQZGMzemhBT0hEUnFjMXdxYjdFUjZhZDZsU3pjVytDbWhG?=
 =?utf-8?B?c3kxQ21EQjhmSWhzZzBPazN3ZldqK3c5TnhTSzlPa1d4ZENSaW5PcUdmNkdH?=
 =?utf-8?B?V3k5ZE5BWDNrcjdjVmhhMFUycndHOVdGYmRLKzdDV0V4d3FVV0ZDZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7889da8-7f40-4a50-765f-08deb63c8fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 06:53:55.8505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QlZQiUs1c+IrGkGQVLT/0T42wkOCFSwQGhtdCJswvLAOtw4A67UssjhToPaI5sDuGBo/Hkas8QHNxdbOH4whQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAwNjo0OQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNS8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBFbXVsYXRlIFZDTURRDQo+IHJlZ2lzdGVyIHJlYWRzDQo+IA0KDQpb
Li4uXQ0KDQo+ID4gKyNkZWZpbmUgU01NVV9DTURRVl9WQ01EUWlfR0VSUk9STl8oaSkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiArICAgIFJFRzMyKFZDTURRIyNpIyNfR0VSUk9S
TiwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICsgICAgICAgICAg
Q01EUVZfVkNNRFFfUEFHRTBfQkFTRSArIDB4MTQgKyBpICogQ01EUVZfVkNNRFFfU1RSSURFKQ0K
PiBcDQo+ID4gKyAgICBGSUVMRChWQ01EUSMjaSMjX0dFUlJPUk4sIENNRFFfRVJSLCAwLCAxKSAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gPiArICAgIEZJRUxEKFZDTURRIyNpIyNfR0VSUk9STiwg
Q09OU19EUkFNX1dSX0FCVF9FUlIsIDEsIDEpICAgICAgICAgXA0KPiA+ICsgICAgRklFTEQoVkNN
RFEjI2kjI19HRVJST1JOLCBDTURRX0lOSVRfRVJSLCAyLCAxKQ0KPiA+ICsNCj4gPiArU01NVV9D
TURRVl9WQ01EUWlfR0VSUk9STl8oMCkNCj4gPiArU01NVV9DTURRVl9WQ01EUWlfR0VSUk9STl8o
MSkNCj4gDQo+IA0KPiBuaXQsIHdoYXQgSSBtZWFudCBpbiBteSB2NCBjb21tZW50cyBpcyBJIHdv
dWxkIHByZWZlciB3ZSBncm91cCB0aGUNCj4gZXZlbnR1YWwgcmVnaXN0ZXIgZGVmaW5pdGlvbiB0
byByZXByZXNlbnQgdGhlIGFjdHVhbCBsYXlvdXQgb2YgZWFjaA0KPiBwYWdlLCBpbnN0ZWFkIG9m
IGludGVybGVhdmluZyB0aGVtIHdpdGggYWN0dWFsIG1hY3JvczoNCj4gVGhpcyB3b3VsZCBsb29r
IGxpa2U6DQo+IA0KPiAvKiBwYWdlIDAgKi8NCj4gDQo+IC8qIHZjbWRxMCAqLw0KPiANCj4gK1NN
TVVfQ01EUVZfVkNNRFFpX0NPTlNfSU5EWF8oMCkNCj4gK1NNTVVfQ01EUVZfVkNNRFFpX1BST0Rf
SU5EWF8oMCkNCj4gK1NNTVVfQ01EUVZfVkNNRFFpX0NPTkZJR18oMCkNCj4gK1NNTVVfQ01EUVZf
VkNNRFFpX1NUQVRVU18oMCkNCj4gK1NNTVVfQ01EUVZfVkNNRFFpX0dFUlJPUl8oMCkNCj4gK1NN
TVVfQ01EUVZfVkNNRFFpX0dFUlJPUk5fKDApDQo+IA0KPiAvKiB2Y21kcTEgKi8NCj4gDQo+ICtT
TU1VX0NNRFFWX1ZDTURRaV9DT05TX0lORFhfKDEpDQo+ICtTTU1VX0NNRFFWX1ZDTURRaV9QUk9E
X0lORFhfKDEpDQo+ICtTTU1VX0NNRFFWX1ZDTURRaV9DT05GSUdfKDEpDQo+ICtTTU1VX0NNRFFW
X1ZDTURRaV9TVEFUVVNfKDEpDQo+ICtTTU1VX0NNRFFWX1ZDTURRaV9HRVJST1JfKDEpDQo+ICtT
TU1VX0NNRFFWX1ZDTURRaV9HRVJST1JOXygxKQ0KPiANCj4gc2FtZSBmb3IgcGFnZSAxDQo+IA0K
PiBUbyBtZSBpdCBsb29rcyBlYXNpZXIgdG8gcmVtZW1iZXIgdGhlIGxheW91dCB3aXRob3V0IGxv
b2tpbmcgYXQgdGhlIHNwZWMuDQo+IA0KPiANCj4gVGFzdGUgJiBjb2xvcnMsIHdoYXQgZG8geW91
IHByZWZlcj8NCg0KTG9va3MgbGlrZSBJIG1pc3VuZGVyc3Rvb2QgeW91ciB2NCBjb21tZW50LiBT
dXJlLCBJIHdpbGwgc3dpdGNoIHRvDQp0aGlzIGxheW91dC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K
DQo=

