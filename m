Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D3FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4eT-0003yX-AJ; Mon, 04 May 2026 21:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4eO-0003xr-D1; Mon, 04 May 2026 21:32:40 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4eM-0001YF-UB; Mon, 04 May 2026 21:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cnw6HccgXhY0HCcqQqdmffSeXyrU5bMq1ALCs3TPtnn4Jt7j7HG2QEVjcSUeN/rk2Wz5damPj6T+3T4225Td+eWGfMvH9ZZsQPLIWs6jHoJLb2GVRtvnpf8PNsQTNx8qvlf477VYpcGhzTlxqKUZ93gFqCNXSjV79rdGLMkr7gpjMKeBKadNypW0VCV/beFrbY817XAXP4JZTUHLrh0WzkQ9CoY0V32hx7xLmhOQR5A11vNHtWnSw4slQF6p2j+cUsa0Ildcj6JvaTHQe03EqQeT+3lYZiWKs2MdcbhrDqyeBFtZtFYU95xA7DcBmCHTykrdhqpiCQe2Q99z7BdKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xacjv7IGqp14+0SAgmwy6rcJGu6ncQn4aE8TvTegVJ8=;
 b=eEzjkvPs80BWMyO36yjyYY5Vbg0wTbdptUcEKC6tCngWkdCt+WcQ5rlT4FqjDeFxxztpbjW9i97CkpwrFgfrlTKgCuukB+kbkyByOMdwmXHZBhX7OnVKP6j3B3ZfWFFIshr7y0hGenEGHb3GMyAMqpFBB8toMMRgasadH+RVbvyXcBKG/uqKge7tKh3FgVxU9AQhruFEQz+pLH6OAfg+4+l7hkpHbIDNZYkUADcdNPWSmyA/KS+3nx4NH3yd7jsKR+bLHRi9UutvXBmAaDENWPTf0hjG5p+DXPiPkyucsJCkRJ9z83mOGV48h3fwJ4a5t0zlCkUR1XO0J+QGVZQh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xacjv7IGqp14+0SAgmwy6rcJGu6ncQn4aE8TvTegVJ8=;
 b=nwkB1geUguuCQlJ0ZLeUpxrFJ2H0XLA4ZdagQgAupIqu0yJE0jYIhifA4mJlSCMiZlQltRtSLf+xooqLD1ZHZW1sV8RUkO/T9iPJd6LBOvDemcr+WHkCFOs+ulCcGfcBV2pX+ig3CeF4tOW9Jtc0iz1DnyouTILQegroqUqDNAEekufJoYzKhDx9ptGh1z8FYBVzAQvV+E8ZPo/GLMQlNgP7VWTqkSUX3h+H1Jr9hjTp2qu3zmmIoAXBRNM9MZGAPx7oeOVbdolOZxBK0ba0IFjGVvj1WnRwpz1HWHPfpSmtITAohe1MqrNksKu6+2DBUkspe1ZPrCf0T/BASCstlw==
Received: from BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:32:32 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::a7) by BL0PR02CA0135.outlook.office365.com
 (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 01:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 01:32:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:32:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:32:12 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 18:32:09 -0700
Date: Mon, 4 May 2026 18:32:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 28/31] hw/arm/smmuv3-accel: Introduce helper to query
 CMDQV type
Message-ID: <aflIlscsgkjxZAAp@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-29-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-29-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: baa19285-40c5-4a1a-3a06-08deaa462d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jeSJrEg6jLDWaLZaiqz3/Jcn7T4Zpn/9mv1T4ytruXGQiRisY1+APqzG5cVRV5dyG2RaqE/kTuv85umb/2+zFQ30lUgI8mxe8c4bbdp/BsYMMwbS2A1hy1iqi30DW0n4StW5aUQ3oy0dYbQlZzZ11gjWcgAauZAIE6uovt30E+25osyI3mNCG3NB39qzkiy3z62/C2KFiiRnsEHx4WOQDGgYVUwcRk6eF6Y4nfranc0NJM/6SsC0zGbhU9lLaSbbE9JSkfq49AohmTIHGIem9zsDmTXEj33xD4D+eFcz02MIsCBfRPUCg+3NjptBaeXMW9gt8pweiQM25F3anHO4qFs/fAK/oovf9d81oZQZXfMj5ONX3+JxkwIXWYM90WcjQUcGeTkDPOZi+Ch9RhAxCujIL8JpMoynjYcE6Fj8T9621InSBGJQ1beRy9CVdKoqx5cB3zZL1iVrvp+fVAq14MYuvIU7xJ6Ys5E+N0AiGMfz+Ku88B1eS2UMbgzRAk/8XtqDU6DHppycxB7ghBYJkIDNWHQ410zSBoBgcnfjewkp8tLSaC9eb4tkoprn7TWeOXGmx/Rdv1IWsyw2sL/PRJxi4gyzoT8icxMlUEWaHan2I/t1vqTbzaakvzKBqA7nwa+tlsdIGop2x6OPypKbQQQOaVJ1ENrlu1Oipwg2zPEAE9fCWgt4QEmhJ9ISxzzz+gtgmI+11AwZXqZqjbQ5u09N+D60dLVVadIttszhz5g=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GVqPKfGcEvb1ku8zcns07XbRgZJQ+VgesGXQqXoogvbSJQcay0wpzQFE8VdCoE8g/g60qH9bKiERumbdd8zmReg919nf8EpfXt35Fy9i7IbnPgWg5zuBcMTwYg+1K72FotjJgfje0m2RZMXsJ43VxWxDJFeJeN42PLhAkWWZ35Y7sRPfP68QnFNnEZBxsmJS+y10k4S07gdDdXzvT5iC9kpPGnCNfpgrmttpYZ2hBgidXtfPEnHgfWmdDHmlORwFAGtFSZDs3PJCgq2BivrqCBDAubJTrRPM2LPQsJUBmbE75wu51ZQsE0ue6a8vu62uv3dvm9ACFcSOJnAymOGZPBiOyCR1D46zWkoa3k/jaBMdZ7PhvYLuFHGqavEt/0aDMbydgDqJl8aMLg/LUSxI+E+sAsqacAybq2UhNcZGI0TncIlNLhrcR6TDvmq/nTTN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:32:31.5503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa19285-40c5-4a1a-3a06-08deaa462d49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

On Wed, Apr 15, 2026 at 11:55:49AM +0100, Shameer Kolothum wrote:
> Introduce a SMMUv3AccelCmdqvType enum and a helper to query the
> CMDQV implementation type associated with an accelerated SMMUv3
> instance.
> 
> A subsequent patch will use this helper when generating the
> Tegra241 CMDQV DSDT.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

