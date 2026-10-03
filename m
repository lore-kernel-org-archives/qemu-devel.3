Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F083CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3AO-00085M-H0; Sat, 03 Oct 2026 13:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39B-0007G1-1v; Sat, 03 Oct 2026 13:03:50 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD398-0007Ds-7p; Sat, 03 Oct 2026 13:03:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WciDxKpkj5UdzKzCJdjMSk3T4GXNmKTzWdwejG2KKN7VV8oY3V005dVheJ01G9S7OsSzHXuCXL3r2W+mssYp6T0G5VLM2NVlziPoKZ1p2RXuNOcSGVtscBgHct+XNaxrM8oPY3K7+NvWr7U6TDEHysg07Mc930lnkNYTU/bkhZ/6sb9dyZxKMXQGoPmQEpidUKxzX1+3pu4LeNmb00b7t/uT7PX5iO1FvZASz4kOqAvDASoCkCwYygHmwK3TSqpgELMtLLfY3iMFNjl2CIV2T2gVWIUUBtwZMlITktsfVzl7Qvjmq3d7YZ8YdLPQjP+xpbOOFvVaLvKGX0Y2JLSVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aFmAiSdaEMxdkslZVlzZp0g78HfwomqLIhQuM4FwGc=;
 b=iKuCQQAgo1ZiiwNm3kmy8AaJeCDZgjJZNMcO+Um4vMQW7Cv01BMoMjOArrq/fYjcirIay/XOXHsX5Q0T7Gi8cdsc9P+RWuwh/wQmT5Ump84a8sCTP81JZk72kKzr9pfKDwRjqK3x/2IczPDfdJ1BaLX/qU5nP7pNEbXwf8n/jnILQbrFt0xz3f2Lbp2lC7kikd1uuLHVAig3i3PbdRDSwUdy7IZaq/pf89LCLYqw45VGrTXY/vjcX6VUVoxP4ruLi2xka6H49xlI+NJ8FFMOVUTyht+ymjXTf5fIxDBQp+kfhfg6gnYJrxwDCJrRxcigdSmtj0OZieAmMjfIfGkWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aFmAiSdaEMxdkslZVlzZp0g78HfwomqLIhQuM4FwGc=;
 b=nLdM8wIY+Bn6wZiC0zIyMISCslTxq6k5NGy2d2eXx/JuM15/0nxvTP6vQDP0EAvJfQtkf0ExvalZTC8cz7clxCTDEhddPL7F28LE4IzUmsdeOwvujfofD6Ept4bcfhwGwcIIayaK6Pi7F2PM7dkcwJr4IvUfUQBSHCa1866F+lt8U/yd1FtOF6j3TxVoOAu65Hsxdyz/I0XroU1XWQsqolx+/LbVUjhlxIyQ1qSyJhWgcW/RxL0AzZCpdRQZb51cL3eURjJSLB98HQl8/Xug+HixwwBxllVlHaygW/mnMyt2byUWxZaomvUI0hraOxg5ypIwY1A1kGH45qhzqvT1ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:30 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 13/27] hw/riscv: pfsoc: Enable 64-bit SDHCI system bus
 support
Date: Sun,  4 Oct 2026 01:02:03 +0800
Message-ID: <20261003170232.2450916-14-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 33478e44-cd5f-48e2-04b5-08df21703fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: KnzaMhZGh0yPnIf7Ifm2MoNYwNgJzArJan22U8ifJ4x7VRN7YRp4monAWfpT83/rY+MvY4pStjJhZCYKURYm9FAZUSM+C0UmlZ1Jet45vpEbihPcug026Hdcoi9WkiTXKcAuSVWqpxnLdTKjc2LfqCgYv5eYgw+fsZqNMezayQC734vRiHF8z6I/iiNvu+ShJJNOrl+VbKc38Mp//b/mIxm1rXm7YdxRXetpHgGQQ/7J/Gzt7HhJ8H67M//ZNAwZceiQKkC1aVK9/U2f0EbWmcvuay1oBr8QSqPc2iZ8Suy6n0sYAOUNtyGgBVUpM5bTzxKV5DSxlvILsFkxuEYLTfeLPalMuHmBpg3hc3E7OmM1XEQ/lSIdK3wRF2fuLx4qG74L9mS5AEEQOKjEvgb2DRTg/ZO3bEBuxjqOjWqOOiShGRuJ//fUl4UY/si9FTPAkV5dSWy0WauALmeaQVvpJx+wb8VqeZr5NKo9QdLbgwrePOfeZ+s1wp7SD+heCey9UmprVjFJ8ybB40mhQlK1dt0lZtFFsyAEBZ2CtMfz5m/4pcKQHnb2apCnLzOUH++t7kylYTPs9J1w82QT+PEnquTb9EAjjXAgCnc0rsTYZ5KZOFesyW9arWfh8SH9e6CVVsKfaNgid5FeF0FKk4lYu3CE6v/kOUkyL+TXdGkoJCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0xUK94mngRMYf0Tcxdrn79JIIf4ux0s/toUMKI81+2MNeiEqRekRMOhYN1n?=
 =?us-ascii?Q?Yu+VBq6og4Zn7i3xTMt/yoMT3yg9ICIBj9d3WdGu7UdiakCDXMF0HcxhFNuV?=
 =?us-ascii?Q?Sx140r+ulwkTzJ8i6+gwVgZb5cmvjy7VpF2f8QGsfkMtRJUcQM64bK4fy5m/?=
 =?us-ascii?Q?ILZz75Qwh2DdTUwhvGaHac/edK3h6GcqtXOOBK3pLdqhi5jjyWBUllPKoAnp?=
 =?us-ascii?Q?FnPGcncYbs3l7BBErjP6CLtu0l+tIQ6eynmGoIpvAWMCbtObmciJPr+HXeGM?=
 =?us-ascii?Q?IPbNWowzc8biWHmA3l7Tbl8BiEKPTLufMdqkIdSAaQuoKvHe4DK63MrTt69+?=
 =?us-ascii?Q?+wvXh9vxuD8Lemri6ztk/dvKciCnw+TspBNHJrCS2ZjYhjJ8xlAhZ+uZtUlw?=
 =?us-ascii?Q?j9h/2zYbF+Z/6Ri72DJml/a6PH7L4UMeuA80mjKGA7mdGDxSqOmZloYUPSRD?=
 =?us-ascii?Q?snksEdX4/zx+FjjIq5x2noSkCojIye0QJ8lEYGVMMBXQq88w3JtSHKluRjqJ?=
 =?us-ascii?Q?sWHLJ+h5tvGKlg6m5ySQX0F39Zl49mic6PGl05d8KKsbfh7sU1rhGMllio3O?=
 =?us-ascii?Q?CmN/tVkKfNda5cZ1E+E1g6AlRZf0tT5b5/wFhwoh/1uuX/H19gu4WHL+wBvW?=
 =?us-ascii?Q?JHxk3vDePpqA2N6PjNoTkfZfThJh6ZglJkNVCchKWfrc+oJPOVvZI7FP0Wab?=
 =?us-ascii?Q?0+Ovi9OfcDtvqxmNcDsQoh9zKZLeWhm9nbBkYpOKfDEZEaJ8qSiSIrHAK92K?=
 =?us-ascii?Q?mFAz2LA98ZCKRZVgbKLPqwjOhgIgbBbrVwlXSDAfZffLPIpw98tdD44MV0Z+?=
 =?us-ascii?Q?78ew7BNPNONwHkibzPRbPPHSaDKaWQlmQ2HplISFjAbL1MmGhN95AIInPzs3?=
 =?us-ascii?Q?+W+bOc4gNKwZU5c7axoBmyBsgVD/grINLZyIWwX7BJg30jh6j3uGDMoFkARM?=
 =?us-ascii?Q?Hf+Yu3hSDSftmXYaTOJeLdQp0IVIQA9FGmH117bv9rvhtkEXV6FgmASudgW3?=
 =?us-ascii?Q?em2g4o2Jr5wu8t83j8nuHYAgbAnmbFKFrtdTUBgPVYaKFLpQ77lGlCiHy/Jt?=
 =?us-ascii?Q?czdv6xStNZtrprkATcz651wiyxrtv/aLtzG64bApqhql6Sxu8aGMqe636a5V?=
 =?us-ascii?Q?UBnT+Srhyu0D8ZRz4mevn2HtyfmupaBEmQMb32a3p3SAR+tWPR2uzxEqKcuW?=
 =?us-ascii?Q?oR+cfMSPuOCA3MUAOVi9UQUYH/1sFt2AP6PonLETYrrtfvsvlGLUavZXWeNk?=
 =?us-ascii?Q?Rj5NF1BlhURh+sppGzAwkbeXRTFJ6uh/623UMVm/9LmzU3q2NkUDx6MQoyyS?=
 =?us-ascii?Q?9q88FVu7A1aqDfzMLBYrz3hHesV7QLpMWJ/vEWFmws5FJkC9i5a8xoCog/L4?=
 =?us-ascii?Q?/XQs5ld7MohUhSyfHVGXjX693BYLTD8tOXWACjcX8lr2wrfyzLLIiu0xfUb4?=
 =?us-ascii?Q?lcgrpp8pRtkSZrU3DJRtp3DUgLmaK90LSeqMPYd1pNC8KeFoRlEHa7NkETqL?=
 =?us-ascii?Q?69ljlvPyH5m50hwqdkVk9RMeheOTKiJrNUrYmt0VLw2bUy6qvD2QWOI0RL+x?=
 =?us-ascii?Q?hLIpaUkO+wP+20YTyc6mtQ4dKt4l7P+x8Kjk/GAqlSWrA0auM8i4BsD8sNQQ?=
 =?us-ascii?Q?MmiCyi42jl/0BU9YjarOn37d/6ksGDVEntgjdYbbNbsZqV2JPzLKZvM4oykA?=
 =?us-ascii?Q?B1qQXgmG017qGTO5vLFSmIWcqEshkC8mFNOLXh550LIiLDwpKt665Fggx3Zz?=
 =?us-ascii?Q?2CEpOs2lIzrn1Iqu06gxJxBgaXxtgCo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33478e44-cd5f-48e2-04b5-08df21703fb0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:30.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8BMY+CHuce0qjUPop+crs8s3TlCpSdsRhGT6wOoOYeaCzJ63MUzjIgVzP2C5xFyoLNps2EPpGM19GCug6VFzLERoSVbjjC0R8RZz2iUbhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
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


