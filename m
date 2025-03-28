Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D9C3600B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 00:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txxxQ-0002U0-Ot; Thu, 27 Mar 2025 20:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1txxxO-0002TR-00; Thu, 27 Mar 2025 20:52:22 -0400
Received: from mail-sg2apc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:200f::701]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1txxxL-0001VP-DK; Thu, 27 Mar 2025 20:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBclidZTbEZulQXV2UxzbyULQQFL/ZzGdHupiT7oSJDECDuicmdzEaZo/WQMzvbzymtKNeVRtU4SZGyhJZYsMLyoYbUtLTUclrNutcHzNPqNd+NePZ3Bi3RN+BdOKKN71IYKMHOdTLODcrfF0TjG+W/v2rMLjNO9tv9a2/YjQHIyBD7Ex+yn80a9ZwnFmgut7wrmJvupuP5GM+iAw4XjClK1MlC+H2ZCcfCmJpB/M37KgH5BtxBZrzZA1Xh2V6LxJsDHlvUnGdzXoTtA3QeOHan2ywwVqTNMWRBAK0p0zpOJjEytM1g6JjLnxxzEiuY3aesbY4i0t1CirftD4xLuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9W8KKQeiKhilUN+14IB2UHDop5itdM1gfvQVk66kXc=;
 b=wX3izmFQfbNcx2PMinTJdCY3u6qKFE4XTRw7118XunXtjYxcHaFj3/72sP8sKVYleYNz1sAlZExjKQkiLThUT/KW+D3HWETiQNETMzgNPaBOtoBps7apj9/N2pnKdfERY4qQSGYrY4YzH0xgZNta1DeMVDN5mOZZLHwg58l+bcpITJZoO7p8dkuG42pHeXRagsAlF0HOtbG7LEgxiPPKDKZjVXF5DO5D3E13fTMhq7tkhO+/OJ1Y367mcGnJrvA333c4Ewv/L3lqpOApmWyMxfh/I2NQ5g4bi5NDTeZiXVXEsGzZtFPkfA2fAmZK7q5T3WcOTH0YhuOPj2RpqyF7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9W8KKQeiKhilUN+14IB2UHDop5itdM1gfvQVk66kXc=;
 b=YtJ/lTg/ElKGtioqo84uQKrW5zbuNtGDT2w4i5vQtqNRn/p732SnWK2unN3b4IIEVTbCR3aPoXjrx3xGWcUtgNBUNQfYF0cdAoETPJtV9tvMEtTMZ+/CdsE5t7PECnI5gDgh5QrwjwCOGmaNOuoRqgXJollF1ByAqX2Tb6XI65bUmcLG3MrtvWjnrXLr3s8rfaEVZMj+o0y8+A/qyCrPiPj4vLklIn4fQmMiuh7PcuZdngV0LFdt+gzOqFDe0iwxcE8hPOboLKjptlacc1DHpa0Ld5tTXx8C/WVHU/xsK4tTjRM1aeWyFLi5pmXVAaT1LWLBzQtMfpVwPnqCLaobjQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6572.apcprd06.prod.outlook.com (2603:1096:101:184::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 00:52:04 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8534.040; Fri, 28 Mar 2025
 00:52:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>
Subject: RE: [PATCH v1 1/1] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Thread-Topic: [PATCH v1 1/1] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Thread-Index: AQHbnuwSAcGQ8Pb5QUCOqSFIOPh+dLOG9wKAgADCBGA=
Date: Fri, 28 Mar 2025 00:52:04 +0000
Message-ID: <SI2PR06MB50417BEBC4B76A3293EF9DEEFCA02@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250327074419.563306-1-jamin_lin@aspeedtech.com>
 <2a0225c6-09c6-41b0-b279-fa7cf0cd6d9d@kaod.org>
In-Reply-To: <2a0225c6-09c6-41b0-b279-fa7cf0cd6d9d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6572:EE_
x-ms-office365-filtering-correlation-id: 0f911497-3cbb-4ed9-3900-08dd6d92c1da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QktGZ2dUTm9LRlJUMjFkVW82L3ZHOWNOY1BpM0FXaUk0bnR0OWZNcUdub0VU?=
 =?utf-8?B?eHMyYkZJaDZZVXdCc21GTTdRcDBoOGJoVFNRQ2g4YW15U3lVb3hEcnk1N1Jo?=
 =?utf-8?B?TU8vaUY0K3p6ajVxNjg0M3loQk8vM095d1VnQ0RrZWUvdlNDWkJyaDMxWDcy?=
 =?utf-8?B?dEtzQ3kwYjNQZEV2RlZqcVcvOXVHQmFWTGdFb3krOVZPWlpNSzAwR1BubjFa?=
 =?utf-8?B?QVR5bHZaS05XUjlERWxVL2FxSU40LzJERWFsSk5rdnVXUTBRMkRqWFNsWTQv?=
 =?utf-8?B?MGZLTW80ZlMvM2R5S2lvK0x4TVNWaGxQQnRFbXVTa3p2czg2YnJrMHZ3cHQ2?=
 =?utf-8?B?Vkd1V0xyYUJkaitGdGdDTmFuMlpJZ05pYkpRSWd2akxiNkF4TWxTTHN2ODdC?=
 =?utf-8?B?bFNBOGg2cTR2RSsvL3EwS2VOdTVtdk9yY1UvVndrTFB2NEZqRUQ4YURJbzc2?=
 =?utf-8?B?eThsWjJITHlrT0pFckRyWEtueHluWlRSWFRQT3BaSVk0VytNcmVUTWx0YUZS?=
 =?utf-8?B?WWNHSmRuNG45MFFrcm0zZUhLdm1rWFp4MTdZQ2lkaHZkTWxlTkFJZGVyV2Z4?=
 =?utf-8?B?QktQVGdxRVVINUlmMG1BT2s4Q1ZaT1JwRXVlZXJlOHJQT3JPSXRlVUJGTTlG?=
 =?utf-8?B?VlU5YkpFQnQwMlduOEI3NXVTSEdSOWgzamtuTGRtSm9OUGJjTWxwS2dyRXlh?=
 =?utf-8?B?ZWlSU2F0Sy9FemtMbUhGUm9xVWdGbEYwK3hVeWZldnp4bCtZeVVKWUExajRO?=
 =?utf-8?B?a0ozVDZ5a0VRaTgvdGEyUjhhSFVmcktxOStDOFU2Ykpockc5UU1sRG9NSVNt?=
 =?utf-8?B?U2xER0YrUmtsU3ZNN0dXLzRFejREeGRZUWVXR05XRThWM2tZeWwxSzQzNy9H?=
 =?utf-8?B?aUZmM3NwZ1B5NWozNXFadnpOeXhDbDQ2TStqeUVNY2dqUGxKenJNdDhOUnk1?=
 =?utf-8?B?ZnJWcjd1V1VqYVl5djdNTDZFZFM5ZjA4OXlvTnkxYXVIWjdqQzMrZXJ6QjU1?=
 =?utf-8?B?U0FYTnI1V2lKWmxueHREKytWNnFnZXVNZVlQYlkxWWExRUFNTmxLNUVhZHlq?=
 =?utf-8?B?VFpyVGVpcTduWGhMNFNKMC9EL2hWRUx2cmovOUtvQVFFbUY0YjF5eEllcHBG?=
 =?utf-8?B?TjhQUTRMKzcwMVJoV3BuUEtXdnU5VUV5YWtHOEQ3SWdrVkNTSlpiZEpGNVpy?=
 =?utf-8?B?R0hIcUg5bEFuNmFIWmgvZWNMVVJPZmE0Ym82Z0NtUXZIdndEa2M0eVNaeU9T?=
 =?utf-8?B?V3ZHUjA1TGRpVTNMMysrYksrY21BTXc5andGcndUdnBlaEJQS1VZSWFkZW1D?=
 =?utf-8?B?NVZFNGo4Vlk0S0RhSVZhbHdsNXVUS3NMdFNyN2ZGTkhCeDB2ZlpqV1R3MlNB?=
 =?utf-8?B?b0xUUE5ueE1CWDVKY2gvd1V5MjA3dHZZR0c5VHY5R2R2QlM1MXZwMTIvQUh6?=
 =?utf-8?B?YTFiaE54MGppUGhFR3VGRk01NHprcTRmdkxtYlI3cVcxTkRJNm1Id29vbWNw?=
 =?utf-8?B?OFAwTEFvR1JwajlZR25IWW45bDlWeDFIZWowVGRoTnNtY3A4dEdvZklaNU4z?=
 =?utf-8?B?ejJsSnpGbmI5WWxlR1BSaFlsYTl5V1VaeHZxQkwrUFJycVZwNHU3ZjVmT1R1?=
 =?utf-8?B?WSthL0VZM1Q5Nm5TVzdQZCt0RE0vUzh4UXBldCtRcUtqZXNraFJKVzB4V3JP?=
 =?utf-8?B?dEpLSURvcXR6ZkU2VHBldk1nZ1UxL0Nzak10TnNZTUFKVmNzckFscUdwNWVu?=
 =?utf-8?B?aTVVM0ZhdmpxLzd5cW5BSGVXa2xoWWhSMXlYNVRaRlEzdWtkZGdMTTJONnRp?=
 =?utf-8?B?bFN3WDl4WFcvVVc1SmVVR21mdHRWUDlPbm81MVhHVjVpeHR1VE40MmhvUE1v?=
 =?utf-8?B?aUNYa1BCdkE5NDBFZnFybVFGV1BGa21TakhLdDhSeHJCT1E5NS9YUTNyVzBP?=
 =?utf-8?Q?9WUDKfrzoGJ6jOOgJup1G5Au/CzWiOs7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJrS3NXdHBUd1BjdXA0K0ZiYWlSaGlEcEsyWDVrMFgvbStPNUtNK3U4cEVw?=
 =?utf-8?B?NzR6MWVqV0lCUVBmWXNjMFhFbmdZVmxZcVFTclN6TmIveVM2SkZqU2pvazlk?=
 =?utf-8?B?aVp5b2NoTG1BUktBV1ZYUFNQRkJwRmZyVXZJbjE5dXdJczRvaUxtRlEzS1hs?=
 =?utf-8?B?VEdhK2FKZHJPN3JtMkpRczg2dndkelNwS2hKbTNXTVdDdFh3OHdMOEVaYmlU?=
 =?utf-8?B?UzZiL2NzVmxzU2xXckxQZkIvUG53RzkrejNkKzB5c216RjJkM2taeWFEUm80?=
 =?utf-8?B?b1JiVnlsSldTNkRGdzl3WW95cTZacU9Oa3FEeUIwemxxdkoyU2h4dWZrUTZt?=
 =?utf-8?B?Mk80ZjZYc2ZObmF6NFduSHg0NWN3Y25Yc0VpS3VPQXVoMUF6ZHlyMXZ1VUx4?=
 =?utf-8?B?U2c3RndMaXRad1lhUW1xYlphajNsYXd3ZWRsSVdiYWpTVmVaOHRKSkwzTG5k?=
 =?utf-8?B?ckxSeVhwMFZVWWFyZWI3TVhsNGNVekhIcW5SVWh5aUtqZ0ZQRzBLUUdDd0dP?=
 =?utf-8?B?NHdUZDlmbStHQ0M3Mk9qYU1DMU93aUdneUpiK0F6dDRyMDFuV3VaUThYREkx?=
 =?utf-8?B?bUwzclh5amo5akc1WDFDYW05aGtqUjBGM01iYmxZdFVSMDIvWlgzaC9teml6?=
 =?utf-8?B?SzNWWTJmSk5sREthWDd0MWFndHZTLzdIeU1kSGhmTURtOU9JVk1BUEdQZGQr?=
 =?utf-8?B?dDFQWXFkcjFzbElPNTd2amhCN0R2YTlCSUNPTnl5RmhVNGUvNGx1elMrdFI3?=
 =?utf-8?B?SkpKZmhsZHBJc2FXUXVwQ0lrcnVjQzEycUpWcWVCbHpWcjJTUXVKWWoxaVYr?=
 =?utf-8?B?TjIrQ0FQUFJtb3FiSXpYc0xoY0VmZUZRUHM2b05pa3YrZEVDcGkrcnZMVEY3?=
 =?utf-8?B?Z3NnNllyaGxtYXVIYkp5UCtsd1pFSkk0YlM0MEFJQTNiREVrZnE3cVB5b2Jt?=
 =?utf-8?B?ai9DbE9FYk1zN1JqZnA4NUh1T29CZHJpWUpCT1BQT1hpSlVvbGpvLzc0d1B5?=
 =?utf-8?B?bytreVUxTUZBT1ZWQ3J6QXk2SVZZNWJmM1o3RTdaVnR0QTBFejdGL08wYmUy?=
 =?utf-8?B?aTdVaG5acFRBalEyOVlGRlRYSWYwMHgvTWlxOUdKbFBnNnVmamk3WTg1dGtB?=
 =?utf-8?B?Z1gyM2J4czJwcVozdWlLM1JGMGlKVHNzc2pUR09yMW90bTE3ZzhQaG5VQ0FE?=
 =?utf-8?B?dlIvWFRVcXdUMUNSaVhGOERCb1RuYkJNeEFTdW1xUFBENTgwOHZ0Y2dnTHhO?=
 =?utf-8?B?UHhaSnBpV1hjWk5yZnNtL0Y1K0UzdHNOL2F6MkMxbVhlVEhmTGZLRFJKRmxH?=
 =?utf-8?B?WFIweFkwdy8rQnFMSjVETmhXbHNPejhLaThJKzlUN1VYcUlmNGJRVWVTZldw?=
 =?utf-8?B?TDJVL2x3dHpCakduOWZ3dmtGZ2RSaXk2bzJtdW42Y0dNdEgrZmo3bXdUVWVz?=
 =?utf-8?B?U1VmNkN0TjV5MzJ0Q2h6YWFSSms5NVk3U2NjNjB2d0tiamVGWnRBOXg1QWxv?=
 =?utf-8?B?NjZNcnR0dGtQcnVobWhaRXNUeHpuaGRMWXdQaElIV05vYlVJeWdoMjZvK3VU?=
 =?utf-8?B?SmJ3V2psMFMrUDUyVE01dCtNcERxOFB4NTlOSHh3RFRxM2pQU01adUFYWnRI?=
 =?utf-8?B?dnZac1BMbytvNk05dTUwQjRVSUZjQUs4SU9iQ20rZ0liaTRiSUswWW5LTHFp?=
 =?utf-8?B?YzRZTGZqUDNlNVJxeER5aWtPOFRBL0JJWHkzWnNQSmQ5U1BGN3V1MHRtUzlz?=
 =?utf-8?B?UGVwMy81UlNLOVRUNTF1dTFsenZnRzErWlVDRi9vS29wWTc1S0l6UHhUZk9C?=
 =?utf-8?B?UEtPRUZuSkVodGRYTHhLSkR5cVEzdklIbjdhL0d3NXlYclZlNWxaSkNmbHVi?=
 =?utf-8?B?OG5MbUtrdW1YOFZqTGVuUnA5KzlKVFAwemRNbkhhZzdVUlFncTBWc0hxRnJz?=
 =?utf-8?B?ajZmVjk5M1NESE9xR01BeDNQd29YT3JrR29YV0hraE9Md3dDNzI1U3F2dGll?=
 =?utf-8?B?em9hTkplc0J1c3RLQzFHL1dnajA4WGtpbE1JVWVRZnkrSmJFTGFCdEZBVXF5?=
 =?utf-8?B?REU3R0dYZHNWUzIvS3QzTURHQWtmdGFvcXNqdGNDTDNHNHFOb09IMTkzOWhz?=
 =?utf-8?Q?cTngLcDABCbrRY8COt+cgnLa8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f911497-3cbb-4ed9-3900-08dd6d92c1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 00:52:04.1365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLf+jfdckDBYyEc/+sdByH5CQPRP7ta0Om8/Jgh8AtI/AbaVbMAu7iM4tQQ/4OiFFM0s1pbSPe+68OjYqqglfaLRbse7nz+jzYxWbLiU0Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6572
Received-SPF: pass client-ip=2a01:111:f403:200f::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLCANCg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsg
bG9uZ3psMkBsZW5vdm8uY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBody9pMmMv
YXNwZWVkOiBGaXggd3JvbmcgSTJDQ19ETUFfTEVOIHdoZW4NCj4gSTJDTV9ETUFfVFgvUlhfQURE
UiBzZXQgZmlyc3QNCj4gDQo+IEhlbGxvIEphbWluDQo+IA0KPiBPbiAzLzI3LzI1IDA4OjQ0LCBK
YW1pbiBMaW4gd3JvdGU6DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiwgdGhlIEkyQyBtb2Rl
bCB3b3VsZCB1cGRhdGUgSTJDQ19ETUFfTEVOICgweDU0KQ0KPiA+IGJhc2VkIG9uIHRoZSB2YWx1
ZSBvZiBJMkNNX0RNQV9MRU4gKDB4MUMpIHdoZW4gdGhlIGZpcm13YXJlIHNldCBlaXRoZXINCj4g
PiBJMkNNX0RNQV9UWF9BRERSDQo+ID4gKDB4MzApIG9yIEkyQ01fRE1BX1JYX0FERFIgKDB4MzQp
LiBIb3dldmVyLCB0aGlzIG9ubHkgd29ya2VkIGNvcnJlY3RseQ0KPiA+IGlmIHRoZSBmaXJtd2Fy
ZSBzZXQgSTJDTV9ETUFfTEVOIGJlZm9yZSBzZXR0aW5nIEkyQ01fRE1BX1RYX0FERFIgb3INCj4g
STJDTV9ETUFfUlhfQUREUi4NCj4gPg0KPiA+IElmIHRoZSBmaXJtd2FyZSBpbnN0ZWFkIHNldCBJ
MkNNX0RNQV9UWF9BRERSIG9yIEkyQ01fRE1BX1JYX0FERFINCj4gPiBiZWZvcmUgc2V0dGluZyBJ
MkNNX0RNQV9MRU4sIHRoZSB2YWx1ZSB3cml0dGVuIHRvIEkyQ0NfRE1BX0xFTiB3b3VsZA0KPiBi
ZSBpbmNvcnJlY3QuDQo+ID4NCj4gPiBUbyBmaXggdGhpcyBpc3N1ZSwgdGhlIG1vZGVsIHNob3Vs
ZCBiZSB1cGRhdGVkIHRvIHNldCBJMkNDX0RNQV9MRU4NCj4gPiB3aGVuIHRoZSBmaXJtd2FyZSB3
cml0ZXMgdG8gdGhlIEkyQ01fRE1BX0xFTiByZWdpc3RlciwgcmF0aGVyIHRoYW4NCj4gPiB3aGVu
IGl0IHdyaXRlcyB0byB0aGUgSTJDTV9ETUFfUlhfQUREUiBhbmQgSTJDTV9ETUFfVFhfQUREUg0K
PiByZWdpc3RlcnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBGaXhlczogYmEyY2NjZCAoYXNwZWVkOiBpMmM6IEFkZCBu
ZXcgbW9kZSBzdXBwb3J0KQ0KPiA+IENoYW5nZS1JZDogSWJiNDAzOTc3M2E4OGJhNGYyZWJkYTdm
MWFiNWI1ZjllOTlkMjI0NTYNCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhpcyBpcyBicmVha2luZyB0
aGUgZnVuY3Rpb25hbCB0ZXN0LiBDb3VsZCB5b3UgY2hlY2sgcGxlYXNlID8NCj4gDQoNClRoYW5r
cyBmb3IgcmV2aWV3Lg0KV2lsbCBjaGVjayBmdW5jdGlvbmFsIHRlc3QgaXNzdWUNCg0KSmFtaW4N
Cg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIGh3
L2kyYy9hc3BlZWRfaTJjLmMgfCAxMCArKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L2kyYy9hc3BlZWRfaTJjLmMgYi9ody9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+ID4gYThmYmI5
ZjQ0YS4uYzY4YjhhNWVjMCAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+
ID4gKysrIGIvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+IEBAIC02NTYsOCArNjU2LDYgQEAgc3Rh
dGljIHZvaWQNCj4gYXNwZWVkX2kyY19idXNfbmV3X3dyaXRlKEFzcGVlZEkyQ0J1cyAqYnVzLCBo
d2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgICAgICBidXMtPmRtYV9kcmFtX29mZnNldCA9DQo+ID4g
ICAgICAgICAgICAgICBkZXBvc2l0NjQoYnVzLT5kbWFfZHJhbV9vZmZzZXQsIDAsIDMyLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIEZJRUxEX0VYMzIodmFsdWUsIEkyQ01fRE1BX1RYX0FE
RFIsDQo+IEFERFIpKTsNCj4gPiAtICAgICAgICBidXMtPnJlZ3NbUl9JMkNDX0RNQV9MRU5dID0g
QVJSQVlfRklFTERfRVgzMihidXMtPnJlZ3MsDQo+IEkyQ01fRE1BX0xFTiwNCj4gPiAtDQo+IFRY
X0JVRl9MRU4pICsgMTsNCj4gPiAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgY2FzZSBBX0ky
Q01fRE1BX1JYX0FERFI6DQo+ID4gICAgICAgICAgIGJ1cy0+cmVnc1tSX0kyQ01fRE1BX1JYX0FE
RFJdID0gRklFTERfRVgzMih2YWx1ZSwNCj4gPiBJMkNNX0RNQV9SWF9BRERSLCBAQCAtNjY1LDgg
KzY2Myw2IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9pMmNfYnVzX25ld193cml0ZShBc3BlZWRJ
MkNCdXMgKmJ1cywgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgICAgICAgYnVzLT5kbWFfZHJhbV9v
ZmZzZXQgPQ0KPiA+ICAgICAgICAgICAgICAgZGVwb3NpdDY0KGJ1cy0+ZG1hX2RyYW1fb2Zmc2V0
LCAwLCAzMiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBGSUVMRF9FWDMyKHZhbHVlLCBJ
MkNNX0RNQV9SWF9BRERSLA0KPiBBRERSKSk7DQo+ID4gLSAgICAgICAgYnVzLT5yZWdzW1JfSTJD
Q19ETUFfTEVOXSA9IEFSUkFZX0ZJRUxEX0VYMzIoYnVzLT5yZWdzLA0KPiBJMkNNX0RNQV9MRU4s
DQo+ID4gLQ0KPiBSWF9CVUZfTEVOKSArIDE7DQo+ID4gICAgICAgICAgIGJyZWFrOw0KPiA+ICAg
ICAgIGNhc2UgQV9JMkNNX0RNQV9MRU46DQo+ID4gICAgICAgICAgIHcxdCA9IEZJRUxEX0VYMzIo
dmFsdWUsIEkyQ01fRE1BX0xFTiwgUlhfQlVGX0xFTl9XMVQpDQo+IHx8IEBADQo+ID4gLTY3OSwx
MCArNjc1LDE2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNfYnVzX25ld193cml0ZShBc3BlZWRJ
MkNCdXMNCj4gKmJ1cywgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgICAgICAgaWYgKEZJRUxEX0VY
MzIodmFsdWUsIEkyQ01fRE1BX0xFTiwgUlhfQlVGX0xFTl9XMVQpKSB7DQo+ID4gICAgICAgICAg
ICAgICBBUlJBWV9GSUVMRF9EUDMyKGJ1cy0+cmVncywgSTJDTV9ETUFfTEVOLA0KPiBSWF9CVUZf
TEVOLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGSUVMRF9FWDMyKHZhbHVl
LCBJMkNNX0RNQV9MRU4sDQo+ID4gUlhfQlVGX0xFTikpOw0KPiA+ICsgICAgICAgICAgICBidXMt
PnJlZ3NbUl9JMkNDX0RNQV9MRU5dID0NCj4gQVJSQVlfRklFTERfRVgzMihidXMtPnJlZ3MsDQo+
ID4gKw0KPiBJMkNNX0RNQV9MRU4sDQo+ID4gKw0KPiBSWF9CVUZfTEVOKQ0KPiA+ICsgKyAxOw0K
PiA+ICAgICAgICAgICB9DQo+ID4gICAgICAgICAgIGlmIChGSUVMRF9FWDMyKHZhbHVlLCBJMkNN
X0RNQV9MRU4sIFRYX0JVRl9MRU5fVzFUKSkgew0KPiA+ICAgICAgICAgICAgICAgQVJSQVlfRklF
TERfRFAzMihidXMtPnJlZ3MsIEkyQ01fRE1BX0xFTiwNCj4gVFhfQlVGX0xFTiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRklFTERfRVgzMih2YWx1ZSwgSTJDTV9ETUFfTEVO
LA0KPiA+IFRYX0JVRl9MRU4pKTsNCj4gPiArICAgICAgICAgICAgYnVzLT5yZWdzW1JfSTJDQ19E
TUFfTEVOXSA9DQo+IEFSUkFZX0ZJRUxEX0VYMzIoYnVzLT5yZWdzLA0KPiA+ICsNCj4gSTJDTV9E
TUFfTEVOLA0KPiA+ICsNCj4gVFhfQlVGX0xFTikNCj4gPiArICsgMTsNCj4gPiAgICAgICAgICAg
fQ0KPiA+ICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICBjYXNlIEFfSTJDTV9ETUFfTEVOX1NU
UzoNCg0K

