Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E665C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 05:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSUkQ-0008Ca-FW; Fri, 20 Jun 2025 01:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uSUkJ-0008B7-K7
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:57:06 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uSUkH-0005ci-Uz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1750399021; x=1781935021;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NtUA5H++ZtVaD1dwCDXk5HNWvAZSnGYL7bwtsqk1zRM=;
 b=UhgR5TvjDG2271QcMJHBoXHQR9xQlWJAYIksPkmE9MyrkHG9wStH/Ip/
 GT+ncomkw8OpPXSnA73iMJLj4nhJD2julJRHsFYH+3Bxk1T1ljkooIjvy
 BePdX6t4obG4K6PHj3xMhZ2N0RqbSs7kDzB8fkZp64mHY7WvdNmu5bpxA
 62vw82xiPiaf/Kaop2a4lyFZGSv+bhI1LBvxG60oA3pLpMXIYC1sQo6Rd
 FEC27EToXAPcQC2ebKeiieg0HSBaB5DdUTrMIfSzxxYCIOUPoHO5KjYZn
 MK9TcvgZ2Xi9xQkLfSPAiKA5YSe04O7QbaSontIliDUDiTMU/K5RYhbU4 A==;
X-CSE-ConnectionGUID: LTniGQ0DTcSlgpngCjK5Xw==
X-CSE-MsgGUID: 3m0ox6tzRk6b/uRx+Ml+PQ==
X-IronPort-AV: E=Sophos;i="6.16,250,1744063200"; d="scan'208";a="41190334"
X-MGA-submission: =?us-ascii?q?MDHqJC3CZxc/YTGn75VYVfIMlS/4m3uWnQRRCt?=
 =?us-ascii?q?oq7uRgRhLvJr3QrTJEyHhTpfyncV2Jw9DOGrHri8MnYFq0rjkqSoS9GY?=
 =?us-ascii?q?2ucADbqTT50ZIQTECperhvnDgsGhIVVaW0yGlYN2imAUAHlWe4ltkSlb?=
 =?us-ascii?q?Vw+otit4aaxYKV+YBnI24IRw=3D=3D?=
Received: from mail-francesouthazon11011042.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.42])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jun 2025 07:56:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYK2gE3D8bQoP0V3H6WW0YtQYY6+r0XUADzrqDJiokncYnp5yFHwzMZO9m+gBKTNw6sG2BBwJawctTclb9YE9f0xciDtci5H2N76ZoYT7clZLR5obJpM9jyHcGHNt6FYSUJIkZMbjYsZj98RkFKjJY+6idMfzAaaj3BLcOeItEmtzBGMCYushQhk3U/OT3abdLpT1ooiNVU3PgHW9vjtMuV+aMFL82QC9SKurKkBc/gg40Y5L81baJgzQtaIJ64Cm1u6R3l6nSamJsofa5EuKaFF/egrvqhP1MCFykSJ0PftO813J/L6Pkgx8/1ngE55ko+MzVRK/v+Nf0R40kEMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b20UksoTZ1i+jaI0zM5Yg+d1lymN1EwXBCvZ16FNHMI=;
 b=Ph2KELD7wD+TLOy0QPTC5RzIrDUE2KqMhCXGiDd7bwMjzuwEjHRBL4WLdg9ZGOdARqgrI0a9nnd51eiA0fAVf69bjTy4+rKFYP+bQX+gx+Nya2fu9ExLD9uzDYGReZ9XwnblIYqyV/UN7OAwFm4094LOU/rh0JUaOIlGnIyUbStkZZOm5BuCkt6RIjKuWUuEcwtTnIKYliWn1tdBWHg7M9LdJbDyZIiLa5zLh1suGBJZnx4teuzTbTrTG8p34YRVT+1VMhQrLZGEAP7YU89wF/ny1fhFwfCtI43nbklbKySBSbR0NEVysCwMemj6Q9P9bdffHEN12aH7n2M106zI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b20UksoTZ1i+jaI0zM5Yg+d1lymN1EwXBCvZ16FNHMI=;
 b=mCQVJXeGRmtNK2Ha1had3L08tY13QgQGWNjQ60glydur+HinStI/M98IP8a83s3p3PE4VlLCuiZCb2C4C5+06yCpGpk9yyhNnwd5zLrzKTL4/vSASpKlzkBOgGZdREAGxdDiq29X+auPAhiBq5PDGSs6c/kftHLny5eOzLWEJr9sEU0HHBs1v873F5gcYuFlSgiRS9xaVwIUXYBrVTFw5VIhaEpRneRhRgFV0dMqHgi278vabJDEZZtAdGQnOajYTPMASc34Ej7gv6QAgowxN4ubJuH5fHDwh+WrQ/OQ+HAqrUiXRGdtUwvPceygqUxxOkuPW0xi4oCI9r/6O+Yl0g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9853.eurprd07.prod.outlook.com (2603:10a6:102:38d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 05:56:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 05:56:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Ethan MILON
 <ethan.milon@eviden.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 2/2] memory: Add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH 2/2] memory: Add permissions in IOMMUAccessFlags
Thread-Index: AQHb4agejkRoUF+etkO4uq1FF4u38Q==
Date: Fri, 20 Jun 2025 05:56:52 +0000
Message-ID: <20250620055620.133027-3-clement.mathieu--drif@eviden.com>
References: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9853:EE_
x-ms-office365-filtering-correlation-id: aba3a6b9-45f1-4490-70cb-08ddafbf4103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7m9t4NLW02wh6/N7QHSnT7kbHyrneFnCt4wUV/bfDP/Czp2ehnjBe6NkgL?=
 =?iso-8859-1?Q?Bi3vM6c5Y7lA2HlpqV0LSSNZMLaUhceR1GPwiMEFpXX+V/sqjwEOFwGSes?=
 =?iso-8859-1?Q?8MZT4hodMb6P8SFJgALmL1DdC3enZN7Az3ovcy52RffVRpk+wzo1wURpZJ?=
 =?iso-8859-1?Q?/SN+EexGN17hcDqb6lqVVfgn+wN8GbcSvRaXsuCfdYcg+KdH1U79pgqeeK?=
 =?iso-8859-1?Q?5B2tk1lVJrULR5KNPovJf7+8joXJbNFbTH/44h45Q1UuQ6XMKmP95jSu6V?=
 =?iso-8859-1?Q?3oONXBtTtVObAK35Kt50pGYJoqOnCSHfDToYEpBnsS5BCtTPexOqHFCii/?=
 =?iso-8859-1?Q?kkUc0PJkvTvKXvLDgjNyUr3yS6meSzGHdj+YHY4JAh3+gGzqTPAwfdHQhG?=
 =?iso-8859-1?Q?eiezaRiAnJOeMigMX3ynxKFb1z6Et/eXBVm8hi+qPv/7BGQHgdMnIE8dVq?=
 =?iso-8859-1?Q?uXVN14qxFsWsi4dvWEdnSy3GrW37Y2pbXYuEQJl7Gts8vrVjra2BcnkdBG?=
 =?iso-8859-1?Q?N2dBfUnxE9nPYYnD/ppYY9kOMZ1arhv+8zZASqlOSZK4xl7oZqthywZLMY?=
 =?iso-8859-1?Q?AQmhCQfMWlMk0g8ogAVHVAKSOfTy3YaDUzf6Ty8GsbYp272BFNufLi5GTp?=
 =?iso-8859-1?Q?LCnuSs2zQbusC27pRwPCYrOwXLXiji8jeBaK4eBuOxj2Q25FMOIZzfzEqR?=
 =?iso-8859-1?Q?TvkwMRbTNtOqCTIj8gCvkeqVSPklKXVORnRVFCp5Nu2vUieKQTZd3emVMk?=
 =?iso-8859-1?Q?vofTcdyrRQbmrofpI2EEddAqYb3fstkc1WmQIxPrqlnmmUPHC0qWbvjqWy?=
 =?iso-8859-1?Q?3Z1nsb8n7XPMF9o7zX2ll9+7t3A8AYm9L9wbrOC6eFy9KckOe5z2W3vcBu?=
 =?iso-8859-1?Q?/2mIbiVlxzoiLNAsWvpNJSc/roxAH+CqB34BKVlI6DoRwHeZ2JbbRb/6Nr?=
 =?iso-8859-1?Q?wMYn/DcltzpmeZC00Z32+Hf/EMNCffOCsmfU3LZ2XvNQsvA83mPLkumOTB?=
 =?iso-8859-1?Q?yaVzyTwqixAFNbyo1UJzCaPOlNREBBXfRmqm4qp/VkfbSA+9XFW15K+Ih1?=
 =?iso-8859-1?Q?CDMQxrx4Bg7cIGtbFNmnOj791V/kjc65Y20d9PULVf5ZX47jkk/6PI6sLu?=
 =?iso-8859-1?Q?hwg6WRNdjnCzNon4m3VDYQUC0E15giRq5ElBYRCn/96OgfLTz5IwAYZbl2?=
 =?iso-8859-1?Q?dhq041kTBeowzhvbdO82VGxE2OXvZDFTj+Hno/F1zGfOCq8EX/vsrdgZ/B?=
 =?iso-8859-1?Q?bCEHazjP3+BESNF7z8H4Hs6Df/p2MzXGIVkc6ho3nJ+k3bfyvWBU+Qz0SJ?=
 =?iso-8859-1?Q?viKNNtiys7+z24Fyccu1/tu7dVD4JJTrRh0SqCJqCgXxA+8OOTw+SbXTrL?=
 =?iso-8859-1?Q?NqmBZxUs8HqxP3mWgW9++oj2WYYuEUzT659rRJYnQ+GJXflI7YPNwUPNcL?=
 =?iso-8859-1?Q?/H7YQRAo9DJJK5yd2V1nX13/lJDjxUH+Q5KOMGVEqWHLgGt5bKaqj8mS/n?=
 =?iso-8859-1?Q?BBcXUKxfKNtFkypjYGOOkuTudDzhDjGmXSg5SVlXUqLw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?utWHY6GnpAj1fZJoJWCa6T+3km3AK68uoFlbQwQyOZSn22Rc3wJLmsfv4z?=
 =?iso-8859-1?Q?eWLAkyg9ug10fw72HLObeOO6Yvjmjk43xcGoL1BdLhVLOKUF4R6xy8u34p?=
 =?iso-8859-1?Q?NCL7Qc0e31GRdTXEgBTxR3M0NLl3WIRgsbkLZR3/pIBTiLqTV/+4IFM8AR?=
 =?iso-8859-1?Q?Q6UKstgmVatH0HWCEwhDPKCVUyZhWGzmb6yN9/tRCyMaXvV39rF6TW+Fn8?=
 =?iso-8859-1?Q?wml4c181oRsnTZbBTdtMe6EjtDC/tJHO96xqtVgNYTmV+GS6omsI3iBD59?=
 =?iso-8859-1?Q?uFak9ZbfG8HMTqGvsU8wRXLA3dwj35H5XV9jlYYeef1+TiNUDKUrAcj1XF?=
 =?iso-8859-1?Q?dDRCpSeX0uVVv/L7ma70ze5/+amVLBx1qWsNGxWr+T7GLUftd/RBnMti7O?=
 =?iso-8859-1?Q?lNsnOBv1WZs/kWGdAuqDcjOAWz9cupnJzzDbOTWiAL8M3bKdAfhzAAF8Ud?=
 =?iso-8859-1?Q?WfjsI5o+JFDilWudD26jdYDPFgOvZuCylj00CEgNrD5PFZH+2SYlXdOPXD?=
 =?iso-8859-1?Q?gQU7dhT1Z5VmfXQPxk2zMHstrRBto0yLKPrfh55ZfQuKee9RqaipvrjIFN?=
 =?iso-8859-1?Q?5SARg0WEY5YjpVOEPtKkw+R5KuVuSRdLRH++YYMrEP25H0bymPJTClXD2U?=
 =?iso-8859-1?Q?FivPBUoYLAmYGTknqHvEUmTJxQqqX6+2QwqlQMWZwWUiB9a8QUypShU29P?=
 =?iso-8859-1?Q?KBN8iD+1OQ8jY9LRFOZeRCiHd6xAUUIYhOXnezgeqo4Wf5L3B5HVmm0SBV?=
 =?iso-8859-1?Q?pXqwxyHlT+BApnkWuoX60FcUPBwvgVjYBNSFLQY853n3PlX4wNbUV1IfIY?=
 =?iso-8859-1?Q?wUbEALjvj7oTGw0Mp/r/koxeUimTFqu5blGC1g1967gT3/uWvaM4cAYNDv?=
 =?iso-8859-1?Q?sclRKElKkqOZ4YqMMItyQAanhlhWR7Xef15zFXinNgHS2jemmXv1UIU2Ma?=
 =?iso-8859-1?Q?WScNmyCrOsp4Oc69eGUlWFPnWLNdNmBfIOIt9ubMzHyLc/ELRSFzhO0n7Y?=
 =?iso-8859-1?Q?5ogNvyXTILSNi54sY7uJJXFl48qE2r2nWv8wpehlwMMxy4mzAE4rEQy3l8?=
 =?iso-8859-1?Q?959S7q7eg9cQVI+FpwmRsl0JBGBXWqCImiLS91jMdu7YICOuHefV8Ki7vg?=
 =?iso-8859-1?Q?xOr9Udf0ZmJx5i4z/6AaWAP7aiVv8BnEwnCLM0undO5LNS6SPrwGhiTqXY?=
 =?iso-8859-1?Q?JN6ZeSsrUR1t43Kpt/kbxpgINuKCSkY8HDrSBrhjBgyQjvtKhQVHVWCnJ/?=
 =?iso-8859-1?Q?35lBKHJpfJmtJSC9eIV6dWaq2/8poHeikrjGxKpG8qRGK41fHO4Op+33YR?=
 =?iso-8859-1?Q?tP12LQya3WEUYoGbg7oiIULS/9JoJ2gUfhwrpaiblYGdbcve3/CIYGCoLN?=
 =?iso-8859-1?Q?U3Bx9/achEMSi5N6jIgtw/k3C4VaFuEqnkmFXyvVuRXHy80g3VdEeNvqWb?=
 =?iso-8859-1?Q?T5LKWjsLLJsyok9rIZ8XQeXz8s+FNput5P7PwYqNJMobzxU54pixuTkvL/?=
 =?iso-8859-1?Q?Cxev1E1u0no+BfiI7dsdDL/999ZmrDxqcHTozUPcC3fQCBk/WbjdDXL6la?=
 =?iso-8859-1?Q?y2nyDWwHDYiXZP0Kt6Uo3lVlr9MEd82fo3tLG7YUjEOpice8qlmDwvCvqV?=
 =?iso-8859-1?Q?rw9xl33qQvzSodSs3n1zoMkTIYyw9lMWUdCEeIzD30vqrNeuJcVz/8S2H4?=
 =?iso-8859-1?Q?ilaVoWqbyBw5DU4g5EY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba3a6b9-45f1-4490-70cb-08ddafbf4103
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 05:56:52.0633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdN98tmRv9b2Pfc2TrkP9hvom6jjtQSWnwti1eFbshqTnnyTfqqiVGz3LTlPNZmig1WTRZHVnwXny/L/zsSOs3Vp4uDwmDpEmT7Mtt3w8Qgq6sxL1MGnd+qUSjYVHCVy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9853
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This will be necessary for devices implementing ATS.
We also define a new macro IOMMU_ACCESS_FLAG_FULL in addition to
IOMMU_ACCESS_FLAG to support more access flags.
IOMMU_ACCESS_FLAG is kept for convenience and backward compatibility.

Here are the flags added (defined by the PCIe 5 specification) :
    - Execute Requested
    - Privileged Mode Requested
    - Global
    - Untranslated Only

IOMMU_ACCESS_FLAG sets the additional flags to 0

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/system/memory.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0848690ea4..5c4cbe838a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -109,15 +109,34 @@ struct MemoryRegionSection {
=20
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
=20
-/* See address_space_translate: bit 0 is read, bit 1 is write.  */
+/*
+ * See address_space_translate:
+ *      - bit 0 : read
+ *      - bit 1 : write
+ *      - bit 2 : exec
+ *      - bit 3 : priv
+ *      - bit 4 : global
+ *      - bit 5 : untranslated only
+ */
 typedef enum {
     IOMMU_NONE =3D 0,
     IOMMU_RO   =3D 1,
     IOMMU_WO   =3D 2,
     IOMMU_RW   =3D 3,
+    IOMMU_EXEC =3D 4,
+    IOMMU_PRIV =3D 8,
+    IOMMU_GLOBAL =3D 16,
+    IOMMU_UNTRANSLATED_ONLY =3D 32,
 } IOMMUAccessFlags;
=20
-#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : =
0))
+#define IOMMU_ACCESS_FLAG(r, w)     (((r) ? IOMMU_RO : 0) | \
+                                    ((w) ? IOMMU_WO : 0))
+#define IOMMU_ACCESS_FLAG_FULL(r, w, x, p, g, uo) \
+                                    (IOMMU_ACCESS_FLAG(r, w) | \
+                                    ((x) ? IOMMU_EXEC : 0) | \
+                                    ((p) ? IOMMU_PRIV : 0) | \
+                                    ((g) ? IOMMU_GLOBAL : 0) | \
+                                    ((uo) ? IOMMU_UNTRANSLATED_ONLY : 0))
=20
 struct IOMMUTLBEntry {
     AddressSpace    *target_as;
--=20
2.49.0

