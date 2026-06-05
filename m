Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA7ECD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 00:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVIFx-0006Ow-5w; Thu, 04 Jun 2026 20:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFr-0006MZ-RJ; Thu, 04 Jun 2026 20:17:43 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wVIFp-0007yG-Lj; Thu, 04 Jun 2026 20:17:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy1ZNLOzYOifv5PyLY4K2jPV7/n/bYp5baV9Hc/fbkPqJWBDq2cuod7XpVs9Va9oPtlwV+fdZXLkJXwlnqbGmyzVumA0nZPQnV0OfoY2YWkxT2lJgG/ERGbEtTLiUbBoQTu8AMDiTf3mWIn7aTeshyBPjqI6W7AesAZQFv4pDeOT+a0Sr8+QAEOGXiUKIBifoBiX+dRK4yhLE013ed2nK4KWxq1zzHTLX9668IjrVUOx0AslCwe2m7+oRXKeq32HgLafvJHlNprRcPikFgYdV4Y5vlhipZn58tj/iWY0alVkmD0ikXRLCJKLpZWHGs0YgkEppz6oSj7Yopy3uH4C5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRVmxnYBXgPOAjXkDsSCWUZZr8b9h5z35F0mT/Z5zLk=;
 b=Bc+pwaeukzzMvvDQO69V/Ou5XsSFUB5SX+AKRlA1e3aeTzFem0x3S7FUCtNI+fQTc1YsctCV4iNew2w9ifDgZQWeJGj/nqkIv3lhd/ePRjxdn94AvEYdFIDrf4vNvpeoO8aFaS+etD/u3jvDSfEJET2I2r1j8MxZsESA+Lf63NXz4jVqodavFMXVxk/Oy/20Tg56OJKPvVT5AyYjMv+dUB82o0MzPX7lvowC2b65YXlGbafimhpAQD0T6iIPSFpSvX1a8JkSU4IajWpDKcUqp7OL7cT8kMHjZ4NY8U0syAhtjaknb3gcdZQZUDvPeHCbg4W6OpBPKhjqqsMBoPz33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRVmxnYBXgPOAjXkDsSCWUZZr8b9h5z35F0mT/Z5zLk=;
 b=n/qd1grQSQTvrXOqAwy5F5MUg2TQJMNt6tPEXqLa7eIEdzxi62cRXuQwRfr9s576A0duBClkBDg7Ux0+IPqrVYqLcWFR7YBDCShWSqzJt0KbwbxOnXBy7wx8KhNiwQZrwybPiDv2EFCco9gDGCFKnTYLrIAb0kde9GWf1YvV30ssdCWS8JtMfSySXfWekGWAkXM+YhmixJLjaETD7TNjdjpLVzKbC8bPdx9AMKYIylO2HpjjSw/9eHQ9/fy34UsH8wG5NN8ZGGGNQHVzGqmA2INfuKhm/DVIi8si3LZbqS5B+zfVWgEyqnQSkdUgD63LT8Tyr3+Ess+ogaDyF6d9zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 00:17:25 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 00:17:25 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 4/9] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Thu,  4 Jun 2026 17:17:07 -0700
Message-ID: <20260605001712.1823737-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::34) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6ea5ed-45f6-49c8-a965-08dec297d1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: zbzO6qyOFnXfUy26W6U+clN9KX+GIctOKdZS+ayOGFMZEOb0N1FARR4mzq3gLzbeI/BG6ueQZIcgeo5/Vgpg9OUq2anlVNJMYdtq6ouj/6yHyKMwr5Ji/chmmWtLrlJmzeW65kK69n6aOdBwYJ+CQuljpcgiICzkdLUdEMzakuSQsrZui9yIyHDMbgZgW33LFtXTnMneDal9XNOjsLoryVYKo7e4JUC+zYj5mu5oj2OYfp9lqmsMTyZiVfBhYgQmbVgRpnqPD5FrBxkq84bARHNPJzHkE6h9aBms/kg5L9OBwZC8FVBSgmLukYuthl5EhG9oiCEcaobEEE1PU1+G3YH+20nEWbTlvzv9vvZyLOKjAf5l05mIA8+zRrR6XyjLVN/Y5y6bi1/UUXx7BlVhMhLpgeZh0Zzhe6X2M4zXjp51WVO1imDfEzRN2teiTtT3v+XKDD0/i5c1g2mU2yffnu0LfD6T29CVkgMAaOYhJiQ4chf205bMetW8H62N7ty0UuZwzGe9wR8Nlga/fpT/IkeKZLq29WM+5erm0qp8nxUOxrHA2DNq4683yt437yGbq50eQF16jDIaK0DRUpTYm1v+gdwdIIykYbdkoMCMYEcCGoIp5tmwZjCGTFnGi3+8g0MTta8FRhmha29UOtDcBv1sgpzlFSAWUYdl2cpDUzefMId3BKKIzqqHWleFxfof
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSohRO27yzdpa5xTmLwOqyzcC9GD/Kziahv46QgqPN1uI0YeyPXrjsRCTRRq?=
 =?us-ascii?Q?Qf5b4WR4Hs20c8RF4St4i6IEzBdIw0SaP+ab6J7GFbCScUU/RbqkJ6EPKEOS?=
 =?us-ascii?Q?A/xiNnQJxiPVVzICbqJojcWGjSXunzLFwl3XjPH5lu18Dli35GG5CPHOgwHh?=
 =?us-ascii?Q?MCvkJM+Sjwfg63wQDzPPxpQLNTFkn/X+ULtnGJeJFxb+HTJ7s2pBJ+KcNWmG?=
 =?us-ascii?Q?Pcn+teyKw/Ng3JsrMZt+SnHoYH6OD/HSlGDqkdegKGW0+1eACwY0lpBT2Xcr?=
 =?us-ascii?Q?C2baWb7gEEh9P106+C068g6hvBoQ1mVWFtK9cyt0WJN+iut9SQg/tGSZAOwS?=
 =?us-ascii?Q?gpr/cTLctEH25oMvsLOWrhwc3En+MEDPKYLldtQs3s8H84sz7wAkA2zi35fd?=
 =?us-ascii?Q?2r4des9DQO2DNZyVFFIFKqjJgbgFPHfI9o885ok/PYMbhja335/U40nnJlzd?=
 =?us-ascii?Q?xhMY9YqeByqK5tZbL+5aoFgq4vpToN+J0MftpzFmKjpX6K/lD5XMyEJgIPos?=
 =?us-ascii?Q?hTpQMqTF7GnckC7rWtnISm4CSHOJNZeaqZJtc0+YXIFNPhG/Z+b8GwRmr9O3?=
 =?us-ascii?Q?/xPlYI0UWOfR037LHzlJKJOqAVHM1d/eA0lclKDk2ok8ddiaB8qntUhIp+8H?=
 =?us-ascii?Q?VwpmZ+99y+8DOfvnc2lWX/E2rfMDQn0caTGDiWJ0IO9Y5iZvK95VkPC8l1vX?=
 =?us-ascii?Q?MUe/tr2u+THPxaxy4OdKYT9xj6Sj7rrpNfRCbLhqHJJ0IaznaAqJfAfcSzeQ?=
 =?us-ascii?Q?5sUgH/+7n/H2aUP12zCoKzGNRsl7F223ABGQKCQbgCfOVM+ArddrY99jnsmX?=
 =?us-ascii?Q?RGL7D0vNLR0ga+JKqX0E9osZBtg5STu45U1H8KXYF98cltzCsos9Dtv8b9QQ?=
 =?us-ascii?Q?UWBBApW13cr0zXo9Bu1O4GrG/5DubU/zMd03PYSeke6E/aNfF0P/HJoQwPip?=
 =?us-ascii?Q?OKisTFZi0rARP3hsDFwlKYSch/gdZ+lBhDGM6SFBkHWJSKzJinjhrbagtfiG?=
 =?us-ascii?Q?jmlbzFTnIITtX5gE8YSRDEwNmeikln3YOvs6PBK72xE4smfknq87WkXpP4WF?=
 =?us-ascii?Q?KMybbppTOShiXLKEFQQtScgq9aWbLAop9jQCnuiZdK5A7Pf+M2Lkmp/nq2lq?=
 =?us-ascii?Q?uxGkt4gQr1htSIFkBmUMLQk8sdqNM1P6PxoWvkp1ILLSM4roiC6zJHqpv+Vd?=
 =?us-ascii?Q?MA1H3a23YStw+f/7Ht2JmWmoa9b5lbEs8SapMR2H0AC1KgfBMWfbp4ASbPfw?=
 =?us-ascii?Q?wF8IHnRqFl9sDNvmbtjB/YGMro5XogKusM88BFDNH39bedNpGvq6qjTgX0iA?=
 =?us-ascii?Q?9v+OtGU21rwW8J8HiIfPa5gy3sOFOdMY5zVZ+0d3gfyYi6J0fzlTi3awnt3F?=
 =?us-ascii?Q?vmkdLNVVtARlfo09Mg9q8r47ZGFDfoBD2yrq1Ehv1EwpPm+ignRAhRhhBcd6?=
 =?us-ascii?Q?F6Dt5QgvU4RV8dsYU6J5kBR2NMOoMFZ4fi3JXYKjMQ0xc6o0JirnUPtKCAJ4?=
 =?us-ascii?Q?sXpcuuY25WWy+oa3qEsoR1/ZjpnnTISU5g16tMKP2j9nWxOAiZTXpHTJ4nsX?=
 =?us-ascii?Q?/rmXk9A1P2hgvrSmAUL3Qplpow5bSLb+fy4jUFslFMn7IHhs7Xky6z2Pbnz1?=
 =?us-ascii?Q?kxDLHaaYdk5NVnKdTHPynzbPyX9UqTY8jP+e3ABb7BCZCFDMtgF6OSBptxbb?=
 =?us-ascii?Q?zeKbvdnG3dCJRLVbfMcqECUT3gT4Y9WMlUcAnpz5ki5W0A+GPKDmlES5zBKJ?=
 =?us-ascii?Q?tp2sK33n8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6ea5ed-45f6-49c8-a965-08dec297d1ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:17:24.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXjBEsoEr3RabmIpLfIJ6oOiQSDhJDNN4SdtEr9ZoOvwcaDGl/IPaq213/oegrWSFCbbd0duhUQyjtB/Hz/aAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Allow accelerated SMMUv3 Address Translation Services support property
to be derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  9 +++++++++
 hw/arm/smmuv3.c       | 11 ++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fa0a97cece..4c2acbbedf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -53,6 +53,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
         return;
     }
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
+                               FIELD_EX32(info->idr[0], IDR0, ATS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -961,6 +966,10 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
+
     if (s->s_accel->auto_mode) {
         s->machine_done.notify = smmuv3_accel_machine_done;
         qemu_add_machine_init_done_notifier(&s->machine_done);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6b5035e11f..436155d883 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ats == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ats auto mode is not supported");
-        return false;
-    }
     if (s->ril == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ril auto mode is not supported");
         return false;
@@ -2172,9 +2168,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
     object_class_property_set_description(klass, "ats",
-        "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this. ats=auto is not "
-        "supported.");
+        "Enable/disable ATS support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to off. "
+        "Please ensure host platform supports ATS before setting it "
+        "to on.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-- 
2.43.0


