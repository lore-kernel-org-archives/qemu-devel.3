Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B76606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=i2NFDgeM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeLH-0001Am-Rp; Wed, 04 Nov 2026 12:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL5-00019z-Cw; Wed, 04 Nov 2026 11:59:55 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL3-0002UE-9c; Wed, 04 Nov 2026 11:59:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxhTv1xOT00IQK136fypM+SEOKbSm2wJ5HUUZHV4OtVEwXzVaw6cUFBpBgx02Q64YAtaLTkCbEArsrCVSBgLvGc1qW4I2dETxeBQDS/ETCdf7cW+22LBo/G55uWcpkIlMCh6ZUzW3tvVcSK4Vzdayt2bNgaRHdXyKHLu/RDgfbV9N8IIMLcadCEJrqvXZa3r3CUrya6veuj0yzpdGoNRfL18+0/Sx/TcydaAuqn4h/YzVo6OrHVKucXAScgwwDffMXg/L3a6Pxt8/LY68XtxS2NUGWKoBwDhkPiDSQECgkliKRdpVKZWF3dnBQtUd0Aw8SfbXENu/DeIf8WBf3VG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaC6kQM3D0kM7WBeCBBn6/Nb+LlkYLHifMBL9BsBAQE=;
 b=s9XRwWVacFadR5wvYpVWDqcP/x7lwhjkQWOKcXSzcL9FdCXRbR0vibhC2WFvfCFqNA4DeMlSRT2qOKiffMQHzzC9NEUvU4Bx/roa2tEBQXWFl22Or5dkonoDNMsC5Nmd5SNJNx+fQSswBcva0O3my1YUwA1T3utkHEEly6raNQCcoUD0gQlVxlZFJEoYP78LdbHstG9DvXqTUNd0ch0kcelL1tQqkqEPd3UGh+DYH+uoVxdjIzDvg2oVrLYp+EVooS2151F/bX3l2TT35gpBg0xkjL2fA3JHiluynRsHtgIzxwO2lpoTbnUXcDrJnX04RSqb7u21uXtEmJDQVx+zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaC6kQM3D0kM7WBeCBBn6/Nb+LlkYLHifMBL9BsBAQE=;
 b=i2NFDgeMkmnH9r7So7thlIoLrn63AZ3W/jmpHoRBfBg7MwYWOOygXBoxdYjJ6v51UkW1E7zpZQfoWyTwfbw5DnIqE1yhkCg3QLyw1AJE/7GsIp8g0Z/kNGQrZ/JSVTJooHmgoA/KSk5+ZIrgxFv8rTDcHl4VOlzCvNKiZKWf4e3d8kjCNcW7oUTIs5OIXhBmQ1WoiqWkcIV34gvCh7eC3LDJa7/gMfDn0pIHkYqxP+Ywv/CBGyVgyWWjoU5ksMQsrFbIFpOcS5hpsyDQgKOY3Auiqxw0kQO/tJ0eW4FBdTEpeAdcehipvV+fG3LS+MOayuA0c9KWnSZ9fT0YKVU8kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by TYPPR02MB9056.apcprd02.prod.outlook.com (2603:1096:405:395::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:59:46 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH v5 01/10] hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
Date: Thu,  5 Nov 2026 00:59:13 +0800
Message-ID: <20261104165927.678833-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|TYPPR02MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: b69cfc63-023c-4ab2-658f-08df3a950733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|56012099006|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: phaeKxuHj5SvWaZbJzf1Cg3ZFSA8yj01auFm7t56pARQuFiZmVIormC0S9dUNqdTqLSWpIAHTU9nVy/8XLSaC5PY1FDD2TBDrrqvFE4AQjCKaDnwYqSTqWSEH4NCtR5anngAJchyNxkikhGkz2CSVlOGHin9TZXAmPPOF8gzpeBnZWdMPHwv1h2c3sf5p+B5QAJMp07o7JNE9EAv8sBY7Tfkir/fAOao/wsYPZRrakxDPpecelpqx73Z56Mx7LgnP6QqesU1uBhqB15kKihJwHPSpuQUHlCojYcE6vhjd6Kt1xw+DCQnnAffNLZv1E0RF+b+bTC+e9JlxEmk9uKUeoXTJtp+2V82rnHTn1ZkOxiaG2mihWLgVXyRqGh8N5RZl4Xb8PB21XEvomKWDpKTbOdr6kU5wYvfFhd+gYS9mRYoGgep1DhViABZc3KZ11M51cWCCo5v+PbBflWICeExfqyhlU7lB7p4tHm0iKVqlqwWkjYAjx3L87GbSDVJ8EydbvbSepqvKP3bKPb6kpOSsi8U+dncZRX7ikO5WNvjkwuL53eCZYzEZa1trXUs/2RwFFiATX7GeciHov2PXkqbP69AHC6toqzsJncmxYhF68FAkNFdiuxKcqFE6o9oFqj7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQ0hWmHGd2uc6ZR8vvzg3DoBTxjxTa5MILqsCzo/iam5mET2nPIe/89eKeP1?=
 =?us-ascii?Q?uDd4wZYr43Gses+ZD39FSPkc7UE9nwfRQMQ2+E/CsYDbc1OM53pBkJnHohrT?=
 =?us-ascii?Q?KR6zfB7iUBrWu9aKllzvaeoCBxoXSOEoRjGCDXq3rIPL+eqzCVEwLE7yz5KS?=
 =?us-ascii?Q?I/UPJBh1yuSOXHYfugfc5bx6QKrKwfJpynHN2quJb1HLVqGmM5FXfoWy3nSb?=
 =?us-ascii?Q?r0epOg3Mg7sR+HATAt+NiXb9mSdTymXHXjvFMXl5cwVIOnFzhGyXzaGVMhVE?=
 =?us-ascii?Q?qCXXLwIqXM2woNOZTJw2WjSs6pNP7DtJVeIOjejsNgnrAyWSFBhk5JolSiCX?=
 =?us-ascii?Q?9/xL1YrOCtW0YoRZKRbKW+tdUdI9xBkXHS4BOPaW4sxMglQEyZSuz4u+IFfM?=
 =?us-ascii?Q?eHrENHpm4crQ5miXB7p+KeiHeKdE4jymLBritkxHAiH9GtKhL08eZIIQT6eO?=
 =?us-ascii?Q?83CVlkn68GFyPMPzQ7InrTdS58svuV6RwEwd39dciB+JzbuGieQLOasGmJee?=
 =?us-ascii?Q?TZwpQsDezbyPwKehskVfT+3d7Ws88LuzNfz0Lhfvru6d69pQlXVmPMOP1NSI?=
 =?us-ascii?Q?308/+2J8MsLsJJtEEOo19s0lQsQAuADukxXQQS9vJynDHl0E8SmqnMbbTqYj?=
 =?us-ascii?Q?XB11TTxDGQ+6ZhKiE6jzzzcrhUA/XHDm76aKpQ4ZHQ7lWZc5NVC3akmKDUsc?=
 =?us-ascii?Q?YJhBdLaPXICu8XfNnHPGVimJgztfXkUkseYT1hgQYSHlUnf7ouo/nb4Gx2pG?=
 =?us-ascii?Q?3LIBPR4DmbvQXjNOZSD7gWcGQKz+U/A3Kdl/QKX43uDWu231c/1c+0htU1A1?=
 =?us-ascii?Q?An/gO4b2TTVD8iMNbGEom8eMWp8rsDDChwJhH0HVT2H6Vw7MsSq6EQ9zJ/33?=
 =?us-ascii?Q?zQRTkqJhJk+3adJz+k2vNtCo8CDAY8itSBH9ZqBO+1z7zkreBRL5i4su1R2d?=
 =?us-ascii?Q?66XKZ6pbbgZe9B/3bG0qjkYc1TGUwEeA3qSIBfTvA09PR4OuLqrst5IBcPFD?=
 =?us-ascii?Q?vThhscrt8WPJVmHsFxYdDZ/EYNEiaVstkMNpBPJ5B/G1TyU8jozumxY2Ksgr?=
 =?us-ascii?Q?r372RI4sNWqlJCpbBBIZ8RZLdonoe6TiUAS065fVgyTSt7oKU+AR5+Gq4a+Z?=
 =?us-ascii?Q?Pfa9KGsEcjo/U+09ryEOy0UVYgjdxVasDpi3MRt3In4+A0veaKV5XaIwOKte?=
 =?us-ascii?Q?PP5G92bLsZK5WJy4nCxkQfXk8rq3OMqsI5Yx0ZHqMx5VhIl7ljfA/iNPqOa2?=
 =?us-ascii?Q?Qupc55BpcdX4W1RhRTQ8lzi1beJwfE2XXDKb1JE19W0OJMQo0uXbNmtsxd6a?=
 =?us-ascii?Q?xL8MXSRr+dPkY/zyJCadZxft39U1bHY+2IB2IjUDF2DAdUMFh1VExOqujMr9?=
 =?us-ascii?Q?gjktUD8+Kz/xrijGJFNLSMJay6+X016hrkpjKMDctyLbDxZ3oKQ192X2ildK?=
 =?us-ascii?Q?IA2Jr/pCz+NaiBzss1Dcd5ZBGy+Se8qsfM2YLOKEs0bycG0TW3ZI5Eg65Go6?=
 =?us-ascii?Q?FpEUOWWjLVb/JbvJdvylrl4AK/P8g221EmiiSolvSLjqScpI0bKP/8Ngdhei?=
 =?us-ascii?Q?RwLfnCgL5f5AE/w+LIoPVKXy23T3LVQOvSY3XEawxSmegPKI1R4BMrVe8A0m?=
 =?us-ascii?Q?pbpgD2PzHfWuYvIotU/LW9fMCqQmnMnmq/GuFoXFNn7u3fXlXZJLTuSJnLrD?=
 =?us-ascii?Q?DPkY7xUeoh/VbCAirCb3HL3r1JesZDnlzr3mk8zVcQMO5VTFXpsN/9mQFDQi?=
 =?us-ascii?Q?0YfOjm9DqillJqxDxdRGzg0F2UQhSR4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69cfc63-023c-4ab2-658f-08df3a950733
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:45.6113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxugznTnEzswW+3NbV/N7inKmGXmIhfCGAPz17SRubSlNHTQi/X8GqSqduTT/vGVokGJO6n9l8Gm0IYZl5Nt1b7RgF4j6Oi7LMZjgTfI71o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9056
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
so that access causes a data abort before the console is ready.

The Cortex-A15 and Cortex-A7 TRMs describe errors for reserved
accesses, while the related GIC-400 TRM documents RAZ/WI. Follow
the behaviour relied on by existing U-Boot on i.MX6 boards and
log these accesses as guest errors. Keep the reserved page in the
private peripheral device.

A U-Boot fix has been posted:
<20261013232700.289717-1-bin.meng@processmission.com>

Reference: GIC-400 TRM (ARM DDI 0471B), section 3.1 and 3.2
https://documentation-service.arm.com/static/5e8f15e27100066a414f7424

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


---

(no changes since v4)

Changes in v4:
- Replace the reserved-page child device with a MemoryRegion
- Log reserved reads and writes as guest errors
- Explain the RAZ/WI compatibility choice and reference the U-Boot fix

Changes in v3:
- New

 include/hw/cpu/a15mpcore.h |  1 +
 hw/cpu/a15mpcore.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/cpu/a15mpcore.h b/include/hw/cpu/a15mpcore.h
index 138f491c22..7b5269d626 100644
--- a/include/hw/cpu/a15mpcore.h
+++ b/include/hw/cpu/a15mpcore.h
@@ -38,6 +38,7 @@ struct A15MPPrivState {
     uint32_t num_irq;
     MemoryRegion container;
 
+    MemoryRegion reserved;
     GICState gic;
 };
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 28cda55ccf..f0e8b276b3 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/core/cpu.h"
@@ -28,6 +29,28 @@
 #include "system/kvm.h"
 #include "target/arm/gtimer.h"
 
+static uint64_t a15mp_reserved_read(void *opaque, hwaddr offset, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: read from reserved offset 0x%" HWADDR_PRIx "\n",
+                  __func__, offset);
+    return 0;
+}
+
+static void a15mp_reserved_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: write to reserved offset 0x%" HWADDR_PRIx "\n",
+                  __func__, offset);
+}
+
+static const MemoryRegionOps a15mp_reserved_ops = {
+    .read = a15mp_reserved_read,
+    .write = a15mp_reserved_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void a15mp_priv_set_irq(void *opaque, int irq, int level)
 {
     A15MPPrivState *s = (A15MPPrivState *)opaque;
@@ -43,6 +66,8 @@ static void a15mp_priv_initfn(Object *obj)
     memory_region_init(&s->container, obj, "a15mp-priv-container", 0x8000);
     sysbus_init_mmio(sbd, &s->container);
 
+    memory_region_init_io(&s->reserved, obj, &a15mp_reserved_ops, s,
+                          "a15mp-reserved", 0x1000);
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
 }
@@ -130,7 +155,14 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
      *  0x5400-0x55ff -- GIC virtual interface control for CPU 2
      *  0x5600-0x57ff -- GIC virtual interface control for CPU 3
      *  0x6000-0x7fff -- GIC virtual CPU interface
+     *
+     * The Cortex-A15 TRM specifies a bus error for reserved accesses, and
+     * the Cortex-A7 TRM says they can abort. The GIC-400 TRM instead
+     * specifies RAZ/WI. Existing U-Boot code on i.MX6 boards relies on
+     * these accesses completing without an abort, so use RAZ/WI here
+     * for compatibility and log the invalid guest accesses.
      */
+    memory_region_add_subregion(&s->container, 0, &s->reserved);
     memory_region_add_subregion(&s->container, 0x1000,
                                 sysbus_mmio_get_region(busdev, 0));
     memory_region_add_subregion(&s->container, 0x2000,
-- 
2.53.0


