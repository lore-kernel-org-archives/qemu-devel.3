Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5409606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdY-0000Ax-Nz; Fri, 23 Oct 2026 16:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd2-0008PZ-1A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcy-0006um-S8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGnlQ59umBOkbJzJqmgWfNMyOeAF3k2F/IbgGRNnt9T22tSx10rFn7Xa4LTlAPwZKVOnIRYxuhccskIwsPqRkOggEWRE+jpYNpZo2q5UDD3BUsM3aGm2DPZkRck3rkJVZvZVifHgt/CUoY5y7Ae588m1r3RvHyizXeqYi/8MlpWwuOA1oWAaaNBB7fD7FQrKv2ZSfO6YzMWfW/MZT72UtboJztPdI9/f3ms7hCyQOwtzUUdsdW9itEsD+8RKbBkfvoD4p4Efeq7YoaTKge22VFIbNAmP3s7GlFJylHoC/XpbuY4wCPy7FLzq5u0n7wzWKiM2I2/5oMvVm1qX7HgHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnDu1kcVeOZpyr5CCqPz5nrcoHoj0esBcf9FDBpFHgg=;
 b=PWp1zCAFQ19xKZRVYZZQEyhjtlUWzEaTF6sBHXBN12EGq0v7mXAm8PanuTUlcuFVqAHhLcaCAtTkyPD/pbhP3F4zLaHub5N4YhHqzMbrS+Cc8wxppPTGX9l5BfNvSq4UxMBQYG8vgy1++vZJv6NbGeUhQIBpNKqtoKEnMejqqD338skCsRgyafpw/rcZ0EnaSjmywQe0mkwLGWE4rYHGAh2TZV7jzovUEsM7vfNqsj37XMzc+5LJEwpMx5MukkrIk2cxUSgSbQEUhzBD5Qdh4mHGc8rir1/NwJlWjioX5qXZrjpOnrerc/xP9kFEqka6bRsudHans2gRGje5qpEfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SEYPR06MB6107.apcprd06.prod.outlook.com (2603:1096:101:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.3; Fri, 23 Oct
 2026 20:12:30 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:30 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:42:03 +0530
Subject: [PATCH v2 9/9] hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB
 machine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-9-c722e4ca5661@linumiz.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 Andreas Konopik <andreas.konopik@efs-auto.de>, 
 David Brenken <david.brenken@efs-auto.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=23829;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=+4bnhICTjJIs6C9YXdalMcYF1Hx9MrY6Cp/TAbig96k=;
 b=giB8/gh+6FBMDYu+Dlvp4XkHj1exrf5QeXFHeYWtHyGgV7IMfwTPDZmmteXy0MNSDQ0WcYxvu
 ccxp6SalA0aCkBW8mXXDEVjAu7eP+exu3JbxXTS0Hs8lEdU9g0H1Mn8
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SEYPR06MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9af8a0-66c8-4ada-d252-08df3141f796
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|260925021311599003|10067099003|260925022911599003|260925021911599003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: vVmr+cYhL5ItvXpkmsvd9RTaDJe7kWOxK6m1Vo3mCqSZdNy5g+iTBcq3rchSbTIDomNK/YJaHusOqtmx710cz/TjGtV1GeQDJtUQZnKSdZywMauEuz/qTk32dRduNP4NmvNkK33LsOTHGIgTO9wMxE3tLv8ou1U+Tpi/oIRPNFWEkm+xroD2UChDV+cTxC9qZX9u9cPViXIGw5qZ1vnJ1krJ1zlbGxO23MEMSbAU7LnjtqcYYNPNmVo0SJyPkOMVWiYX+IwdsCe1zrpkmWt9cLX3srXAyTf/YaOamVSTfIjF7ACZSJ7oBrCA70YFJ1XfwT9K+g9xJC+zmJe9bthGUNNNUC+6XTY1r88rm0zhoYfe94ZpqqgGRt4bVLk03Ygbp022Oc6sgCsrBQXjI1kv0TlUe5sRh/9kTzoDqEHXPMUmEXbkLKT5SAbZ3gE7koMN/4ny/lOyMsiCG0u2+BGySkWcAEEomiLYxS9PrpNfysg4wgxOH17cugFKY5ZXnlS5+f380jn5pHh9ziRURBYSbp515JgxYPEofK+9/SFxdlY2tr36bp56L12M1gWhwBLzEZhvovquJ6+g87A/XBXiC62yyson1qvvRLsQTCJGssifsE+kLGdqY3m03XphsixlQY1wr0IBSD2S935CzB9x3qjHOpAWz4yXQwchRphNtUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(260925021311599003)(10067099003)(260925022911599003)(260925021911599003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emIvd1pFRXlrZ1ZzQkN0dm9VeDlZTnduaXNvb2ttZVMvdDZSdFpnKzFHNExU?=
 =?utf-8?B?UmxaeEQ4QkJwcDVNVkxnYnFOZjE4NmRwR1dwUDFOT0RuUGlPSDBIR1k3dGFI?=
 =?utf-8?B?TmNiNzRia0xKSjlFaFpSWTVVUlJCRFRnZW85NDBhYXRrUWJ3ZU05ZkRmQndx?=
 =?utf-8?B?dXVFNDZQVHRqT0VVcnNySERhVUJIaXVLUkJjTWF1Sk0rNVNQOUdacXpSbjVy?=
 =?utf-8?B?WlN3NHVMdDMvaHBmaFpnaFpFdCtrUWRkL3RLalNCdUZlOE1WS0lqL3JlWHBF?=
 =?utf-8?B?bFFaYXhTRjFQTVFzZS9VRm1xblpiQ2JxU01iaGp2OWV0eFpia0FjeE9paHNW?=
 =?utf-8?B?TWNLRU5ZWGtJWFFCREVDZUpFZ2t4MUdQVU0wcmw2VWd5c1ZEYzJGc3lzNzBz?=
 =?utf-8?B?Z3J3V2JHVVZYQ1BlcHhwb3ViSzE3eXo2MXYzcktYb0ZsOVlqSURkTjgrL0li?=
 =?utf-8?B?Smk2UkFvT3hHaDVYRjRWa0xQank3K2RPbGdDY1Uza1A4T3Z1WktlTm5wbmFt?=
 =?utf-8?B?T0FRdVNXbTlFOXRWK1AyRXBuRVZrQkdLYjkreCt1VmpVODd0SnNhTHE0Umpk?=
 =?utf-8?B?QjlsemhEZUU5cXBlcnBkeW8rL2ljVThEL0dVamJvRnpCN2dxcnJtNTVZMDkv?=
 =?utf-8?B?Vk9lR3pEVHNIWm5vK2pYcUJzL0xLaXFteTcwenVtTHVqelE2K3dzcjdMMWRo?=
 =?utf-8?B?ZWMrZ2EwT1c3c0c2VW9DNWt0VTJjZlYxT2FWS1BKNDdyczlHbTVMUnE3aFgy?=
 =?utf-8?B?S1RDbFNDZWRHTWFraUxSZTRnbit5N2IvdCt3ZHlDK29ka0N2LzN1NVQ3UHgy?=
 =?utf-8?B?clF1MUtRQUlFaWxqd0dscmNBWFd2UlAxZjFETTlGZFpTek1CQlVBZnlPOEhN?=
 =?utf-8?B?MlQvTDhjN216bjl3UzBXbUJLZmc3WVhOcFNwK25ibE5OcDJDZGhPcTY5RVA2?=
 =?utf-8?B?aWdySW1xclIxdG1kTnVRalZlbWRLZXo0VVBsNWhTcDdwYVBKT3RBZnF4ZzM0?=
 =?utf-8?B?cWRhL3oxcVFEeDhQNWdtQzgrVzdNT1JzU0tkN0dXOEJ0Nzd0Y3JaUWVKdGVw?=
 =?utf-8?B?OVhMT0xlY1kxYzd0YTFsQmNiUHdqUnlRaGl0TWhxWFdFZmNhQjM0UFFFVHVw?=
 =?utf-8?B?dFBhQ1R4RDBodHBIMCtQalN4NWlnK0JvUDRPRGpaNVRjY3RSOEdLTkQ2ZVB1?=
 =?utf-8?B?dnZRdzRJU3l6WXd6Y0FTSWtob3IwbnN3b1duR3hERTVpV1p1KzJNQjVtZ25G?=
 =?utf-8?B?OGorL2tZNmZjSFE5SnVOcTBOSFRWTjR1MWJjQkI4N1JqV3pnVVlIWkkyeXVa?=
 =?utf-8?B?UmwxYkd0Z2pJRmg0bzgwUEdaVFRuMlVHZWNGeFdZZzZ2K3BKYjVwMGh3TS9G?=
 =?utf-8?B?SDUrSmlnMTVPakQ1WlRQZ2NjV1RkTXR3K1BtWFBOUEkxZEdCbmlOT1pYL1FS?=
 =?utf-8?B?ajk0UHh1ZmtZWWg1eitZak05SGhmTHpEek1iSHd3K3UzUERXYnpiVUFMajNV?=
 =?utf-8?B?WWdVbVlXUGdmOWJuR24vWDZ2Tkpab1IrSWREMS9uV0VlWGQ0YjFNZmUzejlV?=
 =?utf-8?B?UUMvV3BwSUFFdUNlSVN5WTN3UlErM2xYNmlUZk5tYVlyTVd1d0NjNU9sYkpo?=
 =?utf-8?B?MExiTlFNVEEyVFJha3NZaDhHdU9JTG95UzhIR1RKbDM2Y1lkYllYSDVVQ05n?=
 =?utf-8?B?ZUVEbmUyb0hXd2l1c2kzZnVuQzhlMTF1LzBOeER6ZkxSWlNZMXE4cHN5SzBG?=
 =?utf-8?B?OTYrejU2ZG0yYVFNa0JjazhxdFlxYzRmYjV0Ujl3b3lsL2EwNy91MDA3U3RM?=
 =?utf-8?B?L1FFbjdMYWRiWmpuUlpOSU84RFBsV3BTZ1hmL2xhWTExRm5OK0EyWnRFT2pL?=
 =?utf-8?B?NDcxVUVIM0FFSnIyRWptdUE5ZGxXRHplRldxeHNSc0JjcUJTdVl6dUtsRzlS?=
 =?utf-8?B?clh4Yk5pRlpYZ1FraEZMY1JNNjZNWmtIV3RwMkh6YlFIZkVOcmU1UXVqWHNm?=
 =?utf-8?B?Z095TUJybXZUTEg3dGRQSE41dTFNeTIwaGVyZEI1cWFWU240Tld6MzZyUnly?=
 =?utf-8?B?VnN5b3lNNEM1dlUxaEw0Zy9uV1pSaDc1SkY5TkE3RWFqSHZQNUlMNW5QcVhH?=
 =?utf-8?B?NjhMMVd3TnA2Skp6RWdsY0tFM1VXV2E0UHZvbUZMTEsxcmc0WitDWHM4cVQ0?=
 =?utf-8?B?WGVlanVnZUVITDJCdlp1RDFCVDk4WUtFQWl6YzkwRE1uQjF4UTUxckwrd1VH?=
 =?utf-8?B?RzBEVVZQZHlON2xOQ3JLM1NGa3ZSSVU0MHQvL0s0T1NoOUkxd3FQalFrVzRF?=
 =?utf-8?B?dDYybXBYdjh1aG00cGJBeHRROWE5YmRKa2plaHA3SENtNXd3ei9Vdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9af8a0-66c8-4ada-d252-08df3141f796
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:30.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXEUHixJnZj4AKKrUYAWSt+sYuTghmPSRikeX+hCT8zZlKO0EI6fBikMSpwpX4zzlGAP29Ujz7C5HpJr+aZC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6107
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=parthiban@linumiz.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TC39x SoC with the TC397B memory map: 6x 240K DSPR, 6x 64K PSPR,
6 flash banks, DLMU, LMU, 4M EMEM.  Only CPU0 runs.  Same
peripheral wiring pattern as tc27x.

Originally-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Originally-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/tricore/Kconfig              |   7 +
 hw/tricore/meson.build          |   1 +
 hw/tricore/tc39xb_soc.c         | 338 ++++++++++++++++++++++++++++++++++++++++
 hw/tricore/triboard.c           |  32 +++-
 include/hw/tricore/tc39xb_soc.h | 110 +++++++++++++
 include/hw/tricore/triboard.h   |   2 +
 6 files changed, 489 insertions(+), 1 deletion(-)

diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index 9e312495e5..79b4731cff 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -8,6 +8,7 @@ config TRIBOARD
     default y
     depends on TRICORE
     select TC27X_SOC
+    select TC39X_SOC
 
 config TC27X_SOC
     bool
@@ -15,5 +16,11 @@ config TC27X_SOC
     select TRICORE_SCU
     select TRICORE_STM
 
+config TC39X_SOC
+    bool
+    select TRICORE_ASCLIN
+    select TRICORE_SCU
+    select TRICORE_STM
+
 config TRICORE_SCU
     bool
diff --git a/hw/tricore/meson.build b/hw/tricore/meson.build
index 86c8c8dd9f..96e367f996 100644
--- a/hw/tricore/meson.build
+++ b/hw/tricore/meson.build
@@ -3,6 +3,7 @@ tricore_ss.add(when: 'CONFIG_TRICORE_TESTBOARD', if_true: files('tricore_testboa
 tricore_ss.add(when: 'CONFIG_TRICORE_TESTBOARD', if_true: files('tricore_testdevice.c'))
 tricore_ss.add(when: 'CONFIG_TRIBOARD', if_true: files('triboard.c'))
 tricore_ss.add(when: 'CONFIG_TC27X_SOC', if_true: files('tc27x_soc.c'))
+tricore_ss.add(when: 'CONFIG_TC39X_SOC', if_true: files('tc39xb_soc.c'))
 tricore_ss.add(when: 'CONFIG_TRICORE_SCU', if_true: files('tricore_scu.c'))
 
 hw_arch += {'tricore': tricore_ss}
diff --git a/hw/tricore/tc39xb_soc.c b/hw/tricore/tc39xb_soc.c
new file mode 100644
index 0000000000..cecca7d94c
--- /dev/null
+++ b/hw/tricore/tc39xb_soc.c
@@ -0,0 +1,338 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Infineon TC39x SoC System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
+#include "qemu/units.h"
+#include "system/system.h"
+
+#include "hw/tricore/tc39xb_soc.h"
+#include "hw/tricore/tc27x_soc.h"
+
+const MemmapEntry tc39xb_soc_memmap[] = {
+    [TC39XB_DSPR5]     = { 0x10000000,            240 * KiB },
+    [TC39XB_DCACHE5]   = { 0x10018000,             16 * KiB },
+    [TC39XB_DTAG5]     = { 0x100C0000,              6 * KiB },
+    [TC39XB_PSPR5]     = { 0x10100000,             64 * KiB },
+    [TC39XB_PCACHE5]   = { 0x10108000,             32 * KiB },
+    [TC39XB_PTAG5]     = { 0x101C0000,             12 * KiB },
+    [TC39XB_DSPR4]     = { 0x30000000,            240 * KiB },
+    [TC39XB_DCACHE4]   = { 0x30018000,             16 * KiB },
+    [TC39XB_DTAG4]     = { 0x300C0000,              6 * KiB },
+    [TC39XB_PSPR4]     = { 0x30100000,             64 * KiB },
+    [TC39XB_PCACHE4]   = { 0x30108000,             32 * KiB },
+    [TC39XB_PTAG4]     = { 0x301C0000,             12 * KiB },
+    [TC39XB_DSPR3]     = { 0x40000000,            240 * KiB },
+    [TC39XB_DCACHE3]   = { 0x40018000,             16 * KiB },
+    [TC39XB_DTAG3]     = { 0x400C0000,              6 * KiB },
+    [TC39XB_PSPR3]     = { 0x40100000,             64 * KiB },
+    [TC39XB_PCACHE3]   = { 0x40108000,             32 * KiB },
+    [TC39XB_PTAG3]     = { 0x401C0000,             12 * KiB },
+    [TC39XB_DSPR2]     = { 0x50000000,            240 * KiB },
+    [TC39XB_DCACHE2]   = { 0x5001E000,             16 * KiB },
+    [TC39XB_DTAG2]     = { 0x500C0000,              6 * KiB },
+    [TC39XB_PSPR2]     = { 0x50100000,             64 * KiB },
+    [TC39XB_PCACHE2]   = { 0x50108000,             32 * KiB },
+    [TC39XB_PTAG2]     = { 0x501C0000,             12 * KiB },
+    [TC39XB_DSPR1]     = { 0x60000000,            240 * KiB },
+    [TC39XB_DCACHE1]   = { 0x6001E000,             16 * KiB },
+    [TC39XB_DTAG1]     = { 0x600C0000,              6 * KiB },
+    [TC39XB_PSPR1]     = { 0x60100000,             64 * KiB },
+    [TC39XB_PCACHE1]   = { 0x60108000,             32 * KiB },
+    [TC39XB_PTAG1]     = { 0x601C0000,             12 * KiB },
+    [TC39XB_DSPR0]     = { 0x70000000,            240 * KiB },
+    [TC39XB_DCACHE0]   = { 0x7001E000,             16 * KiB },
+    [TC39XB_DTAG0]     = { 0x700C0000,              6 * KiB },
+    [TC39XB_PSPR0]     = { 0x70100000,             64 * KiB },
+    [TC39XB_PCACHE0]   = { 0x70108000,             32 * KiB },
+    [TC39XB_PTAG0]     = { 0x701C0000,             12 * KiB },
+    [TC39XB_PFLASH0_C] = { 0x80000000,              3 * MiB },
+    [TC39XB_PFLASH1_C] = { 0x80300000,              3 * MiB },
+    [TC39XB_PFLASH2_C] = { 0x80600000,              3 * MiB },
+    [TC39XB_PFLASH3_C] = { 0x80900000,              3 * MiB },
+    [TC39XB_PFLASH4_C] = { 0x80C00000,              3 * MiB },
+    [TC39XB_PFLASH5_C] = { 0x80F00000,              1 * MiB },
+    [TC39XB_OLDA_C]    = { 0x8FE00000,            512 * KiB },
+    [TC39XB_BROM_C]    = { 0x8FFF0000,             64 * KiB },
+    [TC39XB_DLMU0_C]   = { 0x90000000,             64 * KiB },
+    [TC39XB_DLMU1_C]   = { 0x90010000,             64 * KiB },
+    [TC39XB_DLMU2_C]   = { 0x90020000,             64 * KiB },
+    [TC39XB_DLMU3_C]   = { 0x90030000,             64 * KiB },
+    [TC39XB_LMU0_C]    = { 0x90040000,            256 * KiB },
+    [TC39XB_LMU1_C]    = { 0x90080000,            256 * KiB },
+    [TC39XB_LMU2_C]    = { 0x900C0000,            256 * KiB },
+    [TC39XB_DLMU4_C]   = { 0x90100000,             64 * KiB },
+    [TC39XB_DLMU5_C]   = { 0x90110000,             64 * KiB },
+    [TC39XB_EMEM]      = { 0x99000000,              4 * MiB },
+    [TC39XB_PFLASH0_U] = { 0xA0000000,                  0x0 },
+    [TC39XB_PFLASH1_U] = { 0xA0300000,                  0x0 },
+    [TC39XB_PFLASH2_U] = { 0xA0600000,                  0x0 },
+    [TC39XB_PFLASH3_U] = { 0xA0900000,                  0x0 },
+    [TC39XB_PFLASH4_U] = { 0xA0C00000,                  0x0 },
+    [TC39XB_PFLASH5_U] = { 0xA0F00000,                  0x0 },
+    [TC39XB_DFLASH0]   = { 0xAF000000,              1 * MiB },
+    [TC39XB_DFLASH1]   = { 0xAFC00000,            128 * KiB },
+    [TC39XB_OLDA_U]    = { 0xAFE00000,                  0x0 },
+    [TC39XB_BROM_U]    = { 0xAFFF0000,                  0x0 },
+    [TC39XB_DLMU0_U]   = { 0xB0000000,                  0x0 },
+    [TC39XB_DLMU1_U]   = { 0xB0010000,                  0x0 },
+    [TC39XB_DLMU2_U]   = { 0xB0020000,                  0x0 },
+    [TC39XB_DLMU3_U]   = { 0xB0030000,                  0x0 },
+    [TC39XB_LMU0_U]    = { 0xB0040000,                  0x0 },
+    [TC39XB_LMU1_U]    = { 0xB0080000,                  0x0 },
+    [TC39XB_LMU2_U]    = { 0xB00C0000,                  0x0 },
+    [TC39XB_DLMU4_U]   = { 0xB0100000,                  0x0 },
+    [TC39XB_DLMU5_U]   = { 0xB0110000,                  0x0 },
+    [TC39XB_PSPRX]     = { 0xC0000000,                  0x0 },
+    [TC39XB_DSPRX]     = { 0xD0000000,                  0x0 },
+    [TC39XB_STM0]      = { 0xF0001000,                  0x0 },
+    [TC39XB_ASCLIN0]   = { 0xF0000600,                  0x0 },
+    [TC39XB_SCU]       = { 0xF0036000,                  0x0 },
+};
+
+static void make_rom(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void make_ram(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void make_alias(MemoryRegion *mr, const char *name,
+                       MemoryRegion *orig, hwaddr base)
+{
+    memory_region_init_alias(mr, NULL, name, orig, 0,
+                             memory_region_size(orig));
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void tc39xb_soc_init_memory_mapping(DeviceState *dev_soc)
+{
+    TC39XBSoCState *s = TC39XB_SOC(dev_soc);
+    TC39XBSoCClass *sc = TC39XB_SOC_GET_CLASS(s);
+    const MemmapEntry *map = sc->memmap;
+    TC39XBSoCCPUMemState *c0 = &s->cpu0mem;
+    TC39XBSoCCPUMemState *c1 = &s->cpu1mem;
+    TC39XBSoCCPUMemState *c2 = &s->cpu2mem;
+    TC39XBSoCCPUMemState *c3 = &s->cpu3mem;
+    TC39XBSoCCPUMemState *c4 = &s->cpu4mem;
+    TC39XBSoCCPUMemState *c5 = &s->cpu5mem;
+    TC39XBSoCFlashMemState *f = &s->flashmem;
+
+    /* CPU scratch-pad memories */
+    make_ram(&c0->dspr, "CPU0.DSPR",
+             map[TC39XB_DSPR0].base, map[TC39XB_DSPR0].size);
+    make_ram(&c0->pspr, "CPU0.PSPR",
+             map[TC39XB_PSPR0].base, map[TC39XB_PSPR0].size);
+    make_ram(&c1->dspr, "CPU1.DSPR",
+             map[TC39XB_DSPR1].base, map[TC39XB_DSPR1].size);
+    make_ram(&c1->pspr, "CPU1.PSPR",
+             map[TC39XB_PSPR1].base, map[TC39XB_PSPR1].size);
+    make_ram(&c2->dspr, "CPU2.DSPR",
+             map[TC39XB_DSPR2].base, map[TC39XB_DSPR2].size);
+    make_ram(&c2->pspr, "CPU2.PSPR",
+             map[TC39XB_PSPR2].base, map[TC39XB_PSPR2].size);
+    make_ram(&c3->dspr, "CPU3.DSPR",
+             map[TC39XB_DSPR3].base, map[TC39XB_DSPR3].size);
+    make_ram(&c3->pspr, "CPU3.PSPR",
+             map[TC39XB_PSPR3].base, map[TC39XB_PSPR3].size);
+    make_ram(&c4->dspr, "CPU4.DSPR",
+             map[TC39XB_DSPR4].base, map[TC39XB_DSPR4].size);
+    make_ram(&c4->pspr, "CPU4.PSPR",
+             map[TC39XB_PSPR4].base, map[TC39XB_PSPR4].size);
+    make_ram(&c5->dspr, "CPU5.DSPR",
+             map[TC39XB_DSPR5].base, map[TC39XB_DSPR5].size);
+    make_ram(&c5->pspr, "CPU5.PSPR",
+             map[TC39XB_PSPR5].base, map[TC39XB_PSPR5].size);
+
+    /*
+     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
+     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
+     */
+    make_alias(&s->psprX, "LOCAL.PSPR",
+               &c0->pspr, map[TC39XB_PSPRX].base);
+    make_alias(&s->dsprX, "LOCAL.DSPR",
+               &c0->dspr, map[TC39XB_DSPRX].base);
+
+    /* Program flash (6 banks) */
+    make_ram(&c0->pflash_c, "PF0",
+             map[TC39XB_PFLASH0_C].base, map[TC39XB_PFLASH0_C].size);
+    make_ram(&c1->pflash_c, "PF1",
+             map[TC39XB_PFLASH1_C].base, map[TC39XB_PFLASH1_C].size);
+    make_ram(&c2->pflash_c, "PF2",
+             map[TC39XB_PFLASH2_C].base, map[TC39XB_PFLASH2_C].size);
+    make_ram(&c3->pflash_c, "PF3",
+             map[TC39XB_PFLASH3_C].base, map[TC39XB_PFLASH3_C].size);
+    make_ram(&c4->pflash_c, "PF4",
+             map[TC39XB_PFLASH4_C].base, map[TC39XB_PFLASH4_C].size);
+    make_ram(&c5->pflash_c, "PF5",
+             map[TC39XB_PFLASH5_C].base, map[TC39XB_PFLASH5_C].size);
+
+    /* DLMU (per-CPU local memory) */
+    make_ram(&c0->dlmu_c, "DLMU0",
+             map[TC39XB_DLMU0_C].base, map[TC39XB_DLMU0_C].size);
+    make_ram(&c1->dlmu_c, "DLMU1",
+             map[TC39XB_DLMU1_C].base, map[TC39XB_DLMU1_C].size);
+    make_ram(&c2->dlmu_c, "DLMU2",
+             map[TC39XB_DLMU2_C].base, map[TC39XB_DLMU2_C].size);
+    make_ram(&c3->dlmu_c, "DLMU3",
+             map[TC39XB_DLMU3_C].base, map[TC39XB_DLMU3_C].size);
+    make_ram(&c4->dlmu_c, "DLMU4",
+             map[TC39XB_DLMU4_C].base, map[TC39XB_DLMU4_C].size);
+    make_ram(&c5->dlmu_c, "DLMU5",
+             map[TC39XB_DLMU5_C].base, map[TC39XB_DLMU5_C].size);
+
+    /* Shared memories */
+    make_ram(&f->dflash0, "DF0",
+             map[TC39XB_DFLASH0].base, map[TC39XB_DFLASH0].size);
+    make_ram(&f->dflash1, "DF1",
+             map[TC39XB_DFLASH1].base, map[TC39XB_DFLASH1].size);
+    make_ram(&f->olda_c, "OLDA",
+             map[TC39XB_OLDA_C].base, map[TC39XB_OLDA_C].size);
+    make_rom(&f->brom_c, "BROM",
+             map[TC39XB_BROM_C].base, map[TC39XB_BROM_C].size);
+    make_ram(&f->lmu0_c, "LMU0",
+             map[TC39XB_LMU0_C].base, map[TC39XB_LMU0_C].size);
+    make_ram(&f->lmu1_c, "LMU1",
+             map[TC39XB_LMU1_C].base, map[TC39XB_LMU1_C].size);
+    make_ram(&f->lmu2_c, "LMU2",
+             map[TC39XB_LMU2_C].base, map[TC39XB_LMU2_C].size);
+    make_ram(&f->emem, "EMEM",
+             map[TC39XB_EMEM].base, map[TC39XB_EMEM].size);
+
+    /* Uncached aliases for program flash */
+    make_alias(&c0->pflash_u, "PF0.U",
+               &c0->pflash_c, map[TC39XB_PFLASH0_U].base);
+    make_alias(&c1->pflash_u, "PF1.U",
+               &c1->pflash_c, map[TC39XB_PFLASH1_U].base);
+    make_alias(&c2->pflash_u, "PF2.U",
+               &c2->pflash_c, map[TC39XB_PFLASH2_U].base);
+    make_alias(&c3->pflash_u, "PF3.U",
+               &c3->pflash_c, map[TC39XB_PFLASH3_U].base);
+    make_alias(&c4->pflash_u, "PF4.U",
+               &c4->pflash_c, map[TC39XB_PFLASH4_U].base);
+    make_alias(&c5->pflash_u, "PF5.U",
+               &c5->pflash_c, map[TC39XB_PFLASH5_U].base);
+
+    /* Uncached aliases for DLMU */
+    make_alias(&c0->dlmu_u, "DLMU0.U",
+               &c0->dlmu_c, map[TC39XB_DLMU0_U].base);
+    make_alias(&c1->dlmu_u, "DLMU1.U",
+               &c1->dlmu_c, map[TC39XB_DLMU1_U].base);
+    make_alias(&c2->dlmu_u, "DLMU2.U",
+               &c2->dlmu_c, map[TC39XB_DLMU2_U].base);
+    make_alias(&c3->dlmu_u, "DLMU3.U",
+               &c3->dlmu_c, map[TC39XB_DLMU3_U].base);
+    make_alias(&c4->dlmu_u, "DLMU4.U",
+               &c4->dlmu_c, map[TC39XB_DLMU4_U].base);
+    make_alias(&c5->dlmu_u, "DLMU5.U",
+               &c5->dlmu_c, map[TC39XB_DLMU5_U].base);
+
+    /* Uncached aliases for shared memories */
+    make_alias(&f->olda_u, "OLDA.U",
+               &f->olda_c, map[TC39XB_OLDA_U].base);
+    make_alias(&f->brom_u, "BROM.U",
+               &f->brom_c, map[TC39XB_BROM_U].base);
+    make_alias(&f->lmu0_u, "LMU0.U",
+               &f->lmu0_c, map[TC39XB_LMU0_U].base);
+    make_alias(&f->lmu1_u, "LMU1.U",
+               &f->lmu1_c, map[TC39XB_LMU1_U].base);
+    make_alias(&f->lmu2_u, "LMU2.U",
+               &f->lmu2_c, map[TC39XB_LMU2_U].base);
+}
+
+static void tc39xb_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    TC39XBSoCState *s = TC39XB_SOC(dev_soc);
+    TC39XBSoCClass *sc = TC39XB_SOC_GET_CLASS(s);
+    Clock *fstm;
+    Error *err = NULL;
+
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    tc39xb_soc_init_memory_mapping(dev_soc);
+
+    /* STM clock: 50 MHz */
+    fstm = clock_new(OBJECT(dev_soc), "fstm");
+    clock_set_hz(fstm, 50000000);
+    qdev_connect_clock_in(DEVICE(&s->stm), "fstm", fstm);
+
+    qdev_prop_set_chr(DEVICE(&s->asclin), "chardev", serial_hd(0));
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->stm), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->asclin), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->stm), 0,
+                    sc->memmap[TC39XB_STM0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->asclin), 0,
+                    sc->memmap[TC39XB_ASCLIN0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[TC39XB_SCU].base);
+}
+
+static void tc39xb_soc_init(Object *obj)
+{
+    TC39XBSoCState *s = TC39XB_SOC(obj);
+    TC39XBSoCClass *sc = TC39XB_SOC_GET_CLASS(s);
+
+    object_initialize_child(obj, "tc39x", &s->cpu, sc->cpu_type);
+    object_initialize_child(obj, "stm", &s->stm, TYPE_TRICORE_STM);
+    object_initialize_child(obj, "asclin", &s->asclin, TYPE_TRICORE_ASCLIN);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_TRICORE_SCU);
+}
+
+static void tc39xb_soc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = tc39xb_soc_realize;
+}
+
+static void tc397b_soc_class_init(ObjectClass *oc, const void *data)
+{
+    TC39XBSoCClass *sc = TC39XB_SOC_CLASS(oc);
+
+    sc->name     = "tc397b-soc";
+    sc->cpu_type = TRICORE_CPU_TYPE_NAME("tc39x");
+    sc->memmap   = tc39xb_soc_memmap;
+    sc->num_cpus = 1;
+}
+
+static const TypeInfo tc39xb_soc_types[] = {
+    {
+        .name          = "tc397b-soc",
+        .parent        = TYPE_TC39XB_SOC,
+        .class_init    = tc397b_soc_class_init,
+    }, {
+        .name          = TYPE_TC39XB_SOC,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(TC39XBSoCState),
+        .instance_init = tc39xb_soc_init,
+        .class_size    = sizeof(TC39XBSoCClass),
+        .class_init    = tc39xb_soc_class_init,
+        .abstract      = true,
+    },
+};
+
+DEFINE_TYPES(tc39xb_soc_types)
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 23f11cf0a1..c16a6bc8f7 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -64,6 +64,20 @@ static void triboard_machine_init(MachineState *machine)
     }
 }
 
+static void triboard_machine_tc397b_init(MachineState *machine)
+{
+    TriBoardMachineState *ms = TRIBOARD_MACHINE(machine);
+    TriBoardMachineClass *amc = TRIBOARD_MACHINE_GET_CLASS(machine);
+
+    object_initialize_child(OBJECT(machine), "soc", &ms->tc39xb_soc,
+                            amc->soc_name);
+    sysbus_realize(SYS_BUS_DEVICE(&ms->tc39xb_soc), &error_fatal);
+
+    if (machine->kernel_filename) {
+        tricore_load_kernel(&ms->tc39xb_soc.cpu, machine->kernel_filename);
+    }
+}
+
 static void triboard_machine_tc277d_class_init(ObjectClass *oc,
                                                const void *data)
 {
@@ -74,13 +88,29 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
     amc->soc_name   = "tc277d-soc";
-};
+}
+
+static void triboard_machine_tc397b_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    TriBoardMachineClass *amc = TRIBOARD_MACHINE_CLASS(oc);
+
+    mc->init        = triboard_machine_tc397b_init;
+    mc->desc        = "Infineon AURIX TriBoard TC397 (B-Step)";
+    mc->max_cpus    = 1;
+    amc->soc_name   = "tc397b-soc";
+}
 
 static const TypeInfo triboard_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("KIT_AURIX_TC277_TRB"),
         .parent         = TYPE_TRIBOARD_MACHINE,
         .class_init     = triboard_machine_tc277d_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("KIT_AURIX_TC397_TRB"),
+        .parent         = TYPE_TRIBOARD_MACHINE,
+        .class_init     = triboard_machine_tc397b_class_init,
     }, {
         .name           = TYPE_TRIBOARD_MACHINE,
         .parent         = TYPE_MACHINE,
diff --git a/include/hw/tricore/tc39xb_soc.h b/include/hw/tricore/tc39xb_soc.h
new file mode 100644
index 0000000000..b0a9562e48
--- /dev/null
+++ b/include/hw/tricore/tc39xb_soc.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Infineon TC39x SoC System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ */
+
+#ifndef TC39XB_SOC_H
+#define TC39XB_SOC_H
+
+#include "hw/core/sysbus.h"
+#include "hw/char/tricore_asclin.h"
+#include "hw/timer/tricore_stm.h"
+#include "hw/tricore/tricore_scu.h"
+#include "target/tricore/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_TC39XB_SOC ("tc39xb-soc")
+OBJECT_DECLARE_TYPE(TC39XBSoCState, TC39XBSoCClass, TC39XB_SOC)
+
+typedef struct TC39XBSoCCPUMemState {
+    MemoryRegion dspr;
+    MemoryRegion pspr;
+    MemoryRegion pflash_c;
+    MemoryRegion pflash_u;
+    MemoryRegion dlmu_c;
+    MemoryRegion dlmu_u;
+} TC39XBSoCCPUMemState;
+
+typedef struct TC39XBSoCFlashMemState {
+    MemoryRegion dflash0;
+    MemoryRegion dflash1;
+    MemoryRegion olda_c;
+    MemoryRegion olda_u;
+    MemoryRegion brom_c;
+    MemoryRegion brom_u;
+    MemoryRegion lmu0_c;
+    MemoryRegion lmu0_u;
+    MemoryRegion lmu1_c;
+    MemoryRegion lmu1_u;
+    MemoryRegion lmu2_c;
+    MemoryRegion lmu2_u;
+    MemoryRegion emem;
+} TC39XBSoCFlashMemState;
+
+typedef struct MemmapEntry MemmapEntry;
+
+typedef struct TC39XBSoCState {
+    SysBusDevice parent_obj;
+
+    TriCoreCPU cpu;
+    TriCoreSTMState stm;
+    TriCoreASCLINState asclin;
+    TriCoreSCUState scu;
+
+    MemoryRegion dsprX;
+    MemoryRegion psprX;
+
+    TC39XBSoCCPUMemState cpu0mem;
+    TC39XBSoCCPUMemState cpu1mem;
+    TC39XBSoCCPUMemState cpu2mem;
+    TC39XBSoCCPUMemState cpu3mem;
+    TC39XBSoCCPUMemState cpu4mem;
+    TC39XBSoCCPUMemState cpu5mem;
+
+    TC39XBSoCFlashMemState flashmem;
+} TC39XBSoCState;
+
+typedef struct TC39XBSoCClass {
+    DeviceClass parent_class;
+
+    const char *name;
+    const char *cpu_type;
+    const MemmapEntry *memmap;
+    uint32_t num_cpus;
+} TC39XBSoCClass;
+
+enum {
+    TC39XB_DSPR5, TC39XB_DCACHE5, TC39XB_DTAG5,
+    TC39XB_PSPR5, TC39XB_PCACHE5, TC39XB_PTAG5,
+    TC39XB_DSPR4, TC39XB_DCACHE4, TC39XB_DTAG4,
+    TC39XB_PSPR4, TC39XB_PCACHE4, TC39XB_PTAG4,
+    TC39XB_DSPR3, TC39XB_DCACHE3, TC39XB_DTAG3,
+    TC39XB_PSPR3, TC39XB_PCACHE3, TC39XB_PTAG3,
+    TC39XB_DSPR2, TC39XB_DCACHE2, TC39XB_DTAG2,
+    TC39XB_PSPR2, TC39XB_PCACHE2, TC39XB_PTAG2,
+    TC39XB_DSPR1, TC39XB_DCACHE1, TC39XB_DTAG1,
+    TC39XB_PSPR1, TC39XB_PCACHE1, TC39XB_PTAG1,
+    TC39XB_DSPR0, TC39XB_DCACHE0, TC39XB_DTAG0,
+    TC39XB_PSPR0, TC39XB_PCACHE0, TC39XB_PTAG0,
+    TC39XB_PFLASH0_C, TC39XB_PFLASH1_C, TC39XB_PFLASH2_C,
+    TC39XB_PFLASH3_C, TC39XB_PFLASH4_C, TC39XB_PFLASH5_C,
+    TC39XB_OLDA_C, TC39XB_BROM_C,
+    TC39XB_DLMU0_C, TC39XB_DLMU1_C, TC39XB_DLMU2_C,
+    TC39XB_DLMU3_C, TC39XB_LMU0_C, TC39XB_LMU1_C,
+    TC39XB_LMU2_C, TC39XB_DLMU4_C, TC39XB_DLMU5_C,
+    TC39XB_EMEM,
+    TC39XB_PFLASH0_U, TC39XB_PFLASH1_U, TC39XB_PFLASH2_U,
+    TC39XB_PFLASH3_U, TC39XB_PFLASH4_U, TC39XB_PFLASH5_U,
+    TC39XB_DFLASH0, TC39XB_DFLASH1,
+    TC39XB_OLDA_U, TC39XB_BROM_U,
+    TC39XB_DLMU0_U, TC39XB_DLMU1_U, TC39XB_DLMU2_U,
+    TC39XB_DLMU3_U, TC39XB_LMU0_U, TC39XB_LMU1_U,
+    TC39XB_LMU2_U, TC39XB_DLMU4_U, TC39XB_DLMU5_U,
+    TC39XB_PSPRX, TC39XB_DSPRX,
+    TC39XB_STM0, TC39XB_ASCLIN0, TC39XB_SCU,
+};
+
+#endif
diff --git a/include/hw/tricore/triboard.h b/include/hw/tricore/triboard.h
index c6be4dc3f3..bc84c26f32 100644
--- a/include/hw/tricore/triboard.h
+++ b/include/hw/tricore/triboard.h
@@ -25,6 +25,7 @@
 #include "qom/object.h"
 
 #include "hw/tricore/tc27x_soc.h"
+#include "hw/tricore/tc39xb_soc.h"
 
 #define TYPE_TRIBOARD_MACHINE MACHINE_TYPE_NAME("triboard")
 typedef struct TriBoardMachineState TriBoardMachineState;
@@ -37,6 +38,7 @@ struct TriBoardMachineState {
     MachineState parent;
 
     TC27XSoCState tc27x_soc;
+    TC39XBSoCState tc39xb_soc;
 };
 
 struct TriBoardMachineClass {

-- 
2.47.3


