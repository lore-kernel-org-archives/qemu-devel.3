Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB92CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97w-0005BX-8U; Sat, 18 Oct 2025 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97s-00058h-87; Sat, 18 Oct 2025 11:45:48 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97p-0001Rh-Sc; Sat, 18 Oct 2025 11:45:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky5oTZnD0mSdUUIyPhhbMJTOzVj9lAYaiGkBCSdBdYJKDPF9GvS6a39HmaIAzgL79t5sr6tDO+sX+pBjEY1I+HV/BvJX2nWN+6USfiVviGeccNbQ4PzuDc0RWR3Vrh8/nsmjgEOiEeTyb/lsnU+ij/rzaVpr3FEfA8Ja/EF7vvOhm07+7/74Pa6UPQHiT1cfLpV8jHmmRyf1TH69ZgxK3NDtuG1oLGifM6pBpRJ6fCoRhQZ72XdNqQ9Zgyjthh3uXZcESBLKPOgiqNafDA2APebHAa9wjayTzx9FOA/RGht2TzmRWqj136ID1AzO//mbOfnA0KEtbIiN8l2PrgQ+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=EjeKOB7dGXEg+sRrc8izRUFfEYchH0tgwEQt2UPk8IL21bYW3U+h+ZE8oE0BmKnQ9n+ArNWSQNBebUeT8N2lKR8utuwQUQ6C3D/r45RunxqBXiRB3VNJ3yFQD9+a4+vnUYU7ebZaRg8hyAmjCkuDCX0O3q8HeQG/CfCdemCGeNnhkiUN0cNsALouTWaBM5UAAHx1jenbSoyGiU261uFsg6ZQDPzfkEmfm2QZIXUUaygabalUx7HFTdlFc2qGeZkk50UqiJ1X7P82jeWuq4hSOZXQMZD0zekoIX2Yq/1fg9YQ22UZiwuC8Bq8I5bJXsdGGBK9KhF+Jt9Pt0VzTc/7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=XF1mFp7EYKeq531i2EWRI8toXbZDBWMnTZwjahHeu3Ypd5iV3Lr76yAv47/2rnKhcxmxHhgilsx2IaqMgJWiK5kH/5WV9xYvduWb5OAW4QNDa4VypWa6ynOa55trZJB3AvbTjIC6QVi0nbupLb3QQ6MQjFB/jaMBfrYmo0Eil6UiWYk/hRo57BetMYZQdJdPHy4e+sli3wgsDA9D96UmagdgQS8szb49ZTQp4crGhcOuFoJ/FdcoM22uNtiVYySpnGTaib4KUvxwFmD7a995+iQvlNDCRy7hli7dAuPlMjgGrA1f42Wq/RlSCpN15WxYmSS9C6/8756GX25TgZgjJQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:31 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v13 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v13 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcQEY7yzW05qLT9Uq9xX2Rnz4KwQ==
Date: Sat, 18 Oct 2025 15:45:31 +0000
Message-ID: <20251018154522.745788-10-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: 64134d5e-5a50-4699-a6d3-08de0e5d5e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UY1sRfE9f3qjWbHJ3EEuzQJfvWjPkSv52fxdv7+pf7MwGkMDYdLgP0wPhr?=
 =?iso-8859-1?Q?eio9ijg1Jd7WEGMtO3WfwkSXlUjqa21FrS2B4T7TfvbxNsUO24sJIaiQeg?=
 =?iso-8859-1?Q?H7NzK380Py7q342afs/11kA2NNbHUoKYE0an7gaH/onw5qdzaxSlfdCNLo?=
 =?iso-8859-1?Q?aq1ztgvR/N70p5hxmvA4QJUtUkgAJtaCtSROgiRHE3tefIODFW8oqX2Wm2?=
 =?iso-8859-1?Q?ECybRV6GB0WU6gBsb/LG1VT/0SQKnu1ZZpftF9jaEqMJxHHZEybTy6DnqF?=
 =?iso-8859-1?Q?vzn+fjnK2tKnBoDRd+R+lJXGrGpZpOEk6hjWCtJ1wT73ivo26q8hdM7XcQ?=
 =?iso-8859-1?Q?PkhrcRgNrhpJAYvwb+eUc//RYWX2CDJXtjO2ZAmhgcHcfTFNTpYrV+d1Tn?=
 =?iso-8859-1?Q?SoMJ50ihvdkbd951S3B5vCFKWgQPT8t73UdKpr5GPe3hHPNQnQbfgOLPTm?=
 =?iso-8859-1?Q?SKt62bFSiCbgCp/WtBoQBxdYlx7DVJDaEsJyQqK4703VP+ut+j4kKT9f3O?=
 =?iso-8859-1?Q?P3uKMIybTH4CGfuDV2GuogqenOm2ftqCd4ElwnEFOGfE5De4fUby34A3gV?=
 =?iso-8859-1?Q?fOvnRzMDJaeJMmhJc+O6pNgO/7yFk9KZNX7MVioDPJBCD37ySq91ew0BTE?=
 =?iso-8859-1?Q?cg9l+hc+UwJ2fIh8NVdh7KaDw/gBXgRjlWy57dLjFgtRwrv1G7hkV8AsJ8?=
 =?iso-8859-1?Q?dQI1Sv6vg59qOi2JyHyG5I91nhmbyXGnVojmL2APeHNYDqYFbzBhL+nE02?=
 =?iso-8859-1?Q?k7bucZ0JkrKiRj/a/exKE9qqdNBI3u63KdTS5rcFiCWDZEmHdAqe5wGW0P?=
 =?iso-8859-1?Q?5NxYnoH7hZl5Cc5anfJTCYL6Xw5Tca8byM0Y4XoSB/gvurkAvOvn6OgPP7?=
 =?iso-8859-1?Q?npPr4OkUo7LG0imGd6pco00iD6kSsAkek5BFhHsUzyX8l79edwqWl7gKLo?=
 =?iso-8859-1?Q?ANno+Y+Uo1OLTohxc+whEPksv0R7h/fwEMaTHqo2qErHvc8QCGEkHBp4C6?=
 =?iso-8859-1?Q?CKAu0t7whFP4WP5u6+hOjOhFXIfkv17M0lsg+Xw5ZB3A/s1QDoFoJ63Fna?=
 =?iso-8859-1?Q?7DfYinhhvP2HaYEHp7sM8edUYezROMrtF/gvt9imRxa7SJx9vYeS1Ujcy9?=
 =?iso-8859-1?Q?1MO0F+mIe6WVem23IypjurG4cnSvEhjv9LLc36RaePU70xRoYDfLakxRvp?=
 =?iso-8859-1?Q?igwFrPwXRNiphMa3YX3dbCWzObYdflHQyE6dG8yn/htmqhn7kpJd5uffx8?=
 =?iso-8859-1?Q?tRWK9ZePMGU8fsA3jiexeE8hc3OT54J8M/rYx2rpuWTVxUmKv8IiscuXMI?=
 =?iso-8859-1?Q?x9bywRl+Qhaq0UwbDg9+1PIldmlNM1+dKUYxXotxWAXtYhpFGph1BPESy+?=
 =?iso-8859-1?Q?c38w3+Vqf+U/5DKrvRWeC+7QFSqlryKKkjYi/5mLP/9NbvLb46qk70NWua?=
 =?iso-8859-1?Q?+uhmhSOOPaU+6G9SRSVPQl5Sww9kOxDedCh76UUR3wGbyZNjRcx4/seZY2?=
 =?iso-8859-1?Q?P+qBQTYLKwZge6JM3ksH5vb+iBgXAUYgbjpFBUbbUnvoqijqq0r8585AUO?=
 =?iso-8859-1?Q?1XRUc3vMudhK0vdHxo1RaT4Tt4hR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t+5qzvQWzvj3vYRiwLkbFJOxfZNPwI01CSUmmUbCuh1kOBZQhuhxQUMTmu?=
 =?iso-8859-1?Q?SeVvKJzWZIf3ZKyFFvgEIJXMIe+mvrVOzuEgrMFSoKWfPXGp1Uf9WnZIAq?=
 =?iso-8859-1?Q?1lJUTR2GJYbUIzAMy1MO50awdxDEktBwDTEb0HMcTi/ywykZsreES8xKuG?=
 =?iso-8859-1?Q?yiRib9BbmLCyrumkvbBAXX/T43+fCE7GshZegVFTsA8xCTwMzXv8pQ9WaF?=
 =?iso-8859-1?Q?XphUkLxxUyUuLqC0Epmwhd/vjZP1fAbhqIW1mYhrmlWseZRxvjPuskeZCQ?=
 =?iso-8859-1?Q?aljEgyuNnHTbEwrIONvuXpWv2X59FGaHAfzrXLGrxidoh4xr65iXIZH976?=
 =?iso-8859-1?Q?x59+KY3x19OTaZQ2f4vjLLsiIgG5ZOcoajqSi9P0SkgGOEjpl8UQ6E+Is2?=
 =?iso-8859-1?Q?mDt3FjN9wAO1oONIlZ2HqDl3AM0cIxCPRq7iQBEOy81/WNGJPjukiofkJ+?=
 =?iso-8859-1?Q?5YPBVS8+SH4prnxKNPnXnIB8w4NETMlX0DAz/sK4dn+vogpwE92XhFKovw?=
 =?iso-8859-1?Q?vhV87622LqQB57B+ss8hKOGc0P6xZJzwpp4ak8FCDgTgE06+4Xzi6qaQYE?=
 =?iso-8859-1?Q?Xm67WqHlvXJImBRq8ARd7/Jywl1cAPJ+QvfxIom66tU2ku05cR4T91idk6?=
 =?iso-8859-1?Q?tDOLErGYFOOeOumYemKSXCYUdZsrFprQ5QTwySKxFxCbKOEF2IAU2oLk3e?=
 =?iso-8859-1?Q?jhOBownIggwFvgC9tVjeYGahKG+WRPwcOAGVi6AiTIoqbyt93KpdZKb6m4?=
 =?iso-8859-1?Q?1ESAvDl574G9XjXQW4MM8HFjnyqTSSvZ1Q1N6qvnd46uEXitmmXA+6kff+?=
 =?iso-8859-1?Q?VsNcP6mZi2lmLCzmnSy2SZ/mU5DxUfLF3YibhRJdf6gMzuOeUsKJqA1Nlv?=
 =?iso-8859-1?Q?E0cj8+VEP1+hH0pRQ4rQ4d1FoLrsNo/EfSro640GPs0xi+ujySIvi92I/G?=
 =?iso-8859-1?Q?iSjWV3L7kFtLBf3ZvluUHvsXFQLeQ41+4htYzcm8yzA0TpcHOC5fNWOjkg?=
 =?iso-8859-1?Q?0ltNVn/jalxK6BgDyqKN+yhGuW8l7IfKI2EjfnSGoxXaZ9mnFyUppM6i7a?=
 =?iso-8859-1?Q?7sxcdpFYD8kGaJ41Tx2yrFJ1zjpajB1etEhWZMeOXcezd0CnTtiT4pMrtN?=
 =?iso-8859-1?Q?qJLCrkicguojSosxlv/K5L7yPYaefRznAn8nUogOtv3hhX15ycqeTAKfj5?=
 =?iso-8859-1?Q?UVUZIA1iTmQ30s2IjJkj1/UM4+rNlP+5bWtIgzd1UD+6AUnR8d140Zb327?=
 =?iso-8859-1?Q?J20t92brlSH/y4eYIo7bua7nTYL3y5luFqDvsRtkZCkR4jQZ6+zoyaVSAX?=
 =?iso-8859-1?Q?BsJ09BOE/KRz7QxV3JChtJeDygB7hMzsHZOk31/1hr5AeubgBwEA+PnZy9?=
 =?iso-8859-1?Q?M0nlU4YcV3X/sfCXvmA2mNLZovWFy8NwywlQlJwNKzRy5Eefcb56Ql7/hK?=
 =?iso-8859-1?Q?Z0lqtf1ifk1PfRJw86SooY+BnoVtB5penFMUGSTPQl/+/yuzMYxHaQL3gD?=
 =?iso-8859-1?Q?UXRrfV44xrwqDxB2X465ra0lyvngipv5SCtJtzWWH9xwAGdffdjVIC8cAF?=
 =?iso-8859-1?Q?Ma1802rYaGjYkrX3YXBhUkjIqZjzKGJf04t2Oi94Uco+HUDDE1ZwRkT3da?=
 =?iso-8859-1?Q?BNldxob5yB+d/Yw5pWPkzbp8u5WxtRZuD7EiOSjAM5QpL3YrpdLWdvCa84?=
 =?iso-8859-1?Q?TJdFvKuxmZVjA3haDVk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64134d5e-5a50-4699-a6d3-08de0e5d5e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:31.3079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRzurvn01JqVxrww36WDqW5VhXjteLT401Ye4XRmnmCYXmHMBZPbUgDCjjmyu92cXwv6AkAhJu9i7NRa8MCzzP/p1FsmRpIPfCqIb6kqSgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 265 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 222efb12fb..2b308ec9b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_MIPS_CMGCR
     bool
=20
+config RISCV_MIPS_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 489f0f3319..32b878e035 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c=
'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..344f855847
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,265 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vps_running_mask |=3D BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &=3D ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE)=
 {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i =3D 0; i < CPC_MAX_VPS; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64
+                   " for num_vp =3D %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i =3D 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState,
+                       vps_start_running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..713455eb83
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,64 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    /* VPs running from restart mask */
+    uint64_t vps_start_running_mask;
+
+    MemoryRegion mr;
+    /* Indicates which VPs are in the run state mask */
+    uint64_t vps_running_mask;
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

