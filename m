Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ADAC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 05:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSUkP-0008CD-1f; Fri, 20 Jun 2025 01:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uSUkI-0008B3-K6
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:57:06 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uSUkG-0005cT-NH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1750399020; x=1781935020;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LCynLE3owqTuRh9HpSF+sqcZ4KC4BNMaZmYJoWmq3ms=;
 b=Y9IICMXsi9XCY93q4AabdzN45ofdF1UhbwMrNGce4v4AuyHw6YE1CAZr
 N9EnqaTiyw7emyC7eoWWqZNGd4t8kgRmnl+1StKu+RHYpNTZJ59LVxnaP
 ye2rzXo0K+RSSoo3ZGg6xC/smxf09nj69pwAfGokVD6k3dXT+bWegDAns
 lf4bnfBlqitsbons2W4mu4tohxUdpKCgjM9yamCjPMAIxFQRv0GQ3Muii
 J2VZd8aVvCuI/5w9WZCMr0bGZjECqKibDIIlhVf56KNgapwTENYhg0Us/
 GG57UEB5fm7iBWns9mIfUn9iwLuiykInRS125TOGyCw171g2K5f3CqGWE A==;
X-CSE-ConnectionGUID: ZSi5RZ+4TaWw24pcQo+LTw==
X-CSE-MsgGUID: fsIKoUYmT26rbccd5wyzzA==
X-IronPort-AV: E=Sophos;i="6.16,250,1744063200"; d="scan'208";a="41190332"
X-MGA-submission: =?us-ascii?q?MDHj8rGjlL+f1t4K902K5OcQDCQuJpQwJUAoL+?=
 =?us-ascii?q?COzgdiSRAnoOKEcEMNIaDgdToFLzpfZ/fYu6/nQKCASITcpIgZ9QvmI/?=
 =?us-ascii?q?iFzMJo1c61NG9RcwOnGBlRlcuNHu+LssSY7hsbZzvfYj2yoXATMFZc6A?=
 =?us-ascii?q?+nLYsC3IU3YSFx1ErZKUp9lw=3D=3D?=
Received: from mail-francesouthazon11011042.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.42])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jun 2025 07:56:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx1a3NCbPIHF4dVxGnCMWe60bZmXCrEzmVSfhI0eDYY+bFP1IcTj8PXxuDV9sO/IIGVkKt+iOSY2/P78ovHqFHZp92vQUEo/2TvgfDJVawSY1sGvU4dRGKQ4G+iY8FbN95Rlpzv0GkjmXeZDp+cshyPITX1fiwqn5rTLzLTD2wCS8XfZIwaT8LdCEo5jxHSQKitvemmaE/2rlJXP7yRZG5epTs9DXSS7iDAvxLG+gna8RGefqMMkkE28j1h77nME06xvjAg/SEEiMRYH1jzVfoD50Uau5PKI2GB4/oH6/dieZ2Ei7SYIuQ7r38nvs0gh7HneTKf3MPVzwydzeypjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeD9JTwd4ZQYtfnIkyfg9aiIV2cZso6od3fOyuA4iys=;
 b=lJKSAg5/pFUpolkGlOZMlfDwOzudxYzdhGcsNdk8CG5yA1sh0iHkVSUtlyAAy2ZziYJWQJmeWAJS3SFlft2QkEAYxEnEf0jBiooFJPNR4so30sqM+7iBXkMwGPiZqDyKqCrmjsO7L2cg5l5zBZURmoDWB+mKrvpw6ILNgR98tgOqaAH31rJbBxSBny1OeX/PLOHOfv596Bd+YWhBDodCsrtP0pKX/+HnHtaeXLgCz4JJlcwfKPpOOLz/O71SsyF8BX06ZsCMqLT+Haz6pU+LMGcdgU1svf2wOiWVK2Z4lQEXnFt9TON9Ic+CWE1ApZi9C+oHhrN0GniqPEPjs7VJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeD9JTwd4ZQYtfnIkyfg9aiIV2cZso6od3fOyuA4iys=;
 b=PyKsHYd0R3Q+fSsKfotCC7lzbv2cz3m277oZWa/dEMiySHLiaiIeUvVwWkVp/1T5tYrjgh8psn0ijjIkwwzmlIwxDXL9NfCbCrBiUo0PofEPpPWb/kllVFNaAoPKR1sKhtmGYLQMVlzdT6oOa5LQA4DVGoVaP2dArBfq2JLXRT9YoS+SbtLi4VXq5U2WJtMpDzMQYYBxljnrdBVRzYbVTG/8rz7IoxNg2asYa3ELDGC8wiZ4B0hs3we9wsE+zyKlqdIQupQTnHU+peFaHnIbPTCUeuhrzoEek74nve5pMbP93clJoGvJFe0nMGkbY4RID5rhPf8nU1KGMnCdklYTEQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9853.eurprd07.prod.outlook.com (2603:10a6:102:38d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 05:56:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 05:56:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Ethan MILON
 <ethan.milon@eviden.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 1/2] pci: Add a memory attribute for pre-translated DMA
 operations
Thread-Topic: [PATCH 1/2] pci: Add a memory attribute for pre-translated DMA
 operations
Thread-Index: AQHb4ageAb5JmjAfNk6h1uUnC979XA==
Date: Fri, 20 Jun 2025 05:56:51 +0000
Message-ID: <20250620055620.133027-2-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 1e16a61b-8c25-496a-ceb1-08ddafbf407d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZXsJeDhnSsvKBuBj+N3fAKsuiIldaoP0Fh4HXYDyr06o3nDvH/BXDeMKuY?=
 =?iso-8859-1?Q?7ZAHBGOoWoVlwN0AfDDqLeuLJWsG5RCZq3GKffdcQE4U72c0RvYm6hYOlR?=
 =?iso-8859-1?Q?ZCQ0jPw5n1YxNxKm7XGV1xLIq+QjoVDa8RLfmtZZ08OnB1xKFhT0m/AGvm?=
 =?iso-8859-1?Q?efHPQvOKFWC5MkYTMcVg1NqhvECRP9ZgY54fy51pyfhZ0P5MHbc25l/4vF?=
 =?iso-8859-1?Q?TG4YhzdSrQHvk0fLR9Oc3fCWj/OburQXCt1kYlTJPtd4fy6kzAfYNjAjCY?=
 =?iso-8859-1?Q?3yFY6RFpovP2eC3mimm3LXiNcXynkLFqqkaGEZN9Z9ums811Vtav+GhYPq?=
 =?iso-8859-1?Q?i5vs2MRvT8in5UWza+3vTPacFbj77QtNJqgo004xlB1Ac1ne4fKG1NoMrL?=
 =?iso-8859-1?Q?gcy2GC9C78FfUoXTPPrfpzSRl5tOi1mLEpiHOCzz0vYKvDdTn3xBGNaGK0?=
 =?iso-8859-1?Q?UN5kVKvvhPHql+AwTPnk7iHEGPhZV0UwqtzOF/FNuiz7JgS7yu+KcItin6?=
 =?iso-8859-1?Q?zXJQDOO+LGqHXomeQg+yTBUhACzLPjAVyxIRkUWRiDkYZTx/IBVncQidAj?=
 =?iso-8859-1?Q?Vm4s4ncdqyiDhfBj27OUWtLBNBVI6kzGsuk8rS5BjfAnBYbImMb54PK1QD?=
 =?iso-8859-1?Q?RMTX+vt5iKN9vtuZgYDVhJm6FAMypgCD6CxJ+tNCHh/Hyw/3qXrjfbmtXc?=
 =?iso-8859-1?Q?2w7ARoNq4DDjk4e8ZfYS//JRJ9yt7ntERgT4WB2s3iwsuTEJN402Au49J1?=
 =?iso-8859-1?Q?5CpSapTtLU84uXQUL1s6rvvWg7yM8FZSb/CjQWjYeyN+5C4IYhGQUpxxAu?=
 =?iso-8859-1?Q?bjpO1p7KgyuOp8L3rKERCo5O4nh3FvTjwnKTnGPnlrwcn1FGGQ6uFeQZy3?=
 =?iso-8859-1?Q?cUp9T5K4eui0cOm+ZmtsG0u/mhQUnj7ryumS706iRSkC1CSk9M5r6WIFkv?=
 =?iso-8859-1?Q?r+zY252KHS8gnMbDV8czN1AbrG+B7zi3kTIveO88w5cEAqJdViKw/PIfIk?=
 =?iso-8859-1?Q?Jxf7XLW3f811wc7VCD452IDOvOHEu3XjX4GAVtDqb8FccfGU99EPdIWAxV?=
 =?iso-8859-1?Q?8od2Q+/WPp7lWm/vjogXMIDaAQkL3xhyBpstYhjLAhdzPep0Kr/TfkT6X/?=
 =?iso-8859-1?Q?3ESa3XOKmJEyEhABDpi9u7sQ3dXdAZyOIzarefZ/xlqQrgKAEjThOXJpaH?=
 =?iso-8859-1?Q?T0jWiWAVmBl4/RXcfe9EYTiHROzGqussJptvow5UuIvGpUQpXy/Fe+5KyM?=
 =?iso-8859-1?Q?FLzzTXCLcWWm1qSIrsEhEsjsG936wa94YA+nUADmQKeDL9tLsSjeySGwTu?=
 =?iso-8859-1?Q?nNFDyeWAggdSLY/sCtN9i9+GXCcbTy2P5fwZJ1pmv0QyGahZzE4oG3rP1h?=
 =?iso-8859-1?Q?W2lLj7jJkwv7KARfEZR81xdJ5aOv0hL5xgdtMxMk3uUTkuhsi0KQr5B/4E?=
 =?iso-8859-1?Q?0+XhbZyOqTilfwX3/2zE3dSTlw2cly8xR4FRhV0TOgeyq7WgZ1OBNpodIr?=
 =?iso-8859-1?Q?wzhOZEGSyhvnEcFNaUqKO02p0QSQuzAfC7yXF+h5OvHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BwKx6ii66U7568TfkWauViyCieqlKQ8PC4CzxqvuJq9yMQp2Bo8UUtP4Kn?=
 =?iso-8859-1?Q?R45hq3i/aAny3F/h3XmTXEXRTl09reaznOYwRV0VIU/ZkT/QGdJlwxwynj?=
 =?iso-8859-1?Q?FbbBcv8j4JmkIlfIbDF28I4upKBoV+9+wSHR/MRR4kylOytm2DwKq5H8ge?=
 =?iso-8859-1?Q?4u+UH44jvWykPLzpFwUu7NYrKl4IsiizFeDmH84B+C78D09O5Et++1Ra2v?=
 =?iso-8859-1?Q?CDPGrzpM0r+dmKQUEVBlxTVPQkAacP+OwiuwMUn34wce248JI4YZwMY1K0?=
 =?iso-8859-1?Q?CkbTa1LM9D7tmrWpqyqGX0rGW2xOkzjTXHSEg10APaHYeYhmQRRs5fVkYm?=
 =?iso-8859-1?Q?KzFkFZvyvGeEPLPIWE1MZZQcvlIi0ivA7lTLOTzau6vMKR/sUrlYaZuBwP?=
 =?iso-8859-1?Q?cRFTTV1qd4/8u44Pklk42DSyST634oGKsUuOMNrAR2vjcQU/zcxui5nqIR?=
 =?iso-8859-1?Q?xoYN3K2q+Z+s2YDoWYHJoiHeiSbgi76UNj6UMmx7UnHywBO8dJdi+4Us1b?=
 =?iso-8859-1?Q?h3yFTjaYaeQFCOcvK9JVAkVHNGjN0jaV/GaZWRHjoP+pel/TLS/IEyLjWF?=
 =?iso-8859-1?Q?bEYPaVERXJxV9MJoVRSVje3I+XBKs430W/VTyBfTLi9QayZPyBDIAXnH+s?=
 =?iso-8859-1?Q?l1OVGTf8f8qpbIQZZD2+7vPGPx8c/r+3KuFy758+XRrnCJa9qU17kvNAZy?=
 =?iso-8859-1?Q?XU/P2u2TD9X4zzztG7r5QJfY0IactwdjFpP1mtFwKaLl49QOH5dNAZkQEA?=
 =?iso-8859-1?Q?wGJLGbJl0bpyC1iGBKmu5YryDklA+5W1XukeOGdMUmMMbp4TRKaiiATyVw?=
 =?iso-8859-1?Q?+1vY26jN3Mg923rNHp5M39YIR7zQ+CjVOT8QPHQtgwJu9bGBDFKw9Sei28?=
 =?iso-8859-1?Q?tVCLwVtYW0K1ue8PZyVpikLrzBWh2Z+1xTbRZKwPRPhd9hhPcFxXZGdnhR?=
 =?iso-8859-1?Q?uzq38jOJYZe6BmF+4pDwi1RwqyEov2C2v1STHfp28S/NHV4GCTzcXV8dz/?=
 =?iso-8859-1?Q?Xm/zTbRXRtdZP8KmUqabZ5uRhh3nMqXubJSEFdBNd5edC/B3kSDEcHA7p6?=
 =?iso-8859-1?Q?9B/On3hpDzPmm387215i50qM/6P5/zDa92Pe6b8w6D5stOIMb4keYHM+ls?=
 =?iso-8859-1?Q?egsIVS5Ke/MvUudEN6shro49iROjrwAXoDhPGxOEZgooRSpZrMBkQP/NEF?=
 =?iso-8859-1?Q?xQtahuASk7PZTb8Rod04Q9/tg9L7UFhZYylP41JZyqlSXNokwfDk+1toET?=
 =?iso-8859-1?Q?cGa3fdFXhozOZw39euFTOUlDVGsqJqgm3onpG2q39qnXk9vV3L58CMBmBy?=
 =?iso-8859-1?Q?h+qPY2pGVxZ5rJuOWaF01du3gJUQJJsQOgOezTlWuL33UyEoRVkJzdovde?=
 =?iso-8859-1?Q?/F2zxcNhxgA8aTLTa4zicgFhKDJxZZ6eh2/T8YfIuK72d9kS8vPcDBFv21?=
 =?iso-8859-1?Q?DtPeHMCESG4MVSpPaX+mQV4YvYPWCRsSMcdIgCC7utpMhvNOuTgTLo+vrn?=
 =?iso-8859-1?Q?HRKUZ407Oa+yhiaQruWSOZ6+qamcDvfzikJqvpNMkSdd+Ph3HcxmQtpn9C?=
 =?iso-8859-1?Q?YG31CbUsH8UJoAjeYEnXHJf3E/0HTKX8mZCh+xYV9kzeW1vGvMhOcpl7V6?=
 =?iso-8859-1?Q?RNHlTcAtsUBdQ4lbX56RNs2gK8YsRwFe++1BteUuX3KQVIxCPHCwSR+prU?=
 =?iso-8859-1?Q?RTwNRF0L55KBazAFhTc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e16a61b-8c25-496a-ceb1-08ddafbf407d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 05:56:51.2063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9c84Q32TSFgFz/Q6NB+l2RBWaMKLaNtqx7rpCKhts5qH06D2YPlBpReqX/I0sAdQfzv1++vPqzMmKk7ivLmSxzwh/bBSqGzPMt/8wgvPOXLfB6JPyDFGQOTjbN+2pwNz
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

The address_type bit will be set to PCI_AT_TRANSLATED by devices that
use cached addresses obtained via ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memattrs.h | 3 +++
 include/hw/pci/pci.h    | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 8db1d30464..52ee955249 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -54,6 +54,9 @@ typedef struct MemTxAttrs {
      */
     unsigned int pid:8;
=20
+    /* PCI - IOMMU operations, see PCIAddressType */
+    unsigned int address_type:1;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index df3cc7b875..6b7d3ac8a3 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -134,6 +134,15 @@ struct PCIHostDeviceAddress {
     unsigned int function;
 };
=20
+/*
+ * Represents the Address Type (AT) field in a PCI request,
+ * see MemTxAttrs.address_type
+ */
+typedef enum PCIAddressType {
+    PCI_AT_UNTRANSLATED =3D 0, /* Default when no attribute is set */
+    PCI_AT_TRANSLATED =3D 1,
+} PCIAddressType;
+
 typedef void PCIConfigWriteFunc(PCIDevice *pci_dev,
                                 uint32_t address, uint32_t data, int len);
 typedef uint32_t PCIConfigReadFunc(PCIDevice *pci_dev,
--=20
2.49.0

