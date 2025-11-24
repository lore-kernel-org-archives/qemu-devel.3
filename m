Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA7CFD2F6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 01:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLMH-00033U-HC; Sun, 23 Nov 2025 20:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vNLMD-0002xs-3e; Sun, 23 Nov 2025 20:27:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vNLMB-00071Y-1r; Sun, 23 Nov 2025 20:27:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeCjpZhTHUoEmdlvEKY5MbyQG+XC+1po+oB+h8ewRFkvOwsJW12oskE5t4evRFvufCxm0/y4jNFY00nbMel+xVViy6HjcXdLKbzJrAbFOXUeKodl8f4HhsFo7zgchrHfH16cCgrzzInJej35Qs6pzSXyH7sOGeUFj+J/pBRMdIo0Pbl5OnVjA4uo5b+xcyoI8UPfnFAOT1GyCeEwtQ2MBlqQaZwp6jxpxro0MSQMMQvpsEtV/Mj/5LOSdvMk5RFY+oG3ksz8HWknR2QXG7Ube5vWETwtwCge5/U85f7DRAl+4PLyZ8Y9DDDtRa52RNEkogx3zl2i6IAP5RuCF1w0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ct3YVm7ozUb6/aF9K2CFUl84cO1NaEkk49kurBX1ZQ=;
 b=WlvsQW2mKt9EWQs1dGLchrTZ6j7VnTGvriciMRsfVhNR79MUiL52BsWUVx9BXMMiEBjVvnk3Ab08VdEd3GmSKO8ngCvB59ThDGxVSLWo75A4KK6BwBp0TELi3YOPfYooU4IYdRCYJtKiYyl4eA8mPy4N50KoMix4Kb6xKK6fzr70OLKjN4DUEBj3pVZf2z2MFBuvqeyTuH+xGV/M1PTWAfdOV7Vprt/YuYAu2MMAHXTDfcGurc0X18GhOgYlkXpFU02zfePSODLNt2MfieJFIcL7X5c0djsI4ZbcmLknw6jAnaQ0hrblxMynW4h+geDVWzXjaHh2Eql/iA7wDTgH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ct3YVm7ozUb6/aF9K2CFUl84cO1NaEkk49kurBX1ZQ=;
 b=ITiJo60J/xBFFF+t2Fc8xbG4/pRKPLMYSQD2EG6GTrTPLdiR+hTXdxouUf+UDVV3mT9ZgOBRMGx8ArMQ7LwQz4qXzPIZuUlE5CbuUGMxcPMdmC/DxyKMnjE4TdfC/mAyT8CUqb/vxZpbs3mc0naSerrX+YqDystuA/i7hsy9L5PYnh7TlNMAegWTOsefkx2+sBmdtjNMgzfAINC3bv3dLz+vpDQtxv6ogFcuKJ3TbcM1Ttk2+HuJrKCNujl6JDG855u7ubywFu/Ewq+zk3U4p07WVJ8Bt7R0s4XbsGrUIYpSwf2pM3Db76mdSY2n0BtVV02kF/y7SPCMbnxnxUaSwA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Mon, 24 Nov
 2025 01:26:56 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 01:26:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [SPAM] [PATCH v1 1/1] hw/pci-host/aspeed_pcie: Update ASPEED PCIe
 Root Port capabilities and enable MSI to support hotplug
Thread-Topic: [SPAM] [PATCH v1 1/1] hw/pci-host/aspeed_pcie: Update ASPEED
 PCIe Root Port capabilities and enable MSI to support hotplug
Thread-Index: AQHcWqPcURtTgdo3jkuIpuDLVeHo6rT+TAUAgALBD8A=
Date: Mon, 24 Nov 2025 01:26:55 +0000
Message-ID: <TYPPR06MB8206124CA2B4B3B97F4795E9FCD0A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251121050108.3407445-1-jamin_lin@aspeedtech.com>
 <20251121050108.3407445-2-jamin_lin@aspeedtech.com>
 <4a893b67-c457-47a5-87ca-c41c0a4df070@kaod.org>
In-Reply-To: <4a893b67-c457-47a5-87ca-c41c0a4df070@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI2PR06MB5041:EE_
x-ms-office365-filtering-correlation-id: a5a52f55-3337-4cfc-6cec-08de2af88e3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?K3MvNUZIaTRERkpBMHRXNjdZU0o0UEg3Zm9VREdwOFJVNGNGeEFwVDJiWXpR?=
 =?utf-8?B?ei9pbnNIVjI2WHJkVG1lQUxqTk9wTnFEWUdOclVYN1VRQU5RUXBMbzM5amFM?=
 =?utf-8?B?dHhnckVNNHlSamVtY1MvRytPa0RFczZVbzE5MjFlWktzcFhQM3MydS8zNTFX?=
 =?utf-8?B?eDI1YVpkWnl5SzdYVHZXV21UTk5Bc0pzcWVTcmdmWGRNQ1JTSVc4VERUYmh6?=
 =?utf-8?B?RDAzejJxTjI3Y0tUbVJ3ZFA1U2ZRZUpWdTA4WEZXSFAxdWxZeXIzdXdTYy81?=
 =?utf-8?B?a1poRFRYd0gzR0x5TWFYd3czdjhiaVM0dDV0NDZlQUFwdnJ5WmxTODVhRitt?=
 =?utf-8?B?V0pzWldCeFJtMEM3ZnJUVm41WmFydkF3ZTlZR0dEUFpVKzh1SFNmWEQyU1VL?=
 =?utf-8?B?OVQvZG5KRDZmVkgzU0doVHl0WUNtNHcvZ25OZTl3S1RPbDREKzZzMmUxdGx6?=
 =?utf-8?B?SGRQUFl4WGZpOGtIZmpkeFl3VkI0MFgzZUp4b0tvNXVIaHN5b2kwR3A4YVlH?=
 =?utf-8?B?b0xpRFV3SW1BMkd4N1dDQWRHaFM0bEFZcHhUV3B3WjlnZ1c0S3VuRTk5aTY4?=
 =?utf-8?B?d0ZvREhXQXk3cGgxaGY5ZTlwSlV5Z3BiaWpYLzZ6ZW5QTEhtMnExR3kraVM2?=
 =?utf-8?B?bXBxbXFYTHArODNRYmtMb2J1MUNaUXRUN0ZvbFpld3BKczVyZVV5QUM2R21V?=
 =?utf-8?B?Z0IrT2ovVm5IRng5cUFoRUUwcnVvWGxRb25Td013SnQ3VzljRzZQN0xqQVU1?=
 =?utf-8?B?QlpKbzVqNm5MQ1NBb2k3Y213WVIyY0ZKT1d2NmZraFdFeStoc2JIVWVEdFho?=
 =?utf-8?B?Y2Ryci95WlBjM1pEbVQzcGg5eFZ1dVk1Vjdla0pZK01GTkpyQVRmWkRLdTNZ?=
 =?utf-8?B?b0NJdUVDNnY2Y21PcmhCakJ3MHI4c2Z2SmFLVHErcVFoK0k0aG1abERaRzF4?=
 =?utf-8?B?aHFGQzJFempzTitmRm5nMTNVcGJvSGlWQklqa1hsS3FmZzN2L2hDbiswY3R1?=
 =?utf-8?B?bkVwYzVmUXJUaVArTyt3YTFJUS9XbmN4TEdWZERzYUVtTVgzUElSTUZwTm80?=
 =?utf-8?B?M3h5RGtjWUNGRmxIRVJiTGNQNFZ6NmhxdktwQVFWdlA0ejZJK3lkdlZCeEEy?=
 =?utf-8?B?MnRldFFjTmdUN2dMZ2dlaGdmQWlLNlM1R1FoZFBxMCtQN00rak5McGxIdklM?=
 =?utf-8?B?SHFSV0t2VGtRNkM2MUVEamFlQVY4Tkt4TkZmaUlaOWJsLzlDZmYyWDlmNWww?=
 =?utf-8?B?dzZGcndSVFBETDdVTCtTYy82dGVIb1l3b0FTaXorYUgwb1dWdU5oMmVPdUZa?=
 =?utf-8?B?Q2ZUWis1aG9mTWtzZlB5MDlxMGhNNGJpTSsyVjdtSzAwNlZBWW1YUkhsRmhr?=
 =?utf-8?B?S1V3cjVZdGNnNzkwcnhlWnMyeERCWityTGFQOTFKMEJqdVVuWEVteUkvWE90?=
 =?utf-8?B?ZVlWMEhjeTNsYy92UlhWSGxwZ0N4TG40VkxtRGhPdlNCREtCRnBwT3ZaNzAx?=
 =?utf-8?B?cDFwR1V3ZUI3Sm81YXQvdHE4TGVqSTRjV0p4VDlOQVQrVmpYMnpyZ3UwVjZo?=
 =?utf-8?B?U29qVnE0WDJNL2tIY1lwMWRsM0J5RUVDSURGTW5UM05DWE8zakcrYW9MYkdS?=
 =?utf-8?B?aGZrUnhkTk1hOGRtaExFOUsyTVJKYkY3V1NmbnNBVnhmd1lrdmRYTVRtWm1H?=
 =?utf-8?B?eThFZ295Ymg5bGFHWnNMQmcrcVQrSjJoWDV6MGhxdXkxSHZON3J3b1RYR0RF?=
 =?utf-8?B?N0EwVGprMm8yWGNjUXlDUkpHN1RtdS9jSklyYVNiSmJVTE1QNzRFd1V3Q3ND?=
 =?utf-8?B?WlQyVDU3ZUVUVlZuZ01LaEkvS1BwaC9acVhhNjMzVlpTaGpHeTREUnhkbXEz?=
 =?utf-8?B?L09DOEhXNU5TbnRlWHJpdXdSL00xeGxuaWxHSC91YkZsNXdmcDBQWjZnaG9C?=
 =?utf-8?B?V2srQ3VBeFBtSWdkYnFvdTdGUmI2V21VNEZUYURsWEdGalBsYUpIMFVFWWg0?=
 =?utf-8?B?Q3ptRFQ1a0RJSHFaQUh0THZWcFJwLzdydTVmOTk1YWN2dGkzRzhhN1B0QTBw?=
 =?utf-8?B?NHVJcEFLQXhJSVFOdlpQY05iVVF6cy9NSHFPQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkJpZnJWZ1dsbHVpb1hGL1lJcURCdGRCZTRyZzV0N2JIZkp4aS9iaTBUMVFm?=
 =?utf-8?B?bktpY0Q2Q1IrRkNmZzBxOUJ3dzVRU3BSNXRVbzZuL1dyK2V4Tk9TSkVWaWhv?=
 =?utf-8?B?cmlFT2xDZEJEelpoNElFKys4RkZOVnNDYjF6VVZyREI0Ym1henRsNDBnZWoy?=
 =?utf-8?B?ZFJ1MXhiZ2NJc1J0MFF3N251RXlDQnhPYnNtckJ0Q0dGV2g3WFJTQ0hndm1J?=
 =?utf-8?B?THdyT1hzdVlML0ZjVk9SZkR4YXNhaEs0dEc2b0NKQ3lYVmNFQUw3Z29WTFBV?=
 =?utf-8?B?UmtOcG5nM2ZlcDV1VmxCQjZNOFVpK0pKaGt2TFM3T3VmdXJabjR2cVV3T3FU?=
 =?utf-8?B?V0hXeHVaMkJycTVSSE94NGtPM0tFOXJRVFB2L1ZnQ0lyWk5lOG8zR29SaTVh?=
 =?utf-8?B?QVlJSHlTN2JlZVhsVTNoRW5sdkxkaWlGMTNtMlRHZGFYV0hFbnZiSWJCSDEr?=
 =?utf-8?B?bmhpczh4azYwQTR1QWhVZXBqUU5tV2N1RUFOQk1UOE1jaU9rWW1wc3BDZnIw?=
 =?utf-8?B?dE42ejcxeG9wbW1HY0tNbmp0bkxId1N0d3dFcEFXYk0vd284VGlQNTZjMkt2?=
 =?utf-8?B?MUhYa0lnSVY0Rjg0STRUUzhld0M2YVhlbEl1TjlmWDc4UXRpdzRVMlA5WXJv?=
 =?utf-8?B?UFNVaE11aHJ1WjVrV0toQ3Zmc2t6Y0lTVzFTcWZWL2ZBdzJ3aFJ4K1U4N20r?=
 =?utf-8?B?N1J5SmVZNEZ0V0k1RmlvYURJZmFrTzBieFIzRGVoUm92N1NvY1MxbHZvKzBi?=
 =?utf-8?B?T0NMSkFRbHJFWVZvK0VEUWpPMEpqYkVMUnpjMDR1VTI4bzcyenVwczRHK3Qv?=
 =?utf-8?B?eWFBZmpaYVVNeHpkdXZZeEYvRUU0K0o2WGNqYUZaTE9GakY2ajFDcVVhOHVU?=
 =?utf-8?B?aWI5NnF4eG5SR09uM0xJTXc0WGd3Y25uczRKMWpJQ2lGRHg0MUFZbGdVNEtZ?=
 =?utf-8?B?anc5bE1kcDFXNnAxbFQ3TWc3cy94d0RERUhlRnZYK0xpV0FyckJhK2dpUHpZ?=
 =?utf-8?B?cW9NUFJwRkd2TUdFTUUxUjFPdXpWZDkwOXBmOGcyck5seDVTN2p0L2VveW9Y?=
 =?utf-8?B?NG1Zb1hxRW1jYkc4QTljUUJwL01RNmhYcXlKTFh0M3RkcU9wd1VjT2E1VkRW?=
 =?utf-8?B?M0gvWHZoMDFqWEtEL3FvRm8wbjJCd3lyRzRvTlJYYit4VU9KcUdNR3lUZG5D?=
 =?utf-8?B?QkZWNThjYkZjVm5NMDBKd29yQnVXVXRWMHVTUG82TC9YV1lxeDRnbWhJdWtV?=
 =?utf-8?B?bDRHaVFzc3lLdlhyNGdFSlJwQzk5Qk1WOWRzT1ZLVUVLaXUzZUV4amRxVlcw?=
 =?utf-8?B?SURjOXZuN2Q4eFFLREVLUlF5Y3RhWGpQcVRvY2drQlZxWk5xTWM4N3k3NXRY?=
 =?utf-8?B?dUUvWUIzdjVERzZoUWVNNlFPSGJ6NzNDamRWaGNhcVUyNEFEd0FGT3RDSGY5?=
 =?utf-8?B?Y2pIdWV6b000d2lTcDQ1bDJVeUExWDluenRlQ0xtZC9Ld0x0d2M1V0QzVENw?=
 =?utf-8?B?b1NzMUM2TEJDUHIzYnlzbWluVEZuVk8wVzFPYmtjK3ZFUXFDNWZmRmlJL2l3?=
 =?utf-8?B?UGR3ZmN4Zk4wSEFYWEkxYUZra1EyR1RLVTV5VXIzeVJnUTlGMDI5bzFHT2Y1?=
 =?utf-8?B?T21sL1UwTTArb3VIWlk4Z1ZyMEtZcmFFdUkzdTVuYU0ya0wySzJKOGdvZklC?=
 =?utf-8?B?ZmdOMUR6K1B4R1N4UVRhQ3BYRTlOc25MNFpGbngrckU2dHA0elN5Q3JTSWtP?=
 =?utf-8?B?U2RIdUtVczluY25xbTVoK01XM1hqYmpwazdqZzJRV2lzelJmZlFEaVA0V3lX?=
 =?utf-8?B?cXNMUXNlYysvWmtlM3VQWjlPZU5aWG5PQ0RyaXVYOHlGTnVnOFdBa3Y2c01h?=
 =?utf-8?B?dFlEV2d4ajZZWFV6TmMrNHg0MG5lRk13MmZjNXkzSE10eXlOb0prVVQyWDFp?=
 =?utf-8?B?R0ZiZnExdWFVamsvQVNSenJkbVJpTWhFMVVMMEZYYS9QTzJ0MFdHS1dwc0k2?=
 =?utf-8?B?OTA3VjJwWFp1c09JaUtsWE5TTmQ3cjMrMEEzU280LzFjdnJOOTJqMmJoN0Zy?=
 =?utf-8?B?eFArWm5FTmxQYTMyRDFhdW1ZMjFqeEdzSnl1TnpvZ0lCQmxoMGNyeUd4b0Ex?=
 =?utf-8?Q?p68Yk3xLBslkXU4LWvoc6mAzK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a52f55-3337-4cfc-6cec-08de2af88e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 01:26:55.9321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjxh6DgT2cbEEWQrXFnycynCUPYQ1XLldAYRnrGremzxjQSBIc37i1iFO4CVPzg5WJk48JUWGb7EsOKw7ZdEwb7ptTVm6GXkSwKQi0+cZ2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5041
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+IA0KPiBGaXhlczogMmFmNTY1MThmYTkxICgiaHcvcGNpLWhv
c3QvYXNwZWVkOiBBZGQgQVNUMjYwMCBQQ0llIFJvb3QgUG9ydCBhbmQNCj4gbWFrZSBhZGRyZXNz
IGNvbmZpZ3VyYWJsZSIpDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgc3VwcG9ydCBhbmQgaGVscC4N
CkphbWluDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gICBo
dy9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jIHwgNDANCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3BjaS1ob3N0L2FzcGVlZF9w
Y2llLmMgYi9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jDQo+ID4gaW5kZXggZjc1OTM0NDRmYy4u
MWZjMmM2MTc3MiAxMDA2NDQNCj4gPiAtLS0gYS9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jDQo+
ID4gKysrIGIvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuYw0KPiA+IEBAIC02OCw2ICs2OCwzOCBA
QCBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX3BjaWVfcm9vdF9kZXZpY2VfaW5mbyA9DQo+
IHsNCj4gPiAgICAqIFBDSWUgUm9vdCBQb3J0DQo+ID4gICAgKi8NCj4gPg0KPiA+ICsjZGVmaW5l
IEFTUEVFRF9QQ0lFX1JPT1RfUE9SVF9NU0lfT0ZGU0VUICAgICAgICAweDUwDQo+ID4gKyNkZWZp
bmUgQVNQRUVEX1BDSUVfUk9PVF9QT1JUX01TSV9OUl9WRUNUT1IgICAgIDENCj4gPiArI2RlZmlu
ZSBBU1BFRURfUENJRV9ST09UX1BPUlRfU1NWSURfT0ZGU0VUICAgICAgMHhDMA0KPiA+ICsjZGVm
aW5lIEFTUEVFRF9QQ0lFX1JPT1RfUE9SVF9FWFBfT0ZGU0VUICAgICAgICAweDgwDQo+ID4gKyNk
ZWZpbmUgQVNQRUVEX1BDSUVfUk9PVF9QT1JUX0FFUl9PRkZTRVQgICAgICAgIDB4MTAwDQo+ID4g
Kw0KPiA+ICtzdGF0aWMgdWludDhfdCBhc3BlZWRfcGNpZV9yb290X3BvcnRfYWVyX3ZlY3Rvcihj
b25zdCBQQ0lEZXZpY2UgKmQpIHsNCj4gPiArICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IGFzcGVlZF9wY2llX3Jvb3RfcG9ydF9pbnRlcnJ1cHRzX2luaXQoUENJ
RGV2aWNlICpkLCBFcnJvcg0KPiA+ICsqKmVycnApIHsNCj4gPiArICAgIGludCByYzsNCj4gPiAr
DQo+ID4gKyAgICByYyA9IG1zaV9pbml0KGQsIEFTUEVFRF9QQ0lFX1JPT1RfUE9SVF9NU0lfT0ZG
U0VULA0KPiA+ICsgICAgICAgICAgICAgICAgICBBU1BFRURfUENJRV9ST09UX1BPUlRfTVNJX05S
X1ZFQ1RPUiwNCj4gPiArICAgICAgICAgICAgICAgICAgUENJX01TSV9GTEFHU19NQVNLQklUICYg
UENJX01TSV9GTEFHU182NEJJVCwNCj4gPiArICAgICAgICAgICAgICAgICAgUENJX01TSV9GTEFH
U19NQVNLQklUICYNCj4gUENJX01TSV9GTEFHU19NQVNLQklULA0KPiA+ICsgICAgICAgICAgICAg
ICAgICBlcnJwKTsNCj4gPiArICAgIGlmIChyYyA8IDApIHsNCj4gPiArICAgICAgICBhc3NlcnQo
cmMgPT0gLUVOT1RTVVApOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldHVybiByYzsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX3BjaWVfcm9vdF9wb3J0X2lu
dGVycnVwdHNfdW5pbml0KFBDSURldmljZSAqZCkgew0KPiA+ICsgICAgbXNpX3VuaW5pdChkKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9wY2llX3Jvb3RfcG9ydF9j
bGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICB7DQo+ID4g
QEAgLTgwLDcgKzExMiwxMyBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfcGNpZV9yb290X3BvcnRf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQo+ID4gICAgICAgay0+ZGV2aWNlX2lkID0g
MHgxMTUwOw0KPiA+ICAgICAgIGRjLT51c2VyX2NyZWF0YWJsZSA9IHRydWU7DQo+ID4NCj4gPiAt
ICAgIHJwYy0+YWVyX29mZnNldCA9IDB4MTAwOw0KPiA+ICsgICAgcnBjLT5hZXJfdmVjdG9yID0g
YXNwZWVkX3BjaWVfcm9vdF9wb3J0X2Flcl92ZWN0b3I7DQo+ID4gKyAgICBycGMtPmludGVycnVw
dHNfaW5pdCA9IGFzcGVlZF9wY2llX3Jvb3RfcG9ydF9pbnRlcnJ1cHRzX2luaXQ7DQo+ID4gKyAg
ICBycGMtPmludGVycnVwdHNfdW5pbml0ID0gYXNwZWVkX3BjaWVfcm9vdF9wb3J0X2ludGVycnVw
dHNfdW5pbml0Ow0KPiA+ICsgICAgcnBjLT5leHBfb2Zmc2V0ID0gQVNQRUVEX1BDSUVfUk9PVF9Q
T1JUX0VYUF9PRkZTRVQ7DQo+ID4gKyAgICBycGMtPmFlcl9vZmZzZXQgPSBBU1BFRURfUENJRV9S
T09UX1BPUlRfQUVSX09GRlNFVDsNCj4gPiArICAgIHJwYy0+c3N2aWRfb2Zmc2V0ID0gQVNQRUVE
X1BDSUVfUk9PVF9QT1JUX1NTVklEX09GRlNFVDsNCj4gPiArICAgIHJwYy0+c3NpZCA9IDB4MTE1
MDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9wY2ll
X3Jvb3RfcG9ydF9pbmZvID0gew0KDQo=

