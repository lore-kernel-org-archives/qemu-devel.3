Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0FC021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 01:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmkAp-0008TF-02; Mon, 24 Feb 2025 20:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yumin686@andestech.com>)
 id 1tmkAj-0008SU-An; Mon, 24 Feb 2025 20:55:45 -0500
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yumin686@andestech.com>)
 id 1tmkAg-0004j3-MN; Mon, 24 Feb 2025 20:55:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7k51QAmx7qVKQcqV7Org/f6TM2tf5tShqDMmNiwztU2L742QIN/ECPjiwq6fN5islxT1QhkA6Y0/yMl3rtSFdYNc8ORFiZ5LfRn4ppkjcjsa16DvL4A5HcWSDHcHhc/uJCZCI0h86zQb2PsfZS9NsDIKvevNh9tXNt8fWIBrUsV7JkyF4sCP1UNQKUK47xdzCdid++B01OLWPEOjpB8uIN6h2wKnqB7YTU62slz7SaWpuaXpvP515UjSGEPLfRHyfHmSABFMepwZU0VZjQc83p2LWUzdFh7vRiVjCM5sD7BAjyyj7P02EykqYwZ93Totk9LYxpqb2n9hnxHXTy6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0RTx41JudaF6Xr1HurlJjMZexIfeLw4+hI1mXImQKs=;
 b=QlKJf+N1uwngAwemVdhXCxO8RphYb0OhyPz/dqx7sQurNoghDavRKLd37QITWT9106y3aMJqX3fZaI2K0h/R+QzezYTQIgQ7NB+7YS7CxUgbijBOVB3AeTrIjM5LeRjR7TswuDSU246MYU+JdkiLrYAGiRzmMBlJC76yqrLt76F8p+4eNyJ6/GSKv8NNEiwVAxG/C9h2j0vBXz3FpyUn5Bv6yc/HrWot74TPxGYgShcOPA6q23ofctjU4QEeyO4XYNK9EAaw36G9DA6Ns+pG9RVe9mZ0QqDePPNWx+1OZIJJCf+q51l+my2HCBxbaLzdN7EESyiUyyIPOLYcUQFo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0RTx41JudaF6Xr1HurlJjMZexIfeLw4+hI1mXImQKs=;
 b=cv4CqBYS0Bs2KnhFGpPz6ufbWss1Th0xvaXdUzzetnOXojQOc5SQb3sHeWGTQL3oqUm/PULNEPOiWOQWgzC1CGnhNbL9EcSIGhptMTdXLDGzm41f+blh/kJ7VgNaspT64ErwZTiAgj7CtryPmqZOMYd4k9Df+04qRfXZx46HWdcv0QcRQZNSLtQNQUkkEtyXHwH7AbdG6HSBeWdz1kGEo0h0wOGSudXfqvS2X20jWb6oKJfaYS9J4oXw9wTowssysGG9ZasRFcMzQDpt+hhkIqQcknrZ13OUXYY5GKngG/7zFTCmheWyG06zJU/L7iSZeqxrxBIYBEFxnJzaQ+33Yg==
Received: from SI2PR03MB5674.apcprd03.prod.outlook.com (2603:1096:4:155::6) by
 SEYPR03MB8029.apcprd03.prod.outlook.com (2603:1096:101:16e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 01:55:24 +0000
Received: from SI2PR03MB5674.apcprd03.prod.outlook.com
 ([fe80::6ad1:634f:be60:2336]) by SI2PR03MB5674.apcprd03.prod.outlook.com
 ([fe80::6ad1:634f:be60:2336%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:55:24 +0000
From: =?utf-8?B?WXVtaW5nIFl1LU1pbmcgQ2hhbmco5by16IKy6YqYKQ==?=
 <yumin686@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH qemu v2] target/riscv: Check ext_zca for misaligned return
 address of mret/sret.
Thread-Topic: [PATCH qemu v2] target/riscv: Check ext_zca for misaligned
 return address of mret/sret.
Thread-Index: AQHbhm6eD46m+i5t+0+21ItU52hk+bNXQqPA
Date: Tue, 25 Feb 2025 01:55:23 +0000
Message-ID: <SI2PR03MB56744699F20F2B68F4BE09B88CC32@SI2PR03MB5674.apcprd03.prod.outlook.com>
References: <173856049155.9683.4580810619712230382-0@git.sr.ht>
 <CAKmqyKOOoYpdJVDk=7+iehteoOrPsHJ4FSWqqHAeWK3HiC0GHw@mail.gmail.com>
In-Reply-To: <CAKmqyKOOoYpdJVDk=7+iehteoOrPsHJ4FSWqqHAeWK3HiC0GHw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5674:EE_|SEYPR03MB8029:EE_
x-ms-office365-filtering-correlation-id: 186d99c5-ce5f-4977-1b5d-08dd553f77f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NW5sblpGZDVud2JKbXI1UER1cFNOK3A5azFVNE16MmcvdkRkUU9WYlRmVVV3?=
 =?utf-8?B?NkxMNUpvNld4UTAyTWhkUEl6dzhZczVNQlZ3bzg4UUJSbE5xRFN3OUc4VFZ4?=
 =?utf-8?B?ZDhkNDk2SUtXL0NlbEtOVnpxR3A4cjNNN2Q2M2E1ZHlsZ0R2R2t6WmZHekY1?=
 =?utf-8?B?OE1WbGxVeEhwMjN5Q3k4ZVhMWXkrQm80Tzh4dlEwU3ozNEUzRjFUMGRLRjdC?=
 =?utf-8?B?V2V2LzZQdld3NS9rK1lLRHNCZFhGU1U2eWJGWGZVSDZxR2lFY0xBellLYU5H?=
 =?utf-8?B?dEJYTGMvQkkwbUpwb0MzN1NNTWdQanZaOUlEOEs1YTZNWWJnTkErdnk3MlZj?=
 =?utf-8?B?bkRMVkpBMVFrWVptck5NaUlRMjlYdzFJNFEzc2hhdjE5TlYzSEhZU1VkQ2xt?=
 =?utf-8?B?VzhoTHVuVXcwdi9icGhQVGxBbVltK2FmQzJYMHdiN3VlNGVoUGRmN0VIN1FF?=
 =?utf-8?B?cHoyLzZ1Vk12SUtOeVlTVGF1ZTQ4YW1PWGJ6SENkUFNKcDBtVTdNVUdLZDVN?=
 =?utf-8?B?L3VVbVJmWmtZT2pBaHordHNUM2FqTFhmR2JaSnJxdEc0WS8wTWdjbGgzSGpO?=
 =?utf-8?B?MWxzS0tQMUlBSm5zanp4UWJMOE9oYTU5N3NNZUlBK3NhOURneFhtVWtsT1k2?=
 =?utf-8?B?eUJET0VrZzg1OWZTb1ZsMzJ2VDl3cmF2ZDM0OG0xVDN3VmdHc2krR1h4Rk1Y?=
 =?utf-8?B?QTZMWmlEYjFYUTNRYjNEL2JqVUxxQ0Mya1liYm9XY1pMeW9VTEppcXlPLzJ3?=
 =?utf-8?B?bW5wL3ByeVpUNzM1RjUyb0dTTXpKN2M2a2pPNmtBZzlwbUtHRUtRS1Bjd3dw?=
 =?utf-8?B?OGkzTFFrT2NZVXM1U1NSbU5KYUJFQ3lleFE0QzBvS2NvT21FZndVSWdUQjFM?=
 =?utf-8?B?RS9SZ1J3eTFmeE5UNm5hQjFRQ2wxY3NjQXJnVi9ILzltZlJNWFJhbHNQYXdV?=
 =?utf-8?B?YWtyQnUxRW1HdGJONy80TEZIWEJ2UnY5dzl3NUlDQ3FVdzJPdjRGdDlQTjM5?=
 =?utf-8?B?Vk9XNnZHSnJCc3ZyOTNQemg4WlVaMWRlM0F4d1M3cFFOUFh6aTE0ZE9XQzJq?=
 =?utf-8?B?NzNhUnlqR1pVK2N6SXdjV2VjaklZUmN4Y0FDZW04SmM5RThBTVRUaHRpWEJY?=
 =?utf-8?B?bkNBTUNCdFI2RjdtTjFKOHlnUVRpQWZlTkNwWHhDZWsxZnJHK3JKVHY2aWZu?=
 =?utf-8?B?S01CYmhsTHBWeFVoOXZIWU5NUzFTUCtMcmJZODUzTThGaDIxbHErajBnWU53?=
 =?utf-8?B?S3llSm9kWG5sbzdFNHc2MlN2WXpTRGlVV0c4Wm1UR0dxaXJoa2twaWRyWFRF?=
 =?utf-8?B?WDhTdHFQQUhVZGZKUUpQT1lKeDNSV2syVXhkQm51RFp2WGpWS1ZLWkFXY1oy?=
 =?utf-8?B?LzlNZWQzQXNoK25GMFl5SmNueEtDOHZzbTR5YnNOcXczc2dKQUlNM2RSR29R?=
 =?utf-8?B?Q0tNamUwUUJ4dktjU0N6SC9sdyt5dzM0S0Exb3VELzFiQVY3ei9MUWlRTzR1?=
 =?utf-8?B?VkpvM2tMbGk2K1NvMzRuU3BTQTI2eWhDc0haSHVOLy9DTkkzOTZJUlNTU05z?=
 =?utf-8?B?bUN5ZTlzS1RnSXFOc1FZaWdOb2tyTmYxKy9Jejc2dit4WjE1VFF6bjZjMXda?=
 =?utf-8?B?OGQ0VXB6V1oyQXc2ZHNQVkhEa011SGpKVm15Um9vNVlyUHVmYzl1c2ZFcWto?=
 =?utf-8?B?bGorTUZkK2lJSFZQeGZkY1lSVXY0aG1qcDdlOVFRNHVUMmNQdlcrZC8xM2t1?=
 =?utf-8?B?aGpwaDJDeFdsZGE0WHErRmJNN3Vla0FFZkRncVNsZFdKSTAzbXNHN2p0bUhQ?=
 =?utf-8?B?VHgwb0l0Q2tKeUcrMldPVkw2SzVaUTZQN3UzOURWbUNsZDluZCsyV1dlaTBN?=
 =?utf-8?B?SWNSWERaU2g3QW5YL1RnZkZ3QlR0S2xRT1lKZWZVRWRGcFFJeDdkS1lsc2JX?=
 =?utf-8?Q?oIGVfrfrlXGGWT1RCsg/VztX43AewoQl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR03MB5674.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0xjYWljS3lRcjdIQWlEK2VuUWZLOUxtYU1UaVdscFZsNjdtZndwTDVtYVZC?=
 =?utf-8?B?RDJ2NjZpR1JuK1hvQ1ZxU3F5ZUhYZ3h6ZmtJYUtoVXh6bVN5S2U0OVpFYkdo?=
 =?utf-8?B?ekZ6SmJWRDNEUGxGZDhWd1FrUGZXbEJYajYyZ0x0cmNuS3YxZDdKdjJXb21m?=
 =?utf-8?B?MTNZUFJmUFJJbWdhVFBUeVRkM2JzaUpaVHNuWUVsOFo1dkU2Ym10cEhQbUt5?=
 =?utf-8?B?WlVqV1c0dWQ2a1Zic0xjdjBnMStZbXB2ZjNCNlg3cXE4a3poWlFrQ1RoUW41?=
 =?utf-8?B?MVowbThpQVl1dTNINUNSRXFmVDRURFJnMzRReWgvdUJBeXlzM3JBc2FESFo1?=
 =?utf-8?B?V0Y1QUQ1NmlqSUFsT1NkeFEvdEVZUnR0M1g2enRrR3dnVWxKbCt2TzBKZ3Y3?=
 =?utf-8?B?d0ZCZDdzemFKbjBNejNtVFcySDNPRGdBb3V2K3E2cmhiZktzcDd5L0VnZmds?=
 =?utf-8?B?YVZBUXlUY1ZISGE0dXU1cDdBVVFRMFRhMnY5RG51RGgzWUVMWkViY1NIKzhU?=
 =?utf-8?B?SFBpeVcrMGxyUDhLcHRqd2pRc0t3TGpNT2ZBVHptTmtxUUZsOFgrSDJVa3JY?=
 =?utf-8?B?QTc0V3JDbnZEc0g0ODJFU0JtQlJUbjk3SUlwek1RRXVKL2J1TjkwZjk4MnVJ?=
 =?utf-8?B?aWljOFM4OGpoK3Q2OVpMcWUraTVyTElBa0hkc3RXUjFiemVYN3FGVFBUYkxm?=
 =?utf-8?B?ZTR6ekNHSmNmd2dYclJCTDc5UXVXMzhWRmhMWGFLYzhVNDVGWmhiOVFRNHBN?=
 =?utf-8?B?Sm1MTWI5VnFyWDdKUlFTZE9aMVpweWVIdUo2T1R6NElRSk01bU1ONUZpOHlW?=
 =?utf-8?B?ZmFhd3pETGVSV0hpeHY5MGNjb3ppQ3U5WFdjNHJPQlVxc0E2MU5XY0EyaUh3?=
 =?utf-8?B?TkQyUjR5OC9IZTJicm1wb2JFS2tyZTlaOXNVbW9QS1pDa1VZUkxBR0dLVFZX?=
 =?utf-8?B?T3c5eUlSUm5HVnNxQTJ1Z3lEWnFIYk1Yb1dTYzNSYnozT0Q2QkRXZmVaVGZq?=
 =?utf-8?B?dCtsUDExajBLeDdsVEczSmtNcnB4OWJyeEo4MjZSOW9Qb3o3YXFUK0hQNm92?=
 =?utf-8?B?cnF5UHRMOEpQczVDek1aTFBGTGF0UURkeEd6TUs3MzVZMjdwSVMyVzdSNzJo?=
 =?utf-8?B?QmFEU0RXMW8vZEtoc2hPL2FBRkVIQUF3bmtnZE16MW9LRDQ2WmdCSDV2RW92?=
 =?utf-8?B?WHYrQVc3S2h6UWRkdk9ZS1Vvc0JFYldqdFBMZkRsUEo0UTRmTEJTeFdQQW9Q?=
 =?utf-8?B?b0NjbVZoMEtyVU94alo4d3hBbXpVdDdGa1ZQdlNkaXBiNC9OTVo5bVNDdm11?=
 =?utf-8?B?K1VRSXoySnR2M0srUEdnSUZRSW9vNy9kMTdOVU5XUFR2U3YrTHMva0c2Nkxa?=
 =?utf-8?B?RnppQXZPdXkwK3NPUmF2ekk5YzlUU0xyVXVCa0QzWXcrRVhoc0dMUGtqdWZw?=
 =?utf-8?B?OUYxRllIMnNlNFo1bzZmN2VhQU02a25kcTFSeHlIQ3F3NzBRZ0FFTzJiY1d6?=
 =?utf-8?B?RW44dXMzdmwzWUo2ZE9lTk9VZ2FEd0JtNjBtRks4S25CenN3UEJPQk42Zkhz?=
 =?utf-8?B?TkxvYnpDaFV5c3BjZis4dHRKczNDcTJNRXlwUHRMcGxjNVJsZHRoVXV3MmVp?=
 =?utf-8?B?Mm5GTnIwTU1VNFoxU2dNeCs5L0ZJeTNpNDJ2ZGtVenRTNnk0ZHExUlZRUVJN?=
 =?utf-8?B?NG1PdDZMYUZzK1NDNUdadGdPbFpaMHVwcGRsSzBQWENEN1B2bEJLUHNvQlNE?=
 =?utf-8?B?QkhGL0hBSyt2OHY3MnMyVnNrZTdBSEZNR3UrU25SRGs2VmJyOUJUNTYvaS84?=
 =?utf-8?B?U09nSkdQdFZuNWdzdWtSckFFdXY1cHpGaWJ6c2d4QjIzdXNoUG9aSnJ2Kzdw?=
 =?utf-8?B?SUlROW45QlpQYmZOQ3FaZzhqN2krMVFxSEQvVGk1aUxEYll4alNTT0laaHMz?=
 =?utf-8?B?RDZKcjg3Y3R0b3Z1d2lNTWhzRTlzVkpMeDZrNDcyaGtWSEM5SjF5WTlSZm1J?=
 =?utf-8?B?UXNFSEVSRWtvM0xoSnBOcUZBU1hGTUpYUGFqeWp1cXEwUWhLbzZscTRDcGpz?=
 =?utf-8?B?WlcxWTJYSlBUdTFBbGhlNFVSNmxKMjNDMXNqcDRmZ1NXN1hGUDJpU05LZ1Vs?=
 =?utf-8?Q?0XTtHK9bj3ZUbjiuUmdebFzBb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5674.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186d99c5-ce5f-4977-1b5d-08dd553f77f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 01:55:24.0293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3Ca/oIKQKeHpxSS84fVkFr+D9BQv38XGAi5OUYY9MI1OKhtHw+hZC+CS2QwrVaKNWYcwBA9kRUiy2ARu9Ut3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8029
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=yumin686@andestech.com;
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

SGkgQWxpc3RhaXIsDQoNCkkgaGF2ZSBzZW50IGFub3RoZXIgcGF0Y2ggYWNjb3JkaW5nIHRvIHlv
dXIgc3VnZ2VzdGlvbjoNCiAgICBbUEFUQ0ggcWVtdV0gdGFyZ2V0L3Jpc2N2OiBPbmx5IGNoZWNr
IGV4dF96Y2EgZm9yIDE2LWJpdCBhbGlnbmVkIFBDLg0KDQpZdW1pbmcNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyMjNAZ21haWwu
Y29tPg0KU2VudDogTW9uZGF5LCBGZWJydWFyeSAyNCwgMjAyNSAxMTo0NSBBTQ0KVG86IFl1bWlu
ZyBZdS1NaW5nIENoYW5nKOW8teiCsumKmCkgPHl1bWluNjg2QGFuZGVzdGVjaC5jb20+DQpDYzog
cWVtdS1yaXNjdkBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFBhbG1lciBEYWJi
ZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+OyBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwuY29tPjsgV2Vpd2VpIExpIDxs
aXdlaTE1MThAZ21haWwuY29tPjsgRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRiYXJib3phQHZl
bnRhbmFtaWNyby5jb20+OyBMaXUgWmhpd2VpIDx6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCBxZW11IHYyXSB0YXJnZXQvcmlzY3Y6IENoZWNrIGV4dF96
Y2EgZm9yIG1pc2FsaWduZWQgcmV0dXJuIGFkZHJlc3Mgb2YgbXJldC9zcmV0Lg0KDQpbRVhURVJO
QUwgTUFJTF0NCg0KT24gTW9uLCBGZWIgMywgMjAyNSBhdCAzOjM04oCvUE0gfnl1bWluZyA8eXVt
aW5nQGdpdC5zci5odD4gd3JvdGU6DQo+DQo+IEZyb206IFl1LU1pbmcgQ2hhbmcgPHl1bWluNjg2
QGFuZGVzdGVjaC5jb20+DQo+DQo+IFdlIG9ubHkgY2hlY2sgUlZDIHRvIGFsbG93IDE2LWJpdCBh
bGlnbmVkIHJldHVybiBhZGRyZXNlcy4gVGhpcyB3aWxsDQo+IGNhdXNlIGlzc3VlcyB3aGVuIG9u
bHkgZXh0X3pjYSBpcyBlbmFibGVkIHdpdGhvdXQgUlZDOiAxNi1iaXQNCj4gaW5zdHJ1Y3Rpb25z
IGFyZSBhbGxvd2VkLCBidXQgMTYtYml0IGFsaWduZWQgcmV0dXJuIGFkZHJlc3MgYXJlIG5vdC4N
Cj4gV2Ugc2hvdWxkIGFsc28gY2hlY2sgZXh0X3pjYSB0byBwZXJtaXQgMTYtYml0IGFsaWduZWQg
cmV0dXJuIGFkZHJlc3Nlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWXUtTWluZyBDaGFuZyA8eXVt
aW42ODZAYW5kZXN0ZWNoLmNvbT4NCj4gLS0tDQo+IFRoZSB2MiBoYXMgYmVlbiB1cGRhdGVkIHRv
IHByb3ZpZGUgbW9yZSBleHBsYW5hdGlvbi4NCj4NCj4gIHRhcmdldC9yaXNjdi9vcF9oZWxwZXIu
YyB8IDEyICsrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9vcF9oZWxwZXIu
YyBiL3RhcmdldC9yaXNjdi9vcF9oZWxwZXIuYw0KPiBpbmRleCBlZGRlZGFjZjRiLi44OTEwMDJm
OTU0IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yvb3BfaGVscGVyLmMNCj4gKysrIGIvdGFy
Z2V0L3Jpc2N2L29wX2hlbHBlci5jDQo+IEBAIC0yNjksOCArMjY5LDEwIEBAIHRhcmdldF91bG9u
ZyBoZWxwZXJfc3JldChDUFVSSVNDVlN0YXRlICplbnYpDQo+ICAgICAgfQ0KPg0KPiAgICAgIHRh
cmdldF91bG9uZyByZXRwYyA9IGVudi0+c2VwYzsNCj4gLSAgICBpZiAoIXJpc2N2X2hhc19leHQo
ZW52LCBSVkMpICYmIChyZXRwYyAmIDB4MykpIHsNCj4gLSAgICAgICAgcmlzY3ZfcmFpc2VfZXhj
ZXB0aW9uKGVudiwgUklTQ1ZfRVhDUF9JTlNUX0FERFJfTUlTLCBHRVRQQygpKTsNCj4gKyAgICBp
ZiAoIXJpc2N2X2hhc19leHQoZW52LCBSVkMpICYmICFlbnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0
X3pjYSkgew0KDQpZb3UgY2FuIGp1c3QgY2hlY2sgZXh0X3pjYSBhcyBDIGFsd2F5cyBpbXBsaWVz
IFpjYQ0KDQpBbGlzdGFpcg0KDQo+ICsgICAgICAgIGlmICgocmV0cGMgJiAweDMpICE9IDApIHsN
Cj4gKyAgICAgICAgICAgIHJpc2N2X3JhaXNlX2V4Y2VwdGlvbihlbnYsIFJJU0NWX0VYQ1BfSU5T
VF9BRERSX01JUywgR0VUUEMoKSk7DQo+ICsgICAgICAgIH0NCj4gICAgICB9DQo+DQo+ICAgICAg
aWYgKGdldF9maWVsZChlbnYtPm1zdGF0dXMsIE1TVEFUVVNfVFNSKSAmJiAhKGVudi0+cHJpdiA+
PSBQUlZfTSkpIHsNCj4gQEAgLTMyOCw4ICszMzAsMTAgQEAgdGFyZ2V0X3Vsb25nIGhlbHBlcl9t
cmV0KENQVVJJU0NWU3RhdGUgKmVudikNCj4gICAgICB9DQo+DQo+ICAgICAgdGFyZ2V0X3Vsb25n
IHJldHBjID0gZW52LT5tZXBjOw0KPiAtICAgIGlmICghcmlzY3ZfaGFzX2V4dChlbnYsIFJWQykg
JiYgKHJldHBjICYgMHgzKSkgew0KPiAtICAgICAgICByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52
LCBSSVNDVl9FWENQX0lOU1RfQUREUl9NSVMsIEdFVFBDKCkpOw0KPiArICAgIGlmICghcmlzY3Zf
aGFzX2V4dChlbnYsIFJWQykgJiYgIWVudl9hcmNoY3B1KGVudiktPmNmZy5leHRfemNhKSB7DQo+
ICsgICAgICAgIGlmICgocmV0cGMgJiAweDMpICE9IDApIHsNCj4gKyAgICAgICAgICAgIHJpc2N2
X3JhaXNlX2V4Y2VwdGlvbihlbnYsIFJJU0NWX0VYQ1BfSU5TVF9BRERSX01JUywgR0VUUEMoKSk7
DQo+ICsgICAgICAgIH0NCj4gICAgICB9DQo+DQo+ICAgICAgdWludDY0X3QgbXN0YXR1cyA9IGVu
di0+bXN0YXR1czsNCj4gLS0NCj4gMi40NS4zDQo+DQpDT05GSURFTlRJQUxJVFkgTk9USUNFOg0K
DQpUaGlzIGUtbWFpbCAoYW5kIGl0cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50
aWFsIGFuZCBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJv
dGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgeW91IGFyZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWlu
ZywgZGlzdHJpYnV0aW9uLCBvciB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJl
aW4gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSW4gdGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRl
bHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdl
IChhbmQgYW55IGFjY29tcGFueWluZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVk
IGhhcmQgY29waWVzLiBUaGFuayB5b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQoNCkNvcHlyaWdo
dCBBTkRFUyBURUNITk9MT0dZIENPUlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg==

