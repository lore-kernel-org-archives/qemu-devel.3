Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E776FC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXa-0004bL-8Z; Thu, 27 Feb 2025 05:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXY-0004YK-KQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:53 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXW-0005pC-N2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653691; x=1772189691;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MFzdMfJRvzeRB8KN3cYhlmgFrM88PNKvAD0/WZFjBos=;
 b=BkMfzQ+aAf9ovwvfd/UOCplD3QpexGoMwgmJiOpTDBdlFmUDeNqSM4sA
 1ReQb7V/8ZWlaCrPkgZrmdwBRToNcGnf+G/StxLnFgbOiSETFehmNtf2Y
 GsYLTvZnpcqOPqd0xcy7+zn2y8Htg3PQ2Q/aC9AfxQpNYZSFkHtZIa1lx
 0ms93CbYGLSdZrfvh+mgWjFXlAUDW8pZsV8wKtTMesRPH8FmAvTL/1p+i
 uz2g2jM3WEwg9tS/VuJwl5eUWO15ufBOcLR6nX1Rb46goeOAXnAQNXkuN
 46/airXTNqIug/KWXHs6HAKN3IuwQHo/cCoFkPwuUAJUjIcRniuY2UTCw w==;
X-CSE-ConnectionGUID: 6LNfxTgnSo+PJtr9gtz/jw==
X-CSE-MsgGUID: hPWD7/qjTmSu7tQ0fQnnBQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331842"
X-MGA-submission: =?us-ascii?q?MDFSuJsID7FS2o5yFRpzQrqqYq4QdsUi/ozObK?=
 =?us-ascii?q?VvvEc67lDlPHYoVgRbuoL7gIyi90GIrx0mc7Z48TrHptNKbNcypdAf1G?=
 =?us-ascii?q?2HknOVwsE9LYRxWr0tYmKoxkkSHT/aoM2RGfei0aL89mE0ttFguTAbj2?=
 =?us-ascii?q?Kan937t93jZVvSvVc9lEHrbw=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwSShu8ikxIXDoyhP7UWUfk0g7mwRY1/Sxlv7ZTCSfirObUPPrlbRc6bSX+tca06LHeU5ie6Eat2JBCW5fUeJtpF4/zhXWrZkPj2lU8MIoyIThFJwzfKGpApl/nvM1xqjgE0R+Z3+39ok7S/7AXIsnmpMDH0hL2zsTsNBYY2BRjlHWXS2W+zDxCwPNXxcAV1sxZqARxOZ4b9F0iQVIoLcAQriHFNz8K1+UNy85amj/vNTyxgrmck8cPsHMjqqM8sC9rEzVzMb9rRNwl9s3YkBe4SwuUn83EacWgxwftmJE42Q/5Ayg2yL12bvJG/FHG09BaBQpxho/AUdqQHV9LYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2iXVLFV52LhyndbqvldJ6WUjzWPJC+MCtn8QEwVLZg=;
 b=VTKyIbnRejOjbtjel5N97ETGYh4kAr+0vo6+YssFd2FdRH2Ym0D9dFfqaycpHXE8MZa+TdJZNTBfxWGI2CF+MPpXfJ3DP43ABV9BbmyZbJowNHGbzmJau0EKK8g/6tPDbjrJlwxqQ7pkpcNHO1/6RAQQjN+Ow1vWowqhKiVAopLKW3DFK0+A4cM2A3AoJz+yLrE+mczGFx3sV+6ZgQQqbjo6pkNHJ1wlXtqXzb/PzDCyCp+OblPIi9gropDR/BoMfuwVT5moWSOu62+YWH8o0FldkZ4qVLY1PbtFEIn4RtPoGC8eCgeV7zNqcntcfWEKtGqHNR6Ci8Zhzdqsm1L3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2iXVLFV52LhyndbqvldJ6WUjzWPJC+MCtn8QEwVLZg=;
 b=Som5GbyzqVb38tts5RAuRWbgeLjk7/TsSDoFNTA8TCXxwNIJtnG6x3aQXqHC9fJnFf6wkAenNhlCHY7d1vGzbwwZJftJqkS9HTZeOAlP0M2OeaB2WK26wdAd/RIAMyw6pghMPd//6YmrCJjdqokAFlrWomkEaVUcvn4oceOHzIQeCMeJ8owoDSHGoCxqCX0VjGjEgyXI8Nw0q5TFg3JN0Zy/WjNi6VMKVlm3GZP3tqgu1oMBgNAR4Y/sb9ZjdcTqlD4DVOEzBwmNGLhtz1AwkHgV9ql/PCKGQbVeJO0Rxc+zBIiePfSRR+4+P7d+AohP24AI07UmKfja4ZxJK3yCpg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 10/19] intel_iommu: Implement the get_memory_region_pasid
 iommu operation
Thread-Topic: [PATCH v4 10/19] intel_iommu: Implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHbiQYCkIzSXfWcU0GCACeeqhivIw==
Date: Thu, 27 Feb 2025 10:54:44 +0000
Message-ID: <20250227105339.388598-11-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 45a3a1dd-301a-457a-3b3c-08dd571d253f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8wc9tj2PIZiJqPr+SoiaZQhAhgTf/VjvPeTRXPVct9uDFFlmGd36+7eXNe?=
 =?iso-8859-1?Q?YssHvkV/iuAXQNKq8G8ws5vZ0mDiRGlLnAmAURKVaE2Vi6eDCSuI9hvTJx?=
 =?iso-8859-1?Q?P2zzrd2HT2c0HTVrzeS14+7wvnZg5jALmY6D0aezCyX6NQgqqCeNEBgDS4?=
 =?iso-8859-1?Q?oqyovRvmt+DWWZt0AaZ7GGBK6W4zE6+0G6aIKSnc7MslO/lDkTLkjFVtXe?=
 =?iso-8859-1?Q?z+kYF/p5kPQjVAfCuhRU00+xVe+k9IVkBLeuHgYC/81S4+VMv8IVfLeEZj?=
 =?iso-8859-1?Q?LwVPQVk5XZakEZ9h1jcOYW/+qY09jLPTfycekNwk6RHNqG6E2TX4xl3s4C?=
 =?iso-8859-1?Q?IUUW1y90PjrhuR+bzpQpe1wmkusTjVrz0yPv3dIvDXdfOVQGtQAMvkz9EM?=
 =?iso-8859-1?Q?O0Y0oAeSmpgQ0wKsxf/a08JsTclZle1LqQvhGBrEWZtZpuUs8/xVUNvwST?=
 =?iso-8859-1?Q?WsCef1njbOouJ7bkPFooyLuyiAaLmX4orz7Xx0x82S34/ZTnjw5uiYzHCf?=
 =?iso-8859-1?Q?kZbpIFk/BEk1DKAopQjkvf4kHEe5O69DFTK6Te3r5jBUpHdFNaiIfuB4k/?=
 =?iso-8859-1?Q?GBjqOsNWZzhdwIOGouN3nYAalPSlaqalqZAhwNx9sIgK7J4Kfrq5FUC8CA?=
 =?iso-8859-1?Q?Le+lQLZOZxd8WoP9feJBhLusqJPt7n1zVwqEVKq185mdZq2BbTyeOnOUvx?=
 =?iso-8859-1?Q?sZGQ6mMGQZg2qv5wwJXF+QL6zdyY2JETlAAvFY7qnP5FNjFmFde3Ybg6At?=
 =?iso-8859-1?Q?5IbevnfLx5I85KfNOV/CY0EAO79++nTbWXuTtA8fdyo83UvKduJQARVbZn?=
 =?iso-8859-1?Q?j/hT3Jg7f6eOci7+dFI907WHJY18YzXkQEF3fbtM9r4PlHsFlflPNz1dG4?=
 =?iso-8859-1?Q?rLXbqgzlDRw1cOo4s84f+V4EQDmF9usD8ypzDDvbpiStl2hzw3OnI76UNU?=
 =?iso-8859-1?Q?YReNy1L4tQh9Ys4k/SQpIGxfoP/HKzuV8/zKMj4YbZfiBEhRRsVOVYQpgq?=
 =?iso-8859-1?Q?nef5Mh2F0p6V+QYMjAsbaZSEao1KaxWBJmXLDsdfqG/Q6/YanHL1eC6kQQ?=
 =?iso-8859-1?Q?flLBaT7Wa/efflPf+Re1S7CRO1oixla2DhvNH/YSKe2tJ1qY/s/TKJP71K?=
 =?iso-8859-1?Q?hZRhJxosHFT8UdoBfrKcuNAOd3WMBW4WuDI20xqWQmpzaCo9az1pfienHJ?=
 =?iso-8859-1?Q?bR9IKIJNDrdF8Yz60MNrHfHx83FwtUUiG37X+KD92PQtxBriD4qSb8vK/Y?=
 =?iso-8859-1?Q?OrpsrEsWVP9V2cq97eUQp031uLMnLO+hJRqsIz64ha9BWYy++XfgjdxDUa?=
 =?iso-8859-1?Q?2NLVxcm3lMYHc3m9spGO2LzUMZ+OXSkSZ15ZQWnuMnHY+MaiYn+6f4/JwZ?=
 =?iso-8859-1?Q?kyadK7z0IC6SbQZaH2SkiYhsasor2NONCHDKE5ml5XzLPpxYD4QBwltr4Q?=
 =?iso-8859-1?Q?Fd0QgqwRR1dxugf3HLJR4rNh+P9rjUZu9GL3VTysfQHRTpOPRlJzhPy3X9?=
 =?iso-8859-1?Q?nfg9IUbhp2gBHdtBKc8/Eo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zdvwjddvyc6Gb/JD2TUCwOZfIKnQzO9EpapHzP/qjnYK4oUBjpt0yzWeZX?=
 =?iso-8859-1?Q?Ia7+l9eT9Z7OI64wAjbF/dU1F34JT69Ww6ZjoeA7QoyYT/Z5RfndXp2iPK?=
 =?iso-8859-1?Q?LuUU7Z4f+PH0oVSkWIfsNenejA3Y7au+GnMxDFJ2BiRZAQoCSjj69UyCd1?=
 =?iso-8859-1?Q?J/oNERZ94KM7zWswuAgbZgSc0uTH9nkjG/3GrEYaQm30aVtWvHNqzvgU/W?=
 =?iso-8859-1?Q?UgWd5YWAcCsEjy6ifnR+Wxei8IyGICyi8AqsMjOBVLQVhhVunVP9jE2XAq?=
 =?iso-8859-1?Q?gKGV8f6KUWHote7ey+7Yu+UrplnpznJDDR558CqQb+cjg54ByTQ8Ywn9af?=
 =?iso-8859-1?Q?pWpbt+8jwRDPr6Z2iAMNAwZcDFoi2I7XaA2rh/PZCUNfcbBe8sJsNBekif?=
 =?iso-8859-1?Q?u2t/XhyQBgQhMHshKv82VMxsOlRvef7nmgUZnD89NQB7zSPSgq5A6qBpyW?=
 =?iso-8859-1?Q?RHxtcXg8B1Sq8bBwdMO8RdUzlKrMnBqqpIadMTmXzRhm3owh91gHa6XuHL?=
 =?iso-8859-1?Q?zrF9KSZf7jqSPIJLwZMvll19OAVc5G57zIV2iTB24IprV3JtFYTKcKARli?=
 =?iso-8859-1?Q?zvdx14gFlhIqnKCH+uI5IUYWZfYQMhyvTsDbgppE57gZUMxKlJZ0EB/NUM?=
 =?iso-8859-1?Q?PDvBE4PcglrwUBuC4fLm/VP0NuFj8dGvn8D70C2VNlDw40anpUUFc7y9+j?=
 =?iso-8859-1?Q?zioD6tUSGn/mOFKEzSoEBHft+KSTd7ePqzThgU+xt19Jk9Jc3qHaEj7ybI?=
 =?iso-8859-1?Q?+wHRYShfddimSYcmfTiETT4gwYVHvQEjrVPMh6wFuoLLcE2rb0qghL/1iv?=
 =?iso-8859-1?Q?VCSBkAL7DqPYkSGh8UlPj+ZGGYpbw4p9HkAsPN6jZWPOGxhsEOAhoQADh2?=
 =?iso-8859-1?Q?t3hCnAzckmjAzRab4UF+9puv8uJxaKq73RwPwHekFwEbk7JxLVixyv4JuE?=
 =?iso-8859-1?Q?gVW10bciL81OI1BMMTTypfI5Uwneg0sROEUUGlpXWg8+ol8Wwcr//sZwEc?=
 =?iso-8859-1?Q?icmhkCxG4RiopAcIejh+YE2ukEtQVbRbLegg/sA3Si+SGBQNH01NIv8lsx?=
 =?iso-8859-1?Q?IC+dcvaHQahL6U0ZApJVRqsKIx9ItsdlMNfzw93gqoy8bQKN5/js4yj/pp?=
 =?iso-8859-1?Q?laK9EgTMWUQuo+SmntDu3z5UsAoua5hKzEzp5NkUyYuwjWGczj+vAYSZAa?=
 =?iso-8859-1?Q?CR+RdMJspRRnJvfJ1ORDbc+VtEdof+NYZY2OrVCz/6d2Kte1goiQ7TiryJ?=
 =?iso-8859-1?Q?kSgOHVFk7YDdv6H1+q2olYCP2yYtGLyPAKxafMNagU/zubcWK2sENdiMGm?=
 =?iso-8859-1?Q?js8/Lhq7CDwfLgMu8hGnp55Y27ifz7xajGD5N+q2a7Jfd2x0TGEB0LvF8K?=
 =?iso-8859-1?Q?E2Cc8bCOgv2Dlpj8rqHlCTIEIAGj6cV2gY6SMweiTvJ/dyXwyXxyZzYSJF?=
 =?iso-8859-1?Q?3ND/sFSs3CWB39QZRFYwKyqdBJrKVD1b4sP3ZFcGae82t01cEgApFjSVTJ?=
 =?iso-8859-1?Q?E5kt1ylRBBna78KWKeQJ1IjjePy8tvEZ0Ak0IDgbxkbk/zAIX26MbUrMhx?=
 =?iso-8859-1?Q?7Ho5QLNebSWcc+ZhUx2aPAT2utWo68MRMR/MJMTCr6XFzBSRw+cpo4dyAy?=
 =?iso-8859-1?Q?kldau3KkMXszX7Xq+E8NKDg5bn2fWdp5KtmZnILOAwrbtePUj4aMnF0VY9?=
 =?iso-8859-1?Q?Oeif3p7u7K+b5C+6rCw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a3a1dd-301a-457a-3b3c-08dd571d253f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:44.6789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzssABBRmKMeemdzsHCJ9J64B3AIHbQrY7Rb9cRAFD4fQpyFUy/jFNWQhG2UJAjNbE0OJBgK/d5RwdN3Ya69+PpPjwYSoU2AqM2/3gxfBanYBe4feq52zS9RJOiUL7r4
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

