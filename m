Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEC1FCA174
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfXq-0003FG-7K; Mon, 09 Mar 2026 14:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzfXm-0003D5-9i; Mon, 09 Mar 2026 14:41:30 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vzfXj-0004Vh-4M; Mon, 09 Mar 2026 14:41:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQUOAZyNEkh4udqMtIv/4guVPRuBFS8OiN5jkfd6vVjRykE9/ooYbq5tMeOtg/tTrQMN+95HJF2qzuqJN4xvuttDs2fm+5+iH+1NcUKr9KJjHkDPNgZXfl02LTeIOd8S2FK/8XndGA6RcmjVsqGudehWFxUeRxiNkGvWPxJJ6QdkMUWcyZo+uHsa6ZSipn8E0wGwUHx8oW964p34OH0WDBYnPH+JORs3EOYH72z4x9G8TMrcNv3RgB3PAXGwPc7ersAhdmIDDSiHBv2Ozr0zIlORSl2YP2PRUM9CTNRb15KGbyaAhxqXzymwYCFS0SdqLGgzobp5W+gOIYzGtb2x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTrycQbGlAHf24CfOpqZ1oFXcEAZvySGCOJV6e4Hf5U=;
 b=iytZ6aYiri8FYoQCucQP4FlwtzqTq0XOn6yDkbn7oqh1yf9wzcpMuu0F3mazz1Cish7fBre332Sm3MOFouKaF9XX0XhWA88VMnHQr4bGQeGl9FWmeHdEMWXVChCGRRTLd9wfDq8QCIlIv+VsLwDuyph7Rxz2saP64nVyU4O8FtP82CYos/YNWav81FfxlDZVI/WEIdatEsYdwvS8ORnYsylXshECweUIRdoZUpE4/0InuDQydxYxCscHicO/caZN/8Ywk6BPFZFUmykn571eojy5MbgNtvFWmxcaqqUxxAyWJBUw2ijvGHurSOIsuhaQwcdXiaXMjchxjBnnGSMLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTrycQbGlAHf24CfOpqZ1oFXcEAZvySGCOJV6e4Hf5U=;
 b=qpKuXBUvmLKD0FEPqhVSO14ByeM/bxF0Nk2ix6u5eLyPowlejEHL2rHgb2fUNyg2CY6vG2yNkmo6hnN++lpyQkEFaOvRkvtUIP9z1KwsZqAtjIqVEhfXGLoY3GiXR3/5HVkc16ln9dVV+1Xo5N5qETxPLnzJ8+DbWZn+WXIF6ozV9WLFxrQDZ3NnsAi/avkMEVmFVW4uz2fATvrFG1G1761ciPRrUVLU2T5RfarN2toZ1T4e27BFfTmjEPf/2vrPgS7W4KHRt1PC229Y5Ckh9UwNlNES88E8Jrxot1mFTjQC47oAfk0rSp8WrOOmF+2dCYI4h5U2lvNByla98NvPeA==
Received: from CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::22)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 18:41:19 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::21) by CH0P220CA0026.outlook.office365.com
 (2603:10b6:610:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 18:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 18:41:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 11:41:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 11:41:00 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 11:41:00 -0700
Date: Mon, 9 Mar 2026 11:40:58 -0700
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
Message-ID: <aa8UOhKhA4jIXVxf@Asurada-Nvidia>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-16-skolothumtho@nvidia.com>
 <1b64d8d1-85d9-4894-8813-d645977aee68@redhat.com>
 <CH3PR12MB7548413828C8ED32C75B1ED1AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548413828C8ED32C75B1ED1AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: d31c438a-a6c9-4e3b-429d-08de7e0b742b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: DM9CJ395tMOMtOzIcrR/XWNJaSxCyeb8e+ouAES9vCzRRjzpsmUahNEitms3I0Mm7xceHFHdZYKilj7kNtehXSj1w7zJbTwG3o/4aiCpDXxYNv8Cs5cnzmVXejuKlcUPxvzRHRML0SspmsPP+4+kO3ctrsk+rQGp+t9t3TV8t4AtN5/Q7Djk0ahLKUqh6PIqx2W9CZRm2nBs1rBovZct5ucwmEtiYsOT08Ud8SevRJAsGSH+70Ln6AoRUcyQLJ8dYcHDVx0qqoQQRVb/J3yXZtUDU5rsZncsMVuXBNTWcL4xAl7AxZiJ49RVhgpa06l1dKH+uzCb9rTB9bbKC+zUpwNS8uc1AEq5ZbGM6RDV3nL37rP/TX7MSKTGLOr3kYSlEn3etdB7JJLPi0Efadae0Knb5ynUtezVrjn8x/KTiLAXtr/Hb07z/tXQ0lfi2U0G0eHWYx5Fm525worbBA21rWjEgsi9C0BRvyPBnJ58s6Q0F2jwMqdzYJq3zuCNoxxTpMpwF/B9Y1t8jY5yLgsCuufVlXB7zMczurUynaQ/z8BaAMymCJU8rVnfxN97WCbQyJ77z/dHILaMbotwuZmrcsVi2PDhTT6XhZMPoUp/pWeOMAlWesp228WN36TpO0Ij3XENY34uzQJ3w/Qcu1LmDhqBKGcsUMM8Qh93+FYT7Czyyb30kOf541lHczUYf3ZawjEL8IgRBdU5UBNfMpCYLcYi34LndF07czOeJP39SZt30HoOVmkEc8FFGFl5E7JO1wtRZB1Lc5FwsrNVzld8tA==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bYTA9O+4GybPWTzDFPffRQ0W8JNVox6OeS9JNTnkLCFvfMEY/YMaAPIrwYg63hRU7QMX5g/8r4hfKpV2hzvwlN3ae3pVT5xqbUVbCN7sASRktigWL6tZOsMlE0YqaZQmuGyOJ5ZXQdkdzoD4GstUKa3Ri9YMdSyzYw7y+oMoZrX4JFTeb03qPsEuUBFyKsZn/NMt24+RBM10nB2zX8LrVrYV9KEffq5GqmlSwqHnc+OWC/7SFCFtk8LgL7hTmkE2xQjWH15ZacaXzrpu5zmJ3xMODym7pCTz+qRHlvehdS+b6ThW5+luzrrpANTbCb5vCrp79x+prQqMOIIWc/SdhqCaQ5CTsT6sIG2Pn5DnY3jPLhjL5yUwgL+LMp42kIVRJM142Q6HgQi7FHIUlXiZCMn4VKF//kkZ5jwFycrtnjvv5z+KBkUtutZYqoDcbwxj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 18:41:19.0245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31c438a-a6c9-4e3b-429d-08de7e0b742b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Mon, Mar 09, 2026 at 11:04:31AM -0700, Shameer Kolothum Thodi wrote:
> > > The VI_VCMDQ register ranges are an alias of the global VCMDQ registers
> > > and are only meaningful when a VCMDQ is mapped to a VINTF via ioctl
> > > IOMMU_HW_QUEUE_ALLOC.

> > If the guest detects he can use a single VMCDQs (I guess he can
> > introspect this by reading the SMMU_CMDQ_PARAM_0) how does he know if
> > he
> > shall access your so-called "Global VCMD regs" at 0x10000 or VI0 regs
> > (0x30000-40000). How does the guest know that he is supposed to use VI0?
> 
> The CMDQ registers can be accessed via both the so called "Global VCMDQ registers 
> Page0" and by "VINTF logical VCMDQ registers Page 0". And they are aliased.
> 
> The difference being(from Nicolin's explanation here[0]):
> 
> "
> The global page0 is programmable at any time so long as CMDQV_EN
> is enabled.
> 
> The logical page0 is programmable only when SW allocates and maps
> global vcmdq(s) to a VINTF. "logical" also means "local" to that
> VINTF.
> ".
> 
> IIUC, for now a Linux Guest kernel will only use "VINTF logical VCMDQ
> registers Page 0". 

Yes.

> The question is whether QEMU should also support accesses via the
> "Global VCMDQ registers Page 0" if some other guest implementation
> chooses to use that path.

Yes.

The point is that we can't reject guest's access to the global MMIO
space. So, QEMU has to support both. But guest OS is allowed to do a
partial map/alloc, so global MMIO page isn't identical to the VINTF
logical page in this case.

In an extreme corner case, guest OS might try to enable a VCMDQ via
the global MMIO space, though the vcmdq isn't allocated/mapped to a
VINTF. QEMU should still allow these MMIOs but does not essentially
make the vcmdq functional, since this would be "unpredictable" in a
physical HW situation.

Maybe we should elaborate these in the commit message.

Nicolin

> @Nicolin, please correct me if that assumption is not right.


