Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A1D58E4E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwtvc-0005oF-OR; Sun, 01 Mar 2026 22:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvb-0005o7-AU
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:39 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvZ-00008k-7l
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug+9jdJ+/zaNCQw3eAXTbXBDnmdm+zMyFLOWNsz94w0LL6NxqKDl3UkfhuWB4Sy8FvXwo3/a8tl8PKjTy3aMkfv1yx+QndEoFuCBztCDtFCywVHhMwRTBa5pRxtMiXbvfw6/JcWc5MjH/cLnhgsW8QwvmQf96D17q52uQaGSs2p5JkXTrcaVYzKckjhpTHy4DFpCg5TSo8rb3f+7NgnDWkXSlXncwfDEi5yEDntw3Iq88OjcsVzaYeicmN/U/CIlkdAAcWF2W/5LSeoShRKlpXMqCiSzGZU3dKrb/GaMbMnxB7JVOz/4WyEgdHwYzzWitl6tdVi1KCubOjO1k2Z/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyEcFEkPmKREHttqXq6GEEGgbMmtcPOmslYSoyUneX0=;
 b=Ljyg+BIzhIJ2Wv48cCnBQm+wjdYY5yB3CFDQetN17AbFoUDOYYGUYgKKJtIBbWrwU7XCdEniBGPdn4sMXujpnfGWs8vkJQT4RfDP5+8S07dq8VzCiYknGu9pQAVAAMwvY+rD0zRwHL9fwv+WFncdUWcjBxCsnqGPP2A8IGohGWluCZeI4MrFhrbe095YFk5n+hPFLgrNuP8uHKcHcVmutMjjS7LeqXVLdTYmb2s1j/x27t15VIHC0AC789KxRrefXvnPnRzINQtUi0gqBWNT1nAW5C4WbFzaESzocJNEOd2o1GUm4m+KrGpEltKPEv2KlSvEFQOlfeG7iW1oRSjMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyEcFEkPmKREHttqXq6GEEGgbMmtcPOmslYSoyUneX0=;
 b=GiHdTj7M3uOmVHxCbE9yRD2ClA7gmpUBH7r40+4kQkldniIxBVkMJwUj+inS90ZpVFj7p2hD6G0YEVeCRu2EFmMaMtjmsiDcptZpmXN0h8pU/wKBINbY9sB/770PMPDKLdHyyhZ+wGLurKND3ugC/yxlZwCnJRyxNG9kFZ5QgaSb1ZUbzui17a1fKaC/7WR+YN/i0fm4d55Q6uVi4Vf8SyEuTK03eGflIdr3sJGOdVhvHsbqTCYtFu9C/s+YzWA2w+YH/+ahi1eOaNwS6GKx/4XP91rNd2bvQPVbXvWBEamPcvPv4fwGwdvSWvpBSEfZ3xR1NlvKMV+ZSfYGc2QXCA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6791.apcprd06.prod.outlook.com (2603:1096:820:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:26:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:26:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "jithu.joseph@oss.qualcomm.com" <jithu.joseph@oss.qualcomm.com>,
 "clg@kaod.org" <clg@kaod.org>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/4] hw/i3c: Trace fixes and readability improvements from
 review feedback
Thread-Topic: [PATCH v1 0/4] hw/i3c: Trace fixes and readability improvements
 from review feedback
Thread-Index: AQHcqfRarqX9H/BGN0qDgqDRJyv4qQ==
Date: Mon, 2 Mar 2026 03:26:27 +0000
Message-ID: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6791:EE_
x-ms-office365-filtering-correlation-id: aa251acc-8507-4b5e-dc66-08de780b7d61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: pddzshCUw8Wz5Cd+HGGgjjSbiVkKZS0j5oeEm+mAn6fDIv+rD9RWcDUy5q8kVCiwJBW6ut3Gei24D1pHJgaupNxHeBqlK5yPPbKE19ovX6t4XT6KvpuN493PJtglFhijL4FDcpArGlXH0ldoWQFlcIm2jWq7O4PatEP0iUE9kn4u3hKkgOcC/NYrvfY7qC7CV8wFUv3+V8UEapVGpJhjooOBzbFGCBRo7XTVkIJB4DooCz4oq2ya0JBvkSbsrvEv/ImrEg5ugG5fQu8Fd7EnzZ+iE5DKibIOqCB+3JAjHt2+Luuq5OpGIKknbhbPByJGYRG6NdjjW9UKX6B4EmR6iIMuoYoxuXIZsyp3KbHDLhiM2OzksMhI1/2yZ+z4N0DDtcPvHLF8bGCJv6QyOE1Ik8KvxkxEyUtG8bW5XfdqjWryNpxUVmbx6Gs66qYL02YwcVAefOMhMhBggbrS5/Dtl7XyZB56BW9u75IUidt1FPZauuA/zw4JqsUM/DKhCpRwBRAHWLvV/kyyElFNaPANFKtDs4KeT9JDY14jN3os6FAgBNG491geiFO+3Jcgjf3zxtjDsgsApoOH14GBAY5Qipg08iehcdbGiJGI7u4ZKUWms0OWgeNw3ihNse6OE5n935rzjzhTTK2AR0Bd1HaQfYthWD6Wb2yLtX/VRhXyop235mV9A+uKvUvS+6qDEmgM3VQXKxRN0+hbxuFIlGsJw31YCpfYIKUHBUkL9cYtKTqs+EIq43xDW76z/xeVYtv/90LFaoeysUiyXBxdufIzllO1RkyCq+gqzkhHX/tZH3Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VTvON6XlslXX7s2KGNiuNrKkMClNktm2a/TeHvnoczn69CA9zjqWTXb9Dtxw?=
 =?us-ascii?Q?5w2SZO7PDeZljv3WeGdSAnrHLWneNVK8/BOL6LpMcWS0ghbVO93T7jhS4h1/?=
 =?us-ascii?Q?Eka30vsSj5TXm8JVjvQw8cZ8mbcmWxOzvqIQzGjyJeer7DTmh/N+QRr+PQOS?=
 =?us-ascii?Q?6jNUIv1L0d1IF7x4rSf2wEfetfpSowlEvShaF6schzAS0R3JmbBoC5q25tJZ?=
 =?us-ascii?Q?3GtTNeSsgDV0IE9IMef7ICbKQ8kAtMXBUN0yZ9rPr8LZ6Up2ZxI/VqqXSgsQ?=
 =?us-ascii?Q?Crv6AGcmrjo74+XAN0WijrkR6Cl1JJUwAwwZ7teUd7B6dtk24HzitHPRWrRD?=
 =?us-ascii?Q?mMdRsvZvfYYh25vOWkDbNpqI8qC9PMHoKwUmffJEHt0ujdJ4t0O4uh+R+TDr?=
 =?us-ascii?Q?Cs5IgZa78sVjOzT2+FswUNvVzmZp04DyaT65LG69t1rc5tF7g93h8IPIUqoC?=
 =?us-ascii?Q?Zv3WX+WPif/iTO00hM3eu9xqG3LGV8RYU91BvKTaS7MmUs5WhIwWhscrIvXc?=
 =?us-ascii?Q?q/6FypJHonmP9tAS22HWI5bLan/uvPHc/obBhwnaz1cDz00ENdh9gUtgTng4?=
 =?us-ascii?Q?CfqAkpF9nA2nt73lD1uk8a+yZ+CZ0j1Tq5ld98aAGQF+da0h7k5q9tZfaMSh?=
 =?us-ascii?Q?YdHJ6gRZHT98WXSm3rbV6dPbQCE35HqNlVC2o26KzXDZW8oR3+SOYP+SK5eJ?=
 =?us-ascii?Q?wkn+j22fX5QxlxWTpISIAJyidiz7YrFU0ICrKW0r5Sql005rdPcZ8bRJsWj0?=
 =?us-ascii?Q?I1rAZ6BzIvHxviRPtu9iUnnYwFJv/3OyPcpOWjSr5crWqO4YV2/KV7L1mC0W?=
 =?us-ascii?Q?N31QyzawDY2+dsp5ZqSJRA63miUBsjrnQFEp83QRtZymRWUUwAYDwY4JHPSJ?=
 =?us-ascii?Q?y/0Kwcp3ZkpPK0dNk3qJd3mTewLD30ZFht9OKHUs3HkpkxV4eFFieMkbypOL?=
 =?us-ascii?Q?QPShso+ZOVk6rMV5LbwElNqcFbzUr6qdinvebw7X8hxLzssFkoKuP+6N937c?=
 =?us-ascii?Q?zgb4S7FoDIoTtHPnGEWyaX+jAXO/fMcmnxG5wk47ywdjXcLylIgXw4YFqPuq?=
 =?us-ascii?Q?ojBtuZmA36cEQ78mdX7gIvpG4mT3siUiyF2WIwu0O4iMUTzQGTOMgivDfcy1?=
 =?us-ascii?Q?dogK8zNH1PSEQJ01uhF3wWjuA2yceuG1rXqY831kw1lnD2BcEfE1AqSMBRNZ?=
 =?us-ascii?Q?eiDb0OwZLXxxGkstcSeH9hx/luyvau1PyV4jqWGq5cHsscbskghhxLRKrNCv?=
 =?us-ascii?Q?zj5MW4G2Qr12dNmP3X8UBXOEzaGD5YX3d47/TeB2QwNYgNSF8MyYLdOh2GFi?=
 =?us-ascii?Q?tcwUyOf/3Elz+7kdA4Vl6bAaZxM1/9+GPz3ygP2taXZcnGq5o6i6ZeMVZmzN?=
 =?us-ascii?Q?/wb8OiTJun/IGRbqdswsbAOhIfVWjsvpiaKfnAm8ivaV/557wiPMSTtkIvA7?=
 =?us-ascii?Q?SDVGxiGD285tk6wY1h2C3zZuPEiO2M7l00W3pFP1KKwhaGeP++DSpI26ccdg?=
 =?us-ascii?Q?jLXmJwb9RcfUIZoD5S1Lbe1NYkcmxrg0JH6r5s3wKgajpjEzMVSkeTmQ4wCU?=
 =?us-ascii?Q?kkV2Mh3hht1yGcF5lSsweiD80eowCjEhL6kuF3wNCaJPnpBNN0bW3mLDP5tf?=
 =?us-ascii?Q?We0E0Nb9upJ3vZbwcYmxCkY4HiHVr9D7nrAzzW5Z8k+q6Of2oIcEixCilcwG?=
 =?us-ascii?Q?6/22q9Dn5f5K4l3Rd1XigFpMgHiFkZXoFCjLbAx89qvJfUMsflKmktB7F1eu?=
 =?us-ascii?Q?owxHtXU26A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa251acc-8507-4b5e-dc66-08de780b7d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:26:27.6128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koAoxhfHpLbLbQXgINO5woUQGbHHUiOXfzyBLxyXXdH4zO4CXINkhb4j+Pj0ycal6rpzftfxwPaYMN4Hfu1NYCK9jcB0xML7h+y5ATlRYMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6791
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

This small series applies a few follow-up cleanups and bug fixes to the I3C=
=0A=
subsystem based on recent review feedback.=0A=
=0A=
The series is based on the aspeed-next branch from:=0A=
  https://github.com/legoater/qemu.git=0A=
=0A=
v1:=0A=
 1. Improve trace correctness/determinism by ensuring num_sent is always=0A=
  initialized and reported properly.=0A=
 2. Replace a couple of less readable expressions with clearer helpers/logi=
c,=0A=
  without changing behavior.=0A=
=0A=
Jamin Lin (4):=0A=
  hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer allocation alignment=0A=
  hw/i3c/mock-i3c-target: Set num_sent in TX callback to fix trace=0A=
    reporting=0A=
  hw/i3c/core: Initialize num_sent in i3c_send_byte()=0A=
  hw/i3c/mock-i3c-target: Simplify GETMRL byte extraction logic=0A=
=0A=
 hw/i3c/core.c            |  2 +-=0A=
 hw/i3c/dw-i3c.c          |  2 +-=0A=
 hw/i3c/mock-i3c-target.c | 10 +++++++---=0A=
 3 files changed, 9 insertions(+), 5 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

