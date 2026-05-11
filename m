Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1364CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPCt-0000pV-Lv; Mon, 11 May 2026 07:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wMPCp-0000oc-NS; Mon, 11 May 2026 07:53:53 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wMPCn-0000hF-Ig; Mon, 11 May 2026 07:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt16SHULV0CVUWWc4O23ZrkaO4nkMFenCahMHGA0N65+apGfRxSqAsaL2uVWM6Gn5wdoqTV6pK3RhvB/xv2+kbc3R8hOiLSyyU/Ke/mazpblZXSbhENT7rj6BhX8h1eKzxuj5v4QFIJHoZDio1gLS/RwKTIUTMy2XUFIWOdj5im64Kq5YBLwZoq9ociBSMnkI4foFQrlmUqSJw1UNWd5qI65DQm4dNtNw9/QUpj4jDSrd0oJAuGmEts7oXJbNTZgBOx5AIUSktn5K9blSpfs7sbljOjHw3pfR/VNGE2lq4ovI2LQ5om9M2vFf79rbYEtZxWvmDSwBmK8Dwe2Qj0Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkoGDdWG3fk616xeCXHbrrpL0C627vPOgs1YM8VTG4w=;
 b=Sqb7RdZBgbbiYbo0u8Vc5pF5SBxLjQ07TZyEulHCBOeJaSD0twGqXD7Iih3N7zJ9EMBsfzwTnBk7qEbbBkftEzEyJcH1Yo8G+Uwq/gr6LPTL5g1qy2pVYQBBwSKnyVlfvzDx1aBluBSPUEn6FuTSDrhhLIXmefn3LduIzcTvKdLEDO9FF9eLwpisCSiTQrwRVHMqH/n2dQ0OSthTmqhhW4SOSYnQ7QvAqPKPgu/qP9RHsUa5IrK1MnRi/A7g0qSC8B4GPFdSR4Gx0TTADucxDHL+1bsGlfiCD1QF9GDKQ0nrgWQpnVj9ngDyHh9TEykbBhCs4VrfKA50f7rEsjJ0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkoGDdWG3fk616xeCXHbrrpL0C627vPOgs1YM8VTG4w=;
 b=hHNaZuwl1brNC2N29k3TGi4u4TkQqIlryeZ6URE2H8eRYnZKbFjstNXx/WI0ThcUHLh1oJzUyRn4HXY/VZiWAlWPE3nbe5VVPLKt1nBpjQrH1PnqLsmy35Zlbuk9M3bNmzVrpecGtE0JOLnyZoCLVc1l5SBV4iGJH61tfIzCjew83rMMucf63kImdyvebmBbUbwlAVJPtkI4nnRN1i3zj3lMOdq39jThdlrAAUoS9ydlK66LYBlEEkfgMnE41pF0Be9msJIPRH1TP3MX/hhz4Rn7ZM6WMPu60FYXR6kjH7vFBqZ5pUmto8PfpIqstIjEhOu91LzKq1fK5dkrGAY6Gw==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 11:53:44 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 11:53:44 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Adding AMP (Asymmetric Multiprocessing) support for the i.MX8MP SoC
 in QEMU
Thread-Topic: Adding AMP (Asymmetric Multiprocessing) support for the i.MX8MP
 SoC in QEMU
Thread-Index: AdzhPFYpCkI1fsg9TF6Q60JeeLkprg==
Date: Mon, 11 May 2026 11:53:43 +0000
Message-ID: <AM0PR04MB437090062D4587ECEC9A3B8E87382@AM0PR04MB4370.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|AM8PR04MB7410:EE_
x-ms-office365-filtering-correlation-id: 48fd9d67-d1d7-4133-efaa-08deaf53f3cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021|11063799003|56012099003|18002099003;
x-microsoft-antispam-message-info: Sye+ithYNLJk+dy3IuR25tlKa6/06eevpBwHLVmvpfu5572O0fOCSO5+epq4O1B7NeMd1hK4luatd+E1hA/w8dDmcAnmQ3WdZHKXYLwo+YVz7vunjROFF6WDzhuL91Df/zH42bSzrCpZlbFMuAZNMMja6Kuz+Zfqe4//sHzlx0RoF0+HjH23/x88Mi/RjZcNwG2Pz/oSOArJfD+zncIZ0/MMlEFivcB/D1ezo9e5wd5Dq+jnWE34EI1d01bRwTlr2x2py2lxGvbGTfCZZLXUW1O0sQp7VgtH3L/DNHvYpwUuBNeUDnI6h2+33UFPCw0suM0GbJUismsMB3V7WcCVDakyu5I/Dml9bR7FCoN0NBIBGga0WLH5puHNfs/3yieSszZJ4SXT9rm3KmaN+DQo0HqXbMyeItwbvHqn8yifgnURAppa3ZwF0AJke69iHU1xrWinTdoRwvqehEGzIlXl1YtBTxU4k7/FuEZFiklhJBR9XpxzRAPpn0OSf1X19GokbfTB+XIjCwAao53nifD6OQSSVy68qemJTrpF96T2JTzqdAAEWvWwRhnToKETEWqoN4hBI8Ni+M4/CiXCwWMBXYDeOol8mTbCW2GV2KIZBcSVvAerFFtA3RQsRZuO+czs3BJgHYJQ3Zra0YmJ4AtZwd7xXuguZ9SkVrh3/RKj4kLORBH5PJiGzM0S64e+Es28DfV+OVXjmIOGVgHB1n+9P91VIJyYUC6o4CXT0dR1TVjTmy3rOdI6BSY7cRBuX2D/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UbmwDAH247tJbGyk6039ck4LkpyYyObk+QbHQ5gcMdLSsckgDXXAiomT0zHE?=
 =?us-ascii?Q?+jw88eNvb4VpuokGy9UmDBXfbCzwLTeYU43SPLpoBW+GmMOys0YCU4ZijNQQ?=
 =?us-ascii?Q?oe0c+Yfq8Pb7c0SUrP6oq0nM3zAAgz6MqpsD6ZPk1Atfp7Lri6kZYZHd/JY+?=
 =?us-ascii?Q?vdeFg865/LBn7iFGObfS9XURyIKoagG9fBKC3pQ8nVL1f+2GRKSXpcO6stkn?=
 =?us-ascii?Q?QKWgTRw+K8HdK3YvgAx4ZHca6mIkNLGApx89LLqMNPoh1agQVyUhysS0A8xX?=
 =?us-ascii?Q?u0l5pvgvX3kyUKWW/6KD4TZMurq/E1qfve7AXk2c1wUftRVK5LPPiyC9nJDP?=
 =?us-ascii?Q?p7/CykXBcs6Tk5D63B6Mt2CpmkHKAHKAb5hXKWJafznc0MK+lEHBnmFRFZsZ?=
 =?us-ascii?Q?y+tWuJ2VCy3StjJASQwQtllCfTyN+Ob26I2IfUyS8vsjNe40VX4YABcLw4TG?=
 =?us-ascii?Q?GiZIAMyGZsAf70WKRqYTPeCbe/Zq/QieKSH3cCxWcN7Nzow3IOD296FFJxjv?=
 =?us-ascii?Q?AAXv2ltIS9KnV1Ng9il4dXoxoRycWM/Dow43IxB60NdkuoxZxvgYX/rU0sBq?=
 =?us-ascii?Q?gcK2u7L0Gn53/aCy8axk3uYz6mkJt4T1iidL6L8YKLe9aSToddklpveGwbYO?=
 =?us-ascii?Q?vJxEciB3zoccOKYoDfWpkn5fqZKQyOfaFx17PWUVbJFLlMjMVNy5B/crZ8zs?=
 =?us-ascii?Q?nSco2TUFtp+WbENiCzKkWsF+yqp3BP+8yQhF5fFZtV/GJD3IZfMYJdae0gxL?=
 =?us-ascii?Q?1+kltkBl5mFSRtxvGfhvPixS+rUt04u8lhvxH0Mt8GtIOEJ5wWnwRvaCTQvD?=
 =?us-ascii?Q?LiMb+ajNP0lwIDrfloNrcX1WwVUx5/i2o41rQhM1w7flnnUJ9IajjyzfHwjQ?=
 =?us-ascii?Q?36Cq4J/OuocQ4p/KG8ofkvQATSWnnJ9XoMbV3eqMhZDcyoyviLbgTe7HSTFW?=
 =?us-ascii?Q?8KLFGYcAAgWhfrBkqRegkkP16QCkCRkHQvLx4pyjgx2cHtI/UYrwLhGrhLO9?=
 =?us-ascii?Q?DnQDGQJlXNA3oANPmBe0Y57kLcocxQ1iKqfhpIDCDThCjt+rN4S+M7sEK3t3?=
 =?us-ascii?Q?r8SQxXLS/slAJsM0W7gavnz7jBzzWcYl63ZjTZFC2ZXSmcDubJ7s5aoA8vXs?=
 =?us-ascii?Q?52vY1H+V+3kwuTlPUzbDmN2jWuf5wJiXt+ZOHgRWDvgtv51dUlAi+A7kwyXZ?=
 =?us-ascii?Q?GpVxgnZVenUL1dUj9j/NLRzK0pLiONT5u2xnCLDbXkAjSikDI6ecPHmDGjrb?=
 =?us-ascii?Q?+PTPo+rSjRInzVS6C71VPdJ3pP8F8al+ILRDhKB1qPwNV/PGNbYUhyOMkayF?=
 =?us-ascii?Q?SVnJFACsapaPKd766p1GIXL565mxeoChfCjDRXt5HPUarUsdpMMQWxHXFSck?=
 =?us-ascii?Q?W9Ta0mXK0pwLE4QvpkhMyq7GzV2aOW2CUBWf/6acSCRo80Nh1EuDDcVjl8uz?=
 =?us-ascii?Q?duo/NByaLnejagjPkVCY2HBiRXcdypfubQJx222BReG7pnP3nBCGR3JmI4zM?=
 =?us-ascii?Q?bLArUayu6vw8banY623SrDd/NXKmoAEXCVil7ve6ReTvWazr2tBhAsW8P/oZ?=
 =?us-ascii?Q?BPpi0dvuDeB5Jl7ymrBAepe8SeCymyBzxq53fCSW51VBHosJQtoFm6onDqsj?=
 =?us-ascii?Q?PuOMDtdwR6nlmr0EGw4bfK2vLC6HpTo62cYgjUP8EM2LmyoH5k40X0GJ1IDu?=
 =?us-ascii?Q?7B/6sGHEYnBUH/x9nozgLRuOUCx7mvC39+iOfw/+TPYsLK+HJXGVacLxzIX8?=
 =?us-ascii?Q?KrUNjOA0Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd9d67-d1d7-4133-efaa-08deaf53f3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 11:53:43.9502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JRNbNfNRrASyGfj7GEq+RdezSu2kY7h0mSmErwwgOqpAt3AQsxoUV4xMKZpnvfYN/uU3Wa3AiX59A0Hra3Qyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410
Received-SPF: permerror client-ip=2a01:111:f403:c200::1;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Hi Bernhard,

I've been working on adding AMP (Asymmetric Multiprocessing) support for th=
e i.MX8MP SoC in QEMU, which enables:-
1. Cortex-M7 core to boot alongside the A-core.=20
2. Device emulation for Messaging Unit.=20
3. Linux running on A53 to load Cortex-M7 bare metal images via remoteproc[=
It can start and stop the M7 core].=20

So far, I have successfully tested the above with minimal SRC stub. I notic=
ed that you have a SRC implementation in your private repo which is not mai=
nlined yet.
Is it planned to be mainlined ? If yes, shall I base my changes on top of y=
our SRC implementation.


Regards



