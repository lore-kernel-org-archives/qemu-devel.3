Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AEACCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKFA-0006oh-HU; Tue, 04 Nov 2025 11:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGKCz-0006ij-JD; Tue, 04 Nov 2025 11:48:49 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGKCu-0002kT-4h; Tue, 04 Nov 2025 11:48:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpCeYF6gBL77reeI+JReP+wf/PaLYI/NasE39BzpvbzOFzRp3kw3Lley6ONf0dmviZK9O8U6XFWN+oPwjjJEQ05N2MYrnQGckOMzNeoRyaMkJW1StMOEG1z8xgsIunPjtAzvHajWt+pAPiftCtde+w/XpSZIf6Lmh3mhx70qs0FMPGetPSx9fVxMZ50wGrUKvaqrTVUFhX4DyA5M7k3FaIhsMKYNaKzQYO06DSVFvekiwfIL7rESoNUOIKTDCx5uXfe1zx57GQSBqu0FyXV/Dk8/0z4W5BKUFxi+YR1wB+0jc3T0spyana0N1ykDtT324Gt+RW76fNQurbJV8fHQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32OpHf3QpZcVnnsAz6W8+huziSYgW777jvfTouk2q8A=;
 b=P9iSaV9pcWaywUuCgwcUzmG9oVb+LqzcLu/SPlhH38ty1jxyEq2eKfXLIyyQFyvKDLPfktAleH3L9ymiyU5UJG1oY0wbYEzbjFzgqKSMmz/FDib0LkhHP2Jb3kel4TwQtirk6PAUMZuZrKWZYyt0k4LYwoSVvTUtGuEkETE2xvJ1z93b+3R+3WjYiI9joPvW3ISCViPxDIKeRSfzO/mwhOt1aVWw0MfqysRxTomUu4lsr0AbwUMTMpjc4ippDyOWcp35A7/RNh7rGekPzIjqEe5X/49lV/2piVINKlxOiCgDClMU8tHAK+14Rw46CejrEjVx0NARO8Bk93dHTAKHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32OpHf3QpZcVnnsAz6W8+huziSYgW777jvfTouk2q8A=;
 b=ZpCrZp8CTRNPfqA8pyBHhHmSVEuSZ9hgn8sm7DYn65Jx+g/Qe0hfxjcsRF1/DOavhZ/90wC+4o8vM/k4hYlyxT6anI1m10z5tpo1WgzWT6T5VMY+kFKM6rNxsc+whYXAuAgGrDGbhNUWihOI+9fDjDJnP4LCyRoQ1N+cYzmDZiuB2nBF3XQyfWfHmELAMkaDFa6vI5Kp0AH0I2ABElPs2S5GBxk9dbpOy0JbMCRemgBIwVd4Io4G3XsXlhQvmlCPzCHgLGKndfnq7od9rckI0nVrpextm/2/zGPgAIZ6i3kXKV0kWKF7vbYjiaRRD+ILYhIVSzD8ugD7/VZWvoICXA==
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 4 Nov
 2025 16:48:20 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::3a) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 16:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:48:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:48:09 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 08:48:09 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 08:48:08 -0800
Date: Tue, 4 Nov 2025 08:48:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Message-ID: <aQouR6WRyi1nCgje@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-14-skolothumtho@nvidia.com>
 <987614d8-de6b-4cb5-b5a8-1723e24502f3@redhat.com>
 <CH3PR12MB7548B864AF133DEFFCFCBB2BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548B864AF133DEFFCFCBB2BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bc391c-48ee-41bc-9946-08de1bc1f61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2tOYUxmRXVyYzJTRkdvSVFVMkk0cXoxaDNhTlVKZTB1SlZ3d3hxdVE2V0RQ?=
 =?utf-8?B?c0NGdmZDYjRXUjZ4UkQwYU1aQUVQeFhLZEFTT0VOdXIwRVZtbjE5ZEJOZ2VX?=
 =?utf-8?B?bGlhNFVmcGVPbW9lTFF2T0JlRlFndExUU2hjc3RDc1pWMTZVbm5Ra3RQZG1H?=
 =?utf-8?B?a3dDd1lMd2hvM2RuK3M2VVVCWUFENGdHYzNobzhMaWJlQU9JdkpMNllmSkhM?=
 =?utf-8?B?QjhoR01jdWlMRVplSkRCVXRSN25SbStvY2RCL1h5YmxrM1d1YkkvS0pEa0cr?=
 =?utf-8?B?bEFpdEZieWdzcFFNOEhDMHdXS0VlZnBiM0lOVG5ITFMwVlV6dEsrK2Y0bUcr?=
 =?utf-8?B?M0cwc3FBcmZvb0IwK0prSHl0dUZBZTVHNEpNcEZuSnpuWjlHN2o5M09hcmFD?=
 =?utf-8?B?Q3pnZVNNRnJJU21tSW1ULzZJckJZZkc0WlhKTXJrLzU4OEdtQnhXRS9jNXR2?=
 =?utf-8?B?ajBSYU1QYXMzUC80NmN3dFU3dlpYbTJlWmV3WWhTd21zMjl5QUdHVkpXR1pL?=
 =?utf-8?B?WjA5b09BUkRXN3dQZmZFbVl5S3R4bG1MTDdHZ1hnVWpVY09zN1BsYWwrd2Q4?=
 =?utf-8?B?Vk13dVFNZ1NvVFlBMmRqRFhBTnREWEl1UFVRbUxDa1A2aG5TZ0tya3BjSjFD?=
 =?utf-8?B?QUE4dWtRWU04NHNHRVFuNEd4VjkzVEhsb0prNGhpT0U0WnBIQVNBZG92dGw0?=
 =?utf-8?B?U0tRYkNXNWRZRCsxaHBvRmJWOXptVjI2YTVXemh3Q2k5NjAyTlJQamFsb0ZW?=
 =?utf-8?B?Qk9XdEZtN3QyY2M4ZG9MT2FyR2dLcnNUQjNxb0ZSZ2Rtei9teEZER01nOTZ6?=
 =?utf-8?B?SWRBRGs1QW9QcUgzWDQ2SlVhNVBqWXRtSTJtYmVPaGVvdlBEelM5akFuNitU?=
 =?utf-8?B?VkJvdFBUV3puYW05RlhNTnZlbFJJZXFiMTVWWnUrK1dvS2FHSGdtM0dSYjN2?=
 =?utf-8?B?MG04WFNiVmlRelpHY0RNR1N6eHZsMmdCQWVjYWxnWGliRkczdkFuN2JZdU9z?=
 =?utf-8?B?V0R4QXVzK0p1TTNXeTBkSzlPSW1hR09VQnpRSG9xRUN4Wm9HWFlvV3hGL0hG?=
 =?utf-8?B?Z2o2UHhORTMyWVhXSG1VZTFHaFpFaW8rWXlJSDBDRkswdnpEUk4vNnFiUDlk?=
 =?utf-8?B?SGVNUjl5N0NUYkJVM0l6Q1c2Q056eWs0anhpU1htKzZyaGdwankzVnpvRHU0?=
 =?utf-8?B?V0NEOER1eE4wa3cxYWhOeVluckxDbkNSWVVQUjFnZmI3ZVozbHoybmRVSGhY?=
 =?utf-8?B?MExvc2VWdThiVmxpZVpoK1NUWXBNa2svMVM3MGhrdzA1dTVTY1h6SitvQUdv?=
 =?utf-8?B?cjZvZm1ORm5sUE85MzIxcDl4Y2Vmb1BRS05WWlZva2dEY0V4Q0NWTHdEc256?=
 =?utf-8?B?RkhJWllyT28vSjhsNTZqTk9mMnRIMDJOQ1AzOXpjVGF3TUt1TWZpWk54LzNr?=
 =?utf-8?B?VEVYd1Zwdkc0cElCc0pjNHcrOVJ1bzBid0xEd3lMQ25INW5nTzJPQ0JzUjNn?=
 =?utf-8?B?cjM4M3hGejJUWWg3eEtZVTFyZm5lK0t5TjhGVVVRWDJxOEkzRG04WFA5UWRx?=
 =?utf-8?B?dTNiRFBWRVdVYVlScEs2aHdRZEZvU29zWS9odHJoNjVaRGE0aFBVUFdlaUI1?=
 =?utf-8?B?QUtPcklzQmpETVFKbXUwUU80Y0FaRUFoMTBLNzVnNkhxWFhWSEVYUnJYUENk?=
 =?utf-8?B?ejhuc3E0MUZFeTVyenNSbVR3ZHpZZGt3bmJKOXBuOEJsUXB4UUYvUFBMM3k2?=
 =?utf-8?B?L1BjaWkwTG5RaHdtY2xLY2NOOFZpKzF5bi9xNnV6SHpIT2VIT0R2QXcwS3kx?=
 =?utf-8?B?WTA0UzRQRDVsWnRKaUtpOXZJcEh0N1RBZlhKc3owVmJwdGRReFRzeVRBTFgy?=
 =?utf-8?B?SlBzREVIdGtaMVhWQk9ocFAzdWZxT0lYTVdiS1BYaENnTDJaeldYdEcrM2xm?=
 =?utf-8?B?WUxVZ2ZNdXA1L1F3WVVHQlliaWZlRkkxVkZjS29hTWhCWE9HSTBXbWxFWERV?=
 =?utf-8?B?WFZ0ZmRKYXh0VWtBTTU0bzFUall3eWVyUkZWSnQ3L0lzTVRpUTV2OU1MYlZR?=
 =?utf-8?B?MkdsbTFJK1NyZ0I0RDI3QnBWZkEvdjVRRWJEQzlhZ25PWWV3eVN5MGlhYld3?=
 =?utf-8?Q?aDrc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:48:20.3758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bc391c-48ee-41bc-9946-08de1bc1f61b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 04:26:56AM -0800, Shameer Kolothum wrote:
> > > +static bool
> > > +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> > > +                                    uint32_t data_type, uint32_t data_len,
> > > +                                    void *data, Error **errp)
> > the name is very close to the caller function, ie.
> > smmuv3_accel_install_nested_ste which also takes a sdev.
> > I would rename to smmuv3_accel_install_hwpt() or something alike
> 
> This one is going to change a bit based on Nicolin's feedback on taking 
> care of SMMUEN/GBPA values.
> 
> Probably smmuv3_accel_attach_nested_hwpt() suits better considering
> that’s what it finally ends up doing.

Eric is right, because the current version passes in hwpt data for
allocation.

Yet, my new version passes in STE, so naming could keep "ste" IMHO.

Thanks
Nicolin

