Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3896DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYyb-0001zo-BJ; Tue, 30 Jun 2026 09:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyY-0001zB-RR; Tue, 30 Jun 2026 09:58:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyW-0003om-QV; Tue, 30 Jun 2026 09:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI5QFdAzE3QrWwFVv4RJ2JVXuhpo9Nl9lj97Yv4+1QCGRvwJHQ3k10EI60A3yDRGql1DPd3rmFNqckPm7Bu2ydVKq+AOvMfqmQvNZOE48Bfw3rbOVB+UgzK4f8Hck5zVkJjyJWhkqzdtAp8v6C7CJk2vdDIfF5WBzH5KKsmdTlOyGu3GzC/b8TARqjBh29bVNTj+8g4SVbugJwdI/ezHhaXLk35oXSH07lkZheRcoXr7AQ4CGx1hw5LDPErREokbrHVCX8KUp6j3mdJN4+KwK7pKxZxzMq3vhvgtYp2/xE5dW52Gz2qakwepDmX/LJC3e/WTwncTUIGwHt91nzpKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSuIJaaPVfoo68DMqCwnOzkDYqtrgDihQZjSYqgQeJQ=;
 b=ADFI0lGrb8CR0jVArC+x9F8Js3lIUNooQdZoFJpAiH2qqE7fkc32XRUDQfzJ+wNUicNovVHZD2caQYD/uycRwuFXtgjVQljETHvonldd1eA3cUh89Dqxzq0DNuHpNI9T6Nx8pTYnclp+tB+rcu8wEMtlLaFzFn3esm1uSj+u83YzsmJq5i/Wn6C50Bbe7ONErtFG+toERdI9FM06ncOY7ZAy+PksXnBrs6CvCD4pnPTLzWSh1f2m0lCFpc59TzWTTezbxQwyrhmmcRR/UQxM/AeHbob7O5NIh9An6xqeR0b15bDbDXE0wnUd2gpNzhkL8xy4+cUOnQIFsZ64mr8Rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSuIJaaPVfoo68DMqCwnOzkDYqtrgDihQZjSYqgQeJQ=;
 b=NXStbrkrrew+1983mukzUTDMitu7VbNBqQqUz/Wu+l+elG3+KW6SCrk/TnkiBuwGJ/FckFPxFJQ+TdPzBCA2e6dU6r2cqjY5q5LVFfLSieoV2ZHIYnZNg4FR1d6p2Jms6cF5DbVqZcwgz/Jfl/TsaQ/gDYmsRCpHVTO+scDNofp33tsEIv+nqaCDbmVzSISdWgEy9kNwJoRlL4WSInTPJcwR86KnN6DMWv5zYEuvso0+TjkhEHffWf9Wf+ROGSq1unSBK3uYcPigQiwaMnd66wBvH15I7xaQ0IQaAUhqLgQncW7WKOKc/2fSJ0IUoRJhgUn2+Kf/JHo96HO6dKiSKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:57:59 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:57:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 01/10] hw/block: m25p80: Fix dummy byte handling for Winbond
 flash
Date: Tue, 30 Jun 2026 21:57:20 +0800
Message-Id: <20260630135729.466264-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: f349a961-43f0-4770-87b0-08ded6af9741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: aFWCodoeuinjmO9wQl6ZdCtqgCjRLZqVeGb3D0T4qxAJAtvjGSBaXCOQA58ViSe94i6OOg1epsNqM9/mn8scJlcKmjRvg69myU11IctkzBzBK4+d5bPnyhEUvz9TKBQGpzQ7j7EPDbiZB0G8uGbt6/k/GUUhq9RZg6f72UgmKvnyXpFBSyhQHqopA5NKFZPGDczEuV1BmNtrJ5tIceEhOJBZqPtKGO8w3nfHwqfsHOY3GUafsuwSBZBgXw9Fnky3VY2jIn4e9nUZXiaJeKTU1mt4Hv3tRWbOaZ+pHdVfzR5xjUMbF0fw9UQ30ZG0p4MlJO8lkoY1Fnw/Go937+2R6RsniLETRGBTZpSUYOeLYS3sj7Crt8E6OGusKb1143kHslqqzmLDoRpzwgfjO0dSw+S64tjQZNChTwcAz+q3MLSSViK7Vj1dSnlqBC6weyA2ikqF/vjL2pkOOw7Hp/r21YW/i3THzvAldAXYd7uRk5TYmuVwl0WU6lNod1/f3Ca3PBGedZXkF8lqd4gaSRed0VhoFgt2dXKRB3nfQ3CvXPG3niwQ5VPVTSGEUJ7gua3Y31kd/TBp8WrVLpPMeLP/Izy+vrS2sxNJbDaSKhwVwQZ4UaXEhaEGFjbXZ1IRfTNJSGQO0QXpfS4OYuBDCmAuFOLFUZbmi4FZDtk7U41Gc4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tApaf34gIDpT/bogM/bmbwVLn6vxe4QvITBDtMhUW0wW9mELxGbwjmP1e94Y?=
 =?us-ascii?Q?H9M7pr+Aw4kxBYosh6ZjyblRPMI07oft3USzrj2VM1U2hdb1EDaXL2WHX1Tg?=
 =?us-ascii?Q?YEMWfkZckE4PrztTo9LC6g8yM9KBx2sS5R9OZiNAZAVBMMoEPRSJ5TCYxg7+?=
 =?us-ascii?Q?yjDwaKF7bgEtquuf+JNimsLJOLt1Y6cwyHMUaAsQYvaEdFQzOxlT3hGK4//Y?=
 =?us-ascii?Q?c5E92arv6SLe8Jb6pCj9o/K68IrbrEW8Rwg01OVX9zU41qOLf4uJpgNchTlx?=
 =?us-ascii?Q?Nutc3Owt02GIWYAzIjEqRb3pTKYa94oRW+qAUu4MQkOz6evvLSWrQ4VmhCk0?=
 =?us-ascii?Q?TA4K0wywNvF7vt5fm078uPovXOIRfmLl/lwlKQzyWx9oJ0WypA6mxGZ9pfKm?=
 =?us-ascii?Q?9see+Mr9bhmLO3Ss3ocBHG6boCwGDukmaYQa87C+RtGV/EFR1i3FuTIr+hmE?=
 =?us-ascii?Q?GujUUcMtXbFsMUEk2ProtlHmJ8Nteh/PlQfJ4JNeNU98rcf2hfFsgDghlW7I?=
 =?us-ascii?Q?O52NPYZ0uKw7QIN/oEddpVHPQvW/e0I7QerF0IcQ9cnPF8Z2bLPUN0sjuYr/?=
 =?us-ascii?Q?nipfZmSrVVFtK/++Z8RXdsco1u8ny22CDG9CPCtKC+H3GUwj/HUzE6xd3Xeu?=
 =?us-ascii?Q?FIz68M4Pc6q+gwNqAq4HBzr3frXvCB5QfdrJJg1O/sqZ16XBr7VxbUgBRAta?=
 =?us-ascii?Q?ITfiow8fF5IQOFoO50Co5xfRrSscrsr7fJyd2DSSyRzUit0nxziMCrlrDA15?=
 =?us-ascii?Q?mjehiVjmD0Ndr2215jMgBnDBVguiaBFGp2TBCF1wuP6HMuZ8kZd2G75XmVYT?=
 =?us-ascii?Q?X9Y16NGOO9XfwSvwzwxvj4UFmABCcFKmr0BmVTdxaD8gbsCaLsbWCr3jcDFh?=
 =?us-ascii?Q?p7/din5z3eJ7ggT0mXji2TO7lsD4XU83jxnie+bhS2uwfPbNsLheFr15cGKn?=
 =?us-ascii?Q?j0ZlVQyqBOjHG7KozODPvEz97YUeaAovY3QqF3bNApElQauCsMicjx9+/dHk?=
 =?us-ascii?Q?vnIIWQ0DRJPdQxvxskWA7jbSs8mrHcDEBKjLJ5ljdhD/iRaIeGVCqhks/Flj?=
 =?us-ascii?Q?OS2cJqv7NxIq3gjvK00Mc5f0emfwacEye6hCUuax+Ud/VhslJ0mmx+lI/25e?=
 =?us-ascii?Q?dVwiWFHl5gxWDmujFAA6VwacysX01ddvpLGKnmpGLMKtKwmgaG7pgGkBY/D0?=
 =?us-ascii?Q?b2Rp+yyx/lkRSjdztLmz4NNTe/sNs5WJbPo80n822nftlZcMhtPnBkAF4JOb?=
 =?us-ascii?Q?N66OGpypdnjWZD70BmM2ThRuL+Gy5FwB2ZNDze6DIyH8HUz/H4/CdGhfIIqA?=
 =?us-ascii?Q?DryedS+5MY9j4z1YvOg3T5y9T5GAwb6DVPYse74RsbwuwIzGNGGj/I0vVxrk?=
 =?us-ascii?Q?H3HqD3JC/dizHuqgBPvoLPIdYFhW0c1ua6a8aqNq+rLnTS+6Pzzj7LfGyA8Z?=
 =?us-ascii?Q?LizDHea4y4A92mLWV15IaKyBnpqQ2whsSpbd0T+EWxgc8pm6FuNz1chqXGy/?=
 =?us-ascii?Q?4RoFRQnoNvvo+BK9O0wn2rTaMIHUEF5sZ2LIQebNqXj8WNIOCcLpT4VUVYyg?=
 =?us-ascii?Q?6DhthS7m9DCOrphQtpDCxi5oZi8G4SuJLAYmi5keQGNUTphmXkvtlDgjYTRQ?=
 =?us-ascii?Q?omD3FG51ZQpduskkRkLrVNdcB7U2fz1Ja9rqj/KPWDfj6YxT4CNXqAhojtC/?=
 =?us-ascii?Q?Ak/bEHhNqLfkleqf+j9BqH/U73gkO3E1bEnbKpyNGhwbO0Z8/XmFYWMSJdcA?=
 =?us-ascii?Q?bH+hcS8VW2GNBi7b/kYOvpMYPHBqe8A=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f349a961-43f0-4770-87b0-08ded6af9741
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:57:59.0135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycp7zRUaSnAaiV+rbxmW7mnYY5oV3mwc6KwglTniCbVZw9FJlQNcBycno88R2NWBe/OcLaID3sXqNK1cG96Og8v+g3k9hwLlvvw2hfZ4o8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The m25p80 model uses s->needed_bytes to track how many bytes a
controller must send after an opcode before the flash model can enter
the data phase. For address-bearing commands this includes the address
bytes. For fast-read commands it also includes the dummy phase.

The tricky part is that flash datasheets describe the dummy phase in
clock cycles, while the QEMU SSI interface advances the flash model one
transferred byte at a time. The dummy clock count therefore has to be
converted to the number of SSI bytes that the controller will actually
emit.

Some controllers have drivers that push these dummy bytes into a FIFO.
Other controllers are programmed with a dummy-cycle count and generate
the clocks themselves. The flash model still has to use the same byte
count that a FIFO-style controller or the Linux spi-mem layer would use,
otherwise the model waits too long and drops the first data bytes.

Let's fix the inconsistency from the flash side first. We start from an
easy one, the Winbond flashes.

Per the Windbond W25Q256JV datasheet [1] instrunction set table
(chapter 8.1.2, 8.1.3, 8.1.4, 8.1.5), fix the wrong number of
dummy bytes needed for fast read commands.

[1] https://www.winbond.com/resource-files/w25q256jv%20spi%20revb%2009202016.pdf

Fixes: fe8477052831 ("m25p80: Fix QIOR/DIOR handling for Winbond")
Fixes: 3830c7a460b8 ("m25p80: Fix WINBOND fast read command handling")
Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/block/m25p80.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4a4cda6602..59ecb32c0a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1004,7 +1004,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_WINBOND:
-        s->needed_bytes += 8;
+        s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
@@ -1099,7 +1099,7 @@ static void decode_qio_read_cmd(Flash *s)
     switch (get_man(s)) {
     case MAN_WINBOND:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += 4;
+        s->needed_bytes += 2;
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-- 
2.34.1


