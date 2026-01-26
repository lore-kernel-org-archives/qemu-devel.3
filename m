Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE355C88E79
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIZI-0008UX-95; Mon, 26 Jan 2026 04:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vkIZ0-0008SW-39; Mon, 26 Jan 2026 04:07:14 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vkIYy-0002xm-G0; Mon, 26 Jan 2026 04:07:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQs3uisK8Tpkzk+vCWc32sHjRqhO4luZDtKTd0CcB4mRxOp1XDGMWDfbaH2o9/3SznKb53LVTXEc1tv1h+gOyjAL59najy9z4Y7L0kflYmuNf4OFn1D0LIf4Q0cIhDZ25ABPndcmX0OcFdMQy1l5HC6fhv9uuTYeG4VIR2BkG8lkckFVSqfSJenxV2W/1AW9kQoJc+yymJBpw3Xr3Rsy7WWYNP8F/pUPPIa3sm7I6voE9ZnJnwbsjYqJdg60TOJytHYA3svn8lRi0g7D27ZZekG7Zz+USoYUz5ltv8ET7EvUlVEQBEyYuvwut4tb2lnGmozOivwDNa/AY/Lok3rnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg8bK4VkByJMLZF1FGvQd8mU7WgRZWv7gkO0W6RdEQ8=;
 b=HUxAU439PPGigubYATouSiv+aobo7abea2M3nJQqh088wrgmmS8aYFW8q6aLrkr4ATF6kz/+b7AE/O8tJihRNWaJLe76XPqEzTXzVi31dlz+xkx9oqjsw1QhkuqwXqBiwoOD2o5K/d39mIaUIl/8rL1M93l757f2as1wPgojEvZ6cunCxxY0Psp0Ob1aNQHmTXuQ6JS+ONWObzi5w/6dg6UwyWRZdmrDYfjTCec6sNbRalUsvnn/Nr0227spuZSoOZE2hLOqGVCUvwML3Rcv9y1GGGf1lM7EoALDVB/ERNwkfkuehoWN3gZuW+e7LCiFOpWYWtnGUFrOdElgl855Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg8bK4VkByJMLZF1FGvQd8mU7WgRZWv7gkO0W6RdEQ8=;
 b=UgF6OwmVbotaX64u6NJl/Ox2weWFecnH19Z9FOBkXPy+PI0tftP/yDheoAIbjeDd7EOhUydP9neO/ov9wDTQUpOsOeKwaFQ6yvWA1QwiNDd3OIWPLJ2UQNaalt2LRUGdSqx/HAUSAjE8J7QBhYGdgZ2CJn9YxGGndnJV9bpxgCVKhtB83G380xnRnO5dtdM7sV1c//e6rfUxnMn3C/zs/uYwv4tQgUqSSuBqBmNrkyFduGY8iMEivBpYLhhSizkC8ADvhQwwWkHdFAhjkaxKYUhdMUPFYc1Ep1lv998bzd3brMPrhGO55M9uONyJgJ4XQw7IuCDnfNcIKPnVDuksCw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6686.apcprd06.prod.outlook.com (2603:1096:820:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 09:07:05 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:07:05 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 14/22] hw/arm/aspeed: Introduce 'bus-label' property
 for AST1700 SoC
Thread-Topic: [PATCH v5 14/22] hw/arm/aspeed: Introduce 'bus-label' property
 for AST1700 SoC
Thread-Index: AQHcicxTPzUUIbANYEylJUcJ7H0+6rVkLGiAgAAFoOA=
Date: Mon, 26 Jan 2026 09:07:05 +0000
Message-ID: <SI6PR06MB76318DF66E6A76180795AA4DF793A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <20260120051859.1920565-15-kane_chen@aspeedtech.com>
 <a6095cbd-0c66-4cf3-8e89-a72ae13b67cd@kaod.org>
In-Reply-To: <a6095cbd-0c66-4cf3-8e89-a72ae13b67cd@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6686:EE_
x-ms-office365-filtering-correlation-id: c915fae3-8da3-4f6c-3dd5-08de5cba46ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cUtBVnNDV1UrY3BZU3hHMHdpYm9mT3RLR0tkWEtRWE9OL0VtcEhnNDZCUmUr?=
 =?utf-8?B?MS9RVzRpK25LZEJ1cUlBamIwbTJCaDREZ2w0Y2g2d3BVS2Q5endsaDlMU1Q5?=
 =?utf-8?B?Y2tTTHNQL1p4RnFyWEtGUmRqQ2REUEozSUxPdHphMXI1V1V2Q0xUTFNZbUQ1?=
 =?utf-8?B?cjlLU0JHK3ZicHFXam9IS29UUVdmL0ExNTFLSVJ6OVYrTkMwelJvUk16RUJu?=
 =?utf-8?B?OEkrTThBanJCRklMMmNFVm9TS2FOTmxBcFVmRCthL1JzczRKOTZJa1ZqdjRS?=
 =?utf-8?B?L1BGY2lFR2o3T0ZoMzFzUS9jWlhKWjIwaEFrRC9hbElXcjNWUS9IeXdCUjZW?=
 =?utf-8?B?VE5SdzNORHhwd1I5b0doUldzTzFkRmM4TUQyUzJ2M1huVzZtUlQwNU44NzlE?=
 =?utf-8?B?ckxVL1daT1RMR1JHQldjekhyZ1BxdXZiV3BUTGJ5Ui9KK3gzdGdWMXlmaC8v?=
 =?utf-8?B?ZkJOeENlUGQyOExMNEpTbWJZVWRzOWwzWnVQQWxCSWI4b2Y3Z2p3aHpsZy92?=
 =?utf-8?B?emlvSWY4eXpvOEwxRTZMc0xPamJJdEdFYitjVkRVd3U0M0V4L0tpWUY0NlZG?=
 =?utf-8?B?U1dxV1AwZ2tUVkVBVmUzQnhENHp6OTJaQ3JpOWV4ODJFL3p3RCtkNnRQVkVD?=
 =?utf-8?B?T3NodnhxMmtzaGRtd0Y3UHRwUmRIZ293SExJSFJuZ09QY04wNFhBTytuL0Jz?=
 =?utf-8?B?MjZ0OTJQbzIxNldESVU5ejg0Und6cFViRjF1VFhIbGtvZXp5NHRMOU52ZElq?=
 =?utf-8?B?NHBWRzBjMjNkTHBGbHpsMXVoaTNSUGpJbGJUTERQZnI3WXZNMFVEUUhPUUVP?=
 =?utf-8?B?UWVzYUZGZEZrU2hHeGYyanBjN2s4dHB1L3BFYWxGYlRrWXJSTWpnYlcrTkNs?=
 =?utf-8?B?ZnBFM1N3VWZBWkEvTjdjT05EWWw2cGJFNlZzNWdKUkoraklIWEdFemcxK3dy?=
 =?utf-8?B?bWU0bXBkNmU2MGlOV2pheTA4ZUlmeGZTaFE1RjRCaTFzN01GVFVJekxaTVBv?=
 =?utf-8?B?ZlRJZkNWMGFmeURFaTdtUVM4bFJpd21NcUdBWUpQRlJIOGlpbTZ1K1A3Tm5H?=
 =?utf-8?B?SU1qYzM1ejVYYVpBb3BxNDNPeGRmYTVzVlFhZGNSVExndVFpRkp2UDdRUzR0?=
 =?utf-8?B?UU5BQ3ZjVTI4OTk5bTZzVDlRT2ZWbjdieE04YUdRUDFHTHQ2ZnR1b01EYWdK?=
 =?utf-8?B?ay9kN1JaWnQrcEZ5TVdwcitHMTFjbXVaM0FwRHZFYlhwZ3YvVlMzYWxqdm1o?=
 =?utf-8?B?SGNmTEFUalZ3MHV2dlVzOXZtYWNzM1RrY2ZCUmEwbEJ3K01TTy93QUovK1Zp?=
 =?utf-8?B?dDUwTWxmS1RibXBCUkxWRUl1YkZxcVFXeDB6VmNtVE52QS9sWGkvOVlsangz?=
 =?utf-8?B?a2ZXT1l1RGNWZUVGaFd3d3VuOHVjVUZYTFB3dmpYWDFQNWdrYzQ5WVdieEpH?=
 =?utf-8?B?aUxRZEFaTTAyK0czOUE1WDdyVWlpeWZ3Y2pqNnlJMlRHTHNZSDI3YmZLVUVY?=
 =?utf-8?B?QXlEZzB4MWt6SW1LaXJoV3dueG1mVndQUlFQZStsS25ic0lEQytibnRTbFhh?=
 =?utf-8?B?T2IzWHpoTUNabE5ZbmxvanY0UUlSbHp3ckUzUHJNdVBHN3JBWDJsbkFsQzM0?=
 =?utf-8?B?Rmh2STUwNUpDdC9jYjd5QnkxUGdIYU9LZnhDQk53b3U3SVdLckhFUHpzVEht?=
 =?utf-8?B?T2JKRmNTaVNiV0trNEVEVHcrb1lvZUVYZXJSSGJnOE5NcHlMUVFVQkVWeVZ1?=
 =?utf-8?B?WGx2ODhRQXozWjIrK2J3WVJLeEpGTlE2MUpLMnlBTnhNbHg3eGpyVktBOU8v?=
 =?utf-8?B?TWFoMzhEaTZkTWs2UWNwMnhWVFcxTVdLSnhVY2l3cnRycEtRSTdLUnhxQ2Uw?=
 =?utf-8?B?ZE0ySFFnMkpWU0dCdlA0TUZMampPaWo2L3NNS21hQXYzRnR6Ly9hWUJrVUpq?=
 =?utf-8?B?YW9YZWNTWUxYWWNCUkZ1R2EyQkRESzBvWFdiRUhFdzlyYUtDWVRiQVU4NWZB?=
 =?utf-8?B?VGxrUFpCQVdKREhVdzRXdTZ0aDFXbWl1Ry9waEdyN0F5ZjJiOXA4UjhwTHJ3?=
 =?utf-8?B?RUZMU3BLb25hUkczQTI2RW9laFZORG1wNjBBT1dXRFFZMytMVVVYWTZKQkNo?=
 =?utf-8?B?VldEMmxtQkRqb2NTenhPT2Q3bGF2aUhQbHVXUXJ6L3ZFemxFVndsZGkya0FS?=
 =?utf-8?Q?q2uIfjy1jVnKVjVyMina4M4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEFwelNYQjJhdWZ3cE15S2JZSGgzeE84Yk1GYkZLWnpDdElzUjBJdWNHVnFN?=
 =?utf-8?B?UGRoUUF6bUQ5S0pJVFF2M0VWbUF1OWhFYjlXbU5ZcVJXd0VCNjZ1ZG5qZ2ZO?=
 =?utf-8?B?eTJ6cVA3eWpVbzJ0UTVGcVBVSFplS3FzMEhnTWpBVGRSYStpUXZGVmhpYUh0?=
 =?utf-8?B?WTk0WnFHRDVzeFFKRll2em15QXJIUWZKZ3Z1NEtxL2htS2JSM1FzU09rbzlp?=
 =?utf-8?B?QVIvdW1lQ2hpY3k3bHlTV21jZU1KMFl5RWdNRjcwV1M1V0piSjAvZkhFRGJa?=
 =?utf-8?B?UTdXeVZMeEd5VDZCeUJqK01odytrR2RCNzlmWnZMV1pnK1V3K3Byc3F1V0g4?=
 =?utf-8?B?NDNWYjFBbjVlaFVXdmg2ckNxbXltWlJCanpLa1hMakRpUVpVdEhZbmJ3Y2ND?=
 =?utf-8?B?V0kyYTVyK3lGdnhzS05aVlJhTVdNT0tVWlhabDNmK254elQ2QStzL3NKR0h3?=
 =?utf-8?B?L3dpdnhBNEluT1MzQnZ4TFRMc0ZvOEVIRGJCUVN3ZjFTQWNqQ2dHS2tBYTVC?=
 =?utf-8?B?S3pZc2JURVk2NXhWREQyaU5LMnRZcEJ6d3hMbzR4c2FtSWFxSlZJYU5zbWx4?=
 =?utf-8?B?a3NyWHh4ZGZOZnh4UDcxRU81YUpkd3AyRHk2Zk9hcFk1QmxMWVRYT0hkS2Jm?=
 =?utf-8?B?dlU1OGs0MFhQV1VFc1VUY2YwNldpRXJxZ0IxQ05YK29aRjVTN0VsUGtqVmJy?=
 =?utf-8?B?WjFxSEZRL3Z3QTFmY3ZzcDI4WGVKcU5xdXYyVDhLZlBMUkZkSmMzdXJMbFkx?=
 =?utf-8?B?bEQvdU1rekxmU2J1RE5STmlmQXlTN1VlS3MxL2RnbzJuQ3p3REIyMmxKcUZO?=
 =?utf-8?B?Unk0a0k4YXF1d2p0L09JMm5td0lJWjFUWkIzSTFtMDFGcjRiNDFiVEsrZlNO?=
 =?utf-8?B?eHgwV1J4bTl3WjNTQVlMQ2tXTXEreFlUY3hYUHFPYWF0ZlVZREhrNjdmZUZB?=
 =?utf-8?B?SElSVHUzVVF5ODB0MmJBMldlUUROd2J2bTZXVXFwcS9aekxPY1VoUXpNTWxS?=
 =?utf-8?B?aFhrcjFIYVFGWUFvdVdVbnc3T0RraEFIanEzSUdPL1JxeHEybHRwbEs4L2dE?=
 =?utf-8?B?K2I3SVJxd2dkRis0bUsvOGI1dFVIME9zNElKbjYyRnAyWmZjcU1MVTJZRGwr?=
 =?utf-8?B?eWhLRDEycTNoZTlPbkFZL0tSMlB0dW5jRFZ0ZGdiR0h6VHA0cFEyYXJtaFNk?=
 =?utf-8?B?VEdVTytZeWo4MHdwdkVNa2EvUzJIaGRadzlxdmdDS3FkNXlIczl6Y2lLbjR6?=
 =?utf-8?B?bmhwRU5UeW1nL0hNQ3NqTVI4aXBWa2lhRWVjV3cwSTZjOXlQTDM3cFZYT2Ns?=
 =?utf-8?B?NnhuOEdUZGpHQVdRd1ZhTFJYT3BvTUsvczFmQTd3Wk5iUzhTVFcxNU5KVDcr?=
 =?utf-8?B?Y2MybndNTExTR1VkQUpJalRsd3pVTnVuengvL2U3dWtUM0JKM01pZnJaZU9x?=
 =?utf-8?B?cUN0cE1tMU9QUjhPSEFUVllhV245MVR6RzJmdEJHVnliQXBrdTBMdDFreVdz?=
 =?utf-8?B?a2VhN1cwNUJFSG45TVJLYWF0OTNYenluOVBJM2NZcGM2VG95SkJZTnRhUUo3?=
 =?utf-8?B?RDhnY2lGaCtlRVkrcTdTdUI5Tk5JeFhoRm14T2I3em1OeU82a3hjNmxjU2pM?=
 =?utf-8?B?T0hrRitnVnRoN0NyZ2EraGpVeXI0MU1OUFJXUHUvUko3Wm1VTTFqVUJFMlkx?=
 =?utf-8?B?RmZnR3ZSd3kyaUZEWTBXQldBSU1SU0YyUXdRVXBvNERhQ0c1RGgwUEl2ZHh4?=
 =?utf-8?B?YlluMmdIb1R0VDdCWVZHVGVnSVEwNEFHN2lrU2RKc1ByZ3RzaUdmVEl6b3Q1?=
 =?utf-8?B?UUtVaHhHOW5sY2xlWC9GdWFsNjNSZ1IwQUk1cmlYSlllZEp0NUM5WG9GbDdz?=
 =?utf-8?B?L2haR3dzOUVnY1ZDQ096VDVLaFA2MWZDalhEMUtBZFlMcSt1a3RWYjFQTU9S?=
 =?utf-8?B?Y1BLZ25aa1hTN3hwN2FqMlIwMnRIWEkzR1dQd3VJZjUzajN4b01iK3NDSDd5?=
 =?utf-8?B?NEdQaWpzTHZPSEZRa3NWSFpqdTdiNjk5N25tNWszSHBwU25FNzI5Y1hML0Q4?=
 =?utf-8?B?Vm01RE9XTmlTdFZid0xYNStUMFR6ZTR2KzdmQ1gzL3l5cHVzRWdJajlXUThM?=
 =?utf-8?B?cFJsSGZMQzY5enp3WEd3NmlDbVJ3ODl5WXdhbUc3S3JiZ0FPVklMZm5WSDE5?=
 =?utf-8?B?SVQ1aVRjTTZ2SzdQY1lkazdBWDdqR1ZqRUo2RzRLd1RkN2tPQlN2N3dEcHht?=
 =?utf-8?B?NjZkYkRqR0ovc3R4ZkNJM01qSWRLQVdmNlJzNk9rcDNIdXRJbWFmRG91dTNR?=
 =?utf-8?B?TGVENlVncm5KUnZIU0I1L0d0NmhuczJTNktzL2VaMnRKU0lWblBsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c915fae3-8da3-4f6c-3dd5-08de5cba46ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 09:07:05.2975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMMKgMYl7lUB3P/Aky1MlFUY5S+Unpv6Y9dnRbDBbRKInLw+aO5YnQYKyunK6+yjAqZIQoV0WT9nBDwX2wu5zIXdjPPkbniieFjUZpblnZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6686
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjYsIDIwMjYgNDo0NSBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFz
cGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwg
cGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTQv
MjJdIGh3L2FybS9hc3BlZWQ6IEludHJvZHVjZSAnYnVzLWxhYmVsJyBwcm9wZXJ0eQ0KPiBmb3Ig
QVNUMTcwMCBTb0MNCj4gDQo+IE9uIDEvMjAvMjYgMDY6MTgsIEthbmUgQ2hlbiB2aWEgd3JvdGU6
DQo+ID4gRnJvbTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4N
Cj4gPiBUaGUgQVNUMjcwMCBTb0MgY2FuIGJlIGludGVncmF0ZWQgd2l0aCBtdWx0aXBsZSBBU1Qx
NzAwIElPIGV4cGFuZGVycy4NCj4gPiBXaXRob3V0IHVuaXF1ZSBpZGVudGlmaWVycywgdGhlIEky
QyBidXMgb2JqZWN0IG5hbWVzIGZvciB0aGUgcHJpbWFyeQ0KPiA+IEJNQyBTb0MgYW5kIG11bHRp
cGxlIGV4cGFuZGVyIGNoaXBzIG1heSBjb2xsaWRlIGluIHRoZSBRT00gKFFFTVUNCj4gPiBPYmpl
Y3QgTW9kZWwpIHRyZWUuDQo+ID4NCj4gPiBUbyByZXNvbHZlIHRoaXMsIGludHJvZHVjZSBhIGJ1
cy1sYWJlbCBwcm9wZXJ0eSB0byB0aGUgQVNUMTcwMCBTb0MuDQo+ID4gVGhpcyBhbGxvd3MgdGhl
IHBhcmVudCBTb0MgKEFTVDI3MDApIHRvIGFzc2lnbiBhIHVuaXF1ZSBwcmVmaXggKGUuZy4sDQo+
ID4gImlvZXhwMCIsICJpb2V4cDEiKSB0byBlYWNoIEFTVDE3MDAgaW5zdGFuY2UuIFRoZXNlIGxh
YmVscyBlbnN1cmUgdGhhdA0KPiA+IHRoZSBidXMgbmFtaW5nIGhpZXJhcmNoeSByZW1haW5zIGRp
c3RpbmN0IGFuZCB0cmFjZWFibGUgYWNyb3NzDQo+ID4gZGlmZmVyZW50IGV4cGFuZGVycy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2gu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCB8IDEg
Kw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDEgKw0KPiA+ICAgaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICB8IDMgKysrDQo+ID4gICAzIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiBJIGRvbid0IHRoaW5rIHRoaXMgY2hhbmdlIGlzIG5lZWRl
ZC4NCj4gDQo+IFNldHRpbmcgdGhlIEFzcGVlZEkyQ1N0YXRlICJidXMtbGFiZWwiIHByb3BlcnR5
IGluIGFzcGVlZF9hc3QxNzAwX3JlYWxpemUoKQ0KPiBzaG91bGQgYmUgc3VmZmljaWVudC4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMsDQoNClVuZGVyc3Rvb2QuIEkgd2ls
bCBkcm9wIHRoaXMgY2hhbmdlIGluIHRoZSBuZXh0IHBhdGNoIHNlcmllcy4NClRoYW5rcy4NCg0K
QmVzdCBSZWdhcmRzLA0KS2FuZQ0K

