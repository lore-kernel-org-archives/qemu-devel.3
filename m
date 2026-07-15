Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C09C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjuVv-0005VC-06; Wed, 15 Jul 2026 03:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjuVn-0005Uv-GN; Wed, 15 Jul 2026 03:58:35 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjuVk-0004MG-Ss; Wed, 15 Jul 2026 03:58:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvPusB3wE18uK4vYWFrM1aIybrLpzdynOuLFh7igzw1cO/MHxd2a+e+g4tV6+o3vned3moch35x54J8kK5rYpJREYbpt0amUKqUeokxIi/nofXkiRm/pjbYjOLgp2pHi7PNFV7x6eTLXcT3n3Jgk7Z97gdsCD+mDZuTRKcfGaFev7DEWhZJ25jYS+LwSwyEJ729QLOiSYYdtR5bP5qdCll5QAx5uJt0g4I+GTPbrCiSvkgzCO81qWhMpjh6mq/prQ8G7qNpYtlxkIPUFGDzl2O9P8+QGqG/aHrcWv5sNPZPwQid46mlgZUI1414CWkZQ2kAKREOqc5VJhgvsK3/8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aji1qEboEJMWzbdsBDBQq9KuklElRKbw8ut9lzr87nQ=;
 b=D2sjDJWW+AdB/rPpQbmQr1Nbc/ZTWoSv/TxdkI6cUJrDAOLgkPY/f9u5DcutD3k1XA6LybcnpZJ5JtwcGTGLU3xhDWs22ixDFhGcShJZJyyZq+jDE6XuVArKQxzvUAtgBgqb6FtiivYr2ZbAsPS6m2La+5Yn+w/XuZbWWySwGEEE/o8Y1gwt+sds5TczURuMI9JiC9g4tHbCJETg+ES4F3sC7jQwGoYKi4ddh5WTnAIglJPZT7kFVC9/TERvqnj9CJeuz6pFRo0ry4TV3HCMb4MFr2da+V+ES4r/uvISEf9YD/tHiQ1a5XTzQk8Cf5MwjZjIIyDARWtCZ3nxM8eMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aji1qEboEJMWzbdsBDBQq9KuklElRKbw8ut9lzr87nQ=;
 b=bdf5JJ3och3cZ3pxmWWEz4/17uAiRBB0ogNa/pDnkxEbN9cUjbR8+J760fXZsFZ1aknzWmCM0OzfeirMc89uWippl4uRXzyTHXFSXJRgphmTe/7AQbo9Ms2txcHaH0dtRZJPNTSN3Zb1V7zqnkKjTAVToY/Pgzxx2QadoLQ+VHoSc5riC0QdnIAXm2/BHs+R9V2rPiC3Ej47qrYQAIO/bdAJ/ESESpz0ipoK1/8Gn6gUr4JYhbvEcFQb1Szi9BZHM7MWRVrZyLoi+vN5M3eEqh46UZJPUrP+tP7Aiz1br6RwDPzcDyPSc1kdwe2sWDciHZf1c/3nCTe20ck2ZI1nMw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5388.apcprd06.prod.outlook.com (2603:1096:4:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 07:58:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:58:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Topic: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Index: AQHdDdctc0cnKqefhUew9zJXrM01CrZtVxOAgADp9KA=
Date: Wed, 15 Jul 2026 07:58:19 +0000
Message-ID: <TYZPR06MB4980058F16852B1E754F2DFFFCF82@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-9-jamin_lin@aspeedtech.com>
 <bf6d933b-c15b-45ca-b20f-62b786e3d434@kaod.org>
In-Reply-To: <bf6d933b-c15b-45ca-b20f-62b786e3d434@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5388:EE_
x-ms-office365-filtering-correlation-id: df895057-939b-45bf-9a30-08dee246d5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|921020|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info: 3nG+4+WlQqw9dYmGiB/L6fFrlC2eeSNZicGDZkYX3Eex2AE7um5nGdsQkKCh1qVM4Vtz86KQWbnODSl1g9EWOk696nNFCL/Zh/tsqO6PoywGnSxlv9ew3YYbubqOrw6I+F77ynxKKEej4z9JdNjhF4TvRHjbjAS7MA+yLrwS1rZ7Wuz3VoDR8it0zp2A4ymfMLHmkZzmhFmF9S0ck7cgYWD1uycFbEvrDBSe+KLYkufbsakDixJFsdBLtT+4qJNPdWyPKmOAxa38yNRDTniCumTEea0WrYs0/ygKxpDDFs4fmUCPFK2+ZeedI+Ne+gKS/8ppYMHiskU7+kIbA8pyfosbDPRTL+8Do77c2lVqMniv0lbmjVx0TRtxvvG76T+r1IarEthC0p9Q35UXzAzDT2NTiEkfFxIUylbGw7ntsFjUbtKnkc5UuATkpxd3cS3GdPb8RpLcz7KdXoiZxyE65mBEl4XmuGazuxChw2YoAP5maaSsCg3qGq+9qUWjJCpUrwSXoyjnzLUseXXOg/juspr28LunoOinAvnL2p9IHMn1ld7M95gTmyIxv3/l5L9ZX1Osv7n9UqSd/pCvOFybxkwMEQ5SFaAXk+SK/vJ/oddQ+VknsWwrOPDlprT3Sw4piERMck0qOjdG89NdkxD2DKz90wNISJVqu2OHFo49M/T4/xKSTeOJglJvmo3Rcgrt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhlWDR2dk9aZHJYWXZ1QjY5NTRPeEJPbEVjWTJtY2tDaTJyMEhMekpOc0VE?=
 =?utf-8?B?clhUcWFGWXBEUVVlWktmT2RWckQwWmZyUU9nN3pjWXdhNGhqbjU4OWlpcnlj?=
 =?utf-8?B?WEtTMWs2UHpyM2t0dSt1MW9tMVdrbTFBUGIrK0tBb2dSZnVoaVdYTmZtbGVE?=
 =?utf-8?B?V0Y0U2VwbmdRU1BkV2lzcmgwYms3VVRNbVFuZnBZeDZrV3liaUVnd25zWnZl?=
 =?utf-8?B?Si9rNmYrK0pFMmM2UHdmMEY2SlpBOEd3VURscWoxelcwR3htazVmbEQwaDRo?=
 =?utf-8?B?WFZwV0draG1BZ1Q3a0t3dnR4NWJiUXVibDB5TkpaYlFPQ0o0ZmNxVTNFWW9o?=
 =?utf-8?B?K0VjTElqMlpjR2VYeWFkR2tyTlNNcVVEdnl0K0hDQjFDcmMycVRaVk5IUW9l?=
 =?utf-8?B?MEFMSE02bU81VGtBaVdINng5aFJsNjBLQ3hpV0JWNFowZ0E1emJ5TjU2TDFI?=
 =?utf-8?B?NElLbGFKQkZMWitNeGtuWmVJS3d4M2NRbEFFdHBhN0E1ZjlSWENaS3o4UzdV?=
 =?utf-8?B?RWwzRDlqZlVISFdNT3AvWkJuWVZUdHhpRDNUMWZIaUN1NDFFalE2ZjFieGxz?=
 =?utf-8?B?S1FNL1RiT0ZISTU3VGZsQmJ0dXBKUlZIYXpMN0ZCL2lLRk82M09aeXBkdEdR?=
 =?utf-8?B?cGpDa2xEd0dJQjJlcHd5dU5ZMm9Zb1o2TG9rL01zR2xkWUpWRmpYRS9wcjdI?=
 =?utf-8?B?VmsvSVhaU1ZQSWVwNS9YaThZekhseEhXSDBURlo5a3ViakxLdlBGbGNxS1dz?=
 =?utf-8?B?U0RTRDl1UUVUTlJJNkMrS3hZK3d1NEhVOHB5aEU2YWU5S0tsTFYvRlBSZHQz?=
 =?utf-8?B?SDhFWFpIMldUazFmWGNDS3QxZmh1ejgrekJnSDloTGVGVjVSazc5cnl1ZW9X?=
 =?utf-8?B?LzdtMG9CNEYzRWRyNWhPUDhYUzJhenpGY3pZa1U5VDEwdXNSS2JnazZOcDRT?=
 =?utf-8?B?bjg3K1pqUTRpUmpqR3lDK3RkTG0rdTMyNDZLUUJzanFWcHRZV0U4VG04WnpL?=
 =?utf-8?B?TWxBM3hpWldSSnk1dStianpoZDFWSmowWElnc0hVN0NzWnZwMVFjZS93TWM5?=
 =?utf-8?B?N2d3ZDBzTUNGNjU1a2ZKK1dIRDYrNTZjZE1TYkhPOVNnYnYxbEI5SHF6N3Nl?=
 =?utf-8?B?MEI3d1M4cUNPMXZrT1Y5Vm1UTGQ4V1g1YUI4RzVwYXM5K3dvV1Z3eTU0c0ph?=
 =?utf-8?B?amRuUmRlSXBueEgrM2dqQWEwSmVBVTZkeTlUeVR3NXArRXlzVXp0OE8waThB?=
 =?utf-8?B?OG9GUWxPelhXd1hScTZsVUsyWndUYTFBTHlPdUgrUEdndGIycTg0SzBnZWha?=
 =?utf-8?B?TVU2WE1vNTNoVUZTcDNtaTFpZDhCWGo1TmhHNkpKbXhzdFVwQkZBZzNKakRW?=
 =?utf-8?B?bDh0WElVcG9TTi9QOWdja0R2YndMak9HNkRXMEwvWmpSWHVSemJ0aWl1bnA0?=
 =?utf-8?B?WkU1cTMwTExIY1dpUFBqaGt5ZFpDSWRVNzNRS1FsMXhZWW1pZ3F1U25ST1B4?=
 =?utf-8?B?UVphT3I4S0E1OUVJYjlWOFBEZzZvQXk4NjQxTWRscmpuamdZQ3kwQVkwOE1U?=
 =?utf-8?B?Umx0MmZabGlaeVlSS3EyLzdhYVhycmNkTGF6M3B2TmMzVkx2TGEwck0wZXht?=
 =?utf-8?B?Z05BV3ZhNVM1VTdRZ2Mzb3lNc1ZMNzlHL0VtTEJoTG5xSTVwQndxNXdnREZS?=
 =?utf-8?B?NitEY2hjUkRoOFROSWhRM0dPQlo4eXY0eG9ERlpzWDhNM2lqS0VxMFVrKzNV?=
 =?utf-8?B?NVZoWEdSeE4xZkh0UnUrMGpDKzkrNzZjdmVRY3ZkVTJMYVR4dC9IZkQxN0t3?=
 =?utf-8?B?SnNXMlNReXMwRklYVUlhYk5OUU5MNXN3TmNLOXV0MWoyVjJybTBFN041TVV1?=
 =?utf-8?B?Z2twM0k1NXhwWlEwaFVwTGttQVVJRXRqRUIzeTZnalUwQ3hHNGNINlA2Z3BN?=
 =?utf-8?B?UEVYdDJYT25VOUNCTjNvNVcxWHV1VUtZaWYxMWcyMDlySHdPSWRiNU1jcUs5?=
 =?utf-8?B?WVNta2g3bWVPZ3pDRklJRnpESVVIV2E2SnFwa0EyREpTcG55L0xHdmg5b2RN?=
 =?utf-8?B?Q1F4ZU0wbnJwMm9Hd3FXOUZ1YVpsRzhjZXZrQWpmb3VlV2N2bG4vdThkdyth?=
 =?utf-8?B?QlpBK2hiYnJIQ2U2SEMxMERiYndtZnZ3WDlYamdWMVlLYjNUWWJRT2VZUkE1?=
 =?utf-8?B?TGt2aU8rL0U0TFlROENvQ05OOGZrcHVCV3BjVVNmL2dmVHl1bEVuUjdlWGZv?=
 =?utf-8?B?czIvcnRFNERRcWc1dFRab3F2MGd6Y2FoWUgvb2NaZ3I0NDM0d2MzbElMMmRW?=
 =?utf-8?B?Y3VzM2Z4MWp0Y0lVdkpLZEFQVkh1aXE0RUVtYkxkVVBidTRDSDFzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c58PJvpgCUpII5PgLjmIjIJZRmUa+re+imao90sqJ+7ejoSTe+iZZa7LbeQyFei+2soDl8MvhG+vbQwpk2qThHY2udKKTBvz+V3BUKQNFfN+PY4aAy2n+vc8mDFUYjNTx5kWM2k3/fDpCgvIoQXwxrnbUCj7wew9fMuePZjjWRG2Uqsj2gBRqjk8MnwnK3sBnN6dziPei4cB2HneU5JNEs1/kbhWa2rnUu/wmRYNvOKyhcrZCKV5qeOewErXwIzyC6nQpsrmlqBA1zrtbJfBSVcI1N72NPc036FNcORzi96UdhGPvdrJXp6pLTqMBS6puXQ2FYwxWYmXY4FD2EHofg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df895057-939b-45bf-9a30-08dee246d5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 07:58:19.5164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vW+qpwI3upJMPPfqdbbDHDSHQpeofDQqqGCSeN7cTQSWKN4VOtARSe67df+UCYSqr3FJBpVtQPEEoqibbFZAL3MWjmW++ZCgKKBNLO7a75U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5388
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgOC84XSBody9zc2kvYXNwZWVk
X3NtYzogQWRkIERhdGEgRklGTy1iYXNlZCBmbGFzaA0KPiBhY2Nlc3Mgc3VwcG9ydCBmb3IgQVNU
MjcwMA0KPiANCj4gT24gNy83LzI2IDA4OjA5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQVNUMjcw
MCBzdXBwb3J0cyBhIERhdGEgRklGTyBtb2RlIHdoZXJlIGZsYXNoIGFjY2Vzc2VzIGNhbiBiZQ0K
PiA+IHBlcmZvcm1lZCBkaXJlY3RseSB0aHJvdWdoIERhdGEgRklGTyBNTUlPIG9mZnNldHMuIFRo
ZSBEYXRhIEZJRk8gc3RhcnQNCj4gPiBvZmZzZXQgaW5jcmVtZW50cyBieSBvbmUgZm9yIGV2ZXJ5
IDE2TUIgb2YgZmxhc2ggYWRkcmVzcyBzcGFjZSwNCj4gPiBhbGxvd2luZyB0aGUgY2hpcCBzZWxl
Y3QgKENTKSB0byBiZSBkZWNvZGVkIGZyb20gdGhlIERhdGEgRklGTyBvZmZzZXQuDQo+ID4NCj4g
PiBUaGlzIGNoYW5nZSBhZGRzIERhdGEgRklGTyBzdXBwb3J0IHRvIHRoZSBBc3BlZWQgU01DIG1v
ZGVsIGFuZA0KPiA+IGludHJvZHVjZXMgYSBjbGFzcyBjYWxsYmFjayB0byB0cmFuc2xhdGUgRGF0
YSBGSUZPIG9mZnNldHMgaW50byBDUw0KPiA+IGluZGljZXMuIEZvciBBU1QyNzAwLCB0aGUgRGF0
YSBGSUZPIG9mZnNldCBpcyBtYXRjaGVkIGFnYWluc3QgdGhlDQo+ID4gc2VnbWVudCBzdGFydCBh
ZGRyZXNzIG9mIGVhY2ggQ1MgdG8gZGV0ZXJtaW5lIHRoZSB0YXJnZXQgZmxhc2ggZGV2aWNlLg0K
PiA+DQo+ID4gVGhlIFNNQyByZWdpc3RlciByZWdpb24gc2l6ZSAobnJlZ3MpIGlzIGFsc28gZXh0
ZW5kZWQgZHluYW1pY2FsbHkNCj4gPiBiYXNlZCBvbiB0aGUgbnVtYmVyIG9mIHN1cHBvcnRlZCBj
aGlwIHNlbGVjdHMgdG8gY292ZXIgYWxsIHBvc3NpYmxlDQo+ID4gRGF0YSBGSUZPIHJlZ2lvbnMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvc3NpL2FzcGVlZF9zbWMuaCB8ICAgMyAr
LQ0KPiA+ICAgaHcvc3NpL2FzcGVlZF9zbWMuYyAgICAgICAgIHwgMTEzDQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMDcgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IEkgYW0gbG9va2luZyBmb3IgYSB3YXkg
dG8gdGVzdCAiRGF0YSBGSUZPLWJhc2VkIGZsYXNoIGFjY2VzcyIuDQo+IEEgcXRlc3QgZXh0ZW5z
aW9uIG9mIHRoZSBhc3QyNzAwIHNtYyB0ZXN0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZS4NCj4gDQpX
aWxsIGRvLg0KDQo+IElzIHRoZSBsYXRlc3QgU0RLIGtlcm5lbCB1c2luZyB0aGlzIGZlYXR1cmUg
Pw0KPiANClllcy4gUGxlYXNlIHRyeSB0aGUgZm9sbG93aW5nIHByZS1idWlsdCBpbWFnZToNCmh0
dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2Fk
L3YxMS4wMi9hc3QyNzAwLWlyb3Qtb2JtYy50YXIuZ3oNCg0KVGhlIGltYWdlLWJtYyBmaWxlIGlu
IHRoZSBhcmNoaXZlIGlzIHNtYWxsZXIgdGhhbiAxMjggTUIuIFNpbmNlIHRoZSBRRU1VIEZNQyBm
bGFzaCBtb2RlbCBleHBlY3RzIGEgMTI4IE1CIGZsYXNoIGRldmljZSwgcGxlYXNlIHJlc2l6ZSBp
dCBiZWZvcmUgdXNpbmcgaXQ6DQoNCmphbWluQEphbWluTGluLVBDOn4vcWVtdS13b3JrL2RlYnVn
LXFlbXUtc3NwLXJldmlldy9hc3QyNzAwLWlyb3QkIHRydW5jYXRlIC0tc2l6ZSAxMjhNIGltYWdl
LWJtYw0KDQpUaGlzIHByZS1idWlsdCBpbWFnZSBib290cyBib3RoIHRoZSBQU1AgYW5kIFNTUC4N
Cg0KQWZ0ZXIgdGhlIHN5c3RlbSBib290cywgbG9nIGluIHRvIHRoZSBaZXBoeXIgc2hlbGwgcnVu
bmluZyBvbiB0aGUgU1NQIGFuZCB1c2UgdGhlIGZvbGxvd2luZyBjb21tYW5kIHRvIHJlYWQgdGhl
IGNvbnRlbnRzIG9mIHRoZSBGTUMgQ1MwIGZsYXNoOg0KDQpzc3A6fiQgZmxhc2ggcmVhZCBmbWNA
MCAwIDEwMA0KMDAwMDAwMDA6IDQ2IDRjIDUzIDQ4IDAxIDAwIDExIDAwICBhYSAyNiA4NyAwMCBm
OSA2NCA4MCA3OSB8RkxTSC4uLi4gLiYuLi5kLnl8DQowMDAwMDAxMDogMDEgMDAgMDAgMDAgZGMg
MDAgMDAgMDAgIDc0IGE2IDAxIDAwIDAyIDAwIDAwIDAwIHwuLi4uLi4uLiB0Li4uLi4uLnwNCjAw
MDAwMDIwOiA1MCBhNyAwMSAwMCA4NCAzZSAwMCAwMCAgMDMgMDAgMDAgMDAgZDQgZTUgMDEgMDAg
fFAuLi4uPi4uIC4uLi4uLi4ufA0KMDAwMDAwMzA6IDYwIGNlIDAyIDAwIDAwIDEwIDAwIDAwICAz
NCBiNCAwNCAwMCBkOCA3NyAwMCAwMCB8YC4uLi4uLi4gNC4uLi53Li58DQowMDAwMDA0MDogMDEg
MTAgMDAgMDAgMGMgMmMgMDUgMDAgIDAwIDAwIDAxIDAwIDAyIDEwIDAwIDAwIHwuLi4uLiwuLiAu
Li4uLi4uLnwNCjAwMDAwMDUwOiAwYyAyYyAwNiAwMCBiOCA3NCAwMCAwMCAgMDMgMTAgMDAgMDAg
YzQgYTAgMDYgMDAgfC4sLi4udC4uIC4uLi4uLi4ufA0KMDAwMDAwNjA6IDAwIDAwIDAxIDAwIDA0
IDEwIDAwIDAwICBjNCBhMCAwNyAwMCA1NCBjZiAwMCAwMCB8Li4uLi4uLi4gLi4uLlQuLi58DQow
MDAwMDA3MDogMDUgMTAgMDAgMDAgMTggNzAgMDggMDAgIDAwIDAwIDAxIDAwIDA2IDEwIDAwIDAw
IHwuLi4uLnAuLiAuLi4uLi4uLnwNCjAwMDAwMDgwOiAxOCA3MCAwOSAwMCAwMCA0MCAwMCAwMCAg
MDcgMTAgMDAgMDAgMTggYjAgMDkgMDAgfC5wLi4uQC4uIC4uLi4uLi4ufA0KMDAwMDAwOTA6IDAw
IGEwIDAwIDAwIDA4IDEwIDAwIDAwICAxOCA1MCAwYSAwMCA2YyA3MCAwMCAwMCB8Li4uLi4uLi4g
LlAuLmxwLi58DQowMDAwMDBBMDogMDkgMTAgMDAgMDAgODQgYzAgMGEgMDAgIDkwIGFjIDA2IDAw
IDBhIDEwIDAwIDAwIHwuLi4uLi4uLiAuLi4uLi4uLnwNCjAwMDAwMEIwOiAxNCA2ZCAxMSAwMCA1
OCA4MiAwZCAwMCAgMGIgMTAgMDAgMDAgNmMgZWYgMWUgMDAgfC5tLi5YLi4uIC4uLi5sLi4ufA0K
MDAwMDAwQzA6IDZjIDNlIDAzIDAwIDBjIDEwIDAwIDAwICBkOCAyZCAyMiAwMCAwMCAwMCAwMCAw
MCB8bD4uLi4uLi4gLi0iLi4uLi58DQowMDAwMDBEMDogMGQgMTAgMDAgMDAgZDggMmQgMjIgMDAg
IDM0IDk5IDc1IDAzIDQzIDRkIDQxIDRlIHwuLi4uLi0iLiA0LnUuQ01BTnwNCjAwMDAwMEUwOiBm
YyAxNiAwMCAwMCA1ZiAxOSA0OSBmYyAgYTYgNmEgOGQgNjYgZTYgMjYgODAgODcgfC4uLi5fLkku
IC5qLmYuJi4ufA0KMDAwMDAwRjA6IGUzIGYwIDQ4IDJhIDNiIDAxIGIwIDYzICBmZSBjZiAwYSBh
MyAyMCA1NiBmMSA2MiB8Li5IKjsuLmMgLi4uLiBWLmJ8DQoNCllvdSBjYW4gdGhlbiBjb21wYXJl
IGl0IHdpdGggdGhlIGJlZ2lubmluZyBvZiB0aGUgaW1hZ2UtYm1jIGZpbGUgb24gdGhlIGhvc3Q6
DQoNCmphbWluQEphbWluTGluLVBDOn4vcWVtdS13b3JrL2RlYnVnLXFlbXUtc3NwLXJldmlldy9h
c3QyNzAwLWlyb3QkIHh4ZCBpbWFnZS1ibWMgfCBoZWFkDQowMDAwMDAwMDogNDY0YyA1MzQ4IDAx
MDAgMTEwMCBhYTI2IDg3MDAgZjk2NCA4MDc5ICBGTFNILi4uLi4mLi4uZC55DQowMDAwMDAxMDog
MDEwMCAwMDAwIGRjMDAgMDAwMCA3NGE2IDAxMDAgMDIwMCAwMDAwICAuLi4uLi4uLnQuLi4uLi4u
DQowMDAwMDAyMDogNTBhNyAwMTAwIDg0M2UgMDAwMCAwMzAwIDAwMDAgZDRlNSAwMTAwICBQLi4u
Lj4uLi4uLi4uLi4uDQowMDAwMDAzMDogNjBjZSAwMjAwIDAwMTAgMDAwMCAzNGI0IDA0MDAgZDg3
NyAwMDAwICBgLi4uLi4uLjQuLi4udy4uDQowMDAwMDA0MDogMDExMCAwMDAwIDBjMmMgMDUwMCAw
MDAwIDAxMDAgMDIxMCAwMDAwICAuLi4uLiwuLi4uLi4uLi4uDQowMDAwMDA1MDogMGMyYyAwNjAw
IGI4NzQgMDAwMCAwMzEwIDAwMDAgYzRhMCAwNjAwICAuLC4uLnQuLi4uLi4uLi4uDQowMDAwMDA2
MDogMDAwMCAwMTAwIDA0MTAgMDAwMCBjNGEwIDA3MDAgNTRjZiAwMDAwICAuLi4uLi4uLi4uLi5U
Li4uDQowMDAwMDA3MDogMDUxMCAwMDAwIDE4NzAgMDgwMCAwMDAwIDAxMDAgMDYxMCAwMDAwICAu
Li4uLnAuLi4uLi4uLi4uDQowMDAwMDA4MDogMTg3MCAwOTAwIDAwNDAgMDAwMCAwNzEwIDAwMDAg
MThiMCAwOTAwICAucC4uLkAuLi4uLi4uLi4uDQowMDAwMDA5MDogMDBhMCAwMDAwIDA4MTAgMDAw
MCAxODUwIDBhMDAgNmM3MCAwMDAwICAuLi4uLi4uLi5QLi5scC4uDQoNClRoZSBjb250ZW50cyBy
ZWFkIGZyb20gdGhlIGVtdWxhdGVkIGZsYXNoIHNob3VsZCBtYXRjaCB0aGUgY29ycmVzcG9uZGlu
ZyBkYXRhIGluIGltYWdlLWJtYw0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+
IEMuDQoNCg==

