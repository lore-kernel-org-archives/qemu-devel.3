Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D327606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=EwrjzXhL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1bC-0007JE-I3; Sun, 08 Nov 2026 07:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aU-0006lI-D4; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aS-0000Wc-Hm; Sun, 08 Nov 2026 07:01:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTZHBbdZyeeyUkQy8NCk2eN+9gocAr6L9f50jhupNdd/Jllg2380w9FYrl7f7VpDQHRkT92XbTf/7bKMTsIklKshfAAVrso1Vylh01/b3sXNl19XCu5TK4FvC8hxLH47SKjnE7/cV8yrrcJgpycxXxzjj9UlCnUcySloJhtFriuK8lJ4qQtbzB68ujyrfEm8POrHpDnK+u3Mr8q7EwSxh4IZvIClfqvaVOhBCDZBKsCD5ZdR7Uax7MYzfh4OJOtZCyzLIaO1wkF0NiJOMnE/b0rFFMpjfUdNJH8Z1PS9tNxW1IKSV/6Dze+qGABif6TLn7EGNava1ZhzCfltNzwy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVbGFTWADzYeXgjsQj751XExW4hHg8kVZ508CoM/EMM=;
 b=yD99glDcQMS99OQN8AlDR5b/w4sdlHrBSwRBiv1KMVDjlD5nXaAqqRVRbHDpi/NI3xzEH7PZIp8b+feGNSiV01gdbHNPox8t7vU/XgkIQJvLfvKayYHfoD8G/vAOCD6R85YheZP1Nt67umECt67qpNvHjI3MFdynuD3QcJUek+KrWEOR7MfHt81uiTmudaI7B8ZiaKL6rUFDbEk4Ilxg/7Pq1/v8oVXWJ8jszRxj2tf/Garu836wamD0k476CCrBGeC78LxmFLL+HG3lb7SJ9F4BZyiR2QB9P9u4uWdJ7TISfh6GEDR/Z708g8WVj11z+PFeIwr0lWeX7Gebw11S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVbGFTWADzYeXgjsQj751XExW4hHg8kVZ508CoM/EMM=;
 b=EwrjzXhLVFPcaxLELO/39C3YVerUZjL7F/JP7QtNAu5FPgQN3zCdzfotVI9CNt64FNTtPTuXBV/ciaLY8EipG+s/gK6pyPfAFRsBnAOLmPX3IZR4wtL8Aw2X6kmaU3N5NDlIKeYNc2vvSwXRKZHKVvZBU2VlVK2/jkxiDOV4b8wDxqam/W/CUAwYazS6uCQok27fHq9ULT9n7VJzx66uqIQFP6qNAOci/gRKN3rO/CRiEtK9xdCvOqdxf3Gu5zRrI/rtrKLGYAV+Ifdo0H58yFJ9GYUchhOARfuP+tSJKBdDDWT0nfWayYnnPhoF2ca76Mea5chyNd9gQTHFBwD6+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:14 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 08/23] target/ppc: Register L2CFG0 and L2CSR1 on e500mc and
 e5500
Date: Sun,  8 Nov 2026 20:00:07 +0800
Message-ID: <20261108120034.1755008-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b74a0d6-0ef4-46f4-13a0-08df3d8ffd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|3023799007|261102123227099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: /fFblHDR8/8QGcwPT+b+uihplwBa1zuiaLpJTOsrBTUS0BKuOVD0LtJVwSGK4ynVDysF0N66NAZWEQ8cyovCj5EZH23gTSILVWL7F9PurnCzjY3zz3kwnU+Zp9lCjYdNNf9vBbo9BxiqVLJM6D9cuWiPXZAJHebOqd7YYhDZ2yMzZXL6AHWQF6xkJ6E/VxaGXADpO1FTHHwYpCa/hNLdUbQ0+hfK7340SFMhl70MKt081Dpv9rR9cRodGxy5QdP8TFadhUW26MnhGwG0hP/huleS0dlTU4bA/Yq8ZcaYwmI11GcBTDe5WsClDf5GnXa5m1P1PK4l/LpO39Vt3UH+oDcAshaAkfmJs7uYc9MyfAH1bav6J7LKvGKRlpswq2jHMZ/dGPpblDGNmhGFo3j9JR0+RP3EcAGcBDuxKVBhp46GA4kVgGzXTA9Gfd1B8+BUppbTpHQdP790vmQVVLa2hzEY52eX0XwD/3wJ44NHq4Q0znw/i7RSr+PdRDY3XdF76ZRyDoLYsQBRf+7S8gipZ8WTwnowG6GgxXaA/mphJYOYEODej1O81QH/k99Y44BjWjUWoNv1XRZcK4v2S4qSG39E8zjh2gHeSkF4UZSpZXg6IB74ahMb4tpoJDbqNcP3SXPywuuGLo2U0dzQpw034M1ZfcSe+4r/01/IrU6zRJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2gwn7nKa1Nv102gRzlonBSPzn0njEVM4INC6PhUhP6PmS6dH3dmNFMyzUsR?=
 =?us-ascii?Q?poyYn45oIPSbQwFJkrlbce0UMrZYTZOguFzKIHNJZ+1FUEvXJj248iutblee?=
 =?us-ascii?Q?x7GGhYRfNm1qRA4RY3s9bRaD7MnsS90XUim8RaEW6+Lg0TrxYe/MJ00gplyI?=
 =?us-ascii?Q?otDMNC9fNebf2PpRDRyJMrNE28/LYpbrDibBgmTuCdhfVMfhNgFHRoAzqUvI?=
 =?us-ascii?Q?4AljbNNxbh0e/ZRA6ITOq70ZWlIE/nZx5OH4ojRgJzUbnhcWTmZjMp/xWv0Z?=
 =?us-ascii?Q?sU3U+6LH9fCS/O89NZVendpcd6uQUFvU1fYxkVbRZ/L2MwziqC7fvUau7xmq?=
 =?us-ascii?Q?oyGzE8tgv0P6HrweAT9MHxn6lk1c09Csz+qXt9fmNbUhi614mBsUmmEWo2IX?=
 =?us-ascii?Q?UwanIje+NOWLBSTZRXmtTCzGMcZ8uthNMO5+/rQuLflc7ZX5xG2/5jxRhNtC?=
 =?us-ascii?Q?3yBmpO8ocXAxMptNyHhS91jJV/U/os6jihhuq00Gi1qbh1efsOYN75mEnPYc?=
 =?us-ascii?Q?p+bRHMriYtY8xkVwqTcvjUbixS9PPyewwQmK32rzVJcj16cn989L9TM8tTFc?=
 =?us-ascii?Q?ZVrpvheT74/4P8l3v7VyLVL5tnsTM0LU4+IxUEvvqKUK6pRgSsQ3qTDcyLYv?=
 =?us-ascii?Q?Tk1zvEITLB7xcOmCD8At2GCly0cMTeDNqMJGBUR4BOlPcBsqLGcmHqKowZly?=
 =?us-ascii?Q?WkH7pJGQvh1EvO42w0R3ax3/18XMija7QtwZKvXpY4yeCxgnOaRYn31QytCi?=
 =?us-ascii?Q?KQRJiuI7YZ7h8dONGxwVS8AsAjSC7NpLSuXxM+bXMzUMPLY3wpAQJEneMC+Q?=
 =?us-ascii?Q?gfuQl2H0QGS+HBR7+gE80W3VPQ69MxEUcF6KzZH8cKjuxlsB85pRMloHg7/N?=
 =?us-ascii?Q?hhtHwcBq4rZ/g1hrOjvQ/MzBp1FKmsF7dYiU/K8ywZxnrxpDbMUzhR54QaLZ?=
 =?us-ascii?Q?3Da1ygzVFuWpT/G3RZCLYIay/tH24XamTHK4ZAQyhmYK5h1gsXcfTe/fsUaT?=
 =?us-ascii?Q?wV9Mlzn6h1wl5Z0uBUXqXoRsRZhLqYetgjKvpAF1d8uqvkyxw1QRXzoEHblP?=
 =?us-ascii?Q?7jvI33LaK67GydBCqGkrjKFCgL9E9YiO1cqiu44fqjxeyRt89P/Z14wQA28T?=
 =?us-ascii?Q?Zg3ZA8INhkHoQJDYEjALHImuu0scCWMAn/axfVNdI8jKhDDUpNgtPF7NE3St?=
 =?us-ascii?Q?jzoWnkwV5lbvl9+7cAShPJ3PDTIXKtvDc/eTBHz6cnXxLMOqVgAYzB7tBZkM?=
 =?us-ascii?Q?mNJFRTuu/JJy2C1vWcuvQruCSseDz1OFYUQCFE11XAOKNDLJdjj2kqJiRTDc?=
 =?us-ascii?Q?13bO0HprwcbJsDqRlwxwLXAyEqo2GaCWbetLBptIrgQxB5GyWFxFxsMwGhow?=
 =?us-ascii?Q?AGTGtuPhb+TpSvJ62nq+8LXCQ1faEXnrtyAMYEhq3np7ej9jp3YxazlxPQny?=
 =?us-ascii?Q?nV4gU723PBivywvAdYuW9ajgLDLvMw+Nyfx859ZEoqNDIPjzOsVw9WJ4utQQ?=
 =?us-ascii?Q?jWMOh8b8W+WeGgkJzjL3b1+djwZFb2JIEc0rCKjNBT/rC+UojZaKN9AvJZA8?=
 =?us-ascii?Q?1gkIxVv1HFdhCzX/fB+Dc7CswRs6hHUx+wCanMJBoa03Vxg+DI9GBUDtO7u+?=
 =?us-ascii?Q?1iGGzqcRXhHpM2tX7L/24jKBzH8ZsflKrTiHbnFxWVfCXMKxZOXtdmzHQNqt?=
 =?us-ascii?Q?WGAIFb1Kz4uSzK6IQv8HlgeXC9ZzJYHh20U68eRUQQtuD+n1coiAa+g02n/2?=
 =?us-ascii?Q?uBq040lOQoWXWIYHzouhQR4hAfjvuHI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b74a0d6-0ef4-46f4-13a0-08df3d8ffd2e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:14.8537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRKVUXqq5ToEG1WBuTe2cefg7JWDLgpNwWax76xKdAaigLozCAH1ORHzo5LO55i1kw1nkQb7mTMGq33zUlSnvWEj1xnQQNLZ0++54RFhp/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The e500mc and e5500 core manuals define L2CFG0 as read-only SPR 519
(0x207) and L2CSR1 as writable SPR 1018 (0x3fa). U-Boot reads the
former to discover the private L2 cache and programs the latter to
select its stash ID. Missing registrations leave cache discovery
and stash setup incomplete.

Expose both registers on e500mc and e5500. Use the 128 KiB L2 geometry
specified by the e500mc manual and a 256 KiB default for e5500,
matching T1040/T1024. Other SoC integrations can override the capacity.

Note the e6500 shared L2 uses memory-mapped registers, hence we do not
add these SPRs to that core.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), section 2.15.1 and 2.15.3
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.15.1 and 2.15.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.12.1 and 2.12.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0dea3a9d2b..3d76b8a082 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1978,6 +1978,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_Exxx_L1CFG0       (0x203)
 #define SPR_Exxx_L1CFG1       (0x204)
 #define SPR_Exxx_NPIDR        (0x205)
+#define SPR_Exxx_L2CFG0       (0x207)
 #define SPR_ATBL              (0x20E)
 #define SPR_ATBU              (0x20F)
 #define SPR_IBAT0U            (0x210)
@@ -2343,6 +2344,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_750_TDCH          (0x3FA)
 #define SPR_IABR2             (0x3FA)
 #define SPR_40x_DCCR          (0x3FA)
+#define SPR_Exxx_L2CSR1       (0x3FA)
 #define SPR_ICTC              (0x3FB)
 #define SPR_40x_ICCR          (0x3FB)
 #define SPR_THRM1             (0x3FC)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5db9ea8b70..bf535d3081 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2974,6 +2974,20 @@ static void init_proc_e500(CPUPPCState *env, int version)
                      &spr_read_generic, &spr_write_e500_l2csr0,
                      0x00000000);
     }
+    if (version == fsl_e500mc || version == fsl_e5500) {
+        /*
+         * L2CSIZE is in 64 KiB units. Use 128 KiB for e500mc and a
+         * 256 KiB default for e5500, matching the T1040/T1024 SoCs.
+         * Other SoC models can override the e5500 capacity.
+         */
+        spr_register(env, SPR_Exxx_L2CFG0, "L2CFG0",
+                     &spr_read_generic, SPR_NOACCESS,
+                     &spr_read_generic, SPR_NOACCESS,
+                     version == fsl_e500mc ? 0x3cb1c002 : 0x3cb1c004);
+        spr_register(env, SPR_Exxx_L2CSR1, "L2CSR1",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+    }
     spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
-- 
2.53.0


