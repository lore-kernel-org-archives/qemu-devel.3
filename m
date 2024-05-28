Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E028C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 01:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBlnQ-0004P8-Mq; Mon, 27 May 2024 21:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBlnK-0004OI-7d; Mon, 27 May 2024 21:38:30 -0400
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBlnH-0002Dm-8Y; Mon, 27 May 2024 21:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALaRaVnvcd/QOBYKLrebbett2yOndYvtfXidY5opEsF7cKMqEadKSTuZaoZ8nBJd/hhDOGw0hBhstKckX4LN1/b60LmfSV2H4RQh8vyc9Rb4UxMM1UaJ28gqHdZc9Pganm7865jQ/J1sC3oUP9SgpeNT9N7yMv1DYPRBEC7ubFQ7OorQbfLB/MEz6rBJXsHpEcf1qBeqfSunfga6y5GI4td4wgIjZfnPKgLI8l6Ve2wsaXiQqtNCcy8HMghWLeL38fUZQZdjZuFJAjs+Mm4LpNumHnKg4sDmtszWmEoy45VuItEK44dHrButh3rEVv5vPSafTCl2c4S1GxZgtpwQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6Mwj3eg17Qpy+wXunqtm2rMG1aEjG2qVbkxqgnypWY=;
 b=fZrodnZga9/2wZjjLx2s/p/hfhPrBkiTRM4g+dvOm/SmXjxOZSJgEF5uO6Xg7DshFFt1TTjpQcf7YIGKZef6+5kmXAIGpOZ5uPQTHDnU+gnuUkhaLiiD6eNRAsl12BrWFlj6zvhR5/x43nxf/+iu6IzXO3zy2YqWf+4S6s2yCMcZkqiMJb3jKawG1qC+z6He20QcW9lhAmm6M79XHHmE88SEaPNvFbW5HEnS48Ve7sLkZmvFsvRKy/KJA4GiGINRnHMWgx2hhDTpPQQSaL6tXX1Iqhxx4M86y4VRqnLCQUpzDV3ABA2uPJwu9r3Q2sfOsLWVIxfsS9jnUkb4FL497w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6Mwj3eg17Qpy+wXunqtm2rMG1aEjG2qVbkxqgnypWY=;
 b=LFIlTHMQthnUiVmFvY7VVw8fUoUcQ7Kd1RUtR978Kk4i5RXb451V/IASqy3cWjnT2HILwEU07+++NIljV+N5ugGu5d99TVtFETY5tBO6ITJ+40lEa/mryJZAPAsnjuNhO5DcvkBwKGcCYMKJs/ChOCMUDKVQcDpH8l337SNE4/2qmaX/PNgZBfcMO2f3StqLB22PwsPuWhvW+VYflqXTsjmZcTp+93mJ8OZsN6L9vr2osmEKDLj6rwPC5uiHN1O2UbunqpNyh9j+56IyqnQhmAZDdnUsSBiASNm5SiIM4cm60N79TnSIxVTrXZ7m70EfUj+Txye/kGTOlNJdf/P8aQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 01:38:18 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 01:38:18 +0000
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
Subject: RE: [PATCH v4 08/16] aspeed/smc: support 64 bits dma dram address
Thread-Topic: [PATCH v4 08/16] aspeed/smc: support 64 bits dma dram address
Thread-Index: AQHasAxE9aGOlngWBUyAboQ+lO4mk7GrP6CAgACfGKA=
Date: Tue, 28 May 2024 01:38:18 +0000
Message-ID: <SI2PR06MB504102354FDF361025252284FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-9-jamin_lin@aspeedtech.com>
 <2d64463d-0694-4d6e-a8c4-5bfad2cf801d@linaro.org>
In-Reply-To: <2d64463d-0694-4d6e-a8c4-5bfad2cf801d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB5178:EE_
x-ms-office365-filtering-correlation-id: 56bcedb6-ff70-4679-0429-08dc7eb6da0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|7416005|376005|38070700009|921011; 
x-microsoft-antispam-message-info: =?utf-8?B?aXl2Y1RqekV4SnR4RnF1Mkk1R0tTNU04RWdiWWtZVDFaRktJbWVqaUdVRU4v?=
 =?utf-8?B?eWJuYkp1SnFIMUdIUytqRVVHK1NKNkVDb2IrRm5qZDJObEl4aVdNZmg2UUZv?=
 =?utf-8?B?TGdRZ1dMcExRR2tFbHN0M2w0cXkvRHFCOGhVVDg1WStVU0RrWWp4bG9ETW5W?=
 =?utf-8?B?NDJxaWRCM1R1bW9rd3ZYcnlXVkp5WDBQVlFPcmxiQnBXK3lKYjhYczlmUWN4?=
 =?utf-8?B?ZHRuREJPaWdiVjhtZWhpZGo4SE4zdFl3cEZrYkN2YUxNSi85UEIxamVpeEZi?=
 =?utf-8?B?NFVjU2RZWFdRanhKdDMxbWxJVFIzK3JQS0IzaWNLdUVBb0pIZkxKWmVPZW1L?=
 =?utf-8?B?WXcxK2IrdFZ5TmxNaUlDRFB5d3hMbnZ4NTlTM3gzZmFSV3djc3JaTlczOWF3?=
 =?utf-8?B?Ty9vUFJnK0Fhcm56dksrWUZtY05WUjBHc2FMbzloc1d6VFBwRnlkRlNZWWV3?=
 =?utf-8?B?MVhIRmNqa2o5dU1YN0J1ZzJaSU9tV2xTMW1Ed0dBZmlaaHB0NkxzNkV4SlE5?=
 =?utf-8?B?dSsxSVkySGhFaDQrT0ZJbGYvRE1UZVV4U0E4blJQREdiRDJRMmNGWEtMam01?=
 =?utf-8?B?V0RnWUR1UWhGNkdybDU0NlZPdGRWTFBldTZnYUdXMnFtSTBGTVBKRzdWYWsr?=
 =?utf-8?B?ZTE5bExQUkJ3VGlUZDRNWlJlSUNaVHZRKzZpVERjMW9JSUh1aG5mUjlPVmY0?=
 =?utf-8?B?WTlQa1o5QWVGOWo1SmZBSEI4RWpiZ0VJbjMycXE3VUZCV1paZ2NidldabWEx?=
 =?utf-8?B?WjFab0tQalMxbWlkcUpjbThEYmlKd1AzMlRhZjVZcWxMTnJhUWJJVW12Rlls?=
 =?utf-8?B?K3NjakFjaTBGL1NGUVdFcFVZYmlhVHJhWGtHc09nVW5HWjRtRDJ1MHh5RzNX?=
 =?utf-8?B?ZmpCa2NVcktaVFNqYU5BRHg3ZjQxYkRKMXdiU0E3ZXpKYkVMaUdnTktselVz?=
 =?utf-8?B?dGF1VUdtRFc1ZjgvNkhQbWdYcnhSQ0ZRampBRWhEZWVlWDBMNXJDK3pRQjZX?=
 =?utf-8?B?VU1FbzdmWmI5K3prekNHck9XRTcvUGhKRG9DNzlFOTJ2OGlZbEpEaTNxbmdv?=
 =?utf-8?B?YldUOFcvNFRCMXZxaHA3c0xoRXJhUXVjL1JoS2VBUXoyQ2JDNjdlQ1QzcjNl?=
 =?utf-8?B?S1k0eW1qcVM1bVhFM3VJMm5NUGRTcEpFeE9nSGVSV1BHVVRSRnh5cy9qdDJC?=
 =?utf-8?B?Y0VsQWxNa3FZdHVvZUxqOWdtSi9udkp4dXRsS3hocitGYnAxMCtOeVd6dFBY?=
 =?utf-8?B?eHJhTk91eUFwbDRNL2Z0WnlKckc2SGp6azNUZFVpTmRTdXI5TkVhME5DcmxW?=
 =?utf-8?B?Yld6RFBEdE0zd29kWkhST3R0a09jMDVycjl0bkVwL2N6MlNtVU5sV1MrWTRy?=
 =?utf-8?B?Q1p3bjVZdktIUnk4R3lOUDlXWmxhZXVHNmo1bjNneGczQkR3U2Y4UDJZNThm?=
 =?utf-8?B?OFR6dUg2SFFycDVzZXJmemFBdzByN0NKVXdmdFFFeUdzU0ViRE5HaW9TTTJi?=
 =?utf-8?B?NjBRNTJ4T1N2SFp1VmF2QmxMM0JPaHVIOElqbHYxQkVuR09nMVF0aHdSUHFn?=
 =?utf-8?B?Q2orMVNxSnIrUFJEVkU4YzIrU3BKd3c2VnpKbGQzb0M4OFBaaW5IMjJxdWt1?=
 =?utf-8?B?dWJSdUFhd3NtRWVYQ0ljT3kzczIrVXRiNzZkclhmaVBLYTUzeHd3cGIxOXhj?=
 =?utf-8?B?Si9HUEY5K2h4Y3YvWUQ0UUlPQ1hUM3o4Vjd1V0UwTk5EOGZ5dGZ4NWordjRL?=
 =?utf-8?B?MkNPNzdOVmZhUGp4ZzVkbWM3dGRlYmhCNnMrb1NlVE03Q005WGRSUDdGdGxm?=
 =?utf-8?Q?UobHGEKitMt26pd/YMClJxuZToglOk3T5Z3MM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(921011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGg3eDFCNzlUQmdmNE9IMmJuazlubWxCWE13OERUL3pCdnVSTk5CTG5JaUN1?=
 =?utf-8?B?YktEeHFkRm02SUx2NGpOUnU2Nm1Hc2s0cDQ0UHFMY3JmUUZIblhOb3lsY3hs?=
 =?utf-8?B?RjdKZmZpT3pZSnlqWEZhTVRGdFJBdzczVnRvQzJGWlcyOFdhZGhGcU1tMk13?=
 =?utf-8?B?Q0lDTytxUW5HWnZyT0hnNkR0ZHhuNitkOExMUFlvaHJpMWFvNDdxNHBQbkhk?=
 =?utf-8?B?cEVTdi8vdGxhanpENjNDeHArQllQTjFJZThoczVmMUZmK3pSNUxhM3VvVDJ2?=
 =?utf-8?B?Tm4vTWtqRGd1UWJ6SzJoNlBsbGpFczRQMjViQVNMbDhRem1IWnZXL1pyNG9h?=
 =?utf-8?B?bG9zcDUyc0pUdE1LWXN3aXhBeUZGMEdFRzRRanlOTzgxakErVnI3Z29EUmU3?=
 =?utf-8?B?SWNYbXNseWl5eXdSM2FDekxWSldlMWp1NDZQTXRNUStQcS9DZFRmWGxoRDhN?=
 =?utf-8?B?b2ptMm8yUnRnZVFBUVVGS0t6cDNJUEE0eVJkZTlLSFMzb3RCbkZHaW12NGZa?=
 =?utf-8?B?ZDhoVGdJK2xWZ1U0U1o0MjIySXhBeG8xVUdlVDhDRHdEL2E2dUxWeDJtVGsy?=
 =?utf-8?B?bTUrSXcybjhkdXVxSFlMWUZQZzY1Y0daZndJbXg0ZDJHb3JZRXFyQUFZZTdB?=
 =?utf-8?B?SHNqYlRsY0l1cWprQkZmamVXdUdaSXYyZHZMYk1lbms2SHNjUzB5MkJjZ2hO?=
 =?utf-8?B?U0JncE9QZjNYaExaZ1J6b0t3YjJaZmNJTzRZMklCR0o5bStqZ3N1Rlh0OHEv?=
 =?utf-8?B?NEhNVlQ2UExlZjJZYjZzNk40Tk5VbWdmK01UTmNxV2V0VmVtR2VHZk9KeTkx?=
 =?utf-8?B?bDRqaUNock5nTk05dEdxaDgyQjU2ZVJvRVgxT2VhWW1xUVA4VHQyclYzN0Uv?=
 =?utf-8?B?Q2orSEVWRHdkOFc4N2FSSC9oWmZKNWF6WXlyVitNb09yOEFELzFwNkJFNkxj?=
 =?utf-8?B?RHoxTXhMdEhvUmZWSVpROUM5OVFGU0M0cGdIakZWUDVEa0ladmhsVlhLK3hP?=
 =?utf-8?B?d0hRRlEyYkNHcVg0dlJGd3gwTS9sN3BTODc0V2RyemJFeVA4Smx3M3p4RXJy?=
 =?utf-8?B?V0hERG5NcFZobGU3R1k0RWZxN1M3d1dsMk1LZXJjaGxqUGs5S3BLTEFqK1Ir?=
 =?utf-8?B?MXcxK2ROamR3N1NnL3NPMm5BcXh3RHNCUTFIcmtaZDdrMklnZjBJZ3JFUHFZ?=
 =?utf-8?B?NGVRbUFOOTlMUXEzV1VJLzN5aVIxWDVOYnRpQ2ZZZTJxWVF5bjluT01pY1gv?=
 =?utf-8?B?dHU1NG01N3hDWlVyT2crOVM5dVU0TFIxdkdldzNrUlBGOE9xOWlLWWhLK2Zm?=
 =?utf-8?B?c1hjb1RYRFc4Y3VZMGw3eDdNTlZyS0Jka0ptemxSQjAvR0VUSmlWSTFvckRs?=
 =?utf-8?B?SDBuaUNnY1hvQ3NXYUR0SzhCMEFzbmhSdzl1blpDZ2dVU1p4ZlNHQzMraW9D?=
 =?utf-8?B?WE9YWEtocXl0MjJtdzArb2RGU1NueFhZOTJtK0RsaUdjM0RKUE9uWHJBMnNO?=
 =?utf-8?B?THBEclg5MjlhcmVnL0JmT0E1bCtBZ0o0Vjdsdy9kSm9sSWpJME1RYktBcTZ2?=
 =?utf-8?B?Uk5NT1g2ZUtXdGxuTE5nVWxnemlEOXA5TGZTcVZ4dUMwMnlLRVJBcHpYdllI?=
 =?utf-8?B?VUN4b0dqd1I1a2pRSmx3TkM0ZW80N0FZQTZlQmtuTm1FZUJTZDRNYThWZGJr?=
 =?utf-8?B?M3RxVXJxMGhlaHVLNjJINTVhazY5QmJwQzVPdUZKemd3cERqNGw0TFN5QUZW?=
 =?utf-8?B?d0hNUVBlZHNTZjNtc2wyOHJ4cTAzTjQzK2Y3MVFFZjVqMjBoNUROQTVkcWVz?=
 =?utf-8?B?QVJlK012NE5WTmJtNEFqUm9xQU13Wjl6OEdleWRhYWhaR0NOOFgzWFJuSDll?=
 =?utf-8?B?ODJVcjdmdHJyY3N6QjE4L21sdkNxSXI0cE01TGVNLzUyakNsSVhERGZuQjFo?=
 =?utf-8?B?R0JPa0MwTFMyTmw3MDR6aDV4UkIzVGJzb052VWlpaW1WbXZKbkZWUmVPRmFj?=
 =?utf-8?B?VkJoQVRTRUpDQU8weEp0UXVXZFpKZHQxYTNZbCtFeXpUL2dTYlhISXNXQlNF?=
 =?utf-8?B?Sy94Q3d4M202dng4ZXEzeml3c1IrYTE4SmcrS0F1dnFBakJNSmZQL3ZGaU95?=
 =?utf-8?Q?VHuMkUJDMEJo+rhGUYD5NvYnG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bcedb6-ff70-4679-0429-08dc7eb6da0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 01:38:18.6576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KXqPPZbLPVDloRheTIAPDNYDF8n8MHc6NHN277Lq1CvuI+N11/Tcmh0m6nlYgzYLdf5dEPpIz5WmfLAGCB2CWmUWdAbSQAgYr7/jY9wSzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5178
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCj4gSGkgSmFtaW4sDQo+IA0KPiBPbiAyNy81LzI0IDEwOjAyLCBKYW1p
biBMaW4gd3JvdGU6DQo+ID4gQVNUMjcwMCBzdXBwb3J0IHRoZSBtYXhpbXVtIGRyYW0gc2l6ZSBp
cyA4R2lCIGFuZCBoYXMgYSAiRE1BIERSQU0NCj4gU2lkZQ0KPiA+IEFkZHJlc3MgSGlnaCBQYXJ0
KDB4N0MpIg0KPiA+IHJlZ2lzdGVyIHRvIHN1cHBvcnQgNjQgYml0cyBkbWEgZHJhbSBhZGRyZXNz
Lg0KPiA+IEFkZCBoZWxwZXIgcm91dGluZXMgZnVuY3Rpb25zIHRvIGNvbXB1dGUgdGhlIGRtYSBk
cmFtIGFkZHJlc3MsIG5ldw0KPiA+IGZlYXR1cmVzIGFuZCB1cGRhdGUgdHJhY2UtZXZlbnQgdG8g
c3VwcG9ydCA2NCBiaXRzIGRyYW0gYWRkcmVzcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRy
b3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1p
biBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L3NzaS9h
c3BlZWRfc21jLmMgICAgICAgICB8IDUyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0NCj4gPiAgIGh3L3NzaS90cmFjZS1ldmVudHMgICAgICAgICB8ICAyICstDQo+ID4g
ICBpbmNsdWRlL2h3L3NzaS9hc3BlZWRfc21jLmggfCAgMSArDQo+ID4gICAzIGZpbGVzIGNoYW5n
ZWQsIDQ2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gPiArc3RhdGlj
IHVpbnQ2NF90IGFzcGVlZF9zbWNfZG1hX2RyYW1fYWRkcihBc3BlZWRTTUNTdGF0ZSAqcykgew0K
PiA+ICsgICAgcmV0dXJuIHMtPnJlZ3NbUl9ETUFfRFJBTV9BRERSXSB8DQo+ID4gKyAgICAgICAg
KCh1aW50NjRfdCkgcy0+cmVnc1tSX0RNQV9EUkFNX0FERFJfSElHSF0gPDwgMzIpOyB9DQo+ID4g
Kw0KPiA+ICAgc3RhdGljIHVpbnQzMl90IGFzcGVlZF9zbWNfZG1hX2xlbihBc3BlZWRTTUNTdGF0
ZSAqcykNCj4gPiAgIHsNCj4gPiAgICAgICBBc3BlZWRTTUNDbGFzcyAqYXNjID0gQVNQRUVEX1NN
Q19HRVRfQ0xBU1Mocyk7IEBAIC05MDMsMjQNCj4gPiArOTIxLDM0IEBAIHN0YXRpYyB2b2lkIGFz
cGVlZF9zbWNfZG1hX2NoZWNrc3VtKEFzcGVlZFNNQ1N0YXRlICpzKQ0KPiA+DQo+ID4gICBzdGF0
aWMgdm9pZCBhc3BlZWRfc21jX2RtYV9ydyhBc3BlZWRTTUNTdGF0ZSAqcykNCj4gPiAgIHsNCj4g
PiArICAgIEFzcGVlZFNNQ0NsYXNzICphc2MgPSBBU1BFRURfU01DX0dFVF9DTEFTUyhzKTsNCj4g
PiArICAgIHVpbnQ2NF90IGRtYV9kcmFtX29mZnNldDsNCj4gPiArICAgIHVpbnQ2NF90IGRtYV9k
cmFtX2FkZHI7DQo+ID4gICAgICAgTWVtVHhSZXN1bHQgcmVzdWx0Ow0KPiA+ICAgICAgIHVpbnQz
Ml90IGRtYV9sZW47DQo+ID4gICAgICAgdWludDMyX3QgZGF0YTsNCj4gPg0KPiA+ICAgICAgIGRt
YV9sZW4gPSBhc3BlZWRfc21jX2RtYV9sZW4ocyk7DQo+ID4gKyAgICBkbWFfZHJhbV9hZGRyID0g
YXNwZWVkX3NtY19kbWFfZHJhbV9hZGRyKHMpOw0KPiA+ICsNCj4gPiArICAgIGlmIChhc3BlZWRf
c21jX2hhc19kbWE2NChhc2MpKSB7DQo+ID4gKyAgICAgICAgZG1hX2RyYW1fb2Zmc2V0ID0gZG1h
X2RyYW1fYWRkciAtIHMtPmRyYW1fYmFzZTsNCj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAg
ICAgZG1hX2RyYW1fb2Zmc2V0ID0gZG1hX2RyYW1fYWRkcjsNCj4gDQo+IEhlcmUgcy0+ZHJhbV9i
YXNlIGlzIDB4MC4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gY2hlY2sNCj4gYXNwZWVkX3NtY19oYXNf
ZG1hNjQ/DQo+IA0KDQpZZXMsIGl0IGlzIHJlcXVpcmVkIHRvIGNoZWNrIGFzcGVlZF9zbWNfaGFz
X2RtYTY0IHRvIHN1cHBvcnQgZHJhbSA2NGJpdCBhZGRyZXNzLg0Kcy0+ZHJhbV9iYXNlIGhhcyBi
ZWVuIGNoYW5nZWQgdG8gIjB4NCAwMDAwMDAwMCIuDQpUaGFua3MtSmFtaW4NCg0KPiA+ICsgICAg
fQ0KPiANCj4gTWF5YmUgc2ltcGxpZnkgaW1wcm92aW5nIGFzcGVlZF9zbWNfZG1hX2RyYW1fYWRk
cigpIGFzOg0KPiANCj4gICAgc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9zbWNfZG1hX2RyYW1fYWRk
cihBc3BlZWRTTUNTdGF0ZSAqcykNCj4gICAgew0KPiAgICAgICAgcmV0dXJuIChzLT5yZWdzW1Jf
RE1BX0RSQU1fQUREUl0NCj4gICAgICAgICAgICAgICAgfCAoKHVpbnQ2NF90KSBzLT5yZWdzW1Jf
RE1BX0RSQU1fQUREUl9ISUdIXSA8PCAzMikpDQo+ICAgICAgICAgICAgICAgIC0gcy0+ZHJhbV9i
YXNlOw0KPiAgICB9DQo+IA0KPiBUaGVuIG5vIG5lZWQgZm9yIGRtYV9kcmFtX29mZnNldCwgZG1h
X2RyYW1fYWRkciBpcyBlbm91Z2guDQo+IA0KPiA+DQo+ID4gICAgICAgdHJhY2VfYXNwZWVkX3Nt
Y19kbWFfcncocy0+cmVnc1tSX0RNQV9DVFJMXSAmDQo+IERNQV9DVFJMX1dSSVRFID8NCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAid3JpdGUiIDogInJlYWQiLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHMtPnJlZ3NbUl9ETUFfRkxBU0hfQUREUl0sDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5yZWdzW1JfRE1BX0RSQU1fQUREUl0sDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfZHJhbV9vZmZzZXQsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2xlbik7DQo+ID4gICAgICAgd2hpbGUgKGRt
YV9sZW4pIHsNCj4gPiAgICAgICAgICAgaWYgKHMtPnJlZ3NbUl9ETUFfQ1RSTF0gJiBETUFfQ1RS
TF9XUklURSkgew0KPiA+IC0gICAgICAgICAgICBkYXRhID0gYWRkcmVzc19zcGFjZV9sZGxfbGUo
JnMtPmRyYW1fYXMsDQo+IHMtPnJlZ3NbUl9ETUFfRFJBTV9BRERSXSwNCj4gPiArICAgICAgICAg
ICAgZGF0YSA9IGFkZHJlc3Nfc3BhY2VfbGRsX2xlKCZzLT5kcmFtX2FzLA0KPiBkbWFfZHJhbV9v
ZmZzZXQsDQo+ID4NCj4gTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgJnJlc3VsdCk7DQo+ID4gICAg
ICAgICAgICAgICBpZiAocmVzdWx0ICE9IE1FTVRYX09LKSB7DQo+ID4gLSAgICAgICAgICAgICAg
ICBhc3BlZWRfc21jX2Vycm9yKCJEUkFNIHJlYWQgZmFpbGVkIEAlMDh4IiwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+cmVnc1tSX0RNQV9EUkFNX0FERFJdKTsNCj4g
PiArICAgICAgICAgICAgICAgIGFzcGVlZF9zbWNfZXJyb3IoIkRSQU0gcmVhZCBmYWlsZWQgQCUi
IFBSSXg2NCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2RyYW1f
b2Zmc2V0KTsNCj4gPiAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICAgICAg
ICB9DQo+ID4NCj4gPiBAQCAtOTQwLDExICs5NjgsMTEgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3Nt
Y19kbWFfcncoQXNwZWVkU01DU3RhdGUNCj4gKnMpDQo+ID4gICAgICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAgICAgIGFkZHJlc3Nf
c3BhY2Vfc3RsX2xlKCZzLT5kcmFtX2FzLA0KPiBzLT5yZWdzW1JfRE1BX0RSQU1fQUREUl0sDQo+
ID4gKyAgICAgICAgICAgIGFkZHJlc3Nfc3BhY2Vfc3RsX2xlKCZzLT5kcmFtX2FzLCBkbWFfZHJh
bV9vZmZzZXQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLA0K
PiBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCAmcmVzdWx0KTsNCj4gPiAgICAgICAgICAgICAgIGlm
IChyZXN1bHQgIT0gTUVNVFhfT0spIHsNCj4gPiAtICAgICAgICAgICAgICAgIGFzcGVlZF9zbWNf
ZXJyb3IoIkRSQU0gd3JpdGUgZmFpbGVkIEAlMDh4IiwNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcy0+cmVnc1tSX0RNQV9EUkFNX0FERFJdKTsNCj4gPiArICAgICAgICAg
ICAgICAgIGFzcGVlZF9zbWNfZXJyb3IoIkRSQU0gd3JpdGUgZmFpbGVkIEAlIiBQUkl4NjQsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9kcmFtX29mZnNldCk7DQo+
ID4gICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ICAg
ICAgICAgICB9DQo+ID4gQEAgLTk1Myw4ICs5ODEsMTIgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3Nt
Y19kbWFfcncoQXNwZWVkU01DU3RhdGUNCj4gKnMpDQo+ID4gICAgICAgICAgICAqIFdoZW4gdGhl
IERNQSBpcyBvbi1nb2luZywgdGhlIERNQSByZWdpc3RlcnMgYXJlIHVwZGF0ZWQNCj4gPiAgICAg
ICAgICAgICogd2l0aCB0aGUgY3VycmVudCB3b3JraW5nIGFkZHJlc3NlcyBhbmQgbGVuZ3RoLg0K
PiA+ICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICBkbWFfZHJhbV9vZmZzZXQgKz0gNDsNCj4g
PiArICAgICAgICBkbWFfZHJhbV9hZGRyICs9IDQ7DQo+ID4gKw0KPiA+ICsgICAgICAgIHMtPnJl
Z3NbUl9ETUFfRFJBTV9BRERSX0hJR0hdID0gZG1hX2RyYW1fYWRkciA+PiAzMjsNCj4gPiArICAg
ICAgICBzLT5yZWdzW1JfRE1BX0RSQU1fQUREUl0gPSBkbWFfZHJhbV9hZGRyICYgMHhmZmZmZmZm
ZjsNCj4gPiAgICAgICAgICAgcy0+cmVnc1tSX0RNQV9GTEFTSF9BRERSXSArPSA0Ow0KPiA+IC0g
ICAgICAgIHMtPnJlZ3NbUl9ETUFfRFJBTV9BRERSXSArPSA0Ow0KPiA+ICAgICAgICAgICBkbWFf
bGVuIC09IDQ7DQo+ID4gICAgICAgICAgIHMtPnJlZ3NbUl9ETUFfTEVOXSA9IGRtYV9sZW47DQo+
ID4gICAgICAgICAgIHMtPnJlZ3NbUl9ETUFfQ0hFQ0tTVU1dICs9IGRhdGE7IEBAIC0xMTA3LDYg
KzExMzksOQ0KPiBAQA0KPiA+IHN0YXRpYyB2b2lkIGFzcGVlZF9zbWNfd3JpdGUodm9pZCAqb3Bh
cXVlLCBod2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwNCj4gPiAgICAgICB9IGVsc2UgaWYgKGFz
cGVlZF9zbWNfaGFzX2RtYShhc2MpICYmIGFkZHIgPT0gUl9ETUFfTEVOICYmDQo+ID4gICAgICAg
ICAgICAgICAgICBhc3BlZWRfc21jX2RtYV9ncmFudGVkKHMpKSB7DQo+ID4gICAgICAgICAgIHMt
PnJlZ3NbYWRkcl0gPSBETUFfTEVOR1RIKHZhbHVlKTsNCj4gPiArICAgIH0gZWxzZSBpZiAoYXNw
ZWVkX3NtY19oYXNfZG1hKGFzYykgJiYgYXNwZWVkX3NtY19oYXNfZG1hNjQoYXNjKQ0KPiAmJg0K
PiA+ICsgICAgICAgICAgICAgICBhZGRyID09IFJfRE1BX0RSQU1fQUREUl9ISUdIKSB7DQo+ID4g
KyAgICAgICAgcy0+cmVnc1thZGRyXSA9IERNQV9EUkFNX0FERFJfSElHSCh2YWx1ZSk7DQo+ID4g
ICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICIl
czogbm90IGltcGxlbWVudGVkOiAweCUiDQo+IEhXQUREUl9QUkl4ICJcbiIsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGFkZHIpOyBAQCAtMTIzOSw2ICsxMjc0LDcgQEAN
Cj4gc3RhdGljDQo+ID4gY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfYXNwZWVkX3Nt
YyA9IHsNCj4gPg0KPiA+ICAgc3RhdGljIFByb3BlcnR5IGFzcGVlZF9zbWNfcHJvcGVydGllc1td
ID0gew0KPiA+ICAgICAgIERFRklORV9QUk9QX0JPT0woImluamVjdC1mYWlsdXJlIiwgQXNwZWVk
U01DU3RhdGUsDQo+ID4gaW5qZWN0X2ZhaWx1cmUsIGZhbHNlKSwNCj4gPiArICAgIERFRklORV9Q
Uk9QX1VJTlQ2NCgiZHJhbS1iYXNlIiwgQXNwZWVkU01DU3RhdGUsIGRyYW1fYmFzZSwgMCksDQo+
ID4gICAgICAgREVGSU5FX1BST1BfTElOSygiZHJhbSIsIEFzcGVlZFNNQ1N0YXRlLCBkcmFtX21y
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9NRU1PUllfUkVHSU9OLCBNZW1vcnlS
ZWdpb24gKiksDQo+ID4gICAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCg0K

