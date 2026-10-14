Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ADFCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjP-0005dy-MD; Tue, 13 Oct 2026 21:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjO-0005dT-MR; Tue, 13 Oct 2026 21:24:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjN-0006ql-AR; Tue, 13 Oct 2026 21:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UknMKUUmCxm+pbIPbO7HmrLBgShw2gEIdQ12SaH+noZ0qS1NB7WLjfsdr60B7f0bdAKAsVy1rnJ7Wg5WgPK58vtACnzg9nwAe+qEWTl5PnrBEsOTDGefjztkbCISHw7WuUc559HGrmDiAqsiJZmXAXeHR2/UHvOyFUXv7XQmKiUfofY/9+VLOsxyX0unPinEMKzMxkpDw5nCmVfqh5QmZ19qjVxTovIBhpcFITUlgqxjFuhIaI9/iBzNAC84RWMAUGMw5wKZYqTFfQ4kU4DYPgEn6MU72lmAiiBaAVkVlSS0BeElChI3J9m/w3meNdSj3I37gfLXjkIZpwA6eUvgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMXwf94Dgj7I7H5zLNSVb3S04nW/kNnN2hEQOqdUxpI=;
 b=jBeFDSm+3zWt4e0cu6gp/+BevBkWjyC5v6Xi0gLwjp2M2twTOeLKSFgByNgiBupfPb8ytZzi+EAuD6UjWGfwsIMhvMsQ8XtuI/F0P3QnYAaB5eg+2Pob/P3tGvMfOw72JpOaq1rY3Y/8Kwx5Mw7ekzeAxYODiMKaTuHSq+gUt7HBw7sCyIzN3VoI1Q49jj7gKtohXWdZpMFn9d9HwGgeIrwp7/M59I6MdY9CjrWJ4pD1DHDy2691GFI0zANrkwTJrnjXz26mLKdQIXp+Zkg+rCPOOuQFqg/vOVgyRJFfw4EVL3+SpQOX2c6t2Eqv6dYTorbLg7Fo+HeMfe2l/rlTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMXwf94Dgj7I7H5zLNSVb3S04nW/kNnN2hEQOqdUxpI=;
 b=PxhKGmeegJS7V9hUWucmLbuGBHaMPNzDv2lIa1pPT702nYqivD6jdHbOeLT6ssRsyfG0kAOBnw23JVGwC/43QtqeD4Zk9wXN/rnCGS2vXSNVVIUeYwOQsPkNA4Pvo36KUI5zFPdaN/9TWET60IwcG+XycOmwGk9hbmin8vb8SiSD6DXKFLSI4LkoDlrB2xSAXky6GA28NW3TEQpY3SjRKDLttYJldRbPpA1RAIFe5TBBYIiUbcK2UM/yI6ZF1eSiCMCfmNnLGQRdIPnDKXxjds4NTxTbHvL4cgiLa/cHZ314/rY2fxpH7C0TM0XwCfB1YGK2KmDYh7vXOqNKIeJzBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:21 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 13/27] hw/riscv: pfsoc: Enable 64-bit SDHCI system bus
 support
Date: Wed, 14 Oct 2026 09:22:53 +0800
Message-ID: <20261014012323.322790-14-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f704035-1936-4c76-4b76-08df2991dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z8TrIahHqB47MnOGrdik/wnUr2zH32Jtd4XUzY+9rCsb+zS2om4BC3rH7CZba7s5ykYcr0VPjnlimYQt3PBQn9eSCgovWggluCgHNU3IdqcabAGVSVByLhodY5GIfMnqxxjiotiimOMvKEiVfcqIVTgKgMGycpL6Jv/f0ssVBdpuabbwWWxrV4uBkJykXveBDsBpFRZJ7EopLq/yyESXVu7sGLoJ3QRtNZ8PAsr5PwvJjl1ky45/JISnl+LDx7c/qnFhfbeMq6OGdAKgIlPYYOFpFEbo2+9Fu5htC/T3ZAS1Bmvn//KIJ/qDp20RIJtmMEE+I1IVjASS2uesiuqy9hE0X6NwhOHwmrpcxzu0W8E8tiEn4oFGOxkVRw/czY+GtV0lDqBHDz6W/2LhPeW331n9NkmsraDNtaoVPC364un/3JcEIZWv2Ah70hg4lPzckg6Cgqx0NpFovCb+GK4yKmmAzqHEWAyWoeshOsqw4UAlg5XBFz3bJBnfv+p98tm6gPHfIw8AQqp1b8YpgkTwiq/PTODfkasiWZ8SBSqi3+BSXPJI6U6hR/QpdqTZAmyB8EWl+MJCIvRDUE/9v4IIJNIWHCZCe5KyWeqnoZA5ZiDm7LNFMN3pHoNlf1H6rzC8cQzeqmiYxWe0MGc0qw7fUUs+isEsQmAujj9AmdM9GPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yJl68ge2UexjFFZLSNzVhIiI5VkKfGW1q4wG5YAbUQQnqQQKH32W823pwJx?=
 =?us-ascii?Q?rDBSl0OLggbDAWXk1krMwppe/gNHDiH4yGcDmVwfGqhjSSIkxZ4hZ+1tz0YK?=
 =?us-ascii?Q?5QnP50LIyna/o8gdM8mvJlRndsXD0oCezPk0rCZAFn3/NLyh9FPL6sZK73N0?=
 =?us-ascii?Q?oEjzNPgqXbbgsy3Q4uKFBc+BEe4IiQ1fSvIQ05dNXtbUJmi3dcodWHgPAIgk?=
 =?us-ascii?Q?ar7eZmNlzkzLFV6T9ywUfI086Q1L0zAN8u9HNMkemPDrDA9tO/QNQxt0O3eE?=
 =?us-ascii?Q?jPkLnfjb7CUqk7rIy61/B22BnzIvO1qpXwrkxu/ez6LBeihIAzAjFFypYvzq?=
 =?us-ascii?Q?oMql2fHrQVrG9W3vMnWUaLoGD+oE6kW8Kug/c5KelNzFEfbE5G3hHGUyDmOn?=
 =?us-ascii?Q?ChWtlYVxftAGUjasUSJyajl4SoaP6seaVN2Y5eM3BxqaAOl5aI9J6j/r43nY?=
 =?us-ascii?Q?qTCafK2rReYLuvesvWy60ytLNemxfFKnUjFPFRsgsHuGYD0ne0litWZiQxy1?=
 =?us-ascii?Q?BqadtpDhvVvnPQVw9moaB9dzYNmn1/tOdhfCDXmbMfQ/20drqrAiiZIHHpYB?=
 =?us-ascii?Q?aeYsSi+LlLWjjDVq/+Kwr8SSkQ+XedgnwM4XhxCjTTbXmYJsRZL0iofLoQBN?=
 =?us-ascii?Q?9v24XPW/B4PQkjh7oshiCu32g/ILolyDGODFvIjbUg1S9SYEwiz4eA7OdxAi?=
 =?us-ascii?Q?uvJZbi+qABA/EvoC5x3Px4Ggn8BqyziVnBYUm+XURK3E5DBXIYj47Cdedlg1?=
 =?us-ascii?Q?54jP9DwIxcmjpm2riR1k9ueHyf78NyuXtfHssKStN9lOIOqG33yIWQWtKevS?=
 =?us-ascii?Q?BifcTQOX3KTZtXmHfZiIQLiYASMLmd6S84PehI2bzbndYWHxF60f4K+J1EFc?=
 =?us-ascii?Q?6bDkksiuoL1GdxJmC+0uHcQ3udCUfRn3lTAXEAoyXoflnCiLKItbB16uwSNf?=
 =?us-ascii?Q?yUP5X17WB1KQvqvcaPbNdejVQ/nTXKgslgNsqsLxxaEi1UV9tV94LB5g8vSL?=
 =?us-ascii?Q?FKkDw1ng54V92WdnGe4W2lAadZaLjtcYT0LMhfXRLN1dkcxihvPE5ECmtuiL?=
 =?us-ascii?Q?PKQHNMG5OiGfnHcUM0n88r2WpuFwFgirq5ymEwnRQ9xLM1QRYG3xmScBY5h6?=
 =?us-ascii?Q?7+vm0qv5qcM0h9UBokrrVEFduuAwj3VmV+jm/XRVpbT7zx/kXs6iJ5GT/IbJ?=
 =?us-ascii?Q?FUHlokqBZby2K+WKIlyFI3U6GrmPNMB/k+ciFSKUW351Es81M4XS6Zo/K8rH?=
 =?us-ascii?Q?PfKdmrofWpymxxOuXpPsAeifeYL6ldWNccPexrJ0WsqRcTLwwfdxyfXM0dPW?=
 =?us-ascii?Q?IyMgEuzqfB0dindtGJ0ivIHTdto6+814k4WgKNOVakIN7AcBjDyubN5jaZ6X?=
 =?us-ascii?Q?Ed0yB+qvh/OFFeVoGrjciaDi0Y7vu403WdHV/QOrAR1sNBSDo0oJJhnD3F5Q?=
 =?us-ascii?Q?jjiJ4Y9R990GYXm0GRqlkDlFzMlTlIJfFVhvNSOE8X8hhlD+0bL8Srdlpply?=
 =?us-ascii?Q?+1HSBN4etGbQ2DHncbZbVfABQGdiMRJxNA7HuB9H4rQ+9WkRAVBP+uGpbWX4?=
 =?us-ascii?Q?WR1SuQ6m80I9Mkalyv5sJ7umGpjzXO/bwQrJhSKirHeYBwaL98HRylytbR2z?=
 =?us-ascii?Q?fxXNpaqX09oRgms/Q7RWxshPfZSrg7lRnV9wBVFVgGatmq1xtoeSLMxPmZyA?=
 =?us-ascii?Q?mJTNIkCuRHO575/ORPwWMwrfSbjrjpLelLZHZwzogUw8sh9QqNAb8yFqe0/E?=
 =?us-ascii?Q?tXOU1KhIM4QjO8N9Ci4dKoEtYyqGkWk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f704035-1936-4c76-4b76-08df2991dfd2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:21.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ5mIFnLmEuts08DXvQ6MjPGzGxKAglXZgHso0USX0G6QutcJlCq2WjVisdVHmHXv373eBv7je4+m48oz7KIpolXk/YRZETKotO9cSeeA4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PolarFire SoC software selects 64-bit ADMA descriptors for the Cadence
SDHCI controller. The controller supports those descriptors, but the
Cadence property remains disabled by default for other integrations.

Enable the bus64bit property from the PolarFire SoC so the generic
SDHCI descriptor engine can execute 64-bit ADMA transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

Changes in v2:
- New

 hw/riscv/microchip_pfsoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index d0d8c8f84c..3d1b3246db 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -193,6 +193,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
+    object_property_set_bool(OBJECT(&s->sdhci), "bus64bit", true,
+                             &error_abort);
 
     object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
 }
-- 
2.53.0


