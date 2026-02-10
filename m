Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61767E94627
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdPN-0002Pa-H4; Mon, 09 Feb 2026 21:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdPL-0002LN-07; Mon, 09 Feb 2026 21:23:19 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdPI-0007CN-SA; Mon, 09 Feb 2026 21:23:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/PLRCfG2v+RITqEt6kE2OSrWPI0CD2KYSCo4+cvJUpnX4suNCRmvckl8BDaMNz2p8cBvu0IGbSyEJ/rUGuA0+lE1bWD/KztHuhobPgL/h58wEirk2mCg4bIiMIl//0MVHngtjsNzUEaZVAeP1SISK3vMbhIZdSbWaBpngsCxAEJxmPOnwsFGq8I2AHlB3MeL/oHxXzSwuI8mQU9JRB6lh7GCQIpx9fmol15BmXfG0NsV7kgXNhLDvXJD9XULLl5xPDo/j4sEONoidj7e8MvnjN7hR+HJvNRb2UK2dFHP/bcsfKcmYpSCbDuVv2gcVeigh6xXxg8+5lopIFkB0Bn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+uAaWRqaUFL758szmIdiVpfbbPP/LctjxjQtq/L564=;
 b=ltDCMXSHwoLmhbTBkHLyfViy1vRVbtJ2gNGcWoGj9+h4egAwKaBTWoGxU4CjcsTjzBDVosNOpzUoAPmISSmr10O7mMHqsrlx/KpReIyZ3QQmXiFPe9dpR9f1EilM0bZHPOZ1V+8TMGdVFVtw60MtDQyUeH30fbHxn6Wf30V1XVIYS6WELZCgMjriBKxfzUi+wd6EBiFIjUZk9fYdO4swlKhqgKymvHxx64epKAYGm8zmcMlYNYJFiF7BcF33wOHsziYlr2deC+XHfmsW114NiKA5zyuSvcCx/nF39gyCDkTSLB9Q2/xYgwCzP/VXRX9WWu9jBTtnJy6TMPSdytfmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+uAaWRqaUFL758szmIdiVpfbbPP/LctjxjQtq/L564=;
 b=In9OfuYanJrA04rgBIYXcA+cZDprS47hPnv1RkoW9qgdmwz4It8mV5W21/rlMo5KomM1JPNLBftFdq3rLQ+LTTGGrIkry3GBPg2RIkniDukt1nMCD0W7GBOaK0WwCEVgshDBd47OFgig8y09YaQMliM+GKj6X9dIiadL/lvw1Ys1CHx8ZqlIOeP4iyFPLn/Mk/g0Lcig6di0H9XW7IxfxEJrW6BXmrG/6Yl5lnuG1ueihWw7ITysTeHxEX5UDra47GdhHPNoDOvrF9QOhIWM3cVduUX2ccfhhYYt8oR72Y/R558OeML8dGQsUoPnZYeJwqLFfMfm9nYlwysqEGEI4g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB7987.apcprd06.prod.outlook.com (2603:1096:d10:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 02:23:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:23:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using
 dynamic register array
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using
 dynamic register array
Thread-Index: AQHcmWXMoUJBn9wsH0SaWe2SvMw7ULV6B4+AgAEtYJA=
Date: Tue, 10 Feb 2026 02:23:06 +0000
Message-ID: <TYPPR06MB820678CA1089C1C63002F2C4FC62A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260209014540.823794-1-jamin_lin@aspeedtech.com>
 <31a22691-3b03-4ea4-bec3-79ec8aadaa99@kaod.org>
In-Reply-To: <31a22691-3b03-4ea4-bec3-79ec8aadaa99@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB7987:EE_
x-ms-office365-filtering-correlation-id: 6c940cfa-6143-406a-4362-08de684b53c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z3U1aDM5ZkgweGFHTlNSc3hiczB4Vm5lbGw0a0llSXlTUThndjIzRFJnOTJH?=
 =?utf-8?B?Qm1ncUMzNTdqSWZGWU1JZGh5ZDI5QzRwZWsrVmFUa0VtWk5XcDg2cEJvSzBM?=
 =?utf-8?B?bnFzcFplanNqcmFnNHo3SS94dDZiaTJtRTdlQVlhSWlYbEplcTFocXQzZWE4?=
 =?utf-8?B?VzUxQThSSENvRUxnRDZHbXpEWmNYQ2xhZkhURjlVR0JXVUZ3aG5uU0tJeUlt?=
 =?utf-8?B?UnM0Y2NUSDB2NTBrSzNtRmExKzdlN2lsOC9Xc3FUejZLT0VGUThDc2d4ck1l?=
 =?utf-8?B?NTRPc3NoamVwNUFYV2t1V2N3TW54RkVLcFFHRHlOZEszLzVieXFIMVNwZVYz?=
 =?utf-8?B?b0Rvb2Q4cUN3bWZVZEV2WkQ4MkZjTWZYNjFFeFpPNCs0RmFZQjQ1K29TTWl3?=
 =?utf-8?B?SWYvTEMrLzVoRS93OTBMcDNTMm1GcndqUkxCOUVyOW4yTlM1WUhhSHZuWS8w?=
 =?utf-8?B?bElYakFpNEF1eG1Bb0NuT3NZTXBYUHlhVVMzbDl0M2M0NVNtVVJqUVNiM2hR?=
 =?utf-8?B?UDZFOGJUdlZ2Uk1tTjRwTHpmbWpFZHBsM0xnZXJBL1A1RExPUXorK21KMlYr?=
 =?utf-8?B?VjJIU0lEZkpxV0tyTmZ3eTRLOUVhV1lxKzkxMGtZNzVweW5uWktIa3hPVWRG?=
 =?utf-8?B?eER1TFVkYzRJcy9wR05DTTQwa2F5RklIbGMzM1lkdjhVZFJxeWhJdytrNGor?=
 =?utf-8?B?VHY4R1JFNFcxUmpqTEI5cFcrc2JHTGlJYUtFNUhoclB2RmZ2NW5uc0h4clF0?=
 =?utf-8?B?SWVkaHJIU3ZkMHlBbU91ZDlrQjcxS1M0TWZaelBFYmpRV1BsUFpramY1UkFK?=
 =?utf-8?B?SWpMTGNUVEJTMnpYT1FXN0lqaVBEV3RPZ3hZLzFTdDRla3hINWUwVGJ6WFhX?=
 =?utf-8?B?RHZCWlNGcCtvMzNXVlhWZlF6aXlHK01JYjlHUFUxVVRhdzlSS3dyZWdWdW1C?=
 =?utf-8?B?eDh3eEp6endkeFJsTU9EcWxQdVlnMEhpd2JrZUszTEQ2b20xU0ducFhPb1pZ?=
 =?utf-8?B?QjEyYnZuNUFiQUhrNXJERnN5dHpnU3BQaXpBdVUyWHZlTjdWOUNsU2J0TGQz?=
 =?utf-8?B?d1lvcmhocERVbUNLVCtiazg2bE4rdkw5Q2ZLK1RTSzNDbnRqUTFIYmpxQUk0?=
 =?utf-8?B?czIxallpdk91L1U0L1hsWHFiWHBJQ1MxZHlRa0lkbDhVZFdnNHNCeXVYZmJU?=
 =?utf-8?B?Rm9jWENIRk92cGt4OXlkRnRVMjN5NmcyeGJXUUpXVUdjei9jbG42eVAwUWdR?=
 =?utf-8?B?MVZLN2FPS2Irbm8rd2FmTWxsYVpJQzRuV3Z6VXVlNFhRRlFMMzBFNmZLYWRX?=
 =?utf-8?B?MEhDWGxtNCtXNU9MRGl3aG00a0ZENWk3R3owM1VHT2M1VGdSVnJZK1hJU1FD?=
 =?utf-8?B?NDZXL0lSVmRpY2pwd3pNeVRJNm5ReHZPaUN5Vno0S1F0NnB5dk00UEd6OXpW?=
 =?utf-8?B?M3FCMzhyZEJ2dUEyeVArb3VFMzNyMUhwaWNxbDNRdVFLRVdVa0tRdk1PeS9G?=
 =?utf-8?B?bmlsbytwSk85UTJ3MytWUXZSWFd3QmMrRlNiVDlKYXI5THl2R096SVF3WmRY?=
 =?utf-8?B?a3ZNM1QrbmZhcWNpb2ZYYmVSS2F2dXBKalNzN3J5dG1NV0YyVE5SbEdNclFG?=
 =?utf-8?B?Q2RGU0hwOG1UWCs2dGJFbklUOGhJMWdGUjE3aXYyejFCZmxSTnJHenJLT2h0?=
 =?utf-8?B?NzM5dVBoLzBKdnF0N1o5N1U4R2RicGM2OXl1ayt1RHpXRG4xUG80MHZxRVhY?=
 =?utf-8?B?YWJaZUI1eWdzU25rZGI1WmI1MnZCK1AyMCtWQlRJODlhbzdZbkk3LysrMTFN?=
 =?utf-8?B?cUFNQ2JjUzhQYWJ0MjFtNVA3MkJsMVFnTEVvcysxbWYxUERWTE1QVXBQWWw4?=
 =?utf-8?B?MUtRR250UStIQWZZMnBZYlh1WkpCWTAvVHpTam9FSVRhRzlEOTV3clNUS09B?=
 =?utf-8?B?Nm5Hb1RaWmlWdWN0Q3FSSXIxT3lzNW55SWExNVVZakN2SWlhOU1pbjZRKy9D?=
 =?utf-8?B?M3pmUTcyV3VpWE1xV3BWbW56cy9BNXpId1oxTEllRmJURHRSeWN6dVFCdHdp?=
 =?utf-8?B?VEMyZEdWTmp1a3c0d2xQK1hlNjV1V2tldXRhWGJaTy8xalhNbzl0WXE0MEc4?=
 =?utf-8?B?UDhwQklpZVFVdklnWHlOVzZYQ2owTEhzcXdEOSt5QkRodXJHczdJdkpsQUZp?=
 =?utf-8?Q?aioMkeQEYbKWR2e3MV+QQuc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHg4ejBEL3pLaGxURkN1ZVU2empoMnB2SzErYkxIZWNjbncvOC9mT0huQUN2?=
 =?utf-8?B?UXZkV3MzTHpZcVc5TGNGbU1KK05CNmFGYkgyKy9uZ3dNUzJNSndQUGNRV3VI?=
 =?utf-8?B?ajgwUTIxV2phbnBMb1BySEF4Mm1yMERaaHJjOC9USjNaSENsc0dJRElTQ0dQ?=
 =?utf-8?B?T3k2OGNvK3AyQnB1UnRKVUttVjJvS2VEV2VTZDl3RmtaVU8xUWUwSytVNU5h?=
 =?utf-8?B?RE9iMUZjNDZjaFJOcFJkZHFUalprQTBQMG4vdk8vOTY1Q0ovdjVVTkd5WjBE?=
 =?utf-8?B?b2EwWklZaE9SQUlPOFMwb2V4UWhiU0JrR2VjS3R3WVo1dUw4TFBGT2xCNi8y?=
 =?utf-8?B?Z1VQOG1jeXV6QnE5T1lxY0VjUTRUWDhmUEE0ZmY1TWFRUnBnVXlJMXdiK3Vl?=
 =?utf-8?B?VFVxcHRKaDZ3ZWgvZDNSbmxRL2xkcTJOMVpTV0VKdTRFRlVxazdib2wwM0ZL?=
 =?utf-8?B?bitXbFRBUjA2T1N0cm0vaVB0cG50dUZncElyVm5zQkVHTys2KytUcHFtNnJF?=
 =?utf-8?B?eHBZM3BwSUdPanZ4dlhjWUt6MFNpbE1mbVUwS01WbmJnSFBZR285Tmp1V243?=
 =?utf-8?B?aExQU08xa29yMFFiK1Nib3RJVzlsTkQ2UzFYVzYwOEhBcjdoVFEvUFZQUi9v?=
 =?utf-8?B?d1FDV0wvMmlFRU52b2d6bnJaR2t5dFAreVdweC9Tby9yNVBhY2ZiZ1FKOXkz?=
 =?utf-8?B?ZU04cUs4aGdRSHVQVnRDTmc1ckxvNkY4QW9mWE1Tb2JlVVRvMTZjTHNQZjJ6?=
 =?utf-8?B?Z2ljY291alRKY0tmVjNIYlVOOFphOHR2RW4vNEdQWlRnenZIRTVMaXI2bmpF?=
 =?utf-8?B?SE1qbVVjL0c3MWxkdlFOdjRRZmFETzFlamtDWGJRQkFneWRseW04NFkvdk9N?=
 =?utf-8?B?bzVwamlpa3lWdW9zWjM0Zko2SHM0L3VqWGMySkFjUFYzaDRxbEs4RmF1dEo2?=
 =?utf-8?B?Q0hCUDV2Q1YxeGtYNWJqWmd1N2NrdHpDWURJSVBSaFJCaENMMVg2eGx5MkZE?=
 =?utf-8?B?dkh6MGljc0N0NCtGZDlWSFpjTnFra1RabHJUbUtiZEg2Q1ZrYW5qZGV1WDNV?=
 =?utf-8?B?M3RzanpXazBORkdHcXpmOEVERzdYRGU5N1pOOXJYR0dmbVVjRzRWL0ZTVXRI?=
 =?utf-8?B?RGJBQUJzY1FtQ2JycGx6Zm5WNHJLYWM1ZDBaaFg5R1doZXpzMmJ4bDE0N2pt?=
 =?utf-8?B?UzZMYTJDaG1BeUtBSXdPSGZ1dGVCNDNvQ2xYK0I4RlY2ZGw2N0c4YmZmUVpr?=
 =?utf-8?B?VEtGczlmdm0vRTBUUkRqaXN1K0dFRDdyWTN5eU9GRGVEQnVsSFJCVTM0M3Bj?=
 =?utf-8?B?MnZ4UHBHbUlHVkhPcm9aUnc4NHhnZTFTM3Z2LzZHV25lbjdiVHdBSlpZSW1B?=
 =?utf-8?B?dHUzU2ZmeUNBR2pmZmVnMWRYNzFJTFVsRFRCS3E5blBUV042RDlVSGtoSG5w?=
 =?utf-8?B?VllMSmFqakw1ekdJcXFVK0thd2FZWWx3RlRWUWl4SHMvQi93SERkQ21XUlFS?=
 =?utf-8?B?TzZCWnNSdS9wQ2NGWld0R1R3NG5mVnBvc3MvN1RxdHEySHJZSHN1a05aZDJN?=
 =?utf-8?B?azFsWklNN0Frc3pyZlN1MElXTXlNSkY3OSt0ZTFBZWRqcEtTdDBKSlVGaG1a?=
 =?utf-8?B?cHpXNCtBUTMyYzlmb3pncTBweTVsM05vZ0tRdUc4bnd0WTY0UHVRNUI3dFh2?=
 =?utf-8?B?NnFsSFZtM2dmMkdKbmdEWUpaeDhJUzB0ZDBzSFN6VnNKekhiVldGVUxlN0FM?=
 =?utf-8?B?MzBEeGQ3K0JtYzQyMEVqU25qemhYUkdsbGdrMXJlcDF1SjRpT1FBa1M2dTdj?=
 =?utf-8?B?cDAzUEJqZHVkRkJYcWhFY2Q3bFhtYlM0NmdrNHIwY2daVlo2cHNnSndia1ZH?=
 =?utf-8?B?Q0ZBc085OE5GKy9OalovVU5KRWVjU3llNG1naWJpdVBtM1luL25MTUs2MUc4?=
 =?utf-8?B?N01HOWZDNklBelJYYmNkK3FDbkJoQ3VrWElCUVUwaHFZWVlEeGFCbFRDWHBr?=
 =?utf-8?B?THpQMFVDdm9wUDBGR2hOS05COHRIUGgrWVl1cHlBUk1PVTFhbHQ4Z2pySWJO?=
 =?utf-8?B?Q1hJN0Q1K2NaUGJkYkZFc0o0SzVXWWdYSjdQRnduVkg0Z0pwb2RmRmJvSEhT?=
 =?utf-8?B?NzMzTTJlelJSSzY1QmVGeWUyNFhBV1QvQ0g5L1krZFo4U0VZWlhreWphN3pR?=
 =?utf-8?B?Z0JPY1BLdE9sWnFtUldXN3RlR2tuZG5RT3JWUWg4ZnhVbVA0UFk4YW9aSVZ4?=
 =?utf-8?B?eFNGN1FpZzRvUUJmRWFNZjZVNEwwVW8vbktUMmlDMkFta3pHM3docFYyclhu?=
 =?utf-8?B?WHhMTEhLaVR3R1drQ1M4NU1WMWpiSzV1SkdxcVlmbW5yTGg3dW9BQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c940cfa-6143-406a-4362-08de684b53c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 02:23:06.9759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iC6cZh3a4ZuyIhCJUqjbZTdadtFxAtcbMYX+8c6lxwkuS4OHHYV8aqAE0rysgumjTvL5buuXfNS0/L+p5MaOjSa+SEzt6ZlUgaUl0Xn/Iy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB7987
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBody9pMmMvYXNwZWVkX2ky
YzogRml4IE91dC1vZi1Cb3VuZHMgYWNjZXNzIGJ5IHVzaW5nDQo+IGR5bmFtaWMgcmVnaXN0ZXIg
YXJyYXkNCj4gDQo+IE9uIDIvOS8yNiAwMjo0NSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSBB
U1BFRUQgSTJDIGNvbnRyb2xsZXIgZW11bGF0aW9uIHVzZWQgYSBmaXhlZC1zaXplIHJlZ2lzdGVy
IGFycmF5DQo+ID4gKDI4IGR3b3JkcykgZm9yIGFsbCBTb0MgdmFyaWFudHMsIHdoaWxlIG11bHRp
cGxlIEFTUEVFRCBTb0NzIChBU1QyNjAwLA0KPiA+IEFTVDEwMzAsIEFTVDI3MDApIGV4cG9zZSBh
IGxhcmdlciBNTUlPIHJlZ2lzdGVyIHdpbmRvdyAoZS5nLiByZWdfc2l6ZQ0KPiA+ID0gMHg4MCku
DQo+ID4NCj4gPiBUaGlzIG1pc21hdGNoIGFsbG93cyBNTUlPIGFjY2Vzc2VzIGJleW9uZCB0aGUg
YWxsb2NhdGVkIHJlZ2lzdGVyDQo+ID4gYXJyYXksIGxlYWRpbmcgdG8gb3V0LW9mLWJvdW5kcyBy
ZWFkcyBpbiB0aGUgSTJDIGNvbnRyb2xsZXIgbW9kZWwuDQo+ID4NCj4gPiBGaXggdGhpcyBieSBj
b252ZXJ0aW5nIHRoZSByZWdpc3RlciBzdG9yYWdlIHRvIGEgZHluYW1pY2FsbHkgYWxsb2NhdGVk
DQo+ID4gYXJyYXkgc2l6ZWQgYWNjb3JkaW5nIHRvIHRoZSBjb250cm9sbGVyIGNsYXNzIHJlZ19z
aXplLiBUaGUgcmVnaXN0ZXINCj4gPiBhcnJheSBpcyBub3cgYWxsb2NhdGVkIGR1cmluZyBidXMg
cmVhbGl6ZSBhbmQgZnJlZSBvbiB1bnJlYWxpemUsDQo+ID4gZW5zdXJpbmcgc2FmZSBhY2Nlc3Mg
YWNyb3NzIGRpZmZlcmVudCBBU1BFRUQgU29DIGltcGxlbWVudGF0aW9ucy4NCj4gPg0KPiA+IFRo
aXMgY2hhbmdlIGVsaW1pbmF0ZXMgSTJDIHJlZ2lzdGVyIG91dC1vZi1ib3VuZHMgYWNjZXNzIGNh
dXNlZCBieQ0KPiA+IFNvQy1zcGVjaWZpYyByZWdpc3RlciBzaXplIGRpZmZlcmVuY2VzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
DQo+ID4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2lz
c3Vlcy8zMjkwDQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmggfCAg
NCArLS0tDQo+ID4gICBody9pMmMvYXNwZWVkX2kyYy5jICAgICAgICAgfCAxOCArKysrKysrKysr
KysrKy0tLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJj
LmggYi9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiBpbmRleCA2OGJkMTM4MDI2Li4y
MDVmMGE1OGQyIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaA0K
PiA+ICsrKyBiL2luY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaA0KPiA+IEBAIC0zNiw4ICszNiw2
IEBAIE9CSkVDVF9ERUNMQVJFX1RZUEUoQXNwZWVkSTJDU3RhdGUsDQo+IEFzcGVlZEkyQ0NsYXNz
LCBBU1BFRURfSTJDKQ0KPiA+ICAgI2RlZmluZSBBU1BFRURfSTJDX05SX0JVU1NFUyAxNg0KPiA+
ICAgI2RlZmluZSBBU1BFRURfSTJDX1NIQVJFX1BPT0xfU0laRSAweDgwMA0KPiA+ICAgI2RlZmlu
ZSBBU1BFRURfSTJDX0JVU19QT09MX1NJWkUgMHgyMCAtI2RlZmluZQ0KPiA+IEFTUEVFRF9JMkNf
T0xEX05VTV9SRUcgMTEgLSNkZWZpbmUgQVNQRUVEX0kyQ19ORVdfTlVNX1JFRyAyOA0KPiANCj4g
DQo+IFRoZSBBU1BFRURfSTJDX05FV19OVU1fUkVHIHZhbHVlIGNvcnJlY3RseSBjb3ZlcnMgdGhl
IHN1cHBvcnRlZCByYW5nZQ0KPiBvZiByZWdpc3RlcnMgb2YgYm90aCAnb2xkJyBhbmQgJ25ldycg
aW1wbGVtZW50YXRpb25zLg0KPiANCj4gSW5zdGVhZCBvZiBkeW5hbWljYWxseSBhbGxvY2F0aW5n
IHRoZSByZWdzIGFycmF5LCB3aGljaCBpbnRyb2R1Y2VzDQo+IHZtc3RhdGUgY29tcGxleGl0eSwg
SSB3b3VsZCBmaXggdGhlIHdheSB0aGUgYXJyYXkgaXMgYWNjZXNzZWQuDQo+IA0KPiBJbiBhc3Bl
ZWRfaTJjX2J1c19vbGRfcmVhZCgpLCBjaGFuZ2UgOg0KPiAgICAgdWludDY0X3QgdmFsdWUgPSBi
dXMtPnJlZ3Nbb2Zmc2V0IC8gc2l6ZW9mKCpidXMtPnJlZ3MpXTsNCj4gdG8NCj4gICAgIHVpbnQ2
NF90IHZhbHVlID0gLTE7DQo+IA0KPiBhbmQgYWRqdXN0IGhvdyAndmFsdWUnIGlzIGFzc2lnbmVk
IGVsc2Ugd2hlcmUuDQo+IA0KPiBTYW1lIGZvciBhc3BlZWRfaTJjX2J1c19uZXdfcmVhZCgpLg0K
PiANCj4gSWYgeW91IHdhbnQgdG8ga2VlcCB0aGUgZHluYW1pYyBhbGxvY2F0aW9uLCB0aGUgdm1z
dGF0ZSBuZWVkcyBhIGZpeC4NCj4gTWF5IGJlIGludHJvZHVjZSBhICdyZWdzX25yJyBhdHRyaWJ1
dGUgZm9yIHRoYXQgYW5kIGNoZWNrIGhvdyBvdGhlcg0KPiBtb2RlbHMgc2F2ZS9sb2FkIGR5bmFt
aWMgYXJyYXlzLg0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbnMuDQpJ
IHdpbGwgc2ltcGx5IGluY3JlYXNlIHRoZSBzaXplIG9mIHRoZSBzdGF0aWMgYXJyYXkgdG8gZml4
IHRoaXMgaXNzdWUuDQoNClRoYW5rcywNCkphbWluDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

