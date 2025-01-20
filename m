Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D9AC02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmd-0004eR-7P; Mon, 20 Jan 2025 12:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmX-0004Wu-Kd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:51 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmT-0000Yv-Na
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394906; x=1768930906;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QjevDev5eUjw/Y9whaZdJdOcVV49XsTnrI6bYczFujc=;
 b=uEEZVyJ8RD0tft1Wdw7tvVpCFKE5+u9Rxy7t3vPk3qMiSCFBt4XxyZcQ
 fdGJdh69HH5djQWWBN6mO9KiiAKhXgvD7MKDyCaAycuAZT9mQUqqKgfMs
 pmMYuY/OdskxXwHM2zlafI3fNncCYR5gmn+kwQ7nPcVtAxwSchJGF6OEj
 EKxSFHvKJO4k9/SzH8jQC85SQB8CdwvyaBpzQRs3xujodkRnp06LqTsv1
 rrBOD+oAMczqbSMy/LzNTrsLa9OJkjfuKubDlS9H23pbQoShevzz4niZR
 9gNRAi1rsBh+e9N+gVNhRHPr84KQ6+InKYL/dwf5tK47Mkv4YO3m4PYk1 A==;
X-CSE-ConnectionGUID: 3WduwJNfSP+kKivNdEI9dw==
X-CSE-MsgGUID: eXMk+PatRpGzdScCjX2iYg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291718"
X-MGA-submission: =?us-ascii?q?MDG/6lSJ2nWNtSvvvMbTYkjUCjJuxxLnbWBUlu?=
 =?us-ascii?q?dkX/wQz4ZAsxYNfW6gGYVkpaELUBxiwEXuhqDsxqD97GjOq1YL9VC2BZ?=
 =?us-ascii?q?8dYy4CGBjfftpVVGPzamJooFvJfC0RyvemSrEGof45VE3g17XH+yN2rU?=
 =?us-ascii?q?KGmgC7YpOo7U04d4+qA+E2tg=3D=3D?=
Received: from mail-db8eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.109])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuaN0LgXMsD4CS98xsJfFqP4h/QJxMiOJLa6ozhilUkJk+IMh3b6IxBGBE95hKu0Q41U2E4N5WuDSjUwux93EyRmh3jECPAk0UeNohwoK8foShSvMd73iBoojLpEy5UQhGA4NGzisTFSEWsmfrsyXY7PLhmWlRJjxy+D+zEopaIlERZu6jR1RP5xsqmxm66rKRXtAFmscL0ZBMJ8/ynUu8GRi0GCY+enlzroMqcPL0dAZNIwY2SBejffn+rp4FNlelr7V4XR2lKyolvDfNeRVKkOpUrnQkigi4IURflxA12wyJspR+mEqe4ePUC6seL7E9jBbPxWOW1PaH8c9LBI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b63JwT/W3QFF2AdBMAfGy1CbHlCNQp2Hc5PSBtMwLlU=;
 b=KaUx2u4djsTL5rIu8IR72nXGE9tSw27J+nyPNNma3/8Jir8hGjab+1YdDV2jTM1DWP6fOj7OgpI4k7ij5a6VX/mRHElzKlri84pc8UuXS0cennjIskvdqPza1oZWFpRn0zwKiLXq4YjqqKS+HdjEKbkhIc8ekmVKPWMMczgXCSLRzk+a4jnpAse0rKtMC4EY3KHhZOiR/fhSD1SDis9e2wotSEl4UEWNnAL8ibzaMghVSwPCYgBS6c5h7zvvdfJDXFJHw/u8gitx6zm6Z6UsEyS6fmv1iBU8kqUaKXGCosfnwAY4dxBolrvhaly/vjmtm5lxls2sSHOwAXCWMRA1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b63JwT/W3QFF2AdBMAfGy1CbHlCNQp2Hc5PSBtMwLlU=;
 b=O5bWQ4dQ5yEdOaoqUf96t0hyhaBB9rWCADwe2pmGRrtliySdAdljJxerSoeq6GYdjGlsvwIJfutxtHX3qp/+7M9YNlYZ22Ubmx3uq7Go0WDSF6gRPgpLArckgOMGoiTXIITdHBM4OUOvQog7KPYJQFCqKM8a0idyw9fA1SCFUF3aK5wI2qhsO8enM3f2G92/29JP70BoRIW+dL0JJj6lsmd8Myy4DAXyOWE3kgBWJ+wSRGVDy8iCPd4UhPmW5sPNvw38BlaSyEH/RI3/5EIKyuJhUVq3iYcIni0G42Dg4ood4v42lX4aTRicavt6xkqtTBIwBeoLo3h5lbS/FpVUbQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 04/19] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Thread-Topic: [PATCH v2 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Index: AQHba2KRHmsbEDO7vkC0f7S4oxcf8w==
Date: Mon, 20 Jan 2025 17:41:42 +0000
Message-ID: <20250120174033.308518-5-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: b4fecd6d-caa5-4fe5-0c90-08dd3979b3c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RrtJGn5CO09ADkbO06oTjsMkXpit4IrzYun07TDmr+BAlXGluiflnd0e/1?=
 =?iso-8859-1?Q?6vmYAHLD8BC/FyMQqlojsLK6glWS/aqWnkF43s6uT+PLkqfgbbLbo4nsLo?=
 =?iso-8859-1?Q?zaqWbQzk9WIPgr8QFoDW6WZ/yvikW5Bef9qVRGhPIuo1xsEM3rzCoOkQl9?=
 =?iso-8859-1?Q?K1pWdjp4LcgH4qnoROUC4rDHC49qXszD0+wXz1oz3+5nKLvxdweYKBjaYQ?=
 =?iso-8859-1?Q?9gIzqgUxC1fVyBN80MlYAFwsnRnoIyk0oxKTjbXC/FQk3pvD8AYlCfKe2e?=
 =?iso-8859-1?Q?F+BnaX6MkaL9UwQRYe9fOfGl2RzxE66PpfVLaAUBFkqL/VlviuanbzY4s+?=
 =?iso-8859-1?Q?GycBfhs6wNoEb4bQ08BDh1shmGJEbNWFwn4TEZ/Z8IUVklkmgZSn7AycEV?=
 =?iso-8859-1?Q?GdgsmGcbYbICGHE+Vi5u4+xsS28OwXKdCiEeb1wlHhnwrsWQAiQTndZRT2?=
 =?iso-8859-1?Q?SpMSzAGJUh9r1JCsfSVxXHLWxLOAfRfVza5xR1otm5XkV6pVwAIu5FDjyH?=
 =?iso-8859-1?Q?NbKFWZyIK+0lxhzsemFXCdDEdTJ0ZRMpx/md1oFd3n0X9uoeHm8ZvFQgH5?=
 =?iso-8859-1?Q?x5JsDNdJRbwi5kvIYOKnf8MNucA31iFY1u/1T+ry1+qkqyYk+dmkMtQOiQ?=
 =?iso-8859-1?Q?J1ctXKAtgLn+1HJpH6pIwUxa7/ENG3YzGjUKiQZM4OI9pHg0GHMAKaWhkZ?=
 =?iso-8859-1?Q?KGJoNClx68Cc1J8MRT3PfrPMESOrNcCgJBYW2t2/yR4Bh85N/8ITgOXj6D?=
 =?iso-8859-1?Q?CHQ8wSs6RCXxan7EtRJgQ5RbmvFrk7/q5L/G4FLVv2xy5w6ZZXYW7rp+1R?=
 =?iso-8859-1?Q?TMNycrXTtfPWeX0ylzULui3EynFDdbXFeMcf2YAYBsiYwldbpnuZ28SSjS?=
 =?iso-8859-1?Q?wF9LOjOygOYiJH15geZYdGovzWwoNvsfmAnJh7Si20IyPUXXvttVnDx2hC?=
 =?iso-8859-1?Q?IOUAU7/hNo0Xj4PjTCd3H32fwju8eetcYq+a038hOUPvNbbLXn6qHveoQV?=
 =?iso-8859-1?Q?Yk3HfZ+97pAKN7oIKhw1cKCEW2jeQSVkU5tka+yiVEAmEQ63nb8xOoB8km?=
 =?iso-8859-1?Q?YmHwMaou5SXaw7l0AB3TFmW7OnMXS959AkZ917iXYvKy1SCx1CPgIVHNGg?=
 =?iso-8859-1?Q?KZXkVEl/ZwlnObp6JKuxJvIOlCHXqNAqBLCrurTPHTtnNmK7l6eJiUAQU+?=
 =?iso-8859-1?Q?OTp+od6/Uh+eVFamAxydPODpemc4FtVxNFxPPdKuk+jy1t/M0SLZz3Ekqp?=
 =?iso-8859-1?Q?BA481Ea24ehT68h+aM9eq/UCkltDXAOYWumm5UtQ+ofywUWmyRkQayouEh?=
 =?iso-8859-1?Q?aitzwLDm8DBFrrWV0jn/cbCYojBnUGjKcwnI6wpJAhu1V4Q5dDb+T1gR8J?=
 =?iso-8859-1?Q?sgMw29ITMaVQxEGz6imoq5fv51Kw+/HV7vvtQDAFlRniUq64hH4mjH6m+o?=
 =?iso-8859-1?Q?KB6ngCBohbbGZABzMGWjAfe5ybtnLTzmjgMsOcma1Pi5tWmBCwck7+zlOs?=
 =?iso-8859-1?Q?+2mPQeJry0DbUnvEQP1erH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T3bQvEspttPUiBx4yBQa+nf1CN2FX2zhTbffC3XEFIl0wmv30mxYg2rEJD?=
 =?iso-8859-1?Q?i6TVjkHHv0W/5Vg61vOaCeoGMpkVYUyyphDxUDuPXiE2Fkz8zp33qMNSiR?=
 =?iso-8859-1?Q?XGKzglHnOxVO+2t1M92wFgo+9YXkVMVhbEfIvnr9ccgj85rqMLA2wtx1F/?=
 =?iso-8859-1?Q?fF/23Z/gZ8bmYFH4FdDh/ltnHiWnAsXpHjAvaD5QWkPCD6WzrmHqbJx/a5?=
 =?iso-8859-1?Q?SrrrpICiOKHZO+NNNpXB912TQgMDXz5rfOXMfDSAt7Mq2llTl8r9tIGh6L?=
 =?iso-8859-1?Q?kasWCDBIEZqzZ90Z7mJ8dCFAhPLjXl6m1Kyv9xv/xjcu7URolRqX6z0PrK?=
 =?iso-8859-1?Q?PMbcTmpVD3F/XiVrQ6Xi3w0RSedQCpB1xz0Lgy/hUmGkTRdv+dSbRERE7r?=
 =?iso-8859-1?Q?kq0VgYd8JBQfqgqnozZAPfdsjeoEtYn0uJ0coK76+Trudhp3Iiezh6mpcO?=
 =?iso-8859-1?Q?ingVnDI1x3tTJfKQjpnW6bKrjaPyGLIzknbgfTaZCh5NALFa7iSDMvhB60?=
 =?iso-8859-1?Q?aLuBoJvg5YKUE7boXDKTK9+AdXGuBM7Ll/3nilwDFvo2Ek99CSgyKjmTfw?=
 =?iso-8859-1?Q?hQZEvSxNYNohjwy9MPDY8VlVKrzupFiR8NMTJBZVLbnjNUaTMeGijrubUm?=
 =?iso-8859-1?Q?32V2dqmeBuiGshebDZkNgyKErDuy/w//oFI/prmu3+W641BiAJjIyUdfNX?=
 =?iso-8859-1?Q?Avus4wy++BQocCySGaLAqM7LAlL1SAhJJjLQO0Lk84hu/9edbabCwqx+ov?=
 =?iso-8859-1?Q?RI16nEl1XUNk/CS2t9ad915VXuq1mkGm6NCXMdZ+cc2ixZzPG/7K/9qZ2t?=
 =?iso-8859-1?Q?c0etUCSECqzqmWrW/V3UHnUW43T9p+pj7q+eh4w1pu1AXPtlptSikePm1H?=
 =?iso-8859-1?Q?bryjIm/87dv+TARIA0E2kO25/syHgjUXegSRvA9M7qDh3Mwso4iEHG0sKO?=
 =?iso-8859-1?Q?INrkAcoKzXHdeuOv9jFeKiS+8m+yJ+TiUK97fsflbZPKocpO2EVSvG8Tji?=
 =?iso-8859-1?Q?UuGCZ63/TgD/qCo5G+j8Q9ecsF/MeVaJvchtCUydLaCDYgVkyr6E3NDwrF?=
 =?iso-8859-1?Q?JsxffrVjTvmcBzF1/GYUPejwpnKIbJjktlSPXMys7Sugqsxk1xxPeW3o00?=
 =?iso-8859-1?Q?RUhnVCGVsNd262T8yiRfdQXfxXkhBjyrJ7PAUByC41sMD1XtC8qGB+eMwW?=
 =?iso-8859-1?Q?FigZjRsDspbxhU7OPIq4LT871rysiWk0fqXJguw5Ik/D8iZSHZvKZ0GU9I?=
 =?iso-8859-1?Q?61ylF6aIRi/N/Qxz5QWn0afc5rO9X+iInNO8tvN3WolFMEY5ZB02nvvgKs?=
 =?iso-8859-1?Q?H1m/m6n4F4p7mdbWDmxgkXCh5M3Ntlo2baRmq+WtUUuc8leXKi7RgSKA3+?=
 =?iso-8859-1?Q?A2GFrkEN6o9M15puL0pfuvjhMjqq6sf0DaInhF29SkQy5+gOB/hvQg+nJv?=
 =?iso-8859-1?Q?oz+HnEv+kvf9U+fHVt3eaesJKu86WKMJP8HY+yQ+GRuXLhWfluC/B1nmyI?=
 =?iso-8859-1?Q?Wcl0tPCGRkmp9Hn+cQPr6kSAADMMAv5rYuKoaU/nVlJbgrbET+tB92E1sf?=
 =?iso-8859-1?Q?exBV8GoVVvutWsIM2O8CNXefpMpzSNfjIVbZma1L8rG2+194yRo9n9LLhg?=
 =?iso-8859-1?Q?KG+aIKRPZbvrjU6f4KVFFkE99hEC8JkXlj50k+opqwM6aUAodsgZBM2jyB?=
 =?iso-8859-1?Q?0LdMCVrqKkN9rZQG8Ac=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fecd6d-caa5-4fe5-0c90-08dd3979b3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:42.5570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+L6aVUc4wM1aLI34lXfkC2LUAejSdjEwGi75xpStfKtZXjVL23ECCITOJuqdSbDbdPfmEsjDiMhSSQ+ouDjiQccJmD1ND04fFsFOOXrcsVw9D56T5zsXQLhXPPo/W3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

PASID value must be used by devices as a key (or part of a key)
when populating their ATC with the IOTLB entries returned by the IOMMU.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1d5ff8f4f6..c58e18a56c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2511,6 +2511,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOM=
MUState *s,
                         .translated_addr =3D 0,
                         .addr_mask =3D size - 1,
                         .perm =3D IOMMU_NONE,
+                        .pasid =3D vtd_as->pasid,
                     },
                 };
                 memory_region_notify_iommu(&vtd_as->iommu, 0, event);
@@ -3098,6 +3099,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace =
*vtd_dev_as,
     event.entry.iova =3D addr;
     event.entry.perm =3D IOMMU_NONE;
     event.entry.translated_addr =3D 0;
+    event.entry.pasid =3D vtd_dev_as->pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
=20
@@ -3680,6 +3682,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryR=
egion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb =3D {
         /* We'll fill in the rest later. */
         .target_as =3D &address_space_memory,
+        .pasid =3D vtd_as->pasid,
     };
     bool success;
=20
--=20
2.47.1

