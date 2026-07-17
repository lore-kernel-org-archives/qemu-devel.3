Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E08C44512
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 01:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkXfi-00063J-33; Thu, 16 Jul 2026 21:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfe-00062i-GM; Thu, 16 Jul 2026 21:47:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkXfc-0001j6-W5; Thu, 16 Jul 2026 21:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT9k/jNqSloIwv+aeIt/9V3Wdjj87LEhdyf/Hl2IH+YXXAPC2uoY3txZE2mw+Wb5SFL/Lru+DIrVY1QBEDk+nkoxYb0aaqGZWiZC2m/bHVQKgNWkLcaQua6trCwPnMOFZmbOaFFBj/fdwiRzGlGfRas8FLSCBP5vUbrmGt2isfyUS36p0o+eNbLhd6sloY61JMiZoWWL7KProY7UF70r4iK6Q4j4bbHi6nRFLy7Uslj+UiKmAKChWIujqFYyaE0HSnkRS2a2aE6TCeQM6Oi5P+agCaSqAHoHwfUI5stlIjay6NWORkcG0pqTIJQTJmYMj2RZQ9ivdPXn/Oa4+fuRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV6esXMmLD0/CGcJHDlMvm7/i1D64lv0/nJcTHpv4Lc=;
 b=HKArjt86qPb0Mz1UeN7jy0aWRoLEXSRsI4bEY/Uaj5DV1qD8OrSoa9euTaSSkMyy04Lhi/0tWHo0OJHbz8+MQqrZAoNt2p/SVG+CUdXKQBfF86vb6B3Luks8/5A5re4SUAeKgm9vOn4ftJgxG9rg9UyGXQcMAisJ9OtyKxz3wF+8qAWKZY2QrHt/XROwGFw2GBjzb5ExpA8/h83eeS2ucQ8tkt5VpUdNxezcoknfXy5VnVFbLrnfLQpByt/S3xM8X4Nrwgi/FVuKZfUNOlcqm7k8WKk3iDZrdFUQNe7ISeo7Gw+LX5OAEZI0/RK0ueln3Xl4U9HIaIWPAyhvJCTz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV6esXMmLD0/CGcJHDlMvm7/i1D64lv0/nJcTHpv4Lc=;
 b=DNhLdlsOsGU1KxzPjoJ+1Ye80404/I7e1Onn++y6CMQUONcIVSkv6vn1O658Nq9no2IxFKT0Yyu35BXfDWx5hQFYbPZBJBtbc9U4mbNO2hVyqp3Nl1rxYOHKjQhY67ZRAFtZVeG6w4wIEUj+FJoCiuUQAdQkMPN392IPHOHB65rn8PO4sS9/mO+OyvgyLPoX7wtwKXAd+bAHu35vB9Waux3wbA3CDKFebfTSt+Frc4gnodGyJhZfHImqlt6+NF1iKdeIb25ZNu/2uE2JaGSQl4n+k3fvLb+gAhaNjjCBRohQ672YhV4Tyojt1bfD+KiBmlk38zXeqCC0cWph0cq+Iw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUYPR06MB9015.apcprd06.prod.outlook.com (2603:1096:d10:74::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 01:47:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 01:47:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/3] hw/ssi/aspeed_smc: Bump vmstate version after
 ASPEED_SMC_R_MAX increase
Thread-Topic: [PATCH v1 3/3] hw/ssi/aspeed_smc: Bump vmstate version after
 ASPEED_SMC_R_MAX increase
Thread-Index: AQHdFY4rxqckSWEwFkSu1flEV22jgw==
Date: Fri, 17 Jul 2026 01:47:05 +0000
Message-ID: <20260717014701.1683876-4-jamin_lin@aspeedtech.com>
References: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUYPR06MB9015:EE_
x-ms-office365-filtering-correlation-id: c42e2159-af3e-4877-c003-08dee3a54e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|921020|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: H9tNjmGSwFfgVbCCT69jFrV4ePaHh++qyJbNXi1A13uhrz615a9lfyxIeAkKot+rAQLaN34FbNkXB4vWaLV/hZhny2zMQmcm3prLB/fd6kDORyFh+gLRDHYs0ZtNchrk4lZ+lUkvrR/9mziSMcK413f2S3gAKLI3weMWjqpKoHOaFbILbXlXF+E5YtKDbSbWRy1xJRPMj7HcLSuD2r+fIbfguuI55iuobx1IaNJS3mnXwpskbsRlqT+SvKl9W3nRbnyMZJUFv9488aColjhYQ5H7iAcyHWepfnrqm0YVErPkUkk7EwIoY83q4tnLROq8QyGWwXY4Q3gvaDOXtV66+uZfJ5AAxYisD5nqZnjfIhxMG9qFq7RI68ps2lEkCa86z9yuNq1XgHu0v/SCI4WVWsVO0wNPZu77y9dPAGF6ynvlTP41jmIXh6KsgY8A4pJeS0MwVMZbpA1FVprCl/k1Mb5ejpyha1HPAkidKmDmvLn2+3AKQV4A6ABA0lpe24/dU9pqC/ksmgGBwNpY1B0LNTJCQjrWYKl8SSrOf5KkeBt8BbvXF6tUEV1pTz6jhrQTAsIYhIuD60LNKE7elrAv6/FF7so2M1PqZ6dziCrD+1Y90ZQcdGq9ODj3bf/0YlgOEYYTEZ7bZ9mNlB3nUvBvaEqylAWdVSzKNQv6th7tSUemJQ2tHDJ0o7jLcOTG8cT+5LLh7VUnwvpesl6+GSmHl87+Jk8wtGod0pc5kqcxK+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(921020)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7LD6oMtW2c5TrZexUp2JILN7dpeTvBYVc1wg7QlcYdbx/leRzTGG9No0Fr?=
 =?iso-8859-1?Q?8KyvH03diBtv/x3aaHvg7CkcghPWbxpKpJc9Wq60N2y9jqVT1VKSZkAXxz?=
 =?iso-8859-1?Q?T3ZLR2Ex1hJBdORiNfRMU1MD15mTC6otg9KRkafL4pfXixXjwFNmXj6G++?=
 =?iso-8859-1?Q?gfg9biYidIAlNzKPTvUkXAg2eszacTa82fySunClQPVI6UM9bVrEQz20sY?=
 =?iso-8859-1?Q?66Nlz0r4uRQCr5cUuMu0iq9riPUPM5wFeq8BW+dJ1lMbZ4AgxMP5R8qgMg?=
 =?iso-8859-1?Q?+oVRNZBaTmgGFs4HIo5UCq9elhmlKXHhaowxBBFJhdwO3oL6lkcUpfL3Cg?=
 =?iso-8859-1?Q?SFNsnqTz3JduJDcrJcOSahRS0a29N4lUg2zuthB4BkT2N9ZF1vFEA+BJJ1?=
 =?iso-8859-1?Q?KBII67e9ZEpSwKPGyUbBS0Jqdjwq1C2F+439fvBc5DaAGQOHPl37u4+ZV0?=
 =?iso-8859-1?Q?Wvd/nni8vaZj05SYT+Gw4LelgHTFo2enOIX2Rs6Oqe6ER8bK/lkcN4JEq+?=
 =?iso-8859-1?Q?vJ7TSS7+I/a/aBHi/lgBYcG9QeoEpX1WT8bd4/4V0tutoz1+V3qQMm9Y0C?=
 =?iso-8859-1?Q?96wCCzU/Gjk4d0sXkRg9uYo7adTTl/07LtgP6J6NwOKeDIJ/vtNi1qugwk?=
 =?iso-8859-1?Q?DmR8RVvx57mDwRJC01yfcGGSIt4fHFtoELJp2x2qik0YUrSYnjyMI+HH2Q?=
 =?iso-8859-1?Q?Zm7T7KWB/mVIaWBPLnQfnPjdp4qmE53mbdhV8dWFenPLjp+zDGZIDHT2uO?=
 =?iso-8859-1?Q?94q0r23xG6FPZO9hsJ8iPdAxnQVz1iRKAukwp0M5BvlbMZsIy3wh8k+vLy?=
 =?iso-8859-1?Q?IGODLICoeIxxKAAXlA3zOU8k81incC7fdD6y12pGi0TLJJV+Kar0I34+rM?=
 =?iso-8859-1?Q?A0Fgp4mLcZ7Ey31bu0IuOFEdbfQ98cR6/BnxtQAau4jcVXRa/4L35agtys?=
 =?iso-8859-1?Q?deJPuI4AG0AV7szK4P+lZ95Lqa/IrEwUkaJlqp0C+D74mBHgnJ1aaA6r/F?=
 =?iso-8859-1?Q?iCwcdP4Ue4PpuZbwzPI9bBBHYKiLoJDJR2MnKlfJFSe6DOMe7teMJr0YnY?=
 =?iso-8859-1?Q?2U1rkX8j9l0ymkZvdydeROVidqR4n7KOaMTRkCzWRLtKkj0Zf+I0rkEUQW?=
 =?iso-8859-1?Q?DnjKNN1odKnSAjcqQx1Nht+wK37F3BVcZILA7pAtjtd3E5LPNNmM3ZgWjv?=
 =?iso-8859-1?Q?452psnL0eerlCRKK2xpxjstkfQL26K+CXsQGimqTVnTS81FjIA2dyb86hr?=
 =?iso-8859-1?Q?HCZwBb+RIwJToEZLBHtILfqp9Nol0KPJ9H7TkNILEfbwVHJ4XgeTwnEJha?=
 =?iso-8859-1?Q?CEcX8H8mOEoaEIEJLG6IvUo+yiF6UP7zteiAeB/G5hvjvomCpxAg8suCoh?=
 =?iso-8859-1?Q?mmZfuUEMnwtoFNpHxhR/yKkO1pKq19czCdKDOg3LVDJ1/d10Cuslxr7SGT?=
 =?iso-8859-1?Q?QQvpVUBUM/XTMuVLEqJ6qFzJrM911Ob9KxO6BejBfZGcWqpBnL/fMnHdTP?=
 =?iso-8859-1?Q?j44L2099HJE8m5DI48/R56mdUsQo/xfwDPU2pK/5tW78y2BvI9K88kYHKZ?=
 =?iso-8859-1?Q?Qw37cNhnNQjBL59DwhtjmDuvC81pnIoNH7kzkKP8dbHCm9nFsPPUFeiLln?=
 =?iso-8859-1?Q?hP/cK5bP6jUkgxFzfF6s28KnjfTwNpXmP0i4UPQF3Bn3Do6sOIxGePr8LV?=
 =?iso-8859-1?Q?2vn77XV1Us6YfmHIAL6jdBd8u72tfejWrGzuB4syLB5urM1kEVBqSeCBqR?=
 =?iso-8859-1?Q?r3HPAgIt1xAPK4gG48oUnmhRy5/Sx2AGzSLrP18Szjtw3eEUMqhA4pxRkY?=
 =?iso-8859-1?Q?oZ9uO4DC0A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tB4swLBC+dseaKh9Dis/1ez7iamcgMZWCy99Q3FAR3VlUuKsFARF7uMg8zv78RDFSN54Bz30Iaee4TXfxFSraSmlaY0Db7v2sgXnf2GlMIxqTtCpRrKNouLyUsca1PdZsepA7ihxxwCPUqfeZfZ7eBhTkbOsUMAcA2YpzXEwyfSa0JlMz7tKoCrOD9HBrfFDXrASTfHDkLAaqyoWO99otVVnnZF39jhxZ71XrP5xvUOZE9NfWpQNddQLRczlhVXXewkmro83b1uXjRdalji5EXn857rFSFoV0Tl3nSJq7nGxv0m9qxA7qsI+s2L5CaTCzaqqzh2++aHf8zlqWTriZA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42e2159-af3e-4877-c003-08dee3a54e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 01:47:05.6922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkcKqpPtFsHR89ysFukc5zdkaeYVXEWYMy6rjtnMW/bhYTaWQ+j66EdhPKHVCAcV7/STkffMZ/zd5h/zkd1V05DyJmeK9krSsx2NBanYi9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB9015
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ASPEED_SMC_R_MAX grew from (0x100 / 4) to (0x300 / 4) to cover the new=0A=
AST2700 data fifo registers.=0A=
=0A=
This breaks migration compatibility with older QEMU builds for the=0A=
affected models, even though Aspeed machines are not officially=0A=
covered by migration compatibility guarantees.=0A=
=0A=
Bump version_id to 4 and minimum_version_id to 2 to reflect the=0A=
incompatible format.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index 5cc4dd5e42..bf596f7b2d 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -1218,8 +1218,8 @@ static void aspeed_smc_realize(DeviceState *dev, Erro=
r **errp)=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_smc =3D {=0A=
     .name =3D "aspeed.smc",=0A=
-    .version_id =3D 3,=0A=
-    .minimum_version_id =3D 1,=0A=
+    .version_id =3D 4,=0A=
+    .minimum_version_id =3D 2,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),=0A=
         VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */=0A=
-- =0A=
2.43.0=0A=

