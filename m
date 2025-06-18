Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF7BC7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoYq-0004t1-I9; Wed, 18 Jun 2025 04:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRoYn-0004ry-Sg; Wed, 18 Jun 2025 04:54:21 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRoYk-0007Cq-2W; Wed, 18 Jun 2025 04:54:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZxxKEJJlTti4njl8MSAhsy3mawA2Cqnh62e4NCoBnGMRZW7yUIV+0AHDfVy7JP8VNr9Yqm/L7id4uRWX9l6nYcMswIEi5z0IgbmUf9hfn2Jwg5cq7/siFQTI4TCjDvJz1HMa87gW2O5a6WcB5/3CIeoUI6tfEyP12ibM5Ame7mwAnttU8KhVJirGB5H5ltzD2NkVgyrN+uiWgnK5w2sc5b4gqA1HLmSOZqNBuhpt5DVVh3WXg5CrbeG8srdq5gijxM0kEISw5Qq/eeJlnyfDkKWNG2ho6Hyk5N4XD2M+yl5JD8qeTRZgGJXYpZrESmloX1FWOYDYP7wVZ3RboQ1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klf3GdHbRcw5bJWrxhN4kXFWo11WWywwgmCdrQUD/rg=;
 b=Elji9AaRuypw599wO6IbuBIzZmrxql/JI1odkh2SxKobnPPj8b3/iyxX2/V7fBfpxnncBU5T5dMN97uSSsKXAPXTynmVWm4kmltOa1+k01rCTmTYLr0mBUlbj2qeFeljajhTh1qlEcQTXrJsSlhWVIusEe3axu+GSn/dIcgQlSkPRdG6vofIvSCNqy2lEE17i8MPcWuwg6ZfVEdHuk3/kPNYHy3SKTAW+J2fT630jc9kNzjRlh7Zh2L7pnoEMjI94p5YymdfB8WqrMTZ76Qr8ev+94W7A21cT3JYEDfr53FSomPaacbKpk5OykrM1bDtYy3B+72R1fzObmOEV6IeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klf3GdHbRcw5bJWrxhN4kXFWo11WWywwgmCdrQUD/rg=;
 b=fROS4QKrXGy/hlAOOKZJywtkNsFuL//4tQLxKNQdNSQFR7JXHj3V1jQrHvoFKwWcx6pgxLudhkO2z550dC8RKnAoZA5gOv0394jD2arYyU4RjuCRA5nXdlptm3Db2ffmYtA6Cirq37XfT7SX9lPT5DNZqVY90OafnVfdCKvCPDdBivr+SP5EY7kJ7oRHdFY0e34I4YKD+8JOy58RIjrYUxpTGzypkxkfJbje5hfsagSAJbhkfAVOA89GZWfEgaB5sURPCfCaGJEqKh5Y4yXTPmxE+e70Ad+kdbBhbkGZ1vW/wQROBRsa6qPyi+oLGqaAfIbe39tlAgIxh24l25jicw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM7PR09MB3976.eurprd09.prod.outlook.com (2603:10a6:20b:114::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 08:54:13 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 08:54:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>
Subject: Re: [PATCH v2 3/9] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v2 3/9] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb08AB0AGZl8+GykOQE9DkCQGBY7P8DekAgAyntYA=
Date: Wed, 18 Jun 2025 08:54:12 +0000
Message-ID: <632900c8-ae01-47bd-9f9b-9670d8ee5c48@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-4-djordje.todorovic@htecgroup.com>
 <37f95977-5d4e-4c58-bff8-f808aeaead07@linaro.org>
In-Reply-To: <37f95977-5d4e-4c58-bff8-f808aeaead07@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM7PR09MB3976:EE_
x-ms-office365-filtering-correlation-id: d4eaed5b-092b-4abb-0372-08ddae45b2a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3BUVDUrLzBWUUFRcVdiQzJQQWk1TEQ2QWs0SjNIQ204QnFucklrdmlnTGxy?=
 =?utf-8?B?cVRXRGNPWTFhL2V4dUJsZG80aFFNNThmMkpSWlRNR2FyUHVqTjhYQ0t3SnVG?=
 =?utf-8?B?cEFhWmpvSGIvZDM4VjljQ2dFSDdIS2NpcEdPYTdhd0FxcFowd3BQWDBpWkU1?=
 =?utf-8?B?OVI4b2dhdHhpMTNmRStQT3BwSm9qenBiS3VpckxYVEZEUTNjaU0xQjBoeklW?=
 =?utf-8?B?R09FK3NKL0dtM2srRG5DMkFGTWZ3ZmFXVnJVdVc0UVJZQjBjU3lZNXFtTkwz?=
 =?utf-8?B?SmdobzhyK0FCTG5hMy80RHQ3VjFjTjZzMmtaaHBpUkhCZEVWMXF2T1pmN3dl?=
 =?utf-8?B?WlA4YnNMeVI2OXI1VlRoRGtHOFZGQ0Z5bFpwc05WUksyQmV5TytDV2tiQ1hT?=
 =?utf-8?B?SkN3K3hqTlJYS0VYUGtEUjFuaVNvU1NHeDVNUlc2LzBWOVk4aUNBTDVQU1Bv?=
 =?utf-8?B?RlFERjA1c2JjU2s2RnYzWVFJVHRkWmhXUHBudXhmSDYvdFVsSkI5bUdKdkJu?=
 =?utf-8?B?Z3k0VEt5VmdHRUVSa1UybWlrV1ltd2ZYcm82b1ZXeWE3clBHWGRIbm5PbGtn?=
 =?utf-8?B?akpWYm02a0xMZ3RxRUozNjJHMUtsTTRrNDBrZlpCMlBWN0dFR3NmbXozRGc5?=
 =?utf-8?B?Vm9jSGJNUTVvWHM0YWYwOWVHNGxQTzdOQVVsZ1pPcGVxZVc3QUI3UmxZZDVq?=
 =?utf-8?B?a2lNU2hTSW9TTSt3Tlc4SUk2RmtZSCtmRVpUOURGZER4aGhMNm5jYVVEZThY?=
 =?utf-8?B?S1RSS1lVRE15OEJPelNnUVY2S0NQUTZQZGZpRFViYk1kYjl2YWtNYnJwcGNC?=
 =?utf-8?B?Tkw3S2Z0RmZKWGRhRHd1aVNUcUV3TzR5K3JrcHdxVGVlTEFEV09XVitXUmUx?=
 =?utf-8?B?VEw3S3lRblR3Nk1MazV4Y0wzcDY0WFBDOTZMZDlrdXRBd1ZTdTgvbmNSNmhl?=
 =?utf-8?B?TUVLV1IrdTdaZWljZkQxZi9JUERSUWIxd2ZLK0IvUkg0d09yY3RZM09xaGNq?=
 =?utf-8?B?elliUjZqTk41YkhUT0xGeTNzN0JFRDlMZFZ0S01jMUtMMVo2SEdsZGYyRGhh?=
 =?utf-8?B?WTB5bWFOVlRyU1FRcXZnQnkydzdDNUhyR3BuRnRaTUt6V3c2UXdYaWZvNnpF?=
 =?utf-8?B?R2pwSFJVSmMxMzVRMGo5U0YyMEdnZ0lrUGpINjcvYjdzOW5ZRVBzOElJWUhr?=
 =?utf-8?B?WkwralhmK3kyVGM1TS9uSklnNVN5VHVtbmF4aEU0Tmt4K3RXRFpWTGpOOFZU?=
 =?utf-8?B?WUpsekV2ZVFpaXFlNFdwRHBnR3R4b1JMSTBiWjV2NW5kMTc1VUNodCtvam1S?=
 =?utf-8?B?M2s0ZjJzUDFvMWJHSERmdHpIR2d5OHkvQ2dmQzFQTkZTSEJlK29DbHhyTW5m?=
 =?utf-8?B?SitvSFpTN0crWE1iWjUySGNKdzgxL0dud0VrYmNUMXBrYkNrbUNkV1VLUlp1?=
 =?utf-8?B?VVpqU3pyL1pxMjJ3V3JZREZjRWdLeEV1N21YMVNENkdBRDhWU0taZVFHZ2tT?=
 =?utf-8?B?Sk9lbFFvdTNQUjNrSWQ2M2tYRkdCZXhhWkhkWWFBdjY2LzYzdXNrU1dyMi9i?=
 =?utf-8?B?VXhoTm0zWXZ4aWdEYnJoNDlkUHcxc2RRbjVXNURMZVRRczMwcEFHVHh3dXZs?=
 =?utf-8?B?NUtIYTJYUGtISThPWWYycDVyZzM0QkdlUnBZU0tBaXJ4L09DeHIrTEVLN1ds?=
 =?utf-8?B?clhUOXAxQ3ZzVnYxZ1lzQ3ZzeE9leExuZVZYdnlqeVJMNGdJaGpsN3QvTFNw?=
 =?utf-8?B?Sjc5WXFIVzZsRVhsUlhHbXlJRmM0U2hOMDhwdityc0UvR21pN2V2dnBvdFZm?=
 =?utf-8?B?dTVYNEpiUjNpbnRqTWZzK05lYTN2WkxKS0oyeUsrZUJGTzM1MHVFd3ZTMDR0?=
 =?utf-8?B?L2prZ1hqUnJVU0toN2hjYWNpQlV0bTRhcjUxRURpRlpGYXBTcUlwaUh2WDRN?=
 =?utf-8?B?LzVmakppUzY0WW9sVWtrOWpHUDMvZU10am9vcE53TG1mbGxPbU9sQXd3dXly?=
 =?utf-8?B?Qml2alhseEZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y29SL20vZGpzdzBqNG9qTTFibnJzaXF2d3FGR2QwZnk2Ylp3SDF5bUpMayto?=
 =?utf-8?B?a2tHUjMzNW1hY2duUFM0RThveDRHb1lneVBjRllIWld5dUlLcXNicEl5TGMv?=
 =?utf-8?B?UTNJZEtNV1A1N0xWRWJHVStpRHEwL2JwNzBOZ2d5cWxlbzJQNDc4NDIyMUcx?=
 =?utf-8?B?L1hMSkFocHRiMjBGTGIwaWxmcFE3QlBxMmg0Q1lqbzdkdUEzam54ck0xS1Bv?=
 =?utf-8?B?bTRUWksybHYvb05MQUJZcGhXR0dLWUpWQW9DcHhBcFJsakVtYU1qM0VNNlBJ?=
 =?utf-8?B?Y1hkUE82M3dpMVgvaWNRWjhtVkZTZkp6ai9jb2pxbHhmSUFqbW5uTUgwejRF?=
 =?utf-8?B?TG9OTWpKQlJPdG10enFrVU9BSm1TSUtEb2ZacjBFKzVGd2dxZkFxZ2JUTEFh?=
 =?utf-8?B?dFRDYnMvdGtkV1Z6M0FxZ0lYbGJOcTRxYVE3Y2syWDAxZ3dJeXdFdWhVN09a?=
 =?utf-8?B?QnRrak55WE14WnpMQVBMb3JHN0FrVStWejJmT1NzR3V3ZXhyN1pFU0tkWEla?=
 =?utf-8?B?Nm1yYTIvMVhaWkhKWEk3d25DKzV1RGpHNWRPYWF3dXQ3eWFZMmZoMFFRR0hG?=
 =?utf-8?B?RkN5b0RUYU5KdlI5U2VvZ0M0UnFQR0hqN0haekhZWWxHaXFET3BpNlcxR29B?=
 =?utf-8?B?dno2TkpJRzJkcWZRRCtKdWRwdXFPaWp6KzV1OU13eERESWkrZUpxb25yZ240?=
 =?utf-8?B?d21rd1FWQjYzb0JoUmErNjhiWWxITXoyUktvNEFlTXE3cG5lbTJiZkdjYVBE?=
 =?utf-8?B?OWtEVllwaDFEc3Z5RFNFSUtyWXBaUGplSTU0SEpodzBjVGx4MDVWV1R3OEYy?=
 =?utf-8?B?NDl4eWUrOCtKc3VhekowOWs0bkE5Y0xOK2J0L0l5RDFmRUZSZTBmZE80RWtm?=
 =?utf-8?B?djFsQzZNNWhUWkNFV01ZVFpWZUNvSitSVzhZbTFqbmFGZEhFQ2dtcmNtd0tW?=
 =?utf-8?B?NHA3M2QwbnRNemJiaDlOS3dwV0JOeE5SWW5FZ2oyVDdXUDNST05wODBIQkE1?=
 =?utf-8?B?Qk40ZGNVY2JWWFFoOTVDK1dZR2NtUWNrcEVBYkQvUTgwUkxVVy9aa3FsK3BB?=
 =?utf-8?B?M3RpbW11T3ByR2FlZ3J5SG9BbkJna1Z4QzQ1ZHVCT2I2TVE4UFhRS1BsWm1x?=
 =?utf-8?B?Wmc1c3YyeFh3YWNBcjdYMGZEVWFSQmpYOUtHRWdTc1pvQjVhUU5qT1NxOTkr?=
 =?utf-8?B?S0hTQ1lDSExnenE4aWQvejRCMEt1ZmREelJRaUtITEg1QVZTamh4Rng4MlU5?=
 =?utf-8?B?a0RkMmMzUjZNTlJ5ZzRXVUNjNWlUMXByTE96WkhxQ3hzVi9LMERFenFCbTR2?=
 =?utf-8?B?MXNDWVA4dzIwSWloZGFnMTQxc2VuMmFwWWpYSWlvODJSRURSTWVsRzcwUlhu?=
 =?utf-8?B?VStzODdWYnpSVytOVDg5Q0dUVm9uOVhxcmEySG00dXBFL3RGZUQ1a045UWhS?=
 =?utf-8?B?T2sraURLb1VIVFFwQXZqbU1iSXc4aGxiSGVkNXg1bWVlU2tFMFh0YUFEUzl1?=
 =?utf-8?B?RW5CT3RVcnRHeTlHS1krOHZEYVBFTkxXVGlKN3o4VG1hcnhpS0xLS3JGQzUy?=
 =?utf-8?B?eXpsMlBGZjhmQ1JRM2NaR0JqZnlMdjRsWjcxYWRvbEE4OGthMEFoMlhuR3pE?=
 =?utf-8?B?RHNwQXNjMnhiY05pVDY3SHVMUmx1Z09rTFF5TjlOb1B0VlRFME93U1Excndr?=
 =?utf-8?B?eHVWVStGcDh3d0w5ek13bmJZV2FlSzVRZjhIWCtRVUEyaUJZS2M5eVVPNHNm?=
 =?utf-8?B?Z2czREJ6LytiQmIxSjh1Zlc3a0J2SllhNUxnTW9IK3RndlBrTkR3ODBqeVlm?=
 =?utf-8?B?K0V6MkJPbnZ1eHV2ZkVsY0piaWh5cy9iRmh0bCt5c3dpVVdSRlAvcElnYngx?=
 =?utf-8?B?anoyS2lrQXE1THAwYWMrV3grdW5PZzEreVBqc1FISE9QUTNuN3RFZXpvWkZn?=
 =?utf-8?B?NzM0eHpybHNTOVlYWkRlZmVJbElQVEhIZGpXaXJoQ1QwVzNUMk1landXQmV3?=
 =?utf-8?B?V05vK25SekkyZFExcEFXb0V2Ly9jQzhmbVZ5YkNvRjRBSDk4ZGlxeEVVZzZw?=
 =?utf-8?B?N1VrZEhGSUtnSG1tZit0eGR0NDFzeTh3NlJhcWViVy9IREdzUE1vQWxTSkh4?=
 =?utf-8?B?eWdrb1dGY1hvOU5UWHZhUmdGWUd1TFpCUlNvM2ZKN0pSZzVkWk1uU3lmTFly?=
 =?utf-8?Q?O1lBETAzNXzR9UE5sqe8zEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C7E69F9C9FB90479E97DC7BE6FF247B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eaed5b-092b-4abb-0372-08ddae45b2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:54:12.9840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIpdAUlE8FrE1GND/NOszMuKc3A0zZ/ov8s6pbZwYdwcIDz6yur14s6CGqgK96i6n6aNwCLCurDpMd0Zuysk5qHft5wtN7a1N47dXQ7NFiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3976
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQpPbiAxMC4gNi4gMjUuIDA5OjM4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4NCj4NCj4gSGksDQo+DQo+IE9uIDIvNi8yNSAxNToxMiwgRGpvcmRqZSBUb2Rvcm92aWMg
d3JvdGU6DQo+PiBJbnRyb2R1Y2UgTUlQUyBQODcwMCBDUFUgYW5kIHNldCByZXNldCB2ZWN0b3Ig
dG8gMHgxZmMwMDAwMC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvLXlpbmcgRnUgPGNmdUBt
aXBzLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRv
ZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KPj4gLS0tDQo+PiDCoCB0YXJnZXQvcmlzY3YvY3B1LXFv
bS5oIHzCoCAxICsNCj4+IMKgIHRhcmdldC9yaXNjdi9jcHUuY8KgwqDCoMKgIHwgMTYgKysrKysr
KysrKysrKysrKw0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUtcW9tLmggYi90YXJnZXQvcmlzY3YvY3B1
LXFvbS5oDQo+PiBpbmRleCAxZWUwNWViMzkzLi4xZTYyYjk2MDk0IDEwMDY0NA0KPj4gLS0tIGEv
dGFyZ2V0L3Jpc2N2L2NwdS1xb20uaA0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS1xb20uaA0K
Pj4gQEAgLTU1LDYgKzU1LDcgQEANCj4+IMKgICNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfVkVZUk9O
X1YxIFJJU0NWX0NQVV9UWVBFX05BTUUoInZleXJvbi12MSIpDQo+PiDCoCAjZGVmaW5lIFRZUEVf
UklTQ1ZfQ1BVX1RUX0FTQ0FMT04gUklTQ1ZfQ1BVX1RZUEVfTkFNRSgidHQtYXNjYWxvbiIpDQo+
PiDCoCAjZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX1hJQU5HU0hBTl9OQU5IVSANCj4+IFJJU0NWX0NQ
VV9UWVBFX05BTUUoInhpYW5nc2hhbi1uYW5odSIpDQo+PiArI2RlZmluZSBUWVBFX1JJU0NWX0NQ
VV9NSVBTX1A4NzAwIFJJU0NWX0NQVV9UWVBFX05BTUUoIm1pcHMtcDg3MDAiKQ0KPj4gwqAgI2Rl
ZmluZSBUWVBFX1JJU0NWX0NQVV9IT1NUIFJJU0NWX0NQVV9UWVBFX05BTUUoImhvc3QiKQ0KPj4N
Cj4+IMKgIE9CSkVDVF9ERUNMQVJFX0NQVV9UWVBFKFJJU0NWQ1BVLCBSSVNDVkNQVUNsYXNzLCBS
SVNDVl9DUFUpDQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jp
c2N2L2NwdS5jDQo+PiBpbmRleCA2MjlhYzM3NTAxLi41MTlkMjM0NWI4IDEwMDY0NA0KPj4gLS0t
IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+PiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4+IEBA
IC0zMTY3LDYgKzMxNjcsMjIgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHJpc2N2X2NwdV90eXBl
X2luZm9zW10gPSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmNmZy5tYXhfc2F0cF9tb2RlID0g
Vk1fMV8xMF9TVjM5LA0KPj4gwqDCoMKgwqDCoCApLA0KPj4NCj4+ICvCoMKgwqAgLy8gTk9URTog
V2hlbiBzcGVjaWZ5aW5nIENQVSwgc3BlY2lmeSBgcmVzZXR2ZWNgIGFzOg0KPj4gK8KgwqDCoCAv
L8KgwqAgLWNwdSBtaXBzLXA4NzAwLHJlc2V0dmVjPTB4MWZjMDAwMDANCj4NCj4gRG8geW91IHRo
aW5rIHVzZXJzIHdpbGwgZ28gcmVhZCB0aGUgY29kZSBmb3IgY29tbWVudHMgYmVmb3JlIHVzaW5n
IFFFTVU/DQo+IChwbGVhc2UgcmVzcGVjdCBRRU1VIGNvZGluZyBzdHlsZSkuDQo+DQo+IE1heWJl
IHJlc2V0dmVjIGhhcyB0byBiZSBhZGRlZCB0byBSSVNDVkNQVVByb2ZpbGU/DQo+DQpUaGlzIGlz
IG5vdCBuZWVkZWQgYW5kIHRoZSBjb21tZW50IHNob3VsZCBiZSByZW1vdmVkLg0KDQpBbnl3YXks
IHdlIHdpbGwgYWRkIHRoZSBkb2N1bWVudGF0aW9uIGZpbGUgZm9yIHRoZSBNSVBTIENQVXMgYXMg
cHJvcG9zZWQNCg0KaW4gYW5vdGhlciBwYXRjaCByZXZpZXcuDQoNClRoYW5rcyBhIGxvdCENCg0K
Pj4gKyBERUZJTkVfUklTQ1ZfQ1BVKFRZUEVfUklTQ1ZfQ1BVX01JUFNfUDg3MDAsIFRZUEVfUklT
Q1ZfVkVORE9SX0NQVSwNCj4+ICvCoMKgwqDCoMKgwqDCoCAubWlzYV9teGxfbWF4ID0gTVhMX1JW
NjQsDQo+PiArwqDCoMKgwqDCoMKgwqAgLm1pc2FfZXh0ID0gUlZJIHwgUlZNIHwgUlZBIHwgUlZG
IHwgUlZEIHwgUlZDIHwgUlZTIHwgUlZVLA0KPj4gK8KgwqDCoMKgwqDCoMKgIC5wcml2X3NwZWMg
PSBQUklWX1ZFUlNJT05fMV8xMl8wLA0KPj4gK8KgwqDCoMKgwqDCoMKgIC5jZmcubWF4X3NhdHBf
bW9kZSA9IFZNXzFfMTBfU1Y0OCwNCj4+ICvCoMKgwqDCoMKgwqDCoCAuY2ZnLmV4dF96aWZlbmNl
aSA9IHRydWUsDQo+PiArwqDCoMKgwqDCoMKgwqAgLmNmZy5leHRfemljc3IgPSB0cnVlLA0KPj4g
K8KgwqDCoMKgwqDCoMKgIC5jZmcubW11ID0gdHJ1ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoCAuY2Zn
LnBtcCA9IHRydWUsDQo+PiArwqDCoMKgwqDCoMKgwqAgLmNmZy5leHRfemJhID0gdHJ1ZSwNCj4+
ICvCoMKgwqDCoMKgwqDCoCAuY2ZnLmV4dF96YmIgPSB0cnVlLA0KPj4gK8KgwqDCoMKgwqDCoMKg
IC5jZmcubWFyY2hpZCA9IDB4ODAwMDAwMDAwMDAwMDIwMSwNCj4+ICvCoMKgwqAgKSwNCj4+ICsN
Cj4+IMKgICNpZiBkZWZpbmVkKENPTkZJR19UQ0cpICYmICFkZWZpbmVkKENPTkZJR19VU0VSX09O
TFkpDQo+PiDCoMKgwqDCoMKgIERFRklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVfQkFTRTEy
OCwgVFlQRV9SSVNDVl9EWU5BTUlDX0NQVSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuY2ZnLm1h
eF9zYXRwX21vZGUgPSBWTV8xXzEwX1NWNTcsDQo+

