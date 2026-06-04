Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6240FCD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 01:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUwUC-0005B8-Q8; Wed, 03 Jun 2026 21:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUwU8-0005Ax-HZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 21:03:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUwU6-0003qg-Df
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 21:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVcgTNHEziZu3nCHVAnmJtT5E+chEaHOXeRFqDUwGAmb6VUHWkEcNiYjrHnktog5Ry33/FHLRBtu/XNAdKW6hqL+DtMsk6vlWsH7M6W44iKI8/ojNAWo2g4flCrdXB/hb33ZeMwOQlQ7YU39yA8RRrGXtDEiTlttaJ1qaCbdZQizCo57yEhwUnubC+QAZLUU3z6OFNlsllwWtvUcyR73z0Ebmfa+k04ivby8RwMwklR4cuONsHYHN1A0XkLK0jkEeN1CrC5zNpy17/+6ms+dI9243ybuTNJsy+3iSLQaid5iVjjpXhu3B3eL7je3oll7lbbO0ycp54cjEcf4C6VE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKZQYWm0lv7Y+BI8Ppi8zjdBjfaXa/TmXZs/QQkpY0I=;
 b=ZMYU+iCQ4kDs6SiPt3Hz546W56YnE15rv3GIPviQX73B329W+5QBLoPoF/N7v6KTLYYd5CwB0dwOy7SvnSGgigf2+mx4ucXZ8HFCUB47RhCXY0H1jNMSa3WMWERFGmh7u9TiOTOex5AwnNT1WrP/EMQW0LK8h9n0e8oFQbtGfhqttzRT2bzKEVUSdU+c8Lg/PUkr+Lak3jRZro4kGos6AvCgyl40Gm4L75d8a9HvQ9kAJ0LMF6XmHd859EEsy6TuufTznU7axxroQ0+E39BaEcdF80SJzMm4+w5RBsGRDWyEaa5teQzPKNdQhvqgY6IXivSfZ0mygCMwKONgV4HNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKZQYWm0lv7Y+BI8Ppi8zjdBjfaXa/TmXZs/QQkpY0I=;
 b=X8Q7fiFPXQqHT4AdN2V+OC3KfEN9JS5DfAd/nOdhsN7+UDAU7IEQzqlYav9oFnCmM4/+qBuRDelxDZQSM/AFf1fPmrMNE/uASOIC45/cHDFHzeXlR2ADXN8KfGTiEfsLN78U7XaZHu2zL7gqQB4AigOGPUOvntl3lVI4D/ltNMzOxwSAYsH+pY16t1ntgY7EQfgV4B4eainupTkZxsXEBLiwBP1YpuDkdR6M+ZSNXGfYn87MZbGDuvIraZhDKjNLlaQg7ZkFqMufwPslKlGxy5xw/s76u6n75V2LAcD1oJy08kRGYUTgZg0BjW/gtI7PpOlVS+2YDRBsqgWCBErB6Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYUPR06MB6003.apcprd06.prod.outlook.com (2603:1096:400:352::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:02:47 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:02:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, "clg@kaod.org"
 <clg@kaod.org>, "komlodi@google.com" <komlodi@google.com>
CC: "nabihestefan@google.com" <nabihestefan@google.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
Thread-Topic: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
Thread-Index: AQHc87Ys+CbS7eX2h021KXR73Tnw6LYtk5rQ
Date: Thu, 4 Jun 2026 01:02:47 +0000
Message-ID: <TYZPR06MB4980465C29969AB4F3FA04A5FC102@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYUPR06MB6003:EE_
x-ms-office365-filtering-correlation-id: 1888d0a5-1f0a-49fc-c98e-08dec1d4fdf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|6133799003|56012099006|4143699003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: YJRuEg8KCDNd9307jMY3t6stYWBwpbTCpPuj3RTEUuspt0Or7b1o2LXhWPJPQ7JZkXAltfNVafF4ENIkCVr+ICRTRa4APciWakbiXCQrgwzha6avbtxtxXGjAGhK5m62RYcmkipCnXXZUl5XiDSCRP5jKGRZ5i4mTzi8ZRFzFPiW8dqjBR3MLoK13/nBiZVhHSl070eTXpYbWwOsTB4VfjVy9j4hTRruPD+AGmQgnJO1cksJfTQYbUILy0Kxck+O0rZFufIqMkf1EBvmZXJA55uqXtF+g51X+bAZKWYISmcDNzF81cWFyFc9MFfpwjEt/hjT6aGeCimFkF3u2OFtY2Gw9OS4fy5TXOZBLNEiz7JSfSh84T4JQXer98wPpnZoopda8b5bPUdqWunLuyWMn7OCz5KkYP+/b039QRUFe4YRduH/cBzAx1WnjjrtzeSExewXvnXWcfXd/GzYO9VOLoYSYm7ojBw0KI3mB6Cd592rgp1EIAxzjUYx8wAEVJ8dP7BMtymLNjhES1JxSP+nbtWbanOll0egp2KuarfQHfWOvxrj6E/2fwk6tlehJx8mXGa9IoMOJ1kG8legIRWEIB8XSP12HrcOQwQSPnu6uX0Q8O569oJde3LjiYQYWxXWuMQ2ZWHwK6TwEtDygLQlIGOz89nuGuCMdXyK7nuUy9qEEANmN3zuI+hmn73NC1Um0+EW2ZGWSEsBMLuOPvjRjeJxR5/oVytE2OZXEvauaQDiL+IoLcKDGP7bDwlodTwC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xy5JOaWfhfo/hf1J5BBn561zA7KnJf/tjCUxRB1eIzTdGiAijWDeNEHbHF9N?=
 =?us-ascii?Q?mGQsT/HeeKRA+rzkk/sHXKl4bGGrNb45NcjMK1r0pYWHb9ueG8WaTujxudTT?=
 =?us-ascii?Q?K2XapABP4ruAK+7rTKRpjuGJC8HWDayP9sKrSwGMq3HMX0xr0uHmVItt43pQ?=
 =?us-ascii?Q?Qtn1/jJ3X3d2e3kjOKIJ+OIE8wDW/+WegFeOrFzm+lwodjrdCpO4Yhdhzgx6?=
 =?us-ascii?Q?mzssZCHgUetAJXFfR+MkvyrvXfk8kAXwtymyX22tfIgiKYSZTspl6y+A7Hw5?=
 =?us-ascii?Q?ugUm6fhAnNgGzyxATk2n/kpGgMjBKZ62SeZrWDzXyjhX/gQOfZ+T3F37eAFY?=
 =?us-ascii?Q?iM7YnQfnHRIszTMfI/93gQuk9wlP9Wn0K9YZDHft7ghQNi3VHMVxdf6Qk0Q+?=
 =?us-ascii?Q?PVbMOYhwW2G0c+KtJYmAgIUkLk+fA9907MwnkRXCAyRXlTuy3Ou2KAxVBBcC?=
 =?us-ascii?Q?OLR7BhrQtv3zHtwEIo6trhseYIYO1nrclopbRnI6jBEP+MA30SluLiaSuW15?=
 =?us-ascii?Q?KA1oUXGR2l/ryErKQwZEKOPNh+I4H50M+R1hPI6cR+zxd20Vif8mmr3QzjzS?=
 =?us-ascii?Q?p7fcdZPyntRwsYD+6iyiAxvJeOqC0FtlLxmTee/rLphEWwoADyel6wKy46dx?=
 =?us-ascii?Q?SemrtzydWKJnK+7tE1nyZyqa/cllyjl/HtfmnIrP6oLKT4VCFF2rdlYYuE3Q?=
 =?us-ascii?Q?FP2S5h7nx0y93NRXHWNYnFJE6SAuNqhke5OOZDk1897k8bKu3HR30EoXSht8?=
 =?us-ascii?Q?/fHtP5Bm/pzIKTJtISfknL3dCcd8mL/3gGW6ZBdK4DRq6Ck1/vlmKx33MbAy?=
 =?us-ascii?Q?RXpJz1DmVZJGTUW5CLnV2MfMxtRspiOGnyae29b47zna1j0RyhQ/cYVYwmWg?=
 =?us-ascii?Q?uI0zw4NTQQXCvj9AvxFIe/2x317Glj6IP/aJ8ZCMpe9Qr237PKKbDJh6AkG8?=
 =?us-ascii?Q?PMBBLDCEqL4hFXMedt7isvAIfUEyOIBfck+V0IFhZX3TQsehglKsJ2ZESGzc?=
 =?us-ascii?Q?UXjInjcZpYzctk6GQQpeRcLZfcl0w0R3bitJlFg4uxBADPzLQYn15rmqfjtb?=
 =?us-ascii?Q?2U7On6c1vyomL0QeTcyjK31+pb0k/w3sYBTMtAtYdZrobLxpug38VVDmK91q?=
 =?us-ascii?Q?OBpbpHPUOhpHtaulnO5CFdDrpi7pnt3Vcn5b+eVPetQM/I1CC8Da3QuWVg7P?=
 =?us-ascii?Q?8/oW/0YIZ3d0ZWFRIPU4dM98+He4PVBmWXD/cDlh5dsylVRLwRZW2elrAYq4?=
 =?us-ascii?Q?ut7YNtXzA1gmq4lSxX//r1aK4vXxNmTKsxcuj43VChh2/yAxdyxQv+eEekyV?=
 =?us-ascii?Q?OyI2VwLyj/dfSIbU3kQhAHpGqs7OiNB2oZmaeMslUexwoiRgZ72me+V2V+sx?=
 =?us-ascii?Q?yhw1ncB85FTtDTJdq0vjf9WDL6gCAhBkt9MBfUYS1+4VR34gtcgt75LiqhY+?=
 =?us-ascii?Q?9MDwlgh1rLze3wCTyVCWN5ikV9rP6j4wPCzmboNYHzR/1FZwL9mnBFfAaM2r?=
 =?us-ascii?Q?lPIWXCH892lU/00URyi2+ZWbYxHHFWzWw6d5QiAdthql4+Q6V1xuD63RJEDw?=
 =?us-ascii?Q?cjRfGUyLpmGhxAwrO5Iz4Iu8GtHqXVEcwWz9PVzktMQs/xHasm5A5rwKUSoX?=
 =?us-ascii?Q?XRLl4beVmplvNEhxqRRO7946yi66HuZEFhnovZicBDKsY3ssswwysJQr66wq?=
 =?us-ascii?Q?6TWyriLvVgyLJ1YXJWy2yxA25mTfYnms4NgPzuIUZYeJMjbNSpv4N5b0JUNX?=
 =?us-ascii?Q?mCSciXu82A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1888d0a5-1f0a-49fc-c98e-08dec1d4fdf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 01:02:47.0930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0Aq0zsPvINXV4QQjviOVBRKii38s1+oYiieMtQmIYBnm/K/HehZPoJREtuX69k1pb7NbdjMDS/y0S+zYVDNHKs1PxgmY0jTWbFgaoWy4B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6003
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Jithu,

> -----Original Message-----
> From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
> Sent: Thursday, June 4, 2026 8:08 AM
> To: clg@kaod.org; Jamin Lin <jamin_lin@aspeedtech.com>;
> komlodi@google.com
> Cc: nabihestefan@google.com; philmd@linaro.org;
> jithu.joseph@oss.qualcomm.com; qemu-devel@nongnu.org
> Subject: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
>=20
> This series corrects the DesignWare I3C controller's advertised CMD/data =
FIFO
> depths and cleans up the misleading queue-capacity field names that made
> the bug easy to overlook.
>=20
> The Linux DW-I3C master driver reads QUEUE_STATUS_LEVEL and
> DATA_BUFFER_STATUS_LEVEL at probe to learn the controller's queue depths,
> then rejects any transfer larger than what was advertised with -EOPNOTSUP=
P.
> QEMU was resetting these registers to 0x02 / 0x10 instead of the real 0x1=
0 /
> 0x40, so the guest believed the controller could only do 64-byte transfer=
s and
> failed any I3C transfer with a payload larger than
> 64 B.  The backing FIFOs were already allocated at the correct size; only=
 the
> advertised reset values were wrong.
>=20
> Patch 1 fixes the reset values, and additionally drives the advertised de=
pths
> from the queue-capacity configs in the reset handlers (per Philippe's rev=
iew) so
> a configured override is no longer silently ignored.
> Patch 2 is a no-functional-change cleanup renaming the queue-capacity str=
uct
> fields and device properties from _bytes to _words, since the values are =
word
> counts passed to fifo32_create() -- the old names were what made the dept=
h
> bug slow to spot.  Patch 3 keeps the old _bytes property names working as
> aliases, since they are user-visible and shipped in v11.0.0.
>=20
> Patch 1 is the actual bug fix and is tagged Cc: qemu-stable; it is kept
> self-contained (using the _bytes field names that exist in released
> branches) so it cherry-picks cleanly.  Patches 2 and 3 are master-only
> cleanup.
>=20
> Note on the IBI queue capacity: unlike the cmd/resp and tx/rx capacities,=
 it is
> not advertised to the guest through any status register (the hardware exp=
oses
> only IBI occupancy via IBI_BUF_BLR / IBI_STATUS_CNT, not a depth), so it =
sizes
> only the internal fifo32 backing store and has no entry in dw_i3c_resets[=
].
>=20
> Changes since v1:
>  - Patch 1: drive QUEUE_STATUS_LEVEL / DATA_BUFFER_STATUS_LEVEL from
> the
>    queue-capacity configs in the reset handlers, in addition to correctin=
g
>    the reset-array values (Philippe Mathieu-Daude).
>  - New patch 3: keep the renamed _bytes properties working as aliases so
>    existing command lines do not break (Philippe Mathieu-Daude).
>  - v1:
> https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@o
> ss.qualcomm.com/
>=20
> Jithu Joseph (3):
>   hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
>   hw/i3c: rename DW-I3C queue capacity fields from _bytes to _words
>   hw/i3c: keep _bytes aliases for renamed queue-capacity properties
>=20
>  include/hw/i3c/dw-i3c.h |  6 ++---
>  hw/i3c/dw-i3c.c         | 58 +++++++++++++++++++++++++++++++----------
>  2 files changed, 47 insertions(+), 17 deletions(-)
>=20
>=20
> base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
> --
> 2.43.0

This patch series:

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

Thanks,
Jamin


