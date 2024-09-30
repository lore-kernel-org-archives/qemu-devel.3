Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C71CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 05:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv9OA-0000Dl-AE; Mon, 30 Sep 2024 01:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sv9O8-00004w-LZ; Mon, 30 Sep 2024 01:56:04 -0400
Received: from mail-tyzapc01on20710.outbound.protection.outlook.com
 ([2a01:111:f403:2011::710]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sv9O6-0002OZ-40; Mon, 30 Sep 2024 01:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9/PRAUbortgEQYC+bpN1eE+HJxaRt75R0gsEhOulDGu4SEucVjCiNVBtucEfy03zV34ylBfhVl+u4gWCo33RS4oFnRlEi65aWws9GvYjDS8RfEOLHpliFHx6VhD0zLf7fXlztMWKU27RwCPU95WM6Kz7rcMDHtAwBtMoaRL64RtPyCZq4fm6fdIX3FpIcvZHwlWUfOzkC5r30fGNtkSm6r3NxHrmBcEFbUt4P5cxTinKFjH6NEXODPKB4bk/0YIyW3OlnAINcfzYbO/JpF85NXESc4mOcncgpaYMnKH349roUlVY9l57HhX7QNtArSnY1jztpjn1MvsEGpHF+OJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmhNnfwAsuCZZOg350CA10yHmr5IofHXCvL8xSV+4Mk=;
 b=DHCJtWbmQ9VfzPUyX4S2sjBv3mjnu3gLHYVl44vQUEgt4VccNMxYIaVXtw90ZEgX/SiWYzI87yzCPpw2Yzq00/sU2P31QyaCkyvQgxRlfSTWZ/XMCeO15Rv32DH/0MabrXQa8FCzfe5G1mQNkYTD3f8f0v8wYtKZPbxAzW6XmI4jNnAvxbsojqVWnRnpS33di8bgjq8wFc7tBZ+vmMYh7u1xCRNYexVTllGGm+N4qE1RISWFvWWiuPVBOZAnlR8sidzgXGnUXwTCxF0v2deVwvShtSCPIvu8eMeCCv7Xlt/OLXguCCzLm0SVZeFIzPGiEJ285UjFFQC5K9cZXgWMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmhNnfwAsuCZZOg350CA10yHmr5IofHXCvL8xSV+4Mk=;
 b=HME79EZ4x0jE6heGtO0/Vm/dveqlFqnHhySObDkSekWTQbOyVhCCrwvOd6IZ/I2mGDtLPR9xrARZwRVCT7qnw5FAghnrthofsQkmd4U9y/EBIEQroCmO437oO+cowEp3pNpYMhldmoTpoooRJZptx3BjbPFvv8C5E32YYszonk/WL3gKxztoRzTh7qYkEAH5uKNfUlPDeaFxJZwu3VM29PDlavf7YXLRCggdwZb1bLEKWysFN6CZYKi/0LpBg4i/bT0m+BfTr/4S0ajlp7LcWHdHM9xix3wtl12oBSY2xRetnBYxsT7CLhSY9mvl+ZiQwiVcDXYQ3RBAnDdobBQvFA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6465.apcprd06.prod.outlook.com (2603:1096:400:44e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Mon, 30 Sep 2024 05:55:53 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Mon, 30 Sep 2024
 05:55:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Thomas Huth <thuth@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v5 7/7] hw/gpio/aspeed: Add test case for AST2700
Thread-Topic: [PATCH v5 7/7] hw/gpio/aspeed: Add test case for AST2700
Thread-Index: AQHbELgDOu2wpVBqbkabA01SGb1iPbJrXg8AgAR617A=
Date: Mon, 30 Sep 2024 05:55:53 +0000
Message-ID: <SI2PR06MB5041A19554BCA815849FA95EFC762@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240927083351.2637798-1-jamin_lin@aspeedtech.com>
 <20240927083351.2637798-8-jamin_lin@aspeedtech.com>
 <4d4a0c9b-45df-4d2e-b47d-f9ab898801cd@redhat.com>
In-Reply-To: <4d4a0c9b-45df-4d2e-b47d-f9ab898801cd@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6465:EE_
x-ms-office365-filtering-correlation-id: 1ac22aca-ccc4-4fe9-b849-08dce1148b4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?YTVOcmgxWnJpdWdhT2FxS0FWNGNoUkt4S0xhSHBIQWZmenQ3bTB2WFlSR2VZ?=
 =?utf-8?B?bjdRSDc0ajNPMzhyS3FFa3E0SDZXT2hqU1U3OWRtMlBpMklCN1ArRkNuOHZs?=
 =?utf-8?B?MVhpNkhUdjFoWWJHTkJNOFlCYkxJazRhUVc2aEVsaWwveEN0YmNqL2RUakha?=
 =?utf-8?B?VmxHaWNnWWZLbWtYVGFMeWV4dlBnOXFwZ2FpL0FvQnp4Znh1QWY1UkgzVzhl?=
 =?utf-8?B?Z01lRExOMUxiMHdGd1lKQmdOcHoxdzVjV2M5WVBFb2F2TlJxSEJFeG5tbktz?=
 =?utf-8?B?NUw4cUlrTjdaYVZkdWpNK2k1OXlCclY3cCtRN05pb3ZINTF3am5zUE82QTRZ?=
 =?utf-8?B?ZGY2eFpoS1ZmTERzS2NEQy9JeUtENUhpcjg4MWJ3TXhnTThnUXFZSmhaTmhh?=
 =?utf-8?B?N1I0TlBtU0RpWkR3ODA3U0lhcnRQSXFHUTJTek1XZitUV3JobHBEd3l6dXN1?=
 =?utf-8?B?bHpnRnJWQTBSRTVpcmJ0RUJLcnQvWVpQUVk4TWUzY2NOTWZzbXNFRzlRT1BJ?=
 =?utf-8?B?OTdPemFNRHJOYXAvb2RPaWRFR1FoaVdrU1FRNXRNS3JxTWhKVThLblkxd2JF?=
 =?utf-8?B?NW9rRmlYai9jWHdmRVdPb0ppU0JZaXJrVittOEFVWjVyUkI3RTVqVkFoOTNZ?=
 =?utf-8?B?elRFdTZjOHpUdFFiYmV3Z0ozUWlzak9UR0NxYjdFSW9hVVVYTmFoR2F3RE4w?=
 =?utf-8?B?Tm9vWG5mbzhETWlMdTBLTGwxa0NpamVvZUpvOUlXWDdTMTBwSGhBWm1VaDhP?=
 =?utf-8?B?MGg1Vkdhd2NudWFHTnQzU25EZ0FiQjBmTjVoZml4aUtnSnNKVlNjOE5EZjdF?=
 =?utf-8?B?RzlyUmtqQTBIYmlqNnlJcWRVQ3pNTEw0U2xmN0Q2UStJKzFyYk9aa0tUM1Qz?=
 =?utf-8?B?dnNIRkR2K0FqdWpvYWVmaEpaQ2ExOWJNREZrdW1Na1lVTzl0b1Z1QURiVlZS?=
 =?utf-8?B?V1pHRjU3cHVPTklZMDZSNytJOWVlRUoxQ2FqYTBVUktNYjZ5Qk5hZTIxcFlj?=
 =?utf-8?B?WDdQS1MrQXNWdnM3V2dzbVJlbVZjaldVaE9rdFhDUlpCdVBiTGdHb1JzZ1dP?=
 =?utf-8?B?cEl6OXd5VTc5bS83WXp5S054MFNwMTZCbi84TThzKzA4dGRQRU50VHZwZ2Za?=
 =?utf-8?B?RlkvVkQzV0oraW5vdlFhaW1QN0J0ZTV4ZmtVUHdSKzJ1ZVp6WmJxWStVNWpQ?=
 =?utf-8?B?UWhTblA0L3RBblIrQkhOZlJUN29MTmRsT2I0cTdKdUFhV3J3MHl4Mi9Hbmxa?=
 =?utf-8?B?S2hkanRkL0JrWkozRFBWKzU5ZGpPVFhrak40SGJ6UEpaWnpHdE14MkR5bnNG?=
 =?utf-8?B?ZnpKUGE3SFZudGhmMTVqb0tTaFpybFFrcEFrR1BrQkRmL2J6MWM2WjdIaFNx?=
 =?utf-8?B?VFpiUUtjdjJxQ2V6ZlNYcmMrbWttSHgwSGVmVkNmendNUGF0aGorRHVIQTky?=
 =?utf-8?B?MmdWSGlZZ2FwUjJSZkFzdi91NXZHMTJNWTlvenN3WktXdlNlTVBIRWxsYzl3?=
 =?utf-8?B?RDQ2cnpTNUdieXc4YytscG1sZWlPWlVmcWROUmxucFFUYURUand0QTBFTktD?=
 =?utf-8?B?YnFZY0hFQ25EVEdXQ1FWR2NpWDJXV1dsN0hkaGR1MGVkVmFlQzNpd0NSd1Bq?=
 =?utf-8?B?dEIxdVNzaUNPQU5mdEZUdmJUQjhSNXdzallMRTBFN0VyYXozVmdMM0l6ZlpB?=
 =?utf-8?B?VXg4UjY4STBHMTM5NHd2OWZ5eGlZUk5makpiVzVZcFlncDRDRld0cTNHS3Av?=
 =?utf-8?B?UFlJOFdQTjB1b0FJWXVDQlJQTkV2b1dGQWtjSmIxaS94MVc4RWg1SGd0SUg3?=
 =?utf-8?B?eWw3YXFPaG1QY0ZBQ3U1dll3bjd2VEw4VFJkMEI0NnkvSGYvb0pYTVRRejdN?=
 =?utf-8?B?L0h6WGljTWdUQ1BKc0twcjNud1lMeDVIZ3BRV0gxNlJvbXFqNDBKV2ZtZGZQ?=
 =?utf-8?Q?GxJpL8AdzYU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERkVjVhNXhnSmZxeUR0VER3NERWUjJ3bzhBNjkvdzlReGoySk9QVlRmY1U5?=
 =?utf-8?B?WlEvNHF6Z05IeExmQ3RVdkVxRVBJWEFFaVJRYmJVTlQxd3pRRlRzQkZiOEpj?=
 =?utf-8?B?WDRFU3JUODN4TFN4NllwT0lLVnFqWnNvRkhaZWFkRTNOQXB3YVhzbjdiN0Vt?=
 =?utf-8?B?UzV5SlhwWDNjL0ZrRysxbEkwK3NzVW1tM0o0bEZJWGF3QkFOR1lMRU5XTG1R?=
 =?utf-8?B?MHBLdjY1ai9pRDhySXdZYW1FdEtyYk1PSDFkZjRneURkRDZ6NXgvUUtONFNZ?=
 =?utf-8?B?K3hLS0JUQlBaV2VERmtkWGFRa1ZITU41R2ZTRTNnMXgza21ENUZjTmtSMVNK?=
 =?utf-8?B?UU94bkl4aW5ZZHpHdkNadkp1Y0RKVi9JeXdqOXFBd3dtS2NiOEtLaXVWZjJx?=
 =?utf-8?B?d1NiQlkzZDBac0k1eHBWTUxnTExIT3ZFaUd6T2E2VlVmd2pzV0w2dXowajNL?=
 =?utf-8?B?Z2VTU01MTUtra3g5eTN2V0t3aVlBd0ZObWVMa1ZrQmovUzJHelgxR0REQncy?=
 =?utf-8?B?bDRwWjFIRnVXRjREcmdKVm9FWjViZnJXZzNEcm1JUmZzeFUvOEtsNHA3WnFB?=
 =?utf-8?B?QVhBVW1hQTBnRDB2T3ZSY3pUbitlY3lNdnV5MXcyaEtwZUNwSU4xaFNYS1dM?=
 =?utf-8?B?M3VPcU1UUWZxekVZZjAxZUs4MHF5Yklqc3V1dUUvM1pvMFpKeVgrcUZEMFlQ?=
 =?utf-8?B?d3VyV3lvUE5wQk9RQ1FzZ0hPT2FYcUY2UkNFWnA2QWhiZmZ6RzZkVVp4SnZV?=
 =?utf-8?B?MU84MnFQZUF5by9rY2YyOUZPT3FubzZ5K1JFMXhRTWpJN3d3d0w2M1dtdm1o?=
 =?utf-8?B?TWdxQldEcFdqdTkzZnhPazFQbU1tVWl0SC82d0NqY0pKRWk3SnVpMmh0aEY4?=
 =?utf-8?B?anNOczkwUUZGWEVIU2k1RlVtYm9YUDhHbVZrb084QzdLdHlwK1Erb1hZaFJh?=
 =?utf-8?B?VVpwbGMwN3dTUktNbGJMMFJoMVlJMkYxU0pNdE9nenE1TzRZWjh4VjNmQWNa?=
 =?utf-8?B?Skw5VitlWG44SWUrSTRHQjh3Z1FMczBuQ05SRUFuMGxoVFh2TVdvTU1oVG5D?=
 =?utf-8?B?b2RMYUNaTDdidzE2UjJMZ1huRjZRMUhPQ0MrRTBYdjVoS2dGc25rK2xZRzFO?=
 =?utf-8?B?QWVkZEVBcnlhWitDMVVqRnF4VEFvYkkvcll6WWlLNXA3Z0JFWUFJRmN5emgz?=
 =?utf-8?B?YTFIY1E2YzBleGcvQlJWNUd6MlFsbmI4Z0Vva25MNzJGV0JLT09tWEZHWGhV?=
 =?utf-8?B?RXBLSkRXTGMxdmxWUmMxS0tqS2dPQmJScEJrZU1NdzlIbEEzQlNPektsS0R1?=
 =?utf-8?B?ajlXWTNPT0p5aEVMWXFOYVFMVDEySjZYKzVpSWY1ZjN0WnhLRVhUNHdtQjlh?=
 =?utf-8?B?Z2xRZEhSY3pRYWFoaEd5bWJzODl0ZkZXb3hFaFZhY3RveFdZWnVLWFozMVFa?=
 =?utf-8?B?L0tuTTJkTmJyMGp5UldtOGZQSmlBdmRSbGVRaGlzWEdZVjNnb2duYnl0K3BP?=
 =?utf-8?B?VUVkb1djbkJtaHAwbGYxOXg1MHFjWWZnSjJaaEhxbTcyVUZYTTNUWTljaUxE?=
 =?utf-8?B?T2hLbnQ2a3JYaWcvc3h6Wjcvc200VFJMTktwUTBXb1ZtV2RtTlc2c3RqRnpY?=
 =?utf-8?B?cjI0OTU0bTJSczRtZGEyemYzSUVVTC9DSmtDME4vQktmTFg0bERHYzBvaXkw?=
 =?utf-8?B?eUtZeEkzM2UwSUR2S1YvM2dtRDl3NkovbiszWDllaStEOEl6UXlGYTVMeWxO?=
 =?utf-8?B?MDVZbkhhMGtiQlk3QklCVTNjc2xaVnhFaDZKVjNMc21BOWVRLzlSUXlyYWZk?=
 =?utf-8?B?N3IxNVhENm9uQUgzNHNXYi9QSFRVMjQ3ek0rUWFJcE1qbUlpYzE5NTJHMGg1?=
 =?utf-8?B?Tm5lK0FnRWlCbnNib2xBWEc3MiszSkRRTUhVV2NNM2dVbnRzN3p1dWRSRjBT?=
 =?utf-8?B?Y1dVQ3ZkV3h1cW52TzlhMDFsVTU5UkVTWExobEtJZ1YyNU5KY1dCU3pzQWx4?=
 =?utf-8?B?NHM0YlNtSVczRnpLa1UzNk1QYWNic2l5bndYcUtkd3grOGR6QmlVMGF4SXlh?=
 =?utf-8?B?Z3R3b2oyQ3owUVJnb1d1S0VOTWt2Uk9uWjVObjBtZnoweE5NQUc4MXNyZncv?=
 =?utf-8?Q?8Vx2gxQwud3yOWfOaYibCMVxj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac22aca-ccc4-4fe9-b849-08dce1148b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 05:55:53.2237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzZ8Gqb6WJiBB7xxn8y/WCGoz9pxCaJZEQxRYeXSys980sqj5Hlg84DmJk35dbWJnEbH4fLO4b2ZZ38cmy5l3JLOMgGFVQJru0OnUl9if/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6465
Received-SPF: pass client-ip=2a01:111:f403:2011::710;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgVGhvbWFzLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNy83XSBody9ncGlvL2FzcGVl
ZDogQWRkIHRlc3QgY2FzZSBmb3IgQVNUMjcwMA0KPiANCj4gT24gMjcvMDkvMjAyNCAxMC4zMywg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IEFkZCB0ZXN0IGNhc2UgdG8gdGVzdCBHUElPIG91dHB1dCBh
bmQgaW5wdXQgcGlucyBmcm9tIEEwIHRvIEQ3IGZvciBBU1QyNzAwLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+
ID4gICB0ZXN0cy9xdGVzdC9hc3BlZWRfZ3Bpby10ZXN0LmMgfCA2OA0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2FzcGVlZF9ncGlvLXRlc3Qu
Yw0KPiA+IGIvdGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVzdC5jIGluZGV4IGQzOGY1MWQ3MTku
LjlkOTc4YjcwZTAgMTAwNjQ0DQo+ID4gLS0tIGEvdGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVz
dC5jDQo+ID4gKysrIGIvdGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVzdC5jDQo+ID4gQEAgLTMz
LDYgKzMzLDEwIEBADQo+ID4gICAjZGVmaW5lIEdQSU9fQUJDRF9EQVRBX1ZBTFVFIDB4MDAwDQo+
ID4gICAjZGVmaW5lIEdQSU9fQUJDRF9ESVJFQ1RJT04gIDB4MDA0DQo+ID4NCj4gPiArLyogQVNU
MjcwMCAqLw0KPiA+ICsjZGVmaW5lIEFTVDI3MDBfR1BJT19CQVNFIDB4MTRDMEIwMDANCj4gPiAr
I2RlZmluZSBHUElPQTBfQ09OVFJPTCAweDE4MA0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIHRl
c3Rfc2V0X2NvbG9jYXRlZF9waW5zKGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICB7DQo+ID4gICAg
ICAgUVRlc3RTdGF0ZSAqcyA9IChRVGVzdFN0YXRlICopZGF0YTsgQEAgLTcyLDggKzc2LDY0IEBA
IHN0YXRpYw0KPiA+IHZvaWQgdGVzdF9zZXRfaW5wdXRfcGlucyhjb25zdCB2b2lkICpkYXRhKQ0K
PiA+ICAgICAgIGdfYXNzZXJ0X2NtcGhleCh2YWx1ZSwgPT0sIDB4ZmZmZmZmZmYpOw0KPiA+ICAg
fQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIHRlc3RfMjcwMF9vdXRwdXRfcGlucyhjb25zdCB2b2lk
ICpkYXRhKSB7DQo+ID4gKyAgICBRVGVzdFN0YXRlICpzID0gKFFUZXN0U3RhdGUgKilkYXRhOw0K
PiA+ICsgICAgdWludDMyX3Qgb2Zmc2V0ID0gMDsNCj4gPiArICAgIHVpbnQzMl90IHZhbHVlID0g
MDsNCj4gPiArICAgIHVpbnQzMl90IHBpbiA9IDA7DQo+ID4gKw0KPiA+ICsgICAgZm9yIChjaGFy
IGMgPSAnQSc7IGMgPD0gJ0QnOyBjKyspIHsNCj4gPiArICAgICAgICBmb3IgKGludCBpID0gMDsg
aSA8IDg7IGkrKykgew0KPiA+ICsgICAgICAgICAgICBvZmZzZXQgPSBBU1QyNzAwX0dQSU9fQkFT
RSArIEdQSU9BMF9DT05UUk9MICsgKHBpbiAqDQo+IDQpOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgLyogb3V0cHV0IGRpcmVjdGlvbiBhbmQgb3V0cHV0IGhpICovDQo+ID4gKyAgICAgICAgICAg
IHF0ZXN0X3dyaXRlbChzLCBvZmZzZXQsIDB4MDAwMDAwMDMpOw0KPiA+ICsgICAgICAgICAgICB2
YWx1ZSA9IHF0ZXN0X3JlYWRsKHMsIG9mZnNldCk7DQo+ID4gKyAgICAgICAgICAgIGdfYXNzZXJ0
X2NtcGhleCh2YWx1ZSwgPT0sIDB4MDAwMDAwMDMpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAg
Lyogb3V0cHV0IGRpcmVjdGlvbiBhbmQgb3V0cHV0IGxvdyAqLw0KPiA+ICsgICAgICAgICAgICBx
dGVzdF93cml0ZWwocywgb2Zmc2V0LCAweDAwMDAwMDAyKTsNCj4gPiArICAgICAgICAgICAgdmFs
dWUgPSBxdGVzdF9yZWFkbChzLCBvZmZzZXQpOw0KPiA+ICsgICAgICAgICAgICBnX2Fzc2VydF9j
bXBoZXgodmFsdWUsID09LCAweDAwMDAwMDAyKTsNCj4gPiArICAgICAgICAgICAgcGluKys7DQo+
ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCB0ZXN0XzI3MDBfaW5wdXRfcGlucyhjb25zdCB2b2lkICpkYXRhKSB7DQo+ID4gKyAgICBRVGVz
dFN0YXRlICpzID0gKFFUZXN0U3RhdGUgKilkYXRhOw0KPiA+ICsgICAgY2hhciBuYW1lWzE2XTsN
Cj4gPiArICAgIHVpbnQzMl90IG9mZnNldCA9IDA7DQo+ID4gKyAgICB1aW50MzJfdCB2YWx1ZSA9
IDA7DQo+ID4gKyAgICB1aW50MzJfdCBwaW4gPSAwOw0KPiA+ICsNCj4gPiArICAgIGZvciAoY2hh
ciBjID0gJ0EnOyBjIDw9ICdEJzsgYysrKSB7DQo+ID4gKyAgICAgICAgZm9yIChpbnQgaSA9IDA7
IGkgPCA4OyBpKyspIHsNCj4gPiArICAgICAgICAgICAgc3ByaW50ZihuYW1lLCAiZ3BpbyVjJWQi
LCBjLCBpKTsNCj4gPiArICAgICAgICAgICAgb2Zmc2V0ID0gQVNUMjcwMF9HUElPX0JBU0UgKyBH
UElPQTBfQ09OVFJPTCArIChwaW4gKg0KPiA0KTsNCj4gPiArICAgICAgICAgICAgLyogaW5wdXQg
ZGlyZWN0aW9uICovDQo+ID4gKyAgICAgICAgICAgIHF0ZXN0X3dyaXRlbChzLCBvZmZzZXQsIDAp
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgLyogc2V0IGlucHV0ICovDQo+ID4gKyAgICAgICAg
ICAgIHF0ZXN0X3FvbV9zZXRfYm9vbChzLCAiL21hY2hpbmUvc29jL2dwaW8iLCBuYW1lLCB0cnVl
KTsNCj4gPiArICAgICAgICAgICAgdmFsdWUgPSBxdGVzdF9yZWFkbChzLCBvZmZzZXQpOw0KPiA+
ICsgICAgICAgICAgICBnX2Fzc2VydF9jbXBoZXgodmFsdWUsID09LCAweDAwMDAyMDAwKTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgIC8qIGNsZWFyIGlucHV0ICovDQo+ID4gKyAgICAgICAgICAg
IHF0ZXN0X3FvbV9zZXRfYm9vbChzLCAiL21hY2hpbmUvc29jL2dwaW8iLCBuYW1lLCBmYWxzZSk7
DQo+ID4gKyAgICAgICAgICAgIHZhbHVlID0gcXRlc3RfcmVhZGwocywgb2Zmc2V0KTsNCj4gPiAr
ICAgICAgICAgICAgZ19hc3NlcnRfY21waGV4KHZhbHVlLCA9PSwgMCk7DQo+ID4gKyAgICAgICAg
ICAgIHBpbisrOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4g
PiArDQo+ID4gICBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ID4gICB7DQo+ID4g
KyAgICBjb25zdCBjaGFyICphcmNoID0gcXRlc3RfZ2V0X2FyY2goKTsNCj4gPiAgICAgICBRVGVz
dFN0YXRlICpzOw0KPiA+ICAgICAgIGludCByOw0KPiA+DQo+ID4gQEAgLTgzLDYgKzE0MywxNCBA
QCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ID4gICAgICAgcXRlc3RfYWRkX2Rh
dGFfZnVuYygiL2FzdDI2MDAvZ3Bpby9zZXRfY29sb2NhdGVkX3BpbnMiLCBzLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGVzdF9zZXRfY29sb2NhdGVkX3BpbnMpOw0KPiA+ICAgICAg
IHF0ZXN0X2FkZF9kYXRhX2Z1bmMoIi9hc3QyNjAwL2dwaW8vc2V0X2lucHV0X3BpbnMiLCBzLA0K
PiA+IHRlc3Rfc2V0X2lucHV0X3BpbnMpOw0KPiA+ICsNCj4gPiArICAgIGlmIChzdHJjbXAoYXJj
aCwgImFhcmNoNjQiKSA9PSAwKSB7DQo+ID4gKyAgICAgICAgcyA9IHF0ZXN0X2luaXQoIi1tYWNo
aW5lIGFzdDI3MDAtZXZiIik7DQo+ID4gKyAgICAgICAgcXRlc3RfYWRkX2RhdGFfZnVuYygiL2Fz
dDI3MDAvZ3Bpby9pbnB1dF9waW5zIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHMsIHRlc3RfMjcwMF9pbnB1dF9waW5zKTsNCj4gPiArICAgICAgICBxdGVzdF9hZGRfZGF0YV9m
dW5jKCIvYXN0MjcwMC9ncGlvL291dF9waW5zIiwgcywNCj4gdGVzdF8yNzAwX291dHB1dF9waW5z
KTsNCj4gPiArICAgIH0NCj4gDQo+IEFyZSB5b3Ugc3VyZSB0aGF0IHRoaXMgaXMgZXhlY3V0ZWQg
aGVyZSBhdCBhbGw/IEFzIGZhciBhcyBJIGNhbiBzZWUsDQo+IGFzcGVlZF9ncGlvLXRlc3QgaXMg
bm90IGV4ZWN1dGVkIGZvciB0aGUgYWFyY2g2NCB0YXJnZXQgYXQgYWxsLCBzbyB0aGlzIGxvb2tz
IGxpa2UNCj4gZGVhZCBjb2RlIHRvIG1lLg0KDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24gYW5kIHJl
dmlldy4NCllvdSBhcmUgcmlnaHQuIEkgbG9zdCB0byBtb2RpZnkgdGVzdHMvcXRlc3QvbWVzb24u
YnVpbGQuDQpXaWxsIGZpeCBpdC4NCkphbWluDQo+ICAgVGhvbWFzDQoNCg==

