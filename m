Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466D4C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXq-00054w-Nb; Thu, 27 Feb 2025 05:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXm-000516-N0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:06 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXj-0005oQ-Gv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653703; x=1772189703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oA3KYmbSWy/K+XMLDvDgQtpvoImsgYm3m1tPp4EH2n0=;
 b=Nnwkfzg4UGYs4Ih7auP8UiSoKShb5FgEBT0kRAmMyCd6Kmoh66JZbeo/
 NFYXEQh2b+1ayIIYwwBxPUGqzsb0Kj9wAW1bwhDzSupqWB53cXz3JH2Rc
 dKt/f75ohXkJFL0COifeg8ub/kL267b/Kxdzwz/53h6y2mnS7oBnHI8Iv
 ao048MTCYciANH3qx9xEzbv4gXB5a8ayHImsKe80VioRNFcEN1W1VyOC9
 HIzuOJQ5iMqpnpEDtbfNnRg/fEL7HhVF+udhiSbkC0NQaLwt1exggzCLQ
 Ymd8WH2le5UJOdIbIsO2sp6/OLeb+UNSZcz4sxzdSP6RuvtuDr8amhERA Q==;
X-CSE-ConnectionGUID: WLwAKLMqQa+AXxXvmFJ5Kw==
X-CSE-MsgGUID: BhZ3qGjJRa6pghaOULGrAg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331852"
X-MGA-submission: =?us-ascii?q?MDFdPtEXHFb66mmsNMUjBE1/scu8kv3sH408Ks?=
 =?us-ascii?q?FH/XDGmitWl+YnNhFwdY3tBfH5UWIMwa57uvKlu+Bv8BuLuhmeN7Yu7a?=
 =?us-ascii?q?ZQdQXdsljSEkhC0dTOuYnVPSWuTM1fvqIcRzVZGEqNLNjxh7M+J6gEIo?=
 =?us-ascii?q?tTaOjPESMDCjXOsxQ/sZ7SHw=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:49 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnEUnKqar/rt/165/X/HoTzzNECVtFM65K2WyWFYdZaUY1VYLCDxdw2zgv8BJ2V1TDwcRx7+XwJgXy2opl184zb/Be0+njIBl2HQnfQeQs4SD3t9jZ0x1Ue2ubW+L+HsqXmc4NulGBw6vyWuAbYef1lA0rQmZNDQ7ywdKMKLW+cQ9slYrW9gBrR9Xv2phKCIdYTw2NkhqNlGDGzXWKVXU24gmONoVv4cY1uCkLxtf59hgi07MNuH/ee9JuThruPA6LRRFpqiBH0qR8JLPodeTim5xg8wvu5BPuUA8slKuL/tRZ0UZC38RlfRBaJw3C7inYSZzFW3KSLXBDaRMDByPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/agh/ytGu+2jrSulAJnbz0Adp579Lwlc/FfbJbH4Qww=;
 b=ccsgFXXenY+DgibOApV6ddkQ6VhPHigxUupqPlD830ZXi4rkCcjMpugMON0YKs7vd6zG3QdskuSUQUjFV8CbaDr5EWg4VVa5qISkoW7+/GtzmqUMvOkj3jcoT72wuu0mK1Hxm+Tu6ndN7JpQ0djNkWBUDOOZcrkWXlx3HF5yiR1KYTqfZoX3Cq/wb2D3Vwl8rZ9t28SKgsZC8PJBGyJgUf8DOcIo0p9GyAtVSFiDtR87UMlqZXZ4+O6p2KR2e70huig4Qkiycu2g1c2ahMEKgP1S7FurggZ5ptKg8Xhg9Ux39slMbRk2P6sjk6KnpuuFELWbsgGQEafdKQqN7hEhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/agh/ytGu+2jrSulAJnbz0Adp579Lwlc/FfbJbH4Qww=;
 b=Sj+AEwog4fsxip2oOV/zRB/Pp9IOwfW2tVb9qxiCwxwkEbyTR9vgH+dptmld+4GhJdRC4NE7b+6AV08+vwlL6vtYdduWJL962mqALqgwzvuQhKWMNTToiP82DPZi9+8inQwkRWGM169FIrOydE7J35Uhr/kyHriWC0hkJYxeWs0o//17IAql2wxKiIQTOhl6+cEn9ScLnQ9RBgvPPnnv31v/aNvhrCxjx62JlB10xNAdGNxL4ZupG6W+zsrIHJuoMz0VUcOa5NU3McY0yfu+JrsgXmIj27bwcf80JJyu5XvJOYxl7TE5n9A8atZ+O/wf+AhT4/gMuuUBZ5x5tmLE9A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 14/19] atc: Add unit tests
Thread-Topic: [PATCH v4 14/19] atc: Add unit tests
Thread-Index: AQHbiQYEzW3T+ip9y06dN7PkBU3udQ==
Date: Thu, 27 Feb 2025 10:54:47 +0000
Message-ID: <20250227105339.388598-15-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: c023d0d1-cd4f-47be-ba6a-08dd571d26db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7U4LyySH5rznrmXjAnIoxTri/U7RxNtGkgBHNkgck/pknGxpswFGGxb5gC?=
 =?iso-8859-1?Q?kd2xSCNCbFaqtfGXHsVN58NlRHTtpo19pqU19sM8wrT+mcdnW5/HQ+zsxT?=
 =?iso-8859-1?Q?JJWYBysFftBURp+WdfyAUg4WGEKNar+acVxyDjJXaVT6VAyKSiV3svuRQj?=
 =?iso-8859-1?Q?3MUXYMxo/lQg2oj+ey4eTbvNNn8hA2sJAj6X9FQeb3vtC93wjLowWYfZvg?=
 =?iso-8859-1?Q?5ILwRQJzDKR1Rm6H/6fieU5NBb7qSvlhuBL3v/Fj3uF2L0UpRMj9fRzObW?=
 =?iso-8859-1?Q?nVUjhEoBqgwYy4d2J4EVydv2YbSnfuvBh9gRM11EuLDaCpLMwbHB/PE2af?=
 =?iso-8859-1?Q?R2xFws0FQ59T0EqUfKQEYt+LmFnPnYb/WPedDvux02B45annyA7XZ662ih?=
 =?iso-8859-1?Q?nMxZa7Hc9SQTW97eBiVJFZXjD3jMpXNVchwKeHGbxrbRKEtPKHjNJiLPdo?=
 =?iso-8859-1?Q?r2FBagvuUgmD3NbqUImSlYpQB9zWJH/zLBnQuYun7IGewsRxmHUoFg8/7S?=
 =?iso-8859-1?Q?+xMaqGtRwaQcSWiuE+LgwxgD4jFMx0ZnNl1MQqioWn8NuHBsg/qC944uWq?=
 =?iso-8859-1?Q?c96YOtXqtNdwmAtXhf5pywbsKjV3dKpR8UkRZz60KMnjufmCARgEfFtvil?=
 =?iso-8859-1?Q?vF/chTidh5BRMlDAFOLnaiv37nCuEJSEzXr7MPjwHXLbl3ppudNblOGuob?=
 =?iso-8859-1?Q?a8UTtXlKNdXF75vS8xLkR29BYnJhRMgx9I9KNnSI9VTsRsjcNlDDG3m2q5?=
 =?iso-8859-1?Q?zvwYDcOy/TS1AWOzo9Lr0FYxYO9ZGxJ9YN7KuxzE/66oe5dE09/6Erweom?=
 =?iso-8859-1?Q?oc7k03xrPOUVH10kmR82GhvLjCfnIS/vXJyokk3eiFTYbGjWRzNLkkmqHV?=
 =?iso-8859-1?Q?EFT3O9XnDC8ZY/M+lCeY1FhZAgxRiyjIwEoe/wHF8THVReGO2Yd2C6/ItO?=
 =?iso-8859-1?Q?lpUg6vDrzdb8X/sQwTyrsE7+Ls4Q0k29MD+k9PNd3xX56Vpy1NTyuBBtmY?=
 =?iso-8859-1?Q?l6g2Uz6WzDevpmnk3kD7DwUyW8wfW+6T+Ure0fFR044WlnDA/x1ZIce5m9?=
 =?iso-8859-1?Q?p6t2OtyUa5tDOUv+A2baKl/wRlO3RjrwBrKG5oCkYKuA3mDPE11QWUJTCj?=
 =?iso-8859-1?Q?lMPoIbTiZWzi0iUrik8X20n+m1uMFnFecbQsRdsunM2dpDEyguU4Ktq8M3?=
 =?iso-8859-1?Q?PswUsw04hnAqDHj1Sj7ssBuOD7B1f/uQLx/YM8N27DSRqUuxCFtfqLJZ4J?=
 =?iso-8859-1?Q?3XWr/z3GF4XLg0f3FSXPG1V76Iyx6+CYk7v7PaV0QtS2xzDKV4aGmsESWg?=
 =?iso-8859-1?Q?rXIH4lfgXGHwmlNjkoeb1+La7wMdmUE3tJSuvTg9bvw9zasij2turlN2aM?=
 =?iso-8859-1?Q?xMlLYNuhzp8B9T/miWeC5ytg6rEotrJv+5HtQV+J61HQtWIb4cD0TNV5+X?=
 =?iso-8859-1?Q?DWzsP6QC3VxDe2D5dMeTb3ObTtmdRBmp5y8BvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D/GKQiI1zsiKiVikQLG2p5v2NwihCive9C0CUJNUYAw/5Pem/ozPt5U7fB?=
 =?iso-8859-1?Q?SMmu2SA/3cz5IzKSzP+hEDrpXBS6AVTaNdSpER8eULS9E849M5UWFmXJW2?=
 =?iso-8859-1?Q?Tm1rhL8Y4Ey9FUdGFf6IGUc99V5/4hd+cjIwjdhCp9jbeXXV7+JJmlkbnr?=
 =?iso-8859-1?Q?FE91dOWTztLmTmB0U73Dr0/pjRPuJtQ/eH0fIXqHBUztHQqXsqqOGuYmwP?=
 =?iso-8859-1?Q?xwAPFpovG8wbll5SBoFJSZM97K8dPhQXbmsKKgXGQMw5hQQqmBIlbHFKfJ?=
 =?iso-8859-1?Q?V1n01jaNqRz170UYipJSnnis7nBSeGTVi2lINeFBqkkX9vP/8x7dp583E6?=
 =?iso-8859-1?Q?qaM4epm/7gLU+RVYL2js7uIzGhIvapQUH28Mb9ICehIT5xXtjRE40fsetC?=
 =?iso-8859-1?Q?SQhOiu9DHqshjcX3CptjngYWE3cOxPDR+tvaeAG4aNKc26x8xkqpL0xH8w?=
 =?iso-8859-1?Q?IQR5G+uxYXC7e+C4919R2zs3VoSLiFWH05rEqTmED6k0N2KRMz/3r8uV1J?=
 =?iso-8859-1?Q?92pGiIuEmgoKfOrqSxPC9dTtQq0TAxqALPOwuNaXJ5wfCJEij5ZYcqi+T9?=
 =?iso-8859-1?Q?/opeMxsGCK3/HX48tG5+BQ1U/doZ3AziFLL/7Y1Bm/0wh3EjIMnxRQLeWn?=
 =?iso-8859-1?Q?uPsHO7gzXxHXuMQi1O4PUBaP82D300nsM32MfvagiekaKj156Svsijw1k2?=
 =?iso-8859-1?Q?+CNap5TaRNWldf3mLbg6qs0Tf8oUfVX6DVBBDrIms9eMIk2MZycLIkNk6j?=
 =?iso-8859-1?Q?fYgf4uXfcZMpQjpHngqiX5/dLbtM8/hAW8DHHkqddoNh/8sDXuAxlmBtCE?=
 =?iso-8859-1?Q?6XPBBXZg8f1eQiN3++Gen/Fe8xHwUCu+TgJ8J4OsVdcpHkrWDKPWuY6clk?=
 =?iso-8859-1?Q?jX87RYqFlyFLVIGadBclVRlMkyddmZsRITyq5by3NykMoJYMCnq0kvwrBY?=
 =?iso-8859-1?Q?qZ64AcqKBaR0Z8G9hXY8LUjWllmrhMuacoOSZ15lL+SsjqwGZWL/F8OU20?=
 =?iso-8859-1?Q?Dg/DsQB084OFlBtf22936mUBItVuu24PDG5oNss4q3N8GDf5e/qr1g5K+f?=
 =?iso-8859-1?Q?A9cBVJk93Rvx80tIydemf3lzLL3pYMjmYQRB7x3y0Bn4Hcw40RUaoWE2J4?=
 =?iso-8859-1?Q?M3g81CNF8apU1r1im+/qAxsfFq0gdaw/JKbZ7BULDtuszYsRgXyAB9OUfc?=
 =?iso-8859-1?Q?CePVLSsyr0vcc2rfnugfChPZR566MUQDuEMiDnqVTw0SKXWZFmk0fK1BkU?=
 =?iso-8859-1?Q?+vR222tue6fCj/60V4MMHYEPzMOTKqCYeotOyeF7KMgsT1Hiv1rAeRVb3I?=
 =?iso-8859-1?Q?y/P+C+gisSQKJFNOyxTOxsFp2WRnoYnDsIWxelVTvopTOg3S7usWFmLezY?=
 =?iso-8859-1?Q?nmKkMDUy/kLQMbmxuikN0tyThHnPL2928ti/E4TZocaNQPn0+Xck2UL0+s?=
 =?iso-8859-1?Q?ua6mR35/7tDb+C0ee7KZ6EmE4JtwMvHMkVUexUEyn6uS3ARTBchIr4dOJe?=
 =?iso-8859-1?Q?QU2cBlHz8jbNuXI6t53wrQihts5udR97WHCeNJN6+9h0Z6OtvXGkZ/3ah+?=
 =?iso-8859-1?Q?aWPeIZJWWvqvWxKBX1GWOyP2yRkEsuVTUpwH8eAKTsBPJgr47qZjsoLvps?=
 =?iso-8859-1?Q?uzzQK2KJGvhLy2L7/qL7+9q820EqeM5rw8WOJQetJ2lY5mPQ478ZLc55ws?=
 =?iso-8859-1?Q?ngVSfjcCmGZ9eirjGHU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c023d0d1-cd4f-47be-ba6a-08dd571d26db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:47.3516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvvXnRWALPwCwfHH0t7/Oy6bGBjI8Af4O/soC2TXT9K1xgEFdiimg172tFCxQanruj5rToULhwpzyPlxhp7rcVjYWiCv1YrG5CEIRqW5rfzRTIl/iqTnR6Ahp2XqXBeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 tests/unit/meson.build |   1 +
 tests/unit/test-atc.c  | 527 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 528 insertions(+)
 create mode 100644 tests/unit/test-atc.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..810197d5e1 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -48,6 +48,7 @@ tests =3D {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-fifo': [],
+  'test-atc': [],
 }
=20
 if have_system or have_tools
diff --git a/tests/unit/test-atc.c b/tests/unit/test-atc.c
new file mode 100644
index 0000000000..0d1c1b7ca7
--- /dev/null
+++ b/tests/unit/test-atc.c
@@ -0,0 +1,527 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "util/atc.h"
+
+static inline bool tlb_entry_equal(IOMMUTLBEntry *e1, IOMMUTLBEntry *e2)
+{
+    if (!e1 || !e2) {
+        return !e1 && !e2;
+    }
+    return e1->iova =3D=3D e2->iova &&
+            e1->addr_mask =3D=3D e2->addr_mask &&
+            e1->pasid =3D=3D e2->pasid &&
+            e1->perm =3D=3D e2->perm &&
+            e1->target_as =3D=3D e2->target_as &&
+            e1->translated_addr =3D=3D e2->translated_addr;
+}
+
+static void assert_lookup_equals(ATC *atc, IOMMUTLBEntry *target,
+                                 uint32_t pasid, hwaddr iova)
+{
+    IOMMUTLBEntry *result;
+    result =3D atc_lookup(atc, pasid, iova);
+    g_assert(tlb_entry_equal(result, target));
+}
+
+static void check_creation(uint64_t page_size, uint8_t address_width,
+                           uint8_t levels, uint8_t level_offset,
+                           bool should_work) {
+    ATC *atc =3D atc_new(page_size, address_width);
+    if (atc) {
+        g_assert(atc->levels =3D=3D levels);
+        g_assert(atc->level_offset =3D=3D level_offset);
+
+        atc_destroy(atc);
+        g_assert(should_work);
+    } else {
+        g_assert(!should_work);
+    }
+}
+
+static void test_creation_parameters(void)
+{
+    check_creation(8, 39, 3, 9, false);
+    check_creation(4095, 39, 3, 9, false);
+    check_creation(4097, 39, 3, 9, false);
+    check_creation(8192, 48, 0, 0, false);
+
+    check_creation(4096, 38, 0, 0, false);
+    check_creation(4096, 39, 3, 9, true);
+    check_creation(4096, 40, 0, 0, false);
+    check_creation(4096, 47, 0, 0, false);
+    check_creation(4096, 48, 4, 9, true);
+    check_creation(4096, 49, 0, 0, false);
+    check_creation(4096, 56, 0, 0, false);
+    check_creation(4096, 57, 5, 9, true);
+    check_creation(4096, 58, 0, 0, false);
+
+    check_creation(16384, 35, 0, 0, false);
+    check_creation(16384, 36, 2, 11, true);
+    check_creation(16384, 37, 0, 0, false);
+    check_creation(16384, 46, 0, 0, false);
+    check_creation(16384, 47, 3, 11, true);
+    check_creation(16384, 48, 0, 0, false);
+    check_creation(16384, 57, 0, 0, false);
+    check_creation(16384, 58, 4, 11, true);
+    check_creation(16384, 59, 0, 0, false);
+}
+
+static void test_single_entry(void)
+{
+    IOMMUTLBEntry entry =3D {
+        .iova =3D 0x123456789000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 5,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 48);
+    g_assert(atc);
+
+    assert_lookup_equals(atc, NULL, entry.pasid,
+                         entry.iova + (entry.addr_mask / 2));
+
+    atc_create_address_space_cache(atc, entry.pasid);
+    g_assert(atc_update(atc, &entry) =3D=3D 0);
+
+    assert_lookup_equals(atc, NULL, entry.pasid + 1,
+                         entry.iova + (entry.addr_mask / 2));
+    assert_lookup_equals(atc, &entry, entry.pasid,
+                         entry.iova + (entry.addr_mask / 2));
+
+    atc_destroy(atc);
+}
+
+static void test_single_entry_2(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xabcdef200000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, 0xabcdef201000ULL);
+
+    atc_destroy(atc);
+}
+
+static void test_page_boundaries(void)
+{
+    static const uint32_t pasid =3D 5;
+    static const hwaddr page_size =3D 4096;
+
+    /* 2 consecutive entries */
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x123456789000ULL,
+        .addr_mask =3D page_size - 1,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D e1.iova + page_size,
+        .addr_mask =3D page_size - 1,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x900df00dULL,
+    };
+
+    ATC *atc =3D atc_new(page_size, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    /* creating the address space twice should not be a problem */
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova - 1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova + e1.addr_mask);
+    g_assert((e1.iova + e1.addr_mask + 1) =3D=3D e2.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova + e2.addr_mask);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova + e2.addr_mask + 1);
+
+    assert_lookup_equals(atc, NULL, e1.pasid + 10, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid + 10, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_huge_page(void)
+{
+    static const uint32_t pasid =3D 5;
+    static const hwaddr page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x123456600000ULL,
+        .addr_mask =3D 0x1fffffULL,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    hwaddr addr;
+
+    ATC *atc =3D atc_new(page_size, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    for (addr =3D e1.iova; addr <=3D e1.iova + e1.addr_mask; addr +=3D pag=
e_size) {
+        assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    }
+    /* addr is now out of the huge page */
+    assert_lookup_equals(atc, NULL, e1.pasid, addr);
+    atc_destroy(atc);
+}
+
+static void test_pasid(void)
+{
+    hwaddr addr =3D 0xaaaaaaaaa000ULL;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D addr,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 8,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D addr,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xb001ULL,
+    };
+    uint16_t i;
+
+    ATC *atc =3D atc_new(4096, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    for (i =3D 0; i <=3D MAX(e1.pasid, e2.pasid) + 1; ++i) {
+        if (i =3D=3D e1.pasid || i =3D=3D e2.pasid) {
+            continue;
+        }
+        assert_lookup_equals(atc, NULL, i, addr);
+    }
+    assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    atc_destroy(atc);
+}
+
+static void test_large_address(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaaaaaaaaa000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 8,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0x1f00baaaaabf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D e1.pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 57);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_bigger_page(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccdde000ULL,
+        .addr_mask =3D 0x1fffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    hwaddr i;
+
+    ATC *atc =3D atc_new(8192, 43);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    i =3D e1.iova & (~e1.addr_mask);
+    assert_lookup_equals(atc, NULL, e1.pasid, i - 1);
+    while (i <=3D e1.iova + e1.addr_mask) {
+        assert_lookup_equals(atc, &e1, e1.pasid, i);
+        ++i;
+    }
+    assert_lookup_equals(atc, NULL, e1.pasid, i);
+    atc_destroy(atc);
+}
+
+static void test_unknown_pasid(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccfff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 48);
+    g_assert(atc_update(atc, &e1) !=3D 0);
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    atc_destroy(atc);
+}
+
+static void test_invalidation(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccddf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xffe00000ULL,
+        .addr_mask =3D 0x1fffffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xb000001ULL,
+    };
+    IOMMUTLBEntry e3;
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    atc_invalidate(atc, &e1);
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+
+    /* invalidate a huge page by invalidating a small region */
+    for (hwaddr addr =3D e2.iova; addr <=3D (e2.iova + e2.addr_mask);
+         addr +=3D page_size) {
+        atc_update(atc, &e2);
+        assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+        e3 =3D (IOMMUTLBEntry){
+            .iova =3D addr,
+            .addr_mask =3D page_size - 1,
+            .pasid =3D e2.pasid,
+            .perm =3D IOMMU_RW,
+            .translated_addr =3D 0,
+        };
+        atc_invalidate(atc, &e3);
+        assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    }
+    atc_destroy(atc);
+}
+
+static void test_delete_address_space_cache(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccddf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D e1.iova,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    atc_invalidate(atc, &e2); /* unkown pasid : is a nop*/
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e1);
+    /* e1 has been removed but e2 is still there */
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_delete_address_space_cache(atc, e2.pasid);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_invalidate_entire_address_space(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x1000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xfffffffff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xbeefULL,
+    };
+    IOMMUTLBEntry e3 =3D {
+        .iova =3D 0,
+        .addr_mask =3D 0xffffffffffffffffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e3);
+    /* e1 has been removed but e2 is still there */
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+
+    atc_destroy(atc);
+}
+
+static void test_reset(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x1000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xfffffffff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xbeefULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_reset(atc);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_get_max_number_of_pages(void)
+{
+    static uint64_t page_size =3D 4096;
+    hwaddr base =3D 0xc0fee000; /* aligned */
+    ATC *atc =3D atc_new(page_size , 48);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size / 2) =3D=3D =
1);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size) =3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size + 1) =3D=3D =
2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, 1) =3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size - 10) =
=3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         page_size - 10 + 1) =3D=3D 2);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         page_size - 10 + 2) =3D=3D 2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 1) =3D=
=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 2) =3D=
=3D 2);
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 3) =3D=
=3D 2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size * 20) =
=3D=3D 21);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         (page_size * 20) + (page_size - 1=
0))
+                                          =3D=3D 21);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         (page_size * 20) +
+                                         (page_size - 10 + 1)) =3D=3D 22);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/atc/test_creation_parameters", test_creation_paramet=
ers);
+    g_test_add_func("/atc/test_single_entry", test_single_entry);
+    g_test_add_func("/atc/test_single_entry_2", test_single_entry_2);
+    g_test_add_func("/atc/test_page_boundaries", test_page_boundaries);
+    g_test_add_func("/atc/test_huge_page", test_huge_page);
+    g_test_add_func("/atc/test_pasid", test_pasid);
+    g_test_add_func("/atc/test_large_address", test_large_address);
+    g_test_add_func("/atc/test_bigger_page", test_bigger_page);
+    g_test_add_func("/atc/test_unknown_pasid", test_unknown_pasid);
+    g_test_add_func("/atc/test_invalidation", test_invalidation);
+    g_test_add_func("/atc/test_delete_address_space_cache",
+                    test_delete_address_space_cache);
+    g_test_add_func("/atc/test_invalidate_entire_address_space",
+                    test_invalidate_entire_address_space);
+    g_test_add_func("/atc/test_reset", test_reset);
+    g_test_add_func("/atc/test_get_max_number_of_pages",
+                    test_get_max_number_of_pages);
+    return g_test_run();
+}
--=20
2.48.1

