Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA5C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMwd-0001yG-EZ; Fri, 21 Feb 2025 01:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlMwa-0001wy-GO; Fri, 21 Feb 2025 01:55:28 -0500
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlMwV-0005wI-Oq; Fri, 21 Feb 2025 01:55:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoR2w1hRE101736QQP44yvwdBmkA5wIUcZYAExzl82eN603VMdfGddM6UE5m1hcz5W105JXiuFruf0vU2ry5Kuj6om83U8HHCo8ZfhVXN8ZB/CLdpySWTegBpO2Xg7X6hBeDPlVup5TStt1upegiIwcPyTjiHDCvUc9ARvckmkDUoLgGKBPor6a+m/3HOOWuqyImEm0vjUdt17gH740e0/CJl8L9X7di99+3dUqFb1E6i/ulBguF2avlNQhYAGo4MlFmVhoWQIGClgMdUtcIOpB4jk7C5hLv7S/YMxb4blC0MuXP/Y20UvATSQKr9y9s1uNK7sl5JYYSCZFR3qM6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHaCeDo7iC/KO7lr+bsuYPV536Rrcyq+QkZjkC1KJO8=;
 b=Sgz0WPzc0QojANRwN5z7Tktj+PgRaltN2fVfRpeF/yoxn7MzKKqteW9DqjfbtgrJNd98Z11ENQEPRRLCz5ONW4BKGOQgtOtynZ1BjShDUgU3ZquLjFr4G9EU3Lh8QMdGWoMt+SFurxeH7t3yoYlSpGK0v4TQXc2oRU6N2/6trQYEMSEz5QY34QOiklinQrC0jv/ik4uEFpcfB6dUoTeStRNrgnpzBqv561CB6on5YDXmC0zEUMa3ELMu08HgUqNFUudU4/7qO7g8jXpkkJ1eofv/S/LRkd+RyIlWnpHQfRP8B4aBOhBcxTBtmSYR1vh8lRQdNvLHqCU952eqHVXPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHaCeDo7iC/KO7lr+bsuYPV536Rrcyq+QkZjkC1KJO8=;
 b=LU2tlDz+9ZB4J+L3Yv1ZrkBwTNuEfzmj5gBBN0osVGtKQze3Ho3BeFCy4ddQ5XuYVlYUvX0XRQtSlSvB0VtghoiXbK+eUeIhUXmNe/E1OlisCDmIbu3NaNUwh3LuS75LazPO5IFrWlcM8qM52IpiySYwLu7oSPPjSyvsovTDWIjmifwnyrpILTVkzrLgiMO/egWQe6WiVM9TFnFlAqfkm/uGT1Lm+5GR7NZ3+UXFQdbqbytYbfD/fwXGjKzRsbmWR225UX6P6XHxYwhhFVgNAaWTQF3aPgmVzPZkBllq4mkmmgn8yCDdGtPq3pQSBa1Q2/OnWIrc2ywyDeqU3E0Qdg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7143.apcprd06.prod.outlook.com (2603:1096:405:ae::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Fri, 21 Feb 2025 06:55:02 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 06:55:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 21/28] hw/misc/aspeed_hace: Fix boot issue in the
 Crypto Manager Self Test
Thread-Topic: [PATCH v3 21/28] hw/misc/aspeed_hace: Fix boot issue in the
 Crypto Manager Self Test
Thread-Index: AQHbfchky6ROwLofhkuIiNhSbOQHZrNMoGUAgASp1uCAABTIwA==
Date: Fri, 21 Feb 2025 06:55:01 +0000
Message-ID: <SI2PR06MB504179BD1EEDEBFF9A68BEC4FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-22-jamin_lin@aspeedtech.com>
 <51b4d012-db0c-42b1-ae0e-2b28751bc2a4@kaod.org>
 <SI2PR06MB5041F4186411EE60CB26CC44FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041F4186411EE60CB26CC44FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7143:EE_
x-ms-office365-filtering-correlation-id: a1c227cc-4e82-48d4-7275-08dd5244aa0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TEhFRW1Tdi9vV2RiZnR2MVR4RnhzWGRVUmZWWHltUmliUDhUZmhsNTVUN1k2?=
 =?utf-8?B?T0pTOW9tRVNwMGdGTmFNZ25QRnhIV2t5TEEweVl4aGRtd3MwbWd3MWVsSW1T?=
 =?utf-8?B?U0t1SVdjUEJ5c3g3UGlSVUdLTmJhcFF4RmF2ZlZuUFpVdGxISEJIR09RRk9T?=
 =?utf-8?B?c2IrVlJod29DYnd0YXR6R0NwYUFXait2c2Z2ODlhZzBndHppQlZTZENGWExV?=
 =?utf-8?B?MXloSU5uZnh5QWt0bjQyNGZORWYrRS9LcUpnN0tseFB0cWVWYXFjYXd5djF2?=
 =?utf-8?B?dGNadFpIWWRSYmNYVHZEdjAwNVViWlRhc1h1VTV2aWU4QkRIZGVLWWxMNldP?=
 =?utf-8?B?VVBXVmIwVnA2Qmc2ZUVBUHhjM1U0OEVQelEvVjVnbHRvbEpTUnRBcWRQb1RQ?=
 =?utf-8?B?dWtoZk5IbUVHZjJzM0JzNDIvYVdFRzRVbnlTK0ZDV2NLVVpiUWZicVlmc3M2?=
 =?utf-8?B?MXE3bHRlYmVIRVRiUUFvOUlYZ1VtNVdNU2RvWW5sRkhsYnhOK3JtL2FlQWhG?=
 =?utf-8?B?dyt3Q0wvVU1VWWFxeXN2Vyt1YlZlVzhBWXIxSHhOa2dzQzlhYWp3cGwwQ2JI?=
 =?utf-8?B?SXBqZ21qMjNDaDFpbmdnL0JDbHE4aDd4by9tcDV2NE8wR0M5N3dud3EvcDdt?=
 =?utf-8?B?dmhFdUorNXh1SllaaXdaZUZKMHJ0MEJ2TTJkdUxPM1RWT2owNFlsckMvMzUz?=
 =?utf-8?B?YTI3UFRwanNvMTgzamZ6NWI3Qm42SjVMR01Xb3ZrTXM4M1dkQk1tWi9PMG5x?=
 =?utf-8?B?TTlkOHBsdGdBYmRLc2IwWHIxSmVacGhwQWhIeEFDaTJkeVA1SXNRc0h0VTJK?=
 =?utf-8?B?SG85SklIREl0ODFjY0dMNHVGeGtpSmNNYmNWYlhscFc3S05kOU1jV0JzN3lC?=
 =?utf-8?B?cHBjb2QrWlNvWEJqbDRDWVhaWklibTh6TXRJTjBaSzhHSHJySk1iaUZHSXQ1?=
 =?utf-8?B?VEhLZ0tMMmNGOTUwSktOY2pyUmx2eVY4RnlzU0JtZURyUmhvQVIrU3JhTWg0?=
 =?utf-8?B?eXd4Y2FOYlFKa3MyNElGbjh0dWR1eUx3b3ZuMWQwWk5MelIyNHlHL0dNRmVO?=
 =?utf-8?B?S3BGZUpacEQ5T1VLZ3BRSFhVdWVhUGk5SjlFZkl2cWxQMGxDRU1BeFhFMjJD?=
 =?utf-8?B?S0haYWVlOTdxTmVidk5Hd3E1Z1YzQ1VGeUhhUHh6Sk10ck44YjNseDBIYUJ0?=
 =?utf-8?B?eFU2TjVHaGxZai9uRG9OQzB5MmhsanJ1Q0hNclB0ZEYyNmtlZmpUa25ORkta?=
 =?utf-8?B?ZGZzSVVqNXRHKzJtb2hwNTI4WE94cjVhdDBTdkRTc1UvRnc4UHA2Z0tvc1Qw?=
 =?utf-8?B?S0dkYjhqYnI1eU5tc2wwb1NuZEo5a0xIMVowczVIT1Yza09rK1F6QTBLL3Yz?=
 =?utf-8?B?TlN1akJSLzNpS0Yvd1d4RE5ya1lkSXUvcDlEOEhPcXgyZlRHSXdlbFpxWG5k?=
 =?utf-8?B?VkpJWi9CV2QvcE11aU53bnZsZG4zSDYwWWoraDdEcS9aczNDVmNiTzJQVDla?=
 =?utf-8?B?WWRDRlBkYjFpVS9TazV3UlJHb2w4MDYwSGdKeUZ2MVY3cjh4dTVyRzJqd1NP?=
 =?utf-8?B?ZGpuaEswRGt1VCs5ZnNZRUQ1UDNLSjRrOUhXWkdQUzl0RGdyY0YrQzUvdXdY?=
 =?utf-8?B?dUxqSW9tT2RYL2h2ODloUllzMTRGYnB2RUZkWHgyL2tGVWswTDRDb01CZklP?=
 =?utf-8?B?QlN3Z1Bvano1VXhkS3kwMC9xWmZKYURMUEZEOEVTaGtaTE4zanlSY01QTmZT?=
 =?utf-8?B?NTVyWjRJcXBzeVZSUkIxK3NwcU5scVBGN3ZQOEJlUVR2b2owSUpxK1VLenpy?=
 =?utf-8?B?RGpDNmNYRzR1RzhDSWwwb1N2SGpXWitiRkVrRkFIdGdGdXVxaWw0RytIMVRv?=
 =?utf-8?B?eWpER21McUo4K2NJSkEzcnRBL0w5OUVUZ01VRGljZ1pTYmRJMUxFTEFjVlVo?=
 =?utf-8?Q?O8+pJpitfGK0jKQQQ2ukzfrQ3RlZgWVW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9EWWVLdEhoaTZmSFk5NkkyeFUxYUdGUnBvUk81VmpjQTJzcXJSZDkwellL?=
 =?utf-8?B?RG9rWVo1MitoSDREMWg2eUdnN1N0RmI1VjhZNEFEK3c2T2RVb2J4dUxyTDJ4?=
 =?utf-8?B?ckNpeWsvYWxRQzRDM0hmZTNPTWswa0liZlZqTHBSNUkyNzZaQkJ1d1JQS3l3?=
 =?utf-8?B?QWJUNHdsQmtjTUszaitKamhvSERCOUdMVWNrT0lTcFc2MEhDUDVyb0ZxWVpx?=
 =?utf-8?B?Z2J2THRJRTgwWTdJOFNOSi9UUUhWOERaaVc3cWt4ODJadlYrbUg1SGI3T1ZI?=
 =?utf-8?B?NlpHbFl4Nm9FRE5PRkpNS1RxblRkZjJ6M1krK0pzYmwwU0s1cWpSMGhVNUZW?=
 =?utf-8?B?alA5T1pudkV3S0IxZmN0MEVHZkxzbHptV3dmV0ZmVFAvVzBjZmdWTHd1UEsr?=
 =?utf-8?B?dnorR21Jc2pQZ2VJYy84a0ViZlh0bnZvczliT0NoaGFISEdoUDloZlhUbFFX?=
 =?utf-8?B?V0xXSWRDbENpMk01Tll1SmhJZTY2L3RzRzBGRFgzNGZxcDBNZ0FCS0lxMU1P?=
 =?utf-8?B?MTBoVmR6eFY4Y3g2RjIrYUU2NlhHSGxVd2xxYWQzaFprUWk0dlZBdGNVTVMr?=
 =?utf-8?B?UDM4SHNEdFZVZ3dxWnVQMSsrUjJxSkJ1M21yeVZ5UktaY3ZtRXJzSC9wU1dQ?=
 =?utf-8?B?ZmlrZUdHS1VGcDdpeEtac0M3bGlDWjUwU2tOc2ZvU25ldnNvZEdOMGl3SzRx?=
 =?utf-8?B?WitURkNuNlY2WnFrZDBMZUhJVDZzNGhXV3JJRE5SdnlVTDczZXlJMDlzVlhm?=
 =?utf-8?B?L2hRamlYdDFvelVsRjlCaEhzUGxVRFJOMkd5STZuQXM4TUR4VS9CaGtPWGRS?=
 =?utf-8?B?bGFpNjRNTlk3SFRTY3RaSDF1RUJreDBFK3FzdWhiaGs5T2JDOVBPWVlqNWxI?=
 =?utf-8?B?aTZmc1M4dm9KNWtOQWRVRUw5UDJ3NFFhZ1Jrb0Vjc0xTQzJwTm55UlZMa0ZY?=
 =?utf-8?B?Q2txQ0wyWVVBUFE1QXZYd09Yb0VRYmpxRk1Vamdob3lZQmx6NWpiTlhzUjhq?=
 =?utf-8?B?VUl1ZlNCYzM1enNhZjBTNnpYS1ZZcHFkTkM3NTB4cU53MFE2RGpIbTFZMmZ1?=
 =?utf-8?B?dFVrbW9JSy9xcmI4STdnZDVrSTYxQ3paZGhVWXRFVERzTUIxM2pDNk9mR1cx?=
 =?utf-8?B?VE5saXJUUktiT0NGY1NoU0diQ3E0TDRQM1NwOU0zVEJxZGsrK1V2MmhLWDUz?=
 =?utf-8?B?QjMwNysxdmYvbHlRQTVjYU5oelJvQXlndzdWbC9zMGFpeCtjSklubGpsN0Y5?=
 =?utf-8?B?YmlLdERpbGMvdVl1VWRHMG9jVzFoZmdPaTIxeFFvMldybUtsR1NVY1hEcVg4?=
 =?utf-8?B?MWJDSDdueVJyY1MzdDJsZmlzUWlKYlJrNk5RNms0bTM5Tk53RFRLSmk2ajc0?=
 =?utf-8?B?TjdTKy8vZ3o2cW5aS0Y1TjUraHJqWEkvQkhYL0o5MUJYVXQ2bDNBRVBJdDg5?=
 =?utf-8?B?eHl6aFYyNHdMM2laU0ZDd2NYL0hJbkdUcVVTY1NEQ2V2TW9OVkJDa0FMa3Yy?=
 =?utf-8?B?M082RVFhbEpUWGpRR1V0dGZvUER3UktJNzlINnFJSTNGMldWVzMwUENzVGsv?=
 =?utf-8?B?aVo4bU9UbTBYY3Nrd3NTOFBEUGQwSVdGSUtLdVA2VC9ZVmFIWEZTaG1wWDlk?=
 =?utf-8?B?K2J1M2xjMjZQcW1lUGV5eFZFS1ZzY2M0NkdXNklENGMvdi9SeEhQZnB2eFpv?=
 =?utf-8?B?OUhoNHdXTE01eVJ1QkUyL2ZUUUkzMmk1eldIVk5Rc2lURnptajZ2QXpVaTMw?=
 =?utf-8?B?YVc3NXNZWmxLOHlvc0w0YU5lcXNLOGRvcEVXTFJyb1ZFWmhQMnlFREdPOTll?=
 =?utf-8?B?RERVOGlqU2p3KzAzeFdXSTAzeVc4SGtCYXRMR2UrSzNEV1kzdXoyV1F4czVU?=
 =?utf-8?B?QzZJTW5Pdm5nZUNlRkNGYXdIdlV2MERxMGx5aDVmeWJQcXVENUtUWWdQaTlF?=
 =?utf-8?B?Z2JsOWVCUXE0blh1R1BIZHR1ajdHc0UwOXFFVTZxZDhESEtEVTdKeDdiQi9W?=
 =?utf-8?B?eXhjcjR4RTRLWlhzTjlKYnJrUVllaHZ6TU4vVXg4RyttNndoMzNGdjFVbWxX?=
 =?utf-8?B?SUlBNnVKalN4Zlh0RFhXT0xIMkZ2dDJLY2xQV1BZRnJ4UWRZZGRYSFpCVFE2?=
 =?utf-8?Q?wchMTOLrDJF2cBqooY6/bFqDP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c227cc-4e82-48d4-7275-08dd5244aa0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:55:01.9905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTXbvcXMfOls2htiF6cH+y4sHcjpdZiE9Q3sZwXleDLEvWs8VpTqvyKqckmT3pxqCmkrQjezi3fI4V6leiOwdaCWZK2jT0cvQM54ZLxwWv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7143
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLCANCg0KPiANCj4gSGkgQ2VkcmljLA0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDIxLzI4XSBody9taXNjL2FzcGVlZF9oYWNlOiBGaXggYm9vdCBpc3N1ZSBpbg0KPiA+
IHRoZSBDcnlwdG8gTWFuYWdlciBTZWxmIFRlc3QNCj4gPg0KPiA+IE9uIDIvMTMvMjUgMDQ6MzUs
IEphbWluIExpbiB3cm90ZToNCj4gPiA+IEN1cnJlbnRseSwgaXQgZG9lcyBub3Qgc3VwcG9ydCB0
aGUgQ1JZUFQgY29tbWFuZC4gSW5zdGVhZCwgaXQgb25seQ0KPiA+ID4gc2VuZHMgYW4gaW50ZXJy
dXB0IHRvIG5vdGlmeSB0aGUgZmlybXdhcmUgdGhhdCB0aGUgY3J5cHQgY29tbWFuZCBoYXMNCj4g
PiBjb21wbGV0ZWQuDQo+ID4gPiBJdCBpcyBhIHRlbXBvcmFyeSB3b3JrYXJvdW5kIHRvIHJlc29s
dmUgdGhlIGJvb3QgaXNzdWUgaW4gdGhlIENyeXB0bw0KPiA+ID4gTWFuYWdlciBTZWxmIFRlc3Qu
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+DQo+ID4NCj4gPiBQbGVhc2UgYWRkIGFuIEFzcGVlZEhBQ0VDbGFzcyBjbGFzcyBh
dHRyaWJ1dGUgKGJvb2wpIHRvIGhhbmRsZSB0aGlzDQo+ID4gd29ya2Fyb3VuZCBhbmQgYSBjb21t
ZW50IGluIHRoZSBjb2RlIG1lbnRpb25pbmcgdGhlIGlzc3VlLg0KPiA+DQo+IFRoYW5rcyBmb3Ig
cmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KPiBJIHdpbGwgYWRkIHRoZSB1c2VfY3J5cHRfd29ya2Fy
b3VuZCBhdHRyaWJ1dGUgdG8gdGhlIEFzcGVlZEhBQ0VDbGFzcyBhbmQNCj4gaW50cm9kdWNlIHRo
ZSB1c2UtY3J5cHQtd29ya2Fyb3VuZCBwcm9wZXJ0eS4NCj4gRG8geW91IGhhdmUgYW55IGNvbmNl
cm5zLCBvciBkbyB5b3UgaGF2ZSBhIHByZWZlcnJlZCBuYW1pbmcgY29udmVudGlvbj8NCg0KDQpV
cGRhdGUgbXkgY29tbWVudHMuDQpJIGRvIG5vdCBuZWVkIHRvIGNyZWF0ZSBhIHByb3BlcnR5LiBJ
IGNhbiBzZXQgdXNlX2NyeXB0X3dvcmthcm91bmQgdG8gdHJ1ZSBpbiBhc3BlZWRfYXN0MjcwMF9o
YWNlX2NsYXNzX2luaXQNClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcy1KYW1pbg0KPiANCj4gPg0K
PiA+IFRoYW5rcywNCj4gPg0KPiA+IEMuDQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+
ICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jIHwgMTIgKysrKysrKysrKysrDQo+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2h3
L21pc2MvYXNwZWVkX2hhY2UuYyBiL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBpbmRleA0KPiA+ID4g
ODY0MjJjYjNiZS4uNGQwOTk5ZTdlOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L21pc2MvYXNwZWVk
X2hhY2UuYw0KPiA+ID4gKysrIGIvaHcvbWlzYy9hc3BlZWRfaGFjZS5jDQo+ID4gPiBAQCAtNTks
NiArNTksNyBAQA0KPiA+ID4gICAvKiBPdGhlciBjbWQgYml0cyAqLw0KPiA+ID4gICAjZGVmaW5l
ICBIQVNIX0lSUV9FTiAgICAgICAgICAgICAgICAgICAgQklUKDkpDQo+ID4gPiAgICNkZWZpbmUg
IEhBU0hfU0dfRU4gICAgICAgICAgICAgICAgICAgICBCSVQoMTgpDQo+ID4gPiArI2RlZmluZSAg
Q1JZUFRfSVJRX0VOICAgICAgICAgICAgICAgICAgIEJJVCgxMikNCj4gPiA+ICAgLyogU2NhdHRl
ci1nYXRoZXIgZGF0YSBsaXN0ICovDQo+ID4gPiAgICNkZWZpbmUgU0dfTElTVF9MRU5fU0laRSAg
ICAgICAgICAgICAgICA0DQo+ID4gPiAgICNkZWZpbmUgU0dfTElTVF9MRU5fTUFTSyAgICAgICAg
ICAgICAgICAweDBGRkZGRkZGDQo+ID4gPiBAQCAtMzQzLDYgKzM0NCwxMyBAQCBzdGF0aWMgdm9p
ZCBhc3BlZWRfaGFjZV93cml0ZSh2b2lkICpvcGFxdWUsDQo+ID4gaHdhZGRyIGFkZHIsIHVpbnQ2
NF90IGRhdGEsDQo+ID4gPiAgICAgICAgICAgICAgICAgICBxZW11X2lycV9sb3dlcihzLT5pcnEp
Ow0KPiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPiAgICAgICAgICAgfQ0KPiA+ID4gKyAgICAg
ICAgaWYgKGRhdGEgJiBDUllQVF9JUlEpIHsNCj4gPiA+ICsgICAgICAgICAgICBkYXRhICY9IH5D
UllQVF9JUlE7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgaWYgKHMtPnJlZ3NbYWRkcl0g
JiBDUllQVF9JUlEpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgcWVtdV9pcnFfbG93ZXIocy0+
aXJxKTsNCj4gPiA+ICsgICAgICAgICAgICB9DQo+ID4gPiArICAgICAgICB9DQo+ID4gPiAgICAg
ICAgICAgYnJlYWs7DQo+ID4gPiAgICAgICBjYXNlIFJfSEFTSF9TUkM6DQo+ID4gPiAgICAgICAg
ICAgZGF0YSAmPSBhaGMtPnNyY19tYXNrOw0KPiA+ID4gQEAgLTM4OCw2ICszOTYsMTAgQEAgc3Rh
dGljIHZvaWQgYXNwZWVkX2hhY2Vfd3JpdGUodm9pZCAqb3BhcXVlLA0KPiA+IGh3YWRkciBhZGRy
LCB1aW50NjRfdCBkYXRhLA0KPiA+ID4gICAgICAgY2FzZSBSX0NSWVBUX0NNRDoNCj4gPiA+ICAg
ICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgIiVzOiBDcnlwdCBjb21tYW5kcyBub3QN
Cj4gPiBpbXBsZW1lbnRlZFxuIiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1
bmNfXyk7DQo+ID4gPiArICAgICAgICBzLT5yZWdzW1JfU1RBVFVTXSB8PSBDUllQVF9JUlE7DQo+
ID4gPiArICAgICAgICBpZiAoZGF0YSAmIENSWVBUX0lSUV9FTikgew0KPiA+ID4gKyAgICAgICAg
ICAgIHFlbXVfaXJxX3JhaXNlKHMtPmlycSk7DQo+ID4gPiArICAgICAgICB9DQo+ID4gPiAgICAg
ICAgICAgYnJlYWs7DQo+ID4gPiAgICAgICBkZWZhdWx0Og0KPiA+ID4gICAgICAgICAgIGJyZWFr
Ow0KDQo=

