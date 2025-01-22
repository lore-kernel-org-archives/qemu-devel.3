Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49B4C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 02:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taQ6r-0006jD-7s; Tue, 21 Jan 2025 21:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taQ6j-0006i8-SI; Tue, 21 Jan 2025 21:04:42 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taQ6Y-0001hz-PJ; Tue, 21 Jan 2025 21:04:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVSttZ9qQOc4vVapj2uHMLnD09fiFiUcbZv+VpqouyKR6SbQRXFx8L1Kqz5745eXo6EvagOZUMIX2hSTJfsb2QOiAJ0ODfwVwmNYxxxoPQItvDb/wFIjr2RVBxHK8IkNGzLg3v/tLKFlLcIbCLDOA295XEr5CsgPjCPV7iAkxf8IFoFyLJJVUuTwxqijF3zlkY+aT17+UBfgxjIriWnRFcmJXq2HTeXKp7qk8RRJh7gUSGE3O2kC8k2aMyT/EMPdBgUAfNoCzpNLmIF1gHeDSl40VCx+3JJaZp9o5hh0OWtGWvGO9d0WHIUVtnppjnuFVukWiEs4E/J2omU4lTUCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIZvmDJr843fMu+fzoBj3K3Hqh0ROh0Qq5e7EbPWtyU=;
 b=AkRs5IpYhY69/lwqKsG5XGoA7+AtRRkwB+vUJx/XlVH9wqsgOTCkQif0pAKeTDIKXu3yUMWtb8Ifj9cmCi9Ie31I2qdPkB1P9fceBJWWPbrqzD/PwDcdJBuYoC9moYi+4ztbVJy6w3nEH83HmJZMPcCesfN10mYcp/+llkj2iqLIzItPgXDaePovfURi6Uvyr7kNoiLHF1w3h+5NB/GUIqZAkOYr9Jd+UWnIYygIAs9jPaHYOXgELovEZEJEqnrEpPVBVUUwgwo56DzzjqSahySojYG2FDx2R1MlQVO91cA0209xn9clwv5B8IBbCwjmNGbY6u1m5h0k5Wy9GfkaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIZvmDJr843fMu+fzoBj3K3Hqh0ROh0Qq5e7EbPWtyU=;
 b=a51y4RlJ7Vs/KVDOSqhEbp3wxhhPGeVv89gPIPJLcSbr5DGh7T+UyYBqSnGpYoxYnYSR8KgJhvTW3KvcyfhGxnYzjwXrb8UmEKstOcTDdxZq2gCsxh7adT5K4g30UKygs2N886sgRBfYYRKcSRhI9RJpqvwSKcl+bXGhbZW513HXy+Oe0698J8U7ehBY/9u31jwlPpQXsxG6o+N7zuCVpq9GEVwgM0j+p+6k9bzlY4ZdIsB7UGwdG7YLS9Zk9pEa7bkDWdQqve4CHVc4GD2x8vPieizn2TRMtLg+af2mXZm+cyxv7CbfSIf0Hmm1L+rxN4HD/8HKOWNlnWuzYgDgiQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5308.apcprd06.prod.outlook.com (2603:1096:400:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Wed, 22 Jan
 2025 02:04:17 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 02:04:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)"
 <qemu-block@nongnu.org>, Bernhard Beschow <shentey@gmail.com>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [PATCH v3 2/3] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
Thread-Topic: [PATCH v3 2/3] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
Thread-Index: AQHbNnpnS4XsT/Ib70mwX3hmvelwN7MhdF4AgAD/D5A=
Date: Wed, 22 Jan 2025 02:04:17 +0000
Message-ID: <SI2PR06MB504103AB83CB83F565CE75B2FCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <20241114094839.4128404-3-jamin_lin@aspeedtech.com>
 <26daf2e4-dcf3-4da2-b9aa-63de37ecf877@kaod.org>
In-Reply-To: <26daf2e4-dcf3-4da2-b9aa-63de37ecf877@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5308:EE_
x-ms-office365-filtering-correlation-id: 0d8e8fdb-ecae-4693-ff87-08dd3a8913b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WTBLNThBVCsvMUxCZDNTb1duL1Y3RUJ4dncwMUJabGpYUU01YTBjcmdyclVr?=
 =?utf-8?B?Mnh1VGU3djQ5RlVqRUVtWkhKVGpoSTNzNlRnTmQreWxjTU1SbjlaaGVFcWFz?=
 =?utf-8?B?Qk12MFRSakh3SmxycU5XcjA1ck5qZGwvMlBxYmtzbnRqd2NtTHRHV1RCWmhi?=
 =?utf-8?B?am0wZjc4NHEwVUdRT0c2K0xYaFVJdVdSWlJVZGF5L0ZuQzlrSW10a0FTTHlR?=
 =?utf-8?B?Zk4veEExckJhNTJqRU9aUXF2STZyTlhtUURLRHBBcms3TnlLVmxFaUZDTHY0?=
 =?utf-8?B?Q1hnQjRhUS95MHd4L0xYck1pMjZ2NVdMV1VNdndjZE0rbCtyRGJISTM4UjVF?=
 =?utf-8?B?U29mcUZYcFRMUnNLSHRLc0YwL3JjMURzdDNhVHo4NmVJclgxcWx0UVozUyt6?=
 =?utf-8?B?cVJiL0phQW1DRkVzVjZlckFBbHVTMUhsaFdFditHVGFCSUhNS05vVHdEWm1M?=
 =?utf-8?B?bjFib3R4NUNYV3ZOc3dPSXdLOU1rK0JpTDYvL0FnbEdpUXFFYmNVRFVvRFpj?=
 =?utf-8?B?aytOMjFISWEvUHdoZnBncUhYZnd1YTRIRXZQUldXUHpvNkxyNWlyQ0RsVTk2?=
 =?utf-8?B?ZWFqWEc3SXdEWVFVdjU5YWlJWkE2NmRIN0g0VWlXak9DeDUvUElaY1ltZVlh?=
 =?utf-8?B?Y05CenRMVjh1OWZwNUJVWWI3bDl4REk5ci9DeU5kbUN1d01ZWTg4ajlEeG1Z?=
 =?utf-8?B?aDNldmNHNnNSbTRYUFlJNXZmbG1GWFcwK1JOM2pGdFp3dG9sQ1lXMVl5dTJq?=
 =?utf-8?B?Z0hiUWx3ZG5iQVNzL3U3UFZENEcvTnJJd0RmaXhvSklkd2R6TW9Tdi9tSmM3?=
 =?utf-8?B?L0g1aDFDd2dpUEZHeGtDT1Q4djllOVo0Sjd3TjI0N1RKOWlZZ2sxanlaOXlX?=
 =?utf-8?B?ekh0QlBXQ2pqK0pCRHpRblYyT3FoZHdaYzZsRDRtUFdCOWVkbnhkSGhLeW5l?=
 =?utf-8?B?cDBOcVJsUkVRMW9zZlFNSUV0YmJ6VzhIOG9XaXo1OVU5dDhFNDZGM1VVY284?=
 =?utf-8?B?V2NZYXkwTHgrSXBSZTFyNXluajhVWjVnMHprVndsVE9GeWN0OWxXNmdxN1VQ?=
 =?utf-8?B?Nlh1TVE5MVNNMmc1bXFyMldkZE1PZXdGMDlNOXNEZm82b013dGF2bEJVQVRH?=
 =?utf-8?B?ZWIyY2J2TEFkeE9nbms4SURnREtITmhRcm5xeG1xYnBLZnpYSkkrMmJiMW1z?=
 =?utf-8?B?aHhmTCsxZDRKakI0ZWsvSzJ3WWF5UHRQaGMxaG5jV2ljaVFTRUhnc1ZtOERk?=
 =?utf-8?B?c1RsZnlyWkMwMU5LamtrRVlyYkFFVlg3RmRQWnR3MEVuaTVIL21SbHh5Ritu?=
 =?utf-8?B?bmZQbzRmVG5EOW1CZ1RjTjA4UTUyWkY5QWJEQTFKM1pMN0tsSHl0Ti9xR3N6?=
 =?utf-8?B?SGtBTGVaSjZ3NnZPa2JwMnBSaDc2WFNvM2hxOTMrSUtLUGo1ZGpaa0RMWlBq?=
 =?utf-8?B?aW85aEhHWDJYekFPcUxvZXFITXlPcjBNNDVLVjJDbkFIUjRtZk9VcjRSNitv?=
 =?utf-8?B?NHlEb0NEcEZpNGZhdWpDV1VMcmQrM1I0d1dPdkZYaFA4OUpCWXhVUUIyK0hQ?=
 =?utf-8?B?RXAySWk1L1hvdEVhSmxIbU12bzVoQVl6RzIxeW82aXEwV0RuOVg0QmQraGFo?=
 =?utf-8?B?SmtJUlJTZUY3UGhHcmk5bE1tam41MmhPWE5kclNKZ0dreTBrQ2lxY2RLSUZx?=
 =?utf-8?B?RGRmUWlxenRoK29CeU4xY3VLd0Nibk5KNS9nR0xSc0lLUHNsVXRqWDFQT1Zj?=
 =?utf-8?B?aHoyaXBtR3dDMGJwcUgveFdRS1JYTDhZUlNCc2dMSEF4U1BKTUVFZitkcFc2?=
 =?utf-8?B?TEtlNDIyRHpkWjhIaUV6MmdHekNHcFZyK1I2amJlRER5ajMrZm1la2VINWg3?=
 =?utf-8?B?Q3BCMkJpaE9hczJqR0pSVXNTcmJuY0VGc0FaYzJJbzZXLzZyU1Uxcm9Dck9a?=
 =?utf-8?B?TTVwS2Z0WEtTYnE1TDg2Y3FGWjBoQkdmdStKZmF1OFlxOG9IYTB2UnFCZnNq?=
 =?utf-8?B?clkreTI4czJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NwVml2R1pyQXZXV3VSZkJQaU5iazBicWdQdFVLYVVKSUlPMWZRTTdrWFNp?=
 =?utf-8?B?VlpGOTNEMjQ1SFU5R3I4eDd2U2ticmY4cXlLamgxNmNybVVxUmVYekFyWE5Z?=
 =?utf-8?B?ckFYSk9IV0c1RG5nMjBOYmRTcVpWaHVZTmdYQXJoSmFUMHRMc3J4by8zVWRC?=
 =?utf-8?B?b2haeVpqUnROY3lMZ1hNTjRnakpLL01uM3VxYnJiNGd4T0lleG5oTzR3M2ZH?=
 =?utf-8?B?dWNYanFXNUppRUhDaTU1VXU1YU51VmlYWW1nWmVCbFE3cFBpamd5VlUxa3RK?=
 =?utf-8?B?ZGhjQ0hYYmJHcnV3NnhreldpaHFuOTN3OXk3S1l0WmxVdnRhS1ViQXpLTDMx?=
 =?utf-8?B?bkxuN3hSVmhYbzhCMXlSeTJKcHkrYm9pRnloenNJajRQbVl0Zi9PNFlPeFdY?=
 =?utf-8?B?blJFVndNUmtQbE9yNXlsUUFoWkpscTk5RDc4ZjhOVDEvOU9zcGVYRUZRVkJu?=
 =?utf-8?B?S0gxQkRndGRLM0lCV0w5c0NVbTFtaHpHUTJFNlVYc2FjRGZCMkdWZHZhL2xN?=
 =?utf-8?B?TG5vQkRRV2N1d2JjWUZVeTZGWENVMHVmQ2dpRUtlOHhubzJWaTkyYjUwdkd4?=
 =?utf-8?B?aG1rNVhwbndWZjNsc1ZiQXlkd2FqUnFEcEJEc3BVOXczVGZoMkRqVlJhNVJF?=
 =?utf-8?B?WkJSSEtpWGt4eDNHTE9yWTJ5ZVlQdUE4bTlmNERWV283V2lpZEtGbDRVS2pL?=
 =?utf-8?B?T3UvL20ybCt3OWZzcjl3UjBpcWpVRUtPQkozQ3VvYW1ML1lFVWh6aUYzbVVR?=
 =?utf-8?B?Sk91Y2VsRWZXQXhDaGp4YnErQzY2SGpML2dQaERBMHRoRXpiOTc5UlRwODFZ?=
 =?utf-8?B?dkFoK3daTitrYkJPWThDaW5zN1VFbllWcGJycVNNQjh3YWNJa1ZOVVFGdHNm?=
 =?utf-8?B?VnhEK1lybVRiR25qdXY5SlB0UXhTTXV0SVdzVXd0eDFxbUVPaU5SWkUvNzhP?=
 =?utf-8?B?dWVucXRSWk9pMjRxc0VwWDg0N1lPcUR0MzBsY2Q0cTV2cFk0TERsd05hVURy?=
 =?utf-8?B?eGlIeGlra09ZNU5MZmJWNC9oUEdzV3V2TnFBcGZ2aktZMVFNOW1qR0x2SFU1?=
 =?utf-8?B?UWxWRG1iZUxzZTVVOEF0eTh4YXVmOXJhUTBDeUJoc2Qydllha2l6YXZ0TzQ0?=
 =?utf-8?B?emJDOWlCWktCdHJpbEV5MVBNeVlWQXROMElXUHUxYW5BRXhNcndsUXFhTFVD?=
 =?utf-8?B?RG1SU0RFMm1PYXVjUDJvUng1MWNVVzhyREZyMXVjZStnZERZKzZMZ09pVWt0?=
 =?utf-8?B?cFNHUk0rVHZLZVB3M0VHQkZBcDBSOHN1cGxpYkM5TlNIdFZMKzNrU2N6LzAv?=
 =?utf-8?B?bHd4RUNDMHB4cllGdmU2NWpobWlVSTJQTC9aTDllYnkzakxqMmxEN01FTDhQ?=
 =?utf-8?B?dXJxY0Z4TEh5eUFJbnJDaVJNbWhIQWRpSDMzR0VpZnlPcWYrTVIveWFtWm9B?=
 =?utf-8?B?S01hbUN1MFVxb3JTS3psOTFGb1dnVTdpbTRDVDRFazl1dEFPVVJBVlpyaFpx?=
 =?utf-8?B?T3I2azgwTnJvN01pR2ZtclJTdC85NVd2VFdkd2ozMW5MRXFUdENVaFJFVEdm?=
 =?utf-8?B?RFFFU1pXVFpYa2ZTdk5qNnZjMWFjVGE3K25nNmFkZ0NZNnE0ZXdGVHpENFo0?=
 =?utf-8?B?ZE5yMG83N1JnVXgyTXNDV21SUzU1NDFmUDZhV0JVMzMydHl2cGJJTjlIMnBR?=
 =?utf-8?B?akwxYkE4ekpWdjE4M2F1Tmx2ZVE4YmJaL2pVWXVSV3A2RmpyaVJwcEVDaEFs?=
 =?utf-8?B?eU03RFl0L1N1UXpjK3NZWUVKR2ZwSzBjRmE4RWdPb3VSWXU0VFAwclRqWUVw?=
 =?utf-8?B?QUh0Q3RMVEc2b0JxTlliTzI1alJ4bDlpdGIzdUxKM0F6ZWdyMjBTQ0QrSHJ6?=
 =?utf-8?B?TnpuUnFtd1RDV3VaNFJCZi9SNkZ6a2ppd1R1WlV1Z0xqc3ZhS084T09CbXVm?=
 =?utf-8?B?dmdKQVVSQXA0RmUxbFB2LzRyanlaSnJJMHVCamEyNEEyS1dZSThzaEV2cXhs?=
 =?utf-8?B?K2pEVG9oUG1PS0JNVVBjWTgxT0ZSVFN2bWV2dnV5QUxQd1d4eldZUzJLQlhn?=
 =?utf-8?B?bU5FbUFTYnJ3VUhHRC95enlJYjNLUHZJNFl1MS8vR1hXOTZVaG1YeGNuWnVy?=
 =?utf-8?Q?Lms1OxiK0o6vsx2vLCymuhmQ+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8e8fdb-ecae-4693-ff87-08dd3a8913b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 02:04:17.1285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWkpKw1UwjW9zSV/OIxrvEp9I20kSbxR8Xf1N0558bJf04QbH4IXz+MtP9qhDOKHwVgS7SkNJhmhPcdZ3CbMhmgnB/WbkFuR1BmI5u5L85E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5308
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIxLCAyMDI1IDY6MzkgUE0NCj4gVG86IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47
IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsNCj4gQmluIE1lbmcg
PGJtZW5nLmNuQGdtYWlsLmNvbT47IG9wZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA8cWVtdS1hcm1A
bm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVs
QG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6U0QgKFNlY3VyZSBDYXJkKQ0KPiA8cWVtdS1ibG9ja0Bu
b25nbnUub3JnPjsgQmVybmhhcmQgQmVzY2hvdyA8c2hlbnRleUBnbWFpbC5jb20+DQo+IENjOiBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGlu
LnRhbmdAYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8zXSBody9zZC9zZGhjaTogSW50cm9kdWNlIGEg
bmV3IFdyaXRlIFByb3RlY3RlZCBwaW4NCj4gaW52ZXJ0ZWQgcHJvcGVydHkNCj4gDQo+IEphbWlu
LA0KPiANCj4gK0Jlcm5oYXJkDQo+IA0KPiBPbiAxMS8xNC8yNCAxMDo0OCwgSmFtaW4gTGluIHdy
b3RlOg0KPiA+IFRoZSBXcml0ZSBQcm90ZWN0IHBpbiBvZiBTREhDSSBtb2RlbCBpcyBkZWZhdWx0
IGFjdGl2ZSBsb3cgdG8gbWF0Y2gNCj4gPiB0aGUgU0RIQ0kgc3BlYy4gU28sIHdyaXRlIGVuYWJs
ZSB0aGUgYml0IDE5IHNob3VsZCBiZSAxIGFuZCB3cml0ZQ0KPiA+IHByb3RlY3RlZCB0aGUgYml0
IDE5IHNob3VsZCBiZSAwIGF0IHRoZSBQcmVzZW50IFN0YXRlIFJlZ2lzdGVyICgweDI0KS4NCj4g
PiBIb3dldmVyLCBzb21lIGJvYXJkcyBhcmUgZGVzaWduIFdyaXRlIFByb3RlY3RlZCBwaW4gYWN0
aXZlIGhpZ2guIEluDQo+ID4gb3RoZXIgd29yZHMsIHdyaXRlIGVuYWJsZSB0aGUgYml0IDE5IHNo
b3VsZCBiZSAwIGFuZCB3cml0ZSBwcm90ZWN0ZWQNCj4gPiB0aGUgYml0IDE5IHNob3VsZCBiZSAx
IGF0IHRoZSBQcmVzZW50IFN0YXRlIFJlZ2lzdGVyICgweDI0KS4gVG8gc3VwcG9ydCBpdCwNCj4g
aW50cm9kdWNlcyBhIG5ldyAid3AtaW52ZXJ0ZWQiDQo+ID4gcHJvcGVydHkgYW5kIHNldCBpdCBm
YWxzZSBieSBkZWZhdWx0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gQWNrZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4NCj4gDQo+IFdoZW4geW91IGhhdmUgc29tZSB0aW1lLCBjb3VsZCB5b3Ug
cGxlYXNlIGNoZWNrIHRoYXQgdGhpcyBjaGFuZ2UgZml0cyB0aGUNCj4gYXNwZWVkIG5lZWRzIDoN
Cj4gDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwMTA4MDky
NTM4LjExNDc0LTktc2hlbnRleUBnbWFpbC4NCj4gY29tLw0KPiANClRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9uIGFuZCBoZWxwLg0KDQpUaGlzIHBhdGNoIGlzIG9uIHRoZSBTRCBDYXJkIHNpZGUu
DQpNeSBjaGFuZ2UgaXMgb24gdGhlIFNESENJIChIb3N0IENvbnRyb2xsZXIpIHNpZGUuDQoNCkkg
dHJpZWQgdG8gZGlyZWN0bHkgc2V0IGJvdGggdGhlICJ3cC1hY3RpdmUtbG93IiBwcm9wZXJ0eSBh
bmQgdGhlICJyZWFkb25seV9hY3RpdmVfbG93IiANCnZhcmlhYmxlIHRvICJ0cnVlIiBhbmQgImZh
bHNlIiBpbiAic2QuYyIuIA0KVW5mb3J0dW5hdGVseSwgSSBzdGlsbCBnb3QgdGhlIFJFQURPTkxZ
IHN0YXR1cyBpbiBTREhDSS4NClRoZSByZWFzb24gaXMgdGhhdCB0aGUgU0RIQ0kgcmVnaXN0ZXIg
MHgyNCBpcyBub3QgaW52ZXJ0ZWQuDQpUaGFua3MtSmFtaW4NCg0Kcm9vdEBhc3QyNjAwLWRlZmF1
bHQ6fiMgY2F0IC9zeXMvYnVzL21tYy9kcml2ZXJzL21tY2Jsay9tbWMxXDpmM2E1L2Jsb2NrL21t
Y2JsazEvcm8NCjENCg0Kcm9vdEBhc3QyNjAwLWRlZmF1bHQ6fiMgZG1lc2cgfCBncmVwICJtbWMi
DQpbICAgMTMuMTMxNTI2XSBtbWMwOiBTREhDSSBjb250cm9sbGVyIG9uIDFlNzUwMTAwLnNkaGNp
IFsxZTc1MDEwMC5zZGhjaV0gdXNpbmcgQURNQQ0KWyAgIDEzLjIxMjQ2Ml0gbW1jMDogRmFpbGVk
IHRvIGluaXRpYWxpemUgYSBub24tcmVtb3ZhYmxlIGNhcmQNClsgICAxMy44MjkxNjZdIG1tYzE6
IFNESENJIGNvbnRyb2xsZXIgb24gMWU3NDAxMDAuc2RoY2kgWzFlNzQwMTAwLnNkaGNpXSB1c2lu
ZyBBRE1BDQpbICAgMTMuODMyNTI3XSBtbWMyOiBTREhDSSBjb250cm9sbGVyIG9uIDFlNzQwMjAw
LnNkaGNpIFsxZTc0MDIwMC5zZGhjaV0gdXNpbmcgQURNQQ0KWyAgIDEzLjg5MDA0MV0gbW1jMjog
bmV3IGhpZ2ggc3BlZWQgU0QgY2FyZCBhdCBhZGRyZXNzIGNhZTMNClsgICAxMy44OTYyNDNdIG1t
Y2JsazI6IG1tYzI6Y2FlMyBRRU1VISAxMjggTWlCIChybykNClsgICAxMy44OTkyOTRdIG1tYzE6
IG5ldyBoaWdoIHNwZWVkIFNEIGNhcmQgYXQgYWRkcmVzcyBmM2E1DQpbICAgMTMuOTE1OTQ5XSBt
bWNibGsxOiBtbWMxOmYzYTUgUUVNVSEgMTI4IE1pQiAocm8pDQoNCnJvb3RAYXN0MjYwMC1kZWZh
dWx0On4jIG1vdW50IC9kZXYvbW1jYmxrMSAvbW50DQpbICAxMDcuODIyOTA4XSBFWFQ0LWZzICht
bWNibGsxKTogbW91bnRlZCBmaWxlc3lzdGVtIDNlNWZhMDg2LTliZTYtNDUzYS04NTMzLWJjYTZj
YmExNTg3MyBybyB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBRdW90YSBtb2RlOiBkaXNhYmxlZC4N
Cm1vdW50OiAvbW50OiBXQVJOSU5HOiBzb3VyY2Ugd3JpdGUtcHJvdGVjdGVkLCBtb3VudGVkIHJl
YWQtb25seS4NCg0Kcm9vdEBhc3QyNjAwLWRlZmF1bHQ6fiMgdG91Y2ggL21udC8xMTExMTExDQp0
b3VjaDogL21udC8xMTExMTExOiBSZWFkLW9ubHkgZmlsZSBzeXN0ZW0NCg0KPiBJdCBzaG91bGQg
YmUgbWVyZ2VkIHNob3J0bHkuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0K
PiANCj4gPiAtLS0NCj4gPiAgIGh3L3NkL3NkaGNpLmMgICAgICAgICB8IDYgKysrKysrDQo+ID4g
ICBpbmNsdWRlL2h3L3NkL3NkaGNpLmggfCA1ICsrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9zZC9zZGhjaS5jIGIv
aHcvc2Qvc2RoY2kuYyBpbmRleA0KPiA+IDM3ODc1YzAyYzMuLjA2ZDFlMjQwODYgMTAwNjQ0DQo+
ID4gLS0tIGEvaHcvc2Qvc2RoY2kuYw0KPiA+ICsrKyBiL2h3L3NkL3NkaGNpLmMNCj4gPiBAQCAt
Mjc0LDYgKzI3NCwxMCBAQCBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfcmVhZG9ubHkoRGV2aWNlU3Rh
dGUgKmRldiwNCj4gYm9vbCBsZXZlbCkNCj4gPiAgIHsNCj4gPiAgICAgICBTREhDSVN0YXRlICpz
ID0gKFNESENJU3RhdGUgKilkZXY7DQo+ID4NCj4gPiArICAgIGlmIChzLT53cF9pbnZlcnRlZCkg
ew0KPiA+ICsgICAgICAgIGxldmVsID0gIWxldmVsOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAg
ICAgICBpZiAobGV2ZWwpIHsNCj4gPiAgICAgICAgICAgcy0+cHJuc3RzICY9IH5TREhDX1dSSVRF
X1BST1RFQ1Q7DQo+ID4gICAgICAgfSBlbHNlIHsNCj4gPiBAQCAtMTU1MCw2ICsxNTU0LDggQEAg
c3RhdGljIFByb3BlcnR5IHNkaGNpX3N5c2J1c19wcm9wZXJ0aWVzW10gPSB7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICBmYWxzZSksDQo+ID4gICAgICAgREVGSU5FX1BST1BfTElOSygiZG1h
IiwgU0RIQ0lTdGF0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9tciwgVFlQRV9N
RU1PUllfUkVHSU9OLA0KPiBNZW1vcnlSZWdpb24gKiksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9C
T09MKCJ3cC1pbnZlcnRlZCIsIFNESENJU3RhdGUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IHdwX2ludmVydGVkLCBmYWxzZSksDQo+ID4gICAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1Qo
KSwNCj4gPiAgIH07DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9zZC9zZGhjaS5o
IGIvaW5jbHVkZS9ody9zZC9zZGhjaS5oIGluZGV4DQo+ID4gNmNkMjgyMmYxZC4uMzhjMDhlMjg1
OSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L3NkL3NkaGNpLmgNCj4gPiArKysgYi9pbmNs
dWRlL2h3L3NkL3NkaGNpLmgNCj4gPiBAQCAtMTAwLDYgKzEwMCwxMSBAQCBzdHJ1Y3QgU0RIQ0lT
dGF0ZSB7DQo+ID4gICAgICAgdWludDhfdCBzZF9zcGVjX3ZlcnNpb247DQo+ID4gICAgICAgdWlu
dDhfdCB1aHNfbW9kZTsNCj4gPiAgICAgICB1aW50OF90IHZlbmRvcjsgICAgICAgIC8qIEZvciB2
ZW5kb3Igc3BlY2lmaWMgZnVuY3Rpb25hbGl0eSAqLw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAq
IFdyaXRlIFByb3RlY3QgcGluIGRlZmF1bHQgYWN0aXZlIGxvdyBmb3IgZGV0ZWN0aW5nIFNEIGNh
cmQNCj4gPiArICAgICAqIHRvIGJlIHByb3RlY3RlZC4gU2V0IHdwX2ludmVydGVkIHRvIGludmVy
dCB0aGUgc2lnbmFsLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBib29sIHdwX2ludmVydGVkOw0K
PiA+ICAgfTsNCj4gPiAgIHR5cGVkZWYgc3RydWN0IFNESENJU3RhdGUgU0RIQ0lTdGF0ZTsNCj4g
Pg0KDQo=

