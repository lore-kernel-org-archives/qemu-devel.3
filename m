Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB15C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 01:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBlc7-0007q5-42; Mon, 27 May 2024 21:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBlc4-0007of-SN; Mon, 27 May 2024 21:26:52 -0400
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBlc1-0000SB-9x; Mon, 27 May 2024 21:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4zAUvCff62BqlQq75Q8OPVTAoM5yWPxA8rLkJ08n/zsO+EHraWXKu1OOxzQEQ0esoDpLiSSMQwOREHWSr2+aHPR7+Kdwcs34ZQ6QCEsAhz3eckTGjQxfpeZ9D55dVzxqLGj/tuI77Bp+NaXDy2nPAcxmioUXqFFYD3iYp/72tDArD7PgvIbgSCgyaH5XJPnAWADFe3IAT8sDLWCrclDxPf9Yphp9JJqxOqYHTRlwkRVLG/g6MvOi3Gh+6szRj154y0bLG+2n4X7hNUbEWwXjNxBG0MZeom5DiESm7/OsXT/Hd4bnU4GQva4C709T231msli2qT/eYv1ZdokPB1VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS1mWLGIN9nuJwngt/YlGA7LbWizZdgvtjppqKp8QtU=;
 b=RipP/AzaRHx3U8oTkWf2PDJpCO8ZtzfXOsNVG01wR+Aey4rRy2bxxGUqxRgS+OwLIKudl/cbaxnSE/tF9O0b5Ry3QMOGP/EqKUl3ZqeXa/S/SFKXy1KIga0MCHoK4sPjsUjPJwRFYGJp0fCncn08dhqF6JyyYctsiAEtFttawx0lsi6D4Vo/DWX0g2IeqCxgab6aT3CIHOqzF7yoMupT5k1NiC8luoY9Rkw9U1PVLkgSwJhxI1WgyoauZ3URwC7x9ESfkbOrx7cWfLKFcTfNRFHQlp9FTd+DZNgPNdJB8TGW6h3HyW5Q1SPn4b2k72n+CPNn9kk6a+jPrOx6s4v4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS1mWLGIN9nuJwngt/YlGA7LbWizZdgvtjppqKp8QtU=;
 b=IZGLFTp9qrDQR5WYwNIr2C1qmYIhKbtvVW6220affpl+hw0vEx4NMPtU0Cs54KPUS80I9aSMdZaxh7beof0H2k3Ykv7tm0xAJN7675Z1Qqncm5xyvCjzuqF8YbjqwQ5S4NjZM5wq/inKBTVoonrxjnENiAOrHPPPT/c0gZyCslvDGFxUxPoza1ZIIxvm+MpAPUAcpiGFAl35UBeTjYUKtyA7hm+baQ06R8jDw3L+9K4A46qe3BJQOLKleNbkyqtMH602VSWfHQ5Vdrz0TsZyTfc6PGERb0iRpqPFJLpQmSIXThaAQ1AJ9Zs3PkHs7Pwg5UpIA3zaFTnRa+J9ly+1kw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7038.apcprd06.prod.outlook.com (2603:1096:405:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 01:26:39 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 01:26:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
Thread-Topic: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
Thread-Index: AQHasAxBoT342ZIDJkuMa+uwhNwqLrGq4AwAgAAPGoCAABcLgIAA1T4A
Date: Tue, 28 May 2024 01:26:39 +0000
Message-ID: <SI2PR06MB5041CD54D31762371A757C48FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-6-jamin_lin@aspeedtech.com>
 <9476cfcc-5a7c-4b76-a684-1361463bd161@linaro.org>
 <b01604af-5fa7-469f-98e9-c23b3a668a2e@kaod.org>
 <933822dc-de0e-4180-90f9-d951aed30aec@linaro.org>
In-Reply-To: <933822dc-de0e-4180-90f9-d951aed30aec@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7038:EE_
x-ms-office365-filtering-correlation-id: 27df18cb-a7e2-4164-4e1b-08dc7eb53920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011; 
x-microsoft-antispam-message-info: =?utf-8?B?ZVhvRGYwdEc4NHp5dUFpYUJiczM0RnlQMmNpMlh0ZmdkY3RmWEtacGJidkZE?=
 =?utf-8?B?ODBMdTRPSUo5cUZMOHJCbEVJY3ExWWliVDRjWXVPcEZ6VmVHNHZoN3F6WXNI?=
 =?utf-8?B?bXVFS1BTbFh0NFdTL3I0MUdkZVA0S0pHUkxiWXd0cEYzbzN4LzlSOXEvelg5?=
 =?utf-8?B?cFhzbXRyblB0eFZnWnE5UUxKU1MzM0oyVjRzM04wK0VxUU1ZRFpaQU4vNWxz?=
 =?utf-8?B?MEVrSHdMNDNRSWVaNFY4Q0E2M0NEeHNJZVBGeHYrRTZxdVFndlV5dFlrdDIx?=
 =?utf-8?B?K0kyWE1wNDBESVVSN3BwdE5oUlMxVlQ4WXQ1ZUUxUDdHWnFLY2ZZNVpydG5W?=
 =?utf-8?B?V0s5QUpjRGMzRHpNZ1h5dEhTdm95S3E3Um84WkNqNDZ4eVZhVmRPekVtdzl3?=
 =?utf-8?B?ODNWeGY0Y2FGNkNxRXAxYVlUUVZ6USsyQzh6ZlIxY3F1N25xekZtTlNnaXB3?=
 =?utf-8?B?c3RtL255Q0tKSEVjTmxtdzY5b0cwYnY2WDdpcVdWNW13ekVxVU9LbThaUy9z?=
 =?utf-8?B?UUVRbEUxMkYwRFRnb1FiQms0aDRJMGlSTFNVSW9sV09KbkRDWmVqOGtQS1ph?=
 =?utf-8?B?N0NhQWkwbHdDcjhYdmtmRU9BWWFUWDloYTZjUGNXTVQ4QlJsWlhpUVp4VE9u?=
 =?utf-8?B?bGhHODlVR1lQbWZNUktnbm8xY2tZZGlZY0N6MkhZNzZmLzlvUG9OOWJ6RXBJ?=
 =?utf-8?B?c1FzVk9BcnUxS2hCaTNLL2VaTnh6TXhwOWxDellDZmY1S21iWElEU3I2Rnc0?=
 =?utf-8?B?djFNNC9EMHlVaVNIa3loVkdnWXRteWxMVFQxQ05qL1R0NDk5VzdEN3BBVUZD?=
 =?utf-8?B?RU1xL2pzSEtIbE5MemFOUk40K0Z0QmsvaGJwR1JIRVROWVgwOUF0NEM0dnJq?=
 =?utf-8?B?S05hVzlpR1JtUEhtN1FxQnNoSHJmMGJ5Tk1sbzh5R0ZZa0pOZGwxek1kNXZz?=
 =?utf-8?B?c1NGNHZ6TndYT2lRZ0dKNlRaeVJhcWVDRDRqd0l3SUgzUmxRYld6YVFORUJU?=
 =?utf-8?B?blgwWjhkN3J0dUM5RWVlVC82WW1iYVM4cDlwZWV1Z1F4cFBjMU9LL201ZlFq?=
 =?utf-8?B?T09aTFY2U1BUbzBsSnRxbVBUYk9RK2ppVnhUWEMrWWRsUld2WnVXMDZlMkRu?=
 =?utf-8?B?eUNJQ093ck10TXllVktvTUtobUVQM1h4Q2pBTHMyZGQ2eWxlWnJJd3Faa3N1?=
 =?utf-8?B?VldpVzg4MDVMZTFhdzVzdm1kZGdxbWJ2V2k4MENFMjdhSy82eE1RVjFxZkxn?=
 =?utf-8?B?cU9pRURCTWVKaU4vSlJqRm96cHd2Z3NkY1FJMlliVkcvMURiTGFmTXMrOHMv?=
 =?utf-8?B?S2VpZkw2YVM5MTFSeHVQMUpmUENCejQrR255bEhjWkR6Vm5reHBRUFBmbW96?=
 =?utf-8?B?RFdleWh2ZkZaT0RrWDZWdHdaK0ttNm01KzFmRTIweVl5Qm9Sa3c3NkJkem9j?=
 =?utf-8?B?QTRDODNwV3h0Sm5RTVBobmFDc3ZZTUhSTy9PaVBFb1VJbWFwT0hNb0ZWV0I0?=
 =?utf-8?B?d25oL1NiSVZxUllzc2hsejRDR2xPMzE3Q3BRYTVHcTVHY0YydzlUUFY4Q0Zp?=
 =?utf-8?B?V3JpdFlxcFFzZlcvdVhSejhBRndMYXdLVXhPRmd2dDFNeEZNMXZITGl0Ri90?=
 =?utf-8?B?MVNHbFBOZ045RGk4dHRoSmZMT0s0VVNJV2wrcjROakJkUXM2UUltSVdTK0lB?=
 =?utf-8?B?WGlDeUJvY25vbnV4M08wbWlSVUtVc0V4TWZjT3RyYlpIcElIdHpEUldXWVd2?=
 =?utf-8?B?TmdpQzI2RjArNm4wMUJYRnJFQlc3RmsxYUo4enVHQlVraU55UU5HYUd2aWtX?=
 =?utf-8?Q?Wbjri3OBa/SrRvZBTC5FU5/Zzk2/mJR8WOmSc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGk1K3ZkdWNlNG9wVXZmMENKTmp4d2Z5RS81QTlpajlrc0E0cUdKSS9FUzVk?=
 =?utf-8?B?L3N2elIwMEF4cXBHbS9nSDVROTJmb3lkaUxmSjRPVlZqTkFXSE5BL0VkcUp1?=
 =?utf-8?B?TU5KWWhUdmZBcEUzR1FUOVdoNDJ5TkpHL0Mwa1I4UmpGWGhoTlI3QUpiZ3d4?=
 =?utf-8?B?UzU1Rk9MM2ZtUHU1R2JNNGw2emxPZGNkVjFRU0wrY2d3S09SallwR2xPb2pQ?=
 =?utf-8?B?alhVdThPWmpvSVJrUStGTUlDZlBNRGZlbVA1R0xBWHAwQVFQM1VWZURtNlJC?=
 =?utf-8?B?VUpENzJmclJncE1Ea0g0dHUxNEJHenhaZmp2K2J4N0VCQ3pwdTY2YVR3UEFh?=
 =?utf-8?B?Z0orWlc3RWRlTW1SbkFITEkyZkZ4dVQ1V1hlc2psRHhScGNlQ1dtVDE1QXRs?=
 =?utf-8?B?eGFvUWtSSnF0eUJqdFRMMWM5MzNBc3Q4WDNYcmdJWFQ1ekdKYmUvaTlBWVdl?=
 =?utf-8?B?M1BXK0FQS1hLQ1Q5dnVZc2tld0kwWnNGNzVxWWQ2ZW16UUgrNC9ub2plRWN3?=
 =?utf-8?B?RWJyUUxlVjR5d0xVT0E3ZFFiMCt6UlBQclNWYTVRempDRmJIemwxV2ZZM0cx?=
 =?utf-8?B?VlM0RUJKd2hZTS96MjRIaVQzWFBFTGRNckkvVzVBbGhPS2swaThvN2ZOWFhL?=
 =?utf-8?B?MlhWYXQvdnFjOWVUNGdTVHgyclJ4amZwUmtrenkvMWNLbE51dUxlWGZRVzdp?=
 =?utf-8?B?N1R5dmpTeXBKQ05TcU9UVXVOT2FLVjFDRlQwUFhXa3hLM3lBUGp1bUsxVXpp?=
 =?utf-8?B?WE9rQ2ZNQWJ2L1hueVd2RFMybFI1K09mODlCOFZoa0FCekw2N1J0cFk4SE9R?=
 =?utf-8?B?YnJJcE9qdUp6NjlHd3VyQkVETmdTbERWVmhKNzR3VjBTZVA0SE54UzhDb2R1?=
 =?utf-8?B?VE4xOGNaMGxJL1YzbWZDOGE0K0JFRFFzMmphRmRob0JRZmladUM2ZWZLL2M3?=
 =?utf-8?B?eHBadWhyNWdjTHJXeHpVd0RiZk82LzJlZy9peVRHaG81WVYydVpvbENOT1Fx?=
 =?utf-8?B?REtRTkNJaGx5WlZsU2hIelhhRGhKU1IrT0RYdWZVNFN2WHdUbmJzQk1KNkg3?=
 =?utf-8?B?L1htQXlCbnpXTDE3MjJ5TFpBeCtlS0NqZnlkejFNU3ZrV2t5UjFQdi8yL04v?=
 =?utf-8?B?RUR1d3BodzYvakFtZTRMRGs5M1ZqQ1FlUEpxcmtTa2ZQaXZ5dytsYzBwOS80?=
 =?utf-8?B?R3NZTzlrbnpqb2M1bFFlV0FGRnpnMSt6Ly9UZ0hSZjFHaXVqSVJFdGVOM1BS?=
 =?utf-8?B?eWxZVG1zTW5HYmNEYzVaYStDd0x3Szg5ZmZjMnZzenJFcTlhajg0WlM0UTVF?=
 =?utf-8?B?WmJjTEN4WWE0elNsbU5BK0lXZS9XdW1MWVBLR1Npc2dETHlLRE16UEptTmlF?=
 =?utf-8?B?NngvMlczeUFVbFpIQ2F0Q1pYRWx6VHZwbEIxc0hsOTNPMk8ydGxwaFYzeHBm?=
 =?utf-8?B?aFlWVGhqUDRlL3NGaHJIakRIZVBHaTNTVjB0STFZVTk0MXFqelU2ZUtTUkxX?=
 =?utf-8?B?K0xVMEdkSm5NK2xlUE5MVDhjZDJRR2RFUnY1bjk3U1lVQkM5NjViVnRJTlcy?=
 =?utf-8?B?VWtkQldTSGxnNWFLd1lTeWtXUDlYZ2xvYXU3STV1c1V4dDFUTFFLOVdydzVo?=
 =?utf-8?B?eEwrTUlmSHh2VGdIZC9YTkt4ZTdLaFFJb2I4ZVpxeTBRYWJ4MjA0ckd4QnIr?=
 =?utf-8?B?eC9uaXUwZUFmalVUbUhoczIyN0JOdFN6LzZWWmg0NmNzS3lWVFh5YU5LQ2U3?=
 =?utf-8?B?cmFMOFhrbUI4bGxOM3BGeFlFMld1YkFSTXpKTW4rVUEyOW82L1VyeW41STZQ?=
 =?utf-8?B?UFEyeDd2NFBRQWNvWTF2VTRud2ZZSG4vUkFjSDhRZ3BQRVE3NGtLYjlyaUhK?=
 =?utf-8?B?cmh5Y1hGekJ0ZG15TUZia0Fwbk8zRWpmU0owSklIZEFVYlovL3M1K0RFMmpB?=
 =?utf-8?B?c1Jka25YbXpvWDFBNXF2c1MrTDM1L2hCeVltSFVzM1kzSWdBRzgraCtEWHE5?=
 =?utf-8?B?dDZOcVVub2F0S3VUbFNhSEp6YlB3eWVYdUFzZlAxemNVUmpVOXpMZm5OSWxH?=
 =?utf-8?B?b2hVR1MzbGxObEhpaERiOU9zRHJyK25rY2JOVUZKb0EyYzBNR1hTYlRWaXh6?=
 =?utf-8?Q?cLJh4ai7Jj5ucqDSB2yDlg449?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27df18cb-a7e2-4164-4e1b-08dc7eb53920
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 01:26:39.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQYobIzD4idst6zRQBaEjgqSZxSGMG6Z2InRyOgJe2HEVWij8RmNojaaGYJWR2SHVpOixhf+CxOzPs+k6MmapUDIcTXZkhz4UXXgFQIlYU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7038
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsIENlZHJpYw0KDQo+IE9uIDI3LzUvMjQgMTM6MTgsIEPDqWRyaWMgTGUgR29h
dGVyIHdyb3RlOg0KPiA+IE9uIDUvMjcvMjQgMTI6MjQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IHdyb3RlOg0KPiA+PiBIaSBKYW1pbiwNCj4gPj4NCj4gPj4gT24gMjcvNS8yNCAxMDowMiwgSmFt
aW4gTGluIHdyb3RlOg0KPiA+Pj4gVGhlIFNEUkFNIG1lbW9yeSBjb250cm9sbGVyKERSQU1DKSBj
b250cm9scyB0aGUgYWNjZXNzIHRvIGV4dGVybmFsDQo+ID4+PiBERFI0IGFuZCBERFI1IFNEUkFN
IGFuZCBwb3dlciB1cCB0byBERFI0IGFuZCBERFI1IFBIWS4NCj4gPj4+DQo+ID4+PiBUaGUgRFJB
TSBtZW1vcnkgY29udHJvbGxlciBvZiBBU1QyNzAwIGlzIG5vdCBiYWNrd2FyZCBjb21wYXRpYmxl
IHRvDQo+ID4+PiBwcmV2aW91cyBjaGlwcyBzdWNoIEFTVDI2MDAsIEFTVDI1MDAgYW5kIEFTVDI0
MDAuDQo+ID4+Pg0KPiA+Pj4gTWF4IG1lbW9yeSBpcyBub3cgOEdpQiBvbiB0aGUgQVNUMjcwMC4g
SW50cm9kdWNlIG5ldw0KPiA+Pj4gYXNwZWVkXzI3MDBfc2RtYyBhbmQgY2xhc3Mgd2l0aCByZWFk
L3dyaXRlIG9wZXJhdGlvbiBhbmQgcmVzZXQNCj4gPj4+IGhhbmRsZXJzLg0KPiA+Pj4NCj4gPj4+
IERlZmluZSBEUkFNQyBuZWNlc3NhcnkgcHJvdGVjdGVkIHJlZ2lzdGVycyBhbmQgdW5wcm90ZWN0
ZWQgcmVnaXN0ZXJzDQo+ID4+PiBmb3IgQVNUMjcwMCBhbmQgaW5jcmVhc2UgdGhlIHJlZ2lzdGVy
IHNldCB0byAweDEwMDAuDQo+ID4+Pg0KPiA+Pj4gQWRkIHVubG9ja2VkIHByb3BlcnR5IHRvIGNo
YW5nZSBjb250cm9sbGVyIHByb3RlY3RlZCBzdGF0dXMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+PiBSZXZpZXdl
ZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPj4+IC0tLQ0KPiA+Pj4g
wqAgaHcvbWlzYy9hc3BlZWRfc2RtYy5jwqDCoMKgwqDCoMKgwqDCoCB8IDE5MA0KPiA+Pj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+Pj4gwqAgaW5jbHVkZS9ody9taXNj
L2FzcGVlZF9zZG1jLmggfMKgwqAgNSArLQ0KPiA+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxOTMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4NCj4gPj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NkbWMuaA0KPiA+Pj4gYi9pbmNsdWRlL2h3L21p
c2MvYXNwZWVkX3NkbWMuaCBpbmRleCBlYzJkNTlhMTRmLi42MWM5Nzk1ODNhIDEwMDY0NA0KPiA+
Pj4gLS0tIGEvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zZG1jLmgNCj4gPj4+ICsrKyBiL2luY2x1
ZGUvaHcvbWlzYy9hc3BlZWRfc2RtYy5oDQo+ID4+PiBAQCAtMTcsNiArMTcsNyBAQCBPQkpFQ1Rf
REVDTEFSRV9UWVBFKEFzcGVlZFNETUNTdGF0ZSwNCj4gPj4+IEFzcGVlZFNETUNDbGFzcywgQVNQ
RUVEX1NETUMpDQo+ID4+PiDCoCAjZGVmaW5lIFRZUEVfQVNQRUVEXzI0MDBfU0RNQyBUWVBFX0FT
UEVFRF9TRE1DICItYXN0MjQwMCINCj4gPj4+IMKgICNkZWZpbmUgVFlQRV9BU1BFRURfMjUwMF9T
RE1DIFRZUEVfQVNQRUVEX1NETUMgIi1hc3QyNTAwIg0KPiA+Pj4gwqAgI2RlZmluZSBUWVBFX0FT
UEVFRF8yNjAwX1NETUMgVFlQRV9BU1BFRURfU0RNQyAiLWFzdDI2MDAiDQo+ID4+PiArI2RlZmlu
ZSBUWVBFX0FTUEVFRF8yNzAwX1NETUMgVFlQRV9BU1BFRURfU0RNQyAiLWFzdDI3MDAiDQo+ID4+
PiDCoCAvKg0KPiA+Pj4gwqDCoCAqIFNETUMgaGFzIDE3NCBkb2N1bWVudGVkIHJlZ2lzdGVycy4g
SW4gYWRkaXRpb24gdGhlIHUtYm9vdA0KPiA+Pj4gZGV2aWNlIHRyZWUgQEAgLTI5LDcgKzMwLDcg
QEANCj4gT0JKRUNUX0RFQ0xBUkVfVFlQRShBc3BlZWRTRE1DU3RhdGUsDQo+ID4+PiBBc3BlZWRT
RE1DQ2xhc3MsIEFTUEVFRF9TRE1DKQ0KPiA+Pj4gwqDCoCAqIHRpbWUsIGFuZCB0aGUgb3RoZXIg
aXMgaW4gdGhlIEREUi1QSFkgSVAgd2hpY2ggaXMgdXNlZCBkdXJpbmcNCj4gPj4+IEREUi1QSFkN
Cj4gPj4+IMKgwqAgKiB0cmFpbmluZy4NCj4gPj4+IMKgwqAgKi8NCj4gPj4+IC0jZGVmaW5lIEFT
UEVFRF9TRE1DX05SX1JFR1MgKDB4NTAwID4+IDIpDQo+ID4+PiArI2RlZmluZSBBU1BFRURfU0RN
Q19OUl9SRUdTICgweDEwMDAgPj4gMikNCj4gPj4NCj4gPj4gVGhpcyBjaGFuZ2UgYnJlYWtzIHRo
ZSBtaWdyYXRpb24gc3RyZWFtLg0KPiA+DQo+ID4gRG8geW91IG1lYW4gbWlncmF0aW9uIGNvbXBh
dCA/IFdlIG5ldmVyIGNhcmVkIG11Y2ggYWJvdXQgdGhhdCBmb3IgdGhlDQo+ID4gQXNwZWVkIG1h
Y2hpbmVzLg0KPiANCj4gU28gbGV0J3MganVzdCByZW1vdmUgdGhlIFZNU1RBVEUgdG8gcmVkdWNl
IGNvZGUgYnVyZGVuPw0KPiANCj4gT3RoZXJ3aXNlIGluY3JlbWVudGluZyB0aGUgdm1zdGF0ZS52
ZXJzaW9uIGlzIGVub3VnaC4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBQaGlsLg0KSWYgeW91IGJv
dGggb2theSwgSSB3aWxsIHJlbW92ZSBpdC4NCkRvIEkgbmVlZCB0byBjcmVhdGUgYSBuZXcgcGF0
Y2ggb3IganVzdCB1cGRhdGUgaW4gdGhpcyBwYXRjaD8NClRoYW5rcy1KYW1pbg0KDQoNCg0K

