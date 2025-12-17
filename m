Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D366D6552D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 09:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVoJ6-0002YH-BN; Wed, 17 Dec 2025 04:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vVoIt-0002UY-RF; Wed, 17 Dec 2025 04:58:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vVoIr-0000hL-Uv; Wed, 17 Dec 2025 04:58:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZceR0tyk1A/biAqqhzrNokKaBx1jz309WF30FOZi92hf7YHL80jXKPqJGk8gqIeTgDBIF5jas1Qa6TAw6kgZEpZXwhh/E/96wTp6ZVL/ulTBqf9n85XuTrXU6wjSz6IcQcijpVmHx4bPyy9Q7Hbcx05OkI3vJ8i2nSdJN8UdqO0H57bDU83+77YQLXeyc5A4WZJMQvSLVBLIvXtejNCfbi4AM+7RRakHxjnPIeuW6rymATR5/Bc3tvQX5qVcDjWAxM+FJz1VrYcvBxqOM9MTPDQd1eIbRdFcrvyo7ulWDyU853slwwQBdOVF35W5artYd70KZ1ofqr9JLkyZHiN/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxvjqntZliZloZrYD0cUPOxu06aQcU7JKdHc2zXml8Y=;
 b=NLtLre9ugJw3MvygZDw5b0uKlMvOKF4yN6JzOO6xserlirLfy+W2VnSegH+1YcMp5cQRGX9VilGE7nt+84hSrrNqEyQBlZbWVaQunSPo0xnBzFA9WZwgLtj5PENGVMrYG6SbQ/mKXlUqlWeLxLib69HK/5FKzWGMmr9PO8UYKBvxRDds3gZiN3berQDpV0KFd7koeutZXTQVo32yRzVvyiuKoilpqkQJjZPd6MJYsDYRG6NGSbmGSJavgWWKKHk4USwDzgrdEYB64ZXHFa/KwQc+RqD3OzenaoZE9STrK3tjrvkDQ1TcIRQTDESZUyBOF6nwImRM9Wy5lJuw4dPJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxvjqntZliZloZrYD0cUPOxu06aQcU7JKdHc2zXml8Y=;
 b=jhH2OwldtQE3xZ7hKvmdFCFoRLvBVzHwv452pQEfgUcs1LlVt5SMsVVyXkHG3MkDbG7ph+MqNObnHqAVDH1nBv084o4Ngo5rffFyxAk7nNddP3YNdPyZhLiFDtQmuhch2svMow0RGmAItEstRIwhWo1laIVEfVzL+WT7ROvtqxbf1uWN8CMn3HgunQymJYh1b+F71SbPAYp0fFNUJOPnT/hFOZ5t+TGrmRAlIq5JZooedjw+RYXS9gJ4BIgFIm6WF3h4e74mte9a7aBHdEX0SEzUWpjPTFCV1EvlrK4rOYxD9sV5shIHGaHjHRZdiGXoRHm6VZcfe0QhxQAt898vmg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYSPR06MB6390.apcprd06.prod.outlook.com (2603:1096:400:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:58:36 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:58:35 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nabih Estefan <nabihestefan@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v4 2/6] hw/gpio/aspeed_sgpio: Add QOM property accessors
 for SGPIO pins
Thread-Topic: [PATCH v4 2/6] hw/gpio/aspeed_sgpio: Add QOM property accessors
 for SGPIO pins
Thread-Index: AQHcbus8iiWxcHf3AUWf8p1L39yyNrUljqpg
Date: Wed, 17 Dec 2025 09:58:35 +0000
Message-ID: <SI6PR06MB76311DF8794673BB4C10DD94F7ABA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com>
 <20251217-aspeed-sgpio-v4-2-28bbb8dcab30@google.com>
In-Reply-To: <20251217-aspeed-sgpio-v4-2-28bbb8dcab30@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYSPR06MB6390:EE_
x-ms-office365-filtering-correlation-id: 7946ecdc-7428-4cdc-bb3e-08de3d52d806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eHJlRFJubmxneFh4aDBNWEExZ0lPMHZ3czlZaDFLWnFKa2hNYXFMN0g5WG9B?=
 =?utf-8?B?cEtJc21uOWRRS01ycjNZbEszMjgyYk9SWWxGMmlsOWEyQ3FHd3JFbkVKUnQw?=
 =?utf-8?B?SmNxL3JLZFcrTU14SFRvSkNUOTR6NXVWbXN6eVM3cjBUak9mektHMVhmQ1lw?=
 =?utf-8?B?dUFZRXNXYlB4TWVqZmFWVzB0TW1hUmFDKzBoOU95RmJJWHl0RUNvWnVpa0Jq?=
 =?utf-8?B?UnRWOFhFMHJJcVlhRjNEWGpPaGNMTEg1K3JMclpJZ2ZnT3dqQzVGdnFXZmlS?=
 =?utf-8?B?VmJsWGNJb2lHenR1UHQ4dlpsakhKbmQ0Y2pWYWYrOW94Z2hoMTU4UVkyNnNS?=
 =?utf-8?B?SnNWcm9acUFMTVJVR051TGw5RVhyLzNOSS9SK1J3V1NkU3U5K3o5eWk3N2tU?=
 =?utf-8?B?VFEzRG40a3RTVUx2b0laTCs2VkhOczNOQnp3SWUyK0lRT1lvR0hxempPMW5k?=
 =?utf-8?B?b1BBamFJbzdWZ0FzWUQ1enBiQ01xK2NiZFJ0Z2RBRm1VallNeWxBeGtjUm5Z?=
 =?utf-8?B?eHFwRGs5V3JRYXZSL2pYMXExZDdFc1dJbjdyNjBXZmZUaTQ5dlMzd0xSVUR2?=
 =?utf-8?B?OTJmYTBjckV1N0VOVkNxZHhiS3VqUk5HUGV2aGl6QUtDTHErYll2TEVOT1Nl?=
 =?utf-8?B?M1FxeEltakJmbnhTeWZzZmtvajJ1TTVIWTVXbnltZFp2RmYvQlVWekZRdjEx?=
 =?utf-8?B?VGVYeTVPajN5NzluVElvZG8yUnBSVGh2VWNlUUIxWUxVaytkZjVRZlJXZ09a?=
 =?utf-8?B?UGhraFkxV0RyaUhaMlpYdkhWV04xNjVZelk2ZjVHU2VjQTlaQk10Ukh4QkZr?=
 =?utf-8?B?L0t4QlIvSnpGZTRvem8zeXhKV1V1emZqcWhaeVVNd1M3VmJTNWR2V0NpTERm?=
 =?utf-8?B?ckNLNzU3MnNrMWRrZFJWcXpIWVRra3FhMWpEYXV5K05oTHRieWNGUjVZQ2dO?=
 =?utf-8?B?d3hqV3ovR2pFMkRVSGt6YUM4ZmpEQkZmNnNpcUVuK01kVmZLT2E0b1lwMnJs?=
 =?utf-8?B?a3kwbkh4d0lxaVpIM0YxY2JXaUptV0xLSTVjS3JOZExMUzRVQTR1N3Q0VnFD?=
 =?utf-8?B?Y1BDU0FUYzFMOWRmaWZyWGUxZXFYN2xVR1loMlN2dVRjSGJ5NktIdE43WER2?=
 =?utf-8?B?NWE2Ulc3RXZVU1ZNQThVTU1hRUovbE5BY2JIWE52V1psSUR2THI2THRUVUNR?=
 =?utf-8?B?UHVsM2pYbndFSDRmMjE0cHNQSktHM0I2RTROZUN3dnBXMi9jRTFVT0JYbDhP?=
 =?utf-8?B?NkFWM3FIWU9Yc1BKM2tXcEpYZVprNXJZRkMxb2ZyOXRySjNvNnJJR0dNdFUv?=
 =?utf-8?B?TlhraWpTVjdZZktWUTJTUDVIWVhoZ3JDTy9xMWVaZ2xiTklPWUdvZHdzVitY?=
 =?utf-8?B?MUFWTVE3ZmR1Y1RCWG1PR01xZmlTYTlmbmN3aE5iemdZTDlNR1Q1L1FWcEJO?=
 =?utf-8?B?OHMwVkpYQWpMaDZBcWFIVmtteFRRR3d4bExCbnRvSWV2cHU3RXovKzdhM20z?=
 =?utf-8?B?NExyQlhYL0FWRlZEMUJIWjl2R0pkejJ6UEpsaU1OeXFjSGQwR2w3YnNVbmxM?=
 =?utf-8?B?MmM4eVMvdzVLekMwTllDV1NPUHVXMXdUN242cm1VR0tyenF0UkNnTDJXbm5i?=
 =?utf-8?B?SEdScXF5bnJQbWJNZWpXY3hwMDdFN2RWeTl4M1NQTUxlN05ORS9ISUk3Ziti?=
 =?utf-8?B?TkJHNlE2aDVETzY5cFpyajRtQzYvSThFd3NreHRBTVEyOE9QdXphREZhUmtF?=
 =?utf-8?B?MVp2eVhRZHN2MDNGS0FTZTVkUGNUT3BLbUJSNjhaZFVKdUlEeDBnUENGRFpV?=
 =?utf-8?B?L3ZKZXhpUU9UUlZJdkEzRmoyMUpTbXpzT0VDblMyQ29GNy90cHJ4Lys0RUcw?=
 =?utf-8?B?RkxJb2dCWnpEUmRWSHNlc0ZLbjZ3NFRueEVLYUkrdVB0dzJwZXZNY0Z6cjBq?=
 =?utf-8?B?aS9CUEpMK3B5dTdFKzVWaTdFT3FsYmFQeDB5b3U0dWZMQTZnTDNSb2duRmYy?=
 =?utf-8?B?Wm13YVpLQ29yT29RVldYMmtXY2kxTTJpOXNtOTBEOWNrVjIxdlNqaGJMU2NZ?=
 =?utf-8?Q?hWEh4T?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpZblozMUU0VXNxd2JkSG5zK3h6LzlhdFEyTjFEMVMyUFkyUVZmMzR4TE81?=
 =?utf-8?B?dWdRbTZTQjlOY1JPejV6cVphK2tTVHFPc3JtemNnemRMU3U3RXV0b3dPR284?=
 =?utf-8?B?SW55WVM2am55djhUZGtXMElabU9LOTFzc3d0OFFCeGNFQWJOWXpqQVh3S3NK?=
 =?utf-8?B?azd4ODlNWXZua2FJUUQ1NzNIcVRlN0FlTytYa0p2Yyt0WG1qUkpCYjVyVFlH?=
 =?utf-8?B?WnlwcitHaUdsNUdQUGxUeEV0ckJsc1dtSU9acDZSYUV2ZW9mWTNBVkNqcEVD?=
 =?utf-8?B?U0Z2bGhlSWJ6VjRIcy9Uc3FrQklUVW5BS01FRkpjYkswUzNvMkxMdjA3b0ph?=
 =?utf-8?B?QTdQanZSWnpIR0JwRG5SbHJQYmYyTUdSQU9rVmJsQitGMVZPdThsSDMrY0t6?=
 =?utf-8?B?R0wraDdVYWNJaVRqcUx0UE1Ga29PYkJwSUxDVTJwZS9kM2gxNXVRUUZxbTRQ?=
 =?utf-8?B?Z1BmcW5mQmZjb2k3SjVOOU1xcVJDK2djamJwbnc2NC9BTGQ2VStxNnhueHFI?=
 =?utf-8?B?b2hPQWZtSit1VVViY2FDZG9RUFJvVldzWGliUnFWWjhhdjRxL1lvcjhIeTFP?=
 =?utf-8?B?NDNQNHdrN0JrRVVwYW1IV1hKWkU2RmM4ckh1UlFmSWt0M2VNakdTVkRIZ0Z2?=
 =?utf-8?B?czJtQWhFdjZYeFdJanlUTlI4MWR4L1RVc3d6R1UrOVRmcVR6WDFoeWtmV2tO?=
 =?utf-8?B?dlBNQTFVeGVyUHpxdTgvZm12UVVEZkhuY2tWdkh2SXFucDllYWJwSzgyUEJy?=
 =?utf-8?B?YmFNNUlITTc0QW9KY3EwWkppaE1QVVBxcXhZajVmVW4veVg0WUFXS0hYcldn?=
 =?utf-8?B?RDIwSEord0NVL3VDSjM3bzJuS05ZM09FYUVUV1AwV0xHanpVN1MzcnZMeWd2?=
 =?utf-8?B?K3RVN0pNNS92RFNKL1hhT1l6RkU5enVWcDB4UlpZTHVLam52OERaaS9QMDF3?=
 =?utf-8?B?Ty9ucnEwQk9CQmI4emM1N1RhVGRWV3NyZGp2cjI3OVc3OXBia3VaTGRwZnRO?=
 =?utf-8?B?VUZWMUFoWHVFTEpncHBueVJPaEVmWmVCUVFBQm1HRXlsVVF5aGdKUkx1N3Yz?=
 =?utf-8?B?TkEwUHhPNjFPZk9uSHZhTGcxZEQ4clptVmYzaXRVbllNS3NHNUVOeEE1Z1g3?=
 =?utf-8?B?bVpydnl3cHJ2clZsekVaZERlYzlTdnlUZjhmdU93V0haLy9xeGRIbXQ5MC9r?=
 =?utf-8?B?b3BJK1BDY0xxZGVrV1F5emZyQnVVTGhYRzlBQzgwaW9wNHpxdkdvSTJLVEFv?=
 =?utf-8?B?VlN6Y29sN1oyWVlodnRERFRONG5ZUTlFNTlORjJjdEdyZ1p5ZzFVYTB4V3Ey?=
 =?utf-8?B?ZDhUOVlVT3BtQlg0NU9GMkJoVjVHSFR4SFkyWXo5bzBQTVBETnIyTTNCamk0?=
 =?utf-8?B?ZlAzRXBtdFRvcUgweXNlZ1crKzZkdFlTUnVWNWJTSGpiTGVJd1lXYzJaVWFC?=
 =?utf-8?B?VlNrNWF4WjJXL1htQUxFVjc0dzl0eGFZWjk3d0FzN1AwUjQ3akcwYWRXUURm?=
 =?utf-8?B?MXdOU1FtZXBNTTZUcUtGM3NwRlg2UzhkUkNOdjVnYmRLWFlOZ0gydG01bVFo?=
 =?utf-8?B?SmhVS3NBcEZCc3dBcXFxTUpYMGxrWHBBVXJ4ZVh1dzZEcGwzVmdZTGFvaHNN?=
 =?utf-8?B?aWFabC9sRlRoNElmWTZSQ3hDM05MZDc1UzJsWVNGMVhmR0piMm5pWS9uemY5?=
 =?utf-8?B?TTNhMVB3ellGTTlHc3cyTVlqbHlIcy8vMWdwUW5ZKzBjY1V6WVh1L043NHJZ?=
 =?utf-8?B?N2FmYlZ1RXhxRmZSMTI1WlhGZWIxSVFsNmRSWkdXdngwaFplKy9TRmI5YjQ3?=
 =?utf-8?B?NDlMSVpnVnlUSXEwSjEwRXVRdk1lVnVpYXRvWHFadTJZajBmZm9FSVFHdlpK?=
 =?utf-8?B?Z2RwM3hFaE4wRGZWbmlwVlJSOFZCSzJHSkJqeFRGOHdWOWIxeGMyQUt1Q0xr?=
 =?utf-8?B?eGhjQXZhMHE1bU9XWWJvRkpzWUM1WXI3T3lqU3lIRTVKVGJpSFhWNk95L2JI?=
 =?utf-8?B?QWlIb2RxOVZXWXl3ZU1uNFAzZitkRDVZano4ZnFsVmdYcC8xc1dCMy9QY05a?=
 =?utf-8?B?VFhJN2JNWFB1TW1TTnVORkl4ZVQ1eVJTNzV2d0lqNzJHNkJYNDZCdVFQM1dZ?=
 =?utf-8?Q?1Ha4Lpyb1aah8cCfxhciLzcoN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7946ecdc-7428-4cdc-bb3e-08de3d52d806
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 09:58:35.3914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6qtAnlvdJPZEUGVTo4xu5bas7LqsiDqow+lWF92qphTg1vCDycXx3x5dsQIYbuH3CbC1OpiTslgzvSdCDVlmLmE9ppZYPLWRjZ9zIShahk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6390
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdWJpbiBab3UgPHl1YmluekBn
b29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDE3LCAyMDI1IDg6MjIgQU0N
Cj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0BrYW9kLm9yZz47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFu
ZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5s
ZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gRmFiaWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPjsg
TGF1cmVudCBWaXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT47DQo+IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+OyBLYW5lIENoZW4NCj4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNv
bT47IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPjsNCj4gcWVtdS1hcm1A
bm9uZ251Lm9yZzsgWXViaW4gWm91IDx5dWJpbnpAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHY0IDIvNl0gaHcvZ3Bpby9hc3BlZWRfc2dwaW86IEFkZCBRT00gcHJvcGVydHkgYWNjZXNz
b3JzDQo+IGZvciBTR1BJTyBwaW5zDQo+IA0KPiBUaGUgYGFzcGVlZF9zZ3Bpb19nZXRfcGluYCBh
bmQgYGFzcGVlZF9zZ3Bpb19zZXRfcGluYCBmdW5jdGlvbnMgYXJlDQo+IGltcGxlbWVudGVkIHRv
IGdldCBhbmQgc2V0IHRoZSBsZXZlbCBvZiBpbmRpdmlkdWFsIFNHUElPIHBpbnMuIFRoZXNlIGFy
ZSB0aGVuDQo+IGV4cG9zZWQgYXMgYm9vbGVhbiBwcm9wZXJ0aWVzIG9uIHRoZSBTR1BJTyBkZXZp
Y2Ugb2JqZWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXViaW4gWm91IDx5dWJpbnpAZ29vZ2xl
LmNvbT4NCj4gLS0tDQo+ICBody9ncGlvL2FzcGVlZF9zZ3Bpby5jIHwgNzcNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA3NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvZ3Bpby9hc3BlZWRf
c2dwaW8uYyBiL2h3L2dwaW8vYXNwZWVkX3NncGlvLmMgaW5kZXgNCj4gM2ZjNzUwZmU2MTlkY2I2
ZjlhMWYyNDg2OTk5ZTk0NTAwMmE2ZGYxMy4uZGMyZGYxMzdkYjI0N2MxNzhhZGMwNTgwNw0KPiBi
ZDA1OTVmYzBjYjVjNTIgMTAwNjQ0DQo+IC0tLSBhL2h3L2dwaW8vYXNwZWVkX3NncGlvLmMNCj4g
KysrIGIvaHcvZ3Bpby9hc3BlZWRfc2dwaW8uYw0KPiBAQCAtODQsNiArODQsNzMgQEAgc3RhdGlj
IHZvaWQgYXNwZWVkX3NncGlvXzI3MDBfd3JpdGUodm9pZCAqb3BhcXVlLA0KPiBod2FkZHIgb2Zm
c2V0LCB1aW50NjRfdCBkYXRhLA0KPiAgICAgIH0NCj4gIH0NCj4gDQo+ICtzdGF0aWMgYm9vbCBh
c3BlZWRfc2dwaW9fZ2V0X3Bpbl9sZXZlbChBc3BlZWRTR1BJT1N0YXRlICpzLCBpbnQgcGluKSB7
DQo+ICsgICAgdWludDMyX3QgdmFsdWUgPSBzLT5jdHJsX3JlZ3NbcGluID4+IDFdOw0KPiArICAg
IGJvb2wgaXNfaW5wdXQgPSAhKHBpbiAlIDIpOw0KPiArICAgIHVpbnQzMl90IGJpdF9tYXNrID0g
MDsNCj4gKw0KPiArICAgIGlmIChpc19pbnB1dCkgew0KPiArICAgICAgICBiaXRfbWFzayA9IFNH
UElPX1NFUklBTF9JTl9WQUxfTUFTSzsNCj4gKyAgICB9IGVsc2Ugew0KPiArICAgICAgICBiaXRf
bWFzayA9IFNHUElPX1NFUklBTF9PVVRfVkFMX01BU0s7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAg
cmV0dXJuIHZhbHVlICYgYml0X21hc2s7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGFzcGVl
ZF9zZ3Bpb19zZXRfcGluX2xldmVsKEFzcGVlZFNHUElPU3RhdGUgKnMsIGludCBwaW4sDQo+ICti
b29sIGxldmVsKSB7DQo+ICsgICAgdWludDMyX3QgdmFsdWUgPSBzLT5jdHJsX3JlZ3NbcGluID4+
IDFdOw0KPiArICAgIGJvb2wgaXNfaW5wdXQgPSAhKHBpbiAlIDIpOw0KPiArICAgIHVpbnQzMl90
IGJpdF9tYXNrID0gMDsNCj4gKw0KPiArICAgIGlmIChpc19pbnB1dCkgew0KPiArICAgICAgICBi
aXRfbWFzayA9IFNHUElPX1NFUklBTF9JTl9WQUxfTUFTSzsNCj4gKyAgICB9IGVsc2Ugew0KPiAr
ICAgICAgICBiaXRfbWFzayA9IFNHUElPX1NFUklBTF9PVVRfVkFMX01BU0s7DQo+ICsgICAgfQ0K
PiArDQo+ICsgICAgaWYgKGxldmVsKSB7DQo+ICsgICAgICAgIHZhbHVlIHw9IGJpdF9tYXNrOw0K
PiArICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIHZhbHVlICY9IH5iaXRfbWFzazsNCj4gKyAgICB9
DQo+ICsgICAgcy0+Y3RybF9yZWdzW3BpbiA+PiAxXSA9IHZhbHVlOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgdm9pZCBhc3BlZWRfc2dwaW9fZ2V0X3BpbihPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwg
Y29uc3QgY2hhciAqbmFtZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9p
ZCAqb3BhcXVlLCBFcnJvciAqKmVycnApIHsNCj4gKyAgICBib29sIGxldmVsID0gdHJ1ZTsNCj4g
KyAgICBpbnQgcGluID0gMHhmZmY7DQo+ICsgICAgQXNwZWVkU0dQSU9TdGF0ZSAqcyA9IEFTUEVF
RF9TR1BJTyhvYmopOw0KPiArDQo+ICsgICAgaWYgKHNzY2FuZihuYW1lLCAic2dwaW8lMDNkIiwg
JnBpbikgIT0gMSkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICIlczogZXJyb3IgcmVh
ZGluZyAlcyIsIF9fZnVuY19fLCBuYW1lKTsNCj4gKyAgICAgICAgcmV0dXJuOw0KPiArICAgIH0N
Cj4gKyAgICBsZXZlbCA9IGFzcGVlZF9zZ3Bpb19nZXRfcGluX2xldmVsKHMsIHBpbik7DQo+ICsg
ICAgdmlzaXRfdHlwZV9ib29sKHYsIG5hbWUsICZsZXZlbCwgZXJycCk7IH0NCj4gKw0KPiArc3Rh
dGljIHZvaWQgYXNwZWVkX3NncGlvX3NldF9waW4oT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNv
bnN0IGNoYXIgKm5hbWUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQg
Km9wYXF1ZSwgRXJyb3IgKiplcnJwKSB7DQo+ICsgICAgYm9vbCBsZXZlbDsNCj4gKyAgICBpbnQg
cGluID0gMHhmZmY7DQo+ICsgICAgQXNwZWVkU0dQSU9TdGF0ZSAqcyA9IEFTUEVFRF9TR1BJTyhv
YmopOw0KPiArDQo+ICsgICAgaWYgKCF2aXNpdF90eXBlX2Jvb2wodiwgbmFtZSwgJmxldmVsLCBl
cnJwKSkgew0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArICAgIGlmIChzc2NhbmYo
bmFtZSwgInNncGlvJTAzZCIsICZwaW4pICE9IDEpIHsNCj4gKyAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiJXM6IGVycm9yIHJlYWRpbmcgJXMiLCBfX2Z1bmNfXywgbmFtZSk7DQo+ICsgICAgICAg
IHJldHVybjsNCj4gKyAgICB9DQo+ICsgICAgYXNwZWVkX3NncGlvX3NldF9waW5fbGV2ZWwocywg
cGluLCBsZXZlbCk7IH0NCj4gKw0KPiAgc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBhc3Bl
ZWRfZ3Bpb18yNzAwX29wcyA9IHsNCj4gICAgLnJlYWQgICAgICAgPSBhc3BlZWRfc2dwaW9fMjcw
MF9yZWFkLA0KPiAgICAud3JpdGUgICAgICA9IGFzcGVlZF9zZ3Bpb18yNzAwX3dyaXRlLA0KPiBA
QCAtMTA3LDYgKzE3NCwxNSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc2dwaW9fcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LA0KPiBFcnJvciAqKmVycnApDQo+ICAgICAgc3lzYnVzX2luaXRfbW1pbyhz
YmQsICZzLT5pb21lbSk7DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgYXNwZWVkX3NncGlvX2lu
aXQoT2JqZWN0ICpvYmopIHsNCj4gKyAgICBmb3IgKGludCBpID0gMDsgaSA8IEFTUEVFRF9TR1BJ
T19NQVhfUElOX1BBSVIgKiAyOyBpKyspIHsNCj4gKyAgICAgICAgZ19hdXRvZnJlZSBjaGFyICpu
YW1lID0gZ19zdHJkdXBfcHJpbnRmKCJzZ3BpbyUwM2QiLCBpKTsNCj4gKyAgICAgICAgb2JqZWN0
X3Byb3BlcnR5X2FkZChvYmosIG5hbWUsICJib29sIiwgYXNwZWVkX3NncGlvX2dldF9waW4sDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXNwZWVkX3NncGlvX3NldF9waW4sIE5VTEws
IE5VTEwpOw0KPiArICAgIH0NCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgYXNwZWVkX3NncGlv
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCBjb25zdCB2b2lkICpkYXRhKSAgew0KPiAg
ICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7IEBAIC0xMzYsNiArMjEy
LDcgQEAgc3RhdGljDQo+IGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9zZ3Bpb19hc3QyNzAwX2luZm8g
PSB7DQo+ICAgIC5uYW1lICAgICAgICAgICA9IFRZUEVfQVNQRUVEX1NHUElPICItYXN0MjcwMCIs
DQo+ICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfQVNQRUVEX1NHUElPLA0KPiAgICAuY2xhc3Nf
aW5pdCAgICAgPSBhc3BlZWRfc2dwaW9fMjcwMF9jbGFzc19pbml0LA0KPiArICAuaW5zdGFuY2Vf
aW5pdCAgPSBhc3BlZWRfc2dwaW9faW5pdCwNCj4gIH07DQo+IA0KPiAgc3RhdGljIHZvaWQgYXNw
ZWVkX3NncGlvX3JlZ2lzdGVyX3R5cGVzKHZvaWQpDQo+IA0KPiAtLQ0KPiAyLjUyLjAuMzA1Lmcz
ZmM3Njc3NjRhLWdvb2cNCg0KUmV2aWV3ZWQtYnk6IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVl
ZHRlY2guY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo=

