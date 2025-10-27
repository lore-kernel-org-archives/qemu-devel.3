Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72326CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI2e-0007zg-LT; Mon, 27 Oct 2025 03:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vDI2Z-0007eb-Gs
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:53:19 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vDI2S-0002iT-0y
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761551592; x=1793087592;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=XJ1OZKw2PI6vBg96TMvCM9/Ww6Bh66CfCaEXx7wD2fw=;
 b=GBqt+LJ0B6h8ZMNC5bJd3TQ8fef9GSsHdLgL2TxFGyrG5SxSJhhdZHKo
 E4INuWkHc4p+nuAPW6ZaXg3X0FBcO/RsjoIj55oFF5HqP4Oubuen8hcDv
 wZmNuJj2oF34zeoz2ANnOwohbO5Ny1zJ1yQKC7cXYZupMNZ2WBAfnG+ZE
 omaKDfL45C3xR/690feaZVe/RNxyBlbbo+oG7TmCtS5ZIH++YDu7k+4s7
 W4h9EE8yqxuAZOMjh9FFItCaMZp8p8LpRy33gBZ8so/YUUcn8GbytQMNS
 1zyXriitG7Wa2ipUi8oAofGLNrXdoecgrrityuA8RAGhxQ7eIbtZ8SGbX Q==;
X-CSE-ConnectionGUID: TSa9KvqESMm439QpaSiFhA==
X-CSE-MsgGUID: S3KWhLyqSraPI+mHxwj8oQ==
X-IronPort-AV: E=Sophos;i="6.19,258,1754949600"; d="scan'208";a="44130416"
X-MGA-submission: =?us-ascii?q?MDHNpaX+tudLKodCjg4AaXvjhSpxaY2z4eHJd2?=
 =?us-ascii?q?KkXrF+OU5vafCZxW1h9UXvEklysAJUdAEumUMVNIJZC8SovFdezLQ68a?=
 =?us-ascii?q?fvaGi82LNwm0XYX7uSLI2t551H3I5vR0cIiIwFkixFXwxrRZiXhODwyI?=
 =?us-ascii?q?74TLdJQ4go2X1Wn2fMZ1YKUA=3D=3D?=
Received: from mail-northeuropeazon11010042.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.42])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Oct 2025 08:53:04 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci/Yk0o0iRw65yt4E/fIKA8OUche4Zc8fgc79+5WRWoImZOg4mhW1k7HxGLWfu2kMd3U9ZBunbWfIYMXT5rL2lltVLKTW75O8CY1u55MQcc2BgfRxepLRSQ1EYJMHHmZHbE6XfoaX1qomg9sQpKdidhBUCNnZ1zPqIiilsA2Hq6yIYbHiqABqHw/F0fse+xj2WMgA1dm7V9YDEwzo7RCsCjkc0GxfZq9oVd73Wbtrw68u9KGC2oDZsQaT7n+A4Y796oNVR1wwGaWaDmPXS28+Psw6cqKTZyl1kU1VS0xXhPxBC6ZUn8X5PZntKmfku070bUFfmKU4wjNxOsD78eotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BGT2xMc37Ds1hCCMgZlMuBh5eaybgr0rekyFNtnkHA=;
 b=vjMfEO5IbCDKnXJIrEmepIymMzyPPUeOaOFnESO/fqFh4B6kdoPlw2ENlZIvVyRaeSj2dLucD+dSbr0e8LCo0HRDaq5pqbu8fJpG7bWh5XglvkSRzVuxDB10r6GWhi92vyVRJQtj1teTkvCIm5T40WgOqksT4tbccTzzWKjJQ+IILLLa/3sEMZU5RAX0vnme0mZ7lAMYtbN2cWwLE/LBVQ7mlNSA6e/1qZ+7St92KlZXiwD80ZXtn0vSwVCgTrEhBCJZX0PW8s+B6dF6lndNscbXqP05S9hsSe4HxV5bnLBSobvSfomDzqmvwsXphqz/uMfxoVwE7dOCrJN3bWJoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BGT2xMc37Ds1hCCMgZlMuBh5eaybgr0rekyFNtnkHA=;
 b=DWeH1f2jJpMe1JsZ3Thrbh6GDwZb4QZgzHjODDLY07hS6GTsyadrQODnpFj/NIKWGONOpigiItMOGwoHRBqgxe02CoISsAwKwhTWFjxYysGgfrckYCmVzIYzNR0eYs2fUC1qRO1ixOfaIpDDR6+3msdzyMKTyWrTZuE1xLWjtQxu9PLrfuxwwh0+HFUIF0989TSfKBxmQ/mlTJ/v+gyOXCBjUFLw2jaJ4NOjnpOIwTtb4VNVKjfi8snG5u24PgTcQiytJeDmuKUo7xi1ZBvC5hwCTSPOIcgwyrnhrRpHLv/wkdlPS0GGd3JUhLgYqy9jW+sBWbaDNa8ujUIGrhcx7g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7483.eurprd07.prod.outlook.com (2603:10a6:10:1e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 07:52:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Mon, 27 Oct 2025
 07:52:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH] intel_iommu: Remove an unused state field
Thread-Topic: [PATCH] intel_iommu: Remove an unused state field
Thread-Index: AQHcRxa166oz1NZ730SRvUVw0E4oKg==
Date: Mon, 27 Oct 2025 07:52:57 +0000
Message-ID: <20251027075232.95262-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7483:EE_
x-ms-office365-filtering-correlation-id: 3bc1ce24-943d-4eaf-ee64-08de152dd82b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?L+MyFMBT7Z92Az7wH7fH7ONEmn8xLOZjYEGHJxFZr+WNvaIuFag7UMEzFf?=
 =?iso-8859-1?Q?f0tc1q0sLEBa9xO9Ot7+yuNDr23qysAl2ZsLfCoVMBUlyRWPvp4nr4pG55?=
 =?iso-8859-1?Q?XpmiL+m78e07vQuMZmp7YLFdELWZIOMn/McsLCle22WvtYoyu/M7l4UaAt?=
 =?iso-8859-1?Q?l1t2lLzN98fa/eP5Cgt806UqVfyHfFWo32K7mRAySxjSp0eUWL1LSQ37l0?=
 =?iso-8859-1?Q?yEzufaWjSzW92fyqStlY7gDO7WxYzHtTCDLJTsxC96m4VkBo/C9XLbY/6N?=
 =?iso-8859-1?Q?Tv2MF1YmAkZXK2aKRK0WnW2sF/Z+4pq4It/aXwv7s/oidzCbn1ZdyLNwKd?=
 =?iso-8859-1?Q?SeH8sPRfmN4p5k8DaXNKPrHkMfgOQCVpv9xm1fC4D3NTDHq38kYwzMrK9w?=
 =?iso-8859-1?Q?blrql/Zo3J3II92d7Z7PeSF0bVLxOGpLxzHG6c2QsjMlO16jJc+h2xSTHB?=
 =?iso-8859-1?Q?WHZEUu4UgF6CJIoWsGFNPI/LO4uxUZ3VS3hiMzkfFTAmLPeVCmJsgCIABD?=
 =?iso-8859-1?Q?PzW/nhVM3q0Y81+JCPvNSZQY+Ccx921dLG1uzc59AYHEde/jl78S46WX3O?=
 =?iso-8859-1?Q?wOKyzO6d04EYnjCGmnuQBjKLVA+J1QEs6dt+Y4ts1HTzw13kQtZRpWymiA?=
 =?iso-8859-1?Q?cMgeLGU442AhXSkl8f3Ojk6ERJfD3gv1ySKiv8LnT5dni54sH4Pir6pGyL?=
 =?iso-8859-1?Q?koSUEL564pSRS0IPSTk8t70hugmKrXNTi97vX8JN3ZvbfxSutbW237cSWK?=
 =?iso-8859-1?Q?9CgQshN6QIpUDCKnbmdM0F4lpO9caVkoZBh+4Uo11ej7srI1zLdU7PsnMp?=
 =?iso-8859-1?Q?OsaG0g9iBG992fsKGrBlGQ3dt33zoGnd6rfYcdAaXBMVNSIlVpSEKPGxsd?=
 =?iso-8859-1?Q?sdyFk7Yxq7S63tz/pvE2uRcppgHykqoBzvidyI7tMFvZzpvvbaVgHWpV0M?=
 =?iso-8859-1?Q?gvSETPSNPzcDOmQNq7dRIQznEEqkZVW3ntoJYQ6LquGX0PAJ6yJR2RNbIx?=
 =?iso-8859-1?Q?7SYf4FK7l/8XvjpO/w3H6qkOISQAaPgqwnTESF0Q7WGJrCvMr4YSBNdr5D?=
 =?iso-8859-1?Q?EoxdZYUssWcVbv35Lb9R6YsEH7yAzFmxF4OGG5JNaiPXe1cobAn1XxO4Ri?=
 =?iso-8859-1?Q?3OhaOsL9QcuLLkJ1QjWJ30tSheK0QSdnc12iiM7+LjM0hJoglQgHaLE5/z?=
 =?iso-8859-1?Q?bNfQIIvpkgQih7J28uCu5KeFS3TfkIAmATzC6m3/Y2rGXWw+/fPc5EZNcb?=
 =?iso-8859-1?Q?91nxgqE4OG4duCWfDEKea9urZlJHxo8oVpOMDgcEaJFLvAySeA1x3DRjuA?=
 =?iso-8859-1?Q?ssoyEl4UBfuK9wg5CCS/0yFASeJ6dbrQjzi6U/eXcb1AG8zC2X98ftMU0r?=
 =?iso-8859-1?Q?k/VJWdwiJgeT5d99qZDDSeYlA3WRlxCA3kyb5MGpdcp3NuLvrSUBN5nl+/?=
 =?iso-8859-1?Q?YMjQUFS6eo244jz10XRo/IXHNCQPO/BZs3yzqaCmmP/D7neCGbUcZcqFRv?=
 =?iso-8859-1?Q?MZPDrzkDV9kH8mttFgpJFYSsBHX+IYmY1ifWEpGZ0du3ZLBkfatiTRomK8?=
 =?iso-8859-1?Q?gUYPY1sxezWW0ApwYDeGC7vetOkD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2oYn27rcSrFaNzBc67sDz6bGUHcKIuIHA/50HklGkpBcKs9S7N/jrs2Cr3?=
 =?iso-8859-1?Q?Fu3kaXmkgZnll/F3hMFzpOOqiUdE8D2QqzOR19NwRwJ+TZZ+ZfvDOE4zTm?=
 =?iso-8859-1?Q?Xdiy7bgqnCQCZ2IVrXxx4KbqBCDa1aOKYM2wFPQ0fPVR7UVsFkjXYNhArj?=
 =?iso-8859-1?Q?RidydHh0OoTrlFIQM5ENMHMf4o3va3thpW4JI7QfviYdG5o9VrXjTXjiZf?=
 =?iso-8859-1?Q?AKVD2ffFMgXoFvjxyqUc7EED9F1haJrksBoHwlKNHdqIW/tsZE+zElFPIu?=
 =?iso-8859-1?Q?p/jUmeb4qxDaB2ukBx+6IwNm918wiHoKV3Un/jcw4j4dCO2NGqN6va/py4?=
 =?iso-8859-1?Q?YsNNYtvgsUqkrxJC7tOZViI7pBprHRulx1jyvpZV9yJKn+d7cQlO9PSRZk?=
 =?iso-8859-1?Q?aGKUP4FHVlMpRmjgFreWr3RCU3JCTKmTEtMUBQ4S9zvG2GWdKCyHE6KhPM?=
 =?iso-8859-1?Q?n7Qw5JINE3CMv9jbssfipwzf3tEZRMIXtOXCw6U7rL+aQrEpLhYv7yNJLF?=
 =?iso-8859-1?Q?jd8+JquyvVZ/UlfxKRUb45EiT3Q/D+5JaQjiGx0QWWvZXnUwU47euToF90?=
 =?iso-8859-1?Q?HM7BP9bawGU6iRbObKxSWjRtbZCPoARiyG3N8CTIjg3UrX42CZuCio39cM?=
 =?iso-8859-1?Q?XFsCxL3DykdS1rwUa913gKE0li3ZPhmKcH01zN4aolinjUElERa4zAq4Dh?=
 =?iso-8859-1?Q?vlBzmcq3hTjlOWG/QSzLQSIlmVNPHBCNCMM5p18h3lfL5mIwq88AiyYuT0?=
 =?iso-8859-1?Q?lm140w+K40ZhJ91Sh5/rd1JC6GIIr3S/ZPwrzdRt9wxAuLtMvSjkSU4M6K?=
 =?iso-8859-1?Q?Kd90BDXciJZlQhFvTDrUpgTSn9DK6ooLK+Vq34i2mWHe5oZDGMnQPc0hZD?=
 =?iso-8859-1?Q?cYlHV2Jj58Ad0Jv4jx5LTrkFw/pS+q4SR29O6yJsS1JexIKuJgLrldN55U?=
 =?iso-8859-1?Q?++Wt/+z6Oz1D9ueNSl1IblKD52Fx6rGvDdUBVB7bE1dX5e/XBFxXrUu61O?=
 =?iso-8859-1?Q?O6UlsT5cLWwkgRQRsfk0kyJGT7DgB0qbBZHiLJve6+JmfYX2Rc7WFWgBJM?=
 =?iso-8859-1?Q?mEfHa1kK1EVmpaJ6ipF6HI1bO7WhdkC6HMpouujbNS9jtIZpvTym8pY8C7?=
 =?iso-8859-1?Q?j3UM40tzkBWTvxUdsuQHT/KKeZ3L94v5YkiF9lUMvG364kulwh2NPGJYxh?=
 =?iso-8859-1?Q?LOIgE5K5kVwboU849dZ07GBgaBOnvPfPauUAIReRFJ/6wpPPenwfBOpoJa?=
 =?iso-8859-1?Q?TQ9t+2arQU4R443phOhL7c8UqFNZ3RpSbdsNKk9eSaX2uqS8v839qVZVlM?=
 =?iso-8859-1?Q?JEp+Yu04ZMG8QiysVE6BryosR0O6h2JvwmvOSHLGXfeJZBKJYTI/s5NDI9?=
 =?iso-8859-1?Q?hdakonEcJVGj3L6KC9D4CDjRdqRLAL2GXwfkzRso7qZYLZ8Au4zoK+tfvB?=
 =?iso-8859-1?Q?RlJ8NGuwhYQjAxrqpwxFFZ55m/xSRpHp+veNNOlL2Z3/xSflDe/4l/yECI?=
 =?iso-8859-1?Q?k2pxToIN+e3kqV8gdbyWv9TYVSFZvDiZZ3gLfzyvE1a83xpTRjj1qODKfC?=
 =?iso-8859-1?Q?4YgLLSFKtm9TmNV8NnGaAAJ41YN2Aveh0Bqlr/5GKXp9kleGrkTm+1iq+o?=
 =?iso-8859-1?Q?hhMJcCjncEvWMOFe72e5d79RAIwaA2EaRpFzTVtBSAAo4LstCRDzLdStcH?=
 =?iso-8859-1?Q?GzQkuNE+XeQj5GvOXoE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc1ce24-943d-4eaf-ee64-08de152dd82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 07:52:57.7131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXVMeW0VIIzJRjgAkKelHQDutyawcK+MyQAJ0Uib0laBI3gNCryqCkUFlVrpovbUCbZrMVw8QKyblFWF8wt6C61BPFM0NH8WD2+koW0de0hSVvV/fHpFPmvBwrkGxFrm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7483
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

dma_translation has been moved to x86-iommu and is no longer referenced.

Fixes: b6b49c2cd6c2 (intel-iommu: Move dma_translation to x86-iommu)
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/hw/i386/intel_iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 47730ac3c7..b2f1ef9595 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -307,7 +307,6 @@ struct IntelIOMMUState {
     bool buggy_eim;                 /* Force buggy EIM unless eim=3Doff */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) *=
/
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
-    bool dma_translation;           /* Whether DMA translation supported *=
/
     bool pasid;                     /* Whether to support PASID */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
=20
--=20
2.51.0

