Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF89610BA421
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 03:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yBZ-0001yy-TD; Thu, 26 Mar 2026 23:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5yBY-0001yL-7I; Thu, 26 Mar 2026 23:48:36 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w5yBW-0003lA-Hq; Thu, 26 Mar 2026 23:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNZlHTNj+mmXhSn0QjBEqjMCc+rBv5av+xJVl6P8+4JhN25BnwfpGD+1k+GgA6iu++XSbvY7xkg0CXsNkPaGcfuOXKIdc1HOwTLGyLY8xb8VJqL4kp1mecEGEKjbRreAfXjM6SXnl8IUtv8SBGBy9eMv7MgS6LBwSBW9k3A2ObGujWkTdrxNMNnJ3cXqzGSasiB4xE8Jvg0vx1Yk+e/Dp12cQs9nglf5cBpdTa7XqwgHN9T08MmiGTD3FIebavcENba79cqvfOky6olGh7JyqQj7T27xZI78KuYCztCudYMlfG28305+wW/dZUwb7kJpJh1cE1xRD3ykN02QZKqguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDVYmQ6+5KfoOyhQ/QX+iKUNnYYBJAaTDSqvZdonbNI=;
 b=dkTyZkGZA2OmMl/Wy2Oo38uYRxhgBr0am7PyMXVngwYA7z8jXwDn54XOrLlEeDVr7+QBLDc42TK/5Q7VGny+CJZJa0QL1KpWF4LCpVXeQmEwKTMm4c7h0w7tq+8UImD+h7V+qkEaKHP69qrpglXGKjVfPK3OWOmrdFFUjjLAXa9jD+Wl6KxiGUaNUNnzUuweZpA/yKkxYNX+fjkg47ML0v2wU2OKl9PtpTWD8eswv2yDFo6eY8FCcMW0nYJMFMIFJOyGkFlkNiqLa6s8yhFfoglUxCKyR9b62/4PESAPhbedB1iD7BbrGpTKZUk5h9IWanqGaMSdK0T9HSrMrezYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDVYmQ6+5KfoOyhQ/QX+iKUNnYYBJAaTDSqvZdonbNI=;
 b=F/GGVfNHvGmk32yWW8rhJIZSLrDOeIvpvLArH8Dz6xG46jDEnM5Nm5hR/dL3paDY0PS3LqM5tOznf51JJiPCcZs5b7P8/QUTb6lstnTJOw67cuzsi9aWe0oD7JhgB8wGtiAXIR5vkr3gupbIBvhKLKLhBvsNmQEc2vpzAc5PTXLT26VJn2oigbdD+8NpHiRn3YPSyynzvRjDTj0WhBcLrN8tqr9/wAtje9+9Uxq52zxeDdclvlbGMt+xxkBlXGkHOVLQT4PWsUEQPPnf+AlVN9D/9Z3JN39i9LlVyrtX8GwSg4Vl3cJsW+eru4MRMQpvB5U1X8D/oktrc7T/NZt48g==
Received: from DS0PR17CA0003.namprd17.prod.outlook.com (2603:10b6:8:191::17)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:48:27 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::98) by DS0PR17CA0003.outlook.office365.com
 (2603:10b6:8:191::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 03:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 03:48:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 20:48:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 20:48:19 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 20:48:16 -0700
Date: Thu, 26 Mar 2026 20:48:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Message-ID: <acX9/RjKaO0bBI/d@nvidia.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
 <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: dc680aec-242d-4f9c-f9b6-08de8bb3b477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MipVb3ho1gy+18lGGWGLF5Xv0ON/dlAL9CCCc3Zq7TRO1mzf5j6oL7qH0Vx7ukBp+qVAv1442YIe1ktpA+gTFAnY6EO80Pcqkq314xXFXBCJufMQdOxcFKnSWaQNOXpGgk+vjch9qzHAjTRZT5Bxbe5MjoCU0dAbScWElLETk9JAKb8YW5jpFCuf5Y0cxlg6mJK1ozgyIR6VTszWLWTGTvQoiRQoqUzDJQ/hjO4RGi046ENC8sX4xzHD1gl6ko3v57H4msl5JBWapWLkELQwqB+9Bb2edOOqRPsMBjYgd12GIsJfaY0TIai9Rvxras6D5tq0VLLpcYWYA0N/PSCcg8EMy57vY2NgQjPvVFZky8PQhdSW65DSbkg9WqpPtRDuf3F3SGyl8Xud6Sa0TTFxh1FjeJEGwztgZABEIcBm42mlF6Hfoktfuyl+luqhCTI+440meAM39E011TqlEid0nzdwXqZyZ0y4BcCTOpGt+4LHO/k6tUlJrA9k8s8eNYydnEISCFUI6qO0P91lGGD6OsQjvEvx/Z9WyXz2dYcrFKYcKeqcL/27kUsMBPrsAv3As7ekrybef+if+wqJldWt/QK1pN7jS2jtVcD9I+aVZSE5efGzBroSWDwHZd+SUEXpCv6nLPOwQ/jRTAR35Lw7CXWenlO7P4gSEFy9wJpEwnKLrKiCLC3MfwK/T3IoYZU/Xo91NwC6OdItHbdb7t50kk9Ssr51ODXN2Ili7ZXVFQcGKo6EeNwpe4e+QCke84s92jcNYKe92b/CHtBxsGJ2zg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W6harFvBk4GtoW9DpQJZT9XpkTfn8sRC6GVxU560hh4Ct7Fws8HwxwS6REqhxuwexNkUh4oow8enjmttmHkX9h8yja9dremyOV99XD06lLJ/Xfi1KEhkp43IZQJv7fGS5ZzAZw0tmNZM6BcutRuk6uMBR7wGszcnliFrE3a4bMUU9/E/8N6ex5SYvU5yvffgfsUdZz/OEhfEd5lrqNoOvsAonnbeI0oPtUnvrIgNP2RDM5KkhGU0kGao37WKUdN56XtLtDK28L1t3deYwXOF0Ajo+PqD35ieY11c163UgSf+v+UeI7DYLei76HoxWqR23GX8qoH8CSaY6l4dCrWe4oDvywIDAUR6u/KHUTqMLkEMYi4j+kLjyKbRF51I+aAkUwmIGxNVQ1WAPhevn3i+reU/HgfcT8JaAI6u/hFhR3+ov92+nyIW4IAfkMlcZwuz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:48:27.4982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc680aec-242d-4f9c-f9b6-08de8bb3b477
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

On Fri, Mar 27, 2026 at 02:32:57AM +0000, Duan, Zhenzhong wrote:
> >-----Original Message-----
> >From: Nicolin Chen <nicolinc@nvidia.com>
> >Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
> >support pasid
> >
> >On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
> >> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
> >>       *
> >>       * @idev: host IOMMU device backed by IOMMUFD backend.
> >
> >Not commenting against this patch, but I just found the "host IOMMU
> >device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
> >an "IOMMU device" right? Perhaps somebody can help me understand :)
> 
> A host device under host IOMMU?

"host device" would make sense, not "host IOMMU device", right?

Nicolin

