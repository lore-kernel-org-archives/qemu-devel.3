Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E42EF99E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 23:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr2bL-0000Xz-C6; Fri, 13 Feb 2026 18:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr2bJ-0000XN-3e; Fri, 13 Feb 2026 18:29:29 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vr2bH-00016C-Fr; Fri, 13 Feb 2026 18:29:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgCByEBI+4oSFcxEbFvH/S+z0D2o4Maui3864rJFcE0XTiZtCrpNp7zbbRRJuCPAxCNCO0FqA5cCN48kMM56X6gvZ2RYC81yKJ72Ddca6AxpTAJiWXz7AorrRfj/lWq1bjytneexjmdbTcBvBvJOVlPENeATnfOw2X+rizQFBSP+7vVr2r0f9ihRfoL+Vw1mZo1vMdVabqSgwGrI42zUtIxZP0JDbIVHV9vcpZu8uxCegkfEMrs9S7EoEuFWUghe3OLs3/OznVRpskMp5QMu16I5Ki4wMvsugeDti2ZnxxH5Bjrf8Bj6xm391G37e8XbtPTZwdwBq+AhZ+Fkfrk/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACRFkcxnWr5X9duGEW3nkUG7FiaSOwDfipUNfShnjkU=;
 b=ta6QlUqzpMmHsYjtbeFKXES0y+xfLAQ947TGKHL48+Hc79sdgTqH49F+57xwvonF0qz7NIq4/WHy/m5AHGzBxTKnZD17LibqhTM3ddDY53LuzmIUvVZ/DtuB94Vc3MN0ZrrPOk+cE5g3JLsumI+EPxjLySxDwZGmnCOBA6dDlX5WTBkcDEqwvMATfKi4SIUeI9dJiCl1GCm9I/j7mfkhOwPRqC92eceJOOGfxPY4ymMwFvMCG1uAgDC82zX67k5e8uRB+U8RApjptbY5s7kOtCgsOhYFA//r9SS+1BlN5pbfN3Cs9DHKBxBkiZUfA5sAmwhOxQQeMPDMIdQaaGAm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACRFkcxnWr5X9duGEW3nkUG7FiaSOwDfipUNfShnjkU=;
 b=GQBeUBAfUIwMOz7aUVuIu53U8mMJXSD71Ao/bxN10BMU5jTBubcYcOiS5VtNeN/So23ZdYEBzpjAg76HlSxlMZaDsaSvYdcPTuZ6D7UkQZCPoN3Qvpe0msWwV9VRmbgQoOxG1tr0f5eXg+qCo96Jeb6hNMTLfMOL8yFdAPNbXWqKm+gdEx7gyZDcw0792Cu2gXBaVcbD/cOVITUBMCus4UoUkKzswK684BJHNfeX5Tqbgc7rvY1cEHhjSNRX9X+Vn/oe98yOD+3v8tYOOB2SHEDZiRV6jcaVA4U2PS1PNaOrO3UbvP1wlRLlMZomPslCHEw4P4fTO+XRjQJe2ZfhSw==
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 23:29:20 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::54) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.9 via Frontend Transport; Fri,
 13 Feb 2026 23:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 23:29:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 15:29:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Feb 2026 15:29:13 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 15:29:12 -0800
Date: Fri, 13 Feb 2026 15:29:11 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 18/24] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Message-ID: <aY+zx++9jISoKBiR@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-19-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260206144823.80655-19-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c73b686-a4f7-4a06-1cea-08de6b57b6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Czq2+9oNyGKOPP7hrKGp2JjNJ5Mfh8rfy9J162kpw1r0aCX/w8VsTcM9hSdW?=
 =?us-ascii?Q?/XJRZoa8po/KRbSlFEpHbi7Fgjjf4TSkeuoKwVGjxuIELSlfc3o0Ofcyy3ZL?=
 =?us-ascii?Q?ZJh6fyEhWslnm4dgek0hNd3mUySA158tk3VJUNhgvPe3lzJH2k+Ik5fBv8NT?=
 =?us-ascii?Q?TpVBUIOSjbhZmslUemNPjKUMnxYncWNdDG+NVCHZODjOuK7KexTevTcaQYNn?=
 =?us-ascii?Q?bXuCPBmrQO6ErFRtqzbEhYWbOTzA68YlWZzooixyquGPwvkuzThggG+F61l+?=
 =?us-ascii?Q?uDfM1F5AWHJWoJMDChoF6ZU3yVRDmbSJYvdawJTkJhEz+V0oablFbnfn4po+?=
 =?us-ascii?Q?Lswse47P/ImLjVRhPZDVTbJG49Qjx+g96IC30Gl/l+lgCHpuSdzDp4j86KQb?=
 =?us-ascii?Q?H2PV9SnI64slX73WZZt6dAErTR8oMsFShcryiGCGentFIfgEqAc+aGB/DqZG?=
 =?us-ascii?Q?zhrEW+C/IaodBQxc0iY+0KUi1S9td/WaLvyJCGsyt8CibyY3EO0YQIvqGLqa?=
 =?us-ascii?Q?bh9Ri9fbXy6zB5CnlV5QZGUtrTAd0hD5+KLPkwZSr6HKo9RqJZuPuv3abPL1?=
 =?us-ascii?Q?0q604UlFpXepBblSn3Gw6RX2Uaq2QoLiesMtEvOkJI1OsSsIyGPcDtD6MfXC?=
 =?us-ascii?Q?neKWhFtkzwMdFONVLfxLlBDlSldtEEBuq/4LlyGO0mAXr8+Jb5UsiszaEhPy?=
 =?us-ascii?Q?Hw86uQ2nt+devIMktQCtFypkRSm6ddk4pg2yp9ByvJiG5XXw1dDBB5W5LAyP?=
 =?us-ascii?Q?3qrM+eJqcyNPPA/Z+eTN+1llbSbEpXqKXb6w5X45qIiDbW4jpdSgrtgmyRrM?=
 =?us-ascii?Q?tYEn7ooijZchVWgKbkkI13XvrMtoq+YrKZxIlj9NUUjjn76qxc9Julja1P3k?=
 =?us-ascii?Q?CFWb6jFEVG/6GlBJ19iRrnM7luw/1HzNTh9aX7To5NpqOU/O71T4r6T6AyeX?=
 =?us-ascii?Q?xc0f/T9f9FlFB6kkDrqISgD5PT52fbR/fW8ujr2BDbyMdUzVVLLry0lR6sM5?=
 =?us-ascii?Q?VwzRcX23U4YYW9CNwYUVRQa8Tq3E0pxFeGmRZYvWPeo0kK9xzkYsfMuO9LUK?=
 =?us-ascii?Q?4BRO6/AKH4yhdmLQa0Ki2XYEcFIXT6PkUNkgWdnGHsaznq34fVh6muOEkSqK?=
 =?us-ascii?Q?+XY8tfU17SEBH3ObXyhQpHi5qkwppVAYK72Exhi9bHFA9yl7sPIo2EKOcUZi?=
 =?us-ascii?Q?1/mzl407v+VQYaJkAmChv2hBy3OjFESdZPjdu6rd4xFUERVm3KSfF0Gz9l+F?=
 =?us-ascii?Q?ag4L1YG0iUVDoy/rP6qVQvm3s6yebYvDXRhU+JIRltplhUp8dYNQEc7LJuIC?=
 =?us-ascii?Q?MQLP7EUoMpUmTGRQQJkMyuDlkTZYkH1OpZr2YlVNf3uJWg0lgICCpvBTSOLc?=
 =?us-ascii?Q?JDpvaOpEt/FdItHqvoOm3AsKCEUkzZMd4XCR5dqXuhLfrbVVvvBZ9PJXJLGl?=
 =?us-ascii?Q?TLFPDu2QrlsWa/sXwMgFozSs8m5nxp9Oorv0yMezgpr2ImkMZEe3KeCzbnZp?=
 =?us-ascii?Q?RUjx6Ch+z+Yl4VdF8T+XawF8kSGpxAQTyfFhssKf0239H2PHexvWD565+Db5?=
 =?us-ascii?Q?1mxmoSxuDLTNCRKDcm+J9XlmbX5GMLmTCi5z17FJlL+zyifhJNxlklRFiC4A?=
 =?us-ascii?Q?vItPF10SkBxu6VBzN/qf47ALYi6OE9WvfuhYgNerS/5VGJxxTibzZaQ5NNkn?=
 =?us-ascii?Q?ECKWQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Plj7V/QFPZ0Ckwh8y7VBdOXbqwL+MEgEDrek8AAcG3h0TQS56+DsgJ637FH37dIHXfZlrwwPUW6Tx4TjvT7+NX6psxaj9giTLvnphDKWwfP1yhte4FQROMts5DaRIfctF5oWv2QDQehHFyd70BudLX+zdoUPBU7bzHQI1mNwdBZPi7wwETltynMgiYzsHpK+b1q3El56JAfXyFmwzxOZPgdyAallGKfA2uE7clI/5s6IgnilivrAFTvkUtDbkML5dImIcESuZbKKtZSjOE69BqXxOSUWM10wRGvSs22eG5Xr/g8LXi6sEle2+93y6sscShfYBaTJnHr51v4d+ULSECP+9K2O2x887Z7kZ7d9H/O73hOTMqHmX+RZKFBbApKYvNkIa/tvQpUYx1Eh5gpVWKyEI9r3dI2cFjla4WqMHmiW2khiz3nfMHs73YiQT7Qx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 23:29:20.2480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c73b686-a4f7-4a06-1cea-08de6b57b6a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 06, 2026 at 02:48:17PM +0000, Shameer Kolothum wrote:
> +static void tegra241_cmdqv_event_read(void *opaque)
> +{
[...]
> +    bytes = read(cmdqv->veventq->veventq_fd, &buf, sizeof(buf));
> +    if (bytes <= 0) {
> +        if (errno == EAGAIN || errno == EINTR) {
> +            return;
> +        }
> +        error_report_once("Tegra241 CMDQV: vEVENTQ: read failed (%m)");
> +        return;
> +    }
> +
> +    if (bytes == sizeof(buf.hdr) &&
> +        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> +        error_report_once("Tegra241 CMDQV: vEVENTQ has lost events");
> +        return;
> +    }
> +
> +    if (bytes < sizeof(buf)) {
> +        error_report_once("Tegra241 `CMDQV: vEVENTQ: incomplete read (%zd/%zd bytes)",
> +                          bytes, sizeof(buf));
> +        cmdqv->event_start = false;
> +        return;
> +    }
> +
> +    /* Check sequence in hdr for lost events if any */
> +    if (cmdqv->event_start && (buf.hdr.sequence - last_seq != 1)) {
> +        error_report_once("Tegra241 CMDQV: vEVENTQ: detected lost %u event(s)",
> +                          buf.hdr.sequence - last_seq - 1);
> +    }

It shares the exact same routine with smmuv3_accel_event_read().
Can we put these into a common helper?

I also suggested in the veventq series that event_start/last_seq
could be moved into the common structure.

>      veventq = g_new(IOMMUFDVeventq, 1);
>      veventq->veventq_id = veventq_id;
>      veventq->veventq_fd = veventq_fd;
>      veventq->viommu = viommu;
>      cmdqv->veventq = veventq;
>  
> +    /* Set up event handler for veventq fd */
> +    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, s);

Should pass in "cmdqv" instead of "s".

Nicolin

