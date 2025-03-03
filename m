Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A580DC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2Ec-0001tr-Uu; Mon, 03 Mar 2025 04:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tp2Eb-0001tI-Ji; Mon, 03 Mar 2025 04:37:13 -0500
Received: from mail-francecentralazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::] helo=PA5P264CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tp2EZ-00007q-Qr; Mon, 03 Mar 2025 04:37:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp+aR8gB63CQF2HzH0vEhcK7pW7ioA06dfakCLRbn8ygT7rsRHsng7IfpeswsebzyIoNsVAMvuu6wFVs6wbePmKQL8H4X9YE4i9/5ZacR4GYxC9OMOtKkABQXARGdNVq9KIjbdConYzLfielg54X+g3lNGrP3SX+JxkUVfXP7BMq0hpq+SDXZsyXoyPRYZ5wTqxzOsgjSghj2yFvzfTfdSoCZXeLZNs273RcPzeV1QYbQ64wQpy6iEOkU/g68FhpKEsUqvG+y5hL5Qpfg94dlDGdn9EGmQ3g+8y/pjs4IQCAMQGKgVX6um7KvddM0NSOldmv4Vs+Ia0TxpCZELC9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjZ4Kpy7JjL4nveskTvqweRdIFgR1d024El4qftx8Lk=;
 b=uKGrGDdCwrdv9Mzgp/nmrRQDwWmuwhOBFH2+ecLfglgVUt2c6s9ye01XhYq0RREmNaXDyvNLqfyIzl4Edl1+eEE0ftA4MceYeJh8z7Pbp2HnStB7qKYbE81+gQ4hGiovot/3pKUio7FsE678UQLW5rYqgqikhZ+kNyqJkuoz0R6EFRbBs6fuj3JXsrM4Lyx/R4JAsohk57/yR9fjoUTjeuOo8B65Npv69HwMT0S48K+fsV3tWPufStzE1xirFQiX13XJJrpZ2pq9jwN6GCrtz1mDpqZT1MCBTnI9YK+RmxRLrkSOwb62NxAd9nqlmgwLeh3+MGr7oD4fcPR96vFQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjZ4Kpy7JjL4nveskTvqweRdIFgR1d024El4qftx8Lk=;
 b=upjd6EUZcO3o2ZA7R7T5Jed1fVwna7YzjNIzI6dCtqR4zhzZjPUztPJ8Xbgq+xsZlCw213wFF7RwxyN6gbnoHLDcnmZtuBevNftmzo35ccr04fdTKvCvwawoG1Yo/a7wQS526ZF9RR62Qt8AAKXjkCvmxuxHZDuDxcnavgrjyM7Xz5moeL6vULP7Z8YevPWbWv3OzsHko5GuI7uXvpyDmOUpSQWFyh/zFAxU7M4/Vhb+0qCeCDNzfy8lLXH0zSTt27Gk7MSU76xLJ3MP4iKWMX8MSkOOQmNkNW7JIe7IUPkpwLOras0e7Zd2PHISG+gurSzOgowlapUm0tJ1+x3ZaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR0P264MB5530.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 09:37:04 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%5]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 09:37:04 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 2/2] target/riscv: Support matching scontext in Sdtrig's
 textra CSRs
Date: Mon,  3 Mar 2025 10:31:55 +0100
Message-ID: <20250303093155.35585-3-florian.lugou@provenrun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303093155.35585-1-florian.lugou@provenrun.com>
References: <20250303093155.35585-1-florian.lugou@provenrun.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0158.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::14) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR0P264MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: bb379a60-308b-48c0-166d-08dd5a36f52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SRZuoVR6TddCWdMGrexkEsytSKBMLVf1DzNVtU0NmqyIugNC3i35B+XqWS12?=
 =?us-ascii?Q?2oQzGduqlHqCDCD5SCmEAd53FSpM2VRbK/1luamCqBYKZ2t032tTHPfGFlKJ?=
 =?us-ascii?Q?qnngIAVqQ75R964K1EQMWwYEyLesmtLIZKlLke45iiwqUbdfUbtICz2uZRA+?=
 =?us-ascii?Q?f+yBw9kZ8tqFn95D8EViCuM/oDtqLNN0Fmuc6RijMIBBY6dlzjYFTRJYkuzU?=
 =?us-ascii?Q?kV/8v1R7XgUSMKTwmyHa1yAR3wh4mvSX/psHs+rAlQUNgYx1TEN/rXtZB9gF?=
 =?us-ascii?Q?Ae9cLAUQCyPCMq9j9ZFu5JO4Cdnrev/1g3o6YDtkyQBM46GO8hAK2ar5PcLi?=
 =?us-ascii?Q?GdO6FlM9RqQUEbWhe+JgywzdTB+IkjjMUPVqE9IxmQmrFBzoCGrV/oTauNn0?=
 =?us-ascii?Q?fuEvw3DonNl1gyihZKGu7E5y+/8Zl0iAnTmxIs4FUVi75g5/w5/iJUIq4Onm?=
 =?us-ascii?Q?46mHGArXkrvROaVeAbw8VnHDFy5RmeNMdpYEOnLbKeKzixI/u8dKBVT0W9ss?=
 =?us-ascii?Q?9YjvTuK7/0IVcocdUzkibD75HPqF9MwMdl9TVwhcrt/jWBrtNXcxSioNr6do?=
 =?us-ascii?Q?W6Xa5zuYaVSn+Hj37ilu4ZMqQ+si/06x7MA5+dmk8TnF4FI3w1DP70FoEKg9?=
 =?us-ascii?Q?SPiXIOGsi/GRoCzAuUdjqiRhO67vyuWImd3SiSSYn/f0g3AvUT73IoYZufy/?=
 =?us-ascii?Q?lNbyutxxAjKKhDvXbzo6A232IDI4GuuW/MfSoBknFTs7qqTpay8UavXhTdFo?=
 =?us-ascii?Q?Ro+FEo6v06Hs1+xxJIjakqk9wtuH/1B+57kZOPRqMSNSBHmnmqCs4f8VO4yb?=
 =?us-ascii?Q?fsdHUEY9uBG731mmi9ge01dbj9ErO9wNVlj55MPPDfq12Z6sEQUopBA2n/st?=
 =?us-ascii?Q?+qd5Pf9SBG58+Hf3qoY0PnK75EyuS21DPCIho+Qd8WdqoWY7busxya6bPkit?=
 =?us-ascii?Q?Sc5t7JPCJxj77WOYgtnh9ZP+ZWCbJjJfDopRcF9hw7wiAkUZfr45wI+ryNPq?=
 =?us-ascii?Q?EwIyecu+eFnN90AiZUkRN42RYnZPXMajcJy/bIwT7A4MPRxLxHhhYqum3eRW?=
 =?us-ascii?Q?WwOpl96bQ4Rc6hEyZpVVRsaG8J5O4+gKyLsfh2madPbMvoN7XSr581trnzRG?=
 =?us-ascii?Q?3lhFUKWfgie2FCcOXbJgWyI8KipIkUKCpvUD/7MvU3ae9FUqqU+/iCOvER5k?=
 =?us-ascii?Q?9GvLYmYONCP4YHQ30c3CMkBmM7i9whKUn5dC6+zQDaooPoEepVXfXnXVpXdn?=
 =?us-ascii?Q?1JdbFVHH7QzBK8d6a8cDBfTqsucLhNMRFWEJqGIJgXMw0y7leJ0uitfrIZHA?=
 =?us-ascii?Q?ey2c4mg3/jNBN2SX/8pNmozGmmDmHbVhRjZDPkSHWuhhiYB1YBpAK3wV3AAW?=
 =?us-ascii?Q?EkXxhT6BFuj8/ExVwxSROwN92CCl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sp/Vn4FvZAlYyuex8klhew/6eKVw74KTko4X69qLBvl5nLlMeuVvg3psisBj?=
 =?us-ascii?Q?LCdXDITqnuhzmhbUj9cAzDlTtVeIheMl1M/OKYgNyBrh7XQLpkNRnCC0kWXj?=
 =?us-ascii?Q?DaBn7R+ST6LfFHjTuwhUD9M7KPOg3s0FBNQ+zImbb3JXhJNS2feEl1AmfcSR?=
 =?us-ascii?Q?/yqVhbWwzc1V2jKiqZ0D/2O28/KkOU+whPU0owP1pWymHV11PkShA10ni9tE?=
 =?us-ascii?Q?V2lEOXgkpXBrv9WEgmmykigorHlOUvN3xdG/TTjfKzamC5VgBNWAbqaTS3X4?=
 =?us-ascii?Q?ydW6JLLAWqyN+PdWPjwvnXTVYUeh3IKxFo2VowMgHAEoQ+u/HaV+zHasWpVA?=
 =?us-ascii?Q?M4jPYgU/nSy2Pf8sgDx7/tgNNzW8GSdNOVh1OQ+9VyuSp8n3L5zxVDh8AxVS?=
 =?us-ascii?Q?+PfiG5BWlnZSkz4R/4gUSnU3JYWrCnXt6Yz0UEBFZpI6mqLmvFmEgjgWM5vy?=
 =?us-ascii?Q?xheGUJf+2jD0o4XqWdnkxQYa69TDDh0rmjdH2yig8ODruBvoYKWz4BWxYUkO?=
 =?us-ascii?Q?S68/OwZgYre6u5BHn920dEakn47O3M1p/CHcCplx8SQvF2OUPPuE7FX3M4rg?=
 =?us-ascii?Q?eHywImgfQoEfKbmntJ0jqguR/W0PNv07IUjU+/EOqKiAJqyBjUhhFx46rMg/?=
 =?us-ascii?Q?F0Lbqmhve/iP1seur6XN/00yk4i93FzFNzdZeOorEjilHY5CD+F2WtF68cjg?=
 =?us-ascii?Q?E41eHT+iutu0qwSmpqk/ppivNPLydBWzOdXWaEDHJyoXC5A2Yl2j8dGfLWQD?=
 =?us-ascii?Q?2vKlWMm0P9MtpOUPPGSicdEX61ONq+WuXk4gim2wtxrhP8MomoqZR6VOo0Pc?=
 =?us-ascii?Q?lf9qQFhUyDC0EMUC73iNwAndlEQlI/N4yUs7Pm280Q/AHgkec/v709RI0ayn?=
 =?us-ascii?Q?heULyjEVQzGDlt2l2q6dA8ayPgJBiJPKgrbxM3BpkiTA34jPUwtZKFzrWmy9?=
 =?us-ascii?Q?TDSw67GehmlFGoPYu/BS7WbHoDzmu0r+6Urr9dYfpNuEOMcGCNjroLkYTVEw?=
 =?us-ascii?Q?eG0kdHezF6r9qIZUTO9N+nj9Xlgy/5XlfFkuwRGGw6tjZvlbmupeEx/hvA9/?=
 =?us-ascii?Q?OGpM5ERMWbFvL4LoI730wKYwFMi2pYqd2XfElSHNdbg1lEbl3UEUq5heRNPn?=
 =?us-ascii?Q?jdEoAGApVfMcWCUUkje5pahCukJdYF9+GJElDzAiefU45i8ij4wC2XNBPv6I?=
 =?us-ascii?Q?GAVwhLAo0VZCwmioK71RZbSACSHGwfk7n11DWDiblONaETXrlywTUTrs9y8i?=
 =?us-ascii?Q?RwfOBK1oroSpLbxXXA/gi+uLGmnMIBdA0M54w2oVK//1/b5zCIcyPsyABsN3?=
 =?us-ascii?Q?NqtLa+SrSnbgO3ofpU/NBvepFH1+3LZqYqErtOPo3tPFbbEgjJGVKPC8ii+l?=
 =?us-ascii?Q?Xo8uiPQ0n5DZHg2HrGYba7+KXMo3v1nnJw0Nzd5Q8iJTS4IO54r3j1EMyi9y?=
 =?us-ascii?Q?N4cO1nj3ZQ8fP6Nv47C/UM30p7gvLEnJ63h7EFnqs9r8Qpo/L8qbF+3pT61a?=
 =?us-ascii?Q?ho28y/J40cZb4zpN29K7IgW/pOis4bKWoaDUJXJhy9C4oq1/NytL8v9qlul3?=
 =?us-ascii?Q?Ug/yHsgiPTRJc6/5JhCNLfC7E2iC4G1jAMHcGvMNbfd0h0XDSaziZA1VQ/ac?=
 =?us-ascii?Q?NSGWdHbhgUiw5vQ5oUsye4kDmzUdrqcStM/00yvogZNQ5T0mamVkR5mwLiS+?=
 =?us-ascii?Q?lpgJ2Q=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb379a60-308b-48c0-166d-08dd5a36f52b
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:37:04.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrSe1KSG8tLnXvu2LgADqiY2GFjEysbXQ2rTC7NGr3tJvR/x0kvEba5+aq/MuFJumqvl1lgMcc7TuixQ1UVNYNEMv4k8r7b4K4w/K9EFknY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5530
Received-SPF: pass client-ip=2a01:111:f403:c20a::;
 envelope-from=florian.lugou@provenrun.com;
 helo=PA5P264CU001.outbound.protection.outlook.com
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

Support setting textra32.sselect or textra64.sselect to 1 (scontext).
The trigger will only match if the content of scontext matches the value
in svalue, after it is masked as configured in sbytemask.

Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
---
 target/riscv/debug.c | 75 +++++++++++++++++++++++++++++++-------------
 target/riscv/debug.h |  3 ++
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 072593ab12..a64dadf6d6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -219,8 +219,8 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
 
 static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
 {
-    target_ulong mhvalue, mhselect;
-    target_ulong mhselect_new;
+    target_ulong mhvalue, mhselect, sbytemask, svalue, sselect;
+    target_ulong mhselect_new, sselect_new;
     target_ulong textra;
     const uint32_t mhselect_no_rvh[8] = { 0, 0, 0, 0, 4, 4, 4, 4 };
 
@@ -228,25 +228,17 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
     case MXL_RV32:
         mhvalue  = get_field(tdata3, TEXTRA32_MHVALUE);
         mhselect = get_field(tdata3, TEXTRA32_MHSELECT);
-        /* Validate unimplemented (always zero) bits */
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
-                             "sbytemask");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
-                             "svalue");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
-                             "sselect");
+        sbytemask  = get_field(tdata3, TEXTRA32_SBYTEMASK);
+        svalue  = get_field(tdata3, TEXTRA32_SVALUE);
+        sselect = get_field(tdata3, TEXTRA32_SSELECT);
         break;
     case MXL_RV64:
     case MXL_RV128:
         mhvalue  = get_field(tdata3, TEXTRA64_MHVALUE);
         mhselect = get_field(tdata3, TEXTRA64_MHSELECT);
-        /* Validate unimplemented (always zero) bits */
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
-                             "sbytemask");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
-                             "svalue");
-        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
-                             "sselect");
+        sbytemask  = get_field(tdata3, TEXTRA64_SBYTEMASK);
+        svalue  = get_field(tdata3, TEXTRA64_SVALUE);
+        sselect = get_field(tdata3, TEXTRA64_SSELECT);
         break;
     default:
         g_assert_not_reached();
@@ -258,17 +250,34 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
         qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\n");
     }
 
+    /* Validate sselect. */
+    switch (sselect) {
+    case SSELECT_IGNORE:
+    case SSELECT_SCONTEXT:
+        sselect_new = sselect;
+        break;
+    default:
+        sselect_new = 0;
+        qemu_log_mask(LOG_UNIMP, "sselect only supports 0 or 1 for now\n");
+    }
+
     /* Write legal values into textra */
     textra = 0;
     switch (riscv_cpu_mxl(env)) {
     case MXL_RV32:
-        textra = set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
-        textra = set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
+        textra = set_field(textra, TEXTRA32_MHVALUE,   mhvalue);
+        textra = set_field(textra, TEXTRA32_MHSELECT,  mhselect_new);
+        textra = set_field(textra, TEXTRA32_SBYTEMASK, sbytemask);
+        textra = set_field(textra, TEXTRA32_SVALUE,    svalue);
+        textra = set_field(textra, TEXTRA32_SSELECT,   sselect_new);
         break;
     case MXL_RV64:
     case MXL_RV128:
-        textra = set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
-        textra = set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
+        textra = set_field(textra, TEXTRA64_MHVALUE,   mhvalue);
+        textra = set_field(textra, TEXTRA64_MHSELECT,  mhselect_new);
+        textra = set_field(textra, TEXTRA64_SBYTEMASK, sbytemask);
+        textra = set_field(textra, TEXTRA64_SVALUE,    svalue);
+        textra = set_field(textra, TEXTRA64_SSELECT,   sselect_new);
         break;
     default:
         g_assert_not_reached();
@@ -368,7 +377,7 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
                                  int trigger_index)
 {
     target_ulong textra = env->tdata3[trigger_index];
-    target_ulong mhvalue, mhselect;
+    target_ulong mhvalue, mhselect, sbytemask, svalue, sselect;
 
     if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
         /* textra checking is only applicable when type is 2, 3, 4, 5, or 6 */
@@ -379,11 +388,17 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
     case MXL_RV32:
         mhvalue  = get_field(textra, TEXTRA32_MHVALUE);
         mhselect = get_field(textra, TEXTRA32_MHSELECT);
+        sbytemask = get_field(textra, TEXTRA32_SBYTEMASK);
+        svalue = get_field(textra, TEXTRA32_SVALUE);
+        sselect = get_field(textra, TEXTRA32_SSELECT);
         break;
     case MXL_RV64:
     case MXL_RV128:
         mhvalue  = get_field(textra, TEXTRA64_MHVALUE);
         mhselect = get_field(textra, TEXTRA64_MHSELECT);
+        sbytemask  = get_field(textra, TEXTRA64_SBYTEMASK);
+        svalue  = get_field(textra, TEXTRA64_SVALUE);
+        sselect = get_field(textra, TEXTRA64_SSELECT);
         break;
     default:
         g_assert_not_reached();
@@ -403,6 +418,24 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
         break;
     }
 
+    target_ulong svalue_mask = ((sbytemask & 1) * 0xFF) |
+        ((sbytemask & 2) * 0x7F80) | ((sbytemask & 4) * 0x3FC000) |
+        ((sbytemask & 8) * 0x1FE00000);
+
+    /* Check svalue and sselect. */
+    switch (sselect) {
+    case SSELECT_IGNORE:
+        break;
+    case SSELECT_SCONTEXT:
+        /* Match if the low bits of scontext equal svalue. */
+        if ((svalue & svalue_mask) != (env->scontext & svalue_mask)) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
     return true;
 }
 
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a..16b66441ca 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -134,6 +134,9 @@ enum {
 #define MHSELECT_IGNORE       0
 #define MHSELECT_MCONTEXT     4
 
+#define SSELECT_IGNORE        0
+#define SSELECT_SCONTEXT      1
+
 bool tdata_available(CPURISCVState *env, int tdata_index);
 
 target_ulong tselect_csr_read(CPURISCVState *env);
-- 
2.43.0


