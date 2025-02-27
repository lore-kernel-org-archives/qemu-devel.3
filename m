Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BA3C1B087
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXU-0004Mq-GE; Thu, 27 Feb 2025 05:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXS-0004HG-Fe
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:46 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXP-0005oQ-Kv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653684; x=1772189684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tQ4ZD/jVqFaAa80Rd9aB0joY7YkHKhzqxvXOWS3zxO8=;
 b=XA/xO2hneW3hgS8K1OM4Q0tAnf+e4vDte1suQZrbaj+E+FuCUXMWnGVi
 ezpPKIs88v777Wu26YFbaFxmA5rRC5qwJOm3pO4Macl0KVuCBpjMucdKB
 fbALEJ6hl9+MWpGHQnupw3XgSlScjkpU3UpW3zZjj85cnn2XrGaYSCWGu
 DYLbZ0+desO+JJrTtAfzijWPSvTe+c120HIMgGHzyIDlxz6YbhSxTn0WJ
 oJSNiME0S+a6f9Tp+qXoIysuOt80wOMllEkmiLALoaLdp/id76fb1tjJI
 GwRDiydZhehn2ZNhA99tmC9svxe3SlI5G8MFo7C91I8FEx/1WNlkyk0XW Q==;
X-CSE-ConnectionGUID: hxdLEg5YQzy4MnTQu2uLZw==
X-CSE-MsgGUID: 0vQU+eZpSk+0O7a0ow2Gcg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331822"
X-MGA-submission: =?us-ascii?q?MDH1rnFtvIUVNnUsXf1jaXVnkStTa78odlHZw+?=
 =?us-ascii?q?ez/Mz+zZu1rv81BZq+5Fm27J3wlaHGE2F+a86EZs20xTvDBNs5vns37v?=
 =?us-ascii?q?q61m+S+BCAh/xVxIdM+rE6Lk02omkF+ioyJPGx3dx/ioT6WDo3HSfyrl?=
 =?us-ascii?q?gUtutnMpLQHsHVMrpXPEQeyQ=3D=3D?=
Received: from mail-db5eur02lp2107.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.107])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk9Q7hE/hLODOtyZ4mGj4W35k/+hdaKlEbjFTAShybmZQQZz9Q4C7TJlKIgEubrXmPt73c9U9W5HyxmXG1qb3IJWNNJ5zZ/T7qRU/3IeGBFrQHhGhWlCDuf2vXS1ZZp6zr2TuHJ5/0XzpKJCu8C9h+sIWh/W25H+ftKTI8NAMgCW97hcZVb0AVlsjmJP30QYW7VmR1g5IHK/sFe9XAhG3qFrSSQdXx6pyIlTdxI/csujvYLun6rTYWdpinNe4EiXdUlH3eLez52Y0VpKBiqKNTDJzMD35YYZMz0BxQporcORECJhK9IgIHUffbjL60NhM1eM3ueYEhsaxfpiQMKOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7CTr+Rb2R1zqg2bmxcnsAs7xBENi9tcDM1WAW1bfKA=;
 b=d4gaVJx4qxkbzz6n0eIWMdqFYgYRweyFrsjCPlu9L9SR+Enbbf+OjKCVRuPXZRNMMM3Ka7POTS9AUxyJHvqZNGhXgo0OKLJUiJoD+saH9nIm2ZIQ2QYd/EwOpieyxU5cRRlSvKySznofYAuTpzN3Nk+TnqHcgcn8V7Cc5bZuFzHVkGmvpGv5YLH8SkvSi5JwUBBBoNsgq8Z5qHTvCDRfx9dQCElN8+HtKcKvkF6y77h9gCPc0GnAbdjHjOtcjZsUeJUKFiuSbG21ZClX3kTcZs2DZmjKyGKNVdFJJO8bCER42PCUzdaSYkBYM+W5et/VPVMPJ5qSulw8Vr5qp1TfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7CTr+Rb2R1zqg2bmxcnsAs7xBENi9tcDM1WAW1bfKA=;
 b=r/t3SSdl5nLA9a0GGTquAuWGxJMFAWnrL77QWWcnwwsOFvfpIIpt9J/0GXPS8FPdCj43ckzi9zbVDB2uAFrxaayQiAeHYOthFn5nNy+uW3iLvTtcnuQFbm2b9yBNUXGXCh4dou3olfP3pNemdmPrhs9kZ3gSAcwhnQpTuzEw87mS/IAs2/3siHvD/3z8i1ZaJNYdSbZ3lguxPRvuU4h2ihwia46JvWDA8tjdCi6C6UlZ8xNc0Oi+aQ4oeaqgJZsDTWpVSdYAj84UN0Ymbr1GRjGYTcYaxrhB1jXT8i7qbz+aX6IS7ULTyFY/KkMS3IvmKG/q7rixPz28hM2Cscz0hQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9421.eurprd07.prod.outlook.com (2603:10a6:800:1c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH v4 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Index: AQHbiQX+k4wfw2jwrUuxWYSRoffAiA==
Date: Thu, 27 Feb 2025 10:54:38 +0000
Message-ID: <20250227105339.388598-2-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9421:EE_
x-ms-office365-filtering-correlation-id: dd32985b-52b4-4c6c-5f28-08dd571d2172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?srZoRJHo3aS05chNz8SYlph8TCpd35gdYtdVZj6uL+o8VAvPTgfYmYpMq1?=
 =?iso-8859-1?Q?G8ADkN3N2S77ZXpdc1uL8jOXonGvT5GKKiRRdceeH7PNN5VRpwMTwt6T4F?=
 =?iso-8859-1?Q?n1HbZLxXN7L7RD1J0l1cWt40DDdTqfw93+4WMBPF49k9Ymv8txqO1HiBtg?=
 =?iso-8859-1?Q?Sz0f9nDNpD+QvZvolUL+ILo2jau9hmvKsI3/m9568LI5szLyDlPZaZo752?=
 =?iso-8859-1?Q?sXpnPS4WPPeTJwLU8oB0JieuK5+MQFzWr197GsnBh/zYrMSqEXPrdMy09T?=
 =?iso-8859-1?Q?l8vYaowazzpSUcxuCGkxPuYa4pWUCPI7W52w3AVY1O8wmZqAssbZ+K3qLK?=
 =?iso-8859-1?Q?xQT8x9DI3WH+0Ycpzeb/4sHeV44HMZ0k0G8mzo0lV+MaMEw8Sad+RS10VS?=
 =?iso-8859-1?Q?I+VhoRaxcgI/RWBiwPW9kYxNfbrWVv1XKEjWBBxeFZ7hEP1dA0oyyXE5vg?=
 =?iso-8859-1?Q?UnBskZEXyojkFehZA09ShOqstd8csydXLVPpIKTZZGx41DPGj20f1ZwK0G?=
 =?iso-8859-1?Q?KTC6cHu38utTSTm1tVTH2MGFtgrlIe+UV503JZd45UlyIBcjryZ2suU2LF?=
 =?iso-8859-1?Q?FpgONJDhHEx9onVUoFTEtM6a42RYOit85mhZLbRAyFHSrErKvQHdnXchTL?=
 =?iso-8859-1?Q?e9L0eS0MqXSPOJhLG23Vxw+Rs043ZWCfO+SOpN4tDXG72/T13ok637/zdb?=
 =?iso-8859-1?Q?NNwzlJkW/ne8KIV6oHBrA8iSPuCF4wgTUm2oWBDuq431tqDuDfcyzPB62C?=
 =?iso-8859-1?Q?6G/dkGMiN97mso0CTGfmO/W8QGXadp0+PTjVihBlgndVkiJvF7waLXU7Dj?=
 =?iso-8859-1?Q?7ksrasGuUE+yemtZHWWuNPQlIgRI+w0MwoJBFeE9JWVUXZbIfEasl3ZWFx?=
 =?iso-8859-1?Q?4QL3KOP+HhJ4/E+wvA9PYcPVyDfoO+KB6S4Xgfq12kzCgugmD9Oj73Rk9k?=
 =?iso-8859-1?Q?aXwOAc4cU5TI52HVyKbu1YPkC5ax4hx3cTfv2uZ97GjmipDx2UO2F3x94s?=
 =?iso-8859-1?Q?SecFk09P/83Fp0C3CFePL2d4KPpENt3PVaPHK0Xn+cF3NMgejf+rvWLFO+?=
 =?iso-8859-1?Q?8Be5/YZ2wBDhqYPXyPt19x7n3eLqJutC6k97xfWYIG2bTHtgJPzfObLTbM?=
 =?iso-8859-1?Q?GPHI2vZnHCp4838O4pbIIg+sXYuZ/Txcl2uwuDVH3IsosGewefLkptoqli?=
 =?iso-8859-1?Q?xy9tFSlkV3SK9s6MzkaqxGDsNbgxbEi3uJqE7MiTYp9V9xRoeWQjG0eJBN?=
 =?iso-8859-1?Q?OPnOdjv/7yZ0ca1JGjgW9p8l6BATPsmDfP7I4NSVoO9APRKToaKTy5V7FU?=
 =?iso-8859-1?Q?t4jQRLBmEp1yxT/DFaooXW0RWW9PlsqXwGJeloQJCc+VTsC4OdVPrFI+9Q?=
 =?iso-8859-1?Q?uMCKrWevFwpo3+mSAqqJbR51wi7wn+V//hDV/k/OlLNCBmKHWAcfON1+qs?=
 =?iso-8859-1?Q?XKXIULLuSEuOnhLDS0INAaquh96tndbQxUxOZXIEfWt/V3g7DMPsCn7alj?=
 =?iso-8859-1?Q?SJuFpR3S/Gb+3UgHNndXOi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b2ueXif96zIap6y/AhL0LeOV16sSgPPxJliNYcrdB8iFRpilqanGaomkSA?=
 =?iso-8859-1?Q?jN17neh69rp8g4xOv/C4RkA+6AT0XyZ9fmshfU5/10wAOsXBotHgopMMhy?=
 =?iso-8859-1?Q?x1lrlmalmvc70FQXf8N3qbYS1vDItWo5AgHWvIYl8mFTad6l9jvGCUcLov?=
 =?iso-8859-1?Q?lfHcRDJtAZ/mAYEcusZZDtp+hFAa+p4nmUEY2itPIPURM5PD0UK6k5fzI6?=
 =?iso-8859-1?Q?eqIep4txe41En9p1j9dpedu21llQJU9xT7OOljxiOo2lLXO7hVSZKfLSWL?=
 =?iso-8859-1?Q?XnI54eKpBv4IeFqF+OFNJ9T8i1zlGH35G4FE1mcWLMrE/YK84moUonUBOq?=
 =?iso-8859-1?Q?FEhHhuu395tLQGPYl8F2q841FIyj0Pdp+lnP643/F2GuKO+UHmX5cmLLp4?=
 =?iso-8859-1?Q?JS/5P3kWiTGRKeo98r5FC7+5FCOO+YGOwdjRErl62SVSFXHKlAxjKQx363?=
 =?iso-8859-1?Q?gJCKGteiqTWv8sxVpKENKd/yhWij7TTOznxMBYj1dvDXhhy9yb59CfsLvK?=
 =?iso-8859-1?Q?ZHBzRXVh65ueQ5RyXlDsdFEDkJyQiLMntLfesWihfuN8L7TF6o2qYogS7Y?=
 =?iso-8859-1?Q?HOiGEXXlj0JVMp3kpzzDU6iHPvLggp0W2WmzNBkVxpVWJY/iKdWD8e0hxd?=
 =?iso-8859-1?Q?qY85KZUZZH27ExVGrxzupBoCbKGEUfOi0ejfppTy9zWzoQpkwkFCtUf29T?=
 =?iso-8859-1?Q?2wdxrJXrPBk0kuoxLOUQrIxdUmLF9zmeJADzoJTXOQ38jdjafpNya1BD/P?=
 =?iso-8859-1?Q?9VlZKe3n+82/Ix/BYBDV8PcMAg77ykYcUEm8cGuDILpmalAtOFuRdWCtAC?=
 =?iso-8859-1?Q?uUxGzwABaCjMBN0sVJ2uvp6yjZ8XZazhav4UvcGaPeIZGGCwgBvBaaqfSi?=
 =?iso-8859-1?Q?B26Q1lpG8zfdm2vlqaTJ8EBESiRh26O9wVnXPeAZLDIwb9DDszy1T703/p?=
 =?iso-8859-1?Q?h3wiDpaDWYOw8TjOdAL/M8GcwiP+xvyktCAMt04cRWH+KYOS8J85vRguGq?=
 =?iso-8859-1?Q?lmKUVpUF1kDweQEgHjn4k+sLDGyH3kcTFDjDwEHKwtQITBq49GVKn64Ut1?=
 =?iso-8859-1?Q?6oyIzQiCNqDO7cA7x9dM6YtCtgJ6UR4RlX/uCfXakHE6tOumA9kKHGhpNz?=
 =?iso-8859-1?Q?MeUkz/mneHBnPdIImdsdmp0wpcJaIRJKi2RArCLCubSGcvp7QIlDoF7VTi?=
 =?iso-8859-1?Q?ThuQZQBayvXate1yuhJNAOuwa8Ba9WL+G1fOF7M3lMqYWpEYwuHDsCQuAv?=
 =?iso-8859-1?Q?1j64qNL7prww1qX00/MfWEIzhXggU0GdY/rGs4IY28/jcjlDw/NnkzN5oZ?=
 =?iso-8859-1?Q?QXMHAU29gi1y+zEAnAK/3JgujM/d0ojM3t/Z0hY4F5TVNnlc1UThjQgphz?=
 =?iso-8859-1?Q?1zJ6qkaMuGny5YGhbSzfH289qIZ/ZZi7TKja/2YOBPt/XsCvLnQy94osja?=
 =?iso-8859-1?Q?ELuTUZQurenTW8/FwGt7ivv76UtkvpUwd5+1BpnAe0XHO5jhRqjBAIcfQ7?=
 =?iso-8859-1?Q?rjbECnX8zf6hwtku80rSL9IL0k4x9isHkSr42X8aLXTMfdpgihCDrHrfrE?=
 =?iso-8859-1?Q?PEAUxrWqlNUPZ7zYMtMOsoTCqKYIY7ArYiE6F/Az8HDQsFJ2XmSiEHgccZ?=
 =?iso-8859-1?Q?3NP7xr/5cf3/mc5N9320onoqVH1dZmUbjFOTjA7qbRR6b9wazTbkL/k6Dr?=
 =?iso-8859-1?Q?kNJC4BUVhHUQk9NljCU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd32985b-52b4-4c6c-5f28-08dd571d2172
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:38.3092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRGXKAwbxO3cEhlDQQZzQrEQ3iff4c9zfcjYVbZr20vcmbgV6oAlQdxaeAWLdmN54jQ9qtdokwBVmbKFQvFvhMpWsJ4Ke49AjRWrEyS8xU7G9tOwEhx8BNFuFNAAnRyI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421
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
 include/exec/memory.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 78c4e0aec8..29f5d31eef 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -110,15 +110,34 @@ struct MemoryRegionSection {
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
2.48.1

