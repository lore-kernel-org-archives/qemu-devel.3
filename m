Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA89C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoMY-0002nq-Bm; Tue, 28 Jan 2025 11:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>) id 1tco7x-0004Vp-MY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:07:50 -0500
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com
 ([40.107.243.86] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>) id 1tco7v-0001r4-F7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:07:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkwrGD/kVFZmeyRSsoJd5xjiXu/40tBgZK3Rvh+mEnVSIpdNahF/IlgGQ56D2Doc+AtjPJDTuqpKolk532c7YS1KQ+4tT/3pyb03fk4nrGg+THNjmPOcDt32NVXB1aNlPVGqhk1FBdx5akoq9O3HDR6XXeuWI2sKEc1pfF12i3kRWL4TBzxbyUAkZUiRwHmhLXMh3NWQgsakOkdu/jTk5Rp+ggVcD7oxM8pqs9Ng473nZQB3nDotRXOE/V/hsCYpR6QqrrEEtbsBIPQAATSrel0ytCUq0c2Y2ZJMFJHlHBjZ8QXZlBCv7H8VFOfjhoWeir4xYKztlIJyFoiJTkwkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sljcWpfigYeX0ULkEdIXnEwyOkmS5zmxlkLD9bA3XT8=;
 b=Cpr6nCSsKwVWjG5wpsrsA7IECOOUjy9ltQwpw83oQqXaLOvYRkJnCLz94h3HnjHzZi4xzCap18Ch11f8kjV/aO75UfUh9M7hfMzeZBscTtuxcoZr6IvciTlVLJbzy0YuSsJaIGtFbmESHS7eECPBwyTv8IcG+sbrGohW3zCJla38HQlVqQ/iUcc+7eda9c/ZSutt/g0icjNxow17VGF4mL/ONJDTQ6FOmhRJqv1A3A/1iTjzwC1MvXWxQMZV2bWlSar+82dRN5w0FMHQTVK/Y232jro1d//f4qAdfZFYEYjnxtNqlmh6j8l/ZtGyBO13MiII1PxuFEjKqa6eBhFVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sljcWpfigYeX0ULkEdIXnEwyOkmS5zmxlkLD9bA3XT8=;
 b=fRITqRIRdxYlI+LVBtXQSdPycd9XA6w46J85WaosvBkVKwDtT8aidyxRo0PXEHunduQ244ipAmvHz4DJVugy4zw1YCCLGD71yjk6ThUkVybY6sDPmZuaDGgiJmTSBjyRmCKX6cRSlpgHrxgegvsd5UP9khuOURW1vs7d8TpuUSHoK9PRWnBip7caa1SUQOxH7okJUdOkI+Ay7FVZUe3uGROM+FCNS/Gzkt7hgxc1Q/j3jTaKohhDoDYWHxQJJRSj7n25gNzpWTrVJnYiXkXNNeiAmieTPqWB/b+IMHkifSwsy4jE7Q9lb61i20epWEi+FRXC8V+RcbmnmK6hqD0w2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 16:02:38 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 16:02:38 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 nathanc@nvidia.com
Cc: ddutile@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 ankita@nvidia.com
Subject: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Date: Tue, 28 Jan 2025 08:02:37 -0800
Message-ID: <20250128160237.3379569-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d69549-65e7-482c-5107-08dd3fb5300d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWHSrqGZcv12PEN1JafqF9bc0JatBX8c4A3GqIFBKCSq1TUmmYCO92xjkEGH?=
 =?us-ascii?Q?vCYy2/Im4YVDsXmG66ZDa2ndbF8RUIzbRha+iBJQjA54ApM2FfYXStU0k6zb?=
 =?us-ascii?Q?YGxoThdNlkA04fYvjOqQv1JBR5FUms9A8Y1bkcvRmKIk7zSqZGjpvow9ilBk?=
 =?us-ascii?Q?/on7CwNibM0eXTZ5OhfE6bS0VQMiGhRg7G1soDte2vdcJ0yQESXkOVjCiTwe?=
 =?us-ascii?Q?UqLLvHjnBmn2iK9qaQ9KjHKaWtRMLzabkDP14fWAvDZo8wgjVskqwUNDb0Wk?=
 =?us-ascii?Q?ghnz/gDpYTJjX1hyfN52bBieZ0i3reP54go4hej1LrNSQveGXwsMthQjgd4L?=
 =?us-ascii?Q?/pxYhVuMJ7NaNF1fMop8n+PpjuEXn4HPp6Mb/ZOYqFF5f6jeE8/+n40i+Hla?=
 =?us-ascii?Q?4G7iAYBawhMJ1fkeidBkJciBT/ms2lIfzxNXcE01cOyXMvR/qoq5fIU0GIpu?=
 =?us-ascii?Q?U5d9aNCmCjXT6CRjMl2H1o4bG+FvlnQkbHi2UVEf3IvvrcJAhShb9wEbgU3/?=
 =?us-ascii?Q?O2Vsi1UbRHoGjoYsTjVF5zBNODmHTKJttVfekYn5yXZC7ff3lCnH0XxMCDfc?=
 =?us-ascii?Q?sJLqMM56xKkW4i0M0X9lHNsmLeLAzKR+a0pBE/ji2A2/KGd6N+fMqDDiz3zf?=
 =?us-ascii?Q?0z9ei/QkkIIAPKtvixPYKhuDKivMrYXV21DlPkLrZlqFvIgiZPuHaYWrdtYb?=
 =?us-ascii?Q?CaFqxAoIk/CflYrfwbSyJQaDIUGWdJeMI5wNv95VXZ8sbAT3DYMyIAhvUx4F?=
 =?us-ascii?Q?207cdbiOF6dFq1ipXloelpfGDrEd5y2orwMu4BfOUvUZc/WyXEoMl1J7fdMS?=
 =?us-ascii?Q?6mLqZKXEyr+QW7Qi4WjPD44vKy9f2w66Zl2KoXuBpu/rgqCd7rrLlig+BxaM?=
 =?us-ascii?Q?Ez/xpfgsg8yVP8gxFIMnoY9c4g7KTdLmJaDN4HTSLLM1uqd6pW55ZS6XbbyV?=
 =?us-ascii?Q?5G/TC3y7tOwzfnFjXPesQrPBDgGLetZh0AQAS0Lkxv30eXTN3If7Vt01O2om?=
 =?us-ascii?Q?duEh/h7NuvkDhEo5vrM+F/EB2r6byfBEoCbptDFSeqG94ZR6jv9ENxMf7g52?=
 =?us-ascii?Q?6X1nEZAhIGndSV7AlGJEWMmWZT7M4EU8cRDa1pVD/t5Sc/UbYuhSRRdEvRtE?=
 =?us-ascii?Q?esVbkPcY0JwRtIhrvPpfZGhEBnyLX1LLhumv2nZ42Mab2ptWfRynkaRPdl5F?=
 =?us-ascii?Q?ujbbT8EtVUIWJcxjZrEENnTAjPbTqFFN0Hr++ZrHAMj0Ob8GYf7wuGTgIZ+s?=
 =?us-ascii?Q?Ib3cgSKQ/C/6ZwfEfSNANq7OyZkosMCZO33bteMA2AV+3St7NP+ogypdBjUF?=
 =?us-ascii?Q?GWSvIm/5l3rifJ/iYGQTvgM++Xe69ggRn6uDF7p4YD9wCNZ2+D5kiCALWpLt?=
 =?us-ascii?Q?n2PhnqdSKwRpFhGHNmG34Lge9jm0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYNcPgTd0bRlZ7yx3oWjvdVBojiJUK4enjRzBKh8zyoxekaPmA13BSyRNXQf?=
 =?us-ascii?Q?EQ3aPY34O4rVellbtrHJ+lwFHujlM7aq1MzosGFVncQ/RF0eqcVYAPW4oYwq?=
 =?us-ascii?Q?sLgh/S6I241ZsoBjTQY8l/A27kR4Bn99SAKDb7+5AT28m98uGaoweS2EU8Uw?=
 =?us-ascii?Q?K2mULiEdenjQZ77ia1cXNOw9QOjaBUMX8MruBTfiRLTpgOWM+nhK9upXwVoT?=
 =?us-ascii?Q?KmUhrpHOk//vcuVKHSSzFrbDNqx94tpP+LnbPmJ1RuutRpQM413k4l0TjJQJ?=
 =?us-ascii?Q?B95kcU5NI7cfa1VSEVRAmGiTqC4yfnwo5+AIETCHAlfYhmXbdyn3k9s1TaU/?=
 =?us-ascii?Q?c7RZner+SytjGoLMokIK5dNYbXUwJ/Hsb9VXWbrkLeHvz/ajT3XpHPXUGmHM?=
 =?us-ascii?Q?p/N7M3wXegk3S9vB7P7ahrFNQzUvlNT6DUyyPWpVuroA0KqMYpvQ3mCw4I5i?=
 =?us-ascii?Q?uu5CuwWrxtbR4RHQ9Cv96NSxWl3sLaaRCI6nxIKPS9wVNF4JV0944lYhaKnh?=
 =?us-ascii?Q?lLdyXUYuGAarIMDTvCTUEv5j1G6V8NkbalEtnTtJoxd9uaHYlINacTvefkXp?=
 =?us-ascii?Q?QEFKxqN/1XTX0x7EBe0Em6/VJ+B+cu3qjXOVrfFoE2Fyunlb1pPrjbNXOzJe?=
 =?us-ascii?Q?HUjVr9J3hXc2krm9aJMMA+fdTH3V42Q6oBXb5E3dZ4HXRrhQNzmgvGqM47cf?=
 =?us-ascii?Q?v35f20stWtN51fsYeR+d53oVaoAXhZwNR0mZc4fXhtbAOU6yXdydvVYMe5+/?=
 =?us-ascii?Q?grVeQt1ySmhYHLSmkWWcSkjX9HTsL85T5oNyeL+jZ36BPHNZPT9t0Wzz+joB?=
 =?us-ascii?Q?sUzLdKFpG/nX9WYWrt2Ri/uA/0noZFPRtQEFApLkk4ETJQnvpoqPteC8GqFq?=
 =?us-ascii?Q?dGDFRiMIQ38Z0lXxBCnjREJajZQSCUbJtpTJET6Z50EUMawmO/I4MafsSAFl?=
 =?us-ascii?Q?Nzaex79/mST0PoGuKKmz6zhObPyEQkGAM21ZQFBDa5G3RhzTp8sJFyxfz5TF?=
 =?us-ascii?Q?sWX6nEySMCgw9JkcEIjq4zDImrO4IryKy+gbFx8Px48XLv1+gWQlpQ4WdkFs?=
 =?us-ascii?Q?K9MG/ZI/VFZZEilaLIe1nUa7Zoid6mgFWrTKjw/7FdAVNNjlXYF5A62mHyhs?=
 =?us-ascii?Q?fWfy2Kb89w83/NmsENKxK9R8zl4DwFe72hYfFeVj2yGNlgiW7+8HnZJYV92b?=
 =?us-ascii?Q?ljZCZO+hyAnf9JOf9J7xiX+56SJmhjzGR1Wmh0bywsLsySDYBGd0xmuID/Fz?=
 =?us-ascii?Q?rDFnE/O4od71vbOqdChkL223bpEYom8f2Lt05Laq9V7BHCxsl+sNRysty4LI?=
 =?us-ascii?Q?bLCxn+GQOhmMIxrDKysd5tAcNJB1sle5xmyV1savmVDiSRZxIkcGlgN/H4FG?=
 =?us-ascii?Q?Yl/vhahtXAqr3rkB7yQWITBuct6BHphH8vN59HNxm46bA+g//Ae/udPSu9is?=
 =?us-ascii?Q?rgiGdMWlik0irUkAdW77NXt/UXug6oRj794a6XysICd0Fs2rM9UCHG3e9Dsu?=
 =?us-ascii?Q?5dxW/QUS1m2OyAvyljOp9G5abVxoIHQ//jboA1DugwW0RAamHXV9cUmXuGEc?=
 =?us-ascii?Q?BrWQnn4SXSWwkT8GzYNQ97JgM/XK2AFQXMrsEcqz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d69549-65e7-482c-5107-08dd3fb5300d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 16:02:38.5464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mpUC2s0SxznwksvdLvZoFxSTuh0tXXxpFkDqXV0TLkqhSwhr6V8PVwrz0k8UdRkCWhhYiOZcKuK03Qgpl/W4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
Received-SPF: softfail client-ip=40.107.243.86; envelope-from=mochs@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Jan 2025 11:22:51 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MMIO region size required to support virtualized environments with
large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
(currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
new parameter, highmem-mmio-size, that specifies the MMIO size required
to support the VM configuration.

Example usage with 1TB MMIO region size:
	-machine virt,gic-version=3,highmem-mmio-size=1099511627776

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c50..36344554788a 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -138,6 +138,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set extended MMIO memory map size. Must be a power-of-2 and greater than
+  the default size.
+
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
   Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 49eb0355ef0c..43d47ffedd9a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2773,6 +2773,35 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
     vms->highmem_mmio = value;
 }
 
+static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
+
+    visit_type_size(v, name, &size, errp);
+}
+
+static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    uint64_t size;
+
+    if (!visit_type_size(v, name, &size, errp))
+        return;
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "highmem_mmio_size is not a power-of-2");
+        return;
+    }
+
+    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
+        error_setg(errp, "highmem_mmio_size is less than the default (%lu)",
+                   extended_memmap[VIRT_HIGH_PCIE_MMIO].size);
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
+}
 
 static bool virt_get_its(Object *obj, Error **errp)
 {
@@ -3446,6 +3475,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                                   virt_get_highmem_mmio_size,
+                                   virt_set_highmem_mmio_size,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-size",
+                                          "Set extended MMIO memory map size");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
-- 
2.46.0


