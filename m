Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C7D597B4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 23:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAzrj-0004Mm-Vd; Tue, 12 Nov 2024 18:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tAzrh-0004MV-SR; Tue, 12 Nov 2024 18:00:06 -0500
Received: from mail-co1nam11on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61d]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tAzrf-0004zQ-NK; Tue, 12 Nov 2024 18:00:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHBv4F8P5hlcLfR/Vi7IsnpCWgQ8GLq6Y3KKTQJClFk2UmNCIm/hdV5xyGHZ6XweK4i8JaCcMQWd5hQptEQJTQUP/wvJmKbLxwFme1/FU0B3DnF1S39SRJpRgJaBXRYrArOt6avqIzbuXCvsdAl/zM5lnWuq1JhjIiVpM7hPYSrMB7HuK56mjev4YU9hEbiTRJ37ens7waWwP0tytt3s4RnWGHyJ0PHbXEA2ca56AQN1PYkYiH2Pp4j4eBi05ZTh8/Bu+9PXaj/gNmuop2N3otdE0M+7459pHFrRtX7109yV2aLB+bZ7oouGQDihO3GgCjkbP8JMb+QUxl5c3fwDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF0cHfv2VK7u7WPzBNwCludU8QPbwEbXS09y9fISMTU=;
 b=MisfKtl/p3KyLqJMuJiw8m5Zou9xTkrFQpBk3iIobCL6AXZ7jbyV79GdSxO6WlyGcHTbRq4oaCWoyM3cqOPRDvLblTX4qPGVYeM780azUlbGCrcat5cGK8vHjJfZtJ5OvR4J1Z99dZ/HHIyQHGZkLvnUUTLZsIzh3Py99zUb6u2PqPkd1hbXLr3XWnFzBADO+oSomvzvDvCLVbhT3BaJEIO4JrN47n0Da60PTdX/5HxcEmK+oyf93cBysB3TdqXVH3fUWCBmEtelqH0JOHVH77vDmM92+/1YUvOwYytUlgI5S0ht8xllsBqCXlZXU92LzCUtaQbG26H32yD9YtcbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF0cHfv2VK7u7WPzBNwCludU8QPbwEbXS09y9fISMTU=;
 b=dCEGn4+GjwYPosCcJ9K9eZazc9TAP5bZCZuN56oFneNiie5QzhXkc4kzP94wi8dgTQpVFO7kNlzduMzNUoA/vWpr84ii+mAnscveb2oD8eoU1BDv9eeuXHkQ1gAjxtC0k/tkZ2KA0/MNfkfdgMlxkz4nVKW7cAjp9fIBfaA1nxgm7fDl0ITvKRQPWsR+z1tM+TtLDy6HCDg+iOgiUqSqiEGY0JItpJKDBm/boIlnZAmD0pHyRrlXvOGW6MFqWeYbuOtE/QTbns3+Jv+nA+5rDHwN7kcNnedIZ7R0qfqHk0jlO2lRGoeIks0JvXjikHzniSYAgSBtjEJo105mk5pOQA==
Received: from BYAPR11CA0053.namprd11.prod.outlook.com (2603:10b6:a03:80::30)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 22:59:56 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::39) by BYAPR11CA0053.outlook.office365.com
 (2603:10b6:a03:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 22:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 22:59:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 14:59:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 14:59:35 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 14:59:34 -0800
Date: Tue, 12 Nov 2024 14:59:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <nathanc@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b05c77-bb19-4fcf-86f9-08dd036db923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5rJWHo86e3Sd3O2HJ7YoZUc8Ku0W4saCqjnqRwjoLdHraZ1H6yREEr6gFTyD?=
 =?us-ascii?Q?saF8ahRCV14rVzJPf/w+obAroXAR6VwGCMl8eE9AERGxwy2aoLgUBIw80l4k?=
 =?us-ascii?Q?uVwhUIeBJR6jG7Z9hGt8PmNkFoBKNwCj3ZLp4pVxwD/I4oEosWUwuiAxe6Af?=
 =?us-ascii?Q?fzaB24dOLwhRxBqAKqmvjCHuICavBN97+L1bKbfmj20NG3NZGktG1dN0tq4A?=
 =?us-ascii?Q?55KF5xJBJ3ilhfrGFBcZs2fECDIaACP4hVtu2CzeTKtOm1D7+uZJWapgepdU?=
 =?us-ascii?Q?NKmfLz1qeCJP6nrq2Wcd1p2WYKiaO8f+sdFWIRHzu0bhGD6q96Z96aFCzyIK?=
 =?us-ascii?Q?xGfJ4otp5r+cbMiJCTmEaaOAwkG9/fhsFRry61eB25xmv69rb0smqsCzpAXg?=
 =?us-ascii?Q?G/U/IV8jnf0ZYn48Dp183EBv5d3fZdU2IBHC7SdoRhr/X8blX6fVmJnQlN4f?=
 =?us-ascii?Q?ygc8XHhMqjqZ5L2uaNcPg3tgexo0S2Zn/4dnO4CHEcfC45xVPKiZ2XJoDRIq?=
 =?us-ascii?Q?Lk3H8MbzRrlQamfMop6S3URm+hFAazRI228vTcNBbrb5sKDTIxW7bdLPwTg5?=
 =?us-ascii?Q?cpUQ3CBXqVx0NRrw/gmkH9quob5ShpzjyHznr0J0717YHhGpghdmGDv4i5lJ?=
 =?us-ascii?Q?DQmU/SHTO95OpuX8AxHKRpSZKDfN9fwlKp28KM/h9Y29bbULGtHwF1shQwa+?=
 =?us-ascii?Q?Ly13kych4JPp34XRcH1ZN/tQlZJKTv5I6QiVC49T7OyXOTl+dP4Ldqtyze9R?=
 =?us-ascii?Q?UVcJ6wZNNuNzv56D3zuuIcrsOqvIp4ks4zewLAbXfVsUMD6n9XL1h0/67TgU?=
 =?us-ascii?Q?e4Y00pVavldUhNEeIoYAC7Zknyj3XNETJhsdJ42PvaGW1ndOGJE8R1biYpiB?=
 =?us-ascii?Q?LyQvlfQBek2hVDCUk60v78qnnvtAcrTgUFyBy02YVnBdCXct9kDjyPUQ94gq?=
 =?us-ascii?Q?Oe0PGhylMM/ljOpCm5/08olTm4XeBUndtOpGcEfa+viqWwPH/pfIMxgk4ggT?=
 =?us-ascii?Q?DlcRs8wJzUSI68AcL9caQFwncaPMCAVKCKWfxE2x50KR0RgZAzHpJ5MCZF2F?=
 =?us-ascii?Q?NKRJFNVmvislx/ihHGTFVE+bK4urNYZT9V9pAQzSlLQRx0Mc1QE9114Ht5zh?=
 =?us-ascii?Q?+ujTrTRzlc0z5OLGVBU1v3Eu7/yiCTTa0x6s85M6dc6qbipVddB9dKvvR02B?=
 =?us-ascii?Q?cID9AISLnPqBaweYJPMA1ZPz6rXBrzmi2dNCUYnY2Zg1MbGCPMIAWyr2U1ZG?=
 =?us-ascii?Q?p7lmVg6bhUFFjX9asgZwrp6KzMjOgndhGpyTofeQIgP+wptHWaZ1FF4O1vHC?=
 =?us-ascii?Q?RyOnFLxCPilhi4oH19QuS8y16rQmsupCbbjye/KWNwne2hk7JQo5oGdJdZE0?=
 =?us-ascii?Q?FJrCC9BvYsCZ3j1vpUrqizNjSTqe08SWHZd+rE+/6WRgZD86gA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 22:59:54.7347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b05c77-bb19-4fcf-86f9-08dd036db923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
Received-SPF: softfail client-ip=2a01:111:f403:2416::61d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum wrote:
> Few ToDos to note,
> 1. At present default-bus-bypass-iommu=on should be set when
>    arm-smmuv3-nested dev is specified. Otherwise you may get an IORT
>    related boot error.  Requires fixing.
> 2. Hot adding a device is not working at the moment. Looks like pcihp irq issue.
>    Could be a bug in IORT id mappings.

Do we have enough bus number space for each pbx bus in IORT?

The bus range is defined by min_/max_bus in hort_host_bridges(),
where the pci_bus_range() function call might not leave enough
space in the range for hotplugs IIRC.

> ./qemu-system-aarch64 -machine virt,gic-version=3,default-bus-bypass-iommu=on \
> -enable-kvm -cpu host -m 4G -smp cpus=8,maxcpus=8 \
> -object iommufd,id=iommufd0 \
> -bios QEMU_EFI.fd \
> -kernel Image \
> -device virtio-blk-device,drive=fs \
> -drive if=none,file=rootfs.qcow2,id=fs \
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> -device arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \
> -device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
> -device pxb-pcie,id=pcie.2,bus_nr=16,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2 \
> -device arm-smmuv3-nested,id=smmuv2,pci-bus=pcie.2 \
> -device vfio-pci,host=0000:75:00.1,bus=pcie.port2,iommufd=iommufd0 \
> -append "rdinit=init console=ttyAMA0 root=/dev/vda2 rw earlycon=pl011,0x9000000" \
> -device virtio-9p-pci,fsdev=p9fs2,mount_tag=p9,bus=pcie.0 \
> -fsdev local,id=p9fs2,path=p9root,security_model=mapped \
> -net none \
> -nographic
..
> With a pci topology like below,
> [root@localhost ~]# lspci -tv
> -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>  |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           \-03.0  Virtio: Virtio filesystem
>  +-[0000:08]---00.0-[09]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
>  \-[0000:10]---00.0-[11]----00.0  Huawei Technologies Co., Ltd. HiSilicon ZIP Engine(Virtual Function)
> [root@localhost ~]#
> 
> And if you want to add another HNS VF, it should be added to the same SMMUv3
> as of the first HNS dev,
> 
> -device pcie-root-port,id=pcie.port3,bus=pcie.1,chassis=3 \
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0 \
..
> At present Qemu is not doing any extra validation other than the above
> failure to make sure the user configuration is correct or not. The
> assumption is libvirt will take care of this.

Nathan from NVIDIA side is working on the libvirt. And he already
did some prototype coding in libvirt that could generate required
PCI topology. I think he can take this patches for a combined test.

Thanks
Nicolin

