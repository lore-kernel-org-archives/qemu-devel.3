Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E89D3E78F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZ8j-0001Kv-40; Thu, 11 Dec 2025 00:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vTZ8g-0001KM-LS; Thu, 11 Dec 2025 00:22:54 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vTZ8d-0003jP-Ik; Thu, 11 Dec 2025 00:22:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBtrhOeknceVKcQNeWe3MebMvNf57ec4+1EXE0DTxKCrYCz7TQorWAMw6IItTk3N52qYdTE5yD+c2Lj9YRv+mpJzlggLkxviijULjgl6NuKo/OO7LtLwCn5TbnyXA6yfwNhvHudgTMM9IU/sOQ/NBbEmhc/nCtXv+5fiknYa+EC632MD5KOpqrXVKsSolBViZ54U19c4JNYTGGp0GmwyfcaLtFcQ8I2ikwi3yvr/eInpZG/8seQ2SgdeYwBLHhMAyXzd7ER+GX0YyEBH+HjYLrdsqXm1yGqkHv0H/ImmHXOuZ8sjghrTy4slRdcbq5SKjdEML+wR46jt95zaC1gf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvCYLQlvMmK/O95ek0oUj9ItbzhwGyNPLkKgg8PefKw=;
 b=EVK46DBy5zB/29R4Tn63FTcxRpCzk86sbOUTM97UCw+0yfGskxs2MgfJAgcLzxZdwcOywTTbB4h5ibS9VbeN/DRySaCcmCim728MMWJhB+MDgJhHXgTuaSdomY6OjUjL9lcUithfv4/lDwWC/vFHmEYcsDapC3CrdAoacglYpvIlA1BRMq4b7sme3imrUfbki4jruZRhezSXCbUrmQf6UaaMJs8mMyFNSHKAPmb0oQ8g3zLRXOTMnV2xrzUCAbscq1/+td3wneQ7WB1l01p2kQXYgorpjlhzSJIpwJCV3bWbYRkxIq2/neRccpwEyVzm3/fWPH44DKHkYJsg5qGcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvCYLQlvMmK/O95ek0oUj9ItbzhwGyNPLkKgg8PefKw=;
 b=g0O3ht925fz9NlM/tqY3pZ9M6Z3LZXJrPIWFtgFRajiJB/cmf9vbEuFp50qy0aqQpqUo5lGX/McVeB3IL1WkVL+vTIwovSiFUVIrRKJi8vd49QyMVhasuJqbDzpr4pkEVEemMKWQp9OJJcOtIwFTS1dHEAGltgUron/gU+pcCgpBvDYHF7q3IYXpMk2xWjPHjZhZuyO9ggO3DUB2fQ45B3Rjq8PCBEqc9GY9ExpF7hETiUSZviZ0d8CMJu2Nq0pERqoQEtdrt1ugd0orkTmoK1DrZUPuz+O0rkoDVZmvZBgP/pBWctlA1YeZsQCnm2z62wbs2WJkrikNGQpPRt4ZVQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SI6PR06MB7147.apcprd06.prod.outlook.com (2603:1096:4:24c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 05:22:11 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:22:11 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nabih Estefan <nabihestefan@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v3 2/6] hw/gpio/aspeed_sgpio: Add QOM property accessors
 for SGPIO pins
Thread-Topic: [PATCH v3 2/6] hw/gpio/aspeed_sgpio: Add QOM property accessors
 for SGPIO pins
Thread-Index: AQHcaizcVIH+fuHMS0G4KM9+DJc9p7UbtWBA
Date: Thu, 11 Dec 2025 05:22:11 +0000
Message-ID: <SI6PR06MB76310D340EFCC0D96D4170D7F7A1A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
 <20251210-aspeed-sgpio-v3-2-eb8b0cf3dd51@google.com>
In-Reply-To: <20251210-aspeed-sgpio-v3-2-eb8b0cf3dd51@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SI6PR06MB7147:EE_
x-ms-office365-filtering-correlation-id: 12d3753f-9d94-403d-7a63-08de38753c8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QnB0c1p6OUxjWlFBU2JhbCt1Z0hGelVlZUs0YVBaSUg1eW5SRDd0bk0rcENq?=
 =?utf-8?B?TTNuTzV5RDZEamNoYUZSM1gyVElaWGFOTTNPREwzY21WWm1WVDRxVjlQZTJJ?=
 =?utf-8?B?cWJPUjZaQU1OYWxxZ0UyQlVyRVNvWk8zc0wxeUJWOFJQdjhBUnBqaGlyclJs?=
 =?utf-8?B?SmhTZzUwNWtWazdTMEVnVTdmM1Qxdmk2ekREVnZhcmlKcjQxZ2xIL2EyS0Zn?=
 =?utf-8?B?YXV4VW9uVExpaEpva2FPYmxkYVV1ODNWT1pZd0l5cGh4Zk9ISmNPM2tzYUlH?=
 =?utf-8?B?eEt5R2VjSC9yUG1SSFE5eUt1VXJlM0lPT0hWcTVHZzdrM2c4bDlNNWM4WnRZ?=
 =?utf-8?B?Vm9WNWRIZnR0anBDMk8ydVhvZGVjalFPYTlJYTBnWCtDOGJCVXp1bWVwQ1lD?=
 =?utf-8?B?ek1pRjZwRFdrMnZXbXloSGk3UTJSdDZWcXh4M1BwanZFS2dSRkV2SGVCSzJ0?=
 =?utf-8?B?ck90OSt4YVdlOTBPKzBWdlUxRVVKZXd1c2F3dGlLaUFvcUI0aGc3ZWF5aHdD?=
 =?utf-8?B?TVBUWkJXTFNLZ2J3OTBZTlBvWGJLTzhSRTVQY0tnWVBTTXdRdkY1UjM5UEtS?=
 =?utf-8?B?L0Z6ZVJ3VzZ4K0tpZHZzcHZPNXdnQzQwY2hDS3lRdjJnYWkvZGwyd0NjUlZO?=
 =?utf-8?B?ZWVQaUxVTGgwSmJjQW9qUmx4V3FkdE41Skc4M012MCtEaFdIK0NDN2xpNlJh?=
 =?utf-8?B?TzNkc0xPaFVBemJVWmZDL1Z5UzV5V2FOSFFJSG5uMnpwSXZVcGVRUGMvV2hj?=
 =?utf-8?B?b1hRd2xSWHVyV0duQ3F0Kzk0akp6ZStmY2xRUW93OEV2SVVnYXBCTm9VaDVz?=
 =?utf-8?B?NG5EV0FxVmt1YzVZSUhLZkpwM0d2VWVHR0tRVHppdFMyWkJRRVJQMVd1MUFr?=
 =?utf-8?B?YjlDZGlwdmZDYjB3clFNay8vVk4yREhrZDFmekxIU2YrYkNyejlsRkFMLzRp?=
 =?utf-8?B?eWpVakNiZ1hkRmp6TUV0UjQ0WjIzTFo2ZmljbFF2dCtoVXJiUmlueEF1Z1E4?=
 =?utf-8?B?L1htVENHbElGcW5yNnNIV2tlNFpPd1cvc3VCU2dxczlUYlQzT05HUmg0UWtj?=
 =?utf-8?B?ZWdhR2Vud0NQcUFIaUovRHZpdDVSSE5wUW1pc09ITFIwblNiRTRiWldRR21R?=
 =?utf-8?B?eXNCd2MrTXl5cTl6TWs1RVZkOCtEMGpPTUdkQmo1TERQM25aM2svTEhpYmhP?=
 =?utf-8?B?NVVWRHFBSUpFL1VPU21QWkFhdmY4bmNrL2JpZWlMSm5vVkdVYU9WSTVKS1d4?=
 =?utf-8?B?djZ2UWlPK1Nmc1cxVm93SHNjREN2YVIwQyt2NngyWGh4M21lQ0MxYjFWVFYr?=
 =?utf-8?B?a2pYSG1RMHZXdzBoY0JOQ0c3MWpDTmdUdmlVM3ZabkwyVlhMYWY2RGNCbUxE?=
 =?utf-8?B?WlhuNE9iU3U2TnUwMnc4M1RmbG9PWE8zck1nUnAxeW1kU3B2VitublZZdXFh?=
 =?utf-8?B?Njd4YnhCdENJdlFCRTZ4MXVXT25rOGpJYnJlOFFxV1hEZTRqSHp4K1lEODBE?=
 =?utf-8?B?d0tJOE5oUTBFTFJ6RUI3V01wK21HT2swMDJHWWJsZURVK0xBOFZHUTQ0cFI4?=
 =?utf-8?B?b1NGemxOSElPZDJ3b0JHd0ZhNlR0YUtpMDhqdUtRajhNOStpUVpQQW1iVDR5?=
 =?utf-8?B?N0NaZnZDOEZUN25JWjRPLzkxQjN3QkxsS0szWi9NT2tOME5xNTBCMkk4K05I?=
 =?utf-8?B?aUxFN2c4NG9tUE5JM1AwMjg0UEpSUWtpQW5HQUordEE2QUxrLzN5SzYxTm9n?=
 =?utf-8?B?OUo0blduVktDM1pVMHJ4QTVqblNMWnZ4cHQ2VHcvRTJEMUw0UjBhWWRBVEh5?=
 =?utf-8?B?VlRqbHNVMko0RjcwZGQ1RTBmVUM1YXR0WHhGSlA3M3A4cHU1MnJieVVNOXpT?=
 =?utf-8?B?TDIrRFFpYVZnZTBvUGE3R0k0dm5hWCtIRjd5MlZPdmVza08xSkR4dDBqN0VK?=
 =?utf-8?B?RnF5QWVFREx4ZTNTeDkvUTFwMml3YUg0OHdKLzVidUhHcHpZS2hGc05icHhj?=
 =?utf-8?B?Qko3Sm92bytVWE5rWDlLYjJOMitySlk3OFhwV3h5TTNQQVI4aytYSSt5elQ3?=
 =?utf-8?Q?u/sj3U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDlITmVLb1NGa0FUSVpxZTBmSkJnaWdpOU9Cd1d3aVBKNHZuZUpOMDFuRG5U?=
 =?utf-8?B?UzR2WXF0TUxQbzJaSld6Ynp3Z3RwVktMaVVBZHdMUTVzU3UwUFlZS3NuQ1Mx?=
 =?utf-8?B?bGtNYnRkMmVmMTgwV25zTDJjRDdSUUY5ZzdaNUtvSTJnZE1GSzgvZGxKcVd5?=
 =?utf-8?B?TSs1bmdmSmp6bG5nbFpvUFVScWJ1R2ZzYTB6MU1LZCtQcTVrMlloY1VTQjVQ?=
 =?utf-8?B?d2hDVkk2TjU5SzNmSkIwcVlWY2tMVi9HakVyTWZ0WDZCRlhXRHNLM0ZTdjJ6?=
 =?utf-8?B?dER2cmJneUlCTTNpYko4Ty9OMkVXQ3k0VFV6c2x1d2JFbkhnR0F2NmFtY1BM?=
 =?utf-8?B?KzVlSk5uL0FxT3QxL3N6dWl1K3FMWG84aFN3dkQzejVzSHQvY0Y5a1RqWk50?=
 =?utf-8?B?OWg3LzdrME9kOEtyZDYyNWNYWm45WkhmdGZ5RW40K2FEVCtsOXdQUUdyWVdD?=
 =?utf-8?B?a2EwZ1kybmk0TEgzWTNCUm44Tm01NjVHVDNZTFBzaFNBQlJKVkt3Z24rVStF?=
 =?utf-8?B?ZkRJQnEwQzNZdGxoNmZZYk9tczZRd3FaL3o5Q1U4ZEUvVzFjVXo2M1hYdU9T?=
 =?utf-8?B?eTMvejBPcnlINEYxYUk0cHJxckJ2M3F6SjJGWFp2ajdaSTNsdUQ1aXNoRXIw?=
 =?utf-8?B?WlZmNGNIYmNvUWsxeDJIWHdaWDExS2RKQVpEVTM4U3BJTS9LL3VvS2JOMFRD?=
 =?utf-8?B?eWxFMlE1K0sveTRVK0pRMjlDd0ZsVnhpZkV1aEprdGUwVXdYbUh4NEJzQW1E?=
 =?utf-8?B?RGhFN2l4dmoya0R3bmxmdHZtak5KZGxmTmY5dlhQWE1rbkViSTFkZzNLbURj?=
 =?utf-8?B?Z0k3TllvK0tlSXU3WCtFeGRtbWtiK3JTeTRhdHJPNVhNOHJ2alFVaWZJSjh2?=
 =?utf-8?B?VmJoUGw0bkJiQ3RWdnJ5OGF5ek1Ic05MWEJFcU53V1kxV01KbEV2ZTFobHAv?=
 =?utf-8?B?WmdDVzh4dXZIbVJBSDlhYWdtVHR3RllWc2UvdjVSWEZVVmNmSktjWVEyUUcx?=
 =?utf-8?B?QmtSSFIvNXBnTXoyR3MrdDNHSGRpT3Y0amJqZ0dvbk5QYmc0VW5rZXhRL1lL?=
 =?utf-8?B?S2xWYjgvTnRIT3NTNUQ2RTlQZkV0YnBoMUhXaFcvdHg1VEJhWHhxVCtad1lv?=
 =?utf-8?B?QndvYldzLy82TU5xMGJjVnpCRFNNcEh2V2d2clZxQWhBeVRqR0JrM3ExYnBG?=
 =?utf-8?B?dExWM29TMTViMWJod3NNWXk5VzZyYWJVck5NbElhMlZnYjl1QzQrd1hoeWFl?=
 =?utf-8?B?QzZHM3FVemJ5Q2o2Q3FSRG1xcVNHdmk3OTk3bFc3c09XZWdNMDBrVXNraFda?=
 =?utf-8?B?aVhCS25Ic0RDYlljaEh2VjlZSWxtUjBFS2xmQkVrVFVDdmY0WXBUY096THRR?=
 =?utf-8?B?c2NoT2ZnNU1BRFZpdUJMMlV4WHd2U2J5RG5YVThGcWlTNks2NXUwVi9DNjYv?=
 =?utf-8?B?Q21IbXNGYUV0bDd4dXlyWmdvK3lFRDlySDQzVGZuZHcxM3k5T01ub2haQ0tv?=
 =?utf-8?B?S2pxUGRURk5TTmgvdEN1SGlmdk13c2R6Ny9pMjcycE16WlIwdkxhQTZVcDdD?=
 =?utf-8?B?VUV0elkrc1F1UEdNSkNRbkxSMWs5VEZMTEo1MUVnaFZQVzhMcDl4dGFSeTg1?=
 =?utf-8?B?VCtEajdBNlN2UTdaa25LNmJ3emRXbUE5aFVoUXFkSllLT0JYOGIreG90d1lK?=
 =?utf-8?B?dTRVMnNIMHQxRGZVdXhUOVBoZmhEcFlmWDhHTFM4cjJFZHBYYnMxS0s2NkJM?=
 =?utf-8?B?aWR1OVlxNWh1SEU2S3dlbmpHZXJDMjVoNEltZG1JczhqbHMyU2Y2MTFrdzRz?=
 =?utf-8?B?Ym80aUwzSjlQdWRZSnUvd21SbHBaV3RYTlpxSmdxWDhxaEMxbUxRNzFBOEU0?=
 =?utf-8?B?NlJ4REQ0aExzVFRQNkVoeXNRSG9aT0R2M0xVa3VISDdWMkhuMFlWUlZoUlR0?=
 =?utf-8?B?Skw2RkdVcEdxU2hiekZvYTVDQS93MDhYNTdyUCtqQkJYd2ZWQldDT3ZlOFFS?=
 =?utf-8?B?TjV6YWN1UC95ajcrVEc0Z053TDJXdXAzOVMvWTEyY3BReC9DdG8zWHNVcWx5?=
 =?utf-8?B?QlNZQ0IxTGwwZ3dpTEo5VDFNd2syM2RrcWRGRnJRVVF4Z29DUUxhTktzaTJp?=
 =?utf-8?Q?Vdru0XIAud7Vy+Ze/adLdT86D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d3753f-9d94-403d-7a63-08de38753c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 05:22:11.0780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcST18/yTya+fjlCJMH8qEvCP2ntOlLTgs4QqFTTchitrH5zjLKbotX52w10N6fJZ78afeg/HjYhGpVjGndwfIeeszjOi2IEKcW/oCzVb+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7147
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdWJpbiBab3UgPHl1YmluekBn
b29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTEsIDIwMjUgNzoyOSBBTQ0K
PiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
U3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0
cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5k
cmV3DQo+IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3Rhbmxl
eSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBGYWJpYW5vIFJvc2FzIDxmYXJvc2FzQHN1c2UuZGU+OyBM
YXVyZW50IFZpdmllciA8bHZpdmllckByZWRoYXQuY29tPjsNCj4gUGFvbG8gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT47IEthbmUgQ2hlbg0KPiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29t
PjsgTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+Ow0KPiBxZW11LWFybUBu
b25nbnUub3JnOyBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjMgMi82XSBody9ncGlvL2FzcGVlZF9zZ3BpbzogQWRkIFFPTSBwcm9wZXJ0eSBhY2Nlc3Nv
cnMNCj4gZm9yIFNHUElPIHBpbnMNCj4gDQo+IFRoZSBgYXNwZWVkX3NncGlvX2dldF9waW5gIGFu
ZCBgYXNwZWVkX3NncGlvX3NldF9waW5gIGZ1bmN0aW9ucyBhcmUNCj4gaW1wbGVtZW50ZWQgdG8g
Z2V0IGFuZCBzZXQgdGhlIGxldmVsIG9mIGluZGl2aWR1YWwgU0dQSU8gcGlucy4gVGhlc2UgYXJl
IHRoZW4NCj4gZXhwb3NlZCBhcyBib29sZWFuIHByb3BlcnRpZXMgb24gdGhlIFNHUElPIGRldmlj
ZSBvYmplY3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUu
Y29tPg0KPiAtLS0NCj4gIGh3L2dwaW8vYXNwZWVkX3NncGlvLmMgfCA3OA0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDc4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9ncGlvL2FzcGVlZF9z
Z3Bpby5jIGIvaHcvZ3Bpby9hc3BlZWRfc2dwaW8uYyBpbmRleA0KPiA4Njc2ZmE3Y2VkMTM0ZjFm
NjJkYzllMzBiNDJjNWZlNmRiM2RlMjY4Li4yN2M0MDZkNTA0MmY0MjNiOTE0ZDUzZGUNCj4gMDAw
YjcyN2NiNzI0MmRjOSAxMDA2NDQNCj4gLS0tIGEvaHcvZ3Bpby9hc3BlZWRfc2dwaW8uYw0KPiAr
KysgYi9ody9ncGlvL2FzcGVlZF9zZ3Bpby5jDQo+IEBAIC05MSw2ICs5MSw3MyBAQCBzdGF0aWMg
dm9pZCBhc3BlZWRfc2dwaW9fMjcwMF93cml0ZSh2b2lkICpvcGFxdWUsDQo+IGh3YWRkciBvZmZz
ZXQsIHVpbnQ2NF90IGRhdGEsDQo+ICAgICAgfQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyBib29sIGFz
cGVlZF9zZ3Bpb19nZXRfcGluX2xldmVsKEFzcGVlZFNHUElPU3RhdGUgKnMsIGludCBwaW4pIHsN
Cj4gKyAgICB1aW50MzJfdCB2YWx1ZSA9IHMtPmN0cmxfcmVnc1twaW4gPj4gMV07DQo+ICsgICAg
Ym9vbCBpc19pbnB1dCA9ICEocGluICUgMik7DQo+ICsgICAgdWludDMyX3QgYml0X21hc2sgPSAw
Ow0KPiArDQo+ICsgICAgaWYgKGlzX2lucHV0KSB7DQo+ICsgICAgICAgIGJpdF9tYXNrID0gU0dQ
SU9fU0VSSUFMX0lOX1ZBTF9NQVNLOw0KPiArICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIGJpdF9t
YXNrID0gU0dQSU9fU0VSSUFMX09VVF9WQUxfTUFTSzsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBy
ZXR1cm4gdmFsdWUgJiBiaXRfbWFzazsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgYXNwZWVk
X3NncGlvX3NldF9waW5fbGV2ZWwoQXNwZWVkU0dQSU9TdGF0ZSAqcywgaW50IHBpbiwNCj4gK2Jv
b2wgbGV2ZWwpIHsNCj4gKyAgICB1aW50MzJfdCB2YWx1ZSA9IHMtPmN0cmxfcmVnc1twaW4gPj4g
MV07DQo+ICsgICAgYm9vbCBpc19pbnB1dCA9ICEocGluICUgMik7DQo+ICsgICAgdWludDMyX3Qg
Yml0X21hc2sgPSAwOw0KPiArDQo+ICsgICAgaWYgKGlzX2lucHV0KSB7DQo+ICsgICAgICAgIGJp
dF9tYXNrID0gU0dQSU9fU0VSSUFMX0lOX1ZBTF9NQVNLOw0KPiArICAgIH0gZWxzZSB7DQo+ICsg
ICAgICAgIGJpdF9tYXNrID0gU0dQSU9fU0VSSUFMX09VVF9WQUxfTUFTSzsNCj4gKyAgICB9DQo+
ICsNCj4gKyAgICBpZiAobGV2ZWwpIHsNCj4gKyAgICAgICAgdmFsdWUgfD0gYml0X21hc2s7DQo+
ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgdmFsdWUgJj0gfmJpdF9tYXNrOw0KPiArICAgIH0N
Cj4gKyAgICBzLT5jdHJsX3JlZ3NbcGluID4+IDFdID0gdmFsdWU7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyB2b2lkIGFzcGVlZF9zZ3Bpb19nZXRfcGluKE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBj
b25zdCBjaGFyICpuYW1lLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lk
ICpvcGFxdWUsIEVycm9yICoqZXJycCkgew0KPiArICAgIGJvb2wgbGV2ZWwgPSB0cnVlOw0KPiAr
ICAgIGludCBwaW4gPSAweGZmZjsNCj4gKyAgICBBc3BlZWRTR1BJT1N0YXRlICpzID0gQVNQRUVE
X1NHUElPKG9iaik7DQo+ICsNCj4gKyAgICBpZiAoc3NjYW5mKG5hbWUsICJzZ3BpbyUwM2QiLCAm
cGluKSAhPSAxKSB7DQo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIiVzOiBlcnJvciByZWFk
aW5nICVzIiwgX19mdW5jX18sIG5hbWUpOw0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0K
PiArICAgIGxldmVsID0gYXNwZWVkX3NncGlvX2dldF9waW5fbGV2ZWwocywgcGluKTsNCj4gKyAg
ICB2aXNpdF90eXBlX2Jvb2wodiwgbmFtZSwgJmxldmVsLCBlcnJwKTsgfQ0KPiArDQo+ICtzdGF0
aWMgdm9pZCBhc3BlZWRfc2dwaW9fc2V0X3BpbihPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29u
c3QgY2hhciAqbmFtZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
b3BhcXVlLCBFcnJvciAqKmVycnApIHsNCj4gKyAgICBib29sIGxldmVsOw0KPiArICAgIGludCBw
aW4gPSAweGZmZjsNCj4gKyAgICBBc3BlZWRTR1BJT1N0YXRlICpzID0gQVNQRUVEX1NHUElPKG9i
aik7DQo+ICsNCj4gKyAgICBpZiAoIXZpc2l0X3R5cGVfYm9vbCh2LCBuYW1lLCAmbGV2ZWwsIGVy
cnApKSB7DQo+ICsgICAgICAgIHJldHVybjsNCj4gKyAgICB9DQo+ICsgICAgaWYgKHNzY2FuZihu
YW1lLCAic2dwaW8lMDNkIiwgJnBpbikgIT0gMSkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICIlczogZXJyb3IgcmVhZGluZyAlcyIsIF9fZnVuY19fLCBuYW1lKTsNCj4gKyAgICAgICAg
cmV0dXJuOw0KPiArICAgIH0NCj4gKyAgICBhc3BlZWRfc2dwaW9fc2V0X3Bpbl9sZXZlbChzLCBw
aW4sIGxldmVsKTsgfQ0KPiArDQo+ICBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIGFzcGVl
ZF9ncGlvXzI3MDBfb3BzID0gew0KPiAgICAucmVhZCAgICAgICA9IGFzcGVlZF9zZ3Bpb18yNzAw
X3JlYWQsDQo+ICAgIC53cml0ZSAgICAgID0gYXNwZWVkX3NncGlvXzI3MDBfd3JpdGUsDQo+IEBA
IC0xMTQsNiArMTgxLDE2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zZ3Bpb19yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsDQo+IEVycm9yICoqZXJycCkNCj4gICAgICBzeXNidXNfaW5pdF9tbWlvKHNi
ZCwgJnMtPmlvbWVtKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBhc3BlZWRfc2dwaW9faW5p
dChPYmplY3QgKm9iaikgew0KPiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQVNQRUVEX1NHUElP
X01BWF9QSU5fUEFJUiAqIDI7IGkrKykgew0KPiArICAgICAgICBjaGFyICpuYW1lID0gZ19zdHJk
dXBfcHJpbnRmKCJzZ3BpbyUwM2QiLCBpKTsNCj4gKyAgICAgICAgb2JqZWN0X3Byb3BlcnR5X2Fk
ZChvYmosIG5hbWUsICJib29sIiwgYXNwZWVkX3NncGlvX2dldF9waW4sDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYXNwZWVkX3NncGlvX3NldF9waW4sIE5VTEwsIE5VTEwpOw0KPiAr
ICAgICAgICBnX2F1dG9mcmVlKG5hbWUpOw0KPiArICAgIH0NCj4gK30NCg0KUGxlYXNlIHVzZSAi
Z19hdXRvZnJlZSBjaGFyICpuYW1lICIuIGdfYXV0b2ZyZWUobmFtZSk7IHdpbGwgY2F1c2UgYSBi
dWlsZCBmYWlsdXJlLg0KDQo+ICsNCj4gIHN0YXRpYyB2b2lkIGFzcGVlZF9zZ3Bpb19jbGFzc19p
bml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkgIHsNCj4gICAgICBEZXZp
Y2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOyBAQCAtMTQzLDYgKzIyMCw3IEBAIHN0
YXRpYw0KPiBjb25zdCBUeXBlSW5mbyBhc3BlZWRfc2dwaW9fYXN0MjcwMF9pbmZvID0gew0KPiAg
ICAubmFtZSAgICAgICAgICAgPSBUWVBFX0FTUEVFRF9TR1BJTyAiLWFzdDI3MDAiLA0KPiAgICAu
cGFyZW50ICAgICAgICAgPSBUWVBFX0FTUEVFRF9TR1BJTywNCj4gICAgLmNsYXNzX2luaXQgICAg
ID0gYXNwZWVkX3NncGlvXzI3MDBfY2xhc3NfaW5pdCwNCj4gKyAgLmluc3RhbmNlX2luaXQgID0g
YXNwZWVkX3NncGlvX2luaXQsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyB2b2lkIGFzcGVlZF9zZ3Bp
b19yZWdpc3Rlcl90eXBlcyh2b2lkKQ0KPiANCj4gLS0NCj4gMi41Mi4wLjIzOS5nZDVmMGM2ZTc0
ZS1nb29nDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

