Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71706C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 19:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txA2c-0002m1-FN; Tue, 25 Mar 2025 15:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txA2a-0002ll-Eg; Tue, 25 Mar 2025 15:34:24 -0400
Received: from mail-dm6nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2417::602]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txA2Y-0007gc-5o; Tue, 25 Mar 2025 15:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxqce/kE4ARGcskG9wYPVULYwZ49J8K+cYMGwkd07NLdQXhD5yPJLBcDBpnS9a/gAb3g0Lj6Ag+mj46IlxIRy6c4ExLASj+TV9V60FYUA/PzOSVdYd1sdOxfuo6WLaNY3xAc329aWV6n6vQPrJP6NoJLqUBW8Fxtp7pMirmpW4MLKKNNr/FVcoMS3kFE8u8JSpQ36oy5IrI2n/+Th/DQj3Ok26YtSfEUphlav1sEpku2j8vYLdUyqXgup9ki7CApb6keWTSnD1jmBivKmZq/ar3Tn24KgUrKrH3INFqfNj+fpa+tfEjfYv5Q+i1MDATLz3/u5Oe7SP9L7Gt253qqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7gNEZfHGx2ubcaFQX3iUJvaOmdLa6wDhAYYAhYQPzA=;
 b=VkNImaPKK0jixX8+TK6C5SVP5TdRlG6dWS2b0CGFqsBesXPh1XMdX5WB94HPkxMdiJOAIcVq1Y8BI5JrmNAEN7bcOrDLcFiGX/qWP3di/VFDtkmKEblM95kI4K93Q0dPP6iYEETgI4k6aqf2pSwMwVF9IMEi24vYadtUjipgDh7xjESMTcjZGLb3OLW7DXzAhjXY1ey3ZfmbWR6+GYSdiuwFw08ARyX6dUNaPw1CnSlVn/C6rcKVpZVQNG/TSWhilaDcr05OaoTxw+eTCUivWWDUZVckwYZ5jX6YKQgdTlbSkwYvYCljJZ/WdCTwDz4N7e65hTV60GK4Hn/uHP98TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7gNEZfHGx2ubcaFQX3iUJvaOmdLa6wDhAYYAhYQPzA=;
 b=i6/NIuQHUTrMwxZuaunszU2mr0OLzBZfGX0rXXnq+pPFfh71QC5jDRN9XrvhhdTvpjYnBc+FgDsDXXBEbARu4n93CoqdDqtDxXxqFj10WFIdf7mPoi8j601Y/pxmFMo+U8BinAxNjyseCtXG/ZtC3CS3YyYdkzLj3AwLmR0MFJmcPoLVLtgsqnPDykttlseaGMZvhA9FInwzYLjUc7ObLYax9SfEGTTNayx/Rj/Byr6xFGA9ibj16/x7tMmFrRFVU2bZznknoQbD4UHujtK7AHN6kjxEWhxWQ+uKxN60WMM3dtTXbyAEQ6mioq8ANXmpczm/odf/dnR5sT+McPwqxw==
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 19:34:14 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::4d) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 19:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 19:34:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Mar
 2025 12:34:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Mar
 2025 12:34:00 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Mar 2025 12:33:57 -0700
Date: Tue, 25 Mar 2025 12:33:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 10/20] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Message-ID: <Z+MFIxMpuI7MvGPu@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-11-shameerali.kolothum.thodi@huawei.com>
 <4333965f-f5bc-412f-ae23-46544d7dc919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4333965f-f5bc-412f-ae23-46544d7dc919@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a66fa2-f677-4c4f-0ad2-08dd6bd40674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uagx+n4PfYlICDHBdQHxu18lGObmANlOA2KBqGgElJ+CnUkD9Ry8rQH04ANi?=
 =?us-ascii?Q?wCqgxWgB7sg6jaB3EAcsjGRJSeGCJRdMw7zzQUUB1yPIhlrsrJPLobjY8X/B?=
 =?us-ascii?Q?au0ZMGFSMKqrXdZdWGFDnWGIL7EBf0Psn+MGQY/8ID0GJCJAm0vvopTMKigU?=
 =?us-ascii?Q?CFH2hnzDunA0f/iG7Wjtp5TvwF9cMnqlIAKjHyW4VUeWOwa89SLBiv0P1sV+?=
 =?us-ascii?Q?CcQyCVRWxk2pvOAYS6BA99Yr/QHEHx3Anm3zz8XquJAPmFAA81G6Zgb7Wxvu?=
 =?us-ascii?Q?bNut8QoOTa0tXTdXhQEelM2d5m6LGHkp6OydAkyGjJCSEqi3Ya65bVYfozZo?=
 =?us-ascii?Q?CRWcmRA3TqN0WLlLtShDErbUDosHZ+qVYa4MOtDT0FTJCiXuhS0o3cYK2pcB?=
 =?us-ascii?Q?8ceKFjLnKtpGK7bojqA3cuVl/dtx9ld0uYf5ZVg5H2l6kx5NBWsMkwF8buEm?=
 =?us-ascii?Q?lz1mFtf34nx4MnjI/191/jsHwyljnv2Tse8ECNDxGXjdro654+lkgEdfTR0K?=
 =?us-ascii?Q?8D2xbnUrl47m7riHNrFnUySf0COFDTIh4/ECZOydW2ydw8AITwgdPxaUhJd1?=
 =?us-ascii?Q?2tMFmsFeFtmugCguRYsaCSYshIglcwcyShkZI+kTrY9mqcgo04kVvy4LcYL0?=
 =?us-ascii?Q?hjRpsUH8e4HQfZb7hkUZJoxJ1IhUaqnLUxmWsYLYzHOkseVkhZwuqa29ACP/?=
 =?us-ascii?Q?mXSF8oVq1/EZzP1df8dudBfphsJ+R5Z7JBghLPu3SX2BaVHTTC3KlbVFsRF3?=
 =?us-ascii?Q?GZ9ij8G2YinE7fyAPEaozvNXmr3xTFpiXqItsi7Crg9yG3WdxqR/+ZoEnr0i?=
 =?us-ascii?Q?zdl+s4vx3jNOTSlmVE2c4kQmEH8VmG5i22OHZgTG9UVpi47XRH1iJcnpSuiW?=
 =?us-ascii?Q?KVByWljntDHuhP/w5ccm6FGahlzn8obW7jn44PP+zl/XX5X6d+eUyp31UBVI?=
 =?us-ascii?Q?xZjM+g4BnD/+RBXDAWC6SmC9CKMpAk/sSD3iCU45/e3Z87tlvL+yvimFhAwZ?=
 =?us-ascii?Q?W8TGr/qTGP/M2rTHWLWx25LBxLYAgkhyj4RbxljgRbdvv9pJnZjgTQKFNYz+?=
 =?us-ascii?Q?5jkrnF+myAmseYah0fJGpDQWXd8T/NJ/g7KjL4syX6+lxsgiE2Z0Q4XjIZSA?=
 =?us-ascii?Q?0pD12lC227JLVGurwSwQo+YmNp/GAq4cpvaPMzFnBIy7zgfFt5viyctrJWWk?=
 =?us-ascii?Q?eo0pP2MKNWSh0ljOLJ+NzlNVT3D2RICfBXRL/BlaNFEypvo/Up1ss62J8Eno?=
 =?us-ascii?Q?CEZ9xGRqBD1e2aMIp/nIFOxC9mTR0iRufFsDOFjw6u7QNalqaHKvIrtjCRBp?=
 =?us-ascii?Q?TdK1wJ/Te+slCbe4Qy5XcuxxYvhe11xcWxbjSj8mOToGbdMD+95UqtES/wxI?=
 =?us-ascii?Q?OtexcWPQ9n7PVDzCY4HxKedoPqGI5UVBjSkxZCImJrF9fpQBwD3VHvS8657L?=
 =?us-ascii?Q?9R9OGYlKbEbsDHHleFKBKMov3I/1NCp3joExVdlP89otuwDd0+hKUNDl388A?=
 =?us-ascii?Q?iYIEkR+d/8lts0U=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:34:14.0266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a66fa2-f677-4c4f-0ad2-08dd6bd40674
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
Received-SPF: permerror client-ip=2a01:111:f403:2417::602;
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

On Tue, Mar 25, 2025 at 07:08:29PM +0100, Eric Auger wrote:
> > +static int
> > +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> > +                                    uint32_t data_type, uint32_t data_len,
> > +                                    void *data)
> > +{
> > +    SMMUViommu *viommu = accel_dev->viommu;
> > +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> > +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> > +
> > +    if (!idev || !viommu) {
> > +        return -ENOENT;
> > +    }
> > +
> > +    if (s1_hwpt) {
> > +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, false);

> why do you choose abort = false?

There is no particular reason. This is in the way where guest is
updating the STE. So we want to stage the device somewhere as its
default stage. Maybe ABORT could be a better place? I didn't give
this a deeper thought, to be honest. Good question :)

> > +    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
> > +    if (ret) {
> > +        /*
> > +         * For a 2-level Stream Table, the level-2 table might not be ready
> > +         * until the device gets inserted to the stream table. Ignore this.
> > +         */

> I am confused by the above comment. Please can you describe the
> circumstances when this happens and why this should be an error

I added this since one of the early versions, and I don't recall
what was going on exactly... likely I saw smmu_find_ste() return
an error at that time when guest OS boots with Stream Table init,
yet later it installed the stage-1 STE and then smmu_find_ste()
started to return STE.

I think we can drop this comments, until we hit this again.

> > +        return;
> > +    }
> > +
> > +    config = STE_CONFIG(&ste);
> > +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {

> you fully bypass the logic of smmuv3_get_config/decode_config. Couldn't
> you reuse it. Originally we used the s1ctxptr and disabled/bypassed info.

We likely can, though we don't need the CD part in decode_config
so we might need to split those functions to reuse.

Thanks
Nicolin

