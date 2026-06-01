Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684ACD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAmG-0005Dc-TB; Mon, 01 Jun 2026 18:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wUAm9-0005Cz-VK; Mon, 01 Jun 2026 18:06:25 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wUAm8-0006SK-9C; Mon, 01 Jun 2026 18:06:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwZTtcoQ/0bM1Md/eEvOjbeAOqWxgX9PZSsjqvFKz2nARtykY5zxDV4LFYEnXEq68mCcaZZfoIhlfnvmSJ6cxdZ7jLAMss+SSuMMM2MO8RHrTtVgHFNQIkvqBMzVU2qNncIwZVZ5ulPtdPFmV4RSkOeam9xiQT94oSQK8vV+X0wS51o1FvhYS36EctAcGOojvVOZXzMV7T9knW8yK+fw615DnkmUlEG6zX/cJS9ioPji/i+HfxvMm63Fxyyc0IiaXXsOs1d3Sm6+iMQSOWyIs0i4N8GdyusdJR4OzjwH2bqxfT90SuRmD0wx7aUF+7TynrakCP2I+iensh4vMvee1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgI3H0OEzGj1ZqauLCnL4BDmF0cOGENZ7c3CVRb9tDs=;
 b=ym0hpMQNn2F9oXpqAVRwR6ABqlmb4SRt0KTVFrobdet4IgJlcXgFy6o1kCovARkQ11nUwxHDTd44Yse2htNmHOexzKHT//JrMHBa5OyeOg1QD1VnQKPhKh3LYjaoNcG9KmS668OO8C/Qhzn/PdQX0oF8DMdtP/kbkXb6LKFd9tyQtFxWChrI8uWiOhzWuZQQ1fPEahLZ48Yxv7mStkMZ3Obuc2psK/yzLZ6HmFF+0nurhL4cJrUeFdSWZ2aBI/mxlVDJZlL8YKqNCSUlEEwQVkCaLkWBDFexiLM2ESrfHNjPPq4ftXezugkosGCYqG4AQvwudh2UcEAVhK+aDVHs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgI3H0OEzGj1ZqauLCnL4BDmF0cOGENZ7c3CVRb9tDs=;
 b=E5GlRDcnPNfOyi6U1EJiO7QJn2e8FPiw417Z5evyDbVYN83iSQfM6itbKAcTZ0fJCWGD0oP7XVLyIJxrpqmJEBWDwfVdPdC2X8Xyj6IH07MVvc2hY0spayxdGM0ekrXaBo3s2O02hT5gkcGvXP5oyCCTbVmcY3BIptRwfAwy/8qmMuDoLqUiAHd3mAuXMRwbx/geSBHPGWCzrG49gX9S0GFHIG13F4dx+S+4Gw6DQ90Yi0mdgKD8fZ9CYSDTrt7Ru1laU8UupfgcRmMh/9x5vQyOFbdX2i8lFK4HL5bhw7/qoy/HjX5heHCfP6cWmhcVWipbPZpgpCtfgOMcJ7W2zg==
Received: from BN9PR03CA0190.namprd03.prod.outlook.com (2603:10b6:408:f9::15)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 22:06:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::43) by BN9PR03CA0190.outlook.office365.com
 (2603:10b6:408:f9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 22:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 22:06:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 15:05:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 15:05:50 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 15:05:50 -0700
Date: Mon, 1 Jun 2026 15:05:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Message-ID: <ah4CPKqNMnRfuSxT@Asurada-Nvidia>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-20-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601114221.457995-20-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 25748f12-95a7-4cc5-df68-08dec029fe76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: tuh9ws3WL0kAn9sXy+op5vN6n82LmFQaMtTw7fvLPIOw5yEKftp6qY1RmkZJEblOZIFcFtVbBw+n5RY9SbqwVa0fpSV3VVw44E8Z0HF6X31BENa5kIbmLP5APNgJbrjNkr0IpfoX1QvkVMjgZSsamA//kGwJNc1z9aUnb/Uj9uetH+Dvobiz9U2pID1/b6XOC8Z3bdAnUPKYQWNpsZCCSWYB1pX1JUuqk6qxn8wFS6F7CXksqqaTlyEGqyma3A7FDS9fSfwGAz7lUUqS1ltECEFyeu9BWZ3BnQfKLEcgOR+MqhRIVg8mveCbIudWXmbww8Ttx4F43ZtNVDpq9s5MtDHIomFLDbgNK52JdT22JEQ5zXEbm3hoD1IfkeYPkCN8il1unKRuKsCekndrKRoXzaNlw6obCgqPDZk3a4iBWILRRfeYWqNrAMxrlFY1IAftiZ+MtGa5ZSEUnZgRYwl1JJzdTX5ThfGj9j2fkIoSW61z+D+n1T7IrG66aDnEbCkupHIrIvY+AtC/SMkx81q9GVGBSen8Ygbo44TfkIFRVlUd74ZgvYGpA2u9hOLusNDePHk23pI4QfQ/yWwolF6AgQAYpmslwUtAMn8IilBou3HYUy6O5uCYl+BVXGZHs/kaOiKlN1HZA+mGDmU2obdzXvv8++YGyQttiEH1nWSRhrWxLlzdNN3l99WS3TCHoq/fYwgAc7TY/tegEPJLltFM6wwQzzOPIG6WKiH0M5HQgY4=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E0fzIvsFtUkLmu3Z4NIL5rfX2NSExJZuRDUdWf3YWjtmcvEi3eU7rvgd2B7L4YHn6JqWt3dXqYomeSlljH7LaCO7koHcL0Y5zvUKXLjSshDr8XFY+fdcpg27B8p6eyOsPXVAiQG4Ol6nYMmjbKAYgx/qLh3gjA+RywNShJUHglzNuoR9dJf8g6ForFn17CxipFnv09xfcOhzZfQoGqLO/+uB6/neARMlhMrB80717/92PSRHDC2bHg+k2omenwdBs8wWPH3ZbGbBAT6yY6xoRKBllNhbZdYEzFoYKbRa9QKKY8K631LbF9yQb4rf/gyxqJnhl1jJUI/6KpL29lRDtd5jBZmM1Y8D/iIZsKuIE83DlFcqlF2jRPBAZNT+C9AM5DPd8FhOFYbJrcm74dJFc8QX44Ys1TPlD96qACYV3HqqL/g54i52xTNkoCo/P5us
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 22:06:12.6639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25748f12-95a7-4cc5-df68-08dec029fe76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Mon, Jun 01, 2026 at 12:42:09PM +0100, Shameer Kolothum wrote:
> +/*
> + * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
> + * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
> + * has no hw_queue allocated or the VINTF page0 is not mmap'd.
> + */
> +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
> +                                                 int index, hwaddr offset0)

I'd do:
  tegra241_cmdqv_vintf_lvcmdq_ptr()
or just:
  tegra241_vintf_lvcmdq_ptr()

>  static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                                               hwaddr offset0, int index,
>                                               uint32_t value, bool direct)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_GERRORN:
> +            *ptr = value;
> +            goto out;
> +        default:
> +            break;
> +        }
> +    }

Could stuff this into the helper? Return a valid ptr only when the
offset0 is one of these four registers; otherwise, return NULL.

Then, here if would be:
    if (ptr) {
        *ptr = value;
        goto out;
    }

Doing so inside the helper could also sanitize the other callers.

Otherwise, looks good to me.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

