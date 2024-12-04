Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10193E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIkCn-0000CE-68; Wed, 04 Dec 2024 02:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tIkC4-0008BD-Lm; Wed, 04 Dec 2024 02:53:12 -0500
Received: from mail-sg2apc01on20709.outbound.protection.outlook.com
 ([2a01:111:f403:200f::709]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tIkC0-0002JB-Ew; Wed, 04 Dec 2024 02:53:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6ybWRLZiItrEl2ZZPYzA2Fu2HIcnBJeCyydHVIPupUQVh+Rn29JtubsEQno0XdKqqHwEZM+jlunh+9TM6cz43DumAdVJnasYrFPI/x8n179DQSYP3VT2R205Uv1pQ2FNahnPX/Dm7tCsLZUGZGa7qAk+pfBx1OoaUZ6kU4NUs12rE3o7iTCPleEZ7+QfwgdOk6YLFYk54t9dkdYPNgfqJYz2knDs0plSn4JQKFPyS55WdgpZd0PX4cwxnr19bftY41SKjT+wj/SQMsd6r+X4I43Im/tIM2fTOYpWxZFisgi8z7HuvoFYHOp69T0Gus9am+iC0Xr9UfJ94pqbD4WFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWTfSt/nJk/gKcAkHoNjyJWjW86ndRDhLhH0QO44B8k=;
 b=urlo+uI1fjLOFDh3tQ6Otc7oMRXRADQIFXHfbTQAMFJcKNT4JYvEiuF/rwgO80jvnEZIYhh/mui0svU9yna3ZrKstF/Gx4s3e3UdJSa0HeSg6KSx6Qfsi0XXuz7lvQ/5Tmd/7DlfpgdM++RuhRKfN4AuIa+vewwy57BcTCwhokH4dOu5md/49YaHaXrdFxpfiOvamkOChNtoy2ysJn3gJVIWOVLKUCtAeONqw8vHnihNsYdY49w6yGe9cbiYUgnmp1v95hPdbQXQrD8ZnAmDgy3tTbECvFxugDT7VTAXOWAPEUNfpXCvMzX5lMLJSRoVgP4Z7HhRO77m3X1B7tZzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWTfSt/nJk/gKcAkHoNjyJWjW86ndRDhLhH0QO44B8k=;
 b=nki/0PbI4B2Nxbi+ylVztsPcwM7tjvoWYdINo/DL8Vg0IPtasB/MXUWV4dAPqUhvXmJjP6LxO4kpRcTopw9xoGza5tLqBfNe0SSeYnJsVSccDG3CDrjKhj2T/wMWZioNt9QJyU671+Yb9S1uggVVjJY7q46qRtLgnMjNwyEIOOiikJRfq47ChpCJGDy1NN1QX1FXrgj4njEXvEt3YtWSxIXwiIde3SXzRcKNGYRFlZ0mA0YLuDVwf8Trqws6X/REiBx1ta9LPGj0j4MFozYsKwqgXr41QKPob20sDpCWguCkjE1R1yWAIxZFIIeGlRHgcDGNC5YKoEOznialmph1YQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 OSQPR06MB7181.apcprd06.prod.outlook.com (2603:1096:604:291::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.10; Wed, 4 Dec 2024 07:52:54 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8230.000; Wed, 4 Dec 2024
 07:52:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers.
Thread-Topic: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers.
Thread-Index: AQHbRSku2n2Tv9S1rkmdLgDvcmDNcbLUQXSAgAF3ESA=
Date: Wed, 4 Dec 2024 07:52:53 +0000
Message-ID: <SI2PR06MB5041C7F608ADD7A0FAB3A102FC372@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241203021500.3986213-1-jamin_lin@aspeedtech.com>
 <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
 <86e4b6d7-aaa1-423d-958e-28cf37022b8a@linaro.org>
In-Reply-To: <86e4b6d7-aaa1-423d-958e-28cf37022b8a@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|OSQPR06MB7181:EE_
x-ms-office365-filtering-correlation-id: 8df88a00-b163-44f8-9f1e-08dd1438a8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXo1U1NQaHpQMXM2a2NzVnlDZFA3Rm0vRWdRUVdtbytLU2FIajNGNEZZdEpa?=
 =?utf-8?B?bC9GL2ZEYmRBM0lsRlFmei9oYmhXQkFMUENSTnNUNERzdUQwdnE5V2d6aE04?=
 =?utf-8?B?S1pyMk8vQTEycU04VUR2TXgrM0psUmFFQnV1ZS9sWjdCckwralp6UWNTNkFP?=
 =?utf-8?B?ekxadFNyeHA5dkQ1STU0dUtUc0pKVFhoK0NHWlZDTFJZUnFZMlJqamIwbGgw?=
 =?utf-8?B?VHphQmd6Q2Z2eXlMajN2WHhaRjl5MHQ4SmxDTWdHQ29yVkJoN1V3UGYyQ1VO?=
 =?utf-8?B?ZnloOUJrOEdlUkgxdGZGbE10OWVsaVQ2M1RXVEVKekJZa3FzODBKTXozOUZi?=
 =?utf-8?B?dVl4VWVxRUlRMWNFUUR0SjZhVmlrQ0NxVTh6M2dvaVg5Ri9uZVJ3ejc2QjN4?=
 =?utf-8?B?ck5ZMXVWaStoWGhTcmhJaUNjVjRVN3FUbjBlZktKeFdmL1d2ZC9WUVhyOUI0?=
 =?utf-8?B?a2NVQW1ITnlxdUhqTnhPU2ZCQk9JdzZ0QkQxR1d3anJUcXNRY3JlbzhWaHhq?=
 =?utf-8?B?djBOOUFrRVhLUXRVeG8xelFXWWE1enpMN1VGK2gxc0JQOFBQUkhtaWtZUFpV?=
 =?utf-8?B?ajYzQ2tFcDFpWTFJSytTR3FMczNiQlhVTkpoUGg5R3FWMDdGZnA0ZmU5Wkps?=
 =?utf-8?B?S2crbkNoY045RUpXS3UvSWV6akVEQ0RhdFFLRU5uenA0a0MrRFlTNkk5M1du?=
 =?utf-8?B?dTRwUW1NVlRrSmx0dFdZYTF5N0xqSkhFZ2dzaHM0MDNxM3ZzclU5U0FGV3pG?=
 =?utf-8?B?UjNTWEVZQldQT3JnOGRPeGduRHozOUJKblpKMkVIQjJaSXhUb2lzMGs3RnQ4?=
 =?utf-8?B?SHVYUkRlVnFXS003N0FGRUUvckhySVRxS1JlSTRYbVpYOEtzWktMbnFBOGs4?=
 =?utf-8?B?QmRzcGV4K0xaTnBJKy9ZN1QxaUdFSjBRN0FkdDZMWExiM1dsY2wxOGJzZnpm?=
 =?utf-8?B?TlJOdGxjRFByMHdmcmVqSjRNUlk3aXIvNksyUFMzZzB2WTZ4WU41MkQxeGRq?=
 =?utf-8?B?Yy95ZTQ3SWJ3TXRqVmdMS0JtaklsV1pkMU5yeE1qSExnVko1bXRzOTZrcStE?=
 =?utf-8?B?aXpOcFhRMStZNHhpaEVrd2p1ditBUVdqZms1dWlWL3d5LzdicDhJcnNrNzJ6?=
 =?utf-8?B?Vk9FcjVLTkxIWVhpMzIycG1IcVhweDcybUlkanIwNVpwd1hWWEZmS0R0dmZp?=
 =?utf-8?B?RHAzSUJIUVM5em5jc011clJPNWpUUFNVb1J6OE43UGk0WWhvT1ZwYndGajdS?=
 =?utf-8?B?TGRUUVJCemM0aGxMRlYwTXNXN3VaNDdUcU1kLzhQc0tZVUdQN3NMczRrbXVy?=
 =?utf-8?B?L09QM1EyeTdJaDdQdXhIa1ZLNVAwVmUzVHM4aFl3NHdwL1BWd0lMQjV2MlJj?=
 =?utf-8?B?eFVuVmZqUjdOYjFSWDFweVlsT1RVd1lJei9uS0ZYZ2pPUm9rVCtwY1AwNkZ5?=
 =?utf-8?B?L0picXl5RU5IQUFZaTc5VmdaNnNDY01jTlM4R3BGRzhrQUJ6UTcybnJFSXov?=
 =?utf-8?B?c1lZdlc1NFMyU2dUYW1CYy9pNlNJaVFGTWt3V0U5YjVtaTlyZ1kzUmZSL1lX?=
 =?utf-8?B?N1lGQ25oK3pJUVIvNStPRmIzNVpaVGdZZkJxSzh0RWM3VzV4Vk1oSTdFNm5t?=
 =?utf-8?B?QmdjMFpuQ29OSDdKV0MxdTdsSXFwUXZPdDFwZmtUajA4b0VYaUw2Z3BEa25C?=
 =?utf-8?B?T21QZGJGdmNxZWc5ZEt0YnBTQ0tlaE85UEc0aUkzdjVlaWN2QWRNdnllSjBW?=
 =?utf-8?B?SVZtQ01BQVJwSlhDU3pDWU9MYXJWcEdUOVRIQTQ2bU1GSkJOcmlXaFIxbFg2?=
 =?utf-8?B?M2dZdGNRTlBIdi9kUjRGTXN3aS9UUkdNVEJhS1pWYnkrdVN5bXEvSDdKU0NU?=
 =?utf-8?Q?VOlAjYuw7RzBM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnNrTm05RCtnNjlmNTVZcGV6cUt3SDZSWmNHZXgwQ0RvUlVpNHpUZGFaMU4r?=
 =?utf-8?B?QW01enpzK0VpREx6b3gxVGNsMXhHR1pYRXpYczhjNUZkLzE1a2pHcXl2d0ZK?=
 =?utf-8?B?S1NLRUZvU2U2aHhJSVkvY2ZEMjlXSCt4SE1jbnBXN0ZNbWpvd256STNOc3Vz?=
 =?utf-8?B?c2ZNcGFISHU3Vlg3MS8vNTZEaTRmNFBPWDF6aTVhQnFDS0xrOVV4VkNvdEVI?=
 =?utf-8?B?UXdZOUtycFZjdXAxb1RBcitoQlRNZW80S0dMMC9jYWptSTZ0VXNoM041MWhw?=
 =?utf-8?B?Z0FHQnNCZjkxUHBvM3dsMWdQU1Q1U0VONUl3eHlKMEVyTDZ4M1NlbW9mMWlz?=
 =?utf-8?B?MmZ3Qm9VcXRibGhldWNhZ3pHd1VyaVJYUHMvVTQwYjFQNHduMFh5NFpjMmRR?=
 =?utf-8?B?TzVFLzJyT0dWUi8zOHRWalJiN1FoN0tjZWdSU0dvM1QvZGNtYnBLMGQ2empi?=
 =?utf-8?B?TStNZmUwZVRGUzVIYUluMmJFbG1BREd4SlFvOUsyNHEwdDVTTTFMMXdwbXZM?=
 =?utf-8?B?ekNxV0trZ3dDQWZGL2J1cGJDallyZld0cVlrVDJUbUJOT21vdjloVk1aV0ZO?=
 =?utf-8?B?aE5xc0xtbi9UbzJseGNUTUh0SFd6U1hnL1lNS3JnZEUxcFp3RnpvTmNlR2lT?=
 =?utf-8?B?Z0dHaCsyOUZGK2FnN3JJcEFBY2VLMGJ3L0J0TDNXYVFyODlrTnhDL2sxR0pa?=
 =?utf-8?B?bUVyZHlaeFFnT0Zmbk9hVCtVQThmWWdwTjJDK09VaFkyK2RhL2ZpRW9YMStW?=
 =?utf-8?B?azdCallzdGprYTZWZGRLQXAwMytCSnFON3RxRDlRYWxlNFMwWkdDRlV2TXRo?=
 =?utf-8?B?akl2Vkw5Q2xOTmRrVnZVQVl1TDlYQUpsRllmOEk5bTVHanozY2ZuQzBmQlBQ?=
 =?utf-8?B?dG0yMytIMndlai9RN0Z4THdtRFpvdHhOcFFCeEozemY3ZnZDMWdacSt6V0Uy?=
 =?utf-8?B?a2YzTStRVytlbWM4R0lhMC9JNGd1UEtlTVVpQTU0N2pnUEEzWWVsOHFWRVZs?=
 =?utf-8?B?ZC9JUm5Tb2ZZVWVPaDV1K1g1Z3plbUJzSDA5VDRHajUxc2RlbzhuZ3dNZUZv?=
 =?utf-8?B?N1R3bmNmWlJDT05Bc0VQc21aekJKTzZTUGVzbHRka2VCcmZtTU5FZVV1V1pX?=
 =?utf-8?B?bDJJRDBXeldPMldnOVFUbTdlOU5nM1FESkpocVJOdkhqdFl5ei8rRm8vU3NL?=
 =?utf-8?B?dTU5SklJYm1yaE02TGl3bi9iV1dHei9HQlprU3grSmNyMWNPQXdMVXdLSXpp?=
 =?utf-8?B?OW9rbVc4UjNZM0ZNS1BRM2pGMndacnJnL3VmbXRoMHZIeVVZdTBjaWJXbUVw?=
 =?utf-8?B?VFMweVB0K1ZoS0JyUG9OZzl4Z3BoV2twb3JYeE4veGtjK1VqaFdxRkdTUjZj?=
 =?utf-8?B?VEpUZFJnRXREZXhNbnE4TmQxcGVyNnZhczlyVmdyRnJDQno5cU5rSVc2NzA4?=
 =?utf-8?B?b2d6L1QrSEFPSStRcUZCYnkvM2ExWVJNMUkvL3ZLQ2srbHNvTktmSFA1UTdp?=
 =?utf-8?B?YlprdHZQVXA2MDlIRHBodlZ4UkpPMy9qNitEbzNCWUx4bWdjM1RrM0RNY1Z6?=
 =?utf-8?B?eEE5cTQ2N1NkVWZ1MzI1cFc1VUZpaEhzSXFoZk5XVHhuYndWRlBia1RUY3l6?=
 =?utf-8?B?ak5rR1kwTEF0NXgzZ1did0JsREw1K3lhOFFUcitsQVgyeTNrOGJ2Mk93Z2VY?=
 =?utf-8?B?c0NzcEhkTWpaRXpBL2dxdFcrdXZWK3dBMTVrbXdYZ09wWUtiRGRzUHBVZU4v?=
 =?utf-8?B?ZW1WczI2U2ZRZCtVSTF0TUlQQVcvRnBaNlZMNmVRNXFiSFlCSHV4cklIOW9q?=
 =?utf-8?B?M1RyQmo4TWRNTHVoSVhQRkZVcG5ZM2dYWlA2U1lPbnRoclp6N2w2bnRidlFj?=
 =?utf-8?B?MCtLUFk0bmlHTXNjUnRyV2lpdW5EMDFNZWxOVFAzSTZ1UEI1aFdvOENRbHl4?=
 =?utf-8?B?Rmhxb0tlSWlpTVdGU01zcjQ4b2hXaW5SUVFyZGxJVHdEbjR0NUsrL2EzanNH?=
 =?utf-8?B?QWtPZUptWXdWMGxoUVhFMWx6TWE4WitweWJURUVxS1QvS3dKcjlhblIwQWJt?=
 =?utf-8?B?UFVNeC9YS3VybWZKNFV0K3BaazM4UGwxSlA5disyS1gxUVVVdlVUeUxZckhW?=
 =?utf-8?Q?48JiK0wpcIFaUtqO0A0ae4kgE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df88a00-b163-44f8-9f1e-08dd1438a8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 07:52:53.9117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZWhtcBPlKhUlY8+Gzo1cX4svFdJMz+Wl76f8reu4Ln3IVE3VdRemdc95cfB8wy9/f9mxTahBh2MG3G35HE0OFz7SuO07IaqydcHOjiv8Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7181
Received-SPF: pass client-ip=2a01:111:f403:200f::709;
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzZdIGh3OnNkaGNpOiBJ
bnRyb2R1Y2UgYSBuZXcgImNhcGFyZWciIGNsYXNzIG1lbWJlcg0KPiB0byBzZXQgdGhlIGRpZmZl
cmVudCBDYXBhYmlsaXR5IFJlZ2lzdGVycy4NCj4gDQo+IE9uIDMvMTIvMjQgMDM6MTQsIEphbWlu
IExpbiB2aWEgd3JvdGU6DQo+ID4gQ3VycmVudGx5LCBpdCBzZXQgdGhlIGhhcmRjb2RlIHZhbHVl
IG9mIGNhcGFiaWxpdHkgcmVnaXN0ZXJzIHRvIGFsbA0KPiA+IEFTUEVFRCBTT0NzIEhvd2V2ZXIs
IHRoZSB2YWx1ZSBvZiBjYXBhYmlsaXR5IHJlZ2lzdGVycyBzaG91bGQgYmUNCj4gPiBkaWZmZXJl
bnQgZm9yIGFsbCBBU1BFRUQgU09Dcy4gRm9yIGV4YW1wbGU6IHRoZSBiaXQgMjggb2YgdGhlDQo+
ID4gQ2FwYWJpbGl0eSBSZWdpc3RlciAxIHNob3VsZCBiZSAxIGZvciA2NC1iaXRzIFN5c3RlbSBC
dXMgc3VwcG9ydCBmb3IgQVNUMjcwMC4NCj4gPg0KPiA+IEludHJvZHVjZSBhIG5ldyAiY2FwYXJl
ZyIgY2xhc3MgbWVtYmVyIHdob3NlIGRhdGEgdHlwZSBpcyB1aW50XzY0IHRvDQo+ID4gc2V0IHRo
ZSBkaWZmZXJlbnQgQ2FwYWJpbGl0eSBSZWdpc3RlcnMgdG8gYWxsIEFTUEVFRCBTT0NzLg0KPiA+
DQo+ID4gVGhlIHZhbHVlIG9mIENhcGFiaWxpdHkgUmVnaXN0ZXIgaXMgIjB4MDAwMDAwMDAwMWU4
MDA4MCIgZm9yIEFTVDI0MDANCj4gPiBhbmQgQVNUMjUwMC4gVGhlIHZhbHVlIG9mIENhcGFiaWxp
dHkgUmVnaXN0ZXIgaXMgIjB4MDAwMDAwMDcwMWY4MDA4MCIgZm9yDQo+IEFTVDI2MDAuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MjQwMC5jICAgICAgfCAgMyArLQ0KPiA+
ICAgaHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMgICAgICB8ICA3ICsrLS0NCj4gPiAgIGh3L3NkL2Fz
cGVlZF9zZGhjaS5jICAgICAgICAgfCA3Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0NCj4gPiAgIGluY2x1ZGUvaHcvc2QvYXNwZWVkX3NkaGNpLmggfCAxMiArKysrKy0N
Cj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0p
DQo+IA0KPiANCj4gPiAtREVGSU5FX1RZUEVTKGFzcGVlZF9zZGhjaV90eXBlcykNCj4gDQo+ID4g
K3R5cGVfaW5pdChhc3BlZWRfc2RoY2lfcmVnaXN0ZXJfdHlwZXMpOw0KPiANCj4gUGxlYXNlIGRv
IG5vdCByZS1pbnRyb2R1Y2UgdHlwZV9pbml0KCkgY2FsbHMuIFdlIHdhbnQgdG8gcmVwbGFjZSB0
aGVtIGJ5DQo+IERFRklORV9UWVBFUygpLg0KDQpUaGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2Vz
dGlvbi4NCldpbGwgZml4IGl0Lg0KDQpKYW1pbg0K

