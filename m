Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0CBE6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzp-0001T2-HB; Tue, 23 Dec 2025 04:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzn-0001Rm-8T; Tue, 23 Dec 2025 04:47:59 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzl-00025T-HE; Tue, 23 Dec 2025 04:47:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxb7ppZfIiwZHCNyXtTpei8qiqvghMydspvQs9NDiu+wRrZSMtrVE3gdPEF1BoyUPf1Wr/cgevgv8cA7jle5d3638XB9Gnn0+4pECUJ5GLofASxxncxvrqe92KsZSPWPHveUCqDrL0DbCCwi0xIpcUkQaA204Av4s5hUZCVnsLjGDj0aIrKyq1fHKCgnXlf3xNOv6SG5E+CQ4perAVSYdkIZmD5pqFG+iE5DhsuV0v4mOY9VQSPffdwmH4apWk8hbU2Zdf5e4CBZ/iX9fPPkXUyryBl8GT2RTenREpODM/qWrtXFu/2WwqeH3iV9boWDnpih2Xb7Yj0DmldpAtwndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7C33spovEnnVfYY9vsz+RbFcCuBRne2wpG6WieJzKw=;
 b=TT4703MJkrubMSJSyOlH7gIaf9djeVDuufHY7hTb8Lz8BCJ4Kht76kH9IsEPvxSUfMhIYesL13JfEFNAt/f19P4GuIxwppS5PEvEb+u9bBza2nVp/osVen2FgAYKrD1ez3wmombBJ0gyRr0rVl2zaUm6AOx0NKXXsVLcEaaD0tb+YXhNUwPAKHE5fMEt9Sm+bHS7tz6qRF3ykZL/XGRPPGXomlvz2xvXeWlxemvSmD27v5eutzLwyt7xYp6vRBSPX+6pQQS5nznMQviUKkh61AaqHSOV0hDbDaGbBEc0dOZuU8pQWThCDG/idS7h4lfL9ux0Ril7/WW7nyHqda2bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7C33spovEnnVfYY9vsz+RbFcCuBRne2wpG6WieJzKw=;
 b=RypLynFdwti1ssB4s6Zf46MwXoNvn/GcGbMwbgwiXsdC5efWtm0bl4Rmnb4Rn4sgIch2+Xl+M0ZyWjWQsu5fHdvylZJpCvOXjOU+QkCM6aXXv027P5SAX9tGiBBjVsdfhvuJUDQcOqMIb0BFY6wfiafVyEZrqjuL0lOq1DmAGG6lZVkZvRFMfSyd8jMvSeOsUG0B/P3fkPnBaMEISQd7y45itHyr2r4hVMt9OCo78i9Go12+6BOZJ3AaS0acc4ynnDMSYz+EXKfH+H3X55y6pN8CzYYzqHy4hqt098dAGFVfTKMfZ+2/OndGLwQMY79KK2p7I0KNAexz6JIMp8RCag==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:53 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:52 +0000
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
Subject: [PATCH v15 02/12] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v15 02/12] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcc/E1O+a0wj6n60OM3BzHkpiJiA==
Date: Tue, 23 Dec 2025 09:47:52 +0000
Message-ID: <20251223094739.1983381-3-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: 7fea9faf-b7f7-45f2-b028-08de4208578c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XgvaRIhNOFUplVJTStDPzh9CngV2oqWLlpnaa02lutn5aJsYXyoSV+l2yI?=
 =?iso-8859-1?Q?xTI3osbj/zTdohxVoyzIMi+OVGcsuj2SCnab5PUcDmnfMTN3N52DXKK5zg?=
 =?iso-8859-1?Q?goKaXgajthdj/fVHVgAzimMVozL1oQukTQiFTorUTscHrTgWU80UjB4C4n?=
 =?iso-8859-1?Q?hh/qjhTB90k48NcElSxuGey2gmg2jZ1tazqCbaALE/RSdMy9rWMnHhqQzn?=
 =?iso-8859-1?Q?MsVFEmcU4cw5iLPat/8WWdkaecWpxZjVhWpXkxvngs8dLE0XxWMkwtSx2H?=
 =?iso-8859-1?Q?4JaPNHN3WyQEDNBjSB2T2SjelZ6WdX3MklV7fccMkHxM/UvJpoERe/hUxz?=
 =?iso-8859-1?Q?242MWPn7hjdQ41ruCzAj7IoS9yVFynXkaKQZkeZLVgkCjDNrYlKU/mUIVL?=
 =?iso-8859-1?Q?Q9yfgiAgFzXQsUMO3M/gVyYRbLH7yvgp9Bgw+76d6dIlIFKhFbXwU5C0g7?=
 =?iso-8859-1?Q?Y69o9wBJYvFtSFg034YC/dzEPC93xGKGUCNlH5faNCER2qTYHAYI6S2xou?=
 =?iso-8859-1?Q?uLCH6bf/y+0J0x8PY/7OrWj8Y95koreaFJaxlnu3GTftzib9rM2Br9jhZp?=
 =?iso-8859-1?Q?LMpqXWpidOXTnlkfH3FjDhVKp8lAM8Mk5PnF42QfMH8XxG+1Ndqri6ZhR0?=
 =?iso-8859-1?Q?NlhUo+8GdTnBMeBQaQP246nbwjHCg5h6Sgdr0PXpCFihTJanG4+xIu8o8Z?=
 =?iso-8859-1?Q?QAhxQfrwbfeXckrRQ3k9jdOhYtjZ60rwbzvIZHVd+7ARcqgTSBASf56or0?=
 =?iso-8859-1?Q?oYXgiLytSyiMYn79N+lNKU9ToyS25zgMl67oJgqY79isuzb8HFcB+BFbik?=
 =?iso-8859-1?Q?8vrQEC7w235X0odotp+Wzs5R9TAxM+hENUE5pRXaiGqYeWeJVAJKUJ2iMe?=
 =?iso-8859-1?Q?6rmTnexL4FqQ1Sntj4GAmlFh6UQ+iP+Llao2j1cnA2sIabmcDxxPQ2Q1QY?=
 =?iso-8859-1?Q?WYzPG72RJ5aBCURri/sRfpOB+FteHRAHCt2Z1BxHZGk9bYMb7QWGot+iz0?=
 =?iso-8859-1?Q?T2EkB074LxHZBt4IlPxICJGW2SXJRbKGyXkzWD0phfLa7oJWNXJcBpjO6q?=
 =?iso-8859-1?Q?6cjk+BtASTntOMYrmJ+30ecgxF5+fXI8CNoIEd7FDU025stG87BMdpsFKj?=
 =?iso-8859-1?Q?2q6Io++xLwuH94QALoEEtEGoeklTx1dPLwUAEyMSuyz+cHXnigTBjrpeVm?=
 =?iso-8859-1?Q?a2AwdH0ag5G+uJ8bvUuynYhabpr6h7cT3Vk/F+OYKfhiDTb0yZ65EcNp3G?=
 =?iso-8859-1?Q?rlqJ5KaRGgDENgVaw/PWys01Bhn7D0anklY4/FncHWGZjfTcff/igPbXgd?=
 =?iso-8859-1?Q?14WEcUnvBCXlX4Yhlo2PvRvjf46G0GgWQX9hPTtatxTZGajzJZkUTTAzzb?=
 =?iso-8859-1?Q?sJLMfxlZZKn6OsClJfjRLHiH38XJYaESDrdz/nraI6MwBQ7OYx0GqTBsDH?=
 =?iso-8859-1?Q?K6rIXtUCdCP/OQtgs3x6k6g/t28MON+Ro3T15Yizh7rxEsq7QELHsgQetN?=
 =?iso-8859-1?Q?3I0WnPwXDkS9Wb++L/QMteOym6dIAz8zJ1KG83JphxsO5XxSuq8AmzBcz7?=
 =?iso-8859-1?Q?BUc19vRwxfIFZUpXOMsmfT0RGAbQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nXeVHJ6uCOWHhvFPoaXPPc7HUu0RI58sNaw3bHQC+s0k1J3ozuFwyDKeO+?=
 =?iso-8859-1?Q?9hD4YOYl7ffW8wcf7oiseSvngpeWCjpFPBySDvNrzXDdBgj13twD4Rdovv?=
 =?iso-8859-1?Q?8cHVSXJUBm6pG1mvn3hYVk7MQuAY2++Ln7gVxjoD2A65I6F9aSiL/wS+VR?=
 =?iso-8859-1?Q?CthJS19qMGy6xs+xFBqmVTGFYbt5KgPPa31kUDkJsG3ockxaAWLKg5d7zP?=
 =?iso-8859-1?Q?985pqHN1Z2pi5jwZd0r+ShWz3OpT6pBPlI90Dwv9P0nJNrfzyMcG5xww7T?=
 =?iso-8859-1?Q?YDKaaYhsrmG0mA6vQvmrPQmMqkyr3qw5ppc5m1QaMflW1gw6+vIOkrhtXR?=
 =?iso-8859-1?Q?+fVJ1hkbxj3jWWgvgUfVi9JWAFG2xusMljYTTcVy1HlJR+QhWeF/GwnveW?=
 =?iso-8859-1?Q?junSvjZ4mLPsXxiz4jD6yszKih6UOGY7Anot2tFA5tfXUYJ0AuxmkyqdE3?=
 =?iso-8859-1?Q?N+M4QuDkT17IRugffez/CgaUXRjRvSyBegC7WQPxH/qpQFvioqEVseABrp?=
 =?iso-8859-1?Q?hGJ7bOMkf72hjRmn4xNMa3bjqiOYre9sm4LjETUa//2ilPfzv0vigeRqWF?=
 =?iso-8859-1?Q?Z2YNQq57hRH4zJSZkyekI8AW3sVSRRgPdTFV077hVYOO+pWpJcbAnsryWN?=
 =?iso-8859-1?Q?8go9HAPKrvCEbSLlqtP97JdsdBrD7m37aGK9OoVrMCJTe3zq4RWSWXODAW?=
 =?iso-8859-1?Q?vwp0q8onZB6VTNq/1Bm+UILVOh9Wwt0Gyx9Haeor0pQJJnspK2i3DCoMSc?=
 =?iso-8859-1?Q?JltkkJmItm9EjaXRAT/yndJLoAxb1qrXKu4T0/4q9dQCmoaNGffxnYCGlF?=
 =?iso-8859-1?Q?1YTSEBoLdhgnnN6Kp5ZEi2YufdgERn29hjmBwj2w//9AU2dSfU2v6DSqyA?=
 =?iso-8859-1?Q?8+GJF7GbXlhH3OuFoAmGrwC4r6aC1zRfzPc9hIOKLtFv5PKNBySxcwtOzH?=
 =?iso-8859-1?Q?4OOSk9If73uKyqhYAUaI0rAGTm+hdU5U471M6bt21EPynGE2/kysLoWMsK?=
 =?iso-8859-1?Q?sYMHcCblCLRMllgPgd/j+WYKwfTuh2zyKfzm7YmsOJMXgQV2fPFvGzD4Tr?=
 =?iso-8859-1?Q?K/0QzzOpXlUH7AjnpXtBLY4tXXkoINo7IkgKkWLoA01g6E49hqieD/ShSe?=
 =?iso-8859-1?Q?hdxgS1t9wxFPP0fw0RB5J21Pf/rPexzJFopmoITraKj/KWTtXmln39o3uq?=
 =?iso-8859-1?Q?6pEwBJaSUHiC1THmIJ0aTdIddiCvINKSIWdx017Xnf1v57uR0r6r4yve53?=
 =?iso-8859-1?Q?s8GbCrUYqIJEWtRdAuBg3C7Gx6OQH6eWmRrc7UNhHjhPe1JAH0M1zA/msF?=
 =?iso-8859-1?Q?03MFFLYgCUT789IkNw0Rq4xGtgP4d2vGyuZLGk9Xm+ltGBKofPsX3DQXSR?=
 =?iso-8859-1?Q?IgPlWn6liSRqygBlr5+miPF1Xp5ZDnRPyQh+P0HWLLke23dgmvxXd5kIUt?=
 =?iso-8859-1?Q?mFzsj9wNUWNWr0W0VW/tN+qSO02vYAwMk4lpfyXHXQSbfToGYDywYga5Km?=
 =?iso-8859-1?Q?Q9m44TrBOp4XAn4+ToQkue2pyeJs5wzceV9g0lmsu2NwHFwOXRQSE8Rss8?=
 =?iso-8859-1?Q?U8fVlshwI8JW32CKKwwH2yiAeVD1dymL4QH3E0U6TrliPBUbVdSg3hdT7M?=
 =?iso-8859-1?Q?ds+jhav3MdhyDSECoRwuDWfyhYGmywdHH9tDl/5T2KSij1j6jQrTUXGAFA?=
 =?iso-8859-1?Q?OtHRj6y/iWrjVCar/ggtQ7F+5jYxkM582C/oQWbgE72aoqeblWLU6+bHiw?=
 =?iso-8859-1?Q?QJmivy+SW0goLlEmiDPbdvSfX2QjpNKxQdYWn5f0vkk0OJlQnCVV01z/rC?=
 =?iso-8859-1?Q?SKRWuZfh9Q2lxaT4S2WbqqIfcUnGR9qinUbef/Xr+ggHyb1DbUqN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fea9faf-b7f7-45f2-b028-08de4208578c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:52.9001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbpFAb7xu2hOUfJIiflhhC2oYU4HDhxYhVJRKFRKMD5NreARzsv+8tvAEyhi6kJoaCw+kZ4vw6bhwu/yD+fm1EVCWgYF2c+2znj2vVubABU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 07c0e215cd..e473e36e20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3322,6 +3322,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..f1ffc66542 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x127
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

