Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC4CCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6U-0006gB-16; Mon, 08 Jun 2026 13:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6S-0006eZ-0K; Mon, 08 Jun 2026 13:49:36 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6Q-0007Bn-HM; Mon, 08 Jun 2026 13:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZchEFqgGMYZKA/qLEREUqLOzMNhIe60QwRdqCRU0tW3z/qP5YaDLxa70vweTFFJld2IvqJYFsyPvvteLCWnp65kPPBq7Rn2eO5Vn2rkimcprREGDZk1MLiq8omiYEDicwZ+GwriIhZmQwTMFPDbxakAWd1CG9J9Hz4brVcWImsKSa0EMH6yRTU6oF0nPXrSYvNJO2/ueThYcHFt3RjE7GxY+bhqL4YJN9PVPtCq5G5baxW3Kj49TmbWOxdXs/MuOBApV5ol2hIlUGj2qypKp+3sU6ygt0tEFf8qoIITHSBWmXUWZ0ii2FNZuku+++zRaat9ZxARKUvUsuRCBXxWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRVmxnYBXgPOAjXkDsSCWUZZr8b9h5z35F0mT/Z5zLk=;
 b=yA0KvloLS1devR6IugGFjwIz6qrcQp8qnkoXz02//3uS8euDM1IJ4uCoAGzXcAhD537MNFw+1l6cLuICDnxwKgxdEomWYCcVQxP5rRUSaTvRXSO1QZRDXNn11y/ama3p6Npzd1jFkwx3c53Ajak0cZmPMDeWWqF5BH16bh3VbTlHuo4jdkemf99I+KvRHTMfAAex11dDeMlpNaBa4wprn61LkiOo3aSh8YzJbi54hWYhqFm8RLIkgXH/JBvOA+W2uiMRlptmverKXKzEUg8OT72GyGcQCMEXTWsNmMXygA3cnWYVc6xTRVfdDVz+FY0yzqCpBbo5xbkn7IT6TkMmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRVmxnYBXgPOAjXkDsSCWUZZr8b9h5z35F0mT/Z5zLk=;
 b=pf1nuOPJaykM6hEhes69MhbXYQ7g5W+1pVUtrd2MmRUMyPEipxLc2kxZLpLftChi26im+0FC1mU5PUAR49h4uZDpDn2RtTP2oiDZVqVU18QlwFU54SQTIGWVy/6hU1oZ9hg+bQeaqlKhxxCTuXH0kdn2asmEUcEYuNpAfn/GLhX5qjw64mYy5dK5+rQDyQUcmXkTmKv0b8hTA0XFSJ9wk9VBpy4LF3hDhZmzgeGTihesY3qxy402Ic+VG4eWoldzeHbVggNOlXukTH1+kd0593UeOi/y5zuRg8UQM9UW9lViLUGcEfue8fsrwCbyGJxHcuSTgVyg/F1f4RxxVnrZ4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:23 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:23 +0000
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
Subject: [PATCH v6 4/9] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Mon,  8 Jun 2026 10:48:55 -0700
Message-ID: <20260608174900.2227340-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 07461b86-8195-4a28-5242-08dec5864666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 43fNJ/Mzn20m8MmtjFggjyK6tI8C1l7wFAdZsDA7CxpzHcoJzXRdF/E1z0mA5T/lOvWdvEz99uNsn4778LRu29C+S/jQb/TfOc0NgZ1Q26R7JprtCdzmwwhUmOPImRGeTw+emCi/NiD7UJBE90XTL9bw1v1g0Slukk3ex+ezMfd+DRWjYg8ChHLR0wak36+j9kFl/Jf/EoDbeVVmYEggZkTmA/Zws05Z3pfnggi2Xvsf9JFwjkoQgE+LaUzHyq8BGF/EgGvcrN026ZnLhFqfNRiK7TKCMfxRFP8BayNo5LJZEkVCmZIDM2XVpZ6Mj902+0zQFM7LWPqFwlfv7X4xUnB5Y0N3PQslpDyGWGrpNu7Jh0NJAg+vQLxUUYkTkLXuxS3Xs+i2g1cDg7qdh9hQqAdtZ8uFRV4W9sIgCPEoc7IhcTslYNzXapKyNt6Er/+N4a6/OItZqcjru6fSShye+TJn8LCLwHPIEoO6cuodihzCzNqUh/R+paEhzI1llzuG4OTpkLGY4b70//Cw+SmjxTBH3zgcJJW16fKxXbtx2OqrWRGly1vw0/Fd7S8/76YA7Ey92wuFvZmh4ELYOV6ayc1BHMZKAAIL9EAuXV+GXYx6IPxqJL0M/KF6AkWK1J+I1y10QXpvkoWRyFE5gitqNUHQbSI1umiE5zyfxhaNWEirW6qT+6K5fq+B/8ayLR8R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I65yArpKi2gTPGTNre0s5L7pK17uD7YexGgBNxYQRGxG2/9sFogtgjglztsk?=
 =?us-ascii?Q?9F5tprbI8rVhQkjTVZaiaOc3Vu3bcL3uBt/E9W/ByPBpe0TFID7iBX7JKHf1?=
 =?us-ascii?Q?Nyku7Ea8UcmlpJS3ZX6u3jmPC3QeT6AIak2JSynzrqvaMt0SibLMXitOLTCJ?=
 =?us-ascii?Q?pyC0NSIpASaFMYWQ4QgByAQ1x1FLi1GPfTBSpbcuSNTJteJo407W7rFhGkTo?=
 =?us-ascii?Q?AUeniG3XGLQ1Gvt6LMeIAVOO8bmTmTW4jXV+UKi4FdFKGDekAGqsV78pJHV1?=
 =?us-ascii?Q?RS2ubwOdzS0OOFTaePGTmVJDWQr1Cf4zbqe92hr5r+eIXxsXne/FDNnoJVnm?=
 =?us-ascii?Q?SMZld+pRgx7KanB19az54iMk1iHu1QdFc4dpFTDHzIlU+/XGI9PA1ZNn+czh?=
 =?us-ascii?Q?mnix6WyQp2yDHilZ4XptfbdXx3Bs+1rl4u7aYZdXqE+WeRURRuMfSg1yb4fJ?=
 =?us-ascii?Q?rlBZ/TzLxu9AczYaJiC35sxkJFLHurfSeokH8kV+8ZfJFu6z6r+vIt8oCVnf?=
 =?us-ascii?Q?m8pItIhNXir5oW9JY2AGDlHG5vh53XOkgS6bY9qEgyXfxIt1x4W1hRt9xFmg?=
 =?us-ascii?Q?lpYzncwiBez1piJl2B+qBki879ojWyCd5t4p1tWn/hyK6DXklGvGY3JcTY+i?=
 =?us-ascii?Q?k6WnUNxY1tz/drx93m6hhem53NB+6hRuAz8K6Eq78Mvf8IX0LmHBcsGE+ogN?=
 =?us-ascii?Q?W9xIC4JPBlYYNDFkglvkEqz4gnbT1Cz1bNyzDYLh43PkhQNNO6nIZ6ceHxC5?=
 =?us-ascii?Q?1T3UUanlhAvhz5n1N5mTFv1h5VrFm6Uw5J1SK2opYOpMhWfUwS6a9S+9pYSe?=
 =?us-ascii?Q?k0sX9ic0quX9+WD1xw6GFZTgITCYVL02+rNXZDbn0d8VO7FDoPCaL4mgHhzY?=
 =?us-ascii?Q?cTAcKqAiPIR4/FApoTSK81FGyedAYPToNnJ3r8FNn0I5Yu2Onqs2CMrAsvQb?=
 =?us-ascii?Q?7QwL35nmW2V0jxUNo2YSTeaG3UXTJj/C7nn3MwRfNN8AiBKSXXIEyfu6AQLm?=
 =?us-ascii?Q?qInLKRzho+GWs2ZcDQqsytSfTWvPREXcOFDnbHjCzLxXrbbtweVRijjZZn1B?=
 =?us-ascii?Q?OmDiW6UX2hpz8s3zuSdzW5yOxoWLRankMLb8E1N1lq98BDMo3MukHwftJMNB?=
 =?us-ascii?Q?VyC/LuoUZ5Gu+mc+/mEIsa2xGoV55fj9vQI/aXa/it5JOcLc8JcUX/kjLHuH?=
 =?us-ascii?Q?PmvoCasCtxgxKdAJGxsCkDSAeOjj9hYqqOmmdGHYw4O0V62opLd2Ev4Xmmd3?=
 =?us-ascii?Q?myTnnQmHv9Cwz1qviyaChaH/iKWkPgkhDE6IsjNhh8zmokH3kTZkit9qduTe?=
 =?us-ascii?Q?na1Okn00iOAq9Yu4zOeqYZUOKERRaEL7mDgIWPLtHtRwuOgGdUovimZAfE09?=
 =?us-ascii?Q?FtOoDA8FdqLnoDeJMLlvtYN4zTn96PW9Y0AsnnS9P+Yu+IhX+Q4qDMUoxFiU?=
 =?us-ascii?Q?d0eNd/GXcoug7zdAEpM4+6qOq75W9M079kqdqTkI//gXHxWdrObKctJTD3WJ?=
 =?us-ascii?Q?esUysHWdsS4EyPDLXzSCwgQGtVFixnxQOSgAe6Tnw6BqsTzQH5Ra3soYuTfa?=
 =?us-ascii?Q?XmG+b1Cc9vls8malF259e/TfdNpK+YUML/C8OY+v9PqPAdXT21Pxw0UJrf4w?=
 =?us-ascii?Q?kOG7mylU2FwgV2aj0T2J0yO/LSrGK4hKMGh+ejDwhu2eqXif5XlgOZXOzmuy?=
 =?us-ascii?Q?uwNyDVd9TPBHGvlP5I2pDp85PiDs+u93c9qtZJgOPOzUHa73prxQnKo+nwrL?=
 =?us-ascii?Q?+M8BS8OpfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07461b86-8195-4a28-5242-08dec5864666
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:23.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8Jdhx9oNhQkgJhWOEYYezS/dLWBsp7h+lmA5i8Psgj2bfYTMTnmamXrSOAVsGLKlH2Ag2APjB7kwri3upxfnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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


