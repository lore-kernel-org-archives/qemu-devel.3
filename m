Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FA9CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFHBn-0000vN-T3; Fri, 09 Oct 2026 16:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1xFHBf-0000ux-To; Fri, 09 Oct 2026 16:27:28 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1xFHBe-0006XM-6P; Fri, 09 Oct 2026 16:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtlEQKT+2CDLtGb44KvFotp63UxeUhvZ8T2Vc3AxoTZeRW17bB+Xcy3DQqI7sbWVq/gmHgPt8HK5T9vo4nW+92jE1gNep5Nxs+/qsoJYABiF37sllF9LNR7zeVKHLtYSdjI3PsRIBom/vSrgmV0jnremT5SNGrsGwIsOsfWdvhR/kdrUJtankdZ89P/ZfTdEorxrCnn67IyzbhWYjJ6xwBMk+odTAKRScCj/6gE0lueqcvMK8HBCQ/mkQsgdeT+3pCwz5J8kP/hzdGcvCAQjC80qiUEpXrrnAL58rxnMzjcVtIly5BuxqUzJ315bkkdRmOZoeyp/vTRGD0rL/90GwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izEOPKZHwfs85ocYQ42SOKpL93PDZfeRHEroAJAPMbI=;
 b=jJUUyJjL1zgFEon1KCR5xPuttyAmof5SP+u6YbV6A6ySgX9QWUV7/eiuMJxyfQRIAla7IrXJaKagzoFChjz9XSKRsT1KOdZjJaYfX/5SUgzQFI54QGpn6lEo6DaGlnlKEGdyzgSNMKMv8KQO+GxRr+ezpPneL4m9Ylk33/2QcTchYPUuQ5H0dBLjln69eDz/nE24SxjANPMW0IEdXVXXREqSmCPL01FyhUF2JYOKj/rEzIYTNuSLiPYGyr9g9/q7zFMZIG8harWWuwb7rgXat3tmfs4yMqCzQQU7CBru83fnh9CAF/NZwZbLl0KOtWlgjWGIj1etJWKwszLba5AZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izEOPKZHwfs85ocYQ42SOKpL93PDZfeRHEroAJAPMbI=;
 b=lHAxKHzGh3wq+yVGcYdLr38H8RM+2V7MDna3PzC/aRkcaC+llwo7h50dq0p4ygUbizMshva6TJmwVeEcn60TB76P5qhNCc7BpL2v7P9HrFNLa6OE7r6abu62oPdk7BOvoGuNiREZzKWREkqLARpD0/hR8liZqy5oA8XT+RuCJDDuRyFv0XcThdCjTsoZWIkqH9BZ2DikXpvvm74imMUckWddZ5xi6jXRPdgu7N8S4pElHbv2sbnSES8LTfzJMmAM/6PexDuR/P5Z2cHOb0+Xim8DfGgayyASrFyCJK+lUrUByLG0REC97fG/faylYKJtOTH+k3HbBF3FSzx6moGKSg==
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 20:27:07 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::11) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 20:27:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 20:27:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:26:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:26:41 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 13:26:40 -0700
Date: Fri, 9 Oct 2026 13:26:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowangio@gmail.com>,
 <jgg@nvidia.com>, <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@bull.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v8 3/6] backends/iommufd: Extend
 iommufd_backend_alloc_hwpt() with fault_id
Message-ID: <aslN/uXOIuJKP42Q@nvidia.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009090737.3930000-4-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 010d5867-892f-4467-07af-08df2643b031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qpTjVKaO/CaR5itWPOfk4PJKyzfgencrqqlJoN8k8/RwBH7quj8wgbRr7K5ZreGFqvM2mRDKZQFk/4p6EvJG5eSpsUtW0eCWntao5AZK+Ur2VN8dFv9RPJXcbB2Fk0kpG/2gxMdSBK3jNSVlWeR0umtBSQVXhFXIE0LSLaw1u31fylUYYwbyxT8nfgXsnEJLWrDNsBYaP08VtxvYY8K0qgKDvWXqEt3HAla5Jof25lDFJ5gTpgj6+yB5vjf30zdgC6F3hi0UaxNVkyACS5AzqujMXZspKXoLT8hiT365QEp2qD02VXPG5j6AdmyLx2mAgWCN3pBJvnBJjDz9I1z91kEG1gv6EZgX8lThquH4OVSyKW6yANXlEb86Fd7nCL6gKN466wCh+/sGPOcD9oIarNN51LkVhBBOezNCmyw6ynNpoInWwrdywKzJWb/cwf6rjJsKmKj0UrzwuFjUeO7Bs+GGJj6wVOyBR6CuXVJWNOgPyhr5ZhJYaJN19lbIu1Q0Icf//L8LB0iEzMd4Ig6W+wstyJBOSUor9sfE85kb0PpdkkzfP874ZBv97yRLFb8NOJb3odqsajQZ9katpZ6be/DLqiTjuIcyqACwe9wxFKHpPVMdz1xK0TOBwU5w590KQXGWCp1+XbuGEa7ldXxKzvtSkT0OQU8hf+ijtUau1ZqJYcmKmnTa8ft/38weixR32WiPdMgwavm97s8tGFKV9g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D4guNNrS654g00CyQNvx9tR6Rt1kOYX4twgfQid66T5V4p8o9rKqJvMhtpXsIjANwrTqJwMycFG/jtXBVjklomsGesKuuoWO3qgecwZbn0HeOP6NqIjguLlBGcLTMYs6umjtOLpJP4U/bz8RcwpjPkJDKTFGoZfIQafkV1VW6RnECzW2I+5/kTxcfbNpvhzNntPSL0VLlhH2EsD4+TvppcMLtBp/eWi0yKPC9v0zCZ28eoh6RzxM81azJlUVnZHGB/AdxfTs/xByimhjpQVxsxfSdkUIvXpnPL+MUflm8OyX8M2zUkABDCVu07+5ZcFbnHydov4EBfA9DA30qEYKE+0goPo/L+LZkdXCK2eQfValbIBqT7UC02HDexduiKkhGL6T/DuEWJ20wzsvlUfOFYXTs9x8cXWE5uKTdcANYqz1/MVyBAB6GHr79uHU3X97
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:27:06.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010d5867-892f-4467-07af-08df2643b031
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nicolinc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, Oct 09, 2026 at 05:07:33PM +0800, Zhenzhong Duan wrote:
> We should set flags IOMMU_HWPT_FAULT_ID_VALID when pass in a fault
> object id in the caller.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

