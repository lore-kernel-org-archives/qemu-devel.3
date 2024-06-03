Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EA2C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE531-0008Vz-6i; Mon, 03 Jun 2024 06:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sE52z-0008VZ-DV; Mon, 03 Jun 2024 06:36:13 -0400
Received: from mail-psaapc01on20726.outbound.protection.outlook.com
 ([2a01:111:f400:feae::726]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sE52u-00064U-T0; Mon, 03 Jun 2024 06:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgKyvPbBnqxm1MSoq8QT93qmP0I7eeLBMIeURZIxdsxTAiFTpYv/LmjycmoUeMrwJvE4Nxd9O1DAH/ZprTMCWXNe4TrcSWt/hD3IiAVBNw3LhQ48SURmvJmNihXUwH1s9caeZcvRvJU5FLl/BPmVmhoCxg2NaPhcU0lTtvZyqnZdZFXPqwmt3rC5/C4+Al30eeo52qZM9EyVpl1u9SvavXn1b4w+EUhkbmVyhZvf1CnGiCBHvZaR2gNIr2v9j+QfzoZaeWKRtHA817TdK7v+fpaHpxEgipVw+c/qb96LCk8CPB3a2XPbEsUw397LxxS1PA2d9Xf+V63z6rKHy3iClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gz2NkQOrQ3cKIbxytSu5OzsS3xA/JlG8MMJTmjBunk=;
 b=EkASPHqrSOg0WV1jv9jEJ5QJlnY6TWiXiaHujmIlljf/1mHKAkVNLRf1GGMnLnee/4EfhPD9Q8FvOYDA9gmiWMyqqdXXO2iZoNtibgxExQrtT59r7l/0oQluxlpKiolYhOtjsqGDHWixQHBAroQ0GK5UxLgeG1jLhEuGvPw+7IYpKf8DuvjlRYJjeg82Uhp7gUlv5kkPdH8u2QKqKKZ/P8BBbiyG0FI+DBuW642UHa2ICnF/Murm3lwr5QeuRiekon38HPGSlAH0Ox5j0L/1L1BEy+EGXhmCnXHcupbhRyZR9ZYj3iwd3u+Jvn4bPvJBrl3/cEE5N/CycpWuEmv0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gz2NkQOrQ3cKIbxytSu5OzsS3xA/JlG8MMJTmjBunk=;
 b=nJzZeocrTaoMy0fcrxx6BsBtyzf1tprU1h4NW+EaH+MWQkb7ekU0NNsQvJx3XIU+/4pUxDgXHil+G7oW8jOLJVT4+02wrX1Lilo778MyTReTffZryaJsjsLymG43FaAJO7WDua+3xRACHanwj84i9B+W5Y5wxUcXwNUFWhPABdyA4kn6kPnthsQjEIPTDNuiZiCb5yEzw2L59Wv1VFfNHJT9dGVkIeaNkrhL7n4FfDYEn1iljYtvR/WVTqf5OSQOoD6BRo9xcZg2Fi66hRwzpIch+O4fsQR6lFCMmEWu/tBbiRO1wS55g4pbcecL0/tmxTAn9WbtEilPyv6mIIdm1Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6563.apcprd06.prod.outlook.com (2603:1096:101:166::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.26; Mon, 3 Jun 2024 10:35:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:35:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
Thread-Topic: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
Thread-Index: AQHasAxD7pGMgs1HT0+SNhsCAW+G/7GrPUCAgAD8sQCACVwRkIAAF4AAgAAms/CAAAT9AIAABz2A
Date: Mon, 3 Jun 2024 10:35:58 +0000
Message-ID: <SI2PR06MB5041FCED8D307124D1747830FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
 <b641018c-e906-452b-8072-1b46f141808b@linaro.org>
 <41e59fa6-c74d-47c7-ba01-690cfaf7f5f1@kaod.org>
 <SI2PR06MB504115C43768F1DF7E9621B9FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <98886224-8de7-41d7-9ae9-77ac85818605@kaod.org>
 <SI2PR06MB5041574C3A7283A1A29B81FCFCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <747755fd-dc9d-4bbd-9b6d-eaabe398bb19@kaod.org>
In-Reply-To: <747755fd-dc9d-4bbd-9b6d-eaabe398bb19@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6563:EE_
x-ms-office365-filtering-correlation-id: 4b350187-6c64-430b-001a-08dc83b8f510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009|921011|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?b0ZueWhBUE9Uc3ZXM0twYndneEQ5MkFxTDFRUEgyMGdqVXV6b1M5bjBUa29U?=
 =?utf-8?B?YXNnR2NUV3l6MGttT2d6NC9UaURRaHpKeVN5YS9nNnY4ek1tZUM5aS9YYmR6?=
 =?utf-8?B?VXdOYmNkdFFIVE8rMjlsYkQ5R00wM2kwVC9HVU92M3FNbGRicnBlb3ZTSHFJ?=
 =?utf-8?B?Mi83NWlRYW1mRDR6M1F0bGE1SHFoK3BhT0tSSk1yK2ZLUlJwUDRaVDhxcjl6?=
 =?utf-8?B?bjBFQi9LSTJIcnppWGZXdjQ0NGhMbGtueURlc0FGM2pST2pDN3RLWnVYdVFE?=
 =?utf-8?B?YVdHVnkydktLNlQwdzcxOWxETGY5R0Y1ZFVRbVY0SVo4eHYrWFVwVzdPZGpD?=
 =?utf-8?B?YWJXNWNad0FOMnJOUVVGN3ovMkd4TFRQaG10Y2Jpdlc4T0RaZFAvR3RwY3Vy?=
 =?utf-8?B?WnU0dHg2amZLaS9JUmRFcmJadEVHNFBrTWs5YjFnNSs3TE1VeFF2cG9lRldB?=
 =?utf-8?B?ZTN4aXZweFB3K0haeEh0WHY4TWNLWUl0MGRjU1lsdmJmVDM3bXE2NXRkS3hR?=
 =?utf-8?B?SFk3dXFsWjJTTDhVZFZEVFdXSEs1ZnpiNFpJblJxSHM1eHVJeUF3Vm14N3hI?=
 =?utf-8?B?ZmE5RGsrWXNtL1dZZzNvcFNZWnB3TjRQSGdvcEdVdSszOEU2ZmI5ZTZFUnFN?=
 =?utf-8?B?VldiUzFaUzJQbXVpb1MwajdqT0Q2RnRhYzVEWG9BSUxFVjhxbTZjYkdqVGVj?=
 =?utf-8?B?YXJQYmpBNm00OFZxaldIcUlFbDdIVjZVdHhkNWhHMVkrUW5tNkZ3N3NBcXh5?=
 =?utf-8?B?TlFLYnc5bmtoaytHTHYvc21TOVZqUHBRQTQ3Qzd1czJpSDBuS3VtQzBBeXhD?=
 =?utf-8?B?TVhqaGpNWGJZSVNyQTFueUF4byszQUxYVUwyS3Rqb3NnaDdpNmsxYUd2ZnJm?=
 =?utf-8?B?V0dQR0JHY3l3YTRoRVc0N0ZYNkt1N2hTUEhoZVpSMlh1dXo1cDBoWHQ5VDlW?=
 =?utf-8?B?bGdzR3Rpbk5GRXlvdUpWUjNsTWNVTUFtdlVZUlRKanJjRW85ZXR2bFdONTZ6?=
 =?utf-8?B?b1dFT29oZkpSOEVxYnV1YjR6V1U0eUFLV0NtczllR3lGTWxDOXV0NEdzUXJT?=
 =?utf-8?B?NW5RQXRXcGlPclNWSnZXbWVhRFF2dklhVzJQUDVzWmlTUGoyWUVDTHlMNGU5?=
 =?utf-8?B?RVZUaDhpcUVnckNwbnJZc1BjY2V5NWNGS1lSSXRPQWtJbVd3MXQ2V3BJanYw?=
 =?utf-8?B?Q0Q4SkhTZFcreFpJTUVIZGZuNlI3aG8yZ2o2QThPU3IrSDZ2K01keGxVUnpD?=
 =?utf-8?B?eVgzaWdsMEpkV2dFS1BxOW9aQjNqaThZNWtFcWc5ZU9jVXl4Tkw2akRJR0Z5?=
 =?utf-8?B?anppREViL2g2anlSVzYrdjJWZ2dHR2Y2ZUdGd3diRTU4ekR2QWZObmJKZnhs?=
 =?utf-8?B?YW51R1FPRGxlTFRjRmJra0VzSnQ4UmZibzVzMFBhKzhISXppQ3VvbEhSa0tm?=
 =?utf-8?B?Yys5WjE0dHF1ck85WEpyZTRKdndaelJpa01iTTcwWWNhOThOUjd2RDR5c2dr?=
 =?utf-8?B?RU5teDR5Yi9qOGlDQy8wdWpuQVo3bkZkVnRpcjRCb3BMdlRTV2NIUzVGa1pQ?=
 =?utf-8?B?Q3hSQ2xNcHRnMEFmR0s1eUpIUUUvSXM5ZVJYSkpkN0tkK0c0dkIzUnJScC9B?=
 =?utf-8?B?ZDdzcWdLMW1iNVJXMFVaek4rem9PU29Ka01vck14YUpHSVRVUUVvZTZ6YVpx?=
 =?utf-8?B?ZDRkZ1Z3Q21xMGNSM2lUM0Vlc0l1MWhGalRKMFNQR05aTi9heHJuTmduNi9i?=
 =?utf-8?B?Y1k0NzNtTVpobytJb3VFR2N1QzJOQ2EvcVlOTnU5dDVtU0ZHL2VMS25IRS9U?=
 =?utf-8?B?dGNvaGJaNmp0aGRZOEU4OVd3M1MrTXNIZnh6L3pnM0RwV0FGTFk4UHZDUU1j?=
 =?utf-8?Q?R1JlvCSxwp/al?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009)(921011)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFzQmd2QUk4RWMvbm9uZ0NwRlJ5SGRsL3FEWEtHMHZwRlNOSEpQZEM3Mjkr?=
 =?utf-8?B?dUF2NkpNT0J4MjJMZmJKeENuKzVBSzd3Zk51S3Y3QnU3dW9BV1Y2RnZWTSti?=
 =?utf-8?B?SUE1SHNjd0oyTTl3TEUzZWp0UUVOd044b2EvRlpmYzZubW55SWlpMU93M1Zu?=
 =?utf-8?B?SG9yRTBmYXhucWlNaWtaUVVtV0huWk5Dd0JlNjh4T3pHZUVFOVhtclFlaW5F?=
 =?utf-8?B?M0IrVEY0SHNDNE5sMm9HNzV0TGJEdUFGMTlyaGpiZDJDL05XU2pzbGJNbWlh?=
 =?utf-8?B?Q2NDYWZyR2N3d3RISUJoMi8rQnZaQmxMdGorY3M4NjY1LzdLak02QkpSaW9C?=
 =?utf-8?B?N3dYN1Z2WndNVTg4THVnOUFNUVQ2bk1LeUJhR0pIbFZmZnlSUFBtL0FUR3Jj?=
 =?utf-8?B?NUJ1L3lxK2gyNFZDd0dWUlo1UmN3L0FMR1dZZlVJbkhNSHZYOHQwc25KbW1k?=
 =?utf-8?B?eXBhWXI4Y3RXbVpzdjlrZG9WK2ViVFNyVFVLOU81TENaeU11Vi85QjBJY1Bo?=
 =?utf-8?B?dlM2MjR1YktQbFZEb2Fkdk5sd242RVRuQk9LSnNycEcvZUg0QnQ2czRKcWI4?=
 =?utf-8?B?aFdRVmtSdnFiK245czJNM1JsNitJN1F2VDY1US8vK2NPUjhFT3N2RkZ3aXhy?=
 =?utf-8?B?OEtnR0s1QUt5WXRtNityYUhGMW1FY0kxVHRUcCs4eUtQdG81dzhKQWhjc05S?=
 =?utf-8?B?b3RXQ0RuSUx4eHFINnpqSnhQaWgxNDlYTGNnb0xSdlJDeThGRllyR1pSVkl1?=
 =?utf-8?B?RVJuNkoxYnRnTTV0TGEveEhpUmpSWUZzQmlPcjB5NVpQQTV4eThabnNPT0dN?=
 =?utf-8?B?YXBGTGtoQ2ZrR3BUSXM0MkpCby9yblUrZzdDZDg1ZFVWZVhRZ0hNNHZNUXR1?=
 =?utf-8?B?VWNOczFBQW5yMXBVRU80NFY3QmVtN0JENmE2cjhLWHZpK0J2WTZWTFZ5UHhn?=
 =?utf-8?B?NXZSTExCWjJRbUhSTUpKWERSbERseGFvbisrc1VmdC9BV0tJdmdJaUVRT0g4?=
 =?utf-8?B?ZVJOOUYzRmUwRXlIM1lpM0JMcEZVWk92QndxVDZlQ2doOWtVRTFYUDA4bGli?=
 =?utf-8?B?SVdxOHpNalB2WlBHUVo0bHczSWVaaW9YUCtyYlFkUDZMZVVkUkdHMTU3cGJR?=
 =?utf-8?B?VnZzMlo3c1MzZDJkUmV0SDVxakZScVIvQTNhMTByYXBwVmJySnNEU2ZTL2k3?=
 =?utf-8?B?aFVSK2dJUXM1dUhHSUd5elNnYkNRM2ZOMUwvcTdQWEJkVmRId2JXQVJsTm1y?=
 =?utf-8?B?K1c4UVZZNW5rMXV5TnduT0xXQk90VEtpdjhzUi9JdkdUVU4ydnhiR1FIN3R4?=
 =?utf-8?B?ZFIxVm1LTDExVkl0ZVdqMmROaTVsVVNoWW12M2IzazAvM3pkVm9rT2NhNlJi?=
 =?utf-8?B?NmhnWmxEYjFnZVZhNnVOR0dPeW9YalhtcHVyU3Y1emEzZ3BEYjBNdndhcXVx?=
 =?utf-8?B?VVVCaGFveU9JMitvcWFza1Y4clRSd29MT2VLSnhBNXhHclgvaitDZ3FMR1Fa?=
 =?utf-8?B?a2t0REpiQndHSXhPQlQ3T3lMbjJtaVZMQlNsL1dtOXk2WWxhSmtnMksvUHY4?=
 =?utf-8?B?SGdXNmd3Z2RjMzRiM0x1T1NRYzlqTEtWeE8rTDVwU2RhSU0vZTNUa1BqZUpp?=
 =?utf-8?B?UVNDWm5Fc3kzbWE4REtKM1AzRWV0aHFMVmhxSUp5ME04b0YzaWptTlBrOG9N?=
 =?utf-8?B?b0h4Q1RQeGhWSDVwK0lwWFVqa05SUkJVdE9vTzM1cURJZjRLYlVsaU9Qdll5?=
 =?utf-8?B?bVhJaXMxY2tobDlMZHQ5NXF5T0ZqajkzcVU5ZEZFOStCMzk1bVBQbFhvLzVm?=
 =?utf-8?B?K3NIZXA3czZLSHdYV3NhYy9WVHVtWTljbVdtSW80cjlJV1BVK0RRVmI3amlw?=
 =?utf-8?B?Z2FCTmNRc29ZVlhkTnZJeko0M2xERnZ6TGtBOGcxRmxMaFRSQ1RUZkVPVjl4?=
 =?utf-8?B?Sk9hWGJPY0hCVSt3S0UwYXJma1dGUFQyZ0NCZE1RWGxLWExENTdPU2FPVHRR?=
 =?utf-8?B?a3JZU2Y2ZUhZQU5wTHhNdnhyMldPYlpvQ2ZtQ0FxZHZ2L0plTm9OMTdjc3Vl?=
 =?utf-8?B?MmlwcU1mMUMrckZIcWdMQit0MEVyZkd1eUJFVmIrQ3E0YjJCeFZoTzR0d2VD?=
 =?utf-8?Q?c6s8P9gPPTEzXmDSrsxqDAGzr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b350187-6c64-430b-001a-08dc83b8f510
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 10:35:58.7957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNhVv5qG32DPLKdR83gw3R2bGrEazJXM2t7mJMlFYgEMggLxd6dpWcLqMmnCGZoafspkmGP2NdYOG5tXhjU36+hnlVuJD1IgTgMoqSiCX4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6563
Received-SPF: pass client-ip=2a01:111:f400:feae::726;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbU1BBTV0gUmU6IFtQQVRDSCB2NCAwOS8xNl0gYXNwZWVkL3NtYzogQWRk
IEFTVDI3MDAgc3VwcG9ydA0KPiANCj4gT24gNi8zLzI0IDExOjQ5LCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gSGkgQ2VkcmljLA0KPiA+DQo+ID4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
a2FvZC5vcmc+DQo+ID4+IFN1YmplY3Q6IFJlOiBbU1BBTV0gUmU6IFtQQVRDSCB2NCAwOS8xNl0g
YXNwZWVkL3NtYzogQWRkIEFTVDI3MDANCj4gPj4gc3VwcG9ydA0KPiA+Pg0KPiA+Pj4+Pj4gQEAg
LTY3MCw3ICs2NzAsNyBAQCBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzDQo+ID4+Pj4gYXNw
ZWVkX3NtY19mbGFzaF9vcHMNCj4gPj4+Pj4+ID0gew0KPiA+Pj4+Pj4gICDCoMKgwqDCoMKgIC5l
bmRpYW5uZXNzID0gREVWSUNFX0xJVFRMRV9FTkRJQU4sDQo+ID4+Pj4+PiAgIMKgwqDCoMKgwqAg
LnZhbGlkID0gew0KPiA+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgLm1pbl9hY2Nlc3Nfc2l6
ZSA9IDEsDQo+ID4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgLm1heF9hY2Nlc3Nfc2l6ZSA9IDQsDQo+
ID4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLm1heF9hY2Nlc3Nfc2l6ZSA9IDgsDQo+ID4+Pj4+DQo+
ID4+Pj4+IElzIHRoaXMgYSBidWdmaXg/IElmIHNvLCBwbGVhc2UgdXNlIGEgc2VwYXJhdGUgcGF0
Y2guIE90aGVyd2lzZQ0KPiA+Pj4+PiBwbGVhc2UgbWVudGlvbiB3aHkgaXQgaXMgT0sgdG8gd2lk
ZW4gYWNjZXNzIGZvciBBU1QyNjAwICYgQVNUMTB4MC4NCj4gPj4+Pg0KPiA+Pj4gQWNjb3JkaW5n
IHRoZSBkZXNpZ24gb2YgU1BJIGRyaXZlcnMsIGl0IHVzZXMgdGhpcyAibWVtY3B5X2Zyb21pbyIN
Cj4gPj4+IEtFUk5FTCBBUEkNCj4gPj4gZm9yIFNQSSBjYWxpYnJhdGlvbi4NCj4gPj4+DQo+ID4+
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iLzEwNjJhMDc0
MjBmOWFlZDRlZDdkYzlkZQ0KPiA+PiBiDQo+ID4+PiAzNDI5YjhlNzgyOGY1Y2YvZHJpdmVycy9z
cGkvc3BpLWFzcGVlZC1zbWMuYyNMMTgzMg0KPiA+Pj4gQVNUMjcwMCBpcyBhIDY0IGJpdHMgcXVh
ZCBjb3JlIGNwdXMoQ29ydGV4LWEzNSksIHNvIGtlcm5lbCBBUEkgdXNlDQo+ID4+PiA2NCBiaXRz
IGZvcg0KPiA+PiBkYXRhIGFjY2Vzcy4NCj4gPj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRU
ZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoDQo+ID4+PiAvYQ0KPiA+
Pj4gcm02NC9rZXJuZWwvaW8uYyNMMjUgSSBzaW1wbHkgc2V0IHRoZSBtYXhfYWNjZXNzX3NpemUg
dG8gOCBmb3INCj4gPj4+IEFTVDI3MDAgc3VwcG9ydC4NCj4gPj4+IEFTVDI1MDAsIEFTVDI2MDAg
YW5kIEFTVDEweDAgYXJlIGFsbCAzMmJpdHMgQ1BVUywgdGhhdCB3YXMgd2h5IHRoaXMNCj4gPj4g
bWF4X2FjY2Vzc19zaXplIDggZGlkIG5vdCBpbXBhY3QgdGhlc2UgbW9kZWxzLg0KPiA+Pj4gaHR0
cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12
Ni42L2FyY2gNCj4gPj4+IC9hDQo+ID4+PiBybS9rZXJuZWwvaW8uYyNMNDUNCj4gPj4NCj4gPj4g
WWVzLiBJIHRoaW5rIHdlIGFyZSBzYWZlIG9uIHRoYXQgc2lkZS4NCj4gPj4NCj4gPj4+IElmIHlv
dSBoYXZlIGFueSBzdWdnZXN0aW9uIGFib3V0IHRoaXMgcGF0Y2ggbW9kaWZpY2F0aW9uLCBwbGVh
c2UgbGV0IG1lDQo+IGtub3cuDQo+ID4+PiBJIGFtIGdvaW5nIHRvIHJlLXNlbmQgdjUgcGF0Y2gg
Zm9yIEFTVDI3MDAgc3VwcG9ydC4NCj4gPj4NCj4gPj4gUGxlYXNlIG1vdmUgdGhpcyBjaGFuZ2Ug
aW4gaXRzIG93biBjb21taXQgZXhwbGFpbmluZyB0aGUgcmVhc29uIGFuZA0KPiA+PiBhZGQgYSBU
T0RPIGNvbW1lbnQgaW4gdGhlIGNvZGUuDQo+ID4+DQo+ID4+IFRoZSBhc3BlZWRfc21jX2ZsYXNo
X29wcyBNZW1vcnlSZWdpb25PcHMgc2hvdWxkIGJlIGNvcGllZCBpbg0KPiA+PiBfcmVhbGl6ZSgp
IHRvIHNldCBhIGRpZmZlcmVudCB3aWR0aCBmb3IgdGhlIEFTVDI3MDAgU29DLiBZb3UgY291bGQg
ZG8gdGhhdA0KPiB0b28uDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4NCj4gPj4gQy4NCj4gPiBJ
IHdpbGwgZG8gdGhlIGZvbGxvd2luZyBjaGFuZ2VzLiBDb3VsZCB5b3UgZ2l2ZSBtZSBhbnkgc3Vn
Z2VzdGlvbj8NCj4gPg0KPiA+IDEuIGFkZCBhc2MtPm1heF9hY2Nlc3Nfc2l6ZSA9IDggaW4gYXNw
ZWVkXzI3MDBfZm1jX2NsYXNzX2luaXQsDQo+ID4gYXNwZWVkXzI3MDBfc3BpMF9jbGFzc19pbml0
LCBhc3BlZWRfMjcwMF9zcGkxX2NsYXNzX2luaXQgYW5kDQo+ID4gYXNwZWVkXzI3MDBfc3BpMl9j
bGFzc19pbml0IDIuIFVwZGF0ZSBhc3BlZWRfc21jX2ZsYXNoX3JlYWxpemUgYXMNCj4gPiBiZWxv
dyBzdGF0aWMgdm9pZCBhc3BlZWRfc21jX2ZsYXNoX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwg
RXJyb3IgKiplcnJwKQ0KPiB7DQo+ID4gICAgIC0tLS0tLQ0KPiA+ICAgICBzLT5hc2MgPSBBU1BF
RURfU01DX0dFVF9DTEFTUyhzLT5jb250cm9sbGVyKQ0KPiA+ICAgICBpZiAocy0+YXNjLT5tYXhf
YWNjZXNzX3NpemUgPT04KSAtLT4gY2hlY2sgbWF4X2FjY2Vzc19zaXplDQo+ID4gICAgICAgIGFz
cGVlZF9zbWNfZmxhc2hfb3BzLnZhbGlkLm1heF9hY2Nlc3Nfc2l6ZSA9DQo+IHMtPmFzYy0+bWF4
X2FjY2Vzcw0KPiA+IC0tPiB1cGRhdGUgbWF4X2FjY2Vzc19zaXplDQo+IA0KPiBZb3UgY2FuIG5v
dCBiZWNhdXNlIGFzcGVlZF9zbWNfZmxhc2hfb3BzIGlzIGEgc3RhdGljIGNvbnN0IHNoYXJlZCBi
eSBhbGwNCj4gbW9kZWxzDQo+IA0KPiBCZXN0IG9wdGlvbiBpcyB0byBpbnRyb2R1Y2UgYSBuZXcg
J2NvbnN0IE1lbW9yeVJlZ2lvbk9wcyonIGF0dHJpYnV0ZSBpbg0KPiBBc3BlZWRTTUNDbGFzcyBh
bmQgdXNlIGl0IGluIGFzcGVlZF9zbWNfZmxhc2hfcmVhbGl6ZSgpLg0KPiANClRoYW5rcyBmb3Ig
eW91ciBzdWdnZXN0aW9uLiBIb3cgYWJvdXQgdGhlc2UgY2hhbmdlcz8NCg0KMS4gYXNwZWVkX3Nt
Yy5oDQpzdHJ1Y3QgQXNwZWVkU01DQ2xhc3Mgew0KICAgIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyAq
cmVnX29wczsNCn0NCg0KMi4gYXNwZWVkX3NtYy5jDQphLiBjcmVhdGUgbmV3IG1lbW9yeSByZWdp
b24gb3B0cyBmb3IgYXN0MjcwMCANCnN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgYXNwZWVk
XzI3MDBfc21jX2ZsYXNoX29wcyA9IHsNCiAgICAucmVhZCA9IGFzcGVlZF9zbWNfZmxhc2hfcmVh
ZCwNCiAgICAud3JpdGUgPSBhc3BlZWRfc21jX2ZsYXNoX3dyaXRlLA0KICAgIC5lbmRpYW5uZXNz
ID0gREVWSUNFX0xJVFRMRV9FTkRJQU4sDQogICAgLnZhbGlkID0gew0KICAgICAgICAubWluX2Fj
Y2Vzc19zaXplID0gMSwNCiAgICAgICAgLm1heF9hY2Nlc3Nfc2l6ZSA9IDgsDQogICAgfSwNCn07
DQoNCmIuIHNldCBtZW1vcnkgcmVnaW9uIG9wdHMgaW4gYWxsIG1vZGVsIGNsYXNzIGluaXQNCnN0
YXRpYyB2b2lkIGFzcGVlZF8yNDAwX3NtY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywg
dm9pZCAqZGF0YSl7DQogICAgYXNjLT5yZWdfb3BzICAgICAgICAgICA9ICZhc3BlZWRfc21jX2Zs
YXNoX29wczsNCn0NCnN0YXRpYyB2b2lkIGFzcGVlZF8yNDAwX2ZtY19jbGFzc19pbml0IChPYmpl
Y3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpew0KICAgIGFzYy0+cmVnX29wcyAgICAgICAgICAg
PSAmYXNwZWVkX3NtY19mbGFzaF9vcHM7DQp9DQpzdGF0aWMgdm9pZCBhc3BlZWRfMjQwMF9zcGkx
X2NsYXNzX2luaXQgKE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSl7DQogICAgYXNjLT5y
ZWdfb3BzICAgICAgICAgICA9ICZhc3BlZWRfc21jX2ZsYXNoX29wczsNCn0NCnN0YXRpYyB2b2lk
IGFzcGVlZF8yNTAwX2ZtY19jbGFzc19pbml0IChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRh
dGEpew0KICAgIGFzYy0+cmVnX29wcyAgICAgICAgICAgPSAmYXNwZWVkX3NtY19mbGFzaF9vcHM7
DQp9DQpzdGF0aWMgdm9pZCBhc3BlZWRfMjUwMF9zcGkxX2NsYXNzX2luaXQgKE9iamVjdENsYXNz
ICprbGFzcywgdm9pZCAqZGF0YSl7DQogICAgYXNjLT5yZWdfb3BzICAgICAgICAgICA9ICZhc3Bl
ZWRfc21jX2ZsYXNoX29wczsNCn0NCnN0YXRpYyB2b2lkIGFzcGVlZF8yNTAwX3NwaTJfY2xhc3Nf
aW5pdCAoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKXsNCiAgICBhc2MtPnJlZ19vcHMg
ICAgICAgICAgID0gJmFzcGVlZF9zbWNfZmxhc2hfb3BzOw0KfQ0Kc3RhdGljIHZvaWQgYXNwZWVk
XzI2MDBfZm1jX2NsYXNzX2luaXQgKE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSl7DQog
ICAgYXNjLT5yZWdfb3BzICAgICAgICAgICA9ICZhc3BlZWRfc21jX2ZsYXNoX29wczsNCn0NCnN0
YXRpYyB2b2lkIGFzcGVlZF8yNjAwX3NwaTFfY2xhc3NfaW5pdCAoT2JqZWN0Q2xhc3MgKmtsYXNz
LCB2b2lkICpkYXRhKXsNCiAgICBhc2MtPnJlZ19vcHMgICAgICAgICAgID0gJmFzcGVlZF9zbWNf
Zmxhc2hfb3BzOw0KfQ0Kc3RhdGljIHZvaWQgYXNwZWVkXzI2MDBfc3BpMl9jbGFzc19pbml0IChP
YmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpew0KICAgIGFzYy0+cmVnX29wcyAgICAgICAg
ICAgPSAmYXNwZWVkX3NtY19mbGFzaF9vcHM7DQp9DQpzdGF0aWMgdm9pZCBhc3BlZWRfMTAzMF9m
bWNfY2xhc3NfaW5pdCAoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKXsNCiAgICBhc2Mt
PnJlZ19vcHMgICAgICAgICAgID0gJmFzcGVlZF9zbWNfZmxhc2hfb3BzOw0KfQ0Kc3RhdGljIHZv
aWQgYXNwZWVkXzEwMzBfc3BpMV9jbGFzc19pbml0IChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQg
KmRhdGEpew0KICAgIGFzYy0+cmVnX29wcyAgICAgICAgICAgPSAmYXNwZWVkX3NtY19mbGFzaF9v
cHM7DQp9DQpzdGF0aWMgdm9pZCBhc3BlZWRfMTAzMF9zcGkyX2NsYXNzX2luaXQgKE9iamVjdENs
YXNzICprbGFzcywgdm9pZCAqZGF0YSl7DQogICAgYXNjLT5yZWdfb3BzICAgICAgICAgICA9ICZh
c3BlZWRfc21jX2ZsYXNoX29wczsNCn0NCg0Kc3RhdGljIHZvaWQgYXNwZWVkXzI3MDBfZm1jX2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0Kew0KICBhc2MtPnJlZ19v
cHMgICAgICAgICAgID0gJmFzcGVlZF8yNzAwX3NtY19mbGFzaF9vcHM7DQp9DQpzdGF0aWMgdm9p
ZCBhc3BlZWRfMjcwMF9zcGkwX2NsYXNzX2luaXQgKE9iamVjdENsYXNzICprbGFzcywgdm9pZCAq
ZGF0YSkNCnsNCiAgYXNjLT5yZWdfb3BzICAgICAgICAgICA9ICZhc3BlZWRfMjcwMF9zbWNfZmxh
c2hfb3BzOw0KfQ0Kc3RhdGljIHZvaWQgYXNwZWVkXzI3MDBfc3BpMV9jbGFzc19pbml0IChPYmpl
Y3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQp7DQogIGFzYy0+cmVnX29wcyAgICAgICAgICAg
PSAmYXNwZWVkXzI3MDBfc21jX2ZsYXNoX29wczsNCn0NCnN0YXRpYyB2b2lkIGFzcGVlZF8yNzAw
X3NwaTJfY2xhc3NfaW5pdCAoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0Kew0KICBh
c2MtPnJlZ19vcHMgICAgICAgICAgID0gJmFzcGVlZF8yNzAwX3NtY19mbGFzaF9vcHM7DQp9DQoN
CmMuIHVwZGF0ZSByZWFsaXplIHRvIHVzZSBtZW1vcnkgcmVnaW9uIG9wdHMgZnJvbSBjbGFzcyBy
ZWdfb3B0cyANCnN0YXRpYyB2b2lkIGFzcGVlZF9zbWNfZmxhc2hfcmVhbGl6ZShEZXZpY2VTdGF0
ZSAqZGV2LCBFcnJvciAqKmVycnApIHsNCiAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPm1t
aW8sIE9CSkVDVChzKSwgcy0+YXNjLT5yZWdfb3BzLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICBzLCBuYW1lLCBzLT5hc2MtPnNlZ21lbnRzW3MtPmNzXS5zaXplKTsNCn0NCg0KVGhhbmtzLUph
bWluDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

