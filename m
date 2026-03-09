Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FC3FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzg4d-0003bT-72; Mon, 09 Mar 2026 15:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzg4W-0003W4-IY; Mon, 09 Mar 2026 15:15:21 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzg4U-0002OO-Nv; Mon, 09 Mar 2026 15:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8IX3+FeBl4Pbq/Hjg32MzyYAu6w5a2OMtKQ8I8ngrdGnc8rYeub6armixUyJyQavSb9DQu9WKGq0dnPjGC4A2RFpdYPVYYYvks3UB9dyLbOKHRXgFQlmFCEH9FUHwBPvosEaZaET0O0O5BofQO1S0LtoYE9A1nC0L82Yd86vpgjq5tk25E6wj4jvnohivt8UVwUveG4u1Hxhi4lRdNugBCGQysgxsk/vIJgOYYl2e+0r54oobbnW45IxE8DA0BwG/JczZ8Vu0+veJhXsKNDxjtSJgwOi8gC0cJK5gt03hbdFLmlyQQa3nRO+5qxp31SW69UzTzV//R1FqQcVLSd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VdNBakTYcj60DVnlRERPaRxzVAaJGoNorU1X7G+ses=;
 b=cZWklZK/rYuW8yaXTwuxHXqz9bJrkzv8+GXjoYuayEYdJBR1Q5o9E6MEY9Gok7p3jtRp4eC0eO/i2E/tB/PXtVGFR33AWTcmQe35ZP/j5zORvqBfssouVLJMtGzQnby923q84zGnv66Au9QVrqMyZ8QlKlVWxBMbG+TqZqGP/6a5IBYRpLLGTV2avp2zE56Zp3TJqg2BWBSIrNlWu2sCW0Z3MitU+tcSVBtJcc7bkPmHrBj18EzGrKfzC2oWp8KwtO9xkko6rEpmmMwZWXWNAhFuFMiPrCJkP93OhKSUhwPsoWcRZfzpDqW927RXZiwArjKXUIQLB6gwPETGhPUYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VdNBakTYcj60DVnlRERPaRxzVAaJGoNorU1X7G+ses=;
 b=Xf9SgJAkaUGW//dFruDazmsWoebutxG78Aad5Ko2yXRjdxf//pxd89tWqgFlnCMC0KL9+t31yIr7oLAYCANMG2UBT0eHmVoY6par2jLARrUdyYQieZZZ4frkV+BFfe6xOO6kZbci36GpBZ1+S2+mAvWxiYmHa/a7opbZ+w6m5OF0LgTq6d743LazmyUNwCElkd4DeNakLU/1yQBujFdytwJ1zlXsHBkTuaEkMX5m5pVP0KE9FZJKvhAqlNxMYW3VF9vFDjfbRUB9t1pAuetR+lwQvPeApXk9PnS1SlLEsumEuccGHbfDYFIksbwQs+WYRgQp+uLkNzARAgHF/evqHw==
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:15:08 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::4e) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 19:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 19:15:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 12:14:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 12:14:48 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 12:14:47 -0700
Date: Mon, 9 Mar 2026 12:14:46 -0700
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
Subject: Re: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register reads
Message-ID: <aa8cJszkOKGLUYdD@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-16-skolothumtho@nvidia.com>
 <1b64d8d1-85d9-4894-8813-d645977aee68@redhat.com>
 <CH3PR12MB7548413828C8ED32C75B1ED1AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aa8UOhKhA4jIXVxf@Asurada-Nvidia>
 <CH3PR12MB75481A77D2468CA6848824EEAB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75481A77D2468CA6848824EEAB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0d6300-c9de-41dd-6334-08de7e102d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|7053199007; 
X-Microsoft-Antispam-Message-Info: Fgw0M9aZITUR6yykNqwV5GDpDu18te3GRpOE53UrpQqRHuvnxnHxdv0/NQ3qyubhjqNJkC9yqyvwZ7toZbSImXyIixfgI21jNKj5DYg7OaxFc8lfkH2DJJZowDXJmpXabaheruSGn5YVJ4RiqKONHIkbbUOF6cDMNWfZ86Lc8Dcy3+w04t+spAORqgz/2y8MHrVo7gmTJL+T/ukI4/jylWPNUjsH65Y+Lcg8Tyo8bsc3OC2UJlYSuLvv1XsOoVjNp2gRJdk3vphOi9sFvyfbmfqDpYfR3m2qAk6UexVxRW3FhDXFz9askGoNMXpcXPbr0ZcUSukcn8Zsf9RsYuMKD4aW+6LyVguxEVTycSjn9PG17yPzKx5mE05REOIlUfNKekYkBRtz2pa5UqegCAae7+IqN0GztE3Jo2gQef+4r+8r9OUK2IRWevJCt2XF9/K76iX+hDF0WMjM4h8/uBMoIb41M3BYdwGwQ4LnIqWu3Sgc6rrkXeqNNVXB0AUBZvnbdMBM6c5pgo4mYQIxhSB8gJOtI81Z7LP9vr2eEKg8C3KprlRpE1UjEYjkr7ggYnFltexvpYaR2t81irKQClMxI2TrwSaQL4uTpvC9l6gh6fmJBQ/RqWReddIbcjnabf3vSTFai8wrJNki+UgF/mAJ60HOEdxf0JgwSLbSz06yOcZOx01t1W5hLtybg59F+fQaM1otX8xfobJKmiH72yZm7wUu0Wx7mnDOXPaQ0l5Lq9KPrgnwUIUFSbTVQNLfkX6W0FKJ0Ee4jS2JyKDAXTaViw==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gEM41oRoSUHZGToe5vmlG8BmopgYf6DHrmlDdWVpYiocpC1KC9P1k/OBY9o2KzNKcrW+XnISEXMiPR6W0n5kvsL2Q53d3RWl5wmGMiXDF7AFLd+VTpkdhQzkvxDj/Z7rKzrZ+1gDv/jsHRCw0ELobU8eSajvSsjnmGUd63zf7RMbNxBhiYOefw0sgb72mvwrIKSjGi3OmjX8rc/i+m/qeLUERURoMppaG2C2/AJlSh/PlFpw96YkiayOVttN/I4GG6vZlytznv4iy7400MrwwM4cyYb54HpCfYeBzJCEVF0xJvKs/04uhMIsiSNFIy37OfJnaaueVGSiDJoudCnHxCKj6k1mLSYyUP+zJHd3NfDq1aFk7SzaajQfTHDo6hDFzL+IxhmS7uRrgok/gFtz/O1WENA+3uiHPLnxyvnrUkYybPna6W+vWxYJNdaq914D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:15:07.9825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0d6300-c9de-41dd-6334-08de7e102d71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Mar 09, 2026 at 11:53:59AM -0700, Shameer Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 09 March 2026 18:41
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> > devel@nongnu.org; peter.maydell@linaro.org; clg@redhat.com;
> > alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>; phrdina@redhat.com
> > Subject: Re: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and
> > VINTF VCMDQ register reads
> > 
> > On Mon, Mar 09, 2026 at 11:04:31AM -0700, Shameer Kolothum Thodi
> > wrote:
> > > > > The VI_VCMDQ register ranges are an alias of the global VCMDQ registers
> > > > > and are only meaningful when a VCMDQ is mapped to a VINTF via ioctl
> > > > > IOMMU_HW_QUEUE_ALLOC.
> > 
> > > > If the guest detects he can use a single VMCDQs (I guess he can
> > > > introspect this by reading the SMMU_CMDQ_PARAM_0) how does he
> > know if
> > > > he
> > > > shall access your so-called "Global VCMD regs" at 0x10000 or VI0 regs
> > > > (0x30000-40000). How does the guest know that he is supposed to use
> > VI0?
> > >
> > > The CMDQ registers can be accessed via both the so called "Global VCMDQ
> > registers
> > > Page0" and by "VINTF logical VCMDQ registers Page 0". And they are aliased.
> > >
> > > The difference being(from Nicolin's explanation here[0]):
> > >
> > > "
> > > The global page0 is programmable at any time so long as CMDQV_EN
> > > is enabled.
> > >
> > > The logical page0 is programmable only when SW allocates and maps
> > > global vcmdq(s) to a VINTF. "logical" also means "local" to that
> > > VINTF.
> > > ".
> > >
> > > IIUC, for now a Linux Guest kernel will only use "VINTF logical VCMDQ
> > > registers Page 0".
> > 
> > Yes.
> > 
> > > The question is whether QEMU should also support accesses via the
> > > "Global VCMDQ registers Page 0" if some other guest implementation
> > > chooses to use that path.
> > 
> > Yes.
> > 
> > The point is that we can't reject guest's access to the global MMIO
> > space. So, QEMU has to support both. But guest OS is allowed to do a
> > partial map/alloc, so global MMIO page isn't identical to the VINTF
> > logical page in this case.
> 
> Are there any benefits for a guest implementation making use of the
> "Global VCMDQ registers Page 0"?
> 
> If not, the VINTF-based access path seems preferable from a hardware
> isolation point of view.

Yea. That's why Linux was implemented in that way.

> In that case, would it make sense to restrict
> usage to the VINTF logical page and recommend that guests use that
> interface?

I don't think QEMU can recommend that... Linux kernel made a good
example but it doesn't make a lot of sense to recommend or force
all guest SWs to follow.

From hardware emulation perspective, QEMU should just re-act like
a real HW. It's okay to make it unfunctional v.s. unpredictable.
But it shouldn't reject any MMIO access, since the HW wouldn't.

Nicolin

