Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13B2C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJg-00052v-LC; Fri, 04 Sep 2026 11:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJc-0004vh-NU; Fri, 04 Sep 2026 11:58:56 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJb-0004Pg-1a; Fri, 04 Sep 2026 11:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdkJOdwa0z3tg7+vgfmGb7V4shvljY5zLkqbkVS8ru/9/Mb3dUt8adcrKBSWUUwdsc3UVamIzyMdEXeZ+DTEAY4OjvRxDK1hbgA203stbU+wv/wailhsWbCVJMRgbPSjOxTkOXPFQPjBZac2qbOWaZWcxdGeKwslArkJ7EC3Okpqgg7ns0qQzSKO7Uev8z16sYg+5oSJDnnwCLdNapB0z4aIKMByU/gT+J8kOqaEKE+ngoP09V3MVSYH4LMx4VxLboul4Z9TtGiBeQuQiVeo6aZilxW6HxoFEoQ91Ctz9LF4nyVwQ8NH9S/uwLXPgtUdubDBJoC6GzpyNOZechcM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbVRc9tgHEbDLK5fuOyRDEJKPHnncrA718MiTnOhY3I=;
 b=V3J1+K3urMGTVRYAkBRKyLuukbB5rKW2dd+SJFaeAo6/udRe05ib5uAIowXqoZPGPpMcv5c63dB3S0IV9gkkDvwuaU9cQpIeyIyp6c45HoMV0Xmy5OoPzFgGg3D4xIRifrgnyxfc/62z32ggDg241uK97COzXfXrQTwbS9+ctDUimv3lxZ80F3k4swLQ9fAmsitToOGEwjqr0TfB+ljx/6tgT/BsgHo+8Y/xnjM4afrf+oSxQKNIillVagWDEncr+LxbYFGKx7AFjfDKjjcymSMHArsKUAJwBlZ1tA94m5ZbJIsXKdBmmOB99AtO1awgAyzqqxzSZuGdLb6qxQQVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbVRc9tgHEbDLK5fuOyRDEJKPHnncrA718MiTnOhY3I=;
 b=Rrvea0X3kwXmsMF/PTodFh/r70681b7VwZPjkUnGx9DJ9uKaGlz31TcZacCekd4x8duN+0U+/Xl8PdnpTTVzJD9V4aDW+krA7q6Di5zMyKpdR05V6FMXJLbz3RaFZWz1DgCweObDXypuHBGwDpz1UxSjKHXwLa8JYVnVnfO5axu6CB67RMWMMApewOm2Mj+9dJLK8P6NAJiYGdBAZ6ubIT4I4t0R37HyD3cJaZgFI8JCdPyCqn9MFERsIuZrpkgsSfiiYaSAJheFeCjfYuv0Dy3hEE/JOgAx9yPbvRb/oRFQOJS1O7dbspO621wjZPWJ8iLBUDoy+m35g6rjKiQMeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:44 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 10/24] hw/sd: cadence: Add 64-bit system bus property
Date: Fri,  4 Sep 2026 23:57:29 +0800
Message-ID: <20260904155758.3833179-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fdf228-d8da-494d-dff6-08df0a9d6569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M6IQMlv1cI15LY4xdlcGkE1dPnGyxl/kqi4HvS5koDnujwpUh4XAZWnYj4pyWv5GM2zaLcE5pkh/9I7dgyi76GCYq6m9C0n67mE/40z5n9QXt0kECYBJQGIoAzkUPGogHsj9b8hSiexFodf6xTNp4+y/e7GUwStIBe4VJ+gjPB/FcCWJWmstx3MV0WhPcm/N3jCkL9Uvqd+BwQo2F/7oNFgkDU153LIXGTCKpE9AOqXp6zJb9B7jRNe0aAysJnp1IOyekYL9xiw4SFJfec3B5oFMzhbr5JcGh0fJtGQ8hM4xB0FrqOcFAyGkQqRyi0RDWot8Ohnzz4mHsR5QWXJ9+bEp6FGi79hY3exd37tBrfqBnWLkohPBaFJg0rzSqnyreJzD6uX75qf77qJwX2SZ/WCrmNJHdrDj5Q9DVkonFosmztBSlux8V+CSgHEmjsFdSIZ/xepQb0Iy7gHehzS0mA6urJR4j5cCrL9H2zMPIn/SvZ0M/diTurN3zf1LmEai4WPCHNT58R/2l3UovZlFz93fZRSxAOlx3hO69mCuWfe9xcsrRipwjJQqbloHbdmES0E5hkHhzDzgG7QXtwwBgdE9nIc3C9zn6U8puLqC57cBlL/rc+207K9iMnd1iEoAFiJ2yReQXZnHM9J5ozsD/BTd79CsdLEcozFp+VwXarI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wz/18nK784jNf2KU6g6bNimeSegK474LydtUvZw4YPKwobLSBfA1VI316Vl2?=
 =?us-ascii?Q?HnLWN3PVOeP4+6eb+2JUmW2PBZsFBQzI7ciWEuo4NzuZtuGceWN5VeZ3FUCw?=
 =?us-ascii?Q?wIjggo050wKi6PSj7XEn9Xnw6pFwF0pNAST0MiXJswiomn29l4vKysVa9LOC?=
 =?us-ascii?Q?72b86XaZn1trZ1M/fwPsSMKec+XECatlzGget2M5JDiQMTt/qTfPhNH4xbwd?=
 =?us-ascii?Q?/na4+e6JJP8+71JP+9JfLxQ3CR05yhzh9X/k6T2R8K9gj1c8LE3dYuhVYKWX?=
 =?us-ascii?Q?LD0eVRKNe7nfoaIRNxKwT6xGowbHzElYMy6yEWYU39rhwyr+6l+zcmG66HEG?=
 =?us-ascii?Q?p8ue8lEjlq0JahHeo+5w4dDc51jcf5UWKiJfFyJrOJrlYIGW2QBlvq8CmCcZ?=
 =?us-ascii?Q?Oa5LjqSdMbtvPbW/afIArktkSw90+pTqOS+GNRRVzeUxEnS0As4D9rzMa643?=
 =?us-ascii?Q?0Y7IQJqcx9ewH0Sr6eMyvx7oiMhMWqIndsPjQ/WfVJVhRWwWMSyaIzpUjZRD?=
 =?us-ascii?Q?ZZ2+3NRShmw0PTa9bmWIzPbpnna6VreS4N/0PaEX8SB2gm6EuXjTliLCv+4N?=
 =?us-ascii?Q?ZTdVXoXU3M5fo/J5Nrp3dZOc4+I4Ej2Lrv8DfDRJ9tJlmwM2cr7JrsJFNubn?=
 =?us-ascii?Q?n3DlXePm0Fml2tyb/TvQwOq1pKmFVUUPrv/ukWocpGQ62FXhfD+PcuRTsG8l?=
 =?us-ascii?Q?Vx6ACQh6UAkKc0KDyIP/ztDGmg+HtAzMH6pThVCaJOTzLbUPiyTH0oMkBxyA?=
 =?us-ascii?Q?jAWXZXbHmyrgEV5zro6BdXmWtDu++Vlx2PwJcxCrod21QjfnK8K3tbF6i1pp?=
 =?us-ascii?Q?8cuD0LIVRQdrCN/t4TE+KdrFbb81U8KdkoJgRhzbotYJweP7giIrd5K6/E3t?=
 =?us-ascii?Q?vHK1/0elnY/m1YK+Zf8SJ/zxhJzSHhnVNEoJSnzqsOaGCKnl8qVSPhDd/vwr?=
 =?us-ascii?Q?Lco9sdflYkLz+2Ml3tpCGb/+VJVVhrFkZ9ecotuMntmJyFmqDU9KPCoLZmkl?=
 =?us-ascii?Q?E/gZPnajWnFl1MV23waSPGkxn3L73Yi/MN8vLzNHQ16MeXLhSwp5gwxDz02b?=
 =?us-ascii?Q?8hlhkjpoe63YFMrXP3Mv9DqWSPT0hN7bruq15DXGsBxyooUXodrnG45rGQvp?=
 =?us-ascii?Q?hbKYgcpWw2lIE4wwfoQQvTe5YX6V+iw576b7T1j/yo+BG2nBS41eA4rLDSwg?=
 =?us-ascii?Q?FFyjizKqeaj/W0glncij/g3r87QdrSeI5er0fnQfG0fDUtqJH3+Q6ki4WQc1?=
 =?us-ascii?Q?4tHHGk2piEEsMUAtwsBjv5DbTPwDEmWB0gkxrlxH6C4eda4oWOliebEHd12Y?=
 =?us-ascii?Q?MmygZuXuUuqApyMruGqxqjdfJwco3gVy+tr4c1g8paDKHiTqlw/10JVAknmb?=
 =?us-ascii?Q?KrfQrO5cUjgWq9uUkQu1nquTqPcjr3+h1CbjMjrxxJD5AKUcQi+7UaAR59FS?=
 =?us-ascii?Q?JNUGhK2il+bSdAQ8AnYLSEBtmXXHMcOLThMiPUaLAQhGcjCXBgHppKm69FnY?=
 =?us-ascii?Q?tCSFURBrnDmS1G6PjzdtDvDksks+po3wsVxm+M+/34ENqzrswlbA+rWiOWp9?=
 =?us-ascii?Q?ZwS5EWqAzD1/y9cI0OHdxWRckhRRIpu7al3ozwOxPfqT5P3BqU1nJHom3Jpa?=
 =?us-ascii?Q?BIL34QCYOU/jINJ0l9grQEOv8nEaLhGT3P2v+bDMJoPk8u7Ged1CC/wC3WMh?=
 =?us-ascii?Q?+qkbPd4s5gfLKVnGhDptTEW5NnLWzm5MEl2CeoaWfS2qsQmHMfjn11d1sVcS?=
 =?us-ascii?Q?SEo/ZnDKKMjbpWl5zdzgNmJKlm0Bq6Y=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fdf228-d8da-494d-dff6-08df0a9d6569
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:43.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YObO/091uxz27Mdq7317hXQIFY498LVwV8eIkzER0MvVPi5POrOq/oNknScc0vHXcwmlgiQFMMXQZhk3BuIG2+QkQjOCl02/bQwNmyLOqes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Cadence SDHCI integrations can differ in whether they provide a 64-bit
system bus. Advertising the capability unconditionally could make a
guest select unsupported ADMA descriptors.

Add a bus64bit property to the Cadence model and keep it disabled by
default. When enabled, expose the corresponding capability through the
generic SDHCI child.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Make 64-bit system bus support a device property

 include/hw/sd/cadence_sdhci.h |  1 +
 hw/sd/cadence_sdhci.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/sd/cadence_sdhci.h b/include/hw/sd/cadence_sdhci.h
index cd8288b7d8..553fa73842 100644
--- a/include/hw/sd/cadence_sdhci.h
+++ b/include/hw/sd/cadence_sdhci.h
@@ -34,6 +34,7 @@ typedef struct CadenceSDHCIState {
     MemoryRegion container;
     MemoryRegion iomem;
     BusState *bus;
+    bool bus64bit;
 
     uint32_t regs[CADENCE_SDHCI_NUM_REGS];
 
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index 8476baf67f..875823a50d 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -25,6 +25,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "sdhci-internal.h"
 
@@ -147,6 +148,11 @@ static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
                           s, TYPE_CADENCE_SDHCI, CADENCE_SDHCI_REG_SIZE);
     memory_region_add_subregion(&s->container, 0, &s->iomem);
 
+    if (s->bus64bit) {
+        object_property_set_uint(OBJECT(&s->sdhci), "capareg",
+                                 SDHC_CAPAB_REG_DEFAULT |
+                                 R_SDHC_CAPAB_BUS64BIT_MASK, &error_abort);
+    }
     sysbus_realize(sbd_sdhci, errp);
     memory_region_add_subregion(&s->container, CADENCE_SDHCI_SRS_BASE,
                                 sysbus_mmio_get_region(sbd_sdhci, 0));
@@ -165,6 +171,10 @@ static const VMStateDescription vmstate_cadence_sdhci = {
     },
 };
 
+static const Property cadence_sdhci_properties[] = {
+    DEFINE_PROP_BOOL("bus64bit", CadenceSDHCIState, bus64bit, false),
+};
+
 static void cadence_sdhci_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
@@ -172,6 +182,7 @@ static void cadence_sdhci_class_init(ObjectClass *classp, const void *data)
     dc->desc = "Cadence SD/SDIO/eMMC Host Controller (SD4HC)";
     dc->realize = cadence_sdhci_realize;
     device_class_set_legacy_reset(dc, cadence_sdhci_reset);
+    device_class_set_props(dc, cadence_sdhci_properties);
     dc->vmsd = &vmstate_cadence_sdhci;
 }
 
-- 
2.53.0


