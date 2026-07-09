Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17A6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqTo-0005Vr-U7; Thu, 09 Jul 2026 11:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1whqTW-0005Nx-Um; Thu, 09 Jul 2026 11:15:46 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1whqTU-0005Fl-K8; Thu, 09 Jul 2026 11:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKv+mxh9OAtAR0ShR70RP4euFOZNlOSV/zcA2lPQixEKwHRZztodGmNEB7DDvUs9mzNpKkb+bhtOJDdK9zBH0GtGatCQghoPEvE8uHXg6bTGVSwBKq0J59Oj+EhlMgE5A7RlUBHdj/cssiJ0g3QA2eD9TZ7UbG/FTSzZwZtFZZXYFk3c1pyKxnuNiS+l7A/yAavrkf+RqLudV73wpZ7jAD8A014MQ8K8YgKrXhYls4LYqqiLVdcrnqOIYGkk2d9IWA5i1DMhmXmEkpa2TdO8zl3+SmCDFT6bAz3bpzk4r65ub0cBBhPxe7QKDgXe8sI8AqRi+d9lQWzukTTVJHD5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2abgIj+9H2i3Vx8aIWRrFpQgLLn3AW3c7IJ6vP8cqhA=;
 b=Gup39DGT+U6ZsQR6IMJLajuaaUYiX2m2dZM7ajd1vMyyQKf+ytL9RSChtEDJZ0xVUUfB6kuwlih8rPm+LJWyVVWlSYg+owTETrnpk91c2oVKD2FdznY0yCQGa1JCI3R3INSlExh7ClUnkmDa+t8EOJJ4ZGQgghhr2lnhliZDJRO58iO9WAwpUi+ySUBy1IOh6Zm0XroudPcSchVEQxDeA1iEKb2f9Tw5CeQNW2Lq0Zufl9P9Nj5S2JsD9lg61UCkGW2mfxlrCLdetWf9Kp6uDZMq/W/2jLKf4qep7SxW1nceJ2E9TOG5KTLRX+USOK2UrjGHIxQf2LHHVxGQlqdfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2abgIj+9H2i3Vx8aIWRrFpQgLLn3AW3c7IJ6vP8cqhA=;
 b=ZABf+efN+l5A2gHJxI4EGv5844jSv1ajt38mQyv8WjdmZRUBMGVySvhRrUd5zJ62d89TZtS6P1OPtUJq99GOQaNO9mB6UO3YyqsHU0Q5lEoS4GfdR+rnQi2SvSaKCL7YNaElS0Es63vfBOpf9qGkHfxUWrm7Af7mQWkHyivHJu+lLUctsUnuAtkGpcaIIetHA3NT3I15xdejw8rI+Ae/Hd3c7olmdV4jkXIiRV2Fifu7qerotZ0Wk1OAqcba/l3VCZ6ADEFuQdmUTnCdxDEMA6UhdRVIlZoqY7BnxKqx8jxmR2ltagMEkkPFQtaah0on4vebARPJ2DEbKo5db383WQ==
Received: from PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:15:23 +0000
Received: from PH7PR12MB8593.namprd12.prod.outlook.com
 ([fe80::9c70:35c0:f8b2:8f77]) by PH7PR12MB8593.namprd12.prod.outlook.com
 ([fe80::9c70:35c0:f8b2:8f77%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 15:15:23 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>
Subject: RE: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
Thread-Topic: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
Thread-Index: AQHdDgNZ5fJQ5WS14EWh3Rd+Y9q0v7ZlSKyAgAADvTA=
Date: Thu, 9 Jul 2026 15:15:22 +0000
Message-ID: <PH7PR12MB8593CB26D92493FE0EF0C3EEABFE2@PH7PR12MB8593.namprd12.prod.outlook.com>
References: <20260707112450.111178-1-skolothumtho@nvidia.com>
 <5161e394-4f41-4fe4-af83-1c0993758442@redhat.com>
In-Reply-To: <5161e394-4f41-4fe4-af83-1c0993758442@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8593:EE_|SJ0PR12MB8616:EE_
x-ms-office365-filtering-correlation-id: 83ee5bea-cdb6-41ab-7fc8-08deddcce5b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: LvS4lfuFedA9VKRWWGtGODlPoAdCx7lQ1Exaoc43CVR7m142BfUBS+xIQKXhSvLJ9gsbll0KYjpvR9dX6IDonKLsLLb8Bh6lqIKntKdgOH8nfM1PQmX/1ziVrdmd3kw5N/NcMxQZTGpzqFWnWVJFyknk+w4WzDQiyN3NPVf6tQ1zIa6e8i1T0pNYTZOmkFMwHsIzvPqiidrQFAJqndtsRMazSN0mAGUmFFybxaG8aaGHxblFvbr9YNBhcicClih0YJVcq1r915Ak7ltz5X6cpqWiXoCbVG7Ib0CE1kiyVsrogjIR2XQChBENRy8qu7myctrGqcmxnVhRm6TID53Gdtxqubr3+88h+58Fr2WjqhQrfjfiSabZX1ZGJ6qWx73YROP5wc7Zf5y7KZ1kZwqAyOPmW8vYWKz4ztrqFg83yXWG2AReLq5ibdboZPHDZiB7FnQtz3aOCfK/6vsfsD2YiRAFkXxZq1E5pSmzQZAaV5/FFxkt/LviBDHrW2nwL4etSdHBZmoK4zb3l5S0O255HsCFiLO2Jeh9TTrkg2a16jgkE40p1UY4gs8A4tFpPCkD5f8oWSz+zw4x3plDM6i2fJsSGUD8v4LMiSq3kyD5cUoGI7M0CRq8zwn1l/8VNCMWmE1SNauG7OFJHNVnUcHKmVanzgoC/fSPao2RYGoT+vAGYPmB701N6kuoDihF4SelVdq0LAR6pr7oGARiUXry/poJQHtv3K2neiUmAPBYrRY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8593.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJxQ0kzSTNwNU4xNU1TL3FUWlh2L2doS3ZJTE9RbGp4R1NLTmxSQklsc0Yw?=
 =?utf-8?B?TmJBdkMydTUxbm1nZURJcWg5ZGFWN2kxWXZhQUFyK3FYdTlWa3gvbDZHeGZV?=
 =?utf-8?B?REhKRDJhM2lITEV4Rk1hNFA5UVAzS2dXVFAybGNKTG51T2NwNTMrZzNwVTBC?=
 =?utf-8?B?YnJxNmFkTmZkODNrZmNkUmVEOWNYOVBnWXk0dXNrcmwvRDJ5MXZ2NmlxKzZF?=
 =?utf-8?B?YnJqOXd1WGNoS1pNQUVsdGNzdFBDd28vektrclUzUkF4WTVVWS92Z2JGRGVl?=
 =?utf-8?B?OFNhdVp1T1p3VXFYSUdKR2hIdUdFazEwR0FTRERULzJRUTVYK25leCthR2dT?=
 =?utf-8?B?TFJFUVF6MXRXcnFYNTUvdlhQL0dxWXh4T0ZXYWpiNkYrZ3lKdFV5UzFudzBo?=
 =?utf-8?B?SHFRQ0s5eWs3dHdXZ3FKWU5vRkVob0w2bHNSUDM2NFY5T25BRXFYclJDWk5E?=
 =?utf-8?B?SDhqaTMrS0lYYUszNXMvTytVeW83WFdpVWhFNFdvdDl0UmowZExmSGJjODE5?=
 =?utf-8?B?NFhvOEp6ZFJVb3Q1ZWxUdG1Pb3dKdEZTR3JNL3BHdUtIb09OVmJoSXRmMDBG?=
 =?utf-8?B?QzhzOWRXVWVFREN4Vy85VEhGVXdkMm15bTUwSnRTRnBuSWU3NHBWK2NaRDZX?=
 =?utf-8?B?eXB1bmNUaGVQSmNNWlUyeElQOWdCYml4eTRKTTNtRkJOcHhxWWdMY3NoOS9w?=
 =?utf-8?B?bnVyakhVRTFBa29GampJV1V4VjR0YzR6QlBhMDU4bDBQKzdrSm1CRHlId0J0?=
 =?utf-8?B?cjlXTlRubVVIN2hlQUNMUnFDbDFET1R5VVNXTVZNWjl0M3EySHI5ZTF5MWtR?=
 =?utf-8?B?V1hHbTZQanpQTU5HTU9wOVlMMXQvQ0dDL1M5MFd5T0F2MGxQQnl6SGM5Unov?=
 =?utf-8?B?Ym1VVS8zN1RpR0ZMa3lISnpRWkgwaW5jRVRkRTdPdmY1REpqU1pFODhocXIz?=
 =?utf-8?B?a2ZXTi81NVpjRGhFVE9BcVI2aUNmKzA4c3FndXdjeTlvMGtONHJvM3NsU0dG?=
 =?utf-8?B?elBSNUpGNnZ5UG1rRnB6MU1rT1FhWExQNzllUk8weGpEalM1YU82L1c4UE1R?=
 =?utf-8?B?Nm1JZE1DTFVRaFlFUk5FeFNYREdZRjdpQmc0dUxPZk9JelRhNmxkNytxenpU?=
 =?utf-8?B?alNpaklsQ1dNMXA2TzdpaSs2YVE1Unlia2c0UmtIY2dmQ2k5azBhUHNQMEtz?=
 =?utf-8?B?dGUzcTB4SW9jc2c0amNVR0xFT2s5RWNUanV4bzJZUmVGOGtwekpVVDgxYTEy?=
 =?utf-8?B?NzFxZllyek5XL0VoL1FlcU9jWnNFM3RvWVB0V25WRUw1d3czNklieGhEeVhB?=
 =?utf-8?B?ck9xdTRJbUdnTXlpS3poUnkxNnpnajJOWVVrV2w5aGhhYzJJcURTMUxjS2Jo?=
 =?utf-8?B?UkZ5cVVOY3ZWSTd1czFZVG9jazVOOTRsR0N0TWdRdVRvOFRhMitSVEpoSEZy?=
 =?utf-8?B?NHdyWkc0emVrYWpMWGZEU3lmV2VxcUJ1WFRrU2V6L21MQS85WG1JWG9RQWtn?=
 =?utf-8?B?MkUvZUR1ckFnWTVCWEw0TjZEWUNzaFhHc2RTWWVXcWNnMld4Zy94bTVyb09t?=
 =?utf-8?B?akdPdi9FVEk0ajZ3ZzREODJtMjgyZzQ1V3psVDMxR2lYRDdETjJIc3FHcXRo?=
 =?utf-8?B?eldsSUNXR051RE1XWStoZXZsdUMzZFhXblNkeTY3amlJYjVQWGg0ZENUUVIx?=
 =?utf-8?B?aEx5SG1Xamd0QnJUbS9RMmRhdkl6bU1UQkFnT2M4UGlJeFpGNjByUUloSG5V?=
 =?utf-8?B?U3l0Z0FxQjhLSzQ0VjdZWmhYc29pL2xkMDlDQU5ubWgyRlBEMHBJME9GS3Vj?=
 =?utf-8?B?VHFhNnhTdTJXY3gyWjZNUDlRR2VhYW5LQ0p3M0V6U0RWQVcwUmdwTDFCQm80?=
 =?utf-8?B?ZkJBRWJ1aGtyVTQzUG9xVmRoMGFlYUhuTDA0YjlCU0EvZmpURW95Z0s1NGts?=
 =?utf-8?B?cGMvWDMwUmxIVGpDdzRZV1R0UjR0WURPQ3dvc3BmcjJVQXNSMW94TUxiME1Y?=
 =?utf-8?B?dlhFQVBRL1ExV0tvOTFETjgvZDhNRXAxVHpaMWl1Z1M3c2NKZ2F4NkM0YlF2?=
 =?utf-8?B?R0hpZVd1NFFORmhsS1RZWWZBd1B4WUlYWjMwRy84ZWx1WkIyYlo2cGRleHpS?=
 =?utf-8?B?dnMxV2pHNGJ2MEs1QUVvbjVFbVFEYVNXQnMwK2MyZ1ZhR1pDMUxhTE1rcSs4?=
 =?utf-8?B?VmdzWGsrOGd3NmFEK09SRFpuUGhFUTIvM2h0ZzZBaDVON1lPQjQ3SWEwQ09v?=
 =?utf-8?B?R2JFWEFxY05ybFVURnFjS0hTNmRTZjZLRnBVOWs3NDlpYVp2ZEZiNitDSU81?=
 =?utf-8?B?VzkrQU9CMzZFdTVlYXl4d1pGSmFNU3pkVVhZMHY5cHBrTDdIV1JKZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8593.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ee5bea-cdb6-41ab-7fc8-08deddcce5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 15:15:22.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcPLL8h/c90A6qIhrbx/ChMQyVOM1bEA44l8YQL2uPo8axGFl2Tks0iBNQwA7F6ac0B9ji1v5J6KfoR1AZKawg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA5IEp1bHkgMjAyNiAxNTo1MQ0K
PiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBx
ZW11LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47
IE5hdGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52
aWRpYS5jb20+OyBKaWFuZGkgQW4NCj4gPGphbkBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBody9hcm0vdGVncmEyNDEtY21kcXY6IERvIG5vdCBzeW5jIEdFUlJPUk4gb24NCj4g
VkNNRFEgYWxsb2NhdGlvbg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5p
bmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24g
Ny83LzI2IDE6MjQgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gV2hlbiBhIGd1ZXN0
IGhpdHMgYSBjb21tYW5kIGVycm9yLCB0aGUgaGFyZHdhcmUgc2V0cyBHRVJST1IgYW5kIHRoZQ0K
PiBndWVzdA0KPiA+IGFja25vd2xlZGdlcyBpdCBieSB3cml0aW5nIEdFUlJPUk4gdG8gbWF0Y2gu
IFRoZXNlIHJlZ2lzdGVycyB1c2UgdG9nZ2xlDQo+ID4gc2VtYW50aWNzLCBhbmQgc2luY2UgR0VS
Uk9SIGlzIHJlYWQtb25seSwgYm90aCBHRVJST1IgYW5kIEdFUlJPUk4gbWF5DQo+ID4gcmVtYWlu
IHNldCBhZnRlciBhbiBlcnJvciBoYXMgYmVlbiBoYW5kbGVkLiBBcyBsb25nIGFzIHRoZXkgc3Rh
eSBlcXVhbA0KPiA+IHRoZXJlIGlzIG5vIHBlbmRpbmcgZXJyb3IsIHNvIGEgc3Vic2VxdWVudCBW
TSBpcyB1bmFmZmVjdGVkLg0KPiA+DQo+ID4gV2hlbiBhIG5ldyBWTSBzdGFydHMsIFFFTVUgYWxs
b2NhdGVzIHRoZSBoYXJkd2FyZSBWQ01EUSBhbmQgZmx1c2hlcw0KPiBpdHMNCj4gPiBjYWNoZWQg
R0VSUk9STiBvZiB6ZXJvLCB3aGlsZSB0aGUgaGFyZHdhcmUgbWF5IHN0aWxsIGhhdmUgYm90aCBH
RVJST1INCj4gYW5kDQo+ID4gR0VSUk9STiBzZXQgZnJvbSBhbiBlcnJvciB0aGUgcHJldmlvdXMg
Z3Vlc3QgYWNrbm93bGVkZ2VkLiBUaGlzIG1ha2VzDQo+IHRoZW0NCj4gPiBkaWZmZXIgYWdhaW4s
IHNvIHRoZSBoYXJkd2FyZSBzZWVzIGEgcGVuZGluZyBlcnJvciBhbmQgc3RhbGwgdGhlIFZDTURR
LA0KPiA+IGxlYWRpbmcgdG8gQ01EX1NZTkMgdGltZW91dHMuDQo+ID4NCj4gPiBEbyBub3Qgc3lu
YyBHRVJST1JOIHdoZW4gYWxsb2NhdGluZyBhIGhhcmR3YXJlIFZDTURRLg0KPiANCj4gT25lIHF1
ZXN0aW9uOiBJIHNlZSBjbWRxdi0+dmNtZHFfZ2Vycm9yW2luZGV4XSBpcyBsaWtlbHkgdG8gYmUg
c2V0IGluDQo+IHRlZ3JhMjQxX2NtZHF2X3NldHVwX3ZjbWRxKCkuIERvbid0IHdlIGhhdmUgYSBy
aXNrIHRvIHNpbGVuY2Ugb25lDQo+IHByZS1leGlzdGluZyBlcnJvcj8NCg0KSG1tLi5kb24ndCB0
aGluayBzby4NCg0KdmNtZHFfZ2Vycm9yW2luZGV4XSBpcyBzZXQgb25seSB0byByZXBvcnQgQ01E
UV9JTklUX0VSUiB3aGVuIGhhcmR3YXJlDQpxdWV1ZSBhbGxvY2F0aW9uIGZhaWxzLCBtZWFuaW5n
IG5vIGhhcmR3YXJlIFZDTURRIGV4aXN0cyBhdCB0aGF0IHBvaW50Lg0KSXQgaXMgaW50ZW50aW9u
YWxseSBjbGVhcmVkIGFmdGVyIGEgc3VjY2Vzc2Z1bCBhbGxvY2F0aW9uIGJlY2F1c2UgdGhlDQph
bGxvY2F0aW9uIGVycm9yIG5vIGxvbmdlciBhcHBsaWVzLg0KDQpPbmNlIHRoZSBoYXJkd2FyZSBW
Q01EUSBpcyBhbGxvY2F0ZWQsIEdFUlJPUiBhbmQgR0VSUk9STiBhY2Nlc3NlcyBhcmUNCmJhY2tl
ZCBkaXJlY3RseSBieSBoYXJkd2FyZS4gU2luY2UgUUVNVSBubyBsb25nZXIgb3ZlcndyaXRlcyBH
RVJST1JOLA0KYW55IHBlbmRpbmcgaGFyZHdhcmUgZXJyb3Igd2hlcmUgR0VSUk9SIGFuZCBHRVJS
T1JOIGRpZmZlciByZW1haW5zDQp2aXNpYmxlIHRvIHRoZSBndWVzdC4NCg0KSSBjYW7igJl0IHRo
aW5rIG9mIGFueSByZWxldmFudCBjb3JuZXIgY2FzZSBpc3N1ZSBoZXJlLCB0aG91Z2ggSSBtYXkg
YmUgbWlzc2luZw0Kc29tZXRoaW5nLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

