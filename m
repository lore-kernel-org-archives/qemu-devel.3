Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F31098796
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQY-0002t4-PC; Fri, 20 Mar 2026 11:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQS-0002qx-6J; Fri, 20 Mar 2026 11:06:13 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQQ-0002Q3-Pf; Fri, 20 Mar 2026 11:06:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZlYBzs5G625Ll0bn9zJIQ3QF3WPxb9/y1GeV5DsLrSGy2Jjow86tcnavWr2dd9U/xFZxX3Plo0SrSVlJAnN/7IcgWJGcQtRBpNYvIWR2nopZ+AMT4VKTkbcLGHKmDn3QUmNNRjGvbJCXdg3kNLre7dWCYnoMMVl1BTCnr4WyvgootRryTD8NKGiuhD0iGEgCVMh/kqQsUZWvHC7jE9czLb9VajGELU9EJopf0vfbDUg9yLfr0B+PEVoF4nfq3ImX14l7r0arQ2VwmWdmblwPG96n/95KUvh15vJhYlh0E6Hhnh2f5erqa/pIIWPZzCJJf63o1ODuArMs8WxHio8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecCfSg8uDGE4ujf8sKSBImdcxzfMnPxIU4Dlw7Q9APE=;
 b=fBC/x7ICq+5t6NDL6P5AKf+C0lYci5ErfZt8hZopHV1nKDw/nl/V5s7sWV9W8MA1cNz4fKtMNJX3vnEitRfpEPti+t2zQ8/sBcHA7FJBGRf7zCId77plT/8reDjKz/AbMP/9v5elRP6u8CK18p6cQXoHaxq2S2wkpZyk4Jeqfsr1sVBxC91rGgpGNucNyA2G0jfVgDVW+HQaxk33ajeVIMP+6gwrpYuELGBSXryxo2GAg1t7sgNWDoQBxWldA7E0rGgeKd8eGrJvhv28ZgLVx0wylCXgRcY5It0zD02zs8CkR1l+yKgyCxnzBjLGkyeM1uI0qznkLGkFg2TZVXAYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecCfSg8uDGE4ujf8sKSBImdcxzfMnPxIU4Dlw7Q9APE=;
 b=dx9x4NmR4PLTBP0C2wz8YLx2Nk6PwOY6sL235tSOTPP/nd6cHb95lELvEkDgGLSp8e1GRHyyDrUjytEhk4zQLbuduLUVXdaA/YI4zGQ9616RBkovzGeUzoHhg5zAg+h5/jTod+lVp4xTFNhNAJyENXNE8Okvc/GtKjy8v+ROs5CUUGu6WEEBDg+QUQx2yQ3wZQFTG3IqqdkGV+6fAKZ4rs6k+oKzCcMP5tfj3jHJtJa3hHQb9nbHybLzDeyCc/3mcNk6VOZuIDKQEL7M4246LtEF2AqUVC5HyNBm4qIsZ6ei/wZuRuUVm23WakKO37MYOfekMLwiH5ED4IK4iLahNA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:06:00 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:06:00 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 3/7] target/riscv: Set endianness MSTATUS bits at CPU reset
Thread-Topic: [PATCH v4 3/7] target/riscv: Set endianness MSTATUS bits at CPU
 reset
Thread-Index: AQHcuHsPNGAOt5LLwU2Y4KNNqM1iUQ==
Date: Fri, 20 Mar 2026 15:05:59 +0000
Message-ID: <20260320150552.169480-4-djordje.todorovic@htecgroup.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA2PR09MB7446:EE_
x-ms-office365-filtering-correlation-id: 81238d70-9435-4c00-513d-08de86923244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: KIltGAR0+9E5lqgLI2VGF8/GAQCfDP3OVq6ACgYehWjy07Qs/IrUC0C+nIw7Cby9rEsxan/Pqud3ZKk1aL1oZjGsUxwd2I2Sex98j4jFf09lA9p30ZffqSwtR7/NJMO5JGg0cuGZ6K/mJH4Vvy+L2PuJFdP6IOcocEDGhae22loJnrVWWeknVlgITDKDKrG/Jb/t3Pa4Mcu7uLGMpQqbxcvaZpBEVh2zkNPehg1j3yCvOgMzJPCVG/1a34vKR2SYB61/JSGgmYZYDNloHwcykVOHLtVXf12DijiNdTVBV7icxn95q59uL6WV+/HuYNNjabP2ioHhyau2CDSLffjw+sXNh1xlaTbQ5YNPbmfO3IrOJI4tYhDYRdaOmujabevuQU7XdYdEgHuUrWAm4xRFFauKQuYxsULqYpBNX3CK5kV4O9tyd3ikmjMK/RC/zR/s3PfAskiY6MY8UWTyLJp2xVRiKzkacc5+Mp09bo9Z2d2InGviZAsM4YTSmbw2KIjWaIQuXWMNGGN/14ngfh+F9ES6xiaj7zw6437r4OblYczWY/cvqUY21ke9N0O8bb5sDxbH7Uc8iq/bqRIv/XtI00pLHoZtV8mHtVslKRhw2Zp8e1hN2Cjn7vmuXiMrDzAC9lOTsY/rhJ3oJaEi1yO7tF3RH1wbO1+aiZHozgByJXwFnc/72AAdv8ZiR9sLRfiWfMSgAHEWpGBv+Xluwhvx8iwdm45VsaAUxl9k25yfYo/1OeXQAyZhFoG813as7uQccIlzWqStyDUpv9i19lgnjZ51YcBgggjNldqbPs1YGkA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8x875sV6iRYqP4c8OpgfsJ0C2Gckbo+OLepKfNcMDc6ptlSHGSp5FhtWPW?=
 =?iso-8859-1?Q?wZeRUdUob9HZg2NgVlapS7rwumPYqJG6szMVInutjCptY30yNlgp+MWBdN?=
 =?iso-8859-1?Q?kPeEOl17J4rUIbIcT9QdRm9sYd4DFsPIUz6Udn9suXwDrdUNI/p2KkR+I0?=
 =?iso-8859-1?Q?Ls9eaEcCewszezIxAr4maxpCeAZSPg6IH+uoEph90+A1YQw8W3q3+q/yxd?=
 =?iso-8859-1?Q?JSR4N/7b3LDF7lsUEmx/Hh3mNML7TSPXc+ssqqQ4hCiz6iaYfwNKYv0myQ?=
 =?iso-8859-1?Q?mUu10MsmdwEFI8EEJj8e7bOZFeI2sNHnGTc3VsWKbrbBMVzaRR/+UEM8mH?=
 =?iso-8859-1?Q?Gjor+VZ3UVQUOBnG/3SeoPexjlJ2UbNOfAswz1592c9ddyeieoGQzt5yvB?=
 =?iso-8859-1?Q?mCQe3FL9TBP6ajWM9lj/JbzF0yrFSA/ATliuH0Dl2tuX3dpXiIsGKlIr21?=
 =?iso-8859-1?Q?lGYUbIVgUCQYwNyOEhFIMAmTdH7DX9QlvBYDdQrk9/qsLRMeRBS/IrTaJx?=
 =?iso-8859-1?Q?Ede77PTsG8H8LY3FfK3j6CALf/om2h3iRU1RmwUiiehGOMfpam1w8BuGiP?=
 =?iso-8859-1?Q?TXZm2YvQWLYD79dtJRlr/s59t7Jj0PwrYVJyHFP4qQhCnRH87D7A1x3i4X?=
 =?iso-8859-1?Q?LWAZnIn9TCW3UkDwwZMQ6PUhl/cs/Y513QicornzXc4PJvKVV2yRCRQU0A?=
 =?iso-8859-1?Q?LQCYAdTtwXticOzGu5CdMoSmOj4f4kfCpJitIkuKeHHsIAnfZM2L33wFq3?=
 =?iso-8859-1?Q?KKlDITcvQV0EcFAt3nZpwvR+ESuJcXATzG5kCMgPDezP0zAiQba4EmU8/E?=
 =?iso-8859-1?Q?BV7/07y1+rS4jg+Um0aRDQxwb1+qIAsamhKL0cmv7s4K9ItQMj9JrOclPu?=
 =?iso-8859-1?Q?kkJ2KeBWBbVs7Y9pJOyaG7bInLMqyh3kYpwRLDCBY+EUS/wpNNZnL8TBYq?=
 =?iso-8859-1?Q?KeoGr6NFzPtBNSDC3q9R50anm/L7YUwT4RrnCPzRkRdsHNMn+6MpsEFW6Q?=
 =?iso-8859-1?Q?6LqGThjIFfolH2Rb/01O/7FdE5VcX9Wn7t/pFizBqmoDmxcbvpLF/hhhy1?=
 =?iso-8859-1?Q?o1CPnfgq88yXPfB/bxTjIicA34Ko9ga3RpLwf7yNZATuP9C6ZXteXUBHIY?=
 =?iso-8859-1?Q?cK0/yK6QcISBpw+BJn3ivttHto993qzvblOWBd5O+UR9DPVPITf3mv45ch?=
 =?iso-8859-1?Q?n6+irRS94Ufe5bROi/xEL7EvT1o0bbGAxP9b0ZE82fiDkQK1IbVyjL4Kh7?=
 =?iso-8859-1?Q?yaAzoyOXxZrsfY6beV9eWBD3W3dWjnWcu4RzeRYAeSfZhfS4lWU/4yInSD?=
 =?iso-8859-1?Q?avuTitn5dMaOY469nTu3XFppuaCZCehNy5A5NlG5Ba7b/YNT1e71pQxGFY?=
 =?iso-8859-1?Q?9golSXvH+khZTujeJWgExtfM6xKvU5hmx3C6bzQGeceMB+7DlDjqzAUzrt?=
 =?iso-8859-1?Q?L0b/fhqnJkhI+CwLNnA1+QxD/RpGq9Cc+oaYIdlPDivthqIZpQvIyfKdtj?=
 =?iso-8859-1?Q?L31B1+f/5F9xCsXejVBJRnug8trl2/F4lveoWRVDrDVy0zMpsE0YqDPkSC?=
 =?iso-8859-1?Q?tJMx6yMc88xQWlxIBbciQt1VaUgOXVGvGCyZaw722YCio2mpQatd8MHKjr?=
 =?iso-8859-1?Q?4P2mY/kqOfq46wuB/R4b/XghA4YIL8fmJGyOqc+/4FGGOYVeySEXTmnCxz?=
 =?iso-8859-1?Q?9ZK6lieImDDN3EUztbEwIk81AHU/lIYOlakGdZ7wn/TQKwypFc7gxhzjmp?=
 =?iso-8859-1?Q?6dQwBkRWZS9ZATPh48Ak6F7i4t6+/NtoNV9hqbSDi8hLnKV/UCVlwbjfId?=
 =?iso-8859-1?Q?IqHyr0k3vXTNgpKHgkq6kj/6baW/uzv7eqPHAqSzOaZ5K/ndp7P2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81238d70-9435-4c00-513d-08de86923244
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:05:59.4219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbvzfqynW1kSjvO0B9hSGh5463vPJFb94NEcW41t8V9KVolUNpzHSTxHUiVZz3oQBvkFHNnrjRTGYocz8f1gmr2CETfRbPnnBOtSVHXNcOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7446
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

When the big-endian CPU property is enabled, set the MSTATUS_UBE
(User Big-Endian), MSTATUS_SBE (Supervisor Big-Endian), and
MSTATUS_MBE (Machine Big-Endian) bits during CPU reset.

This configures all privilege levels for big-endian data access,
matching the RISC-V privileged specification's endianness control
mechanism. Instructions remain little-endian regardless.

Also update the disassembler comment to clarify that
BFD_ENDIAN_LITTLE is correct because RISC-V instructions are
always little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4537305dfe..eed5afd27e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    if (cpu->cfg.big_endian) {
+        env->mstatus |=3D MSTATUS_UBE | MSTATUS_SBE | MSTATUS_MBE;
+    }
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
@@ -803,11 +806,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
, disassemble_info *info)
     info->target_info =3D &cpu->cfg;
=20
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian =3D BFD_ENDIAN_LITTLE;
=20
--=20
2.34.1

