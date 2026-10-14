Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38257CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr3C-0006kC-Ez; Wed, 14 Oct 2026 00:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2w-0006cG-3p; Wed, 14 Oct 2026 00:57:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2n-0008Iu-G2; Wed, 14 Oct 2026 00:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk4g35v2oglhoFNfp/ljtBHsrzCyuf6hbXdPtBgJUJAdwTIbNWPkbsWzMBqINVZAYoG++LuCN+YEUNCmUjGOy6RpFhxB5v3llXjagXlPB3igTY9TQkWvfhTXLiGQzHNCflxPC984Vkm0/qWrRcvAdkTrNUxqun6bpnnyH6X9ujRsCd+3S2XXJMLrKE+CzWsmGlTLSVjp2AXR4NDDEVajL7pwkFyFE+QBrhyRPNh1FLwHqRyTUdAKqG95Sa3AN1enQI5k6OvR9mflfWpdTXZEzPbX0wWLHw/Z7bE+UIZp29cN7+gXkyJM0wY7ZqbOKHDhE6VHxRToMfbBsuWp8+vQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkFwLA0wvCBk/76sHqrATtEO9M3PR+Ng5IcdDiOOSLM=;
 b=nbRAPQU78Va5luEXLYqXYd+JdMbY7fYRcVQDgZ3bRDOsB7SEXzd/4cX2FpkYEjCPwy96d/OB9lBqv8DbWVbp/1LbrPNxJuhFG06fTbMvBKGTKQ3hFsvaRv1gv0voMNVNT4HTuLuu9uxCE5xsh6LXyfue7CLeiLDiZKMAX1NSh8MGLoDseH62fK1Sje6mBREzJQYFtV8wtzhyBlUCnhfqo3fl2mzi1+PgfYdkg24nr77FLLtPuqfNrt5lSSfBaHkIUCWkC3qxiQud6wRPqWp2Oser6U3iFAeGEfp+p8s11apePswvDs39zwpF9TqBcOQwBOrIh25L8hx5KvUI7kesSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkFwLA0wvCBk/76sHqrATtEO9M3PR+Ng5IcdDiOOSLM=;
 b=Ab8cSDSPxW5M45XDGif/2PbE8C4hd9EWDk/4IUOFmgZNmZDjlbk03WyfeYcqrOkCfxjftMkMTHfeEycrLyp9voxzg+7lXHkOymkFufiZAC2fjYizLMNtuZN6y6kn7eMoBf8ZN9Il9EUng2RZNVYysheMF7nMVO6dPn5QP/WQrcXGaoAZZu3mdrDyGLN8u3AvTQ+RsrTFHmiD8Ry7AKGhzrhoj+UpL3ylr7d7Mm0lUmBX544VmLQSqEFvuS3tUPx+94BgDMWVLLDQiyrOi8K5Hw2iNyIABhnUSq+nX5hHCdnGKne5dd8A6hHKvfQhgbWOSJCpcsHQGJWtXFI9g53v5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:38 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:38 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
Date: Wed, 14 Oct 2026 12:55:56 +0800
Message-ID: <20261014045605.399684-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5e216f-ccfc-45e7-63e6-08df29af87d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|22082099003|18002099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: JLfJ996X4iI0FLcMYdhJmUzvYHAx9k0hTOwVVWjNKZzDX7KjXIL1bwcT/+mnEhjQJL39C3OdFacRqLAUqXarraoUYXzRA/YL/IfrxjAvuT7HZsut7S/+Dh91Vo51oJrPigW25FWOvEv0VvcJVifPx2emWjpz/AT99IntzvZMMnpnxYGcL59OCgMviUdfYggdxfbJXEdjfl4NITcy306husA741Sv+Z6G4vxNw4Ljgrcoa8yQj9onxofhz/UxZFrdHqgNsQcw7j31Hf5shRKWaeyTJXwGivHu7c5tGgV2jngPr/geGj1T/MT07SklkGaMR0vMt6ER/sICqNKAbj16uh8+99IkyNWfPlqUL+Mizf8mw7LHuaePOwA3Orvv5YVfst6Y4fs0gbm3+vg01qx4yV74Qtza4fhwASmFw8Ioi+kph8lZ/lz7U2+zVKCJDUYtJLxgx5+3mp1onlkn9QkFU5MV94Lx4g/w+zaUyU/JI9H1wZ2kyXNc18utPecbGSic5wtrUY2u8hhH42MFL5adexBBj/XJ7OfRmNr2MBWVseggmEgQAf1quq4/Uk8q1tX96TIpjXj0j1lIwtAY57yNtcSfZJ4HFKKwsjW50DINGsfoBFQs9rg1WeXi/ccoI5wNGSL6wv9o3EP5tVWifMMrYkstE/bM6Src7eAtM5PGWOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUT8DZm9HU/ei2R6FNx7CCTUHTn+5cH2F8o6net0PN158+idu8K1JTidHcv3?=
 =?us-ascii?Q?UVgNehNmNqaK7MR7j2IYklfZ143F8eyO/02U8sbSD2eDnAsVQ48gVSXqh8/m?=
 =?us-ascii?Q?7CjmZGwFAS/1HtH79SFIY5LXsXAV9gwKThCSU+oHQuYGTc/R6NVw9ofDtzF1?=
 =?us-ascii?Q?ZZ6yO4ZhvbrK4rrVbFabbhgPkW+GM6DsBALnkkaINlP6AV99Q6h+kNQYRYGO?=
 =?us-ascii?Q?eaW75wXIacPhB7V3SzEue8HUePWKYcpjuPQ1vOxYjscWSe4/z3S65U4iEExl?=
 =?us-ascii?Q?DrpdlksW/wLsyo8ocOvSoPytBOiALuAWLjOt+iXpCpFUB3VQVtykQHkVlJpE?=
 =?us-ascii?Q?iybVL3PxMGlgyDx5aRyOXKTdn8Zx43k9XJIzM7xihibMj3hsp/7gYQ+iXUIx?=
 =?us-ascii?Q?94l2XnDpIjpSG/cK5wXXoV5ttgWeO66mlTnBPiA7MQgdbI0UzyzHOebBikIi?=
 =?us-ascii?Q?nx1jbmSG1hk+2WkwBVovyWN0tdPXYjBPeOc09dNkV7fDbvLAtofy2OBbO7Ly?=
 =?us-ascii?Q?uDobeIhpB0ARYGDuAoEqW+L0WBfBlMpoWj2Hss2Rq9+Yo722jQWB3VQtiuDk?=
 =?us-ascii?Q?55w3CmQTjs5Cb7dDCqeGDmY4Lz7K8qmgkqmYGLZTUimBLyOwhPI6+fcbV/b8?=
 =?us-ascii?Q?+mF/W4gzdn1raPODE0b8Zp8uBOE/RvZSdjPI3286vW9RIBjYcTtvobw2Of7x?=
 =?us-ascii?Q?UGhhQ9uDBTrRt3q/K8t+EYLoEY2M2NSukyZbO1iG/WkFEanBKz4VGJ+yOw2o?=
 =?us-ascii?Q?pMlMueONV7OW0LUh6PzW1GOrQGKfIgoAunzusRHdbv6cnm636/aClXeoZwH8?=
 =?us-ascii?Q?ERWIcJGH5ZqpvaXfV/4TUYUM5oBrHjCAiZIFKYwF44CLXn3JT+nr0aDJCzlK?=
 =?us-ascii?Q?1kE2ZkavqdxTKyhDGEujX0tVXZ8iV8gSHT5UygTiPzjX2Zl1OlKsg013Mm/m?=
 =?us-ascii?Q?DBcaDypQu+h3TeJbAd2wRsgjT6J+mRAYY4wnEsvhpvy5Ig+xLCxhUrp2KxTR?=
 =?us-ascii?Q?lS0BEAUxGualeRjMMtglJm34E2Ch7xKq8WMSSJ958slgjdE8oJs66lW1p2Fx?=
 =?us-ascii?Q?Gq0AbLDBV3sNL/HlcbJCPawymACE5g3EjWKA3ziLSR9EDISyR/Fs2RC8a0aV?=
 =?us-ascii?Q?ynabmiCnXwA6iVSHJHAUwn/ZDoaLSJjRK+tp/C+p6myzKH1MSjtrigZUpO1p?=
 =?us-ascii?Q?FzA5+6QIMCmo/V0bfeIaExPFo4wY7KX+xxsvgiLZLkb8BWmSSHcI5X4TOUnB?=
 =?us-ascii?Q?28b6vd99m3f6Kqr59KTEYdUH2HZ+vwt+q5zwQL6v/7rC9/7mtrc5RJqLl5Nc?=
 =?us-ascii?Q?c9tqoC3U6tHrAS3d52Uvbpg9YdWMTECsv+QkVxTYYxh+7MSXaYLdtuKE5rY3?=
 =?us-ascii?Q?iKgc7E9wDp+wqivRrl+BSv+B4/pOsySxFvHsFVLnMo5ArdC/7HvgQJ80FNeE?=
 =?us-ascii?Q?K5Tw32HI9GlXp5X/nb6Kt+YLh0+XLJIo3PMpt3vLYDL2dtSQWU3Rd3sqzPH/?=
 =?us-ascii?Q?sgAq3p2ogKUl4dUdzkKYjdKaSY4SfA0cgbFCK4eHVFKCPPmapR73NLDo46QS?=
 =?us-ascii?Q?A36fLuA5aOXdssZVJqPbepa8IR1qFd0TDykh5l1OyIjbEfoKUsbl1NVbsXcQ?=
 =?us-ascii?Q?70NklNgQHelDaISSmYYmnS5HI/6QUCvl/2C2u3sxMtfTt+dHPAAtfxiEe31m?=
 =?us-ascii?Q?M5I0lZvs/gwLHJkARuoienWFAeLpEjPBJnx+kbrt8v8g0Wu+OBFeaCmI5IBJ?=
 =?us-ascii?Q?g7eM3zZbp7Huf/tX8OovCX+2xHkYsns=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e216f-ccfc-45e7-63e6-08df29af87d7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:38.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/aCrtpP5jzeBE2WyOamRSLTJg/D95/uO/aeifPc0shTzOrIk3TKwCr+3P4IP2qsgBPYI3rVzwo8UXqbp1E+pa0jCqLABaw9mRhGeUL43jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
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

U-Boot enables i.MX uSDHC clocks through VEND_SPEC, so checking only
the standard SDHCI clock-control bits drops commands and prevents
firmware from loading its kernel from the SD card.

Present vendor gates to the common clock check during uSDHC command
writes, then restore the guest clock register. Retain the standard
clock path used by Linux without adding vendor quirks to generic code.
Report SDSTB and handle partial vendor accesses in uSDHC MMIO handlers.

Reference: IMX6ULRM (Rev.2), sections 56.8.10, 56.8.12 and 56.8.26
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

Changes in v3:
- Translate vendor gates in uSDHC MMIO instead of a generic quirk
- Preserve the standard clock path used by direct Linux boot
- Handle partial vendor accesses and report SDSTB in uSDHC reads
- Migrate the vendor register in an optional subsection

 hw/sd/sdhci.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 0c5b0ed984..1831e5e8ff 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1604,6 +1604,24 @@ static const VMStateDescription sdhci_hostctl2_vmstate = {
     },
 };
 
+static bool sdhci_vendor_spec_vmstate_needed(void *opaque)
+{
+    SDHCIState *s = opaque;
+
+    return s->vendor_spec;
+}
+
+static const VMStateDescription sdhci_vendor_spec_vmstate = {
+    .name = "sdhci/vendor-spec",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdhci_vendor_spec_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(vendor_spec, SDHCIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
 {
     SDHCIState *s = opaque;
@@ -1623,6 +1641,7 @@ static int sdhci_pre_load(void *opaque)
     SDHCIState *s = opaque;
 
     s->hostctl2 = 0;
+    s->vendor_spec = 0;
     s->sdma_boundary_paused = false;
     return 0;
 }
@@ -1698,6 +1717,7 @@ const VMStateDescription sdhci_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sdhci_hostctl2_vmstate,
+        &sdhci_vendor_spec_vmstate,
         &sdhci_pending_insert_vmstate,
         &sdhci_sdma_boundary_paused_vmstate,
         NULL
@@ -1801,6 +1821,10 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 #define ESDHC_VENDOR_SPEC               0xc0
 #define ESDHC_FRC_SDCLK_ON              (1 << 8)
+#define ESDHC_VENDOR_IPGEN              (1 << 11)
+#define ESDHC_VENDOR_HCKEN              (1 << 12)
+#define ESDHC_VENDOR_PEREN              (1 << 13)
+#define ESDHC_VENDOR_CKEN               (1 << 14)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -2051,12 +2075,67 @@ static void fsl_esdhc_le_init(Object *obj)
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
+static bool usdhc_vendor_clocks_on(SDHCIState *s)
+{
+    uint16_t clocks = ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN |
+                      ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
+
+    return (s->vendor_spec & clocks) == clocks;
+}
+
+static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    SDHCIState *s = SYSBUS_SDHCI(opaque);
+    uint32_t value;
+
+    switch (offset & ~3) {
+    case SDHC_PRNSTS:
+        value = esdhc_read(opaque, SDHC_PRNSTS, 4);
+        if ((s->vendor_spec & (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN)) ==
+            (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN)) {
+            value |= ESDHC_PRNSTS_SDSTB;
+        }
+        break;
+    case ESDHC_VENDOR_SPEC:
+        value = s->vendor_spec;
+        break;
+    default:
+        return esdhc_read(opaque, offset, size);
+    }
+    return extract32(value, (offset & 3) * 8, size * 8);
+}
+
 static void
 usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint32_t value = (uint32_t)val;
 
+    if ((offset & ~3) == ESDHC_VENDOR_SPEC) {
+        value = deposit32(s->vendor_spec, (offset & 3) * 8,
+                          size * 8, value);
+        esdhc_write(opaque, ESDHC_VENDOR_SPEC, value, 4);
+        return;
+    }
+    if ((offset & ~3) == SDHC_CLKCON) {
+        esdhc_write(opaque, offset, val, size);
+        return;
+    }
+    if ((offset & ~3) == SDHC_TRNMOD) {
+        uint16_t clkcon = s->clkcon;
+
+        /* Present vendor clocks to the common command check */
+        if (usdhc_vendor_clocks_on(s)) {
+            s->clkcon |= SDHC_CLOCK_CHK_MASK;
+        }
+        if (offset == SDHC_TRNMOD && size == 4) {
+            val |= s->trnmod;
+        }
+        sdhci_write(opaque, offset, val, size);
+        s->clkcon = clkcon;
+        return;
+    }
+
     switch (offset) {
     case ESDHC_MIX_CTRL:
         /*
@@ -2076,18 +2155,6 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         s->trnmod = value & UINT16_MAX;
         break;
 
-    case SDHC_TRNMOD:
-        /*
-         * Similar to above, but this time a write to "Command
-         * Register" will be translated into a 4-byte write to
-         * "Transfer Mode register" where lower 16-bit of value would
-         * be set to zero. So what we do is fill those bits with
-         * cached value from s->trnmod and let the SDHCI
-         * infrastructure handle the rest
-         */
-        sdhci_write(opaque, offset, val | s->trnmod, size);
-        break;
-
     default:
         esdhc_write(opaque, offset, val, size);
         break;
@@ -2095,7 +2162,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps usdhc_mmio_ops = {
-    .read = esdhc_read,
+    .read = usdhc_read,
     .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
-- 
2.53.0


