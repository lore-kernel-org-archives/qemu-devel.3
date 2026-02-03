Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD122E6E7E6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDZt-0001Rj-Dd; Tue, 03 Feb 2026 05:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnDZr-0001Qu-4R; Tue, 03 Feb 2026 05:24:11 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnDZp-0008Nq-4N; Tue, 03 Feb 2026 05:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPpKNUy7dqQPbXW3Yk11fFGWL4Urxm9YfhW8rCra9NdZzF2NF8K1h3HcXEPIA5FTC7wWVSMweshXTSo7zDVKW9h9hF0BghxF60AbhK9KxyhdjDhGjDj/1sZy0MAJDGahlJJQlBzgqcv3CHVDgz932kw8fC7ljzospmhOc1jRcDaM0HrQ4W6V6ZtaF2h2YCiFQwmfAf4EXoRgeyo7oXYow1cdeV/iqSIv0eugYR/kqF8v0db8976izt2d1aaiDNYqdv5hV8rwcj19rIQZ9jdadBPpXdXPdRgm+s66ZnqIsv+yftd60uEPw3Jp6a6tc8jReNCRCU/smvrf+0kF6/rqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyhiFRbJCMhwV+3By3xBishISwF4tWpCT5IxGA3/CqA=;
 b=CmxHhIMo3HIHdA7lKIeH28nEp3WPE/C+8OFevO4qCFcVl6AVoKUHJawGG8jMADj9aiHh2BVPKwcT2NxTi3n0RIXvhUjtadJog9+jCCg4GWhHY7ZR+IZGukQpCUA3v9mYErBns9B4LPon0+zyLleoQXDzSQhJTgJIGTJOm63W+a3Vj6X/pFG/m1y+SLdwmYZ/qsJXt/lGFnamnMyflbs5RYecGkzNCnib3SEpLoJFMBhCae5jzMN9H78zTzCwdkfvLYAuLwT/DSl21qYgun4Kk+9dOGfFcURx+4orxkvjmaqx9eHPuKj686F5b+M1Bqmr39SDsMQKvJJINsRzdnFJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyhiFRbJCMhwV+3By3xBishISwF4tWpCT5IxGA3/CqA=;
 b=hjpEKtHbPBjKOTN6x3fJZpo6rojjttXOrvB9AvNGdMcBeIW0wIIvPFWKR11AeHfpuVzVlMdWil15ESqndOVW6c3t6Dvw8fO26mvUJnX4fk+lk3oNJxKP8wFjLhljQ3aVdAX2PbCH2Vwkl6LyHmutYCVYQlN7FpjkvUrKqsaKlg5w2CqToLfpDswtXpX6odn1yJexL/79wLvutzpRbeeIeGQ8FSGTvFmdzHK3K7IupM0rpSP8EeyB8JVcP+W+ITqbvDYTXkXsPMU6T//CrtZlVkGDv3f1qA+li42zdFD4PPzoUxZU+jLvsyGCnFyyfP/byMZKBMLLxER+Wfb7GhkXAg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SG2PR06MB5057.apcprd06.prod.outlook.com (2603:1096:4:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:23:58 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:23:58 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Topic: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHcie9SKTdPnCSFkUWsdzq93BR4GrVkMO6AgAFQ/ACAABFPgIAAPRoAgAk8RICAAC2PAIAAAIaggAAUegCAAYlqsA==
Date: Tue, 3 Feb 2026 10:23:58 +0000
Message-ID: <SI6PR06MB76316284692DF29B079A22FDF79BA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
 <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
 <TYPPR06MB8206FD6566DFDE3BA513FBFDFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SI6PR06MB763182A3E4BC0C6ADC0555CEF79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <05782501-e775-4065-820e-1b599674f478@kaod.org>
 <SI6PR06MB763184DBA59EA9E61B97C3A5F79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <57fcf2ba-fd8c-4978-af29-18c5dcc7a152@kaod.org>
In-Reply-To: <57fcf2ba-fd8c-4978-af29-18c5dcc7a152@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SG2PR06MB5057:EE_
x-ms-office365-filtering-correlation-id: bdbe6790-a296-41d7-c19b-08de630e57a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N2RFbTJjRlFkU1BNSU5xakFqZW9XNk1Lb0k0QVpIQVhqNDNGMWhaRUNJVXJ5?=
 =?utf-8?B?Y2FkZUF4czJIQzJPR2tJM0NwTm9DOS9BQTEvcWp5QnJQTjBQaVlqOU1MUkc2?=
 =?utf-8?B?L2ZFTnhlRnpnM2lDV3MxV2UyMjBEYk93RW9IQVdhazFVSTFzbUp0bFpOaXRZ?=
 =?utf-8?B?RC92M2xDUU9wZVhyQWJFY1dHNWtMMDAyWUppV0ZzVkxsd2VmQ1NzejZxcjF0?=
 =?utf-8?B?b1M1Q1JtNEhYOEVNL2pVNC9mdFk5YkhGMEZ5OUd3aGpNZ2oyZEhUVU1QRjBY?=
 =?utf-8?B?SzNET1Q5WC8vZFFSQ1Q3VXY1R1VZY1l1R2U0RzArRkZ6eDZYSXZoMnJzYU51?=
 =?utf-8?B?dityS0ozMEgxUytEWWgvZDF1SHk1d1pqTUdXUFU1cGhVTGVEbitsRE43VWVI?=
 =?utf-8?B?UmFmTHVScDJBODBCUmJNNUxtblcxZ0JvUTVnUkswaFpCYUZjMFgrUzAxS1lU?=
 =?utf-8?B?bjBoaXVzdGJtQUVNV1N4ZUpobGo0UmorWUFGbWx2ZGUzRmthTENFVncyU1hW?=
 =?utf-8?B?ZExZQXE5Y3VhaC9wZzlrTGdXdGtNSFhPQXR1VFpReTBRK1ZzUm5PV25Idnpo?=
 =?utf-8?B?dVY4Zi9WbnpJcSsxL1RJUFFDU3NnWFQ3dTRQNm1mbzlVZ2tWVXNkY3dmR0Iy?=
 =?utf-8?B?R0VNQTlsS2xIVGlUc1M1SjZLTE1qT3RhYjZiZUY1RVJEdFBSQVY4a1pJUXlT?=
 =?utf-8?B?dVNVT2tnSGFEOXFnVXBlTjRXeE1NalFBc2d4b1I4bjZNOHArOC9aeWhVYnps?=
 =?utf-8?B?dFVqOFRuVUFsN2Q1c1lsMDAzNnF4aGJVSDFLMjFRVUlqdm1RN094RjBXaHpF?=
 =?utf-8?B?MGMyQm5USGpEZG1ocXlFTlNSTE4xZG9BS0RWOVdrOVlLb1huczZZUDNrdUFR?=
 =?utf-8?B?bllHeUNlMHJ1QWQ4UUlGRnh2bnBmTmZyZ1p5WnVGWkk1TlFZZFJMSHlpOCt5?=
 =?utf-8?B?R3BlR2k3aDBUbEpSTEJBbkFVQklWcmM1b2JZRXpqclBiazFuSThXSmNWcUZi?=
 =?utf-8?B?aHc1ZXdUck12YWErYlIxQUZHMzZUeU8xcHdJaE43Y0NSSkRjZVZXQW80UUhF?=
 =?utf-8?B?VHRSN1ViV3ZWZWZKVm9tMFh2cGNnaFZwVlRpYkVrVHV0RVB4YjY1dnJlc1hi?=
 =?utf-8?B?ZFBDOXFBWnZqRHJvODhLZ3ZoeUlraDAvajZzeXI5WlFEaVBicXQrSzZZeGQ5?=
 =?utf-8?B?L2pLSFo1MU1rcWFkOHErWExDRUV2Ymc0TThSWUw5MklXWjI3cGZ1VlNqTlFU?=
 =?utf-8?B?c3J3eldtTHdVSHRCc21uL3lHNFcwVVZzQ2FkRFlNTkFzS1VzNDh0clV4aWJa?=
 =?utf-8?B?N3B5bFdiTG5oMW5ST24wNkZlNUR2cVZDUmJ1bVZaN0lXSzhJeEdzOE1KcFJk?=
 =?utf-8?B?cFF5QUs5YXkxWHNkc3lUMVJ4VUVwOUtNVXRVNnRGOHZCRnlLa2lWbDNlbHJJ?=
 =?utf-8?B?eXNieHk5L1lqUW1lRlhQWkZ1dSs1eHBMOXhGOGhlOTJZRGtkZ2FFVnNpMjJt?=
 =?utf-8?B?bXMxTDJITjJZS0FDUVc4YitHMnNUM3RIZ3VNd093cTRKaDNHWUVTblQ5SndE?=
 =?utf-8?B?RE1iczdpUWwxK1d1OGtHVUliZ0M5OHZqRlVyVFh5T0QvTHRmZUV5bkZxcDV1?=
 =?utf-8?B?cm5YTFN5QzB6RkFoZlFQZDNublNzMEYyd2VKeWFyN3dLMm9NQXp0K2J6YWgy?=
 =?utf-8?B?UGJnSmV4bnlYYXBqN0dZMlFSNEQwYk13M2pNTDQxZERaMHI0enRxbXFyNkZD?=
 =?utf-8?B?a21yNmNmR05NZjdQeWoyMGt5SmY5ak4xa2pmenEra0dyQ09YWWM3ckREbWlW?=
 =?utf-8?B?eWg0Ymh5R0E2OUdPVXFlUVcybU5vWE1FYzIxUkh0bzRyeUlvcGtpZGhxWE9F?=
 =?utf-8?B?UnFFaU1RY2lKT1E3RC9JcVRON2dwUDdSZ0JQTytWRS9wSkprY205akFtQTZm?=
 =?utf-8?B?ZTZycC9tQ1VYNkRlUnloYkF6UDJYNHpHMGp0RVBwT2dNanlia2czbFVSb1kz?=
 =?utf-8?B?V3Z3MVdvaFlqUWtLTmtKVmZlWlY5YUo3dGhyYXF0TmplZG5wdng1V3NESndv?=
 =?utf-8?B?Y2FxSTBZSWNwMDZEWkxwT0puRXZQSXh0SXo5dkU4dzBlZkl1NStjc3UrQ2FJ?=
 =?utf-8?Q?IrO4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzdMMnR5M0FYcG5LaUtwZ2VFUGd0em8rRDlDZUJDSTR3aWlyeGoxeldxaUFn?=
 =?utf-8?B?T1hIS0ZNZVppRm1aZHpUaDVweGZmZUFNVE9LeTNJb2liajhCWUtGWVl3cTdK?=
 =?utf-8?B?UVN3bE9TbUlmNy9uMGJUWUxKR25hQzVGdFdwTUpjQ2l2dmltVXhya2Vycmg4?=
 =?utf-8?B?SUhqMnhzbVJtanYrRXVxN2hCZ1BKdEVkYW9oUkM1WUxmeGFCemhkc2VyaENa?=
 =?utf-8?B?L1g2TkdVNjJnZk56L3ZpeVBSbDduT3U4bmRyQ3JyUWFiYjZpMllLdUxacXlN?=
 =?utf-8?B?bDI2ZmxGN2x0WDRIbzIrUzZuL1BnM1dDYUlndHNDeWZqTEJWc2VHSVNsVmJw?=
 =?utf-8?B?MFFRTFprOVBsSzdaOVFFUjI0MWRRRlV6RllUWTZPTmFCcjhSODU1VHN4Mm1G?=
 =?utf-8?B?VGFuMkhPWjk2NTVsMGFxU2pWakdiL0lTT3Z3T2NTdDFrazBNVkRVK1RYR0ZF?=
 =?utf-8?B?dE9aV2pLTCtaZkNYb1JKVnVKOHYzNWFUWGg1VnFUVVJ4T1JVeHZQck8xMjdH?=
 =?utf-8?B?Sko3bTFjN1VzVmR3aHlZRGxEaVk5ajF2dXN4NDJIQzBqMWhUOUpvaDFRcHhU?=
 =?utf-8?B?Ym1DS0piS0w1TEpHQVRlQmU1V21UNDJTZTJnR3FOWi9od0FxNFNuRVRmbDBN?=
 =?utf-8?B?WE9pV1pONUVscHhjK0RpR2lVcWZiRHRQTU9tZUJhbEtOcXpkTDViWk93V3dT?=
 =?utf-8?B?TTZnTVVld2t5RnYrZnZPenRvdHpmdFBIemh3T1ZVM2pyT1UwVDhmL1ZOK3pK?=
 =?utf-8?B?QlN0ZGpLc3MwUDRTd0xUd3lYY29MWGFxZnUxcDhZWUtzMHZObTlGQXVvUFFU?=
 =?utf-8?B?NUxEK2VieE5ONEs3NGJDZUNlTVVmR0YzUzgvZ0kzU2Z3UlJMbWlUTWxFOGk3?=
 =?utf-8?B?TFh3Y3hKZWxiMUxsMllOMCsvQndMQ3I3aTgwT2lLWUVMYi9KQk9RQzNkNlRp?=
 =?utf-8?B?a0RtNThpYit5cU1pL29Qb09xZWI1enZYcXRwbjE4VWhoNWFxS2tSMy83WUd2?=
 =?utf-8?B?RlAyNE5HNjcyTG8wMXB1cUNOeUptaklLZStha09SNDh0YmZ6TS9IYUNraXps?=
 =?utf-8?B?TE1yYU9WRnVkVHZramhCZXBJaHZzMURka29PT29JdlByeExTYWFnbVZxVTF0?=
 =?utf-8?B?cHRTaEVMeDhJUXVycG1mRTRiSkxDakVVYnZnWlVjbkQzRmtiYVZxR2NxTmJm?=
 =?utf-8?B?RG1vQnMwejJBRGhGVUtEU1lUeWdEb29HRWhySnorSnRKcjFyTHdxVVlMVExT?=
 =?utf-8?B?OS9jMXVpN1YvYzFDVVI0SjdkLzFERjFTT25tejV1eTN4MW1qTlhKS21Pand1?=
 =?utf-8?B?UXkwZFJIKzdCZUtaYlFYb21wSzJreExRbFg4MkJlRkYxOTh1SkZBVVV0NGFn?=
 =?utf-8?B?L2FzdkUxcG9PN1M0YWVPcysxdDJ3cm9nZlFWR2FpL1NLRXhwbmFnTzJYZTUz?=
 =?utf-8?B?dTU4SzBpZUlBZHY2Ky9YVkJRSlFXbG1wUlQ2c2JqM3orOCsrZXVXMWwxaDVJ?=
 =?utf-8?B?UktBQ1FodjFzMlA1OXBQdlRRM3cxanIvaURCWWVUNTlYRTBRTjcvWUdKUE8z?=
 =?utf-8?B?SE50ekZjL1dZQiszS2ZiT3M2K1ltWlhjckFkbEpFTTdQaGRoRlMrM3RkZlBM?=
 =?utf-8?B?bWVxQzREdTRCekJCWWpZb0xIeE96c0pGR04zdjM4aklPbTRtVkw3ejh6UDNk?=
 =?utf-8?B?NDRJYk4waHVvRkxMcWl4R3U1UXhOb0tTT1p3ZjlVMFo3Wmd6cVhuNDF1UVNJ?=
 =?utf-8?B?My9VUVB3NXN3dXNGMUZ0Um1iYTltMEZhNUF2UUpkMVVOU0tWeDBudE1BUEky?=
 =?utf-8?B?R09kazZWLytDSkF3RmRUdWNySVNkTzRCL1k1dVV1TDdQRzZrNHdhWWF3RzA0?=
 =?utf-8?B?MC93UkRCM0FsOUlyNmtxdVFVUElxcnVWcVdudHp4bjRxcndxNDRESEpvZk05?=
 =?utf-8?B?SXRYcVRJaGQrK05LUDFoZGhUQXhuY0IrRWZyVEV0RUh1WXhmQWVBdmZCSGNx?=
 =?utf-8?B?SU0vaGsvdmY4d0dOTnMzUEd0TG5WSG1ZaVZjY244cmo3eTFESTM0cjUvMzdr?=
 =?utf-8?B?WlZYQVVWaEpmYXQ3U3NwNHJqNkJPSm4wY1NTalhiR2dhcHNMb3FjZkNoQWIy?=
 =?utf-8?B?U1J6b1JVNXpUcjhaRytrY3gyRnVXblVTQm16WTVPVkZIK3JRVnVVVXRaVjl4?=
 =?utf-8?B?UTJ4YkVxaHgwV2o0ZWJrYlJkTk1ab21uVUVSV0NzRkNvek1TdXdkNTQxYlVK?=
 =?utf-8?B?NjRJYXBUOGVIdEdER1FudHZJYnBzcm9SalR4MUhVMHYzUnNUZUxHWEtpNS90?=
 =?utf-8?B?WXlabnkvV243V0ZJZHdaUCtWdjdpY3VpY1dGV3dQMHB0aTAxdnZXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbe6790-a296-41d7-c19b-08de630e57a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 10:23:58.4231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /U7LdW8pJClt28biGgpG+JfHvvFsIPUZRddh4xy9DFQ7y1PFDkYHqiEDxFnHSwCB8cgrYRDm34lqDFAnOvUIJ8MV9NtN4CbsCx5OAf3XHWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5057
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDIsIDIwMjYgNjo0OSBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBKYW1pbiBMaW4NCj4g
PGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz47DQo+IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBU
cm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+Ow0KPiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT47IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gbGlzdDpB
bGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQv
MTFdIGh3L2FybS9hc3QyN3gwOiBBZGQgRFJBTSBhbGlhcyBmb3IgU1NQDQo+IFNEUkFNIHJlbWFw
DQo+IA0KPiBPbiAyLzIvMjYgMTA6NDYsIEthbmUgQ2hlbiB3cm90ZToNCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9k
Lm9yZz4NCj4gPj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyLCAyMDI2IDU6MzQgUE0NCj4gPj4g
VG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgSmFtaW4gTGluDQo+ID4+
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc+Ow0KPiA+PiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29t
PjsgVHJveSBMZWUNCj4gPGxlZXRyb3lAZ21haWwuY29tPjsNCj4gPj4gQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleQ0KPiA+PiA8am9lbEBq
bXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBv
cGVuDQo+ID4+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3Jn
Pg0KPiA+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDA0LzExXSBody9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMg
Zm9yIFNTUA0KPiA+PiBTRFJBTSByZW1hcA0KPiA+Pg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4+IFdv
cmtpbmcgd2l0aCBvdXIgSVQgdGVhbSwgd2UndmUgdHJhbnNpdGlvbmVkIHRvIGEgTWljcm9zb2Z0
IG1haWwNCj4gPj4+IHNlcnZlciB0byBlbnN1cmUgREtJTSBpcyBjb3JyZWN0bHkgaW5jbHVkZWQu
IENvdWxkIHlvdSBwbGVhc2UNCj4gPj4+IGNvbmZpcm0gaWYgeW91J3ZlIHJlY2VpdmVkIHRoZSBi
ZWxvdyBwYXRjaCBzZXJpZXM/DQo+ID4+Pg0KPiA+Pj4NCj4gPj4NCj4gaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9RRU1VL1NFM1BSMDZNQjgxOTlGNEIwMDY5RjkzMjYwMzQ1ODVENkZDOUFBDQo+ID4+IEBT
RTNQUjANCj4gPj4+IDZNQjgxOTkuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbS8NCj4gPj4NCj4g
Pj4gSSBkaWQuIEFsdGhvdWdoLCB0aGUgc2VyaWVzIGlzIG5vdCB0aHJlYWRlZC4gUHJvYmFibHkg
ZHVlIHRvIHRoZSB3YXkgaXQgd2FzDQo+IHNlbnQuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4N
Cj4gPj4gQy4NCj4gPg0KPiA+IEhpIEPDqWRyaWMsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBj
b25maXJtYXRpb24uDQo+ID4NCj4gPiBJdCdzIHBvc3NpYmxlIHRoYXQgdGhlIHRocmVhZGluZyBp
c3N1ZSB3YXMgcmVsYXRlZCB0byBzb21lIGV4dHJhDQo+ID4gJ0Zyb20nIGluZm8gaW4gdGhlIG1h
aWwgYm9keS4gSSd2ZSB1cGRhdGVkIHRoZSBzY3JpcHQgdG8gcmVtb3ZlIGl0LCBzbw0KPiA+IHdl
J2xsIHNlZSBpZiB0aGF0IGZpeGVzIHRoZSBpc3N1ZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiAN
Cj4gT0suIEkgY2FuIG5vdCBmZXRjaCB0aGUgc2VyaWVzIHdpdGggYjQuIFNvIHlvdSB3aWxsIGhh
dmUgdG8gcmVzZW5kLg0KPiANCj4gDQo+IFdoYXQgYWJvdXQgdGhlIHY2IG9mICJody9hcm0vYXNw
ZWVkOiBBU1QxNzAwIExUUEkgc3VwcG9ydCBhbmQgZGV2aWNlDQo+IGhvb2t1cHMiLiBEbyB5b3Ug
cGxhbiB0byByZXNlbmQgc29vbiA/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCkhpIEPD
qWRyaWMsDQoNCkRvIHdlIG5lZWQgdG8gbWFrZSBhbnkgY29kZSBjaGFuZ2VzIHJlZ2FyZGluZyB0
aGUgImkyYy1idXMtbGFiZWwiPw0KSWYgbm90LCBJIHdpbGwgc2VuZCBvdXQgdGhlIHBhdGNoIHNl
cmllcyB0b21vcnJvdy4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

