Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A79C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 05:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9GoG-0006V0-BH; Mon, 28 Apr 2025 01:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gni-0006Sy-RL
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:07 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gnh-0003tX-3Q
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745817185; x=1777353185;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g9cqc70jCG4JpbuqSySdk1X3AvjvX3RX9bMDbCf1L5g=;
 b=qlITSCQgeu0FfXUlpbXbihySU7e+Ip0Q/7jbN/L6mmnjhBOiQvauFDso
 PXmY64VN/7Ig/W21PeIJ3kePgq9l9DtrejTg57lvcjbeWhHFbycEArbS0
 CbaZtujXOuXqy9p7RcphbqCFzUrXltNEph4x/o9gUOFrgek5S+s5pZHBD
 dzo8xR9gHfkUkVGQ15Hh0qXaIXGHCta9Se0bfEVC+tmSNpvPTuOPSG7ZU
 jcMJQaKRDyXFMMYtuTDxTMRuMByG024vmwLHp0EMrCu4R3puG+VLsIdJ9
 fVApID7zhl3mGskiLmN4Hs5zVi8GOO8qbrABFDTH0UYXMwyJrI6JRmjaq A==;
X-CSE-ConnectionGUID: T3OCtRYpRsa2o2q6N1ppbw==
X-CSE-MsgGUID: cxYb2DcUSP2xZXOm12LITg==
X-IronPort-AV: E=Sophos;i="6.15,245,1739833200"; d="scan'208";a="35826824"
X-MGA-submission: =?us-ascii?q?MDFAom0kCRSl2CUx2btPLUmzhsyRLbVO8O3fWE?=
 =?us-ascii?q?veO6iYYsO/m+u77sLnxH8oCvaDHIdOXKAfQRv79xsnNU60Fog0G1Qv1a?=
 =?us-ascii?q?y2CCyAW7ZuQcXbu2MZH4oknh/Br88hBOKU47fA4OTnYsabjTQ1R2DpEd?=
 =?us-ascii?q?FcY48vWtWR31mcIAe1XbO6Zw=3D=3D?=
Received: from mail-westeuropeazlp17011025.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([40.93.65.25])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 07:12:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFnoAhFEmGdkZq4AtFIWN6XD5hZZhc/AwVtg2XFWrBDNH0lxci2kAjKF4+L0k4vgznKATL9pdz8tSwLnEfuk7o5CHKsgCmonsSsUPJUZnGIYwiK4Q+EjIoZRSWftdPK/SADPGttob5GdV66NkFrMs+nVGf0eEocGDgGIGhAOH3vQEtV4brd1GrUHg9RENhUsTYOml8tSYPrvo9GbXEb66cSXCSJEm5VEfPZB+jUWwSd1NHZfd5+XCG54r26W/ya2NpbQN5qy9Wz0ddvVvbVOz6Z8sCE3YylbQ9yFR47FQFrdZjhotp4JfLKluwi/2w4d16BQfKTS1uBuTYXizdNhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idNZKf3Ky+0ljb7i2FQe3ge4Io2pidoqePUjppk0noI=;
 b=SwQCk7pT9eiWJLdVddQYnft/Nrup4tpWhDkF6hqM+/usOt1RGWhKz3yOgf5G42ln006MT+rnMK48M1La8Xk0YeI5xn8bY1eZOY1aPIcLMvH1fOe3zWkvbIOt0T/n+pX/a3ZuMIX7/K9sBgrc2Ysn0EgGWfdsbq0ok4Va2/jFehqu3UfvbVEBRlkTo9zySe5nn04lBNQSssGVPVwJQNEZMnTJTQR04ZUe40waDXwTkR3KVgIbYKYpU/zvJ546G868iv3NNAD/Uj9YKWlF1TXGmDwf1TNrkk7DT8PPbPGDYr8G/StmqyXeA8eI7BUJXJ0oGWytEGQV5YHMXJYeKkKJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idNZKf3Ky+0ljb7i2FQe3ge4Io2pidoqePUjppk0noI=;
 b=Niw4M+GmzKOX0LQYfwt3Y7dsenxOlvwuFDG3rgLI8eKrOCPOfp2xzIHVxym8zQt4MgGAo6/8SF9hFRDTL20Ayrwa2CIqZDkRvTnziNveHN6vIDDjCzlIUPovEFi7FeBL0O24oYuH+gJBrGbNRbSyFwZ0xG8bHBfSD7SVOnFvD+dbgxj5X6slJ76dkozYJI2x+EJ0LoGyher2EGnvwr18QbhWza4TqSmiV7/zfRpUm4P3Hb0cP8M4by0xaH/W+ouoQ+8RbB4Jcdx9iACPysFzDRWW0mNYRYNU7Mh4t1O5hqJvedgMBv+fuZEXWuR1/FCTfOtFDoh2vI5NGTLoTPUIZg==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by PAXPR07MB7774.eurprd07.prod.outlook.com (2603:10a6:102:135::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 05:12:56 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 05:12:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for and
 creating address spaces
Thread-Topic: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Index: AQHbt/wzwrZhvPrcvUqcZsB0k76GeA==
Date: Mon, 28 Apr 2025 05:12:55 +0000
Message-ID: <20250428051235.10767-4-clement.mathieu--drif@eviden.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|PAXPR07MB7774:EE_
x-ms-office365-filtering-correlation-id: 13202200-43ab-49f9-2811-08dd861355e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CS1Amf8za8xWC+XWAfrvGnXQzfpYZEejohLnpmoGLtzOPEfpeMJgH5doo+?=
 =?iso-8859-1?Q?yiUvNGro3eLvi/vzxTDCtNrkZ0NQr5dhkqobQ1K8wGj5Rv//lY2Ngp/f16?=
 =?iso-8859-1?Q?cZYOx+SOxtQzKgxLZS7Kuwjuk9axkvapNl/oMAUGP18WPxd5VRuFKKcPLk?=
 =?iso-8859-1?Q?/iYOOI2A5k2Zg0x5Js2K366SbgtaqIkeG23rn2t5fh+QkoBDWstph0KdAW?=
 =?iso-8859-1?Q?CFPdMGym3Bz5aSJpqhWU9Gy5o0TnfSssu7W9E3dOLkW6CgkNfjKa7AHb1Y?=
 =?iso-8859-1?Q?ONTEsm9LAHypIvRmYlkm4eHCisMic4a+kv9sog4+9o8yHAFIVaz6OrE71m?=
 =?iso-8859-1?Q?W4XYBO4fnzecq+8Ji5PqeixDzszbtkGzu6a6zVbSsBaKr/9IrR1Da8fROB?=
 =?iso-8859-1?Q?+SDputbND9deyz3mk09hiQ4/WhSNFjvmfEoEnrBhunLN010jeQVTurUB/U?=
 =?iso-8859-1?Q?ohwFm50FkGvCYRSBHXLOo6fmLwakb3E1Xt+4WR5k4vQPgxFb3DUGY+usN9?=
 =?iso-8859-1?Q?vFA7Fq2YDNY/NWjMfH36OHliRm1vqq39m0K5+aQiYfylsRJgmQ9o/rBf2X?=
 =?iso-8859-1?Q?R9xbk495lmNnonwe6PWxn9E30cSkS/9efX0dZJvydimt2bgN+6Il+g5UYl?=
 =?iso-8859-1?Q?q861v3raC0FgKK9pD/atoQepvZ4x33fVYsAhQGm0bDSdTouQHqaKYKB7KH?=
 =?iso-8859-1?Q?+4taU+WwoJunczsRIr3dPPwie4EJwTQSlcTNXA/tPVS78xqkC2rlIN72/i?=
 =?iso-8859-1?Q?qvrZPDrhKk1m7+xeht3ICJLoyfeezTNG5IzmZUZgrNDwE0Xmcj1ESrki+r?=
 =?iso-8859-1?Q?UxZ9rEEaCOeatCj+J+yJcSQGPTivadLaMaqGv67YKmC4tsr2KPcr+c22to?=
 =?iso-8859-1?Q?eDpZZOmfe+LGdJ6TwRHs6FhgncDMH7zVtV6Ed7SJEJg8Ow+s6iDUtQmIsI?=
 =?iso-8859-1?Q?IgQqlE0HAyywKAEHwLy90+iML9ofO1UbKD2XiwLX5lAl4QgnQHeIJ0h+vp?=
 =?iso-8859-1?Q?sToTvMo+V8BBfUBbIq0zdSE+VvZlPxt5VumbCROgci3FV5NLpWdy1uDt07?=
 =?iso-8859-1?Q?JX0AKEW0hoqVttcVO286YL0n3vIqT+2wvOdTsAIUbYNgRJoH4KZOQdr5LA?=
 =?iso-8859-1?Q?abKl6TNztc1RfUomtxw0L7bonWBtxR5WLKXq7QpcsI/7GkLWfsKtHuEvTj?=
 =?iso-8859-1?Q?hnP3UOKYnab4uWbJYoT0OQr9PF57VKABKI0PdhUZ9UfbUtn9oFHWSCGwbN?=
 =?iso-8859-1?Q?20MCTQaEHZ36LDYgY76nTXHb3wCYyBnuswC2eEKWJHaZNtxr7sCzrV4Nhb?=
 =?iso-8859-1?Q?f9CusxdE9zFlA5dbekV9Qebez3/p/W8Her9GcRVmdVPeRAryle0U5qR5wx?=
 =?iso-8859-1?Q?eAITRxS0/0JkiKKpEa0xvb7UQE09OfWrNaYnMcFYKe4lTsbKRX1MQK4xvO?=
 =?iso-8859-1?Q?Bh59xlVggkqv+odfemZB3x3QKiahXcyco/P+vvEfQwfdfzg5H6S1Zpv10a?=
 =?iso-8859-1?Q?XLrXyibjy86PzHzAnjJcUwWqbtvxEn+pxggViX3NgfQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r/Rv30pohSh27RFceJDC8nhi6H9GO+y4AdVpuhrfwijFLCWnfxdoknkPQu?=
 =?iso-8859-1?Q?nzMJr6zNNrRkUMGJkDAwWs+zMs4aRTtQJ7qdvCxBfHOBO5OCFWRT0v5xlK?=
 =?iso-8859-1?Q?1zYF+0M/tQqiVt09uAgg0sdkmGpkOdp7XcspNNpMCvpatNwHt5ykTakt36?=
 =?iso-8859-1?Q?H1VN0m5XRlbeMDppQvJwxmgR3aJyDsih3WjGS+jIvgHaF7aK8bl18e4EoO?=
 =?iso-8859-1?Q?AgDg8qnxetcHg0Lp+uWWx8ddKUtq487M8crphwiD3l/4oAFTIPuo9CfAXh?=
 =?iso-8859-1?Q?JlOGimeteRphrsbgadKvM/zLa5OhHT89psTgu8mQFgkgCuqTXZba4phwMm?=
 =?iso-8859-1?Q?Z2vf2wlLoUFwQi8RRBNOGI0XTKqc5+Tl7zVEwLd7bIqA2Vdupcxzikp5SG?=
 =?iso-8859-1?Q?SqwCM29SbOEqr6dkGIgoC/TqgMPs/7SNUck5PozSaEBlpZU86QjVTWJQOF?=
 =?iso-8859-1?Q?BFQ/8WhpYgkm7f/OoSQ/e+Pkif1QM+aaEcE8AvZumX7NgWwhU648t99GBG?=
 =?iso-8859-1?Q?dLXu+l9LZ9I+EA2ytfqs9mMOR0AxgmBFMkMPSmi/WHKBCnZOiV7ydz1q1j?=
 =?iso-8859-1?Q?N7zRUt0s6iiOh7Vt0Vx4UoG14jLoHDCHLP7mBvva7ql/HGdnSIrkY/qiTg?=
 =?iso-8859-1?Q?AAfwVgvfaEEDrqv5Hegu1asxd1V1CeopX9kXddpo3OwOIR+t8GDxZ6TL0a?=
 =?iso-8859-1?Q?oDFaKcOHG0umDvlbcKLVrwr0pktmiB84vT4eXFJp8FYUZYAYpBBsGFy642?=
 =?iso-8859-1?Q?QbNtsV361fQL6Sc35l053mckGbwPjNrtm6V27D+yR0Fn80aJXUiY2Gr9La?=
 =?iso-8859-1?Q?K7j02HNkiTRxlDQsMzvYV5qsTeBixcxvrqB8Lff6ZFO+YQChWqAJegb34R?=
 =?iso-8859-1?Q?HclqaXMrU7e1QsehkBqpW80zGgwGu+gC18p/16aWSBkkK8p7WCRDoHEmHU?=
 =?iso-8859-1?Q?9edrOnNjVO1I7uW60fTMvL05D+9yFmCA+mNz7jlZnvtUWRKwE8IriPkeI0?=
 =?iso-8859-1?Q?ukofcXwfOxl64iBcwPuaOZNPErKrcRYoM78hQkmHzD2wZx2ekqnsJP/QLo?=
 =?iso-8859-1?Q?itmBVmiblnV0ymfPjlUyUmnTOWQ++1BOZyluZeVtkj9PWwc4HE29KDqaM6?=
 =?iso-8859-1?Q?wM2VTGWyFeHeQt1J3/f8rSmtDhjii0I6G8t3dr0NxMFMNcg1isZmNCgSJu?=
 =?iso-8859-1?Q?D2E7W3dZvK80etKaj3wDGVS4M0Dspjd1Epl90zPQ+hcfPgQ6KROO032wfe?=
 =?iso-8859-1?Q?qmk69NdMUyGIojBNra7DPHskuZX6k6FodulODs53EFCyfDffonTIUfVxXK?=
 =?iso-8859-1?Q?9ThCY1goOFH0+Mg9fO54249DHqhBuBZEpZ3aaLzYciaOuytbnKy92er0XT?=
 =?iso-8859-1?Q?p867sgB+ouqYiZury5MOeey1RQJ4ATE80CYhhKzwNv7n0pF2TqEVLTfSba?=
 =?iso-8859-1?Q?g6X+aZUGgsW32hyIUHsFM8o+SQcLxIm6FC7yTWoMfKcvu59zQixU0Nw96V?=
 =?iso-8859-1?Q?RPBroHe5WNbxx/YlcWP+0/X3mkzQ2YUwbk0ZfQV1M4Z+35UFclxwQt2FYM?=
 =?iso-8859-1?Q?klwyDDIBE2GTT7rXhD+G9ax6tpRtWv5RfdmeUttELwPbVGuVt8DjSeS7fP?=
 =?iso-8859-1?Q?qX7EZCuGqci8f0kjhGfA4pvWqM33t3hs/tAGjRDIc3FFxR8datiFw92qGa?=
 =?iso-8859-1?Q?ZtgsebNRl77n0Uv/pu4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13202200-43ab-49f9-2811-08dd861355e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 05:12:55.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OMNY9lN8FcXZpPBMhpOv2fZ20eDKEqGr/aDuppWfZL18xBi7T58m8Qbp8g0BTj8cEnypT6lHLPok5P3wVQ4gEb+E6LjIrBwFVGNU+rh120X6UF1lJYTkPsJo4U+YooO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7774
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vtd_find_add_as can be called by multiple threads which leads to a race
condition on address space creation. The IOMMU lock must be taken to
avoid such a race.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b7855f4b87..931ac01ef0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4203,11 +4203,15 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s=
, PCIBus *bus,
         .pasid =3D pasid,
     };
     VTDAddressSpace *vtd_dev_as;
+    struct vtd_as_key *new_key =3D NULL;
     char name[128];
=20
+    vtd_iommu_lock(s);
     vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
+    vtd_iommu_unlock(s);
+
     if (!vtd_dev_as) {
-        struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
+        new_key =3D g_malloc(sizeof(*new_key));
=20
         new_key->bus =3D bus;
         new_key->devfn =3D devfn;
@@ -4302,9 +4306,29 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
                                             &vtd_dev_as->nodmar, 0);
=20
         vtd_switch_address_space(vtd_dev_as);
+    }
=20
-        g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
+    if (new_key !=3D NULL) {
+        VTDAddressSpace *second_vtd_dev_as;
+
+        /*
+         * Take the lock again and recheck as the AS might have
+         * been created in the meantime.
+         */
+        vtd_iommu_lock(s);
+
+        second_vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &=
key);
+        if (!second_vtd_dev_as) {
+            g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as=
);
+        } else {
+            vtd_dev_as =3D second_vtd_dev_as;
+            g_free(vtd_dev_as);
+            g_free(new_key);
+        }
+
+        vtd_iommu_unlock(s);
     }
+
     return vtd_dev_as;
 }
=20
--=20
2.49.0

