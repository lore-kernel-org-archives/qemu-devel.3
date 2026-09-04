Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA8CC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WKK-0006fL-CQ; Fri, 04 Sep 2026 11:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKH-0006Nm-OA; Fri, 04 Sep 2026 11:59:37 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WKF-0004ae-Vn; Fri, 04 Sep 2026 11:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OncW3dzbZ9LrL5muvdZtLV4v+GyhgpS4NDMWCNJ1Uql6enXNHczB+PMF3+/HRM8t/Wlu/sQ1sVTv808tQZ+JVR2lZthpiPEclGSnn5dVmomIBkBSa/Ktj3EFHoMbfiig6D22O6IevBp1LpXtq+bVH7go2Mx8kwbrc3tIN0Ro16qxBq5sF01laZJY2SLBNBvFq+QWZ2Ttm9iIvPjCCRKAYIeR2QRmJkwHTj8RUb48W3w5BR2GNOdfDlF7GS7wLCRHVHFQy4rMHfCHmhda78z8UpNFwjiU6qi2DB+Tx0LJZ6QD1tHocgftfaAZeGOe8qqyKwiOpU6kM3JOYUCmYOzdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L74/BAiN8g0gebSHaJCDeD2c4iPytAAN36kb8ou5anI=;
 b=qLukPC8+uBhYYrvt3dy0r1V4ePnQBA3YArThNO51jWJfeou3ymr4H/Q5cmtrZiR6DJwLIGn9Jk65Oly8uWlL0gtHSf1Bxd2Lq/GqNkHoMTm4J7sGcnYL4/0GdzLeqRR9xEY1AVwQp9cWkpZlrz69RSvTsGAqRKx5MD/3/AKataUVRTsyifR5WFqqUVklA6dJfahmHeiDC6IBLy5IFWwZ8NDnMdd1oStkpG8MhkX6drSwALsjFuXV0li9kOG4/ebvjPEAZeuxwVe7VsqwtzO9bNjHXkBz/UF6QaWqiDgAUSFgsteBaR+zTrgt50zDv2oQqtJCpYZbreEJBtgF3zI1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L74/BAiN8g0gebSHaJCDeD2c4iPytAAN36kb8ou5anI=;
 b=WINrym6dmJsZzXjPucGitwohFgs50yHCa2TGKVLccZym0Cbm//k7FfoPfC/CVccHrRVKXcGYcmxNEO9CtCmdXJWEzdda2vyaUqeH2+vAowVs5Bc2UkVcKz/1Pa+Abasphgr4eoSH+hZFKe5zQysXd1mlNVZLdUqgbCnYq0B5u0OPqAB9O8tnajNNNN1i75E50i4BgwyBiXuaRPlA1fcS/loU8jj7XB0HpEKLRuShZBSnT0Ud5HKYJt5ktd3TB+pz+v9XY9bOUqjOq8G4wfEmZfCSiua2YsC5Levkg0cd/S/JFKZyF7FngWTqtWOrTZuWGVLDeYBXqEpumyo2lPO1uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:59:13 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:59:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 21/24] docs/system/riscv: pfsoc: Document CLINT topology
 for direct Linux boot
Date: Fri,  4 Sep 2026 23:57:40 +0800
Message-ID: <20260904155758.3833179-22-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e94a4f5-9987-488a-e7f3-08df0a9d76d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: XuvREOyiZ15v4hlN86Vf6xNWZb4ji1camdr+MUMI5iqEAvuQxlll6VUEX4Oks629AxJ6c5qVHoTMNW7RiumnbRbRCmvGagoUD5mIzBhAr1OeJI1dvV5YyIUPmgiF9khacyk2TaLKL8YqtROyx+8+s38h52BIT1Gq2RaSz8Ku2y4lk7pFoMFgr5zdA2ItaW/3p9yDRkx4K0Lmw/89NaugDYYytRIQ4EKmn+MfSPnNB7vT+JL2zv+RK9rmIpdwUitWw2wXuHhBtZBQxmrbuzg2GIHMp1CjW9kn25ZUW3LcUm8x/kfsV7kX8305W0w2+TXX/0xDOHhw10Y0m6/IegzGOaH623KRPqAMxFo6DfIjjsDb1v6gbZzG9lZREv8u4n/95749J9UVkSryb81H7XFGyvbm5AuPUbZjcsalKzBnLDzl8dNaH0AoT41cLyJBIaGHbeBfD5tdnHWlC2T36+w0Ve0IUgVm8SZib5PFMSD9F6PJraUQvji2xvqv7fPyiYAI2E+q29SwVbrSSILpBFEg8vI9+DBbojrvn3iB9qDwn2Yrs3hA75LDxEPQyWuyn110rhaFZgo06lJJuVmomZyJCRekdsfzAdnvlsKPjaXEJJfaUOQjVDj+LIsK0chaWgSQpveuMVyC2F/TKlOevLOc14BirV/7CMxVSLo8FlSPdd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fxwk0so5OecLTGTf3I1euwQIPHu9j51RcBZOFcHa6u5QBzl7QB9um5QFEwDq?=
 =?us-ascii?Q?MNP4hyb00G47MZa7mHwctQvPu4d/Bhm0NAvRMPqJhBaEJft2yQ4GYiNcAVE3?=
 =?us-ascii?Q?iNUA1gJcrmqW6dwiYzd5cvCevWjOLpl9tqRpLt+UX+K0MuwBwCNh2gVTCPdB?=
 =?us-ascii?Q?NMCorKmZyyTVtzeN0R/5JmIANHWO4pzs3pUGkKpOogCVBK8KeKoxuj+Hqkeo?=
 =?us-ascii?Q?0HoU9HLyaaasIghJdJtDJ6LrYioTyXk4T4H8cMezqF7M6gkR/VBkqiJ42/dy?=
 =?us-ascii?Q?VWC7wcKYxItGTJytw7HhX7ka/GVmdt2r374zqTT3ol4FkU39+blIDUU+MS1I?=
 =?us-ascii?Q?bW6A5rBiHfEYhzBIN6wTcPdHO159KDJVS78kI0kkSXTenStMX5vTqM0VpcXD?=
 =?us-ascii?Q?u09ps90gxbE5HxXB1AjbxvcFEZbpkkAiJ6LY9Vnwg/9uoQY+o+1cxHQc2kDa?=
 =?us-ascii?Q?utnCyiRwfXyYEK54hOxr18aWdhUnZ0/Gj3sMf+/aHLpcckHhF/8Bkk7R7tSB?=
 =?us-ascii?Q?H8zcXat/zMbLfq8KuNqjHcavu+eHrgVNh8s0MSpGi5kp4p+XcCSR8EtnepCC?=
 =?us-ascii?Q?sJSxejfgH7Uw64scKQ8DirsVhzWwHxBFqxnvl9Sovti7n4bj4YkXcnmgjfb8?=
 =?us-ascii?Q?uAM5f866PK5J6mk4wr6JTQbg0Fzbh64gaX6LF7F6WOgWDqTjKJ9gpJ63UeTo?=
 =?us-ascii?Q?6avrdkffNT/5ZKR0FfVvMKQxNGvVQKCVWBLQ+/DIaW16wly6X/psgEbSQIks?=
 =?us-ascii?Q?lJeGZyIogkYqB/Ob9jkVJXqMn5hVq9a8pb7sN9F0rwzR2YbOdPE3SDGzQAlO?=
 =?us-ascii?Q?Vazw4sfNbhLix/u1eB73LxjR5mnMIUSKbuYNFk5pJNVcviN+O9rDZQpggprw?=
 =?us-ascii?Q?PbIrRQifB1DemI8YJjyOxvWQ/YTn3iSUDhBnKz4XpTWjyXZQA1dzRih2TeHb?=
 =?us-ascii?Q?9xUViCeMr4KvL4st3kPOjzR8ZIuStjNyKPPEbb5O9EyIQRma9bWgGrWZl7dG?=
 =?us-ascii?Q?IG6JqV+khso2R7NldnB0kt3hjOp6fuisXT+HNWzPnQh1tHno1F8VBXaJjztZ?=
 =?us-ascii?Q?gFXrNUOTw6ilvGshlgREqsfZXeEnurhEvRT+IJt9ugIbe8nrbiPqIqq4+GMu?=
 =?us-ascii?Q?vgYPTWMFgqfU4QP87DHUMerMY/23EYLqJROD55hmPmYTjvts2ShaOaUD4bzT?=
 =?us-ascii?Q?aI5fLcj6PgBnFPCM5ODv0H9QssAGPWcxXoMjwzjr+mnY5hkPxLbM91Kbmbp4?=
 =?us-ascii?Q?b8JQGS+cVX4dxwf+7886h8dzbQ37e7c3+2sJQpPRRBEWYEoWfL7pkzz2UgEf?=
 =?us-ascii?Q?Qo728Nfhr6hADI8Z+ZG45V7kQo4H2rRUrJ4ITw1IK4Drl9XXn6z5Lh7orj5u?=
 =?us-ascii?Q?uhwgvSH6iQIesvYZkuQ7bc0M4ZsWOjv0CiUFa5OvbYaahB8l6OOunerG4gMZ?=
 =?us-ascii?Q?5FaG6MsTyEkNvh2TgPWxt3Di0Is+DRD5Wcy2TwKiaIcHZXeqlHSduQ6RV3Dl?=
 =?us-ascii?Q?/lWe9lvxHPRYo+1YEDs56sUyVJo7xkRpraxqGqxhmTBwpiyls0M10/Z8iqHk?=
 =?us-ascii?Q?anWp8x0s09xsW1exmQg1B3DI/3oC5ZyzZaak8rlsQORDjes5Ot5lAr6Kliy3?=
 =?us-ascii?Q?iazxanQ9Sz/INTCgX/cRhqXHQ6Y4G4APhcevpLwI6v7OH+MX+QnXEWoPwiKC?=
 =?us-ascii?Q?x1otwHZi6tQeZRLGXvdHCvBgBXJ5ZnH2H/4ohP4FCwLJkbiw509kT65EUcPj?=
 =?us-ascii?Q?pljsuPmKsSUFC/4f9gUqhZ+vgudA0rA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e94a4f5-9987-488a-e7f3-08df0a9d76d6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:59:13.1096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AXd6UFYCfZQmG0FHI27ndVFug2MjXcS5WNfIlz0Cs5Wm+OtY2pOtQjH8658jonJK3hA0zgOpLH/KuVARqQCaJso4nNRr2KxbZg6ege5YiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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

The generic OpenSBI platform derives the CLINT first hart and register
slot count from interrupts-extended.  Some S-mode-only MPFS device trees
mask the E51 M-mode interrupt entries with 0xffffffff, which shifts the
MSIP and MTIMECMP slots when the same DTB is used for direct boot.

Document the complete five-hart CLINT node. Require interrupts 3 and 7
for hart 0 as well as the U54 harts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 docs/system/riscv/microchip-icicle-kit.rst | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index eeb4ff938c..af8e984df7 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -65,7 +65,28 @@ should meet the following requirements:
   option.
 
 * It should contain a node for the CLINT device with a compatible string
-  "riscv,clint0".
+  "riscv,clint0" or "sifive,clint0".  Its ``interrupts-extended`` property
+  must describe the M-mode software interrupt (3) and timer interrupt (7) for
+  every hart, including the E51 hart 0.
+
+For example, the five-hart Icicle Kit CLINT node can be described as:
+
+.. code-block:: none
+
+    clint: clint@2000000 {
+        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
+        reg = <0x0 0x2000000 0x0 0xc000>;
+        interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+                              <&cpu1_intc 3>, <&cpu1_intc 7>,
+                              <&cpu2_intc 3>, <&cpu2_intc 7>,
+                              <&cpu3_intc 3>, <&cpu3_intc 7>,
+                              <&cpu4_intc 3>, <&cpu4_intc 7>;
+    };
+
+Do not replace the hart 0 interrupt numbers with ``0xffffffff`` when the same
+DTB is used to initialize the generic OpenSBI platform.  OpenSBI derives the
+first hart and the number of CLINT register slots from these interrupt tuples;
+masking hart 0 would shift the per-hart MSIP and MTIMECMP register mappings.
 
 When ``-bios`` is not specified or set to ``default``, the OpenSBI
 ``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot an
-- 
2.53.0


