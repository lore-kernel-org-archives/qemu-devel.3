Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdb-0000LJ-MW; Fri, 23 Oct 2026 16:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd0-0008PK-0i
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcy-0006uV-7t
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDkmDpG3DpwmQPOBvDxq2XWJ7HnvXOy/q6Mmg1NQm4wzAov7HiokxRLYwYGJXq82JImAQhBl8/t2eKyS8uHI2H6CqvvPwsTJ9BZ8rYoZXeaudRv8VVVTwo61+h7ms/vis1vvedqkuuuemkccAwEj5LB2EHJGzixWd8dwPSinhd9lIzwa9g0LjoY5jAaCNkjZy8RvfeF73B9N4AV1mlrhcT036h8V1176RQd0bko4IFDUgBg7NGPSPWZAJC8hAia8aCKLhZaDyq4mbSdWk4fPoah+xBkI5x5fzBAHPgueHHb/KV34SaAIZh5nCrue2Mp19PPXYk7rNHogwZ3QIudijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru2TWpIF/fxDZRujwWaoaOWIyeBzrdN/yFEJrfZxKLA=;
 b=SQaR7teGHz5K/lV79lKtABxJ2dJxr8gFoZCLK+jLhJ/VEZLqwqmcIRQadC8uCeV2DRR9t211ouCxo+hCS0QaTiTrQA/X5p1XYjPxrbRJY4REZmHZdQ6CZuP4VprmtSDQh2OH2As3qrXiBPmi5j/CerOCsBCWrSP2O94W4JQ6IBpyeOL0pG6mM4ZS0azh7zPu+mmvrBqR8CoH9diLCzqSZ2hny7GvrLDQ9eWJEm+2Q8hh2MB15ycZ8HwKDPYJTL4n0rxhsv/GE9CyFu4NEr8zTKJ5WrILCLjAWnvDy+7P4maw64VP3W2nH85gJyGEywX7qhPHjkTQ8sQ3a8f4HdtZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:20 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:20 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:41:57 +0530
Subject: [PATCH v2 3/9] target/tricore: add tc39x CPU model
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-3-c722e4ca5661@linumiz.com>
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
 Parthiban Nallathambi <parthiban@linumiz.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=1207;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=dvwy3Ush79U5IjBL31vNJ0ztEAUX401D8SyXOQ+o9yM=;
 b=mD4jj2qlislZLMsBZbnSl8mX6oSM0dmYCyc0DGkqqEuF55W6l8+6wOvdevqNHFChd4h6FTTaC
 qMsLhCwXt5KCT0oGIw73mceOhCEG5xwLENTlsOaecxpPqKm/q2oNalb
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d11c56-42f7-4ad0-a285-08df3141f1a8
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261009223027099003|261021121427099003|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: kZ+V/C/2vYum3yuNYSQ4BjJjYkb+u8zeJPjOHtbW9m7PlBXlajxFEyMjwJXQxBMytfhRUs+27lqEkCceBhqDQod9cv/Yb3smOTzFKvZULktb60GcxKLw9ALfioBVPZnU9cxLlWfD6xreeWcoupJFxdiJN+jbwqmy/TFt2XBjVIKXBT+6qrdvbqEPUs+eeLtrl0NuV4wGqtCoA9EF+ZZy1OsVGEdHfPAPfssj7vkgHxZXAblTOm9336fy+KBq84AJhmzn/2pnCus/9AvicOSOGMUH2L8IUNRi+DxNul1KQ96O/u39tX7EQTckEqpS/lR7Q4PO8ll4uJYuTJP8Bx26rEqlR8YZ7c7kCJfqfx3QI4e13WoXo5+gkRuecKO9E8yTwMelGN9MblG4Ws2hfqVD6BGosr3sO0dvJaXlzT3a5iMLrKcbK6Nm9XAu8KXrpHcKoGUQWvgGz/3uV6xpZ74y7yEWVYLCE0n5eCTHOyuxeNdeGO4KwLBttRRftTdhciqC7bHKQ4bQeXInMOLs4hNID1ayDbpNTbJ8ot8oYMAJkKqaTpBw0QzBW+UHLLINOBCeK56rhZbg0VUIT3ms8QuXn6BbsBpUncUZFMXnLo4wKgWj16ymOUXDNSWonNN3NZZiutGFE6kYYcKAqHIElaBh7qYIz3cLpZbK0FWXZD8psWpJiSySA8uFhdK/uocgi1DkrX7VRo9FiRu15daNZvRkQKDfHr8fD5yP9Zc6ZhdaFx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJ5WTZ6ZWhDa2dOOWJnOFY2WlRzL1VubWdCRGp4QjlZbXN4SE8yT1huWHY1?=
 =?utf-8?B?cy9jVU1DRXNQMEdzdzEwU25GbUZ4M0doc2Nqa3V5ZjA1QUxoV0lsbkJ5ZVVF?=
 =?utf-8?B?NUNUSm5PSnRvVEJpUmJrek0yYjErUlV5RnBBSEhMNmxtQ09oRUF4UytQcksr?=
 =?utf-8?B?dklGVUdWUFBvUndoUnVKN1UxNmdhZUhxM3UwbEhKZHBEbGVDczlpbmRzUjgx?=
 =?utf-8?B?bjVYREdvTjM3b2Z6MXJKSzg0SExYVEpnMlVtanJPckNmRGdoMUtPQ2tVcTBH?=
 =?utf-8?B?ajdSdVlLbEFlV3hGdlpUQTdOOWJXK2ZLdk9QanNYRnFZV0d0TFBvaXB3M0Vo?=
 =?utf-8?B?bFUxemY5bmhqVThSeGxid0JhT2VPcVRyYlpOYyt6ZGh6SURBMFdyMmFveFZa?=
 =?utf-8?B?ZElGS2FIeVR1ZHlpdDNJQnFlT2dQc3p3UGhtWEgwU09oSE1uWGV1SGxITnU0?=
 =?utf-8?B?THYzM0w3eVFnL1RiMzF3c2NweW5kYkgxMjZVSTIvRXRZYTVFQkdaemNnbWps?=
 =?utf-8?B?VHBlYm9KWFloa01nSUxrU3dKampZQ0UvQko1dVc3ZkdZUkQxanFKd25GRVdn?=
 =?utf-8?B?Y2d3WUNOcnBjRHdWeWxOQUpoVU1MSTZLQ01LY1Q3M1JNdlZ5cFhmNHhrOWJl?=
 =?utf-8?B?WTdabW4vbUZJNitNZTNjSzJSamxSdWY1NDdqVXNDSldWN2hxMDdpZkJYeTMx?=
 =?utf-8?B?Q0xIYlR6UU0zQ1lyNFdmczlibExxN2pqQ0xVZThCMHdhb1lHeFhDcUVuOTZs?=
 =?utf-8?B?RUtIeXdNMDM2SlVqdFo4Q3dXZFZpRlFScE1hQ1NtNkF0MnNpL0VqbDh4Y3k3?=
 =?utf-8?B?SFJtYnpFc0xycXFMMjJnMGZCdDE3TksxbHRPRSszeXdRNGp6b1BsL21JNjZM?=
 =?utf-8?B?dkVvaHE2NmJPclcvSDVGUThkUVpLUDhQcXo4d3hNWXErOStYaXNYQ3RTRE1T?=
 =?utf-8?B?VGl6cE5XZHpwZjhFTjk0eUNXUmE4VHZMaXFKN0hVTjgrSnBxaUtURTBmV2NP?=
 =?utf-8?B?dWdWZ3FGYWJLeEVpNlN3eUNLbVArc2FkUjFydEs4MFlSRnA5OHE4TyttK2hS?=
 =?utf-8?B?dzM4cWpxbFMxNmZCMWUxNlNNVmd4dklMdWk5Qk9jSUlNUUdwdDlrek5UTlpi?=
 =?utf-8?B?OEZJamNxS1JHeXJnUDh5QmFWL3pOMjRXcG9BanBMWCtlVlE5Y09ScGRqaXB2?=
 =?utf-8?B?SjRXRXYwSzJ0UFVFTUZTVHBwdG1uZ3RHWDVsc090V2xEZ09jL1kwU3hWVnds?=
 =?utf-8?B?ZDVPRlp5ZDhWRkxvcy95NlplbExzNWpPQmhTdmR0c09USGtUOGZ3N0crRDMv?=
 =?utf-8?B?S240Znd3clk4REtIbyt5cUFHN3ZQNEVCZVdIcU01bzNoak1Fc1JQcG5VY1Ny?=
 =?utf-8?B?bS9FT3RYTU1lekxmTmZWSWpIS2M1c0lWTXJsdE53YWpINDhoVWlCc3VPOTg1?=
 =?utf-8?B?NC8wZThBQXBSZVlTbFl4ZlVEaDRjbzNsUlc0SzFDL0RNU1BYVitvYjhjdVR6?=
 =?utf-8?B?RjM0MW5WeVlja2Z3ZklIamJZUDJESnk0SXZJenRuTWt1TlJzQVNiWGZnVi9O?=
 =?utf-8?B?NlpoRHhXT3JIQXNTdGFmTkZ5VW9QV2EwanA3OTVCbjEwdFQ5Zzl6eWRMUWVl?=
 =?utf-8?B?MGJEWlFKQTBMNWdITmJZaTY0M2U0aFJ6bVpGYVBlakdqZnI4M0tXZEZMbmQ4?=
 =?utf-8?B?MmpWN0t6Skg4V1FsQW1pdXNkeUxTL2xYaVZLVmdKYUhJNUpKQVFzdWh3Wm9k?=
 =?utf-8?B?UnNXem1sTFRNckpIL1JNSUR0eXBsbUtPOFpZbXNROXo5VHl1cExML3BXVENt?=
 =?utf-8?B?TGVzTWFmMUdzK2pEaVFPUVRqU1VWMFRScldWandLeU90VVVFSUtNd0xhVXox?=
 =?utf-8?B?QnRuWXlDdUI1WElBRURjSU1VYXI2UHhrM1VLRk9kQWlDRG1UY3drNUR5T2x3?=
 =?utf-8?B?UnY3VHNhVjJSWFNHUjQwUC9zR0lHd3Y1WDBia21zdVJ6dEJhNDNzZWJxOWNo?=
 =?utf-8?B?OExmcldubitKbllRQVphYWI5em9EMzRUZHo4eHVMbFNaVUdDUUNWYkFyQmYr?=
 =?utf-8?B?a0Fld2pNSzBlVndVNnQ5Wk9lblpCRy8wSTU1L0dObys3bjRoa1IrYjNySmNx?=
 =?utf-8?B?VnRrY2Q2Y2I1WWk2dEVaZnNocHNEYUdHY3dEVXJKaVViU2RRc3hULzNta0VH?=
 =?utf-8?B?UFdTeE55WlJXZHhXTnh1SnZmMVAvUkhtQk96bzQ3dHBNTmtvMnVLckdPRTNy?=
 =?utf-8?B?Zk1lSFkzblFMd1E3cDZDR0hIZmEzRFo5bVJ2VlE1TVdLOXRUV0ltdGdwVm5L?=
 =?utf-8?B?Wk4raDJOcUNZK1ArM0RlUXZCVnB6TDhQU2Fad2dsa0tzMlRYZTVPdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d11c56-42f7-4ad0-a285-08df3141f1a8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:20.7788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gV9tj8qi8/ucrSsmFCkOm9PTUdFdkiBCqC0mVz+8FORovSs8yohytz7Cnd7nX5rb+XtYKD+cZJvKwbknnyUeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9019
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add tc39x with TRICORE_FEATURE_162.  Same ISA as tc37x but a
different chip family (6-core AURIX 2nd gen).

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 target/tricore/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 84a05e3d36..83b36855ca 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -197,6 +197,13 @@ static void tc37x_initfn(Object *obj)
     set_feature(&cpu->env, TRICORE_FEATURE_162);
 }
 
+static void tc39x_initfn(Object *obj)
+{
+    TriCoreCPU *cpu = TRICORE_CPU(obj);
+
+    set_feature(&cpu->env, TRICORE_FEATURE_162);
+}
+
 static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     /* Interrupts are not implemented */
@@ -275,6 +282,7 @@ static const TypeInfo tricore_cpu_type_infos[] = {
     DEFINE_TRICORE_CPU_TYPE("tc1797", tc1797_initfn),
     DEFINE_TRICORE_CPU_TYPE("tc27x", tc27x_initfn),
     DEFINE_TRICORE_CPU_TYPE("tc37x", tc37x_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc39x", tc39x_initfn),
 };
 
 DEFINE_TYPES(tricore_cpu_type_infos)

-- 
2.47.3


