Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713EEC02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 00:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfSya-0004Fc-Pn; Tue, 04 Feb 2025 19:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tfSyX-0004FB-GV; Tue, 04 Feb 2025 19:09:05 -0500
Received: from mail-mw2nam10on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tfSyV-0005du-3S; Tue, 04 Feb 2025 19:09:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjb3dpmMugtWSV3ziG2Nv/PV4pEwGYT16cr/KRjdp767BGo49SBq/HxPFUJrm9EG+uWHtN+PZJUxyQvwtq9H4LSAnWSgtszF0ejJwjl7eGaAbX++1M5bZ5KR9IFr9VIWrWN289CtvblnfcdKeCDGW4VRINxz2fQ2iXEIFzi+Z4epbAQ4PyLBy8CD4cuGFq2Z2USHeqmIAp1/ktgQyqXAWQBsDW8avk6Q+WQFQJbTpMkEewp7LEJb1c0Py/tbDaLtQMBRinwWgTHTSXLLy71qWgzg6hN5r5+yDXd+m1YtvChdRnXg9X1HqDSAVaE5U/trRmjLGT/qGLSghvaGzcb42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j76u0etjnof+d43BgxQez9qy2Szyve4yF1y3S8iZ8SI=;
 b=VingeBMDaM8RmR+Zz8YQjGmOUvOZ9FllH7tbFA6bjTVJa8a6S84bGz5RRE2pnQUWnI7JqkwhZhY1vMH4kS7TXBj+j2FyBbfFqrYY8uGnKH61LCMN0Ta1tApj+hK2GV8zqNPzU3rd+iADIzVxtsTAydP45DcuVCIla9jENOWcF4cxPip1xXY2PLdLWMaFthCjSCREUtm4ktv4SKpAUlkrdhUltmWjWgTpf3UeD8Q5UVOZ6t1K+9Wpd3Jr0u387Hgjft5hav3lazc//untsftkMD7xKfnHzu+x9fZpMFuMSL5eEdrmaVctFLVy0XhQFaFVyFgjSpbmmku8Jq3gtwcT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j76u0etjnof+d43BgxQez9qy2Szyve4yF1y3S8iZ8SI=;
 b=dk2TuMXkgpyhAnERWHiQjSjhYozkwO/pj8eSEM0gUuRIOHKrAD9+7psR8zfD1mL2yUZH1JFSiWYnU+PwXAV9xcsPlPj+AsKJnP4mvQ69KVQaXQl88S8cev4bYefaI5sbRwHAXGt3N6r8c8NC+0s0eor1Eowt37TwibnKSlsfipBHKyCDdw2532kK3AiqeHLwm+EmlkwSz0VyY1YsOHZoUin68WqrZHVaiagi7dAPGSkUOyfsuzv8MteIxnbfjcLSRdkEi+dGEG5S9zvduquG+gpahZHuwry1AdyOvDV2M0F5/BF4bsGiQjg2hbhTvZzUTzlFLnhlA7yuQPhkMhBZMA==
Received: from PH7P220CA0131.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::33)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 00:08:53 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::d3) by PH7P220CA0131.outlook.office365.com
 (2603:10b6:510:327::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 00:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 00:08:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 16:08:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 16:08:34 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Feb 2025 16:08:34 -0800
Date: Tue, 4 Feb 2025 16:08:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Eric
 Auger" <eric.auger@redhat.com>
CC: "ddutile@redhat.com" <ddutile@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 535cc197-6137-4e61-1f6d-08dd4579462d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PdVfn3qhQnkLFHi+MC5GGYBgyo85MqfvoWWs1B5jcIa7/74IHkzRtw/oXz6H?=
 =?us-ascii?Q?bVibJAzkaFjxPwU+8Sno3R+bqj3aYIiEXODCq8utFTcuQ1qYC31IVWizdxpk?=
 =?us-ascii?Q?A9fam5OALDJ4MiAylrdDJAUlQhwu8Ch2AEA5SurfjPeASUvjBYv6QnxD0mQI?=
 =?us-ascii?Q?drM88kKmi6ulDzFsvDdkqbmWXkYMK12J4Fx5hHpfzqOnelJjXIPpH1FtZQJ8?=
 =?us-ascii?Q?vergbIPGvcejk9UWEqYH4szgM/A55RA985OHHWKKzqEnm2b/rHHrjs2ioYdA?=
 =?us-ascii?Q?4d/q4tq69sg/w5z3C8qpeRVMEwaXlCPjImpmZVedqtLZBtd05u62E85+832t?=
 =?us-ascii?Q?g9I0Ru+Gj97Kzy9gDGrjTDBJsyB+4wmR15DT7dj20PUfLfvBvOUzUOCpIGvn?=
 =?us-ascii?Q?ZGpUdZgTIGuCItwK4UE5kUyThN+eTtYnsK/lXiRH2k7No7P/ssizMa1nuPTr?=
 =?us-ascii?Q?6CbhQqHwQXGVvRZ+6UPzBi0esd//IpsFxBkhUsetuKSoDV/H+57RiMEJ3ZJX?=
 =?us-ascii?Q?EbLXPLqYERN0DYhndAPtNTlXMo2BNInhfuPx1UyBZtv/ioCude4579fThPqZ?=
 =?us-ascii?Q?1edvRWrsHyXcwC9NtOejW+1SrIixVmmNtLSHGUVv11xk1Cf8NRdw2KU2R8jQ?=
 =?us-ascii?Q?EhXczH+DP81awslL7CtvSOc8EvYrid2EJ1TiyWUi/XlmsG+nIfMf4OGkyiAR?=
 =?us-ascii?Q?rNfSskRJnxEQU7jxV4pGd8JnBhj9coBbHEudRUCX23vY19CuV4J/JCu55h0s?=
 =?us-ascii?Q?y1DKihfAcGUohTX/xyxNt5DlzonnzjMoxHFhFR0IUe1olKmKAPt62eOGoNfw?=
 =?us-ascii?Q?/usaD63s+OZtVtOMJd6q3ZK/1cRwoYyInTkEeYjcKhsKm3+UcQtwD9pYvdPG?=
 =?us-ascii?Q?NlAEjks4MWl4PVPxk3U4UJjZlmAjXZ4i21AMiCN3Y3BhSZrp233Aj6iDaZCY?=
 =?us-ascii?Q?I1GJFm2OIKWE6IaKlMTMuQb0s+dd9e2GmuD2mGxRhE18JDl9jnHygwJRhdxY?=
 =?us-ascii?Q?uPfv+mGh7Mp1F3GPAPUx+5rjrJmQnMcv6IPjzRAswA4t57T7xTCI1ZS07dST?=
 =?us-ascii?Q?sp4rY6662eJVAYOYTj8+/VQ9OL2OgXx2DPvAskz5bmCJ+aO+rfj/RVgHm8y9?=
 =?us-ascii?Q?mI18CUs7w+C7v0Q0hUhhZuvqtrqNvEJephRD3rP2HzDLbxhKAstBR/TGnxMV?=
 =?us-ascii?Q?CCpduZSzn/Fwvwo5aOlOJ3Ezwa/iJOJWUVQ7TpWzQTOcyI4TkWnOxj8vJfT2?=
 =?us-ascii?Q?rNpUulb3mT+i0aV4y8zltQOyPDYWThZh/zJw1FO8mrUVA324S6/viCffIHM9?=
 =?us-ascii?Q?mEZcT2+9+yooF/xJTmcOv6SjjLCdlCEOZ1FcvPLMVvivna607nyERgmc1V1p?=
 =?us-ascii?Q?hr2l4xPeuR3NXyvUXpV3NHkL5fAny7iqo90EGzQyZKmUIz3c/4fTY3uDmiTV?=
 =?us-ascii?Q?/GUhCPS5bywcyb/7bJM2C0QaLrqdZ66yBrsxCFT34Xtbu2jwab778NMtAMfA?=
 =?us-ascii?Q?6Riltaej2tQGHWY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 00:08:52.6262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535cc197-6137-4e61-1f6d-08dd4579462d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
Received-SPF: softfail client-ip=2a01:111:f403:2412::62d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=0.499, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 04, 2025 at 06:49:15PM +0100, Eric Auger wrote:
> > In summary, we will have the following series:
> > 1) HWPT uAPI patches in backends/iommufd.c (Zhenzhong or Shameer)
> >    https://lore.kernel.org/qemu-devel/SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com/
> > 2) vIOMMU uAPI patches in backends/iommufd.c (I will rebase/send)

> for 1 and 2, are you taking about the "Add VIOMMU infrastructure support
> " series in Shameer's branch: private-smmuv3-nested-dev-rfc-v1.
> Sorry I may instead refer to NVidia or Intel's branch but I am not sure
> about the last ones.

That "vIOMMU infrastructure" is for 2, yes.

For 1, it's inside the Intel's series:
"cover-letter: intel_iommu: Enable stage-1 translation for passthrough device"

So, we need to extract them out and make it separately..

> > 3) vSMMUv3 patches for HW-acc/nesting (Hoping Don/you could take over)
> We can start sending it upstream assuming we have a decent test environment.
> 
> However in
> https://lore.kernel.org/all/329445b2f68a47269292aefb34584375@huawei.com/
> 
> Shameer suggested he may include it in his SMMU multi instance series.
> What do you both prefer?

Sure, I think it's good to include those patches, though I believe
we need to build a new shared branch as Shameer's branch might not
reflect the latest kernel uAPI header.

Here is a new branch on top of latest master tree (v9.2.50):
https://github.com/nicolinc/qemu/commits/wip/for_shameer_02042025

I took HWPT patches from Zhenzhong's series and rebased all related
changes from my tree. I did some sanity and it should work with RMR.

Shameer, would you please try this branch and then integrate your
series on top of the following series?
   cover-letter: Add HW accelerated nesting support for arm SMMUv3
   cover-letter: Add vIOMMU-based nesting infrastructure support
   cover-letter: Add HWPT-based nesting infrastructure support
Basically, just replace my old multi-instance series with yours, to
create a shared branch for all of us.

Eric, perhaps you can start to look at the these series. Even the
first two iommufd series are a bit of rough integrations :)

Thanks
Nicolin

