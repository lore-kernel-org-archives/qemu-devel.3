Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FB1FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4GC-0000P9-3S; Mon, 04 May 2026 21:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4G9-0000Og-5L; Mon, 04 May 2026 21:07:37 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4G7-0007zH-EV; Mon, 04 May 2026 21:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZI5ZqKr1FY0bpnI3Pi+f3NRUpOySPMwQsV/11cBjn/fuXQmM5M9MPmVuhB8tuGNRSoed9Deqcttj23dZtUEqaWsE2QQ1XonyKMuu3d2BWl0KWAzsQvQQJjDHcrE2MUrBGMX7M+asWnNiIBtJVyHgZJyWGRIesE6Gp8TKuyZ0BijwV8CGyjXBGhP6sej/6B078t6/zGpN8UXxFTY8edNIawME7BSt4o7NRJKJUz83X9YymBvYkFcpMK9bQ9QmlRpIb6rmKFaf3Y9oyIhPYb8O6nwG4qdidmbozZX7psk5OIWvUIKHJ77670alEsMljeRanQxua8ohppW+IZ3bhaF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAD4OqKaPSBjMFeLQ+USmsZD+3Le9mFznqv/PvcZPC8=;
 b=aciFX+aD3Tl4IRjHPNuV2D1erqLGa2HvdqkTJUqgJmxjd9YFL0L3wicuR1XCb2jf4LE3v42GA/kSHIw3bByH8exNtKNKUX+LAl4Jg94+XYuzN0AvLSPwFoBw8KVDGiSRvx53jlxQ4ivHG4tiqr1YO9rwi0Z5/KfL12facRsziyail7vvae6F+mEnPxzeSL9UCug2d3XBGE5lPMvJKD/6vNhXeuAcqWHAjCK2giHmv1drMGVlCLRoBho0dHIzTJlGssj+FnB2b77aNQzMLJTdh33zLUgHGl2t+7i1gNooWJDHAMfIbzb048sbK8FIEWt77H6O8KNoDjfV7au6Uj7iPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAD4OqKaPSBjMFeLQ+USmsZD+3Le9mFznqv/PvcZPC8=;
 b=ptwI4Iy6JBQFtZi1ZlzqdAKPXzmz64qHKaxIDFt7Is3Upw6BwNhxZms5ppaPYvUDzwE5ujqWYkdPLBQtGYn+UjFh/5itSeySLU9wGDEBGbmOWD+bCO+5AoYKIdlWLn47KQXySH/55XzPiah11WWOv2Zdit6TMD8JmTjXoAXgF4edhi+4sQ9XYXJW8f5OAuZPBazFxcrcqcyNl/LEN1Z5M0aAqSkajEDExzkmuusKeDVRAASxnvLlbr1N7lH9DToR7nqLAwZKMLzeQHYp7nwrIdNEjNJYFSI3LsKgBRGnw8UJkdSRRIQ1w3PJIBIYSdRjoNzUf0lOSQOR89Gcghrb6g==
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:07:23 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::70) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 01:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 01:07:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:07:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 18:07:11 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 18:07:09 -0700
Date: Mon, 4 May 2026 18:07:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 23/31] hw/arm/smmuv3-accel: Introduce common helper
 for veventq read
Message-ID: <aflCuvleKMiVsvY2@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-24-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-24-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e867cb9-3ca1-4b06-788c-08deaa42aa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: gxqDTZvtwSRB/qzq1vFF6MwbbsYfwyVMbLLgGjWdchlVFCJQ2zVucOZWJlBuxCWtTIvkJIKVlrQH/J0j5F5nrla57qary+JIaRTv08Jsv55/71S4GCvT9jufdW1br1RBZQcJ8RPxT9SUBOAmPJqdIPdE+6VTHQy8oe/Rwlcy7cXlQ+rDXlCKk5TRR7FyOjyPElN9t77Ap5c7JbPepvFbcQ3nv+auGfMfRZ/T1qqT72evAcuOKVhLNdGAGjvatfzg4wqvdqekt3mc0KjRKEGkaWACbu42AAR8XfVqAvY1PD/Yhfg0ifxnsuXIEnNFpR0rBVLUoh5OosQ56azbFQzwFQ5iThGorv9CCedfghJcpQyCBb/zdDhErmqUN+MvxOZVQmiCrRowgsLzMjERR+L+mGP8hjnYnasatl3B9BdJmyDneLRJ2Krrk5gA8OlknNLsWbQv3vXJk/RE3O8zzKTv1ERAontnhuY8jwISzcm0k/QiolhTpcHwjl/OHrU7TkVuopPeAf5RFyAEnqD61mbbHGdll2tIvPFZ+96kBgOEMT0vnLbD7cGgGm3jrGOe2EBQLo/8HFW+EZjSHCRPYQ0NLbEJ601m1MIwY/VC/0cPtz84DelBO/F0jIzxpk11sXbE5GlfnWbW0P2Fh9k8dLQta10k7OSttEaXaUL4SEGK6gZbAtGkCE6MhNaIhFPiEkJQwTS0jx3aEZbml+Jg1+oDg+IjJ1kB3hE9sx1WScwKpT8=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ZareDLKg0E7O7HecuNVn9+Qve3Xivfi8TdD4D+ExWq05zwBKVKNrsKTwVuD4hDKXsOtBz9S9nkWSuL8xu6p3zxcswCKgsxTsWtNLdrpEOjrfFdWKW1dTXh7gmNamDaM/v5UMmB3aKuFGrm5Q31dNq0wE7SMGEwLTelKxIQ9Kv0Jl5KHRHR+LUThb+SXTDbREbjtYBudAdDqG5cKM1aEUqLAm5YPTQfxCrL66R80/DuroYJanXFJ7eTPG/B5hLklgeFcBMFdFxSmiZhCM43nSR5LNlAJlLVAv/cyy37uELEbTFMNcpleEdqNF7w6PbbmICD674oYx3RllMJg3Hy5pQZdk9MC7Q+Uw5KgLesWJtPe6ZnJGZR+nycJ4jkbO0r/T+/10a4UMnNUnLmeYgDAv7SKLDMUa1nh2ABqefdRaw6SAdh/y2hcNtpuUhZz6Dk8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:07:23.2316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e867cb9-3ca1-4b06-788c-08deaa42aa27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Wed, Apr 15, 2026 at 11:55:44AM +0100, Shameer Kolothum wrote:
> Move the vEVENTQ read and validation logic into a common helper
> smmuv3_accel_event_read_validate(). The helper performs the read(),
> checks for overflow and short reads, validates the sequence number,
> and updates the sequence state.
> 
> This helper can be reused for Tegra241 CMDQV vEVENTQ support in a
> subsequent patch.
> 
> Error handling is slightly adjusted: instead of reporting errors
> directly in the read handler, the helper now returns errors via
> Error **. Sequence gaps are reported as warnings.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

