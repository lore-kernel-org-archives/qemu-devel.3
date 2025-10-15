Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A831CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90AC-00087m-Dq; Wed, 15 Oct 2025 07:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v90A8-00086i-C6; Wed, 15 Oct 2025 07:59:24 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909y-0007nx-Gf; Wed, 15 Oct 2025 07:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDnFrn747ReMDXjeX68I4jo3C9xyurrvB3eHNGb1/DKOU0LZd8nK2KjjAg36mLyY2kUP93vEhVt14ZPRzzKNK8qWf0TZobMc52XIzOrMakibToydgdpxIbzd6PEZIwzjg7HXFZPIpX1vTwzuHgfuYB7jlFrf6WoiKUNfhcunRonltofcwHYatEHQcF6Kxyye9TlOe3ELB0wf686cE3gRHIqHT1g+YQOg3M10Be64TsBwxFV8YeORhoLCZRKcIGZn/HQ/AgFJIaJqlthRcoOm+fnG4oMyY7p22YYe88eGNp5m6lneDE+vPjXBfDie1M7P09uUnFcn8tx/wBeYw8NigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=ZyTX/9YotHi4S/LVa+9WBOxkOnz5epL+839Cc5wB1LZpiOKnP6zwsXG7QXjLg6JsOIgWCAr0Nvj/ZouvwFVFAZg/tSDR2rfuDL+S9YA816IPxRFt01bsmy0Ym4O6AX/QWlhQorS7VPqKUgRK0xsW1UaMd63NBTbJJjLmA6+nkMFW6aFI1B70rh5n8OuY5lcswuQ/xzNZapZTWM2XwpaDN5kTzrRflgJ0b/FiQ7L2B1OkcKQKyyLb16LTdeVCkL1HfXCJL+3uAjNUtFHHxIi/VN5jMbw1+M0VN4mJbjEeP/VJM+bTDOZzFk2hXqzJWCuWYXYG3oT8UUe6kf9OFE/aOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=N4qDI/tT/SGxnH7kEintK3w2jOMpvYLcD9pNbW0yWfcxTqz5+oFWz0SCno7JYXjRbr+uRTXwuyGDxKFawLx3vA1uHQ3oiQiQGlT/hmaOstIhsN2IWBISvHYS4+AGgTTkPCP24jJ/PSfQBRz8SpIvHbb7bRoh5tLCHvXOCQvPHXAKRy7Z9k3QdthU1n9Hh7LOxmvmYyIPZ3y8S7rjWA6KAYOtmjGMLmwZpT2+6njKFbmzLs7gHh/WZZpgWYXCghnzJvFg6LO0VhTZXTeYikpQyJmRNwY3HLx/XqI0eDqPU/KN71Wq+2gq/4KCCgNVhgbwFO+Wm7Wwb+xQAzsZ+yXvHQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v11 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v11 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcPcr+n/E+KttZMUqUleYRgsb5ZQ==
Date: Wed, 15 Oct 2025 11:58:18 +0000
Message-ID: <20251015115743.487361-10-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 84bb71b4-75dd-4c07-75e5-08de0be22262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?T8paNsfTFUO7dNROfPXlIxzN4InovPTbBrcxNBJABx10g+otPMTN0PVwZc?=
 =?iso-8859-1?Q?4o79KEGmPMnuX7b3dWL0PK5byuvSmQ7l2S9ySFuuKZej9y9ShP6aun684a?=
 =?iso-8859-1?Q?s2teHnVn4yMPXPQrtRBI6nX5/m+504XkIEeI7HN6zSWQCNmB886D5+isO7?=
 =?iso-8859-1?Q?EbM4V+Wq4VMcYlwHu89kPer4+1DzzJTCLCNW5UWTWqk/WbUc0pcHGywRXx?=
 =?iso-8859-1?Q?IF5q8PdFcMdwHv5aSUjjY5DsId5uww0eImmGejNExKRrCDQ8HU14Ka46sz?=
 =?iso-8859-1?Q?hRUar97YXfEfvCKtB3Ot4FHnl7XCNiL3bCVXMTyfwcquknPb6tWikutqvM?=
 =?iso-8859-1?Q?onIC40t+5GFLeaqLVfJ1foegMIf75HKO5IcrdjF9LZN93HHv6+SkEArqKc?=
 =?iso-8859-1?Q?FXF36+huiHOaum3tOLsbmn7zakckdDotkw/6PdC7xCE5oyiaMQAfvP6xzM?=
 =?iso-8859-1?Q?IIaKjkA0fG6i8F3YgFd/yLkeO+yfDvif6Z5xhFSb39KqTVp7PTv2NBW7dl?=
 =?iso-8859-1?Q?GUUV+Jo7bx+K1pLSzSKuagVssn1oMqEoDiuTcasMoAXM/RZ53I0aMzZ+AW?=
 =?iso-8859-1?Q?NY5+5SEvus09npWH7/6ZxNVJFWSx3My0yLywyR6TsnrcxZWKiakGzCZnCY?=
 =?iso-8859-1?Q?Au12BiKZBeldqSKknSfzBp+VBMU1pZ5AE955f/IgPigwn0O2n45lK8NFrh?=
 =?iso-8859-1?Q?XGYI+aaCdniiyLxXZQ6zA2xa8ZM54EHHX/h06TPUVY32SQjmmGS04WCHdh?=
 =?iso-8859-1?Q?5jEWyk+VjDFDZyZfeqPptTIc0Tv47tHDHNhUXIqx0NMw0PFBOhAvny5psV?=
 =?iso-8859-1?Q?b5B67Drh7IkddxR8SuaXeSAyb1KvS3jHa9xSqpiFOI7ci3uEX7P3IjhlfX?=
 =?iso-8859-1?Q?A4cb6TO7tAYVmBNLCTHBHUpFsObif24UsTHllfkmp3ZlLpeUjmnJHtSs/v?=
 =?iso-8859-1?Q?oh/XN78elTZGDBOWUQuFl+6EbkyPvVco815qxAWZ/d+3U+IzVcvr4SO3ch?=
 =?iso-8859-1?Q?1GBDOqEwojipk5jXMDpvw2MHwUenlncc/hUrxjNqcpzsHelhgCUkCktAi2?=
 =?iso-8859-1?Q?Jbge1sqlGSX412tiAYWWX3Cvlo1hmA0hD0tktk3QT0WZTUhIkpDrpqSlhn?=
 =?iso-8859-1?Q?cMYjLd9FQPMghDG2YNVOODUvUzn693GOdPbJLwL03DvNR/JyKtoBTkPeXg?=
 =?iso-8859-1?Q?lQefWwG+i6fxlx9Neh9jHjkEKkfOBYcrUCnJgEqOPGp7UHRzBb9yP29VhH?=
 =?iso-8859-1?Q?X8MSlCYzdY8XJ4PTZfyL+b/HLWMX5Sbyfj6+4+NsrjSryrc9UACNcPvzuv?=
 =?iso-8859-1?Q?AusCErbunAB0rLjC2EDSAw93etOEbSsvfoq0MABhCq8Ci60B0Q/I9y5BZ1?=
 =?iso-8859-1?Q?GjZOoSTFKMhzvb0fSn54crwlBdkqJStUQUnMXWV66naQiI/ITLmh1Rl5E+?=
 =?iso-8859-1?Q?gAK1gG9kuVjnDnybyIe0Gx45aYXLnrxM6Pu5gi7eUjBsFzrQddGmgrQwWp?=
 =?iso-8859-1?Q?m/I4ODqnzBmzCgpnKn/PkBZdn4H6F75k9JBrEUUg4wdHYcpWVKbMrzMWGj?=
 =?iso-8859-1?Q?NWVToZanKQOe6V8xJymnMqTzeTm/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K4r7ZBnKG1hoHR899OmLW3yLKQOXWVQGnFLw5tU/ms95bQTL63cVU+9Y9O?=
 =?iso-8859-1?Q?TKYJNwfoGL/thBN/YjJsP9Xrr5IUACeH1rxt6HuwOSD3oszz8Y3mgFpD0P?=
 =?iso-8859-1?Q?vrHeqgu4T8UIBsTbFIKBkIfFx4acESLuioRPLhqgJqhqvVc8ngnHA3gGYl?=
 =?iso-8859-1?Q?URj43QhJoZ/jGDatR/GuIincWWIe1Bigvdy8+5W0K1sPDiztfBlH+HrB53?=
 =?iso-8859-1?Q?Ewfxsz7qiYTbF/l6Y28Yh3G8xA3zbhuja8k075mhtGXJbg7PVpuohPgu2X?=
 =?iso-8859-1?Q?u9fo+ndh6vNpJ1cCKeaJhT/NQWBg8mR92gJ9yYfBk+oC2I8PfpVjQnDct/?=
 =?iso-8859-1?Q?/lZv3VGoZUf21/nnPzhFLlbSyXnbdA2B+9N4U36g57mTPTvwm52wb1KKO+?=
 =?iso-8859-1?Q?XzgEH1kt/56bBB/4LogxHctX07s/PWBvVWHZe/gZYD3oYh5g79bOQ0kEri?=
 =?iso-8859-1?Q?nncaSdknUrk9KpstmXJkbXBAYlBY5HOaiVo4+/S53M5H5VeaLPKBuY9bPB?=
 =?iso-8859-1?Q?rRSdCuO8rpiCutSLDWZySjWwcFV9xi2VyOrKv92Urnn8nsCgtIP5Xd+rRy?=
 =?iso-8859-1?Q?0E7N7ULwE4PvylS6CybxqBVFZeki3ZLsr30oMjo7ZiEQUiHZy+akKwTn4M?=
 =?iso-8859-1?Q?/NwvBMoAkrTWTQ25gMW2uqCd7rU6YRwmeZVWxjaN1aRGMKWW57nvRygWOi?=
 =?iso-8859-1?Q?a6U5ICMD7I9j+aJUZT0FZEnu3ZwZPrx2cE4Cfa7bcTeODU9W+xMatvP/Kz?=
 =?iso-8859-1?Q?IhPFENa+sAkIm1p/AKQp5UI6dDwgDvXyDiKbt7BgsrQHtxCChCKhFzLegq?=
 =?iso-8859-1?Q?R+3811OJ0EJs+4BQHBYJTxFRQZrmJVrLOsBEE0Cg1h7wBByDBdOD4xLVYS?=
 =?iso-8859-1?Q?1NTLgYFVWzJtNv2RCBvcMIDaxFTo0eA50UsUHpz1GFyVhSGyUgrVVlNOUJ?=
 =?iso-8859-1?Q?JkyFf1n9CrD/A/8N0ZrYhnrGu/Xmv7BfwkeTY2R9dE+pgplnYJOk+jERLH?=
 =?iso-8859-1?Q?LG8LdDwgOd8rAQTbMfxg7AUrWcf1nVKUEt0TGMhTeJiJuIV3cQaWgk7+bl?=
 =?iso-8859-1?Q?p//aIbMa+oWhF+Eu1mgbD8eTZkJMEOoSl2Rb7kHIpvd/CYEE5XuQ/OQsRn?=
 =?iso-8859-1?Q?1cJpgFq1aWTXI6vrrOdISyrhvVDsO+/UVv1t+rVfcYy8h7gOUHHOCqWC77?=
 =?iso-8859-1?Q?l7uOw11R5JYo7Z0tHIdhTa56zC5j8tvHsd7FX/eZr5UtUi0kkft6ahSIii?=
 =?iso-8859-1?Q?BNyzXzsDwye065jyDQELkPjZ/mHj3zy2MyCiHsiy2SichGueVn+JZIwHjt?=
 =?iso-8859-1?Q?Gy83Q3RNWC5gKdtSX4d6Xw4tOP9mMTUOMxFQxAiqqgJBKkwyVfUrYPh/Bp?=
 =?iso-8859-1?Q?+iQ0i0/SBzOHxRsjVrCAU1qL1H978y4MBoxaH/cj7oTVzsMjSBwHFYR668?=
 =?iso-8859-1?Q?JEcvj4N+RGA0B/hpX4r4yOXNZCbYYhzTWkLJPIb7s/Qqy8xpPCjhbBrgZu?=
 =?iso-8859-1?Q?Q9TeKsWZ39qn+QTnje8mt1REI8WL0sic7ojL8NUUGU/Hvu/7Ywj7uHAUmU?=
 =?iso-8859-1?Q?oN6rrYr2gdZSq8jwKHvs3qocdt2kmbydv4oBbn8RbdhVM+ZtYc+G15dtL1?=
 =?iso-8859-1?Q?5eNWXmj3A+PprydT6YieeXrOXqVJDl5i1yhwwVIQ37PBHkC21qgGWMZd0Q?=
 =?iso-8859-1?Q?OdrOwsuvP1XXHwAl+4s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb71b4-75dd-4c07-75e5-08de0be22262
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:18.2099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URtV6dMrkS24067IYTv7vtzEkLnOfXi/7L4VvwgfqPsl1VZ7h8++N+EqoHgbvZIMmeN8t+gw1ZrlKrNyv2Cg5tGRJ+sOmyQLMNzGAZbbyFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
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

