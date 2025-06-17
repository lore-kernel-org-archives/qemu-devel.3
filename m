Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D9C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYbJ-0003kY-2q; Tue, 17 Jun 2025 11:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uRYL1-0002D3-1a
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:04 -0400
Received: from mail-dm6nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2417::626]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uRW5y-0006JI-Gm
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:11:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE7gofAXy9iwwOnF5YQSQKA9xWlPnd3yp4ALcgUIaOZ5QC59nf/DPDy+vTCoaXgavGY/OdKsebjoVQwxMxQTwAMNRZua23uASRV795Z7G2m5ZVqEnKSzuvNxzIgOeibCYxIpcOKzJUtfyRL983Od9ZlV9a6CEhaSa8zmekAMcNf965hGQ5d6I+ggOc7dR9gkBdOlaWHjqhNEJ8SAnFkL7XZmdjlo1BrKm7N8kUy70qHVIMa0MyWXpEtqMcz3bLnTG50q0WYTgRy6+jOKprKaxOQ78z+ngm+MSrxZ9fdKjxyKD45rYGEpWL9k7MsSINfosJRcMGPDaJ/1uObXRb88aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vuc1WF5JuNerVVZtvnQwd1s/cMYbayWpQazJ/ldCGQo=;
 b=zSnmVDsq6LGNU83T26eusKmauSDNcEP1GQgn7RZzGiaXCTiVGalOApdSpljQcoXfsROuJqOgbmhuUlYQb/zb1Pmxvf/O8SMl8GoEW6m5bO6GHVVxOMbuGaNPhjbdd2EWwFge5YGZyxcAvY+5RneWK8AaFHYUhq7lVeIMAJJnAG6ajMbKst7dJdnNjyk/R5yrozZmNkgnRZoWz+i+dQh/61bBIXTqvhyyhHnXGPuN7IJX6+vkXoxuNwl/RvgneIs5AIyA3euzGKeoyETqbm+oHbfNxRVeU1+Iuhh+EjwkejsqpdNNyZQH8r7xb8gY5MTf0vtbs82yXEKwHMp+mKpUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vuc1WF5JuNerVVZtvnQwd1s/cMYbayWpQazJ/ldCGQo=;
 b=fBBCzk+W2GFMDnBPJmI0pDOitUBe6aM/Tfi1+WOhx5pQdFGh+K2DwUSvLOQfiENTYD9b+zqwfRENTPWHLF7Tvb6YPVhojhwsDO4KYdrJdWgieVlR/BaKu6pozqX3HU4WbiZ5orUlUeQJ2PhEw/NWTaE1RWXg2PwueOTpPmMY2AG+SHSHCa8yxxsyth8QntWOPQNt2NaD1xMg0xdGSvpdzjOoOIPCiEdWHEp8iMT43FW+kkHzKdq/vcBnstim+g+2qzy+sMasOzW/1xXR7dkU21sYBRVFjPhYRaiFtZJ4UGYYJzT4aOgRbhMRMLgiW/vfju7cFT+ZXMe8B44LNTodvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 13:11:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 13:11:15 +0000
Date: Tue, 17 Jun 2025 10:11:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <20250617131113.GX1174925@nvidia.com>
References: <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aFDdkxPODYnyG0Vo@nvidia.com> <20250617123707.GW1174925@nvidia.com>
 <de5baefb-515a-47e3-9e4b-16bca4dbec5e@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5baefb-515a-47e3-9e4b-16bca4dbec5e@intel.com>
X-ClientProxiedBy: YT4PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e473a3f-4bfb-4d0b-59e1-08ddada07075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b2TxsIk5G3+rcAvmgdKiPTyDUr5hXCPy4apxlKfH6K3fOjGohWuSTcAI5Lxb?=
 =?us-ascii?Q?+vKPngtslRebuVuCUG6b7jfwVi5+fyCAcUWWEFI+XzGcI0yz3EDq9jtaxrIs?=
 =?us-ascii?Q?I2y8X01d1oc+VQyD+l6NpumfU2AXXqeGrkF3VJxXJiuxUkseIwGNRIfIPOLc?=
 =?us-ascii?Q?m/VaVJXZ9jY1RTbw2gTprnsA2SFTjfzRZbogwbuKrWCNb8KMiyM6XNbWYVU+?=
 =?us-ascii?Q?5UkaeUn53PaCvspxoS70Qe5S9NJXDZffCXit5zzu9wOsmRwoR1UEBzRjM7xp?=
 =?us-ascii?Q?W1DBdkAhq7MyiH2cIK79oWv1BqftR49rxqFIuasiEtcluXGc/DWE1F/3uuGC?=
 =?us-ascii?Q?9E+vXDu9U8UsiK0sTdkRu8Dp4DbRqFc4r+of5Lkc+tFofiox6/DjxCAB/qDj?=
 =?us-ascii?Q?vqGoRXxFGANOz5BtLqFHVQYo03cfWR3D/ce/nh4Cm0H+20QLMPrcQdLO+/2O?=
 =?us-ascii?Q?P3mc48C6mpKVDeSZhqJ2yiiu0vk5MlEuE/oTYNqBl6ME0sL+d1D3eMc+m5Lj?=
 =?us-ascii?Q?nDuoMZt8GvR0x0pLphp/xl1Jt/HFc5DiPFkMlXeK8Vbv02CuEcqSTYZlXoye?=
 =?us-ascii?Q?w0Yb9OWJCT4DNKSsdSpE878t9OZ41g/RpCs2Yfb4YllLfocuBiGJhAj14goX?=
 =?us-ascii?Q?/cVfrGSHPG/fMxuTWgyHYQSO8OWNEGrEXdsmmcxMy6IPvyj0sCofLKw4xCja?=
 =?us-ascii?Q?5cLw3HjizpsehytwuEAQWo82z+xRJ57R4Lp9l57uhUvfBfIuOkYGjIVAqzoF?=
 =?us-ascii?Q?T26rfMHBZCc8H3Fjk/mJf1JCScnkMIK90SpjWkBr7kDD9218LL1Tekxpd3eK?=
 =?us-ascii?Q?sEjaVkyoxcQ6tRmRosx9oYmY3STD+m9emH26gnRf9mmXab0P5FcraNa7MNPz?=
 =?us-ascii?Q?uCLvBugVeGyrqgpKfzBCFkI24eD0vmfBzFRacFzYX8y1ZEDtsTyXp14moKds?=
 =?us-ascii?Q?tEmxyxjQ+O9Ml7Ur04TlSBRECi95m2A7wfoU89HmnzGkcTYpzciK9IVZ3q06?=
 =?us-ascii?Q?a8MCldiI0PRxAnVrtOgjfnp+EOqlNUDSt8ogaHqTHe/u7yHWQV10x8QA6N8M?=
 =?us-ascii?Q?XFpSKR/5DkgEljdGMPp8DDSCexcG4VSvcNYwRgHxi652TIqFXbvTb9pmJoep?=
 =?us-ascii?Q?4Eo8J9xVxDmCKhHHjIbXFhOxzKhnRgUW7xDO5bPjoO/iQ3TR2Reov2IVQEj+?=
 =?us-ascii?Q?bR67UoEIKM4AtWbpavwuUg7XZOY1zT7KAHyRHK9mHW4x9SUkBbam4DhAXDVK?=
 =?us-ascii?Q?RhHmmzDeJoIvmJgSOu+W3fT536pEq+Tw4inJ4jT1b1O00tqQ6skcSNfAK876?=
 =?us-ascii?Q?l4IsEYh8cyeqg67F5KIjFMzw4ucSeenTJ8seG2zXUZRPlZkVtoIL5uRGOrTc?=
 =?us-ascii?Q?vripGxy/WhHIlSRtoXc0AwJyzUegbI9ogqfkyaRGcbDuRqijNGrV92LqfI23?=
 =?us-ascii?Q?CZOUIPbLQpw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62sJoDr6e3m9f+RZW7pgaTtpvIGcGDWJQjH0eQnrdKw7/TWkcTJ0G8a5E08y?=
 =?us-ascii?Q?lT3BW6G0jIgQ7oi7JFk80Hq0X84QqktDiS1+YVUqvA0l0dEDDIHtIezGBQ0U?=
 =?us-ascii?Q?XlkFd70jN/lUK1whFlGTiXYTi6goVTVotrvuFLIj+uJZqCjF5lpFKvzu/x7y?=
 =?us-ascii?Q?S3IRcw/v8HVVnhmx3E+fY2vXlGA+lhFAwpgUkXgHXYSF+cpAltqqtvmGbZyu?=
 =?us-ascii?Q?DDBJDCCwLwbmNgyr3RHbhF8/ZBR2wztfc7iLbzMLMwwjmZisJM/KqTDwcTzg?=
 =?us-ascii?Q?Q8I4dZ4CriLVonDeIIrp0+11H+SqL75EsJZdGtfVV+quszVqyqJC8C/nU+dV?=
 =?us-ascii?Q?B6S85ZIeBfekEsO/eNTHQSqRstO5hkAPE6Bx34I3I1V68WlRxsLOX/OUngsW?=
 =?us-ascii?Q?eMkONr/MCrMVrB0dbQCmczJ1eyxKODnYIsf4CjoDxzzTTM++kLgqZK0LAYOl?=
 =?us-ascii?Q?My/IUOY9Tn0U+Qm1iak0nL9mLpJiXiNgW2NuPnv37bkyNsewBWKaKHsy7wMc?=
 =?us-ascii?Q?dRBqaYi4s37RuxjnPDM141Smr0hudMZ4caPd07wZYfMYmLjVLpHP+jYdV05X?=
 =?us-ascii?Q?zBzMTUTX+o7R7v2SmXP9wBlHqmqTafhJZ4e42jRSEYHvG41I54hpCLyamTUm?=
 =?us-ascii?Q?/OtL+/28r6euVHIeJCKdYj1CFZPkk3wjniLUJX9x0PSl2Y1hUrYBN7uGyDYi?=
 =?us-ascii?Q?wGrmXNmhFk+e0rPvDmYumSwyxVR9f7E3WOMwiEQTXxnZTCkuoi36nAXWGdsv?=
 =?us-ascii?Q?+voHgGFGYfwFRXjkxznaWmQiX8B3187Ar3nOJ9GRD6XJGVyaNW0Dyaco8olI?=
 =?us-ascii?Q?FPmnEEG40k/81aHa5M4PoExo3ImXAlRlXVN5dOljHSdC/+SvTF2UQXlQVSig?=
 =?us-ascii?Q?FJCjZWgFOEz70mcXmcxETUDfNwtLw5FduD0wPqYL6SdabWEcxBLWf+773IC9?=
 =?us-ascii?Q?lKDntbzeTc5MnF4EDhHi4aBcEardUf4Kqdj6sJq9G+oqTktNvLMeMhhODdba?=
 =?us-ascii?Q?rWIEyrkA0kFx7LT8mS/YZEuZJUediNvpLriDVY1XTGmpKdfLVEwBVZhcDHoD?=
 =?us-ascii?Q?6NoTKMtuvCSYBeuRRoo2gt/54iCiVrC4IoE1Ef6EcAp/Lbw2X7BzXILpUZtV?=
 =?us-ascii?Q?cFL9V0jv/nko1SyXpkmUt2d5KuP3BURWYE+I6hGGiBoWQ34KzbbEGVINJ0SR?=
 =?us-ascii?Q?u45VulXhivJaBfSOyNggbGgOdMONFZZRXX2BLiA6MaPQEcxebiQBfk/G1UBH?=
 =?us-ascii?Q?0diPjyDaQ5K3yXTBHs1CfMzOaBXnro2LTZX4c2kTQXNTOX8DftzC5+7tnBx8?=
 =?us-ascii?Q?BKCKs7t0Xf2H43Y40YZSOYdKKvKMtHSBJ/4mlldKBR0wM8xQRWqoQ0rsmcMt?=
 =?us-ascii?Q?hScX8O4fy4TpZ2ahL8U8dxrOPjYlMyC7sa7rufXzg+yGINLtCczYvD+6nN4F?=
 =?us-ascii?Q?uRBn5DZbCgR5aN7WMZCvKq91LDWyrW49OmqbXRQxywdcxp7XUD/lHKatkLfW?=
 =?us-ascii?Q?soQsY4v12Os9ev7RekRva9BghvWWU4HaU5yZRk91BsY1EKM+aUdp3qznubHZ?=
 =?us-ascii?Q?Ie8ZKNp2SAdjUGIraB7E6B5FTQwnsxgkX5lFiMV8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e473a3f-4bfb-4d0b-59e1-08ddada07075
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:11:15.2446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNevFZNI+cj15YDCD8Q6XMzpkg6a2HGCSHAgsNs30kW5hQdfKIu42t3SUVHP2xiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
Received-SPF: permerror client-ip=2a01:111:f403:2417::626;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

On Tue, Jun 17, 2025 at 09:03:32PM +0800, Yi Liu wrote:
> > I suggest fixing the Linux driver to refuse to run in sm_on mode if
> > the HW supports scalable mode and ecap_slts = false. That may not be
> > 100% spec compliant but it seems like a reasonable approach.
> 
> running sm_on with only ecap_flts==true is what we want here. We want
> the guest use stage-1 page table hence it can be used by hw under the
> nested translation mode. While this page table is only available in sm_on
> mode.
> 
> If we want to drop the legacy mode usage in virtualization environment, we
> might let linux iommu driver refuse running legacy mode while ecap_slts is
> false. I suppose HW is going to advertise both ecap_slts and ecap_flts. So
> this will just let guest get rid of using legacy mode.
> 
> But this is not necessary so far. As the discussion going here, we intend
> to reuse the GPA HWPT allocated by VFIO container as well.[1] This is now
> aligned with Nic and Shameer.

I think it is an issue, nobody really wants to accidently start
supporting and using shadow mode just because the VM is misconfigured.

What is desirable is to make this automatic and ensure we stay in the
nesting configuration only.

> > ARM is cleaner because it doesn't have these drivers issues. qemu can
> > reliably say not to use the S2 and all the existing guest kernels will
> > obey that.
> 
> out of curious, does SMMU have legacy mode or a given version of SMMU
> only supports either legacy mode or newer mode?

The SMMUv3 spec started out with definitions for S1 and S2 as well as
capability bits for them at day 0. So it never had this backward
compatible problem where we want to remove something that was
a mandatory part of the specification.

Jason

