Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A47DD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6bk-0002bI-8Z; Fri, 09 Jan 2026 02:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve6ZN-00019l-RK; Fri, 09 Jan 2026 02:06:32 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve6ZJ-0004Fc-Op; Fri, 09 Jan 2026 02:06:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky0TI/9G1z1DfCuVyXVn7mbtr971EqTGN+k8AcNOAr7t0fUHRCOTYOO/nDaGDBdUP+wly8aLIgPoqJ3vPGRst7g3bA00mE8zzG6rgDo7sLJN96VHFDghIrXIKzPhknnfUDEYpZ582ovU8bwr/US2TFMKhDGVaDa7bRdcvpHXs+wu1kOsEdFr6x3dczmp249u9NJvJ/BAmSobJZ8YkoF7ajAiOy8o9hozyrCW1+YQd7Cnw2lHbql35Ti5lwrRuFFFkXNGSQH9gVq/zTjaqj8yVh2642O0kqAOwVeRNXmdSKCTLy9RvZOksTAWQJ55RrFAxelwSjDulH0wgnxDO2PpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bulWoGsbkx37CZM1aowNvUnUfDC1gpEe77pvrq+0B4w=;
 b=lbdcoViku8VdDUpuoT9ul2ZOmDJ0kQf2MnwH9VgYP4zWb4lv0hvwxsUJoNRsqf8Vi/pF9MyHUuznM4ODewZ+Wb0FavQxsEKnZJ3pYae0/YIYPYfI8KbJG5jYDp7RnEqMVGj6197BBXOLE/abfGfp+hxamWrGA//f9sNthSQf4kvqZTfNT+QDP2rOuutwwQTfrUII5b8cWVRVeFcwjvWgl4qLjNbdaR86hYb0b3j4ySw01wJlIbIOCdTlh9IA8IPh19PnQlkb3MbF1uf9RErlrTwlHkvVxdtQuHGO0i/a8bEhfPniZGdxVFbSOfHEaps5orQkf3MEGBiWChy+4wQXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bulWoGsbkx37CZM1aowNvUnUfDC1gpEe77pvrq+0B4w=;
 b=TvJOVaG8Xi2JG42GFeTEXVETFpWKhJ0zpYZD7x2/d0pwL0sBxxfbyp/PAWz8Vm1zZOWVT/JvHLstjR6vpS1AvLJ+lIrFv+r7NuWo77kZr7mlHcoqjjRAGJCy1X3HCSDArUvrNWXT9a5U5deRJD370AOd+PH2tGn0kkyHNDipq8wI4B/qGlq/6qBoVsvmqc2jasVVw6pRNx/IV39om0oDpQLZvgrcbjsnjSqvYnmqnHAzMSaUFY5dO7HxokWEm3m2RHWCsi8hpRqxepqKZbS44nKSkWg59VwT7+gQC1ddAGJC8tfUJe4VSIb3LFyzhRJH0/Fzztuv/LmDlleSKWbX9A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 07:05:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 07:05:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, Patrick Williams
 <patrick@stwcx.xyz>, Joel Stanley <joel@jms.id.au>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: RE: Refactor ASPEED INTC
Thread-Topic: Refactor ASPEED INTC
Thread-Index: Adx7t1aXXYHZ0YoZSLmzYzIi+9c1nQCq7JKAALTK9xA=
Date: Fri, 9 Jan 2026 07:05:48 +0000
Message-ID: <TYPPR06MB8206AD0B065D019AAB3F7C5CFC82A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <TYPPR06MB82060AAD1D538252B336AEA8FCBBA@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <1fd2f102-6a4c-4e6c-b9ee-a3e340763747@kaod.org>
In-Reply-To: <1fd2f102-6a4c-4e6c-b9ee-a3e340763747@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYUPR06MB6217:EE_
x-ms-office365-filtering-correlation-id: 4526010d-8e44-4923-0380-08de4f4d845f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cjJxRUxNbjMrN0ZIVUEwMFdhMC9hWlp6dHlISVZFWk1FekpPbmNxTTI1Wkhj?=
 =?utf-8?B?WWxjaFFOWktZWHA5eE1nTXBEV1NXUTVyai95WGdEY3VyN2hDT04yTXJPVFFk?=
 =?utf-8?B?N0dGZU5xY21RODVhZ2gvbEI0dGlXbE9zdnJ0cEN0MitER1VuM1RIdFJLUG5w?=
 =?utf-8?B?aUFoTWJZN25ISnF3M1BPUUQrRTU1VDVxMW5wTVhXYURjdnhkQjRyazR3RnNQ?=
 =?utf-8?B?ZEgwektnWFd3akVNWC9MTTBpK3R4ZVBtT0ZKNGpxbUl2RjQ1VlhYbTNGRzl3?=
 =?utf-8?B?SW9BdkMxSHMxTXNYb0N6WHNxWTQrNldwbStGdWs3SDFMVWk2MVhPVW8wVUdz?=
 =?utf-8?B?Q1dKc0VUSTVSY1I1NWhTOHV2ODAzVWlFcjZ2TXRBd2dzM3FzWkVFVmV5eVNu?=
 =?utf-8?B?Nk5QZFR2NWFlOFl2SS9Sd05sWVQ3dXVVdDFSQW81bjRsa2svR0FXOXhZZ2hw?=
 =?utf-8?B?VGhiNlU5dGg4RWhjQVRsZ0xZOXRlRENWL3NSSlY0RGQyMTVjUGgzank1QTc1?=
 =?utf-8?B?OTd1bXgwdmNMOENBWDZZbE1OdGdmOERreis2YmIwTmZLbjNpREp0TFk3QUhy?=
 =?utf-8?B?eFZDUitXQ0p2YkFpQVZYTGxsUmlhb0xKRTFkTFJVM3BDYjJrL3J3LzN4RUdj?=
 =?utf-8?B?THRMOWNWTjF1Z3BQcUs5RGNOL2VrYXY2UFQ0bVRTU0sybTRCWVU0Qzk0OGQv?=
 =?utf-8?B?aGZiRzFIckdtZnNuTVpLNmpDdXI3NUxwTDRBUDNVazliNEYxM2VjUVhIVjh1?=
 =?utf-8?B?SHdYeDBRYk1kbndycHJPWGFKZUsyMnpZOUxpd2o5cGxzQUtaSEdyYjF0Qmly?=
 =?utf-8?B?VERacUcyTWdZeWhlVVZjaW1xSGNYUy8wK3VYMy9BUFdYY1ZiSTJNTGs0WDlM?=
 =?utf-8?B?Z0IvcWFnVmNYWmZsdmoyaGJ3UzhXYS9tNC9zRUVQKzZ6bVcrRlA1bUpCdklN?=
 =?utf-8?B?dFBPS2VCZ1owRDcrU3BVQkw1Qm5WNFdLRVV2RzZIK3MzTDhpN096SEdDRW1Y?=
 =?utf-8?B?SjNLTDI2ZlJwSDlYUmhRZFVmYXF5Z3J0R3dPYmVYb2FrMGVuaWQxVXVvaW1o?=
 =?utf-8?B?N1dmM3ZLRk1JMFVKQTNkblVPUk02bGVpWUtCbkg1OTlBS2FLNFRyZ3BzZXhv?=
 =?utf-8?B?NmpmMGdwaWlQWTlwdTBuQlQ2TlA3OGprVFE0cnlkaVNiZEdySEZRZzRxVnFM?=
 =?utf-8?B?NkdtNTBDNWpvYk14YVpwUnRKWHc4VUtrMVdGUzhldnpOSm5ETWhHQU4rSWo4?=
 =?utf-8?B?MXBzQWp4M250d0YvU1ZVZHFUMTZBcElNKzdub3FkakNtWkZFaGR2a20vMG8y?=
 =?utf-8?B?a1ZyNUpvN1FsaER4aEtPZTkxSUM3ZzE4Nml2elZJLzFCb2Y4TFdBemNNK0hF?=
 =?utf-8?B?Zjk1YnBRNWFFb1NkTVlwMlhDSXNsbUdtOTZDOEE1TkZNclhmb1E5OTVCNGJi?=
 =?utf-8?B?OWN5dXpOMjF1dzBtZDJ1amQ1OHEwN2h5Vm9jTzRKdVBHMFVVTHc3RGpmS09p?=
 =?utf-8?B?UHRnZDhNSSs2UDlkZFZqWGNXU1lvclI2NU9lUHB4YURSWXRnRTNVT0lGRmE5?=
 =?utf-8?B?Qk9nRkpzQVlrRmdOZFh5SitIZTVXUExNNFQ1TUJCM0JuSUtxS0NiNGVwd3ZF?=
 =?utf-8?B?UzJ2VDJncStvT3g2d1ZzUytUNkE0MWlMTFZBaWxyeW1WZGJieWtQUHR3enhZ?=
 =?utf-8?B?Q24ra2xmRDdRS2pTOFUweTBuVERKSmJuS1VWWkQwcDkxZExmV2Y2Zk5LQkV5?=
 =?utf-8?B?WWlmQTJ2VU84cW9PZ0pacTBnTGUyYWRJaUVUNGVmWWd4MG1OWm50RHVkRWV4?=
 =?utf-8?B?SnZ2ajA0Ui9pZi85RjJRdisxRTlOcVVrenA1Rk15Qkx2RWJZNUhkRVBsTUMv?=
 =?utf-8?B?cWJOencvaUQvajFoaWxnRHQ3RWYxdTEwRTNKZXFuNmljeVRSRnp2VUo5UVdC?=
 =?utf-8?B?ZjdiTGV2bXBsZlpHdnhLOWtqK3EwQnZVblhROGk1Yks0eU1HZmh1czdxcVE2?=
 =?utf-8?B?c1ZCWWpkT3Y0WHhnRW9yakNpZHNzZUs5SVlPczBUUi9EaGdMK1A4a255Unhy?=
 =?utf-8?B?ajZKVHlrV0VJeE81YnREY3VqbzBZY29DUjQ2Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnp6RGc1UTJrclZGNlBtVDFIdkJKYnliM0xMdks1MW01UUYrNVV4NnFqb3l1?=
 =?utf-8?B?cGN4Z3lhcGc0bnZaVy9LY2pNSktwVXNwenRWeHl4a2txSGEwYisvbFQ5RVJG?=
 =?utf-8?B?RHF4UEMxdHNCUnJJQUJNRDZKaW5xWUZPWFlFRUJQQi9lQkJHK3R6cDNuV282?=
 =?utf-8?B?QkYwaDNBUVpFM01sWjF0Tzdlb252S3VMK2lQVDdJZ0lnT3g3MmpMdnkwRSs2?=
 =?utf-8?B?cExSZzU2U1ZYRG9XUklDTFJGeXZZa1dlQUc0Nk9PSVpESUpUdVk2N0t2dW9w?=
 =?utf-8?B?eVJKTEdHbHdoamZJOXQzMDRxTTVPekVrWWx6bnVab0NjVFhRNzJvanFsSUZs?=
 =?utf-8?B?Zm5UU0wxdlRVelZ1K3k2SFFPb21iU0ZFZEtTVW5SRVhHMHY3cHV4ZWlEVGJr?=
 =?utf-8?B?dnlnQzF0Wlk5cXAyeTJ2VG94OWZqN0kvQTIzTHg1UmdDMzRiNFJOYUswZ1FI?=
 =?utf-8?B?cnNubmM4R0pmMDhGMVkyRHpJYXprM3Z0YVdhQkkvZjMxSXl2U0JEOWpOU09u?=
 =?utf-8?B?L2JIY3o0QXhudU9kdlVDMlNoTGNBYXViaHhjQjEwOUwzcitXMFd2TkttNjdx?=
 =?utf-8?B?bHNVTStGMjJ1OGtRSE5JR0l1SE0rVXFJZ1dUYXM4bmdSVGxKcDhvVkcwUkVK?=
 =?utf-8?B?Qi9EQnlsUFlaV3NRWlpSczFGdXMwYTZHdzcyM1AzcHBuTWV4Wng3WktTL1ZZ?=
 =?utf-8?B?WC9NM2Y5emtOTnd5aG9VM1ozcVhyV3RSV00reXBMdFNVVTE5RHFYMEVuUHE1?=
 =?utf-8?B?c3RQQnMwMTQwS29lQUx4MkRYcWFRb1V0aFluWTZ4dHZEMTBJZDAxR1JHSVp5?=
 =?utf-8?B?Y0NOdkIwWVZsc1RDT0pVSE9JL015eWRhVGNzOGIxaCtkTFA4ZXltK3pYdkR6?=
 =?utf-8?B?ZHArRUtlQVE1WmhkZlZCRGtOdXBXQVZXRC9JR3JhUE1rYkhiUUkyUTcyWFNG?=
 =?utf-8?B?ZUIxTVhXMmhVTTNyYTd2eDZvOUlYai9BMmVRM0FGOS9sM1lXMytDenhod0g5?=
 =?utf-8?B?YnowQjZHUWdOSjRVL3lrOUNEOXBjU0ZLTkVrc2hjUkE3Q204MERIUXd6RmV6?=
 =?utf-8?B?aEZSOGRUNGV1N1JibGxWZll5N0IvbW9Dc2h1dWtmUWZad2pueHJraXZ1OHlz?=
 =?utf-8?B?UVhOcTJaUGI0cU1sZFBnZFZXYm1PM0RkK2M1Z0MzYkJoYUxBUGFkUW8xOUFy?=
 =?utf-8?B?MGZpcmpxVTk0SzVwWFdlVnpiNzN0L2tINDRmeEM1S1hOV1JzV0tWUzZXN3hx?=
 =?utf-8?B?QW15T2hjaS9lZTZGcjkvQ0kycU43M2xpbnFLTXc2NFg2VnROTFF0NUJWaGo0?=
 =?utf-8?B?UVJpQ0xpSXZpdGo3TXpvWUFZbURDdDVTRnZFYmtUVVpjTUZQODhFTE5lUHRj?=
 =?utf-8?B?NFVPbDBvSjd0clBUZHV2Z3ZCNzUrV2xlQSsycVpDMDdxWERPNDJtN29PQ2JJ?=
 =?utf-8?B?Wklsem1FRTFrUEpIdU8wRzQraUZqZXhzZk9LZFVjWnlQZDlNdThsNzZFVHgz?=
 =?utf-8?B?a0h2OEdoaGthU3NFSE94SHBnYVR1S1gxNzB5QXN5djJ2Z0RxQzdTOVpNRmRI?=
 =?utf-8?B?a3BtejV0SS8ydEhJakozRWZIZTlLM1FsZllyaWR6VkxjaWpaaGVwVmdST0pX?=
 =?utf-8?B?WTM1MzF2U1hxTWl1eVd6R2lPaHdXL3NlakNwdFpwS2haYitmYnFsTlpxZnNC?=
 =?utf-8?B?WHphOEM0bzlTdmx4Q1NIazZ2dDRqdllnUjJ5WmhSZG5xdk9iRWd0Z052UEFH?=
 =?utf-8?B?Um4wZU04R0JjbXN0WEFreldWeFF5eFRodWFoWEt1OUhkNDVvdjNVSjd4aFp5?=
 =?utf-8?B?bVplWHRIaGpUbU05Z3BoNkRad2tSZEt1OU1NQTJXaDB0T24xNUpUSGtwMUps?=
 =?utf-8?B?Z3NHRThXUVJZcW4yckFKaVR0YldRTnIvanZOS1FtcU4rdklUajdCaUZuN2M0?=
 =?utf-8?B?WmoxeUZhOGtkbHViZXYyK2QxUStGalhqWjBza3FjT2JXeEZ6N0FIZUMwTm4y?=
 =?utf-8?B?QW5MYVUvRkppU1FjcWdYS3d3aUJ4NmRUUHl6SFNzY2tqdmxSeG8yWjUvRVFr?=
 =?utf-8?B?T3prTnBJQUk1TitmMzM1THY1YW01SGRYeVJKbDJ0a0tMdnY0eUJpNTVoRS8r?=
 =?utf-8?B?cnFoTTlWd001bWs5dXRNdFZhTGFXSnk0bFIxRFlFOTlkdUYzd1ZHV0V3UGVa?=
 =?utf-8?B?N1hOZWdaSDYwazNXS2xaN05NV0t2U010YWlOeTlFNTFWNjcrUW9SQ2Y2aVF3?=
 =?utf-8?B?N20rQnF3bnBUaEhROVBhSWMvNHdtZHZUS2Q3T1JLaWhMTWRCMDdVT21IbTlu?=
 =?utf-8?B?aVRHWWV0LzdwTEVkdFRmYVd2SUUzZ0NpWFZ2aGh4Sm9KVEhxSkFLZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4526010d-8e44-4923-0380-08de4f4d845f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 07:05:48.4555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCfjemWi51w4fw8Z4Be3ieklcvutTH7cPzpytIhb0wLu19bEWUBZPmeNIEvPHjUDxOCW24hTkfDy2hMZOszP7stg/07dvK9ARAX+hv0k84E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6217
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuIEnigJlsbCB1cGRhdGUgaXQgbGF0
ZXIgYW5kIHByb3ZpZGUgYW4gZXhhbXBsZS4NCg0KSmFtaW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBT
ZW50OiBUdWVzZGF5LCBKYW51YXJ5IDYsIDIwMjYgMTI6NDggQU0NCj4gVG86IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQ8OpZHJpYyBMZSBHb2F0ZXINCj4gPGNsZ0ByZWRo
YXQuY29tPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+
IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogVHJveSBM
ZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgS2FuZSBDaGVuDQo+IDxrYW5lX2NoZW5AYXNw
ZWVkdGVjaC5jb20+OyBuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbTsgUGF0cmljayBXaWxsaWFtcw0K
PiA8cGF0cmlja0BzdHdjeC54eXo+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgcGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRl
Y2guY29tPg0KPiBTdWJqZWN0OiBSZTogUmVmYWN0b3IgQVNQRUVEIElOVEMNCj4gDQo+IEhlbGxv
LA0KPiANCj4gT24gMS8yLzI2IDA4OjUyLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgYWxsLA0K
PiA+DQo+ID4gKkkgYW0gY29uc2lkZXJpbmcgcmVmYWN0b3JpbmcgdGhlIEFTUEVFRCBJTlRDIGRl
c2lnbi4qDQo+IA0KPiBGb3Igd2hhdCBwdXJwb3NlID8NCj4gDQo+ID4gQWNjb3JkaW5nIHRvIHRo
ZSBwcmV2aW91cyBkaXNjdXNzaW9uLCBvbmUgc3VnZ2VzdGlvbiB3YXMgdG8gY3JlYXRlIHNlcGFy
YXRlDQo+IG1lbW9yeSByZWdpb25zIGZvciBkaWZmZXJlbnQgcmVnaXN0ZXIgZ3JvdXBzIGluIG9y
ZGVyIHRvIHJlZHVjZSBjb2RlIHNpemUuDQo+ID4NCj4gPiBUaGUgdG90YWwgcmVnaXN0ZXIgc3Bh
Y2Ugb2YgSU5UQyBpcyAweDQwMDAgKDE2IEtCKSwgYW5kIHRoZSByZWdpc3RlciBzcGFjZSBvZg0K
PiBJTlRDSU8gaXMgMHg0MDAuDQo+ID4NCj4gPiBCYXNlZCBvbiB0aGlzIGlkZWEsIEkgY3JlYXRl
ZCBhIEdJQyBtZW1vcnkgcmVnaW9uIHdpdGggc2l6ZSAweEIwOCBhbmQNCj4gbWFwcGVkIGl0IGF0
IG9mZnNldCAweDEwMDAuDQo+ID4NCj4gPiBSZWxldmFudCBsaW5rczoNCj4gPg0KPiA+DQo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0LzdmZmVlNTExZmNmMTQ4N2UwMTZhZTFk
MTFjNWUxOTE1DQo+IDU3DQo+ID4gYThiODA0DQo+ID4NCj4gPGh0dHBzOi8vZ2l0aHViLmNvbS9x
ZW11L3FlbXUvY29tbWl0LzdmZmVlNTExZmNmMTQ4N2UwMTZhZTFkMTFjNWUxOTENCj4gNTUNCj4g
PiA3YThiODA0Pg0KPiA+DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNTAyMTMwMzM1MzEuMw0KPiA+IDM2NzY5Ny0yLWphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbS8NCj4gPiA8aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNTAyMTMwMzM1MzEuDQo+ID4gMzM2NzY5Ny0yLWphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbS8+DQo+ID4NCj4gPiBBcyBtZW50aW9uZWQgaW4gdGhlIGRpc2N1
c3Npb246DQo+ID4NCj4gPiBgYGBgYGBgDQo+ID4NCj4gPiBIb3dldmVyLCB3ZSBjb3VsZCAib3B0
aW1pemUiIGEgYml0IHRoZSBNTUlPIGFwZXJ0dXJlcyB0byBhdm9pZCBtYXBwaW5nDQo+ID4NCj4g
PiBodWdlIHVudXNlZCBnYXBzIGFuZCBvbmx5IG1hcCB0aGUgdXNlZnVsIHNldCBvZiByZWdpc3Rl
cnMgOg0KPiA+DQo+ID4gIMKgwqAgSU5UQyBSZWdpc3RlcnPCoMKgwqDCoMKgIFsgMHgxMDAwIC0g
MHgxQjA0IF0NCj4gPg0KPiA+ICDCoMKgIFNTUCBJTlRDIFJlZ2lzdGVyc8KgIFsgMHgyMDAwIC0g
MHgyQjA0IF0NCj4gPg0KPiA+ICDCoMKgIElOVENJTyBSZWdpc3RlcnPCoMKgwqAgWyAweDAxMDAg
LSAweDAxNTQgXQ0KPiA+DQo+ID4gRWFjaCBzZXQgd291bGQgYmUgYXNzb2NpYXRlZCB3aXRoIGEg
c3VicmVnaW9uIHdoaWNoIHdvdWxkIGJlIG1hcHBlZCBhdA0KPiA+IHRoZSByaWdodCBvZmZzZXQg
aW4gdGhlIHJlZ2lvbiBjb250YWluZXIuDQo+IA0KPiANCj4gSU1PLCB3ZSBzaG91bGQga2VlcCBv
bmUgZGV2aWNlIG1vZGVsIHBlciBIVyB1bml0LiBTbywgMiBJTlRDIGRldmljZSBtb2RlbHMNCj4g
Zm9yIHRoZSBBU1QyNzAwIFNvQy4NCj4gDQo+IEhvd2V2ZXIsIGlmIHRoZSBIVyB1bml0IGhhcyBt
dWx0aXBsZSBzZXRzIG9mIHJlZ2lzdGVycyBncm91cGluZyByZWxhdGVkIGZlYXR1cmVzLA0KPiBp
dCBtYWtlcyBzZW5zZSB0byBpbnRyb2R1Y2UgYSBzcGVjaWZpYyBtZW1vcnkgc3ViIHJlZ2lvbiBw
ZXIgc2V0IG9mIHJlZ2lzdGVycw0KPiBhbmQgbWFwIGVhY2ggb2YgdGhlbSBpbiBhIG1lbW9yeSBj
b250YWluZXIuDQo+IA0KPiBUaGlzIGNvdWxkIG1ha2Ugc2Vuc2UgZm9yIHRoZSBJTlRDMCB1bml0
IGJ1dCBpdCdzIG5vdCBhIHN0cm9uZyByZXF1aXJlbWVudC4gSQ0KPiBkaWRuJ3QgbG9vayBhdCB0
aGUgb3RoZXIgSU5UQ3MuDQo+IA0KPiA+IGBgYGBgYGANCj4gPg0KPiA+IEhvd2V2ZXIsIGFmdGVy
IGltcGxlbWVudGluZyB0aGlzIGFwcHJvYWNoLCBJIHNlZSBzZXZlcmFsIGlzc3VlcyB0aGF0IG1h
a2UgaXQNCj4gZGlmZmljdWx0IHRvIG1haW50YWluIGluIHRoZSBsb25nIHRlcm06DQo+ID4NCj4g
PiAgMS4gUmVnaXN0ZXIgb2Zmc2V0cyBubyBsb25nZXIgbWF0Y2ggdGhlIGRhdGFzaGVldA0KPiA+
DQo+ID4gRm9yIGV4YW1wbGU6DQo+ID4NCj4gPiBSRUczMihHSUNJTlQxMjhfRU4swqDCoMKgwqDC
oMKgwqDCoCAweDAwMCnCoCAtPiAweDEwMDAgaW4gdGhlIGRhdGFzaGVldC4NCj4gPg0KPiA+IFJF
RzMyKEdJQ0lOVDEyOF9TVEFUVVMswqDCoMKgwqAgMHgwMDQpIMKgLT4gMHgxMDA0IGluIHRoZSBk
YXRhc2hlZXQuDQo+ID4NCj4gPiBUaGlzIG1pc21hdGNoIG1ha2VzIHRoZSBjb2RlIGhhcmRlciB0
byB1bmRlcnN0YW5kIGFuZCBtb3JlIGVycm9yLXByb25lLg0KPiANCj4gSG1tLCB0aGF0J3Mgbm90
IGEgc3Ryb25nIGFyZ3VtZW50LiBUaGUgbmFtaW5nIGlzIG1vcmUgaW1wb3J0YW50Lg0KPiANCj4g
PiAgMi4gU2hhcmluZyBJTlRDIC8gSU5UQ0lPIGJldHdlZW4gUFNQLCBUU1AsIGFuZCBTU1AgYmVj
b21lcyBjb21wbGV4DQo+ID4NCj4gPiBUbyBhbGxvdyBUU1AgYW5kIFNTUCB0byBhY2Nlc3MgdGhl
IHNhbWUgSU5UQyBhbmQgSU5UQ0lPIHJlZ2lzdGVycywgd2Ugd291bGQNCj4gbmVlZCB0byBjcmVh
dGUgbWFueSBtZW1vcnkgYWxpYXNlcywgd2hpY2ggc2lnbmlmaWNhbnRseSBpbmNyZWFzZXMgY29t
cGxleGl0eS4NCj4gd2h5IG1lbW9yeSBhbGlhc2VzID8gSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5k
IHlvdXIgb2JqZWN0aXZlLg0KPiANCj4gPiAgMy4gUG9vciBzY2FsYWJpbGl0eSBmb3IgZnV0dXJl
IFNvQ3MNCj4gPg0KPiA+IEN1cnJlbnRseSwgd2UgY3JlYXRlIHNlcGFyYXRlIFNTUCBJTlRDLCBT
U1AgSU5UQ0lPLCBUU1AgSU5UQywgYW5kIFRTUCBJTlRDSU8NCj4gbWVtb3J5IHJlZ2lvbnMgb25s
eSBmb3IgQVNUMjcwMC4NCj4gDQo+IFFFTVUgbW9kZWxzIGFsbCB0aGVzZSBpbnRlcnJ1cHQgY29u
dHJvbGxlcnMgOg0KPiANCj4gICAgICAubmFtZSA9IFRZUEVfQVNQRUVEX0lOVEMsIChhYnN0cmFj
dCkNCj4gDQo+ICAgICAgLm5hbWUgPSBUWVBFX0FTUEVFRF8yNzAwX0lOVEMsDQo+ICAgICAgLm5h
bWUgPSBUWVBFX0FTUEVFRF8yNzAwX0lOVENJT0VYUDIsDQo+ICAgICAgLm5hbWUgPSBUWVBFX0FT
UEVFRF8yNzAwX0lOVENJT0VYUDEsDQo+ICAgICAgLm5hbWUgPSBUWVBFX0FTUEVFRF8yNzAwX0lO
VENJTywNCj4gICAgICAubmFtZSA9IFRZUEVfQVNQRUVEXzI3MDBTU1BfSU5UQywNCj4gICAgICAu
bmFtZSA9IFRZUEVfQVNQRUVEXzI3MDBTU1BfSU5UQ0lPLA0KPiAgICAgIC5uYW1lID0gVFlQRV9B
U1BFRURfMjcwMFRTUF9JTlRDLA0KPiAgICAgIC5uYW1lID0gVFlQRV9BU1BFRURfMjcwMFRTUF9J
TlRDSU8sDQo+IA0KPiBTbyB0aGUgY3VycmVudCBkZXNpZ24gbG9va3MgT0ssIEFGQUlDVC4NCj4g
DQo+ID4NCj4gPiBTdXBwb3J0aW5nIGZ1dHVyZSBTb0NzIHdvdWxkIHJlcXVpcmUgYWRkaW5nIGV2
ZW4gbW9yZSBtZW1vcnkgcmVnaW9ucywNCj4gd2hpY2ggZG9lcyBub3Qgc2NhbGUgd2VsbC4NCj4g
Pg0KPiA+ICA0LiBUb3RhbCBtYXBwZWQgc2l6ZSBleGNlZWRzIHRoZSBvcmlnaW5hbCBJTlRDIHNp
emUNCj4gPg0KPiA+ICpUaGUgc2l6ZSBvZiBTU1AgSU5UQyBpcyAweDJCMDggYW5kIHRoZSBzaXpl
IG9mIFRTUCBJTlRDIGlzIDB4M0IwOC4NCj4gPiBUaGUgY29tYmluZWQgc2l6ZSoNCj4gPg0KPiA+
ICooMHgyQjA4ICsgMHgzQjA4ICsgMHgwQjA4KSBpcyBsYXJnZXIgdGhhbiB0aGUgb3JpZ2luYWwg
SU5UQyBzaXplIG9mDQo+ID4gMHg0MDAwLCB3aGljaCBpcyBjb25jZXB0dWFsbHkgaW5jb3JyZWN0
LioNCj4gDQo+IFRoYXQgSSBkb24ndCB1bmRlcnN0YW5kLg0KPiANCj4gPiAqQmVjYXVzZSBvZiB0
aGVzZSBjb25jZXJucywgSSB3b3VsZCBsaWtlIHRvIGNoYW5nZSB0aGUgZGVzaWduIHRvDQo+ID4g
Y3JlYXRlIG9ubHkgb25lIElOVEMgYW5kIG9uZSBJTlRDSU8gdG8gaW1wcm92ZSBtYWludGFpbmFi
aWxpdHkgYW5kDQo+ID4gY29ycmVjdG5lc3MuICoNCj4gDQo+IElzbid0IHRoYXQgdGhlIGNhc2Ug
YWxyZWFkeSA/DQo+IA0KPiBTZWUgYXNwZWVkX3NvY19hc3QyNzAwX2luaXQoKSA6DQo+IA0KPiAg
ICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImludGMiLCAmYS0+aW50Y1swXSwNCj4g
VFlQRV9BU1BFRURfMjcwMF9JTlRDKTsNCj4gICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChv
YmosICJpbnRjaW8iLCAmYS0+aW50Y1sxXSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBUWVBFX0FTUEVFRF8yNzAwX0lOVENJTyk7DQo+IA0KPiA+ICpJbiB0aGlzIG1vZGVsLCBjb3By
b2Nlc3NvcnMgd291bGQgb25seSBuZWVkIHRvIGNyZWF0ZSBhIHNpbmdsZSBtZW1vcnkNCj4gPiBh
bGlhcyB0byBzaGFyZSB0aGUgSU5UQyBiZXR3ZWVuIFBTUCBhbmQgU1NQLioNCj4gDQo+IEkgdGhp
bmsgeW91IG5lZWQgdG8gZXhwbGFpbiBtb3JlIHRoZXNlIG5ldyByZXF1aXJlbWVudHMgdG8gZ2V0
IGZlZWRiYWNrLg0KPiBXaGF0IGFyZSB5b3UgdHJ5aW5nIHRvIGFjaGlldmUgPw0KPiANCj4gVGhh
bmtzLA0KPiANCj4gQy4NCg0K

