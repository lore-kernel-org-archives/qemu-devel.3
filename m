Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B672FEFB49
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxAq-0005iI-0X; Fri, 27 Feb 2026 07:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvxAo-0005i2-Vv; Fri, 27 Feb 2026 07:42:27 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvxAn-0000sY-BB; Fri, 27 Feb 2026 07:42:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNYmVfzttxCauARcx6qyIUwfsYAlqNMuqngwEg1i974mKPdHS2wJJ9zhzAJ7D9+jGL4QisQjHY9wLZHLNOi6i7dFw2+57w60zjz7nsLQ712AwN4fAoM+C6WugXLU9V5dbp5jdzXxYC0qfg9zTcUI1Gf0gmhflguDi/Uk23w/E7KgNll09Fqb6CcoUfIF8PIL92yEew5K3lxCmbQJkvyvCp0Pv/Yg+K3209T5rw2QxCwQdNX5ha98pNBfDBEyKd19JzVgTZXltXVm2VF38zl2ObGEquaroB13TAiL4+iykqxJJE+V7VzdZYrUxB+HMOGc6trf/8SlVfJsWH9rmeGE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPIc0LOT3HENDwIfPKMjcpGBcLBLysWlS1m+7aTRh4E=;
 b=Ls0UC97eQF9NQmiajIARXDOAkJabIFHO38k8U8AHTXYzhMJPHYh+PKGc3o72y+Vyuhcv9lEarQjImPBvLg9PaMi1xBLI9PF+NWoT510r34XfbfKT0pqLyKt6pCxyAnJtlfdEOZ7DsYLHXGKWyqTVSWUH4MvlXjm9G3MulS6tEmdWzS5BWHvueeWu4S2FAnMM8UOJufAr7frGtDaRuyuN5QDfp906tFz7G4H3/V854sfGoZFh5NnC617OGyJaI7OoNkIY2Pbsz2Or/CcCUb2fAsB2ANDiaFUllF8bVCEDL87H3Hb3o0pmivHzhgCYl366klDn+1KlgfkxlHZk7qhPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPIc0LOT3HENDwIfPKMjcpGBcLBLysWlS1m+7aTRh4E=;
 b=efPwGE1taiMTb4vbUYIL+94G6CtvRgN/bPWtctdZ4uW5bC3tew2soHWEy0/BPrsXyKu26iyxQVMG5dfkfK7eU1BdnbPpz661A7zNocoEwwkuvMIhCGfmMg3Lqc93bHfmtmpS3GbMGx/PZL9ze/Zc8tkdEsZ/PxKGH0hK2y1TlNuR1CZQVc5D7GmU7wDsGmKQIzIM21Bp6PGR/BGTig04Yl8jAbtl2za7Ix4QldbxYIQLWfpaqDecairDGR4/CrPIh4FTVYths7/ow+gxqG0BC9V5iKkX/aLQt88PmKieYAxONJWMVoB6LxbiaUPMVUmtcGkvAID0XdPMHZiThPnjXw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by AS8PR09MB5880.eurprd09.prod.outlook.com (2603:10a6:20b:54a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 12:42:21 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:42:21 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>, Conor Dooley <conor@kernel.org>
CC: Mohamed Mediouni <mohamed@unpredictable.fr>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Topic: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Index: AQHcpkBaA1l4l1CIU02NL47xpBxJMLWTSjoAgAJY6wCAAATbgIAAE2KAgADFJIA=
Date: Fri, 27 Feb 2026 12:42:21 +0000
Message-ID: <de767b4f-93f2-47b1-8813-d1c063a30759@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
 <20260226-hangout-satin-fd7913f18f2b@spud>
 <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
In-Reply-To: <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|AS8PR09MB5880:EE_
x-ms-office365-filtering-correlation-id: 5b7768f6-2781-4c81-34ea-08de75fda6ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: JlkSo+LgrH+51rcVkVMePy3ER2ipXthYYXFoFWNsaxDarR1DaMGNiuKh4kbwuX5c0xrUpO+VHpGUFapAm3LEpuF7KUahMRGOB9LUdOH+nHgRhA3fJYi3rNq0Hmn5om19Tq5gpQiZ2Orr5o52vM/DUrcfSpecYVxzmW/mKdaphvE3Bk/wsCWvgnu/ecsQ/1uMZ56lwY/H+90HaTfXCepfCy7xp45Z1AFHY+7cC3wG140bUq7a0xQHi4P190Inq4EVepjoHJA3Zu1lJOYJwnYi7UevrnlBvNU88Pc9ezDmLOSeJTfksV/K6TBJ140N3gtQxI0xwLo/VhtK8BRO1EFTSwXzErvotUamrk39RBgLdes9t8CTgLLxzgy4+YoNnZXeGcvsdMKiJuS7fnPpxwCNY2uNeICbX2aUJrVuwKpJVOFDjQ4XAu4Nv7IsCfISfEXjtJlju+FTL76vFk6VLWF4PVp0HNtiwZLeBJrtCLAKJVFsrnTKUM+GoGv10NLF+4/CEfujbmfmSt/OtuY+87+ojmBr6hCce37pqCyHVLolA1UIC0i7uuUyZKOxUbuZ7YB4cqPWrVKuxp4+JaGQlO3Y3pgNzQhC0gAKoJKP5MeIPfHxSQ6KMkuFVzcFHnP8mqSYMjhBuROTv5B57Yn/33zJDFdCFpIwC7/hzMsnHuQNFc3LexeroUrC5EA97hxqctDiYEGyyGcjyEA1EKVljC8QU6ztBEuXVvTGYaHpwRGil61MfBQHQk9cookpitqbM2G/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWNwZG9NeWUxVHVKNUFCYmh4amJxdFZvYkRJZkM3dDhESEEveDhJZWlaWHZs?=
 =?utf-8?B?bmVwWVVxMUtnR1lRam5nNmtpdG5yM0s4RWJxSFkxejZKTmlIVlN0WnZabDBT?=
 =?utf-8?B?MXRYdWozd2ZCUUlpZkQ0R1BIaTZRV3JRRXZsVWg1eUtMbEUxSHpTV3YxbGVS?=
 =?utf-8?B?cGFsZEhwcFhYbVN4N0tvL0Zlbm9pSjA3Q1Fpay85bDFJQUxzYk8zTGlJYjBU?=
 =?utf-8?B?cEo4REFJWlFzY3FrZUN2U0o0TGpvWGNkUlY1Sloyd0ZzRFVKNWNUaVNTYk91?=
 =?utf-8?B?My83THdVMzRQV2lZUWlWWDA0cVJVanVMVFE0ckQrV04zajA4Smh1TEN6VzNH?=
 =?utf-8?B?T0YyR0JrL0lQZDM2QUtGSlVRaDZOY2xDM2JKWHoyYTlxZ3grRTArNzIxSFdQ?=
 =?utf-8?B?dUptMThwSURTT0ExZzYrbklNNHpLanJDMkwwa3pzbE41Y2N6bGJZSndSTkh6?=
 =?utf-8?B?MG9ZajFrbStXTU1yRmdSRWVRRkRuRzgxM09MaHVxdXpNRk94SVpPc3pSSFZV?=
 =?utf-8?B?c200L0dndUFNS0JVVjM4cWlzUC9hV2J1R1BSTW1TTDdHM3N1eGxFbkxzUGNP?=
 =?utf-8?B?YW1Edkt0V2J5TUN2Wll3TEVTekFxWTREVG5lQ0NHQ0EzSGhaNkRmWDlzRjdL?=
 =?utf-8?B?S1RqcFZHTWJHa25ya093QW5WaWYxOGNoTWpkQ3IxQSt3cGhGcExkZTVjL1c3?=
 =?utf-8?B?ekVrYkhoRlNNNnd1MldWVk5JNklhNVJmeW5HNnJmUGlCZnpPNzBHbWgyZ3Y3?=
 =?utf-8?B?VVljZkxQT3FhYk50VSsrUnA0RGI3NGh0WmIrdktDek5pQmUrM2xRUjVHYnU3?=
 =?utf-8?B?d2hSb2pYOThoWk12UE5RMzNoQWVaNE9McDYzS2gzajEwcExaeHZuL0VaNVdZ?=
 =?utf-8?B?R2RKM2tNR09NMno0aWVtcktLT3E0WVVPSFpDOCsvK0EvaGpWSWwyL0orK1Vm?=
 =?utf-8?B?ZkhnZDJDY2JqZ04yUk5WTGtGLzlEckpTQ1B1SXFEVDVqY0MvMk9kMFRMU2p0?=
 =?utf-8?B?MzlaR1FBL3dNMGpQNmxrRWs1VHo4NGNlV2J5dlBrUUVEWlIyU3VlSVdHckQr?=
 =?utf-8?B?azd3MFh1YkcyYzR5UXJNVnA0SkZ6VE5FbVFtd1F4Z0h0VzI1dHhueTZtaWI0?=
 =?utf-8?B?akQ2VEw4NThvSmVZbUNURisxWkRESURmSURVVFZXK1AyYWRJa0NUOUtLc2xC?=
 =?utf-8?B?VFN5SnBpcmg3UVZjRHJHTHZLdVcwbnBzVHlXVS9wWFZQMGtQNEJ0NHczaXhm?=
 =?utf-8?B?eHhhWHE5ekJhTkxBWDlxamo1WmcvR1VZcWQxSW1SbEtva2c3MFovZy9FMm5q?=
 =?utf-8?B?REFxQ05oRStrWkl1azJjckpHbTJ0YStFWUYwU3lEMGVidE5renhna0kzUG5w?=
 =?utf-8?B?c3AxbWtkOGUvdmV6NTBrVTR4QXE2Uzd1RDE5a2NnL09lNExVQVR3MEd5Nlp6?=
 =?utf-8?B?dUgvNDJNMGhManlkdkNBTkhaRzZpNlg3WjRaZ0ZCWXl6aUxOZ1pBT2k5YkNa?=
 =?utf-8?B?ZjQwUEVjaXV0ZEV4TlBkN0RIdGZZaVlsaVQ0enVYZFBTaE5EWHlacldPWmtC?=
 =?utf-8?B?RElMTVVpK3kzbTFDNE44TjgzODNtc2FtMzY2NnQ4MmFXYnd3VEpwT21sNUl6?=
 =?utf-8?B?bGNNWDcvdUYyeTcxTmljT2NqMkZYQ3h6OU5mWWhnMUF3YWx5KzVyN0hLVS9i?=
 =?utf-8?B?QVB3V3B5ZlBBbHJBdFNFVnRIWmErN1F4QzVzWmtORmtsYTVpeWhwZHFJdmR5?=
 =?utf-8?B?VEd1WklBRjVqeWtVbnFrcTZvSHJJb2dYTHZPaktIT1lZK2pHZFJFU1JVcHlS?=
 =?utf-8?B?bnQyb0M3eWVEdXV6RXJFaGZBV2FrSTBTSWI1a3dDYXFCQmVIK3ZCZUhKRW1l?=
 =?utf-8?B?Y2crT1pSbm9hT0ZrNkEvSitjMmhta05wLzVIRFpsWHcwKytWWW1QOVQ3V2g0?=
 =?utf-8?B?OE9GaGpVam1WL2xGOFNXOC9kVGdqd1YwbCtDWmxEYW9Ha1pHVHRnb1FweFpD?=
 =?utf-8?B?V2dYc0ljRGhPZU1UeFg1L3llNTZLLzllaEdsSWtjY0dLNlZYMVpnQnVzUGN3?=
 =?utf-8?B?c0pvL0hNV3liU05TUERMcHZRcHUyM25GQ1dMdmgwSUZvdkRuNGU1dzZlNG1T?=
 =?utf-8?B?RjFqSlQ4Y1Q4VFJLa1FEU3VKTXRlTVNMQUplaGJtSTgrSmZTUndRdk4zQTVt?=
 =?utf-8?B?ZW0vZDJjdkxuNmNIN0lEYlhrd0JEejFlejd6blhlK1Y2WGtWd2REOTVtQ3dW?=
 =?utf-8?B?RVdGSVNNVStGdHM1SEs0YXQzbWRQMWYvdTdOd2NvdzNGejVUVDVzTDk0cmFI?=
 =?utf-8?B?N21yRmZXMlN4YkF1N1VBSGE3TUxNaU9Majcvd3dSL0dtSDIvd0duU1VqcGx2?=
 =?utf-8?Q?AKlQzYF4m85rc5UHJR7ORROx9OKfMZNCfElK/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B5B413D0EE843428E73375B307A9057@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7768f6-2781-4c81-34ea-08de75fda6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:42:21.6690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adQj/0Ip5E4rv4rebwObdCz2bYmFl+9jY32YY32bMyYVqYfSB+Uw0hKn+SI65sOUxpaZIrvJeUk06s5PeBtQugwbawpOPU0chbkFF0yvHTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5880
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

DQpPbiAyLzI3LzI2IDAxOjU2LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9OOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24gRnJp
LCBGZWIgMjcsIDIwMjYgYXQgOTo0N+KAr0FNIENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+PiBPbiBGcmksIEZlYiAyNywgMjAyNiBhdCAwOTozMDowMEFNICsxMDAwLCBB
bGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPj4+IE9uIFdlZCwgRmViIDI1LCAyMDI2IGF0IDk6Mzni
gK9QTSBNb2hhbWVkIE1lZGlvdW5pDQo+Pj4gPG1vaGFtZWRAdW5wcmVkaWN0YWJsZS5mcj4gd3Jv
dGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+PiBPbiAyNS4gRmViIDIwMjYsIGF0IDExOjIwLCBEam9yZGpl
IFRvZG9yb3ZpYyA8RGpvcmRqZS5Ub2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4gd3JvdGU6DQo+Pj4+
Pg0KPj4+Pj4gVGhpcyBzZXJpZXMgYWRkcyBiaWctZW5kaWFuIChCRSkgUklTQy1WIHRhcmdldCBz
dXBwb3J0IHRvIFFFTVUsDQo+Pj4+PiBjb3ZlcmluZyBib3RoIHNvZnRtbXUgYW5kIGxpbnV4LXVz
ZXIgZW11bGF0aW9uIGZvciByaXNjdjMyYmUgYW5kDQo+Pj4+PiByaXNjdjY0YmUuDQo+Pj4+IEhl
bGxvLA0KPj4+Pg0KPj4+PiBUaGVyZeKAmXMgbm8gTGludXggUklTQy1WIGJpZyBlbmRpYW4uIE1h
eWJlIHRoZSByaWdodCB0aGluZyB0byBkbyBpcyB0byBub3QNCj4+Pj4gc3VwcG9ydCBpdCB1bmxl
c3Mgd2XigJlyZSBzdXJlIHRoYXQgaXQgY2FuIGdldCB0byBMaW51eCB1cHN0cmVhbSAoZm9yIHRo
ZSBsaW51eC11c2VyIG1vZGUpPw0KPj4+IEFncmVlZC4gV2UgcmVhbGx5IG5lZWQgdXBzdHJlYW0g
TGludXggc3VwcG9ydCBiZWZvcmUgdXNlciBtb2RlDQo+PiBPbiB0aGF0IGZyb250LCBCZW4gcG9z
dGVkIHBhdGNoZXMgZm9yIGl0IGFuZCBMaW51cyB3YXMgcmVhbGx5IHJlYWxseSBub3QNCj4+IGVu
dGh1c2VkIHdoZW4gaGUgYmVjYW1lIGF3YXJlIG9mIGl0Og0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtcmlzY3YvMDY2ZDcwYzctYjBhNy00NWU1LTkzMzctMTc5MDFiYzk1NjY0QGNv
ZGV0aGluay5jby51aw0KPj4gRXZlbiB3aXRob3V0IExpbnVzJyB0YWtlLCBJIGZlZWwgbGlrZSB0
aGVyZSdzIGFic29sdXRlbHkgbm8gY2hhbmNlIG9mDQo+PiB1cHN0cmVhbSBzdXBwb3J0IHdpdGhv
dXQgbWVhbmluZ2Z1bCBzaGlwcGluZyBoYXJkd2FyZSB0aGF0IHJlcXVpcmVzDQo+PiBiaWcgZW5k
aWFuIHN1cHBvcnQsIGJlY2F1c2UgYmFzaWNhbGx5IGV2ZXJ5b25lIGVsc2Ugd2FzIGFsc28gb3Bw
b3NlZCB0bw0KPj4gYWRkaW5nIGl0Li4uDQo+IFllYWguLi4gSSBzYXcgdGhhdC4NCj4NCj4gQSBm
ZXcgdGhvdWdodHMsIGp1c3QgYmVjYXVzZSBMaW51cyBkb2Vzbid0IGxpa2UgaXQgZG9lc24ndCBt
ZWFuIFFFTVUNCj4gY2FuJ3Qgc3VwcG9ydCBpdC4gQnV0IEkgYW0gaGVzaXRhbnQgdG8gc3VwcG9y
dCBCRSBjb25zaWRlcmluZyB0aGUgbGFjaw0KPiBvZiBlY29zeXN0ZW0gc3VwcG9ydCBldmVyeXdo
ZXJlIGVsc2UuDQoNCg0KUGxlYXNlIGJlIGF3YXJlIHRoYXQgTUlQUyB3aWxsIHNoaXAgaGFyZHdh
cmUgYmFzZWQgb24gcmlzY3YgQkUNCg0Kc29vbjrCoGh0dHBzOi8vbWlwcy5jb20vcHJvZHVjdHMv
aGFyZHdhcmUvaTg1MDAvDQoNCg0KVGhhbmtzLA0KRGpvcmRqZQ0KDQoNCj4gVGhlcmUgYXJlIGEg
YnVuY2ggb2YgY2hhbmdlcyBpbiB0aGlzIHNlcmllcyB0aGF0IGNvdWxkIGVhc2lseSBnbyBpbnRv
DQo+IFFFTVUuIFRoZXkgYXJlbid0IGludHJ1c2l2ZSBhbmQganVzdCBpbnZvbHZlIGNoYW5naW5n
IG9yIHVzaW5nIGhlbHBlcg0KPiBmdW5jdGlvbnMgdG8gaGFuZGxlIGVuZGlhbm5lc3MuIEkgdGhp
bmsgdGhvc2UgY291bGQgYmUgc3BsaXQgb3V0IGFuZA0KPiBnbyB1cHN0cmVhbSwgcmVkdWNpbmcg
dGhlIHNpemUgb2YgdGhpcyBzZXJpZXMgYW5kIHJlZHVjaW5nIHRoZQ0KPiBtYWludGVuYW5jZSBi
dXJkZW4gb2Ygb3V0IG9mIHRyZWUgcGF0Y2hlcy4NCj4NCj4gVGhlIGNvcmUgQkUgc3VwcG9ydCBp
cyBhIGRpZmZlcmVudCBwcm9ibGVtLiBCdXQgaWYgc29mdG1tdSB3b3JrcyBpbg0KPiB0aGUgZXhp
c3RpbmcgYmluYXJpZXMgdGhlbiBtYXliZSBpdCdzIHdvcnRoIGFjY2VwdGluZy4gbGludXggdXNl
ciBtb2RlDQo+IGlzIGEgd2hvbGUgb3RoZXIgcHJvYmxlbSB0aGF0IHdlIHByb2JhYmx5IHdvbid0
IGJlIGFibGUgdG8gYWNjZXB0Lg0KPg0KPiBBbGlzdGFpcg==

