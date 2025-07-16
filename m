Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F3C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc71K-0006Sd-PZ; Wed, 16 Jul 2025 14:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc70o-00069Q-L5; Wed, 16 Jul 2025 14:37:50 -0400
Received: from mail-mw2nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2412::606]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uc70l-0003Wm-TL; Wed, 16 Jul 2025 14:37:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuPDxhFVCuEFb6BHY0+sitLXosj9dAoeZe9OpHLyBmY/j1p+6Ghy/n6L3FpvXj7G4ho1CBzL8Ig8FuaCsu7Emb3eOEGMNU+7iVmPa6QszTz6Ll56rM6OXmTEBAWX9MdOfNB7QlJ07KHP9LajjXss/eoDv+mln9V+7xCf5sJ26i+GrME2tnTpsyPOt8gWCH1/L7QirP719+WcL0/t5Be4xFCZr0sWhbdRDlupMgtIcLScv2DP/WvgIHesmeODaxdWmeTLZp3nxzH1OgnT3QnnKkEdu37xsH7nVuF9toUWgD9SIIcWAhsVZVE4SvDp3mQB6wyNS1UYU6tzI5R2HGimDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzjoZi35nAzVZxvyvT96ZDvWSXXGGfCp0+i3km0kfcg=;
 b=jUYUnNFs0UddPnr1zW2vxXeQFGYYVOkYc+fNYuB1kiTD0E/XKY0mO3P67SLCItxLWGcusDWo3FCsoNVT7cjWVuMJw4ZE/MtRo/E7ZFYdh7CvXx84XdeH4rxXuCmQ32UGUFV4lLbWyq2j1PBRk/fmYF7tOPAyvpPTu3ygH3luJmsFVFmbkSKAjBtyTuOSumgGGDJev24rPtnzm8hxfdHBOD60FWZ22976/IVQsb8K1q+P8ezFO/KOXQNNXjlnyYX7DAEqVARu/UhMOWpw2CBvqdMUnbQYANwk01l4LmIv6Hpl2cbZWOzQ4Vgc5SfQZ7basufHXQ1Hg9EA2nFYzOoZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzjoZi35nAzVZxvyvT96ZDvWSXXGGfCp0+i3km0kfcg=;
 b=UxJ5SShTgxMtA/OtRouluuGE+Kf1mcpOGeCyD1MURecWJvVCIqnDuoPa0MzAWG2VWpD7SLoEdxD7dZGNP41zSGOrWTZoMvoXv8t2K/6Ea1qzm0H+0V23oGrxETzuDoOOE7Y6He3FoEluZi26zE1J5QZnTxFj7834TCjLPfr+qeYcZUiTc479utgWNFzggEODHpiGdyin6l85LNS8a12spjAgySSZBzY3mxCPaDW2vdbVb0uryN8RAzDVHrXV2hl3qvq4j4Xc8McYU8ek/JJU/PyMA5/loKNVyvSb5THRxNwY7R86ARoqDfw7THxpb/m+LR4eFDjtxuix7g1XgcpmnA==
Received: from DS2PEPF00004566.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::508) by IA1PR12MB6652.namprd12.prod.outlook.com
 (2603:10b6:208:38a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 18:37:38 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:2c:400:0:1002:0:5) by DS2PEPF00004566.outlook.office365.com
 (2603:10b6:f:fc00::508) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Wed,
 16 Jul 2025 18:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 18:37:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 11:37:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 11:37:24 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 11:37:23 -0700
Date: Wed, 16 Jul 2025 11:37:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHfxYbPLoiZvWlNZ@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
 <d3396db488164f558aeafafd151aa7ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3396db488164f558aeafafd151aa7ee@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 4115697e-3b9b-4d51-20dd-08ddc497d651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GbqSmipJFNar9xz13U4yIIGe9N4enfxeWLNWjZVHvkSKm9dom1QBaAtpCvl8?=
 =?us-ascii?Q?GKtZXFw/pCckQwQrvInNncsBsCka1ux8gyJLEARAGavfhuVd8n/CmsAD7+Uh?=
 =?us-ascii?Q?fS9tYKG8s8ej+mAvd+0G/9yRBwUEynFcKsRzMaWD+t7AlIMekAoO5c13We+M?=
 =?us-ascii?Q?YHdfBjaKzv2FbGOj+k4BCu7nmo3O8sFJEChWH0wWcbFoLWX4zpYIibi3lDsN?=
 =?us-ascii?Q?Kf6Ei4hjlRNTuJEMr2n63QAK5phngV11gJ7HgltyVv+uB+19zJeXanSgFqi/?=
 =?us-ascii?Q?0kSsbWM3A027+6RIDYvWQjS+EPKPbygQ0jbfsZmrZ7/V79sr2DM/chxP/igq?=
 =?us-ascii?Q?ydhsSf9LS2rdggult1WjS9bb2JZB2dOAysRQWjzmsT7H2SzQcDTahb6ZD/gI?=
 =?us-ascii?Q?/mJi9lSu5R3kIs4N71B3K1tisGq0nGlg3XzINPb185CUzTcmXQrDMr2I0ajA?=
 =?us-ascii?Q?a7w87t3vk4TZKAeEg/1RzRi7olLpODFw7LJqDd2oU4eAcD53CJ2+nynib5l1?=
 =?us-ascii?Q?bre1EJrtNOyoQWJ0E+qoaubiCws9nf/kuFyp9PDlGbRf/M/+ytGKU0FOAGDt?=
 =?us-ascii?Q?F4jyA4VIJ2d6jYNlbnVAEWizXFskU1hAUhX2QUNgxou6YSGCZVYH5XT6LjqA?=
 =?us-ascii?Q?6JdUgLFnYfJOBSqEgqGRPXgrnRVxt9NBRlRVSf2emq7WO/Mx5uEwLGNwMl3G?=
 =?us-ascii?Q?ql41lKYd0vetlPrQrQkhTK3u1Xq8hTJOsHu4gGzL6DrH8Ir9Y9eedmek0RC+?=
 =?us-ascii?Q?7TjK3yKn1AaSVLbVcu6eJe8nT1v+aUAwIkioaXTC3iBVd6Hltcok+vs1X//Q?=
 =?us-ascii?Q?pk3doEBak47vwX5n4zDYFVlBO186d1tqqd/ri86QTUfsPIN+VsXjiIwyFfh6?=
 =?us-ascii?Q?0sgxYuQ0WINMAAvy/Qm8RfiljDHPTMAk5Ga4hD36+P8hrlegVdtpiCY2v8vj?=
 =?us-ascii?Q?SR66iD6SQ1EWMDszs+bhrQWM3MD/5E756M1JJl3rcYgYHepeBndsmVkpix2r?=
 =?us-ascii?Q?dWwgZOoAgPyAUYopb+qokTNASwhT1Aq08v+m5jgv7sy7aBq+O9Tc2MFLf3oA?=
 =?us-ascii?Q?fIFKWaOVG0qwZ7PRa+TRk4c8PxJoIIFwNxMv8XBkWQ4n1XIpFzanDoZhvvQN?=
 =?us-ascii?Q?O8UHwrN6NHtAXXCtgj6d1UqFqzOUwj/tI8gAUgnhBoSaFefE2doyMXREOFd0?=
 =?us-ascii?Q?+9giXz/pokPRu0JAqLndaPhv1kQ20ldQDeBQEhSnv4mxAZlVkDHCNkGIgEzZ?=
 =?us-ascii?Q?5dSRszRnWJOMeQY5QW4cTB8nxncZuRvSdBwYTdjPI6a7lR/U3KstDMZRcVPO?=
 =?us-ascii?Q?wcjLTZka7RfUT38T5BJJ8Y5Iw62Iqx3ZOoYnvCH8Cw1Vmn05muxui5EHFNM9?=
 =?us-ascii?Q?sQLLPAVfulOsl0k+voOKTNna8jssb3HCtQXx2AAPTBtYU9NBX94quseen0W2?=
 =?us-ascii?Q?atJugTjGetO51BiKgbk8vMgL/EchO8NoPx3AXU/pgYjN+7N+CrjMcok2Xgoh?=
 =?us-ascii?Q?/mH8d5oBFKe9LBU+y8cHkwYoowqtgvaRMAD0?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:37:36.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4115697e-3b9b-4d51-20dd-08ddc497d651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
Received-SPF: permerror client-ip=2a01:111:f403:2412::606;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 10:26:21AM +0000, Shameerali Kolothum Thodi wrote:
> > On Mon, Jul 14, 2025 at 04:59:40PM +0100, Shameer Kolothum wrote:
> > My vSMMU didn't work until I added entries like SIDSIZE, SSIDSIZE,
> > TERM_MODEL, STALL_MODEL, and RIL.
> 
> How come your vSMMU not working? Or you meant the assigned
> dev is not working?

The "dev" (behind the vSMMU) running in the guest I mean.

> The emulation supports SIDSIZE = 16 and RIL. Could you please
> share the difference between these values w.r.t host SMMUv3.

My hardware doesn't support RIL while the VMM sets RIL.

There are other conflicts like STALL_MODEL that affected
the final two-stage STE in the host too.

> Probably we should take a look at Intel vtd implementation mentioned
> by Zhenzhong in the other thread where it looks like there seems to be
> a property for each capability they care about.
> 
> Probably something like,
> -device arm-smmuv3,accel=on,pasid_cap=on,
> 
> And then enabling all features related to pasid and on later when
> we retrieve the HW_INFO on device plug, compare and fail if not?
> 
> But I think on ARM, we still we have limitations in knowing the actual
> host supported features through IDR. In that case, we can only assume
> that user is making an informed decision while enabling these features.

Yes, I think you are right about this approach.

Maybe a "subversion" parameter could mask away quite a few bits
like RIL BBML. But the tricky thing is that user might want a
customization to those individual bits, because it has to match
with the HW values to use the device correctly.

Thanks
Nicolin

