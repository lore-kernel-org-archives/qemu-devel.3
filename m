Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TlHHdwr0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLePv-0002L8-7E; Tue, 27 Oct 2026 06:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icheng@nvidia.com>) id 1xLePP-0002Kr-Cs
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:27:59 -0400
Received: from mail-centralusazon11010014.outbound.protection.outlook.com
 ([52.101.61.14] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icheng@nvidia.com>) id 1xLePN-0006HS-5U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:27:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXvzJ8MMjWOEfXur4iM48P2yxuOcylVl4IOMDjYrKdoiyAwGs5mDXr6NKA99SneeEsceX5XroyrkberE5QyGGRetVdXLePBV0mfhyW+cc5lRDMxXGcD1pZnS5L/EekRL47ldKnIR+TNQuYCNZ9c6r6EjlCux55Y5xnrMw9UqkJUJyAr1FMMVRyY+QvlC5haxSVACc+anE4DbDrwMRA+4+UkFy2AeKqv2Fy9HbzzTqZ9kb+Exrus+fS5TaSABwB1E+VIwtSMnj4DJWYSeO3uY37yyA/6jKHtBArY7qZuLyHyLeIleVaJ8OpPwJdSsWbylhM6l3Hjcfg+/vFyOO945WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0WLszNaWE47B/kkbMXtoSO+FszyZuIixNeOWQOpUuM=;
 b=sJKCjwg66SMoBv+EIyfuyCwd2vDkzl/ksBbCeH0LOuh3TRgw9PJHkh5gdBElkF8lnq6dBjEd6m8rq1XZM6ZWe6iyD2qua3LrpEIJ4pb9hRNCBd1dptX2t1c2zF7KtdnSRKg7xlvSfoashpq0Xa7sh3IArwiLZenHXa+jrhb1HY37nVdwMiUiY5MKzprMgff8d2Lat0m475Kqqk2uHF9b0J1MdcaBddx0u1vP/uWyhyGT4On+wKs0Aw9LY6a/JfUS/hFsenAZ1ahH6HOV/k7uYQCBIg36IJ/hpLekCJmD+NHEkkhdhDQ8OnDiIugJD6CzDLd8GAdZfLZ2DffK56y7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0WLszNaWE47B/kkbMXtoSO+FszyZuIixNeOWQOpUuM=;
 b=TlHHdwr06A+03/8wAhz/ejFEAP7jE//HwQ91uLQ0DB3p/H12n06I+Mx4WyUB9Y4UqGMnUXNdsKpiB9+fFRJ8YTFWpRKsjaFp5sGDTGIHpNeQFRMjhY0UtEyJ7MnN8wd7a0lMicxWrQv6pgnHz3yQCQ+iCxGm1DNnQ6Gou2J+9MyTGGtZKOrQwF9XhfEbPkDHFuNfhk8TcU9KuGElpaWHIz09SMNrK8Ru/d/c3U7aKrVNeN3lreUizoX0dzpjuuyTITmM59t1z/qq5R+LeQsWv15xepYiY6VxByeoUc3hxFh1njksRoY6iH7DytQhzZZ9kue7339VaumQY+Pfif4cEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA3PR12MB291063.namprd12.prod.outlook.com (2603:10b6:208:711::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:22:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:22:50 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org
Cc: junjie.cao@intel.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org, Richard Cheng <icheng@nvidia.com>
Subject: [RFC PATCH] hw/cxl: Align mailbox payload backing storage
Date: Tue, 27 Oct 2026 18:22:27 +0800
Message-ID: <20261027102227.4976-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA3PR12MB291063:EE_
X-MS-Office365-Filtering-Correlation-Id: 412eafb9-4301-446e-7bb3-08df34144097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|261026140227099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261021123027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /US0KeHU7mjQoFpPGf0HvLmCWtvt8Zv9NclTe0B+aKl6/t+xAyOw4CE8KTWOGffWj8cTd4K6VVv7j0HcR37oo43zEDQWv0wTkD+sGc/Yv5W3XGVsz4X2Y7icBNrvkwn28Q4IzSVxAvJ1UzcLPsww3OHYJXh2p3oVLh6ChAfzh03B2HrL9+T+cIQJN/unt3mHTKBVdcS42C0vCsMZL0/J+agxU4F3G866s5rtuVIFpJlIod9OYX53+yyGME4/t58OI0TzMc4oeDDdE8DxFmfqLPgGDCbiGRuHSWN6SShKWH11k/RSvtEdI2TIfuHSRc1e5zrP3FQuF7nzsl68fXd0u+nAJDyenmJu8xOh4VujcWFeDGqbWQH43GBztnpGjW0GFppbb3uYe/vXiSvPJG7BOazDfFQvAyERhveCV/Wh4xrXYuUusZhSzyISFPfp3DeexZcJNrA2EyilGt09iLc5T+K5VdLHl7/CoLoba3zL/IYKuOa8mhR4OuONC3Elmw3Ip7OgF6HsNixvr0Z34YJ8oy1lyRWw9Oubs3VlepnQUjmmBKc+iE05xD1+s8z31NENgMIaNo8UTee9j+V5VbZOzVlYp8JYM7dRguNrXuqvHl2eb1T1oXD6RFyJvm33NzhlKU50ZcAmRtG4JToHDSsx450oF+cplsSlGMatXi3ZN7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261021123027099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGTv/tpaMJVoGdOLAlT9eK5R9S6+hkw443tjP6PSxf/W/oVSwuSMyz5kCyvR?=
 =?us-ascii?Q?iAWCWuAtI6AfDB3Jy4g5Rq2HYRBXKy8Jk8ai7mksq7mQR4lxSbTbu4K/zart?=
 =?us-ascii?Q?BdhcTh8V4FKLQFvlGr5xtsEDbTiKpa3LYglXtk3U8QKkaLqxHQIk+FMJ0bGO?=
 =?us-ascii?Q?DH4ibxdYv0UGfgSMeXEQpWGRe/adFe/15TClzSFGp28bvPpjqyfd8yHJ5Vng?=
 =?us-ascii?Q?WrRlOH1qY+pFJ7BVQD3oYlU+EaA1O8E1hTGkGNXKszUNxsk+AzINgvO5aQj6?=
 =?us-ascii?Q?7eV0CZqBCCQUwnUtn1AqpBCzNMY/Y2blSOkO8XcjbCPRThx84WbwQIs16NUZ?=
 =?us-ascii?Q?LaeXCt4I0oks7WaOaETYM3gJt0aiVBsK7wxfpQfnnsNaCyBRxqQAVlUOJQ5G?=
 =?us-ascii?Q?tWV9apVDKjT2MIosf4yr6JhaqzoZXH5X0m1X27wVmc2FHikGaQVb9M4tqj59?=
 =?us-ascii?Q?OzWvlfe9P72ujuE1BQMJ1B3w7WKIID7TwTS3dBtzLQ/bp/6uV1RceGrPrRWr?=
 =?us-ascii?Q?GfcmZJRR/u9GA9qhLTyU9rkVZ/QRZhdLssxD3DrL2Iel8m67WKo1PKtS/N8E?=
 =?us-ascii?Q?YeM1MH8K+tEnTZlY7lb/tBX04LimWaGVocXN7DurBKvNe0567Wd/QVgLENEM?=
 =?us-ascii?Q?UvtHArfI/hn+fsIBeCHHMRa6aR7S0jR0s9SYowJSkKrKRRa7kwZ4E3h2csGf?=
 =?us-ascii?Q?9JR60+sYQ5H9LHJGBWOo3F2DoPsp18/FVpr8carVCf00ZjGQMNjjwxOw0gDl?=
 =?us-ascii?Q?kmudEEvxWNQARbRZjFLa+YE4wgAjgqA3Q0wODewsZYwedi5Io9mUnoO0rBxl?=
 =?us-ascii?Q?FX9Zw21B/7X6PCjDwUCQLliwl/BXTe8FB5egj7IuhbJEb0IDER6u+QblBzEq?=
 =?us-ascii?Q?VLhUnOtNPh7YLlRkMB5fi27SX9f3AvoP9kn/t0YhIi+xDr1VQVeH0UzIJbup?=
 =?us-ascii?Q?uQD/5UJatUj/2fmfJWTUEiwT2H+Ksz1CB+GJT17a/KzlJevZkx/5ljYjhvNy?=
 =?us-ascii?Q?ZppFcpM2JDH1HoW/V82R9s8mrL5oomfk/uSjD0fpMUNfMfGuWWNo/vcoIk8o?=
 =?us-ascii?Q?GYXYV4t490ua5LN8sjkWw+QtiYh2UColXbvyJ3Ow/4t8WSt+kw4VJMJqTgMI?=
 =?us-ascii?Q?auGb9mxpiWZfSPvKKq67BsA3FU9ZpxT1i8bkcjbnMWUHS8lrowl9GbOl5IVG?=
 =?us-ascii?Q?PUiUyXehcXHpXgESflGQBb2HDkLPryxc88OhOyHDJCn6W2LoNJWg9lkw2RnH?=
 =?us-ascii?Q?9V5vrEpfIdRdVbq34NrP/PrlEiIUD/cHDYBc23eJVA3Lv88QriVQaqHpFrWY?=
 =?us-ascii?Q?keeqmqzMw+AZpNnb6QhDlTFCRfTqzqf3zx/ChsBaD/1uS5F7+FUWbBf3mJZn?=
 =?us-ascii?Q?LjwrSyqp9vO+5h062Dl0NFaBbuK6oksNYUA75/K9zbmT8xQd+7S6xzVOYGLD?=
 =?us-ascii?Q?uetuKWJqdnYi+t85z5rV/U/CzYpa7xJ1wwNkJ1lMkuQET2Dq2plnOUMTvnoY?=
 =?us-ascii?Q?yexH9PBPM+aDdcHGbYiuXoOzFynpl5AqpMohCFA/2SJa841P+qPlIGHZoM3C?=
 =?us-ascii?Q?6Cgk6mZYBjZqgv8Xi6ZoxwFhP3nRpyjt4Gf4SOa987GIgFJQEqeuDclyE+ry?=
 =?us-ascii?Q?ZzdUn/vwcthVknOTNjjdtcK2ze6xHz4YAYePd98dSWbYu63CAjO8ioTkTOho?=
 =?us-ascii?Q?LyIacyUpB02DuHn4kbaqHp7SxuFQ4Yc5tUxK2Qc7XURBj74nlFwO7i54jHxe?=
 =?us-ascii?Q?v7bE4Isu/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412eafb9-4301-446e-7bb3-08df34144097
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:22:50.7858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94v9CDnsET3JgSSZCZv2b3oFLYK8U1MuH4SSDU8zGT1ALFhl8yPw6cYywBc0jo/R2xGByA+jqvoBw6Kc42V+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB291063
Received-SPF: permerror client-ip=52.101.61.14; envelope-from=icheng@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Get Supported Features handler treats payload_out as a 16-byte
aligned structure. However, the mailbox register is aligned to 8 bytes.
Since the payload starts at A_CXL_DEV_CMD_PAYLOAD, a misaligned union
will produce a misaligned payload pointer.

The bug can be triggered when QEMU built with UBSAN:

  hw/cxl/cxl-mailbox-utils.c:1571:39: runtime error:
  member access within misaligned address 0xff7772f3d628 for type
  'struct <unknown>', which requires 16 byte alignment

QEMU aborts while handling GET_SUPPORTED_FEATURES

Didn't see a strong evidence why QEMU would treat it as 16-byte aligned,
so I want to raise the RFC and see what's the actual corrected fix,
rather than dropping the aligned tag directly.

Align the mailbox backing union to 16 bytes. Since the payload offset is
0x20, payload_out now satisfies the handlers' existing alignment
requirement.

Fixes: d80378943a6b ("hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Reproduce with:

    1. Configure QEMU with --enable-ubsan.
    2. Start QEMU with UBSAN_OPTIONS=halt_on_error=1 and a cxl-type3
       device.
    3. Boot a guest with CONFIG_CXL_FEATURES=y, or reprobe the endpoint:

       # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/unbind
       # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/bind

Best regards,
Richard Cheng.
---
 include/hw/cxl/cxl_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa..2191b7c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -248,7 +248,7 @@ typedef struct cxl_device_state {
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
             uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
             uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
-        };
+        } QEMU_ALIGNED(16);
     };
 
     /* Stash the memory device status value */
-- 
2.43.0


