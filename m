Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411B51062871
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEG-0000A5-Dm; Wed, 11 Mar 2026 07:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IE2-0008KV-Je; Wed, 11 Mar 2026 07:59:44 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IE1-0004do-1J; Wed, 11 Mar 2026 07:59:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDlA4Yi2QdGIXSIcfQSejng9XVBfpwA2hKYiNMygXweQE/O4jSYvbHeWEpozsFCWR9yW3scSEHF49c+QcVveBSVUQIlBX2X2Xm0Y/mU88JJiAW6iUUSdIe5Ju9c/T7lBOnSChHAQ8NKmmoFVCr8eqq17u74Ha48Vt1Q2XgSZiT4omSMicdnQCGumN8rFUIBo+HcCG1PXDe5USiO61LholrJGK5mwTsL+hXkjQFyHWN+GO3tQy+9sVshacCuhLEl8yVBTMmT89/yS1ADKajtRX0fCid7OhOlw9yqmQ5lod6VN1Xv9wJcrADWTb6Uzl/rWqOfJcGMnUi/2H/xYgpQKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp37qVhDQvOQIyg8rWcE4hJ0+0mSB5Qlz5n81cggFMg=;
 b=q0bG5GNmRrkSrAMTwPocziic4QGmDbbcFz03YHq0AkdLDYZ3fxeHoFEHMzSG7Yy86dLKQaD1dxUAf5Ql2w2Kch7DF59NfLG8LBiWmDyt6eqXBuH5gFkiahKJDDyfS49snXQBZ0Ijl5WIuLk0DixyVGS+nbmTs2zahEnXx8+jxw8N0j1eMwoDRwmqTnH3YuECAn6c7iyQGj0rpJbH/jz8PMw7+2fuUhIE/MJHq5tvsmW44lEQYFi6GNL3UIw1KxcxUM30JtRZJKuJgArEx+dvU8ZNmvM18WWm11I5hBo2OZkFvm8SWa06ER30WHRB6tcspSr1Utz89mpErE9Uk6Prdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp37qVhDQvOQIyg8rWcE4hJ0+0mSB5Qlz5n81cggFMg=;
 b=QHEvXwHKi/L0Bf9w0pORj8uQJhrpr4/BJkk6oBNbxyc8IKyN3DZbe4x1QeE3jUVga2H6l+iZLKf4GxQTkKPqJBbqx1INMh2xaWGCFR0BpuyqkVbYu6Nt9TLJQ5dZtWyQXhcQHZOPSZD7qVgoZuV/jAq4qa3yhdkrAl6VtuGQFFXEIO8ly1+EWp9IPQyC4aFKrQZ6adL4+2v030SBOcXlV6+TAWaMe5PIxiwJKDVNFkT4vwmYJnDeKtz7AOzsbh1tftByieT7+FvykuyRdpgn7cty6MNUPLR0Vq0hMqVmPjw/CIH6n6+1Zt6Xf0fOxNmN+9ar4aqoSVdYD0YDllrwWQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:20 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 8/9] system/memory: Fix subpage endianness for big-endian
 targets
Thread-Topic: [PATCH v3 8/9] system/memory: Fix subpage endianness for
 big-endian targets
Thread-Index: AQHcsU5+NOPqL4wxGE+KphpT7sKvvA==
Date: Wed, 11 Mar 2026 11:59:19 +0000
Message-ID: <20260311115910.564481-9-djordje.todorovic@htecgroup.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6069:EE_
x-ms-office365-filtering-correlation-id: 308d66b9-0b89-462b-111b-08de7f65a147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: kaFq3r9D7mS6V1yKVOgZTA2G4csGRg+jSOeOewKNKepT95WAABL+cZEzKvNqc46YocGk5MQcoChW5QsbGCM5CamPiW4nQLUCnLD2Aa64UbQ+Q3pwKUDcYvp4UuUzHIjBvJJpZ/V0k+zocA7H+yshInroQYAozzwjnxc46sf3wV1c3aDHJa7NuaVzkOmXC/eoqkfySgz5w/LAHrWXVOSjjMg0pqwAobbu6PhHvgS80g9EjRuRGJoOYJDn7JNJQ1R1lINpaudbO3nWvrbiR0DqAEbsEApu7qERRej6N6nMbr9y42BNl/R3RzgDXbEVK6TsnHhkLidKXEfiVqfkxcmONnEAB3aFWmssq2JEfjbCYvPA6A3wCMyqGnCT6ykK+TyAtWw7JHgfXKgZwr28phb3MKeJdhCqYsxKrYuaAnNH46LLNrj+yuECTq5Bt8oyd6dhsgKTUAT4oQ+BKDHqXbdnoEXT+/Fg1UJgOVTz8IJBwzQ9+KiElzgOgUfB2jnikTlpyrNeO8faRZcWD9upRyiLIivFRs+Drh+yByEiS1omKmuWHaDpLz6M0StiR68KxRWGd6E+92pGm5UE3dEyGwoPfyny3hcQHR8InVl2poDbAR+aHaF9VTjmkrnODZUQtXS7EnA746wayH5C6SnssLnES9VUcx+gMsOny16qNa575fG0d10H0TIPgdp7UCAfc0t4Vkoz3qdtw1uUajN+d3OmywBH5AXjNZ+NVg0CGpyFGRQKSW8cVGhmiZHLVqYcmwLSgT28LxxXL2aKK9E0s5vNzwnOaPsGufDnKn39XccxvoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bP7QNdzePRin+PXVVCbvq3KB1j82JJ81GaHVNRU4QjjOVO6ugOETCW8mCE?=
 =?iso-8859-1?Q?U5DIJmDnGuiO4rCtTgWa2oBDRsc2zYRMnZ1/nB2M3pmU5vzcZBkYXd+cns?=
 =?iso-8859-1?Q?MtCTYCsEZ+BU0sFq7e0ViRzzqfPjVDnznXGe5+cXG1dvdo8+5AY0J7CNsi?=
 =?iso-8859-1?Q?vlq5maGlHNYkfyPtTjsofzEnPvDi7DUE972c3Rs4f8xUtfh0FZkQFyKtpy?=
 =?iso-8859-1?Q?je0Y68sFDgJOy9/7iG6EGYAXc3OD+WEGp2VqJ3MAEQ4sLcekczg8dsFnef?=
 =?iso-8859-1?Q?hr7ZMGqyuH2e8r6rXnXfhdwSs9VQ3xQDlvVqV55RxzrA9YIaW34Ts/c8UZ?=
 =?iso-8859-1?Q?TbYTqCNs4teLUnuTzyGlgMGgll8yTUCeFOKevkmDqU6n5AvTAdy26uodUI?=
 =?iso-8859-1?Q?wSH13/7yU8ZnttR6k+dcwyqzVxDKAuJweZbxtuAbaaCdqCGgO7giTVi6Ty?=
 =?iso-8859-1?Q?la908nsoVR4+6dW6VgO/shOLBj6g1HBkz0ZC27QFWyXdeEK1an68j++ila?=
 =?iso-8859-1?Q?V65K3UJW9ZZgtXW8bZZkbqnQiIwfww1NomiQZ/LsNVL9WP185GRjCzV0yp?=
 =?iso-8859-1?Q?s9RugZaTTYgNd8u0DAjwEXSsSUAE3mZugCRWsWMQ8h929wijpoXTbf08V9?=
 =?iso-8859-1?Q?6DBfYeyF7hNmX97adH4WhvjxesF1uVsXktmjflrH5AnWZpW5A155cort+x?=
 =?iso-8859-1?Q?DUmf3S74kNpnBMC/SrRG6BpLhwJcAuWfGTuixoNLaj6g3iBduXvEpcrXXR?=
 =?iso-8859-1?Q?FxicI8Ydlk2d4eAzthrzPgc0G++fI0MAG+HdPpRE+K9nzMAFi0xIzdGr5U?=
 =?iso-8859-1?Q?tzNDstmBaV2qSBxVhU2pARqwhvekVyObd9dO9hBYhCyNKMZndNAp4LL4Fm?=
 =?iso-8859-1?Q?xxiKafZ7hDhj8+d+TM3oyarY8ef7SfOzDlj1ydf82aBhGm7kRik/R3YKGk?=
 =?iso-8859-1?Q?gfcXhGJLxy+f/j7MEpbvofMidGurBBaBkG0HhBoCEFE7F8Sn0vo28PvQgq?=
 =?iso-8859-1?Q?SyvhRqOsnJFvrvi3uE8Ef6/HVibkAZmJF1Me5VffRA/nd+ptBhhjHL06pR?=
 =?iso-8859-1?Q?3Sv62o1NI1U9mjZLkrV/3MeiI4OS/nVDI6xdW4JpYb6XOupJnZAk/ilFPf?=
 =?iso-8859-1?Q?J+LQDCgbYZPfcN5qiIt+/HZCJoi8c7xtM5a5xrRtscRrGCK+Z8MajS82JI?=
 =?iso-8859-1?Q?X5Xvjrhw8yWuoN7SZXWRAT1H150qhC1Uj/NCkwJ0t6uCG1s38pqBcvBDxe?=
 =?iso-8859-1?Q?enqhv6Siqx7xwIADJiVLd9OcuHcpcYpNzI2/gGrXAMNWhn1OjGKZFcYRiF?=
 =?iso-8859-1?Q?a0+mIE1dNhkDBVN7Bj2ZZkdO1pxDdgfvQiZSE6FtByJ9i3PsWYQkPQ3vob?=
 =?iso-8859-1?Q?inI270VHIetXnqa/BSZHgqF2p5GPD6ezdVWvaEOvVDgTfp6Zq+tCmPZCIr?=
 =?iso-8859-1?Q?ee0UbPd3px/jHL14RZRQJI2jnxN8UW2I7JUcYcOu5N7UULdHAa9W6nwxK1?=
 =?iso-8859-1?Q?3CbxcaKZxSc2XaU/mZEi8FD2mKR74l+klVL8mhcySjJ2hybo5NhjHzbfdT?=
 =?iso-8859-1?Q?zIND7QhbBnRFlOjNf+dU9hBryaYrs/t9ASkEud5T5KU2/AUZGy4fmNijY5?=
 =?iso-8859-1?Q?pvziaRcVmBLk8iAtXa6UNF36ZBEG5EbwUWI/Uhhh7z6dEJ4j7Ixcraph1R?=
 =?iso-8859-1?Q?9PPLYSeNw3vvlk+mB+0YzLIaU02YTwP++QjNkbQaALdp6ShGWrMzSqnj1n?=
 =?iso-8859-1?Q?BjLWU4GfhpjVHUt0H1bgSk9L9vt5lYXLIYkYiGB023E2+iTZx3acgDNSHZ?=
 =?iso-8859-1?Q?fVTpgZPmQvmJuWJyeO2UZKqKf41YeNL/V9tcnd2fZq/9bIR5aJww?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308d66b9-0b89-462b-111b-08de7f65a147
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:19.9340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3ZE6jMwVSw7z4RBuo09HJGDTMNb2Rp1WCVN2yHUu50XOHMclIDFDu+wscaIT9j8o6ahiYiTvRkISvdw59d+50Y8p36eC6AdwfV5gGwShUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

The subpage memory region wrapper dispatches MMIO accesses through
flatview_read/write, which re-enters memory_region_dispatch_read/write
on the underlying device MR. The inner dispatch uses size_memop() which
strips endianness bits (effectively MO_LE), causing adjust_endianness to
apply a byte-swap for DEVICE_NATIVE_ENDIAN devices on big-endian targets.
The outer dispatch's adjust_endianness then sees matching endianness
(MO_BE =3D=3D devend_BE) and does nothing, leaving the data incorrectly swa=
pped.

Fix by changing subpage_ops from DEVICE_NATIVE_ENDIAN to DEVICE_LITTLE_ENDI=
AN.
This matches the implicit LE semantics of size_memop() used in the inner
dispatch, so the outer adjust_endianness correctly compensates with a
second swap, yielding the correct net result.

For little-endian targets, DEVICE_NATIVE_ENDIAN already equals LE, so
this change has zero behavioral impact.
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93..5d917482eb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2929,7 +2929,7 @@ static const MemoryRegionOps subpage_ops =3D {
     .valid.min_access_size =3D 1,
     .valid.max_access_size =3D 8,
     .valid.accepts =3D subpage_accepts,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
--=20
2.34.1

