Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CA5D74EF7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIq2-0006Fc-UR; Mon, 26 Jan 2026 04:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vkIph-000634-Fo; Mon, 26 Jan 2026 04:24:29 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vkIpf-000675-0z; Mon, 26 Jan 2026 04:24:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJobapo68GL+LEi3vJiTFqLKITfWCTyaxV8t+NKT5wmLzZnq/8aGqBSeSNU6Hpx5kKt7ENiXHFRDCsaERwqhRbUu96budEo4mXoK7yrjKIa+ne2mkztTGTz8ZqZfU2Pk+3nr3wm12HbwyzsooJht2/Y2Y2hgjtO3z3hds6SNdpg6lU/KT9jvlckcJ17VTt8EG+sdyMcWI3Kg48sFwy7wI+fnDavJw4wMBOpa3PSp2t6ciu1KxMl5YN79KTWRWt/K4vkC1qgNVPn8K0cB/QE3LAqcq9R7Qy1DYMFZsZHRt9oEjw9sJqWvYW4VxC3zA0XrJNmCjk3lzcxJUg3aTW+UMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sMoM8+B/aEEp5KNR+VZMu8e/dEEeOlLq3cNo4HCRTQ=;
 b=zOW6HZ8rniFxjgi93URapteIVbzj+D94mWZ1SRrQ6jV4fnO4VoMbxEgjYRkVf8KNAstSaVr3zx02tf1jZAWs2Qy2adNrjfB6MrWboNYvxMJf1VW/UFEkI9aCdQ6l+SA9iLdMlMrIalQ6ODO7gqmmMw6k4T8Dpv5Tg/QdH10eFVGscJqeI+vTkePHgUesI25mHZQEozcQZ855ORjxhUWrcj1e8TnfWX4cGgWZmopbSvdV1tosq+BQVbKhh16pHV1GPxw0G7gidimvhyPIXYTjKsQmQP0wH8Eu5MA9n1WMWFyqMkMvx8zzzRGY80/L7SC/IHKVcgGr28kf9JlI5DKOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sMoM8+B/aEEp5KNR+VZMu8e/dEEeOlLq3cNo4HCRTQ=;
 b=eswPY9I73DeRSibSlwryrysgZG3jo6e9xuKsMn61IkAd9jkM2t3gd/0dZ3V4pDSNOu1/I5v8znVRmevpQ1/Iot2+hLlUq0thMHYG3XpYjrQBgN125AKZJdeEian4tWybtFwA1ojtRTqg4gSEuehOTLkxu75WC+AolPA2Up5BDCrqXYp78lXqt2VeEaVam6qtjQDk/m4MDYLgjztj7SwOqnqjT02Xek4zFZqMKd7h0msOA4D3NO+Hm9OqaTyLY6lmA3T1xNPgGUoJm2heas+P8CNpzaZ5v6Yv0WwhcMRdsLtmupxDCi9KfdHYaPegEvMfyBwCS1kxjIVgWR4qDa8YmQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB5806.apcprd06.prod.outlook.com (2603:1096:400:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 09:24:18 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:24:18 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 03/22] hw/misc: Add basic Aspeed PWM model
Thread-Topic: [PATCH v5 03/22] hw/misc: Add basic Aspeed PWM model
Thread-Index: AQHcicxNoHlfMIGUBUupvVqX/LHtlrVkL+mAgAADQdA=
Date: Mon, 26 Jan 2026 09:24:18 +0000
Message-ID: <SI6PR06MB76314CF8F22CA3D393B306D3F793A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <20260120051859.1920565-4-kane_chen@aspeedtech.com>
 <00403858-d7c8-4d90-9c95-90395691a790@kaod.org>
In-Reply-To: <00403858-d7c8-4d90-9c95-90395691a790@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB5806:EE_
x-ms-office365-filtering-correlation-id: 9d12b646-7a4e-428c-50dc-08de5cbcae70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q2cvQm02NDJxOGtHeldDYmxybW96V2srUm9VWmsrU3VXQWt0cE5VTUtCbVhi?=
 =?utf-8?B?RXlNVzg5aUF6ZEZkV0Jiam0xdFpub2pyMUgydXV0OUV4b2NWb2lMeGk4cHh4?=
 =?utf-8?B?THE3cGtKb3RxZWVsZVk5MnVUaTc2ZUdnbm1STDBOdTJVaHVITjcwc1RYbG5R?=
 =?utf-8?B?dnI2K1NRZFdTb2NqeU1PUlErcXE1Tm5qRkxuOHczdWV0RWs2Ym1CUEhPckdB?=
 =?utf-8?B?WkdGSmxrQUdGRDA3KzJyUW43aEhJWERyMDlZajhpLzhueHk0WXVlQjA2L3JI?=
 =?utf-8?B?SU1Ea0VkV0Z6VkQ2ZHZkRUxDL1FieHg4N3FNUDVQc1MxMk5ZZmJhOWFmczFk?=
 =?utf-8?B?SVlVVFQ5V3RTdjJEUjBHRDd1NGNWZXVqbG1CWnJTUUUwM2g5MFJOemQ4cTFv?=
 =?utf-8?B?NDhkYWw1eEZCM0V3Z0xXVFlyUjV4eklPd1YzMll6UFVUbmJ1TlE1VVFkc3NO?=
 =?utf-8?B?NzlvdlVpSjRabTc1Rm1HQk1VVy9tS2NwSE9qRTNWa3hVY2hzVStOWnR4YmEz?=
 =?utf-8?B?OTA4TjhBTUcrMlQ1WGpYVDF6ZTFqOVhXR0tpQWZxQncwcy9SWFI4MDJWaGhY?=
 =?utf-8?B?V3NmSHlzWnVpaS9KemdNSlpsRGZVRU5mUkZBZWptZEMyOVk1aVIwY2x6eGVi?=
 =?utf-8?B?ZjJKYkQ4MDM4eEpKTEEvR2JzOXJiYzZYVUZiRjh0U09OSG5WSHVHdW51bEEr?=
 =?utf-8?B?VzFYMVR5eU9jd0ljeGFoZmh4VjdCSUlJRDNkSWQ4V3AwNit5Z0Qya3k0QUhj?=
 =?utf-8?B?VmYwelZyN2l0c1NFanZqSE5jR1pLSXdwTG1jU3E4TUx3MTA5bE1EQUZ4b1Jw?=
 =?utf-8?B?dmJycTNpQmdOUXdXU01YUXdvOUlvTTM3OTlBaUtVM3diM3lDUkhIRWQydnE1?=
 =?utf-8?B?Qk5kbFdrbHA2RVo5Rk5OMUNTNC91b3RKRHJZQmp3R2RKVFZYVmU5bG9EVFkw?=
 =?utf-8?B?UGRjM1hFV0gxNXhHeUVRcnozRk5lRTJGamc1L3M0dWZMOEUyaUxpYitZNEhy?=
 =?utf-8?B?YkVacm5XTzJwRGgveG4xczdNMEdpYVhIbGM5NVo5WlczMmVqcndzSGVNR3V1?=
 =?utf-8?B?QmtkcmplcnBjNzlOb0l4VGlZaFpubU5hbDhOV2VqOE5DRG8rOHo3NzJDaVhn?=
 =?utf-8?B?QVZFVnR0V1JmeDVBd1A3VVJaRlJzYU5sNmlsa1ZMWGtlVisvQWxzRkcvamM1?=
 =?utf-8?B?dWhCdldzT3hMVW5nV08yajFTM01tOGIyMy9SM2lhbm81QVFZVWtCSFEyVnVy?=
 =?utf-8?B?UEY3YXR3RkJoWUxocjFTenMrd2Z0WW43RWt1L0RrMTFyWTBXUE9uMytiTXB6?=
 =?utf-8?B?cnEwTUxnNnZzUENOWVBwZlU1NEd5WktOaUpKMElFQkVkMUxrdVdHMUJSOGtq?=
 =?utf-8?B?OGN2NjN6cVdRWXVPVmd5eWtHZ1ZWSE9XVW1Ka3o5QTUwTFBYcGQzN1g5QXpM?=
 =?utf-8?B?L0QyeG40Q09LN1dGZU9RUy96VDEwR3A1MHRERU9iT2w4M2pySUcwUzlxdzRG?=
 =?utf-8?B?VFJqMlNWOW9WYmZVNis5cXFkd01Jd09wbXF4M2hXa0tDZWpLeS9KS0FOb244?=
 =?utf-8?B?S3JZRXVKTXVybE5waXhSellkdTVQazFRQU5xdTM5SW94ZERqSmVhdkNpR2dW?=
 =?utf-8?B?WlFBRWFKUnZiZ1FpUVhVWXB5UEprNDJMY3grRVBoOWE1aDZLYmI2SkYzTHhU?=
 =?utf-8?B?czBSdG5tdWFRYUNrK1BrL0RPVnRGc3ZzUUhUMHl5Rk14cVNwWXZJVVRTQnJW?=
 =?utf-8?B?ckxobnFmNWdGaHpJR28waXJYWEsyZll5TzBKWEVvbStwSkdKRklKeWJJWjM4?=
 =?utf-8?B?WlpoWE9GTzJYbHAvZ055WUZYMXkxbnV6S1ZoZVcyYi96R0hUUS9Db0oxNlB6?=
 =?utf-8?B?UkRyOHgrVEdFNDQxSWJ2a3BkYUkrRisrZ2tENHpSOExiYWJwaC9hSlJPTkdF?=
 =?utf-8?B?bGMzOGZUaTVJV0RpSDZNT3FvY2pseGRUOWtLVXhoc3F4QnJNSGZ6WTdPN292?=
 =?utf-8?B?MVR5OTBVZTBuU0VSMVE0YkduUnEvbCsvc1J0T2xMaUpXSmc3NmJvZG9aZEEy?=
 =?utf-8?B?ZmJQTW91cURxNWZtM0J5a1RCMW4wb040bFhBeFFmODNGalVtYVg0aEtIS1kv?=
 =?utf-8?B?K3NSa0pWdHp4R0NvaGZZSWFqbXQzSWlKTzVzVXhpSW1vd2xBU2dITGorR1VC?=
 =?utf-8?Q?3tJ88z7OZOXDABeo0ElL0s8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVBUWWZpWEplODZKWEFraXpPOW1HdDdtOW0zY1d2eGtrVXVnYmppRyt3RkVC?=
 =?utf-8?B?R2JzOEdQWFZTcE9hRDRacCthT0hIZEZnV0dPdFFjVEJkVmRvcG1oQU5peEJP?=
 =?utf-8?B?VGIrNUtGN05GU2tTclRmVHNhOEdpZU1oQzZxcVFIdmR5a1pmVnF3Um0ydlY0?=
 =?utf-8?B?RnVDQXJJWW5lRVFVd3ZwQnZPcXpaSzVZVjcybU53aERob05GdWJteGRYdDQ3?=
 =?utf-8?B?RnU4dDhmdFcyZzhBYndzS2tBQ05kRlhyUWozalpDSnBIanBIN2xqNFg1OHMr?=
 =?utf-8?B?eUhIOTZCNXBuTTlJMGdQeW5tMlpwWUZ0Z3B1WFlsaVVKZkZPM2Q4cWVTYnNW?=
 =?utf-8?B?ZWtwakZFdmsweTVUVWRtcmhEN0Q1SHVHNU1GV09lYjVqRnMzZ1NWR1ZHK3J4?=
 =?utf-8?B?SjZQYzhWNVdJTnd4MTIrdXE2cEJ1bk9FazBJMjdZNmV4NVQvNlFaZzNIMGgw?=
 =?utf-8?B?KzB4Qm50bGVOaUc4TFJ0V3NJNHJGK25weGlrT3VsR0RHRHF0anpOZGhOSTZT?=
 =?utf-8?B?RFpzNktEdFBIMEFEeXczb3VuNk1FSzZjWE5wZFgwMUZKbmZrZlY4LzFtTDg3?=
 =?utf-8?B?K2F3L1FXaUdEWWZ4bElnZjdnbkpoUnlpTmdqQTBXV0w3QkJKQzNLQWVIaWtL?=
 =?utf-8?B?Zm11Ri9aUlBLUUFSbTFDVDE0NnJ3QzlMdksrMGpPbVRWSSs5a05TZWZPeGJq?=
 =?utf-8?B?N0dJKzdGcjh2bzRiaDN0RzhTWWdaYlRGV1c3NlRHVk93QWxmTkQzcG80ZGht?=
 =?utf-8?B?L2JwNWZ4VmFpWHFPREhoU2MzdXVsaWxmL2F0S2d3RjM3Rk5QMEV6VHIxcXpT?=
 =?utf-8?B?UEpYQWwzSTIxWVI5Mm9ZQzYxVldJZWtJREFTY2p6bzVKdHdHdnZUNEVwR2tq?=
 =?utf-8?B?aEphNjd2amJieXdienJEVnNjZWhXVzNSa0hkY1RDd0owMlpCRTZvT0twb3NC?=
 =?utf-8?B?WDZjazlNVmg5V1RkUVlVbGdFV2s3Y2sybEQ5T2NGbURaUDg5NnVCREVmYm5O?=
 =?utf-8?B?ZHJxeUEzTmwvSlJDdUZuUHRwM3k4dXdFdSs5NGE4QlpJMkpucnNMWmxKd0FG?=
 =?utf-8?B?b0x3MmJKdGpOb0dTZVJpN2xRSVVuOXB0YzgrTzJXNjArY2JGclJ5N3Nzb3Vp?=
 =?utf-8?B?OHJ2SGYyaWU3OTB2QnhpZmU4ZUxEVWhNeExhakVlSzNlYm5LQzhaaWdXU2pY?=
 =?utf-8?B?ZG9XQXBEcmttTEJDRDVIcUJ3aExmMC96NVV4akdQeEhQWVJqSkpvWlJVejQr?=
 =?utf-8?B?RVdDVzVrTE5rYjlKZGtabDExOVZoOFo4bVV0cXo4OTNRaUZxY29Pd2JBejRn?=
 =?utf-8?B?L2srNlgxdytpSmcxVUh6VWMrcFI2dG1GOWQzelViaFlQUlF0UVVIdktPN0pC?=
 =?utf-8?B?eHFhUUZ3M0NtclFkNCtJWnpHejNPT1pjejA1MDY0STQvcmVCa1MxZHo0Q2k1?=
 =?utf-8?B?R2RtMFRYS3gyTk52WS9XYUJqUnFjaWw0VVpoejBQRVBvVjhFOGZSbWQ1a0Zl?=
 =?utf-8?B?UXlxSG1IbGhqb2ZObDdvaE9JWDhhL2tldzAxTU5TRGh0M0tlZ3JMaHZFVWw5?=
 =?utf-8?B?RTB4Qnc3RU5lUlNmRTZkTGovOExZMTZhckdnZzNXam1IU0hMY1lmRkRqL0FH?=
 =?utf-8?B?a2lheDFyUk5rVUZ3K0QwQllsc3NyYVlrSHhWYnJBSHpjUzlvUHFYWlBTYVNt?=
 =?utf-8?B?Q3BTUTROVC8wUDdoNldZdGEzOVZyYWpNT0NNSTA3WU53L3RzUWpCVjk2NFJn?=
 =?utf-8?B?SU4yOGc2M0UzbGlUSDZYa2N3TnZ5Y0RDT0xNWWxpZzdjTzFzOEJld2dETXlo?=
 =?utf-8?B?Qk5kdUhFMjdrUldXREgwblQ0WHp2T1g4Sng2R1ZiaFpaZWw4VDZvSEkyT29X?=
 =?utf-8?B?OWR4enBRTDlQN2IxQ0pxdkhpVlVDek14YkVHaDhIMnZNa0psMTBaSm5PcE82?=
 =?utf-8?B?WDlGbjlpTUQrRmdOMllTOGNNR1N6RCttWkVtYjNnMVlpeFZJb1hSdzV5Z2hi?=
 =?utf-8?B?TldUcmlseXpXMkIvRTR2Z0c5ZThWRElJUFFUd2tESm8xNGp6c3N0ZytZZUds?=
 =?utf-8?B?Q3N0SnRyWE5ITmltejZkRzRGNXpjUStFVWNPeUdzMTQrTEtiOXFDZitremdI?=
 =?utf-8?B?UFJaUy9GSllLN1E5dU1qOEdtb0V1SVBpbzhaeGpFSFVVV1VheExyTGVkMFlJ?=
 =?utf-8?B?d2doYmcxTjYwY1c3R0ljY0M0NlFRNnVDakJOMjBuTFQ2Zzd4U2E0V3JiSTkz?=
 =?utf-8?B?a1FyWUY1cjk2S0lBWWlucllYQjd3bm9vNUg2SnY2NU9RcndXNk8vNEpRZzl0?=
 =?utf-8?B?Z0U2ZG5nSnprTUFDVDFlaW9uL3B5OFg4SFpMVERXRTlLV1hJR3JwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d12b646-7a4e-428c-50dc-08de5cbcae70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 09:24:18.2768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVwfkTO/EQnIDBWNW/1NK3hLJckFqMxNUtQZySPxoiUZzUJBNmt++Zm5CNtAWgTGBkxNWv0urXDiwXfxAdqnaBqVMNGH1IHfPaoNZtv42/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5806
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjYsIDIwMjYgNDo1NyBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFz
cGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwg
cGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDMv
MjJdIGh3L21pc2M6IEFkZCBiYXNpYyBBc3BlZWQgUFdNIG1vZGVsDQo+IA0KPiBPbiAxLzIwLzI2
IDA2OjE4LCBLYW5lIENoZW4gdmlhIHdyb3RlOg0KPiA+IEZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAa2FvZC5vcmc+DQo+ID4NCj4gPiBBZGQgYW4gaW5pdGlhbCBQV00gbW9kZWwgZm9yIEFz
cGVlZCBTb0NzLCBpbmNsdWRpbmcgZGV2aWNlIHN0YXRlLA0KPiA+IHJlZ2lzdGVyIGRlZmluaXRp
b25zLCBhbmQgYmFzaWMgaW5pdGlhbGl6YXRpb24gYXMgYSBzeXNidXMgZGV2aWNlLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAgfCAgIDMgKy0NCj4gPiAg
IGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfcHdtLmggfCAgMzEgKysrKysrKysrDQo+ID4gICBody9t
aXNjL2FzcGVlZF9wd20uYyAgICAgICAgIHwgMTIxDQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgIHwgICAxICsN
Cj4gPiAgIGh3L21pc2MvdHJhY2UtZXZlbnRzICAgICAgICAgfCAgIDQgKysNCj4gPiAgIDUgZmls
ZXMgY2hhbmdlZCwgMTU5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3B3bS5oDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvbWlzYy9hc3BlZWRfcHdtLmMNCj4gS2FuZSwNCj4gDQo+IFdoZW4geW91
IHJlc2VuZCwgY291bGQgeW91IHBsZWFzZSBmaXggOg0KPiANCj4gICAgRVJST1I6IE5ldyBmaWxl
ICdpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3B3bS5oJyByZXF1aXJlcw0KPiAnU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXInDQo+ICAgIEVSUk9SOiBOZXcgZmlsZSAnaHcvbWlzYy9hc3BlZWRfcHdtLmMn
IHJlcXVpcmVzDQo+ICdTUERYLUxpY2Vuc2UtSWRlbnRpZmllcicNCj4gDQo+IA0KPiBFUlJPUnMg
ZGV0ZWN0ZWQgYnkgLi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIHNob3VsZCBiZSBmaXhlZCBiZWZv
cmUgc2VuZGluZy4NCj4gV0FSTklORyBhcmUgT0suDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
DQpIaSBDw6lkcmljLA0KDQpUaGFua3MgZm9yIHRoZSBjYXRjaC4gSSBtaXNzZWQgdGhlIFNQRFgg
ZXJyb3JzIGJlY2F1c2UgSSB3YXMgcnVubmluZyBjaGVja3BhdGNoLnBsIC1mDQpvbiB0aGUgc291
cmNlIGZpbGVzIGluc3RlYWQgb2YgdGhlIGdlbmVyYXRlZCBwYXRjaGVzLiBJIHdpbGwgZml4IHRo
ZXNlIGVycm9ycyBpbiB0aGUgbmV4dA0KdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

