Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09546C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXb-0004ez-BF; Thu, 27 Feb 2025 05:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXY-0004Y3-CB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:53 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXW-0005qC-Dg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653690; x=1772189690;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fDuNj2e5Z+tVyKsZ9Vl/nMf+ohGdmNjrvRU9Wlq6dmM=;
 b=PDOpTzQh6ExBqf1H/vyjkpwBUycko+v7aJ6+6/E2N9tzfziJQZyZ8fV7
 P+mBUUIXKyQNlKTfGU81XSjlgwkPtY0Eyjcvfsnuu3V64Oq/ztkRyRlDY
 BOru91Fqexj+JQz0ZtYKk8dTTPrFg1BLI0el6UdyvR2Fx8BoJJNUh2h7t
 eO9Zegvh7QpWF5lNh0MemXd9AWlXLqp4H8pOGhGC2xNju5H7ESGMxUNt3
 gKmZIcj7HuQVyVXRGeh5LbG0SkOBK+LyqHBFgmS+oYS+nm+xVLgNK/+ki
 Lzof3aGqWokeGLmXGs4Js+vWEkZTCaD/zezVaymKPoNoGAOFlb7PCA2SK A==;
X-CSE-ConnectionGUID: Y8r2H4dESNqgShyLgoUIuw==
X-CSE-MsgGUID: /KNB5JpOTAmHNLBT3NFIag==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="31822963"
X-MGA-submission: =?us-ascii?q?MDHawFV+MDl33gxkMWw2KYIyxKcNyrlGFPYy7e?=
 =?us-ascii?q?j1nXjczrCl/PWfIY1EYZaZQbU0rlVIWHVCtjF3Jxa7Jfh1CTUDEyxF4c?=
 =?us-ascii?q?YhMefGwGqODHG8C7G7LZxyWZsjrI7V+7HVt0SSmkaUhxBnte6gTzSJ3q?=
 =?us-ascii?q?iubTisi1YuymnNVDf9JfqOeg=3D=3D?=
Received: from mail-db5eur02lp2106.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.106])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0cdCun8aPhL5yNFFKxXrpA3+aScIDND1pRrqsNuj0MjHsKUiiTiihU4G9lT76xuWvcUPhxCgpLSb9SUyw94Y3xKFDB9IcNHUW/mq59OKecM1MhKlBZBF3HQPR/a1KeCDJfaQnG7NA3kthti+lMRh5+f22MN/iX5LyIUnzxUI/Ge3yCfN2tPVQGejA/kMrNa0/KhxD6pAN6AFISfqmomh88Petw6uE5poOulvwQcJVuue/Ghx2fCGPZ1vRxmKjYcl1PM0HjO0J1JXkMkrgobB9eOgCdGoRjo/qJe68wUgAH3sMjZSfjli4v+O6/rteVSzj0dEwsHrJwpobhuD7oJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdmPJO5RPn+KvHUqO9BHrSYOABK1AmuO2QQjcSjxo28=;
 b=TLPVsxVWBdYmIDsm/G72UKRa8EibyO6paGTr/X0ivV9yFdFqPUZwzOnyLyLVGCff1/akNZSk+si4N82YcG+OD2a5UlqFPnqnmJofOcL8lF9dbg1V1cR3W7lIUYErQLo4jysnyx+UF1rjh/vtDshkjfJZQXXOhFCbXo6nbk994OF7XCYmtE4uQGa5GKbsH0zxlSl/eZeW+68iIZ7smA1463wtulI2DiZK/hLa0YL4ZVOTI8Dmwkh+6Lih+ba0ItPuSLFXraaiiZ/jWJjLNIYubQ/J4IegBdb4zOFo8I0XjKTx9H5pqfBEWm7zBgBc+FkDfD0OegY+m2mcpaCpLJgl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdmPJO5RPn+KvHUqO9BHrSYOABK1AmuO2QQjcSjxo28=;
 b=G7n/f+9X81EEAevpNAEBFXcHiR6O7CRQ08fUU8geyfD4TSOoGm1+g05Mf8bvHw7pYe2mLrDgPSMTwizdH3M7MQrBouw1+ICcYYUoEtpKglO/MG4F52jp8Rh4sR+/FJr1p25dEgmYRRvxDhApTksVHLZqJmxrPFQDdVLwyabn+7F+NJjCilOolVa+l/dI8h1lQ9FlK+lYo1cMvCrgW9YAaDOOxyzrA0LnleZ3NIGX3mZxOGtYCTh9Rxi4URTXl7kWX03WY7l9nQWX4DsxrGbJwBZudIgZT0qmlz+ZQW2Bna88JrdhunurJTmBS/Os8Z6beiRQf7kjnAqRAHlJOML6Pw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9421.eurprd07.prod.outlook.com (2603:10a6:800:1c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 07/19] pcie: Helper function to check if ATS is enabled
Thread-Topic: [PATCH v4 07/19] pcie: Helper function to check if ATS is enabled
Thread-Index: AQHbiQYBOv1+QKz6XkaWkGVVgEGHEA==
Date: Thu, 27 Feb 2025 10:54:42 +0000
Message-ID: <20250227105339.388598-8-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 67798e8b-414a-4410-c3c1-08dd571d242f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gnryjlUGax44W5qniX/Rn4j3t+CeaXuKtp80mp6EhprSQCy4fxGG3ECHu3?=
 =?iso-8859-1?Q?uRb45PismCaULfIuf9qjOLraNqO+sYC9wnjUmRnzWfMVTugGJEn4pbC+q5?=
 =?iso-8859-1?Q?i0gejmuxAfdAiccL1EY1Ec3JY26gwJnZN/qfFefMydwRvkTKD9pbwhgQQS?=
 =?iso-8859-1?Q?/iRgQTHKhd3klEjkyTnwvDn983z43Fn092bN6eLe41+WwkIutaLqKEopKp?=
 =?iso-8859-1?Q?laWqdWV6uFpKnnwdL7L1qoSPuRRwaV+mtVKGH/eIBCA5ach3Ee1VwXzW0A?=
 =?iso-8859-1?Q?zgNHVLLgmY8nUEiXr7N3Cbf+ho6k8LFCct2uhTofj4n0+tHz7gk4Dfj69H?=
 =?iso-8859-1?Q?KPtUJgNSXbJ7q/WhYvy5QRZKswnTpp7djX4LrdgxEMYkpm5AP3aGKstDY0?=
 =?iso-8859-1?Q?msJDU/EOOVeLWcaCP7ze7SWpfwUcN/sBalbWYLU6gy13gEiI8k/vfkBEKT?=
 =?iso-8859-1?Q?4MMeXwDWfU1Wm3Sn4y+Wl5oQI9kOVVQJ1diulOK7TvKuSjK5wdhbDYkujs?=
 =?iso-8859-1?Q?+FYuO0nQZF8PSmTPP5tDkk7JvITd4BS30s/IZMToQ7TfcfjoVru0jh9o6Z?=
 =?iso-8859-1?Q?WikMmJy1cFzUS8fHE6E5hvqP+KSyE4YSTwQZMhYfFCiGx7J059uUSqBJPq?=
 =?iso-8859-1?Q?q+J2qzQvdGfE9tLSC0Zq0sAUN9/wIkoHeD45PQDKfO5ZbFeWvlTtrCnLc0?=
 =?iso-8859-1?Q?HU58G2PA+LMKSJncKJUdisjjdwSMd/Bfkq5TFb3Zvew5rHtxFwNE7w1jgF?=
 =?iso-8859-1?Q?qVxydtojwq8h7MFP0V3Up7N9yTsFr27JdvKnRsPWR4izF0a6PLEZg3NO3H?=
 =?iso-8859-1?Q?aUqp+g2DI/ZNOwJUGpGHtA2E5du2pSpF9VaTs6zLeTsnO9ANqesmv8KXjv?=
 =?iso-8859-1?Q?9Lu6GXoLhz4THuTv1f1fs9WH2iYD3UBobAIWt39tHjV2z/fRITA5CEVBnM?=
 =?iso-8859-1?Q?QEphrr6CUAICYfkWUfAWGnzk4klPGsZsPITImLxiQrR2EJ69gkO9Yg5k31?=
 =?iso-8859-1?Q?YsGygmiXPNgSKEB4hE1a+76kJUBEro2PL5B/TWxYalHIhh151O/PgrCKon?=
 =?iso-8859-1?Q?/LbIFk4kcycjFQpP+NjmcyoswFSAvtM1gyp0xg8dx/JkaQV63yWO2dO2hN?=
 =?iso-8859-1?Q?aPnXXV8GSK7bBM6teiq27j/dvtsq2ELsEzrKEx2w5b+tnd7OFE5HzNVveN?=
 =?iso-8859-1?Q?gLNeUvcSvP39XSqc21/sU6hK3hxqfb4MYHbEbyeiDRxuKkg+21cpy29xqV?=
 =?iso-8859-1?Q?dfQjN9vGi0JMAoaTscrwXWi5NC2gYjXatFdfbst8ByruKONJMylpOmK//D?=
 =?iso-8859-1?Q?p5+QjC1pbe1V44Tlt70SiroiZBeGINt6lIg12UHODQxfuxEyqStCnu67Fb?=
 =?iso-8859-1?Q?MGux1j3Qgcg3BkNcI025ekjTiLRex5pDhcU4TZLgKU8G3N6KhNRBf8riBl?=
 =?iso-8859-1?Q?mcvAT9CkFxc8htjSGkvRf+/LINQiSH+dAZcbxpicUlYPTIqv2zMB32yUsm?=
 =?iso-8859-1?Q?ViDagzckr67dol45hXJYFI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qtUnGgYPB2t7tR3tNWm8Juk912Q6jq/6Ev5AJvXeA6qiXXdUOnORTbMTSQ?=
 =?iso-8859-1?Q?wcSYArhpAPX8No6aXeC8LvdDnnhvLCAxO3SgoZVJDrlOYtlRZtC96P3+Gs?=
 =?iso-8859-1?Q?6AVAgM9afKxF+EbwA4nso4K5OaeS+qrBnKVfZCRzz4vbVYd932OguQkgWi?=
 =?iso-8859-1?Q?UiJHWxCc21zG4ZjY/07OGES2oVQP5eMJKDvhVgxtufjA4EVL4yRnELX5L+?=
 =?iso-8859-1?Q?SiVZ60lg6p9pADGjCLFWz5+TDtr7JXE/vVDXILrCPwCpekRy/PPX7tg4BM?=
 =?iso-8859-1?Q?TnbwXBiYnADsVj93u4Iiobe6GbDdil8PyURqQqRwb7tIQXjO3gN/TVXjU3?=
 =?iso-8859-1?Q?M8ccCCNeyJafLYNux16ZtMFWnxBD2nNwVscVazBOUDJVdmFWCqf22XUTYg?=
 =?iso-8859-1?Q?LcvS0pe/EM0DLH7R1jG7sFTriUXN5XMIFhaYrpBMk/gu6qDGFJ4HY4lhpf?=
 =?iso-8859-1?Q?0ROc4j93Bjj7LYmZkZOtbl+b3kJL2e8uNp3wNWsik1cft0h7AuIwjLJoQ5?=
 =?iso-8859-1?Q?S0VhKaZc+z3F54VB3ywlm5c4p4Vb568aUyTzC57zlCe+ujV6OvIq6ggftA?=
 =?iso-8859-1?Q?hJp2cTj3CvM+edOor3u7qDpwFaMAes30jKhcTj5p93BLYtJylTf1J9ZPzn?=
 =?iso-8859-1?Q?BaEBsgf98G4OPq/5D24VrONGyHer2Xkt3TwKywdHr0pRkw5sYGNjnchIAQ?=
 =?iso-8859-1?Q?ZwTZELeJEE3J5RYwbXJiz8Hy880YHphXVKJtwcns6l46A94zD29tNcM/zt?=
 =?iso-8859-1?Q?zuIOzRT88WMnOv84pDDR7tiWo9nmvLSTjAgWM7tN9MjsitPAf2HBv4y3p3?=
 =?iso-8859-1?Q?vr5DM9zLrqks+eGuH3IPK80ee8lPHjILhsWkEWOlW0EpTnxKx/et6IrUsb?=
 =?iso-8859-1?Q?K++otRnbG88D/tFHZ+Aw1SEzF/mGVlh0wSJtgjXceqiQrYwoO0GnJhWOMI?=
 =?iso-8859-1?Q?ov5hMkHXYzIcC/xjRmYX8oRElg3m1QJU4KmwPumjI9l+F243iw/YkVEixY?=
 =?iso-8859-1?Q?wt9cB4mlBGgL1LDAM5NpQmsTWa0gozkayScWLqqoXTYYKBbVPeDWLzvhcC?=
 =?iso-8859-1?Q?e58x4x2hqtQSJkwmXtZdttq3h/QYmXBs+IT3ULYacY+T/q32WmVmmx02mI?=
 =?iso-8859-1?Q?4zwvh/k6uGRNxIKMmsTNCjSCjxRIhXiNFUQ+rM1ghn783FJKvu16B4r/It?=
 =?iso-8859-1?Q?IOXIvlkS4ROnMcfOV60Mk6SjN4JmQxx+HnwS/ow7XvEwcdvzwFlnZGYd9B?=
 =?iso-8859-1?Q?vdnbzImfq2G4YC1gz9EpxoIfpRDHHZXCeWd1ciSG5O6uPQRALI+M69Ee9O?=
 =?iso-8859-1?Q?ejuZ1m1rxtUbBAQkctovvQyI0GQbS7Sm96zPTQBx641hfOe4jtwXrwek1e?=
 =?iso-8859-1?Q?6bFW5mXDuFOZ7hBtWGt0LVKPx249/2wWAEGUZu2Ea1VOYSAvt1JTuAoofM?=
 =?iso-8859-1?Q?JSpcZv+Nl6lW1LR0QE1GJVUa385WOBaMNA3Yo3/XiD+bUOhncgciHp/Ay0?=
 =?iso-8859-1?Q?YvntpzcBQ64UTr2JAjU7gfz73MeG/Vqdf9trKTfZN4y7IzKrO0plFB1Gsq?=
 =?iso-8859-1?Q?bpm/KWPjL+rcPo7TTEAahUk4n3ijlSLjIl/3gQh/tUewTllQvpvx/xP08n?=
 =?iso-8859-1?Q?yKwJTTV9UvbECWZoZzjH1JiXgay1Uvh57b9DkGHcuC9/Vdx4Ac2l+rw/qR?=
 =?iso-8859-1?Q?9hKnI7Nhad0EHnxp3EQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67798e8b-414a-4410-c3c1-08dd571d242f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:42.7470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPqYCnAHcUK40Eaok3EWByTwv72dsmur0dSqKCwTsrR2CM6qPsIgabvZH+CRinZ8swG/cTyuMR3dDjMwbNMFCvWJbCldW08TexVtJzBXU8GDQrTQeTnO1QW1VsK1gmbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ats_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 8186d64234..3b8fd6f33c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1247,3 +1247,12 @@ bool pcie_pasid_enabled(const PCIDevice *dev)
     return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
                 PCI_PASID_CTRL_ENABLE) !=3D 0;
 }
+
+bool pcie_ats_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.ats_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.ats_cap + PCI_ATS_CTRL) &
+                PCI_ATS_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 63604ccc6e..7e7b8baa6e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,4 +158,5 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, u=
int8_t pasid_width,
                      bool exec_perm, bool priv_mod);
=20
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.48.1

