Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDADD3EE66
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viuo8-0005aS-R4; Thu, 22 Jan 2026 08:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1viuo5-0005Uo-Uq; Thu, 22 Jan 2026 08:33:06 -0500
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1viuo1-0000MA-W2; Thu, 22 Jan 2026 08:33:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEZXIjsf0PlJHk94jxGdKjsPxFKYAfyXpQS4FjSdAEWVjYECpJFe7dE9J1+8HlAd5rP1atN3474WnLJfjA/7tIP5Ruwtw4VbdNp1+JdsVTp5OBA7OGh98adGGKizjCIaJUc2wNWmcT1ObeGN1UfwQ5aNkajFu3MNFdmq05axx9+L50eOFhNlIhI5EC6wtBUBS2C6ajwxDcM5Y1HiPW/bC7shtSocPX23key8MAPFVgF6yt0+IpFie/thVmkhpfO2Ss6B7yUAuB05Nf4ERlUKumX1jM1R/fTrRgWbPQAGA5VRxHwMGIcy5iU9TrpRgNsecg3iYN/LfQsK+3VUw9jlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+m4+xM+GA0b5+4ScHeqvE9mZXzCFHO17fbJi8JeBgQ=;
 b=GSdOM2nhORiSkQdPHa4f5GsmVnHO1o3A/uiQoqwXwVOo2kViR4F/QiySBMdBfpIsb4CzSZEFJya1Xx+cVy+X3Y56p39zn6MMsRLMDiZMM4FzBBx1WXnU9G+mmCdWAb+Zrg5VdVpiIWHKEzOIFR4uqCuXwovyjnGc1FQCD0zYHvVbEXWJj3NaIVpYlB66toCoPd/dOlgS5e+edzBnJ/cgK7LEES3vG1usekGANHiAY2fATQK0nvWY6RYy0IMc6bf+rM/AIwjwnxcbzzORhFEBf1ZOWG8DNAMs7FKhnQFOi3ETB6WdKkAVihcmAByic8xIEAQtEgqAI3nxuEoabjwwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+m4+xM+GA0b5+4ScHeqvE9mZXzCFHO17fbJi8JeBgQ=;
 b=mMT0r5AXCNf59cEZOG9JUdir624hiwPO0HQ/hzysEkquXJ5R5iMGPLay1JuvgSASxK6Gz3NzMevbX1NU7s8Mzd+PBTk3qtrNVc2QELuu6AifK+VpPzgJFd0MnrvL8YdPxm7ZWUV6Ji6AEV/36Gr50BQRaHdMb8TDTvkp0e2XtUhalS9CbMkEFGIOCPLZuXPl09r6zRPSfkUaVxC/KP9RqSuOxtVMcOGbrHTaAeRqzm1egi3jVlGzmwU5wC5uUJbElJCJdnSQ25pcM1GivqH5qPxWZuM2tHkS/eaRZ+pABpGajQifBZLbucmafEoB/EIOp8XUAhL7fRKSenhWwdKBjQ==
Received: from DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 by GV1PR08MB10806.eurprd08.prod.outlook.com (2603:10a6:150:162::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:32:52 +0000
Received: from DBBPR08MB10697.eurprd08.prod.outlook.com
 ([fe80::2318:7df7:a744:15d2]) by DBBPR08MB10697.eurprd08.prod.outlook.com
 ([fe80::2318:7df7:a744:15d2%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 13:32:52 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Polina Vishneva
 <polina.vishneva@virtuozzo.com>, John Snow <jsnow@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Eric Blake
 <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Den Lunev <den@virtuozzo.com>, Andrey Drobyshev
 <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2] block/qcow2-bitmap: remove inconsistent bitmaps when
 loading
Thread-Topic: [PATCH v2] block/qcow2-bitmap: remove inconsistent bitmaps when
 loading
Thread-Index: AQHci6ObvWJLEfkZz0WsXQllbrH0Fg==
Date: Thu, 22 Jan 2026 13:32:51 +0000
Message-ID: <20260122133243.64909-1-polina.vishneva@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR08MB10697:EE_|GV1PR08MB10806:EE_
x-ms-office365-filtering-correlation-id: edb0c786-7216-43ba-6e85-08de59babe09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nhCB5mjwRYPGnnXXQXc9JfGiyMv77/hQIHXyqjnEBARZKUoq+VZF51mOIS?=
 =?iso-8859-1?Q?UXvVClkOrUvE5CJ1XF9ANle7m/+mMOGELCAYL6PJ5Kjmpzq2LKHuFwvdCp?=
 =?iso-8859-1?Q?PbhykvTAKKWK5KljFtMCNQZ4Vui0yQlAAfXxiZ4QVcY92DGzAoBTsG+9th?=
 =?iso-8859-1?Q?Y/ifW8AXWosECDMcxAf5vDAkyfKEcILl9pp+yte8QSFQxBiwxx7mTTulf7?=
 =?iso-8859-1?Q?h95+2UskZo8mzKRs9BO6VHmfViaAnumLHqU/2DNHOHJtEgSE0msLToafP/?=
 =?iso-8859-1?Q?DQwp4AKy4/skHQWqFUA4JLGeZm7PbhzOn5f5A0jdACXrQCQ6hevx1ypwZN?=
 =?iso-8859-1?Q?H0Hi6gslScb6PWZmr+mDLzZ0j5ETsfCl4db1mPCy6FcXQllWi/ZBszcYGs?=
 =?iso-8859-1?Q?SeyZR3J9/+KA6Y+QjHPRvQrtkDXHf8+6ZRRNlBkJd5dgioWVK+h2Dwt4l4?=
 =?iso-8859-1?Q?PsYHKwMIyj0xEVJPbmc9SZWOsMe3l6munlwWdlTI3LknZrXCpuNmZnFm3G?=
 =?iso-8859-1?Q?uJs+fpWRag23zfKfs8sETxXXsq0CjP11OiH0qZJKfUQpWeQvoPxzFYCYeX?=
 =?iso-8859-1?Q?UcM4j77AVRSGbqSJAmKBtiO0RN3g5f5x9PpNzfKWDIYDB/uLJhScp81I9q?=
 =?iso-8859-1?Q?BVUsSy4r9qkTLhYwxZpSu/58vCBsH/HemNj4NS6biFj7dOtZjJnrWPQWrw?=
 =?iso-8859-1?Q?tgOgtBGsvZ/spmbSNWX1rb0f4npE2Xy5F6Nyg65P6P/MtM93Vd/dxmJ6Tl?=
 =?iso-8859-1?Q?/Zy+Ft7qDXc4qpbNBuBh+qS1wyuGU4nhuPyTrZeHO8Q/llxhWm0zoe+wwU?=
 =?iso-8859-1?Q?C2qM6GouJYKI++CghJcClGpDxA3tdIxAMCqT4JqDRkymAZbiaxCa6FRVXJ?=
 =?iso-8859-1?Q?2lHSV8qFFbePe6+Rj4Sp34GuqXH4R9j0VUmXiHq6eqiq43fncCuotZdjfm?=
 =?iso-8859-1?Q?zf40BMbRCK0Fn8mXi5GlewAxjdiqjKllFOYhi+sf3fVHMm7UFCfti+We1z?=
 =?iso-8859-1?Q?cYmQ0ZH4G1TgRmh5I0Y8Vh21mnlGrZ+LUoQGoYxPqzQV/uklqsOGfMMj5D?=
 =?iso-8859-1?Q?IXPCu8zqKM0CWFskZuzBJuDJoMyVty79M/Nfz9ABpmTSn5SGcyWCKQUuaV?=
 =?iso-8859-1?Q?UvcDfOCvmmpV8LC/dkmv/K9lei7LYe8WrOOhPoOLDs8nNLdUiJOWaT9BP+?=
 =?iso-8859-1?Q?HmjvW+eKx831qFjjTBk9tGfzOnadiXxcE0f9m6k41oWux2TXfV++0qR8+F?=
 =?iso-8859-1?Q?NzmTkesRIFCGCOLyxoWOmzBfYQgEzAkXCQoG4SAVTBzrvIINBVM5TM3LdU?=
 =?iso-8859-1?Q?CEiEwY53HDVq7aL9ZZaaW86/vXoItYONsN78CS/H0hxiPqTsnKzUm0xG+V?=
 =?iso-8859-1?Q?eLImfK3ifwlfqAE380TRdKvmA36ftJMTsn5sEbUXLBhgDjNOe7MtNG74jP?=
 =?iso-8859-1?Q?V2P3URn+VkP1YWzllulVGP1zkdUc69ftWVY9MrPqxQwMndYJd6yPYuKFxs?=
 =?iso-8859-1?Q?gQ3jsAGA79MUJcNDJIofZhnQiAQ8KDFo9ArbZVpNeNvPLLAYpn294IOd9E?=
 =?iso-8859-1?Q?VaZ4b/75M4Hr1jAOX3FHhwKauC66J7Q6vLoUpVWB/70NsKxdBRV+idE8Dh?=
 =?iso-8859-1?Q?B/MHEWTZ7ufx2LcDn7qLpzCDf78QojTYCnJQEhAGwgC+9GCudC45HoHF18?=
 =?iso-8859-1?Q?v32cs0oGzWbdO2l7Ubo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10697.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q/Y5tuQpCpjKFaHHGOt96YZhHv7n4UqQxs5ROwIBZiI2pTgKOPNVx5WW/A?=
 =?iso-8859-1?Q?CakwBLGaI0uhe0B5te8trnPFQuF0P5uqHWdPkbNS8mvKoqzHm5trEfEWdy?=
 =?iso-8859-1?Q?P4Cse9zucAUCQID3eYWbNvliCZF0aMUWvLiq0eKWME9n0ZeuBiPAkC9Qrr?=
 =?iso-8859-1?Q?e4iE1gVY2fQ8uaIkUfiD1ODa727fa9PbL9FrkNZ85jvvhHiGUMk0gBop6Z?=
 =?iso-8859-1?Q?gnaBJXNeWD4XTd73LyBjjP+rVbtEjUXAYrA6KE3KRcIZmFD6EzXD7Nelvj?=
 =?iso-8859-1?Q?paIMdarz2OPSxHeH1C99UCoNITku4oS5AJKUaTTPb1JBkO0c7qGby+WvXd?=
 =?iso-8859-1?Q?gIs6yFrIwBKbu9x8wT8pnTzQW16HMmIA/hsr6t/bhAaRyjTd19wpDO5zTB?=
 =?iso-8859-1?Q?bx0evGXcQhholr38TRyBVFPqp3UTY0Jm98f2DY4g1j9+taSmiKhXatZAyk?=
 =?iso-8859-1?Q?Bh0TjOoygKuctpIt3mtFY4CIIl23S+PuqksMqBEseD71ZV65HWsxarHRky?=
 =?iso-8859-1?Q?UG7Osnp0Ig9IzDXne42S23adyJTA+vSO+WHaal0lOtyP6ECb3xnGLNHttR?=
 =?iso-8859-1?Q?Q6wItrdYt6JaO76SChs+0U1XiIg7v77RdNM1G3S9WoE4SuGjjSTUt882tF?=
 =?iso-8859-1?Q?GEQZ7N0cL4Hdf+lSqz27Fj/nIU/94es90msRTxVDvs9EkdgePaN5eSuTyz?=
 =?iso-8859-1?Q?ZMmMQzfV8YWEmYH43KFL7z0CHIxMeJMOni1pItLnQZYQlbERMg2IHXbONr?=
 =?iso-8859-1?Q?T+KEZ2mXv5Q6qYrzIMWsGvNXcaGFI/6zz9Rj77y8QtolDrRKjQ1hPkf4dZ?=
 =?iso-8859-1?Q?rcBnGcDwB+pUpo92dtwIKH0/yni3TcEIzyxkkta+IyINwBDwjRhmFv5qyv?=
 =?iso-8859-1?Q?OcbbR0p+1FsI55mv6XC68CKZRsVvlr0n3LTGG63B/Zehe+4Ji+v4XH7KI9?=
 =?iso-8859-1?Q?/L9dQW7STyNDXfJWIj1jTvscKOR2pVSpU1rYdtZQ3+bBurpTCIRLvxH3nK?=
 =?iso-8859-1?Q?xmBKcX65z24LudiwOvtWP+TM5RoN2O+kJ3ggluyS2yx9uHqaqeiNwugEQY?=
 =?iso-8859-1?Q?LHfL6g34+rtvA8P823xfRXMAdEQC/1aHLvizXTKFvZpB6jYUktsinvK3Lr?=
 =?iso-8859-1?Q?s2sxLVr0B/w6TbO3pw2Dtvvqlf0L7G/igOq+T7VXzr6rO5XS61Ry8RR304?=
 =?iso-8859-1?Q?10XFPVbjLVIMlQqBZDdabh+g0tdTdrHpuuxI+fy8NtfnH8wcOj2V5r8pjW?=
 =?iso-8859-1?Q?LBAl8hW5Av8SaJUyyTwyf6f3rJhFT1J9Mk41MOrA7RVcw0R8Vh8zbncWr/?=
 =?iso-8859-1?Q?lQwJ+QYZhGjBQUti4LghL+Vlxp5tlPZm8fuKRQhB0hIXFtfkyA6mh3z5rF?=
 =?iso-8859-1?Q?Z9kdokTQ7Xc9s+irlhJpiDz5t/QY3gOKMKGQKA0T7NDELboyPrA+vI+WeH?=
 =?iso-8859-1?Q?r22h7PzoBZNOrXTtghYtKTEDWjYbK/IuZu+vdBiOJM5efr5AnX0/EIuAZn?=
 =?iso-8859-1?Q?lh4BoScyQPvsH7PV+/3tfHMCOKfRIf25cvBVxJp/8jrgp+6b9+Z4z42z9e?=
 =?iso-8859-1?Q?4rcWVj41WHzLzpxDRf4w2MN/A0xfEgN18YoxeBn1SrK0EZnED/V3A55QGW?=
 =?iso-8859-1?Q?Djk3PYSAg/N/a1UwEJQRc2l49/7oVl49bjR9qQ7fqnmJBSlZYLVPy9FLRx?=
 =?iso-8859-1?Q?JHwz7n/g+7bmTZsVhYjf4uirt49+fV5HpVQAzLn6LEutPl2I/benBFQEM+?=
 =?iso-8859-1?Q?MV9pAVcqJfiBFNC18VGl7T+jldknnRHyl9QwYy/48suDoYjhdZ74gAAEO1?=
 =?iso-8859-1?Q?d0v3M4MFVA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb0c786-7216-43ba-6e85-08de59babe09
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 13:32:51.9876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sUUxsQE5wtWLyyVX2C5iy9Wj92k7hIv9WXRQXkuYY+Wb1QNEm/vmooOeP1Jvy8f36AfWX3a+Z1K9lahkCXzsaJ3ipFIZ8jxS69lX5cmjes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10806
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=polina.vishneva@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Marking the bitmaps that are found in_use in the image as inconsistent=0A=
works in the most cases. However, in some cases, like migration,=0A=
it's critical for bdrv_dirty_bitmap_check() to always pass.=0A=
=0A=
Instead of asking the user to manually request the deletion of=0A=
inconsistent bitmaps, delete them automatically if we can,=0A=
while respecting the possible edge cases like repairing an image with=0A=
overlaps.=0A=
=0A=
Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>=0A=
---=0A=
Fixed a small typo.=0A=
=0A=
 block/qcow2-bitmap.c                          | 111 ++++++++++++++++--=0A=
 block/qcow2.c                                 |   9 ++=0A=
 block/qcow2.h                                 |   2 +=0A=
 tests/qemu-iotests/tests/migrate-bitmaps-test |   2 +=0A=
 tests/qemu-iotests/tests/qemu-img-bitmaps     |   2 +-=0A=
 tests/qemu-iotests/tests/qemu-img-bitmaps.out |  36 +++---=0A=
 .../qemu-iotests/tests/qemu-img-close-errors  |   3 +-=0A=
 7 files changed, 132 insertions(+), 33 deletions(-)=0A=
=0A=
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c=0A=
index 256ec99878..ccc6f731b4 100644=0A=
--- a/block/qcow2-bitmap.c=0A=
+++ b/block/qcow2-bitmap.c=0A=
@@ -30,6 +30,8 @@=0A=
 #include "block/dirty-bitmap.h"=0A=
 #include "qapi/error.h"=0A=
 #include "qemu/cutils.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
 =0A=
 #include "qcow2.h"=0A=
 =0A=
@@ -958,6 +960,48 @@ static void set_readonly_helper(gpointer bitmap, gpoin=
ter value)=0A=
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);=0A=
 }=0A=
 =0A=
+int qcow2_remove_in_use_bitmaps(BlockDriverState *bs)=0A=
+{=0A=
+    BDRVQcow2State *s =3D bs->opaque;=0A=
+    Qcow2BitmapList *bm_list;=0A=
+    Qcow2Bitmap *bm, *next;=0A=
+    bool removed_any =3D false;=0A=
+=0A=
+    if (s->nb_bitmaps =3D=3D 0) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,=0A=
+                               s->bitmap_directory_size, NULL);=0A=
+    if (bm_list =3D=3D NULL) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, next) {=0A=
+        if (bm->flags & BME_FLAG_IN_USE) {=0A=
+            qemu_log("Removing inconsistent bitmap '%s' at image '%s'\n",=
=0A=
+                     bm->name, bs->filename);=0A=
+=0A=
+            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);=0A=
+            free_bitmap_clusters(bs, &bm->table);=0A=
+            bitmap_free(bm);=0A=
+            removed_any =3D true;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    int ret =3D 0;=0A=
+    if (removed_any) {=0A=
+        ret =3D update_ext_header_and_dir(bs, bm_list);=0A=
+        if (ret < 0) {=0A=
+            error_report("Can't update bitmap directory after removing "=
=0A=
+                         "inconsistent bitmaps");=0A=
+        }=0A=
+    }=0A=
+=0A=
+    bitmap_list_free(bm_list);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Return true on success, false on failure.=0A=
  * If header_updated is not NULL then it is set appropriately regardless o=
f=0A=
@@ -969,9 +1013,9 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
 {=0A=
     BDRVQcow2State *s =3D bs->opaque;=0A=
     Qcow2BitmapList *bm_list;=0A=
-    Qcow2Bitmap *bm;=0A=
+    Qcow2Bitmap *bm, *next;=0A=
     GSList *created_dirty_bitmaps =3D NULL;=0A=
-    bool needs_update =3D false;=0A=
+    bool needs_update =3D false, removed_persistent_bitmaps =3D false;=0A=
 =0A=
     if (header_updated) {=0A=
         *header_updated =3D false;=0A=
@@ -988,7 +1032,7 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
         return false;=0A=
     }=0A=
 =0A=
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {=0A=
+    QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, next) {=0A=
         BdrvDirtyBitmap *bitmap;=0A=
 =0A=
         if ((bm->flags & BME_FLAG_IN_USE) &&=0A=
@@ -1008,6 +1052,32 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
             continue;=0A=
         }=0A=
 =0A=
+        if ((bm->flags & BME_FLAG_IN_USE) && can_write(bs) &&=0A=
+            !(s->flags & BDRV_O_CHECK))=0A=
+        {=0A=
+            /*=0A=
+             * Remove inconsistent bitmaps.=0A=
+             * This is to avoid errors on migrations, when=0A=
+             * when bdrv_dirty_bitmap_check() could be called on a bitmap=
=0A=
+             * marked as inconsistent, causing an error and requiring the =
user=0A=
+             * to manually request inconsistent bitmap deletion.=0A=
+             *=0A=
+             * In case we have a corrupted image, there's no guarantee tha=
t=0A=
+             * update_ext_header_and_dir() will succeed.=0A=
+             * This would render some images impossible to repair.=0A=
+             * Therefore, skip it on the image open if we're in the check =
mode=0A=
+             * (and do it later when the image is successfully repaired).=
=0A=
+             */=0A=
+            qemu_log("Removing inconsistent bitmap '%s' at image '%s'\n",=
=0A=
+                     bm->name, bs->filename);=0A=
+=0A=
+            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);=0A=
+            free_bitmap_clusters(bs, &bm->table);=0A=
+            bitmap_free(bm);=0A=
+            removed_persistent_bitmaps =3D true;=0A=
+            continue;=0A=
+        }=0A=
+=0A=
         bitmap =3D load_bitmap(bs, bm, errp);=0A=
         if (bitmap =3D=3D NULL) {=0A=
             goto fail;=0A=
@@ -1015,6 +1085,7 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
 =0A=
         bdrv_dirty_bitmap_set_persistence(bitmap, true);=0A=
         if (bm->flags & BME_FLAG_IN_USE) {=0A=
+            /* Reached in check mode or readonly mode */=0A=
             bdrv_dirty_bitmap_set_inconsistent(bitmap);=0A=
         } else {=0A=
             /* NB: updated flags only get written if can_write(bs) is true=
. */=0A=
@@ -1028,15 +1099,31 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
             g_slist_append(created_dirty_bitmaps, bitmap);=0A=
     }=0A=
 =0A=
-    if (needs_update && can_write(bs)) {=0A=
-        /* in_use flags must be updated */=0A=
-        int ret =3D update_ext_header_and_dir_in_place(bs, bm_list);=0A=
-        if (ret < 0) {=0A=
-            error_setg_errno(errp, -ret, "Can't update bitmap directory");=
=0A=
-            goto fail;=0A=
-        }=0A=
-        if (header_updated) {=0A=
-            *header_updated =3D true;=0A=
+    if (can_write(bs)) {=0A=
+        if (removed_persistent_bitmaps) {=0A=
+            /*=0A=
+             * Bitmaps must be removed=0A=
+             * (possibly along with updating in_use flags)=0A=
+             */=0A=
+            int ret =3D update_ext_header_and_dir(bs, bm_list);=0A=
+            if (ret < 0) {=0A=
+                error_setg_errno(errp, -ret, "Can't update bitmap director=
y "=0A=
+                                 "after removing inconsistent bitmaps");=
=0A=
+                goto fail;=0A=
+            }=0A=
+            if (header_updated) {=0A=
+                *header_updated =3D true;=0A=
+            }=0A=
+        } else if (needs_update) {=0A=
+            /* Only in_use flags must be updated */=0A=
+            int ret =3D update_ext_header_and_dir_in_place(bs, bm_list);=
=0A=
+            if (ret < 0) {=0A=
+                error_setg_errno(errp, -ret, "Can't update bitmap director=
y");=0A=
+                goto fail;=0A=
+            }=0A=
+            if (header_updated) {=0A=
+                *header_updated =3D true;=0A=
+            }=0A=
         }=0A=
     }=0A=
 =0A=
diff --git a/block/qcow2.c b/block/qcow2.c=0A=
index e29810d86a..eb6da74d34 100644=0A=
--- a/block/qcow2.c=0A=
+++ b/block/qcow2.c=0A=
@@ -634,6 +634,15 @@ qcow2_co_check_locked(BlockDriverState *bs, BdrvCheckR=
esult *result,=0A=
     }=0A=
 =0A=
     if (fix && result->check_errors =3D=3D 0 && result->corruptions =3D=3D=
 0) {=0A=
+        /*=0A=
+         * Run the removal of inconsistent bitmaps that we've skipped on=
=0A=
+         * qcow2_load_dirty_bitmaps().=0A=
+         */=0A=
+        ret =3D qcow2_remove_in_use_bitmaps(bs);=0A=
+        if (ret < 0) {=0A=
+            return ret;=0A=
+        }=0A=
+=0A=
         ret =3D qcow2_mark_clean(bs);=0A=
         if (ret < 0) {=0A=
             return ret;=0A=
diff --git a/block/qcow2.h b/block/qcow2.h=0A=
index 96db7c51ec..542630bfbd 100644=0A=
--- a/block/qcow2.h=0A=
+++ b/block/qcow2.h=0A=
@@ -1039,6 +1039,8 @@ bool coroutine_fn GRAPH_RDLOCK=0A=
 qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,=0A=
                          Error **errp);=0A=
 =0A=
+int GRAPH_RDLOCK qcow2_remove_in_use_bitmaps(BlockDriverState *bs);=0A=
+=0A=
 bool GRAPH_RDLOCK=0A=
 qcow2_get_bitmap_info_list(BlockDriverState *bs,=0A=
                            Qcow2BitmapInfoList **info_list, Error **errp);=
=0A=
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iot=
ests/tests/migrate-bitmaps-test=0A=
index 8fb4099201..dc69bb9433 100755=0A=
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test=0A=
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test=0A=
@@ -197,6 +197,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):=0A=
             log =3D self.vm_b.get_log()=0A=
             log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)=0A=
             log =3D re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)=0A=
+            if persistent and shared_storage and pre_shutdown:=0A=
+                log =3D re.sub(r'Removed inconsistent bitmap.*\n', '', log=
)=0A=
             self.assertEqual(log, '')=0A=
 =0A=
             # recreate vm_b, as we don't want -incoming option (this will =
lead=0A=
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps b/tests/qemu-iotests=
/tests/qemu-img-bitmaps=0A=
index 7a3fe8c3d3..90743d4eb9 100755=0A=
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps=0A=
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps=0A=
@@ -137,7 +137,7 @@ echo=0A=
 =0A=
 # Prepare image with corrupted bitmap=0A=
 $QEMU_IO -c abort "$TEST_IMG" 2>/dev/null=0A=
-$QEMU_IMG bitmap --add "$TEST_IMG" b4=0A=
+$QEMU_IMG bitmap --add "$TEST_IMG" b4 2>&1 | _filter_testdir=0A=
 $QEMU_IMG bitmap --remove "$TEST_IMG" b1=0A=
 _img_info --format-specific | _filter_irrelevant_img_info=0A=
 # Proof that we fail fast if bitmaps can't be copied=0A=
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iot=
ests/tests/qemu-img-bitmaps.out=0A=
index 74b81f703b..8062ae1114 100644=0A=
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out=0A=
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out=0A=
@@ -118,6 +118,10 @@ Format specific information:=0A=
 =0A=
 =3D=3D=3D Check handling of inconsistent bitmap =3D=3D=3D=0A=
 =0A=
+Removing inconsistent bitmap 'b1' at image 'TEST_DIR/t.qcow2'=0A=
+Removing inconsistent bitmap 'b2' at image 'TEST_DIR/t.qcow2'=0A=
+Removing inconsistent bitmap 'b0' at image 'TEST_DIR/t.qcow2'=0A=
+qemu-img: Operation remove on bitmap b1 failed: Dirty bitmap 'b1' not foun=
d=0A=
 image: TEST_DIR/t.IMGFMT=0A=
 file format: IMGFMT=0A=
 virtual size: 10 MiB (10485760 bytes)=0A=
@@ -127,29 +131,13 @@ backing file format: IMGFMT=0A=
 Format specific information:=0A=
     bitmaps:=0A=
         [0]:=0A=
-            flags:=0A=
-                [0]: in-use=0A=
-                [1]: auto=0A=
-            name: b2=0A=
-            granularity: 65536=0A=
-        [1]:=0A=
-            flags:=0A=
-                [0]: in-use=0A=
-            name: b0=0A=
-            granularity: 65536=0A=
-        [2]:=0A=
             flags:=0A=
                 [0]: auto=0A=
             name: b4=0A=
             granularity: 65536=0A=
     corrupt: false=0A=
 =0A=
-qemu-img: Cannot copy inconsistent bitmap 'b0'=0A=
-Try --skip-broken-bitmaps, or use 'qemu-img bitmap --remove' to delete it=
=0A=
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT.copy': Could not open 'TEST_DI=
R/t.IMGFMT.copy': No such file or directory=0A=
-=0A=
-qemu-img: warning: Skipping inconsistent bitmap 'b0'=0A=
-qemu-img: warning: Skipping inconsistent bitmap 'b2'=0A=
+unexpected success=0A=
 image: TEST_DIR/t.IMGFMT.copy=0A=
 file format: IMGFMT=0A=
 virtual size: 10 MiB (10485760 bytes)=0A=
@@ -174,10 +162,20 @@ Format specific information:=0A=
                 [0]: auto=0A=
             name: b4=0A=
             granularity: 65536=0A=
-        [1]:=0A=
+    corrupt: false=0A=
+=0A=
+qemu-img: Operation remove on bitmap b0 failed: Dirty bitmap 'b0' not foun=
d=0A=
+qemu-img: Operation remove on bitmap b2 failed: Dirty bitmap 'b2' not foun=
d=0A=
+image: TEST_DIR/t.IMGFMT.copy=0A=
+file format: IMGFMT=0A=
+virtual size: 10 MiB (10485760 bytes)=0A=
+cluster_size: 65536=0A=
+Format specific information:=0A=
+    bitmaps:=0A=
+        [0]:=0A=
             flags:=0A=
                 [0]: auto=0A=
-            name: b2=0A=
+            name: b4=0A=
             granularity: 65536=0A=
     corrupt: false=0A=
 *** done=0A=
diff --git a/tests/qemu-iotests/tests/qemu-img-close-errors b/tests/qemu-io=
tests/tests/qemu-img-close-errors=0A=
index 50bfb6cfa2..d72567171d 100755=0A=
--- a/tests/qemu-iotests/tests/qemu-img-close-errors=0A=
+++ b/tests/qemu-iotests/tests/qemu-img-close-errors=0A=
@@ -81,7 +81,8 @@ for max_bitmap in 6 7; do=0A=
     $QEMU_IMG commit -d "$TEST_IMG" 2>&1 | _filter_generated_node_ids=0A=
     echo "qemu-img commit exit code: ${PIPESTATUS[0]}"=0A=
 =0A=
-    $QEMU_IMG bitmap --add "$BASE_JSON" "good-bitmap"=0A=
+    $QEMU_IMG bitmap --add "$BASE_JSON" "good-bitmap" 2>&1 | \=0A=
+        sed '/^Removing inconsistent bitmap.*/d'=0A=
     echo "qemu-img bitmap --add exit code: $?"=0A=
 =0A=
     $QEMU_IMG bitmap --merge "good-bitmap" -b "$TEST_IMG" "$BASE_JSON" \=
=0A=
-- =0A=
2.52.0=0A=
=0A=

