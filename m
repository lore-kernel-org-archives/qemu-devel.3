Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C05D167F3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 10:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve9HX-0003Nl-JN; Fri, 09 Jan 2026 04:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ve9HT-0003Mx-MI; Fri, 09 Jan 2026 04:59:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ve9HR-0000XJ-68; Fri, 09 Jan 2026 04:59:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTDHkGAzvIrJ1RneN404HQIuq0Oj0VEZtQscfhFbPTZQ4CIUopl/BoFCp7qTjisUHvBWNxUvV9WpixKFuJjSi/8ONZOi3eFv2RXXg6JHhTfd0nPYw5PnzOQxnCCl7A3FYNGzf3gS7vddJ/vix1+0B+GhY6IYc8vu17kKpAkY4DW8w8jzU/yK17YGPh2eNw4lSUeTKP8zg5hfOQFHWoHE2noYpcYlnsFpjFkN8uxhllnN5AIS/mI9ZkoMhdCv7pkrP8r2nj0OpBJsKeftQ0mWhiUBp5fyF+U09H3deXu62ik66nua5VtyKvbxJ32zDQlJHzOp/2NOX7/+CPZRTtS2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy8yv51txPh7HEE16Dr+6mLG6fwtN/9Ydw/Kg7WYKT8=;
 b=K+SQtmLXva1gZ6khoUqqCnmmojJ5Os6ZiXde8ZVtVjMXy+uldbFoDcqRclawlQ6JS5jTv74yMsTqcJzS1jd43o1BDtesooscbZKPt70sbGBUzxmBkL6Zuo4s2Y8P0tYczJLztPkILLwz18RLyQvI1xkRJnqCNWJq0Q2ABOkZlq1lopvZd9EUvxPl2ac6JAy4/5G2kOx6acvq9yKA+qzDIH+tvma7wLCrBi2BCHW/oPECsnb/0u+T1DhwFYDUO38MoJj87vrmMrOZVlroEKiXTvTaODqkSwF0eBy3Yx7chzqzf5pKCaNFnEaDbccdHAxeGB9OoBneTtt5Nyd1bbkHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy8yv51txPh7HEE16Dr+6mLG6fwtN/9Ydw/Kg7WYKT8=;
 b=jXpz20HBcVxmXxxa0Lgm8Yxn/Zsd0ou9nIOy7eY6b70FpXLGVMxPhIvrhS7UFsBJzjBc1tGTNiypuxHidqleSIjXB4CIU5O6T10kStXNFFZSXEPPnZBzGWWE1z/t0Igfhf26UWyDDVe/+2vatK1mtUWZKBl8j64VyFhqhO462zHAXFuSBJvmG47B6ODkaimiKWHQVre2Pl31QgTPebTrkWCUT0d2+qC6fU7ZMoIfV1Nap+zawDBwbgXp/KGnZkF8Lt9FTMxl4MOfhv4xsD231EtfiNb7MHIcLEQG4DjaVwhMYoXJX4O2h2+HuSfpmLPXQYEqP4kUqslzrb9tW4g4Cw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY0PR06MB5580.apcprd06.prod.outlook.com (2603:1096:400:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 09:59:32 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 09:59:31 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
Thread-Topic: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700
 model
Thread-Index: AQHcdHaM7LqK+1z4NUeh6mGjSHFVqbVG4dYAgAALpoCAAM4SsIAAbWyAgAEVn9A=
Date: Fri, 9 Jan 2026 09:59:31 +0000
Message-ID: <SI6PR06MB763104221FFD3B2F8511E62FF782A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
 <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
 <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
In-Reply-To: <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY0PR06MB5580:EE_
x-ms-office365-filtering-correlation-id: 9f19c8f8-c2be-4c4d-4dce-08de4f65c922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SlNYb0hOci9xaUVMcGFsNUxvMDRENUJ0NWRUaDBYclZqeWIxM1NFdGJuZUc3?=
 =?utf-8?B?Z2xaRGpMNklnSm94ckpCdEVhYS9ZcHVuWWMveDlsVi9HMCtmTDZ0a3dDODY1?=
 =?utf-8?B?cGhUR2RvVXU5aFU0NjhzV0U5M3VONlBvWm9COWkzYXlvZTh1ZWFOVHZVekNN?=
 =?utf-8?B?UXQrbHVpTGJ2S3pxTnZIa1ErbmhZbnZKODc5UXJwZlZMalpPSXgvdTlVWGxV?=
 =?utf-8?B?bkMxVHJ5ZmVBeHExKzVnQTZVVEt5Y0c0Nm03SHYzaGdJbkFxOE5BSnpMYUxR?=
 =?utf-8?B?VlBGQVF1RVhnMEk0Q3dzeG9LVGh1WlN1dGVZeXpmVCt0K1htYTZ4cXBxb1lE?=
 =?utf-8?B?YWhmOW54cnlzVHQ1Q3FBaElPWUFwalVIWW1tRlV3c052QkgrMHFJaHlLSUpM?=
 =?utf-8?B?RWUreTV0T21zQXVhUm1wL3lRTW5oRW1VemgzblBDak1iVkkyeVNCT1gyZlRs?=
 =?utf-8?B?cm1QNUIxM3FGeWhoMmdYNk9CK3dZZW83Y3VyK3dqQ1hiZWZ1QXpHREtKanZt?=
 =?utf-8?B?Yms2UjlEQmlVNUdXazdHTFlOaG14cnZHK3JhQ0FwNnRjeWpxekNRamNoQjFS?=
 =?utf-8?B?UmEyaXpmOGwrQ0JKUGg2U1AyRjI4VTEyOStLWGhBaXE2NDZ6ZEVSa3BWeDhj?=
 =?utf-8?B?MUFsbnBCUjJuZjZIcktHS21PQkRRSXJqeGtySy9Hdk1yYlpHa1BtQlFxc1RL?=
 =?utf-8?B?SVB4bHFsd0N0cCt5b0JpY2IzZnpLRG1RWDJxaGVjOThsMEorNWRXbFpSeTVH?=
 =?utf-8?B?RCtvcElML0xXNUI0aWVYaVBGMWJqcXhER3hpQ3h2bDdhVkNxZSsrOC9YYW42?=
 =?utf-8?B?bDRIN0tzem9tbGVvRXpLQ29IRjlCOU5NY29uN01zRSt6bEtEcVVxTmlpUmQ0?=
 =?utf-8?B?Q3FYcHRXcElFQkpqQk8vUkU3Q2c0S0xZSnNaVUFRMUFhR3ZOMVMxS1lWYVFn?=
 =?utf-8?B?bWE5OTUwUWRBRjFYdTN4UkVzUnc3cmU2ZTRhVHFUa3hsbTFZUmJncFc4UWdM?=
 =?utf-8?B?TkJnTE1MS0ErVG1NbFY4cDV5R2dvQVQzNlZqSi9oRjczQnF0YlpnMUg2ZWlw?=
 =?utf-8?B?VmhMM0ZBZW0wNWd2S1d5Z3RmODhFVk9YUUpSUFQ4eWx4ZFp1SVpXK0NSb2NF?=
 =?utf-8?B?dDR2Ty81QmN3cEZoai94OCtKK0IyTjdmb3FiU0VlWkhwejM1WXpidTVMNVJM?=
 =?utf-8?B?dktlWkRJVWFuOEFzNDVpakFxem1sTC9Kb081bEc0SXhvUWdrMlJHRSs4RCtp?=
 =?utf-8?B?eHpwbTBRQzdjWlRSbS9zWUxFT0NXZ3F4N3Z4NzFrbVY5alBPUDJPQXVHTTRK?=
 =?utf-8?B?cGh0b25qdjhsN0MzRENkSkZ4STZSMzRlZHhVNnBjVmhnTWZ0cGlYd2krelQ1?=
 =?utf-8?B?RGgyMEY0VVBNbE9FenlsaE10YlFTVVB3Y2JNSVZBOUkvdFNaWjBtZHdKVy8z?=
 =?utf-8?B?L0VOKzZDcFNmOFZhNVJiVmhpMkljaGRvYUsvZ3dPRE9kNmpDTlpsVHJHcHVP?=
 =?utf-8?B?ZFphc2d2NmdvK2lnTkxqTm5WcCsxemxIbHpoWnI3RHVMUHRYMlpnQkRYMFMr?=
 =?utf-8?B?elJxYUQvTjVoN05lUEh1cmJud1dxbWp4akZodmtoY1F4NmVSREtPcTlOMnFG?=
 =?utf-8?B?NHF3bTU1cndCOUdtdkllb2ZKbmpPcTVoTGZ2Sm92M0RxYXYvZ2YwR0R3WmNz?=
 =?utf-8?B?UWJEVzlHdXZ4bzlxTzFFRThwNTFaRHQxTmxHUEZialdRc1dZYmNONWRqRWQr?=
 =?utf-8?B?NndwVnBQMFlKQStqdEE3cUFDOFFsRkNvcFdGdzJEVGt4VHFiOHFKWHpaVVpX?=
 =?utf-8?B?c0pleWF5cVNEampoS2ZpTzR4L3NmVjM0Zk5OTk9TejR4UUdtYWJkY25ndVV3?=
 =?utf-8?B?K3Iwc3RpZUJPc05oNlEyYVJTQStabWliRWVQY2l0VHVGcE9zclUrWkM1ZEky?=
 =?utf-8?B?b3Z6SWpqeklvSFcrZVB5NkdoTGtPR2JaRzlNc3hETXRCL29uMldqSHRMbU82?=
 =?utf-8?B?c3I5dk9NMDRuUzdBMEZ2RjM1QlUwby9TS1A0bGgzS3dUc05lVjBYaGYwL2NQ?=
 =?utf-8?Q?s5GVvz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZuUy9HaG9WU2NXUVhTWGxZb09lV09wbWROOUVaQ1NsTWFlSWhqM0NYNGdr?=
 =?utf-8?B?TkR5aVVSU0JzSTdMR0Qyem5XVzNkOXVhWHYxbkFoczY5VFkzdHBoaTRmeHdC?=
 =?utf-8?B?b0pObDNwVHAwZ1Vvd29TT0wwd3hIeTM4TytPV0dZOXJkU2VZcTVHTFRFb2I3?=
 =?utf-8?B?aDVoWlk3WDlObmQ1L0h3akxRSWZhTHdSU25OdVZuK0hudk95ZXE1MEhaUjRY?=
 =?utf-8?B?elUwYnhSS1ZxbDVwSlFLcVExSUszVXVmS2VjTnNSSEJicTNuUE1RUFo5RXc5?=
 =?utf-8?B?VEkvQ0NiWXREWG9pNE5tSHdvMFhwWXREczFuaWYyVCtwRDVVa0VXQ0VqM05y?=
 =?utf-8?B?MkYwNlRyc3F1RVI2NzREcSs4RFlaVDhxNWZtclNIQ3BmKy8yckpBVUxzVk1Z?=
 =?utf-8?B?R2YxWHNPdmU5TDZTUk1yd2VpK3ZHU3ZKVFFiTStjUHpzSld6THNqcENHRTV6?=
 =?utf-8?B?ODhHME05em1yajFyWnI0MzA3ZnZYaG9PemZCMmlnNXRsMS9kbWUwQVZtb0RD?=
 =?utf-8?B?YjNBalNaTnpSS0RINXE5THhmaUJvUUVid2RubkZFS0puZjluSXE1aVdSU3FG?=
 =?utf-8?B?VHd1cy8yczgxdUx0Rkd6VjZJclVBNms2d3FKa0I1U2p6bG82OWRQeVQ3a1hp?=
 =?utf-8?B?ZWp6NVR3RHZSMG1CVktuMGN5djRZZUdseDZ3MWkrWStSVkUwOHhWRXF1bzZU?=
 =?utf-8?B?T29tanprUnU5UzlaankxT0lGb0lHbWRRUjJQUDh4c2Y4RFBoNlJrS0krczhk?=
 =?utf-8?B?WVZ3NmtYQ1M4dHVFaEUvR1I2TWhaYUMzUGZ6SndmWDR6Yy83WXRFaS9IQnlH?=
 =?utf-8?B?WTVTVjkrL2EybUZvNGNCUDJOd3U2aXZQdnVGOTBrUnBWc1ZwODlPQ1BiQys3?=
 =?utf-8?B?a1RISFlYdTdVUWVKalVRTGEvSm5icTFHNXowbWxQQmo5SW1EclkxRUl6NWVP?=
 =?utf-8?B?SjZQRXVFQ1RRTmVyckJZUlVTNzZDNVQxM3RqSE81bkRaRGw0bzZHRDN5K3dR?=
 =?utf-8?B?cmVDUncvdHVYZDk2VmJ3Z3U2L2dPOGxoNnVJQnVBeTRBemFMWG9nenhHRDhT?=
 =?utf-8?B?bkd1ZGV1VmNhYTRCZjUwcnZxeHJLbkZxMHM5UnlRMUZndm1mZkZ4eHdkSFI2?=
 =?utf-8?B?UDZkS2Z6a2hkZVZIclBiZld0aHluMDR2eUcyQ21nOTNhaktVSkk1SlBrN2xM?=
 =?utf-8?B?dW9JWEtyWmlQRlErUHdlekYzUDk2VmFIekFwQzhXUW5QN0dKYWVEalR4VmxQ?=
 =?utf-8?B?YzhjTkJJY0tCQlJlcWZpVlFwMnlGcWsxZjgydDl6MWtKSDV0Rm4rRWhBeFdj?=
 =?utf-8?B?R0llWlI5MFRLU01xdjZsYVhYN0pnK3Roc3Y0eWkzRS9uaWNCM1RDTXZNczQ1?=
 =?utf-8?B?cEFpOWhGcjRUOFJoQmdVdTNTVmZyZDhIb0hqcjIxTmZWNnNicEZlNzVTSHNp?=
 =?utf-8?B?dGFobm53S0tsT2pHSk1JdkRGV0ZreDNlS0NEUUkrdVErL3V6YjJ5emNsblVx?=
 =?utf-8?B?Tm5jOVFHM0k3dWNDVlhaYWZNN2J6eEVVbXdsSmtsL3lGeFZhWVlRYU9FVE5r?=
 =?utf-8?B?R3VqUnZUNU5RdWx2RGRGZGszZUlPdjJneHk2SlhZNk9BMGpzdjlJM2NpMDA0?=
 =?utf-8?B?bHhudUw0WG9JcjhXK09EWEkzc1RneFk4ZVZtbS9NclBZa1pmNllUYzA1OEZJ?=
 =?utf-8?B?d254YU95S3JRSTc5bUFKc0JkYkI4UC9scUVGY3lpaG9sK2lEb052WkJPY0dy?=
 =?utf-8?B?dnVIelRybFkvQmlvTXg3MTZybEp5RzAzWTlTdE4zU25QMGZKSmNCRmlJQVMv?=
 =?utf-8?B?UW5NUzYxcGlidFpRTG1BdVNxRWhaZ2o2RFpGZDgxaU1RMEpNOE4vM0cyRkZx?=
 =?utf-8?B?NTdwcStaNWp0MXU3T0Jud2JWUWhQR2p4M1hDZW82QXBGZWpRamdSVlgzQTVt?=
 =?utf-8?B?TW0wdTNvT09UUlJZdTdWdEFla1BzRmp2OUMwaU1YYldEaU52RzFQS1FETTAr?=
 =?utf-8?B?WjlLNkRTRkdQaCt4b29UU2F6VExsak4yN3Z0Z2g2MkgvaXdmNWd1bVhHKzRL?=
 =?utf-8?B?Z2hndVlDV3RHb1B3SWxGdVJIQ01MU3RZcTJBMXVuenRVL1FKMDFQTy8va1lR?=
 =?utf-8?B?TkovT1UzVXFsOS9wOWQxQlIwR01DV2h2d01Fc3BqUm1zQTBhaU9mYmFNRUl1?=
 =?utf-8?B?NzJEaHZkUWYrV0tjR1hpZGFhdkNzUThBcTVHYWx5MW1Mei81N0pJTWFwK0F0?=
 =?utf-8?B?ZXdYK2VpS0htNWNncUFtS2orQVFqTGthcC9TUEdWZi9FM0JXVXIycFdHekpM?=
 =?utf-8?B?bjFqaHVjMWQybzl4bnZqZWtnL1VPSWV3MGdaZWZNN3pML0doYkdqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f19c8f8-c2be-4c4d-4dce-08de4f65c922
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 09:59:31.7438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kcNo0ZqPyTnVC1bJLgzmDlf9a/3lhE+3fZdwMl+SBcsPUVPWOUP2MJ/lgCQfYAaZ+laQK9iPezYTiEnlGcEnSsOGiZcbiO16sU5k+geXK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5580
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA4LCAyMDI2IDY6MjQgUE0N
Cj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVs
bA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBv
cGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxs
IHBhdGNoZXMgQ0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBM
ZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgbmFiaWhlc3RlZmFuQGdvb2dsZS5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNC8xOV0gaHcvYXJtL2FzcGVlZDogYXR0YWNoIEkyQyBk
ZXZpY2UgdG8gQVNUMTcwMA0KPiBtb2RlbA0KPiANCj4gSGkgS2FuZSwNCj4gDQo+ID4gVGhhbmtz
IGZvciB5b3VyIHN1Z2dlc3Rpb25zLiBJIGhhdmUgcmVmYWN0b3JlZCB0aGUgYnVzIG5hbWluZyBs
b2dpYyB0bw0KPiA+IGFsaWduIHdpdGggeW91ciBjb21tZW50cy4gVGhlIGRlY2lzaW9uIG1ha2lu
ZyBmb3IgdGhlIGJ1cyBuYW1lIGhhcw0KPiA+IGJlZW4gbW92ZWQgdXAgdG8gdGhlIFNvQyBsZXZl
bCwgYW5kIHRoZSByZWR1bmRhbnQgImFzcGVlZCIgcHJlZml4IGhhcw0KPiBiZWVuIHJlbW92ZWQu
DQo+ID4NCj4gPiBIZXJlIGlzIGEgc3VtbWFyeSBvZiB0aGUgY2hhbmdlczoNCj4gPiAxLiBBZGRl
ZCBhIGJ1cy1sYWJlbCBwcm9wZXJ0eSB0byBBc3BlZWRBU1QxNzAwU29DU3RhdGUuIFRoaXMgYWxs
b3dzIHRoZQ0KPiB0b3AtbGV2ZWwNCj4gPiAgICBTb0MgKGUuZy4sIEFTVDI3MDApIHRvIGRlZmlu
ZSB0aGUgbGFiZWwgZHVyaW5nIGl0cyBpbml0aWFsaXphdGlvbiBvciByZWFsaXplDQo+IHBoYXNl
Lg0KPiA+IDIuIFRoZSBidXMtbGFiZWwgaXMgcGFzc2VkIGZyb20gYXNwZWVkX2FzdDE3MDBfcmVh
bGl6ZSB0byB0aGUgSTJDIGNvbnRyb2xsZXINCj4gPiAgICAoQXNwZWVkSTJDU3RhdGUpLg0KPiA+
IDMuIEluIGFzcGVlZF9pMmNfcmVhbGl6ZSwgdGhlIGNvbnRyb2xsZXIgZ2VuZXJhdGVzIHVuaXF1
ZSBuYW1lcyB1c2luZyB0aGUNCj4gYnVzLWxhYmVsLg0KPiA+ICAgIFRoZXNlIG5hbWVzIGFyZSBw
YXNzZWQgdG8gdGhlIEFzcGVlZEkyQ0J1cyB0aHJvdWdoIGEgbmV3IGJ1cy1uYW1lDQo+IHByb3Bl
cnR5DQo+ID4gICAgZHVyaW5nIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgYnVzZXMuDQo+ID4N
Cj4gPiBXaXRoIHRoZXNlIGNoYW5nZXMsIHRoZSBuZXcgb2JqZWN0IGhpZXJhcmNoaWVzIGFuZCBi
dXMgbmFtZXMgYXJlIGFzDQo+IGZvbGxvd3M6DQo+ID4gQk1DOiAvaTJjL2J1c1swXS9hc3BlZWQu
aTJjLmJ1cy4wDQo+ID4gSU9FWFAwIChMVFBJMCk6IC9pb2V4cFswXS9pb2V4cC1pMmNbMF0vYnVz
WzBdL2lvZXhwMC4wDQo+ID4gSU9FWFAxIChMVFBJMSk6IC9pb2V4cFsxXS9pb2V4cC1pMmNbMF0v
YnVzWzBdL2lvZXhwMS4wDQo+IA0KPiBUaGUgbmFtZXMgaW4gdGhlIG9iamVjdCBoaWVyYXJjaHkg
c2hvdWxkIG5vdCBoYXZlIGNoYW5nZWQsIG9ubHkgdGhlIGJ1cw0KPiBuYW1lcyBleHBvc2VkIHRv
IHRoZSB1c2VyIGFyZSBpbXBhY3RlZC4NCg0KU29ycnksIEkgbWF5IG5vdCBmdWxseSB1bmRlcnN0
YW5kIHlvdXIgcG9pbnQgaGVyZSwgc28gSSdkIGxpa2UgdG8gZG91YmxlLWNoZWNrLg0KRnJvbSBt
eSB1bmRlcnN0YW5kaW5nLCB0aGUgb2JqZWN0IGhpZXJhcmNoeSBpdHNlbGYgaGFzIG5vdCBiZWVu
IGNoYW5nZWQsIGFuZA0Kb25seSB0aGUgdXNlci12aXNpYmxlIGJ1cyBuYW1lcyBhcmUgYWZmZWN0
ZWQuIEJlbG93IGlzIHRoZSBjdXJyZW50IG9iamVjdCBoaWVyYXJjaHkNCndpdGhvdXQgbXkgY2hh
bmdlczoNCg0KQk1DOiAvaTJjL2J1c1swXS9hc3BlZWQuaTJjLmJ1cy4wDQpJT0VYUDAgKExUUEkw
KTogL2lvZXhwWzBdL2lvZXhwLWkyY1swXS9idXNbMF0vYXNwZWVkLmkyYy5idXMuMA0KSU9FWFAx
IChMVFBJMSk6IC9pb2V4cFsxXS9pb2V4cC1pMmNbMF0vYnVzWzBdL2FzcGVlZC5pMmMuYnVzLjAN
Cg0KSSBiZWxpZXZlIHRoaXMgbWF0Y2hlcyB5b3VyIGNvbW1lbnQgdGhhdCB0aGUgb2JqZWN0IGhp
ZXJhcmNoeSByZW1haW5zIHRoZSBzYW1lLA0Kd2hpbGUgdGhlIGJ1cyBuYW1pbmcgbG9naWMgaXMg
YWRqdXN0ZWQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd2VyZSBleHBlY3RpbmcNCmEgZGlm
ZmVyZW50IHJlc3VsdCBoZXJlLCBvciBpZiB0aGVyZSBpcyBzdGlsbCBzb21ldGhpbmcgSSBzaG91
bGQgY2hhbmdlLg0KDQo+IA0KPiA+IEkgaGF2ZSBhbHNvIHZlcmlmaWVkIHRoYXQgdGhpcyBuYW1p
bmcgY29udmVudGlvbiBkb2VzIG5vdCByZXF1aXJlDQo+ID4gY2hhbmdlcyB0byBleGlzdGluZyB0
ZXN0IHNjcmlwdHMsIGFuZCBhbGwgZnVuY3Rpb25hbCB0ZXN0cyBwYXNzZWQgc3VjY2Vzc2Z1bGx5
Lg0KPiA+DQo+ID4gSWYgeW91IGhhdmUgbm8gZnVydGhlciBjb25jZXJucyByZWdhcmRpbmcgdGhp
cyBhcHByb2FjaCwgSSB3aWxsIHN1Ym1pdA0KPiA+IHRoZSB1cGRhdGVkIHBhdGNoIHNlcmllcy4N
Cj4gDQo+IFBsZWFzZSBzZXBhcmF0ZSB0aGUgYnVzLWxhYmVsIGNoYW5nZSBmcm9tIHRoZSByZXN0
LiBJIGFtIGV4cGVjdGluZyBhDQo+IGZ1bmN0aW9uYWwgdGVzdCBjYXNlIHRvbywgbWF5YmUgd2Ug
c2hvdWxkIHVwZGF0ZSB0aGUgc2RrIHZlcnNpb24gdG8gdjEwLjAwDQo+IGZpcnN0ID8NCg0KUmVn
YXJkaW5nIHRoZSBmdW5jdGlvbmFsIHRlc3QgY2FzZTogY3VycmVudGx5LCBvdXIgQk1DIHJlbGVh
c2VzIGRvIG5vdCBlbmFibGUgQVNUMTcwMA0KYnkgZGVmYXVsdC4gSSB0ZXN0ZWQgdGhlIGltYWdl
IG9uIG90aGVyIHBsYXRmb3JtcyBpbnN0ZWFkLiBJIG5vdGljZWQgdGhhdCB0aGUgQVNUMjcwMA0K
RENTQ00gaW1hZ2UgaW5jbHVkZXMgYSBEVEIgd2l0aCBBU1QxNzAwIGVuYWJsZWQsIGJ1dCBJIHJh
biBpbnRvIGFuIGltYWdlIHNpemUgaXNzdWUuDQoNCk9uIEFTVDI3MDAgRVZCLCB0aGUgQk1DIGlt
YWdlIHNpemUgaXMgMTI4IE1CLCB3aGlsZSBvbiBBU1QyNzAwIERDU0NNIGl0IGlzIDY0IE1CLg0K
VGhpcyBwcmV2ZW50cyBkaXJlY3RseSBsb2FkaW5nIHRoZSBEQ1NDTSBpbWFnZSBvbiB0aGUgRVZC
LiBBcyBhIHdvcmthcm91bmQsIEkgY29uY2F0ZW5hdGVkDQp0aGUgRENTQ00gaW1hZ2UgdHdpY2Ug
dG8gbWF0Y2ggdGhlIDEyOCBNQiBzaXplLCB3aGljaCBhbGxvd2VkIHRoZSBpbWFnZSB0byBib290
IGFuZA0KcHJvY2VlZCB3aXRoIGZ1cnRoZXIgdGVzdGluZy4gSG93ZXZlciwgdGhpcyBmZWVscyBs
aWtlIGFuIHVuZXhwZWN0ZWQgYW5kIG5vbi1pZGVhbA0KYXBwcm9hY2ggZm9yIHRlc3RpbmcuDQoN
CkRvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBvbiBob3cgeW91IHdvdWxkIHByZWZlciB0aGlz
IHNpdHVhdGlvbiB0byBiZSBoYW5kbGVkPw0KDQpUaGFua3MgZm9yIHlvdXIgZ3VpZGFuY2UuDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

