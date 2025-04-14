Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C365C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 03:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4AK1-0005nL-LA; Sun, 13 Apr 2025 23:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u4AJy-0005mn-Du; Sun, 13 Apr 2025 23:17:18 -0400
Received: from mail-tyzapc01on20705.outbound.protection.outlook.com
 ([2a01:111:f403:2011::705]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u4AJv-00082X-Or; Sun, 13 Apr 2025 23:17:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YheUsxOJRRbfrZ2M+gnR5juRSdTpXvsIHL7gMaABGWkv22Uwn5GR25DqxORIoGZSEz3G78Rm7UfL+UkaDGB4UIKsBfM4PrWhBXotOeqNyOLLbq79xKJt25Foo76oH8jWqkDLIaoeOfvFbZz1VavrbAWJEBOiJyUn/XY6I0XYJF0PvclwNdYW+Isl3+um3tDtGSrGm7ZFFDCdn/DbH2exTmw41J9ihK9Z3nQwrRfiAOiTJnTkml5dAA0x7IK3/0n9JEuJYVJoJXPHXtlXdCIYFij7Hm1WBpcjLyYq02gAYwLUJ/adhNmtQ/trYcmRVi4eTjCCkpYi++s/qKkHOKPJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4/W1emC2dPayrfCmI7YypVKKtgrzjMFaF9RQt9+yS0=;
 b=JvPM8GLgod8UI+aqQJ663ACskOjaH8JBahpCYQ/akZTX7nMgZb1qrj8007Zgmppei8LDDOzr+drY6h50YU/G+CVpcuDoSao5lyiSZhfH9zT208M+iTfvGsLOk6w8vC8VRcqiQ9U/AGsXSDAZgNiC+nbhwMf6/3MPXACAfXJ0JQz0aE1gOFlNGVEVxc/T/rYg3oFotJUuViRnw31fP8rxFhkTXmePT3jnzXJQsmOewfrBNNabwSWckWumoxYJsRJyCJBRV+XVb7KuZ8CZ7+XcQ20tRKOMGD2pTsC86Mr11QPICpUTbfI71SqkhJocyA3MPHHZ1xMfRzBrZ9isQ0NSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4/W1emC2dPayrfCmI7YypVKKtgrzjMFaF9RQt9+yS0=;
 b=iVlOM4QW2S2XAnHEw+gNTfXm9lMGNc1f33G5EM9IBoenJayqG1I9841qGdqzIimq0miJOlde0RTJmNHyOptEv/4Q7TIAcVymIIf1W7ykaQw0pEh8PNL9QAL3Xr8qgkS3L59dclcVoD23Bwm4HHh4t/g3SkZYo3WuRLeqNgbyGn5BUV2d2yY0DxrZvDONxjWtnIIZqXarUcwqZAY4DkPLhMGy610LjmDvXTZiuYHIkcvdvQUB9iomCFjGTuvMB/IPx2GzFasRfNqtbzmHMCz38MzJLE0WT9zEnEJpwHn9R4dC0vcSUNL8tgMszA+Cd4idJ9EUZ/3nvIlXePvyKYx2dQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB6899.apcprd06.prod.outlook.com (2603:1096:405:35::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.29; Mon, 14 Apr 2025 03:17:06 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 03:17:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbqcG9me2omjhCUUi7MtZUDXpZTrOepD+AgAPfM9A=
Date: Mon, 14 Apr 2025 03:17:06 +0000
Message-ID: <SI2PR06MB5041C73D934E10DEC9B66805FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-8-jamin_lin@aspeedtech.com>
 <860fbb39-feec-4c1d-b05f-aea7889a698f@kaod.org>
In-Reply-To: <860fbb39-feec-4c1d-b05f-aea7889a698f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB6899:EE_
x-ms-office365-filtering-correlation-id: 35055886-0d34-4267-e137-08dd7b02d5c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzhMamk3b0xxOTA3SDV2WWNTMFRCY0hrRWtrNUFnTTNJZ1BjSktiU3lBNXNB?=
 =?utf-8?B?bWwrQ0FBQmZWdDl5R0kzVHlzQ1g2bjl2citUSFN4S1lsUkNSZHVYWjlBQXRV?=
 =?utf-8?B?Tnp4OFZqOTdDeHhSWSswVUlEM2d1cUxGQ2wxZy9lNHcrcEwwSFRTb3NWSnRU?=
 =?utf-8?B?cjNReWJYNG9vZmlENm8rakh2eGFKNUZKYzRZZmlyc1ZMMXlocGJhNzVuRGZq?=
 =?utf-8?B?N1gvdFZoK1IxVHFReDJwRkJ6WGNmeDFMSlFrVlFnc2doSW5kcW01M3FNZlRB?=
 =?utf-8?B?ZlkrdnFRUUFSQmtHU09XUHlxRUNCSDRFakU5VSt6MVJ4MHQzZjNQYjQ4Y2tz?=
 =?utf-8?B?NCt1NFJHQ09wV0MwOThRZWhZR3FMVWR0ank3anQ3WC9wQXRrNUYxcVdwM2N5?=
 =?utf-8?B?eG1NRHhhcmVTMGtvUTRxKzUwVEEzZ2JtTzA4Q0JxTTVlN2dncFhvbmZhTFRC?=
 =?utf-8?B?eVpxbGczaXlSWDVtM2JJSEVpbnZSTlMxRG1qRDFGaEM2U2dESFlub01EbUtX?=
 =?utf-8?B?VGtMM05DcmdMZ3k3Q0VrTisyTUNhNll3M3hWdkwrYVVKOTMxZ3VKRGFFaGRk?=
 =?utf-8?B?NDQvRENhVkoyZFdzL211ZXZ4QnNqMDBYeWp6VzZiTWJUdWtjeWxnYmhBZGRK?=
 =?utf-8?B?MVFSUENnREoyS21LMHp6RFN2N1R4TjRQTDF5NkxMMEZZcEtHR2V0TWNlYy9O?=
 =?utf-8?B?SVVxaXpJWnhIcU9uWEp4M1A5QUZVeWlkOGs5VGgydnQvMUhrZDk0anpyU1ds?=
 =?utf-8?B?MGUrbXcwNHMxVCtFRHI4RXlpVnVjblI0NUthOWxwQmVzYVdkZ1NYZHFFek1n?=
 =?utf-8?B?cmErK1d4ZUlnZnlGUVVUbjFVK3FPWi9KR3g3YTRNa2N0V0FxVmdVaTBtSnBE?=
 =?utf-8?B?NWU4cFZqQmVsSGE0WnN2c0h4WmdOK2FlKzFleCtodDlIMEVkeXg4akJHbnRy?=
 =?utf-8?B?RS92cXQ5VGs2L2dMV3JRWWVPZlFQOUpIbVFWbUQvZnh3SVZQWUc3dEJHV1d6?=
 =?utf-8?B?MWkxN1ZQcWhycDUxMm51cnBMbld5SHJlQ1VtWXBBKzlOOGR6NjE4Q21nR2RO?=
 =?utf-8?B?bkZkQ2dPeVNKNEpEaUhONG5MSXF5RFFXUW05RUl4UFZiMFQrV25uVDVUT3FM?=
 =?utf-8?B?cGhzVk1weUJ4dkNrYUMzY1lYWUl3dmc3eWs3SUlqNnJYMERJd2oxaXhvb0Mz?=
 =?utf-8?B?WW1wb09pb2tyeFNxOWJPeHRxK3ZiaW5scktsUEgxMXRHd1ZPbGlKOXo0UXZz?=
 =?utf-8?B?cUs2a0xRZ1RnbUVKcjN5em5BSUREam9sMTJDSk03cm5qTStmSG1XVmk3MUE3?=
 =?utf-8?B?T3hFd21KMGJ5QnA0Q3c1YnpKN2lVcHNUZXhwaUtRYmVXWHYrYXhtRjYxVWpL?=
 =?utf-8?B?NmMrSlgvK05uNXlIbm5QdWl6VDJCOTFPSmJ4bXQ2ZG95Y1N3MitsKzZRZFR5?=
 =?utf-8?B?M0V2cXpOM1JjTVJDdUdiZ0VXeTV5WkJ2bU9ybkJTY2psMmh0YUZKUlVqQkU5?=
 =?utf-8?B?NUdLSGpZVmsyVzFoajh5UklkN1VNZm10WFpISHI0R1lGQmN0a2hWZVNZNU9t?=
 =?utf-8?B?em9mWlQzOTVnMzV1STJndGE0a2pSSGt0L0pRU0pZWmxMa1NFMXBnOTRsYk9r?=
 =?utf-8?B?NlBNc01udERaWGVmdWtyRUd2Vi8yZVJIRzdab0dxcU9GeWkwRWRQOU13eHpV?=
 =?utf-8?B?YUdRWmZveHhTbzdkZ2VBUnB2Vld2dWxVS3o4UzlzR05uNFI0VE5QOGNlT2tN?=
 =?utf-8?B?emd1Vy9vZkQ4V3d5ZUtab3M0bXdKdlhUWlNPaTJmZFpxZWJKSG83cjIvUkwx?=
 =?utf-8?B?MllSMTBJSlFHRW9KNDAzbE1wb1lSUFBBREVKei8xUmdOY0tyRENuZUFEUElN?=
 =?utf-8?B?SzVhazNJRHRBSllSRDJ5OHg5dzlFWG5GT1dGMFdEeHd2ek5SVVpZQ3ExR0k4?=
 =?utf-8?B?WGJhZTlIWGx1Mlo3bjF0cU5IS25VQnowdGs4eGtPRFZSeCtUSFBFMXZYZEMr?=
 =?utf-8?B?RVloS2ZGdDBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjRYa0Q0UFZORmdWb1dqZnZwc2VJZHBxclJsVkNYazdVVVlZdVVObE05em43?=
 =?utf-8?B?blBhY0VscGtnblRXVlNRVG1WK3JzbE1UWnU4UW5hS2NVelFPNnI3STRyR3lz?=
 =?utf-8?B?d1R1Zms4NUxFaHJ4b2Rsa2tEZWZCTDBMNnBkUGwxekNqeU1BY0ZqcHRXL1FV?=
 =?utf-8?B?NElGUlp1M3FGTk1aM25LZWltMkVpTXVJRzhScGFRUDJXcEgzbVJVSXVEWmNj?=
 =?utf-8?B?b1M5b3c2cEVOV3FtOEc3OThlK1o1TE9ZS0lLUjh4ZkxjM0tuMURldElIWFp3?=
 =?utf-8?B?ZGZZbmJuNkR4SG45QzhsczNrS1J4K3BRdmwyQVZ1NmQ1UExPK1FRYWtRVjA1?=
 =?utf-8?B?ZXM0MTJnSlUwNVdGVVFHV3VFaHh0M3Jyaks5djFGMlN4elFHQytKd2g4TGVt?=
 =?utf-8?B?ZWRWaVVKU0YySEFtc2NpV2R3R3ZYSG80R0lOeDIvWk5lTjc1Ty8rekd3YU1N?=
 =?utf-8?B?b0dnTnVwZEZrMWVaQjdvSHJMSk54Q0Z0MGFSeVA3NFhIOU51K1MyNDN6M3lN?=
 =?utf-8?B?R1JmbllQeUJicHVkSmpQZlpkUmlZWGV5ZWNvYzRkY2pId2dRYjAxQXhtUGF4?=
 =?utf-8?B?VUZxUVlJSGExWXJuQk45SWRGV0xiMERVa0NLMjhpWEVjTk1IVU5RQ09Mek9i?=
 =?utf-8?B?bVVhSmFINDhMYUJUVm83MWQvU0ErRnJvelowKzFhMks2WmZtbU5Ld3U5VFU0?=
 =?utf-8?B?RHcwVlVpMU4zMnE5eWI3OWdvVi9uQmhHeHlxY0NERkhWL21qMWltUmJQc21Z?=
 =?utf-8?B?cU1TZ0N0bUlkMkVGUmlzK0VYdnkzN3hZN3RDaE1abXArYit3MHFHMWZ6bVlF?=
 =?utf-8?B?RzlDRUJySGZHdDl2ZCtSY3M1cEptYXhNbEVhMmdkRXBzV2xib0pqL3dSSjZR?=
 =?utf-8?B?UG9EZ0tIakZuRG0xd2kzS0NWNWd3OWI0UURScEdJc2NEbzJlcGRTRHB0a09Y?=
 =?utf-8?B?azNZbTdtTDh6Q2xyaTd5aW9lRFpuM1VOL05lM1R2SzVYVTl1NVRiaTQyWUw0?=
 =?utf-8?B?NUtoUnZ6TXRRbjk2NnJrMnJrYWFaYjh3RXJyMXEyWXloUWdYSTdiTHV6U2Fy?=
 =?utf-8?B?QVpYdEZGSnVvbXVUZlRyRjA5TVZRSGVtU1hlbmVSSFlqWUpIRnNvT1BqY2dJ?=
 =?utf-8?B?UXN3eU5yUzNVbDZiU0F0dVBDazVLbFdtd3V4M2U3azZKZWxCb0U4T3JBaFJj?=
 =?utf-8?B?MDdORHMvWkkxb3NPNktlck5uU0ZSdmdNYzljZmxIdEJzL2taVXZOTVFzSWwz?=
 =?utf-8?B?ckdUOWphb0RNNEFDSVltM3BCOWQvODJEeU1vSVNDbENmeWV5RVJTa2ZZQTBM?=
 =?utf-8?B?SzhEMUJQS2pUUWVtYXpqWTdMVXl2alZ5OE5yTWNacElXVWRRNldvVHpiQnpx?=
 =?utf-8?B?VkZJR1JhVnI1THZLcDVIVTYrNHhHSG45MWM0RlE0TGRCeVl5YkdhNDJZZngv?=
 =?utf-8?B?eW11OC9Cc2h1MjAvQUdZeGxCaWZPc29EOW5zNkZpT296RW5IVkNYcVRKV0o2?=
 =?utf-8?B?ajZmYnJkL3R1TlNxMnJFTEZWTTFlUHJaT0ZiVzBPOHErR3NPajJpbEhaMmEz?=
 =?utf-8?B?aDlrU1VZNDB6YUJLZllQbEJOemVkeStsVE9YK2MzS01lc1pBcXVMd25qcS9j?=
 =?utf-8?B?WDdJZFozMWRIQmwvV3J1djMybHpaeStUR1U4cG9RcnR1MVpHM2d2ZDAwYUlm?=
 =?utf-8?B?eEpldkRaMkRsWnlxckV6VVNYbDRGb25BL1drQllYZGVKNkxnY21iRjlncVp4?=
 =?utf-8?B?eDZjV3h5OVBTa1o1bDJTRWxSYlErUDdTYUlwaGtSYlBiM2NCdFBZWnlzMnVO?=
 =?utf-8?B?K3lJQnd1cHBpWWRQK3pYdXJ6aDUrT0hCZk9qaCtCTkY2bDZpdThnN1I5QzZl?=
 =?utf-8?B?NkRCbUkwMW1tVE5nUGdSb1dyMXZJMUN3Ry9hQ2ZMenpCYmh4Yy82RUV4T1l2?=
 =?utf-8?B?UG8wbjRwSnBmVjhFYm50RnIxWEFFd2tsRldCY2g1RlJYcE1PSWdaenpyMWlP?=
 =?utf-8?B?T1FSNXdQblpBY1laTnd0bHpwdGdrMCtJUXVQQ0VacDgydFhjeEhwQ1lPNG90?=
 =?utf-8?B?cE1nd3JYblpJbllVRkZWWThiUUVuUnVjVEhMWnZpcldUS3N1RnRselVHcmcx?=
 =?utf-8?Q?9UsRb7H6UFZqbBjQxuKC642cE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35055886-0d34-4267-e137-08dd7b02d5c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:17:06.2928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaHLyIcX93q7cl2YOnSxJeNp+NzsutnHBKJCmc0d/tUOeajJZ+Yo4h5bfeClxn/0OODmm8FUDGKtOo5NNluthV2KRi6f/eVKT3x4beM1PZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6899
Received-SPF: pass client-ip=2a01:111:f403:2011::705;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMTBdIGh3L2FybS9hc3Bl
ZWQ6IEFkZCBzdXBwb3J0IGZvciBsb2FkaW5nDQo+IHZib290cm9tIGltYWdlIHZpYSAiLWJpb3Mi
DQo+IA0KPiBPbiA0LzEwLzI1IDA0OjM4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNl
ICJhc3BlZWRfbG9hZF92Ym9vdHJvbSgpIiB0byBzdXBwb3J0IGxvYWRpbmcgYSB2aXJ0dWFsIGJv
b3QNCj4gPiBST00gaW1hZ2UgaW50byB0aGUgdmJvb3Ryb20gbWVtb3J5IHJlZ2lvbiwgdXNpbmcg
dGhlICItYmlvcyINCj4gY29tbWFuZC1saW5lIG9wdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAg
aHcvYXJtL2FzcGVlZC5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+ID4gYjcwYTEyMGU2
Mi4uMjgxMTg2OGMxYSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gPiArKysg
Yi9ody9hcm0vYXNwZWVkLmMNCj4gPiBAQCAtMjcsNiArMjcsNyBAQA0KPiA+ICAgI2luY2x1ZGUg
InN5c3RlbS9yZXNldC5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L2xvYWRlci5oIg0KPiA+ICAgI2lu
Y2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+ID4gKyNpbmNsdWRlICJxZW11L2RhdGFkaXIu
aCINCj4gPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcvcWRl
di1jbG9jay5oIg0KPiA+ICAgI2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCINCj4gPiBAQCAtMzA1
LDYgKzMwNiwzMiBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaW5zdGFsbF9ib290X3JvbShBc3Bl
ZWRNYWNoaW5lU3RhdGUgKmJtYywgQmxvY2tCYWNrZW5kICpibGssDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgcm9tX3NpemUsICZlcnJvcl9hYm9ydCk7DQo+ID4gICB9DQo+ID4NCj4gPiArLyoN
Cj4gPiArICogVGhpcyBmdW5jdGlvbiBsb2NhdGVzIHRoZSB2Ym9vdHJvbSBpbWFnZSBmaWxlIHNw
ZWNpZmllZCB2aWEgdGhlDQo+ID4gK2NvbW1hbmQgbGluZQ0KPiA+ICsgKiB1c2luZyB0aGUgLWJp
b3Mgb3B0aW9uLiBJdCBsb2FkcyB0aGUgc3BlY2lmaWVkIGltYWdlIGludG8gdGhlDQo+ID4gK3Zi
b290cm9tDQo+ID4gKyAqIG1lbW9yeSByZWdpb24gYW5kIGhhbmRsZXMgZXJyb3JzIGlmIHRoZSBm
aWxlIGNhbm5vdCBiZSBmb3VuZCBvciBsb2FkZWQuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9p
ZCBhc3BlZWRfbG9hZF92Ym9vdHJvbShNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIHVpbnQ2NF90DQo+
ID4gK3JvbV9zaXplKQ0KPiANCj4gcGxlYXNlIGFkZCBhbiAnRXJyb3IgKionIHBhcmFtZXRlciBh
bmQgbGV0IHRoZSBjYWxsZXIgZGVjaWRlIHRvIGV4aXQuDQo+IA0KDQpXaWxsIGFkZC4NCg0KPiA+
ICt7DQo+ID4gKyAgICBBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYyA9IEFTUEVFRF9NQUNISU5FKG1h
Y2hpbmUpOw0KPiA+ICsgICAgY29uc3QgY2hhciAqYmlvc19uYW1lID0gbWFjaGluZS0+ZmlybXdh
cmU7DQo+ID4gKyAgICBnX2F1dG9mcmVlIGNoYXIgKmZpbGVuYW1lID0gTlVMTDsNCj4gPiArICAg
IEFzcGVlZFNvQ1N0YXRlICpzb2MgPSBibWMtPnNvYzsNCj4gPiArICAgIGludCByZXQ7DQo+ID4g
Kw0KPiA+ICsgICAgZmlsZW5hbWUgPSBxZW11X2ZpbmRfZmlsZShRRU1VX0ZJTEVfVFlQRV9CSU9T
LCBiaW9zX25hbWUpOw0KPiANCj4gV2hhdCBpZiB0aGUgdXNlciBkaWRuJ3QgcHJvdmlkZSBhbnkg
LWJpb3MgY29tbWFuZCBsaW5lIG9wdGlvbiA/DQo+IA0KDQoNCldpbGwgdXBkYXRlIHRvIHN1cHBv
cnQgYm90aCB2Ym9vdHJvbSBhbmQgbG9hZGVyLg0KDQo+ID4gKyAgICBpZiAoIWZpbGVuYW1lKSB7
DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDb3VsZCBub3QgZmluZCB2Ym9vdHJvbSBpbWFn
ZSAnJXMnIiwgYmlvc19uYW1lKTsNCj4gPiArICAgICAgICBleGl0KDEpOw0KPiA+ICsgICAgfQ0K
PiA+ICsNCj4gPiArICAgIHJldCA9IGxvYWRfaW1hZ2VfbXIoZmlsZW5hbWUsICZzb2MtPnZib290
cm9tKTsNCj4gPiArICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0
KCJGYWlsZWQgdG8gbG9hZCB2Ym9vdHJvbSBpbWFnZSAnJXMnIiwgZmlsZW5hbWUpOw0KPiA+ICsg
ICAgICAgIGV4aXQoMSk7DQo+ID4gKyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gICB2b2lkIGFz
cGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoQXNwZWVkU01DU3RhdGUgKnMsIGNvbnN0IGNoYXINCj4g
KmZsYXNodHlwZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IGNvdW50LCBpbnQNCj4gdW5pdDApDQo+ID4gICB7DQo+ID4gQEAgLTQ4Myw2
ICs1MTAsMTEgQEAgc3RhdGljIHZvaWQgYXNwZWVkX21hY2hpbmVfaW5pdChNYWNoaW5lU3RhdGUN
Cj4gKm1hY2hpbmUpDQo+ID4gICAgICAgICAgIH0NCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAg
IGlmIChhbWMtPnZib290cm9tKSB7DQo+ID4gKyAgICAgICAgcm9tX3NpemUgPSBtZW1vcnlfcmVn
aW9uX3NpemUoJmJtYy0+c29jLT52Ym9vdHJvbSk7PiArDQo+IGFzcGVlZF9sb2FkX3Zib290cm9t
KG1hY2hpbmUsIHJvbV9zaXplKTsNCj4gPiArICAgIH0NCj4gPiArDQo+IA0KPiBFdmVuIHdpdGhv
dXQgYSB2Ym9vdHJvbSBmaWxlLCB0aGUgbWFjaGluZSBjb3VsZCBib290IHdpdGggJy1kZXZpY2Ug
bG9hZGVyJw0KPiBvcHRpb25zLiBXZSBzaG91bGQgcHJlc2VydmUgdGhpcyB3YXkgb2YgYm9vdGlu
ZyBhbiBhc3QyNzAwLWV2YiBtYWNoaW5lLg0KPiANCg0KV2lsbCBzdXBwb3J0IGJvdGggbG9hZGVy
IGFuZCB2Ym9vdHJvbS4NClRoYW5rcyBmb3IgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KDQpKYW1p
bg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gDQo+ID4gICAgICAgYXJt
X2xvYWRfa2VybmVsKEFSTV9DUFUoZmlyc3RfY3B1KSwgbWFjaGluZSwNCj4gJmFzcGVlZF9ib2Fy
ZF9iaW5mbyk7DQo+ID4gICB9DQo+ID4NCg0K

