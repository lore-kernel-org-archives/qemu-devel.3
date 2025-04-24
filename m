Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD6C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7nkT-0007Ei-Dw; Wed, 23 Apr 2025 23:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7nkQ-0007EG-UA; Wed, 23 Apr 2025 23:59:39 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7nkO-0006br-Qq; Wed, 23 Apr 2025 23:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sL4pa60y8qjLkMx7PBpgMaxCJJ7InoE9AmGbhGTmXqTd12vmCZmRqWj/6SVsxZoOtYRe4G7zEpaY2hSZG+t39eWBsHzERhu8Oh/VsBEWs0y+5q+qiOybWI+Ow+zxjc9+afVObM5XrVT5QEBLnDsn6MXJ+kzZHlTGVCELBdljslEHFZRT2hXub8YRUaLaxxWmzO5Ou/COLOsdtrPbNzz1iJwrZepPqH/D+v365ojOcSRVcf5q8bqloqr0TCSZYYVziKdgsU0+tA7D6TFZiQr7zcmIIqEUewbBNd3cE2N1jpICxnMxVPawN7se9RVxxwRLjy5Ft4Po5IMF+lZC7rxHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEtsPgRXDNooxJOHeDkoNROarI+xYsSGaY71GnLwbzg=;
 b=SEgbj7vxDGdtTdseDpy5iHSCStKiux066iXwIBnabLsQMiztLHfDi8O2nxo3JU0X5Kqix1f5ApkFClw7fiukiZko2uZB9ug3wYsTvomCdkPOUAySvXoqKJfPHxnCn5cgfHY/cJLjPU6GU6rruZ/cYBlTpG/stXW0C7JJtadsUCXITeXkuVcJu6s5SQqlmBErf1zbtJWoUKYZwFUWY2iDlflM/j+EO35ecDKhcqR3dEEI6ChXQXjSya/iGMuCO6i5I4VpMrFirfBkLJpGoXZOWcAbowGQ5ATFbmwWLEjHoiNnrj/XJ0w2yFIp5wxFzOrJEuPjSJpCW60mB6a86zreTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEtsPgRXDNooxJOHeDkoNROarI+xYsSGaY71GnLwbzg=;
 b=rT+87yORATATNOS6HZhV0oA2qs+ta2xSFUAjY2miWH/XFe9kAQI+Vz9Y3Rm3UJcaD/6QSisFxrJ1XRqOr9FEkXDB5LKyE9Sklai5qj+2s17g4e8eBlNg/mnG7z7WwRRTSzl1HuatYrjxBpb8XfN64OUN3Sl/7ccA6TmFRYcSCHLFqBLFWNwyMJPYUeZSQC2JwvBJ8gcQ4hojdp47sEnq7Mp83/vhLMi+fzzAU4OqJjz/wieLPyeQ4rA7SkxDkQ7TXV6JBMoo7X6ARSF5dHKti35MlHyYLle6ZVbGgo980/MPWoy049YPkL8cZQgmxBtBN98CuDsfcC/zoEPD60WArg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5443.apcprd06.prod.outlook.com (2603:1096:400:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:59:21 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 03:59:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [PATCH v5 04/11] hw/arm/aspeed: Reuse rom_size variable for
 vbootrom setup
Thread-Topic: [PATCH v5 04/11] hw/arm/aspeed: Reuse rom_size variable for
 vbootrom setup
Thread-Index: AQHbtCCvKvfNnuudjkKqZNt82aoTU7Ow+ZgAgAE4fhA=
Date: Thu, 24 Apr 2025 03:59:21 +0000
Message-ID: <SI2PR06MB5041F85966A94C1184F472AAFC852@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
 <20250423072350.541742-5-jamin_lin@aspeedtech.com>
 <7cca3a76-8529-41d9-a35b-16a298622b55@kaod.org>
In-Reply-To: <7cca3a76-8529-41d9-a35b-16a298622b55@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5443:EE_
x-ms-office365-filtering-correlation-id: 3e64581e-674b-4b70-0ff9-08dd82e464f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VlQ1RFVtZVVrenFqNTIvYllKQlpGOUUzK1NmUmxwK1RiZCtVcmNGNHZVa2JU?=
 =?utf-8?B?TjlPS0xEWUlESHZSa0ZHcUhVNStrZEwwQS9zZFh5WjdTcmVzMG9Za0ZKMVl5?=
 =?utf-8?B?NEV1Z2xNTlN3THU3Y1JUZkh3ODFrTDgzek52dnVzMVBRbkE0Rlh6UUZ6akhD?=
 =?utf-8?B?aCtmS0hMam53MUJIVUdoaEdyZTR3b0ZUYU5iWkhYbWFhTm80ZXYrMUNDVENj?=
 =?utf-8?B?SDV1RkswdS85M3ZKS2ErM1BJSTQ0R25qNFB2dk5USjNaNjM2bXpDYldBL3I2?=
 =?utf-8?B?TEZ1MDRsOGswdWtrK0NZaW4xZnZDRCtQVktNMjVMU3cwK0JGZ0xSR2lYWUJU?=
 =?utf-8?B?RG1ERGVLdHBWQzBQeEtRS05qVGUwa3FxSkd6ZmpoYWJyQlIxSU53T0lad1Bh?=
 =?utf-8?B?UVE2bVkydWRleU5Ocks4NTJKV25UdHhNTjZRZTlhTzJiZU5yaXNQdjZvNzNt?=
 =?utf-8?B?RFplZm93VnpMMVNvNWdrQXVBV25mekJtSWcyZ3lZbFh6aTR3eU0zVHFVei9z?=
 =?utf-8?B?UnQ5ZFhVVDNDdVhXWi8ySWZBcTlxbUtaWkhwdVNBSDlrTTkwa01hVUJlTW5V?=
 =?utf-8?B?ZWI2bHlwTzRLMjU3dWdhRWlBMUFPc2FWTFRWRHV5SDZ6MVU2MHlrMVZmdnlW?=
 =?utf-8?B?N3ZFWkg0TTMwcldYcHBoS09BN1g4OUdTODZac0FFQUJWYll0RW10b3ZES2xv?=
 =?utf-8?B?RTBjSEM5MER1akNjTWZpN3RJd0lxU0lyLyt2N01DK1hROUJlZEJXL2hxci9l?=
 =?utf-8?B?K3oyYUNNU2d6VUxJZEhIYWJmcGswYTJTc2F6b2NtZlRNc0ZMY1hrNnA1SjhJ?=
 =?utf-8?B?MnVzTnJtUzhNeW9ERVNOSER1VXNLYmxtdzNFa0ZkdmFicnZWeXhDamlUQXZI?=
 =?utf-8?B?SGlDUVFVWjlxVERzcUt6ZXF1L1pRTEFmT1docGd5L0RXQWdJNmRBZEFjMHBo?=
 =?utf-8?B?RXpCdloybVlrd05Ya2J6QjRkdUpzYjRHOTZYeUhVWlJ4cjlnQm5NWlVvbkpF?=
 =?utf-8?B?SjRJV0pQTkNDeE9ORWx2Ui9BNkRTNHRqUGFKM280YTFoVEdBeDU0ZmRzSkZs?=
 =?utf-8?B?MDdhTndTVkZLT3lydXNPaEpXaC9pREhMVW0yVFJTNDY2UGdSY1BnZ0JyMkcv?=
 =?utf-8?B?cURsNytSRlZRTWNyNVZoTUMraGw4VFFyUDdhS0w0cXNNMFQ3RTM3dy9ZeFA1?=
 =?utf-8?B?ZldXUzJqbWpXUVV3eTY3eCs3Sk45aUZHVUk4MWowcHF4YTF1eFF5YzhKSk1N?=
 =?utf-8?B?UkllSWVDNVI0R0xGOWQzQkNlRVlVc1NpUkV2ZmE1cVp5c0hJTkZ4aFVmbUtt?=
 =?utf-8?B?NDlCREZwSUF4S2pSSyttMFV0bFR1MHRrWUJXZUhmU3hwK1VIK0pUUWRqQTVs?=
 =?utf-8?B?ZW5zbk5nMnpiWmhibjZJZlE0amxsMEFlVXJyYkhKN2JMUUZRRUlwQ1lqQThR?=
 =?utf-8?B?ZXRFUGdmckQ0SjZScTFpcHZ1dUFGYnVSZFA5WUVPNEFWcTVyMWdYUEhXek1h?=
 =?utf-8?B?Nm9xZm11cVMwYzg0eFZyOGo1TmxGZTFEeS92cXJBcUVNdDF1STVjTFhRMlNv?=
 =?utf-8?B?REwxa2o0LzQ0VlV4SGlUc3JXajNHSy96SXdNOTJOYzEwZGM1aUs4T2RWWjBD?=
 =?utf-8?B?WnNmY2ZtOUtMYkw3WjRrWXk2SnZzMnQrWkVNdHJpN0MzVnpsc0ZpbTVjaTM0?=
 =?utf-8?B?T1pXZWdJVS8xUEs5blV5OGxZSDhmcEJ0RXBVV0c2aVJNWU0rRS9EdmVwcUZh?=
 =?utf-8?B?NFZWcU9yTzEvQjNOOEI5THM0OEsrQWZHRHNxODNoMHhJOGwwdmlIZGhCRVlP?=
 =?utf-8?B?ZS9Ha0h3RUtXOUx5dEwxWjhmSkU3Y2lOeHE0SEdiYm4zL0hXZDdkZk5aMlVp?=
 =?utf-8?B?WVA2eEthVTlXRWpuY2Y2RkF6MTNNclAyeHNHUjZPU0hmUk1UclUyVVd5dzNs?=
 =?utf-8?B?RjUyanZNcDllb3N2c2RYd0lDbGRJbTY4RkN1eXpEeDBVWlJ2dHdrVzJYNFJ1?=
 =?utf-8?B?Qm0xVXdBM0NRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1J1R05wd2lpTnh2UG9LU0Z1WGJHZjk0NzluanE1blRYaEdWOEI3bVorcnlX?=
 =?utf-8?B?S3VxTFRjcG9ROU9WYmFJZ0M0U0FWU3pONk1VaTI5aCtwSnpZV1I3QzV2L0hM?=
 =?utf-8?B?Q0dZWWl2eElBK0toTXZESFBEOERMRXNqa2xxeDhmUWxFcG1VelhiMVZYVFMx?=
 =?utf-8?B?ZGZ2L1ErNzNvVERjV25LczhpNVd4N01IM0IxMTF2cVQrcTNRZGNIbkZuV0pr?=
 =?utf-8?B?S1JTSzBVOFUwNVJaeXVWd2QxaHN1Sjlmd01GTk5PQTZDMDJsTHBwanBQZG5r?=
 =?utf-8?B?MUx0c3d4UzN1VzBKRDBLaHllTm05LzZRbGFEbk80NEZJdFpuTmE0YUtFRDFK?=
 =?utf-8?B?aTdKVGI2RkdJamJlMkVtOU5JajNrZnAwUG54ZXlGazU2TE8zdFRGcHdGbTFE?=
 =?utf-8?B?TUg0bUxYYmlybFl5R1hSbWVJWDBrNlkzdmZiWVJGZUQ5UVpOc1ZFUE9vUjdz?=
 =?utf-8?B?bk1YY2FCWHZtV3lGR2xuUUNEVDhHdWdxVkVDREx3WVZENDhpblRxVm5GbHlD?=
 =?utf-8?B?allaMWxRT0RiZUFCYTZXdGdjTEJOc2lTZmVVSFBJcEZtR1FETlViYVNudVRZ?=
 =?utf-8?B?WU9JWUNNMmt1ekl5clFQOFdlbGdQem1kWTdmOWZRR2h3RGVxcXBXWGpsc05L?=
 =?utf-8?B?cjNuVXdtMHZ0aDUzY0YrejJkV3lCcHRVV0NvZ284WHExc2RQYUZuU1NVM0cy?=
 =?utf-8?B?MzhDT2lFY3gwOFo3ZW1kbTN4a0NNcnFEdklQaEVZcWxJNDFtQW10TDQ1a0tY?=
 =?utf-8?B?OEdTVU1MTmhCR2dyblBKNnBRN1ZQOER2a01WbnRWaXFUdGl2SzlPOUNHZDkz?=
 =?utf-8?B?L1VOVFkyTWpmQzlkK2QxeUQzdmVjYXZYbTFMOEJKOUxDandFaUhBeGxQME5o?=
 =?utf-8?B?WlhmL2lKZ3dsVkFLbUhqdTBUUGpINW1QY2lpZXJ0UlJJRHdyL1VRYVpjN1FZ?=
 =?utf-8?B?OVQ3WlZoalpxWWtLRnR5WFhYNWZ0ODR3YkZBYWpZNXNjeVBsczIrWVduNy9J?=
 =?utf-8?B?S0tqNXpkZ1UydVhQR2dXMEpVY3lvMVJSL1F4bFdCYnp5VjdjRVZCbkE3c0NB?=
 =?utf-8?B?WTc3OUFiMlJqUWlCendUN3J5NkNzMG1nWkJ3Nk91bG1TcVp4d0VrVDNBeG9S?=
 =?utf-8?B?SkkyRzdBeUZkMWdnTUJMVElNNkRMaURUZ0FtWk9OeGVSNmdncXNYaFdyVXJr?=
 =?utf-8?B?ZjgwWWpKOUNMOTNsWEFGWHZtWEt2ZEZCTVNncE8yWEN2aU5PVWh2WDJKK1pj?=
 =?utf-8?B?WjQrdUpLajc4dzQ4eThDMUVDNzhMem9NU0IzQm9BTGMrN1BEcmtYZGZTUzUv?=
 =?utf-8?B?eWxLRWU0Yk5JL0hwQ2R1QVZxY0JaSnlPMEFxZlEzT1VSdUlZZEFYcmNNd1Bv?=
 =?utf-8?B?OExKODVWeEVYZjhPSjNOV3JUazgzS2pYZ2ZKN1JuR3ZnSVZwUnlLbmxKTmZZ?=
 =?utf-8?B?V0N4ZlBPOGl2OHgzWGwwWTNpak9QSTZqendMaWtSQnpTWnJla1Rpa3E0SmQ0?=
 =?utf-8?B?dkNrNS95K0dRbUlGNEp1OFZzbTZVQSsxbHQvUnZGVnFqRUlkdzEvQTJ4SUJx?=
 =?utf-8?B?WnR2U0JmUGl5aGl5Q2MyN0Y3cFNjanViTjZKMGZibS9nNGszY2pxc0ZjQ1NO?=
 =?utf-8?B?RzVLNUc0RUZJTDRzWElEbHBOcXc3dU0vUyt0djJVR3haU1NKem13NmhHWUJh?=
 =?utf-8?B?bE1ZbUk0TWZkTUVOOVkrRmVsUFVTd2luaGZrMHV6bFhXYnJCQVAzcHdJSmdC?=
 =?utf-8?B?bnRSbHVWYVdtTTBaVFpzcTVqZE5CMjJWd29JVDFwYjRsQTc4VXd4VmdHYUdX?=
 =?utf-8?B?cGRkdWZtck1rQ29Jd09PZi9TdE5kZEtaTDhVSmZQL1p5SGgrZy92MWFhcUNw?=
 =?utf-8?B?bHhJSUxoOHZRbnlzU2lhbGNCWTVzS3h6dFovMWR5NVBmbmV0T3R6Rm1TK24x?=
 =?utf-8?B?Z0pob1VxVGFNbVh4NDdVRmlvMG9scVBKdnAvbSthdnBIcUlVOVdJNmhVMnNz?=
 =?utf-8?B?WHBiaVB4WVlCSC9oWnA1TWtTREtaMHkvNkYzZFpQN1pVRGY5SThJenZiOHhO?=
 =?utf-8?B?NUFJckF3UTJ1MlNPSlQ1eDBNWWY3ZVhzK1NDN0UxMXBJUlJLdlY3V0ZUSFQ3?=
 =?utf-8?Q?Me9f0R9HXrszSNh2pXgSqcYGd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e64581e-674b-4b70-0ff9-08dd82e464f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:59:21.3998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcIGfyUlMI4gPyxec55rdDyieI0Bvf/PMcnn+hL8hupoqIDJ/Rjj+5F+igJw3C/C2OZdNc48iqHVpKzOxUCh+hthZsR/42uI6wHRwiazZ3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5443
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDA0LzExXSBody9hcm0vYXNw
ZWVkOiBSZXVzZSByb21fc2l6ZSB2YXJpYWJsZSBmb3INCj4gdmJvb3Ryb20gc2V0dXANCj4gDQo+
IE9uIDQvMjMvMjUgMDk6MjMsIEphbWluIExpbiB3cm90ZToNCj4gPiBNb3ZlIHRoZSBkZWNsYXJh
dGlvbiBvZiAicm9tX3NpemUiIHRvIGFuIG91dGVyIHNjb3BlIGluDQo+ID4gYXNwZWVkX21hY2hp
bmVfaW5pdCgpIHNvIGl0IGNhbiBiZSByZXVzZWQgZm9yIHNldHRpbmcgdXAgdGhlIHZib290cm9t
IHJlZ2lvbg0KPiBhcyB3ZWxsLg0KPiA+DQo+ID4gVGhpcyBhdm9pZHMgaW50cm9kdWNpbmcgYSBy
ZWR1bmRhbnQgbG9jYWwgdmFyaWFibGUgYW5kIGVuc3VyZXMNCj4gPiBjb25zaXN0ZW50IFJPTSBz
aXppbmcgbG9naWMgd2hlbiBib3RoIFNQSSBib290IGFuZCB2Ym9vdHJvbSBhcmUgdXNlZC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+
ID4gVGVzdGVkLWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWQuYyB8IDMgKystDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+ID4gZTg1MmJiYzRjYi4u
YjcwYTEyMGU2MiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gPiArKysgYi9o
dy9hcm0vYXNwZWVkLmMNCj4gPiBAQCAtMzgxLDYgKzM4MSw3IEBAIHN0YXRpYyB2b2lkIGFzcGVl
ZF9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlDQo+ICptYWNoaW5lKQ0KPiA+ICAgICAgIEFzcGVl
ZFNvQ0NsYXNzICpzYzsNCj4gPiAgICAgICBpbnQgaTsNCj4gPiAgICAgICBEcml2ZUluZm8gKmVt
bWMwID0gTlVMTDsNCj4gPiArICAgIHVpbnQ2NF90IHJvbV9zaXplOw0KPiA+ICAgICAgIGJvb2wg
Ym9vdF9lbW1jOw0KPiA+DQo+ID4gICAgICAgYm1jLT5zb2MgPSBBU1BFRURfU09DKG9iamVjdF9u
ZXcoYW1jLT5zb2NfbmFtZSkpOw0KPiA+IEBAIC00NzUsNyArNDc2LDcgQEAgc3RhdGljIHZvaWQg
YXNwZWVkX21hY2hpbmVfaW5pdChNYWNoaW5lU3RhdGUNCj4gKm1hY2hpbmUpDQo+ID4gICAgICAg
ICAgIEJsb2NrQmFja2VuZCAqZm1jMCA9IGRldiA/IG0yNXA4MF9nZXRfYmxrKGRldikgOiBOVUxM
Ow0KPiA+DQo+ID4gICAgICAgICAgIGlmIChmbWMwICYmICFib290X2VtbWMpIHsNCj4gPiAtICAg
ICAgICAgICAgdWludDY0X3Qgcm9tX3NpemUgPQ0KPiBtZW1vcnlfcmVnaW9uX3NpemUoJmJtYy0+
c29jLT5zcGlfYm9vdCk7DQo+ID4gKyAgICAgICAgICAgIHJvbV9zaXplID0gbWVtb3J5X3JlZ2lv
bl9zaXplKCZibWMtPnNvYy0+c3BpX2Jvb3QpOw0KPiA+ICAgICAgICAgICAgICAgYXNwZWVkX2lu
c3RhbGxfYm9vdF9yb20oYm1jLCBmbWMwLCByb21fc2l6ZSk7DQo+ID4gICAgICAgICAgIH0gZWxz
ZSBpZiAoZW1tYzApIHsNCj4gPiAgICAgICAgICAgICAgIGFzcGVlZF9pbnN0YWxsX2Jvb3Rfcm9t
KGJtYywNCj4gYmxrX2J5X2xlZ2FjeV9kaW5mbyhlbW1jMCksDQo+ID4gNjQgKiBLaUIpOw0KPiAN
Cj4gSSBkb24ndCB0aGluayB0aGlzIHBhdGNoIGlzIHVzZWZ1bC4gU2VlIGNvbW1lbnQgb24gcGF0
Y2ggNi4NCj4gDQoNClRoYW5rcyBmb3Igc3VnZ2VzdGlvbiBhbmQgcmV2aWV3Lg0KV2lsbCBkcm9w
IHRoaXMgcGF0Y2gNCkphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

