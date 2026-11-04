Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11154606A335
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=tLAgKVm8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8c-0001id-F0; Wed, 04 Nov 2026 10:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8Z-0001gJ-Lp; Wed, 04 Nov 2026 10:42:55 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8X-0001E6-W5; Wed, 04 Nov 2026 10:42:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b//HudlPGXRq2EpBBhn5K7D5hKa+MZQXe15qNwGh9MdrwHHhyoF5WyvDOMqivl8rY+DGMUFR6CDsu74bg4eohi1Mlh/0CxAs2LCWmNKZGC9xkvZsxsmhHGXSk1DPrYkuRvukNxaOboJESvxRKXfl3yXcgpiSspwhWiAQ2bv/nYsr26F3Tt6Hm/SIvvt+Tw61ce2D0oAJRj4lMYnqTL/ztmHxkQvWG1wxRN3R1ZnKkE3t1bgA7+KiDCcVFBQYvlYZsu6aUAras/iTdcZJUb/Nx6Vi+eto4u9qouweEd7DdfdqcWKAuibndz9KvMm4NW35Q+tvRwI16yT2sYO2RylHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTTGmqL+1eGmem9ALqeNh6jTnCf1Tx1cEq/r7iHhCcA=;
 b=llZVePzUdEcGT5KzFKN/RNXDsuUPtLGkbtCvVYdFTJQVTAFnJ1eFa+jRNgzK7vP4jOPtKZ9idlXyntv0+iurqqGthkNTy0/FV/Al2g+WdvRfyAQVxo+WNmjz0bhI+py8dSxv6J36qhSbY0MNOeGqvRXWfE6ojCEujzL43zYKK54SLqwFLEG2yIT7y7p9dBfJRaO4cpF5Wpw5hzXU9IzoVw8T9QAyPWynoK7UwRrgdhEzYwdQ9Mb5Pe9LYhgu/4zrHqKdyCU5ZsliEA74rDxNSMbEYEDVBYllfO4zQtXSBdLdRk5d3KJeyLaD22IMQ45cuyx8O3rqGeKtlrxbPqwVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTTGmqL+1eGmem9ALqeNh6jTnCf1Tx1cEq/r7iHhCcA=;
 b=tLAgKVm8Cx8fhIgdZvwaSDEVos+8rOYNVM8BaGbjSkFqSE5X6HRgdLrDZ9Agzaj38U5YvFD2M7cSkXS7eqzkRgIfJ3A3PzbFn2jCDL78ua7b1VD1gBBOdP1+VSOHymQB5MupYMVBdgWL6UQf2Xje5n+1gcthHJb8pPH748a3z1ootNq4aPeVKIkklPCBBke0ONpzOYqGUDpVh0dhr/8oyqfoBL1SEoVRIcN50Eke2bjX0F4dvSkl/E5ptHxCNOBHHC22LmzJ4wbTOUhw7tJnhyWedh6/ZEJQIQitBAID/totP83kJFMvqpC/ulJi7wSPDZKCnzYtcE3Z33XVhLrH3Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:45 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 11/26] hw/sd: cadence: Add 64-bit system bus property
Date: Wed,  4 Nov 2026 23:41:38 +0800
Message-ID: <20261104154207.641511-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8b092e-c77a-4350-a3a3-08df3a8a457d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: gXcD7nw27MIFcIu2S/BFFUT/+FW8OQOaTakczURZqYyv1Lzpr1Fz7u7waKaRbuUNA5c6JdMtP/Ozfbb5ACS4sEa1xFoj1hwQZC3pN5BViXFryU19LUE9lMeliSVjuB/o2+p5HAUfA28XQGWsXsfYA0RauMBNN2LAVReg7hk6pFVWvkecmOu2VW1ZsW++9HmDB/pJZiLmtWK6L8+mbCnCb6pVnMfDRVZ+IGOnAgtl0ZaDIx/gSFVzNBFRb6pVO2xvo4oAUmUL1oieZZeW1N/G7OlaSt1Z+uG/AxwbI0ll3Caz4CPLKqYgCkyQRauxwRoIRWRdcLpAIIav47OQS9QkdQ5YrR9O7q6T/YuI0IEIf/yC269TTUfV/tiLqd+QKRsU8n4OSASwRnCbC5T//ShTHybjIeDrkS1DaEQLwFVGV5GLHt2p48yvwXFtq9DHuxIMSgtyKeRInVlvSVoHC9yn5zNHvvXM82qF0GAT3RcHsHWpcQVdB5JiLGIfrgXRrbO9PqEOMU5HXPEMi9vWl9HCNrPcmBZc3qAAwaHV3FB5C+JzIJ/TSjLzUm1lBjuQtq9xbE1Kkt5w9apcmQJB7lM/CSAsKCdJrEy8VWHVDSahCu9Xpva+bJ5j9RiuXB/IRoZ2qCTlGsO7wWte3YtNz7/jmp7Wbpd+jNIAyd9XsKWitDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/vatNP/1voqvsCirBWZK6Ufee8Pl+sZKWJ6zoY/Iq5A5hEH5tM7bqTqv5JL?=
 =?us-ascii?Q?UDv7HQMalgpC4m8zTIT8QqXjEUPGpb7BCd6BjvSCBDwZigMDDs6qBmkEC8a6?=
 =?us-ascii?Q?Er1sR8BD0aIGaw7yAY0jkE+WzWmF0BtcpUfwiuyBChwu/wub/knr9/5bhmST?=
 =?us-ascii?Q?5eO+jfaZQ5gTqgdFkmiWzBOTNpJ7D5TvKP/IIqRMRAFUladUVlqejaktWQZO?=
 =?us-ascii?Q?TJwDmeX6y4jDA0NMmAQmLcU5cQnWpv+KFWnaveYWVfkApw8odi+vtwaaYTqP?=
 =?us-ascii?Q?TrhoLT8Pgjpru5W1u37vaHtQcNJ6kiyL3IQB2e6W4KzgucfbcqXdcNebRF2h?=
 =?us-ascii?Q?GsxSJ5NB+I8rYlsxvFdfAXE3u7jNmEp0sgMYx6LMK4/UZswB8zy/9OSGuCtA?=
 =?us-ascii?Q?ToNUL7JYQsochRsOfGwQUHMz/YBYnanr0b6JzusMQLayrsH22F2XCmRTk9G7?=
 =?us-ascii?Q?UDDaxp5pfeZ1I9jTdAuTL8S/+B31O8lHpbOqICWzAx3be9xfORjuA5Mpctqw?=
 =?us-ascii?Q?vzaePZbqzhw/lkSw38jvuM5byLXRX30T2yDmcHx9ci+kfLZhM8aAewipjON5?=
 =?us-ascii?Q?4AqZdDWMHt1SUgB0pUDzapZ6/3UAeCoIqxIcFncSNKrbheVR41NpohoNCEyd?=
 =?us-ascii?Q?+JrvPhy2gHYS/+WcGHl6wuGsEwGM/BNRIZly6MrSPp7n6M3cUQxH5HszwsUO?=
 =?us-ascii?Q?dorZG51o4B2SNniN9NjMcFOZktXF51MN93IuY7zu38aRuj6QPTgUCrZj4YOd?=
 =?us-ascii?Q?CuFAp6c0hr732kxuR9L41YvZL1gRhpnmAxxVRWcWX9ANynMC1PEkThvgJspZ?=
 =?us-ascii?Q?qK/eIC+BtAFnX744ZNxmYTnxAViqoIYd2PRHOiy6iJwDzR4K3ykgLlNhgM6Y?=
 =?us-ascii?Q?X+3/yr5E+XEY7+Uuor6ClgbTdH4v3GkSOeRdfMdFP4yrVoc1LT06ZjwTXOkj?=
 =?us-ascii?Q?7VnlNt17gMwb6NjWyw2cUTtLMCaCTuFKCkhmB4rS4KRVdBguJJOqRyzp0kW3?=
 =?us-ascii?Q?m6Jl9jAF91KulxClmzusgV5n19nIVwp2uLePixdbPq8yDlKr22vqPMMt5Roo?=
 =?us-ascii?Q?ZxOk/hQU6Ru4f/SnZjm7gvUz17STYBLe/DY7996XpmzyBo56ieoHjRLzZohy?=
 =?us-ascii?Q?a5PE0VdlLqISA2O18S5tuTu695N99p4ZZ5peORbuNVORsZE4ncG0SYQaP9PO?=
 =?us-ascii?Q?zkhKPyMAVwjUgGngqecGLvJj4AcaWOWlLfAHlQQnpWr3QAKbTXCmgC3jZWfO?=
 =?us-ascii?Q?ezRn8z6JvFdDaX1FD6gCIMI31yaA4SD8jKMgeuheaTWt82gpj2bttWf7N4tl?=
 =?us-ascii?Q?wN2kjdw8rWUIKDnOe1TfTOoXEOJ168ip2kVEk85f6EWuwwrel7EtqQhUR38X?=
 =?us-ascii?Q?R9jNkFehVKl8aqa9I08PCzvf1a0CrNWcmIzNzmWXe6o5hAGfQEwOMNIn9+Jl?=
 =?us-ascii?Q?0IsYa6SbTBLXWXX7AK3tsieGRbydkDJQPmCjgMPbhmrqgE+9j6l4KYko4ztd?=
 =?us-ascii?Q?i2BMjDn9mtYGfNpvPDoR4vRSbALveb8qoUWBZgi66W7hdOcJdo1jocXi+bwZ?=
 =?us-ascii?Q?yV49CsHDodCaTrzWD9TVHIE6iy7eStEXmor2iQEOmuS/9wrG/x1N7yRUFlMD?=
 =?us-ascii?Q?oUDy9DUXg0lfTUWxkzTFoLiWBJAtZkj5degyosC8VXF5Vh8gOD5q5hdEfomw?=
 =?us-ascii?Q?7NTEh3rrF813i1zSoM3fcGU5G9dWYqACbS0fW/9OiO6lq2jNl/oFWnU1sNZm?=
 =?us-ascii?Q?13H3DH93AmdblKM+5YwlJuWpK5VQ8LQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8b092e-c77a-4350-a3a3-08df3a8a457d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:45.6815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGL0vlRGXpnTyO6gs0FylpIUOA+Az60iJF0URrjFIjbx8Rijsu6N/dH7bVIJWzW3CX9hSDJJz6pGlvQTITsZYx6cDW3TzNlQHlTsRQMbYVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cadence SDHCI integrations can differ in whether they provide a 64-bit
system bus. Advertising the capability unconditionally could make a
guest select unsupported ADMA descriptors.

Add a bus64bit property to the Cadence model and keep it disabled by
default. When enabled, expose the corresponding capability through the
generic SDHCI child.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

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


