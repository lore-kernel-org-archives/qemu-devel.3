Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1552106286B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IE0-0008H4-QR; Wed, 11 Mar 2026 07:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDp-0008E0-Ii; Wed, 11 Mar 2026 07:59:30 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDn-0004dz-BL; Wed, 11 Mar 2026 07:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq3xcA6gpFWh89FpERU5XNoTHhnphGt4m2gLYAm4ufefR+4vmn7caKKgX+L9YuxvHRmC0id6VMOP23U6TNtNKkhzMZ5GeIVCAaLqH+o74lQisl8yMk51QVmoAgKw02fAPx31MEpcsi+0ggUvdpHrLLuZ5Ipzd4DLVkdINIcdFR/CwS0+UKD+fcnplqviO+Bd33ShUomxpVPw16ISnmjeZxGa6OFJWjppc+qcSZJ53GTiPFdLxEAwpOPFsWCRZocKTQQn+GOnmVb6VglNOkrhLz1etHGW3BR0kWSIWdBagbbYPo4ugulbfgyaiY73zWUnY0RvfI9GuuGs1wpGZncUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NBWaBO6GHUWjWfO4FwPAN9bxG4mA7RE0n6gAautICY=;
 b=UfgTSypzlYROGvrTwOXq8ivwf2vGxae7q0mmFn82pzTcgOzkSNwD1jbGigm4uavbGHBdNAxOouHzVBg4G8VhioeL/ZrXthqYz8hy55h0U9gv8EXBsCGijbXGf4tcSJAWJ2VTlXhbbbWv7IzuPprCFS6OBTscvF+F66UflObw8S/lKlYyu8amq7VD4wQEGW8gi8T7RjStxyshtdi6DargSoaDlPQs+1DUm5lfrD/izzBh/jOpEmB8K1pv3lSCff3zdxB9shMhOu6LAEXyPJ1RsCNu7CJjBFofjXwxEAjM0wZ+7xDhOQ0Jc4wXnmveZWsbngA2PDhEu4VFnR/7+tuIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NBWaBO6GHUWjWfO4FwPAN9bxG4mA7RE0n6gAautICY=;
 b=PkTWoUSCwE3y44mDagDnPlPhKX0eNy+miZwoZW8+MFFJNwZDd5gShXQiEU4jej1z77gV9SffR0K6Dv+yFwL9NZ+h6tvIUzn849L7Dco8WDCEg174kmmNIP+uu1D0rSc4ZfVP9HJbSFO5RoLW9RIk01Uin1rJrDTajizGUUZN2/WizO9velbfEnTjoiLQz19YhHg/iICry2K0/YuV6WXw+ijjJEXlpvGIseOAhsDLqNPqo0YeBCduPa0Hg0r6+trNz8RsF3WORPFth8ILr9QX47UymKKRIRBqo1vhbHcgSONbjvE+zm1DVXAjXbZAOwsvmy08c7/1ZbuPoocSWKa0YA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GV4PR09MB8104.eurprd09.prod.outlook.com (2603:10a6:150:27e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:17 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 0/9] Add RISC-V big-endian target support
Thread-Topic: [PATCH v3 0/9] Add RISC-V big-endian target support
Thread-Index: AQHcsU58cRjCbjsaikytPPgbpanVMg==
Date: Wed, 11 Mar 2026 11:59:16 +0000
Message-ID: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GV4PR09MB8104:EE_
x-ms-office365-filtering-correlation-id: 47aea91e-3ac9-44d2-af99-08de7f659f0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: xoWioUuMVjSd4J3UjXkgIXhBQ1KpTvUYAbzn0OlPrzOJ695ztXZTHg9WDkx+4CT8tQCClw782uhZrJIDpOT6ySPioSPmvb7sDLfT9cl6UDrjJ7bBrygnC69JHssWhsQRH/bZqE3jBtQUsKuIAhjd6fYywp+EZC0FwhfDjo0sZZOYoYGlQZSHLRVvSMJ1fKLB59/05S0z0nEomqK/xq70jySRZAGuZz75XZ6t8YYeM0liVC4HEoa008hxwI4J8N3yGGTiLbqOJZpmX+wMFeSm59h89qEelARr0nxBy1uaATvMQW2bughvbUkc38d7wFEx+iDKf4s41VOQKL5c7Qn3V0qnYocbVEPQL3EvFd/QduqWnL4Frxcj/U6GowNd9Uj+cGfSYxsuhiQ/AIsZ6x5VRiFHsTUOeKpzWRZITmlwtG5EgQzBmTy6ViFXNdMl1oWdJjDZiIGlpg2vITRdpOHnRe829NbPUSXMna1PRH1cQd+VAZeXuBsZGijmLjFXE1gt+sW1w6Plysxj3UeKbqZSNQrbdZ53vLknTDiThp1Fkmzl6ihjKhaS9qPv4X1BaWZz9JH+rjmcqFUqA9TTh/7Qn3QGoKge4sGN/7oSQpyZH8MLjwRU/4mC76rrhwzEcDQAmYuWsHlCsPM/xg6ZxRa5jYs7P5x9n6iiy7U5/meztwbTlF0wkyiLg4IHX8SrVn5+RacyKHzG4nTOVSHWyube5pRcN+BfwGBkW1wBvSyDFZQuKoZjLe7NvwEi3AbSJL2qTJefgjNz8JEV+jfieYcDAKisC/DDdMhBMmtwhTWlciE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jn0nFzfO6Hi7m2ogbdnSEBWuMxZSeo3dzAcuOswVqRjft2gtfpHowT4x7t?=
 =?iso-8859-1?Q?AmJFxRmL3cUPUoChXt2EpUU+Tgkq3+e+1WHUqXMFtIOYw7TgGBx/WvtHZN?=
 =?iso-8859-1?Q?99b7MavKmR3RjV1vuLrpIAMTa5tqkVSve81dugfQDmpj6IlJSlxLbnJfKq?=
 =?iso-8859-1?Q?yy6PDDSWf8qs1zPbF/g9QHcZIkjrhiI9qtLNsvisFev1b8IEWv6vJS2C5I?=
 =?iso-8859-1?Q?XChASfKyXP/DQ38S1zMo28+rVpXZEkPBxgzWiUoCkzcGwXxpKxy3O/4Mw+?=
 =?iso-8859-1?Q?UlD8CtCaIXFq/iI4F1pCMO/ZUt0np6N2oztbdLmpybuJJBNjLo+oFAZBPT?=
 =?iso-8859-1?Q?3sTjkQvvRzL48+zwYM+Ix8XHIGq7J9ashht90+BqAXEXPMSlcKTrJk//3L?=
 =?iso-8859-1?Q?xO7P1TUVxlzD1+aGXZy7zmZjeCUPvvuvJap3sHXYJnsnqEg7ubm+gqfAwa?=
 =?iso-8859-1?Q?rvw1xYiQleVEeqSBPcuN84S/vbiq8V5QskdaOl0wQu1Nh+K5ccJTHK8e9N?=
 =?iso-8859-1?Q?6dyXlEQpHtonzvt4FRUD5cDyob3W6ymdW7Zd4F9aWXGWBE3UiyC45RF3Nd?=
 =?iso-8859-1?Q?4T7M9V6ge5aXAmEFFpHuPuML80CuNHREc+kvzlL55F8PGtf0/m5hM8iaPN?=
 =?iso-8859-1?Q?7HIkc/R8eQEB0YRbvFDr5lBYRQ+WMjZBEGXDzsSe2iWdV8pRAw+OgN8vqd?=
 =?iso-8859-1?Q?NgbD2KLWTn4rE+IzHfy7wAzIUI6zsZPKv8tRWncUUQQzz2Hi8bv3YO3WE4?=
 =?iso-8859-1?Q?DAFGs1b2wOHXJ5rr0jpvIFIS7Fr2MYeX6ZVNNnv84vEyXCdkzItjDwIs9N?=
 =?iso-8859-1?Q?z9uT9tVxXq0DUd9vc5yHfrNDR2pf7ATfJI68vt63MUBF24uuLbU1xjPx5/?=
 =?iso-8859-1?Q?zu8E+9thrfnUUBP/Zkt9BEbkxpzy3SHpstNesCEWn/Ni7Tfi61bEyW58Js?=
 =?iso-8859-1?Q?3AySnibigqIUnEGGDyeFCZhl9VCFD1qRh+DTyJBX81mRRPVhxbJKbaSih7?=
 =?iso-8859-1?Q?90Qk3pjr1U2kGxn367ZIMm+Kva0BKM5Rx5PnBtFIDREKhp/LxSa01Cp/Og?=
 =?iso-8859-1?Q?6rfnUFI3IKr6RHshT0aCzi4K0r+CST/9rccg3dknYerv4ANOoZqpPtRvbY?=
 =?iso-8859-1?Q?MwdK8nbXE934rEAx60BR63+yYZfvvrPd1dtT8cfsiJloCCsTO6Mgl8jZWt?=
 =?iso-8859-1?Q?8wni0Rls4kxoV0XJCKj+5fTLnLWS4AceV1zUyx8Iy8XSqkkCuIF6SqnKYX?=
 =?iso-8859-1?Q?VX8wTxEHjFdx1ZT/JydOTDO9Ti/jZtH9ULgHE1epJOy6URZ1nj445NoaTd?=
 =?iso-8859-1?Q?U7+aGWLAih/kiLUeVMnJDtGUQIO6qjJlbT2u1uXPzDzld/yZ+kVjnraHL0?=
 =?iso-8859-1?Q?jpjjnXmAGYhe7LpZ0FKrprLfrKlfD0ti+Y2im4kO4G4pLTW2Cms5FL/1oZ?=
 =?iso-8859-1?Q?zQKSUou3bzB+7pexfkfZYPZH1BBlhA+IvDqeUSHRFZw1N0XuIA/IwOCRQu?=
 =?iso-8859-1?Q?LnlxTJyjn5g8pRqrmhs9/6iP5LgS+UZlC8za13R0grgwmW2ElyvfrPTiei?=
 =?iso-8859-1?Q?zJ5JptffFF7Vqdba4vWkVdE/IHMx5/2Z4N2YNDt+w5z2f/Vwj0D9aeBmY/?=
 =?iso-8859-1?Q?6N5y4YPRz5IqeL1jsLbNeFkjuFSvbBuaWxyRo66tC53MbKKrJaG6VKuGxf?=
 =?iso-8859-1?Q?2lAwFlXaBk8cUbd8GtpYhC5FsV3F2xdIF9aR9fub/QUFlOZpvlwlkVjuP4?=
 =?iso-8859-1?Q?06dnxzFdMTtSN8QKduKu7jP5p+ttKSoPIFX0QQd0Akr3Ojmn3lh3lCPAlA?=
 =?iso-8859-1?Q?+xGHoXQGkqDGPNThW+T2md9GVXntA0niVb5UxuGEcgavC+Ca2KFs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aea91e-3ac9-44d2-af99-08de7f659f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:16.9804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgTCakEDQwA/6K2HTeR+31UfE2YeGaxUjdNdJ5TjoVcjtUcx6wpLV6Y920oOa7UUZIRqTeElJqZLsbtzIJaS80RbctNiiLm7PzsbgXtLE18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR09MB8104
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

- Address comments from reviewers
- Handle both endianness within signle binary
- Rebase on top of main branch

Djordje Todorovic (9):
  target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit masks
  target/riscv: Use MO_LE for instruction fetch
  target/riscv: Add big-endian CPU property
  target/riscv: Set endianness MSTATUS bits at CPU reset
  target/riscv: Implement runtime data endianness via MSTATUS bits
  hw/riscv: Make boot code endianness-aware at runtime
  target/riscv: Fix page table walk endianness for big-endian harts
  system/memory: Fix subpage endianness for big-endian targets
  hw/virtio: Support runtime endianness in virtio access helpers

 hw/riscv/boot.c                   | 68 +++++++++++++++++++++++++------
 include/hw/riscv/boot.h           |  2 +
 include/hw/virtio/virtio-access.h |  6 ++-
 include/qemu/target-info.h        |  9 ++++
 system/physmem.c                  |  2 +-
 target-info-stub.c                |  8 +++-
 target/riscv/cpu.c                | 16 +++++---
 target/riscv/cpu.h                | 24 +++++++++++
 target/riscv/cpu_bits.h           |  2 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/cpu_helper.c         | 26 +++++++++---
 target/riscv/op_helper.c          |  9 +---
 target/riscv/tcg/tcg-cpu.c        |  9 +++-
 target/riscv/translate.c          | 20 ++++-----
 14 files changed, 155 insertions(+), 47 deletions(-)

--=20
2.34.1

