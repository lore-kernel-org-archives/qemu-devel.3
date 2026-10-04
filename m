Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F4CCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAB-0005uM-1R; Sun, 04 Oct 2026 05:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA3-0005sq-4E; Sun, 04 Oct 2026 05:05:35 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA1-0005jn-43; Sun, 04 Oct 2026 05:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxCiYpdKz+vuldERovSctVsXsQzvsn7HAYGVtIGNJZGV7Bi2d8JhJ0ISlII8p4BnMUJL3SoIXbY5zRmLGZ/o41q9tlqcdBt01nfAOtgQeQoliOkuReOOoGEGD46tx5HxQB3wEQzxbrJ6Z3W33R2doc1uEUj5X4VSXMxwxgHR5uTBP+6g8rp07Lj041aS6hI0c7qcCrMH9yVDihNhxnnXbDt2YQ2cAqxgsR4YQVdOa0wyOjOyQP+FsX2bX03ZTFsLf76M6CGMqipSD1vLRxxkZPcJJGpcmaphLYc/zX1cK1ct8NVc4Mzk3q9QnzFNVlEMH6RP3xROqARVRCoRx5oA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B8D9cORFBQiuy5Lre3ayNyJkHDrftAC/DL7K3G9uhw=;
 b=L0WqRWEzECc+1sdg7lbl6mN+avL+oJG1GjQrNLhVbOtmzDj86Z3FmQQcBxlOvHTBtgmYjmkBOy8lt5NToNj2z1EUWSmlqeV0Xj5wFVjzhZMfUq9CVx9c/KY+IXORONZJsJo/Y8Hjc5hioeYdemswHCvBIHxFPFGgzRduV9gNjXd/VJzQ4aS0r4UtSN1HbL7NNeObwYIHM67JqeBPCVSLXkvzh8gNl3kGQJc+UsYnB25AdeHMoCLG+4e8maqkiwspSfvl0KK+jqekzg1XpJyp6aY/JEZVRQ8UnU6PfjE8WvEQW9baXnnKS7fobx5VCHgai7777AkUuvuLGUM22NQfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B8D9cORFBQiuy5Lre3ayNyJkHDrftAC/DL7K3G9uhw=;
 b=rB8nTDU7lQbHwxCM4kVDVSPU792AXbipmZxSMETco23Scrbg+41H3ZL9Dj0NL7x4bgR2vevKXvb7Kd7/hkFChGwSY7vSV+XR+Euoqk8r+yr8u7cmvk37i5ItB50bIakfuGc4WhJoBMkF+S8fPiNB0kgjuFeoMZa2x2mmcKxyYTcRLae28DsekpMBDH91xYM01Er/IlgTwoflmv1KTsjQnL/us4OvedzelkjkmOMc97v8W5rIjT/lf34/pPt0uvSY126JnPR9PZlV03IDYZeQzQmeMm92gvhVoIpqE0CcfttS0grLTtP5Csgv8PLrWelCapXdsvrAg9m7WXsjj/ZShQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:19 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:19 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v3 01/10] hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
Date: Sun,  4 Oct 2026 17:04:46 +0800
Message-ID: <20261004090500.3082641-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: cd13c0f0-53e5-4367-f21b-08df21f69d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AOef/wb/yzg8BHaD3scKTof+VrUWNGMKQ3XzaJBcODPLvAo4XA2Wa4MhQQQyMx9xB+U7sPTk/yl2ztCkY9KVJxgLwg/o1Easdv5tiorcJLbRH4vZXTWwohnUKqclwFeLme969gq4uhtrttbMlDX5vDei8mD7tvlR6FB4w5h4fIDRj3TY1gwE99vr1RfHuc9KV1vj9UIdShgecEEzK+7HTGFv4kj++4aFBVCWZSP5Me5zF8AKDbt/YODAzupcqIcGNBoGJZPvgs9AlxHSvTuecFADkgGruha5M86cDu/v6TfSX33ZXdUX+fJTn0KtkGml2HRuLaVz6h01roBkGLKfxTdPSyAg00JReisku5SL5TnjErN4nIs6H9NhMivizXWpl93LoX+0bg3ylgIzXC42L59d/TC1Q0opJPlu9f6QSli+p+U+psDc+SP62TxJbzuRRBvxl1RLUyWo3RAt+4oV+qOPU2ijLVDtGhj8fazNrxnsNmptwZlzcDaSf3JL0L/5aJc+yp8eqklYv0cQ6Q5Cai9IibO1xkZzoZut3hkum7vCt6phahyrwaboqP0oQ9eYriNR7x9WAq7BrCOLOYVbA2sf3SGxEabUClvfIBA9UfABwBJrWQNKoRumyWNQWxyJtJyHhShLhof9LM9i8f1HPgtxWRjzZF+LhXSw4zRlNFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+h4OvdyZcp5tATk494f/sbhOMe70NUhq+DPBnxSFAG+VXS8o6+fpOIP/yRiV?=
 =?us-ascii?Q?W7T3SAOpJqYPgy2JSHdEaIiDw30Fb8UB0EpR2pxbH/3bNndZDK/ANJ14tqKb?=
 =?us-ascii?Q?FsUFpMmVkNbKU/1UIwwKfmTtq0Tw0NideAG2B1yDN0uL6X+qoZDGTvnn63Kd?=
 =?us-ascii?Q?9/X0wsZWDFNuzcNsDgPbtQz9Ro/jygsIGT6S5BjITkRPITBnCZQ8kiozFRcj?=
 =?us-ascii?Q?KcJfPL36+dGq/fjYJvilptLJSdkUf96ZuGMSRDlzkQeDxuJFnRjM+AY+ut5H?=
 =?us-ascii?Q?/VGM4LoCr7G80/yCXOkvSwflRJJzqjkOWJZXNC9XkzbtkTxz9DzL01pU5qKx?=
 =?us-ascii?Q?OTKEl2mhH87NMjJyM4PE+MGDFLPN1o4CQBmAecEjm6iTi10d+rJOOmER7HDL?=
 =?us-ascii?Q?5LDuAn4aypfPG5eQQUr2PODSniCLiVCXvHlQy4W6UW8s0mNQCSa0refNWoMp?=
 =?us-ascii?Q?sgxSd/IKN+HlLRwHUX/5Cih7maZIm6OQL4MkZmAYuzNP+h60lgiEIjREMmzQ?=
 =?us-ascii?Q?p+zYZWZ8MlPbfzZNBqPnIuQGVFl8FXlqwDvuLo6//8H8PbalnUP4pPdhqFZr?=
 =?us-ascii?Q?PY44VtbS6VilIUhDNm+FE4u6BU0ghmtrcPar3v+mwZMRC2oAB7PCgpQjiYW6?=
 =?us-ascii?Q?3WDpVrNUjXFm484Dzq3DR/bDg2rPb9ogM7K+cdntlRDAJYD4qxgZwyOgk+RB?=
 =?us-ascii?Q?wkgAUJma+scmxNJg89GQZR/kIO7K8XCzO9LL5kikm5Tqca1bdJ/xr2hBBRXt?=
 =?us-ascii?Q?PNBB5BDRa/kl+02TE0AGNdca4Msm3kvXtEASjto1DcyjbTPMiwiy5VlbkWWf?=
 =?us-ascii?Q?HfvXLIb0xiSdWbEB6vTHRDJG+oKQcbFyKE9AgGHgzem7Pbwkm6uBZ/8m/jgW?=
 =?us-ascii?Q?LwpaPFubrKbh2SVzfQFhdfF02AWydSE6CgckyN6sv41VivyCbFj2jkkISBkz?=
 =?us-ascii?Q?8nMbrpZwseOhf6f1BOQL6jNFOW8BFfjDfuxh54UsVFh36JK9J6FBVR2JnAAC?=
 =?us-ascii?Q?YjH29NIuVAWLkTzO3/PIafVBfJfiT2lhljNFBxkdENeqOLohckAx/qjYZ8mS?=
 =?us-ascii?Q?Z2nbBC5zMlD+tD7MWj+UaA5CDYEUXnqKte4mtv7mThGutLegp2pznqSZnvFp?=
 =?us-ascii?Q?5aabCcOvxnbL9w15o/wEuIUPUSoMaj0zOQvMP9M0JL3aVCftx81f2j5IcYkU?=
 =?us-ascii?Q?CccIsH909HJTEJ7hMt2sww1MABJoO6pSNpPExWFi6qzm2KcIbohIuB+dowWD?=
 =?us-ascii?Q?QTd54eJToO9Ga4o1gyniTGb4k7TDT/vOX0JL9ZqaS0AsFunqn1wFqdcQpwxp?=
 =?us-ascii?Q?rrdFGLp96bgtz5EmI3jmKkQ0XHibYRvpWyFi2upbf75sg004QpRysp0Gq0U0?=
 =?us-ascii?Q?y/K49tCbb6dBJ9QmEtCyhHGwjQ0z8AV3ViFNOGwc2zEqR1uc7fmw4+Gqi6NN?=
 =?us-ascii?Q?OwACg/DVbE1lQK7yji9Jx4e8Dkrb07EnNKFsorpXqq7koeV4o+Gh0LuT0FkN?=
 =?us-ascii?Q?HLCkSJx6YMtNcbZ/YjpZEF95Dt+LCHECKdm+BBIlA0is/4WP7rw5No2yQP/i?=
 =?us-ascii?Q?vg2smc7X2f5wBp30n3itswZWYoUkh3EfL0r4yMv/laHtUNzM1GMD2W3iUD/M?=
 =?us-ascii?Q?+f29kBpUl7Nir15Z/s8aZZOFjidC0e/6IKG3Hn1fAV54XrGB9DtA8qhKSPvf?=
 =?us-ascii?Q?81daCR6knrbROsluBGYWQXBsCjCHniH6UBnJL2n7tux8b81mjBV4R7OQWX0l?=
 =?us-ascii?Q?fcyj43djqr7+jfcN9s0UJLSz/+lZAe4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd13c0f0-53e5-4367-f21b-08df21f69d48
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:19.5582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXEVD503gGdXUPJn/o87AB2Za4ezNBqKbN7K2CtFjHrdMN7Go/KyrWyBU6R0v7cMP05SjXnDaZkxAmYZY+Pg87hzCSKPqqMP8eVSwlN9LqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
so that access causes a data abort before the console is ready.

The GIC-400 register map reserves offsets 0x0000 through 0x0fff and
specifies read-as-zero, write-ignored accesses to reserved locations.
Model that page in the private peripheral device.

Reference: GIC-400 TRM (ARM DDI 0471B), sections 3.1 and 3.2
https://documentation-service.arm.com/static/5e8f15e27100066a414f7424

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- New

 include/hw/cpu/a15mpcore.h |  6 +++++
 hw/cpu/a15mpcore.c         | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/hw/cpu/a15mpcore.h b/include/hw/cpu/a15mpcore.h
index 138f491c22..581bd147fb 100644
--- a/include/hw/cpu/a15mpcore.h
+++ b/include/hw/cpu/a15mpcore.h
@@ -29,6 +29,11 @@
 #define TYPE_A15MPCORE_PRIV "a15mpcore_priv"
 OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
 
+typedef struct A15MPReservedState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+} A15MPReservedState;
+
 struct A15MPPrivState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -38,6 +43,7 @@ struct A15MPPrivState {
     uint32_t num_irq;
     MemoryRegion container;
 
+    A15MPReservedState reserved;
     GICState gic;
 };
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 28cda55ccf..0c379e58af 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -28,6 +28,44 @@
 #include "system/kvm.h"
 #include "target/arm/gtimer.h"
 
+#define TYPE_A15MPCORE_RESERVED "a15mpcore-reserved"
+DECLARE_INSTANCE_CHECKER(A15MPReservedState, A15MPCORE_RESERVED,
+                         TYPE_A15MPCORE_RESERVED)
+
+static uint64_t a15mp_reserved_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static void a15mp_reserved_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+}
+
+static const MemoryRegionOps a15mp_reserved_ops = {
+    .read = a15mp_reserved_read,
+    .write = a15mp_reserved_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void a15mp_reserved_initfn(Object *obj)
+{
+    A15MPReservedState *s = A15MPCORE_RESERVED(obj);
+
+    memory_region_init_io(&s->iomem, obj, &a15mp_reserved_ops, s,
+                          "a15mp-reserved", 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void a15mp_reserved_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Reserved private peripheral page";
+    /* This device is an internal child of a15mpcore_priv */
+    dc->user_creatable = false;
+}
+
 static void a15mp_priv_set_irq(void *opaque, int irq, int level)
 {
     A15MPPrivState *s = (A15MPPrivState *)opaque;
@@ -43,6 +81,8 @@ static void a15mp_priv_initfn(Object *obj)
     memory_region_init(&s->container, obj, "a15mp-priv-container", 0x8000);
     sysbus_init_mmio(sbd, &s->container);
 
+    object_initialize_child(obj, "reserved", &s->reserved,
+                            TYPE_A15MPCORE_RESERVED);
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
 }
@@ -131,6 +171,12 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
      *  0x5600-0x57ff -- GIC virtual interface control for CPU 3
      *  0x6000-0x7fff -- GIC virtual CPU interface
      */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->reserved), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->container, 0,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(&s->reserved), 0));
     memory_region_add_subregion(&s->container, 0x1000,
                                 sysbus_mmio_get_region(busdev, 0));
     memory_region_add_subregion(&s->container, 0x2000,
@@ -171,6 +217,13 @@ static void a15mp_priv_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo a15mp_types[] = {
+    {
+        .name           = TYPE_A15MPCORE_RESERVED,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(A15MPReservedState),
+        .instance_init  = a15mp_reserved_initfn,
+        .class_init     = a15mp_reserved_class_init,
+    },
     {
         .name           = TYPE_A15MPCORE_PRIV,
         .parent         = TYPE_SYS_BUS_DEVICE,
-- 
2.53.0


