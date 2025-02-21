Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9028C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4d-0004b7-1t; Fri, 21 Feb 2025 03:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Z-0004Zd-HV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:47 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4V-0005kU-AI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125263; x=1771661263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MFzdMfJRvzeRB8KN3cYhlmgFrM88PNKvAD0/WZFjBos=;
 b=WJLRIW8fxMNGxMBKbfQYFfhJ/uGymRBQrIyX2/83qH/ksa04lvyjrEc0
 Aqoz0Sbff+jbGZHR0kPoUHaNcMPAWNs5z2pftESSQO25VmaCGRSpRwGvy
 FOhrP7Cd+8TDus/MPZAxVnkPmRt1ddXH8QlNIZFwByvO5n+N9vE2HGBbl
 q1xweZBW/RsJ5Nuu/2hMY7utmVfBb8739aUB5baLsTJ4NXGEYYWOXZoRu
 7dUH8mgyFEO4k7wo6UTGvBXSmMWU0xT0jmmc1R/gngKYU8atRBUTTeTqc
 eHo/C5Q6CmqjFIX69DIChT1x1akmA87OyO+kUyrD4xAHcQUi5hD4gr4R3 w==;
X-CSE-ConnectionGUID: urKhIuXQT6yNVDOcETfqUg==
X-CSE-MsgGUID: p4yP/Cy7QEiZuNgpJKlP+A==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836650"
X-MGA-submission: =?us-ascii?q?MDGV11rUnxbRr4AjKH0BQQ7OgEdqymvcbaIDAO?=
 =?us-ascii?q?9OoQRctBk4EKWx2vsVx8MZqW8qLfEe+ttx8jSLZoFCQWcnZeEv4ZFu/E?=
 =?us-ascii?q?x+jyvQsrg2XTNpFSsMLAcWs+TKnGA7vLT0rMx/TP07sR6joiG4YTyzU8?=
 =?us-ascii?q?1t5VJfTJQt6mxeIVRo2hM0iw=3D=3D?=
Received: from mail-vi1eur05lp2172.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.172])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:41 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLqjK8moKMnB7hIw92k/WYhW+EreWTGbZqhuLZ64wV/KsBDfMrzljaDhF0rOTfJXwpjcbEG4N0oldfMZRB2DOMTETRz1MubxdbhCgk6lTx27IQFxU2G2jUuiCcXBGKKhbUf8CXOpKS9IoZyRgjwhnVcPIGtCm5CmCf3DpiZq4ZqBPn7RKx4j2OWoKRX0HPbjGOh5gNMtY6Qu31adt1E/uB8fiU5cacfAc0FEyTsUGX1Nwbg7V70JOQHN3oASE/sVEYPNrieX7wgRNjltBeOGJlXUdvbuTLozM6XwacQPXrs3LEDqksoVjYAAkSE7AuMf8fWBT4ojdXjwLkcavrFqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2iXVLFV52LhyndbqvldJ6WUjzWPJC+MCtn8QEwVLZg=;
 b=ZtdngYJ31kE2Yg0mOM4qPHRYDI8qa0KQDh3xLiIWfqtAS3qCUBXbPzoqt4/6GK3erU0oXWzSzIJ/9Qiq0sloFKvuBvKtGwlxlDKdiVuPlyDK0AI9XXtY+wXNs/pHbca+euVBfBNuOuMI83ZADwyKCGTE8wvYYclDodIgyNwdYNUu7WIquyKo8n7gxV2BMDjon3My3bWXhhsLVpMlPrdDUQMPfRELNGGACXT9B9qtFgJhsVZblMsS/p7vXJNc/EtkCBDX4Eim+pOGMvd+hc4kg65XzM38F34NZ5rzzdL80/SzGd/ctZbshDfhYy5btIxPbyy9FxYSPzJLXzYHMqCLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2iXVLFV52LhyndbqvldJ6WUjzWPJC+MCtn8QEwVLZg=;
 b=IYdEyLIwl/eD4051wmCRhDV/QhR5zP+HV8NwHaKjtpI9mK6b49+l8JwbuWwimxTFGFsW9EHcf6AG+0uUF2LcMy5Y8Nmj//IfKd6FWyFDW5uPMoeRG03el7TN8PcU0YVWMouZNVjZn1k7GGlXJQnjfng2jloh7EjhCfiZlvXkh/N2FZnTKqYPWNd3Vb7Krp5EO7V2T45R//EnxIdc0JX/gvAAENVvI6LhU8Z+LQUsecNiR71AIIAE+iYwJdn57IVJEF4j5SuRBYQBlWR+QnsLlZRsjG0vKa6egDi3EQPJmOacQgrdoLkrxUPR9ItyBq2MZE6NN619I6QwiH5LzYnJIA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 10/19] intel_iommu: Implement the get_memory_region_pasid
 iommu operation
Thread-Topic: [PATCH v3 10/19] intel_iommu: Implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHbhDerjHspUf9T3kODDE5uSoKcSQ==
Date: Fri, 21 Feb 2025 08:07:37 +0000
Message-ID: <20250221080331.186285-11-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 48c5f938-b504-4661-96e2-08dd524eceff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b98AflzcGX98hn+9Q3xYSoXxTsX09NSYCM7o97uvBwaslNkRDxbmtYHoqu?=
 =?iso-8859-1?Q?TMmLg/ZqxSzj5jV6upZ3kqg8CtEPuqA/3pwYArMm1JqU2ODOQv9FqN2Smv?=
 =?iso-8859-1?Q?6zcKUIaBWd+khSWPtsi0m2ctwjt9Xt3FXYBDqoJaCqRsPTOSaSC7t6Sq9x?=
 =?iso-8859-1?Q?dhYgxjA7oSugH5TfedUey84+kRodOHgGBCejYtm/ZEftqzebRcYufzh57k?=
 =?iso-8859-1?Q?6r2wAArNOTGm13NMKQpwNmwjkjvZnespSMqQriAsGgFt72alh3kvyOpwNx?=
 =?iso-8859-1?Q?dfgtYBA1uelL1GcT32uDQPhDAf6Qh/XtSl+2D7pKufWx4EkV1RaBihkOeD?=
 =?iso-8859-1?Q?LuW2wnGMcwpEl3xVN8HXrHiMI9tv1EcXdCrHsOaT8qGl0xP3n3ebv+/4Dt?=
 =?iso-8859-1?Q?CmD5WrDqdr9dmxPSD22yu+pRgIc1QoRyRYsGwta+W5hPtGtfi12O14nSA2?=
 =?iso-8859-1?Q?ydGakdBSiUcu1SjwoOwTLcYCMUkHd858dLhuDmOR78YkGFfSv+qH+1T3mB?=
 =?iso-8859-1?Q?PXs5CFqfcHl0lgn7HDe7UpG7djjJkRAec04Jdy27PO3ffYiPLY7MhBxPje?=
 =?iso-8859-1?Q?LE+dHyRPbInaJly+VAcqVzW884uPeJTP4BlDG6PiKjRleG1RiOZTL8xl8S?=
 =?iso-8859-1?Q?SeOtFTG+Hn7M+YtP/UYZcsxnXj9Bg6fvgoS/C+PYqWnjujSFecdvtYRpu0?=
 =?iso-8859-1?Q?DiJJS8q9LpTmUcVKn6Fqy2Cb5vJ6lmF1atow2bv+7y0LjFh+ml2053zl0B?=
 =?iso-8859-1?Q?TGmpF3tqXI7dhKWYu0Be2FQMZXPxrXuaTidG0sYSAeR2qAk+i3Eyo6LaN5?=
 =?iso-8859-1?Q?fZaHrnfwaUungu2Nr7waY1/aZ6tDUsSPIQa2TiYXIQTQl20aORGJtfLdEG?=
 =?iso-8859-1?Q?bg0HvIli1XTzkmqvU9G9uX6DZTvtsq4Cv81bf36u5Gm1SciuvNV3rproRo?=
 =?iso-8859-1?Q?NPVpZSGFCyME0YZfQP8YT5wFKUfyL+Q+SrGz6gm6cgsbb1pivA64ePye24?=
 =?iso-8859-1?Q?T3J40NJunc6ELFdYqLBSnM1gh0/Ijkr908hDbSeFKChv2gZbHaYDYfmrsO?=
 =?iso-8859-1?Q?dRQKDIBB5SXVPKjbz9IGnQleoEIRD+S7BWLSM5Xpllim7x//oLazzYjYbY?=
 =?iso-8859-1?Q?5FQmV12LPEhovLR7BaWQ4dFyWEr5tp5M9yuSlFsUmALUb06DprxLf7TRpn?=
 =?iso-8859-1?Q?MQ5xxkkL0g+tCDTmMOpX/A0Xs/CLddxPxSwnWf39ItR4TUntVOZZ2rs8GI?=
 =?iso-8859-1?Q?9FpSSwgZXnYau3jiSZ5uwaQ3hvIF++KqbZ7MZdSmXcmiQcCA5Gh0imEmTl?=
 =?iso-8859-1?Q?xO/6SOfjesVwcTH5LGjpvUFETIdPNIXZxT4ZT45ygDft2Z5GGRB7GITI1d?=
 =?iso-8859-1?Q?3VaTHi8vMGIJ6q1C5OGu9bVOYLjdc9uw4vCbIhzKSRZBTDn5ADpjLYuIAj?=
 =?iso-8859-1?Q?w/aqD+QuTU4BptDwc6HDw5YWSzVix6IKUKy1f5B+l6914Dk5NUIUDhF+t7?=
 =?iso-8859-1?Q?ZaHuZfOjAqJozDgB6MIbmH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SLNRSbpj1tUzrEIsqsXSiVAAuWGZNn67ytWgbhOaE5eZDonTxBnVtRHYtM?=
 =?iso-8859-1?Q?yDlLfj6mhzie9g12Mfgujx02IxVgmTdTpeKwBzo7fGKk+Q/DhMTFVNtwqn?=
 =?iso-8859-1?Q?gnFmAREKXyEjfkeItI2aPPbTxfPHbVeYQ3PxvJna9olR75b6riOCPp7boK?=
 =?iso-8859-1?Q?t4IDV3Pneml2q83dpMVa6rtcve14+Y2reAxtJrLg6xrBxEEFOUdfnUnNS4?=
 =?iso-8859-1?Q?wTuFd3/hDj2r1D8AxiMS4c1WUxaxDX+xh91Qg6QnK3Q6dPaoBTDxoN0d08?=
 =?iso-8859-1?Q?nFtt6MUvoWDA2CkhdHl7D5sdKIFPie5Ul4yi0S2DfITlr38IWfmYQnVMXi?=
 =?iso-8859-1?Q?uMZ54JWiIWPvJ5fimpODGSwn/2yKWEZa9BcIf7pE5spqpbgrQrEo0jLWTx?=
 =?iso-8859-1?Q?mUZ6QuZmaDeHaLlxDP8o5iJnbes3qkFNGAAryzk6r0MRgSjv/CCt4s/8kQ?=
 =?iso-8859-1?Q?uqjK/Vd+SLT4Ec1NjqafguaIAoByKvRPdfg3rBPgKa24dgBakYrQSRbwVM?=
 =?iso-8859-1?Q?wTYo64WnuIkgHJ2ggP2M2YFeYHBf9TXys61oIR3m7m9NTgVz9yGP9/AWmP?=
 =?iso-8859-1?Q?Yil5nTNgJSy5FnPHOHgh6hKMavPjVrI37WLTVuyu4caFCLQxlAJ++E9JME?=
 =?iso-8859-1?Q?/8ZeppLmo49OiPb/lGLGayaDnBmOGc9qZgZ5tCYGoV2vmaqWGY6DdmgYjI?=
 =?iso-8859-1?Q?+Rd0bKKFFLfOYu9dYkSfvQHyLl+F0NpgZxHcv255f45X7uKzzCAHVjSLec?=
 =?iso-8859-1?Q?/L22qNvxgMxUVzRQU9frQRb3uIp5v3T8UnAVZPHbuKACLijy0sMxKX5OyD?=
 =?iso-8859-1?Q?SolAcsMn8+NquG0Vv913DIIvJLh4zID5pFfbX9HkNXmj29EF/HIJPB9ncx?=
 =?iso-8859-1?Q?O10gcq4xl9a8kBgIkA8Grn9V0MGHUV9NIN5hyNwaJYXMRzojPyGCf9zSEE?=
 =?iso-8859-1?Q?6Tb7xBlc8SEg3ZFdr/Y1Rq3hZr8UIwgB9Pj7xOPQylf/ia48qhXJFa/LUB?=
 =?iso-8859-1?Q?4R/sUWM3XiEWbD1YflRr4CmH0mkXRSsqxKgre8S3vEGaIhbeIMeFIoPc4B?=
 =?iso-8859-1?Q?7CaWynmVHnIK4QI6ixkO9WN3xGM1qwa2PDziOHyZQlVbvS9AI8oscKyXUw?=
 =?iso-8859-1?Q?wy7bIXHwdjKjGem6VAL53Fj4qqqfPBg+bYRHifCvrfaOJ5E4Hl9VQc9Awu?=
 =?iso-8859-1?Q?Tggg0Gfp0GE3VzbxuvEsHVawV1SdMhtCquF1m0BQ5EFBXHvnao5hfh4r+J?=
 =?iso-8859-1?Q?kb7we4wLadH7cT4N+KTAyh4pmhWN8qr/AHjAS4Bx0iRYEvtdengccDl0DO?=
 =?iso-8859-1?Q?V8clmwNfhtRlM+M82A8dR/wpM+xJ34jBhx+lk7FvXaIGNP4fg9p5ftrIrZ?=
 =?iso-8859-1?Q?ZgMdi3kKKvC+xhFdOP/sfCMoF0syoXsN+PPY3iLxCXCZ6WPAk3tJEud3Nw?=
 =?iso-8859-1?Q?BwTFLOZs1N5Vbgs2ouIFfjI+wd4nO0EBT7Kl6wKsGJxcV1rwB/39+ahj36?=
 =?iso-8859-1?Q?LLwE4FAOqw9BkRMiJEW4vBd9Rbz+d6/AD717X4pP/mUcSAsS5HVMwlkDP1?=
 =?iso-8859-1?Q?JWBhzcZkbssqAXm7UZSOzXRzuM34ZIcm/2CGmTSpwimkX4+gf/susKSuBc?=
 =?iso-8859-1?Q?XDUVDBvZCFIdDOJJjtFcR4HgjjeY5huZfuPWpRxdcJ3MUWImhacUAUpWB5?=
 =?iso-8859-1?Q?Sg8eFOhg8XQz/Eyo1GE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c5f938-b504-4661-96e2-08dd524eceff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:37.7599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvUGmR8IqFVj396tvD4vbU2L2pgkM1huAHA2TRwHuIDvsOnXXvC/HWTrfgBwuh/MvDqZNWSXqOyG+OdQkW+Z8zEnEoukssw8sDVcR2Wvpl74gIVWvCIxUMZFELKhj14n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
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
 hw/i386/intel_iommu.c         | 17 ++++++++++++++++-
 include/hw/i386/intel_iommu.h |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a360119fbe..d3772d8902 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4202,7 +4202,7 @@ static const MemoryRegionOps vtd_mem_ir_fault_ops =3D=
 {
 };
=20
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
-                                 int devfn, unsigned int pasid)
+                                 int devfn, uint32_t pasid)
 {
     /*
      * We can't simply use sid here since the bus number might not be
@@ -4719,8 +4719,23 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus,=
 void *opaque, int devfn)
     return &vtd_as->as;
 }
=20
+static IOMMUMemoryRegion *vtd_get_memory_region_pasid(PCIBus *bus,
+                                                      void *opaque,
+                                                      int devfn,
+                                                      uint32_t pasid)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    assert(0 <=3D devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    return &vtd_as->iommu;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
+    .get_memory_region_pasid =3D vtd_get_memory_region_pasid,
     .set_iommu_device =3D vtd_dev_set_iommu_device,
     .unset_iommu_device =3D vtd_dev_unset_iommu_device,
 };
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e855..08f71c262e 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -324,6 +324,6 @@ struct IntelIOMMUState {
  * create a new one if none exists
  */
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
-                                 int devfn, unsigned int pasid);
+                                 int devfn, uint32_t pasid);
=20
 #endif
--=20
2.48.1

