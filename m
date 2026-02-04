Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A76E83EE3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8i-0005tx-Ue; Wed, 04 Feb 2026 02:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZ3-0004Wc-FA; Wed, 04 Feb 2026 01:40:39 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWYs-0004H5-PH; Wed, 04 Feb 2026 01:40:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqVWWcIm5mHy6BubKhUZGxMRHMDcentmqIBbZeBAIXKsotpZlACLu2A3i9PqTBFUHvwxbBhoNa7U9PQkFXnP4dldOYQApLITN+bjABCV4gYAvly/OwO4NLroFBTTGZwX0QO6w1JrbqHOJ+O3yF9/O66CKSj1BGStxw9HawHxeZPZuEidLPlajDRhQ+V9mJG+KzM1fByZzPzn7Zft1vHaVWDGhtcT8guUG6iUrB/+jQYcAx/QmLd1WQ8esSAn4RhQZIgvrkNW9PmjCD6RA+LP7TzB5rgebGfjrQQzZlNG/s9eKzDKHbE4jwQlMhMrDpCh7D9O5zuhdZESl2LuZm/zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAuq0DjXRGOJpfNhWy+gE05qRc3lZOQsYt9g+4v6Q9c=;
 b=oKNHBiqIV6YiIknPAqbCraFwCpW+3Ouwxsj9F1Kka5qDk93s3jZXkkULaW/ssYZc/rpghtK1aQcy9AhDRiVw+qXGYEywwX5JNAbyg3oCx3v6fHp61J962l4p/RZJsIFM+/+P3SxeYCiFW8TwRbbLigGjOuNmnVD/mKT9t7ylOObv6CYK7sBmQ8+cQxocQE26iW7HYkd19/zZkeujWK3FnCsWSr+cm34DpHkBybMxMgdynyt1lBR/vzDr7yAuxvOha03DPN85RC6+EVQeX892afuy/fWzK3Tz+HSrsuuPtmqdBV17Vq2ea5Nz+x/z2g4XnQojEX2+vobbttfQgJxdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAuq0DjXRGOJpfNhWy+gE05qRc3lZOQsYt9g+4v6Q9c=;
 b=OAgWjTaLz9WJFGv75t4p0rJ0ir/KFzCPIvIxzseo+abcmqjcwDK0jJ92fo4uswTtLOzGPe86xHSOrA5FaLWnGzCuNhMI4hbBE4SA5rfn1rwpDFqgNMEwQuE9VaiQSGvxWlyp49mom/4/2vnTcCCOirvv0GOosFbwbiUbyjRUPFNYBrbkAdYmbDC+FHv5EwxY7UWlvjrO41jxrCkAvjTEuZ/sUC9v/PS5z9Nx0erOleXtric990hqC0crwlyZAm6bhlplHsIkvhyUecj2V+R/G6vobBeGo8z8m7w+q3DfN704fxSPntQZ/0fYzORvBZNN4pzk2TuZ//zIwCu5BV5igg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYPPR06MB8036.apcprd06.prod.outlook.com (2603:1096:405:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 06:40:18 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:17 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v6 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHclaEgqcQ/fMEZWUWKZPwHiYpOTQ==
Date: Wed, 4 Feb 2026 06:40:17 +0000
Message-ID: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYPPR06MB8036:EE_
x-ms-office365-filtering-correlation-id: 7cf78a06-1acf-42e6-b33e-08de63b842c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Tmx5ZTJJZWZVRUQyZGxKS0FCNWZGa0V3eEluSGUxKzlUSFM2S3B2SUM0em12?=
 =?utf-8?B?eGRCQXBjc2VmTEVsUXJ5aWVHZy80RnJZUUFIY1pvbjJFL1BsM3pWMjhkTWpS?=
 =?utf-8?B?VHJMb3A5U2tjS2hKSWpoSmlGM3ViN1l3TWdPcmE5ZTJJTUg5YnBvZ2tubTIz?=
 =?utf-8?B?OEJDQzh2ZjJxWUFtRmZleUdlckdpYkhJbmw5TyswSG11Q1pXTDAvUWY4L1h3?=
 =?utf-8?B?TGVmdzBqdmZVa2RGN0FLYTN6MGJ3T0V4SXhHREh3MDFmR2QyV1d5cml4RDV3?=
 =?utf-8?B?SjlwWmQyMkU4aldOajExc3kwRm5kQUNPaFRTcXNYc3VGNFkxZjlHRHZ6SEFT?=
 =?utf-8?B?aTZka3lGbFc2SFl1dFhQNnNDUzVOY3pWUWZvYUxWdGp2N245Y2dtbjdDd1pQ?=
 =?utf-8?B?cXdYSVNkMmxtOCs2MUtBcnE0NC9KMUd1b2pSVTJpdEZPUHZ6TCt6NGhqYSts?=
 =?utf-8?B?eGN1cDJ6clByL3R3MWQ5QkI0YzgwejVoMlFjT3BwR3l0MVpxSnJKWjJzSHh3?=
 =?utf-8?B?by9wUzdydU5MUDJwb1h2SWtmWE5pRlVobG1YdVN4bjZpUDE2K3BrUUthcmFE?=
 =?utf-8?B?ZCtSaWhQRXZDL2VqT0dzV2pIUEg0cGt3cnlwKzNKZ3ZTdHJObUxlNCt0OHlx?=
 =?utf-8?B?c1AyRU1nUjF1NVdCNGdXTXgvRHJIdGp3cUZtc1FTd3BzK2hRemhaOVNUYk9E?=
 =?utf-8?B?UngrdnI4TGhMZE9xVVJzSVo2bkV4WWRVanl6SDZHakpVTkdpQXdmcmtOeStU?=
 =?utf-8?B?Q254TFVZU3RnUVBBZE1wbWhxMWxYaCtPblo3bWR0ZUNEMkwwRnhtZEhHUXRy?=
 =?utf-8?B?cHAyTWVMc08vbjRxRmd3amVhVVhTR1Q2VVV1MDZPZVNRSnlHNFJwSE5CNVBU?=
 =?utf-8?B?RGxVSGxWalI0b1VaZVIwdThKSjJ1U3NIN2duQTI3UXNKTlJEUmRnYnBFSnlF?=
 =?utf-8?B?V0pPUWRFUW1MSiszUWYyR3A5dXBjQjU3R016b3FibzQ4c1Rjc3p2TVlOMmc2?=
 =?utf-8?B?SHJ3eUNIcWJMT1diTzFGOTJINUY2NzViQkYzVWM2dUNaS3hFTU9KNGFsNVpK?=
 =?utf-8?B?TkdmV0VKMWZZcG1JN2ZxaFFjNEl3Vmp0cFBBUFJ4SVZoRlB2S1BUNlRKcVcz?=
 =?utf-8?B?R04rNmY0SHV0K2hXS2FJUzZmYUw2WUs0RzYvb1pUKzliNXRIcno5Umlzc1Js?=
 =?utf-8?B?ZEQ2VGNWdEVVRzFLZzFFSk0zRzlMb3NNMVBROFRaditVS0RqWmp2VVluQkpt?=
 =?utf-8?B?SnQzdFFGR3BOM0U0dFpWNzR0clFQclRiMGx6T0JDT29ZbTN6NDZTTnJNdXNw?=
 =?utf-8?B?Q0tVOE52NEtxYksrYkdOTHRkWEhHaXErZEdQMWcwWnlET08zUFZoVU9qaFYx?=
 =?utf-8?B?Qkp0UEpyNk5mUEJGUzJoa0IvdkNtVFdXMS9vcGppc3Y4aHhuUndKMTV0ckVR?=
 =?utf-8?B?aUZaa05qbitqb3VlVmVLTjQ3V1ZXVUw4K3lLa2JkTU02akFwelY3NjFJMTRD?=
 =?utf-8?B?QXNDWEdZTG4xMGpYWGQ2eGxsOThPSXVJRHVpbWZaSXh2bkIvYnY2TVkxQ29I?=
 =?utf-8?B?ekdZN0g3ZWFUQXJQcFYyMUpGcE11clJYM0xncW1MaEpPb2hSalFSb0Y0cjhy?=
 =?utf-8?B?Um5PNm9qSmJEQ2g0OCs4aTdOVnJjM0VYblNSeU1ZL04yTkE3Vko2QlBGREQ5?=
 =?utf-8?B?dUdYMiswdVN5QWtzRWhYZHc4aTVIMmtDUGlLQ2cvNzd2ZUJGRnhCNTdiVktn?=
 =?utf-8?B?ckNhajlmeDVRaTVlU2lzOTQrYm9Bb3JFd2dsWTZOVmkyamZuSnphSUowNUlR?=
 =?utf-8?B?blF3SXpOQ1BXZk5Yd095OUQ2T3o0clhBVW9xZDNiT2dvZ2IzM0hRYU1MM2N6?=
 =?utf-8?B?cCtUVTFNSVhyekpKYjJqTDE0d0puVDNrT0hpc3VvQllzd3dwK2h2ZUIzdnZl?=
 =?utf-8?B?WlhzVkRvb0VYMG5XWDI2bks2bERsMnZFS1c5aU1pRWlIVVJEajNJZDVycDRE?=
 =?utf-8?B?Um5QZVN1U2NSLy9DL0d0bkRCWm1DelNUamdRK0ZOZUhlS21UWC9ETGtNb0I0?=
 =?utf-8?B?dW1tOHB0Y1R4ME0xbVFjWWpEaml1ZG1xMXY3NGl3WnpYUTk4ZFVSdUFaT0h3?=
 =?utf-8?Q?TXT98rt1INzMb+/3qgPQuKxiU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE1OSmtZb1FvNzhVbThlK2p4aHdpVk9qSFdQOWdlZ3JxZ0JtOWZNZm1UYXdk?=
 =?utf-8?B?dlo3cGpSSjd6NHUwamxKL3FFaDlwNlVLWkg1VU8wNllyVGRqRDFGQ1IvR1M2?=
 =?utf-8?B?YnErdmoyTUhMUHdkWTE1ekxTWi9pS3F4RXZrOUJrbXE5Q0l1M2p1ckQvS05X?=
 =?utf-8?B?MFlpSmlHNUZrLzg5d1ZFZTc0Z0FOWHQ4bGNHN0FwWXIrRDFjeEVjS0pLbDMy?=
 =?utf-8?B?VnFJbmNRMlArd3o3c1RNK0QyOVNKUktUM0FHVWNJaGN3TGZVRndFQ0VVWTho?=
 =?utf-8?B?QWlldkdQZjZpd0JPSDV1UjR1aVV6SVpxQUU0RXdOOVJiUVVRS0ZJcjRkZ2tx?=
 =?utf-8?B?VmZrUGdkQjdETUJFTXJFcCtUMitBb0pwRTdZVlc5blJZUmIrSkVqKzF1S0RK?=
 =?utf-8?B?eXNtRWw5YjV1QlJ2ZXNRSUkrN0MyWDNvN1h0SjVieWJQVS9zdTJqLzRpQksv?=
 =?utf-8?B?RmhxcldEbW9tYXUyMlFXRk1mZEpHZG13aHhyUXU2SlB2MERpWGNtRXh0MllS?=
 =?utf-8?B?OTU3T0QwRFA3Z1ZxZWlVL09lcjkrck1OVnEwNWd3TktXcGVmR0hIb1VURVRo?=
 =?utf-8?B?bDhMQmVIeHcyeEdud2VVblYyeXgzazBCM3pLenJ5RmRsdGVpM2NSV0hCVTQy?=
 =?utf-8?B?SGVaMzhDZVRpTFRCWUVYUW1HZVh3SXdsQzVFemNlMW5pYWlJdWV5Z0Rucy85?=
 =?utf-8?B?Mm5ZSmFEVUFOSzFwSUdyTVBMdktDK3RxcGY2Q2xKb3ZTU2FQeUE2MWh1Y1p3?=
 =?utf-8?B?bG1FQjRtMWRwbHJkaTREamltOHkyb0h4WUJrNE9WWnJxTkVkY1VyNmlWWnVl?=
 =?utf-8?B?SktldHFha3dlai9aamxsa0NycC92V3hJSitXVmZqMHpYZXV3b1hLRk5nTk9F?=
 =?utf-8?B?Rk9Ba3d6NWxPT1luNkdtcWdodzhNV1UyU3RQRnh3VlQwZkZCc1g0cEZtUWhn?=
 =?utf-8?B?OVM4WURxZGNsNFNlSmluQWNSdDhaQnh6eUZ1REpacWxqc2NyU0srTmVNSXVl?=
 =?utf-8?B?aE9sdHQzeEtCdDZ6R0pKTTgxVksxQ3h4Mk1xb3hqMkljQjZ4SnJwbWlkQ1pv?=
 =?utf-8?B?WStjbkhaNjgwdm9kSk5NSXlvaGdrYmlDZ214ZzBSK3d3S1d0MzB1YmlRRmgw?=
 =?utf-8?B?WHNTcUhZNFo2QWlBTkc3Q05rd2hYUUllRjJHenFycnBZTU9iMnBSMlY4ME1Y?=
 =?utf-8?B?MGZLOEg4VGYxR1JpRFd4MjZDSERZdkpXMVNnLytteFNaYVJCaVR4V0xqSi9p?=
 =?utf-8?B?NDJabFArc1F5bE1OT2owdkpab0o4OGt0UElTcWFpdWZDcGI0MVFGMndTcGRS?=
 =?utf-8?B?NlFyTmRtaGJUQk9iSkpKeCtveHE2RVRhbDFGd2hEVzFJMU5BUXFhdXFzUTc3?=
 =?utf-8?B?aFZ5ZWRIQi85djh0aGZyVE1nOTJmUnR0ekZiRUlXR3F6eEROaksycDJNeEU3?=
 =?utf-8?B?aFBUVk5NS1d0MlZsQnpkSjgvVkVOU2ZLcUlTcWxRMW5raVhMb1REZmdBZnll?=
 =?utf-8?B?M1BvVGp4NzdoSXlQLzlIRmIyKzkyYStybHdxbmxnZW5VTmtXTGlmcGRXMzF5?=
 =?utf-8?B?NlpaVmNXeDNJUHYrSUdyMmZrOWN4Nk1BSVN2QzlhTzdQY2dFRkpVOVVxV1ZR?=
 =?utf-8?B?WWVlYXpRTVhma0NLYjNZZFdjSTRnTzlzTG8zeGc5cXN4Qm1RQlh2NURlQTg2?=
 =?utf-8?B?MjFZWVNaTXpFSkdJN1pvMGFuU0hlTmliNG16aVppQUpqMjN2M2VpU2RaTUpx?=
 =?utf-8?B?WUN0WXNjbmxvUXpEcGFYSWNnaC9kalc5MWprTGVLRXFRQzRXM2p4MDlkV0RO?=
 =?utf-8?B?SWZxWWJxbkRtbERkYWd3ejNhODZVNlNIRzJnTFVtUVBvUlNxTnRCZXBKUkZF?=
 =?utf-8?B?YTZIMGhCZVV5a2FNOW5PZjhuODVCYjgxZ1VwYnlSaHkyMXZNQnFRRmlFdW53?=
 =?utf-8?B?a2ZpWFgvQ2RldVBZWkVtUmN2bEtKNGVrY3d3N3ZrbitIUmlia2ppOFRmQVRr?=
 =?utf-8?B?clAzN29jVStLZi9xcG5oTWFrTEVGVmF0dkl3Q1FEa0g5bE56enljMHQyMFVE?=
 =?utf-8?B?UUJnc2RESVdTS0dKUU5ORVdnYlk1QVpVMlYxbWJNQmxMVm1IQmVMTmdSNDdC?=
 =?utf-8?B?Zmszdmt2aEFMbnY4TDFvZFdhRzZicktXVzRobXl0dnFnUkRIa3hiQ0w4QmZj?=
 =?utf-8?B?d21hSEpFYm5JRU9meDBnem11NVUyQ1lsa3Z4NGFYWEdIUDdtQ0l4cnlmeEU3?=
 =?utf-8?B?VjhtUnZBMlBPVThCUG1LbXd1SFRSNDJSYmxrSUVnbTV1S3dVZWtRcWRzeFJW?=
 =?utf-8?B?YXFvaU1YcUdnNFBOZWtqWTNvcURSNFY3MHUzT1Joalp6SWo2TURHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf78a06-1acf-42e6-b33e-08de63b842c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:17.8265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPB9u3YZJ5wy46CL0KFBsjDRwBA0xGdHicYwldwISWOXsN5UR0loVlD/DdY6tk2yEo+86yMxuR2Au4x4NkQSpTBD+IcgEUVEyrNzvI/iq2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8036
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:14 -0500
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

SGkgYWxsLAoKTFRQSSAoTFZEUyBUdW5uZWxpbmcgUHJvdG9jb2wgJiBJbnRlcmZhY2UpIGlzIGRl
ZmluZWQgaW4gdGhlIE9DUCBEQy1TQ00KMi4wIHNwZWNpZmljYXRpb24gKHNlZSBGaWd1cmUgMik6
Cmh0dHBzOi8vd3d3Lm9wZW5jb21wdXRlLm9yZy9kb2N1bWVudHMvb2NwLWRjLXNjbS0yLTAtbHRw
aS12ZXItMS0wLXBkZgoKTFRQSSBwcm92aWRlcyBhIHByb3RvY29sIGFuZCBwaHlzaWNhbCBpbnRl
cmZhY2UgZm9yIHR1bm5lbGluZyB2YXJpb3VzCmxvdy1zcGVlZCBzaWduYWxzIGJldHdlZW4gdGhl
IEhvc3QgUHJvY2Vzc29yIE1vZHVsZSAoSFBNKSBhbmQgdGhlClNhdGVsbGl0ZSBDb250cm9sbGVy
IE1vZHVsZSAoU0NNKS4gSW4gRmlndXJlIDIgb2YgdGhlIHNwZWNpZmljYXRpb24sCnRoZSBBU1Qy
N3gwIFNvQyAobGVmdCkgaW50ZWdyYXRlcyB0d28gTFRQSSBjb250cm9sbGVycywgYWxsb3dpbmcg
aXQgdG8KY29ubmVjdCB0byB1cCB0byB0d28gQVNUMTcwMCBib2FyZHMuIE9uIHRoZSBvdGhlciBz
aWRlLCB0aGUgQVNUMTcwMApjb25zb2xpZGF0ZXMgSFBNIEZQR0EgZnVuY3Rpb25zIGFuZCBtdWx0
aXBsZSBwZXJpcGhlcmFsIGludGVyZmFjZXMKKEdQSU8sIFVBUlQsIEkyQywgSTNDLCBldGMuKSBv
bnRvIGEgc2luZ2xlIGJvYXJkLgoKQmVjYXVzZSB0aGUgQVNUMTcwMCBleHBvc2VzIGFkZGl0aW9u
YWwgSS9PIGludGVyZmFjZXMgKEdQSU8sIEkyQywgSTNDLAphbmQgb3RoZXJzKSwgaXQgYWN0cyBh
cyBhbiBJL08gZXhwYW5kZXIuIE9uY2UgY29ubmVjdGVkIG92ZXIgTFRQSSwKdGhlIEFTVDI3eDAg
Y2FuIGNvbnRyb2wgYWRkaXRpb25hbCBkb3duc3RyZWFtIGRldmljZXMgdGhyb3VnaCB0aGlzIGxp
bmsuCgpUaGlzIHBhdGNoIHNlcmllcyBpcyBiYXNlZCBvbiB0aGUgYXNwZWVkX25leHQgYnJhbmNo
IGluY2x1ZGluZyB0aGUgYmVsb3cKY2hhbmdlLgpSZWY6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9xZW11LWRldmVsL3BhdGNoLzIwMjYwMjAzMDIwODU1LjE2NDI4ODQtMi1q
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20vCgpJdCBpbnRyb2R1Y2VzIGEgYmFzaWMgTFRQSSBjb250
cm9sbGVyIG1vZGVsIGFuZCB3aXJlcyBpdCBpbnRvIHRoZQpBU1QyN3gwIFNvQy4gVGhlIHNlcmll
cyBhbHNvIGFkZHMgdGhlIEFTVDE3MDAtc3BlY2lmaWMgTFRQSSBleHBhbmRlcgpkZXZpY2UgYW5k
IGluY3JlbWVudGFsbHkgY29ubmVjdHMgY29tbW9uIHBlcmlwaGVyYWxzIG9uIHRoZSBBU1QxNzAw
Cm1vZGVsLiBGb3IgdGhlIEkzQyBibG9jaywgd2hpY2ggbWF5IGNhdXNlIGtlcm5lbCBjcmFzaGVz
LCBpdHMgTU1JTwpyZWdpb24gaXMgbW9kZWxlZCBhcyBhbiB1bmltcGxlbWVudGVkIGRldmljZSB0
byByZXNlcnZlIGFkZHJlc3Mgc3BhY2UKYW5kIG1ha2UgdGhlIG1pc3NpbmcgZnVuY3Rpb25hbGl0
eSBleHBsaWNpdCwgZW5zdXJpbmcgc3RhYmxlIGd1ZXN0CnByb2JpbmcuCgpJbiB0aGUgb2ZmaWNp
YWwgcmVsZWFzZSBpbWFnZXMsIHRoZSBBU1QxNzAwIGZ1bmN0aW9ucyBhcmUgbm90IGluY2x1ZGVk
CmJ5IGRlZmF1bHQuIFRvIHRlc3QgdGhlIEFTVDE3MDAtcmVsYXRlZCBmdW5jdGlvbmFsaXR5LCBw
bGVhc2UgaW5jbHVkZQp0aGUgZm9sbG93aW5nIERUUyBmaWxlcyBmb3IgcHJvYmluZzoKaHR0cHM6
Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12Ni42
L2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1sdHBpMC5kdHNpCmh0dHBzOi8vZ2l0
aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTEuZHRzaQoKQWZ0ZXIgaW5jbHVkaW5n
IHRoZXNlIERUUyBmaWxlcyBpbiB0aGUgQk1DIGltYWdlLCB5b3UgY2FuIHZlcmlmeSBMVFBJCmZ1
bmN0aW9uYWxpdHkgdXNpbmcgdGhlIGZvbGxvd2luZyBzY2VuYXJpb3M6CgoxLiBJbiBVLUJvb3Q6
CiAgIFJ1biB0aGUgbHRwaSBjb21tYW5kIHRvIHRyaWdnZXIgdGhlIExUUEkgY29ubmVjdGlvbiBh
bmQgZGlzcGxheSB0aGUKICAgY3VycmVudCBjb25uZWN0aW9uIHN0YXR1cy4KMi4gSW4gQk1DIExp
bnV4OgogICBSdW4gaTJjZGV0ZWN0IC15IDwxNi0zOD4gdG8gc2NhbiBhbmQgdGVzdCB0aGUgSTJD
IGJ1c2VzIGV4cG9zZWQgYnkKICAgdGhlIEFTVDE3MDAuCgpBbnkgZmVlZGJhY2sgb3Igc3VnZ2Vz
dGlvbnMgYXJlIGFwcHJlY2lhdGVkIQoKS2FuZQoKLS0tCgpDaGFuZ2VMb2cKLS0tLS0tLS0tCnY2
OgotIFJlbW92ZSByZWR1bmRhbnQgWypdCi0gRml4IGNoZWNrcGF0Y2gucGwgZXJyb3JzCi0gVXBk
YXRlIHRoZSB0ZXN0IHNjcmlwdAoKdjU6Ci0gQWRkIGZ1bmN0aW9uYWwgdGVzdCBjYXNlIGZvciBB
U1QxNzAwIEkyQwotIENvcnJlY3RlZCB0aGUgRnJvbSBhdHRyaWJ1dGlvbgotIEZpeGVkIGluY29y
cmVjdCBEUkFNIHNldHRpbmcgZm9yIFNQSSBhbmQgSTJDIGNvbnRyb2xsZXJzCi0gUmVmaW5lIGNv
ZGUgc3RydWN0dXJlCgp2NDoKLSBBZGQgbWlzc2luZyBTaWduZWQtb2ZmLWJ5Ci0gRml4IGNoZWNr
cGF0Y2gucGwgd2FybmluZ3MKLSBSZWZpbmUgY29kZSBzdHJ1Y3R1cmUKLSBFbmFibGUgQVNUMTcw
MCBzdXBwb3J0IG9ubHkgYWZ0ZXIgYWxsIGRldmljZXMgYXJlIHJlYWR5Cgp2MzoKLSBBZGQgUFdN
IG1vZGVsCi0gSW50ZWdyYXRlIHRoZSBTR1BJTyBtb2RlbAotIEZpeCBJMkMgdGVzdCBjYXNlIGZh
aWx1cmUKLSBSZWZpbmUgY29kZSBzdHJ1Y3R1cmUKCnYyOgotIFNlcGFyYXRlIHRoZSBBU1QxNzAw
IG1vZGVsIGludG8gYSBzdGFuZGFsb25lIGltcGxlbWVudGF0aW9uCi0gUmVmaW5lIHRoZSBtZWNo
YW5pc20gZm9yIGFzc2lnbmluZyB0aGUgQVNUMTcwMCBib2FyZCBudW1iZXIKCnYxOgotIEluaXRp
YWwgdmVyc2lvbgotLS0KCkPvv71kcmljIExlIEdvYXRlciAoMSk6CiAgaHcvbWlzYzogQWRkIGJh
c2ljIEFzcGVlZCBQV00gbW9kZWwKCkthbmUtQ2hlbi1BUyAoMjEpOgogIGh3L21pc2M6IEFkZCBM
VFBJIGNvbnRyb2xsZXIKICBody9hcm0vYXNwZWVkOiBBdHRhY2ggTFRQSSBjb250cm9sbGVyIHRv
IEFTVDI3WDAgcGxhdGZvcm0KICBody9hcm0vYXNwZWVkOiBBZGQgQVNUMTcwMCBMVFBJIGV4cGFu
ZGVyIGRldmljZSBtb2RlbAogIGh3L2FybS9hc3BlZWQ6IEludGVncmF0ZSBBU1QxNzAwIGRldmlj
ZSBpbnRvIEFTVDI3WDAKICBody9hcm0vYXNwZWVkOiBJbnRlZ3JhdGUgaW50ZXJydXB0IGNvbnRy
b2xsZXIgZm9yIEFTVDE3MDAKICBody9hcm0vYXNwZWVkOiBBdHRhY2ggTFRQSSBjb250cm9sbGVy
IHRvIEFTVDE3MDAgbW9kZWwKICBody9hcm0vYXNwZWVkOiBBdHRhY2ggVUFSVCBkZXZpY2UgdG8g
QVNUMTcwMCBtb2RlbAogIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBTUkFNIGRldmljZSB0byBBU1Qx
NzAwIG1vZGVsCiAgaHcvYXJtL2FzcGVlZDogQXR0YWNoIFNQSSBkZXZpY2UgdG8gQVNUMTcwMCBt
b2RlbAogIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBBREMgZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwK
ICBody9hcm0vYXNwZWVkOiBBdHRhY2ggU0NVIGRldmljZSB0byBBU1QxNzAwIG1vZGVsCiAgaHcv
YXJtL2FzcGVlZDogQXR0YWNoIEdQSU8gZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwKICBody9hcm0v
YXNwZWVkOiBhdHRhY2ggSTJDIGRldmljZSB0byBBU1QxNzAwIG1vZGVsCiAgaHcvYXJtL2FzcGVl
ZDogQXR0YWNoIFdEVCBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbAogIGh3L2FybS9hc3BlZWQ6IEF0
dGFjaCBQV00gZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwKICBody9hcm0vYXNwZWVkOiBBdHRhY2gg
U0dQSU9NIGRldmljZSB0byBBU1QxNzAwIG1vZGVsCiAgaHcvYXJtL2FzcGVlZDogTW9kZWwgQVNU
MTcwMCBJM0MgYmxvY2sgYXMgdW5pbXBsZW1lbnRlZCBkZXZpY2UKICBody9hcm0vYXNwZWVkOiBF
bmFibGUgQVNUMTcwMCBJTyBleHBhbmRlciBzdXBwb3J0CiAgdGVzdHMvZnVuY3Rpb25hbC9hYXJj
aDY0OiBQYXJhbWV0ZXJpemUgSTJDIGJ1cyBJRCBpbiBBU1QyNzAwIHRlc3QKICB0ZXN0cy9mdW5j
dGlvbmFsL2FhcmNoNjQ6IFBhcmFtZXRlcml6ZSBQQ0llMiBpbml0aWFsaXphdGlvbiBpbiBBU1Qy
NzAwCiAgdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0OiBBZGQgSTJDIHRlc3QgZm9yIEFTVDE3MDAg
SU8gZXhwYW5kZXJzCgogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCAgICAgICAgICAg
ICAgIHwgIDU0ICsrKysKIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAgICAgICAgICAgICAg
ICAgICB8ICAyNSArLQogaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggICAgICAgICAgICAg
ICAgIHwgICAyICsKIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfbHRwaS5oICAgICAgICAgICAgICAg
ICB8ICAzMyArKysKIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfcHdtLmggICAgICAgICAgICAgICAg
ICB8ICAzMCArKwogaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgMjc2ICsrKysrKysrKysrKysrKysrKwogaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTY3ICsrKysrKysrKystCiBody9pbnRjL2FzcGVlZF9pbnRjLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjAgKysrKwogaHcvbWlzYy9hc3BlZWRfbHRwaS5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTkzICsrKysrKysrKysrKwogaHcvbWlzYy9hc3Bl
ZWRfcHdtLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTIwICsrKysrKysrCiBody9hcm0v
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogaHcvbWlzYy9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGh3L21pc2MvdHJh
Y2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArCiAuLi4vZnVuY3Rpb25h
bC9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDAucHkgfCAgNjUgKysrLS0KIDE0IGZpbGVzIGNo
YW5nZWQsIDk5NSBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9ody9taXNjL2FzcGVlZF9sdHBpLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2h3L21pc2MvYXNwZWVkX3B3bS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvYXJtL2FzcGVlZF9h
c3QxNzAwLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL2FzcGVlZF9sdHBpLmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9taXNjL2FzcGVlZF9wd20uYwoKLS0gCjIuNDMuMAo=

