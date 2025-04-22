Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEE0C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76qn-00086R-JC; Tue, 22 Apr 2025 02:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u76qm-00086D-2N; Tue, 22 Apr 2025 02:11:20 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u76qi-0004Oj-GN; Tue, 22 Apr 2025 02:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeA96tB2/cacrdAyp9RdT2OJmnoCGsRlK0dcZpOuFYLkbKm81GcSjg98Odh3Z2ce1jRptobW6YOwwaM0hdF7ttEnimpMD3aJfc4rKUtOz7akpcjV72OKazZtx0d811mY5tBt2RuPl3j80HImbXLypCdfyPM7FeWr7BEw2O4d1J5CqGa+EomQuUQkZmTxwmGDbLybblpNPQwlS7XvRP+0l8G96B2RTY0glLUDSkj2Mu48afC4RcFCXmPifVkveNgXhHVAMQNgMF+L9mxEx7lQ5M4u31y3O1sg/UKY3UTY+Vv9OqVQQ/aAe+yd23PzOGQsuKk9j5k5hLr5wXD8rhm72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C8NPP/dFL/aEFjRNYJPw6llbnLciPo5tx+b/19ysrQ=;
 b=vPMBkfFwhrghw6olHWGNoOGwv6WidhnY43TkPUWIyLpDuYUaIeqbBfdgDgcHl1az4ceoUrqU/plkrPLWfHDYBrEUb3sBEB4Jg6GuKwlULkzRJOqewugOehZzwBo/QmiNjkEjyrY3m+T3+EPiiX0BnBeXrcs7v2LW/zWchWSwN3sjsENCBzDAIjuFcNhuoHZTwL0MaUIp0pMBYSNOG9OzPLNFXAf0vPE8iHq+sj8BseFRzF/56Wf4IiUgGbS9+DecLYjS8MHrQEXJ0X/0jW4jEitkkM62DqRxmopiRamY/EYLV1QczmTaCCMyTVlyVMtaYIBMB8Bf0xElMyb1k1y9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C8NPP/dFL/aEFjRNYJPw6llbnLciPo5tx+b/19ysrQ=;
 b=bsze0JQqOKnbXpVUv1gXDLDIWfu2hnhQ6uBOl6s7hXHJnzi29ji7uHESf3N3LmsVDStlHhTuI9/xuTp6wG5fB7cZjPP81xHFb7zvLk2piv2AMXnI/byJIknBukVTspOc9V4IBOheXfaZ2Kp5/BlPETa/WbYNtKBIX8FmT9uli8acgf9EYB6lZhHYuu1UK9SWy/FLh2lwCie4u0Okv4xJ9pH+lCjjKXqYbxnxh7fKu1LnIJEhI3wMyXZhHyCSmqbj1YnO62gVgxBhEvY2u9w2SDsbJaqHwSN15prRnbihKel0OITWPpuwUR2VIbGvNUk5yU7bh58Hj3WldBZ1vN61Yw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB6855.apcprd06.prod.outlook.com (2603:1096:405:13::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.34; Tue, 22 Apr 2025 06:11:09 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:11:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 09/10] tests/functional/aspeed: Add to test vbootrom
 for AST2700
Thread-Topic: [PATCH v4 09/10] tests/functional/aspeed: Add to test vbootrom
 for AST2700
Thread-Index: AQHbr0bGIM7nj+V3T0m21EtIoIXIOrOupDqAgACXw4A=
Date: Tue, 22 Apr 2025 06:11:08 +0000
Message-ID: <SI2PR06MB50417E3327430A5DF470CDABFCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-10-jamin_lin@aspeedtech.com>
 <810f52af-c28c-439c-90f9-c4829f77a910@kaod.org>
In-Reply-To: <810f52af-c28c-439c-90f9-c4829f77a910@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB6855:EE_
x-ms-office365-filtering-correlation-id: c9b79fcc-9377-425b-aa05-08dd81647966
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z2Zhd01QQ2dFK3FVWU9nZE1yakU1Y3lIOGNaUFFpZkc0c0V3NDhGWG5OakVa?=
 =?utf-8?B?UjBPTG9VcEpEaDBINTh5bWIydXR2eFBuVWRQbUsxRnZhQ2hRa1RZMk10emxD?=
 =?utf-8?B?SHpveDZFU3FHRXgwN203ZzQwYlNzU0h3K1FwOWNjTlBKQ2x6UFdKcXRXajBv?=
 =?utf-8?B?bUtIRkxIeCtMeXhNQnFGNEFYbFJuekR3b1BCMVkrRmlQdE4xYTBIcDgrTFc4?=
 =?utf-8?B?N0ZYNGwzQVpTNVZidUYzVHQrT0JqZk9lU1lxQXdmNnJobEV5NE1jWFhYZ2Fw?=
 =?utf-8?B?bWdXZ0dHZUVNbG5uOUlvc1IzOWpvMUtUL1hRRGg3NE1ZSW9yQUZiblNtVHo3?=
 =?utf-8?B?NkF4cXp0NytYQXp2RTBZWmNvUFZYbkNQK2M3SXV4Q3JmT0xEUW4vVXFleGcw?=
 =?utf-8?B?OUlORjlqdHF5TVlvOHVpSnNxWWNyV3ZlY3QyTzRWbFpFQlBBT0lCYXFYZTBE?=
 =?utf-8?B?QUJEZmRGV3E1V29NUWFweFlhbUNDVk5mUGRWRkJQNjVabGlFVEtCd04yNGdt?=
 =?utf-8?B?V3p4bWc1YUhTM3I0UCtKYUpHMVNMTXYzbDJNeUFEQXBMSUZyODR2VnQ4bkVK?=
 =?utf-8?B?R0hWTmdHRlVCU1hmaUFaZklTaVBwSzhUbm1IY09DNVhCYzdTdG45dk9uTTBU?=
 =?utf-8?B?UmRqaHJGZVNuMzhqR1NFYW5wbkIyZWxqSmxGMXhBa1JpcTFJRUhJeVVIcVIr?=
 =?utf-8?B?V1NrcjllRGUzT1lQWC93RFJsS0d4N3k3dnBtTkVvSEV0RzlTOGFNbEc0NDR6?=
 =?utf-8?B?QUw5Umx4bG10R1d5ZndsWk1semh1b3lFV1RDRnNGakY3c1VOUzhvQlBBUVFz?=
 =?utf-8?B?RTl4Q1REMHpMMnJVaE5Pa1piRURFNmpWYXpLS1VieTg3UnZ6RmFxY0dNTWRy?=
 =?utf-8?B?RllJdDFKNVhnQjNJSnRUd0V4bFRFaGNsOGNrdTM0L242YU55OHF3RFl4TFcw?=
 =?utf-8?B?aCswT0U0UjlreDZBL0Q2bWYvZlZwRlZaSWxYZzE4ODQ0MjNqaU1ieTlESi9z?=
 =?utf-8?B?ZS9YWkh6N29SeFg0bTdFTWx5YVA0dFAxcDNnaG0zOXY3ZkpibFhFcEZHMWFl?=
 =?utf-8?B?eVI2a0tCald0UC9pRjkvZ2dTdk5CZzNEb0trdUlFVTU5a0pLOEtZSWo0RWNz?=
 =?utf-8?B?S0dZK0VXYWRMSDhySnp1dXNqbDdMMHJJWUgydG9sTjJrYzM4QzAraFlaOTd5?=
 =?utf-8?B?eWxublB0eW5RSFhuM3VZNlV4R3pkbU44cDZiaGFzOWQrNlRhelZLRThEMmsz?=
 =?utf-8?B?eTBPQmpjSTJ3OUFFSEVwc1pXMFZsc0sxeU1wVDA1eHVZb25QSWFvdlpTUEZx?=
 =?utf-8?B?ZnFCRHlLRExlcCs0aDZwQjhyeTRkWEFCbWJZcWxKd3h5eGZidXRLc2pXQk52?=
 =?utf-8?B?bWZDdlR6b2FJaFNBVUdOTlJaSnNsWUF3QkltR01EZ0hhYnprRDgxY1ZuKzFy?=
 =?utf-8?B?STNaUWQwZFp2eU5mQjNMZC8xTUh2Q1NjeEFIWWc4RFhyN2ZUdERPRmgxTURr?=
 =?utf-8?B?OWNBYjd3cFhKbjVJRGcvRUE0Tk9EalFiMWRTT0ZxTWFybUg2cmZLejlhY3FX?=
 =?utf-8?B?NVcyay9xVExlSmNQcURWeFJQajluNkNxYXh3ZUsvSVJ0djRGbnJTODNFQzk5?=
 =?utf-8?B?cUdlS3E0L2ZTRE5EVjM4cjR1YTk0RXp4enV3NUlxTU1PL0ZmdjU5OS9abXEx?=
 =?utf-8?B?Qktja1lrZVpyMTRqMysvbzRQQW9NZ3ljVVBKZ0lyaFEwM25tK3FqSlRic0I5?=
 =?utf-8?B?RW1wbEFxVzBZQmE1WEZPeHhvVUdlWkFmSjRBOEUvTk1YMys3a294TzJaeEVQ?=
 =?utf-8?B?bmMvSzNtdTRrMGZnS3did0pFK2xOalcvRDZsSU1QN2J1VVVCMXAxTHVQR1Vv?=
 =?utf-8?B?WTJEeDQ0VTk4em9qRWxMNFk1QVUxdE9Ic1JLVk9iNjhCS3J1ZXlCOUplZEgv?=
 =?utf-8?B?a2c1YlVmUklzcnZsUFZJZ1o1b1NNWk96aW80eDBqdmlUUVNVOG1IeFZIaXUw?=
 =?utf-8?B?TEZuOTI3bTJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amRGMjZZeE92ZldleUovaFlHRXJ5QVRSeTBsK2xTNGdramU4UStaeGx5WXJj?=
 =?utf-8?B?dWFEWVMzZ2thcEh0ZHNlam9KSmZPTmNoUFRtODhYU3htblJFYnpuREdhUTZu?=
 =?utf-8?B?ditqRDFhM0dhdG5INmJYZjBmaTY4NDltZW43VnNQZi9HZkF5eFpWQmFvYS92?=
 =?utf-8?B?SHRmTjN0WUVIRFFoa0YweXU4aHZYMndhdnorVlk4Qmt5dk9rSVE3ZjRVNTRI?=
 =?utf-8?B?MytXdE5GcklHcllBL2I2RHZZNW93VXpKRzdKNHE1Z1JBdG1Pb0xJWFd0azNW?=
 =?utf-8?B?dDVxREhmVUNvbkNlbm9IQzAxMkhLSTN6UmZTYUVxYzhjdE5VZUd4QW1KMlND?=
 =?utf-8?B?K3FjdjdZbDNGaDNSOFRNR20wd3FTT2VsNDN6RzRBUHpLRm03ZGxsaHV2ZnlP?=
 =?utf-8?B?bU0zOUJVWGJNdXdEQlcvQzRDelgxUWNycEZXdy82akw3c2NBbDVOcURCR0lu?=
 =?utf-8?B?dk9QSXlFd1NtYS84OUJiZVRiODlmZllpSWxQOWsxVVY0dUZ4NExGMzM5SW5D?=
 =?utf-8?B?eWVmVnJta1A1WXJ6UU9vSHh1L3RjUnBKcmt6bm1ia1p6d21LOFd5NGxDMkxN?=
 =?utf-8?B?eWRxdjFueW1mT3dmTGg2NG44N1ptL21MQWg4aDVkRjAvWFJlWFhZdjdFUUtG?=
 =?utf-8?B?ckFIcWtQazF5QW5sbkZORktEUnZkeWovYUFFYzhFOUpXcmpzbDhEU3VyMXB6?=
 =?utf-8?B?cFFnclRGOCszcTFFdmRUM0ZQTjJFQTh5RnVxbUFNMURqekNZa0huU3QrZi9y?=
 =?utf-8?B?MlI1Y0doQlVRcXJqM1ZDRzB0djBJSlhyU0c5c2N5ZnpESE9OajBURnpYMkk2?=
 =?utf-8?B?amVGZG9xYkNCK3MyU0hFZHAzcGxjWDA2cHBSRzgrdFhCM0FKR0E3UDlodzU2?=
 =?utf-8?B?VUdJd1JsTVZ6N0dESEZLZmYvak44Qmhra1lTbTllVi9sZkhNWnQvNnhqUDNn?=
 =?utf-8?B?VTcwZ1NyRnBTdUZJTzFvN0xyUnhvUCtLb3hMSWwxcDlmZnMyUnpZSmoyUVZl?=
 =?utf-8?B?cWJYdmowSjA1WmxWRktQdnRaZHA1ZlFJL2tCUlpZNlM1K0dGOUxZMlFxQzQ5?=
 =?utf-8?B?cGJlc3pjc25oOThZQVdzVThoNmNSSXFzSGd1dm4wc1diZ013UW5UaWt6QWd0?=
 =?utf-8?B?eGpmTUI2eWFOaEtmWHpqb0hJdXFUR0tRTFMrbEhEQ2xrK2tJOVNBYzdMTUQx?=
 =?utf-8?B?a1pWUndNTEZMcFZhczJDMkZQMVRFNzJtclJpcGdvYXFuT2VKRVExQk0xeHpS?=
 =?utf-8?B?UnhiNFJXa1JidWJxdWY3c3ptS3pDWm9DQVdxeWJBTFh4YnpvWVMxSGx1TGJE?=
 =?utf-8?B?cXA5UjVBWktwZFZPcDBqU0N5cjZ3dW5GL1oxd3lMUTF4RmVXK2FqQTFkZkMv?=
 =?utf-8?B?bnN3ZW5nTmFCYzc4Q1JGc0E4V2g3V3YxQ0FRaW5QR3BJL01KR1h4Unc2R1Fw?=
 =?utf-8?B?c0FxL1RrTW94MXNwWVV6YTBqaGFrQ2Eva2pqcU93L2ZtZlcrckxHdjRaK1NW?=
 =?utf-8?B?ZGVqTm4xdjlQMElGT3JzU2w1MDZQQjhZTHFCNEk5NU5vQWRueE9kMXZpdm9H?=
 =?utf-8?B?dWFJdWlGZ3ZKR0R4YXR1TjVPajMrdnI3K3hBN2I0enNjNDJFb0NXTDlxVHAv?=
 =?utf-8?B?OWI5djR5QzAzSEduNlB0VWlKR0ZZU1FDVDVhNjJyWEJoWUkxaVJJS1BNVS9H?=
 =?utf-8?B?Z2hTK3lZdC9xTTA0ZXhYMkJPNU1LeklUZTBDRjJhYUNJek1SL3FJK09ERGd3?=
 =?utf-8?B?Nm5mK2o3OFBQMTRHcmNiR1V2LytydGN4SWVhb3JnZ0RxV0RPZGhWS21GQ1E0?=
 =?utf-8?B?N21tMjYwemsxb2prb2dmcHN2RFVXQXlDbzNTQ3R2YzM2L3NYa29qd1UrT2Rk?=
 =?utf-8?B?cVJ5RDBrcGEwT3puNHFIeDd6aEJqSEQyMEd2a0RoTVBzSmlMUmV2ZUpKdG44?=
 =?utf-8?B?dHpkeU84WGlwY2FQVjBRYTB0YVBPdVE1SU5DYy9adzJPcCt5MitNbmt4L2E5?=
 =?utf-8?B?QnhiNlFmS3V6QllmSitJNE5qOVpSS0c2K0NmVXVUcUJtRlVPRGlDUHl5VWJy?=
 =?utf-8?B?cWZRbXlzamptWVNWeHoxNDBNcU5sRjJ0d2VGeUNuNHg4ajZnbkpLb0Z2WHZF?=
 =?utf-8?Q?jH2JEHDDyp+aZxoAxD3SJa/qR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b79fcc-9377-425b-aa05-08dd81647966
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:11:08.9672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNQ4EI4aSl1Gh2AC9JzgY+03xn2fsmAe8029z2+PXtfnXqacfebJ9Sx0A/g70Htf/VETrbrnRBO20XX3EIpOoU+XnNzoD7DdxbwQiXOyON4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6855
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDkvMTBdIHRlc3RzL2Z1bmN0
aW9uYWwvYXNwZWVkOiBBZGQgdG8gdGVzdCB2Ym9vdHJvbQ0KPiBmb3IgQVNUMjcwMA0KPiANCj4g
T24gNC8xNy8yNSAwNToxMiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEFkZCB0aGUgQVNUMjcwMCBm
dW5jdGlvbmFsIHRlc3QgdG8gYm9vdCB1c2luZyB0aGUgdmJvb3Ryb20gaW1hZ2UNCj4gPiBpbnN0
ZWFkIG9mIG1hbnVhbGx5IGxvYWRpbmcgYm9vdCBjb21wb25lbnRzIHdpdGggLWRldmljZSBsb2Fk
ZXIuDQo+ID4gVGhlIGJvb3QgUk9NIGJpbmFyeSBpcyBub3cgcGFzc2VkIHZpYSB0aGUgLWJpb3Mg
b3B0aW9uLCB1c2luZyB0aGUNCj4gPiBpbWFnZSBsb2NhdGVkIGluIHBjLWJpb3MvYXN0Mjd4MF9i
b290cm9tLmJpbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2Fh
cmNoNjRfYXNwZWVkLnB5IHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9u
YWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+IGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2Fh
cmNoNjRfYXNwZWVkLnB5DQo+ID4gaW5kZXggMzM3ZDcwMTkxNy4uODU3ODljMWIxZCAxMDA3NTUN
Cj4gPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiAr
KysgYi90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiBAQCAtOTQs
NiArOTQsMTQgQEAgZGVmIHN0YXJ0X2FzdDI3MDBfdGVzdChzZWxmLCBuYW1lKToNCj4gPiAgICAg
ICAgICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsICdyb290JywgJ1Bh
c3N3b3JkOicpDQo+ID4gICAgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVy
bihzZWxmLCAnMHBlbkJtYycsDQo+ID4gZidyb290QHtuYW1lfTp+IycpDQo+ID4NCj4gPiArICAg
IGRlZiBzdGFydF9hc3QyNzAwX3Rlc3RfdmJvb3Ryb20oc2VsZiwgbmFtZSk6DQo+ID4gKyAgICAg
ICAgc2VsZi52bS5hZGRfYXJncygnLWJpb3MnLCAnYXN0Mjd4MF9ib290cm9tLmJpbicpDQo+ID4g
KyAgICAgICAgc2VsZi5kb190ZXN0X2FhcmNoNjRfYXNwZWVkX3Nka19zdGFydCgNCj4gPiArICAg
ICAgICAgICAgICAgIHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsICdpbWFnZS1ibWMnKSkNCj4gPiAr
ICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgZid7bmFtZX0gbG9naW46JykN
Cj4gPiArICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwgJ3Jv
b3QnLCAnUGFzc3dvcmQ6JykNCj4gPiArICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9y
X3BhdHRlcm4oc2VsZiwgJzBwZW5CbWMnLA0KPiA+ICsgZidyb290QHtuYW1lfTp+IycpDQo+ID4g
Kw0KPiA+ICAgICAgIGRlZiB0ZXN0X2FhcmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8wNihzZWxm
KToNCj4gPiAgICAgICAgICAgc2VsZi5zZXRfbWFjaGluZSgnYXN0MjcwMC1ldmInKQ0KPiA+DQo+
ID4gQEAgLTEwOCw1ICsxMTYsMTIgQEAgZGVmIHRlc3RfYWFyY2g2NF9hc3QyNzAwYTFfZXZiX3Nk
a192MDlfMDYoc2VsZik6DQo+ID4gICAgICAgICAgIHNlbGYuc3RhcnRfYXN0MjcwMF90ZXN0KCdh
c3QyNzAwLWRlZmF1bHQnKQ0KPiA+ICAgICAgICAgICBzZWxmLmRvX2FzdDI3MDBfaTJjX3Rlc3Qo
KQ0KPiA+DQo+ID4gKyAgICBkZWYgdGVzdF9hYXJjaDY0X2FzdDI3MDBhMV9ldmJfc2RrX3Zib290
dG9tX3YwOV8wNihzZWxmKToNCj4gDQo+IHZib290dG9tIC0+IHZib290cm9tDQo+IA0KPiA+ICsg
ICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI3MDBhMS1ldmInKQ0KPiA+ICsNCj4gPiArICAg
ICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChzZWxmLkFTU0VUX1NES19WOTA2X0FTVDI3MDBBMSkN
Cj4gPiArICAgICAgICBzZWxmLnN0YXJ0X2FzdDI3MDBfdGVzdF92Ym9vdHJvbSgnYXN0MjcwMC1k
ZWZhdWx0JykNCj4gPiArICAgICAgICBzZWxmLmRvX2FzdDI3MDBfaTJjX3Rlc3QoKQ0KPiA+ICsN
Cj4gPiAgIGlmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+ID4gICAgICAgUWVtdVN5c3RlbVRl
c3QubWFpbigpDQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBhZGQgc29tZSBwYXR0ZXJucyB0byBj
YXRjaCB0aGUgdmJvb3Ryb20gb3V0cHV0LiBTZWUgYmVsb3cuDQo+IA0KVGhhbmtzIGZvciB5b3Vy
IHN1Z2dlc3Rpb24gYW5kIHJldmlldy4NCldpbGwgYWRkDQpUaGFua3MtSmFtaW4NCj4gDQo+IFRo
YW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ICAgXyAgICBfX19fX18gIF9fX18gIF9fX18g
IF9fX19fX19fX18gIF9fX18gIF9fICBfX18gICAgICBfX18NCj4gX19fX19fX19fX19fX18gIF9f
X19fXyAgX19fX19fDQo+IHwgfCAgLyAvIF9fICkvIF9fIFwvIF9fIFwvXyAgX18vIF9fIFwvIF9f
IFwvICB8LyAgLyAgICAgLyAgIHwgLyBfX18vXyAgX18vX18NCj4gXC9fXyAgLyB8LyAvIF9fIFwN
Cj4gfCB8IC8gLyBfXyAgLyAvIC8gLyAvIC8gLyAvIC8gLyAvXy8gLyAvIC8gLyAvfF8vIC9fX19f
Xy8gL3wgfCBcX18gXCAvIC8gIF9fLyAvICAvIC98DQo+IC8gLyAvIC8NCj4gfCB8LyAvIC9fLyAv
IC9fLyAvIC9fLyAvIC8gLyAvIF8sIF8vIC9fLyAvIC8gIC8gL19fX19fLyBfX18gfF9fXy8gLy8g
LyAgLyBfXy8gIC8gLy8NCj4gLyAvXy8gLw0KPiB8X19fL19fX19fL1xfX19fL1xfX19fLyAvXy8g
L18vIHxffFxfX19fL18vICAvXy8gICAgIC9fLyAgfF8vX19fXy8vXy8NCj4gL19fX18vIC9fLy9f
L3xfXF9fX18vDQo+IA0KPiBWZXJzaW9uOjEuMC4wDQo+IA0KPiBGb3VuZCB2YWxpZCBGSVQgaW1h
Z2UgYXQgMHgxMDAxMDAwMDAgKHNpemU6IDB4MTU5MDhiIGJ5dGVzKSBbdWJvb3RdIGxvYWQNCj4g
YWRkcmVzczogMHg4MDAwMDAwMCBbdWJvb3RdIGxvYWQgZW5kIGFkZHJlc3M6IDB4ODAwYjM5YTAg
W3Vib290XSBkYXRhOg0KPiA3MzU2NDggYnl0ZXMgQCBvZmZzZXQgMHgxMWMgW3Vib290XSBsb2Fk
aW5nIDczNTY0OCBieXRlcyB0byAweDQwMDAwMDAwMCAuLi4NCj4gZG9uZSBbZmR0XSBsb2FkOiBw
cm9wZXJ0eSBub3QgZm91bmQgW2ZkdF0gbm8gbG9hZCBhZGRyLCBmYWxsYmFjayB0byB1LWJvb3Qg
ZW5kOg0KPiAweDgwMGIzOWEwIFtmZHRdIGRhdGE6IDI1NzUyIGJ5dGVzIEAgb2Zmc2V0IDB4YjNi
NWMgW2ZkdF0gbG9hZGluZyAyNTc1MiBieXRlcw0KPiB0byAweDQwMDBiMzlhMCAuLi4gZG9uZSBb
dGVlXSBsb2FkIGFkZHJlc3M6IDB4YjAwODAwMDAgW3RlZV0gZGF0YTogNDMzMzA0DQo+IGJ5dGVz
IEAgb2Zmc2V0IDB4YmEwNzAgW3RlZV0gbG9hZGluZyA0MzMzMDQgYnl0ZXMgdG8gMHg0MzAwODAw
MDAgLi4uIGRvbmUNCj4gW2F0Zl0gbG9hZCBhZGRyZXNzOiAweGIwMDAwMDAwIFthdGZdIGRhdGE6
IDI4Nzc3IGJ5dGVzIEAgb2Zmc2V0IDB4MTIzZGE4IFthdGZdDQo+IGxvYWRpbmcgMjg3NzcgYnl0
ZXMgdG8gMHg0MzAwMDAwMDAgLi4uIGRvbmUgW3NzcGZ3XSBsb2FkIGFkZHJlc3M6IDB4YWMwMDAw
MDANCj4gW3NzcGZ3XSBkYXRhOiA2NzI2MCBieXRlcyBAIG9mZnNldCAweDEyYWVjYyBbc3NwZndd
IGxvYWRpbmcgNjcyNjAgYnl0ZXMgdG8NCj4gMHg0MmMwMDAwMDAgLi4uIGRvbmUgW3RzcGZ3XSBs
b2FkIGFkZHJlc3M6IDB4YWUwMDAwMDAgW3RzcGZ3XSBkYXRhOiA2NzM5Mg0KPiBieXRlcyBAIG9m
ZnNldCAweDEzYjYzMCBbdHNwZnddIGxvYWRpbmcgNjczOTIgYnl0ZXMgdG8gMHg0MmUwMDAwMDAg
Li4uIGRvbmUNCj4gW2liZXhmd10gbG9hZCBhZGRyZXNzOiAweDE0YmE4MDAwIFtpYmV4ZnddIGRh
dGE6IDUyNDYwIGJ5dGVzIEAgb2Zmc2V0DQo+IDB4MTRiZTE4IFtpYmV4ZnddIGxvYWRpbmcgNTI0
NjAgYnl0ZXMgdG8gMHgxNGJhODAwMCAuLi4gZG9uZQ0KPiANCj4gSnVtcGluZyB0byBCTDMxIChU
cnVzdGVkIEZpcm13YXJlLUEpIGF0IDB4NDMwMDAwMDAwDQo+IA0KDQo=

