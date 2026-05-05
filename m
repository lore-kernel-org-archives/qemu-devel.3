Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504BBCD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4Mb-0001Cu-PD; Mon, 04 May 2026 21:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4MR-0001CK-9V; Mon, 04 May 2026 21:14:08 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4MP-00015X-OR; Mon, 04 May 2026 21:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTRNeBrZxnXjrVG5HyRIove34gSm00gU58jmCvn5RKlOyw1iUEQwMb0MOzLTh/WuHHcEjORBpf2DnqHic1LT5z1hGsold6IVnFuhaqD9++ZQ9qtmpYAJaZkFyZCvGAsgXL9twND3FsBheRGfOGIUjY0GokmVUJ/4lsuoUW08hzuF0zd1NBewXZbc1w5pc0x+9FswTdxa+1daaE6NpO3kq5lhiLH6RQxTfITgiYa229Tv9AgoYnJUeAowMP8lsoTZiefS6bgNpywnixLQc6RkZeZXN5Saym31wPmnDG4lo2AIQuYOTsG8s3o+F0f1ZJ3kpAvtTypikXNI/S4DNQhleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6NzTxsssJjO+GJsdfwZWkEDJuvkcV0VLhiuwjYrsFk=;
 b=lZ+1Zqvb9bCMAfBcOmZ3goKz6iyrfxzU1EnFAYOqKcLqKkvMwJCSFM0WoygSEEEMV6HtLCa3DEMIF4rxCRJluCIcRfMkBqbqsfwjos9/Op39Mnu4dUL8KvfxHRrUufOXnwh41gnM/PZRqA5dCK2RsUvH+9z6WbUHkZBztUXq4bnawd5dC+yAQhzgnOzjDEqRCD1AJskzlidFsybfE+MqiWe5pN7t3o1DEeBVWqdC2/b/ykQPvIMhK+XxaUDhWP8pcyLJj7GirxxXxcBEkV/Nsbp3jyO0di7efwZdi4Yszg7qt3357Aqmv0ErH6sgAmAD4y+7NGV82iidCY8cjCuUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6NzTxsssJjO+GJsdfwZWkEDJuvkcV0VLhiuwjYrsFk=;
 b=VaowtPtmzsgc1MjPCR+yp1/Qz0kdl3Fqiutgvyv45ax83pQ9UWq611DkV6mF0TbT1LODyP9wdFDOjAsYI70ifsy0ddBgUJDHOo8iFBtcC11+ArisCnSQQKKWK9CuSpuaQbckk0HBx4s2oFhJ+k+XpBHfXa7dI+6z/WmeeOqnelPHD0ditxmZd7olqixvAmWVnjd6TtPBqdSGLU3nPfNpY6jatcsz35diIAm3KqGtb9sbLAj24AhCF6dFCpPWIfNgH8hD+iAxpBfs7TTfaFaolV9bNlXHz9wdLdy1ChbAcj5lYr3mjH2mEQ3WlWu+hXUVlRU3wisyBbJmkQE1TAsPqA==
Received: from DS7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::7) by
 PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 5 May
 2026 01:13:54 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::6) by DS7P220CA0013.outlook.office365.com
 (2603:10b6:8:223::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 01:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 01:13:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:13:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:13:40 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 18:13:37 -0700
Date: Mon, 4 May 2026 18:13:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 24/31] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Message-ID: <aflEPzS+OBZUyD3t@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-25-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415105552.622421-25-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 046cb3df-8391-4f66-272d-08deaa4392f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: H88hG1+xM4F2w4dJqXIhMP45kfn1T/4zxjqwm845gR1AWatX3iXJ3Lzb+3OQuZEekrK3cr9Xrw/s8RSPzlMUNJfQWK+RUSHwbo1Z/EyfBdeplFPr/EcMkAsMLBXCJovpxIq8A7GOhfeecJkS6wpvXthX/JfpwXRcwD1EjCGn6SFWJNsSTQB6yiOiq5CQLTChtYGoRQExQl5eCOO8lSnOv/PddXeZSPaxvyBfxfnhXna01bMPbHAOIQpa5sVALJKCqGBW8kltSlPxeD8ThFVspk7NYxvHnig/wafYLOImKPZP17Q6bQEr7wmLFLwtE5AC7gMO/R3oNm0JIU7ATDXC2SXC0bcsPEu0p+SMPZzF2jauEVJ8grKEFFmMFS7WGHSxiqhvIVYPeWWaFIcHC4RLDfYKcRCeUQpfdYuPB2hd1wmI+hRVbFnwUrj706FuzTCP4XLXDfFXRr12MaRxvFsSut5YV8sUF3iCNsV0CHNnUtnqcGBQe1k6Hi3t43KnSOiXUBQfZeitKKDadGUOTHYysk5J5EcCGvSpImax7JV18t8N/Bz+OJZ+tlkbLuXkWzn9MS90u7tL/kw3/Qz3x+H8rquqajLsxVa2f+2bXKnkSGXpF21lka3cS3FJMNhvnLOUOQ9VZi1a9JqKl0nwKRLenIfY0YdGm/y6QEt1Sa3+dBX2JpiVpMAaAtfPaJ6qUF1jnrD8CoR11zwB4R86aCKMpVugzfg4KlzGnLAIPkigL1U=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZHghrpIl5P5F2gShw+QXqJxYRxP8dIQpDATmTRevk57P+KPTAV/pZEepoe9JPPgMrBVZ8+eYsf5GHYNFEnOe2WAPrfFW7pfXbcs3IevWWrK+mSVuXDNd47Xiwd5GhhX9voQyYL9c0vq187brh9JX8ZYtKT8rAbqyamoUwMHGULOEKJwapfLR36RBMMnUMA1Ciio+kG3QrJEQztwjA7Q/JtbAEovGbUBzFTdF0kQrKW5Szh7lBBiQg3IfGfHM6BMA7GvismDAAlOWB4T+sr1ylOqkSgDF5CROe6/frq/hUE0rIYAuJIbPkSUH3f49yX6ByReVyNDkq8X+A5EJmBA4sJv50ea74J8tt4gmB10mB7dBttY/a4ri+FRJxkhcjGBTwA8uAHGAxGgjPcVVwTkv+WSXuCIL0N/1lOEY1WCygv5vuKD7Jh6sQutPKu4FXuRJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:13:53.6619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046cb3df-8391-4f66-272d-08deaa4392f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 15, 2026 at 11:55:45AM +0100, Shameer Kolothum wrote:
> Install an event handler on the CMDQV vEVENTQ fd to read and propagate
> host received CMDQV errors to the guest.
> 
> The handler runs in QEMU’s main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

