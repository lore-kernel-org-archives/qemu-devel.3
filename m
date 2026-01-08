Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC2ED185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqGx-0002Z7-El; Thu, 08 Jan 2026 08:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGw-0002Yb-DJ; Thu, 08 Jan 2026 08:41:54 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGu-0005p5-6e; Thu, 08 Jan 2026 08:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhFGrc+07iw/3zxnNhHNNsErQqfiqQLQKdPB+lFCOL3BGneV9J5LU1YSSRN+h7LEwdh44kaZ9j9vovUS3dOR0L+RIDg8u9Zn4R8vVdurpihDih26qvKlihxY2B2rrE7DqeBbcrEb4vaYLmKhSkFIyti4jYSN8oq3kG/kURCCEY93y/JDL087SEzmY1iBkAzQyISCSzcsPHt+5Ca7n2FobUzm9VO831Ub6aMxW6hiscNCqnR9cb0zPTcwRu9Rj/Ksfzm594rLKZmotpQUinMqbQjIMyv4fsRX4EKpQTDpo8glOkkDUziLfOpjz+omJfJVjjJ2L3UHENA943h7HkPsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLz52LxnxeYyLdIknUwZyIURI31CMomeggiJKT6DKS4=;
 b=kLDxixDRnELdpZ+6ZB0QR2sURqzDgdQ7+iBpWLf4IaTa7ag9l0WyVwugqMkqB5lBa/Bnfav0wQ0k2kuEcZQ9pu78mMPKTAn4qNxR1JL95yaznT8Kbjt7PsnUR/izvARJLWQd1AH/RhG13oUj0lVhpaqJqsx674xfiyGmvxW+H+MSBBuLhyAV5K5eFOugFNLufklEM4avcxvD/W/LT32uzna6GyTVHc1Se0L3tSbaKEXUn/VogjQMINWTgOUI9Ao4Ht/hsf7zbRnMgxqPKqhQMMvQaTPS/H/0lMzRDCIoyHonL1Kklz8uyADcnaDVW7B9zrmOCuYJ4jJLgTauah0a3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLz52LxnxeYyLdIknUwZyIURI31CMomeggiJKT6DKS4=;
 b=sa53rC19u2T1PUHuMpYeqwpCNC2BYoOeNmKeDHDOfGHeo6mVqUdi70B0ci352SjJHLRX57mZoYE6MZ09oR8ZFTGvap4p+GgNVALnv6oL4SGZob23wRpwmimgTGw4r4SeNZI7tUxGjJYX5n7z6r3gvyY2zsyGr3NSnVMmOvehuY0p99Y8wX2Bl1EWrsk4z/mB3R7hxd3uc+45PlyjImJYEX8r9veEBo/+xhRNkAcH2Ehe2KDmtlR61qj8BJHSu3iycVsDk0WNaUf0kkmpzwc0iFHSfAGVVDzdCYiELfBnrwQchqnMqK+5pJZV55eFtHZIhR67903kGhd5g3NmcsOQEw==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:38 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:38 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v16 06/12] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v16 06/12] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcgKSDbqVPFDiZFE2uruhHGZSNMg==
Date: Thu, 8 Jan 2026 13:41:38 +0000
Message-ID: <20260108134128.2218102-7-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: d85916f8-ebaa-4b95-8d4e-08de4ebba60f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?okSG0pt9I9N4nO7XnS8ZGQDhni6sLrBpzCwUAtjfT65FZ82KgWPdvoQAQ4?=
 =?iso-8859-1?Q?+XnbM5S9FqwMqtj5OlRMHCmbq955N3h0w4XKeMluP5VCGA7OlL62sHGAh1?=
 =?iso-8859-1?Q?+9G8SX6fUMFo37Z+9QP+4nMR5LlR86V9f+CTnXpOd0Em3+n9g11oXyWPj9?=
 =?iso-8859-1?Q?8JPiPomci1mxrFWkfjTMEhOb+4muaRJDDnKJk7jTvb2UciId/GKg3T/5P7?=
 =?iso-8859-1?Q?QRHNMDU2DCO2MPKC8zMJ1+eNzviRiGu2lkXpwPGe8JCT+cptPCOteTFkte?=
 =?iso-8859-1?Q?CpgQD02izgIytlPDameIdofKkYya8oHAE0q1fcMcPFxNMxCfbjv9oQGRT+?=
 =?iso-8859-1?Q?FYhdLFq0wNr7TqTbiyVOcWdpxCYgwtiq9S5o8DjhqLYZnc0KQFtLR1YfSE?=
 =?iso-8859-1?Q?iVb8e/GC7u6SZCuHnRMK1lln2iSyFONU6vsPZnc/CPW68fBtFGUc1+WiIs?=
 =?iso-8859-1?Q?UtYxHWME5P2K0+oiuFJmbpcFbZXFt7uBIYyPIODnNInqYpwx4z41I/RZVd?=
 =?iso-8859-1?Q?xNPFD2vTPE53ABjMQpnIVYPrJUY04fxECQKmsNMfmuK9DqeU9KH8ung3b7?=
 =?iso-8859-1?Q?Q94rsx9TZ/vAskEtIIrv/ZgtbCJxiLuiiK31SQ/hxD4LCA6wBgS8MiYVzY?=
 =?iso-8859-1?Q?m8vGy634ew8LHCKmy2tUpwlgxQKPmPmtxO5nXZGHtbUv/CoevspznZce//?=
 =?iso-8859-1?Q?3YtLGM5goG7bIz7CkkX1+6DFwCbZCVOZnw+IN5gC4V1jqx4igfz/qOmhzi?=
 =?iso-8859-1?Q?t2aNqVPYUargeq/6eBAfPjgmpzo8f1/heGqHDG6lU8x9vfjeBRXyGSj6tv?=
 =?iso-8859-1?Q?n+cbC/TNYa6FRWCNxzDfyWXRingF6CMLp3gMYJo09caX3WzIHMIsK8aHpX?=
 =?iso-8859-1?Q?Y6gYWaJIBntAQBgLszqy36FMRPixCdz7AufcHPptJ+hDWi0Z7gAACJ9Qou?=
 =?iso-8859-1?Q?LSg4ZiPY5MGFsvGG+emGkQc/VwNdmMk2+YJs7KkyXSOf1fGcDDyZUP+OW9?=
 =?iso-8859-1?Q?roD7afSecBDnpa4BnOJqH4KOz4AlqeeP/j8u9lT/zGcfxwiMxPLWpwbROQ?=
 =?iso-8859-1?Q?n0iaOs0hrDJb8A6A67I/hK44sy932YvS4cBfZ1I/nmA0mX490GotOqI/Nm?=
 =?iso-8859-1?Q?7tv8ZwA0+aKuMrcWzA3/3+lPD0pDOfaJgML6iTsQZJcyWXWy/37tuInQ2H?=
 =?iso-8859-1?Q?rXw25LIHXiguqLaSWiSkp1ui4iW2tYRubmrL0CkP08ZDfyEe5BeEn0LoFU?=
 =?iso-8859-1?Q?NUGxeP7K2rPrkI2IVsP35eR9mswh9haNvpH0RyxaQaqIRe9Kd0mEMK5VGv?=
 =?iso-8859-1?Q?teVxTnmVa4sUM6n4klz3Vl4lRiqOShQ+XqcriypKbIXW5RTrsVx94ogQJ/?=
 =?iso-8859-1?Q?31cKxyEBRHmjJ627I/b1y4PqNUWb00mKqIN2xnRz2fSkVL++1W8Y0PL6oL?=
 =?iso-8859-1?Q?indT/R9fN80sA+ZMiFUhzlzvFigHBT2UanXYzeWu5dBj7LzcaILeoWhZ+p?=
 =?iso-8859-1?Q?VlAWnmY5HT5n34pBAMY/d5iMoME7JQrOderhjAwqN/ysGm2yPacoszgZ2y?=
 =?iso-8859-1?Q?ru28TYwpRMCQI2/hDKeT70G41DJQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yLrLD8TvTII10TmLUJQOmBWy7jIt+FuLf0DJO87Ng97iRuVo2ftKg0H5Ns?=
 =?iso-8859-1?Q?9o58KAE0zQ7mbKriiiEzRdCNwOFEAJKeo+17w7xdISVCPgbpN/zqRNAaQF?=
 =?iso-8859-1?Q?hAxTJZtNi8BWqaWe969IcyvyEeYaYrqvwaLhUB2PK0DByjiK8keqe5+72t?=
 =?iso-8859-1?Q?w46WuohjBHlFaLcN/RNLqn3P/jOj9sl9jOR6OxxDHJjAaLgjEMYswbWzlx?=
 =?iso-8859-1?Q?qOj0p+/+uWtKZhkRiMsZVcAB93ImbkqFCeICzClb8pxvXXd9+s7KM8omG6?=
 =?iso-8859-1?Q?3r+j2Ioi8qX4ZLiToKOBU/3DHm91WNKdJBuoshWBd4WLjkAI39MSWp6mO5?=
 =?iso-8859-1?Q?7dX9vgs1tjqsoW8r7tEqmC1GH2mF4JTnGc3aedVm0cVB/Q6lUKKFNQe5OI?=
 =?iso-8859-1?Q?9mdKQbW25ldmIKXgWP3U3bbKmhbwwnT5Yc+XF9adPQ9e/YLduUqnvROnAM?=
 =?iso-8859-1?Q?gCUCDsZ2cSLzVv0sUWEa+JSiCLtYR7RVovn4y9E1A2qjZpG894Cf89ZZmn?=
 =?iso-8859-1?Q?sqztzNux+Mtdt/6Q9QXcyjPPVszuRNL3mpv3ofSMXncvaYzu5Y/yE0NfJL?=
 =?iso-8859-1?Q?iZmX81gXKKThzX+/RBfhCZDhuVhvtZ0yGQCoxvDIh3wuJAfBSSuBJTwnR9?=
 =?iso-8859-1?Q?QjUSjsuE/DilnZ7kxwWkHxdqryFefX6gTy+dPuSIEl0jRPo8F6+9rzycT1?=
 =?iso-8859-1?Q?H9iOFaQ3VSNVaYswPkkz9MhB2H60WC2VErh8YpFmj44kQKfrkonuOyyPrM?=
 =?iso-8859-1?Q?evRaDQPo/8X/iDaR1bUmmp0UOgT5zNfHYudpCW9KJ2+bkZI6ecklH++dwL?=
 =?iso-8859-1?Q?9afhNHMbzvSo6xMoYT71k7vVeOWsjY6uSJ5kpvK1OuFyI58j9JSIbXzFd2?=
 =?iso-8859-1?Q?OdUqFX8mDvxhdbaYfKWXQb8XTs5VuVr6znZBnPgZiqR0tsNKRaOp/YXQbt?=
 =?iso-8859-1?Q?H/8mWUukOSSBNFpqajAnSvSpMIrsIdTq5PTrMUld6VQjTjyLdmnqONl7kt?=
 =?iso-8859-1?Q?gurc7gL9/GamM3OG03ou5V85VWsuSCXI5PdL4ZiY0fQk1fLdCpsvsVCcVM?=
 =?iso-8859-1?Q?Hd9h4g8LMUJXZTy3lTsaRsgyUDRqBLJXiJcdOzqyuBLxCTjChpQWCdUDxU?=
 =?iso-8859-1?Q?OBGc7zCxBZ9VjqtOXRA6n8iuR4MrfNKx0EYxrDpbMDF9eOOj47rojRnAyO?=
 =?iso-8859-1?Q?Z05td+L4tqWkhfGrXBQp9bMmwJzX1SBcbLC4Rd8ZQ6/GX9mw/THwauplKC?=
 =?iso-8859-1?Q?iKaTFu3pSf9cSgCLQlxFOAVH0QXvfbUYvnaTAY2CvsdpSbC/IdchvLsU3w?=
 =?iso-8859-1?Q?GIVa9Ejq3Lmd+77WEIeT+qH6uIR5Ipm+OwRE3uOAgEGIClby/QhOj8Ahfb?=
 =?iso-8859-1?Q?PiEsQDCYoM5APH5QqfzXMgUeh0sSeIv5U04ncEw42LLhyAOfQYCYYBJPIT?=
 =?iso-8859-1?Q?I1GtfriQZ3bNxFimZIgtm6AIkUBlnobrvaU4rfn+eTa1wOe5ypvX5eDyom?=
 =?iso-8859-1?Q?bNIjyiSwCyv8CjxNqrax0hYnFzJq9Q3QReV4wK7S7ijanNK5h4qHoes7wU?=
 =?iso-8859-1?Q?CFuKHNQ00KrqsyYkIE0lSInpeTvX0VaPtx6BWY+wjHnvLHNo4bfe1F5Wu1?=
 =?iso-8859-1?Q?MMVfOQGQ0dckxajZXXEAUx9BsLv1WrBx/fr0UAvG203LwktmNIX0wlaUPk?=
 =?iso-8859-1?Q?trdGay5Rigcuu6Ow7r6yPglc8QDQXOqkKMnzYRLBRA/UzdA5rhzwBiz59Y?=
 =?iso-8859-1?Q?Qdh0NitjVwjhN0AUYbxGHZJ38bl8YNtJm95Rg/vgGM9ECYRdDbO66bnDtL?=
 =?iso-8859-1?Q?pL8ChQ9yRIxCZJDV3afnbYJwXy0ieKm2kDHLm1jP9HmyePyuQsJj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85916f8-ebaa-4b95-8d4e-08de4ebba60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:38.0902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAcumUbntvA+H2GRT4rMn2JCoOBYXwmfmT8DCQfpXL7HRpR/DoaHvSRRHPGC+x3Xr/xTUIKhGHtktq/mk409W1j9y9MZtGlU3qHAze+MO8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08c345a493..3b9d17d58d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1386,6 +1387,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3338,6 +3340,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 7dab84fc07..7729fef3a8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
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
+/* Load Word Pair. */
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
+/* Store Doubleword Pair. */
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
+/* Store Word Pair. */
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
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

