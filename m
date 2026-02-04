Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD7E83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8q-0005wz-Ux; Wed, 04 Feb 2026 02:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZK-0004dT-BK; Wed, 04 Feb 2026 01:40:54 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZH-0004IG-C8; Wed, 04 Feb 2026 01:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=er2dgzgQsGv08k2nSyXKI9Wmn+SDY+Mh6HStFttzN/FzqXGf1Zesx04/w9OahDeONO2Mn1iBNFQWrNO+sbJIhWSKzDH0apzxFLusFJw3gBYfTHkeXvmtF6OHxUILckSD8QmAy+27YyyeopuNAx+jYc9tRQbtsSsigYKlK7318AjKKci+7qmRG9oH9oPo8d0e5lBF2bU10DUGU7C6y+Od+30ckGhN0xOJF/PJx9rdR4bE5pjtRz0vPDSdbgpDv9/OjiXbPPIwMWjbeISHksOzL8NgxWXvO3UF8PZAjFBCKv27QRMtyae9J6sLLnf0oKimi6O51M55hugva59KCR/Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOLW8iKOf+tacZ84BRw3NJL4DAiwSD35ngYuZDohhm4=;
 b=C1JHNbsQdXAsqeKNMNiqzRhcSi91BsxVfcl+YCYS17hgtR4irVUrsZrgS0mrth82VaOMz6ea0+nxRTzhHGeJZa2LnyHgb/QLMZlbVqnNi+NCFdU8pUNIEL4IGj/tszq7lKrMEUjSxLFMERx8MDjjM4q6bunn11ep9iUEUAC1Pux88TCdDu1ua4cvO2JtOgW9rb52JvxbAgIEwDTSvNOD4RLT6wZsTOSWpezqTsVn+B3s9IWpxbRxgq0UtknW8GMwqNIijqjNVQVAs6zcn1e1ORAnMinE6D5a+P5oTApVAxMGrQU55gBulN9CB0ng88HEq5gqpONPmc0tFeuOMuoi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOLW8iKOf+tacZ84BRw3NJL4DAiwSD35ngYuZDohhm4=;
 b=nWZ5Y9qAAduCzG2Z5bA4JqEn2xVza4ShoZsXHAkDeAXudXPQ3lWi61GgqhamMAByIUfIzdC/sI4VAKU7ImzQ47sX7MZ0tEayjBJFierjfG7oWC0G8W+MDxugyA2fgJXXYiZfvzCB4MJtxXic2gy8X42kn0BtdC/S/B3VGYOdD/O8VFU8PqaANoMH9m24f/dLG8EdlGnYE4Q7SQvPZpNaMOR9EqhSk/tU6oEoSYti+uieb0G/TuP+MPQG7lsxJW+YReyc/qJA3wNk2jChEYBoJfWVtqq8uaszxr9SI89zUeJO8dq9x9I0hR6UVomixTO5tcJloJ2qnTU1ZDmm8YhWUg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:34 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:34 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 12/22] hw/arm/aspeed: Attach SCU device to AST1700 model
Thread-Topic: [PATCH v6 12/22] hw/arm/aspeed: Attach SCU device to AST1700
 model
Thread-Index: AQHclaEqOhEcw/+0mEyYlArVFk8t/A==
Date: Wed, 4 Feb 2026 06:40:34 +0000
Message-ID: <20260204064016.3515639-13-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 04e99176-2d98-4a0e-f28c-08de63b84c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bzZiVWxST05rMEQvUXk5UlRnSHZLTVNaNGlpZmZnSlVwWXNIeENpbEkyR1lD?=
 =?utf-8?B?MlR6dVA5bTRxdWFrZERPd2JEZHpDOU9iVVY3RlNWK1FZZTlGK1lIZUdsVHRO?=
 =?utf-8?B?L0ozY2pvY2pIWUNhOHpMMTJ2WXZJblpCUkljMzV4d05ZcGh5cnVDSWVraHRl?=
 =?utf-8?B?dkt5YTVhR2lTclJkZ2JWTlVORWNNOExlajBzYlZlNXlMR1lhYTV5bnZ2dE1r?=
 =?utf-8?B?N0N0UWVGaVByY3RMMjFIaTR0ZEg5SXlwMmx0dlVCNHEvRFZGMDVUeUY4VWpy?=
 =?utf-8?B?Z2l4TDhGRXRRMkppN1F2L01QVE5yc0lWTi9GMkxjUU1KRzh4dmllQk5xRDln?=
 =?utf-8?B?Ym5jODN3Znd2L29IRTdUYUZSQnYyVUIvd2VUK0NvcmtJMGpYY2lQWjdHWWJT?=
 =?utf-8?B?aG13OENRZEh3ZVk3dk5RQlVEYldsRVViRXVDR2xZV2x0YWNpZFRBRzR0bVQy?=
 =?utf-8?B?UENPUjN6dmxzUHV4a3lMNy8xNEpRQ1YwYXlLemo4ZjNvcE45TCs2QWRwSUw1?=
 =?utf-8?B?cWtuYTRZUmkxeW1FaWlBdW5HQisya1ZjTC9SbUt4eTc4LzloUXQ1SGtwdzN5?=
 =?utf-8?B?elE5VHBjWEpleUVTQW9IVkUvZ3VmcUs3TnBRdm9LTm9LYm9LNXNORER5OVha?=
 =?utf-8?B?cDE0YXB3Q1puaTF2Wkoyb1VYSWNzNjMxZXdWelAzVkk4RGh4bEhCa3dhSisv?=
 =?utf-8?B?anFTUCttV1g3WFRCNmRnWHRlYm10V3ZoVEpiNGxUcnhnMmF5TGduenFUclFV?=
 =?utf-8?B?UHF5c1NuSXBaNTI0cU9DSFM1Mm82UEI1VEhjODdNWTNMY0VkY3hSTk16R2p3?=
 =?utf-8?B?aGprcG53K0pCVUhtY2tOUDRxdGh3MlJuMTJvRzJJTXo1T0RxSCswVE85NWpU?=
 =?utf-8?B?dnBkQmI3YWpWTlpHdlFhOW5oZXNCZGwvWVNFS2dJNUN5d1hocGFtZ2FMeHVS?=
 =?utf-8?B?VWkzLzVXNjRhZWo1bFZ4eUNoREFzUkVpMnhpMzdHcks3YWNydlhnSVhZUStO?=
 =?utf-8?B?U21iRDVMMFlnTzVnK2ZmclFaTDA3UFFqbm9xR1NCNnNsL3cvTGdHOFVLNFZK?=
 =?utf-8?B?NXdkczJ0NU9NWDVINFowT294bEdzYkJBSCtza2k1NTNQVFBjNjFGbjR0Sk42?=
 =?utf-8?B?c2h2OVRTWUtXOFFSMGhYdjBRMmRWdzdHMURTR0xiSTdtME5CSEk2ZDZuVVMx?=
 =?utf-8?B?bzEwdEc3SjFtTmVsc0xlOFFwYlRpWmFHUzNOMVRuNDBvbHpLNnZ1aGRjMGNC?=
 =?utf-8?B?K2FoNXdGMzBDMGpkYW4vWlRyQVFXaEN5ekRobkRCRmhmRnpDSjg3eUtWckVx?=
 =?utf-8?B?RldBNHV4eC9rbXR2aFNnRzZXSEhxbENTY2FjUkd6NmhUZ2NUZmFPemh6RkFE?=
 =?utf-8?B?TXRFUXVJVTc3Tzd1NlZsNm5HTjhCQk5mMW53VW5LQm4wT013dTkyaVdSdncv?=
 =?utf-8?B?aGQxckZLTHlOdGsrcWFMWTVSWGN0T2p0QnFrTEtnKzRyM3ZLSUx4Z3JpY1ZK?=
 =?utf-8?B?cWRkYXFueEhaZFhWVEt3YkRVc3I3SWx3NVBFQmpaZGliaHpDdENEcWJtVjBN?=
 =?utf-8?B?RFVqWnRXYm9FcktQRzdpd0t0TlJ0U2Q2eFJMci9kUWdsNHFzM2U4a0pERG1Y?=
 =?utf-8?B?NHpzR1Jta3V4cVB5a09iSDJNdFRSdHg0b3hBTll0Mnh6V1RXNUNod1RHbCtC?=
 =?utf-8?B?dFBTbmhlY1dHR0VkV1NuR1B2cm5NUklwakJQVTFwTkRnMHNOTmtCYlJMM3Rl?=
 =?utf-8?B?Q3ZHQkYvVmswWllPOFlRMnNNYXd4YU5HS0lBTHk4SUd0NU1CZXRCdmdBT3lM?=
 =?utf-8?B?THVTTmhGSHpFM1dwRHBUTVVNOEdJaU1IMUVMNEZKZzBYaWZETEtCWWFqYko1?=
 =?utf-8?B?NFNMbzI2eXE1U0xPRG5xVSt3NG9rWVJFS2ZldEhQcThVTzExMUROSE05V1U5?=
 =?utf-8?B?cUhaSWpTQ1VCUjJTSXRaRzBMNDc2RE1OVm0rY25GOTNad3A4Y2ZMK2xMRGls?=
 =?utf-8?B?L1cxY2h2NmJ6S0ZxWEYwK1RWQTlzeFg4dUJtSXNvdDdtcGlJQWd3OEZhVHU0?=
 =?utf-8?B?L0ZJNW1RT2U4a3g0MDdNQVV4ZHZUZlh2R0RNS2ZFaVJBOERmdHJEYVVYRStm?=
 =?utf-8?B?RHkwUTNoRTlxYWxvTGUzV0hUU2s2ejUwNG1yT3hxOHc5YkxqdkxjVWF6YmZL?=
 =?utf-8?Q?mWx7T82q8NWMwBIrZ7O4YC4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjh2bWZCRUVtNXN5K3VDckZtY0YzMmhTb0FOVXZPYTVWZUFja2NNNzZTbVZx?=
 =?utf-8?B?cUdWc2Q0Z1N4NnNXcFJ0aG8zbUVWN1Y1dUhNMG5oWWxNTS85M211ckhXQk5S?=
 =?utf-8?B?SVo3UkVuNnRJU29Ia05yUGpRZDlsUnlTb0xmSzNRMkFlaHA2RzVmR3FsOFVX?=
 =?utf-8?B?TTk1aWNZK2FzbWZLbEdjMTdCUWVVQjlJWDV5Q08xSml6U0JVWndxNlZzZEVq?=
 =?utf-8?B?K0RPR0dDeXNGQzl3ZUFjU0k1M3dycGtTelFmbkdhOStzR2U5YlBaQWdPcDJq?=
 =?utf-8?B?TnVsTHZZbGJxVjJiYXlpR29kcHRIb3dlc2FwVlFoYzBkUUROTWlHV3BPZnFR?=
 =?utf-8?B?MzR5Q3U0WG40bXlGcVFzZGJaYmFQbmdEcERDWEovb2tIYjQ1Z1Q4TWtGY0JK?=
 =?utf-8?B?NjlxYlZTVVhOTnVXUGF2TVhxSHBMNXNYNGtncWVnL2VtaGhYSWZsdm5lYzRV?=
 =?utf-8?B?OWY1aElUa0NFcDdtNlZNTGVZR1RPZzY2ZWlzbVo3RUcvd1pOY1V4WVdwNXlE?=
 =?utf-8?B?WU1zV1NKNDhjQ0cyQVJPNHVqb01zSWNyNytoRCtuOGVVd2VGcy8yeDVDS0ZP?=
 =?utf-8?B?K2Raem4wbW9Ub083eCtVMnhoeHB0aGpQQWZkV3JFRDdnUngybnowRGcvazFn?=
 =?utf-8?B?QzFCL2dqVWdGQ2Q1NjhkWTVwaHFQOVkvSUs0amZ5RTFKK3FyV2N5MjJLaDJu?=
 =?utf-8?B?Ry9wZkE3MXRkems1OUFsaUdhWXE2UGdSVFBjQUdKWHBYdmtxY2pKQ0t4U0N6?=
 =?utf-8?B?M1Mwc3JjaXhHVzhSUXplSzFteEJmTVBIdHNOUDIzdUNDK2FsbEhzeEFuaXdM?=
 =?utf-8?B?RHl2aWRBMEEyL2NiVVJKZkVpNG5pVXhCSWJUMzh4YzI4bDhWQlBDZEg4R3o5?=
 =?utf-8?B?d3RBTGNtZis3Q1FYTzZKK1ZlUnBaY1FPbGdMS1JKU05EdERja3RDbEpxOUZz?=
 =?utf-8?B?NWxJeDFVVklObUtSZmxnZklScGtoRFZGRWxsOWZxMldTWGFzdTBHRFFHcExV?=
 =?utf-8?B?RFBtTUY2K2xyUWlPZndYa1dHNk1wOHAxMjFmb2hZS1VrTDU3SFVCN2dtM3Zw?=
 =?utf-8?B?ckhhNXpnNThoN2d5R3ZjZ3k2TW9UaWIrcmpOU1pXRSs2bEVUTlpKZHZPWk8v?=
 =?utf-8?B?QXFzOWRYc2NuQnY4a01adzA3NzFtUC9RVG5tcVA4SVJ3QjVuZFJPbG5PbDdP?=
 =?utf-8?B?ZjlFakRtV3NMbUNjSzlDVnVURlUxeFp0QXVlanZaZzhFYk9EN0dRczR0eE5C?=
 =?utf-8?B?eFlYb09qMXhnUXdCVE9GekllWGhIRytYN3g2U1YyYUZwbHNIanI2MHpuVzRV?=
 =?utf-8?B?NWNEa3R1eW1ZMXphOUpJV2MvOFROTGtBbUJMbUJCZVZsK2tnLytpbTgzeHNs?=
 =?utf-8?B?WktkTlAvaDdOeFFuaVQ1TmtJZXprU0Jva1AyTjVjdHNrYVhKWHNSSyt1Qi90?=
 =?utf-8?B?OVd4VmkrTDM4ZURHdXN5UGJoVFdXa0o0Z1RORStxYVJMTlFXak9yU3FqanNI?=
 =?utf-8?B?a0w4T3V1dVZuTmp4K3F3V0x5QWxDS0JTSGExQTRhNkFhQ0pMSHd6V01JRnR2?=
 =?utf-8?B?bG1xbEZxOXNzL1dzb001UFVJekJvckZzd1R0Q3ZqNlJPRW5xait0eEtWZ2Ry?=
 =?utf-8?B?NmZCeVFtOVB1M2czcityZ2VNUzRhZ2hMaEp1T1V5TzVxWm9BdlRhSVZjaWQ5?=
 =?utf-8?B?VFZtZngwUkhVcWRSaHVuWmd1eitiejZRbTRldzE1VmxLMWtxc2ViaFoydTFQ?=
 =?utf-8?B?K0V5TEgrWVloQllVdEVvcXdoRUtPQmF3Yk1ycVdVSktLYTBTb2puS3ZkZ0hP?=
 =?utf-8?B?clhQQzFMSnc2bnZGbkgyUUpISHVydkprbWU0S2tmbTNoLzFmd2dwRUEvSzl5?=
 =?utf-8?B?ZTFNUnhtNmlMYXAzTm1MN1hyZ1Z3VWVRc09oQW92MjErR2lTZklaMXRYZWFD?=
 =?utf-8?B?ZzFwMVgyV0VCMDhNVVp3SDl6VXdBbXM2eW1MQ1lQQ1RaZ3VVUldheTRNU1NK?=
 =?utf-8?B?cFhYT2lEQVpqTE1aRVNOUktnZUx6c1c0M1VFWlJUYTdBdTM5cFJkRWh5d1pX?=
 =?utf-8?B?cC9jaUFKeEdMbkl6djVlNm1KZytxamFVM2l5OU9mNGlJaDRqTDJLaWRvQ0JQ?=
 =?utf-8?B?ckc2WXJRQWhZNjVDY3NzV1hib3V3Uks0Q3dxOUNpWDRjY0Q5VkdnS1dnNzRv?=
 =?utf-8?B?ajhURldGVHZKOThiMm8wMURTNGRUWFM1UVFLU2N0VGdlcDJCOXhRVWRXZ1RS?=
 =?utf-8?B?TlloRnNnSnZldDZoQzdpVGM1Si9tOVVjVW1JMHB2bnF1N0Z6RjYxb2llWjJm?=
 =?utf-8?B?ZFVSaXB4bmlsak1UYU9NZkkzaDkyUEZJS3c0dGhuSi9WY2JiNFVjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e99176-2d98-4a0e-f28c-08de63b84c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:34.2510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrXr/6a5h9DGuLmLVIKUgGbg4PWqAreHLhSbQTenPjK/V07wX94B9Dub29PjRNzJVdZF008MUaeS05ekeGWCpd/rmXvdEmqQrwFAtLdeOAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:21 -0500
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

Q29ubmVjdCB0aGUgU0NVIGRldmljZSB0byBBU1QxNzAwIG1vZGVsLgoKU2lnbmVkLW9mZi1ieTog
S2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD77+9
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZh
biA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFi
aWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAu
aCB8ICAzICsrKwogaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDE3ICsrKysrKysr
KysrKysrKysrCiBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgIHwgIDIgKysKIDMgZmls
ZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJt
L2FzcGVlZF9hc3QxNzAwLmggYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oCmluZGV4
IDQ0MTY1NWNlZTcuLjY1ZjE0OTdhMmQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVl
ZF9hc3QxNzAwLmgKKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaApAQCAtOSw2
ICs5LDcgQEAKICNkZWZpbmUgQVNQRUVEX0FTVDE3MDBfSAogCiAjaW5jbHVkZSAiaHcvY29yZS9z
eXNidXMuaCIKKyNpbmNsdWRlICJody9taXNjL2FzcGVlZF9zY3UuaCIKICNpbmNsdWRlICJody9h
ZGMvYXNwZWVkX2FkYy5oIgogI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2x0cGkuaCIKICNpbmNs
dWRlICJody9zc2kvYXNwZWVkX3NtYy5oIgpAQCAtMjQsMTIgKzI1LDE0IEBAIHN0cnVjdCBBc3Bl
ZWRBU1QxNzAwU29DU3RhdGUgewogICAgIE1lbW9yeVJlZ2lvbiBpb21lbTsKICAgICBNZW1vcnlS
ZWdpb24gKmRyYW1fbXI7CiAgICAgdWludDhfdCBib2FyZF9pZHg7CisgICAgdWludDMyX3Qgc2ls
aWNvbl9yZXY7CiAKICAgICBBc3BlZWRMVFBJU3RhdGUgbHRwaTsKICAgICBTZXJpYWxNTSB1YXJ0
OwogICAgIE1lbW9yeVJlZ2lvbiBzcmFtOwogICAgIEFzcGVlZFNNQ1N0YXRlIHNwaTsKICAgICBB
c3BlZWRBRENTdGF0ZSBhZGM7CisgICAgQXNwZWVkU0NVU3RhdGUgc2N1OwogfTsKIAogI2VuZGlm
IC8qIEFTUEVFRF9BU1QxNzAwX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTcw
MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKaW5kZXggMTc1NzdlYmI1YS4uNDlhMjQyZjNk
ZSAxMDA2NDQKLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKKysrIGIvaHcvYXJtL2FzcGVl
ZF9hc3QxNzAwLmMKQEAgLTIwLDYgKzIwLDcgQEAgZW51bSB7CiAgICAgQVNQRUVEX0FTVDE3MDBf
REVWX1NQSTAsCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX1NSQU0sCiAgICAgQVNQRUVEX0FTVDE3
MDBfREVWX0FEQywKKyAgICBBU1BFRURfQVNUMTcwMF9ERVZfU0NVLAogICAgIEFTUEVFRF9BU1Qx
NzAwX0RFVl9VQVJUMTIsCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTCwKICAgICBB
U1BFRURfQVNUMTcwMF9ERVZfU1BJMF9NRU0sCkBAIC0yOSw2ICszMCw3IEBAIHN0YXRpYyBjb25z
dCBod2FkZHIgYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW10gPSB7CiAgICAgW0FTUEVFRF9BU1Qx
NzAwX0RFVl9TUEkwXSAgICAgID0gIDB4MDAwMzAwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RF
Vl9TUkFNXSAgICAgID0gIDB4MDBCQzAwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9BRENd
ICAgICAgID0gIDB4MDBDMDAwMDAsCisgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TQ1VdICAgICAg
ID0gIDB4MDBDMDIwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9VQVJUMTJdICAgID0gIDB4
MDBDMzNCMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkxdID0gIDB4MDBDMzQw
MDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9TUEkwX01FTV0gID0gIDB4MDQwMDAwMDAsCkBA
IC05MSw2ICs5MywxNiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKICAgICAgICAgICAgICAgICAgICAgICAgIGFzcGVl
ZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9ERVZfQURDXSwKICAgICAgICAgICAg
ICAgICAgICAgICAgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0UoJnMtPmFk
YyksIDApKTsKIAorICAgIC8qIFNDVSAqLworICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKERFVklD
RSgmcy0+c2N1KSwgInNpbGljb24tcmV2IiwKKyAgICAgICAgICAgICAgICAgICAgICAgICBzLT5z
aWxpY29uX3Jldik7CisgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+
c2N1KSwgZXJycCkpIHsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKyAgICBtZW1vcnlfcmVnaW9u
X2FkZF9zdWJyZWdpb24oJnMtPmlvbWVtLAorICAgICAgICAgICAgICAgICAgICAgICAgYXNwZWVk
X2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9TQ1VdLAorICAgICAgICAgICAg
ICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+c2N1
KSwgMCkpOworCiAgICAgLyogTFRQSSBjb250cm9sbGVyICovCiAgICAgaWYgKCFzeXNidXNfcmVh
bGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+bHRwaSksIGVycnApKSB7CiAgICAgICAgIHJldHVybjsK
QEAgLTExNiw2ICsxMjgsMTAgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfaW5zdGFuY2Vf
aW5pdChPYmplY3QgKm9iaikKICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJpb2V4
cC1hZGMiLCAmcy0+YWRjLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuYWRj
LWFzdDI3MDAiKTsKIAorICAgIC8qIFNDVSAqLworICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxk
KG9iaiwgImlvZXhwLXNjdSIsICZzLT5zY3UsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VFlQRV9BU1BFRURfMjcwMF9TQ1UpOworCiAgICAgLyogTFRQSSBjb250cm9sbGVyICovCiAgICAg
b2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaS1jdHJsIiwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmcy0+bHRwaSwgVFlQRV9BU1BFRURfTFRQSSk7CkBAIC0xMjUsNiArMTQx
LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9i
aikKIAogc3RhdGljIGNvbnN0IFByb3BlcnR5IGFzcGVlZF9hc3QxNzAwX3Byb3BzW10gPSB7CiAg
ICAgREVGSU5FX1BST1BfVUlOVDgoImJvYXJkLWlkeCIsIEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSwg
Ym9hcmRfaWR4LCAwKSwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoInNpbGljb24tcmV2IiwgQXNw
ZWVkQVNUMTcwMFNvQ1N0YXRlLCBzaWxpY29uX3JldiwgMCksCiAgICAgREVGSU5FX1BST1BfTElO
SygiZHJhbSIsIEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSwgZHJhbV9tciwKICAgICAgICAgICAgICAg
ICAgICAgIFRZUEVfTUVNT1JZX1JFR0lPTiwgTWVtb3J5UmVnaW9uICopLAogfTsKZGlmZiAtLWdp
dCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKaW5k
ZXggNTA4NmQ0YzUxZS4uY2RhODQxZTEwMyAxMDA2NDQKLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKQEAgLTUwOCw2ICs1MDgsOCBAQCBz
dGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3MDBfaW5pdChPYmplY3QgKm9iaikKICAgICAgICAg
LyogQVNUMTcwMCBJT0VYUCAqLwogICAgICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmos
ICJpb2V4cFsqXSIsICZzLT5pb2V4cFtpXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVFlQRV9BU1BFRURfQVNUMTcwMCk7CisgICAgICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKERF
VklDRSgmcy0+aW9leHBbaV0pLCAic2lsaWNvbi1yZXYiLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzYy0+c2lsaWNvbl9yZXYpOwogICAgIH0KIAogICAgIG9iamVjdF9pbml0aWFsaXpl
X2NoaWxkKG9iaiwgImRwbWN1IiwgJnMtPmRwbWN1LAotLSAKMi40My4wCg==

