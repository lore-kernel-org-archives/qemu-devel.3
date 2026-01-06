Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B858C47BC4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 09:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd2yZ-0004IG-TI; Tue, 06 Jan 2026 04:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vd2yY-0004HK-0e; Tue, 06 Jan 2026 04:03:38 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vd2yW-00050w-FA; Tue, 06 Jan 2026 04:03:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPinBd6eUHN6VHwlmxiQ01Y0PZQK5NfqfC1gWytYgmsqi1LuwocEb+C+ldIDIX4PaDVUUK+kr14lL8xgoA+WjoVFIlyCr35oPNncqT5py0zIp7sPkcEa7MeRLps0Ko+tCYJ+irTwyqoupVoa5fRKjLUiWuNuo5P+4Q+R7OrtYCt7nqjK/111YfUkYDqYIsCjdCTBsP1GaTjMOppFBaCy13/1UfyNymCJyCrEddbDc4FUkQJILLoW6FXV5cJYi+2CkAVK3RBVo9eWTlrkt0A+KdiH+JObJpulPyl7zVacztd+mL2dwu/xNcNKrizX8KjPpRNCgD270fA35jzksPQXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfBnn27ZiJTxWJ9kUeg7psjqA6yueRAlFHIvnDNR9eE=;
 b=LJf131080j8SlXG+XW1xGTYPNS5Wo+8/rbrGDinMc5Q9qtisdqGe/vE7+Em6qEsAUtABSpjPwTsb9FTXOLSM7gq0cvZCIvfq0wNbphMdo7S5s9hSjNvIp5wxUURM+/c3q5eYniCWam0r07422mvvQCjQ8VohJyTLmb39qaSPlYI13A0iDDvIp2NJyL1sVum9wY9i9qApJRq5m+DTlVxvhH1iitQdolRyJvyaaxT9sHJsBraxVn+GZTF7NhdgLLlqNEYI30kOpTCqbxrN3dsm+RQriCBi6lOjNWXSjYCl3udmmbCgX1JLZe+9HPc/zMrB4khIvo452lC4OrCXZbADZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfBnn27ZiJTxWJ9kUeg7psjqA6yueRAlFHIvnDNR9eE=;
 b=n0JfxlwIVvW3aeR5W1TYDLTsHtpsmvNBhVxKcgOP6BxmYGeRU0sLXhR4e7v3m8OhoUAQs383ErgeurglFFMHwOenykHi5GpGKERPRgaIUUhmTS7xQlbPL9gktQFv3x99geerwADtacNJZe2Sd5Wt+XwfoblZkrTbiWMXHPNKi8/wLBFfzukgUmphPWYKW0whpMcSpYsFxYWC/rtSsByhyLgUUQaNADVxPHIB8/VgoUCU0ANYdXFTVs+LWW8UYiyaHeCGo0Ez+bVQk3K9eOB035HFifvL5rDeIfu1uBgBqlzRtQz0LjdC46j3ChyAxjvIRTfToCFwnA3J+/a5uS4ywQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5058.apcprd06.prod.outlook.com (2603:1096:4:1c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 09:03:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 09:03:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 16/19] hw/i3c/aspeed: Add I3C bus get function
Thread-Topic: [PATCH 16/19] hw/i3c/aspeed: Add I3C bus get function
Thread-Index: AQHb2/bCugo833ocPU+SFBoY2Yyt4LVGHpJQ
Date: Tue, 6 Jan 2026 09:03:31 +0000
Message-ID: <TYPPR06MB8206B4E1707204BA17A7D4EDFC87A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-17-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-17-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5058:EE_
x-ms-office365-filtering-correlation-id: ff334ad8-b148-41b2-d42b-08de4d0276fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K1kvN1RndzB5enZBNWlyc1ZLUk9lUWo5dW90UWFFQ1gzZ1FkVjJxRFRRN1pX?=
 =?utf-8?B?a0NHUDExbDRqZDNBME1pemdiR0JyRUJxVWR1QnlOME1tcjc4WVNlZktNZ1Ra?=
 =?utf-8?B?OWFTYkJIK2M4THlmR0JOK3dYUUN5Q3ZCKzdPZUh3R3lMZUhYVEdzY3dRU3dC?=
 =?utf-8?B?VkV3Y3pmWHd6Vlc3ZlRjWlJhR0w1WFgrZktPWlIzUFlOcHlkOTFsanRFY0dR?=
 =?utf-8?B?c2o2c2F6S01DR2l1QTBCSXVlb2J0aWpNRzhLZE5Md1B2RXc4T3M0b2g3bTQr?=
 =?utf-8?B?V1NGU1RmTDFWbHM3cXV4TWhjSW5nd1ROc3QvL1NTZGRiajlMWVRNejZBTHFx?=
 =?utf-8?B?YmR2NGhlYkllSEkraG9Jci82VGpBZU9hOExoQmROQjdXQ2JqVHpXZ05jdE0v?=
 =?utf-8?B?WStOYWkvZys3NGNqWnZIa1FNdnJpSDJxenJoM2ZwY3pySGcxb0Y5M0Rjcnlj?=
 =?utf-8?B?OWR0TmpLUUpob1VSNUJwSW43bTdaOHdVajBYb1BvbUFXMHZzOWR4allxUysx?=
 =?utf-8?B?enVJeUNhL3VxaGpJQkdhTGlmdlVpWHV0TWdDblk2dzBVYjJ0ckZZY1RCbUl2?=
 =?utf-8?B?SzVWSG1ONlprZ1p5em5nQXIxV2hlMDNjSTVad3pBNHNPY3BubkZsUHJMNFpV?=
 =?utf-8?B?Qyt4QVlTQXdRYmU0U0oxZDhKRjRLNFJjMHA3eUZEVnRWUTE2cHhUMlhrSlpS?=
 =?utf-8?B?YTc1T2d5Y1drbnlTbXBhbEthdVgyaUVmVHlsTG9XVEhURjl5elJjRkFpRzBy?=
 =?utf-8?B?Vm50UEhNeWpVaTRJcFF2em1ZcGpuZ1lGRkxSelM5ZWdtQ2x1TGorNXgzSzFw?=
 =?utf-8?B?Vk1WMWNXbmdZNE5FYmcvVkR6OXRBeTNVWWp6aTV5ZC9zOTR1UU0wakZFUTh3?=
 =?utf-8?B?OW8vVG9WNld2L1Y2Yk1KOWtRRnZSSjd0Y3d5bUJUSUpqeGprY3BaaDdtcSs2?=
 =?utf-8?B?VFJGZXN5djB3dXpFbER3cWY3cVp4MHo5WmlGYUo4dFZXVGtMOENwb0ZlT0hX?=
 =?utf-8?B?aUF2QytzUEhCWktuRDVXc0UwaCt2M2RCTnk1dUxtZWhsL0Vrb25FVko0OGdi?=
 =?utf-8?B?U3A2VDRrdFYvOFR6T09URWk3U2l5ZW9FYzVEMDh4cVF3U3hSeXpFcHF6RDht?=
 =?utf-8?B?L2d2NVlQTURPZVpxWXJCdmNXdkNvamJFNGV6OTFpclZiUGxPMVRGZHNOVVFa?=
 =?utf-8?B?QTIrRmc5cGQ5dHdRaWdna1JxUDVCUWhQdmMwNTQvTDRhcXphR1JxYXhkUGp0?=
 =?utf-8?B?WktsRUR5bjRuMHRPQ0h1Wnl2ODBYU2VrMTFEZCtUWDF0REdWTDFWc0Jha3ZO?=
 =?utf-8?B?QVhsalZVUktyVU9wRitVbC9XbkhoQ0QrcW5jcFpxUDBPQWZQZDNDUDgwd1dZ?=
 =?utf-8?B?MjNqdnVyM01sNDdUNXdWQndneTNNVUwyOFp6R3ZQRjVHZDhJQytNZ2VhQVFL?=
 =?utf-8?B?VSsyMmhvL01qbzJzMXFkYnZTZFNWWXZGdnVhTW85Sm9FeFhEaGtQN1pacXpw?=
 =?utf-8?B?aDdzdGtsRmxkQzBoVkxzcEdJcXVlamIxOFZjV1g4RDZnUVFSMmMvS0ppT044?=
 =?utf-8?B?cm1DU0tseDNwcGZmTlpvZWFHMGFqUzYzU1ZIc0pYV1Q2MFJqUnQ4Q2FyNE02?=
 =?utf-8?B?ZlZqMWdoVXVCMU95bDZTZmY5dTVhNWNDSVBGblBuTHMvV0NmTUMwNFF3d0tv?=
 =?utf-8?B?Z2FGV0hRcFMrRWpkSzBteGJHdmVIbWZiWnpUV2VQd25velVIV3UwV0lPVXgr?=
 =?utf-8?B?aHlmVjBPa0RvRThXSkFacGV6R1pEN0Z1My9VY1gwTTdTTmdRaU9Mdng0Ymxy?=
 =?utf-8?B?NnA1NkUxeThxdUNlUkdLVEJneXlrTG5NaTUrcEhHQkxyRXRmSU1aR2tGbE9O?=
 =?utf-8?B?WjZURGVvT0dKRW9zMFlBZGI1L1ZxMys2VitoOG1yWmdxY3M1ZHRSMUprRXcw?=
 =?utf-8?B?RXNTVEtKZVF1ejYvMURVdUtQT1orbi9TU1N5TTMwUUJNUk5zQ1U5dE0zZVRu?=
 =?utf-8?B?L1VUelZvVzBGbVBnWHJTbkpJWERhaVhDMVpxZEp0Mlc2ZzhRS2VqUFlDMWVz?=
 =?utf-8?Q?fSHQfj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0g0dU5HaC9kbE1uNFQ2SFYwYVNqbGloZnlKTlQvcVhwcVRtS01hdjJqYXBK?=
 =?utf-8?B?d2VST2NPOWkranJ1aVFWc1R1MmM3S3ZsclUzbW12bU9pZmRyc2dndDJNRTFC?=
 =?utf-8?B?c3U5bHdXelVMM3JmVVpyWVVQQ2NxRXNWOEJrbEFqdDZtY2MyWTR4bVFaQkNr?=
 =?utf-8?B?LzNCNFVYOG0zM2JacEVXUy8vUzJ1dEwwYmU5dmoyZFhiUVpZY3ZPL01CdktU?=
 =?utf-8?B?U1NyUkZ5OU50TmxxK2kxNkRObDdsVXZPSWZUYmxKOVdiajZxWTRwaHVkbERv?=
 =?utf-8?B?ZWsweWx2clBraXpRWHBsNEFrOE11MXV6VC8rOG5rQ3JzL3pFOWdkSzlMeXhn?=
 =?utf-8?B?bEFyY2FmcHRMakQ4SWlBdzlXS0V5MG15SitNRHdiZGVtbjZjM0ZTeStQVkZO?=
 =?utf-8?B?eVl5VDdpYkZ3MzFxbnh5UjJMcGVMbTVndTllZytNOS82Q1ZWcDV5eXpJWUYy?=
 =?utf-8?B?TzNUcXc5UFBSdTljK3o0b0UwbVRVMHp2QzRmMnQ5RHBWQ0xmZHZUem5RU3BO?=
 =?utf-8?B?NFVqL0VxUmZLRnNwS0l3bFQwSFUvalFEMXZpRi9wRkhZcGtMK3k1Y3FFWTB1?=
 =?utf-8?B?UEVQbzBqR0lNZTEyeGVtbTBtRDh6aWt4NGxSUGc2eUswdThwM3VJNU1FWW1q?=
 =?utf-8?B?RVlRUTIvenpQeG1tSmI1RG5OUVBYTlgvbFgxYkVpbHB4NEJ1eWRjVnhPN1h2?=
 =?utf-8?B?VGdoblZrdzBxTWEzYXp5VG9CN1YrTWFNVTlqbmlNWnl4RzRTM0NSY1hycU84?=
 =?utf-8?B?V1c0bklQNzhnSWdzeEVvVVRvZVdZMi9rWWpEbHphOVJ4aHJtUGp3ak11S2xw?=
 =?utf-8?B?SVpucXpkZ2JnK1pjQ0hGbFZyUWIzbFBneUxIUmUrQmxIQzFWZWRVT0pqRVVz?=
 =?utf-8?B?QzdPellid1JLalQrcHVnSHdiNFAwaGtOSXlleFlJY21BZ0JPRGFkb2hEZjIx?=
 =?utf-8?B?cm4zNUxqdzVkNVB2VWozQUhFZVlPTjV1dmh1b0N5dkEwenh3b09JRE1Xb1hx?=
 =?utf-8?B?aUk3dlNnVTFhc00wUy9TdXdmQncraFZCR3UyQ0JsaGMweXNObVpLd1hoeFVr?=
 =?utf-8?B?KytnN1NjUnM5N0FBR3IxbUFZNEtVYk1IUVJVZTYxRUExbXNEVlVlMVIyUE1I?=
 =?utf-8?B?Y0dGaDdNbklOR3d3c3pxSkFOSnJwM1MvZC9aVnZLTnZ2YVV6SmZTMytTd1px?=
 =?utf-8?B?RkozVEtXYXNaNEM2VGlnVFVXcjY5QW5MVWE0Mndxc29wbEl0SFNHcGk1UnJF?=
 =?utf-8?B?N2NsWjFFNmQ2SHlwVFhrSE1vYVlTcXN2U2RKbC9OZ3FuUUpJUVV6WlJqaVlI?=
 =?utf-8?B?VmlzUGNMZ3pKb2FDRnlnSkp1VENFQVJKVXdnR2VkcUJmYXZBOHNSRGFyR0VW?=
 =?utf-8?B?N3RRUklkNk9NbEt6WnVEdlVQc3MrMFNCc3ZqVlY2ZE1iR1dOUExmV01rZ1ZP?=
 =?utf-8?B?SkJYbzAyUFhmeFZKa1RUL1FmVmpEbE5GMUMveE9uMzB1RDZBMkZTV0R4OWdZ?=
 =?utf-8?B?dUQ0elVTR0pyZ0pZcWpxZ3N0YzZnZ05HM0hXZ3h4U0FKVU0yejRQR2tLZXpV?=
 =?utf-8?B?L1hWZnRRc0ROVlNGZHM3TC83TE52UnljUkZ2NWoyalp5OTl0V0QvS3JKVlZM?=
 =?utf-8?B?aGMwQmVCWDNRSkhUOCtCMG9kZHN5ZmFCeS8rcFBoVlUwZ05ORENhVkFNQXVr?=
 =?utf-8?B?VWE3Qmp6c0lwMU5ReU9yeC9zcnBObnhQR1g1UFBKV3d5alBxNjh0RDEwWmx2?=
 =?utf-8?B?VmFJOUdTZGV1VEdpeXBsWVR1WXg0dTd6NDRTc0R6MjFZRkJ2SkxKK2FMWCs4?=
 =?utf-8?B?VnpZQTJRMUl4MzNLN1BGVDR6dE9MZFVBWi8wVjVBQWdYRUJpdkxQL3lIdXQr?=
 =?utf-8?B?TVBkT01lUFpNMTd6d0g5Q2lsVmthMDZLcXRjZ1JZbEx3Ty9hRU9QZDQ0YzVO?=
 =?utf-8?B?MmczVUJXOWREdnR6Ri96UGRUUG9CTFBCcEFOdC9Vdi8za1hqU25kU0ZvaTNy?=
 =?utf-8?B?aVZXVEJRVUx0L1F3L1dwZ3hWYksvRXhhUGVobWVId0Y4aGY0VTJJZG1zLzdk?=
 =?utf-8?B?bHdLaGlyUVYybWNFRnN2MVNXU2JrS2FzM25VSnorNzBWVUgrRzNjOGZQODU1?=
 =?utf-8?B?RjZZM0syM090Wi9tYTN4K0xlL0hRU1ZNKzRRSTRLZ01ITVY2KzZPNUF6SGZs?=
 =?utf-8?B?QmVrNjhlRldNRm5lSWZ6bVJyZGM5WGdTaU0rRTg5RmpzbDdIL1UrcHpXUENH?=
 =?utf-8?B?clpBdnc1TmNNZGx1ZDdwWVNiSnkyZUwxMHF6SFZTSW9UN0hUaHp4Vk1qeTE3?=
 =?utf-8?B?YWZieE9taTl0WE5LSEc1alBQWFVZSXEzSUsxWituVHhyTDE5SVZXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff334ad8-b148-41b2-d42b-08de4d0276fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 09:03:31.4337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4siFT1oW4eDqqyI89gCLSSdxxFvmKjhaS4yIaNhvJNXLMZ/nqsg9nxJinnFjwQg4AJ7mPxjuQ3A4cmLKn72FbE6CM8PykXJAIZxLuUhoPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5058
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTYvMTldIGh3L2kzYy9hc3BlZWQ6IEFkZCBJM0MgYnVzIGdldCBm
dW5jdGlvbg0KPiANCj4gVG8gcmV0cmlldmUgdGhlIEkzQyBidXMgb2JqZWN0IG5vcm1hbGx5LCB0
aGUgb3JkZXIgaXMgQXNwZWVkIEkzQyAtPiBEVyBJM0Nbbl0gLT4NCj4gYnVzIG9iamVjdCwgc28g
bWFrZSBhIG5pY2Ugd3JhcHBlciBmb3IgcGVvcGxlIHRvIHVzZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEpvZSBLb21sb2RpIDxrb21sb2RpQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgaHcvaTNjL2Fz
cGVlZF9pM2MuYyAgICAgICAgIHwgOSArKysrKysrKysNCj4gIGluY2x1ZGUvaHcvaTNjL2FzcGVl
ZF9pM2MuaCB8IDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2h3L2kzYy9hc3BlZWRfaTNjLmMgYi9ody9pM2MvYXNwZWVkX2kzYy5j
IGluZGV4DQo+IDFhZDI1ZTVhMDAuLmFmMWZmNWJjMTIgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzYy9h
c3BlZWRfaTNjLmMNCj4gKysrIGIvaHcvaTNjL2FzcGVlZF9pM2MuYw0KPiBAQCAtMTUzLDYgKzE1
MywxNSBAQCBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIGFzcGVlZF9pM2Nfb3BzID0gew0K
PiAgICAgIH0NCj4gIH07DQo+IA0KPiArSTNDQnVzICphc3BlZWRfaTNjX2dldF9idXMoQXNwZWVk
STNDU3RhdGUgKnMsIHVpbnQ4X3QgYnVzX251bSkgew0KPiArICAgIGlmIChidXNfbnVtIDwgQVJS
QVlfU0laRShzLT5kZXZpY2VzKSkgew0KPiArICAgICAgICByZXR1cm4gcy0+ZGV2aWNlc1tidXNf
bnVtXS5idXM7DQo+ICsgICAgfQ0KPiArICAgIC8qIERldmVsb3BlciBlcnJvciwgZmFpbCBmYXN0
LiAqLw0KPiArICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyB2b2lkIGFzcGVlZF9pM2NfcmVzZXQoRGV2aWNlU3RhdGUgKmRldikgIHsNCj4gICAgICBBc3Bl
ZWRJM0NTdGF0ZSAqcyA9IEFTUEVFRF9JM0MoZGV2KTsgZGlmZiAtLWdpdA0KPiBhL2luY2x1ZGUv
aHcvaTNjL2FzcGVlZF9pM2MuaCBiL2luY2x1ZGUvaHcvaTNjL2FzcGVlZF9pM2MuaCBpbmRleA0K
PiA5ODMzMjkyZWMwLi5iM2U0ZDEwNTVjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2kzYy9h
c3BlZWRfaTNjLmgNCj4gKysrIGIvaW5jbHVkZS9ody9pM2MvYXNwZWVkX2kzYy5oDQo+IEBAIC0z
NCwzICszNCw1IEBAIHR5cGVkZWYgc3RydWN0IEFzcGVlZEkzQ1N0YXRlIHsNCj4gICAgICB1aW50
OF90IGlkOw0KPiAgfSBBc3BlZWRJM0NTdGF0ZTsNCj4gICNlbmRpZiAvKiBBU1BFRURfSTNDX0gg
Ki8NCj4gKw0KPiArSTNDQnVzICphc3BlZWRfaTNjX2dldF9idXMoQXNwZWVkSTNDU3RhdGUgKnMs
IHVpbnQ4X3QgYnVzX251bSk7DQo+IC0tDQo+IDIuNTAuMC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0LWdv
b2cNCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0K
DQpUaGFua3MsDQpKYW1pbg0KDQoNCg==

