Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B72DCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 07:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQ9U-0001UW-8f; Tue, 16 Sep 2025 03:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyQ9R-0001TY-15; Tue, 16 Sep 2025 03:30:57 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyQ9G-0006gT-S2; Tue, 16 Sep 2025 03:30:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrh5WqopggsG56IfrR12+jvHamwtSoo3XPU7qS65ychVABdSoIF+Z+/eseLzWR72v+lGgOSC6GQrP40dIwicGpeqX+ZG9ldqHljck6v9F76Agj8k0a4eyGNXuJ1YTQB52CLoVZ2bTIbFTTa0CFhFREgd4b80zsr04wFInimgx34VYBoJyjWadwgtfwE+grK9gvYu7La1+mTaEIlkC41FcamFMYl6K0JFjBbJKl29qws2moANRSgc7OkIKeDUVlgL2RawOyCjabiXMhcR9jYiYPzQ/LeXLm4+smNlBQD/iQS4LqLxhgwtOYw+pZGvimbn20PV0yTPluB+dqqDwxqafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqX5fRb0qxTUchlLth1IHqUfMFv2YiwJx8DPyzbLnM8=;
 b=FxWvlz8sava4yUVG/mnaDsoYx03opzazO2iuKyJFyf8OFbQUOxsfGLjP9H4daN3tG+XfARICqJFDkMbynKjOZGY5BovyHshoUp89IdSMiVDqKq1cJ1ZXUOGgv1AIB0YpGlCcjSdVfyGsNC7V1HrzAGBm9+0GGZOPb6DipIQpwrqk25swGnba9sVatEnUwGFAALKzNYjMR9UqH2gzc45be3cE3Ecfr82Weml/IwjAO9WBrBAd7XC/sSx8KA9zpaPdywO5hCLH0KXDrWg8hozavmMU3uIwPVWAx38VN4zXgADUqw4+YO0dahLsI/i6WxlKe9066atjIihwu7RIYBffdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqX5fRb0qxTUchlLth1IHqUfMFv2YiwJx8DPyzbLnM8=;
 b=V26PFhZtm5qoHqw5xB64QwXZtxorfss1V10bfBzxwXc3mg7tjHi3GljEMY95ck6umYZnffNRq2L9LJVD7Qp4xYaRWj+p8gJy9M0FQTg01LQ7MWrEmsh/jDe6juzfA6FwE8AnAevptty1NVfpkkRD20y1btKPSM7NXRB0k4EePWlfrCERxnWJlqxnMPEiKmZDiMpx6xXmvWSShwduNeSE2PACgxXN24vfhBBbOKMjHUYnXT2gB7ueZ/+MZg0S6deyYsuXkOm9twiQOtk4kMAusEhqCUuz3XWH2EEPe2xOzDRinnoPpqHDT70lZxJl+gyWZYh/bokbFhl3U6hIcjoP9g==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB7016.apcprd06.prod.outlook.com (2603:1096:990:6f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Tue, 16 Sep 2025 07:30:28 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:30:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: [SPAM] [PATCH v2 13/14] tests/functional/arm/test_aspeed_ast2600:
 add PCIe enumeration test
Thread-Topic: [SPAM] [PATCH v2 13/14]
 tests/functional/arm/test_aspeed_ast2600: add PCIe enumeration test
Thread-Index: AQHcIu00cXB6uwmS3UCbqmacudbgSbSUhImAgADp/YA=
Date: Tue, 16 Sep 2025 07:30:28 +0000
Message-ID: <SI2PR06MB5041375C3586349460CD73D0FC14A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-14-jamin_lin@aspeedtech.com>
 <1d990b45-9188-4631-a819-c32257dec558@kaod.org>
In-Reply-To: <1d990b45-9188-4631-a819-c32257dec558@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB7016:EE_
x-ms-office365-filtering-correlation-id: 93e7f894-7090-48b2-aa1c-08ddf4f2e8ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?dHByTFlFOExnbTZKYW51Smx0RGFXQWxNYUtLNHg5Uzh6R1dNV1M0VFVUaTA4?=
 =?utf-8?B?QWpnZzN5SnRPR2hORGpDTXhRYTRhSlZpZG11NlZKYlM0d3p3RytMY3FjS0Zp?=
 =?utf-8?B?KzdYRWVPdzNSOXRlMnNtcnBIMmY1UUFrSXpmR0lpWEhpamU3cWxtcHIwOUJK?=
 =?utf-8?B?blFXdjF5K3kwZTNGSng3Ri9kZlZHeE16Q3Z6dXBaK0xEUHdKbyt5bVBHY2kw?=
 =?utf-8?B?ZGp6Ui96Vlh1M0JlZmt3WFRYYlZpcUZwVFBjUk1TbHZHTjYxQW1mNGMvZXBq?=
 =?utf-8?B?Slh3Z2F6Q3pMTG1NYjdvT21uYXM2bmJVYm9FWXFaUGJUaUpPM25XajBDVVc0?=
 =?utf-8?B?ZVQyUnVNUkwvOGtveUFwazd4UHVDZnhuL01vdDlWcVpaRXRRbEJqMldtZDZm?=
 =?utf-8?B?elJ2RkRKZmdZMjkvc1ZxME1hT203NnEySWRUcWJ6U24xRmIrbmRqeTdLL1VH?=
 =?utf-8?B?NHhqM2N3T09ubWtmMDMyUmRzd245RTgvWlNSd0RTdWwxUFhnTUZ3a3dvMzUw?=
 =?utf-8?B?TkJ0Zk5vM0liSWxwR0hGdjFTWlloTHBjZjJNRUQ1WG5PTE1Rb2lwU2pXSXV6?=
 =?utf-8?B?NiszS05INWQ2RVlZY25POHo1VTRFOGM4ZjBLL3M2Tk1lbklsd1RKY1B2Y1E4?=
 =?utf-8?B?ZXduYjBjMndOVUMxd0d3WU9neFBaMTBwNm9Cd2VjcFlGVTQycUttbFRudkpP?=
 =?utf-8?B?ZXM4VkZBbjgrK1g3Y01vRURXTmdTZEI4OHZCR01PbjV1YmlCTkU2Q1pWVlVj?=
 =?utf-8?B?M1dqb28zOUdQeVJGK3Urd0Z6ejhzYWU3K1RqclFnSDhaL1IrSzl2bWZqanE3?=
 =?utf-8?B?V0MzaFhmeU5IaWJ3TkR5c1E3VVFXZGIwYXhaLzUvRzhaMTBDeTlPQTdsbG9K?=
 =?utf-8?B?SEplU3BiVXZQRUNnYnJyR2V0bHY0ZDVTMXhGNkovbWQ3THVPTW1XdmhoL1gz?=
 =?utf-8?B?eGZyNnR1SDB4M0E2dFFiOS8wZ0w4VlBXc0gweFRXc1lCcEtXOWNUY1RLSFQx?=
 =?utf-8?B?MHVJMUhFU1B4bnpmY200T1RXMGtEcWN6dGRJeUo3VE1rZ1RUR3dFZmtMVUhJ?=
 =?utf-8?B?T2lDNTVocFVSY3I1am5NZ1pwbWd3RTM5dTJlWEVPSW9wSGQ5U3FvRVlGaGhV?=
 =?utf-8?B?T0FFaXQxOG5RU0pBQVlTS3ZveVIvT2JwYUxubkVuOEhRUXFmZ2JxSklZN2xH?=
 =?utf-8?B?cVlQR2thOHZIUVNaL2krRDczRmdkbW1vWDhETkZoZ1p0TWNXQnd4Tnp0VVlV?=
 =?utf-8?B?aXB3Z1BMWXJIa1lGT2JpU2VJK3lhWFhkL0lxVFE4Z0lqcnU3OFA4NXVWbnMv?=
 =?utf-8?B?YndMbHE5c2tNVjB5SE5WREp5WFRleGZHZXJ4T0RjR1dFZitzTW15U080a1lp?=
 =?utf-8?B?K3FwUEF1Nm8wejFFWTM0VmxLcjFZWlNONmpnakJ2NWNUTXFnYkJkeTl4QTVW?=
 =?utf-8?B?dmwxaDBtMHdJYllmdXFIZTJkSEx6b3pqelBYOFVTZ2Z5NEEzclZvZ09EVWo2?=
 =?utf-8?B?cXlwUitVemhxMksxd1EvdWdmaS9QajZUZnVnRG5ySTByZXhhYWs1d1NkUC9m?=
 =?utf-8?B?Y2RvOFM2RmtjcllBajVmdW5xSG1mN2VxZ3hSaktsVmxUVUI5NlZvSWJDd3ll?=
 =?utf-8?B?ejYyblZGaHJBbExoZTQ1enZPdkEzaWlFYjhWcFJ2bU0wZTFGZWdNWWsyUDdZ?=
 =?utf-8?B?WjFiTW5GZ2lZSUFjTjM3TTVJZTNTOHVlZXZoZXE5NVU2alNXS1BQSDdwb1RL?=
 =?utf-8?B?UExjM0NMbnNQdThadGU0c2doS2VVYk9XSDkvUklzQk0vRC8yQ2lRVzczdWlQ?=
 =?utf-8?B?N29OdENJaXNha0lqbzlJVk9CbWwySVVBeHZsSHhxZEgxakJhSkx3ZWErVHNR?=
 =?utf-8?B?aTkvR2lVcVNKM2Y2UU5OemlPbWVVVmhERldmajhzMENKNVpjWVArOTdWaGtX?=
 =?utf-8?B?akwvby9sUjhXRG9CczhuUGJYQ3NuN01QTGNpZjNxMVFFdjgweUNiUndnS2Mw?=
 =?utf-8?B?T0tnS0NDZ294UXYydFdnWVBqL2N3QkgzK1RNZzZnay9QbjRwUU0rSDR3ZStP?=
 =?utf-8?B?OS9kc2dYeTYvMFRhMFhCWjNyMEtsbFhrNXJzdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azV1dFYwUHhtSFE5SGVPeTVqRVVqckxoM0tIa2g4dXR1NXBIam1kNmN1clAx?=
 =?utf-8?B?bmdKcG5KTzc3UElEV3RBQ1Q0R2ZVNkRJRmZnaU04TDZNdUFMUVJPKzhyWFNK?=
 =?utf-8?B?VHBOMEhKN2pHTnp0bVlTUlhQUmtibldwYmtBZkJMZUVENzNzdjJCZkFJUHlE?=
 =?utf-8?B?VjJoaUxuSUVJUWowcGNkVE1tU1h6VENjTzlzcGJNV1U5dEtVa0YzWjlXRDZO?=
 =?utf-8?B?RVV0Qnk1dnh3ZTFaREh6c2NqUllpbUhWV2k5NWJuLytDR3FCdUJkNFE4NXI5?=
 =?utf-8?B?cnI1Sm9EU2lLSm1oUmwzMTlNWWZqWk0zWS9VTlkzWUlZVXVHN25jUmhDaGtx?=
 =?utf-8?B?TlFwMCt0RTVwaHJCUmpuSDFwSmdiaUN5R2RBVW0rRDJ2NU5aYVZpL0s1YXJG?=
 =?utf-8?B?dkZaVTZGVFBqV29JejdnNzI2aDRQZVpOWXRNRFpDOFZOYm1OS1o2b1ZLNG41?=
 =?utf-8?B?S2ZnaWZZUTlSN3lNcHUvOG9OSGo1N2NyUWpqQm5hbEo1SWFmUU9QbGtNSVBw?=
 =?utf-8?B?Sng3eVMvN21nQ2poOUhsZkhpY0ZjakRlcjBqRmlNcms2emwyNkRKUDZPSHZI?=
 =?utf-8?B?UG05NjJac3FJejhxQkhjSzk0WG1DREF6dS9rUGtTOGRwYmZudUVCank5NGMw?=
 =?utf-8?B?S3hoU3R1bThIbGxEV0svWktIbGZhTVV4aDBxdUo0ajRjb1V3T2lOWUI1VmZD?=
 =?utf-8?B?MnNIUXdjc0tMV3lUWWYyK2tCU1dBR0h0QWNjZG1kZ2xxSW85Yys5eDk1Mzd1?=
 =?utf-8?B?UWlaL0Y4Qm9XWUZVckcyanp5SDJEWm9ZZkVjS053S25CeGRqSWR2aWRQUDBO?=
 =?utf-8?B?WVdpZ2NndFVGS2RtS1g4Y3hrTE5pT1BVWHVqOGV4anBHMjAxclZSWWVMTHNQ?=
 =?utf-8?B?RWRhbE9PcGc1eGZtTmJKWC8vaC9IUm1pUFVVTzJZakN3MG90UCtsR0psTDdH?=
 =?utf-8?B?QUpMVXVrenFnRlV0NENqeHM1OWlKZW1xNjNTSXR6ZHUxZllZRGtVZVJ4RW95?=
 =?utf-8?B?d2NDdm5NSzNucnRpc0k5NFZULzRHbXpJUUJvSCtyc2Zud3cwK3NyKzFKK1pL?=
 =?utf-8?B?TWdUK3BpcFFacFNJYVVxeHhiaHViR0duYW1EQlo1dkVzU1VVd1dnSlh1bGVD?=
 =?utf-8?B?d2pBRHE1elVKLzZsakhnRndLQ3N4L1NubzMwUG9CWHlqd09WTnVKSEhBMXFL?=
 =?utf-8?B?L0xzWmVaYkY0d1lKR1ZUT09uSlF4bmdBVWllWmpPZFpjbVNySjI1bkdHU1JO?=
 =?utf-8?B?b1kyaDN5RnVxNHBQaHE5TDFENUhTTHNJdGZuRUN4NzRGQy9PTVNYTGtNR1F0?=
 =?utf-8?B?blNFanlST3g4NHI5MWtlQU1tZDBUcTNmYzRnOENrSW5RTlFPNnQ4cFRhQjUr?=
 =?utf-8?B?R2gxbWczMHdxeE9lbk5VZzdOeVZ1RWkycEQ1ZE9JSGFJc2d1MmMvYTNPbWtz?=
 =?utf-8?B?Ym9Ua29zTWV4UVZhUXlFeXVYa01jemJlaERSVGUyU3ZRTE9yeFB2SnhNbnpU?=
 =?utf-8?B?TDZzSGpTYkVURTBMbEhReThLczdtZWFZRUJ6OHNNd0kxemMxaDkxT1Qya1o1?=
 =?utf-8?B?RHdTMm9EdnQvZUpib0VTSUd4bVB3c3dMKzBUQTh6SmI0L2h0TEp6Q3hvQ1BZ?=
 =?utf-8?B?Y2hQY0l2VjZ3RlhmSVlmbXpMYVZZa0VkSEw5NTBBK0NwTGlacDk1cDgzaWJv?=
 =?utf-8?B?RWNKRk81bUJSelRRNVZReHBydjdXZ2hXYzNGWWtheTl6VkdNWEE3TkxwN3V4?=
 =?utf-8?B?aE0yaTRyaGoyZ0VlRzVkcmdMUWRTb2YrTGpXYmxldFR5N1ZudlVtVVo2RVV4?=
 =?utf-8?B?ZlpRUnRvTWtNR0RVc3U1MVR4eXp2eU1wWmlpY1JkTXpGNGJCSzZvTzhUWEdZ?=
 =?utf-8?B?NCs3WXdFT1pqaEtPSzBJZUVtL0NiMVlyMzZLb1VmTzVUMVMzRTRXL29jekJj?=
 =?utf-8?B?RmlsWEgveFI2S2h3Nnc3aFUrVkxOeWJXaEtLcGFNUEVLalFsN3FjTG45Sm81?=
 =?utf-8?B?aklUT21wZkV6Mk1NUHYwV1pRM1hyL3VIb3FxSmZSMjE4OE5TWTNGdlVueE1F?=
 =?utf-8?B?YksyQjFpcVlPZ2pHQWdZbjdnem5adXBhaXdkRHd1WjJyTElHUVU4NmU4eVlY?=
 =?utf-8?Q?IiGvuwuj4xSspjQXnxyx3xfB9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e7f894-7090-48b2-aa1c-08ddf4f2e8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 07:30:28.0942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kh9jfhHjyD4ZJfbs7iWyK9FvSRI0wqe7IRY6yNiuPmAoynCcRZO5mpCrUKS8GB+oOROHUaHPwPTu1FbOliTr+5pK/wbjg03iR3u7o/7tHMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7016
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

SGkgQ8OpZHJpYw0KDQo+IHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDA6
IGFkZCBQQ0llIGVudW1lcmF0aW9uIHRlc3QNCj4gDQo+IE9uIDkvMTEvMjUgMDk6MjQsIEphbWlu
IExpbiB3cm90ZToNCj4gPiBFeHRlbmQgdGhlIEFTVDI2MDAgZnVuY3Rpb25hbCB0ZXN0cyB3aXRo
IGEgUENJZSBlbnVtZXJhdGlvbiBjaGVjay4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNl
cyBhIG5ldyBoZWxwZXIgImRvX2FzdDI2MDBfcGNpZV90ZXN0KCkiIHRoYXQgcnVucw0KPiA+ICJs
c3BjaSIgb24gdGhlIGVtdWxhdGVkIHN5c3RlbSBhbmQgdmVyaWZpZXMgdGhlIHByZXNlbmNlIG9m
IHRoZQ0KPiA+IGV4cGVjdGVkIFBDSWUgZGV2aWNlczoNCj4gPg0KPiA+IC0gODA6MDAuMCBIb3N0
IGJyaWRnZTogQVNQRUVEIFRlY2hub2xvZ3ksIEluYy4gRGV2aWNlIDI2MDANCj4gPiAtIDgwOjA4
LjAgUENJIGJyaWRnZTogQVNQRUVEIFRlY2hub2xvZ3ksIEluYy4gQVNUMTE1MCBQQ0ktdG8tUENJ
DQo+ID4gQnJpZGdlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rl
c3RfYXNwZWVkX2FzdDI2MDAucHkgfCAxMCArKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9u
YWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDAucHkNCj4gPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJt
L3Rlc3RfYXNwZWVkX2FzdDI2MDAucHkNCj4gPiBpbmRleCAxMjk2OTVjYTRlLi5mOTdmYmJhYTEx
IDEwMDc1NQ0KPiA+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2
MDAucHkNCj4gPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAw
LnB5DQo+ID4gQEAgLTEwMSw2ICsxMDEsMTQgQEAgZGVmIHRlc3RfYXJtX2FzdDI2MDBfZXZiX2J1
aWxkcm9vdF90cG0oc2VsZik6DQo+ID4NCj4gJ2h0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNo
LUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4wNy9hc3QNCj4gMjYwMC1kZWZhdWx0
LW9ibWMudGFyLmd6JywNCj4gPg0KPiA+DQo+ICdjYjZjMDg1OTViY2JiYTE2NzJjZTcxNmIwNjhi
YTRlNDhlZGExZWQ5YWJlNzhhMDdiMzAzOTJiYTIyNzhmZWJhJw0KPiApDQo+ID4NCj4gPiArICAg
IGRlZiBkb19hc3QyNjAwX3BjaWVfdGVzdChzZWxmKToNCj4gPiArICAgICAgICBleGVjX2NvbW1h
bmRfYW5kX3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwNCj4gPiArICAgICAgICAgICAgJ2xzcGNpIC1z
IDgwOjAwLjAnLA0KPiA+ICsgICAgICAgICAgICAnODA6MDAuMCBIb3N0IGJyaWRnZTogQVNQRUVE
IFRlY2hub2xvZ3ksIEluYy4gRGV2aWNlIDI2MDAnKQ0KPiA+ICsgICAgICAgIGV4ZWNfY29tbWFu
ZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLA0KPiA+ICsgICAgICAgICAgICAnbHNwY2kgLXMg
ODA6MDguMCcsDQo+ID4gKyAgICAgICAgICAgICc4MDowOC4wIFBDSSBicmlkZ2U6IEFTUEVFRCBU
ZWNobm9sb2d5LCBJbmMuIEFTVDExNTANCj4gPiArIFBDSS10by1QQ0kgQnJpZGdlJykNCj4gPiAr
DQo+IA0KPiBJIHdvdWxkIGFkZCAnLWRldmljZSBlMTAwMGUsbmV0ZGV2PW5ldDEsYnVzPXBjaWUu
MCAtbmV0ZGV2IHVzZXIsaWQ9bmV0MScgYW5kDQo+IGNoZWNrIHRoYXQgYW4gSVAgYWRkcmVzcyBp
cyBhc3NpZ25lZCB0byB0aGUgaW50ZXJmYWNlLg0KPiANCj4gDQpUaGFua3MgZm9yIHlvdXIgcmV2
aWV3IGFuZCBzdWdnZXN0aW9uLg0KSSB3aWxsIGFkZCBhIHRlc3QgZm9yIHRoZSBlMTAwMGUgZGV2
aWNlIG9uIEFTVDI2MDAuDQoNCkkgYWxzbyBoYXZlIGEgcXVlc3Rpb24gcmVnYXJkaW5nIEFTVDI3
MDA6DQoNCjEuIFNESyB2MDkuMDYgZG9lcyBub3QgaW5jbHVkZSBhIGJ1aWx0LWluIGUxMDAwZSBk
cml2ZXIuDQoyLiBBU1QyNzAwIEEwIGRvZXMgbm90IHN1cHBvcnQgUENJZSBSQy4NCg0KR2l2ZW4g
dGhlc2UgbGltaXRhdGlvbnMsIGlmIHdlIHdhbnQgdG8gdGVzdCBlMTAwMGUgb24gQVNUMjcwMCwg
Y2FuIEkgb25seSBhZGQgYSB0ZXN0IGNhc2UgZm9yIHRoZSBBU1QyNzAwIHZib290cm9tPw0KDQox
LiBUaGUgQVNUMjcwMCBGQyBTREsgaXMgc3RpbGwgb24gdjA5LjA2IGFuZCBjYW5ub3QgYmUgdXBn
cmFkZWQgdG8gdjA5LjA3IHVudGlsIHRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VyaWVzIGlzIGFwcGxp
ZWQ6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zl
ci8yMDI1MDcxNzAzNDA1NC4xOTAzOTkxLTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLw0KDQoy
LiBUaGUgbWFudWFsIGRldmljZSBsb2FkZXIgY2Fubm90IGJlIHVwZGF0ZWQgdG8gU0RLIHYwOS4w
NyBiZWNhdXNlIG9mIHRoaXMgY29tbWl0DQpodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1C
TUMvb3BlbmJtYy9jb21taXQvMTdmN2EyNTlmM2E0ZDA1MmI5ZWE5MzM1M2EzNDAwMDQwZjM5OTky
ZQ0KDQpTdGFydGluZyBmcm9tIFNESyB2MDkuMDcsIHUtYm9vdC1ub2R0Yi5iaW4gaXMgbm8gbG9u
Z2VyIHNoaXBwZWQuDQpJZiB3ZSB3YW50IHRvIHN1cHBvcnQgaXQsIHdlIGNhbiBnZW5lcmF0ZSBp
dCBtYW51YWxseSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZHM6DQoNCmR1bXBpbWFnZSAtVCBm
bGF0X2R0IC1wIDAgLW8gdS1ib290LW5vZHRiLmJpbiB1LWJvb3QuYmluDQpkdW1waW1hZ2UgLVQg
ZmxhdF9kdCAtcCAxIC1vIHUtYm9vdC5kdGIgdS1ib290LmJpbg0KDQpIb3dldmVyLCBJIGFtIG5v
dCBzdXJlIGhvdyB0byBpbnN0YWxsIHRoZSBkdW1waW1hZ2UgdG9vbCBpbiB0aGUgdGVzdCBlbnZp
cm9ubWVudC4NCkNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBtZSBhbnkgc3VnZ2VzdGlvbj8NCg0KVGhh
bmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiAgICAgICBk
ZWYgdGVzdF9hcm1fYXN0MjYwMF9ldmJfc2RrKHNlbGYpOg0KPiA+ICAgICAgICAgICBzZWxmLnNl
dF9tYWNoaW5lKCdhc3QyNjAwLWV2YicpDQo+ID4NCj4gPiBAQCAtMTM2LDUgKzE0NCw3IEBAIGRl
ZiB0ZXN0X2FybV9hc3QyNjAwX2V2Yl9zZGsoc2VsZik6DQo+ID4gICAgICAgICAgIGV4ZWNfY29t
bWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLA0KPiA+ICAgICAgICAgICAgICAgICcvc2Jp
bi9od2Nsb2NrIC1mIC9kZXYvcnRjMScsIHllYXIpDQo+ID4NCj4gPiArICAgICAgICBzZWxmLmRv
X2FzdDI2MDBfcGNpZV90ZXN0KCkNCj4gPiArDQo+ID4gICBpZiBfX25hbWVfXyA9PSAnX19tYWlu
X18nOg0KPiA+ICAgICAgIEFzcGVlZFRlc3QubWFpbigpDQoNCg==

