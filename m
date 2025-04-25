Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F32C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfl-00048c-TT; Fri, 25 Apr 2025 10:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl0-0001bX-KU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:14 -0400
Received: from mail-vi1eur05on20702.outbound.protection.outlook.com
 ([2a01:111:f403:2613::702]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hky-0001Mx-BE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9MHwycbidR9nA1Jqudj1bgiWXPkVJYDjTIEgv/0GmDp85fFIOaePSFN5QxYgwoTAJt4UCq2EhckNcFveAmt27uue4k/+c8mzqTpKSH1bb8MfdS//3GNQXUSQkrYQ8x28+WzqBCMAKsVDNaB+YM9w4NeDU7FyacWJOUO3k5kKkd5YnXmE3yC3b7o9ICow6YTcWzlxJMW8E76Rg6sjDaCUkSJLACwZmamYwU01l7TE/T7px5QROp6YH3eqv9oecv2oBINJKVz++yU3UmlJf9x24Qv22g7flTp3QhEAaZnVbbr9P11mYhigGV06ViiJi38sBCgkCHX0eUSrtjVv/tcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF0gYadvan8aQ7LVsbV7JjNY7DMfggX7SWj9oz0x/T0=;
 b=p7mX7fOUnlBBIZVKxIh8D7FS9apbD6NXLC1aKXOUzcgQbHu+NKOHSc9QupchgTq85H//bEUZGekKNipEDZpD41wCSCTi0/XWgg+beVYOzNu3kKg5Qv330XUFTHhpjHLq/ytiXNW/hG+p+ZqsGxBN0XY8xqihA/43Uu1VpL6y3ndfx1h2oAVj18REP3+fkD7GzabUhdbibtuEY2hnbP11kTcQdMaoRR9mq01BkrrbNHsUKtqbr5U0D35y5jlByRFLOeLiOhsLaikx8zQF+JdVgD+eE9xzfnCaUpFLvN6U0QtDZfDQV+/3OER5b9qaP/BYd8PgOq/MUB5a0xfb2eb0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF0gYadvan8aQ7LVsbV7JjNY7DMfggX7SWj9oz0x/T0=;
 b=sWoyZBd5cIYO8quUIvFh0N1GcS/g7bcLBqVQs7RjpAOC23Rak7uztFTUslD/M3dj4Sc4cB3YOdD9GEcnn0dTkA7dpLTzFiJ2hkYnvgODogaVB+dlg+Cz5QkEFb5mYQ8QcSQAhAn5l60d2nO64dbhi6YUUxKkX2GVdf1uDJM3kMD4nfP18ot0Zjac9Jsv9gH8c7cqWnpXFbRPPOKogEQSiuDbzfh/mQ+V8vYVKwQLKG6b3GPMKSJc4cGZ386dUO7/XzpPNn81FaOKJuklV6j/KZ/Lvp/1TOos77qSSQczUVEZTNlERPZiN6lMyEfTobuAPY7hignfUcWOngzWLFBFAA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3713.eurprd09.prod.outlook.com (2603:10a6:208:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 12:01:46 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:46 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 6/9] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH 6/9] target/riscv: Add mips.pref instruction
Thread-Index: AQHbtdnRtgh9BV4/BEKxThGJISTn9A==
Date: Fri, 25 Apr 2025 12:01:46 +0000
Message-ID: <20250425115912.912889-7-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3713:EE_
x-ms-office365-filtering-correlation-id: ab8d2b50-c181-4eb3-5f06-08dd83f0f3d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AD5Mzgov7BtcFmZZJKTxBCUTsSJa5JZLFm9Sb9yx57iKq2mj9FcPck24uw?=
 =?iso-8859-1?Q?gYrtlQnYfsUoM7gru4MNMXVUse44gMbXu6cp89oANPjAli3f1GtLx1AkxU?=
 =?iso-8859-1?Q?yirXzy2HsxVXiRRXjzlvXYYbJfcudwfRMR1HjE836X5CyV2XYdp7spZD3E?=
 =?iso-8859-1?Q?2/j2qZ/ueLZVyzTpgbnHYNGCqjRlQ8ZMDvaI9eqDw4whVp9ZBKkgWqFcFw?=
 =?iso-8859-1?Q?pEs9PPurp2fwtNqXR8TFphe9w4LAK+2zHzwkJKvS8F9ieJmjuPkuQ84GVh?=
 =?iso-8859-1?Q?rMxEcDXOc0+cfgVjycGot2HuWo5IxR40jHlKPProUX0DqMxLeMmEbkpPPa?=
 =?iso-8859-1?Q?K/jiDUoAkex8+ubCUu3wRFgCUkggxyAG8WCETE+qiPbATCwxhiOyLZZnPw?=
 =?iso-8859-1?Q?yajGqmD52tjigte6W4vFBcJWI5R4rJWUv1R3DEDC90CX6WUH3j5RNQnRBD?=
 =?iso-8859-1?Q?tC2F1dZe0JC0uxIK51qE+VAjjgZCKzoBJM6M0wu3FCkwZQpyVspA2+JueS?=
 =?iso-8859-1?Q?TVUCu3KQwbc8i7vsOFMqeAQffbmEk+Evyhg9771grMuUM7bCKlNX4Ayu/9?=
 =?iso-8859-1?Q?l21OI6PmGghU++yDbhDJu5gU2NPkm6PZjltvyhmbhrms6PCoKLqHsZWOHf?=
 =?iso-8859-1?Q?ZNeC60+tRviWm3vWKEDXdAXQa/fenYMaakTmFqVP9qnMU6CNdWbPxP9Ez5?=
 =?iso-8859-1?Q?xopnbprRE+fb/XNC/YbdJgjr7vr1nhnC1irD4ieRELYz2M6T6NYJ+4DQAq?=
 =?iso-8859-1?Q?Pm4kX5OKAeZvCM8He782Syw3EJG7F8M59lTV96V8yd0dbmId/DcZvc0emr?=
 =?iso-8859-1?Q?liBF16HgidZdKi3Smz4zBS2CjS+UzlJWEz67c/PyONcJXuEnVNzxmip+mr?=
 =?iso-8859-1?Q?SO2qkAuTT/JFghAB845Aqj0H6b4PdtV3047aOhbZqdz/NWNitSR2DOsc1q?=
 =?iso-8859-1?Q?RxctPehH2S5UfEaSHUu7Pnb0Oj/VrY6ZO2gKEQh7koN2mtWxVTRvgGoUiE?=
 =?iso-8859-1?Q?xH/ic4n8zD9U7htGUHChH97QgCHTcD+1/M6NYtLv+IsDULLjrcYSCNKAqc?=
 =?iso-8859-1?Q?CMEd+scBtqYUAbDZ5ny3h57cwsrbvaxtD2bWLL6sVvxXFHZVuyZJIvMooz?=
 =?iso-8859-1?Q?MA3dXbIWh9o9sIG2K+WPTwiA7SAs49fLDZ/CEXm4BAhKNF9r38N20YlRM/?=
 =?iso-8859-1?Q?FZrc/4o4vTAKqqE8w9W7Iutm3eZdS+FvsqePELNFr0/l42sVaYQpxkWJwK?=
 =?iso-8859-1?Q?3rOp2HJVzUppWiLuVExmm3CguhZifcbjfxJiBHdL7rE+EScGAXd0UCRfx2?=
 =?iso-8859-1?Q?sp0XFkKoW1A9yE4UvRhVvDMzGvtq8yAp8SZf+PTFKNcelKGLUwga3dOKfz?=
 =?iso-8859-1?Q?WDBZWfvBbO7gf/Bf38aJuu3WboaCewcX0syeWGUmPjme6G841rxLxbl7j5?=
 =?iso-8859-1?Q?QkfL2fY59ll+7sYjQD4jUojLr1VnBEdj0bhS9ORum8BTChwyFGhn2uKwn3?=
 =?iso-8859-1?Q?VEysxeogu2Aq4/Ep5slFU5Uv6u/nSmeEw5lu+qhsYtgqj1rGlQx/K2yxDn?=
 =?iso-8859-1?Q?SknAzNg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uA7Np0OjfRhNtTN3n3Urtl+vUryv+hggieWV8U3J8mgv+JwtyHm2iuDn2B?=
 =?iso-8859-1?Q?17k0l/6fH3c7Mp8JCXFEaGiP28NKBUaTQBwjVW9OvOTK0Wl5DxRy/BLAoa?=
 =?iso-8859-1?Q?MVx3CdGfltQ+A34ZQtDiPNm/tvtLLeHkTYjQqXpHXA+qvgnF/Gl7lObS0u?=
 =?iso-8859-1?Q?fsaLX7fDD+hFwsYblRwuiP8PmqZv/LXgxGoplD+8EWKhJUq/7vfIYK9GKP?=
 =?iso-8859-1?Q?JrtlS/bgUuzxUavTaN2atn6QCOF4A7KFBnQgk3dJ5WFSsN2RZye15BFD0M?=
 =?iso-8859-1?Q?MhqXYDx1qdE6JQBjTeEm8zm1kJVPf1Mnd5jqjoakXVLR0VPZcMXdtkzIol?=
 =?iso-8859-1?Q?Ur1qRyt2hVfc9yKX8U5xHLK1uLvISG6dvZXBdQzbqHMEGkUZc2Mw/Q/W2f?=
 =?iso-8859-1?Q?pecfjodU+WGXhcK0rCagwjLVrSxGMDnGt2JKkL8YwBSiIx/KCeqwxE2Svx?=
 =?iso-8859-1?Q?wJPdzIXqkK9b54owBmKVnsJ11MjujMhfHWv2pANyy5IGd8VfW6L1Q0KU8H?=
 =?iso-8859-1?Q?pZmyMiVcYMVQMo2Jobg6hsgF7ZDSPWJD+94LPeifgSt1LEnhKJJV+poWDS?=
 =?iso-8859-1?Q?wb4ryDo5owR8L+Dr2DoZu8lXWTn05FMO+gcYK6u26m7ybLDR+j+PmJwhGI?=
 =?iso-8859-1?Q?N1dewLzkW/P/ZpT9dS640YFk0iBoNrAuc7gMxCGQye4Myyg8I8CHcDdLrn?=
 =?iso-8859-1?Q?zO5OSMkXUSeT2gIj+wS40u6M8HNYv+mDrH+YLdmMzmfPtkJ6vS3M2fOROx?=
 =?iso-8859-1?Q?ZmTJfd900kOzjKdU+VdcgoacSCNwrYFGn4YfUh+jUNXNxECYVyVM7TPSCa?=
 =?iso-8859-1?Q?bVjx2hLsVuegn2CCoemadE3S9lnBTWFaIF82ebiiWt6ElCWprWQ6utCJNT?=
 =?iso-8859-1?Q?93x2pWh7+B4onacsfpvaK/63JeA3xZaCxaNIzcmJY3gw8giP6Sw155sG8t?=
 =?iso-8859-1?Q?rYRx/Q+q+Dg2Le69PztfCJrKZ4h+VYs5W6VuFR3yEvW5DXTREWYzc9O5TT?=
 =?iso-8859-1?Q?sHhfpalHzm5MJl7tkSFJecLMHVNP/yL/dLaSRnYSavAzF2+LjZtC+1IE59?=
 =?iso-8859-1?Q?GeMh8FtGrCxjzCCjJHNyI8vkZ5VwDpiuK0f0UMfDsF5Cqg5fYCVC/vmjYU?=
 =?iso-8859-1?Q?DqokhjorJBS+5N4DgKKz8xV5sdCmfezG9cFnjcXQiN7ULv34yhCtMUVUWl?=
 =?iso-8859-1?Q?W23h+O26hCuXCE8J1u9SFVE8v0EaC4/+NRLoAgr/LVDV1p7ft/ZW5RImPb?=
 =?iso-8859-1?Q?J/EewexwFogR77yBBirwPpyTTMUEuFfKVerpQQo+ugQzEYYvEV4l6nzlrP?=
 =?iso-8859-1?Q?mPefs3HM5EaqLDbbnuT/c/5OFsnwTJC5iHi884UaMFbZx6om0UhCiktgfh?=
 =?iso-8859-1?Q?8GLZaSJD1haHIT+FCKdUDiQR7J4RznkonsFitacWzkx/4usRJiAIsep7kQ?=
 =?iso-8859-1?Q?L3jUc+U+P5daZu9R+96DRA2EkRNoLCtuYdGhDT8AMExPaviU/Abxyujw4b?=
 =?iso-8859-1?Q?G6X9twFOiCpc/CFVQbUc4Tqt8zHcJ+PcTVtMmP7Y0vy2R+wymRx0ghSIsF?=
 =?iso-8859-1?Q?etQtV7/DNH5Ju/tQOrNafgS3TdfPGg0MK9nyCtwkdEVqB5i8zoC2/AbUbE?=
 =?iso-8859-1?Q?P52XmO6RV++wnKgTUh/1C3UEM4cbn7Pk+VMEbnLYshz0SA7p+aIwwP4gqE?=
 =?iso-8859-1?Q?X6YxynBWxXRJGEyQ/0k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d2b50-c181-4eb3-5f06-08dd83f0f3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:46.2604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWhc69MVIksQIJEawxI9yxuHVShtSfafVQf9s9DAk4/yTowj95k0SDaD7e7y9NXS+0U6KDGhRuvRFtoFmvfLllCvrgFURm2T3Dg1kttULKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3713
Received-SPF: pass client-ip=2a01:111:f403:2613::702;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  3 ++-
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  4 ++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6d866253f5..d201a0dd02 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -236,6 +236,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempa=
ir),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
=20
     { },
@@ -541,6 +542,7 @@ static void rv64_mips_p8700_cpu_init(Object *obj)
     cpu->cfg.pmp =3D true;
     cpu->cfg.ext_zba =3D true;
     cpu->cfg.ext_zbb =3D true;
+    cpu->cfg.ext_xmipscbop =3D true;
     cpu->cfg.ext_xmipscmov =3D true;
     cpu->cfg.marchid =3D 0x8000000000000201;
 }
@@ -1758,6 +1760,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e6cce7fdf8..9643625018 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -182,6 +182,7 @@ struct RISCVCPUConfig {
     bool ext_xtheadmempair;
     bool ext_xtheadsync;
     bool ext_XVentanaCondOps;
+    bool ext_xmipscbop;
     bool ext_xmipscmov;
=20
     uint32_t pmu_mask;
@@ -213,7 +214,7 @@ static inline bool always_true_p(const RISCVCPUConfig *=
cfg __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index a555c94e23..375970defc 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -16,6 +16,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -36,3 +42,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 94d37c10ae..56237fe610 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -13,11 +13,15 @@
 %rs2       20:5
 %rs1       15:5
 %rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
=20
 # Argument sets
=20
 # Formats
+@r1_pref ...   ......... ..... ... ..... ....... %imm_9 %rs1 %imm_hint
 @r4      ..... ..  ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rd
=20
 # *** RV64 MIPS Extension ***
 ccmov       .....11  ..... ..... 011 .....  0001011 @r4
+pref        000  ......... ..... 000 .....  0001011 @r1_pref
--=20
2.34.1

