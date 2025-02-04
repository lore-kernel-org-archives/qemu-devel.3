Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B98C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfECX-0004H0-3b; Tue, 04 Feb 2025 03:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfECQ-0004Fy-Uy; Tue, 04 Feb 2025 03:22:27 -0500
Received: from mail-tyzapc01on2071f.outbound.protection.outlook.com
 ([2a01:111:f403:2011::71f]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfECF-0002xe-CJ; Tue, 04 Feb 2025 03:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwqYPJusSffpNtjO1qCJIkdbL6eRy/XWaVmNgpsOBR4NHjPdvrB85IW5AFa3iW7ym/5Gx5y8y+/79Auj3HD8m3s9gUGj8fGDGEiDllvduIisda95lk5o0rUAuPfh5cNXCk+tLxiugzrPDxzQeR0MGQUxM2vKY0mRWQmeQbvaDB1V2OjvsnbofRW/aQenR3Mq08Gx2NwZFG0xMecuaOAepwNose5UQLHd2PRdwEeIeZFTDgQ97WWl5pP4JmQ/rBufSxfhSY+d+E0yMB+MxrryK0Qc72Q9hcgx0ZbidnWpbd3OM+YbCx5HryyOh+yFs3hX26JKAWceVo4boN/1kPeGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGsVwOgxer4EkPGlgAkGiN8e2ZvnLzQmJ9GWKp6utWw=;
 b=YSF0u2/lLVWrGwjRf/ls+CpAph+rivZ1ndAU0i639Rujwp4Tkj1dX/vLWtmuB+YNZixG1HEKRBZOIwr5yZ7gR0nNQVUM+xkV3jSSbJCKqAEcl+N3fdkhc6hGfeiMv5+rO0MncK8bhSjuVMP88afx5AeV+M7clHdCsQbcRIrsg+6WtbT6/av0muA9/PL7iwcHcKbJEv9E4t03rxxxjbokiSM8J75LraOlLiVolsk4c5vltsRwgf//Ps3BFde00GZpyURhW0Ur83wu3kVfyd09BN6AleAVkDCGHQhjr9GewmH8kZUhtRH7sKKS4WQ9WJRzR1xGLFp3XbNvO+qrB3974g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGsVwOgxer4EkPGlgAkGiN8e2ZvnLzQmJ9GWKp6utWw=;
 b=bP12q51BTAYgcwS0rOcN0Y260rloBFjTKvInMYEj5EKoUByYa9EPyEQqRx7ILVxTHrQtCdgg2YAgX28D77OkSNyICWSprM4AfbTADdgC3cdqrMr8vZ7WgSUqX2MhVgqKeK9xvZKZPesYw78ZK0note+wW4we9b+z3MgZWijQQXd25cyeWpJvT3mnTX8SgeyT10XAtaHBp2kc5GtvK0mCPr/khL7DT55218RXBZMlsssLIkDJgumjq6pH7F/Ih83f7HK0dgzxiengs+dqYTjc85ZjdFbmUOEt8UZKR7LWdeD+++vMyYlGLTF4OHImfopHeTXBK+6yZwvo5gvOySSjLw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6591.apcprd06.prod.outlook.com (2603:1096:820:f8::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Tue, 4 Feb 2025 08:22:05 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Tue, 4 Feb 2025
 08:22:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
Thread-Topic: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
Thread-Index: AQHba9K4YfoMx8rChEaxoKZIUrwsxrMuB+MAgACswYCACBWzUIAADHiAgAAJFKA=
Date: Tue, 4 Feb 2025 08:22:04 +0000
Message-ID: <SI2PR06MB5041FC0F7F84B3D9031D0111FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
 <2d9247ab-34dd-4dde-a9c0-c04c2d8a1a18@kaod.org>
 <d9575d2cec122e41e11d84667f4d7cc63848b3ce.camel@codeconstruct.com.au>
 <SI2PR06MB504109C5631AD551E2542802FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <fd8bd633-947b-4bb6-be64-eb3bce60babb@kaod.org>
In-Reply-To: <fd8bd633-947b-4bb6-be64-eb3bce60babb@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6591:EE_
x-ms-office365-filtering-correlation-id: b181e831-5e55-4575-948f-08dd44f501fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OTcxbDR0ZDdsblc3ZDVmV29CTG5oWjZmMjVpNjBod0grbGxuT0xXcDBJa1lR?=
 =?utf-8?B?Mk91azNYYlQ2dTYyWEtlSXRQYVdIcU9oZWJLOUpkWTdDQnowVHNqUUkweXh2?=
 =?utf-8?B?OUUvRXNmTjNMNGVibXRQSDd4eDN1aTZ6YTYwUFJQZlVKVm1JTW4vWFhTdHZh?=
 =?utf-8?B?VmpwTWZLeE1YQ3pnQ1NoRWtORGQ0UW56RWwvTkp0d1V6VXNkc1UwNzQ3WXBR?=
 =?utf-8?B?QnhhenVJcHpzT2lRYTZIL1RnS1lTVGxscG9yTVRZSUpRUzd4T005czB6bzJC?=
 =?utf-8?B?QVI4aGhreWZwQVN0YmNOSFhQOWJTTW9tT1pLU3djRHlYSXd2ZCtpUFhSUW9V?=
 =?utf-8?B?MUlUR3NIb2Z0eVphcHJrOEtwNi9EK2k3U1ZkUURMVE03VG8vbzJTcEJsS3pS?=
 =?utf-8?B?UkdSUEIyTmF3QXdFVVV3eFNQL2NLYWE1Vk1CMFhrRFdISjA1Q2hVSDUzbjds?=
 =?utf-8?B?TFE5RWFiMnVIQUVWUTlqMGhYSVpDUHVVd0FXWlBMeXlWRzBBem1oUFlndFEx?=
 =?utf-8?B?Zzc3a1Y0RHBJQTRSS2dob1lzdUlBeG5mMVhMNUw5bXNwR2FTMGJlQWkxYWE4?=
 =?utf-8?B?TGwweS9QT0pWdGtYUThJM2hycGNNc2xZWndyV295UFdBb3AzR1Z5eTFXd1My?=
 =?utf-8?B?dVBlY2tWdUs5cWYrc1JXb0JaRDNFbGJjenhOaU42QmZvQU00aXVMSTBiblRS?=
 =?utf-8?B?QWNVeUtTdWJVUXZHT2ROK1ZLWkUwUnQvSnMwc3d4NUFYNURhTmQ3b2ZyMlMr?=
 =?utf-8?B?NldHQWl4Sjh6VXZsUVRiSnRoOXJ4aTZvOTZCbFd6U28zUURyZkZUODNUUUlV?=
 =?utf-8?B?cUVpRmNFd0N2SmNTU2NmOTVhN1JmREp1b0dhL3ZlalprOTdKd2UrOHMwM3hi?=
 =?utf-8?B?WUMvb0gydEJCWXZ6bytMVStCK3Z3S01VWGE1TDBCMHVibitWc2Rqb3NBWjFh?=
 =?utf-8?B?cXY3aDAzdkIveWRUNldyMVA0dUlhNytYTGUxbC94TCt6RjJzYjYyR1NZbGUy?=
 =?utf-8?B?ZWpCSWJxZExBVzVJRXpHUWc4N3g1M3h2RHNrOHI5R1FWYkpyeUlyZFN3eU9Y?=
 =?utf-8?B?cVVBbmh0QytnZG4zY1Qwb1hDYUtHR204aHhkdXdTVUk4NHpKTmR3ZVhFTFhu?=
 =?utf-8?B?eDA1L3dKOFFMUG5TQUo0c3BvTzNSQVVYZ252NHo2M2FrSTJ3VnhRdjl3S0t5?=
 =?utf-8?B?cFdDMnlYdHNSU2VoWnYyOUJDVXdWRkw0bS9LOUkxaU0zQTVhUWY2ZWx3QlIr?=
 =?utf-8?B?Y0hIN2FSRkhaTFlZRmNTSUFtVlZvZTZ4aVJFR29sOFZqSzlLcWxpUDArR1BD?=
 =?utf-8?B?VUtISzVRQzZVbkFHVHRlS21EN1ljM0J4VU9wampCZkJPMklOc3owTDE5UWNk?=
 =?utf-8?B?RjEvd0dtQzVBaGpSUko4aEJjVG1BS1AyS3UvVzhxS0hvUlRVOUZkOFZTVnpv?=
 =?utf-8?B?bXVjL05SSllXWk10OG1oM3RNM2o4N1VSa2FlT3UzYWF2dnJtT0FOZ1VCVWJn?=
 =?utf-8?B?WU03V2Y1RWJSYWRseTF4Y3JZODUyUmVuS2hpVW5VQ25DaExBZzNxakJ5RnhM?=
 =?utf-8?B?WmY0S3YvbHBjVVhrTGxFK0dhdmFMOEpqZVNZUXJjZ3I4SU45Q283VzMxS01K?=
 =?utf-8?B?T1RTazhjU1NtQjhHalNKYU1sKytzZmQzM0NBT2xSUlpOR3ExUkpob1VWQXRw?=
 =?utf-8?B?clR2YlgyQkRYUUZrbW5ocGhtQ3FrejV6VElVS0V0eE9qWjM0NTF1b1paZmlP?=
 =?utf-8?B?TVI3WHN0b3VsaVBOdGxUMGxHVUNzN05ST0IrL3BjMjlPSzJSYy8ydjZiTFlh?=
 =?utf-8?B?R0ZQU0pqcWxKdUdlWXdZdUo1ZkJGTXc0R1htekIvdzRVT203bmhGSUNiYlRa?=
 =?utf-8?B?TjhXekZNWTJjdm1USW52cGRNbDV6Z1Yya0NvanVxMDdxUmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0lhLzZOQythR3VPaHJyYm1rc0ZQMU5rOWtCdDZ5VE5QOWRjNzNlZE9mMXNL?=
 =?utf-8?B?bzBtOXY5S3VFU1pZaUxSaHdFNGtFNmlXcnJmaWpGWVBCVVZ3RXdPQ1VraC9S?=
 =?utf-8?B?eXBzeUdhK0IwY1loV2xNVzl5TUwxWVh6cUlWeTVraWEzRmhRNTNNR3FjV1lz?=
 =?utf-8?B?UFBHZ3VxMFlFc1RZTUt5WnNPTDdtMGdlK3BHODU3UTFIVHFwcHQ4andPZ2c3?=
 =?utf-8?B?TFY2THdRbXlKZmhtWnhIcGgzRklPbHZXVlh3cCsxVytTODJsM0crTGgreFNz?=
 =?utf-8?B?WFQ1K1BiNHJaRzEzWnV2SXV4U28vYU42aGN0TFNIZjdQREtQZ3pTd1lORnlG?=
 =?utf-8?B?Ym5UeDhMRlR4MWhHWkNOMUx5TDBjeFFrdkEwcXNBeHVrY2l5M3NFZjRWM3ZB?=
 =?utf-8?B?UXRGYmR0SzdIM3Q4L1VxdXRLT1BMUmZZRkxzOUJWZVFxbnZHTUpsb25IRmZQ?=
 =?utf-8?B?S2xCVEJEaDJHK085SEVQVmo3NTNYMXhtRVUrdWtmLy8zakJOUENINmdTdmkv?=
 =?utf-8?B?L3Z1bU9MTjZHaVo5dW4wVHhzd3FucTNqYVJRS2g0U21UYXBDUjBpbWMyYjZE?=
 =?utf-8?B?b2k3NE5KV0xKdkNzb1R0cy9rVTNlYkREMkltZjNXYzRQMmxybStzMjhqeDJr?=
 =?utf-8?B?N3JIK0ZCclNCdXRWRUpoNitWbU43OHFEc3g5TDNxVlZOZTlwcGpsTUIvVTJo?=
 =?utf-8?B?MUhvNEhNNm9EOXpOM2dnUWZlcllzZFZXVSt6QWtZNE80ZlQ0eUZod0psV2hS?=
 =?utf-8?B?OVpMeGFhNnZURHYwcjZZei8xTk9MeVNjcC9BWTYwWm9aVXJ4c0ZEam9XZUdL?=
 =?utf-8?B?ekJqTDZzd0Y1TlhLV1p3cWNEWU1FbGZ6K2NZUEM4d3pMUnVRbXEyTVRyd2lk?=
 =?utf-8?B?UXFiUHIzcFF1Y2pmWUpnQ2NNZUFKaHBFZGZpd215M0oxejZ0aW9mSVhNcVR3?=
 =?utf-8?B?RWRzd01JTDJuRlcwUk12T2dQZ0NtMTRPSTBpYWZYb0VPNWZpeWkxUExTMEFK?=
 =?utf-8?B?MkFMeklaWFZvZzFoc1pxbmRqdC9nRU42ZFJQQW9Od1pMU0E1R0pBOU1IV0xE?=
 =?utf-8?B?UTgzU05EVGtWUGNqSlNpV01MR01lVjFxY2kwcEhmWWJOR0FOMW9kTmVRQlo3?=
 =?utf-8?B?T2U4QVppQWxTVjk4bS9IbTBmcWo1bm0wNVNIUTBzRVZqdURKTlhqbzllcStm?=
 =?utf-8?B?VWoxem1sQVZwRU5nS1V1bC9WNkViOHROcDdWT1VqbzY5WnhvMTFhekxYWHRz?=
 =?utf-8?B?Z1E3Y21QNFl5UXgyNHU1QS9uRjVYOFNTSHJCbk11dTJucFQwV0tTRkZNYkpa?=
 =?utf-8?B?NmVHdk8zUWRDV2tLM1RvUlNId0gydHVZT3RITnJnU28zM3F6Mkw4QWFJbThs?=
 =?utf-8?B?NmNyODYzTGxrODF5ejlla1Brb2F1cEZHYXFlOTV4bE95Tml5bnVWbHhLOFlh?=
 =?utf-8?B?NTZNRFMyc1lEeVNvY2VRQnlPaFRVSUplWWRRYWNaelowdFVCanh2Z1pCZTVG?=
 =?utf-8?B?ZFdvaUlGeU9oeHJ6d09jR2ZVRERTWENXLytqako0Q2VhRk9uY3pHZWN6QWhk?=
 =?utf-8?B?WlMyUitoaUlTT1NMdjA2TDkzSnJVWWVKMThsNkJ2MmNNUmRScGlQOGlLWVFt?=
 =?utf-8?B?cnE3NXV0TVBBWEZlUU5KRStGSEh2WXFYUkRydEllc2RwL2ZsVlUrWFZVR0d5?=
 =?utf-8?B?Q0FweUQzS3JybU1HaERnczEvKzFITmhWWTNhSTAydmNvU1NYQXcrUHdHNmd6?=
 =?utf-8?B?eWdWLzNGUktIeko3Q25BNnZIWU56SWtmV1Nscll1R25oZ1lFcXVGNVBBcHln?=
 =?utf-8?B?dkFPVU9pZXJXSEhobmdBeFFVQXFlNlQyNjB6Ti9wK1BsR2hBRW5XR0g2T2Ew?=
 =?utf-8?B?VWMyZkU0UFJReTRPQy93NGRvWDhNU2EyT0g0dFBJTW5WNUREcDQ3LzZQYkZO?=
 =?utf-8?B?VnBmRFVkcTk2MFUxYmhEMitXd08vM1lHSXFuT21ac0VYVjZSY25HU21XOXc5?=
 =?utf-8?B?eW9hOURPVzlKVnZLM2wxaDBBRDVMS1hXVWlzWFgwWGxpUDNIU0MxVndWcm8w?=
 =?utf-8?B?ZzdTbjBtY3dueHBIdDJiNWZCWTVQWFptQkxXRU1xS2RFOUJJK0RzeFUrTVBM?=
 =?utf-8?Q?c/dVV3Bp3geWcW9PQW4gR/P4x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b181e831-5e55-4575-948f-08dd44f501fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 08:22:04.7520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pao4B00d27zO9f+LOftqP4ydYM4RcGN6ZlrRLDxAKlAiugFr60ft6GHzvEYM8vrsKFn7CadKXVmRodVTf5FGBt1TyV3pbqj5a5jAyXqOabA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6591
Received-SPF: pass client-ip=2a01:111:f403:2011::71f;
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

SGkgQ2VkcmljLCANCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA0LCAyMDI1IDM6MzUgUE0NCj4gVG86IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4gPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz47DQo+IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsg
b3BlbiBsaXN0OkFTUEVFRCBCTUNzDQo+IDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0
OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRy
b3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4u
dGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMS8xOF0gaHcv
aW50Yy9hc3BlZWQ6IFJlbmFtZSBJTlRDIHRvIElOVEMwDQo+IA0KPiBPbiAyLzQvMjUgMDc6NTAs
IEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDZWRyaWMsIEFuZHJldw0KPiA+DQo+ID4+IEZyb206
IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4+IFNlbnQ6
IFRodXJzZGF5LCBKYW51YXJ5IDMwLCAyMDI1IDExOjIyIEFNDQo+ID4+IFRvOiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgSmFtaW4gTGluDQo+ID4+IDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+Ow0KPiA+
PiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUNCj4gPGxl
ZXRyb3lAZ21haWwuY29tPjsNCj4gPj4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9w
ZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA+PiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+ID4+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4+
IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA+
PiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEgMDEvMThdIGh3L2ludGMvYXNwZWVkOiBSZW5hbWUgSU5UQyB0byBJTlRDMA0KPiA+Pg0KPiA+
PiBPbiBXZWQsIDIwMjUtMDEtMjkgYXQgMTg6MDMgKzAxMDAsIEPDqWRyaWMgTGUgR29hdGVyIHdy
b3RlOg0KPiA+Pj4gT24gMS8yMS8yNSAwODowNCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IFRo
ZSBkZXNpZ24gb2YgdGhlIElOVEMgaGFzIHNpZ25pZmljYW50IGNoYW5nZXMgaW4gdGhlIEFTVDI3
MDAgQTEuDQo+ID4+Pj4gSW4gdGhlDQo+ID4+Pj4gQVNUMjcwMCBBMCwgdGhlcmUgd2FzIG9uZSBJ
TlRDIGNvbnRyb2xsZXIsIHdoZXJlYXMgaW4gdGhlIEFTVDI3MDANCj4gPj4+PiBBMSwgdGhlcmUg
d2VyZSB0d28gSU5UQyBjb250cm9sbGVyczogSU5UQzAgKENQVSBESUUpIGFuZCBJTlRDMSAoSS9P
DQo+ID4+Pj4gRElFKS4NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBwcmV2aW91cyBJTlRDIG1vZGVsIG9u
bHkgc3VwcG9ydGVkIHRoZSBBU1QyNzAwIEEwIGFuZCB3YXMNCj4gPj4+PiBpbXBsZW1lbnRlZCBm
b3IgdGhlIElOVEMwIChDUFUgRElFKS4gVG8gc3VwcG9ydCB0aGUgZnV0dXJlIElOVEMxDQo+ID4+
Pj4gKEkvTyBESUUpIG1vZGVsLCByZW5hbWUgSU5UQyB0byBJTlRDMC4NCj4gPj4+DQo+ID4+Pg0K
PiA+Pj4gV2h5IG5vdCBpbnRyb2R1Y2UgZGVmaW5pdGlvbnMgd2l0aCBfSU5UQ19JT18gYW5kIGxl
YXZlIGFsb25lIHRoZQ0KPiA+Pj4gY3VycmVudCBpbnN0ZWFkID8gRG8gd2UgZXhwZWN0IHRvIGhh
dmUgbW9yZSB0aGFuIDIgSU5UQyBjb250cm9sbGVycyA/DQo+ID4+Pg0KPiA+Pg0KPiA+PiBUaGVy
ZSB3YXMgc2ltaWxhciBkaXNjdXNzaW9uIG9uIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciB0
aGUgU0NVIGENCj4gPj4gd2hpbGUgYmFjazoNCj4gPj4NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzk0ZWZjMmQ0ZmYyODBhMTEyYjg2OTEyNGZjOWQ3ZTM1YWMwMzE1OTYuDQo+ID4+
IGNhbQ0KPiA+PiBlbEBjb2RlY29uc3RydWN0LmNvbS5hdS8NCj4gPj4NCj4gPj4gUnlhbiBkaWRu
J3QgbGlrZSBkZXZpYXRpbmcgZnJvbSB0aGVpciBpbnRlcm5hbCBkb2N1bWVudGF0aW9uIDooDQo+
ID4+DQo+ID4+IEFuZHJldw0KPiA+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlv
bi4NCj4gPg0KPiA+IExhc3QgeWVhciwgVHJveSBhbmQgSSBpbXBsZW1lbnRlZCB0aGUgU0NVKENQ
VSBEaWUpIGFuZCBTQ1VfSU8oSU8gRGllKQ0KPiBtb2RlbHMgdG8gc3VwcG9ydCB0aGUgQVNUMjcw
MC4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFzdGVyL2h3L21pc2Mv
YXNwZWVkX3NjdS5jI0wxMDczDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9ibG9i
L21hc3Rlci9ody9taXNjL2FzcGVlZF9zY3UuYyNMMTA4MA0KPiA+ID4gSSBhbSBmaW5lIHdpdGgg
a2VlcGluZyB0aGUgSU5UQyhDUFUgRGllKSBuYW1pbmcgYW5kIGNyZWF0aW5nIGEgbmV3DQo+IElO
VENfSU8oSU8gRGllKSBtb2RlbCB0byBzdXBwb3J0IHRoZSBBU1QyNzAwIEExLg0KPiANCj4gR29v
ZC4gSSB0aGluayB0aGlzIHdpbGwgcmVkdWNlIHRoZSBjaGFuZ2VzIGFuZCBjbGFyaWZ5IHRoZSBt
b2RlbHMuDQo+IA0KPiA+IEkgaGF2ZSBhIHF1ZXN0aW9uIHJlZ2FyZGluZyB0aGUgSU5UQ19JTyBt
b2RlbCBpbXBsZW1lbnRhdGlvbjoNCj4gPiBDYW4gSSBkZWZpbmUgc2VwYXJhdGUgImludGNfaW9f
Y2xhc3NfaW5pdCIgYW5kICJpbnRjaW9fY2xhc3NfcmVhbGl6ZSIgZnVuY3Rpb25zDQo+IGZvciBJ
TlRDX0lPLCBzaW1pbGFyIHRvIHRoZSBTQ1UvU0NVX0lPIG1vZGVscz8NCj4gDQo+IExvb2tzIE9L
IHRvIG1lLg0KPiANCj4gPiBJZiB5ZXMsIEkgdGhpbmsgdGhlIHBhdGNoIOKAnDIgU3VwcG9ydCBk
aWZmZXJlbnQgbWVtb3J5IHJlZ2lvbiBvcHPigJ0gY2FuIGJlDQo+IG9taXR0ZWQuDQo+ID4gQWRk
aXRpb25hbGx5LCBJIHN1Z2dlc3QgdGhhdCBib3RoIElOVEMgYW5kIElOVENfSU8gaGF2ZSB0aGVp
ciBvd24gTU1JTw0KPiBjYWxsYmFjayBmdW5jdGlvbnMsIGFzIHRoZWlyIHJlZ2lzdGVyIGFkZHJl
c3NlcyBhcmUgZGlmZmVyZW50Lg0KPiANCj4gRG8geW91IG1lYW4gdGhlIHJlZ2lzdGVyIG9mZnNl
dCBpbiB0aGUgTU1JTyBhcGVydHVyZSA/IFdlIHRyeSB0byBhdm9pZA0KPiBkdXBsaWNhdGlvbiB1
bmxlc3MgdGhlIGNvZGUgYmVjb21lcyB0b28gY29tcGxleC4NCg0KDQpJIG1lYW5zIGJvdGggSU5U
Q19JTyBhbmQgSU5UQ19DUFUgdXNlIHRoZSBzYW1lIG9mZnNldCBidXQgZGlmZmVyZW50IHJlZ2lz
dGVyIGRlZmluaXRpb25zLg0KDQpJTlRDMDoNCklOVEMwXzEwDQpJTlRDMF8xNA0KDQpJTlRDMToN
CklOVEMxXzEwDQpJTlRDMV8xNA0KDQpJIHdpbGwgaW1wbGVtZW50IGFzIGZvbGxvd2luZw0KDQpz
dGF0aWMgdm9pZCBhc3BlZWRfaW50Y19yZWdpc3Rlcl90eXBlcyh2b2lkKQ0Kew0KICAgIHR5cGVf
cmVnaXN0ZXJfc3RhdGljKCZhc3BlZWRfaW50Y19pbmZvKTsNCiAgICB0eXBlX3JlZ2lzdGVyX3N0
YXRpYygmYXNwZWVkXzI3MDBfaW50Y19pbmZvKTsNCiAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygm
YXNwZWVkX2ludGNpb19pbmZvKTsNCiAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmYXNwZWVkXzI3
MDBfaW50Y2lvX2luZm8pOw0KfQ0KDQpzdGF0aWMgdm9pZCBhc3BlZWRfMjcwMF9pbnRjaW9fY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQp7DQogICAgRGV2aWNlQ2xh
c3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCiAgICBBc3BlZWRJTlRDQ2xhc3MgKmFpYyA9
IEFTUEVFRF9JTlRDX0NMQVNTKGtsYXNzKTsNCg0KICAgIGRjLT5kZXNjID0gIkFTUEVFRCAyNzAw
IElOVEMgSU8gQ29udHJvbGxlciI7DQp9DQoNCnN0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRf
MjcwMF9pbnRjaW9faW5mbyA9IHsNCiAgICAubmFtZSA9IFRZUEVfQVNQRUVEXzI3MDBfSU5UQ0lP
LA0KICAgIC5wYXJlbnQgPSBUWVBFX0FTUEVFRF9JTlRDSU8sDQogICAgLmNsYXNzX2luaXQgPSBh
c3BlZWRfMjcwMF9pbnRjaW9fY2xhc3NfaW5pdCwNCn07DQoNCnN0YXRpYyB2b2lkIGFzcGVlZF9p
bnRjaW9fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQp7DQogICAg
RGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCg0KICAgIGRjLT5kZXNjID0g
IkFTUEVFRCBJTlRDIElPIENvbnRyb2xsZXIiOw0KICAgIGRjLT5yZWFsaXplID0gYXNwZWVkX2lu
dGNpb19yZWFsaXplOw0KICAgIGRldmljZV9jbGFzc19zZXRfbGVnYWN5X3Jlc2V0KGRjLCBhc3Bl
ZWRfaW50Y2lvX3Jlc2V0KTsNCiAgICBkYy0+dm1zZCA9IE5VTEw7DQp9DQoNCnN0YXRpYyBjb25z
dCBUeXBlSW5mbyBhc3BlZWRfaW50Y2lvX2luZm8gPSB7DQogICAgLm5hbWUgPSBUWVBFX0FTUEVF
RF9JTlRDSU8sDQogICAgLnBhcmVudCA9IFRZUEVfU1lTX0JVU19ERVZJQ0UsDQogICAgLmluc3Rh
bmNlX2luaXQgPSBhc3BlZWRfaW50Y2lvX2luc3RhbmNlX2luaXQsDQogICAgLmluc3RhbmNlX3Np
emUgPSBzaXplb2YoQXNwZWVkSU5UQ0lPU3RhdGUpLA0KICAgIC5jbGFzc19pbml0ID0gYXNwZWVk
X2ludGNpb19jbGFzc19pbml0LA0KICAgIC5jbGFzc19zaXplID0gc2l6ZW9mKEFzcGVlZElOVENJ
T0NsYXNzKSwNCiAgICAuYWJzdHJhY3QgPSB0cnVlLA0KfTsNCg0Kc3RhdGljIHZvaWQgYXNwZWVk
X2ludGNpb19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCnsNCiBtZW1v
cnlfcmVnaW9uX2luaXRfaW8oJnMtPmlvbWVtLCBPQkpFQ1QocyksICZhc3BlZWRfaW50Y2lvX29w
cywgcywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9BU1BFRURfSU5UQ0lPICIucmVn
cyIsIEFTUEVFRF9JTlRDX05SX1JFR1MgPDwgMik7DQp9DQpzdGF0aWMgdm9pZCBhc3BlZWRfaW50
Y2lvX3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQp7DQp9DQpzdGF0aWMgdm9pZCBhc3BlZWRfaW50
Y2lvX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopDQp7DQp9DQoNCkkgd2FudCB0byBjcmVhdGUg
YXNwZWVkX2ludGNpb19yZWFkIGFuZCBhc3BlZWRfaW50Y2lvX3dyaXRlIGNhbGwgYmFjayBmdW5j
dGlvbnMuDQoNCnN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgYXNwZWVkX2ludGNpb19vcHMg
PSB7DQogICAgLnJlYWQgPSBhc3BlZWRfaW50Y2lvX3JlYWQsDQogICAgLndyaXRlID0gYXNwZWVk
X2ludGNpb193cml0ZSwNCiAgICAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0K
ICAgIC52YWxpZCA9IHsNCiAgICAgICAgLm1pbl9hY2Nlc3Nfc2l6ZSA9IDQsDQogICAgICAgIC5t
YXhfYWNjZXNzX3NpemUgPSA0LA0KICAgIH0NCn07DQoNClRoYW5rcy1KYW1pbg0KPiANCj4gUGxl
YXNlIHNlbmQgYSB2Miwgc3BsaXR0aW5nIHlvdXIgc2VyaWVzIGluIDMgYXMgcmVxdWVzdGVkIGlu
IHRoZSBvdGhlciBlbWFpbC4NCj4gDQpXaWxsIHJlc2VuZA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
DQo=

