Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE58E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 02:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTB1H-0006xU-P5; Wed, 01 Jan 2025 21:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tTB18-0006wX-NI; Wed, 01 Jan 2025 21:33:00 -0500
Received: from mail-sg2apc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:200f::700]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tTB16-000124-IQ; Wed, 01 Jan 2025 21:32:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQDvjltmygWS8E1NbBti3k0U3MOkYDV3n4IfsGQtR0lzoOp+AQnHjx6QhLYzg9f1FKiC7Oqm69W2fUx01Dd7xqC/u75cYzbyzktt0Ikq7+LJ7/gU8Cx8ju+r6Ct/Aece40P3ey8rV8MPpZpZYScm7UHJkQ+dwj5kB06xajFgNofDwGv0zvc7PG7NP/2+XFJmysmkJhHFE8arCd9/tIdyKGyucYddvJppszzwImqpI/M/x48e9CBhNDRZEDLJfyCcio6aj7qAEfkiXtmCPEmyemM9mbFDmIRiDQmz2kUOowQoYjMNwWgBfugDvZwNz+XOy/JsIVnUaK8Y9Ms2DAyxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcupXd3AiKj3IhVcu9YMTDwBXhI1cBgZyFFUhGNSHPQ=;
 b=ncBRlMg++9NuoJv1WpH+eHWtknqcJyhNCKxPYIGn+H5hCfA/KtAbfpqZ7ghioyuUQXlKIWpWHisu7sA091BC0H/iIpF1H+cNGCqt+P7rCLGIQgQGrxdoKtn1QFc0w5Ty+Ow9N0eJADaqjo+VLt6RzZx/bjzLgDc11GUBJjcBoU5qEJeY7tihgHyMzrUPEOwDoN5Qc3bFL84oc6CVigP39QzD6UaRVmv8ZVoUBXmmwioJD8t5P9OfJlhkkvHu/s4p+RtEB2ZaBe6T1Uzonqnq4Pi/7hcTns0J8Fouz4gvUaavvV+vR/222G6YQ1JDHvITM0ccxIxWYp6vYMUUKf4/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcupXd3AiKj3IhVcu9YMTDwBXhI1cBgZyFFUhGNSHPQ=;
 b=HGHRJE+CH2QkARdVfhNNZxJgvPpTkWvRi2yrma/SxDzwJkLhh5oc7RM1gDodU9UrE/CHrOT/uWyPlQovie2rdmEICnPiDO45Q4BhP5h6tqTygQZx4atYxl5sVezuHeQRY3TRArmlJRMn5Pvo0V55JufUEANiFS/ykAYSTGau8F/mF9raYEKXKGetof0peoAYS43VePBQtUyc7jy2eFocvZdmunRixWdqOI6QLWR6YvA5luU6sWFpScSKByz8J0lNoNylRnf5+91p48DcNqeG/75SIjMPwPf383j4inAo03Kr8EcwSYsSBCwWaKephPcz2SGwTbBO1kP2bc0Eud7k3g==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB7044.apcprd06.prod.outlook.com (2603:1096:101:1db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 02:32:40 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 02:32:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 0/3] Support timer for AST2700
Thread-Topic: [PATCH v1 0/3] Support timer for AST2700
Thread-Index: AQHbT4+qN7k1C4LYnEmN2It9lSQ3yrMC3SQA
Date: Thu, 2 Jan 2025 02:32:39 +0000
Message-ID: <SI2PR06MB5041000ED0373E0A2ACEDD1BFC142@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB7044:EE_
x-ms-office365-filtering-correlation-id: 388f0c23-cc96-42ae-7126-08dd2ad5ba35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDZmaUkxRmxyUWREUWtuS0g5cGtPaXhqa0ZaejArb3gxVytvSnVMaTdNTjg4?=
 =?utf-8?B?MlJkTXdSem4wMVZKZkU2MmdZc0hnYXExSUFRcnJrZ0VVLzNPMDVudG1HUGNs?=
 =?utf-8?B?Z3BvMU9keVdDNGVYT0FmNys5N2owaUYyREVPNkFaVUFERDJjNnRWM0JPZDll?=
 =?utf-8?B?MDF2Y09kbjF5RU10YUozSThFNVFrZXdub2VVbHFjM2N2eWRtQWo5MG1SVTVG?=
 =?utf-8?B?K1NaT2prdm5JU2trSlZycU1sRkxIOFN0RUd0YXQrTVdXclpHL3VJc2pWVkNo?=
 =?utf-8?B?amhDRVhoY3Z1WmtvSHBVUXVnV1U5TTM4M0g0SUR2MFdCMzZPY2N2V2FpUUlD?=
 =?utf-8?B?anJNQjUzaS9OZ1hVa2NiQnYvNWNqc3g2MEhTa1RKL2FXd0Q2bFNsclA1Nlhn?=
 =?utf-8?B?VmNRZk9NVktNSGhRbzY3NGhIRHJWQzIvRmhIWHJOOGFJT3Z2ZmZ3K2hZWFVU?=
 =?utf-8?B?Nm5mZnBCWWRMMkZqNHdLNHNVZWp6bG14RnZnbWNQUmsyamNra2RsbDlra1hX?=
 =?utf-8?B?UFFjNHZpWnRYNnU0dmcrRHc2cmVMcHE1TGhDUmpEanNUR0FiTzV2UnlzVXNH?=
 =?utf-8?B?WTlUenV5SzM5QU5oa1dGWlYyNTA0RjdJcUhrM01GR01SRnhpRXViUDdWZnJr?=
 =?utf-8?B?aythWWpBRGNCeVh5aUpjZXZEU1FIdVlzQ0orNC9PUlJSK2FWMGRHLzk1VHhO?=
 =?utf-8?B?ejVWR3lSSTByUjBCMUxBUDlVU0N2Rkk1WDhnN2pCYVNtZlZxVVBvek5YVUV4?=
 =?utf-8?B?STZvdU5iSVFFUzU2RXVCemJLTnladGUwSXBZQ1hSbHRRK2d1dTM3dWlPc1Na?=
 =?utf-8?B?R3FpckR0cVlicGx5SEhkVE15ZmtNZm1OZE8yM1IveDhOSGYyMkwwWExVNDFi?=
 =?utf-8?B?ck82VkpLcU9RdkU1dy9QbnFOdWwrNzNnRHFhVkxqSmZHMFZscS84cG5udmxr?=
 =?utf-8?B?VG9acmNSR29GWjl0M0xDTG9kcVJWRnlLM1V1M2JwZDFvY1Z1TGZ0TmI0ZGl1?=
 =?utf-8?B?bWV5MlNNM2JCaVBCa0tBUUgrQkpiWkpMa2tTVk10b3BqUkxIMWYyZHk0M1Jz?=
 =?utf-8?B?elhRZ0tlMXNWMm5TK3Y5Y3UyT21aSGJibnNJQW92ZVdFa3BUUStQMzh3VFNO?=
 =?utf-8?B?TmlHT3NFVHhaRU85c21hSks3R2cvMkpDR1U1ZEkzZEtGYkZZL0pHZzRxTDZO?=
 =?utf-8?B?STgxNXlxTFdzSGlqZWlDb3hHb2FKVnErWityMnJaNEEyVnBjcjBFWi9MblF3?=
 =?utf-8?B?MlZKQmRTakNDTlJkZUQ1b0h5SGpoOVVpUG9keEhnMlZJRDNnZ3FzQ3pReXZZ?=
 =?utf-8?B?Q2pnNUFlZWRabHpCUG96NTZLazdBYXRmNWo3QmloNHQ1RjcwVlNscWpTMmRO?=
 =?utf-8?B?b25XM1BTR0RGclpQSnVmNHVVSWRNYjhKZDNlVTZVeTRWbEUyQmJVcVljcTlT?=
 =?utf-8?B?OGVteVdRSVhEcHpyTmZ5Q3BEYXZXL3hJcEpteVVrSFdiSGJUa3dQUi80ZCs1?=
 =?utf-8?B?OUM2NTBmUzZQT1JwejVmNGJNZFUrNWtqMi94bXZ0TmFIeURJUUZTRlFjMVhI?=
 =?utf-8?B?RE9CS29WdXdFbkFacFJuZE9FNmx3dTVuZ3RkMGVFaVhzVXRqUFpSY3pRcDhY?=
 =?utf-8?B?blRCQUx2Z3gweXhpV09BUUkzQncycGRrOW9KRzNRbVpSbGpBbm1SRk84c2Fu?=
 =?utf-8?B?Z1AxM2czNFRVcjNnei9KTGFHa0dnQlBiMWVBYUNJSkNpRndEUlArb3ZiUzlk?=
 =?utf-8?B?cGtBbVdYL2JJZXU1dDJqSnRGbVNnV2V1WWJ3SlYxN0pERUFsb2o0QUJNMEFz?=
 =?utf-8?B?amlybkpySkVLZytKZ1pocDJ0U3Y0cEo1MDVBdU1SMjAxck16M2F5MFk1bGkz?=
 =?utf-8?B?bTgzUGRkUmxaTS9VWDR4NVdSU2xHT1VmaWJLZnREVVpaOEY5eENvUHRBdXI4?=
 =?utf-8?Q?r0ZdA+ifiAlh23N3OpI15wUkqN7A1eqT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVlLcStjVE4wWjVXY2hoMU5rVmwyUDM2T0YyZFFsdllCYzlsY3VuVng3dDZH?=
 =?utf-8?B?TUZNdS8wZWE0NFFkcjVsL3RLUGlUMjU4M0dHYUNVZ21MRnphNXlMaUpjMDFw?=
 =?utf-8?B?QUZ3Tm1ITWs0QW9TUFVBMkhJbi83MmpmSDVlVkFkVXVKZGhDUW9SeUtDSDd3?=
 =?utf-8?B?dWtrWENQWHgwVmhHN0FVTnU4ZzA1MFVnWThMQlNkTXREREZUcGtoYzlQUkc3?=
 =?utf-8?B?bEhvYk9uMmZKRS9SOGtJVDlrUUJhSFBJa1I4ZjdFMTlvN1c1eHZFSTdtN01u?=
 =?utf-8?B?SEszY2hGMEpWSVFIZWFaS2xVL3YvbUxJcmtJZUxKU2pEMkRoVUhVZXltQlBl?=
 =?utf-8?B?MFpIM21QUklzYXYzaTdNbTFyeFNzcnYvSENUWEViYzgwK0RGZHd2ZWRMZDQw?=
 =?utf-8?B?aFIvaW1wNExsMVlsdEZGdnpNWUJ6NThycnloRXd3aXdXRUNkaVJMUDFCL1Ba?=
 =?utf-8?B?M2lJUFh0OWljNGIrcW5IQVlLK2doUytRUWZvTnZTLzVnT0N5dlY3VmJHaFp4?=
 =?utf-8?B?d2c3eUFVL1UvYzljR0VhK1RLQnRaU3J6dC83Vkw2VzJsSGk4R3hSeG91SDc5?=
 =?utf-8?B?QTRDWHlDaGt3dUJ5TG0rRmoxYmd0QWU5ZWdYNXAxakhtcXBHczlYMDNlRHp0?=
 =?utf-8?B?ZG5VZzdGVFp6MjBwRzdramVDUFhkNllQcGlZSmQyT3B6bnlxRVVKVTBXdE1T?=
 =?utf-8?B?dmMxazY4d3g5bFpTK1BkUU9JQnREWnJaNHRxcXQrKzJQRWdOZGJMaXErUVFI?=
 =?utf-8?B?RE84dnVDNmtDWmVYd2RXb1JUcGxOMGJwNXo1Z1BQbzhCRmtFUkgyeGpSQTBs?=
 =?utf-8?B?dEtCRmpva2g2K21VV3NjOTRLdUtVTlBZcVRYSW81bkJRbVJxd1RGYnA4dGV3?=
 =?utf-8?B?Tmhmb21LWHRqRGxQd3NKTWxjSUI3OEQ1VVhDTWVyMXpmZnNsb2ZOL1JCeU1W?=
 =?utf-8?B?dEJkMG0xUWdBWFgyaFIxYjFvN2huTUhLQlVGN2lWUVBlbUIzdW41akZQQXpL?=
 =?utf-8?B?Z051N3Faa3c3WjE3WmN4VEx3THB1R1Fwa25lSTVCSmpjTzlxVmpZUGJ5aktX?=
 =?utf-8?B?RjJvc0N2N1JzOUNrb0E2dkMvdXJLT0pidkZMem4ycC9rWGZLc3lPUE44eXNF?=
 =?utf-8?B?TkxKa1BBVHkvMVdHQjVnL2hpOWFCMnRJdjdIUE1kZno5ZzdmbXVMcm1DSkRy?=
 =?utf-8?B?bGZRNFZCOCt5OHpCMXpMNXJiQ2NqQVYrWjZwYjRKZFRySm5Bb2xScnhyR2dr?=
 =?utf-8?B?UlBqaitnbjRSRTZWSmR1VkVVT2ZkNXE0aGtIcGhVRmlwU2NSemRKVytWbGN4?=
 =?utf-8?B?THpiZk80bG1XYXBTZlBiTVhGWkJHSS93VFlZRHB0THc0YzJwSFV5WVU3ek9j?=
 =?utf-8?B?bE56VzBHSyt2YlNuQ3hjdlN0YjBhUmVEenBNajh3UjRZd1ovU2pidjhoNFFo?=
 =?utf-8?B?NEtvSmVwSzh4Qnl2QlZmRzM2ZHA5OGE1cGIxS1h0VHF3bTQvWnZrRU9VR0JH?=
 =?utf-8?B?eDEvU0tPam1HcGFSNDY4Y1FGTVJBcDdkWnJRaEZaZThzbmFXUG0yUGt1ZEl4?=
 =?utf-8?B?eXcwaVFTbC93c09yRW9uQURiY2NjUldMS0tadXJqUlRCSTZrQ0lzemdIT1JM?=
 =?utf-8?B?NFlWNVl3UXdKT09QK0daZ1NxUExrMFB3akhSdVlWYUVOTGpmVjE5d0FwbFg1?=
 =?utf-8?B?alZOSW5LSDRGelZYZTc2YkIxcEp5R3oyQVBYV0lOZVRpTDJCSk8yOXREcnRO?=
 =?utf-8?B?enhVdlBpeElaaTU4STNRNU9JTDUzMzZBeTAzUkpQdmMxSXdnNHJKYnF6ZjdP?=
 =?utf-8?B?T28xaWhZQUN5dXhST0svRElnNkN4QjNud2pYWEpUY3BYQ0wwajNQVlpCNFdj?=
 =?utf-8?B?elFzc2M3UkxadGRRVDhINGcyczE3MktETVFNRkZidkgwYytISS9vQ3FNWE9V?=
 =?utf-8?B?NU9aR0lYWkdoVzV4ZVcrY1dHcFEzVGM1TmUwRUFsamQ2Rm1mTnhvNGluVDVq?=
 =?utf-8?B?SUt0YlBxV3ZIWG5HZ29jZWRlZTVqN1BiSEdiNnljaGc2TnVjTHNldkxRMVI2?=
 =?utf-8?B?TTRIc1Vtc3NCL1F2cThOZ1lwZ3g0d3dNN2xYSGZwVjdIWUlQcFAyd0NBUklI?=
 =?utf-8?Q?Xw66ms5BsZpblcQydL2LDDtvI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388f0c23-cc96-42ae-7126-08dd2ad5ba35
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 02:32:39.6387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RV0yh93xwmXN+QxVUFkzSUinxp2+5zDmm2ki/f7/WecHXOk6hrEgjCCzytgLx2/WnWhPpaoY2RLvLouwo/0AyWVq45yGFJOeB8uKRE3UvSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7044
Received-SPF: pass client-ip=2a01:111:f403:200f::700;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

PiBGcm9tOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBEZWNlbWJlciAxNiwgMjAyNCAzOjU0IFBNDQo+IFRvOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxs
ZWV0cm95QGdtYWlsLmNvbT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5j
b20uYXU+Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3BlbiBsaXN0OkFTUEVF
RCBCTUNzDQo+IDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIEND
IGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IEphbWluIExpbiA8amFtaW5f
bGluQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUNCj4gPHRyb3lfbGVlQGFzcGVlZHRlY2guY29t
PjsgWXVubGluIFRhbmcgPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjEgMC8zXSBTdXBwb3J0IHRpbWVyIGZvciBBU1QyNzAwDQo+IA0KPiB2MToNCj4gICAt
IFN1cHBvcnQgdGltZXIgZm9yIEFTVDI3MDANCj4gICAtIEludHJvZHVjZSBuZXcgImFzcGVlZF8y
NzAwX3RpbWVyX3JlYWQiIGFuZA0KPiAiYXNwZWVkXzI3MDBfdGltZXJfd3JpdGUiDQo+ICAgICBj
YWxsYmFjayBmdW5jdGlvbnMgYW5kICJhc3BlZWRfMjcwMF90aW1lcl9vcHMiIG1lbW9yeQ0KPiAg
ICAgcmVnaW9uIG9wZXJhdGlvbiBmb3IgQVNUMjcwMC4NCj4gICAgIEludHJvZHVjZSBhIG5ldyBh
c3QyNzAwIGNsYXNzIHRvIHN1cHBvcnQgQVNUMjcwMC4NCj4gDQo+IEphbWluIExpbiAoMyk6DQo+
ICAgaHcvdGltZXIvYXNwZWVkOiBTdXBwb3J0IGRpZmZlcmVudCBtZW1vcnkgcmVnaW9uIG9wcw0K
PiAgIGh3L3RpbWVyL2FzcGVlZDogQWRkIEFTVDI3MDAgU3VwcG9ydA0KPiAgIGFzcGVlZC9zb2M6
IFN1cHBvcnQgVGltZXIgZm9yIEFTVDI3MDANCj4gDQo+ICBody9hcm0vYXNwZWVkX2FzdDI3eDAu
YyAgICAgICAgIHwgIDE3ICsrKw0KPiAgaHcvdGltZXIvYXNwZWVkX3RpbWVyLmMgICAgICAgICB8
IDIzMQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS9ody90
aW1lci9hc3BlZWRfdGltZXIuaCB8ICAgMiArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI0OSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQoNCkhpIEFuZHJldywgDQoNCkhhcHB5IE5ldyBZ
ZWFyIDIwMjUuIA0KU29ycnkgdG8gYm90aGVyIHlvdS4NCklmIHlvdSBoYXZlIHRpbWUsIGNvdWxk
IHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgdGhpcyBwYXRjaCBzZXJpZXM/DQpUaGFua3MtSmFt
aW4NCg0KPiAtLQ0KPiAyLjI1LjENCg0K

