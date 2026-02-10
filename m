Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D869EB26EC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprCn-00006J-CQ; Tue, 10 Feb 2026 12:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vprCl-00005x-Bz; Tue, 10 Feb 2026 12:07:15 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vprCj-0007oR-Kr; Tue, 10 Feb 2026 12:07:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1tZkevaAf5xdRXwtO9iXQqpNxjNawbqVP/sEi0vdfMv8ENlprRJg9OClr46DOdo75DT9afrhGX2w1zGtocrIcD0Mtir6UFiHtabIlRD8FFOPAVw3qvapQ0gDEnvXasEA90j0wFPBCR15A3gCi5uljRCqXHUO0pqCbcd/ZBRIxIQeCWrtGzDAOtYHQZMZQHD440Fw6tDH55cRHvuDRXjyOX7pIKcpUUYdNtx8MVykvYNFcxBt76DfjivPrt+4ue+9qACadfikPS3TfJnKrtB1yEbWy3Kp4ddhs5/huSfE4EgK++4xhq/L/muOz31vFBJYCe8WFHE+eNO0d3iP57Yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3lhe4oy41rGUV2heVsv0zSkMmwgVneX92pXZqjQMYs=;
 b=X66IGq9j0RArGHFY8NKWL+eBwLaa+nYfjPgwap5A2CiHU993pgohA9oYGqG1qM4si0I7ut6reufx4Yzg6iSJU3C8+rHBZLalNcv8W1YIs2RMnDCdT/KIkJE4gLljJ7qjU2nFo3+l7WzA+sG8BzFYDreYnE7MeRkU2mAvoYsC83RAQwx9pixUKEJghdGZy7r5HijBb4pX2vWRtAPGpKmfRfZNh/EnFAfPDLjJREQV4eZc3KQPqoeLjWuPLCkMUgYuvMFGX+2m4nlKWFrhXzHvHYbr7Xr3bhS2GhSaPW64h1DQTTBvO2gz6VZk0tLgMsJGDhdV8WEsA7xBAPWflw52bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3lhe4oy41rGUV2heVsv0zSkMmwgVneX92pXZqjQMYs=;
 b=SY3rQECuKjoUCjWJq9qiaJpNMTrtmjtXvNlZrdb1mknAb82LDTiUp3dFVxOjNhxp//tZXvyD7OYcGLTpVFfsSh1s4MfJS7e7di8UVI+IPyl7KErzrb4GcZ85BBg2Qiq+6TzuynxhPAnRGhNc2E81k3aj54dYzBK2XzvzDI65fP/lT2Az513qSs0WgnX63foZhMgSC9MSqIYM6rBGTug0Jv9Gv47YU9t/dLCNhwsEiSQi1tSS+QJWZmHhmbNwtoshnj6IadCKw1FqkGBYT3/JGd22No3k7QBg9wpViuV3Bgbn7fTW2yMxjFAriR8ew6GRW0AfTKUlkBaGUU2SljpXbQ==
Received: from BY5PR17CA0016.namprd17.prod.outlook.com (2603:10b6:a03:1b8::29)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 17:06:59 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::5d) by BY5PR17CA0016.outlook.office365.com
 (2603:10b6:a03:1b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 17:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 17:06:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 09:06:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 09:06:37 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 09:06:36 -0800
Date: Tue, 10 Feb 2026 09:06:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v2 10/24] hw/arm/tegra241-cmdqv: Emulate global CMDQV
 registers
Message-ID: <aYtlmjNSGgMHqZt3@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-11-skolothumtho@nvidia.com>
 <aYprcoyITz1GuPbF@Asurada-Nvidia>
 <CH3PR12MB75480DD532BC21E77C6A65D7AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75480DD532BC21E77C6A65D7AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: a078f5b5-0155-4a0a-7120-08de68c6cd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rmh00NhBkzIs4O0ayij91EmcsCpyJPEUFqt8/fVyj51imHl4liUBo8zX7TnI?=
 =?us-ascii?Q?ioVEneA9Mw9G0mAE8dBCeeub42yqKgpY/FUs5NsWYGtCaZQxFXV/em/Lc/n5?=
 =?us-ascii?Q?9r4WR0f6lAnHUiJb+owuiGrOy2PKr9FMn3inzdtTQJfDVlNfeLl/CyGB8I0S?=
 =?us-ascii?Q?RRiAbbVJ2EBzyXkNISXRBEnbVtc6zs5UAxcCM19t7DNIJhyfTTyAhapBSZ59?=
 =?us-ascii?Q?6IF0cQSpmt4mL5gEAcv4tcpLCm4g2WBjzGCk+68U3+OCmyc3M0cSMQLZG5Dp?=
 =?us-ascii?Q?LUWEXNYhS/qi7mwhm5DbGMiR08vqPu7LmieyobwhwPDzAyw4AzHRBE2pmNcB?=
 =?us-ascii?Q?CiC/xUeLdbCZiCDalEJk89uuxNJRBynpATKUEtmw5vVc2owlVLDMYeUVY7tb?=
 =?us-ascii?Q?XvJK/fHZmrsE59JThNa8q120RNwlIpzGWJ10NtXpsjL4qGM908b4U4fnj5Ej?=
 =?us-ascii?Q?70oTK4Xxn1tGmbJEqzXi2SXFKS5fCu35483IfWshWgw4rmQEo9YY9PsG7LxF?=
 =?us-ascii?Q?9ogqjC5ZJC3n6XDvs08d9JQ+pYWAauuVofFmdFm4nWHf9+GuCcCqGAs3dW54?=
 =?us-ascii?Q?X3pCQLzMlMN2TzgmqgYFFWO3enqGyQlam+65hj13mbefMJ3N4SX1li3md+gM?=
 =?us-ascii?Q?GVoT8/UafvM8xJOsz6odCpeLBS0Dg2LZMUFnbUq3fq8GV9VgmOJ6z60LV7bl?=
 =?us-ascii?Q?yPJPuRCXd9yHTUJDkrv8Fe2dPhAwQN40Pr03UU60L6nVCHu5fO3lYVWmuxfo?=
 =?us-ascii?Q?Y8fVk9Qu7XUyPLlZiaGyDr2cCuNAYp1mpMve5p825NCnQAL9x5RztX3qoG6o?=
 =?us-ascii?Q?zgXt4j3ArIEDPtGzmnkB3Bwup22urBuZmLNMjfFCopsLbpaJ+xZ6aa+Cv4BI?=
 =?us-ascii?Q?nbA1+If7Q5p12YOP/LMG9DtnkE9UC3khhI7ncgGPQrIsp+KM3+GJwuAPpdh7?=
 =?us-ascii?Q?Ygr9mK+QKVXlhVNpUMAnRo6nyZnT879WtTriTJ1C/Cc8IJ3wtc7uAiYmc+gO?=
 =?us-ascii?Q?Q6zYT5DEOGcuE84kTJzQfmAza/ToS6c4dzLURjvBWudOZ8D1l66Y/O+Wb0ea?=
 =?us-ascii?Q?ElVbEuZFPAq1xT65dpdvWCUp0FEWRnXuO4tjkPYH164B1ktbWSjRXNaKVVnF?=
 =?us-ascii?Q?dzhBbDG9ZrigtlYOqMycDL/9bEZmJMTNbIe5ymUTTf2PjI7uDREUCQ4j3d/t?=
 =?us-ascii?Q?e0H2UB7yPsAn8o/gd5znTVJ1bQobYaEd0XWd8pC0uAEOfh2CBC+wjKngA++T?=
 =?us-ascii?Q?IMYLdKpkGSRX0Y/ZsbegJwH4SIoIfWfZnN7Cf6HtH37Sv6i4MTa7KLtynANC?=
 =?us-ascii?Q?Kz7ahwVIobg7fFw8dNViRzfxADNIkFDgyJmEaruC+INBXk3F/HYl/e5GaZT0?=
 =?us-ascii?Q?0QxRp/80G0N6EWzt7Mcb/5AapxejAfrMzXbczddrLasEOo0VzlBcU3NKJc57?=
 =?us-ascii?Q?Z7n0W6MqwV1u5rrE9p1Q6CzBmIiEEH8XzGM5gkX5zOuUy5hkbB1hhE7nV6De?=
 =?us-ascii?Q?V6RsrA/MBgzERIf4Tez+mDWYc4aDdwr+agkHylOXc5MmGThIAZlMD6/zu6vG?=
 =?us-ascii?Q?glEBG0F7GI5jahwCZW+WNrCwqLR9ignDN8sDpaSRPn9L0K5GGIgzfyH00uss?=
 =?us-ascii?Q?y3a0hX1Tky0i+Lzpf0zQki4kfHLmesvm57KzcWF5Lr0Agin+0D6i7gtzXX8m?=
 =?us-ascii?Q?l+r/5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8hYI2xstx7FW9n274WKaUA+iE/5EHUk2FUiRExPFL8qv2E7W+IW7dcwydk/VXixr7GtlWrTB9uCiknBWVjqBqprcj4D7x1X0RUnUX2guQQpbWnLOoObA5xSYFlfqXvRlfUiNmUpZxDggzr6X0cu5or/s3OLdHOJDtXc4dBxgb8+X/keNjGDT1nqco5Q3RuuykyqCFcUeVu2tqXm59hZ6wcSp3c1kJ4H1KvghMHD2CriuZLFjlMZcMtPh+z/mdgGAws+OygWChhG+YVzt8qqLl6kvkTw2VccBKs3vmzfISvd5YjetzwwPdfGYllcWjwTi0dPCvejnYFYCKzDqagMM4WhKxtLll1A77ggGVH5xrGzwy5/PKXzYQXb4CMq4fsJGFsq3LuBJxhDOAe8ZHPuqrgrsAaQYNTaS72UpF9KbcBBnxP9t5YbUmLyO4QQzvaTV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:06:58.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a078f5b5-0155-4a0a-7120-08de68c6cd3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 10, 2026 at 12:51:09AM -0800, Shameer Kolothum Thodi wrote:
> > On Fri, Feb 06, 2026 at 02:48:09PM +0000, Shameer Kolothum wrote:
> > > +static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv,
> > hwaddr offset)
> > > +{
> > > +    int i;
> > > +
> > > +    switch (offset) {
> > > +    case A_VINTF0_CONFIG:
> > > +        return cmdqv->vintf_config;
> > > +    case A_VINTF0_STATUS:
> > > +        return cmdqv->vintf_status;
> > > +    case A_VINTF0_LVCMDQ_ERR_MAP_0 ...
> > A_VINTF0_LVCMDQ_ERR_MAP_3:
> > > +        i = (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
> > > +        return cmdqv->vintf_cmdq_err_map[i];
> > > +    default:
> > > +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%"
> > PRIx64 "\n",
> > > +                      __func__, offset);
> > > +        return 0;
> > 
> > I wonder if we'd still need to implement VINTF0_SID_MATCH/REPLACE
> > registers as it's a part of HW spec. They don't need to associate
> > with anything but register cache alone to support MMIO.
> 
> Ok. But I was thinking Guest should not be allowed to configure it as it
> belongs to hypervisor, right?

That's correct for the physical registers. But I think guest could
still MMIO the VM registers? So, what we'd need is just two arrays
in the register cache list to support read/write.

Nicolin

