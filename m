Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74689C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4b-0004aJ-2u; Fri, 21 Feb 2025 03:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Z-0004ZP-AX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:47 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4W-0005ke-Md
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125264; x=1771661264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PiyTkK6hdM98UWkbkeuE8WtZivWls1Pdx4DsUKcW/KM=;
 b=w07vAlrBr70Cp3quNQbDe2oiCkh2g1UGt6gCdAEX3u3lkiJMsQ4qQNVU
 7GRhGzBWkmXyWsxWV6wT2B4cHtiCZ4gAAQZKUZIqA7kR0bmXzpBW5W8mH
 12NVYWIX3dlgdpwSbhfiIyL/X8gVR2tLT2MbPTgGqWgrQ/q/zrxoKHJYX
 8QCvoV8lfbzUnQrWmrZARo90Gn5FHna7yAyHo+7K901UK33uiVBr0qGdI
 Gtj05ogPwJd63UcYzeXnyW0M9Xn8gw9N5NP6lg5pfkT7M2c5AwR604fXF
 db4/PV9N6BvYbjU2U9XJITEwcq03FcnUS41oGTFIBwapZPvq6GEbzxfdK Q==;
X-CSE-ConnectionGUID: RUNfYzbrRuuRgshl69j4xQ==
X-CSE-MsgGUID: 8IuULMadSRKAHG+cqmue/A==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836652"
X-MGA-submission: =?us-ascii?q?MDFu6qCHClwEPa1/3MExJdE0ghoVtztjk5A4RK?=
 =?us-ascii?q?AEbPchmxYincLyugEpacCVlCMFUZNa8XZmFBEYHQi9MozGcfWd4GqMq+?=
 =?us-ascii?q?Hdd2a1vqyoN4bVuCq+T0TSY+C9wyP2Rr+vv8xql0a1wr+NWOCClAwWH0?=
 =?us-ascii?q?pa4X+9e5llaIe99VHtHWiMAQ=3D=3D?=
Received: from mail-vi1eur05lp2172.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.172])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHs/9FjWLM0xxWY8kc1y3sAR6WcqFsoFLPKBjMhT7qfFivT15zfzEFWFH4WtUB2Y0KzgQC5vCjpslwlEji0xs9EUSBbilGqEXiZX6ybrpkbfllqwAsd7xuonLIPkd6FZC1bw8Ef86c9VTU8+bK7xIH0u8YOx/fuYngaggJpdEczJOrW+xBfAr5fGDn56gEktpaetcsENtCu6yk5sn5yArIlpU37WT8vVqw3rl97yMDzM0oHEUFwybUYRijB9Ski4TaaOh2IqyZ7PqwqSiixSUscQz3fnLOvuiJVw2MTnvWVGhuGh2k/VvriZAOlI+TgS7qh+v/f9YO3fn3sMhaE2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EcOu+TOcfbfDadm1pZd77Y5A6tl5Nr6dRcZJCVh2AY=;
 b=Nw+OREfvwP7Tn+ItlQvwIEFPeojuRlmxvQiQokrpmyInc2w7RwsHy63arcyG4VJjtiO8dLoAa6J9Y03tLmjB18yVsm/JLxU8lZUUodXTnrhtMDaq1CR6UvW2phYLNKBhRSaTW0c4/rCE0ZjT+Mva3ixej9JGt9Gihnw3PkP15IdCkI5pkNtYRsqtIgXiHgjHoLayShEyymOL+lEORk6CF3Li/QEINfyaoPZu5mGz1+CtOsV/8Pw6J/aeftyc3raukVGxoU/aCXPSe5lFoFYsdGAJ2dY5TqIiUJXs/ZLGMSjmI/BinmvFR9y50bxogM9zN9u9IS+NDFMmIOgMiywgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EcOu+TOcfbfDadm1pZd77Y5A6tl5Nr6dRcZJCVh2AY=;
 b=lTl6j3+kMg3wY4Wo93NY7s2R9n4iSazz5d5T/GQeB65j09UT3wvNvD8PRtLOp8YbpwuaKpa75/BBSyGIqFhKCkHW7oNh6xOSeSzLYIgLRP+4ScVduqoHqVH+5w1lMefpiK/KtMNNhUL7aPmTr58zgYICaEMSf7LrNIkuyVevfbeiFYx2pFangJzgRC7VAiOiBO74yvrzJabWrp8H81ELlWzbCq26QpXbB6vaTLcGjJ32HDZIFE3XvKqqrThiXeDJx6FpJOnfrLDVl6MvYQtSsDVoLxD/Y5Jxlpi+kFYvuqgoqd60I4oyyHXWpUUeTlo2+koZHtuW6O7xJMkSQejd7w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 12/19] pci: Add a pci-level initialization function for
 iommu notifiers
Thread-Topic: [PATCH v3 12/19] pci: Add a pci-level initialization function
 for iommu notifiers
Thread-Index: AQHbhDesmnxqhE6Hj0uBJ8Jm1MOagA==
Date: Fri, 21 Feb 2025 08:07:39 +0000
Message-ID: <20250221080331.186285-13-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 72c11ab8-4089-464a-b85e-08dd524ecf53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wgx98kWnlZtJSI9fYaTV5wC2Sp+T6ga0UKGMzP0i57tsO7TyuiK9gJuqtT?=
 =?iso-8859-1?Q?AZlxgtWweLDwdUCOmGZ4CjsXbfe46+ykRSNw1q5jBhK0XEA/X2DASjH7q/?=
 =?iso-8859-1?Q?xjhPusVv9rxDX+t6ELMxd+p2ce0g9WxEjnA7HpV901bnZuz7rMTpDRMoMC?=
 =?iso-8859-1?Q?qj3HbvF3jpxAHRYWIv7P1sdzNK+4Fgx5rt+3JelMXesFoUXtqiNaNPxnbx?=
 =?iso-8859-1?Q?nML+6e9tpe3v4u1WbXBaal7voe7S+9PqbV25OtyBPlngTRiblKaVc4r9IP?=
 =?iso-8859-1?Q?nZThjIQ6ZD9wlKo6nhgyr/J2RrUCBtWKeX9Q9Uwn57UaUwN6VPy5RMxY1M?=
 =?iso-8859-1?Q?vr+fU5/tnYbg4Ub+p0cRLiGRoYbmoJ5FcdZWwExEZ5onRnQ1w4R3Nfqz9S?=
 =?iso-8859-1?Q?sVNqHnf50BiYZFomOO9x67I3tYDJFAG54DsyUJq2cOoFFEXnjzzheZwjOi?=
 =?iso-8859-1?Q?/iI53QffcP3vkM+8R7cTMw6iYdVYlf9/fGqp+jETcn8GKv/GY01R5A3Emx?=
 =?iso-8859-1?Q?vwLpjSyzCYSa0F/15BeTkpYbjSWyohgj+rRk6R3vBUYuzacvWX4++NqZi3?=
 =?iso-8859-1?Q?izYYmi71XBqG4alTqHD6Z6BHr+UIGJPwg3Ef+9p0nJt8DEVISUtl43cdyy?=
 =?iso-8859-1?Q?wpBr2XD01pZHmupIlXMcETHvJc9MEoA47gLrE1zKLG7VswAT/c0Pz0fuoJ?=
 =?iso-8859-1?Q?YVmEImv3mmGOXVwFwohCfr8ZiubpU0JkNGaSCpQwo86iASj0Cw9SHxGuzM?=
 =?iso-8859-1?Q?/kE+qscgQB32TTf0SEGCSoWL8uDz0cwZqZdurBIUqrzlLQQRe6fizk5fX1?=
 =?iso-8859-1?Q?lpnJEoPX7NOxfD3aw2YZ44Z6lA5REAHfit4a69BOg7Apn6tOtMxlUfGLFc?=
 =?iso-8859-1?Q?+3D7M1vLxUR4PSwxCnIuJ2QjAUjtmLlgvox+Q5QC0rpRqqAZfMWKATrSmQ?=
 =?iso-8859-1?Q?FN9B3X2sMKNw8S5OTlYuYtZgIWqZ9/55focSpHq0ypmhwmCsH+cDcc/jsU?=
 =?iso-8859-1?Q?+ir/VnON4PesSWjmpt074YFYIihG3Bw0q06CCKk+NvWce6RDuFjyRqytGW?=
 =?iso-8859-1?Q?GiDQ+RmD/+uk/IvCcUot/rkaBKueVsQb+XUMvXvaDQbtCcp5MaINDa0ppv?=
 =?iso-8859-1?Q?/iM81CivkH9Z5u1u4cb7lkTqvhwpaSCEpjmJFEKPyXX/c48WwGq1OnKwH5?=
 =?iso-8859-1?Q?2HtK1uSrsaJrMsNX2nDSdrJpk7+t+epmwX2Gg2DS14R0yXHHgiu/UF3V/H?=
 =?iso-8859-1?Q?lmDhPS13ATEIjsAxmUYvGPlaZR51Dtk0obc/5bxLr4ff7QwpHaIQzrUd9D?=
 =?iso-8859-1?Q?Au2Df7XG46a7FtSqa5upvZxXEPg3IjArPdn29yWs3JKXuN0Kol7oVXryfu?=
 =?iso-8859-1?Q?5lGIoMmyhpe00+JZ1HBlnTb1zuaoyF9CrId6kBIISJF4gkrdwgh9J8YO/d?=
 =?iso-8859-1?Q?IXHOZgVqnDKZy5zhpTHMnwmBetiJFKvbeKb3e19Q/ONiQt6O54gQlcA+X6?=
 =?iso-8859-1?Q?PLaWEsQ8J7ZVmSJYO0y0F+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gR6OEA9oBbz1JayLyaa2R0mOULJosfwj3fAUJXFHFJ5AwtWNB/TaN33jZP?=
 =?iso-8859-1?Q?f0tF8QMWplkrT10VGSehjpiy2MAmWnc2OtlwJ24Fd+UWgQvbZg19rWMXRJ?=
 =?iso-8859-1?Q?qIWZVy/LKyE/njwULcCXLvoZ5gk2a90FUARzCJrieVPt91r5AJtrwNQQ6A?=
 =?iso-8859-1?Q?mXqh0pfXi/ioJmfJHTJsqOHNKqRyNa/lj3WgPC72HmipiNEnqkQFCToMXH?=
 =?iso-8859-1?Q?aA9OviuBl2sC4HstP48CxLFGN/bQUqSh/4Nb0pV/7BNE1eeFF80rG7lrET?=
 =?iso-8859-1?Q?Ph7AybYpIoumh/WkQgr+4WFhyn7Tcmlf2brjRs0sCDgVo+Nr8UkCsod1Vq?=
 =?iso-8859-1?Q?koIJIPNtQdGPuGg1ZJq8Hjbp7lH/HL+87/bLUHwQBbgfqepFDuLaYcYr44?=
 =?iso-8859-1?Q?GAokA85TNuZCx0gnhFFXqpbWiYtvPJGBMno8bXy68hysfGAHIhybgQwQwW?=
 =?iso-8859-1?Q?yh6274NfH5nze+wDahhhYEuj14Kyhim9dVzce+zaNZuhpTSKRhn/Ck2IOJ?=
 =?iso-8859-1?Q?BF26Sl1nbFC84msVkpyEFDe+khQ71Q1JR8NYg1S/czLHFnS4IMTOPl//Y6?=
 =?iso-8859-1?Q?2IM1VP6AIPm1C6+78pxPwatrLdzIz3d12rjblMt+TvUrXvc0ye6ezzOERX?=
 =?iso-8859-1?Q?RQshzKqIifvK1MvROISP3Cxj0i44pxDvO0jAaaDd48YfV8Qb9HRUahkpYP?=
 =?iso-8859-1?Q?lFSBQptKM+NK47msduRab9e9A7Ozq5VPg9tS9feaqI5nIMvWXB8P8g5DXW?=
 =?iso-8859-1?Q?6clfL02+SEdiTQIJq9ZrMp2JkClvl/IFBK/G+75A7z8cVTFioWQIs3Iac2?=
 =?iso-8859-1?Q?7VXduwOXIDtmF9e+4wO2VqgJwglWAychMmeQCs3jSzpwvc4SUGRxraEqRi?=
 =?iso-8859-1?Q?BZajOrnX9shML1igTXYT/Kz4wZEx4OUGACKq+1zzPOd8U+mKfKaUXxqE7j?=
 =?iso-8859-1?Q?RGPLyqacNKnX2gPl5jF4gL9IvRBxEtk7OE+9mNVeRY4eQaUSp09eMSYCbe?=
 =?iso-8859-1?Q?N2xF5Rz1H7u/5v17N5b3/T0tiEYnnpqpS3VUhVEbv1rPZcCdlUw8o5sePJ?=
 =?iso-8859-1?Q?QcceEZymgelPbSZhK3yxvJP/Iaw2bfAXHaXW9O50XRuHzMOVkjEMkge2AK?=
 =?iso-8859-1?Q?4BpEdQWLK42CKodfaghn6PMf+D1BL/pCJtpYg1cDu0LBDYmkXa2jHigOp7?=
 =?iso-8859-1?Q?qyhrt5XSjT6y/J0N9nYeCHXKAqr+5YBdn87D6XBuealP/TRG8QrWwxkKB6?=
 =?iso-8859-1?Q?Lf4IaNvkAUi37QaajnQfMkqHRflRfqZjyan3pGNG6OBkpPknOriZJXZSUz?=
 =?iso-8859-1?Q?Q+7wB0n6wjL1juMPpw0Xdouxp3A/bEse1AMbm70HekeWq+3SVhxpxKf1yh?=
 =?iso-8859-1?Q?OLuLFkQz6ypLIsZXPs9M6ywmC1VBXiyuhpLrLlsjRXRJhdbUdVvHTtuMQF?=
 =?iso-8859-1?Q?pNQQzRSAo1CaQsvPk8LXkgNmTgECebAnig6LMVjFxbHINfU5bQ26J4ys+c?=
 =?iso-8859-1?Q?1+9KYZe3NTRsDoH6MHYBsiyPa4/7KQhvSI/YV5aRZoU6inSxqDMsPb9F4Z?=
 =?iso-8859-1?Q?aAUBAJjMZwiCyAg4Y5U3vUiWXnbAP3OY202UahmygJGe+7yeW15fVifZtb?=
 =?iso-8859-1?Q?WPePt5y8OKwFUOxtA17jXZ2dnDtJ2Tn2JLrNFxfhEOSpMRomJBRFGvLbr6?=
 =?iso-8859-1?Q?4YobTB9iMhPLSKmF7mU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c11ab8-4089-464a-b85e-08dd524ecf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:39.1652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxYVyasIsEZt4OdpijGTbKxSvv6cOogdNNxJehbsuKGQpT4oRJ6mq9OKpi/02IAzkU2LRxKPrDGj9BuhjEL6x/08H93Xq8PAL/Gp1n45DEduuYZq/Q/jcF8QjRdv5TTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

We add a convenient way to initialize an device-iotlb notifier.
This is meant to be used by ATS-capable devices.

pci_device_iommu_memory_region_pasid is introduces in this commit and
will be used in several other SVM-related functions exposed in
the PCI API.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 15 +++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 164bb22e05..be29c0375f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2825,6 +2825,46 @@ AddressSpace *pci_device_iommu_address_space(PCIDevi=
ce *dev)
     return &address_space_memory;
 }
=20
+static IOMMUMemoryRegion *pci_device_iommu_memory_region_pasid(PCIDevice *=
dev,
+                                                               uint32_t pa=
sid)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    /*
+     * This function is for internal use in the module,
+     * we can call it with PCI_NO_PASID
+     */
+    if (!dev->is_master ||
+            ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev))) {
+        return NULL;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->get_memory_region_pasid) {
+        return iommu_bus->iommu_ops->get_memory_region_pasid(bus,
+                                 iommu_bus->iommu_opaque, devfn, pasid);
+    }
+    return NULL;
+}
+
+bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                   IOMMUNotifier *n, IOMMUNotify fn,
+                                   void *opaque)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return false;
+    }
+    iommu_notifier_init(n, fn, IOMMU_NOTIFIER_DEVIOTLB_EVENTS, 0, HWADDR_M=
AX,
+                        memory_region_iommu_attrs_to_index(iommu_mr,
+                                                       MEMTXATTRS_UNSPECIF=
IED));
+    n->opaque =3D opaque;
+    return true;
+}
+
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 644551550b..a11366e08d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -446,6 +446,21 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostI=
OMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
=20
+/**
+ * pci_iommu_init_iotlb_notifier: initialize an IOMMU notifier
+ *
+ * This function is used by devices before registering an IOTLB notifier
+ *
+ * @dev: the device
+ * @pasid: the pasid of the address space to watch
+ * @n: the notifier to initialize
+ * @fn: the callback to be installed
+ * @opaque: user pointer that can be used to store a state
+ */
+bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                   IOMMUNotifier *n, IOMMUNotify fn,
+                                   void *opaque);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.48.1

