Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6B4FCA177
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfvw-0000pT-Gc; Mon, 09 Mar 2026 15:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzfvr-0000no-Tj; Mon, 09 Mar 2026 15:06:23 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzfvo-0000mP-Ok; Mon, 09 Mar 2026 15:06:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4JO2KQ79dnZvcYcPGDauF1xMLt/scvZcbq6TZBoXEQP4IqHcvhCveH2eJH73VeiigtdSPHkMMgypr98xqD9eS0yOLEGTMy/eh1GfDE3yYPbrFHI4K+FvrmhIz+Q34AUlevkaxEW2FreLGVm6d9FdVbXsbSCNWIZGNSsshRHg5B5nRVyR+MIYCwkArETr7qeJIIG2VtCmJBOvo79GF7ztcIQOc6sV1qGDl5i1WjK/PQVSEk3E55Br9XGiYg4OiosjMQwCGzQh5eovsoecpg+pSZ5tNQVsXEoelH/I2Rj+DlrGqVqB7GfMj9MRPS+kYjex9NytzOhWARz0Idf2uC/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPIo9cuT19fiZhqAWvgIdWUBYUOYMFHQ6pmxrHxM2+Y=;
 b=O4o+3/Ac2ma1A+nkWB8YcP64qZTfSThZqqfE4dkfn63OxB8X9mc7fccJyzWZDlfMTlHlq4/00VxjMx7cQP8oLK8O4UwktSh0ApQ/zRqP/Qrj7aRqgGuiCQwuF9+OcUpVfanamLH3p+VzaaN+oHHLi2TfEMqKFB+WdjcvcJVuYbN2R+A4+nBxSvqvwu2kquvcibH46NCjCVfsprZ4Vjq9ttGqgntSW9HC4Qf2TV2FeMJIzi6HpdpDDsP+qpVTgaF0SIPsla7yIv2k/FPQqby7SqeTY01AqmIT0eGXl9l6s3NOHqvOQYxTdGyxU5Js0DSt0BQtvsfibDPhylNg/x1Q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPIo9cuT19fiZhqAWvgIdWUBYUOYMFHQ6pmxrHxM2+Y=;
 b=MNDpPvIY8mds4BOyXLC0KXDFBnVatcvgYoMZ1oEPIEBJyaLzYpmFI37iZpn8I8vJ8iKcfJdgoF+3ecXLqIjItVbNhQFDWJ3aE7dGnqw0dPnKBIw1pdCuj8qLARa852xN4wRNTBfiFUh7dFRd/hU1ouGAFJOQbcJnlzssHCGTf+mqdRbMl8in8fsk+gLHRIQ+zj26atbM2OjCrpF7cvhjEdI3N65jGLSrlSJamMPd9g9m/oCnfI3uT/QsChazkzswzfU1M6spJsNQWV6ufrz/iT4uu5G+kQWtyCR/FFV2hKq7JlunAECAaUkgM+YvlN+c6uMqwp1CAOGh7TxJv7kMhQ==
Received: from PH0PR07CA0052.namprd07.prod.outlook.com (2603:10b6:510:e::27)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Mon, 9 Mar
 2026 19:06:13 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::c8) by PH0PR07CA0052.outlook.office365.com
 (2603:10b6:510:e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Mar 2026 19:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 19:06:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 12:05:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 12:05:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 12:05:43 -0700
Date: Mon, 9 Mar 2026 12:05:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Message-ID: <aa8aBsl220veL+n/@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-14-skolothumtho@nvidia.com>
 <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
 <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aa8M96GLFbPiMNUo@Asurada-Nvidia>
 <CH3PR12MB7548B6C7F7DC206BD38B9143AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548B6C7F7DC206BD38B9143AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 417efef5-a480-4068-82ea-08de7e0eeea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: CVsysPn4knKS7BKoyymkGj9wy14/3+8dS9XnI/GXLchcyLf+OSyWXPF6lB6w4T2bAMSRogzt5dkuyssJTjFadsdJIyBi0wFSPwUuHIPg0q8SuqUkvkMuVSNOOqX8VT9h7HnEiTV1AcLq5XXZpPFZf6QHHUtWdkg6nZRd+cUH2Xw76u1iuEqZRRcoytMlCiLmO+5KcnFQQY2p30fpoAaWgTSLWE+VvtQ4HOPbz7NC+leXmE6DZIcupDa7x7eIRkP3FA1ut8SPcJSKxHHGFC0oTWe8pdsUrNVo28lxyz2olcx18GT7twQXrfShWYmttN6K9ZTcraLVwA1hM65zF9SphIjmswHxVUYoTnmYfsQ7epp8ML7lufVsQqTAKCgPP0tgWnl/jvY3USWYf9I+nxkwswvnE8QtEKdHwGJ4SBvYb9faG7LooHa91p3+F616ph+mRxk80WdcDmpKxS+oQeo19qEm2dF1zphsNWHg3/MHwmQLTOraKSXG+s2oW4R5zf4awf6hE+5w3NIV+8EuP9xhA6My2V+drKcXeCeQPrJYXbHwTMplXlcB85p9Dde34pR9RWquLevjeQYIn4OP7kAI88EugFK8eXkzQKeqgjansBfmq3uw5qTfjEHhCS2NPjwchOqpbH+4uDTIUeoeaA769jXX7yMPXj8oj6eS/CnOSkfk3i0Mm3rDnAvLTkHR7n9jBoPi9Qh9igmgPKyBXs5OMczRKoukrvGxjdY+6OJ1o6+IPzamTRa7gsv0uaV53gZDxDy+DCkx3PPojs7DBuYhWQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KrnV+YdNr3phmt/vhjLnEJescsJaokx8aAQmeV7Zg/zZaYrRnOZtAat+ABzdIydXdReOpByODKqPsV1EX8LsRBtRlHo8qZ2xNXlCatY1bf8ZTQbV8KlF9+XRShT6AKmeQUa3gtE7+Jb2/52DJCQ/XXILBbTi1jbhsK9q3YjFGf7KFS+9dn8zChbhMDatVsXe8c93/R5bWnWsgHCO/qv1+Cg6ol80Oall5R0vb+WfYxg4Pu6BjsnNtPLM2RMB2TO/EZU6iVgkkIVL0j3eRA2H0YZnWnfVBvlrkNAzhSc/r2Hya5bNnOFQrzD0pYMRbH5FyiHdqU8BafV1+GGMo/hkKLYDvTbcSiPmxFankLQoejg+N0aJ7zQfGssR8TDwwgu5Ss1cStJLtj8jSCkJOxrw/C4j+Jre3CaXO5HbaU8G7oX7WYduj1i/tCVMEpoLIxUd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:06:12.9861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417efef5-a480-4068-82ea-08de7e0eeea0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 09, 2026 at 11:25:21AM -0700, Shameer Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 09 March 2026 18:10
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> > devel@nongnu.org; peter.maydell@linaro.org; clg@redhat.com;
> > alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>; phrdina@redhat.com
> > Subject: Re: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV
> > vIOMMU alloc/free
> > 
> > On Mon, Mar 09, 2026 at 04:31:22AM -0700, Shameer Kolothum Thodi
> > wrote:
> > > > > -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> > > > > -    return false;
> > > > > +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
> > > > > +
> > > > > +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > > > > +
> > > > > + IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> > > > if the only think that differs compared to no cmdq is the type, ie.
> > > >
> > > > IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV vs
> > > > IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV
> > > >
> > > > + passing true args, maybe you can just record the type of the cmdqv
> > > > + that is being used in the smmu_accel device. Then you can get rid of
> > > > + alloc and free
> > >
> > > It is not just the type. Based on the type we also need to pass,
> > >
> > >  * @data_len: Length of the type specific data
> > >  * @__reserved: Must be 0
> > >  * @data_uptr: User pointer to a driver-specific virtual IOMMU data
> > >  *
> > >
> > > And the above is implementation specific.
> > >
> > > If our idea of the "ops" is to allow easier support for different
> > > implementations in future, it probably makes sense to keep this.
> > 
> > Any future "cmdqv" will likely have a different viommu type. So,
> > essentially this is just a viommu type override, as Eric pointed
> > out above.
> > 
> > What we actually need to expose per viommu is type/data_len. The
> > data_uptr can be a union viommu_data in the accel structure?
> 
> So the suggestion is to get rid of alloc_viommu() and retrieve type/len 
> during probe() and store the data_uptr in struct accel . Doable, I guess.
> 
> But then we need to do something similar for veventq as well, right?
> 
> Isn't that actually bloating struct accel then? 
> IMHO, the ops way looks better.

The data_uptr could be dynamically allocated corresponding to the
data_len, to avoid bloating.

But you are right we do need a place to alloc/free a 2nd veventq.

Maybe we can have a pair of alloc/free_viommu for now.

Thanks
Nicolin

