Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEE9EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlv-0001Zx-87; Tue, 10 Feb 2026 04:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjls-0001QC-7V; Tue, 10 Feb 2026 04:11:00 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlq-0004mZ-KZ; Tue, 10 Feb 2026 04:10:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwNpBxVYlmKVznJLDTtHG/MuArgwaT2GKDMB9hDcfeUG7zAHvvhNau6hOdrlAuBcoGRoIQe9F9Sk4ahq/cGx3/v1dMsZGJ9HYb9sSVWpSdHCoDlOqKF9ea/TZhsjMr9+RSXGYAZXH9zR/Zc63r3qzbKen/gwpxAlOpIhqjh8bKagpnQyzZl0jg4Ao63m2w0DkhqQbDaF+vKgRv0SYFqf3BEhkpWHTcNOlmod18QdLqxnSjpsMlv2OvwCY1PAJJB8bvPJsWamo7oQ27vlTeN2A2JU6amoov5e6U58aQVR2TMjatBPe+UJQorde2aYIS/+f70VlXV1HwWR//hNsThD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmVF+Hu280YwIRW2Y2PU2OYpm86SrAuPXXf0GR+tRTo=;
 b=yM1F+4VFYbgyHdJu9qQyrWTeh+f0fZUK3uL18vEMoe0nkKS00RqDQcebLsG32lY4E4itM0ona0FORkv09Mhu6n3pISb4AOYmN0Wk+olKpCkdL0/ya+JcIrx9cT+fxVKoJEBo5CMlBZgRXZweHkt2pQZ/f9FE7G6ImX+B1fM1S7Rrjl5aqn3UFaC3xN8U8VGSGTU6omUJLv9yWnHeZ8neH/plQu9k/TiKp6KfAAwbT1isornW3igKDNtU/ugDQkbfAF69Y332eWA1w+SOKLnekJpnZGw1jxIQi49jMi0AP9R8lToT69TrZwSjBq60RNmIwjaNPPr5HDYxrcVaEzkUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmVF+Hu280YwIRW2Y2PU2OYpm86SrAuPXXf0GR+tRTo=;
 b=R5WQ0Wguj6NdmtQWHwM/B4A/K9fu6aiiY6FWAigxy+NjONIoNkheM0SFyI6MUX14yHJGIcnY3KRr+9BIgiGz7+alGA3tqj8KOPI8VZKD+CGR0qOQhJcilRECMmFtVvSkzkrSHjRBlzzL5AgD1siQIzuXzi+hL1UmZy8bKwdn7kdj8htpQIgs2trPILkdHBJUwwFMwcglsuWuyQuRh+31FZOB1odqD9tSx8jlYOA6Nx0PkGKaJvQONhJt1s8ibUCWSbLXxdyl/qmuL6o4lc/HEjlkcw7C47ebFhcNp++vZduPp6AHFpYdCvZFgcuvG6FsCA52QrucpYbXae22DO64Iw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Titus Rwantare
 <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v5 15/21] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Topic: [PATCH v5 15/21] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Index: AQHcmm0hs+8Te5qUKkKQhXc2qeUFIg==
Date: Tue, 10 Feb 2026 09:10:41 +0000
Message-ID: <20260210091018.1553489-16-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: be24e802-1d00-48ed-b801-08de6884444d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Pbg6YnrYRo9ZZ3aSVfIlBSgGjQG2ZQR48MRV/DRRliSGcRGNjgZAo5Xgr/?=
 =?iso-8859-1?Q?wUU0HTCRk/8H0OM1JRXcP9M/FRPAmRHqulI5ktWPiL7gy/C9lts/d5XZ+2?=
 =?iso-8859-1?Q?UgXt5NqYDBGl323sk2POHoJJZ3EdfgLRdSIj3qAaDCRpIBgpmJiX0qZAii?=
 =?iso-8859-1?Q?jTkZA6P9SwXWvAkKJP49CBIfPJy+pymzuVVRCK5Qby0tCdYEfhuD0UcVPp?=
 =?iso-8859-1?Q?bBDepS2/oxuCxnTlkV/khDyG5ANA9EY0ekP2u7GSmIqmCpJ5EzWleda15w?=
 =?iso-8859-1?Q?8WlS3rzwZIS+6kdhLW8PZknpRRizyFd/vmxrM4nDYsNKSg8cLtGQkAc87U?=
 =?iso-8859-1?Q?8NqK4GMayH6A/POAtHkrRSnfsL2RIJQUMH26pqhT543TzQSuAQ4jY0PYeW?=
 =?iso-8859-1?Q?MkuYlPVSNDRv6RGHu96drjC/YPj2AEU8iBpHoavuzzJ1TjSCaWJ93ViZNl?=
 =?iso-8859-1?Q?0fEB0LREb3EJ7igWrqAfvKBYATTuQDwAGtDyRjiap1MKSRICZ5/DnJuVu/?=
 =?iso-8859-1?Q?mtxVwQElruEpJBqMjL7xDnGPE3UFcMaT8KfxgepoM3psYfLT7zOP/EOG4K?=
 =?iso-8859-1?Q?EI9GXlIkirigpu5i5Zm4sSe0gcbXs0ufS8KwI0hK6TQEBljCGY+25fz1zh?=
 =?iso-8859-1?Q?RKs/3fkLBGtLOCRLcBCI5CaT3YTP4kXYKobSWMYtRgwtC9zu2qSL+vhG9U?=
 =?iso-8859-1?Q?fHh1QtWDCW2cyEHSZPC/BaA+jvvWpkOsCvfctDN7qvKmcpAiB1uUILOm48?=
 =?iso-8859-1?Q?/9O75QsdlLU3zUuZ8SkfohmHD7/PaBxK70f5c1SN0ZALADL8G8apZiSlWY?=
 =?iso-8859-1?Q?/o9bhYSqPDJ1CVDZO6ieQCI4hRcxL0Fbh8/HXgnxHGEIiVThJLU/mfJB4y?=
 =?iso-8859-1?Q?DyXBGbIUbpitpvs8IL9btrqLSOdeiHEJnabuGWJuoutAH7uY3CE96SKubK?=
 =?iso-8859-1?Q?2HgsucV7u0HINS8fd6H6uFUMY/IPDGTwWHfHKGN3ZdYTVgh/g6Y/E+9WlZ?=
 =?iso-8859-1?Q?bAtf0OBdvEAKUufsPNNX+tuH2PM6MgZNkRMy8MHFyI/COKcvRg4/YzBUyf?=
 =?iso-8859-1?Q?3ici1EZd0GQJoDkYSVA9aVDJMCjTjuaERatBOomvdpPcntmMZjBb1I1gES?=
 =?iso-8859-1?Q?Y8FzgnrC6JoCZ1xHUofwp11+bdG6AoGgoUYmClDkGA+EqwFl9PvmYcJVrx?=
 =?iso-8859-1?Q?9FZgbEAJFPwbZbMhrFqa3ES1mIydlvzOHxVigQfN01qhWmMC57CSGxqB4h?=
 =?iso-8859-1?Q?a+HkgmxL3Id408Z+ebmlzuag3ekRM9rlqSuM3dj10ZxJfGvVZ3hzIiCV2z?=
 =?iso-8859-1?Q?xUSjwa0sDa33cQnayFmS5AUBKV28o/6f0ybsirzjpjcYswgQKYd58624Qh?=
 =?iso-8859-1?Q?mnRlHbQ1OHwKDxlE/UlfxM5YVPrLsJ12vID7UiTCtWcopP+Xd6x206GQcv?=
 =?iso-8859-1?Q?tbZT2Er7072SQIIduBJD6Ghn3ySu3hMtbkzP7HKFxTVGBoovvceQp2xNye?=
 =?iso-8859-1?Q?uQQvNP4DPkvQfPvTSFqsEi1/8C8krzZThHlaw8IfJm2GrLEqHduIAmcKOb?=
 =?iso-8859-1?Q?ZsfaaDENI/cu+SJOtbIwFKVGiWTuUiDnhBtTZB7uT+gBuBeRUD7+fDXOz1?=
 =?iso-8859-1?Q?NgWFvigV1W5zmzjEXm+wT0J5yEH0Lr7eBtos+odL3sH2q7y3WiYSmmm+Zi?=
 =?iso-8859-1?Q?n4a5EuT6Oq0OrNKPbELwdUgs5wVmiTEJrsHI0KRk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3+dIQEwTNCoPd6VaoWumc5DuostDVReypjlcin544IUdTJSYSnztDX/1iP?=
 =?iso-8859-1?Q?yEUvUQODpNm0xjN2WZDE1P/JCG741IFS/8gISaBcwGpH1jw3xudhVULZ7L?=
 =?iso-8859-1?Q?0hBgtHgkoBBh34d0LnViguEj8PB1SurUoUfs79UtXUSRsxY4YxxvaRum50?=
 =?iso-8859-1?Q?osHatx0EqZERwgDFdUQ+HRLzRA9feROm427Whodck+xgbsjXwWPNqDN1ba?=
 =?iso-8859-1?Q?dw2IQW7pW/dj7862UyOBuBUynyEP0vFdlJZyzkgn8gAImKgXK6yIeVb06k?=
 =?iso-8859-1?Q?/dhMhKSye2V6huB1ojacunkYovWv1CFowsSoLeo+t4H+mXDT0rEIEqQP6n?=
 =?iso-8859-1?Q?PlPTYFIo1Y42AiEbgGK8KZHkojWrS9g9ml/zT3ghc5EOXtNvTCNtRQJ659?=
 =?iso-8859-1?Q?N2rMMKl57j28dBnmoI7Dz3lDXKU9OL4GQ4ZAyi9tXf77QQllBNdY321+JL?=
 =?iso-8859-1?Q?rP7MRqHzYNRibbNu5N5frTjnVTFMovyJ/uKmwCcSIrr7tIFdp27CvyjyuU?=
 =?iso-8859-1?Q?aM7g8TurKR/Hy08dkZDrZMx6G3yLm109f2GJ59XyA7f9gHHbZC9St6sJMn?=
 =?iso-8859-1?Q?9Uybk2Atio66lkbYGh0dsW86jOjli/9lzC5SsfEXcfNPrASyWXTAo8JNdB?=
 =?iso-8859-1?Q?ngDMQ3WHbDSEPmHrGzSuO80q0i5P5YJzy2HQDKuKalua5VcL/UErbH7adV?=
 =?iso-8859-1?Q?9Lj+2HBfQVXTuzvq1XgDMkjL+skdHdTG51bQLthCBDOsKQCEBxAUmfKK25?=
 =?iso-8859-1?Q?zG3d2C8GUa/d4PNvzUJ3jSljd59lM49Kk9eP/2ii/slDzcwu8F6g92z396?=
 =?iso-8859-1?Q?v/ggN7uWt1XgVx0Nu18Uz/YGnMxyQYFKThWLRIwxypDZuzdBCyvZ7femnm?=
 =?iso-8859-1?Q?W6u58g8XcSxHGALRqybcvuGLJtcY2gdqFfcm+EFnvYLkYWn1cx0Ok1ugx4?=
 =?iso-8859-1?Q?CxGA9fkTE8aMfYsTlcsB0B6KwScJT4Ypcxnsiy3gerU+wX62FsKB4f+cVw?=
 =?iso-8859-1?Q?aCO4UODae3u5U2rJ3yuqpCkFEGksOVhNs6Bsfci4DV0+S4jht7gSshG3yS?=
 =?iso-8859-1?Q?k6JiYA3AbuK/0x/6Ednwdi7MtLddENdu8qMip+gchJS8tdKvN6GYf+BlNl?=
 =?iso-8859-1?Q?08KnXK8MZp/jHIaNMD+2/TVKnhAWoYQk7119/xqJT3Uc3Z4RE4XCxvbtkY?=
 =?iso-8859-1?Q?NDTpLeJJPKtqKZzTN8nVLyGwDBs7RHn11zzAFCFJ5WJNKrkLjiaJzDl90M?=
 =?iso-8859-1?Q?jmrsLzV5/ZPaBknjC/UVOOTg0+xxF4ePjM8/L0ObJgWdb1hYGxRHpzRvH+?=
 =?iso-8859-1?Q?pwyzBcsfLLqWRBO4lRar/A0LgrkANtmq2o7clQUu4pAMJKEi7bmJN9w85e?=
 =?iso-8859-1?Q?DoJTlUZgFuJ4/BGsO3ncak6oXSKnYmUNm9bqMZ0eHj1QMRmztSmfnzkPzA?=
 =?iso-8859-1?Q?/G3+HLaf7JmCjl3fH/efUOXeuC0V2PzsRn95IsJgVu3PsCTXd/fgVjz6lG?=
 =?iso-8859-1?Q?Np2dtyD994zMdK2ak1+uhA/HBSExC/tTm1IRkPaswWYnnBos0b9abTPKA/?=
 =?iso-8859-1?Q?IqTzvtsPOzXQ08uWEIYmVrK8VvmEBIVJfgpbfiKzjutCHLiwVhYn1Vs3lD?=
 =?iso-8859-1?Q?zE7U43MVkep8Sl8kxpcm+tLYP3zj0BSfRF9a84C/QO1QQYCLDC/J7UCVPU?=
 =?iso-8859-1?Q?TGsl0Rju2jp1iwVX/9a8NOanvPIo53BWfpk6o678O3AC/Tsrk2rZH4FPTn?=
 =?iso-8859-1?Q?yuS6UfQguqM34hp6JrgM8lT2Ryrd0Lmv9Tcfk/Q1FyiLqjpGwTspNpC+uU?=
 =?iso-8859-1?Q?6hSst7LWcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be24e802-1d00-48ed-b801-08de6884444d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:41.3372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bZc7beam3w+iqEWr3jusByQdyvMi5WS3PV3p3BOFNylXhiq5ENY6azugKG8/prvwjz0Q2CGLLCLZm/Ma73jUtAidUxz0kxXR6NLdFwtwCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Adds functionality to the CTRL register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 35 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 832fcf326a..b6ec0d9579 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -344,6 +344,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s);=0A=
+=0A=
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
 {=0A=
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
@@ -503,6 +505,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uin=
t8_t *data,=0A=
     return ret;=0A=
 }=0A=
 =0A=
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /*=0A=
+     * If the user is setting I3C_RESUME, the controller was halted.=0A=
+     * Try and resume execution and leave the bit cleared.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);=0A=
+    }=0A=
+    /*=0A=
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP i=
s=0A=
+     * sent.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/true);=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    /* Update present state. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+=0A=
+    s->regs[R_DEVICE_CTRL] =3D val;=0A=
+}=0A=
+=0A=
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
 {=0A=
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
@@ -1575,6 +1607,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       "] =3D 0x%08" PRIx64 "\n",=0A=
                       __func__, offset, value);=0A=
         break;=0A=
+    case R_DEVICE_CTRL:=0A=
+        dw_i3c_ctrl_w(s, val32);=0A=
+        break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
         dw_i3c_push_tx(s, val32);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

