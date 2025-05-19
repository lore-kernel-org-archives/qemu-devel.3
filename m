Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84348C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGvoy-0003xq-6v; Mon, 19 May 2025 04:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uGvoo-0003vV-2K; Mon, 19 May 2025 04:25:55 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uGvok-0002v9-JP; Mon, 19 May 2025 04:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWTxmeIXSpiSUeDZc05X3Olia+YMillsxMUqPaglG4Kgkc3QnrK+CdHgFSBo593jZRTIBIQ4BnEs6liAZ6GYiRESKers8Lyh64R7TGzi5AaDrpp4DSGGNeP9c1NarFbG1IYEcGu5FIG31lxnaOm6pDadpWrYRDWmgBptu2WOUsCWfua/Yu+ZLZHp8FB1bVoksxboRTtBafbtiVKun+TNHAmo1qJ9QBT+1sgsSmHkuOexmvCBBKiFNTADFCEchiQ+Ui6Xj6+PuE49FFMS3/THLCQcDSssuuPC7vM1gXnK1typ90/bgCQHPHb/xuSamb/9fTD5s2OIw3SA2tCXFx/ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhHOM0pMtDA76cDo7RKi1V1MQ4/d0TM45MOduKEz5OY=;
 b=R3kidZ5N+zQhrjj+ux3a1znZCmqZQlMXakbfXfbtJaOCRcQCjteaI36G9N2d7eL8GU90VinCaR+v49w8/h/3nqUvJvi3MTfIECnmnFtSKQV2YGR66bsMDvmwpu2C0/o6WFmnAUmUBLb7zFA0Q1OecZbCq7LF8pLIarkMImgbq9gm/W1zPvePeGPrpVr6v3SIAdVFymzSP7fzp7P020vIi3dd0xfShlayFwQKDWxVee0gpwL/SJsfF8F+28IInHMRp1jYaB+iSL+pdI7rT1WBp035Z14RXYmbgUyUkUF4hjefP3LsgAfWVklLOqIZAeGZXL7f6eHJS5NXCMn0gVTExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhHOM0pMtDA76cDo7RKi1V1MQ4/d0TM45MOduKEz5OY=;
 b=LHteuDJS16PVBLcaMskBKo3IODvMhzIzwj4N5RfJdLhorZXkf4whb5Aqnsad9+Op2BD9XryXvP17WdDGVls/xX5GZRSkQGxJ6PtQf4yaxi6NOehmeHULehi7k+0rA+DbtaQR+W/uCAl07aiZmXmrmvAXOw3omgBh/rP5TLOPkc2i01N2qSvLAsbHRj/lYnpLD2SGtCnGmY9Y4dQw9ahDO74y2e3MuHyEGh6Eg4xrvOAExuVuJ3XcO50F6n49mXzDc1B98hOnqPk53teqvH/Suo6hSHfTDacx72zn5ozpNkSs3N57nAjw9mKj2bDo8pTSXQnwhIu9vP8he6CA8Tvq1A==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SI2PR06MB5172.apcprd06.prod.outlook.com
 (2603:1096:4:1bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 08:25:36 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:25:35 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 2/5] hw/arm/aspeed_ast27x0: Fix unimplemented region
 overlap with vbootrom
Thread-Topic: [PATCH v2 2/5] hw/arm/aspeed_ast27x0: Fix unimplemented region
 overlap with vbootrom
Thread-Index: AQHbxK8iOcEwevI8KECiwbp6ei27nrPSHpWAgADyNvCABpKr8A==
Date: Mon, 19 May 2025 08:25:35 +0000
Message-ID: <KL1PR0601MB41801853073F4669B45BA1D0859CA@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-3-steven_lee@aspeedtech.com>
 <395b5586-67f9-48db-9830-c4ace0b85e47@redhat.com>
 <KL1PR0601MB4180A20D466DFAA909A8425F8590A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR0601MB4180A20D466DFAA909A8425F8590A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SI2PR06MB5172:EE_
x-ms-office365-filtering-correlation-id: 242605d2-d022-429b-b231-08dd96aebacd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXl2OWFGcHlFcitsampPUm0ydXZHVG1wOFVwNXBDbm55VkwvL3pRdUo5cXQ1?=
 =?utf-8?B?VTJYNHJ5YS9hUEpkaW4wcUhzOUVkNnJjeWZWQzBSUDBmYy9jZ3dlQzFDRjhY?=
 =?utf-8?B?Z0hrOUx1RDVMR0xMTk9kWG5NNGZVWk9xWk1wUmMvQWVGQVY2VnpVV1o5dnVt?=
 =?utf-8?B?VTM3OXU5d3J6TDJTV0daOXVXeWhzODBaQ3ZuTWszYm9ZTG0wUTZCU2lySHJv?=
 =?utf-8?B?Nk9yZEUya0x1Q1RiTW1sbU03SUgxb2ttL0tJblZNS05aQklkYkFMUGFJWG9j?=
 =?utf-8?B?WG5FTHZLWUpEcVUrUTVlSndjVGZTNWRqY29NQi9lUHIxaWd0eERLN0orSlg5?=
 =?utf-8?B?VzQwa2UxdkRlQ0Y1M0s3OFdtc21EZkw2RU9Xd3JySU5VMnZqLzAycXpRczUy?=
 =?utf-8?B?SlMrR25XRlZhbVNuQ2RSZnVabUkyZnJTbWZ4Ym1lN0xQVU0yTTg5UU4zbFhQ?=
 =?utf-8?B?dW1yYWIvQmNXblZCd1dIeVJwRUFodzNuUm1ydUYveDVyKzFKNmNvTXc1TC90?=
 =?utf-8?B?TnFxd3ZMSFY5UXJnY2pEYlZiK2g0Zjh3ZVIydUsvcjBkSWt1NjVsVWpQdHpK?=
 =?utf-8?B?ank0OGlSZGN6R3dwdWIvZFI3WS9TQUFZRG40clFicmRtSVZKY3cvOTJSSTVN?=
 =?utf-8?B?bmFHZ0FHVUh0bFNjdWFWcEJqVCtPWitSMGFNdUZqRi8yRFVvaVJIRWNia1pQ?=
 =?utf-8?B?dk9Ea3BXSVZnOVFSZ1g3UGVvbEl4ekx4eS9sODB1RW9jMDA5ZjlDOWNBOTRP?=
 =?utf-8?B?T2FHakVjS1ROblJwR2hlLzUycHRsd0ZBV2tUeXBOWGc4dW95VkUzQldWUStX?=
 =?utf-8?B?bVg0V2l4T3dXMjRXMnlHSk10M0puVmpjaDhjVDhJN1RZb0FTazR2WTV5SXF1?=
 =?utf-8?B?c0ZtSHA3R0VKVkJETWQ2WEE5RDNOUjF5RmRnWjdSMzBPbGJiRFduZHdCdUZ3?=
 =?utf-8?B?aVEyY2pHSVBTRVNXUk9zOE9NVThqRzhBRk5pU0JSUW5EWVRnSHBPOTdtbHhv?=
 =?utf-8?B?WXJOVUdFZ0lPS1hEbElGRUhnK1YrQUhqVDZUTGVTRElCYy81QlRBYU4xNS96?=
 =?utf-8?B?UW1XaUFKTU1ZVzBVdU5abkJJcVFjMFRoaUd3SnFnU3dqSHl5T3d0YlRpYjlv?=
 =?utf-8?B?R1VBWm14ZVZGejdrZGpiem1YQ0Q2RmZDZ1FwTU9ES0JKZE9MeGJUandIU21p?=
 =?utf-8?B?dVByY1V5RWRQSjZQRjJ0SU41YmRpMFpVQzF0TWV5NU5aN1Z0NWNiT1UybnNj?=
 =?utf-8?B?b0FFRjgya2QwdmpNSmhpRGpSKzMvYVpOa1lnTko2NDJtU2dwNXNoMzN1ZGVq?=
 =?utf-8?B?dHpuUklCQWFYTzNnNFEwZnkwYVpMZ1lNbFJQSE5jYkhBUitackFpaW5GYlJI?=
 =?utf-8?B?dmpzY2VFdHg0aEVzVVluZytuVjZtakVSQldkZjhMQjdURE5hQUZjbE02Zkhn?=
 =?utf-8?B?OXJib0dRdittaWNId0dCSUI0Qk1YOUZIelIzTjVPNGJHTmRaSGxNenpZRS9B?=
 =?utf-8?B?VVdqUkNEcHhFSVUweGRxRU0yQWl3VUJzYkJMcTlKYTVZWVpKbTBaam5MYW5B?=
 =?utf-8?B?YjJJcmxhT0Jha0ZyQkpXQkJZcmRJV1hhbDJ6cllZNDYxWUZwRCtQSjlITXRs?=
 =?utf-8?B?L2IwRG0vMmdxMkIvZ0Z6UENpb3pKLzBPRVpqRjU2SUk2c04wUGNqUkp4TkZW?=
 =?utf-8?B?UWRpbjBJV0ZmVEx6NEhPNXlxTnczNE9YS2E2SWRKYVVvRFA2MDdWRGZuM3h6?=
 =?utf-8?B?MGFJbnpmekRmSi84RW1adFpLaXlQLzNXSVNBRnl0WmFyc09zOHViTEZLbzEw?=
 =?utf-8?B?cHBsZHZQcVhiM0N0Vko2YXpMRURsaGZ4eUFDeHVSVVRGaXVXRXRQcjNpbGMr?=
 =?utf-8?B?YnVCNG9Tc1NQVnlaZWhEZFB1OU1IMW4xOUFFVmhTaGNSdVh6c0FoV1hjNlVL?=
 =?utf-8?B?QlRyblRNSG5UVGxmdUxmUEZjUjZzQitPNWJ0ejNuQ3hFTzJRdDJHaGQ0M0tL?=
 =?utf-8?B?VEJiMHdNU0Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGhDbmJVdnlIVVRTdW54c2ZacDRGT3dxTkJJa0tqS3ZScGk5aWhZVGptTWJF?=
 =?utf-8?B?bEdkcEF3S1lKbW0vTmdaTnRHME8rbnRKOTRGaW1sYXlVVkVVSitkdFNlTXE2?=
 =?utf-8?B?THE1dGRybi9jWCt6THY5Rm0ya2pDWG05SC9IdlRlVklrUUVjYU5uVkEvck1Y?=
 =?utf-8?B?VS9YZWRNeFkyNnNTK3A5bExLZTM5Ym5wQXN3RzRZYjA1VzNCRGkveG1XZGJm?=
 =?utf-8?B?clAyb0VNY2VGNDNXdGVoQUQraWVNU2V4Z1ExdjV6TWQ1VkRRb0dKcUpBa3o3?=
 =?utf-8?B?cndJWTFzRTFPNFYvZjNub1pVU25zc21Ec1FsRk4zOVJyRkZCTU5oQUtMWVhP?=
 =?utf-8?B?NnNPSWZTOGxjcVlub1Myc2RUaVpyaGdyOXJObWVHQ2dSQ0x0QWpQemlvQkJK?=
 =?utf-8?B?d0xhMXdBMjVHOTMxY2o4QWhwM3RiSUZqNWdCRHJwZERncVJCRTMrNU5mOUpD?=
 =?utf-8?B?Vk1pTUMvNFVaSFYvOGRIb25JVytNQ0EwUCtNZkZzbUlQNnhLWnF6aVQwOVRy?=
 =?utf-8?B?ZVVwVzFJdmp3UjhDeWszQ1NGZ01zdGx2eHRaTHdPeEhERzdDRXJOS3pZQU9q?=
 =?utf-8?B?dkNHUEx6Y0wzdXpNc2RYUnlyNEtSUnQvZGpSbHVwM0lvaW1acjJqSVl5ZVVF?=
 =?utf-8?B?REVHZjNCTXBhbitseDJTOGJHdHNqUjFLemtSWXRkV2JKRGpFcDhSdGRmMlMz?=
 =?utf-8?B?dUxvbk1tUWhKZ0JJZzdaKzVWQkhDZGtQMEFjei9lYzYyNFExR1dxUFhGOHl2?=
 =?utf-8?B?L1hPdGRCWHBoUWJVQ2N0d2N6Sm0xT0ZnUUhXdTErSWhka2tvR01QcW9hUlpL?=
 =?utf-8?B?Y1VLN1ZuTTlnNWFTdGIvcHBoTkFyOFNRbE9xbm9DQzRYYjV6aU5wZTFMdktk?=
 =?utf-8?B?UVRYRjhUWFgzMUx2cGQ2NlBBSU5aWHpxclo1WDAzSkZxaTJ1U1JpaCsyRzZr?=
 =?utf-8?B?Q0dUZkcyanFtKzBQUkxSaHlwSGI3UGtMUmhzeUhiOEhURVJWVzVFUUpFUndq?=
 =?utf-8?B?V2ZVbTFaK21ENkUvSm1SK1BvNG5VTFpIV3NxZXhHTTJOeDJjWHJlY1FWZFFs?=
 =?utf-8?B?dkRoaVVsU0N0WEVIOWErTlplUjN2bkdERkZvU3htTjJ4eEhLRzJwNkF1bVFX?=
 =?utf-8?B?WUx0K3VOREk2dmJpTUx4dHBia1VhazgwckpaOVhmKy94ODBsS0dLbjIzUlph?=
 =?utf-8?B?WWZUczJFYXZySC9zTmEwbGdlR3lPaDVKbndwV2xGMUc3ZUZ2TGRJbE9MUmJG?=
 =?utf-8?B?eEZWS3hDczhRcGE1bitVbVJKT0V4Unptc2tqRHZrRWpzUExUYkUrS1BiVnVG?=
 =?utf-8?B?TkhscnhYbDZwa2NlS0lQNjc4a0lmTEtPOU1QM0MyM3hkeWtoNHdIM3VFSWhD?=
 =?utf-8?B?Rk81Q3V0b2pack8vNXhscmR2bnpvblBGcTU3blpFRzY3S1FJQXJsTVNFUXNV?=
 =?utf-8?B?YlNObDJhSjBLOXhJaEsrdVNFL0pIcnJCaDZESjhSMXVYRE9iU2phOHZvZTE0?=
 =?utf-8?B?VDdPL1FYYk42Y3BjTjllcDVZZi8xK2ZFdFBBcDUzdG1wRUVHQVdyL1N2SEl4?=
 =?utf-8?B?WERReTROZVpEajdrVklUQzdLcGJsSW9pNDJvbGY4SjNwOFZnclFiSFJNOTB5?=
 =?utf-8?B?aDBTc2xxL2dhVllwSFFaTzlTaWNvV2lROTVXV2V3Y1psNDZzaEx5ME4rQXNr?=
 =?utf-8?B?TzFrdUlUWG04MFpic0JDUFFmQTJzZ2FlaHlVSCtqWk11YjZ6YjlMOGlhbFZr?=
 =?utf-8?B?WlI5QjdPQ1hYMEdwZ3NKR3M1eitKQXE5QlZvbzNNRGtMNTNDUHBNWHhyOHAw?=
 =?utf-8?B?ZG85dW9SaVo4eG1VNmNTaVRqZjFSbVpkcE1JMUtTcXZMVktoeVNhWHBlOTNJ?=
 =?utf-8?B?YjA4MDNxMEZMUnNjM3FvL2dZLzM5MzAzVWljb3Z4aHVWc1FERlZRdWtaZ1RR?=
 =?utf-8?B?dGlLemFseUk4MThIUy9wZDJBdERIeWZRSHhobVZxNm1EZnpOREw0UFZQUUVv?=
 =?utf-8?B?RFd0S1B3Y0RjU3Q5SllLc2hFYmF0MlVObXVUL2FpdmRQT1EraXRHQ1BiZXZy?=
 =?utf-8?B?SnprazcvcVUvK0RKc1hBNk9LUEl0aDBMSy9POFZmYVhHN1NOck9mbVFzK0k4?=
 =?utf-8?Q?xgc0k8SLCFH93X3BILTjpokhG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242605d2-d022-429b-b231-08dd96aebacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 08:25:35.8361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0+JPXEoEpXZB+UPk6JdA+D895X+JUYf6So4uT6qTHALmi+Pv41wNWbUKqsXnSljhcDvgXS50UyfjdDW7uiHFAzRZrK4ICirA7KIfQuly48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5172
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=steven_lee@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGV2
ZW4gTGVlDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTUsIDIwMjUgMTowNiBQTQ0KPiBUbzogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4g
TGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5k
cmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47
IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBsb25nemwyQGxlbm92by5jb207IFl1
bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUkU6
IFtQQVRDSCB2MiAyLzVdIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogRml4IHVuaW1wbGVtZW50ZWQN
Cj4gcmVnaW9uIG92ZXJsYXAgd2l0aCB2Ym9vdHJvbQ0KPiANCj4gSGkgQ8OpZHJpYywNCj4gDQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTQsIDIwMjUgOToy
OCBQTQ0KPiA+IFRvOiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgUGV0
ZXIgTWF5ZGVsbA0KPiA+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
PjsgQW5kcmV3IEplZmZlcnkNCj4gPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9l
bCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPiA8
cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiA+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVk
dGVjaC5jb20+OyBsb25nemwyQGxlbm92by5jb207IFl1bmxpbg0KPiA+IFRhbmcgPHl1bmxpbi50
YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi81XSBody9h
cm0vYXNwZWVkX2FzdDI3eDA6IEZpeCB1bmltcGxlbWVudGVkDQo+ID4gcmVnaW9uIG92ZXJsYXAg
d2l0aCB2Ym9vdHJvbQ0KPiA+DQo+ID4gT24gNS8xNC8yNSAxMTowMywgU3RldmVuIExlZSB3cm90
ZToNCj4gPiA+IFRoZSB1bmltcGxlbWVudGVkIG1lbW9yeSByZWdpb24gb3ZlcmxhcHMgd2l0aCB0
aGUgVkJvb3RST00gYWRkcmVzcw0KPiA+ID4gcmFuZ2UsIGNhdXNpbmcgaW5jb3JyZWN0IG1lbW9y
eSBsYXlvdXQgYW5kIHBvdGVudGlhbCBiZWhhdmlvciBpc3N1ZXMuDQo+ID4gPg0KPiA+ID4gVGhp
cyBwYXRjaCBhZGp1c3RzIHRoZSBzaXplIGFuZCBzdGFydCBhZGRyZXNzIG9mIHRoZSB1bmltcGxl
bWVudGVkDQo+ID4gPiByZWdpb24gdG8gYXZvaWQgY29sbGlzaW9uLiBUaGUgSU8gbWVtb3J5IHJl
Z2lvbiAoQVNQRUVEX0RFVl9JT01FTSkNCj4gPiA+IGlzIG5vdyBtb3ZlZCB0byAweDIwMDAwIHRv
IHJlc2VydmUgc3BhY2UgZm9yIFZCb290Uk9NIGF0IDB4MC4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4g
WW91IGRpZG4ndCByZXBseSB0byB0aGUgcXVlc3Rpb24gSSBhc2tlZCBvbiB0aGUgdjEgc2VyaWVz
Lg0KPiA+IEhvdyB1c2VmdWwgaXMgdGhpcyBBU1BFRURfREVWX0lPTUVNIHJlZ2lvbiA/DQo+ID4N
Cj4gDQo+IFNvcnJ5IGZvciBub3QgcmVwbHlpbmcgdG8geW91ciBxdWVzdGlvbiBhYm91dCB0aGlz
IHBhdGNoIGluIHRoZSB2MSBzZXJpZXMgZWFybGllci4NCj4gU29tZWhvdyBvdXIgbWFpbCBzZXJ2
ZXIgbWlzdGFrZW5seSBmbGFnZ2VkIHRoYXQgcGFydGljdWxhciBtZXNzYWdlIGFzIHNwYW0sDQo+
IHNvIEkgbWlzc2VkIGl0IGluaXRpYWxseS4NCj4gDQo+IFJlZ2FyZGluZyB0aGUgQVNQRUVEX0RF
Vl9JT01FTSByZWdpb24sIEkgY2hlY2tlZCB0aGUgZGF0YXNoZWV0LCBhbmQNCj4geW91J3JlIHJp
Z2h0LCBubyBkZXZpY2VzIGFyZSBtYXBwaW5nIHJlZ2lzdGVycyBpbiB0aGlzIHdpbmRvdy4NCj4g
U2luY2UgaXQncyB1bnVzZWQsIHRoZXJlJ3Mgbm8gbmVlZCB0byBtYXAgaXQgaW4gYW4gdW5pbXBs
ZW1lbnRlZCByZWdpb24uIEkgd2lsbA0KPiBkcm9wIHRoaXMgcGF0Y2ggaW4gdjMgcGF0Y2ggc2Vy
aWVzLg0KPiANCg0KSeKAmWQgbGlrZSB0byByZXZpc2UgbXkgcHJldmlvdXMgc3RhdGVtZW50IHJl
Z2FyZGluZyB0aGUgcmVtb3ZhbCBvZiB0aGUgQVNQRUVEX0RFVl9JT01FTSByZWdpb24uDQpBZnRl
ciBmdXJ0aGVyIHRlc3RpbmcsIEkgZGlzY292ZXJlZCB0aGF0IGVpdGhlciB0aGUgT1AtVEVFIGZp
cm13YXJlIG9yIHUtYm9vdCBpbiBvdXIgQVNUMjd4eCBpbWFnZSBwZXJmb3JtcyBhY2Nlc3NlcyBh
dCBhZGRyZXNzIDB4NDAwMDAwLiBJZiB3ZSByZW1vdmUgdGhlIHVuaW1wbGVtZW50ZWQgcmVnaW9u
IG1hcHBpbmcgZm9yIEFTUEVFRF9ERVZfSU9NRU0sIHRoZSBmaXJtd2FyZSBoYW5ncyBkdXJpbmcg
ZWFybHkgYm9vdC4NCkFsdGhvdWdoIEkgaGF2ZW7igJl0IHlldCBoYWQgdGltZSB0byBmdWxseSBp
bnZlc3RpZ2F0ZSB0aGUgT1AtVEVFIGZpcm13YXJlIGJlaGF2aW9yLCBJIGJlbGlldmUgaXTigJlz
IHNhZmVyIHRvIGtlZXAgdGhlIHVuaW1wbGVtZW50ZWQgcmVnaW9uIGZvciBub3cuIFRoaXMgd2ls
bCBoZWxwIHByZXZlbnQgc2ltaWxhciBoYW5ncyBpZiBvdGhlciBmaXJtd2FyZSBjb21wb25lbnRz
IGFjY2VzcyB0aGF0IG1lbW9yeSByYW5nZSB1bmV4cGVjdGVkbHkuDQpTbyBpbnN0ZWFkIG9mIGRy
b3BwaW5nIHRoZSBwYXRjaCBpbiB0aGUgdjMgc2VyaWVzLCBJIHBsYW4gdG8ga2VlcCB0aGUgQVNQ
RUVEX0RFVl9JT01FTSBtYXBwaW5nIGFzIGEgc2FmZWd1YXJkLg0KDQpQbGVhc2UgbGV0IG1lIGtu
b3cgaWYgdGhpcyBhcHByb2FjaCBsb29rcyBhY2NlcHRhYmxlIHRvIHlvdSwgb3IgaWYgeW91IGhh
dmUgYW55IGNvbmNlcm5zIG9yIHN1Z2dlc3Rpb25zLg0KDQpCZXN0IHJlZ2FyZHMsDQpTdGV2ZW4N
Cg==

