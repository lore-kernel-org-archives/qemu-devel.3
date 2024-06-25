Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6922C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzTZ-0001xH-SM; Tue, 25 Jun 2024 02:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sLzTP-0001tE-V7; Tue, 25 Jun 2024 02:16:11 -0400
Received: from mail-psaapc01on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:feae::71d]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sLzTK-0006bh-KJ; Tue, 25 Jun 2024 02:16:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCg0axsR/QoXxk+uuNNWnVvjFJ0WU988XOYZNTVwQ88l3Zaueq2P5eRfI4yZPYcbGbizq1pKlY0f1u9Spf80sSB8BlsqyoC/YqwCP/EZqbPRsm6LaC/MnmlV3IcGyKQaBoKRdwpq/dVJshTJrWMKnwMecnTIqBAkRG8SfJzbIQTpy/Ft0DfleqS88LaCYKo8zn8Bmu1DPLXrxCvEbvHDWAhMGcrUxl6k0yraiR9prZEzLFvTUFAkn2TT/uhHjfuI+mUMYYUXDG4KConN2Sd4ENYO9vu16hQs8sCnElRZ9tx2TJJvUebnKByM2saDKCIRlu+RIW/laeKqFl7eHv9VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsFtrn4panLWmHIBA7GNqM/NvKv//P+Hak8joKDorUg=;
 b=EOTUtXz6vyY5hSC+qEkwNu8Z0ZLIvj9cplKcQXUTZk2vV1nN4PkCdxPHMQCicQ71fRdD3MfV8tIpTvxSnxYNIMDRsKrOH3+Dy+nUVJEkld1dNAG5eZSjaJSTJ+oB+fYeoErubN6EsOBtSeB+6SWV+s5wK9C6kU/RfYgyR+T2gy6130dg5gOELaFT86PCvq7Eu52Iem2/bqDMrcL6izD3zNaziReaI+k1nMeg0CDdmrfKq3j8m2QhihKEIVc922Qa79F0K1OuVyaWRxOn+AbFBckJ3HvioushDWCnLbU4c+tES+0fKtPok0NnO0ueY+yiKoH7K4ChtwOc2TCqez+6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsFtrn4panLWmHIBA7GNqM/NvKv//P+Hak8joKDorUg=;
 b=AVWItm3ynsWkKaclmwny4bDQCbTXPic4wgnLVbcefVM6v7LeC/jv2kbRl0Q2KznLZ1se95kmoU9jsoCcSkbU6g4H9gNNDzac9527D6NricqbFRqqM172rFEZiJ1rxmiP/ftJ2U2NwIlstopG55pH87D95yWM9ftP4V12PD0Bg4jhzvmI70OZkJzPZ/QXwbgKs2CpJGeznyrIATUqjgZ8XjFru0PWjb3CKWU6VK7crGVHBEglBfr4lhtpdxtA+DxdtFAXPhy5v0e/mHZUrNUQVAxfR8Y98f5tXI2HPooTJoZoxCXJGm2MpfH5KvR3T0pxIToNv6d5ZY4WnUnHWd/iCw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 OSQPR06MB7132.apcprd06.prod.outlook.com (2603:1096:604:296::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.25; Tue, 25 Jun 2024 06:15:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:15:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: cmd <clement.mathieudrif.etu@gmail.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: RE: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
Thread-Topic: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
Thread-Index: AQHaxqIVksRkQEAAIEeptYffZVrMR7HX/MgAgAAA3YCAAAD/gIAAAa7A
Date: Tue, 25 Jun 2024 06:15:59 +0000
Message-ID: <SI2PR06MB50415148B5224AB52D485D02FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240625015028.1382059-1-jamin_lin@aspeedtech.com>
 <20240625015028.1382059-2-jamin_lin@aspeedtech.com>
 <24dbb79e-cdcc-4415-befa-e6351c8f29b4@gmail.com>
 <69656db3-24a7-447d-b2b2-49a938744be4@kaod.org>
 <d698609b-4760-4932-999b-4d4754021421@gmail.com>
In-Reply-To: <d698609b-4760-4932-999b-4d4754021421@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|OSQPR06MB7132:EE_
x-ms-office365-filtering-correlation-id: 5bd753ca-c97e-442e-5c7e-08dc94de47f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?NXRydFNLK21BYll5SWMvR1FXOUtMOFNXM3VpR1FDTnFodDNrVnR6UGlockhm?=
 =?utf-8?B?OWtEckhnQUxjcG5JL2VpZGZTRzI2NFRzaUJUQk5FTkFZSEJ1N0FXeTQ5MUtP?=
 =?utf-8?B?ZWtqVndOTTFiV1IrZThCNzJOTjU1MS95eFNHQTB0OUY5bFdiOWZGb0JiN2hq?=
 =?utf-8?B?d1VjcTZEV3ZFUSs0dTNUMzVhOXU0ZEZzemVCcmI2MTFRRTJnNEYvN2swaVgy?=
 =?utf-8?B?eCs4ZWhPdlJhM2dWMVo0dnN0MDVQdksyZkQ0eEgvZXJQNDBZVnFCczRTWkJX?=
 =?utf-8?B?OVd3eHNMZVJzT3c2dW5OaHk0dStmYy94UjZkSlU0bFdaSzNOcE5yOS9vTzJ5?=
 =?utf-8?B?U0YxS0NxeUhyempXNGZYaFlmQWttcHpxVFk0UzN2YzNXeTk4WUp6SDA5NmZY?=
 =?utf-8?B?N3NDTFBXcGV1SWVtOG4wc1VWUXVSa1Y1UVdKRkdnVDdibzFkNGpKNW1pOHhS?=
 =?utf-8?B?RXJyaG84SWNxNlFHYWtGT0wvdDJPZzNjeGJLY0FkM3lxc05OdGRPVUh6ZldI?=
 =?utf-8?B?ZEhEeThWRVNRcjIyTURpZ1BvRjJDRGttdjFEMGUxRTdpVmdNblFxbzd6Tjhp?=
 =?utf-8?B?RjhYaGpaeVFobGZrRXhsU0grdElPQ1lPMzIyWXJWeVRKMmR3Mzg5L0lxc1dU?=
 =?utf-8?B?VUZ2Ty9xQXpaYnlZRnllaUJOVzJNdnM2Uzhia1REcXRMUHpVNGdaM3N1Nm5Y?=
 =?utf-8?B?THBaMWppN0RXbXk0L0tpcTNUR1ZXSy96RnBuU3dvelNoZk15czI4eUk0RGFD?=
 =?utf-8?B?VHMvNS9tOGVsU0ZqRm5jTUEvY28rcnlJS3VaWjR2U1hVajVWbmVwdnA5RXky?=
 =?utf-8?B?VCttNkRqeXhpaXQySitYdlRnaGg5L042M1N6aXMyeTFOTXdZZitLRmlNeFFY?=
 =?utf-8?B?YXJvUHM5MkVBUHBHSDV5SFluTXRxRmUvU2ZVTzAwREpsUFB4TXc4UXNSeXVO?=
 =?utf-8?B?N3E5bUJmcGl2aG5vMVNpYW1zeVFJU0xXSmZnL1R2T0RXSHYyTUFQNVdJR3Q1?=
 =?utf-8?B?TEtCbldEaXFhTlFrdnhMdTYrQjVXaldJbDEwMGlsbXNnanR4dW12VGs3NXd2?=
 =?utf-8?B?T000OGpab0JWa0tBTjJSRDZydDc1Z3M5V0cyOTZTOTV2TFZDTDhac1FiNGxV?=
 =?utf-8?B?M1NLS1RyTCs0ZUoydDhZb00xSnhQYzBPaUNJb29WbWZWWExERTJxR2ZwbDBF?=
 =?utf-8?B?WXk3TUNPd2xabHJjbnRHRlJaNXJQeXMwaEViQW9sZC9KNWoxL3FCYXBiUDJq?=
 =?utf-8?B?RzEydnRSejJWb2cwbk45SU52ZFN6ZDBMdVI4WHBOTGl1aXlneGZ2REk2ZFlh?=
 =?utf-8?B?OVhVbzF5R3EyQUNxZ0Q1U0VmT2c0SzRPZWh1Sld5ekQ0S0Vwa0dFYzFxQU1t?=
 =?utf-8?B?eFdwV1A2TUFCNHRzQU8vZEFlSHlwMlV4Q2dHQndIazBEbWVKazNJaVYzV25Z?=
 =?utf-8?B?dVE2dHoySmFtZlFkNTFLNi9vOE9jZTBpeTJnVFpZZ2tYOTE2Y2EvdDZ2T1lT?=
 =?utf-8?B?ekhadEQ2aDZ2THVHYnBST1hMRjg2cHAzU2NGR1lXbmk3ZWE5NkhPWEk4WTlW?=
 =?utf-8?B?UW0xTUtIeFhXVWRSUDByaEZjTDlXalZodEwrSjYzRTd4UFNzdGNZNGVrdTg3?=
 =?utf-8?B?WFNwWHFhYnBRSlc3dlRNNWQ5YkZyQ3FOQitJbFU4U0prS09zdVJ5SWpuNWVn?=
 =?utf-8?B?NjhPSHJQV3g0SGIrU3VpUVNNWnBvTzdIOHhSSzhJSFg1ZzZXdlBLb1ZGOE5Y?=
 =?utf-8?B?a1I1elFKYXNMVmM0RGRoWDFhcCtZcGxITDNaRlJnVnF6M3FVYVhOUWQ3dmpV?=
 =?utf-8?Q?XXK81g6rS+C8tm5O6TaUu8vYMiw8vEltBPfUg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(366013)(1800799021)(376011)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDQxN2FBbVFjaXpKekFsYTVPNkV2cTlHT2ZvVWd5and2Sm11ZkdUQS9oU0xr?=
 =?utf-8?B?SjV2ZFlERkE2a2YvYW9RZXdaaWJraU5CbnpLZEJzMXFVZUJhZmNURG9ZZUx1?=
 =?utf-8?B?djQwc2NxYjZyV1YxSlBSN1NGdVo3d2FZaDBNWTk2ZTZwTW9Rd2YwTllJakYy?=
 =?utf-8?B?bFpvWmkrYXpPMHRWUFZONUFHQnNNZmdmTnphSFJ0N0hWQlpEbFF3S2ZTdDI5?=
 =?utf-8?B?WFA3Qnk1dStGK0JKdllNK1Fab051S1FEOW9Cbnoza2RPaFd6SlFxK0w0bHVw?=
 =?utf-8?B?eFlpdDVKSDN6UkxJQzNjZm9vYzJnZkxLcURMV0M2NUlLaGZaZk9vRWFOOHox?=
 =?utf-8?B?N0N5QjhxZm42bmhQQ2FKUkV4MUh2R3I4TEN2Q3hnUStDcWUzWDBkZVVYdGFx?=
 =?utf-8?B?ZmJSR01WNklhOEovQUFUN3hqZmU2ajk2QVJqT1QvMDVDNzZzeVNyYzljc2d3?=
 =?utf-8?B?Q0toWVVHR3RPMVZ0SXE5MEt1b2wzSW1kbFFIcWZhZVdQNE1WMW9ZOFpjWTNk?=
 =?utf-8?B?NW1Mb3NBcXYwZ2twZmxMYnovdk5XUGlzRXE5ZFhtQkJUSnJCcm8rcmdOUXFp?=
 =?utf-8?B?eWxmS1NRWkd6cXhIdjdSN1EyVHpxUzZIMzRlbytJd1YxNy9EMkFxaXlobXJi?=
 =?utf-8?B?SUxjdzE0amNISVUwVDZIVU4rRnVoaTBudWc4ZzgzSXJXNW5uL2dlV1ZRVGJk?=
 =?utf-8?B?dDVGVmw3c1hDL2tqU01WSjVmTU5pUTdYekdRbXJWUkF4b09PT0J4T1FyNFFh?=
 =?utf-8?B?ZXhhZlpJOHJwZHlMYXFmZTluNXlBcUJXTk56WlhaU1VSR21OUmtRdDhBTlh5?=
 =?utf-8?B?SHR0N0o2ZlFIdEhiNnY1Tkh5Zm5QWThOOXZ0MzUrcHJTRXdWYkFROC9id1lD?=
 =?utf-8?B?aXVHQ0ZWcFJlbXdHL1oxUkk2WFFGM1M0ZzZBbm5BOE9UblVCWFh0Q0FMRkJo?=
 =?utf-8?B?ajh2UFFNRlE2VmowYkw2MGVIOW02OWluYStXTUFSN09JUEppbjNDUlkyd0hB?=
 =?utf-8?B?L3pRY2pPVlRCMjNBcnNBbW84Mkh6RklDVXJzZ3YxYWVTSnZ5L1JSVmoyYkt5?=
 =?utf-8?B?VE5hYWRqWXl0SlF3RmpOc1BEQnp6RUNpYk5tZks2OGRGem15TTJzSE90dDk4?=
 =?utf-8?B?TVFNUXJKTC8xRjM1TnVzd2FYeHBHV1l0OURYR3lBY2EwMk1DdXZsekNPOE9B?=
 =?utf-8?B?MDJKZWJBZndPcVhJbWx6d3VzaWxxQ0R5M2R1WWNpYUp1cFptZkJjZGh4T2Vj?=
 =?utf-8?B?UXJqbnJneTNmSGFSbm9KSDlwcTY1VDIvK1JmaTVoSmg0SVVIa2poQmJjK1lv?=
 =?utf-8?B?Nmh2bmJHbXk2RjdaRHBWRk9xYUxZQWE5eE44NDZrZCt2NGs4VHBMbU1GVUhH?=
 =?utf-8?B?YnJHV29FRzcwTkptQStocm9Pa1JVWnl5S01JWk1XTUt6MGpUQit1cHI5amF4?=
 =?utf-8?B?cEwwS2t5a2xjTDcrNThKclgxSXJSVnV3emxsTVJWdnB4R0N3OFVNWllPdC9L?=
 =?utf-8?B?ZjU2MVB0Q01qbElKYmR4WFRlMGJnU2tWdVFJVnRhT2gzQ2E5NmxPVWcrOTYv?=
 =?utf-8?B?UUE4bFRnb0dGM3crSERtaVhYa2tZUHlzMlZRRlRCM2d6OFViZTJDOEtnbjlu?=
 =?utf-8?B?OERRN2xZdExBRGtDY2dKQ3ZQQXlvUkw4ckh6cUZabGYwQXN5cWdldFczRTMw?=
 =?utf-8?B?aGtUKy90ajhjWVBEWXZWdmV6czFlcCtMMUo1bEhqdUp3VVJNdUpsZWp3RkVG?=
 =?utf-8?B?dm4wanlUTUtabXBjSlhRalhiWjR6Nm5KbDR2TW9jWGE0bGx0ZjBsRFZGVCts?=
 =?utf-8?B?SEEzckw0dW40b0tNSFpDN1BmUUNWUFdMbk1aQzZLclZOM0prNzhzUGxHRDFE?=
 =?utf-8?B?RElIb0VXcklCTlNpTUhyWG1YRGF2RUFJS1J1RTB1NjlzZU1CM2VXa0pYZXMz?=
 =?utf-8?B?NzZDV09rbTNjYkcxZzU5TlBEM2RsWFZxT0ROTDhPaDRrMXJOQUJQTXJ1elc2?=
 =?utf-8?B?Y3Z1QWdTalMvTy9SSkh1R0hPV2tOTTlFV1hIVldIVmQ3OXUvVFdiVGd5aEJs?=
 =?utf-8?B?RWhHek82Q09KSVhxbzA5K2YvWS9iVlF0eEZsQWtLSFBpQjZ5SUphd0lrWHN3?=
 =?utf-8?Q?j5ByNKuw8uwnQdyk9W7r9Fy3L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd753ca-c97e-442e-5c7e-08dc94de47f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 06:15:59.0756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4u9+sFMCO2y9XfCOxX361R42ucGh+TiztTFhyX4idHleZCDkSVTm1IrQq8CuJv+yav+WFoQaTFtfApEhgmLbBx/4QQfOtFVtVSJaUounm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7132
Received-SPF: pass client-ip=2a01:111:f400:feae::71d;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgY21kLCBDZWRyaWMgYW5kIFBldGVyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IGNtZCA8Y2xlbWVudC5tYXRoaWV1ZHJpZi5ldHVAZ21haWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDI1LCAyMDI0IDI6MDcgUE0NCj4gVG86IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAa2FvZC5vcmc+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47DQo+
IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUNCj4g
PHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+
OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBT
dGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1h
cm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+DQo+IENjOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBhc3BlZWQvc29jOiBGaXggcG9zc2libGUg
ZGl2aWRlIGJ5IHplcm8NCj4gDQo+IA0KPiBPbiAyNS8wNi8yMDI0IDA4OjAzLCBDw6lkcmljIExl
IEdvYXRlciB3cm90ZToNCj4gPiBPbiA2LzI1LzI0IDg6MDAgQU0sIGNtZCB3cm90ZToNCj4gPj4g
SGkNCj4gPj4NCj4gPj4gT24gMjUvMDYvMjAyNCAwMzo1MCwgSmFtaW4gTGluIHZpYSB3cm90ZToN
Cj4gPj4+IENvdmVyaXR5IHJlcG9ydHMgYSBwb3NzaWJsZSBESVZJREVfQllfWkVSTyBpc3N1ZSBy
ZWdhcmRpbmcgdGhlDQo+ID4+PiAicmFtX3NpemUiIG9iamVjdCBwcm9wZXJ0eS4gVGhpcyBjYW4g
bm90IGhhcHBlbiBiZWNhdXNlIFJBTSBoYXMNCj4gPj4+IHByZWRlZmluZWQgdmFsaWQgc2l6ZXMg
cGVyIFNvQy4gTmV2ZXJ0aGVsZXNzLCBhZGQgYSB0ZXN0IHRvIGNsb3NlDQo+ID4+PiB0aGUgaXNz
dWUuDQo+ID4+Pg0KPiA+Pj4gRml4ZXM6IENvdmVyaXR5IENJRCAxNTQ3MTEzDQo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IFJl
dmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+IFsgY2xnOiBSZXdy
b3RlIGNvbW1pdA0KPiA+Pj4gbG9nIF0NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUg
R29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gwqAgaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMgfCA2ICsrKysrKw0KPiA+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAu
YyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+ID4+PiBiNjg3NmI0ODYyLi5kMTRh
NDZkZjZmIDEwMDY0NA0KPiA+Pj4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPj4+
ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4+PiBAQCAtMjExLDYgKzIxMSwxMiBA
QCBzdGF0aWMgdm9pZCBhc3BlZWRfcmFtX2NhcGFjaXR5X3dyaXRlKHZvaWQNCj4gPj4+ICpvcGFx
dWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCBkYXRhLA0KPiA+Pj4gwqDCoMKgwqDCoCByYW1fc2l6
ZSA9IG9iamVjdF9wcm9wZXJ0eV9nZXRfdWludChPQkpFQ1QoJnMtPnNkbWMpLA0KPiA+Pj4gInJh
bS1zaXplIiwNCj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2ENCj4gYm9y
dCk7DQo+ID4+PiArwqDCoMKgIGlmICghcmFtX3NpemUpIHsNCj4gPj4+ICvCoMKgwqDCoMKgwqDC
oCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiVzOiByYW1fc2l6ZSBpcyB6ZXJvIizCoCBfX2Z1
bmNfXyk7DQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+Pj4gK8KgwqDCoCB9DQo+
ID4+PiArDQo+ID4+IElmIHdlIGFyZSBzdXJlIHRoYXQgdGhlIGVycm9yIGNhbm5vdCBoYXBwZW4s
IHNob3VsZG4ndCB3ZSBhc3NlcnQNCj4gPj4gaW5zdGVhZD8NCj4gPg0KPiA+IFllcy4gVGhhdCBp
cyB3aGF0IFBldGVyIHN1Z2dlc3RlZC4gVGhpcyBuZWVkcyB0byBiZSBjaGFuZ2VkLg0KPiA+DQpU
aGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCkhvdyBhYm91dCB0aGlzIGNoYW5nZT8N
Cg0KYXNzZXJ0KHJhbV9zaXplID4gMCk7DQoNCklmIHlvdSBhZ3JlZSwgSSB3aWxsIHNlbmQgdjMg
cGF0Y2guDQpUaGFua3MtSmFtaW4NCg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gQy4NCj4g
Pg0KPiBPayBmaW5lLCBJIGRpZG4ndCBzZWUgdGhlIG1lc3NhZ2UsIHNvcnJ5IQ0KPiANCj4gVGhh
bmtzDQo+IA0KPiAgPmNtZA0KPiANCj4gPg0KPiA+DQo+ID4+PiDCoMKgwqDCoMKgIC8qDQo+ID4+
PiDCoMKgwqDCoMKgwqAgKiBFbXVsYXRlIGRkciBjYXBhY2l0eSBoYXJkd2FyZSBiZWhhdmlvci4N
Cj4gPj4+IMKgwqDCoMKgwqDCoCAqIElmIHdyaXRlcyB0aGUgZGF0YSB0byB0aGUgYWRkcmVzcyB3
aGljaCBpcyBiZXlvbmQgdGhlIHJhbQ0KPiA+Pj4gc2l6ZSwNCj4gPg0K

