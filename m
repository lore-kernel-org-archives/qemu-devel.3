Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070D8E9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJIo-0001IQ-Ls; Mon, 29 Dec 2025 14:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJIX-0001Fz-6Q; Mon, 29 Dec 2025 14:52:59 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJIV-00029o-L2; Mon, 29 Dec 2025 14:52:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NckJbLzYfSJdOQgk66gddYwOr2MoG3FgKCqdnzWYNho5nmHAAcnEEJNPj5o7b2v9uHBLWWLjqGambdTTmrKZiZpj9ymHcsYNBTyxaVGODz58vrooHNw8Bnvxg0L+Q0mKB3Cz9+doszbv2ms6C7Lw0pULYB0lNSEgonQTei0Okhqb6TKhyy4lNRWo1XsGqwIq7uQ+r+EGt0JOwfF+wrSjUfowgkOdD5VUK2uRtc5g1kP+Q4mvEyLKSDL6ZhH1mb320D0/57HXkDSXTD5DlCHDZ04B+7MCNatk8gTTVD+3+UWpJuW/YHFG8PSxS5Eyulf13DOu/dVcExeuUnQmptOiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Feyhdm8VaN4YDLuXzPhLYpZySfaWX8vGx3gsGlmHE8=;
 b=lEGJO3L+V2dRwqKz/6nsDZE80VmTsVO2IgdoXZ/OEmelO29GWuYkrf/W0TkRRTeXAOsiSuakYb8sA8DpKz7Tk5ixyO29I6p+JrC5NUZg5/Jm/rm+XbShwf/lRDKbGRjEQsT/0KUjb6VARsKrieONNcFeZ4f14vYtzNnVzt/yLn/wS2dPmkV6p79fGW4yp7AthcoJT38Lr2HpNG50/J9r1xsaiWIivhwjHfd6SHSAwALFQ1plOzXRj/8UFj73BasMJ3uJIVXc/wNf1EibansmyGhQyStDGdicN7XfA8GINMLHXiAXm3ddj+g0jEC+DfUmOOfjkZAfyCKYz/BX/UonSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Feyhdm8VaN4YDLuXzPhLYpZySfaWX8vGx3gsGlmHE8=;
 b=jBrW0mnjxk7cBoCq/2T4SphHIczU4eXMC0JX6EzD0hGsLR4H4lfMhh1nnvx8S5iDXQJiqSZmzTRoHdTT3l2iw+SlyDPonrtklVeAPyLuY/gbaqk3Qy0a07jyGmxn7Gq+SR62u8RdMFkpZT+mq+FEp057e9ZdPm/BaguUcbYOAGt32UhGfWYwaJ7QJVSYjamengz4WJETapzzInVvTCGsMLZyI/+6Xx6yAHTbrtGtZnUUEXo3VKzwvkLrddtYUxt7CheNci/dtrxh7kzPgj08QFW2q2Pu2jNIGquxdEIfPXiM1pLZAgXd1xcAHGbQhtwvw5xiDEgLpmV9d+mSg7HZ+Q==
Received: from BYAPR06CA0020.namprd06.prod.outlook.com (2603:10b6:a03:d4::33)
 by CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 19:52:49 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::8e) by BYAPR06CA0020.outlook.office365.com
 (2603:10b6:a03:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 19:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:52:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:52:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:52:33 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:52:32 -0800
Date: Mon, 29 Dec 2025 11:52:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 11/16] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Message-ID: <aVLb/zDSDda6eSmR@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-12-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-12-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CY1PR12MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2466dc-1070-43c6-8ee3-08de4713d7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cud4DZvaNMVpUbpBAbhhNesidmIATk9VdE9VvW1k2g9Mw9+iE+OZE+8d31bu?=
 =?us-ascii?Q?CVL5puyzo3VxRJgtEHMVYDSTOoKYFvw61aZIxhim7bOSnmunG8WZS9XBOPWF?=
 =?us-ascii?Q?j3wG7zRe1lTmegfbuHxI98SzvwxzTMBXyrDYqrev/L5rXcrOk3q94VjyLtBv?=
 =?us-ascii?Q?xGyGABsCTg8/Z9V5Xi2w42bB2WCFnwoTMQ8WucvsWibGqjU7SRgXkxqmycuZ?=
 =?us-ascii?Q?G/WJe/6T/ZGcPeMCrsi29ppbyt13Bo11/Gr2rVrd8kKXPU2NRSBnSR0htPuo?=
 =?us-ascii?Q?KXdsnFT55jj32C01kYHBuEfAUsvkYSqftaFsV988o4/0kc7QnIGCYu986uMt?=
 =?us-ascii?Q?TVLqawBnfySYtZvHrbyehUFEk13N/DEicXL7DixwnHcEmeUlM8UFuyq3TYxx?=
 =?us-ascii?Q?fsWovMJ6PQbbxDN+TXXZjJaipgTT5j/x8yzq+jHAgXRrM17UGLQZ1ZwpWeLg?=
 =?us-ascii?Q?XMetbCIZO20eVIIeBOrzFZdw3YcKFQCmcwSJMYFvKMiS0xyHZxUO0jZdPeDO?=
 =?us-ascii?Q?p1BAsSIsnuvfWAIqoDhU6Y68BGj1BQQ+spwjYWcSE4qTx946pb5DT/+NiXaP?=
 =?us-ascii?Q?k4aibNaXjnqv9b9UGNzn5i6fEdNdg9+xLe9rC+keff9QhPMAMhRhaNfMSfu/?=
 =?us-ascii?Q?NfFVjEh0K054up910K7s/IG49HnF5Vob1fyG1EveWVwd3DR62aLrp6ozIaL+?=
 =?us-ascii?Q?Px/iiIeoB76bhT1Af6rrHECrDD9+oFm9gTXk3x7vJYvYCMPl2YSSJqjyfdmT?=
 =?us-ascii?Q?rV5zj0T5mKTnnp8O5M0HGRx7r7t8S5GfJt/1rQeTe6fySlI3FCJSNpDZJJC6?=
 =?us-ascii?Q?25AIn89WI6QoLK9NaxLsHiAD3FcO2nUBkaSqPcfZ8RCDku3JP74GJxQKddKw?=
 =?us-ascii?Q?AKXcfW7EPyCh6grGi2KosRzwEeAaKfNABHic885Rrt5zdZSLJXMyDFVLtoMY?=
 =?us-ascii?Q?Jts/P0qe3qiB8b/RC8R+8QXZk3Nb/Qo8EpPY39PzRipnA8LuH+9+R26nkbEg?=
 =?us-ascii?Q?2F17voBPYcmvJtzDOndlB+DPefCGSOLtnuyrXp8bhrwModIhTPeK6ZZ/GvbQ?=
 =?us-ascii?Q?AIRLvjuMAhGL8hQamImEfHRNi3zM8O1y1Ki8XrYKFSfxDVeanAKa0iq6iGKR?=
 =?us-ascii?Q?1OW57/iRcebHPkCSsq7NrfHaaA+R3VABuMOQsPrgFmCDwO823pK2MUFtgc2X?=
 =?us-ascii?Q?xKvNU2/1uDtQkRhnlnUE7Z4JtQXnC/mSCWBQPMY4UWKPIzQ+Wqom2gipRi1F?=
 =?us-ascii?Q?YSeDDzyfVq3ywS9v6GS4eZQ/X2oiclJ7IC3t70CnM5xfiRBOLa5MupVMjOGR?=
 =?us-ascii?Q?Y0D4QipmmDJ39wpO2YYqJMZAyINbOixrpv4q7nMlKmIQwEqFBT0xSjIrEweh?=
 =?us-ascii?Q?FxIoKZwtoJMoveDRs4w3/derCp1/7cNLFqbZi8lFyn83qhJv7gja7SRFInDj?=
 =?us-ascii?Q?xXJU9x8tBFHiqYDY/+ppoYpnpviobJqv/PKgYFQu7bseDyAa1IGzJv70APT+?=
 =?us-ascii?Q?SQ+BIT7yHkZRjTt9xS4aelg7jW+w4QwgK1NPtr+IlkdO+ZZEBgvMqL9/6pky?=
 =?us-ascii?Q?mXY2Z/HKL1Gj6/2OlLc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:52:48.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2466dc-1070-43c6-8ee3-08de4713d7e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9697
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 10, 2025 at 01:37:32PM +0000, Shameer Kolothum wrote:
> +static void tegra241_cmdqv_event_read(void *opaque)
> +{
> +    Tegra241CMDQV *cmdqv = opaque;
> +    struct {
> +        struct iommufd_vevent_header hdr;
> +        struct iommu_vevent_tegra241_cmdqv vevent;
> +    } buf;
> +    ssize_t readsz = sizeof(buf);
> +    uint32_t last_seq = cmdqv->last_event_seq;
> +    ssize_t bytes;
> +
> +    bytes = read(cmdqv->veventq->veventq_fd, &buf, readsz);
> +    if (bytes <= 0) {
> +        if (errno == EAGAIN || errno == EINTR) {
> +            return;
> +        }
> +        error_report("Tegra241 CMDQV: vEVENTQ: read failed (%s)",
> +                     strerror(errno));
> +        return;
> +    }
> +
> +    if (bytes < readsz) {
> +        error_report("Tegra241 CMDQV: vEVENTQ: incomplete read (%zd/%zd bytes)",
> +                     bytes, readsz);
> +        return;
> +    }
> +
> +    if (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
> +        error_report("Tegra241 CMDQV: vEVENTQ has lost events");
> +        return;
> +    }
> +
> +    /* Check sequence in hdr for lost events if any */
> +    if (cmdqv->event_start) {
> +        uint32_t expected = (last_seq == INT_MAX) ? 0 : last_seq + 1;
> +
> +        if (buf.hdr.sequence != expected) {
> +            uint32_t delta;
> +
> +            if (buf.hdr.sequence >= last_seq) {
> +                delta = buf.hdr.sequence - last_seq;
> +            } else {
> +                /* Handle wraparound from INT_MAX */
> +                delta = (INT_MAX - last_seq) + buf.hdr.sequence + 1;
> +            }
> +            error_report("Tegra241 CMDQV: vEVENTQ: detected lost %u event(s)",
> +                         delta - 1);
> +        }
> +    }

This part looks quite similar to SMMUv3's vEVENTQ function. Maybe
add a vEVENTQ helper in the iommufd backend?

Nicolin

