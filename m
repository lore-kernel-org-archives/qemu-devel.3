Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B12C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWFu-0005W7-TA; Wed, 26 Mar 2025 15:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWF0-0005OA-17; Wed, 26 Mar 2025 15:16:51 -0400
Received: from mail-dm6nam12on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62f]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWEw-0001kp-PE; Wed, 26 Mar 2025 15:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVg1+t04L5WgXdy9D/fZJNjzbDAPk/AOj7jFePWfDunEZgDzx8VAGIbockMZN0Ef7Hn2e+Tkd6jw7kIXCGMbCzIcQpH50eT2xk5PEG0Dh7DI44CJoch7ZC8XYX2fV9xC15HFemzlKpQ2wN2GZ4t78SAS+ZYuh7oyS5NdlCWaY3ajxkoxlyFyGhEoo/zR78gPblybAoTwtHlgxwb1vE4xvn0lZYJTOnwZfYpXoVK5ry9eZTIiAldkAaOW92AoZyMybwkb8Vhw+JxsFsGuZ5Hz3MbtkDSdAS0gO7mrhyTPNVR7o8p3HbGzvH6lS2HclbD9D3c2XFKt4gEs7BgngQ7jTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dejQibcDu2rTva9DEEgjd3Wccry2XHm8IPxwC7t8B3c=;
 b=NdhPQOh27J5orms3Rxyr2MwfrI3p+JwK9xffmqfaBGUdtZAdt6biMLJpEb+kVWOCCphThYx8NMTAk4126EFdkyoNa/43HAetUF+3eGsBsK3fgmxjuRZYq973DKf8LbtY2KcTLocK/KNbRnH+AboDygBrhty21MfuyLctVQMLYScKRvWTWlhiPZx0OpHsulnq4SzsdG5XcigpTdpZHG4UDyXZn1tMqB/t5JLDv0GMIfSFOAdqWporFZuoDvlwgACzD0d+MCkFPCy02p00YZO/emkGz6vWdVg8JRyLVbXERq+EfEqfYA5HDhjwseW1Vl/G2ya4Dms3mEETEiEnKlaRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dejQibcDu2rTva9DEEgjd3Wccry2XHm8IPxwC7t8B3c=;
 b=TWKJ2ttSbmvmFRC36SLN37PtJdv124wSMZt0l0W9VKxr4HGsVL8+dpCuL7NA2ji1SjfXj5K6fus/cwIBf3yldZAGr0v9flFJ/8pdZXC5yqXmBwfyhNDYoGILk9L8CZ7Z4kBnpO3IKaoqaEBTCaEf1n1aPXRfozbvrjGH1Fv60ZL7253b0zQNnyUtwAm2xCH1no1ZBqptkDh+9M48L42mRzMTV3KhX0+4mi/zVhx3iwZ00KuJjewFc25nMmzuV9vSmN6K9XfKRr9A0iNuAlAR6UDHRE+7NG+n1SG88NEVabR2VifjrcrbAvZVRppJvlf80W48xTy7iKFGxBm0c1syug==
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 19:16:30 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::34) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:16:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Mar
 2025 12:16:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Mar
 2025 12:16:14 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Mar 2025 12:16:11 -0700
Date: Wed, 26 Mar 2025 12:16:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Message-ID: <Z+RSeDAuUFtryi4E@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
 <e23b4803-02d1-4850-8b6e-ad398a66a31c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e23b4803-02d1-4850-8b6e-ad398a66a31c@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 591efe52-edb7-423b-7e04-08dd6c9ab688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qSl07rGeBk3zxwZEOgmHWAAqE5yOewwf95Wv8xMCPkQZV6OnGviY6MgD0p8e?=
 =?us-ascii?Q?gVZ8+WrgZvvbZij3CqTXoBP9LDPYiFpcq3o0ur8AgTExcD85Yt3yuVmSsUOF?=
 =?us-ascii?Q?mvCRMEjc/kabjzVkm7Yif+mhLeAAqVr2vAIuHj7s9v5UaCXZ0gTZNk2/H8NR?=
 =?us-ascii?Q?NpGK+tOQYWXkogHVpO7AfT2N6Mc5xxo5wmp4aGfqkUz5CmX87YVU19MPmdFt?=
 =?us-ascii?Q?endJhgucrw9WGw9v6bcifgkA2bAK6lallxciQocRY3KYnMk2rpCumpDSgd7y?=
 =?us-ascii?Q?7DCo7tZ4lzTUuuE8jRILiLGGQhB0JbOXDr4+iUqSOtZlYJMLkqqAFEPqkLdy?=
 =?us-ascii?Q?tezmyOiB9pol0zZUsbTEACQ8OpJY0eJ70xwWdCce4TCPINi7qJhUY1npod4x?=
 =?us-ascii?Q?jGCg/xiFS0x+HrgCFqkosd1tB3lNdNx5uYDwzr6k7XVtwgErkstNo/McOCHB?=
 =?us-ascii?Q?oFvEhal5yC8dbO8LLCHzphKFNwXrGPtzqaHxqP0gngyEXbt/848qqxxIyuSt?=
 =?us-ascii?Q?SgGyqVXLra/bPN6U1ZpXR84Uu2zr3/R7Wdk4PdYsQ1oHqkyQctU47FJGzYWC?=
 =?us-ascii?Q?8I8I18tVsB2/Huyu2Ib4nYAjIHIMn8b6Q3kENc8cVlPFPp2QvYu8zCmg6+ds?=
 =?us-ascii?Q?NblJWfJ+7UPzzsXWu8+zIX/GlaEEjbw/q3lt/NgWiRRRlqjf53SOYw59vUn5?=
 =?us-ascii?Q?g3cv9X0I9wUPqt2aXXoWBEiOKRQwmi0A0W5IqNwc6wxNb+j40Q5RSIXEN61c?=
 =?us-ascii?Q?5fvvGjbWLfn4s9KH+xepej/ikuwE85CvTg5naF2MwC5VI+tzDQAnSd0qAYwF?=
 =?us-ascii?Q?Df1USr7eJMU4khQd7hfg7mJPME9B1i6lnn9PpJrqHZSept6RKHbwsvjyNQRd?=
 =?us-ascii?Q?TdzZdRa+9wNpw76zTmnUItuhbxvNFKrTUYakOkBmB5WHvq3GyETSVJ0sqa/m?=
 =?us-ascii?Q?2vfZw2x+4vc41pJbXElpRE+p9pW06xN019khiRF2LC3amRYP4QVk2IyqVNHB?=
 =?us-ascii?Q?JlDhiPar45MUhmnLaynIhlkh4F2b1RfecKeZtm6UId3kzq00iYWh4A4aSbmL?=
 =?us-ascii?Q?Q54FMG7Ioa5I1aDOxJjg2KE1h1wX3ETnPfGdriwBOWFoBNShlNK9Vf0+2tt0?=
 =?us-ascii?Q?Gjt/ENagtf27ICupkdq3xs0jHv2VZgo9hiZSHKAgpGJSp1kieHNAl8x1puKH?=
 =?us-ascii?Q?WRZC19J6D8/pEotWMvkQl7ltoDIvjCX1bfScSNbHA+xhERoqcbNsPp/ukI5N?=
 =?us-ascii?Q?ntxK2TQKgEnsI8ma2x3d9IqQtzqLvLr1rI9Jzf/O6MJYXAI0a0I0YnA/3vOJ?=
 =?us-ascii?Q?OTMP+NQm5cdRLYz7q+WtWnV2ftp+XLy3ITvOmjsB5VXtEYlQlXk3TBsRbKcA?=
 =?us-ascii?Q?AlK49ORQzoc6ddVp+dnrfU390FzhnUdg7ixJ6TM5oYeZuw7Kjfi6BW3t8OC9?=
 =?us-ascii?Q?JW/nNiE+DasI5uJcGQAEX0s0kfsXYDM1/kdGTZSj5BFb/+6r7MdBgT6IvzQp?=
 =?us-ascii?Q?YIMuxbnyhtKomq0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:16:29.7609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 591efe52-edb7-423b-7e04-08dd6c9ab688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
Received-SPF: permerror client-ip=2a01:111:f403:2417::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Wed, Mar 26, 2025 at 02:38:04PM +0100, Eric Auger wrote:
> > +/* Update batch->ncmds to the number of execute cmds */
> > +int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch)
> > +{
> > +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(bs);
> > +    uint32_t total = batch->ncmds;
> > +    IOMMUFDViommu *viommu_core;
> > +    int ret;
> > +
> > +    if (!bs->accel) {
> > +        return 0;
> > +    }
> > +
> > +    if (!s_accel->viommu) {
> > +        return 0;
> > +    }
> > +    viommu_core = &s_accel->viommu->core;
> > +    ret = iommufd_backend_invalidate_cache(viommu_core->iommufd,
> > +                                           viommu_core->viommu_id,
> > +                                           IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> > +                                           sizeof(Cmd), &batch->ncmds,
> > +                                           batch->cmds);
> > +    if (total != batch->ncmds) {
> > +        error_report("%s failed: ret=%d, total=%d, done=%d",
> > +                      __func__, ret, total, batch->ncmds);
> some commands may have been executed (batch->ncmds !=0). Is the
> batch_cmds array updated accordingly? In the kernel doc I don't see any
> mention of that.

The uAPI kdoc of ioctl(IOMMU_HWPT_INVALIDATE) mentions:
 * @entry_num: Input the number of cache invalidation requests in the array.
 *             Output the number of requests successfully handled by kernel.

> Do you need to report a cmd_error as we do for some
> other cmds?

Yes, we do. And we did (in this patch)? cons would be updated:
+    if (batch->ncmds && (dev_cache != batch->dev_cache)) {
+        ret = smmuv3_accel_issue_cmd_batch(bs, batch);
+        if (ret) {
+            *cons = batch->cons[batch->ncmds];
+            return ret;
+        }
+    }

> > +        return ret;
> > +    }
> > +
> > +    batch->ncmds = 0;
> > +    batch->dev_cache = false;
> > +    return ret;
> > +}
> > +
> > +int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
> I was confused by the name. The helper adds a single Cmd to the batch,
> right? so batch_cmd would better suited.

Yea, it could be "smmuv3_accel_batch_cmd".

> > +                            SMMUCommandBatch *batch, Cmd *cmd,
> > +                            uint32_t *cons, bool dev_cache)
> > +{
> > +    int ret;
> > +
> > +    if (!bs->accel) {
> > +        return 0;
> > +    }
> > +
> > +    if (sdev) {
> > +        SMMUv3AccelDevice *accel_dev;
> > +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> > +        if (!accel_dev->s1_hwpt) {

> can it happen? in the positive can you add some comment to describe in
> which condition?

I recall this is for device cache specifically (i.e. CGFI_CD[_ALL]
and ATC_INV) that I had in smmuv3_cmdq_consume(). Perhaps it gets
here because Shameer separated the accel code from the non-accel
smmuv3 file.

This condition is to check if the device is attached to an accel
HWPT, particularly to exclude commands being issued for emulated
devices. Surely, if a device isn't attached to an accel stage-1
HWPT any more, we probably shouldn't forward the commands to the
kernel? Though I start to suspect that we might need a lock for
accel_dev->s1_hwpt?

> > +/**
> > + * SMMUCommandBatch - batch of invalidation commands for smmuv3-accel
> > + * @cmds: Pointer to list of commands
> > + * @cons: Pointer to list of CONS corresponding to the commands
> > + * @ncmds: Total ncmds in the batch

> number of commands

OK.

> > + * @dev_cache: Issue to a device cache

> indicate whether the invalidation command batch targets device cache?

Maybe "invalidation command batch targeting device cache or TLB".

Thanks
Nicolin

