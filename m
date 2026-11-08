Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EF606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=NreTXyfh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1ah-0006q5-P7; Sun, 08 Nov 2026 07:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aY-0006mJ-Mr; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aV-0000Wc-8j; Sun, 08 Nov 2026 07:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZocIwWDNYgaS1jgYCCiTMhPkSXw6gFpB8a1ziAyOVLcj48Co8pwNNQ9eIfdFU2/9/G7H7pFtK0FBrxJ/hXA4qB/vxHweV+itqGRWDnwtrKjtLNH9KAonktcQS/6ERDa3QM34IAZsYI3aX6m2LIT0bIkwGjl1kPq3pF2ds8HwWoE3kZuhYjZzEMbLHx9GRvmnJiWqCvS5baoTN5EDAGVos0Wuo6FkeJmvMBQBhfNq+gQ8/uo+/OYjhCgCWXqcLbY+fFCK7GCnZGULKOX7zJmZ5++w3K2pcvWL5ennaMZJl1uEROG0prwApHYzIwXbEBLUmVcag47u+XAFAw5s3ii1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmz7ObNsH/+1iAisKFwjR8STcStzNlkEPpSRazAs6q4=;
 b=kw7LlwTZSt4m2ShqVPGjd+s00mQOZyrgISMbX4YP0TQArkaANT59oGLLXX3gxcmJTb5eY6fX0M/YV5gjfSWwzwdEYif3B3fXjMxM3TfDU2FNiIe6ZV0H2WD0+pRhEu1hXxq+XnkQuAj3trPR2L8CBdlX+F7NeIp2lWa4a9A1RSfVN2A6GN0ogPB4y+Mp2Tq5m+wsA4mLNQp74q9LQ/yI0P2FqQfNs/DozD+dgJotTqK8adN1YiIrrXw/Awy/pjzXG5U/guiEzizbZIOMfWjjcPgkk906BFlRAk5r6WPtQlXIGdYkPeezQYLfSphhxBuTtlmp7ahXumSIaPvr/L7e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmz7ObNsH/+1iAisKFwjR8STcStzNlkEPpSRazAs6q4=;
 b=NreTXyfh17Hn89mPKjpeiZVdNzvEhDfobTaYkV6UvpO4pEEuVXj/nYChXgdPBm7dYw56rsGonH/W3YjzQsUA5tQPLX8tuDPVt9VAJoOljoUoexL4UseCaL4Mn//PDNkbKkPBDJIeZpHfLiBsVSSYN0zMrjTYsCL8m9QE0Rdha/xrVQY0RPgXsHdslRbuSU+jZYX1W8GjA1ZnRm88LbG26EUJdosUMmv0rORwtvvzR+C+3GqRncKFG2MZJvFEEw2/M2hC6Iuh5O82DPm+r/KuL3XTW2ZAhB/UiMBi0d1hx6gSODbDRZMNXwaokqnihJTPO0foonv/fZ3RDOJJ8KHsgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:20 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:20 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 10/23] target/ppc: Register PWRMGTCR0 on e6500
Date: Sun,  8 Nov 2026 20:00:09 +0800
Message-ID: <20261108120034.1755008-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f743dcd-5328-450f-d77d-08df3d900070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: UDoA1cuSoH5KJWNPVhFCbBSgOqjHbiJ6vMW50ZhLAo972pGq1COIiDut5AuSPHr+73+arPXuWknJXMflPaFW3lbZHlidNA9zOrkqagz+VliT3O7F62/oPMd6oUA+qzRRgNLAllM3l0bp+iAs4Q6ZRNpQBQbWSwEqHPtlgi/L8jypLOoHDdNGjy2t/Ft8daa12oqhLBby4n+nMltcjudo8XD4YyMpX1g62yYiw/1XAD9Fn5o9Q8UlQcfgbML53cW3QiRFEb9obGNZd+ZUr/8j07VvsHyrOPK+XgdVqk/v27nXTcfR017WTidJmt85BZMT7iEfaWjC7f12cBsXqv28DGkaX4bghpFnuu35sXjrG/i22J08E789p60EoWGHYmS0M5A0GOuSKWTP4r5TS0sfIX1yBT9kCoQNrDGAHjB8BpqbE/c4EPE/58UDqlNt+dsvZKgkPEggmx6sOqUgxUgBis/lytD1N07b/bqLxjrNM7vMUMXvd1SIwCCnopJqH2jS79U8YoQFww/h66z3YrHvVVytqnwGSWzNtRD1uApe9KK3/gm6usS1UU7UdCHUBZSqpeO7EFwJ3FpaExoocL0WoT9hAjdPvJlrly2XtD7xzFnGS1P2HCk0GgE3olGZX17lbqdLjvEINSkcw24L3euigM9EAkMsGVeZF1klsBWhm6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Pv+X8vsVRB0i67h2HCLPDp/5CKtm+hzq2eNp+DT0XWnBEz55j431fv6X9RX?=
 =?us-ascii?Q?4V9L/8JOSezXCXKGiVUJlhaLuq68WTw7fN+xrb8U14kJXvi7ILZW5CWwtg4i?=
 =?us-ascii?Q?gBoV+DOtMOZsFPFsPnKReMxyPyrr6Y4yS9PzaqQoahIbk8ajjXOvJUPnLD23?=
 =?us-ascii?Q?GoyCPz56P/4qVoYpd1Vnwog23HiMA0bsHeY2sSW4OjOP0kkvrwE2wEqLyC0G?=
 =?us-ascii?Q?ccrhExdK7ED39GWrlcfpmwP8tAqcOzTDMltmIysf5QIgfF33gzHl4n0LDRDh?=
 =?us-ascii?Q?cYRyIAUIStxkQRRHRYvcWcdlS0wMqojKBNKCxcK72QoIjIvYYKL6B4MvtGrt?=
 =?us-ascii?Q?T/vhDLsZJVGTP6RsPQWonva5F62M/yxnSiSZEsrf29aCqYJnGw0ynYm4dzhO?=
 =?us-ascii?Q?Hd7aDV0JTDcTIV9/KKAb36ojGuo+jGy8FzjQBt0x9Q8X6BWojAGUpzyMk5W+?=
 =?us-ascii?Q?yVCzYqV+On0rE4aU16P7XJ7+DffK/VTu3tW9ffgAgC5ai2pCtnBN57jba8Yr?=
 =?us-ascii?Q?mz1kKf2Zihmn9+NvqlgbKyb6b8hicHkdWWvBkFwmEbzQEj+pOfh4zEYQnxUV?=
 =?us-ascii?Q?WX1yciA+gI2T/isLUGz2IaZUII7j0TcnFcz8yO/Fp8ar1UWdpJx6WoPJgUOi?=
 =?us-ascii?Q?g9LeCg0690uyruCET2lUqohAyFjU92T/MI5T21mcMwUgj/AIPGDof15KOp+W?=
 =?us-ascii?Q?hI014rQEpEO+8R7mgx2e8g/2AYDEzJ8T+5AUSqzk6JkVKk60WlOep+CrH2Dh?=
 =?us-ascii?Q?X3GJRJbNcaCCNYIpAPyvIOzcD05Wu7KOoSew2vP9R0qJKNMD2xUiYimdL3qK?=
 =?us-ascii?Q?vWMFx4Pk6Np4v4PuSicNvcJxCsdRWHsjubSuDvpGvGBMxRkNQkKJQpdDBty8?=
 =?us-ascii?Q?BuqjvkBJEZ8bevJyEm+jAiA8K6zmuUsLP4q8QoSHnvMZsqjYOhz4GaeTx4/C?=
 =?us-ascii?Q?0jBh17Q/PMWHS4OmZhzZCBlau+dzw53QGVemcECr3ZTmMEiFJvrvOjNPGAe9?=
 =?us-ascii?Q?H32svpBwpdWzOs+cyIqT2hEIil7frkRYEQSI8c9rS4tBy63RBW8zqtY7wDVE?=
 =?us-ascii?Q?lZt/6AlUvcjAgMGM3qW24fCHoLxqhP+NcXAAR6aOlzZEezjGKWXnKaIs4Hx5?=
 =?us-ascii?Q?kkmJo2ABSCwwbgFIcV6ayKW7WzgEfcIlFmTAO9p9++5Zg6Fk/A7PjrgcJGQ4?=
 =?us-ascii?Q?9MZfG9Xed0f+kvdE1re/7N5n9jV7KAoselbBbiHwQBJxdk6g/yKTXN9a9arC?=
 =?us-ascii?Q?4Czi52cQJjYWDbnUFWkb+rH1yit8V2FKcVPgQMKYDyH8XvhTgak7jLbl/RVO?=
 =?us-ascii?Q?p7c+i6XUhsY6bdY/41zZ7HH+8Zzt9Fegc5UO696v3qR8zDQjJmxisQI1itWF?=
 =?us-ascii?Q?9fdMlicx3Hz8YP1WOBbZ0W9FBu0BUqyobhv599t/Gg4XhBzvSuGcp69kHT4S?=
 =?us-ascii?Q?+2/lGKo1HAh0Q+5kVtuu7oMKPS7tTzEr7/rfj9omvlv1qfH0Faa3HA7pV6WM?=
 =?us-ascii?Q?PXw/CAyS3AFCq/NshHyidkbmf5xM1fRfSbBPuil+gTgVXBgIZt1ePchUZMk0?=
 =?us-ascii?Q?4HajeuXhKUrV6a9zn6On5oii61UuJNiO8IxB0fcBCySEKploKqXXoX4REH8Q?=
 =?us-ascii?Q?yOezvURARhlvcH7D475EQqr4dFf1pfFMeQ52MaCDmu+L6ZFwYqRqpwWLwRCF?=
 =?us-ascii?Q?IXlV9P+wRFEyB2i7Rk6jn+NeRU9F/tnF5YCFeTlHYheE+tNOdX3i5WribS05?=
 =?us-ascii?Q?CucHWy483vdprpChdNL8updtdLd1ahc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f743dcd-5328-450f-d77d-08df3d900070
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:20.2518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC4O3Ue3QPztsMRhNQqkBIecaTnfsKm1YRn7Q3G7icpnThqCh3JIrhu1mBOSeVTIMxpz5sfdFBb7SmgBYSsRkMET8A1RO2pCUHI+FQwPjjo=
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

The e6500 core manual defines PWRMGTCR0 as SPR 1019 (0x3fb). QorIQ
U-Boot and kernel access its fields during processor power setup.

Define and register PWRMGTCR0 using the existing 32-bit SPR storage
to retain the programmed control fields.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference: E6500RM (Rev.0), section 2.7.7
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e93f699f83..2bc0e36c5f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2348,6 +2348,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_Exxx_L2CSR1       (0x3FA)
 #define SPR_ICTC              (0x3FB)
 #define SPR_40x_ICCR          (0x3FB)
+#define SPR_Exxx_PWRMGTCR0    (0x3FB)
 #define SPR_THRM1             (0x3FC)
 #define SPR_403_PBL1          (0x3FC)
 #define SPR_SP                (0x3FD)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7bb4e4bcb2..cc702d7c7d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3026,6 +3026,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     }
 
     if (version == fsl_e6500) {
+        spr_register(env, SPR_Exxx_PWRMGTCR0, "PWRMGTCR0",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
         /* Thread identification */
         spr_register(env, SPR_TIR, "TIR",
                      SPR_NOACCESS, SPR_NOACCESS,
-- 
2.53.0


