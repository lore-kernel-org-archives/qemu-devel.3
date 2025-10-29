Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0885CCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 04:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDxmY-0005aV-0V; Wed, 29 Oct 2025 00:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDxmT-0005Yr-JP; Wed, 29 Oct 2025 00:27:30 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDxmN-0003KO-QO; Wed, 29 Oct 2025 00:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQFdN3px2EHH/SmJDFfIJ2AsETO8o7ewwb9kbJ3XVx6FWagU0/6Y0zhGWOLFCaUtqy/maesLtoJtFWulZx7F06/LM4wVfoENjxj/pSpRnwCS164Gz80ZDN+ElXN5f3g/RrcYFzXGu6CU9x5zeepJApE4wjaQ5n+U8yMQ+u0SB7xaGO7nGi5MJXQu/HYKCKztePp9uRiqmooXSFUlEcExjhmtBVmSodbcF3opqOEWe6E3k9HqG2fsLt7rTNrvaH2UvFtNbEHoCEeN5ro4u3uP1dUhKCDNpmzXDRDEFq2EkfpLVN2JBgRbl5TUgWg9K/qUB8VT33/pXiBnEjEko0Xxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laV/sKzr99pyp3tUeBKzD1oZMdS7ab2LEYHqVwuP1Ys=;
 b=cDXqqZAQV6Frmdf1/9BNcObOE0OGqkOMVAwMBhCHi703FqBsE1ZJHGdQsm4Fvflk8osXZtpFrMY39hmDiZhc5RAzETy3JsR0wVmJDq27SOliV3fjmgb26+6CTA3VyM6cVLMfyniKrzCaabXUKs+zW+Act281muFocaMxk8p6XXETsfkG9id0T+9sFLxlfrcz6OlnNJo3/JO/dCILxhnfkZ+xuA9X07f5p+b82lTd9vzhv9hstBlTyQ5Sh+mxW8m1hM4h7wrAZKbUL+kW2uYfpJ1kEliNbBDd3gxOO8maxkDzKgVBjIrFQaCfHqfMzFzgC3tV8x+IPhndHMd60xeWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laV/sKzr99pyp3tUeBKzD1oZMdS7ab2LEYHqVwuP1Ys=;
 b=Ktwr1FaIv1ckeU0HwvO73o+fGcC8HT1AeOK/hyojxEXzzgb0SgUn4wo8+6JZE/pF7+ePB5Zzfx+LI46co3NR91H0BjpxwDnPwQ1oSLdnuZhp0fz32n8xirbKpr16+5GCMmTUpRjM/+9lMQtkjw4+fE+zsHKmqD/svrzZo5ZC40NrCQsc7wiv8d3D9OBILXpPidGnr1o12iHrT3ysRqZHHjgXODdhA1YLBdeMaUDmbpnmDIBYfrqnA125TtjfJQ1SU6HIPdwPxsl210DcarBCjcMrjsyc5FvjlFe3bojpwkQ4DbwMKU9dQTYZvAVDQZ6QaVhZxmw/bL8KJGOrX8CtcA==
Received: from MN0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::6)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 04:27:08 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::69) by MN0P220CA0014.outlook.office365.com
 (2603:10b6:208:52e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 04:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 04:27:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 21:26:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 21:26:51 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 21:26:50 -0700
Date: Tue, 28 Oct 2025 21:26:49 -0700
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
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Message-ID: <aQGXibWAiMpXAQlF@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
 <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
 <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB75480062975BA40AD454742CABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: e82ab1c7-3482-4880-ce9d-08de16a36c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEd6NmZLVHJkaEdHazVrU3hQSE03c2FlWGRnV05rTFczWThQQkgzSERueEt0?=
 =?utf-8?B?OHc2ZExrY3pHUHBoQlFyTG1PdGxEMmk5SWxCeXdGUHVVS2pWY1dFS0llWUN5?=
 =?utf-8?B?bElidE01b0pSRDZjRXFGME5NVkdqaDZTcTNQUTJlQzFpbTRPQ0NHaTA5K3N6?=
 =?utf-8?B?eXpRQzZaOHFpUTZwb1lBeVdVRDJ2dGlONkRVK3l1OVk3UGR2b1JmbXdtZGY2?=
 =?utf-8?B?YmU0NTdQNmxHSEdjYU9GRm0zV1pzRVM1cWVLd1JGaTY4OUZCMCtDRWd2QUNG?=
 =?utf-8?B?MTVaYU5sVTlCc25jUmtoaUU3dWwxN0JZcEpEbk5XWjhxYi9aeWFRVzRvSTlx?=
 =?utf-8?B?YXV6R3NqbXdUY3NLa0tQbU9RdTB4M0YvNFR1KzluZHlPMWRLcjBJWmdEeEgy?=
 =?utf-8?B?YS9ObFIxOERqNkt3NFFrbU5vclgvM0JadlVlUGpONm10Y0RYY1JSSGluc2pK?=
 =?utf-8?B?QnNDYTZXSERGSlhBajM5b3VVRHhQcDg1eUZhTTEwZytQM0V5Y1pZWU91SWMz?=
 =?utf-8?B?SHQrc3c4SjZrMEZWRWRXU0J5eUl2OG52dDNIUktZOHQ0TnJwaE5nRmZmQldH?=
 =?utf-8?B?S3BOdVgzTlowK0twTFZsNXdDOTY3dHdXSm5IQ1lPeitlb1hhQTQ5blVQdnA2?=
 =?utf-8?B?c0Q4UytkZFNvZ0REd1BHNjU3cmNMWUZHbzVEdEcrM3M5MnRJUityenVoQlRp?=
 =?utf-8?B?UDdMZEx1NkRBTGZteGVwR2twbjczME91Y1pwMnN1c1NOdU5MSXhkQUc5MjI3?=
 =?utf-8?B?Sk5sNGo1Z0ZaNzlCZVBjQTBQazFhNEdNRVNTRjhJY1ZUQUNJQkF1cEJmZnpj?=
 =?utf-8?B?L3ZoNi9ZTHZpc1VkdExMWWo0TmxrMXlJQzFyL3Yxejd4THE5ckl2dStESW16?=
 =?utf-8?B?ZzAwK0dPbm9ObjdSc1ZKMTcyM0hQNTZrT1NTV3cvWERCSGgvQkZWdjRwTTZx?=
 =?utf-8?B?Y014RlpqYkNzTGhYYlc4QVJnVk01NkFYS2FXQjBYYnlQQ3RoYVVndWt0cXFW?=
 =?utf-8?B?TmVJNGY0UHlWRFlFQ1lUdmNaSlFUdTZkc2tFZ0R6MTBOZHpRa1RZQTkvQjNI?=
 =?utf-8?B?aTRWY3dTTVRUd1NwaDRaWFdmcHdVbTNOaUwwZ0xMT1J4U01hOEExZ2tKMVc4?=
 =?utf-8?B?V1ZxMHV2MmdMU2w3SWhuclJRcTdVL2d3YXZvTzYrNjRYWm51Ry9LcEpDRDNQ?=
 =?utf-8?B?ZFhyNm0vSlo2b1BvcnpkUlhZWjlNSXZJNnIwT3QxMkZXL0ZvOFNNbVhHQnp1?=
 =?utf-8?B?dmQ4cUV5RmZxTGdaYXI0QTFYdmJ4Q21GRSt2WW9jUjRaMWlQMUdnK2lVWVpS?=
 =?utf-8?B?TFptdnF2WlJuaVB0ZlU3R25WQWdFS1Q3bGZMNUQ3ZzBrVzV3UlZoc2l1d25T?=
 =?utf-8?B?NnJoQ1Y2cSs4Nng3a1M0NnNaVXZZL0V5alFJZ25zdVRRdjRXdXppVnhLRkFm?=
 =?utf-8?B?UUNnQVNHb2dhR0dJMXg4Z0ZQaU5DdDZFRXI3Yk1zMW96WnZqWCsrMy96SGwv?=
 =?utf-8?B?dDluQ2dPZVJFclJXc08zNjVvcWk5Zkh4RDJTdDhJdWVPbzBMbHZ5S3Zla0g0?=
 =?utf-8?B?YUFpZjdyZnd0cDFVVE9rRXc3MFZ6MVpyc2plVFYzVzU1VEYyb3Z1VzlLcERJ?=
 =?utf-8?B?cENZTTF3MGJvQkdsSmR3bWZIY0lRbk1HUFRFMStKZ3lJNy96dmhMQ2crSlQw?=
 =?utf-8?B?bEZMSFlEV0ZnWnJXREFkZTR3bVYxRlM1SFJ3a093NTZGdXNVclZ1M0ZrNmJH?=
 =?utf-8?B?VnlacTZqSDNyVHMxSUNES1hGWEQrOG1PZUYreDVkRERoUnp5SjR0Rmw1VW9V?=
 =?utf-8?B?czlJb3pHMnVBWCthNGhPNTJHNWw3VU4rZnp0YXdZSGxqZHRtM00wc2Nkd0xh?=
 =?utf-8?B?UUR2SW8zc2pxRmNRUmtSZkdnQW9oaFRzdTRuSlNOQzNVdGJ2bU5ZOFRSSkdE?=
 =?utf-8?B?d1MvTVZqeWRiWndtcVVRZDAvVWNwM3cyZDJJTS9kSGlVbGRuNmxoTWJRZ2FW?=
 =?utf-8?B?dXNkS3B0eERkaUFzeXZPdEFuRElrcDIvRFdRSVRiYk5UYTZDUWZ1MzZXS05G?=
 =?utf-8?B?Rmw3cVF3NGFEZHdrTnp4bkJxR21QYTVMT3BzVFo3a2htTDA3Qnd0OE5KOFBq?=
 =?utf-8?Q?Cc64=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:27:08.0111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82ab1c7-3482-4880-ce9d-08de16a36c13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 27, 2025 at 07:51:15AM -0700, Shameer Kolothum wrote:
> > On 10/17/25 1:19 AM, Nicolin Chen wrote:
> > > On Mon, Sep 29, 2025 at 02:36:35PM +0100, Shameer Kolothum wrote:
> > >> When the guest reboots with devices in nested mode (S1 + S2), any
> > QEMU/UEFI
> > >> access to those devices can fail because S1 translation is not valid during
> > >> the reboot. For example, a passthrough NVMe device may hold GRUB boot
> > info
> > >> that UEFI tries to read during the reboot.
> > >>
> > >> Set S1 to bypass mode during reset to avoid such failures.
> > > GBPA is set to bypass on reset so I think it's fine. Yet, maybe the
> > > code should check that.
> > 
> > shouldn't we check its actual value before setting bypass?
> > 
> > By the way the spec says is ABORT is set to 0x0:
> > "Do not abort incoming transactions. Transactions bypass the SMMU with
> > attributes given by other fields in this register."
> > 
> > Wondering about those attributes and they can apply on the host?
> 
> That’s right. There are other attributes there. Currently kernel only
> support,
> 
> * @ste: The first two double words of the user space Stream Table Entry for
>  *       the translation. Must be little-endian.
>  *       Allowed fields: (Refer to "5.2 Stream Table Entry" in SMMUv3 HW Spec)
>  *       - word-0: V, Cfg, S1Fmt, S1ContextPtr, S1CDMax
>  *       - word-1: EATS, S1DSS, S1CIR, S1COR, S1CSH, S1STALLD
> 
> If other attributes make sense, we may have to update kernel. I will add a note
> here, so that we can update it if required. I think Nicolin is looking into this.

According to SMMU spec 6.3 GBPA register's Additional information:
 - If SMMU_IDR1.ATTR_TYPES_OVR == 0, MTCFG, SHCFG, ALLOCCFG are
   effectively fixed as Use incoming and it is IMPLEMENTATION
   SPECIFIC whether these fields read as zero or a previously
   written value. In this case, MemAttr reads as UNKNOWN.
 - If SMMU_IDR1.ATTR_PERMS_OVR == 0, INSTCFG and PRIVCFG are
   effectively fixed as Use incoming and it is IMPLEMENTATION
   SPECIFIC whether these fields read as zero or a previously
   written value.

On the other hand, QEMU seems to set both OVR fields to 0, so all
those "other attributes" wouldn't be necessarily forwarded to the
kernel?

Nicolin

