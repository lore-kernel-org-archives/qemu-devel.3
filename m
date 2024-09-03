Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C56CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNgH-0006aK-3x; Tue, 03 Sep 2024 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slNgE-0006X7-E4; Tue, 03 Sep 2024 03:10:22 -0400
Received: from mail-tyzapc01on2072e.outbound.protection.outlook.com
 ([2a01:111:f403:2011::72e]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slNgA-0007l5-Sx; Tue, 03 Sep 2024 03:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzPESEKYKTyHCA/qdT26J+0mS09nG/Zv6FDBCQ/Cxjoc5wru+p3+pExGVYDvIGOcEyyY52nqxjWh0NFCwcGIPLt9n9HPHCc8v5M5a5lCR7Yc2fqFAGGxdOAAGfyLpAhHKZw/GwlrW5ez3+tnSeIeni3ZhxWjOq5oR7jshT1oRp4+kGc19/K0oYZqZRNvjscvVWkE/ni0AviBm9g2zU/t8k8kAwi8UsQlpb/YDFESBKnTPHiDZoQp/czCmNrdlFBGSq6n8fI1570BHBXOvSkPbASyDcBDqvZjcE4UTiU0w1fnV4Hvjjf/UikcDOAFXT+tvUZ6+vLdNUGuXuRHDuehrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhsOLkC3P1Fr/s8HfWbIjRfusOCz4McHwInQY2TQN2Q=;
 b=kt+XRmjBaxjz50WaTn7l+c34e55wNsnkLkdoGi4goroHGDwIs0/JNR39v6kmkWRRPWB2gcEYMDGacObD/QB1xz1HiO4AejBsM+AZS3bPYKE61uzHEBc+WVXFe3T3GjfXqKnxGL6Q+YE9H2pmpTeg1tBbDCml9IIV0E+tkzwl5JHcBH7XwoqlChJNPbI2NO2mLj72thqNcMaRiG08lOA1DKa7pq8pOHbWYQyI8mij9v+EL/aSgLyArRW73eIDwtWTssR4Ur7a1holsa4/yABVFzpYUJ51flGa+tn9Yu5aEQegvWs8hky2FPXOxaz2TBEsierJ+c/RyPiXpkMFCkIv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhsOLkC3P1Fr/s8HfWbIjRfusOCz4McHwInQY2TQN2Q=;
 b=jOWXBv4YnfrMvbrt9ev3yM4ajaLXMS5JCpEKhEty2nGhAn6x4wMHj+Pn0SDe5RbTajzjI9FtT03KCnAE5G4q4YD3QlX7gVdva/EAsOvBVCpNfMoemariHTz4wIHv0qBpKM9dXEGcxI2Bs90c15XNCsom3+HgGqFOITHjwgDx0q/Th73YUtGBzuwQr3uhc8RYhEoFiLoV0VTzVRyJxivPs9HMgNqj4lcGJYN6kJWpHDx8oOklLu4b5uQuvaI24691NJe5q2ugHmX76B3Tsxjca++4Dl/oxJRIwlgHK+7YrsSoN+smN2Sts4JN/Y+Vbj43EHzcs0x1kn7TVKc4Z3sy3A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7275.apcprd06.prod.outlook.com (2603:1096:405:b8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 07:10:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 07:10:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 07/11] hw/i2c/aspeed: support high part dram offset for
 DMA 64 bits
Thread-Topic: [PATCH v2 07/11] hw/i2c/aspeed: support high part dram offset
 for DMA 64 bits
Thread-Index: AQHa6T2WGJJO30MNAkmAAXkkqnI2FrJEpXYAgADkQXCAAEP1gIAAAFfQ
Date: Tue, 3 Sep 2024 07:10:10 +0000
Message-ID: <SI2PR06MB5041A983349E8AAE291BB1B8FC932@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
 <20240808024916.1262715-8-jamin_lin@aspeedtech.com>
 <0e62d8ed-f30d-4b18-914b-89a51d6d9687@kaod.org>
 <SI2PR06MB5041259485142B47913B7E9AFC932@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <054474d6-64a6-483c-ab90-d0bc6778712a@kaod.org>
In-Reply-To: <054474d6-64a6-483c-ab90-d0bc6778712a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7275:EE_
x-ms-office365-filtering-correlation-id: 459e2200-61c1-4da5-27e7-08dccbe772de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NlVzWG0zTCtIL01rTG5xMXl0L1hNaC9TY0c0b243ZnJZTTQvMVltZDcyR3U4?=
 =?utf-8?B?QlBMUVdkdG9uQm15WkZ5WUhuYzlyZDFUZjBQcGRhQXI3cjZhZ252eXkzbzdK?=
 =?utf-8?B?WTljL3I1VldVQzFQWFltYkliZGEyOCtIckc1VWMwNXZrSS9WWkM0ZXhxRURN?=
 =?utf-8?B?VEVsM3ZoVGFveHI3c0ZDcnNqSEZFdFZLaGM5azhyQkRISnNkVElqNVVBclRG?=
 =?utf-8?B?dUc2a0pDVEJoTEhpeGtWQXJTTzc5YkRjb3FQNkI2OG52KzlGMVVhT1N6NVhs?=
 =?utf-8?B?QW4vRXBlQ0owemhSelBWUkk0TlUvaUMwWjlNb0tkY3RrUm0wUjgxQ2FFVnlw?=
 =?utf-8?B?WnpZd24zei9NQWlHZ2dSeWxBdnF1TFQ5Uk05UTBYREFvVW9tQ1lCU3AxMTRG?=
 =?utf-8?B?VHBHT3g0SWZHbkllMEtxN2pmMEU2ZVZIRUgvNkdlU25nMGw3cEJGYUMzSHd4?=
 =?utf-8?B?SDZFRDJkRUlqSzBaTndzZHhWeVZLVU9jYnd1WFM5UEQ3eDJqRndFTU04T05L?=
 =?utf-8?B?a0RDeGdza3NYYkQ4MUxkNHQ3RDVhSTdIZVNabGd0QkJwd1hTUzdiUDZFVWhk?=
 =?utf-8?B?Q04rUEc2elY4WVJPc3dSTHR5WGp0eS9wVVV0Q0VlMDByQnFzZnBmcjFqT3Nv?=
 =?utf-8?B?dVJHLzd3R2d5U2JWeXNkM2RpZzl6blZ1YllCTnJjTHV6Z2FmcmZpWkEwRUNp?=
 =?utf-8?B?WlkySkRTMzFhN3NQYzIxTFRaTmlYRk1uVU9ZZngvY2pCTjRraW4xdVgyZWR1?=
 =?utf-8?B?SnBwWUYvTTVCbFB4NG5JSlFvS3RYd08wUWpacEVVRnhWYXJGSXZNUm9SRlMv?=
 =?utf-8?B?c2JwQ0ZaaUdYa0FFRWN5dW5GcW5YdWhaUUMxUlVENzcrdXZoVnl5dS9NM21j?=
 =?utf-8?B?T0VFQ0psL1U1UnpiR0F2cXNzczZEUlR6cHN3a3ZINlZoQWlFTGtRbnN4QW1U?=
 =?utf-8?B?T2FwajZ5azRmaUtWSzBnUWtWZUJJVjRUZnlocnVxamhPUU1oaHh0M3R2eHlQ?=
 =?utf-8?B?WjBobGZoY0NjeVFydEZMaVBETllmZUF2cE5kVGVIdUJlVFB0Z0VlMS96Y0x4?=
 =?utf-8?B?a05TOXVjNkJ3QzNaN3ppQ2s0RENrM1g1MFpyck1EMDVGLzhxRVdOMzM1K0hG?=
 =?utf-8?B?bDIvMW5rMlpaRzExaU83VGhhV3FrZlZhSnpheDk2djVoaFNncWdDM2RyMm5D?=
 =?utf-8?B?UzBuWFdpbGY3TnYrRGVYeDZmSUM2bStxeFI4OXNFYXlhNU50a0Y2NDdybmxC?=
 =?utf-8?B?WEIySndiNHYyNXhFekpQSmdKZndMc3lsZitQS3dQaklsQUs3QUVQOWE2K2tF?=
 =?utf-8?B?Mk1KenlmN2pFMEFmbUVMTEJhMFFFMmVkTlEzMUQvUUlWQzdYd3I2UFZpZVB4?=
 =?utf-8?B?TXNadGtoQTZkVDR0MlBhMTAzaVZKMFB2ckg5Ync0RTNpYjZPQkx1aWszU0dp?=
 =?utf-8?B?NjJQV2RTOWZ6UVBPWTU1UmE0WUJOT2ZQZ2pYTm84MEk1ZzhlbnRXekJlRnhG?=
 =?utf-8?B?bjBDWHFYbjVwQURIMTZUczdTSnR5WldIZWVFUDQyNjJYL3BZOFFxNmxYK3pT?=
 =?utf-8?B?dEdFUHZhQUlDQXI5cnlvcHZjKzBXR2dPMHFvbDNWbzJrb0pFREtrUEJIZDhs?=
 =?utf-8?B?aFoxc0xieGpMdFc5STQwMzNzVHltQXdoSmZoZmdQdFVsQURNZXg2N1o0M0c0?=
 =?utf-8?B?aGQrbDJlQzBVN3llQktoVHdsK2xMUlFxd1M1OEZLUHZiUS9sc2xnZVhJdGFS?=
 =?utf-8?B?SXAyK2Vsb1hIUFg0cDN1dVFINmZxQXVEVWtTMStud1FIUVQxekk1bFFtaXBu?=
 =?utf-8?B?eHQ2V1dGOXZ4dmZWRDZYalN6TTN0dzV6UEJZMDhycG1NNEN4L1pYNG9LWCs5?=
 =?utf-8?B?amFLVjNZZ3BpVlA3ZXFIM2FXMG44VEdiU1dlQVdSWnBEYkZiMXdTMVBWVU1F?=
 =?utf-8?Q?REtHme3KjG4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rnk4Yy9tV3BJa3p5VVgzc2hRajQ4cmdaTU5tYlFXZHZDZGdGbTZORkg1VGdh?=
 =?utf-8?B?L1dvOUIrMzExek1jUlJjT3ZOeDg1YmFVOXZHVktMTldZUlZZQjVWSHdYMFJV?=
 =?utf-8?B?UHp5UWhlcER3c04wbFVOdHBCRm9FdXFtTWZldTZVbVBsNnFTVU1ZL1dBa0w1?=
 =?utf-8?B?MWY3cUl3SHRFUWl0MCtxU1dQWXl2dUZHY2JlTUtERzVxNlI5WUFkb255V2gv?=
 =?utf-8?B?cTM5QStFOU9LeHZkQmZBNWphb3BOeHBDOUVzS1BKMkNMMit4V3VYcmRwRUwy?=
 =?utf-8?B?K2hKV2tOQXRMWkRHckp2K0dCR2RKcU51QjdDd2RFOEpLVjJPM3ZqZklRTmU4?=
 =?utf-8?B?dnBzMHZ0R3J3b3NZcjN3cXZieGQ5NkJ3UmxRZFczeUhHNE5STHArQUREVEFr?=
 =?utf-8?B?bUYrNi9aaFYydDdSVVE0QW9YVVhYcmtZck1PZHVDK0FFdTUweDV3UUwzY1Iw?=
 =?utf-8?B?RzIrVjZPcE8xOHJzQzlObFNVd0VSNmZETkNlTUUzYytIcmpRSFBJTjE3MFlm?=
 =?utf-8?B?RzdrU0t3NC9mQzAzR01Bc1BQS21ZaWZmbGUwdWFzTG1aV1dKSU0xTEZ2bUsz?=
 =?utf-8?B?ZXIxMGpiNzZJNjNTUDB3TkVWSmE2N01BcXYveHVLWm5vYlNSVklxWWhLSHg2?=
 =?utf-8?B?MkpWeWFobE1CTWc5UXErMmJwNFJTVlZLbFVVN2h6SW01Z3hDWHNhMG9EM1BC?=
 =?utf-8?B?a3oxbVRqYXh6QUQxNDMzL3lvS1cwT29ocVB6VnV3T2hEVjIxWlZRU3VCbE9H?=
 =?utf-8?B?eFE5Kzh2RVJmYjJmclZGLzljU2ZaY2x4clJlMkc4UUM3eWxFTWU5dW05NmVC?=
 =?utf-8?B?dDRGUVlCNldKTkY2ckNXZ29LSTlSQ1ZBN2tsTVRLdTNHRSt2TzBBK2pKUno3?=
 =?utf-8?B?WVVEWERQaVk0aWwrQndWSGYvNmw4OVhlL2M0NFRvNDJHVDd3TDhFRUxKV01a?=
 =?utf-8?B?cVpKZnpmZWxTUXR0UXZDQmJyQmxNb3lmY29LajlmbXVHMXZ2V1lORklMRVVD?=
 =?utf-8?B?cGFCZFpoT3UzL1NsbEE3b1BLYlA2OHBPVHI5V3BLWGVLVm5SWjNHK0dmd3R5?=
 =?utf-8?B?SmpJVlNETGxCeGJ5Vk9hQUlpUWJLNGNTTGZBSEJUdlVtR2szMHdOZGlrRDNz?=
 =?utf-8?B?MDNmK3ZpQmk4cVVqQmhqSkUxZWhsUUNJWWdZNFhFM21tVzRLYVZYZ3hER3ZE?=
 =?utf-8?B?ajloaEx4VXV0VG5FWGVwRlZya2xjdDBmSkl4b29Sa1IvZVN1eHJxMDhHRGQ0?=
 =?utf-8?B?LzVXWUxoejdlSEcwcktrcjRRcE9GVDhSMGxMcE1zKzdqVjd1TW43MVpHb2Zi?=
 =?utf-8?B?bDZyQVNxY0psWEh5TjVMU1d4anFnZkdHZmRUcEttbmhOSThGb0crMWVmRzMz?=
 =?utf-8?B?cWw3RzJSYWdXVlRCK3lNL3IwdTBKQ3BoR2l4bE93SUVZWVVtOTVRNEtQK3gy?=
 =?utf-8?B?aEVvY2wyeGZQcVo0US9aR0dnWm1EYmdMbFR3MXk0Yk1hK0pUUHJqM1VScFox?=
 =?utf-8?B?UDBiZlJVeTNJOW5nVlFWWU84WFlaTStXYTdGZDF0Tk53dE1FM0t2eVI1eHhx?=
 =?utf-8?B?YjZvelhicUd4bDhHRURyRHFweHRaRHNvaEFkMGFwNUtYTURVc24rZ2hRQUtn?=
 =?utf-8?B?SzlIbG5JZEd1dHRwZFhKSXRjSG5wZEIvZ1VQMDZLQ004ZU5lYnVJY2FvTFpr?=
 =?utf-8?B?ZG1WV3o5NWkzeGwyaElFZW9zdG9UVGVqK2pxNW1Ed2NxdTVjZEpVZHI4SENk?=
 =?utf-8?B?QlNOSGpTRjEyVWZhSkQ1aU5UWnhXZUNBbkxneGFhQThmMFE3bnpkcmtYenlO?=
 =?utf-8?B?bEhRTjRBYTFSa2hlVjZtYUNDT3Y3TlpzNDIxZzcyZ09tVS9CekZOMTA1RkYx?=
 =?utf-8?B?aDZPRXFXa0pMSi85eEgrOVpUdG14azQ0Q3VRbUpRNURBZ0NJSmtjbndhbFFS?=
 =?utf-8?B?ZzRBbG5sakhsYTF2emxSUFh0N0wwbExjTjlUM1V1UG9VUDZ4aFhQV2VHcHlT?=
 =?utf-8?B?MzUrZE4vR3ArNU94SzRuTzdMMGVodXpRNFJpV2RRNkV3NDUzL043YzRzVWxs?=
 =?utf-8?B?bmVDbFFodlNtMk42bUZCZHFKdXpJZDM2OWpvRXdlc1BLbFplUXNZeEFGR3RB?=
 =?utf-8?Q?yai2RNUhj7O1iN5ce+x7OjfU+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459e2200-61c1-4da5-27e7-08dccbe772de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:10:10.4585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF7oZwDv6t/OsV2EIHPll3uCmSo1VM3WNNCnNVpLtEMJ7dFwfoqM3w9G+hNSTM8PogBl7tC6gaGq0Kut5Xk0nN6zyfKx/pp8+fhvSCwMYTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7275
Received-SPF: pass client-ip=2a01:111:f403:2011::72e;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMTFdIGh3L2kyYy9hc3Bl
ZWQ6IHN1cHBvcnQgaGlnaCBwYXJ0IGRyYW0gb2Zmc2V0IGZvcg0KPiBETUEgNjQgYml0cw0KPiAN
Cj4gT24gOS8zLzI0IDA1OjA2LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ2VkcmljLA0KPiA+
DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMTFdIGh3L2kyYy9hc3BlZWQ6IHN1cHBv
cnQgaGlnaCBwYXJ0IGRyYW0NCj4gPj4gb2Zmc2V0IGZvciBETUEgNjQgYml0cw0KPiA+Pg0KPiA+
PiBKYW1pbiwNCj4gPj4NCj4gPj4gUGxlYXNlIGFkanVzdCBjb21taXQgdGl0bGUNCj4gPg0KPiA+
IFdoYXQgZG8geW91IHRoaW5rIGlmIEkgY2hhbmdlIHRoZSBjb21taXQgdGl0bGUgYXMgZm9sbG93
aW5nLg0KPiA+DQo+ID4gaHcvaTJjL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yIGRtYV9kcmFtX29m
ZnNldCBhdHRyaWJ1dGUgYml0cyAzMyBhbmQgMzIuDQo+IA0KPiBIb3cgYWJvdXQgPw0KPiANCj4g
ICAgImh3L2kyYy9hc3BlZWQ6IEFkZCBzdXBwb3J0IGZvciA2NCBiaXQgYWRkcmVzc2VzIg0KPiAN
Cg0KR290IGl0LiBXaWxsIGFkZC4NClRoYW5rcy1KYW1pbg0KDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KPiANCj4gDQo+ID4NCj4gPiBUaGFua3MtSmFtaW4NCj4gPj4NCj4gPj4gT24gOC84LzI0
IDA0OjQ5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+PiBBU1BFRUQgQVNUMjcwMCBTT0MgaXMgYSA2
NCBiaXRzIHF1YWQgY29yZSBDUFVzIChDb3J0ZXgtYTM1KSBBbmQgdGhlDQo+ID4+PiBiYXNlIGFk
ZHJlc3Mgb2YgZHJhbSBpcyAiMHg0IDAwMDAwMDAwIiB3aGljaCBpcyA2NGJpdHMgYWRkcmVzcy4N
Cj4gPj4+DQo+ID4+PiBUaGUgQVNUMjcwMCBzdXBwb3J0IHRoZSBtYXhpbXVtIERSQU0gc2l6ZSBp
cyA4IEdCLg0KPiA+Pj4gVGhlIERSQU0gcGh5c2ljYWwgYWRkcmVzcyByYW5nZSBpcyBmcm9tICIw
eDRfMDAwMF8wMDAwIiB0bw0KPiA+Pj4gIjB4NV9GRkZGX0ZGRkYiLg0KPiA+Pj4NCj4gPj4+IFRo
ZSBEUkFNIG9mZnNldCByYW5nZSBpcyBmcm9tICIweDBfMDAwMF8wMDAwIiB0byAiMHgxX0ZGRkZf
RkZGRiIgYW5kDQo+ID4+PiBpdCBpcyBlbm91Z2ggdG8gdXNlIGJpdHMgWzMzOjBdIHNhdmluZyB0
aGUgZHJhbSBvZmZzZXQuDQo+ID4+Pg0KPiA+Pj4gVGhlcmVmb3JlLCBzYXZlIHRoZSBoaWdoIHBh
cnQgcGh5c2ljYWwgYWRkcmVzcyBiaXRbMTowXSBvZiBUeC9SeA0KPiA+Pj4gYnVmZmVyIGFkZHJl
c3MgYXMgZG1hX2RyYW1fb2Zmc2V0IGJpdFszMzozMl0uDQo+ID4+PiBJdCBkb2VzIG5vdCBuZWVk
IHRvIGRlY3JlYXNlIHRoZSBkcmFtIHBoeXNpY2FsIGhpZ2ggcGFydCBhZGRyZXNzIGZvcg0KPiA+
Pj4gRE1BIG9wZXJhdGlvbi4NCj4gPj4+IChoaWdoIHBhcnQgcGh5c2ljYWwgYWRkcmVzcyBiaXRb
NzowXSDigJMgNCkNCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IFJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGh3L2kyYy9hc3BlZWRfaTJj
LmMgfCAxNCArKysrKysrKysrKysrKw0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvaTJjL2FzcGVlZF9pMmMuYyBi
L2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gPj4+IGMxZmY4MGIxY2YuLjQ0YzNjMzkyMzMg
MTAwNjQ0DQo+ID4+PiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4+PiArKysgYi9ody9p
MmMvYXNwZWVkX2kyYy5jDQo+ID4+PiBAQCAtNzQzLDYgKzc0MywxNCBAQCBzdGF0aWMgdm9pZA0K
PiA+PiBhc3BlZWRfaTJjX2J1c19uZXdfd3JpdGUoQXNwZWVkSTJDQnVzICpidXMsIGh3YWRkciBv
ZmZzZXQsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPiA+Pj4g
ICAgICAgICAgICBicmVhazsNCj4gPj4+DQo+ID4+PiArICAgIC8qDQo+ID4+PiArICAgICAqIFRo
ZSBBU1QyNzAwIHN1cHBvcnQgdGhlIG1heGltdW0gRFJBTSBzaXplIGlzIDggR0IuDQo+ID4+PiAr
ICAgICAqIFRoZSBEUkFNIG9mZnNldCByYW5nZSBpcyBmcm9tIDB4MF8wMDAwXzAwMDAgdG8NCj4g
Pj4+ICsgICAgICogMHgxX0ZGRkZfRkZGRiBhbmQgaXQgaXMgZW5vdWdoIHRvIHVzZSBiaXRzIFsz
MzowXQ0KPiA+Pj4gKyAgICAgKiBzYXZpbmcgdGhlIGRyYW0gb2Zmc2V0Lg0KPiA+Pj4gKyAgICAg
KiBUaGVyZWZvcmUsIHNhdmUgdGhlIGhpZ2ggcGFydCBwaHlzaWNhbCBhZGRyZXNzIGJpdFsxOjBd
DQo+ID4+PiArICAgICAqIG9mIFR4L1J4IGJ1ZmZlciBhZGRyZXNzIGFzIGRtYV9kcmFtX29mZnNl
dCBiaXRbMzM6MzJdLg0KPiA+Pj4gKyAgICAgKi8NCj4gPj4+ICAgICAgICBjYXNlIEFfSTJDTV9E
TUFfVFhfQUREUl9ISToNCj4gPj4+ICAgICAgICAgICAgaWYgKCFhaWMtPmhhc19kbWE2NCkgew0K
PiA+Pj4gICAgICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICIlczog
Tm8gRE1BIDY0DQo+IGJpdHMNCj4gPj4+IHN1cHBvcnRcbiIsIEBAIC03NTIsNiArNzYwLDggQEAg
c3RhdGljIHZvaWQNCj4gPj4gYXNwZWVkX2kyY19idXNfbmV3X3dyaXRlKEFzcGVlZEkyQ0J1cyAq
YnVzLCBod2FkZHIgb2Zmc2V0LA0KPiA+Pj4gICAgICAgICAgICBidXMtPnJlZ3NbUl9JMkNNX0RN
QV9UWF9BRERSX0hJXSA9IEZJRUxEX0VYMzIodmFsdWUsDQo+ID4+Pg0KPiA+PiBJMkNNX0RNQV9U
WF9BRERSX0hJLA0KPiA+Pj4NCj4gPj4gQUREUl9ISSk7DQo+ID4+PiArICAgICAgICBidXMtPmRt
YV9kcmFtX29mZnNldCA9IGRlcG9zaXQ2NChidXMtPmRtYV9kcmFtX29mZnNldCwNCj4gMzIsDQo+
ID4+IDMyLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZXh0cmFjdDMyKHZhbHVlLCAwLCAyKSk7DQo+ID4+PiAgICAgICAgICAgIGJyZWFrOw0KPiA+Pj4g
ICAgICAgIGNhc2UgQV9JMkNNX0RNQV9SWF9BRERSX0hJOg0KPiA+Pj4gICAgICAgICAgICBpZiAo
IWFpYy0+aGFzX2RtYTY0KSB7DQo+ID4+PiBAQCAtNzYyLDYgKzc3Miw4IEBAIHN0YXRpYyB2b2lk
DQo+ID4+IGFzcGVlZF9pMmNfYnVzX25ld193cml0ZShBc3BlZWRJMkNCdXMgKmJ1cywgaHdhZGRy
IG9mZnNldCwNCj4gPj4+ICAgICAgICAgICAgYnVzLT5yZWdzW1JfSTJDTV9ETUFfUlhfQUREUl9I
SV0gPQ0KPiBGSUVMRF9FWDMyKHZhbHVlLA0KPiA+Pj4NCj4gPj4gSTJDTV9ETUFfUlhfQUREUl9I
SSwNCj4gPj4+DQo+ID4+IEFERFJfSEkpOw0KPiA+Pj4gKyAgICAgICAgYnVzLT5kbWFfZHJhbV9v
ZmZzZXQgPSBkZXBvc2l0NjQoYnVzLT5kbWFfZHJhbV9vZmZzZXQsDQo+IDMyLA0KPiA+PiAzMiwN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4dHJhY3Qz
Mih2YWx1ZSwgMCwgMikpOw0KPiA+Pj4gICAgICAgICAgICBicmVhazsNCj4gPj4+ICAgICAgICBj
YXNlIEFfSTJDU19ETUFfVFhfQUREUl9ISToNCj4gPj4+ICAgICAgICAgICAgcWVtdV9sb2dfbWFz
ayhMT0dfVU5JTVAsDQo+ID4+PiBAQCAtNzc3LDYgKzc4OSw4IEBAIHN0YXRpYyB2b2lkDQo+ID4+
IGFzcGVlZF9pMmNfYnVzX25ld193cml0ZShBc3BlZWRJMkNCdXMgKmJ1cywgaHdhZGRyIG9mZnNl
dCwNCj4gPj4+ICAgICAgICAgICAgYnVzLT5yZWdzW1JfSTJDU19ETUFfUlhfQUREUl9ISV0gPSBG
SUVMRF9FWDMyKHZhbHVlLA0KPiA+Pj4NCj4gPj4gSTJDU19ETUFfUlhfQUREUl9ISSwNCj4gPj4+
DQo+ID4+IEFERFJfSEkpOw0KPiA+Pj4gKyAgICAgICAgYnVzLT5kbWFfZHJhbV9vZmZzZXQgPSBk
ZXBvc2l0NjQoYnVzLT5kbWFfZHJhbV9vZmZzZXQsDQo+IDMyLA0KPiA+PiAzMiwNCj4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4dHJhY3QzMih2YWx1ZSwg
MCwgMikpOw0KPiA+Pj4gICAgICAgICAgICBicmVhazsNCj4gPj4+ICAgICAgICBkZWZhdWx0Og0K
PiA+Pj4gICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgIiVzOiBCYWQg
b2Zmc2V0IDB4JSINCj4gPj4+IEhXQUREUl9QUkl4ICJcbiIsDQo+ID4NCg0K

