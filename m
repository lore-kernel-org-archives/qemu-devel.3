Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD69ACA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAS-0005zd-7R; Sun, 04 Oct 2026 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA8-0005uI-Rw; Sun, 04 Oct 2026 05:05:42 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA6-0005jn-Pj; Sun, 04 Oct 2026 05:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtgjKKB3AqZtb2qBnVPfggsQb9ez4ZWP57RVle8mNa654HqnZb+71B0ozIc7MtorX+lPajHFl+tzbMrojWOOwcHS5VzhvDl9fb6fg6sUcolPz2SQdh/RjGxn35Hk84lYTYGlmYb2VViHPnXxRlYuOBOLvgyFbYVU47rTQAPlnLtTGISMULJ93ZfTPNp3P0As2CY7kjXLqm7QfL+KtFBJKy+/CaDawK7nJYCrbTPDLp3ZmslORfcUU/8TityOT6BEowWtX5ANQmkSKrmAdvPOQG2QyNOK3aYOsf+KheewVnlsXmGAWIPKaq3L8OA2ayWwbvTZd9oGHvEhpCurJIZPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQw2+XSrhinHQKTdGGYsrpNr/qfKp+c67h7NlUKlduM=;
 b=jgpV9OA5BaFT2eARKXn363zcqcnsaELkyJg+9P3MlEBYDzZBy8tgVaSd0VnHm84KQOUK1HfVxrU6gTQI14BQ5F5ZeUvtzvbTjXQHjvNp6S4IaNcuBbjwrWksK6JRQ2k+Ln7lydbAhVpOFVG9Gh/ZNIgUn0rsN6xJipr3Ma/vkvZpUlxoqSL3Pm1JFStnp9rC+mpBWozmY+4AI875jVVGl4W5Wh2beJJnOyRp8u0JYjnb8KHSFamei8T+HgHkOOehiab1XmqgQtrPKYhD6vWpGJfmQuiggeT38Ugbqo1tM9Ysn4x7VQg/k6rg3WJPlzEgQNmddzTp3igNACxgmRPLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQw2+XSrhinHQKTdGGYsrpNr/qfKp+c67h7NlUKlduM=;
 b=C89hJRXVXU71nlNLotooIhjOqoVCUHVf68j9LomoctzmZkSPHkjeMCTobi8kmoFvElN3LVdurT7GhB1n9WxaZ58OZY89rTjge4QCDgi4i3QVAgxDMYGZ4Mbw1OzXAlrrNKLhi2LPntgroPpydbsh8fQa/SgndJ7aEByOxOZJ23seqow2DBs8GtD3Og7GISqyBnPFEAcpHnRumWtxNd5xLZbRqFNrhNc74YqeknMkkx9O08cdMyVLI+6W0L5Q+8C6N8LBUM7Hz3D+9jqmUmn/7QQwPNSELMUTumNCPlqkwiptcqdmrsFshdKZTtBT59v2Q/pHs7W0p6IjGj8wRBguWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:29 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
Date: Sun,  4 Oct 2026 17:04:51 +0800
Message-ID: <20261004090500.3082641-7-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac5d0f14-08a5-46f8-41aa-08df21f6a305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 8GhSZ5uVGluN1gycLH/5ZhlTMp6g/DQRtVCVQNHyazrvjTNmjHTOs6ak9UqZOxpXM+Vj4qg6KjLEliJcA9OPNdaWN6drhoKrj4XQ9B08NXjzlT4SB4IIXrvWGcE60+tuvA0uQCeltXP3plW+omFJwDkvm0OYC17GNVae/Cur5ybZv/HzAGsnEW7ddOAVidxM3QEFV5JRt7nvV9a4OZgEXtfmmKopIMn8MKW7gdYxLxd3oyhRt/gi0JfVbx2jvVJXHz2SPhnvAgJI8gT2iVQiLEWPu/Tf0+N5m6wl5xlr48a41FlIjCrANHa9ULLtZTH3SvtJKekUcTs3PLu71FcdMiLJC3YGw7YpNv3+BmuE89jHI5xA+XELD/hYl8HizvTEqFCZPcw7k8+K/JYmpPvO28J07aNSkbNssLfqdz3AzSfvg2CaU/6RBqO74N/Sh73/sySAhP67ov0/9PDB9P5vnEeEu0vNJ3D5EfKyyXBwd+2uPeSnyhyITPRXvzSICi9wJuIH1Hxg8E+qk/8pG9Gzgp4kWBpIH5HQA9Mf6mq56XUXBGidu5CJBpkOwi0TVfF2uIx8CIJHOZZzL6KKLFUhrcE4pKlWN+k0V+xikfaa+RR8J6ifRQI/J0j/8rwUuBJBzt8O3e8cBmc0uDk14jchte8XsxQ4+UBpqMp8bwOG/Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVqP0e2MMiplOa/xUlfcnaUqk4tlWaoAuPy5wRgz00a5PPkmPVUMiqa5L1x/?=
 =?us-ascii?Q?wKnM89KO5GlejPmpswKwP/UARJ0gyTbvJj5+amFvJZl0ivaqqMol5ZK7+rPf?=
 =?us-ascii?Q?xZVzJDbP7JTmQmp895VypMcX/c35WTA8HA8zPIPEzZJkDgvIiauzkKCp73X+?=
 =?us-ascii?Q?5LWo7k0AXzfi5QOnA+dwMKGLJFLQZ1aOlZCDjJns8f07akn9v2fhVuRoaqdP?=
 =?us-ascii?Q?q8ORK5bMkP/t4n/3ZaOHpYKD0T25+yS7U2ltJms+eW9reU3e7VCdbVwzBkXg?=
 =?us-ascii?Q?5+FUdQz1LNMBczTksVNIUIq8kSRUbAs+XBBEHG288lw2pSuN1ewTFx3n9x2U?=
 =?us-ascii?Q?dyyroq1u9XNIlkH17uOiF60VcYa1RRwzTqsfd1+NjCSJ0NRS9eUK/HFH4btj?=
 =?us-ascii?Q?BfOy4yJrR99ejO5zh4pvcErBxXIySjoE8W75N54KvPf/hdgJtPKdz5zp9TyJ?=
 =?us-ascii?Q?KkInYoQOPn5SaJ4vRxuXSlmSVgMDMKIdigcvN5bvUnMjf6Ip+re3KSz8hlTg?=
 =?us-ascii?Q?jfTqG3yAz19l1JJL0K8i2rmokEN3sW47X1DuuGko66ImUya18evwkUkZ/Ox0?=
 =?us-ascii?Q?5bOfhXXWOFPRCFes/CVLwzyWfH0gj4/pxEaIdPh5Sn+PVmYsAevvMx9QrvGb?=
 =?us-ascii?Q?W1fnxYiF+5CzBKo0tdOk6z/u7x2rM1j5QemEE7KMI+jFRV9OmQgocppMlQtS?=
 =?us-ascii?Q?qi3yZ8I9i9IIojibsLemIRj9lEJx2qgTJwDxQdEjs5nJyuSDXZFJ51EN+IIw?=
 =?us-ascii?Q?HWV3PSDUSlYKTq8uNO9+KbWeKPnhq2nCb50R4N7XruauC5+MDFvRqO0Ok/DV?=
 =?us-ascii?Q?Et6FhHVFhPBLCDUtMBIuzI3fZXo+vqVHOCE9MTbcAoDzTcphOBEYWgf+NtB2?=
 =?us-ascii?Q?wyHTG74H3gEyWQN5VWSiQj03isj+w+Ar6WtN4X4IztW2E5asUt5t0l9ILsCM?=
 =?us-ascii?Q?US4d6NUzXuv7o1hvrHb856YszGhnMfh6tc58nDCkL7Jl95vq1sZfw69GH5q0?=
 =?us-ascii?Q?JJ45QD6RryV5LsAbpTkS5BBVAAhQWwJc1QQFq1o70U8AwGLKaXeuYrJv/0h5?=
 =?us-ascii?Q?CiEAWVjLqvXF9G+fBBhvM8cKLz4UFKLe4IoXC3Ucvb0vL2qKMbh01OLa+1ZX?=
 =?us-ascii?Q?8hFaJtGtbn5F5qXRWgjgOsA43WdgdxEURkSVJUlfGcFxC+PeXKoy9K6kj+JX?=
 =?us-ascii?Q?DIFd+at3CdbXCNl4R+hE0gyTA+KcDOBUWcRqgh1jEnoDfA55OkEzYj1vZpxO?=
 =?us-ascii?Q?WnyZ2qKRchwWe1CpYe7huFfyTF+OCTJi96oOFTbm7InMm1kdjF/MpwCf+KkW?=
 =?us-ascii?Q?ugn1AdF0BYYof7ZMU3UAs3KbTfMHR52W45Oxz9yPSx23LatJgiFL1ELujlUu?=
 =?us-ascii?Q?vI74Jsp3Etg4gz50x/XAVoAtHEzF/BX7Oby2L2SUhYmoVIQit3T6Xv89S/0J?=
 =?us-ascii?Q?9dsXJ3DUz0CdVDmZThTTiC1tCeTWDdr6gUOxV14cR+CoutpE/nN40lVB3AcY?=
 =?us-ascii?Q?kADIyjsmbVycxBLWFtn2Pet8Zwz6PFCbv35Z5T0IAaN5erA2JwJ66uOf1BCD?=
 =?us-ascii?Q?9NAgSl/a7KCL7Xz0ypjr1aUsNgcz0GFtC7AibXRgLJmsWPG9ViYiI7V/AYzI?=
 =?us-ascii?Q?WH6grj2GYQDcM7QoNyBKQS7Qbz+TGGUgpbEdKk6YfQYwpXr3vvgjX2PURJNp?=
 =?us-ascii?Q?7qkHoCFffZ6K/qU6GFuQulnee9bIUrXDnU+x6OWEJ6Q+VM7uIKbELexepAKO?=
 =?us-ascii?Q?iDItlhskRS2jpnJrA+XtfHX0bXq1rmM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5d0f14-08a5-46f8-41aa-08df21f6a305
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:29.2054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gloQXfWNxN+0f6opcgGd9ptNJOjsb9/ODqmlQk3cL3q9CxLOoAj9DxqEwk4TsSkDvly+Hh7651w4bi+x+rti1ti4YsiP9iTq0EQe9QUffk=
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

U-Boot enables i.MX uSDHC clocks through VEND_SPEC, so checking only
the standard SDHCI clock-control bits drops commands and prevents
firmware from loading its kernel from the SD card.

Present vendor gates to the common clock check during uSDHC command
writes, then restore the guest clock register. Retain the standard
clock path used by Linux without adding vendor quirks to generic code.
Report SDSTB and handle partial vendor accesses in uSDHC MMIO handlers.

Reference: IMX6ULRM (Rev. 2), sections 56.8.10, 56.8.12 and 56.8.26
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Translate vendor gates in uSDHC MMIO instead of a generic quirk
- Preserve the standard clock path used by direct Linux boot
- Handle partial vendor accesses and report SDSTB in uSDHC reads
- Migrate the vendor register in an optional subsection

 hw/sd/sdhci.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 14c312a691..40cf407876 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1613,6 +1613,24 @@ static const VMStateDescription sdhci_hostctl2_vmstate = {
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
@@ -1632,6 +1650,7 @@ static int sdhci_pre_load(void *opaque)
     SDHCIState *s = opaque;
 
     s->hostctl2 = 0;
+    s->vendor_spec = 0;
     s->sdma_boundary_paused = false;
     return 0;
 }
@@ -1707,6 +1726,7 @@ const VMStateDescription sdhci_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sdhci_hostctl2_vmstate,
+        &sdhci_vendor_spec_vmstate,
         &sdhci_pending_insert_vmstate,
         &sdhci_sdma_boundary_paused_vmstate,
         NULL
@@ -1810,6 +1830,10 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 #define ESDHC_VENDOR_SPEC               0xc0
 #define ESDHC_FRC_SDCLK_ON              (1 << 8)
+#define ESDHC_VENDOR_IPGEN              (1 << 11)
+#define ESDHC_VENDOR_HCKEN              (1 << 12)
+#define ESDHC_VENDOR_PEREN              (1 << 13)
+#define ESDHC_VENDOR_CKEN               (1 << 14)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -2060,12 +2084,67 @@ static void fsl_esdhc_le_init(Object *obj)
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
@@ -2085,18 +2164,6 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
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
@@ -2104,7 +2171,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps usdhc_mmio_ops = {
-    .read = esdhc_read,
+    .read = usdhc_read,
     .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
-- 
2.53.0


