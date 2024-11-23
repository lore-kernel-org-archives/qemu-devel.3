Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7249E6ADE7
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 08:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tElkt-0006rk-SW; Sat, 23 Nov 2024 03:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tElks-0006rJ-4W
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 03:44:38 -0500
Received: from mail-sg2apc01on2126.outbound.protection.outlook.com
 ([40.107.215.126] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tElkp-0006Uu-6N
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 03:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPmH0Utz+mljRsOGQQfmpwzqRfhuDEtsTTqUgOeNYpDHnbZk45JQC4bnA8MvOz5zCSft3hvJiYEgwHLXd7w2Y+TA4uJihZiq3D/LRUI/6ffhq+c9+mlzGbTJhihyDZFMp84SgC2yPeVPKjpa5k57jKplB+dlnua/xLkv1LsNdLsMQf5o1JjezTFRZJw86lZ0ClacTeHo1zIcqNb0+kvqKbSTzaSZApDys4viw94c4OtnHkxh3u2t5nQFRd2DBOWdZdfT6nBJ3kZ+UnJxwI0NsAW6GP5/bh/sCs5IJe072EACd1AK20WmSUKUD7pdW6G7rN6I2koMAcH6e+C9qOfmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGiYKXQZNGAuZCCZ7CJB/7y5VEkef8lOLuk1BJ47jZY=;
 b=rgPNxQXlsqREAMenDScCL5RtjrutCsL+YNLfrVhrttxISPnKliBbUFbASel64sXzsdWVyVTQ5TQIC3HaGVCO8XrTCLzeG9aLg1CEgImSiYj2OybKlFmCn3eiYz1XQdJoh9tSztGdsaWfmK/u6ZTB0TRyxzUY8jtNoC4zx6Lao2gFIKxcBf38VuDH/xb6AP/F0baQiaP3Sg57jQ3VHITdXGCULz2pHYbDv4ciDiAVl0qqMVqOuVreRP37JJWWs1OTRWMa8A8WDzm7p7ufXR/w0dn8rjoVzeLel2Dr7mNCwYuzxjybnrAdz46ZrIwx41+fC/2NDXsrXOvy4tRKB6QzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGiYKXQZNGAuZCCZ7CJB/7y5VEkef8lOLuk1BJ47jZY=;
 b=lo4GqoWFRgkDoApuXcZqisIro/bXLWBg2Kr3gaGEaUK9Q6va86gRQZoKx/HtC38IQDZhT4fsqusc1pgmv5ti9wFlW1ek+UpyvArARrWfNUfO9ju0H16kWfPgoX4a20dIbuLQiR4vVFeA5XPPwMkO9+RU/MFHBRM3HWreFHWsi3uST25Uni8XWblhnJy2C9MTIvlJ6397Ju0OQCKRUclZhi79cYFCxG9PsSEUIe81wsYraSxmHBiV/o5XY1y9j37rmzcCnm0CbTBBWNPLIsO2WmdtZlPL1UfumVsGeqwRShpxLyeXoer0pWJ8Wm3kPRJOSld6KfbYZBxFDzgJAaHcPQ==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB7296.apcprd06.prod.outlook.com (2603:1096:990:a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Sat, 23 Nov
 2024 08:39:22 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%5]) with mapi id 15.20.8182.018; Sat, 23 Nov 2024
 08:39:22 +0000
From: Wafer <wafer@jaguarmicro.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "eperezma@redhat.com" <eperezma@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Angus Chen <angus.chen@jaguarmicro.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "groug@kaod.org" <groug@kaod.org>
Subject: RE: [PATCH] hw/virtio: Fix getting the correct ring number on loading
Thread-Topic: [PATCH] hw/virtio: Fix getting the correct ring number on loading
Thread-Index: AQHbPIJosKTsv0Hf0kCpKj2UATG/HLLC37YAgAGkUlA=
Date: Sat, 23 Nov 2024 08:39:21 +0000
Message-ID: <PUZPR06MB4713C38048484D29F20B3B65A22C2@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20241122020002.564-1-Wafer@jaguarmicro.com>
 <52aebd45-da0c-41a9-ab2f-acee8da5d7e4@linaro.org>
In-Reply-To: <52aebd45-da0c-41a9-ab2f-acee8da5d7e4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|JH0PR06MB7296:EE_
x-ms-office365-filtering-correlation-id: dde9ec89-b458-4cc1-c077-08dd0b9a541a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cjhsbld6ZERWWnUrbTkwR2RIRVZPeVl6ZDF3V3drektubElBbUVUa25Bb3lG?=
 =?utf-8?B?Z0piek5PUTBBbEpGNFBuaDRzdDh4K3NTZDlLdjQ2VVg4WXQvV0dSbVdGdHdL?=
 =?utf-8?B?R3g5RnFRbVZUZ2pCZ2taTmFFQmlTSjhaeCt4YkdaeEtCT2JtajJRUGhnWVE4?=
 =?utf-8?B?eHZIU2U0TzZHN2ZIZEF5eXJpWEtTTTRwMksrOGRnNHprcVIvZ2Vmc3Z1aDJm?=
 =?utf-8?B?SVBjaGp3SXMrbnU3SXhaN3NManZOdmlRYnQ1T21SMUlOSGU5NVBMQkI5SVMv?=
 =?utf-8?B?ZC9FbWY2NTV4K3RHN1BZQVJvWUNuODliTDcxY2RpQmg3RzB0cnNRaGpSTzBF?=
 =?utf-8?B?aCtrL1BOSnhha0ZlM1pjOU10MjhPOGpwSnY1M0FxUFdVZ1BhOS92dloyclZh?=
 =?utf-8?B?cFZNZStmQjdMMjdzWldaT0h3bzhoSzFGUTQrTGRzRkJFb25wQ0RuR3VlaTMr?=
 =?utf-8?B?TEN0ZlJWUGlSVnZMems5cUwrd1BZMmJBT25Ld2YvMEpjN1ZMK3pMMEVaWEl2?=
 =?utf-8?B?RkoxQndmcEtsbndITGZnOGh2Ni9SVldSOHByOG9TOW1KTFk5bURhTjVsZjZU?=
 =?utf-8?B?cCtreWg0bDREbTIxMWxsVjZPaWI4aWJqYXNSekFJUUNoRDFwdGtEVzRTWDF2?=
 =?utf-8?B?cEhwamJ4LzZuc1NnOVBKcEJodHVxc3A4bjllekNIenFCb2VQTzY5cmVISjFz?=
 =?utf-8?B?YytORGR6c3o5TlUySm1CekdHcTE3TmwyYkR1R1Q0S241Snk3VmVVb3k3bkl1?=
 =?utf-8?B?MURycndrdW41S3lsZVFMNE16cCtoV1kvM3NKNU84MEltS1JYMmZlRnNOWUlz?=
 =?utf-8?B?ZGNFWjNYMzJqSjhPUERwamw0cFAwTS90S0Q0cW9ab09YSzBBaU9oYVdudWR0?=
 =?utf-8?B?RmF4TmFZd1UyRW9CYWJGYWpoS3RWY1d0UzZYNTJBOWFFTUhoZXdYaFd3alNa?=
 =?utf-8?B?SzRCRDRkK1FwRHhqNkpOa0lOUWNCQUlLMkZKMDR5QVVxV0V5Z2cxU00xMFFu?=
 =?utf-8?B?U3hDTm9OOUxpY1NLZ0pJektrQ2V5Sk0yQWNGQlRCREkvMnVCbGxXd3lOSmg5?=
 =?utf-8?B?ajFVRm1JbWJZUkZ3UHBGV2VMbXg5SmNlTkJBNjdVUkxnQmlNN2J4bDM0ZThy?=
 =?utf-8?B?NDU2NUltVm13VUF6UXZVU3hUTFE1aUdIZ1RVU0ZVSVZMYnBRYUFHalRpZmFW?=
 =?utf-8?B?RGhKeW5tZjV6MHAxZ1R1OWt4K3JkVkdnQXBZaGtsbzJUMFNIU3JlSENrbGlR?=
 =?utf-8?B?WWhwTHhURUZCd0wrZE8xMUFIbkdYVXVjTWhTemx2cVQ0RWRHb0RxaTdNSFdn?=
 =?utf-8?B?ZWxxckdic21BU1JaZlhvWnVzNklxcStxT1hDZ05SdXU3VFEwWWFjTzJUYkJC?=
 =?utf-8?B?RjNldDNoRHVkTXBTa2l1MUJVWm04K1NxbWQ3RW1DVzlvNk5lc2w0aXZYOHc0?=
 =?utf-8?B?Vmo0Tkorbkc0eXFrREVMcGlOVHBvNmxRZUV6YWdnRklqS1RUYm95dDRmZDZr?=
 =?utf-8?B?bXBJZUZxQTVGbXVSVzF5RER3TUZPKy9qcDRyOFJYb3pHaXpWbFRIaksxUjBx?=
 =?utf-8?B?QVFLVWxPMnNLblRCOVN4UnNhcmVQa0ZPTnpaRGl0dTZzQ3R4blJjelNFZXBJ?=
 =?utf-8?B?TFhoY2FxazZvdWgwbmxsK1ZRT0g2TVJhKzlnTHBiQXROVDhZYzM4MjN2RXNO?=
 =?utf-8?B?NXR0OVFEWjdXWmQxOGlpV2hUeXRVQzFHTFBmaWFuUzhjdWlrZFJZWkhsSWds?=
 =?utf-8?B?UVhTSTNvamlLRE0vWUJFdnhXbXJZUy93MEhxM0YzVEVVVUE2WUtoTTNmdXFq?=
 =?utf-8?B?dlZNSDAvMnd2dWwwYnI4dDZmOGtYaTd0NUVkYjhlVzZuMGlncG9NZ2krTzU4?=
 =?utf-8?B?U21hNVRvdVN5cTFsdHdEYjhIOFdxTEJVOFBPSkgzeS9tZXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym1oYUhFU25IcUlKTExjOUQ4OVNDNVBFUFZuL2t2emRHSHBsL2EyYktSeE52?=
 =?utf-8?B?eXA0cFE2TXdXeWEvekRTMGNRVkxSOXFOY2ZyWTNSd1JubUdJOWNZT1NYZ3NX?=
 =?utf-8?B?amFabTdEZW80Zzg1N1Q0cmhEV2NENlplaFdKMWFyU2ZtM2lyRlg0K2FzL20y?=
 =?utf-8?B?L1RveDg4MEw4OUtNOHFZcmdDQk5zTTdiTldCaGg3bEhyWm5oRG1ZOWZqQ2lm?=
 =?utf-8?B?S2lIKzcwdFlFaGpsbzhKWFZRRlgyTkNnQ0xwSUF5clE1TGplWTRyUUY0N0l3?=
 =?utf-8?B?SHR3SlpnelYveWExdHVleXRaenc0VXprSkk5WmVjZzBEWjJCMzlwU0ZTTzAz?=
 =?utf-8?B?Q2l4NGc3bmpnL1pQaVBSYXdKN3lIQy9kZXYrTnRwdkRaYTVSL1ZhT0hPVnlu?=
 =?utf-8?B?eUtHbGhmZ29KY2FZR2ZZWXZ2SE9zZHBRZHFXenVINGZ0azJuc1VYbHFtSnJt?=
 =?utf-8?B?eHZJRzFTeWdhWDBrdGNqQy9PMHBEY09HRHhvVzkxODZCTDJCK3JiQ0Z0ZVR6?=
 =?utf-8?B?aGFyeHY1UURMc3JpNng2YUpkZjJOTW9jWDZWY1VhdS9Xb2VrYnZMNkRzd0hE?=
 =?utf-8?B?dWZxOXFCcmEzVERBcmlvbkNSRU9HMU12MmNWVENjUmd2MDlCYjd4TENzMlEy?=
 =?utf-8?B?Y3ZyQ0tsUWtCR0k1ZjgwemZYU3dXeGI1cEJlQ0V2bHE1SlVvTUJVcUlMcUNt?=
 =?utf-8?B?OW1ORWpmdDlFdDFtM04vTDhqZ04xK0hOK3h6WVVwUWNOR3JHRGlGWFVlSFBK?=
 =?utf-8?B?VTlpRGUwS3pBUnEyZ2Y4UDlrdkZpNGpSRVhBNzRBUXM5cHEwMTRJaWlSSGdu?=
 =?utf-8?B?cEhXZVp2UXk2UjNKK2t3QWtYdHZkK2VmZkR0TnZzSlJ1VGJiclNXbTREbGk1?=
 =?utf-8?B?MXlNdzlGV1pmV0hTaFJ3VlozTGlsMDNZb2hiMHBNT3dxTEl5SXlhNGk5RlhI?=
 =?utf-8?B?V1NRZHdHNEtTWkNmSGoyWmovb3Exbzh2NEpKRHVIVHpSN2Z1UEgvZ2hjS3d6?=
 =?utf-8?B?UEM1ajc5WkpuME5VczFPOUgyaWNrSmYyOVdjOE5PYXlVanZBVW8walNCYWpz?=
 =?utf-8?B?QlFOSHIrTE9BNzV5d0xqbVVCM1hWUGxiVXdlMGhMKzdLVjZMS1BUcDVUTkNM?=
 =?utf-8?B?eHhIbWZTT0NqNnI1Zm5VRXJqZVBHenBNalFqNzBJZWljeWwzTTdseit6TndU?=
 =?utf-8?B?cjNqT2dmS21pV1FMV3VwSDJuanBxNWxkQThCSmlBQWhsSXI3Ym1kMEF0M3Y4?=
 =?utf-8?B?SlJPVGU0c01PNHlxR014NVIvUlpzT0ZHQ29SM280Q3hvN1JubEgrTml1QVE5?=
 =?utf-8?B?Q3VlVERQRWxhaGFRdWprNDJjL2hxcjBpUHphYjRDS0lFTnZMc1kvcFM5WGFI?=
 =?utf-8?B?aTh6MHRpZVVwdmQ5c3Z4MGo5cnd6RVVhMFg3NEZjRzdIOTJqdVprQjk4dlpF?=
 =?utf-8?B?VzVzU0lnd0tVdmtQSkt2UTFBdGVIZUdOUEROUEVtVHlPRmRXWXlLVHg0UTkw?=
 =?utf-8?B?NEdMb0tZNS9OSVBQZ3R6TWVuNXZxV2ZidUE3M3hIQm1XL2lwSUNaZUxQNTlV?=
 =?utf-8?B?UG9wckZRRHNQZW1tMzF5YVBEOXVZMUQ4UDB0eWdMSEdyQzlBUXpkQ25xSWJF?=
 =?utf-8?B?em5QNkdPekxOWWh4YWlUR2hKU1pSQlhuQWh3MXNOR0dwdmNIekU5QjJOSmRp?=
 =?utf-8?B?QXBkZURUeWVDUW50TVlwNlR5SS9vZHBBU3o4V3k5OXlWSXdLa0pHMHQxOXVx?=
 =?utf-8?B?RkZXcTVOSXM0NFRxdXZpOGZ2UFYrS0ZGMFlvNmJJZm5jYzRwTUl5Wlp5TUY3?=
 =?utf-8?B?YjduWW82d3hGbEdpaHdpRUEwZUtVM0RvdGx3RDltSXJZOTNFL011enBRcUk0?=
 =?utf-8?B?dFQ3Y2RaNUd2NzA4aTZnQmp3blNUTzdKVHdhb2N3QjZsMU1USmZ5eUJxb3hw?=
 =?utf-8?B?ZzYrNWhSek9id3JEZUlqODQrdUluUzhFSTFWMmZvVUNGdzcyMUJHUzJ6NUxU?=
 =?utf-8?B?dFhyZnVwMjdBaE43dmI3M1B6YTJMa1hmU1lHbGpGd2VYeEM3c281T3ZoQzA1?=
 =?utf-8?B?dFhPZDhHUnFGQkU2d3hKaFRQVFIyWW5ERW9GbTBMbnAvQmpZZFZ3a25ZbEU4?=
 =?utf-8?Q?WzB+K8h9hPEqNs1W7C+MX/fmB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde9ec89-b458-4cc1-c077-08dd0b9a541a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2024 08:39:21.9998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLnAXcwQanqgmqNPe/0JxvRDHtKwf6xSfMIuAoNUSUp2hZDXNgEogfMww3yBtzMQB57R03eiYmyQqPVM/Tb0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7296
Received-SPF: pass client-ip=40.107.215.126;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHmnIgyMuaXpSAx
NTowMg0KPiBUbzogV2FmZXIgPHdhZmVyQGphZ3Vhcm1pY3JvLmNvbT47IG1zdEByZWRoYXQuY29t
Ow0KPiBqYXNvd2FuZ0ByZWRoYXQuY29tOyBncm91Z0BrYW9kLm9yZw0KPiBDYzogZXBlcmV6bWFA
cmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBBbmd1cyBDaGVuDQo+IDxhbmd1cy5j
aGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaHcvdmlydGlvOiBG
aXggZ2V0dGluZyB0aGUgY29ycmVjdCByaW5nIG51bWJlciBvbiBsb2FkaW5nDQo+IA0KPiBFeHRl
cm5hbCBNYWlsOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBPVVRTSURFIG9mIHRoZSBvcmdh
bml6YXRpb24hDQo+IERvIG5vdCBjbGljayBsaW5rcywgb3BlbiBhdHRhY2htZW50cyBvciBwcm92
aWRlIEFOWSBpbmZvcm1hdGlvbiB1bmxlc3MgeW91DQo+IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFu
ZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gSGkgV2FmZXIsDQo+IA0KPiBP
biAyMi8xMS8yNCAwMzowMCwgV2FmZXIgd3JvdGU6DQo+ID4gRnJvbTogV2FmZXIgWGllIDx3YWZl
ckBqYWd1YXJtaWNyby5jb20+DQo+ID4NCj4gPiBUaGUgdmlydGlvLTEuMiBzcGVjaWZpY2F0aW9u
IHdyaXRlczoNCj4gPg0KPiA+IDIuNy42IFRoZSBWaXJ0cXVldWUgQXZhaWxhYmxlIFJpbmc6DQo+
ID4gImlkeCBmaWVsZCBpbmRpY2F0ZXMgd2hlcmUgdGhlIGRyaXZlciB3b3VsZCBwdXQgdGhlIG5l
eHQgZGVzY3JpcHRvcg0KPiA+IGVudHJ5IGluIHRoZSByaW5nIChtb2R1bG8gdGhlIHF1ZXVlIHNp
emUpLiBUaGlzIHN0YXJ0cyBhdCAwLCBhbmQgaW5jcmVhc2VzIg0KPiANCj4gIm1vZHVsbyIgLi4u
DQo+IA0KPiA+DQo+ID4gVGhlIGlkeCB3aWxsIGluY3JlYXNlIGZyb20gMCB0byAweEZGRkYgYW5k
IHJlcGVhdCwgU28gaWR4IG1heSBiZSBsZXNzDQo+ID4gdGhhbiBsYXN0X2F2YWlsX2lkeC4NCj4g
Pg0KPiA+IEZpeGVzOiA2MTZhNjU1MiAodmlydGlvOiBhZGQgZW5kaWFuLWFtYml2YWxlbnQgc3Vw
cG9ydCB0bw0KPiA+IFZpcnRJT0RldmljZSkNCj4gDQo+IFRoaXMgY29tbWl0IGlzIG9ubHkgYWJv
dXQgZW5kaWFubmVzcy4uLiBEbyB5b3UgbWVhbiAxYWJlYjVhNjVkDQo+ICgidmlydGlvOiBmaXgg
dXAgVlEgY2hlY2tzIikgb3IgMjU4ZGM3Yzk2YiAoInZpcnRpbzogc2FuaXR5LWNoZWNrIGF2YWls
YWJsZQ0KPiBpbmRleCIpPw0KDQpUaGFua3MsIEkgbWVhbiAyNThkYzdjOTZiICgidmlydGlvOiBz
YW5pdHktY2hlY2sgYXZhaWxhYmxlIGluZGV4IikNCkkgd2lsbCBtYWtlIGNoYW5nZXMgaW4gdGhl
IG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdhZmVyIFhpZSA8
d2FmZXJAamFndWFybWljcm8uY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvdmlydGlvL3ZpcnRpby5j
IHwgOCArKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8uYyBiL2h3
L3ZpcnRpby92aXJ0aW8uYyBpbmRleA0KPiA+IGEyNmYxODkwOGUuLmFlN2Q0MDcxMTMgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby5jDQo+ID4gKysrIGIvaHcvdmlydGlvL3ZpcnRp
by5jDQo+ID4gQEAgLTMzNjIsNyArMzM2MiwxMyBAQCB2aXJ0aW9fbG9hZChWaXJ0SU9EZXZpY2Ug
KnZkZXYsIFFFTVVGaWxlICpmLCBpbnQNCj4gdmVyc2lvbl9pZCkNCj4gPiAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gPiAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAg
ICBuaGVhZHMgPSB2cmluZ19hdmFpbF9pZHgoJnZkZXYtPnZxW2ldKSAtIHZkZXYtPnZxW2ldLmxh
c3RfYXZhaWxfaWR4Ow0KPiA+ICsgICAgICAgICAgICBpZiAodnJpbmdfYXZhaWxfaWR4KCZ2ZGV2
LT52cVtpXSkgPj0gdmRldi0+dnFbaV0ubGFzdF9hdmFpbF9pZHgpIHsNCj4gPiArICAgICAgICAg
ICAgICAgIG5oZWFkcyA9IHZyaW5nX2F2YWlsX2lkeCgmdmRldi0+dnFbaV0pIC0NCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgIHZkZXYtPnZxW2ldLmxhc3RfYXZhaWxfaWR4Ow0KPiA+ICsg
ICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAgbmhlYWRzID0gVUlOVDE2
X01BWCAtIHZkZXYtPnZxW2ldLmxhc3RfYXZhaWxfaWR4ICsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgIHZyaW5nX2F2YWlsX2lkeCgmdmRldi0+dnFbaV0pICsgMTsNCj4gPiArICAgICAg
ICAgICAgfQ0KPiANCj4gLi4uICAgICAgICAgICBuaGVhZHMgJT0gVUlOVDE2X01BWDsgPw0KDQpu
aGVhZHMgY2Fubm90IGV4Y2VlZCBVSU5UMTZfTUFYLCBidXQgaXMgaW52YWxpZCBpZiBpdCBleGNl
ZWQgdnJpbmcubnVtDQoNCj4gPiAgICAgICAgICAgICAgIC8qIENoZWNrIGl0IGlzbid0IGRvaW5n
IHN0cmFuZ2UgdGhpbmdzIHdpdGggZGVzY3JpcHRvciBudW1iZXJzLiAqLw0KPiA+ICAgICAgICAg
ICAgICAgaWYgKG5oZWFkcyA+IHZkZXYtPnZxW2ldLnZyaW5nLm51bSkgew0KPiA+ICAgICAgICAg
ICAgICAgICAgIHZpcnRpb19lcnJvcih2ZGV2LCAiVlEgJWQgc2l6ZSAweCV4IEd1ZXN0IGluZGV4
IDB4JXggIg0KDQo=

