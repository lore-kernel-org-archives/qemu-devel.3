Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB1CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EO-0003M6-Dz; Wed, 15 Oct 2025 09:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EJ-0003LL-TA; Wed, 15 Oct 2025 09:07:48 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E7-0000mp-0e; Wed, 15 Oct 2025 09:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4F2NATGwI+C1FIZoqcFWL6YknQMYs47KWdnD+zYz316FktUD8IgRn8/5dHGF3gY62C0gQ/VXYJW33fVVAr4H2DPA1bthRS/W29ORP9njriaoCu0ycbs6xZ6lLC+S2IyXsrhk/u2Hmi+aORAQkpHf+17X75AcwYP29CUbJp93acTqGzYOuox8C/Fjd7gOZj9lOm+3Ei5Ax/w8oS70YzrFBcur2+FxF0bdt4503HwwcO5vqNzalrilxoL134pZcyNsMGoIN9b/paW8Z8DjWzdTqDqUuf8fDeakaLXxL07jXY/SjWXKkGhZY5u5xoBcbCBWyvLfTXE4d23KtDcz85Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=X9mBQmBm5i1vOBnEKM7RMAZVmW2+C16XxilTl2uB0ulEz4jWH2Qg4T0RjhZELMLRXMtNce/a78+4zwl3IjnY3QXBYIglAsLF8smr3soETzHsVO+vMCaVHc8aWxLr+pao7sEUu7R2A9q5lCDEd7OiI5tCr0h/920Wh8KkzBL/9Q5JQmO6bR9zdpvQHpx3VVIqlBKktJPY7UF2ZayHQzepRLviD92LQfXdmSug/a8trkzxisACoUA8OjOwQQS9LWI0QhMrF8FeTUsXJMg7UqYAiidxCOkkWvKKSB9fO9XZ8XJ8Yclahpf3Ycnwrsg6ZTVv6O02tZcq/hW7XnS1M0m8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=PeMcPnmAN5ZlHqy/3COXno9Xmd5I1M5GGxT/L89u048P4jqUlJKeCfl1iGAEyptSCcqBoZEWSBC1AhrOAzpK0RLs9q78jXu/a6z/2kC5/6bD4uD5MsgMmLPRqX48I0wCGEg/NpcQmZx7YaLtMCW7u59elAqVqRB51KNamOaiovKgqG5orvMi1w9hwqu/uMnarETX6G7LD/WvhLgGH5xgfZtWdmy/4OzGnfhRCNa7TgbQ595ksJgk4nfFKc5hxPRBw6ZcA2oaXMCtu4XBxEKTyG9nI1h38JSFcAQHTXDPpuS+g1eKgHW/YQN2HYYoytKQXd8pcQJnvDtErWHIpFUupA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:05 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:04 +0000
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
Subject: [PATCH v12 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v12 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcPdSar7u4kHPRqEe0QiIph/dEWw==
Date: Wed, 15 Oct 2025 13:07:04 +0000
Message-ID: <20251015130657.571756-5-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 17eb14d1-c75e-4b8c-9f6a-08de0bebbcfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IbWH4pEOjws1mRvvBQl8rpHC+sfG2pe+4wce/9RX70lw+GBxhUN9AW8261?=
 =?iso-8859-1?Q?7Y6rQt08/UHtcSveKIVtXJZ1+T2Ft2m2F5lmUstn/zaqHGKBMhClvj0pEN?=
 =?iso-8859-1?Q?CzM5AbkXNSnEGTaRRYGsS1JpkMDKJH+RDp5QxIz7GwgDjvtE7MDAF5QePW?=
 =?iso-8859-1?Q?klmjAlxMTZN2EAjODXV/yKXbpOEX/F1WsWdARSaEW9qpu+odMVlkAHdczg?=
 =?iso-8859-1?Q?tDMX2BP3V4+KhykKkRhFmmvd8ULVcsruFOqBMLTpKQlKWmB+hDQ67Xl1Qn?=
 =?iso-8859-1?Q?quogdzdhGNYzqf+zjpF0RmaaY449RkjbZNOcjYpK5nmsF25gzdfXoZI5K4?=
 =?iso-8859-1?Q?CDNZUgG5u6N9X3y5CTDlriVAtcSrZDUOWeFSVy2+eskd/eLqfOm7lbCDHX?=
 =?iso-8859-1?Q?3Q2+rhIFGwjhzvhJO7SHkuGZXViE380hxScOj2nZLWcmk3EdzPqip8WXix?=
 =?iso-8859-1?Q?uBhtPudYvsdQNECIXZ5oMn1jgbSZZ0lnmbn/BEwp9S8kTxezkA8FuKWsAK?=
 =?iso-8859-1?Q?Kze+JAKEf775XvClIueVwpGA/iG88r/PENSPqjKX42u2saNTCrdbEi7ynS?=
 =?iso-8859-1?Q?JNH4fSZOViTglItF6zijK0IumwKM5KdIiRmfVvJukfXWoJcJ/3MSbXiiIH?=
 =?iso-8859-1?Q?QsJIcGXa0uy3gvP+//2CVpVk9aTlGAmhqtatUbJgTcFSRVOfvKmmshFe8C?=
 =?iso-8859-1?Q?AZNCf5IQDUu37qEf+QolkBRvKFRGGqvyQXQzwdXmyYdaMpgfnDWGXCyaOY?=
 =?iso-8859-1?Q?eEms4TeUuXxDOexcl2sgqWxIOl/041oBx96wL+MLKrMfsa8A7eMia18vzd?=
 =?iso-8859-1?Q?9vLC+L6o0/HuelITQU+ayynb2atzt5EcUwmlwM9Fuu9ICTVQ1Ulhw0BaSs?=
 =?iso-8859-1?Q?lFAiCAEb7RltdzaHzJiSMU8NRBwPqLlxc6e+S5NWdeLKOEfaP7n2T+KFfn?=
 =?iso-8859-1?Q?Mhk0SO176z0eqNKxIB0HBwo6mIL9vIztaA5zfdKbB8rD+/272GOYDyGITX?=
 =?iso-8859-1?Q?rwVq35C9V2qEIHTiMZR0ngnjEhhhKMjjAgbU9zOfFYm7N8q3ww3x5bupNd?=
 =?iso-8859-1?Q?6fGfFxD6prYGuc2K2Uj/FlV4bLTOLE3ZKdUvlM/60+/xx456ZBuosHfhFo?=
 =?iso-8859-1?Q?r4vV3lliCIvqUXALmAMAUb/4RLTgqIa4+G5sHIU1Jf4NHCSlb8rW/X2C2s?=
 =?iso-8859-1?Q?RaI2LqOmu0oFZ+lmawQx8qrXCH1sTVB8oSuepoOjZZeWKHELCT6vpe/DcC?=
 =?iso-8859-1?Q?8XABnfMFas7O84A50C9mawXAj4fzS9i3rgEddCOSq220euV9uH8oLNr+Zt?=
 =?iso-8859-1?Q?R71OShXnljrpId2XR+QtLrQGRGqiPtYKEvDxb46j8qQypryyxNKVY0xd5G?=
 =?iso-8859-1?Q?pmwAy/yPUFgzFmgbfcboD01/6HJTrGBiNf5pJORdpXX8h0y1B4XgY0lLZv?=
 =?iso-8859-1?Q?fkIEAmEEjbrL+X+QMcDMQOHpE6O3U+zD5i52KlLT1z5a8eONDM+6Ie5tVN?=
 =?iso-8859-1?Q?M8lgv39VwCKL3rduSzoHHwakXpp6NRP3AUE4073a+XO8xDfxXSSCH0trrg?=
 =?iso-8859-1?Q?gRzIiSqty32maUp1eWkvLLnLuIJX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V6QYOrZ1GdhIFHe6wYPvz8/lXWhv/vnQ/hUVH/glSOUyni+DJq7dXa1who?=
 =?iso-8859-1?Q?P7fgdtFTydqfZkGBnSxlLRzjdS5FESNsCbdu53bvqTMM2cq+ffC6KsGIuW?=
 =?iso-8859-1?Q?Z4XcuDw7uqXBVhYwJqGzM0LtRrDL105mcg8DjZqBmq5I3ujqISgwV7fz5p?=
 =?iso-8859-1?Q?4fzgMVwv/Md2D1M0oamcUrUS90ycvSTfKZ+JD2UkaIiLJGJHR59encCRB9?=
 =?iso-8859-1?Q?r/gO3M0DocQt4EPqmrgfw66tV+BtFEIZQ560uDJqw6cWFIsrXdj2Xkpw2A?=
 =?iso-8859-1?Q?mBC5ErLYJLvmScVdPr9VMK5U4hSsvn5rGJYMvYwZ1CgwIqK0K7A5G1L7aZ?=
 =?iso-8859-1?Q?CqLYuSEKsOObhbX4Kl4PhsGDOTASAl1mcBZ2M8q17x72UI/m7rInxOT4HK?=
 =?iso-8859-1?Q?PanP+XCzy/aJp+VRVQIcIKeS1PMvjofEVqdWr9SlIaLSzzSkm1qPiO0rgZ?=
 =?iso-8859-1?Q?mKjZXrK0CQz1Jreyu9xnUo891H3L/pTsSBCRXqfGwEVB4MGTMdbJ03ETir?=
 =?iso-8859-1?Q?YCgPKwRHpz6Alwfh/WOvfO6iVea/BMsCnrIyhgwbqqDKaf7ld76/89ZNZ/?=
 =?iso-8859-1?Q?Pomnx0JtQq3FXfeXioC3wWAhyVUmanV0JwXg41VbPb8nz+KVBkhcixRdhC?=
 =?iso-8859-1?Q?3U9CtnGMiLHXPaVtVPOHT3qEFEm+/0ccMyx1+BO+hgmLp8Cutr1AgjMlKu?=
 =?iso-8859-1?Q?esJrpQfDIPv/KkqHxK0+JQ/GZedr3iSgLjz/P+2ogJC7h+3AqtbiE4MkLB?=
 =?iso-8859-1?Q?sAGUSq1JZVnLM8tNNuV3DxDkjlwN9562WDSSCG4VNGY1gDpR3baF31IZy1?=
 =?iso-8859-1?Q?VR/V1/R0pYWNSRk1otkO5I/wW7Y3aM+djYjAGfUCxVSNI3mIQfSZ2TCY82?=
 =?iso-8859-1?Q?MT87Un7/pWrVPYR7zouN3iI0B9w2rqmriStruRRqlOjMLoJp9EMLedFBMg?=
 =?iso-8859-1?Q?faslK2C2Xr5J3CnJDtExcYlKzZ3VNKascTe0l2j/iPDuPCzmxhBD1UCH8d?=
 =?iso-8859-1?Q?jVswF69ODtlq40N6XM7M106XYEbC2bqAcxTl9ORAG5c8hwIK3tVf9+59Ag?=
 =?iso-8859-1?Q?2wP26FHkNlveDAy7qSYlOHEupl6Plfysv9dPOZNdqB42AcWPHaSdxfp+Gc?=
 =?iso-8859-1?Q?+yhJObuY8o/j0p81bBPVx9jJloxgpq8OaSedZawPfQDkdD+3Vo+HrYxZQP?=
 =?iso-8859-1?Q?5GZQBiRvyc97KqGMj4S7HXO75ZNfyH60/0Jl7eA90nb3/KNdtjwqpHdaev?=
 =?iso-8859-1?Q?aXk9sngqxZr37U5IxC32ZMxLBp9eAmBIv7uNaqcJs+qW/Qx5+3odBeQqEh?=
 =?iso-8859-1?Q?kO33K1xW7WDKBHYFnyUBKw0jmO9jDyGUkW8GbMDTauj9aDPLrScl+OuN1z?=
 =?iso-8859-1?Q?B7oXHmi5EPike1z40+icY7BKpZmgCrvYyz9uRO1bfGexP5aDm66sWYxMDB?=
 =?iso-8859-1?Q?vJXsIOmy98IzMaOCKya0CeJftch37b1P/SZnKo1I25L0ynKNrW63svBJJO?=
 =?iso-8859-1?Q?kSXsS3sWFkayu5IpSKDJ6rsc9gsekS+5Nutt+aQA7QyDbYNaHv1zj3Bago?=
 =?iso-8859-1?Q?NPGq4LM4zG2N9wznzmZb8ibi9I8v/IEQtN4TRE1uLphnf/kS8wFUc0i5HT?=
 =?iso-8859-1?Q?OS/v7+UqgmSgpnf1rDty4Ie3dx3WryH3PA+k3Ci6ZL/ZCIBxqczK9mdEFn?=
 =?iso-8859-1?Q?8sOsEKAn0SUJz5tNW6E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eb14d1-c75e-4b8c-9f6a-08de0bebbcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:04.6729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+AtVIt1v20LSpyWQ6QNTHdSr3tzM42ugY8yZYqyf6rGhd34v8fXt7caxh431zNolwoLn1Ur/3eC7FsL/fgIt4WU8VGhvWbx5hxhBNPUWQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cd4e442bdb..2fd0ced25f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3297,6 +3297,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34751bd414..234210c6b6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

