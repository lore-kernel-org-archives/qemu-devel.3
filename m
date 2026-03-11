Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375951062870
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IE4-0008K3-FU; Wed, 11 Mar 2026 07:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDp-0008Dz-CP; Wed, 11 Mar 2026 07:59:30 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDm-0004do-92; Wed, 11 Mar 2026 07:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtIjzX+bJWBBkK1hNCUr/0C5+1b0SAS2jFrZ800irsPI5DqoJyT2NZ4YSMMjRYOdhmyoM1ytgqK5p3nFS/sT5nnuYyS4THtCYfpu/lQCybTB6DJVZ84EzZPEWINIqEI4fl3j5Vnqtg5xcce0dJuv1WLKQq0clG/cVLoWTVm0Hg0U5xo4jzZfq/DL/Ehxd8Enfa5+sYxGib9+tcrIZwskRC51vTENIOt5cYc9YvzGirOPI6PEjKxQcH5jmnEGWdAyCGsmwda5hmBVj1AT+x31iqM+fqXm1LtlnkAP2WLKCyHSt2FjO/WsRVx6ul9wXObfFA4JtarDh4dAfe3soxyMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NE+6VlmEEzsbxLpGg9YPgXRz7jZqbn3s/no2Lp9e/A=;
 b=mwKlrwDhZoNA/n3BoAat2+LOrA8fL0ydmkIKplDMBo3is9rRW/de552x8ciNGiSalEdP49hF4ZQbu7ge7ZzRmqI55BGgQpx6nxxEtpFsInrkFRx/VmXif3qHcffxh+EXLzwgWVCJPFweTS7o1gsNXCpVR+vro9TMtBaWQ+lYvVs+0GQL1Ae/5zPN0KRCo6iDWdUwZq2o7m5eHJWgLr8yEDw5t1kNyCKZxGPz/JECd1Rkp5bLKdWoB+SkwqOUHH+lFnfifPtsE+JXeGss6jiB0MHLpUzrqUxmBpZj3ZoxQR0XnnxZP6TiE2Vm2OZuSwbxKDUA85hFdXxm5MCVQLzYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NE+6VlmEEzsbxLpGg9YPgXRz7jZqbn3s/no2Lp9e/A=;
 b=cDRwCyVrtV6b5c2w9y8ydD2+/qwt6qei6CNLgnR/DS2tDSZmpJzhQsumFm2QO+J2fUGNQM9Rfbr1Z0OAkXWU7jwiHdpZI7zgnQYiA36UtlWZyadgRhjfnJpaP/yU8B+69BkulcBtEPbTxD1tdiEoXACU2z8LdXERzjxY6Yk7LHhpUlcthSyLhjugVRxarFChjIHLw+/d9Qji0P/iMbE2RFTr2Gp/c/ueGTzYcdd/bPTPJ/8CXDjdT5dRVDfh+RUhAUfySyAzYsD3njQOpcSc3/tg8F9mjEb3H1R+fu1lkMmH0+5ZW3LMKsGLR48J9A5wtR6voTyxgsVV/t4bh+Ldnw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:18 +0000
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
Subject: [PATCH v3 1/9] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v3 1/9] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHcsU58YzF/Y3qJ9kaE6DNKDVQxZg==
Date: Wed, 11 Mar 2026 11:59:17 +0000
Message-ID: <20260311115910.564481-2-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: b44d40e0-7b28-494f-d73a-08de7f659f89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: qMjTBk8jI42JpPzkGctf8dqWJVcdSEsJ6nDwvXrkVNnKgm+q+IgnFtf8SNJqLjlJGahNM4fHO3lbwyOHbOqFqzZ0aa1VPYodS/uK+EdykhI9j0wgZTbGWEtIniJSPXSycUu1z+j3ePJqpcrQ0tAUvLqwDhGpjzIM8vkG6zpf7mAaMrMYDiWuuabogFQahmSYBYfB1AXr0zN3ulq750Mekm1mOFnQkkxFNgQOm6dVFOUC9rRwEmgiRnypF/pgv5JPHoalenj6tefcFkMU4x2/FKeZ67bvmQApJiT78zICriN0BtXuotbk8iHNpozy9wrUrdFtfvI0x+w7cuDJeVy0mPKdDMMJ0Hb2/nXINGJ+Vb2oICeQ0zX01dH4Ple80oe9+iFbJPeChXcF+spkYywfcJ/H26UQcpPVHCrYC8jZS5hL8oX4cC7h50RxfKqhvbSO87Fu1PU4Vfj6pHIX4rMOLyqFg+bVlWdSnymnBKP5QxZ1Y9Jv1U0IG0qVwuYCJeMPyrkNWEJJbOajWY+ZRJLIjjPIljNvONxoiTxEwocf/1/dcUQ0z1c74V6UnJqP41CQJbLijbyxmkZgGBCx315pGfM800zm/xNcawCDcw5z+3pgArF9JyDBPYSi0hO5kNi4yHqov73cWq9pKvxFRd7zrfmQMHHRzVLsEqndiXjcr6eaYfKHxNQ13lzNPAqPHPS0B86hdeYEqRT3Sd+i1o+NL76/c6BgIQHKx/NRiV+XcGekUTpAs5p5oT1dko6SRzA1LaAt6jvQaoUYj71OD5vH7ncz4PS2MErSO82QoulXnuQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ORMhI++pkG0Jq9VC3sQ0COz7HuVSIS8fNkIjtEA+4wZk7tHl43/ts6qnAf?=
 =?iso-8859-1?Q?l30Fe4Mz5gNpORYyk6i136mYM/sIuqarO+aQeDNZ3Exo43Gq5+2SIuITA0?=
 =?iso-8859-1?Q?7O65AEHBv6uucriy/ir0P0hTbCk8VMdqaF58Q349UW0AXDxSBQ9qZvdBrX?=
 =?iso-8859-1?Q?FCkAUHLZOTw0C9m3WN7bXCezw1sPywgvM0jD3J/fTbC5mgwWVndmjDZJR+?=
 =?iso-8859-1?Q?SkfGT0RGNrh6v7YtNcBrlafGaQRq3nEH2+K2IybskpNzaCAJ/tH8Pa++F6?=
 =?iso-8859-1?Q?z4DwR59t1e563SwxNwdHxBe6vTVfdv1PqLPSYHkrA2/1TcEyARfK9KABLH?=
 =?iso-8859-1?Q?HKOgTOCh22pI3V/kxHmElBtCl9i4YDsD0QhjPpj6hiZYkr6986GIyjgIAn?=
 =?iso-8859-1?Q?iGuiBM6pTTfLdPaqHkxlJJ5FPyn6Vh7xEzkKHQWLbo8JPQ2yxnIhwKLxAV?=
 =?iso-8859-1?Q?3hvpYqdLYwLY2HOgyDZ1M/zMBMZazbd9rCRFIxTexPjipBqFHvVX45D9YZ?=
 =?iso-8859-1?Q?k+q59njwBlY9ZBpoAWrNjsqCS8qiY36bVK2GvaboH8jWclDBsWw4WyoAuQ?=
 =?iso-8859-1?Q?IEObPElrYZvzOrdbGhAzAwP1DOEkRIowuYks1+uFT3wwT7QrnrwzDIQozC?=
 =?iso-8859-1?Q?dbr1TIl9iRYPubf0eezoBnUR/fa/IAc2d+07uouUk5qKGevGYk2ezDYr2g?=
 =?iso-8859-1?Q?/tIc8wjZUIvTRjsZdrVEI6lxyBXvpjc3MKiwKih6ZsTZn++NJB28edOwoh?=
 =?iso-8859-1?Q?AM9gc3Vl5ux1n0WPp9EuPrke9SgOXfPrG5aDdj9I/8g6s9CpBzdJvgfC7+?=
 =?iso-8859-1?Q?YOdywvkJ1RbWYU4Lcekp5ajtyTfFYYkhmoCiNMEohx0yNxxYIXa+1QVCLM?=
 =?iso-8859-1?Q?nZ3ohhYiwNCJw57Bx5MZRl91HqlLttcH+6IyzqfogqrNPSQxtcD62N8nxd?=
 =?iso-8859-1?Q?N9aBsPeJ6nABE0ZXk7ABUGcfjVJOEMBgVKebqPgxPiedW29dLT2h8bUxgL?=
 =?iso-8859-1?Q?+oWkLl3uGqy0uX0gQ9H+I8T2yjYSqdQGfqAjEsPGopx/cl9bsVOOC/om3v?=
 =?iso-8859-1?Q?y+vNiX/CUhJPOv9qNlsN29vssMecQSpWAwh2w+0L+uxgYJ2CpGpMY9qtNf?=
 =?iso-8859-1?Q?I0Ws9VVtrf7XSJIdErslmi/hybSBQAs3lppb3xRkIwR7J7N7RuDO3Nlj3A?=
 =?iso-8859-1?Q?JhEdil0xk5dYFLbEkS/fbGwPiszpeFraA/CdrOOzcziapmYsN8fu7aG+NG?=
 =?iso-8859-1?Q?Wr0lafgZ9+7+x8IeoxXJA8pOKb2L5Cxli4uZ/cw2aalVQ0WvklKQqyYTUQ?=
 =?iso-8859-1?Q?m2+dnWflFY15LR9oErTHRamTMYhY1iIGtZ0HaLUfJKG6K7183NTRR+E5bG?=
 =?iso-8859-1?Q?bOw4e5GCvOKRnqIJvt2MmckmOZIUMj7Yoh80GhB5SAVhufV/eCruTOwwY2?=
 =?iso-8859-1?Q?QnNNi9wHpZTPi4pBEf76R8crPoClGpD4xUnuUrAPpfwEatiTtE0/58UARD?=
 =?iso-8859-1?Q?a1RjIQIHFgYcUC+lshVvTzfOfQTXQAaHojtA8d3YCiUfBPse8m9DXv4KzW?=
 =?iso-8859-1?Q?YOGznJjgn6w4e5+SiAwy/RcFmevlzVPPDvm+WIUgvEqFBIlH5uAtPlApDA?=
 =?iso-8859-1?Q?ugCNNNSXX5g7O8BotuVzjOTH1C2Mhy4W+vQZxDBWyOPROLZTl647gM+vP+?=
 =?iso-8859-1?Q?9z6piQjX2mAlgFW2Awf3xgqoP4F/r61THG6ib5sS3PEklkEWHCuQvQ1nZf?=
 =?iso-8859-1?Q?oniaCvvYAKEr8IdR78FFwe/wukwkQlRkcC9Q/T2/Ngmn1yYIDE9NVtKoBR?=
 =?iso-8859-1?Q?WdfNYMGhmcGn/ZC3vAaGC2rkzkii0ReZvcCXVIQC2URrJysyxbo/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44d40e0-7b28-494f-d73a-08de7f659f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:17.3620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ondpjEytZliwXl/AuGDx51Agf75UYdAdXFKGZISfd6Rn9H5p8stivAVajcq8COJKx98VBMCm7SzO016oF55jlye7vzQernZwqOfptxcQYHM=
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

Add the RISC-V privileged ISA defined bit positions for the Supervisor
Big-Endian (SBE, bit 36) and Machine Big-Endian (MBE, bit 37) fields
in the mstatus register. These are used alongside the existing
MSTATUS_UBE (bit 6) to control data endianness at each privilege level.

The MSTATUS_UBE definition was already present, but SBE and MBE were
missing.
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..c2a3ee4bf3 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -628,6 +628,8 @@
 #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
 #define MSTATUS_SPELP       0x00800000 /* zicfilp */
 #define MSTATUS_SDT         0x01000000
+#define MSTATUS_SBE         0x1000000000ULL
+#define MSTATUS_MBE         0x2000000000ULL
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
--=20
2.34.1

