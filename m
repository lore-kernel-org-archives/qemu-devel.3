Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C4ECA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 20:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uviEO-0003qT-JQ; Mon, 08 Sep 2025 16:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uviEL-0003pf-Q0; Mon, 08 Sep 2025 16:12:50 -0400
Received: from mail-co1nam11on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2416::60d]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uviEH-0001H9-0A; Mon, 08 Sep 2025 16:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IksgvJacVTHxby06O7ODd1uL8gF0PrmvILqEhMgMTzwTKMwVKOiQkmjK6MpChQ2rDyZ6nJEcc1zjg1WwNdDH9d2myqzgCoY+IsRiPLC2YCb4Zi5hRWbXcoyVFqU2KisMLv9by2Ms7fSN5kKGIiHoSQDEs1p7Sf64HbgZDh+xfAYtnbjY9azE6xaE0v8xhbGZOT2OnrQXu9JaahWD2TkceK3p4tBOjB+7p9x1gydsQIC/CHubCKBN3P0MKau+NLqZH4GrwniPBg73688Su/u2wDIzbulnMn8DDMwRAutTWJ542Hgo7Oth4IQ6lbWzjuGmTZCmwq/W7og8CPwgWXxZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9b0BcYk9WZb32veBb5CM8vbmxASJalsljZCewIlDTU=;
 b=s1HGpGlMlMFBibE/VYfcXmtR6TMjoheL1jzHdF8rOnuX1tsQzjhTB3M7MCH1gUA3xnUo/VG8dcZOvgTCxF/E1PwzPnxjqfUKHFf4ukdf/np47BFA2XPtIugFIlbH+PeXXiYUaHAO9//HilIFG92DU22+zRNcIOR28W/q2dJ3K9Czx8iHbNT8fclWcugIdntNrJFW8BYyaTm/0qypKMdZiL8DH//M6x51AD9MjLquFV7XXmhol6vIBkwZOhwHC19JqoKnMTe3uadrkvX6Iy0nUXpl6t6opY3chY9IEQuTRZij4CHszKNvfvqvSWxO0YHbdvWHBV+qXIx8Gl0KK2DStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9b0BcYk9WZb32veBb5CM8vbmxASJalsljZCewIlDTU=;
 b=ksVkDk32L4wbzgDFXJfVGfef1oGfY8yizGhwPZwFWiObxikoCKnkTbJlDln6ec05XNvnB2r+mMO1UJTP0wSNKvD3erPNoxgXHXt7T6GpCD02FmCWo0VaAXQvFtY44KoQsnPwrWS4SB/FEjqPzUkipoJZJENxgY+bTR+RV8P6Vg+/HvsYRRDWRF3ZDrJmbiL2MTRSN+mlShzTaljibJalu1AURxUwKtvWaKIOcRyBH7SuKbDD3cdFJT5cyiXRnlRF9jioRbA6AmqntASSWeb3UHJao4V4TTMGpB8V/sRwmM8DN8+AC7QqWVD2IsQAlQ5FNHZQ5nAOldCVCJt1i/epRw==
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:12:28 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::de) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 20:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 20:12:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 13:12:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 13:12:12 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 13:12:09 -0700
Date: Mon, 8 Sep 2025 13:12:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation
 commands to hw
Message-ID: <aL84lwouHh8LZ5mA@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
 <5ab38eaa-b005-432a-9de7-fae3e6096f89@redhat.com>
 <CH3PR12MB7548543A976A65B74DA6EA42AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548543A976A65B74DA6EA42AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a7beac-edec-49e5-798b-08ddef140848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nmp3K21iUXZjNWxOZVlKeWhEZU5aRWdEQThSSFB2d1FvQ051aGVvT1l2WERT?=
 =?utf-8?B?TzdBMWZtRUxFNG5hdTVWVVVYUUttZWZnVjhLY0FxdDNKYVhhdEVWdy9SSmNq?=
 =?utf-8?B?OTIxM1lZdUIzbVFQTVgxMXpwM1Q4WGw3bWZvMlJQSEFuZ3VyRnB2WGNsNk5L?=
 =?utf-8?B?WW5wSFdJNnd3ZGZSbDFnRGZlb0tWcFZuenBjalAwYWRkR0dvRkV6Qm8vano4?=
 =?utf-8?B?aWwwQnFmeldDajVoeWwyeEhDZG94Q1cxVDVoaEpKTnVlMkJiajEzZFFrWkNs?=
 =?utf-8?B?VXpBSDM0VnEya0ZIR2ZsdHFJWTNxSUhSWkN3ZmdwK3g0SlhLemdMSU9MNll2?=
 =?utf-8?B?MmdTNGZIeWhybDU5bWJteHBCU3E4b1JOR1NRbHIzSmNuajFOdGxRbU5ZdlRn?=
 =?utf-8?B?RXU3VTdHQnMwUCs1VVJTbU1EbDF5YUs3Rm10SGFaaFVnRHlwVW5GREFLaDhV?=
 =?utf-8?B?U2FxeFM5TzZDU01Hc3ptSUF2MzBLS0dTLzFsRmdVbm1UaUUvVnV1eUdXcDZu?=
 =?utf-8?B?b3JKOVpuOHBBQnM4aytIcDhpZHFxSzFnMU5id0EyV3JFV0cxVFVNYTAxaVlG?=
 =?utf-8?B?aHFYaDR5OC94MUhaVGpBZ0RRTWVIQVBnNG1lR3F3bDdnd21hRkxyRHgyYStX?=
 =?utf-8?B?SXhERjVDY2IwM3RlSlBCZDFvUG1iT0JLMmNXcDNIUzYzOTlNSklKdUNCU2JQ?=
 =?utf-8?B?RkY3UzY4R0xqMFBTV3F3YWhGSXJmdUNBYXBGV3AwSjlqZ0ZoQ2RKVXQrOC9H?=
 =?utf-8?B?eGQyejB4dHlQVWxTazZjKzBDbWFrTFpaQWdkeEMweWFIWU9FSW0vNkpodFBT?=
 =?utf-8?B?bkdvY3dXTkNWRDFCREY3ZXZqSGZuMXJ2SCsveXlnT0JkSkdRODVFYVl3YjlL?=
 =?utf-8?B?eVRVdWF0VmYwekhvb0h1UW0rTENVbHAvdExkU0UraWxtdXE5RXBuRUx6TElF?=
 =?utf-8?B?Y3pvRjVYWkVKR0ZVRmJzZmhtRHcydWl3eUtDYStnOHJkOWxZMWdKQmVwczNL?=
 =?utf-8?B?VFh0UGFlYUN0NDhIdEJvRkhzU3l0YlBCc0xmWmM0THpyV2xMNnVNME8raG5y?=
 =?utf-8?B?cys0QzU0cW1objNFNElRUjh1YkJlRnJDaWliSjFrWG1HeHhmR3lpdFJLWVJq?=
 =?utf-8?B?SGlPS0NCYUtlSjVkTHBsODRBczNMb0wxZlplVTFwSWZHbEdkeEdFRTNOcElh?=
 =?utf-8?B?cTJ5NXNYTzVtZDFkRlJwUGlTK3dKbGZmM0g0R09sekZEbGo1THFIWEkyTUdr?=
 =?utf-8?B?ZWIvS0JNQkVSTzRJUFdMR3BYODNHWGlYeHRiREh5aWxxaFUxTzdUcHJFV2w2?=
 =?utf-8?B?cVYzQ3hVV282bVBQNFZTdVI0TUtlekdwd05yV3pad29ZdDByT2EvL2VwQnlE?=
 =?utf-8?B?U1lmZEVVb2MzMlZ2WTdwT0JkUUdKVUNPOGhDTGhVOVdNQzRUcTA4dDcxSkJz?=
 =?utf-8?B?bkpaM0FFR2VXTUI2R2FBeCtsU0JhbHBZaldhQnQzaVRHV3MxcXB6UlVNZFlL?=
 =?utf-8?B?enUvNUg5cGM5enRLNWowRUVuUzBHZnV3SHFIWSsrcEFNai9GQkR4WUtXRWsr?=
 =?utf-8?B?RENKb1h1ellJM1c1bi9lcWU0K2tXMk5McnMycXZ6c2JnM3piNDlLb3U3b0VN?=
 =?utf-8?B?VmpWRTIvb3Vvc3NvRVNub3VzdWFBbzRCUmtnNWdVYjRRRitEY1BQaDFzUGlC?=
 =?utf-8?B?b0Z3bko4V0ZZN0Z4RDV1b2dUd05FSkIrRnQ2WTl1QU5XYmJzMFpxelJad251?=
 =?utf-8?B?cVM0V3NlQVRac2k5ZWJVM3ZMKzIrRUw4NXhJR2dzcTdlZUtOejVJNkNhMjdO?=
 =?utf-8?B?Y0NWS1c5VVIvWUtndTdjMmpLQnZ2d0p5cVllMEUvWU90MXlWZUh1RE5MRGlo?=
 =?utf-8?B?WVJKbFl5NmJuK25ObTZLdEcyb1BEMVlGT25TTmd1NHRGbXNrYUJNWUJCcmlC?=
 =?utf-8?B?bDJBRE5tak9EK3J2VmgyenhSWVZ2aDNzMHNQWEo4R01YRXEvSFRwSHBwYzJV?=
 =?utf-8?B?K3k3NTdJdXVsU3ZjWklMamtnaHFZTE1WeHBsN1o4K0c0RXRBVWlmQWlYSS85?=
 =?utf-8?Q?JR5FZe?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:12:27.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a7beac-edec-49e5-798b-08ddef140848
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
Received-SPF: permerror client-ip=2a01:111:f403:2416::60d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Mon, Sep 08, 2025 at 05:22:35AM -0700, Shameer Kolothum wrote:
> > -----Original Message-----
> > From: Eric Auger <eric.auger@redhat.com>
> > smmuv3_cmdq_consume(SMMUv3State *s)
> > >      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> > >      SMMUQueue *q = &s->cmdq;
> > >      SMMUCommandType type = 0;
> > > +    SMMUCommandBatch batch = {};
> > > +    uint32_t ncmds;
> > >
> > >      if (!smmuv3_cmdq_enabled(s)) {
> > >          return 0;
> > >      }
> > > +
> > > +    ncmds = smmuv3_q_ncmds(q);
> > > +    batch.cmds = g_new0(Cmd, ncmds);
> > > +    batch.cons = g_new0(uint32_t, ncmds);

> > so you are provisionning space for n commands found in the queue,
> > independently on knowing whether they will be batched, ie. only
> > invalidation commands are. Then commands are added in the batch one by
> > one and you increment batch->ncmds in smmuv3_accel_batch_cmd. I agree
> > with Jonathan. This looks weird. AT least I would introduce a kelper
> > that inits a Back of ncmds and I would make all the batch fields
> > private. You you end up with the init +
> > smmuv3_accel_add_cmd_to_batch(batch, cmd). Then independently on the
> > ncmds you can issue a smmuv3_accel_issue_cmd_batch that would return if
> > there is nothing in the batch. You also need a batch deallocation
> > helper. 
> 
> Agree, at present we pre-allocate irrespective of whether there will any
> Invalidation cmds or not. I will take another look and incorporate your above
> suggestion to improve this. 

Perhaps we can try a different data structure for those two batch
elements, e.g. using a GArray.

This allows an unknown "ncmd" at the beginning, so an invalidation
command will be just appended to the array in the _batch().

Then, in the _submit(), we can convert it to regular array:
    Cmd *cmds = (Cmd *)g_array_free(batch->cmds, FALSE);
    // passing cmds to ioctl
    g_free(cmds);

> I remember I expressed in the past my concern about having
> > commands executed out of order. I don't remember out conclusion on that
> > but this shall be clearly studied and conclusion shall be put in the
> > commit message.
> 
> Yes, you did, and I missed it. Sorry about that.
> 
> I think it is safe to honour the execution order of Guest here. From a quick glance, I
> couldn’t find anything related to a safe out of order execution guidance from
> SMMUv3 specification. Also, we can't be sure how Guest will be modified/optimised
> in the future to completely rule out problems if we do out-of-order executions. 
> 
> Hence, my plan for next is to start batching if we see Invalidation cmds and submit
> the batch If any non-invalidation commands are encountered in between.

That sounds good to me.

> @Nicolin, do you foresee any issues with above approach? From the current
> Host SMMUV3 driver, batching of commands is mainly used for invalidations
> (except for certain arm_smmu_cmdq_issue_cmd_with_sync() cases). So 
> I guess we are good from a performance optimisation point of view if we can
> cover invalidations as above.

Yes. It shouldn't impact perf so long as the guest OS is sane.

Nicolin

