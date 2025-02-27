Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DD0C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXb-0004f6-Cf; Thu, 27 Feb 2025 05:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXY-0004YL-UK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:53 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXX-0005oQ-90
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653691; x=1772189691;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V223gIkaKR30sNUdnEml5N4wlPmNOlUUGNe6oZ+paVM=;
 b=C4gQERwxPDuJQUwDXVuib5HeEC/my/pWzYEsz0XY/IPbMn24wmPqKHpd
 Ow5VkreNMjUQ08DHoTCif2IaWEGpgIZ5C0uWhDzoTCfzykbJ7U1qVMaUc
 8cyhMLCI8lET9NnpapI+I4X1RhKrj/A5MTHpDztJ2Iz/tkVhZCNtslOhq
 R/ydl2CKInoxCMIX5hSWGU5CCK3IUaegxHGjGE46+zdEqw3IwLocLvWnI
 4YbBztbNCfbozvNiNOamx5Yt5SuizBxM60FR3Qtlr7NZTfQ1sV2Ju/dGh
 dmvG/NJFCwOzRMGzg4rUtUJf4Cj/u4yBt1drVscTKyzZDQ/8/I/aDTJrZ g==;
X-CSE-ConnectionGUID: cN6UGbkDRbmj5rZeyTfvGg==
X-CSE-MsgGUID: S9nL0AnWT++j/kU4D1KUaQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331844"
X-MGA-submission: =?us-ascii?q?MDErWGch/tb7NIQ25pullphBvH1UcSXz14d8kz?=
 =?us-ascii?q?TSi4hDqlmnjoNhFDXm3ORH1RVuxmmPH1oQt37dlLREItND1oYpP8hr3K?=
 =?us-ascii?q?LrTP4953QEeYkFZOeHTYHU27jnZwf/kC/blKzBK53dffO9YlNIYgoNLc?=
 =?us-ascii?q?NMAnmet//VRuELJP8AKeyukw=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3wkWvTYkBjIUnmMljZcJwrCzlqkIHriFvZbd2NYj2/dHJ7IleZiqutdGCGK+W6zaudpI/STeEuHu0KL36GFBHPmwl8NylOuVaBOghjP27BxhRtqQaa96188hbGmVGChLv5EsCF7aczkdaAATT3oTLPICMM0RGapynynHuPNFDRVtHdyLLbwZHfqiCRUST73+ttfTRKeUnZwL/Va7rmqI6DnSHfH64XAswClSqOzYuqLYfFtmYI+oKOS8lp7WunvPRQht1RTDEhX6t6XnrMpuoPIcDtRzlyL1HeFgkjVwIVJPqegsXiH1M2dL1RA1toBAI/x47aT1pvafd5NSTAVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UxSyr3l4O0MfvKh7SI51WYPvr2HNFpIRSV5MiiWeWY=;
 b=uc2N/i9xzrYnBxM146yjkPoi5er1asTdCneMShnzNsfivyOYbzDx4GeYW+CK46hqpPMDiUqvHoNE+UozdPP8exHM4k6SjYGrRfJ8CPp9LlKat3iHTcqyB7Mtl5Ul39LjnLYsiSMuwKEw736bFiRVuqaE9O3IOPk9LvsT5Bn4boqeAUBukW+FFs2Qz59ZA6iNSD5UuQxpQlr4D8Gjd8YMViYfg6I8lmnJXXc2cVcnry3MFz9Pqed5lK4YdB6tI/JxCphVo3ndmxYZlGjGvjznO99efYRxQ0NPUIDxb1ZeYFEoW1sMpxTeN3DQt20OcaPq3BDj0GTFuFIvB8ijReDpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UxSyr3l4O0MfvKh7SI51WYPvr2HNFpIRSV5MiiWeWY=;
 b=RXDIRUHw5tYgcuhlpycACnWhNudn3nnF2nBvn1WRpQSuxg/OUAMA8V5F5jS1icjstu8b7q+Va2pdd8ZXGpPwTm9UDxhvYz5eaQJGxwqxcYIPuoFC/4iyiUKO5D6GkRB5f+eFA5CuFNOweqhrXHRq8je2rWGjaVpH5g7u92eYEcGB/aZwt3kk8oiv08lT6o+u2mK7JjCRj3+qnU9yyfjYDAmltPbNZEio1Lpk8egrZ9eA7ibSNBm9xDwUlfjI6uFlKEsgYEnwSRba1WGXzybmom6D/Po+53NLmDKGiVH/mxxayhqWJAOTgzZGehoJ/LMw253PGfrJ0MAk3jk4z38Xgg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH v4 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Index: AQHbiQYDSAyUVSLpHk2eNfYAP59Y8A==
Date: Thu, 27 Feb 2025 10:54:45 +0000
Message-ID: <20250227105339.388598-12-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 82669fd4-553a-4d7c-2a7b-08dd571d25a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lwKYKBrMwdsb1eJrPBudDp1MbNbMIfRRyDsmAvVkfBzA4H0o/XQDsufvor?=
 =?iso-8859-1?Q?Hl8NIqyn6cUcKSOXKmHCE1ds2lomFtWPKQZtiLCKrEl+WeQ0iBf/Y6F5Re?=
 =?iso-8859-1?Q?bAV/1kYQvte0AdFVJM4yPP01eg6SXFK/0BQQcnGAk4wjGGNXFaXGg++zhX?=
 =?iso-8859-1?Q?zYRiFHe71foEuWc+zQWkt3plqmp/3zWODtvs5zgV5XJ0grj0W1G4jguYRE?=
 =?iso-8859-1?Q?xq2J9N2U4aZgUQRQ5lLxaBFkwVtso9W/oNLcPu3POsRUoYVAQ/KcsK4XXA?=
 =?iso-8859-1?Q?YMOkb4r1CWjxzijplLbcNylGe8fg43biVDPDUX2Wz+f5tw1nv6jfei6dWR?=
 =?iso-8859-1?Q?kjGUIoX+oQ+cwgbKf/JfhJv2IKmmucdpQzeIasb8CSkJ99RyKyCKaz07bP?=
 =?iso-8859-1?Q?flnOx8eY2wr0kEpFcBcBV5fZ+n6Suw5tNqBlayYoqgMCB8ir9QcvYl1p5h?=
 =?iso-8859-1?Q?4cuYkn4VyEWsz5QVofeYOsFwexe9k7HoL5U6bqN3WI24K1uZRdVEtQPLAU?=
 =?iso-8859-1?Q?oTIX6GSDw3oR+iWq1gLg2dvoMD/pwOLXYRqAK/lKl/FLFt4b2WuHghUCtz?=
 =?iso-8859-1?Q?k/Uf7luyTXPhjOhtGF3wcS6/PyY2bd3YsCvGyvv04ZIq8NqUv/tOcK2pGk?=
 =?iso-8859-1?Q?4Qi1niHQD9RmEX+ZJjj+KdzorNSLnY1xpU2bNDOhZLLf1cjkuj8uEZKGX1?=
 =?iso-8859-1?Q?sWxc/1Hh2+Pe8aietBEkiv9gilptq7K98JEs9DkhEKR/V94OQuk3zJ9BkS?=
 =?iso-8859-1?Q?oAttmwLzIhAw8DulhURRu41Pp5gQbXqt2oxOb/Q0d24Ko4X5PAcHqGScWT?=
 =?iso-8859-1?Q?tH81dUmAmhA+QejvfadhLvKsNCSGZn2AzIitGmhGNLNU8grYLTErbYzep3?=
 =?iso-8859-1?Q?9eDgkn9o7uKOARKfbx9GR5tryFFu/VSSDt5lNGNlz2A/Ojhx5X3DQ9VUh5?=
 =?iso-8859-1?Q?IOGpXPeKskporvAKYira1cGgfhgCtwNbxX3BeM7/985nSQ8rcyNS0xQUjI?=
 =?iso-8859-1?Q?BHIlyaJQO+vw2d5Zk1GqOAdFoe7z7/i+Jb1RnlcKuYzaLWCEOk7gGdkt6z?=
 =?iso-8859-1?Q?e61toRi3aeuVt19v0J0k/UhCBwT+2Hn6sAs+cqCgWLFAWJKawkJqNWI+KE?=
 =?iso-8859-1?Q?pVax4qlejXN8w/hqKGDe7XwkBwi+As5jkcEgEXc32LJx+q5oi8Yzfr511I?=
 =?iso-8859-1?Q?HoR7fkyI+jG1SPH2Mo+EVenr+qiYXhJQY5Ynzr8v+uRZp9w/1O9eGv4Dnt?=
 =?iso-8859-1?Q?46nStJMycTMMwNKyvoIaSWD2DJxkrRBvaUGQFQk5a7dNuIJlnnEIpHUw4R?=
 =?iso-8859-1?Q?yYLUw5NDi7F5vDE21QVk+MvIIyTgJshdHy0KDpTbP3QSQ/NFMxdeo1yLtj?=
 =?iso-8859-1?Q?cpSEsZK9Sp77u7HX628dcsgaibLUw/Pip9cT+y1+PMbeDPAHfl3SoGg+BB?=
 =?iso-8859-1?Q?D0l14dT8ltJDk90J6BZR2u8eax65UneR/Lzbgsw4HUHJsjCkM6CGZloBU+?=
 =?iso-8859-1?Q?zO+g4hzWPWXV/qI7nwKXeA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XIoqn5Wd3tdIyVqRes2lVPg0X92SmrT1b/BnZq2iE0LkcMV4QoPBPzYKjG?=
 =?iso-8859-1?Q?PQZUcj1njmAoW87Bpz5now3dyvIecaXhNSj4pjtAhgRnj1Gsp+0nUXKfSq?=
 =?iso-8859-1?Q?kn9dJbYyhro8d7MY0mtL8Dg6JMw/885xUlGoZfYW77UwrFycNGE+r7kqz1?=
 =?iso-8859-1?Q?6nKlhdXQ+WA9tnF/1IYRMNb4VbzbOmOiEj7YCfxlqT4vDVEPQyZDIl1P2M?=
 =?iso-8859-1?Q?D+vpnFA2JuVOj+7TG6c/SMR2ZWU+R2SL5J9YSSw24Wcs2Ig0DYYGdCQsRw?=
 =?iso-8859-1?Q?D/QgiOXLIAu1MKJ7nf21KU9NYzewDVyAjqql4pAlxxV0y3zKWit03zStgs?=
 =?iso-8859-1?Q?rH2UD879Or8fSil6oFyeKxeI/T5vrjR5BtSNuMyLuEnSy9dzJRVBKYvSM1?=
 =?iso-8859-1?Q?wW0G6leJS1op4bBpMFiQTsfirWyKlHHM334db3vwKX5pNIPYumwewocLD2?=
 =?iso-8859-1?Q?tIBu0csA3oRfhsLntBPUxwTegEdiP+jVsEelg3EtjJfiTHb2WL5YY18SFa?=
 =?iso-8859-1?Q?pn7W7GA3+3WBet3JXJOb5qXGGRUpQB3bhGyWN9AHxKKDLn+yWecx6LBw8q?=
 =?iso-8859-1?Q?7ZipSwvqdQJmNcR7E8fNbshx/6DaMXZuw0BOp8ZVhqFXViOjoxTUlezbsU?=
 =?iso-8859-1?Q?5AvyYVEYY806+3yesASgBlFKBSUqjqpPgoE8zgSX1614UDMnkYnRoDM++6?=
 =?iso-8859-1?Q?8mNSBQ5hsBJBvb1FaW+cri+/2mcOItaO0QYv675NxNu4hA/xYvPZB0+u5t?=
 =?iso-8859-1?Q?JRisywSe8cYBGlNBU8svM8IZWTwlkoTX2xFZSOLzhSK47bpVI7fb5Uih0E?=
 =?iso-8859-1?Q?L67OWj8oHQ+L2IvObpwQttUirVTUw17YRGTHw9PfzKE+JvvopOWmJUpyLs?=
 =?iso-8859-1?Q?P6ecQ8lwZmWeEsEJU8vPvdZiHZknKVbnPtkZQR3dIjiQtGlEFiywXQNsYo?=
 =?iso-8859-1?Q?tYIRJDwmW3ZYqgOD0kT620VWsmelCjcwPoAPw+DkKIIfCkUw69UupsYFI8?=
 =?iso-8859-1?Q?63nVTi4l+3O1JEGaMUYZHZPgDa4ElqMNAto/gg499Z+FYh2d78N9BHebYs?=
 =?iso-8859-1?Q?KTe6xR8HrX5Audlcxh6qtA8fZe5k7U7Mmsv8f0KlZIo/2P8YctQRCzBO6C?=
 =?iso-8859-1?Q?e/VLlLjd+2w8pAfcSX4whxXkYrCHCD3x+wNbMSgwPmjx8eWy6nW9d6DOdR?=
 =?iso-8859-1?Q?XBrLwj71szJdNIOvTCRKsEKdMBQmIl3GBN5Oy/KjqLRZS+X4GdXRRlQQEm?=
 =?iso-8859-1?Q?u2SAiH+22aGWaEEQPmqBDtqBoVxj2Ouha/scjaPLskzB+9x++LNmQ4Meda?=
 =?iso-8859-1?Q?5g5ija1Ew03UU+DlBsjHt2gqIVKHSL/VhEreFXoVO4uJ4nFrc1ZChovTFG?=
 =?iso-8859-1?Q?03++7lopDES3GUiz+CFFcE0JYilZzcaq0cd5HKjMIHv5uB6oyXG6XtKjVz?=
 =?iso-8859-1?Q?60TcYtQV9Ve/N59vd2gZPSOkcUdLymk/hXtF5RYYheXt4+aSHMZ5zAYmJD?=
 =?iso-8859-1?Q?1YU4ucou3vsZ2eS/obCx2SEbt0YjIYbvqcboWplRCePeNL4CUc9KvllStm?=
 =?iso-8859-1?Q?zh8zvlgpwl/qsh61BHCulI3vpKv4tAfiXp2Y4tYThyVjbptsJHgCcqRfLF?=
 =?iso-8859-1?Q?G3XzlWuIGvRKuP06FnoDn4a43h44fsWGnol5ynmGcI6jt5opHOqGGkVUNb?=
 =?iso-8859-1?Q?vMjhj98ftRSSd0caBWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82669fd4-553a-4d7c-2a7b-08dd571d25a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:45.3367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/SLqz3kvRSiepFsVSNC9AyjK+EPki7zIpRJi2FnJ9qEmJ9M7HZZ/OY1xeoGKG4Q3zOoxDZpeGSuQ2acuPbrrVBEK1TC+rtHRUUCoOEVPlqaeT+lcCyO2k/Qz9SyDCAE
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

This will help developers of svm devices to track a state

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index eee625a9c6..4d240cad1c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -204,6 +204,7 @@ struct IOMMUNotifier {
     hwaddr start;
     hwaddr end;
     int iommu_idx;
+    void *opaque;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
--=20
2.48.1

