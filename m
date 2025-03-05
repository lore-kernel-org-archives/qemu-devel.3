Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF917C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 04:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpg19-0006OJ-8R; Tue, 04 Mar 2025 23:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpg0p-0006MJ-MU; Tue, 04 Mar 2025 23:05:42 -0500
Received: from mail-tyzapc01on20720.outbound.protection.outlook.com
 ([2a01:111:f403:2011::720]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpg0m-0001Vp-6k; Tue, 04 Mar 2025 23:05:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da/RB+z7LL+lbulmxVHIEvWfTmdFql1qqrHwVfwwiW7rNGsiilxcR03d9DnxZbac7KQOOMsfNqFs00q/sImw7Gg04r6wk8q7ZIQ6+B0jkfVgkb6k1d6LdRto0fznwr7veqHg/p5ZEjV4bBtL/XIq8qWlY6x9nNakOtjRCBIyaNz+2Ryz+KlcN2RqyIT1wh4qm9XERtvZ4d0wscB8gD8hKH3V0+f+0X7ZRdtB0UIKPs7z9qLxXulE/1DO6hy3T2oP1JK6PYrCxSB5Qp/2Hdno2pEVrj0WZvS+dMLQKHnvpojke4M1ioR15eMoPXkJQvPTwF8UiA1XxtaG7O8tm47Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9vuUjjQG92C48s+XupRV+2FWhZiPZsENnAxrz0vMDk=;
 b=sg1SLzM4lLwjt3gDgfZyagmNzkohQKo/viMpdNPF2jsI9IHsXuTaQmx3MHmgUEls5gw2oqj69+Tz9EiYRAQXu88aJRRNxFAm9H/RwZoTiMHHqmic7/KxfwfUtOjTopY5uRLEnxsiqKXLxBeUWvRS1VZ/wdkFiX54zBrpgcgDyK1vp8A66GQ7OYPVLe7ZPQRJ/SWCmKnOvPbzctZazafKOWK4tsqUwG7A1zlQc7zHV4Hu8EMpiAdnypSN7QtkAFjb5BChzQ0CthC0dWp8XXQ/9DqohEVozRUIl47rqoWazh92Z6RM6AIrHX/Z5dDBPWHd+DwzxSRf+K2rQMUF3a1Fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9vuUjjQG92C48s+XupRV+2FWhZiPZsENnAxrz0vMDk=;
 b=N713mH2vVQfqH0T6K3rTH72DKACU3vLC457c7FnOIdQFGc6r14s55h1+zbNAkS39FNhu7+PQunotRootjFOrDj4HIYaYTjkttc1punFzacOhUDwitamrvzgqv3kJliS1RgMiwYEIcLhpdJgq4+sfVd3PdpMoYN3Lu2+G9jcESMp6LkcZapoeFnwAV3TFVOfAjF6lUqE41UF8QYhLfyoDlnSTKRxUp3mr+9D+T3xfmlUT2XE/YZzh43jcwzLSM96kblJ97il65+ooCXhRQv9FIXYJa5eNRRk65SHbPH5VsNbKDaD0byYoIuT9wFV4Mgqs1IQspbAg1xoReYags8/TXg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6659.apcprd06.prod.outlook.com (2603:1096:400:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 04:05:22 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 04:05:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 03/23] hw/intc/aspeed: Reduce regs array size by adding
 a register sub-region
Thread-Topic: [PATCH v4 03/23] hw/intc/aspeed: Reduce regs array size by
 adding a register sub-region
Thread-Index: AQHbjCJYY3Ley6tw1EyWkz9Wa3+24rNhdu+AgAJ4QGA=
Date: Wed, 5 Mar 2025 04:05:21 +0000
Message-ID: <SI2PR06MB5041BBCE0459FB43D3FB0B4FFCCB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-4-jamin_lin@aspeedtech.com>
 <51ecafcb-4cd4-4617-a155-8d699b9dbc2e@kaod.org>
In-Reply-To: <51ecafcb-4cd4-4617-a155-8d699b9dbc2e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6659:EE_
x-ms-office365-filtering-correlation-id: d6a5f87f-be3b-4fc6-0b9f-08dd5b9af2c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NHRZSzI4VmhXejR6Nm85UWUzQXFUTGhENEdUaXhNV0hod212dTZDc29pd25D?=
 =?utf-8?B?Q3lNNk94V0ZnUnNyN2NKQ28xMGRKdmd6c2REV1N0eVVFMUpzV1p6RkJTVWt0?=
 =?utf-8?B?M1d5VXdzajdPMTVyTnRSc0Vua0tVR0FoNGNMZ3o3Qk9NVUgwWmlYUzc1NlBO?=
 =?utf-8?B?ZkRuL0hEMWtqdVJIMFFEL09qZ2hEQ1I0bVdTQkhHUXlxU3diOEltbmdia2ly?=
 =?utf-8?B?d2VsVjQrWWZxMFdGc1pocVdQUzhPSlpYQkVyS09oT00vWjFXdEFmc1I1OHB1?=
 =?utf-8?B?cGg0dmdpcmhjZmlaYlp3OWNmT3Ruck01MGkvUlFjN3VRdTQxRlFPaXVrY3h4?=
 =?utf-8?B?ZjU1L1YzcHFWSDFXZUEvM0FueEo0WnBPalVzdDgvbjRRQkw0MDlCVU5tc29v?=
 =?utf-8?B?L1NBVzYydHVhaE83Z01XQ0JVS2lFZ0pxV3lwRDNvcjgrWldRYUp6c3NSOXlE?=
 =?utf-8?B?a3ZCYzIzaks3Zk42ZnYvRFIram50Ni9TNUNwbTFoTUh1Sk1ZN2JCVEdmTWNz?=
 =?utf-8?B?b2J4NERqU0dzSmNUQ3pBVmxYaVlsTGNpamlEWVVyd1ZSSE1XazkyMjBQNkFP?=
 =?utf-8?B?d21VQ2E2cW94a2tWay8zZ1NqL0ZWR1BadjhIY1R2QlByZ2ptMzVUb3BOMlUx?=
 =?utf-8?B?NHRKM2pEMjNHVHdMemI3V2hkT3B3dkQ1d0tuUWRpNzExOTdBS2I2S0pKbytM?=
 =?utf-8?B?RGFLd25nQ3g4dm5wMHFRYUFuNmF3MHhWMGc5N213NEM4RUJrbXUxZjVpc0Ny?=
 =?utf-8?B?U1FQYmVIamZiRHNrTitNejlnZk5tdVgwSnN6TzJCTThkVGpDWEgvVjZNOXNa?=
 =?utf-8?B?bm1KV2xCczk5N1lMRkVHN3JtQXE3cVQrQlpRTU10UGU5UzhxSkxKaVVCakJJ?=
 =?utf-8?B?cjRFaGo0OXoveXVnSlBldDRVY1pIQmFEZFd0Z0NOUDEwVjM1ZEh5eVl0ZkNu?=
 =?utf-8?B?dGV2TUZyYjlTbGtKYmZ1amlUc3BRcy92MGJTT3NuaCtwUHQrTjJsTlh3UzJN?=
 =?utf-8?B?Z20wUmNJZzVDRURGenVhVysyM0xGRXczdzdtSVk5QlQ4eVBDRGZhT1p3NnJW?=
 =?utf-8?B?c2c0d2xOa1VDRHBYSklUUFBaUXVJdlI0R0VwRUQ0bDVUOXNFR2NIM29tcS9j?=
 =?utf-8?B?b1ovRGM3anB0aUtKa2swRCtoKzAwNEs1SEw1b2JlVkVsZzZiaURVTHlEN3g5?=
 =?utf-8?B?Z1pZRHJPdjVVOWZrK1VOMERXWjdGOGx4NDVKV1pwTjdkeFc0YldnUncwelpl?=
 =?utf-8?B?dGpsdGxvb3JmK2t4M3dNS2RNSnVjVVZxYnJrNnhqM1NxdVo3bWYzcXB2ZkVP?=
 =?utf-8?B?VEF0UnpMcUhhcHJxYUVudHZRemM3TFFzQzhpNmtNa3pySHd3QWg0NStsOG1K?=
 =?utf-8?B?Ly9tZXY0OGR6UnpGWEVFYlpKT3lEbmdDU0VKVVhIQnNRQnY2SzMyNmlXSHFV?=
 =?utf-8?B?Y0J1a2w3UExqaVFrcUx1OW1YMUlKWUdhMzFGbnBrTUMvVkZOVlZiVGMyM2E3?=
 =?utf-8?B?WDJ6SFh6bkduT2FCd3kxMElxc1RBb1NUOVF2SVBVTkh0YkkvY0FTdEtwSGw3?=
 =?utf-8?B?YUlqMmg0VjhLWGVUWFZGL2hDVDZqbzFBMm81VUU4cmNYNUdNZUh2YzVKSXow?=
 =?utf-8?B?ajlqaFZLek1jNnRRNytRRi8wblovMHN1QmYrV3FkY0d2NFNBSzZIT3VLK2FF?=
 =?utf-8?B?SmdZaXFkVW1SdG9KbXMwdGpPdzlHOVhBdTdTUXFlNXZMcTREamJWL2NpVWov?=
 =?utf-8?B?eTcrRlpubkxrekZSSDQrUWxidkV6ajdVZ2ZBdGxaTUFtd2tzSnVocFAvVDVL?=
 =?utf-8?B?YnFjTjRTSmNMYlBxdXl6TEEybkhQK2Z2cTR6bEdzTElYWlcrM2VKVWZiSGVZ?=
 =?utf-8?B?d1lNUW4rZm1obk9oYUpaenpBNXl5MFVKSmFvY0p4TG9MN1Uvcmk3VS8xU1Ez?=
 =?utf-8?Q?OaSm2YqYTVLJt5ndUk4KaPe1obbPsXko?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW9scW0yTlhDUlZuRkNuMU1ORTBvYVBHM1g0Q0NNdnFyRVVrTDllaWR6aTQz?=
 =?utf-8?B?M3J1aitnSnVTRWk1WlA3QlZXaTQwVnFNbGRVUHlWNEsvTjhqQ2VYK0IvRk5G?=
 =?utf-8?B?NGp4ZUF4ZXg0K3BCN2Fic0lBU2xmTmJEMW52SldZTkptVlphME1ySkxCL1hG?=
 =?utf-8?B?QzZ3Z0tCb2t2cG0rRUFTMXZwUzJYaFZ0TnF5TUhQSkEwdHVYRGZpUHhxaU40?=
 =?utf-8?B?dWp3SnZtb0hQeC93TzNsRkQ1dXFvamR1UUlaUFdJRTZENE83WjljVTl5NnVZ?=
 =?utf-8?B?Z1ZYUWxJallhZXcxK0VTMVRNMjF3UG5XNmc5RlZHaUVSNHZNWC91UEV2SjJ4?=
 =?utf-8?B?TTBvVXJNc0V1eTZFQXAvTXVlbFVRbExlOFRHSGNScFZPTTMvWTVwYXVkc2RD?=
 =?utf-8?B?ekxnL0VjTWh4K1lsZUNwckFJVnR5bUFBSXRZZ3RmSlVBbjJEbWkxM08reld3?=
 =?utf-8?B?WUl6WEgzdmQrVnovaHJSN0ZTQ2FtVklhVXpMdys3a1JacjZIS0hJRWF1U3cz?=
 =?utf-8?B?blZBNVZqVGdwUmFJS0pYbUVHeGFoN2JnYndEUk05bjB5anZBYmdaU2ZXRFQx?=
 =?utf-8?B?RXA0V0Evc0hOb2d6MTVjWGlaZm9qeUt2L0daWUk2OGsvZUswR0k3QVFsa0Q1?=
 =?utf-8?B?d3NXNFVERSt4UVNlWFU0L2FJcmVEUzRIeE0vZE5nQUVESjBUeFJJSHVsMHFn?=
 =?utf-8?B?NTNXMXpaTXJVZ25ndDFmTnpScUdyUUpWeDVvRU92ck1hQUk1NWhTYytXYUpo?=
 =?utf-8?B?d3FOYWw2eEo2cWxFMTV5dVUwT0ZlUkhyWHpuSWtleldjY3NWWlY5UTdUcEZN?=
 =?utf-8?B?eFpuZnZ6cWZmN2k3YzF3ZTdNZE1ZcFcwT1J5UkhqYS9mUE5lWnhST2d3TVZ4?=
 =?utf-8?B?RFdVK3hFUlE2MlY1dEVvYVhpN1czbFJVNlFxK1pITGJzM09CeWUyU2dPNG9S?=
 =?utf-8?B?bjlvMUdYREJjZTVaUG5kc0dxUWpFRW9sbEp2TGF1M0dEOGhPb0xCNENZd0c3?=
 =?utf-8?B?Y0FUU0RIMGRNd212NmZQZ1p3bVA1cmRQaDZmcVhIR1prRnFZR0h5azlld05R?=
 =?utf-8?B?TFJyT2pmVUVJbmZ4MitscFFVSm5Ha0JWR3pXeDZFV3JIc2dMMFlCNi8xcFVy?=
 =?utf-8?B?dXlKNXp0aTNvR3JlZWxFVVZrM0xTb0NOOXYvUEpycUVzM3ZkOHFCUFhJM2Ri?=
 =?utf-8?B?UmZnK0F3R1U3Nkw2WnA3RTJnUU50RUlXeWxtdkVhMEdGaVZhMGxVUG52SzZ0?=
 =?utf-8?B?OFdqVnh5UDJSTVlrS20vNEJGTDdJZVhHTGlGZTcxSGJzcjdMa2NmN3lFQzRz?=
 =?utf-8?B?TjQyUmZma2dDK2ZvNzRMc3hEdWFYdGN0eTRkRzNZM0ZJZFp1Y3p2RDFCU1lQ?=
 =?utf-8?B?Y29HbHlFRnFUKzdxeElHbGFkMkNQKzB0cHpuak1oYzgvOHQrMGdaNVlOdWVo?=
 =?utf-8?B?TitSY1pQMmZqWjJjaEVScFk5Rlcrb29LbGdFMTRDVm5idm9WLzhiclZEZ2p1?=
 =?utf-8?B?bUlGZEJ3U3ptRDA2ZHIrWTlMWWVqQ21aZWJHRkVibUhaWGV0dGY4ZVYzbjgv?=
 =?utf-8?B?WEJUWXM1eE9FdytyQXhEOG1WSGVYSnBxUkRNNjM4YVhYeVlydkdyaUhPOTRj?=
 =?utf-8?B?Q2FiK0hCRXh6S3ZXV0FSOHJDOWVLUCs4MmxIR0ZKWTZaNHdMd3BOeXdPZXM3?=
 =?utf-8?B?TSs0YmdQRXcwbFJnK3Fzd3dQWm5GcmZHMFNXTjQrOVVaQW1tUWdtZ0EyRmEz?=
 =?utf-8?B?YndaakFkMlhHaC9RdmhaaEdtYkxBUE40cUlyZUpZbEZDQ1VxR2Q1eDVRYUk0?=
 =?utf-8?B?T1BVRmVob0piVEcxUERkdmpKSHRGeG43QXo1Q0RTQVowODJHRzVlNW1tQ28z?=
 =?utf-8?B?L21aTW4rVE9wdFQrM3ljTTdLNWtOTXVjZEJIL2NPY0I0S0IyZlBoZVFEMWlL?=
 =?utf-8?B?NTBpNnhzYWRYeGR3SmJDT0QydW1VNDFjOVFQUzJWR3NRZWg2Tk1mTkhPZVdT?=
 =?utf-8?B?OXdJK2ZoWjJvWjdqS3dBQlhhNnRBSDVTeXhiOEJ2YWl5akp3UTNhSXFyVW92?=
 =?utf-8?B?K2xpYWVuRFdJSTh3WjNNQlBxbUdvSlE5UUdIczBZMThqUW1LTVdsQUg0eVFu?=
 =?utf-8?Q?Wxv6596xAq3LZxHfpUBug1OYc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a5f87f-be3b-4fc6-0b9f-08dd5b9af2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 04:05:21.2103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoaiaKuoiw7x4YjWSFSFnsTEM9Ez4ojCsLUjxDWWwNNC/UzpfLhQkn62azKwGFrJj5GWPbfv2j3t63RVO6POoHvH0syZl3EHxkCtXGd2CrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6659
Received-SPF: pass client-ip=2a01:111:f403:2011::720;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDMvMjNdIGh3L2ludGMvYXNw
ZWVkOiBSZWR1Y2UgcmVncyBhcnJheSBzaXplIGJ5DQo+IGFkZGluZyBhIHJlZ2lzdGVyIHN1Yi1y
ZWdpb24NCj4gDQo+IE9uIDMvMy8yNSAxMDo1NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEN1cnJl
bnRseSwgdGhlIHNpemUgb2YgdGhlICJyZWdzIiBhcnJheSBpcyAweDIwMDAsIHdoaWNoIGlzIHRv
byBsYXJnZS4NCj4gPiBTbyBmYXIsIGl0IG9ubHkgdXNlcyAiR0lDSU5UMTI4IHRvIGBHSUNJTlQx
MzQiLCBhbmQgdGhlIG9mZnNldHMgZnJvbSAwDQo+ID4gdG8gMHgxMDAwIGFyZSB1bnVzZWQuIFRv
IHNhdmUgY29kZSBzaXplIGFuZCBhdm9pZCBtYXBwaW5nIGxhcmdlIHVudXNlZA0KPiA+IGdhcHMs
IHVwZGF0ZSB0byBvbmx5IG1hcCB0aGUgdXNlZnVsIHNldCBvZiByZWdpc3RlcnM6DQo+ID4NCj4g
PiBJTlRDIHJlZ2lzdGVyIFsweDEwMDAg4oCTIDB4MTgwNF0NCj4gPg0KPiA+IFVwZGF0ZSAicmVn
X3NpemUiIHRvIDB4ODA4LiBJbnRyb2R1Y2UgYSBuZXcgY2xhc3MgYXR0cmlidXRlDQo+ID4gInJl
Z19vZmZzZXQiIHRvIHNldCB0aGUgc3RhcnQgb2Zmc2V0IG9mIGEgIklOVEMiIHN1Yi1yZWdpb24u
IFNldCB0aGUNCj4gPiAicmVnX29mZnNldCIgdG8gMHgxMDAwIGZvciBJTlRDIHJlZ2lzdGVycy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2gu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggfCAgMyAr
Ky0NCj4gPiAgIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgIHwgNTANCj4gKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5z
ZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9pbnRjL2FzcGVlZF9pbnRjLmgNCj4gPiBiL2luY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50
Yy5oIGluZGV4IGVjYWViMTVhZWEuLjE4Y2E0MDUzMzYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9ody9pbnRjL2FzcGVlZF9pbnRjLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2ludGMvYXNwZWVk
X2ludGMuaA0KPiA+IEBAIC0xNiw3ICsxNiw3IEBADQo+ID4gICAjZGVmaW5lIFRZUEVfQVNQRUVE
XzI3MDBfSU5UQyBUWVBFX0FTUEVFRF9JTlRDICItYXN0MjcwMCINCj4gPiAgIE9CSkVDVF9ERUNM
QVJFX1RZUEUoQXNwZWVkSU5UQ1N0YXRlLCBBc3BlZWRJTlRDQ2xhc3MsDQo+IEFTUEVFRF9JTlRD
KQ0KPiA+DQo+ID4gLSNkZWZpbmUgQVNQRUVEX0lOVENfTlJfUkVHUyAoMHgyMDAwID4+IDIpDQo+
ID4gKyNkZWZpbmUgQVNQRUVEX0lOVENfTlJfUkVHUyAoMHg4MDggPj4gMikNCj4gDQo+IFdlIHNo
b3VsZCBhbGxvY2F0ZSB0aGUgcmVnc1tdIGFycmF5IHVzaW5nIGFpYy0+cmVnX3NpemUgdG8gYXZv
aWQgcmVkdW5kYW5jeS4NCj4gDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24uDQpXaWxsIGZpeCBpdC4N
CkphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiANCj4gPiAgICNk
ZWZpbmUgQVNQRUVEX0lOVENfTlJfSU5UUyA5DQo+ID4NCj4gPiAgIHN0cnVjdCBBc3BlZWRJTlRD
U3RhdGUgew0KPiA+IEBAIC00Myw2ICs0Myw3IEBAIHN0cnVjdCBBc3BlZWRJTlRDQ2xhc3Mgew0K
PiA+ICAgICAgIHVpbnQzMl90IG51bV9pbnRzOw0KPiA+ICAgICAgIHVpbnQ2NF90IG1lbV9zaXpl
Ow0KPiA+ICAgICAgIHVpbnQ2NF90IHJlZ19zaXplOw0KPiA+ICsgICAgdWludDY0X3QgcmVnX29m
ZnNldDsNCj4gPiAgIH07DQo+ID4NCj4gPiAgICNlbmRpZiAvKiBBU1BFRURfSU5UQ19IICovDQo+
ID4gZGlmZiAtLWdpdCBhL2h3L2ludGMvYXNwZWVkX2ludGMuYyBiL2h3L2ludGMvYXNwZWVkX2lu
dGMuYyBpbmRleA0KPiA+IDMxNjg4NWEyN2EuLjBmNjMwZmZhYjcgMTAwNjQ0DQo+ID4gLS0tIGEv
aHcvaW50Yy9hc3BlZWRfaW50Yy5jDQo+ID4gKysrIGIvaHcvaW50Yy9hc3BlZWRfaW50Yy5jDQo+
ID4gQEAgLTE0LDI1ICsxNCwzMSBAQA0KPiA+ICAgI2luY2x1ZGUgImh3L3JlZ2lzdGVyZmllbGRz
LmgiDQo+ID4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiA+DQo+ID4gLS8qIElOVEMgUmVn
aXN0ZXJzICovDQo+ID4gLVJFRzMyKEdJQ0lOVDEyOF9FTiwgICAgICAgICAweDEwMDApDQo+ID4g
LVJFRzMyKEdJQ0lOVDEyOF9TVEFUVVMsICAgICAweDEwMDQpDQo+ID4gLVJFRzMyKEdJQ0lOVDEy
OV9FTiwgICAgICAgICAweDExMDApDQo+ID4gLVJFRzMyKEdJQ0lOVDEyOV9TVEFUVVMsICAgICAw
eDExMDQpDQo+ID4gLVJFRzMyKEdJQ0lOVDEzMF9FTiwgICAgICAgICAweDEyMDApDQo+ID4gLVJF
RzMyKEdJQ0lOVDEzMF9TVEFUVVMsICAgICAweDEyMDQpDQo+ID4gLVJFRzMyKEdJQ0lOVDEzMV9F
TiwgICAgICAgICAweDEzMDApDQo+ID4gLVJFRzMyKEdJQ0lOVDEzMV9TVEFUVVMsICAgICAweDEz
MDQpDQo+ID4gLVJFRzMyKEdJQ0lOVDEzMl9FTiwgICAgICAgICAweDE0MDApDQo+ID4gLVJFRzMy
KEdJQ0lOVDEzMl9TVEFUVVMsICAgICAweDE0MDQpDQo+ID4gLVJFRzMyKEdJQ0lOVDEzM19FTiwg
ICAgICAgICAweDE1MDApDQo+ID4gLVJFRzMyKEdJQ0lOVDEzM19TVEFUVVMsICAgICAweDE1MDQp
DQo+ID4gLVJFRzMyKEdJQ0lOVDEzNF9FTiwgICAgICAgICAweDE2MDApDQo+ID4gLVJFRzMyKEdJ
Q0lOVDEzNF9TVEFUVVMsICAgICAweDE2MDQpDQo+ID4gLVJFRzMyKEdJQ0lOVDEzNV9FTiwgICAg
ICAgICAweDE3MDApDQo+ID4gLVJFRzMyKEdJQ0lOVDEzNV9TVEFUVVMsICAgICAweDE3MDQpDQo+
ID4gLVJFRzMyKEdJQ0lOVDEzNl9FTiwgICAgICAgICAweDE4MDApDQo+ID4gLVJFRzMyKEdJQ0lO
VDEzNl9TVEFUVVMsICAgICAweDE4MDQpDQo+ID4gKy8qDQo+ID4gKyAqIElOVEMgUmVnaXN0ZXJz
DQo+ID4gKyAqDQo+ID4gKyAqIHZhbHVlcyBiZWxvdyBhcmUgb2Zmc2V0IGJ5IC0gMHgxMDAwIGZy
b20gZGF0YXNoZWV0DQo+ID4gKyAqIGJlY2F1c2UgaXRzIG1lbW9yeSByZWdpb24gaXMgc3RhcnQg
YXQgMHgxMDAwDQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICtSRUczMihHSUNJTlQxMjhfRU4sICAg
ICAgICAgMHgwMDApDQo+ID4gK1JFRzMyKEdJQ0lOVDEyOF9TVEFUVVMsICAgICAweDAwNCkNCj4g
PiArUkVHMzIoR0lDSU5UMTI5X0VOLCAgICAgICAgIDB4MTAwKQ0KPiA+ICtSRUczMihHSUNJTlQx
MjlfU1RBVFVTLCAgICAgMHgxMDQpDQo+ID4gK1JFRzMyKEdJQ0lOVDEzMF9FTiwgICAgICAgICAw
eDIwMCkNCj4gPiArUkVHMzIoR0lDSU5UMTMwX1NUQVRVUywgICAgIDB4MjA0KQ0KPiA+ICtSRUcz
MihHSUNJTlQxMzFfRU4sICAgICAgICAgMHgzMDApDQo+ID4gK1JFRzMyKEdJQ0lOVDEzMV9TVEFU
VVMsICAgICAweDMwNCkNCj4gPiArUkVHMzIoR0lDSU5UMTMyX0VOLCAgICAgICAgIDB4NDAwKQ0K
PiA+ICtSRUczMihHSUNJTlQxMzJfU1RBVFVTLCAgICAgMHg0MDQpDQo+ID4gK1JFRzMyKEdJQ0lO
VDEzM19FTiwgICAgICAgICAweDUwMCkNCj4gPiArUkVHMzIoR0lDSU5UMTMzX1NUQVRVUywgICAg
IDB4NTA0KQ0KPiA+ICtSRUczMihHSUNJTlQxMzRfRU4sICAgICAgICAgMHg2MDApDQo+ID4gK1JF
RzMyKEdJQ0lOVDEzNF9TVEFUVVMsICAgICAweDYwNCkNCj4gPiArUkVHMzIoR0lDSU5UMTM1X0VO
LCAgICAgICAgIDB4NzAwKQ0KPiA+ICtSRUczMihHSUNJTlQxMzVfU1RBVFVTLCAgICAgMHg3MDQp
DQo+ID4gK1JFRzMyKEdJQ0lOVDEzNl9FTiwgICAgICAgICAweDgwMCkNCj4gPiArUkVHMzIoR0lD
SU5UMTM2X1NUQVRVUywgICAgIDB4ODA0KQ0KPiA+DQo+ID4gICAjZGVmaW5lIEdJQ0lOVF9TVEFU
VVNfQkFTRSAgICAgUl9HSUNJTlQxMjhfU1RBVFVTDQo+ID4NCj4gPiBAQCAtMzExLDcgKzMxNyw4
IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pbnRjX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4g
RXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcy0+aW9tZW0s
IE9CSkVDVChzKSwgJmFzcGVlZF9pbnRjX29wcywNCj4gcywNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVFlQRV9BU1BFRURfSU5UQyAiLnJlZ3MiLA0KPiBhaWMtPnJlZ19zaXplKTsN
Cj4gPg0KPiA+IC0gICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKCZzLT5pb21lbV9jb250
YWluZXIsIDB4MCwNCj4gJnMtPmlvbWVtKTsNCj4gPiArICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1
YnJlZ2lvbigmcy0+aW9tZW1fY29udGFpbmVyLA0KPiBhaWMtPnJlZ19vZmZzZXQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmlvbWVtKTsNCj4gPg0KPiA+ICAgICAg
IHFkZXZfaW5pdF9ncGlvX2luKGRldiwgYXNwZWVkX2ludGNfc2V0X2lycSwgYWljLT5udW1faW50
cyk7DQo+ID4NCj4gPiBAQCAtMzUyLDcgKzM1OSw4IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF8yNzAw
X2ludGNfY2xhc3NfaW5pdChPYmplY3RDbGFzcw0KPiAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+ID4g
ICAgICAgYWljLT5udW1fbGluZXMgPSAzMjsNCj4gPiAgICAgICBhaWMtPm51bV9pbnRzID0gOTsN
Cj4gPiAgICAgICBhaWMtPm1lbV9zaXplID0gMHg0MDAwOw0KPiA+IC0gICAgYWljLT5yZWdfc2l6
ZSA9IDB4MjAwMDsNCj4gPiArICAgIGFpYy0+cmVnX3NpemUgPSAweDgwODsNCj4gPiArICAgIGFp
Yy0+cmVnX29mZnNldCA9IDB4MTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0
IFR5cGVJbmZvIGFzcGVlZF8yNzAwX2ludGNfaW5mbyA9IHsNCg0K

