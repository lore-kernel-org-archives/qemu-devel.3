Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09107606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=EmbF53JB;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ePYUvsk3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzLu-0007OD-4j; Tue, 10 Nov 2026 22:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzLp-0007He-A7; Tue, 10 Nov 2026 22:50:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzLl-0006Rk-KA; Tue, 10 Nov 2026 22:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794369017; x=1825905017;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AR8Go7Qn8ueSigWEUpabU9UGzEujddD4SoGDmiYB26c=;
 b=EmbF53JBHLY+rx7UsL5Pw1SLMTHVOZTyel5upCKIk3Oj2SB8OMn46Kap
 mehT4jpo+vIKlVvmkkp23vfnwHxYblIl5XeOmdrORrCTpJKl1MpXWJDP4
 dJlO2HQBa2t4hyx8X1sqfF2FmmeGzIfkauebIoclidLcdu7CdckGqFWrl
 Q1ZMZwzVLgWlHkh7deTi1x+sDK/ftlgISHGBcDI+hGrSvWOvTI4ZYisOp
 iXrFxzDt++RfibzIwMUwcrKVkWbqYu827y192e3Y0/mNJ8hc1V6fZpYnA
 nDq22y1IDJWJWywb4xGPw8QVceQ9VaP5hMvQByUr+mcPX5uRJXTEYTwGb w==;
X-CSE-ConnectionGUID: yqdV3J2yQW6mNF5q7YXzQA==
X-CSE-MsgGUID: xKsT0F8cTeG9DFJmG5UYaA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="161572663"
Received: from mail-northcentralusazon11013009.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.9])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 11:49:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJr5akAgM96bE5w8A8o8UaLxtU9kMlT9LpvQVIMoAR3QfxG8OM3XV9eZShnP3Rn+k0W9wsnMpUBw9NWljFcI6hb2ddfrXS8+B78Msj/5CzTvrZLbOQtZuq5DiY/Yc/34mesH/HhKUGv3btxUDuESF/dkvhG5FTiRnfjea2otb2EFrHdGn9XCaJB/etYx4G9W9Bee3/1i3m8QcKlNrUSd0wRKKdCaLoeRqNK993Rg5G271OwgJP4+vBpwGCY2TUdUAjpEWHvx1tIRNUXsrxpp6sgGX4p3JuYBeEJnZFLfd6rij+KpeG1vnm3zrwwDibfFfIXhJIA6CslHi8Dnt4oSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR8Go7Qn8ueSigWEUpabU9UGzEujddD4SoGDmiYB26c=;
 b=i5LVD5fy/Jjfwbz71iJjsOda902Xh1wPxP3H5fg7wnoYSqydIT2tlyOWDCKeB82pcAxBpMYn3l2PuX9PLK543c+QNAF02m6G2XX2cuGGMVR+v9du+5YaxzFi6Umg4Me2cnMD154bsHhVUbGUt5tC9Xg0o5Uq0auHbOgi2R24l/numeJuJLI9KgS1luwmnWPPevBhfxrQHHhbNTUGSNX8mJ+dYK2Tkq61qw0DS6LyJUFtOoaCk92W6uVogUKufKz9XoM7FzjiQoz6dydTs9cWGINviTihus9V+lCekYceGalf4YDz3KOAsI575qDZGkdBwSPL6l83mrQATwPYc/esVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR8Go7Qn8ueSigWEUpabU9UGzEujddD4SoGDmiYB26c=;
 b=ePYUvsk3K4MKOxCJdXQln6v5ETNu6slfQS0ja7K5CDpaHim5l0v1u6qSLk1lIwSPENyQGicQvZK7MNALwl4WbH/IZJog7UODB8AP+Vx90KPtnJCsfe8WrnIHD11tSrq4WI2LPlSJwdfNnVZnQXGJu8deEfMsdM0WLanp90VSu3Q=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH0PR04MB8280.namprd04.prod.outlook.com (2603:10b6:510:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:49:57 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 03:49:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3] target/riscv: Fix incorrect MMU_USER_IDX value
Thread-Topic: [PATCH v3] target/riscv: Fix incorrect MMU_USER_IDX value
Thread-Index: AQHdZbxddLqOpAigtkeV6z5i9UgwUrcoU/SA
Date: Wed, 11 Nov 2026 03:49:56 +0000
Message-ID: <94566c689f28091c7ef527091c7d3c075804ac37.camel@wdc.com>
References: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH0PR04MB8280:EE_
x-ms-office365-filtering-correlation-id: 2550bf3c-1796-424e-ef99-08df3fa6da3c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|10070799003|366016|376014|18002099003|22082099003|38070700021|56012099006|261026140227099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|11063799006|261009223027099003|10067099003;
x-microsoft-antispam-message-info: BJ694EVsrUHV6pcUobPykb5Orjd57ZtuZqNl9x0dcLL/WlcF1xryKjzEJa7g3PM4BhRMs0VkJickruSYNgd72tzKBR6Gsxr6Gct6dLuLc9Of9wHBD106gJ9ebdVFkwgjT3Z73N/1dN/AZcwsdz7t1ymJ0XlO19J4v7b7OwBmy4PFlrTpLtZ1s5GheYTmCGGp4SGEQhO9uIRvxHnSBa7pOJdKIkBlzhZWrKJe+jUaSJxVBaepki3akUn6cVoV9iB6tl73Q3x2i/Q/26xs7KfGnBeqyNy+jwUXvzSvLB9d5FOxAU5UqIaopDGctG1SgXjYSvwcU0DIeNvuIXwV78PPpUTwuHNFcOteGLPRp05gzcl5vFL8QH9n85oRtcLCNsHfEmwjljtDTkwIXNPVuXWLl7vGqVEOxMSnqfFNCKlJy9tkbmnXq1QV6yzi35a0CVKHfYibkTFkNit7X6Fk3i1MpuGLcP93TfgNuddK8Yt2iD6Gg8l2v8lq5RBwss01rgJbM26kipSna65qzZzvhAPbS2aZ46SQtGC2ILQ2+aOqD8M2CB/54apO2zN8RQOQBcO9Rkztz8RjtLy3DltddjCsZTpUvcUpqQYIc4I3w6QhrUQ2n73rWCFC1hVa4sNV0bEoy6FvHhRmyXV1+Q0t6E8968zzELvksK/1bbC7QdHgpnc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWp2TnFwK3F4WWRTOC9ZdkpVNkhaaTlQNFNNRTZHd0V4NHdkUk9Lb3VOeS9q?=
 =?utf-8?B?djRsditGbGR4UHBFQm9vRUJxSkh2M0drR0NwRE5TSzZxL0RZcExtajluMmRD?=
 =?utf-8?B?OFFaY3cwSzFyeC82UEZrdVV4YWJ4SWQ0N1JvclpRdDYvbW9wdjVpR3Vpb3pp?=
 =?utf-8?B?OXUxWVdpYVFxa1IxU3pobmVEMmltL0RmN3E3VWhlUXBEdUxmZWxzVW02NEtD?=
 =?utf-8?B?YmtzUlR3NnlLZStnVkdHNStsbnZtaHJpZnhhVFF2Z3dWMWpXS3NQRHZRT2xO?=
 =?utf-8?B?eW1jQUEvYUcyRWd4QlVpZ1E3b0tjQ1p6VjNBaDYxZ0xPVTN3SlhvelNROThz?=
 =?utf-8?B?VVRpRVJoNGRIbnJPSjZtenRmblpvR296ZDNFMjhPMjZBS0F2N0ZVZkhwci9N?=
 =?utf-8?B?a2FSMHJFWHVvcWt2ZlNFeTN1OE9MUTJkREVrdjNHeW9abkxiZUF6aHVTYlU0?=
 =?utf-8?B?UWViMFZSSTMzcXFRN1lFQUVCdno0bHgySm1sMDJQK25qUWJyWW05OFptcE4y?=
 =?utf-8?B?KzZYUEpDa09DQ0Nubk9aaUdKenNMK05oZS9sNTM2MkRmOXZDTlNBbjFkbXVp?=
 =?utf-8?B?UFdNcGxOMkg2TWRXcE1RMVEwYjNNbzZJWFM4b3lPUVdrWTVWczhzZWg4RmJ6?=
 =?utf-8?B?WjZESkF2akEyRUppSnZLYkhhbk1FenBIRjBXQm0xaVc1RVFOTXJCUkt3R0xi?=
 =?utf-8?B?eDZUWGRTVWFzdzAzWm1zZDdaakczcWp3bVNhVnIvdGhRYVpocmloMmgvQTM2?=
 =?utf-8?B?bXErSERTZFNwREhmOEZMTjVxdUhsSkhtSVJkM2R4VmFiRi8vdGVGcStXK1pN?=
 =?utf-8?B?TDJjaWhTd0JSRmNVakZFY1ByTkZ6YXNYWStRTTgrektRdmpaMXpnVEV0NUlB?=
 =?utf-8?B?Y2JsYkl0THhnU2FRdzkxN0Rub3JMOTlIQ0MyWU5DQkRIZUdNaDhEVC9lMTYr?=
 =?utf-8?B?bDdtc2VCNUpyS0lxZlEwWWNVZ1dKR0hBbHBMVGcrTE01RmQ1ZzJzMnlrRFFE?=
 =?utf-8?B?d2xrZ1U2VUpKQXlrRHBlUWdIbFBJZ2ZWRmFqNVNIUDBJazZ0dXZZNG9QZHg5?=
 =?utf-8?B?R1ZqVUprUDRFOGhaM2llUXJEcy9ZSXpMTTZ5ZWhpRituMk1qbWphMWJ4aGsy?=
 =?utf-8?B?bTAxMVNtemZrUXltOEQwZUxKVTFzWlhNNUx4RmozVzlXMm1wZlRPbUJqQm9m?=
 =?utf-8?B?VzYrS1dHZ0RJcXAvN0p6aDBXRmpoeUNkZEFTZWR1aEFkMitqMHhhdDRpd2U4?=
 =?utf-8?B?RjJpM09aUkZCV3ZMNTV4eUpkdnJXUVlLN1k0Zlc1UTU0aE5TRlFEY3kzdDYw?=
 =?utf-8?B?ck1LK25IYkJRdThpSC9tOUxmWEpqS0pjMVBlQXRHZ0xicUp2OENxTXZoZVlW?=
 =?utf-8?B?UHlCK2k1OEtzYVFpdkFWNTBwSy9uN0xZSTljaklrZnhvLy9hOGFrVTRZOHQr?=
 =?utf-8?B?UE10bkIvQWhnai94T2FqZUo1bHdLTkhNWTRnWExXVDMwNStUeHJldGEzZXFW?=
 =?utf-8?B?SVdVYkFIcnBpT1plVVBVd0s1aTYvZVJET0RHbGZEaWZMdzdZWHUwYkdnMXFu?=
 =?utf-8?B?K1RYVFFjOWZaR2NoR1NrZlQ0cjJ1Qkt2NzZhVTkrNWRsWG5kUnVrYncwSVVX?=
 =?utf-8?B?TkcxRC84S3B3ZXdxdDRhQXZOb2psMlZhQzFBYldDY2FOZjFQMmdhTFdBeEtl?=
 =?utf-8?B?K3pFdmFTNGxhNm9yaVlSZUducENHVVZsRFZkUXhUV1dwRkd4aHJoZk9rVFJ0?=
 =?utf-8?B?cnAvVDBIbmJhYmhxK1E5VGV1eXdHMW5aUSs2TXR2OVJOQ3JQNGVRc21Ueldi?=
 =?utf-8?B?WGlIaHE0TXRvQ1NXZG5VSGthSHlRWGVTN3pucDZpMnRzUFByRjZ6S3Evdkpu?=
 =?utf-8?B?RWxTcVFveWZjMlY3QzFKYThFcXVVbCs1OHZFNjh3WkZ5YTllL3o5OWtyeVBM?=
 =?utf-8?B?clVCY2diNThvbzJuSVRnMXEvb1p1VVZEWHMvaWRPUWYzZlBiYXRDdTlsbDRs?=
 =?utf-8?B?N1JKNFdWdWY4TEJweG9lM3FYQXB5SkNMa211MlpEd2Zia2pYamtaTzNoZEcw?=
 =?utf-8?B?SXZmQjB4a0FmdEVDYnRDZEtTWFlydlR4N2EvYnRxbGYvTUlpTUg5R2tBNWUx?=
 =?utf-8?B?NXlNaG9pWXNaUnh4RkF1TVNhNWdvUmpWZkFmMHZzZGt1NmxOMmVLdysreWRo?=
 =?utf-8?B?ampDcXYvMTh2OHV1RytrMVBLeHREYTBlUXc5OFplRFJhL2lRZ2FYZEo2Mngz?=
 =?utf-8?B?N2xrZlhkRGdKNW9wTGN2T3JXdUh0bDEraldzRldzSnppTlRPQVZZT0p3RWk5?=
 =?utf-8?B?bVdmZU5ERUlEcm1vTjB5bEM2bnE3Z1p3cnR1SFJJRjBacnMwTEw3czNxMmFQ?=
 =?utf-8?Q?XxA8LuwyOGW2itvDt7BI5PBaDnhs8zc1S4MRYVmo8Dl98?=
x-ms-exchange-antispam-messagedata-1: mhRjP65orR/OythnNqdGIDl4LhxshpoGFC8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC45DBDFEE64A4A9199FB554B85C50D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lFisX8dVetpiTe3qwUIrSPOeezEv5wPcM8Perue9xnzbdrocDPzNQuBDIik4RAZmTvL/1cDzFRGGSe6Lhj6gvB8oMs9Nztw1qisfO3OfCdJqoJwRHZUNIL6QhWqwW8y6NvL9Nh1o+UHD0CSErkcRu8SUU8nGDFlHoyU0Jw/K8AOmQO9WKuF4zKZue7dgCT9/47VfUvAMYCXlyh/mu/6Rria3gjS2wUyHQo7/xY8qB7yVd7lV4DM9LVsncKQ1LDzvGEFvQ1IBFVspHF8JD5ZMuATFUBiMEm5v/eJ2yPHNUmK7/5LLFF5HJC10uaoneKZ8TQnut7QkN2n+qYtOJzfm6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XYyX8M8V9C3jbg4B8AIU5vm3gK0PfGSOfIdmb4THWDvJCxuViQjWVIHp9G6MR31Ptg4M8a7cqczjACgd3pR1t8cxXLHVbZZFJBrW/FXkOoYRS2loH9BZStiVi3Fe7COicweeE8J3+KvpmqaucZwkjmwmoLlwMK9vD0SDbMAs1XVJtXczO4L0V3PYJn3XtMhWS9YinKRDhKaGhYR8xJEhq1349wEtVRkxnjI1zybv02zTh0/0o2pdTzW7OxnIbDpYsulytmu0Um0fU3rqM6Mo9mnHZMQPUdcMcLVcYkXqZlWGp/f8pphxV2Pso2Fd+OSocu8TD5ae9oxStN555CPx1elO/Es/IGNw1aPmW7fzUGkatf4p5BuvL1mSUeVuZp1F2Xd1ium1hYDtguyMsveHqWvV2h6DDOQkP/fSDYqTz2CiUL+g0jvnHyFRQ65ztnM/eB9radxFunoXDyyjiJuFyCGwtcaoCl6pXEk9RyGkqmO7rGxqoKJE3GVHp8m0uRGJ0wyTfau1KAEUDfmS/DulHYCWBPJSeYNXzeAqN94OpRMQ9sttG9NswXT8Vu4FusE9zPVA2pyZ5+3BrWK6SM+rvijwGa62n6YLS7g6j0ZuEg/r4bKhqjbgEBoJRlUo4YzG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2550bf3c-1796-424e-ef99-08df3fa6da3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:49:56.7774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vno1AVCCoKsLwU3r6Q/9lfhfNItGrb7y91HArc1m/P3E5+VP7un5LElqDYJx3rDAJ6UVB4xLWw6WBE3f/kug11rxiCNCA9wgwEPVBHcZljk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8280
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTEwLTI3IGF0IDEwOjM3ICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
TU1VX1VTRVJfSURYIGlzIGRlZmluZWQgYXMgMywgYnV0IHRoZSBSSVNDLVYgdXNlci1tb2RlIE1N
VSBpbmRleA0KPiBpcyBNTVVJZHhfVSwgd2hpY2ggaXMgMC4gVGhpcyBtYWNybyBpcyB1c2VkIGJ5
IHRoZSBnZW5lcmljDQo+IGNwdV9tbXVfaW5kZXgoKSBmb3IgQ09ORklHX1VTRVJfT05MWSBidWls
ZHMgYW5kIG11c3QgbWF0Y2gNCj4gcmlzY3ZfZW52X21tdV9pbmRleCgpLCBzbyBmaXggdGhlIHZh
bHVlIHRvIDAuDQo+IA0KPiBGaXhlczogZGM1YmQxOGZhNTcyICgiUklTQy1WIENQVSBDb3JlIERl
ZmluaXRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFllY2hhbyA8d2FuZy55ZWNoYW8yNTVA
enRlLmNvbS5jbj4NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQN
Cg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBLZWVwIHRoZSBNTVVf
VVNFUl9JRFggbWFjcm8gYmVjYXVzZSBjcHVfbW11X2luZGV4KCkgbmVlZHMgaXQuDQo+IC0gTGlu
ayB0byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAyNjAz
MTE0NC42MzE5NjQtMS13YW5nLnllY2hhbzI1NUB6dGUuY29tLmNuLw0KPiANCj4gQ2hhbmdlcyBp
biB2MjoNCj4gLSBBZGp1c3QgdGhlIHBhdGNoIGRlc2NyaXB0aW9ucyBhbmQgcmViYXNlZCBvbiBy
aXNjdi10by1hcHBseS5uZXh0Lg0KPiAtIExpbmsgdG8gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAxMDcxNjEzMzYxMDhSYnZnSUVKMXB3d19mS1p0TXJlRnBA
enRlLmNvbS5jbi8NCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5oIHwgMiArLQ0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPiBpbmRleCBiNjVk
NjMxOTk0Li5hYWYxNjIzMWRlIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCj4g
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+IEBAIC0xODAsNyArMTgwLDcgQEAgZXh0ZXJuIFJJ
U0NWQ1BVSW1wbGllZEV4dHNSdWxlDQo+ICpyaXNjdl9tdWx0aV9leHRfaW1wbGllZF9ydWxlc1td
Ow0KPiDCoA0KPiDCoCNkZWZpbmUgUklTQ1ZfSU1QTElFRF9FWFRTX1JVTEVfRU5EIC0xDQo+IMKg
DQo+IC0jZGVmaW5lIE1NVV9VU0VSX0lEWCAzDQo+ICsjZGVmaW5lIE1NVV9VU0VSX0lEWCAwwqDC
oCAvKiBNTVVJZHhfVSAqLw0KPiDCoA0KPiDCoCNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZ
KQ0KPiDCoCNpbmNsdWRlICJ0Y2cvcG1wLmgiDQo=

