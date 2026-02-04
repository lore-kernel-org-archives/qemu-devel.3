Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76C4EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjFm-0006Uk-6X; Wed, 04 Feb 2026 15:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vnjFl-0006UR-4y; Wed, 04 Feb 2026 15:13:33 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vnjFj-0005nh-LY; Wed, 04 Feb 2026 15:13:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4voD+m2q5U3mjACxUS06y3fwfTtMmz1P/83MgZcT7vy8B0Ll28+gBCbM9ORTNo62xBeeHf9OcuA1ee20bESrkac8qdpvUXlJK2MEykCCtwE0nT7wDo256jttvcL0hHeM16sLgA0ejY6/olIW+/38xOIFDL2+jjosm2CrXYkpl2pKhARpIphUU7fkOAUh5BSL/AucFaqbwEG1FFEEoJ0bm4j2lpWz3HfAs7bL34GY+Ud10ox2F5S8M2sJD6rdvioQgnCr3rXsSWTsc+hKDUyrskJe/u//n+bKeL0aOf7NQfocaDRu5P1Ys4qcLpi3YWRj82PIDkXZhvP7Y5uf4flzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlzTXUoETL0aAZpTQthawAfwWQfmzeudx7S73nYnBeM=;
 b=XXZt6pUX6M/CseewPXIWGFWHIJvXVxV+PcztGlrEzQfEykHfdHwXjZu5Ssuq+FruwomeLPfb5BbRUMKPeCS33TTm0xBSHvUvmn3PG2lqqu+n+Dl6sTEhDoscc9zBUFvb9CC4SQhYBqTe8iXll7Cn1fnzV1K5PZl4IrhO1Bj9qn+2GlwFdSs3AnFxd4fTJDC6siHDhGTbXnda0QlwNDuxmcxj3K4K65W9IPI2wfx42EAKP0wC/8h9bu+BB/gZYbsl9zCdHyrZAd2IbU8PnjuByt9JOsvOuX5ehZHdqSzQvFVsZ01D0qEqM31oMTAg2Zkr3hu0xW2PaekDZRGzRLhqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlzTXUoETL0aAZpTQthawAfwWQfmzeudx7S73nYnBeM=;
 b=OlbzRHlifxeb5Ohu4mLw+pv5o5cax0kKKDQI9Ja+JyjMVbwdbUinXjbAE4UKBDvLHwdGz6Nl17plKYAGjans02FPHpk12upQVAczMOGtDrbSXdJTaa1eiMo4/eYu54wBltb7eIlWbosmYtfGzPRM6f/eysH8Gze4T+cHiHUgSF8s/fEZqmML+knsKTn+3noh9DLCym4NeIC7zpQDqA4QQCkIQHrg2smYyUdPWuM5mGVTpvuYaleWQE/dSa6B5ynEELFMEqZ+n6LIxRugjnUU7CmsReoCV2QFf9LRoDvs+cliOOm71Y1HEv5c91ZVxZpltBIWusvDaOacg6s+Dx+bLA==
Received: from PH1PEPF000132ED.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::32)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 20:13:21 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH1PEPF000132ED.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 20:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 20:13:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 12:13:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 12:13:02 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 12:13:01 -0800
Date: Wed, 4 Feb 2026 12:12:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v4 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Message-ID: <aYOoS1qpaL4m+NJE@Asurada-Nvidia>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204190008.20070-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a138801-b071-4e6e-06a3-08de6429d827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFgzOUFjRVhUU1JBT0szVnkzVm42ZmRRcmVSMzkvUVU2VVNYRUVDakt3THk5?=
 =?utf-8?B?bnJYdHB0TElJZmUvSFM1QTdhczlxNGxtd0hOd3VTZTgwUmNuTURUTjZvbHBU?=
 =?utf-8?B?WVpHVko1TEROSmltR2Z3aWdxZm9LanVvVWNIazBUMVB2OEg0dEQvT0lRUFVH?=
 =?utf-8?B?MnhoSE5XdUxYdzNUM3RUNXNnTWY2SEkzdEJnWnZrMFBwZ2ZRVWJwZlRJdjhT?=
 =?utf-8?B?dk1qNEFPY01iZHl0ZmtVMnF5UGtHNUJFS2RpV1hrWElTUGlYZytQaFRsVlAz?=
 =?utf-8?B?ZmdveGd6TjFEdkluWVdXSG1lVC9hNkVvOWRrcXoyWE9QY1MzeXdDRmZsYjd3?=
 =?utf-8?B?L0JkOU1MQ3JiT2o5cFN1U0o4ZHFSamdFaTFUcm9vc0xLWEIyZzM1Zi9xNG5Q?=
 =?utf-8?B?T0NMemprcVoyQkx2dzhTTm5pTjIrQlVrRGNmVHMzV2haWE5UeTVEcjZSNW80?=
 =?utf-8?B?bGtFcVk2OXh6VGdjRjRiQXI4OTQ0TzhCVzBVMkFoZ2d6NzlmbGF0UCtHdG00?=
 =?utf-8?B?elgxNSs4cWF0cW15TEQ5Z3JNZTFhVFVheG9GckRQYUZ5enBOZGc0Q3grOFNN?=
 =?utf-8?B?d1ZrQmEyNmVmaEhiUkw2a28wWXQyaUNORDZ1SU1EWlE2ajNKNE5qVGg3L3Ay?=
 =?utf-8?B?QXhURXZWeWJRTG1KS3lJb2pCTitvTTExMVBRdWFSUU12ei9QWXp3NC9XVzl4?=
 =?utf-8?B?KzZaR3FuSm13UnVZQ2tKOWh0RHk2TnBwaFRXaGhGMXVzV24yRUM2NGZkdENC?=
 =?utf-8?B?aDBtQnZiWm5ETHZWYU84b01rWXl2alRHZ3E2azh6WkRQUlI4YituaUJxUFNT?=
 =?utf-8?B?MzVseHhYU3J1dDI1cWdoWWtKNG9pTkE3elJuRmJPK1hiWk0vSU4yYm51cU5p?=
 =?utf-8?B?eEtkMFh6UUNVckR0YlRxa0k1cHU5ODhQSGxXODFwd3Z2ck5udVVxdC92dlF3?=
 =?utf-8?B?VXRMT1B6cmtKdzhFdmhlRituNEhwR2R3M3lHNktJTFZNdllGQzlhVVcvZkEr?=
 =?utf-8?B?VHRSdjczOWJwMTMyVEpCZlovU3RXZU42M3ZueHFKR28xQ1ZiOExTSjROeFJx?=
 =?utf-8?B?ZGVSZ05oUElQZ1ZZK0hMRGgveTNDcGtVWjBzNHcxYmZRY0FnZUtxRytPcVRm?=
 =?utf-8?B?MnkrZjNndGlIS25aMHNCeENaVFl6aGowbTFLb3dKV08wcEFIQnlOTzFiajNG?=
 =?utf-8?B?TEhHSnNmUkJsQ1F5OHkzcFZQK01MYlY5elFha012bFZMRWc2MXRPS1Q1QTYy?=
 =?utf-8?B?UEZqR2d5N2lZSlFaMDV3NzFMdmxmZHY4aE1Vaysvd1VzSlFTWHAxUG44QTR2?=
 =?utf-8?B?UHJSOGhmeTMvT1BpNGhTZXZtcldmNnZzUVRoQUdNdkwrVUZpT2pTWnNlWVpl?=
 =?utf-8?B?TzU1clh2c2NybC9jRUZQSldvV3o2MGZJQW5SRlkvZ0R5S21jamh2b2lCZUhm?=
 =?utf-8?B?QW9EM1ZMbml0VktaeTFIWW9oTVdEME1yMTNQZkhhdkZsSWhadEZPdUZpbVhs?=
 =?utf-8?B?bjdEdDEza0ZKYzZXNlh0YTN2V25GcnlwZWc1VmdkQkZjLy90UmJGcTg2NHE0?=
 =?utf-8?B?b1VpaHd3R1prUThOYzRPQkg0RTRFZGxPWWNBMXlONFV1eC9iMmJQZWRmdUtE?=
 =?utf-8?B?ODMvemR1MUxPeFdLTXc5SURhL0UxbXQ3ZUd0MFdUK2lRdE83TElhV1NYdmEr?=
 =?utf-8?B?NkdXMUlUdk5hakViZjNaWmNIQ2ROZEdoVnRYQ2FOV0pQWk1ua1hiVnJSRTg2?=
 =?utf-8?B?RTlyQ1JBZmE2T0h5VTI5dVVvL3ZqWEtuZHZRV3U0bHhzTnM5V1cycW50aGs0?=
 =?utf-8?B?MUZDVUpXckpyYmtOSHlYdm9GNW11Y1JzNmhFS0JUeFZLak9ROWZkVWlvencz?=
 =?utf-8?B?LzI2RGFNbVdPaktkUGExVFhRc1lYUTErd2NJZEVZQUdJSTVOcmxBRmFDb21W?=
 =?utf-8?B?aDNnNTJ0ZnB0YndsbWtUYk5MYnBqYlEyZnM4WmFCWGxYNmVET1U4bjB3ejlo?=
 =?utf-8?B?WUpZRUJHeVN0MjRzSkNIbVUrSzhhWHNNZ25PKy9qV3BPdWFoYWFVS3laYi9G?=
 =?utf-8?B?cG50RVZqcy91Q1VPQUNWSVhKTllQWVBpcmo4QjgxSXI0WXBJQk9sUGI3T1hH?=
 =?utf-8?B?QjJQYURxd29YcnlkR2pOMnNmN0pyeEl0c0ZTTVh5TFFFekt4QmlwZWxkNnBK?=
 =?utf-8?B?UURvS0JrSmxPYnNyRlNiRzJ6akRxS0taRFQ0dXZmeGs5L0drd2M1NXVTY1hz?=
 =?utf-8?B?elhuKzRseFdhTjJPbU5Lb3plYVZnPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SrCHkqyh0RjBm94Pu8c2K8sru7QkvB3+Ge8APL5BBV2fyrr4O8UpONI24P54+tDQ3SLJB/NL/FkDFIYs4Kdj58kSNAJs7dlaYNuR05BMD5as1IWULhhcBJ8s1+0I36iwjO2e4FcJcY0GAjoTqHWYyHoSX2jfTIiGuh1R/1IU0ZYcTl8wSJ5m7DsRvyTS4p2DWbbAfxzTFGA5i+k/2LIrZymgBUPljm9oog2m0pIie0vZtz7I2SOVMPoq2c6CHoSPjfaWFRcnXT092p+55858Ztr7cZyHtHSXNAGK1qAuPzyQnziBzMiKYbvTQ6sNt7MaLuBW25arEEbrDBDu4W8sXPJo17V9e1F9LNnp2Dvps3EYM6VvTIxvVuGEMUzJAuSquWI6Q2leR4E0NQJgmCOX5RzdmPVFYQhFzj7GcxvZ2ZHIkS5Iw3uXblf7BihEeUb6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 20:13:21.4725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a138801-b071-4e6e-06a3-08de6429d827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Wed, Feb 04, 2026 at 07:00:08PM +0000, Shameer Kolothum wrote:
> Install an event handler on the vEVENTQ fd to read and propagate host
> generated vIOMMU events to the guest.
> 
> The handler runs in QEMU’s main loop, using a non-blocking fd registered

s/’s/'s

> +static void smmuv3_accel_event_read(void *opaque)
> +    /* Check sequence in hdr for lost events if any */
> +    if (accel->event_start && (buf.hdr.sequence - last_seq != 1)) {
> +        error_report_once("vEVENTQ: detected lost %u event(s)",
> +                          buf.hdr.sequence - last_seq - 1);
> +    }
> +    accel->last_event_seq = buf.hdr.sequence;
> +    accel->event_start = true;
> +    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
[..]
> +    /* Set up event handler for veventq fd */
> +    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);

Are callbacks serialized across threads? Otherwise, we need a mutex?

Thanks
Nicolin

