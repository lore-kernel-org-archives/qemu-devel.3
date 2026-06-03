Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E634CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUaSd-0004BH-Ty; Tue, 02 Jun 2026 21:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUaSa-0004Ai-NP; Tue, 02 Jun 2026 21:31:56 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUaSY-0007PZ-Et; Tue, 02 Jun 2026 21:31:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNkRqF3SouvISnDwTNyxT1NhfqA3N7mrSXdsROiEoRfj8ImfUPUdfXB8zbbbq5rZrCw9IKFjC0ZqRHd20OQPywEL3lXcT7DpVlDgBsLI2ubco3fPAlA5JSjbcCsRzXxoKprp8Vq4aYwHun8H6lqOT3fxK4Rqt/CFNOxcysiDf03Xu4NKPc/49VPDIdE6gFvx1meKTMaxO6SdUQGrKeqEiWvE/ysmC4WJ/mq36MF5My8DmC5WrQJ0/keoEs0DexjKE80ai3yXbkgiZD0FnAcIB7EhPp8rYRpNzE0UAbtuP/78USh1mFo58/qV/I/1NXAp0KcBkQ32D5TAM17ZvxEPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh9QJ1a3blVNvHzQIYeyGwMTP2zpRrlcNDRZrz8S/ls=;
 b=W///sPjeLodlkAONtf7C/Wt25NHT7dK63HAym+CFCekeGA/andYA++Uf2vZjbMI7bsf8kg95Nvj4RoZvhb8pfz4W4ZMcsYqSoCo60M22UMnb2xw/ZVLbTY6yBPjTtKRTzt9Lbkv3RtQ/tiPLuy1Jgt7mQ/lcDxNvyQPGaB7VZxvKR+POqv4WrV8QYB8a3x7XiANm7DslhrSOgnA+HTHJE877U8ZOYzvOB7E9t72VCPcOE1OVzaXlFssX0X2ItCxS5DlD5H9bA2Bp/8yBiBSISk5IhkpR19Vav1N59u0G8L/ol2dXSsdufukVdGAtW6CHw7QdA+LwO3Er5q19IaYMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh9QJ1a3blVNvHzQIYeyGwMTP2zpRrlcNDRZrz8S/ls=;
 b=WNl+KAGvq+Wvl9Ei/vMjKx4VCOz6Ml88wy+x/XT9hW64tEk1InaxVNvnAPqaXsOAjaO026XOiOUt9JxNeMHWB3Ilyw5BPVhVVKgnvLrhEXNOl6fHu7bogCmbwgIgmI3WKuHU3red3+AU8sN7OiFHwT3C5nLJ7m+jgZdpTDLgYoGoJj3/mbqlDe+76lOk7LHGnWx22gvg+br5EMIlLFm69reRA0M4S+M7d7SBWGF27wj7O8VP8dp9FBvQQZWQEcaPMh6BfAuvIGyInWBfmwgO3PaQwrTy4uR74XVPw9Agn3kjMHI8ashnk1ICit5xMytv0dPG3tap0Eq2PFoLmMeq3w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7036.apcprd06.prod.outlook.com (2603:1096:820:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 01:31:44 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 01:31:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
Thread-Topic: [PATCH v2 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard
 I2C device
Thread-Index: AQHc8lCqSxHismjzOkG6W4XZ3+fb1bYqzyEAgAE3NXA=
Date: Wed, 3 Jun 2026 01:31:44 +0000
Message-ID: <TYZPR06MB49804F37E2FEEFCCA23A40AAFC132@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
 <20260602052827.1535299-10-jamin_lin@aspeedtech.com>
 <904f30ab-14ed-41e8-8875-42179c444b56@kaod.org>
In-Reply-To: <904f30ab-14ed-41e8-8875-42179c444b56@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7036:EE_
x-ms-office365-filtering-correlation-id: 2b48044c-2a60-4740-3d00-08dec10fdeed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|6133799003;
x-microsoft-antispam-message-info: 9kc89FhHB76VcjZVgdn8+aC/xNnZ8mWoCrIJSmXaGo3qWcs8xnjx5FW3BlGviRgFCZF1Qiv5WC779FLDzb25kwstgk+I3ROqY6I2IPphvRHp3DNuhvDjvZz57LhSD2L9d+OR24CBYhs29pql/IRC3b6XufwrB5WUWro/eNMRJanaebgpLMtoyvqqpEqrW5gDB9aI0noCeW1nQWbbvBUo2VpkTKmneyRsijyRguWkB1dlvTJTWNx5uOkcPQAuW6m4BEekH+9c58oqkyQFmToFkkx9Vu2X1ptASe+L+sFzSRp7W4ssj0FIpT9WI7QtT41Cho8911d0Qj35obi+ENBDVCKyZb4w7UdtPPAn+il/ImvlmFt9UcHEFffOmICJYmf6xeT1eHOMgNuEirsdpmPZqp5oko0slZxB76tLgsdrSukn58ajf77ufIY50RMvQJJpm9+XcRoJjD/AjS8o8FF2sKmzOX4abVaev+d2xUDncoudRsyGJoMSkR+oh7+wG2TdoaoODnHIwQGe0UJ8es+w9kPCMaqZZN9gnNcrYvNYKfQUUx3FPJiOFUyrwqRshwYOozM3Z3Iw3piolsK/G7QltVBx4lRrNNH8h6SZ2yOwBq1YhdK60yjB7uvE4uVtVjdhbocgZn57y4Kd4Ai6H2eKIiNVvk7cwvw1VQ7R4WSKTU2yFmu/kvYOReQJD5+BNS88Ze05G394Nk3KNDk8jGjlAHAn3UzgzWzksrbJygmGzajZRNR7TzNFYzIkXQVEFSCI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?endtNVRFYzdvckZqV1M5SUdNWnpYdWRYY0pMcGpXL05LQTNneUYwTTRkbWtR?=
 =?utf-8?B?WVdoN2xTT1orK3E1bEIvRFZlTFlQYWZzR0pnSnFXejI5Mk1iNlB6ZTRhK0VW?=
 =?utf-8?B?L3NjWmM1eEZ0RVFVTXVuZUhUdmtSQnkxOXE2OUEzRnVwR0ZwWWsrUkRyNlBq?=
 =?utf-8?B?UzB2RHBxdVBsN0xhVkl4SkVLdTFiN0ZwbXRlT1JtaHBnU2Y4RjFmaFE1OEVF?=
 =?utf-8?B?UHVYWm92Y0g2MlhEUks3dHBkZWJnYUVRMUJjYUdBdFdxUU13SWdreUlweU5x?=
 =?utf-8?B?bmpjTUM2QkkxV1Q0SC9KeXgrTURLZ1FyQmNVaEdTeXFyVnRObk1OV1VGa0E2?=
 =?utf-8?B?eVBSa21kc2grcGU0OFB4MiszVG5RdUo4OTR5SGNZVkl2NG5vS0lVZmcwbUh5?=
 =?utf-8?B?UTU0TFFOZ2RkUndVN2lCL2JRYjFxQU9KY1gvZjZNVjVhamg3bU1iNUJHWGlm?=
 =?utf-8?B?NEQ1cTVnSzF0emIyd0VvUEdTZnRwOGlLU2tsanV5bU9nSmp1bUNldm9Wdnh5?=
 =?utf-8?B?dkRsNjhOODVMRFZqU3VCVitvdkJjNnl0c3JYRGNQTlY1R1diSm9kTW4vck5j?=
 =?utf-8?B?Z3NxYUJxSGpJN1M2RktJSmVFMWk2VzZOd21XQXNXMVVqK2V3RDVoUWkxblJp?=
 =?utf-8?B?aGpWMTdqZUZRdCtyVExIeDNUb3J6ZzNsZ2h3anBuVmJ0US9uUWMxbURWck53?=
 =?utf-8?B?b0QvMURPcEQra2x4Rk02emwwN0VpbE9IZ2d3Nkl2NHpaRWdkb3VYN2dTVWlt?=
 =?utf-8?B?TGs5NlJIWGV5MXFZSktHUnE5TEdCYlBTQlo2eHExZVhqNnhBc3BQWXpwK2FK?=
 =?utf-8?B?S1BaMDRqNFFVM0k1RE1vUkdYN3JDQXczaUY2VEVpS09NdmRRRW0vNjhNeDc3?=
 =?utf-8?B?K3U4QlVqU1Q2dnRyN2tiSnU3TjNselV3ZEpJU2ZTd2tucjRzYzFnY0d6VE1R?=
 =?utf-8?B?R0JWQnpVWWludEhuMVpvRUliY0E5Y29BYVYvUWVhRWFzcGtEWjVydS9OaDli?=
 =?utf-8?B?OUJwc1ZQMUdTYXBvZW9PeHJ1bjNFZzllaVR1cmhDc09GeWo4VU1ibU9zd3Er?=
 =?utf-8?B?ZVVFU0grVHNLR0Q2VUk5Q0s5MFZBNHhaWE92K1hWQ2wrWWZzWTRRM1NMaUpV?=
 =?utf-8?B?czFSVnU0UmkvT3d6VktLY0x1WlZseVlDQWRMN1ZwZ1k4ZEQ4bGlqVHhRUFRn?=
 =?utf-8?B?ay9SRFdycjFuMzdHc3R2Y3pJWWtJdTlydmZqNm9uMjBBb1hRaEkzVzdRaDRX?=
 =?utf-8?B?bzAzejJxQ0gzcnhkc1AwZ0NqaUhQYUcwTXF6UlJQNFJONlp3WU96QjZpVFVa?=
 =?utf-8?B?NUNmdlcyTmxyQVlQelpDSnI0VHY1OVNyMitCWkkwTWNvOElpWUozeWRNekwz?=
 =?utf-8?B?SThLN1ZPVlIxSi9zcERXeEpJNHNMdU82anlPVUFKVXd5WnhJRVVwQlFLY1Er?=
 =?utf-8?B?TXFoQjh1b3RqYkx2OGFJcVZqcHlMV1U3S2JRZmpjZjgwa0VpaHZQYUdNUVFm?=
 =?utf-8?B?ZyswWTlHWEVRQk8zczN5K0JvT0RJTU9Qc3pMajRtbGVyZHZiRnA4bVVIWWx1?=
 =?utf-8?B?UHM3aG91b1NUOTNLSkxoOWd4VmpSdzQ1TzNEeUZqV2NOSTJXZ2pzb2NRbG5G?=
 =?utf-8?B?U1NYbVNLRkRyeTd2Yytvd1BEdVpKNVhxZ1NiSmlBMjUrZnBxcm1qWGRCSUdH?=
 =?utf-8?B?czBQa1oxYVM1WkYvdFdjTVBiY3ZaVWJiNVovUlp1WFhyMjM1cFJULzBlUDdN?=
 =?utf-8?B?Qi9NMWx0ejhieDhFN3VFM2YveTEwYkxNOURlay9Bak1pb0x0ZE95OGhNajJk?=
 =?utf-8?B?RjZ1NlBXa1EwbytSLzdxTzdvcGUyU1UrTDhIQSthbFc1aXdBY1FkaEZFU3R3?=
 =?utf-8?B?eW1pZVNJZC9qa0FqWnhScVlBWXFTclFSRnllWU43clNxelBEbVUxQjBOVWFI?=
 =?utf-8?B?TndGMGowQW5adVRCczcxOGFpY0ZsVnN5VVNMUTJkeDhqbGVoYk5xV0J2RWM4?=
 =?utf-8?B?NmNqTkxlcXZVNy9BMEVlaWZoNU96bXdvNE1rUEthcEFtYWUvN1NTY1c5VTcx?=
 =?utf-8?B?NnBFeTJXYVVNMGN4Y0tTZGpKbUd2a0c0SXdQQk9EQi9nK3l6Z1lmV2c3K3Yx?=
 =?utf-8?B?c0FWTkxBQjZVT2JjZXROcU83ajU2Y1QrSHN6cEFTR2x6Tnd4K0RjdW52bzdW?=
 =?utf-8?B?RU9ZTGlXQWJvSTZ6ZmhTVHZreWxqbTY4ajZwOEtJY3VSNkcweG5oTlRZdGFy?=
 =?utf-8?B?RjA4blcwdzg2RzUySnR3ZU1sT2RTRERyRVU1VUVFVDNaY2l6OVFQUWJybTFt?=
 =?utf-8?B?QktWQlVXOXB4RkQ3ODQrVjcrMldDQWloUlRlbDNEektlUzN2Z0FPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aaKrcpwn1MMKOs18KP7M4vNc9Ajtw6ygK36LD1eGY77mhVU7NwPlQZnXCgeXucUgpblCpLtuK1yyq08vCGHDy3gGZ/XOKMg9flLaD+7Jc8K3S8CuJWUiiTgJKKYqK+XpMQGc8p4/e88yFRQ70xJP9Y/uLbYHEWF12PZFe+HE+AI6aJcr9OF9gj2IEAZk//E0RRAeSyNTg+xX6R5QrOp0IwJhojgH2pZFAALEyWfpmhoIvgiD4nOFMg/3X+zEj1yuwzAdJ/SnfNWgJqc/dWtamVqJnEiUkdxgHdkPTkDnRcmcNvcAAwP0HQelz/AcZw3sjR+PO+aGPN53mfkAv/SONA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b48044c-2a60-4740-3d00-08dec10fdeed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 01:31:44.1702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e33ChiaEGWa5Hk/WpVwmrTyLsCA9o/8ArNO3XbipRjAide5SBnIXv3yqqedOTOvBFa0HNBU/figs5NdFIPwlQBRzh9TafNqcIVqGIn6wxgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7036
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDkvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0MTA0MF9ldmI6IEludHJvZHVjZQ0KPiBvbmJvYXJkIEkyQyBkZXZpY2UNCj4gDQo+IE9u
IDYvMi8yNiAwNzoyOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEludHJvZHVjZSBvbmJvYXJkIEky
QyBkZXZpY2UgaW5pdGlhbGl6YXRpb24gZm9yIHRoZSBBU1QxMDQwIEVWQiBtb2RlbC4NCj4gPg0K
PiA+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGluaXRpYWwgb25ib2FyZCBJMkMgZGV2aWNlIHNldHVw
IGZsb3cgYW5kDQo+ID4gaW5zdGFudGlhdGVzIGEgMjRDMDggU01CdXMgRUVQUk9NIGRldmljZSBj
b25uZWN0ZWQgdG8gSTJDIGJ1cyAwLA0KPiA+IG1hdGNoaW5nIHRoZSBjdXJyZW50IEFTVDEwNDAg
RVZCIGhhcmR3YXJlIGRlc2lnbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QxMDQwX2V2Yi5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRf
YXN0MTA0MF9ldmIuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTA0MF9ldmIuYw0KPiA+IGluZGV4IDFk
OWI1NTI0N2YuLjY2ZjA4Y2NiZTYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3Qx
MDQwX2V2Yi5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxMDQwX2V2Yi5jDQo+ID4gQEAg
LTE0LDYgKzE0LDcgQEANCj4gPiAgICNpbmNsdWRlICJody9hcm0vYXNwZWVkX3NvYy5oIg0KPiA+
ICAgI2luY2x1ZGUgImh3L2NvcmUvcWRldi1jbG9jay5oIg0KPiA+ICAgI2luY2x1ZGUgInN5c3Rl
bS9zeXN0ZW0uaCINCj4gPiArI2luY2x1ZGUgImh3L2kyYy9zbWJ1c19lZXByb20uaCINCj4gPg0K
PiA+ICAgI2RlZmluZSBBU1QxMDQwX0lOVEVSTkFMX0ZMQVNIX1NJWkUgKDQgKiBNaUIpDQo+ID4g
ICAvKiBNYWluIFNZU0NMSyBmcmVxdWVuY3kgaW4gSHogKDQwME1IeikgKi8gQEAgLTM4LDEyICsz
OSwyOCBAQA0KPiA+IHN0YXRpYyB2b2lkIGFzcGVlZF9iaWNfbWFjaGluZV9pbml0KE1hY2hpbmVT
dGF0ZSAqbWFjaGluZSkNCj4gPiAgICAgICBhc3BlZWRfY29ubmVjdF9zZXJpYWxfaGRzX3RvX3Vh
cnRzKGJtYyk7DQo+ID4gICAgICAgcWRldl9yZWFsaXplKERFVklDRShibWMtPnNvYyksIE5VTEws
ICZlcnJvcl9hYm9ydCk7DQo+ID4NCj4gPiArICAgIGlmIChhbWMtPmkyY19pbml0KSB7DQo+ID4g
KyAgICAgICAgYW1jLT5pMmNfaW5pdChibWMpOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAg
ICBhcm12N21fbG9hZF9rZXJuZWwoQVJNX0NQVShmaXJzdF9jcHUpLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICBtYWNoaW5lLT5rZXJuZWxfZmlsZW5hbWUsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgIDAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIEFTVDEwNDBfSU5U
RVJOQUxfRkxBU0hfU0laRSk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYXN0MTA0
MF9ldmJfaTJjX2luaXQoQXNwZWVkTWFjaGluZVN0YXRlICpibWMpIHsNCj4gPiArICAgIEFzcGVl
ZFNvQ1N0YXRlICpzb2MgPSBibWMtPnNvYzsNCj4gPiArDQo+ID4gKyAgICAvKiBVMTAgMjRDMDgg
Y29ubmVjdHMgdG8gU0RBL1NDTCBHcm91cCAxIGJ5IGRlZmF1bHQgKi8NCj4gPiArICAgIHVpbnQ4
X3QgKmVlcHJvbV9idWYgPSBnX21hbGxvYzAoMzIgKiBLaUIpOw0KPiANCg0KSSB3aWxsIGNoYW5n
ZSBpdCB0byAyNTYgaW4gdjMuDQoNCklmIHlvdSB3b3VsZCBwcmVmZXIgdG8gdXNlIFNNQlVTX0VF
UFJPTV9TSVpFLCBJIGNhbiBoYW5kbGUgdGhhdCBpbiBhIHNlcGFyYXRlIGNsZWFudXAgcGF0Y2gg
c2VyaWVzOg0KDQpNb3ZlICNkZWZpbmUgU01CVVNfRUVQUk9NX1NJWkUgMjU2IHRvIGluY2x1ZGUv
aHcvaTJjL3NtYnVzX2VlcHJvbS5oLg0KVXBkYXRlIHRoZSBBU1BFRUQgbWFjaGluZSBtb2RlbHMg
dG8gdXNlIFNNQlVTX0VFUFJPTV9TSVpFIGluc3RlYWQgb2YgaGFyZC1jb2RlZCBFRVBST00gYnVm
ZmVyIHNpemVzLg0KDQpJIGFsc28gbm90aWNlZCB0aGF0IHNldmVyYWwgQVNQRUVEIG1hY2hpbmUg
bW9kZWxzIGN1cnJlbnRseSB1c2UgaW5jb25zaXN0ZW50IEVFUFJPTSBzaXplczoNCg0KaHcvYXJt
L2FzcGVlZF9hc3QxMDQwX2V2Yi5jOiAgICAgICAgICAgICAgICBTTUJVU19FRVBST01fU0laRQ0K
aHcvYXJtL2FzcGVlZF9hc3QyNTAwX3N1cGVybWljcm8teDExc3BpLmM6ICAzMiAqIDEwMjQNCmh3
L2FybS9hc3BlZWRfYXN0MjQwMF9zdXBlcm1pY3JveDExLmM6ICAgICAgMzIgKiAxMDI0DQpody9h
cm0vYXNwZWVkX2FzdDI1MDBfZXZiLmM6ICAgICAgICAgICAgICAgICA4ICogMTAyNA0KaHcvYXJt
L2FzcGVlZF9hc3QxMHgwX2V2Yi5jOiAgICAgICAgICAgICAgICAzMiAqIDEwMjQNCmh3L2FybS9h
c3BlZWRfYXN0MjYwMF9ldmIuYzogICAgICAgICAgICAgICAgIDggKiAxMDI0DQpody9hcm0vYXNw
ZWVkX2FzdDI0MDBfcGFsbWV0dG8uYzogICAgICAgICAgIDMyICogMTAyNA0KaHcvYXJtL2FzcGVl
ZF9hc3QyNTAwX3dpdGhlcnNwb29uLmM6ICAgICAgICAgOCAqIDEwMjQNCg0KRG8geW91IG1lYW4g
dGhhdCB3ZSBzaG91bGQgdXBkYXRlIGFsbCBvZiB0aGVzZSBBU1BFRUQgbWFjaGluZSBtb2RlbHMg
dG8gdXNlOg0KDQp1aW50OF90ICplZXByb21fYnVmID0gZ19tYWxsb2MwKFNNQlVTX0VFUFJPTV9T
SVpFKTsNCg0KaW5zdGVhZCBvZiB0aGUgY3VycmVudCBoYXJkLWNvZGVkIHNpemVzPw0KDQpUaGFu
a3MsDQpKYW1pbg0KPiANCj4gVGhlIHNtYnVzLWVlcHJvbSBkZXZpY2UncyBpbnRlcm5hbCBidWZm
ZXIgaXMgMjU2IGJ5dGVzLg0KPiANCj4gV2UgaGF2ZSBiZWVuIGNvcHkvcGFzdGluZyB0aGlzIDMy
ICogS2lCIHNpemUgZm9yIGEgd2hpbGUgaXQgc2VlbXMgYnV0DQo+IFNNQlVTX0VFUFJPTV9TSVpF
IHdvdWxkIGJlIGVub3VnaC4NCj4gDQo+IEFueWhvdywNCj4gDQo+IA0KPiBSZXZpZXdlZC1ieTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQo+IA0KPiANCj4gPiArICAgIHNtYnVzX2VlcHJvbV9pbml0X29uZShhc3BlZWRfaTJj
X2dldF9idXMoJnNvYy0+aTJjLCAwKSwgMHg1MCwNCj4gPiArIGVlcHJvbV9idWYpOw0KPiA+ICsN
Cj4gPiArICAgIC8qIFUxMSBMTTc1IGNvbm5lY3RzIHRvIFNEQS9TQ0wgR3JvdXAgMiBieSBkZWZh
dWx0ICovDQo+ID4gKyAgICBpMmNfc2xhdmVfY3JlYXRlX3NpbXBsZShhc3BlZWRfaTJjX2dldF9i
dXMoJnNvYy0+aTJjLCAxKSwNCj4gPiArInRtcDEwNSIsIDB4NGQpOyB9DQo+ID4gKw0KPiA+ICAg
c3RhdGljIHZvaWQgYXNwZWVkX21hY2hpbmVfYXN0MTA0MF9ldmJfY2xhc3NfaW5pdChPYmplY3RD
bGFzcyAqb2MsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IHZvaWQNCj4gKmRhdGEpDQo+ID4gICB7DQo+ID4gQEAgLTU1LDYgKzcy
LDcgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX21hY2hpbmVfYXN0MTA0MF9ldmJfY2xhc3NfaW5p
dChPYmplY3RDbGFzcyAqb2MsDQo+ID4gICAgICAgYW1jLT5od19zdHJhcDEgPSAwOw0KPiA+ICAg
ICAgIGFtYy0+aHdfc3RyYXAyID0gMDsNCj4gPiAgICAgICBtYy0+aW5pdCA9IGFzcGVlZF9iaWNf
bWFjaGluZV9pbml0Ow0KPiA+ICsgICAgYW1jLT5pMmNfaW5pdCA9IGFzdDEwNDBfZXZiX2kyY19p
bml0Ow0KPiA+ICAgICAgIG1jLT5kZWZhdWx0X3JhbV9zaXplID0gMDsNCj4gPiAgICAgICBhbWMt
Pm1hY3NfbWFzayA9IDA7DQo+ID4gICAgICAgYW1jLT51YXJ0X2RlZmF1bHQgPSBBU1BFRURfREVW
X1VBUlQxMjsNCg0K

