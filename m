Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B50ECD128D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrdz8-0004v1-HH; Tue, 02 Apr 2024 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simeon.Krastnikov@imgtec.com>)
 id 1rrdYq-00028J-Rb; Tue, 02 Apr 2024 08:48:22 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Simeon.Krastnikov@imgtec.com>)
 id 1rrdYe-0000CM-4H; Tue, 02 Apr 2024 08:48:19 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4327UEjY019305;
 Tue, 2 Apr 2024 13:48:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
 from:to:cc:subject:date:message-id:content-type:mime-version; s=
 dk201812; bh=8a+U9a++3V5olVXn5lPIRnLLnF7ytqLQQKWqy2P4EYU=; b=mZK
 fGAaJNUWEcH61pEMJsraEZe2oy6PCEm5tUGoXYopxJrWuK757mWKPsBF/4QluvPO
 SyZxcfQQXBJeLdQM4zQZMp/bHStbfWO/fEpKGeLL7hGGTlJSIDeUZLnT1DeTF14D
 hixO/aeDxpWS/kYICfKyt+W8nmSJDHhFePrLgkqLyadS9Cc/gE1+QOiQEYobLyws
 IKxxT/Rqp7mopaPPgvppZ0zQUM7Z9UHOn0oDyTXIgy+9Ksuik5qjDpj4X+BVSk6b
 t/V+U3XCYgtJhCSOwAy9NwDJfWrKEClgnMc/LdeSa4dfciFZZPWHpv616H3t9TV8
 YBJHZVcIf7bGpMpZC8w==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3x6bpwuxpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 02 Apr 2024 13:48:02 +0100 (BST)
Received: from HHMAIL04.hh.imgtec.org (10.100.10.119) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 2 Apr 2024 13:48:01 +0100
Received: from LO3P265CU004.outbound.protection.outlook.com (40.93.67.5) by
 email.imgtec.com (10.100.10.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Tue, 2 Apr 2024 13:48:01 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8U0pTN44UdjguTmXT7BrF0n2eMLkkLIPP2Jp6RHQ3p2fw4F5Npl7ypUUOWHBJFsaLZYqZhEoxqGieaRqOBb16mPdkDPbGN9G5aEp2XnfmK8QNy4HcZ/cBHXf3j+msx0+kcMnd8A7BfIVFLo4S5zPVHgf+0CL5b/0SVANvGBUGUtwt8Ldcom3suJGZdaf/mQK4XDe1HK70Vfelgf6zKoTcJGQQHEBYz6gXBk6u9e0iRpeVLYAOWbrrO/TE+yHEc6Fi8b8kco8aZ2BUYg596dgPlrfJX0ML5Pnf81wu1pB5n3oYOyckSHeJutRvL0GNvjNL0tCWfjgoVDPQk5igl4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a+U9a++3V5olVXn5lPIRnLLnF7ytqLQQKWqy2P4EYU=;
 b=Vm+0q+mIWC8ZEZ/wwan+4xGdAmNOdpXovjBFyeza+V6HFe5y5ybHVYSowvDt9dZk9HIc/5C7rKwtn7hHJG7C++ra/NjjLmXKAPmM7eM8f2GMepAnSapdBMJEOZs/s3R3iQtedYeti84BVyZL37zWP+uHGAgJy+haw9K6wiJRGbVSWAcD0XBIv22c2xOyWojeQpjtnF/WYIKMf/4uJ09mwrfuGzbXEqOFVVJ9W8Nefce1PSpAett7DOcruh+OottaDkD9AornHoYID4XM0+BfwmALBybMUz3Nbs3xLtoxWw7JzK1nGmHiS2wVT9My8WwpJvTV/Fibu+4+Yc5u4Azclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a+U9a++3V5olVXn5lPIRnLLnF7ytqLQQKWqy2P4EYU=;
 b=CQlxC5gxD+EWh66pMKIWikebVDdV0folWplQ6IsAGk1s0OjADbr3mRXXQZRKMJg0FfVVtUDRhXXn8ru/AdV96cMFH37TJ8do94cIiB0YzoXZDTu+9LzNAIE4VBKDcHGwJCOrcL/EKZUUSyAKHalqWVf2uc0dKECn4vSSDrPurtM=
Received: from LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f0::11)
 by CWXP265MB1975.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Tue, 2 Apr
 2024 12:48:00 +0000
Received: from LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c9e8:ad7a:f36e:a282]) by LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c9e8:ad7a:f36e:a282%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 12:47:59 +0000
From: Simeon Krastnikov <Simeon.Krastnikov@imgtec.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>, Shiva Chen <Shiva.Chen@imgtec.com>
Subject: [PATCH] Fix incorrect disassembly format for certain RISC-V
 instructions
Thread-Topic: [PATCH] Fix incorrect disassembly format for certain RISC-V
 instructions
Thread-Index: AdqE+4RJgAV1qFBhT8677tuQrfnSpw==
Date: Tue, 2 Apr 2024 12:47:59 +0000
Message-ID: <LO4P265MB66669BD6FF7CAB642AE30316933E2@LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO4P265MB6666:EE_|CWXP265MB1975:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9SEcro6HEYjmtn4XROFtN6OdLLItESB9i5DVVbid2e3YpkBhnb7WYKJ8bTI+aOme+6gCN22SZPA8SSHaTnbyw8ImS+K0F/h6NsH+njhea4RaMTEmUMSYbFG7j1FZ7bXnpwlBs/xlPg9v22Mr5sMS/8kMUv1y7c1ljk7rvi5iSPIacdjPmXDib2eoyxS1AuOL5d9aCUM/EshZvZf+2rgZO2qCJEOFC/dp7uUSG6J9zs+8cmca+KCJx6EsJOADGVzJtBfPvj+AWFxhjIsY+ofbSKlLvE9G4dMQwKCIpclh7KP0tabthJ+/Qgl9UVX3tueIO3OdZo3s/ofQosiULNj4Lq1+4pHFp26aLvfR+yw4uWukzHzfF+QmUF77SR/VrAZBKoSuyIkbomrVl9LaKfSr+ibF8zmy+na6Qrx1sVvlyQXDGUDer9BbFKCaQsYxJktR7sbrqDncieJ/kM66Lhztk9V+HiZzslYGbP9CcKT1Qd73bv3OxFdXWT4kWTRcHDHxqPl6+cPoNu3Mn6jlIyMAcP+WER9Dd+SlMDyIuAXZTa8v0/S98NyRyApp2Nix3gchGKROhpaNCV7TMIALXQOVHStt5ic+sndlKExh8Ja/wc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PQZG941hvsaSpTm2ZHLms0Wk6g4e6WXoM8DgQBAkewTOUInaWZStro7mZGj8?=
 =?us-ascii?Q?EGdrOJXqdRfzGkjNNB2aFcYMfwx+hpPuxr2/JvYDeuy2RzveD22ddou+Y38k?=
 =?us-ascii?Q?+LbHhv8etsnOcuxaa6szdIPV+4p7tIXs36Nl9Dy3sKWsGMHcYuo/YuqXDIGF?=
 =?us-ascii?Q?bcDrnT37MIp3u4Qff3VlYp3QArNtcq/8CGmRQv6CydYg7srSXrmvPyKkGaGj?=
 =?us-ascii?Q?ZF7T2EoIJFCDAZ1DPkCSTclwKiP804WONiE48kugNPBYtMJb80kkT8jJj8fv?=
 =?us-ascii?Q?algDfhdUycwhVLE11nIQKxBHcv5z8Uur2Nm4Hr7mvEI1mPgXb7JruAl3g4X0?=
 =?us-ascii?Q?V1O1sdBYFleaq8gFei/wyUoEmrt5aPbDPJTOoA114vNgbt88OST2JdXd/74d?=
 =?us-ascii?Q?Ihq4u9kqG+pQiQxpfsmIe0Xgs2Xp5HbeD7dG1/P9QeemeGYWZja6AlpSNwrN?=
 =?us-ascii?Q?gIN6gG+ftVUkMVRsN2ZK+7s+lIjbKY7Dxmp688G7u11L11QUwcGHW15GxwVt?=
 =?us-ascii?Q?TtgCY5ENpPJDdqMYF0fSfLWIOeWLmUuwzuV/iz3DD66CpYM6e/YZUNfFHUAb?=
 =?us-ascii?Q?uaraoj0X4gAI4uV0ZG/mK9LXS+vZzauB6qSoRVw1QcKLWOvN5r+yYhDZ1dgu?=
 =?us-ascii?Q?Jt8H7WLTnK704QwyXv8cIobpKBif6c5So0uBql7E6vjQ7HnRfFTrLP/4AeAu?=
 =?us-ascii?Q?m0mhmSGpPzYrPC5PVE2YuaSAKddyY0kScSoZVNrix5mGuS0hWghJeVRSy+g4?=
 =?us-ascii?Q?S/GUxS43D5a9yvsWnrptjYycJwXrP5tN+DdwkLP8bG6iU+QVvKckpt00LbzB?=
 =?us-ascii?Q?HHQ6FgzNdTNQAElxh+HuSEJrD3+YO/q0RnxOIdJwmLn0dZTeg95RruXl8k0X?=
 =?us-ascii?Q?OeArkS7XcENh6AxTo18evCiVkT50jPprfUgTFAk92kuzklbFAoLeUGlQ+84F?=
 =?us-ascii?Q?pwLmJ1EwSMKex6qHWNUzHl9NubBtEDrOGtE4MGUceJar4A2Y4JHRek2iTzAe?=
 =?us-ascii?Q?2mY3qaSn8VR+ZZHngssSOoFBfLaKUc5LZgxUBxp+kpT6YyNniIftHlwxInm7?=
 =?us-ascii?Q?TC9V144AV26YeCHWCugZ2UYarb8p9JWV7sRtp+fkJj2tb2PZhhFiRC5KIf4y?=
 =?us-ascii?Q?7jnMDCSLto1UKy/d++L+eKyn8QWfuWAf48kaF5QL+Uwb8PF6HfpziO+jOb3J?=
 =?us-ascii?Q?8Xm7p3ZgR3mv2D3KF9N4Ap3fIvznFdzsk/Zps6Eo+8JJKparptfnHNz/ib0Z?=
 =?us-ascii?Q?msZcX+yddoiw4OK1OyQT4N9+aAbUJ0l5+d0nuHMcFS/c7+/PcGiz7XUQwP8j?=
 =?us-ascii?Q?yaCOcdqJsF434cwAGSTiM7MO+CGTdtGLuO07ZbHl2SioeukMpPzCubaDXLYC?=
 =?us-ascii?Q?0aSiTFMSWK9pWenpD2qW6h58/2c0VPkMdYc17AmyGvXLgVGD9xdYbFPn2GNO?=
 =?us-ascii?Q?tMPzapo/Uoe5KSp6zAtuaiWxR4Nour5fMXoODa00T5+PTqQcE/6vP70uruMc?=
 =?us-ascii?Q?/syNVRA6q32Vz3G5FdJeD86XV4REMTnvZ8UZh4Dvm8AQ/civb1yXgvBvquax?=
 =?us-ascii?Q?a44+YZfk2BPnFder4dcGzJE0O4yjtuuSmY6fVrdwjQZXW6aKwuMB1rnRgn0w?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LO4P265MB66669BD6FF7CAB642AE30316933E2LO4P265MB6666GBRP_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO4P265MB6666.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d9874-c5c6-46ac-94eb-08dc531320ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 12:47:59.8102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZWc9hWuiW7BOgZvPhTS465d/IBGl96SfQHutlMkbsXedhSqra8fEoczMC3v4t8KsYMzLONwelMCGukm2yD8FB69nrk9l4u/10Ms85Qz2HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1975
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: 55i2xm43SNWT6ZWZR1xwynuOiZtXqC-X
X-Proofpoint-ORIG-GUID: 55i2xm43SNWT6ZWZR1xwynuOiZtXqC-X
Received-SPF: pass client-ip=185.132.180.163;
 envelope-from=Simeon.Krastnikov@imgtec.com; helo=mx07-00376f01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Apr 2024 09:15:21 -0400
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

--_000_LO4P265MB66669BD6FF7CAB642AE30316933E2LO4P265MB6666GBRP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_LO4P265MB66669BD6FF7CAB642AE30316933E2LO4P265MB6666GBRP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">* The immediate argument to lui/auipc should be an i=
nteger in the interval<o:p></o:p></p>
<p class=3D"MsoNormal">[0x0, 0xfffff]; e.g., 'auipc 0xfffff' and not 'auipc=
 -1'<o:p></o:p></p>
<p class=3D"MsoNormal">* The floating-point rounding mode is the last opera=
nd to the function,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; not the first; e.g., 'fcvt.w.s a0, fa0, rtz' =
and not 'fcvt.w.s rtz,<o:p></o:p></p>
<p class=3D"MsoNormal">a0, fa0'. Note that fcvt.d.w[u] and fcvt.w[u].d are =
unaffected by the<o:p></o:p></p>
<p class=3D"MsoNormal">rounding mode and hence it is omitted from their dis=
assembly.<o:p></o:p></p>
<p class=3D"MsoNormal">* When aq and rl are both present, they are not sepa=
rated by a '.';<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; e.g., 'lr.d.aqrl' and not 'lr.d.aq.rl'.<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Based on the following assembly reference:<o:p></o:p=
></p>
<p class=3D"MsoNormal">https://github.com/riscv-non-isa/riscv-asm-manual/bl=
ob/master/riscv-asm.md<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Simeon Krastnikov &lt;simeon.krastnik=
ov@imgtec.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">disas/riscv.c | 144 ++++++++++++++++++++++++++------=
------------------<o:p></o:p></p>
<p class=3D"MsoNormal">disas/riscv.h |&nbsp; 10 ++--<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 79 insertions(+), 75 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/disas/riscv.c b/disas/riscv.c<o:p></o:p=
></p>
<p class=3D"MsoNormal">index e236c8b5b7..71a3ab878f 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/disas/riscv.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/disas/riscv.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1311,98 +1311,98 @@ const rv_opcode_data rvi_opc=
ode_data[] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;csrrci&quot;, rv_co=
dec_i_csr, rv_fmt_rd_csr_zimm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;flw&quot;, rv_codec=
_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsw&quot;, rv_codec=
_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmadd.s&quot;, rv_codec_=
r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmsub.s&quot;, rv_codec_=
r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fnmsub.s&quot;, rv_codec=
_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fnmadd.s&quot;, rv_codec=
_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fadd.s&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fsub.s&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmul.s&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fdiv.s&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmadd.s&quot;, rv_codec_=
r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmsub.s&quot;, rv_codec_=
r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fnmsub.s&quot;, rv_codec=
_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fnmadd.s&quot;, rv_codec=
_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fadd.s&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fsub.s&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmul.s&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fdiv.s&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnj.s&quot;, rv_c=
odec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_s, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnjn.s&quot;, rv_=
codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_s, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnjx.s&quot;, rv_=
codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_s, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmin.s&quot;, rv_co=
dec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmax.s&quot;, rv_co=
dec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fsqrt.s&quot;, rv_codec_=
r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fsqrt.s&quot;, rv_codec_=
r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fle.s&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;flt.s&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;feq.s&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.w.s&quot;, rv_codec=
_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.wu.s&quot;, rv_code=
c_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.w&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.wu&quot;, rv_code=
c_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.w.s&quot;, rv_codec=
_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.wu.s&quot;, rv_code=
c_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.w&quot;, rv_codec=
_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.wu&quot;, rv_code=
c_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmv.x.s&quot;, rv_c=
odec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fclass.s&quot;, rv_=
codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmv.s.x&quot;, rv_c=
odec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.l.s&quot;, rv_codec=
_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.lu.s&quot;, rv_code=
c_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.l&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.lu&quot;, rv_code=
c_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.l.s&quot;, rv_codec=
_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.lu.s&quot;, rv_code=
c_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.l&quot;, rv_codec=
_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.lu&quot;, rv_code=
c_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fld&quot;, rv_codec=
_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsd&quot;, rv_codec=
_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmadd.d&quot;, rv_codec_=
r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmsub.d&quot;, rv_codec_=
r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fnmsub.d&quot;, rv_codec=
_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fnmadd.d&quot;, rv_codec=
_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fadd.d&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fsub.d&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmul.d&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fdiv.d&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmadd.d&quot;, rv_codec_=
r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmsub.d&quot;, rv_codec_=
r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fnmsub.d&quot;, rv_codec=
_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fnmadd.d&quot;, rv_codec=
_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fadd.d&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fsub.d&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmul.d&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fdiv.d&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnj.d&quot;, rv_c=
odec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_d, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnjn.d&quot;, rv_=
codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_d, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnjx.d&quot;, rv_=
codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_d, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmin.d&quot;, rv_co=
dec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmax.d&quot;, rv_co=
dec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.d&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.s&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fsqrt.d&quot;, rv_codec_=
r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.d&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.s&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fsqrt.d&quot;, rv_codec_=
r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fle.d&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;flt.d&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;feq.d&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.w.d&quot;, rv_codec=
_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.wu.d&quot;, rv_code=
c_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.w&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.wu&quot;, rv_code=
c_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.w.d&quot;, rv_codec=
_r_m, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.wu.d&quot;, rv_code=
c_r_m, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.w&quot;, rv_codec=
_r_m, rv_fmt_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.wu&quot;, rv_code=
c_r_m, rv_fmt_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fclass.d&quot;, rv_=
codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.l.d&quot;, rv_codec=
_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.lu.d&quot;, rv_code=
c_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.l.d&quot;, rv_codec=
_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.lu.d&quot;, rv_code=
c_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmv.x.d&quot;, rv_c=
odec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.l&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.lu&quot;, rv_code=
c_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.l&quot;, rv_codec=
_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.lu&quot;, rv_code=
c_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmv.d.x&quot;, rv_c=
odec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;flq&quot;, rv_codec=
_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsq&quot;, rv_codec=
_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmadd.q&quot;, rv_codec_=
r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmsub.q&quot;, rv_codec_=
r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fnmsub.q&quot;, rv_codec=
_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fnmadd.q&quot;, rv_codec=
_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fadd.q&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fsub.q&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fmul.q&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fdiv.q&quot;, rv_codec_r=
_m, rv_fmt_rm_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmadd.q&quot;, rv_codec_=
r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmsub.q&quot;, rv_codec_=
r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fnmsub.q&quot;, rv_codec=
_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fnmadd.q&quot;, rv_codec=
_r4_m, rv_fmt_frd_frs1_frs2_frs3_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fadd.q&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fsub.q&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fmul.q&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fdiv.q&quot;, rv_codec_r=
_m, rv_fmt_frd_frs1_frs2_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnj.q&quot;, rv_c=
odec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_q, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnjn.q&quot;, rv_=
codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_q, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fsgnjx.q&quot;, rv_=
codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_q, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmin.q&quot;, rv_co=
dec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmax.q&quot;, rv_co=
dec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.q&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.s&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.q&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.d&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fsqrt.q&quot;, rv_codec_=
r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.q&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.s&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.d.q&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.d&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fsqrt.q&quot;, rv_codec_=
r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fle.q&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;flt.q&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;feq.q&quot;, rv_cod=
ec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.w.q&quot;, rv_codec=
_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.wu.q&quot;, rv_code=
c_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.w&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.wu&quot;, rv_code=
c_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.w.q&quot;, rv_codec=
_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.wu.q&quot;, rv_code=
c_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.w&quot;, rv_codec=
_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.wu&quot;, rv_code=
c_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fclass.q&quot;, rv_=
codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.l.q&quot;, rv_codec=
_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.lu.q&quot;, rv_code=
c_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.l&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.lu&quot;, rv_code=
c_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.l.q&quot;, rv_codec=
_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.lu.q&quot;, rv_code=
c_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.l&quot;, rv_codec=
_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.q.lu&quot;, rv_code=
c_r_m, rv_fmt_frd_rs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmv.x.q&quot;, rv_c=
odec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmv.q.x&quot;, rv_c=
odec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;c.addi4spn&quot;, r=
v_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2009,8 +2009,8 @@ const rv_opcode_data rvi_opcod=
e_data[] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;cm.jalt&quot;, rv_c=
odec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;czero.eqz&quot;, rv=
_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;czero.nez&quot;, rv=
_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.bf16.s&quot;, rv_co=
dec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.bf16&quot;, rv_co=
dec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.bf16.s&quot;, rv_co=
dec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvt.s.bf16&quot;, rv_co=
dec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;vfncvtbf16.f.f.w&qu=
ot;, rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;vfwcvtbf16.f.f.v&qu=
ot;, rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;vfwmaccbf16.vv&quot=
;, rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2031,15 +2031,15 @@ const rv_opcode_data rvi_opc=
ode_data[] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmaxm.q&quot;, rv_c=
odec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fminm.h&quot;, rv_c=
odec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmaxm.h&quot;, rv_c=
odec_r, rv_fmt_frd_frs1_frs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fround.s&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;froundnx.s&quot;, rv_cod=
ec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fround.d&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;froundnx.d&quot;, rv_cod=
ec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fround.q&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;froundnx.q&quot;, rv_cod=
ec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fround.h&quot;, rv_codec=
_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;froundnx.h&quot;, rv_cod=
ec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; { &quot;fcvtmod.w.d&quot;, rv_co=
dec_r_m, rv_fmt_rm_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fround.s&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;froundnx.s&quot;, rv_cod=
ec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fround.d&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;froundnx.d&quot;, rv_cod=
ec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fround.q&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;froundnx.q&quot;, rv_cod=
ec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fround.h&quot;, rv_codec=
_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;froundnx.h&quot;, rv_cod=
ec_r_m, rv_fmt_frd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; { &quot;fcvtmod.w.d&quot;, rv_co=
dec_r_m, rv_fmt_rd_frs1_rm, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmvh.x.d&quot;, rv_=
codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmvp.d.x&quot;, rv_=
codec_r, rv_fmt_frd_rs1_rs2, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; { &quot;fmvh.x.q&quot;, rv_=
codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -4854,7 +4854,8 @@ static void format_inst(char *=
buf, size_t buflen, size_t tab, rv_decode *dec)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cas=
e 'U':<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; fmt++;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; snprintf(tmp, sizeof(tmp), &quot;%d&quot;, dec-&gt;imm &gt;=
&gt; 12);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t uimm =3D dec-&gt;imm &gt;=3D 0 ? dec-&gt;imm : ((1=
 &lt;&lt; 20) + dec-&gt;imm);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; snprintf(tmp, sizeof(tmp), &quot;0x%&quot; PRIx32, uimm &gt=
;&gt; 12);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; append(buf, tmp, buflen);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (*fmt =3D=3D 'o') {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (strlen(buf) &lt; tab * =
2) {<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -4939,7 +4940,10 @@ static void format_inst(char =
*buf, size_t buflen, size_t tab, rv_decode *dec)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cas=
e 'R':<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dec-&gt;rl) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (dec-&gt;aq &amp;&amp; dec-&gt;rl) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; append(buf, &quot;rl&quot;, buflen)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else if (dec-&gt;rl) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; append(buf, &quot;.rl&quot;, b=
uflen);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/disas/riscv.h b/disas/riscv.h<o:p></o:p=
></p>
<p class=3D"MsoNormal">index 16a08e4895..a7a2a49971 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/disas/riscv.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/disas/riscv.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -237,11 +237,11 @@ enum {<o:p></o:p></p>
<p class=3D"MsoNormal">#define rv_fmt_rd_frs1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t0,4&q=
uot;<o:p></o:p></p>
<p class=3D"MsoNormal">#define rv_fmt_rd_frs1_frs2&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t0,4,5&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">#define rv_fmt_frd_frs1_frs2&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t3,4,5&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-#define rv_fmt_rm_frd_frs1&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\tr,3,4&quot;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-#define rv_fmt_rm_frd_rs1&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\tr,3,1&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">-#define rv_fmt_rm_rd_frs1&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\tr,0,4&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">-#define rv_fmt_rm_frd_frs1_frs2&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;O\tr,3,4,5&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-#define rv_fmt_rm_frd_frs1_frs2_frs3&nbsp; &quot;O\=
tr,3,4,5,6&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#define rv_fmt_frd_frs1_rm&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t3,4,r&quot;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+#define rv_fmt_frd_rs1_rm&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t3,1,r&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+#define rv_fmt_rd_frs1_rm&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t0,4,r&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+#define rv_fmt_frd_frs1_frs2_rm&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;O\t3,4,5,r&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#define rv_fmt_frd_frs1_frs2_frs3_rm&nbsp; &quot;O\=
t3,4,5,6,r&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">#define rv_fmt_rd_rs1_imm&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t0,1,i&quot;<o:p></o:=
p></p>
<p class=3D"MsoNormal">#define rv_fmt_rd_rs1_offset&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t0,1,i&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">#define rv_fmt_rd_offset_rs1&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;O\t0,i(1)&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">2.25.1<o:p></o:p></p>
</div>
</body>
</html>

--_000_LO4P265MB66669BD6FF7CAB642AE30316933E2LO4P265MB6666GBRP_--

