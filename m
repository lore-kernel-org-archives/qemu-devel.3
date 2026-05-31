Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D37ECD6E56
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWW-00020l-1V; Sun, 31 May 2026 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWV-00020O-1K
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:31:59 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWT-0008Ra-K4
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:31:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmz5cx5OrlIhAuzArqEa9rv8l0jMvJh6MRhFFabj0MU+l2EQhK7rqC/uzQHVV1i2HUhG2iGykrfpQJVetFOiqqUNiRQkZZGUiXlYstVy6Zc3IgkIAqU23HGDwKrfN7Bx9OrU8A9xMe7i1yqRd99W2Bc6Yv1AEdXs0JVC6i9MY5V8PY/nFwtGOwipVaAdqIXI46TGC7LDmSaMry4okzsVjNyh64DKK0SD6ixj6KNGuB2SYrcis2pCfq+CLrp4RsZRtK7OAiTBtzIL299IUVyNBLefQxRAzO+9QvHAUkHlfWLwRRc+WKQ5nep+aQ15gRB9PMcPgnmsZpnkfAsx+Op7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TNQgPqLqnfIMlII8pShDk/Xagb+64bCTZYiiDSaMJ4=;
 b=ZKNhfN+AUJgtPkb4s+B0D3lbXPNxzZ+cCFoih7WmYBykyX8lNSv2xnsl262RBaeBPlBrk/OepdQs76tpV3kOH6EZ8Zx1OhVw9KojwslEkp0gX0fdNkpngJIks7mF3zXr3uXjZH+tal5BB8zXZ8rJEO0iPbbaYvplky2NgJs2Vfd+Bg0+pvx8gMkJEILCVe69x/TpPVTjkfgalDDriDozheDaVxvV4hrHnFLHC+H4hrtb/ZstiuFsZVQW+S2Hkb9vTXeG1BpXztu4IkT9qhQWMSAQC995U3pGJKWzHkt2CQtAlvZWPPqpmGlUM4ZN5uolkwXb+OK7UTS3DZ+JCBCUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:43 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:43 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:54 +0530
Subject: [PATCH 03/10] target/tricore: add tc39x CPU model
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-3-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4f5117-4cdb-4fad-8f0f-08debef76d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: SDMfW2SxjXSpJTBd7JGkr8zMOmroAjZgMVOtlBCTUH+wedTlcFj1xpsIX9AdeT8trVRwFO4llV/omIP2Pyby17e7EVPYNRs9byqY55pYJT4XkWmnof47GmSkSGQO+KSR1KHCNc5upDHoKUNlntKFSZmEYlzKafUV1l64Az3QOYrMw/HjUwM6711B/7fcnBNCy5ArtRyzP7c/UTHuIVDAMywwDc4GETBLRbcxl55EFOYQsnCxpJCPBv20EJIBss2QypwVHO3bG+PRH1I9JJm8EtmJLeY00pmkGenUdKSprJxYrfFLFbjnyMlOFYVTOvqNQBlGdI7DXdFtQ1E+mepkCOH0p/Wxdukux29Zy9EJNT5LjjPAYxyUOcekLG9ulyBb2vHnBo9SdqUQHee4TcuWq9j1HLED3KsQwfHT0CfnH8TJlvCY+a6sMowXJLLTL5lwPuqn9fVrjTyI8pybbVsEDS89oUvRgxeH8CRZd8AnbRow6Sg27UL+VkYu/nHvOgO7zL1FUxOrZlO1GRrLw9A2vsvViTNI0rmCdI/VFVpndav8pNDm+/yqjWqmddb8P22W4EP59b0NqUOeZa0h2hFCSsW8ifydk3jGmav1hbpHm13RbqRbHBFh82qa9bNsaOChCRKGqQERiv9yqWBZPoiemVz86PNF8I+p6mqr3/KciBL3RVGMAE07F0PTXiUIvngDRXi5pwepcX0lwE5sGYIouzINzTDJluErtQu/dgsGjcWusWZpO6fZWfun95Yl3NOb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01iVGN5MmNodUVhVW9Yek5GS29ER2N3V3FwR3VISlFvT0lDc3E0NUtsWTkx?=
 =?utf-8?B?M1R6WmZ6TDRBV2VlbU9UMmE1TXJXelR6VURScVRXMHpNWDgvNVpiTG5KUmVC?=
 =?utf-8?B?ZHBDSy91WlRyZXBBOVBrT2huaVNpT1Bwd1d5UmNUM2I1MWY2dDJ2ZmJmbCtI?=
 =?utf-8?B?WTU4RFRTdTE2REVMc3lKR0FDOUxrTFVOdkZxNUNjemRUN09Lb05VbmRXOVEz?=
 =?utf-8?B?RVNRUTF0em5lVUVwNmF1RDY2L09wVTh5Ry9ybWNMekZOKzcvRFNZRkNJU0Z4?=
 =?utf-8?B?SEd3N0Y2Q0lrSFJtMUd5cHF1bC9kNEFTVVE0Mkk1VnJSUVVQZlh6QzdyYXF2?=
 =?utf-8?B?V0QzeFE5SHl1d3BzdWRFMmE2WTlicXcvbFhrWFhkeHAxTmJOZzJEdXhqRHNm?=
 =?utf-8?B?T3lSYWp0MXhtdFBCWXdHc3pGK2dxd3EwTGV5aWxLMjJrVFpRRjNrVmZJN2dK?=
 =?utf-8?B?YTFoTy9DTGRkK0VmcU9OSDNkamZrYjc5TzNpb2JOTUhlOHI2cHMwOTNNMm9K?=
 =?utf-8?B?Ry9pQm5FUkVucjl4QzlrRWtXa093ZlNHWVoxMzVzOVFLZFgxaGpjczhRdVpo?=
 =?utf-8?B?RlVyQmNIUDluWGpXNjY2QW9kUkVKRjJ6SGxXQ3R5VGFwQ0ZtWkp6TUN5eTcz?=
 =?utf-8?B?dlZRNFdaa1pYK0RZN3pwdFdqSkRtSFBRM0o2Sm9UMUdoVlBrNW0vekZqSGZw?=
 =?utf-8?B?YllFZmF0R09SNkVxK1NSeVZ4aGEzcXFXZXBwVTN0cTNscGJJOXZQeDhWcUI4?=
 =?utf-8?B?Q1lvWFVpZFpXQjBmMW1oRXMxcW8xLzIyMDR6c0pJcVV6cTVCdFRBRmoxbm5Z?=
 =?utf-8?B?QUVnb2lMMzBGb3lwa1NYTmZZWWlnM3lmTGk1VUVYWlYwVVNURWtNdjU3bmpR?=
 =?utf-8?B?aFh6SHRGc1JnRC9DQjZjaWV6RjdSUVJzNGN3dDJWZE8yWFcxbXZGQWwvUEpo?=
 =?utf-8?B?TTFzRlcvZVpoaDU1MnlqQzhUcmNIN0d6RmlTdWE0UjN5MlRtc2JlY2pocVd3?=
 =?utf-8?B?RUdDZE83WnJDcjh3dlp6emRJUEJRVjZkTk51SHZGcnY2Z3FxMnBoNU03SnBZ?=
 =?utf-8?B?d3ZTZmhDaTEzNWdvYWhKTnloWVFINFhaSmJrTXRpdXhRdFEwTDJrZ1pxTVcz?=
 =?utf-8?B?MUw3dHk5NVFRL25FVTlrVld0RDBxdEFJUWlkOEZDTXJVa2xoTjFtV21WMi9s?=
 =?utf-8?B?N3hQbCtnMU04MlYyczRrV1dXdkxLdS9mcEF1dHRobFplSzR5OFJzTUEwZm5U?=
 =?utf-8?B?TWpLRmJWZVRCN0hVUS9EcHhuQWdGdjBXSTJDdGROdXU3MjZCdmRrNll0Zng0?=
 =?utf-8?B?bCs4Snl4V051MThFYWQ2K2I2ZDdrNmRNZUxOcXhEV2NBWFRMbkpOQndoNkZP?=
 =?utf-8?B?YkcvQTZFeHVnTjU0VGJBSjhvK0ZoZGZKVXU2L3M0UERFb3JKaEVqMDF4QWtJ?=
 =?utf-8?B?RVVEL3BuN1NhYWwzZDBpY1VSY0J3UGNWR3VTYnJmdWw4V0hJR290ejc5U0Fl?=
 =?utf-8?B?aHZkaDlRUWdVbkR4bkZVYkRCS2xOMXpvdmhLQlRhZzh4bk10ekJPVDV1RTVD?=
 =?utf-8?B?Ti9QOHVZRm8xTEQ3ZWd3MkxuOGdjT1hoSE9ZRktPd1VGQnM4dGJ1S1BMN2p5?=
 =?utf-8?B?dk9ydm5abUJUSU9aRk5weXJ2Z0d1VHVDKzVCOUp3RVJqM1hwVmwvU0E5UGNY?=
 =?utf-8?B?a2wybzRNbHBiU2JQaUpzZU9YK3FocUtWT3VIR2RZS0lMOFQvb0hlZGM3UlV0?=
 =?utf-8?B?UHNMVVNPZWVvSk5sS3BvZkNnZVZQY0JYaTQ5NnFpZ1k0YjhsTk9RWGlyZkxD?=
 =?utf-8?B?MW1kM2NFUjJTTWdqMnkrTDkzK2FiY1NXYS8wUWY5R2NlS0M1eU5ybjVKMW5r?=
 =?utf-8?B?MmhONzVBQjNhdUlUcWlLTGc5MnFMUkkyMG0rR1ZmMEdmTkhVQ2VONDR2WHJ6?=
 =?utf-8?B?Q1Rnb3hxRDdldzlmNlJFc2FUNS9PZ0FVOFI5NmtwY2x2VEZ6bnF6eitoSG9B?=
 =?utf-8?B?MkZ5MXNhTEFFWmJjR2tkTC93V3ZUN2t2bHFIbU1kcURlczZpUUhKcnpwZkVH?=
 =?utf-8?B?MlBLalQ5d2xmbUFPeEtjQjYxRmdSM2lYWDN5NlJ4K2RPT0tRZjB2ZER1ZG1j?=
 =?utf-8?B?MHFLTFhtdDNxbGdhMFJEOHRXR05Nd3IwUldGSlQ2QXhBWml5Qkd3bVZMOHZ6?=
 =?utf-8?B?TGovNTRIdHhLSklPa2NOY1ZPVGV6S3pHaGl2OEpOQkVYVDdHK3RJeUNIUGQ3?=
 =?utf-8?B?Z1Q1YTU1ZHUwQ0ZXRmtMN1g0SFFBa2hSZzFTWnlic0FMQ1MxSC9mN0tTTDYw?=
 =?utf-8?B?U25DL3dRcXhVem1UODdQWkwzNXIrbGtORisvanROSUcraU5hSGxEUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4f5117-4cdb-4fad-8f0f-08debef76d97
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:43.8707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gxSuKGNa2t9ECLonJoAeTZpwsa5d8MfVrTCSQDzX59QRQjXmJ81g1GOPkrNFqSOTyx2UT73yYit8eYAt+yKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add tc39x with TRICORE_FEATURE_162.  Same ISA as tc37x but a
different chip family (6-core AURIX 2nd gen).

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 target/tricore/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 472c24ae32..e62ccd55c0 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -166,6 +166,13 @@ static void tc37x_initfn(Object *obj)
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
@@ -243,6 +250,7 @@ static const TypeInfo tricore_cpu_type_infos[] = {
     DEFINE_TRICORE_CPU_TYPE("tc1797", tc1797_initfn),
     DEFINE_TRICORE_CPU_TYPE("tc27x", tc27x_initfn),
     DEFINE_TRICORE_CPU_TYPE("tc37x", tc37x_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc39x", tc39x_initfn),
 };
 
 DEFINE_TYPES(tricore_cpu_type_infos)

-- 
2.47.3


