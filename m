Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410BE92FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 20:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJdr-0000YC-Om; Mon, 29 Dec 2025 15:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJdn-0000Wd-Ux; Mon, 29 Dec 2025 15:14:56 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJdm-0006NQ-EU; Mon, 29 Dec 2025 15:14:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRzLPB9vnEI6utOvIsL+g0tTjcS2wt3vpfOcUMSqqgQNtCyfnPChSV8eHb783mpu2jc7hKCXvSozaIGI3VK+Fl0Vy4rHnJekIOoE5pRaVkZtnEj/j2+b0UVpJh85aaL3AcjmcHFsiMvIsjA+9sg8LtZAJB8tR1Tew5PVmp956FUoKtFgXqF52E/hbCgvnqsx/mVS364A9kYewiQ88oeHYYWMazBfCaeETbJ5kAMJPraokixT/SNP9N6mWhm/Sr/zM+qtbw0UAsKzw1BtHl4kyBmPgiRSVaXgLprHFiV+vw6hJtKRZnj8k5VyYpNCV8zv//Mg0TRSzyjcaiZJkOeLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfwAxKitftY9zUtuWU00iSeteEU9DTWYG4ubQXasdno=;
 b=cJPULL0OKMTe0kjGvZYJdrLoerseNUC/8BGnDNh1HMeIogF0sBQS+Lhbzq32u8rNl4QHLgwcWIu2Mu2QKFseg87nZJe02SUXeuk0tU9xvx3W/XzLznOvL685dTHzp28U7wX/mNokc0fCK8IxLsVaNEHean0Xaxn6p0l7SzF34zz6Zj4gNN6V3w+W8cD/tLZJlRTsqk0s511W9MmrX66mGUoG/NfEMcLVzgbiVl+fx+NrxY+RwzsJo68vM7wes8gNrv9QsHaZbVCLYX5RS1qkRuKF/fg3hw7aLz5HPdmi/Fx2ZJ4ykhlNhgUY16z0b2o12gcR0lq1e+QsrioFPh0GxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfwAxKitftY9zUtuWU00iSeteEU9DTWYG4ubQXasdno=;
 b=MEdDCPMomR7sjWCunO7CPoE4z/uAQSixf6K2xQBuZZfB3z8iGWXnFRe6Ny0QCeHA3R+PeU8spMpaijzLvBDv/QmFID7Ksje7FBhiLH1G4Z4Xg2sjtwla8XeG8f28JMLQRggLawsTLZiaW0kPuF60YZRwJio1t/407eXXPaeeDZUvoqshLQ0ECrWPKZTM5bARm+gsZu/uijM1C2hbW/nZ7mE7SY1ImQxCmTsBZZwNV0uZ7pGw4jzUML1LcYeFO6hdCfiUww13Jpxdk44uMLoWAqF7CC8gucluuLQ2JkcHol8JjJKBnVxj33YCgWtI7vyhXXNJxFW9YzErw7I4idJaXQ==
Received: from SN6PR04CA0097.namprd04.prod.outlook.com (2603:10b6:805:f2::38)
 by DS4PR12MB9705.namprd12.prod.outlook.com (2603:10b6:8:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 20:14:48 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::25) by SN6PR04CA0097.outlook.office365.com
 (2603:10b6:805:f2::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 20:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 20:14:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 12:14:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Dec 2025 12:14:47 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 12:14:46 -0800
Date: Mon, 29 Dec 2025 12:14:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 16/16] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Message-ID: <aVLhNYKlzHgnj9n8@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-17-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210133737.78257-17-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS4PR12MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a79d877-cd6f-4317-5c99-08de4716ea90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFFCSFBDcWxsQnhWc0pwNldmWUVVaGVkV1ZjQ0ZXbmY2ekNVL2lONVdaY2Rx?=
 =?utf-8?B?MTRjaUIrTHR6ZkIrTVJUVWxTMjVZN1dEWjNnaUlpamxKU0NOYWU4bGdmTC9v?=
 =?utf-8?B?RU42V2EraEhjSVJvTkRUWGdWNk5HTERUYlRSVFdRREdXbXZwcmFwazFlbVhK?=
 =?utf-8?B?OUNGNjdjWTdqUnJ5SHI5WXpyNStHbTd3d1hRQWxRK0RmWWJjOS9aWFlYT2xa?=
 =?utf-8?B?L1JNMFBlLy84ZjRQcHNxdjdjSU9KN3grQWNFM0tLM3BZVVp5N0ZtK09YdTIz?=
 =?utf-8?B?Y0k1dzRsd21VY1gwT2VCcXFTczJoTE15UDhoVFJvaXYwUFpSVmFIWDZSMHMv?=
 =?utf-8?B?M2h1QTZmbDJaU3U2N2hHeHpaMlQ4YnVQYjRPM0FpWHVpbkw2UnYwSzZ0TitU?=
 =?utf-8?B?U2M5c3F0L0FrcHA4SUxRSWlZSm96dFZkUnBsbEpBWDRUZVF4SCtkMjg5N1V1?=
 =?utf-8?B?RHFnMHlRTE1Hd0pmRnljVXk4RTk2L28xTTZpaFJYeVA0eXlYYjR3KzRmTFNz?=
 =?utf-8?B?UEcvQVd0WklmNDRkYkZOeTMzRmRsMy95VHYweFZpbGhEb0wvbzViVVkyb25r?=
 =?utf-8?B?ZndDRDdzekFOZFBxeEpDUnVNNFpHdndmV1o5M3orWmZuTGpnRTUreFgvMVdm?=
 =?utf-8?B?eW9zWFdacVBCU1lheG5wY003L2haRmhTZ0U4UHhOUGNLUFJYdWZ1TDI5VkVm?=
 =?utf-8?B?STdGUm1SMTk1alUwS1Y4SzIxODBWMlFMYWx6Qm5SNlgzT05DUDJmSUI3OUF3?=
 =?utf-8?B?R2RNU0F0WVkvRDZycEM1YmFuS1pNZ3FFNUhrbkY1dmNTN2svQVFxOVlxWWRV?=
 =?utf-8?B?dGNUb2ZRSE1FZFpaUnZZTDlUS0laWjJUWisxekpkZ05xZWpyMkRmeG1IUnNJ?=
 =?utf-8?B?Vkx1ODJ6ajVhck5WcDVacWt0ZnZQS2l5T3R3Wi9VdTN4NHBlQUJTT0pwODNt?=
 =?utf-8?B?c01uMVM2dDBFOEZ4cHkrSHp6RkFRLzB2K1dreXYrUWFyejE4SXR5VkJGV1JK?=
 =?utf-8?B?MDEzL0JjOUdvQ0cwcndiQzZVOW9OMXFodWJHOEg0Mnl6VHdiR00xaXNTSHJS?=
 =?utf-8?B?QXFLRXR5cGVSQzlReE9WTjI0UlRpSWZmOElGVS9hSVRGK1llWkpTS3hBaDdF?=
 =?utf-8?B?czhlVUVqaUd4cmJGaGxuMmw5M2ZLbEpLU2k2ckp0bVgzaUlrTHZvUGdUSHFZ?=
 =?utf-8?B?azFjOEpzYXgxQy9TZEd4anM3dFdZeWJEaTB4dTdJR0xvSitObG1sWjQwTk9I?=
 =?utf-8?B?Uk4xL2FXL05Ncm84VHc0N29JNktWdlI4dXJCR3Nna3dhVUhaMGo0amxzVmVW?=
 =?utf-8?B?aVhqdTF3dW9TVm83S0lGNFV3Z0NyY25jcGRNN1lpdHJFWjQrUzk5Z2hLV2lC?=
 =?utf-8?B?R1o4ZHY4OEQxa1dLZmgvVHY4MGRZZmNla3pjOEdtZTR2L1FpcDAyWWJGYXM0?=
 =?utf-8?B?K3B0bzBsT3gvM095SkM2NVV1bVRxREYwS1FiVjROcFZnQ1MwOWxhS0lGZVlx?=
 =?utf-8?B?OWhNOHR5ZWJvdmhNSXF0cTRqMWlGdnRMUjJ1d2dybEhUUmpZYU1RNy9Rdmp4?=
 =?utf-8?B?S2R4UU1BdUtucFkyVFhUb2psRGhDSWhKRGl2S0I0V0l6MUJJQWZsNHdGNGxw?=
 =?utf-8?B?aFhhQnhxNzd3aVFFR0I4ejMxdEFiRDYvenZkSDFzL0N6Tkt3ZVVuV0k5OUJQ?=
 =?utf-8?B?NkJkcldKQWZlS3c2dUNSaCtBMGU0SGk5cVdBODV5QitFSU0xVHFiWlV5SGRt?=
 =?utf-8?B?NVVJN3dhMUVlRnJjRktWNElsMjJkQ1F5RDlvMjVsT3lDQ1lzalNVbytqRUdI?=
 =?utf-8?B?RDlxN1hLeWZ4RkNMQ2hCTGhvRUJRSWluVXNvTUN1MUNJbkR5ZjBINWlySlhm?=
 =?utf-8?B?a012Tk83WS9lNGU3amhNTWtseDJzWHlEOXZKVFBwODdCNFg5NEJuSXFxbjQw?=
 =?utf-8?B?OTF3a2kzbzJnU1RPV3B6Ly9xOXpGNjVmL08zTWx4VDMzNzhnMzR3OXJGS1pV?=
 =?utf-8?B?T3Ezc3Q1dnZ6b0xydTB6WGlLbUZwZS9pWWJjOGxoREsyMHBQd0VlZFhBdTFx?=
 =?utf-8?B?NTl2RUw3dE9TRHpQTnlGMUtIQlAwWlpmOTRub05pSkxWS0RMUUxDcHpwOVUv?=
 =?utf-8?Q?Nz7Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 20:14:48.2661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a79d877-cd6f-4317-5c99-08de4716ea90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nicolinc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

On Wed, Dec 10, 2025 at 01:37:37PM +0000, Shameer Kolothum wrote:
> Introduce a “tegra241-cmdqv” property to enable Tegra241 CMDQV
> support. This is only enabled for accelerated SMMUv3 devices.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ec8687d39a..58c35c2af3 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1953,6 +1953,12 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "accel=on support not compiled in");
>          return false;
>      }
> +#endif
> +#ifndef CONFIG_TEGRA241_CMDQ
> +    if (s->tegra241_cmdqv) {
> +        error_setg(errp, "tegra241_cmdqv=on support not compiled in");
> +        return false;
> +    }
>  #endif

Instead of adding this..

> @@ -2109,6 +2119,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
> +    DEFINE_PROP_BOOL("tegra241-cmdqv", SMMUv3State, tegra241_cmdqv, false),

Could this be

+#if CONFIG_TEGRA241_CMDQ
+    DEFINE_PROP_BOOL("tegra241-cmdqv", SMMUv3State, tegra241_cmdqv, false),
+endif

?

> @@ -2144,6 +2155,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "are 44 or 48 bits. Defaults to 44 bits");
>      object_class_property_set_description(klass, "pasid",
>          "Enable/disable PASID support (for accel=on)");
> +    object_class_property_set_description(klass, "tegra241-cmdqv",
> +        "Enable/disable Tegra241 CMDQ-Virtualisation support (for accel=on)");

And here too.

The current approach looks okay to me though. So either way:

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

