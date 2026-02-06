Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E86ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOe-0001oK-WF; Thu, 05 Feb 2026 22:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNx-0000SR-H0; Thu, 05 Feb 2026 22:19:58 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNu-0008HM-3P; Thu, 05 Feb 2026 22:19:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrtkufZbySjRSDG+Ovj02kEVItAzpJnsESf/RYrKLxwe4LuwaefHoPSEnEfMfZUqzztjui5xSah8soKqFLJFqYKG+l1XFn4wqFaCh9H3AUmRRXlU9MrdYP2SgXLpEu2vUsWdhcIq+A5Su4uBZgUqJYmvntXybMGbsuLZnP7+ckx2Cb/Rd7rec/lkowdmLabOHosyzuwOQNB9YA+fkKJtyG4tSOfc8cKbNR2qBskWG6aGz8a36LvLypUo6vTD6/QOEGm9252HPg7Nq0iWxe5sAQyDngvLpZS9Ldw4GRZVPwDP3pVA48G3jqwcTf+Q9ZfSTAMLYsHJdl8dc3lEtPy/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0O2SoSjLP/X1cltUaNpv76AZtBwFXpF9txvrcdRiSE=;
 b=GlNeeG+PXSSuukOvU3B6tDRWB1pF3U5kJzsysYEPPh/DjQpCEUVjGlTIIkINd6nWzd3Tt16Mv3Ec4RGISXgq2v+Yx+qRxQPxlA9d/XPlX+pIjyeMfIUfuVFk8rVosC3a8wJw+TMwpWRjtWMijPpKmipHedywGOiUEsnMFqF/QBkX1vozpTopRN0ZGPHTBun5tA7WivZ0ich6dUMT5WlOjLQwoH8XLf+SbvIW0LjZqyicsNrXitSbyqV4v+/GA47QKJCW4ByfAv3nCaEDy9k8v/HlrAVqhwSADIQU7FUAXBclnl3flxmPgN7dlNPgoM6seKL2oQfj11xE5zTmuPeiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0O2SoSjLP/X1cltUaNpv76AZtBwFXpF9txvrcdRiSE=;
 b=luCXo+VFn6wHova8Y5NibywtuqzB3QswbxwV4L2hycCioqDp2xZmoWmsU7YYy6vWlc75o8giABHC/S0paYNca9xZGVnu/blDtyHE1bv0KQ6+PHS38ZTiwFuKMNfC5t+pCU5upku/mpzsTOZOSHb1A6k3ezb5YrJMMXQKFfUi76uBaxz0n5CzzgEU12Z6uUGehn6jUurb6jrehxz86URA8y1sYlbPPdKia6BluDxJAxy6wB1k/JP+XCw/JxPiN7yUz55eFchGo4pPaQqPsaeSCH8vxErjBxOugV5+qGPAOnB1hiLi+vLfV7nUB7RSpI3G4YeFJOQjVOz0vxH1bSJbxA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:37 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 07/20] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Topic: [PATCH v3 07/20] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Index: AQHclxdswD31AxNkVE6OE6vaOIkCcw==
Date: Fri, 6 Feb 2026 03:19:37 +0000
Message-ID: <20260206031926.3227848-8-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 0ae21e3f-a5ab-4574-8e4e-08de652e8f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SwReckewf6E4BXFdVyYlS3HuX5cgqm1Kq+cRuQW9JZOseXm7lGC1M9J2vf?=
 =?iso-8859-1?Q?F5fiqRy/CnL0KjVQ6Zq1Z1RQWyn2YmYY14j5I/V1jcyOBKQPCFZDVHi/nz?=
 =?iso-8859-1?Q?atUxln0os6fTo2fLGonjT+X1nEzU3GzVOk8v3/UxTKZOKf1Ywby+pKLgmy?=
 =?iso-8859-1?Q?lNHATcSDyh0D5LFLmMAZD+uDPtLNmcsqbuYBiqwqAz2olVGNEv0nZ1DuVM?=
 =?iso-8859-1?Q?PuLG3uEJorLd4LqAqipMhHqQyYdPpIaXdkHGTBqAb+ePq3lsEuXkOQDrYN?=
 =?iso-8859-1?Q?KI5WxkUA5fPStvJgaJsfH/5ZR9lQJl7tWj6G/iySyG6jzhZPntMATiG5Ds?=
 =?iso-8859-1?Q?rpI7cl78qp0gWT/pXWN9Vdff/XczFuU/OIxzpN4gyhcRR7VbWZ/0dfgEIi?=
 =?iso-8859-1?Q?fy8bXrQEA2mkE/O5FHwHulb+HTD41s3UplJHagc6qR0swnOayyEGAuGubz?=
 =?iso-8859-1?Q?LbwmsKtWjseP+EyrDf/7fXUXgh0rqSdIo9Omyc4Zr2tNFYIOhOxBqUmFkr?=
 =?iso-8859-1?Q?WFXh4croy/Agj4cKz5FTQsNGd4HAPyxlP+ZEGHy2RWTiRhixwU0KUxmxnu?=
 =?iso-8859-1?Q?ey+dC9mfOyVauArsv1Z2sJ3KMj2oSCBBYQ6C7JIi9XmULBUneV4tc85uEA?=
 =?iso-8859-1?Q?BHvbpXuhbfN56navo+36a5K0fdkwfqB2sT9LOkmFiePc4Ze2qln2VfTuEo?=
 =?iso-8859-1?Q?2AucHNsACNxO0CrL8J5wzcnDuiAY15PCehARrbDHzKP6nvAGH852uFglke?=
 =?iso-8859-1?Q?G4/ZvaXIXFiopc25hpXC4qoliILCUtazOq5YXNY2icIxXLuazmWwJKi1ce?=
 =?iso-8859-1?Q?tritmZd9FsDoPd52AABVLfARzQVoEIjhkoZnwUjBEgaTGVGjonuZwIR9pj?=
 =?iso-8859-1?Q?te2hEd0i/4sBLIv+/P48goNKi2BH3EDrLCJLubFrCd2tQxqMOm5mAYdG9E?=
 =?iso-8859-1?Q?qCJN8x89q0oX+gsev/7hug/XE81BeLwkcPBeq31TYVr6p0i4VU5sEsHnlq?=
 =?iso-8859-1?Q?JJMFdiWELXqbZYmJDbtxFSkHczYKQ9sgWVEs1NaaB5byFlB0FpT/EbCasK?=
 =?iso-8859-1?Q?Lbh5Bz9bPDAuvKVBB0g/YuvRA8RVNjPpR9ZLKWFDVeBXpC5R7SzkFjxbnx?=
 =?iso-8859-1?Q?BW3hKQUSBGRDwKqXrFRdDF+JpMrsoA+UVniEQhxSK0v+hoYShgQJHvCC9r?=
 =?iso-8859-1?Q?Z/0xnTPWlTSxbZlh+MB2/C5gw4QILI+D/GgGDFCBpD2v2dGtCZGE7qGVoL?=
 =?iso-8859-1?Q?bWEJflZdNc4HEUYFc1XvoVH1qi370NMlxf/dKrfP5N6fmLSYGrk0LYxjcJ?=
 =?iso-8859-1?Q?/XeMNQ/j9roeUq5PANa4VtSbLa0akLmArL3h66uY2ycZMzG2ohyn63kPCG?=
 =?iso-8859-1?Q?gY3xk37W6Wgtdx2/n2OFwCNmqnb0rlIUNynumwzD/chmT7PPjg1RlsaY9f?=
 =?iso-8859-1?Q?rt/DF9pLEunJqJAOUjxDhbGa+YlC7TuAAAA2/JzAOtiU3TR6kYlIRp9vZj?=
 =?iso-8859-1?Q?wb+WNopiD4bN95teXqmLAt1PMapdxoK4yZ3AHv6VJMiLj1ajvMZUQMA7G8?=
 =?iso-8859-1?Q?9qDCmzTJZAzKa9nwkpNNMsvGIflnxuSmEaLHX+x8TyWT+sIc94G/2Pjboh?=
 =?iso-8859-1?Q?cXdGPsVWnX64BeqHT/vYeahITH8gSf3SVbnJiwiTEOywOOU3SAFjB2xqpS?=
 =?iso-8859-1?Q?hI1mg+8bAmvb4NYuQDUCxqFzQxvhA9PyacuEP9YE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kIj6fPccoEnCHgj6ANYqzB8xB98Dd8Xu1ElgipY1QaJ5F2MIbBDhEmIxT5?=
 =?iso-8859-1?Q?cztV8pdAVT18fWEBSGCu8ExAdG0pyP5PfCIOhcBreTzGwd6N9dv9szQWkw?=
 =?iso-8859-1?Q?Hyo4kPUFb1zREDUFODP6az7d0dKZZGNkYYovZbTG3SgTEDYKiaahz5+tpq?=
 =?iso-8859-1?Q?zulyijOryGe+uMe+GYSJ95b3OBmafyeBA5gfsoy76MzdAUuuM2Th1l53fO?=
 =?iso-8859-1?Q?MZAJNuAlXWZRWqf0R1hEmMrUJ8XmI9/thxAsOsJGjfftGtDYM2+V/5fp/f?=
 =?iso-8859-1?Q?xxWDatuVCcmX2nyLPCrAkZBx0GnT4CbtrgiLbEALnN0INSltNv4UNCmI6g?=
 =?iso-8859-1?Q?ud7AIv7UNXpEtX7cj9rSDaKTvnsn1ZWLYF6NyM3IlyF9/2snf8M0IiP/Kl?=
 =?iso-8859-1?Q?F+dIv/q2sJ6tOF4AM2SvllktCRAIqFR/6sWBjBbGlfiN9P+Sux4OpUxqob?=
 =?iso-8859-1?Q?bmoOVDo5AbFomIbYQ+2duj8fSwU749K6rgE0QB25AknCjQhMV+9+FnQYvy?=
 =?iso-8859-1?Q?OrRKq9V7W/pqEHMzsQ5kDUzAZR8KsCGec8R0OqA0vJlwLc+7R2j4pOBjpR?=
 =?iso-8859-1?Q?A7VxEvAhXCQ2JlYnlyOcmhd3ihEOq8EA0L2GCa2b7KM+e668k8mIhJ+R1c?=
 =?iso-8859-1?Q?8nl5HVwtlzG8+OIZRIZodd7en7zL6QOkmE2GnCeodqVACWLMusphF973mI?=
 =?iso-8859-1?Q?7iXn6d3wYsvRcerKJopDIwrXFtd0KN2hEld6I3Svk9cK6nr8QUzww/qXs2?=
 =?iso-8859-1?Q?LAL98AJTlcXVScm2ZYjPb8tC5ljkKoTpG3R8wSDA0YXMJhGnsTDWZiaHud?=
 =?iso-8859-1?Q?Mh/ifHQgYIzT/BOs4+vRL3A5H6H3SNEl6OdHVgypZrbq+u+DbmHZvL1jIG?=
 =?iso-8859-1?Q?fMLXcDlE09ZKPdBLF+6ZLREvlIV4nOdDDJxz9fS6+ycQjqVvROAWoze6jr?=
 =?iso-8859-1?Q?IGXHLx43FQANTpjazRwuQtNytbpLkjEf+OHfwxKy7eGRiuo9qSpfdbuXzy?=
 =?iso-8859-1?Q?sk5axnA5k3Xviw08p5QvFoQhDKsbkOs3mv0xmxJmhNpFnrI+H5fC/ZqTQv?=
 =?iso-8859-1?Q?B7nnxYmmHffC5iRtiat+1Zkdk6SeAaoq02rfM07Awt325xkEK1esHIYWAi?=
 =?iso-8859-1?Q?/w90OAXZ0x+4/ZedgewFqFFnNs6OVyQgs5flLJ/2h5/bdKWtV6pxHELMTn?=
 =?iso-8859-1?Q?b1sow4uYeeO6qXohoODGm5NCb2f5xdc22n+4tPpLHBj4BSyej1O469Wv5/?=
 =?iso-8859-1?Q?cu2ijdkxbtkVEkIfBB/kyzSUzQ0mMDmlZZKdXxE2i8j/w6PndgA0IOK3fM?=
 =?iso-8859-1?Q?8Tu82x/ELUM76klvKdiqCMRmzwyWbFWPgFZOmsDLkFwwc2yz/Wqxxe7HOb?=
 =?iso-8859-1?Q?TpiogV3Js24H6wjXFTOsZ8jQUH1dbJ2vgNhe0Uez+7fOaTdgSfIXuY5SdM?=
 =?iso-8859-1?Q?HdO0xAIhfODwOdgu5xM7twKQ6eq2fZqtn+u1fYsr/ZYjXfZtP8/oHyrqlu?=
 =?iso-8859-1?Q?qW32aH1nFSQasLyv7DSExagZAGLiSflTKhEyHBJznLok/geYdDvpaJ9Wa6?=
 =?iso-8859-1?Q?8XFbL2VIclkEWJQpcgddYCCdsqeJCUlx05faligFRbof4ggKUnPIHwXiiM?=
 =?iso-8859-1?Q?LYvfPCyyEOtqL5y1nwuNFCWJ/Te/KFKdnMf6hCDXREGbPV8p/2Njwqjw12?=
 =?iso-8859-1?Q?o6tGE0m70joYrCIXcvStSu3/Dq15t9i313gQr1PSzAD55zHnkH5sBrnVdl?=
 =?iso-8859-1?Q?aptImy/Sn6s77POhL9R5/IaeoNy1nmWGwlZ+Ai1qSWVdig0ZC2uXTDdTr/?=
 =?iso-8859-1?Q?JwFMhC7u8A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae21e3f-a5ab-4574-8e4e-08de652e8f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:37.7711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq8HvIlfpwPRPQOS/C7ghWvzKPpBEEqzlzeKwmIqYRZ+mK+dLqi/jh/mJBBlS9DJU6M/bEHUReF2ieswhgC7ZvYK6xP/uvMEhhrUEX0BwIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Adds read-only register masks for the Aspeed I3C controller registers.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++=0A=
 1 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index f0352aaca0..bb41493c55 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -74,6 +74,21 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
     FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
+static const uint32_t ast2600_i3c_controller_ro[ASPEED_I3C_NR_REGS] =3D {=
=0A=
+    [R_I3C1_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C1_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C2_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C2_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C3_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C3_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C4_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C4_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C5_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C5_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C6_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C6_REG1]                   =3D 0xfff00000,=0A=
+};=0A=
+=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -97,6 +112,7 @@ static void aspeed_i3c_write(void *opaque,=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
+    data &=3D ~ast2600_i3c_controller_ro[addr];=0A=
     /* I3C controller register */=0A=
     switch (addr) {=0A=
     case R_I3C1_REG1:=0A=
-- =0A=
2.43.0=0A=

