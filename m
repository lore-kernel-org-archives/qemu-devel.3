Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0669C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 07:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV4wX-0001ss-0c; Sat, 20 Jul 2024 03:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sV4wU-0001pS-RN
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 03:55:47 -0400
Received: from mail-psaapc01olkn2080e.outbound.protection.outlook.com
 ([2a01:111:f400:feae::80e]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sV4wS-0006zW-2H
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 03:55:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZxe9D4mGv6A/otAwLTBdUVcJvt8CisrSz+oP+aU04GB9nfgBlwSuDUzawCqmXszfZis2//MQckndGmTONiA8yHFlXYynVNQ6Jw04p3J9nTV3qSfK79mUmGFhfyblvXizexRI9jZup4fgVP+A02c97jYPC2ML7k/eph7s7c8nr1IP9KCp2NnDicQaTtlZbT4JDtEOdq2JjNAQux+8yVUYdHf5oQd5mzGDDRsCs52SsKLq1ag0O2eRkIijABoqqnO8Mfkym0ItebATtytdL7EDuZiIJ+Ejsr/LF7scwWaWlE0nTAMF2QBfVrpbh5a5EngqRKIG6M8YRQ+KJYevIKxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhFrgqAevyT8rA2H+uWsv0/MWTkNmuzhkEqx7LRAOZ4=;
 b=thPiZgXq07yC0OU1GhcxPwxri13oEAn0f5MQp2VvV9Sytx+lL41uZX43NjaBN93JE7ouYBtViNA5KrMkhWKfLe0Vn6mJIJNFVJzV280DFhwF4+J0zYDwvaTK/Vi5HmMjZg0w2YSecMjGiTrcZXlrbTRWKClqlxzYVd2lV4BqG62chWRCEAGrL42doE5D+bJS2neYgNurcx6lY1mKcx9s0RxrN+YTBsZTgUnu0WD77j2E1tyeQ8Ca+99VmjO6p19YQqZmoaqFQScHeSmAf61wcOnqI0PedfwyTMgYlMlM/r+F/rHE5mdI5MaWOo3un2kqlCLNnhXqa/+CopajT9R2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhFrgqAevyT8rA2H+uWsv0/MWTkNmuzhkEqx7LRAOZ4=;
 b=QNdP8uxHhCA4254kcxOKo+BH7RQ5D4hJt1y+4LvPiuPW5h+u6wShBVRyxbHt/L95gExobgVMldT/5pVyAzg5L5/fnezIvGcHvfU2lu85SY813fwph6EE2gNvPW/hUHrVdC/HKQbZx0e/S1l53isXHcrJffaghbbyeFgBnucivZtyTaFovG/7n++DOjwsgxtkWcxXDm9icS5zxxJO0K+Xj0l22TDDvHWs3UWlPlyYjzzUNHnJGm/A6OyqhGce+8iHOXwRllG1Q/RZySRCjjod4GenASqNhJcxZTcqTRK9LS1kLD/c1O2WgFGfCqC8+jW9MfTPq/z7M2PRvbbWyD8zSQ==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by TYZPR01MB5726.apcprd01.prod.exchangelabs.com
 (2603:1096:405:24::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 07:55:36 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%7]) with mapi id 15.20.7784.017; Sat, 20 Jul 2024
 07:55:36 +0000
From: TaiseiIto <taisei1212@outlook.jp>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, TaiseiIto <taisei1212@outlook.jp>
Subject: [PATCH] [PATCH] system/memory: Fix max access size
Date: Sat, 20 Jul 2024 07:55:18 +0000
Message-ID: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OIuYdUx8QdxXbkZu1EEeXSgCbk9og/w1]
X-ClientProxiedBy: TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33)
 To TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11)
X-Microsoft-Original-Message-ID: <20240720075518.25285-1-taisei1212@outlook.jp>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4285:EE_|TYZPR01MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b7cd46-5be7-44ab-7835-08dca89156db
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|8060799006|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: 8ugzgZLKQ8Q9/yBpvDtOZfKSrULTpoNWZOung5nvOPwvYUujKzjJXP7gdSz4NGe19yJ9o2fnp4u8Rs+2T4fDTiq5TX7d0uwFxfcVvXUfasEmSUc74Qq7q8HkWSDjO/AGL9HVb0bBmR/ev2wV15818QKLFDXBFl+j3HmGIDyX+dT1vQWLQ33Ls7Vxr2LGL4Le94kkq09ajMe6PjuG04nIDTT3aENtH3TlhB5w7QNODWw/MD6oiF/6pk60Y5kz2d/h8fWejXTBoVXHugE5wXhNlMPuPzVPatkiyBBZSX/9ZXa/k/Z9NKJVRyHBG32NsSJOa8CEdXr06ZK1jBWr4J40fuMPksUpxtcvyZxeuTUZNB40Mm2Eq+yeaHn6AUnjaWEb6ZWsHNegIyUoF3eLoO4bjoMnhx4rC+0u3y46b5l0NoQ5Zf/f8zKF7jRES8p8y0+2QuO+D8pDtIRmdIUBmI0amMFSdq9F6ylVblyNSK+IbZO4frCfZqA7O6Qwx0pf74593WVeWmvKVlIzhPQ3naKiB2VuoAYFnanQ5HZHtu5sIF7Fgl0YwzDXgfhDEZWqqBIMzmjJ9ok7sUN6c5uZEjAY2VxXBYKHEOOpRp3kwmacEa+ndM63DtDBgGg3an6S1979IXsljqfqapmWh/sNkDZNsYe65rBLnD62jP76S46iw1rTIUX0K6giJQVm6Dq4c3ua
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7icGMdeNqzAoJa+tp9F5HsO7j3KYKGkhi8woaCtXeZnM/Gbcyd8uvi2DTou?=
 =?us-ascii?Q?UqKiZ2Hmp8yolqd06FozUu4KIdalGPKLsbYPOsgs9RVH7TT/Fa/ZwuxB8Hus?=
 =?us-ascii?Q?JMw578KO95Srcs7/V1EDEmWsUpa3GaENcqShQuL89FC40Spsvcm842BoEJ1d?=
 =?us-ascii?Q?gqwYeaThS1wfd4GdesfjTNqFEJ/foruhxLK6u5miCbIIqkYEWkvjKkKyCh1r?=
 =?us-ascii?Q?RY28jem3NPSbPi3pVSc/lWjcEbBhKNKMtcKj2FSJ6TKLOPx6ugd/HW65/8xv?=
 =?us-ascii?Q?xgdVeASJRRboxn1GBqQ5vxeVyPkMJ39HUXT/yaY93pm69lEXNJifDsCW//FO?=
 =?us-ascii?Q?uyR+0a+4yMpxgh0K/cnNQIwRseHWbCy3e+alN/qZCpgKZJ37I+nApK64AmZ0?=
 =?us-ascii?Q?O1mh9h8Uv2yEm0jnb/SQtFfNf2tqlE3M8q8BwG9aRVWEMI8Ff8lKe9lzdaBT?=
 =?us-ascii?Q?v8KbLMSSYvkQ993mFJ3xfR1ycsN0KLp+Gpxeb1iLr3YC6163te9kQ9xWD/GY?=
 =?us-ascii?Q?PeOz7YGJEzQB7YzF/RmzAp10eUSiazA/AZ63OLyE459nZTAp5hRlvi2IL9aL?=
 =?us-ascii?Q?j3Fq9NFIN1YeCEI9EWHOq4QqCRsr4oSN0gsfG35/X3p6LrvMxcjEdoccVRGR?=
 =?us-ascii?Q?RHlpG8oMdRgYyn980W/qJYFQxEpY1FQF/6L2Z+7dyDJECNeZAhVuMlHOobyS?=
 =?us-ascii?Q?sjBsPnTkCDCxW5iJhKXayA0vnV3Upi0pcBhUBcrbuSALEewOowgHw9eq8UqN?=
 =?us-ascii?Q?Rj16SNzPLjrSrfhRnQT+b0Kn+Lggmi1x29CP/iGErdscgp3l5bP1GiFB+lgF?=
 =?us-ascii?Q?c8pEe5d4Xk4u6P5Ie4taJLtrZY/hsfzW9ZqsuQu73bws1tApUBqqdsNx+w+o?=
 =?us-ascii?Q?wL4VucGghnBSEQb5CUQj7L1Lw1kz5dQsaO6bH0eyNCFTORbSLU5siAceNpur?=
 =?us-ascii?Q?3PR5Qcjla+VXlMwe1DEy7cgXZ9Qv/fpBWTS4PNwrRElnIVsnySJggSZzfW7D?=
 =?us-ascii?Q?uTjGff1OC3+USDgcL2wfB4Ahf/6qlpgyA/dUYtTY/mafgnM6yZn9UreSg/vX?=
 =?us-ascii?Q?j8r810etNH+AHh800KCmWK8jebCbe27GpoYebFt/DfmHrEdClEdCbPbUBXx+?=
 =?us-ascii?Q?iOpZf0TpCgvplCDgyJkeEogS+AbYBDsmtHqzsyvBGh5wNH5geFej9Dbn/nMs?=
 =?us-ascii?Q?Ntmh4wzLt4xBVDqekJGfjBgiUljMUAMlVjMQ+mRVzzQRSUWgKSt+oPXz410?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b7cd46-5be7-44ab-7835-08dca89156db
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 07:55:36.2867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5726
Received-SPF: pass client-ip=2a01:111:f400:feae::80e;
 envelope-from=taisei1212@outlook.jp;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Before this commit, an HPET driver can not write correct values to
comparator registers of HPET timers. When I tested my HPET driver on QEMU, I
ovserved too early HPET interruptions. I investigated cause and found that
QEMU didn't write higher 32 bits of comparator registers of HPET timers even
though my HPET driver did 64 bits writing to the registers. When my HPET
driver wrote to an HPET timer comparator register with 64-bit access size,
QEMU divided once 64-bit writing into twice 32-bit writings because QEMU
allowed only up to 32-bit writing. In the twice 32-bit writings, first, QEMU
wrote lower 32 bits of the comparator register and immediately clear
HPET_TN_SETVAL flag which means whether a software can write the comparator
register of the HPET timer. Then, QEMU tried to write higher 32 bits of the
comparator register, but the writing is rejected because the HPET_TN_SETVAL
flag is already cleared. As a result, the comparator register of the HPET
timer had a incorrect value and generated too early HPET interruptions.
After this commit, QEMU allows 64-bit writings. So, once 64-bit writing to
HPET timer comparator register is not divided into twice 32-bit writings.
Therefore, the comparator register of the HPET timer has correct value. As
a result, the HPET timer generates interruptions at the correct time.

Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
---
 system/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory.c b/system/memory.c
index 5e6eb459d5..985a5bd2bb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -544,7 +544,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
         access_size_min = 1;
     }
     if (!access_size_max) {
-        access_size_max = 4;
+        access_size_max = 8;
     }
 
     /* Do not allow more than one simultaneous access to a device's IO Regions */
-- 
2.34.1


