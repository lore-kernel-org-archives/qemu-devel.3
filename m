Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8801DC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfl-00048d-U2; Fri, 25 Apr 2025 10:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl3-0001dN-7w
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:17 -0400
Received: from mail-vi1eur05on20702.outbound.protection.outlook.com
 ([2a01:111:f403:2613::702]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl1-0001Mx-2s
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKsIjcoEtmO+QEUavDdoQvVnRu/43cpX6VeK6d4WXn5//5dMtj2RybYbQWF+mAp9Km6XRWi3lequRERwQ8gwp3hINOg2/QugCpNjRukicyUB/ZKGdgXk49B1D2aZS1JmejnPQy1Y6oJI0KkbaZXiE7yRsa3MQs+cyE/Az78Wv8h13WwaVKH2BZRTMEMSlC6krLX/MYr1FUQx/rb5BUcydcB1kh9yHGCppHt4THmxbgpLTv0ixAVGVRYMCwq34S2NOjv5nmfDDYv11Tt1a0kAbFNiy2RfHimUL/a9er8MKwPyICkn8xY680BDdnAFDK0t78oDVggDoS5IcYuN11Z5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZJFjecIkKnsnjP45fpOOUNA9pV3mbOPdzwE9xu71R0=;
 b=cPKK4pdxLvhJ97QryIuBqWWCn4hZnp7c0IpOh150XJgVjpkbPlb+/sgcJfMWUZ17tmV3syv49SDGt6yAnl23Q4qGhpH/qDVqa0lRPXbvasHk0sTdT6XHNQGqYmJSglpF95u4Wh03PHFLSDOPGdp9IJjWP8aAGyicDeieK4B452JR7QX6vobAvYDTWLPsfljE5FTDcWxoMGU2vOOnvLaz3TPDjO2fuJUBUSY361F94VOGgY+L5oJEsUvkbx4Y6IQ+G4uaotTTBOTw6i14oNtQhxXvsiYoS8bz3Y+6EcVZzy5JYvsDaqCsE660FehChLTYHfVV21TPuNiChFyRBkmRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZJFjecIkKnsnjP45fpOOUNA9pV3mbOPdzwE9xu71R0=;
 b=iFWmmr/9RXlhv020cIbYaA3nq94ea2GflBEI1scrNIh/7lwdx1K6zCstDZFESCRFIQwJ9s7I0ehHpKLaNqg0ybW8FwrG2reXSXoeElMq/BAAFuHMzzuxFtzV0o6U2x3NJU3XCR+tViJzrAofpmLS6RkToxK0qChxKjpkJ2BYYiJtElNIGmsGonHqGPuWUnL9IeU/njK9ghyJG8R3GxWzf3Eclg8jETSD+SN4MbWgwTPdPA3N+bxxIPjbBnXLitpRRE0zTToni/t7P4oK5nuppDVvatDREwPeI5ZOxWi8KuyHhXjhgiWBAc6urICzwR9g2SY2bqLb3bxnD9pQm21aIg==
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
Subject: [PATCH 7/9] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH 7/9] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHbtdnRaFsGxDZJmUeWywYHH2rksA==
Date: Fri, 25 Apr 2025 12:01:46 +0000
Message-ID: <20250425115912.912889-8-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 46f0082b-b07f-40e3-05f0-08dd83f0f40d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Jpy/O8mvJB2sm/hPz+Gn4z44glcMO0o7IL4WQWsgyi0O6ukqGLp5nkWlLk?=
 =?iso-8859-1?Q?gp6kZXxhwB/ZhQ1cngB+GiyTfJbSoEiz2K9jWpUJ4OMGdY+/kFsaN8VjLq?=
 =?iso-8859-1?Q?UnwGwMjlOS7EV8UdIxvVH7R2JnZI58QqcDnOjJ3EJuTantZdbghUV4AySD?=
 =?iso-8859-1?Q?puNVyUijO9aosXP9MYlRgdTz6DmZKFfD6RrYyT6uIyLoqe8FaAeczgJviS?=
 =?iso-8859-1?Q?aUwWniqya5rpKtRKNJ85B8uentWBRAXwNNd4TaJETZJQ9hhdBO2WsICEuL?=
 =?iso-8859-1?Q?dGS/2MhgzmwAH+bEUccqXIcw1EaaEzWv6+6B+Kubh8gUpwypCZkNydWPKx?=
 =?iso-8859-1?Q?pGzqVSKAmASj1leFF/1aJ9frg+coJ3SOcEM58zBYJT0Ex69F2rm+t5gMkU?=
 =?iso-8859-1?Q?kiN08gka0YwIR/M16Md8qSjTQqkVkjZTPEbbu2X7PlItZVNC5gehu5mlzw?=
 =?iso-8859-1?Q?xMW87/JRdkl7R6nCaE2bAIYe4vwPo7ELd7aTD9+Paw0aketK3Msmxte5UP?=
 =?iso-8859-1?Q?2KLS+kctDQjOjeBRYmdREAxdO9gEq2Kx3T0SdrDs4pg43wTivXfY7/f2Yw?=
 =?iso-8859-1?Q?cF3XMKnX1qRe/8CyO6m+9GC7W8Sb7LkhLEdopKmbjdMUfJ0KhWohwhx3eO?=
 =?iso-8859-1?Q?mEang4VTT8uj8rqmrJq4duHolFXZII7Ju2wAc4Sz+TjX6eua8Jy6zyZQ2p?=
 =?iso-8859-1?Q?0EerfvXkkaUYO6wTt4YP92+xgQCgBzoPzq6ZS8fjvum+ET659e7VVrzZbh?=
 =?iso-8859-1?Q?EJjvx2HPBB529iqqkzafCAdQIj90eenWEAt66Vh//Hq2obE/wtTzDIvjCv?=
 =?iso-8859-1?Q?CbJrJvxSMLQCVUKHPI+QHfK0Qm0bpEYWFWAeGWinvoOaUbCX/Rukcm2bMZ?=
 =?iso-8859-1?Q?Q/hz10xQN50sGROVdPmi4MH8xOVuSffVXEMFM/nLw0hkk3UziQmcCleaxk?=
 =?iso-8859-1?Q?w3jcGGh2fho3gz7JJVGAIGHMnDespbWM6v020uU03vypX3Gtqz9GNPxc0t?=
 =?iso-8859-1?Q?q+z//3mt6b4xwcp5jEDd+g00hyEPlXj1TXAvwzsOnwGpxjGzYd5ljXJBoL?=
 =?iso-8859-1?Q?Cg/MVhT3Ws5oNfUyGMCejnOmdp3DNb81oCYb1t6TnoQHq6f7fJOkKE+iSs?=
 =?iso-8859-1?Q?5KbNQlVX/hoDE00CN/5Ka/9L8dumuDSZZ7DO42v0DBJof1jEGYyB4GUr8W?=
 =?iso-8859-1?Q?VonuEyyguwRfac1bwUcaD+/jvigk6vD1IcjrGkTQNVt0FtXSHJEV/jDu8/?=
 =?iso-8859-1?Q?N99m/sJOZZddFP25P6834yATQ6sqC+gczElPvpwEdXYxCeNjzENN8pbH9M?=
 =?iso-8859-1?Q?3Qc6+LNaDMVtdVZzsVlho/I4cMfq5MA4GqxyM7xIohqApnNsZLSJuM4PLc?=
 =?iso-8859-1?Q?XA72yq38tZtcdg/DfLY0RO/au1TxHdKXTIMp1oxuqZWjvCDeyWXiFWF1EH?=
 =?iso-8859-1?Q?vco12KaajCRqyUSw38TIUXYL8GzkP2ogSF5ACHwZ/603ZIp4bOBj45C245?=
 =?iso-8859-1?Q?EyGKzf/IUKN5k/X2nszXEF+1IWoV9cvIJrd50O1yLboQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oDB7Mjx+3l5/Jg0hXEw/sZ6L0vgyfO0SnTy/bZvnoRRwsOvlw2p1/Eyc4Y?=
 =?iso-8859-1?Q?vkqoRxuEurRD/s8qx6DMiLxQI1chU4zm+mRBWLfd87xHp5foqCR/2LLW9A?=
 =?iso-8859-1?Q?PvYPxD1Si+x2NyeJYiR6DRed1l+eCByeRPUs0gBwek5Eutf88MGnlzd1G4?=
 =?iso-8859-1?Q?LIxmPMi6yFE7zL6TuCl4Oy6yYnhAPrPfhQ3FJNgCusjtJRmQoQvVnUjs2z?=
 =?iso-8859-1?Q?+0dkxftauezONaxbxUNkZcP+OxCuqH0KIiSrXbBninb3dzQBzdh2FXhLrJ?=
 =?iso-8859-1?Q?A/ApHTtLhSa2LupPKRTf46DRvDsSgJzyvG8fpwSwV9EEWCE1Smw9SiP6L2?=
 =?iso-8859-1?Q?v1gWCxd1KfSe7Klv1El1kr+Y86lydVESd6RP8Ac0kNKGMvktADfQMfOtzp?=
 =?iso-8859-1?Q?fKIgIlTI3fWgwpXGUJBsKbE1wUT8dBPu1jxW5CgxqAyRjPaxi+nSrCXrxp?=
 =?iso-8859-1?Q?POIUx2JOnD2cxPOlj56OfMEad5nu52xYgY1L01eIyCY3KylcnRJW8gnNdx?=
 =?iso-8859-1?Q?GgFH19nkj9vNzpFfSMaQrr6tjhyrGTseh/vzuFBzeN+iwlbFAb8WBFfOqD?=
 =?iso-8859-1?Q?S9ZfgVEowvvHE3E+FfVWRXG+BX7Vw5Cshdf9H8CJg/+P+VK2BhSYfm7em7?=
 =?iso-8859-1?Q?mxWDHQluEBJCWCLTHwiM6UD5GG8iAm94KHPRecRT53pYnLTcMjyxFDggdm?=
 =?iso-8859-1?Q?u1jYjz+yT61S2B/2panTp1ZcX1tz8KYd0pjz/5JKdfo77d0pcT8EgZsKLe?=
 =?iso-8859-1?Q?sN9l+3RgxD5UB9lbGI1HhGR55JWFlTBFnx5bkartwJLci8WpH05o6DqLB6?=
 =?iso-8859-1?Q?bpN2ftw7NHdS5shvzEy1MuEaq0sqTNjnC8TsiU3x5mZXG2WyIS3Atkiz9T?=
 =?iso-8859-1?Q?jqw2kjfTtFpVWXk1zQKdV81IklEWT95Fa+0PK8QwAH4slPZfewCQcQl7A8?=
 =?iso-8859-1?Q?FRicJIff+V5kXRKuQbjdysCUCbmdmJNNorw5RQ+mAoKoOKI6yDQtysFfDe?=
 =?iso-8859-1?Q?72gYJLf0wlRVumB7QmIQ26E1wftvvypYn+yU0uOEJmrPVauPoa24vL1lcE?=
 =?iso-8859-1?Q?5jAB00nvHjOk+tt29hv/Fpz36PT0I49oDnoxB3I5nPJwoXmH9h9UeeqqT/?=
 =?iso-8859-1?Q?zgmXDIuyvsLgIibDDcpbhiXcWQ8PSTB5JcE4cFEVRFG7k6iPsizTvsKU8/?=
 =?iso-8859-1?Q?OnPo3z3JTabZT8smq2E9+Zh/AcASEkxgxFvfYMm3Eih6T6MD9PIkJzOoxd?=
 =?iso-8859-1?Q?YoyTqdmNBEZy4lsS5tMk2mF0v6GiO19f8yQDjIYpxiqL64EO1JC2oDsIva?=
 =?iso-8859-1?Q?tbYN92GIXySd60Y+vPDppGh8KIJD1SCLR+yZLI2UXFGmMElLorPlyA/ye8?=
 =?iso-8859-1?Q?zUeo88MZtpDdAMFKFY5nOkoYu/kJvrr6NAmNcZbQ064ZB41yHQHZc/FMre?=
 =?iso-8859-1?Q?fN321ihqT0DmmXOiK9sQWgJsFth8zKa/wwFyQUFstUxHycL7RwxNWwhavV?=
 =?iso-8859-1?Q?uODrsIbdnENirgnK+0WQRnklwpy8bojYLG26rbqakdSJ/XcOfpu7dWei0j?=
 =?iso-8859-1?Q?wLg/GuglyEq4gKEvm1Lk3U/SYE/ANigVdSV+gQwq1GdrkXnQQGTq6HYq4g?=
 =?iso-8859-1?Q?dObrXJyNSv0+TmESkqoexG6+xKKdn3ymOhT0HQ6NkMufLcYzeExXA09/9v?=
 =?iso-8859-1?Q?Lpq+IKs8VIs45NSEhdA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f0082b-b07f-40e3-05f0-08dd83f0f40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:46.5149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o/GDDEyKx9bnD1oOvnfroGs5O2ww/fa53EzGjIE+qfsRMzE8Xu0zbGajunWyqlJfChomJrrTy2ozWF1imNEl3VSAXg1z2n3BBZoqyWHV1Q=
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  3 +-
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 12 ++++
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d201a0dd02..39872cfec5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -238,6 +238,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
=20
     { },
 };
@@ -544,6 +545,7 @@ static void rv64_mips_p8700_cpu_init(Object *obj)
     cpu->cfg.ext_zbb =3D true;
     cpu->cfg.ext_xmipscbop =3D true;
     cpu->cfg.ext_xmipscmov =3D true;
+    cpu->cfg.ext_xmipslsp =3D true;
     cpu->cfg.marchid =3D 0x8000000000000201;
 }
=20
@@ -1762,6 +1764,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9643625018..68634c49e7 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -184,6 +184,7 @@ struct RISCVCPUConfig {
     bool ext_XVentanaCondOps;
     bool ext_xmipscbop;
     bool ext_xmipscmov;
+    bool ext_xmipslsp;
=20
     uint32_t pmu_mask;
     uint16_t vlenb;
@@ -214,7 +215,7 @@ static inline bool always_true_p(const RISCVCPUConfig *=
cfg __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 375970defc..8f6d485a52 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -28,6 +28,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -43,6 +49,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 56237fe610..07802bf30e 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -15,13 +15,25 @@
 %rd        7:5
 %imm_9     20:9
 %imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
=20
 # Argument sets
=20
 # Formats
 @r1_pref ...   ......... ..... ... ..... ....... %imm_9 %rs1 %imm_hint
 @r4      ..... ..  ..... ..... ... ..... ....... %rs3 %rs2 %rs1 %rd
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
=20
 # *** RV64 MIPS Extension ***
 ccmov       .....11  ..... ..... 011 .....  0001011 @r4
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
 pref        000  ......... ..... 000 .....  0001011 @r1_pref
--=20
2.34.1

