Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A01E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRBe-0001O8-IO; Mon, 23 Feb 2026 03:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vuRBU-0001Nr-Vw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:20:53 -0500
Received: from mail-westus2azon11012046.outbound.protection.outlook.com
 ([52.101.48.46] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vuRBT-0007gY-6f
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:20:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtQKvMKDShrv649/HAh42OLRQKmu0ypzEikgi/UbqEu6yBaLiloWZOgrsrelRPO/1DkGdNAklXmK5MW+fjCXSTnM4IjhIld31pUJq/EFF7g6kVvBNNoy/mQKP5v2g87eNm7Wc4f41f1b+iKddZpLeL6YpZzyNop2QuPecubr2UeEKKpsFSEhYahwdozvBOTIUZZkvlhxPl+l2WUWAPDZSGKYPRWJWNzrlWPbk8mZGG+hloJzOcbLroj7eUCzUy8cpYaAccG/H1WLVUFAGkx8KN6YMpFBtHFv0T8vuknLuho6+StzzCz1RZAp5Y9vYK6i/Rwt9PJgMFKXyfs+1XBAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwyyQ1xGbzElG+HhB7+sufULlPoCR0Xm/H7mMnT6jgw=;
 b=YaA6AlqTJYrz571Ms5JqLuslCTCbvJCv7hQ0VnAzty3QJvu3QBXOfCMce1m86n+F43Xd6VKcTnVb2SMhr5M2Y79EJNAcXiNKrzbf8x3vqEtmXOIoNi/dJxqRg4ZRkaxPLgLfO5VNz2BS2SJIjlQ3nAO14UPLCRgo4VQa6R2MsYiHWXiB94N+mOtgi+890jsEzB7GfgpAwGbP5CRILxZQPmkKvQqXVt124/drerDxHSjJevmKi8KqaojKC/M9F+LOZCdZuxuneghwo5EFL8NfKzaPg1l6HTdQv+e95aNjG0kDOxGp2GHWr0pEd2rAHZu1hwc462JR4UaLl09/HcJE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=demindiro.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwyyQ1xGbzElG+HhB7+sufULlPoCR0Xm/H7mMnT6jgw=;
 b=sV+rQZrqL8gPp5gycyEe3fy8tdVrBHIwQnhuGbmXsny6J4RN+pq3Dkt4wfT+npCt3r49UbPsNv3FOM5JnEy/ILjHrk9LxPTutRnzzWnqrhAXf721lRb2f3/AwpAJ9SkIHFDsWHgFPPMwj9gyYsA/3JmkhYK+Tf0yURjpSiglICY=
Received: from CH2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:610:54::29)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Mon, 23 Feb
 2026 08:15:41 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::e6) by CH2PR11CA0019.outlook.office365.com
 (2603:10b6:610:54::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 08:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 08:15:40 +0000
Received: from [10.252.204.230] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 02:15:36 -0600
Message-ID: <dc1c709f-89a9-4d59-bbe8-f19020a380dc@amd.com>
Date: Mon, 23 Feb 2026 13:45:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Eduardo Habkost <eduardo@habkost.net>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH] hw/i386/amd_iommu.c: fix amdvi_unhandled_command logging
 cmd ID
Content-Language: en-US
To: David Hoppenbrouwers <qemu@demindiro.com>, <qemu-devel@nongnu.org>
References: <20260220181437.19338-1-qemu@demindiro.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260220181437.19338-1-qemu@demindiro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a121348-eb31-4ff9-1984-08de72b3bb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFhpZVlUZUg2c0tsK3A3MEZxOFlCVnNFRjBMQTJGRW9pVzR0Q3Mwczg4bzN6?=
 =?utf-8?B?U2ZYRkRJV2JqWVc3TWdxKzRBSGlKYVNxdDUyMkxiNDFyb0pDUCtjVHVXS3NF?=
 =?utf-8?B?Uy9RT0I4RDhSUldFWkh5WTNtbFVvd0tFc1p3eTlTZ0c1eUZHM2o2MGloZUtM?=
 =?utf-8?B?bVFNcitLSm84cThEYlg0bkowYXY2emNDYys5SXg2R0x1c2dzOUJ2aTRSNVhx?=
 =?utf-8?B?TXNxMnBIMFI2emdQVVdoZWxkOGgzRjR0S3l4dzg2dTY3NmJPbWlUcWVyZUhY?=
 =?utf-8?B?TGE5YkVxSGNxMWpKSWwzbitDa09hK1JhamNmTHdCOEsvVTFrSnFNekh5S3lm?=
 =?utf-8?B?K3E2SWwzQXg2ZG9LZnlSZDY2NU4zNkpSQkxvN3R0WXNaVjN2bUlRU3Z2ZnlB?=
 =?utf-8?B?blI2SVNmbklERUVtZGs4WGk2VkEvWi9IMktDQlNIRWVMV1kybjNkUjEzSE5K?=
 =?utf-8?B?SzdPeW16MDFWMUJHQW9BUW83eUhsSkx1d0hIT0xkMCtiVC9Ob3JjOWpoTTBn?=
 =?utf-8?B?WDR5bDNJQkVZeVdMeGNjYkJTSzU3b2Z3aE1aQVJLWnc3VVdMMkFIM2wzWlo3?=
 =?utf-8?B?a3ArcDlScVJzUXArVnAyL0VpSWhtaUFwRUlJcThkYjM1TDBUK29jYWtpdGt1?=
 =?utf-8?B?YXB2WE1aaUtDQ2xBMG8yd25JWmJBRHk3UTBsVWEyOWl6UVFjWWFIYjFiMENL?=
 =?utf-8?B?eS9WYlB4QmNjUGdLNFNJdlExcXBlejB0ZjVnTmJxM2Nac3hhTENBZ2hLd3BE?=
 =?utf-8?B?NUdjanlUOG5KK21lQ3JreE00V2F1eEJZaS9Zbm81RVIvQTJVdk0zbWhJUUhw?=
 =?utf-8?B?S1dXajBHcnRKU1E0NjFiSGMzdHV1LzF4SnZiUmVFYy8wNk9GbThqZndkdVhD?=
 =?utf-8?B?SVdGWW04VVJkWHBXRWRRSUdIRUZDQXJsMGh4SDI3c1Jpb1JFSDlPOVBuN1Mz?=
 =?utf-8?B?dHRaSUVGc0wyU0hSdkE4cEowcGJUUkFrV0NDNjhqMjI4K1U5SWVROGhxeUFz?=
 =?utf-8?B?Vks4OGd3Uk5sUUQ3Z0lISzFvM20zSTQyVUhUZUVIOHJjd2h4THBvRGtuUFh4?=
 =?utf-8?B?NmMyV2JYbGFhVHIvUzV1Y2RHdE0vZFZhNjdRcFR1QWJoR3o0TVRYVlJGdURS?=
 =?utf-8?B?ZkMvMUYzUjNIWEIwMXg2Lzk3SE1XZysvbkJCTW9OdHJPRVFFZ3FZUEEvRSto?=
 =?utf-8?B?SzdET0dxbzZVRVY2eisyNzRNckMzK2pxeE9lQnZpZWdNQ3ZjbWxpRW9ReHV1?=
 =?utf-8?B?a2hIRTJwTUJ2d2tqWk9ndDJ6Q0cxR3FQcjh5Ym1CQUxPZ0oxK1VRbk1FVUtk?=
 =?utf-8?B?ZXJzK2JHMm43UTJuL2o3TmNyWFhDSVoxdm1Sd1hHUmRCcDAxSU5OaEVlcGRY?=
 =?utf-8?B?RzdtRXN4OFpwYThxd2hRQnZlZUZpMTRVTFFaeHNjbGpMYW5GQ1g4ZFRYZXVZ?=
 =?utf-8?B?L2ZsTlBSNjlHYXhwK2RrdXdCWmJPdHdJN1FSdGc4OUJ3WVpHalNrRDNpbnl5?=
 =?utf-8?B?WWRjV01GNTdROHZ0aWtuMGpqdmo4MmJqSGgyUGhzZy9lNGZWL05mOE8wV3Jk?=
 =?utf-8?B?SGZycUhlR0NEZ1owSlBCbERQOHFVNnZBazg4SDRyZ1NiVzU3d04xUER0bnpF?=
 =?utf-8?B?YnlBdisxMjNOb0JsaEgwaUpiZ09BaElFazZNblJxUVRTMnV5QzZpWE1zR0RN?=
 =?utf-8?B?bmlQbVgwM2ljM0haclZzMlhpeDdXRXVNZTNTcDZRVVdaNUd5eXV5Y29OQkVp?=
 =?utf-8?B?OFFXcGxqV1NXaDhzZXcxd3lycGliZ0NqZE1tV0piY3VMbnF1bWxES2JLUXJW?=
 =?utf-8?B?UXljSllWTENQSFZCN3VpSHE4bDNhcVgyWm5WR2E1UENRRTVBcDdXaDFMZXRj?=
 =?utf-8?B?RHNYS0dpL0ovZmV6cnE2dHJDa0JQek02WlN3aFhjMkNaVENuaUVNeG5iVFFq?=
 =?utf-8?B?cm5NbEVUWFk1VThscm9YWnhkTjlpam5iMll0WEEvL3g1WXBUaW9VYURsbU5N?=
 =?utf-8?B?bHpucWl5eEQ2Sm1mb1QwNWorQ0YvS05EdXZKcW44NVQ3SW5iaXUwUHJpUGw2?=
 =?utf-8?B?MDBlZ3E4V0dRR3RjYjVpY0wzOHdGdkxpbXp1S3VnazZJVEJkWks2bTdQU1Rl?=
 =?utf-8?B?TTdnRU1DeGtGT1FUMHVhRWtNUm1ROUQ5czNDbkdSNVFCc2tKdVlnM1kxL2FH?=
 =?utf-8?B?elBJeDhFQSsrVm50N0ltV2hpbUUyMlRFRWFGbFU3clpwZ01DSzhHeVUvWEtQ?=
 =?utf-8?B?QUlxU2ZSN0REaFVJcDZSTnFWdlFnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HHOInEfDgW/hrrvi8WUMCxnZEgmLk6pL4tw1845W6hvEljXaI71LjE+v8O1Nuw0vLVpUHE7Dbo0br0y9rMWOSvclgwiVpKTHxZaTJyVZ2ykgO6BNJKjr0N8uSQj/SyFmbiFO2SvxWAyl9I1Ii/xR5XrOQfajgrrxjGB5ZhPJOuj91k6aKBUwbUYby3ooo8MzPIuHAvm7IbrtO2mTkXRSRHszTetEL+1m5ynuIcy7TL7nkqec6wdrH+SP0lFjR2Jrk3J2fuzqzV+ANuSQ+NRbQo4VfoX9VBzycwbGIh2nSaDWOPF3zp/5nfhNccactIMdZV9OcISBI598pcr0tXS8XiDc+A7aGmuk7H3NLI1/im4MxX4bfZDBVcLzwZDM03U2f+QnXYECPrrklj4V8MLzy5qBex67EiEOYZGdwlbiLQbSLiY/z4yNgmSpi6kTpmoz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 08:15:40.3559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a121348-eb31-4ff9-1984-08de72b3bb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
Received-SPF: permerror client-ip=52.101.48.46;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2/20/2026 11:44 PM, David Hoppenbrouwers wrote:
> [You don't often get email from qemu@demindiro.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The command ID is in cmd[0], not cmd[1].
>
> Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
> ---
>   hw/i386/amd_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2..2570a4701c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1456,9 +1456,9 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
>           amdvi_inval_all(s, cmd);
>           break;
>       default:
> -        trace_amdvi_unhandled_command(extract64(cmd[1], 60, 4));
> +        trace_amdvi_unhandled_command(extract64(cmd[0], 60, 4));
>           /* log illegal command */
> -        amdvi_log_illegalcom_error(s, extract64(cmd[1], 60, 4),
> +        amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                      s->cmdbuf + s->cmdbuf_head);
>       }
>   }
> --
> 2.52.0
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>


