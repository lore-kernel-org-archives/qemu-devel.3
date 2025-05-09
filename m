Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD730C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHeP-0003nq-Rw; Fri, 09 May 2025 02:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHeN-0003jH-4W; Fri, 09 May 2025 02:56:03 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDHeL-0000jB-0p; Fri, 09 May 2025 02:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrPL+jqPR3W+PhI0xM9AmyK77a/oiKzob9m0FH5C5idL24SkfStSSS5AaQh1GnDHxOYTLktePKnwSZW6s5zBHzbvJbEwO5AM41HK6ERIMNnQdOWVF1NiDTdKKpzQCLmOsul67wzPCyy7iO+US4LXWANci7LvDiD06zfprK8kPH2czqT7eAbd1JwZ9lIQkPwnUU2oGjBPb98bIqcAC2/y7ZMkaRSsGZKBJphk5Q35Ldsf9OsVvFYjT4G9dttRexmG5Zl5JWeS2qVm4OBTky9mPSPyjGGfnJ8zPgruhfUk9qhgcGnde0HCM20fcMRgUW5rC6H+wf1gbmIBGsEFPNAD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cCzCYr4nt2xTtLcBUBlCtBSxudTa2Qranc3cbDDe44=;
 b=Ev3B3tAPKRyUAl4vkWT8m9WNInBDgurSmikkt5KlKbd8kv/oZY/HY9G+4NdVDrN0sCn0g+rew2xf97UeFYCcSUnrK5xQUY/4eitbIzl84akGVG2QhOU0QeNOqsdiyWzqPiMG9V8LlLilsDa+l5N/UGOO8fSpdUU4i+WGbXtec8ETSFk5tjnkgrLDMI6FVXL+GTcR/WJ1uUC674uZEAQYaJFmCd0B2T1XMXXuEaKoS/bQbCEvjGO0OELhbzUV3Ixo97EuzcTVcQEXgnnr+HfKno4EbxQyP2bSkT1ijmhmcR7UldjdBknm8Bh0a6AfcEPDDtJcY6ZAu9aahbZNGkEiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cCzCYr4nt2xTtLcBUBlCtBSxudTa2Qranc3cbDDe44=;
 b=cKlZYb2Vl5yCZLYy34T7P3kUgRmyFQBqj7pAW5ZZ3r37BNLhOzJsMJdbpTe1lAl3N4nHjXvk3WGxcgsz6k29zl/rKQAyJhWFntSFFkiSqZtXgjBPtkqu5yPnDYhCHki3kl7ftz+Kuei6TosOFwTI7+9YakfEjbbZSkrLBICSNBWQI2LROKOLQmfJy357/cPDHHxGkk0g8VsxF6GTUzgxToI+7tMhgBNL7SWU4WOGIGtlYGZFF2NaNDQbtV48aS/wUFDN6xEVguCtRQcaztS1UO5b9D5/2dkLiRSDAWDDBZ0cDetB1dmrhQnIuAPu8T4jCHKaktFkfEwp3AQFhRAxqA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB7105.apcprd06.prod.outlook.com (2603:1096:990:91::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Fri, 9 May 2025 06:55:53 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 06:55:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 06/22] hw/misc/aspeed_hace: Support accumulative mode
 for direct access mode
Thread-Topic: [PATCH v1 06/22] hw/misc/aspeed_hace: Support accumulative mode
 for direct access mode
Thread-Index: AQHbmkNVt8u5ICXrp0OzkxV37+Wl4rOO544AgDtBbuA=
Date: Fri, 9 May 2025 06:55:53 +0000
Message-ID: <SI2PR06MB504109C2AA0AC26C243C30BAFC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-7-jamin_lin@aspeedtech.com>
 <c2789dae-3c0e-4ad3-b3ba-07493bdbec28@kaod.org>
In-Reply-To: <c2789dae-3c0e-4ad3-b3ba-07493bdbec28@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB7105:EE_
x-ms-office365-filtering-correlation-id: 00657a5f-322b-4eae-31be-08dd8ec68a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?MDdyOCtITWhXcy9adlhYOHpHU2VqOXExeEVyTFE0V0kwR2RnYzZIbTduVG83?=
 =?utf-8?B?U1FlRFVzYVhJZkVNNFZKMyswM0huMnRITStyM2JFYWJXc21nMmY3U1hCU1Ar?=
 =?utf-8?B?RmJBTWxMcGtrSStwdEp6RStFZ0Y3OHRtdG5TTWtZcmpCeDRnNGhYMEJjNVhF?=
 =?utf-8?B?UFdFNHJJVWR4bWZCZGVMTWRpaXBTRTZXZk5BLzRZYlhtUERkT1U3aWRUSERK?=
 =?utf-8?B?N1JhUzBhcFdSZjNnWHFTeWdzVHRzVDY1V3IxQ252aFRvdGt5RUFIZGg4Vkxu?=
 =?utf-8?B?eXQ1REYxcWVTYXlQbUZ6d3A3aGw4MGk3TE1pU09wSitOTHh0VGF3Yk8wMVIx?=
 =?utf-8?B?SjlPOGpTV29MdjQ3alQ2dkZxR2xFczFIT3U1RVdZYThpQnNuWHdjSlhBQUpP?=
 =?utf-8?B?aEk3VmlTdzdVUTRPcEZ0ZTFQdGRQWFZHZEVVK1hOTXc0ck4zTDY2aGd5Ymgv?=
 =?utf-8?B?TXNyZUJXQ2F4Y2taSWN3S0lkellxT243OHRIMXdCUDBLQ2QvcjRXN05abU4v?=
 =?utf-8?B?V2NnaFB5NzJhcDYwNFZseE9kT3VtTmFoSmJGOTllUGdlL3d1N2t0cW9tbmJW?=
 =?utf-8?B?Z2EvQ1JCVnpwQ2R6SlV4TDFDYlRNYm1vNFI3V052aFlqbENOQVhmNXZGaWxG?=
 =?utf-8?B?Z0NrSVBOb1h3TjJLWTRZRjBEdC92RWJrUHlCWmd5UmVEYmpsZzhsbzFyOEp6?=
 =?utf-8?B?R2RNSURYMis2bEN4SWwxL3c3NENldEVDbVE5aFdMOWZCaTZkejVFbG85ODcw?=
 =?utf-8?B?UklySnB2dksrYWlEMkVPdHp1Q0Zrb1hTblBaTHRBemNDWXNLQWFWWEl5Y05E?=
 =?utf-8?B?RkJNaFlaak9SNjlqeXNhdmFKOWxTVkg0SlAwcHp5cTl6NU1hU2RaaDBrRUdS?=
 =?utf-8?B?UEhOWGFpQVhzNk94SDFBN05wUlhhQ0tBOVhJVVdWL28raDIyTFhWS2N1MEc5?=
 =?utf-8?B?K1VCTHVoZWtPUGpJSXFzemNvL2phRjcwWDhXZE43SmtUT2YrWXIyUWVBWXl4?=
 =?utf-8?B?NTdNTjhDbXdJaElZL0Y5NjF2bk1mb1dFRFBhclhDYS9BUkx1OUFFY3JBSk02?=
 =?utf-8?B?Skp1UVBqZE9HcWpmWkRxWk92TTVPUnJrb21adGs0WE14TXU1Zk9SWTM1M2Fq?=
 =?utf-8?B?VkdVa09DTzdQNlMxRDdyS3Y3T0lCUnFhbk1uSVV3cysvb3lRajhrWThLZTI5?=
 =?utf-8?B?dU91N0VKaWZnSnBldG9xckpvdDl1cklhRlIzNURVeUdLZWNKVjZMOXJsd0ZL?=
 =?utf-8?B?eGNlalBhZ2lMZkhBWFdHbFQzT0RLUVJCSWRXQ05FZUR5ZlVvUDNWV2NxRHhp?=
 =?utf-8?B?NDBYYzVJa1Q4Q2ljZXJpWDVpUXdVYUd6SHlaMWRnUHJqcGs0K2liV251MGtn?=
 =?utf-8?B?REpsRkphQlJLNTI1NXZ0V29jVkVNMzhGUEZtbzJFcUNoampDbjk1VjBKREti?=
 =?utf-8?B?TmxUL2ZBME4rd1JqaWxCelpHVTk2eVd6Rnk0eDhUMW9lWmNrd0phY1hsd0o0?=
 =?utf-8?B?cWkvdHBlTGRrUnY5bUdVSDhLV2Q2S1EyS1k1YVF0ZlgyV1pmUmsyVms0NExD?=
 =?utf-8?B?bHoxR2pRSmlFeVJrZVdJd3B5WldOdkl5UFRqa2Z6am15NnlPUFQzK1lub2Ux?=
 =?utf-8?B?Tk5lWUgwRVFibG4xOE1QUDJuMUxlUXZkQ09CVTQ2YjdOa2lGT2NZdEJlb2lN?=
 =?utf-8?B?TlZlNzhxOUZ4Tkh3M0hwejBwUmsySXRHOEtka2ZsaFpmd1RpS0lNV2Jna3N0?=
 =?utf-8?B?ZVJEWG5pZm9DeGxVQjA5ekloY1dENlk1TjZnQWNTQzQvamM2L0FpTkRnajYx?=
 =?utf-8?B?QVZkOWpsK0RONjJtWndFOFc0NjJqU1Rwcmp4UkxRcEplOWZJdmluYWFKQjJG?=
 =?utf-8?B?ME9Ic0VRN2FueDNyK3ZlcnhoL2hyVks0VnZXZWNlOTd1RWZBYThwRk5JSEpq?=
 =?utf-8?B?TU03UytmT0hzbktrOTd3T2lMbTZpWU00cU1VaVpKamdqK2c5ODg3QlBmc003?=
 =?utf-8?Q?q/XPqIgEKllc8FBbcxwQO4FLsmR6Ys=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk1MdmdaUmxoaHMzc3ZuNy9LQWthU0dnWWZhTGxiT2lzbGUzZm9IdVVRYlNw?=
 =?utf-8?B?ZXFjc1IyMXFxQTZDZVdvYlVkU3NDcW93WW9SS3Z1Q08xei95ZUNxVXhQLzJD?=
 =?utf-8?B?YUt2S0Z4Z2JLSVd0WThlc0xHWDJ0Wkp2K3hmT3poV0FWUHRIUFh1dVExUnBS?=
 =?utf-8?B?M2w5dFpiOS9jYlBBM1ZyK2U5Q3NYTWVUOFNBTkJJMVhRQXlablJZc0ZIbVNj?=
 =?utf-8?B?TXlkaHlIeXRUMDgraWViczByeE85TG1GbmRKZ01nc3pVbS93UjUrdW9zYmpU?=
 =?utf-8?B?alZudjhVei9ia2xGdFlOcjdJTkxhbE11YWRLQ291bzR5eXhpYlFKeXpBVm5v?=
 =?utf-8?B?Z3FpVWcrSjhtaXdUNnBaaEVPSUxuZVliTjVsWHVraDl2SDFDKzRLL0pMVlJ5?=
 =?utf-8?B?NitRRFNjV29JR0orT1F4ajVFWmlOL1Z2WHNHd29KbWJsb2FZSzRjMkpOendL?=
 =?utf-8?B?RUpxVmZ3SFowdExjckZoZDVnMVZRejZTRFBEekp2ZE1UeHdpZW42L2MzdFUx?=
 =?utf-8?B?Sk54STRyUWVxZXcxVHVkMmFtWkc5YkkwakUvWHZVT3FybjYxZVk3YlVjamx3?=
 =?utf-8?B?ejhxZGZaa29vaVVTMHNycWNEa3pmWGJjOCtJTFQ5VjdSa3JpL2tneXZqZ0Vz?=
 =?utf-8?B?cW41UnNkS3kzSVUydkNraDRtaTc4M1lBeHBOaHIxTmJNa3lNTUxqQnVyR2pP?=
 =?utf-8?B?bUNGT1gwakVFcU9jN250VElhdzVHMnI3OVNFaWhXR2lmbnBzRVFnWnpkS1Zm?=
 =?utf-8?B?dnhGU1h6ZlA5cS9NNG9xQkc0cFdnYWlIaHdRZ3RFRW1rLzBqdGszbkhZL2hn?=
 =?utf-8?B?aWpMTkFVNTR6N05nczFVYVg0eEtxdnR4eEdQdlJFaGk3bVpLNktXb0N3Q2FM?=
 =?utf-8?B?MFdOaWpNV3pBcS9kL2pGWU1oS2phMTh2Zkc1Nm1vL3lZUTF3ZUJteWk1M0Zr?=
 =?utf-8?B?YUUvV0FFcTZnNGVIWi9EUzdkWjltNXVRUkNOMkh6blNEcit3WnJTSkhtUUpH?=
 =?utf-8?B?bSsvSmJMakd0b0g0NWNNRDg0SVBvTmhnNGNmRjdpZy9vUW1IR3l3M0l3Z2Q4?=
 =?utf-8?B?dHRabW5qRGlpWGxBTTVVakxZcTFLdmozRVpVc2wyUjY2ZUdDdlNhV2VGVTVX?=
 =?utf-8?B?UEMzQWZHL2NIYTRMWGgyL3lrZFZtaVlidGtHbXpoWVZ0enVEZFErVUJVeEwz?=
 =?utf-8?B?elR1L09qSlF0UWQ1b2hJVVl5ZFowcUt0VGZkbnpsVnNnNktqMmc4Y2RRQ3Jh?=
 =?utf-8?B?RkpCZTByV0hyVEhOWW1xN2NCWkhPaTI0YjcxcFpXcUs4STh5TUNFSzhMYXFM?=
 =?utf-8?B?YXVJb09WbW5tNGJPYjlhUWRrdlpGMDZ6M3VhNko2SUpubDdXbzNEdjQ4YzhX?=
 =?utf-8?B?dVFWWi9ieTgvM1hydEJ3MkxOT2g2akhuNmRvYVMyM25NSDQ2b0dwV3lGWnBQ?=
 =?utf-8?B?T01YRDg0aXpMZmpKRXVkSGdjUFlYSysyQnBKZ1lzY3lESjlURWcyd0VGUXph?=
 =?utf-8?B?b3NPZVBPU1NBc2pMZWl6NFROOFF0UHJKTUg1dklhQU80Vjcwc0hmck41aXJu?=
 =?utf-8?B?Qml2eXMvVDdpWksvUHZSV3NGMnluQ2ErbHBnTGgxc2RxM2M4MzkvTjUreXNj?=
 =?utf-8?B?dTBJMVVsV05WTDA1UWJNUk12Q29md1UwWXpudFRzQ2hJRDIrR1llbXVGMEMx?=
 =?utf-8?B?bjVuanlQTDh2ZmtCSXRmRGVncTdpaXdPZHNwNnQzWHp0dW1MQTFQbjk2ejRr?=
 =?utf-8?B?OUxHQytVbW9hUElQbElzdUkwTkM1VUlvMlp4a2YzblphMktSNEJyU0dHd3dp?=
 =?utf-8?B?cUhhV1lGVkpyN21uTkV1UTJpbVNHQmU2cEgwYjhRRWZaSEIreDZNdG51bGY4?=
 =?utf-8?B?QXg1cnlxbyt2Z2FVbzArMmhhaXBkMEdiT0s0VmE2WVZZSnJ4WTY0enN3ZW9t?=
 =?utf-8?B?a3FSaldnc2pGRG1kNGJUbEFqTytvcWQ5QXpFWjdnb1krVmtsc0dRSnNaR01y?=
 =?utf-8?B?RWRrL0hyTHZNQjJkNWczZUdXZ3k4NUxZdHFQczBOQnA1NUorNDJrcUpTdVZK?=
 =?utf-8?B?eThxcW5wa2kxYUJSUmxWOEQrckdXV05Sbjh2TGxTRXhUL1JCTzNFUHNKbjZP?=
 =?utf-8?Q?fh+DSTe3bPsicIxDex+dEDDMv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00657a5f-322b-4eae-31be-08dd8ec68a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:55:53.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSEKkK9sjACCnHnEeykI4OXcP5JV2AybcqGEFkes5oUZIyWUCsDszkGn0fT866eK1A4DVxTSlxILyWm1UIGUQEjEN+khIpP5EZdOVLVoEnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7105
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDYvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IFN1cHBvcnQgYWNjdW11bGF0aXZlDQo+IG1vZGUgZm9yIGRpcmVjdCBhY2Nlc3Mg
bW9kZQ0KPiANCj4gT24gMy8yMS8yNSAxMDoyNiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEVuYWJs
ZSBhY2N1bXVsYXRpdmUgbW9kZSBmb3IgZGlyZWN0IGFjY2VzcyBtb2RlIG9wZXJhdGlvbnMuIElu
IGRpcmVjdA0KPiA+IGFjY2VzcyBtb2RlLCBvbmx5IGEgc2luZ2xlIHNvdXJjZSBidWZmZXIgaXMg
dXNlZCwgc28gdGhlICJpb3ZlYyIgY291bnQgaXMgc2V0IHRvDQo+IDEuDQo+ID4gSWYgImFjY19t
b2RlIiBpcyBlbmFibGVkOg0KPiA+IDEuIEFjY3VtdWxhdGUgInRvdGFsX3JlcV9sZW4iIHdpdGgg
dGhlIGN1cnJlbnQgcmVxdWVzdCBsZW5ndGggKCJwbGVuIikuDQo+ID4gMi4gQ2hlY2sgZm9yIHBh
ZGRpbmcgYW5kIGRldGVybWluZSB3aGV0aGVyIHRoaXMgaXMgdGhlIGZpbmFsIHJlcXVlc3QuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGh3L21pc2MvYXNwZWVkX2hhY2UuYyB8IDE1ICsrKysrKysrKysr
KysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9oYWNlLmMgYi9ody9taXNj
L2FzcGVlZF9oYWNlLmMgaW5kZXgNCj4gPiA4Y2YzZjE5NGE1Li5kMDYxNThkZmZkIDEwMDY0NA0K
PiA+IC0tLSBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVk
X2hhY2UuYw0KPiA+IEBAIC0yMjMsOCArMjIzLDIxIEBAIHN0YXRpYyB2b2lkIGRvX2hhc2hfb3Bl
cmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gaW50IGFsZ28sIGJvb2wgc2dfbW9kZSwNCj4g
PiAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICBp
b3ZbMF0uaW92X2Jhc2UgPSBoYWRkcjsNCj4gPiAtICAgICAgICBpb3ZbMF0uaW92X2xlbiA9IHBs
ZW47DQo+ID4gICAgICAgICAgIGkgPSAxOw0KPiA+ICsgICAgICAgIGlmIChhY2NfbW9kZSkgew0K
PiANCj4gaG1tLCBtb3JlIGNvbXBsZXhpdHkgaXMgYmVpbmcgYWRkZWQgdG8gZG9faGFzaF9vcGVy
YXRpb24oKS4gSSB3b3VsZA0KPiBpbnRyb2R1Y2UgYSBzdWIgcm91dGluZSBkb19oYXNoX29wZXJh
dGlvbl9hY2MoKSB0byBoYW5kbGUgYWNjdW11bGF0aXZlDQo+IG1vZGUuDQo+IA0KVGhhbmtzIGZv
ciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KSSByZWZhY3RvciAiZG9faGFzaF9vcGVyYXRp
b24iIGFuZCBjaGFuZ2VzIGxvb2tzIGxpa2UgYXMgZm9sbG93aW5nDQoNCk5ldyBIZWxwZXIgZnVu
Y3Rpb25zOg0KDQpoYXNoX2dldF9zb3VyY2VfYWRkcg0KaGFzaF9wcmVwYXJlX2RpcmVjdF9pb3YN
Cmhhc2hfcHJlcGFyZV9zZ19pb3YNCmhhc2hfZ2V0X2RpZ2VzdF9hZGRyDQpoYXNoX3dyaXRlX2Rp
Z2VzdF9hbmRfdW5tYXBfaW92DQpoYXNoX2V4ZWN1dGVfbm9uX2FjY19tb2RlDQpoYXNoX2V4ZWN1
dGVfYWNjX21vZGUNCg0KYGBgDQpzdGF0aWMgdm9pZCBkb19oYXNoX29wZXJhdGlvbihBc3BlZWRI
QUNFU3RhdGUgKnMsIGludCBhbGdvLCBib29sIHNnX21vZGUsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIGFjY19tb2RlKQ0Kew0KICAgIHN0cnVjdCBpb3ZlYyBpb3ZbQVNQRUVE
X0hBQ0VfTUFYX1NHXTsNCiAgICBib29sIGFjY19maW5hbF9yZXF1ZXN0ID0gZmFsc2U7DQogICAg
aW50IGlvdl9pZHggPSAtMTsNCg0KICAgIC8qIFByZXBhcmVzIHRoZSBpb3YgZm9yIGhhc2hpbmcg
b3BlcmF0aW9ucyBiYXNlZCBvbiB0aGUgc2VsZWN0ZWQgbW9kZSAqLw0KICAgIGlmIChzZ19tb2Rl
KSB7DQogICAgICAgIGlvdl9pZHggPSBoYXNoX3ByZXBhcmVfc2dfaW92KHMsIGlvdiwgYWNjX21v
ZGUsICZhY2NfZmluYWxfcmVxdWVzdCk7DQogICAgfSBlbHNlIHsNCiAgICAgICAgaW92X2lkeCA9
IGhhc2hfcHJlcGFyZV9kaXJlY3RfaW92KHMsIGlvdik7DQogICAgfQ0KDQogICAgaWYgKGlvdl9p
ZHggPD0gMCkgew0KICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCiAgICAg
ICAgICAgICAgICAgICAgICAiJXM6IEZhaWxlZCB0byBwcmVwYXJlIGlvdlxuIiwgX19mdW5jX18p
Ow0KICAgICAgICAgcmV0dXJuOw0KICAgIH0NCg0KICAgIC8qIEV4ZWN1dGVzIHRoZSBoYXNoIG9w
ZXJhdGlvbiAqLw0KICAgIGlmIChhY2NfbW9kZSkgew0KICAgICAgICBoYXNoX2V4ZWN1dGVfYWNj
X21vZGUocywgYWxnbywgaW92LCBpb3ZfaWR4LCBhY2NfZmluYWxfcmVxdWVzdCk7DQogICAgfSBl
bHNlIHsNCiAgICAgICAgaGFzaF9leGVjdXRlX25vbl9hY2NfbW9kZShzLCBhbGdvLCBpb3YsIGlv
dl9pZHgpOw0KICAgIH0NCn0NCmBgYA0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQo+IA0KPiANCj4gPiArICAgICAgICAgICAgcy0+dG90YWxfcmVxX2xlbiArPSBwbGVu
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgaWYgKGhhc19wYWRkaW5nKHMsICZpb3ZbMF0sIHBs
ZW4sICZ0b3RhbF9tc2dfbGVuLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBh
ZF9vZmZzZXQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAvKiBQYWRkaW5nIGJlaW5nIHByZXNl
bnQgaW5kaWNhdGVzIHRoZSBmaW5hbCByZXF1ZXN0ICovDQo+ID4gKyAgICAgICAgICAgICAgICBz
Z19hY2NfbW9kZV9maW5hbF9yZXF1ZXN0ID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgICAgIGlv
dlswXS5pb3ZfbGVuID0gcGFkX29mZnNldDsNCj4gPiArICAgICAgICAgICAgfSBlbHNlIHsNCj4g
PiArICAgICAgICAgICAgICAgIGlvdlswXS5pb3ZfbGVuID0gcGxlbjsNCj4gPiArICAgICAgICAg
ICAgfQ0KPiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgIGlvdlswXS5pb3Zf
bGVuID0gcGxlbjsNCj4gPiArICAgICAgICB9DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAg
aWYgKGFjY19tb2RlKSB7DQoNCg==

