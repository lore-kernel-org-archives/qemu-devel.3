Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCADBCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJP-0003mO-Lo; Fri, 03 Oct 2025 06:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJI-0003k8-J9; Fri, 03 Oct 2025 06:46:48 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJ5-0007P0-Dm; Fri, 03 Oct 2025 06:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSQlbna8TA/ETirIW6tkFCvI0t1H+gp2to2YjFYRWw0f1z+j23fnaAvF7N3tmMWXqVIN7j+rLiHRjvMDJeIVsVWHDNxbwh0mQOQ4qWIEEN7mh3c0F1Ieo53aJrJxteU93ywAgHS4PtLz0gW5OaedHClWMebrhOvYrfr2TxxznlCs5FIvYEgfWLX0b9Cpzgke9CJjRFABCmE6E2S0uO9jbF5Vi7tB4+6fuf68Yx9lQZFhfGPe6zbEdC8PLpBBMaa8BsUMKmFgEVNlFEtOHav4HcfnkHUZ46/IUM9PyZ/bRXXbCca8al88LvhyCRXis/fYZsyPbYg5z4dFRQX/ov+QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db0lls8Qg746k8cnatLCbWq9TxosqHWZj2uUkyGjNig=;
 b=HkF2Fxf2Xdo7z0UNusUzaZaaUkC3cWnn7/yBzXM3hm3Xffzlg43kSuJT+pA5QJEaZwA6rRHDZDl0X3dbnK3QyQ82OAr83Z+E68ATb6lUIRJvLtzxDM5GQ7AqnX+0B9ZTdjOruTY4csqbNNuLw13XqAiPLwnTYMDSFq89e9yC6XY6lS8rD3f63xZ4pkrrazSnNg+WKyB+BlbV6UdwvQWAB81CVV1XjqNLcaZaqhytsY2UahBDhDsZOiKdTrrP5SXjYoLW0lbjR8FjBY8sLB8xNEUX94MTDskferwgU+2eW36Rjqq12bgfqueArz6leCbJW+Vhu/fyUd82Q1mK2sW8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db0lls8Qg746k8cnatLCbWq9TxosqHWZj2uUkyGjNig=;
 b=rb8dB+t2VVnmhga1gQVvc/aY1oqSrDqntPQM20E3QO/tvRwLZrOcjGPrB6iCHjWjqHoqMRJrDEMbcQd6G4Cbm6egEnlOUE8mNjvX4yW3y6hT3bit7Wv6Zo0iQ5F9/cAs4klrDkBWgt8sEKexbPQPU8TA/UoZ5ysGkeEkwZR8FkL6uAkkVtx0o8Je2k3NLk3iM5CZH5kkg+TFTlu712hKElUuDjIB3oHPoQqwwWTnHH+x6YxlKKEIyX55amqlOSWEMUU6H8buV7wDjqZO1wJy4v1h1TJ84ifPvnaGy6v9AAzyDFMZKfBCUQZT3cV8+GkSmG92K7XkJYD/OhKVD3UIVQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:22 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:22 +0000
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
Subject: [PATCH v10 07/13] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v10 07/13] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcNFLReWIhFmvws0W1nd3FYYXYfQ==
Date: Fri, 3 Oct 2025 10:45:22 +0000
Message-ID: <20251003104443.51501-8-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: 50cc3b17-4612-46a6-45f9-08de0269f3ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b+KWnLXG/FVKlT8nEdqfdl52lDIw78DFPtkfpV1swtC2nFGlGb+ADzgpAw?=
 =?iso-8859-1?Q?xulJ1JVaDoV1v7uvuF1NP8DtP96B80S6EhIg0g9+5c2YZfuSP0I9eAqhQa?=
 =?iso-8859-1?Q?Q6XiQ0C+BjaKFB4tjIp3KsWDhck1eNdi8U4fr8Onny2xr/IczFlkJqeNLW?=
 =?iso-8859-1?Q?uXzqs/T2BYzPffxv2NjD061xUJysWlLpyPeFPAqSN41Xo37NOMzrEO4oCo?=
 =?iso-8859-1?Q?Y20nFri+MSJP4vg+ksWRaKg1R2NBgR0JQoMdfDYGt+cjYAlZXuHjTJXLit?=
 =?iso-8859-1?Q?jV6L5O2+33L3K41OJOeSJ12wPiFbYYb+xD3JDcTyUQJ4vtkkPNRPyafWC2?=
 =?iso-8859-1?Q?rTpyNMskz701+TuFnq8QO0CNXzHGCYTCtlkntjvedXc5qfW50kbgK9NHd/?=
 =?iso-8859-1?Q?Cl4RIn/icvhrNnyazAQBElJ0GwNBYbvP3C8Kk7r1ASPqA6f/spuUqyYUqp?=
 =?iso-8859-1?Q?qboA5kL/W4UesVZKOCh10+u+TGr2KXdt7Sk8NPpwUqXONbj2nPbxe+yoaN?=
 =?iso-8859-1?Q?4cxi7taiyqNHsxdSeEDmV6VyCvsumhlu1rtsMsukfEOVZB2MYPyI8B4+2j?=
 =?iso-8859-1?Q?Dg8CJXSbqsAhGQhIQK3B3yiEgTWo67TTe/G9XNiVlsOaFzB/08M3l1M+9M?=
 =?iso-8859-1?Q?3Jtkm60qzpxi/MtOjT622U+q5HhttDYrYfoK4uXA6gBLT7+d6ZYYqxI9BB?=
 =?iso-8859-1?Q?rT6NzqCIVC+0XEQGkBky3Auj9+u3d2LRDsWLrz3imYsNhmXd6NzhWgVPxQ?=
 =?iso-8859-1?Q?VXMDNnGdE2sZFO/jsEEmI5ZlEfJg+471YxlDdia0tGDTkJRdautQ2qBgxW?=
 =?iso-8859-1?Q?S68MtonwEuUy42ixMxZTHbCOBEgzbQ9JDK0ATLhI/bPJLvmhpGu7fqg/ym?=
 =?iso-8859-1?Q?cOS7M4sXTrd6gc23PjVeyN9mt8g9ip40/rduNRfBZBvb016XW4NGBOH0Gt?=
 =?iso-8859-1?Q?JzvAzEUNchC1B1rrwKHJI37BryFBm5tU4p3gyPUVPLs5R5T7dHeP1vZaLG?=
 =?iso-8859-1?Q?6YfTop9KSZUgBOeUnixnWnYGWQh8K+HD036cJrJ3sXGRccRtprd3WhAzRf?=
 =?iso-8859-1?Q?0edCJNsBD66ikMbwm4vKRmd/iHfcge3sHh8FlSewBReesjI+7hy2cMdUP0?=
 =?iso-8859-1?Q?RBhhIRNbkNdhMPttRpP0UmIcC2VJjHH4H0EcAEU+luLKD/KtrAOYv0r8Eg?=
 =?iso-8859-1?Q?HxAKxU3GMCtYigdKqOifeucQ8GY+Ot8qaeXrh6OTgRvGEaf4TRueIRgFgM?=
 =?iso-8859-1?Q?QKuiV+OXcsq5jjGVtlqcqFjdBVnUW9syYemSPy70wIRvcrnSTkeh7/WCgJ?=
 =?iso-8859-1?Q?WtgJAv2AT4qRYRnns89qKoDk9lYpZlgfDqXqNsp93xL65S5S4nXLQYhzhe?=
 =?iso-8859-1?Q?M4uj/q8tqL30/sqP06fdZ7aqfA2cWDxdxzODKm5xzLGs0DeKimV/4KWsCU?=
 =?iso-8859-1?Q?0e9OOVMa01IAvOQF1Edh/ByttU595x0rE0ARm0eUsDAU/Bj3RfdfJn7XQW?=
 =?iso-8859-1?Q?uzd9n/R8cKJuygP31xPMhKJWx15Wu0Io4Vg0SPTYGAJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vI4xokgsWHLGBNmrKNQRT0cSeVNuCe/rzKBRME5UOGAzT46rnMptCbFJQG?=
 =?iso-8859-1?Q?Jx/VTxGPCuMY15pzFC0m12ltF2G9k/4Tmzb0npSmdeXj+KqdIc/PPq3/no?=
 =?iso-8859-1?Q?h3Y1UhjgsEZzLfafn+jlfwHvqauST78lsABXaSES3nrBFyCp6XbhjUCk24?=
 =?iso-8859-1?Q?JJRz8+yjxL4sasOqDw5eUb7PN2ynJXrKQqmpMgmhlzWDG2PR42+f9SppVK?=
 =?iso-8859-1?Q?86tVSXZtw1o/Ef8Of7vBYGL9zLQBkzEopswRLexAcnUrmP7SsrXYDV++ZW?=
 =?iso-8859-1?Q?tPuI5RA+RgEiAWSCnUyM/h1/wiL/ia6JDfo2dNAAOSLoxyWJDskLVIHf4F?=
 =?iso-8859-1?Q?RrQTEefOSHl5ptpqANNh9WtvUmlRqWWgP6NT1G+LV81Gz0F1rzRdqU0q5o?=
 =?iso-8859-1?Q?mok2cnjHlbmvMqlFRNjjWjknzUQ2UDgE9l9FACZewijVUk74CHzhEu7BHT?=
 =?iso-8859-1?Q?eU9HZuICOlCweBSAS4QMFBf7tEWpQK1+NTui0WxvEQhdZ79mmKE8DyEKDC?=
 =?iso-8859-1?Q?v60E/Yfw8hFh4R5cD6JJOwDIKUAafEa656gifWJ8LnrEJ7ZtFEgyl9gOKN?=
 =?iso-8859-1?Q?p2960XiwKHkpf7W5pDibMfGSIdFIZMU3MMp+vSIzw90xLJnYpGvMfgtY0L?=
 =?iso-8859-1?Q?IZbIb08UIKd2Z4zAaUga6XFAi01/KAq7exJpOrwPmHJXN+/xsmfUCtSA/r?=
 =?iso-8859-1?Q?zShpjjI4dRUh7ObRpDpLxvztTWuUnnnMt3TjCs4XECT4K1CNk437hbq7s9?=
 =?iso-8859-1?Q?Qe672fryL634b8UOobNTnXHEUu23G5KvM887OtW822mc/gaLiUMAA+bPvX?=
 =?iso-8859-1?Q?tAiZM9cb7W/m3q7jml0k3KNpsp1CNihgIuXivlHJKUdUT2BnE/oqfZszXD?=
 =?iso-8859-1?Q?H833PvQUUf2tp5DKogZIlAadJs7fWuF6UR52ajpKMmRcqCGqv8SDkZj1jQ?=
 =?iso-8859-1?Q?L8xs62Zlsgpp81uSzv04qfS+jKu92SLq4MOj/SNdYDScqucI7W0Y06lbkp?=
 =?iso-8859-1?Q?mehvg38V7BeRw/6F/k/lizoOUfKZo/bRpiJFPNo9M1KolVeXdmwUZHZNcj?=
 =?iso-8859-1?Q?Fo2xWEHKKpgEdeICClUq+6WVRhGb3kMhOHiKb0KVtwuhKuFibF7aUdv+iL?=
 =?iso-8859-1?Q?qfB6KORefaqHBMJ/yrIcgj9GTFI1KkI+ykEwB2CnGfHcn+zwJzruNf4r4G?=
 =?iso-8859-1?Q?ULR6HP8iQiMQLY6G0O/PwqDachgTiPIebhDmO5h+zphu6g+AjqT3CKFC1c?=
 =?iso-8859-1?Q?X8ihEFbk4/EWtAZgy88R0VKjIgr423vqcqovey/p2er0q8wdwE6NILAOOD?=
 =?iso-8859-1?Q?wlczvOMxT8yEk9OD3OClonyldg2GmsaT8RR3CjnNK+Cjq3ZRVUojYFvzfd?=
 =?iso-8859-1?Q?8X80WiJp5aK0fZznW8E+yV9iAI4qtSmQWNJEIRyb4RwKxemoB1UQ5pfCGL?=
 =?iso-8859-1?Q?2V6xOJ3gA3U19hQ8e65jxxSRRrV49v4SVWT8wj/3xSECiZ3OUtGpg94mpV?=
 =?iso-8859-1?Q?It5BG9t8PmVSwmkOHYy6EzGrzZ3Ko5Aew30egnwfxgGjgGSFwAJoOkZX+V?=
 =?iso-8859-1?Q?ISxg7GiwdtMylyCQHGCWm5qKj4q75U+o05CCSDKlPQc5jF0+BQDo62/tZr?=
 =?iso-8859-1?Q?r5cigvblxAyuXCrx5MQfrcFC+WlETKQ9D2MXue5cWdPhmJQk+qM72pS1iG?=
 =?iso-8859-1?Q?IsRIjhXB014FA4M1K3o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cc3b17-4612-46a6-45f9-08de0269f3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:22.0325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zo2SNloAN3auamhCjkGBM+6N6pDjG31xy9NGcQYW6ja3zWviflhBrLZ5KdV/xaHr3rxsDXDFeEsklMdxWOtv64ZZP406dQM+bhk4TJ2+rRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
index 3a66c9408e..71439785fc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -250,6 +250,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1384,6 +1385,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3298,6 +3300,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index dd3ee7ba2b..7c624ab677 100644
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

