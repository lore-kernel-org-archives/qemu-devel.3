Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425C5C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXb-0004f5-Ca; Thu, 27 Feb 2025 05:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXY-0004Y0-BC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:53 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXW-0005o1-4Z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653690; x=1772189690;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4q+FNgT9HVsk5swidj6jJeI6FoYQL+sITZhOOFRxzsg=;
 b=ty6HAKfbZWSBoU265FWhBE/GxOkEsVeTUa9efquAG6BfGiLXHi3uJOAE
 D5KhZzh9GFbnfcoHffS7fHRYZgHr5hnuQGGHTKNxaNnmEBekbUzrrpte/
 cVGzhUHnCggsuNHSVkUZ6ejpwk/xGIah3pPzFnmaaguAH8tXu3M1dchps
 FT9NuQPPvIrjeaiQb8OfAlj6eCHEyFqnprdJWUXdOk9znKDqJzjzD85Ox
 CkM2fowgPs8C/ONoKFbE0a0Zntk07zchMj3XUY5Kxh3LhPrrlSsvLjtHn
 47uA2IfjYNM46M0IcpnYsfndC9MMfK2qCJwkGOa6K1szY+PkLQ/zo7fzN A==;
X-CSE-ConnectionGUID: fdpYLv8uSYyYITgu8ymNKg==
X-CSE-MsgGUID: R55dHwtSQtiDPFi5wigcXQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331839"
X-MGA-submission: =?us-ascii?q?MDEgcuMEBEExrS1e2varPlpjCvUAjFaSipuTxe?=
 =?us-ascii?q?hDrd/AGidepT4stqOyLpPI5sshvgccEH3RNppBuhCyjPuKT6Dij+Lz0D?=
 =?us-ascii?q?colHt+UCwZsokbbxXbf4EtGU47jq0ZJk80WVZP/DXHmN/yDEPfc8R7VP?=
 =?us-ascii?q?Gl/FZ+eKDS4noRt3nNEeW4JA=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxOB+xMdxybSnvNKiJ4karfQH8t047GdC9FYevBHE+83guNZsY04RsAebcV6HbpoTdT0wl6snx5hvS6Vg1kNc8dDDhSadVMbGDKvF/ZKR07CV7UWzHSabDkh1PHpzhwK/rT1fY2l9Fm7U/7fe/Eq98O6gw9j/5a0hxD/ZU0Q+pLWV4nGhzd9xhQTHGddbEJIq6VTzHQYpjysKH0AZHz5xOjrTMnmslveDDi3oCK6eIkibDRsCiBi+RfDBv04z4b/dlr3qT/tFPbKIQcV5cDQby6gm7abh7qUq7I2n1VT0qPUNIyfml1Rv7hYN1T4czUsdJebJVjF0ixN3fgB/ER+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEmwoWOY7veZvqndImfbubbycqeBF+qn+7KqkGGtMWw=;
 b=nLNd/deJs2kcF+ANA8gh75xXGDtDEJGtP4387Qbj8l9b59wUa21x7DUFV2qUg0GFxlWkzw67PZkeJ/ByUyf2rbkSeCEz9hTXW81al1vrv2OrwssTXR8vNHHaUZCQBWiYDyhiVBb5uND5VZtuyO7JG8fxubMH++45Sq3A0pBb5DkZEYScFUHm5H3HCIbKHY87kCrU5HN/BBeeDb+gVSc7WsSSuMpy5qM9UavoHNFX1JcTVmHy8flG3EhnxzzLonjIvFtEe4Gna21becEkIXLhjAaw4RmAEgTjKIdypOR/1uh7QkLqOEoZBD4ccjKUfU7sQSxhNQvPeQEiW+cW+EiiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEmwoWOY7veZvqndImfbubbycqeBF+qn+7KqkGGtMWw=;
 b=XJdETQ29jUnSFV5e2sVapWYYymY62Y4bT0Jdz+qouKDoJgfbYpXIDspbiqcSG9XJCoqjYSSqsII3MlmdBuT/YX13UrCTsVRepYATwl5wM1c7xecOn97xx76Wglv2SyaoVl0GyP+xrh4CocZMeSsaDmUwKsfd9/shiPjuUY28fCI5IKzJPWvfM80j157ExIOee0qVOg//nVhAZJCFglnRPGnbPme3bzXxl2mwGtbTWGljDS65Bgg1+t6yTYFlA1E/sm5rszi4U37IimqQUE+hxRFMxG/aIFJZBHcWt4zKfvu9aTWWRvOL/c/Z8MyUyoHAO8nMb9rDwV6fIH0wc/lbJQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 08/19] pci: Cache the bus mastering status in the device
Thread-Topic: [PATCH v4 08/19] pci: Cache the bus mastering status in the
 device
Thread-Index: AQHbiQYCJoyp/p7SPEiYXiebYwCbpQ==
Date: Thu, 27 Feb 2025 10:54:43 +0000
Message-ID: <20250227105339.388598-9-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 4812b146-a9e6-4af4-569c-08dd571d248c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YWrAy5RkcrxftGVPfoUXWv9LgN9OTdAnBupP3sQGKbRBwmLfP1XJu4fSf5?=
 =?iso-8859-1?Q?GIRhBjbXy6uyOu+MGfBKnPLG635zTtU/mLQ7qOvqqT13GncBYWRoBSBH6b?=
 =?iso-8859-1?Q?4b54fQyqwMcMvy9EzmxthLHZ0AdxeI+Mp/3lnasjwPL/qQ0hFvB2zmtZed?=
 =?iso-8859-1?Q?N6J/4COe8lbsJDYRIqwtVou1vt4HkIVxxfHWzj5wZARLv+z8TpGZoijaq9?=
 =?iso-8859-1?Q?dTtrRpMfa6apGXt7H3R4GHni3Jvdh49t61X7VBMoiUAjCVVZaDtv+MdErh?=
 =?iso-8859-1?Q?CDNXrPaOYXl2yc+g+v1gEMWxa7wK3HCeu6N+91nv4FYbRfF84DcPycgF1R?=
 =?iso-8859-1?Q?/F5qCjJX52OBO85pzFPT/wRdvr9rN9+pXnE/xHJNessg5OMeEhvISF10Ri?=
 =?iso-8859-1?Q?j9RRj34WONTyfEXw379FrbdXYUewkZwCoNX6hRxrS2rpYVoiYz1InwEnT7?=
 =?iso-8859-1?Q?cjiodW4BMKkbw79vMNVFh3XhASCUW/qoH0DJ4igP1P0j2dfFSdpkU7flBc?=
 =?iso-8859-1?Q?ADJmPZCBazkJvva/wpY1aINkWr06CRg/BsW9z0/tqEJCzp0p+BN1du7DSE?=
 =?iso-8859-1?Q?wNwwgV1v4hRyMaV3k4DxKw0t7Xfv4RhRZFTiRP15ZxH8gBd4fQT42XVGUh?=
 =?iso-8859-1?Q?tOzrXjXyTVqXmBv+LyGkPOqnCz7D69wruus0PTWNTmwTT0ijgfmoImCDSj?=
 =?iso-8859-1?Q?M3lgV8oxlhKL+dGMtD7njrLp2Amr5dbspnHxli6u2cXGquR6Thr8Y4u80P?=
 =?iso-8859-1?Q?F1/wNbcho2bF3Dvgzw6iWEyztgKXKGfFZ+ovw5RucCdxwky2pSQFDvp+sM?=
 =?iso-8859-1?Q?kC2NV0VR6nyIl9PpJ3fXrxihUSbyfxQm2SZcPbeMRII+uhu6imLzGO6Ml6?=
 =?iso-8859-1?Q?7klnd/nGESHwJZXYdsJVq6ZSWoeD3mD5Oml9mgYJhjI/99In5Cvm7Mtsom?=
 =?iso-8859-1?Q?g0PuYkeYd5ELnPt6SU7FS8U+gFSrI/6QhBIU0Tl4R0griVw8VjaroPYy1L?=
 =?iso-8859-1?Q?6uzzjoUsOw56351bi4Gui8Ta2rrwFSxOHMyUPvbe5p9oUQ5tbqxrB5f3qH?=
 =?iso-8859-1?Q?QUs9sUHoK1/xfrq00+nDrvaR2SexhfH9p1Ntrs8OBYmZ+iTcyjy9vf2pxr?=
 =?iso-8859-1?Q?QXqNxas71joVvqc0jcbFjmm+seDzyGXbYDUUSyn5/Y+iCln+u7m8FhnqeB?=
 =?iso-8859-1?Q?tJleLYoR/DabCGCWAX2MU7juX2N+D6wEvonknrJUpLVP5yJMcCMyMLi753?=
 =?iso-8859-1?Q?uSURUHzRu8d0bAEAy8MZRU4QuwtriSLncrAWnxIsEmv2EScOjEjV9UgqLc?=
 =?iso-8859-1?Q?azd5CMJ0y2P5s+sYTgOfyqBQeQG1sZPeTWu5H6zeX7weZmDMW7H9sJugsX?=
 =?iso-8859-1?Q?8tGyyo4u5xH8TaLBRLZJy+acVy5tB7toRd+gkxznF8fvHWm0ISWHd2u2JH?=
 =?iso-8859-1?Q?bEYS6+mq8UzwNED63YP66hysagsWAaKNI2sWtANrlX0MI74K4TVchRu57P?=
 =?iso-8859-1?Q?HBSaodAjMFhEaV4aOTynHT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dbA0A2HpiNA9vooSWHiMsE1z4j1m+SIi7c+vn+1DLG/8owIorP3P1jXCom?=
 =?iso-8859-1?Q?CnZ4ziDfdZeL4dWZ6Z01REJqGONIULdXb3thMY4RDQj94oBwgXy4Lr/7V1?=
 =?iso-8859-1?Q?9B8SiD4aTAqy/eIo3eq/eN00KrGHmGWJzg4wNjsmJrUwJaYpWH5iz8LVvT?=
 =?iso-8859-1?Q?rEU2KrOSYf8umtjJg8huZm0C32xncB+2sLWpSgRgKb6sXg5MZqKQ8MjKlW?=
 =?iso-8859-1?Q?PFvAFcAryGIblXpFz3ZJGNxIT7V5JUFR32DiW9nf4vDloYffZ4H2HtHq7R?=
 =?iso-8859-1?Q?U5JHE6Ohp/1fcnGJAIHpHFMFXJxgcl7ZhYltF6LXvCJ3wbRjADVFSMNWwR?=
 =?iso-8859-1?Q?Crqhds0maNSq538dg0H5qPg4EayZ7Of0T0D8x7xaxYGdc8iJeTEfVkBaGf?=
 =?iso-8859-1?Q?5t1qO3AMwihcNpcsWLQM0gI8JjT+BJ913eL0v0XG52Daxpmy5Cj1d7KwYo?=
 =?iso-8859-1?Q?UR2KadJAFbbOOBtXt4Z74tSY6k2GDVF8W1jdDdXFeQ1xm/kvYvCh7M92NU?=
 =?iso-8859-1?Q?1/2qlHvJ4mfjsZeGDfmUS44sB4jsiwftxYipjKL25lAUsMsMLqtQhhjYIF?=
 =?iso-8859-1?Q?tJMArwBTgB77p6cpFAZ0z1rGDaMwTU7rusVAm7RkRGw+KIA0W/NLP8OMiG?=
 =?iso-8859-1?Q?7pCpSidJ9maeLxGLZEEVEOdvIB4suG1MKfzsXcEfak7vtPlMfx2wt2IvuG?=
 =?iso-8859-1?Q?Kkk7ohXnhNxcSfq0QS0Hl1c450HfI8g74wo5gYLGNv4YCKe9XGD+Gy/Dx+?=
 =?iso-8859-1?Q?ti9EEfBO621pQmHWn9TnMqYr1sHOtRWrE0+A0WVJEeM6iYczd5rOGc10qE?=
 =?iso-8859-1?Q?CtVV5SSNQgt3Pps6P43mUC2vbei+mgbyzxOPamJgd8NycMrBqHbLu1Y7jP?=
 =?iso-8859-1?Q?p18tjFE/yy45VicVi4n6FYyhqxCnpsf69FWF/BF1M/1ALXdvQqZvAArnZi?=
 =?iso-8859-1?Q?P3PXoXmsYpc1cy4PxHuxOwMTIFkWpeBT8pDB0ra3AsZLyNf3sik/ffomrq?=
 =?iso-8859-1?Q?r35Jh3VRFsnRNgowaX2xI+RjhG1m/tb+jU5kuOipip/+1qy4CfLLVNkTu9?=
 =?iso-8859-1?Q?Ka2h25ZVfHk+Lv5L6eML/lS7zjLoAMh50Z4TzPQGZPjSvVALG7AGsw1shn?=
 =?iso-8859-1?Q?KvYEqtbx3DXP95r6Pw4aMSKEXbfnGQwZx9+oRjMJOqQzRXMxEZf0YlKMPH?=
 =?iso-8859-1?Q?ddX1Dy6pGybTMcoMjYwRb+XijT5TpvKRiVGaxqJgAQxH5n+mpvfzQ+A9gX?=
 =?iso-8859-1?Q?fFmm3/HFVPza3nvfbxx93+2P4RMqOMyrbL4mPCRafjuCEosOn0dCpsPAvJ?=
 =?iso-8859-1?Q?zSG2WLlRjkpWWmNzDmr+kmlh0nXfEr++fL00SGM2q83EWKrqugc+wwDjks?=
 =?iso-8859-1?Q?n13+PrW/QSIaGt2NGsQ+4coCXVhHXpHJAUt3BSL3Ht3jcIGlMjDPAziEI0?=
 =?iso-8859-1?Q?uvfyq2on1aNyLSFZrLG8Y6YgAcleg9CKEplQG9zz9pWdr9H/alHtslPayb?=
 =?iso-8859-1?Q?0jB678WsN5GApo+wdu0bIwGUsPlKAZqSW5CwOYq6SqtBmjn54NVlgXdg/9?=
 =?iso-8859-1?Q?fVfJGAbgoPTEudQl6YOAaZQ33lxqVtzq4ZkYcfFvBxwtmvlgoKlqvLKljB?=
 =?iso-8859-1?Q?D7f5fVzuGtvusQBSuoXMWXdNBBVHnBVjUxkp6SehqKz2hVnSCBYOnat50d?=
 =?iso-8859-1?Q?pNybyneicoqr71hK5yU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4812b146-a9e6-4af4-569c-08dd571d248c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:43.4866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlliWUBdsUOVdA1p5rqeCqAd/X0xKSyaMF1bDsn/02ogi5hgqqjaFvfRUBJeMAy6qlKXVfkAciSbRluwpRVFlJnJ7oE/iwSwFHex3eSUrrKKQkywNwq6oTqAj1elSmQY
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

The cached is_master value is necessary to know if a device is
allowed to issue ATS requests or not.
This behavior is implemented in an upcoming patch.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c                | 25 +++++++++++++++----------
 include/hw/pci/pci_device.h |  1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2afa423925..164bb22e05 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -134,6 +134,12 @@ static GSequence *pci_acpi_index_list(void)
     return used_acpi_index_list;
 }
=20
+static void pci_set_master(PCIDevice *d, bool enable)
+{
+    memory_region_set_enabled(&d->bus_master_enable_region, enable);
+    d->is_master =3D enable; /* cache the status */
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_dev);
@@ -141,7 +147,7 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
     memory_region_init_alias(&pci_dev->bus_master_enable_region,
                              OBJECT(pci_dev), "bus master",
                              dma_as->root, 0, memory_region_size(dma_as->r=
oot));
-    memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
+    pci_set_master(pci_dev, false);
     memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
                                 &pci_dev->bus_master_enable_region);
 }
@@ -727,9 +733,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv,=
 size_t size,
         pci_bridge_update_mappings(PCI_BRIDGE(s));
     }
=20
-    memory_region_set_enabled(&s->bus_master_enable_region,
-                              pci_get_word(s->config + PCI_COMMAND)
-                              & PCI_COMMAND_MASTER);
+    pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER);
=20
     g_free(config);
     return 0;
@@ -1684,9 +1689,10 @@ void pci_default_write_config(PCIDevice *d, uint32_t=
 addr, uint32_t val_in, int
=20
     if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
         pci_update_irq_disabled(d, was_irq_disabled);
-        memory_region_set_enabled(&d->bus_master_enable_region,
-                                  (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->enabled);
+        pci_set_master(d,
+                       (pci_get_word(d->config + PCI_COMMAND) &
+                        PCI_COMMAND_MASTER) &&
+                           d->enabled);
     }
=20
     msi_write_config(d, addr, val_in, l);
@@ -2974,9 +2980,8 @@ void pci_set_enabled(PCIDevice *d, bool state)
=20
     d->enabled =3D state;
     pci_update_mappings(d);
-    memory_region_set_enabled(&d->bus_master_enable_region,
-                              (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->enabled);
+    pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER) && d->enabled);
     if (!d->enabled) {
         pci_device_reset(d);
     }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index add208edfa..40606baa5d 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -88,6 +88,7 @@ struct PCIDevice {
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
+    bool is_master;
     MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
=20
--=20
2.48.1

