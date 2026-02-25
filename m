Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A61F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OF-0003T4-3D; Tue, 24 Feb 2026 21:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O3-0003OF-SZ; Tue, 24 Feb 2026 21:12:27 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O2-0000Bm-H8; Tue, 24 Feb 2026 21:12:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSHdtXryw2kI1iedzvqC2cMd0nsMxr/PpbxuM453AXFGbp8XM/TqtaBPKXSsAXEzGRO4awkoF2VlIGLUCxFtvTMmXmHwsaH8TdWKJeXErUXPC/PeDBj4BdPDOBib355XVAwh7i3jhUfuW5bq5xRYYgrzytFmWUFkXgD9ZM+Z0wbFcb2LMgcpTT9S2ycHdjP1m3g+Zp4ecp0g2DjOEcFHX2iGbSEz3A7NcDWDdlOYlTMyeM7hll11tatbbeYVjEjyvC9XPk3SyWClgIBuXxgVCGKzoEwEh1hVIwZrh0suqlemm9sOm9t5O0J/5ueznItiC+6d3Ta0OEX1jbmsLldSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR1YkodCjzHBKGroe0DJUM7olLEYORn2iyAE7vug75s=;
 b=DGx6EvylvRlx53NEEgHRO/Dza1+hJLTMHd7sWLEaCrtQ9bb70qMB0LCv+cMFPA5mbvy4P9p028MzdWnaxO/8pWHUMhC26EUw5pUr9yWKsQ6hs5OdRa4s9q08CCGiGgn79JUv0UpUA2OBxCq8Sg5oo80x5JnJywLDObf0URjwE27IwEWkUn/SrLWCL3B9WpvPuaTlfqqqhAJtmjx8ltMFSKPoKPzDLRIHclN+GQ8gHntykHmM0Ly2SMi0DDHeTB84MfhN2ZXpLfmFy+qtDbcrlHzR19Qr8nEsZ4tFNDtBrveBeXf7l/3u/rIVg0ndfOkHYsyivdfXMWThdJ2wHpMezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR1YkodCjzHBKGroe0DJUM7olLEYORn2iyAE7vug75s=;
 b=EGro32aaYmgyfSKoXa3qaKBDnTg5E2QBGuU3COGYyFraBTnlQnjBdg16YOlV4freNJX6LkM+R+YSCVTEkGae/7gxlfMKvh3iNFY+FqaNOocBBLgr3OfknSUlWy4XzC4szRv5nQyr1gA5XNQKVIOAR6c1EvrsErgNEjxB0xS7qEk6c7ACCA1K/w2hyiBg6wGEJb+djazEPGMDys25o3l7j7ZqRmdKGa6VA9tlcRV5Hf1Btc/NdRmv1TktvizlbcQ43G1b88ZySPRv4mgGbyzNgoEJT67WzQIJO6a38DpTG+aFqevTPmv0w0CgS9UcG3Qk0BXFu9S1+V/kBWvUtGFQRg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:14 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:14 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v7 08/22] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Topic: [PATCH v7 08/22] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Index: AQHcpfwoBqoUTG0ZJk+nrJvGEcfNHA==
Date: Wed, 25 Feb 2026 02:12:13 +0000
Message-ID: <20260225021158.1586584-9-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: ed9c8903-ba2f-4592-a247-08de74134ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jUTDytHIxBTjfu9vxzj68nW4+AGd7DQAC9sWPN0sdKWon/v/ufpjxxydI9?=
 =?iso-8859-1?Q?cMnOMNij6oD0WWXttKtc0brU7/1PHZnwtYz9ulamYy7zEWVzhgq8hoIAew?=
 =?iso-8859-1?Q?U106tFCDNFTJiG26GkRaJrXMgBMCRJ+aaW1Ub08727urOmdtab52biRs6C?=
 =?iso-8859-1?Q?35MbCkqZ5T4AGWu2O5UIpg0qxIu3kV6Eoq5ti7e8RWv7nBw5Rm/iB4ha0u?=
 =?iso-8859-1?Q?brYTodGm07/NLgNVkLbx0klZc3lejuYWZCJ5aTlQt6/DlRaIYyHn5g4Cwe?=
 =?iso-8859-1?Q?9ZhuxPm0+epwaNw9mKFEq/G1aqrDn1UjYTnueuKhByBTpTSN8XrsDfkFtP?=
 =?iso-8859-1?Q?AY/XGTSRt+i3/AV8FUUcg9gaGjQyz4OGVsQGpG0DDLe7qO1Iun5LtfL0u3?=
 =?iso-8859-1?Q?uecLZf6JPbnfEHqXRNrk3aKApY7rbrGddP0rnWPNgZJ+ggfHgeO6Iuwb9s?=
 =?iso-8859-1?Q?WssOBq86CtxEmQDg5OMohkWFXi7Nw7cmwrXy9zwy5sbfL4gj/gsjbmjsfZ?=
 =?iso-8859-1?Q?TYQvzfvE7cIJVlmsoj4LF0ZmsOYTh/Bmf9Or0jv9mIV4YsXxWR2+THtL2r?=
 =?iso-8859-1?Q?BPyYM2yGMeKmQU7WiRZlzpmwdVxDKYS9WMeMTNVm0GeqLGo5LnRtgqpRrP?=
 =?iso-8859-1?Q?cdhr1FtP6uo3L8qWkqLZQdov62lQXwAAffGKTZYqHLh8EuwkInUv/5Lh9R?=
 =?iso-8859-1?Q?voUiOJ6wVqulYubCrOxTHre89mp7f4BYaRSOd/V+7iwPOp3KVztZldMAZL?=
 =?iso-8859-1?Q?+UhaPwmQC2gV6cKIHR/n3L7WGIzBXyBhyDn8Z8sNMhwM7O/6BmEt8C+6aA?=
 =?iso-8859-1?Q?Dp1VjF7y1M/MkQv6WTzisbyn/8LYTLA+6GWPQeFgmI/mtVbhU4nKUM3ZKX?=
 =?iso-8859-1?Q?c4qLsE7cYMpAf5Tdjhve9D3yfpIUuQXl5JWksKmKTmAR7+xm5hRtga76Qv?=
 =?iso-8859-1?Q?CI6YAs4Q2gzPIieFrZdiVuCLVjTG3FNxf+SgBmabySuWV/f4KlPQrC/vSI?=
 =?iso-8859-1?Q?ni42TncscGkxf5kQWQvLc1hxPh/KXFc1eVdZjWsazMfeuaQcaRIPKuGZR3?=
 =?iso-8859-1?Q?6w9AuZBlAyD4kg83VB5cp58akz+Se6RYmbiOaTU+QWTc5WviIJvS64QvhT?=
 =?iso-8859-1?Q?Mxr+27Fb6g2NdsYv/mdhdBvCFNDhxKq36deCPibDIXt4DVjumQe+Y1O57Y?=
 =?iso-8859-1?Q?PusPrD9vD84l48OgS/2QywoS7DrDnE6HS8b1QfZgIZyD1n89yGmcOAR+9u?=
 =?iso-8859-1?Q?CmRhPF9lcVkWI8BEpWtolfHJMylIRX4Q5e480Mfrwvq4Rc81XNvXoT7sFQ?=
 =?iso-8859-1?Q?UjI9We2eVT+Ugtkxvv3coX5bdmVddNhBaJm8DlpGUwKASj0TTfnb4EuUGv?=
 =?iso-8859-1?Q?95dHA0/AEfOYBb1IZCQrhLcTHJ76lCPtTP4kDlAYUAOVPExR58r5Sr8JSN?=
 =?iso-8859-1?Q?MLtBrTNV3SFIhjybbd9ou1RQNQsU6UCeKVqaGxSw+DgGfUgRUh5IoX5vaa?=
 =?iso-8859-1?Q?C9g/Tl95tUu22frskCTp60NRZv3Fsd3fP5FNwwhXi9y38Z4rj1/LeuqTmx?=
 =?iso-8859-1?Q?2/j/c1u9BAcNUasnjgXkq/PVRIti4tHoUctE5z5V4ULuOH+CK9/UZtJAfz?=
 =?iso-8859-1?Q?om8+ATUN0ijguP0R8eNCo9JImbbjl3q9byrvUCh1ZyspPFONucXJ7SxAAE?=
 =?iso-8859-1?Q?b1Uu6x2LBYye34LsN2incFnULfwwJTtY7yAhVvTu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b2rEEsRN+VYo8FnsTssoLi43KpT42a2GuM3DDCzufRV1IbfGvDc0etWjKh?=
 =?iso-8859-1?Q?1TfRv26bH/GuV3ksI2wRjj99NSo2F8zy7MPJUS+LHWcLDWtYszk2W0vTBh?=
 =?iso-8859-1?Q?5TytJ0zsTK/CV+gD4wIaKUucsCvb1qCoKp2l5WzfqXJMYDmxPspC6OJ7gJ?=
 =?iso-8859-1?Q?8ccwDUivi7Bv+DEt+wgwIPGp7oEMh5K55ywe2vEuyND4RVo9IEM9BJkw1l?=
 =?iso-8859-1?Q?xfjfZE7oNTlYJyj0aIcA+LfBf71G8/OqmkEjcwicmCGMCgkZC0yD6nv8+D?=
 =?iso-8859-1?Q?njIXwhS/5nU3C847zDS3Qk3jn9uJZK3B8fP3fDk3BZxSUfCU3NSvNfdQMF?=
 =?iso-8859-1?Q?zGN9GReKwwHvIsieVeTnQrHoXYIki6PKJkOKxMb957sk8U5AEtoTYc4R2g?=
 =?iso-8859-1?Q?tXuUvYiBFjafBlOlVKMur0Y32mw74FgyzN3wPyEZL/vj1/WZHogD9ByW+b?=
 =?iso-8859-1?Q?gd4YKlQhgUZxlGD9nMWh+frHi9ZzDtxron59anXis01zYOGEHxsiKxOZZU?=
 =?iso-8859-1?Q?+q44a9QTKxIocoMS7qp9G8jQU8U1jyK2CadqDvfGnFH/oD+oUK4H7qUAM+?=
 =?iso-8859-1?Q?eb5giPhfc4hLp2GedUiKTycD0pi2sq4RWA9jCx3SUZ/ehTzIfU4xIBqcos?=
 =?iso-8859-1?Q?EuBv9kSgM6fjqu60nt6MtwCGfOR03SJOPeQ5YI+EMx+yBn3cKxfTnLZuO1?=
 =?iso-8859-1?Q?iCwjYnhq1G7tXQ8nagSDfYWpLBQ9pYI9dp8YBnXMrztJ7BHTAORD7uT2cZ?=
 =?iso-8859-1?Q?NjslZyWKOKpbLHsXL1eJ6EmFjMg3jNC66rc7IAt2VZhg00DIJsFQweKfBH?=
 =?iso-8859-1?Q?9zyQKpWX8fO2YF2QYLk8aacmj/hLrEcEZV1CAUnBci8VN20ZsO+7GIaui7?=
 =?iso-8859-1?Q?s6ke9WT5DYlJCf0JdN1UxqpP6mN1CPoWFjqL1iRcLoMLPloDLh9XZrdcHL?=
 =?iso-8859-1?Q?Se4VgHYemLmm5Tm4tKuy/GLR1zVu81seox97o6XlLb2DG2fq8mY2WoVw9i?=
 =?iso-8859-1?Q?ey3KSKZrkxxLdvUtZw3UtF0NbEmcSeN0qrwW3fzCPgUKtD0dm7bnlN7WnE?=
 =?iso-8859-1?Q?U+G1oCnl01q282pjvR20/gqlpqMMJIp90wWO9Knh5AwQ6FCaiJ47BYBkBy?=
 =?iso-8859-1?Q?2TiidN477jAbw8NLFJZF5Xsd7xfOdRXtaS+GkcReFHl9YBK8DbyFrMBDxY?=
 =?iso-8859-1?Q?rBUS5K6OkuvWooNnrsgUhUsoxNfEsRCOL5GpMaeffCp3ywJIPDEuUj1MJM?=
 =?iso-8859-1?Q?s9C9wWkSRx4JRAH39Zvgxs7xZsBzqRsVpV14vnsivOhBE8wnVhhHkYkt1T?=
 =?iso-8859-1?Q?/RGVtd6WWxYgu9gG3OichZi5b9rLyuZM8AriMUKgo8Jf5jZkINrdUUYssd?=
 =?iso-8859-1?Q?ihZR2bjQa11PiohpTvVcmKdROakYGb3n9cfEOEAjGPZipS0jbM3Q4ogBgP?=
 =?iso-8859-1?Q?WKmB1aBnAhgIZC+Ik8iPzsCvg/m+3a/ela7CGnHYnlTgWcIEyhuRoaThjh?=
 =?iso-8859-1?Q?8VTP4PiDopfDC9kHqLG7P0Yzp4brV0IL8ttob8KqcDhWNgny0k4gK7SYBg?=
 =?iso-8859-1?Q?XzZjnQbJiTtA1z7a8X+nYjyvgjZK0co+1MBtq+DtJktYRNkp+wfo7xFnyK?=
 =?iso-8859-1?Q?USB8lMJyeJeh2qz66i1p+FQa+ybi1zsL57G/3EdakmbG21+XVgZ9uho7Q1?=
 =?iso-8859-1?Q?Mq4LXzoOzRsY/CrAg//bY2nNM4/RLkyt0kfOgfSLYyvW+t2hOs/pLFm0Z6?=
 =?iso-8859-1?Q?zIyrv3SHzEZHC336dZBGBYxMakxKPgT43612bn0A/8w/wf1QRTn7sJrL6e?=
 =?iso-8859-1?Q?BhiicpPxOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9c8903-ba2f-4592-a247-08de74134ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:13.8729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ezfFzBZVm72+gwSnDs8r1zqVpj7Hs/KuvHLwGqBePTpxmQSjFUMbJHGYYjhpGj45vUk0QDtcUxoZlDELBL+Iwv9natEMqKRUdD0qnp2u4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
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

Adds read-only register masks for the Aspeed I3C controller registers.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++=0A=
 1 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index a215700288..2700c5f4cd 100644=0A=
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

