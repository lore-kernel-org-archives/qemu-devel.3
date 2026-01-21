Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B56DC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicSl-00073P-GA; Wed, 21 Jan 2026 12:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSV-00064T-EI; Wed, 21 Jan 2026 12:57:36 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSU-00024Q-3K; Wed, 21 Jan 2026 12:57:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpjk83diFFkdEvuFpO1bszpmAEyKIEq3fQhAb2ca0ppIcPpELh+11xP/JjNo292am93Ew02L+4/glGZHK5Za9HdpWT9hb6+vev+1cgrzyAj+QdsbGCktCRV3uz3zBsY6gaQ1A6HTeAEzBDky2i8LopHBOrdgxenBSxf+V88jyo29bAS4Q4VnXbnFb1eDff3azRPPDGbuySYYuwh91QUuUnj2Ik1JfjU/RX+zpOcLn1fuLnQ85nb2A5rJVLFgWWK3jwDd0CmN5FijOi65/lwgSBY02aRZJD6FfE2bbp4XORNoAvCivIcLVAsAzEE8IaAx2F9QSpGFlseOwu4G7GvPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9/z9vcnNHyTjYwUUCXKWpKjzDVknRD6okAP9TjBN/w=;
 b=Wawt4KJVZuD90DBDRJmYF633/XzPx89bw17GVyO0J5lZfDmI5TrZa2TSilIHsrkNqHGG/0Fq58osYUOt1pgJ92QIORCJSiDfJR2G/6gVTZS7AQMI4naOWq0OYfLrLQSQCYgTfgSmu+xNhTHAIzj3mZUG18qZdZwHajbfXMwKvyHbhi645kK3tLuGoA/LLsehfdzYuqeuNSCkou7aUXyvu5VCDLa4oQ7HIHEe9Fzi7UqqXRoJoV22Xo3mJijXE0QzjxrpA43nSEY/t1yzUCB0dgzpA+NcI15IQh/kNx/3pC0Zc8dD0nV2Zpu3/GSfldPo8Cp1gagnUfjKtiNY4Gh4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9/z9vcnNHyTjYwUUCXKWpKjzDVknRD6okAP9TjBN/w=;
 b=Y1mZqtMAWq0AW+Icr8Vl5r7GPHhF1G0XfysHeydc7pEJtoCFIm+WwHO+7dqd4f1WpA6oAS3OvbhNr3sufog3e8k6URaXGosVOekBKNXdxLBqxhmxJGPiS9lhOYgtBJnCoHgYaJDYeSwarVRCkBum3C9wJe7cry7gsCHN8pfjUZw4ADtIQhrWuE/Gq3JoIpAF1td6w19pC3Ucbvqlg4+jU17dGZWxEtiF4+w8KSKo8iq9nTCwY26ZZdiiau/8NKSX/weShSUOS8Hl3HUviIH+fnuIgAM+m8s0XkhsUfk7IpwJf7yxBEG7WzqlIx89AHOVrvmu+BWTbCxNF2smE/Bgpw==
Received: from BN9PR03CA0937.namprd03.prod.outlook.com (2603:10b6:408:108::12)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:57:29 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::95) by BN9PR03CA0937.outlook.office365.com
 (2603:10b6:408:108::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Wed,
 21 Jan 2026 17:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Wed, 21 Jan 2026 17:57:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:09 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:04 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 24/37] tests/qtest/bios-tables-test: Prepare for IORT
 revison upgrade
Date: Wed, 21 Jan 2026 17:52:29 +0000
Message-ID: <20260121175248.87649-25-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 54593bf7-dcf8-4e07-badc-08de59168b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2lNbnBIYXJGQUtPaEFteUlHZEFWZEtUcHdLOWdUazk0MG15Tkt0WWNDbVd0?=
 =?utf-8?B?S251Tk41K0pobTVKVVg1WXR5aEptTjcyUVV0OFBicjI4WWRpbitQN3BUSDVm?=
 =?utf-8?B?NUNXN1EveEhsZFQ5c0ZGZUZ2MExFeUJ5S0lBQXZ4VUFzY0laUWRzV2NMc3FK?=
 =?utf-8?B?Y1Q3cTZ0S3JvZTJoZDJQZE1MaFo5Vi9DVE56MmlPQnhLTDBRcHMyeGJSYUFH?=
 =?utf-8?B?a0h6aFNMcFRMYUtzMHQ0UUt5UTJRWWF5NVp3WTEwVVE1dFJkUURuMDVwc1NU?=
 =?utf-8?B?UVNUbW1wY2pxVXdVbURNVGprcDdtVW9UbEhhRWlsMVNUSnllVDdVczdnWG5p?=
 =?utf-8?B?UThJbU1taC83Tm1RY002RzcwdHMzdFFpWWpYbk55VVBmQ1VSWmtoZEkyUUZw?=
 =?utf-8?B?dHRucDltaFFXWDZJbGE3dkFCSGszR25yZ2dFR0dTYkNDYWhzVWEzcHlrTTJZ?=
 =?utf-8?B?Ynd6T085RmxqQVlJYUFmU2hVTjdtcWFUSHBoZTRnbnFDQUlqR0pzeGlPOVZk?=
 =?utf-8?B?VTVKdzRiNlhrTkdkSmRUZjBMbytxa09uemxqSWVIRW10TDlvRi91UjI5MHVp?=
 =?utf-8?B?RDMrYzc1MnF6eFRoZVg3WUMraGhvWVc1ZXh5aEhObzBwWFNYcHlQM25IeGhq?=
 =?utf-8?B?NXdSUFdQV0diY2RIOHkzRE1kN1c4aUJraEVoYnpTZ3RJTFBOSW9rakNYMUdX?=
 =?utf-8?B?am1VUjBSQldZOTZBOE5oVWlmRUhxV3NGTWpsSUdTeFVoNG5hUmYvZmtnQ1pU?=
 =?utf-8?B?WEF1SkZ3Nkh2NVh4MXBEMkM2NkNnZkxFYktxUXdQZ2dqVHZjeHZ6d2N1MFU4?=
 =?utf-8?B?eFNYY2xUbWxoeEtyV3BRSi84eUJlZXNveWRmWlllN2RueGoxU2s0dk9jVzFF?=
 =?utf-8?B?bDJRWmVsNktvZEU0UVlIb1Y2RlY1L2l2N2V4NElJbExUL0NSbjk1bzM3azd6?=
 =?utf-8?B?T2pmd210cnFsZ3pZNWxHZ2tzWGRONVR0ZEhHTjhzMGFKcGZ4VUNMZ0M1SFFN?=
 =?utf-8?B?WklobEVLQjNubEhKNDlZdEQzQ2d4Qkxoc0NzNmlkR3F5eEdjTjJoMnZwL04y?=
 =?utf-8?B?MjNOWmJQbWxWeTgvNWJ1SE9yWFZpUDVWY2VuTzBxbjZydUxFTWtBUFFqOHhy?=
 =?utf-8?B?NWlFaWIxKzhWL2trcWhyOWdHaFdJVlpVS2pNY2JrOEh3YVJRNkVudDU0TzJX?=
 =?utf-8?B?WXBjTmFESFgyeS9iY2NJeXdxMDRLYjJwbVV0OXkwUjNUbCtvRENabmVRODNW?=
 =?utf-8?B?WkxOSlFvNmFVVjQ3TFp0dEZOV1Urck1YaHBMV1loWGFYUVJWTXlyQWhrZ1Fy?=
 =?utf-8?B?V0NWRmxsRGE4eFNMQ25YYWlmbEN5WlgxWDRtMGs2TGJmK2JZMm5tYTZZM1dk?=
 =?utf-8?B?NnJPWFByWkRYMml3YnVTVW5PNFJid3BkYkltRzVvSUFaRC9idFYrZUZWRUQz?=
 =?utf-8?B?RzdCbTRwYThYOEExanFxQzh5TG5Rd3VmMGVTcTVwTThodHcrQ0k2YjljRllS?=
 =?utf-8?B?SzN6bTRLaHlRK0kyODBsK2pGZThudVVPcmZGb2UrQVYxSC9ZVXJKNU1kbFQ1?=
 =?utf-8?B?dmQ2enlRcytJOVBZNG9sTXMyWUN0ZlVtR1A0RENjWTl2ZURBNFR2a0laS1Rh?=
 =?utf-8?B?bENyWlBkZ2piOTdoaVFlZEdtMHRrdkZUeFlSMFdER3pxRU0vdENwMWZ5WXFX?=
 =?utf-8?B?QmkybEQwT1dCRHhETFdNVVhIMkhQVmNHSjNtU0dHQnhlakVPMDZXSEtZdmZx?=
 =?utf-8?B?SG9semNkRW9wbTFwSmx5UVJ0YnY5MDQ2NTErR1g0ZDlXcjY5N1NSNzVkeDFt?=
 =?utf-8?B?VmV1SXIrcC84eDM2SzhKOFNuazRnMUlNL2VtM3RPbnZXOHVZS1JLSjhHQkNq?=
 =?utf-8?B?YW5PRWZCdFczZ21sdVRpeHo3dG5nM1ZORUlUanJReG55dFZKVS9tSXdYVyt3?=
 =?utf-8?B?ZStrc0k1TTQ0anJoQkY4SWdONUlOdUZFRTlCTTNLY2UyUGxVVTlDanVseklF?=
 =?utf-8?B?OWpIaU1kRHZKTGpGaXRvSXY4OU1heWFKeHIzamN6dFpsRW5ieUhtNVFwRjE3?=
 =?utf-8?B?WXJHeVJ5RnJ6WGJIT0lqZm9VandBWitUTHJsQ0dzejNEZmZ0cjV2N2dSTito?=
 =?utf-8?B?dFZibXF4T3IyTThuRVlOSEVaNnpsUTdibnN2UVJEbHZEYzRMQXdDM3lKYTJv?=
 =?utf-8?B?VFBaZnRWYm9kbU9ENm1lZ28xVkt0L2JRcVJ2ODJYYUY2TGM0TGR3UC9RRjZk?=
 =?utf-8?B?RzVyTDFnYmJ1NkJlLzZSQ3Ryb0pRPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:28.9775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54593bf7-dcf8-4e07-badc-08de59168b21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

Subsequent patch will upgrade IORT revision to 5 to add support
for IORT RMR nodes.

Add the affected IORT blobs to allowed-diff list for bios-table
tests.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3279638ad0 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


