Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7089C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmo-0004zP-55; Mon, 20 Jan 2025 12:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmk-0004uV-SC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:02 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmi-0000cP-Ol
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394921; x=1768930921;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=utsA/EQVP03hwimpwCFqp0/zAZAKoMG7SGkkjc+HEe0=;
 b=BwJx7Uy+2LxpoAsHvu6514TeeWBTwPcsFy3EFcLqLNirc6WfOA7SNaTF
 Q+RNAIXdnujCpW3XPkGO9hRkvQImQTovb8nTvImq4A9lj60L7TI+qkbzZ
 5PHoxp7LCt/0EnYjkM/xNE0CUa+y1NTgF1JiiXjMafrfDvr+Dq3KyFgPE
 XGATf437OyPkUWcVAP9Ivitxp520qhiwlm7Cagp1y94mGKiYJlfyGqydd
 vdhtlhMjfWcOjMOtemjYwXRtTovnrc86g9YKp6RSySur2ch+o/5vEFhLP
 BCz1sR/yyDIplqKM1T8mCRxLSpLv8uy84HriVzUUr9kZAjSYdoR3q2Mdm w==;
X-CSE-ConnectionGUID: w6X+yHKRT4WtPDlE8ZVuzw==
X-CSE-MsgGUID: eehT+nbbSZSWWkUJZiNW1w==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291725"
X-MGA-submission: =?us-ascii?q?MDGmhSgbKL5sAAE0UseJojG6mRYDFo8OFpDe0b?=
 =?us-ascii?q?sAXrJG7YDsjLvyP1QeLDsNn43tUzmyP30qqz/WV+m8uQY5fA5Hu32zrD?=
 =?us-ascii?q?y74ha2fOQXhd2sBGYvDRseNEn1Qqwqdv8Q+mId7/Npi6xpt6MeV9HBu5?=
 =?us-ascii?q?UFMjYD+gtfQp/iNWB/UMvyCA=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:59 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHz9Dg4ft0lGIRaNU/0znUPkrhndbovlRG4FGhvHeOJ59Zl0oCbvzUKTdzM4LLYQsW2t8a80j3fN5Bi6WvZeO2b2c5ou6P5KumjBEAcv/GL4plKgiXEzgTRHDnW5qM3spjJEhXIrzizaMpYV/Y4tpYyB1MN7wN222IG1IwT7qmY6tl64etO/EyIKX4I0jSrZOLOMmNXoYOyI0qP+HrW4JHWkqz4x6ec8IMEszw+PdR+kuhgMkfkd5XgVfLEwcnn88u32jr0AYGaf1ZDTsAGYOhNuq6QjarafNuajqlwl6eguycDTyL0xw9/0A0+jgZt1TxkCV6yXVbEypewaN4tAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihlsVNHBhWzOiyKsk02pHbXIfjbbzjC7MTfT0JrY5gA=;
 b=QGSuZO7ZBCnEzsUFhAl3DT04B3tyftyDzxJywFo105TOoMV0bZDMF5RxuJfHlr5tLZStjOy7On5/zFUKHhXbVXLDnqiSZHDKpgVfI74gBo2m11HUf/OhuMUfbRvaFZBfim5I7s/p7FBlAaZihy1nF28LGNTo7rNqf/fSxuFzarjbO/umYw8bKgUE5pGWrserCIo/EiavMSj4i60UPG2mrj/wyU1xzEHcPD6zMMpdBtraRzWx/+sLXYMouOy6OMC4BIKr7xt8iiVmRkGwCcTeDwYhGDx4ULEbNhWCAjRLrDZ7Txc3LdkNqm9wExXckuFUbWtGkKLfEUEo/Ehlzg6tSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihlsVNHBhWzOiyKsk02pHbXIfjbbzjC7MTfT0JrY5gA=;
 b=sJK+yA0GUJg//9XRTDRDxXVR9FvEN8ifTynXwM8djgyg/2mdV9n/YQY8bTV1aQjV7SZiBQoF2JrovY3f4zbbbAAai3okOEZGjXX3AHe0gOOZBe6RalZttTa9hKl9OLmJ0//n6e9RFPoWOncQHMCA8IZp3Sh7zxLHb1dOLSRAjjoidprQpTlUT1dRw+05KvcAA0X3rS4N+g5hE856i1o2+qFYkHhNx2UqEVnC5hewkljXskgwTJomJqyJnVRV1pDzzS3Snrd+Tx3P8fgfGQzOGa4GhzzgRDk2U1qgszLAavrtEpacEdzCBoO/nTPkShpd5ty9PNunnwjQSb46k/zDYw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 19/19] intel_iommu: Add support for ATS
Thread-Topic: [PATCH v2 19/19] intel_iommu: Add support for ATS
Thread-Index: AQHba2Ka+y6joUjfBUuVcadc89bZlQ==
Date: Mon, 20 Jan 2025 17:41:58 +0000
Message-ID: <20250120174033.308518-20-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 6e0e3279-7344-45ee-8ec7-08dd3979bd05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?I4g3E3Rn03D5DstDWfHv/wpB8vw4jlp4z4TC5gYyRRBRCuW+6TLMKN+E7p?=
 =?iso-8859-1?Q?Gl+2LUQ4VJaxY+EOSHvLJfkbJGra6jWi5zxxWZdrkI4EOGG9BLYEe0spnJ?=
 =?iso-8859-1?Q?iOofVq8fOY+A23wD/qxID64gg/A1HELSIplF09X4LPfXgkQUyGK55FcNbi?=
 =?iso-8859-1?Q?SOs1wRwqt+37ovTnQxWnWWodGTHLI0s+jWBY01wEisXPqiMrOaO3ezeZ4T?=
 =?iso-8859-1?Q?/AnFfTHaYCDY8UG67U8iYJ7N+82ePt9Ke2ixStxmnTrj10g70E2kNSk3Bw?=
 =?iso-8859-1?Q?wf6zM9W6zWDozyvHDU2YF2yKlZvapObSS7bEECrPp/d7RgKEIVe+ePHytr?=
 =?iso-8859-1?Q?rUvnkSiapPeZ6CdndfZxgtlj7gU+wLipLvwu8C7b15lEI45LjbVVNa+SgV?=
 =?iso-8859-1?Q?ChpMbNmZtTFDka5zu+T2257BvcVnq/ePMi1qvQNrfJojLVXBsR+ZdpNd84?=
 =?iso-8859-1?Q?qRSKMINAI9Z9maI10iLPN49eqFHPaSJmS4H10UljDqQ/Rmm4uMYGRK57T4?=
 =?iso-8859-1?Q?9VjKyWxQR1k9/xaMwrcRS2vWLOAJiIhD9EOAQelx2gzOkH/VZ0M3XRRIfg?=
 =?iso-8859-1?Q?Zv5fXf5wlShn9w8oOMogbD6gvApfXO/82XaqY8f/r4LsFt1d/oPVefjPd2?=
 =?iso-8859-1?Q?m+lwc28pK0UBRhGh/voDzqspL4XVqjCeNBwTZMIuC0qpFDXKpiP50YgmpS?=
 =?iso-8859-1?Q?fmbOFheCTwbdso2dpl2klPkZImGslKbI8b8YkfTcwMd74hneMDzdmWJNuk?=
 =?iso-8859-1?Q?JRH0INBx1dI9ll9rHupMdJ+UsqtynNPR/+OjUwxQExAvUW2pU/luJ7lSdo?=
 =?iso-8859-1?Q?p5Mc3KCc5ctZv2OE37gJW8wkU9GNXqcSQcF9xi7SsLhHLERbxuaA90Fap1?=
 =?iso-8859-1?Q?tRNaLsSMRCp4mPDv4J//7J0/wqghw1/j8M3H+XKQa7b3Bg6JZujGMVNq8s?=
 =?iso-8859-1?Q?vfY2ofKjqkNR3s2jierFlisfUA0eRGwYxS+EeoxDC71l39nDoR61R696Z3?=
 =?iso-8859-1?Q?Q36OWSFts0IbHG9LFZHeWvvsAQbAhoKzCOe73dGuQCpbUQqoRr4wGhIduF?=
 =?iso-8859-1?Q?N9rmuSEFKvh2xjSRDhWxaW6Ts+4Z3uPP8fs+dDmc+lzZw31BhV9B0sWaU3?=
 =?iso-8859-1?Q?MQrnMWpcoHmbNkSw2SL0F/DyO5vZB5xEXDe0ipi3MREbJDntkVWTcZHnVN?=
 =?iso-8859-1?Q?8dL1dY9PCcsGTDr6gt8g+TxX9qdmVIJDBqOTgDsA5A2U6+YgNelemw2p9r?=
 =?iso-8859-1?Q?TThhJA/zl1sEZ5zai+OjO4VCQGr4dbQQ9BGVO0WaXmJX6tGBd6cjvvd+nf?=
 =?iso-8859-1?Q?XsCOz7j+JAwmCDZltH77MtsqieG/krF4tRcrxrVJAJ2/MrNmuLKEHf6jbx?=
 =?iso-8859-1?Q?p4WOgcL070xbAe1mtnlFaFqdDB4UUX9RlD8RbDzqFb5Kf9L0Ri0zchA/K/?=
 =?iso-8859-1?Q?3Hn7+Zy0gDkcG8WDVd1tSMPhkQPW8ukItRlZrcQkojjkjFS+ehi0TtmXg6?=
 =?iso-8859-1?Q?FTsHb+Oox1YFu+9puyj2eC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FrNv2lzVOxqSq/IoIH5OZwpKcyNsHKAdFzMLSW0hDlsUyrxGCLntzF6Oz0?=
 =?iso-8859-1?Q?esN3YbwX8+JVbCabLf0DcE64zVEaivKTdQY/1e6d+0lBpI5CodZkIvxtDh?=
 =?iso-8859-1?Q?+dDDHEaYERsoswaKH+YIV7LzYmm3aIfDH7VyxFb+JJQysP4xsPXz6MompB?=
 =?iso-8859-1?Q?Nth2uPq5i8gDFoaLBtHgCphGAwyqQC0dE+vesTj7IhbK1xpy/U1a08vxRZ?=
 =?iso-8859-1?Q?lAT+5ESYkSvSoXWQzI0J+m/eiutKVJOhfkDe3Ca/FHBXarc1xfZv8io8AT?=
 =?iso-8859-1?Q?LZ+3RKPziIK+kf2PjtMOyKgmq0jcIQLHO/gPE1xDuD3GDTAzNLixjMWI5c?=
 =?iso-8859-1?Q?XaH+1q7YkYLdfs84d5D6N2boRLS8HgQHKUifQcPJbN1G2EqRx0U8LnPCuz?=
 =?iso-8859-1?Q?H8lC4r+G6K4agZ39MwXc0wz5QsZXf7TaHAWizIE6i+3NJuO9TEgyPW+pb2?=
 =?iso-8859-1?Q?3ahy6gxjB/8+bFLmSBCbJRqQ9KngoZsDKN/DbPdK73nSY9GzDSbVVgvgt3?=
 =?iso-8859-1?Q?okxw/z5+28gVXB2SL3YIz9RjE3v8cia7BSYg6d1fipmPlDMhzBmzHV8yVk?=
 =?iso-8859-1?Q?aySorNQbjzaBi7HXw5pnUFU/8cwb6o7eh5IvpjndtFUcDGhZzTlooTDo2e?=
 =?iso-8859-1?Q?Zadp0wTibKhBOzLxklWuP+QkZGR078gUd2ou7MkKu/s7zHJhsmn1qOwWj4?=
 =?iso-8859-1?Q?bovTAS+azK0E3DbCIJHzWFABxU1vwRqo5jL5ytmfLIZbnIvOSNQCMLjrMA?=
 =?iso-8859-1?Q?EMqA86rqBy2dfdkI+fnaUQLJYUprd1eTqfiQntNSdFiwKZPbgweZp5jhVe?=
 =?iso-8859-1?Q?Xy/iPfvc8LnMktFP8rRV8/vvcFeR6gNwmRATw8fs8KhSPNDUJBVDEdO1+j?=
 =?iso-8859-1?Q?tV9vVJkUk3ZihDBTS97eZFIp3nPuIK/cwGi9EtuQgQLI3WXAUMJLdiQnRq?=
 =?iso-8859-1?Q?e3Mro7sDiGewy6dShotQvXK1bdD9dQv6fLX7kzAm4CzGa0KOcSctUkg4H6?=
 =?iso-8859-1?Q?SRzp80oNpkGVIRCl73DUDq424uqspZhrDvJXg5l0gsC19Qv4hBEfk8zQzU?=
 =?iso-8859-1?Q?b7kloUggvUnocsVuwLgpFIpdOqhG8qpL6ln0257J6bmLYaYpQxylFmihiQ?=
 =?iso-8859-1?Q?NCtk8ZjYsrtU7zSwgyL/uK4AEBlvBwXRrp15PBzqk3tCcjzpAC5D2FkdEJ?=
 =?iso-8859-1?Q?LyA7bL1UW9BVGvstBwqID4Ejbexc9t3X1bdnnscuZe4xAkMOhmaGd2+KyN?=
 =?iso-8859-1?Q?jetpQ3CS27OhIkefwCfQeakF/sT/WYrAk73C20g/2d6M0m+e2T1rKSTWV6?=
 =?iso-8859-1?Q?5GXeM/Rqwvq3HazgoX9ZZIOVYI1pPr+PYz5pNEudJsZrhLZINF6nrl76+8?=
 =?iso-8859-1?Q?NKWiLFYDbB6Un/aoYS34UYEWCFyCI0SMeQ9UBIvvz/Pg065zVn4CRjJPoe?=
 =?iso-8859-1?Q?gQl4sIqbea5GbuY5pmvC3QdfAs2wIIY1M+GAMMMvD5F89yPIZVpwF4mmgU?=
 =?iso-8859-1?Q?Xp2KF/2G22PvOeo4IAc6i+ixrN+7nqfzvrdpM2NbC8zTRjSAFpVVzG4ePq?=
 =?iso-8859-1?Q?mQtrtlLuJD9RaJ0JS6JzKfb+TNvgxRSTeQuZTzja7xvgq2ngrNSVMeiLLI?=
 =?iso-8859-1?Q?0c0t/CGrQmUoI7pkEAky27M8qu/JuqsSu+eH/BBg44GLNkhraypgDwyzNG?=
 =?iso-8859-1?Q?AHH8AL3CxGiQLlrrDzY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0e3279-7344-45ee-8ec7-08dd3979bd05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:58.1438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilDy/tlk4MxbtIvNE0+RzvWdN+W0o105Grb178XDYOA1cxOWYJhBv7otDZCfoGR5n0wfsskC4DRy6eQyYiVLRjfmg+dncQQ9Ig52ac9XvmvqadmkVscFKFR1CtnJZJys
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 71 ++++++++++++++++++++++++++++++++--
 hw/i386/intel_iommu_internal.h |  1 +
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3c31dc1047..698e1286da 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4159,12 +4159,10 @@ static void vtd_report_ir_illegal_access(VTDAddress=
Space *vtd_as,
     bool is_fpd_set =3D false;
     VTDContextEntry ce;
=20
-    assert(vtd_as->pasid !=3D PCI_NO_PASID);
-
     /* Try out best to fetch FPD, we can't do anything more */
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D 0) {
         is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
-        if (!is_fpd_set && s->root_scalable) {
+        if (!is_fpd_set && s->root_scalable && vtd_as->pasid !=3D PCI_NO_P=
ASID) {
             vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
         }
     }
@@ -4738,6 +4736,71 @@ static IOMMUMemoryRegion *vtd_get_memory_region_pasi=
d(PCIBus *bus,
     return &vtd_as->iommu;
 }
=20
+static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flags,
+                                                int iommu_idx)
+{
+    IOMMUTLBEntry entry;
+    VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iommu=
);
+
+    if (vtd_is_interrupt_addr(addr)) {
+        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        entry.iova =3D 0;
+        entry.translated_addr =3D 0;
+        entry.addr_mask =3D ~VTD_PAGE_MASK_4K;
+        entry.perm =3D IOMMU_NONE;
+        entry.pasid =3D PCI_NO_PASID;
+    } else {
+        entry =3D vtd_iommu_translate(iommu, addr, flags, iommu_idx);
+    }
+    return entry;
+}
+
+static ssize_t vtd_iommu_ats_request_translation(IOMMUMemoryRegion *iommu,
+                                                 bool priv_req, bool exec_=
req,
+                                                 hwaddr addr, size_t lengt=
h,
+                                                 bool no_write,
+                                                 IOMMUTLBEntry *result,
+                                                 size_t result_length,
+                                                 uint32_t *err_count)
+{
+    IOMMUAccessFlags flags =3D IOMMU_ACCESS_FLAG_FULL(true, !no_write, exe=
c_req,
+                                                    priv_req, false, false=
);
+    ssize_t res_index =3D 0;
+    hwaddr target_address =3D addr + length;
+    IOMMUTLBEntry entry;
+
+    *err_count =3D 0;
+
+    while ((addr < target_address) && (res_index < result_length)) {
+        entry =3D vtd_iommu_ats_do_translate(iommu, addr, flags, 0);
+        if (!IOMMU_TLB_ENTRY_TRANSLATION_ERROR(&entry)) { /* Translation d=
one */
+            /*
+             * 4.1.2 : Global Mapping (G) : Remapping hardware provides a =
value
+             * of 0 in this field
+             */
+            entry.perm &=3D ~IOMMU_GLOBAL;
+        } else {
+            *err_count +=3D 1;
+        }
+        result[res_index] =3D entry;
+        res_index +=3D 1;
+        addr =3D (addr & (~entry.addr_mask)) + (entry.addr_mask + 1);
+    }
+
+    /* Buffer too small */
+    if (addr < target_address) {
+        return -ENOMEM;
+    }
+    return res_index;
+}
+
+static uint64_t vtd_get_min_page_size(IOMMUMemoryRegion *iommu)
+{
+    return VTD_PAGE_SIZE;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
     .get_memory_region_pasid =3D vtd_get_memory_region_pasid,
@@ -4915,6 +4978,8 @@ static void vtd_iommu_memory_region_class_init(Object=
Class *klass,
     imrc->translate =3D vtd_iommu_translate;
     imrc->notify_flag_changed =3D vtd_iommu_notify_flag_changed;
     imrc->replay =3D vtd_iommu_replay;
+    imrc->iommu_ats_request_translation =3D vtd_iommu_ats_request_translat=
ion;
+    imrc->get_min_page_size =3D vtd_get_min_page_size;
 }
=20
 static const TypeInfo vtd_iommu_memory_region_info =3D {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 238f1f443f..7e2071cd4d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_PSS                (19ULL << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
--=20
2.47.1

