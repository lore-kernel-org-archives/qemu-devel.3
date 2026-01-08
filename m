Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8934D185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqHJ-0003Ce-7t; Thu, 08 Jan 2026 08:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqHI-00034I-4B; Thu, 08 Jan 2026 08:42:16 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqHE-0005qf-As; Thu, 08 Jan 2026 08:42:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1qTHm5Ru/sQgnHG7pUuh5xw97XZXKuxV9mVrpB0fprh9meEBLQdwQkrEU5xJdNrjI/gTkbRLXYy2Lntv876StOjk5e42YlGGoF4uezzoBJcCSrGzDsevMCn46qVfzP+S76MwcSO4HCZb4TtJA28xgxI2DhBtBrx3QRHLDttdTSuA+8sEkPQwkuxp3mk7cnIFh8tYBY7xNlz7fiPmmAsIohZX5iE75ujFaNxEwEVdSP94gCk6/cs6Be/NJiXq0bYyw2jLbMYhM1sCqVw30Ac0bsMWKN8rJ4lW7uTKfeiIGEbx/3BL9pUbnQqVnzY//cZ13L7sPUodh56liPgPGJIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE3+NKy0APkAID7+4k3ccrzlzMukSS4RW/9+sasbrMI=;
 b=px9tVHqP15BVMZTHRENhg9pP0IBc8x8nUxv5NXWQ/CjbHuuYIY6RMdDDXp4U5DSKq+n9P2uObFurliC1a2uNrl8vR16uC8h2n3jR46Z12DJ8TAguXgDPrG/aFKErhD5/Q4ZGJb80cHv4lWvcjTvf8NVD5dw8vdUeXcwP/NOzJ9oQq0vWvGcQbNX3vXR9cZfWlJhs1R8qTmqFcCQroWGnKPmdzHebQICHNwhqz37PpBEIqqSNSd5B97yNjOj77T4U8FJJ111DpLM66X6pGYaQl5uvgP86HZDX2Nhbs8sSqK1MfiheN/EW0sMhBKbvLY9AHLDV2Iu3BVvCI+ETOjpZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE3+NKy0APkAID7+4k3ccrzlzMukSS4RW/9+sasbrMI=;
 b=MYuLY24kN8uPSX+KW60iqTKZrHh8ZwZgUuTc38jW8RvbEFn+mgD7E05TDmU17htH4m2iEYxCNJWv63ikZ711N8D+q9NXOueYRmqLE3aqsZCqNa3mmC3A/+v6fLCrTcOeW442862r6J9DmTpDVlEL+ge837FowTyyg1IuMrJd+I5RKH6+wQgW+YNkhWPMhjZsPTJgBP4+UTqEzNWfYlDdkT6elcaAAc4NkzNOf5sROH8U9h5mukAnfhC7hajcpBpVMP4TumHUppMq3Wm3I2tGSVYpRkQF3AFg8dh46IrZ0qFerVqEuNjKImSsnkHgM4yHYwc7Qm8I17orI4OE0ObN4w==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:41 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:41 +0000
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
Subject: [PATCH v16 12/12] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v16 12/12] test/functional: Add test for boston-aia board
Thread-Index: AQHcgKSEYI3ikCbNkU2zwSMj2a1QtA==
Date: Thu, 8 Jan 2026 13:41:40 +0000
Message-ID: <20260108134128.2218102-13-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: fd707bf6-6d49-4299-f69e-08de4ebba7d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LWv6jUs3ypWfqCBy6AT7Sfy8Ra67VSRSy0ij07JidmTrvcdGboAorgP+7s?=
 =?iso-8859-1?Q?oXyOK0cCOk1uNCxqgxsyesA5ZSJiOfALmf0A9VVZ8EOPhFPJvBPWTv5Caz?=
 =?iso-8859-1?Q?on8bcVBjcbYxb6qJW5PyP4lFFIO9J1LbC+jY66ms8xcP9BVQsBVFFbjYeQ?=
 =?iso-8859-1?Q?oaIHfpYfEj0iqG7WrvFYe36Og5rzafUz/Vld/VsNLHp1aSz2Zx0/KXn6na?=
 =?iso-8859-1?Q?CqRMs3BprVtmZ7ld9NvhPFWBLEIiRnYc/ZZik0ypGzmOJQgtwCnL8bwfBs?=
 =?iso-8859-1?Q?OKJYBZjLCpSxMVFtHLH5KduN1iRAJKzgilVuCseLklCrtM2ccAZUb9I0G/?=
 =?iso-8859-1?Q?7g7TTclXRhLAidMJBQxXceBomfjUmPvrxTNVyy/6aMosZpY1FFHJlLUIZP?=
 =?iso-8859-1?Q?3Jd9cVmoL2Fq4XRS0Q7tC4QKlk5kTKFLyU6acahbQ2JjCt0zzIIEKMFNcP?=
 =?iso-8859-1?Q?NqKRHej/HaDN2u4gGdL0eDwmDOgMDadDX+opH+VJmey+ULksUOFMLLn+F0?=
 =?iso-8859-1?Q?YKm70rI16WQa6ZaV/8R3Osx7mpWnCT5S/vDjC0d9dnDGjoRUferS7+Acv/?=
 =?iso-8859-1?Q?8eFouVw7NeqUE1chTOLosFiqohJxbbJJmvD8hE0fhGdGu/03ZKyqhKe7Fj?=
 =?iso-8859-1?Q?b5H/INIlxlrPXCkXTAYaicOQ2/d4DabLcM4chd5QlSBm3k2g2ZB2HIG4H/?=
 =?iso-8859-1?Q?TQkuW29EZMGWQKobMJZxQRFHMQv/7+ZoGj614uB1zopo9Rg51xzrzpQqxQ?=
 =?iso-8859-1?Q?OtuVx+qCYDERh5fO5YJ+jhMQDSyROqySY8h4jakp2/SaydVV36g/tO/GHc?=
 =?iso-8859-1?Q?2lO7SzCyvWrwUShHmHBRaFxHIe1T9JpqYw37H3WwPmu3+MMIvEibtNilvr?=
 =?iso-8859-1?Q?F/Ekszybyy6otsInBusvCN6LY3E4Lt/TRnnLyW5oCWlE46n5XTtE/UXiKQ?=
 =?iso-8859-1?Q?dgKemOOY++D7k0veF0PvV0qQ9YN/QcnZbIOyLmUU7W41IznWhkrRTAlqBh?=
 =?iso-8859-1?Q?JXiT72UsDb8yRxc6ks8gI7ksTndDY/b1oq8+28EaXSqQJ8fxv6UQtbhJuv?=
 =?iso-8859-1?Q?GVi3ILXaLM8iT06h+63oKav986aG39cNfoXI6SHoYMlL5ncT6kvmnAZ/8g?=
 =?iso-8859-1?Q?7056rM9a04rzm90oUKc4frBPh1b6uPZiCzh/d/Wp9eLyOTgwanECidNGlC?=
 =?iso-8859-1?Q?j/99vWqrJBwvRxYB+OiZVQKZcOVnvyYzjnkDuqS0cuJowreYvcDNuUdraZ?=
 =?iso-8859-1?Q?eJ4eT3NwipYLkKCS3wXF4YQrzkNEGvIcd4JhxzsB0aLt24+/nwwIgTc6Ii?=
 =?iso-8859-1?Q?PSx52LvPigf1MZ/nWbWsbGJkv+p+J2rV164uQIp/wvKaBIc8QsTEm/iDbp?=
 =?iso-8859-1?Q?gMO50B6NKFidaPLtQ7dxSW/2rGsH5t6Nb2zEWF1NUUtAOy7XB5lnzvbHwK?=
 =?iso-8859-1?Q?px286LRVIdjv76xknl4doh47+Lo6MEle6Cm8jpNscZm0MAcfkp3H0/rV+u?=
 =?iso-8859-1?Q?iS8oAmuUWF4oqWuHi6ShJJL9HRA7wsBbTmKhDhHDyL4ZdIXgOMZWJUJfjM?=
 =?iso-8859-1?Q?9r09A27uSXVHxzCFfDvkm7UZ4qYS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/QF/NVaa0wr19X8UI+FmchYEv/EL3nFRerjfMv+MCFvPhoeCzV37MNST3e?=
 =?iso-8859-1?Q?GfIELMwiLkusa5lCiH2ZvqEaiPkAKXSolfGHZerVOCojFFNnAE3LjAXIVp?=
 =?iso-8859-1?Q?IcJMmStV64EvreJLh80QZh2r0AAMCQC96XvgNYt+EWc7BCcyKeQC01NOlq?=
 =?iso-8859-1?Q?XuHSE//zEFWFWuMknxlQkKpTjw8BnpZ2iQZOTIcAf800y8SDBLl1KKIgex?=
 =?iso-8859-1?Q?SEOeCfTOEZuI/C2NYGahRBnlfWIzyptxx+A7VJj480A6IK71gOmMYwm6Sd?=
 =?iso-8859-1?Q?FVoogJ4/jwJePPGmjjOpJfmWJSSC9B+fIHB69jNjZtpwh4ojKr+Ha5cNxe?=
 =?iso-8859-1?Q?xUHP8BYSG40guz9nnId73FNRZ5fWcLrnzMi8iFFQ6SvLafgLJxGyGUoQZl?=
 =?iso-8859-1?Q?dRD6gyCHFbDPs+51VgWZz1aqnUtwBsGBTfuQ3tTrkyls97eQQF7BhOHkmM?=
 =?iso-8859-1?Q?uSNvY8ARHbDedCLXnVDG6M9+7t9DgglYfoSEOtH7ssBM12C/4pENh/ct8/?=
 =?iso-8859-1?Q?gLLQXqTE3smUcjHGjcAMN4Wy92QwYMlZMEi/Xqcq9oA91k48De/88TJoH6?=
 =?iso-8859-1?Q?77uLgUZ38bFrvaMURSgajr0ZPNeQkxv6iuvDAUQNtJMu/4JBWGE+SyhjSt?=
 =?iso-8859-1?Q?kl7T7MTzsZ0PnodP5M4ZeQeh98BONqbzTcsDs2nbkQZFMH3NuC3QSJZj7a?=
 =?iso-8859-1?Q?GpE0pbH3zOoEKoiscnM/3LNI+Kz/nweGd8OT6IBulRvw6vk2X2FA8fEK7T?=
 =?iso-8859-1?Q?1fTdVZE+KnYmOwcEp/C4SWd+br2SW9moMGvK1VWiYP3lJgWhJs/dpfgOn9?=
 =?iso-8859-1?Q?TdJoCrx43Yq8qQEeWa4hDoK7O0NrY/HImSj0ur+Jr3hDk/mH+eT3Qy0ACv?=
 =?iso-8859-1?Q?KdG3JKPMuSZxKwSEUkgMAyPsVdWBxizkrYK8YNYnx1HGrsd+QUQUJ0s7Mh?=
 =?iso-8859-1?Q?hs7KdgBCHaPUWS6U5Zt+d3Zket7MnPfqZFU8KLY6uQXp4H6/ei9aRPn2Ba?=
 =?iso-8859-1?Q?XMJRWR9BlTALhkXaaxHHBhLJ8zsPcuglWSc6izgsGl75oSTKTXkdORzQdc?=
 =?iso-8859-1?Q?K+zcWZ5Rn94rZb8u7hFfjRJEJLk01qJ8FBBxDhecr4hazeEhXyU5oMY0WX?=
 =?iso-8859-1?Q?VUY2nlihsydwgM+Odd/8Apo76HX5q/DWY6G7T9B/ULdFvu6fxHwLfuyOSg?=
 =?iso-8859-1?Q?wskHbWFEGHYvmGcUTSZEwoPxoKQ7Ak3jRmzoJ7TT0m5vCAUUbxgvYNzKw5?=
 =?iso-8859-1?Q?iy6mJSNtCFdreZKFt9BKi+4P4hCAl0DU/8HR/uGMf+/G/E60oN6VfCX6so?=
 =?iso-8859-1?Q?MU4Vvgq6QWMjAJOl04/VqQybuwDDhv1r6EQ2YOFJeN611WuM0Up4LHM8+3?=
 =?iso-8859-1?Q?Hpq9JF9mWC+3lXgCOQ5bjBaCWkAOd6OzckLSBvM4MgV3fcDqB7coCQHUdU?=
 =?iso-8859-1?Q?UnDDff4eWA3PbIyKw9W75VeC26np3re0j3Xce3jA1Tmp0EJgHPUFYXRdiW?=
 =?iso-8859-1?Q?54zaR6viTfatniEdWFLOrBO8XSYAUKxWCy3VC+Td8jik/IzSMmfw0/NNfI?=
 =?iso-8859-1?Q?bFDGBLM8WRFlL0NOPVA0V+tsh4AQNj2a68uCJinBrDvLpzLE2jU0mZvHYJ?=
 =?iso-8859-1?Q?2eieAc1phzLJqixkKCsBqOWH/S9/l1pFtCCXV3t4yYjFVbAhb4QN/P0hG5?=
 =?iso-8859-1?Q?D5wS1WW0ItOtCGMvQR8Qgwx9orlYJgA8kWBASxlCQVXWbLwU1lHtcEDlgn?=
 =?iso-8859-1?Q?fcwOYA97ER2vaPfALicnICz/RzGMcCQnDx2PiUtbzF11hoWQ0r+W/2Ri+d?=
 =?iso-8859-1?Q?RYi56DZwshgB38xLn9kv+zlvgZP4nyj8gF4ZnlMZnOtFjFfQ4WAz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd707bf6-6d49-4299-f69e-08de4ebba7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:40.6068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5T2jMs7ls5sDCsOPv3+ZJmyZMaNcHuRkJuljz+tw8gCkgHR/HLgGdAq3BPjcbq/tRdpVdu8ppuBCVDq1SjyivVKNwGi6jh8SIV6/cbrBxog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/riscv64/meson.build    |   2 +
 tests/functional/riscv64/test_boston.py | 123 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 tests/functional/riscv64/test_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..b996c89d7d 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
 test_riscv64_timeouts =3D {
+  'boston' : 120,
   'tuxrun' : 120,
 }
=20
@@ -10,6 +11,7 @@ tests_riscv64_system_quick =3D [
 ]
=20
 tests_riscv64_system_thorough =3D [
+  'boston',
   'sifive_u',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/ris=
cv64/test_boston.py
new file mode 100755
index 0000000000..385de6a61d
--- /dev/null
+++ b/tests/functional/riscv64/test_boston.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw,sna=
pshot=3Don')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=3D2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=3D7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=3D35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=3D64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw,snapshot=3Don',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

