Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B539CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrwhZ-0004Ec-OM; Wed, 03 Apr 2024 05:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simeon.Krastnikov@imgtec.com>)
 id 1rrwhT-0004DQ-Se; Wed, 03 Apr 2024 05:14:31 -0400
Received: from mx08-00376f01.pphosted.com ([91.207.212.86])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simeon.Krastnikov@imgtec.com>)
 id 1rrwhQ-000559-Q5; Wed, 03 Apr 2024 05:14:31 -0400
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4337F2eF012653;
 Wed, 3 Apr 2024 10:14:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 dk201812; bh=/ccU9R7v0g3dM8rxhooHYQq5XDpaFLHPR44ahRvZmhE=; b=vey
 YenWeTV1vEStMkP9j6opWsvhxhU79TbENY8rljrrDdn/GPbm4P2Xui40f2hCuLVY
 O2DEkl3kupG2/QPLIxrnBUmRzW3XCf02WTZDwcvOxN/8qaQMPYTUH2u2paYmi3R7
 ieDHqci0ZoN6+hkibkvEjK8LMgZr5//5GWru5bBj5Q+l9/8IQzPqEvKzGgFp9KdU
 w3HTE9L7HBmL+4muxpFi60plHWdWRIznF9dOxtFrCuq+689TAreIA/blXlFnMx5V
 EaHQCTUmEA7fXUuHEcwbFsmqYKge+1I3qnehPCxpihjkeLqwqCKh+Rt2THTG0q49
 kiIMWGdpAUnix9SrK4g==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 3x69vsmnn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 03 Apr 2024 10:14:24 +0100 (BST)
Received: from HHMAIL04.hh.imgtec.org (10.100.10.119) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 3 Apr 2024 10:14:23 +0100
Received: from LO3P265CU004.outbound.protection.outlook.com (40.93.67.5) by
 email.imgtec.com (10.100.10.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Wed, 3 Apr 2024 10:14:23 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHtIhlwUM9PjKISWLP0Oj1K6uUMC/pwuVHvinASOH7YG2/kv0ZH2sMzAGAGYXmYAzW+4Uie8WzxG2uMDwtLSJf5mZeffmzkFRK5aVSDlY5UpMNC8ZmHoZ3VsRQa4avd+T8nyLNAJEeDT/fRhL0c45ggOgzp85afZqHFSrlz978Q/0Bd7Ze55FksIeT81Vm34aCvQmRBKwLEDv08TQC+Tk/lYjM3T9uL+gEZwY7WavSTrk8Bh7FSMAXI2yndLE9wGyRXeLyKhCA2DtxLv4Z92td435P8vSXRiS6u9SqE4uvuKkqem7aCHugKV3/FAf21t8J5IvaLN+j13D3Zy3e0wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ccU9R7v0g3dM8rxhooHYQq5XDpaFLHPR44ahRvZmhE=;
 b=HsS+fZzd4N0iuKGY0H/dZLYqtbluCFBLORV4I1WKHfO1ijTdPoiHXP9OXB9/yrM8YFqGioK8UrG+PeOQaLXsNAEDL8E8MIVVSJGpCj/aQwFD0GAJLom86b4AeiIab0J4DZjM4i59SoeM6RsBd8GM8XDa/+n2XVkY69S0/SnWa22shu+D27CGliYUh4uCJGuKmQL3YnfkJl5XOO7dEQFix1FbsKN2u/y3AucwBa3Ny9n1DSglvoySYtZntFI59kNevnIxp+DpFtHNVFOwlMzgEd0UDfSNpAar1F8to35I6VxnskoNRjjEYxLwfBul+vPswHDKYloWHDDTD+Tpkijlpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ccU9R7v0g3dM8rxhooHYQq5XDpaFLHPR44ahRvZmhE=;
 b=BC8W/rJbL3hx/cUCyX28FYq2hsoJ5p80EkBI1tODn3KgpDAmnzefY5ZdwUkGtLaE2/mFI8fRADoXHLYQv0FmZTIWnDhlO0hKnzNxSVYtMIiS2owC79XF+QlvXbl+5Kgos0/IGpL+MCVURu4vo9Qyzg2cusJnZ0EHRPcU4FZN0ZE=
Received: from LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f0::11)
 by LO2P265MB3088.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Wed, 3 Apr
 2024 09:14:20 +0000
Received: from LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c9e8:ad7a:f36e:a282]) by LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c9e8:ad7a:f36e:a282%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:14:20 +0000
From: Simeon Krastnikov <Simeon.Krastnikov@imgtec.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>, Shiva Chen <Shiva.Chen@imgtec.com>
Subject: [PATCH] Fix incorrect disassembly format for certain RISC-V
 instructions
Thread-Topic: [PATCH] Fix incorrect disassembly format for certain RISC-V
 instructions
Thread-Index: AdqE+4RJgAV1qFBhT8677tuQrfnSpwAq8pnw
Date: Wed, 3 Apr 2024 09:14:19 +0000
Message-ID: <LO4P265MB6666B4EBBD3BE5DC8822C85E933D2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
References: <LO4P265MB66669BD6FF7CAB642AE30316933E2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO4P265MB66669BD6FF7CAB642AE30316933E2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO4P265MB6666:EE_|LO2P265MB3088:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /E0uQe5RFg9akOUXPzCuSiUGCknOA5hleb0TrF4BWKVXl43JdHlusEqRD3m9YgeuR9hdUJJyHhi4h7mpdViKBsmzJude5UAzgz7hxAyTjysnoIJci5hB4iIxcdHGbW7rOu8hoe8xuSjnpJ+kmi+P9ngihPXYxlnENGFUJL6JH8datCi4Mw5CIryC5+gLQNCfusCeVKGeMhSZhvntf8vjzBVU34OZYJ03YHbGZC/dt8BT7c7lJOC7Lc38v8gh9OFR1GE8EQkIjlBB4X8AeazqwYrBRta33By4DvVU8UMEo7WW7nx/8lrFba2RPm646v6+ISXl71VrIrrlXJc80XHc9k3Rc8iMG0sFIVdLkRj/x3GH1AaHwE9wzH67uZmstt2alfM1+wTYKAaXcoQIP0KMsME7SLHYreggzxsXcely9fXjW8mqGs2mOxxI6sBWDLSLCUG1WzcNkQpH/IQTEQUi9PKeS+jmT9aCNdOlSJ44Ork6OuqbyAdB9riqFdGj28rOD1UhmBID70irOjerAEPs8ROC/kPxPDA4NqWjGq1DJCG58yqjTJdDD6r19wVr8j/aaOb0qZArxQzp+AZK6XXYb8fmpLs3S2bs3VL0ojaG6C8Zm7BQY2Fqfm05aF0ungtkofUc5IdIOhroH51xXzJB5H9+QmZ+gz37vba+W1+doX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h3Lia4HrYIoUVPLGI2kV4zp0jF6oWEldhGFb48FAJM9RIDl6QGar0hjRWk+I?=
 =?us-ascii?Q?kkxAFHADf6RMJkInIcJs26TJoBRql7DOlSYh2AfMK8ms/d48tul5PNAlNPp3?=
 =?us-ascii?Q?2j6q1M7QX4bJvTQRHAB5aff33vELpnTWj3lue+wRV6Fp8Y8mKFbVT/hXAjNz?=
 =?us-ascii?Q?FB94ddwXLqqRmlWtr2MDHQ8qqSPXxV8B107UfuqQWk/DtvJExDKOOAWFqXAa?=
 =?us-ascii?Q?AW8kzOdTKdEy4N/XEcGdaiveTdCh9ktq1dm71ZpIOoF20L2kUR7ntjBG2h2Y?=
 =?us-ascii?Q?gAsxYnqEJNgFKsGDvBAiW9WWn01j5kdcS/FoNPJLv+woz/pHkW9ooCYkep63?=
 =?us-ascii?Q?pYD26DyU821R5sxiDqHCa+YCOEyZh9S+tD+DOUNe/fwFVaSEmvcpGWs2WScH?=
 =?us-ascii?Q?oxjwUDRxrFQbjvVV6yvidTAiE3mTSiOCjafuvwFP1/Se5ymfZlZGCTXQqJXo?=
 =?us-ascii?Q?x1B6+EjZrt5yODWnD7SBAtgGqd72bIUJpVe7LVgL/g7SApDDycl8p9OuA9Rs?=
 =?us-ascii?Q?CpYoXtxoArFwfuJPQ01RQ5hUGGPXG/ie3JxXl4otKx4ABaLn6+1gA6DiQ2kj?=
 =?us-ascii?Q?tC788YAxfX8wPjylZUazbGVSDpnV0mXaTeHRriHs9KHrLpJGjacF3L0Qsfof?=
 =?us-ascii?Q?PSebt6bV7sv1VJDxKyuK+FPQe5nxOhIlAJ+mfoV128YSesktCehnhn6QmZuq?=
 =?us-ascii?Q?/eRavHPb7MvqB54v0Wootf3yj2ts9ejiL9g4bl4p9FG+oeeG4WE+PoS7DAkT?=
 =?us-ascii?Q?bn/gRHYJ55kM5/FgayPXso4pKDoNJoA8L8qnqqSJpLDpWpaUbdJa4Li8Cg2c?=
 =?us-ascii?Q?HxUOHNUgI/Y5WDdT6SayuMq9rSmUp6dihbbCJC9Exk8LGKoi/qhEemLO3FZ5?=
 =?us-ascii?Q?iWljhPfO1kMQwqriIXONWz40DtgZBFDAsmOt3vU1ahbJ6MzTerx7ldWlEHM9?=
 =?us-ascii?Q?mtpzx0o5SgpF0NJozTfLXU2Yl/pmBBWLie1xU3y9etXX7Df81hLOhTliOMG2?=
 =?us-ascii?Q?fC4Y6IdDIXgik7w4BmX9Hisy+1+uq9GpeVX427WvhH5GSYh76WFwegyIVofy?=
 =?us-ascii?Q?NyU/Ez2V+kSUjpEFvr4o8fEFObFjiTECv76xdqaEB3ozPBpjuGz7ZEXMkP5J?=
 =?us-ascii?Q?i0miqaz4wJ3NoQa5apjArdW3NjnyqpG6pCR2AX52LC5dK7k/YhzsfTXMp2kf?=
 =?us-ascii?Q?cnvr6AlXx1I+UjxLaIGhjVooUcnW9HnGAmgnLUYk8iNS/d4aImrjjs68Sg82?=
 =?us-ascii?Q?nTXS4mh+P8E76765k/pN/wDBkAVWWQuoeGT0sUUaYmkvcjru3sJ1SMenjjPz?=
 =?us-ascii?Q?N8LmHEX2PkcBFh64zR3l2MNcNiFZ5r99xaD3JUVPB10a+HjI5LvtYahepsuu?=
 =?us-ascii?Q?xxG3TPHjeBlEg9yxbHZPCIa84xh1mSLgO9XShyBcYAa3Md3NjCy3jirUPe5+?=
 =?us-ascii?Q?V4XtLVbqHuABtmvm0GR+ffszK+AfFloIZk3EwUJAXtnMJ0IBiKs2rlPrsGgo?=
 =?us-ascii?Q?fceBqeFPu2exe64xCfljIu8XMXRh6T+p8nqj4ZzAvr9HUM/qPRiONSkea26z?=
 =?us-ascii?Q?C41kxb4mYznVxplu9+Uqc0eItGWfYxYuywddlf9RmsyUsd5Qu4CrXW1fjNGx?=
 =?us-ascii?Q?eYMsuHJPXtmNo6xHAd4Q/VmEuxnBctDVYyeBScgBCilqo9II1WiVRumfcabs?=
 =?us-ascii?Q?LkYPFg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 10edafe6-5a85-499b-5932-08dc53be71e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 09:14:19.8974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjWWtdf8gM6qW/oaAkC/LM4+l4znecexIgKFIFo8gbE5RLV3gl78NoRnHrJQfqoM25qbKh6deEmwx4Az8BINTKhXrHvu2TI3KO9hZiFV+j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3088
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: jQ0XXH0o3tplFYNHnR6elxmb5X8XvXF0
X-Proofpoint-ORIG-GUID: jQ0XXH0o3tplFYNHnR6elxmb5X8XvXF0
Received-SPF: pass client-ip=91.207.212.86;
 envelope-from=Simeon.Krastnikov@imgtec.com; helo=mx08-00376f01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

* The immediate argument to lui/auipc should be an integer in the interval
 [0x0, 0xfffff]; e.g., 'auipc 0xfffff' and not 'auipc -1'
* The floating-point rounding mode is the last operand to the function,
  not the first; e.g., 'fcvt.w.s a0, fa0, rtz' and not 'fcvt.w.s rtz,
a0, fa0'. Note that fcvt.d.w[u] and fcvt.w[u].d are unaffected by the
rounding mode and hence it is omitted from their disassembly.
* When aq and rl are both present, they are not separated by a '.';
  e.g., 'lr.d.aqrl' and not 'lr.d.aq.rl'.

Based on the following assembly reference:
https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md

Signed-off-by: Simeon Krastnikov <simeon.krastnikov@imgtec.com>
---
 disas/riscv.c | 144 ++++++++++++++++++++++++++------------------------
 disas/riscv.h |  10 ++--
 2 files changed, 79 insertions(+), 75 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e236c8b5b7..71a3ab878f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1311,98 +1311,98 @@ const rv_opcode_data rvi_opcode_data[] =3D {
     { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm, NULL, 0, 0, 0 },
     { "flw", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
     { "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
-    { "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, =
0 },
-    { "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, =
0 },
-    { "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0,=
 0 },
-    { "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0,=
 0 },
-    { "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmadd.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, =
0 },
+    { "fmsub.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, =
0 },
+    { "fnmsub.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0,=
 0 },
+    { "fnmadd.s", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0,=
 0 },
+    { "fadd.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fsub.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fmul.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fdiv.s", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
     { "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_s, 0, 0, 0 }=
,
     { "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_s, 0, 0, 0=
 },
     { "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_s, 0, 0, 0=
 },
     { "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
     { "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fsqrt.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
     { "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.w.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.s.w", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.s.wu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
     { "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
     { "fclass.s", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
     { "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.l.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.s.l", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.s.lu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
     { "fld", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
     { "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
-    { "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, =
0 },
-    { "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, =
0 },
-    { "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0,=
 0 },
-    { "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0,=
 0 },
-    { "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmadd.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, =
0 },
+    { "fmsub.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, =
0 },
+    { "fnmsub.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0,=
 0 },
+    { "fnmadd.d", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0,=
 0 },
+    { "fadd.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fsub.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fmul.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fdiv.d", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
     { "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_d, 0, 0, 0 }=
,
     { "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_d, 0, 0, 0=
 },
     { "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_d, 0, 0, 0=
 },
     { "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
     { "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.s.d", rv_codec_r_m, rv_fmt_frd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.d.s", rv_codec_r_m, rv_fmt_frd_frs1, NULL, 0, 0, 0 },
+    { "fsqrt.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
     { "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.w.d", rv_codec_r_m, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.d.w", rv_codec_r_m, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.d.wu", rv_codec_r_m, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
     { "fclass.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.l.d", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
     { "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.d.l", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.d.lu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
     { "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
     { "flq", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
     { "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
-    { "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, =
0 },
-    { "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, =
0 },
-    { "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0,=
 0 },
-    { "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0,=
 0 },
-    { "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },
+    { "fmadd.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, =
0 },
+    { "fmsub.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, =
0 },
+    { "fnmsub.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0,=
 0 },
+    { "fnmadd.q", rv_codec_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0,=
 0 },
+    { "fadd.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fsub.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fmul.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
+    { "fdiv.q", rv_codec_r_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },
     { "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_q, 0, 0, 0 }=
,
     { "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_q, 0, 0, 0=
 },
     { "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_q, 0, 0, 0=
 },
     { "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
     { "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.s.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.q.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.d.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.q.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fsqrt.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
     { "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.w.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.q.w", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.q.wu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
     { "fclass.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
-    { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
+    { "fcvt.l.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.q.l", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.q.lu", rv_codec_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
     { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi=
,
@@ -2009,8 +2009,8 @@ const rv_opcode_data rvi_opcode_data[] =3D {
     { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
     { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
-    { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
     { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
     { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
     { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, 0 =
},
@@ -2031,15 +2031,15 @@ const rv_opcode_data rvi_opcode_data[] =3D {
     { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
     { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
     { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },
-    { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
-    { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },
+    { "fround.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "froundnx.s", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fround.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "froundnx.d", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fround.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "froundnx.q", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fround.h", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "froundnx.h", rv_codec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },
+    { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },
     { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
     { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2, NULL, 0, 0, 0 },
     { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
@@ -4854,7 +4854,8 @@ static void format_inst(char *buf, size_t buflen, siz=
e_t tab, rv_decode *dec)
             break;
         case 'U':
             fmt++;
-            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
+            uint32_t uimm =3D dec->imm >=3D 0 ? dec->imm : ((1 << 20) + de=
c->imm);
+            snprintf(tmp, sizeof(tmp), "0x%" PRIx32, uimm >> 12);
             append(buf, tmp, buflen);
             if (*fmt =3D=3D 'o') {
                 while (strlen(buf) < tab * 2) {
@@ -4939,7 +4940,10 @@ static void format_inst(char *buf, size_t buflen, si=
ze_t tab, rv_decode *dec)
             }
             break;
         case 'R':
-            if (dec->rl) {
+            if (dec->aq && dec->rl) {
+                append(buf, "rl", buflen);
+            }
+            else if (dec->rl) {
                 append(buf, ".rl", buflen);
             }
             break;
diff --git a/disas/riscv.h b/disas/riscv.h
index 16a08e4895..a7a2a49971 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -237,11 +237,11 @@ enum {
 #define rv_fmt_rd_frs1                "O\t0,4"
 #define rv_fmt_rd_frs1_frs2           "O\t0,4,5"
 #define rv_fmt_frd_frs1_frs2          "O\t3,4,5"
-#define rv_fmt_rm_frd_frs1            "O\tr,3,4"
-#define rv_fmt_rm_frd_rs1             "O\tr,3,1"
-#define rv_fmt_rm_rd_frs1             "O\tr,0,4"
-#define rv_fmt_rm_frd_frs1_frs2       "O\tr,3,4,5"
-#define rv_fmt_rm_frd_frs1_frs2_frs3  "O\tr,3,4,5,6"
+#define rv_fmt_frd_frs1_rm            "O\t3,4,r"
+#define rv_fmt_frd_rs1_rm             "O\t3,1,r"
+#define rv_fmt_rd_frs1_rm             "O\t0,4,r"
+#define rv_fmt_frd_frs1_frs2_rm       "O\t3,4,5,r"
+#define rv_fmt_frd_frs1_frs2_frs3_rm  "O\t3,4,5,6,r"
 #define rv_fmt_rd_rs1_imm             "O\t0,1,i"
 #define rv_fmt_rd_rs1_offset          "O\t0,1,i"
 #define rv_fmt_rd_offset_rs1          "O\t0,i(1)"
--
2.25.1

