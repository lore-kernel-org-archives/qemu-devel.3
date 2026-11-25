Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241A606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=EBaT84wE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3R6-0004r4-M0; Tue, 24 Nov 2026 22:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3R3-0004q2-Ay; Tue, 24 Nov 2026 22:12:41 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3Qz-0006wr-PF; Tue, 24 Nov 2026 22:12:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPE8tf+2Vx9qQr/XMEKopbf6NrsyuoK9sU6E8iVRobmv4k62jSVIgn7NQ3lxihuDq83Lr9KFZMfhG8rjXetT8Wx2SezpkOS8z5OArhRyQKvO/rAQTdTl+aEEDpxKHLLRqC+mWMiN5wOSQVhFPgD4I/Klg4uDSziuCLM//e0FaLFgWl7FLKnzd4/jkvXOLJPVasim4hT8grl5JgaP+z7IJr+MYWR2bxf5HrSwYLRUiI1WvPo2bnTLFeN8gaCejgCMLnOrByeK3I6Yc8PrfiUBNASiJTmwopd7+kjuhPNmRz3XnY37RPbHa+Rnu0Kj9IXrTgRvVpMCFz0IQUkmoW+e5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuiDCv9djaU+KkA2uarHqRj0DwlJ60d91AcBjbRQlTs=;
 b=Y2tnb4KFPFuc1BiE5UgeWj3Y7eKBQT7fFFIl/FgiW8ZFYAJVXcOmRPaPE4g5DY+0hdSclSTxkUVErpR1qm/1EmYZJaqHVmO1tuHJofkYW41+DN6AeMj3wvl1gI6w6QwrisV9leSCXkJuBZINU3U7V6ZrcENZkHISKkXhfyzIjRG+sduJ9iwDpNA2MFk3RQdlnTEN4uqudv5T6j4Ha8j38ADMEWLA8TXlTXMuJ/69nx+T7PeQ4SzgkpPwy5c1wYFdi2ZpGRxO1Xt3+ITGulhxlJ9SzTFE6/mr8UMLcg7IFiugCKbr5CmiObOO0nZO+GnzKnbIwFCsSA8Zt1Xn0Zylzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuiDCv9djaU+KkA2uarHqRj0DwlJ60d91AcBjbRQlTs=;
 b=EBaT84wErbL0l3e+kzbXAW/DrjZo6HdQB0gTX9LUAnoRDox35VCLZD39Cg3Y2sC90pqvmYtgFSarYPLeoYDyJplA9QjMgYJoJeLqKAaQ1EG+1TGo8pgjOqma8T4aswJPsfx36ZRKbHLi1Rjj/3fRjn/3Gv8uvlHwLFtCnUYcXpMVrqTqXHjx5ioE/FJnTt/3pTT97xFVybtdOumJRgvy6540z3oDXA9I3Hbr9Sn5olZgMxPU/pfm7XvWIewsth28Om3NJze5wYe52fDThqdj+9NWCO3EDpcH8P3FDICbfrPm4L098pG4I0Xi1VhQFPt6lwB1zHxe9VdbQvSt07T4+w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KU4PR06MB8385.apcprd06.prod.outlook.com with HTTP via P2P;
 Wed, 25 Nov 2026 03:12:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 03:12:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/3] Add the AST2700 PCIe EHCI
Thread-Topic: [PATCH v1 0/3] Add the AST2700 PCIe EHCI
Thread-Index: AQHdfIrMupXjfetwTki0UJHI18Cceg==
Date: Wed, 25 Nov 2026 03:12:26 +0000
Message-ID: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KU4PR06MB8385:EE_
x-ms-publictraffictype: Email
client-request-id: 01aa0cfc-801d-43a4-8524-f8635054ea31
request-id: f8a11b96-f808-4b34-8b9b-08df4aa1eedc
x-ms-office365-filtering-correlation-id: f8a11b96-f808-4b34-8b9b-08df4aa1eedc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|261009223027099003|261021123027099003|56012099006|261021121427099003|261102123227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: pJH0i3Q7xKuB9M8LJmzMlpK8XUbQWGp+ypd9bZhBPZ2GC560QAbuTzoYY4JnRtH/yrHIBDMdJGwAQFggo9w04IrZ90PCpW/pxGuxWz2FIXeienjDJvqBnu8nbJYBCrAxDBWj16kM8BebWuyNLsfMlvgPO4ZGtK+kEOJG5wmpJ22u6QJQdxM4pp7bFbaHRQZ3IhQMvZKiQVTUGjiUqWNcQNq6KaSYgzrxYf92cLuxz5gZuwEmAI5dv99aDRAyx4zkOnSXVtc8aZqSBYsUbCXJDGPRfBPpXj6O+sKBzyoGyxuSeO4x2QyJnvOXxfovNBiy0pycPSsfSCTQXVtPG8xCGGpE8UBRRMj8/kTC0+tPpEmhRb72rM/9/DnOIb2lzbXyOVhYEAVrapAFYaNVTcNjF2UhimO1iWPnwsFCq44y+hQVElBojETq8OTIV8DI8aduIv8wtv94VcpSyQo9B0MHMacD4xP0iAjGcgGLb1oDTurYuRzieym0Dp2dJM0XgUTW3kTBJMMN8oRGvhA0WvCN7Iv/LCFiQ3G1isZGY1RxkuoI3tq3UVXRxtP+C1Y++8y6pYXyEE+ux4XBBMJ45PYj5ZMM0hhTOK756bzE5Kqir0DWGOyV7nHH+Vcy0DljhpZrm0cQ9ZzOkgv4+kFXxg90xt9lQFphmPQLBLQn9/IquWM9qEG6MzmS4sOWHJLUt/dD4oJKZfrM1Bjgamai/YvbNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261102123227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JSoag6p4nCJoxOmGVWMCy3yvTzCZKcB8oMR6HT58PQygEuuw2M0pMnenSm?=
 =?iso-8859-1?Q?btQh1yqcx2RgdrSqkaSsdJVKn4kCluztJ9O4hPIYnZCrbzUovVM8m9iWXP?=
 =?iso-8859-1?Q?poWgcQT0SxKpWi5x2E6qrPvo11Y/Ii57ae3DIMGKu7TEr3rJMTeDqaxFt5?=
 =?iso-8859-1?Q?8HjtRN0t8IuM5r/Bk2EzDxKNLSMxQQtVV43SIUu4KaN+6aRydPnAXjF6t9?=
 =?iso-8859-1?Q?rQbEYToUw/Vbe6xzZdrh8l+NN/YOJivSIrli8WCMQPJsVPr0wwWUmkPSqN?=
 =?iso-8859-1?Q?RsKltBXhzh1zkoYjmBs0PzSnU5H+F3ubZD7YATiarOdB0ugzHse6GJ9J/s?=
 =?iso-8859-1?Q?1MNM1VZWbLYmOhaQEysK6UPybOhEBBrIjI6Og/+o82TJXfzC9JbNHHvqgb?=
 =?iso-8859-1?Q?JEYUqeuW2E4eCypnHfBgFQ++ZkSzOTenY4agImm1/HD1h5pzSO/sDuovco?=
 =?iso-8859-1?Q?+F6lIxIAeyJBuh4yDbp9QqIWCDWEJoZ4G8ouMRSEEu2BPQk7QlNN3SDPSw?=
 =?iso-8859-1?Q?S1OGzn1xCR+TCPOs7bi0SlPvcjINZCXDVGKTFlQ0YyJz32Nfz3dL+vgQwd?=
 =?iso-8859-1?Q?NhfZWZG5fe1T1RpsgQZnrRfEyTbVD+4W3i7nIWptSTgXpweBmVzhtUg4YD?=
 =?iso-8859-1?Q?JzXOIkdoLFQDQsI9dclOJIH+E976BV5vOHb4xdJ+H/+QfN4d83wQVVROuo?=
 =?iso-8859-1?Q?KoabMoF8yg9Zs+JAJajcO7bXMZX9EDZ77XcI2W+spVEcW7qiWwz15+nJrI?=
 =?iso-8859-1?Q?uWWGnlOgcJD1YfwEHot2x/BKBlLL1l7hgiy2IXzWMiYInxn9D4xrN+TSLG?=
 =?iso-8859-1?Q?8ck3Y4GPcqaxsGdD5X6ompPAGSCX39HDY8YIwZ/nsDLvGMoQBHey4t7ljF?=
 =?iso-8859-1?Q?fmCOlxnAK8v0X4CJTDqFA68Idi+xdSF+vXrITqSt08iBjHMutlFr5wgsmC?=
 =?iso-8859-1?Q?Gr94lXFGQRxyj9uZHZ4WH68T6f4WOB/rxRDwALj95Hfz7cIdioZDeFMBro?=
 =?iso-8859-1?Q?h9L7GNooSAi7vEZRogz4HNLvYoyzrZWlAopFNEC/4VEaRvJg8xeCVTA70t?=
 =?iso-8859-1?Q?IA5XI/1bhGuhb6DvSeKbQh2skrAgSEARK24ckrv75a9hzeyBpeM+Lfs/8F?=
 =?iso-8859-1?Q?8OqWkDiZ/MX/cvHnWvQXN3LUsTCdshrzzXMQlhEC+PZr4wAcB8SQsQ9g2H?=
 =?iso-8859-1?Q?DS6faUJ2NySbW58nJeYQ+gfjq7DMgnLRvKuOXnyikZQtlG4DIoqcEUe6Sg?=
 =?iso-8859-1?Q?gpCYaWSNz5KMmC1CvChrDQ+7/sZR8pDhtoUOAHoxMOSBeZYFW3PsBqW86Y?=
 =?iso-8859-1?Q?WbRyB9lRE/9GCmaaG3iE+cTSHzmo6exxRtFijAMWD4yIiw/p5Aa/BRVdzw?=
 =?iso-8859-1?Q?3p7z0qIFdZyjEK92zMCXxpThZ4AU8n9a7MnogKE6BO1ySs1vQGYyd8BeHZ?=
 =?iso-8859-1?Q?HuAvKIos9YPI7UFLfWKEPyIDF4kgPXlk2D9SVqq66ZfgJZlb+qqne/vGRK?=
 =?iso-8859-1?Q?U3aag4pUEf6bfq0YduGtKR93A3HLjwjt+ujKxgEmklBKnA7QwQqQAiPLZw?=
 =?iso-8859-1?Q?0nj6YP8mwQCXug0tOKJpYcrO9sboQVuNPHxGR9qp2K0ZZSE1LwrWE8KlSu?=
 =?iso-8859-1?Q?Faf+1OBQC3rlCp/Xag4+SIVOhva5Zco3hOUexj9pOj0KsZ8mzIhJMJth83?=
 =?iso-8859-1?Q?/mFRYDvzlg2GX8NXa081xRGYLnPTJWOMqtwIeuMUnc9SLRsxTsI3xjWUJi?=
 =?iso-8859-1?Q?9Oc2PkMuxD3oZrvTASjRza1VAJmNND773E6iVBthXIs0GS4Juv78/7axws?=
 =?iso-8859-1?Q?Zp/pqESqNQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a11b96-f808-4b34-8b9b-08df4aa1eedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:12:26.7486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yidXcGYdDyePNcF65+juMDJfs4hhBBE+DMfyfyDD/Q4EV4Djh5Vilhuo1+uQD2Ml3W7mh+G42h/W5ubH2qrSqYJfemmKE7UnftTJh9cgbFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8385
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1=0A=
 1. fixes lost INTx interrupts in the ASPEED PCIe RC=0A=
 2. converts hcd-ehci-pci.c to DEFINE_TYPES.=0A=
 3. adds the AST2700 PCIe EHCI.=0A=
=0A=
Jamin Lin (3):=0A=
  hw/pci-host/aspeed_pcie: Fix lost INTx interrupts=0A=
  hw/usb/hcd-ehci-pci: Use DEFINE_TYPES=0A=
  hw/usb/hcd-ehci-pci-aspeed: Add the AST2700 PCIe EHCI=0A=
=0A=
 hw/pci-host/aspeed_pcie.c    |  41 +++++++++---=0A=
 hw/usb/hcd-ehci-pci-aspeed.c | 118 +++++++++++++++++++++++++++++++++++=0A=
 hw/usb/hcd-ehci-pci.c        |  99 ++++++++++++++---------------=0A=
 hw/pci-host/trace-events     |   6 +-=0A=
 hw/usb/meson.build           |   3 +-=0A=
 5 files changed, 204 insertions(+), 63 deletions(-)=0A=
 create mode 100644 hw/usb/hcd-ehci-pci-aspeed.c=0A=
=0A=
-- =0A=
2.53.0=0A=

