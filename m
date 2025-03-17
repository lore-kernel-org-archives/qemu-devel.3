Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3127DC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuF4x-0000SC-Gb; Mon, 17 Mar 2025 14:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuF4e-0000Q3-KM; Mon, 17 Mar 2025 14:20:29 -0400
Received: from mail-bn7nam10on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2009::605]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuF4X-0003sG-Hq; Mon, 17 Mar 2025 14:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwnL44u+M90yrdkgEhOT35L/R8AuKUZUHpNyg2zt5mS2ay+PW8JzxvZHGsMbwZEnBNzmlQ8DWKSeprMGA+J6/tvZjpCEt1qjDIeBAkzdVJwVprqL7PZF4b6cZr/j6+LpZQ247D8shYoM5LTNr1v+iy14pFFpSgl0EFy2gp/lRf+XWlDHSjZHSjZyCxzpOw141BojTstvwwMWtN+WN+v9ezxmwa9q/BwpHhIGso+GhiincQHYuA9TcfxexEM4YXvR/CO27+HzbUsBQO/ePlmu88ruzdniFvQMa6TMpdV+4Y1us7RYs0fzg9VxUhh6JClp+8+tGlGn16VR81SrM9KoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wVWEfzxvDbtNxkCzjZInmIfQBd6XLsYJ82+x+gT86A=;
 b=lvRVEBcH47nXi+JHcxlp93frGh89B5GMevoY4/liEw4XLnwovFvdyMJ6K7t2cqmnuMYUJVKyB+v5wFw4Qz1Ll/BTbzO1NG5njnkxq9zxaAJQuwbZ+oeQCKvDzXvuKjdgnIgbCkPY2mRqV2tQxNseHHjER+D+TbaZTnPUiypLDUHRbN41R9nuLo9rRh7sEd+xNekUEr/Jy4WcawNMvn0Rn4ams/2Zzd2wwDBx21G5L8/P0ckEDucQZia2Cd0yUiPlk7kAEEisxxrQ/9H4igpPgD0AWSutokqMgsY8xv1C+NYMyuOX4DUV1IxVobUJKRJq+fHZCfebGOLOVW8HjaEOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wVWEfzxvDbtNxkCzjZInmIfQBd6XLsYJ82+x+gT86A=;
 b=HdZToOFb+Z37wWw9Iymxf+56FkKeXnc211Cll8g6ue627OPhtNZ8STezRQHhyMZdXWncyhGd39ot3MQfohoP4lJYTjtpytGQsiNsfy+OGA0bTcOzTECn4wL3/PLxfd1cd23fYdk6Pn3ZcKBVPKGR83ZQDaZ5/QgDMjhEVnoxrgBwDTwjX18YubVsY4XrQ0SI+9caG8fD3cFcz57UOLn0g88lQvqlUQHjflF8XRzogDvx60nM+YCpN+lNLkIUKlx0C/GKJIfF84Oj2KIdV+hxtjGqMpKokFUravt4cB/I05DXtQby301qM7Kfswm2R4NEitwTPrurIsLUk96jZ1jfaA==
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 18:20:13 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::93) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 18:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 18:20:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 11:19:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 11:19:50 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 11:19:49 -0700
Date: Mon, 17 Mar 2025 11:19:47 -0700
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
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Message-ID: <Z9hnwzCEqdfSOsRe@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
 <Z9CmE2oc55lxzW+q@Asurada-Nvidia>
 <8fbdb07be20a43bf8281143720a0c10e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8fbdb07be20a43bf8281143720a0c10e@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df97b67-884b-4763-5235-08dd65805b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5QclQRu0zAHLTzkMVjLAqmE0kRPJdcpOCewrlhdBc3n4EWrRvIGvwvEkUoEf?=
 =?us-ascii?Q?MSniIMhEVb1uKegjE8B89EnhzoYGQzT30NRJCvDszyaUKubT00y4EoJgDmfM?=
 =?us-ascii?Q?d+tNMRQsp7IvkajKdl2Scspp9DmSL1DVXKpx1hi2y2xlnC3l8Uxw+JRFV4n/?=
 =?us-ascii?Q?ssn7/NDUeQ6oLs/nsVdruRbawmqX9mpv/YxTAFNaPfSmY8BT0TujhESaQehi?=
 =?us-ascii?Q?rArS8qlDvJH7MyBFb9k/3HnMOZYs9x5Ru+DexoZoPm5UYtvcnb6jZUa9UY9T?=
 =?us-ascii?Q?mDq8i6qFoevbgfTQEfYOXP3QilwNx3StTHZWFkrL5vhS3DZq6DJB1cLHXKzZ?=
 =?us-ascii?Q?eZUwGT0c4b0oUDU0dRFPiKRO0lbwaeX6NBI+YvkATfuxttR3G2SLet62W/om?=
 =?us-ascii?Q?JBRjqHdg9fHng8Yofeg0KjrfNgXk+DoX9NsO/XS+f6s7qlWXgRkfx8QlAd7H?=
 =?us-ascii?Q?XOgRYnMreZYJmnbPYNWsJ7+12Ceaw7Kya1rx0bfL9o4FAjrkvtqONghVdaYu?=
 =?us-ascii?Q?zgSntKu2+1sya3U7EtK9TmZdZ90jL438WyuRkJ7YLF3UiLc9Wnoq6dhfSM+z?=
 =?us-ascii?Q?nt1hpB7M1FWkHpzIYMT24WvcDpd++wydv3MCEaEUnRsVO5TM7t1/5yyn26+h?=
 =?us-ascii?Q?qW3NHCYc4e5lhw96SJzDB0UCnHaJ7eWjjXxzou7lfhVNisnYSp2NQaxGbhTs?=
 =?us-ascii?Q?C4LIJBLtN5/Iiiur9mVoDqmhCyljyi+Ct0FHYBNka2LQpyi2Pbu2OLsgwYaS?=
 =?us-ascii?Q?a+Vqc+plbGpVHO5Ix7IPMN/wgRZoQEhdv6JJs635vVYCscVdiMcVPKdgzbc/?=
 =?us-ascii?Q?AKd0vQSlJXdG59Qg58hcgrjwTwP28rGbMhat9W/5qYVpXaTRP5kh1qof0Zcl?=
 =?us-ascii?Q?asUHMW7UHVyWFDMS929/W3Nl23nAIz2Y3P/zWkaIqFJQD+DduMYVRqmWTGiI?=
 =?us-ascii?Q?OANzYFKIjy6VsapHJdsAc/9K2XMtI+LNPaiA+O3T5LdMRJkEBpTQSXCRae6d?=
 =?us-ascii?Q?uZ642ZQpYp6RDWBfJ/PhG10VJne4n+8MuZuomAap/GsGJeVZmY3+S6BzFbz8?=
 =?us-ascii?Q?m5wj4yYUHJGC0gG7lsa6+L+ej2G8DJmqSe54ygi9WZ+kJctaD4xcGqA5EEQL?=
 =?us-ascii?Q?Ggdwekax+zrShFC81QY4SDVyQKCIFmlpiukQOeHRlLuN8qldsjFlS5Uqqpuj?=
 =?us-ascii?Q?youIZtqJXptuwT2coFOvw2riY6kv089WDJuJ83qNRpJRtBdlANwKSRh+IuDH?=
 =?us-ascii?Q?RAZ1xtWj4FZxzCBMxz3RRRuMEnBoxeD5J814pSHA290BKYKLdGBWuErX9V20?=
 =?us-ascii?Q?Eoue8oQN9ai7pEMnG85uLmYeWmP5yNp/RuKMPUdmmNoamUrNClVY0sIngS3o?=
 =?us-ascii?Q?GkUsyEFLltLV/ZxT0VUXcjIJWOdPiM3fFfHDF+17ApfqFMyx+dLjPnCnP97W?=
 =?us-ascii?Q?2ND96BdI8m9mHNYunvXsVdv5wBMoLU7VkzeUJwwSiBUMsI9JLeSWsP25yAFf?=
 =?us-ascii?Q?JxTpUl4By0+blYLp9k9HCexmsGDwmuZKWzgw?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:20:11.9011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df97b67-884b-4763-5235-08dd65805b68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
Received-SPF: permerror client-ip=2a01:111:f403:2009::605;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 08:38:23AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Nicolin,
> 
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, March 11, 2025 9:08 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> > ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> > mochs@nvidia.com; smostafa@google.com; Linuxarm
> > <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
> > set/unset_iommu_device callback
> > 
> > On Tue, Mar 11, 2025 at 02:10:34PM +0000, Shameer Kolothum wrote:
> > > @@ -30,6 +32,185 @@ static SMMUv3AccelDevice
> > *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
> > >      return accel_dev;
> > >  }
> > >
> > > +static bool
> > > +smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
> > > +                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> > 
> > With vEVENTQ v9, vDEVICE (vSID) is required to attach a device
> > to a proxy NESTED hwpt (applicable to bypass/abort HWPTs too).
> > So, host_iommu_device_iommufd_attach_hwpt() would fail in this
> > function because vSID isn't ready at this stage. So all those
> > calls should be moved out of the function, then this should be
> > likely "smmuv3_accel_dev_alloc_viommu"?
> > 
> > That being said, I don't know when QEMU actually prepare a BDF
> > number for a vfio-pci device. The only place that I see it is
> > ready is at guest-level SMMU installing the Stream Table, i.e.
> > in smmuv3_accel_install_nested_ste().

> > > +    /*
> > > +     * Attach the bypass STE which means S1 bypass and S2 translate.
> > > +     * This is to make sure that the vIOMMU object is now associated
> > > +     * with the device and has this STE installed in the host SMMUV3.
> > > +     */
> > > +    if (!host_iommu_device_iommufd_attach_hwpt(
> > > +                idev, viommu->bypass_hwpt_id, errp)) {
> > > +        error_report("failed to attach the bypass pagetable");
> > > +        goto free_bypass_hwpt;
> > > +    }
> > 
> > Ditto. We have to postpone this until vdevice is allocated.
> 
> Ok.  I will take a look based on the  vEVENTQ v9 series.
> I guess this Qemu branch of yours is a more representative of the changes described
> above?
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v9/

Yes. 

Mainly this change:
https://github.com/nicolinc/qemu/commit/d8f496eaf528f1c397f2374a999b8b23fd55c75b

Thanks
Nicolin

