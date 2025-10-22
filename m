Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C6BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTuI-0000Lt-T1; Wed, 22 Oct 2025 04:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTu8-0000Kn-8L
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:09:08 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBTu6-0001yV-13
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr5GYshclLQ1QoBPT7241zhUw+fA8AUwEsVMsSQnC61Er7w11gpMeVO6wF75IoyI7hyKKMNWEcJF4fW0jMju4aegzomn77QEV4a3WzvftNdHMXnj1Z5QwF6Oq0jgGWimiXWos0PAFiSm3qWkU13QvAnVUWs1QPcTmGErtvjZiVo3AtVzfiZsKiE9WphxKW1Psg17Mzf/Sv0jsDB6rSrIrgQAI45VE2Q4AXEuVkfCNT/Kor5BpudvWHWDqfo3jlVAHMSsevbZJ4W9piNguOrerkqiau8CDqpI8q4Pn13musOC8lCO3hJCp5tFQnLwfMZrgMVVX0vQ0GZOaHLcf7BITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbjkrcmNHmVt0q4/Ik52JPO88hIn8XIR1fMN0e6X9j0=;
 b=CU3rXdj9hFIddIzZGTmf6xfQcV3IrocZGZkkeFmGZ6n1comnJh7BZb3F92zRMWHxCageKbi5E5IU/wEtSIq0U4Iz1PjtgjltLV+QmSpdo3T3Wsl+uCQ/m/Lbz6qquIw6/1OMmtlB3kSKm0yoym0hRMXcapfCSymf0H4WcKhMdXwXuzbrRwH2tVZ9QKnE4P1OsoL8d+Tq9VMtSigw+XnTlGv4BWd0P1r6iKpIZdU4jj27UnVb6QuIksffBh4xlUgk9ywQCQTclWUW7FBJzP2JKk2dtqGmja+Fv1L2omzJuPvMyR0pOtdiC7VpN2H9qWiBt0je6/GcUxFegN+gvj6gTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbjkrcmNHmVt0q4/Ik52JPO88hIn8XIR1fMN0e6X9j0=;
 b=Yw/aPgkeV4aFIqz3ZivjqM6qL0s+PxDPu77FnfF92RLg0PW5YrUwFmLEvxEluJJuIFxkTrOQeDFqzh8UyVY3qqsQS79u70PjHQwPRBUeMpCvtR7OGku12Qx/FLqPfDkRTO44cLVdWFf5919yWGR4D01bBQAUPb0rfz0BMA3QvQzfvRCoS3BCYyzt7bxxaH9ZV4Buiw2R2gW/Wcr3LF7RZBy9P44v6TnSiZvUhc9Fixuo0pDjBwHn4Xcc52Axo17X9dd1pRN+KzZXcpDk0nqG+punsN2aCKvSAdcc9FDYrXp6K+tmwKDo1Q7RROy1JOOAMKpofRIsDC5oxFztEd014Q==
Received: from BN9PR03CA0981.namprd03.prod.outlook.com (2603:10b6:408:109::26)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 08:08:57 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::6) by BN9PR03CA0981.outlook.office365.com
 (2603:10b6:408:109::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 08:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 08:08:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 01:08:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 01:08:37 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH 2/3] hw/pci-host/gpex-acpi: Fix _DSM function 0 support return
 value
Date: Wed, 22 Oct 2025 09:06:38 +0100
Message-ID: <20251022080639.243965-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022080639.243965-1-skolothumtho@nvidia.com>
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 753970f5-66d7-4d45-668a-08de1142401a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Znh1NDJZUjNCbFMzRWhEZDU3elRYWFRidTRXTTZFMXdBaVgrRm1ZMUI0SURG?=
 =?utf-8?B?UmRxS3BJODYyWi9xWldSekw3RUxDQW5xaVZmbkFWLzh3SUZjREtYRWQ5RHdt?=
 =?utf-8?B?YmpUb25UeHA2V3JNSkJiR2JsSXRESG9xTWlZMzI5TGxUUTNVVEZIRWVWOHRa?=
 =?utf-8?B?b2kxY2N2cXBYOXJuWTh3Y1ZvSEtKR3pFZU5VN0x4TU1Ed3ptdG5jZG40R24v?=
 =?utf-8?B?V3U3dUZETDJPRk5OTkQ1dzVxZ2kvQUcrR2xUNUR0MFNzRXFRSElwaDlQRDZC?=
 =?utf-8?B?RmNtMkJMNHo0ampBM0h4SDhmYmlYMUNuYjU4NEw4bjNMNmJ4NmN0UGE1RnVu?=
 =?utf-8?B?Rk9SUis0WWkzVTFyQmtaaS9jbUJybzNTU1NlZ1JEMjZoS25ncDEvVkliQnkz?=
 =?utf-8?B?OXBWUVFoalJtNDhiaGpmSnl0S2hxc0U2RW1oK3ZxYm5PWnRyc3pGK3BialZN?=
 =?utf-8?B?ZzZhbStnek9ubFpjZkhKQ3BNOEpHUlZ6a2kzV1QzM2htUm1yckljWHRRcjhx?=
 =?utf-8?B?RDZXenkwbWdhM2EreklTV0JtcTVpRUoxalVaenlkVU1zbkdIODd5M3pSVUpl?=
 =?utf-8?B?RERSMkxaT3pxd2NhQ0pnamlpa3RTYnNFNVgrd2lHNGJkMDd4RmpxZERQa1Fz?=
 =?utf-8?B?Ryt0YmV0QU5vQ2FnTUx2S2lDTXNIcVcxQUg1em1iL2pnQUg4STFmTXpFYzdj?=
 =?utf-8?B?UTFPaTZkMWRPTHl0dWNmUnNjYUNKVHcvcm5OcU85dFhRSkNYdGsybmVXeExl?=
 =?utf-8?B?eGVpRVBlZVpNS1IwemRNcEppYWFDY2dsVTFiUXNvNFJNU3MvK3h3cFlJZFBa?=
 =?utf-8?B?V05scmxxMlB0TXBNN2h1RS9ONWdHa1V1RzM3TmY5UzcyMS9uQXptekR2RGc4?=
 =?utf-8?B?SHlZK3hVWG11Nk1lOGpLWXVpM1FNOG9UbzhIeTNMTDRkVEZtWk5OZEU3SGpV?=
 =?utf-8?B?KzRaRnd2VUNTV2hJVjRZMFdHWldLTDQzR2J3cDUvQWhHSDdNcExaR3BTUVNE?=
 =?utf-8?B?dXpnd3VqVVpBYjRUZ0ZiY2RUZDB0cVlLTGxqTTNNYVhIdlh0d2s4cXF6ZUNI?=
 =?utf-8?B?b1R4ajJHTXc4TkNKOW5pQjRFUTdVWVJWcWYxUUgzTE1XRitKa0Z6TDRLUC9H?=
 =?utf-8?B?cmhMcnFNLzR3VGs2c2lZZjhobkhjdUk0YUk4bTVlNVhjdCtCVzI0WDkwWVRk?=
 =?utf-8?B?SUFHZU40TStncVU1MFMxc2dGVDBFWnlPUWw0eGI5VHN5QjdWWmwxeHdiV3JR?=
 =?utf-8?B?ZEx3TG55YzdtZHpMWjR0Qml6NFBQRVRaSDk4MUtBQ2p6TTZLbjZpM0FDelQ5?=
 =?utf-8?B?TUEvTHVpdk0vSHJheTJndHB2ZXRCTVRpR3UyOWZ5Q0VzQmxka3ZZRmxOc2s1?=
 =?utf-8?B?a21oMzFDL0dYcnNPV2tZRWtSQW15a2F1UzV6cFBnMDduZDZSYWYwUG9KUVlG?=
 =?utf-8?B?c2JJMjRXRDl3OEkwL1Q4cGFFZFZya1RiTHk2L0RzbmxYM1hoamN4cUdweC9J?=
 =?utf-8?B?THU4RW5NU0U5TmV0cEFDSkZyR0I4c1I3cFlOV285c0NnMVk1UWM4UXYrdDBk?=
 =?utf-8?B?RHVsdVlXY0FlcnRkRmdSbTU1d0U0YnpBRHo2T3lpOHhhdWs1ODdnL0VCS0lq?=
 =?utf-8?B?d1lUcHZqZStXVFZpVW9RY09VS2VybjJ1MndYaVA3L0JWWkF1UGFoRkZqdS9M?=
 =?utf-8?B?MWpiUEFMWThiT3czSDltWW1rUHdXK0ZaL01qSnRoeWJpOXdlTHF1RVNBVnNZ?=
 =?utf-8?B?WTZTZDBqUDc0aTl6SFJQcGRxWWdRcE1lWVlHcXNXd2ZGekpQZk44blc4MWZO?=
 =?utf-8?B?OXFJZnNqbk1XYUpBdG5taCtOOGZEZ25Fa2ZCbXNFa3A1UkszdTllaUY1dXlB?=
 =?utf-8?B?V2pGanhlWTR3Slk3UFZvWW5iajNCbCtnSzdzUkRjVnhyRzNaajY2S3NGU1M3?=
 =?utf-8?B?c0piK3FjUi9vd0k5UVphdWV6QnZhK2pEa3N1cDlDNzFxSlNaQXZ1alNQSUJl?=
 =?utf-8?B?OTFtMURqZzJlYU5ha01GS3RIdWZHL0hnZTNXNXZKN0hrY1VkbGZGWUFNbjlk?=
 =?utf-8?B?MG9JRTRHK3RVQkxzMC94cWlEZCtNR1JrbVhDejhrMUJORVFzVWtVYlRPSEZq?=
 =?utf-8?Q?Gabw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 08:08:57.2402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753970f5-66d7-4d45-668a-08de1142401a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Currently, only function 0 is supported. According to the ACPI
Specification, Revision 6.6, Section 9.1.1 “_DSM (Device Specific
Method)”, bit 0 should be 0 to indicate that no other functions
are supported beyond function 0.

The resulting AML change looks like this:

Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
{
    If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d")
    {
        If ((Arg2 == Zero))
        {
            Return (Buffer (One)
            {
-               0x01                                             // .
+               0x00                                             // .
            })
        }
    }
}

Fixes: 5b85eabe68f9 ("acpi: add acpi_dsdt_add_gpex")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci-host/gpex-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 952a0ace19..4587baeb78 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -64,7 +64,7 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {1};
+    uint8_t byte_list[1] = {0};
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
-- 
2.43.0


