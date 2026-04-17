Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D9DF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDguK-00073X-Gv; Fri, 17 Apr 2026 06:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDguJ-0006sg-4Q; Fri, 17 Apr 2026 06:58:43 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDguG-0001va-HU; Fri, 17 Apr 2026 06:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4+A64u4XGTxuGx5B/Y/Jew1Y3EWx6qUOGk4MQuwiH47YeRKAwsyXUms5aLjTD0s7nEJN+QxuUR5F+ILzZabNAgbm+rSmCNqq3IpBL6ft58gg9S8/iOOjYRCHUARQUu5FTzNkb3BX72QDnv7iKC2uJwAS9rKWMJj8sSOZcBNbf82Bhfb0m+SbHOcJWZ2EP5PaoMiuQj7Jpqvd/IYiakFipWel+n6t6Sm6If2qIkfHiv8J5OEZmjRm8JLNtf135tF+dGyxwhlHLXpst0LgujxTv+u2AW2UN3eGTFFQnMVvhu+eIy5jrgOQlcs4RJS/7l97/+2/0irzE7mcFiA/LarYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWbDoF5WRNIrr/DhZez7QKCR9nhOkidSGNfJLuaHsUs=;
 b=V3Y4q+ybxq63u2nn6AfcmHfrn1daBU3zmzZvkTsmpoCBi1uWE1WI8BWHaEIQeDfcb9+BH5KAf69qm3wZf0OiasCNfgygpb7Lei02kr/wEEj6SvgScIKKFA9nBDOhBD6l2UI50eN14Lvpo2H9lf2WwxHF39xzS8t1filiB68EXtpR3A3LaJogAKTwCEeOzWJppfTR/tIl7rlC+V4SEnQyJb4ruRNj3W5kijZe8zmzqTsGcsyR2VyDDyga39aThaxAi0WAmdq+2ITPhiiWtsCbEhRGlLdFBKtD4YCRF2hIznpwadJnvP5mp6pH+MqdpmGHMPxOD3Lz5x1gi9FSmStnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWbDoF5WRNIrr/DhZez7QKCR9nhOkidSGNfJLuaHsUs=;
 b=cSaE/uY2KhV8AFA5kKvpEekM2Qkm0oOqL4WsGWI66pvYVuTPPBal1v/H5aWGNr61iG/3LZgQM6RYE4fSG1KKUeTO1FQi4FVZyaBtw23KVdrJmOCCqmRlFIjchtHqYK9KVxDM7ULMN5onMCFVeyc4Cf88ndnlKE/jP1ZbiNOSA0BZay/KxU7dSdV/caxSTHp1HHvdbM+kOvUFX7aov8Lp42a4gyUGDYFg5Bl0+NP+huCw1NfRMSS+MR8pEfI3eWwrL+/lv9sw4alYm3SjOT4H6ObbJuXBGbyarglWDkM0518eR8P7rxNSxuNYlacVUAS2RIgYZkWMC+TE/s+6jNXQTA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB8PR09MB3915.eurprd09.prod.outlook.com (2603:10a6:10:123::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:58:34 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:58:34 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Alistair
 Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "thuth@redhat.com"
 <thuth@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Thread-Index: AQHcxdz7upla7z38V0m76mmMu7gfv7XTpuqAgAJ4ToCAABGbAIAAA2kAgAzgMoCAAAPSgIAADkmA
Date: Fri, 17 Apr 2026 10:58:34 +0000
Message-ID: <87030c88-0245-4219-955f-76bdcf8422aa@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
 <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
 <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
 <55bf85d3-3b62-4dab-9b21-ec1ca193dd15@linaro.org>
 <CAKmqyKN=pn997tWzN+-7rFT5ksN6hq7ae3nLW2yDczcCqCWhnw@mail.gmail.com>
 <ed6e6e5c-3cb9-4cf1-a773-e3cbe77a4552@htecgroup.com>
 <5a737cad-3b66-462c-975b-24937fd92075@linaro.org>
In-Reply-To: <5a737cad-3b66-462c-975b-24937fd92075@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB8PR09MB3915:EE_
x-ms-office365-filtering-correlation-id: 388455c7-af82-4392-6ed0-08de9c70453a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: eKjGKMKAtjaqJSVcfiYwkXICl39XMxAjkNlSvEZ0ANdVed4QFLE/dyOY8wBxs8ve6Hnl7IDZ4gtMnwtpVrYgGPswLigr4ZPCZFMXdQzoN1bqiBNvs0nZvgD7n9uBjPk0u0EnzvcgbMgJvSHE08a80DLPk43Ed48WH6ecxegWjNjHTy4E3MV8y6pGQk5RTpTIUYDSPrphCJ5Z+TOXApgfiVfi7Ba5uQD+9BIiqLlDf32m7s40HZCiJmKX4a4QSnOLIkMG40iR5rmqiZav5BMeRfF56MQtZbDCiUKjhfE/Q6IRDJ6l2H22q0+hudLxojVhUtUNxpig7Yv9cD7+rHzQRhOMKC0fwuGkzOjwJSwhapGM+1sMoMeTD6mpoqp/BqohOAX9sChcXOfb922wNk89uAnlJkfcM4fQx57anVEiXJzgWkxr5ZG796b3cnOAJCbBrGpNEVXVzD4c6UD7NqRjiNY9bLRzCJ7mFT+PIkdXq3pvbpbi0ddPuQRanctWRGDTUEemoYk50+KoFgQa0VRCwiJG/IdadDVgzi0zEl5S9Cr6yC0480j/CJFB8fycsnYeEbht2G5e2us/wyF+K0WGAvWRroNxjcaE1KSIDo5YZsWSO+oVzupZEM7J5Ovq84E25Jy+DlV08h2MQynuZf1kIub+olmAItcCwgGLNK6kzOUlRyEPxDpQVaxNb972LQ4YwvTY20enive/Cs6It8xE3MY3VxClhqGxFHo1J1be9Fk11wB/Bp5Axeo02WSCaiBipnHQeMQthT6W8V6PM5aDmfUfo94I9BkV3VrKNBi65rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEdYdDFrQ1BBN0c3TzY1TXJnWUhsUk9PSmwzaC95VHhsTzVZZXRrSktNeW9t?=
 =?utf-8?B?eXFwWWhlRXBWTU9qdkpVS1VOUElac0t3c240RWJSRFA3Ulk1UVl2aHRleU9B?=
 =?utf-8?B?ZzdTQWtad3kyYm1kS05UNGRlM1RzR0l0ZC9HV3FDY2wrVmVMZ09rSXh2WVNI?=
 =?utf-8?B?UWIzbjk2Q2tVZExkamNJeWlWSG45YWZrYmNoV2V2c1Z0MEh6SnIvSUVxWC9J?=
 =?utf-8?B?V1pjZEtKbklFSmx5bCt2d0ZIdVFkV09ERldEYjllUHdyYkpnNW1DNVdDaUky?=
 =?utf-8?B?cnQrOUUvM0wzSlI3VFBjRldqZTZRbklkNkJNR1RiSm15cEo0OHpCMmRHb1Vi?=
 =?utf-8?B?MDFBeVlDV2dmRVM5N0JIU2hib1BKRFdzTCtyV2U3am5SSHk0Ym9BbE9JSUw3?=
 =?utf-8?B?Y3NERisycndpSTAybENQRnZKWkJJNHJZRW9zTHd2cTJHNGtDMzd3ZWU0bG9P?=
 =?utf-8?B?SmR0VHh2dHJUOFlEOUVRcDVjdVhra0pISDRYSkR5ZVpQVTlhT0htbkoxWCtk?=
 =?utf-8?B?c2dHSTFxazh2YkVNWHNOYytxWVhTaFNodjZvS1FxbGtrdGlIRDhHOTVyNDYr?=
 =?utf-8?B?QlpnYUJNM20veFNsbEZrZGtOejlNTC9UUGN4dHRMZEY0aURmdmp5OFV0V282?=
 =?utf-8?B?SGh3b0VWSkJmaGUxeFFXVlNMRGVKQWJTWlBvSEVncm9NMFlnb09rNmZTSjFU?=
 =?utf-8?B?Wkpva0w5MGU2dTZsakwwT0ZWQWpSN1RSMUpaa0tGRHdFck9DT24yeHVJSkNy?=
 =?utf-8?B?YnczVUV1SUdXdHpYR0FISmRlbEVkM1FZQldKcnVYZU1UWDZsUHlBbHVPR2NZ?=
 =?utf-8?B?SzVETW1YbzZ4RUJ0N1pRNHoxb0RmejhvK1d2TGFjNzB3NEo0ODEyS0NPM2JZ?=
 =?utf-8?B?dFUzV1h6dUlWdkFpMStncHFvSFpoVHVQamRCQzFBTWZ4cHJtUVcyZFI1Q3pP?=
 =?utf-8?B?cVEzaEd0UW9HaDBjNXFMSkYya0Z1M2Q5WVBwSWdxV0U5dHEvOFEwZHJPTmI3?=
 =?utf-8?B?Y0V0RXJiM1JQU3VWQ3FuSExSdHdOYnBHbW5sK201UG5IOFEzc1pQZ0NGRkNG?=
 =?utf-8?B?dmRGK1hDSjhYNndCajJRTWZwNzAyVERBOWpLdlRBUDVCVUluTVNCTGMzL0FE?=
 =?utf-8?B?aWwwUG5IRHhCN1djSHJ3eG5JdmtKUHRJN2ZLRUNNcGt1RWtlTTZZWW1KRmhv?=
 =?utf-8?B?Zmh3VDE0TlBXRzFCb3liSkVKN3VrMHJ6NDVZYVhuYlZwVG9mSkJRVmp6RGlj?=
 =?utf-8?B?bVlFdG4zZW5Kb2xFRUdacE5FaUlWaWs2eTVPL1NwT3BpdFRURTZNVnVQM05y?=
 =?utf-8?B?M3ErQlhMaDdybEczQ0pvUW1vaENwU3p0b2JmRFFNYnJodFloUWlOa3RrRkxi?=
 =?utf-8?B?TFNJalNzSzA0SjNaMXgzSFhKRzNOd0dLZm11QXp1R2R3VUZlcEF0aDcxRHRC?=
 =?utf-8?B?SHAwT0w1dGZ4UHBzczQ5Mmx3U3lGQ2pGM2N4Szd4R25rTkJ2aENqNW9aK3Q0?=
 =?utf-8?B?OXZOcmhVSThNSW4vR2N5QUpyeFMrTmd0Z2s0Z2JKeDRTYUdDSHNZV3M5NmdN?=
 =?utf-8?B?U2ZYaEdpdTNzOGYzajdRWVBvazVhVmRMcjF4bHBYU2NER25HZlowbklBbVZo?=
 =?utf-8?B?K3h5Z2VSYTZKWG9lekxvKzNGaGtzL2FMYWNjSGNQSmN3WUsrU3U3eGlPSm9W?=
 =?utf-8?B?Q0xBOFM5bjFGQi9oVGtTUlZ1d1EwcUVUOHlFU2h1NXNwOFcvV2hTU1EvdEpC?=
 =?utf-8?B?cysxMFRIeXNWeXl4Z1E5ZmRnaDR4RWZUNlV4Nm1jV0M0WEhrN0tPNldHZ20y?=
 =?utf-8?B?d2dxZFA4dWFub2s5UzVJbXJTU21QblFnZFQwVm1XcG1aTE9JVDdqSE81TE5h?=
 =?utf-8?B?ajRIREZaK2gxaWJyQ2doMUNmNmxabGgxY2luSHdQalpQRFFDNE9SR29iZFkx?=
 =?utf-8?B?T1UzRVVoWTUveUVJTGlvZ0p0RHRCd3NZNWxTeW5BVGZ0b1lMZm9UM0JjZU91?=
 =?utf-8?B?NFFvYVZGc1J1Um93SG13RVZiamkyeDBoKzkwbW50RUpsRDhQWjJpa2tqYXow?=
 =?utf-8?B?MENWN1BqQnNQdGxEYU9iSkFEWDJhTEl3UTJZQkt1RmxXZUFjNjhlTjlFVlVa?=
 =?utf-8?B?RlpzNWtWZ2xTZlFzM3lZWDdtYm8zTFN2Wno4UW9VOWg3Qy9DdzRLbDY2Z2Fr?=
 =?utf-8?B?L0xabm1CeGFoalE3cFJCaUR4dkRXS0dmNWRxS2dkWG9mYWRkOEJuWDdoWkpW?=
 =?utf-8?B?bFcwZWpoTmpaa05ueDBwUGljaEtra3hkeUY3MituZFlIRU1PZlFVUnNaM1Iw?=
 =?utf-8?B?MG1pVVNoK2pQOW8weWJ3NTlWcytReStnLzE3MHlkNlJ4YVRrZ3FVUW9UZW1x?=
 =?utf-8?Q?Y8iIowNG1bfHbe2QsPFXAUi6efYYMB11VdiO+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0FC1DA670DBE843BA65EC9FF8BBD6CB@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388455c7-af82-4392-6ed0-08de9c70453a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:58:34.4897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQPoX1AkyC42x1NfpW/1PxazG0Q0LsKQEMA9KHsGY8OeDsutevZ/o9/peqgrrYJ3gHCWt+isKyoK9KawzfcuRBnMUhzlT6kvjaWAWz33yIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3915
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

DQpPbiA0LzE3LzI2IDEyOjA3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ0FV
VElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0
aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4NCj4NCj4gT24gMTcvNC8yNiAxMTo1NCwgRGpvcmRqZSBUb2Rvcm92aWMgd3JvdGU6DQo+Pg0K
Pj4gT24gNC85LzI2IDA3OjE2LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPj4+IENBVVRJT046
IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4g
RG8gDQo+Pj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlciANCj4+PiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
Pj4+DQo+Pj4NCj4+PiBPbiBUaHUsIEFwciA5LCAyMDI2IGF0IDM6MDTigK9QTSBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSANCj4+PiA8cGhpbG1kQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+PiBPbiA5
LzQvMjYgMDY6MDAsIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+Pj4+PiBPbiBXZWQsIEFwciA4
LCAyMDI2IGF0IDEyOjE34oCvQU0gUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4+Pj4+IDxwaGls
bWRAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pj4+Pj4gT24gNi80LzI2IDE3OjQ5LCBEam9yZGplIFRv
ZG9yb3ZpYyB3cm90ZToNCj4+Pj4+Pj4gQWRkIGEgImJpZy1lbmRpYW4iIGJvb2xlYW4gcHJvcGVy
dHkgdG8gdGhlIFJJU0MtViBDUFUgDQo+Pj4+Pj4+IGNvbmZpZ3VyYXRpb24sDQo+Pj4+Pj4+IGRl
ZmF1bHRpbmcgdG8gZmFsc2UgKGxpdHRsZS1lbmRpYW4pLiBUaGlzIHByb3BlcnR5IGFsbG93cyBt
YWNoaW5lDQo+Pj4+Pj4+IG1vZGVscyB0byBjb25maWd1cmUgaW5kaXZpZHVhbCBIQVJUcyBmb3Ig
YmlnLWVuZGlhbiBkYXRhIG9wZXJhdGlvbi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhlIFJJU0MtViBJ
U0Egc3VwcG9ydHMgYmlnLWVuZGlhbiBkYXRhIGFjY2Vzc2VzIHZpYSB0aGUgbXN0YXR1cw0KPj4+
Pj4+PiBTQkUvTUJFL1VCRSBiaXRzLCB3aGlsZSBpbnN0cnVjdGlvbnMgcmVtYWluIGFsd2F5cyBs
aXR0bGUtZW5kaWFuLg0KPj4+Pj4+PiBUaGlzIHByb3BlcnR5IHByb3ZpZGVzIHRoZSBjb25maWd1
cmF0aW9uIGludGVyZmFjZTsgc3Vic2VxdWVudA0KPj4+Pj4+PiBwYXRjaGVzIHdpbGwgY29ubmVj
dCBpdCB0byB0aGUgQ1BVIHN0YXRlIGFuZCB0cmFuc2xhdGlvbiBsb2dpYy4NCj4+Pj4+Pj4NCj4+
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3Jvdmlj
QGh0ZWNncm91cC5jb20+DQo+Pj4+Pj4+IFJldmlld2VkLWJ5OiBDaGFvIExpdSA8Y2hhby5saXUu
emV2b3JuQGdtYWlsLmNvbT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+IMKgwqDCoMKgIHRhcmdldC9y
aXNjdi9jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEgKw0KPj4+Pj4+PiDC
oMKgwqDCoCB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMgfCAxICsNCj4+Pj4+Pj4g
wqDCoMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+Pj4+Pg0KPj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jIA0KPj4+Pj4+
PiBiL3RhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5oLmluYw0KPj4+Pj4+PiBpbmRleCA3MGVj
NjUwYWJmLi41MTQzNmRhYWJmIDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1
X2NmZ19maWVsZHMuaC5pbmMNCj4+Pj4+Pj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmll
bGRzLmguaW5jDQo+Pj4+Pj4+IEBAIC0xNTQsNiArMTU0LDcgQEAgQk9PTF9GSUVMRChleHRfeG1p
cHNjYm9wKQ0KPj4+Pj4+PiDCoMKgwqDCoCBCT09MX0ZJRUxEKGV4dF94bWlwc2Ntb3YpDQo+Pj4+
Pj4+IMKgwqDCoMKgIEJPT0xfRklFTEQoZXh0X3htaXBzbHNwKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiAr
Qk9PTF9GSUVMRChiaWdfZW5kaWFuKQ0KPj4+Pj4+IFNpbmNlIGl0IGlzIHJ1bnRpbWUgaXQgZG9l
c24ndCBiZWxvbmcgdG8gUklTQ1ZDUFVDb25maWcuDQo+Pj4+PiBJIHRoaW5rIHRoZSBpZGVhIGlz
IHRoYXQgYSB1c2VyIGNhbiBzZXQgdGhlIGBiaWctZW5kaWFuYCBwcm9wZXJ0eQ0KPj4+Pj4gKGZy
b20gdGhlIGNvbW1hbmQgbGluZSBvciBtYWNoaW5lKSBhbmQgdGhlbiBNQkUsIFNCRSBhbmQgVUJF
IGFyZQ0KPj4+Pj4gYWx3YXlzIDEgYW5kIGJpZyBlbmRpYW4gaXMgYWx3YXlzIGVuYWJsZWQuIEJh
c2ljYWxseSB0byBtb2RlbA0KPj4+Pj4gYmlnLWVuZGlhbiBvbmx5IGhhcmR3YXJlDQo+Pj4+Pg0K
Pj4+Pj4gU28gaW4gdGhhdCBjb250ZXh0IGl0IGlzbid0IHJ1bnRpbWUsIGJ1dCBpdCdzIG5vdCBj
bGVhciBmcm9tIHRoZQ0KPj4+Pj4gY29tbWl0IGRlc2NyaXB0aW9uLiBBbHNvIGlmIHdlIGFyZSBh
ZGRpbmcgYSBwcm9wZXJ0eSB0aGUgcHJvcGVydHkNCj4+Pj4+IHNob3VsZCBiZSBleHBvc2VkIGxh
c3QsIGFzIGluIG9uY2UgYWxsIG9mIHRoZSBmdW5jdGlvbmFsaXR5IGlzDQo+Pj4+PiBzdXBwb3J0
ZWQuIFRoYXQgd2F5IHdlIGRvbid0IGhhdmUgYSBwcm9wZXJ0eSB0aGF0IGRvZXNuJ3QgZG8gDQo+
Pj4+PiBhbnl0aGluZy4NCj4+Pj4+IFdlIHdvdWxkIGFsc28gbmVlZCBkb2N1bWVudGF0aW9uIGFk
ZGVkLg0KPj4+PiBSZWFkaW5nICIzLjEuNi4zIE1lbW9yeSBQcml2aWxlZ2UgaW4gbXN0YXR1cyBS
ZWdpc3RlciIgaXQgaXMgbm90DQo+Pj4+IGNsZWFyIHRvIG1lIHdoZXRoZXIgTUJFIGFuZCBTQkUg
YXJlIGhhcmQtd2lyZWQsIEknZCBoYXZlIGV4cGVjdGVkDQo+Pj4gVGhleSBkb24ndCBoYXZlIHRv
IGJlIGhhcmQtd2lyZWQuIFRoZXJlIGlzIGEgbm90ZSBpbiBzZWN0aW9uIDMuMS42LjUgDQo+Pj4g
dGhhdCBzYXlzOg0KPj4+DQo+Pj4gIiIiDQo+Pj4gQW4gaW1wbGVtZW50YXRpb24gc3VwcG9ydHMg
b25seSBsaXR0bGUtZW5kaWFuIG1lbW9yeSBhY2Nlc3NlcyBpZg0KPj4+IGZpZWxkcyBNQkUsIFNC
RSwgYW5kIFVCRQ0KPj4+IGFyZSBhbGwgcmVhZC1vbmx5IDAuIEFuIGltcGxlbWVudGF0aW9uIHN1
cHBvcnRzIG9ubHkgYmlnLWVuZGlhbiBtZW1vcnkNCj4+PiBhY2Nlc3NlcyAoYXNpZGUgZnJvbQ0K
Pj4+IGluc3RydWN0aW9uIGZldGNoZXMpIGlmIE1CRSBpcyByZWFkLW9ubHkgMSBhbmQgU0JFIGFu
ZCBVQkUgYXJlIGVhY2gNCj4+PiByZWFkLW9ubHkgMSB3aGVuIFMtbW9kZQ0KPj4+IGFuZCBVLW1v
ZGUgYXJlIHN1cHBvcnRlZC4NCj4+PiAiIiINCj4+Pg0KPj4+PiBhIEhBUlQgdG8gYmUgYWJsZSB0
byByZXNldCBpdHNlbGYgaW4gYSBkaWZmZXJlbnQgZW5kaWFubmVzcywgYW5kDQo+Pj4+IGluIHRo
YXQgY2FzZSB0aGUgY3VycmVudCByaXNjdl9jcHVfcmVzZXRfaG9sZCgpIHdvdWxkIG92ZXJ3cml0
ZSB0aGF0Lg0KPj4+IEkgc3VzcGVjdCBhIGxvdCBvZiBiaWctZW5kaWFuIGhhcnRzIGFyZSBqdXN0
IGFsd2F5cyBiaWctZW5kaWFuLg0KPj4+IFN3YXBwaW5nIGF0IHJ1bnRpbWUgc2VlbXMgdHJpY2t5
LCBhbHRob3VnaCBzb21ldGhpbmcgd2UgY2FuIHN1cHBvcnQuDQo+Pj4NCj4+PiBUaGlzIHNob3Vs
ZCBhbGwgYmUgbWFkZSBjbGVhciBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHNvbWUgDQo+Pj4g
ZG9jdW1lbnRhdGlvbg0KPj4+DQo+Pj4gQWxpc3RhaXINCj4+DQo+PiBUaGFua3MgUGhpbGlwcGUs
IEFsaXN0YWlyLg0KPj4NCj4+IFRvIGNsYXJpZnk6IGJpZ19lbmRpYW4gaXMgbm90IGEgcnVudGlt
ZSBmbGFnIOKAlCBpdCBtb2RlbHMgYmlnLWVuZGlhbi1vbmx5DQo+PiBoYXJkd2FyZSBhcyBkZXNj
cmliZWQgaW4gdGhlIHByaXZpbGVnZWQgc3BlYyBzZWN0aW9uIDMuMS42LjUsIHdoZXJlDQo+PiBN
QkUvU0JFL1VCRQ0KPj4gYXJlIGhhcmR3aXJlZCB0byAxLiBJdCBiZWxvbmdzIGluIFJJU0NWQ1BV
Q29uZmlnIGJlY2F1c2UgaXQncyBhIHN0YXRpYywNCj4+IHBlci1DUFUgaGFyZHdhcmUgcHJvcGVy
dHkgKHNhbWUgY2F0ZWdvcnkgYXMgbW11IG9yIHBtcCksIG5vdCBzb21ldGhpbmcNCj4+IHRoZSBn
dWVzdCB0b2dnbGVzIGF0IHJ1bnRpbWUuDQo+Pg0KPj4gVGhlIE1CRS9TQkUvVUJFIGJpdHMgYXJl
IGFscmVhZHkgZWZmZWN0aXZlbHkgaGFyZHdpcmVkIGluIHRoZSBleGlzdGluZw0KPj4gY29kZWJh
c2U6IG5vbmUgb2YgdGhlIHdyaXRlX21zdGF0dXMvd3JpdGVfbXN0YXR1c2gvd3JpdGVfc3N0YXR1
cyBDU1IgDQo+PiBwYXRocw0KPj4gaW5jbHVkZSB0aGVtIGluIHRoZWlyIHdyaXRhYmxlIG1hc2ss
IHNvIHdoYXRldmVyIHZhbHVlIGlzIHNldCBhdCByZXNldA0KPj4gcGVyc2lzdHMgZm9yIHRoZSBs
aWZldGltZSBvZiB0aGUgQ1BVLg0KPg0KPiBXaGF0IGRvIHlvdSByZWZlciB0byBieSAiZXhpc3Rp
bmcgY29kZWJhc2UiPw0KPg0KSSBtZWFudCBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHdyaXRl
X21zdGF0dXMoKSwgd3JpdGVfbXN0YXR1c2goKSwgYW5kDQoNCndyaXRlX3NzdGF0dXMoKSBkb24n
dCBpbmNsdWRlIFVCRS9TQkUvTUJFIGluIHRoZWlyIHdyaXRhYmxlIG1hc2tzLg0KDQo+IFNlY3Rp
b24gMy4xLjYuNSBub3RlOg0KPg0KPiDCoCBbLi4uXSBlbmRpYW5uZXNzIGNvbnRyb2wgaGFzIGJl
ZW4gZGVmaW5lZCBzbyBhcyB0byBwZXJtaXQsIGZvcg0KPiDCoCBpbnN0YW5jZSwgYW4gT1Mgb2Yg
b25lIGVuZGlhbm5lc3MgdG8gZXhlY3V0ZSB1c2VyLW1vZGUgcHJvZ3JhbXMNCj4gwqAgb2YgdGhl
IG9wcG9zaXRlIGVuZGlhbm5lc3MuIENvbnNpZGVyYXRpb24gaGFzIGJlZW4gZ2l2ZW4gYWxzbyB0
bw0KPiDCoCB0aGUgcG9zc2liaWxpdHkgb2Ygbm9uLXN0YW5kYXJkIHVzYWdlcyB3aGVyZWJ5IHNv
ZnR3YXJlIGZsaXBzIHRoZQ0KPiDCoCBlbmRpYW5uZXNzIG9mIG1lbW9yeSBhY2Nlc3NlcyBhcyBu
ZWVkZWQuDQo+DQo+IFdoaWNoIEkgaW50ZXJwcmV0ZSBhcyAicnVudGltZSBzd2FwIi4gSSdtIG5v
dCBzZWVpbmcgZXhwbGljaXQgbWVudGlvbiBvZg0KPiBoYXJkLXdpcmVkIGJpdHMuDQoNCkhtbS4g
VGhhdCBpcyByaWdodCwgYnV0IEkgd2FzIGxvb2tpbmcgdG8gdGhlIHNlY3Rpb246DQoNCiJBbiBp
bXBsZW1lbnRhdGlvbiBzdXBwb3J0cyBvbmx5IGxpdHRsZS1lbmRpYW4gbWVtb3J5IGFjY2Vzc2Vz
IGlmDQpmaWVsZHMgTUJFLCBTQkUsIGFuZCBVQkUgYXJlIGFsbCByZWFkLW9ubHkgMC4gQW4gaW1w
bGVtZW50YXRpb24NCnN1cHBvcnRzIG9ubHkgYmlnLWVuZGlhbiBtZW1vcnkgYWNjZXNzZXMgWy4u
Ll0gaWYgTUJFIGlzIHJlYWQtb25seSAxDQphbmQgU0JFIGFuZCBVQkUgYXJlIGVhY2ggcmVhZC1v
bmx5IDEgd2hlbiBTLW1vZGUgYW5kIFUtbW9kZSBhcmUNCnN1cHBvcnRlZC4iDQoNCndoZXJlIGl0
IGlzIGtpbmQgb2YgaW1wbGljYXRlZC4NCg0KVGhhbmtzLA0KRGpvcmRqZQ0KDQo=

