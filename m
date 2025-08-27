Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A111ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urI7Z-0003Wb-Oe; Wed, 27 Aug 2025 11:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urI7O-0003Tl-Oy
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:31:30 -0400
Received: from mail-mw2nam12on20623.outbound.protection.outlook.com
 ([2a01:111:f403:200a::623]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1urI7M-00022k-KT
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:31:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzQRR7meBaa+k2A5kXrJaKMNIp59zErVflG0BpPcMpeKJiAHkMri1TjFu4eauYVNYWbMp66gsHKEnp9GEAN++TrR0AR6AycdFjcmHLFdSYKKr78yJW1KnwxwWdfGAq/8wk23eNU0Xs9dEsILRL/7nM7IiMV/JfmkKccFfn9qIMCJSI5yoi5W4zivWd/ZKoSqRdCw7AAsepWSs1oII+o84zpjVZKbjsO4cCucTNoPROyJTqMXWypft9hcRt8w1JoV60NAWkFzJGDtHAcU63PLijh33V+LRVh655b+TaFNGNTcojlVwzzqBp8jeOMF37i6+A7SpGfdX3Zi31cQgXKE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skMGH/xwyvR5vRoG89Xc2Vhtfnfq1q3X3l+KLuKRcww=;
 b=uzNk7kVxfIar9qtapbQm1grxKra7Yne4BNvgNuBy5B9ZDM/AEMsfQ0O2L0HhADE6RxOY/IZMkmv0zwDRu8axPLt6/hZV5Zk4T2+l9eOMW9TbNZ6AO4VzzRl158Qdt/ztYYc/w7gmyig+6LkXACw+17eMp5W3G7/wA2jlNIcQ9Q77N0JPar8Ettk+1DTCB0Q57Wd9weLwdvO7DxtMVB3W8179l+NFy7p7HyMIt5y18beeg1mx9Uz0BYJRpJLaJKOohocX6v5VTj3Yw8chZrZ8U5sUq0bTuwXqsTNtNnhL1QZwevDa38OWQmRdkVY4H6HZZWCveIDaB+wenW6fGPc05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skMGH/xwyvR5vRoG89Xc2Vhtfnfq1q3X3l+KLuKRcww=;
 b=P4IJBPs3ZA28VpfPPdpX8wSbmNd2bFmcE1zBGghMBKJFJT+uPj7PXq006h13CzxUp9G9K4+c8cPpxqHJwfQct0tsox5M/hZZ972K87YVIDd6jZdgAdduvNgbnTctCZTibj5pz84/gaNtbA4EpZlHK+oFO1IsViDhzOsKbckYk9YdSod/Os9no7n62l7Q6PE9dspTbD5LLePZ2qUW4RbM2D1a6/lQGHyk/smUjwRI+xHmqDHb9tCw4v4CL3YIwZ11c9+HBQ7Z8rl0HAcWx3mMKWF7QnkbQ5lIeWITt2TjdLPsrMaTM/cFIHlw5FHELDv/beReVmFTf/sahug1CxC2Wg==
Received: from CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::15)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 15:31:13 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::5c) by CH0P220CA0007.outlook.office365.com
 (2603:10b6:610:ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Wed,
 27 Aug 2025 15:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 15:31:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 08:30:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 08:30:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 08:30:51 -0700
Date: Wed, 27 Aug 2025 08:30:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aK8kqQOV28V36wtM@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: c216d29a-8717-4c15-ad8f-08dde57ec1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d29noRA9Zh0JQbJLeBB96Pf9ZZInoL17wCDp1cOUFhGdtwn5VMbC5TJ+m6cj?=
 =?us-ascii?Q?lZZrIKF/h0rQo762mEEj8rUEoDKeV3ym6MncDrKNhooKk5yyMzTFrAAAif0O?=
 =?us-ascii?Q?wIe4gCvNb4wkYAre5WfCsSj795Uqp8erkRskjfl2H1xdTletJq/61WT2kDap?=
 =?us-ascii?Q?YHMETeZ8/Uw66Jy6YUyDy7XDnvR6dev2pkVoOvJ0+BrLTt5cT+zn7keuSMQg?=
 =?us-ascii?Q?MXbuVYRnW5+yco9v7vOEn9nX9KQgGl39K9QdUnSUQ0aIEBcSEJLas7YuAXX1?=
 =?us-ascii?Q?yc6hXgaLV/IX802/+VHfCXhTm4zWSMziQPPnT0VamXG25Nf+SClVkVOIxv7N?=
 =?us-ascii?Q?Q4m2SH+WDl641TT6X/l7yJxYpGi9V1puwQ9aruiWHzFEAVeEYXHG16RG5B9o?=
 =?us-ascii?Q?qFw52J4ScVGpPKQ+L0Nhn8osennlAhl10GeQ8RvwavCV5VHYppaxUzFql72G?=
 =?us-ascii?Q?52kyZPt2MVSBUBb86fsbB9hqsxiKCxdqrw6SnQjLbe+w/8iN41lJdKyc5WHC?=
 =?us-ascii?Q?lGnZXDl1hBPhrPlxv782HFCk3Zuls+CmdDGqPuWvSwehIObbrvRCKXa5jEQn?=
 =?us-ascii?Q?0ErXUS/XX72Qz9jyoJ5qO37ToiepD9MUOv9cqx8aQpMfEPy2fjpy3at+bWix?=
 =?us-ascii?Q?lyzzFR0NvFxgmsA431s+DMKP15Sy4SZJSLFYZ+4YybJkDqJfhN9HM1CeejJx?=
 =?us-ascii?Q?3sLNtfWgqXLz561ehArMQ70IXK6Z72iew4jAeFZpYJgqH9hTvztmwxsNvKBI?=
 =?us-ascii?Q?044J6RO+u3Bas8I2c9/RM2ryNQxNybgQGs0r9xdsU3sy2c3re8D3k3CXo+Qv?=
 =?us-ascii?Q?5ZF1ICBX7kJpY4DLPT6KhALjA8O2+XJ6vHR7omX/iBsUsg+lsxJv0QHiWTWp?=
 =?us-ascii?Q?3V6eQdJtx6aYd1KBob+CVCXjqv/Vb3P1KYLeaEITT+Eq94RVya8E29jTMqWr?=
 =?us-ascii?Q?A9Qb8dAqv7zf3cTp2kpCeSY7wHlhcrqpBbWruiaZNsZgV4PMeQpJVtKR4tM1?=
 =?us-ascii?Q?g1oIpKkiJxEfs/4nVZHCMgNnfozIKsJxNz6lABOj4b7ghRaPXrju1hEH6zr1?=
 =?us-ascii?Q?olIjf8bpw1cWG2/4L3li0K6V5WLicQlm4ualACILcFd17byHAmjmdbyvIBxL?=
 =?us-ascii?Q?axZLXHVW6WI/7bFx+umChKWjN63uiYA9q3WDUlGGLq1FZlDMcklfR3uGg0zn?=
 =?us-ascii?Q?bjwHfJ+okRUFQKJFLfrhSBj0iaNcCCaevsckPUPdFbCvorNvDNHGfjhh7bf4?=
 =?us-ascii?Q?jbac9jtBCYxqN555bvZr+djsi33tiANoU0dEaGwRjLdolusgK48Vu8PAezEs?=
 =?us-ascii?Q?C2wBlEeneZFOFZNFr3tM1QukwwPA3GwtQSbDhumijqlupGjtoEASTA+9DyOf?=
 =?us-ascii?Q?nWB+McIfX5EDV/yEuSzw/1P03uaowOlJ3/cLOpQCd/nohKwGEN9NTcjjecAX?=
 =?us-ascii?Q?dm98JWpLQHGgOVSEL/XQSJ6vfX1Hnfgo+c8cZhVkYEnHtptiEYUnK4QJdM8k?=
 =?us-ascii?Q?66f+vOj8QpL/+liDlcm/Jp2ifex2ELw+HppC?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:31:13.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c216d29a-8717-4c15-ad8f-08dde57ec1e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
Received-SPF: permerror client-ip=2a01:111:f403:200a::623;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Wed, Aug 27, 2025 at 02:32:42PM +0200, Eric Auger wrote:
> On 8/27/25 2:30 PM, Yi Liu wrote:
> > On 2025/8/27 19:22, Eric Auger wrote:
> >>> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a little
> >>> larger than what we want so far. So I'm wondering if it can be done
> >>> in a
> >>> more straightforward way. e.g. just a bool op named
> >>> iommu_nested_wanted(). Just an example, maybe better naming. We can
> >>> extend the op to be returning a u64 value in the future when we see
> >>> another request on VFIO from vIOMMU.
> >> personnally I am fine with the bitmask which looks more future proof.
> >
> > not quite sure if there is another info that needs to be checked in
> > this "VFIO asks vIOMMU" manner. Have you seen one beside this
> > nested hwpt requirement by vIOMMU?
> 
> I don't remember any at this point. But I guess with ARM CCA device
> passthrough we might have other needs

Yea. A Realm vSMMU instance won't allocate IOAS/HWPT. So it will
ask the core to bypass those allocations, via the same op.

I don't know: does "get_viommu_flags" sound more fitting to have
a clear meaning of "want"?

  VIOMMU_FLAG_WANT_NESTING_PARENT
  VIOMMU_FLAG_WANT_NO_IOAS

At least, the 2nd one being a "cap" wouldn't sound nice to me..

Nicolin

