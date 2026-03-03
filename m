Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29EAEB364A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEdj-0003Tl-3L; Mon, 02 Mar 2026 20:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdg-0003TI-4b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:32 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdd-0002EW-HW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+9WeY8NSoNPgkXTexO81/qhPOEr6QDv0P5o5qaBZ80WiQuRqG0jqY8pzonaScXEosGgJIVLjrLEJ0pXCbla0kBzhYg2wCZlJjrrEMd1JA/F8e+UWvAth/AbzWsE3RclxfB9D/xWdIViVOh6kLH0bk1MAQsoIhyXYiMAVPPMtSekyRKNyNLgeehuO7wKQZGDWlYrMtRghblEFAwglyE2iSKAe2iQKgmZUnuuaJDtdk58+mufxSpl9o03brqOByPDz1iIVXLj+UPEtxdwP9MfHnwzeZjByhKrfWtJm+jec/iNu6WOAffEkEw+LxXFfsupWZn2kKa/VJCCnL3sdTcMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mn0fqKWPa9DyZN6G2QQk/lZluk3tINCHl4Ty67VuFg=;
 b=hVy5u3+iNzheSVd1JmsEI3o3qepCiFng48WxH4crqNVOp/UTGWVW+0W21oX8fn8FaqGCNKhkZUD6KSBDr4/yFZllIWye3/iXhGZdlKjTM3sr6ga+kMzsuUBI2fo5iYm/BzqHSeNdNy2cY0TzKZiXJEEUOl/4ql/gxu5Lm4GI+y8u1PIbYJv6CxDcsBJzlxr4lwXr8vzj31A3ofuUjSm7bMpRRjAa8IaB+yNcrS4DM9uDiITccqi6FLiAasKK4Dlo2DmTdMPkFRnISGKdBHYmr+B7vlHfsBjhfCLESEihGm2QX5htS8sTSafhD4rzDVeCXAo5GJnPWzsgudkkhyO01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mn0fqKWPa9DyZN6G2QQk/lZluk3tINCHl4Ty67VuFg=;
 b=d9drThcCY3oDpu/F3toF3ejeq2XMb2g5A3yGFjZuW9pwP4AcAL9o8grj2Go5FbO7XDmOLzp/UDoJ4yv3WYLzqc2LKTpYYOfr7lbrikkxwSoLyMdtuHVpoH8qCn0b8IcR+PHakKPtXOy15WvzsOTnSt5aUBMM9Fb5TlvVj99CdKqVDWQb/cnwjJqmpb0Tz+jDsJzlhJH29Zv0n0kQk8KfZERxugjgx0lR13y1IE3WZntrxOfU0iYAwCsRoBsYhRouOkui8fs5wiL28DJtaNvqg+HOOR0+5o1NWPXNOHn7KBubSbzRDhyLb1hSQGlD5W1AH+m7o6YK+0lhy/PxmlV4Jg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSQPR06MB7973.apcprd06.prod.outlook.com (2603:1096:604:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 01:33:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:33:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "jithu.joseph@oss.qualcomm.com"
 <jithu.joseph@oss.qualcomm.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v2 0/4] hw/i3c: Trace fixes and readability improvements from
 review feedback
Thread-Topic: [PATCH v2 0/4] hw/i3c: Trace fixes and readability improvements
 from review feedback
Thread-Index: AQHcqq25obblN8pILkiQ6rel5LOqoA==
Date: Tue, 3 Mar 2026 01:33:23 +0000
Message-ID: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSQPR06MB7973:EE_
x-ms-office365-filtering-correlation-id: f53dcfb6-65e5-477d-64ee-08de78c4dc06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: WouX2Q3fr++xZmVGcaHS3RYfozaWpiKmkJWDKY765E/0tJgwnGHpXzyG0867VG+8WGrYU+H15JHdXxrhS5HSrrHHWsUVoV0buyBxnTkCxJ9Z4gg6Nt7AwaAI/21H5cI6bbh3ojqDeB8fZDN9rJ+OWWU6Js0N695R/9K1GXSCc0kBVXEZIvbwCrhi4MVPqd6SXI1L7aBWQpCiFy7xPOBCICzoD3CQ+NDSzCuWaukgeVA+yJvpL94xVphhXfhbpRuujjRkAzVrRTSIXIvl67YQzVAeU1xmx0cyzFaq3ngG7p5hAYwXC8hMiINtEGK1h5rf1Ew/VfkWBllfFE0k5B8piVD1M/v86TRj+RQ6pdQekx2YXgKB4J+wAMD9pTaoFhCk3P+Ly83Da1/K5DlZ0VT7Wp7FvDzCUpFi/p9Na1PLAiU1L80CnfGP8YJ2nfMqttzrJpErY1ZAO5kRgafvCKdcIam192mHOgtprtjx9icxEXhNZByCg8Sn58pIZkxFR+pEu84939pqcRkp1JaJVOhIPSZwETOfZgxOTieHc9gBsMclOyMoLgt7VZqr8awFzg0CdF/M/FVP0eq4KwwNDTzkTumASlLYo1tHOObspScsnDibO0w9qyAXS0pQcTMYmZlPNeO63HpdmhKeVBK8Fw/O/Y6RtyIFslpRHBoNGjd++5aLM9ycGk7DfbAFW9NkR1UggT1h8ft0GQlAA22W3x+pj57QOAnlNXvmQ3f0jrD1IS9QNm1JcdNaomrPFmO32Y6uYu0LGm1Zh438ThZx16YhJL9UhVaqLtFcOSuIl6xm7vo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FtUHi9b9zynRri37m37YyAijOekBQ9cb/E2NHH6iNC0diEzkbLmm9GXNj+3S?=
 =?us-ascii?Q?GUWv8s2Rr1tCXYI4yJ/+PDKtFajqHpD/pHIXMV20MPSAfKv0ToFfSp6TYkh9?=
 =?us-ascii?Q?qifTs7k+eu9hJEro1EJvlxVR1Vb55rMr7hye/1SdfmNe9wfDq9mYP8qM3Kj8?=
 =?us-ascii?Q?34AXGwjyx1yy2H98MRwh8pTWaNBTkL6ryCearPub/1IA/1zEWgoEHgOE1Byd?=
 =?us-ascii?Q?gJLdqW5UFjFnoQvMNwOEwbPOxpd+2TP2Zywh2nck+PNgWlGB+IqcM7xnEkRe?=
 =?us-ascii?Q?j4rW4C3ovAqgOWU9n7/458yZWQDWLCKTblyvRorrxV3Vl9F1iDCz4t0XOPC4?=
 =?us-ascii?Q?Jmc7m4UNhGolCo0h30gqsha+JLPorRJu8TOltwkwyBbpW40qbtuXC0fwE65o?=
 =?us-ascii?Q?4uJQhxy7kRiOSait4+n5ihhm5wQ2NR9UUtu5KcCzG4dEDLBQyy8SXhazr10M?=
 =?us-ascii?Q?yle62Nsdnl3P7vrSN6MXMT3QkdA+DL26Edti0WCritYLEDDoq9L1z8t7au65?=
 =?us-ascii?Q?um1nus7RlbLcG+p4n6DKzRqINmORrcwCjdhgSci1twbs3gHSokvS1hY3AB/c?=
 =?us-ascii?Q?DR1o2tXszQ2el9RMMArA2aDymjX6O+u1C0Ym1bTXuUwlHF9FPzJDST2Loker?=
 =?us-ascii?Q?D49BWYuysh9WYDBE9k2uPPBkxdZiHQW3LOM4gscE2+idOj7czffdWk7fdeIp?=
 =?us-ascii?Q?bwq51+Jy00pI1Z0+ceHPb5UvKy1XC9fU0eDphAz0P4q18foWjIomuH4aNvh0?=
 =?us-ascii?Q?M/UT6kxAjZZE3LqkNeGrT1LyeFKmM4Ejg6HYMlDKIv9MnHNE0o4Rd369OeW0?=
 =?us-ascii?Q?Jo69iOR7OAhmjm+yePDSsEy4ZWdUNfHvjXKTg/LfMwJWFnXv+pTmlIIRLD+y?=
 =?us-ascii?Q?tMyuQxGbr9Znl1m3Mdab3a1OpEf9yx6zglTpWfSmja69/D9z0dNxX3EN2rqK?=
 =?us-ascii?Q?6ANgbxiwNclJXsFkfMdF2LW5l1rMLa3q7FTul4ZVrJKal3RcvwvJtKXeH6FI?=
 =?us-ascii?Q?3WS/wiEhkN7xixdvnPnVwnqqixnUgQQg/Vjh46FpbzkJXaSmpQYkvsqfYv6T?=
 =?us-ascii?Q?ymCqugN0ajdSmu3ag1KMvkyedn02tT1U6eNAmEgMjFkPaQdZeb5Bbd09Zs5f?=
 =?us-ascii?Q?MINCB/NbxBg6DrCyX/xH0/YtXsUsRA75ueifkP8dVXzzTCI4rdD2UzY1+mXe?=
 =?us-ascii?Q?jBKm22byytoVw6tbvlxawuDA+566VLiWT2zomwFEtbYXwBt9/FI8zZhyPahK?=
 =?us-ascii?Q?iALhYHV5BJgo6tTvE2bSYw2jtheKwLXH/codqQiNZ0/KbrUfxRj3WEaYDxGD?=
 =?us-ascii?Q?CI7ayUsDjQJVcN0OiSUQ4wgG6IRUCT4dzPvL+2HlkXq18wUV4A7hNjnm1fA/?=
 =?us-ascii?Q?FRWa6bf+u/uUH+DdqP/1pbZTIaGGTB6VYjQv/V5fOJzj+MsPgFSCZLoIDowA?=
 =?us-ascii?Q?JfQ15O6mslC84mryplbTFbkfZuiTlHPdCq82nHPz3T65RYM6je8XY5Yyn9dD?=
 =?us-ascii?Q?8ViiV5vcTqpBT2yeKaS30hrDWSYutQhTLwVp/kWCJ1Db2Zs53IYdBWE8EM4M?=
 =?us-ascii?Q?ilcflDBBHbFWnrDLbc8Azn1Z/SPYdU3aiiFpgYXReiYM+t4pzdDNZFz6k4cf?=
 =?us-ascii?Q?ijRv8S0WUIv6PTaO2hcOs4xNFHoX+7goxldYTBti9YhSfQG4JR3EzThL8C+3?=
 =?us-ascii?Q?mvCP4Kk5B5cEXWhG+myEDJhxetxu5HObDJYHZdkXz94aUiWZgNkvPKsVtdpM?=
 =?us-ascii?Q?trLdfwCe3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53dcfb6-65e5-477d-64ee-08de78c4dc06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:33:23.3137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smjwvqXiq5SIqvc7KCu+2qjBBTfB1Z48vYZuAP83Lh4hdact6yarBLOeq94kMYWBO5p18FNADE6drikKMNCv0fjl0DOCE6OnYuYMPSjqGok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7973
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This small series applies a few follow-up cleanups and bug fixes to the I3C=
=0A=
subsystem based on recent review feedback.=0A=
=0A=
The series is based on the aspeed-next branch from:=0A=
  https://github.com/legoater/qemu.git=0A=
=0A=
v1:=0A=
 1. Improve trace correctness/determinism by ensuring num_sent is always=0A=
  initialized and reported properly.=0A=
 2. Replace a couple of less readable expressions with clearer helpers/logi=
c,=0A=
  without changing behavior.=0A=
=0A=
v2:=0A=
  1. Fix review issue.=0A=
=0A=
Jamin Lin (4):=0A=
  hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer allocation alignment=0A=
  hw/i3c/mock-i3c-target: Set num_sent in TX callback to fix trace=0A=
    reporting=0A=
  hw/i3c/core: Initialize num_sent in i3c_send_byte()=0A=
  hw/i3c/mock-i3c-target: Simplify GETMRL byte extraction logic=0A=
=0A=
 hw/i3c/core.c            |  2 +-=0A=
 hw/i3c/dw-i3c.c          |  2 +-=0A=
 hw/i3c/mock-i3c-target.c | 11 ++++++++---=0A=
 3 files changed, 10 insertions(+), 5 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

