Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D3C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubjsC-00034w-5i; Tue, 15 Jul 2025 13:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubjNI-00029R-CV; Tue, 15 Jul 2025 13:23:29 -0400
Received: from mail-bn8nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61a]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubjNF-0007K2-Tv; Tue, 15 Jul 2025 13:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/EjgiPPG6eGeVkBdwGogemstQHcd98FAuknBB70PrVEKJDoSrBbDrIRq0sjIxzD1FCewAm1axxgdeBAzkeyDMM+EmHJgoz2upNGYNhrbvKdDdHvn48Ixqt4bOStrD1wcMuHZ0AFOjgqKx02XAr7TFAvXPpMim3crsWoPO6p5cvN8MTrov7N5W86JEBnFh3yNZGlMJG8SkX7eSZsT2mcDSpcoZ7PlTbkukFs1ytcTt9q3Pto9KHA8Mh8uMA02V01EyWvRV9hcdQvN5U4F/M/uU4gmGdN5wMBg2vQn3sutvnvPHR/Z5zPfleh/dMu41cjZnG68d1ysGaCHDUvoXkXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz/5p71SpYB+m3UT7BXVUZMZzdSTe+2CzL+PFgMcQrY=;
 b=hqYaa13d2ccGp5CpQyNE5DpZ1kWU7v6uqe/0YXKV1RS460MfBNqf92whcLVeDYtLLXyI4hyzCNfSUUG8Y2ixNQTUnmSBnJQcVnMdy3ROU0h4G5DHpU23bg9Q2OOQ2ypkNiTS//1u3UWeVQkvNjtO/Ru5/0dAGUNl9T31Kxf26GDAXMu83uNanl61CadaxqT/zCXFAvdJDIRA/WyQxLb7RcuKOXfugnakxHRQ767DBT+Ag1q8zhBKuOkCUGOOJzt+rvwcZSC4ZPVMnr1sZFjaeSPv9/D2TUus7OcvmIDFR5gbjW2Vtm/JAjqGsq+0x3nIjNW4O/HdYmCaDmnNjrq7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz/5p71SpYB+m3UT7BXVUZMZzdSTe+2CzL+PFgMcQrY=;
 b=MsYLfN3L1iEgmYLKxqWBlCHlG4fs59NKLywQC8FJHN4irX4QqN6bYdkZFU+MzeHAikwQyYgB9eVitbAsa5WE2OokIaHhVizKxWgSsCrFfSuOtjZstAJQHZDJ+uSql7sj3f3C3ZSQeshnpChCbSZzbt4RkC5alxwic3u+4o/0mHeiSehPeo2aJJkByoYZ8zf/PfSWjoY7jQ3ZtFtK7rFZbLHBcmdZJ+Nh45rxyUJrSSjy/65DWpJb2sItzw4yqxJvEKd4MLgoNjVujA2rbHRrFBRJyQjIe4gytmxG78qrzV1bV3NvvNSnuBzwiqeqWl5wMnjmF5sMmc0PVxffu+vtEQ==
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 17:23:17 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c1) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Tue,
 15 Jul 2025 17:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 17:23:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:23:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 10:23:00 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 10:22:58 -0700
Date: Tue, 15 Jul 2025 10:22:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation
 commands to hw
Message-ID: <aHaOcd5FKOjsWR/p@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
 <20250715114609.00004e4d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715114609.00004e4d@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7bfa0d-6674-4cbf-cf04-08ddc3c4492d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xEYHEyvhmR1Ie8xLHHSoufX+dre7RVvaeC2IdHXtfRugtS1JzletQL+Duy8y?=
 =?us-ascii?Q?6xaqWGxvK1qdRml8Le+d2Yh49WT1Y4Vv5TbBLNo8F2nrJZb3O3ksLK9p0U6K?=
 =?us-ascii?Q?8wPfvEirmFJnAeNWPP10JbYszYVhRG99ZcwQKwmdVBO1zHA6hMc8vqZ+QW9m?=
 =?us-ascii?Q?sQKLf2elLb1clac3RF+hwGJGzp8VrO9lxI2rH7ki0hhdXTARYXGQc6CXKyQr?=
 =?us-ascii?Q?hIJocuSPjUDVyB7tmwG2R29VfwQkm69WVP7EA94svcB4ZQjV2YcLBvpbzoFn?=
 =?us-ascii?Q?BJctNlfXe7qdGlcTeFL+fP7m5Hf4JNBvknyiF34Hs+0u8askiUxElnPlmSql?=
 =?us-ascii?Q?HKSDjNZKdNXaXv+t0VlMIpTBs/19NoPGA/9v5afrdIEVvRJKqSBC/KVRt1Fe?=
 =?us-ascii?Q?Z2s4iJ566bvkt4heZM3/Q0YJG29wp1s2BuGfLB6rwSESdD9CoEXheCxNixdG?=
 =?us-ascii?Q?DbmDv0AGBl4gu6IR/rmJANpoA/UhIP6hqikC25zGC6DTa6PT8xh4mlpZJrAb?=
 =?us-ascii?Q?/oFYMRvQN5IvFvsXW0yrhpXHlQfSabH1m1RQVs6asqATFUJLpmJffl1A+R/W?=
 =?us-ascii?Q?HCJhaRHy6Ajlk40ecUVOKWzNVP6IY1/FiPgXb8OmtIa0lFMlgGX8c3ZOn27W?=
 =?us-ascii?Q?6x4qkEiTCZv8DpHinL7U64Dx3lh5jpIPNOoXmAvqRk9XnAXAbzCWluJI8zcO?=
 =?us-ascii?Q?5JctuSQAqd2fE+rIx8j1bwptyFVFIrqFczOESJJOxYVSbPweA0MnBMXs5t7V?=
 =?us-ascii?Q?/8/1mnrnzIC+WpVUN8suyGH8tirJIYQLOi4h+jkWrUExGAgj49dLIklsTvJD?=
 =?us-ascii?Q?PfCyl8YxDuji1kb0SZdGyURMYevCh3osWxm6YljJ3xaSPuPuc2oxyuVKjeaF?=
 =?us-ascii?Q?qlLKcGvpNETT655s2AyFg/LeH1iOJ5HD6l9KNilizxRDLhbFz7DwzXcB+2X1?=
 =?us-ascii?Q?XP+s9N1cQtHOvEcpXF0Mygj0HjeEfrA+TCjFvz792WU+Oy9AnH+ApWafECEK?=
 =?us-ascii?Q?Fi2dvfXRBuRw9HJ+NYXJNqkG7JKDedAmXdxwrOysnfV8QA3/EEAqUNN6VO7i?=
 =?us-ascii?Q?5m7ToR5H8I5qthQ68koaECRCZh9A83tI9h+Qi3QlyC/uuD84HF7cnNdBYhmj?=
 =?us-ascii?Q?GMuit4AN8Ay9t1hS9FRXp6JJSmsahVEsdU7K2IR+pVLfvXUd382rZddkEtPZ?=
 =?us-ascii?Q?+uu/KDBztlQGQJGaGx2JJ/h0GgZxcOu1SoNIVT9q5Gha7jFWRj9ciMwEX/wq?=
 =?us-ascii?Q?Djt7GwM0Gua8CpxnkN4Q/BzVnHoRNytDG90YSz8tJs8VuaiREc7YSSPloxio?=
 =?us-ascii?Q?Awo7x+3pGublA76bRS1C5psazbJoVdEtB1nadZ79FOEBUVz/o/JAxFinhQWn?=
 =?us-ascii?Q?UQITTMWOO/mb3Tgs3q+Jlyg/yVBrsatkd+1GL2zgzFRt7wC6p5L22T9x5/4w?=
 =?us-ascii?Q?96XRo4rVFS40qyhHrLrHaTvdPF5QUJ0yDchn29/JZsIdeULI63h//C9pV6tt?=
 =?us-ascii?Q?y4xwNX2kUbJGk4iQUqYloSAfUg+My4esm2OF?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:23:16.3249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7bfa0d-6674-4cbf-cf04-08ddc3c4492d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
Received-SPF: permerror client-ip=2a01:111:f403:2418::61a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Tue, Jul 15, 2025 at 11:46:09AM +0100, Jonathan Cameron wrote:
> >      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> >      SMMUQueue *q = &s->cmdq;
> >      SMMUCommandType type = 0;
> > +    SMMUCommandBatch batch = {};
> > +    uint32_t ncmds;
> >  
> >      if (!smmuv3_cmdq_enabled(s)) {
> >          return 0;
> >      }
> > +
> > +    ncmds = smmuv3_q_ncmds(q);
> > +    batch.cmds = g_new0(Cmd, ncmds);
> > +    batch.cons = g_new0(uint32_t, ncmds);
> 
> Where is batch.ncmds set?  It is cleared but I'm missing it being set to anything.

smmuv3_accel_batch_cmd() internally sets that, every time it's
invoked to add a new command in the batch.

Shameer, let's add some comments explaining the batch function.

> > +
> 
> > +    qemu_mutex_lock(&s->mutex);
> > +    if (!cmd_error && batch.ncmds) {
> > +        if (!smmuv3_accel_issue_cmd_batch(bs, &batch)) {
> > +            if (batch.ncmds) {
> > +                q->cons = batch.cons[batch.ncmds - 1];
> > +            } else {
> > +                q->cons = batch.cons[0]; /* FIXME: Check */
> > +            }
> 
> Totally non obvious that a return of false from the issue call means
> illegal command type.  Maybe that will be obvious form comments
> requested in previous patch review.

That's a good point. Shameer, I think we need some fine-grinding
here, validating the return value from the ioctl, for which the
kernel will only return -EIO or -ETIMEOUT on failure, indicating
either an SMMU_CERROR_ILL or an SMMU_CERROR_ATC_INV_SYNC.
 
> > +            qemu_log_mask(LOG_GUEST_ERROR, "Illegal command type: %d\n",
> > +                          CMD_TYPE(&batch.cmds[batch.ncmds]));
> > +            cmd_error = SMMU_CERROR_ILL;

Thanks
Nicolin

