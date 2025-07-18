Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD99C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 04:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uccUS-0001BK-5L; Fri, 18 Jul 2025 00:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uccUB-00017n-Go; Fri, 18 Jul 2025 00:14:17 -0400
Received: from mail-co1nam11on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2416::60f]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uccU9-0000QU-NU; Fri, 18 Jul 2025 00:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxtHjzkN0Z3QMU4xwPxTSjpW8DUhmEFf6ChNamd/C3O54DASUI5i2xWCnA++ndm2VWh9auvkwWHGzbtJNSTmnoY+ra196w7FTunehkSuGsMmdZr2E+rO2kyaNYZAXieqqV4WICj0mE8Da8IN726H8BQl/2U/5dmWMLfgPZdyJEBKRxISgwiz1wPmI6gc1ZjUqyYC9hy97X+EemlUG0SKjwG7nh5n5hF5II7z/rD8r+xifM0oeDS2oGsCDXEY9pFZdLvsMlgn6fEa8fbiLDnZ1gkoLkwmv+c1IJERtHZC5xWnvGGCTpqLs9JxHRd+ZIT1nnEG1O3GcUQ0MsmYpzv8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8NcY98UzUkK/OOhGHJCrMWYku0hO7bBEC7lPjjKzh4=;
 b=kN2tbvWh6J5mHzsbHOALNUbVjd8IjW8eTOoT6J3qj9Y++OHZeCqDdiQV+AEHOwGb6CFHfNRRB2/WZ3LE9JSc6OFZ2hyBUXS5j84Zeca0crvX5G70i+bOJNCT8bok/rLcP7bwmB5U4jtHlzka8kwwpolfo07SH/D7jwJwJZCCMk2K4U6ehepWYr71t1kqidUU0nUGVGuymAUepxgqzP1fRT/1uYplvYsgJq4uwlRk3R6XmcC6Y6RDEzzMha7U2E0Jz2aW8VQO8y4Fh6au6Hps8HdRY83ZJn41XfnOwPmjazjDvZef13oDVzjTXAxwMXbs75vBU0wEwisB3WdDXWoWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8NcY98UzUkK/OOhGHJCrMWYku0hO7bBEC7lPjjKzh4=;
 b=H9c3dc8+K69OnAsJOM4Wv0GaAMKvgf8I6iDEfBtLSmFL1NgFVcnE6P8SBUY0eau3XWSBuNYv2R2ndrqdl15Wj4MXLVsrE8hXcGoI6GAJtYekCkcOxMZISbXDOe8Q7eGd7biQVuecNUr205+qTwGhCgC6E020i4V8fTIHv9486p+Xba/R9yZJCWsULxos7RCfG0hPkcaVR6RKjqjIWX829td/R8cb7MmhWOgklZYifuNqlOrMIxXCZgiBaQmz7mjLCMR6x1ikIvDF+ikbEQZ5fXEfBJvNCwHiqI2NywZe/EPTRdS6M95bkE3H+v2ZXUv7mEKo2vZCMwhGyTDu1YE2JA==
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 04:14:06 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::79) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 04:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 04:14:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 21:13:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 21:13:49 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 21:13:48 -0700
Date: Thu, 17 Jul 2025 21:13:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v8 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Message-ID: <aHnJ+qUsVyu+eFaT@Asurada-Nvidia>
References: <20250711084749.18300-1-shameerali.kolothum.thodi@huawei.com>
 <20250711084749.18300-9-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711084749.18300-9-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd990de-a21a-45ce-7eff-08ddc5b18920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?famJL+KI0Yi6xNA48KMKPN9POi4kO1PRdwizMTjLem4my8DXs6Mv1WHMkbFT?=
 =?us-ascii?Q?oKIcj6OpMMxnCDYhj4zGUID8zLo97/kb2a/ySP47R7MsSaRP1D1Y4MxsRqGb?=
 =?us-ascii?Q?45CQDeGzwUGonO9cJdV501JM81bYCuFtgnDmlxigYCesJwCgiEEg6KYJe5bI?=
 =?us-ascii?Q?HauwFf10UFm9UchxG8H3nklm9akECZEKVjzSaXoumellF1fJ/+b/y/Y/8+EB?=
 =?us-ascii?Q?vvw0GlbOZkDafUfOak0RFoLgGquIcWIEHWFKnjjnhDYr8EeoKSd60zxx3Yfz?=
 =?us-ascii?Q?2MoXpTBcRrTQjlP4MrdQmyBhgH9n7sIjF69vWW124/91ozDocQLssmfC52l8?=
 =?us-ascii?Q?vs6n08t4TjXN2Icagsy+A5w6u8L7/GdVqbXKUvc4hSjsxw4d0yZFZA6GK1zy?=
 =?us-ascii?Q?iUx5McCz7EgkPxR7V5MQki3DpwVuBdZ9RcRaEEtkGBU+CI5T3heN60J4LAyC?=
 =?us-ascii?Q?CkFBUVxMrtyPcyvwu5pgpx0oSpl2DQa8IjSYOOB8B3SglndBDImNGHeLF4Zh?=
 =?us-ascii?Q?MnI6yh+sSG0p0qfXArb5G8ZWsCFf5DiwftCqossuY1ZxKfX+nH4LDlJ0BhXj?=
 =?us-ascii?Q?R2jwV6ISDw/BezKqhmwQOUqx3vmpHu1C8tachdmsVIQXiniy1F2sU6UUEhrM?=
 =?us-ascii?Q?RVlGr8l42P7QwNJF3p2SiPEaar4zNkhjuYdFJnJ3PeqD5oQ6yYKBZS7qP2ON?=
 =?us-ascii?Q?PConlEkD3zEYTC7W1078ID5vzHrAMsXYJ6lZRHDqWMVu30wz0XAjdggUDZFE?=
 =?us-ascii?Q?JvwAOuZHPW+q3xq5REmlvy1ELQhIkfBzjHz1LByPzfvvK1R1RdMyg+N2x5ad?=
 =?us-ascii?Q?Kr/E+qMWBMtYAs7/HUCgAQxaPI4K4RkuVkYOeQPVYySyegNn8sko28p9sQym?=
 =?us-ascii?Q?mVhcd7qMLKS3nYOuVtTqx52B/1M4r0VcpKyj+9jNqhBywRL1iB2Lnf9FWSjX?=
 =?us-ascii?Q?xbIeYMMC/GQM/DVdIYar4rG5rXvKetd5hRJwhKd4UEZGcJGgiNrJfE/i1Yz+?=
 =?us-ascii?Q?erpqvVQD3iGl90f4yBpMaJmwC65VyKimw4joa5wUa1uLgK6/DW+Y/lM08emc?=
 =?us-ascii?Q?QuHuhLjS4TlWurxc+dS3xs4j0ou1Gi6joI6aCvqWo5HwkkyFDY645qWk49Es?=
 =?us-ascii?Q?TFgXLQbl9TEkR0aXCSKmFne59SpCvpJkEM2UDmTSe9bTfPokNL9elYjX8jb1?=
 =?us-ascii?Q?F5eAz2O9wDxWNywfNw94tklgCyN51AOIYoi2LBVe45zPw6tl6g/hLc6NKEo/?=
 =?us-ascii?Q?JgqrXhKklzsfaPW+MDqj4ZPae9miTwOSb+FiJiPkaHcsDME6UL3GgfNSNKfa?=
 =?us-ascii?Q?0U2gGKsomwV6dUIgWDF8m5oPq2f9aClNJ0eBZ5XBUkpIdwqOBI7dFPX5f0hq?=
 =?us-ascii?Q?uKz438HBLM5YGQdp5vjazEFlRF1a1mlWxUEV6GQg95fCONeOc7C3M2u9bYTJ?=
 =?us-ascii?Q?d4KLhiGZVMQcr9sx1nGuvMWvWJoIu4tfKehEf1R8T6LhVXst62f1GPlJg2UG?=
 =?us-ascii?Q?uLLoVAddAGn7X1jIhWv+2+uC7tLVy3sFRfmQ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:14:05.6276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd990de-a21a-45ce-7eff-08ddc5b18920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
Received-SPF: permerror client-ip=2a01:111:f403:2416::60f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Hi Shameer,

On Fri, Jul 11, 2025 at 09:47:45AM +0100, Shameer Kolothum wrote: 
> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
> +                                  DeviceState *dev, PCIBus *bus)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    MachineState *ms = MACHINE(vms);
> +
> +    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms)) &&
> +        strcmp("pcie.0", bus->qbus.name)) {
> +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
> +        return;
> +    }
> +    base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    irq += vms->irqmap[VIRT_PLATFORM_BUS];

The code is fine.

Just a related question here:

Do you know where we define the number of IRQs and the range of
MMIO for the SysBusDevice?

SMMU has four IRQs. And I see multiple vSMMU instances do have
correct intervals to their IRQ numbers, but I cannot find where
the magic is done.

Thanks
Nicolin

