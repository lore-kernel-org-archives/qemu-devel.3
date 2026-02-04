Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C2E83EE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8v-0005yM-3W; Wed, 04 Feb 2026 02:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZE-0004aB-1z; Wed, 04 Feb 2026 01:40:48 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZC-0004IG-26; Wed, 04 Feb 2026 01:40:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+n7TIbAt0p/GcOmwHeWPXhDSLD2BnTe93hloyQyCOZhQW+CZPdE34B7Vh83cykkv8VbCeMdWbhKTUQe5EM54ukXpheMnjb2BpZkarC55+8HIMSlWbB+P862pvTeo3uIBKdgJk/DNADePVo5zaFVOzxP7WamIyOlCKOqmtqLuV6GMy08Ra+H2sXqB1IZxUWQxwK/HxIWE1TUCRx+PX9AxUDkwtMJCIkdw9f91MtYdJZOfzptq3WiRcQv38RVwQ9r5DPCDF/a/fatNIBy/mwZeTOo0yw4mAFqEGG58aG3OXwrX4rfk25P1tP3ioL5JzlcxHbV0MLMxKpL/X5ned7bkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl8L9FbnsUts0l2barfn0YN4jwBA6pHKzVqllDNVS6M=;
 b=cuL4KkLQ/VRYlcy/rI+NmSmlnt2xFkoxexwoqxKsyCLIv03eEyvvy+Zp1K04q0k62oON118DEsY0mkl0sviHlrS5QOwizWxo6is4wv+hUA//jTdOBsnXKPPhNyuifY+nU6/psCQAjxmn6JhRtLW+1hacPmscGZ+yAc6TWsbUmHA7COJ3bpELqDpes3eOWfw7MpgG0NQ+L1v9r/FF0eG475l/ZxfLmmhYuRlyMs5+6j3bJe0/xagoK8waRaLDiM6rdLdlKeP6FCiRTuOdPD4DIVClc5bYm/n6ibLkuf9pFxDdLxtpFZsbTfpxRYX31Vj2Zy3LjHm5WBIMjftI40/W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl8L9FbnsUts0l2barfn0YN4jwBA6pHKzVqllDNVS6M=;
 b=deNkAbq0kdzYbjx+efP/J37FA2JW+X95GpOw8dzswjRi8uAQg5jgqpgmDDk/vRO91nP/qi+XMSoqvrPwVYxa1dKj1yG8hKVbrzwCcT/HIpUJiuXZppDVeNMR09tlpGh8s+ph8cDuwQEGBdTNeT6s3BQLDPmUL2qiIckEG9QiJThw67Y5vtpsNea3MgynoaULp1FTHJO1HhrYVLvTZ9CwX07I5HUfoz0NGyBNPSzJQiz8oSAZ5021BowFWCqQWPMs7RxngHBfdRFiYHawjZpT48AXvngbXDJjNEaKzOif0R+x6QLM8NfsRVcOcZweZ2crdLVkOWlEDRkG+G2Wc8Gfqg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:27 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:27 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 07/22] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
Thread-Topic: [PATCH v6 07/22] hw/arm/aspeed: Attach LTPI controller to
 AST1700 model
Thread-Index: AQHclaElB+TUJvbnjkOkg7rE/l9XlA==
Date: Wed, 4 Feb 2026 06:40:27 +0000
Message-ID: <20260204064016.3515639-8-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 1eb0e307-f514-44db-338d-08de63b84867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QjlNRmhacUNlY3VPaGxsWEdOL3k5UlZXakZrVlZZcnVvc1Q1blJsODlqa3pn?=
 =?utf-8?B?Y3BhS1hKaHFCeWN1ZmdTZ25BWmI5UEhldThRclB3VjJQVTFPYzZZb2RjTzhG?=
 =?utf-8?B?OWxWMTJucVhzRTRCdWRXQmsyZ05RYWdvaTY0NU45TlFVeWUwMjYyWmZMRThK?=
 =?utf-8?B?VTh2OW9HSGpXMTdMdFV1YjFpVW5YdHBnVEFHL2lVNHFHWmczTjV0cHZ2Qll5?=
 =?utf-8?B?eE9sd0FuLzludjdsVDUvUFc3c2tZTmxFbFF5OFE3RnFlY0Y5cnJuOUo5cVE3?=
 =?utf-8?B?VGk2bS9mWWkyMWNOMFVaNmlhQ09vTHVoUW5oNm5kWXEwSmk1VWg5ZHlVcEs3?=
 =?utf-8?B?bkpmVW54YkRCYzBXMlgxbzU3UjZxWTBPRmhEUVVaTlQzdnRCMTNvaUNsOXcx?=
 =?utf-8?B?RWpObnV0a1MxUlFjSjNFWi9VWTdzbTA4bEdPRnNwcVlIUnVxaGFzQnFHSWl3?=
 =?utf-8?B?Z3EvNUppZVFHVlpucUJwNG4yOVp6Z0F5eUlyRjlDUVB6eFp5SGRKUnZmeFN1?=
 =?utf-8?B?a3pWRmhHYkJkcnY5dm1wZjNPVU5zL3NEbDFhaGpZclhNQVZYY3M3RnlSd1RW?=
 =?utf-8?B?Q2ZpUDdIMGtobzJWVUhTNEkwUE1iSElwd1VBaDFRWE9ZaVIrcG9YL0NQaWNV?=
 =?utf-8?B?dWszZjJ4RW5TSmNXT3hIOHZiUko4ZTJlbndDRUpQY0s4SXQ3S1lGcEFGaDlC?=
 =?utf-8?B?S2lmanVFZUtNenVpSHhWUUt4SVUrZ2lPSWFTRmZjSFVMKzJReDJlcDlLSXZF?=
 =?utf-8?B?RklSQzhGeWt6OWgwWW43aU5hOFVldUJYa2JXby9JQUxxTFh2cVVDOGFwQjdk?=
 =?utf-8?B?VVVEcmtRanlQYms3TmRWM2dNZTYwenZhZHNRTE9pRjVBQS9MbjVLRllBWnA3?=
 =?utf-8?B?Tld1OXBLL0dLaERRYWVGSXhQRWF3SXZSSmtuaGdUU0U3YUFiY2FkMThocDNH?=
 =?utf-8?B?MW5NYXVHeU1XeHRxWDR5VEtIY2RmK0c4MDIvcWFlRTBSVE13SGI4ZWsrT3JK?=
 =?utf-8?B?MHNFYm55RC9DL0JsekkvaGZiL251V09BVE1aeGYrQjBhQWxOQmtzRjBSeXly?=
 =?utf-8?B?OEQ4WGFYcFJPOFI1YU1CeTRUcUpKWm1zc2pKNmxBYjJYUUlkdlN6NnNoN0JF?=
 =?utf-8?B?WGgzQkZPa3VDQ2Rsc0xZcUVZMko3S2pnbUFhcGkzc3VodWVXQ3ZmR1ZlNzVj?=
 =?utf-8?B?NkE3U05iakMwU1dNWEhMb2Y1SXdnNHJuZ0Q3MWVJbnQrMjRPZkFuTDhWakF5?=
 =?utf-8?B?SGRZQ3QzSy9yYm5rK2FWdlBFaTN5VzRkdXdwUWJ2R2EybjM3VHZjZTN5TkQ3?=
 =?utf-8?B?anpwQVBPa09HS1pNNmJYbHhXTm5jR0JCcGdzTk9vcjhDVHJ2cCtOOWI2aWFS?=
 =?utf-8?B?L2lscTBEdWFpMDRCTjNESHBCS3FoUWJYeHFSdmtsN1d6eWlCZ0VjckFUcXRy?=
 =?utf-8?B?a1VGQitzd0xOMDFQUVR3aEFPQ2VSZlVsL2pvcVVNZnhaQnVwRUhmTXZDdFBz?=
 =?utf-8?B?L3F4S280bUhXWjNuaUZrVFZaNjFtcTRsZ2RSWHc4WWZRak1kRUcvRE5NZ3du?=
 =?utf-8?B?V2dJTSt5WHFKUjgyMk9aaTFsZllReWo1TFFkUEYwS2RiL1NsNWRjUVdERHY3?=
 =?utf-8?B?THoveEVpUHZYcVBWTUtMempRREpmSWJUM2xRbmJEYkFyc2hwVGlTQUkvcDQr?=
 =?utf-8?B?aUZZRWs2aWFCaEpqU2w1NklxbE8zSzNMUmFqS1NDbGdQVEJ1QlYycGU2aWta?=
 =?utf-8?B?MkpMR2I2aGp5dWpKR1Q4YkJPNXk2bnpDWHBRSTZ1MytuQXhhanNSclgwNGZw?=
 =?utf-8?B?YU9xRTlVaU45eUpITzhtSkFYQVh0L0Z2TEVRWCtJczU3UzFTMHlSZGlla2la?=
 =?utf-8?B?SDRLYU5oMkRSQ3FsYUN4djBOZExIMnZiYlgzOWFTTGZqZk81ZTI2ODl5bmRk?=
 =?utf-8?B?YlBoeis2MnJhODJJdUU4S3duL2REdS9EdlNxbHlWbTZXaCttSU9MUnZaOEdN?=
 =?utf-8?B?RlRlN2NkbmVrVEFwdzMzUXRvNm5DQU1ubkljaGdYK0cwa1N5M1FMZUwwZC8z?=
 =?utf-8?B?UXFVL1VjRGF4T25mOXBINXBKNVRwOGRxTStPM2hERnpucEVQYUVRZHVacVl3?=
 =?utf-8?B?eEg5a1hMcExVMzJiWE5YL0xSWW55cHAzd296RUpJaUFTL0JSaTAwOEhQbHo5?=
 =?utf-8?Q?IdgozYfU2UhBGnyLlcqa1eg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTFLUEtXYXcvVk12QXJEcDZBL1UzblkxZ1FyS0lEcVBjeXpuN29mQnU3K0dn?=
 =?utf-8?B?Nk8rOElQS29hRmM5Y1JBSG5hd3JIWHdYNzZaSC9ESHFRemxEUDJTWm94eERo?=
 =?utf-8?B?YkFud3JNTFJTaHNiQ21GcHY2R2k4YkNrSC9LU3lWVFdMQ3VRek9MNFdTQWlF?=
 =?utf-8?B?ZXdzbUpvVjlaOFA4amFkUTdSYlRoNWVxSXhpSkFxWXdlZ2ZocytXK1dtZStV?=
 =?utf-8?B?V0x4dURjMTllUGlqZWhUd0VZc3dyYmVTdVpJYzYxMnc5bGRoa3NxcFVPRHp2?=
 =?utf-8?B?WUw0RlpPNG9jVW5SNHBwQ1RKMEN1bUtoWU5JU0JJQWtJOUJFb3FwYWJKaEdo?=
 =?utf-8?B?QlRNMFFER3RIclhyZ0FXZG9Kb2x5b3V2RTkvSTZqaENkK2xYcloyQmVHUjJx?=
 =?utf-8?B?Y0F3SWhvcThwVnpuMTd1bFFQQVNUc3l2OWZIVEYwQVNhc213NTlreko2b0c3?=
 =?utf-8?B?cnl2K2NVMWJCVjB1NkFkbEpHL21BTnhsRzlUa0lYNFYvemNGZXVNOW9BdEd6?=
 =?utf-8?B?Y013RkhqdFhlWEQxV1FhWFh0QlhnUm5vQTNFazFvVFNpZnZTalJyVms5SGx2?=
 =?utf-8?B?a0hQZjdpek04YURKYStjcTZVR1VUd0p2QVlBaWFTTWlsY3hiMlFkRzVCQ2JL?=
 =?utf-8?B?RnA0Z2wxVm9PTDJpSHRYTlkwTVVNTGNBQlVQVWFUQWtLeTlXZHBaRnVWUHR6?=
 =?utf-8?B?WWNsaEZRWmdkNGtpcWpKRXRlb0RXcS81RFVrLzQzYktlM2dLcEU2cHZNSDdZ?=
 =?utf-8?B?NHJOdzQ3NnFFNVl0TlJvb3NRbkIvdXlFWlo4WXBPenZsQjhkKysyUU16M1dJ?=
 =?utf-8?B?MEZOZG00Z0ZsMUVYWUp6bTF3eWpYNExUd1lSKy9rQmdDZkhvVE00aDVhcWM2?=
 =?utf-8?B?Zm93bXF6aWs4T1pQeVhMSUNhTUF5NU82dm9CZUYzU01mY2RhUGdIZGpGVnJW?=
 =?utf-8?B?WjI1ZHEwUHlFSFdUcWZVc3ZKamZsMnFJY3VMQWFCaVI3Rk9PQjhkTFd3VDIr?=
 =?utf-8?B?TnRCN2VzdlcwSVZka0czMlB0enlwNHQ4QjgxL0RwTkhQZEE4ODhQOFZzcEMy?=
 =?utf-8?B?OHA0Si9hR0dUSncvSmxuNTQrd0pBdHFjYnh0d2M5SkpvQTFBc0hSWHp0RUJi?=
 =?utf-8?B?V2diNU5Ybm1wRkRuR2l4QzBxNys4dzR4NWIwSlErWmxwa0dvR0VWWW8xVWhI?=
 =?utf-8?B?WWJzU2RaOGZ2S3A2eXczTWZZWlZlNW5YK2JjRkNVbk4renhRQUJqODJDeFJu?=
 =?utf-8?B?V3B1Y2pWV1doUC9LKzlQVHFRY1JwNW9SWm96NEh2NjZtTXZ2VGt1eEJhL2ZX?=
 =?utf-8?B?azhPMi85SGprYWM3NUZ5YUVuamVqcjFjbmY0djhPQWJaWVhoZjJ3WHVEU0xh?=
 =?utf-8?B?cjkvSzBpVVdzMWh0MXoxdnZxZGhmck5kVGdBN0cvNGpjUXQyb093WldEOUVz?=
 =?utf-8?B?cVAxd2x0SjNiM0pOZ0pSSWFjVXZqYWozdWlRQVA3OHRrVFQ4dWtmQ3JXcjV0?=
 =?utf-8?B?czN0Q0MxK25HZ2NROE1KdWFFcVF6QlMzWFpnTGZZUjVoYU5aWTVQRDJTMkUw?=
 =?utf-8?B?M0hzdUVmaEpCZEczRkZUR3FqSDdzUGJFZysvV3hleDEwTUlqU1JkUm9rclYv?=
 =?utf-8?B?SEZHWGtoZE1xZnJLUWlBaWlacFZYWjZkek55azUrcmk4VlNBOVZLbE52MDho?=
 =?utf-8?B?dDg5d1I0RkR2a3UzaXRnTkI2SzVvU3BtV3B3N2MxMTVicnVSLzhyRG5TZjF4?=
 =?utf-8?B?cHFPL0dVTE1yMkllMkhpY3RYaUpaVy9sZW9wRGVQODEyNnBQNUViNjhmSGU3?=
 =?utf-8?B?blBQd2pvcndwTHhGOFBucUl2anRCaWNtS1pvNGVGMUlSaStsS0xpamNNT1Vs?=
 =?utf-8?B?Y3VibFMwbWM3WmI3ZCtvckVnZzkvbFBEb1RNVHRQVXdsckwvYk1sMWZEOVBk?=
 =?utf-8?B?dnNGcDMrcWg1SjdIanF1M1RDa1N6TlVjdkZ5cWlkSlFBL01aa203M05pVjdi?=
 =?utf-8?B?dkY5UTFqcHdoZXM5Z1NiRHArTmhrUTFLVzlwdUhiNE1Jb3dVSjVNWWwwZVJZ?=
 =?utf-8?B?SmtxcEpOUklWQ0lIVTB4RW5tMElrSUJML21ZVndwSlM5RU1OOG1McS9qeXMx?=
 =?utf-8?B?S0NCRU9aUVduZklUeFV1UWdvSDg2S2M1QUtLNE9nVmVxbXY2SWh5M3BLWUw5?=
 =?utf-8?B?ckQxSWRQYkdPdzRxT09NVjJNT3JMMnFKM1VhL3NoNDNwZGkwRTI3NXh5ME1H?=
 =?utf-8?B?RlNMZGVrN09mYllndWc4eUFyaTlhU0dzMkFYU0dWZS9GaWI5YkY1VHoxK284?=
 =?utf-8?B?VTl3SFlFMk40MUFVQ1Y0dk5uSnl3L0pTZG5pTmlDSkg0SGtLRmJIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb0e307-f514-44db-338d-08de63b84867
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:27.2930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLgkhCcEgs9mSooREsCLGG4SNxKypJkWPfkg2wbEfIFOQf9gUJX8ExFMeOKMQPIL0Ep7zFw3cbzbgj3kU/UgR425XSo6bFUnKe8ysu9ZJ1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:19 -0500
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

Q29ubmVjdCB0aGUgTFRQSSBjb250cm9sbGVyIHRvIHRoZSBBU1QxNzAwIG1vZGVsIGJ5IG1hcHBp
bmcgaXRzIE1NSU8KcmVnaW9uLgoKU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2No
ZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD77+9ZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2ds
ZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+
Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCB8ICAzICsrKwogaHcvYXJtL2Fz
cGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysK
IDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvYXJtL2FzcGVlZF9hc3QxNzAwLmggYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5o
CmluZGV4IDM3OGRjYjQzN2EuLmFkZGVhM2FiMWYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvYXJt
L2FzcGVlZF9hc3QxNzAwLmgKKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaApA
QCAtOSw2ICs5LDcgQEAKICNkZWZpbmUgQVNQRUVEX0FTVDE3MDBfSAogCiAjaW5jbHVkZSAiaHcv
Y29yZS9zeXNidXMuaCIKKyNpbmNsdWRlICJody9taXNjL2FzcGVlZF9sdHBpLmgiCiAKICNkZWZp
bmUgVFlQRV9BU1BFRURfQVNUMTcwMCAiYXNwZWVkLmFzdDE3MDAiCiAKQEAgLTE4LDYgKzE5LDgg
QEAgc3RydWN0IEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSB7CiAgICAgU3lzQnVzRGV2aWNlIHBhcmVu
dF9vYmo7CiAKICAgICBNZW1vcnlSZWdpb24gaW9tZW07CisKKyAgICBBc3BlZWRMVFBJU3RhdGUg
bHRwaTsKIH07CiAKICNlbmRpZiAvKiBBU1BFRURfQVNUMTcwMF9IICovCmRpZmYgLS1naXQgYS9o
dy9hcm0vYXNwZWVkX2FzdDE3MDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jCmluZGV4IGRk
MzhiODE5YjguLmU0Yzg1NjVkM2YgMTAwNjQ0Ci0tLSBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5j
CisrKyBiL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jCkBAIC0xMyw2ICsxMywxNCBAQAogCiAjZGVm
aW5lIEFTVDI3MDBfU09DX0xUUElfU0laRSAgICAgICAgMHgwMTAwMDAwMAogCitlbnVtIHsKKyAg
ICBBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMLAorfTsKKworc3RhdGljIGNvbnN0IGh3YWRk
ciBhc3BlZWRfYXN0MTcwMF9pb19tZW1tYXBbXSA9IHsKKyAgICBbQVNQRUVEX0FTVDE3MDBfREVW
X0xUUElfQ1RSTF0gPSAgMHgwMEMzNDAwMCwKK307CisKIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3Qx
NzAwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQogewogICAgIEFzcGVl
ZEFTVDE3MDBTb0NTdGF0ZSAqcyA9IEFTUEVFRF9BU1QxNzAwKGRldik7CkBAIC0yMiw2ICszMCwy
NSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmljZVN0YXRlICpkZXYs
IEVycm9yICoqZXJycCkKICAgICBtZW1vcnlfcmVnaW9uX2luaXQoJnMtPmlvbWVtLCBPQkpFQ1Qo
cyksIFRZUEVfQVNQRUVEX0FTVDE3MDAsCiAgICAgICAgICAgICAgICAgICAgICAgIEFTVDI3MDBf
U09DX0xUUElfU0laRSk7CiAgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZzLT5pb21lbSk7CisK
KyAgICAvKiBMVFBJIGNvbnRyb2xsZXIgKi8KKyAgICBpZiAoIXN5c2J1c19yZWFsaXplKFNZU19C
VVNfREVWSUNFKCZzLT5sdHBpKSwgZXJycCkpIHsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKyAg
ICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPmlvbWVtLAorICAgICAgICAgICAgICAg
ICAgICAgICAgYXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJ
X0NUUkxdLAorICAgICAgICAgICAgICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihT
WVNfQlVTX0RFVklDRSgmcy0+bHRwaSksIDApKTsKK30KKworc3RhdGljIHZvaWQgYXNwZWVkX2Fz
dDE3MDBfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9iaikKK3sKKyAgICBBc3BlZWRBU1QxNzAwU29D
U3RhdGUgKnMgPSBBU1BFRURfQVNUMTcwMChvYmopOworCisgICAgLyogTFRQSSBjb250cm9sbGVy
ICovCisgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaS1jdHJsIiwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmcy0+bHRwaSwgVFlQRV9BU1BFRURfTFRQSSk7CisKKyAg
ICByZXR1cm47CiB9CiAKIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKmtsYXNzLCBjb25zdCB2b2lkICpkYXRhKQpAQCAtMzYsNiArNjMsNyBAQCBzdGF0
aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX2FzdDE3MDBfaW5mbyA9IHsKICAgICAucGFyZW50ICAg
ICAgICA9IFRZUEVfU1lTX0JVU19ERVZJQ0UsCiAgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2Yo
QXNwZWVkQVNUMTcwMFNvQ1N0YXRlKSwKICAgICAuY2xhc3NfaW5pdCAgICA9IGFzcGVlZF9hc3Qx
NzAwX2NsYXNzX2luaXQsCisgICAgLmluc3RhbmNlX2luaXQgPSBhc3BlZWRfYXN0MTcwMF9pbnN0
YW5jZV9pbml0LAogfTsKIAogc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfcmVnaXN0ZXJfdHlw
ZXModm9pZCkKLS0gCjIuNDMuMAo=

